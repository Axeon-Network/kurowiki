---
title: Legacy News Reports
permalink: "/Special:Legacy_News_Reports"
---

This page shows all news reports prior to September 2025.

{% comment %} 1. Filter out only the disabled news items {% endcomment %}
{% assign legacy_news = site.news | where_exp: "item", "item.disabled == true" | sort: "date" | reverse %}
{% assign legacy_count = legacy_news.size %}
{% assign total_count = legacy_news.size %}

Showing **{{ legacy_count }}** of **{{ total_count }}**

{% if legacy_count > 0 %}
  {% for item in legacy_news %}
- <a href="{% if site.baseurl %}{{ site.baseurl }}{% endif %}{{ item.url }}">{{ item.title }}</a>
  {% endfor %}
{% else %}
<p>Nothing to see here...</p>
{% endif %}