// Media Viewer for KuroWiki (resources/js/mediaviewer.js)
// Copyright Axeon Network/Nekori, 2025
document.addEventListener('DOMContentLoaded', () => {
    // hader elements for hiding
    const header = document.querySelector('.mdl-layout__header');
    const drawerBtn = document.querySelector('.mdl-layout__drawer-button');

    const viewer = document.getElementById('media-viewer');
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

    // func to open viewer and hide MDL elements
    const openViewer = (index) => {
        updateViewer(index);
        viewer.classList.remove('viewer-hidden');
        
        // Hide the Navbar/Header elements
        if (header) header.classList.add('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.add('mdl-hidden');
    };

    // func to hide viewer and show MDL elements
    const hideViewer = () => {
        viewer.classList.add('viewer-hidden');
        currentIndex = -1; // reset index when closed

        // Show the Navbar/Header elements
        if (header) header.classList.remove('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.remove('mdl-hidden');
    };
    galleryImages = document.querySelectorAll('figure img'); 
    // cttach click listeners to all gallery images
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
        // go to next image, wrapping around to start if needed
        const nextIndex = (currentIndex + 1) % galleryImages.length;
        updateViewer(nextIndex);
    });

    prevBtn.addEventListener('click', () => {
        // go to previous image, wrapping around to end if needed
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
        if (!viewer.classList.contains('viewer-hidden')) {
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