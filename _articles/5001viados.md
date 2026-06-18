---
title: Installing Windows Longhorn via MS-DOS! (Post-Reset)
permalink: Installing_Windows_Longhorn_via_MS-DOS
hatnote:
aliases:
    - 5001 via dos
    - longhorn via dos
dyk:
    - "...that [Installing Windows Longhorn via MS-DOS! (Post-Reset)](Installing_Windows_Longhorn_via_MS-DOS) was originally meant to be a [Lynxmic](Lynxmic) video?"
---

{% include infoboxes/video.html
title='Installing Windows Longhorn via MS-DOS! (Post-Reset)'
image='resources/img/articles/5001viados/thumbnail.png'
channel='AstroNT'
channelurl='AstroNT'
platform='YouTube'
views='748'
reldate='2026-01-25'
link='https://youtu.be/9PPVtLosMaQ'
%}

**Installing Windows Longhorn via MS-DOS! (Post-Reset)** is an [AstroNT](AstroNT) video made by [Avery](AveryEclipse).

The video focuses on installing Windows Longhorn Build 5001, an early post-reset build of Longhorn from September 2004, via an Windows 98 Boot Disk (based on MS-DOS). Notably, 5001 was the last Windows build to use NTLDR and the i386 installation method before later builds shifted to WIM for good, but did not include an `winnt.exe` that could be invoked from MS-DOS for installation. The video showcases issues that happen when still trying to install this build via MS-DOS regardless.

Initial plans for such a video for the [Lynxmic](Lynxmic) channel date back to early 2023. A thumbnail for the video was created using the Lynxmic thumbnail style from the time dating back to 23 February 2023 at 1:20am UTC+2 according to file metadata.

As of 16 February 2026, the video has over forty views. It was the first AstroNT video to be edited on DaVinci Resolve (Windows), a choice made by Avery after previous videos since September 2025 (including AveryEclipse and [Lynxmic](Lynxmic) videos) made with Kdenlive on Linux were all either cancelled or took a long time to make due to procrastination.

# Making of
## As a Lynxmic Video

{% include silver_item.html 
image_src="resources/img/articles/5001viados/installing_longhorn_build_5001_from_dos.png" 
caption="'Installing Windows Longhorn (Build 5001) from DOS' thumbnail, 23 February 2023"
author="AveryEclipse/Lynxmic" %}

It is known that the video idea has been attempted for Lynxmic in March 2023 and again in March 2025, both with their final recordings ending at a "NTLDR is missing" after the first-stage text mode setup, which in the last copying stage kept failing to copy `.mui` files. The 2025 attempt though was part of the plans for a final set of Lynxmic videos before the semi-retirement of new uploads for the channel.

Longhorn Build 5001's ISO does not have `winnt.exe` in the `I386` folder, so as such the `winnt.exe` from Windows XP 2600's ISO was used for both attempts as well as the AstroNT attempt mentioned below.

## As an AstroNT Video
### Using the Windows XP ISO
A while after Avery joined the AstroNT project, they have been determined to try to get around the "NTLDR is missing" error in order to finally make the 5001 via DOS video. The earliest recordings date back to 15 December 2025, with a picture made using a phone camera with a 5001 VM having been sent on the private Discord server [AstroNT Advanced Server](AstroNT#AstroNT_Advanced_Server).

The first attempted workaround was to first install Windows XP via DOS, only getting through the initial text-mode setup just enough to have a working NTLDR, then overwrite the incomplete XP install with an Longhorn build 5001 install, also via DOS. 

Although file copy errors persisted, this time it was now possible to boot into second-stage text-mode setup. However, it would now complain about missing files such as `lbrtfdc.sys`. This is where the 5001 via DOS experiment stopped once again, before being picked up again in January 2026.

Avery then proceeded to copy the files requested manually one by one (and even by using a copy command with wildcards inside WinPE), until finally reaching the "Setup is starting Windows" screen, where it would remain stuck. In an attempt to investigate the exact issue, they tried using debuggers like WinDbg or PuTTY to no avail. This had been considered a hard block.

### Using the Longhorn Build 3790.1232 ISO
Longhorn build 3790.1232 is one of the first known builds of Windows Longhorn after the development reset from August 2004, which was based on a newer Windows codebase than XP's, particularily that of a work-in-progress version of Windows Server 2003 Service Pack 1.

The ISO file for build 3790.1232 did contain `winnt.exe` in the `I386` folder, as such it has been decided to use that instead of the `winnt.exe` from the XP ISO. The installation process has went fluently this time, apart from the `.mui` file copy errors which led into problems in the GUI setup, the cause of which it was discovered to be the fact MS-DOS wasn't seeing any of the `.mui` files.

Those files have been copied manually from the 3790.1232 ISO to the hard disk via WinPE. It was initially attempted to use the `EXPAND` command to get the files changed from `.mu_` to `.mui`, however that did not work. Avery ended up just renaming the files from `.mu_` to `.mui`, which allowed to get through the GUI setup and OOBE.

However, issues have then risen with missing or improperly copied files, including `explorer.exe` itself as well as missing DLLs. The `explorer.exe` issue was fixed by porting over an equivalent from a working Longhorn build 5001 VM, however the Start button was still missing. Pressing the Windows key, the Start menu would appear albeit broken.

That said, given that 5001 was reaching the desktop when installed using 3790.1232's `winnt.exe`, the experiment had been finally considered successful regardless, 3 years in the making.
