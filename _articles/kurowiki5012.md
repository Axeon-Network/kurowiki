---
title: KuroWiki build 5012
permalink: KuroWiki_build_5012
---

{% include infoboxes/build.html
family='[KuroWiki](KuroWiki)'
buildtag='7.0.5012.mdelta_N.260410-1441'
version='7.0'
build='5012'
lab='mdelta_N'
compiled='2026-04-10 14:41 UTC-6'
image='res/img/articles/kurowiki5012/caption.png'
image_caption='SpringViewer'
%}

**KuroWiki build 5012** is a Release Candidate 1 build of [KuroWiki](KuroWiki) compiled on 10 April 2026 at 2:41 PM UTC-6 from the internal `mdelta_N` buffer branch.

This build includes a minor update to SpringViewer 3.0 (codenamed *Trifrost*) where the image caption shown on the viewer has two fallbacks in case `.infobox-image-caption-2` or `.gallery-caption` isn't found: if the `alt` and/or `title` attributes are added to the image's `img` tag, it is used as the image caption. Otherwise, SpringViewer uses the image's file name as a fallback in case both captions fail.

<div class="wiki-gallery">
	{% include items/gallery.html
	caption='A screenshot showing the fallback functionality'
	image_src='res/img/articles/kurowiki5012/fallback.png'
%}
</div>