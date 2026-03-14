/* the light mode mechanic */
document.addEventListener('DOMContentLoaded', () => {
const htmlElement = document.documentElement;
const storageKey = 'themePreference';
const lightModeClass = 'light-mode';

function loadTheme() {
    const savedTheme = localStorage.getItem(storageKey);
        
    if (savedTheme === 'light') {
        htmlElement.classList.add(lightModeClass);
  } else {
      htmlElement.classList.remove(lightModeClass);
   }
}

loadTheme();
});