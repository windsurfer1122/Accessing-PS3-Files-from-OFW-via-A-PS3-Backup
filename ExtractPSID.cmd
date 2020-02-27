@echo off
@pushd "%~dp0\Tools"

PS3Xport.exe ^
  ExtractPSID "%~1" "..\psid.bin"

@popd
@pause
