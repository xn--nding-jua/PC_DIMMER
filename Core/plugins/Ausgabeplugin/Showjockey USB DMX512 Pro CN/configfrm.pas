unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry, CHHighResTimer, pngimage, Grids,
  Mask, JvExMask, JvSpin, Buttons, PngBitBtn, dxGDIPlusClasses;

type
  TDMXArray = array[0..511] of byte;
  PDMXArray = ^TDMXArray;
  TSerial = string[32];
  TSerialList = array[0..31] of TSerial;

  TPCD_Interface = record
    Active : boolean;
    Serial : TSerial;
    Startaddress : integer;
  end;

  TCallback = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

// Thread für DMX-Input deklarieren
  TConfig = class(TForm)
    GroupBox3: TGroupBox;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    ConfigOK: TButton;
    PngBitBtn3: TPngBitBtn;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    PngBitBtn2: TPngBitBtn;
    PngBitBtn1: TPngBitBtn;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Shape1: TShape;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    DMXOutArray:array[0..31] of TDMXArray;

    issending:boolean;
    shutdown:boolean;
    PCD_Interfaces : array[0..31] of TPCD_Interface;
    PreviousPCD_Interfaces : array of TPCD_Interface;

    GetAllConnectedInterfaces:function:TSerialList;stdcall;
    GetAllOpenedInterfaces:function:TSerialList;stdcall;
    OpenLink:procedure(Serial: TSerial; DMXOutArray:PDMXArray);stdcall;
    CloseLink:procedure(Serial:TSerial);stdcall;
    CloseAllLinks:procedure;stdcall;
    SetUniverse:procedure(Serial:TSerial; DMXOutArray:PDMXArray);stdcall;
    DLL:THandle;
    procedure SearchForInterfaces;
    function GetPositionInInterfaceArray(Serial: String):integer;
    procedure RefreshList;
    procedure Startup;
  end;

var
  Config: TConfig;

procedure LockWindow(const Handle: HWND);
procedure UnLockWindow(const Handle: HWND);

implementation

{$R *.dfm}

procedure LockWindow(const Handle: HWND);
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
end;

procedure UnlockWindow(const Handle: HWND);
begin
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  RedrawWindow(Handle, nil, 0,
    RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
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

procedure TConfig.Button1Click(Sender: TObject);
var
  i,j:integer;
begin
  // PreviousPCD_Interfaces noch schnell auf den neuesten Stand bringen
  for i:=0 to length(PreviousPCD_Interfaces)-1 do
  begin
    for j:=0 to 31 do
    begin
      if PCD_Interfaces[j].Serial=PreviousPCD_Interfaces[i].Serial then
      begin
        PreviousPCD_Interfaces[i].Active:=PCD_Interfaces[j].Active;
        PreviousPCD_Interfaces[i].Startaddress:=PCD_Interfaces[j].Startaddress;
        break;
      end;
    end;
  end;

  SearchForInterfaces;
  RefreshList;
end;

procedure TConfig.FormShow(Sender: TObject);
begin
  RefreshList;
end;

procedure TConfig.FormHide(Sender: TObject);
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
          if not LReg.KeyExists('Interfacedata') then
            LReg.CreateKey('Interfacedata');
          if LReg.OpenKey('Interfacedata',true) then
          begin
            LReg.WriteInteger('Interfacedatalength', length(PreviousPCD_Interfaces));

            for i:=0 to length(PreviousPCD_Interfaces)-1 do
            begin
              // noch schnell auf den neuesten Stand bringen
              for j:=0 to 31 do
              begin
                if PCD_Interfaces[j].Serial=PreviousPCD_Interfaces[i].Serial then
                begin
                  PreviousPCD_Interfaces[i].Active:=PCD_Interfaces[j].Active;
                  PreviousPCD_Interfaces[i].Startaddress:=PCD_Interfaces[j].Startaddress;
                  break;
                end;
              end;

              LReg.WriteBinaryData('Interface '+inttostr(i), PreviousPCD_Interfaces[i], sizeof(PreviousPCD_Interfaces[i]));
            end;
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

function TConfig.GetPositionInInterfaceArray(Serial: String):integer;
var
  i:integer;
begin
  result:=-1;
  for i:=0 to 31 do
  begin
    if PCD_Interfaces[i].Serial=Serial then
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

  StringGrid1.Cells[0,0]:='Aktiviert';
  StringGrid1.Cells[1,0]:='Interfaces';
  StringGrid1.Cells[2,0]:='Startadresse';

  Stringgrid1.RowCount:=2;
  for i:=0 to 31 do
  begin
    if PCD_Interfaces[i].Serial<>'00000000000000000000000000000000' then
    begin
      StringGrid1.Cells[1,Stringgrid1.RowCount-1]:=PCD_Interfaces[i].Serial;
      StringGrid1.Cells[2,Stringgrid1.RowCount-1]:=inttostr(PCD_Interfaces[i].Startaddress);

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
  if (ACol=0) or (ACol=1) then
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
  if length(PCD_Interfaces)=0 then exit;

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

    PCD_Interfaces[GetPositionInInterfaceArray(stringgrid1.Cells[1,stringgrid1.Row])].Startaddress:=strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]);
  end;
end;

procedure TConfig.SearchForInterfaces;
var
  i,j:integer;
  Serials:TSeriallist;
  newinterface:boolean;
begin
  Serials:=GetAllConnectedInterfaces;
  for i:=0 to 31 do
  begin
    PCD_Interfaces[i].Active:=false;
    PCD_Interfaces[i].Serial:=Serials[i];
    PCD_Interfaces[i].Startaddress:=1;
  end;

  // Ist das Interface schonmal konfiguriert worden?
  for i:=0 to 31 do
  begin
    newinterface:=true;
    
    for j:=0 to length(PreviousPCD_Interfaces)-1 do
    begin
      if PCD_Interfaces[i].Serial=PreviousPCD_Interfaces[j].Serial then
      begin
        newinterface:=false;
        PCD_Interfaces[i].Active:=PreviousPCD_Interfaces[j].Active;
        PCD_Interfaces[i].Startaddress:=PreviousPCD_Interfaces[j].Startaddress;
        break;
      end;
    end;

    if newinterface and (PCD_Interfaces[i].Serial<>'00000000000000000000000000000000') then
    begin
      setlength(PreviousPCD_Interfaces, length(PreviousPCD_Interfaces)+1);
      PreviousPCD_Interfaces[length(PreviousPCD_Interfaces)-1].Serial:=PCD_Interfaces[i].Serial;
      PreviousPCD_Interfaces[length(PreviousPCD_Interfaces)-1].Startaddress:=PCD_Interfaces[i].Startaddress;
      PCD_Interfaces[GetPositionInInterfaceArray(PCD_Interfaces[i].Serial)].Active:=true; // Standardmäßig aktiviert
      PreviousPCD_Interfaces[length(PreviousPCD_Interfaces)-1].Active:=PCD_Interfaces[i].Active;
    end;
  end;

  for i:=0 to 31 do
  begin
    if (PCD_Interfaces[i].Serial<>'00000000000000000000000000000000') and (PCD_Interfaces[i].Active) then
    begin
      OpenLink(PCD_Interfaces[i].Serial,@DMXOutArray[i]);

      // Noch alle Werte in der Hardware manuell aktualisieren
      SetUniverse(PCD_Interfaces[i].Serial,@DMXOutArray[i]);
    end;
  end;
end;

procedure TConfig.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if length(PCD_Interfaces)=0 then exit;

  if StringGrid1.Col=0 then
  begin
    if PCD_Interfaces[GetPositionInInterfaceArray(StringGrid1.Cells[1,StringGrid1.Row])].Active then
    begin
      CloseLink(Stringgrid1.Cells[1,Stringgrid1.Row]);
      PCD_Interfaces[GetPositionInInterfaceArray(StringGrid1.Cells[1,StringGrid1.Row])].Active:=false;
    end else
    begin
      OpenLink(Stringgrid1.Cells[1,Stringgrid1.Row],@DMXOutArray[GetPositionInInterfaceArray(Stringgrid1.Cells[1,Stringgrid1.Row])]);
      PCD_Interfaces[GetPositionInInterfaceArray(StringGrid1.Cells[1,StringGrid1.Row])].Active:=true;

      // Noch alle Werte in der Hardware manuell aktualisieren
      SetUniverse(Stringgrid1.Cells[1,Stringgrid1.Row],@DMXOutArray[GetPositionInInterfaceArray(Stringgrid1.Cells[1,Stringgrid1.Row])]);
    end;
    RefreshList;
  end;
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

    if (ARow>0) and (ACol = 0) then
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
      if (ARow>0) and (length(PCD_Interfaces)>0) then
      if PCD_Interfaces[GetPositionInInterfaceArray(StringGrid1.Cells[1,ARow])].Active then
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
    setlength(PreviousPCD_Interfaces, 0);

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

procedure TConfig.Button2Click(Sender: TObject);
var
  i:integer;
begin
  CloseAllLinks;
  for i:=0 to 31 do
    PCD_Interfaces[i].Active:=false;
  RefreshList;
end;

procedure TConfig.Startup;
var
  LReg:TRegistry;
  count, i:integer;
begin
  DLL:=LoadLibrary(PChar(ExtractFilePath(paramstr(0))+'\sj_dmx512.dll'));

  GetAllConnectedInterfaces:=GetProcAddress(DLL,'GetAllConnectedInterfaces');
  GetAllOpenedInterfaces:=GetProcAddress(DLL,'GetAllOpenedInterfaces');
  OpenLink:=GetProcAddress(DLL,'OpenLink');
  CloseLink:=GetProcAddress(DLL,'CloseLink');
  CloseAllLinks:=GetProcAddress(DLL,'CloseAllLinks');
  SetUniverse:=GetProcAddress(DLL,'SetUniverse');

  setlength(PreviousPCD_Interfaces, 0);

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
          if not LReg.KeyExists('Interfacedata') then
            LReg.CreateKey('Interfacedata');
          if LReg.OpenKey('Interfacedata',true) then
          begin

            if LReg.ValueExists('Interfacedatalength') then
            begin
              count:=LReg.ReadInteger('Interfacedatalength');
              setlength(PreviousPCD_Interfaces, count);
              for i:=0 to length(PreviousPCD_Interfaces)-1 do
              begin
                LReg.ReadBinaryData('Interface '+inttostr(i), PreviousPCD_Interfaces[i], sizeof(PreviousPCD_Interfaces[i]));
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  SearchForInterfaces;
end;

end.
