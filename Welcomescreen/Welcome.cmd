@PROMPT PROMPT$G
@ECHO DIR = %0
IF EXIST Welcome.res  DEL Welcome.res
BRCC32.exe -m -foWelcome.res Welcome.rc
IF ERRORLEVEL 1   PAUSE
EXIT
