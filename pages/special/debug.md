---
layout: raw
title: Debug Info
permalink: debug
---

# Debug Information
This page prints information mainly used to debug certain features of Deltari, or to simply check in for other resources.

## Site Variables:
This is a list of the `site` variables used within the layout files. These can be called via the `{{ site.myvariable }}` syntax, where `myvariable` is the name of your variable.

- site.name = **{{ site.name }}**
- site.productname = **{{ site.productname }}**
- site.title = **{{ site.title }}**
- site.author = **{{ site.author }}**
- site.copyyear = **{{ site.copyyear }}**
- site.email = **{{ site.email }}**
- site.description = **{{ site.description }}**
- site.url = **{{ site.url }}**
- site.baseurl = **{{ site.baseurl }}**
- site.sourceurl = **{{ site.sourceurl }}**
- site.license = **{{ site.license }}**
- site.licenseurl = **{{ site.licenseurl }}**
- site.home_desc = **{{ site.home_desc }}**
- site.featuredarticle = **{{ site.featuredarticle }}**
- site.retailtag = **{{ site.retailtag }}**
- site.devphase = **{{ site.devphase }}**
- site.debug = **{{ site.debug }}**
- site.retail = **{{ site.retail }}**
- site.version = **{{ site.version }}**
    -  site.version.major = **{{ site.version.major }}**
    -  site.version.minor = **{{ site.version.minor }}**
    -  site.version.id = **{{ site.version.id }}**
    -  site.version.lab = **{{ site.version.lab }}**
    -  site.version.timestamp = **{{ site.version.timestamp }}**
    -  site.version.full = **{{ site.version.full }}**

**{{ site.productname }}, {{ site.devphase }}**
Version {{ site.version.full }}; Compiled on {{ site.version.timestamp | replace: '-', ' ' | date: "%y%m%d %H%M" | date: "%A, %d %B %Y at %H:%M" }} by neko64.

&copy; {{ site.copyyear }} Axeon Network. All rights reserved
