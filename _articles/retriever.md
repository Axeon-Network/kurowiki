---
title: Comet Adventure
isTitleItalic: true
permalink: Comet_Adventure
redirect_from:
- Retriever
- Project_Retriever
hatnote: "\"Project Retriever\" and \"Retriever\" redirect here. For the debugger, see [The Retriever Debugger](The_Retriever_Debugger).<br>This article is about the video game. For the fictional character that it is named after, see [Comet Adsurden](Comet). For the planned Nintendo 64 spin-off formerly known as \"Ultra Comet Adventure\", see [Project Retriever 64](Project_Retriever_64).<br>This article is a work-in-progress and should not be considered finished."
---

{% include infoboxes/game.html 
logo='cometadv/logo.png'
name='Comet Adventure'
developer='[KitSixtyFour](KitSixtyFour)'
screenshot='cometadv527/windows81.png'
caption='[Build 527](Comet_Adventure_build_527) running under Windows 8.1'
genre='Role-playing (RPG)'
releasedate='<b>Prior to cancellation:</b><BR>27 January 2027 (RTM)<br>12 September 2026 (Demo)<br>15 August 2026<br>(*Interim Developer Release*)'
formerly='Stuff Adventure<br>Stuffy Adventure<br>Starlight Adventure'
codename='Project Retriever'
writtenin='C++'
platform='Microsoft Windows<br>GNU/Linux'
arch='AMD64'
currentVersion='[0.5.677.private/kitsixtyfour.260112-1152](Comet_Adventure_build_677)'
curverDate='12 January 2026'
curverISO='2026-01-12'
status='Development halted; project on hiatus'
%}

***Comet Adventure***, also known by its codename of ***Project Retriever***[^1], is a planned role-playing game for PCs and consoles created by [KitSixtyFour](KitSixtyFour). While it is considered to be in a hiatus due to many reasons, the final version of the game was originally meant to release on 27 January 2027, while a *Demo Release* was meant to release on 12 September 2026.

{% include items/tableofcontents.html %}

# History
## Early 2026: "Comet Adventure" and the Engine Usability Tests
The development of Retriever has been debated many times. While early prototypes (or *builds*), such as [build 508](Comet_Adventure_build_508) are known to exist, they are not considered official development builds by its creator due to internal factors regarding the development of the latter.

Early concepts and ideas for Retriever actually began in early-to-mid 2016, where the game was entirely different; it was known as "Stuff Adventure", [Comet](Comet) was originally [Dogui](Dogui), and other miscellaneous ideas (such as <span title="Yes, I'm dead serious about this." style="cursor:help;">frying pans as enemies</span>) sparked to life and were written in a notebook that is still owned by Kit to this day.

Prototypes written in C++ dubbed *Engine Usability Tests* were developed by Kit on January 2026, which "were built as a way to get the game going while resources were being made". This was because *The Project Retriever Team* (known back then as *The Comet Adventure Team*) was not yet created, thus resources were unavailable at such time. Thus, placeholder sprites originating from *[Mario & Luigi: Bowser's Inside Story](https://mariowiki.com/wiki/Mario_&_Luigi:_Bowser's_Inside_Story)* were used instead.

Following the compilation of [build 677](Comet_Adventure_build_677), the development of the Retriever project was cancelled, as according to the readme files found within the release of [build 527](Comet_Adventure_build_527), the game was cancelled due to a lack of skills and motivation, stating that "only a *good* development team can do something miles better than whatever this non-sense is". However, *The Project Retriever Development Server* was active, where Kit posted their ideas for the project.

> Project Retriever realistically could be possible to make if I were to have the skills needed to make it. I still want to get dirty with the code, but I can only do <span title='Abbreviation of "website development". Similar to how "Game development" is abbreviated to "gamedev"' style="cursor:help;text-decoration:underline dotted;">webdev</span>, and <span style="font-style:normal">[Nexus](Nexus)</span> is proof of that. I can still get people, but I'm not good enough at communicating with people about my ideas; I was already kind of freezing when I worked with [pquirrel](https://pquirrel.neocities.org) when <span style="font-style:normal">[Icefield](Icefield)</span> was actively worked on.<br><br>However, I still can get involved aside from being the director and creator, I just need to learn how to draw better to meet my expectations. Story-wise I already get enough ideas for it on and off, just that I wanna learn how to make the usual "protagonist-defeats-antagonist" story without it getting too annoying. I still dream of [Comet](Comet) and [Daylight](Daylight) saving the world, I just need to get my shit together to form The Retriever Team.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*-- KitSixtyFour on the Retriever project. June 2026.*
<!-- always use 7 spaces so it aligns with the quote -->

For the next following months, *Project Retriever* was officially declared cancelled.

## Mid to Late 2026: Revival, *Project Kydro* and *Project Andromeda*, and "The Retriever Files"
Throughout August and September of 2026, Kit had picked up back the project, to an extent: the project did not re-start development, but rather re-entered the planning stage instead. This was done as a way to re-document and write down several ideas for the game itself, many of them first coined in mid-2025.

Sometime in May 2026, the project was renamed to its interim/working title "*Project Retriever*", as the previous name was put in limbo in case the final release required a rebranding. The codename originates from the Golden Retriever dog breed, referencing an in-game running gag where Comet is frequently mistaken for a Golden Retriever, despite actually being a Cocker Spaniel. It is worth noting that during Kit's second Discord break from July to August of 2025, many of the ideas and projects written here were originally coined during this period, including character personalities.

Most notably during this phase, two sub-projects were officially written down:
* ***Project Kydro***: An animator engine designed to have a user experience similar to Adobe's Flash Professional/Animate software while keeping full compatibility and easier support for C/C++ APIs and source code use. It is divided into:
   * ***LibKydro*** (formally *Kydro Animator Library*): The core of *Project Kydro*. It tells a program how to parse the *Kydro Animator Format* properly and is the central animation core.
   * ***Kydro Animator*** (codenamed *Odyssey*): The user interface and experience of *Kydro*. It is heavily inspired by Adobe's Flash Professional (Creative Suite 6) software and functions very similarly.
   * ***Kydro Animator Format***: The container format for any animation created by *Kydro Animator* and is composed of two formats: The ***Kydro Animator Sequence*** (.KYD) and ***Kydro Animator Bank*** (.KAN).<br><br>The ***Kydro Animator Sequence*** is a pseudo-binary format that is composed of animation instructions (hence its name, it's a sequence of instructions) similar to those of x86 assembly, and can be played back by *Kydro Animator*. A Kydro Animation's file structure can look like this:

   ```txt
   KDA
   KYDROANIMATOR1

   BEGIN KYDANIMATOR(PATHS) {
      SET(SPRITEMAP, 'CometVictory.png')
      SET(SPRITEMAPWORKINGPATH, 'R:\SOURCE\ASSETS\MAPS\COMET')
   }

   BEGIN KYDANIMATOR(PROPERTY) {
      SET(SPRITEMAP(SIZE), 810, 580)
      SET(SPRITESIZE, 50, 76)
      SET(SPRITEMAPMARGIN, 20, 20)
      SET(SPRITEMAPSPRITEDISTANCE, 5)
      SET(SPRITEMAPMARGINEND, 790, 560)
      SET(SPRITEMAPCOLORALPHA, '00ff00')
      SET(SPRITEMAPSPRITECOLORALPHA, 'ff00ff')
      SET(SPRITEPIVOTPOINT, 25, 75)
      SET(SPRITECENTREPOINT, 25, 38)
      SET(SPRITEFRIENDLYNAME, 'COMET')
      SET(SPRITETOTAL, 14)
      SET(ANIMATIONFPS, 27)
      SET BOOLEAN(RETRIEVERPLUSKYDRO, TRUE)
   }

   BEGIN ANIMATION('RVT_ANIM_COMET_BATTLE_VICTORY') {
      START(COMET, 1)
      CHANGE(COMET, 2)
      MOVE(COMET, 2, NULL)
      BARK(COMET, RVT_SFX_COMET_WAHOO, CURRENT)
      CHANGE(COMET, 3, 13)
      FREEZE(COMET, 14)
   }

   END(ANIMATION, 'RVT_ANIM_COMET_BATTLE_VICTORY')
   END(KYDANIMATOR)
   ```
   On the other hand, the ***Kydro Animator Bank*** (.KAN) format is a fully binary format containing the raw bytes and instructions for every animation, hence its name. Usually little-endian (although it can be switched to big-endian for RISC compatibility), it is used to gain a better performance at parsing animations, since it looks at the raw data and uses it, instead of looking at the data, looking at the instructions, parse them and displaying them if the *Kydro Animator Sequence* is used.



# Notes
[^1]: For consistency, the game will be referred to as "Project Retriever" or "Retriever" due to several development changes.