@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
set p=
FOR %%x in (%*) DO (
    SET p=!p! %%x
)
CALL embeddedpython_x86 bilischeme.py !p!
ECHO Program returned %ERRORLEVEL%
if NOT DEFINED p PAUSE
ENDLOCAL
