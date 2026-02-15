---
title: Home
permalink: ./ # i interrupted my housepets reading time just for this
              # i'm at the november 17 2008 issue
search_exclude: true
hatnote: This is beta software! Please report any issues you may find through <a href="https://github.com/Axeon-Network/kurowiki/issues">GitHub Issues</a> or on our <a href="/discord">Discord Server</a>
---

<script src="./resources/js/dyk.js"></script>
<!-- todo: literally move this to a separate JS file thanku -->
<!-- this script took several sessions of bashing my head against the computer -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  const container = document.getElementById("feat-article-container");
  {% assign featuredpath = "pages/articles/" | append: site.featuredarticle | append: ".md" %}
  {% assign featured = site.pages | where: "path", featuredpath | first %}
  const pick = {
    url: "{{ featured.url | relative_url }}",
    title: {{ featured.title | jsonify }},
    excerpt: {{ featured.content
      | markdownify
      | split:'<h' | first
      | split:'<img' | first
      | truncatewords: 256
      | jsonify }}
  };
  function removeInfobox(html) {
    if (!html) return '';
    const openTag = '{' + '%';
    const closeTag = '%' + '}';
    const openVar = '{' + '{';
    const closeVar = '}' + '}';
    const liquidRegex = new RegExp('(' + openTag + '[\\s\\S]*?' + closeTag + '|' + openVar + '[\\s\\S]*?' + closeVar + ')', 'g');
    html = html.replace(liquidRegex, '');
    html = html.replace(/<div[^>]*class=["']?infobox[^>]*>[\s\S]*?<\/div>/gi, '');
    html = html.replace(/^(?:\s*<[^>]+>)+/i, '').trim();
    return html;
  }
  const excerpt = removeInfobox(pick.excerpt);
      if (container) {
            if (excerpt) {
      container.innerHTML = `
        <a id="pagetitle" style="color:var(--kurowiki-accent); padding-bottom:10px;" class="mdl-layout-title" href="${pick.url}">${pick.title}</a>
        <p>${excerpt}<a href="${pick.url}">Full article</a>.</p>
      `;
    }}
})
</script>


<style>
    hr, #pagetitle {
        display: none !important;
    }
</style>

<h1 style="color:var(--kurowiki-accent)">Welcome to KuroWiki!</h1>

<!-- actual homepage description -->
<p class="homepage-description">{{ site.home_desc }}<br>You can use the drawer or the search bar to browse the contents of this wiki!</p>

<!-- cards to make the homepage complete™ -->
{% include homepage_cards.html %}
