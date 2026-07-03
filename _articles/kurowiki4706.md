---
title: KuroWiki build 4706
permalink: KuroWiki_build_4706
aliases:
    - kurowiki 4706
---
{% include infoboxes/build.html
family='KuroWiki'
familyurl='KuroWiki'
buildtag='7.0.4706.kayaurora.260309-0025'
version='7.0'
build='4706'
lab='kayaurora'
compiled='2026-03-09 00:25 UTC+2'
image='res/img/articles/kurowiki4706/home.png'
image_caption='Home page (dark mode)'
image2='res/img/articles/kurowiki4706/homelight.png'
image2_caption='Home page (light mode)'
%}

**KuroWiki build 4706** is a Release Candidate 1 build of KuroWiki, compiled on 9 March 2026 at 00:25 UTC+2 from the `kayaurora` development branch.

Screenshots with this build have been published with a final design of the Table of Contents (ToC) box, simply known in the frontend as the *In this article...* box, which is however still not implemented well enough in this build due to quirks such as improper aligning or it appearing where it shouldn't, like the Homepage or the Settings page.

Some code cleanup had also been made in this build, such as moving the JavaScript code for the Featured Article box to its own file. While on that topic, a bug with the box where the featured article title would not appear has been finally fixed after having been broken since [build 4100](KuroWiki_build_4100), the fourth Interim Developer Release of KuroWiki based on unfinished Beta 6 code.

Additionally, the line "*This is beta software!*" in the homepage's hatnote has been changed to "*This software is still unfinished!*", reflecting the transition from the Beta stage to the Release Candidate stage.

# Gallery

## Dark mode

<div class="wiki-gallery">
    {% include items/gallery.html 
        image_src="res/img/articles/kurowiki4706/drawer.png" 
        caption="Drawer" %}
    {% include items/gallery.html 
        image_src="res/img/articles/kurowiki4706/article.png" 
        caption="Article" %}
    {% include items/gallery.html 
        image_src="res/img/articles/kurowiki4706/settings.png" 
        caption="Settings" %}
</div>

## Light mode

<div class="wiki-gallery">
    {% include items/gallery.html 
        image_src="res/img/articles/kurowiki4706/drawerlight.png" 
        caption="Drawer" %}
    {% include items/gallery.html 
        image_src="res/img/articles/kurowiki4706/articlelight.png" 
        caption="Article" %}
</div>