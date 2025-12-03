---
title: Contributing to KuroWiki
layout: main
permalink: Contributing_to_KuroWiki
search_exclude: true
---

Welcome to KuroWiki! This article should teach you how to contribute to the wiki, by adding articles!

KuroWiki is a community-mantained project, so we always welcome people trying to help us out. First things first, you'd need to know some things.

# Requisites

As the wiki is freely hosted on GitHub, you need a GitHub account to commit your files.

# Code of Conduct

To prevent any sort of unwanted articles or behavior, we have a code of conduct to help regulate these issues, these are needed guidelines to add, publish and modify articles.

You may not:

- add nor publish 18+/mature content to any of the articles.
- go out of topic in your article.
- modify other articles without permission.
- vandalize any of the articles.
- add false information to articles, nor make fake articles.
- cross personal boundaries, if some info gets too personal, please remove said content as of the person's request. (this also applies to admins)
- add anything that is not related to the Axeon Network, KayAurora or Nekori. 

# Creating your article

Now that you know the necessary stuff, you (like most people will do) will start making your article. This *will* get technical, wiking is no easy thing to do!

To get started, clone the GitHub repository of KuroWiki. If you have Git installed, you can run `git clone {{ site.sourceurl }}` in your desired console. You can also clone the repo via GitHub Desktop or the web interface.

## File setup

Now that you've cloned the source code of KuroWiki, head over to the `articles` directory inside the `pages` directory in your source folder, as you've might seen, all of the articles you see on KuroWiki are in the Markdown file format, with a file extension of `.md`.

Ideally, a short file name will do, as you can set the URL of your article in the frontmatter of the file itself.

The frontmatter is a way to setup the article, it holds most of the necessary information of the article for use with the KuroWiki engine (code named *Deltari*). A full example of the frontmatter would be this (dont worry, we will explain what each setting does later): 

`---`
`layout: main`
`title: Hello, world!`
`permalink: Hello,_world!`
`hatnote: Lorem ipsum dolor sit amet`
`aliases:`
`- Alias 1`
`- Alias 2`
`- Lorem ipsum`
`redirect_from:`
`- Hello_world!`
`- Hello,world!`
`- Hello,_world`
`- Hello,world`
`---`

So, what do all these colons and dashes mean? These "colons and dashes" are the setup parameters of your article, if you want your article to actually..work, you need to add this to the start of your article, before the content itself.

### **Definitions**

`layout`: This defines the layout that the page is going to use. **Always** set this to `main`. **This setting is required**.

`title`: The title of your page, self-explanatory. **This setting is required**.

`permalink`: The URL of your article. As with every other URL, it must not contain spaces. You can use underscores as a replacement instead. **This setting is required**.

`hatnote`: The hatnote of the page. This setting is optional.

`aliases`: Used with the search engine (code named *DeltaSearch*), this can be used to allow the page to come up in the search results with a query that is somewhat close to the page title, for example, you can search "DHI" and [Dogui Heavy Industries Incorporated](Dogui_Heavy_Industries_Incorporated) will show up.

`redirect_from`: Alluding to its name, you can set what pages should redirect to your article. This can be useful to replace dead links (like `Horibyte_Arctic` for [Nekori Arctic](Nekori_Arctic)), or to automatically correct any URL typos (like `ABoard` for [A Board](A_Board)). Redirects might be used for other cases without a specific reason, for example, going to [Comet_Nishi_Adsurden](Comet_Nishi_Adsurden) will redirect you to [Comet](Comet), as "Comet Nishi Adsurden" is Comet's in-universe name.

The dashes above and below the settings define when the frontmatter begins and when it ends. **This is required in order to make the article work**.

## Custom components! (and how to import them)

### Galleries

The gallery item is a way to organize your images in a clean way. This item is compatible with SpringViewer (the KuroWiki media viewer), so whenever you click the image in a gallery frame, SpringViewer will happily open it for you! (unless you incorrectly add the gallery item or image, or you make SpringViewer mad, which is rare to happen (be careful! they are a real grumpy creature)).

A single-frame variant of the item exists for normal image organization.

In order to import this component, you'd need to use the following structure:

<code>
&lt;div class="wiki-gallery"><br><br>
{&percnt; include gallery_item.html<br>
image_src="resources/img/articles/helloworld/untitled.png"<br>
caption="Lorem ipsum dolor sit amet..." &percnt;}<br>
{&percnt; include gallery_item.html<br>
image_src="resources/img/articles/helloworld/untitled2.webp"<br>
caption="...consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." &percnt;}<br>
{&percnt; include gallery_item.html<br>
image_src="resources/img/articles/helloworld/untitled3.jpg"<br>
caption="Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." &percnt;}<br><br>
&lt;/div>
</code>

...which would end up being this!

<div>
{% include figure_item.html 
    image_src="resources/img/articles/contributing/gallery.png" 
    style="width:50%;" %}
    </div>

You can change these variables to your liking!

To import the single-item frame, you'd need to use this:

<code>
{&percnt; include figure_item.html<br>
image_src="resources/img/articles/helloworld/untitled.png"<br>
caption="Lorem ipsum dolor sit amet..." &percnt;}<br>
</code>

### Infoboxes
The infobox item is usually located on the right side of the page, and includes a quick summary of what's presented in a specific article, similarily to other wikis.

Currently upstream Deltari/KuroWiki supports the `build` type of infobox, which is usually used on versions of projects that use a versioning scheme similar to KuroWiki's. An example is shown here:

<code>
{&percnt; include infoboxes/build.html<br>
family='KuroWiki'<br>
familyurl='KuroWiki'<br>
buildtag='6.0.3933.nekori64.251027-1830'<br>
version='6.0'<br>
build='3933'<br>
lab='nekori64'<br>
compiled='2025-10-27 18:30 UTC-6'<br>
image='resources/img/articles/horiwiki/article.png'<br>
&percnt;}
</code>

The end result of the above example is this:

<div>
{% include figure_item.html 
    image_src="resources/img/articles/contributing/infobox.png" 
    style="width:30%;" %}
  </div>

Just like with the gallery, you can change these variables to your liking! Just make sure the infobox item is located just after the frontmatter but before the actual page content!

### Hatnotes


# Sumbitting your article