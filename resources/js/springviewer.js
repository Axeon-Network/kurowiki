// SpringViewer for KuroWiki (resources/js/mediaviewer.js)
// Copyright Axeon Network/Nekori, 2025
document.addEventListener('DOMContentLoaded', () => {
    const header = document.querySelector('.mdl-layout__header');
    const drawerBtn = document.querySelector('.mdl-layout__drawer-button');
    const drawer = document.querySelector('.mdl-layout__drawer', '.mdl-layout__drawer-button'); 
    const mainBody = document.body; 

    const viewer = document.getElementById('springviewer'); // this mf made me explode
    const viewerMedia = document.getElementById('viewer-media');
    const viewerCaption = document.getElementById('viewer-caption');
    const closeBtn = document.querySelector('.close-btn');
    const prevBtn = document.querySelector('.nav-btn.prev-btn');
    const nextBtn = document.querySelector('.nav-btn.next-btn');

    let galleryImages = []; 
    let currentIndex = -1; 

    // update viewer content + state
    const updateViewer = (index) => {
        if (index >= 0 && index < galleryImages.length) {
            const image = galleryImages[index];
            currentIndex = index;
            
            // set full source and alt text
            viewerMedia.src = image.src; 
            viewerMedia.alt = image.alt;
            
            // get caption from <figcaption> element
            const captionElement = image.parentNode.querySelector('figcaption');
            viewerCaption.innerHTML = captionElement ? captionElement.innerHTML : image.alt;
        }
    };

    // func to open viewer and hide MDL elements + scrollbar
    const openViewer = (index) => {
        updateViewer(index);
        viewer.classList.remove('viewer-hidde');
        
        // hide navbar, button and drawer
        if (header) header.classList.add('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.add('mdl-hidden');
        // the drawer needs to be hidden explicitly cuz mdl opens it via classes
        if (drawer) drawer.classList.add('mdl-hidden'); 
        
        // hide scrollbar so it doesnt look weird
        mainBody.classList.add('hide-scrollbar');
    };

    // func to hide viewer and show MDL elements + scrollbar
    const hideViewer = () => {
        viewer.classList.add('viewer-hidde'); // THIS STUPID MOTHERFUC-
        currentIndex = -1; // reset index when closed

        // reshow header ux
        if (header) header.classList.remove('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.remove('mdl-hidden');
        if (drawer) drawer.classList.remove('mdl-hidden');
        
        // reshow scrollbar so we can go up and down
        mainBody.classList.remove('hide-scrollbar');
    };
    
    // collect all, i mean ALL..img tags that are children of a figure tag for gods sake
    galleryImages = document.querySelectorAll('figure img'); 
    
    // attach click listeners to all gallery images
    galleryImages.forEach((image, index) => {
        // make sure all gallery images are clickable
        image.style.cursor = 'pointer'; 
        
        image.addEventListener('click', () => {
            // open the viewer at index of clicked image
            openViewer(index);
        });
    });

    // navigation controls
    nextBtn.addEventListener('click', () => {
        const nextIndex = (currentIndex + 1) % galleryImages.length;
        updateViewer(nextIndex);
    });

    prevBtn.addEventListener('click', () => {
        const prevIndex = (currentIndex - 1 + galleryImages.length) % galleryImages.length;
        updateViewer(prevIndex);
    });

    // closing and keyboard mechanisms
    closeBtn.addEventListener('click', hideViewer);
    
    // click on backdrop (the black area)
    viewer.addEventListener('click', (event) => {
        if (event.target === viewer) {
            hideViewer();
        }
    });

    // keyboard controls
    document.addEventListener('keydown', (event) => {
        if (!viewer.classList.contains('viewer-hidde')) { // YOU.
            if (event.key === 'Escape') {
                hideViewer();
            } else if (event.key === 'ArrowRight') {
                nextBtn.click();
            } else if (event.key === 'ArrowLeft') {
                prevBtn.click();
            }
        }
    });
});