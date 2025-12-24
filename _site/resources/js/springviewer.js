// Developed with love by Nekori64.
// SpringViewer Version 2.8.5606. Licensed under The MIT License:
//
// Copyright 2025 Axeon Network
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of 
// this software and associated documentation files (the “Software”), to deal in 
// the Software without restriction, including without limitation the rights to use, 
// copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the 
// Software, and to permit persons to whom the Software is furnished to do so, 
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all 
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


// oh boy, here we go
document.addEventListener('DOMContentLoaded', () => { 
    const header = document.querySelector('.mdl-layout__header');
    const drawer = document.querySelector('.mdl-layout__drawer'); 
    const mainBody = document.body; 
    // ^ absolute cinema

    const viewer = document.getElementById('springviewer');
    const viewerCaption = document.getElementById('viewer-caption');
    const closeBtn = document.querySelector('.close-btn');
    const prevBtn = document.querySelector('.nav-btn.prev-btn');
    const nextBtn = document.querySelector('.nav-btn.next-btn');

    const viewerMediaContainer = document.getElementById('viewer-media-container');

    const dlButton = document.querySelector('.dl-btn'); 
    const flscrButton = document.querySelector('.flscr-btn');
    const viewerCounter = document.querySelector('.viewer-counter');
            
    // we keep null so the script knows it exists
    let drawerBtn = null;

    // the button gets created by mdl too early so the script doesnt recognize it, 
    // we use a timeout to fetch it after mdl has finished the layout
    setTimeout(() => {
        // select the button after mdl has finished making the layout
        const foundBtn = document.querySelector('.mdl-layout__drawer-button');

        if (foundBtn) {
            // assign the found element to the outer 'drawerBtn' variable
            drawerBtn = foundBtn; 
            
            
            // WARNING!
            // Previous versions of SpringViewer used to have code related to
            // 'is-visible', such CSS class should not be used to avoid
            // corrupting the drawer.

            // If you are working with the 'is-visible' class, proceed at
            // your own irght

            // tell the console that it was found succesfully
            console.log("MDL Drawer Button Found and Listener Attached."); 
        } else {
            console.error("ERROR 0x3001 (SCRIPT_RAN_TOO_EARLY)");
        }
    }, 100);

    // this excludes the viewer container itself from being counted in the image counter.
    const excludedID = 'viewer-media-element';
    // and this from the banner in the drawer, if used
    const bannerID = 'drawer-banner';

    let galleryMedia = []; 
    let currentIndex = -1; 
    let totalMediaCount = 0;


    // format file size in bytes to a human-readable string
    const formatBytes = (bytes, decimals = 2) => {
        if (bytes === 0) return '0 Bytes';

        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

        const i = Math.floor(Math.log(bytes) / Math.log(k));

        return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    };
    
    // clear the details dialog elements
    const clearDetailsDialog = () => {
        document.getElementById('dialog-filename').textContent = 'N/A';
        document.getElementById('dialog-filesize').textContent = 'N/A';
        document.getElementById('dialog-resolution').textContent = 'N/A';
        document.getElementById('dialog-author', 'viewer-details-author').textContent = 'N/A';
        document.getElementById('dialog-uploaddate').textContent = 'N/A';
    };

    // update the details dialog with image metadata
    const updateDetailsDialog = async (imgElement) => {
        const url = imgElement.src;
        
        // author + filename
        let pathStart = url.indexOf('/', url.indexOf('://') + 3); 
        
        // extract the full path
        let filename = (pathStart !== -1) ? url.substring(pathStart) : url;

        // remove '/kurorwiki/'
        const prefixToRemove = '/kurowiki/';
        if (filename.startsWith(prefixToRemove)) {
            filename = filename.substring(prefixToRemove.length);
        }

        document.getElementById('dialog-filename').textContent = filename;

        const author = imgElement.getAttribute('author') || 'Axeon Network'; // we use axeon as a generic name bcuz uh...
        document.getElementById('dialog-author').textContent = author;
        document.getElementById('viewer-details-author').textContent = author;

        // resolution
        const width = imgElement.naturalWidth;
        const height = imgElement.naturalHeight;
        document.getElementById('dialog-resolution').textContent = `${width}x${height} pixels`;

        // file size + upload date
        document.getElementById('dialog-filesize').textContent = 'Loading...';
        document.getElementById('dialog-uploaddate').textContent = 'Loading...';

        try {
            const response = await fetch(url, { method: 'HEAD' });
            
            // file size
            const contentLength = response.headers.get('content-length');
            if (contentLength) {
                const fileSize = formatBytes(parseInt(contentLength, 10));
                document.getElementById('dialog-filesize').textContent = fileSize;
            } else {
                const userMsg = '0x8001 (MISSING_HEADER_SIZE)';
                console.warn(`0x8001 (MISSING_HEADER_SIZE): Content-Length header missing.`);
                document.getElementById('dialog-filesize').textContent = userMsg;
            }
            
            // last modified + upload date
            const lastModified = response.headers.get('last-modified');
            if (lastModified) {
                // format the date string nicely
                const date = new Date(lastModified).toLocaleDateString('en-GB', {  // no en-US cuz we use DD MMMM YYYY ovah here
                    year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' 
                });
                document.getElementById('dialog-uploaddate').textContent = date;
            } else {
                // log and print error to user
                const userMsg = '0x8002 (MISSING_HEADER_DATE)';
                console.warn(`0x8002 (MISSING_HEADER_DATE): Last-Modified header missing.`);
                document.getElementById('dialog-uploaddate').textContent = userMsg;
            }

        } catch (error) {
            const userMsg = '0x8100 (FETCH_REQUEST_FAILED)';
            console.error('0x8100 (FETCH_REQUEST_FAILED): Metadata fetch failed:', error);
            document.getElementById('dialog-filesize').textContent = userMsg;
            document.getElementById('dialog-uploaddate').textContent = userMsg;
        }
    };

    const downloadMedia = () => {
        const activeMediaElement = document.getElementById(excludedID);
            
        if (currentIndex !== -1 && activeMediaElement) {
            if (activeMediaElement.tagName !== 'IMG') {
                 console.warn("0x4001 (FILE_TYPE_NOT_ALLOWED)");
                 return;
            }

            const currentSrc = activeMediaElement.src;
            const link = document.createElement('a');
            link.href = currentSrc;
                
            const filename = currentSrc.substring(currentSrc.lastIndexOf('/') + 1) || 'download.png';
            link.download = filename; 

            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    };
        
    // full screen logic
    const toggleFullscreen = () => {
        if (document.fullscreenElement) {
            document.exitFullscreen();
        } else {
            viewer.requestFullscreen().catch(err => {
                console.error(`0x7001 (FULLSCREEN_REQUEST_FAILED): ${err.message}`);
            });
        }
    };
        
    // update the viewer content and state
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
                
                const authorAttr = mediaSourceElement.getAttribute('author');
                if (authorAttr) {
                    newMediaElement.setAttribute('author', authorAttr);
                }
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
                
                const originalAttributes = mediaSourceElement.attributes;
                // a rough check to see if there are more attributes than just src/controls
                if (originalAttributes.length > (newMediaElement.src ? 1 : 0) + mediaSourceElement.querySelectorAll('source').length) {
                    console.warn(`0x2001 (ATTRIBUTE_NOT_COPIED): Attributes not copied for ${tagName}. Missing attributes might include 'poster' or custom data attributes.`);
                }
                    
            } 
                
            if (newMediaElement) {
                viewerMediaContainer.appendChild(newMediaElement);

                if (tagName === 'IMG') {
                    // wait for the image to load before trying to get its metadata/resolution
                    newMediaElement.onload = () => {
                        updateDetailsDialog(newMediaElement);
                    };
                    // in case the image is already cached/loaded, call it immediately too
                    if (newMediaElement.complete) {
                        updateDetailsDialog(newMediaElement);
                    }
                } else {
                    // for video/audio, clear the dialog values
                    clearDetailsDialog();
                }


                let captionText = '';
                const parentFigure = mediaSourceElement.closest('figure');
                if (parentFigure) {
                    const captionElement = parentFigure.querySelector('figcaption');
                    captionText = captionElement ? captionElement.innerHTML : '';
                }
                
                if (!captionText) {
                    captionText = mediaSourceElement.alt || mediaSourceElement.title || '';
                    if (mediaSourceElement.title && !mediaSourceElement.alt) {
                        console.warn("0x6001 (TITLE_NOT_FOUND): Falling back to 'title' for caption. Use 'alt' or '<figcaption>' for main caption text.");
                    }
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

        // 2. Hide the elements using your stable logic
        if (header) header.classList.add('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.add('mdl-hidden');

        // 3. Use the aggressive hiding class on the drawer (Needs CSS rule)
        if (drawer) drawer.classList.add('viewer-drawer-hidden');

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

        if (drawer) {
            drawer.classList.remove('viewer-drawer-hidden');
        }

        // 2. reshow the MDL elements
        if (header) header.classList.remove('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.remove('mdl-hidden');

        mainBody.classList.remove('hide-scrollbar');
    };
        
    // filter elements and collect them all, to make this universal
    const allMediaElements = document.querySelectorAll('img, video, audio'); 
        
    galleryMedia = Array.from(allMediaElements).filter(element => {
        return element.id !== excludedID && element.id !== bannerID && (element.src || element.querySelector('source'));
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
    if (nextBtn) { 
        nextBtn.addEventListener('click', () => {
            const nextIndex = (currentIndex + 1) % galleryMedia.length;
            updateViewer(nextIndex);
        });
    }

    if (prevBtn) { 
        prevBtn.addEventListener('click', () => {
            const prevIndex = (currentIndex - 1 + galleryMedia.length) % galleryMedia.length;
            updateViewer(prevIndex);
        });
    }

    if (dlButton) dlButton.addEventListener('click', downloadMedia);
    if (flscrButton) flscrButton.addEventListener('click', toggleFullscreen);
        
    if (closeBtn) { 
        closeBtn.addEventListener('click', hideViewer);
    }

    // click on backdrop (the black area)
    if (viewer) { 
        viewer.addEventListener('click', (event) => {
            if (event.target === viewer) {
                const mediaElement = document.getElementById(excludedID);
                if (mediaElement && event.target.contains(mediaElement)) {
                    // --- 0x5001: ELEM_MISALIGNMENT_TRAP ---
                    console.info("0x5001 (POTENTIAL_BACKDROP_OVERLAP): Backdrop click registered successfully, but note the potential for overlapping elements.");
                }
                hideViewer();
            }
        });
    }

    // keyboard controls!
    document.addEventListener('keydown', (event) => {
        if (!viewer || viewer.classList.contains('viewer-hidde')) {
            return; // exit if viewer isnt active or doesnt exist....duh
        }
        
        if (event.key === 'Escape') {
            hideViewer();
        } else if (event.key === 'ArrowRight') {
            if (nextBtn) nextBtn.click();
        } else if (event.key === 'ArrowLeft') {
            if (prevBtn) prevBtn.click();
        }
        else if (event.key === 'd' || event.key === 'D') {
            event.preventDefault();
            downloadMedia();
        }
        else if (event.key === 'f' || event.key === 'F') {
            event.preventDefault();
            toggleFullscreen();
        }
    });

});