@echo off
@pushd "%~dp0\Tools"

set IDPS=..\idps.bin
PS3Xport.exe ^
  SetDeviceID "%IDPS%" ^
  ReadIndex "%~1\archive.dat" ^
  ReadIndex "%~1\archive2.dat" ^
  >"..\%~n1_index.txt"

@popd
@pause
