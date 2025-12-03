---
layout: main
title: KuroWiki build 3615
permalink: KuroWiki_build_3615
aliases:
    - kurowiki 3615
---
{% include infoboxes/build.html
family='KuroWiki'
familyurl='KuroWiki'
buildtag='5.2.3615.main.251011-0412'
version='5.2'
build='3615'
lab='main'
compiled='2025-10-10 19:12 UTC-6'
image='resources/img/articles/kurowiki3615/home.png'
%}

**KuroWiki build 3615** is the official **Interim Developer Release** of **KuroWiki Beta 5.2**. It was released on 11 October 2025 at 4:12 AM UTC+3 (7:12 PM UTC-6 the day before). It was released as a way to merge the `nekori64` and `kayaurora` developer branches into one, like it was done with [build 2600](KuroWiki_build_2600).

It is jokingly codenamed in the version information as KuroWikiXP due to its version number of 5.2 being identical to the Windows NT kernel version used in Windows Server 2003 and XP x64. The codename of *KuroWiki XP 2002 Server .NET Advanced Web Datacenter Blade Server Limited Edition 2003* was used as a way to mock the many names [Windows Server 2003](http://betawiki.net/wiki/Windows_Server_2003) used to have between 2001 and 2003."

# Release Notes

## KuroWiki Site

`**KuroWiki Interim Developer Release now available**`

`The public KuroWiki release has been updated to a developer release. This version is mainly public for production testing, bug fixing, and developer branch updates.`

`Specifically, this release was made to merge Nekori’s and KayAurora’s branches to be up to date with a newer version of **KuroWiki Version 5.2** (code named *KuroWiki XP 2002 Server .NET Advanced Web Datacenter Blade Server Limited Edition 2003*).`

`Any comments? We’re all ears! Just report any issue or comment to our Discord server or open an issue in the GitHub repository.`

`Sincerely, The KuroWiki Development Team.`

`10 October 2025, 5:52pm UTC-6`

## Axeon Network

`New KuroWiki Interim Developer Release!`
`This should NOT be considered an official beta release, it's just to merge the two development branches (kayaurora & nekori64) for production testing, bug fixing and developer branch updates.`

`However, as you may notice from the screenshot, there have been very notable changes over the last public release from almost 2 weeks ago, and I'm personally pretty satisfied of the outcome - it looks waaay nicer now, isn't it?`
`We also fixed search and added a further set of articles as well!`

`We're hoping to have KuroWiki reach stable before the end of the year, and we're getting closer to that point ^^`
`https://axeon-network.github.io/kurowiki`

# Changes

- The rest of home page cards have now been added, those being "Featured article" and "Recent news".
	- Recent news was already a thing in KuroWiki Beta 1 and Beta 2, it was commented out when Did you know?'s card was added.
- A new background has been added to the website, replacing the LexTheNova-style one from Beta 3, Beta 4 and build 2600.
- The hatnote present on the homepage has been changed.
- The "Search KuroWiki" text has been made brighter, to contrast better with the new background.
- The fun facts file (`dykdat.json`) has been updated to include more facts

# Bugs

- Clicking on the Next and Previous buttons when viewing an image yeets you to the Search Results page with no query.
- The home page cards extend out of the main content box when the size of the screen is too small

# Gallery

<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/kurowiki3615/home.png" 
        caption="Home Page"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kurowiki3615/homeditto.png" 
        caption="Ditto, recent news collapsed."
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kurowiki3615/drawer.png" 
        caption="The drawer"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kurowiki3615/homebug.png" 
        caption="The home page's card bug."
        style="width:50%;" %}
</div>