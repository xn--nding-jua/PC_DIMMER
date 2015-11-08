unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry, CHHighResTimer, Grids, jpeg;

type
  TDMXArray = array[0..511] of Byte;
  TSERIAL = array[0..15] of Char;
  TSERIALLIST = array[0..31] of TSERIAL;
  THOSTDEVICECHANGEPROC = procedure;
  THOSTINPUTCHANGEPROC = procedure;
  THOSTINPUTCHANGEPROCBLOCK = procedure(blocknumber: byte); // >= v1.1

  TDE_Interface = record
    Serial : string[16];
    Modus : byte;
    Startaddress : integer;
    Version : DWord;
    UseDMXIn : boolean;
    DMXInStartaddress : integer;
  end;

  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

// Thread für DMX-Input deklarieren
  TConfig = class(TForm)
    GroupBox3: TGroupBox;
    StringGrid1: TStringGrid;
    ScanForInterfacesTimer: TTimer;
    RefreshSometimesTimer: TTimer;
    Panel1: TPanel;
    ConfigOK: TButton;
    Button3: TButton;
    Shape2: TShape;
    Shape3: TShape;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Image1: TImage;
    Shape1: TShape;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Label3: TLabel;
    ComboBox2: TComboBox;
    Button1: TButton;
    Button4: TButton;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    CheckBox1: TCheckBox;
    saveconfigbtn: TButton;
    CheckBox2: TCheckBox;
    ScanTimer: TCHHighResTimer;
    startuptimer: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox2Select(Sender: TObject);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ScanTimerTimer(Sender: TObject);
    procedure saveconfigbtnClick(Sender: TObject);
    procedure ScanForInterfacesTimerTimer(Sender: TObject);
    procedure RefreshSometimesTimerTimer(Sender: TObject);
    procedure ConfigOKClick(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure startuptimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
    RefreshSometimes:boolean;
  public
    { Public-Deklarationen }
    RefreshDLLEvent:TCallbackEvent;
    DMXOutArray:array[0..31] of TDMXArray;
    DMXInArray:array[0..31] of TDMXArray;
    DMXInArrayLastValue:array[0..31] of TDMXArray;
    UseBlockChange:boolean;

    comportnumber:integer;
    baudrate:integer;
    rs232_inframe:array of byte;
    IsSending:boolean;

    DE_Interfaces : array[0..31] of TDE_Interface;
    DE_IF_Profiles : array of TDE_Interface;
    function SerialToSerialstring(Serial: TSERIAL): string;
    function SerialstringToSerial(Serialstr: string): TSERIAL;
    procedure SearchForInterfaces;
    function GetPositionInInterfaceArray(Serial: String):integer;
    procedure RefreshList;
    procedure Startup;
  end;

procedure InputChange;
procedure InputChangeBlock(blocknumber: byte);
procedure DeviceChange;

var
  Config: TConfig;

function GetAllConnectedInterfaces: TSERIALLIST; stdcall external 'fx5_usbdmx.dll';
function GetAllOpenedInterfaces: TSERIALLIST; stdcall external 'fx5_usbdmx.dll';
function SetInterfaceMode(Serial: TSERIAL; Mode: byte): DWORD; stdcall external 'fx5_usbdmx.dll';
function OpenLink(Serial: TSERIAL; DMXOutArray: Pointer; DMXInArray: Pointer): DWORD; stdcall external 'fx5_usbdmx.dll';
function CloseLink(Serial: TSERIAL): DWORD; stdcall external 'fx5_usbdmx.dll';
function CloseAllLinks: DWORD; stdcall external 'fx5_usbdmx.dll';
function RegisterInterfaceChangeNotification(Proc: THOSTDEVICECHANGEPROC): DWORD; stdcall external 'fx5_usbdmx.dll';
function UnregisterInterfaceChangeNotification: DWORD; stdcall external 'fx5_usbdmx.dll';
function RegisterInputChangeNotification(Proc: THOSTINPUTCHANGEPROC): DWORD; stdcall external 'fx5_usbdmx.dll';
function UnregisterInputChangeNotification: DWORD; stdcall external 'fx5_usbdmx.dll';
function GetDeviceVersion(Serial: TSERIAL): DWORD; stdcall external 'fx5_usbdmx.dll';
function SetInterfaceAdvTxConfig(Serial: TSERIAL; Control: Byte; Breaktime: word; Marktime: word; Interbytetime: word; Interframetime: word; Channelcount: word; Startbyte: byte): DWORD; stdcall; stdcall external 'fx5_usbdmx.dll';
function StoreInterfaceAdvTxConfig(Serial: TSERIAL): DWORD; stdcall; stdcall external 'fx5_usbdmx.dll';
function RegisterInputChangeBlockNotification(Proc: THOSTINPUTCHANGEPROCBLOCK): DWORD; stdcall external 'fx5_usbdmx.dll';
function UnregisterInputChangeBlockNotification: DWORD; stdcall external 'fx5_usbdmx.dll';

implementation

uses timingfrm;

{$R *.dfm}

function TConfig.SerialToSerialstring(Serial: TSERIAL): string;
var
  i: byte;
begin
  Result := '';
  for i := 0 to 15 do
    Result := Result + Serial[i];
end;

function TConfig.SerialstringToSerial(Serialstr: string): TSERIAL;
var
  i: byte;
  len: byte;
begin
  len := length(Serialstr);
  if len > 16 then
    len := 16;
  for i := 0 to 15 do
    Result[i] := '0';
  for i := 1 to len do
    Result[i + 15 - len] := Serialstr[i];
end;

function GetModulePath : String;
var
  QueryRes: TMemoryBasicInformation;
  LBuffer: String;
begin
  VirtualQuery(@GetModulePath, QueryRes, SizeOf(QueryRes));
  SetLength(LBuffer, MAX_PATH);
  SetLength(LBuffer, GetModuleFileName(Cardinal(QueryRes.AllocationBase),
  PChar(LBuffer), Length(LBuffer)));
  result:=LBuffer;
end;

procedure DeviceChange;
begin
  // Neue Interfaces suchen
  config.ScanForInterfacesTimer.Enabled:=true;
end;

procedure InputChange;
begin
  // Neue Kanaldaten stehen an
  config.ScanTimer.enabled:=true;
end;

procedure InputChangeBlock(blocknumber: byte);
begin
  // Neuer Kanalwertblock steht an
end;

procedure TConfig.Button1Click(Sender: TObject);
begin
  SearchForInterfaces;
  RefreshList;
end;

procedure TConfig.FormShow(Sender: TObject);
begin
  RefreshList;
  ComboBox2.ItemIndex:=DE_Interfaces[GetPositionInInterfaceArray(stringgrid1.Cells[0,stringgrid1.Row])].Modus;
end;

function TConfig.GetPositionInInterfaceArray(Serial: String):integer;
var
  i:integer;
begin
  result:=-1;
  for i:=0 to 31 do
  begin
    if DE_Interfaces[i].Serial=Serial then
    begin
      result:=i;
      break;
    end;
  end;
end;

procedure TConfig.RefreshList;
var
  i,Position:integer;
  tempstring:string;
begin
  Position:=StringGrid1.Row;

  StringGrid1.Cells[0,0]:='Interfaces';
  StringGrid1.Cells[1,0]:='Modus';
  StringGrid1.Cells[2,0]:='Adresse';
  StringGrid1.Cells[3,0]:='Version';
  StringGrid1.Cells[4,0]:='DMX-In';
  StringGrid1.Cells[5,0]:='In-Adresse';

  Stringgrid1.RowCount:=2;
  for i:=0 to 31 do
  begin
    if DE_Interfaces[i].Serial<>'0000000000000000' then
    begin
      StringGrid1.Cells[0,Stringgrid1.RowCount-1]:=DE_Interfaces[i].Serial;
      case DE_Interfaces[i].Modus of
        0: StringGrid1.Cells[1,Stringgrid1.RowCount-1]:='Standby';
        1: StringGrid1.Cells[1,Stringgrid1.RowCount-1]:='Booster';
        2: StringGrid1.Cells[1,Stringgrid1.RowCount-1]:='DMX-Out';
        3: StringGrid1.Cells[1,Stringgrid1.RowCount-1]:='Merger+DMX-Out';
        4: StringGrid1.Cells[1,Stringgrid1.RowCount-1]:='DMX-In';
        5: StringGrid1.Cells[1,Stringgrid1.RowCount-1]:='Merger+DMX-In';
        6: StringGrid1.Cells[1,Stringgrid1.RowCount-1]:='DMX-Out+DMX-In';
        7: StringGrid1.Cells[1,Stringgrid1.RowCount-1]:='Merger+DMX-Out+DMX-In';
      end;
      StringGrid1.Cells[2,Stringgrid1.RowCount-1]:=inttostr(DE_Interfaces[i].Startaddress);
      tempstring:=inttohex(DE_Interfaces[i].Version,3);
      insert('.',tempstring,2);
      StringGrid1.Cells[3,Stringgrid1.RowCount-1]:=tempstring;
      StringGrid1.Cells[5,Stringgrid1.RowCount-1]:=inttostr(DE_Interfaces[i].DMXInStartaddress);

      Stringgrid1.RowCount:=Stringgrid1.RowCount+1;
    end;
  end;
  if Stringgrid1.RowCount>2 then
    Stringgrid1.RowCount:=Stringgrid1.RowCount-1
  else
  begin
    for i:=0 to Stringgrid1.ColCount-1 do
      Stringgrid1.Cells[i,1]:='';
  end;

  if Position<Stringgrid1.RowCount then
    StringGrid1.Row:=Position;
end;

procedure TConfig.StringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
var
	text:string;
begin
  if (ACol=0) or (ACol=1) or (ACol=3) or (ACol=4) then
  begin
    text:=StringGrid1.Cells[ACol,ARow];
    StringGrid1.EditorMode:=false;
    StringGrid1.Cells[ACol,ARow]:=text;
  end else
  begin
    StringGrid1.EditorMode:=true;
  end;
end;

procedure TConfig.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if length(DE_Interfaces)=0 then exit;

  if stringgrid1.Col=2 then
  begin
    try
      if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])>8192 then
        stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='8192';
      if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<1 then
        stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='1';
    except
      stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='1';
    end;

    DE_Interfaces[GetPositionInInterfaceArray(stringgrid1.Cells[0,stringgrid1.Row])].Startaddress:=strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]);
  end;

  if stringgrid1.Col=5 then
  begin
    try
      if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])>8192 then
        stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='8192';
      if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<1 then
        stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='1';
    except
      stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='1';
    end;

    DE_Interfaces[GetPositionInInterfaceArray(stringgrid1.Cells[0,stringgrid1.Row])].DMXInStartaddress:=strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]);
  end;
end;

procedure TConfig.SearchForInterfaces;
var
  i,j:integer;
  newinterface:boolean;
begin
  // Alle Interrupt-Funktionen beenden
  UnregisterInputChangeNotification;
  UnregisterInterfaceChangeNotification;
  if UseBlockChange then
    UnRegisterInputChangeBlockNotification;

  for i:=0 to length(GetAllConnectedInterfaces)-1 do // GetAllConnectedInterfaces liefert immer 32
  if (i<=31) then
  begin
    DE_Interfaces[i].Serial:=SerialToSerialstring(GetAllConnectedInterfaces[i]);
    DE_Interfaces[i].Modus:=6;
    DE_Interfaces[i].Startaddress:=1;
    DE_Interfaces[i].Version:=GetDeviceVersion(SerialstringToSerial(GetAllConnectedInterfaces[i]));
    DE_Interfaces[i].UseDMXIn:=false;
    DE_Interfaces[i].DMXInStartaddress:=1;
  end;

  // Ist das Interface evtl. schon einmal konfiguriert worden?
  for i:=0 to 31 do
  begin
    newinterface:=true;
    
    for j:=0 to length(DE_IF_Profiles)-1 do
    begin
      if DE_IF_Profiles[j].Serial=DE_Interfaces[i].Serial then
      begin
        newinterface:=false;
        DE_Interfaces[i].Modus:=DE_IF_Profiles[j].Modus;
        DE_Interfaces[i].Startaddress:=DE_IF_Profiles[j].Startaddress;
        DE_Interfaces[i].UseDMXIn:=DE_IF_Profiles[j].UseDMXIn;
        DE_Interfaces[i].DMXInStartaddress:=DE_IF_Profiles[j].DMXInStartaddress;
        break;
      end;
    end;

    if newinterface and (DE_Interfaces[i].Serial<>'0000000000000000') then
    begin
      setlength(DE_IF_Profiles, length(DE_IF_Profiles)+1);
      DE_IF_Profiles[length(DE_IF_Profiles)-1].Serial:=DE_Interfaces[i].Serial;
      DE_IF_Profiles[length(DE_IF_Profiles)-1].Modus:=DE_Interfaces[i].Modus;
      DE_IF_Profiles[length(DE_IF_Profiles)-1].Startaddress:=DE_Interfaces[i].Startaddress;
      DE_IF_Profiles[length(DE_IF_Profiles)-1].Version:=DE_Interfaces[i].Version;
      DE_IF_Profiles[length(DE_IF_Profiles)-1].UseDMXIn:=DE_Interfaces[i].UseDMXIn;
      DE_IF_Profiles[length(DE_IF_Profiles)-1].DMXInStartaddress:=DE_Interfaces[i].DMXInStartaddress;
    end;
  end;

  // Timerinterrupts wieder aktivieren
  RegisterInterfaceChangeNotification(DeviceChange);
  RegisterInputChangeNotification(InputChange);
  if UseBlockChange then
    RegisterInputChangeBlockNotification(InputChangeBlock);

  for i:=0 to 31 do
  begin
    if DE_Interfaces[i].Serial<>'0000000000000000' then
    begin
      // Normale Verbindungsmethode
      OpenLink(SerialstringToSerial(DE_Interfaces[i].Serial),@DMXOutArray[i],@DMXInArray[i]);
      SetInterfaceMode(SerialstringToSerial(DE_Interfaces[i].Serial),DE_Interfaces[i].Modus);
    end;
  end;
end;

procedure TConfig.ComboBox2Select(Sender: TObject);
begin
  if combobox2.ItemIndex=0 then
    CloseLink(SerialstringToSerial(Stringgrid1.Cells[0,Stringgrid1.Row]))
  else
    OpenLink(SerialstringToSerial(Stringgrid1.Cells[0,Stringgrid1.Row]),@DMXOutArray[GetPositionInInterfaceArray(Stringgrid1.Cells[0,Stringgrid1.Row])],@DMXInArray[GetPositionInInterfaceArray(Stringgrid1.Cells[0,Stringgrid1.Row])]);
  SetInterfaceMode(SerialstringToSerial(Stringgrid1.Cells[0,Stringgrid1.Row]),combobox2.ItemIndex);
  DE_Interfaces[GetPositionInInterfaceArray(Stringgrid1.Cells[0,Stringgrid1.Row])].Modus:=combobox2.ItemIndex;
  RefreshList;
end;

procedure TConfig.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if length(DE_Interfaces)=0 then exit;

  if StringGrid1.Col=4 then
  begin
    DE_Interfaces[GetPositionInInterfaceArray(StringGrid1.Cells[0,StringGrid1.Row])].UseDMXIn:=not DE_Interfaces[GetPositionInInterfaceArray(StringGrid1.Cells[0,StringGrid1.Row])].UseDMXIn;
  end;

  ComboBox2.ItemIndex:=DE_Interfaces[GetPositionInInterfaceArray(stringgrid1.Cells[0,stringgrid1.Row])].Modus;

  if not ((StringGrid1.Col=2) or (StringGrid1.Col=5)) then
    RefreshList;
end;

procedure TConfig.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
	AOffSet : TPoint;
	AHaken1 : TPoint;
	AHaken2 : TPoint;
	AHaken3 : TPoint;
	ARect : TRect;
begin
  with StringGrid1.Canvas do
  begin
    if Rect.Top = 0 then
    begin
      Brush.Color := clBtnFace;
      FillRect(Rect);
      Pen.Color := clWhite;
      Rectangle(Rect);
      TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
      Exit;
    end;

    if (ACol=Stringgrid1.Col) and (ARow=Stringgrid1.Row) then
    begin
      Brush.Color := clHighlight;
      Font.Color:=clHighlightText;
    end else
    begin
      Brush.Color := clWhite;
      Font.Color:=clWindowText;
    end;
    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);

    if (ARow>0) and (ACol = 4) then
    begin
      //Kasten zeichnen
      AOffSet.X := (Rect.Right - Rect.Left - 11) div 2;
      AOffSet.Y := (Rect.Bottom - Rect.Top - 11) div 2;

      ARect.Left := AOffSet.X + Rect.Left;
      ARect.Top := AOffSet.Y + Rect.Top;
      ARect.Right := AOffSet.X + Rect.Left + 11;
      ARect.Bottom := AOffSet.Y + Rect.Top + 11;

      Pen.Color := clGray;
      Rectangle(ARect);

      // Abfrage ob Haken zeichnen oder nicht
      if (ARow>0) and (length(DE_Interfaces)>0) then
      if DE_Interfaces[GetPositionInInterfaceArray(StringGrid1.Cells[0,ARow])].UseDMXIn then
      begin
        //Haken zeichnen
        AHaken1.X := ARect.Left + 2;
        AHaken1.Y := ARect.Top + 6;
        AHaken2.X := ARect.Left + 4;
        AHaken2.Y := ARect.Top + 8;
        AHaken3.X := ARect.Left + 9;
        AHaken3.Y := ARect.Top + 3;

        Pen.Color := clBlack; // Farbe des Häkchens

        MoveTo(AHaken1.X, AHaken1.Y - 0);
        LineTo(AHaken2.X, AHaken2.Y - 0);
        LineTo(AHaken3.X, AHaken3.Y - 0);

        MoveTo(AHaken1.X, AHaken1.Y - 1);
        LineTo(AHaken2.X, AHaken2.Y - 1);
        LineTo(AHaken3.X, AHaken3.Y - 1);

        MoveTo(AHaken1.X, AHaken1.Y - 2);
        LineTo(AHaken2.X, AHaken2.Y - 2);
        LineTo(AHaken3.X, AHaken3.Y - 2);
      end;
    end;
    TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
  end;
end;

procedure TConfig.Button3Click(Sender: TObject);
var
  LReg:TRegistry;
begin
  if messagedlg('Möchten Sie wirklich alle gespeicherten Interfaceprofile löschen?',mtWarning,
    [mbYes,mbNo],0)=mrYes then
  begin
    setlength(DE_IF_Profiles, 0);

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
          if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
            LReg.CreateKey(ExtractFileName(GetModulePath));
          if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
          begin
            LReg.DeleteKey('Interfacedata');
          end;
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;

    Button1Click(nil);
  end;
end;

procedure TConfig.Button4Click(Sender: TObject);
begin
  timingform.CurrentInterface:=SerialstringToSerial(Stringgrid1.Cells[0,Stringgrid1.Row]);
  timingform.groupbox1.Caption:=' Timing des DMX512-Ausganges für '+timingform.CurrentInterface+' ';
  timingform.ShowModal;
end;

procedure TConfig.ScanTimerTimer(Sender: TObject);
var
  i,j:integer;
begin
  with config do
  begin
    ScanTimer.enabled:=false;

    for i:=0 to 31 do
    begin
      if (DE_Interfaces[i].Serial<>'0000000000000000') and DE_Interfaces[i].UseDMXIn then
      begin
        for j:=0 to 511 do
        begin
          if (DMXInArray[i][j]<>DMXInArrayLastValue[i][j]) or RefreshSometimes then
          begin
            DMXInArrayLastValue[i][j]:=DMXInArray[i][j];
            IsSending:=CheckBox2.Checked;
            RefreshDLLEvent(j+DE_Interfaces[i].DMXInStartaddress, DMXInArray[i][j])
          end;
        end;
      end;
    end;
    RefreshSometimes:=false;
  end;
end;

procedure TConfig.saveconfigbtnClick(Sender: TObject);
var
  LReg:TRegistry;
  i,j:integer;
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
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
          LReg.WriteBool('Synchronize Universe', Checkbox1.Checked);
          LReg.WriteBool('Loopback vermeiden', Checkbox2.Checked);

          if not LReg.KeyExists('Interfacedata') then
            LReg.CreateKey('Interfacedata');
          if LReg.OpenKey('Interfacedata',true) then
          begin
            LReg.WriteInteger('Interfacedatalength', length(DE_IF_Profiles));

            for i:=0 to length(DE_IF_Profiles)-1 do
            begin
              // noch schnell auf den neuesten Stand bringen
              for j:=0 to 31 do
              begin
                if DE_Interfaces[j].Serial=DE_IF_Profiles[i].Serial then
                begin
                  DE_IF_Profiles[i].Modus:=DE_Interfaces[j].Modus;
                  DE_IF_Profiles[i].Startaddress:=DE_Interfaces[j].Startaddress;
                  DE_IF_Profiles[i].Version:=DE_Interfaces[j].Version;
                  DE_IF_Profiles[i].UseDMXIn:=DE_Interfaces[j].UseDMXIn;
                  DE_IF_Profiles[i].DMXInStartaddress:=DE_Interfaces[j].DMXInStartaddress;
                  break;
                end;
              end;

              LReg.WriteBinaryData('Interface '+inttostr(i), DE_IF_Profiles[i], sizeof(DE_IF_Profiles[i]));
            end;
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TConfig.ScanForInterfacesTimerTimer(Sender: TObject);
begin
  ScanForInterfacesTimer.Enabled:=false;

  SearchForInterfaces;
  RefreshList;
end;

procedure TConfig.RefreshSometimesTimerTimer(Sender: TObject);
begin
  RefreshSometimes:=true;
  ScanTimer.Enabled:=true;
end;

procedure TConfig.ConfigOKClick(Sender: TObject);
begin
  // Einstellungen speichern
  saveconfigbtnClick(nil);

  RefreshSometimes:=true;
  ScanTimer.Enabled:=true;
end;

procedure Tconfig.startup;
var
  LReg:TRegistry;
  count, i:integer;
begin
  UseBlockChange:=false;

  setlength(DE_IF_Profiles, 0);

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
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
          if not LReg.ValueExists('Synchronize Universe') then
            LReg.WriteBool('Synchronize Universe', False);
          Checkbox1.Checked:=LReg.ReadBool('Synchronize Universe');
          RefreshSometimesTimer.Enabled:=Checkbox1.Checked;

          if not LReg.ValueExists('Loopback vermeiden') then
            LReg.WriteBool('Loopback vermeiden', False);
          Checkbox2.Checked:=LReg.ReadBool('Loopback vermeiden');

          if not LReg.KeyExists('Interfacedata') then
            LReg.CreateKey('Interfacedata');
          if LReg.OpenKey('Interfacedata',true) then
          begin
            if LReg.ValueExists('Interfacedatalength') then
            begin
              count:=LReg.ReadInteger('Interfacedatalength');
              setlength(DE_IF_Profiles, count);
              for i:=0 to length(DE_IF_Profiles)-1 do
              begin
                LReg.ReadBinaryData('Interface '+inttostr(i), DE_IF_Profiles[i], sizeof(DE_IF_Profiles[i]));
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  RegisterInterfaceChangeNotification(DeviceChange);
  RegisterInputChangeNotification(InputChange);
  if UseBlockChange then
    RegisterInputChangeBlockNotification(InputChangeBlock);
end;

procedure TConfig.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  RefreshSometimesTimer.Enabled:=Checkbox1.Checked;
end;

procedure TConfig.startuptimerTimer(Sender: TObject);
begin
  startuptimer.Enabled:=false;

  startup;
  SearchForInterfaces;
  RefreshList;

  // Abschalten
  CloseLink(SerialstringToSerial(Stringgrid1.Cells[0,Stringgrid1.Row]));
  SetInterfaceMode(SerialstringToSerial(Stringgrid1.Cells[0,Stringgrid1.Row]),0);

  // Neu verbinden
  OpenLink(SerialstringToSerial(Stringgrid1.Cells[0,Stringgrid1.Row]),@DMXOutArray[GetPositionInInterfaceArray(Stringgrid1.Cells[0,Stringgrid1.Row])],@DMXInArray[GetPositionInInterfaceArray(Stringgrid1.Cells[0,Stringgrid1.Row])]);
  SetInterfaceMode(SerialstringToSerial(Stringgrid1.Cells[0,Stringgrid1.Row]),combobox2.ItemIndex);
end;

end.
