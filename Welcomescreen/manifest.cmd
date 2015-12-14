@PROMPT PROMPT$G
@ECHO DIR = %0
IF EXIST manifest.res  DEL manifest.res
BRCC32.exe -m -fomanifest.res manifest.rc
IF ERRORLEVEL 1   PAUSE
EXIT
