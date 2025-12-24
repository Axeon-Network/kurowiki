---
title: Kit Arctic
permalink: Kit_Arctic
hatnote: As of now, this article is about the publicly available version known as Arctic16. For the 32-bit internal developer version, see <a href='Arctic32'>Arctic32</a>.
redirect_from:
  - Horibyte_LeafyOS
  - StuffyXP_LeafyOS
  - LeafyOS
  - Project_Arctic
  - LexNova_Arctic
  - Arctic
  - Horibyte_Arctic
  - Lexibyte_Arctic
aliases:
    - horibyte arctic
    - stuffyxp arctic
    - horibyte leafyos
    - stuffyxp leafyos
---

**Kit Arctic**[^1] is a free and open source operating system developed by [Kit](Kit64), first released on 26 May 2025. The source code is freely available on GitHub ([github.com/Kit64/arctic](https://github.com/Kit64/arctic)).

As of now, Arctic is only compatible on **QEMU** and **VMware**. This is due to how other virtualizors (and emulators) require image files to have a file system, whereas Arctic's boot disks are binary code.

The latest stable release is version 0.1.5.

{% include figure_item.html 
    image_src="resources/img/articles/arctic/0.1.5demo.png" 
    alt_text="Kit Arctic 0.1.5 Demo on QEMU" 
    caption="QEMU running Arctic v0.1.5a"
    author='Kit64'
%}

# Overview

Kit Arctic is a 16-bit real mode OS, making it compatible with processors going as far back as the 1980 or even earlier.

The OS has a built-in command line interface, which supports basic commands like `clear` or `echo`. Due to the OS' earlierness, disk support is absent from the OS.

Arctic is available in both **Standard** and **Server** SKUs, but the Server SKU is exclusive to the Lab02 virtual development lab, also known as [Arctic32](Arctic32).

# Development

Arctic's development began around 22 May 2025 (or even earlier) featuring a simple boot screen written in Assembly that eventually evolved into the OS's command line interface.

Interestingly enough, several instances of a **LeafyOS** (Arctic's former name) virtual machine have been seen in Kit's VMware VM library. Additionally, screenshots of several `kernel.bin` files and directory structures going as far back as **December 2024** have been sent by Kit on several Discord servers. All of these files are **lost media** due to improper backups.

A developer 32-bit version, codenamed **Arctic32**, was developed alongside Arctic16, while Arctic32 hasn't been publicly shared, boot attempts date back as far as **28 May 2025**[^2]

# Kernel Overview

The Arctic loading process involves three key files:

1.  `bootloader.bin` - The Arctic Bootloader, internally codenamed **Midori**, which is responsible for loading `osload.bin`.
2.  `osload.bin` - An intermediary component between the bootloader and the kernel, responsible for loading necessary functions and preparing for the launch of `rekanto.bin`.
3.  `rekanto.bin` - The main Arctic kernel, codenamed **ReKanto**, which contains all of the operating system's commands and drivers.

Arctic's kernel, codenamed *ReKanto* (a nod to the Kanto region from *Pokemon Red & Blue*) is a 16-bit monolithic kernel, due to its simplicity. The kernel had to be re-written due to various issues during the transition from 16-bit real mode to 32-bit protected mode. Interestingly enough, another attempt is being made with Arctic32.


# The Mockup Era™ Gallery

*This gallery showcases the finished Arctic mockups created by Kit.*

Before development began, Kit designed several Arctic mockups using GIMP. These images are conceptual representations and are **not** actual screenshots of functional builds—*yet!*

<div class="wiki-gallery">
    {% include gallery_item.html 
        image_src="resources/img/articles/arctic/7078personal.png" 
        alt_text="Horibyte Arctic Personal Beta 2 Build 7078" 
        caption="Horibyte Arctic Personal Beta 2 Build 7078" 
        author='Kit64' %}

    {% include gallery_item.html 
        image_src="resources/img/articles/arctic/7089professional.png" 
        alt_text="Horibyte Arctic Professional Beta 2 Build 7089" 
        caption="Horibyte Arctic Professional Beta 2 Build 7089" 
        author='Kit64' %}

    {% include gallery_item.html 
        image_src="resources/img/articles/arctic/7089personal.png" 
        alt_text="Horibyte Arctic Personal Beta 2 Build 7089" 
        caption="Horibyte Arctic Personal Beta 2 Build 7089" 
        author='Kit64' %}

    {% include gallery_item.html 
        image_src="resources/img/articles/arctic/7089server.png" 
        alt_text="Horibyte Arctic Server Family Beta 2 Build 7089" 
        caption="Horibyte Arctic Server Family Beta 2 Build 7089" 
        author='Kit64' %}
</div>

#### References

[^1]: Formerly known as **StuffyXP LeafyOS**, **Horibyte Arctic** and **LexNova Arctic**.
[^2]: [https://wetdry.world/@horibyte/114586135328279262](https://wetdry.world/@horibyte/114586135328279262)
