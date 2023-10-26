unit geraetesteuerungfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Mask, Menus, Buttons, Registry, Math,
  messagesystem, JvExStdCtrls, JvExExtCtrls, JvComponent,
  JvOfficeColorPanel, JvExControls, JvGammaPanel, Grids, JvAppStorage,
  JvAppXMLStorage, JvComponentBase, JvExtComponent, JvPanel, PngBitBtn,
  JvColorBox, JvColorButton, HSLColorPicker, JvInterpreter, JvCombobox,
  JvColorCombo, mbXPImageComboBox, ImgList, PngImageList, JvExMask,
  JvSpin, HexaColorPicker, gnugettext, pngimage, TB2Item, TB2Dock,
  TB2Toolbar, GR32, VirtualTrees, ShellApi, pcdUtils;

const
  {$I GlobaleKonstanten.inc}

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: byte; // 0=Vendor, 1=Type, 2=Device
    Caption:WideString;
    ID:TGUID;
  end;

  Teditproperties = record
    name:string;
    channel:Integer;
    actionname:string;
  end;

  Tcheckboxproperties = record
    name:string;
    channel:Integer;
    actionname:string;
  end;

  Tcomboboxproperties = record
    name:string;
    channel:Integer;
    actionname:string;
    itemvalue:array of integer;
  end;

  Tsliderproperties = record
    name:string;
    channel:Integer;
    actionname:string;
  end;

  Tbuttonproperties = record
    name:string;
    channel:Integer;
    onvalue:Integer;
    offvalue:Integer;
    actionname:string;
  end;

  Tradiobuttonproperties = record
    name:string;
    channel:Integer;
    actionname:string;
    itemvalue:array of integer;
  end;

  TDeviceprototyp = record
    ID:TGUID;
    Name:string[255];
    DeviceName:string[255];
    Beschreibung:string[255];
    Author:string[255];
    Vendor:string[255];
    Bildadresse:String[255];
    MaxChan: Byte;
    invertpan:boolean;
    inverttilt:boolean;
    KanalMinValue:array of byte;
    KanalMaxValue:array of byte;
    kanaltyp:array of string[255];
    kanalname:array of string[255];
    kanalfade:array of boolean;
    ddffilename:string[255];
    funktionen:string;
    hasDimmer:boolean;
    hasShutter:boolean;
    hasVirtualRGBAWDimmer:boolean;
    hasRGB:boolean;
    hasCMY:boolean;
    hasAmber:boolean;
    hasWhite:boolean;
    hasUV:boolean;
    hasFog:boolean;
    hasPANTILT:boolean;
    hasColor:boolean;
    hasColor2:boolean;
    hasGobo:boolean;
    hasGobo2:boolean;

    UseAmberMixing:boolean;
    AmberMixingCompensateRG:boolean;
    AmberMixingCompensateBlue:boolean;
    AmberRatioR:byte;
    AmberRatioG:byte;

    colors:array of TColor;
    colorlevels:array of byte;
    colorendlevels:array of byte;
    colornames:array of string[255];
    colors2:array of TColor;
    colorlevels2:array of byte;
    colorendlevels2:array of byte;
    colornames2:array of string[255];
    gobos:array of string[255];
    gobolevels:array of byte;
    goboendlevels:array of byte;
    gobonames:array of string[255];
    gobos2:array of string[255];
    gobolevels2:array of byte;
    goboendlevels2:array of byte;
    gobonames2:array of string[255];

    ShutterOpenValue:byte;
    ShutterCloseValue:byte;
    ShutterChannel:string[255];
    StrobeOffValue:byte;
    StrobeMaxValue:byte;
    StrobeMinValue:byte;
    StrobeChannel:string[255];
    DimmerOffValue:byte;
    DimmerMaxValue:byte;
    FogOffValue:byte;
    FogMaxValue:byte;
    Gobo1RotLeftminValue:byte;
    Gobo1RotLeftValue:byte;
    Gobo1RotOffValue:byte;
    Gobo1RotRightminValue:byte;
    Gobo1RotRightValue:byte;
    Gobo1RotChannel:string[255];
    Gobo2RotLeftminValue:byte;
    Gobo2RotLeftValue:byte;
    Gobo2RotOffValue:byte;
    Gobo2RotRightminValue:byte;
    Gobo2RotRightValue:byte;
    Gobo2RotChannel:string[255];
    PrismaSingleValue:byte;
    PrismaTripleValue:byte;
    PrismaRotOffValue:byte;
    PrismaRotLeftminValue:byte;
    PrismaRotLeftmaxValue:byte;
    PrismaRotRightminValue:byte;
    PrismaRotRightmaxValue:byte;
    PrismaRotChannel:string[255];
    IrisCloseValue:byte;
    IrisOpenValue:byte;
    IrisMinValue:byte;
    IrisMaxValue:byte;

    IsMatrixDevice: boolean;
    MatrixXCount, MatrixYCount:byte;
    MatrixOrdertype:byte;
  end;

  Tgeraetesteuerung = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel3: TPanel;
    XML: TJvAppXMLFileStorage;
    fortschrittsbalken: TProgressBar;
    OpenDialog2: TOpenDialog;
    SuchTimer: TTimer;
    ScriptInterpreter: TJvInterpreterProgram;
    SuchGruppenTimer: TTimer;
    Panel1: TPanel;
    Grouplist: TStringGrid;
    Panel2: TPanel;
    Panel4: TPanel;
    ChangeBtn: TPngBitBtn;
    AddBtn: TPngBitBtn;
    DeleteBtn: TPngBitBtn;
    AdvancedSetupBox: TGroupBox;
    copycountslbl: TLabel;
    autoscening: TCheckBox;
    showinstageview: TCheckBox;
    copycounts: TEdit;
    upbtn: TPngBitBtn;
    downbtn: TPngBitBtn;
    Panel5: TPanel;
    geraetelbl: TLabel;
    Bevel6aa: TBevel;
    suchfensteredit: TEdit;
    minus: TButton;
    plus: TButton;
    Panel6: TPanel;
    RefreshGroupBtn: TPngBitBtn;
    ActivateGroupBtn: TPngBitBtn;
    DeleteGroupBtn: TPngBitBtn;
    AddGroupBtn: TPngBitBtn;
    AddDeviceGroupWithoutDeselectBtn: TPngBitBtn;
    ShowGroupIDbtn: TButton;
    ReorderGroupBtn: TPngBitBtn;
    Panel7: TPanel;
    DeviceSetupBox: TGroupBox;
    positionlbl: TLabel;
    PngBitBtn2: TPngBitBtn;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn4: TPngBitBtn;
    panmirror: TCheckBox;
    tiltmirror: TCheckBox;
    SyncTypeBox: TComboBox;
    CalibrateBtn: TPngBitBtn;
    PngBitBtn3: TPngBitBtn;
    GrundsetupBox: TGroupBox;
    adresselbl: TLabel;
    colorlbl: TLabel;
    dipswitcha: TImage;
    DIP1: TImage;
    DIP2: TImage;
    DIP3: TImage;
    DIP4: TImage;
    DIP5: TImage;
    DIP6: TImage;
    DIP7: TImage;
    DIP8: TImage;
    DIP9: TImage;
    DIP10: TImage;
    DIPON: TImage;
    DIPOFF: TImage;
    DevStartaddressEdit: TEdit;
    colorBtn: TJvColorButton;
    Panel8: TPanel;
    TreeView2: TTreeView;
    Panel9: TPanel;
    Panel10: TPanel;
    renameBtn: TPngBitBtn;
    idbtn: TButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel11: TPanel;
    geraetegruppenlbl: TLabel;
    Bevel3aa: TBevel;
    suchfenstergruppen: TEdit;
    Panel12: TPanel;
    deviceusedinlbl: TLabel;
    Bevel5aa: TBevel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    Datei1: TTBSubmenuItem;
    Gertesteuerungzurcksetzen1: TTBItem;
    Gertesteuerungffnen1: TTBItem;
    Gertesteuerungspeichern1: TTBItem;
    Gerte1: TTBSubmenuItem;
    Gerthinzufgen1: TTBItem;
    Bearbeiten1: TTBItem;
    Lschen1: TTBItem;
    N1: TTBSeparatorItem;
    Bildndern1: TTBItem;
    Kanalnamesenden1: TTBItem;
    Dimmerkurveneinstellen1: TTBItem;
    Scannersynchronisation1: TTBItem;
    N2: TTBSeparatorItem;
    Gerteadressenexportieren1: TTBItem;
    Adressenimportieren1: TTBItem;
    GertemitGertedateiabgleichen1: TTBItem;
    Gruppen1: TTBSubmenuItem;
    Gruppeneditor1: TTBItem;
    N5: TTBSeparatorItem;
    Gruppenhinzufgen1: TTBItem;
    Lschen2: TTBItem;
    Auswahlaktualisieren1: TTBItem;
    Gruppeanzeigen1: TTBItem;
    Gruppeadditivanzeigen1: TTBItem;
    N4: TTBSeparatorItem;
    IDderaktuellenGruppeanzeigen1: TTBItem;
    DDFEditor1: TTBItem;
    showddfbtn: TTBItem;
    VST: TVirtualStringTree;
    sortbtn: TButton;
    TBItem1: TTBItem;
    TBSubmenuItem1: TTBSubmenuItem;
    TBItem2: TTBItem;
    TBSubmenuItem2: TTBSubmenuItem;
    TBSeparatorItem1: TTBSeparatorItem;
    TBItem3: TTBItem;
    TBItem4: TTBItem;
    TBSubmenuItem3: TTBSubmenuItem;
    TBItem5: TTBItem;
    TBItem6: TTBItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RefreshDeviceControl;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure TreeViewCheckbuttons(Shift: TShiftState);
    procedure Gerthinzufgen1Click(Sender: TObject);
    procedure Gertlschen1Click(Sender: TObject);
    procedure tiltmirrorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure input_number(var pos:integer; var s:string);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure AddGroupBtnClick(Sender: TObject);
    procedure DeleteGroupBtnClick(Sender: TObject);
    procedure GrouplistKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function GetChannelName(DeviceID:TGUID; Channel: integer):String;
    procedure ChangeBtnClick(Sender: TObject);
    procedure RefreshGroupBtnClick(Sender: TObject);
    function GetDevicePositionInDeviceArray(ID: PGUID):integer;
    function GetGroupPositionInGroupArray(ID: TGUID):integer;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure panmirrorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    function channel(channel:integer):Integer;
    procedure suchfenstereditEnter(Sender: TObject);
    procedure suchfenstereditExit(Sender: TObject);
    procedure suchfenstereditChange(Sender: TObject);
    procedure showinstageviewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure colorBtnChange(Sender: TObject);
    procedure SendNamesBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure minusClick(Sender: TObject);
    procedure plusClick(Sender: TObject);
    procedure ActivateGroupBtnClick(Sender: TObject);
    procedure Gerteadressenexportieren1Click(Sender: TObject);
    procedure Adressenimportieren1Click(Sender: TObject);
    procedure autosceningMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SuchTimerTimer(Sender: TObject);
    procedure suchfenstereditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure copycountsChange(Sender: TObject);
    procedure copycountsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure copycountsKeyPress(Sender: TObject; var Key: Char);
    procedure PngBitBtn4Click(Sender: TObject);
    procedure DIP1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure suchfenstergruppenExit(Sender: TObject);
    procedure suchfenstergruppenEnter(Sender: TObject);
    procedure suchfenstergruppenChange(Sender: TObject);
    procedure suchfenstergruppenKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SuchGruppenTimerTimer(Sender: TObject);
    procedure Scannersynchronisation1Click(Sender: TObject);
    procedure fadenkreuzMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GertemitGertedateiabgleichen1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure AddDeviceGroupWithoutDeselectBtnClick(Sender: TObject);
    procedure GrouplistMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShowGroupIDbtnClick(Sender: TObject);
    procedure SyncTypeBoxSelect(Sender: TObject);
    procedure ReorderGroupBtnClick(Sender: TObject);
    procedure Gruppeneditor1Click(Sender: TObject);
    procedure upbtnClick(Sender: TObject);
    procedure downbtnClick(Sender: TObject);
    procedure GrouplistDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrouplistGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure PngBitBtn3Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure VSTEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure VSTKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure VSTMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure renameBtnClick(Sender: TObject);
    procedure sortbtnClick(Sender: TObject);
    procedure TBItem1Click(Sender: TObject);
    procedure TBItem2Click(Sender: TObject);
    procedure TBItem3Click(Sender: TObject);
    procedure TBItem4Click(Sender: TObject);
    procedure VSTMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure idbtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DevStartaddressEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TBItem6Click(Sender: TObject);
    procedure TBItem5Click(Sender: TObject);
  private
    { Private-Deklarationen }
//    SystemVals: array [0..2] of Integer;
    dontrefreshXY:boolean;
    argumente:TJvInterpreterArgs;
    dipstate:array[1..10] of boolean;
    Bmp : TImage;
    procedure WMMoving(var AMsg: TMessage); message WM_MOVING;
    procedure RefreshDeviceDependencies;
  public
    { Public-Deklarationen }
    refreshchannel:array[1..chan] of boolean;
    Red,Green,Blue:byte;
    LastRed,LastGreen,LastBlue:byte;
    Position:TGUID;

    VSTVendorNodes: array of PVirtualNode;
    VSTTypeNodes: array of array of PVirtualNode;
    VSTDeviceNodes: array of array of array of PVirtualNode;

    DevicePrototyp:array of TDeviceprototyp;
    PositioninSelectedDevices:integer;

    active:array[0..chan] of boolean;
    flashmastervalue:byte;

    slidervalue_temp:array[1..15] of byte;
    refreshGUI:boolean;

    FileStream:TFileStream;

    procedure NewFile;
    procedure OpenFile(FileName: String);
    procedure SaveFile(FileName: String);
    procedure MSGSave;
    procedure RefreshTreeNew;
    procedure set_pantilt(DeviceID: TGUID; PANstartvalue, PANendvalue, TILTstartvalue, TILTendvalue, fadetime:integer);overload;
    procedure set_pantilt(DeviceID: TGUID; PANstartvalue, PANendvalue, TILTstartvalue, TILTendvalue, fadetime, delay:integer);overload;
    procedure set_channel(DeviceID: TGUID; channel:string; startvalue, endvalue, fadetime:integer);overload;
    procedure set_channel(DeviceID: TGUID; channel:string; startvalue, endvalue, fadetime, delay:integer);overload;
    procedure set_group(GroupID: TGUID; channel:string; startvalue, endvalue, fadetime:integer);overload;
    procedure set_group(GroupID: TGUID; channel:string; startvalue, endvalue, fadetime, delay:integer);overload;
    function get_channel(DeviceID: TGUID; channel:string):integer;
    function get_group(GroupID: TGUID; channel:string):integer;

    procedure set_color(DeviceID: TGUID; R, G, B:byte; Fadetime, Delay:Integer; Mode:Byte=7);overload;
    procedure set_color(DeviceID: TGUID; R, G, B:byte; A,W:integer; Fadetime, Delay:Integer; Mode:Byte=7);overload;
    procedure set_shutter(DeviceID: TGUID; OpenOrClose:byte; Delaytime:integer=0);
    procedure set_prisma(DeviceID: TGUID; SingleOrTriple:byte; Delaytime:integer=0);
    procedure set_prismarot(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
    procedure set_strobe(DeviceID: TGUID; Speed:integer; Fadetime:integer=0; Delaytime:integer=0);
    procedure set_dimmer(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
    procedure set_fog(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
    procedure set_iris(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
    procedure set_gobo1rot(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
    procedure set_gobo2rot(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
    procedure set_gobo(DeviceID: TGUID; GoboName:string);
    procedure set_gobo1plus(DeviceID: TGUID; Delaytime:integer=0);
    procedure set_gobo1minus(DeviceID: TGUID; Delaytime:integer=0);
    procedure set_gobo2plus(DeviceID: TGUID; Delaytime:integer=0);
    procedure set_gobo2minus(DeviceID: TGUID; Delaytime:integer=0);
    function get_dimmer(DeviceID: TGUID):integer;
    function get_strobe(DeviceID: TGUID):integer;
    function get_shutter(DeviceID: TGUID):integer;
    function get_color(DeviceID: TGUID):TColor;

    function GetMatrixDeviceStartAddress(MasterDeviceID:TGUID; MatrixXPosition, MatrixYPosition:byte):integer;
    procedure ChangeDeviceStartaddress(ID: TGUID; NewStartaddress:Word);

    function FindDeviceConnections(ID:TGUID; var TreeView:TTreeView):boolean;
    procedure GroupListChanged;
    procedure CheckDeviceGroupIntersection(PositionInGroupArray:integer; var HasChanType:Array of Boolean);
    procedure CopyDevice(Source, Destination: integer);
    function GetImageIndex(Bildadresse: string):integer;
    procedure LoadDDFfiles;
    procedure AddGobo(filename: string);
    procedure ConvertRGBtoRGBA(Rin, Gin, Bin: byte; AmberColorR, AmberColorG:byte; CompRG, CompBlue:boolean; var Rout, Gout, Bout, Aout: byte);
    procedure ConvertRGBAWUVtoRGB(Rin, Gin, Bin, Ain: byte; AmberColorR, AmberColorG:byte; CompRG, CompBlue: boolean; Win, UVin:byte; var Rout, Gout, Bout: byte);
  end;

var
  geraetesteuerung: Tgeraetesteuerung;

implementation

uses PCDIMMER, adddevicefrm, geraeteremovedfrm, buehnenansicht,
  ddfwindowfrm, dimmcurvefrm, devicepicturechangefrm, colormanagerfrm,
  ddfeditorfrm, audioeffektplayerfrm, scannersynchronisationfrm,
  ProgressScreenSmallFrm, reordergroupfrm, devicepowerfrm, devicelistfrm,
  adddevicetogroupfrm, sidebarfrm;

{$R *.dfm}

function BitSet(Value: Byte; BitCnt: Byte): Boolean;
begin
//  Result := (( Value AND Round ( power (2, BitCnt-1) )) = Round ( power (2, BitCnt-1) ));
//  result:=(Value AND (1 shl bitcnt )) = (1 shl bitcnt);
  result := ((Value AND bitcnt) = bitcnt);
end;

procedure Tgeraetesteuerung.input_number(var pos:integer; var s:string);
var
  i:integer;
begin
  i:=1;
  while i<=length(s) do
    begin
      if (s[i]<'0') or (s[i]>'9') then
        begin
          delete(s,i,1);
          dec(pos);
        end
      else
        inc(i);
    end;
end;

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

procedure Tgeraetesteuerung.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DDFWindowDeviceScene.Showing then
    DDFWindowDeviceScene.close;

  MSGSave;
end;

procedure Tgeraetesteuerung.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
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
						LReg.WriteBool('Showing Geraetesteuerung',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
	end;
  mainform.SaveWindowPositions('geraetesteuerung');
end;

procedure Tgeraetesteuerung.FormShow(Sender: TObject);
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
				LReg.WriteBool('Showing Geraetesteuerung',true);

        if not LReg.KeyExists('Geraetesteuerung') then
	        LReg.CreateKey('Geraetesteuerung');
	      if LReg.OpenKey('Geraetesteuerung',true) then
	      begin
            if LReg.ValueExists('Width') then
              geraetesteuerung.ClientWidth:=LReg.ReadInteger('Width')
            else
              geraetesteuerung.ClientWidth:=692;
            if LReg.ValueExists('Height') then
              geraetesteuerung.ClientHeight:=LReg.ReadInteger('Height')
            else
              geraetesteuerung.ClientHeight:=540;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+geraetesteuerung.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              geraetesteuerung.Left:=LReg.ReadInteger('PosX')
            else
              geraetesteuerung.Left:=0;
          end else
            geraetesteuerung.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+geraetesteuerung.ClientHeight<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              geraetesteuerung.Top:=LReg.ReadInteger('PosY')
            else
              geraetesteuerung.Top:=0;
          end else
            geraetesteuerung.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  RefreshDeviceControl;
end;

procedure Tgeraetesteuerung.RefreshDeviceControl;
var
  i:integer;
begin
  if length(geraetesteuerung.DevicePrototyp)<=0 then
    LoadDDFFiles;

  Grouplist.Cells[0,0]:=_('');
  Grouplist.Cells[1,0]:=_('Name');
  Grouplist.Cells[2,0]:=_('Beschreibung');

  RefreshTreeNew;
  TreeViewCheckbuttons([]);

  if length(mainform.DeviceGroups)>0 then
  begin
    Grouplist.RowCount:=length(mainform.DeviceGroups)+1;
    for i:=1 to length(mainform.DeviceGroups) do
    begin
      Grouplist.Cells[1,i]:=mainform.DeviceGroups[i-1].Name;
      Grouplist.Cells[2,i]:=mainform.DeviceGroups[i-1].Beschreibung;
    end;
  end else
  begin
    Grouplist.RowCount:=2;
    Grouplist.Cells[0,1]:='';
    Grouplist.Cells[1,1]:='';
    Grouplist.Cells[2,1]:='';
  end;
end;

procedure Tgeraetesteuerung.SpeedButton3Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if messagedlg(_('Möchten Sie wirklich alle Geräte und Presets löschen?'),mtWarning,[mbYes,mbNo],0)=mrYes then
    NewFile;
end;

procedure Tgeraetesteuerung.SpeedButton2Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  SaveDialog1.Filter:=_('PC_DIMMER Gerätedatei (*.pcddevs)|*.pcddevs|Alle Dateien|*.*');
  SaveDialog1.DefaultExt:='*.pcddevs';
  SaveDialog1.Title:=_('PC_DIMMER Gerätedatei speichern');
  if SaveDialog1.Execute then
  begin
    SaveFile(SaveDialog1.FileName);
  end;
end;

procedure Tgeraetesteuerung.SpeedButton1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  OpenDialog1.Filter:=_('PC_DIMMER Gerätedatei (*.pcddevs)|*.pcddevs|Alle Dateien|*.*');
  OpenDialog1.DefaultExt:='*.pcddevs';
  OpenDialog1.Title:=_('PC_DIMMER Gerätedatei öffnen');
  if OpenDialog1.Execute then
  begin
    OpenFile(OpenDialog1.FileName);
  end;
end;

procedure Tgeraetesteuerung.NewFile;
begin
  setlength(mainform.Devices,0);
  setlength(mainform.DeviceSelected,0);
  setlength(mainform.DeviceGroups,0);

  RefreshTreeNew;
  TreeViewCheckbuttons([]);
  groupeditorform.GroupListChanged;

  geraetesteuerung.ClientWidth:=692;
  geraetesteuerung.ClientHeight:=540;
end;

procedure Tgeraetesteuerung.OpenFile(FileName: String);
var
  i, j, k, Count, Count2, Count3, Version:integer;
  DummyByte:Byte;
begin
  if FileExists(FileName) then
  begin
    FileStream:=TFileStream.Create(FileName,fmOpenRead);

    // Projektversion
    Filestream.ReadBuffer(Version, sizeof(Count));

	  Filestream.ReadBuffer(Count,sizeof(Count));
    setlength(mainform.Devices,Count);
    setlength(mainform.DeviceSelected,Count);
    for i:=0 to Count-1 do
    begin
   	  Filestream.ReadBuffer(mainform.Devices[i].ID,sizeof(mainform.Devices[i].ID));
   	  Filestream.ReadBuffer(mainform.Devices[i].Name,sizeof(mainform.Devices[i].Name));
   	  Filestream.ReadBuffer(mainform.Devices[i].DeviceName,sizeof(mainform.Devices[i].DeviceName));
   	  Filestream.ReadBuffer(mainform.Devices[i].Beschreibung,sizeof(mainform.Devices[i].Beschreibung));
   	  Filestream.ReadBuffer(mainform.Devices[i].Vendor,sizeof(mainform.Devices[i].Vendor));
   	  Filestream.ReadBuffer(mainform.Devices[i].Bildadresse,sizeof(mainform.Devices[i].Bildadresse));
   	  Filestream.ReadBuffer(mainform.Devices[i].Startaddress,sizeof(mainform.Devices[i].Startaddress));
   	  Filestream.ReadBuffer(mainform.Devices[i].MaxChan,sizeof(mainform.Devices[i].MaxChan));
   	  Filestream.ReadBuffer(mainform.Devices[i].invertpan,sizeof(mainform.Devices[i].invertpan));
   	  Filestream.ReadBuffer(mainform.Devices[i].inverttilt,sizeof(mainform.Devices[i].inverttilt));

   	  Filestream.ReadBuffer(mainform.Devices[i].typeofscannercalibration,sizeof(mainform.Devices[i].typeofscannercalibration));

      Filestream.ReadBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
 	      Filestream.ReadBuffer(mainform.Devices[i].ScannerCalibrations[j],sizeof(mainform.Devices[i].ScannerCalibrations[j]));

      // Bühnenansichtdarstellung
   	  Filestream.ReadBuffer(mainform.Devices[i].ShowInStageView,sizeof(mainform.Devices[i].ShowInStageView));
   	  Filestream.ReadBuffer(mainform.Devices[i].color,sizeof(mainform.Devices[i].color));
   	  Filestream.ReadBuffer(mainform.Devices[i].picturesize,sizeof(mainform.Devices[i].picturesize));
   	  Filestream.ReadBuffer(mainform.Devices[i].pictureangle,sizeof(mainform.Devices[i].pictureangle));
   	  Filestream.ReadBuffer(mainform.Devices[i].picturefliphor,sizeof(mainform.Devices[i].picturefliphor));
   	  Filestream.ReadBuffer(mainform.Devices[i].pictureflipver,sizeof(mainform.Devices[i].pictureflipver));
   	  Filestream.ReadBuffer(mainform.Devices[i].pictureispng,sizeof(mainform.Devices[i].pictureispng));

   	  Filestream.ReadBuffer(Count2,sizeof(Count2));
      setlength(mainform.Devices[i].top,Count2);
      setlength(mainform.Devices[i].left,Count2);
      setlength(mainform.Devices[i].bank,Count2);
      setlength(mainform.Devices[i].selected,Count2);
      setlength(mainform.Devices[i].OldPos,Count2);
      for j:=0 to Count2-1 do
      begin
     	  Filestream.ReadBuffer(mainform.Devices[i].top[j],sizeof(mainform.Devices[i].top[j]));
     	  Filestream.ReadBuffer(mainform.Devices[i].left[j],sizeof(mainform.Devices[i].left[j]));
     	  Filestream.ReadBuffer(mainform.Devices[i].bank[j],sizeof(mainform.Devices[i].bank[j]));
      end;
   	  Filestream.ReadBuffer(mainform.Devices[i].hasDimmer,sizeof(mainform.Devices[i].hasDIMMER));
      if Version>=481 then
        Filestream.ReadBuffer(mainform.Devices[i].hasShutter,sizeof(mainform.Devices[i].hasShutter));
      if Version>=464 then
     	  Filestream.ReadBuffer(mainform.Devices[i].hasVirtualRGBAWDimmer,sizeof(mainform.Devices[i].hasVirtualRGBAWDIMMER));
   	  Filestream.ReadBuffer(mainform.Devices[i].hasRGB,sizeof(mainform.Devices[i].hasRGB));
      if Version>=468 then
     	  Filestream.ReadBuffer(mainform.Devices[i].hasCMY,sizeof(mainform.Devices[i].hasCMY));
      if Version>=463 then
      begin
     	  Filestream.ReadBuffer(mainform.Devices[i].hasAmber,sizeof(mainform.Devices[i].hasAmber));
     	  Filestream.ReadBuffer(mainform.Devices[i].hasWhite,sizeof(mainform.Devices[i].hasWhite));
        if Version>=476 then
       	  Filestream.ReadBuffer(mainform.Devices[i].hasUV,sizeof(mainform.Devices[i].hasUV));
        if Version>=477 then
       	  Filestream.ReadBuffer(mainform.Devices[i].hasFog,sizeof(mainform.Devices[i].hasFog));
     	  Filestream.ReadBuffer(mainform.Devices[i].UseAmberMixing,sizeof(mainform.Devices[i].UseAmberMixing));
     	  Filestream.ReadBuffer(mainform.Devices[i].AmberMixingCompensateRG,sizeof(mainform.Devices[i].AmberMixingCompensateRG));
     	  Filestream.ReadBuffer(mainform.Devices[i].AmberMixingCompensateBlue,sizeof(mainform.Devices[i].AmberMixingCompensateBlue));
     	  Filestream.ReadBuffer(mainform.Devices[i].AmberRatioR,sizeof(mainform.Devices[i].AmberRatioR));
     	  Filestream.ReadBuffer(mainform.Devices[i].AmberRatioG,sizeof(mainform.Devices[i].AmberRatioG));
      end;
   	  Filestream.ReadBuffer(mainform.Devices[i].hasPANTILT,sizeof(mainform.Devices[i].hasPANTILT));
   	  Filestream.ReadBuffer(mainform.Devices[i].hasColor,sizeof(mainform.Devices[i].hasColor));
      if Version>=450 then
      begin
        Filestream.ReadBuffer(mainform.Devices[i].hasColor2,sizeof(mainform.Devices[i].hasColor2));
        Filestream.ReadBuffer(mainform.Devices[i].hasGobo,sizeof(mainform.Devices[i].hasGobo));
        Filestream.ReadBuffer(mainform.Devices[i].hasGobo2,sizeof(mainform.Devices[i].hasGobo2));
      end;

   	  Filestream.ReadBuffer(Count2,sizeof(Count2));
      setlength(mainform.Devices[i].colors,Count2);
      setlength(mainform.Devices[i].colorlevels,Count2);
      setlength(mainform.Devices[i].colorendlevels,Count2);
      setlength(mainform.Devices[i].colornames,Count2);
      for j:=0 to Count2-1 do
   	  begin
        Filestream.ReadBuffer(mainform.Devices[i].colors[j],sizeof(mainform.Devices[i].colors[j]));
        Filestream.ReadBuffer(mainform.Devices[i].colorlevels[j],sizeof(mainform.Devices[i].colorlevels[j]));
        Filestream.ReadBuffer(mainform.Devices[i].colorendlevels[j],sizeof(mainform.Devices[i].colorendlevels[j]));
        Filestream.ReadBuffer(mainform.Devices[i].colornames[j],sizeof(mainform.Devices[i].colornames[j]));
   	  end;
      Filestream.ReadBuffer(mainform.Devices[i].colortolerance,sizeof(mainform.Devices[i].colortolerance));
      Filestream.ReadBuffer(mainform.Devices[i].autoscening,sizeof(mainform.Devices[i].autoscening));

      if Version>=449 then
      begin
        Filestream.ReadBuffer(Count2,sizeof(Count2));
        setlength(mainform.Devices[i].colors2, Count2);
        setlength(mainform.Devices[i].colorlevels2, Count2);
        setlength(mainform.Devices[i].colorendlevels2, Count2);
        setlength(mainform.Devices[i].colornames2, Count2);
        for j:=0 to Count2-1 do
        begin
          Filestream.ReadBuffer(mainform.Devices[i].colors2[j],sizeof(mainform.Devices[i].colors2[j]));
          Filestream.ReadBuffer(mainform.Devices[i].colorlevels2[j],sizeof(mainform.Devices[i].colorlevels2[j]));
          Filestream.ReadBuffer(mainform.Devices[i].colorendlevels2[j],sizeof(mainform.Devices[i].colorendlevels2[j]));
          Filestream.ReadBuffer(mainform.Devices[i].colornames2[j],sizeof(mainform.Devices[i].colornames2[j]));
        end;
        Filestream.ReadBuffer(Count2,sizeof(Count2));
        setlength(mainform.Devices[i].gobos,Count2);
        setlength(mainform.Devices[i].gobolevels,Count2);
        setlength(mainform.Devices[i].goboendlevels,Count2);
        setlength(mainform.Devices[i].gobonames,Count2);
        setlength(mainform.Devices[i].bestgobos,Count2);
        for j:=0 to Count2-1 do
        begin
          Filestream.ReadBuffer(mainform.Devices[i].gobos[j],sizeof(mainform.Devices[i].gobos[j]));
          Filestream.ReadBuffer(mainform.Devices[i].gobolevels[j],sizeof(mainform.Devices[i].gobolevels[j]));
          Filestream.ReadBuffer(mainform.Devices[i].goboendlevels[j],sizeof(mainform.Devices[i].goboendlevels[j]));
          Filestream.ReadBuffer(mainform.Devices[i].gobonames[j],sizeof(mainform.Devices[i].gobonames[j]));
          if Version<452 then
            Filestream.ReadBuffer(DummyByte,sizeof(DummyByte))
          else
          begin
            Filestream.ReadBuffer(Count3,sizeof(Count3));
            setlength(mainform.Devices[i].bestgobos[j], Count3);
            for k:=0 to length(mainform.Devices[i].bestgobos[j])-1 do
            begin
              Filestream.ReadBuffer(mainform.Devices[i].bestgobos[j][k].GoboName,sizeof(mainform.Devices[i].bestgobos[j][k].GoboName));
              Filestream.ReadBuffer(mainform.Devices[i].bestgobos[j][k].Percent,sizeof(mainform.Devices[i].bestgobos[j][k].Percent));
            end;
          end;
        end;
        Filestream.ReadBuffer(Count2,sizeof(Count2));
        setlength(mainform.Devices[i].gobos2,Count2);
        setlength(mainform.Devices[i].gobolevels2,Count2);
        setlength(mainform.Devices[i].goboendlevels2,Count2);
        setlength(mainform.Devices[i].gobonames2,Count2);
        setlength(mainform.Devices[i].bestgobos2,Count2);
        for j:=0 to Count2-1 do
        begin
          Filestream.ReadBuffer(mainform.Devices[i].gobos2[j],sizeof(mainform.Devices[i].gobos2[j]));
          Filestream.ReadBuffer(mainform.Devices[i].gobolevels2[j],sizeof(mainform.Devices[i].gobolevels2[j]));
          Filestream.ReadBuffer(mainform.Devices[i].goboendlevels2[j],sizeof(mainform.Devices[i].goboendlevels2[j]));
          Filestream.ReadBuffer(mainform.Devices[i].gobonames2[j],sizeof(mainform.Devices[i].gobonames2[j]));
          if Version<452 then
            Filestream.ReadBuffer(DummyByte,sizeof(DummyByte))
          else
          begin
            Filestream.ReadBuffer(Count3,sizeof(Count3));
            setlength(mainform.Devices[i].bestgobos2[j], Count3);
            for k:=0 to length(mainform.Devices[i].bestgobos2[j])-1 do
            begin
              Filestream.ReadBuffer(mainform.Devices[i].bestgobos2[j][k].GoboName,sizeof(mainform.Devices[i].bestgobos2[j][k].GoboName));
              Filestream.ReadBuffer(mainform.Devices[i].bestgobos2[j][k].Percent,sizeof(mainform.Devices[i].bestgobos2[j][k].Percent));
            end;
          end;
        end;
      end;

      if Version>=460 then
      begin
        Filestream.ReadBuffer(mainform.Devices[i].ShutterOpenValue,sizeof(mainform.Devices[i].ShutterOpenValue));
        Filestream.ReadBuffer(mainform.Devices[i].ShutterCloseValue,sizeof(mainform.Devices[i].ShutterCloseValue));
        Filestream.ReadBuffer(mainform.Devices[i].ShutterChannel,sizeof(mainform.Devices[i].ShutterChannel));
        Filestream.ReadBuffer(mainform.Devices[i].StrobeOffValue,sizeof(mainform.Devices[i].StrobeOffValue));
        Filestream.ReadBuffer(mainform.Devices[i].StrobeMinValue,sizeof(mainform.Devices[i].StrobeMinValue));
        Filestream.ReadBuffer(mainform.Devices[i].StrobeMaxValue,sizeof(mainform.Devices[i].StrobeMaxValue));
        Filestream.ReadBuffer(mainform.Devices[i].StrobeChannel,sizeof(mainform.Devices[i].StrobeChannel));
        Filestream.ReadBuffer(mainform.Devices[i].DimmerOffValue,sizeof(mainform.Devices[i].DimmerOffValue));
        Filestream.ReadBuffer(mainform.Devices[i].DimmerMaxValue,sizeof(mainform.Devices[i].DimmerMaxValue));
        if Version>=477 then
        begin
          Filestream.ReadBuffer(mainform.Devices[i].FogOffValue,sizeof(mainform.Devices[i].FogOffValue));
          Filestream.ReadBuffer(mainform.Devices[i].FogMaxValue,sizeof(mainform.Devices[i].FogMaxValue));
        end;
        Filestream.ReadBuffer(mainform.Devices[i].Gobo1RotLeftminValue,sizeof(mainform.Devices[i].Gobo1RotLeftminValue));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo1RotLeftValue,sizeof(mainform.Devices[i].Gobo1RotLeftValue));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo1RotOffValue,sizeof(mainform.Devices[i].Gobo1RotOffValue));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo1RotRightminValue,sizeof(mainform.Devices[i].Gobo1RotRightminValue));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo1RotRightValue,sizeof(mainform.Devices[i].Gobo1RotRightValue));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo1RotChannel,sizeof(mainform.Devices[i].Gobo1RotChannel));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo2RotLeftminValue,sizeof(mainform.Devices[i].Gobo2RotLeftminValue));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo2RotLeftValue,sizeof(mainform.Devices[i].Gobo2RotLeftValue));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo2RotOffValue,sizeof(mainform.Devices[i].Gobo2RotOffValue));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo2RotRightminValue,sizeof(mainform.Devices[i].Gobo2RotRightminValue));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo2RotRightValue,sizeof(mainform.Devices[i].Gobo2RotRightValue));
        Filestream.ReadBuffer(mainform.Devices[i].Gobo2RotChannel,sizeof(mainform.Devices[i].Gobo2RotChannel));

        if Version>=461 then
        begin
          Filestream.ReadBuffer(mainform.Devices[i].PrismaSingleValue,sizeof(mainform.Devices[i].PrismaSingleValue));
          Filestream.ReadBuffer(mainform.Devices[i].PrismaTripleValue,sizeof(mainform.Devices[i].PrismaTripleValue));
          Filestream.ReadBuffer(mainform.Devices[i].PrismaRotOffValue,sizeof(mainform.Devices[i].PrismaRotOffValue));
          Filestream.ReadBuffer(mainform.Devices[i].PrismaRotLeftminValue,sizeof(mainform.Devices[i].PrismaRotLeftminValue));
          Filestream.ReadBuffer(mainform.Devices[i].PrismaRotLeftmaxValue,sizeof(mainform.Devices[i].PrismaRotLeftmaxValue));
          Filestream.ReadBuffer(mainform.Devices[i].PrismaRotRightminValue,sizeof(mainform.Devices[i].PrismaRotRightminValue));
          Filestream.ReadBuffer(mainform.Devices[i].PrismaRotRightmaxValue,sizeof(mainform.Devices[i].PrismaRotRightmaxValue));
          Filestream.ReadBuffer(mainform.Devices[i].PrismaRotChannel,sizeof(mainform.Devices[i].PrismaRotChannel));
          Filestream.ReadBuffer(mainform.Devices[i].IrisCloseValue,sizeof(mainform.Devices[i].IrisCloseValue));
          Filestream.ReadBuffer(mainform.Devices[i].IrisOpenValue,sizeof(mainform.Devices[i].IrisOpenValue));
          Filestream.ReadBuffer(mainform.Devices[i].IrisMinValue,sizeof(mainform.Devices[i].IrisMinValue));
          Filestream.ReadBuffer(mainform.Devices[i].IrisMaxValue,sizeof(mainform.Devices[i].IrisMaxValue));
        end;
      end else
      begin
        mainform.Devices[i].ShutterOpenValue:=255;
        mainform.Devices[i].ShutterCloseValue:=0;
        mainform.Devices[i].ShutterChannel:='SHUTTER';
        mainform.Devices[i].StrobeOffValue:=0;
        mainform.Devices[i].StrobeMinValue:=0;
        mainform.Devices[i].StrobeMaxValue:=0;
        mainform.Devices[i].StrobeChannel:='NOTDEFINED';
        mainform.Devices[i].DimmerOffValue:=0;
        mainform.Devices[i].DimmerMaxValue:=255;
        mainform.Devices[i].FogOffValue:=0;
        mainform.Devices[i].FogMaxValue:=255;
        mainform.Devices[i].Gobo1RotLeftminValue:=0;
        mainform.Devices[i].Gobo1RotLeftValue:=0;
        mainform.Devices[i].Gobo1RotOffValue:=127;
        mainform.Devices[i].Gobo1RotRightminValue:=255;
        mainform.Devices[i].Gobo1RotRightValue:=255;
        mainform.Devices[i].Gobo1RotChannel:='GOBO1ROT';
        mainform.Devices[i].Gobo2RotLeftminValue:=0;
        mainform.Devices[i].Gobo2RotLeftValue:=0;
        mainform.Devices[i].Gobo2RotOffValue:=127;
        mainform.Devices[i].Gobo2RotRightminValue:=255;
        mainform.Devices[i].Gobo2RotRightValue:=255;
        mainform.Devices[i].Gobo2RotChannel:='GOBO2ROT';

        mainform.Devices[i].PrismaSingleValue:=0;
        mainform.Devices[i].PrismaTripleValue:=127;
        mainform.Devices[i].PrismaRotOffValue:=127;
        mainform.Devices[i].PrismaRotLeftminValue:=0;
        mainform.Devices[i].PrismaRotLeftmaxValue:=126;
        mainform.Devices[i].PrismaRotRightminValue:=128;
        mainform.Devices[i].PrismaRotRightmaxValue:=255;
        mainform.Devices[i].PrismaRotChannel:='PRISMAROT';
        mainform.Devices[i].IrisCloseValue:=0;
        mainform.Devices[i].IrisOpenValue:=255;
        mainform.Devices[i].IrisMinValue:=0;
        mainform.Devices[i].IrisMaxValue:=255;
      end;

      Filestream.ReadBuffer(mainform.Devices[i].UseChannelBasedPower,sizeof(mainform.Devices[i].UseChannelBasedPower));
      Filestream.ReadBuffer(mainform.Devices[i].AlwaysOn,sizeof(mainform.Devices[i].AlwaysOn));
      Filestream.ReadBuffer(mainform.Devices[i].ChannelForPower,sizeof(mainform.Devices[i].ChannelForPower));
      Filestream.ReadBuffer(mainform.Devices[i].CalcPowerAboveValue,sizeof(mainform.Devices[i].CalcPowerAboveValue));
      Filestream.ReadBuffer(mainform.Devices[i].Power,sizeof(mainform.Devices[i].Power));
      Filestream.ReadBuffer(mainform.Devices[i].UseFullPowerOnChannelvalue,sizeof(mainform.Devices[i].UseFullPowerOnChannelvalue));
      Filestream.ReadBuffer(mainform.Devices[i].ContinuousPower,sizeof(mainform.Devices[i].ContinuousPower));
      Filestream.ReadBuffer(mainform.Devices[i].Phase,sizeof(mainform.Devices[i].Phase));

      if Version>=479 then
      begin
        Filestream.ReadBuffer(mainform.Devices[i].MatrixDeviceLevel,sizeof(mainform.Devices[i].MatrixDeviceLevel));
        Filestream.ReadBuffer(mainform.Devices[i].MatrixMainDeviceID,sizeof(mainform.Devices[i].MatrixMainDeviceID));
        Filestream.ReadBuffer(mainform.Devices[i].MatrixOrderType,sizeof(mainform.Devices[i].MatrixOrderType));
        Filestream.ReadBuffer(mainform.Devices[i].MatrixXCount,sizeof(mainform.Devices[i].MatrixXCount));
        Filestream.ReadBuffer(mainform.Devices[i].MatrixYCount,sizeof(mainform.Devices[i].MatrixYCount));
        Filestream.ReadBuffer(mainform.Devices[i].MatrixXPosition,sizeof(mainform.Devices[i].MatrixXPosition));
        Filestream.ReadBuffer(mainform.Devices[i].MatrixYPosition,sizeof(mainform.Devices[i].MatrixYPosition));
      end;

  	  Filestream.ReadBuffer(Count2,sizeof(Count2));
      setlength(mainform.Devices[i].KanalMinValue,Count2);
      setlength(mainform.Devices[i].KanalMaxValue,Count2);
      setlength(mainform.Devices[i].kanaltyp,Count2);
      setlength(mainform.Devices[i].kanalname,Count2);
      setlength(mainform.Devices[i].kanalfade,Count2);
      setlength(mainform.Devices[i].kanaldimmcurve,Count2);
      setlength(mainform.Devices[i].kanalabsolutedimmcurve,Count2);
      for j:=0 to Count2-1 do
      begin
     	  Filestream.ReadBuffer(mainform.Devices[i].KanalMinValue[j],sizeof(mainform.Devices[i].KanalMinValue[j]));
     	  Filestream.ReadBuffer(mainform.Devices[i].KanalMaxValue[j],sizeof(mainform.Devices[i].KanalMaxValue[j]));
     	  Filestream.ReadBuffer(mainform.Devices[i].kanaltyp[j],sizeof(mainform.Devices[i].kanaltyp[j]));
     	  Filestream.ReadBuffer(mainform.Devices[i].kanalname[j],sizeof(mainform.Devices[i].kanalname[j]));
     	  Filestream.ReadBuffer(mainform.Devices[i].kanalfade[j],sizeof(mainform.Devices[i].kanalfade[j]));
     	  Filestream.ReadBuffer(mainform.Devices[i].kanaldimmcurve[j],sizeof(mainform.Devices[i].kanaldimmcurve[j]));
     	  Filestream.ReadBuffer(mainform.Devices[i].kanalabsolutedimmcurve[j],sizeof(mainform.Devices[i].kanalabsolutedimmcurve[j]));
        mainform.channel_dimmcurve[mainform.Devices[i].Startaddress+j]:=mainform.Devices[i].kanaldimmcurve[j];
        mainform.channel_absolutedimmcurve[mainform.Devices[i].Startaddress+j]:=mainform.Devices[i].kanalabsolutedimmcurve[j];
      end;
    end;

	  Filestream.ReadBuffer(Count,sizeof(Count));
    setlength(mainform.DeviceGroups,Count);
    for i:=0 to Count-1 do
    begin
   	  Filestream.ReadBuffer(mainform.DeviceGroups[i].Active,sizeof(mainform.DeviceGroups[i].Active));
   	  Filestream.ReadBuffer(mainform.DeviceGroups[i].ID,sizeof(mainform.DeviceGroups[i].ID));
   	  Filestream.ReadBuffer(mainform.DeviceGroups[i].Name,sizeof(mainform.DeviceGroups[i].Name));
   	  Filestream.ReadBuffer(mainform.DeviceGroups[i].Beschreibung,sizeof(mainform.DeviceGroups[i].Beschreibung));
  	  Filestream.ReadBuffer(Count2,sizeof(Count2));
      setlength(mainform.DeviceGroups[i].IDs,Count2);
      setlength(mainform.DeviceGroups[i].IDActive,Count2);
      setlength(mainform.DeviceGroups[i].Delays,Count2);
      for k:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
      begin
     	  Filestream.ReadBuffer(mainform.DeviceGroups[i].IDs[k],sizeof(mainform.DeviceGroups[i].IDs[k]));
     	  Filestream.ReadBuffer(mainform.DeviceGroups[i].IDActive[k],sizeof(mainform.DeviceGroups[i].IDActive[k]));
     	  Filestream.ReadBuffer(mainform.DeviceGroups[i].Delays[k],sizeof(mainform.DeviceGroups[i].Delays[k]));
      end;
      Filestream.ReadBuffer(mainform.DeviceGroups[i].MasterDevice,sizeof(mainform.DeviceGroups[i].MasterDevice));
  	  Filestream.ReadBuffer(mainform.DeviceGroups[i].UseMaster,sizeof(mainform.DeviceGroups[i].UseMaster));
  	  Filestream.ReadBuffer(mainform.DeviceGroups[i].FanMode,sizeof(mainform.DeviceGroups[i].FanMode));
  	  Filestream.ReadBuffer(mainform.DeviceGroups[i].FanMorph,sizeof(mainform.DeviceGroups[i].FanMorph));
  	  Filestream.ReadBuffer(mainform.DeviceGroups[i].Delay,sizeof(mainform.DeviceGroups[i].Delay));
    end;

    FileStream.Free;

    RefreshDeviceControl;
  end;
end;

procedure Tgeraetesteuerung.SaveFile(FileName: String);
var
  i, j, k, Count, Count2, Count3:integer;
begin
  FileStream:=TFileStream.Create(FileName,fmCreate);

  // Projektversion
  Count:=mainform.currentprojectversion;
  Filestream.WriteBuffer(Count, sizeof(Count));

  Count:=length(mainform.Devices);
  Filestream.WriteBuffer(Count,sizeof(Count));
  for i:=0 to Count-1 do
  begin
    Filestream.WriteBuffer(mainform.Devices[i].ID,sizeof(mainform.Devices[i].ID));
    Filestream.WriteBuffer(mainform.Devices[i].Name,sizeof(mainform.Devices[i].Name));
    Filestream.WriteBuffer(mainform.Devices[i].DeviceName,sizeof(mainform.Devices[i].DeviceName));
    Filestream.WriteBuffer(mainform.Devices[i].Beschreibung,sizeof(mainform.Devices[i].Beschreibung));
    Filestream.WriteBuffer(mainform.Devices[i].Vendor,sizeof(mainform.Devices[i].Vendor));
    Filestream.WriteBuffer(mainform.Devices[i].Bildadresse,sizeof(mainform.Devices[i].Bildadresse));
    Filestream.WriteBuffer(mainform.Devices[i].Startaddress,sizeof(mainform.Devices[i].Startaddress));
    Filestream.WriteBuffer(mainform.Devices[i].MaxChan,sizeof(mainform.Devices[i].MaxChan));
    Filestream.WriteBuffer(mainform.Devices[i].invertpan,sizeof(mainform.Devices[i].invertpan));
    Filestream.WriteBuffer(mainform.Devices[i].inverttilt,sizeof(mainform.Devices[i].inverttilt));

    Filestream.WriteBuffer(mainform.Devices[i].typeofscannercalibration,sizeof(mainform.Devices[i].typeofscannercalibration));

    Count2:=17;//length();
    Filestream.WriteBuffer(Count2,sizeof(Count2));
    for j:=0 to Count2-1 do
      Filestream.WriteBuffer(mainform.Devices[i].ScannerCalibrations[j],sizeof(mainform.Devices[i].ScannerCalibrations[j]));

    // Bilddarstellung für Bühnenansicht
    Filestream.WriteBuffer(mainform.Devices[i].ShowInStageView,sizeof(mainform.Devices[i].ShowInStageView));
    Filestream.WriteBuffer(mainform.Devices[i].color,sizeof(mainform.Devices[i].color));
    Filestream.WriteBuffer(mainform.Devices[i].picturesize,sizeof(mainform.Devices[i].picturesize));
    Filestream.WriteBuffer(mainform.Devices[i].pictureangle,sizeof(mainform.Devices[i].pictureangle));
    Filestream.WriteBuffer(mainform.Devices[i].picturefliphor,sizeof(mainform.Devices[i].picturefliphor));
    Filestream.WriteBuffer(mainform.Devices[i].pictureflipver,sizeof(mainform.Devices[i].pictureflipver));
    Filestream.WriteBuffer(mainform.Devices[i].pictureispng,sizeof(mainform.Devices[i].pictureispng));

    Count2:=length(mainform.Devices[i].top);
    Filestream.WriteBuffer(Count2,sizeof(Count2));
    for j:=0 to Count2-1 do
    begin
      Filestream.WriteBuffer(mainform.Devices[i].top[j],sizeof(mainform.Devices[i].top[j]));
      Filestream.WriteBuffer(mainform.Devices[i].left[j],sizeof(mainform.Devices[i].left[j]));
      Filestream.WriteBuffer(mainform.Devices[i].bank[j],sizeof(mainform.Devices[i].bank[j]));
    end;
    Filestream.WriteBuffer(mainform.Devices[i].hasDimmer,sizeof(mainform.Devices[i].hasDIMMER));
    Filestream.WriteBuffer(mainform.Devices[i].hasShutter,sizeof(mainform.Devices[i].hasShutter));
    Filestream.WriteBuffer(mainform.Devices[i].hasVirtualRGBAWDimmer,sizeof(mainform.Devices[i].hasVirtualRGBAWDIMMER));
    Filestream.WriteBuffer(mainform.Devices[i].hasRGB,sizeof(mainform.Devices[i].hasRGB));
    Filestream.WriteBuffer(mainform.Devices[i].hasCMY,sizeof(mainform.Devices[i].hasCMY));
    Filestream.WriteBuffer(mainform.Devices[i].hasAmber,sizeof(mainform.Devices[i].hasAmber));
    Filestream.WriteBuffer(mainform.Devices[i].hasWhite,sizeof(mainform.Devices[i].hasWhite));
    Filestream.WriteBuffer(mainform.Devices[i].hasUV,sizeof(mainform.Devices[i].hasUV));
    Filestream.WriteBuffer(mainform.Devices[i].hasFog,sizeof(mainform.Devices[i].hasFog));
 	  Filestream.WriteBuffer(mainform.Devices[i].UseAmberMixing,sizeof(mainform.Devices[i].UseAmberMixing));
 	  Filestream.WriteBuffer(mainform.Devices[i].AmberMixingCompensateRG,sizeof(mainform.Devices[i].AmberMixingCompensateRG));
 	  Filestream.WriteBuffer(mainform.Devices[i].AmberMixingCompensateBlue,sizeof(mainform.Devices[i].AmberMixingCompensateBlue));
 	  Filestream.WriteBuffer(mainform.Devices[i].AmberRatioR,sizeof(mainform.Devices[i].AmberRatioR));
 	  Filestream.WriteBuffer(mainform.Devices[i].AmberRatioG,sizeof(mainform.Devices[i].AmberRatioG));
    Filestream.WriteBuffer(mainform.Devices[i].hasPANTILT,sizeof(mainform.Devices[i].hasPANTILT));
    Filestream.WriteBuffer(mainform.Devices[i].hasColor,sizeof(mainform.Devices[i].hasColor));
    Filestream.WriteBuffer(mainform.Devices[i].hasColor2,sizeof(mainform.Devices[i].hasColor2));
    Filestream.WriteBuffer(mainform.Devices[i].hasGobo,sizeof(mainform.Devices[i].hasGobo));
    Filestream.WriteBuffer(mainform.Devices[i].hasGobo2,sizeof(mainform.Devices[i].hasGobo2));

    Count2:=length(mainform.Devices[i].colors);
    Filestream.WriteBuffer(Count2,sizeof(Count2));
    for j:=0 to Count2-1 do
    begin
      Filestream.WriteBuffer(mainform.Devices[i].colors[j],sizeof(mainform.Devices[i].colors[j]));
      Filestream.WriteBuffer(mainform.Devices[i].colorlevels[j],sizeof(mainform.Devices[i].colorlevels[j]));
      Filestream.WriteBuffer(mainform.Devices[i].colorendlevels[j],sizeof(mainform.Devices[i].colorendlevels[j]));
      Filestream.WriteBuffer(mainform.Devices[i].colornames[j],sizeof(mainform.Devices[i].colornames[j]));
    end;
    Filestream.WriteBuffer(mainform.Devices[i].colortolerance,sizeof(mainform.Devices[i].colortolerance));
    Filestream.WriteBuffer(mainform.Devices[i].autoscening,sizeof(mainform.Devices[i].autoscening));

    Count2:=length(mainform.Devices[i].colors2);
    Filestream.WriteBuffer(Count2,sizeof(Count2));
    for j:=0 to Count2-1 do
    begin
      Filestream.WriteBuffer(mainform.Devices[i].colors2[j],sizeof(mainform.Devices[i].colors2[j]));
      Filestream.WriteBuffer(mainform.Devices[i].colorlevels2[j],sizeof(mainform.Devices[i].colorlevels2[j]));
      Filestream.WriteBuffer(mainform.Devices[i].colorendlevels2[j],sizeof(mainform.Devices[i].colorendlevels2[j]));
      Filestream.WriteBuffer(mainform.Devices[i].colornames2[j],sizeof(mainform.Devices[i].colornames2[j]));
    end;
    Count2:=length(mainform.Devices[i].gobos);
    Filestream.WriteBuffer(Count2,sizeof(Count2));
    for j:=0 to Count2-1 do
    begin
      Filestream.WriteBuffer(mainform.Devices[i].gobos[j],sizeof(mainform.Devices[i].gobos[j]));
      Filestream.WriteBuffer(mainform.Devices[i].gobolevels[j],sizeof(mainform.Devices[i].gobolevels[j]));
      Filestream.WriteBuffer(mainform.Devices[i].goboendlevels[j],sizeof(mainform.Devices[i].goboendlevels[j]));
      Filestream.WriteBuffer(mainform.Devices[i].gobonames[j],sizeof(mainform.Devices[i].gobonames[j]));
      Count3:=length(mainform.Devices[i].bestgobos[j]);
      Filestream.WriteBuffer(Count3,sizeof(Count3));
      for k:=0 to length(mainform.Devices[i].bestgobos[j])-1 do
      begin
        Filestream.WriteBuffer(mainform.Devices[i].bestgobos[j][k].GoboName,sizeof(mainform.Devices[i].bestgobos[j][k].GoboName));
        Filestream.WriteBuffer(mainform.Devices[i].bestgobos[j][k].Percent,sizeof(mainform.Devices[i].bestgobos[j][k].Percent));
      end;
    end;
    Count2:=length(mainform.Devices[i].gobos2);
    Filestream.WriteBuffer(Count2,sizeof(Count2));
    for j:=0 to Count2-1 do
    begin
      Filestream.WriteBuffer(mainform.Devices[i].gobos2[j],sizeof(mainform.Devices[i].gobos2[j]));
      Filestream.WriteBuffer(mainform.Devices[i].gobolevels2[j],sizeof(mainform.Devices[i].gobolevels2[j]));
      Filestream.WriteBuffer(mainform.Devices[i].goboendlevels2[j],sizeof(mainform.Devices[i].goboendlevels2[j]));
      Filestream.WriteBuffer(mainform.Devices[i].gobonames2[j],sizeof(mainform.Devices[i].gobonames2[j]));
      Count3:=length(mainform.Devices[i].bestgobos2[j]);
      Filestream.WriteBuffer(Count3,sizeof(Count3));
      for k:=0 to length(mainform.Devices[i].bestgobos2[j])-1 do
      begin
        Filestream.WriteBuffer(mainform.Devices[i].bestgobos2[j][k].GoboName,sizeof(mainform.Devices[i].bestgobos2[j][k].GoboName));
        Filestream.WriteBuffer(mainform.Devices[i].bestgobos2[j][k].Percent,sizeof(mainform.Devices[i].bestgobos2[j][k].Percent));
      end;
    end;

    Filestream.WriteBuffer(mainform.Devices[i].ShutterOpenValue,sizeof(mainform.Devices[i].ShutterOpenValue));
    Filestream.WriteBuffer(mainform.Devices[i].ShutterCloseValue,sizeof(mainform.Devices[i].ShutterCloseValue));
    Filestream.WriteBuffer(mainform.Devices[i].ShutterChannel,sizeof(mainform.Devices[i].ShutterChannel));
    Filestream.WriteBuffer(mainform.Devices[i].StrobeOffValue,sizeof(mainform.Devices[i].StrobeOffValue));
    Filestream.WriteBuffer(mainform.Devices[i].StrobeMinValue,sizeof(mainform.Devices[i].StrobeMinValue));
    Filestream.WriteBuffer(mainform.Devices[i].StrobeMaxValue,sizeof(mainform.Devices[i].StrobeMaxValue));
    Filestream.WriteBuffer(mainform.Devices[i].StrobeChannel,sizeof(mainform.Devices[i].StrobeChannel));
    Filestream.WriteBuffer(mainform.Devices[i].DimmerOffValue,sizeof(mainform.Devices[i].DimmerOffValue));
    Filestream.WriteBuffer(mainform.Devices[i].DimmerMaxValue,sizeof(mainform.Devices[i].DimmerMaxValue));
    Filestream.WriteBuffer(mainform.Devices[i].FogOffValue,sizeof(mainform.Devices[i].FogOffValue));
    Filestream.WriteBuffer(mainform.Devices[i].FogMaxValue,sizeof(mainform.Devices[i].FogMaxValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo1RotLeftminValue,sizeof(mainform.Devices[i].Gobo1RotLeftminValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo1RotLeftValue,sizeof(mainform.Devices[i].Gobo1RotLeftValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo1RotOffValue,sizeof(mainform.Devices[i].Gobo1RotOffValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo1RotRightminValue,sizeof(mainform.Devices[i].Gobo1RotRightminValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo1RotRightValue,sizeof(mainform.Devices[i].Gobo1RotRightValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo1RotChannel,sizeof(mainform.Devices[i].Gobo1RotChannel));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo2RotLeftminValue,sizeof(mainform.Devices[i].Gobo2RotLeftminValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo2RotLeftValue,sizeof(mainform.Devices[i].Gobo2RotLeftValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo2RotOffValue,sizeof(mainform.Devices[i].Gobo2RotOffValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo2RotRightminValue,sizeof(mainform.Devices[i].Gobo2RotRightminValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo2RotRightValue,sizeof(mainform.Devices[i].Gobo2RotRightValue));
    Filestream.WriteBuffer(mainform.Devices[i].Gobo2RotChannel,sizeof(mainform.Devices[i].Gobo2RotChannel));

    Filestream.WriteBuffer(mainform.Devices[i].PrismaSingleValue,sizeof(mainform.Devices[i].PrismaSingleValue));
    Filestream.WriteBuffer(mainform.Devices[i].PrismaTripleValue,sizeof(mainform.Devices[i].PrismaTripleValue));
    Filestream.WriteBuffer(mainform.Devices[i].PrismaRotOffValue,sizeof(mainform.Devices[i].PrismaRotOffValue));
    Filestream.WriteBuffer(mainform.Devices[i].PrismaRotLeftminValue,sizeof(mainform.Devices[i].PrismaRotLeftminValue));
    Filestream.WriteBuffer(mainform.Devices[i].PrismaRotLeftmaxValue,sizeof(mainform.Devices[i].PrismaRotLeftmaxValue));
    Filestream.WriteBuffer(mainform.Devices[i].PrismaRotRightminValue,sizeof(mainform.Devices[i].PrismaRotRightminValue));
    Filestream.WriteBuffer(mainform.Devices[i].PrismaRotRightmaxValue,sizeof(mainform.Devices[i].PrismaRotRightmaxValue));
    Filestream.WriteBuffer(mainform.Devices[i].PrismaRotChannel,sizeof(mainform.Devices[i].PrismaRotChannel));
    Filestream.WriteBuffer(mainform.Devices[i].IrisCloseValue,sizeof(mainform.Devices[i].IrisCloseValue));
    Filestream.WriteBuffer(mainform.Devices[i].IrisOpenValue,sizeof(mainform.Devices[i].IrisOpenValue));
    Filestream.WriteBuffer(mainform.Devices[i].IrisMinValue,sizeof(mainform.Devices[i].IrisMinValue));
    Filestream.WriteBuffer(mainform.Devices[i].IrisMaxValue,sizeof(mainform.Devices[i].IrisMaxValue));

    Filestream.WriteBuffer(mainform.Devices[i].UseChannelBasedPower,sizeof(mainform.Devices[i].UseChannelBasedPower));
    Filestream.WriteBuffer(mainform.Devices[i].AlwaysOn,sizeof(mainform.Devices[i].AlwaysOn));
    Filestream.WriteBuffer(mainform.Devices[i].ChannelForPower,sizeof(mainform.Devices[i].ChannelForPower));
    Filestream.WriteBuffer(mainform.Devices[i].CalcPowerAboveValue,sizeof(mainform.Devices[i].CalcPowerAboveValue));
    Filestream.WriteBuffer(mainform.Devices[i].Power,sizeof(mainform.Devices[i].Power));
    Filestream.WriteBuffer(mainform.Devices[i].UseFullPowerOnChannelvalue,sizeof(mainform.Devices[i].UseFullPowerOnChannelvalue));
    Filestream.WriteBuffer(mainform.Devices[i].ContinuousPower,sizeof(mainform.Devices[i].ContinuousPower));
    Filestream.WriteBuffer(mainform.Devices[i].Phase,sizeof(mainform.Devices[i].Phase));

    Filestream.WriteBuffer(mainform.Devices[i].MatrixDeviceLevel,sizeof(mainform.Devices[i].MatrixDeviceLevel));
    Filestream.WriteBuffer(mainform.Devices[i].MatrixMainDeviceID,sizeof(mainform.Devices[i].MatrixMainDeviceID));
    Filestream.WriteBuffer(mainform.Devices[i].MatrixOrderType,sizeof(mainform.Devices[i].MatrixOrderType));
    Filestream.WriteBuffer(mainform.Devices[i].MatrixXCount,sizeof(mainform.Devices[i].MatrixXCount));
    Filestream.WriteBuffer(mainform.Devices[i].MatrixYCount,sizeof(mainform.Devices[i].MatrixYCount));
    Filestream.WriteBuffer(mainform.Devices[i].MatrixXPosition,sizeof(mainform.Devices[i].MatrixXPosition));
    Filestream.WriteBuffer(mainform.Devices[i].MatrixYPosition,sizeof(mainform.Devices[i].MatrixYPosition));

    Count2:=length(mainform.Devices[i].kanaltyp);
    Filestream.WriteBuffer(Count2,sizeof(Count2));
    for j:=0 to length(mainform.Devices[i].kanaltyp)-1 do
    begin
      Filestream.WriteBuffer(mainform.Devices[i].KanalMinValue[j],sizeof(mainform.Devices[i].KanalMinValue[j]));
      Filestream.WriteBuffer(mainform.Devices[i].KanalMaxValue[j],sizeof(mainform.Devices[i].KanalMaxValue[j]));
      Filestream.WriteBuffer(mainform.Devices[i].kanaltyp[j],sizeof(mainform.Devices[i].kanaltyp[j]));
      Filestream.WriteBuffer(mainform.Devices[i].kanalname[j],sizeof(mainform.Devices[i].kanalname[j]));
      Filestream.WriteBuffer(mainform.Devices[i].kanalfade[j],sizeof(mainform.Devices[i].kanalfade[j]));
      Filestream.WriteBuffer(mainform.Devices[i].kanaldimmcurve[j],sizeof(mainform.Devices[i].kanaldimmcurve[j]));
      Filestream.WriteBuffer(mainform.Devices[i].kanalabsolutedimmcurve[j],sizeof(mainform.Devices[i].kanalabsolutedimmcurve[j]));
    end;
  end;

  Count:=length(mainform.DeviceGroups);
  Filestream.WriteBuffer(Count,sizeof(Count));
  for i:=0 to Count-1 do
  begin
    Filestream.WriteBuffer(mainform.DeviceGroups[i].Active,sizeof(mainform.DeviceGroups[i].Active));
    Filestream.WriteBuffer(mainform.DeviceGroups[i].ID,sizeof(mainform.DeviceGroups[i].ID));
    Filestream.WriteBuffer(mainform.DeviceGroups[i].Name,sizeof(mainform.DeviceGroups[i].Name));
    Filestream.WriteBuffer(mainform.DeviceGroups[i].Beschreibung,sizeof(mainform.DeviceGroups[i].Beschreibung));
    Count2:=length(mainform.DeviceGroups[i].IDs);
    Filestream.WriteBuffer(Count2,sizeof(Count2));
    for k:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
    begin
      Filestream.WriteBuffer(mainform.DeviceGroups[i].IDs[k],sizeof(mainform.DeviceGroups[i].IDs[k]));
      Filestream.WriteBuffer(mainform.DeviceGroups[i].IDActive[k],sizeof(mainform.DeviceGroups[i].IDActive[k]));
      Filestream.WriteBuffer(mainform.DeviceGroups[i].Delays[k],sizeof(mainform.DeviceGroups[i].Delays[k]));
    end;
    Filestream.WriteBuffer(mainform.DeviceGroups[i].MasterDevice,sizeof(mainform.DeviceGroups[i].MasterDevice));
    Filestream.WriteBuffer(mainform.DeviceGroups[i].UseMaster,sizeof(mainform.DeviceGroups[i].UseMaster));
    Filestream.WriteBuffer(mainform.DeviceGroups[i].FanMode,sizeof(mainform.DeviceGroups[i].FanMode));
    Filestream.WriteBuffer(mainform.DeviceGroups[i].FanMorph,sizeof(mainform.DeviceGroups[i].FanMorph));
    Filestream.WriteBuffer(mainform.DeviceGroups[i].Delay,sizeof(mainform.DeviceGroups[i].Delay));
  end;

  FileStream.Free;
end;

procedure Tgeraetesteuerung.Gerthinzufgen1Click(Sender: TObject);
var
  i,j,k,l,m,mx,my,offset, matrixoffset, newdevicesstart, space, devposition:integer;
  bildname, bildpfad:string;
  NewDeviceWithGobos:boolean;
  MatrixMainDeviceID:TGUID;
  PicturesInCols, CurrentRow:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if adddevice=nil then
    adddevice:=Tadddevice.Create(adddevice);

  NewDeviceWithGobos:=false;

//  adddevice.adddeviceicon.checked:=(Sender=grafischebuehnenansicht);
  adddevice.ShowModal;

  if adddevice.modalresult=mrOK then
  begin
    newdevicesstart:=length(mainform.devices);

    if (adddevice.VST.SelectedCount=1) and adddevice.DeviceSelectionOK then
    begin
      offset:=strtoint(adddevice.Edit3.Text)-1;

      devposition:=adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype);

      ProgressScreenSmall.Label1.Caption:=_('Geräte hinzufügen...');
      ProgressScreenSmall.Label2.Caption:=_('Es werden ')+adddevice.Edit2.Text+_(' Geräte hinzugefügt.');
      ProgressScreenSmall.ProgressBar1.Max:=strtoint(adddevice.Edit2.Text)+deviceprototyp[devposition].MatrixXCount+deviceprototyp[devposition].MatrixYCount;
      ProgressScreenSmall.Show;

      if deviceprototyp[devposition].MatrixXCount<1 then
        deviceprototyp[devposition].MatrixXCount:=1;
      if deviceprototyp[devposition].MatrixYCount<1 then
        deviceprototyp[devposition].MatrixYCount:=1;

      matrixoffset:=0;
      for k:=0 to strtoint(adddevice.Edit2.Text)-1 do
      for m:=0 to (deviceprototyp[devposition].MatrixXCount*deviceprototyp[devposition].MatrixYCount)-1 do
      begin
        my:=0;
        mx:=0;
        case deviceprototyp[devposition].MatrixOrdertype of
          1:
          begin
            my:=trunc(m/deviceprototyp[devposition].MatrixXCount);
            mx:=m-(my*deviceprototyp[devposition].MatrixXCount);
          end;
          2:
          begin
            my:=trunc(m/deviceprototyp[devposition].MatrixXCount);
            if ((my mod 2) = 0) then
            begin
              // gerade Reihe (von links nach rechts)
              mx:=m-(my*deviceprototyp[devposition].MatrixXCount);
            end else
            begin
              // ungerade Reihe (von rechts nach links)
              mx:=(deviceprototyp[devposition].MatrixXCount-1)-(m-(my*deviceprototyp[devposition].MatrixXCount));
            end;
          end;
          3:
          begin
            mx:=trunc(m/deviceprototyp[devposition].MatrixYCount);
            my:=m-(mx*deviceprototyp[devposition].MatrixYCount);
          end;
          4:
          begin
            mx:=trunc(m/deviceprototyp[devposition].MatrixYCount);
            if ((mx mod 2) = 0) then
            begin
              // gerade Spalte (von links nach rechts)
              my:=m-(mx*deviceprototyp[devposition].MatrixYCount);
            end else
            begin
              // ungerade Spalte (von rechts nach links)
              my:=(deviceprototyp[devposition].MatrixYCount-1)-(m-(mx*deviceprototyp[devposition].MatrixYCount));
            end;
          end;
        end;

        if k>0 then
          space:=strtoint(adddevice.Edit4.text)
        else
          space:=0;

        if (offset+space+k*deviceprototyp[devposition].MaxChan+(mx+my)*deviceprototyp[devposition].MaxChan)+deviceprototyp[devposition].MaxChan>mainform.lastchan then
        begin
          if mainform.lastchan<chan then
            ShowMessage(_('Das zu erstellende Gerät liegt außerhalb der möglichen Kanäle (')+inttostr(mainform.lastchan)+_('). In den erweiterten Optionen kann die maximale Kanalzahl auf ')+inttostr(chan)+_(' erhöht werden.')+#13#10#13#10+_('Das Hinzufügen neuer Geräte wird nun abgebrochen.'))
          else
            ShowMessage(_('Das zu erstellende Gerät liegt außerhalb der möglichen Kanäle (')+inttostr(mainform.lastchan)+_('). Diese Software unterstützt maximal ')+inttostr(chan)+_(' Kanäle. Sollten mehr als diese Kanäle benötigt werden, wenden Sie sich bitte an christian@noeding-online.de, bzw. auf der Website http://www.pcdimmer.de, um die Software entsprechend anpassen zu lassen.')+#13#10#13#10+_('Das Hinzufügen neuer Geräte wird nun abgebrochen.'));
          break;
        end;

        if ((k+mx+my) mod 10 = 0) or (strtoint(adddevice.Edit2.Text)+mx+my<20) then
        begin
          ProgressScreenSmall.ProgressBar1.Position:=k+mx+my+1;
//          ProgressScreenSmall.ProgressBar1.Refresh;
          ProgressScreenSmall.Refresh;
        end;

        // Grundkonfiguration des neuen Gerätes
        setlength(mainform.Devices,length(mainform.Devices)+1);
        setlength(mainform.DeviceSelected,length(mainform.Devices)+1);

        CreateGUID(mainform.Devices[length(mainform.Devices)-1].ID);
        Position:=mainform.Devices[length(mainform.Devices)-1].ID;

        mainform.Devices[length(mainform.Devices)-1].startaddress:=1+(offset+matrixoffset+space*k+(k+m)*deviceprototyp[devposition].MaxChan);


        // Matrix-Funktionen
        if DevicePrototyp[devposition].IsMatrixDevice then
        begin
          if ((mx+my)=0) then
            mainform.devices[length(mainform.Devices)-1].MatrixDeviceLevel:=1
          else
            mainform.devices[length(mainform.Devices)-1].MatrixDeviceLevel:=2;
        end else
          mainform.devices[length(mainform.Devices)-1].MatrixDeviceLevel:=0;

        if mainform.devices[length(mainform.Devices)-1].MatrixDeviceLevel<2 then
        begin
          MatrixMainDeviceID:=mainform.Devices[length(mainform.Devices)-1].ID;
        end;
        mainform.devices[length(mainform.Devices)-1].MatrixMainDeviceID:=MatrixMainDeviceID;
        mainform.devices[length(mainform.Devices)-1].MatrixOrderType:=deviceprototyp[devposition].MatrixOrderType;
        mainform.devices[length(mainform.Devices)-1].MatrixXCount:=deviceprototyp[devposition].MatrixXCount;
        mainform.devices[length(mainform.Devices)-1].MatrixYCount:=deviceprototyp[devposition].MatrixYCount;
        mainform.devices[length(mainform.Devices)-1].MatrixXPosition:=mx;
        mainform.devices[length(mainform.Devices)-1].MatrixYPosition:=my;


        // Kanal- und Geräteeinstellungen
        if mainform.Devices[length(mainform.Devices)-1].MatrixDeviceLevel=1 then
          mainform.Devices[length(mainform.Devices)-1].Name:='[M] '+deviceprototyp[devposition].Name
        else if mainform.Devices[length(mainform.Devices)-1].MatrixDeviceLevel=2 then
          mainform.Devices[length(mainform.Devices)-1].Name:='[M '+inttostr(mx+1)+'x'+inttostr(my+1)+'] '+deviceprototyp[devposition].Name
        else
          mainform.Devices[length(mainform.Devices)-1].Name:=deviceprototyp[devposition].Name;
        mainform.Devices[length(mainform.Devices)-1].DeviceName:=deviceprototyp[devposition].DeviceName;
        mainform.Devices[length(mainform.Devices)-1].Vendor:=deviceprototyp[devposition].Vendor;
        mainform.Devices[length(mainform.Devices)-1].Beschreibung:=deviceprototyp[devposition].Beschreibung;
        mainform.Devices[length(mainform.Devices)-1].Bildadresse:=deviceprototyp[devposition].Bildadresse;
        mainform.Devices[length(mainform.Devices)-1].MaxChan:=deviceprototyp[devposition].MaxChan;
        mainform.Devices[length(mainform.Devices)-1].color:=clWhite;
        mainform.Devices[length(mainform.Devices)-1].hasDimmer:=deviceprototyp[devposition].hasDimmer;
        mainform.Devices[length(mainform.Devices)-1].hasShutter:=deviceprototyp[devposition].hasShutter;
        mainform.Devices[length(mainform.Devices)-1].hasVirtualRGBAWDimmer:=deviceprototyp[devposition].hasVirtualRGBAWDimmer;
        mainform.Devices[length(mainform.Devices)-1].hasRGB:=deviceprototyp[devposition].hasRGB;
        mainform.Devices[length(mainform.Devices)-1].hasCMY:=deviceprototyp[devposition].hasCMY;
        mainform.Devices[length(mainform.Devices)-1].hasAmber:=deviceprototyp[devposition].hasAmber;
        mainform.Devices[length(mainform.Devices)-1].hasWhite:=deviceprototyp[devposition].hasWhite;
        mainform.Devices[length(mainform.Devices)-1].hasUV:=deviceprototyp[devposition].hasUV;
        mainform.Devices[length(mainform.Devices)-1].hasFog:=deviceprototyp[devposition].hasFog;
        mainform.Devices[length(mainform.Devices)-1].UseAmberMixing:=deviceprototyp[devposition].UseAmberMixing;
        mainform.Devices[length(mainform.Devices)-1].AmberMixingCompensateRG:=deviceprototyp[devposition].AmberMixingCompensateRG;
        mainform.Devices[length(mainform.Devices)-1].AmberMixingCompensateBlue:=deviceprototyp[devposition].AmberMixingCompensateBlue;
        mainform.Devices[length(mainform.Devices)-1].AmberRatioR:=deviceprototyp[devposition].AmberRatioR;
        mainform.Devices[length(mainform.Devices)-1].AmberRatioG:=deviceprototyp[devposition].AmberRatioG;
        mainform.Devices[length(mainform.Devices)-1].hasPANTILT:=deviceprototyp[devposition].hasPANTILT;
        mainform.Devices[length(mainform.Devices)-1].hasColor:=deviceprototyp[devposition].hasColor;
        mainform.Devices[length(mainform.Devices)-1].hasColor2:=deviceprototyp[devposition].hasColor2;
        mainform.Devices[length(mainform.Devices)-1].hasGobo:=deviceprototyp[devposition].hasGobo;
        mainform.Devices[length(mainform.Devices)-1].hasGobo2:=deviceprototyp[devposition].hasGobo2;
        mainform.Devices[length(mainform.Devices)-1].picturesize:=32;
        mainform.Devices[length(mainform.Devices)-1].pictureangle:=0;
        mainform.Devices[length(mainform.Devices)-1].pictureispng:=true;
        mainform.Devices[length(mainform.Devices)-1].picturefliphor:=false;
        mainform.Devices[length(mainform.Devices)-1].pictureflipver:=false;
        mainform.Devices[length(mainform.Devices)-1].autoscening:=mainform.Devices[length(mainform.Devices)-1].hasRGB or mainform.Devices[length(mainform.Devices)-1].hasCMY or mainform.Devices[length(mainform.Devices)-1].hasCOLOR;

        mainform.devices[length(mainform.Devices)-1].ShutterOpenValue:=DevicePrototyp[devposition].ShutterOpenValue;
        mainform.devices[length(mainform.Devices)-1].ShutterCloseValue:=DevicePrototyp[devposition].ShutterCloseValue;
        mainform.devices[length(mainform.Devices)-1].ShutterChannel:=DevicePrototyp[devposition].ShutterChannel;
        mainform.devices[length(mainform.Devices)-1].StrobeOffValue:=DevicePrototyp[devposition].StrobeOffValue;
        mainform.devices[length(mainform.Devices)-1].StrobeMinValue:=DevicePrototyp[devposition].StrobeMinValue;
        mainform.devices[length(mainform.Devices)-1].StrobeMaxValue:=DevicePrototyp[devposition].StrobeMaxValue;
        mainform.devices[length(mainform.Devices)-1].StrobeChannel:=DevicePrototyp[devposition].StrobeChannel;
        mainform.devices[length(mainform.Devices)-1].DimmerOffValue:=DevicePrototyp[devposition].DimmerOffValue;
        mainform.devices[length(mainform.Devices)-1].DimmerMaxValue:=DevicePrototyp[devposition].DimmerMaxValue;
        mainform.devices[length(mainform.Devices)-1].FogOffValue:=DevicePrototyp[devposition].FogOffValue;
        mainform.devices[length(mainform.Devices)-1].FogMaxValue:=DevicePrototyp[devposition].FogMaxValue;
        mainform.devices[length(mainform.Devices)-1].Gobo1RotLeftminValue:=DevicePrototyp[devposition].Gobo1RotLeftminValue;
        mainform.devices[length(mainform.Devices)-1].Gobo1RotLeftValue:=DevicePrototyp[devposition].Gobo1RotLeftValue;
        mainform.devices[length(mainform.Devices)-1].Gobo1RotOffValue:=DevicePrototyp[devposition].Gobo1RotOffValue;
        mainform.devices[length(mainform.Devices)-1].Gobo1RotRightminValue:=DevicePrototyp[devposition].Gobo1RotRightminValue;
        mainform.devices[length(mainform.Devices)-1].Gobo1RotRightValue:=DevicePrototyp[devposition].Gobo1RotRightValue;
        mainform.devices[length(mainform.Devices)-1].Gobo1RotChannel:=DevicePrototyp[devposition].Gobo1RotChannel;
        mainform.devices[length(mainform.Devices)-1].Gobo2RotLeftminValue:=DevicePrototyp[devposition].Gobo2RotLeftminValue;
        mainform.devices[length(mainform.Devices)-1].Gobo2RotLeftValue:=DevicePrototyp[devposition].Gobo2RotLeftValue;
        mainform.devices[length(mainform.Devices)-1].Gobo2RotOffValue:=DevicePrototyp[devposition].Gobo2RotOffValue;
        mainform.devices[length(mainform.Devices)-1].Gobo2RotRightminValue:=DevicePrototyp[devposition].Gobo2RotRightminValue;
        mainform.devices[length(mainform.Devices)-1].Gobo2RotRightValue:=DevicePrototyp[devposition].Gobo2RotRightValue;
        mainform.devices[length(mainform.Devices)-1].Gobo2RotChannel:=DevicePrototyp[devposition].Gobo2RotChannel;

        mainform.devices[length(mainform.Devices)-1].PrismaSingleValue:=DevicePrototyp[devposition].PrismaSingleValue;
        mainform.devices[length(mainform.Devices)-1].PrismaTripleValue:=DevicePrototyp[devposition].PrismaTripleValue;
        mainform.devices[length(mainform.Devices)-1].PrismaRotOffValue:=DevicePrototyp[devposition].PrismaRotOffValue;
        mainform.devices[length(mainform.Devices)-1].PrismaRotLeftminValue:=DevicePrototyp[devposition].PrismaRotLeftminValue;
        mainform.devices[length(mainform.Devices)-1].PrismaRotLeftmaxValue:=DevicePrototyp[devposition].PrismaRotLeftmaxValue;
        mainform.devices[length(mainform.Devices)-1].PrismaRotRightminValue:=DevicePrototyp[devposition].PrismaRotRightminValue;
        mainform.devices[length(mainform.Devices)-1].PrismaRotRightmaxValue:=DevicePrototyp[devposition].PrismaRotRightmaxValue;
        mainform.devices[length(mainform.Devices)-1].PrismaRotChannel:=DevicePrototyp[devposition].PrismaRotChannel;
        mainform.devices[length(mainform.Devices)-1].IrisCloseValue:=DevicePrototyp[devposition].IrisCloseValue;
        mainform.devices[length(mainform.Devices)-1].IrisOpenValue:=DevicePrototyp[devposition].IrisOpenValue;
        mainform.devices[length(mainform.Devices)-1].IrisMinValue:=DevicePrototyp[devposition].IrisMinValue;
        mainform.devices[length(mainform.Devices)-1].IrisMaxValue:=DevicePrototyp[devposition].IrisMaxValue;

        if not NewDeviceWithGobos then
          NewDeviceWithGobos:=mainform.Devices[length(mainform.Devices)-1].hasGobo or mainform.Devices[length(mainform.Devices)-1].hasGobo2;

        // Ein einzelnes Gerätebild in der Bühnenansicht anzeigen
        setlength(mainform.Devices[length(mainform.Devices)-1].top,1);
        setlength(mainform.Devices[length(mainform.Devices)-1].left,1);
        setlength(mainform.Devices[length(mainform.Devices)-1].bank,1);
        setlength(mainform.Devices[length(mainform.Devices)-1].selected,1);
        setlength(mainform.Devices[length(mainform.Devices)-1].OldPos,1);

        // neue Bilder der Reihe nach anordnen und ggfs. mehrere Zeilen bilden
        if deviceprototyp[devposition].IsMatrixDevice then
        begin
          mainform.Devices[length(mainform.Devices)-1].left[0]:=mx*32;
          mainform.Devices[length(mainform.Devices)-1].top[0]:=my*32;
        end else
        begin
          PicturesInCols:=trunc(grafischebuehnenansicht.Paintbox1.Width/32);
          CurrentRow:=trunc(k/PicturesInCols);
          mainform.Devices[length(mainform.Devices)-1].left[0]:=k*32-(CurrentRow*PicturesInCols*32);
          mainform.Devices[length(mainform.Devices)-1].top[0]:=CurrentRow*32;
        end;

        setlength(mainform.Devices[length(mainform.Devices)-1].KanalMinValue,mainform.devices[length(mainform.devices)-1].MaxChan);
        setlength(mainform.Devices[length(mainform.Devices)-1].KanalMaxValue,mainform.devices[length(mainform.devices)-1].MaxChan);
        setlength(mainform.Devices[length(mainform.Devices)-1].kanaltyp,mainform.devices[length(mainform.devices)-1].MaxChan);
        setlength(mainform.Devices[length(mainform.Devices)-1].kanalname,mainform.devices[length(mainform.devices)-1].MaxChan);
        setlength(mainform.Devices[length(mainform.Devices)-1].kanalfade,mainform.devices[length(mainform.devices)-1].MaxChan);
        setlength(mainform.Devices[length(mainform.Devices)-1].kanaldimmcurve,mainform.devices[length(mainform.devices)-1].MaxChan);
        setlength(mainform.Devices[length(mainform.Devices)-1].kanalabsolutedimmcurve,mainform.devices[length(mainform.devices)-1].MaxChan);

        for i:=0 to mainform.devices[length(mainform.devices)-1].MaxChan-1 do
        begin
          mainform.Devices[length(mainform.Devices)-1].KanalMinValue[i]:=deviceprototyp[devposition].KanalMinValue[i];
          mainform.Devices[length(mainform.Devices)-1].KanalMaxValue[i]:=deviceprototyp[devposition].KanalMaxValue[i];
          mainform.Devices[length(mainform.Devices)-1].kanaltyp[i]:=deviceprototyp[devposition].kanaltyp[i];
          mainform.Devices[length(mainform.Devices)-1].kanalname[i]:=deviceprototyp[devposition].kanalname[i];
          mainform.Devices[length(mainform.Devices)-1].kanalfade[i]:=deviceprototyp[devposition].kanalfade[i];

          mainform.data.Names[mainform.Devices[length(mainform.Devices)-1].Startaddress+i]:=deviceprototyp[devposition].Name+': '+deviceprototyp[devposition].kanalname[i];
        end;

        setlength(mainform.Devices[length(mainform.Devices)-1].colors,length(deviceprototyp[devposition].colors));
        setlength(mainform.Devices[length(mainform.Devices)-1].colorlevels,length(deviceprototyp[devposition].colorlevels));
        setlength(mainform.Devices[length(mainform.Devices)-1].colorendlevels,length(deviceprototyp[devposition].colorendlevels));
        setlength(mainform.Devices[length(mainform.Devices)-1].colornames,length(deviceprototyp[devposition].colornames));
        for i:=0 to length(mainform.devices[length(mainform.devices)-1].colors)-1 do
        begin
          mainform.Devices[length(mainform.Devices)-1].colors[i]:=deviceprototyp[devposition].colors[i];
          mainform.Devices[length(mainform.Devices)-1].colorlevels[i]:=deviceprototyp[devposition].colorlevels[i];
          mainform.Devices[length(mainform.Devices)-1].colorendlevels[i]:=deviceprototyp[devposition].colorendlevels[i];
          mainform.Devices[length(mainform.Devices)-1].colornames[i]:=deviceprototyp[devposition].colornames[i];
        end;
        setlength(mainform.Devices[length(mainform.Devices)-1].colors2,length(deviceprototyp[devposition].colors2));
        setlength(mainform.Devices[length(mainform.Devices)-1].colorlevels2,length(deviceprototyp[devposition].colorlevels2));
        setlength(mainform.Devices[length(mainform.Devices)-1].colorendlevels2,length(deviceprototyp[devposition].colorendlevels2));
        setlength(mainform.Devices[length(mainform.Devices)-1].colornames2,length(deviceprototyp[devposition].colornames2));
        for i:=0 to length(mainform.devices[length(mainform.devices)-1].colors2)-1 do
        begin
          mainform.Devices[length(mainform.Devices)-1].colors2[i]:=deviceprototyp[devposition].colors2[i];
          mainform.Devices[length(mainform.Devices)-1].colorlevels2[i]:=deviceprototyp[devposition].colorlevels2[i];
          mainform.Devices[length(mainform.Devices)-1].colorendlevels2[i]:=deviceprototyp[devposition].colorendlevels2[i];
          mainform.Devices[length(mainform.Devices)-1].colornames2[i]:=deviceprototyp[devposition].colornames2[i];
        end;

        setlength(mainform.Devices[length(mainform.Devices)-1].gobos,length(deviceprototyp[devposition].gobos));
        setlength(mainform.Devices[length(mainform.Devices)-1].gobolevels,length(deviceprototyp[devposition].gobolevels));
        setlength(mainform.Devices[length(mainform.Devices)-1].goboendlevels,length(deviceprototyp[devposition].goboendlevels));
        setlength(mainform.Devices[length(mainform.Devices)-1].gobonames,length(deviceprototyp[devposition].gobonames));
        setlength(mainform.Devices[length(mainform.Devices)-1].bestgobos,length(deviceprototyp[devposition].gobos));
        for i:=0 to length(mainform.devices[length(mainform.devices)-1].gobos)-1 do
        begin
          mainform.Devices[length(mainform.Devices)-1].gobos[i]:=deviceprototyp[devposition].gobos[i];
          mainform.Devices[length(mainform.Devices)-1].gobolevels[i]:=deviceprototyp[devposition].gobolevels[i];
          mainform.Devices[length(mainform.Devices)-1].goboendlevels[i]:=deviceprototyp[devposition].goboendlevels[i];
          mainform.Devices[length(mainform.Devices)-1].gobonames[i]:=deviceprototyp[devposition].gobonames[i];
          AddGobo(mainform.Devices[length(mainform.Devices)-1].gobos[i]);
        end;
        setlength(mainform.Devices[length(mainform.Devices)-1].gobos2,length(deviceprototyp[devposition].gobos2));
        setlength(mainform.Devices[length(mainform.Devices)-1].gobolevels2,length(deviceprototyp[devposition].gobolevels2));
        setlength(mainform.Devices[length(mainform.Devices)-1].goboendlevels2,length(deviceprototyp[devposition].goboendlevels2));
        setlength(mainform.Devices[length(mainform.Devices)-1].gobonames2,length(deviceprototyp[devposition].gobonames2));
        setlength(mainform.Devices[length(mainform.Devices)-1].bestgobos2,length(deviceprototyp[devposition].gobos2));
        for i:=0 to length(mainform.devices[length(mainform.devices)-1].gobos2)-1 do
        begin
          mainform.Devices[length(mainform.Devices)-1].gobos2[i]:=deviceprototyp[devposition].gobos2[i];
          mainform.Devices[length(mainform.Devices)-1].gobolevels2[i]:=deviceprototyp[devposition].gobolevels2[i];
          mainform.Devices[length(mainform.Devices)-1].goboendlevels2[i]:=deviceprototyp[devposition].goboendlevels2[i];
          mainform.Devices[length(mainform.Devices)-1].gobonames2[i]:=deviceprototyp[devposition].gobonames2[i];
          AddGobo(mainform.Devices[length(mainform.Devices)-1].gobos2[i]);
        end;

        bildname:=ExtractFileName(mainform.pcdimmerdirectory+'Devicepictures\'+mainform.Devices[length(mainform.Devices)-1].Bildadresse);
        bildpfad:=ExtractFilePath(mainform.pcdimmerdirectory+'Devicepictures\'+mainform.Devices[length(mainform.Devices)-1].Bildadresse);

        if adddevice.adddeviceicon.checked then
        begin
          mainform.Devices[length(mainform.Devices)-1].ShowInStageview:=true;
        end else
        begin
          mainform.Devices[length(mainform.Devices)-1].ShowInStageview:=false;
        end;

        if deviceprototyp[devposition].IsMatrixDevice and (m=(deviceprototyp[devposition].MatrixXCount*deviceprototyp[devposition].MatrixYCount)-1) then
          matrixoffset:=matrixoffset+m*deviceprototyp[devposition].MaxChan;
      end;

      ProgressScreenSmall.Label1.Caption:=_('Gerätegruppen erstellen...');
      ProgressScreenSmall.Label2.Caption:=_('Es werden ')+adddevice.Edit2.Text+_(' Geräte hinzugefügt.');
      ProgressScreenSmall.Refresh;

      // Gerätegruppe erzeugen, falls gewünscht und mehr als 1 Gerät hinzugefügt werden
      if adddevice.adddevicegroupcheck.Checked and (strtoint(adddevice.Edit2.Text)>1) then
      begin
        setlength(mainform.DeviceGroups,length(mainform.DeviceGroups)+1);
        mainform.DeviceGroups[length(mainform.DeviceGroups)-1].Active:=true;
        CreateGUID(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].ID);

        devposition:=adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype);
        mainform.devicegroups[length(mainform.devicegroups)-1].Name:=_('Gruppierte')+' '+deviceprototyp[devposition].Name+' ('+adddevice.Edit2.Text+' '+_('Geräte')+')';
        mainform.devicegroups[length(mainform.devicegroups)-1].Beschreibung:=deviceprototyp[devposition].Vendor+' '+deviceprototyp[devposition].DeviceName;
        setlength(mainform.devicegroups[length(mainform.devicegroups)-1].IDs, strtoint(adddevice.Edit2.Text));
        setlength(mainform.devicegroups[length(mainform.devicegroups)-1].IDActive, strtoint(adddevice.Edit2.Text));
        setlength(mainform.devicegroups[length(mainform.devicegroups)-1].Delays, strtoint(adddevice.Edit2.Text));
        for k:=0 to strtoint(adddevice.Edit2.Text)-1 do
        begin
          mainform.devicegroups[length(mainform.devicegroups)-1].IDs[k]:=mainform.Devices[length(mainform.Devices)-1-(strtoint(adddevice.Edit2.Text)-1)+k].ID;
          mainform.devicegroups[length(mainform.devicegroups)-1].IDActive[k]:=true;
          mainform.devicegroups[length(mainform.devicegroups)-1].Delays[k]:=0;
        end;
        mainform.devicegroups[length(mainform.devicegroups)-1].Delay:=150;
        mainform.devicegroups[length(mainform.devicegroups)-1].FanMode:=1;
        mainform.devicegroups[length(mainform.devicegroups)-1].FanMorph:=1;
        mainform.devicegroups[length(mainform.devicegroups)-1].UseMaster:=true;
        mainform.devicegroups[length(mainform.devicegroups)-1].MasterDevice:=mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs[0];
        setlength(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].HasChanType, length(mainform.DeviceChannelNames));
        geraetesteuerung.CheckDeviceGroupIntersection(length(mainform.DeviceGroups)-1, mainform.devicegroups[length(mainform.devicegroups)-1].HasChanType);

        // Gruppeneditor aktualisieren
        groupeditorform.Grouplistbox.itemindex:=groupeditorform.Grouplistbox.items.add(_('Neue Gerätegruppe'));
        k:=groupeditorform.GroupListbox.itemindex;
        groupeditorform.GroupListChanged;
        groupeditorform.Grouplistbox.itemindex:=k;
        groupeditorform.GroupListBoxChange(nil);
      end;

      RefreshTreeNew;
      TreeViewCheckbuttons([]);
    end;

    if NewDeviceWithGobos then
      sidebarform.RefreshGoboCorrelation;

    ProgressScreenSmall.Label1.Caption:=_('Initialisierungsfunktion ausführen...');
    ProgressScreenSmall.Label2.Caption:=_('Es werden ')+adddevice.Edit2.Text+_(' Geräte hinzugefügt.');
    ProgressScreenSmall.Refresh;

    // Initialisierungsfunktion ausführen
    for i:=newdevicesstart to length(mainform.devices)-1 do
    begin
      for j:=0 to length(DevicePrototyp)-1 do
      begin
        if mainform.devices[i].DeviceName=deviceprototyp[j].DeviceName then
        begin
          XML.Xml.LoadFromFile(mainform.pcdimmerdirectory+'\Devices\'+deviceprototyp[j].ddffilename);
          for k:=0 to XML.Xml.Root.Items.Count-1 do
          begin // <device>
            if XML.XML.Root.Items[k].Name='initvalues' then
            begin
              for l:=0 to mainform.Devices[i].MaxChan-1 do
              begin
                if XML.XML.Root.Items[k].Properties.IntValue(inttostr(l))>-1 then
                  mainform.senddata(mainform.Devices[i].startaddress+l,maxres-XML.XML.Root.Items[k].Properties.IntValue(inttostr(l)),maxres-XML.XML.Root.Items[k].Properties.IntValue(inttostr(l)),0);
                if XML.XML.Root.Items[k].Properties.IntValue('ch'+inttostr(l))>-1 then
                  mainform.senddata(mainform.Devices[i].startaddress+l,maxres-XML.XML.Root.Items[k].Properties.IntValue('ch'+inttostr(l)),maxres-XML.XML.Root.Items[k].Properties.IntValue('ch'+inttostr(l)),0);
              end;
            end;
          end;
        end;
      end;
    end;

    ProgressScreenSmall.Label1.Caption:=_('Fertig.');
    ProgressScreenSmall.Label2.Caption:=_('Es wurden ')+adddevice.Edit2.Text+_(' Geräte hinzugefügt.');
    ProgressScreenSmall.Refresh;
    ProgressScreenSmall.Timer1.enabled:=true; // Timer1 schließt den Dialog nach ein paar Sekunden
  end;
  SendNamesBtnClick(nil);
end;

procedure Tgeraetesteuerung.Gertlschen1Click(Sender: TObject);
var
  i,j,k,l,m,n,devicefordelete,devposition:integer;
  IDsfordelete:array of TGUID;
  deviceinuse,channelstillinuse:boolean;
  DeviceSelectedForDelete:boolean;
  WarnForMatrixDeviceDelete:boolean;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  setlength(IDsfordelete,0);

  // IDs zum Löschen sammeln
  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  begin
    if VST.Selected[VSTDeviceNodes[i][j][k]] then
    begin
      Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);
      setlength(IDsfordelete,length(IDsfordelete)+1);
      IDsfordelete[length(IDsfordelete)-1]:=Data^.ID;
    end;
  end;

  // Matrixbehandlung
  // Prüfen, ob ein Matrixgerät vorhanden ist
  WarnForMatrixDeviceDelete:=false;
  for l:=0 to length(IDsfordelete)-1 do
  begin
    devposition:=geraetesteuerung.GetDevicePositionInDeviceArray(@IDsfordelete[l]);

    if mainform.Devices[devposition].MatrixDeviceLevel>0 then
    begin
      // Gerät ist ein Matrixgerät
      WarnForMatrixDeviceDelete:=true;

      // alle zugehörigen Matrixgeräte zum Löschen hinzufügen (sofern noch nicht geschehen)
      for m:=0 to length(mainform.devices)-1 do
      begin
        if (mainform.devices[m].MatrixDeviceLevel>0) and IsEqualGUID(mainform.Devices[devposition].MatrixMainDeviceID, mainform.devices[m].MatrixMainDeviceID) then
        begin
          // prüfen, ob Gerät bereits zum Löschen eingetragen wurde
          DeviceSelectedForDelete:=false;
          for n:=0 to length(IDsfordelete)-1 do
          begin
            if IsEqualGUID(IDsfordelete[n], mainform.devices[m].ID) then
            begin
              DeviceSelectedForDelete:=true;
              break;
            end;
          end;
          if not DeviceSelectedForDelete then
          begin
            // Gerät zum Löschen hinzufügen
            setlength(IDsfordelete, length(IDsfordelete)+1);
            IDsfordelete[length(IDsfordelete)-1]:=mainform.devices[m].ID;
          end;
        end;
      end;
    end;
  end;

  if WarnForMatrixDeviceDelete then
  begin
    if messagedlg(_('Sie sind im Begriff einen Teil eines Matrix-Gerätes zu löschen. Dabei werden auch alle zugehörigen Matrix-Geräte gelöscht, selbst wenn diese nicht selektiert wurden. Bitte wählen Sie, wie weiter verfahren werden soll:'), mtWarning,
    [mbYes,mbNo],0)=mrNo then
    begin
      exit;
    end;
  end;


  for l:=0 to length(IDsfordelete)-1 do
  begin
    devicefordelete:=0;
    deviceinuse:=FindDeviceConnections(IDsfordelete[l],askforremovingform.Treeview1);

    for k:=0 to length(mainform.Devices)-1 do
    begin
      if IsEqualGUID(mainform.devices[k].ID,IDsfordelete[l]) then
      begin
        devicefordelete:=k;
        break;
      end;
    end;

    askforremovingform.Label4.Caption:=_('Gerätename:');
    askforremovingform.devicenamelabel.Caption:=mainform.devices[devicefordelete].Name;
    askforremovingform.Label2.Caption:=_('Gerätetyp:');
    askforremovingform.devicedescription.Caption:=mainform.devices[devicefordelete].Vendor+' '+mainform.devices[devicefordelete].DeviceName;
    askforremovingform.Label6.Caption:=_('Adressbereich:');
    askforremovingform.startadresselabel.Caption:=_('Kanal ')+inttostr(mainform.devices[devicefordelete].Startaddress)+'...'+inttostr(mainform.devices[devicefordelete].Startaddress+mainform.devices[devicefordelete].MaxChan-1);

    // Gerät wird noch verwendet -> Dialogbox anzeigen
    if deviceinuse then
    begin
      askforremovingform.Label35.Caption:=_('Das zu löschende Gerät wird noch verwendet.  Bitte wählen Sie, wie weiter verfahren werden soll:');
      askforremovingform.Button1.Caption:=_('Gerät löschen');
      askforremovingform.showmodal;
    end;

    if (deviceinuse=false) or (askforremovingform.modalresult=mrOK) then
    begin
      // Alle Elemente um eins nach vorne rutschen
      for i:=0 to mainform.devices[devicefordelete].MaxChan-1 do
      begin
        // Alte Kanaldimmkurven zurücksetzen, falls dort kein Gerät liegt
        // Checken, ob an alten Kanälen noch Geräte adressiert sind
        channelstillinuse:=false;
        for j:=0 to length(mainform.devices)-1 do
        begin // Geräte durchlaufen
          for k:=0 to mainform.devices[j].MaxChan-1 do
          begin // Gerätekanäle durchlaufen
            if (mainform.devices[j].Startaddress+k)=(mainform.devices[devicefordelete].Startaddress+i) then
            begin
              channelstillinuse:=true;
              break;
            end;
          end;

          // Kanal wird von keinem Gerät mehr genutzt
          if not channelstillinuse then
          begin
            mainform.channel_dimmcurve[mainform.devices[devicefordelete].Startaddress+i]:=0;
            mainform.channel_absolutedimmcurve[mainform.devices[devicefordelete].Startaddress+i]:=0;
          end;
        end;
      end;

      for k:=devicefordelete to length(mainform.devices)-2 do
      begin
        CopyDevice(k+1, k);
      end;

      // Letzte Position löschen
      setlength(mainform.Devices,length(mainform.Devices)-1);
      setlength(mainform.DeviceSelected,length(mainform.DeviceSelected)-1);
    end;
  end;
  SendNamesBtnClick(nil);
  TreeViewCheckbuttons([]);

  VST.Refresh;
  RefreshDeviceControl;
end;

procedure Tgeraetesteuerung.RefreshTreeNew;
var
  i,j,k:integer;
  vendornode, typenode, devicenode:PVirtualNode;
  vendornodeok, typenodeok:integer;
  Data:PTreeData;
begin
  VST.BeginUpdate;
  VST.Clear;
  VST.NodeDataSize:=SizeOf(TTreeData);
  setlength(VSTVendorNodes,0);
  setlength(VSTTypeNodes,0);
  setlength(VSTDeviceNodes,0);

  ///////////////////////////////////////////////////////////////////////////
  // Geräte hinzufügen
  for i:=0 to length(mainform.devices)-1 do
  begin
    vendornodeok:=-1;
    typenodeok:=-1;
    // Herausfinden, ob für Vendor schon ein RootNode vorhanden ist
    for j:=0 to length(VSTVendorNodes)-1 do
    begin
      Data:=VST.GetNodeData(VSTVendorNodes[j]);
      if (Data^.Caption=mainform.devices[i].vendor) then
      begin
        vendornode:=VSTVendorNodes[j];
        vendornodeok:=j;
        break;
      end;
    end;

    // Wenn kein VendorNode verfügbar -> erstellen
    if vendornodeok=-1 then
    begin
      vendornode:=VST.AddChild(nil);
      Data:=VST.GetNodeData(vendornode);
      Data^.NodeType:=0;
      Data^.Caption:=mainform.devices[i].Vendor;
      Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');

      setlength(VSTVendorNodes, length(VSTVendorNodes)+1);
      setlength(VSTTypeNodes, length(VSTTypeNodes)+1);
      setlength(VSTDeviceNodes, length(VSTDeviceNodes)+1);
      VSTVendorNodes[length(VSTVendorNodes)-1]:=vendornode;
      vendornodeok:=length(VSTVendorNodes)-1;
    end;

    // Herausfinden, ob für Type schon ein Sub-Node vorhanden ist
    for j:=0 to length(VSTTypeNodes[vendornodeok])-1 do
    begin
      Data:=VST.GetNodeData(VSTTypeNodes[vendornodeok][j]);
      if (Data^.Caption=mainform.devices[i].DeviceName) then
      begin
        typenode:=VSTTypeNodes[vendornodeok][j];
        typenodeok:=j;
        break;
      end;
    end;

    // Wenn kein TypeNode verfügbar -> erstellen
    if typenodeok=-1 then
    begin
      typenode:=VST.AddChild(vendornode);
      Data:=VST.GetNodeData(typenode);
      Data^.NodeType:=1;
      Data^.Caption:=mainform.devices[i].DeviceName;
      Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');

      setlength(VSTTypeNodes[vendornodeok], length(VSTTypeNodes[vendornodeok])+1);
      setlength(VSTDeviceNodes[vendornodeok], length(VSTDeviceNodes[vendornodeok])+1);
      VSTTypeNodes[vendornodeok][length(VSTTypeNodes[vendornodeok])-1]:=typenode;
      typenodeok:=length(VSTTypeNodes[vendornodeok])-1;
    end;

    // Neuen Device-SubSubNode für Gerät erstellen
    devicenode:=VST.AddChild(typenode);
    Data:=VST.GetNodeData(devicenode);
    Data^.NodeType:=2;
    Data^.Caption:=mainform.devices[i].Name;
    Data^.ID:=mainform.devices[i].ID;
    setlength(VSTDeviceNodes[vendornodeok][typenodeok], length(VSTDeviceNodes[vendornodeok][typenodeok])+1);
    VSTDeviceNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1]:=devicenode;
  end;

  VST.SelectAll(false);
  VST.InvertSelection(false);
  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  begin
    Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);

    if IsEqualGUID(position, Data^.ID) then
    begin
      VST.Expanded[VSTDeviceNodes[i][j][k].Parent.Parent]:=true;
      VST.Expanded[VSTDeviceNodes[i][j][k].Parent]:=true;
      VST.Expanded[VSTDeviceNodes[i][j][k]]:=true;
      VST.Selected[VSTDeviceNodes[i][j][k]]:=true;
      VST.FocusedNode:=VSTDeviceNodes[i][j][k];
      break;
    end;
  end;
  VST.EndUpdate;
end;

procedure Tgeraetesteuerung.TreeViewCheckbuttons(Shift: TShiftState);
var
  i:integer;
  mastertype,mastertypevendor:string;
  actualdevice:integer;
  Data:PTreeData;
begin
  mastertype:='';
  mastertypevendor:='';

  AddGroupBtn.Enabled:=false;
  DeleteGroupBtn.Enabled:=false;
  RefreshGroupBtn.Enabled:=false;
  upbtn.enabled:=false;
  downbtn.enabled:=false;

  // Wenn nur ein Objekt, dann Einzelgeräteinstellungen freischalten
  if VST.SelectedCount=1 then
    Data:=VST.GetNodeData(VST.FocusedNode);

  if (VST.SelectedCount=1) and (Assigned(Data)) and (Data^.NodeType=2) then
  begin
    actualdevice:=GetDevicePositionInDeviceArray(@Data^.ID);

    if actualdevice>-1 then
    begin
      upbtn.enabled:=(actualdevice>0);
      downbtn.enabled:=(actualdevice<length(mainform.devices)-1);

      AddGroupBtn.Enabled:=true;
      DeleteGroupBtn.Enabled:=true;
      RefreshGroupBtn.Enabled:=true;

      DevStartaddressEdit.Enabled:=true;
      ChangeBtn.Enabled:=true;
      PngBitBtn1.enabled:=true;
      PngBitBtn3.enabled:=true;
      PngBitBtn2.enabled:=true;
      PngBitBtn4.enabled:=mainform.Devices[actualdevice].hasColor;
      Bearbeiten1.enabled:=true;
      Lschen1.enabled:=true;
      Bildndern1.enabled:=true;
      Kanalnamesenden1.enabled:=true;
      Dimmerkurveneinstellen1.enabled:=true;
      Scannersynchronisation1.enabled:=true;
      DeleteBtn.Enabled:=true;
      idbtn.enabled:=true;
      renameBtn.Enabled:=true;

      mastertype:=mainform.devices[actualdevice].DeviceName;
      mastertypevendor:=mainform.devices[actualdevice].Vendor;
      DevStartAddressEdit.Text:=inttostr(mainform.devices[actualdevice].Startaddress);
      panmirror.Checked:=mainform.Devices[actualdevice].invertpan;
      tiltmirror.Checked:=mainform.Devices[actualdevice].inverttilt;
      panmirror.Enabled:=mainform.Devices[actualdevice].hasPANTILT;
      tiltmirror.Enabled:=mainform.Devices[actualdevice].hasPANTILT;
      for i:=1 to 16 do
      begin
        if mainform.Devices[actualdevice].scannercalibrations[i].name<>'' then
          SyncTypeBox.items[i]:=mainform.Devices[actualdevice].scannercalibrations[i].name
        else
          SyncTypeBox.items[i]:=_('Kalibrierung ')+inttostr(i);
      end;
      SyncTypeBox.itemindex:=mainform.Devices[actualdevice].typeofscannercalibration;
      SyncTypeBox.Enabled:=mainform.Devices[actualdevice].hasPANTILT;
      Scannersynchronisation1.Enabled:=mainform.Devices[actualdevice].hasPANTILT;
      CalibrateBtn.Enabled:=mainform.Devices[actualdevice].hasPANTILT;

      autoscening.Checked:=mainform.Devices[actualdevice].autoscening;
      showinstageview.Checked:=mainform.Devices[actualdevice].ShowInStageview;
      copycounts.Enabled:=mainform.Devices[actualdevice].ShowInStageview;
      copycounts.Text:=inttostr(length(mainform.Devices[actualdevice].top));
      colorBtn.Enabled:=true;
      colorBtn.Color:=mainform.Devices[actualdevice].color;
      showinstageview.Enabled:=true;
      autoscening.Enabled := true;
    end;
  end else begin
    DevStartaddressEdit.Enabled:=false;
    ChangeBtn.Enabled:=false;
    DeleteBtn.Enabled:=false;
    idbtn.enabled:=false;
    PngBitBtn1.enabled:=false;
    PngBitBtn3.enabled:=false;
    PngBitBtn2.enabled:=false;
    PngBitBtn4.enabled:=false;
    Bearbeiten1.enabled:=false;
    Lschen1.enabled:=false;
    Bildndern1.enabled:=false;
    Kanalnamesenden1.enabled:=false;
    Dimmerkurveneinstellen1.enabled:=false;
    Scannersynchronisation1.enabled:=false;
    panmirror.Enabled:=false;
    tiltmirror.Enabled:=false;
    colorBtn.Enabled:=false;
    renameBtn.Enabled:=false;
    copycounts.Enabled:=false;
    copycounts.Text:='0';
    showinstageview.Enabled:=false;
    autoscening.Enabled := false;
  end;

  // Wenn mehr als ein Gerät
  if (VST.SelectedCount>1) then
  begin
    DevStartaddressEdit.Enabled:=false;
    ChangeBtn.Enabled:=false;
    idbtn.enabled:=false;
    PngBitBtn1.enabled:=true;
    PngBitBtn3.enabled:=true;
    PngBitBtn2.enabled:=false;
    PngBitBtn4.enabled:=false;
    Bearbeiten1.enabled:=false;
    Lschen1.enabled:=true;
    DeleteBtn.Enabled:=true;
//    Bildndern1.enabled:=false;
    Dimmerkurveneinstellen1.enabled:=false;
    Scannersynchronisation1.enabled:=false;
    panmirror.Enabled:=false;
    tiltmirror.Enabled:=false;
    colorBtn.Enabled:=false;
    renameBtn.Enabled:=false;
    copycounts.Enabled:=true;
    showinstageview.Enabled:=true;
    autoscening.Enabled := true;
  end;

  // Wenn kein Gerät
  if (VST.SelectedCount=0) then
  begin
    DevStartaddressEdit.Enabled:=false;
    ChangeBtn.Enabled:=false;
    DeleteBtn.Enabled:=false;
    idbtn.enabled:=false;
    PngBitBtn1.enabled:=false;
    PngBitBtn3.enabled:=false;
    PngBitBtn2.enabled:=false;
    PngBitBtn4.enabled:=false;
    Bearbeiten1.enabled:=false;
    Lschen1.enabled:=false;
    Bildndern1.enabled:=false;
    Kanalnamesenden1.enabled:=false;
    Dimmerkurveneinstellen1.enabled:=false;
    Scannersynchronisation1.enabled:=false;
    panmirror.Enabled:=false;
    tiltmirror.Enabled:=false;
    colorBtn.Enabled:=false;
    renameBtn.Enabled:=false;
    copycounts.Enabled:=false;
    copycounts.Text:='0';
    showinstageview.Enabled:=false;
    autoscening.Enabled := false;
  end;

  // alle selektierten Objekte sind identischen Typs
  AddGroupBtn.Enabled:=true;
  DeleteGroupBtn.Enabled:=true;
  RefreshGroupBtn.Enabled:=true;
end;

procedure Tgeraetesteuerung.tiltmirrorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j,k:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  begin
    if VST.Selected[VSTDeviceNodes[i][j][k]] then
    begin
      Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);
      mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].inverttilt:=tiltmirror.Checked;
    end;
  end;
end;

procedure Tgeraetesteuerung.CreateParams(var Params:TCreateParams);
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

procedure Tgeraetesteuerung.AddGroupBtnClick(Sender: TObject);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  setlength(mainform.DeviceGroups,length(mainform.DeviceGroups)+1);
  mainform.DeviceGroups[length(mainform.DeviceGroups)-1].Active:=true;
  CreateGUID(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].ID);
  mainform.DeviceGroups[length(mainform.DeviceGroups)-1].Name:=_('Neue Gerätegruppe (')+inttostr(length(mainform.DeviceGroups))+')';

  mainform.DeviceGroups[length(mainform.DeviceGroups)-1].FanMorph:=1;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      setlength(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs,length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs)+1);
      setlength(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDActive,length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDActive)+1);
      setlength(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].Delays,length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].Delays)+1);
      mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs[length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs)-1]:=mainform.devices[i].ID;
      mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDActive[length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDActive)-1]:=true;
    end;
  end;
  setlength(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].HasChanType, length(mainform.DeviceChannelNames));
  geraetesteuerung.CheckDeviceGroupIntersection(length(mainform.DeviceGroups)-1, mainform.DeviceGroups[length(mainform.DeviceGroups)-1].HasChanType);

  if length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs)>0 then
  begin
    mainform.DeviceGroups[length(mainform.DeviceGroups)-1].UseMaster:=true;
    mainform.DeviceGroups[length(mainform.DeviceGroups)-1].FanMode:=1;
    mainform.DeviceGroups[length(mainform.DeviceGroups)-1].MasterDevice:=mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs[0];
  end;

  groupeditorform.GroupListChanged;
end;

procedure Tgeraetesteuerung.GroupListChanged;
var
  i:integer;
begin
  if length(mainform.DeviceGroups)>0 then
  begin
    Grouplist.RowCount:=length(mainform.DeviceGroups)+1;
    for i:=1 to length(mainform.DeviceGroups) do
    begin
      Grouplist.Cells[1,i]:=mainform.DeviceGroups[i-1].Name;
      Grouplist.Cells[2,i]:=mainform.DeviceGroups[i-1].Beschreibung;
    end;
  end else
  begin
    Grouplist.RowCount:=2;
    Grouplist.Cells[0,1]:='';
    Grouplist.Cells[1,1]:='';
    Grouplist.Cells[2,1]:='';
  end;

//  Grouplist.Enabled:=length(mainform.DeviceGroups)>0;
  DeleteGroupBtn.enabled:=((Grouplist.Row-1)<=length(mainform.DeviceGroups)) and (length(mainform.DeviceGroups)>0);
  RefreshGroupBtn.enabled:=DeleteGroupBtn.enabled;
  ActivateGroupBtn.enabled:=DeleteGroupBtn.enabled;
  AddDeviceGroupWithoutDeselectBtn.enabled:=DeleteGroupBtn.enabled;
  grouplist.Refresh;
end;

procedure Tgeraetesteuerung.DeleteGroupBtnClick(Sender: TObject);
var
  i,k:integer;
  groupinuse:boolean;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if messagedlg(_('Möchten Sie diese Gruppe wirklich löschen?'),mtWarning,
    [mbYes,mbNo],0)=mrYes then
  begin
    if length(mainform.DeviceGroups)>0 then
    begin
      // Objektekopieren nur starten, wenn nicht letztes Element (Row=RowCount-1) selektiert
      if Grouplist.Row<=(Grouplist.RowCount-1) then
      begin
        groupinuse:=FindDeviceConnections(mainform.DeviceGroups[Grouplist.Row-1].ID,askforremovingform.Treeview1);
        askforremovingform.Label4.Caption:=_('Gruppenname:');
        askforremovingform.devicenamelabel.Caption:=mainform.DeviceGroups[Grouplist.Row-1].Name;
        askforremovingform.Label2.Caption:=_('Beschreibung:');
        askforremovingform.devicedescription.Caption:=mainform.DeviceGroups[Grouplist.Row-1].Beschreibung;
        askforremovingform.Label6.Caption:=_('Geräteanzahl:');
        askforremovingform.startadresselabel.Caption:=inttostr(length(mainform.DeviceGroups[Grouplist.Row-1].IDs));
        // Gruppe wird noch verwendet -> Dialogbox anzeigen
        if groupinuse then
        begin
          askforremovingform.Label35.Caption:=_('Die zu löschende Gruppe wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
          askforremovingform.Button1.Caption:=_('Gruppe löschen');
          askforremovingform.showmodal;
        end;

        if (groupinuse=false) or (askforremovingform.modalresult=mrOK) then
        begin
          for i:=Grouplist.Row-1 to Grouplist.RowCount-3 do
          begin
            mainform.DeviceGroups[i].Active:=mainform.DeviceGroups[i+1].Active;
            mainform.DeviceGroups[i].ID:=mainform.DeviceGroups[i+1].ID;
            mainform.DeviceGroups[i].Name:=mainform.DeviceGroups[i+1].Name;
            mainform.DeviceGroups[i].Beschreibung:=mainform.DeviceGroups[i+1].Beschreibung;

            setlength(mainform.DeviceGroups[i].IDs,length(mainform.DeviceGroups[i+1].IDs));
            setlength(mainform.DeviceGroups[i].IDActive,length(mainform.DeviceGroups[i+1].IDActive));
            setlength(mainform.DeviceGroups[i].Delays,length(mainform.DeviceGroups[i+1].Delays));
            for k:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              mainform.DeviceGroups[i].IDs[k]:=mainform.DeviceGroups[i+1].IDs[k];
              mainform.DeviceGroups[i].IDActive[k]:=mainform.DeviceGroups[i+1].IDActive[k];
              mainform.DeviceGroups[i].Delays[k]:=mainform.DeviceGroups[i+1].Delays[k];
            end;
            mainform.DeviceGroups[i].MasterDevice:=mainform.DeviceGroups[i+1].MasterDevice;
            mainform.DeviceGroups[i].UseMaster:=mainform.DeviceGroups[i+1].UseMaster;
            mainform.DeviceGroups[i].FanMode:=mainform.DeviceGroups[i+1].FanMode;
            mainform.DeviceGroups[i].FanMorph:=mainform.DeviceGroups[i+1].FanMorph;
            mainform.DeviceGroups[i].Delay:=mainform.DeviceGroups[i+1].Delay;
          end;
          setlength(mainform.DeviceGroups,length(mainform.DeviceGroups)-1);
        end;
      end;
    end;
    groupeditorform.GroupListChanged;
  end;
end;

procedure Tgeraetesteuerung.GrouplistKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if ((GroupList.Row-1)<length(mainform.devicegroups)) then
  begin
    if Grouplist.Col=1 then
      mainform.DeviceGroups[Grouplist.row-1].Name:=Grouplist.Cells[Grouplist.Col,Grouplist.Row];

    if Grouplist.Col=2 then
      mainform.DeviceGroups[Grouplist.row-1].Beschreibung:=Grouplist.Cells[Grouplist.Col,Grouplist.row];
  end;
end;

function Tgeraetesteuerung.GetChannelName(DeviceID:TGUID; Channel: Integer):String;
var
  i:integer;
begin
  for i:=0 to length(mainform.devices)-1 do
  begin
    if IsEqualGUID(DeviceID,mainform.devices[i].ID) then
    begin
      Result:=mainform.devices[i].kanalname[Channel];
      break;
    end;
  end;
end;

procedure Tgeraetesteuerung.ChangeBtnClick(Sender: TObject);
var
  i:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if adddevice=nil then
    adddevice:=Tadddevice.Create(adddevice);

  if VST.SelectedCount<>1 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if (Data^.NodeType=2) then
  begin
    adddevice.pngbitbtn1.Caption:=_('Ändern');

    adddevice.Label7.Visible:=false;
    adddevice.Edit2.Visible:=false;
    adddevice.Edit3.enabled:=false;
    adddevice.Edit3.text:=inttostr(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].Startaddress);
    adddevice.Label9.Visible:=false;
    adddevice.lastaddress.Visible:=false;

    adddevice.ShowModal;
    adddevice.pngbitbtn1.Caption:=_('Hinzufügen');

    adddevice.Label7.Visible:=true;
    adddevice.Edit2.Visible:=true;
    adddevice.Edit3.enabled:=true;
    adddevice.Label9.Visible:=true;
    adddevice.lastaddress.Visible:=true;

    if adddevice.modalresult=mrOK then
    begin
      if (adddevice.VST.SelectedCount=1) and (adddevice.DeviceSelectionOK) then
      begin
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].Name:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].Name;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].DeviceName:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].DeviceName;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].Vendor:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].Vendor;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].Beschreibung:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].Beschreibung;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].Bildadresse:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].Bildadresse;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].MaxChan:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].MaxChan;

        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasDimmer:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasDimmer;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasShutter:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasShutter;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasVirtualRGBAWDimmer:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasVirtualRGBAWDimmer;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasRGB:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasRGB;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasCMY:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasCMY;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasAmber:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasAmber;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasWhite:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasWhite;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasUV:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasUV;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasFog:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasFog;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].UseAmberMixing:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].UseAmberMixing;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].AmberMixingCompensateRG:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].AmberMixingCompensateRG;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].AmberMixingCompensateBlue:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].AmberMixingCompensateBlue;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].AmberRatioR:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].AmberRatioR;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].AmberRatioG:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].AmberRatioG;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasPANTILT:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasPANTILT;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasColor:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasColor;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasColor2:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasColor2;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasGobo:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasGobo;
        mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].hasGobo2:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].hasGobo2;
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].KanalMinValue,deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].MaxChan);
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].KanalMaxValue,deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].MaxChan);
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].kanaltyp,deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].MaxChan);
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].kanalname,deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].MaxChan);
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].kanalfade,deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].MaxChan);
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].kanaldimmcurve,deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].MaxChan);
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].kanalabsolutedimmcurve,deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].MaxChan);

        for i:=0 to mainform.devices[GetDevicePositionInDeviceArray(@Data^.ID)].MaxChan-1 do
        begin
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].KanalMinValue[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].KanalMinValue[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].KanalMaxValue[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].KanalMaxValue[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].kanaltyp[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].kanaltyp[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].kanalname[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].kanalname[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].kanalfade[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].kanalfade[i];
        end;

        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colors,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colors));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colorlevels,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colorlevels));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colorendlevels,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colorendlevels));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colornames,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colornames));
        for i:=0 to length(mainform.devices[GetDevicePositionInDeviceArray(@Data^.ID)].colors)-1 do
        begin
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colors[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colors[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colorendlevels[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colorendlevels[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colornames[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colornames[i];
        end;
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colors2,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colors2));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colorlevels2,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colorlevels2));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colorendlevels2,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colorendlevels2));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colornames2,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colornames2));
        for i:=0 to length(mainform.devices[GetDevicePositionInDeviceArray(@Data^.ID)].colors2)-1 do
        begin
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colors2[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colors2[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colorlevels2[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colorlevels2[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colorendlevels2[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colorendlevels2[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].colornames2[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].colornames2[i];
        end;

        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobos,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobos));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobolevels,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobolevels));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].goboendlevels,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].goboendlevels));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobonames,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobonames));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].bestgobos,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobos));
        for i:=0 to length(mainform.devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobos)-1 do
        begin
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobos[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobos[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobolevels[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobolevels[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].goboendlevels[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].goboendlevels[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobonames[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobonames[i];
          AddGobo(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobos[i]);
        end;
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobos2,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobos2));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobolevels2,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobolevels2));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].goboendlevels2,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].goboendlevels2));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobonames2,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobonames2));
        setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].bestgobos2,length(deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobos2));
        for i:=0 to length(mainform.devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobos2)-1 do
        begin
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobos2[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobos2[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobolevels2[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobolevels2[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].goboendlevels2[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].goboendlevels2[i];
          mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobonames2[i]:=deviceprototyp[adddevice.GetDevicePositionInDeviceArray(@adddevice.SelectedPrototype)].gobonames2[i];
          AddGobo(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].gobos2[i]);
        end;

        Position:=mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].ID;

        RefreshTreeNew;
        TreeViewCheckbuttons([]);
      end;
    end;
  end;
end;

procedure Tgeraetesteuerung.RefreshGroupBtnClick(Sender: TObject);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if length(mainform.DeviceGroups)>=Grouplist.row then
  begin
    setlength(mainform.DeviceGroups[Grouplist.row-1].IDs,0);
    setlength(mainform.DeviceGroups[Grouplist.row-1].IDActive,0);
    setlength(mainform.DeviceGroups[Grouplist.row-1].Delays,0);
    for i:=0 to length(mainform.devices)-1 do
    begin
      if mainform.DeviceSelected[i] then
      begin
        setlength(mainform.DeviceGroups[Grouplist.row-1].IDs,length(mainform.DeviceGroups[Grouplist.row-1].IDs)+1);
        setlength(mainform.DeviceGroups[Grouplist.row-1].IDActive,length(mainform.DeviceGroups[Grouplist.row-1].IDActive)+1);
        setlength(mainform.DeviceGroups[Grouplist.row-1].Delays,length(mainform.DeviceGroups[Grouplist.row-1].Delays)+1);
        mainform.DeviceGroups[Grouplist.row-1].IDs[length(mainform.DeviceGroups[Grouplist.row-1].IDs)-1]:=mainform.devices[i].ID;
        mainform.DeviceGroups[Grouplist.row-1].IDActive[length(mainform.DeviceGroups[Grouplist.row-1].IDActive)-1]:=true;
      end;
    end;
    setlength(mainform.DeviceGroups[Grouplist.row-1].HasChanType,length(mainform.DeviceChannelNames));
    geraetesteuerung.CheckDeviceGroupIntersection(Grouplist.row-1, mainform.DeviceGroups[Grouplist.row-1].HasChanType);
  end;
  groupeditorform.GroupListChanged;
end;

function Tgeraetesteuerung.GetDevicePositionInDeviceArray(ID: PGUID):Integer;
var
  i:integer;
begin
  Result:=-1;
  if length(mainform.devices)=0 then exit;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if IsEqualGUID(ID^, mainform.devices[i].ID) then
    begin
      Result:=i;
      break;
    end;
  end;
end;

function Tgeraetesteuerung.GetGroupPositionInGroupArray(ID: TGUID):Integer;
var
  i:integer;
begin
  Result:=-1;
  if length(mainform.devicegroups)=0 then exit;

  for i:=0 to length(mainform.devicegroups)-1 do
  begin
    if IsEqualGUID(ID,mainform.devicegroups[i].ID) then
    begin
      Result:=i;
      break;
    end;
  end;
end;

procedure Tgeraetesteuerung.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tgeraetesteuerung.panmirrorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j,k:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  begin
    if VST.Selected[VSTDeviceNodes[i][j][k]] then
    begin
      Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);
      mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].invertpan:=panmirror.Checked;
    end;
  end;
end;

procedure Tgeraetesteuerung.set_pantilt(DeviceID: TGUID; PANstartvalue, PANendvalue, TILTstartvalue, TILTendvalue, fadetime:integer);
begin
  set_pantilt(DeviceID, PANstartvalue, PANendvalue, TILTstartvalue, TILTendvalue, fadetime, 0);
end;

procedure Tgeraetesteuerung.set_pantilt(DeviceID: TGUID; PANstartvalue, PANendvalue, TILTstartvalue, TILTendvalue, fadetime, delay:integer);
var
  aktuellesgeraet:integer;
begin
  aktuellesgeraet:=GetDevicePositionInDeviceArray(@DeviceID);

  mainform.Devices[aktuellesgeraet].PanStartvalue:=PANstartvalue;
  mainform.Devices[aktuellesgeraet].PanEndvalue:=PANendvalue;
  mainform.Devices[aktuellesgeraet].TiltStartvalue:=TILTstartvalue;
  mainform.Devices[aktuellesgeraet].TiltEndvalue:=TILTendvalue;
  set_channel(DeviceID, 'pan', PANstartvalue, PANendvalue, fadetime, delay);
  set_channel(DeviceID, 'tilt', TILTstartvalue, TILTendvalue, fadetime, delay);
end;

procedure Tgeraetesteuerung.set_channel(DeviceID: TGUID; channel:String; startvalue, endvalue, fadetime:integer);
begin
  set_channel(DeviceID, channel, startvalue, endvalue, fadetime, -1);
end;

procedure Tgeraetesteuerung.set_channel(DeviceID: TGUID; channel:String; startvalue, endvalue, fadetime, delay:integer);
var
  k,endvalue_new:integer;
  aktuellesgeraet:integer;
begin
  if fadetime<-1 then
    fadetime:=Random(abs(fadetime));

  aktuellesgeraet:=GetDevicePositionInDeviceArray(@DeviceID);

  if aktuellesgeraet<0 then
  begin
    // wenn kein Gerät, dann vielleicht Gruppe?
    set_group(DeviceID,channel,startvalue,endvalue,fadetime,delay);
    exit; // exit wenn Gruppen-ID
  end;

  if delay<0 then
    delay:=Random(abs(delay));

  endvalue_new:=endvalue;

  if lowercase(channel)='pan' then
  begin
    mainform.Devices[aktuellesgeraet].PanStartvalue:=startvalue;
    mainform.Devices[aktuellesgeraet].PanEndvalue:=endvalue;
  end;

  if lowercase(channel)='tilt' then
  begin
    mainform.Devices[aktuellesgeraet].TiltStartvalue:=startvalue;
    mainform.Devices[aktuellesgeraet].TiltEndvalue:=endvalue;
  end;

  for k:=0 to mainform.Devices[aktuellesgeraet].MaxChan-1 do
  begin
    if lowercase(mainform.Devices[aktuellesgeraet].kanaltyp[k])=lowercase(channel) then
    begin
      if (endvalue_new>mainform.Devices[aktuellesgeraet].KanalMaxValue[k]) then
        endvalue_new:=mainform.Devices[aktuellesgeraet].KanalMaxValue[k];
      if (endvalue_new<mainform.Devices[aktuellesgeraet].KanalMinValue[k]) then
        endvalue_new:=mainform.Devices[aktuellesgeraet].KanalMinValue[k];

      if mainform.Devices[aktuellesgeraet].kanalfade[k] then
      begin
        if startvalue=-1 then
          mainform.Senddata(mainform.Devices[aktuellesgeraet].Startaddress+k,startvalue,maxres-endvalue_new,fadetime,delay)
        else
          mainform.Senddata(mainform.Devices[aktuellesgeraet].Startaddress+k,maxres-startvalue,maxres-endvalue_new,fadetime,delay);
      end else
      begin
        if startvalue=-1 then
          mainform.Senddata(mainform.Devices[aktuellesgeraet].Startaddress+k,-1,maxres-endvalue_new,0,delay)
        else
          mainform.Senddata(mainform.Devices[aktuellesgeraet].Startaddress+k,maxres-endvalue_new,maxres-endvalue_new,0,delay);
      end;
      mainform.recordchannelvalue[mainform.Devices[aktuellesgeraet].Startaddress+k]:=maxres-endvalue_new;

      break;
    end;
  end;
end;

procedure Tgeraetesteuerung.set_group(GroupID: TGUID; channel:String; startvalue, endvalue, fadetime:integer);
begin
  set_group(GroupID, channel, startvalue, endvalue, fadetime, -1);
end;

procedure Tgeraetesteuerung.set_group(GroupID: TGUID; channel:string; startvalue, endvalue, fadetime, delay:integer);
var
  i,j:integer;
  temp_startvalue,delayfaktor:integer;
  PositionOfMaster,countofpihalf:integer;
  temp:extended;
begin
  PositionOfMaster:=0;

  for i:=0 to length(mainform.DeviceGroups)-1 do
  begin
    if IsEqualGUID(mainform.DeviceGroups[i].ID,GroupID) then
    begin
      if mainform.DeviceGroups[i].Active then
      begin
        if mainform.DeviceGroups[i].UseMaster then
        begin
          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
            begin
              PositionOfMaster:=j;
              break;
            end;
          end;
        end;

        if delay=-1 then
          delay:=mainform.DeviceGroups[i].Delay;

        for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
        begin
          if mainform.DeviceGroups[i].IDActive[j] then
          begin
            temp_startvalue:=startvalue;

            if mainform.DeviceGroups[i].UseMaster then
            begin
              case mainform.DeviceGroups[i].FanMode of
                0: // Fanning aus
                begin
                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,0);
                end;
                1: // Links und Rechts ab Master
                begin
                  delayfaktor:=abs(j-PositionOfMaster);
                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,delay*delayfaktor);
                end;
                2: // Nach Rechts ab Master
                begin
                  delayfaktor:=j-PositionOfMaster;
                  if delayfaktor>=0 then
                  begin
                    set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,delay*delayfaktor);
                  end;
                end;
                3: // Nach Links ab Master
                begin
                  delayfaktor:=PositionOfMaster-j;
                  if delayfaktor>=0 then
                  begin
                    set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,delay*delayfaktor);
                  end;
                end;
                4: // Sinus nach Links und Rechts ab Master
                begin
                  delayfaktor:=abs(j-PositionOfMaster);
                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                end;
                5: // Tangens
                begin
                  delayfaktor:=abs(j-PositionOfMaster);
                  temp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                  countofpihalf:=floor(temp/(pi/2))+1;

                  temp:=temp/countofpihalf;
                  if temp>=((pi/2)-0.1) then temp:=(pi/2)-0.1;

                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,round(delay*abs(tan(temp))));
                end;
                6: // Tangens 2
                begin
                  delayfaktor:=abs(j-PositionOfMaster);
                  temp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                  countofpihalf:=floor(temp/(pi/2))+1;

                  if temp>=(countofpihalf*(pi/2)-0.2) then temp:=countofpihalf*(pi/2)-0.2;

                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,round(delay*abs(tan(temp))));
                end;
                7: // Halbkreis
                begin
                  delayfaktor:=abs(j-PositionOfMaster);
                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                end;
              end;
            end else
            begin
              case mainform.DeviceGroups[i].FanMode of
                0: // Fanning aus
                begin
                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,0);
                end;
                1: // alle Gleichmäßig
                begin
                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,delay);
                end;
                2: // nach Links
                begin
                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,delay*j);
                end;
                3: // nach Rechts
                begin
                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,delay*(length(mainform.DeviceGroups[i].IDs)-j));
                end;
                4: // Sinus
                begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                end;
                5: // Tangens
                begin
                  temp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                  countofpihalf:=floor(temp/(pi/2))+1;

                  temp:=temp/countofpihalf;
                  if temp>=((pi/2)-0.1) then temp:=(pi/2)-0.1;

                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,round(delay*abs(tan(temp))));
                end;
                6: // Tangens 2
                begin
                  temp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                  countofpihalf:=floor(temp/(pi/2))+1;

                  if temp>=(countofpihalf*(pi/2)-0.2) then temp:=countofpihalf*(pi/2)-0.2;

                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,round(delay*abs(tan(temp))));
                end;
                7: // Halbkreis
                begin
                  set_channel(mainform.DeviceGroups[i].IDs[j],channel,temp_startvalue,endvalue,fadetime,round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                end;
              end;
            end;
          end;
        end;
      end;
      break;
    end;
  end;
end;

function Tgeraetesteuerung.get_channel(DeviceID: TGUID; channel:string):integer;
var
  k:integer;
  actualdevice:integer;
begin
  Result:=0; // -1 macht hier Probleme, da vielfach bei PanTilt auch der Wert von PanFine/TiltFine geholt wird.
              // ist nun kein PanFine/TiltFine vorhanden, wird -1 auf get_channel(PanFine) zurückgegeben und dann
              // wird die Berechnung fehlerhaft. Vor Allem der Befehl "Aktuell selektierte Geräte 16-Bit PAN/TILT"
              // funktioniert dann nicht, da bei 8-Bit-Geräten der Cursor einfach aufgrund des -1 wegwandert
  actualdevice:=GetDevicePositionInDeviceArray(@DeviceID);

  if (actualdevice>=0) and (actualdevice<length(mainform.Devices)) then
  for k:=0 to mainform.Devices[actualdevice].MaxChan-1 do
  begin
    if lowercase(mainform.Devices[actualdevice].kanaltyp[k])=lowercase(channel) then
    begin
      Result:=maxres-mainform.data.ch[mainform.Devices[actualdevice].Startaddress+k];
      break;
    end;
  end;
end;

function Tgeraetesteuerung.get_group(GroupID: TGUID; channel:string):integer;
var
  i,k:integer;
  GroupIndex,DeviceIndex,IntegratedValue,DeviceCount:integer;
begin
  GroupIndex:=GetGroupPositionInGroupArray(GroupID);

  if (GroupIndex>=0) and (GroupIndex<length(mainform.DeviceGroups)) then
  begin
    IntegratedValue:=0;
    DeviceCount:=0;
    for i:=0 to length(mainform.DeviceGroups[GroupIndex].IDs)-1 do
    begin
      DeviceIndex:=GetDevicePositionInDeviceArray(@mainform.DeviceGroups[GroupIndex].IDs[i]);

      if (DeviceIndex>=0) and (DeviceIndex<length(mainform.Devices)) then
      for k:=0 to mainform.Devices[DeviceIndex].MaxChan-1 do
      begin
        if lowercase(mainform.Devices[DeviceIndex].kanaltyp[k])=lowercase(channel) then
        begin
          IntegratedValue:=IntegratedValue+(maxres-mainform.data.ch[mainform.Devices[DeviceIndex].Startaddress+k]);
          inc(DeviceCount);
          break;
        end;
      end;
    end;

    result:=round(IntegratedValue/DeviceCount);
  end else
  begin
    result:=0;
  end;
end;

function Tgeraetesteuerung.channel(channel:integer):Integer;
begin
  Result:=maxres-mainform.data.ch[channel];
end;

procedure Tgeraetesteuerung.suchfenstereditEnter(Sender: TObject);
begin
  if suchfensteredit.text=_('Suchtext hier eingeben...') then
  begin
    suchfensteredit.Text:='';
    suchfensteredit.Font.Color:=clBlack;
  end;
end;

procedure Tgeraetesteuerung.suchfenstereditExit(Sender: TObject);
begin
  if suchfensteredit.Text='' then
  begin
    suchfensteredit.Text:=_('Suchtext hier eingeben...');
    suchfensteredit.Font.Color:=clGray;
  end;
end;

procedure Tgeraetesteuerung.suchfenstereditChange(Sender: TObject);
begin
  SuchTimer.Enabled:=false;
  SuchTimer.Enabled:=true;
end;

procedure Tgeraetesteuerung.showinstageviewMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j,k,position:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  begin
    if VST.Selected[VSTDeviceNodes[i][j][k]] then
    begin
      Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);

      position:=GetDevicePositionInDeviceArray(@Data^.ID);

      if showinstageview.Checked then
      begin
        if not mainform.Devices[position].ShowInStageview then
        begin // Gerätebild hinzufügen
          mainform.Devices[position].ShowInStageview:=true;
        end;
      end else
      begin
        if mainform.Devices[position].ShowInStageview then
        begin // Gerätebild entfernen
          mainform.Devices[position].ShowInStageview:=false;
        end;
      end;
    end;
  end;
end;

procedure Tgeraetesteuerung.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tgeraetesteuerung.PngBitBtn1Click(Sender: TObject);
var
  i,j,k,l:integer;
  newpicturefile:string;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  mainform.LoadDDFPictures;

  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  devicepicturechangeform.aktuellebilddatei:=ExtractFileName(mainform.devices[GetDevicePositionInDeviceArray(@Data^.ID)].Bildadresse);
  devicepicturechangeform.showmodal;

  if devicepicturechangeform.ModalResult=mrOK then
  begin
    newpicturefile:=devicepicturechangeform.aktuellebilddatei;

    for i:=0 to length(VSTDeviceNodes)-1 do
    for j:=0 to length(VSTDeviceNodes[i])-1 do
    for k:=0 to length(VSTDeviceNodes[i][j])-1 do
    begin
      if VST.Selected[VSTDeviceNodes[i][j][k]] then
      begin
        Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);

        for l:=0 to length(mainform.devices)-1 do
        if IsEqualGUID(mainform.devices[l].ID, Data^.ID) then
        begin
          mainform.devices[l].Bildadresse:=newpicturefile;
          break;
        end;
      end;
    end;
  end;
  grafischebuehnenansicht.dorefresh:=true;
  TreeViewCheckbuttons([]);
end;

procedure Tgeraetesteuerung.MSGSave;
begin
//
end;

procedure Tgeraetesteuerung.colorBtnChange(Sender: TObject);
var
  i,j,k:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1, false) then exit;

  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  begin
    if VST.Selected[VSTDeviceNodes[i][j][k]] then
    begin
      Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);
      mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].color:=colorBtn.Color;
    end;
  end;
end;

function Tgeraetesteuerung.FindDeviceConnections(ID: TGUID; var Treeview:TTreeview):boolean;
var
  deviceinuse:boolean;
  i,j,k,l,m,t:integer;
  text,h,min,s,ms:string;
  BefehleNode,KompositionsszeneNode,TastencodeNode,JoystickeventNode,MidiEventArrayNode,DataInEventArrayNode:TTreeNode;
  DevicePresetsNode,DeviceGroupsNode,DeviceScenesNode,AudioeffektplayerNode,EffekteNode,BewegungsszenenNode:TTreeNode;
  SubmasterNode,XTouchControlNode:TTreeNode;
begin
  LockWindow(Treeview.Handle);

  Treeview.Items.Clear;
  deviceinuse:=false;

  BefehleNode:=nil;
  KompositionsszeneNode:=nil;
  TastencodeNode:=nil;
  JoystickeventNode:=nil;
  MidiEventArrayNode:=nil;
  DataInEventArrayNode:=nil;
  DevicePresetsNode:=nil;
  DeviceGroupsNode:=nil;
  DeviceScenesNode:=nil;
  AudioeffektplayerNode:=nil;
  EffekteNode:=nil;
  BewegungsszenenNode:=nil;
  SubmasterNode:=nil;
  XTouchControlNode:=nil;

  //ProgressScreenSmall.Label1.Caption:='Geräteverbindungen suchen...';
  //ProgressScreenSmall.Label2.Caption:='Es werden sämtliche Verbindungen zu diesem Gerät gesucht.';
  //ProgressScreenSmall.Show;

  // Befehle
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  for i:=0 to length(mainform.Befehle2)-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    if length(mainform.Befehle2[i].ArgGUID)>0 then
    if IsEqualGUID(mainform.Befehle2[i].ArgGUID[0],ID) then
    begin
      if BefehleNode=nil then
      begin
        BefehleNode:=Treeview.Items.Add(nil, _('Befehle'));
        BefehleNode.ImageIndex:=15;
        BefehleNode.SelectedIndex:=15;
      end;
      Treeview.Items.AddChild(BefehleNode,mainform.befehle2[i].Name);
      deviceinuse:=true;
    end;
  end;
  // Ende Befehle
  // Tastencodes
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  for i:=0 to length(mainform.TastencodeArray)-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    if length(mainform.TastencodeArray[i].Befehl.ArgGUID)>0 then
    if IsEqualGUID(mainform.TastencodeArray[i].Befehl.ArgGUID[0],ID) then
    begin
      if TastencodeNode=nil then
      begin
        TastencodeNode:=Treeview.Items.Add(nil, _('Tastencode'));
        TastencodeNode.ImageIndex:=24;
        TastencodeNode.SelectedIndex:=24;
      end;
      Treeview.Items.AddChild(TastencodeNode,ShortCutToText(mainform.TastencodeArray[i].HotKey));
      deviceinuse:=true;
    end;
  end;
  // Ende Tastencodes
  // Joystickevents
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  for i:=0 to length(mainform.JoystickEvents)-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    if length(mainform.JoystickEvents[i].Befehl.ArgGUID)>0 then
    if IsEqualGUID(mainform.JoystickEvents[i].Befehl.ArgGUID[0],ID) then
    begin
      if JoystickeventNode=nil then
      begin
        JoystickeventNode:=Treeview.Items.Add(nil, _('Joystickevent'));
        JoystickeventNode.ImageIndex:=28;
        JoystickeventNode.SelectedIndex:=28;
      end;
      Treeview.Items.AddChild(JoystickeventNode,_('Joystickevent ')+inttostr(i+1));
      deviceinuse:=true;
    end;
  end;
  // Ende Joystickevents
  // MidiEvents
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  for i:=0 to length(mainform.MidiEventArray)-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    if length(mainform.MidiEventArray[i].Befehl.ArgGUID)>0 then
    if IsEqualGUID(mainform.MidiEventArray[i].Befehl.ArgGUID[0],ID) then
    begin
      if MidiEventArrayNode=nil then
      begin
        MidiEventArrayNode:=Treeview.Items.Add(nil, _('Midievent'));
        MidiEventArrayNode.ImageIndex:=17;
        MidiEventArrayNode.SelectedIndex:=17;
      end;
      Treeview.Items.AddChild(MidiEventArrayNode,_('MidiEvent ')+inttostr(i+1));
      deviceinuse:=true;
    end;
  end;
  // Ende MidiEvents
  // DataInEvent
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  for i:=0 to length(mainform.DataInEventArray)-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    if length(mainform.DataInEventArray[i].Befehl.ArgGUID)>0 then
    if IsEqualGUID(mainform.DataInEventArray[i].Befehl.ArgGUID[0],ID) then
    begin
      if DataInEventArrayNode=nil then
      begin
        DataInEventArrayNode:=Treeview.Items.Add(nil, _('DataInEvent'));
        DataInEventArrayNode.ImageIndex:=49;
        DataInEventArrayNode.SelectedIndex:=49;
      end;
      Treeview.Items.AddChild(DataInEventArrayNode,_('DataInEvent ')+inttostr(i+1));
      deviceinuse:=true;
    end;
  end;
  // Ende DataInEvent
{
  // DevicePreset
  for i:=0 to length(mainform.DevicePresets)-1 do
  begin
    if IsEqualGUID(mainform.DevicePresets[i].ID,ID) then
    begin
      if DevicePresetsNode=nil then
        DevicePresetsNode:=Treeview.Items.Add(nil, 'Gerätepreset');
      Treeview.Items.AddChild(DevicePresetsNode,mainform.DevicePresets[i].Name);
      deviceinuse:=true;
    end;
  end;
  // Ende DevicePreset
}
  // Gerätegruppen absuchen
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  for i:=0 to length(mainform.DeviceGroups)-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].IDs[j],ID) then
      begin
        if DeviceGroupsNode=nil then
        begin
          DeviceGroupsNode:=Treeview.Items.Add(nil, _('Gerätegruppe'));
          DeviceGroupsNode.ImageIndex:=65;
          DeviceGroupsNode.SelectedIndex:=65;
        end;
        Treeview.Items.AddChild(DeviceGroupsNode,mainform.DeviceGroups[i].Name);
        deviceinuse:=true;
      end;
    end;
  end;
  // Ende Gerätegruppen
  // DeviceSzenen
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  for i:=0 to length(mainform.DeviceScenes)-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    for j:=0 to length(mainform.DeviceScenes[i].Devices)-1 do
    begin
      if IsEqualGUID(mainform.DeviceScenes[i].Devices[j].ID,ID) then
      begin
        if DeviceScenesNode=nil then
        begin
          DeviceScenesNode:=Treeview.Items.Add(nil, _('Geräteszene'));
          DeviceScenesNode.ImageIndex:=25;
          DeviceScenesNode.SelectedIndex:=25;
        end;
        Treeview.Items.AddChild(DeviceScenesNode,mainform.DeviceScenes[i].Name);
        deviceinuse:=true;
      end;
    end;
    for j:=0 to length(mainform.DeviceScenes[i].Befehle)-1 do
    for k:=0 to length(mainform.DeviceScenes[i].Befehle[j].ArgGUID)-1 do
    begin
      if IsEqualGUID(mainform.DeviceScenes[i].Befehle[j].ArgGUID[k],ID) then
      begin
        if DeviceScenesNode=nil then
        begin
          DeviceScenesNode:=Treeview.Items.Add(nil, _('Geräteszene'));
          DeviceScenesNode.ImageIndex:=25;
          DeviceScenesNode.SelectedIndex:=25;
        end;
        Treeview.Items.AddChild(DeviceScenesNode,mainform.DeviceScenes[i].Name+' ('+mainform.DeviceScenes[i].Befehle[j].Name+')');
        deviceinuse:=true;
      end;
    end;
  end;
  // Ende DeviceSzenen
  // Audioeffektplayer
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  if length(mainform.Effektaudio_record)>0 then
  for i:=0 to length(mainform.Effektaudio_record)-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    for k:=1 to maxaudioeffektlayers do
    begin
      if length(mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt)>0 then
      for l:=0 to length(mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt)-1 do
      begin
        if length(mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt[l].Devices)>0 then
        for j:=0 to length(mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt[l].Devices)-1 do
        begin
          if IsEqualGUID(mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt[l].Devices[j].ID,ID) then
          begin
            if AudioeffektplayerNode=nil then
            begin
              AudioeffektplayerNode:=Treeview.Items.Add(nil, _('Audioeffektplayer'));
              AudioeffektplayerNode.ImageIndex:=50;
              AudioeffektplayerNode.SelectedIndex:=50;
            end;
            t:=trunc(mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt[l].audioeffektposition*1000);
            h:=inttostr(t div 3600000); t:=t mod 3600000;
            min:=inttostr(t div 60000); t:=t mod 60000;
            s:=inttostr(t div 1000); t:=t mod 1000;
            ms:=inttostr(t);
            if length(min)=1 then min:='0'+min;
            if length(s)=1 then s:='0'+s;
            if length(ms)=1 then ms:='0'+ms;
            if length(ms)=2 then ms:='0'+ms;
            text:= h+'h'+min+'min'+s+'s'+ms+'ms';

            Treeview.Items.AddChild(AudioeffektplayerNode,mainform.Effektaudio_record[i].audiodatei+', Layer: '+inttostr(k)+', Position: '+text+', Effekt: '+inttostr(l));
            deviceinuse:=true;
          end;
        end;
        for j:=0 to length(mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt[l].Befehle)-1 do
        for m:=0 to length(mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt[l].Befehle[j].ArgGUID)-1 do
        begin
          if IsEqualGUID(mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt[l].Befehle[j].ArgGUID[m],ID) then
          begin
            if AudioeffektplayerNode=nil then
            begin
              AudioeffektplayerNode:=Treeview.Items.Add(nil, _('Audioeffektplayer'));
              AudioeffektplayerNode.ImageIndex:=50;
              AudioeffektplayerNode.SelectedIndex:=50;
            end;
            t:=trunc(mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt[l].audioeffektposition*1000);
            h:=inttostr(t div 3600000); t:=t mod 3600000;
            min:=inttostr(t div 60000); t:=t mod 60000;
            s:=inttostr(t div 1000); t:=t mod 1000;
            ms:=inttostr(t);
            if length(min)=1 then min:='0'+min;
            if length(s)=1 then s:='0'+s;
            if length(ms)=1 then ms:='0'+ms;
            if length(ms)=2 then ms:='0'+ms;
            text:= h+'h'+min+'min'+s+'s'+ms+'ms';

            Treeview.Items.AddChild(AudioeffektplayerNode,mainform.Effektaudio_record[i].audiodatei+' ('+mainform.Effektaudio_record[i].effektaudiodatei.layer[k].effekt[l].Befehle[j].Name+') '+', Layer: '+inttostr(k)+', Position: '+text+', Effekt: '+inttostr(l));
            deviceinuse:=true;
          end;
        end;
      end;
    end;
  end;
  // Ende Audioeffektplayer
  // Effekte
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  if length(mainform.Effektsequenzereffekte)>0 then
  for i:=0 to length(mainform.Effektsequenzereffekte)-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    for k:=0 to length(mainform.Effektsequenzereffekte[i].Effektschritte)-1 do
    begin
      if length(mainform.Effektsequenzereffekte[i].Effektschritte[k].Devices)>0 then
      for j:=0 to length(mainform.Effektsequenzereffekte[i].Effektschritte[k].Devices)-1 do
      begin
        if IsEqualGUID(mainform.Effektsequenzereffekte[i].Effektschritte[k].Devices[j].ID,ID) then
        begin
          if EffekteNode=nil then
          begin
            EffekteNode:=Treeview.Items.Add(nil, _('Effekte'));
            EffekteNode.ImageIndex:=20;
            EffekteNode.SelectedIndex:=20;
          end;
          Treeview.Items.AddChild(EffekteNode,mainform.Effektsequenzereffekte[i].Name+', '+mainform.Effektsequenzereffekte[i].effektschritte[k].Name);
          deviceinuse:=true;
        end;
      end;
      for j:=0 to length(mainform.Effektsequenzereffekte[i].Effektschritte[k].Befehle)-1 do
      for l:=0 to length(mainform.Effektsequenzereffekte[i].Effektschritte[k].Befehle[j].ArgGUID)-1 do
      begin
        if IsEqualGUID(mainform.Effektsequenzereffekte[i].Effektschritte[k].Befehle[j].ArgGUID[l],ID) then
        begin
          if EffekteNode=nil then
          begin
            EffekteNode:=Treeview.Items.Add(nil, _('Effekte'));
            EffekteNode.ImageIndex:=20;
            EffekteNode.SelectedIndex:=20;
          end;
          Treeview.Items.AddChild(EffekteNode,mainform.Effektsequenzereffekte[i].Name+', '+mainform.Effektsequenzereffekte[i].effektschritte[k].Name+' ('+mainform.Effektsequenzereffekte[i].Effektschritte[k].Befehle[j].Name+')');
          deviceinuse:=true;
        end;
      end;
    end;
  end;
  // Ende Effekte
  // Bewegungsszenen
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  if length(mainform.bewegungsszenen)>0 then
  for i:=0 to length(mainform.bewegungsszenen)-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    for k:=0 to length(mainform.bewegungsszenen[i].devices)-1 do
    begin
      if IsEqualGUID(mainform.bewegungsszenen[i].devices[k].ID,ID) then
      begin
        if BewegungsszenenNode=nil then
        begin
          BewegungsszenenNode:=Treeview.Items.Add(nil, _('Bewegungsszenen'));
          BewegungsszenenNode.ImageIndex:=23;
          BewegungsszenenNode.SelectedIndex:=23;
        end;
        Treeview.Items.AddChild(BewegungsszenenNode,mainform.bewegungsszenen[i].Name);
        deviceinuse:=true;
      end;
    end;
  end;
  // Ende Bewegungsszenen
  // Submaster
  //ProgressScreenSmall.ProgressBar1.Max:=length(mainform.Befehle);
  for i:=0 to length(mainform.Submasterbank)-1 do
  for j:=1 to 16 do
  for k:=0 to length(mainform.Submasterbank[i].Submasterdevices[j])-1 do
  begin
    //ProgressScreenSmall.ProgressBar1.Position:=i+1;
    //ProgressScreenSmall.ProgressBar1.Refresh;
    //ProgressScreenSmall.Refresh;
    if IsEqualGUID(mainform.Submasterbank[i].Submasterdevices[j][k].ID,ID) then
    begin
      if SubmasterNode=nil then
      begin
        SubmasterNode:=Treeview.Items.Add(nil, _('Submaster'));
        SubmasterNode.ImageIndex:=26;
        SubmasterNode.SelectedIndex:=26;
      end;
      Treeview.Items.AddChild(SubmasterNode,mainform.Submasterbank[i].BankName+', Fader '+inttostr(j));
      deviceinuse:=true;
    end;
  end;
  // Ende Submaster
  // XTouchControl
  for i:=0 to length(mainform.XTouchPCDDevicesOrGroups)-1 do
  begin
    if IsEqualGUID(mainform.XTouchPCDDevicesOrGroups[i].ID,ID) then
    begin
      if XTouchControlNode=nil then
      begin
        XTouchControlNode:=Treeview.Items.Add(nil, _('XTouchControl'));
        XTouchControlNode.ImageIndex:=26;
        XTouchControlNode.SelectedIndex:=26;
      end;
      Treeview.Items.AddChild(XTouchControlNode,'XTouchControl');
      deviceinuse:=true;
    end;
  end;
  // Ende XTouchControl

  //ProgressScreenSmall.Hide;

  Treeview.FullExpand;
  result:=deviceinuse;

  UnLockWindow(Treeview.Handle);
end;

procedure Tgeraetesteuerung.WMMoving(var AMsg: TMessage);
begin
  if DDFWindowDeviceScene.showing then
  begin
    DDFWindowDeviceScene.top:=geraetesteuerung.Top;
    DDFWindowDeviceScene.left:=geraetesteuerung.Left+geraetesteuerung.Width;
  end;
end;

procedure Tgeraetesteuerung.RefreshDeviceDependencies;
var
  Data:PTreeData;
begin
  Treeview2.Items.clear;

  if VST.SelectedCount=1 then
  begin
    Data:=VST.GetNodeData(VST.FocusedNode);
    FindDeviceConnections(Data^.ID,Treeview2);
  end;
end;

procedure Tgeraetesteuerung.SendNamesBtnClick(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(mainform.data.Names)-1 do
  begin
    mainform.data.Names[i]:=_('Kanal ')+inttostr(i);
  end;

  for i:=0 to length(mainform.devices)-1 do
  begin
    for j:=0 to mainform.Devices[i].MaxChan-1 do
    begin
      mainform.data.names[mainform.Devices[i].Startaddress+j]:=mainform.Devices[i].Name+': '+mainform.Devices[i].kanalname[j];
    end;
  end;

  mainform.pluginsaktualisieren(Sender);
end;

procedure Tgeraetesteuerung.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  suchfensteredit.text:=_('Suchtext hier eingeben...');
  suchfenstergruppen.text:=_('Suchtext hier eingeben...');
  Bmp := TImage.Create(self);
  argumente:=TJvInterpreterArgs.Create;
  geraetesteuerung.ClientWidth:=692;
  geraetesteuerung.ClientHeight:=540;
end;

procedure Tgeraetesteuerung.PngBitBtn2Click(Sender: TObject);
var
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);
  begin
    dimmcurveform.aktuellesgeraet:=GetDevicePositionInDeviceArray(@Data^.ID);
    dimmcurveform.showmodal;
  end;
end;

procedure Tgeraetesteuerung.minusClick(Sender: TObject);
begin
  VST.FullCollapse;
end;

procedure Tgeraetesteuerung.plusClick(Sender: TObject);
begin
  VST.FullExpand;
end;

procedure Tgeraetesteuerung.ActivateGroupBtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if length(mainform.DeviceGroups)>=Grouplist.row then
  begin
    mainform.SelectDeviceGroup(mainform.DeviceGroups[Grouplist.row-1].ID, false);
  end;
end;

procedure Tgeraetesteuerung.Gerteadressenexportieren1Click(
  Sender: TObject);
var
  i,Count1:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  SaveDialog1.Filter:=_('PC_DIMMER Geräteadressendatei (*.pcddeva)|*.pcddeva|Alle Dateien|*.*');
  SaveDialog1.DefaultExt:='*.pcddeva';
  SaveDialog1.Title:=_('PC_DIMMER Geräteadressendatei speichern');
  if SaveDialog1.Execute then
  begin
    FileStream:=TFilestream.Create(SaveDialog1.FileName,fmCreate);
    Count1:=length(mainform.devices);
    FileStream.WriteBuffer(Count1,sizeof(Count1));
    for i:=0 to Count1-1 do
    begin
      FileStream.WriteBuffer(mainform.devices[i].ID,sizeof(mainform.devices[i].ID));
      FileStream.WriteBuffer(mainform.devices[i].startaddress,sizeof(mainform.devices[i].startaddress));
    end;
    FileStream.Free;
  end;
end;

procedure Tgeraetesteuerung.Adressenimportieren1Click(Sender: TObject);
var
  i,j,Count1:integer;
  IDs:array of TGUID;
  Adressen:array of Word;
begin
  if not mainform.UserAccessGranted(1) then exit;

  OpenDialog1.Filter:=_('PC_DIMMER Geräteadressendatei (*.pcddeva)|*.pcddeva|Alle Dateien|*.*');
  OpenDialog1.DefaultExt:='*.pcddeva';
  OpenDialog1.Title:=_('PC_DIMMER Geräteadressendatei öffnen');
  if OpenDialog1.Execute then
  begin
    FileStream:=TFilestream.Create(SaveDialog1.FileName,fmOpenRead);
    FileStream.ReadBuffer(Count1,sizeof(Count1));
    setlength(IDs,Count1);
    setlength(Adressen,Count1);
    for i:=0 to Count1-1 do
    begin
      FileStream.ReadBuffer(IDs[i],sizeof(IDs[i]));
      FileStream.ReadBuffer(Adressen[i],sizeof(Adressen[i]));
    end;
    FileStream.Free;

    for i:=0 to length(mainform.devices)-1 do
    begin
      for j:=0 to length(IDs)-1 do
      begin
        if IsEqualGUID(mainform.devices[i].ID,IDs[j]) then
        begin
          mainform.devices[i].Startaddress:=Adressen[j];
          break;
        end;
      end;
    end;
  end;
end;

procedure Tgeraetesteuerung.autosceningMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j,k:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  begin
    if VST.Selected[VSTDeviceNodes[i][j][k]] then
    begin
      Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);
      mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].autoscening:=autoscening.Checked;
    end;
  end;
end;

procedure Tgeraetesteuerung.SuchTimerTimer(Sender: TObject);
var
  i,j,k:integer;
  Suchtext:string;
  Data, Data2, Data3:PTreeData;
begin
  SuchTimer.Enabled:=false;
  VST.FullCollapse;
  Suchtext:=LowerCase(suchfensteredit.Text);

  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  begin
    Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);
    Data2:=VST.GetNodeData(VSTTypeNodes[i][j]);
    Data3:=VST.GetNodeData(VSTVendorNodes[i]);

    if (pos(suchtext, LowerCase(Data^.Caption))>0) or (pos(suchtext, LowerCase(Data2^.Caption))>0) or (pos(suchtext, LowerCase(Data3^.Caption))>0) then
    begin
      VST.Expanded[VSTDeviceNodes[i][j][k].Parent.Parent]:=true;
      VST.Expanded[VSTDeviceNodes[i][j][k].Parent]:=true;
      VST.Expanded[VSTDeviceNodes[i][j][k]]:=true;
      VST.Selected[VSTDeviceNodes[i][j][k]]:=true;
      VST.FocusedNode:=VSTDeviceNodes[i][j][k];
    end else
    begin
      VST.Selected[VSTDeviceNodes[i][j][k]]:=false;
    end;
  end;
  TreeViewCheckbuttons([]);
end;

procedure Tgeraetesteuerung.suchfenstereditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return then
    SuchTimerTimer(nil);
end;

procedure Tgeraetesteuerung.copycountsChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure Tgeraetesteuerung.copycountsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,j,k:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if key=vk_return then
  begin
    if TEdit(Sender).text='0' then TEdit(Sender).text:='1';
    if TEdit(Sender).text<>'' then
    begin
      for i:=0 to length(VSTDeviceNodes)-1 do
      for j:=0 to length(VSTDeviceNodes[i])-1 do
      for k:=0 to length(VSTDeviceNodes[i][j])-1 do
      begin
        if VST.Selected[VSTDeviceNodes[i][j][k]] then
        begin
          Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);
          setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].top,strtoint(copycounts.text));
          setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].left,strtoint(copycounts.text));
          setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].bank,strtoint(copycounts.text));
          setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].selected,strtoint(copycounts.text));
          setlength(mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].OldPos,strtoint(copycounts.text));
        end;
      end;
    end;
  end;
end;

procedure Tgeraetesteuerung.copycountsKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    key := #0;
end;

procedure Tgeraetesteuerung.PngBitBtn4Click(Sender: TObject);
var
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);
  begin
    colormanagerform.aktuellesgeraet:=GetDevicePositionInDeviceArray(@Data^.ID);
    if not mainform.devices[colormanagerform.aktuellesgeraet].hasColor then
      ShowMessage(_('Das Gerät besitzt offenbar keinen Farbkanal. Einstellungen im folgenden Fenster wirken sich nur auf Geräte mit "COLOR1"-Kanal über die Autoszenen aus.'));
    colormanagerform.showmodal;
  end;
end;

procedure Tgeraetesteuerung.DIP1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
  LSB,MSB:byte;
  temp:integer;
begin
  if not mainform.UserAccessGranted(1, false) then exit;

  if (button=mbLeft) then
  begin
    for i:=1 to 10 do
    begin
      if Sender=Timage(FindComponent('DIP'+inttostr(i))) then
      begin
        if dipstate[i] then
        begin
          // ausschalten
          dipstate[i]:=false;
          Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPOFF.Picture;
        end else
        begin
          // einschalten
          dipstate[i]:=true;
          Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPON.Picture;
        end;
      end;
    end;

    LSB:=0;
    if dipstate[1] then LSB:=LSB or 1;
    if dipstate[2] then LSB:=LSB or 2;
    if dipstate[3] then LSB:=LSB or 4;
    if dipstate[4] then LSB:=LSB or 8;
    if dipstate[5] then LSB:=LSB or 16;
    if dipstate[6] then LSB:=LSB or 32;
    if dipstate[7] then LSB:=LSB or 64;
    if dipstate[8] then LSB:=LSB or 128;
    MSB:=0;
    if dipstate[9] then MSB:=MSB or 1;
    if dipstate[10] then MSB:=MSB or 2;
    temp:=MSB;
    temp:=temp shl 8;
    temp:=temp+LSB;

    if (temp > 0) then
      DevStartaddressEdit.Text:=inttostr(temp);
  end;
end;

procedure Tgeraetesteuerung.FormDestroy(Sender: TObject);
begin
  Bmp.Free;
  argumente.Free;
end;

procedure Tgeraetesteuerung.suchfenstergruppenExit(Sender: TObject);
begin
  if suchfenstergruppen.Text='' then
  begin
    suchfenstergruppen.Text:=_('Suchtext hier eingeben...');
    suchfenstergruppen.Font.Color:=clGray;
  end;
end;

procedure Tgeraetesteuerung.suchfenstergruppenEnter(Sender: TObject);
begin
  if suchfenstergruppen.text=_('Suchtext hier eingeben...') then
  begin
    suchfenstergruppen.Text:='';
    suchfenstergruppen.Font.Color:=clBlack;
  end;
end;

procedure Tgeraetesteuerung.suchfenstergruppenChange(Sender: TObject);
begin
  SuchGruppenTimer.Enabled:=false;
  SuchGruppenTimer.Enabled:=true;
end;

procedure Tgeraetesteuerung.suchfenstergruppenKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then
    SuchGruppenTimerTimer(nil);
end;

procedure Tgeraetesteuerung.SuchGruppenTimerTimer(Sender: TObject);
var
  text,suchtext:string;
  i:integer;
begin
  SuchGruppenTimer.Enabled:=False;

  Suchtext:=suchfenstergruppen.Text;
  for i:=1 to Grouplist.RowCount-1 do
  begin
    Text:=Grouplist.Cells[0,i];

    if StrPos(StrLower(PCHar(Text)),StrLower(PChar(Suchtext)))<>nil then
    begin
      Grouplist.Row:=i;
      ActivateGroupBtnClick(nil);      
      exit;
    end;
  end;
end;

procedure Tgeraetesteuerung.Scannersynchronisation1Click(Sender: TObject);
var
  i:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);
  begin
    scannersynchronisationform.aktuellesgeraet:=GetDevicePositionInDeviceArray(@Data^.ID);

    // Alle Kalibrierdaten in ein Temporäres Array kopieren
    for i:=0 to 16 do
      mainform.ScannerSyncTempArray[i]:=mainform.devices[scannersynchronisationform.aktuellesgeraet].ScannerCalibrations[i];

    // Scannerkalibrierungen auf 0 setzen (Für Vorschau wird innerhalb des Fensters neue kalibrierte Werte für PAN, TILT und FINE-Kanäle berechnet)
    for i:=0 to 16 do
    begin
      mainform.devices[scannersynchronisationform.aktuellesgeraet].ScannerCalibrations[i].PointA.X:=0;
      mainform.devices[scannersynchronisationform.aktuellesgeraet].ScannerCalibrations[i].PointA.Y:=0;
      mainform.devices[scannersynchronisationform.aktuellesgeraet].ScannerCalibrations[i].PointB.X:=255;
      mainform.devices[scannersynchronisationform.aktuellesgeraet].ScannerCalibrations[i].PointB.Y:=0;
      mainform.devices[scannersynchronisationform.aktuellesgeraet].ScannerCalibrations[i].PointC.X:=255;
      mainform.devices[scannersynchronisationform.aktuellesgeraet].ScannerCalibrations[i].PointC.Y:=255;
      mainform.devices[scannersynchronisationform.aktuellesgeraet].ScannerCalibrations[i].PointD.X:=0;
      mainform.devices[scannersynchronisationform.aktuellesgeraet].ScannerCalibrations[i].PointD.Y:=255;
    end;
    scannersynchronisationform.showmodal;
  end;
end;

procedure Tgeraetesteuerung.fadenkreuzMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dontrefreshXY:=false;
end;

procedure Tgeraetesteuerung.GertemitGertedateiabgleichen1Click(
  Sender: TObject);
var
  i,j,k:integer;
  DeviceHasGobo:boolean;
begin
  DeviceHasGobo:=false;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if not DeviceHasGobo then
        DeviceHasGobo:=mainform.devices[i].hasGobo or mainform.devices[i].hasGobo2;

      for j:=0 to length(DevicePrototyp)-1 do
      begin
        if (mainform.devices[i].DeviceName=DevicePrototyp[j].DeviceName) and (mainform.devices[i].Vendor=DevicePrototyp[j].Vendor) then
        begin
          mainform.devices[i].MaxChan:=DevicePrototyp[j].MaxChan;

          setlength(mainform.devices[i].KanalMaxValue,mainform.devices[i].MaxChan);
          setlength(mainform.devices[i].KanalMaxValue,mainform.devices[i].MaxChan);
          setlength(mainform.devices[i].kanaltyp,mainform.devices[i].MaxChan);
          setlength(mainform.devices[i].kanalname,mainform.devices[i].MaxChan);
          setlength(mainform.devices[i].kanalfade,mainform.devices[i].MaxChan);
          for k:=0 to mainform.devices[i].MaxChan-1 do
          begin
            mainform.devices[i].KanalMinValue[k]:=DevicePrototyp[j].KanalMinValue[k];
            mainform.devices[i].KanalMaxValue[k]:=DevicePrototyp[j].KanalMaxValue[k];
            mainform.devices[i].kanaltyp[k]:=DevicePrototyp[j].kanaltyp[k];
            mainform.devices[i].kanalname[k]:=DevicePrototyp[j].kanalname[k];
            mainform.devices[i].kanalfade[k]:=DevicePrototyp[j].kanalfade[k];
          end;
          setlength(mainform.Devices[i].colors,length(DevicePrototyp[j].colors));
          setlength(mainform.Devices[i].colorlevels,length(DevicePrototyp[j].colors));
          setlength(mainform.Devices[i].colorendlevels,length(DevicePrototyp[j].colors));
          setlength(mainform.Devices[i].colornames,length(DevicePrototyp[j].colors));
          for k:=0 to length(mainform.devices[i].colors)-1 do
          begin
            mainform.devices[i].colors[k]:=DevicePrototyp[j].colors[k];
            mainform.devices[i].colorlevels[k]:=DevicePrototyp[j].colorlevels[k];
            mainform.devices[i].colorendlevels[k]:=DevicePrototyp[j].colorendlevels[k];
            mainform.devices[i].colornames[k]:=DevicePrototyp[j].colornames[k];
          end;
          setlength(mainform.Devices[i].colors2, length(DevicePrototyp[j].colors2));
          setlength(mainform.Devices[i].colorlevels2, length(DevicePrototyp[j].colors2));
          setlength(mainform.Devices[i].colorendlevels2, length(DevicePrototyp[j].colors2));
          setlength(mainform.Devices[i].colornames2, length(DevicePrototyp[j].colors2));
          for k:=0 to length(mainform.devices[i].colors2)-1 do
          begin
            mainform.devices[i].colors2[k]:=DevicePrototyp[j].colors2[k];
            mainform.devices[i].colorlevels2[k]:=DevicePrototyp[j].colorlevels2[k];
            mainform.devices[i].colorendlevels2[k]:=DevicePrototyp[j].colorendlevels2[k];
            mainform.devices[i].colornames2[k]:=DevicePrototyp[j].colornames2[k];
          end;
          setlength(mainform.Devices[i].gobos,length(DevicePrototyp[j].gobos));
          setlength(mainform.Devices[i].gobolevels,length(DevicePrototyp[j].gobos));
          setlength(mainform.Devices[i].goboendlevels,length(DevicePrototyp[j].gobos));
          setlength(mainform.Devices[i].gobonames,length(DevicePrototyp[j].gobos));
          setlength(mainform.Devices[i].bestgobos,length(DevicePrototyp[j].gobos));
          for k:=0 to length(mainform.devices[i].gobos)-1 do
          begin
            mainform.devices[i].gobos[k]:=DevicePrototyp[j].gobos[k];
            mainform.devices[i].gobolevels[k]:=DevicePrototyp[j].gobolevels[k];
            mainform.devices[i].goboendlevels[k]:=DevicePrototyp[j].goboendlevels[k];
            mainform.devices[i].gobonames[k]:=DevicePrototyp[j].gobonames[k];
            AddGobo(mainform.devices[i].gobos[k]);
          end;
          setlength(mainform.Devices[i].gobos2,length(DevicePrototyp[j].gobos2));
          setlength(mainform.Devices[i].gobolevels2,length(DevicePrototyp[j].gobos));
          setlength(mainform.Devices[i].goboendlevels2,length(DevicePrototyp[j].gobos));
          setlength(mainform.Devices[i].gobonames2,length(DevicePrototyp[j].gobos));
          setlength(mainform.Devices[i].bestgobos2,length(DevicePrototyp[j].gobos2));
          for k:=0 to length(mainform.devices[i].gobos2)-1 do
          begin
            mainform.devices[i].gobos2[k]:=DevicePrototyp[j].gobos2[k];
            mainform.devices[i].gobolevels2[k]:=DevicePrototyp[j].gobolevels2[k];
            mainform.devices[i].goboendlevels2[k]:=DevicePrototyp[j].goboendlevels2[k];
            mainform.devices[i].gobonames2[k]:=DevicePrototyp[j].gobonames2[k];
            AddGobo(mainform.devices[i].gobos2[k]);
          end;

          mainform.devices[i].ShutterOpenValue:=DevicePrototyp[j].ShutterOpenValue;
          mainform.devices[i].ShutterCloseValue:=DevicePrototyp[j].ShutterCloseValue;
          mainform.devices[i].ShutterChannel:=DevicePrototyp[j].ShutterChannel;
          mainform.devices[i].StrobeOffValue:=DevicePrototyp[j].StrobeOffValue;
          mainform.devices[i].StrobeMinValue:=DevicePrototyp[j].StrobeMinValue;
          mainform.devices[i].StrobeMaxValue:=DevicePrototyp[j].StrobeMaxValue;
          mainform.devices[i].StrobeChannel:=DevicePrototyp[j].StrobeChannel;
          mainform.devices[i].DimmerOffValue:=DevicePrototyp[j].DimmerOffValue;
          mainform.devices[i].DimmerMaxValue:=DevicePrototyp[j].DimmerMaxValue;
          mainform.devices[i].FogOffValue:=DevicePrototyp[j].FogOffValue;
          mainform.devices[i].FogMaxValue:=DevicePrototyp[j].FogMaxValue;
          mainform.devices[i].Gobo1RotLeftminValue:=DevicePrototyp[j].Gobo1RotLeftminValue;
          mainform.devices[i].Gobo1RotLeftValue:=DevicePrototyp[j].Gobo1RotLeftValue;
          mainform.devices[i].Gobo1RotOffValue:=DevicePrototyp[j].Gobo1RotOffValue;
          mainform.devices[i].Gobo1RotRightminValue:=DevicePrototyp[j].Gobo1RotRightminValue;
          mainform.devices[i].Gobo1RotRightValue:=DevicePrototyp[j].Gobo1RotRightValue;
          mainform.devices[i].Gobo1RotChannel:=DevicePrototyp[j].Gobo1RotChannel;
          mainform.devices[i].Gobo2RotLeftminValue:=DevicePrototyp[j].Gobo2RotLeftminValue;
          mainform.devices[i].Gobo2RotLeftValue:=DevicePrototyp[j].Gobo2RotLeftValue;
          mainform.devices[i].Gobo2RotOffValue:=DevicePrototyp[j].Gobo2RotOffValue;
          mainform.devices[i].Gobo2RotRightminValue:=DevicePrototyp[j].Gobo2RotRightminValue;
          mainform.devices[i].Gobo2RotRightValue:=DevicePrototyp[j].Gobo2RotRightValue;
          mainform.devices[i].Gobo2RotChannel:=DevicePrototyp[j].Gobo2RotChannel;

          mainform.devices[i].PrismaSingleValue:=DevicePrototyp[j].PrismaSingleValue;
          mainform.devices[i].PrismaTripleValue:=DevicePrototyp[j].PrismaTripleValue;
          mainform.devices[i].PrismaRotOffValue:=DevicePrototyp[j].PrismaRotOffValue;
          mainform.devices[i].PrismaRotLeftminValue:=DevicePrototyp[j].PrismaRotLeftminValue;
          mainform.devices[i].PrismaRotLeftmaxValue:=DevicePrototyp[j].PrismaRotLeftmaxValue;
          mainform.devices[i].PrismaRotRightminValue:=DevicePrototyp[j].PrismaRotRightminValue;
          mainform.devices[i].PrismaRotRightmaxValue:=DevicePrototyp[j].PrismaRotRightmaxValue;
          mainform.devices[i].PrismaRotChannel:=DevicePrototyp[j].PrismaRotChannel;
          mainform.devices[i].IrisCloseValue:=DevicePrototyp[j].IrisCloseValue;
          mainform.devices[i].IrisOpenValue:=DevicePrototyp[j].IrisOpenValue;
          mainform.devices[i].IrisMinValue:=DevicePrototyp[j].IrisMinValue;
          mainform.devices[i].IrisMaxValue:=DevicePrototyp[j].IrisMaxValue;

          mainform.devices[i].hasDimmer:=DevicePrototyp[j].hasDimmer;
          mainform.devices[i].hasShutter:=DevicePrototyp[j].hasShutter;
          mainform.devices[i].hasVirtualRGBAWDimmer:=DevicePrototyp[j].hasVirtualRGBAWDimmer;
          mainform.devices[i].hasRGB:=DevicePrototyp[j].hasRGB;
          mainform.devices[i].hasCMY:=DevicePrototyp[j].hasCMY;
          mainform.devices[i].hasAmber:=DevicePrototyp[j].hasAmber;
          mainform.devices[i].hasWhite:=DevicePrototyp[j].hasWhite;
          mainform.devices[i].hasUV:=DevicePrototyp[j].hasUV;
          mainform.devices[i].hasFog:=DevicePrototyp[j].hasFog;
          mainform.devices[i].UseAmberMixing:=DevicePrototyp[j].UseAmberMixing;
          mainform.devices[i].AmberMixingCompensateRG:=DevicePrototyp[j].AmberMixingCompensateRG;
          mainform.devices[i].AmberMixingCompensateBlue:=DevicePrototyp[j].AmberMixingCompensateBlue;
          mainform.devices[i].AmberRatioR:=DevicePrototyp[j].AmberRatioR;
          mainform.devices[i].AmberRatioG:=DevicePrototyp[j].AmberRatioG;
          mainform.devices[i].hasPANTILT:=DevicePrototyp[j].hasPANTILT;
          mainform.devices[i].hasColor:=DevicePrototyp[j].hasColor;
          mainform.devices[i].hasColor2:=DevicePrototyp[j].hasColor2;
          mainform.devices[i].hasGobo:=DevicePrototyp[j].hasGobo;
          mainform.devices[i].hasGobo2:=DevicePrototyp[j].hasGobo2;

          mainform.devices[i].UseAmberMixing:=DevicePrototyp[j].UseAmberMixing;
          mainform.devices[i].AmberMixingCompensateRG:=DevicePrototyp[j].AmberMixingCompensateRG;
          mainform.devices[i].AmberMixingCompensateBlue:=DevicePrototyp[j].AmberMixingCompensateBlue;
          mainform.devices[i].AmberRatioR:=DevicePrototyp[j].AmberRatioR;
          mainform.devices[i].AmberRatioG:=DevicePrototyp[j].AmberRatioG;

          mainform.devices[i].MatrixXCount:=DevicePrototyp[j].MatrixXCount;
          mainform.devices[i].MatrixYCount:=DevicePrototyp[j].MatrixYCount;
          mainform.devices[i].MatrixOrdertype:=DevicePrototyp[j].MatrixOrdertype;
          break;
        end;
      end;
    end;
  end;

  if DeviceHasGobo then
    sidebarform.RefreshGoboCorrelation;
end;

procedure Tgeraetesteuerung.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Tgeraetesteuerung.AddDeviceGroupWithoutDeselectBtnClick(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if length(mainform.DeviceGroups)>=Grouplist.row then
  begin
    mainform.SelectDeviceGroup(mainform.DeviceGroups[Grouplist.row-1].ID, true);
  end;
end;

procedure Tgeraetesteuerung.GrouplistMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (GroupList.Col=0) and (GroupList.Row>0) and ((GroupList.Row-1)<length(mainform.devicegroups)) then
  begin
    mainform.devicegroups[GroupList.Row-1].Active:=not mainform.devicegroups[GroupList.Row-1].Active;
    groupeditorform.GroupListChanged;
  end;
end;

procedure Tgeraetesteuerung.ShowGroupIDbtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if length(mainform.DeviceGroups)>=Grouplist.row then
  begin
    InputBox(_('Gruppen-ID'),_('Die ID der aktuellen Gruppe lautet wie folgt:'),GUIDtoString(mainform.DeviceGroups[Grouplist.row-1].ID));
  end;
end;

procedure Tgeraetesteuerung.SyncTypeBoxSelect(Sender: TObject);
var
  i,j,k:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  begin
    if VST.Selected[VSTDeviceNodes[i][j][k]] then
    begin
      Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);
      mainform.Devices[GetDevicePositionInDeviceArray(@Data^.ID)].typeofscannercalibration:=SyncTypeBox.itemindex;
    end;
  end;
end;

procedure Tgeraetesteuerung.CheckDeviceGroupIntersection(PositionInGroupArray:integer; var HasChanType:Array of Boolean);
var
  j,k,l,m{,PositionInDevArray}:integer;
begin
{
  // Alle Geräte der Gruppe durchgehen
  for j:=0 to length(mainform.devicegroups[PositionInGroupArray].IDs)-1 do
  begin
    PositionInDevArray:=geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.devicegroups[PositionInGroupArray].IDs[j]);


    // Alle Kanäle des aktuellen Gerätes durchgehen
    for l:=0 to length(mainform.devices[PositionInDevArray].kanaltyp)-1 do
    begin
      // Alle installierten Kanäle durchgehen
      for m:=0 to length(mainform.DeviceChannelNames)-1 do
      begin
        if lowercase(mainform.devices[PositionInDevArray].kanaltyp[l])=lowercase(mainform.DeviceChannelNames[m]) then
        begin
          HasChanType[m]:=true;
          break;
        end;
      end;
    end;
  end;
}

  // Alle Geräte der Gruppe durchgehen
  for j:=0 to length(mainform.devicegroups[PositionInGroupArray].IDs)-1 do
  begin
    // Alle installierten Geräte durchgehen
    for k:=0 to length(mainform.devices)-1 do
    begin
      if IsEqualGUID(mainform.devicegroups[PositionInGroupArray].IDs[j],mainform.devices[k].ID) then
      begin
        // Alle Kanäle des aktuellen Gerätes durchgehen
        for l:=0 to length(mainform.devices[k].kanaltyp)-1 do
        begin
          // Alle installierten Kanäle durchgehen
          for m:=0 to length(mainform.DeviceChannelNames)-1 do
          begin
            if lowercase(mainform.devices[k].kanaltyp[l])=lowercase(mainform.DeviceChannelNames[m]) then
            begin
              HasChanType[m]:=true;
              break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure Tgeraetesteuerung.ReorderGroupBtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (Grouplist.row-1)<length(mainform.devicegroups) then
    groupeditorform.Grouplistbox.itemindex:=Grouplist.row-1;
  groupeditorform.show;
end;

procedure Tgeraetesteuerung.Gruppeneditor1Click(Sender: TObject);
begin
  groupeditorform.show;
end;

procedure Tgeraetesteuerung.upbtnClick(Sender: TObject);
var
  ActualPosition:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  ActualPosition:=GetDevicePositionInDeviceArray(@Data^.ID);
  setlength(mainform.devices,length(mainform.devices)+1);

  // Obere Position ans Ende kopieren
  CopyDevice(ActualPosition-1,length(mainform.devices)-1);
  // Aktuelle Position auf obere Position
  CopyDevice(ActualPosition, ActualPosition-1);
  // Letzte Position auf aktuelle Position
  CopyDevice(length(mainform.devices)-1,ActualPosition);

  setlength(mainform.devices,length(mainform.devices)-1);
  position:=Data^.ID;
  SendNamesBtnClick(nil);
  RefreshTreeNew;
  TreeViewCheckbuttons([]);
end;

procedure Tgeraetesteuerung.downbtnClick(Sender: TObject);
var
  ActualPosition:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  ActualPosition:=GetDevicePositionInDeviceArray(@Data^.ID);
  setlength(mainform.devices,length(mainform.devices)+1);

  // Untere Position ans Ende kopieren
  CopyDevice(ActualPosition+1,length(mainform.devices)-1);
  // Aktuelle Position auf untere Position
  CopyDevice(ActualPosition, ActualPosition+1);
  // Letzte Position auf aktuelle Position
  CopyDevice(length(mainform.devices)-1,ActualPosition);

  setlength(mainform.devices,length(mainform.devices)-1);
  position:=Data^.ID;
  SendNamesBtnClick(nil);
  RefreshTreeNew;
  TreeViewCheckbuttons([]);
end;

procedure Tgeraetesteuerung.CopyDevice(Source, Destination: integer);
var
  i,j:integer;
begin
  mainform.devices[Destination].ID:=mainform.devices[Source].ID;
  mainform.devices[Destination].Name:=mainform.devices[Source].Name;
  mainform.devices[Destination].DeviceName:=mainform.devices[Source].DeviceName;
  mainform.devices[Destination].Beschreibung:=mainform.devices[Source].Beschreibung;
  mainform.devices[Destination].Vendor:=mainform.devices[Source].Vendor;
  mainform.devices[Destination].Bildadresse:=mainform.devices[Source].Bildadresse;
  mainform.devices[Destination].Startaddress:=mainform.devices[Source].Startaddress;
  mainform.devices[Destination].MaxChan:=mainform.devices[Source].MaxChan;
  mainform.devices[Destination].invertpan:=mainform.devices[Source].invertpan;
  mainform.devices[Destination].inverttilt:=mainform.devices[Source].inverttilt;

  mainform.devices[Destination].typeofscannercalibration:=mainform.devices[Source].typeofscannercalibration;

  mainform.devices[Destination].PanStartvalue:=mainform.devices[Source].PanStartvalue;
  mainform.devices[Destination].TiltStartvalue:=mainform.devices[Source].TiltStartvalue;
  mainform.devices[Destination].PanEndvalue:=mainform.devices[Source].PanEndvalue;
  mainform.devices[Destination].TiltEndvalue:=mainform.devices[Source].TiltEndvalue;
  mainform.devices[Destination].CalibrationpointA:=mainform.devices[Source].CalibrationpointA;
  mainform.devices[Destination].CalibrationpointB:=mainform.devices[Source].CalibrationpointB;
  mainform.devices[Destination].CalibrationpointC:=mainform.devices[Source].CalibrationpointC;
  mainform.devices[Destination].CalibrationpointD:=mainform.devices[Source].CalibrationpointD;
  mainform.devices[Destination].CalibrationpointAsync:=mainform.devices[Source].CalibrationpointAsync;
  mainform.devices[Destination].CalibrationpointBsync:=mainform.devices[Source].CalibrationpointBsync;
  mainform.devices[Destination].CalibrationpointCsync:=mainform.devices[Source].CalibrationpointCsync;
  mainform.devices[Destination].CalibrationpointDsync:=mainform.devices[Source].CalibrationpointDsync;

  for i:=0 to 16 do
    mainform.devices[Destination].ScannerCalibrations[i]:=mainform.devices[Source].ScannerCalibrations[i];

  setlength(mainform.devices[Destination].KanalMinValue,length(mainform.devices[Source].KanalMinValue));
  setlength(mainform.devices[Destination].KanalMaxValue,length(mainform.devices[Source].KanalMaxValue));
  setlength(mainform.devices[Destination].kanaltyp,length(mainform.devices[Source].kanaltyp));
  setlength(mainform.devices[Destination].kanalname,length(mainform.devices[Source].kanalname));
  setlength(mainform.devices[Destination].kanalfade,length(mainform.devices[Source].kanalfade));
  setlength(mainform.devices[Destination].kanaldimmcurve,length(mainform.devices[Source].kanaldimmcurve));
  setlength(mainform.devices[Destination].kanalabsolutedimmcurve,length(mainform.devices[Source].kanalabsolutedimmcurve));
  for i:=0 to length(mainform.devices[Source].KanalMinValue)-1 do
  begin
    mainform.devices[Destination].KanalMinValue[i]:=mainform.devices[Source].KanalMinValue[i];
    mainform.devices[Destination].KanalMaxValue[i]:=mainform.devices[Source].KanalMaxValue[i];
    mainform.devices[Destination].kanaltyp[i]:=mainform.devices[Source].kanaltyp[i];
    mainform.devices[Destination].kanalname[i]:=mainform.devices[Source].kanalname[i];
    mainform.devices[Destination].kanalfade[i]:=mainform.devices[Source].kanalfade[i];
    mainform.devices[Destination].kanaldimmcurve[i]:=mainform.devices[Source].kanaldimmcurve[i];
    mainform.devices[Destination].kanalabsolutedimmcurve[i]:=mainform.devices[Source].kanalabsolutedimmcurve[i];
  end;
  mainform.devices[Destination].autoscening:=mainform.devices[Source].autoscening;

  mainform.devices[Destination].ShowInStageview:=mainform.devices[Source].ShowInStageview;
  mainform.devices[Destination].color:=mainform.devices[Source].color;
  mainform.devices[Destination].picturesize:=mainform.devices[Source].picturesize;
  mainform.devices[Destination].pictureangle:=mainform.devices[Source].pictureangle;
  mainform.devices[Destination].picturefliphor:=mainform.devices[Source].picturefliphor;
  mainform.devices[Destination].pictureflipver:=mainform.devices[Source].pictureflipver;
  mainform.devices[Destination].pictureispng:=mainform.devices[Source].pictureispng;
  mainform.devices[Destination].top:=mainform.devices[Source].top;
  mainform.devices[Destination].left:=mainform.devices[Source].left;
  mainform.devices[Destination].bank:=mainform.devices[Source].bank;
  mainform.devices[Destination].selected:=mainform.devices[Source].selected;
  mainform.devices[Destination].OldPos:=mainform.devices[Source].OldPos;

  mainform.devices[Destination].hasDimmer:=mainform.devices[Source].hasDimmer;
  mainform.devices[Destination].hasShutter:=mainform.devices[Source].hasShutter;
  mainform.devices[Destination].hasVirtualRGBAWDimmer:=mainform.devices[Source].hasVirtualRGBAWDimmer;
  mainform.devices[Destination].hasRGB:=mainform.devices[Source].hasRGB;
  mainform.devices[Destination].hasCMY:=mainform.devices[Source].hasCMY;
  mainform.devices[Destination].hasAmber:=mainform.devices[Source].hasAmber;
  mainform.devices[Destination].hasWhite:=mainform.devices[Source].hasWhite;
  mainform.devices[Destination].hasUV:=mainform.devices[Source].hasUV;
  mainform.devices[Destination].hasFog:=mainform.devices[Source].hasFog;
  mainform.devices[Destination].UseAmberMixing:=mainform.devices[Source].UseAmberMixing;
  mainform.devices[Destination].AmberMixingCompensateRG:=mainform.devices[Source].AmberMixingCompensateRG;
  mainform.devices[Destination].AmberMixingCompensateBlue:=mainform.devices[Source].AmberMixingCompensateBlue;
  mainform.devices[Destination].AmberRatioR:=mainform.devices[Source].AmberRatioR;
  mainform.devices[Destination].AmberRatioG:=mainform.devices[Source].AmberRatioG;
  mainform.devices[Destination].hasPANTILT:=mainform.devices[Source].hasPANTILT;
  mainform.devices[Destination].hasColor:=mainform.devices[Source].hasColor;
  mainform.devices[Destination].hasColor2:=mainform.devices[Source].hasColor2;
  mainform.devices[Destination].hasGobo:=mainform.devices[Source].hasGobo;
  mainform.devices[Destination].hasGobo2:=mainform.devices[Source].hasGobo2;
  setlength(mainform.devices[Destination].colors,length(mainform.devices[Source].colors));
  setlength(mainform.devices[Destination].colorlevels,length(mainform.devices[Source].colorlevels));
  setlength(mainform.devices[Destination].colorendlevels,length(mainform.devices[Source].colorendlevels));
  setlength(mainform.devices[Destination].colornames,length(mainform.devices[Source].colornames));
  for i:=0 to length(mainform.devices[Source].colors)-1 do
  begin
    mainform.devices[Destination].colors[i]:=mainform.devices[Source].colors[i];
    mainform.devices[Destination].colorlevels[i]:=mainform.devices[Source].colorlevels[i];
    mainform.devices[Destination].colorendlevels[i]:=mainform.devices[Source].colorendlevels[i];
    mainform.devices[Destination].colornames[i]:=mainform.devices[Source].colornames[i];
  end;
  setlength(mainform.devices[Destination].colors2,length(mainform.devices[Source].colors2));
  setlength(mainform.devices[Destination].colorlevels2,length(mainform.devices[Source].colorlevels2));
  setlength(mainform.devices[Destination].colorendlevels2,length(mainform.devices[Source].colorendlevels2));
  setlength(mainform.devices[Destination].colornames2,length(mainform.devices[Source].colornames2));
  for i:=0 to length(mainform.devices[Source].colors2)-1 do
  begin
    mainform.devices[Destination].colors2[i]:=mainform.devices[Source].colors2[i];
    mainform.devices[Destination].colorlevels2[i]:=mainform.devices[Source].colorlevels2[i];
    mainform.devices[Destination].colorendlevels2[i]:=mainform.devices[Source].colorendlevels2[i];
    mainform.devices[Destination].colornames2[i]:=mainform.devices[Source].colornames2[i];
  end;
  mainform.devices[Destination].colortolerance:=mainform.devices[Source].colortolerance;

  setlength(mainform.devices[Destination].gobos,length(mainform.devices[Source].gobos));
  setlength(mainform.devices[Destination].gobolevels,length(mainform.devices[Source].gobolevels));
  setlength(mainform.devices[Destination].goboendlevels,length(mainform.devices[Source].goboendlevels));
  setlength(mainform.devices[Destination].gobonames,length(mainform.devices[Source].gobonames));
  setlength(mainform.devices[Destination].bestgobos,length(mainform.devices[Source].bestgobos));
  for i:=0 to length(mainform.devices[Source].gobos)-1 do
  begin
    mainform.devices[Destination].gobos[i]:=mainform.devices[Source].gobos[i];
    mainform.devices[Destination].gobolevels[i]:=mainform.devices[Source].gobolevels[i];
    mainform.devices[Destination].goboendlevels[i]:=mainform.devices[Source].goboendlevels[i];
    mainform.devices[Destination].gobonames[i]:=mainform.devices[Source].gobonames[i];

    setlength(mainform.devices[Destination].bestgobos[i], length(mainform.devices[Source].bestgobos[i]));
    for j:=0 to length(mainform.devices[Destination].bestgobos[i])-1 do
    begin
      mainform.devices[Destination].bestgobos[i][j].GoboName:=mainform.devices[Source].bestgobos[i][j].GoboName;
      mainform.devices[Destination].bestgobos[i][j].Percent:=mainform.devices[Source].bestgobos[i][j].Percent;
    end;
  end;

  setlength(mainform.devices[Destination].gobos2,length(mainform.devices[Source].gobos2));
  setlength(mainform.devices[Destination].gobolevels2,length(mainform.devices[Source].gobolevels2));
  setlength(mainform.devices[Destination].goboendlevels2,length(mainform.devices[Source].goboendlevels2));
  setlength(mainform.devices[Destination].gobonames2,length(mainform.devices[Source].gobonames2));
  setlength(mainform.devices[Destination].bestgobos2,length(mainform.devices[Source].bestgobos2));
  for i:=0 to length(mainform.devices[Source].gobos2)-1 do
  begin
    mainform.devices[Destination].gobos2[i]:=mainform.devices[Source].gobos2[i];
    mainform.devices[Destination].gobolevels2[i]:=mainform.devices[Source].gobolevels2[i];
    mainform.devices[Destination].goboendlevels2[i]:=mainform.devices[Source].goboendlevels2[i];
    mainform.devices[Destination].gobonames2[i]:=mainform.devices[Source].gobonames2[i];

    setlength(mainform.devices[Destination].bestgobos2[i], length(mainform.devices[Source].bestgobos2[i]));
    for j:=0 to length(mainform.devices[Destination].bestgobos2[i])-1 do
    begin
      mainform.devices[Destination].bestgobos2[i][j].GoboName:=mainform.devices[Source].bestgobos2[i][j].GoboName;
      mainform.devices[Destination].bestgobos2[i][j].Percent:=mainform.devices[Source].bestgobos2[i][j].Percent;
    end;
  end;

  mainform.devices[Destination].UseChannelBasedPower:=mainform.devices[Source].UseChannelBasedPower;
  mainform.devices[Destination].AlwaysOn:=mainform.devices[Source].AlwaysOn;
  mainform.devices[Destination].ChannelForPower:=mainform.devices[Source].ChannelForPower;
  mainform.devices[Destination].ChannelForPower:=mainform.devices[Source].ChannelForPower;
  mainform.devices[Destination].Power:=mainform.devices[Source].Power;
  mainform.devices[Destination].UseFullPowerOnChannelvalue:=mainform.devices[Source].UseFullPowerOnChannelvalue;
  mainform.devices[Destination].ContinuousPower:=mainform.devices[Source].ContinuousPower;
  mainform.devices[Destination].Phase:=mainform.devices[Source].Phase;

  mainform.devices[Destination].MatrixDeviceLevel:=mainform.devices[Source].MatrixDeviceLevel;
  mainform.devices[Destination].MatrixMainDeviceID:=mainform.devices[Source].MatrixMainDeviceID;
  mainform.devices[Destination].MatrixOrderType:=mainform.devices[Source].MatrixOrderType;
  mainform.devices[Destination].MatrixXCount:=mainform.devices[Source].MatrixXCount;
  mainform.devices[Destination].MatrixYCount:=mainform.devices[Source].MatrixYCount;
  mainform.devices[Destination].MatrixXPosition:=mainform.devices[Source].MatrixXPosition;
  mainform.devices[Destination].MatrixYPosition:=mainform.devices[Source].MatrixYPosition;
end;

procedure Tgeraetesteuerung.GrouplistDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
	AOffSet : TPoint;
	AHaken1 : TPoint;
	AHaken2 : TPoint;
	AHaken3 : TPoint;
	ARect : TRect;
begin
  with GroupList.Canvas do
  begin
    if Rect.Top = 0 then
    begin
      Brush.Color := clBtnFace;
      FillRect(Rect);
      Pen.Color := clWhite;
      Rectangle(Rect);
      TextOut(Rect.Left, Rect.Top, GroupList.Cells[ACol, ARow]);
      Exit;
    end;

    if (ACol=GroupList.Col) and (ARow=GroupList.Row) then
    begin
      Brush.Color := clHighlight;
      Font.Color:=clHighlightText;
    end else
    begin
      Brush.Color := clWhite;
      Font.Color:=clWindowText;
    end;
    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, GroupList.Cells[ACol, ARow]);

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
      if (ARow>0) and ((ARow-1)<length(mainform.devicegroups)) then
      if mainform.devicegroups[ARow-1].Active then
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
    TextOut(Rect.Left, Rect.Top, GroupList.Cells[ACol, ARow]);
  end;
end;

procedure Tgeraetesteuerung.GrouplistGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
var
	text:string;
begin
  if ACol>0 then
    text:={GroupList.Cells[ACol,ARow]}value;

  if (ACol=0) then
    GroupList.EditorMode:=false
  else
    GroupList.EditorMode:=true;

  if ACol>0 then
    {GroupList.Cells[ACol,ARow]}value:=text;
end;

procedure Tgeraetesteuerung.PngBitBtn3Click(Sender: TObject);
var
  Data:PTreeData;
  i,j,k,l:integer;
  ChannelForPower, Power, Phase:integer;
  AlwaysOn:boolean;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);
  begin
    l:=GetDevicePositionInDeviceArray(@Data^.ID);
    devicepowerform.aktuellesgeraet:=l;
    devicepowerform.showmodal;
    ChannelForPower:=mainform.devices[l].ChannelForPower;
    Power:=mainform.devices[l].Power;
    Phase:=mainform.devices[l].Phase;
    AlwaysOn:=mainform.devices[l].AlwaysOn;

    // Werte auf alle markierten Geräte kopieren
    for i:=0 to length(VSTDeviceNodes)-1 do
    for j:=0 to length(VSTDeviceNodes[i])-1 do
    for k:=0 to length(VSTDeviceNodes[i][j])-1 do
    begin
      if VST.Selected[VSTDeviceNodes[i][j][k]] then
      begin
        Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);
        l:=GetDevicePositionInDeviceArray(@Data^.ID);
        mainform.devices[l].ChannelForPower:=ChannelForPower;
        mainform.devices[l].Power:=Power;
        mainform.devices[l].Phase:=Phase;
        mainform.devices[l].AlwaysOn:=AlwaysOn;
      end;
    end;
  end;
  VST.Refresh;
end;

procedure Tgeraetesteuerung.FormResize(Sender: TObject);
begin
  if (not mainform.startingup) and DDFWindowDeviceScene.showing then
  begin
    DDFWindowDeviceScene.top:=geraetesteuerung.Top;
    DDFWindowDeviceScene.left:=geraetesteuerung.Left+geraetesteuerung.Width;
  end;
end;

procedure Tgeraetesteuerung.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize:=(NewWidth>=700);
end;

procedure Tgeraetesteuerung.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PTreeData;
begin
  case Kind of ikNormal, ikSelected:
    case Column of
      0:
      begin
        Data:=VST.GetNodeData(Node);

        case Data^.NodeType of
          0: ImageIndex:=3;
          1: ImageIndex:=1;
          2: ImageIndex:=25;
        end;
      end else
      begin
        ImageIndex:=-1;
      end;
    end;
  end;
end;

procedure Tgeraetesteuerung.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PTreeData;
  i:integer;
begin
  case Column of
    0:
    begin
      Data:=VST.GetNodeData(Node);
      CellText:=Data^.Caption;
    end;
    1:
    begin
      // Adresse anzeigen
      Data:=VST.GetNodeData(Node);

      case Data^.NodeType of
        2: // Gerät
        begin
          CellText:='-';
          for i:=0 to length(mainform.devices)-1 do
          if IsEqualGUID(mainform.devices[i].ID, Data^.ID) then
          begin
            CellText:=inttostr(mainform.devices[i].Startaddress);
            break;
          end;
        end;
        else
          CellText:='';
      end;
    end;
    2:
    begin
      // Leistung anzeigen
      Data:=VST.GetNodeData(Node);

      case Data^.NodeType of
        2: // Gerät
        begin
          CellText:='-';
          for i:=0 to length(mainform.devices)-1 do
          if IsEqualGUID(mainform.devices[i].ID, Data^.ID) then
          begin
            CellText:=inttostr(mainform.devices[i].Power)+' W';
            break;
          end;
        end;
        else
          CellText:='';
      end;
    end;
  end;
end;

procedure Tgeraetesteuerung.VSTEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed:=false;
end;

procedure Tgeraetesteuerung.VSTKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,j,k,l:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  if VST.Selected[VSTDeviceNodes[i][j][k]] then
  begin
    Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);

    if Data^.NodeType=2 then
    for l:=0 to length(mainform.devices)-1 do
    begin
      if IsEqualGUID(Data^.ID, mainform.devices[l].ID) then
      begin
        mainform.deviceselected[l]:=VST.Selected[VSTDeviceNodes[i][j][k]];
        break;
      end;
    end;
  end;

  TreeViewCheckbuttons(Shift);
  mainform.DeviceSelectionChanged(vst);
  RefreshDeviceDependencies;

  if VST.SelectedCount>0 then
  begin
    Data:=VST.GetNodeData(VST.FocusedNode);
    if (Data^.NodeType=2) then
    begin
      if showddfbtn.Checked then
      begin
        DDFWindowDeviceScene.top:=geraetesteuerung.Top;
        DDFWindowDeviceScene.left:=geraetesteuerung.Left+geraetesteuerung.Width;
        DDFWindowDeviceScene.loadddf(Data^.ID);
        geraetesteuerung.SetFocus;
      end;
    end else
    begin
      if DDFWindowDeviceScene.Showing then
        DDFWindowDeviceScene.close;
    end;
  end else
  begin
    if DDFWindowDeviceScene.Showing then
      DDFWindowDeviceScene.close;
  end;
end;

function Tgeraetesteuerung.GetImageIndex(Bildadresse: string):integer;
var
  i,position:integer;
begin
  position:=0;
  for i:=0 to mainform.devicepictures32.Items.Count-1 do
  begin
    if (LowerCase(mainform.devicepictures32.Items.Items[i].Name)=LowerCase(ExtractFileName(Bildadresse))) then
    begin
      position:=i;
      break;
    end;
  end;
  result:=position;
end;

procedure Tgeraetesteuerung.VSTMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j,k,l:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  if VST.Selected[VSTDeviceNodes[i][j][k]] then
  begin
    Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);

    if Data^.NodeType=2 then
    for l:=0 to length(mainform.devices)-1 do
    begin
      if IsEqualGUID(Data^.ID, mainform.devices[l].ID) then
      begin
        mainform.deviceselected[l]:=VST.Selected[VSTDeviceNodes[i][j][k]];
        break;
      end;
    end;
  end;

  TreeViewCheckbuttons(Shift);
  mainform.DeviceSelectionChanged(geraetesteuerung);
  RefreshDeviceDependencies;

  if VST.SelectedCount>0 then
  begin
    Data:=VST.GetNodeData(VST.FocusedNode);
    if (Data^.NodeType=2) then
    begin
      if showddfbtn.Checked then
      begin
        DDFWindowDeviceScene.top:=geraetesteuerung.Top;
        DDFWindowDeviceScene.left:=geraetesteuerung.Left+geraetesteuerung.Width;
        DDFWindowDeviceScene.loadddf(Data^.ID);
        geraetesteuerung.SetFocus;
      end;
    end else
    begin
      if DDFWindowDeviceScene.Showing then
        DDFWindowDeviceScene.close;
    end;
  end else
  begin
    if DDFWindowDeviceScene.Showing then
      DDFWindowDeviceScene.close;
  end;
end;

procedure Tgeraetesteuerung.renameBtnClick(Sender: TObject);
var
  Data:PTreeData;
  maindevposition, m:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if mainform.devices[GetDevicePositionInDeviceArray(@Data^.ID)].MatrixDeviceLevel>0 then
  begin
    // Matrixgerät
    maindevposition:=GetDevicePositionInDeviceArray(@mainform.devices[GetDevicePositionInDeviceArray(@Data^.ID)].MatrixMainDeviceID);

    mainform.devices[maindevposition].Name:='[M] '+InputBox(_('Gerätename'),_('Bitte geben Sie einen neuen Namen für das Matrix-Gerät an:'),copy(mainform.devices[maindevposition].Name, pos(']', mainform.devices[maindevposition].Name)+2, length(mainform.devices[maindevposition].Name)));

    for m:=0 to length(mainform.Devices)-1 do
    begin
      if (mainform.Devices[m].MatrixDeviceLevel=2) and (IsEqualGUID(mainform.Devices[m].MatrixMainDeviceID, mainform.devices[GetDevicePositionInDeviceArray(@Data^.ID)].MatrixMainDeviceID)) then
      begin
        mainform.Devices[m].Name:='[M '+inttostr(mainform.Devices[m].MatrixXPosition+1)+'x'+inttostr(mainform.Devices[m].MatrixYPosition+1)+'] '+copy(mainform.devices[maindevposition].Name, pos(']', mainform.devices[maindevposition].Name)+2, length(mainform.devices[maindevposition].Name));
      end;
    end;
    RefreshTreeNew;
  end else
  begin
    Data^.Caption:=InputBox(_('Gerätename'),_('Bitte geben Sie einen neuen Namen für das Gerät an:'),Data^.Caption);
    mainform.devices[GetDevicePositionInDeviceArray(@Data^.ID)].Name:=Data^.Caption;
    VST.Refresh;
  end;

  SendNamesBtnClick(nil);
end;

procedure Tgeraetesteuerung.sortbtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  adddevicetogroupform.button2.visible:=false;
  adddevicetogroupform.ListBox1.MultiSelect:=false;
  adddevicetogroupform.geraetegruppenlbl.caption:=_('Geräte sortieren:');

  adddevicetogroupform.showmodal;
  RefreshTreeNew;

  adddevicetogroupform.geraetegruppenlbl.Caption:=_('Geräte auswählen:');
  adddevicetogroupform.listbox1.MultiSelect:=true;
  adddevicetogroupform.button2.visible:=true;
  VST.Refresh;
  SendNamesBtnClick(nil);
end;

function CopyFileEx(const ASource, ADest: string; ARenameCheck: boolean = false): boolean;
var
  sh: TSHFileOpStruct;
begin
  sh.Wnd := Application.Handle;
  sh.wFunc := FO_COPY;

  // String muss mit #0#0 Terminiert werden, um das Listenende zu setzen
  sh.pFrom := PChar(ASource + #0);
  sh.pTo := PChar(ADest + #0);
  sh.fFlags := fof_Silent or fof_MultiDestFiles;
  if ARenameCheck then
    sh.fFlags := sh.fFlags or fof_RenameOnCollision;
  Result:=ShFileOperation(sh)=0;
end;

procedure Tgeraetesteuerung.LoadDDFfiles;
var
  i,j,k:integer;
  SR: TSearchRec;
  dateianzahlinverzeichnis,dateicounter:integer;
  ddfliste:array of string;
begin
  ProgressScreenSmall.show;
  ProgressScreenSmall.Label1.Caption:=_('Suche DDFs...');
  ProgressScreenSmall.Label2.Caption:='';
  ProgressScreenSmall.ProgressBar1.Position:=0;
  ProgressScreenSmall.Refresh;

  fortschrittsbalken.Position:=0;
  fortschrittsbalken.Visible:=true;

  setlength(ddfliste,0);
  setlength(geraetesteuerung.DevicePrototyp,0);

{
  // Alte XML-DDFs verschieben
  if (FindFirst(mainform.pcdimmerdirectory+'\Devices\*.xml',faAnyFile-faDirectory,SR)=0) then
  begin
    repeat
      if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
      begin
        if not DirectoryExists(mainform.pcdimmerdirectory+'\Devices\XMLDDFs') then
          CreateDirectory(PChar(mainform.pcdimmerdirectory+'\Devices\XMLDDFs'), nil);
        CopyFileEx(mainform.pcdimmerdirectory+'\Devices\'+SR.Name, mainform.pcdimmerdirectory+'\Devices\XMLDDFs\'+SR.Name);
        DeleteFile(mainform.pcdimmerdirectory+'\Devices\'+SR.Name);
      end;
    until FindNext(SR)<>0;
    FindClose(SR);
  end;
}
  fortschrittsbalken.Max:=100;

  // DDFs auflisten
  dateianzahlinverzeichnis:=mainform.CountFiles(mainform.pcdimmerdirectory+'Devices\','*.pcddevc');
  dateicounter:=0;
  if (FindFirst(mainform.pcdimmerdirectory+'\Devices\*.pcddevc',faAnyFile-faDirectory,SR)=0) then
  begin
    repeat
      if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
      begin
        setlength(ddfliste,length(ddfliste)+1);
        setlength(geraetesteuerung.DevicePrototyp,length(geraetesteuerung.DevicePrototyp)+1);
        CreateGUID(geraetesteuerung.DevicePrototyp[length(geraetesteuerung.DevicePrototyp)-1].ID);
        ddfliste[length(ddfliste)-1]:=SR.Name;
        geraetesteuerung.DevicePrototyp[length(geraetesteuerung.DevicePrototyp)-1].ddffilename:=SR.Name;
        dateicounter:=dateicounter+1;

        if (round((dateicounter/dateianzahlinverzeichnis)*50) mod 10)=0 then
        begin
          fortschrittsbalken.Position:=round((dateicounter/dateianzahlinverzeichnis)*50);
          ProgressScreenSmall.Label2.Caption:=SR.Name;
          ProgressScreenSmall.ProgressBar1.Position:=round((dateicounter/dateianzahlinverzeichnis)*50);
          ProgressScreenSmall.Refresh;
        end;
      end;
    until FindNext(SR)<>0;
    FindClose(SR);
  end;

  ProgressScreenSmall.Label1.Caption:=_('Verarbeite DDFs...');
  ProgressScreenSmall.Refresh;

  // DDFs laden und auswerten
  dateicounter:=0;
  for i:=0 to length(ddfliste)-1 do
  begin
    dateicounter:=dateicounter+1;
    if (round((dateicounter/dateianzahlinverzeichnis)*50) mod 10)=0 then
    begin
      fortschrittsbalken.Position:=50+round((dateicounter/dateianzahlinverzeichnis)*50);
      ProgressScreenSmall.Label2.Caption:=ddfliste[i];
      ProgressScreenSmall.ProgressBar1.Position:=50+round((dateicounter/dateianzahlinverzeichnis)*50);
      ProgressScreenSmall.Refresh;
    end;

    XML.Xml.LoadFromFile(mainform.pcdimmerdirectory+'Devices\'+ddfliste[i]);
    geraetesteuerung.DevicePrototyp[i].Bildadresse:=XML.XML.Root.Properties.Value('image');

    // nur zur Sicherheit
    geraetesteuerung.DevicePrototyp[i].DimmerOffValue:=0;
    geraetesteuerung.DevicePrototyp[i].DimmerMaxValue:=255;
    geraetesteuerung.DevicePrototyp[i].FogOffValue:=0;
    geraetesteuerung.DevicePrototyp[i].FogMaxValue:=255;

    for j:=0 to XML.Xml.Root.Items.Count-1 do
    begin // <device>
      if XML.XML.Root.Items[j].Name='information' then
      begin // <information>
        if (XML.Xml.Root.Items[j].Properties.Value('id', 'n/a')<>'PC_DIMMER') then
        begin
          ShowMessage(_('Die DDF-Datei "')+ddfliste[i]+_('" ist nicht zu dieser Version von PC_DIMMER kompatibel.')+#13#10+#13#10+_('DMXControl-DDFs können aufgrund konzeptioneller Unterschiede nicht verwendet werden.')+#13#10+_('Wenn Sie sicher sind, dass es sich um eine PC_DIMMER-DDF handelt, kontrollieren Sie, ob im Header der Datei "<information id="PC_DIMMER">" steht.'));
          continue;
        end;

        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          if XML.XML.Root.Items[j].Items[k].Name='name' then
          begin
            geraetesteuerung.DevicePrototyp[i].Name:=XML.XML.Root.Items[j].Items[k].Value;
            geraetesteuerung.DevicePrototyp[i].DeviceName:=XML.XML.Root.Items[j].Items[k].Value;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='vendor' then
            geraetesteuerung.DevicePrototyp[i].vendor:=XML.XML.Root.Items[j].Items[k].Value;
          if XML.XML.Root.Items[j].Items[k].Name='author' then
            geraetesteuerung.DevicePrototyp[i].author:=XML.XML.Root.Items[j].Items[k].Value;
          if XML.XML.Root.Items[j].Items[k].Name='description' then
            geraetesteuerung.DevicePrototyp[i].Beschreibung:=XML.XML.Root.Items[j].Items[k].Value;
        end;
      end;
      if XML.XML.Root.Items[j].Name='channels' then
      begin // <channels>
        geraetesteuerung.DevicePrototyp[i].MaxChan:=XML.XML.Root.Items[j].Items.Count;
        setlength(geraetesteuerung.DevicePrototyp[i].kanalminvalue,geraetesteuerung.DevicePrototyp[i].MaxChan);
        setlength(geraetesteuerung.DevicePrototyp[i].kanalmaxvalue,geraetesteuerung.DevicePrototyp[i].MaxChan);
        setlength(geraetesteuerung.DevicePrototyp[i].kanaltyp,geraetesteuerung.DevicePrototyp[i].MaxChan);
        setlength(geraetesteuerung.DevicePrototyp[i].kanalname,geraetesteuerung.DevicePrototyp[i].MaxChan);
        setlength(geraetesteuerung.DevicePrototyp[i].kanalfade,geraetesteuerung.DevicePrototyp[i].MaxChan);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          geraetesteuerung.DevicePrototyp[i].kanalname[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'));
          geraetesteuerung.DevicePrototyp[i].kanalfade[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('fade'))='yes';
          if (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('PAN')) or
            (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('TILT')) then
              geraetesteuerung.DevicePrototyp[i].hasPANTILT:=true;
          if lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('DIMMER') then
            geraetesteuerung.DevicePrototyp[i].hasDimmer:=true;
          if lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('SHUTTER') then
            geraetesteuerung.DevicePrototyp[i].hasShutter:=true;
          if (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('VIRTUALRGBDIMMER')) or
            (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('VIRTUALRGBADIMMER')) or
            (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('VIRTUALRGBAWDIMMER')) then
          begin
            geraetesteuerung.DevicePrototyp[i].hasDimmer:=true;
            geraetesteuerung.DevicePrototyp[i].hasVirtualRGBAWDimmer:=true;
            geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=lowercase('DIMMER'); // VirtualRGBAWDimmer als normalen DIMMER maskieren
          end;
          if (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('R')) or
            (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('G')) or
            (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('B')) then
              geraetesteuerung.DevicePrototyp[i].hasRGB:=true;
          if (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('C')) or
            (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('M')) or
            (lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('Y')) then
              geraetesteuerung.DevicePrototyp[i].hasCMY:=true;
          if lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('A') then
            geraetesteuerung.DevicePrototyp[i].hasAmber:=true;
          if lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('W') then
            geraetesteuerung.DevicePrototyp[i].hasWhite:=true;
          if lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('UV') then
            geraetesteuerung.DevicePrototyp[i].hasUV:=true;
          if lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('FOG') then
            geraetesteuerung.DevicePrototyp[i].hasFog:=true;
          if lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('COLOR1') then
            geraetesteuerung.DevicePrototyp[i].hasColor:=true;
          if lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('COLOR2') then
            geraetesteuerung.DevicePrototyp[i].hasColor2:=true;
          if lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('GOBO1') then
            geraetesteuerung.DevicePrototyp[i].hasGobo:=true;
          if lowercase(geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))])=lowercase('GOBO2') then
            geraetesteuerung.DevicePrototyp[i].hasGobo2:=true;
          geraetesteuerung.DevicePrototyp[i].KanalMinValue[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('minvalue'));
          geraetesteuerung.DevicePrototyp[i].KanalMaxValue[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('maxvalue'));
        end;
      end;
      if XML.XML.Root.Items[j].Name='amber' then
      begin // <amber>
        geraetesteuerung.DevicePrototyp[i].UseAmberMixing:=(lowercase(XML.XML.Root.Items[j].Properties.Value('UseAmberMixing'))='yes');
        geraetesteuerung.DevicePrototyp[i].AmberMixingCompensateRG:=(lowercase(XML.XML.Root.Properties.Value('AmberMixingCompensateRG'))='yes');
        geraetesteuerung.DevicePrototyp[i].AmberMixingCompensateBlue:=(lowercase(XML.XML.Root.Properties.Value('AmberMixingCompensateBlue'))='yes');
        geraetesteuerung.DevicePrototyp[i].AmberRatioR:=XML.XML.Root.Items[j].Properties.IntValue('AmberColorR');
        geraetesteuerung.DevicePrototyp[i].AmberRatioG:=XML.XML.Root.Items[j].Properties.IntValue('AmberColorG');
      end;
      if XML.XML.Root.Items[j].Name='colors' then
      begin // <colors>
        setlength(geraetesteuerung.DevicePrototyp[i].colors,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colorlevels,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colorendlevels,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colornames,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          geraetesteuerung.DevicePrototyp[i].colors[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('r')) + strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('g')) shl 8 + strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('b')) shl 16;
          geraetesteuerung.DevicePrototyp[i].colornames[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          geraetesteuerung.DevicePrototyp[i].colorlevels[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          geraetesteuerung.DevicePrototyp[i].colorendlevels[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(geraetesteuerung.DevicePrototyp[i].colorlevels[k])));
        end;
      end;
      if XML.XML.Root.Items[j].Name='colors2' then
      begin // <colors2>
        setlength(geraetesteuerung.DevicePrototyp[i].colors2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colorlevels2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colorendlevels2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colornames2,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          geraetesteuerung.DevicePrototyp[i].colors2[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('r')) + strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('g')) shl 8 + strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('b')) shl 16;
          geraetesteuerung.DevicePrototyp[i].colornames2[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          geraetesteuerung.DevicePrototyp[i].colorlevels2[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          geraetesteuerung.DevicePrototyp[i].colorendlevels2[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(geraetesteuerung.DevicePrototyp[i].colorlevels2[k])));
        end;
      end;
      if XML.XML.Root.Items[j].Name='shutter' then
      begin // <shutter>
        geraetesteuerung.DevicePrototyp[i].ShutterOpenValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OpenValue'));
        geraetesteuerung.DevicePrototyp[i].ShutterCloseValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('CloseValue'));
        geraetesteuerung.DevicePrototyp[i].ShutterChannel:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;
      if XML.XML.Root.Items[j].Name='strobe' then
      begin // <strobe>
        geraetesteuerung.DevicePrototyp[i].StrobeOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].StrobeMinValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MinValue'));
        geraetesteuerung.DevicePrototyp[i].StrobeMaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MaxValue'));
        geraetesteuerung.DevicePrototyp[i].StrobeChannel:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;
      if (XML.XML.Root.Items[j].Name='dimmer') or (XML.XML.Root.Items[j].Name='virtualrgbdimmer') or (XML.XML.Root.Items[j].Name='virtualrgbadimmer') or (XML.XML.Root.Items[j].Name='virtualrgbawdimmer') then
      begin // <dimmer>
        geraetesteuerung.DevicePrototyp[i].DimmerOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].DimmerMaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MaxValue'));
      end;
      if (XML.XML.Root.Items[j].Name='fog') then
      begin // <fog>
        geraetesteuerung.DevicePrototyp[i].FogOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].FogMaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MaxValue'));
      end;
      if XML.XML.Root.Items[j].Name='gobo1rot' then
      begin // <gobo1rot>
        geraetesteuerung.DevicePrototyp[i].Gobo1RotLeftminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMinValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo1RotLeftValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMaxValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo1RotOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo1RotRightminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMinValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo1RotRightValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMaxValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo1RotChannel:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;
      if XML.XML.Root.Items[j].Name='gobo2rot' then
      begin // <gobo2rot>
        geraetesteuerung.DevicePrototyp[i].Gobo2RotLeftminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMinValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo2RotLeftValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMaxValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo2RotOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo2RotRightminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMinValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo2RotRightValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMaxValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo2RotChannel:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;
      if XML.XML.Root.Items[j].Name='prismarot' then
      begin // <PrismaRotation>
        geraetesteuerung.DevicePrototyp[i].PrismaRotLeftminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMinValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaRotLeftmaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMaxValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaRotOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaRotRightminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMinValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaRotRightmaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMaxValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaRotChannel:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;
      if XML.XML.Root.Items[j].Name='prisma' then
      begin // <Prisma>
        geraetesteuerung.DevicePrototyp[i].PrismaSingleValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('SingleValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaTripleValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('TripleValue'));
      end;
      if XML.XML.Root.Items[j].Name='iris' then
      begin // <Iris>
        geraetesteuerung.DevicePrototyp[i].IrisCloseValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('CloseValue'));
        geraetesteuerung.DevicePrototyp[i].IrisOpenValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OpenValue'));
        geraetesteuerung.DevicePrototyp[i].IrisMinValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MinValue'));
        geraetesteuerung.DevicePrototyp[i].IrisMaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MaxValue'));
      end;
      if XML.XML.Root.Items[j].Name='gobos' then
      begin // <gobos>
        setlength(geraetesteuerung.DevicePrototyp[i].gobos,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].gobolevels,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].goboendlevels,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].gobonames,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          geraetesteuerung.DevicePrototyp[i].gobos[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('filename');
          geraetesteuerung.DevicePrototyp[i].gobonames[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          geraetesteuerung.DevicePrototyp[i].gobolevels[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          geraetesteuerung.DevicePrototyp[i].goboendlevels[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(geraetesteuerung.DevicePrototyp[i].gobolevels[k])));
        end;
      end;
      if XML.XML.Root.Items[j].Name='gobos2' then
      begin // <gobos2>
        setlength(geraetesteuerung.DevicePrototyp[i].gobos2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].gobolevels2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].goboendlevels2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].gobonames2,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          geraetesteuerung.DevicePrototyp[i].gobos2[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('filename');
          geraetesteuerung.DevicePrototyp[i].gobonames2[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          geraetesteuerung.DevicePrototyp[i].gobolevels2[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          geraetesteuerung.DevicePrototyp[i].goboendlevels2[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(geraetesteuerung.DevicePrototyp[i].gobolevels2[k])));
        end;
      end;
      if XML.XML.Root.Items[j].Name='matrix' then
      begin // <Matrix>
        geraetesteuerung.DevicePrototyp[i].IsMatrixDevice:=true;
        geraetesteuerung.DevicePrototyp[i].MatrixXCount:=XML.XML.Root.Items[j].Properties.IntValue('xcount');
        geraetesteuerung.DevicePrototyp[i].MatrixYCount:=XML.XML.Root.Items[j].Properties.IntValue('ycount');
        geraetesteuerung.DevicePrototyp[i].MatrixOrdertype:=XML.XML.Root.Items[j].Properties.IntValue('ordertype');
      end;
    end;
  end;

  ProgressScreenSmall.Label1.Caption:=_('Fertig.');
  ProgressScreenSmall.Label2.Caption:='';
  ProgressScreenSmall.ProgressBar1.Position:=100;
  ProgressScreenSmall.Refresh;
  ProgressScreenSmall.Timer1.Enabled:=true;
  fortschrittsbalken.Visible:=false;
end;


procedure Tgeraetesteuerung.TBItem1Click(Sender: TObject);
begin
  LoadDDFFiles;
end;

procedure Tgeraetesteuerung.TBItem2Click(Sender: TObject);
begin
  mainform.LoadDDFPictures;
end;

procedure Tgeraetesteuerung.AddGobo(filename: string);
var
  i:integer;
  GoboAlreadyExists:boolean;
begin
  GoboAlreadyExists:=false;

  for i:=0 to mainform.GoboPictures.Items.Count-1 do
  begin
    if mainform.GoboPictures.Items.Items[i].Name=filename then
    begin
      GoboAlreadyExists:=true;
      break;
    end;
  end;

  if (not GoboAlreadyExists) then
  begin
    if FileExists(mainform.pcdimmerdirectory+'\Devicepictures\Gobos\'+filename) then
    begin
      mainform.GoboPictures.Items.Add(false);
      mainform.GoboPictures.Items.Items[mainform.GoboPictures.Items.Count-1].PngImage.LoadFromFile(mainform.pcdimmerdirectory+'\Devicepictures\Gobos\'+filename);
      mainform.GoboPictures.Items.Items[mainform.GoboPictures.Items.Count-1].Name:=filename;
    end else
    begin
      mainform.GoboPictures.Items.Add(false);
      mainform.GoboPictures.Items.Items[mainform.GoboPictures.Items.Count-1].PngImage.LoadFromFile(mainform.pcdimmerdirectory+'\Devicepictures\Gobos\1.png');
      mainform.GoboPictures.Items.Items[mainform.GoboPictures.Items.Count-1].Name:='1.png';
    end;
  end;
end;

procedure Tgeraetesteuerung.TBItem3Click(Sender: TObject);
begin
  sidebarform.RefreshGoboCorrelation;
end;

procedure Tgeraetesteuerung.TBItem4Click(Sender: TObject);
var
  Data:PTreeData;
  OldID, NewID:TGUID;
begin
  if VST.SelectedCount=0 then exit;

  if messagedlg(_('Mit dieser Funktionen kann die ID des selektierten Gerätes geändert werden. Falsche Einstellungen können sämtliche Szenenverknüpfungen zu diesem Gerät zerstören. Fortfahren?'),mtWarning,
  [mbYes,mbNo],0)=mrYes then
  begin
    Data:=VST.GetNodeData(VST.FocusedNode);
    OldID:=Data^.ID;
    NewID:=StringToGUID(InputBox(_('Geräte-ID'),_('Die ID des aktuellen Gerätes lautet wie folgt:'),GUIDtoString(OldID)));

    mainform.devices[GetDevicePositionInDeviceArray(@OldID)].ID:=NewID;

    VST.Refresh;
    RefreshDeviceControl;
  end;
end;

procedure Tgeraetesteuerung.VSTMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    // Geräteselektion löschen
    mainform.DeSelectAllDevices;
    VST.ClearSelection;
  end;
end;

procedure Tgeraetesteuerung.set_color(DeviceID: TGUID; R, G, B:byte; Fadetime, Delay:Integer; Mode:Byte=7);
begin
  set_color(DeviceID, R, G, B, -1, -1, Fadetime, Delay, Mode);
end;

procedure Tgeraetesteuerung.set_color(DeviceID: TGUID; R, G, B:byte; A,W:integer; Fadetime, Delay:Integer; Mode:Byte=7);
var
  k, kanalwert,Rdiff,Gdiff,Bdiff,temp,temp2,bestcolor,bestcolor2:integer;
  Rdev,Gdev,Bdev,ra,ga,ba,aa:byte;
  colorchannelvalues:array of integer;
  colorchannelvalues2:array of integer;
  DevPosition:integer;

  i,j:integer;
  temp_startvalue,delayfaktor:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, 0, Mode);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, delay*delayfaktor, Mode);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, delay*delayfaktor, Mode);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, delay*delayfaktor, Mode);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))), Mode);
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, round(delay*abs(tan(grouptemp))), Mode);
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, round(delay*abs(tan(grouptemp))), Mode);
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))), Mode);
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, 0, Mode);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, delay, Mode);
                  end;
                  2: // nach Links
                  begin
                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, delay*j, Mode);
                  end;
                  3: // nach Rechts
                  begin
                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, delay*(length(mainform.DeviceGroups[i].IDs)-j), Mode);
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))), Mode);
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, round(delay*abs(tan(grouptemp))), Mode);
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, round(delay*abs(tan(grouptemp))), Mode);
                  end;
                  7: // Halbkreis
                  begin
                    set_color(mainform.DeviceGroups[i].IDs[j], R, G, B, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))), Mode);
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;

    exit; // z.B. wenn Gruppen-ID
  end;

  if (mainform.devices[DevPosition].hasRGB or mainform.devices[DevPosition].hasCMY) and (Mode AND 1 = 1) then
  begin
    if mainform.UseAutoAmberCalculation and mainform.devices[DevPosition].UseAmberMixing and mainform.devices[DevPosition].hasAmber then
    begin
      ConvertRGBtoRGBA(r, g, b, mainform.devices[DevPosition].AmberRatioR, mainform.devices[DevPosition].AmberRatioG, mainform.devices[DevPosition].AmbermixingCompensateRG, mainform.devices[DevPosition].AmbermixingCompensateBlue, ra, ga, ba, aa);

      set_channel(DeviceID, 'R', -1, ra, Fadetime, Delay);
      set_channel(DeviceID, 'G', -1, ga, Fadetime, Delay);
      set_channel(DeviceID, 'B', -1, ba, Fadetime, Delay);
      set_channel(DeviceID, 'A', -1, aa, Fadetime, Delay);

      set_channel(DeviceID, 'C', -1, 255-ra, Fadetime, Delay);
      set_channel(DeviceID, 'M', -1, 255-ga, Fadetime, Delay);
      set_channel(DeviceID, 'Y', -1, 255-ba, Fadetime, Delay);
    end else
    begin
      set_channel(DeviceID, 'R', -1, R, Fadetime, Delay);
      set_channel(DeviceID, 'G', -1, G, Fadetime, Delay);
      set_channel(DeviceID, 'B', -1, B, Fadetime, Delay);
      if A>-1 then
        set_channel(DeviceID, 'A', -1, A, Fadetime, Delay);
      if W>-1 then
        set_channel(DeviceID, 'W', -1, W, Fadetime, Delay);

      set_channel(DeviceID, 'C', -1, 255-R, Fadetime, Delay);
      set_channel(DeviceID, 'M', -1, 255-G, Fadetime, Delay);
      set_channel(DeviceID, 'Y', -1, 255-B, Fadetime, Delay);
    end;
  end else if mainform.devices[DevPosition].hasColor and (length(mainform.devices[DevPosition].colors)>0) and (Mode AND 2 = 2) then
  begin
    setlength(colorchannelvalues,length(mainform.devices[DevPosition].colors));
    setlength(colorchannelvalues2,length(mainform.devices[DevPosition].colors2));

    // für jede eingestellte Gerätefarbe Wertigkeit berechnen
    for k:=0 to length(mainform.devices[DevPosition].colors)-1 do
    begin
      TColor2RGB(mainform.devices[DevPosition].colors[k],Rdev,Gdev,Bdev);

      Rdiff:=round((255-abs(R-Rdev))/2.55); // Differenz als Bytewert
      Gdiff:=round((255-abs(G-Gdev))/2.55); // Differenz als Bytewert
      Bdiff:=round((255-abs(B-Bdev))/2.55); // Differenz als Bytewert
      kanalwert:=round(((Rdiff/255)*(Gdiff/255)*(Bdiff/255))*255); // Gesamtabweichung als Bytewert

      // Kanalwert als "Rating" zwischen 0 und 255 in Array speichern
      colorchannelvalues[k]:=kanalwert;
    end;

    // für jede eingestellte Gerätefarbe Wertigkeit berechnen
    for k:=0 to length(mainform.devices[DevPosition].colors2)-1 do
    begin
      TColor2RGB(mainform.devices[DevPosition].colors2[k],Rdev,Gdev,Bdev);

      // Farbabweichung von Kanalwert abziehen
      Rdiff:=round((255-abs(R-Rdev))/2.55); // Differenz als Bytewert
      Gdiff:=round((255-abs(G-Gdev))/2.55); // Differenz als Bytewert
      Bdiff:=round((255-abs(B-Bdev))/2.55); // Differenz als Bytewert
      kanalwert:=round(((Rdiff/255)*(Gdiff/255)*(Bdiff/255))*255); // Gesamtabweichung als Bytewert

      // Kanalwert als "Rating" zwischen 0 und 255 in Array speichern
      colorchannelvalues2[k]:=kanalwert;
    end;

    // Den Farbkanal mit dem höchsten "Rating" herausfinden
    bestcolor:=-1;
    temp:=0;
    for k:=0 to length(colorchannelvalues)-1 do
    begin
      if colorchannelvalues[k]>temp then
      begin
        temp:=colorchannelvalues[k]; // derzeit höchsten Wert speichern
        bestcolor:=k; // beste Farbe speichern
      end;
    end;
    bestcolor2:=-1;
    temp2:=0;
    for k:=0 to length(colorchannelvalues2)-1 do
    begin
      if colorchannelvalues2[k]>temp2 then
      begin
        temp2:=colorchannelvalues2[k]; // derzeit höchsten Wert speichern
        bestcolor2:=k; // beste Farbe speichern
      end;
    end;

    if temp2>temp then
    begin
      // Farbe mit der höchsten Wertigkeit nutzen, wenn Farbe zu x% passt
      begin
        geraetesteuerung.set_channel(mainform.devices[DevPosition].ID, 'COLOR1', -1, 0, Fadetime, Delay); // Color1 auf Weiß
        geraetesteuerung.set_channel(mainform.devices[DevPosition].ID, 'COLOR2', -1, mainform.devices[DevPosition].colorlevels2[bestcolor2], Fadetime, Delay);
      end;
    end else
    begin
      // Farbe mit der höchsten Wertigkeit nutzen, wenn Farbe zu x% passt
      begin
        geraetesteuerung.set_channel(mainform.devices[DevPosition].ID, 'COLOR1', -1, mainform.devices[DevPosition].colorlevels[bestcolor], Fadetime, Delay);
        geraetesteuerung.set_channel(mainform.devices[DevPosition].ID, 'COLOR2', -1, 0, Fadetime, Delay); // Color2 auf Weiß
      end;
    end;
  end else if mainform.devices[DevPosition].hasDimmer and (Mode AND 4 = 4) then
  begin
    TColor2RGB(mainform.devices[DevPosition].color,Rdev,Gdev,Bdev);

    // Farbabweichung von Kanalwert abziehen
    Rdiff:=abs(R-Rdev);
    Gdiff:=abs(G-Gdev);
    Bdiff:=abs(B-Bdev);
    kanalwert:=(255-round(((Rdiff+Gdiff+Bdiff) / 3) * 2));
    if kanalwert<0 then kanalwert:=0;

    geraetesteuerung.set_channel(DeviceID,'DIMMER', -1, kanalwert, Fadetime, Delay);
  end;
end;

procedure Tgeraetesteuerung.ConvertRGBtoRGBA(Rin, Gin, Bin: byte; AmberColorR, AmberColorG:byte; CompRG, CompBlue: boolean; var Rout, Gout, Bout, Aout: byte);
var
  rs,gs,bs,ys,yraw,ybrightness:double;
  AmberRGratio:double;
begin
  // Normalize all Color-Channels to 1
  rs:=rin/255;
  gs:=Gin/255;
  bs:=bin/255;
		
  AmberRGratio:=AmberColorG/AmberColorR;

  // Calculate the raw Yellow-Channel (without brightness-information)
  if rin>(gin/AmberRGratio) then
  begin
    yraw:=(gs/AmberRGratio)/rs;
  end else
  begin
    yraw:=rs/(gs/AmberRGratio);
  end;
  // Reduce Yellow, if there is some Blue-channel
  if CompBlue then
  begin
    yraw:=yraw*(1-bs);
  end;
  // Calculate the brightness of Yellow-Channel
  ybrightness:=(rs+(gs/AmberRGratio))/2;	
  // Calculate the endvalue for the Yellow-Channel
  ys:=yraw*ybrightness;
		
  // Reduce Red and Green, if there is some Yellow
  if CompRG then
  begin
    rs:=rs-(rs*yraw);
    gs:=gs-(gs*yraw);
  end;

  rout:=round(rs*255);
  gout:=round(gs*255);
  bout:=round(bs*255);
  aout:=round(ys*255);
end;

procedure Tgeraetesteuerung.ConvertRGBAWUVtoRGB(Rin, Gin, Bin, Ain: byte; AmberColorR, AmberColorG:byte; CompRG, CompBlue: boolean; Win, UVin:byte; var Rout, Gout, Bout: byte);
var
  AmberRs,AmberGs:double;
  AmberRGratio:double;
  
  Rint, Gint, Bint:integer;
  Rbyte, Gbyte, Bbyte:byte;
begin
  AmberRGratio:=AmberColorG/AmberColorR;

{
  // Mathematisch korrekte Umwandlung (führt aber zu Verwirrungen bei manueller Anpassung von R, G und A und ist ggfs. nicht zum realen Ergebnis vergleichbar
  if CompRG then
  begin
    if CompBlue then
    begin
      AmberRs:=0;
      AmberGs:=0;
      if ((Rin=0) and (Gin=0)) then
      begin
      end else if Rin>(Gin/AmberRGratio) then
      begin
        AmberGs:=(Gin/255)/(1-(((Gin/255)/AmberRGratio)/(Rin/255))*(1-(Bin/255)));
        AmberRs:=(Rin/255)+(AmberGs/AmberRGratio)*(1-(Bin/255));
      end else
      begin
        AmberRs:=(Rin/255)/(1-((Rin/255)/((Gin/255)/AmberRGratio))*(1-(Bin/255)));
        AmberGs:=(Gin/255)+AmberRs*AmberRGratio*(1-(Bin/255));
      end;

      AmberRs:=AmberRs+(1-AmberRs)*(Ain/255);
      if AmberRs>1 then AmberRs:=1;
      AmberGs:=AmberGs+(1-AmberGs)*(Ain/255)*AmberRGratio;
      if AmberGs>1 then AmberGs:=1;

      Rout:=round(AmberRs*255);
      Gout:=round(AmberGs*255);
      Bout:=Bin;
    end else
    begin
      AmberRs:=0;
      AmberGs:=0;

      if ((Rin=0) and (Gin=0)) then
      begin
      end else if Rin>(Gin/AmberRGratio) then
      begin
        AmberRs:=Power((Rin/255),2)/((Rin/255)-((Gin/255)/AmberRGratio));
        AmberGs:=Power((Rin/255),2)/((Rin/255)-((Gin/255)/AmberRGratio))-(Rin/255);
      end else
      begin
        AmberRs:=Power(((Gin/255)/AmberRGratio),2)/(((Gin/255)/AmberRGratio)-(Rin/255))-(Gin/255)/AmberRGratio;
        AmberGs:=(Power(((Gin/255)/AmberRGratio),2)/(((Gin/255)/AmberRGratio)-(Rin/255)))*AmberRGratio;
      end;

      AmberRs:=AmberRs+(1-AmberRs)*(Ain/255);
      if AmberRs>1 then AmberRs:=1;
      AmberGs:=AmberGs+(1-AmberGs)*(Ain/255)*AmberRGratio;
      if AmberGs>1 then AmberGs:=1;

      Rout:=round(AmberRs*255);
      Gout:=round(AmberGs*255);
      Bout:=Bin;
    end;
  end else
  begin
    // keine RG-Kompensation
    AmberRs:=Rin/255;
    AmberGs:=Gin/255;

    AmberRs:=AmberRs+(1-AmberRs)*(Ain/255);
    if AmberRs>1 then AmberRs:=1;
    AmberGs:=AmberGs+(1-AmberGs)*(Ain/255)*AmberRGratio;
    if AmberGs>1 then AmberGs:=1;

    Rout:=round(AmberRs*255);
    Gout:=round(AmberGs*255);
    Bout:=Bin;
  end;
}

  // Additive Umwandlung (kommt dem echten Ergebnis am Nächsten)
  AmberRs:=Rin/255;
  AmberGs:=Gin/255;

  AmberRs:=AmberRs+(1-AmberRs)*(Ain/255);
  if AmberRs>1 then AmberRs:=1;
  AmberGs:=AmberGs+(1-AmberGs)*(Ain/255)*AmberRGratio;
  if AmberGs>1 then AmberGs:=1;

  Rint:=round(AmberRs*255)+Win+(UVin div 2);
  Gint:=round(AmberGs*255)+Win;
  Bint:=Bin+Win+(UVin div 2);
  
  if Rint>255 then Rint:=255;
  if Gint>255 then Gint:=255;
  if Bint>255 then Bint:=255;
  
  Rbyte:=Rint;
  Gbyte:=Gint;
  Bbyte:=Bint;

  Rout:=Rbyte;
  Gout:=Gbyte;
  Bout:=Bbyte;
end;

procedure Tgeraetesteuerung.set_shutter(DeviceID: TGUID; OpenOrClose:byte; Delaytime:integer=0);
var
  DevPosition:integer;

  i,j:integer;
  delayfaktor, delay:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, delay);
                  end;
                  2: // nach Links
                  begin
                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_shutter(mainform.DeviceGroups[i].IDs[j], OpenOrClose, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;

//  if not ((uppercase(mainform.devices[DevPosition].ShutterChannel)='DIMMER') and mainform.devices[DevPosition].hasDimmer) then
  if OpenOrClose=255 then
    set_channel(DeviceID, mainform.devices[DevPosition].ShutterChannel, -1, mainform.devices[DevPosition].ShutterOpenValue, 0, Delaytime)
  else
    set_channel(DeviceID, mainform.devices[DevPosition].ShutterChannel, -1, mainform.devices[DevPosition].ShutterCloseValue, 0, Delaytime)
end;

procedure Tgeraetesteuerung.set_prisma(DeviceID: TGUID; SingleOrTriple:byte; Delaytime:integer=0);
var
  DevPosition:integer;

  i,j:integer;
  delayfaktor, delay:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, delay);
                  end;
                  2: // nach Links
                  begin
                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_prisma(mainform.DeviceGroups[i].IDs[j], SingleOrTriple, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;

  if SingleOrTriple=255 then
    set_channel(DeviceID, 'PRISMA', -1, mainform.devices[DevPosition].PrismaTripleValue, 0, Delaytime)
  else
    set_channel(DeviceID, 'PRISMA', -1, mainform.devices[DevPosition].PrismaSingleValue, 0, Delaytime)
end;

procedure Tgeraetesteuerung.set_prismarot(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
var
  DevPosition, prismarotvalue:integer;

  i,j:integer;
  delayfaktor,delay:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay);
                  end;
                  2: // nach Links
                  begin
                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_prismarot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;

  Case Value of
    0: set_channel(DeviceID, mainform.devices[DevPosition].PrismaRotChannel, -1, mainform.devices[DevPosition].PrismaRotLeftmaxValue, Fadetime, Delaytime);
    1..126: // Linkslauf
    begin
      prismarotvalue:=mainform.devices[DevPosition].PrismaRotLeftMaxValue-mainform.devices[DevPosition].PrismaRotLeftminValue;
      prismarotvalue:=round(prismarotvalue*((126-value)/126));
      prismarotvalue:=prismarotvalue+mainform.devices[DevPosition].PrismaRotLeftminValue;
      set_channel(DeviceID, mainform.devices[DevPosition].PrismaRotChannel, -1, prismarotvalue, Fadetime, Delaytime);
    end;
    127: set_channel(DeviceID, mainform.devices[DevPosition].PrismaRotChannel, -1, mainform.devices[DevPosition].PrismaRotOffValue, Fadetime, Delaytime);
    128..254: // Rechtslauf
    begin
      prismarotvalue:=mainform.devices[DevPosition].PrismaRotRightMaxValue-mainform.devices[DevPosition].PrismaRotRightminValue;
      prismarotvalue:=round(prismarotvalue*((value-128)/126));
      prismarotvalue:=prismarotvalue+mainform.devices[DevPosition].PrismaRotRightminValue;
      set_channel(DeviceID, mainform.devices[DevPosition].PrismaRotChannel, -1, prismarotvalue, Fadetime, Delaytime);
    end;
    255: set_channel(DeviceID, mainform.devices[DevPosition].PrismaRotChannel, -1, mainform.devices[DevPosition].PrismaRotRightMaxValue, Fadetime, Delaytime);
  end;
end;

procedure Tgeraetesteuerung.set_strobe(DeviceID: TGUID; Speed:integer; Fadetime:integer=0; Delaytime:integer=0);
var
  DevPosition, value:integer;

  i,j:integer;
  delayfaktor,delay:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, delay);
                  end;
                  2: // nach Links
                  begin
                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_strobe(mainform.DeviceGroups[i].IDs[j], Speed, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;

  Case Speed of
    0: set_channel(DeviceID, mainform.devices[DevPosition].StrobeChannel, -1, mainform.devices[DevPosition].StrobeOffValue, Fadetime, Delaytime);
    1..254:
    begin
      value:=mainform.devices[DevPosition].StrobeMaxValue-mainform.devices[DevPosition].StrobeMinValue;
      value:=round(value*(Speed/255));
      value:=value+mainform.devices[DevPosition].StrobeMinValue;
      set_channel(DeviceID, mainform.devices[DevPosition].StrobeChannel, -1, value, Fadetime, Delaytime);
    end;
    255: set_channel(DeviceID, mainform.devices[DevPosition].StrobeChannel, -1, mainform.devices[DevPosition].StrobeMaxValue, Fadetime, Delaytime);
  end;
end;

procedure Tgeraetesteuerung.set_dimmer(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
var
  DevPosition, dimmervalue:integer;

  i,j:integer;
  delayfaktor,delay:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay);
                  end;
                  2: // nach Links
                  begin
                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_dimmer(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;

  Case Value of
    0: set_channel(DeviceID, 'DIMMER', -1, mainform.devices[DevPosition].DimmerOffValue, Fadetime, Delaytime);
    1..254:
    begin
      dimmervalue:=mainform.devices[DevPosition].DimmerMaxValue-mainform.devices[DevPosition].DimmerOffValue;
      dimmervalue:=round(dimmervalue*(value/255));
      dimmervalue:=dimmervalue+mainform.devices[DevPosition].DimmerOffValue;
      set_channel(DeviceID, 'DIMMER', -1, dimmervalue, Fadetime, Delaytime);
    end;
    255: set_channel(DeviceID, 'DIMMER', -1, mainform.devices[DevPosition].DimmerMaxValue, Fadetime, Delaytime);
  end;
end;

procedure Tgeraetesteuerung.set_fog(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
var
  DevPosition, fogvalue:integer;

  i,j:integer;
  delayfaktor,delay:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay);
                  end;
                  2: // nach Links
                  begin
                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_fog(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;

  Case Value of
    0: set_channel(DeviceID, 'FOG', -1, mainform.devices[DevPosition].FogOffValue, Fadetime, Delaytime);
    1..254:
    begin
      fogvalue:=mainform.devices[DevPosition].FogMaxValue-mainform.devices[DevPosition].FogOffValue;
      fogvalue:=round(fogvalue*(value/255));
      fogvalue:=fogvalue+mainform.devices[DevPosition].FogOffValue;
      set_channel(DeviceID, 'FOG', -1, fogvalue, Fadetime, Delaytime);
    end;
    255: set_channel(DeviceID, 'FOG', -1, mainform.devices[DevPosition].FogMaxValue, Fadetime, Delaytime);
  end;
end;

procedure Tgeraetesteuerung.set_iris(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
var
  DevPosition, irisvalue:integer;

  i,j:integer;
  delayfaktor,delay:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay);
                  end;
                  2: // nach Links
                  begin
                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_iris(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;

  Case Value of
    0: set_channel(DeviceID, 'IRIS', -1, mainform.devices[DevPosition].IrisCloseValue, Fadetime, Delaytime);
    1..254:
    begin
      irisvalue:=mainform.devices[DevPosition].IrisMaxValue-mainform.devices[DevPosition].IrisMinValue;
      irisvalue:=round(irisvalue*(value/255));
      irisvalue:=irisvalue+mainform.devices[DevPosition].IrisMinValue;
      set_channel(DeviceID, 'IRIS', -1, irisvalue, Fadetime, Delaytime);
    end;
    255: set_channel(DeviceID, 'IRIS', -1, mainform.devices[DevPosition].IrisOpenValue, Fadetime, Delaytime);
  end;
end;

procedure Tgeraetesteuerung.set_gobo1rot(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
var
  DevPosition, goborotvalue:integer;

  i,j:integer;
  delayfaktor,delay:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay);
                  end;
                  2: // nach Links
                  begin
                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_gobo1rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;

  Case Value of
    0: set_channel(DeviceID, mainform.devices[DevPosition].Gobo1RotChannel, -1, mainform.devices[DevPosition].Gobo1RotLeftValue, Fadetime, Delaytime);
    1..126: // Linkslauf
    begin
      goborotvalue:=mainform.devices[DevPosition].Gobo1RotLeftValue-mainform.devices[DevPosition].Gobo1RotLeftminValue;
      goborotvalue:=round(goborotvalue*((126-value)/126));
      goborotvalue:=goborotvalue+mainform.devices[DevPosition].Gobo1RotLeftminValue;
      set_channel(DeviceID, mainform.devices[DevPosition].Gobo1RotChannel, -1, goborotvalue, Fadetime, Delaytime);
    end;
    127: set_channel(DeviceID, mainform.devices[DevPosition].Gobo1RotChannel, -1, mainform.devices[DevPosition].Gobo1RotOffValue, Fadetime, Delaytime);
    128..254: // Rechtslauf
    begin
      goborotvalue:=mainform.devices[DevPosition].Gobo1RotRightValue-mainform.devices[DevPosition].Gobo1RotRightminValue;
      goborotvalue:=round(goborotvalue*((value-128)/126));
      goborotvalue:=goborotvalue+mainform.devices[DevPosition].Gobo1RotRightminValue;
      set_channel(DeviceID, mainform.devices[DevPosition].Gobo1RotChannel, -1, goborotvalue, Fadetime, Delaytime);
    end;
    255: set_channel(DeviceID, mainform.devices[DevPosition].Gobo1RotChannel, -1, mainform.devices[DevPosition].Gobo1RotRightValue, Fadetime, Delaytime);
  end;
end;

procedure Tgeraetesteuerung.set_gobo2rot(DeviceID: TGUID; Value:integer; Fadetime:integer=0; Delaytime:integer=0);
var
  DevPosition, goborotvalue:integer;

  i,j:integer;
  delayfaktor,delay:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay);
                  end;
                  2: // nach Links
                  begin
                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_gobo2rot(mainform.DeviceGroups[i].IDs[j], Value, Fadetime, round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;

  Case Value of
    0: set_channel(DeviceID, mainform.devices[DevPosition].gobo2RotChannel, -1, mainform.devices[DevPosition].gobo2RotLeftValue, Fadetime, Delaytime);
    1..126: // Linkslauf
    begin
      goborotvalue:=mainform.devices[DevPosition].gobo2RotLeftValue-mainform.devices[DevPosition].gobo2RotLeftminValue;
      goborotvalue:=round(goborotvalue*((126-value)/126));
      goborotvalue:=goborotvalue+mainform.devices[DevPosition].gobo2RotLeftminValue;
      set_channel(DeviceID, mainform.devices[DevPosition].gobo2RotChannel, -1, goborotvalue, Fadetime, Delaytime);
    end;
    127: set_channel(DeviceID, mainform.devices[DevPosition].gobo2RotChannel, -1, mainform.devices[DevPosition].gobo2RotOffValue, Fadetime, Delaytime);
    128..254: // Rechtslauf
    begin
      goborotvalue:=mainform.devices[DevPosition].gobo2RotRightValue-mainform.devices[DevPosition].gobo2RotRightminValue;
      goborotvalue:=round(goborotvalue*((value-128)/126));
      goborotvalue:=goborotvalue+mainform.devices[DevPosition].gobo2RotRightminValue;
      set_channel(DeviceID, mainform.devices[DevPosition].gobo2RotChannel, -1, goborotvalue, Fadetime, Delaytime);
    end;
    255: set_channel(DeviceID, mainform.devices[DevPosition].gobo2RotChannel, -1, mainform.devices[DevPosition].gobo2RotRightValue, Fadetime, Delaytime);
  end;
end;

procedure Tgeraetesteuerung.set_gobo(DeviceID: TGUID; GoboName: string);
var
  DevPosition, j, k:integer;
  BestGobo1, BestGobo2:integer;
  MaxValueGobo1, MaxValueGobo2:single;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);
  if DevPosition<0 then exit;

  if mainform.devices[DevPosition].hasGobo or mainform.devices[DevPosition].hasGobo2 then
  begin
    // GoboButton[j] = Gewähltes Gobo
    BestGobo1:=-1;
    BestGobo2:=-1;
    MaxValueGobo1:=0;
    MaxValueGobo2:=0;

    // Gobo1 durchsuchen
    if mainform.devices[DevPosition].hasGobo then
    begin
      // sofern gleiche Gobos, dann 100%ige Übereinstimmung festlegen
      for j:=0 to length(mainform.devices[DevPosition].gobos)-1 do
      begin
        if mainform.devices[DevPosition].gobos[j]=GoboName then
        begin
          MaxValueGobo1:=100;
          BestGobo1:=j;
        end;
      end;

      // falls kein identisches Gobo gefunden, dann auf Korrelationswert zurückgreifen
      if MaxValueGobo1<100 then
      for j:=0 to length(mainform.devices[DevPosition].bestgobos)-1 do
      begin
        for k:=0 to length(mainform.devices[DevPosition].bestgobos[j])-1 do
        begin
          if mainform.devices[DevPosition].bestgobos[j][k].GoboName=GoboName then
          begin
            if mainform.devices[DevPosition].bestgobos[j][k].Percent>MaxValueGobo1 then
            begin
              MaxValueGobo1:=mainform.devices[DevPosition].bestgobos[j][k].Percent;
              BestGobo1:=j;
            end;
            break;
          end;
        end;
      end;
    end;

    // Gobo2 durchsuchen
    if mainform.devices[DevPosition].hasGobo2 then
    begin
      // sofern gleiche Gobos, dann 100%ige Übereinstimmung festlegen
      for j:=0 to length(mainform.devices[DevPosition].gobos2)-1 do
      begin
        if mainform.devices[DevPosition].gobos2[j]=GoboName then
        begin
          MaxValueGobo2:=100;
          BestGobo2:=j;
        end;
      end;

      // falls kein identisches Gobo gefunden, dann auf Korrelationswert zurückgreifen
      if MaxValueGobo2<100 then
      for j:=0 to length(mainform.devices[DevPosition].bestgobos2)-1 do
      begin
        for k:=0 to length(mainform.devices[DevPosition].bestgobos2[j])-1 do
        begin
          if mainform.devices[DevPosition].bestgobos2[j][k].GoboName=GoboName then
          begin
            if mainform.devices[DevPosition].bestgobos2[j][k].Percent>MaxValueGobo2 then
            begin
              MaxValueGobo2:=mainform.devices[DevPosition].bestgobos2[j][k].Percent;
              BestGobo2:=j;
            end;
            break;
          end;
        end;
      end;
    end;

    if mainform.devices[DevPosition].hasGobo2 and (MaxValueGobo2>MaxValueGobo1) then
    begin
      geraetesteuerung.set_channel(mainform.devices[DevPosition].ID, 'GOBO1', -1, 0, 0);
      geraetesteuerung.set_channel(mainform.devices[DevPosition].ID, 'GOBO2', -1, mainform.devices[DevPosition].gobolevels2[BestGobo2], 0);
    end else if mainform.devices[DevPosition].hasGobo and (MaxValueGobo1>MaxValueGobo2) then
    begin
      geraetesteuerung.set_channel(mainform.devices[DevPosition].ID, 'GOBO1', -1, mainform.devices[DevPosition].gobolevels[BestGobo1], 0);
      geraetesteuerung.set_channel(mainform.devices[DevPosition].ID, 'GOBO2', -1, 0, 0);
    end else if mainform.devices[DevPosition].hasGobo and (MaxValueGobo1>0) then
    begin
      geraetesteuerung.set_channel(mainform.devices[DevPosition].ID, 'GOBO1', -1, mainform.devices[DevPosition].gobolevels[BestGobo1], 0);
      geraetesteuerung.set_channel(mainform.devices[DevPosition].ID, 'GOBO2', -1, 0, 0);
    end;
  end;

  grafischebuehnenansicht.RedrawPictures:=true;
end;

procedure Tgeraetesteuerung.set_gobo1plus(DeviceID: TGUID; Delaytime:integer);
var
  DevPosition, delay, delayfaktor:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;

  i, j, intvalue:integer;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_gobo1plus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_gobo1plus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], delay);
                  end;
                  2: // nach Links
                  begin
                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_gobo1plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;


  for i:=0 to length(mainform.Devices)-1 do
  begin
    if IsEqualGUID(mainform.Devices[i].ID, DeviceID) then
    begin
      if length(mainform.devices[i].gobos)>0 then
      begin
        intvalue:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'GOBO1');

        for j:=0 to length(mainform.devices[i].gobos)-1 do
        begin
          if (intvalue>=mainform.devices[i].gobolevels[j]) and (intvalue<=mainform.Devices[i].goboendlevels[j]) then
          begin
            if j<(length(mainform.devices[i].gobos)-1) then
              intvalue:=j+1
            else
              intvalue:=j;
            break;
          end;
        end;

        geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO1', -1, mainform.devices[i].gobolevels[intvalue], 0, 0);

        grafischebuehnenansicht.RedrawPictures:=true;
      end;
        
      break;
    end;
  end;
end;

procedure Tgeraetesteuerung.set_gobo1minus(DeviceID: TGUID; Delaytime:integer);
var
  DevPosition, delay, delayfaktor:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;

  i, j, intvalue:integer;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_gobo1minus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_gobo1minus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], delay);
                  end;
                  2: // nach Links
                  begin
                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_gobo1minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;


  for i:=0 to length(mainform.Devices)-1 do
  begin
    if IsEqualGUID(mainform.Devices[i].ID, DeviceID) then
    begin
      if length(mainform.devices[i].gobos)>0 then
      begin
        intvalue:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'GOBO1');

        for j:=0 to length(mainform.devices[i].gobos)-1 do
        begin
          if (intvalue>=mainform.devices[i].gobolevels[j]) and (intvalue<=mainform.Devices[i].goboendlevels[j]) then
          begin
            if j>0 then
              intvalue:=j-1
            else
              intvalue:=j;
            break;
          end;
        end;

        geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO1', -1, mainform.devices[i].gobolevels[intvalue], 0, 0);

        grafischebuehnenansicht.RedrawPictures:=true;
      end;
        
      break;
    end;
  end;
end;

procedure Tgeraetesteuerung.set_gobo2plus(DeviceID: TGUID; Delaytime:integer);
var
  DevPosition, delay, delayfaktor:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;

  i, j, intvalue:integer;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_gobo2plus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_gobo2plus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], delay);
                  end;
                  2: // nach Links
                  begin
                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_gobo2plus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;


  for i:=0 to length(mainform.Devices)-1 do
  begin
    if IsEqualGUID(mainform.Devices[i].ID, DeviceID) then
    begin
      if length(mainform.devices[i].gobos2)>0 then
      begin
        intvalue:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'GOBO2');

        for j:=0 to length(mainform.devices[i].gobos2)-1 do
        begin
          if (intvalue>=mainform.devices[i].gobolevels2[j]) and (intvalue<=mainform.Devices[i].goboendlevels2[j]) then
          begin
            if j<(length(mainform.devices[i].gobos2)-1) then
              intvalue:=j+1
            else
              intvalue:=j;
            break;
          end;
        end;

        geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO2', -1, mainform.devices[i].gobolevels2[intvalue], 0, 0);

        grafischebuehnenansicht.RedrawPictures:=true;
      end;
        
      break;
    end;
  end;
end;

procedure Tgeraetesteuerung.set_gobo2minus(DeviceID: TGUID; Delaytime:integer);
var
  DevPosition, delay, delayfaktor:integer;
  PositionOfMaster,countofpihalf:integer;
  grouptemp:extended;

  i, j, intvalue:integer;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    PositionOfMaster:=0;
    delay:=delaytime;

    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[i].ID,DeviceID) then
      begin
        if mainform.DeviceGroups[i].Active then
        begin
          if mainform.DeviceGroups[i].UseMaster then
          begin
            for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              if IsEqualGUID(mainform.DeviceGroups[i].MasterDevice,mainform.DeviceGroups[i].IDs[j]) then
              begin
                PositionOfMaster:=j;
                break;
              end;
            end;
          end;

          if delay=-1 then
            delay:=mainform.DeviceGroups[i].Delay;

          for j:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
          begin
            if mainform.DeviceGroups[i].IDActive[j] then
            begin
              if mainform.DeviceGroups[i].UseMaster then
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], 0);
                  end;
                  1: // Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                  end;
                  2: // Nach Rechts ab Master
                  begin
                    delayfaktor:=j-PositionOfMaster;
                    if delayfaktor>=0 then
                    begin
                      set_gobo2minus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                    end;
                  end;
                  3: // Nach Links ab Master
                  begin
                    delayfaktor:=PositionOfMaster-j;
                    if delayfaktor>=0 then
                    begin
                      set_gobo2minus(mainform.DeviceGroups[i].IDs[j], delay*delayfaktor);
                    end;
                  end;
                  4: // Sinus nach Links und Rechts ab Master
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sin(delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    grouptemp:=delayfaktor/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    delayfaktor:=abs(j-PositionOfMaster);
                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sqrt(power(0.5,2)-power(0.5-(delayfaktor/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end else
              begin
                case mainform.DeviceGroups[i].FanMode of
                  0: // Fanning aus
                  begin
                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], 0);
                  end;
                  1: // alle Gleichmäßig
                  begin
                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], delay);
                  end;
                  2: // nach Links
                  begin
                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], delay*j);
                  end;
                  3: // nach Rechts
                  begin
                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], delay*(length(mainform.DeviceGroups[i].IDs)-j));
                  end;
                  4: // Sinus
                  begin                                                                                   // mainform.DeviceGroups[i].IDs[j]
                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sin(j/length(mainform.DeviceGroups[i].IDs)*PI*mainform.DeviceGroups[i].FanMorph))));
                  end;
                  5: // Tangens
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    grouptemp:=grouptemp/countofpihalf;
                    if grouptemp>=((pi/2)-0.1) then grouptemp:=(pi/2)-0.1;

                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  6: // Tangens 2
                  begin
                    grouptemp:=j/length(mainform.DeviceGroups[i].IDs)*PI/2*mainform.DeviceGroups[i].FanMorph;
                    countofpihalf:=floor(grouptemp/(pi/2))+1;

                    if grouptemp>=(countofpihalf*(pi/2)-0.2) then grouptemp:=countofpihalf*(pi/2)-0.2;

                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(tan(grouptemp))));
                  end;
                  7: // Halbkreis
                  begin
                    set_gobo2minus(mainform.DeviceGroups[i].IDs[j], round(delay*abs(sqrt(power(0.5,2)-power(0.5-(j/length(mainform.DeviceGroups[i].IDs)),2)))));
                  end;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
    exit; // z.B. wenn Gruppen-ID
  end;


  for i:=0 to length(mainform.Devices)-1 do
  begin
    if IsEqualGUID(mainform.Devices[i].ID, DeviceID) then
    begin
      if length(mainform.devices[i].gobos2)>0 then
      begin
        intvalue:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'GOBO2');

        for j:=0 to length(mainform.devices[i].gobos2)-1 do
        begin
          if (intvalue>=mainform.devices[i].gobolevels2[j]) and (intvalue<=mainform.Devices[i].goboendlevels2[j]) then
          begin
            if j>0 then
              intvalue:=j-1
            else
              intvalue:=j;
            break;
          end;
        end;

        geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO2', -1, mainform.devices[i].gobolevels2[intvalue], 0, 0);

        grafischebuehnenansicht.RedrawPictures:=true;
      end;
        
      break;
    end;
  end;
end;

function Tgeraetesteuerung.get_dimmer(DeviceID: TGUID):integer;
var
  DevPosition:integer;
  value:integer;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    result:=-1;
    exit;
  end;

  value:=geraetesteuerung.get_channel(mainform.devices[DevPosition].ID, 'DIMMER');

  if value>mainform.devices[DevPosition].DimmerMaxValue then
    result:=255
  else if value<=mainform.devices[DevPosition].DimmerOffValue then
    result:=0
  else
    result:=round(((value-mainform.devices[DevPosition].DimmerOffValue)/(mainform.devices[DevPosition].DimmerMaxValue-mainform.devices[DevPosition].DimmerOffValue))*255);
end;

function Tgeraetesteuerung.get_strobe(DeviceID: TGUID):integer;
var
  DevPosition:integer;
  value:integer;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    result:=-1;
    exit;
  end;

  value:=geraetesteuerung.get_channel(mainform.devices[DevPosition].ID, mainform.devices[DevPosition].StrobeChannel);

  if value>mainform.devices[DevPosition].StrobeMaxValue then
    result:=255
  else if value<=mainform.devices[DevPosition].StrobeOffValue then
    result:=0
  else
    result:=round(((value-mainform.devices[DevPosition].StrobeMinValue)/(mainform.devices[DevPosition].StrobeMaxValue-mainform.devices[DevPosition].StrobeMinValue))*255);
end;

function Tgeraetesteuerung.get_shutter(DeviceID: TGUID):integer;
var
  DevPosition:integer;
  value:integer;
begin
  DevPosition:=GetDevicePositionInDeviceArray(@DeviceID);

  if DevPosition<0 then
  begin
    result:=-1;
    exit;
  end;

  value:=geraetesteuerung.get_channel(mainform.devices[DevPosition].ID, mainform.devices[DevPosition].ShutterChannel);

  if value=mainform.devices[DevPosition].ShutterOpenValue then
    result:=255
  else if value=mainform.devices[DevPosition].ShutterCloseValue then
    result:=0
  else if value=-1 then
    result:=-1
  else
    result:=128;
end;

function Tgeraetesteuerung.get_color(DeviceID: TGUID):TColor;
var
  DeviceIndex, l:integer;
  AmberR,AmberG,AmberB,Amber,White,UV:byte;
	R,G,B,R2,G2,B2,R3,G3,B3:byte;
  RGB, RGB3, shuttervalue:integer;
  Dimmerwert,Farbradwert,Farbradwert2:byte;
  DeviceColor:TColor;
begin
  DeviceIndex:=GetDevicePositionInDeviceArray(@DeviceID);

  if DeviceIndex<0 then
  begin
    result:=clBlack;
    exit;
  end;

  if mainform.devices[DeviceIndex].hasRGB then
  begin
    // RGB
    if mainform.devices[DeviceIndex].hasDIMMER then
    begin
      Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[DeviceIndex].ID);
      AmberR:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'R');
      AmberG:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'G');
      AmberB:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'B');
      Amber:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'A');
      White:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'W');
      UV:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'UV');

      if mainform.devices[DeviceIndex].hasAmber then
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, Amber, mainform.devices[DeviceIndex].AmberRatioR, mainform.devices[DeviceIndex].AmberRatioG, mainform.devices[DeviceIndex].AmberMixingCompensateRG, mainform.devices[DeviceIndex].AmberMixingCompensateBlue, White, UV, R, G, B);
        DeviceColor:=RGB2TColor(round(R*(Dimmerwert/255)),round(G*(Dimmerwert/255)),round(B*(Dimmerwert/255)));
      end else
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, 0, 128, 128, false, false, White, UV, R, G, B);
        DeviceColor:=RGB2TColor(round(R*(Dimmerwert/255)),round(G*(Dimmerwert/255)),round(B*(Dimmerwert/255)));
//            DeviceColor:=RGB2TColor(round(AmberR*(Dimmerwert/255)),round(AmberG*(Dimmerwert/255)),round(AmberB*(Dimmerwert/255)));
      end;
    end else
    begin
      // kein Dimmer im Gerät
      AmberR:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'R');
      AmberG:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'G');
      AmberB:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'B');
      Amber:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'A');
      White:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'W');
      UV:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'UV');

      if mainform.devices[DeviceIndex].hasAmber then
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, Amber, mainform.devices[DeviceIndex].AmberRatioR, mainform.devices[DeviceIndex].AmberRatioG, mainform.devices[DeviceIndex].AmberMixingCompensateRG, mainform.devices[DeviceIndex].AmberMixingCompensateBlue, White, UV, R, G, B);
        DeviceColor:=RGB2TColor(R, G, B);
      end else
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, 0, 128, 128, false, false, White, UV, R, G, B);
        DeviceColor:=RGB2TColor(R, G, B);
      end;
    end;
  end else if mainform.devices[DeviceIndex].hasCMY then
  begin
    // CMY
    if mainform.devices[DeviceIndex].hasDIMMER then
    begin
      Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[DeviceIndex].ID);
      AmberR:=255-geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'C');
      AmberG:=255-geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'M');
      AmberB:=255-geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'Y');
      Amber:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'A');
      White:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'W');
      UV:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'UV');

      if mainform.devices[DeviceIndex].hasAmber then
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, Amber, mainform.devices[DeviceIndex].AmberRatioR, mainform.devices[DeviceIndex].AmberRatioG, mainform.devices[DeviceIndex].AmberMixingCompensateRG, mainform.devices[DeviceIndex].AmberMixingCompensateBlue, White, UV, R, G, B);
        DeviceColor:=RGB2TColor(round(R*(Dimmerwert/255)),round(G*(Dimmerwert/255)),round(B*(Dimmerwert/255)));
      end else
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, 0, 128, 128, false, false, White, UV, R, G, B);
        DeviceColor:=RGB2TColor(round(R*(Dimmerwert/255)),round(G*(Dimmerwert/255)),round(B*(Dimmerwert/255)));
//            DeviceColor:=RGB2TColor(round(AmberR*(Dimmerwert/255)),round(AmberG*(Dimmerwert/255)),round(AmberB*(Dimmerwert/255)));
      end;
    end else
    begin
      // kein Dimmer im Gerät
      AmberR:=255-geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'C');
      AmberG:=255-geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'M');
      AmberB:=255-geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'Y');
      Amber:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'A');
      White:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'W');
      UV:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'UV');

      if mainform.devices[DeviceIndex].hasAmber then
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, Amber, mainform.devices[DeviceIndex].AmberRatioR, mainform.devices[DeviceIndex].AmberRatioG, mainform.devices[DeviceIndex].AmberMixingCompensateRG, mainform.devices[DeviceIndex].AmberMixingCompensateBlue, White, UV, R, G, B);
        DeviceColor:=RGB2TColor(R, G, B);
      end else
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, 0, 128, 128, false, false, White, UV, R, G, B);
        DeviceColor:=RGB2TColor(R, G, B);
//            DeviceColor:=RGB2TColor(AmberR,AmberG,AmberB);
      end;
    end;
  end else if (mainform.devices[DeviceIndex].hasColor or mainform.devices[DeviceIndex].hasColor2) then
  begin
    if (mainform.devices[DeviceIndex].hasColor and mainform.devices[DeviceIndex].hasColor2) then
    begin
      // COLOR1 & COLOR2
      Farbradwert:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'COLOR1');
      Farbradwert2:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'COLOR2');

      for l:=0 to length(mainform.devices[DeviceIndex].colorlevels)-1 do
      begin
        if (mainform.devices[DeviceIndex].colorlevels[l]<=Farbradwert) and
          (mainform.devices[DeviceIndex].colorendlevels[l]>=Farbradwert) then
        begin
//              RGB:=ColorToRGB(mainform.devices[DeviceIndex].colors[l]);
          TColor2RGB(mainform.devices[DeviceIndex].colors[l], R, G, B);
          break;
        end;
      end;
      for l:=0 to length(mainform.devices[DeviceIndex].colorlevels2)-1 do
      begin
        if (mainform.devices[DeviceIndex].colorlevels2[l]<=Farbradwert2) and
          (mainform.devices[DeviceIndex].colorendlevels2[l]>=Farbradwert2) then
        begin
//              RGB2:=ColorToRGB(mainform.devices[DeviceIndex].colors2[l]);
          TColor2RGB(mainform.devices[DeviceIndex].colors2[l], R2, G2, B2);
          break;
        end;
      end;

      R3:=round((R/255)*(R2/255)*255);
      G3:=round((G/255)*(G2/255)*255);
      B3:=round((B/255)*(B2/255)*255);
      RGB3:=RGB2TColor(R3,G3,B3);

      if mainform.devices[DeviceIndex].hasDimmer then
      begin
        Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[DeviceIndex].ID);

        DeviceColor:=RGB2TColor(round(R3*Dimmerwert/255),round(G3*Dimmerwert/255),round(B3*Dimmerwert/255));
      end else
      begin
        DeviceColor:=RGB3;
      end;
    end else if mainform.devices[DeviceIndex].hasColor then
    begin
      // COLOR1
      Farbradwert:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'COLOR1');

      for l:=0 to length(mainform.devices[DeviceIndex].colorlevels)-1 do
      begin
        if (mainform.devices[DeviceIndex].colorlevels[l]<=Farbradwert) and
          (mainform.devices[DeviceIndex].colorendlevels[l]>=Farbradwert) then
        begin
          if mainform.devices[DeviceIndex].hasDimmer then
          begin
            Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[DeviceIndex].ID);

            RGB:=ColorToRGB(mainform.devices[DeviceIndex].colors[l]);
            R:=round(GetRValue(RGB)*Dimmerwert / 255);
            G:=round(GetGValue(RGB)*Dimmerwert / 255);
            B:=round(GetBValue(RGB)*Dimmerwert / 255);

            DeviceColor:=RGB2TColor(R,G,B);
          end else
          begin
            DeviceColor:=mainform.devices[DeviceIndex].colors[l];
          end;
          break;
        end;
      end;
    end else
    begin
      // COLOR2
      Farbradwert2:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'COLOR2');

      for l:=0 to length(mainform.devices[DeviceIndex].colorlevels2)-1 do
      begin
        if (mainform.devices[DeviceIndex].colorlevels2[l]<=Farbradwert2) and
          (mainform.devices[DeviceIndex].colorendlevels2[l]>=Farbradwert2) then
        begin
          if mainform.devices[DeviceIndex].hasDimmer then
          begin
            Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[DeviceIndex].ID);

            RGB:=ColorToRGB(mainform.devices[DeviceIndex].colors2[l]);
            R:=round(GetRValue(RGB)*Dimmerwert / 255);
            G:=round(GetGValue(RGB)*Dimmerwert / 255);
            B:=round(GetBValue(RGB)*Dimmerwert / 255);

            DeviceColor:=RGB2TColor(R,G,B);
          end else
          begin
            DeviceColor:=mainform.devices[DeviceIndex].colors2[l];
          end;
          break;
        end;
      end;
    end;
  end else if (mainform.devices[DeviceIndex].hasWhite or mainform.devices[DeviceIndex].hasAmber) then
  begin
    // Device has no RGB, but Amber and/or White
    if mainform.devices[DeviceIndex].hasDIMMER then
    begin
      Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[DeviceIndex].ID);
      Amber:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'A');
      White:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'W');

      if mainform.devices[DeviceIndex].hasAmber then
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(0, 0, 0, Amber, mainform.devices[DeviceIndex].AmberRatioR, mainform.devices[DeviceIndex].AmberRatioG, false, false, White, 0, R, G, B);
        DeviceColor:=RGB2TColor(round(R*(Dimmerwert/255)),round(G*(Dimmerwert/255)),round(B*(Dimmerwert/255)));
      end else
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(0, 0, 0, 0, mainform.devices[DeviceIndex].AmberRatioR, mainform.devices[DeviceIndex].AmberRatioG, false, false, White, 0, R, G, B);
        DeviceColor:=RGB2TColor(round(R*(Dimmerwert/255)),round(G*(Dimmerwert/255)),round(B*(Dimmerwert/255)));
      end;
    end else
    begin
      // kein Dimmer im Gerät
      Amber:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'A');
      White:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID,'W');

      if mainform.devices[DeviceIndex].hasAmber then
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(0, 0, 0, Amber, mainform.devices[DeviceIndex].AmberRatioR, mainform.devices[DeviceIndex].AmberRatioG, false, false, White, 0, R, G, B);
        DeviceColor:=RGB2TColor(R, G, B);
      end else
      begin
        geraetesteuerung.ConvertRGBAWUVtoRGB(0, 0, 0, 0, mainform.devices[DeviceIndex].AmberRatioR, mainform.devices[DeviceIndex].AmberRatioG, false, false, White, 0, R, G, B);
        DeviceColor:=RGB2TColor(R, G, B);
      end;
    end;
  end else
  begin
    // nur Farbfilter
    if mainform.Devices[DeviceIndex].hasDimmer then
    begin
      Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[DeviceIndex].ID);
      RGB:=ColorToRGB(mainform.devices[DeviceIndex].color);
      R:=round(GetRValue(RGB)*Dimmerwert / 255);
      G:=round(GetGValue(RGB)*Dimmerwert / 255);
      B:=round(GetBValue(RGB)*Dimmerwert / 255);
      DeviceColor:=RGB2TColor(R,G,B);
    end else if mainform.Devices[DeviceIndex].hasFog then
    begin
      Dimmerwert:=geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID, 'FOG');
      R:=Dimmerwert;
      G:=Dimmerwert;
      B:=Dimmerwert;
      DeviceColor:=RGB2TColor(R,G,B);
    end else
    begin
      DeviceColor:=mainform.devices[DeviceIndex].color;
    end;
  end;
  if mainform.Devices[DeviceIndex].hasShutter then
  begin
    shuttervalue:=geraetesteuerung.get_shutter(mainform.devices[DeviceIndex].ID);
    if (shuttervalue=0) or (shuttervalue=255) then
    begin
      TColor2RGB(DeviceColor, R, G, B);
      R:=round(R*shuttervalue/255);
      G:=round(G*shuttervalue/255);
      B:=round(B*shuttervalue/255);
      DeviceColor:=RGB2TColor(R, G, B);
    end;
  end;

  Result:=DeviceColor;
end;

function Tgeraetesteuerung.GetMatrixDeviceStartAddress(MasterDeviceID:TGUID; MatrixXPosition, MatrixYPosition:byte):integer;
var
  my,mx,m, devposition:integer;
begin
  devposition:=GetDevicePositionInDeviceArray(@MasterDeviceID);

  result:=0;

  for m:=0 to (mainform.Devices[devposition].MatrixXCount*mainform.Devices[devposition].MatrixYCount)-1 do
  begin
    my:=0;
    mx:=0;
    case mainform.Devices[devposition].MatrixOrdertype of
      1:
      begin
        my:=trunc(m/mainform.Devices[devposition].MatrixXCount);
        mx:=m-(my*mainform.Devices[devposition].MatrixXCount);
      end;
      2:
      begin
        my:=trunc(m/mainform.Devices[devposition].MatrixXCount);
        if ((my mod 2) = 0) then
        begin
          // gerade Reihe (von links nach rechts)
          mx:=m-(my*mainform.Devices[devposition].MatrixXCount);
        end else
        begin
          // ungerade Reihe (von rechts nach links)
          mx:=(mainform.Devices[devposition].MatrixXCount-1)-(m-(my*mainform.Devices[devposition].MatrixXCount));
        end;
      end;
      3:
      begin
        mx:=trunc(m/mainform.Devices[devposition].MatrixYCount);
        my:=m-(mx*mainform.Devices[devposition].MatrixYCount);
      end;
      4:
      begin
        mx:=trunc(m/mainform.Devices[devposition].MatrixYCount);
        if ((mx mod 2) = 0) then
        begin
          // gerade Reihe (von links nach rechts)
          my:=m-(mx*mainform.Devices[devposition].MatrixYCount);
        end else
        begin
          // ungerade Reihe (von rechts nach links)
          my:=(mainform.Devices[devposition].MatrixYCount-1)-(m-(mx*mainform.Devices[devposition].MatrixYCount));
        end;
      end;
    end;

    if (mx=MatrixXPosition) and (my=MatrixYPosition) then
    begin
      result:=mainform.Devices[devposition].Startaddress+m*mainform.Devices[devposition].MaxChan;
      break;
    end;
  end;
end;

procedure Tgeraetesteuerung.ChangeDeviceStartaddress(ID: TGUID; NewStartaddress:Word);
var
  position, oldstartaddress, i, j, k:integer;
  channelstillinuse:boolean;
begin
  position:=GetDevicePositionInDeviceArray(@ID);

  if (NewStartaddress+mainform.devices[position].MaxChan-1)>mainform.lastchan then
    ShowMessage(_('In den Optionen ist die Kanalzahl auf ')+inttostr(mainform.lastchan)+_(' begrenzt. Diese Grenze kann in den erweiterten Einstellungen auf bis zu 8192 erhöht werden.'));

  oldstartaddress:=mainform.devices[position].Startaddress;
  mainform.devices[position].Startaddress:=NewStartaddress;

  for i:=0 to mainform.devices[position].MaxChan-1 do
  begin
    // Alte Kanaldimmkurven zurücksetzen, falls dort kein Gerät liegt
    // Checken, ob an alten Kanälen noch Geräte adressiert sind
    channelstillinuse:=false;
    for j:=0 to length(mainform.devices)-1 do
    begin // Geräte durchlaufen
      for k:=0 to mainform.devices[j].MaxChan-1 do
      begin // Gerätekanäle durchlaufen
        if (mainform.devices[j].Startaddress+k)=(oldstartaddress+i) then
          channelstillinuse:=true;
      end;

      // Kanal wird von keinem Gerät mehr genutzt
      if not channelstillinuse then
      begin
        mainform.channel_dimmcurve[oldstartaddress+i]:=0;
        mainform.channel_absolutedimmcurve[oldstartaddress+i]:=0;
      end;
    end;

    // Neue Dimmkurven setzen
    mainform.channel_dimmcurve[mainform.devices[position].Startaddress+i]:=mainform.devices[position].kanaldimmcurve[i];
    mainform.channel_absolutedimmcurve[mainform.devices[position].Startaddress+i]:=mainform.devices[position].kanalabsolutedimmcurve[i];

    // Falls andere Gerätekanäle mit diesem konkurrieren, dann Meldung
    for j:=0 to length(mainform.devices)-1 do
    begin
      if (mainform.devices[j].Startaddress>=(mainform.Devices[position].Startaddress+i)) and (mainform.devices[j].Startaddress+mainform.devices[j].MaxChan-1<=(mainform.Devices[position].Startaddress+i)) and (j<>position) and ((mainform.Devices[j].kanaldimmcurve[mainform.Devices[position].Startaddress+i-mainform.devices[j].Startaddress]<>mainform.devices[position].kanaldimmcurve[i]) or (mainform.Devices[j].kanalabsolutedimmcurve[mainform.Devices[position].Startaddress+i-mainform.devices[j].Startaddress]<>mainform.devices[position].kanalabsolutedimmcurve[i])) then
      begin
        //if messagedlg(_('Ein anderer Gerätekanal (')+mainform.Devices[j].Name+': '+mainform.Devices[j].Kanalname[mainform.Devices[position].Startaddress+i-mainform.devices[j].Startaddress]+_(') belegt die gleiche Adresse wie der ausgewählte Kanal.')+#10#13+_('Es kann allerdings nur eine Dimmerkurve pro Kanal genutzt werden.')+#10#13#10#13+_('Soll die Kurvenform des anderen Gerätekanals nun automatisch angepasst werden?'),mtConfirmation,
        //  [mbYes,mbNo],0)=mrYes then
        //  begin
            mainform.Devices[j].kanaldimmcurve[mainform.Devices[position].Startaddress+i-mainform.devices[j].Startaddress]:=mainform.devices[position].kanaldimmcurve[i];
            mainform.Devices[j].kanalabsolutedimmcurve[mainform.Devices[position].Startaddress+i-mainform.devices[j].Startaddress]:=mainform.devices[position].kanalabsolutedimmcurve[i];
        //  end;
      end;
    end;
  end;
end;

procedure Tgeraetesteuerung.idbtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;

  if Shift=[] then
  begin
    Data:=VST.GetNodeData(VST.FocusedNode);
    InputBox(_('Geräte-ID'),_('Die ID des aktuellen Gerätes lautet wie folgt:'),GUIDtoString(Data^.ID));
  end;

  if Shift=[ssCtrl] then
    TBItem4Click(nil);
end;

procedure Tgeraetesteuerung.DevStartaddressEditKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  s:string;
  i,m:integer;
  position, maindevposition:integer;
  newaddress:word;
  temp:byte;
  Data:PTreeData;
begin
  if Key=vk_return then
  begin
    if not mainform.UserAccessGranted(1, false) then exit;

    s:=DevStartaddressEdit.text;
    i:=DevStartaddressEdit.selstart;
    mainform.input_number(i,s);
    DevStartaddressEdit.text:=s;
    DevStartaddressEdit.selstart:=i;

    if DevStartaddressEdit.text='0' then
      DevStartaddressEdit.text:='1';

    if DevStartaddressEdit.text<>'' then
    begin
      Data:=VST.GetNodeData(VST.FocusedNode);
      position:=GetDevicePositionInDeviceArray(@Data^.ID);
      if position < 0 then
        Exit;

      newaddress:=strtoint(DevStartaddressEdit.Text);

      if mainform.devices[position].MatrixDeviceLevel=0 then
      begin
        ChangeDeviceStartaddress(mainform.devices[position].ID, newaddress);
      end else
      begin
        // ist ein Matrixgerät
        maindevposition:=GetDevicePositionInDeviceArray(@mainform.devices[position].MatrixMainDeviceID);
        ChangeDeviceStartaddress(mainform.devices[maindevposition].ID, newaddress);

        for m:=0 to length(mainform.Devices)-1 do
        begin
          if (mainform.Devices[m].MatrixDeviceLevel=2) and (IsEqualGUID(mainform.Devices[m].MatrixMainDeviceID, mainform.devices[maindevposition].ID)) then
          begin
            ChangeDeviceStartaddress(mainform.Devices[m].ID, GetMatrixDeviceStartAddress(mainform.Devices[m].MatrixMainDeviceID, mainform.devices[m].MatrixXPosition, mainform.devices[m].MatrixYPosition));
          end;
        end;
      end;

      temp:=newaddress;
      dipstate[1]:=BitSet(temp, 1);
      dipstate[2]:=BitSet(temp, 2);
      dipstate[3]:=BitSet(temp, 4);
      dipstate[4]:=BitSet(temp, 8);
      dipstate[5]:=BitSet(temp, 16);
      dipstate[6]:=BitSet(temp, 32);
      dipstate[7]:=BitSet(temp, 64);
      dipstate[8]:=BitSet(temp, 128);

      temp:=newaddress shr 8;
      dipstate[9]:=BitSet(temp, 1);
      dipstate[10]:=BitSet(temp, 2);

      for i:=1 to 10 do
        if dipstate[i] then
          Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPON.Picture
        else
          Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPOFF.Picture;
    end;
    VST.Refresh;
    SendNamesBtnClick(nil);
  end;
end;

procedure Tgeraetesteuerung.TBItem6Click(Sender: TObject);
var
  i, deviceposition:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  deviceposition:=GetDevicePositionInDeviceArray(@Data^.ID);

  if mainform.devices[deviceposition].MatrixDeviceLevel=0 then
  begin
    ShowMessage(_('Das ausgewählte Gerät ist kein Matrixgerät!'));
    exit;
  end;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if IsEqualGUID(mainform.devices[i].MatrixMainDeviceID, mainform.devices[deviceposition].MatrixMainDeviceID) then
    begin
      mainform.devices[i].MatrixXPosition:=-1*mainform.devices[i].MatrixXPosition;
    end;
  end;
end;

procedure Tgeraetesteuerung.TBItem5Click(Sender: TObject);
var
  i, deviceposition:integer;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  deviceposition:=GetDevicePositionInDeviceArray(@Data^.ID);

  if mainform.devices[deviceposition].MatrixDeviceLevel=0 then
  begin
    ShowMessage(_('Das ausgewählte Gerät ist kein Matrixgerät!'));
    exit;
  end;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if IsEqualGUID(mainform.devices[i].MatrixMainDeviceID, mainform.devices[deviceposition].MatrixMainDeviceID) then
    begin
      mainform.devices[i].MatrixYPosition:=-1*mainform.devices[i].MatrixYPosition;
    end;
  end;
end;

end.
