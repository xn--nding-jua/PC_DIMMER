cd en
cd LC_MESSAGES
del old.po
ren default.po old.po
msgmerge old.po ..\..\..\default.po > default.po

cd..
cd..
cd fr
cd LC_MESSAGES
del old.po
ren default.po old.po
msgmerge old.po ..\..\..\default.po > default.po

cd..
cd..
cd nl
cd LC_MESSAGES
del old.po
ren default.po old.po
msgmerge old.po ..\..\..\default.po > default.po


cd..
cd..
cd es
cd LC_MESSAGES
del old.po
ren default.po old.po
msgmerge old.po ..\..\..\default.po > default.po


pause