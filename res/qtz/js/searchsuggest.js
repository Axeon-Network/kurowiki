document.addEventListener('DOMContentLoaded', () => {
    const searchSetups = [
        document.getElementById('qtz-searchbox'),
        document.getElementById('qtz-searchbox-mobile')
    ].filter(Boolean).map(input => {
        const container = input.parentNode.querySelector('.qtz-krypton');
        return { 
            input, 
            container, 
            list: container?.querySelector('.qtz-krypton-list'),
            fallback: container?.querySelector('.qtz-krypton-seafor'),
            fallbackQuery: container?.querySelector('.query')
        };
    });

    if (searchSetups.length === 0) return;

    let globalSearchIndex = [];
    
    fetch(`${window.baseUrl}/res/qtz/articleindex.json`)
        .then(response => response.json())
        .then(data => { globalSearchIndex = data; })
        .catch(err => console.error("[Krypton] Cannot load search index. Search suggestions will fail to load.\n", err));

    searchSetups.forEach(({ input, container, list, fallback, fallbackQuery }) => {
        if (!container) return;
        let selectedIndex = -1;

        function getAllNavigableElements() {
            const items = Array.from(list.querySelectorAll('.qtz-krypton-item'));
            if (fallback.style.display !== 'none') {
                items.push(fallback);
            }
            return items;
        }

        function updateHighlight(elements) {
            elements.forEach((el, idx) => {
                if (idx === selectedIndex) {
                    el.style.backgroundColor = 'var(--search-hover)';
                    el.style.color = 'white';
                } else {
                    el.style.backgroundColor = '';
                    el.style.color = '';
                }
            });
        }

        input.addEventListener('input', function() {
            const query = this.value.trim().toLowerCase();
            list.innerHTML = '';
            selectedIndex = -1;

            if (!query || !globalSearchIndex.length) {
                container.classList.remove('is-visible');
                fallback.style.display = 'none';
                return;
            }

            // now, we add a way for it to search within words instead of match-casing the title,
            // so for example, "KuroWiki 4466 kitsixtyfour" can return
            // "KuroWiki build 4466 (kitsixtyfour.251227-1311)" for example

            // this is a port from search.html

            // history has its eyes on you! / he will never be satisfied
            // what would be enough / why do you assume you're the smartest in the room?

            // why do you fight like history has its eyes on you?
            const queryWords = query.split(/\s+/);
            const matchedItems = [];

            globalSearchIndex.forEach(item => {
                try {
                    const title = (item.title || '').toLowerCase();
                    const titleAcronym = title.match(/\b(\w)/g)?.join('') || '';
                    const redirects = (item.redirect_from ? (Array.isArray(item.redirect_from) ? item.redirect_from : [item.redirect_from]) : []
                        ).map(url => url.toLowerCase().replace(/^\/|\/$/g, ''));

                    // extract only the first sentence text for searching to avoid false positives
                    const rawSnippetText = (item.snippet || '').replace(/<[^>]*>/g, '');
                    let firstSentence = rawSnippetText;

                    for (let i = 0; i < rawSnippetText.length; i++) {
                        if (rawSnippetText[i] === '.') {
                            const isDecimal = (i > 0 && i < rawSnippetText.length - 1) &&
                                (rawSnippetText[i - 1] >= '0' && rawSnippetText[i - 1] <= '9') &&
                                (rawSnippetText[i + 1] >= '0' && rawSnippetText[i + 1] <= '9');
                            if (!isDecimal) {
                                firstSentence = rawSnippetText.substring(0, i + 1);
                                break;
                            }
                        }
                    }
                    const cleanSearchText = firstSentence.toLowerCase();

                    // check if the query matches a page title or redirect
                    // and if present, boot straight into page instead of search results
                    const isMatch = (queryWords.every(word => {
                        return title.includes(word) || cleanSearchText.includes(word) || titleAcronym.includes(word);
                    })) || redirects.some(redirect => queryWords.every(word => redirect.includes(word)));

                    // titles of actual pages take priority over redirects, as they should :p
                    if (isMatch) {
                        let score = 0;
                        if (queryWords.every(word => title.includes(word))) {
                            score = 3; 
                        } else if (queryWords.every(word => titleAcronym.includes(word))) {
                            score = 2;
                        } else if (redirects.some(redirect => queryWords.every(word => redirect.includes(word)))) {
                            score = 1;
                        }
                        matchedItems.push({ item: item, score: score });
                    }
                } catch (err) {
                    console.error("[Krypton] Cannot generate search results. Search suggestions will fail to load.\n", err);
                }
            });

            // actually display suggestions
            matchedItems.sort((a, b) => b.score - a.score);
            const matches = matchedItems.map(wrapper => wrapper.item).slice(0, 8);

            matches.forEach(match => {
                const a = document.createElement('a');
                a.href = match.url;
                a.className = 'qtz-krypton-item';
                a.textContent = match.title;
                if (match.isTitleItalic) a.style.fontStyle = 'italic';

                // clicking a suggestions boots you into the page
                a.addEventListener('click', (e) => {
                    e.preventDefault();
                    window.location.href = match.url;
                });
                list.appendChild(a);
            });

            fallbackQuery.textContent = this.value;
            fallback.style.display = 'block';
            container.classList.add('is-visible');
        });

        // keyboard nav
        input.addEventListener('keydown', function(e) {
            const navElements = getAllNavigableElements();
            if (!container.classList.contains('is-visible') || navElements.length === 0) return;

            if (e.key === 'ArrowDown') {
                e.preventDefault();
                selectedIndex = (selectedIndex + 1) % (navElements.length + 1);
                if (selectedIndex === navElements.length) selectedIndex = -1; // loops back to input box
                updateHighlight(navElements);
            } else if (e.key === 'ArrowUp') {
                e.preventDefault();
                selectedIndex = selectedIndex - 1;
                if (selectedIndex < -1) {
                    selectedIndex = navElements.length - 1; // loops to the bottom fallback option
                }
                updateHighlight(navElements);
            } else if (e.key === 'Enter') {
                if (selectedIndex >= 0 && selectedIndex < navElements.length) {
                    e.preventDefault();
                    const chosen = navElements[selectedIndex];
                    if (chosen === fallback) {
                        input.closest('form').submit();
                    } else {
                        window.location.href = chosen.href;
                    }
                } else {
                    // if no suggestion is highlighted, automatically select the top result if available
                    const firstItem = list.querySelector('.qtz-krypton-item');
                    if (firstItem) {
                        e.preventDefault();
                        window.location.href = firstItem.href;
                    } else {
                        // if nothing matches, submit the form to go to the search results page
                        e.preventDefault();
                        input.closest('form').submit();
                    }
                }
            }
        });
    });
});

// Hamilton at the Constitutional Convention!
// I was chosen for the Constitutional Convention!!! :D