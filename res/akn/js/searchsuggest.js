document.addEventListener('DOMContentLoaded', () => {
    const searchSetups = [
        document.getElementById('akn-searchbox'),
        document.getElementById('akn-searchbox-mobile')
    ].filter(Boolean).map(input => {
        const container = input.parentNode.querySelector('.akn-searchsuggestions');
        return { 
            input, 
            container, 
            list: container?.querySelector('.akn-searchsuggestions-list'),
            fallback: container?.querySelector('.akn-searchsuggestions-seafor'),
            fallbackQuery: container?.querySelector('.query')
        };
    });

    if (searchSetups.length === 0) return;

    let globalSearchIndex = [];
    
    fetch('./res/index.json')
        .then(response => response.json())
        .then(data => { globalSearchIndex = data; })
        .catch(err => console.error("Cannot load search index. Search suggestions will fail to load.\n", err));

    searchSetups.forEach(({ input, container, list, fallback, fallbackQuery }) => {
        if (!container) return;

        input.addEventListener('input', function() {
            const query = this.value.trim().toLowerCase();
            list.innerHTML = '';

            if (!query || !globalSearchIndex.length) {
                container.classList.remove('is-visible');
                fallback.style.display = 'none';
                return;
            }

            const matches = globalSearchIndex.filter(item => 
                item.title && item.title.toLowerCase().includes(query)
            ).slice(0, 8);

            matches.forEach(match => {
                const a = document.createElement('a');
                a.href = match.url;
                a.className = 'akn-searchsuggestions-item';
                a.textContent = match.title;
                if (match.isTitleItalic) a.style.fontStyle = 'italic';
                list.appendChild(a);
            });

            fallbackQuery.textContent = this.value;
            fallback.style.display = 'block';
            container.classList.add('is-visible');
        });

        fallback.addEventListener('click', () => {
            input.closest('form').submit();
        });

        document.addEventListener('click', (e) => {
            if (!input.contains(e.target) && !container.contains(e.target)) {
                container.classList.remove('is-visible');
            }
        });
        
        input.addEventListener('focus', () => {
            if (input.value.trim() && (list.children.length > 0 || fallback.style.display === 'block')) {
                container.classList.add('is-visible');
            }
        });
    });
});