unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry, CHHighResTimer, Grids, jpeg, susbdmx,
  StrUtils, SVATimer, U_Usb;

type
  TDMXArray = array[0..512] of Byte;

  TInterface = record
    Handle      : Integer;
    DeviceID    : Integer;
    Serial      : string[18];
    Version     : Integer;
    UniverseOut : integer;
    UniverseIn  : integer;
    UseDMXIn    : boolean;
  end;

  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

// Thread für DMX-Input deklarieren
  TConfig = class(TForm)
    GroupBox3: TGroupBox;
    StringGrid1: TStringGrid;
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
    Button1: TButton;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Shape4: TShape;
    Label1: TLabel;
    Label2: TLabel;
    DMXTimer: TCHHighResTimer;
    CheckBox3: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button3Click(Sender: TObject);
    procedure DMXTimerTimer(Sender: TObject);
    procedure RefreshSometimesTimerTimer(Sender: TObject);
    procedure ConfigOKClick(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    RefreshSometimes:boolean;
    USBCheck: TComponentUSB;
    procedure NewUSBDevice(Sender: TObject);
    procedure RemoveUSBDevice(Sender: TObject);
    procedure OnDeviceChange(var Msg: TMsg);
  public
    { Public-Deklarationen }
    RefreshDLLEvent:TCallbackEvent;

    DMXOutArray:array of TDMXArray;
    DMXInArray:array of TDMXArray;
    DMXInArrayLastValue:array of TDMXArray;

    comportnumber:integer;
    baudrate:integer;
    rs232_inframe:array of byte;
    IsSending:boolean;

    Interfaces : array of TInterface;
    IF_Profiles : array of TInterface;
    procedure SearchForInterfaces;
    function GetPositionInInterfaceArray(Serial: String):integer;
    procedure RefreshList;
    procedure Startup;
    procedure DisconnectAllInterfaces;
    procedure SaveConfig;
  end;

var
  Config: TConfig;

implementation

{$R *.dfm}

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

procedure TConfig.Button1Click(Sender: TObject);
begin
  SaveConfig;
  SearchForInterfaces;
  RefreshList;
end;

procedure TConfig.FormShow(Sender: TObject);
begin
  RefreshList;
  Label1.Caption:='DLL Version: '+inttostr(susbdmx_version);
end;

function TConfig.GetPositionInInterfaceArray(Serial: String):integer;
var
  i:integer;
begin
  result:=-1;
  for i:=0 to length(Interfaces)-1 do
  begin
    if Interfaces[i].Serial=Serial then
    begin
      result:=i;
      break;
    end;
  end;
end;

procedure TConfig.RefreshList;
var
  i,Position:integer;
begin
  Position:=StringGrid1.Row;

  StringGrid1.Cells[0,0]:='DeviceID';
  StringGrid1.Cells[1,0]:='Serial';
  StringGrid1.Cells[2,0]:='Version';
  StringGrid1.Cells[3,0]:='Out-Adr.';
  StringGrid1.Cells[4,0]:='DMX-In';
  StringGrid1.Cells[5,0]:='In-Adr.';

  Stringgrid1.RowCount:=2;
  for i:=0 to length(Interfaces)-1 do
  begin
    if Interfaces[i].Serial<>'------------------' then
    begin
      StringGrid1.Cells[0,Stringgrid1.RowCount-1]:=inttostr(Interfaces[i].DeviceID);
      StringGrid1.Cells[1,Stringgrid1.RowCount-1]:=Interfaces[i].Serial;
      StringGrid1.Cells[2,Stringgrid1.RowCount-1]:=inttostr(Interfaces[i].Version);
      StringGrid1.Cells[3,Stringgrid1.RowCount-1]:=inttostr(Interfaces[i].UniverseOut);
      StringGrid1.Cells[5,Stringgrid1.RowCount-1]:=inttostr(Interfaces[i].UniverseIn);

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
  if (ACol=0) or (ACol=1) or (ACol=2) or (ACol=4) then
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
  if length(Interfaces)=0 then exit;

  if stringgrid1.Col=3 then
  begin
    try
      if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])>8192 then
        stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='8192';
      if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<1 then
        stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='1';
    except
      stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='1';
    end;

    Interfaces[GetPositionInInterfaceArray(stringgrid1.Cells[1,stringgrid1.Row])].UniverseOut:=strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]);
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

    Interfaces[GetPositionInInterfaceArray(stringgrid1.Cells[1,stringgrid1.Row])].UniverseIn:=strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]);
  end;
end;

procedure TConfig.SearchForInterfaces;
var
  i,j:integer;
  LastOneWasOK,newinterface:boolean;
  TypeID, Version, SerialSize:SmallInt;
  mySerial:widestring;
begin
  // zunächst alle Interfaceverbindungen beenden
  DisconnectAllInterfaces;

  i:=0;
  LastOneWasOK:=true;
  while LastOneWasOK do
  begin
    setlength(Interfaces, length(Interfaces)+1);
    setlength(DMXOutArray, length(Interfaces));
    setlength(DMXInArray, length(Interfaces));
    setlength(DMXInArrayLastValue, length(Interfaces));

    if susbdmx_open(i, Interfaces[i].Handle) then
    begin
      // Interface konnte geöffnet werden
      susbdmx_device_id(Interfaces[i].Handle, TypeID);
      Interfaces[i].DeviceID:=TypeID;

      mySerial:='------------------';
      SerialSize:=18;
      susbdmx_serial_get(Interfaces[i].Handle, mySerial, SerialSize);
      Interfaces[i].Serial:=mySerial;

      susbdmx_device_version(Interfaces[i].Handle, Version);
      Interfaces[i].Version:=Version;

      Interfaces[i].UniverseOut:=1;
      Interfaces[i].UniverseIn:=1;
      Interfaces[i].UseDMXIn:=false;

      LastOneWasOK:=true;
      i:=i+1;
    end else
    begin
      // Interface ist nicht verfügbar
      setlength(Interfaces, length(Interfaces)-1);
      setlength(DMXOutArray, length(Interfaces));
      setlength(DMXInArray, length(Interfaces));
      setlength(DMXInArrayLastValue, length(Interfaces));
      LastOneWasOK:=false;
    end;
  end;

  // Ist das Interface evtl. schon einmal konfiguriert worden?
  for i:=0 to length(Interfaces)-1 do
  begin
    newinterface:=true;
    
    for j:=0 to length(IF_Profiles)-1 do
    begin
      if IF_Profiles[j].Serial=Interfaces[i].Serial then
      begin
        newinterface:=false;
        Interfaces[i].UniverseOut:=IF_Profiles[j].UniverseOut;
        Interfaces[i].UniverseIn:=IF_Profiles[j].UniverseIn;
        Interfaces[i].UseDMXIn:=IF_Profiles[j].UseDMXIn;
        break;
      end;
    end;

    if newinterface and (Interfaces[i].Serial<>'------------------') then
    begin
      setlength(IF_Profiles, length(IF_Profiles)+1);
      IF_Profiles[length(IF_Profiles)-1].DeviceID:=Interfaces[i].DeviceID;
      IF_Profiles[length(IF_Profiles)-1].Serial:=Interfaces[i].Serial;
      IF_Profiles[length(IF_Profiles)-1].Version:=Interfaces[i].Version;
      IF_Profiles[length(IF_Profiles)-1].UniverseOut:=Interfaces[i].UniverseOut;
      IF_Profiles[length(IF_Profiles)-1].UniverseIn:=Interfaces[i].UniverseIn;
      IF_Profiles[length(IF_Profiles)-1].UseDMXIn:=Interfaces[i].UseDMXIn;
    end;
  end;
end;

procedure TConfig.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if length(Interfaces)=0 then exit;

  if StringGrid1.Col=4 then
  begin
    Interfaces[GetPositionInInterfaceArray(StringGrid1.Cells[1,StringGrid1.Row])].UseDMXIn:=not Interfaces[GetPositionInInterfaceArray(StringGrid1.Cells[1,StringGrid1.Row])].UseDMXIn;
  end;

  if not ((StringGrid1.Col=3) or (StringGrid1.Col=5)) then
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
      if (ARow>0) and (length(Interfaces)>0) then
      if Interfaces[GetPositionInInterfaceArray(StringGrid1.Cells[1,ARow])].UseDMXIn then
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
    setlength(IF_Profiles, 0);

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

procedure TConfig.DMXTimerTimer(Sender: TObject);
var
  i,j:integer;
  ptimestamp: SmallInt;
  pstatus: Byte;
  slots_get: Byte;

  myByte:Byte;
begin
  with config do
  begin
    for i:=0 to length(Interfaces)-1 do
    begin
      if Interfaces[i].UseDMXIn then
      begin
        // DMX-In
        if (Interfaces[i].Serial<>'------------------') and Interfaces[i].UseDMXIn then
        begin
          susbdmx_rx(Interfaces[i].Handle, 0, 513, DMXInArray[i][0], 0.0, 0, slots_get, ptimestamp, pstatus);

          for j:=1 to 512 do
          begin
            myByte:=DMXInArray[i][j]; // Workaround: direkter Zugriff auf Array gibt Zugriffsverletzung!!!
            if (myByte<>DMXInArrayLastValue[i][j]) or RefreshSometimes then
            begin
              DMXInArrayLastValue[i][j]:=myByte;
              IsSending:=CheckBox2.Checked;
              RefreshDLLEvent(j+Interfaces[i].UniverseIn-1, DMXInArray[i][j]);
            end;
          end;
        end;
      end else
      begin
        // DMX-Out
        ptimestamp:=0;
        pstatus:=0;
        DMXOutArray[i][0]:=0; // Startbyte immer auf Null setzen
        susbdmx_tx(Interfaces[i].Handle, 0, 513, DMXOutArray[i][0], 2, 0.1, 0.0002, 0.002, ptimestamp, pstatus);
      end;
    end;
    RefreshSometimes:=false;
  end;
end;

procedure TConfig.RefreshSometimesTimerTimer(Sender: TObject);
begin
  RefreshSometimes:=true;
end;

procedure TConfig.ConfigOKClick(Sender: TObject);
begin
  // Einstellungen speichern
  SaveConfig;

  RefreshSometimes:=true;
end;

procedure Tconfig.startup;
var
  LReg:TRegistry;
  count, i:integer;
begin
  setlength(IF_Profiles, 0);

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

          if not LReg.ValueExists('Interfaces automatisch erkennen') then
            LReg.WriteBool('Interfaces automatisch erkennen', False);
          Checkbox3.Checked:=LReg.ReadBool('Interfaces automatisch erkennen');

          if not LReg.KeyExists('Interfacedata') then
            LReg.CreateKey('Interfacedata');
          if LReg.OpenKey('Interfacedata',true) then
          begin
            if LReg.ValueExists('Interfacedatalength') then
            begin
              count:=LReg.ReadInteger('Interfacedatalength');
              setlength(IF_Profiles, count);
              for i:=0 to length(IF_Profiles)-1 do
              begin
                LReg.ReadBinaryData('Interface '+inttostr(i), IF_Profiles[i], sizeof(IF_Profiles[i]));
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  DMXTimer.Enabled:=true;
end;

procedure TConfig.DisconnectAllInterfaces;
var
  i:integer;
begin
  for i:=0 to length(Interfaces)-1 do
  begin
    susbdmx_close(Interfaces[i].Handle);
  end;
  setlength(Interfaces, 0);
  setlength(DMXOutArray, 0);
  setlength(DMXInArray, 0);
  setlength(DMXInArrayLastValue, 0);
end;

procedure TConfig.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  RefreshSometimesTimer.Enabled:=Checkbox1.Checked;
end;

procedure TConfig.SaveConfig;
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
          LReg.WriteBool('Interfaces automatisch erkennen', Checkbox3.Checked);

          if not LReg.KeyExists('Interfacedata') then
            LReg.CreateKey('Interfacedata');
          if LReg.OpenKey('Interfacedata',true) then
          begin
            LReg.WriteInteger('Interfacedatalength', length(IF_Profiles));

            for i:=0 to length(IF_Profiles)-1 do
            begin
              // noch schnell auf den neuesten Stand bringen
              for j:=0 to length(Interfaces)-1 do
              begin
                if Interfaces[j].Serial=IF_Profiles[i].Serial then
                begin
                  IF_Profiles[i].DeviceID:=Interfaces[j].DeviceID;
                  IF_Profiles[i].Version:=Interfaces[j].Version;
                  IF_Profiles[i].UniverseOut:=Interfaces[j].UniverseOut;
                  IF_Profiles[i].UniverseIn:=Interfaces[j].UniverseIn;
                  IF_Profiles[i].UseDMXIn:=Interfaces[j].UseDMXIn;
                  break;
                end;
              end;

              LReg.WriteBinaryData('Interface '+inttostr(i), IF_Profiles[i], sizeof(IF_Profiles[i]));
            end;
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TConfig.FormCreate(Sender: TObject);
begin
  // USB-Änderungen erkennen
  USBCheck := TComponentUSB.Create(Config);
  // Handler zum Erkennen neuer Laufwerke
  USBCheck.OnUSBArrival := NewUSBDevice;
  USBCheck.OnUSBRemove := RemoveUSBDevice;
end;

procedure TConfig.NewUSBDevice(Sender: TObject);
var
  Msg: TMsg;
begin
  Msg.message := DBT_DEVICEARRIVAL;
  OnDeviceChange(Msg);
end;

procedure TConfig.RemoveUSBDevice(Sender: TObject);
var
  Msg: TMsg;
begin
  Msg.message := DBT_DEVICEREMOVECOMPLETE;
  OnDeviceChange(Msg);
end;

procedure TConfig.OnDeviceChange(var Msg: TMsg);
begin
  if (Msg.message = DBT_DEVICEARRIVAL) or (Msg.message = DBT_DEVICEREMOVECOMPLETE) then
  begin
    if checkbox3.Checked then
    begin
      SaveConfig;
      SearchForInterfaces;
      RefreshList;
    end;
  end;
end;

end.
