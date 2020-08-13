@echo off
title Updating version file
for /f "delims=" %%i in ('py v.py') do set a=%%i
if %ERRORLEVEL% NEQ 0 pause
if exist dist del /S /Q dist
title compiling start.exe
pyinstaller -F start.py --version-file v.txt
title compiling filter.exe
pyinstaller -F filter.py --version-file v2.txt
title compiling setsettings.exe
pyinstaller -F setsettings.py --version-file v3.txt
title copy dist exe to bilibin
cp dist/*.exe ../bilibin/
cd ../bilibin/
if not exist Language md Language
cd ../bili/
cp Language/*.po ../bilibin/Language
cp Language/*.pot ../bilibin/Language
cp LICENSE ../bilibin/LICENSE
cp *.html ../bilibin
cd ../bilibin/
title compiling installer
compil32 /cc setup.iss
title clean 7z file
if exist bili_%a%_windows10_x64.7z del /S /Q bili_%a%_windows10_x64.7z
if exist bili_%a%.7z del /S /Q bili_%a%.7z
if exist bili_%a%_windows.7z del /S /Q bili_%a%_windows.7z
if exist bili_%a%_linux.7z del /S /Q bili_%a%_linux.7z
if exist bili_%a%_mac.7z del /S /Q bili_%a%_mac.7z
title building bili_%a%_windows10_x64.7z
7z a -stm1 -y -mx9 -x@7z bili_%a%_windows10_x64.7z *.exe LICENSE *.html Language/* version.txt
cd ../bili/
title building bili_%a%.7z
7z a -stm1 -y -mx9 -x@7z.txt ../bilibin/bili_%a%.7z *.py file/*.py LICENSE *.html Language/*.po Language/*.pot ../bilibin/version.txt
title building bili_%a%_windows.7z
7z a -stm1 -y -mx9 -x@7z.txt ../bilibin/bili_%a%_windows.7z *.py file/*.py LICENSE *.html ../bilibin/chromedriver.exe Language/*.po Language/*.pot ../bilibin/version.txt
title building bili_%a%_linux.7z
7z a -stm1 -y -mx9 -x@7z.txt ../bilibin/bili_%a%_linux.7z *.py file/*.py LICENSE *.html ../bilibin/linux/chromedriver Language/*.po Language/*.pot ../bilibin/version.txt
title building bili_%a%_mac.7z
7z a -stm1 -y -mx9 -x@7z.txt ../bilibin/bili_%a%_mac.7z *.py file/*.py LICENSE *.html ../bilibin/mac/chromedriver Language/*.po Language/*.pot ../bilibin/version.txt
title build complete
