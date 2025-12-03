---
layout: main
title: Settings
permalink: Settings
search_exclude: true
---

SETTINGS PAGEEEE

<!-- Settings Toggles -->
<header>
    <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="darkModeToggle">
        <input type="checkbox" id="darkModeToggle" class="mdl-switch__input">
        <span class="mdl-switch__label">Light Mode</span>
    </label>
</header>
<header>
    <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="onekoToggle">
        <input type="checkbox" id="onekoToggle" class="mdl-switch__input">
        <span class="mdl-switch__label">Cat friend :3</span>
    </label>
</header>

<!-- Scripts for the toggles -->
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

<script>
document.addEventListener('DOMContentLoaded', () => {
    const toggle = document.getElementById('onekoToggle');
    const label = toggle.parentElement;
    const storageKey = 'onekoEnabled';

    function applySetting(isEnabled) {
        localStorage.setItem(storageKey, isEnabled ? '1' : '0');

        if (window.componentHandler) {
            if (isEnabled) {
                label.classList.add('is-checked');
            } else {
                label.classList.remove('is-checked');
            }
            window.componentHandler.upgradeElement(label);
        }
    }

    function initToggleState() {
        const saved = localStorage.getItem(storageKey) === '1';
        toggle.checked = saved;

        if (window.componentHandler) {
            if (saved) {
                label.classList.add('is-checked');
            } else {
                label.classList.remove('is-checked');
            }
            window.componentHandler.upgradeElement(label);
        }
    }

    toggle.addEventListener('change', (e) => {
        applySetting(e.target.checked);
            window.location.reload();
    });

    initToggleState();
});
</script>