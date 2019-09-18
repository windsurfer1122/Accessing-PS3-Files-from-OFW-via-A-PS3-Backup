# Accessing PS3 Files from OFW via A PS3 Backup
Stand: 2019-09-18T19:45:00Z<br />
Tested FW: HFW 4.85, HFW 4.84

## Foreword
**!!! READ THE WHOLE GUIDE BEFORE DOING ANYTHING !!!**<br />
**!!! USE AT YOUR OWN RISK !!!**

Intention is to show a way to access files without modifying a PS3.
The temporary Hybrid Firmware (HFW) can be reversed completely.
Also all trails of the dumps are discardable.
Works as of OFW 4.82 and OFW/HFW 4.85/4.84.

The major part of this guide is to dump necessary data only once from a PS3 console.
The IDPS is needed to decrypt the user folders and files inside a normal PS3 backup.
The wanted files from that PS3 console are then extracted from that PS3 backup.

Other methods like HAN, PS3HEN and Custom Firmware (CFW) do change and/or do add files to the file system.
By the way HAN's file copier is not convenient enough for these tasks.
On the others getting all information and files could be done by just using their toolboxes, SEN Enabler, PSNpatch or webMAN-MOD plus a file/backup manager.

**!!! USE AT YOUR OWN RISK !!!**

## Table of Contents
* [Short Guide for Experts](#short-guide-for-experts)
* [Prerequisites](#prerequisites)
  * [PC: Prepare USB Device for PS3 in General](#pc-prepare-usb-device-for-ps3-in-general)
  * [PS3: Test USB Device on PS3 in General](#ps3-test-usb-device-on-ps3-in-general)
  * [PC: Place Necessary Files on USB Device](#pc-place-necessary-files-on-usb-device)
  * [PC: Install Necessary Tools](#pc-install-necessary-tools)
* [Dump Necessary Data from the PS3 (only once per console)](#dump-necessary-data-from-the-ps3-only-once-per-console)
  * [PS3: Check Date and Time, Prepare Dummy User plus Internet Browser for Dumps](#ps3-check-date-and-time-prepare-dummy-user-plus-internet-browser-for-dumps)
  * [PS3: Install Hybrid Firmware (HFW) 4.85 for Dumps](#ps3-install-hybrid-firmware-hfw-485-for-dumps)
  * [PS3: Dump IDPS, OpenPSID and Lowest Possible Firmware Version](#ps3-dump-idps-openpsid-and-lowest-possible-firmware-version)
  * [PS3: Dump Flash Memory](#ps3-dump-flash-memory)
  * [PS3: Dump xRegistry](#ps3-dump-xregistry)
  * [PS3: Clean-up Dump Trails](#ps3-clean-up-dump-trails)
* [Extract Files from A PS3 Backup](#extract-files-from-a-ps3-backup)
  * [PS3: Activate Titles from PS Store](#ps3-activate-titles-from-ps-store)
  * [PS3: Create A PS3 Backup](#ps3-create-a-ps3-backup)
  * [PC: Extract Wanted Files from A PS3 Backup](#pc-extract-wanted-files-from-a-ps3-backup)
* [Alternative Ways](#alternative-ways)
  * [PC: Get IDPS and Lowest Possible Firmware Version from A PS3 Flash Memory Dump](#pc-get-idps-and-lowest-possible-firmware-version-from-a-ps3-flash-memory-dump)
  * [PC: Get Console's OpenPSID from A PS3 Backup  (needs `idps.bin`)](#pc-get-consoles-openpsid-from-a-ps3-backup-needs-idpsbin)
  * [PS3: Determine Lowest Possible Firmware Version via Fake Firmware Update](#ps3-determine-lowest-possible-firmware-version-via-fake-firmware-update)

## Short Guide for Experts
* Get IDPS of PS3 console via [PS3Xploit][6]'s dumper.
* Create a PS3 backup.
* Use [PS3Xport][7] with the IDPS binary file to extract wanted files from PS3 backup.

## Prerequisites
This guide uses Windows as the operating system (OS) to extract data from the PS3 backup, but this should be easily adoptable to other OSes as long as these can compile [PS3Xport source code][10] or have a binary of it available.

### PC: Prepare USB Device for PS3 in General
* Prepare a USB HDD or a USB stick formatted with FAT32 (PS3 doesn't support exFAT, NTFS or ext2/3/4).
  * USB 3.0 devices work on PS3 in general, but only in USB 2.0 mode and therefore with USB 2.0 speed.
  * Recommended device size is the HDD size from the PS3 plus 2-4 GiB extra to carry firmware files and additional files.
    * Minimum is the currently used space on the PS3 plus 2-4 GiB for the extras. Check the PS3's storage usage via `System > System Settings > System Information`.
    * Be generous, not miserly.
  * Sticks must be a either a typical Superdisk (unpartitioned) or partitioned with MBR (PS3 doesn't support GPT).
  * HDDs must be partitioned with MBR (PS3 doesn't support GPT).
  * Recommended is a cluster/allocation size of 64 KiB. Higher values like 128 KiB will increase the time of PS3 backup creation tremendously.
  * Windows: Use Ridgecrop's [Fat32Format][1] - `fat32format.exe -c128 X:`
  * Linux: `mkfs.vfat -F 32 -s 128 /dev/...`
* Create the following folder structure on it:
  * `\DCIM`
  * `\MUSIC`
  * `\PHOTO`
  * `\PICTURE`
  * `\PS3`
  * `\PS3\BACKUP`
  * `\PS3\EXPORT`
  * `\PS3\EXPORT\BACKUP`
  * `\PS3\GAME`
  * `\PS3\SAVEDATA`
  * `\PS3\THEME`
  * `\PS3\UPDATE` (for Firmware updates)
  * `\VIDEO`
* Check that there is enough free space remaining for the tasks to do.

### PS3: Test USB Device on PS3 in General
* Remove any USB extensions (hubs, etc.) from the PS3 as the original USB ports must be used for dumps.
  Typically the right (most inner) USB port of the PS3 is used (`/dev_usb000`).
* Connect USB HDD/stick to the PS3.
* Check that the USB HDD/stick is detected by the PS3 under Photo, Music and/or Video.
  * PS3 has problems with some USB sticks which use an uncommon internal structure. Only solution is to use another USB stick model.

### PC: Place Necessary Files on USB Device
* PS3 firmware files are valid for all regions.
* The needed **full** PS3 firmware files are called `PS3UPDAT.PUP`. The smaller patch files called `PS3PATCH.PUP` cannot be used for this guide.
* If the PS3 console is on Original Firmware (OFW) 4.8**2**, then there is no need to mess with the firmware. Just skip all OFW/HFW firmware related steps.
* Otherwise the Hybrid Firmware (HFW) 4.85 re-implements a web browser exploit from the Original Firmware (OFW) 4.82.
* Connect USB HDD/stick to the PC.
* Create a folder with the actual PS3 serial number on it, to put all console related files into: `\03-nnnnnnnn-nnnnnnn-CExxxxxxx`
  * Create an empty text file inside that folder with the name: `information.txt`
  * Write all the information from the case into that information text file, e.g. serial number, model number, date code, etc.
  * Determine the PS3's flash memory type by checking its console type (Fat/Slim/SuperSlim) and model number against the [Reddit wiki][2] and [PS Dev Wiki][3].
  * Write the flash memory type into the information text file too.
  * Additionally create sub-folders for each user on the PS3, e.g. by using their PSN name or account or just the PS3 user name. These folders will be used to backup the activation file (`act.dat`) of each user.
* Add Original Firmware (OFW) 4.85 to the USB HDD/stick.
  * Create the following folder on it: `\PS3\UPDATE\UPDATE_OFW485`
  * Download the full OFW 4.85 from the [PS3 Firmware archives][4].
  * Check its MD5 sum.
  * Put the PS3UPDAT.PUP into \PS3\UPDATE\UPDATE_OFW485.
* Add Hybrid Firmware (HFW) 4.85 to the USB HDD/stick.
  * Create the following folder on it: `\PS3\UPDATE\UPDATE_HFW485`
  * Download [HFW 4.85][5].
  * Check its MD5 sum.
  * Extract its PS3UPDAT.PUP into \PS3\UPDATE\UPDATE_HFW485.
* Check that there is enough free space remaining for the tasks to do (backup plus a buffer of at least 1 GiB).

### PC: Install Necessary Tools
* Install [PS3Xport][7] onto the PC by extracting its archive file.
  * Copy the batch file [`ExtractIndexes.cmd`](#file-extractindexes-cmd) into PS3Xport's main folder.
* Use either [FileFormat.info's Online Service][14] to view binary file content as hex, or have a tool available, e.g. [HxD][12], [Notepad++][13], etc.

## Dump Necessary Data from the PS3 (only once per console)
**!!! USE AT YOUR OWN RISK !!!**

### PS3: Check Date and Time, Prepare Dummy User plus Internet Browser for Dumps
* Check that the PS3's date and time are accurate via `Settings > Date and Time Settings`.
* Create a dummy user without any PSN connection. Use that dummy user for anything related to "hacking".
* Log into the PS3 with the dummy user.
* Prepare the browser for IDPS dump and flash memory dump (either NAND/eMMc or NOR).
  * Start `Network > Internet Browser`.
  * Define a blank "Home"/Start page via `Triangle > Tools > Home Page > Use Blank Page`.
    Necessary to make sure that later no JavaScript is executed before a exploit.
  * Reload "Home"/Start page via `Triangle > Home`.
  * Go to [http://ps3xploit.com/][6] via `Start`, then add a bookmark for it via `Select`.
  * Prepare IDPS, OpenPSID and Minimal Possible Firmware dump.
    * From the home page menu select `v3 HAN Tools > Extra Tools > IDPS/PSID/Minver Dump > Run This Tool Now`, then add a bookmark for it via `Select`.
    * Go back to its main page via `L2` or through its bookmark via `Select`.
  * Prepare flash memory dump.
    * From the home page menu select `Flash Dumper > Dump Flash To USB/HDD > <flash memory type of the PS3>`, then add a bookmark for it via `Select`.
    * Go back to its main page via `L2` or through its bookmark via `Select`.
  * Prepare xRegistry dump.
    * From the home page menu select `v3 HAN Tools > *Extra Tools* > xRegistry Tools > xRegistry Dumper > Run this tool now`, then add a bookmark for it via `Select`.
    * Go back to its main page via `L2` or through its bookmark via `Select`.
  * Exit Browser via `Triangle > Exit > Yes`.

### PS3: Install Hybrid Firmware (HFW) 4.85 for Dumps
* Skip these steps if the PS3 console is on OFW 4.82.
* Connect USB HDD/stick to the PC.
* On the PC copy HFW 4.85 to the USB HDD/stick folder \PS3\UPDATE.
* Connect USB HDD/stick to the PS3.
* Log into the PS3 with the dummy user.
* On the PS3 "update" to HFW 4.85 via `System > System Update > Update via Storage Media`.

### PS3: Dump IDPS, OpenPSID and Lowest Possible Firmware Version
* Tested successfully: dumper 3.02 with 4.85 and 4.84, dumper 3.01 with 4.84
* Connect USB HDD/stick to the PS3.
* Make sure USB HDD/stick is connected to the right (most inner) USB port of the PS3 (`/dev_usb000`).
* Log into the PS3 with the dummy user.
* Dump IDPS with Internet Browser.
  * Start `Network > Internet Browser`.
  * Go to `v3 HAN Tools > Extra Tools > IDPS/PSID/Minver Dump > Run This Tool Now` through its bookmark via `Select`.
  * Press button `Initialize MemDump` and wait for the exploit to be applied.
    If it fails, then close browser and start again.
  * Press button `Trigger MemDump`.
  * Exit Browser via `Triangle > Exit > Yes`.
* Connect USB HDD/stick to the PC.
* On the PC move the files `idps.bin`, `psid.bin` and `minver.bin` into the folder with the PS3 serial number.
* Display `minver.bin` [as hex](#pc-install-necessary-tools). The bytes state the lowest possible firmware version for that PS3 console in [BCD][15].
  * Example: 00 02 00 57 means version 2.57
  * Write the lowest possible firmware version into the information text file for the related console, e.g. \03-nnnnnnnn-nnnnnnn-CExxxxxxx\information.txt.

### PS3: Dump Flash Memory
* Tested successfully: dumper 2.02 with 4.85 and 4.84, dumper 2.01 with 4.84
* Connect USB HDD/stick to the PS3.
* Make sure USB HDD/stick is connected to the right (most inner) USB port of the PS3 (`/dev_usb000`).
* Log into the PS3 with the dummy user.
* Dump flash memory with Internet Browser.
  * Start `Network > Internet Browser`.
  * Go to `Flash Dumper > Dump Flash To USB/HDD > <flash memory type>` through its bookmark via `Select`.
  * Press button `Initialize exploitation` and wait for the exploit to be applied.
    If it fails, then close browser and start again.
  * Press button `Dump <flash memory type>`.
  * Exit Browser via `Triangle > Exit > Yes`.
* Connect USB HDD/stick to the PC.
* On the PC move the file `dump.hex` into the folder with the PS3 serial number.

### PS3: Dump xRegistry
* Tested successfully: dumper 3.02 with 4.85 and 4.84, dumper 3.01 with 4.84
* Connect USB HDD/stick to the PS3.
* Make sure USB HDD/stick is connected to the right (most inner) USB port of the PS3 (`/dev_usb000`).
* Log into the PS3 with the dummy user.
* Dump xRegistry with Internet Browser.
  * Start `Network > Internet Browser`.
  * Go to `v3 HAN Tools > *Extra Tools* > xRegistry Tools > xRegistry Dumper > Run this tool now` through its bookmark via `Select`.
  * Press button `Initialize xRegistry Dumper` and wait for the exploit to be applied.
    If it fails, then close browser and start again.
  * Press button `Dump File From Flash`.
  * Exit Browser via `Triangle > Exit > Yes`.
* Connect USB HDD/stick to the PC.
* On the PC move the file `xRegistry.sys` into the folder with the PS3 serial number.

### PS3: Clean-up Dump Trails
* Any USB extensions (hubs, etc.) can be reconnected to the PS3 again.
* Log into the PS3 with the dummy user.
* Delete trails in Internet Browser.
  * Start `Network > Internet Browser`.
  * Delete bookmarks of PS3Xploit via `Select`.
    * Either for each bookmark via `Triangle > Delete > Yes`, or `Triangle > Delete All` if only PS3Xploit bookmarks present.
    * Press `Circle` to go back.
  * Delete cookies, search history and cache via `Triangle > Tools > Delete ... > Yes`.
  * Delete visit history via `Triangle > History > Triangle > Delete All > Yes`.
  * Exit Browser via `Triangle > Exit > Yes`.
* Delete dictionaries via `Settings > System Settings > Delete Predictive Text Dictionary`.
* Optionally delete dummy user.
* The PS3 console can now be reverted to OFW 4.85 if wanted.
  * Skip these steps if the PS3 console is on OFW 4.82.
  * Connect USB HDD/stick to the PC.
  * On the PC copy OFW 4.85 to the USB HDD/stick folder \PS3\UPDATE.
  * Connect USB HDD/stick to the PS3.
  * On the PS3 "update" to OFW 4.85 via `System > System Update > Update via Storage Media`.
    * Always flash twice, so that both flash banks are getting flashed anew.

## Extract Files from A PS3 Backup

### PS3: Activate Titles from PS Store
* **ATTENTION! ACTIVATION LIMIT!** To avoid getting a temporary(!) activation block ([error 80029780][9], see also [this blog][11]) only do ~32 titles per 24 hours.
  The limit seems to be ~256 activations per 7 days.
* Log into the PS3 with the user whose titles shall be activated.
* Download the titles via `PlayStation Network > PlayStation Store > View Downloads`.
* For each title the "Activating" phase at the beginning must be completed to get the license files inside the home folder of the PS3 user.
* The following "Download" phase can be cancelled, no need to wait for multiple GiBs to be downloaded.
* After ~32 titles the [error 80710003][9] "Memory allocation error" will always occur.
  * Activating sometimes work even after that error, but that seems to be accidentally.
  * Just note down the current title and its purchase date.
  * Restart the PS3.
  * Continue with the next title.
  * Keep the activation limit in mind.
* When all titles have been activated but not downloaded, then the occupied storage space on the PS3 got only slightly increased as a license file consumes only some KiB.

### PS3: Create A PS3 Backup
* Connect USB HDD/stick to the PS3.
* Log into the PS3 with any user.
* Create a PS3 backup on the USB HDD/stick via `Settings > System Settings > Backup Utility > Back Up`.

### PC: Extract Wanted Files from A PS3 Backup
* Connect the device which contains the PS3 backup to the PC, e.g. USB HDD/stick.
* Make sure to copy `idps.bin` of the related PS3 console into PS3xploit's main folder.
* Drag the PS3 backup folder on the batch file [`ExtractIndexes.cmd`](#pc-install-necessary-tools) inside PS3Xport's main folder.
  This will create a text file inside PS3Xport's main folder with the name of the PS3 backup folder, that contains the complete index of the PS3 backup.
* Determine all wanted file entries in the archive index.
  * For example to separately backup the activation files (`act.dat`) and license files (`*.rif`, `*.edat`) use the following patterns: `/dev_hdd0/home/*/exdata/act.dat`
* Run PS3Xport Tool.
* Enable IDPS mode to also work on the encrypted part of the PS3 backup.
* Extract all determined folders and/or files.
  * For the example above that would be the folders: `/dev_hdd0/home/*/exdata`
* To better recognize the PS3 user additionally extract the following file from each related user folder: `/dev_hdd0/home/*/localusername`
* Backup all activation files and licenses (`exdata` folders) plus `localusername` files to their related user sub-folders on the USB HDD/stick.
* It's recommended to backup the folder with the PS3 serial number of the USB HDD/stick in an additional place.

## Alternative Ways

### PC: Get IDPS and Lowest Possible Firmware Version from A PS3 Flash Memory Dump
* Install [PS3 NOR/NAND Statistic (aka dumpstatistic)][16] onto the PC by extracting its archive file.
* Start PS3 NOR/NAND Statistic.
* Drag the PS3 flash memory dump onto its window.
* Save the IDPS.
  Rename the file from `IDPS` to `idps.bin`.
  Move `idps.bin` into the folder with the PS3 serial number on the USB HDD/stick.
* Write the lowest possible firmware version (`field "min. Firmware"`) into the information text file for the related console, e.g. \03-nnnnnnnn-nnnnnnn-CExxxxxxx\information.txt.
  * Example: 257.000 means version 2.57

### PC: Get Console's OpenPSID from A PS3 Backup (needs `idps.bin`)
* Copy the batch file [`ExtractPSID.cmd`](#file-extractpsid-cmd) into PS3Xport's main folder.
* Connect the device with the PS3 backup to the PC.
* Make sure to copy `idps.bin` of the related PS3 console into PS3xploit's main folder.
* Drag the PS3 backup folder on the batch file `ExtractPSID.cmd` inside PS3Xport's main folder.
* Move the created `psid.bin` into the folder with the PS3 serial number on the USB HDD/stick.

### PS3: Determine Lowest Possible Firmware Version via Fake Firmware Update
* Connect USB HDD/stick to the PC.
* Add Fake Firmware "Minimal Possible Firmware Check" to the USB HDD/stick.
  * Create the following folder on it: `\PS3\UPDATE\UPDATE_MinVerChk`
  * Download MinVer PUP from [PS3Xploit][6] via home page menu `Flash Writer > Download MinVer PUP`.
  * Extract its PS3UPDAT.PUP into \PS3\UPDATE\UPDATE_MinVerChk.
* On the PC copy Fake Firmware "Mininmal Possible Firmware Check" to the USB HDD/stick folder \PS3\UPDATE.
* Connect USB HDD/stick to the PS3.
* Log into the PS3 with any user.
* On the PS3 "update" to the Fake Firmware via `System > System Update > Update via Storage Media`.
* There won't be any update, but it displays the minimal firmware version possible for that PS3 console.
* Note down the version.
* Connect USB HDD/stick to the PC.
* Write the version into the information text file for the related console, e.g. \03-nnnnnnnn-nnnnnnn-CExxxxxxx\information.txt.


[1]: http://www.ridgecrop.demon.co.uk/fat32format.htm "Ridgecrop Consultants Ltd. - fat32format utility"
[2]: https://www.reddit.com/r/ps3homebrew/wiki/how_to_hack "Reddit Wiki - Console Hack Compatibility"
[3]: https://www.psdevwiki.com/ps3/SKU_Models "PS Dev Wiki - Console Model/SKU List"
[4]: https://darthsternie.net/ps3-firmwares/ "Darthsternie's Firmware Archive - PS3"
[5]: https://www.psx-place.com/threads/23094/ "PSX-Place Forum - Hybrid Firmware 4.85/4.84"
[6]: http://ps3xploit.com/ "PS3Xploit Home Page"
[7]: https://www.psx-place.com/threads/21448/ "PSX-Place Forum - PS3Xport"
[8]: https://www.psx-place.com/threads/24890/ "PSX-Place Forum - Bug report for IDPS dumper"
[9]: https://www.playstation.com/en-gb/get-help/#!/error-code/ "Sony PlayStation Help - PlayStation Error Code"
[10]: https://github.com/kakaroto/ps3xport "Kakaroto on GitHub - PS3Xport repository"
[11]: http://www.vegettoex.com/2012/01/06/psp-game-transfers-and-error-message-woes/ "VegettoEX Blog - PSP Game Transfer and Error Message Woes"
[12]: https://mh-nexus.de/ "HxD Home Page"
[13]: https://notepad-plus-plus.org/ "Notepad++ Home Page"
[14]: https://www.fileformat.info/tool/hexdump.htm "FileFormat.info - Online HexDump Utility"
[15]: https://en.wikipedia.org/wiki/Binary-coded_decimal "Wikipedia - Binary-coded Decimals"
[16]: https://www.psx-place.com/resources/858/ "PSX-Place Forum - PS3 NOR/NAND Statistic (aka dumpstatistic)"
