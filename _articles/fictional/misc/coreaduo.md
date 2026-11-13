---
title: Intel Core A Duo
permalink: Intel_Core_A_Duo
redirect_from:
    - Intel_Core_A_Solo
    - Intel_Core_A_Quad
    - Intel_Core_A_Extreme
    - Intel_Core_A
    - Intel_Core_A_Series
    - Core_A
hatnote: "\"Core A\" redirects here. For the emoji and meme, see [A Emoji](A_Emoji)."
---

{% include infoboxes/processor.html 
name='Intel Core A Duo'
launched='4 August 2006'
launchedISO='2006-08-04'
marketer='[Intel Corporation](https://en.wikipedia.org/wiki/Intel)'
designer='Dogui Heavy Industries: Research & Development 2<br><small>under the [Dogui Heavy Industries, Inc.](Dogui_Heavy_Industries) moniker</small>'
manufacturer='Intel<br>[Foxconn](https://en.wikipedia.org/wiki/Foxconn) (Japan and South Korea)' 
logo='coreaduo/coreaduo_2006.png'
caption='Logo from 2006 to 2009' %}

**Intel Core A Duo** (also written as **Intel Core 🅰️ Duo**) is an inside joke within several related communities, including the [Axeon Network](Axeon_Network). It is a parody of the [Intel Core 2](https://en.wikipedia.org/wiki/Intel_Core_2) processor family manufactured by Intel Corporation. The meme was first used in a public community Discord server, basing itself off from the [🅰️ Emoji](A_Emoji) meme.

Canonically, the processor family was manufactured by [Dogui Heavy Industries Incorporated](Dogui_Heavy_Industries)'s Research & Development 2 division circa August 2006 as a successor to the aging [Quadron](https://en.wikipedia.com/wiki/Pentium) and [Swifton](https://en.wikipedia.com/wiki/Celeron) processors, while co-existing with the [Nexon](https://en.wikipedia.org/wiki/Xeon), [Electron](https://en.wikipedia.org/wiki/Intel_Atom) and [Vapor](https://en.wikipedia.org/wiki/Itanium) processors, which were used under server, mobile and enterprise environments respectively, while Quadron and Swifton performed worse over time due to multiple flaws with the *[Prescott](https://en.wikipedia.org/wiki/Pentium_4#Prescott)* generation. However, Quadron and Swifton continued to co-exist with Core until January 2007.

Eight generations were developed for the Core A family until its discontinuation in 2014: *[Conroe](https://en.wikipedia.org/wiki/Conroe_(microprocessor))*, *[Penryn](https://en.wikipedia.org/wiki/Penryn_(microarchitecture))*, *[Nehalem](https://en.wikipedia.org/wiki/Nehalem_(microarchitecture))*, *[Westmere](https://en.wikipedia.org/wiki/Westmere_(microarchitecture))*, *[Sandy Bridge](https://en.wikipedia.org/wiki/Sandy_Bridge)*, *[Ivy Bridge](https://en.wikipedia.org/wiki/Ivy_Bridge_(microarchitecture))*, *[Haswell](https://en.wikipedia.org/wiki/Haswell_(microarchitecture))* and *[Broadwell](https://en.wikipedia.org/wiki/Broadwell_(microarchitecture))*. The processor family was succeeded by the Intel Core A2 series in 2011. A sub-family, Intel Core A Centrino, was released in May 2008 as a higher-performance alternative to Electron.

# Public appearances
As of September 2026, the parody has been featured in two [AstroNT](AstroNT) videos, *[The Year 30828 Bug](The_Year_30828_Bug)* and *[Quirky Setup Behaviour](Quirky_Setup_Behaviour)*.

# Usage guide
While the processor does not exist, it can be applied to any virtual machine powered by VMware Workstation by editing the VM's `.vmx` file. Follow these steps:

- Go to the path of your virtual machine and right click the .VMX file
- Open it with Notepad
- Go to the bottom of the file and add `cpuid.brandstring = "<model>"`


And then replace `<model>` by your favorite model:
- Intel(R) Core(TM)A Solo CPU E640 @ 2.00GHz
- Intel(R) Core(TM)A Duo CPU E640 @ 2.00GHz
- Intel(R) Core(TM)A Quad CPU E640 @ 2.50GHz
- Intel(R) Core(TM)A Extreme CPU E630 @ 2.60GHz

If you want more accuracy, you can also add `timeTracker.apparentHz = <hertz>` and choose the right one for your model:

- `2000000000` for Solo and Duo
- `2508000000` for Quad, and 
- `2624000000` for Extreme

Additionally, if you want to replace the model number (*E640*) with a newer generation, use the following list:

- *Penryn*: E840
- *Nehalem*: N920
- *Westmere*: W650
- *Sandy Bridge*: S250
- *Ivy Bridge*: I357
- *Haswell*: H467
- *Broadwell*: B577
