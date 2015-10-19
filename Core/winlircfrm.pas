unit winlircfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, XPMan, ColorGrd, JvFullColorSpaces,
  ComCtrls, Registry, messagesystem, Mask, JvExMask, JvSpin, pngimage, ScktComp,
  Grids, Buttons, PngBitBtn, Menus, szenenverwaltung, gnugettext,
  JvExControls, JvGradient;

type
  Twinlircform = class(TForm)
    cs: TClientSocket;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    memo1: TMemo;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    Panel2: TPanel;
    Button1: TButton;
    GroupBox4: TGroupBox;
    StringGrid1: TStringGrid;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    PngBitBtn3: TPngBitBtn;
    RecordBox: TCheckBox;
    Panel8: TPanel;
    JvGradient1: TJvGradient;
    Label34: TLabel;
    Label35: TLabel;
    Image1: TImage;
    Shape4: TShape;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure csConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure csConnecting(Sender: TObject; Socket: TCustomWinSocket);
    procedure csDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure csError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure csLookup(Sender: TObject; Socket: TCustomWinSocket);
    procedure csRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PngBitBtn3Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    procedure CheckButtons;
  public
    { Public-Deklarationen }
    shutdown:boolean;
    procedure MSGNew;
    procedure RefreshStringGrid;
  end;

var
  winlircform: Twinlircform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Twinlircform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);

  StringGrid1.Cells[0,0]:=_('Name');
  StringGrid1.Cells[1,0]:=_('Beschreibung');
  StringGrid1.Cells[2,0]:=_('Blendzeit');
  StringGrid1.Cells[3,0]:=_('Typ');
  StringGrid1.Cells[4,0]:=_('Fernbedienung');
  StringGrid1.Cells[5,0]:=_('Taste [Raw]');
end;

procedure Twinlircform.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  LReg:TRegistry;
begin
  if Checkbox1.Checked then
    cs.Active := true
  else
    cs.Active := false;

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
        LReg.WriteBool('WinLIRC Server active',Checkbox1.Checked);
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Twinlircform.csConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  memo1.lines.add(_('Connected'));
end;

procedure Twinlircform.csConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  memo1.lines.add(_('Connecting...'));
end;

procedure Twinlircform.csDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  memo1.lines.add(_('Disconnected'));
end;

procedure Twinlircform.csError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  memo1.lines.add(_('Error: ')+SysErrorMessage(errorcode));
  ErrorCode:=0;
end;

procedure Twinlircform.csLookup(Sender: TObject; Socket: TCustomWinSocket);
begin
  memo1.Clear;
  memo1.lines.add(_('Scanning...'));
end;

procedure Twinlircform.csRead(Sender: TObject; Socket: TCustomWinSocket);
var
  s,t:string;
  i:integer;
  partend:integer;
  params:array[1..4] of string;
begin
  // Befehl von WinLIRC empfangen
  s := socket.ReceiveText;
  memo1.lines.add(_('Received: ')+s); // s=00000000f9860ff0 00 3 UR89

  // Befehl formatieren
  t:=s;
  for i := 1 to 3 do begin
    partend := Pos(' ', t);
    params[i] := Copy(t, 1, partend - 1);
    Delete(t, 1, partend);
  end;
  params[4] := t;
  delete(params[4],length(params[4]),1);

  // Neuen Befehl auswerten
  // param[4] = Fernbedienungsnamen (String)
  // param[3] = gedrückte Taste (String)
  // param[2] = länge des Tastendruckes (Byte)
  // param[1] = RAW-Code der Taste (16 stelliger Wert)
  if RecordBox.Checked then
  begin
    if ((StringGrid1.Row-1)<length(mainform.IREvent)) and (StringGrid1.Row>0) then
    begin
      mainform.IREvent[(StringGrid1.Row-1)].fernbedienung:=params[4];
      mainform.IREvent[(StringGrid1.Row-1)].taste:=params[3];
      mainform.IREvent[(StringGrid1.Row-1)].taste_raw:=params[1];
    end;
    RecordBox.Checked:=false;
    RefreshStringGrid;
  end else
  begin
    for i:=0 to length(mainform.IREvent)-1 do
    begin
      if (mainform.IREvent[i].fernbedienung=params[4]) and (mainform.IREvent[i].taste=params[3]) then
      begin
        mainform.StartScene(mainform.IREvent[i].ID);

        if winlircform.Showing then
          StringGrid1.Row:=i+1;
      end;
    end;
  end;

  label2.Caption := params[4]+'->'+params[3];
end;

procedure Twinlircform.PngBitBtn1Click(Sender: TObject);
var
  SzenenData:PTreeData;
begin
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

  if (szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal=mrOK) then
  begin
    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
    SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

    setlength(mainform.IREvent,length(mainform.IREvent)+1);
    mainform.IREvent[length(mainform.IREvent)-1].fernbedienung:='n/a';
    mainform.IREvent[length(mainform.IREvent)-1].taste:='n/a';
    mainform.IREvent[length(mainform.IREvent)-1].taste_raw:='n/a';
    mainform.IREvent[length(mainform.IREvent)-1].ID:=SzenenData^.ID;
  end;
  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);

  RefreshStringGrid;

  CheckButtons;
end;

procedure Twinlircform.RefreshStringGrid;
var
  i:integer;
  Name, Beschreibung, Blendzeit, Typ:string;
begin
  if length(mainform.IREvent)<2 then
    StringGrid1.RowCount:=2
  else
    StringGrid1.RowCount:=length(mainform.IREvent)+1;

  for i:=0 to length(mainform.IREvent)-1 do
  begin
    mainform.GetSceneInfo(mainform.IREvent[i].ID, Name, Beschreibung, Blendzeit, Typ);

    StringGrid1.Cells[0,i+1]:=Name;
    StringGrid1.Cells[1,i+1]:=Beschreibung;
    StringGrid1.Cells[2,i+1]:=Blendzeit;
    StringGrid1.Cells[3,i+1]:=Typ;
    StringGrid1.Cells[4,i+1]:=mainform.IREvent[i].fernbedienung;
    StringGrid1.Cells[5,i+1]:=mainform.IREvent[i].taste+' ['+mainform.IREvent[i].taste_raw+']';
  end;

  if length(mainform.IREvent)=0 then
  begin
    StringGrid1.Cells[0,1]:='-';
    StringGrid1.Cells[1,1]:='-';
    StringGrid1.Cells[2,1]:='-';
    StringGrid1.Cells[3,1]:='-';
    StringGrid1.Cells[4,1]:='-';
    StringGrid1.Cells[5,1]:='-';
  end;
end;

procedure Twinlircform.PngBitBtn2Click(Sender: TObject);
var
  i:integer;
begin
  if ((StringGrid1.Row-1)<length(mainform.IREvent)) and (StringGrid1.Row>0) then
  begin
    if (StringGrid1.Row-1)<length(mainform.IREvent)-1 then
    begin
      // Arraypositionen kopieren
      for i:=StringGrid1.Row-1 to length(mainform.IREvent)-2 do
      begin
        mainform.IREvent[i]:=mainform.IREvent[i+1];
      end;
    end;
    // letztes Element löschen
    setlength(mainform.IREvent,length(mainform.IREvent)-1);
    RefreshStringGrid;
  end;
end;

procedure Twinlircform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Twinlircform.PngBitBtn3Click(Sender: TObject);
begin
  if ((StringGrid1.Row-1)<length(mainform.IREvent)) and (StringGrid1.Row>0) then
    mainform.IREvent[StringGrid1.Row-1].ID:=mainform.ChangeSceneWithLibrary(mainform.IREvent[StringGrid1.Row-1].ID);

  RefreshStringGrid;
end;

procedure Twinlircform.StringGrid1DblClick(Sender: TObject);
begin
  if ((StringGrid1.Row-1)<length(mainform.IREvent)) and (StringGrid1.Row>0) then
    mainform.EditScene(mainform.IREvent[StringGrid1.Row-1].ID);
  RefreshStringGrid;
end;

procedure Twinlircform.MSGNew;
begin
  setlength(mainform.IREvent,0);
  RefreshStringGrid;
end;

procedure Twinlircform.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Checkbuttons;
end;

procedure Twinlircform.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CheckButtons;
end;

procedure Twinlircform.CheckButtons;
begin
  PngBitBtn2.enabled:=((StringGrid1.Row-1)<length(mainform.IREvent)) and (StringGrid1.Row>0);
  PngBitBtn3.enabled:=((StringGrid1.Row-1)<length(mainform.IREvent)) and (StringGrid1.Row>0);
end;

procedure Twinlircform.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);

  if mainform.ShowButtonInTaskbar then
  begin
    Params.ExStyle:=WS_EX_APPWINDOW; // Params.ExStyle sorgt dafür, dass das Form einen eigenen Taskbareintrag erhält
    if mainform.ShowIconInTaskSwitcher then
    begin
      Params.WndParent:=GetDesktopWindow;
      self.ParentWindow := GetDesktopWindow;
    end;
  end;
end;

end.
