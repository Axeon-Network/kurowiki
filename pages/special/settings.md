---
layout: main
title: Settings
permalink: Settings
search_exclude: true
---

SETTINGS PAGEEEE

<header>
    <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="darkModeToggle">
        <input type="checkbox" id="darkModeToggle" class="mdl-switch__input">
        <span class="mdl-switch__label">Light Mode</span>
    </label>
</header>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const toggleInput = document.getElementById('darkModeToggle');
    const toggleLabel = toggleInput.parentElement; 
    const htmlElement = document.documentElement;

    const storageKey = 'themePreference';
    const lightModeClass = 'light-mode';

    function saveTheme(isLight) {
        if (isLight) {
            localStorage.setItem(storageKey, 'light');
        } else {
            localStorage.setItem(storageKey, 'dark');
        }
        
        if (isLight) {
            htmlElement.classList.add(lightModeClass);
        } else {
            htmlElement.classList.remove(lightModeClass);
        }
    }

    function syncToggleState() {
        const savedTheme = localStorage.getItem(storageKey);
        const isLight = savedTheme === 'light';
        
        toggleInput.checked = isLight;

        if (window.componentHandler) {
            if (isLight) {
                toggleLabel.classList.add('is-checked');
            } else {
                toggleLabel.classList.remove('is-checked');
            }
            window.componentHandler.upgradeElement(toggleLabel);
        }
    }


    toggleInput.addEventListener('change', (event) => {
        saveTheme(event.target.checked);
    });

    syncToggleState();
});
</script>