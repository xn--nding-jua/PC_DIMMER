v2.16
Bugfix: sporadisch Fehler #6 unter HE-Laserscan bei Nutzung mehrerer Karten



Bitte beachten:

Bei Versionen ab 2.13 hat sich das INI-File gegenüber den Vorversionen geändert.
Die einzelnen Sektionen, die bei Nutzung mehrerer Ausgabekarten die einzelnen
Karten identifizieren, sind jetzt nicht mehr mit der USB-ID der Karte betitelt
(also z.B. [FT5NG6UL]), sondern mit [Projector_01] etc.

Im Lumax-Testprogramm lässt sich im oberen bereich zuordnen, welche Projektor-
Nummer zu welcher Ausgabekarte (USB-ID) gehört. Die Einstellungen gehören also
nicht mehr zu einer Ausgabekarte, sondern zu einem Projektor.

Will man die alten Einstellungen übernehmen, muss man die Sektionen im INI-File
manuell umbenennen.


Ausserdem kann man das INI-File ins Homeverzeichnis
(unter Windows XP z.B. C:\Dokumente und Einstellungen\Administrator\) kopieren,
dann ist dieses File für alle Lasershowprogramme gültig, und es muss nicht in
den Ordner der jeweiligen Software kopiert werden.
Der Pfad zum INI-File wird im Testprogramm als Tooltip angezeigt, wenn man den
Mauspfeil auf dem Button "Write INI File" ruhen lässt.
