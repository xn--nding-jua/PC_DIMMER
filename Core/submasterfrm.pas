unit submasterfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Mask, MPlayer, Menus,
  Buttons, ImgList, Registry, messagesystem, befehleditorform2,
  insscene, midievent, PngBitBtn, gnugettext, GR32;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: integer; // 0 Einfache Szenen, 1 Geräteszenen, 2 Audioszenen, 3 Bewegungsszenen, 4 Befehle, 5 Kombinationsszenen, 6 Presets, 7 Automatikszenen, 8 Effekt, 9 MediaCenter Szenen
    IsRootNode:boolean;
    IsCatNode:boolean;
    Caption:WideString;
    Beschreibung:WideString;
    Fadetime:WideString;
    ID:TGUID;
  end;

  Tsubmasterform = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    GroupBox2: TGroupBox;
    FlashMasterScrollbar: TScrollBar;
    FlashMasterProgressBar: TProgressBar;
    FlashMasterLabel: TLabel;
    Setup1: TButton;
    Setup2: TButton;
    Setup3: TButton;
    Setup4: TButton;
    Setup5: TButton;
    Setup6: TButton;
    Setup7: TButton;
    Setup8: TButton;
    Setup9: TButton;
    Setup10: TButton;
    Setup11: TButton;
    Setup12: TButton;
    Setup13: TButton;
    Setup14: TButton;
    Setup15: TButton;
    Button16: TButton;
    Setup16: TButton;
    BankSelect: TComboBox;
    Label17: TLabel;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn3: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    PopupMenu1: TPopupMenu;
    Befehl1: TMenuItem;
    Szene1: TMenuItem;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Timer1: TTimer;
    SubmasterSendTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FlashMasterScrollbarChange(Sender: TObject);
    procedure FlashMasterScrollbarScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure Setup1Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure PngBitBtn3Click(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure BankSelectChange(Sender: TObject);
    function MyMessageDlg(const Msg: string; DlgType : TMsgDlgType;
      Buttons : TMsgDlgButtons; Captions: array of string) : Integer;
    procedure Timer1Timer(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure SubmasterSendTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
    firststart:boolean;
    updatingbyprogram:boolean;
    _Buffer: TBitmap32;
    mousex,mousey,mouseoverfader,maxfaders:integer;
    abstand:integer;
    GedrehteSchrift:HGDIOBJ;
    redrawsubmaster:boolean;
    FaderChanged:array of integer;
    procedure CopyBank(Source, Destination:integer);
    procedure CheckButtons;
  public
    { Public-Deklarationen }
    scrollbarvalue:array of byte;
    slidervalue_temp:array of byte;

    shutdown:boolean;
		shutdownbypcdimmeroff:boolean;

    FileStream:TFileStream;

    procedure NewFile;
    procedure MSGOpen;
    procedure MSGSave;
    procedure OpenFile(Filename: string);
    procedure ChangeSubmaster(SubmasterNr, Value: integer);
  end;

var
  submasterform: Tsubmasterform;

implementation

uses PCDIMMER, geraetesteuerungfrm, devicechannelselectionfrm, masterfrm,
  szenenverwaltung;

{$R *.dfm}

function RGB2TColor(const R, G, B: Byte): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := R + G shl 8 + B shl 16;
end;

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

procedure Tsubmasterform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  firststart:=true;
  updatingbyprogram:=false;
                                   //2700
  GedrehteSchrift:=CreateFont(10, 4, 900, 0, fw_normal, 0, 0, 0, 1, 0, $10, 2, 4, PChar('Arial'));
  _Buffer := TBitmap32.Create;
  _Buffer.Width:= PaintBox1.Width;
  _Buffer.Height:= PaintBox1.Height;
  maxfaders:=16;
  setlength(FaderChanged, maxfaders);
  abstand:=41;//40;
end;

procedure Tsubmasterform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MSGSave;
end;

procedure Tsubmasterform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  SubmasterSendTimer.Enabled:=false;
  timer1.enabled:=false;

	if not mainform.shutdown then
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
					LReg.WriteBool('Showing Submaster',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;
  mainform.SaveWindowPositions('submaster');
end;

procedure Tsubmasterform.FormShow(Sender: TObject);
var
  LReg:TRegistry;
begin
  if firststart then
  begin
    firststart:=false;
    setlength(scrollbarvalue,16);
    setlength(slidervalue_temp,16);
  end;

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
  			LReg.WriteBool('Showing Submaster',true);

        if not LReg.KeyExists('Submaster') then
	        LReg.CreateKey('Submaster');
	      if LReg.OpenKey('Submaster',true) then
	      begin
{
            if LReg.ValueExists('Width') then
              submasterform.ClientWidth:=LReg.ReadInteger('Width')
            else
              submasterform.ClientWidth:=1048;
            if LReg.ValueExists('Height') then
              submasterform.ClientHeight:=LReg.ReadInteger('Height')
            else
              submasterform.ClientHeight:=361;
}
          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+submasterform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              submasterform.Left:=LReg.ReadInteger('PosX')
            else
              submasterform.Left:=0;
          end else
            submasterform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+submasterform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              submasterform.Top:=LReg.ReadInteger('PosY')
            else
              submasterform.Top:=0;
          end else
            submasterform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  timer1.enabled:=true;
  SubmasterSendTimer.Enabled:=true;
end;

procedure Tsubmasterform.SpeedButton3Click(Sender: TObject);
var
  i:integer;
begin
if messagedlg(_('Möchten Sie den aktuellen Submaster zurücksetzen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    for i:=1 to 16 do
    begin
      mainform.Submasterbank[BankSelect.Itemindex].SubmasterName[i]:='Submaster '+inttostr(i);
      setlength(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[i],0);
    end;
    BankSelectChange(BankSelect);
  end;
end;

procedure Tsubmasterform.SpeedButton2Click(Sender: TObject);
var
  j,k,l,count, count2,count3:integer;
begin
  if (length(mainform.Submasterbank)>0) and (BankSelect.ItemIndex<length(mainform.Submasterbank)) and SaveDialog1.Execute then
  begin
    if not DirectoryExists(ExtractFilepath(SaveDialog1.Filename)) then
      CreateDir(ExtractFilepath(SaveDialog1.Filename));
    FileStream:=TFileStream.Create(SaveDialog1.FileName,fmCreate);

{
    // kompletten Submaster speichern
    count:=length(mainform.Submasterbank);
    FileStream.WriteBuffer(count,sizeof(count));
    for i:=0 to count-1 do
    begin
      FileStream.WriteBuffer(mainform.Submasterbank[i].BankName, sizeof(mainform.Submasterbank[i].BankName));
      FileStream.WriteBuffer(mainform.Submasterbank[i].SubmasterName, sizeof(mainform.Submasterbank[i].SubmasterName));
      for j:=1 to 16 do
      begin
        count2:=length(mainform.Submasterbank[i].Submasterdevices[j]);
        FileStream.WriteBuffer(count2,sizeof(count2));
        for k:=0 to count2-1 do
        begin
          FileStream.WriteBuffer(mainform.Submasterbank[i].Submasterdevices[j][k].ID,sizeof(mainform.Submasterbank[i].Submasterdevices[j][k].ID));
          count3:=length(mainform.Submasterbank[i].Submasterdevices[j][k].ChanActive);
          FileStream.WriteBuffer(count3,sizeof(count3));
          for l:=0 to count3-1 do
          begin
            FileStream.WriteBuffer(mainform.Submasterbank[i].Submasterdevices[j][k].ChanActive[l],sizeof(mainform.Submasterbank[i].Submasterdevices[j][k].ChanActive[l]));;
          end;
        end;
      end;
    end;
}

    // Projektversion
    count:=mainform.currentprojectversion;
    Filestream.WriteBuffer(Count, sizeof(Count));

    // nur aktuelle Bank speichern
    FileStream.WriteBuffer(mainform.Submasterbank[BankSelect.Itemindex].BankName, sizeof(mainform.Submasterbank[BankSelect.Itemindex].BankName));
    FileStream.WriteBuffer(mainform.Submasterbank[BankSelect.Itemindex].SubmasterName, sizeof(mainform.Submasterbank[BankSelect.Itemindex].SubmasterName));
    FileStream.WriteBuffer(mainform.Submasterbank[BankSelect.Itemindex].UseScene, sizeof(mainform.Submasterbank[BankSelect.Itemindex].UseScene));
    FileStream.WriteBuffer(mainform.Submasterbank[BankSelect.Itemindex].SubmasterScene, sizeof(mainform.Submasterbank[BankSelect.Itemindex].SubmasterScene));
    for j:=1 to 16 do
    begin
      count2:=length(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j]);
      FileStream.WriteBuffer(count2,sizeof(count2));
      for k:=0 to count2-1 do
      begin
        FileStream.WriteBuffer(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j][k].ID,sizeof(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j][k].ID));
        count3:=length(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j][k].ChanActive);
        FileStream.WriteBuffer(count3,sizeof(count3));
        for l:=0 to count3-1 do
        begin
          FileStream.WriteBuffer(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j][k].ChanActive[l],sizeof(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j][k].ChanActive[l]));;
        end;
      end;
    end;

	  FileStream.Free;
  end;
end;

procedure Tsubmasterform.Openfile(Filename: string);
var
  j,k,l,count2,count3, Fileversion:integer;
begin
  if (length(mainform.Submasterbank)>0) and (BankSelect.ItemIndex<length(mainform.Submasterbank)) then
  begin
    if FileExists(Filename) then
    begin
      FileStream:=TFileStream.Create(Filename,fmOpenRead);

      // Projektversion
      Filestream.ReadBuffer(FileVersion, sizeof(FileVersion));

      // nur aktuelle Bank laden
      FileStream.ReadBuffer(mainform.Submasterbank[BankSelect.Itemindex].BankName, sizeof(mainform.Submasterbank[BankSelect.Itemindex].BankName));

      if Fileversion<451 then
      begin
        FileStream.ReadBuffer(mainform.Submasterbank[BankSelect.Itemindex].SubmasterName, sizeof(mainform.Submasterbank[BankSelect.Itemindex].SubmasterName));
      end;

      for j:=1 to 16 do
      begin
        if Fileversion>=451 then
        begin
          FileStream.ReadBuffer(mainform.Submasterbank[BankSelect.Itemindex].SubmasterName[j], sizeof(mainform.Submasterbank[BankSelect.Itemindex].SubmasterName[j]));
          FileStream.ReadBuffer(mainform.Submasterbank[BankSelect.Itemindex].UseScene[j], sizeof(mainform.Submasterbank[BankSelect.Itemindex].UseScene[j]));
          FileStream.ReadBuffer(mainform.Submasterbank[BankSelect.Itemindex].SubmasterScene[j], sizeof(mainform.Submasterbank[BankSelect.Itemindex].SubmasterScene[j]));
        end;

        FileStream.ReadBuffer(count2,sizeof(count2));
        setlength(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j],count2);
        for k:=0 to count2-1 do
        begin
          FileStream.ReadBuffer(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j][k].ID,sizeof(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j][k].ID));
          FileStream.ReadBuffer(count3,sizeof(count3));
          setlength(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j][k].ChanActive,count3);
          for l:=0 to count3-1 do
          begin
            FileStream.ReadBuffer(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j][k].ChanActive[l],sizeof(mainform.Submasterbank[BankSelect.Itemindex].Submasterdevices[j][k].ChanActive[l]));;
          end;
        end;
      end;

      FileStream.Free;
    end;
  end;
end;

procedure Tsubmasterform.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Openfile(OpenDialog1.FileName);
  end;
end;

procedure Tsubmasterform.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,value:integer;
begin
  for i:=1 to 16 do
  begin
    if Sender=FindComponent('Button'+inttostr(i)) then
    begin
      scrollbarvalue[i-1]:=mainform.Submasterbank[BankSelect.ItemIndex].CurrentValue[i];
      value:=255-masterform.FlashMaster.Position;

      ChangeSubmaster(i, value);

      break;
    end;
  end;
end;

procedure Tsubmasterform.Button1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,value:integer;
begin
  for i:=1 to 16 do
    if Sender=FindComponent('Button'+inttostr(i)) then
    begin
      value:=scrollbarvalue[i-1];

      ChangeSubmaster(i, value);

      scrollbarvalue[i-1]:=mainform.Submasterbank[BankSelect.ItemIndex].CurrentValue[i];
      break;
    end;
end;

procedure Tsubmasterform.NewFile;
var
  i:integer;
begin
  setlength(mainform.Submasterbank,0);
  BankSelect.Items.Clear;

  setlength(mainform.Submasterbank,length(mainform.Submasterbank)+1);
  mainform.Submasterbank[length(mainform.Submasterbank)-1].BankName:=_('Neue Submasterbank');
  for i:=1 to 16 do
    mainform.Submasterbank[length(mainform.Submasterbank)-1].SubmasterName[i]:='Submaster '+inttostr(i);
  BankSelect.ItemIndex:=BankSelect.Items.Add(_('Neue Submasterbank'));
  BankSelectChange(BankSelect);
end;

procedure Tsubmasterform.FlashMasterScrollbarChange(Sender: TObject);
begin
  masterform.FlashMaster.Position:=FlashmasterScrollbar.Position;
  FlashmasterProgressBar.Position:=255-masterform.FlashMaster.Position;
  FlashmasterProgressBar.Position:=255-masterform.FlashMaster.Position-1;
  FlashmasterProgressBar.Position:=255-masterform.FlashMaster.Position;
  FlashmasterLabel.Caption:=inttostr(round(((255-FlashmasterScrollbar.Position)/255)*100))+'%';
end;

procedure Tsubmasterform.FlashMasterScrollbarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  masterform.flashmaster.position:=FlashmasterScrollbar.Position;
end;

procedure Tsubmasterform.Setup1Click(Sender: TObject);
var
  i,k,m:integer;
  SzenenData:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (length(mainform.Submasterbank)<=0) or (BankSelect.ItemIndex>=length(mainform.Submasterbank)) then
  begin
    ShowMessage(_('Bitte fügen Sie zunächst eine Submasterbank über das grüne Plus hinzu...'));
    exit;
  end;

  case mymessagedlg(_('Was möchten Sie mit diesem Submaster einstellen/ausführen?'),mtConfirmation,[mbYes,mbNo,mbCancel],[_('Kanäle'),_('Befehle'),_('Szene')]) of
    mrYes:
    begin
      for i:=1 to 16 do
      begin
        if (Sender=FindComponent('Setup'+inttostr(i))) then
        begin
          mainform.Submasterbank[BankSelect.ItemIndex].UseBefehl[i]:=false;
          mainform.Submasterbank[BankSelect.ItemIndex].UseScene[i]:=false;

          // Aktuelle Daten des Submasters dem Fensterarray zuweisen
          setlength(mainform.DeviceChannelSelection,length(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i]));
          for k:=0 to length(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i])-1 do
          begin
            mainform.DeviceChannelSelection[k].ID:=mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ID;
            setlength(mainform.DeviceChannelSelection[k].ChanActive,length(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanActive));
            setlength(mainform.DeviceChannelSelection[k].ChanValue,length(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanValue));
            setlength(mainform.DeviceChannelSelection[k].ChanDelay,length(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanDelay));
            for m:=0 to length(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanActive)-1 do
            begin
              mainform.DeviceChannelSelection[k].ChanActive[m]:=mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanActive[m];
              mainform.DeviceChannelSelection[k].ChanValue[m]:=mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanValue[m];
              mainform.DeviceChannelSelection[k].ChanDelay[m]:=mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanDelay[m];
            end;
          end;
      
          devicechannelselectionform.showmodal;

          // Daten dem Submaster zuführen
          setlength(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i],length(mainform.DeviceChannelSelection));
          for k:=0 to length(mainform.DeviceChannelSelection)-1 do
          begin
            mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ID:=mainform.DeviceChannelSelection[k].ID;
            setlength(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanActive,length(mainform.DeviceChannelSelection[k].ChanActive));
            setlength(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanValue,length(mainform.DeviceChannelSelection[k].ChanValue));
            setlength(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanDelay,length(mainform.DeviceChannelSelection[k].ChanDelay));
            for m:=0 to length(mainform.DeviceChannelSelection[k].ChanActive)-1 do
            begin
              mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanActive[m]:=mainform.DeviceChannelSelection[k].ChanActive[m];
              mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanValue[m]:=mainform.DeviceChannelSelection[k].ChanValue[m];
              mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[i][k].ChanDelay[m]:=mainform.DeviceChannelSelection[k].ChanDelay[m];
            end;
          end;
        end;
      end;
    end;
    mrNo:
    begin
      for i:=1 to 16 do
      begin
        if (Sender=FindComponent('Setup'+inttostr(i))) then
        begin
          mainform.Submasterbank[BankSelect.ItemIndex].UseBefehl[i]:=true;
          mainform.Submasterbank[BankSelect.ItemIndex].UseScene[i]:=false;

          mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].OnValue:=255;
          mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].OffValue:=0;
          mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].SwitchValue:=128;

          setlength(befehlseditor_array2,length(befehlseditor_array2)+1);
          befehlseditor_array2[length(befehlseditor_array2)-1]:=Tbefehlseditor2.Create(self);

          befehlseditor_array2[length(befehlseditor_array2)-1].ShowInputValueToo:=true;

          befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ID:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ID;
          befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Typ:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].Typ;
          befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Name:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].Name;
          befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Beschreibung:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].Beschreibung;
          befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OnValue:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].OnValue;
          befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OffValue:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].OffValue;
          befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.SwitchValue:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].SwitchValue;
          befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ScaleValue:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ScaleValue;
          setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger,length(mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgInteger));
          for m:=0 to length(mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgInteger)-1 do
            befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger[m]:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgInteger[m];
          setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString,length(mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgString));
          for m:=0 to length(mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgString)-1 do
            befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString[m]:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgString[m];
          setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID,length(mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgGUID));
          for m:=0 to length(mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgGUID)-1 do
            befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID[m]:=mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgGUID[m];

          befehlseditor_array2[length(befehlseditor_array2)-1].ShowModal;

          if befehlseditor_array2[length(befehlseditor_array2)-1].ModalResult=mrOK then
          begin
            mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].Typ:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Typ;
            mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].Name:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Name;
            mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].Beschreibung:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Beschreibung;
            mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].OnValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OnValue;
            mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].OffValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OffValue;
            mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].SwitchValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.SwitchValue;
            mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ScaleValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ScaleValue;
            setlength(mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgInteger,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger));
            for m:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger)-1 do
              mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgInteger[m]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger[m];
            setlength(mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgString,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString));
            for m:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString)-1 do
              mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgString[m]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString[m];
            setlength(mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgGUID,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID));
            for m:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID)-1 do
              mainform.Submasterbank[BankSelect.ItemIndex].Befehl[i].ArgGUID[m]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID[m];
          end;

          befehlseditor_array2[length(befehlseditor_array2)-1].Free;
          setlength(befehlseditor_array2,length(befehlseditor_array2)-1);
        end;
      end;
    end;
    mrCancel:
    begin
      for i:=1 to 16 do
      begin
        if (Sender=FindComponent('Setup'+inttostr(i))) then
        begin
          mainform.Submasterbank[BankSelect.ItemIndex].UseScene[i]:=true;
          mainform.Submasterbank[BankSelect.ItemIndex].UseBefehl[i]:=false;

          // Szenenauswahl hier:
          setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
          szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

          szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionselection:=mainform.Submasterbank[BankSelect.ItemIndex].SubmasterScene[i];
          szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal;

          if (szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ModalResult=mrOK) and
            (szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount>0) then
          begin
            SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);
            mainform.Submasterbank[BankSelect.ItemIndex].SubmasterScene[i]:=SzenenData^.ID;
          end;

          szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
          setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
        end;
      end;
    end;
  end;
end;

procedure Tsubmasterform.MSGopen;
var
  i:integer;
begin
  BankSelect.Items.Clear;
  for i:=0 to length(mainform.Submasterbank)-1 do
  begin
    BankSelect.Items.Add(mainform.Submasterbank[i].BankName);
  end;
  BankSelect.ItemIndex:=0;
  BankSelectChange(BankSelect);
end;

procedure Tsubmasterform.MSGSave;
begin
//
end;

procedure Tsubmasterform.CreateParams(var Params:TCreateParams);
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

procedure Tsubmasterform.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Tsubmasterform.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tsubmasterform.PngBitBtn1Click(Sender: TObject);
var
  i:integer;
begin
  setlength(mainform.Submasterbank,length(mainform.Submasterbank)+1);
  mainform.Submasterbank[length(mainform.Submasterbank)-1].BankName:=_('Neue Submasterbank');
  for i:=1 to 16 do
  begin
    mainform.Submasterbank[length(mainform.Submasterbank)-1].SubmasterName[i]:='Submaster '+inttostr(i);
    mainform.Submasterbank[length(mainform.Submasterbank)-1].UseBefehl[i]:=false;
    CreateGUID(mainform.Submasterbank[length(mainform.Submasterbank)-1].Befehl[i].ID);
    mainform.Submasterbank[length(mainform.Submasterbank)-1].CurrentValue[i]:=0;
  end;
  BankSelect.ItemIndex:=BankSelect.Items.Add(_('Neue Submasterbank'));
  BankSelectChange(BankSelect);
  CheckButtons;
end;

procedure Tsubmasterform.PngBitBtn3Click(Sender: TObject);
var
  Index:integer;
begin
  if (length(mainform.Submasterbank)<=0) or (BankSelect.ItemIndex>=length(mainform.Submasterbank)) then
    exit;

  Index:=BankSelect.ItemIndex;
  mainform.Submasterbank[BankSelect.ItemIndex].BankName:=InputBox(_('Neue Bank-Beschriftung'),_('Bitte geben Sie eine neue Bezeichnung für diese Submaster-Bank ein:'),mainform.Submasterbank[BankSelect.ItemIndex].BankName);
  BankSelect.Items[BankSelect.ItemIndex]:=mainform.Submasterbank[BankSelect.ItemIndex].BankName;
  BankSelect.ItemIndex:=Index;
end;

procedure Tsubmasterform.PngBitBtn2Click(Sender: TObject);
var
  BankToDelete,i:integer;
begin
  if (length(mainform.Submasterbank)<=0) or (BankSelect.ItemIndex>=length(mainform.Submasterbank)) then
    exit;

  if messagedlg(_('Möchten Sie die aktuelle Bank wirklich löschen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    BankToDelete:=BankSelect.ItemIndex;
    if BankToDelete=length(mainform.Submasterbank)-1 then
    begin
      // Letzte Bank einfach löschen
      setlength(mainform.Submasterbank,length(mainform.Submasterbank)-1);
      BankSelect.Items.Delete(BankSelect.Items.Count-1);
      BankSelect.ItemIndex:=BankSelect.Items.Count-1;
    end else
    begin
      // alle nachliegenden Bänke um eins vorkopieren
      for i:=BankToDelete to length(mainform.Submasterbank)-2 do
        CopyBank(i+1, i);
      setlength(mainform.Submasterbank,length(mainform.Submasterbank)-1);
      BankSelect.Items.Delete(BankToDelete);
      BankSelect.ItemIndex:=BankToDelete;
    end;
    BankSelectChange(BankSelect);
  end;
  CheckButtons;
end;

procedure Tsubmasterform.CopyBank(Source, Destination:integer);
var
  i,j,k:integer;
begin
  mainform.Submasterbank[Destination].BankName:=mainform.Submasterbank[Source].BankName;
  for i:=1 to 16 do
  begin
    setlength(mainform.Submasterbank[Destination].Submasterdevices[i],length(mainform.Submasterbank[Source].Submasterdevices[i]));
    for j:=0 to length(mainform.Submasterbank[Source].Submasterdevices[i])-1 do
    begin
      mainform.Submasterbank[Destination].Submasterdevices[i][j].ID:=mainform.Submasterbank[Source].Submasterdevices[i][j].ID;

      setlength(mainform.Submasterbank[Destination].Submasterdevices[i][j].ChanActive,length(mainform.Submasterbank[Source].Submasterdevices[i][j].ChanActive));
      setlength(mainform.Submasterbank[Destination].Submasterdevices[i][j].ChanValue,length(mainform.Submasterbank[Source].Submasterdevices[i][j].ChanValue));
      setlength(mainform.Submasterbank[Destination].Submasterdevices[i][j].ChanDelay,length(mainform.Submasterbank[Source].Submasterdevices[i][j].ChanDelay));
      for k:=0 to length(mainform.Submasterbank[Source].Submasterdevices[i][j].ChanActive)-1 do
      begin
        mainform.Submasterbank[Destination].Submasterdevices[i][j].ChanActive[k]:=mainform.Submasterbank[Source].Submasterdevices[i][j].ChanActive[k];
        mainform.Submasterbank[Destination].Submasterdevices[i][j].ChanValue[k]:=mainform.Submasterbank[Source].Submasterdevices[i][j].ChanValue[k];
        mainform.Submasterbank[Destination].Submasterdevices[i][j].ChanDelay[k]:=mainform.Submasterbank[Source].Submasterdevices[i][j].ChanDelay[k];
      end;
    end;
    mainform.Submasterbank[Destination].SubmasterName[i]:=mainform.Submasterbank[Source].SubmasterName[i];

    mainform.Submasterbank[Destination].CurrentValue[i]:=mainform.Submasterbank[Source].CurrentValue[i];

    mainform.Submasterbank[Destination].UseBefehl[i]:=mainform.Submasterbank[Source].UseBefehl[i];

    mainform.Submasterbank[Destination].Befehl[i].ID:=mainform.Submasterbank[Source].Befehl[i].ID;
    mainform.Submasterbank[Destination].Befehl[i].Typ:=mainform.Submasterbank[Source].Befehl[i].Typ;
    mainform.Submasterbank[Destination].Befehl[i].Name:=mainform.Submasterbank[Source].Befehl[i].Name;
    mainform.Submasterbank[Destination].Befehl[i].Beschreibung:=mainform.Submasterbank[Source].Befehl[i].Beschreibung;
    mainform.Submasterbank[Destination].Befehl[i].OnValue:=mainform.Submasterbank[Source].Befehl[i].OnValue;
    mainform.Submasterbank[Destination].Befehl[i].OffValue:=mainform.Submasterbank[Source].Befehl[i].OffValue;
    mainform.Submasterbank[Destination].Befehl[i].SwitchValue:=mainform.Submasterbank[Source].Befehl[i].SwitchValue;
    mainform.Submasterbank[Destination].Befehl[i].ScaleValue:=mainform.Submasterbank[Source].Befehl[i].ScaleValue;

    setlength(mainform.Submasterbank[Destination].Befehl[i].ArgInteger,length(mainform.Submasterbank[Source].Befehl[i].ArgInteger));
    setlength(mainform.Submasterbank[Destination].Befehl[i].ArgString,length(mainform.Submasterbank[Source].Befehl[i].ArgString));
    setlength(mainform.Submasterbank[Destination].Befehl[i].ArgGUID,length(mainform.Submasterbank[Source].Befehl[i].ArgGUID));
    for k:=0 to length(mainform.Submasterbank[Destination].Befehl[i].ArgInteger)-1 do
      mainform.Submasterbank[Destination].Befehl[i].ArgInteger[k]:=mainform.Submasterbank[Source].Befehl[i].ArgInteger[k];
    for k:=0 to length(mainform.Submasterbank[Destination].Befehl[i].ArgString)-1 do
      mainform.Submasterbank[Destination].Befehl[i].ArgString[k]:=mainform.Submasterbank[Source].Befehl[i].ArgString[k];
    for k:=0 to length(mainform.Submasterbank[Destination].Befehl[i].ArgGUID)-1 do
      mainform.Submasterbank[Destination].Befehl[i].ArgGUID[k]:=mainform.Submasterbank[Source].Befehl[i].ArgGUID[k];
  end;
end;

procedure Tsubmasterform.BankSelectChange(Sender: TObject);
begin
  CheckButtons;
end;

procedure Tsubmasterform.CheckButtons;
var
  i:integer;
  BtnsEnabled:boolean;
begin
  BtnsEnabled:= (length(mainform.Submasterbank)>0) and (BankSelect.Itemindex>-1);
  for i:=1 to 16 do
  begin
    TButton(FindComponent('Button'+inttostr(i))).Enabled:=BtnsEnabled;
    TButton(FindComponent('Setup'+inttostr(i))).Enabled:=BtnsEnabled;
  end;

  PngBitBtn2.enabled:=(BankSelect.ItemIndex>-1) and (BankSelect.Items.Count>0);
  PngBitBtn3.enabled:=(BankSelect.ItemIndex>-1) and (BankSelect.Items.Count>0);
end;

function Tsubmasterform.MyMessageDlg(const Msg: string; DlgType : TMsgDlgType;
                     Buttons : TMsgDlgButtons; Captions: array of string) : Integer;
var
  aMsgDlg : TForm;
  CaptionIndex,
  i : integer;
  dlgButton : TButton;  // uses stdctrls
begin
  // Dlg erzeugen
  aMsgDlg := CreateMessageDialog(Msg, DlgType, buttons);
  CaptionIndex := 0;
  // alle Objekte des Dialoges testen
  for i := 0 to aMsgDlg.ComponentCount - 1 do begin
    // wenn es ein Button ist, dann...
    if (aMsgDlg.Components[i] is TButton) then begin
      dlgButton := TButton(aMsgDlg.Components[i]);
      if CaptionIndex > High(Captions) then Break;
      // Beschriftung entsprechend Captions-array ändern
      dlgButton.Caption := Captions[CaptionIndex];
      Inc(CaptionIndex);
    end;
  end;
//  aMsgDlg.PopupParent := Self;
  Result := aMsgDlg.ShowModal;
end;

procedure Tsubmasterform.Timer1Timer(Sender: TObject);
var
  i:integer;
  device_name:string;
  rectangleheight:byte;
  levelvalue:string;
  R,G,B:byte;
begin
  if not redrawsubmaster then exit;
  redrawsubmaster:=false;

  _Buffer.Canvas.Brush.Color:=$00A6A6A6;
  _Buffer.Canvas.Pen.Style:=psClear;
  _Buffer.Canvas.FillRect(_Buffer.ClipRect);
  _Buffer.Canvas.Brush.Color:=clblack;

  if (BankSelect.Items.Count>0) and (BankSelect.ItemIndex>-1) then
  begin
  for i:=1 to maxfaders do
  begin
    device_name:='';

    if (BankSelect.ItemIndex<length(mainform.Submasterbank)) and (BankSelect.Itemindex>-1) then
    begin
      // Kanal liegt innerhalb des Geräts
      device_name:=mainform.Submasterbank[BankSelect.ItemIndex].SubmasterName[i];

      rectangleheight:=mainform.Submasterbank[BankSelect.ItemIndex].CurrentValue[i];

      // Kästchen zeichnen
      _Buffer.Canvas.Brush.Color:=$00A6A6A6;
      _Buffer.Canvas.Rectangle(abstand*(i-1)+5,14,abstand*i+5,35); // graues Kästchen
      _Buffer.Canvas.Brush.Color:=RGB2TColor(rectangleheight, rectangleheight, 0);
      _Buffer.Canvas.Rectangle(abstand*(i-1)+5,round(35-21*(rectangleheight/255)),abstand*i+5,35);

      // Schrift einstellen
      _Buffer.Canvas.Font.Name:='Arial';
      _Buffer.Canvas.Font.Size:=8;

      // Kanalwert zeichnen
      _Buffer.Canvas.Font.Style:=[fsBold];
      TColor2RGB(clYellow, r,g,b);
      if (g<127) and (r<225) and (rectangleheight>100) then
        _Buffer.Canvas.Font.Color:=clWhite
      else
        _Buffer.Canvas.Font.Color:=clBlack;
      levelvalue:=mainform.levelstr(mainform.Submasterbank[BankSelect.ItemIndex].CurrentValue[i]);

      _Buffer.Canvas.Brush.Style:=bsClear;
      if length(levelvalue)<2 then
        _Buffer.Canvas.TextOut(abstand*(i-1)+5+17, 17, levelvalue)
      else if length(levelvalue)<3 then
        _Buffer.Canvas.TextOut(abstand*(i-1)+5+14, 17, levelvalue)
      else if length(levelvalue)<4 then
        _Buffer.Canvas.TextOut(abstand*(i-1)+5+11, 17, levelvalue)
      else if length(levelvalue)<5 then
        _Buffer.Canvas.TextOut(abstand*(i-1)+5+8, 17, levelvalue)
      else if length(levelvalue)<6 then
        _Buffer.Canvas.TextOut(abstand*(i-1)+5+5, 17, levelvalue)
      else
        _Buffer.Canvas.TextOut(abstand*(i-1)+5+2, 17, levelvalue);
      _Buffer.Canvas.Brush.Style:=bsSolid;
      _Buffer.Canvas.Font.Color:=clBlack;
      _Buffer.CAnvas.Font.Style:=[];
      _Buffer.Canvas.Font.Size:=7;

      _Buffer.Canvas.Brush.Color:=$00A6A6A6;
      _Buffer.Canvas.Pen.Style:=psClear;
      _Buffer.Canvas.Rectangle(abstand*(i-1)+5,0,abstand*i+5,10);

      _Buffer.Canvas.Rectangle(abstand*(i-1)+5,0,abstand*(i)+5,10);
      _Buffer.Canvas.TextOut(abstand*(i-1)+5, 0, _('Fader ')+inttostr(i));

      _Buffer.Canvas.Draw(abstand*(i-1)+8,44,image1.Picture.Graphic);
      _Buffer.Canvas.Draw(abstand*(i-1)+8+9,44+round((187-25)*((255-mainform.Submasterbank[BankSelect.ItemIndex].CurrentValue[i])/255)),image3.Picture.Graphic);

      // Kanalname zeichnen
      // Text um 90° gedreht anzeigen
      _Buffer.Canvas.Font.Color:=$005D5D5D;
      SelectObject(_Buffer.Canvas.Handle, GedrehteSchrift);
      _Buffer.Canvas.TextOut(abstand*(i-1), _Buffer.Height-5, device_name); // Beschreibung
    end;
  end;
  end else
  begin
    for i:=1 to maxfaders do
    begin
      _Buffer.Canvas.Draw(abstand*(i-1)+8,44,image2.Picture.Graphic);
    end;
  end;

  _Buffer.Canvas.Pen.Style:=psSolid;

  BitBlt(PaintBox1.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Tsubmasterform.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mousex:=x;
  mousey:=y;
  mouseoverfader:=trunc((x/(maxfaders*abstand))*maxfaders)+1;

  if ((y>0) and (y<5)) or ((x>((mouseoverfader-1)*abstand)) and (x<(((mouseoverfader-1)*abstand)+10))) then
  begin
    mainform.Submasterbank[BankSelect.ItemIndex].SubmasterName[mouseoverfader]:=InputBox(_('Neue Submaster-Beschriftung'),_('Bitte geben Sie eine neue Bezeichnung für diesen Submaster ein:'),mainform.Submasterbank[BankSelect.ItemIndex].SubmasterName[mouseoverfader]);
  end;
end;

procedure Tsubmasterform.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  value:integer;
begin
  if (Shift=[ssLeft]) then
  begin
    if (BankSelect.ItemIndex>=length(mainform.Submasterbank)) or (BankSelect.ItemIndex<0) then exit;

    // Fader bewegen
    value:=y+3-54;
    if value<0 then value:=0;
    if value>167 then value:=167;
    value:=255-round(value/167*255);

    //ChangeSubmaster(mouseoverfader, value);
    FaderChanged[mouseoverfader-1]:=value;
  end;

  redrawsubmaster:=true;
end;

procedure Tsubmasterform.PaintBox1Paint(Sender: TObject);
begin
  redrawsubmaster:=true;
end;

procedure Tsubmasterform.ChangeSubmaster(SubmasterNr, Value: integer);
var
  j,k,m:integer;
  NotaDevice:boolean;
begin
  if (BankSelect.ItemIndex>-1) and (BankSelect.ItemIndex<length(mainform.Submasterbank)) and
    (SubmasterNr>-1) and (SubmasterNr<=length(mainform.Submasterbank[BankSelect.ItemIndex].CurrentValue)) then
  begin
    mainform.Submasterbank[BankSelect.ItemIndex].CurrentValue[SubmasterNr]:=value;

    if mainform.Submasterbank[BankSelect.ItemIndex].UseBefehl[SubmasterNr] then
    begin
      // Befehl ausführen
      mainform.StartBefehl(mainform.Submasterbank[BankSelect.ItemIndex].Befehl[SubmasterNr].ID,value);
    end else if mainform.Submasterbank[BankSelect.ItemIndex].UseScene[SubmasterNr] then
    begin
      // Szene ausführen
      mainform.StartScene(mainform.Submasterbank[BankSelect.ItemIndex].SubmasterScene[SubmasterNr], true, false, value, 0);
    end else
    begin
      // normalen Submaster ausführen
      NotaDevice:=true;

      for j:=0 to length(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr])-1 do
      begin
        for k:=0 to length(mainform.Devices)-1 do
        begin
          if IsEqualGUID(mainform.Devices[k].ID,mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ID) then
          begin
            NotaDevice:=false;

            for m:=0 to length(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ChanActive)-1 do
            begin
              if mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ChanActive[m] then
              begin
                Geraetesteuerung.set_channel(mainform.Devices[k].ID,mainform.Devices[k].kanaltyp[m],round(value*(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ChanValue[m]/255)),round(value*(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ChanValue[m]/255)),0,mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ChanDelay[m]);
              end;
            end;
            break;
          end;
        end;

        if NotaDevice then
        begin
          for m:=0 to length(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ChanActive)-1 do
          begin
            if mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ChanActive[m] then
              Geraetesteuerung.set_group(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ID,mainform.DeviceChannelNames[m],round(value*(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ChanValue[m]/255)),round(value*(mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ChanValue[m]/255)),0,mainform.Submasterbank[BankSelect.ItemIndex].Submasterdevices[SubmasterNr][j].ChanDelay[m]);
          end;
        end;
      end;
    end;
    redrawsubmaster:=true;
  end;
end;

procedure Tsubmasterform.SubmasterSendTimerTimer(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(FaderChanged)-1 do
  begin
    if FaderChanged[i]>-1 then
    begin
      ChangeSubmaster(i+1, FaderChanged[i]);
      FaderChanged[i]:=-1;
    end;
  end;
end;

end.
