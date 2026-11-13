// Axeon Quartz "Cleveland" Version 4.00
// Written by KitSixtyFour/SnowyBiFox

// Licensed under The MIT License:
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
    const viewer = document.getElementById('qtz-cleveland');
    const viewerCaption = document.getElementById('qtz-cleveland-caption');
    const closeBtn = document.querySelector('.qtz-cleveland-close-btn');
    const prevBtn = document.querySelector('.qtz-cleveland-nav-btn.qtz-cleveland-prev-btn');
    const nextBtn = document.querySelector('.qtz-cleveland-nav-btn.qtz-cleveland-next-btn');
    const viewerMediaContainer = document.getElementById('qtz-cleveland-media-container');
    const dlButton = document.querySelector('.qtz-cleveland-dl-btn'); 
    const flscrButton = document.querySelector('.qtz-cleveland-flscr-btn');
    const viewerCounter = document.querySelector('.qtz-cleveland-counter');
    const opnButton = document.querySelector('.qtz-cleveland-opn-btn');
    const dialogFilename = document.getElementById('qtz-cleveland-dialog-filename');
    const dialogFilesize= document.getElementById('qtz-cleveland-dialog-filesize');
    const dialogFileres = document.getElementById('qtz-cleveland-dialog-resolution');
    const dialogAuthorBar = document.getElementById('qtz-cleveland-dialog-author');
    const dialogAuthor = document.getElementById('qtz-cleveland-details-author');
    const dialogUpload = document.getElementById('qtz-cleveland-dialog-uploaddate');


    // jekyll can convert markdown to html via markdownify, which works on the gallery items,
    // when cleveland sees it, it uses something like [Text](URL) since it uses the raw data,
    // so we make a small markdown helper so it displays "correctly".
    const miniMarkdownify = (text) => {
    if (!text) return '';
    return text
        .replace(/\*\*\*(.*?)\*\*\*/g, '<b><i>$1</i></b>') // Bold + Italic
        .replace(/\*\*(.*?)\*\*/g, '<b>$1</b>')           // Bold
        .replace(/\*(.*?)\*/g, '<i>$1</i>')               // Italic
        .replace(/~~(.*?)~~/g, '<del>$1</del>')          // Strikethrough
        .replace(/\[(.*?)\]\((.*?)\)/g, '<a href="$2">$1</a>'); // Links
    };

    let drawerBtn = null;
    setTimeout(() => {
        const foundBtn = document.querySelector('.mdl-layout__drawer-button');
        if (foundBtn) {
            drawerBtn = foundBtn; 
        } else {
            console.error("[Cleveland] Cannot find button\nThe MDL Drawer button could not be found thus cannot be hidden. Cleveland was either invoked too fast, or it is not running on this page.");
        }
    }, 55);

    const excludedID = 'qtz-cleveland-media-element';
    const bannerID = 'qtz-drawer-banner';
    let galleryMedia = []; 
    let currentIndex = -1; 
    let totalMediaCount = 0;

    const formatBytes = (bytes, decimals = 2) => {
        if (bytes === 0) return '0 bytes';
        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ['bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    };
    
    const clearDetailsDialog = () => {
        dialogFilename.textContent = 'dummy';
        dialogFilesize.textContent = 'dummy';
        dialogFileres.textContent = 'dummy';
        dialogAuthorBar.textContent = 'dummy';
        dialogAuthor.textContent = 'dummy';
        dialogUpload.textContent = 'dummy';
    };

    const updateDetailsDialog = async (imgElement) => {
        const url = imgElement.src;
        let pathStart = url.indexOf('/', url.indexOf('://') + 3); 
        let filename = (pathStart !== -1) ? url.substring(pathStart) : url;
        const prefixToRemove = '/kurowiki/';
        if (filename.startsWith(prefixToRemove)) {
            filename = filename.substring(prefixToRemove.length);
        }
        dialogFilename.textContent = filename;
        const author = imgElement.getAttribute('author') || 'Axeon Network';
        dialogAuthorBar.textContent = author;
        dialogAuthor.textContent = author;

        const width = imgElement.naturalWidth || 0;
        const height = imgElement.naturalHeight || 0;
        dialogFileres.textContent = (width > 0) ? `${width}x${height} pixels` : 'N/A';

        dialogFilesize.textContent = 'Loading...';
        dialogUpload.textContent = 'Loading...';

        try {
            const response = await fetch(url, { method: 'HEAD' });
            const contentLength = response.headers.get('content-length');
            if (contentLength) {
                dialogFilesize.textContent = formatBytes(parseInt(contentLength, 10));
            } else {
                dialogFilesize.textContent = 'FLSIZE_REQ_FAILED';
                console.error(`[Cleveland] File size metadata request failed\nThe request for fetching the file size has failed. ${err.message}`)
            }
            
            const lastModified = response.headers.get('last-modified');
            if (lastModified) {
                const date = new Date(lastModified).toLocaleDateString('en-GB', { 
                    year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' 
                });
                dialogUpload.textContent = date;
            } else {
                dialogUpload.textContent = 'MDFDATE_REQ_FAILED';
                console.error(`[Cleveland] File modification metadata request failed\nThe request for fetching the last modified date has failed. ${err.message}`);
            }
        } catch (error) {
            dialogFilesize.textContent = 'The request has failed. Please see the console for more information.';
            dialogUpload.textContent = 'The request has failed. Please see the console for more information.';;
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

    const openInBrowser = () => {
        const activeMediaElement = document.getElementById(excludedID);
        if (currentIndex !== -1 && activeMediaElement) {
            const currentSrc = activeMediaElement.src;
            if (!currentSrc) return;
            
            const link = document.createElement('a');
            link.href = currentSrc;
            link.target = '_blank';
            link.rel = 'noopener noreferrer';

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
                console.error(`[Cleveland] Fullscreen denied\nCleveland cannot enter full screen mode. ${err.message}`);
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

            // look for the caption
            const container = mediaSourceElement.closest('.gallery-item, .silver-item, .qtz-cleveland-infobox-img-container') || mediaSourceElement.parentElement;

            // Pass a string to querySelector, not an array
            const specialCaption = container.querySelector('.qtz-cleveland-infobox-img-caption-2, .gallery-caption, .silver-caption');
    
            if (specialCaption) {
                // if it's already rendered, grab the html
                captionText = specialCaption.innerHTML.replace(/<\/?p>/gi, '').trim();
            } 
    
            // fallback to alt text/title attribs if no caption is found
            if (!captionText || captionText.trim() === "") {
                captionText = mediaSourceElement.alt || mediaSourceElement.title || '';
                // run it through the markdown helper
                captionText = miniMarkdownify(captionText);
            }

            // if all else fail, use the filename
            if (!captionText || captionText.trim() === "") {
                const url = mediaSourceElement.src || videoSrc || "";
                captionText = url.substring(url.lastIndexOf('/') + 1);
                console.error(`[Cleveland] Caption fetch failed\nThe image's caption text cannot be found. Cleveland will display the file name instead.`)
            }

            viewerCaption.innerHTML = captionText;
            }  
            viewerCounter.textContent = `${currentIndex + 1}/${totalMediaCount}`;
            if (dlButton) dlButton.style.display = 'block'; 
        }
    };
        
    const openViewer = (index) => {
        updateViewer(index);
        viewer.classList.remove('qtz-cleveland-hidden');
        if (viewerCounter) viewerCounter.style.display = 'block';
        if (header) header.classList.add('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.add('mdl-hidden');
        if (drawer) drawer.classList.add('qtz-cleveland-drawer-hidden');
        mainBody.classList.add('hide-scrollbar');
    };

    const hideViewer = () => {
        viewer.classList.add('qtz-cleveland-hidden');
        currentIndex = -1;
        if (viewerCounter) viewerCounter.style.display = 'none';
        const activeMedia = document.getElementById(excludedID);
        if (activeMedia && activeMedia.tagName === 'VIDEO') {
            activeMedia.pause();
        }
        if (drawer) drawer.classList.remove('qtz-cleveland-drawer-hidden');
        if (header) header.classList.remove('mdl-hidden');
        if (drawerBtn) drawerBtn.classList.remove('mdl-hidden');
        mainBody.classList.remove('hide-scrollbar');
    };
        
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
    if (opnButton) opnButton.addEventListener('click', openInBrowser);
    if (flscrButton) flscrButton.addEventListener('click', toggleFullscreen);
    if (closeBtn) closeBtn.addEventListener('click', hideViewer);

    if (viewer) { 
        viewer.addEventListener('click', (event) => {
            if (event.target === viewer) hideViewer();
        });
    }

    document.addEventListener('keydown', (event) => {
        if (!viewer || viewer.classList.contains('qtz-cleveland-hidden')) return;
        if (event.key === 'Escape') hideViewer();
        else if (event.key === 'ArrowRight') nextBtn?.click();
        else if (event.key === 'ArrowLeft') prevBtn?.click();
        else if (event.key === 'd' || event.key === 'D') { event.preventDefault(); downloadMedia(); }
        else if (event.key === 'f' || event.key === 'F') { event.preventDefault(); toggleFullscreen(); }
        else if (event.key === 'o' || event.key === 'O') { openInBrowser(); }
    });
});