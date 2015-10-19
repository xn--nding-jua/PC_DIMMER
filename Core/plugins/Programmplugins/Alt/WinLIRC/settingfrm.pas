unit settingfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, XPMan, ColorGrd, JvFullColorSpaces,
  ComCtrls, Registry, messagesystem, Mask, JvExMask, JvSpin, pngimage, ScktComp,
  Grids, Buttons, PngBitBtn, Menus;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackSendMessage = procedure(MSG:Byte; Data1, Data2: Variant);stdcall;

  TIREvent = record
    typ:integer;
    data1:integer;
    data2:integer;
    data3:integer;
    ID:TGUID;
    fernbedienung:string[255];
    taste:string[255];
    taste_raw:string[255];
  end;

  TSettings = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    cs: TClientSocket;
    Button1: TButton;
    GroupBox2: TGroupBox;
    memo1: TMemo;
    Label3: TLabel;
    GroupBox4: TGroupBox;
    StringGrid1: TStringGrid;
    ComboBox1: TComboBox;
    data1edit: TEdit;
    data2edit: TEdit;
    Label6: TLabel;
    data1lbl: TLabel;
    data2lbl: TLabel;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    RecordBox: TCheckBox;
    data3edit: TEdit;
    data3lbl: TLabel;
    CheckBox1: TCheckBox;
    Label4: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Einstellungenspeichern1: TMenuItem;
    Einstellungenladen1: TMenuItem;
    Einstellungenzurcksetzen1: TMenuItem;
    Pluginausblenden1: TMenuItem;
    N1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    idedit: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
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
    procedure Button1Click(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure data1editKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure data2editKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure data3editKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Pluginausblenden1Click(Sender: TObject);
    procedure Einstellungenzurcksetzen1Click(Sender: TObject);
    procedure Einstellungenladen1Click(Sender: TObject);
    procedure Einstellungenspeichern1Click(Sender: TObject);
    procedure ideditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    IREvent:array of TIREvent;
    FileStream:TFileStream;
    procedure RefreshStringGrid;
    procedure SaveFile(FileName:string);
    procedure OpenFile(FileName:string);
  public
    { Public-Deklarationen }
    shutdown:boolean;
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    SendMsg:TCallbackSendMessage;
    channelvalue:array[1..8192] of integer;
    channelnames:array[1..8192] of string;
  end;

var
  Settings: TSettings;

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

procedure TSettings.FormShow(Sender: TObject);
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
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
          LReg.WriteBool('Showing Plugin',true);
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TSettings.FormHide(Sender: TObject);
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
	        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
		        LReg.CreateKey(ExtractFileName(GetModulePath));
		      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
		      begin
	          LReg.WriteBool('Showing Plugin',false);
	          LReg.WriteBool('Connect to WinLIRC',checkbox1.checked);
		      end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
  end;

  SaveFile(ExtractFilePath(paramstr(0))+'\WinLIRC Client.pcdlirc');
end;


procedure TSettings.FormCreate(Sender: TObject);
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
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
          if LReg.ValueExists('Connect to WinLIRC') then
            Checkbox1.Checked:=LReg.ReadBool('Connect to WinLIRC');
          cs.Active:=Checkbox1.Checked;
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  StringGrid1.Cells[0,0]:=_('Ereignistyp');
  StringGrid1.Cells[1,0]:=_('Wert 1');
  StringGrid1.Cells[2,0]:=_('Wert 2');
  StringGrid1.Cells[3,0]:=_('Fernbedienung');
  StringGrid1.Cells[4,0]:=_('Taste');

  if FileExists(ExtractFilePath(paramstr(0))+'\WinLIRC Client.pcdlirc') then
    OpenFile(ExtractFilePath(paramstr(0))+'\WinLIRC Client.pcdlirc');
end;

procedure TSettings.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Checkbox1.Checked then
    cs.Active := true
  else
    cs.Active := false;
end;

procedure TSettings.csConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  memo1.lines.add(_('Connected'));
end;

procedure TSettings.csConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  memo1.lines.add(_('Connecting...'));
end;

procedure TSettings.csDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  memo1.lines.add(_('Disconnected'));
end;

procedure TSettings.csError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  memo1.lines.add(_('Error: ')+SysErrorMessage(errorcode));
  ErrorCode:=0;
end;

procedure TSettings.csLookup(Sender: TObject; Socket: TCustomWinSocket);
begin
  memo1.Clear;
  memo1.lines.add(_('Scanning...'));
end;

procedure TSettings.csRead(Sender: TObject; Socket: TCustomWinSocket);
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
    if ((StringGrid1.Row-1)<length(IREvent)) and (StringGrid1.Row>0) then
    begin
      IREvent[(StringGrid1.Row-1)].fernbedienung:=params[4];
      IREvent[(StringGrid1.Row-1)].taste:=params[3];
      IREvent[(StringGrid1.Row-1)].taste_raw:=params[1];
    end;
    RecordBox.Checked:=false;
    RefreshStringGrid;
  end else
  begin
    for i:=0 to length(IREvent)-1 do
    begin
      if (IREvent[i].fernbedienung=params[4]) and (IREvent[i].taste=params[3]) then
      begin
        case IREvent[i].typ of
          0:
          begin
            if strtoint('$'+params[2])=0 then
              RefreshDLLValues(IREvent[i].data1,channelvalue[IREvent[i].data1],IREvent[i].data2,IREvent[i].data3,0);
          end;
          1:
          begin
            if channelvalue[IREvent[i].data1]+IREvent[i].data2<=255 then
              RefreshDLLValues(IREvent[i].data1,channelvalue[IREvent[i].data1]+IREvent[i].data2,channelvalue[IREvent[i].data1]+IREvent[i].data2,0,0)
            else
              RefreshDLLValues(IREvent[i].data1,255,255,0,0)
          end;
          2:
          begin
            if channelvalue[IREvent[i].data1]-IREvent[i].data2>=0 then
              RefreshDLLValues(IREvent[i].data1,channelvalue[IREvent[i].data1]-IREvent[i].data2,channelvalue[IREvent[i].data1]-IREvent[i].data2,0,0)
            else
              RefreshDLLValues(IREvent[i].data1,0,0,0,0)
          end;
          3:
          begin
            SendMsg(MSG_STARTSCENE,GUIDToString(IREvent[i].id),0);
          end;
          4:
          begin
            SendMsg(MSG_STOPSCENE,GUIDToString(IREvent[i].id),0);
          end;
          5:
          begin
            if strtoint('$'+params[2])=0 then
              RefreshDLLEvent(IREvent[i].data1,IREvent[i].data2);
          end;
        end;

        if settings.Showing then
          StringGrid1.Row:=i+1;
      end;
    end;
  end;

  label2.Caption := params[4]+'->'+params[3];
end;

procedure TSettings.Button1Click(Sender: TObject);
begin
  Settings.hide;
end;

procedure TSettings.PngBitBtn1Click(Sender: TObject);
begin
  setlength(IREvent,length(IREvent)+1);
  RefreshStringGrid;
end;

procedure TSettings.RefreshStringGrid;
var
  i:integer;
begin
  if length(IREvent)<2 then
    StringGrid1.RowCount:=2
  else
    StringGrid1.RowCount:=length(IREvent)+1;

  for i:=0 to length(IREvent)-1 do
  begin
    StringGrid1.Cells[0,i+1]:=inttostr(IREvent[i].typ);
    StringGrid1.Cells[1,i+1]:=inttostr(IREvent[i].data1);
    StringGrid1.Cells[2,i+1]:=inttostr(IREvent[i].data2);
    StringGrid1.Cells[3,i+1]:=IREvent[i].fernbedienung;
    StringGrid1.Cells[4,i+1]:=IREvent[i].taste;
  end;

  if length(IREvent)=0 then
  begin
    StringGrid1.Cells[0,1]:='';
    StringGrid1.Cells[1,1]:='';
    StringGrid1.Cells[2,1]:='';
    StringGrid1.Cells[3,1]:='';
    StringGrid1.Cells[4,1]:='';
  end;

  idedit.Visible:=false;
  case Combobox1.ItemIndex of
    0:
    begin
      data1lbl.caption:=_('Kanal:');
      data2lbl.caption:=_('Wert [%]:');
      data3lbl.caption:=_('Zeit [ms]:');
    end;
    1:
    begin
      data1lbl.caption:=_('Kanal:');
      data2lbl.caption:=_('Summand:');
      data3lbl.caption:='';
    end;
    2:
    begin
      data1lbl.caption:=_('Kanal:');
      data2lbl.caption:=_('Subtrahend:');
      data3lbl.caption:='';
    end;
    3:
    begin
      data1lbl.caption:=_('ID:');
      data2lbl.caption:='';
      data3lbl.caption:='';
      idedit.Visible:=true;
    end;
    4:
    begin
      data1lbl.caption:=_('ID:');
      data2lbl.caption:='';
      data3lbl.caption:='';
      idedit.Visible:=true;
    end;
    5:
    begin
      data1lbl.caption:=_('Kanal:');
      data2lbl.caption:=_('Wert [%]:');
      data3lbl.caption:='';
    end;
  end;
end;

procedure TSettings.PngBitBtn2Click(Sender: TObject);
var
  i:integer;
begin
  if ((StringGrid1.Row-1)<length(IREvent)) and (StringGrid1.Row>0) then
  begin
    if (StringGrid1.Row-1)<length(IREvent)-1 then
    begin
      // Arraypositionen kopieren
      for i:=StringGrid1.Row-1 to length(IREvent)-2 do
      begin
        IREvent[i]:=IREvent[i+1];
      end;
    end;
    // letztes Element löschen
    setlength(IREvent,length(IREvent)-1);
    RefreshStringGrid;
  end;
end;

procedure TSettings.ComboBox1Select(Sender: TObject);
begin
  if (StringGrid1.Row-1<(length(IREvent))) and (StringGrid1.Row>0) then
  begin
    IREvent[StringGrid1.Row-1].typ:=Combobox1.ItemIndex;
  end;

  RefreshStringGrid;
end;

procedure TSettings.data1editKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
  begin
    if (StringGrid1.Row-1<(length(IREvent))) and (StringGrid1.Row>0) then
    begin
      IREvent[StringGrid1.Row-1].data1:=strtoint(data1edit.text);
    end;
    RefreshStringGrid;
  end;
end;

procedure TSettings.data2editKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
  begin
    if (StringGrid1.Row-1<(length(IREvent))) and (StringGrid1.Row>0) then
    begin
      IREvent[StringGrid1.Row-1].data2:=round(strtoint(data2edit.text)/100*255);
    end;
    RefreshStringGrid;
  end;
end;

procedure TSettings.data3editKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
  begin
    if (StringGrid1.Row-1<(length(IREvent))) and (StringGrid1.Row>0) then
    begin
      IREvent[StringGrid1.Row-1].data3:=strtoint(data3edit.text);
    end;
    RefreshStringGrid;
  end;
end;

procedure TSettings.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (StringGrid1.Row-1<(length(IREvent))) and (StringGrid1.Row>0) then
  begin
    Combobox1.itemindex:=IREvent[StringGrid1.Row-1].typ;
    data1edit.text:=inttostr(IREvent[StringGrid1.Row-1].data1);
    data2edit.text:=inttostr(round(IREvent[StringGrid1.Row-1].data2/255*100));
    data3edit.text:=inttostr(IREvent[StringGrid1.Row-1].data3);
    idedit.text:=GUIDToString(IREvent[StringGrid1.Row-1].id);
    RefreshStringGrid;
  end;
end;

procedure TSettings.Pluginausblenden1Click(Sender: TObject);
begin
  Settings.hide;
end;

procedure TSettings.Einstellungenzurcksetzen1Click(Sender: TObject);
begin
if messagedlg(_('Alle Einstellungen des WinLIRC-Plugins zurücksetzen?'),mtWarning,
  [mbYes,mbNo],0)=mrYes then
  begin
    setlength(IREvent,0);
    RefreshStringGrid;
  end;
end;

procedure TSettings.Einstellungenladen1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    OpenFile(OpenDialog1.FileName);
  end;
end;

procedure TSettings.Einstellungenspeichern1Click(Sender: TObject);
begin
  if Savedialog1.Execute then
  begin
    SaveFile(Savedialog1.FileName);
  end;
end;

procedure TSettings.SaveFile(FileName:string);
var
  i,count:integer;
begin
  FileStream:=TFilestream.Create(FileName,fmCreate);

  count:=length(IREvent);
  FileStream.WriteBuffer(count,sizeof(count));
  for i:=0 to length(IREvent)-1 do
  begin
    FileStream.WriteBuffer(IREvent[i].typ,sizeof(IREvent[i].typ));
    FileStream.WriteBuffer(IREvent[i].data1,sizeof(IREvent[i].data1));
    FileStream.WriteBuffer(IREvent[i].data2,sizeof(IREvent[i].data2));
    FileStream.WriteBuffer(IREvent[i].data3,sizeof(IREvent[i].data3));
    FileStream.WriteBuffer(IREvent[i].id,sizeof(IREvent[i].id));
    FileStream.WriteBuffer(IREvent[i].fernbedienung,sizeof(IREvent[i].fernbedienung));
    FileStream.WriteBuffer(IREvent[i].taste,sizeof(IREvent[i].taste));
    FileStream.WriteBuffer(IREvent[i].taste_raw,sizeof(IREvent[i].taste_raw));
  end;
  FileStream.Free;
end;

procedure TSettings.OpenFile(FileName:string);
var
  i,count:integer;
begin
  FileStream:=TFilestream.Create(FileName,fmOpenRead);

  FileStream.ReadBuffer(count,sizeof(count));
  setlength(IREvent,count);
  for i:=0 to length(IREvent)-1 do
  begin
    FileStream.ReadBuffer(IREvent[i].typ,sizeof(IREvent[i].typ));
    FileStream.ReadBuffer(IREvent[i].data1,sizeof(IREvent[i].data1));
    FileStream.ReadBuffer(IREvent[i].data2,sizeof(IREvent[i].data2));
    FileStream.ReadBuffer(IREvent[i].data3,sizeof(IREvent[i].data3));
    FileStream.ReadBuffer(IREvent[i].id,sizeof(IREvent[i].id));
    FileStream.ReadBuffer(IREvent[i].fernbedienung,sizeof(IREvent[i].fernbedienung));
    FileStream.ReadBuffer(IREvent[i].taste,sizeof(IREvent[i].taste));
    FileStream.ReadBuffer(IREvent[i].taste_raw,sizeof(IREvent[i].taste_raw));
  end;
  FileStream.Free;
  RefreshStringGrid;
end;

procedure TSettings.ideditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
  begin
    if (StringGrid1.Row-1<(length(IREvent))) and (StringGrid1.Row>0) then
    begin
      IREvent[StringGrid1.Row-1].id:=StringToGUID(idedit.text);
    end;
    RefreshStringGrid;
  end;
end;

end.
