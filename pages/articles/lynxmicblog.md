---
layout: main
title: Lynxmic Blog
permalink: Lynxmic_Blog
aliases:
    - lynxblog
hatnote:
---
{% include infoboxes/site.html
name="Lynxmic Blog"
formername=''
developer='KayAurora'
developerarticle='KayAurora'
writtenin='HTML/CSS/JS, Ruby+Jekyll'
type='Personal Blog'
initialVersion='November 2021 Release'
initialVersionReleaseDate='2021-11-21'
currentVersion='April 2024 Release'
currentVersionReleaseDate='2024-04-25'
sourceModel='Open source'
repoLink='https://github.com/thekayaurora/lynxblog'
repoHost='GitHub'
status='Source code archived; website unavailable'
link='https://lynxmic.github.io/blog'
image='resources/img/articles/lynxmicblog/02-06-2024.png'
%}

**Lynxmic Blog**, sometimes known as **LynxBlog** or previously after its URL address (**lynxmic.github.io**, prior to [LynxWebsite](LynxWebsite)'s launch) was [KayAurora](KayAurora)'s personal blog between 2021 and 2024, hosted on GitHub Pages and powered by Jekyll.

It initially used the MDBootstrap CSS framework for its first iteration used since the launch in 21 November 2021.
An improved website layout using the Bulma CSS framework was rolled out on 1 January 2023, dubbed the "*Bulma revamp*" by KayAurora on social media as the second Lynxmic Blog iteration, followed by a third and final one on 25 April 2024 which brought the layout to consistency with LynxWebsite.

The Lynxmic Blog was officially discontinued on 23 July 2024, with its spiritual successor being the [KayWebsite](KayWebsite) blog.

Overall, the GitHub repo for the Lynxmic Blog saw over 500 commits up over time, the largest number compared to other repositories on KayAurora's personal account. This is attributed to KayAurora using GitHub's web interface for everything instead of using Git or GUI wrappers like GitHub Pages.

<div class="wiki-gallery">
       {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/logo1.png" 
        alt_text="Lynxmic Blog logo used from November 2021 to May 2023" 
        caption="Lynxmic Blog logo used from November 2021 to May 2023"
        style="width:50%;" %}
        {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/logo2.png" 
        alt_text="Lynxmic Blog logo used from May to December 2023" 
        caption="Lynxmic Blog logo used from May to December 2023"
        style="width:50%;" %}
</div>

# First iteration (2021-22)
Plans for a new Lynxmic Blog have existed as early as May 2021, when KayAurora announced on the [Axeon Network](Axeon_Network) Discord Server that they were retiring their existing blog on Medium that has been in use since March 2018

> *Medium is no longer the same free platform as how it was in 2018 (when I began using it); there have been improvements to it over time since I've been last active, but its paywall after reading a few stories per month (similar to some news media websites) became a large con of the website.*

*-KayAurora (then Lynxmic), on retiring their Medium Blog, 24 May 2021*

Actual work started in early November 2021. KayAurora had several options but then resorted to building a blog from scratch using the [Jekyll](https://jekyllrb.com) static site generator that would be hosted on GitHub Pages, instead of using a dedicated platform like Blogger or WordPress.

The Lynxmic Blog GitHub repository existed as early as January 2021 under the name `venus-bot`, suggesting the repo's original purpose was to host the source code of an eventual revival of the [Venus](Venus) Discord Bot project, later abandoned.
The repo later saw its name change from `venus-bot` to `blog-project` as blog development started. Later on, the project README was changed to replace the `blog-project` heading with "*Lynxmic website (New Lynxmic Blog)*", which would later change to just *Lynxmic Blog*. Around the same time a placeholder website was set up on `lynxmic.github.io`, where the blog would eventually be accessible at.

The process of designing and building the Lynxmic Blog was span over the course of a few days, having been finally finished and announced on 21 November 2021, with KayAurora's first blog post since 2019 having been written the same day.

A month later, in December 2021, a set of updates was rolled out, including a Share button, which initially had two choices for Twitter and manual copying to the clipboard for other platforms. It also removed the "View old blog posts" button at the end, with all old blog posts still archived from KayAurora's previous blogs added to Lynxmic Blog. Additionally a rudimentary but broken initial pagination implementation was added but was then removed in November 2022.

The blog would continue to receive occasional updates in 2022 to adapt to changes to branding and what social media platforms are being linked to, but would remain mostly inactive new post-wise aside from Lynxmic project updates and related.

<div class="wiki-gallery">
       {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/placeholdersite.png" 
        alt_text="A placeholder page, used while the Lynxmic Blog was under development in 2021" 
        caption="A placeholder page, used while the Lynxmic Blog was under development in 2021"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/21-11-2021.png" 
        alt_text="Initial iteration of the Lynxmic Blog, 21 November 2021" 
        caption="Initial iteration of the Lynxmic Blog, 21 November 2021"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/14-04-2022.png" 
        alt_text="Lynxmic Blog, 14 April 2022. Fonts have been switched up and the navbar has been simplified." 
        caption="Lynxmic Blog, 14 April 2022. Fonts have been switched up and the navbar has been simplified."
        style="width:50%;" %}

            {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/14-04-2022-footer.png" 
        alt_text="Footer of the Lynxmic Blog on 14 April 2022. Visible is a broken pagination implementation and social media buttons" 
        caption="Footer of the Lynxmic Blog on 14 April 2022. Visible is a broken pagination implementation and social media buttons"
        style="width:50%;" %}

            {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/23-11-2022.png" 
        alt_text="Lynxmic Blog just over a year after launch, 23 November 2022. Logo centering was fixed" 
        caption="Lynxmic Blog just over a year after launch, 23 November 2022. Logo centering was fixed"
        style="width:50%;" %}

            {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/23-11-2022-footer.png" 
        alt_text="Footer of the Lynxmic Blog on 23 November 2022. Pagination was removed, and Mastodon was added in place of Reddit" 
        caption="Footer of the Lynxmic Blog on 23 November 2022. Pagination was removed, and Mastodon was added in place of Reddit"
        style="width:50%;" %}
</div>

# Second iteration (2023-April 2024)
In December 2022, KayAurora began to share over Mastodon/Fediverse sneak peeks of a new "Bulma revamp" of the Lynxmic Blog, a major design overhaul which aimed at giving it a fresh, better look. It was also officially revealed that Lynxmic Blog was also available over RSS, which was only starting to get relevant again (at least in Kay's POV) - the RSS feed was always there the whole time but was left unused and undocumented.

This design saw major changes later on in February, May and July 2023, and then in January 2024 to coincide with the then-new Lynxmic branding.

In August 2023, the Lynxmic Blog moved under `/blog` as [LynxWebsite](LynxWebsite) took over the root of `lynxmic.github.io`.

<div class="wiki-gallery">
       {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/09-01-2023.png" 
        alt_text="The Lynxmic Blog on 9 January 2023" 
        caption="The Lynxmic Blog on 9 January 2023"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/21-05-2023.png" 
        alt_text="The Lynxmic Blog on 21 May 2023" 
        caption="The Lynxmic Blog on 21 May 2023"
        style="width:50%;" %}

    {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/31-10-2023.png" 
        alt_text="The Lynxmic Blog on 31 October 2023" 
        caption="The Lynxmic Blog on 31 October 2023"
        style="width:50%;" %}

            {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/19-04-2024.png" 
        alt_text="The Lynxmic Blog on 19 April 2024" 
        caption="The Lynxmic Blog on 19 April 2024"
        style="width:50%;" %}
</div>

# Third iteration (April-July 2024)
A complete overhaul of the Lynxmic Blog was made in April 2024 using the then-newly-released v1 of the Bulma CSS framework, bringing the blog's layout in consistency with LynxWebsite, which was also updated at the same time from a scroll layout to a tabbed layout.

Despite that the Lynxmic Blog and LynxWebsite continued to have separate codebases from each other, this iteration of the Lynxmic Blog (which also fixed many issues the previous one had) functionally worked as a "part" of LynxWebsite, with even the Dark/Light Mode setting option from there applying here.

That said, this Lynxmic Blog iteration was rather short-lived as in July 2024, the blog was merged with the rest of the website as part of the [KayWebsite](KayWebsite) project. The Lynxmic Blog continued to be accessible for historical purposes under KayAurora's new website domain.

<div class="wiki-gallery">
       {% include gallery_item.html 
        image_src="resources/img/articles/lynxmicblog/02-06-2024.png" 
        alt_text="The Lynxmic Blog on 2 June 2024" 
        caption="The Lynxmic Blog on 2 June 2024"
        style="width:50%;" %}
</div>