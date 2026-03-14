// Developed with love by KitSixtyFour/StupidBiFox.
// SpringViewer "Trifrost" Version 3.0. Licensed under The MIT License:
//
// Copyright 2025-2026 Axeon Network
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
    const viewer = document.getElementById('springviewer');
    const viewerCaption = document.getElementById('viewer-caption');
    const closeBtn = document.querySelector('.close-btn');
    const prevBtn = document.querySelector('.nav-btn.prev-btn');
    const nextBtn = document.querySelector('.nav-btn.next-btn');
    const viewerMediaContainer = document.getElementById('viewer-media-container');
    const dlButton = document.querySelector('.dl-btn'); 
    const flscrButton = document.querySelector('.flscr-btn');
    const viewerCounter = document.querySelector('.viewer-counter');
            
    let drawerBtn = null;
    setTimeout(() => {
        const foundBtn = document.querySelector('.mdl-layout__drawer-button');
        if (foundBtn) {
            drawerBtn = foundBtn; 
            console.log("MDL Drawer Button Found and Listener Attached."); 
        } else {
            console.error("ERROR 0x3001 (SCRIPT_RAN_TOO_EARLY)");
        }
    }, 100);

    const excludedID = 'viewer-media-element';
    const bannerID = 'drawer-banner';
    let galleryMedia = []; 
    let currentIndex = -1; 
    let totalMediaCount = 0;

    const formatBytes = (bytes, decimals = 2) => {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    };
    
    const clearDetailsDialog = () => {
        document.getElementById('dialog-filename').textContent = 'N/A';
        document.getElementById('dialog-filesize').textContent = 'N/A';
        document.getElementById('dialog-resolution').textContent = 'N/A';
        document.getElementById('dialog-author').textContent = 'N/A';
        document.getElementById('viewer-details-author').textContent = 'N/A';
        document.getElementById('dialog-uploaddate').textContent = 'N/A';
    };

    const updateDetailsDialog = async (imgElement) => {
        const url = imgElement.src;
        let pathStart = url.indexOf('/', url.indexOf('://') + 3); 
        let filename = (pathStart !== -1) ? url.substring(pathStart) : url;
        const prefixToRemove = '/kurowiki/';
        if (filename.startsWith(prefixToRemove)) {
            filename = filename.substring(prefixToRemove.length);
        }
        document.getElementById('dialog-filename').textContent = filename;
        const author = imgElement.getAttribute('author') || 'Axeon Network';
        document.getElementById('dialog-author').textContent = author;
        document.getElementById('viewer-details-author').textContent = author;

        const width = imgElement.naturalWidth || 0;
        const height = imgElement.naturalHeight || 0;
        document.getElementById('dialog-resolution').textContent = (width > 0) ? `${width}x${height} pixels` : 'N/A';

        document.getElementById('dialog-filesize').textContent = 'Loading...';
        document.getElementById('dialog-uploaddate').textContent = 'Loading...';

        try {
            const response = await fetch(url, { method: 'HEAD' });
            const contentLength = response.headers.get('content-length');
            if (contentLength) {
                document.getElementById('dialog-filesize').textContent = formatBytes(parseInt(contentLength, 10));
            } else {
                document.getElementById('dialog-filesize').textContent = '0x8001 (MISSING_SIZE)';
            }
            
            const lastModified = response.headers.get('last-modified');
            if (lastModified) {
                const date = new Date(lastModified).toLocaleDateString('en-GB', { 
                    year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' 
                });
                document.getElementById('dialog-uploaddate').textContent = date;
            } else {
                document.getElementById('dialog-uploaddate').textContent = '0x8002 (MISSING_DATE)';
            }
        } catch (error) {
            document.getElementById('dialog-filesize').textContent = '0x8100 (FETCH_FAIL)';
            document.getElementById('dialog-uploaddate').textContent = '0x8100 (FETCH_FAIL)';
        }
    };

    const downloadMedia = () => {
        const activeMediaElement = document.getElementById(excludedID);
        if (currentIndex !== -1 && activeMediaElement) {
            const currentSrc = activeMediaElement.src;
            if (!currentSrc) return;

            const link = document.createElement('a');
            link.href = currentSrc;
            const extension = activeMediaElement.tagName === 'VIDEO' ? '.mp4' : '.png';
            const filename = currentSrc.substring(currentSrc.lastIndexOf('/') + 1) || ('download' + extension);
            link.download = filename; 
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    };
        
    const toggleFullscreen = () => {
        if (document.fullscreenElement) {
            document.exitFullscreen();
        } else {
            viewer.requestFullscreen().catch(err => {
                console.error(`0x7001 (FULLSCREEN_REQUEST_FAILED): ${err.message}`);
            });
        }
    };
        
    const updateViewer = (index) => {
        if (index >= 0 && index < galleryMedia.length) {
            const mediaSourceElement = galleryMedia[index]; 
            currentIndex = index;
            viewerMediaContainer.innerHTML = '';
                
            let newMediaElement;
            let isVideo = false;
            if (!mediaSourceElement) return;
                
            const videoSrc = mediaSourceElement.getAttribute('data-video-src');
            const tagName = mediaSourceElement.tagName;
                
            if (videoSrc) {
                // Handle Video via Thumbnail trigger
                isVideo = true;
                newMediaElement = document.createElement('video');
                newMediaElement.id = excludedID;
                newMediaElement.src = videoSrc;
                newMediaElement.controls = true;
                newMediaElement.autoplay = true;
                clearDetailsDialog();
            } 
            else if (tagName === 'IMG') {
                newMediaElement = document.createElement('img');
                newMediaElement.src = mediaSourceElement.src;
                newMediaElement.alt = mediaSourceElement.alt || '';
                newMediaElement.id = excludedID;
                const authorAttr = mediaSourceElement.getAttribute('author');
                if (authorAttr) newMediaElement.setAttribute('author', authorAttr);

                newMediaElement.onload = () => updateDetailsDialog(newMediaElement);
                if (newMediaElement.complete) updateDetailsDialog(newMediaElement);
            } 
            else if (tagName === 'VIDEO') {
                isVideo = true;
                newMediaElement = document.createElement('video');
                newMediaElement.id = excludedID;
                newMediaElement.controls = true;
                newMediaElement.autoplay = true;
                if (mediaSourceElement.src) newMediaElement.src = mediaSourceElement.src;
                Array.from(mediaSourceElement.querySelectorAll('source')).forEach(source => {
                    newMediaElement.appendChild(source.cloneNode(true));
                });
                clearDetailsDialog();
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
            // Download button visibility logic
            if (dlButton) dlButton.style.display = 'block'; 
        }
    };
        
    const openViewer = (index) => {
        updateViewer(index);
        viewer.classList.remove('viewer-hidde');
        if (viewerCounter) viewerCounter.style.display = 'block';
        if (header) header.classList.add('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.add('mdl-hidden');
        if (drawer) drawer.classList.add('viewer-drawer-hidden');
        mainBody.classList.add('hide-scrollbar');
    };

    const hideViewer = () => {
        viewer.classList.add('viewer-hidde');
        currentIndex = -1;
        if (viewerCounter) viewerCounter.style.display = 'none';
        const activeMedia = document.getElementById(excludedID);
        if (activeMedia && activeMedia.tagName === 'VIDEO') {
            activeMedia.pause();
        }
        if (drawer) drawer.classList.remove('viewer-drawer-hidden');
        if (header) header.classList.remove('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.remove('mdl-hidden');
        mainBody.classList.remove('hide-scrollbar');
    };
        
    // Filtered to only IMG and VIDEO
    const allMediaElements = document.querySelectorAll('img, video'); 
    galleryMedia = Array.from(allMediaElements).filter(element => {
        return element.id !== excludedID && element.id !== bannerID && (element.src || element.querySelector('source') || element.hasAttribute('data-video-src'));
    });
        
    totalMediaCount = galleryMedia.length;
        
    galleryMedia.forEach((mediaElement, index) => {
        mediaElement.style.cursor = 'pointer'; 
        mediaElement.addEventListener('click', (event) => {
            event.preventDefault(); 
            openViewer(index);
        });
    });

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
    if (closeBtn) closeBtn.addEventListener('click', hideViewer);

    if (viewer) { 
        viewer.addEventListener('click', (event) => {
            if (event.target === viewer) hideViewer();
        });
    }

    document.addEventListener('keydown', (event) => {
        if (!viewer || viewer.classList.contains('viewer-hidde')) return;
        if (event.key === 'Escape') hideViewer();
        else if (event.key === 'ArrowRight') nextBtn?.click();
        else if (event.key === 'ArrowLeft') prevBtn?.click();
        else if (event.key === 'd' || event.key === 'D') { event.preventDefault(); downloadMedia(); }
        else if (event.key === 'f' || event.key === 'F') { event.preventDefault(); toggleFullscreen(); }
    });
});