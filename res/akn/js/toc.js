document.addEventListener("DOMContentLoaded", function() {
    const hideLink = document.getElementById("hidetoc");
    const tocBox = document.querySelector(".table-of-contents");

    if (hideLink && tocBox) {
    hideLink.textContent = "hide";

    hideLink.addEventListener("click", function(e) {
        e.preventDefault();
        const isHidden = window.getComputedStyle(tocBox).display === "none";

        if (isHidden) {
            tocBox.style.display = "block";
            hideLink.textContent = "hide";
        } else {
            tocBox.style.display = "none";
            hideLink.textContent = "show";
        }
      });
    }

    (function() {
        const toc = document.getElementById("toc-list");
        const content = document.getElementById("pagecontent");
        if (!toc || !content) return;

        const headings = content.querySelectorAll("#pagecontent > h1, #pagecontent > h2, #pagecontent > h3, #pagecontent > h4, #pagecontent > h5, #pagecontent > h6");
        // we use #pagecontent > hX to prevent infobox headers showing up in the list 
        const counters = [0, 0, 0, 0, 0, 0];
        
        // This keeps track of our <ul> elements at each level
        let levels = [toc]; 

        headings.forEach((h, index) => {
            const level = parseInt(h.tagName.substring(1));
            
            // 1. Reset counters for deeper levels
            for (let i = level; i < counters.length; i++) counters[i] = 0;
            counters[level - 1]++;

            // 2. Generate the BetaWiki number (e.g., 1.1)
            const numberStr = counters.slice(0, level).filter(n => n > 0).join('.');

            // 3. Create the list item
            const li = document.createElement("li");
            const a = document.createElement("a");
            a.href = "#" + (h.id || `section-${index}`);
            
            const nSpan = document.createElement("span");
            nSpan.className = "tocnumber";
            nSpan.textContent = numberStr;
            
            const tSpan = document.createElement("span");
            tSpan.className = "toctext";
            tSpan.textContent = h.textContent;

            a.appendChild(nSpan);
            a.appendChild(tSpan);
            li.appendChild(a);

            // 4. Correct Nesting Logic
            // If the current header is shallower than our last one, prune the levels array
            while (levels.length > level) {
                levels.pop();
            }

            // If we need a deeper level than we have, create a new <ul>
            if (levels.length < level) {
                const parentLi = levels[levels.length - 1].lastElementChild;
                if (parentLi) {
                    const newUl = document.createElement("ul");
                    parentLi.appendChild(newUl);
                    levels.push(newUl);
                } else {
                    // Fallback if someone skips a header level (e.g. H1 to H3)
                    levels.push(levels[levels.length - 1]);
                }
            }

            levels[levels.length - 1].appendChild(li);
        });
    })();
});