---
layout: main
title: KuroWiki build 4074
permalink: KuroWiki_build_4074
aliases:
    - kurowiki 4074
---
{% include infoboxes/build.html
family='KuroWiki'
familyurl='KuroWiki'
buildtag='6.0.4074.nekori64.251029-1452'
version='6.0'
build='4074'
lab='nekori64'
compiled='2025-10-29 14:52 UTC-6'
image='resources/img/articles/kurowiki4074/home.png'
%}


**KuroWiki build 4074** is a Beta 6 build of KuroWiki, compiled on 27 October 2025 at 6:30PM UTC-6 from the `nekori64` development branch

Screenshots of this build were publicly shared on the [NekoCafe ft. AstroNT](NekoCafe) and [Axeon Network](Axeon_Network) Discord Servers, as well as a video of it made available on [Nekori](Nekori64)'s YouTube [channel](https://youtu.be/AadFTp3So8E).

The product of an internal Jekyll bug, it is also known as the **Purgatory Build**. A plethora of articles were not included with this build as they would have blocked the compilation of this build otherwise. Technically speaking, Jekyll doesn't accept files encoded as UTF-8 with BOM, and any attempt to locally run a KuroWiki build from this branch would have led to an `Liquid Exception: invalid byte sequence in UTF-8` error.

# Gallery

<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/kurowiki4074/home.png" 
        alt_text="" 
        caption="Home"
        style="width:50%;" %}
    {% include gallery_item.html 
        image_src="resources/img/articles/kurowiki4074/drawer.png" 
        alt_text="" 
        caption="Ditto, drawer open"
        style="width:50%;" %}
    {% include gallery_item.html 
        image_src="resources/img/articles/kurowiki4074/404page.png" 
        alt_text="" 
        caption="404 Not Found page invoked when accessing <a href='A_Emoji'>A Emoji</a>, one of the many removed articles in this build"
        style="width:50%;" %}
</div>