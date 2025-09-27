---
layout: main
title: Development of KuroWiki
permalink: Development_of_KuroWiki
hatnote: This article details about the development of KuroWiki, for the main KuroWiki article, see <a href="KuroWiki">KuroWiki</a>
---

Initial concepts for [KuroWiki](/KuroWiki) existed as early as April 2025 with the goal of creating a resource to easily get information about Nekori's projects and related content.

Several options were being considered by [Nekori](/Nekori) such as a self-hosted MediaWiki server, but Nekori was unsure how to make it work. A Miraheze-hosted wiki was also taken in consideration between **May 1-3 2025**, however this option was also taken off the table due to the Miraheze bot not cooperating.
As such, the final decision was to start a custom-built wiki core from the ground up, dubbed "**Deltari**" (initially known as *HoriWiki Engine*, and then as *LexWiki Engine* and *KuroWiki Engine* respectively)

##### May 2025: Main Engine Development
---

Development of Deltari began with forking [HoriWebsite](LexSite) version **2.4.3565**, as creating new pages with Jekyll within the existing framework would cause issues. Here are the earliest available screenshots of that fork:

![a screenshot of the earliest developer alpha of horiwiki, changing the branch from main to main-wik and changing the website title to horiwiki](resources/img/articles/horiwiki/earliest_developer_pre-alpha.png){: style="width:60%;" title="Screenshot of an early developer alpha of Horiwiki, showing a branch change from 'main' to 'main-wik' and the website title being changed to 'horiwiki'."}
![KuroWiki Pre-alpha engine debug buil string](resources/img/articles/horiwiki/devalpha-info.png){: style="width:50%;" title="Debug build string from the KuroWiki Pre-alpha engine."}

#### Milestone 1, 2 and 3 (Pre-Alpha) and Alpha
---

With the existing HoriWebsite frontend code stripped off, the basic code for the Deltari engine was thrown up together in just two days, reaching Pre-Alpha status by May 4 2025.
*Image quality in the following screenshots may vary as they were taken from Discord messages sent by Nekori or others.*

##### Builds Compiled on May 4, 2025:
---

###### Pre-alpha 0.1
---

![pre-alpha 0.1](resources/img/articles/horiwiki/pa0.1.png){: style="width:50%;"}
![pre-alpha 0.1](resources/img/articles/horiwiki/pa0.1-1.png){: style="width:50%;"}
This build essentially removed most of the HoriWebsite's front-end elements, though some underlying HoriWebsite code still remained.

###### Pre-alpha 0.2
---

![pre-alpha 0.2](resources/img/articles/horiwiki/pa0.2.png){: style="width:50%;"}
This version shows early attempts to implement MediaWiki-style navigation bars.

###### Pre-alpha 0.3
---

![pre-alpha 0.3](resources/img/articles/horiwiki/pa0.3.png){: style="width:50%;"}
Navigation bars were partially implemented in this build, using multi-colored segments to aid in debugging.

###### Pre-alpha 0.4
---

![pre-alpha 0.4](resources/img/articles/horiwiki/pa0.4.png){: style="width:50%;"}
Pre-alpha 0.4 is where KuroWiki began to take on its distinct form, with several key elements nearing completion.

###### Pre-alpha 0.5.x
---

![pre-alpha 0.5](resources/img/articles/horiwiki/pa0.5.png){: style="width:50%;"}
![pre-alpha 0.5.2](resources/img/articles/horiwiki/pa0.5.2.png){: style="width:50%;"}
![pre-alpha 0.5.2 1](resources/img/articles/horiwiki/pa0.5.2-1.png){: style="width:50%;"}
Builds 0.5.x were the most complete builds of that day, with nearly all essential components implemented correctly.

##### Builds Compiled on May 5, 2025:
---

###### Pre-alpha 0.5.3
---

![pre-alpha 0.5.3](resources/img/articles/horiwiki/pa0.5.3-anaheim.png){: style="width:50%;"}
Build 0.5.3 was the most feature-complete pre-alpha build, with most important elements already in place.

##### Builds Compiled on May 6-7, 2025:
---

###### Alpha 1.1
---

![alpha 1.1](resources/img/articles/horiwiki/a1.1.png){: style="width:50%;"}
This was the first Alpha version of KuroWiki, introducing significant updates to the Deltari engine. Backend engine code was extensively cleaned up and polished, with **Markdown** now supported for convenience. Most fixes were contributed by **KayAurora**.

###### Alpha 1.2
---

![alpha 1.2](resources/img/articles/horiwiki/a1.2-home.png){: style="width:50%;"}
![alpha 1.2 sitemap](resources/img/articles/horiwiki/a1.2-dirlist.png){: style="width:50%;"}
![alpha 1.2 docs file](resources/img/articles/horiwiki/a1.2-cthrwd.png){: style="width:50%;"}
As with the previous version, this update focused on further bug fixes and refinements of the engine.

#### Beta
---
Development after the initial Alpha phases rapidly progressed into Beta stages. The initial **Beta 1.0** release from **7 May 2025** introduced changes to the frontend, adding proper support for mobile sizes.

![beta 1.0 mobile screenshot](resources/img/articles/horiwiki/b1.0-m.png){: style="width:50%;"}

**Beta 2.0** did away with the Alpha frontend layout, introducing a more 2014 Material Design-style UI using the **Material Design Lite** (MDL) CSS framework, significantly enhancing the wiki's visual appearance and user interface.
June 2025 saw the release of **Beta 2.1**, introducing new features such as **functional search capabilities** and a **Wikipedia-styled "Did You Know" section**, further completing the KuroWiki homepage. This was also the final version under the wiki's initial **HoriWiki** naming.

July 2025 saw the release of **Beta 3.0**, introducing further enhancements to the MDL frontend and article wording. This version also reflects on the then-recent rebranding from Horibyte to Lexibyte, with the wiki now known as *LexWiki* around this time.

September 2025 saw the LexWiki project become part of the [Axeon Network](/Axeon_Network). As part of this change, LexWiki rebranded once more to its current name of **KuroWiki** and the engine saw its name renamed as well to **Deltari**. Nekori would remain involved in the project, but the wiki's scope would expand beyond Nekori-related stuff and side projects to a more wide variety of topics. Existing references to Lexibyte would change to Nekori.
The first version of KuroWiki under Axeon was **Beta 4.0**, bringing significant changes and even rewrites to existing pages of the wiki, while adding other new pages and enhancements.