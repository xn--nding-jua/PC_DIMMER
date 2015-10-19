unit audiomanagerfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Bass, Buttons, PngBitBtn, gnugettext;

type
  Taudiomanagerform = class(TForm)
    ListBox1: TListBox;
    Timer1: TTimer;
    Panel4: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    playbtn: TPngBitBtn;
    stopbtn: TPngBitBtn;
    pausebtn: TPngBitBtn;
    panicstopbtn: TPngBitBtn;
    restartbtn: TPngBitBtn;
    Shape3: TShape;
    Label1: TLabel;
    closebtn: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Shape3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Shape3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure closebtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    pointerarray:array of integer;
  public
    { Public-Deklarationen }
  end;

var
  audiomanagerform: Taudiomanagerform;

implementation

uses PCDIMMER;

{$R *.dfm}

function GetTaskbarHeight: integer;
var
  SysTray: Windows.HWND;
  Rect: TRect;
begin
  Result := -1;
  SysTray := FindWindow('Shell_TrayWnd', nil);
  if SysTray <> INVALID_HANDLE_VALUE then begin
    if GetWindowRect(SysTray, Rect) then begin
      Result := Screen.Height - Rect.Top;
    end;
  end;
end;

procedure Taudiomanagerform.Timer1Timer(Sender: TObject);
var
  i:integer;
  Laufzeit, Dauer:Cardinal;
  Laufzeittext, Schlusstext:string;
  oldposition:integer;
  audioscenerunning:boolean;
begin
  oldposition:=listbox1.itemindex;
  listbox1.items.Clear;
  setlength(pointerarray, 0);

  audioscenerunning:=false;
  for i:=0 to length(mainform.audioszenen)-1 do
  begin
    if (BASS_ChannelIsActive(mainform.AudioszenenCHAN[i].MixerHandle) = BASS_ACTIVE_PLAYING) or (BASS_ChannelIsActive(mainform.AudioszenenCHAN[i].MixerHandle) = BASS_ACTIVE_PAUSED) then
    begin
      audioscenerunning:=true;
      setlength(pointerarray, length(pointerarray)+1);
      pointerarray[length(pointerarray)-1]:=i;

      Laufzeit:=trunc(BASS_ChannelBytes2Seconds(mainform.AudioszenenCHAN[i].MixerHandle,BASS_ChannelGetPosition(mainform.AudioszenenCHAN[i].MixerHandle, BASS_POS_BYTE)))*1000;
      Laufzeittext:=mainform.MillisecondsToTimeShort(Laufzeit);
      Dauer:=mainform.audioszenen[i].Dauer;
      if Dauer=0 then
        Schlusstext:=''
      else
        Schlusstext:=_(' noch ')+mainform.MillisecondsToTimeShort(Dauer-Laufzeit);

      if (BASS_ChannelIsActive(mainform.AudioszenenCHAN[i].MixerHandle) = BASS_ACTIVE_PAUSED) then
        Schlusstext:=Schlusstext+' [PAUSE]';
        
      listbox1.Items.Add(mainform.audioszenen[i].Name+' ('+Laufzeittext+Schlusstext+')');
    end;
  end;

  if oldposition<listbox1.items.count then
    listbox1.ItemIndex:=oldposition;

  if not audioscenerunning then
  begin
    close;
  end;
end;

procedure Taudiomanagerform.FormShow(Sender: TObject);
begin
  audiomanagerform.Top:=Screen.MonitorFromWindow(mainform.Handle).Height-audiomanagerform.Height-GetTaskbarHeight;
  audiomanagerform.Left:=Screen.MonitorFromWindow(mainform.Handle).Width-audiomanagerform.Width;

  timer1.enabled:=true;
//  timer1timer(nil);
end;

procedure Taudiomanagerform.FormHide(Sender: TObject);
begin
  timer1.enabled:=false;
end;

procedure Taudiomanagerform.Button1Click(Sender: TObject);
begin
  if listbox1.itemindex>-1 then
    mainform.StopAudioSzene(mainform.audioszenen[pointerarray[listbox1.itemindex]].ID);
  timer1timer(nil);
end;

procedure Taudiomanagerform.Button2Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.audioszenen)-1 do
  begin
    mainform.StopAudioSzene(mainform.audioszenen[i].ID);
  end;
  timer1timer(nil);
end;

procedure Taudiomanagerform.Button4Click(Sender: TObject);
begin
  if listbox1.itemindex>-1 then
    BASS_ChannelPlay(mainform.audioszenenCHAN[pointerarray[listbox1.itemindex]].MixerHandle, false);
  timer1timer(nil);
end;

procedure Taudiomanagerform.Button3Click(Sender: TObject);
begin
  if listbox1.itemindex>-1 then
    BASS_ChannelPause(mainform.audioszenenCHAN[pointerarray[listbox1.itemindex]].MixerHandle);
  timer1timer(nil);
end;

procedure Taudiomanagerform.Button5Click(Sender: TObject);
begin
  if listbox1.itemindex>-1 then
  begin
    BASS_ChannelSetPosition(mainform.audioszenenCHAN[pointerarray[listbox1.itemindex]].StandardHandle, 0, BASS_POS_BYTE);
    BASS_ChannelPlay(mainform.audioszenenCHAN[pointerarray[listbox1.itemindex]].MixerHandle, false);
  end;
  timer1timer(nil);
end;

procedure Taudiomanagerform.Shape3MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if shift=[ssLeft] then
  begin
    ReleaseCapture;
    audiomanagerform.Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure Taudiomanagerform.Shape3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if button=mbRight then
  begin
    if panel4.Visible then
    begin
      panel4.visible:=false;
      audiomanagerform.ClientHeight:=shape3.Height;
    end else
    begin
      panel4.visible:=true;
      audiomanagerform.ClientHeight:=127;
    end;
  end;
end;

procedure Taudiomanagerform.closebtnClick(Sender: TObject);
begin
  close;
end;

end.
