# Accessing PS3 Files from OFW via A PS3 Backup
Stand: 2020-04-07T18:58:00Z<br />
Succesfully tested FW: OFW 4.86, OFW 4.85, HFW 4.85, OFW 4.84, HFW 4.84 and OFW 4.82.<br />
Succesfully tested consoles: Fat PS3, Slim PS3 (30xx)

## Foreword
**!!! READ THE WHOLE GUIDE BEFORE DOING ANYTHING !!!**<br />
**!!! USE AT YOUR OWN RISK !!!**<br />
**!!! RESULTS MAY VARY !!!**

Intention is to show a way to access files without modifying a PS3.<br />
The major part of this guide is to dump necessary data only once from a PS3 console.
The IDPS is needed to decrypt the user folders and files inside a normal PS3 backup.
The wanted files from that PS3 console are then extracted from that PS3 backup.

[bguerville][25]'s PlayStation 3 Toolset runs on OFW 4.82-4.86 and retrieves all necessary data without any changes to the PS3.<br />
On the other hand [PS3Xploit][6]'s dumpers on OFW 4.82 or HFW 4.82-4.86 also provide dumps of users' `act.dat` files to verify the first PS3 backup extraction, plus dumps of the flash memory and xRegistry.
The temporary Hybrid Firmware (HFW) can be reversed completely.<br />
All trails of the dumps are discardable.

Other methods like PS3HEN, Custom Firmware (CFW) and HAN do change and/or do add files to the file system.
By the way HAN's file copier is not convenient enough for these tasks.
With these other methods getting all information and files could be done by just using their toolboxes, SEN Enabler, PSNpatch or webMAN-MOD plus a file/backup manager.

**!!! USE AT YOUR OWN RISK !!!**

## Table of Contents
* [Short Guide for Experts](#short-guide-for-experts)
* [Prerequisites](#prerequisites)
  * [PC: Prepare USB Device for PS3 in General](#pc-prepare-usb-device-for-ps3-in-general)
  * [PS3: Test USB Device on PS3 in General](#ps3-test-usb-device-on-ps3-in-general)
  * [PC: Place Necessary Files on USB Device](#pc-place-necessary-files-on-usb-device)
  * [PC: Install Necessary Tools](#pc-install-necessary-tools)
* [Dump Necessary Data from the PS3 (only once per console)](#dump-necessary-data-from-the-ps3-only-once-per-console)
  * [PS3: Check Date and Time](#ps3-check-date-and-time)
  * [PS3: Check USB Ports](#ps3-check-usb-ports)
  * [PS3: Install Hybrid Firmware (HFW) for Dumps](#ps3-install-hybrid-firmware-hfw-for-dumps)
  * [PS3: Prepare Dummy User plus Internet Browser for Dumps](#ps3-prepare-dummy-user-plus-internet-browser-for-dumps)
  * [PS3: Prepare Real User With Activation plus Internet Browser for Dumps](#ps3-prepare-real-user-with-activation-plus-internet-browser-for-dumps)
  * [PS3: Dump IDPS and Lowest Possible Firmware Version](#ps3-dump-idps-and-lowest-possible-firmware-version)
  * [PS3: Dump Flash Memory](#ps3-dump-flash-memory)
  * [PS3: Dump xRegistry](#ps3-dump-xregistry)
  * [PS3: Clean-up Dump Trails for Dummy User](#ps3-clean-up-dump-trails-for-dummy-user)
  * [PS3: Dump `act.dat`](#ps3-dump-actdat)
  * [PS3: Clean-up Dump Trails for Real User](#ps3-clean-up-dump-trails-for-real-user)
  * [PS3: Optionally Revert Firmware](#ps3-optionally-revert-firmware)
  * [PS3: USB Ports](#ps3-usb-ports)
* [Extract Files from A PS3 Backup](#extract-files-from-a-ps3-backup)
  * [PS3: Activate Titles from PS Store](#ps3-activate-titles-from-ps-store)
  * [PS3: Create A PS3 Backup](#ps3-create-a-ps3-backup)
  * [PC: Extract Wanted Files from A PS3 Backup](#pc-extract-wanted-files-from-a-ps3-backup)
  * [PC: Verify Validity of A PS3 Backup](#pc-verify-validity-of-a-ps3-backup)
* [Troubleshooting](#troubleshooting)
  * [Safe Mode](#safe-mode)
  * [Corrupted Backups](#corrupted-backups)
  * [Activation Errors](#activation-errors)
* [Alternative Ways](#alternative-ways)
  * [PC: Get IDPS and Lowest Possible Firmware Version from A PS3 Flash Memory Dump](#pc-get-idps-and-lowest-possible-firmware-version-from-a-ps3-flash-memory-dump)
  * [PC: Get Console's OpenPSID from A PS3 Backup (needs `idps.bin`)](#pc-get-consoles-openpsid-from-a-ps3-backup-needs-idpsbin)
  * [PS3: Determine Lowest Possible Firmware Version via Fake Firmware Update](#ps3-determine-lowest-possible-firmware-version-via-fake-firmware-update)

## Short Guide for Experts
* Get IDPS of PS3 console via [bguerville][25]'s PlayStation 3 Toolset on OFW 4.82-4.86 or via [PS3Xploit][6]'s dumper on OFW 4.82/HFW 4.84-4.86.
* Create a PS3 system backup ([1][19], [2][20]).
* Use [PS3Xport][7] with the IDPS binary file to extract wanted files from PS3 backup.

## Prerequisites
This guide uses Windows as the operating system (OS) to extract data from the PS3 backup, but this should be easily adoptable to other OSes as long as these can compile [PS3Xport source code][10] or have a binary of it available.

### What to use: bguerville's PlayStation 3 Toolset or PS3Xploit's dumper?
[bguerville][25]'s PlayStation 3 Toolset is normally sufficient as it already provides the IDPS data on a completely unmodified PS3 with OFW 4.82-4.86.
No USB HDD or USB stick is needed.
Therefore the guide will always describe the use of [bguerville][25]'s PlayStation 3 Toolset first.<br />
The [PS3Xploit][6]'s dumpers allow to extract more information, but need a correctly prepared USB HDD or USB stick plus installation of a slightly modified Hybrid Firmware (HFW).<br />
If a step is only necessary for one of these tools, then this is explicitly mentioned.

### PC: Prepare USB Device for PS3 in General
* **Note:** This step is only necessary when using [PS3Xploit][6]'s dumpers. But it is also a general guide for using USB storage devices with the PS3.
* Prepare a USB HDD or a USB stick formatted with FAT32 (PS3 doesn't support exFAT, NTFS or ext2/3/4).
  * USB 3.0 devices work on PS3 in general, but only in USB 2.0 mode and therefore with USB 2.0 speed.
  * Recommended device size is the HDD size from the PS3 plus 2-4 GiB extra to carry firmware files and additional files.
    * Minimum is the currently used space on the PS3 plus 2-4 GiB for the extras. Check the PS3's storage usage via `System > System Settings > System Information`.
    * Be generous, not miserly.
  * Sticks must be a either a typical Superdisk (unpartitioned) or partitioned with MBR (PS3 doesn't support GPT).
  * HDDs must be partitioned with MBR (PS3 doesn't support GPT).
  * Recommended is a cluster/allocation size of 64 KiB. Higher values like 128 KiB will increase the time of PS3 backup creation tremendously.
  * Windows: Use Ridgecrop's [Fat32Format][1] - `fat32format.exe -c128 X:`
    * Note that `-c128` is correct due to a sector size of 0.5 KiB.
  * Linux: `mkfs.vfat -F 32 -s 128 /dev/...`
    * Note that `-s 128` is correct due to a sector size of 0.5 KiB.
* Create the following folder structure on it:
  * `\DCIM`
  * `\MUSIC`
  * `\PHOTO`
  * `\PICTURE`
  * `\PS3`
  * `\PS3\BACKUP`
  * `\PS3\EXPORT`
  * `\PS3\EXPORT\BACKUP` (for PS3 system backups ([1][19], [2][20]))
  * `\PS3\GAME`
  * `\PS3\SAVEDATA`
  * `\PS3\THEME`
  * `\PS3\UPDATE` (for firmware updates ([1][17], [2][18]))
  * `\VIDEO`
* Check that there is enough free space remaining for the tasks to do.

### PS3: Test USB Device on PS3 in General
* **Note:** This step is only necessary when using [PS3Xploit][6]'s dumpers.
* Remove any USB extensions (hubs, etc.) from the PS3 as the original USB ports must be used for dumps.
  Typically the right (most inner) USB port of the PS3 is used (`/dev_usb000`).
* Connect USB HDD/stick to the PS3.
* Check that the USB HDD/stick is detected by the PS3 under Photo, Music and/or Video.
  * PS3 has problems with some USB sticks which use an uncommon internal structure. Only solution is to use another USB stick model.

### PC: Place Necessary Files on USB Device
* **Note:** This step is only necessary when using [PS3Xploit][6]'s dumpers.
* PS3 firmware files are valid for all regions.
* The needed **full** PS3 firmware files are called `PS3UPDAT.PUP`. The smaller patch files called `PS3PATCH.PUP` cannot be used for this guide.
* If the PS3 console is on Original Firmware (OFW) 4.8**2**, then there is no need to mess with the firmware. Just skip all OFW/HFW firmware related steps.
* Otherwise the Hybrid Firmware (HFW) 4.86/4.85/4.84 re-implements a web browser exploit from the Original Firmware (OFW) 4.82.
* Connect USB HDD/stick to the PC.
* Create a folder with the actual PS3 serial number on it, to put all console related files into: `\03-nnnnnnnn-nnnnnnn-CExxxxxxx`
  * Create an empty text file inside that folder with the name: `information.txt`
  * Write all the information from the case into that information text file, e.g. serial number, model number, date code, etc.
  * Determine the PS3's flash memory type by checking its console type (Fat/Slim/SuperSlim) and model number against the [Reddit wiki][2] and [PS Dev Wiki][3].
  * Write the flash memory type into the information text file too.
  * Additionally create sub-folders for each user on the PS3, e.g. by using their PSN name or account or just the PS3 user name.
    These folders will be used to backup the activation file (`act.dat`) of each user.
* Add Original Firmware (OFW) 4.86/4.85/4.84 to the USB HDD/stick.
  * Create the following folder on it: `\PS3\UPDATE\UPDATE_OFW485` and/or `\PS3\UPDATE\UPDATE_OFW484`
  * Download the full OFW 4.86/4.85/4.84 from the [PS3 Firmware archives][4].
  * Check its MD5 sum.
  * Put the PS3UPDAT.PUP into the corresponding folder `\PS3\UPDATE\UPDATE_OFW48x`.
* Add Hybrid Firmware (HFW) 4.86/4.85/4.84 to the USB HDD/stick.
  * Create the following folder on it: `\PS3\UPDATE\UPDATE_HFW485` and/or `\PS3\UPDATE\UPDATE_HFW484`
  * Download [HFW 4.86/4.85/4.84][5].
  * Check its MD5 sum.
  * Extract its PS3UPDAT.PUP into the corresponding folder `\PS3\UPDATE\UPDATE_HFW48x`.
* Check that there is enough free space remaining for the tasks to do (backup plus a buffer of at least 1 GiB).

### PC: Install Necessary Tools
* Install [PS3Xport][7] onto the PC by extracting its archive file.
  * Copy the batch file [`ExtractIndexes.cmd`](#file-extractindexes-cmd) into PS3Xport's main folder.
* Use either [FileFormat.info's Online Service][14] to view binary file content as hex or [HexEd.it Online Hex-Editor][26] to edit binary files, or have a tool available, e.g. [HxD][12], [Notepad++][13], etc.
* **Note:** A hex editor is needed when using [bguerville][25]'s PlayStation 3 Toolset.
  * Have a hex editor available to enter the IDPS information from the toolset into a binary file, e.g. [HexEd.it Online Hex-Editor][26],[HxD][12], [Notepad++][13], etc.

## Dump Necessary Data from the PS3 (only once per console)
**!!! USE AT YOUR OWN RISK !!!**

### PS3: Check Date and Time
* Check that the PS3's date and time are accurate via `Settings > Date and Time Settings`.

### PS3: Check USB Ports
* **Note:** This step is only necessary when using [PS3Xploit][6]'s dumpers.
* Remove any USB extensions (hubs, etc.) from the PS3 as the original USB ports must be used for dumps.
  Typically the right (most inner) USB port of the PS3 is used (`/dev_usb000`).

### PS3: Install Hybrid Firmware (HFW) for Dumps
* **Note:** This step is only necessary when using [PS3Xploit][6]'s dumpers.
* Skip these steps if the PS3 console is on OFW 4.82.
* Note: A downgrade is not possible with these steps.
* Connect USB HDD/stick to the PC.
* On the PC copy HFW 4.86/4.85/4.84 to the USB HDD/stick folder \PS3\UPDATE.
* Connect USB HDD/stick to the PS3.
* Log into the PS3 with the dummy user.
* On the PS3 "update" ([1][17], [2][18]) to HFW via `System > System Update > Update via Storage Media`.
  * Always flash twice, so that both flash banks are getting flashed anew.

### PS3: Prepare Dummy User plus Internet Browser for Dumps
* Create a dummy user without any PSN connection. Use that dummy user for anything related to "hacking".
  * There's one exception: get the `act.dat` of a real user with activation to verify the backups later.
* Log into the PS3 with the dummy user.
* Prepare the browser for IDPS, flash memory (either NAND/eMMc or NOR) and xRegistry dump.
  * Start `Network > Internet Browser`.
  * Define a blank "Home"/Start page via `Triangle > Tools > Home Page > Use Blank Page`.
    Necessary to make sure that later no JavaScript is executed before a exploit.
  * Reload "Home"/Start page via `Triangle > Home`.
  * **Note:** This step is only necessary when using [bguerville][25]'s PlayStation 3 Toolset.
    * Go to [http://www.ps3xploit.com/][25] via `Start`, the page will redirect to https://www.ps3xploit.net/bgtoolset/, then add a bookmark for it via `Select`.
  * **Note:** These steps are only necessary when using [PS3Xploit][6]'s dumpers.
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

### PS3: Prepare Real User With Activation plus Internet Browser for Dumps
* **Note:** This step is only necessary when using [PS3Xploit][6]'s dumpers.
* Log into the PS3 with the real user.
* Prepare the browser for `act.dat` dump.
  * Start `Network > Internet Browser`.
  * Define a blank "Home"/Start page via `Triangle > Tools > Home Page > Use Blank Page`.
    Necessary to make sure that later no JavaScript is executed before a exploit.
  * Reload "Home"/Start page via `Triangle > Home`.
  * Go to [http://ps3xploit.com/][6] via `Start`, then add a bookmark for it via `Select`.
  * Prepare `act.dat` dump.
    * From the home page menu select `v3 HAN Tools > ACT/IDPS Dumper`, then add a bookmark for it via `Select`.
    * Go back to its main page via `L2` or through its bookmark via `Select`.
  * Exit Browser via `Triangle > Exit > Yes`.

### PS3: Dump IDPS and Lowest Possible Firmware Version
* **Note:** The IDPS will never change for a console, even when restoring ("formatting") the PS3.
    Therefore it can also be used for any older backup of that console.
* Log into the PS3 with the dummy user.
* Dump IDPS with Internet Browser.
  * Start `Network > Internet Browser`.
* **Note:** These steps are for [bguerville][25]'s PlayStation 3 Toolset.
  * Tested successfully: PS3 Toolset v1.0.22/Flash Memory Manager v1.2.2 with OFW 4.86
  * Inside Internet Browser:
    * Go to `PS3 Toolset` through its bookmark via `Select`.
    * Wait for exploit initialization (beeps).
    * Go to button `Flash Memory Manager`.
    * Write the IDPS and minimum firmware version information into a text file for the related console, e.g. \03-nnnnnnnn-nnnnnnn-CExxxxxxx\information.txt.
    * Exit Browser via `Triangle > Exit > Yes`.
    * Open the hex editor and enter the IDPS data into a new file, save the binary file as `idps.bin`, e.g. \03-nnnnnnnn-nnnnnnn-CExxxxxxx\idps.bin.
* **Note:** These steps are for [PS3Xploit][6]'s dumpers.
  * Tested successfully: dumper 3.02 with HFW 4.85 and 4.84, dumper 3.01 with HFW 4.84
  * Connect USB HDD/stick to the PS3.
  * Make sure USB HDD/stick is connected to the right (most inner) USB port of the PS3 (`/dev_usb000`).
  * Inside Internet Browser:
    * Go to `v3 HAN Tools > Extra Tools > IDPS/PSID/Minver Dump > Run This Tool Now` through its bookmark via `Select`.
    * Press button `Initialize MemDump` and wait for the exploit to be applied.
      If it fails, then close browser and start again.
    * Press button `Trigger MemDump`.
    * Exit Browser via `Triangle > Exit > Yes`.
  * Connect USB HDD/stick to the PC.
  * On the PC move the files `idps.bin`, `psid.bin` and `minver.bin` into the folder with the PS3 serial number.
    * Note: The IDPS will never change for a console, even when restoring ("formatting") the PS3.
      Therefore it can also be used for any older backup of that console.
  * Display `minver.bin` [as hex](#pc-install-necessary-tools). The bytes state the lowest possible firmware version for that PS3 console in [BCD][15].
    * Example: 00 02 00 57 means version 2.57
    * Write the lowest possible firmware version into the information text file for the related console, e.g. \03-nnnnnnnn-nnnnnnn-CExxxxxxx\information.txt.

### PS3: Dump Flash Memory
* **Note:** This step is only possible when using [PS3Xploit][6]'s dumpers.
* Tested successfully: dumper 2.02 with HFW 4.85 and 4.84, dumper 2.01 with HFW 4.84
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
* **Note:** This step is only possible when using [PS3Xploit][6]'s dumpers.
* Tested successfully: dumper 3.02 with HFW 4.85 and 4.84, dumper 3.01 with HFW 4.84
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

### PS3: Clean-up Dump Trails for Dummy User
* Log into the PS3 with the dummy user.
* Delete trails in Internet Browser.
  * Start `Network > Internet Browser`.
  * Delete bookmarks of the PS3 Toolset or PS3Xploit via `Select`.
    * Either for each bookmark via `Triangle > Delete > Yes`, or `Triangle > Delete All` if only PS3Xploit bookmarks are present.
    * Press `Circle` to go back.
  * Delete cookies, search history and cache via `Triangle > Tools > Delete ... > Yes`.
  * Delete visit history via `Triangle > History > Triangle > Delete All > Yes`.
  * Exit Browser via `Triangle > Exit > Yes`.
* Delete dictionaries via `Settings > System Settings > Delete Predictive Text Dictionary`.
* Optionally delete dummy user.

### PS3: Dump `act.dat`
* **Note:** This step is only possible when using [PS3Xploit][6]'s dumpers.
* **Note:** Normally use the dummy user for anything related to "hacking" except for this single dump.
* The `act.dat` will be needed later to verify the backups.
* Tested successfully: tools 3.02 with HFW 4.85
* Connect USB HDD/stick to the PS3.
* Make sure USB HDD/stick is connected to the right (most inner) USB port of the PS3 (`/dev_usb000`).
* Log into the PS3 with the real user.
* Dump `act.dat` with Internet Browser.
  * Start `Network > Internet Browser`.
  * Go to `v3 HAN Tools > ACT/IDPS Dumper` through its bookmark via `Select`.
  * Press button `Initialize ACT/IDPS Dumper` and wait for the exploit to be applied.
    If it fails, then close browser and start again.
  * Press button `Dump ACT.DAT & IDPS`.
  * Exit Browser via `Triangle > Exit > Yes`.
* Connect USB HDD/stick to the PC.
* On the PC move the file `act.dat` into the related user sub-folder on the USB HDD/stick.<br />
  * Note: The `act.dat` will **change** with each new activation of that console for that user.
    So remember to re-dump whenever a new activation was done, otherwise validation will report false-false result.

### PS3: Clean-up Dump Trails for Real User
* **Note:** This step is only necessary when using [PS3Xploit][6]'s dumpers.
* Log into the PS3 with the real user.
* Delete trails in Internet Browser.
  * Start `Network > Internet Browser`.
  * Delete bookmarks of PS3Xploit via `Select`.
    * Either for each bookmark via `Triangle > Delete > Yes`, or `Triangle > Delete All` if only PS3Xploit bookmarks are present.
    * Press `Circle` to go back.
  * Delete cookies, search history and cache via `Triangle > Tools > Delete ... > Yes`.
  * Delete visit history via `Triangle > History > Triangle > Delete All > Yes`.
  * Exit Browser via `Triangle > Exit > Yes`.
* Delete dictionaries via `Settings > System Settings > Delete Predictive Text Dictionary`.

### PS3: Optionally Revert Firmware
* **Note:** This step is only necessary when using [PS3Xploit][6]'s dumpers.
* The PS3 console can now be reverted to OFW 4.86/4.85/4.84 if wanted.
  * Skip these steps if the PS3 console is on OFW 4.82.
  * Note: A downgrade is not possible with these steps.
  * Connect USB HDD/stick to the PC.
  * On the PC copy OFW 4.86/4.85/4.84 to the USB HDD/stick folder \PS3\UPDATE.
  * Connect USB HDD/stick to the PS3.
  * On the PS3 "update" ([1][17], [2][18]) to OFW via `System > System Update > Update via Storage Media`.
    * Always flash twice, so that both flash banks are getting flashed anew.

### PS3: USB Ports
* **Note:** This step is only necessary when using [PS3Xploit][6]'s dumpers.
* Any USB extensions (hubs, etc.) can be reconnected to the PS3 again.

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
* Create a PS3 system backup ([1][19], [2][20]) on the USB HDD/stick via `Settings > System Settings > Backup Utility > Back Up`.

### PC: Extract Wanted Files from A PS3 Backup
* Connect the device which contains the PS3 backup to the PC, e.g. USB HDD/stick.
* Make sure to copy `idps.bin` of the related PS3 console into PS3Xport's main folder.
* Drag the PS3 backup folder on the batch file [`ExtractIndexes.cmd`](#pc-install-necessary-tools) inside PS3Xport's main folder.
  This will create a text file inside PS3Xport's main folder with the name of the PS3 backup folder, that contains the complete index of the PS3 backup.
* Determine all wanted file entries in the archive index.
  * For example to separately backup the activation files (`act.dat`) and license files (`*.rif`, `*.edat`) use the following patterns: `/dev_hdd0/home/nnnnnnnn/exdata/act.dat`
* Run PS3Xport Tool.
* Enable IDPS mode to also work on the encrypted part of the PS3 backup.
* Extract all determined folders and/or files.
  * For the example above that would be the folders: `/dev_hdd0/home/nnnnnnnn/exdata`
* To better recognize the PS3 user additionally extract the following file from each related user folder: `/dev_hdd0/home/nnnnnnnn/localusername`
* **Note:** This step is only possible when using [PS3Xploit][6]'s dumpers.
  * It's recommended to [verify the extraction](#pc-verify-validity-of-a-ps3-backup).
* **Note:** This step is only valid for [bguerville][25]'s PlayStation 3 Toolset.
  * If other tools fail to work with the extracted files, then please re-check that the IDPS information was correctly transformed into the binary file `idps.bin`.
* Backup all activation files and licenses (`exdata` folders) plus `localusername` files to their related user sub-folders on the USB HDD/stick.
* It's recommended to backup the folder with the PS3 serial number of the USB HDD/stick in an additional place.
* Optionally when the user numbers are known, then the batch file [`ExtractBackup.cmd`](#file-extractbackup-cmd) can be used to extract all their files in single run.
  * Copy the batch file [`ExtractBackup.cmd`](#file-extractbackup-cmd) and [`users.txt`](#file-users-txt) into PS3Xport's main folder.
  * Maintain the user numbers in [`users.txt`](#file-users-txt).
  * Drag the PS3 backup folder on the batch file [`ExtractBackup.cmd`](#file-extractbackup-cmd) inside PS3Xport's main folder.

### PC: Verify Validity of A PS3 Backup
* **Note:** This step is only possible when using [PS3Xploit][6]'s dumpers.
* Compare the just extracted `act.dat` from the real user with the [earlier dumped `act.dat`](#ps3-dump-actdat). Use a proper [PC tool](#pc-install-necessary-tools) for this.
* If they differ it is very likely that the [backup is corrupted](#corrupted-backups).
  * Note: The `act.dat` will **change** with each new activation of that console for that user.
    So remember to [re-dump](#ps3-dump-actdat) whenever a new activation was done, otherwise validation will report false-false result.

## Troubleshooting

### Safe Mode
The [PS3 has a Safe Mode][21] which allows to restore the default settings ([1][22], [2][23]), restore the file system, rebuild the database, restore the PS3 system ([1][24]) or do an system update ([1][17], [2][18]), when the PS3 does not start normally anymore.

### Corrupted Backups
On a Slim PS3 (30xx) after the update to HFW 4.85 the backups became corrupted. The reason is unknown.
Solution was to [restore ("format") the PS3][24] completely as everything else did not fix it - like repair file system, database or restore default settings.

### Activation Errors
Errors may occur when activating a lot of titles in a short time, see [Activate Titles from PS Store](#ps3-activate-titles-from-ps-store).

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
* Make sure to copy `idps.bin` of the related PS3 console into PS3Xport's main folder.
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
[5]: https://www.psx-place.com/threads/23094/ "PSX-Place Forum - Hybrid Firmware 4.86/4.85/4.84"
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
[17]: https://www.playstation.com/en-us/support/system-updates/ps3/ "PS3 Support - System Software Update"
[18]: https://manuals.playstation.net/document/en/ps3/current/settings/update.html "PS3 Manual - System Update"
[19]: https://support.playstation.com/s/article/PS3-Backup-Utility?language=en_US "PS3 Support - Backup Utility"
[20]: https://manuals.playstation.net/document/en/ps3/current/settings/backuputility.html "PS3 Manual - Backup Utility"
[21]: https://support.playstation.com/s/article/PS3-Safe-Mode1?language=en_US "PS3 Support - Safe Mode"
[22]: https://support.playstation.com/s/article/Restore-PS3-Default-Settings?language=en_US "PS3 Support - Restore PS3 Default Settings"
[23]: https://manuals.playstation.net/document/en/ps3/current/settings/restore.html "PS3 Manual - Restore Default Settings"
[24]: https://manuals.playstation.net/document/en/ps3/current/settings/restoreps3.html "PS3 Manual - Restore PS3 System"
[25]: https://www.ps3xploit.net/ "bguerville's PlayStation 3 Toolset"
[26]: https://hexed.it/ "HexEd.it Online Hex-Editor"
