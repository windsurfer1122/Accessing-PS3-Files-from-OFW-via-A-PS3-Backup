@echo off
@pushd "%~dp0\Tools"

set IDPS=..\idps.bin
set USERS=..\users.txt
set TARGETDIR=..\%~n1
for /F %%u in (%USERS%) do (
  @echo Extracting /dev_hdd0/home/%%u/^(localusername^|exdata^)...
  mkdir "%TARGETDIR%/dev_hdd0/home/%%u" 2>NUL
  PS3Xport.exe ^
    SetDeviceID "%IDPS%" ^
    ExtractFile "%~1" "/dev_hdd0/home/%%u/localusername" "%TARGETDIR%/dev_hdd0/home/%%u/localusername" ^
    ExtractPath "%~1" "/dev_hdd0/home/%%u/exdata" "%TARGETDIR%"
)

@popd
@pause
