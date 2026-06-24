/* the light mode mechanic */
document.addEventListener('DOMContentLoaded', () => {
    const htmlElement = document.documentElement;
    const storageKey = 'currentTheme';
    const lightModeClass = 'light-mode';

    function loadTheme() {
        const savedTheme = localStorage.getItem(storageKey);
        
        if (savedTheme === 'light') {
            htmlElement.classList.add(lightModeClass);
        } else {
            htmlElement.classList.remove(lightModeClass);
        }
    }

    function verifyThemeSupport() {
        const toggleElement = document.getElementById('themeToggle');
        // If the toggle element doesn't exist on this page, stop here
        if (!toggleElement) return;

        // Regex looks for CSS variables starting with '--' and containing 'light' or 'dark'
        const themeVariableRegex = /--[a-zA-Z0-9_-]*(light|dark)/i;
        let themeVariablesFound = false;

        // Loop through all stylesheets loaded in the document
        for (let i = 0; i < document.styleSheets.length; i++) {
            try {
                const sheet = document.styleSheets[i];
                const rules = sheet.cssRules || sheet.rules;
                if (!rules) continue;

                // Loop through every CSS rule inside the stylesheet
                for (let j = 0; j < rules.length; j++) {
                    if (themeVariableRegex.test(rules[j].cssText)) {
                        themeVariablesFound = true;
                        break; // Found one! Break out of the inner loop
                    }
                }
            } catch (error) {
                // Silently catch CORS errors from third-party CDNs (like Bootstrap or Google Fonts)
                console.warn("Skipped cross-origin stylesheet analysis:", error.message);
            }

            if (themeVariablesFound) break; // Break out of the outer loop
        }

        // If no variables were found, disable the button and add the tooltip title
        if (!themeVariablesFound) {
            toggleElement.disabled = true; 
            toggleElement.setAttribute('disabled', 'true'); 
            toggleElement.title = "Your layout can't change theme modes.";
        }
    }

    loadTheme();
    verifyThemeSupport();
});