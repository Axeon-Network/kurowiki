---
layout: main
title: Home
permalink: ./ # i interrupted my housepets reading time just for this
              # i'm at the november 17 2008 issue
search_exclude: true
hatnote: This is beta software! Please report any issues you may find through <a href="https://github.com/Axeon-Network/kurowiki/issues">GitHub Issues</a> or on our <a href="/discord">Discord Server</a>
---

<script src="./resources/js/dyk.js"></script>
<!-- todo: literally move this to a separate JS file thanku -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
    const container = document.getElementById("feat-article-container");
     {% assign featured = site.pages | where: "path", "pages/articles/astront.md" | first %}
    // i changed it to dhi to test
  const pick = {
        url: "{{ featured.url | relative_url }}",
        title: {{ featured.title | jsonify }},
        excerpt: {{ featured.content | markdownify | split:'<h' | first | split:'<img' | first | truncatewords: 250 | jsonify }}
      };
    if (container) {
      container.innerHTML = `
        <a id="pagetitle" style="color:var(--kurowiki-accent); padding-bottom:10px;" class="mdl-layout-title" href="${pick.url}">${pick.title}</a>
        ${pick.excerpt}<a href="${pick.url}">Full article</a>.
      `;
    }
  })
</script>

<style>
    hr, #pagetitle {
        display: none !important;
    }
</style>

<h1 style="color:var(--kurowiki-accent)">Welcome to KuroWiki</h1>

<!-- actual homepage description -->
<!-- <p class="homepage-description">Some temporary string here....<br>TODO: add a proper description</p> -->
<p class="homepage-description">This is the home page for KuroWiki. An online encyclopedia about the Axeon Network and its administrators (Nekori and KayAurora).<br>You can use the drawer or the search bar to browse the contents of this wiki!</p>

<!-- cards to make the homepage complete™ -->
{% include homepage_cards.html %}
