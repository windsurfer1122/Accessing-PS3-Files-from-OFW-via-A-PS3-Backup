@echo off
@cd /d "%~dp0\Tools"

PS3Xport.exe SetDeviceID ..\idps.bin ReadIndex "%~1\archive.dat" ReadIndex "%~1\archive2.dat" >"..\%~n1_index.txt"

@pause
