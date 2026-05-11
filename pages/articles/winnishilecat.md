---
title: Microsoft Windows Nishi & LeCat Edition 2026 Version 2003 R2 Home Premium
permalink: Microsoft_Windows_Nishi_&_LeCat_Edition_2026_Version_2003_R2_Home_Premium
redirect_from:
   - Microsoft_Windows_Code_Name_Longhorn_Nishi_&_LeCat_Edition_2026_Version_2003_R2_Home_Premium
   - Windows_Nishi_&_LeCat_Edition_2026_Version_2003_R2_Home_Premium
   - Windows_Vista_Nishi_&_LeCat_Edition_2026
   - Windows_Nishi_&_LeCat_Edition
   - Windows_Nishi_&_LeCat_Edition_2026
isTitleItalic: true
---

***Microsoft Windows Nishi & LeCat Edition 2026 Version 2003 R2 Home Premium***[^1], commonly shortened to ***Windows Nishi & LeCat Edition***, is a Windows bootleg created by [KitSixtyFour](KitSixtyFour) in *[Making a Custom Windows Bootleg](Making_a_Custom_Windows_Bootleg)* for the [AstroNT](AstroNT) channel on March 4th 2026 and released on May 8th 2026. It is based on Windows Vista Service Pack 2 x64 and can be downloaded at [its Internet Archive page](https://archive.org/details/microsoft-windows-nl26-v2k3-r2-homepremium).

Similarly to other famous bootlegs (such as *[Gold Windows XP 2016](https://crustywindo.ws/Gold_Windows_XP_2016)*, *[Windows The Avengers](https://crustywindo.ws/Windows_The_Avengers)* or *[Windows Glass Xp Super](https://crustywindo.ws/Windows_Glass_Xp_Super)*), *Windows Nishi & LeCat Edition* contains several modifications compared to a retail Windows Vista install, such as custom branding, wallpapers, and pre-installed software (commonly called *bloatware*). However, unlike most Windows bootlegs, it does not contain modifications to Windows components such as Windows Explorer, LogonUI or the Windows Task Manager due to time constraints.

{% include tableofcontents.html %}

# Changes over a retail Windows Vista SP2 ISO
- Most references of "Microsoft" have been changed to "Microslop", referencing the 2026 meme of the same name.
- In About Windows, the first line of text have been changed to "Microslop® Windows NT®", while the copyright notice has been changed to "Copyright &copy; 2007-2026 Microslop Corporshitation. All rights reserved.".
- The branding banner present in About Windows has been changed to a bitmap consisting of a badly-drawn Nishi and LeCat drawing, alongside "uindows V2K3 R2 home premium", albeit written with a mouse.
- The End User License Agreement (EULA) (`license.rtf`) has been changed significantly; the header was changed to "MICROSLOP SOFTWARE LICENSE TERMS. MICROSOFT WINDOWS CODE NAME "LONGHORN" NISHI & LECAT EDITION 2026 VERSION 2003 R2 HOME PREMIUM SERVICE PACK 2", and the entire license body was changed to a humorous line depicting cat sounds.
- The Sample Pictures were replaced by the background set.
- The Sample Music was replaced by the track "Big Bang!" composed by Yoko Shimomura from the *[Mario & Luigi: Paper Jam](https://www.mariowiki.com/Mario_%26_Luigi:_Paper_Jam)* OST.

## Pre-installed software
*Windows Nishi & LeCat Edition* contains 27 pre-installed programs:

- μTorrent version 2.0.0
- 7-Zip version 26.00
- Apple Software Update version 2.1.1.116 (implied by iTunes and QuickTime)
- avast! Antivirus version 4.8
- Bonjour version 1.0.105 (implied by iTunes)
- FastStone Image Viewer version 2.0
- GIMP version 2.8.0
- Google SketchUp 7 version 2.1.6860
- Google Talk version 1.0.0.68
- ImgBurn version 2.5.8.0
- iTunes version 4.8.0.31
- Macromedia Flash MX 2004 version 7.0
- Microsoft Visual C++ 2008 Redistributable version 9.0.30729.4148 (x86 and x64)
- Microsoft Visual C++ 2008 Redistributable version 9.0.30729.6161
- Mozilla Firefox version 3.5
- Mozilla Thunderbird version 2.0.0.23
- Notepad++ version 4.9.2
- Opera version 10.00.1750
- Picasa 2 version 2.0
- PowerISO version 4.3
- QuickTime version 6.5.2
- Safari version 3.525.28.1
- Skype version 3.8.188
- Supermium version 138.0.7204.300 R9*
- VLC Media Player version 3.0.23
- VMware Tools 9.0.0.15210*
- Winamp version 5.5
- Yahoo Messenger version 7.0.0.437

\* Leftover

# Bugs and quirks
- Windows Setup might take a while to go to the EULA page. This is caused by `install.wim`, since it is not a retail copy, thus Windows Setup reads it from scratch.
- The EULA page on Windows Setup and the Out of Box Experience (OOBE) is the original Windows Vista Service Pack 2 license (as it does not identify the system as "Microsoft Windows Code Name "Longhorn" Nishi & LeCat Edition Version 2003 R2 Home Premium Service Pack 2"), since `C:\Windows\system32\license.rtf` is not called by the latter, instead using their own license agreement files that were left untouched.
- The copyright notice on the about dialog is cut off.
- Windows Aero does not work by default. Uninstalling VMware Tools and installing a proper graphics driver (or upgrading VMware Tools) can fix the problem.
- VMware Tools is left installed.
- The desktop backgrounds do not show up in the OOBE nor Control Panel since they are not in the JPG file format. To apply a wallpaper, go to `C:\Windows\Web\Wallpaper` and apply a wallpaper from there. A side effect of this problem is that the desktop background is black by default.
- Windows is not activated and will nag the user to activate it on first logon.
- The system is inconsistent with its branding: it identifies itself as *uindows V2k3 R2 home premium* in the branding banner, *Windows Nishi & LeCat The Third Edition 2026 Version 2003 Home Premium idk* in the System applet, *Windows Nishi & LeCat The Third Edition 2026 Version 2003 Vista™ Home Premium* in the DirectX Diagnostic Tool, Welcome Center, About Windows (albeit text form), *Microsoft Windows Code Name "Longhorn" Nishi & LeCat Edition 2026 Version 2003 R2 Home Premium* in the License Agreement, *Microsoft Windows Nishi & LeCat Edition 2026 Version 2003 R2 Home Premium* in the Internet Archive, and *Windows Vista Home Premium* everywhere else.
- The Set Network Location wizard targeting "Network 2" will open on the first boot.
- A message by Avast Antivirus stating that license number is not valid will open at startup.

# Name
The bootleg's name is a mock to many Windows bootlegs' names, which commonly include the year they were made in, the theme about the bootleg, and additionally many other unrelated artifacts. The bootleg is loosely themed around Nishi and LeCat, two cats (owned by KitSixtyFour and [Avery](AveryEclipse) respectively) originating from the *[KitsuMC](KitsuMC)* Minecraft server, which warrants their inclusion.

In the other part, "Edition 2026" is a nod to many bootlegs' name that have included their year of creation on their name, such as *[Gold Windows XP 2016](https://crustywindo.ws/Gold_Windows_XP_2016)*. "Version 2003" and "R2" are references to [Windows XP 64-Bit Edition, Version 2003](https://betawiki.net/wiki/Windows_XP_64-Bit_Edition#Version_2003) and [Windows Server 2008 R2](https://betawiki.net/wiki/Windows_Server_2008_R2) respectively, and were added just for fun.

# Trivia
- Google SketchUp was installed as a nod to one of Kit's sisters, who used SketchUp in their university days.
- *Windows Nishi & LeCat* was originally going to be based on Windows XP, but Windows Vista was chosen instead since "not many bootlegs are based on [Windows] Vista"
- The bootleg was not uploaded to the Internet Archive until one month after *[Making a Custom Windows Bootleg](Making_a_Custom_Windows_Bootleg)* came out. If the creation date is taken into note, it was uploaded exactly 2 months and 4 days after it was created.
- The bootleg had many problems in the upload process, as the upload would freeze at random file sizes.[^2]
- The bootleg was created and uploaded from the same machine, [NishiLappy](NishiLappy).

# Gallery
## Windows Setup
<div class="wiki-gallery">
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/windowsiscopyingfiles.png"
   caption="Windows is copying files..."
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/setupautorun.png"
   caption="Setup"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/stpautorun2.png"
   caption="Ditto"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/setupprodkey.png"
   caption="Product key"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/setupeula.png"
   caption="EULA"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/setupinstalltype.png"
   caption="Installation type"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/setupinstallloc.png"
   caption="Disk partitioning"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/setupinstalling.png"
   caption="Installing Windows"
   author="AveryEclipse"
   %}
</div>

## Out of Box Experience
<div class="wiki-gallery">
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/plswait.png"
   caption="Please wait while Windows sets up your computer"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/plswait2.png"
   caption="Please wait while Windows continues to set up your computer"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/oobe1.png"
   caption="User name and picture"
   author="AveryEclipse"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/oobe2.png"
   caption="Computer name and background"
   author="AveryEclipse"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/oobe3.png"
   caption="Automatic Updates"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/oobe4.png"
   caption="Date and time"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/oobe5.png"
   caption="Network"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/oobe6.png"
   caption="Finish"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/postoobe.png"
   caption="Hardware check"
   author="KitSixtyFour"
   %}
</div>

### OOBE after using Sysprep 
<div class="wiki-gallery">
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/sysprepoobe.png"
   caption="Regional Settings"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/sysprepoobe2.png"
   caption="EULA"
   author="KitSixtyFour"
   %}
</div>

## Desktop
<div class="wiki-gallery">
{% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/boot.png"
   caption="Boot screen"
   author="AveryEclipse"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/firstlogon.png"
   caption="Logon screen"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/logon2.png"
   caption="Ditto"
   author="AveryEclipse"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/activatewindows.png"
   caption="Activate Windows dialog"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/personalizedsettings.png"
   caption="Personalized Settings"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/firstboot.png"
   caption="First boot"
   author="AveryEclipse"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/desktop.png"
   caption="Desktop"
   author="AveryEclipse"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/desktop2.png"
   caption="Ditto, background applied"
   author="AveryEclipse"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/startmenu.png"
   caption="Start menu (All programs)"
   author="AveryEclipse"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/fileexplorer.png"
   caption="Windows Explorer"
   author="AveryEclipse"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/systemprop.png"
   caption="System Properties"
   author="AveryEclipse"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/winver.png"
   caption="About Windows"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/eula.png"
   caption="Microsoft Software License Terms"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/dxdiag.png"
   caption="DirectX Diagnostic Tool"
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/appwiz.png"
   caption="Programs and Features"
   author="KitSixtyFour"
   %}
</div>

## Sample Pictures/Desktop Backgrounds
<div class="wiki-gallery">
{% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/2026-02-28_19.05.31.png"
   caption="A landscape originating from the [KitsuMC](KitsuMC) Minecraft server."
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/2026-02-28_19.56.43.png"
   caption="Ditto, sunset."
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/2026-03-02_15.22.48.png"
   caption="Ditto."
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/2026-03-02_18.46.27.png"
   caption="LeCat (left) and Nishi (right) sitting on a bed."
   author="KitSixtyFour"
   %}
   {% include gallery_item.html
   image_src="resources/img/articles/winnishilecat/2026-03-02_18.18.01.png"
   caption="A solo picture of Nishi."
   author="KitSixtyFour"
   %}
</div>



# See also
- *[Making a Custom Windows Bootleg](Making_a_Custom_Windows_Bootleg)*

# Notes
[^1]: Alternatively known as *Microsoft Windows Code Name "Longhorn" Nishi & LeCat Edition 2026 Version 2003 R2 Home Premium* in the End User License agreement, *Windows Nishi & LeCat The Third Edition 2026 Version 2003 R2 Home Premium* in other miscellaneous media, and *Windows Vista Nishi & LeCat Edition 2026* in pre-release builds.
[^2]: *[me when im trying to upload windows nishi & lecat edition to archive.org but it keeps getting stuck at random file sizes](https://www.youtube.com/channel/UC_wPP8hARim12x52nCrhQng/posts?lb=UgkxY6tGaDgz7UW_nu54TPaWReRWFLwybn2l)*, *[it completed AND IT FUCKING SAID THERE WAS A NETWORK PROBLEM ISTG-](https://www.youtube.com/channel/UC_wPP8hARim12x52nCrhQng/posts?lb=UgkxlGk41xss3g1MXrXAScTa5Q9IUawzzDbc)* -- AstroNTWorkstation Community Posts (2026-05-08).

<!-- this article was actually fun to make idk why, would feature this one thousand times -stupidbifox -->