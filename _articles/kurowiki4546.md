---
title: KuroWiki build 4546
permalink: KuroWiki_build_4546
---

{% include infoboxes/build.html
family='[KuroWiki](KuroWiki)'
buildtag='7.0.4546.private/kitsixtyfour_N(stupidbifox).260215-1732'
version='7.0'
build='4546'
lab='kitsixtyfour_N'
compiled='2026-02-15 17:32 UTC-6'
image='resources/img/articles/kurowiki4546/homepage.png'
image_caption='Home page'
%}

**KuroWiki build 4546** is a private Release Candidate 1 build of [KuroWiki](KuroWiki), compiled on 15 February 2026 at 5:32 pm UTC-6 from the `kitsixtyfour_N` branch. Screenshots of this build had been sent to the [Axeon Network](Axeon_Network#Discord_Server) Discord server.

# Background
This build was compiled a few hours later following the development branch (`kitsixtyfour` and `kayaurora`) source code merge to the `mdelta_N` branch; a "buffer branch" specifically made to forward and backward integrate source code changes between the development branches and public releases of *Deltari*.<br>Its build lab, `kitsixtyfour_N` indicates it was compiled on the buffer version of the `kitsixtyfour` development branch[^1], owned by [KitSixtyFour](KitSixtyFour).

# New features and changes
Apparent by the build's console output, it is the one of the first known builds to include [*TagGen*](TagGen) version 2.0, which identifies itself as *Axeon Kuro/Delta Build Tag Generator Code Named "TagGen"*; alongside a banner reading *Pre-Release Axeon Kuro/Delta Release Candidate 1*, printed before the TagGen banner. 

A deprecation notice for *DeltaSearch*, *Deltari*'s search engine indexer, was also included in this build, stating that in future releases of KuroWiki/Deltari, DeltaSearch will be discontinued in favor of Liquid-based indexing due to DeltaSearch's bugged functionality (e.g incorrectly setting article URLs) due to its simple nature.

A new debug watermark format has been introduced with this build, changing the latter from the *Debug Axeon KuroWiki <development phase&gt; Version <version&gt;* format to *Pre-Release Axeon KuroWiki <development phase&gt; Version <version in major.minor format&gt; (Build <version in build.id.lab.timestamp format&gt;)*; additionally, the version format used in the banner has been changed to *Version <Major.Minor&gt; (Build <Build&gt;)*.

A new background has also been introduced with this build, the latter being a photograph taken by KitSixtyFour in February 2026, additionally as a result of the *MDLAccent* project, objects such as buttons and URLs are colored with the accent color, set by the `--accent` CSS variable within `global.css`.

Within the engine's source code, the website layout is now automatically defined on site build (unless explicitly specified), allowing articles to not require adding `layout: main` to the article's frontmatter, additionally, the `main` layout was renamed to `material` in order to accomodate for custom site layouts, one of the goals of [*Modular Deltari*](Modular_Deltari). Other changes include the site automatically opening itself in a browser and enabling *Live Reload* mode upon running `bundle exec jekyll server`.

# Bugs and quirks
Although not shown, the site may fail to load certain pages due to merge conflicts between the `kitsixtyfour` and `kayaurora` branches. Technically speaking, articles that originate from the `kayaurora` branch still had `layout: main` included in their frontmatters. The `main` layout was renamed to `material` sometime after *Modular Deltari* was merged back to the `kitsixtyfour` branch.

# Gallery
<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/kurowiki4546/banner.png" 
        caption="The site homepage with the drawer open." %}
    {% include gallery_item.html 
        image_src="resources/img/articles/kurowiki4546/article.png" 
        caption="Article view." %}
    {% include gallery_item.html 
        image_src="resources/img/articles/kurowiki4546/console.png" 
        caption="The console output of the site build, showing the version banners and the DeltaSearch notice." %}
</div>

# Notes
[^1]: Buffer branches are always suffixed with `_N`, just like Microsoft Windows builds used to do until Windows Longhorn post-reset.