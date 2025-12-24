---
title: KayWebsite
permalink: KayWebsite
redirect_from:
    - ClyronWebsite
aliases:
    - kayaurora website
hatnote: For a complete list of KayWebsite versions, see <a href='KayWebsite_version_history'>KayWebsite version history</a>
---
{% include infoboxes/site.html
name='KayWebsite'
formername='ClyronWebsite (2024-2025)'
developer='KayAurora'
developerarticle='KayAurora'
writtenin='HTML/CSS/JS, Astro'
type='Personal Website'
initialVersion='v1.0'
initialVersionReleaseDate='2024-07-23'
currentVersion='v25.11.2'
currentVersionReleaseDate='2025-11-29'
sourceModel='Open source'
repoLink='https://github.com/thekayaurora/thekayaurora.github.io'
repoHost='GitHub'
status='Available'
link='https://kay.is-a.dev'
image='resources/img/articles/kaywebsite/v25.10.png'
%}

**KayWebsite** (also known after its URL name, [kay.is-a.dev](https://kay.is-a.dev)) is [KayAurora](KayAurora)'s personal website. It officially launched on 23 July 2024 as a complete rewrite unifying [LynxWebsite](LynxWebsite) and the [Lynxmic Blog](Lynxmic_Blog) under a single codebase using fully plain HTML+CSS, coinciding with the Clyron-Lynxmic online identity split in the same day.

# History
## Version 1.x
For the first month, the website had a generic rudimentary design using the first Clyron branding's color pallete (then known under the temporary name of "Sunn"/"Sunnville") (*v1.0*).
Plans were for the website layout to eventually evolve into a Win2K-style design, which were essentially completed by late August 2024. This version of the website, then known as **ClyronWebsite**, is retroactively referred to as *v1.1*, which primarily served as a landing page with links to socials and projects with a blog in the website as well. It has been tested to work on ancient browsers as old as Internet Explorer 6.

Further updates were planned to improve the overall design, but they never happened and instead only small changes have been done updating the list of projects and socials as needed.

<div>
    {% include figure_item.html 
        image_src="resources/img/articles/kaywebsite/v1.png" 
        alt_text="ClyronWebsite v1.1 in August 2024" 
        caption="ClyronWebsite v1.1 in August 2024"
        style="width:50%; height:auto" %}
        </div>

## Version 2.x
In October 2024, plans were planted over for a complete rewrite of KayWebsite (then known as **ClyronWebsite**), switching from Jekyll to Astro. The website layout was originally planned to remain as-is but it was decided later on that the website receives a complete redesign using Tailwind CSS.

The development of v2.0 took more than 3 months, mainly due to KayAurora's lack of motivation and interest. An initial public beta released on 11 January 2025 with frequent rolling updates as the rewrite progressed.

v2.0 was finally finished almost a month later, on 9 February 2025, when it replaced v1.1. The final v2 release was v2.5.2 from 8 July 2025.

<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/kaywebsite/v2.0.png" 
        alt_text="ClyronWebsite v2.0, February 2025" 
        caption="ClyronWebsite v2.0, February 2025" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kaywebsite/v2.3.png" 
        alt_text="ClyronWebsite v2.3, April 2025" 
        caption="ClyronWebsite v2.3, April 2025" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kaywebsite/v2.5.2.png" 
        alt_text="ClyronWebsite v2.5.2, July 2025" 
        caption="ClyronWebsite v2.5.2, July 2025" %}
</div>

## Version 3.x
Plans for a ClyronWebsite v3.0 trace back to May 2025, as KayAurora had been considering major changes that mandated a major version number bump, such as dropping Tailwind CSS, thus regaining full control over the CSS, in order to build a Retro Frontend, mainly inspired from [Kit](Kit64)'s [HoriWebsite](HoriWebsite).
Like with the HoriWebsite retro frontend, KayAurora wanted to build one using Microsoft FrontPage 2003, but plans later shifted to just building it on top of the existing Astro ClyronWebsite, to keep maintenence burden low.

Much of v3.0's development happened in July 2025, immediately after v2.5.2's release. The website has undergone a new major visual overhaul, also nicely incorporating the design of the then-fairly-new KayAurora branding.

v3.0 was finished and released on 18 July 2025, with the website now known under its current naming of **KayWebsite**. The Retro Frontend came later on 24 July 2025 with v3.1, [extensively and thoroughly tested](https://kay.is-a.dev/blog/2025-07-24-how-low-can-you-go-browser-compatibility/) for compatibility with ancient browsers. v3.2, released 11 August 2025, primarily focused on fixes and refinements.

v3.3 from 14 September 2025 introduced a new color scheme to go with KayAurora's new visual branding along with a bunch of fixes and improvements. The final v3 release is v3.3.1, released 7 October 2025.

<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/kaywebsite/v3.1.png" 
        alt_text="KayWebsite v3.1, July 2025" 
        caption="KayWebsite v3.1, July 2025" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kaywebsite/v3.3.png" 
        alt_text="KayWebsite v3.3, September 2025" 
        caption="KayWebsite v3.3, September 2025" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/kaywebsite/v3.3-retro.png" 
        alt_text="KayWebsite v3.3 Retro Frontend" 
        caption="KayWebsite v3.3 Retro Frontend" %}
</div>

## Version 25.xx
KayWebsite officially switched from the semantic versioning system (SemVer) to a date versioning system in a year-month-revision format (vYY.MM.R) on 30 October 2025, beginning with the release of v25.10 (originally planned to be released as v3.4). Additionally, the version would be automatically determined through CI/CD on GitHub every time KayWebsite is built in production. The changelog page was also deprecated entirely in favor of the [KayWebsite version history](KayWebsite_version_history) KuroWiki article.

v25.11, released on 6 November 2025, brought various bug fixes and improvements. Similarily, v25.11.1 and v25.11.2 from 19 and 29 November 2025 respectively primarily brought small refinements and updates in pages.

<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/kaywebsite/v25.10.png" 
        caption="KayWebsite v25.10, October 2025" %}
    {% include gallery_item.html 
        image_src="resources/img/articles/kaywebsite/v25.11.2.png" 
        caption="KayWebsite v25.11.2, November 2025" %}
</div>