/* the light mode mechanic */
document.addEventListener('DOMContentLoaded', () => {
    const htmlElement = document.documentElement;
    const storageKey = 'currentTheme';
    const lightModeClass = 'light-mode';
    const hljs = document.getElementById('hlJS_color');
    const toggleElement = document.getElementById('qtzThemeToggle');

    // Make theme application a reusable function globally accessible
    window.applyTheme = function(isLight) {
        if (isLight) {
            htmlElement.classList.add(lightModeClass);
            localStorage.setItem(storageKey, 'light');
            if (hljs) hljs.href = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/github.css';
        } else {
            htmlElement.classList.remove(lightModeClass);
            localStorage.setItem(storageKey, 'dark');
            if (hljs) hljs.href = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/github-dark.css';
        }
    }

    function loadTheme() {
        const savedTheme = localStorage.getItem(storageKey);
        window.applyTheme(savedTheme === 'light');
    }

    if (toggleElement) {
        toggleElement.addEventListener('click', () => {
            const isLight = !htmlElement.classList.contains(lightModeClass);
            window.applyTheme(isLight);
        });
    }

    function verifyThemeSupport() {
        if (!toggleElement) return;
        const themeVariableRegex = /--[a-zA-Z0-9_-]*(light|dark)/i;
        let themeVariablesFound = false;

        for (let i = 0; i < document.styleSheets.length; i++) {
            try {
                const sheet = document.styleSheets[i];
                const rules = sheet.cssRules || sheet.rules;
                if (!rules) continue;

                for (let j = 0; j < rules.length; j++) {
                    if (themeVariableRegex.test(rules[j].cssText)) {
                        themeVariablesFound = true;
                        break;
                    }
                }
            } catch (error) {
                console.warn("Skipped cross-origin stylesheet analysis:", error.message);
            }
            if (themeVariablesFound) break;
        }

        if (!themeVariablesFound) {
            toggleElement.disabled = true; 
            toggleElement.setAttribute('disabled', 'true'); 
            toggleElement.title = "Your layout cannot change theme modes.";
        }
    }

    loadTheme();
    verifyThemeSupport();
});