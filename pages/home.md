---
layout: main
title: Welcome to KuroWiki!
permalink: /Main_Page
search_exclude: true
hatnote: This is beta software! Please report any issues you may find through <a href="https://github.com/Axeon-Network/kurowiki/issues">GitHub Issues</a> or on our <a href="/discord">Discord Server</a>
---

<script src="./resources/js/dyk.js"></script>
<!-- todo: literally move this to a separate JS file thanku -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
    const container = document.getElementById("feat-article-container");
     {% assign featured = site.pages | where: "path", "pages/articles/absolute_cinema.md" | first %}
  const pick = {
        url: "{{ featured.url | relative_url }}",
        title: {{ featured.title | jsonify }},
        excerpt: {{ featured.content | markdownify | split:'<h' | first | split:'<img' | first | truncatewords: 90 | jsonify }}
      };
    if (container) {
      container.innerHTML = `
        <a id="pagetitle" style="color:rgb(79, 85, 102); padding-bottom:10px;" class="mdl-layout-title" href="${pick.url}">${pick.title}</a>
        ${pick.excerpt}
      `;
    }
  })
</script>

<style>
    hr {
        display: none !important;
    }
</style>

<!-- actual homepage description -->
<p class="homepage-description">Some temporary string here....<br>TODO: add a proper description</p>

<!-- cards to make the homepage complete™ -->
{% include homepage_cards.html %}
