// Axeon KuroWiki Release Candidate
// Debug Keybinds JavaScript File

// Copyright 2026 Axeon Network
// Written by: StupidBiFox on 2026-05-09 8:52 pm

// What is this? This is a small script to enable debug keybinds to Deltari,
// they do various dev stuff that can make debugging the thing easier.
// What is the master parent keys? Control and Alt!

document.addEventListener('keydown', (e) => {
    // check for both control and alt
    if (e.ctrlKey && e.altKey) {
        
        // now, caps lock might be enabled, so 
        // we convert it to lowercase, just in *case* ;3
        const key = e.key.toLowerCase();

        switch (key) {
            // ctrl+alt+t = changes the theme of the site 
            case 't':
                e.preventDefault(); // stop default browser actions
                const htmlElement = document.documentElement;
                
                // toggle the class and store the result (true if light-mode is now on)
                const isLightMode = htmlElement.classList.toggle('light-mode');
                // then sync it with themePreference
                localStorage.setItem('themePreference', isLightMode ? 'light' : 'dark');
                
                // now here's a fun thing; if we are already on the settings page,
                // just toggle the switch!
                const darkModeToggle = document.getElementById('darkModeToggle');
                if (darkModeToggle) {
                    darkModeToggle.checked = isLightMode;
                    darkModeToggle.parentElement.classList.toggle('is-checked', isLightMode);
                }
                console.log(`${isLightMode ? 'Light' : 'Dark'} Mode enabled.`);
                break;

            // ctrl+alt+w = hides or shows the build watermarks
            // this is useful with stuff like springviewer 
            case 'w':
                e.preventDefault();
                const watermark = document.getElementById('watermark');
                const viewerWatermark = document.getElementById('viewer-watermark');
                if (watermark) {
                    // swap between hidden and its default display
                    if (watermark.style.display === 'none' && viewerWatermark.style.display === 'none') {
                        watermark.style.display = '';
                        viewerWatermark.style.display = 'block';
                    } else {
                        watermark.style.display = 'none';
                        viewerWatermark.style.display = 'none';
                    }
                    console.log('Build watermark visibility has changed.');
                }
                break;

            // ctrl+alt+d = summons the drawer 
            case 'd':
                e.preventDefault();
                // mdl automatically injects a div with this class for the button
                const drawerButton = document.querySelector('.mdl-layout__drawer-button');
                if (drawerButton) {
                    drawerButton.click();
                    console.log('Drawer has been summoned. Is it friendly?');
                }
                break;

            // ctrl+alt+p = jumps to the test page 
            case 'p':
                e.preventDefault();
                console.log('Jumping to Test Page...');
                window.location.href = './Deltari:Test_Page';
                break;

            // ctrl+alt+h = jumps to the homepage 
            case 'h':
                e.preventDefault();
                console.log('Jumping to Home...');
                window.location.href = './'; 
                break;

            // ctrl+alt+s = jumps to sitemap 
            case 's':
                e.preventDefault();
                console.log('Jumping to Sitemap...');
                window.location.href = 'Sitemap';
                break;
        }
    }
});