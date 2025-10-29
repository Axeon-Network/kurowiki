// SpringViewer Version 2.5
// A multi-media viewer for use with Deltari
// Copyright Axeon Network/Nekori, 2025. Licensed under MIT
document.addEventListener('DOMContentLoaded', () => {
    const header = document.querySelector('.mdl-layout__header');
    const drawer = document.querySelector('.mdl-layout__drawer'); 
    const mainBody = document.body; 

    const viewer = document.getElementById('springviewer');
    const viewerCaption = document.getElementById('viewer-caption');
    const closeBtn = document.querySelector('.close-btn');
    const prevBtn = document.querySelector('.nav-btn.prev-btn');
    const nextBtn = document.querySelector('.nav-btn.next-btn');

    const viewerMediaContainer = document.getElementById('viewer-media-container');

    const dlButton = document.querySelector('.dl-btn'); 
    const flscrButton = document.querySelector('.flscr-btn');
    const viewerCounter = document.querySelector('.viewer-counter');
    
    // this excludes the viewer container itself from being counted in the image counter.
    const excludedID = 'viewer-media-element';

    let galleryMedia = []; 
    let currentIndex = -1; 
    let totalMediaCount = 0;

    // fix for drawer button
    let drawerBtn;

    // the button gets created by mdl, but the script doesnt recognize it, so we use a timeout instead
    setTimeout(() => {
        // select the button after mdl has finished making the layout
        drawerBtn = document.querySelector('.mdl-layout__drawer-button');

        if (drawerBtn) {
            // the default MDL handler might be lost when we add/remove classes, so we ensure the button still opens the drawer via a manual listener.
            drawerBtn.addEventListener('click', () => {
                if (drawer) {
                    drawer.classList.toggle('is-visible');
                }
            });
        }
    }, 100); // 100ms should be enough delay for mdl to initialize.


    // download the current media (only works well for images)
    const downloadMedia = () => {
        const activeMediaElement = document.getElementById(excludedID);
        
        if (currentIndex !== -1 && activeMediaElement && activeMediaElement.tagName === 'IMG') {
            const currentSrc = activeMediaElement.src;
            const link = document.createElement('a');
            link.href = currentSrc;
            
            const filename = currentSrc.substring(currentSrc.lastIndexOf('/') + 1) || 'download.jpg';
            link.download = filename; 

            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    };
    
    // full screen
    const toggleFullscreen = () => {
        if (document.fullscreenElement) {
            document.exitFullscreen();
        } else {
            viewer.requestFullscreen().catch(err => {
                console.error(`Error attempting to enable full-screen mode: ${err.message}`);
            });
        }
    };
    
    // update viewer content + state
    const updateViewer = (index) => {
    if (index >= 0 && index < galleryMedia.length) {
            const mediaSourceElement = galleryMedia[index]; 
            currentIndex = index;
        
            viewerMediaContainer.innerHTML = '';
        
            let newMediaElement;
            let isVideoOrAudio = false;

            if (!mediaSourceElement) return;
        
            // determine media type and create new element
            const tagName = mediaSourceElement.tagName;
        
            if (tagName === 'IMG') {
                newMediaElement = document.createElement('img');
                newMediaElement.src = mediaSourceElement.src;
                newMediaElement.alt = mediaSourceElement.alt || mediaSourceElement.title || '';
                newMediaElement.id = excludedID;
            } 
            else if (tagName === 'VIDEO' || tagName === 'AUDIO') {
                isVideoOrAudio = true;
            
                newMediaElement = document.createElement(tagName.toLowerCase());
                newMediaElement.id = excludedID;
                newMediaElement.controls = true;
                newMediaElement.autoplay = true;


                // check for the src attribute
                if (mediaSourceElement.src) {
                    newMediaElement.src = mediaSourceElement.src;
                } 
            
                // check for nested source tags
                Array.from(mediaSourceElement.querySelectorAll('source')).forEach(source => {
                    // clone the source tag and append it to the new media element
                     newMediaElement.appendChild(source.cloneNode(true)); // use true for deep clone
                });
            
            } 
        
            if (newMediaElement) {
                viewerMediaContainer.appendChild(newMediaElement);
                let captionText = '';
                const parentFigure = mediaSourceElement.closest('figure');
                if (parentFigure) {
                    const captionElement = parentFigure.querySelector('figcaption');
                    captionText = captionElement ? captionElement.innerHTML : '';
                }
                if (!captionText) {
                     captionText = mediaSourceElement.alt || mediaSourceElement.title || '';
                }

                viewerCaption.innerHTML = captionText;
            }

            viewerCounter.textContent = `${currentIndex + 1}/${totalMediaCount}`;
        
            if (dlButton) dlButton.style.display = isVideoOrAudio ? 'none' : 'block';
        }
    };
    
    // open viewer and hide mdl elements + scrollbar
    const openViewer = (index) => {
        updateViewer(index);
        viewer.classList.remove('viewer-hidde');
        
        if (viewerCounter) viewerCounter.style.display = 'block';

        // use drawerbtn which is set after the timeout 
        if (header) header.classList.add('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.add('mdl-hidden'); 
        if (drawer) drawer.classList.add('mdl-hidden'); 
        
        mainBody.classList.add('hide-scrollbar');
    };

    // hide viewer and show mdl elements + scrollbar
    const hideViewer = () => {
        viewer.classList.add('viewer-hidde'); 
        currentIndex = -1; 
        
        if (viewerCounter) viewerCounter.style.display = 'none';
        
        const activeMedia = document.getElementById(excludedID);
        if (activeMedia && (activeMedia.tagName === 'VIDEO' || activeMedia.tagName === 'AUDIO')) {
             activeMedia.pause();
        }

        // ditto (from hideViewer)
        if (header) header.classList.remove('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.remove('mdl-hidden');
        if (drawer) drawer.classList.remove('mdl-hidden');
        
        mainBody.classList.remove('hide-scrollbar');
    };
    
    // filter elements and collect them all, to make this universal
    // you dont need to use a gallery or figure item anymore, as springviewer will still catch it
    // it is recommended to use those items for a proper display
    // infoboxes also work fine with springviewer from nnow on
    const allMediaElements = document.querySelectorAll('img, video, audio'); 
    
    galleryMedia = Array.from(allMediaElements).filter(element => {
        return element.id !== excludedID && (element.src || element.querySelector('source'));
    });
    
    totalMediaCount = galleryMedia.length;
    
    // attach click listeners to all included media elements
    galleryMedia.forEach((mediaElement, index) => {
        mediaElement.style.cursor = 'pointer'; 
        
        mediaElement.addEventListener('click', (event) => {
             event.preventDefault(); 
             openViewer(index);
        });
    });

    // navigation controls now use the filtered galleryMedia array
    nextBtn.addEventListener('click', () => {
        const nextIndex = (currentIndex + 1) % galleryMedia.length;
        updateViewer(nextIndex);
    });

    prevBtn.addEventListener('click', () => {
        const prevIndex = (currentIndex - 1 + galleryMedia.length) % galleryMedia.length;
        updateViewer(prevIndex);
    });

    if (dlButton) dlButton.addEventListener('click', downloadMedia);
    if (flscrButton) flscrButton.addEventListener('click', toggleFullscreen);
    
    closeBtn.addEventListener('click', hideViewer);
    
    // click on backdrop (the black area)
    viewer.addEventListener('click', (event) => {
        if (event.target === viewer) {
            hideViewer();
        }
    });

    // keyboard controls
    document.addEventListener('keydown', (event) => {
        if (!viewer.classList.contains('viewer-hidde')) {
            if (event.key === 'Escape') {
                hideViewer();
            } else if (event.key === 'ArrowRight') {
                nextBtn.click();
            } else if (event.key === 'ArrowLeft') {
                prevBtn.click();
            }
            else if (event.key === 'd' || event.key === 'D') {
                event.preventDefault();
                downloadMedia();
            }
            else if (event.key === 'f' || event.key === 'F') {
                event.preventDefault();
                toggleFullscreen();
            }
        }
    });
});