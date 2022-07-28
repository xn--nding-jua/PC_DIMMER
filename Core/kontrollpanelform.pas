unit kontrollpanelform;

interface

uses
  // Delphi Units
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls,

  // Eigene Units
  insscene, presskey, Action, szenenverwaltung, bewegungsszeneneditor,
  editskript, editmidievent, midievent, messagesystem, 

  // Fremde Units
  JvExControls, JvComponent, JvColorBox, JvColorButton, Mask,
  JvExMask, JvSpin, JvZlibMultiple, MPlayer, Menus, Buttons, ImgList, Registry,
  Math, JvComponentBase, PngBitBtn, JvExButtons, JvButtons, JvInterpreter,
  gnugettext, TB2Item, TB2Dock, TB2Toolbar, pngimage, GR32, D7GesturesHeader;


const
  {$I GlobaleKonstanten.inc}

type
  TAct = record
    opt : array[1..chan] of string;
    ch_ready : array[1..chan] of boolean;
    start : array[1..chan] of TDateTime;
    wt : array[1..chan] of TDateTime;
  end;

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

  Tkontrollpanel = class(TForm)
    Panel1: TPanel;
    buttonname: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    buttonfarbe: TJvColorButton;
    zeilen: TJvSpinEdit;
    spalten: TJvSpinEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    temposlider: TScrollBar;
    repeatskript: TCheckBox;
    ComboBox1: TComboBox;
    Label7: TLabel;
    StatusBar1: TStatusBar;
    Edit1: TEdit;
    Compress: TJvZlibMultiple;
    CheckBox1: TCheckBox;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    HotKey1: THotKey;
    CheckFileExists: TTimer;
    sync_btn: TButton;
    beattime_blinker: TTimer;
    Shape1: TShape;
    ButtonPopup: TPopupMenu;
    Kopieren1: TMenuItem;
    Einfgen1: TMenuItem;
    Lschen1: TMenuItem;
    Ausschneiden1: TMenuItem;
    Bearbeiten1: TMenuItem;
    N4: TMenuItem;
    ndern1: TMenuItem;
    N5: TMenuItem;
    Bildndern1: TMenuItem;
    Stop1: TMenuItem;
    Bildlschen1: TMenuItem;
    szenebearbeiten: TPngBitBtn;
    stop: TPngBitBtn;
    buttonglyphbtn: TPngBitBtn;
    CheckForActive: TTimer;
    ScriptInterpreter: TJvInterpreterProgram;
    Farbendern1: TMenuItem;
    ColorDialog1: TColorDialog;
    btnwidth: TJvSpinEdit;
    btnheight: TJvSpinEdit;
    Label2: TLabel;
    Label6: TLabel;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    Datei1: TTBSubmenuItem;
    Neu1: TTBItem;
    ffnen1: TTBItem;
    Speichern1: TTBItem;
    N2: TTBSeparatorItem;
    Beenden1: TTBItem;
    Ansicht1: TTBSubmenuItem;
    Normal1: TTBItem;
    IndenVordergrund1: TTBItem;
    N1: TTBSeparatorItem;
    MenanzeigenDoppelklickaufStatusleiste1: TTBItem;
    Einstellungen: TTBSubmenuItem;
    MIDISetup1: TTBItem;
    hauptprogrammeffekteaus: TTBItem;
    N3: TTBSeparatorItem;
    ooltipsanzeigen1: TTBItem;
    RefreshTimer: TTimer;
    ListBox: TListBox;
    PngBitBtn3: TPngBitBtn;
    showiconsbtn: TTBItem;
    buttonstyledark: TTBItem;
    PaintBox1: TPaintBox;
    TestAccessLevelTimer: TTimer;
    VerschiebeReihenachoben1: TMenuItem;
    N7: TMenuItem;
    VerschiebeReihenachunten1: TMenuItem;
    GanzeZeilelschen1: TMenuItem;
    Zeileeinfgen1: TMenuItem;
    ShiftTasteMausButtonverschieben1: TMenuItem;
    StrgTasteMausZeileverschieben1: TMenuItem;
    N6: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure buttonfarbeChange(Sender: TObject);
    procedure saveClick(Sender: TObject);
    procedure openClick(Sender: TObject);
    procedure szenebearbeitenClick(Sender: TObject);
    procedure buttonnameEnter(Sender: TObject);
    procedure buttonnameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RunSkript(Sender:TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure stopClick(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure newClick(Sender: TObject);
    procedure StatusBar1DblClick(Sender: TObject);
    procedure CheckBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox1Exit(Sender: TObject);
    procedure HotKey1Change(Sender: TObject);

    procedure CheckFileExistsTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sync_btnClick(Sender: TObject);
    procedure beattime_blinkerTimer(Sender: TObject);
    procedure CheckBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure IndenVordergrund1Click(Sender: TObject);
    procedure Normal1Click(Sender: TObject);
    procedure hauptprogrammeffekteausClick(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
		procedure MSGNew;
		procedure MSGOpen(Sender: TObject);
		procedure MSGSave(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Einfgen1Click(Sender: TObject);
    procedure Kopieren1Click(Sender: TObject);
    procedure Lschen1Click(Sender: TObject);
    procedure ooltipsanzeigen1Click(Sender: TObject);
    procedure Bearbeiten1Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure CheckForActiveTimer(Sender: TObject);
    procedure ScriptInterpreterGetValue(Sender: TObject;
      Identifier: String; var Value: Variant; Args: TJvInterpreterArgs;
      var Done: Boolean);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Farbendern1Click(Sender: TObject);
    procedure temposliderScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure btnwidthChange(Sender: TObject);
    procedure PngBitBtn2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PngBitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure RefreshTimerTimer(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure zeilenChange(Sender: TObject);
    procedure spaltenChange(Sender: TObject);
    procedure PngBitBtn3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Bildndern1Click(Sender: TObject);
    procedure Bildlschen1Click(Sender: TObject);
    procedure buttonstyledarkClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure TestAccessLevelTimerTimer(Sender: TObject);
    procedure VerschiebeReihenachoben1Click(Sender: TObject);
    procedure VerschiebeReihenachunten1Click(Sender: TObject);
    procedure GanzeZeilelschen1Click(Sender: TObject);
    procedure Zeileeinfgen1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    buttonstyle:byte;
    cut:boolean;
    Counter:byte;

    _Buffer:TBitmap32;
    xoffset, yoffset:integer;
    BtnDown:TPoint;
    SourceBtn:TPoint;
    MouseDown,OldOffset:TPoint;
    LastColRows:TPoint;
    Extrahighlight:integer;

    //f_ptFirst:TPoint;
    //f_dwArguments:Int64;     //saved T/G dw arguments
    LastTouchEvent:integer;
    MyTouchPoint:TPoint;
    ssTouch:boolean;

    function UseGradient(Farbe: TColor; Direction: byte):TColor;
//    procedure DrawGradientV(Canvas: TCanvas; Color1, Color2: TColor; Rect: TRect);
    procedure DrawGradientH(Canvas: TCanvas; Color1, Color2: TColor; Rect: TRect);
    procedure StartTouchEvent(X, Y: integer);
    procedure UpdateTouchEvent(Event, X, Y: integer);
    procedure EndTouchEvent(X, Y: integer);
    procedure CopyButton(SourceX, SourceY, DestinationX, DestinationY: integer);
    procedure FlipButton(SourceX, SourceY, DestinationX, DestinationY: integer);
    procedure FlipLine(SourceY, DestinationY: integer);
    procedure ResetButton(X, Y:integer);
    procedure MoveLine(Source, Destination:integer);
    procedure DeleteLine(Y:integer);
  protected
    procedure WMTouch( var Msg: TMessage);                 message WM_TOUCH;
    procedure WMGestureNotify( var Msg: TWMGestureNotify); message WM_GESTURENOTIFY;
    procedure WMGesture( var Msg: TMessage);               message WM_GESTURE;
    procedure WMTabletFlick( var Msg: TMessage);           message WM_TABLET_FLICK;
  public
    { Public-Deklarationen }
    SelectedBtn:TPoint;
    OverBtn:TPoint;

    channelvalue_temp:array[1..chan] of integer;
    buttonwidth,buttonheight:integer;
    knopf:TButton;
    FileStream:TFileStream;
    closing,keypressed,waitkey:boolean;
    shutdown:boolean;
    inprogram: array[1..chan] of boolean;
    actualfadevalue: array[1..chan] of string;
    beat_starttime,beat_endtime: TTimeStamp;
    beat_syncFirstclick:boolean;
    flashingkey:Word;
    flashingshift:TShiftState;
    skriptisrunning:boolean;
    ScriptInterpreterArgs:TJvInterpreterArgs;
    ScriptInterpreterCallingCodeSceneID:TGUID;
    procedure OpenFile(filename: string);
    procedure StopButton(Col, Row:integer);
    procedure CollectButtonInfo;
    procedure RedrawPanel;
    procedure RedrawMainformPanel;
    function IsButtonActive(X, Y:integer):boolean;
  end;

procedure LockWindow(const Handle: HWND);
procedure UnLockWindow(const Handle: HWND);

var
  kontrollpanel: Tkontrollpanel;

implementation

uses pcdimmer, effektsequenzerfrm, geraetesteuerungfrm, codeeditorfrm,
  beatfrm, picturechangefrm;

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

procedure Tkontrollpanel.FormShow(Sender: TObject);
var
	LReg:TRegistry;
begin
	shutdown:=false;
	closing:=false;
  keypressed:=false;
  waitkey:=false;

//  kontrollpanel.Width:=mainform.kontrollpanelrecord.formwidth;
//  kontrollpanel.Height:=mainform.kontrollpanelrecord.formheight;
  zeilen.AsInteger:=mainform.kontrollpanelrecord.zeilenanzahl+1;
  spalten.AsInteger:=mainform.kontrollpanelrecord.spaltenanzahl+1;

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
  			LReg.WriteBool('Showing Kontrollpanel',true);

        if not LReg.KeyExists('Kontrollpanel') then
	        LReg.CreateKey('Kontrollpanel');
	      if LReg.OpenKey('Kontrollpanel',true) then
	      begin
	        if not LReg.ValueExists('Show setup') then
	          LReg.WriteBool('Show setup',true);
         	panel1.Visible:=LReg.ReadBool('Show setup');

          if not mainform.UserAccessGranted(1, false) then panel1.Visible:=false;

         	MenanzeigenDoppelklickaufStatusleiste1.checked:=LReg.ReadBool('Show setup');
	        if not LReg.ValueExists('Deactivate Mainprogrameffects on click') then
	          LReg.WriteBool('Deactivate Mainprogrameffects on click',false);
         	hauptprogrammeffekteaus.checked:=LReg.ReadBool('Deactivate Mainprogrameffects on click');
	        if not LReg.ValueExists('Enable Tooltips') then
	          LReg.WriteBool('Enable Tooltips',false);
         	ooltipsanzeigen1.checked:=LReg.ReadBool('Enable Tooltips');
	        if not LReg.ValueExists('Buttonstyle') then
	          LReg.WriteInteger('Buttonstyle',0);
         	buttonstyle:=LReg.ReadInteger('Buttonstyle');
          buttonstyledark.checked:=(buttonstyle=0);
	        if not LReg.ValueExists('Show Pictures') then
	          LReg.WriteBool('Show Pictures',true);
         	showiconsbtn.checked:=LReg.ReadBool('Show Pictures');

          if LReg.ValueExists('Width') then
            kontrollpanel.ClientWidth:=LReg.ReadInteger('Width')
          else
            kontrollpanel.ClientWidth:=780;
          if LReg.ValueExists('Heigth') then
            kontrollpanel.ClientHeight:=LReg.ReadInteger('Heigth')
          else
            kontrollpanel.ClientHeight:=225;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+kontrollpanel.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              kontrollpanel.Left:=LReg.ReadInteger('PosX')
            else
              kontrollpanel.Left:=0;
          end else
            kontrollpanel.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+kontrollpanel.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              kontrollpanel.Top:=LReg.ReadInteger('PosY')
            else
              kontrollpanel.Top:=0;
          end else
            kontrollpanel.Top:=0;

          if LReg.ValueExists('Button Width') then
          begin
            buttonwidth:=LReg.ReadInteger('Button Width');
            btnwidth.Value:=buttonwidth;
          end;
          if LReg.ValueExists('Button Height') then
          begin
            buttonheight:=LReg.ReadInteger('Button Height');
            btnheight.Value:=buttonheight;
          end;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  CheckForActive.Enabled:=true;
  CheckFileExists.Enabled:=true;
  beattime_blinker.Enabled:=true;

  CollectButtonInfo;
  RefreshTimer.enabled:=true;

  TestAccessLevelTimer.enabled:=true;
end;

procedure Tkontrollpanel.FormResize(Sender: TObject);
begin
  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;
end;

procedure Tkontrollpanel.buttonfarbeChange(Sender: TObject);
begin
	mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=buttonfarbe.Color;
end;

procedure Tkontrollpanel.saveClick(Sender: TObject);
var
  i,j,Count:integer;
begin
  mainform.kontrollpanelrecord.formwidth:=kontrollpanel.Width;
  mainform.kontrollpanelrecord.formheight:=kontrollpanel.Height;
	mainform.kontrollpanelrecord.zeilenanzahl:=zeilen.AsInteger-1;
  mainform.kontrollpanelrecord.spaltenanzahl:=spalten.AsInteger-1;

  savedialog1.DefaultExt:='*.pcdcpnl';
  savedialog1.Filter:=_('PC_DIMMER Kontrollpaneldatei (*.pcdcpnl)|*.pcdcpnl|Alle Dateien|*.*');
  savedialog1.Title:=_('PC_DIMMER Kontrollpanel-Datei öffnen');

	if savedialog1.Execute then
  begin
	  If not DirectoryExists(mainform.userdirectory+'ProjectTemp') then
	   	CreateDir(mainform.userdirectory+'ProjectTemp');
    If not DirectoryExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel') then
    	CreateDir(mainform.userdirectory+'ProjectTemp\Kontrollpanel');
    try
	    FileStream:=TFileStream.Create(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Kontrollpanel',fmCreate);
	    Filestream.WriteBuffer(mainform.kontrollpanelrecord,sizeof(mainform.kontrollpanelrecord));

      Count:=round(kontrollpanel.zeilen.value);
      Filestream.WriteBuffer(Count,sizeof(Count));
      Count:=round(kontrollpanel.spalten.value);
      Filestream.WriteBuffer(Count,sizeof(Count));
      for i:=0 to round(kontrollpanel.zeilen.value)-1 do
      for j:=0 to round(kontrollpanel.spalten.value)-1 do
      begin
        Filestream.WriteBuffer(mainform.kontrollpanelbuttons[i][j].ID,sizeof(mainform.kontrollpanelbuttons[i][j].ID));
        Filestream.WriteBuffer(mainform.kontrollpanelbuttons[i][j].Name,sizeof(mainform.kontrollpanelbuttons[i][j].Name));
        Filestream.WriteBuffer(mainform.kontrollpanelbuttons[i][j].Color,sizeof(mainform.kontrollpanelbuttons[i][j].Color));
        Filestream.WriteBuffer(mainform.kontrollpanelbuttons[i][j].Typ,sizeof(mainform.kontrollpanelbuttons[i][j].Typ));
        Filestream.WriteBuffer(mainform.kontrollpanelbuttons[i][j].Shortcut,sizeof(mainform.kontrollpanelbuttons[i][j].Shortcut));
        Filestream.WriteBuffer(mainform.kontrollpanelbuttons[i][j].Picture,sizeof(mainform.kontrollpanelbuttons[i][j].Picture));
      end;

	    FileStream.Free;
	    Compress.CompressDirectory(mainform.userdirectory+'ProjectTemp\Kontrollpanel\',false,savedialog1.FileName);
    except
    	ShowMessage(_('Fehler beim Zugriff auf die Datei "')+mainform.userdirectory+'ProjectTemp\Kontrollpanel\Kontrollpanel'+'"');
    end;
  end;
end;

procedure Tkontrollpanel.openClick(Sender: TObject);
begin
  opendialog1.DefaultExt:='*.pcdcpnl';
  opendialog1.Filter:=_('PC_DIMMER Kontrollpaneldatei (*.pcdcpnl)|*.pcdcpnl|Alle Dateien|*.*');
  opendialog1.Title:=_('PC_DIMMER Kontrollpanel-Datei öffnen');
	if opendialog1.Execute then
  begin
    OpenFile(opendialog1.filename);
    kontrollpanel.Caption:=_('Kontrollpanel')+' - '+ExtractFileName(opendialog1.filename);
  end;
end;

procedure Tkontrollpanel.szenebearbeitenClick(Sender: TObject);
begin
  case mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Typ of
    0:  // Leer
    begin
    end;
    1,4:  // Szene
    begin
      mainform.EditScene(mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].ID);
    end;
    2:  // Skript
    begin
      // SKRIPT BEARBEITEN
      if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1)+'.pcdscrp') then
        listbox.Items.LoadFromFile(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1)+'.pcdscrp');
      if listbox.Items.Count>0 then
        if listbox.items[0]<>inttostr(listbox.items.count-1) then
          listbox.items.clear
        else
          listbox.items.delete(0);
    //  if (copy(listbox.items[listbox.Items.count-2],0,1)='L') and (listbox.items[listbox.Items.Count-1]='Schalte Kanal:   1 to -1%') then listbox.Items.Delete(listbox.Items.Count-1);
      editskriptfrm.ListBox.Items:=listbox.items;
      editskriptfrm.aktuellezeile:=SelectedBtn.Y;
      editskriptfrm.aktuellespalte:=SelectedBtn.X;
      editskriptfrm.showmodal;
    end;
    3,6:
    begin
      effektsequenzer.show;
    end;
    5:  // Flashskript
    begin
      // SKRIPT BEARBEITEN
      if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1)+'.pcdscrp') then
        listbox.Items.LoadFromFile(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1)+'.pcdscrp');
      if listbox.Items.Count>0 then
        if listbox.items[0]<>inttostr(listbox.items.count-1) then
          listbox.items.clear
        else
          listbox.items.delete(0);
    //  if (copy(listbox.items[listbox.Items.count-2],0,1)='L') and (listbox.items[listbox.Items.Count-1]='Schalte Kanal:   1 to -1%') then listbox.Items.Delete(listbox.Items.Count-1);
      editskriptfrm.ListBox.Items:=listbox.items;
      editskriptfrm.aktuellezeile:=SelectedBtn.Y;
      editskriptfrm.aktuellespalte:=SelectedBtn.X;
      editskriptfrm.showmodal;
    end;
    7:
    begin
      Listbox.items.Clear;
      if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1)+'.pas') then
        listbox.Items.LoadFromFile(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1)+'.pas');
      if listbox.Items.Count=0 then
      begin
        codeeditorform.Memo1.Lines.Clear;
        codeeditorform.Memo1.Lines.Add('unit ButtonCode;');
        codeeditorform.Memo1.Lines.Add('');
        codeeditorform.Memo1.Lines.Add('interface');
        codeeditorform.Memo1.Lines.Add('');
        codeeditorform.Memo1.Lines.Add('procedure ButtonMouseDown;');
        codeeditorform.Memo1.Lines.Add('procedure ButtonMouseUp;');
        codeeditorform.Memo1.Lines.Add('');
        codeeditorform.Memo1.Lines.Add('implementation');
        codeeditorform.Memo1.Lines.Add('');
        codeeditorform.Memo1.Lines.Add('procedure ButtonMouseDown;');
        codeeditorform.Memo1.Lines.Add('begin');
        codeeditorform.Memo1.Lines.Add('end;');
        codeeditorform.Memo1.Lines.Add('');
        codeeditorform.Memo1.Lines.Add('procedure ButtonMouseUp;');
        codeeditorform.Memo1.Lines.Add('begin');
        codeeditorform.Memo1.Lines.Add('end;');
        codeeditorform.Memo1.Lines.Add('');
        codeeditorform.Memo1.Lines.Add('end.');
        codeeditorform.Memo1.Lines.Add('');
      end else
      begin
        codeeditorform.Memo1.Lines:=listbox.Items;
      end;

      codeeditorform.showmodal;

      If not DirectoryExists(mainform.userdirectory+'ProjectTemp') then
        CreateDir(mainform.userdirectory+'ProjectTemp');
      if not DirectoryExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel') then
        CreateDir(mainform.userdirectory+'ProjectTemp\Kontrollpanel');
      listbox.Items.Clear;
      listbox.Items:=codeeditorform.Memo1.Lines;
      listbox.Items.SaveToFile(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1)+'.pas');
    end;
  end;
	CheckFileExistsTimer(nil);
  CollectButtonInfo;
end;

procedure Tkontrollpanel.buttonnameEnter(Sender: TObject);
begin
	if buttonname.Text='Button '+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1) then
  	buttonname.Text:='';
end;

procedure Tkontrollpanel.buttonnameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if not shutdown then
	begin
  	mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Name:=buttonname.Text;
		if buttonname.Text=_('Rot') then mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=clRed;
		if buttonname.Text=_('Gelb') then mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=clYellow;
		if buttonname.Text=_('Grün') then mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=clLime;
		if buttonname.Text=_('Schwarz') then mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=clBlack;
		if buttonname.Text=_('Weiß') then mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=clWhite;
		if buttonname.Text=_('Grau') then mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=clGray;
		if buttonname.Text=_('Rosa') then mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=clFuchsia;
		if buttonname.Text=_('Blau') then mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=clBlue;
	end;
end;

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

procedure Tkontrollpanel.RunSkript(Sender: TObject);
var
  h,m,s,msec,c,vs,ve,i,j,k,animationszeit:integer;
  nsteps,stp:integer;
  timestep,t,fadezeit:longint;
  wt,start,tijd:TDateTime;
  opt,st,st1,st2:string;
  itemidx:integer;
  ready,waitkey:boolean;
  act: TAct;
  beg,n:integer;
  list: array[1..chan] of TStringList;
begin
//try
skriptisrunning:=true;
if listbox.Items.count>0 then
begin
  if (copy(listbox.Items[listbox.Items.Count-1],0,1)='L') and (listbox.Items.Count-1>0) then listbox.Items.Add(_('Schalte Kanal:   1 to -1%'));

  for j:=1 to mainform.lastchan do
  	list[j]:=TStringList.Create;  // Listen generieren

  closing:=false;
  keypressed:=false;
  waitkey:=false;

// letzten Eintrag auf Sync-Option überprüfen
  if listbox.items.count<>0 then
  repeat
    st1:=listbox.items[listbox.items.count-1];
    if copy(st1,0,1)='L' then listbox.items.delete(listbox.items.count-1);
  until (copy(st1,0,1)<>'L') or (listbox.items.count=0) ;
// ersten Eintrag auf Sync-Option überprüfen
  if listbox.items.count<>0 then
  repeat
    st1:=listbox.items[0];
    if (copy(st1,0,1)='L') then listbox.items.delete(0);
  until (copy(st1,0,1)<>'L') or (listbox.items.count=0) ;

if listbox.items.count<>0 then
repeat
  beg:=0;
  n:=0;

// große repeat Schleife beginnen
  repeat
    beg:=beg+n+1;
    n:=0;
    repeat
      st1:=listbox.items[beg-1+n];
      if (copy(st1,0,1)<>'L') then inc(n);
    until (copy(st1,0,1)='L') or ((beg+n-1)=listbox.items.count);
    if (copy(st1,0,1)='L') and (length(st1)>30) then // falls "auf Tastendruck warten"
      waitkey:=true;

  for i:=1 to mainform.lastchan do
  	inprogram[i]:=false;

  for i:=beg to (beg+n-1) do // Welche Kanäle sind im Programm
    begin
      st:=listbox.items[i-1];
      opt:=copy(st,1,1);
      while pos(',',st)<>0 do
        begin
          c:=strtoint(copy(st,pos(',',st)-4,4));
          inprogram[c]:=true;
          if c<10 then delete(st,pos(inttostr(c),st),2)
          else if c<100 then delete(st,pos(inttostr(c),st),3)
          else if c<1000 then delete(st,pos(inttostr(c),st),4)
          else delete(st,pos(inttostr(c),st),5);
        end;
      if opt='W' then
        begin
          if listbox.Count>0 then
          begin
            c:=strtoint(copy(st,pos('for',st)-5,4));
            inprogram[c]:=true;
          end;
        end;
      if opt='S' then
        begin
//ShowMessage('S: '+copy(st,pos('to',st)-5,4));
          c:=strtoint(copy(st,pos('to',st)-5,4));
          inprogram[c]:=true;
        end;
      if opt='F' then
        begin
//ShowMessage('F: '+copy(st,pos('from',st)-5,4));
          c:=strtoint(copy(st,pos('from',st)-5,4));
          inprogram[c]:=true;
        end;
    end;

//  UpdateLevels;

  for i:=beg to (beg+n-1) do // Listen für alle Kanäle erstellen
    begin
      st:=listbox.items[i-1];
      delete(st,pos(':',st),1); // das brauchen wir später für die Zeit
      opt:=copy(st,1,1);
      while pos(',',st)<>0 do
        begin
          c:=strtoint(copy(st,pos(',',st)-4,4));
          if c<10 then delete(st,pos(inttostr(c),st),2)
          else if c<100 then delete(st,pos(inttostr(c),st),3)
          else if c<1000 then delete(st,pos(inttostr(c),st),4)
          else delete(st,pos(inttostr(c),st),5);

          if opt='F' then
          begin
            st1:=_('Schalte Kanal:   ') + inttostr(c) + ' to ' +
                 inttostr(strtoint(copy(st,pos('from',st)+5,pos('%',st)-(pos('from',st)+5)))) + '%';
            for j:=1 to mainform.lastchan do (if (c=j) then list[j].add(st1));
          end;
          for j:=1 to mainform.lastchan do (if (c=j) then list[j].add(st));
        end;
      if opt='W' then
        begin
          c:=strtoint(copy(st,pos('for',st)-5,4));
          for j:=1 to mainform.lastchan do (if (c=j) then list[j].add(st));
        end;
      if opt='S' then
        begin
          c:=strtoint(copy(st,pos('to',st)-5,4));
          for j:=1 to mainform.lastchan do (if (c=j) then list[j].add(st));
        end;
      if opt='F' then
        begin
          c:=strtoint(copy(st,pos('from',st)-5,4));
          st1:=_('Schalte Kanal:   ') + inttostr(c) + ' to ' +
               inttostr(strtoint(copy(st,pos('from',st)+5,pos('%',st)-(pos('from',st)+5)))) + '%';
          for j:=1 to mainform.lastchan do (if (c=j) then list[j].add(st1));
          for j:=1 to mainform.lastchan do (if (c=j) then list[j].add(st));
        end;
    end;
  for i:=1 to mainform.lastchan do
    act.ch_ready[i]:=true; // Alle Kanäle bereit
  ready:=false;

  while not ready and not closing do
    begin
      // alle aktuellen Fader-Werte in Array eintragen (für Eingabe von -1 als Startvalue)
//	  for i:=1 to lastchan do
//      actualfadevalues[i]:=inttostr((maxres-data.ch[i])*100 div maxres)+'%';

      tijd:=time;
      for i:=1 to mainform.lastchan do //Prüfen, ob "Warte-" oder "Fade-" Aktion fertig sind
        if not act.ch_ready[i] then act.ch_ready[i]:=(tijd-act.start[i])>=act.wt[i];
      ready:=true; // Prüfen, ob Script abgearbeitet wurde
      for j:=1 to mainform.lastchan do (if ((list[j].count<>0) or not (act.ch_ready[j])) then ready:=false else inprogram[j]:=false);

      tijd:=time;
      for i:=1 to mainform.lastchan do
       if act.ch_ready[i] and inprogram[i] then
        begin
		  		actualfadevalue[i]:=inttostr((mainform.channel_value[i])*100 div 255)+'%';
          for j:=1 to mainform.lastchan do (if ((i=j) and (list[j].count<>0)) then st:=list[j][0]);
          opt:=copy(st,1,1);
          if opt='W' then
            begin
              h:=strtoint(copy(st,pos(':',st)-2,2));
              m:=strtoint(copy(st,pos(':',st)+1,2));
              s:=strtoint(copy(st,pos('.',st)-2,2));
              msec:=strtoint(copy(st,pos('.',st)+1,3));
              if ((h=0) and (m=0) and (s=0) and (msec=0)) then
              begin
              	h:=temposlider.Position div 3600000;
                m:=(temposlider.Position mod 3600000) div 60000;
                s:=((temposlider.Position mod 3600000) mod 60000) div 1000;
                msec:=(((temposlider.Position mod 3600000) mod 60000) mod 1000);
              end;
              act.opt[i]:=opt;
              act.ch_ready[i]:=false;
              act.wt[i]:=encodetime(h,m,s,msec);
              act.start[i]:=tijd;
            end;
          if opt='S' then
            begin
              vs:=strtoint(copy(st,pos('to',st)+3,pos('%',st)-(pos('to',st)+3)));
              if vs=-1 then   // wenn Startwert = -1, dann soll aktueller Wert eingesetzt werden
              begin
                st2:=actualfadevalue[i];
                vs:=strtoint(copy(st2,1,pos('%',st2)-1));
              end;
              vs:=round((vs*255)/100);
//              vs:=255-vs;
              mainform.Senddata(i,255-vs,255-vs,0);
            end;
          if opt='F' then
            begin
              vs:=strtoint(copy(st,pos('from',st)+5,pos('%',st)-(pos('from',st)+5)));
              if vs=-1 then   // wenn Startwert = -1, dann soll aktueller Wert eingesetzt werden
              begin
                st2:=actualfadevalue[i];
                vs:=strtoint(copy(st2,1,pos('%',st2)-1));
              end;
              vs:=round((vs*255)/100);
//              vs:=255-vs;
              ve:=strtoint(copy(st,pos('to',st)+3,pos('% in',st)-(pos('to',st)+3)));
              if ve=-1 then   // wenn Endwert = -1, dann soll aktueller Wert eingesetzt werden
              begin
                st2:=actualfadevalue[i];
                ve:=strtoint(copy(st2,1,pos('%',st2)-1));
              end;
              ve:=round((ve*255)/100);
//              ve:=255-ve;

              h:=strtoint(copy(st,pos(':',st)-2,2));
              m:=strtoint(copy(st,pos(':',st)+1,2));
              s:=strtoint(copy(st,pos('.',st)-2,2));
              msec:=strtoint(copy(st,pos('.',st)+1,3));

              if ((h=0) and (m=0) and (s=0) and (msec=0)) then
              begin
              	h:=temposlider.Position div 3600000;
                m:=(temposlider.Position mod 3600000) div 60000;
                s:=((temposlider.Position mod 3600000) mod 60000) div 1000;
                msec:=(((temposlider.Position mod 3600000) mod 60000) mod 1000);
              end;
              
              stp:=0;
              t:=(h*3600)+(m*60)+s;
              t:=t*100; // Umwandeln in 10ms
              t:=t+(msec div 10);
              fadezeit:=(((h*3600)+(m*60)+s)*1000)+msec;
              nsteps:=abs(vs-ve);

              mainform.Senddata(i,255-vs,255-ve,fadezeit);

              if (nsteps<>0) and (t<>0) then
                begin
                  repeat
                    inc(stp);
                    timestep:=t*stp;
                    timestep:=round(timestep/nsteps);
                  until (abs(((t-((timestep*nsteps)/stp))*100)/t) <= 15) or (stp>=4);
                end
              else
                begin
                  timestep:=0;
                  inc(stp);
                end;

              t:=(timestep*nsteps) div stp;
              h:=t div 360000; t:=t mod 360000;
              m:=t div 6000; t:=t mod 6000;
              s:=t div 100; t:=t mod 100;
              act.opt[i]:=opt;
              act.ch_ready[i]:=false;
              act.wt[i]:=encodetime(h,m,s,t*10);
              act.start[i]:=tijd;
            end;
          for j:=1 to mainform.lastchan do (if (i=j) then (list[j].Delete(0))); // aktuelles Kommando löschen
        end;
      application.processmessages;
      sleep(1);
    end;

    if waitkey then
    begin
      if presskeyfrm=nil then
       presskeyfrm:=Tpresskeyfrm.create(presskeyfrm);

      presskeyfrm.ShowModal;
      while presskeyfrm.Showing and not closing do
        begin
          application.processmessages;
        end;
      keypressed:=false;
      waitkey:=false;
    end;
  until ((beg+n-1)=listbox.items.count) or closing;
  until (repeatskript.checked=false) or closing;

  for j:=1 to mainform.lastchan do (list[j].Free); // Liste löschen

end;
skriptisrunning:=false;
end;

procedure Tkontrollpanel.ComboBox1Select(Sender: TObject);
var
  SzenenData:PTreeData;
begin
  case combobox1.ItemIndex of
    0:  //Leer
    begin
			if messagedlg(_('Durch setzen des Buttontyps auf "<Leer>" werden gespeicherte Szenenreferenzen und eventuell vorhandene Skriptdateien gelöscht. Fortfahren?'),mtConfirmation,
			  [mbYes,mbNo],0)=mrNo then exit;
      mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].ID:=StringToGuid('{00000000-0000-0000-0000-000000000000}');
      mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Name:='Button '+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1);
      mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].TypName:=_('Leer');
      mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=clWhite;
      mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Picture:='';
      mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Typ:=0;
      mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Time:='';
      mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Shortcut:=0;
//      mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Picture.Free;
      mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Active:=false;
    end;

    1,4:  // Szene
    begin
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionselection:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].ID;
      if (szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal=mrOK) then
      begin
        if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
        SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

        mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].ID:=SzenenData^.ID;
        mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Name:=mainform.GetSceneInfo2(SzenenData^.ID,'name');
      end;
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
    end;
    2:  // Skript
    begin
    end;
    3,6:  // Effekt
    begin
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Effektmodus:=true;
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Caption:=_('Effektverwaltung');
      setlength(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionen,1);
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionen[0]:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].ID;
      if (szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal=mrOK) then
      begin
        if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
        SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

        mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].ID:=SzenenData^.ID;
        szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Effektmodus:=false;

        mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Name:=mainform.GetSceneInfo2(SzenenData^.ID,'name');
      end;

      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
    end;
    5:  // Flashskript
    begin
    end;
    7:
    begin
    end;
  end;
	mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Typ:=combobox1.ItemIndex;

  CollectButtonInfo;
	CheckFileExistsTimer(nil);
end;

procedure Tkontrollpanel.stopClick(Sender: TObject);
begin
  StopButton(SelectedBtn.X,SelectedBtn.Y);
//	stop.Enabled:=false;
end;

procedure Tkontrollpanel.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return then
	try
    beatform.UpdateBPM(strtoint(edit1.text));
  except
  	edit1.Text:='60';
  end;
end;

procedure Tkontrollpanel.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i:integer;
	LReg:TRegistry;
begin
  RefreshTimer.enabled:=(mainform.PageControl1.ActivePageIndex=2) and (mainform.panel1.Visible);

  shutdown:=true;
  for i:=1 to mainform.lastchan do
		inprogram[i]:=false;
  waitkey:=false;
  closing:=true;
  waitkey:=false;

  mainform.kontrollpanelrecord.formwidth:=kontrollpanel.Width;
  mainform.kontrollpanelrecord.formheight:=kontrollpanel.Height;
	mainform.kontrollpanelrecord.zeilenanzahl:=zeilen.AsInteger-1;
  mainform.kontrollpanelrecord.spaltenanzahl:=spalten.AsInteger-1;

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
        if not LReg.KeyExists('Kontrollpanel') then
	        LReg.CreateKey('Kontrollpanel');
	      if LReg.OpenKey('Kontrollpanel',true) then
	      begin
	        LReg.WriteBool('Show setup',MenanzeigenDoppelklickaufStatusleiste1.Checked);
          LReg.WriteBool('Deactivate Mainprogrameffects on click',hauptprogrammeffekteaus.checked);
          LReg.WriteBool('Enable Tooltips',ooltipsanzeigen1.checked);
          LReg.WriteInteger('PosX',kontrollpanel.Left);
          LReg.WriteInteger('PosY',kontrollpanel.Top);
          LReg.WriteInteger('Buttonstyle',buttonstyle);
          LReg.WriteInteger('Button Width',buttonwidth);
          LReg.WriteInteger('Button Height',buttonheight);
         	LReg.WriteBool('Show Pictures',showiconsbtn.checked);
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tkontrollpanel.newClick(Sender: TObject);
begin
if messagedlg(_('Möchten Sie das Kontrollpanelpanel wirklich zurücksetzen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
	begin
		MSGNew;
	end;
end;

procedure Tkontrollpanel.StatusBar1DblClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if panel1.Visible then
  begin
	  panel1.Visible:=false;
	  kontrollpanel.Height:=kontrollpanel.Height-panel1.Height;
    kontrollpanel.Top:=kontrollpanel.Top+panel1.Height;
    MenanzeigenDoppelklickaufStatusleiste1.Checked:=false;
    mainform.kontrollpanelrecord.NoOptions:=true;
  end else
  begin
    kontrollpanel.Top:=kontrollpanel.Top-panel1.Height;
	  panel1.Visible:=true;
	  kontrollpanel.Height:=kontrollpanel.Height+panel1.Height;
    MenanzeigenDoppelklickaufStatusleiste1.Checked:=true;
    mainform.kontrollpanelrecord.NoOptions:=false;
  end;

  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;
end;

procedure Tkontrollpanel.CheckBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
	i,j:integer;
  MyKey:Word;
  MyShift:TShiftState;
begin
  if (flashingkey<>key) and (flashingshift<>Shift) then
	for i:=0 to zeilen.AsInteger-1 do
  begin
  	for j:=0 to spalten.AsInteger-1 do
    begin
			ShortCutToKey(mainform.kontrollpanelbuttons[i][j].ShortCut,MyKey,MyShift);
      if (MyKey=Key) and (MyShift=Shift) then
      begin
        flashingkey:=Key;
        flashingshift:=shift;
        kontrollpanel.PaintBox1MouseMove(nil, [], trunc(kontrollpanel.btnwidth.Value*j+(kontrollpanel.btnwidth.Value / 2)), trunc(kontrollpanel.btnheight.Value*i+(kontrollpanel.btnheight.Value / 2)));
        kontrollpanel.PaintBox1MouseDown(nil, mbLeft, [ssLeft], trunc(kontrollpanel.btnwidth.Value*j+(kontrollpanel.btnwidth.Value / 2)), trunc(kontrollpanel.btnheight.Value*i+(kontrollpanel.btnheight.Value / 2)));
      end;
    end;
  end;
end;

procedure Tkontrollpanel.CheckBox1Exit(Sender: TObject);
begin
  CheckBox1.Checked:=false;
end;

procedure Tkontrollpanel.HotKey1Change(Sender: TObject);
begin
	mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Shortcut:=HotKey1.HotKey;
end;

procedure Tkontrollpanel.CheckFileExistsTimer(Sender: TObject);
begin
  CollectButtonInfo;

{
	for i:=0 to zeilen.AsInteger-1 do
  begin
  	for j:=0 to spalten.AsInteger-1 do
    begin
    	case mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Typ of
				0: // Leer
				begin
		      labeltype[i][j].Transparent:=True;
    		  labeltype[i][j].Color:=$00F5F5F5;
        end;        
        1: // Szene aus Bibliothek
        begin
		      labeltype[i][j].Transparent:=True;
    		  labeltype[i][j].Color:=$00F5F5F5;
        end;
	      2:
	      begin
          // Skriptdatei
          if not FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(i+1)+'x'+inttostr(j+1)+'.pcdscrp') then
   				begin
          	labeltype[i][j].Caption:='Skript (Datei fehlt!)';
            labeltype[i][j].Transparent:=false;
            labeltype[i][j].Color:=clRed;
          end else
          begin
          	labeltype[i][j].Caption:='Skript';
            labeltype[i][j].Transparent:=True;
            labeltype[i][j].Color:=$00F5F5F5;
          end;
	      end;
        3: // Effekt
        begin
		      labeltype[i][j].Transparent:=True;
    		  labeltype[i][j].Color:=$00F5F5F5;
        end;
	      4: // Flashszene aus Bibliothek
	      begin
		      labeltype[i][j].Transparent:=True;
          labeltype[i][j].Color:=$00F5F5F5;
	      end;
	      5: // Flashskript
	      begin
          // Skriptdatei
          if not FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(i+1)+'x'+inttostr(j+1)+'.pcdscrp') then
   				begin
          	labeltype[i][j].Caption:='Flashskript (Datei fehlt!)';
            labeltype[i][j].Transparent:=false;
            labeltype[i][j].Color:=clRed;
          end else
          begin
          	labeltype[i][j].Caption:='Flashskript';
            labeltype[i][j].Transparent:=True;
            labeltype[i][j].Color:=$00F5F5F5;
          end;
	      end;
	      6: // Flasheffekt
	      begin
		      labeltype[i][j].Transparent:=True;
          labeltype[i][j].Color:=$00F5F5F5;
	      end;
	      7:
	      begin
          // Programmcode
          if not FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(i+1)+'x'+inttostr(j+1)+'.pas') then
   				begin
          	labeltype[i][j].Caption:='Programmcode (Datei fehlt!)';
            labeltype[i][j].Transparent:=false;
            labeltype[i][j].Color:=clRed;
          end else
          begin
          	labeltype[i][j].Caption:='Programmcode';
            labeltype[i][j].Transparent:=True;
            labeltype[i][j].Color:=$00F5F5F5;
          end;
	      end;
      end;
		end;
  end;
}
end;

procedure Tkontrollpanel.FormCreate(Sender: TObject);
//var
//  i:integer;
begin
  TranslateComponent(self);

  If not DirectoryExists(mainform.userdirectory+'ProjectTemp') then
	 	CreateDir(mainform.userdirectory+'ProjectTemp');
  If not DirectoryExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel') then
  	CreateDir(mainform.userdirectory+'ProjectTemp\Kontrollpanel');

  BtnDown.Y:=-1;
  BtnDown.X:=-1;

  yoffset:=0;
  xoffset:=0;

  setlength(mainform.kontrollpanelbuttons,2);
  setlength(mainform.kontrollpanelbuttons[0],4);

{
  for i:=0 to 3 do
  begin
    mainform.kontrollpanelbuttons[0][i].Name:=_('Neuer Button')+' 1x'+inttostr(i+1);
    mainform.kontrollpanelbuttons[0][i].Color:=clWhite;
    mainform.kontrollpanelbuttons[0][i].Typ:=-1;
    mainform.kontrollpanelbuttons[0][i].TypName:='';
    mainform.kontrollpanelbuttons[0][i].Time:='';
//    mainform.kontrollpanelbuttons[0][i].PNG:=TPNGObject.Create;
  end;
}

  _Buffer:=TBitmap32.Create;
  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;

  mainform.kontrollpanelrecord.formwidth:=632;
  mainform.kontrollpanelrecord.formheight:=272;

  buttonwidth:=100;
  buttonheight:=60;

  beat_syncFirstclick:=true;
  flashingkey:=0;
  flashingshift:=[ssLeft];

	OverBtn.Y:=0;
	OverBtn.X:=0;

  ScriptInterpreterArgs:=TJvInterpreterArgs.Create;

  // Initialisiere Touch-Interface, sofern möglich
  LoadTouchGestureAPI; // sofern verfügbar
{
  if bMultiTouchHardware then
    Caption:=Caption+' - MultiTouch'
  else if bTouchGestureAPIPresent then
    Caption:=Caption+' - Touch';
}
  // use only WM_TOUCH (if possible)
  if bMultiTouchHardware or bTouchGestureAPIPresent then
  begin
    Caption:=Caption+' - Touch';
    RegisterTouchWindowFn(kontrollpanel.handle, 0);
  end;
end;

procedure Tkontrollpanel.sync_btnClick(Sender: TObject);
begin
  if beat_syncFirstclick then
  begin
    beat_starttime:=DateTimeToTimeStamp(now);
    sync_btn.Caption:='End';
    beat_syncFirstclick:=false;
  end else
  begin
    beat_endtime:=DateTimeToTimeStamp(now);
    temposlider.Position:=(beat_endtime.Time - beat_starttime.Time);
    sync_btn.Caption:='Sync';
    beat_syncFirstclick:=true;
//    edit1.Text:=inttostr(round(60000 div temposlider.Position));
  end;
end;

procedure Tkontrollpanel.beattime_blinkerTimer(Sender: TObject);
begin
	if shape1.Brush.Color=clMaroon then
    shape1.Brush.Color:=clRed
  else
    shape1.Brush.Color:=clMaroon;
end;

procedure Tkontrollpanel.CheckBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
	i,j:integer;
  MyKey:Word;
  MyShift:TShiftState;
begin
	for i:=0 to zeilen.AsInteger-1 do
  begin
  	for j:=0 to spalten.AsInteger-1 do
    begin
			ShortCutToKey(mainform.kontrollpanelbuttons[i][j].ShortCut,MyKey,MyShift);
      if (MyKey=Key) and (MyShift=Shift) and (Key<>145) then // 145=Scrolllock-Key
      begin
        flashingkey:=0;
        flashingshift:=[ssLeft];
        kontrollpanel.PaintBox1MouseUp(nil, mbLeft, [ssLeft], trunc(kontrollpanel.btnwidth.Value*j+(kontrollpanel.btnwidth.Value / 2)), trunc(kontrollpanel.btnheight.Value*i+(kontrollpanel.btnheight.Value / 2)));
      end;
    end;
  end;
end;

procedure Tkontrollpanel.IndenVordergrund1Click(Sender: TObject);
begin
  kontrollpanel.FormStyle:=fsStayOnTop;
	Normal1.Checked:=false;
	IndenVordergrund1.Checked:=true;
end;

procedure Tkontrollpanel.Normal1Click(Sender: TObject);
begin
//  kontrollpanel.FormStyle:=fsNormal;
	Normal1.Checked:=true;
	IndenVordergrund1.Checked:=false;
end;

procedure Tkontrollpanel.hauptprogrammeffekteausClick(Sender: TObject);
begin
	hauptprogrammeffekteaus.Checked:=not hauptprogrammeffekteaus.Checked;
end;

procedure Tkontrollpanel.Beenden1Click(Sender: TObject);
begin
	close;
end;

procedure Tkontrollpanel.MSGNew;
var
	i,j:integer;
begin
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
  begin
    mainform.kontrollpanelbuttons[i][j].PNG.Free;
    mainform.kontrollpanelbuttons[i][j].PNG:=nil;
  end;

  OverBtn.Y:=0;
  OverBtn.X:=0;

  mainform.kontrollpanelrecord.zeilenanzahl:=0;
  mainform.kontrollpanelrecord.spaltenanzahl:=3;

  Combobox1.ItemIndex:=0;
  mainform.ComboBox1.ItemIndex:=Combobox1.ItemIndex;

  zeilen.value:=1;
  spalten.value:=4;
  setlength(mainform.kontrollpanelbuttons,1);
  setlength(mainform.kontrollpanelbuttons[0],4);
  for i:=0 to 3 do
  begin
    mainform.kontrollpanelbuttons[0][i].ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    mainform.kontrollpanelbuttons[0][i].Name:='Button 1x'+inttostr(i+1);
    mainform.kontrollpanelbuttons[0][i].Typ:=0;
    mainform.kontrollpanelbuttons[0][i].Picture:=mainform.pcdimmerdirectory+'\Devicepictures\32 x 32\par56silber.png';
    if not Assigned(mainform.kontrollpanelbuttons[0][i].PNG) then
      mainform.kontrollpanelbuttons[0][i].PNG:=TPNGObject.Create;
    mainform.kontrollpanelbuttons[0][i].PNG.LoadFromFile(mainform.kontrollpanelbuttons[0][i].Picture);
    mainform.kontrollpanelbuttons[0][i].Visible:=true;
    mainform.kontrollpanelbuttons[0][i].Color:=clWhite;
  end;
  mainform.kontrollpanelrecord.formheight:=272;
  mainform.kontrollpanelrecord.formwidth:=731;

  if panel1.Visible=false then
  begin
    kontrollpanel.Top:=kontrollpanel.Top-panel1.Height;
    panel1.Visible:=true;
    if not mainform.UserAccessGranted(1, false) then panel1.visible:=false;
    kontrollpanel.Height:=kontrollpanel.Height+panel1.Height;
    MenanzeigenDoppelklickaufStatusleiste1.Checked:=true;
    mainform.kontrollpanelrecord.NoOptions:=false;
  end;

  kontrollpanel.Height:=272;
  kontrollpanel.Width:=731;
  CollectButtonInfo;

  RedrawPanel;
  RedrawMainformPanel;
end;

procedure Tkontrollpanel.MSGOpen(Sender: TObject);
begin
  if mainform.kontrollpanelrecord.NoOptions then
  begin
	  panel1.Visible:=false;
	  kontrollpanel.Height:=kontrollpanel.Height-panel1.Height;
//    kontrollpanel.Top:=kontrollpanel.Top+panel1.Height;
    MenanzeigenDoppelklickaufStatusleiste1.Checked:=false;
  end else
  begin
    kontrollpanel.Width:=mainform.kontrollpanelrecord.formwidth;
    kontrollpanel.Height:=mainform.kontrollpanelrecord.formheight;
  end;

  zeilen.AsInteger:=mainform.kontrollpanelrecord.zeilenanzahl+1;
  spalten.AsInteger:=mainform.kontrollpanelrecord.spaltenanzahl+1;

{
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
  begin
    if FileExists(mainform.kontrollpanelbuttons[i][j].Picture) then
    begin
      mainform.kontrollpanelbuttons[i][j].PNG.Free;
      mainform.kontrollpanelbuttons[i][j].PNG:=nil;
      mainform.kontrollpanelbuttons[i][j].PNG:=TPNGObject.Create;
      mainform.kontrollpanelbuttons[i][j].PNG.LoadFromFile(mainform.kontrollpanelbuttons[i][j].Picture);
    end;
  end;
}
  CollectButtonInfo;

  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;

  RedrawPanel;
  RedrawMainformPanel;
end;

procedure Tkontrollpanel.MSGSave(Sender: TObject);
var
  LReg:TRegistry;
begin
  mainform.kontrollpanelrecord.formwidth:=kontrollpanel.Width;
  mainform.kontrollpanelrecord.formheight:=kontrollpanel.Height;
	mainform.kontrollpanelrecord.zeilenanzahl:=zeilen.AsInteger-1;
  mainform.kontrollpanelrecord.spaltenanzahl:=spalten.AsInteger-1;

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
        if not LReg.KeyExists('Kontrollpanel') then
	        LReg.CreateKey('Kontrollpanel');
	      if LReg.OpenKey('Kontrollpanel',true) then
	      begin
	        LReg.WriteBool('Show setup',MenanzeigenDoppelklickaufStatusleiste1.Checked);
          LReg.WriteBool('Deactivate Mainprogrameffects on click',hauptprogrammeffekteaus.checked);
          LReg.WriteBool('Enable Tooltips',ooltipsanzeigen1.checked);
          LReg.WriteInteger('Buttonstyle',buttonstyle);
          LReg.WriteInteger('Button Width',buttonwidth);
          LReg.WriteInteger('Button Height',buttonheight);
         	LReg.WriteBool('Show Pictures',showiconsbtn.checked);
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tkontrollpanel.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  RefreshTimer.enabled:=(mainform.PageControl1.ActivePageIndex=2) and (mainform.panel1.Visible);
  CheckForActive.Enabled:=false;
  CheckFileExists.Enabled:=false;
  beattime_blinker.Enabled:=false;

  mainform.kontrollpanelrecord.formwidth:=kontrollpanel.Width;
  mainform.kontrollpanelrecord.formheight:=kontrollpanel.Height;
	mainform.kontrollpanelrecord.zeilenanzahl:=zeilen.AsInteger-1;
  mainform.kontrollpanelrecord.spaltenanzahl:=spalten.AsInteger-1;

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
					LReg.WriteBool('Showing Kontrollpanel',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;
  mainform.SaveWindowPositions('kontrollpanel');
end;

procedure Tkontrollpanel.Einfgen1Click(Sender: TObject);
begin
  CopyButton(SourceBtn.X, SourceBtn.Y, SelectedBtn.X, SelectedBtn.Y);

  StatusBar1.Panels.Items[0].Text:='Button '+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1);
	buttonname.Text:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Name;
  buttonfarbe.Color:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color;
//  buttonfarbe.color:=button[SelectedBtn.Y][SelectedBtn.X].Gradient.Color0;
	combobox1.ItemIndex:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Typ;
  HotKey1.HotKey:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Shortcut;
  mainform.buttonname.text:=buttonname.text;
  mainform.buttonfarbe.Color:=buttonfarbe.Color;
  mainform.ComboBox1.ItemIndex:=Combobox1.ItemIndex;

  if cut then
  begin
    cut:=false;
    ResetButton(SourceBtn.X, SourceBtn.Y);
  end;
  CollectButtonInfo;
end;

procedure Tkontrollpanel.Kopieren1Click(Sender: TObject);
begin
 	SourceBtn.Y:=SelectedBtn.Y;
  SourceBtn.X:=SelectedBtn.X;
  Einfgen1.Enabled:=true;
  if Sender=Ausschneiden1 then
    cut:=true;
end;

procedure Tkontrollpanel.Lschen1Click(Sender: TObject);
begin
  if messagedlg(_('Durch setzen des Buttontyps auf "<Leer>" werden gespeicherte Szenen und eventuell vorhandene Skriptdateien gelöscht. Fortfahren?'),mtConfirmation,
    [mbYes,mbNo],0)=mrNo then exit;

  ResetButton(SelectedBtn.X, SelectedBtn.Y);

	CheckFileExistsTimer(nil);

  StatusBar1.Panels.Items[0].Text:='Button '+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1);
	buttonname.Text:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Name;
  buttonfarbe.Color:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color;
	combobox1.ItemIndex:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Typ;
  HotKey1.HotKey:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Shortcut;
  mainform.buttonname.text:=buttonname.text;
  mainform.buttonfarbe.Color:=buttonfarbe.Color;
  mainform.ComboBox1.ItemIndex:=Combobox1.ItemIndex;
end;

procedure Tkontrollpanel.ooltipsanzeigen1Click(Sender: TObject);
begin
  ooltipsanzeigen1.Checked:=not ooltipsanzeigen1.Checked;
end;

procedure Tkontrollpanel.Bearbeiten1Click(Sender: TObject);
begin
  szenebearbeitenClick(nil);
end;

procedure Tkontrollpanel.CreateParams(var Params:TCreateParams);
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

procedure Tkontrollpanel.OpenFile(filename: string);
var
  i,j, Count:integer;
begin
  If not DirectoryExists(mainform.userdirectory+'ProjectTemp') then
    CreateDir(mainform.userdirectory+'ProjectTemp');
  If not DirectoryExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel') then
    CreateDir(mainform.userdirectory+'ProjectTemp\Kontrollpanel');
  Compress.DecompressFile(filename,mainform.userdirectory+'ProjectTemp\Kontrollpanel\',true,false);
  FileStream:=TFileStream.Create(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Kontrollpanel',fmOpenRead);
  FileStream.ReadBuffer(mainform.kontrollpanelrecord,sizeof(mainform.kontrollpanelrecord));

  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
  begin
    mainform.kontrollpanelbuttons[i][j].PNG.Free;
    mainform.kontrollpanelbuttons[i][j].PNG:=nil;
  end;

  Filestream.ReadBuffer(Count,sizeof(Count));
  setlength(mainform.kontrollpanelbuttons,Count);
  Filestream.ReadBuffer(Count,sizeof(Count));
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
    setlength(mainform.kontrollpanelbuttons[i],Count);

  zeilen.value:=length(mainform.kontrollpanelbuttons);
  spalten.value:=length(mainform.kontrollpanelbuttons[0]);

  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
  begin
    Filestream.ReadBuffer(mainform.kontrollpanelbuttons[i][j].ID,sizeof(mainform.kontrollpanelbuttons[i][j].ID));
    Filestream.ReadBuffer(mainform.kontrollpanelbuttons[i][j].Name,sizeof(mainform.kontrollpanelbuttons[i][j].Name));
    Filestream.ReadBuffer(mainform.kontrollpanelbuttons[i][j].Color,sizeof(mainform.kontrollpanelbuttons[i][j].Color));
    Filestream.ReadBuffer(mainform.kontrollpanelbuttons[i][j].Typ,sizeof(mainform.kontrollpanelbuttons[i][j].Typ));
    Filestream.ReadBuffer(mainform.kontrollpanelbuttons[i][j].Shortcut,sizeof(mainform.kontrollpanelbuttons[i][j].Shortcut));
    Filestream.ReadBuffer(mainform.kontrollpanelbuttons[i][j].Picture,sizeof(mainform.kontrollpanelbuttons[i][j].Picture));

    if not Assigned(mainform.kontrollpanelbuttons[i][j].PNG) then
      mainform.kontrollpanelbuttons[i][j].PNG:=TPNGObject.Create;
    if FileExists(mainform.kontrollpanelbuttons[i][j].Picture) then
      mainform.kontrollpanelbuttons[i][j].PNG.LoadFromFile(mainform.kontrollpanelbuttons[i][j].Picture);
    mainform.kontrollpanelbuttons[i][j].Visible:=true;
  end;

  FileStream.Free;

  kontrollpanel.Width:=mainform.kontrollpanelrecord.formwidth;
  kontrollpanel.Height:=mainform.kontrollpanelrecord.formheight;
  CollectButtonInfo;
end;

// Erstellt ein Farbverlauf von links nach rechts
{
procedure Tkontrollpanel.DrawGradientV(Canvas: TCanvas; Color1, Color2: TColor; Rect: TRect);
var
  Y, R, G, B: Integer;
begin
  for Y := Rect.Left to Rect.Right do begin
    R := Round(GetRValue(Color1) + ((GetRValue(Color2) - GetRValue(Color1)) * (Y - Rect.Left) / (Rect.Right - Rect.Left)));
    G := Round(GetGValue(Color1) + ((GetGValue(Color2) - GetGValue(Color1)) * (Y - Rect.Left) / (Rect.Right - Rect.Left)));
    B := Round(GetBValue(Color1) + ((GetBValue(Color2) - GetBValue(Color1)) * (Y - Rect.Left) / (Rect.Right - Rect.Left)));

    Canvas.Pen.Color := RGB2TColor(R, G, B);
    Canvas.Pen.Width := 1;
    Canvas.Pen.Style := psInsideFrame;

    Canvas.MoveTo(Y, Rect.Top);
    Canvas.LineTo(Y, Rect.Bottom);
  end;
end;
}

// Erstellt ein Farbverlauf von oben nach unten
procedure Tkontrollpanel.DrawGradientH(Canvas: TCanvas; Color1, Color2: TColor; Rect: TRect);
var
  X,R,G,B:integer;
begin
  for X := Rect.Top to Rect.Bottom do
  begin
    R := Round(GetRValue(Color1) + ((GetRValue(Color2) - GetRValue(Color1)) * (X - Rect.Top) / (Rect.Bottom - Rect.Top)));
    G := Round(GetGValue(Color1) + ((GetGValue(Color2) - GetGValue(Color1)) * (X - Rect.Top) / (Rect.Bottom - Rect.Top)));
    B := Round(GetBValue(Color1) + ((GetBValue(Color2) - GetBValue(Color1)) * (X - Rect.Top) / (Rect.Bottom - Rect.Top)));

    Canvas.Pen.Color := RGB2TColor(R, G, B);
    Canvas.Pen.Width := 1;
    Canvas.Pen.Style := psInsideFrame;

    Canvas.MoveTo(Rect.Left, X);
    Canvas.LineTo(Rect.Right, X);
  end;
end;

function Tkontrollpanel.UseGradient(Farbe: TColor; Direction: byte):TColor;
var
  R,G,B:Byte;
  gradientvalue:integer;
begin
  gradientvalue:=0;

  if Direction=0 then
    gradientvalue:=50; // Dunkler
  if Direction=1 then
    gradientvalue:=-150; // Heller

  TColor2RGB(Farbe,R,G,B);

  if gradientvalue>0 then
  begin
    if (R-gradientvalue>=0) then R:=R-gradientvalue else R:=0;
    if (G-gradientvalue>=0) then G:=G-gradientvalue else G:=0;
    if (B-gradientvalue>=0) then B:=B-gradientvalue else B:=0;
  end else
  begin
    if (R-gradientvalue)<=255 then R:=R-gradientvalue else R:=255;
    if (G-gradientvalue)<=255 then G:=G-gradientvalue else G:=255;
    if (B-gradientvalue)<=255 then B:=B-gradientvalue else B:=255;
  end;

  Result:=RGB2TColor(R,G,B);
end;

procedure Tkontrollpanel.StopButton(Col,Row:integer);
var
  i:integer;
begin
	case mainform.kontrollpanelbuttons[Row][Col].Typ of
  0:
  begin
  end;
  1:
  begin
    mainform.StopScene(mainform.kontrollpanelbuttons[Row][Col].ID);
  end;
  2:
  begin
    // SKRIPT ABBRECHEN
    waitkey:=false;
	  closing:=true;
    waitkey:=false;

	  for i:=1 to mainform.lastchan do
	  begin
    	inprogram[i]:=false;
      mainform.data.ch[i]:=255-mainform.channel_value[i];
			mainform.senddata(i,255-mainform.channel_value[i],255-mainform.channel_value[i],0);
    end;
  end;
  3:
  begin
    mainform.StopScene(mainform.kontrollpanelbuttons[Row][Col].ID);
  end;
  end;
end;

procedure Tkontrollpanel.CheckForActiveTimer(Sender: TObject);
var
  i,j:integer;
begin
	for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
  begin
  	for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
    begin
      mainform.kontrollpanelbuttons[i][j].Active:=IsButtonActive(j, i);
    end;
  end;
end;

function Tkontrollpanel.IsButtonActive(X, Y:integer):boolean;
var
  k:integer;
  ButtonActive:boolean;
begin
  ButtonActive:=false;
  if (Y>=0) and (X>=0) and (Y<length(mainform.kontrollpanelbuttons)) and (X<length(mainform.kontrollpanelbuttons[Y])) then
  begin
    case mainform.kontrollpanelbuttons[Y][X].Typ of
      1,4: // Objekt aus Szenenverwaltung
      begin
        // Audioszene
        for k:=0 to length(mainform.AudioSzenen)-1 do
        begin
          if IsEqualGUID(mainform.AudioSzenen[k].ID,mainform.kontrollpanelbuttons[Y][X].ID) then
          begin
            if mainform.IsSceneActive(mainform.kontrollpanelbuttons[Y][X].ID) then
            begin          
              case mainform.kontrollpanelbuttons[Y][X].Typ of
                1:mainform.kontrollpanelbuttons[Y][X].TypName:='[Audioszene]';
                4:mainform.kontrollpanelbuttons[Y][X].TypName:='[Flash-Audio]';
              end;
              ButtonActive:=true;
            end else
            begin
              case mainform.kontrollpanelbuttons[Y][X].Typ of
                1:mainform.kontrollpanelbuttons[Y][X].TypName:='Audioszene';
                4:mainform.kontrollpanelbuttons[Y][X].TypName:='Flash-Audio';
              end;
              ButtonActive:=false;
            end;
            break;
          end;
        end;
        // Bewegungsszene
        for k:=0 to length(mainform.Bewegungsszenen)-1 do
        begin
          if IsEqualGUID(mainform.Bewegungsszenen[k].ID,mainform.kontrollpanelbuttons[Y][X].ID) then
          begin
            if mainform.IsSceneActive(mainform.kontrollpanelbuttons[Y][X].ID) then
            begin
              case mainform.kontrollpanelbuttons[Y][X].Typ of
                1:mainform.kontrollpanelbuttons[Y][X].TypName:='[Bewegungsszene]';
                4:mainform.kontrollpanelbuttons[Y][X].TypName:='[Flash-Bewegung]';
              end;
              ButtonActive:=true;
            end else
            begin
              case mainform.kontrollpanelbuttons[Y][X].Typ of
                1:mainform.kontrollpanelbuttons[Y][X].TypName:='Bewegungsszene';
                4:mainform.kontrollpanelbuttons[Y][X].TypName:='Flash-Bewegung';
              end;
              ButtonActive:=false;
            end;
            break;
          end;
        end;
        // Effekte
        for k:=0 to length(mainform.effektsequenzereffekte)-1 do
        begin
          if IsEqualGUID(mainform.effektsequenzereffekte[k].ID,mainform.kontrollpanelbuttons[Y][X].ID) then
          begin
            if mainform.IsSceneActive(mainform.kontrollpanelbuttons[Y][X].ID) then
            begin
              case mainform.kontrollpanelbuttons[Y][X].Typ of
                1:mainform.kontrollpanelbuttons[Y][X].TypName:='[Effekt]';
                4:mainform.kontrollpanelbuttons[Y][X].TypName:='[Flash-Effekt]';
              end;
              ButtonActive:=true;
            end else
            begin
              case mainform.kontrollpanelbuttons[Y][X].Typ of
                1:mainform.kontrollpanelbuttons[Y][X].TypName:='Effekt';
                4:mainform.kontrollpanelbuttons[Y][X].TypName:='Flash-Effekt';
              end;
              ButtonActive:=false;
            end;
            break;
          end;
        end;
      end;
      3,6:
      begin
        for k:=0 to length(mainform.Effektsequenzereffekte)-1 do
        begin
          if IsEqualGUID(mainform.Effektsequenzereffekte[k].ID,mainform.kontrollpanelbuttons[Y][X].ID) then
          begin
            if mainform.IsSceneActive(mainform.kontrollpanelbuttons[Y][X].ID) then
            begin
              case mainform.kontrollpanelbuttons[Y][X].Typ of
                3:mainform.kontrollpanelbuttons[Y][X].TypName:='[Effekt]';
                6:mainform.kontrollpanelbuttons[Y][X].TypName:='[Flash-Effekt]';
              end;
              ButtonActive:=true;
            end else
            begin
              case mainform.kontrollpanelbuttons[Y][X].Typ of
                3:mainform.kontrollpanelbuttons[Y][X].TypName:='Effekt';
                6:mainform.kontrollpanelbuttons[Y][X].TypName:='Flash-Effekt';
              end;
              ButtonActive:=false;
            end;
            break;
          end;
        end;
      end;
    end;
  end;
  result:=ButtonActive;
end;

procedure Tkontrollpanel.ScriptInterpreterGetValue(Sender: TObject;
  Identifier: String; var Value: Variant; Args: TJvInterpreterArgs;
  var Done: Boolean);
var
  ID:TGUID;
  i:integer;
begin
  if lowercase(Identifier)='init_channel' then
  begin
    if args.Count=3 then
      geraetesteuerung.set_channel(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[2],0);
    done:=true;
  end;

  if (lowercase(Identifier)='set_absolutchannel') or (lowercase(Identifier)='set_absolutechannel') then
  begin
    if args.Count=4 then
    begin
      if args.values[1]>-1 then
        mainform.Senddata(args.values[0],255-args.values[1],255-args.values[2],args.values[3]);
      if args.values[1]=-1 then
        mainform.Senddata(args.values[0],mainform.channel_value[Integer(args.values[0])],255-args.values[2],args.values[3]);
    end;
    if args.Count=5 then
    begin
      mainform.Senddata(args.values[0],maxres-args.values[1],maxres-args.values[2],args.values[3],args.values[4]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_pantilt' then
  begin
    if args.Count=6 then
    begin
      geraetesteuerung.set_pantilt(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4],args.values[5]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_channel' then
  begin
    if args.Count=5 then
    begin
      if args.values[2]>-1 then
        geraetesteuerung.set_channel(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4]);
      if args.values[2]=-1 then
        geraetesteuerung.set_channel(StringToGUID(args.values[0]),args.values[1],geraetesteuerung.get_channel(StringToGUID(args.values[0]),args.values[1]),args.values[3],args.values[4]);
    end;
    if args.Count=6 then
    begin
      if args.values[2]>-1 then
        geraetesteuerung.set_channel(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4],args.values[5]);
      if args.values[2]=-1 then
        geraetesteuerung.set_channel(StringToGUID(args.values[0]),args.values[1],geraetesteuerung.get_channel(StringToGUID(args.values[0]),args.values[1]),args.values[3],args.values[4],args.values[5]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_groupchannel' then
  begin
    if args.Count=5 then
    begin
      if args.values[2]>-1 then
        geraetesteuerung.set_group(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4]);
      if args.values[2]=-1 then
        geraetesteuerung.set_group(StringToGUID(args.values[0]),args.values[1],geraetesteuerung.get_channel(StringToGUID(args.values[0]),args.values[1]),args.values[3],args.values[4]);
    end;
    if args.Count=6 then
    begin
      if args.values[2]>-1 then
        geraetesteuerung.set_group(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4],args.values[5]);
      if args.values[2]=-1 then
        geraetesteuerung.set_group(StringToGUID(args.values[0]),args.values[1],geraetesteuerung.get_channel(StringToGUID(args.values[0]),args.values[1]),args.values[3],args.values[4],args.values[5]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_color' then
  begin
    if args.Count=6 then
    begin
      geraetesteuerung.set_color(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4],args.values[5]);
    end;
    done:=true;
  end;

  if (lowercase(Identifier)='get_absolutchannel') or (lowercase(Identifier)='get_absolutechannel') then
  begin
    Value:=255-mainform.data.ch[Integer(args.values[0])];
    args.HasResult:=true;
    Done:=true;
  end;

  if (lowercase(Identifier)='set_var') then
  begin
    for i:=0 to length(mainform.CodeScenes)-1 do
    begin
      if IsEqualGUID(mainform.CodeScenes[i].ID, ScriptInterpreterCallingCodeSceneID) then
      begin
        if args.values[0]>=length(mainform.CodeScenes[i].Variables) then
          setlength(mainform.CodeScenes[i].Variables, Integer(args.values[0]));
        mainform.CodeScenes[i].Variables[Integer(args.values[0])-1]:=args.values[1];
        Done:=true;
        break;
      end;
    end;
    if not Done then
    begin
      ShowMessage(_('Die Funktion "set_var" ist nur nach Abspeichern einer Code-Szene verfügbar...'));
      Done:=true;
    end;
  end;
  if (lowercase(Identifier)='get_var') then
  begin
    for i:=0 to length(mainform.CodeScenes)-1 do
    begin
      if IsEqualGUID(mainform.CodeScenes[i].ID, ScriptInterpreterCallingCodeSceneID) then
      begin
        if args.values[0]>=length(mainform.CodeScenes[i].Variables) then
          setlength(mainform.CodeScenes[i].Variables, Integer(args.values[0]));
        Value:=mainform.CodeScenes[i].Variables[Integer(args.values[0])-1];
        args.HasResult:=true;
        Done:=true;
        break;
      end;
    end;
    if not Done then
    begin
      ShowMessage(_('Die Funktion "get_var" ist nur nach Abspeichern einer Code-Szene verfügbar...'));
      Done:=true;
    end;
  end;
  if (lowercase(Identifier)='set_globalvar') then
  begin
    if args.values[0]>=length(mainform.GlobalVariables) then
      setlength(mainform.GlobalVariables, Integer(args.values[0]));
    mainform.GlobalVariables[Integer(args.values[0])-1]:=args.values[1];
    Done:=true;
  end;
  if (lowercase(Identifier)='get_globalvar') then
  begin
    if args.values[0]>=length(mainform.GlobalVariables) then
      setlength(mainform.GlobalVariables, Integer(args.values[0]));
    Value:=mainform.GlobalVariables[Integer(args.values[0])-1];
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='get_channel' then
  if args.Count=2 then
  begin
    ID:=StringToGUID(args.values[0]);
    Value:=geraetesteuerung.get_channel(mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@ID)].ID,args.values[1]);
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='set_panelbuttoncolor' then
  if args.Count=3 then
  begin
    if (args.values[0]>0) and (args.values[1]>0) and ((args.values[1]-1)<length(mainform.kontrollpanelbuttons)) and ((args.values[0]-1)<length(mainform.kontrollpanelbuttons[Integer(args.values[1])-1])) then
    begin
      mainform.kontrollpanelbuttons[Integer(args.values[1])-1][Integer(args.values[0])-1].Color:=TColor(args.values[2]);
      Done:=true;
    end;
  end;

  if lowercase(Identifier)='get_panelbuttoncolor' then
  if args.Count=2 then
  begin
    if (args.values[0]>0) and (args.values[1]>0) and ((args.values[1]-1)<length(mainform.kontrollpanelbuttons)) and ((args.values[0]-1)<length(mainform.kontrollpanelbuttons[Integer(args.values[1])-1])) then
    begin
      Value:=mainform.kontrollpanelbuttons[Integer(args.values[1])-1][Integer(args.values[0])-1].Color;
      args.HasResult:=true;
      Done:=true;
    end;
  end;

  if lowercase(Identifier)='set_panelbuttontext' then
  if args.Count=3 then
  begin
    if (args.values[0]>0) and (args.values[1]>0) and ((args.values[1]-1)<length(mainform.kontrollpanelbuttons)) and ((args.values[0]-1)<length(mainform.kontrollpanelbuttons[Integer(args.values[1])-1])) then
    begin
      mainform.kontrollpanelbuttons[Integer(args.values[1])-1][Integer(args.values[0])-1].Name:=string(args.values[2]);
      Done:=true;
    end;
  end;

  if lowercase(Identifier)='get_panelbuttontext' then
  if args.Count=2 then
  begin
    if (args.values[0]>0) and (args.values[1]>0) and ((args.values[1]-1)<length(mainform.kontrollpanelbuttons)) and ((args.values[0]-1)<length(mainform.kontrollpanelbuttons[Integer(args.values[1])-1])) then
    begin
      Value:=mainform.kontrollpanelbuttons[Integer(args.values[1])-1][Integer(args.values[0])-1].Name;
      args.HasResult:=true;
      Done:=true;
    end;
  end;

  if lowercase(Identifier)='sendmidi' then
  begin
    if args.Count=3 then
    begin
      mainform.SendMidi(args.values[0], args.values[1], args.values[2]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='get_lastmidi' then
  begin
    Value:=char(mainform.LastMidiMSG)+char(mainform.LastMidiData1)+char(mainform.LastMidiData2);
    args.HasResult:=true;
    done:=true;
  end;

  if lowercase(Identifier)='senddatain' then
  begin
    if args.Count=2 then
    begin
      mainform.ExecuteDataInEvent(args.values[0], args.values[1]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='get_lastdatain' then
  begin
    Value:=char(byte(mainform.LastDataInChannel shr 8))+char(byte(mainform.LastDataInChannel))+char(mainform.LastDataInValue);
    args.HasResult:=true;
    done:=true;
  end;

  if lowercase(Identifier)='sendmessage' then
  begin
    if args.Count=3 then
    begin
      mainform.SendMSG(args.values[0], args.values[1], args.values[2]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='levelstr' then
  begin
    Value:=mainform.levelstr(args.values[0]);
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='startscene' then
  begin
    if args.Count=1 then
    begin
      // Check Type of Scene. If it is a CodeScene show Error
      if (mainform.GetSceneType(StringToGUID(args.values[0]))=11) then
      begin
        ShowMessage(_('Code-Szenen können nicht aus einer momentan ausgeführten Code-Szene heraus ausgeführt werden...'));
      end else
      begin
        // start scene as it is no CodeScene
        mainform.startscene(StringToGUID(args.values[0]),false,false);
      end;
    end;
    done:=true;
  end;

  if lowercase(Identifier)='stopscene' then
  begin
    if args.Count=1 then
    begin
      mainform.stopscene(StringToGUID(args.values[0]));
    end;
    done:=true;
  end;

  if lowercase(Identifier)='startstopscene' then
  begin
    if args.Count=1 then
    begin
      if mainform.IsSceneActive(StringToGUID(args.values[0])) then
        mainform.StopScene(StringToGUID(args.values[0])) // Szene stoppen
      else
        mainform.StartScene(StringToGUID(args.values[0]),false,false); // Szene starten
    end;
    done:=true;
  end;

  if lowercase(Identifier)='starteffect' then
  begin
    if args.Count=1 then
    begin
      mainform.startscene(StringToGUID(args.values[0]),false,false);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='stopeffect' then
  begin
    if args.Count=1 then
    begin
      mainform.stopscene(StringToGUID(args.values[0]));
    end;
    done:=true;
  end;

  if lowercase(Identifier)='startstopeffect' then
  begin
    if args.Count=1 then
    begin
      if mainform.IsSceneActive(StringToGUID(args.values[0])) then
        mainform.StopScene(StringToGUID(args.values[0])) // Szene stoppen
      else
        mainform.StartScene(StringToGUID(args.values[0]),false,false); // Szene starten
    end;
    done:=true;
  end;

  if lowercase(Identifier)='openfile' then
  begin
    if args.Count=1 then
    begin
      if FileExists(mainform.SearchFileBeneathProject(args.values[0])) then
        mainform.OpenPCDIMMERFile(mainform.SearchFileBeneathProject(args.values[0]))
      else
        ShowMessage('Die Datei "'+args.values[0]+'" existiert nicht.');
    end;
    done:=true;
  end;

  if lowercase(Identifier)='sin' then
  begin
    Value:=sin(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='cos' then
  begin
    Value:=cos(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='arccos' then
  begin
    Value:=arccos(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='degtorad' then
  begin
    Value:=degtorad(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='radtodeg' then
  begin
    Value:=radtodeg(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='frac' then
  begin
    Value:=frac(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  // Objekte zuweisen
  if lowercase(Identifier)='mainform' then
  begin
    Value := O2V(mainform);
    Done := True;
  end;
  if lowercase(Identifier)='globalvariables' then
  begin
    Value := mainform.GlobalVariables;
    Done := True;
  end;
  if lowercase(Identifier)='kontrollpanel' then
  begin
    Value := O2V(self);
    Done := True;
  end;
  if lowercase(Identifier)='sync_btn' then
  begin
    Value := O2V(sync_btn);
    Done := True;
  end;
end;

procedure Tkontrollpanel.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Tkontrollpanel.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tkontrollpanel.Farbendern1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color:=colordialog1.Color;
  end;
end;

procedure Tkontrollpanel.temposliderScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
{
  StatusBar1.Panels.Items[1].Text:=floattostrf(60000 / temposlider.Position, ffGeneral , 4, 2)+' BPM / '+floattostrf(temposlider.Position / 1000, ffGeneral , 4, 2)+'s';
	beattime_blinker.Interval:=Round(60000/((60000-temposlider.Position)/100));
  beatform.temposlider.Position:=temposlider.Position;
}
  beatform.UpdateBPM((60000-temposlider.position)/100);
end;

procedure Tkontrollpanel.btnwidthChange(Sender: TObject);
begin
  mainform.btnwidth.Value:=btnwidth.value;
  mainform.btnheight.Value:=btnheight.value;

  buttonwidth:=round(btnwidth.Value);
  buttonheight:=round(btnheight.Value);
end;

procedure Tkontrollpanel.PngBitBtn2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  yoffset:=yoffset+round(btnheight.value*trunc(Paintbox1.Height/btnheight.value));
  if yoffset>0 then yoffset:=0;
  RefreshTimerTimer(nil);
end;

procedure Tkontrollpanel.PngBitBtn1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  yoffset:=yoffset-round(btnheight.value*trunc(Paintbox1.Height/btnheight.value));
  if yoffset<(-(zeilen.value-trunc(Paintbox1.Height/btnheight.value))*btnheight.value) then yoffset:=-1*round((zeilen.value-trunc(Paintbox1.Height/btnheight.value))*btnheight.value);
  RefreshTimerTimer(nil);
end;

procedure Tkontrollpanel.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  yoffset:=yoffset+(WheelDelta div 3);
  yoffset:=round(round(yoffset/btnheight.Value)*btnheight.Value);
  if yoffset>0 then yoffset:=0;
  if yoffset<(-(zeilen.value-trunc(Paintbox1.Height/btnheight.value))*btnheight.value) then yoffset:=-1*round((zeilen.value-trunc(Paintbox1.Height/btnheight.value))*btnheight.value);
  Counter:=251;
  RefreshTimer.Interval:=mainform.Rfr_Kontrollpanel;
end;

procedure Tkontrollpanel.RefreshTimerTimer(Sender: TObject);
begin
  Counter:=Counter+1;
  if Counter>=trunc(mainform.Rfr_Kontrollpanel/10) then
  begin
    Counter:=0;

    if kontrollpanel.Showing then
      RedrawPanel;

    if (mainform.PageControl1.ActivePageIndex=2) and (mainform.panel1.visible) then
      RedrawMainformPanel;
  end;
end;

procedure Tkontrollpanel.CollectButtonInfo;
var
  i,j,k:integer;
begin
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
  begin
      case mainform.kontrollpanelbuttons[i][j].Typ of
      	0:
        begin
          mainform.kontrollpanelbuttons[i][j].TypName:=' '; // Leer
          mainform.kontrollpanelbuttons[i][j].Time:=' ';
        end;
      	1: // Objekt aus Szenenverwaltung
        begin
          // Einfache Einblendszene
          for k:=0 to length(mainform.EinfacheSzenen)-1 do
          begin
            if IsEqualGUID(mainform.EinfacheSzenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Einfache Szene ('+mainform.MillisecondsToTimeShort(mainform.EinfacheSzenen[k].einblendzeit)+')';
              mainform.kontrollpanelbuttons[i][j].Time:=mainform.MillisecondsToTimeShort(mainform.EinfacheSzenen[k].einblendzeit);
              break;
            end;
          end;
          // Geräteszene
          for k:=0 to length(mainform.Devicescenes)-1 do
          begin
            if IsEqualGUID(mainform.Devicescenes[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Geräteszene ('+mainform.MillisecondsToTimeShort(mainform.Devicescenes[k].Fadetime)+')';
              mainform.kontrollpanelbuttons[i][j].Time:=mainform.MillisecondsToTimeShort(mainform.Devicescenes[k].Fadetime);
              break;
            end;
          end;
          // Audioszene
          for k:=0 to length(mainform.AudioSzenen)-1 do
          begin
          if IsEqualGUID(mainform.AudioSzenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Audioszene';
              mainform.kontrollpanelbuttons[i][j].Time:=mainform.MillisecondsToTimeShort(mainform.AudioSzenen[k].Dauer);
              break;
            end;
          end;
          // Bewegungsszene
          for k:=0 to length(mainform.Bewegungsszenen)-1 do
          begin
            if IsEqualGUID(mainform.Bewegungsszenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Bewegungsszene';
              mainform.kontrollpanelbuttons[i][j].Time:=mainform.MillisecondsToTimeShort(mainform.Bewegungsszenen[k].dauer);
              break;
            end;
          end;
          // Befehle
          for k:=0 to length(mainform.Befehle2)-1 do
          begin
            if IsEqualGUID(mainform.Befehle2[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Befehl';
              mainform.kontrollpanelbuttons[i][j].Time:='-';
              break;
            end;
          end;
          // Komposition
          for k:=0 to length(mainform.Kompositionsszenen)-1 do
          begin
            if IsEqualGUID(mainform.Kompositionsszenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Kombination';
              mainform.kontrollpanelbuttons[i][j].Time:='-';
              break;
            end;
          end;
          // Preset
          for k:=0 to length(mainform.DevicePresets)-1 do
          begin
            if IsEqualGUID(mainform.DevicePresets[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Preset';
              mainform.kontrollpanelbuttons[i][j].Time:='-';
              break;
            end;
          end;
          // Automatikszene
          for k:=0 to length(mainform.autoszenen)-1 do
          begin
            if IsEqualGUID(mainform.autoszenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Automatikszene';
              mainform.kontrollpanelbuttons[i][j].Time:=mainform.MillisecondsToTimeShort(mainform.autoszenen[k].fadetime);
              break;
            end;
          end;
          // MediaCenter Szene
          for k:=0 to length(mainform.MediaCenterSzenen)-1 do
          begin
            if IsEqualGUID(mainform.MediaCenterSzenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='MediaCenter Szene';
              mainform.kontrollpanelbuttons[i][j].Time:='-';
              break;
            end;
          end;
        end;
      	2:
        begin
          mainform.kontrollpanelbuttons[i][j].TypName:='Skript'; // Skript
          mainform.kontrollpanelbuttons[i][j].Time:='-';
        end;
        3:
        begin
          mainform.kontrollpanelbuttons[i][j].TypName:='Effekt'; // Effekt
          mainform.kontrollpanelbuttons[i][j].Time:='-';
        end;
      	4: // Flashobjekt
        begin
          // Einfache Einblendszene
          for k:=0 to length(mainform.EinfacheSzenen)-1 do
          begin
            if IsEqualGUID(mainform.EinfacheSzenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Flashszene';
              mainform.kontrollpanelbuttons[i][j].Time:=mainform.MillisecondsToTimeShort(mainform.EinfacheSzenen[k].einblendzeit);
              break;
            end;
          end;
          // Geräteszene
          for k:=0 to length(mainform.Devicescenes)-1 do
          begin
            if IsEqualGUID(mainform.Devicescenes[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Flashgeräteszene';
              mainform.kontrollpanelbuttons[i][j].Time:=mainform.MillisecondsToTimeShort(mainform.Devicescenes[k].Fadetime);
              break;
            end;
          end;
          // Audioszene
          for k:=0 to length(mainform.AudioSzenen)-1 do
          begin
          if IsEqualGUID(mainform.AudioSzenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Flash-Audio';
              mainform.kontrollpanelbuttons[i][j].Time:=mainform.MillisecondsToTimeShort(mainform.AudioSzenen[k].Dauer);
              break;
            end;
          end;
          // Bewegungsszene
          for k:=0 to length(mainform.Bewegungsszenen)-1 do
          begin
            if IsEqualGUID(mainform.Bewegungsszenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Flash-Bewegung';
              mainform.kontrollpanelbuttons[i][j].Time:=mainform.MillisecondsToTimeShort(mainform.Bewegungsszenen[k].dauer);
              break;
            end;
          end;
          // Befehle
          for k:=0 to length(mainform.Befehle2)-1 do
          begin
            if IsEqualGUID(mainform.Befehle2[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Befehl';
              mainform.kontrollpanelbuttons[i][j].Time:='-';
              break;
            end;
          end;
          // Komposition
          for k:=0 to length(mainform.Kompositionsszenen)-1 do
          begin
            if IsEqualGUID(mainform.Kompositionsszenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Flashkombination';
              mainform.kontrollpanelbuttons[i][j].Time:='-';
              break;
            end;
          end;
          // Preset
          for k:=0 to length(mainform.Devicepresets)-1 do
          begin
            if IsEqualGUID(mainform.Devicepresets[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Flashpreset';
              mainform.kontrollpanelbuttons[i][j].Time:='-';
              break;
            end;
          end;
          // Automatikszene
          for k:=0 to length(mainform.autoszenen)-1 do
          begin
            if IsEqualGUID(mainform.autoszenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='Flashautoszene';
              mainform.kontrollpanelbuttons[i][j].Time:=mainform.MillisecondsToTimeShort(mainform.autoszenen[k].fadetime);
              break;
            end;
          end;
          // MediaCenterSzenen
          for k:=0 to length(mainform.MediaCenterSzenen)-1 do
          begin
            if IsEqualGUID(mainform.MediaCenterSzenen[k].ID,mainform.kontrollpanelbuttons[i][j].ID) then
            begin
              mainform.kontrollpanelbuttons[i][j].TypName:='MediaCenter Szene';
              mainform.kontrollpanelbuttons[i][j].Time:='-';
              break;
            end;
          end;
        end;
   			5:
        begin
          mainform.kontrollpanelbuttons[i][j].TypName:='Flashskript';
          mainform.kontrollpanelbuttons[i][j].Time:='-';
        end;
   			6:
        begin
          mainform.kontrollpanelbuttons[i][j].TypName:='Flash-Effekt';
          mainform.kontrollpanelbuttons[i][j].Time:='-';
        end;
        7:
        begin
          mainform.kontrollpanelbuttons[i][j].TypName:='Programmcode'; // Programmcode
          mainform.kontrollpanelbuttons[i][j].Time:='-';
        end;
      end;
  end;
end;

procedure Tkontrollpanel.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(3, false) then exit;


  if (Shift=[]) or (Shift=[ssLeft, ssShift]) or (Shift=[ssLeft, ssCtrl]) then
  begin
    OverBtn.Y:=trunc((Y-yoffset)/btnheight.value);
    OverBtn.X:=trunc((X-xoffset)/btnwidth.value);
  end;
  if (Shift=[ssLeft, ssShift]) then
    Extrahighlight:=1 // Single button
  else if (Shift=[ssLeft, ssCtrl]) then
    Extrahighlight:=2 // Complete row
  else
    Extrahighlight:=0;

  if (Shift=[ssLeft]) or (Shift=[ssRight]) then
  begin
//    xoffset:=OldOffset.X+(X-MouseDown.X);
    yoffset:=OldOffset.Y+(Y-MouseDown.Y);
//    xoffset:=round(round(xoffset/btnwidth.Value)*btnwidth.Value);
    yoffset:=round(round(yoffset/btnheight.Value)*btnheight.Value);
    if yoffset>0 then yoffset:=0;
  end;
  Counter:=251;
  RefreshTimer.Interval:=mainform.Rfr_Kontrollpanel;
end;

procedure Tkontrollpanel.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(3, false) then exit;

  if ssTouch then
    exit;

  MouseDown.X:=x;
  MouseDown.Y:=y;

  OldOffset.X:=xoffset;
  OldOffset.Y:=yoffset;

  if (OverBtn.Y>=zeilen.Value) or (OverBtn.X>=spalten.value) or (OverBtn.X<0) or (OverBtn.Y<0) then exit;

  if (SelectedBtn.X=OverBtn.X) and (SelectedBtn.Y=OverBtn.Y) then
  begin
    if mainform.UserAccessGranted(1, false) then
    begin
      Paintbox1.PopupMenu:=ButtonPopup;
      if mainform.PageControl1.ActivePageIndex=2 then
        mainform.Paintbox1.PopupMenu:=ButtonPopup;
    end else
    begin
      Paintbox1.PopupMenu:=nil;
      if mainform.PageControl1.ActivePageIndex=2 then
        mainform.Paintbox1.PopupMenu:=nil;
    end;
  end else
  begin
    Paintbox1.PopupMenu:=nil;
    if mainform.PageControl1.ActivePageIndex=2 then
      mainform.Paintbox1.PopupMenu:=nil;
  end;

  SelectedBtn.X:=OverBtn.X;
  SelectedBtn.Y:=OverBtn.Y;

  if (Shift=[ssLeft]) or (Shift=[ssRight]) then // nur, wenn kein Shift, Alt oder Strg
  begin
    if Button=mbLeft then
    begin
      BtnDown.Y:=OverBtn.Y;
      BtnDown.X:=OverBtn.X;

      case mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].Typ of
        0:  // Leer
        begin
        end;
        1:  // Szene
        begin
  //            mainform.StartScene(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID);
          if mainform.IsSceneActive(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID) then
            mainform.StopScene(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID) // Szene stoppen
          else
            mainform.StartScene(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID,false,false); // Szene starten
        end;
        2:  // Skript
        begin
          // SKRIPTABLAUF STARTEN
          if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pcdscrp') then
          begin
            StatusBar1.Panels.Items[2].Text:='Skriptabruf aus '+mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pcdscrp';
            listbox.Items.LoadFromFile(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pcdscrp');

            if listbox.items[0]<>inttostr(listbox.items.count-1) then
              begin
                listbox.items.clear;
                messagedlg(_('Sorry, fehlerhafte Skriptdatei!'),mtError,[mbOK],0);
              end
            else
              listbox.items.delete(0);

            listbox.itemindex:=0;
            if listbox.items.count>0 then
            begin
    //	        stop.Enabled:=true;
              RunSkript(Sender);
            end;
          end;
        end;
        3:
        begin
  //            mainform.StartEffekt(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID);
          if mainform.IsSceneActive(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID) then
            mainform.StopScene(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID) // Effekt stoppen
          else
            mainform.StartScene(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID,false,false); // Effekt starten
        end;
        4:  // Szene
        begin
          mainform.StartScene(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID,false,false);
        end;
        5:
        begin
          // Aktuelles Skript abbrechen
          // FLASHSKRIPT STARTEN
          if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pcdscrp') then
          begin
            repeatskript.checked:=true;
            StatusBar1.Panels.Items[2].Text:='Skriptabruf aus '+mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pcdscrp';
            listbox.Items.LoadFromFile(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pcdscrp');

            if listbox.items[0]<>inttostr(listbox.items.count-1) then
              begin
                listbox.items.clear;
                messagedlg(_('Sorry, fehlerhafte Skriptdatei!'),mtError,[mbOK],0);
              end
            else
              listbox.items.delete(0);

            listbox.itemindex:=0;
            if listbox.items.count>0 then
            begin
    //	        stop.Enabled:=true;
              RunSkript(Sender);
            end;
          end;
        end;
        6:
        begin
          mainform.StartScene(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID);
        end;
        7:
        begin
          if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pas') then
          begin
            StatusBar1.Panels.Items[2].Text:='Programmcode aus '+mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pas';
            listbox.Items.LoadFromFile(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pas');
            ScriptInterpreterCallingCodeSceneID:=StringToGUID('{22358076-6286-4327-BC85-2CAD7F1F7E14}'); // just a random ID to direct to nirvana
            ScriptInterpreter.Pas.Clear;
            ScriptInterpreter.Pas:=listbox.Items;
            ScriptInterpreter.Compile;
            ScriptInterpreterArgs.Count:=0;
            ScriptInterpreter.CallFunction('ButtonMouseDown',ScriptInterpreterArgs, []);
          end;
        end;
      end;
    end else
    begin
      if (mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].Typ=1) or (mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].Typ=3) then
        ndern1.Enabled:=true
      else
        ndern1.Enabled:=false;
      if mainform.UserAccessGranted(1, false) then
        ButtonPopup.AutoPopup:=true
      else
        ButtonPopup.AutoPopup:=false;
    end;
  end;
  StatusBar1.Panels.Items[0].Text:='Button '+inttostr(SelectedBtn.Y+1)+'x'+inttostr(SelectedBtn.X+1);
  buttonname.Text:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Name;
  buttonfarbe.Color:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Color;
  combobox1.ItemIndex:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Typ;
  HotKey1.HotKey:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Shortcut;
  mainform.buttonname.text:=buttonname.text;
  mainform.buttonfarbe.Color:=buttonfarbe.Color;
  mainform.ComboBox1.ItemIndex:=Combobox1.ItemIndex;
  mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Down:=true;

  CheckForActiveTimer(nil);

  if kontrollpanel.Showing then
    RedrawPanel;
  if mainform.PageControl1.ActivePageIndex=2 then
    RedrawMainformPanel;
end;

procedure Tkontrollpanel.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	k:integer;
  isaudioscene:boolean;
begin
  if not mainform.UserAccessGranted(3, false) then exit;

  ssTouch:=false;
  BtnDown.Y:=-1;
  BtnDown.X:=-1;

  if ((OverBtn.Y>=zeilen.value) or (OverBtn.X>=spalten.value) or (OverBtn.X<0) or (OverBtn.Y<0)) then exit;

  if (Shift=[ssShift]) then
  begin
    if Button=mbLeft then
    begin
      if not mainform.UserAccessGranted(2, false) then exit;

      OverBtn.Y:=trunc((Y-yoffset)/btnheight.value);
      OverBtn.X:=trunc((X-xoffset)/btnwidth.value);

      FlipButton(SelectedBtn.X, SelectedBtn.Y, OverBtn.X, OverBtn.Y);

      SelectedBtn.X:=OverBtn.X;
      SelectedBtn.Y:=OverBtn.Y;
    end;
  end else if (Shift=[ssCtrl]) then
  begin
    if Button=mbLeft then
    begin
      if not mainform.UserAccessGranted(2, false) then exit;

      OverBtn.Y:=trunc((Y-yoffset)/btnheight.value);
      OverBtn.X:=trunc((X-xoffset)/btnwidth.value);

      FlipLine(SelectedBtn.Y, OverBtn.Y);

      SelectedBtn.X:=OverBtn.X;
      SelectedBtn.Y:=OverBtn.Y;
    end;
  end else if (Shift=[]) then
  begin
    if Button=mbLeft then
    begin
      case mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].Typ of
      4:
      begin
        mainform.StopScene(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID);

        isaudioscene:=false;
        for k:=0 to length(mainform.audioszenen)-1 do
        begin
          if IsEqualGUID(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID,mainform.audioszenen[k].ID) then
          begin
            isaudioscene:=true;
            break;
          end;
        end;

        if (Shift=[]) and not isaudioscene then
          mainform.RestoreLastScene(0);
      end;
      5:
      begin
        // FLASHSKRIPT ABBRECHEN
        repeatskript.checked:=false;
        waitkey:=false;
        closing:=true;
        waitkey:=false;
        for k:=1 to mainform.lastchan do
        begin
          inprogram[k]:=false;
          mainform.data.ch[k]:=255-mainform.channel_value[k];
          mainform.Senddata(k,255-mainform.channel_value[k],255-mainform.channel_value[k],0);
        end;
      end;
      6:
      begin
        mainform.StopScene(mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].ID);
      end;
      7:
      begin
        if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pas') then
        begin
          StatusBar1.Panels.Items[2].Text:='Programmcode aus '+mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pas';
          listbox.Items.LoadFromFile(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1)+'.pas');
          ScriptInterpreterCallingCodeSceneID:=StringToGUID('{22358076-6286-4327-BC85-2CAD7F1F7E14}'); // just a random ID to direct to nirvana
          ScriptInterpreter.Pas.Clear;
          ScriptInterpreter.Pas:=listbox.Items;
          ScriptInterpreter.Compile;
          ScriptInterpreterArgs.Count:=0;
          ScriptInterpreter.CallFunction('ButtonMouseUp',ScriptInterpreterArgs, []);
        end;
      end;
      end;
    end;
    if Button=mbRight then
    begin
      SelectedBtn.Y:=OverBtn.Y;
      SelectedBtn.X:=OverBtn.X;
    end;
  end;

  StatusBar1.Panels.Items[0].Text:='Button '+inttostr(OverBtn.Y+1)+'x'+inttostr(OverBtn.X+1);
	buttonname.Text:=mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].Name;
  buttonfarbe.Color:=mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].color;
	combobox1.ItemIndex:=mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].typ;
  HotKey1.HotKey:=mainform.kontrollpanelbuttons[OverBtn.Y][OverBtn.X].shortcut;
  mainform.buttonname.text:=buttonname.text;
  mainform.buttonfarbe.Color:=buttonfarbe.Color;
  mainform.ComboBox1.ItemIndex:=Combobox1.ItemIndex;
  mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Down:=false;

  CheckForActiveTimer(nil);

  if kontrollpanel.Showing then
    RedrawPanel;
  if mainform.PageControl1.ActivePageIndex=2 then
    RedrawMainformPanel;
end;

procedure Tkontrollpanel.zeilenChange(Sender: TObject);
var
  i,j:integer;
  maxcol:integer;
begin
  mainform.zeilen.Value:=zeilen.value;
  mainform.spalten.Value:=spalten.value;

  if round(zeilen.Value)>length(mainform.kontrollpanelbuttons) then
  begin
    // Neue Buttons sollen hinzugefügt werden
    setlength(mainform.kontrollpanelbuttons, round(zeilen.value));

    maxcol:=0;
    for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
      if length(mainform.kontrollpanelbuttons[i])>maxcol then maxcol:=length(mainform.kontrollpanelbuttons[i]);

    for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
    begin
      setlength(mainform.kontrollpanelbuttons[i], maxcol);
      for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
      begin
        if (j<=LastColRows.X) then
          mainform.kontrollpanelbuttons[i][j].Visible:=true;
      end;
    end;

    // Neue Buttons initialisieren
    for i:=LastColRows.Y+1 to length(mainform.kontrollpanelbuttons)-1 do
    for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
    begin
      mainform.kontrollpanelbuttons[i][j].Name:='Button '+inttostr(i+1)+'x'+inttostr(j+1);
      mainform.kontrollpanelbuttons[i][j].Color:=clWhite;
      mainform.kontrollpanelbuttons[i][j].Typ:=0;
      mainform.kontrollpanelbuttons[i][j].Picture:=mainform.pcdimmerdirectory+'\Devicepictures\32 x 32\par56silber.png';

      if not Assigned(mainform.kontrollpanelbuttons[i][j].PNG) then
        mainform.kontrollpanelbuttons[i][j].PNG:=TPNGObject.Create;
      if FileExists(mainform.pcdimmerdirectory+'\Devicepictures\32 x 32\par56silber.png') then
        mainform.kontrollpanelbuttons[i][j].PNG.LoadFromFile(mainform.pcdimmerdirectory+'\Devicepictures\32 x 32\par56silber.png');
    end;
  end else
  begin
    // Buttonanzahl verringern
    for i:=0 to round(zeilen.Value)-1 do
    begin
      for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
      begin
        if (j<=LastColRows.X) then
          mainform.kontrollpanelbuttons[i][j].Visible:=true;
      end;
    end;

    for i:=round(zeilen.Value) to length(mainform.kontrollpanelbuttons)-1 do
    begin
      for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
      begin
        mainform.kontrollpanelbuttons[i][j].Visible:=false;
      end;
    end;
  end;

  LastColRows.X:=round(spalten.value)-1;
  LastColRows.Y:=round(zeilen.value)-1;

  mainform.kontrollpanelrecord.spaltenanzahl:=spalten.AsInteger-1;
	mainform.kontrollpanelrecord.zeilenanzahl:=zeilen.AsInteger-1;
end;

procedure Tkontrollpanel.spaltenChange(Sender: TObject);
var
  i,j,k:integer;
begin
  mainform.zeilen.Value:=zeilen.value;
  mainform.spalten.Value:=spalten.value;

  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
  begin
    if round(spalten.Value)>length(mainform.kontrollpanelbuttons[i]) then
    begin
      setlength(mainform.kontrollpanelbuttons[i], round(spalten.value));
      for j:=0 to round(spalten.Value)-1 do
      begin
        if (i<=LastColRows.Y) then
          mainform.kontrollpanelbuttons[i][j].Visible:=true;
      end;

      // Neue Buttons initialisieren
      for k:=0 to length(mainform.kontrollpanelbuttons)-1 do
      for j:=LastColRows.X+1 to length(mainform.kontrollpanelbuttons[k])-1 do
      begin
        mainform.kontrollpanelbuttons[k][j].Name:='Button '+inttostr(k+1)+'x'+inttostr(j+1);
        mainform.kontrollpanelbuttons[k][j].Color:=clWhite;
        mainform.kontrollpanelbuttons[k][j].Typ:=0;
        mainform.kontrollpanelbuttons[k][j].Picture:=mainform.pcdimmerdirectory+'\Devicepictures\32 x 32\par56silber.png';

      if not Assigned(mainform.kontrollpanelbuttons[k][j].PNG) then
        mainform.kontrollpanelbuttons[k][j].PNG:=TPNGObject.Create;
      if FileExists(mainform.pcdimmerdirectory+'\Devicepictures\32 x 32\par56silber.png') then
        mainform.kontrollpanelbuttons[k][j].PNG.LoadFromFile(mainform.pcdimmerdirectory+'\Devicepictures\32 x 32\par56silber.png');
      end;
    end else
    begin
      for j:=0 to round(spalten.value)-1 do
      begin
        if (i<=LastColRows.Y) then
          mainform.kontrollpanelbuttons[i][j].Visible:=true;
      end;

      for j:=round(spalten.value) to length(mainform.kontrollpanelbuttons[i])-1 do
      begin
        mainform.kontrollpanelbuttons[i][j].Visible:=false;
      end;
    end;
  end;

  LastColRows.X:=round(spalten.value)-1;
  LastColRows.Y:=round(zeilen.value)-1;

  mainform.kontrollpanelrecord.spaltenanzahl:=spalten.AsInteger-1;
	mainform.kontrollpanelrecord.zeilenanzahl:=zeilen.AsInteger-1;
end;

procedure Tkontrollpanel.PngBitBtn3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  yoffset:=0;
  xoffset:=0;
  RefreshTimerTimer(nil);
end;

procedure Tkontrollpanel.RedrawPanel;
var
  i,j:integer;
  textoffset:integer;
  text1,text2,text3:string;
  rect:Trect;
begin
  _Buffer.Canvas.Brush.Style:=bsSolid;
  _Buffer.Canvas.Brush.Color:=clBtnFace;
  _Buffer.Canvas.Pen.Style:=psClear;
  _Buffer.Canvas.Rectangle(0,0,_Buffer.Width,_Buffer.Height);

  _Buffer.Canvas.Pen.Color:=clBtnShadow;
  _Buffer.Canvas.Pen.Style:=psSolid;

  // Buttons mit Bild und Text zeichnen
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do // Zeilenanzahl
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do // Spaltenanzahl
  begin
    if ((yoffset+(i+1)*buttonheight)>_Buffer.Height) or ((xoffset+(j+1)*buttonwidth)>_Buffer.Width) or
    ((xoffset+j*buttonwidth)<0) or ((yoffset+i*buttonheight)<0) then continue;

    if not mainform.kontrollpanelbuttons[i][j].Visible then continue;

    _Buffer.Canvas.Brush.Color:=mainform.kontrollpanelbuttons[i][j].Color;

    //  _Buffer.Canvas.Rectangle(xoffset+j*buttonwidth, yoffset+i*buttonheight, xoffset+(j+1)*buttonwidth, yoffset+(i+1)*buttonheight);
    rect.Top:=yoffset+i*buttonheight;
    rect.Bottom:=yoffset+(i+1)*buttonheight-1;
    rect.Left:=xoffset+j*buttonwidth;
    rect.Right:=xoffset+(j+1)*buttonwidth;

    if (mainform.kontrollpanelbuttons[i][j].Active) or ((BtnDown.Y=i) and (BtnDown.X=j)) then
      buttonstyle:=1
    else
      buttonstyle:=0;
    DrawGradientH(_Buffer.Canvas,mainform.kontrollpanelbuttons[i][j].Color,UseGradient(mainform.kontrollpanelbuttons[i][j].Color,buttonstyle),rect);

    // Anzeige verändern, wenn Eigenschaft des Button aktiviert
    if mainform.kontrollpanelbuttons[i][j].Active then
    begin
      _Buffer.Canvas.Pen.Style:=psClear;
      _Buffer.Canvas.Brush.Color:=clRed;
      _Buffer.Canvas.Rectangle(xoffset+j*buttonwidth+2, yoffset+i*buttonheight+2, xoffset+(j+1)*buttonwidth-1, yoffset+i*buttonheight+8);
    end;
    _Buffer.Canvas.Brush.Style:=bsClear;

    _Buffer.Canvas.Font.Name:='Arial';
    _Buffer.Canvas.Font.Size:=8;
    if mainform.kontrollpanelbuttons[i][j].Active then
    begin
      _Buffer.Canvas.Font.Style:=[fsBold];
      _Buffer.Canvas.Font.Color:=clGreen;
    end else
    begin
      _Buffer.Canvas.Font.Style:=[];
      _Buffer.Canvas.Font.Color:=clBlack;
    end;
    text1:=copy(mainform.kontrollpanelbuttons[i][j].Name, 1, 10);
    text2:=copy(mainform.kontrollpanelbuttons[i][j].Name, 11, 10);
    text3:=copy(mainform.kontrollpanelbuttons[i][j].Name, 21, 10);

    if (BtnDown.Y=i) and (BtnDown.X=j) then
      textoffset:=1
    else
      textoffset:=0;

    if Assigned(mainform.kontrollpanelbuttons[i][j].PNG) and (mainform.kontrollpanelbuttons[i][j].Picture<>'') and showiconsbtn.Checked then
    begin
      // Bild zeichnen
      rect.Top:=textoffset+yoffset+i*buttonheight+10;
      rect.Bottom:=textoffset+yoffset+i*buttonheight+10+mainform.kontrollpanelbuttons[i][j].PNG.Height;
      rect.Left:=textoffset+xoffset+j*buttonwidth+8;
      rect.Right:=textoffset+xoffset+j*buttonwidth+8+mainform.kontrollpanelbuttons[i][j].PNG.Width;
      mainform.kontrollpanelbuttons[i][j].PNG.Draw(_Buffer.Canvas, rect);

      _Buffer.Canvas.TextOut(textoffset+xoffset+(j+1)*buttonwidth-_Buffer.Canvas.TextWidth(text1)-5, textoffset+yoffset+i*buttonheight+5, text1);
      _Buffer.Canvas.TextOut(textoffset+xoffset+(j+1)*buttonwidth-_Buffer.Canvas.TextWidth(text2)-5, textoffset+yoffset+i*buttonheight+17, text2);
      _Buffer.Canvas.TextOut(textoffset+xoffset+(j+1)*buttonwidth-_Buffer.Canvas.TextWidth(text3)-5, textoffset+yoffset+i*buttonheight+29, text3);
    end else
    begin
      _Buffer.Canvas.TextOut(round(textoffset+xoffset+(j+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text1)/2), textoffset+yoffset+i*buttonheight+5, text1);
      _Buffer.Canvas.TextOut(round(textoffset+xoffset+(j+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text2)/2), textoffset+yoffset+i*buttonheight+17, text2);
      _Buffer.Canvas.TextOut(round(textoffset+xoffset+(j+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text3)/2), textoffset+yoffset+i*buttonheight+29, text3);
    end;

    _Buffer.Canvas.Font.Size:=7;
    _Buffer.Canvas.TextOut(xoffset+j*buttonwidth+3, yoffset+(i+1)*buttonheight-15, mainform.kontrollpanelbuttons[i][j].TypName);
  end;

  // Striche für 3D-Effekt zeichnen (weiß)
  _Buffer.Canvas.Pen.Style:=psSolid;
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do // Zeilenanzahl
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do // Spaltenanzahl
  begin
    if ((yoffset+(i+1)*buttonheight)>_Buffer.Height) or ((xoffset+(j+1)*buttonwidth)>_Buffer.Width) or
    ((xoffset+j*buttonwidth)<0) or ((yoffset+i*buttonheight)<0) then continue;

    if not mainform.kontrollpanelbuttons[i][j].Visible then continue;

    if (BtnDown.Y=i) and (BtnDown.X=j) then
      _Buffer.Canvas.Pen.Color:=clOlive
    else
    begin
      if (OverBtn.Y=i) and (OverBtn.X=j) then
      begin
        if mainform.kontrollpanelbuttons[i][j].Active then
          _Buffer.Canvas.Pen.Color:=clOlive
        else
          _Buffer.Canvas.Pen.Color:=clYellow;
      end else
      begin
        if mainform.kontrollpanelbuttons[i][j].Active then
          _Buffer.Canvas.Pen.Color:=clBtnShadow
        else
          _Buffer.Canvas.Pen.Color:=clWhite;
      end;
    end;

    // horizontal               X               Y
    _Buffer.Canvas.MoveTo(xoffset+j*buttonwidth, yoffset+i*buttonheight);
    _Buffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-1, yoffset+i*buttonheight);
    _Buffer.Canvas.MoveTo(xoffset+j*buttonwidth, yoffset+i*buttonheight+1);
    _Buffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-2, yoffset+i*buttonheight+1);

    // vertikal                 X               Y
    _Buffer.Canvas.MoveTo(xoffset+j*buttonwidth, yoffset+i*buttonheight);
    _Buffer.Canvas.LineTo(xoffset+j*buttonwidth, yoffset+(i+1)*buttonheight-1);
    _Buffer.Canvas.MoveTo(xoffset+j*buttonwidth+1, yoffset+i*buttonheight);
    _Buffer.Canvas.LineTo(xoffset+j*buttonwidth+1, yoffset+(i+1)*buttonheight-2);
  end;

  // Striche für 3D-Effekt zeichnen (dunkel)
  _Buffer.Canvas.Pen.Style:=psSolid;
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do // Zeilenanzahl
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do // Spaltenanzahl
  begin
    if ((yoffset+(i+1)*buttonheight)>_Buffer.Height) or ((xoffset+(j+1)*buttonwidth)>_Buffer.Width) or
    ((xoffset+j*buttonwidth)<0) or ((yoffset+i*buttonheight)<0) then continue;

    if not mainform.kontrollpanelbuttons[i][j].Visible then continue;

    if (BtnDown.Y=i) and (BtnDown.X=j) then
      _Buffer.Canvas.Pen.Color:=clYellow
    else
    begin
      if (OverBtn.Y=i) and (OverBtn.X=j) then
      begin
        if mainform.kontrollpanelbuttons[i][j].Active then
          _Buffer.Canvas.Pen.Color:=clYellow
        else
          _Buffer.Canvas.Pen.Color:=clOlive;
      end else
      begin
        if mainform.kontrollpanelbuttons[i][j].Active then
          _Buffer.Canvas.Pen.Color:=clWhite
        else
          _Buffer.Canvas.Pen.Color:=clBtnShadow;
      end;
    end;

    // horizontal               X               Y
    _Buffer.Canvas.MoveTo(xoffset+j*buttonwidth+1, yoffset+(i+1)*buttonheight-2);
    _Buffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-1, yoffset+(i+1)*buttonheight-2);
    _Buffer.Canvas.MoveTo(xoffset+j*buttonwidth, yoffset+(i+1)*buttonheight-1);
    _Buffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-1, yoffset+(i+1)*buttonheight-1);

    // vertikal                 X               Y
    _Buffer.Canvas.MoveTo(xoffset+(j+1)*buttonwidth-2, yoffset+i*buttonheight+1);
    _Buffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-2, yoffset+(i+1)*buttonheight-1);
    _Buffer.Canvas.MoveTo(xoffset+(j+1)*buttonwidth-1, yoffset+i*buttonheight);
    _Buffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-1, yoffset+(i+1)*buttonheight-1);
  end;

  if Extrahighlight>0 then
  begin
    for i:=0 to length(mainform.kontrollpanelbuttons)-1 do // Zeilenanzahl
    for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do // Spaltenanzahl
    begin
      if (SelectedBtn.Y=i) then
      begin
        if ((Extrahighlight=1) and (SelectedBtn.X=j)) or (Extrahighlight=2) then
        begin
          rect.Top:=yoffset+i*buttonheight;
          rect.Bottom:=yoffset+(i+1)*buttonheight-1;
          rect.Left:=xoffset+j*buttonwidth;
          rect.Right:=xoffset+(j+1)*buttonwidth;
          DrawGradientH(_Buffer.Canvas,clOlive,UseGradient(clOlive,buttonstyle),rect);
        end;
      end;

      if (OverBtn.Y=i) then
      begin
        if ((Extrahighlight=1) and (OverBtn.X=j)) or (Extrahighlight=2) then
        begin
          rect.Top:=yoffset+i*buttonheight;
          rect.Bottom:=yoffset+(i+1)*buttonheight-1;
          rect.Left:=xoffset+j*buttonwidth;
          rect.Right:=xoffset+(j+1)*buttonwidth;
          DrawGradientH(_Buffer.Canvas,clLime,UseGradient(clLime,buttonstyle),rect);
        end;
      end;
    end;
  end;

  // Punktierten Rahmen des markierten Buttons zeichen
  _Buffer.Canvas.Brush.Style:=bsClear;
  _Buffer.Canvas.Pen.Color:=clBlack;
  _Buffer.Canvas.Pen.Style:=psDot;
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do // Zeilenanzahl
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do // Spaltenanzahl
  if (SelectedBtn.Y=i) and (SelectedBtn.X=j) then
  begin
    if ((yoffset+(i+1)*buttonheight)>_Buffer.Height) or ((xoffset+(j+1)*buttonwidth)>_Buffer.Width) or
    ((xoffset+j*buttonwidth)<0) or ((yoffset+i*buttonheight)<0) then continue;

    if not mainform.kontrollpanelbuttons[i][j].Visible then continue;

    _Buffer.Canvas.Rectangle(xoffset+j*buttonwidth+5, yoffset+i*buttonheight+5, xoffset+(j+1)*buttonwidth-5, yoffset+(i+1)*buttonheight-5);
    break;
  end;

  BitBlt(Paintbox1.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Tkontrollpanel.RedrawMainformPanel;
var
  i,j:integer;
  buttonwidth, buttonheight, textoffset:integer;
  text1,text2,text3:string;
  rect:Trect;
begin
  if mainform.PageControl1.ActivePageIndex<>2 then exit;

  buttonwidth:=round(btnwidth.value);
  buttonheight:=round(btnheight.value);

  mainform._MainformPreBuffer.Canvas.Brush.Style:=bsSolid;
  mainform._MainformPreBuffer.Canvas.Brush.Color:=clBtnFace;
  mainform._MainformPreBuffer.Canvas.Pen.Style:=psClear;
  mainform._MainformPreBuffer.Canvas.Rectangle(0,0,mainform._MainformPreBuffer.Width,mainform._MainformPreBuffer.Height);

  mainform._MainformPreBuffer.Canvas.Pen.Color:=clBtnShadow;
  mainform._MainformPreBuffer.Canvas.Pen.Style:=psSolid;

  // Buttons mit Bild und Text zeichnen
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do // Zeilenanzahl
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do // Spaltenanzahl
  begin
    if ((yoffset+(i+1)*buttonheight)>mainform._MainformPreBuffer.Height) or ((xoffset+(j+1)*buttonwidth)>mainform._MainformPreBuffer.Width) or
    ((xoffset+j*buttonwidth)<0) or ((yoffset+i*buttonheight)<0) then continue;

    if not mainform.kontrollpanelbuttons[i][j].Visible then continue;

    mainform._MainformPreBuffer.Canvas.Brush.Color:=mainform.kontrollpanelbuttons[i][j].Color;

    //  mainform._MainformPreBuffer.Canvas.Rectangle(xoffset+j*buttonwidth, yoffset+i*buttonheight, xoffset+(j+1)*buttonwidth, yoffset+(i+1)*buttonheight);
    rect.Top:=yoffset+i*buttonheight;
    rect.Bottom:=yoffset+(i+1)*buttonheight-1;
    rect.Left:=xoffset+j*buttonwidth;
    rect.Right:=xoffset+(j+1)*buttonwidth;

    if (mainform.kontrollpanelbuttons[i][j].Active) or ((BtnDown.Y=i) and (BtnDown.X=j)) then
      buttonstyle:=1
    else
      buttonstyle:=0;
    DrawGradientH(mainform._MainformPreBuffer.Canvas,mainform.kontrollpanelbuttons[i][j].Color,UseGradient(mainform.kontrollpanelbuttons[i][j].Color,buttonstyle),rect);

    // Anzeige verändern, wenn Eigenschaft des Button aktiviert
    if mainform.kontrollpanelbuttons[i][j].Active then
    begin
      mainform._MainformPreBuffer.Canvas.Pen.Style:=psClear;
      mainform._MainformPreBuffer.Canvas.Brush.Color:=clRed;
      mainform._MainformPreBuffer.Canvas.Rectangle(xoffset+j*buttonwidth+2, yoffset+i*buttonheight+2, xoffset+(j+1)*buttonwidth-1, yoffset+i*buttonheight+8);
    end;
    mainform._MainformPreBuffer.Canvas.Brush.Style:=bsClear;

    mainform._MainformPreBuffer.Canvas.Font.Name:='Arial';
    mainform._MainformPreBuffer.Canvas.Font.Size:=8;
    if mainform.kontrollpanelbuttons[i][j].Active then
    begin
      mainform._MainformPreBuffer.Canvas.Font.Style:=[fsBold];
      mainform._MainformPreBuffer.Canvas.Font.Color:=clGreen;
    end else
    begin
      mainform._MainformPreBuffer.Canvas.Font.Style:=[];
      mainform._MainformPreBuffer.Canvas.Font.Color:=clBlack;
    end;
    text1:=copy(mainform.kontrollpanelbuttons[i][j].Name, 1, 10);
    text2:=copy(mainform.kontrollpanelbuttons[i][j].Name, 11, 10);
    text3:=copy(mainform.kontrollpanelbuttons[i][j].Name, 21, 10);

    if (BtnDown.Y=i) and (BtnDown.X=j) then
      textoffset:=1
    else
      textoffset:=0;

    if Assigned(mainform.kontrollpanelbuttons[i][j].PNG) and (mainform.kontrollpanelbuttons[i][j].Picture<>'') and showiconsbtn.Checked then
    begin
      // Bild zeichnen
      rect.Top:=textoffset+yoffset+i*buttonheight+10;
      rect.Bottom:=textoffset+yoffset+i*buttonheight+10+mainform.kontrollpanelbuttons[i][j].PNG.Height;
      rect.Left:=textoffset+xoffset+j*buttonwidth+8;
      rect.Right:=textoffset+xoffset+j*buttonwidth+8+mainform.kontrollpanelbuttons[i][j].PNG.Width;
      mainform.kontrollpanelbuttons[i][j].PNG.Draw(mainform._MainformPreBuffer.Canvas, rect);

      mainform._MainformPreBuffer.Canvas.TextOut(textoffset+xoffset+(j+1)*buttonwidth-mainform._MainformPreBuffer.Canvas.TextWidth(text1)-5, textoffset+yoffset+i*buttonheight+5, text1);
      mainform._MainformPreBuffer.Canvas.TextOut(textoffset+xoffset+(j+1)*buttonwidth-mainform._MainformPreBuffer.Canvas.TextWidth(text2)-5, textoffset+yoffset+i*buttonheight+17, text2);
      mainform._MainformPreBuffer.Canvas.TextOut(textoffset+xoffset+(j+1)*buttonwidth-mainform._MainformPreBuffer.Canvas.TextWidth(text3)-5, textoffset+yoffset+i*buttonheight+29, text3);
    end else
    begin
      mainform._MainformPreBuffer.Canvas.TextOut(round(textoffset+xoffset+(j+1)*buttonwidth-buttonwidth/2-mainform._MainformPreBuffer.Canvas.TextWidth(text1)/2), textoffset+yoffset+i*buttonheight+5, text1);
      mainform._MainformPreBuffer.Canvas.TextOut(round(textoffset+xoffset+(j+1)*buttonwidth-buttonwidth/2-mainform._MainformPreBuffer.Canvas.TextWidth(text2)/2), textoffset+yoffset+i*buttonheight+17, text2);
      mainform._MainformPreBuffer.Canvas.TextOut(round(textoffset+xoffset+(j+1)*buttonwidth-buttonwidth/2-mainform._MainformPreBuffer.Canvas.TextWidth(text3)/2), textoffset+yoffset+i*buttonheight+29, text3);
    end;

    mainform._MainformPreBuffer.Canvas.Font.Size:=7;
    mainform._MainformPreBuffer.Canvas.TextOut(xoffset+j*buttonwidth+3, yoffset+(i+1)*buttonheight-15, mainform.kontrollpanelbuttons[i][j].TypName);
  end;

  // Striche für 3D-Effekt zeichnen (weiß)
  mainform._MainformPreBuffer.Canvas.Pen.Style:=psSolid;
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do // Zeilenanzahl
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do // Spaltenanzahl
  begin
    if ((yoffset+(i+1)*buttonheight)>mainform._MainformPreBuffer.Height) or ((xoffset+(j+1)*buttonwidth)>mainform._MainformPreBuffer.Width) or
    ((xoffset+j*buttonwidth)<0) or ((yoffset+i*buttonheight)<0) then continue;

    if not mainform.kontrollpanelbuttons[i][j].Visible then continue;

    if (BtnDown.Y=i) and (BtnDown.X=j) then
      mainform._MainformPreBuffer.Canvas.Pen.Color:=clOlive
    else
    begin
      if (OverBtn.Y=i) and (OverBtn.X=j) then
      begin
        if mainform.kontrollpanelbuttons[i][j].Active then
          mainform._MainformPreBuffer.Canvas.Pen.Color:=clOlive
        else
          mainform._MainformPreBuffer.Canvas.Pen.Color:=clYellow;
      end else
      begin
        if mainform.kontrollpanelbuttons[i][j].Active then
          mainform._MainformPreBuffer.Canvas.Pen.Color:=clBtnShadow
        else
          mainform._MainformPreBuffer.Canvas.Pen.Color:=clWhite;
      end;
    end;

    // horizontal               X               Y
    mainform._MainformPreBuffer.Canvas.MoveTo(xoffset+j*buttonwidth, yoffset+i*buttonheight);
    mainform._MainformPreBuffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-1, yoffset+i*buttonheight);
    mainform._MainformPreBuffer.Canvas.MoveTo(xoffset+j*buttonwidth, yoffset+i*buttonheight+1);
    mainform._MainformPreBuffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-2, yoffset+i*buttonheight+1);

    // vertikal                 X               Y
    mainform._MainformPreBuffer.Canvas.MoveTo(xoffset+j*buttonwidth, yoffset+i*buttonheight);
    mainform._MainformPreBuffer.Canvas.LineTo(xoffset+j*buttonwidth, yoffset+(i+1)*buttonheight-1);
    mainform._MainformPreBuffer.Canvas.MoveTo(xoffset+j*buttonwidth+1, yoffset+i*buttonheight);
    mainform._MainformPreBuffer.Canvas.LineTo(xoffset+j*buttonwidth+1, yoffset+(i+1)*buttonheight-2);
  end;

  // Striche für 3D-Effekt zeichnen (dunkel)
  mainform._MainformPreBuffer.Canvas.Pen.Style:=psSolid;
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do // Zeilenanzahl
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do // Spaltenanzahl
  begin
    if ((yoffset+(i+1)*buttonheight)>mainform._MainformPreBuffer.Height) or ((xoffset+(j+1)*buttonwidth)>mainform._MainformPreBuffer.Width) or
    ((xoffset+j*buttonwidth)<0) or ((yoffset+i*buttonheight)<0) then continue;

    if not mainform.kontrollpanelbuttons[i][j].Visible then continue;

    if (BtnDown.Y=i) and (BtnDown.X=j) then
      mainform._MainformPreBuffer.Canvas.Pen.Color:=clYellow
    else
    begin
      if (OverBtn.Y=i) and (OverBtn.X=j) then
      begin
        if mainform.kontrollpanelbuttons[i][j].Active then
          mainform._MainformPreBuffer.Canvas.Pen.Color:=clYellow
        else
          mainform._MainformPreBuffer.Canvas.Pen.Color:=clOlive;
      end else
      begin
        if mainform.kontrollpanelbuttons[i][j].Active then
          mainform._MainformPreBuffer.Canvas.Pen.Color:=clWhite
        else
          mainform._MainformPreBuffer.Canvas.Pen.Color:=clBtnShadow;
      end;
    end;

    // horizontal               X               Y
    mainform._MainformPreBuffer.Canvas.MoveTo(xoffset+j*buttonwidth+1, yoffset+(i+1)*buttonheight-2);
    mainform._MainformPreBuffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-1, yoffset+(i+1)*buttonheight-2);
    mainform._MainformPreBuffer.Canvas.MoveTo(xoffset+j*buttonwidth, yoffset+(i+1)*buttonheight-1);
    mainform._MainformPreBuffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-1, yoffset+(i+1)*buttonheight-1);

    // vertikal                 X               Y
    mainform._MainformPreBuffer.Canvas.MoveTo(xoffset+(j+1)*buttonwidth-2, yoffset+i*buttonheight+1);
    mainform._MainformPreBuffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-2, yoffset+(i+1)*buttonheight-1);
    mainform._MainformPreBuffer.Canvas.MoveTo(xoffset+(j+1)*buttonwidth-1, yoffset+i*buttonheight);
    mainform._MainformPreBuffer.Canvas.LineTo(xoffset+(j+1)*buttonwidth-1, yoffset+(i+1)*buttonheight-1);
  end;

  // Punktierten Rahmen des markierten Buttons zeichen
  mainform._MainformPreBuffer.Canvas.Brush.Style:=bsClear;
  mainform._MainformPreBuffer.Canvas.Pen.Color:=clBlack;
  mainform._MainformPreBuffer.Canvas.Pen.Style:=psDot;
  for i:=0 to length(mainform.kontrollpanelbuttons)-1 do // Zeilenanzahl
  for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do // Spaltenanzahl
  if (SelectedBtn.Y=i) and (SelectedBtn.X=j) then
  begin
    if ((yoffset+(i+1)*buttonheight)>mainform._MainformPreBuffer.Height) or ((xoffset+(j+1)*buttonwidth)>mainform._MainformPreBuffer.Width) or
    ((xoffset+j*buttonwidth)<0) or ((yoffset+i*buttonheight)<0) then continue;

    if not mainform.kontrollpanelbuttons[i][j].Visible then continue;

    mainform._MainformPreBuffer.Canvas.Rectangle(xoffset+j*buttonwidth+5, yoffset+i*buttonheight+5, xoffset+(j+1)*buttonwidth-5, yoffset+(i+1)*buttonheight-5);
    break;
  end;
  mainform.RefreshMainformScreen:=true;
end;

procedure Tkontrollpanel.Bildndern1Click(Sender: TObject);
begin
  picturechangeform.aktuellebilddatei:=mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Picture;
  picturechangeform.Showmodal;
  if (picturechangeform.ModalResult=mrOK) and FileExists(picturechangeform.aktuellebilddatei) then
  begin
    mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Picture:=picturechangeform.aktuellebilddatei;

    mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].PNG.Free;
    mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].PNG:=nil;
    mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].PNG:=TPNGObject.Create;
    mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].PNG.LoadFromFile(mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Picture);
  end;
end;

procedure Tkontrollpanel.Bildlschen1Click(Sender: TObject);
begin
  mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].Picture:='';
  mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].PNG.Free;
  mainform.kontrollpanelbuttons[SelectedBtn.Y][SelectedBtn.X].PNG:=nil;
end;

procedure Tkontrollpanel.buttonstyledarkClick(Sender: TObject);
begin
  if buttonstyledark.checked then buttonstyle:=0 else buttonstyle:=1;
end;

procedure Tkontrollpanel.PaintBox1Paint(Sender: TObject);
begin
//  Counter:=251;
//  RefreshTimer.Interval:=mainform.Rfr_Kontrollpanel;
end;

procedure Tkontrollpanel.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize:=(NewHeight>250) and (NewWidth>250)
end;

procedure Tkontrollpanel.WMTouch(var Msg: TMessage);
  function TouchPointToPoint(const TouchPoint: TTouchInput): TPoint;
  begin
    Result := Point(TouchPoint.X div 100, TouchPoint.Y div 100);
    PhysicalToLogicalPointFn(Handle, Result);
    Result := ScreenToClient(Result);
  end ;
var
  TouchInputs: array of TTouchInput;
  counter: Integer;
  Handled: Boolean;
begin
  Handled := False;
  if not bTouchGestureAPIPresent then Exit;

  SetLength(TouchInputs, Msg.WParam);
  GetTouchInputInfoFn(Msg.LParam, Msg.WParam, @TouchInputs[0], SizeOf(TTouchInput));

  try
    for counter := 1 to Length (TouchInputs) do
    begin
      MyTouchPoint := TouchPointToPoint(TouchInputs [counter-1]);
      if not ssTouch then
      begin
        //mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_MOVE, MyTouchPoint.x-5, MyTouchPoint.y-5, 0, 0);
        //mouse_event(MOUSEEVENTF_LEFTDOWN, MyTouchPoint.x, MyTouchPoint.y-Panel1.Height-TBToolbar1.Height, 0, 0);

        // anhand Position aktuellen Button highlighten
        if panel1.Visible then
        begin
          OverBtn.Y:=trunc(((MyTouchPoint.y-Panel1.Height-TBToolbar1.Height)-yoffset)/btnheight.value);
        end else
        begin
          OverBtn.Y:=trunc(((MyTouchPoint.y-TBToolbar1.Height)-yoffset)/btnheight.value);
        end;
        OverBtn.X:=trunc(((MyTouchPoint.x)-xoffset)/btnwidth.value);

        // MouseDown-Event ausführen
        if panel1.Visible then
        begin
          Paintbox1MouseDown(Paintbox1, mbLeft, [ssLeft], MyTouchPoint.x, MyTouchPoint.y-Panel1.Height-TBToolbar1.Height);
        end else
        begin
          Paintbox1MouseDown(Paintbox1, mbLeft, [ssLeft], MyTouchPoint.x, MyTouchPoint.y-TBToolbar1.Height);
        end;

        // Verhindern, dass Paintbox1MouseDown ein weiteres mal ausgeführt wird, bevor nicht ein MouseUp-Event getriggert wird
        ssTouch:=true;
      end;
    end;
    Handled := True;
  finally
    if Handled then CloseTouchInputHandleFn(Msg.LParam)
      else inherited ;
  end;
end;

procedure Tkontrollpanel.WMGestureNotify( var Msg: TWMGestureNotify);
begin
  Msg.Result := DefWindowProc( Handle, Msg.Msg, Msg.Unused, Longint(Msg.NotifyStruct));
end;

procedure Tkontrollpanel.WMGesture(var Msg: TMessage);
var
  gi:TGestureInfo;
  bResult,bHandled:BOOL;
  L:Integer;
//  ptZoomCenterX,ptZoomCenterY,K,angle:Single; _ptSecond:TPoint;
  MyTouchPoint:TPoint;
begin
  bHandled:= False;
  if bTouchGestureAPIPresent then
    begin
      L:=SizeOf(gi);
      FillChar(gi,L,#0);
      gi.cbSize := L;
      bResult := GetGestureInfoFn(Msg.lParam , gi); // retrieve gesture info with lParam 

      if bResult then
        begin
          bHandled:=True;
          case gi.dwID of
            GID_BEGIN:
            begin
              MyTouchPoint.x := gi.ptsLocation.x;
              MyTouchPoint.y := gi.ptsLocation.y;
              MyTouchPoint   := ScreenToClient(MyTouchPoint);
              StartTouchEvent(MyTouchPoint.x, MyTouchPoint.y);
            end;
            GID_END:
            begin
              MyTouchPoint.x := gi.ptsLocation.x;
              MyTouchPoint.y := gi.ptsLocation.y;
              MyTouchPoint   := ScreenToClient(MyTouchPoint);
              EndTouchEvent(MyTouchPoint.x, MyTouchPoint.y);
            end;
            GID_PAN:
            begin
              MyTouchPoint.x := gi.ptsLocation.x;
              MyTouchPoint.y := gi.ptsLocation.y;
              MyTouchPoint   := ScreenToClient(MyTouchPoint);
              UpdateTouchEvent(1, MyTouchPoint.x, MyTouchPoint.y);

{
              if gi.dwFlags=GF_Begin then
                begin
                  f_ptFirst.x := gi.ptsLocation.x;
                  f_ptFirst.y := gi.ptsLocation.y;
                  f_ptFirst   := ScreenToClient(f_ptFirst);
                end
                else begin // read the second point (middle between fingers in the position)
                  _ptSecond.x := gi.ptsLocation.x;
                  _ptSecond.y := gi.ptsLocation.y;
                  _ptSecond   := ScreenToClient(_ptSecond);
                  //ProcessGestureMove(_ptSecond.x-f_ptFirst.x,_ptSecond.y-f_ptFirst.y);
                  f_ptFirst := _ptSecond;      //save
                end;
}
            end;
            GID_ZOOM:
            begin
              MyTouchPoint.x := gi.ptsLocation.x;
              MyTouchPoint.y := gi.ptsLocation.y;
              MyTouchPoint   := ScreenToClient(MyTouchPoint);
              UpdateTouchEvent(2, MyTouchPoint.x, MyTouchPoint.y);

{
              if gi.dwFlags=GF_Begin then
                begin
                  f_ptFirst.x   := gi.ptsLocation.x;
                  f_ptFirst.y   := gi.ptsLocation.y;
                  f_ptFirst     := ScreenToClient(f_ptFirst);
                  f_dwArguments := gi.ullArguments;
                end
                else begin
                  _ptSecond.x := gi.ptsLocation.x;
                  _ptSecond.y := gi.ptsLocation.y;
                  _ptSecond   := ScreenToClient(_ptSecond);
                  ptZoomCenterX := (f_ptFirst.x + _ptSecond.x)/2;
                  ptZoomCenterY := (f_ptFirst.y + _ptSecond.y)/2;
                  k := gi.ullArguments/f_dwArguments;
                  //ProcessGestureZoom(k,ptZoomCenterX,ptZoomCenterY);
                  f_ptFirst     := _ptSecond;
                  f_dwArguments := gi.ullArguments;
                end;
}
            end;
            GID_ROTATE:
            begin
              MyTouchPoint.x := gi.ptsLocation.x;
              MyTouchPoint.y := gi.ptsLocation.y;
              MyTouchPoint   := ScreenToClient(MyTouchPoint);
              UpdateTouchEvent(3, MyTouchPoint.x, MyTouchPoint.y);

{
              if gi.dwFlags=GF_BEGIN then
                f_dwArguments := 0
              else begin
                f_ptFirst.x := gi.ptsLocation.x;
                f_ptFirst.y := gi.ptsLocation.y;
                f_ptFirst   := ScreenToClient(f_ptFirst);
                angle := GID_ROTATE_ANGLE_FROM_ARGUMENT(LODWORD(gi.ullArguments))-GID_ROTATE_ANGLE_FROM_ARGUMENT(f_dwArguments);
                //ProcessGestureRotate( angle,f_ptFirst.x,f_ptFirst.y);  //angle in radians
                f_dwArguments := LODWORD(gi.ullArguments);            //save previous
              end;
}
            end;
            GID_TWOFINGERTAP:
            begin
              MyTouchPoint.x := gi.ptsLocation.x;
              MyTouchPoint.y := gi.ptsLocation.y;
              MyTouchPoint   := ScreenToClient(MyTouchPoint);
              UpdateTouchEvent(4, MyTouchPoint.x, MyTouchPoint.y);   // 2 finger tap
            end;
            GID_PRESSANDTAP:
            begin
              MyTouchPoint.x := gi.ptsLocation.x;
              MyTouchPoint.y := gi.ptsLocation.y;
              MyTouchPoint   := ScreenToClient(MyTouchPoint);
              UpdateTouchEvent(5, MyTouchPoint.x, MyTouchPoint.y);   // press n tap
            end;
          else bHandled:= False;
          end;
        end else
        begin //GetGestureInfo failed
          //dwError := GetLastError;
          // Handle dwError ??
        end;

      CloseGestureInfoHandleFn(Msg.lParam);
    end else
    begin
      // no Touch API Present
    end;
  if bHandled then Msg.Result := 0
    else Msg.Result := DefWindowProc(Handle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

procedure Tkontrollpanel.WMTabletFlick( var Msg: TMessage);
begin
  Msg.Result := DefWindowProc(Handle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

procedure Tkontrollpanel.StartTouchEvent(X, Y: integer);
begin
  LastTouchEvent:=-1; // Start
end;

procedure Tkontrollpanel.UpdateTouchEvent(Event, X, Y: integer);
begin
  if LastTouchEvent=-1 then
  begin
    // Etwas mit dem jeweiligen Event beginnen
    case Event of
      1: ; // PAN
      2: ; // ZOOM
      3: ; // ROTATE
      4: ; // 2-Finger-Tap
      5: // Press + Tap -> MouseDown()
      begin
        //mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_MOVE, X, Y, 0, 0);
        mouse_event(MOUSEEVENTF_LEFTDOWN, X, Y, 0, 0);
      end;
    end;
  end;

  LastTouchEvent:=Event;
end;

procedure Tkontrollpanel.EndTouchEvent(X, Y: integer);
begin
  case LastTouchEvent of
    1: ; // PAN
    2: ; // ZOOM
    3: ; // ROTATE
    4: ; // 2-Finger-Tap
    5: // Press + Tap -> MouseUp()
    begin
      mouse_event(MOUSEEVENTF_LEFTUP, X, Y, 0, 0);
    end;
  end;
end;

procedure Tkontrollpanel.TestAccessLevelTimerTimer(Sender: TObject);
var
  AccessGranted:boolean;
begin
  TestAccessLevelTimer.Enabled:=false;

  AccessGranted:=mainform.UserAccessGranted(1, false);
  
  if not AccessGranted then Panel1.Visible:=false;
  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;

  If not AccessGranted then
    Paintbox1.PopupMenu:=nil;

  TBDock1.Visible:=AccessGranted;
end;

procedure Tkontrollpanel.CopyButton(SourceX, SourceY, DestinationX, DestinationY: integer);
begin
  if (SourceX>-1) and (SourceY>-1) and (DestinationX>-1) and (DestinationY>-1) and
    (SourceY<length(mainform.kontrollpanelbuttons)) and (SourceX<length(mainform.kontrollpanelbuttons[SourceY])) and
    (DestinationY<length(mainform.kontrollpanelbuttons)) and (DestinationX<length(mainform.kontrollpanelbuttons[DestinationY])) then
  begin
    mainform.kontrollpanelbuttons[DestinationY][DestinationX].ID:=mainform.kontrollpanelbuttons[SourceY][SourceX].ID;
    mainform.kontrollpanelbuttons[DestinationY][DestinationX].Name:=mainform.kontrollpanelbuttons[SourceY][SourceX].Name;
    mainform.kontrollpanelbuttons[DestinationY][DestinationX].TypName:=mainform.kontrollpanelbuttons[SourceY][SourceX].TypName;
    mainform.kontrollpanelbuttons[DestinationY][DestinationX].Color:=mainform.kontrollpanelbuttons[SourceY][SourceX].Color;
    mainform.kontrollpanelbuttons[DestinationY][DestinationX].Typ:=mainform.kontrollpanelbuttons[SourceY][SourceX].Typ;
    mainform.kontrollpanelbuttons[DestinationY][DestinationX].Time:=mainform.kontrollpanelbuttons[SourceY][SourceX].Time;
    mainform.kontrollpanelbuttons[DestinationY][DestinationX].Shortcut:=mainform.kontrollpanelbuttons[SourceY][SourceX].ShortCut;

    mainform.kontrollpanelbuttons[DestinationY][DestinationX].Picture:=mainform.kontrollpanelbuttons[SourceY][SourceX].Picture;
    mainform.kontrollpanelbuttons[DestinationY][DestinationX].PNG.Free;
    mainform.kontrollpanelbuttons[DestinationY][DestinationX].PNG:=nil;
    if FileExists(mainform.kontrollpanelbuttons[DestinationY][DestinationX].Picture) then
    begin
      mainform.kontrollpanelbuttons[DestinationY][DestinationX].PNG:=TPNGObject.Create;
      mainform.kontrollpanelbuttons[DestinationY][DestinationX].PNG.LoadFromFile(mainform.kontrollpanelbuttons[DestinationY][DestinationX].Picture);
    end;

    if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SourceY+1)+'x'+inttostr(SourceX+1)+'.pcdscrp') then
      CopyFile(PChar((mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SourceY+1)+'x'+inttostr(SourceX+1)+'.pcdscrp')),PChar((mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(DestinationY+1)+'x'+inttostr(DestinationX+1)+'.pcdscrp')),False);
    if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SourceY+1)+'x'+inttostr(SourceX+1)+'.pas') then
      CopyFile(PChar((mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(SourceY+1)+'x'+inttostr(SourceX+1)+'.pas')),PChar((mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(DestinationY+1)+'x'+inttostr(DestinationX+1)+'.pas')),False);
  end;
end;

procedure Tkontrollpanel.FlipButton(SourceX, SourceY, DestinationX, DestinationY: integer);
var
  i, EndLine:integer;
begin
  if (SourceX>-1) and (SourceY>-1) and (DestinationX>-1) and (DestinationY>-1) and
    (SourceY<length(mainform.kontrollpanelbuttons)) and (SourceX<length(mainform.kontrollpanelbuttons[SourceY])) and
    (DestinationY<length(mainform.kontrollpanelbuttons)) and (DestinationX<length(mainform.kontrollpanelbuttons[DestinationY])) then
  begin
    // add new row at the end
    setlength(mainform.kontrollpanelbuttons, length(mainform.kontrollpanelbuttons)+1);
    // give it the same number of cols as the one before
    EndLine:=length(mainform.kontrollpanelbuttons)-1;
    setlength(mainform.kontrollpanelbuttons[EndLine], length(mainform.kontrollpanelbuttons[EndLine-1]));


    CopyButton(SourceX, SourceY, SourceX, EndLine);
    CopyButton(DestinationX, DestinationY, SourceX, SourceY);
    CopyButton(SourceX, EndLine, DestinationX, DestinationY);

    // delete last buttons
    for i:=0 to length(mainform.kontrollpanelbuttons[EndLine])-1 do
    begin
      ResetButton(i, EndLine);
    end;

    // remove last array-index
    setlength(mainform.kontrollpanelbuttons, length(mainform.kontrollpanelbuttons)-1);
  end;
end;

procedure Tkontrollpanel.ResetButton(X, Y:integer);
begin
  if (X>-1) and (Y>-1) and
    (Y<length(mainform.kontrollpanelbuttons)) and (X<length(mainform.kontrollpanelbuttons[Y])) then
  begin
    mainform.kontrollpanelbuttons[Y][X].ID:=StringToGuid('{00000000-0000-0000-0000-000000000000}');
    mainform.kontrollpanelbuttons[Y][X].Name:='Button '+inttostr(Y+1)+'x'+inttostr(X+1);
    mainform.kontrollpanelbuttons[Y][X].TypName:=_('Leer');
    mainform.kontrollpanelbuttons[Y][X].Color:=clWhite;
    mainform.kontrollpanelbuttons[Y][X].Typ:=0;
    mainform.kontrollpanelbuttons[Y][X].Time:='';
    mainform.kontrollpanelbuttons[Y][X].Shortcut:=0;
    mainform.kontrollpanelbuttons[Y][X].Active:=false;
    mainform.kontrollpanelbuttons[Y][X].Picture:='';
    mainform.kontrollpanelbuttons[Y][X].PNG.Free;
    mainform.kontrollpanelbuttons[Y][X].PNG:=nil;

    if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(Y+1)+'x'+inttostr(X+1)+'.pcdscrp') then
      DeleteFile(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(Y+1)+'x'+inttostr(X+1)+'.pcdscrp');
    if FileExists(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(Y+1)+'x'+inttostr(X+1)+'.pas') then
      DeleteFile(mainform.userdirectory+'ProjectTemp\Kontrollpanel\Button'+inttostr(Y+1)+'x'+inttostr(X+1)+'.pas');
  end;
end;

procedure Tkontrollpanel.FlipLine(SourceY, DestinationY: integer);
var
  i, EndLine:integer;
begin
  if (SourceY>-1) and (DestinationY>-1) and
    (SourceY<length(mainform.kontrollpanelbuttons)) and (DestinationY<length(mainform.kontrollpanelbuttons)) then
  begin
    // add new row at the end
    setlength(mainform.kontrollpanelbuttons, length(mainform.kontrollpanelbuttons)+1);
    // give it the same number of cols as the one before
    EndLine:=length(mainform.kontrollpanelbuttons)-1;
    setlength(mainform.kontrollpanelbuttons[EndLine], length(mainform.kontrollpanelbuttons[EndLine-1]));

    for i:=0 to length(mainform.kontrollpanelbuttons[EndLine])-1 do
    begin
      CopyButton(i, SourceY, i, EndLine);
      CopyButton(i, DestinationY, i, SourceY);
      CopyButton(i, EndLine, i, DestinationY);
    end;

    // delete last buttons
    for i:=0 to length(mainform.kontrollpanelbuttons[EndLine])-1 do
    begin
      ResetButton(i, EndLine);
    end;

    // remove last array-index
    setlength(mainform.kontrollpanelbuttons, length(mainform.kontrollpanelbuttons)-1);
  end;
end;

procedure Tkontrollpanel.MoveLine(Source, Destination:integer);
var
  i:integer;
  EndLine:integer;
begin
  if (Source>-1) and (Destination>-1) and
    (Source<length(mainform.kontrollpanelbuttons)) and (Destination<length(mainform.kontrollpanelbuttons)) then
  begin
    // add new row at the end
    setlength(mainform.kontrollpanelbuttons, length(mainform.kontrollpanelbuttons)+1);
    // give it the same number of cols as the one before
    EndLine:=length(mainform.kontrollpanelbuttons)-1;
    setlength(mainform.kontrollpanelbuttons[EndLine], length(mainform.kontrollpanelbuttons[EndLine-1]));

    // 1. copy the Destination-row to the end
    for i:=0 to length(mainform.kontrollpanelbuttons[EndLine])-1 do
    begin
      CopyButton(i, Destination, i, EndLine);
    end;

    // 2. copy the Source-row to the destination
    for i:=0 to length(mainform.kontrollpanelbuttons[EndLine])-1 do
    begin
      CopyButton(i, Source, i, Destination);
    end;

    // 3. copy the EndLine-row to the Source
    for i:=0 to length(mainform.kontrollpanelbuttons[EndLine])-1 do
    begin
      CopyButton(i, EndLine, i, Source);
    end;

    // delete last buttons
    for i:=0 to length(mainform.kontrollpanelbuttons[EndLine])-1 do
    begin
      ResetButton(i, EndLine);
    end;

    // remove last array-index
    setlength(mainform.kontrollpanelbuttons, length(mainform.kontrollpanelbuttons)-1);
  end;
end;

procedure Tkontrollpanel.DeleteLine(Y:integer);
var
  i:integer;
begin
  if (Y>-1) and (Y<length(mainform.kontrollpanelbuttons)) then
  begin
    for i:=Y to length(mainform.kontrollpanelbuttons)-2 do
    begin
      MoveLine(i+1, i);
    end;
    zeilen.Value:=zeilen.Value-1;
    zeilenChange(nil);
  end;
end;

procedure Tkontrollpanel.VerschiebeReihenachoben1Click(Sender: TObject);
begin
  if (SelectedBtn.Y>-1) and (SelectedBtn.Y<length(mainform.kontrollpanelbuttons)) then
  begin
    if SelectedBtn.Y>0 then
    begin
      MoveLine(SelectedBtn.Y, SelectedBtn.Y-1);
      SelectedBtn.Y:=SelectedBtn.Y-1;
    end;
  end;
end;

procedure Tkontrollpanel.VerschiebeReihenachunten1Click(Sender: TObject);
begin
  if (SelectedBtn.Y>-1) and (SelectedBtn.Y<length(mainform.kontrollpanelbuttons)) then
  begin
    if SelectedBtn.Y<length(mainform.kontrollpanelbuttons) then
    begin
      MoveLine(SelectedBtn.Y, SelectedBtn.Y+1);
      SelectedBtn.Y:=SelectedBtn.Y+1;
    end;
  end;
end;

procedure Tkontrollpanel.GanzeZeilelschen1Click(Sender: TObject);
begin
  if (SelectedBtn.Y>-1) and (SelectedBtn.Y<length(mainform.kontrollpanelbuttons)) then
  begin
    if messagedlg(_('Die gesamte Zeile des markierten Buttons wird gelöscht! Fortfahren?'),mtConfirmation,
      [mbYes,mbNo],0)=mrNo then exit;

    DeleteLine(SelectedBtn.Y);
  end;
end;

procedure Tkontrollpanel.Zeileeinfgen1Click(Sender: TObject);
var
  i:integer;
begin
  // insgesamt eine neue Zeile einfügen
  zeilen.Value:=zeilen.Value+1;
  zeilenChange(nil);

  // nun alle Zeilen eine position nach unten schieben
  for i:=length(mainform.kontrollpanelbuttons)-2 downto SelectedBtn.Y do
  begin
    MoveLine(i, i+1);
  end;
  for i:=0 to length(mainform.kontrollpanelbuttons[SelectedBtn.Y])-1 do
    ResetButton(i, SelectedBtn.Y);
end;

end.
