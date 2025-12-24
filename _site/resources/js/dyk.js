document.addEventListener('DOMContentLoaded', function() {
    const containerIds = ['facts-container', 'facts-container-m'];
    const allFactContainers = [];

    containerIds.forEach(id => {
        const container = document.getElementById(id);
        if (container) {
            allFactContainers.push(container);
        }
    });

    // If no containers are found, there's nothing to do, so exit the script.
    if (allFactContainers.length === 0) {
        console.warn("No 'Did You Know?' fact containers found on the page (looked for: " + containerIds.join(', ') + ")");
        return; // Exit script if no target elements are found
    }

    const factsURL = 'resources/json/dykdat.json';
    let allFacts = [];
    const numberOfFactsToDisplay = 10;

    // Fisher-Yates (Knuth) Shuffle algorithm
    function shuffleArray(array) {
        let currentIndex = array.length, randomIndex;

        // While there remain elements to shuffle.
        while (currentIndex !== 0) {
            // Pick a remaining element.
            randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex--;

            // And swap it with the current element.
            [array[currentIndex], array[randomIndex]] = [
                array[randomIndex], array[currentIndex]
            ];
        }
        return array;
    }

    // Function to display a given set of facts in a specific target container
    function populateContainerWithFacts(targetContainer, factsToRender) {
        if (!targetContainer) return; // Safety check

        if (factsToRender.length === 0) {
            targetContainer.textContent = "...that no facts™ are available?";
            return;
        }

        // Clear previous facts
        targetContainer.innerHTML = '';

        // Display the chosen number of facts
        factsToRender.forEach(fact => {
            const factParagraph = document.createElement('p');
            // Use innerHTML to render HTML tags (like <a>)
            factParagraph.innerHTML = fact;
            targetContainer.appendChild(factParagraph);
        });
    }

    // Fetch the facts and display them in all detected containers
    fetch(factsURL)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status} for ${factsURL}`);
            }
            return response.json();
        })
        .then(data => {
            if (Array.isArray(data) && data.length > 0) {
                allFacts = data;

                // Generate ONE set of shuffled facts to display for all containers.
                // This ensures consistency if multiple containers are on the same page.
                const actualFactsToDisplay = Math.min(numberOfFactsToDisplay, allFacts.length);
                const factsForThisPageLoad = shuffleArray([...allFacts]).slice(0, actualFactsToDisplay);

                // Populate each found container with this set of facts
                allFactContainers.forEach(container => {
                    populateContainerWithFacts(container, factsForThisPageLoad);
                });

            } else {
                console.warn("Facts data is empty or not an array:", data);
                // Display 'No facts available' message in all containers
                allFactContainers.forEach(container => {
                    container.textContent = "that your daily facts™ are unavailable?";
                });
            }
        })
        .catch(error => {
            console.error("Error fetching facts:", error);
            // Display error message in all containers
            allFactContainers.forEach(container => {
                container.textContent = "...that your daily facts™ are currently unavailable due to a source code error?";
            });
        });
});