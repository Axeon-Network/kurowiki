---
title: Arctic32 build 200
permalink: Arctic32_build_200
---

{% include infoboxes/build.html
family='[Arctic32](Arctic32)'
buildtag='1.0.200.arc_rwrite.260330-1627'
version='1.0'
build='200'
lab='arc_rwrite'
compiled='2026-03-30'
arch='x86 16-bit'
image='res/img/articles/arctic200/firstboot.png'
image_caption='First boot'
%}


**Arctic32 build 200** is an early development build of [Arctic32](Arctic32) compiled on 30 March 2026 at 4:27 PM UTC-6 from the `arc_rwrite` development branch. It is the first Arctic32 build compiled in 2026, over 5 months after the [October 2025 build](Arctic32_unidentified_October_2025_build).

Unlike the October build, this build uses a modified version of the [Arctic16](Arctic16) kernel, meaning it has no 32-bit support and therefore is x86 16-bit, even though it is branded as "Arctic Codename Sydney".

It is one of the builds from the so-called "Arctic32 Reboot", yet another series of rewrites to the Arctic32 project.

# New features and changes
- The boot message has been simplified and now prints the version banner and says `Launching console...`.
- The command prompt has been changed to say `[CON]` instead of `>`
- The `cls` command has been renamed to `clear`
- The `echo` command has been removed.
- The `shutdown` command has been renamed to `exit` and now prints `Session terminated`, then halts the machine.
- The `sample` command has been introduced. When ran, it prints `Arctic & Nex32, coming soon!` to the console then exits.
- The `ver` command has been shortened and now prints the full build tag.
- The message that is printed whenever an unknown command is ran has been shortened to say `Not recognized.`.

# Gallery

<div class="wiki-gallery">
{% include items/gallery.html
    image_src='res/img/articles/arctic200/help.png'
    caption='Help command' %}
{% include items/gallery.html
    image_src='res/img/articles/arctic200/ver.png'
    caption='Version' %}
{% include items/gallery.html
    image_src='res/img/articles/arctic200/sample.png'
    caption='Sample command' %}
{% include items/gallery.html
    image_src='res/img/articles/arctic200/exit.png'
    caption='Not recognized message and exit command' %}
</div>