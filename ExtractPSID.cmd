@echo off
@cd /d "%~dp0\Tools"

PS3Xport.exe ExtractPSID "%~1" ..\psid.bin

@pause
