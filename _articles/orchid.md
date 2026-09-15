---
title: Axeon Orchid
permalink: Orchid
redirect_from:
     - Project_Orchid
     - Axeon_Orchid
---

{% include infoboxes/bot.html
image='orchid/logo.png'
name='Orchid'
owner='[AveryEclipse](AveryEclipse)'
platform='Discord<br>Stoat<br>Fluxer'
launchDate='2026-07-01 <small>(Alpha)</small>'
discontinuedDate='2026-09-13 <small>(development stopped)</small>'
type='Utility'
state='Cancelled'
%}

**Axeon Orchid** is a cancelled bot project developed by [AveryEclipse](AveryEclipse) under the [Axeon Network](Axeon_Network) umbrella. Over the years the project had multiple purposes, however in its final form it aimed to, per-say, serve as an in-house solution to "actually make the Axeon Network a network", by linking together the three Axeon Network servers on the Discord, Stoat and Fluxer platforms.

Development of the bot itself can be traced back to early 2021, when its codebase was initially started as a v2.0 tentative for [Venus](Venus). This codebase was shortly abandoned afterward but would only be picked up on 22 June 2026 to serve as the foundation of Orchid. Several alpha and beta releases would come throughout the following months prior to the project discontinuation on 13 September 2026.

The primary selling point of Orchid would've been the cross-guild chatting feature which is ""federated"" across the three chatting platforms, allowing one to talk to someone on Discord via Stoat or Fluxer and vice-versa, to which are added various other utility features like sending an announcement to all configured servers or maintain the same community rules across the 3 platforms.

Although no plans existed to make the main Orchid instance available to add directly to servers, Orchid was planned to be a FOSS (free and open source sofrware) with anyone being able to freely self-host their own Orchid instance.

# History
## Planning
### Original ideas and tentatives (2023-2025)
Original plans for Orchid date back to 2023, when it was considered as a spiritual successor (but unrelated) to 2018's *AxeonBot*, used as a complementary extension to existing 3rd-party bots already in use in the Axeon Network Discord server (at the time known as *Lynxmic's Square*).

The bot account that was to used for Orchid at this time was first added to the then-Lynxmic's Square on 28 March 2023, only to then be kicked after a few days. The same bot account was then readded again on 25 June 2023, with a (now-deleted) announcement following 2 days later where Avery (then Lynxmic) suggested Orchid would become "an integral part of the [Lynxmic's Square] server, powering some areas of the server (and maybe - in the long-term - even port Orchid to Revolt [Stoat] to use for this server's [then-existing] counterpart [later shut down in July 2023] there)".

Some actual work was actually done on the Orchid bot project in June 2023, re-using an existing [Venus](Venus) rewrite codebase dating from 2021-22 which included a database powered by `better-sqlite3`, however this only consisted of replacing references to Venus with Orchid. Just like the previous tentative, the project was abandoned again after a short time and the bot account was kicked from the server in 7 July 2023 and was later repurposed in 2025 to report the online status of the [MidoriMC](MidoriMC) (and later [KitsuMC](KitsuMC)) Minecraft servers on Discord. This Orchid code has since been deleted and considered lost media.

The idea of an Orchid bot came back to light again sometime during February 2025 after the launch of [HoriServer](HoriServer) on Stoat (then Revolt), this time as a public multi-purpose bot (similar to Venus in idea) for said chatting platform, however the project was yet again abandoned after a short while, and the Stoat bot account for Orchid was deleted in March 2025.

{% include items/embed.html 
   image_src="orchid/earlylogos.png" 
   caption="Initial Orchid logos, from left to right: 2023 (for the Discord bot), 2025 (for the multi-purpose Stoat bot)"

%}

### Actual development tentative as a cross-platform bridge bot (2026)
In July 2025, Orchid came back to light again for a fourth time, this time as a project under the [Axeon Network](Axeon_Network) umbrella, at the time planned to link the Axeon Discord server, Stoat server, and the in-game chat of [MidoriMC](MidoriMC). However the idea was largely abandoned again in August following the discontinuation of MidoriMC and the inactivity of the Axeon Network Stoat server.

The idea would remain shelved until February 2026, when it began to be seriously considered again in the wake of Discord's plans at the time to push age verification globally platform-wide and people scrambling to find Discord alternatives. This time the bridge would only be between Discord and Stoat, although Fluxer was also later added in the plans following its success and after Avery took a look at it.

## Development
### Alpha
On 22 June 2026, actual development on the Axeon Orchid project finally began, taking and repurposing the existing [Venus rewrite codebase](Orchid_build_578) from 2021-22 and updating it to work with the current expectations of Discord's API.

Over the next few days, significant changes would be done on the Venus rewrite codebase, including refactoring existing JavaScript code to reduce tech debt and maintenance burden, redesigning command embeds, introducing support for Discord's Slash Commands as an alternative to prefix, and adding an implementation of the [Panther Version Master Utility](Panther) dubbed "PantherJS" to determine build number automatically (it being previously just an arbitrary number bumped manually), followed by the addition of basic Orchid features like global announcement crossposting and cross-server chat.

Orchid Alpha was declared finalized on 1 July 2026 with [build 1000](Orchid_build_1000).

### Beta 1 & 2
After the finalization of the Alpha phase, development moved to the Beta phase in July 2026.

The first beta release ([build 1500](Orchid_build_1500)) came on 8 August 2026, including basic multi-platform support initially between Discord and Stoat, as well as features like the honeypot (banning people sending to a specific channel that was designated honeypot).

Later on 7 September 2026, Beta 2 was released ([build 1700](Orchid_build_1700)). Originally planned to include Fluxer support and other major features, these were pushed later in the development phase and Beta 2 has instead primarily focused on cleanup and addressing major flaws discovered over time with Beta 1.