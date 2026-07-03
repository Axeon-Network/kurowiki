---
title: KuroWiki build 4074
permalink: KuroWiki_build_4074
redirect_from:
    - KuroWiki_Purgatory_Build
aliases:
    - kurowiki 4074
    - kurowiki purgatory build
---
{% include infoboxes/build.html
family='[KuroWiki](KuroWiki)'
buildtag='6.0.4074.nekori64.251029-1452'
version='6.0'
build='4074'
lab='nekori64'
compiled='2025-10-29 14:52 UTC-6'
image='res/img/articles/kurowiki4074/home.png'
image_caption='Home page'
%}

**KuroWiki build 4074** is a Beta 6 build of KuroWiki, compiled on 27 October 2025 at 6:30PM UTC-6 from the `nekori64` development branch.

Screenshots of this build were publicly shared on the [Nishi's Den](Nishi's_Den) and [Axeon Network](Axeon_Network) Discord Servers, as well as a video of it made available on [KitSixtyFour](KitSixtyFour)'s YouTube [channel](https://youtu.be/AadFTp3So8E).

The product of an internal Jekyll bug, it is also known as the **Purgatory Build**. A plethora of articles were not included with this build as they would have blocked the compilation of this build otherwise. Technically speaking, Jekyll doesn't accept files encoded as UTF-8 with BOM, and any attempt to locally run a KuroWiki build from this branch would have led to an `Liquid Exception: invalid byte sequence in UTF-8` error. The root cause was eventually found to be unusual characters present inside SpringViewer code.

The source code was publically archived on Internet Archive and can be [downloaded here](https://archive.org/details/axeon-kurowiki-beta-6-purgatory-build).

# Gallery

<div class="wiki-gallery">
    {% include items/gallery.html 
        image_src="res/img/articles/kurowiki4074/drawer.png" 
        alt_text="" 
        caption="Drawer"
        style="width:50%;" %}
    {% include items/gallery.html 
        image_src="res/img/articles/kurowiki4074/404page.png" 
        alt_text="" 
        caption="404 Not Found page invoked when accessing <a href='A_Emoji'>A Emoji</a>, one of the many removed articles in this build"
        style="width:50%;" %}
</div>