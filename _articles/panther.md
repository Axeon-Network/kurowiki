---
title: Panther
permalink: Panther
redirect_from:
- TagGen
- TagGenerator
- Axeon_Deltari_Build_Tag_Generator
---

The **Axeon Panther Version Master Utility**, simply reffered to as **Panther** (formerly known as *TagGen* and the *Axeon Deltari Build Tag Generator*) is a component present in *[Deltari](Deltari)* (including [subquesent](Deltari_Meta) [forks](KuroWiki)) and *[Project Cuber](Cuber)* designed to automatically generate a new version number after each build. It uses a modified version of the [Microsoft Windows version number format](https://betawiki.net/wiki/Build_tag) for version numbers, commonly reffered to as *build tags*. 

Build tags were introduced as early as [the first *KuroWiki* build](KuroWikii_build_3567_(main_wik)) but were not automatically generated with each site build until September 2025 following the release of Beta 4.

# Format
The Panther utility uses a custom version of the Microsoft Windows build tag format, which is `major.minor.build.delta.id.lab.timestamp`. It can be broken down to the following:

- `major`: The major version.
- `minor`: The minor version.
- `build`: The build number (or compile number) of the site, which is automatically increased on each site build.
- `delta`: A secondary build number used whenever a build is compiled, but is not suitable enough to be considered a new build. This is usually used whenever an exact build is recompiled, such as [KuroWiki build 5194.43](KuroWiki_build_5194.43).
- `id`: The compile identificator, which states the exact type of build that a site is. It consists of a milestone prefix (such as `b6` for Beta 6 or `alp` for Alpha) followed by the build type (such as `fre` for retail/"free" builds, or `chk` for debug/"checked" builds). It is usually left out of some versions of a build tag, but it is usually used on the Akane watermarks, for example.
- `lab`: The build branch (or build lab), which is the source code branch where the build was compiled from. For private builds, it is usually prefixed by `private/` and followed by the name of the user account who compiled the build in parenthesis.
- `timestamp`: The compilation date and time of the build itself based on the [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format. It is usually in the UTC-6 or UTC+2 (or +3 depending on Daylight Saving Time) timezones, but it depends by branch.

# Usage and Implementation

