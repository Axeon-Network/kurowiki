---
layout: main
title: Development of KuroWiki
permalink: Development_of_KuroWiki
hatnote: This article details about the development of KuroWiki, for the main KuroWiki article, see <a href="KuroWiki">KuroWiki</a>
---

Initial concepts for [KuroWiki](/KuroWiki) existed as early as April 2025 with the goal of creating a resource to easily get information about Nekori's projects and related content.

Several options were being considered by [Nekori](/Nekori) such as a self-hosted MediaWiki server, but Nekori was unsure how to make it work. A Miraheze-hosted wiki was also taken in consideration between **May 1-3 2025**, however this option was also taken off the table due to the Miraheze bot not cooperating.
As such, the final decision was to start a custom-built wiki core from the ground up, dubbed "**Deltari**" (initially known as *HoriWiki Engine*, and then as *LexWiki Engine* and *KuroWiki Engine* respectively)

KuroWiki went through [development hell](https://en.wikipedia.org/wiki/Development_hell).

##### May 2025: Main Engine Development
---

Development of Deltari began with forking [HoriWebsite](LexSite) version **2.4.3565**, as creating new pages with Jekyll within the existing framework would cause issues. Here are the earliest available screenshots of that fork:

<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/earliest_developer_pre-alpha.png" 
        alt_text="Screenshot of an early developer alpha of Horiwiki, showing a branch change from 'main' to 'main-wik' and the website title being changed to 'HoriWiki'." 
        caption="Screenshot of an early developer alpha of Horiwiki, showing a branch change from 'main' to 'main-wik' and the website title being changed to 'HoriWiki'."
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/devalpha-info.png" 
        alt_text="Debug build string from the KuroWiki Pre-alpha engine." 
        caption="Debug build string from the KuroWiki Pre-alpha engine."
        style="width:50%;" %}
</div>

#### Milestone 1, 2 and 3 (Pre-Alpha) and Alpha
---

With the existing HoriWebsite frontend code stripped off, the basic code for the Deltari engine was thrown up together in just two days, reaching Pre-Alpha status by May 4 2025.
*Image quality in the following screenshots may vary as they were taken from Discord messages sent by Nekori or others.*

##### May 4, 2025:
---

##### Pre-alpha 0.1
---

This build essentially removed most of the HoriWebsite's front-end elements, though some underlying HoriWebsite code still remained.
<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/pa0.1.png" 
        alt_text="Pre-alpha 0.1" 
        caption="Pre-alpha 0.1"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/pa0.1-1.png" 
        alt_text="Pre-alpha 0.1" 
        caption="Pre-alpha 0.1"
        style="width:50%;" %}
</div>

##### Pre-alpha 0.2
---

This version shows early attempts to implement MediaWiki-style navigation bars.
{% include figure_item.html 
    image_src="resources/img/articles/horiwiki/pa0.2.png" 
    alt_text="Pre-alpha 0.2" 
    caption="Pre-alpha 0.2"
    style="width:50%;" %}

##### Pre-alpha 0.3
---

Navigation bars were partially implemented in this build, using multi-colored segments to aid in debugging.
{% include figure_item.html 
    image_src="resources/img/articles/horiwiki/pa0.3.png" 
    alt_text="Pre-alpha 0.3" 
    caption="Pre-alpha 0.3"
    style="width:50%;" %}

##### Pre-alpha 0.4
---

Pre-alpha 0.4 is where KuroWiki began to take on its distinct form, with several key elements nearing completion.
{% include figure_item.html 
    image_src="resources/img/articles/horiwiki/pa0.4.png" 
    alt_text="Pre-alpha 0.4" 
    caption="Pre-alpha 0.4"
    style="width:50%;" %}

##### Pre-alpha 0.5.x
---

Builds 0.5.x were the most complete builds of that day, with nearly all essential components implemented correctly.
<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/pa0.5.png" 
        alt_text="Pre-alpha 0.5" 
        caption="Pre-alpha 0.5"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/pa0.5.2.png" 
        alt_text="Pre-alpha 0.5.2" 
        caption="Pre-alpha 0.5.2"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/pa0.5.2-1.png" 
        alt_text="Pre-alpha 0.5.2 1" 
        caption="Pre-alpha 0.5.2 1"
        style="width:50%;" %}
</div>

##### May 5, 2025:
---

##### Pre-alpha 0.5.3
---

Build 0.5.3 was the most feature-complete pre-alpha build, with most important elements already in place.
{% include figure_item.html 
    image_src="resources/img/articles/horiwiki/pa0.5.3-anaheim.png" 
    alt_text="Pre-alpha 0.5.3" 
    caption="Pre-alpha 0.5.3"
    style="width:50%;" %}

##### May 6-7, 2025:
---

##### Alpha 1.1
---

This was the first Alpha version of KuroWiki, introducing significant updates to the Deltari engine. Backend engine code was extensively cleaned up and polished, with **Markdown** now supported for convenience. Most fixes were contributed by **KayAurora**.
{% include figure_item.html 
    image_src="resources/img/articles/horiwiki/a1.1.png" 
    alt_text="Alpha 1.1" 
    caption="Alpha 1.1"
    style="width:50%;" %}

##### Alpha 1.2
---

As with the previous version, this update focused on further bug fixes and refinements of the engine.
<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/a1.2-home.png" 
        alt_text="Alpha 1.2" 
        caption="Alpha 1.2"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/a1.2-dirlist.png" 
        alt_text="The Sitemap in Alpha 1.2" 
        caption="The Sitemap in Alpha 1.2"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/a1.2-cthrwd.png" 
        alt_text="Contributing to HoriWiki in Alpha 1.2" 
        caption="Contributing to HoriWiki in Alpha 1.2"
        style="width:50%;" %}
</div>

#### Beta
---
Development after the initial Alpha phases rapidly progressed into Beta stages. The initial **Beta 1.0** release from **7 May 2025** introduced changes to the frontend, and proper support for mobile sizes.

{% include figure_item.html 
    image_src="resources/img/articles/horiwiki/b1.0-m.png" 
    alt_text="Beta 1.0's mobile UI" 
    caption="Beta 1.0's mobile UI"
    style="width:50%;" %}

**Beta 2.0** did away with the Alpha frontend layout, introducing a more 2014 Material Design-style UI using the **Material Design Lite** (MDL) CSS framework, significantly enhancing the wiki's visual appearance and user interface. It is to be noted that the Material design has been in development since **beta 1.0.1**, which initially came with the old design.
June 2025 then saw the release of **Beta 2.1**, introducing new features such as **functional search capabilities** and a **Wikipedia-styled "Did You Know" section**, further completing the KuroWiki homepage. This was also the final version under the wiki's initial **HoriWiki** naming.

<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/b1.0.1-material.png" 
        alt_text="Beta 1.0.1 Material" 
        caption="Beta 1.0.1 Material"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/horiwiki/b1.0.1-search.png" 
        alt_text="Search in Beta 2.0" 
        caption="Search in Beta 2.0"
        style="width:50%;" %}
</div>

July 2025 saw work undergone on **Beta 3.0**, introducing further enhancements to the MDL frontend and article wording. This version also reflects on the then-recent rebranding from Horibyte to Lexibyte, with the wiki now known as *LexWiki* around this time.

September 2025 saw the LexWiki project become part of the [Axeon Network](/Axeon_Network). As part of this change, LexWiki rebranded once more to its current name of **KuroWiki** and the engine saw its name renamed as well to **Deltari**. Nekori would remain involved in the project, but the wiki's scope would expand beyond Nekori-related stuff and side projects to a more wide variety of topics. Existing references to Lexibyte have changed to Nekori.
The first version of KuroWiki under Axeon was **Beta 4.0**, bringing significant changes and even rewrites to existing pages of the wiki, while adding other new pages and enhancements.

In late September 2025, the Axeon Network publicly released its first public KuroWiki version, 5.1.2600.main.250928-0955 (also jokingly named **KuroWikiXP** due to the version string). The first build of the **Beta 5.x** series, this is the first public KuroWiki release since early June 2025.

As of October 2025, work has shifted to Beta 5.2, introducing even more new articles and changes. Build 3505 finally did away of the LexTheNova-esque background and replaced it with a changing background. [Build 3567](KuroWiki_build_3567_(kayaurora)) introduced the *Featured Articles* box in the homepage. Two Interim Developer Releases came out during this time: [Build 3615](KuroWiki_build_3615) and [Build XXXX](KuroWiki_build_XXXX), which replaced the changing background with a permanent background, redesigned the homepage and introduced DeltaSearch 2.0, which by itself brought over improvements to KuroWiki search.

<div class="wiki-gallery">
       {% include gallery_item.html 
         image_src="resources/img/articles/horiwiki/b5.2-kayaurora.png" 
         alt_text="Homepage of beta 5.2, build 3505" 
         caption="Homepage of beta 5.2, build 3505"
         style="width:50%;" %}

       {% include gallery_item.html 
         image_src="resources/img/articles/kurowikibuild3567-ka/home.png" 
         alt_text="Homepage of beta 5.2, build 3567" 
         caption="Homepage of beta 5.2, build 3567"
         style="width:50%;" %}

       {% include gallery_item.html 
         image_src="resources/img/articles/horiwiki/b5.2.3615.png" 
         alt_text="Homepage of beta 5.2, build 3615, the Interim Developer Release 1" 
         caption="Homepage of beta 5.2, build 3615, the Interim Developer Release 1"
         style="width:50%;" %}
</div>