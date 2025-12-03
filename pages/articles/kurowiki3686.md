---
layout: main
title: KuroWiki build 3686
permalink: KuroWiki_build_3686
hatnote:
aliases:
    - kurowiki 3686
---
{% include infoboxes/build.html
family='KuroWiki'
familyurl='KuroWiki'
buildtag='6.0.3686.nekori64.251013-0239'
version='6.0'
build='3686'
lab='nekori64'
compiled='2025-10-12 17:17 UTC-6'
image='resources/img/articles/kurowiki3686/home.png'
%}

**KuroWiki build 3686** is the second overall Beta 6 build of KuroWiki, compiled from the `nekori64` branch on 12 October 2025 at 17:17 (5:17pm) UTC-6.

This build builds upon the Dark Mode, first implemented in [the previous build](KuroWiki_build_2600_(Beta_6)), with more elements of the codebase having been adapted. However, it is still incomplete in this build, with various elements like the boxes in the Search Results page still being white, but with the text already white.

Additionally the "KuroWiki" text in the navbar is now clickable. For convenience, clicking on it now directs you to the homepage which was moved to the website root instead of `Main_Page`, which now returns a 404 Not Found.

The *Featured article* box was also changed, adding a link to the "Full article" at the end of the excerpt.

<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/kurowikibuild3686/home.png" 
        alt_text="Homepage of KuroWiki build 3686" 
        caption="Homepage of KuroWiki build 3686"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kurowikibuild3686/article.png" 
        alt_text="Article view" 
        caption="Article view"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kurowikibuild3686/drawer.png" 
        alt_text="Ditto, drawer open" 
        caption="Ditto, drawer open"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kurowikibuild3686/springviewer.png" 
        alt_text="SpringViewer, KuroWiki's media viewer" 
        caption="SpringViewer, KuroWiki's media viewer"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kurowikibuild3686/search.png" 
        alt_text="Search Results" 
        caption="Search Results"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kurowikibuild3686/navbar.png" 
        alt_text="The KuroWiki text in the navbar, now clickable." 
        caption="The KuroWiki text in the navbar, now clickable."
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kurowikibuild3686/404.png" 
        alt_text="Main_Page displaying a 404, after the homepage was moved to the website root" 
        caption="Main_Page displaying a 404, after the homepage was moved to the website root. An 404 page wouldn't be implemented until <a href='KuroWiki_build_3689'>build 3689</a>"
        style="width:50%;" %}
</div>