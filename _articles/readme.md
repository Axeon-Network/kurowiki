---
title: Microsoft Windows NT 5.2 build guide
permalink: nt5src
---


## Windows Server 2003 (NT 5.2.3790.0) build guide
*Version 10a, last updated 2020/11/29*

Build guide tested under XP SP3 x86, Win7 SP1 x86/x64 & Win10 x64, results may vary under other operating systems.

## Build Preparations
---

- It's recommended to disable any AV before extracting/building, as both of those actions create a lot of new files (your AV will likely try scanning every one, slowing down the extraction/build by quite a bit) - this also counts for any other tools that monitor files such as voidtools' Everything.
- **Ensure build machine date is current** - there's no longer any need to set date to 2003 or anything.
- Extract source tree to a folder named `srv03rtm` on the root of a drive (**important, as pre-built DirectUI files will only link properly under this path**), drive letter doesn't seem to matter (just don't use C:\ drive as that has some extra security), use `D:\srv03rtm\` as the path to match RTM binaries.
- Unset Read-only on extracted directory, including subfolders and files (note that after unsetting this and closing/reopening the folder properties again you might see that read-only has been set again, this is fine, as long as you unset it once it should let the build work without issue)
- Copy over files from this ZIP into source tree, overwriting existing files as necessary
- **If using a 64-bit host OS to build with:** copy the contents of the ZIPs `_x64` folder into the source tree, overwriting if asked.

**If your OS doesn't use UAC (XP/2003)**:
- Create desktop shortcut for `%windir%\system32\cmd.exe /k D:\srv03rtm\tools\razzle.cmd free offline` (see below for explanation) and change `Start in` to `D:\srv03rtm`
- **If using 64-bit host OS** use `razzle64.cmd` in the shortcut instead of `razzle.cmd`
- Open razzle window using shortcut you created.

**If your OS uses UAC (Vista+)**:
- Run command-prompt as administrator (can usually be done by typing cmd into start menu, right click `Command Prompt` -> `Run as administrator`)
- In the command-prompt, change to the drive you extracted source-code to by typing in the drive letter , eg. `E:`
- Change to the source folder: `cd srv03rtm`
- Now start razzle: `tools\razzle.cmd free offline` (**If using 64-bit host OS** use `tools\razzle64.cmd free offline` instead)

The first time you run razzle inside that copy of the source code it'll need to initialise a few things, give it a few minutes, after a while a Notepad window will appear - make sure to close this for the initialisation to continue.

**Important:** Once razzle has initialised run `tools\prebuild.cmd` to finish preparing the build environment (only need to run once after initing razzle for first time in this tree)

## Building
---

**Important:** Currently the build doesn't seem to play well when building with many (over 4) threads. If your build machine has more than that it's recommended to cap it to 4 threads maximum via the `-M 4` switch, added to the build command (eg. `build /cZP -M 4`, or `bcz -M 4`)

### Clean build

Performs clean rebuild of all components (**recommended for first build!**):

  - `build /cZP` (`bcz` is also aliased to this)

### "Dirty" build

Builds only components that have changed since last clean build:

  - `build /ZP` (`bz` is also aliased to this)

### Post-build

  - Download the [win2003_x86-missing-binaries.7z](https://gofile.io/d/SvWudI) pack, which contains missing binaries for both x86fre & x86chk builds.
  - From that 7z, extract the contents of the binaries folder for the build type you're building into your build trees binaries folder (eg. `D:\binaries.x86fre`, should have been created during the build), the 7z should contain files for all SKUs (uses pidgen.dll from Win2003 Enterprise, so your builds should accept Enterprise product keys)
  - **When asked during extraction to overwrite folders select `Yes`, but when asked to overwrite files like DUser.pdb/dll make sure to select `No`!**
  - Once missing files have been added, you should have files such as `binaries.x86{fre/chk}\_pop3_00.htm`, `binaries.x86{fre/chk}\ql10wnt.sys`, etc.
  - Inside the razzle window run `tools\postbuild.cmd` (use `-sku:{sku}` if you want to process only specific one (no brackets!), expect `filechk` errors if you ignore this and didn't use missing.7z / missing.cmd with every sku)

Once postbuild has finished, assuming you used the `win2003_x86-missing-binaries.7z` file above and followed the guide properly, it should have hopefully succeeded without errors, and there shouldn't be any `binaries.x86fre\build_logs\postbuild.err` file!

Otherwise take a look inside the `postbuild.err` - most messages in here are negligible, but if you see `filechk` errors associated with the edition you want to use, you may need to re-run `missing.cmd`, or extract `2k3-missing.7z` again.

If `postbuild.err` contains messages like `(crypto.cmd) ERROR` or `(ntsign.cmd) ERROR` try re-importing the `tools\driver.pfx` key-file (double-click it, press Next through the prompts, password is empty), and make sure your system date is set to the current date (updated certs are only valid from October 2020 to October 2021)

If postbuild.err has filechk errors about missing `hwcomp.dat` files, try copying the following into a batch script and run it in a razzle prompt (after using postbuild once already):

```
@echo off
hwdatgen -i:%_NTPOSTBLD%\pro\i386 -o:%_NTPOSTBLD%\.\hwcomp.dat
hwdatgen -i:%_NTPOSTBLD%\per\i386 -o:%_NTPOSTBLD%\perinf\hwcomp.dat
hwdatgen -i:%_NTPOSTBLD%\bla\i386 -o:%_NTPOSTBLD%\blainf\hwcomp.dat
hwdatgen -i:%_NTPOSTBLD%\sbs\i386 -o:%_NTPOSTBLD%\sbsinf\hwcomp.dat
hwdatgen -i:%_NTPOSTBLD%\srv\i386 -o:%_NTPOSTBLD%\srvinf\hwcomp.dat
hwdatgen -i:%_NTPOSTBLD%\ads\i386 -o:%_NTPOSTBLD%\entinf\hwcomp.dat
```

### Creating bootable ISO files

  - Execute `tools\oscdimg.cmd {sku} [destination-file (optional)]` where `{sku}` is one of: 
    - `srv` - Windows Server 2003 Standard Edition
    - `sbs` - Windows Server 2003 Small Business Edition
    - `ads` - Windows Server 2003 Enterprise Edition
    - `dtc` - Windows Server 2003 Datacenter Edition
    - `bla` - Windows Server 2003 Web Edition
    - `per` - Windows XP Home Edition
    - `pro` - Windows XP Professional
  - ISO will be saved to `{build-drive}\{build-tag}_{sku}.iso`, unless `[destination-file]` is provided as a parameter.

### Troubleshooting
If you get any problems during the build hopefully your problem might be answered here, if it's not feel free to post in the thread.

###### After running razzle it shows a bunch of errors, "tfindcer not recognized" etc
You're likely on a 64-bit system but running `razzle.cmd` directly, you should use `razzle64.cmd` instead, this'll set things up so that razzle will use the correct tools for you. Hopefully with that the `tfindcer not recognized` & other errors should go away.

###### During build I get a `directui.lib(parse.obj) LNK2011` error, mentioning `precompiled object not linked in`
This is caused by the pre-built parse.obj file we currently have to use in order to build a working directui.lib, currently this file requires your source tree to be inside a `srv03rtm` folder on the root of a drive, using any other folder will cause the error to happen. Sadly attempts to fix this such as editing the parse.obj or updating the code to build parse.cpp instead haven't been successful yet.

###### After a full build I get 1000+ errors, build.err has `has bad storage class` errors inside
Seems to be caused by your locale, this is reported to happen with Simplified Chinese language, but can probably happen with other languages too.
Besides changing your locale/language settings, you could also try editing the source files to remove the characters that cause problems, an anon posted a list of the files that need changes [here](https://archive.rebeccablacktech.com/g/thread/78406946/#78416976)

###### I get a `TAPI.RES` error during the build.
Try moving your source code folder closer to the root of the drive, ideally it should only be one folder up from the drive root (eg. `D:\srv03rtm\`)

###### On Windows 7 I get NTVDM crashes while building
All NTVDM errors should have hopefully been solved in the v8 release of this guide/ZIP, but if you still run into any NTVDM error a copy of your build.log file would help a lot to figure out what caused it, if you ZIP that up and post in the thread hopefully we can figure something out.

## Debugging
---

Kernel debugging can be enabled by editing the `C:\boot.ini` file in your installed build, and adding `/debug /debugport=COM1 /baudrate=115200` to the end of a config line.

For example here's a boot.ini with two choices, one with debugging & one without, with this NTLDR will show an OS boot choice menu at startup:

>[boot loader]
>timeout=30
>default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS
>[operating systems]
>multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Windows Server 2003, Enterprise" /fastdetect
>multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Windows Server 2003, Enterprise" /fastdetect /debug /debugport=COM1 /baudrate=115200

(even though they're named the same `Windows Server 2003, Enterprise`, NTLDR will add a `[debugger enabled]` tag to it on the OS selection menu.)

`chk (checked)` builds are preferred for debugging as they enable asserts & debug messages, though `chk` will run a lot slower than `fre` builds. `fre` builds can also be debugged fine, but usually with a lot less debug output.

Ideally you should also configure WinDbg to use the `binaries.{buildtype}\symbols.pri\retail` & `binaries.{buildtype}\symbols\retail` symbols folders too, if WinDbg is running on the same machine that compiled the build it should then also be able to do source-level debugging against the actual source files.

Note that if you're using a VM to host your build on you'll have to pass-through the emulated COM port over to a pipe somehow, for WinDbg/KD/IDA/etc to make use of.

There is apparently a way to get KDNET working on 2003 too (see https://github.com/MovAX0xDEAD/KDNET), but this is as-of-yet untested with our builds, seems like it should [have support](https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/supported-ethernet-nics-for-network-kernel-debugging-in-windows-8-1) for VMware's emulated network hardware at least.

(TODO: add more VM guides here... if anyone wants to post one in the thread I'm happy to add it here)

### VMware setup
For a VMware VM, just open the VM hardware options, **remove the printer hardware**, then click `Add...` and choose `Serial Port`.

In the serial-port config panel, set it to `Use named pipe`, and enter a pipe name into the textbox, eg. `\\.\pipe\vm`. The pipe should be setup as `This end is the server` & `The other end is a virtual machine`.

It's apparently recommended to use the `Yield CPU on poll` option, but I've had success without it, it's up to you.

With that setup now just open WinDbg, choose `Attach to kernel`, open the `COM` tab and enter the baud-rate and pipe name you selected for your VM, then hit OK.

Now WinDbg should start with `Waiting for reconnect` text showing, and hopefully when you next boot up your VM it'll connect up to WinDbg by itself.

### Debugging Setup/Installation
A debugger can be attached to setup by pressing F8 at the right time - for text-mode setup the right time is when asked `Press F6 if you need to install a third party SCSI or RAID driver`, spamming it while that message is showing should make it connect to COM1 with 19200 baud-rate (debug options can be changed inside `txtsetup.sif`, the `SetupDebugOptions` line specifies options to apply when F8 is pressed). After debug connection is made it might take a couple extra minutes for it to pass the `Setup is starting Windows` stage.

Similarly, GUI setup can be debugged by pressing F8 before the Windows bootloader starts (progress bar etc), this should bring up a menu with options for `Safe Mode`, `Debugging Mode`, etc. Choosing `Debugging Mode` will make it attach to COM1 before starting setup, again at 19200 baudrate.

### Changing default baudrate
The default 19200 baudrate can be changed by editing the `base\boot\kdcom\xxkdsup.c` file, search for `BD_19200` inside there and change it to e.g. `BD_115200`, now it should use that by default without needing any `/baudrate` parameter, or eg. when using `Debugging Mode` from the boot options menu.

### Un-filtering kernel messages
Even with a chk build you may notice that the kernel doesn't seem to output much over KD, this seems to be because most of the kernel components use `KdPrintEx`, which allows filtering KD messages to certain components (although MS's docs seem to suggest KdPrintEx filtering was only used in Vista, it does seem that 2003 makes use of it too)

To enable components you'll need to open the registry of your installed build to the following key (or create it if it doesn't exist)
>HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter\

Then create a DWORD value named the component you want to enable (eg. `LDR`), and set the value to hexadecimal `FFFFFFFF`.

A list of the component registry names can be found inside `base\published\obj\i386\dpfiltercm.c` after a build. This also contains the symbol names for the component (eg. `Kd_LDR_Mask`), which can be set directly through WinDbg/KD via the symbol name. (eg. `ed nt!Kd_LDR_Mask 0xFFFFFFFF`, with symbols loaded this should set the LDR components filter value in real-time)

The `WIN2000` components value (default `1`) is added to every components value, essentially making `WIN2000` the default value for all components - so setting this to `FFFFFFFF` should make every component print to KD. You'll get a ton more debug output from this, but all the KD prints will likely slow down the system a lot (unfortunately it doesn't seem possible to disable a component when using WIN2000 to enable them all)

If you need to enable components before your build is installed (eg. kernel is having problems before setup is completed), you'll need to edit the `mergedcomponents\setupinfs\hivesys.inx` file, anon [made a post about that here](https://archive.rebeccablacktech.com/g/thread/78588821/#78626788), though it hasn't been tried yet afaik.

## Additional Info
---

### prepatched\.zip additions list
- New unexpired test-signing certificates (valid to October 2021 - tools\openssl.txt describes how to generate them)
- Updated `midl.exe`/`midlc.exe` from Win2003 SP1 DDK, fixes olepro32.dll errors
- Reordered `dirs` file to ensure that `conlibk.lib` is built before it gets used
- parse.cpp/parse.hpp files required to build DirectUI.lib, and the bison.exe/Bison.skl files used to generate them.
- Pre-compiled parse.obj file, as the parse.cpp/parse.hpp mentioned above has some issues parsing things.. (parse.obj taken from win2003 directuid.lib - causes LNK4206 warnings when using it though, suppressed via changes to `sources` files)
- Pre-compiled GdiPlus v1.0.100.0 from RTM ISO, to be included into `asms01.cab` (x86 only), as the GdiPlus code sadly can't be built.
- Updated DUser build scripts, to make sure it gets placed in the proper location & gets built with the right optimization flags.
- Updated `windows\advcore\dirs` file to allow DUser/DirectUI to get built during main build
- Updated 16-bit build tools inside com\ole32\olethunk\ole16\tools\, and updated olethunk code so it'll build fine with them. (updates are only used if OS requires them to build, XP/2003 should be able to build them fine without changes)
- Disabled fixprn.pl, ntbackuponpersonal.cmd, gpmc.cmd, msi.cmd & incbbt.cmd calls from pbuild.dat, as we're missing required build-files for those (you can grab the results of those scripts from RTM ISO, or from the `2k3-missing-x86fre.7z` pack)
- Updated `setupw95.cmd` & `drivercab.cmd` to add a delay between async calls, fixes an issue with filename-collisions. (update only needed under newer OS's, older OS's like XP don't seem to have this issue)
- Updated `razzle.cmd` to always set `__BUILDMACHINE__` variable, allows build tag built into kernel to match with BuildName.txt (and won't leak your build OS username into the build-tag any more)
- Updated `razzle.cmd` to always set `NO_PDB_PATHS=1`, the build already uses FixPdbPaths.exe to remove file-paths from PDB, but that method leaves null-characters in place which aren't in the retail files, may as well enable this since there's no reason not to.
- Updated `ixsso` makefile, to prevent MIDL2346 warning from breaking the build (warning seems locale related, for some reason `BUILD_ALLOW_MIDL_WARNINGS` only worked when defined inside makefile, pretty strange)
- Reordered `windows\appcompat\dirs` file to help with single-core builds (from idkwhy's OpenXP git repo)
- Updated `msitoddf.cpp`, now closes the MSI package handle when finished (prevents stalling postbuild on Win10), and added fix for 64-bit build OS (redirects SysWOW64 to System32)
- Updated `mshtml.ref` reference file - used to compare mshtml output against known-good one? last updated in 1999(!), without updating it seems to randomly cause build error in certain conditions (I'm not sure why we never had problems with this until we tried 64-bit stuff though...)
- [x64] Added 32-bit mapsym.exe & rc.bat MSDOS-Player wrapper to `printscan\faxsrv\print\faxprint\faxdrv\win9x\sdk\binw16` dir, since some anons seemed to get errors from this folder.
- [x64] Replaced `masm.exe/mkpublic.exe` with 32-bit versions (taken from Sizzle), as some anons had issues with MS-DOS Player reporting a bad DOS version, breaking those two tools as they require DOS 2.0+
- [x64] Replaced MS-DOS Player for some 16-bit tools with recompiled amd64 versions, provided by an anon in the threads (many thanks!), source available inside `_x64\tools\tools16\16_bit_build_tools_v2.zip`
- Added missing `public\internal\windows\lib\amd64\usp10p.lib` library needed for amd64 build, taken from XPSP1 tree.
- Added parse.obj to `windows\advcore\duser\directui\engine\parser\obj\amd64` & `objd` folder, extracted from amd64 `directui.lib` file.
- Added `msgina_sp1.def` & `userenv_sp1.def` from the winlogon200X pack, these will make amd64 builds of msgina/userenv use the SP1 export ordinal numbers, improving compatibility with SP1 winlogon & possibly other SP1 files.
- Added `exinit.c` & `systime.c` from anon's decompilations, along with original exp.h (to overwrite older modified exp.h from earlier prepatched zip)
- Added pre-generated `inetsrv\iis\svcs\cmp\webdav\davcprox\fhcache_p.c` file, includes defs for both x86/x64, should help with issues switching between x86/x64 builds.
- Added `link.bat`/`link16.bat` wrappers for `link.exe`/`link16.exe`, which randomize TEMP env var and give it 5 retries before failing.
- Updated rc16 call inside `net\tapi\thunk\makefile.inc`, changed `WINNT=1` define to `WINNT` to fix an error under some NTVDM versions.
- `razzle64.cmd` which can take care of converting 16-bit tools to 32-bit (via `MS-DOS Player`), and setting required environment variables before launching razzle.
- `prebuild.cmd` that can handle installing driver.pfx keys, fixing file attributes, removing updated files if OS doesn't require them, and copying GdiPlus SxS policies.
- `missing.cmd` that can copy files we don't have source for from a mounted ISO.
- `oscdimg.cmd` to generate an ISO image from a finished post-build.

### x64 build OS support
prepatched\.zip v9 adds support for using x64 build OS's such as Win10 x64, this is done by wrapping certain 16-bit tools using `MS-DOS Player`, using .bat files to redirect calls to use the player, changing some makefiles to use 32-bit equivalents, etc.

Unfortunately some of the wrapped 16-bit tools can still randomly error without rhyme or reason for it, as a workaround the .bat files of the worst offenders will give it 5 attempts before failing, hopefully this should be enough to allow builds to complete fine, but there's still a chance one of the other 16-bit tools could error too... maybe in future I'll apply this 5-attempts bandaid over all the 16-bit tools.

Huge thanks to the anon who initially worked on fixing the 16-bit tools over at [https://rentry.co/16bit-msbuild](https://rentry.co/16bit-msbuild)!

### amd64 build support
As of update v10 an amd64 build can be created by initialising razzle with the `win64 amd64` options, the build should mostly complete without errors, but note that postbuild+ hasn't been updated at all to work properly with amd64 yet.

Unfortunately as the leak didn't come with exinit.obj/systime.obj for amd64 these need to be built from anon's decompilations instead. v10a adds newer exinit.c/systime.c decompilations that are apparently an exact match to the x86 .obj files included in the leak, hopefully these should work well with other architectures too.

Some anons have been slowly working on amd64, being able to get past text-mode setup and start booting GUI-mode setup, though sadly as of this release nobody has been able to actually get GUI mode to fully start up.

Note that this source code is from around ~2 years before amd64 was officially released by MS as Server2003 SP1, so there's likely a lot missing. (WRK may have some newer kernel-mode parts, being both based on SP1 and including support for amd64, though note that WRK also has many things removed too...)

However there's also many indications in the leak that MS did have amd64 running at this point, so it should eventually be possible for us to get it working too.

### Timebomb

- Time can be adjusted by editing `DAYS` variable inside `\tools\postbuildscripts\timebomb.cmd` (line 44)
- Setting `DAYS` to `0` will disable the timebomb.
- Only certain `DAYS` parameters are valid (0, 5, 15, 30, 60, 90, 120, 150, 180, 240, 360, 444)

### Different build options

You can modify your razzle shortcut (or execute it manually inside your source folder) to include (or remove) additional argument(s):

- `free` - build 'free' bits (production, omitting it will generated checked bits)
- `chkkernel` - build 'checked' (testing) kernel/hal/ntdll when building 'free' bits
- `no_opts` - disable binary optimization (useful for debugging, but will most likely fail a full build, some code can't be built without optimization)
- `verbose` - enable verbose output of the build process
- `binaries_dir <basepath>` - specifies custom output directory (default is `binaries`, the suffix added after `.` is non-customizable)
- `officialbuild` - sets razzle to build this as an "official" build, requires updating BuildMachines.txt, see the section below
- `win64 amd64` - builds for amd64 instead of x86, see `amd64 build support` section above.

Other options are not described here, see `razzle.cmd /?` for details.

### 'OfficialBuild' parameter / BuildMachines.txt
The `OfficialBuild` razzle parameter changes a few things in the build, which will make it match up closer to the retail builds, should be useful if you need to compare against retail for any reason.

For a list of things affected by the OfficialBuild parameter see [https://pastebin.com/VgVph3Xv](https://pastebin.com/VgVph3Xv) & [https://pastebin.com/gYzWGLM5](https://pastebin.com/gYzWGLM5), thanks to the anon that compiled them! (note that these aren't complete lists, and not all things mentioned here are guaranteed to take effect).

**However, using this parameter requires a file to be updated with info about your build machine first!**

An easy way to update the file required is to run the following command inside a razzle window, at the root of the source tree:

`echo %COMPUTERNAME%,primary,%_BuildBranch%,%_BuildArch%,%_BuildType%,ntblus >> tools\BuildMachines.txt`

After that you can run `tools\verifybuildmachine.cmd` to make sure it was setup correctly, if there's any problem an error message will show, otherwise the command will return without any message.

With that in place you should now be able to use the OfficialBuild parameter next time you init razzle, eg. `tools\razzle.cmd free offline officialbuild`

Some small notes to be aware of:

- if you change build arch or build type (eg. to amd64, or to a checked build) you'll need to run the echo command again to add your machine for that build arch/type combination
- if you see `Clearing OFFICIAL_BUILD_MACHINE variable` after initing razzle, rerun the echo command and then close down/reinit razzle again, else the build won't properly count itself as official.

### Creating fresh postbuild

- `tools\postbuild.cmd -full`
- `tools\missing.cmd`
- `tools\postbuild.cmd`

Use `-sku:{sku}` if you want to process only specific one (no brackets!)

### Building specific components

Most components can be built seperately. For example, if you wish to rebuild `ntos` component, perform these steps:
 - `cd base\ntos` (you can also use `ntos` alias that razzle has set up for you)
 - `bcz` (alias for `build /cPZ`)

Generally `postbuild.cmd` is clever enough to include your changes properly without needing fresh build as it uses `bindiff` to find differences.

### Generating new build number/name

Version information is stored in `\public\sdk\inc\ntverp.h`

You can also use `m0 set_builddate set_buildnum set_buildname` to generate new build name quickly.

### Original CD filenames

- `5.2.3790.0.srv03_rtm.030324-2048_x86fre_server-standard_retail_en-us-NRMSFPP_EN.iso` (SHA1: A600409482A5678EF6AF2B26D3576D6D9894178D)
- `5.2.3790.0.srv03_rtm.030324-2048_x86fre_server-datacenter_retail_en-us-NRMDOEM_EN.iso` (SHA1: E2B47A7CE45C6C6305594CEE4C1B64894805AAF4)
- `5.2.3790.0.srv03_rtm.030324-2048_x86fre_server-enterpriseserver_retail_en-us-NRMEFPP_EN.iso` (SHA1: 0309FFB4181BA5122C692A6E1079E9FC1D53FCE4)
- `5.2.3790.0.srv03_rtm.030324-2048_x86fre_server-webserver_retail_en-us-NRMWFPP_EN.iso` (SHA1: 46C1CCB2CFC96803E304A35BEF50CD71B2C1DE38)
- `sbs.iso` (converted from mdf; SHA1: CDB30C80FDE314C16CA11F5CD31650ECBEC7A214)
- `5.2.3790.0.srv03_rtm.030324-2048_x86chk_server-enterpriseserver_retail_en-us-NRMECHK_EN.iso` (SHA1: EEF5F921CC8FC20FB29A862E1E132359E0D151BB)
- `5.2.3790.1830.srv03_sp1_rtm.050324-1447_amd64fre_server-enterprise_retail_en-us-ARMEXFPP_EN.iso` (SHA1: 076EDCF017EDE0B2D0D8067FA52CF3D44EEEF79A)
- `5.2.3790.1830.srv03_sp1_rtm.050324-1447_amd64chk_server-enterprise_retail_en-us-AX2EXCFPP_EN.iso` (SHA1: 8916DFBB1D93A9CECB1FE8600BE2E2C752E85E7F)
- `5.1.2600.0.xpclient.010817-1148_x86fre_client-home_retail_en-us-WXHFPP_EN.iso` (SHA1: B273C8D41E3844E3E46722F52F5A4CF9F206C8D0)
- `5.1.2600.0.xpclient.010817-1148_x86fre_client-professional_retail_en-us-WXPFPP_EN.iso` (SHA1: 1400DED4402D50F3864ED3D8DCF5CC52BA79A04A)
- `5.1.2600.0.xpclient.010817-1148_x86chk_client-professional_retail_en-us-WXPFPP_EN.iso` (SHA1: 017F10E4555D1A9280874B9B0243442F045F1B2D)

### Product keys

- Standard Edition: M6RJ9-TBJH3-9DDXM-4VX9Q-K8M8M
- Enterprise Edition: QW32K-48T2T-3D2PJ-DXBWY-C6WRJ
- Enterprise x64: KK2WD-BFYJ6-77X87-8TRBF-9B343

## Changelog
---

Each major release will likely break dirty builds, requiring a fresh clean-build, it's recommended to apply new releases onto newly extracted source code if possible.

###### v10
- (v10a) Added `exinit.c` & `systime.c` from anons decompilations, along with original exp.h (to overwrite older modified exp.h from earlier prepatched zip)
- (v10a) Updated prebuild.cmd to remove the fre `exinit.obj`/`systime.obj` that was included with the leak, so our recreated versions will be used instead (allows building a closer-to-original chk kernel, instead of chk kernel containing fre exinit/systime bits) **Recommended to run prebuild.cmd again if you updated from an earlier prepatched ZIP!**
- (v10a) Updated missing.cmd to include some chk-only files, and srv_info.chm
- (v10a) Added pre-generated `inetsrv\iis\svcs\cmp\webdav\davcprox\fhcache_p.c` file, includes defs for both x86/x64, should help with issues switching between x86/x64 builds.
- (v10a) Added `link.bat`/`link16.bat` wrappers for `link.exe`/`link16.exe`, which randomize TEMP env var and give it 5 retries before failing.
- (v10a) Updated other .bat wrapper files to use 5 retries instead of 3.
- (v10a) Updated rc16 call inside `net\tapi\thunk\makefile.inc`, changed `WINNT=1` define to `WINNT` to fix an error under some NTVDM versions.
- [x64] Replaced MS-DOS Player for some 16-bit tools with recompiled amd64 versions, provided by an anon in the threads (many thanks!), source available inside `_x64\tools\tools16\16_bit_build_tools_v2.zip`
- Added missing `public\internal\windows\lib\amd64\usp10p.lib` library needed for amd64 build, taken from XPSP1 tree.
- Added parse.obj to `windows\advcore\duser\directui\engine\parser\obj\amd64` & `objd` folder, extracted from amd64 `directui.lib` file.
- Added updated `base\ntos\ex\exp.h` & amd64 exinit.obj/systime.obj files based on anon decompilations.
- Added `msgina_sp1.def` & `userenv_sp1.def` from the winlogon200X pack, these will make amd64 builds of msgina/userenv use the SP1 export ordinal numbers, improving compatibility with SP1 winlogon & possibly other SP1 files.

###### v9
- (v9c) [x64] Added 32-bit mapsym.exe & rc.bat MSDOS-Player wrapper to `printscan\faxsrv\print\faxprint\faxdrv\win9x\sdk\binw16` dir, since some anons seemed to get errors from this folder.
- (v9b) [x64] Replaced `masm.exe/mkpublic.exe` with 32-bit versions (taken from Sizzle), as some anons had issues with MS-DOS Player reporting a bad DOS version, breaking those two tools as they require DOS 2.0+ - thanks to the anon from the thread who helped test!
- 64-bit builder support: added `_x64` subdirectory containing fixed files, & `razzle64.cmd` for building under 64-bit hosts (tested under Win7SP1 x64 & Win10 x64)
- Updated razzle.cmd to set `NO_PDB_PATHS=1` without needing officialbuild parameter (reasoning in the additions list above)
- Fix `ixsso` build error by adding `BUILD_ALLOW_MIDL_WARNINGS=1` to makefile, stops MIDL2346 warning from breaking the build (warning seems to be caused by using a non-US locale? can this be fixed via parameters, or a locale-emulator?)
- Reorder `windows\appcompat\dirs` file to help with single-core builds (from idkwhy's OpenXP git repo)
- Updated `msitoddf.cpp`, now closes the MSI package handle when finished (prevents stalling postbuild on Win10), and added fix for 64-bit build OS (redirects SysWOW64 to System32)
- Updated `mshtml.ref` reference file - used to compare mshtml output against known-good one? last updated in 1999(!), without updating it seems to randomly cause build error in certain conditions (only started appearing on win10 though, never had them on win7/XP...)

###### v8
- (v8d) Revert `srv_info.chm` changes, as an anon managed to find that inside an XP x64 ISO image, now included inside `2k3-missing-x86fre-v7.7z`
- (v8d) Updated `cddirs.lst` to allow `valueadd\3rdparty` folder to be included into the CD image.
- (v8c) Updated razzle.cmd to always set `__BUILDMACHINE__` variable regardless of "offline" parameter, allows build tag built into kernel to match BuildName.txt
- **Note: the razzle.cmd change above will require clean-building afterwards! If you want to continue 'dirty'-building with your current build make sure you don't extract the updated razzle.cmd from this pack**
- (v8c) Made oscdimg.cmd use build tag from BuildName.txt as output filename if destination path isn't provided
- (v8c) Removed directui_XP.lib file, as our built directui.lib seems to work fine
- (v8b) Added pre-built parse.obj files for DirectUI, taken from win2003 directuid.lib - allows us to build a working version of DirectUI fine!
- (v8b) Updated `shell\cpls\appwzdui\winnt\sources`, `shell\ext\logondui\sources` & `shell\shell32\winnt\sources` files to suppress LNK4206 warning generated by pre-built parse.obj.
- (v8b) Deleted all references to `srv_info.chm` (which can't be located anywhere, no RTM ISOs seem to have it), may as well remove it so it can't mess up any more builds.
- (v8b) Updated `setupw95.cmd` & `drivercab.cmd` to add a delay between async calls, fixes an issue with filename-collisions. (update only needed under newer OS's, older OS's like XP don't seem to have this issue)
- (v8b) Updated `windows\advcore\dirs` file to allow DUser/DirectUI to get built during main build
- (v8a) Disabled incbbt.cmd from pbuild.dat, as the incbbt.cmd file is missing
- Updated 16-bit build tools inside com\ole32\olethunk\ole16\tools\, and updated olethunk code so it'll build fine with them.
- Removed pre-built 16-bit code
- Updated prebuild.cmd to handle the updated 16-bit tools instead of using pre-built stuff (will only use updated files if OS requires them)
- Disabled fixprn.pl, ntbackuponpersonal.cmd, gpmc.cmd and msi.cmd calls from pbuild.dat, as we're missing required build-files for those (you can grab the results of those scripts from RTM ISO, or from the `2k3-missing-x86fre.7z` pack)
- Thanks to anon who made `2k3-missing-x86fre`, we should now be able to build without any postbuild errors!

###### v7
- (7e) removed DUser/DirectUI building instructions, readded DUser.dll to missing.cmd - sadly our built one doesn't work properly and breaks `pro` sku's login screen. Likely because of Bison.skl being customized by MS, which was missing from the source code.
- (7d) removed DUser.dll from missing.cmd
- (7c) changed DUser placefil.txt so DUser.dll gets placed in binaries.x86fre root
- (7c) updated DUser bldenv.cmd so that 'bldenv release' will also reset optimization flags, now release builds will get proper optimization
- includes Win7 fixes from guideanon's v4 toolkit, hopefully reduces NTVDM errors for people
- adds files & instructions for building DUser.dll/DirectUI.lib, can now build a proper server2003 version of it instead of needing the WinXP one
- adds pre-built GdiPlus 1.0.100.0, since we can't build GdiPlus code atm (should allow building a working `asms01.cab`/`hivesxs.inf`)
- removed `asms01.cab`/`hivesxs.inf` from missing.cmd
- moved prebuild to `tools\prebuild.cmd`, no longer deletes itself afterwards in case it needs to be ran again
- re-ordered some of the build preparation steps, added details about building `DirectUI.lib` before the main build