document.addEventListener('DOMContentLoaded', () => {
    const storageKey = 'onekoEnabled';
    const scriptId = 'onekoTag';
    const scriptSrc = './res/js/oneko.js';

    function loadScript() {
        if (document.getElementById(scriptId)) return;
        const el = document.createElement('script');
        el.id = scriptId;
        el.src = scriptSrc;
        el.defer = true;
        document.body.appendChild(el);
    }

    const enabled = localStorage.getItem(storageKey) === '1';
    if (enabled) {
        loadScript();
    }
});