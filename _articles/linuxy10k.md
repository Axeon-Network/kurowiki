---
title: Running Linux... on Year 10000?
isTitleItalic: true
permalink: Running_Linux_on_Year_10000
hatnote: This article is incomplete.
aliases:
    - linux y10k
    - y10k on linux
dyk:
    - "...that [Running Linux... on Year 10000?](Running_Linux_on_Year_10000) was recorded prior to [Discord on Windows Vista but EVERYTHING Goes Wrong](Discord_on_Windows_Vista_but_EVERYTHING_Goes_Wrong) but wasn't released two months after it?"
---

{% include infoboxes/video.html
title='Running Linux... on Year 10000?'
image='resources/img/articles/linuxy10k/thumbnail.png'
channel='AstroNT'
channelurl='AstroNT'
platform='YouTube'
views='456'
reldate='https://www.youtube.com/watch?v=nWW3fbT7Xm0'
%}

***Running Linux... on Year 10000?*** is an [AstroNT](AstroNT) video made by [Avery](AveryEclipse).

It was initially planned as a [Lynxmic](Lynxmic) video during the video idea brainstorming of early 2025, after which a set of at least 30 video ideas have been noted in a Lynxmic video idea sheet to be used throughout 2025. The video was however cancelled with the discontinuation of active Lynxmic uploads.

That said, the video saw its light of day again as Avery joined the AstroNT project, adding a (cut down) list of videos initially planned as Lynxmic videos to the AstroNT video idea sheet.

Recordings for the video took place on 15-16 November 2025, prior to the publication of [Kit](KitSixtyFour)-made *Discord on Windows Vista but EVERYTHING Goes Wrong*, of which more "silly" style was planned for the Y10K on Linux video, but editing did not start until over a month later, on 24 December 2025. The thumbnail on the other hand was made on 17 November 2025.

It can be considered this video went through [Production hell](https://en.wikipedia.org/wiki/Development_hell), a term also used in media, due to how much it took and demotivation from losing original-original vision over time. The software used for editing was Kdenlive on Linux.

The video itself features a Virtual Machine with Debian 13 'Trixie', the Linux distro used for the Y10K experiment. It is dualbooted with Windows 7, on which year 9999 is applied using the /YEAR switch, later switching to Windows XP due to the persistence of the /YEAR setting in NTLDR versus Windows 7's BOOTMGR.

It was expected for it to "work" under Linux too but it turned out that Windows' /YEAR switch was a fake year that only applied in Windows, so it was decided to use `faketime` on Linux instead to set a fake year on Linux, also to year 9999. Once the year changed to 10000 in Linux, an exploration is done. Unlike Windows, Linux didn't massively slow down, but several bugs and segmentation faults were observed in various apps.

The final video flopped with just over 20+ views as of 16 February 2026 (almost a month after release), making it the least popular AstroNT video.
As of early March 2026, the view count was of over 190+ views, surpassing even that of the Android x86 video (125+ views), the previous title holder of "least popular AstroNT video" which it regained. It is the first major AstroNT video of 2026.
