---
title: Axeon Akane
permalink: Akane
redirect_from: Deltari
hatnote: "This article is a stub and will be probably finished in Release Candidate 2."
---

**Axeon Akane** (formerly Axeon Deltari, the KuroWiki Engine, LexWiki Engine, and HoriWiki Engine) is a free and open source (FOSS) encyclopedia engine built and developed by the [Axeon Network](Axeon_Network). It is primarily used in [KuroWiki](KuroWiki), but it can be used by anyone for their own personal use. Its source code is licensed under Creative Commons Share-Alike 4.0 International, and can be viewed over at [github.com/Axeon-Network/Akane](https://github.com/Axeon-Network/Akane).

The Akane engine was created by [KitSixtyFour](KitSixtyFour) in May 2025 following the rejection of a request for a Miraheze-based wiki, which shorly began the development of [KuroWiki](KuroWiki) (known back-then as *HoriWiki*) and its engine.

Akane uses the Jekyll static site generator for compatibility with [GitHub Pages](https://pages.github.com), which is one of the many goals of the project. It uses components such as [SpringViewer](SpringViewer), a media viewer written in JavaScript, [AkaneSearch](AkaneSearch) for searching articles, and (by default) the [Material Design Lite](https://github.com/google/material-design-lite) CSS framework for its user interface. However, Akane is modular by design, which means that it can be modified without extreme reliance on other components, and can even be used with [a from-scratch layout](Nyxeon).

# Implemetations
## KuroWiki
{% include items/hatnote.html content='For more information, see [Axeon KuroWiki](KuroWiki).'%}
**KuroWiki** (formally **Axeon KuroWiki**) is an online encyclopedia developed by the Axeon Network, originally created on May 2025. It is the commonplace implementation of the Akane engine, and is the primary use of the engine itself. As of June 2026, KuroWiki and Akane are developed together, similar to Chrome and Chromium.
<div class="wiki-gallery">
{% include items/gallery.html image_src='res/img/articles/kurowiki4450/home.png' caption='A screenshot of the home page of KuroWiki' %} <!-- todo: change it to 5200 when it gets compiled -->
</div>

# Akane Meta
**Akane Meta** is the "reference implementation" of the Akane engine, initially started on 13 January 2026 with the compilation of [Deltari build 4500](Deltari_build_4500). A downstream of KuroWiki, earlier builds of Deltari Meta have been compiled under the `main` branch before it switched to its own `aknmeta` branch (formerly `dmeta_N`), which would receive Akane updates periodically.

The wiki itself mainly provides documentation and other useful information about Akane.

<div class="wiki-gallery">
{% include items/gallery.html 
        image_src="res/img/articles/deltari4584/home.png" 
        caption="Deltari Meta homepage"
        style="width:40%; height:auto" %}
</div>
<!-- todo: change to an updated homepage -->
