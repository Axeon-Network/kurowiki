---
title: KuroWiki build 4450
permalink: KuroWiki_build_4450
redirect_from: 
    - KuroWiki_Beta_6.1.html
    - KuroWiki_Beta_6_Hotfix_1
    - KuroWiki_Beta_6.0.1.html
aliases:
    - kurowiki 4450
---
{% include infoboxes/build.html
release_name='Beta Release 6 Hotfix 1'
family='[KuroWiki](KuroWiki)'
buildtag='6.0.1.4450.main.260110-2027'
version='6.0.1'
build='4450'
lab='main'
compiled='2026-01-10 20:27 UTC-6'
image='res/img/articles/kurowiki4450/home.png'
image_caption='Home page (dark mode)'
image2='res/img/articles/kurowiki4450/homelight.png'
image2_caption='Home page (light mode)'
%}


**KuroWiki build 4450** is the official Beta 6 Hotfix 1 build of [KuroWiki](KuroWiki), compiled and released on 10 January 2026 at 8:27PM UTC-6.

This release mainly served to switch to locally hosting the [Material Design Lite (MDL)](https://github.com/google/material-design-lite) resources, instead of relying on the official getmdl.io website, which was taken down by Google sometime before January 10. This caused [build 4400](KuroWiki_build_4400), and many other KuroWiki builds prior to it, to completely break since any requests to getmdl.io returned with HTTP 403, essentially making MDL unavailable. 

Additionally, the copyright year has been updated to reflect the new year, while some references to "Nekori" and "Nekori64" have been replaced with "KitSixtyFour".

# Quirks
- The version number is incorrectly displayed as `6.0.4450.main.260110-2027` in the build tag and as "Axeon KuroWiki Beta 6.01" in the version banner, while the actual version number is `6.0.1`.

# Gallery
<div class="wiki-gallery">
    {% include items/gallery.html 
        image_src="res/img/articles/kurowiki4450/drawer.png" 
        caption="Drawer" %}
</div>