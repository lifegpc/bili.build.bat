@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET pythonLocation="python_x64\"
SET python="%pythonLocation:"=%python.exe"
SET pip="%pythonLocation:"=%Scripts\pip.exe"
SET /A argc=0
SET /A pe=0
SET p=
FOR %%x in (%*) DO (
    SET /A argc+=1
    SET t=%%x
    SET t=!t:"=!
    IF !t!==-pip (
        SET /A pe=1
    ) ELSE (
        IF !t! NEQ -FIXED_CTRL_C SET p=!p! %%x
    )
)
IF %pe% EQU 1 (
    %pip%%p%
) ELSE (
    %python%%p%
)
ENDLOCAL
