---
title: Arctic32 unidentified October 2025 build
permalink: Arctic32_unidentified_October_2025_build
---

{% include infoboxes/build.html
family='[Arctic32](Arctic32)'
buildtag='Unidentified October 2025 build'
version='1.0'
compiled='2025-10'
arch='x86'
image='res/img/articles/arctic_oct25/image.png'
image_caption='The build running under QEMU'
%}

A screenshot of an otherwise very early private[^1] build of **[Arctic32](Arctic32)** presumably compiled on 4 October 2025[^2] running under QEMU was sent to the *Noticeboard* channel on the [Nishi's Den](Nishi's_Den) Discord server. This is the first build of Arctic32 known to exist.

This build is the only known build to use the `<version>-<codename>` version format, where `<version>` is the version number of release, while `<codename>` is the codename. Other examples of this format can be `2.0-Hydra` and `3.0-Calico`, where it can be decoded to Arctic32 2.0 (codenamed *Hydra*) and Arctic32 3.0 (codenamed *Calico*), respectively.

Applying the logic to this build, which identifies itself as ***Arctic32 1.0-Sydney*** and ***Nekori Arctic32 Code Name Sydney*** confirms that this build belongs to the first major release of Arctic32, codenamed *Sydney*.

The aforementioned screenshot also shows version information for the *Mochi Bootloader*, the 32-bit version of the *Midori* bootloader found in the [original Arctic](KitSixtyFour_Arctic) which was renamed from Midori to avoid confusion with *[MidoriMC](MidoriMC)*.

While the `1.0-Sydney` version banner is shown on the boot screen due to it being hardcoded onto *Mochi*, the full build tag is not shown anywhere in the system due to the earliness of the whole operating system itself.

# Notes
[^1]: Similar to TagGen, private builds have a "For testing purposes only" warning embedded within the version banners.
[^2]: While the screenshot was sent on the aforementioned date, it isn't certain that it was compiled on the same date.
