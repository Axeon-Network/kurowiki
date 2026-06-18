---
title: Home
permalink: ./ # i interrupted my housepets reading time just for this
              # i'm at the november 17 2008 issue
search_exclude: true
hatnote: This software is still unfinished! Please report any issues you may find through <a href="https://github.com/Axeon-Network/kurowiki/issues">GitHub Issues</a> or on our <a href="/discord">Discord Server</a>
---

<style>
    hr, #pagetitle {
        display: none !important;
    }
</style>

<h1 style="color:var(--title-color)">Welcome to {{ site.title }}!</h1>

<!-- actual homepage description -->
<p class="homepage-description">{{ site.home_desc }}<br>You can use the drawer or the search bar to browse the contents of this wiki!</p>

<!-- cards to make the homepage complete™ -->
{% include homepage_cards.html %}
