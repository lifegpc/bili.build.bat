@echo off
title Updating version file
for /f "delims=" %%i in ('py v.py') do set a=%%i
if %ERRORLEVEL% NEQ 0 pause
if exist dist del /S /Q dist
title compiling start.exe
pyinstaller -F start.py --version-file v.txt --icon icon/favicon.ico
title compiling filter.exe
pyinstaller -F filter.py --version-file v2.txt --icon icon/favicon.ico
title compiling setsettings.exe
pyinstaller -F setsettings.py --version-file v3.txt --icon icon/favicon.ico
title compiling startwebui.exe
pyinstaller -F startwebui.py --version-file v4.txt --icon icon/favicon.ico
title copy dist exe to bilibin
cp -v dist/*.exe ../bilibin/
cd ../bilibin/
if exist Language rm -rfv Language
md Language
if exist webuihtml rm -rfv webuihtml
md webuihtml
if exist icon rm -rfv icon
md icon
cd ../bili/
cp -v Language/*.po ../bilibin/Language
cp -v Language/*.pot ../bilibin/Language
cp -v webuihtml/*.html ../bilibin/webuihtml
cp -rv webuihtml/css ../bilibin/webuihtml/css
cp -rv webuihtml/js ../bilibin/webuihtml/js
cp -rv webuihtml/jso ../bilibin/webuihtml/jso
cp -rv webuihtml/json ../bilibin/webuihtml/json
cp -v LICENSE ../bilibin/LICENSE
cp -v *.html ../bilibin
cp -v icon/*.svg ../bilibin/icon
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
7z a -stm1 -y -mx9 -x@7z bili_%a%_windows10_x64.7z *.exe LICENSE *.html Language/* version.txt webuihtml/* icon/*
cd ../bili/
title building bili_%a%.7z
7z a -stm1 -y -mx9 -x@7z.txt ../bilibin/bili_%a%.7z *.py file/*.py LICENSE *.html Language/*.po Language/*.pot ../bilibin/version.txt webui/*.py webuihtml/*.html webuihtml/css/* webuihtml/js/* webuihtml/jso/* webuihtml/json/* icon/*.svg webui/api/*.py
title building bili_%a%_windows.7z
7z a -stm1 -y -mx9 -x@7z.txt ../bilibin/bili_%a%_windows.7z *.py file/*.py LICENSE *.html ../bilibin/chromedriver.exe Language/*.po Language/*.pot ../bilibin/version.txt webui/*.py webuihtml/*.html webuihtml/css/* webuihtml/js/* webuihtml/jso/* webuihtml/json/* icon/*.svg webui/api/*.py
title building bili_%a%_linux.7z
7z a -stm1 -y -mx9 -x@7z.txt ../bilibin/bili_%a%_linux.7z *.py file/*.py LICENSE *.html ../bilibin/linux/chromedriver Language/*.po Language/*.pot ../bilibin/version.txt webui/*.py webuihtml/*.html webuihtml/css/* webuihtml/js/* webuihtml/jso/* webuihtml/json/* icon/*.svg webui/api/*.py
title building bili_%a%_mac.7z
7z a -stm1 -y -mx9 -x@7z.txt ../bilibin/bili_%a%_mac.7z *.py file/*.py LICENSE *.html ../bilibin/mac/chromedriver Language/*.po Language/*.pot ../bilibin/version.txt webui/*.py webuihtml/*.html webuihtml/css/* webuihtml/js/* webuihtml/jso/* webuihtml/json/* icon/*.svg webui/api/*.py
title build complete
