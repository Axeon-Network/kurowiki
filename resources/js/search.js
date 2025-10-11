document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('search-input');
    const resultsContainer = document.getElementById('results-container');
    const searchDataURL = './resources/json/search.json'; 
    let searchIndex = [];

    // fetch search index data
    fetch(searchDataURL)
        .then(response => response.json())
        .then(data => {
            searchIndex = data;
        })
        .catch(error => {
            console.error("Error loading search index:", error);
            resultsContainer.innerHTML = '<p style="color: red;">Search is currently unavailable. Could not load the index file.</p>';
        });

    // event listener for user input (runs search on every key press)
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const query = this.value;
            displayResults(search(query));
        });
    }


    function search(query) {
        if (!query || !searchIndex) {
            return [];
        }

        const lowerCaseQuery = query.toLowerCase().trim();
        
        return searchIndex.filter(item => {
            // ensure title is string and convert both title and aliases to lower case for comparison
            const title = item.title ? item.title.toLowerCase() : '';
            // aliases are generated as a single lowercase string in plugin
            const aliases = item.aliases || ''; 
            
            // match if query is in title OR in aliases string
            const titleMatch = title.includes(lowerCaseQuery);
            const aliasMatch = aliases.includes(lowerCaseQuery);
            
            return titleMatch || aliasMatch;
        });
    }

    // when the results are display(ed)
    function displayResults(results) {
        resultsContainer.innerHTML = '';
        const baseURL = window.location.origin;

        if (results.length === 0) {
            resultsContainer.innerHTML = '<p style="padding: 20px; font-style: italic;">No results found for your query.</p>';
            return;
        }

        results.forEach(item => {
            // idk what this is
            const resultBox = document.createElement('div');
            resultBox.style.padding = '15px';
            resultBox.style.border = '1px solid #ddd';
            resultBox.style.marginBottom = '15px';
            resultBox.style.borderRadius = '5px';
            
            // when the title is also a link be like
            const titleLink = document.createElement('a');
            titleLink.href = '/' + item.url; 
            titleLink.textContent = item.title;
            titleLink.style.fontSize = '1.2em';
            titleLink.style.fontWeight = 'bold';
            titleLink.style.display = 'block'; 
            
            // its the url
            const urlP = document.createElement('p');
            urlP.textContent = baseURL + '/' + item.url;
            urlP.style.fontSize = '0.9em';
            urlP.style.color = '#006400'; 
            urlP.style.marginBottom = '5px';
            
            // snipped
            const descriptionP = document.createElement('p');
            
            // a
            descriptionP.innerHTML = item.snippet; 

            descriptionP.style.marginTop = '0';
            descriptionP.style.marginBottom = '0';
            
            // box items, assemble!
            resultBox.appendChild(titleLink);
            resultBox.appendChild(urlP);
            resultBox.appendChild(descriptionP);
            
            resultsContainer.appendChild(resultBox);
        });
    }
});