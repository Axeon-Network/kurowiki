---
title: '%iKBLULTGT2%'
permalink: iKBLULTGT2
dyk:
    - "...that \"[%iKBLULTGT2%](iKBLULTGT2)\" is named such way due to a bug in the .inf file?"
---

{% include items/embed.html 
    image_src="res/img/articles/ikblultgt2/devicemanager.png" 
    caption='%iKBLULTGT2% visible in the Windows 7 Device Manager.' 
    %}

**%iKBLULTGT2%** is the name for an Intel HD Graphics driver modded to work under Windows 7 and Windows 8 on [NishiLappy](NishiLappy) (Dell Latitude 3380), which uses a 7th generation Intel CPU (codenamed *Kaby Lake*), which officially delibrately does not support any version of Windows that's not Windows 10.

While official Windows 7 drivers do exist for the Latitude 3380, no official integrated graphics driver has been found to work[^1], leading to this.

The name is the product of the "`iKBLULTGT2`" variable inside the `[Localizable Strings]` section of the driver's .inf file being left out, leading to the full vaiable being used as a name instead. Adding "`iKBLULTGT2 = Intel(R) HD Graphics 620`" to the aforementioned section correctly displays the device *as Intel(R) HD Graphics 620*.

The fixed version of the driver is available for download and can be downloaded at [drive.google.com/file/d/1Qr2s_nLVZHMsDcgwY3aRLlj0REso_rVl/view?usp=sharing](https://drive.google.com/file/d/1Qr2s_nLVZHMsDcgwY3aRLlj0REso_rVl/view?usp=sharing).

The variable's name meaning has been decoded as follows:
- `i` = Intel
- `KBL` = Kaby Lake
- `ULT` = Ultra Low Power (also known as the U-series)
- `GT2` = Graphics Technology level 2

# Notes
[^1]: The official Dell driver pack includes a driver for the *Graphics 520* for 6th generation Intel CPUs (codenamed *Skylake*), leading to the driver not installing under NishiLappy.