unit cdplayerfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bass, basscd, Registry, StdCtrls, Buttons, PngBitBtn,
  ComCtrls, ExtCtrls, JvExComCtrls, JvComCtrls, PngImageList, XPMan, gnugettext;

const
  MAXDRIVES = 10; // maximale Anzahl der CD-Laufwerke für AudioCD-Player

type
  Tcdplayerform = class(TForm)
    lstTracks: TListBox;
    Timer1: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    cmbDrives: TComboBox;
    lblStatus: TLabel;
    Shape1: TShape;
    cdplaybtn: TPngBitBtn;
    cdpausebtn: TPngBitBtn;
    cdstop: TPngBitBtn;
    cdprevious: TPngBitBtn;
    cdnext: TPngBitBtn;
    cdlockbtn: TPngBitBtn;
    cdopen: TPngBitBtn;
    cdaudiodisplay: TLabel;
    audioplayer_alsschleife: TCheckBox;
    useplaylist: TCheckBox;
    trkVol: TTrackBar;
    Panel3: TPanel;
    Panel4: TPanel;
    trkPos: TJvTrackBar;
    sounddevices: TComboBox;
    shuffle: TCheckBox;
    mutebtn: TPngBitBtn;
    PngImageCollection1: TPngImageCollection;
    Label1: TLabel;
    Label2: TLabel;
    XPManifest1: TXPManifest;
    timelbl: TLabel;
    timelbl2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cdplaybtnClick(Sender: TObject);
    procedure cdnextClick(Sender: TObject);
    procedure PlayTrack(drive, track: DWORD);
    procedure cdlockbtnClick(Sender: TObject);
    procedure cdopenClick(Sender: TObject);
    procedure cmbDrivesChange(Sender: TObject);
    procedure UpdateTrackList;
    procedure lstTracksDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure cdpausebtnClick(Sender: TObject);
    procedure cdstopClick(Sender: TObject);
    procedure lstTracksKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdpreviousClick(Sender: TObject);
    procedure lstTracksClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure trkVolChange(Sender: TObject);
    procedure trkPosChange(Sender: TObject);
    procedure trkPosMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure trkPosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormHide(Sender: TObject);
    procedure sounddevicesChange(Sender: TObject);
    procedure CheckButtons;
    procedure useplaylistMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mutebtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function getdriveletter(number: integer):string;
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    sounddevice:integer;
    CDInfo:BASS_CD_INFO;
    mouseontrackbar:boolean;
    lasttrack:integer;
    muted:boolean;
  public
    { Public-Deklarationen }
    shutdown:boolean;
  end;

var
  cdplayerform: Tcdplayerform;

  curdrive: Integer = 0;
  seeking: Integer = -1;
  seeking_effektaudio: Integer = -1;
  cdaudiolevel: Integer = 0;
  stream: array[0..MAXDRIVES - 1] of HSTREAM = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tcdplayerform.FormCreate(Sender: TObject);
var
  LReg:TRegistry;
  a,i,lastletter:integer;
  n:PChar;
  BassDeviceInfo:BASS_DEVICEINFO;
  text,text2:string;
begin
  TranslateComponent(self);
  lasttrack:=-1;
  lastletter:=0;
  shutdown:=false;

	if (HIWORD(BASS_GetVersion) <> BASSVERSION) then
		MessageBox(0,PChar(String(_('Die Datei "bass.dll" liegt in einer falschen Version vor.'))),nil,MB_ICONERROR);

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if not LReg.ValueExists('Last used Audiodevice (CD-Player)') then
          LReg.WriteInteger('Last used Audiodevice (CD-Player)',0);
        sounddevice:=LReg.ReadInteger('Last used Audiodevice (CD-Player)');
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;


  BASS_Init(sounddevice+1, 44100, BASS_DEVICE_SPEAKERS, Handle, nil);

  i:=1;
  sounddevices.clear;
  while (BASS_GetDeviceInfo(i, BassDeviceInfo)) do
  begin
    sounddevices.Items.Add(BassDeviceInfo.name);
    i := i + 1;
  end;
  sounddevices.ItemIndex:=sounddevice;

  cmbDrives.Items.clear;
  // CD-Player initialisieren
  // Liste aller CD-Laufwerke sammeln
  a := 0;
  BASS_CD_GetInfo(a, CDInfo);
  n := PChar(CDInfo.vendor+' '+CDInfo.product+' ('+CDInfo.rev+')');
  while (a < MAXDRIVES) and (n <> nil) and (lastletter<>CDInfo.Letter) do
  begin
    //cmbDrives.Items.Add(Format('%s: %s', [Char(BASS_CD_GetDriveLetter(a) + Ord('A')), n]));
    lastletter:=CDInfo.Letter;
    cmbDrives.Items.Add('['+getdriveletter(CDInfo.Letter)+'] '+CDInfo.vendor+' '+CDInfo.product+' ('+CDInfo.rev+')');
    a := a + 1;
    BASS_CD_GetInfo(a, CDInfo);
    n := PChar(CDInfo.vendor+' '+CDInfo.product+' ('+CDInfo.rev+')');
  end;
  if (a = 0) then
  begin
    text:=_('Kein CD-Laufwerk gefunden');
    text2:=_('Fehler');
    MessageBox(0, PChar(text), PChar(text2), MB_ICONERROR);
    Halt;
  end;
  cmbDrives.ItemIndex := 0; // das erste Laufwerk automatisch auswählen
  UpdateTracklist;
end;

procedure Tcdplayerform.cdplaybtnClick(Sender: TObject);
begin
  PlayTrack(curdrive, lstTracks.ItemIndex);
//  BASS_ChannelPlay(stream[curdrive],false);
  cdplaybtn.enabled:=false;
  cdpausebtn.enabled:=true;
  cdstop.Enabled:=true;
end;

procedure Tcdplayerform.cdnextClick(Sender: TObject);
begin
  trkPos.Position := 0;
  lsttracks.ItemIndex := lsttracks.ItemIndex + 1;
  if lsttracks.ItemIndex=(lsttracks.Items.Count-1) then cdnext.Enabled:=false;
  if lsttracks.ItemIndex>0 then cdprevious.Enabled:=true;
  if not cdplaybtn.Enabled then PlayTrack(curdrive, lstTracks.ItemIndex);
end;

procedure Tcdplayerform.PlayTrack(drive, track: DWORD);
var
  l: Integer;
  min,sek:string;
  temptrack:integer;
begin
  temptrack:=track;
  trkpos.Enabled:=true;
  if lasttrack<>temptrack then
  begin
    stream[drive] := BASS_CD_StreamCreate(drive, track, 0); // Audiostream erstellen
    lasttrack:=temptrack;
  end;
//  if (drive = DWORD(curdrive)) then
  begin
    trkPos.Max := BASS_ChannelGetLength(stream[drive], BASS_POS_BYTE) div 176400; // an Timelineposition springen
    trkVol.Position := 100; // Standardpegel setzen
  end;
  BASS_ChannelPlay(stream[drive], False); // Abspielen starten
  cdplaybtn.Enabled:=false;
  cdpausebtn.Enabled:=true;
  cdstop.Enabled:=true;

  l := BASS_CD_GetTrackLength(curdrive, lsttracks.itemindex);
  if (l = -1) then
    timelbl2.caption := '8'
  else
  begin
    l := l div 176400;
    if l div 60<10 then
      min:='0'+inttostr(l div 60)
    else
      min:=inttostr(l div 60);

    if l mod 60<10 then
      sek:='0'+inttostr(l mod 60)
    else
      sek:=inttostr(l mod 60);

    timelbl2.caption := min+':'+sek;
  end;

  if lsttracks.ItemIndex=0 then cdprevious.Enabled:=false else cdprevious.Enabled:=true;
  if lsttracks.ItemIndex=(lsttracks.Items.Count-1) then cdnext.Enabled:=false else cdnext.Enabled:=true;
end;

procedure Tcdplayerform.cdlockbtnClick(Sender: TObject);
begin
  // Schublade sperren/entsperren
  if (BASS_CD_DoorIsLocked(curdrive) = True) then
  begin
    BASS_CD_Door(curdrive, BASS_CD_DOOR_UNLOCK);
    lblStatus.Caption:=_('Laufwerk entriegelt');
  end
  else
  begin
    BASS_CD_Door(curdrive,BASS_CD_DOOR_LOCK);
    lblStatus.Caption:=_('Laufwerk verriegelt');
  end;
end;

procedure Tcdplayerform.cdopenClick(Sender: TObject);
begin
  if cdstop.Enabled then cdstop.Click;
  cdplaybtn.Enabled:=false;
  cdpausebtn.Enabled:=false;
  cdnext.Enabled:=false;
  cdprevious.Enabled:=false;
  // Schublade öffnen/schließen
  if (BASS_CD_DoorIsOpen(curdrive) = True) then
    BASS_CD_Door(curdrive, BASS_CD_DOOR_CLOSE)
  else
    BASS_CD_Door(curdrive, BASS_CD_DOOR_OPEN);
end;

procedure Tcdplayerform.cmbDrivesChange(Sender: TObject);
begin
  // Aktuelles Laufwerk wechseln
  if cdstop.enabled then cdstop.click;
  curdrive := cmbDrives.ItemIndex;
  UpdateTrackList;
end;

procedure Tcdplayerform.UpdateTrackList;
var
  vol: single;
  cdtext, t: PChar;
  a, tc, l: Integer;
  text,tag: String;
begin
  tc := BASS_CD_GetTracks(curdrive);
  lstTracks.Items.Clear;
  if (tc = -1) then // keine CD
  begin
    cdplaybtn.enabled:=false;
    cdpausebtn.enabled:=false;
    cdstop.enabled:=false;
    cdprevious.enabled:=false;
    cdnext.enabled:=false;
    Exit;
  end;

  cdtext := BASS_CD_GetID(curdrive, BASS_CDID_TEXT); // CD-TEXT auslesen

  for a := 0 to tc - 1 do
  begin
    l := BASS_CD_GetTrackLength(curdrive, a);
    text := Format(_('Track %.2d'), [a + 1]);
    if (cdtext <> nil) then
    begin
      label2.Caption:=copy(cdtext,pos('0',cdtext)+2,length(cdtext));

      t := cdtext;
      tag := Format('TITLE%d=', [a + 1]); // CD-TEXT Tag anzeigen
      while (t <> nil) do
      begin
         if (Copy(t, 1, Length(tag)) = tag) then // Tracktitel gefunden...
         begin
           text := Copy(t, Length(tag)+1, Length(t) - Length(tag)); // "Track x" durch Titel ersezten
           Break;
         end;
         t := t + Length(t) + 1;
      end;
    end else
    begin
      label2.Caption:=_('Keine CD eingelegt...');
    end;

    if (l = -1) then
      text := text + ' (data)'
    else
    begin
      l := l div 176400;
      text := text + Format(' (%d:%.2d)', [l div 60, l mod 60]);
    end;
    lstTracks.Items.Add(text)
  end;
  a := BASS_CD_StreamGetTrack(stream[curdrive]);
  if (a <> -1) then // Dieses Laufwerk erzeugt Audiostream
  begin
    lstTracks.ItemIndex := LOWORD(a); // aktuellen Track auswählen
    trkPos.Max := BASS_ChannelGetLength(stream[curdrive], BASS_POS_BYTE) div 176400; // Timeline dimensionieren
    BASS_ChannelGetAttribute(stream[curdrive], BASS_ATTRIB_VOL, vol); // Lautstärke auslesen
    trkVol.Position := round((1-vol)*100); // Lautstärkeregler setzen
  end;

	if lsttracks.Items.Count>0 then
  begin
    cdplaybtn.Enabled:=true;
    lsttracks.ItemIndex:=0;
  end else
  begin
    cdplaybtn.enabled:=false;
    cdpausebtn.enabled:=false;
    cdstop.enabled:=false;
    cdprevious.enabled:=false;
    cdnext.enabled:=false;
  end;
end;

procedure Tcdplayerform.lstTracksDblClick(Sender: TObject);
begin
  // Trackabspielen
  PlayTrack(curdrive, lstTracks.ItemIndex);
end;

procedure Tcdplayerform.Timer1Timer(Sender: TObject);
var
  p: DWORD;
  time: String;
  isopen, islock: Boolean;
begin
{
  level := BASS_ChannelGetLevel(stream[curdrive]);
  cdaudiolevel := cdaudiolevel - 1500;

  if (cdaudiolevel < 0) then
    cdaudiolevel := 0;
    
  if (level <> -1) then
    if (cdaudiolevel < LOWORD(level)) then
      cdaudiolevel := LOWORD(level);
}
  time := '0 - 0:00';
  isopen := BASS_CD_DoorIsOpen(curdrive);
  islock := BASS_CD_DoorIsLocked(curdrive);

  if (isopen) then
    lblStatus.Caption := _('Laufwerk geöffnet ')
  else
    lblStatus.Caption := _('Laufwerk geschlossen ');

  if (islock) then
  begin
    lblStatus.Caption := lblStatus.Caption + _('und verriegelt');
    cdopen.Enabled:=false;
  end else
  begin
    lblStatus.Caption := lblStatus.Caption + _('aber entriegelt');
    cdopen.Enabled:=true;
  end;

  if (BASS_ChannelIsActive(stream[curdrive]) > 0) then // Abspielinfo erneuern
  begin
    p := seeking;
    if (seeking = -1) then // Timeline aktualisieren, wenn nicht nach Trackposition gesucht wird
    begin
      p := Trunc(BASS_ChannelBytes2Seconds(stream[curdrive], BASS_ChannelGetPosition(stream[curdrive], BASS_POS_BYTE)));
      trkPos.Position := p;
    end;
    time := Format('%d - %d:%.2d', [LOWORD(BASS_CD_StreamGetTrack(stream[curdrive])) + 1, p div 60, p mod 60]);
{
  end else if (lstTracks.Items.Count = 0) then // Leere Trackliste? Erneuern!
  begin
    if (not isopen) then
      UpdateTrackList;
  end else if (isopen) or (not BASS_CD_IsReady(curdrive)) then // wenn keine CD vorhanden ist, dann Liste löschen
  begin
    BASS_StreamFree(stream[curdrive]);
    stream[curdrive] := 0;
    lstTracks.Items.Clear;
}
  end;

  cdaudiodisplay.Caption := 'Track '+time;
  timelbl.caption:=time;

  // Am Ende zurückspulen und bei bedarf Schleife starten
  if trkPos.Position>=trkpos.Max-1 then
  begin
    // Bei Wiederholen
    if audioplayer_alsschleife.Checked=true then
    begin
      BASS_ChannelSetPosition(stream[curdrive],BASS_ChannelSeconds2Bytes(stream[curdrive], 0), BASS_POS_BYTE);
      trkPos.Position := 0;
    end;

    // Bei Abarbeitung der Playlist
    if ((useplaylist.Checked=true) and (audioplayer_alsschleife.Checked=false) and not (shuffle.checked)) then
    begin
      if (lstTracks.ItemIndex<>lstTracks.Items.Count-1) then
        cdnext.Click
      else
        cdstop.Click;
    end else if ((useplaylist.Checked=true) and (audioplayer_alsschleife.Checked=false) and (shuffle.checked)) then
    begin
      Randomize;
      lstTracks.itemindex:=Random(lstTracks.Items.Count-1)+1;
      PlayTrack(curdrive, lstTracks.ItemIndex);
    end;

    // Bei Stoppen
    if ((useplaylist.Checked=false) and (audioplayer_alsschleife.Checked=false)) then
    begin
      cdstop.Click;
    end;
  end;
end;

procedure Tcdplayerform.cdpausebtnClick(Sender: TObject);
begin
  cdplaybtn.Enabled:=true;
  cdpausebtn.Enabled:=false;
  cdstop.Enabled:=true;
  BASS_ChannelPause(stream[curdrive]);
end;

procedure Tcdplayerform.cdstopClick(Sender: TObject);
begin
  BASS_ChannelStop(stream[curdrive]);
  BASS_ChannelSetPosition(stream[curdrive], 0, BASS_POS_BYTE);
  trkPos.Position:=0;
  cdplaybtn.Enabled:=true;
  cdpausebtn.Enabled:=false;
  cdstop.Enabled:=false;
end;

procedure Tcdplayerform.lstTracksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
   vk_return: PlayTrack(curdrive, lstTracks.ItemIndex);
   vk_space: if cdpausebtn.Enabled then cdpausebtn.click else if cdplaybtn.Enabled then cdplaybtn.Click;
 end;
end;

procedure Tcdplayerform.cdpreviousClick(Sender: TObject);
begin
  trkPos.Position := 0;
  lsttracks.ItemIndex := lsttracks.ItemIndex - 1;
  if lsttracks.ItemIndex>0 then cdnext.Enabled:=true;
  if lsttracks.ItemIndex=0 then cdprevious.Enabled:=false;
  if not cdplaybtn.Enabled then PlayTrack(curdrive, lstTracks.ItemIndex);
end;

procedure Tcdplayerform.lstTracksClick(Sender: TObject);
begin
  cdplaybtn.Enabled:=lsttracks.Items.Count>0;
  if ((lsttracks.items.Count>0) and (lsttracks.ItemIndex>0)) then cdprevious.Enabled:=true else cdprevious.Enabled:=false;
  if ((lsttracks.items.Count>0) and (lsttracks.ItemIndex<(lsttracks.Items.Count-1))) then cdnext.Enabled:=true else cdnext.Enabled:=false;
end;

procedure Tcdplayerform.FormShow(Sender: TObject);
var
  LReg:TRegistry;
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
  			LReg.WriteBool('Showing CD-Player',true);

        if not LReg.KeyExists('CD-Player') then
	        LReg.CreateKey('CD-Player');
	      if LReg.OpenKey('CD-Player',true) then
	      begin
          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+cdplayerform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              cdplayerform.Left:=LReg.ReadInteger('PosX')
            else
              cdplayerform.Left:=0;
          end else
            cdplayerform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+cdplayerform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              cdplayerform.Top:=LReg.ReadInteger('PosY')
            else
              cdplayerform.Top:=0;
          end else
            cdplayerform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  Timer1.enabled:=true;
  Timer1Timer(sender);
end;

procedure Tcdplayerform.trkVolChange(Sender: TObject);
begin
  // Lautstärke regeln
  BASS_ChannelSetAttribute(stream[curdrive], BASS_ATTRIB_VOL, trkVol.Position/100);
  if trkVol.Position=0 then
    mutebtn.PngImage:=PngImageCollection1.Items[1].PngImage
  else
    mutebtn.PngImage:=PngImageCollection1.Items[0].PngImage;
end;

procedure Tcdplayerform.trkPosChange(Sender: TObject);
begin
  if mouseontrackbar then
  begin
    // position scroller
    seeking := trkpos.position;
    BASS_ChannelSetPosition(stream[curdrive], seeking * 176400, BASS_POS_BYTE);
    seeking := -1;
  end;
end;

procedure Tcdplayerform.trkPosMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mouseontrackbar:=true;
end;

procedure Tcdplayerform.trkPosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mouseontrackbar:=false;
end;

procedure Tcdplayerform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
	if not shutdown then
  begin
	  LReg := TRegistry.Create;
	  LReg.RootKey:=HKEY_CURRENT_USER;

	  if LReg.OpenKey('Software', True) then
	  begin
	    if not LReg.KeyExists('PHOENIXstudios') then
	      LReg.CreateKey('PHOENIXstudios');
	    if LReg.OpenKey('PHOENIXstudios',true) then
	    begin
	      if not LReg.KeyExists('PC_DIMMER') then
	        LReg.CreateKey('PC_DIMMER');
	      if LReg.OpenKey('PC_DIMMER',true) then
	      begin
					LReg.WriteBool('Showing CD-Player',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;

  Timer1.enabled:=false;
end;

procedure Tcdplayerform.sounddevicesChange(Sender: TObject);
var
  LReg:TRegistry;
begin
  sounddevice:=sounddevices.itemindex;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        LReg.WriteInteger('Last used Audiodevice (CD-Player)',sounddevice);
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  if cdstop.enabled then cdstop.click;
//  BASS_StreamFree(stream[curdrive]);
  BASS_Free;
  BASS_Init(sounddevice+1, 44100, BASS_DEVICE_SPEAKERS, Handle, nil);
//  UpdateTrackList;
end;

procedure Tcdplayerform.CheckButtons;
begin
  cdplaybtn.enabled:=(lsttracks.itemindex>-1) and not (BASS_ChannelIsActive(stream[curdrive]) > 0);
  cdpausebtn.enabled:=(lsttracks.itemindex>-1) and (BASS_ChannelIsActive(stream[curdrive]) > 0);
  cdstop.enabled:=(lsttracks.itemindex>-1) and (BASS_ChannelIsActive(stream[curdrive]) > 0);
  cdprevious.enabled:=lsttracks.ItemIndex>0;
  cdnext.enabled:=lsttracks.ItemIndex<(lsttracks.Items.Count-1);
end;

procedure Tcdplayerform.useplaylistMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  shuffle.enabled:=useplaylist.checked;
end;

procedure Tcdplayerform.mutebtnClick(Sender: TObject);
begin
  if muted then
  begin
    // Mute ausschalten
    muted:=false;
    BASS_ChannelSetAttribute(stream[curdrive], BASS_ATTRIB_VOL, trkVol.Position/100);
    mutebtn.PngImage:=PngImageCollection1.Items[0].PngImage;
  end else
  begin
    // Mute einschalten
    muted:=true;
    BASS_ChannelSetAttribute(stream[curdrive], BASS_ATTRIB_VOL, 0);
    mutebtn.PngImage:=PngImageCollection1.Items[1].PngImage;
  end;
end;

procedure Tcdplayerform.FormDestroy(Sender: TObject);
begin
  cdstopClick(sender);
  BASS_CD_Door(curdrive, BASS_CD_DOOR_UNLOCK);
  BASS_Free;
end;

function Tcdplayerform.getdriveletter(number: integer):string;
var
  letter:string;
begin
  case number of
    0: letter:='A:';
    1: letter:='B:';
    2: letter:='C:';
    3: letter:='D:';
    4: letter:='E:';
    5: letter:='F:';
    6: letter:='G:';
    7: letter:='H:';
    8: letter:='I:';
    9: letter:='J:';
    10: letter:='K:';
    11: letter:='L:';
    12: letter:='M:';
    13: letter:='N:';
    14: letter:='O:';
    15: letter:='P:';
    16: letter:='Q:';
    17: letter:='R:';
    18: letter:='S:';
    19: letter:='T:';
    20: letter:='U:';
    21: letter:='V:';
    22: letter:='W:';
    23: letter:='X:';
    24: letter:='Y:';
    25: letter:='Z:';
  end;
  Result:=letter;
end;

procedure Tcdplayerform.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);

{
  if mainform.ShowButtonInTaskbar then
  begin
    Params.ExStyle:=WS_EX_APPWINDOW; // Params.ExStyle sorgt dafür, dass das Form einen eigenen Taskbareintrag erhält
    if mainform.ShowIconInTaskSwitcher then
    begin
      Params.WndParent:=GetDesktopWindow;
      self.ParentWindow := GetDesktopWindow;
    end;
  end;
}
end;

end.
