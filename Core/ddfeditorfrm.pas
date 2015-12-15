unit ddfeditorfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, TB2Item, TB2Dock, TB2Toolbar, StdCtrls, ExtCtrls,
  SizeControl, HSLColorPicker, ComCtrls, CommCtrl, JvComponentBase,
  JvAppStorage, JvAppXMLStorage, Mask, JvExMask, JvSpin, Buttons, PngBitBtn,
  pngimage, JvInterpreter, SynEditHighlighter, SynHighlighterPas, SynEdit,
  SynCompletionProposal, JvExExtCtrls, JvExtComponent, JvPanel,
  JvOfficeColorPanel, JvExControls, JvGradient, JvColorBox, JvColorButton,
  JvExStdCtrls, JvCombobox, JvColorCombo, mbXPImageComboBox, PngImageList,
  gnugettext, JvListComb;

type
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
    itemvalueend:array of integer;
    picture:array of string;
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
    itemvalueend:array of integer;
  end;

  Tchannels = record
    minvalue:byte;
    maxvalue:byte;
    name:string;
    fade:boolean;
    typ:string;
    initvalue:integer;
  end;

  Tfunctions = record
    name:string;
    functext:string;
  end;

  Tcolors = record
    name:string;
    R:Byte;
    G:Byte;
    B:Byte;
    value:integer;
    valueend:integer;
  end;

  Tgobos = record
    name:string;
    filename:string;
    value:integer;
    valueend:integer;
  end;

  Tddfeditorform = class(TForm)
    Symbols: TTBDock;
    TBToolbar1: TTBToolbar;
    TBItem2: TTBItem;
    TBItem3: TTBItem;
    TBItem4: TTBItem;
    TBItem5: TTBItem;
    TBItem6: TTBItem;
    TBItem7: TTBItem;
    TBItem8: TTBItem;
    TBImageList1: TTBImageList;
    Panel1: TPanel;
    TBItem9: TTBItem;
    TBItem10: TTBItem;
    SizeCtrl: TSizeCtrl;
    deviceimage: TImage;
    devicename: TLabel;
    deviceadress: TLabel;
    ColorPicker2: THSLColorPicker;
    fadenkreuz: TPanel;
    vertical_line: TBevel;
    horizontal_line: TBevel;
    PositionXY: TShape;
    TBItem1: TTBItem;
    TBItem11: TTBItem;
    StatusBar1: TStatusBar;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    grundeinstellungelbl: TLabel;
    nameedit: TEdit;
    vendoredit: TEdit;
    autoredit: TEdit;
    namelbl: TLabel;
    herstellerlbl: TLabel;
    autorlbl: TLabel;
    beschreibungedit: TEdit;
    beschreibunglbl: TLabel;
    bildedit: TEdit;
    geraetebildlbl: TLabel;
    theline: TBevel;
    kanaleinstellungenlbl: TLabel;
    theline2: TBevel;
    JvSpinEdit1: TJvSpinEdit;
    editierekanallb: TLabel;
    TabSheet4: TTabSheet;
    Memo1: TMemo;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    kanalanzahllbl: TLabel;
    kanananzahlanzeigelbl: TLabel;
    kanalnamelbl: TLabel;
    minvaluelbl: TLabel;
    maxvaluelbl: TLabel;
    kanalnameedit: TEdit;
    kanaltyplbl: TLabel;
    typliste: TComboBox;
    openpicturebtn: TButton;
    Panel2: TPanel;
    funktionentoplbl: TLabel;
    Bevel7: TBevel;
    PngBitBtn4: TPngBitBtn;
    PngBitBtn5: TPngBitBtn;
    funktionsliste1: TComboBox;
    funktionsnameedit: TEdit;
    XML: TJvAppXMLFileStorage;
    unitnameedit: TEdit;
    unitnamelbl: TLabel;
    funktionsnamelbl: TLabel;
    GridSizeTrackbar: TTrackBar;
    standardfunktionen: TComboBox;
    funktionenlbl: TLabel;
    standardfktlbl: TLabel;
    Bevel8: TBevel;
    TabSheet5: TTabSheet;
    komponentenlbl: TLabel;
    theline3: TBevel;
    name2lbl: TLabel;
    funktionlbl: TLabel;
    textlbl: TLabel;
    itemslbl: TLabel;
    komponentennameedit: TEdit;
    funktionsliste2: TComboBox;
    textedit: TEdit;
    PngBitBtn3: TPngBitBtn;
    PngBitBtn6: TPngBitBtn;
    PngBitBtn7: TPngBitBtn;
    itemlistbox: TListBox;
    itemnameedit: TEdit;
    itemvalueedit: TJvSpinEdit;
    itemtextlbl: TLabel;
    itemvaluelbl: TLabel;
    minvaluespin: TJvSpinEdit;
    maxvaluespin: TJvSpinEdit;
    TBToolbar2: TTBToolbar;
    TBItem12: TTBItem;
    TBItem13: TTBItem;
    TBItem14: TTBItem;
    TBToolbar3: TTBToolbar;
    Datei1: TTBSubmenuItem;
    NeuesDDF1: TTBItem;
    DDFffnen1: TTBItem;
    GerteeinstellungenalsXMLspeichern1: TTBItem;
    Komponenten1: TTBSubmenuItem;
    Gertebildundname1: TTBItem;
    menuitemlabel: TTBItem;
    menuitemedit: TTBItem;
    menuitembutton: TTBItem;
    menuitemcheckbox1: TTBItem;
    menuitemRadiobutton1: TTBItem;
    menuitemDropdown1: TTBItem;
    menuitemslider: TTBItem;
    menuitemColorpicker1: TTBItem;
    menuitemShape1: TTBItem;
    menuitemPositionierung1: TTBItem;
    Mainmenu: TTBDock;
    TBItem15: TTBItem;
    defaultvaluespin: TJvSpinEdit;
    TBItem16: TTBItem;
    TBSeparatorItem1: TTBSeparatorItem;
    ScriptInterpreter: TJvInterpreterProgram;
    PngBitBtn8: TPngBitBtn;
    sizecontrolchecked: TCheckBox;
    gitternetzgroessen: TLabel;
    SynPasSyn1: TSynPasSyn;
    Memo2: TSynEdit;
    panmirror: TCheckBox;
    tiltmirror: TCheckBox;
    ColorPicker: TJvOfficeColorPanel;
    breitelbl: TLabel;
    hoehelbl: TLabel;
    widthspin: TJvSpinEdit;
    heightspin: TJvSpinEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    JvGradient1: TJvGradient;
    PngBitBtn10: TPngBitBtn;
    ColorBox: TJvColorComboBox;
    TBItem17: TTBItem;
    TBItem18: TTBItem;
    bildlbl: TLabel;
    bildedt: TEdit;
    bildchange: TButton;
    itempicture: TImage;
    initlbl: TLabel;
    initvalueedit: TJvSpinEdit;
    minvalueedit: TJvSpinEdit;
    maxvalueedit: TJvSpinEdit;
    dipswitchpanel: TImage;
    TBItem19: TTBItem;
    TBItem20: TTBItem;
    mbXPImageComboBox1: TmbXPImageComboBox;
    ImageList1: TImageList;
    TBItem21: TTBItem;
    ColorBox2: TJvColorComboBox;
    TBItem22: TTBItem;
    specialfunctionlbl: TLabel;
    spezialfunktionen: TComboBox;
    autoddfbtn: TButton;
    autoddfbtn2: TButton;
    PageControl2: TPageControl;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    gobolbl2: TLabel;
    gobostartvaluelbl2: TLabel;
    goboendvaluelbl2: TLabel;
    DDFEgoboedit2: TEdit;
    gobovalueedit2: TJvSpinEdit;
    gobovalueendedit2: TJvSpinEdit;
    PngBitBtn16: TPngBitBtn;
    PngBitBtn17: TPngBitBtn;
    DDFEgobolist2: TJvImageListBox;
    goboselectbox2: TmbXPImageComboBox;
    colorlbl2: TLabel;
    startvaluelbl2: TLabel;
    endvaluelbl2: TLabel;
    DDFEcolorlist2: TListBox;
    DDFEcoloredit2: TEdit;
    DDFEcolorbutton2: TJvColorButton;
    colorvalueedit2: TJvSpinEdit;
    colorvalueendedit2: TJvSpinEdit;
    PngBitBtn9: TPngBitBtn;
    PngBitBtn13: TPngBitBtn;
    TabSheet8: TTabSheet;
    shuttergroupbox: TGroupBox;
    shutterlbl: TLabel;
    closelbl: TLabel;
    openlbl: TLabel;
    shutterchannellist: TComboBox;
    shutterclosevalueedit: TJvSpinEdit;
    shutteropenvalueedit: TJvSpinEdit;
    strobegroupbox: TGroupBox;
    strobelbl: TLabel;
    strobeofflbl: TLabel;
    strobemaxlbl: TLabel;
    strobochannellist: TComboBox;
    strobeoffvalueedit: TJvSpinEdit;
    strobemaxvalueedit: TJvSpinEdit;
    colorlbl: TLabel;
    startvaluelbl: TLabel;
    endvaluelbl: TLabel;
    DDFEcoloredit: TEdit;
    DDFEcolorbutton: TJvColorButton;
    colorvalueedit: TJvSpinEdit;
    DDFEcolorlist: TListBox;
    PngBitBtn11: TPngBitBtn;
    PngBitBtn12: TPngBitBtn;
    colorvalueendedit: TJvSpinEdit;
    gobolbl: TLabel;
    gobostartvaluelbl: TLabel;
    goboendvaluelbl: TLabel;
    DDFEgoboedit: TEdit;
    gobovalueedit: TJvSpinEdit;
    gobovalueendedit: TJvSpinEdit;
    PngBitBtn14: TPngBitBtn;
    PngBitBtn15: TPngBitBtn;
    DDFEgobolist: TJvImageListBox;
    goboselectbox: TmbXPImageComboBox;
    dimmergroupbox: TGroupBox;
    dimmerofflbl: TLabel;
    dimmermaxlbl: TLabel;
    dimmermaxvalueedit: TJvSpinEdit;
    dimmeroffvalueedit: TJvSpinEdit;
    goborot1box: TGroupBox;
    goborotofflbl: TLabel;
    goborightlbl: TLabel;
    goborotoffvalueedit: TJvSpinEdit;
    goborotrightvalueedit: TJvSpinEdit;
    goboleftlbl: TLabel;
    goborotleftvalueedit: TJvSpinEdit;
    gobo2rotbox: TGroupBox;
    gobooff2lbl: TLabel;
    goboright2lbl: TLabel;
    goboleft2lbl: TLabel;
    gobo2rotoffvalueedit: TJvSpinEdit;
    gobo2rotrightvalueedit: TJvSpinEdit;
    gobo2rotleftvalueedit: TJvSpinEdit;
    gobo1rotchllbl: TLabel;
    gobo1rotchlbox: TComboBox;
    gobo2rotchllbl: TLabel;
    gobo2rotchlbox: TComboBox;
    goborightlbl2: TLabel;
    goborotrightminvalueedit: TJvSpinEdit;
    goboleftlbl2: TLabel;
    goborotleftminvalueedit: TJvSpinEdit;
    gobo2rightlbl2: TLabel;
    gobo2leftlbl2: TLabel;
    gobo2rotrightminvalueedit: TJvSpinEdit;
    gobo2rotleftminvalueedit: TJvSpinEdit;
    strobeminlbl: TLabel;
    strobeminvalueedit: TJvSpinEdit;
    TBItem23: TTBItem;
    TabSheet9: TTabSheet;
    prismabox1: TGroupBox;
    prismaofflbl: TLabel;
    prismatriplelbl: TLabel;
    prismaoffedit: TJvSpinEdit;
    prismatripleedit: TJvSpinEdit;
    prismarotbox1: TGroupBox;
    prismarotofflbl: TLabel;
    prismarotrightmaxlbl: TLabel;
    prismaleftmaxlbl: TLabel;
    prismachannellbl: TLabel;
    prismarightminlbl: TLabel;
    prismaleftminlbl: TLabel;
    prismarotstopedit: TJvSpinEdit;
    prismarotrightmaxedit: TJvSpinEdit;
    prismarotleftmaxedit: TJvSpinEdit;
    prismarotchanneledit: TComboBox;
    prismarotrightminedit: TJvSpinEdit;
    prismarotleftminedit: TJvSpinEdit;
    irisbox1: TGroupBox;
    irisofflbl: TLabel;
    irisopenlbl: TLabel;
    irisoffedit: TJvSpinEdit;
    irisopenedit: TJvSpinEdit;
    irisminlbl: TLabel;
    irismaxlbl: TLabel;
    irisminedit: TJvSpinEdit;
    irismaxedit: TJvSpinEdit;
    UseAmberMixingCheck: TCheckBox;
    AmberMixingCompensateRGCheck: TCheckBox;
    AmbermixingCompensateBlueCheck: TCheckBox;
    AmberratioGBox: TJvSpinEdit;
    amberratio2lbl: TLabel;
    ambersettingslbl: TLabel;
    Bevel1: TBevel;
    AmberratioRBox: TJvSpinEdit;
    amberredlbl: TLabel;
    ambergreenlbl: TLabel;
    channelfadebox: TCheckBox;
    itemvalueendedit: TJvSpinEdit;
    procedure sizecontrolcheckedClick(Sender: TObject);
    procedure TBItem8Click(Sender: TObject);
    procedure TBItem7Click(Sender: TObject);
    procedure TBItem6Click(Sender: TObject);
    procedure TBItem5Click(Sender: TObject);
    procedure TBItem9Click(Sender: TObject);
    procedure TBItem4Click(Sender: TObject);
    procedure TBItem3Click(Sender: TObject);
    procedure TBItem2Click(Sender: TObject);
    procedure TBItem10Click(Sender: TObject);
    procedure TBItem1Click(Sender: TObject);
    procedure TBItem11Click(Sender: TObject);
    procedure RefreshSelection;
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure SizeCtrlTargetChange(Sender: TObject);
    procedure SizeCtrlDuringSizeMove(Sender: TObject; dx, dy: Integer;
      State: TSCState);
    procedure SizeCtrlEndSizeMove(Sender: TObject; State: TSCState);
    procedure GerteeinstellungenalsXMLspeichern1Click(Sender: TObject);
    procedure CreateXMLDDF;
    procedure CreateCode;
    procedure itemlistboxchange;
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure RefreshSettings;
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure kanalnameeditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure typlisteSelect(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure PngBitBtn4Click(Sender: TObject);
    procedure PngBitBtn5Click(Sender: TObject);
    procedure funktionsliste1Select(Sender: TObject);
    procedure Memo2_oldKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure openpicturebtnClick(Sender: TObject);
    procedure funktionsliste2Select(Sender: TObject);
    procedure texteditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PngBitBtn3Click(Sender: TObject);
    procedure funktionsnameeditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure komponentennameeditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NeuesDDF1Click(Sender: TObject);
    procedure DDFffnen1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridSizeTrackbarChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PngBitBtn6Click(Sender: TObject);
    procedure itemlistboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure itemnameeditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure itemvalueeditChange(Sender: TObject);
    procedure itemvalueendeditChange(Sender: TObject);
    procedure minvaluespinChange(Sender: TObject);
    procedure maxvaluespinChange(Sender: TObject);
    procedure standardfunktionenSelect(Sender: TObject);
    procedure TBItem15Click(Sender: TObject);
    procedure defaultvaluespinChange(Sender: TObject);
    procedure TBItem16Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure PngBitBtn8Click(Sender: TObject);
    procedure Memo2_oldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ScriptInterpreterGetValue(Sender: TObject;
      Identifier: String; var Value: Variant; Args: TJvInterpreterArgs;
      var Done: Boolean);
    procedure sliderscroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure startscript(Sender: TObject);
    procedure OwnColorPickerChange(Sender: TObject);
    procedure PositionXYMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure fadenkreuzMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure fadenkreuzMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure widthspinChange(Sender: TObject);
    procedure heightspinChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PngBitBtn10Click(Sender: TObject);
    procedure PngBitBtn11Click(Sender: TObject);
    procedure DDFEcolorlistMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DDFEcoloreditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure colorvalueeditChange(Sender: TObject);
    procedure PngBitBtn12Click(Sender: TObject);
    procedure DDFEcolorbuttonChange(Sender: TObject);
    procedure DDFEcolorlistKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TBItem17Click(Sender: TObject);
    procedure ColorBoxChange(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure bildchangeClick(Sender: TObject);
    procedure bildedtKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure itemlistboxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure minvalueeditChange(Sender: TObject);
    procedure maxvalueeditChange(Sender: TObject);
    procedure initvalueeditChange(Sender: TObject);
    procedure Memo2Exit(Sender: TObject);
    procedure TBItem19Click(Sender: TObject);
    procedure PngBitBtn7Click(Sender: TObject);
    procedure colorvalueendeditChange(Sender: TObject);
    procedure mbXPImageComboBox1Select(Sender: TObject);
    procedure TBItem21Click(Sender: TObject);
    procedure DDFEcolorlist2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DDFEcolorlist2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DDFEcoloredit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure colorvalueedit2Change(Sender: TObject);
    procedure colorvalueendedit2Change(Sender: TObject);
    procedure PngBitBtn9Click(Sender: TObject);
    procedure PngBitBtn13Click(Sender: TObject);
    procedure DDFEcolorbutton2Change(Sender: TObject);
    procedure DDFEgobolistKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DDFEgobolistMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure gobovalueeditChange(Sender: TObject);
    procedure gobovalueendeditChange(Sender: TObject);
    procedure PngBitBtn14Click(Sender: TObject);
    procedure PngBitBtn15Click(Sender: TObject);
    procedure DDFEgoboeditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure goboselectboxSelect(Sender: TObject);
    procedure DDFEgobolist2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DDFEgobolist2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DDFEgoboedit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure goboselectbox2Select(Sender: TObject);
    procedure gobovalueedit2Change(Sender: TObject);
    procedure gobovalueendedit2Change(Sender: TObject);
    procedure PngBitBtn16Click(Sender: TObject);
    procedure PngBitBtn17Click(Sender: TObject);
    procedure standardfunktionenDropDown(Sender: TObject);
    procedure standardfunktionenCloseUp(Sender: TObject);
    procedure spezialfunktionenSelect(Sender: TObject);
    procedure autoddfbtnClick(Sender: TObject);
    procedure TBItem23Click(Sender: TObject);
    procedure channelfadeboxClick(Sender: TObject);
  private
    { Private-Deklarationen }
    CurrentFileName:string;
    ScanGobosForOpen:boolean;
    argumente:TJvInterpreterArgs;
    Red,Green,Blue:byte;
    Labels: array of TLabel;
    Edits: array of TEdit;
    Buttons: array of TButton;
    CheckBoxs: array of TCheckBox;
    Radiobuttons: array of TRadioGroup;
    ComboBoxs: array of TmbXPImageCombobox;//TComboBox;
    ComboBoxsImageList: array of TImageList;
    Sliders: array of TScrollbar;
    Progressbars: array of TProgressBar;
    Shapes: array of TShape;
    channels: array of Tchannels;
    functions: array of Tfunctions;
    colors: array of Tcolors;
    colors2: array of Tcolors;
    gobos: array of Tgobos;
    gobos2: array of Tgobos;
    globalevariablen:string;
    Colorpickerchannel:array[0..2] of Word;
    editproperties:array of Teditproperties;
    buttonproperties:array of Tbuttonproperties;
    checkboxproperties:array of Tcheckboxproperties;
    radiobuttonproperties:array of Tradiobuttonproperties;
    comboboxproperties:array of Tcomboboxproperties;
    sliderproperties:array of Tsliderproperties;

    LastSelectedComponent:TComponentName;
    Bmp : TImage;
    DDFEgobolistindex, DDFEgobolist2index:integer;
  public
    { Public-Deklarationen }
  end;

var
  ddfeditorform: Tddfeditorform;

implementation

uses PCDIMMER, devicepicturechangefrm, compileerrorfrm,
  geraetesteuerungfrm;

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

//RegComponents: A simple recursive procedure which registers with SizeCtrl1
//all the visible controls contained by aParent except 'tagged' controls ...
procedure RegComponents(aParent: TWinControl; SizeCtrl: TSizeCtrl);
var
  i: integer;
begin
  for i := 0 to aParent.ControlCount -1 do
  begin
    //In this demo, Tag <> 0 prevents a control becoming a SizeCtrl target ...
    if aParent.Controls[i].Tag = 0 then
      SizeCtrl.RegisterControl(aParent.Controls[i]);
    if aParent.Controls[i] is TWinControl then
      RegComponents(TWinControl(aParent.Controls[i]), SizeCtrl);
  end;
end;
//------------------------------------------------------------------------------

procedure UnregComponents(aParent: TWinControl; SizeCtrl: TSizeCtrl);
var
  i: integer;
begin
  for i := 0 to aParent.ControlCount -1 do
  begin
    SizeCtrl.UnRegisterControl(aParent.Controls[i]);
    if aParent.Controls[i] is TWinControl then
      UnregComponents(TWinControl(aParent.Controls[i]), SizeCtrl);
  end;
end;
//------------------------------------------------------------------------------

procedure Tddfeditorform.sizecontrolcheckedClick(Sender: TObject);
begin
  SizeCtrl.Enabled := sizecontrolchecked.Checked;

  //Now, just in case the visible controls have changed (ie a new Tabsheet was
  //made visible) while SizeCtrl was disabled ...
  if sizecontrolchecked.Checked then
  begin
    //make sure the right controls on the PageControl are registered ...
    UnRegComponents(Panel1, SizeCtrl);
    RegComponents(Panel1, SizeCtrl);
  end;
  ActiveControl := nil;
  invalidate; //fixup grid painting on the form

  CreateCode;
end;

procedure Tddfeditorform.TBItem8Click(Sender: TObject);
begin
  setlength(Labels,length(Labels)+1);
  labels[length(labels)-1]:=TLabel.Create(labels[length(labels)-1]);
  labels[length(labels)-1].Parent:=panel1;
  labels[length(labels)-1].Caption:='Label';
  labels[length(labels)-1].Name:='Label'+inttostr(length(labels))+'_'+inttostr(Random(1000));
  labels[length(labels)-1].Top:=80;
  RefreshSelection;
end;

procedure Tddfeditorform.TBItem7Click(Sender: TObject);
begin
  setlength(edits,length(edits)+1);
  setlength(editproperties,length(editproperties)+1);
  edits[length(edits)-1]:=TEdit.Create(edits[length(edits)-1]);
  edits[length(edits)-1].Parent:=panel1;
  edits[length(edits)-1].Text:='Editbox';
  edits[length(edits)-1].Name:='Editbox'+inttostr(length(edits))+'_'+inttostr(Random(1000));
  edits[length(edits)-1].Top:=80;
  RefreshSelection;
end;

procedure Tddfeditorform.TBItem6Click(Sender: TObject);
begin
  setlength(buttons,length(buttons)+1);
  setlength(buttonproperties,length(buttonproperties)+1);
  buttons[length(buttons)-1]:=TButton.Create(buttons[length(buttons)-1]);
  buttons[length(buttons)-1].Parent:=panel1;
  buttons[length(buttons)-1].Caption:='Button';
  buttons[length(buttons)-1].Name:='Button'+inttostr(length(buttons))+'_'+inttostr(Random(1000));
  buttons[length(buttons)-1].Top:=80;
  RefreshSelection;
end;

procedure Tddfeditorform.TBItem5Click(Sender: TObject);
begin
  setlength(checkboxs,length(checkboxs)+1);
  setlength(checkboxproperties,length(checkboxproperties)+1);
  checkboxs[length(checkboxs)-1]:=TCheckbox.Create(checkboxs[length(checkboxs)-1]);
  checkboxs[length(checkboxs)-1].Parent:=panel1;
  checkboxs[length(checkboxs)-1].Caption:='Checkbox';
  checkboxs[length(checkboxs)-1].Name:='Checkbox'+inttostr(length(checkboxs))+'_'+inttostr(Random(1000));
  checkboxs[length(checkboxs)-1].Top:=80;
  RefreshSelection;
end;

procedure Tddfeditorform.TBItem9Click(Sender: TObject);
begin
  setlength(radiobuttons,length(radiobuttons)+1);
  setlength(radiobuttonproperties,length(radiobuttonproperties)+1);
  radiobuttons[length(radiobuttons)-1]:=TRadiogroup.Create(radiobuttons[length(radiobuttons)-1]);
  radiobuttons[length(radiobuttons)-1].Parent:=panel1;
  radiobuttons[length(radiobuttons)-1].Caption:='Radiobutton';
  radiobuttons[length(radiobuttons)-1].Name:='Radiobutton'+inttostr(length(radiobuttons))+'_'+inttostr(Random(1000));
  RefreshSelection;
end;

procedure Tddfeditorform.TBItem4Click(Sender: TObject);
begin
  setlength(comboboxs,length(comboboxs)+1);
  setlength(ComboboxsImageList,length(ComboboxsImageList)+1);
  setlength(comboboxproperties,length(comboboxproperties)+1);
  comboboxs[length(comboboxs)-1]:=TmbXPImageCombobox.Create(comboboxs[length(comboboxs)-1]);//TCombobox.Create(comboboxs[length(comboboxs)-1]);
  comboboxs[length(comboboxs)-1].Parent:=panel1;
  comboboxs[length(comboboxs)-1].Name:='Combobox'+inttostr(length(comboboxs))+'_'+inttostr(Random(1000));
  comboboxs[length(comboboxs)-1].Top:=80;
  ComboboxsImageList[length(ComboboxsImageList)-1]:=TImageList.Create(self);
  RefreshSelection;
end;

procedure Tddfeditorform.TBItem3Click(Sender: TObject);
begin
  setlength(sliders,length(sliders)+1);
  setlength(sliderproperties,length(sliderproperties)+1);
  sliders[length(sliders)-1]:=TScrollbar.Create(sliders[length(sliders)-1]);
  sliders[length(sliders)-1].Parent:=panel1;
  sliders[length(sliders)-1].Name:='Slider'+inttostr(length(sliders))+'_'+inttostr(Random(1000));
  sliders[length(sliders)-1].Top:=80;
  sliders[length(sliders)-1].Min:=0;
  sliders[length(sliders)-1].Max:=255;
  RefreshSelection;
end;

procedure Tddfeditorform.TBItem2Click(Sender: TObject);
begin
  Colorpicker.visible:=true;
  setlength(functions,length(functions)+1);
  functions[length(functions)-1].name:='ColorPickerChange(R, G, B: Byte)';
  functions[length(functions)-1].functext:='  begin'+#13#10+'    set_color(''r'',''g'',''b'',0,0);'+#13#10+'  end;';
  RefreshSelection;
end;

procedure Tddfeditorform.TBItem10Click(Sender: TObject);
begin
  setlength(shapes,length(shapes)+1);
  shapes[length(shapes)-1]:=TShape.Create(shapes[length(shapes)-1]);
  shapes[length(shapes)-1].Parent:=panel1;
  shapes[length(shapes)-1].Name:='Line'+inttostr(length(shapes))+'_'+inttostr(Random(1000));
  shapes[length(shapes)-1].Width:=150;
  shapes[length(shapes)-1].Height:=2;
  shapes[length(shapes)-1].Top:=80;
  RefreshSelection;
end;

procedure Tddfeditorform.TBItem1Click(Sender: TObject);
begin
  fadenkreuz.Visible:=true;
  setlength(functions,length(functions)+1);
  functions[length(functions)-1].name:='PositionXYChange(Top, Left: Integer)';
//  functions[length(functions)-1].functext:='  begin'+#13#10+'    if panmirror.checked then'+#13#10+'      set_channel(''pan'',255-((PositionXY.Left+(PositionXY.Width div 2))/fadenkreuz.Width)*255,255-((PositionXY.Left+(PositionXY.Width div 2))/fadenkreuz.Width)*255,0)'+#13#10+'    else'+#13#10+'      set_channel(''pan'',((PositionXY.Left+(PositionXY.Width div 2))/fadenkreuz.Width)*255,((PositionXY.Left+(PositionXY.Width div 2))/fadenkreuz.Width)*255,0);'+#13#10+'  if tiltmirror.checked then'+#13#10+'      set_channel(''tilt'',255-((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255,255-((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255,0)'+#13#10+'    else'+#13#10+'      set_channel(''tilt'',((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255,((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255,0);'+#13#10+'  end;';
  functions[length(functions)-1].functext:='  var'+#13#10+'	phi,r,x,y:Double;'+#13#10+'	pan, tilt, panfine, tiltfine:Double;'+#13#10+'  begin'+#13#10+'	if usemhcontrol.checked then'+#13#10+'	begin'+#13#10+'		// Moving-Head-Steuerung (Polarkoordinaten)'+#13#10+'		x:=((PositionXY.Left+(PositionXY.Width div 2)-(fadenkreuz.Width/2))/fadenkreuz.Width)*2;	//-1..0..1'+#13#10+
'		y:=((PositionXY.Top+(PositionXY.Height div 2)-(fadenkreuz.Width/2))/fadenkreuz.Height)*2;	//-1..0..1'+#13#10+'		r:=sqrt(x*x+y*y);'+#13#10+'	'+#13#10+'		if (r>0) then'+#13#10+'		begin'+#13#10+'			if (y>=0) then'+#13#10+'				phi:=arccos(x/r)'+#13#10+'			else'+#13#10+'				phi:=6.283185307179586476925286766559-arccos(x/r);'+#13#10+
'		end else'+#13#10+'			phi:=64;'+#13#10+'		'+#13#10+'		r:=128-((r/2)*255);'+#13#10+'		phi:=(phi/6.283185307179586476925286766559)*255;'+#13#10+'		if 64>=phi then'+#13#10+'			phi:=phi+191'+#13#10+'		else'+#13#10+'			phi:=phi-64;'+#13#10+'	'+#13#10+'		pan:=255-phi;'+#13#10+'		tilt:=255-r;'+#13#10+'	end else'+#13#10+'	begin'+#13#10+
'		// Scannersteuerung (Kartesische Koordinaten)'+#13#10+'		pan:=((PositionXY.Left+(PositionXY.Width div 2))/fadenkreuz.Width)*255;'+#13#10+'		tilt:=((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255;'+#13#10+'	end;'+#13#10+''+#13#10+'	// Ausgabe'+#13#10+'	if panmirror.checked then'+#13#10+'	begin'+#13#10+'		dontrefresh:=true;'+#13#10+
'		set_channel(''pan'',trunc(255-pan),trunc(255-pan),0);'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''panfine'',trunc(frac(255-pan)*255),trunc(frac(255-pan)*255),0);'+#13#10+'	end	else'+#13#10+'	begin'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''pan'',trunc(pan),trunc(pan),0);'+#13#10+'		dontrefresh:=true;'+#13#10+
'		set_channel(''panfine'',trunc(frac(pan)*255),trunc(frac(pan)*255),0);'+#13#10+'	end;'+#13#10+'	if tiltmirror.checked then'+#13#10+'	begin'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''tilt'',trunc(255-tilt),trunc(255-tilt),0);'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''tiltfine'',trunc(frac(255-tilt)*255),trunc(frac(255-tilt)*255),0);'+#13#10+
'	end	else'+#13#10+'	begin'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''tilt'',trunc(tilt),trunc(tilt),0);'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''tiltfine'',trunc(frac(tilt)*255),trunc(frac(tilt)*255),0);'+#13#10+'	end;'+#13#10+'  end;';
  RefreshSelection;
end;

procedure Tddfeditorform.TBItem11Click(Sender: TObject);
begin
  deviceimage.visible:=true;
  devicename.Visible:=true;
  deviceadress.Visible:=true;
  RefreshSelection;
end;

procedure Tddfeditorform.RefreshSelection;
begin
  UnRegComponents(Panel1,SizeCtrl);
//  RegComponents(Panel1,SizeCtrl);

//  ActiveControl := nil;
//  invalidate; //fixup grid painting on the form
  sizecontrolcheckedclick(nil);
end;

procedure Tddfeditorform.FormResize(Sender: TObject);
begin
  SizeCtrl.Update;
end;

procedure Tddfeditorform.FormPaint(Sender: TObject);
var
  i,j: integer;
begin
  if SizeCtrl.Enabled then
    for i := 0 to width div SizeCtrl.GridSize do
      for j := 0 to height div SizeCtrl.GridSize do
        canvas.Pixels[i*SizeCtrl.GridSize, Panel1.Top+j*SizeCtrl.GridSize] := clGray;
end;

procedure Tddfeditorform.SizeCtrlTargetChange(Sender: TObject);
var
  i,j:integer;
begin
  RefreshSettings;
  
  if SizeCtrl.TargetCount = 0 then exit;

  PageControl1.TabIndex:=2;

  komponentennameedit.Visible:=true;
  textedit.Visible:=true;
  funktionsliste2.Visible:=true;
  name2lbl.Visible:=true;
  textlbl.Visible:=true;
  funktionlbl.Visible:=true;
  itemlistbox.visible:=false;
  itemnameedit.visible:=false;
  itemvalueedit.visible:=false;
  itemvalueendedit.visible:=false;
  PngBitBtn6.Visible:=false;
  PngBitBtn7.Visible:=false;
  minvaluespin.Visible:=false;
  maxvaluespin.Visible:=false;
  defaultvaluespin.Visible:=false;
  name2lbl.Caption:='Name:';
  textlbl.Caption:='Text:';
  itemslbl.Visible:=false;
  itemtextlbl.Visible:=false;
  itemvaluelbl.Visible:=false;
  bildlbl.Visible:=false;
  itempicture.Visible:=false;
  mbXPImageComboBox1.Visible:=false;
{
  bildedt.Visible:=False;
  bildchange.Visible:=false;
}

  if SizeCtrl.TargetCount = 0 then
    StatusBar1.SimpleText := _('Letztes Objekt: ')+LastSelectedComponent
  else
  begin
    with SizeCtrl.Targets[0] do
      StatusBar1.SimpleText:=format('  %s -  left:%d  top:%d, width:%d  height:%d',[Name,left,top,width,height]);

    if SizeCtrl.Targets[0].Name<>'' then
      LastSelectedComponent:=SizeCtrl.Targets[0].Name;

    komponentennameedit.text:=SizeCtrl.Targets[0].Name;
    for i:=0 to length(labels)-1 do
    begin
      if labels[i].name=SizeCtrl.Targets[0].Name then
      begin
        textedit.Text:=labels[i].caption;
      end;
    end;
    for i:=0 to length(edits)-1 do
    begin
      if edits[i].name=SizeCtrl.Targets[0].Name then
      begin
        textedit.Text:=edits[i].Text;
        for j:=0 to funktionsliste2.Items.count-1 do
          if editproperties[i].actionname=funktionsliste2.Items[j] then
            funktionsliste2.ItemIndex:=j;
      end;
    end;
    for i:=0 to length(checkboxs)-1 do
    begin
      if checkboxs[i].name=SizeCtrl.Targets[0].Name then
      begin
        textedit.Text:=checkboxs[i].caption;
        for j:=0 to funktionsliste2.Items.count-1 do
          if checkboxproperties[i].actionname=funktionsliste2.Items[j] then
            funktionsliste2.ItemIndex:=j;
      end;
    end;
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=SizeCtrl.Targets[0].Name then
      begin
        itemlistbox.visible:=true;
        itemnameedit.visible:=true;
//        itemvalueedit.visible:=true;
//        itemvalueendedit.visible:=true;
        PngBitBtn6.Visible:=true;
        PngBitBtn7.Visible:=true;
        itemslbl.Visible:=true;
        itemtextlbl.Visible:=true;
//        itemvaluelbl.Visible:=true;

        for j:=0 to funktionsliste2.Items.count-1 do
          if comboboxproperties[i].actionname=funktionsliste2.Items[j] then
            funktionsliste2.ItemIndex:=j;
        itemlistbox.Items.Clear;
        for j:=0 to comboboxs[i].items.count-1 do
          itemlistbox.Items.Add(comboboxs[i].items[j]);

        bildlbl.Visible:=true;
        itempicture.Visible:=true;
        mbXPImageComboBox1.Visible:=true;
{
        bildedt.Visible:=true;
        bildchange.Visible:=true;
}
      end;
    end;
    for i:=0 to length(sliders)-1 do
    begin
      if sliders[i].name=SizeCtrl.Targets[0].Name then
      begin
        minvaluespin.Visible:=true;
        maxvaluespin.Visible:=true;
        defaultvaluespin.Visible:=true;
        textedit.Visible:=false;
        textlbl.Visible:=false;
        itemslbl.Caption:='Min / Max:';
        itemslbl.Visible:=true;
        itemtextlbl.Caption:='Position:';
        itemtextlbl.Visible:=true;
        minvaluespin.Value:=sliders[i].Min;
        maxvaluespin.Value:=sliders[i].Max;
        defaultvaluespin.Value:=sliders[i].Position;

        for j:=0 to funktionsliste2.Items.count-1 do
          if sliderproperties[i].actionname=funktionsliste2.Items[j] then
            funktionsliste2.ItemIndex:=j;
      end;
    end;
    for i:=0 to length(progressbars)-1 do
    begin
      if progressbars[i].name=SizeCtrl.Targets[0].Name then
      begin
        minvaluespin.Visible:=true;
        maxvaluespin.Visible:=true;
        defaultvaluespin.Visible:=true;
        textedit.Visible:=false;
        textlbl.Visible:=false;
        itemslbl.Caption:='Min / Max:';
        itemslbl.Visible:=true;
        itemtextlbl.Caption:='Position:';
        itemtextlbl.Visible:=true;
        minvaluespin.Value:=progressbars[i].Min;
        maxvaluespin.Value:=progressbars[i].Max;
        defaultvaluespin.Value:=progressbars[i].Position;
      end;
    end;
    for i:=0 to length(buttons)-1 do
    begin
      if buttons[i].name=SizeCtrl.Targets[0].Name then
      begin
        textedit.Text:=buttons[i].caption;
        for j:=0 to funktionsliste2.Items.count-1 do
          if buttonproperties[i].actionname=funktionsliste2.Items[j] then
            funktionsliste2.ItemIndex:=j;
      end;
    end;
    for i:=0 to length(radiobuttons)-1 do
    begin
      if radiobuttons[i].name=SizeCtrl.Targets[0].Name then
      begin
        itemlistbox.visible:=true;
        itemnameedit.visible:=true;
//        itemvalueedit.visible:=true;
//        itemvalueendedit.visible:=true;
        PngBitBtn6.Visible:=true;
        PngBitBtn7.Visible:=true;
        itemslbl.Visible:=true;
        itemtextlbl.Visible:=true;
//        itemvaluelbl.Visible:=true;

        for j:=0 to funktionsliste2.Items.count-1 do
          if radiobuttonproperties[i].actionname=funktionsliste2.Items[j] then
            funktionsliste2.ItemIndex:=j;
        itemlistbox.Items.Clear;
        for j:=0 to radiobuttons[i].items.count-1 do
          itemlistbox.Items.Add(radiobuttons[i].items[j]);
      end;
    end;
    if (SizeCtrl.Targets[0].Name='ColorBox') or
        (SizeCtrl.Targets[0].Name='ColorBox2') or
        (SizeCtrl.Targets[0].Name='ColorPicker') or
        (SizeCtrl.Targets[0].Name='PositionXY') or
        (SizeCtrl.Targets[0].Name='deviceimage') or
        (SizeCtrl.Targets[0].Name='devicename') or
        (SizeCtrl.Targets[0].Name='deviceadress') or
        (SizeCtrl.Targets[0].Name='panmirror') or
        (SizeCtrl.Targets[0].Name='tiltmirror') or
        (SizeCtrl.Targets[0].Name='fadenkreuz') then
    begin
      komponentennameedit.Visible:=false;
      textedit.Visible:=false;
      funktionsliste2.Visible:=false;
      name2lbl.Visible:=false;
      textlbl.Visible:=false;
      funktionlbl.Visible:=false;
    end;
  end;
end;

procedure Tddfeditorform.SizeCtrlDuringSizeMove(Sender: TObject; dx,
  dy: Integer; State: TSCState);
begin
  with SizeCtrl.Targets[0] do
    if State = scsMoving then
      StatusBar1.SimpleText := format('  %s -  left:%d  top:%d, width:%d  height:%d',
        [Name, left+dx, top+dy, width, height])
    else {State = scsSizing}
      StatusBar1.SimpleText := format('  %s -  left:%d  top:%d, width:%d  height:%d',
        [Name,left, top, width+dx, height+dy]);
end;

procedure Tddfeditorform.SizeCtrlEndSizeMove(Sender: TObject;
  State: TSCState);
begin
  with SizeCtrl do
    if TargetCount = 0 then StatusBar1.SimpleText := ''
    else with Targets[0] do StatusBar1.SimpleText :=
      format('  %s -  left:%d  top:%d, width:%d  height:%d',
        [Name,left,top,width,height]);
end;

procedure Tddfeditorform.GerteeinstellungenalsXMLspeichern1Click(
  Sender: TObject);
begin
  SaveDialog1.InitialDir:=mainform.pcdimmerdirectory+'Devices';
  if Savedialog1.Execute then
  begin
    CreateXMLDDF;
    CurrentFileName:=Savedialog1.Filename;
    if FileExists(Savedialog1.FileName) then
    begin
      if not DirectoryExists(mainform.userdirectory+'Devices\Backup') then
        CreateDir(mainform.userdirectory+'Devices\Backup');
      CopyFile(PCHar(Savedialog1.FileName),PChar(mainform.userdirectory+'Devices\Backup\~'+ExtractFileName(Savedialog1.FileName)),false);
    end;
    Memo1.Lines.SaveToFile(Savedialog1.FileName);
  end;
end;

procedure Tddfeditorform.CreateXMLDDF;
var
  i,j:integer;
  fade:string;
  tmp:string;
begin
  memo1.Lines.clear;
  memo1.Lines.Add('<?xml version="1.0" encoding="ISO-8859-1"?>');
  memo1.Lines.Add('<device image="64 x 64\'+bildedit.Text+'">');
  memo1.Lines.Add(' <information id="PC_DIMMER">');
  memo1.Lines.Add(' <name>'+nameedit.Text+'</name>');
  memo1.Lines.Add(' <vendor>'+vendoredit.Text+'</vendor>');
  memo1.Lines.Add(' <author>'+autoredit.Text+'</author>');
  memo1.Lines.Add(' <description>'+beschreibungedit.Text+'</description>');
  memo1.Lines.Add(' </information>');
  memo1.Lines.Add(' <channels>');
  for i:=0 to length(channels)-1 do
  begin
    if channels[i].fade then fade:='yes' else fade:='no';
    memo1.Lines.Add('  <function channel="'+inttostr(i)+'" minvalue="'+inttostr(channels[i].minvalue)+'" maxvalue="'+inttostr(channels[i].maxvalue)+'" name="'+channels[i].name+'" fade="'+fade+'" type="'+lowercase(channels[i].typ)+'"/>');
  end;
  memo1.Lines.Add(' </channels>');

  tmp:='';
  if UseAmberMixingCheck.Checked then
    tmp:='UseAmberMixing="yes"'
  else
    tmp:='UseAmberMixing="no"';
  if AmberMixingCompensateRGCheck.Checked then
    tmp:=tmp+' AmberMixingCompensateRG="yes"'
  else
    tmp:=tmp+' AmberMixingCompensateRG="no"';
  if AmbermixingCompensateBlueCheck.Checked then
    tmp:=tmp+' AmberMixingCompensateBlue="yes"'
  else
    tmp:=tmp+' AmberMixingCompensateBlue="no"';
  tmp:=tmp+' AmberColorR="'+inttostr(round(AmberratioRbox.Value))+'"'+'AmberColorG="'+inttostr(round(AmberratioGbox.Value))+'"';
  memo1.Lines.Add(' <amber '+tmp+' />');

  tmp:='';
  for i:=0 to length(channels)-1 do
  begin
    if tmp='' then
      tmp:='ch'+inttostr(i)+'="'+inttostr(channels[i].initvalue)+'"'
    else
      tmp:=tmp+' ch'+inttostr(i)+'="'+inttostr(channels[i].initvalue)+'"';
  end;
  memo1.Lines.Add(' <initvalues '+tmp+' />');

  if length(colors)>0 then
  begin
    memo1.Lines.Add(' <colors>');
    for i:=0 to length(colors)-1 do
    begin
      memo1.Lines.Add('  <color name="'+colors[i].name+'" value="'+inttostr(colors[i].value)+'" valueend="'+inttostr(colors[i].valueend)+'" r="'+inttostr(colors[i].R)+'" g="'+inttostr(colors[i].g)+'" b="'+inttostr(colors[i].b)+'" />');
    end;
    memo1.Lines.Add(' </colors>');
  end;

  if length(colors2)>0 then
  begin
    memo1.Lines.Add(' <colors2>');
    for i:=0 to length(colors2)-1 do
    begin
      memo1.Lines.Add('  <color2 name="'+colors2[i].name+'" value="'+inttostr(colors2[i].value)+'" valueend="'+inttostr(colors2[i].valueend)+'" r="'+inttostr(colors2[i].R)+'" g="'+inttostr(colors2[i].g)+'" b="'+inttostr(colors2[i].b)+'" />');
    end;
    memo1.Lines.Add(' </colors2>');
  end;

  memo1.Lines.Add(' <shutter OpenValue="'+inttostr(round(shutteropenvalueedit.value))+'" CloseValue="'+inttostr(round(shutterclosevalueedit.value))+'" ChannelName="'+lowercase(shutterchannellist.Text)+'"/>');
  memo1.Lines.Add(' <strobe OffValue="'+inttostr(round(strobeoffvalueedit.value))+'" MinValue="'+inttostr(round(strobeminvalueedit.value))+'" MaxValue="'+inttostr(round(strobemaxvalueedit.value))+'" ChannelName="'+lowercase(strobochannellist.Text)+'"/>');
  memo1.Lines.Add(' <dimmer OffValue="'+inttostr(round(dimmeroffvalueedit.value))+'" MaxValue="'+inttostr(round(dimmermaxvalueedit.value))+'"/>');
  memo1.Lines.Add(' <gobo1rot LeftMinValue="'+inttostr(round(goborotleftminvalueedit.value))+'" LeftMaxValue="'+inttostr(round(goborotleftvalueedit.value))+'" OffValue="'+inttostr(round(goborotoffvalueedit.value))+'" RightMinValue="'+inttostr(round(goborotrightminvalueedit.value))+'" RightMaxValue="'+inttostr(round(goborotrightvalueedit.value))+'" ChannelName="'+lowercase(gobo1rotchlbox.Text)+'"/>');
  memo1.Lines.Add(' <gobo2rot LeftMinValue="'+inttostr(round(gobo2rotleftminvalueedit.value))+'" LeftMaxValue="'+inttostr(round(gobo2rotleftvalueedit.value))+'" OffValue="'+inttostr(round(gobo2rotoffvalueedit.value))+'" RightMinValue="'+inttostr(round(gobo2rotrightminvalueedit.value))+'" RightMaxValue="'+inttostr(round(gobo2rotrightvalueedit.value))+'" ChannelName="'+lowercase(gobo2rotchlbox.Text)+'"/>');
  memo1.Lines.Add(' <prismarot LeftMinValue="'+inttostr(round(prismarotleftminedit.value))+'" LeftMaxValue="'+inttostr(round(prismarotleftmaxedit.value))+'" OffValue="'+inttostr(round(prismarotstopedit.value))+'" RightMinValue="'+inttostr(round(prismarotrightminedit.value))+'" RightMaxValue="'+inttostr(round(prismarotrightmaxedit.value))+'" ChannelName="'+lowercase(prismarotchanneledit.Text)+'"/>');
  memo1.Lines.Add(' <prisma SingleValue="'+inttostr(round(prismaoffedit.value))+'" TripleValue="'+inttostr(round(prismatripleedit.value))+'"/>');
  memo1.Lines.Add(' <iris OpenValue="'+inttostr(round(irisopenedit.value))+'" CloseValue="'+inttostr(round(irisoffedit.value))+'" MinValue="'+inttostr(round(irisminedit.value))+'" MaxValue="'+inttostr(round(irismaxedit.value))+'"/>');

  if length(gobos)>0 then
  begin
    memo1.Lines.Add(' <gobos>');
    for i:=0 to length(gobos)-1 do
    begin
      memo1.Lines.Add('  <gobo name="'+gobos[i].name+'" value="'+inttostr(gobos[i].value)+'" valueend="'+inttostr(gobos[i].valueend)+'" filename="'+gobos[i].filename+'" />');
    end;
    memo1.Lines.Add(' </gobos>');
  end;

  if length(gobos2)>0 then
  begin
    memo1.Lines.Add(' <gobos2>');
    for i:=0 to length(gobos2)-1 do
    begin
      memo1.Lines.Add('  <gobo2 name="'+gobos2[i].name+'" value="'+inttostr(gobos2[i].value)+'" valueend="'+inttostr(gobos2[i].valueend)+'" filename="'+gobos2[i].filename+'" />');
    end;
    memo1.Lines.Add(' </gobos2>');
  end;

  memo1.Lines.Add(' <form width="'+inttostr(panel1.Width)+'" height="'+inttostr(panel1.height)+'">');
  if deviceimage.Visible then memo1.Lines.Add('  <deviceimage top="'+inttostr(deviceimage.Top)+'" left="'+inttostr(deviceimage.Left)+'" width="'+inttostr(deviceimage.Width)+'" height="'+inttostr(deviceimage.Height)+'"/>');
  if devicename.Visible then memo1.Lines.Add('  <devicename top="'+inttostr(devicename.Top)+'" left="'+inttostr(devicename.Left)+'"/>');
  if deviceadress.Visible then memo1.Lines.Add('  <deviceadress top="'+inttostr(deviceadress.Top)+'" left="'+inttostr(deviceadress.Left)+'"/>');
  if dipswitchpanel.Visible then memo1.Lines.Add('  <devicedipswitch top="'+inttostr(dipswitchpanel.Top)+'" left="'+inttostr(dipswitchpanel.Left)+'"/>');
  if colorpicker.Visible then memo1.Lines.Add('  <colorpicker top="'+inttostr(colorpicker.Top)+'" left="'+inttostr(colorpicker.left)+'" />');
  if fadenkreuz.Visible then memo1.Lines.Add('  <position top="'+inttostr(fadenkreuz.Top)+'" left="'+inttostr(fadenkreuz.Left)+'" height="'+inttostr(fadenkreuz.Height)+'" width="'+inttostr(fadenkreuz.Width)+'" />');
  if colorbox.Visible then memo1.Lines.Add('  <colorbox top="'+inttostr(colorbox.Top)+'" left="'+inttostr(colorbox.Left)+'" height="'+inttostr(colorbox.Height)+'" width="'+inttostr(colorbox.Width)+'" />');
  if colorbox2.Visible then memo1.Lines.Add('  <colorbox2 top="'+inttostr(colorbox2.Top)+'" left="'+inttostr(colorbox2.Left)+'" height="'+inttostr(colorbox2.Height)+'" width="'+inttostr(colorbox2.Width)+'" />');
//    memo1.Lines.Add('  <edit name="" top="" left="" width="" height="" text="" action="" caption="" startvalue="" endvalue="" default=""/>');
  for i:=0 to length(edits)-1 do
  begin
    if edits[i].visible then
      memo1.Lines.Add('  <edit name="'+edits[i].name+'" top="'+inttostr(edits[i].top)+'" left="'+inttostr(edits[i].left)+'" width="'+inttostr(edits[i].width)+'" height="'+inttostr(edits[i].Height)+'" text="'+edits[i].text+'" action="'+editproperties[i].actionname+'"/>');
  end;
  for i:=0 to length(checkboxs)-1 do
  begin
    if checkboxs[i].Checked then tmp:='true' else tmp:='false';
    if checkboxs[i].visible then
      memo1.Lines.Add('  <checkbox name="'+checkboxs[i].name+'" top="'+inttostr(checkboxs[i].top)+'" left="'+inttostr(checkboxs[i].left)+'" width="'+inttostr(checkboxs[i].width)+'" height="'+inttostr(checkboxs[i].Height)+'" caption="'+checkboxs[i].caption+'" action="'+checkboxproperties[i].actionname+'" checked="'+tmp+'"/>');
  end;
  for i:=0 to length(comboboxs)-1 do
  begin
    if comboboxs[i].visible then
    begin
      memo1.Lines.Add('  <dropdown name="'+comboboxs[i].name+'" top="'+inttostr(comboboxs[i].top)+'" left="'+inttostr(comboboxs[i].left)+'" width="'+inttostr(comboboxs[i].width)+'" height="'+inttostr(comboboxs[i].Height)+'" action="'+comboboxproperties[i].actionname+'">');
      for j:=0 to comboboxs[i].Items.count-1 do
      begin
        memo1.Lines.Add('   <item caption="'+comboboxs[i].Items[j]+'" value="'+inttostr(comboboxproperties[i].itemvalue[j])+'" valueend="'+inttostr(comboboxproperties[i].itemvalueend[j])+'" picture="'+comboboxproperties[i].picture[j]+'" />');
      end;
      memo1.Lines.Add('  </dropdown>');
    end;
  end;
  for i:=0 to length(sliders)-1 do
  begin
    if sliders[i].visible then
      memo1.Lines.Add('  <slider name="'+sliders[i].name+'" top="'+inttostr(sliders[i].top)+'" left="'+inttostr(sliders[i].left)+'" width="'+inttostr(sliders[i].width)+'" height="'+inttostr(sliders[i].Height)+'" action="'+sliderproperties[i].actionname+'" startvalue="'+inttostr(sliders[i].Min)+'" endvalue="'+inttostr(sliders[i].Max)+'" default="'+inttostr(sliders[i].Position)+'"/>');
  end;
  for i:=0 to length(labels)-1 do
  begin
    if labels[i].visible then
      memo1.Lines.Add('  <label name="'+labels[i].name+'" top="'+inttostr(labels[i].top)+'" left="'+inttostr(labels[i].left)+'" width="'+inttostr(labels[i].width)+'" height="'+inttostr(labels[i].Height)+'" caption="'+labels[i].caption+'"/>');
  end;
  for i:=0 to length(shapes)-1 do
  begin
    if shapes[i].visible then
      memo1.Lines.Add('  <line name="'+shapes[i].name+'" top="'+inttostr(shapes[i].top)+'" left="'+inttostr(shapes[i].left)+'" width="'+inttostr(shapes[i].width)+'" height="'+inttostr(shapes[i].Height)+'"/>');
  end;
  for i:=0 to length(progressbars)-1 do
  begin
    if progressbars[i].visible then
      memo1.Lines.Add('  <progressbar name="'+progressbars[i].name+'" top="'+inttostr(progressbars[i].top)+'" left="'+inttostr(progressbars[i].left)+'" width="'+inttostr(progressbars[i].width)+'" height="'+inttostr(progressbars[i].Height)+'" startvalue="'+inttostr(progressbars[i].Min)+'" endvalue="'+inttostr(progressbars[i].Max)+'" default="'+inttostr(progressbars[i].Position)+'"/>');
  end;
  for i:=0 to length(buttons)-1 do
  begin
    if buttons[i].visible then
      memo1.Lines.Add('  <button name="'+buttons[i].name+'" top="'+inttostr(buttons[i].top)+'" left="'+inttostr(buttons[i].left)+'" width="'+inttostr(buttons[i].width)+'" height="'+inttostr(buttons[i].Height)+'" action="'+buttonproperties[i].actionname+'" caption="'+buttons[i].Caption+'"/>');
  end;
  for i:=0 to length(radiobuttons)-1 do
  begin
    if radiobuttons[i].visible then
    begin
      memo1.Lines.Add('  <options name="'+radiobuttons[i].name+'" top="'+inttostr(radiobuttons[i].top)+'" left="'+inttostr(radiobuttons[i].left)+'" width="'+inttostr(radiobuttons[i].width)+'" height="'+inttostr(radiobuttons[i].Height)+'" action="'+radiobuttonproperties[i].actionname+'" caption="'+radiobuttons[i].Caption+'">');
      for j:=0 to radiobuttons[i].Items.count-1 do
      begin
        memo1.Lines.Add('   <item caption="'+radiobuttons[i].Items[j]+'" value="'+inttostr(radiobuttonproperties[i].itemvalue[j])+'" valueend="'+inttostr(radiobuttonproperties[i].itemvalueend[j])+'" />');
      end;
      memo1.Lines.Add('  </options>');
    end;
  end;
  memo1.Lines.Add(' </form>');
  memo1.Lines.Add(' <code>');
  memo1.Lines.Add('  unit '+unitnameedit.Text+';');
  memo1.Lines.Add('');
  memo1.Lines.Add('  interface');
  memo1.Lines.Add('');
  for i:=0 to length(functions)-1 do
    memo1.Lines.Add('  procedure '+functions[i].name+';');
  memo1.Lines.Add('');
  memo1.Lines.Add('  implementation');

//  if globalevariablen<>'  var'+#13#10+'    // hier können globale Variablen definiert werden'+#13#10+'  DontRefresh:boolean;' then
  begin
    memo1.Lines.Add('');
    memo1.Lines.Add(globalevariablen);
    memo1.Lines.Add('');
  end;

  for i:=0 to length(functions)-1 do
  begin
    memo1.Lines.Add('  procedure '+functions[i].name+';');
//    memo1.Lines.Add('   begin');
    memo1.Lines.Add(functions[i].functext);
//    memo1.Lines.Add('   end;');
  end;
  memo1.Lines.Add('  end.');
  memo1.Lines.Add(' </code>');
  memo1.Lines.Add('</device>');
end;

procedure Tddfeditorform.CreateCode;
var
  i:integer;
begin
  memo1.Lines.clear;
  memo1.Lines.Add('  unit '+unitnameedit.Text+';');
  memo1.Lines.Add('');
  memo1.Lines.Add('  interface');
  memo1.Lines.Add('');
  for i:=0 to length(functions)-1 do
    memo1.Lines.Add('  procedure '+functions[i].name+';');
  memo1.Lines.Add('  implementation');
  memo1.Lines.Add('');

//  if globalevariablen<>'  var'+#13#10+'    // hier können globale Variablen definiert werden'+#13#10+'  DontRefresh:boolean;' then
  begin
    memo1.Lines.Add(globalevariablen);
    memo1.Lines.Add('');
  end;

  for i:=0 to length(functions)-1 do
  begin
    memo1.Lines.Add('  procedure '+functions[i].name+';');
//    memo1.Lines.Add('   begin');
    memo1.Lines.Add(functions[i].functext);
//    memo1.Lines.Add('   end;');
  end;
  memo1.Lines.Add('  end.');

  Scriptinterpreter.Pas:=memo1.Lines;
  Scriptinterpreter.Compile;
end;

procedure Tddfeditorform.PageControl1Change(Sender: TObject);
var
  SR: TSearchRec;
begin
  if pagecontrol1.TabIndex=4 then
    CreateXMLDDF;

  if ((pagecontrol1.TabIndex=1) or (pagecontrol1.TabIndex=2) or ScanGobosForOpen) and (mbXPImageComboBox1.Items.Count=0) then
  begin
    if (FindFirst(mainform.pcdimmerdirectory+'\Devicepictures\GobosSmall\*.bmp',faAnyFile-faDirectory,SR)=0) then
    begin
      repeat
        if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
        begin
          bmp.Picture.LoadFromFile(mainform.pcdimmerdirectory+'\Devicepictures\GobosSmall\'+SR.Name);
          ImageList1.Add(bmp.Picture.Bitmap, bmp.Picture.Bitmap);
          mbXPImageComboBox1.Items.Add(copy(SR.Name, 0, length(SR.Name)-4));
        end;
      until FindNext(SR)<>0;
      FindClose(SR);
    end;
    mbXPImageComboBox1.Images:=ImageList1;

    goboselectbox.Items:=mbXPImageComboBox1.Items;
    goboselectbox.Images:=ImageList1;
    goboselectbox2.Items:=mbXPImageComboBox1.Items;
    goboselectbox2.Images:=ImageList1;
  end;

  RefreshSettings;
end;

procedure Tddfeditorform.FormShow(Sender: TObject);
begin
  NeuesDDF1Click(nil);
end;

procedure Tddfeditorform.PngBitBtn1Click(Sender: TObject);
begin
  setlength(channels,length(channels)+1);
  channels[length(channels)-1].minvalue:=0;
  channels[length(channels)-1].maxvalue:=255;
  channels[length(channels)-1].initvalue:=-1;
  channels[length(channels)-1].name:='DIMMER';
  channels[length(channels)-1].fade:=true;
  channels[length(channels)-1].typ:='DIMMER';
  JvSpinEdit1.Value:=length(channels);
end;

procedure Tddfeditorform.RefreshSettings;
var
  i:integer;
begin
  // Grundlagen erneuern
  kanananzahlanzeigelbl.caption:=inttostr(length(channels));
  kanalnameedit.text:=channels[round(JvSpinEdit1.Value)-1].name;
  minvalueedit.value:=channels[round(JvSpinEdit1.Value)-1].minvalue;
  maxvalueedit.value:=channels[round(JvSpinEdit1.Value)-1].maxvalue;
  initvalueedit.value:=channels[round(JvSpinEdit1.Value)-1].initvalue;
  channelfadebox.checked:=channels[round(JvSpinEdit1.Value)-1].fade;
  for i:=0 to typliste.Items.Count-1 do
  begin
    if lowercase(typliste.Items[i])=lowercase(channels[round(JvSpinEdit1.Value)-1].typ) then
    begin
      typliste.ItemIndex:=i;
      typliste.Text:=typliste.Items[i];
    end;
  end;

  // Funktionsbox erneuern
  funktionsliste2.Items.Clear;
  funktionsliste2.Items.Add('');
  for i:=0 to length(functions)-1 do
    funktionsliste2.Items.add(functions[i].name);

  funktionsliste1.Items.Clear;
  for i:=0 to length(functions)-1 do
    funktionsliste1.Items.add(functions[i].name);
  funktionsliste1.Items.add('< Globale Variablen >');

  if funktionsliste1.Items.count>0 then
  begin
    funktionsliste1.ItemIndex:=0;
    Memo2.Text:=functions[funktionsliste1.ItemIndex].functext;
    funktionsnameedit.text:=functions[funktionsliste1.ItemIndex].name;
  end;
end;

procedure Tddfeditorform.JvSpinEdit1Change(Sender: TObject);
begin
  if round(JvSpinEdit1.Value)>length(channels) then
    JvSpinEdit1.Value:=length(channels);
  RefreshSettings;
end;

procedure Tddfeditorform.kanalnameeditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  channels[round(JvSpinEdit1.Value)-1].name:=kanalnameedit.text;
end;

procedure Tddfeditorform.typlisteSelect(Sender: TObject);
begin
  channels[round(JvSpinEdit1.Value)-1].typ:=typliste.Items[typliste.itemindex];
  channels[round(JvSpinEdit1.Value)-1].name:=typliste.Items[typliste.itemindex];
end;

procedure Tddfeditorform.PngBitBtn2Click(Sender: TObject);
begin
  if length(channels)>1 then
  begin
    JvSpinEdit1.Value:=length(channels)-1;
    setlength(channels,length(channels)-1);
  end else
  begin
    ShowMessage(_('Es muss mindestens ein Kanal in der Gerätedefinition vorhanden sein.'));
  end;
end;

procedure Tddfeditorform.PngBitBtn4Click(Sender: TObject);
begin
  setlength(functions,length(functions)+1);
  funktionsliste1.items.Insert(funktionsliste1.items.Count-1 ,'NeueFunktion');
  funktionsliste1.itemindex:=funktionsliste1.items.Count-2;
  funktionsnameedit.Text:='NeueFunktion';
  functions[length(functions)-1].name:='NeueFunktion';
  functions[length(functions)-1].functext:='//  var'+#13#10+'    // hier ist Platz für eigene Variablen (z.B. "temp: boolean;" oder "temp:string;")'+#13#10+'  begin'+#13#10+'    DontRefresh:=true;'+#13#10+#13#10+'    // bitte hier die eigene Funktion eintragen'+#13#10+'  end;';
  Memo2.lines.clear;
  Memo2.Text:=functions[length(functions)-1].functext;
end;

procedure Tddfeditorform.PngBitBtn5Click(Sender: TObject);
var
  i:integer;
begin
  if funktionsliste1.itemindex=funktionsliste1.items.count-1 then exit;

  if (funktionsliste1.ItemIndex<funktionsliste1.Items.Count-2) then
  begin
    for i:=funktionsliste1.ItemIndex to length(functions)-2 do
    begin
      functions[i].name:=functions[i+1].name;
      functions[i].functext:=functions[i+1].functext;
    end;
  end;
  setlength(functions,length(functions)-1);
  funktionsliste1.Items.Clear;
  for i:=0 to length(functions)-1 do
    funktionsliste1.Items.add(functions[i].name);
  funktionsliste1.Items.add('< Globale Variablen >');
  if funktionsliste1.Items.count>0 then
    funktionsliste1.ItemIndex:=0;
end;

procedure Tddfeditorform.funktionsliste1Select(Sender: TObject);
begin
  if funktionsliste1.ItemIndex=funktionsliste1.Items.Count-1 then
  begin
    memo2.Text:=globalevariablen;
    funktionsnameedit.text:='< Globale Variablen >';
  end else
  begin
    Memo2.Text:=functions[funktionsliste1.ItemIndex].functext;
    funktionsnameedit.text:=functions[funktionsliste1.ItemIndex].name;
  end;
end;

procedure Tddfeditorform.Memo2_oldKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  text:string;
  position:integer;
  tabwurdeentfernt:boolean;
begin
  if funktionsliste1.itemindex<0 then
  begin
    globalevariablen:=memo2.text;
    exit;
  end;

  functions[funktionsliste1.itemindex].functext:=Memo2.Text;

  position:=memo2.SelStart;
  tabwurdeentfernt:=false;
  while pos(#9,memo2.Text)>0 do
  begin
    text:=memo2.text;
    delete(text,pos(#9,memo2.Text),1);
    memo2.Text:=text;
    tabwurdeentfernt:=true;
  end;
  if tabwurdeentfernt then
    memo2.SelStart:=position-1;

  UnLockWindow(memo2.Handle);
end;

procedure Tddfeditorform.openpicturebtnClick(Sender: TObject);
var
  newpicturefile:string;
begin
  if pos('\',bildedit.text)>-1 then
    devicepicturechangeform.aktuellebilddatei:=copy(bildedit.text,Pos('\',bildedit.text)+1,length(bildedit.text));
  devicepicturechangeform.showmodal;

  if devicepicturechangeform.ModalResult=mrOK then
  begin
    newpicturefile:=devicepicturechangeform.aktuellebilddatei;
    if pos(mainform.pcdimmerdirectory+'Devicepictures\',newpicturefile)>-1 then
      newpicturefile:=copy(newpicturefile,length(mainform.pcdimmerdirectory+'Devicepictures\32 x 32\')+1,length(newpicturefile));
    bildedit.text:=newpicturefile;
  end;

  deviceimage.width:=64;
  deviceimage.height:=64;
  deviceimage.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\64 x 64\'+newpicturefile);
end;

procedure Tddfeditorform.funktionsliste2Select(Sender: TObject);
var
  i:integer;
begin
    for i:=0 to length(edits)-1 do
    begin
      if edits[i].name=LastSelectedComponent then
      begin
        editproperties[i].actionname:=funktionsliste2.Items[funktionsliste2.itemindex];
      end;
    end;
    for i:=0 to length(checkboxs)-1 do
    begin
      if checkboxs[i].name=LastSelectedComponent then
      begin
        checkboxproperties[i].actionname:=funktionsliste2.Items[funktionsliste2.itemindex];
      end;
    end;
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=LastSelectedComponent then
      begin
        comboboxproperties[i].actionname:=funktionsliste2.Items[funktionsliste2.itemindex];
      end;
    end;
    for i:=0 to length(sliders)-1 do
    begin
      if sliders[i].name=LastSelectedComponent then
      begin
        sliderproperties[i].actionname:=funktionsliste2.Items[funktionsliste2.itemindex];
      end;
    end;
    for i:=0 to length(buttons)-1 do
    begin
      if buttons[i].name=LastSelectedComponent then
      begin
        buttonproperties[i].actionname:=funktionsliste2.Items[funktionsliste2.itemindex];
      end;
    end;
    for i:=0 to length(radiobuttons)-1 do
    begin
      if radiobuttons[i].name=LastSelectedComponent then
      begin
        radiobuttonproperties[i].actionname:=funktionsliste2.Items[funktionsliste2.itemindex];
      end;
    end;
end;

procedure Tddfeditorform.texteditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
begin
    for i:=0 to length(labels)-1 do
    begin
      if labels[i].name=LastSelectedComponent then
      begin
        labels[i].caption:=textedit.text;
      end;
    end;
    for i:=0 to length(edits)-1 do
    begin
      if edits[i].name=LastSelectedComponent then
      begin
        edits[i].text:=textedit.text;
      end;
    end;
    for i:=0 to length(checkboxs)-1 do
    begin
      if checkboxs[i].name=LastSelectedComponent then
      begin
        checkboxs[i].caption:=textedit.text;
      end;
    end;
    for i:=0 to length(buttons)-1 do
    begin
      if buttons[i].name=LastSelectedComponent then
      begin
        buttons[i].caption:=textedit.text;
      end;
    end;
end;

procedure Tddfeditorform.PngBitBtn3Click(Sender: TObject);
var
  i,j:integer;
begin
  UnRegComponents(Panel1,SizeCtrl);

    for i:=0 to length(edits)-1 do
    begin
      if edits[i].name=LastSelectedComponent then
      begin
        edits[i].visible:=false;
      end;
    end;
    for i:=0 to length(checkboxs)-1 do
    begin
      if checkboxs[i].name=LastSelectedComponent then
      begin
        checkboxs[i].visible:=false;
      end;
    end;
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=LastSelectedComponent then
      begin
        comboboxs[i].visible:=false;
      end;
    end;
    for i:=0 to length(sliders)-1 do
    begin
      if sliders[i].name=LastSelectedComponent then
      begin
        sliders[i].visible:=false;
      end;
    end;
    for i:=0 to length(progressbars)-1 do
    begin
      if progressbars[i].name=LastSelectedComponent then
      begin
        progressbars[i].visible:=false;
      end;
    end;
    for i:=0 to length(buttons)-1 do
    begin
      if buttons[i].name=LastSelectedComponent then
      begin
        buttons[i].visible:=false;
      end;
    end;
    for i:=0 to length(shapes)-1 do
    begin
      if shapes[i].name=LastSelectedComponent then
      begin
        shapes[i].visible:=false;
      end;
    end;
    for i:=0 to length(labels)-1 do
    begin
      if labels[i].name=LastSelectedComponent then
      begin
        labels[i].visible:=false;
      end;
    end;
    for i:=0 to length(radiobuttons)-1 do
    begin
      if radiobuttons[i].name=LastSelectedComponent then
      begin
        radiobuttons[i].visible:=false;
      end;
    end;
    if colorpicker.Name=LastSelectedComponent then
    begin
      colorpicker.Visible:=false;

      j:=0;

      for i:=0 to length(functions)-1 do
        if functions[i].name='ColorPickerChange' then //CHANGED: (R, G, B: Byte)
          j:=i;

      if (j<funktionsliste1.Items.Count-1) then
      for i:=j to length(functions)-2 do
      begin
        functions[i].name:=functions[i+1].name;
        functions[i].functext:=functions[i+1].functext;
      end;
      setlength(functions,length(functions)-1);
      funktionsliste1.Items.Clear;
      for i:=0 to length(functions)-1 do
        funktionsliste1.Items.add(functions[i].name);
      funktionsliste1.Items.add('< Globale Variablen >');
      if funktionsliste1.Items.count>0 then
        funktionsliste1.ItemIndex:=0;
    end;
    if fadenkreuz.Name=LastSelectedComponent then
    begin
      fadenkreuz.Visible:=false;

      j:=0;
      for i:=0 to length(functions)-1 do
        if functions[i].name='PositionXYChange' then
          j:=i;

      if (j<funktionsliste1.Items.Count-1) then
      for i:=j to length(functions)-2 do
      begin
        functions[i].name:=functions[i+1].name;
        functions[i].functext:=functions[i+1].functext;
      end;
      setlength(functions,length(functions)-1);
      funktionsliste1.Items.Clear;
      for i:=0 to length(functions)-1 do
        funktionsliste1.Items.add(functions[i].name);
      funktionsliste1.Items.add('< Globale Variablen >');
      if funktionsliste1.Items.count>0 then
        funktionsliste1.ItemIndex:=0;
    end;
    if colorbox.Name=LastSelectedComponent then
    begin
      colorbox.Visible:=false;

      j:=0;
      for i:=0 to length(functions)-1 do
        if functions[i].name='ColorBoxChange' then
          j:=i;

      if (j<funktionsliste1.Items.Count-1) then
      for i:=j to length(functions)-2 do
      begin
        functions[i].name:=functions[i+1].name;
        functions[i].functext:=functions[i+1].functext;
      end;
      setlength(functions,length(functions)-1);
      funktionsliste1.Items.Clear;
      for i:=0 to length(functions)-1 do
        funktionsliste1.Items.add(functions[i].name);
      funktionsliste1.Items.add('< Globale Variablen >');
      if funktionsliste1.Items.count>0 then
        funktionsliste1.ItemIndex:=0;
    end;
    if colorbox2.Name=LastSelectedComponent then
    begin
      colorbox2.Visible:=false;

      j:=0;
      for i:=0 to length(functions)-1 do
        if functions[i].name='ColorBoxChange2' then
          j:=i;

      if (j<funktionsliste1.Items.Count-1) then
      for i:=j to length(functions)-2 do
      begin
        functions[i].name:=functions[i+1].name;
        functions[i].functext:=functions[i+1].functext;
      end;
      setlength(functions,length(functions)-1);
      funktionsliste1.Items.Clear;
      for i:=0 to length(functions)-1 do
        funktionsliste1.Items.add(functions[i].name);
      funktionsliste1.Items.add('< Globale Variablen >');
      if funktionsliste1.Items.count>0 then
        funktionsliste1.ItemIndex:=0;
    end;
    if deviceimage.Name=LastSelectedComponent then
      deviceimage.Visible:=false;
    if deviceadress.Name=LastSelectedComponent then
      deviceadress.Visible:=false;
    if devicename.Name=LastSelectedComponent then
      devicename.Visible:=false;
    if dipswitchpanel.Name=LastSelectedComponent then
      dipswitchpanel.Visible:=false;

  sizecontrolcheckedclick(nil);
end;

procedure Tddfeditorform.funktionsnameeditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
begin
  if funktionsliste1.itemindex<0 then exit;
  if funktionsliste1.ItemIndex=funktionsliste1.Items.Count-1 then exit;

  i:=funktionsliste1.itemindex;
  functions[funktionsliste1.itemindex].name:=funktionsnameedit.text;
  funktionsliste1.Items[funktionsliste1.itemindex]:=funktionsnameedit.text;
  funktionsliste1.itemindex:=i;
end;

procedure Tddfeditorform.komponentennameeditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
begin
//  if Key=vk_return then
  begin
    for i:=0 to length(labels)-1 do
    begin
      if labels[i].name=LastSelectedComponent then
      begin
        labels[i].name:=komponentennameedit.text;
        LastSelectedComponent:=labels[i].name;
      end;
    end;
    for i:=0 to length(edits)-1 do
    begin
      if edits[i].name=LastSelectedComponent then
      begin
        edits[i].name:=komponentennameedit.text;
        LastSelectedComponent:=edits[i].name;
      end;
    end;
    for i:=0 to length(checkboxs)-1 do
    begin
      if checkboxs[i].name=LastSelectedComponent then
      begin
        checkboxs[i].name:=komponentennameedit.text;
        LastSelectedComponent:=checkboxs[i].name;
      end;
    end;
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=LastSelectedComponent then
      begin
        comboboxs[i].name:=komponentennameedit.text;
        LastSelectedComponent:=comboboxs[i].name;
      end;
    end;
    for i:=0 to length(sliders)-1 do
    begin
      if sliders[i].name=LastSelectedComponent then
      begin
        sliders[i].name:=komponentennameedit.text;
        LastSelectedComponent:=sliders[i].name;
      end;
    end;
    for i:=0 to length(progressbars)-1 do
    begin
      if progressbars[i].name=LastSelectedComponent then
      begin
        progressbars[i].name:=komponentennameedit.text;
        LastSelectedComponent:=progressbars[i].name;
      end;
    end;
    for i:=0 to length(buttons)-1 do
    begin
      if buttons[i].name=LastSelectedComponent then
      begin
        buttons[i].name:=komponentennameedit.text;
        LastSelectedComponent:=buttons[i].name;
      end;
    end;
    for i:=0 to length(radiobuttons)-1 do
    begin
      if radiobuttons[i].name=LastSelectedComponent then
      begin
        radiobuttons[i].name:=komponentennameedit.text;
        LastSelectedComponent:=radiobuttons[i].name;
      end;
    end;
  end;
end;

procedure Tddfeditorform.NeuesDDF1Click(Sender: TObject);
var
  i:integer;
begin
  UnRegComponents(Panel1,SizeCtrl);

  for i:=0 to length(Labels)-1 do
    labels[i].free;
  for i:=0 to length(Edits)-1 do
    edits[i].free;
  for i:=0 to length(Buttons)-1 do
    buttons[i].free;
  for i:=0 to length(CheckBoxs)-1 do
    checkboxs[i].free;
  for i:=0 to length(Radiobuttons)-1 do
    radiobuttons[i].free;
  for i:=0 to length(ComboBoxs)-1 do
    comboboxs[i].free;
  for i:=0 to length(ComboboxsImageList)-1 do
    ComboboxsImageList[i].Free;
  for i:=0 to length(Sliders)-1 do
    sliders[i].free;
  for i:=0 to length(progressbars)-1 do
    progressbars[i].free;
  for i:=0 to length(Shapes)-1 do
    shapes[i].free;

  CurrentFileName:='';

  setlength(Labels,0);
  setlength(Edits,0);
  setlength(Buttons,0);
  setlength(CheckBoxs,0);
  setlength(Radiobuttons,0);
  setlength(ComboBoxs,0);
  setlength(ComboboxsImageList,0);
  setlength(Sliders,0);
  setlength(progressbars,0);
  setlength(Shapes,0);
  setlength(channels,0);
  setlength(functions,4);
  setlength(colors,0);
  setlength(colors2,0);
  setlength(gobos,0);
  setlength(gobos2,0);
  setlength(channels,1);

  setlength(editproperties,0);
  setlength(buttonproperties,0);
  setlength(checkboxproperties,0);
  setlength(radiobuttonproperties,0);
  setlength(comboboxproperties,0);
  setlength(sliderproperties,0);

  nameedit.text:='Neues Gerät';
  vendoredit.text:='Vendor';
  autoredit.text:=mainform.JvComputerInfoEx1.Identification.LocalUserName;
  beschreibungedit.Text:='Neues Gerät';
  bildedit.Text:='Par56silber.png';

  channels[0].minvalue:=0;
  channels[0].maxvalue:=255;
  channels[0].name:='Neuer Kanal';
  channels[0].fade:=true;
  channels[0].typ:='DIMMER';
  channels[0].initvalue:=-1;

  UseAmberMixingCheck.checked:=true;
  AmberMixingCompensateRGCheck.checked:=true;
  AmbermixingCompensateBlueCheck.checked:=true;
  AmberratioRbox.Value:=255;
  AmberratioGbox.Value:=191;

  typliste.Clear;
  for i:=0 to length(mainform.DeviceChannelNames)-1 do
    typliste.items.add(mainform.DeviceChannelNames[i]);
  typliste.items.add('VIRTUALRGBADIMMER');
  typliste.ItemIndex:=0;
  typliste.Text:=typliste.Items[0];
  shutterchannellist.Clear;
  for i:=0 to length(mainform.DeviceChannelNames)-1 do
    shutterchannellist.items.add(mainform.DeviceChannelNames[i]);
  shutterchannellist.ItemIndex:=18;
  shutterchannellist.Text:=shutterchannellist.Items[18];
  strobochannellist.Clear;
  for i:=0 to length(mainform.DeviceChannelNames)-1 do
    strobochannellist.items.add(mainform.DeviceChannelNames[i]);
  strobochannellist.ItemIndex:=18;
  strobochannellist.Text:=strobochannellist.Items[18];
  gobo1rotchlbox.Clear;
  for i:=0 to length(mainform.DeviceChannelNames)-1 do
    gobo1rotchlbox.items.add(mainform.DeviceChannelNames[i]);
  gobo1rotchlbox.ItemIndex:=7;
  gobo1rotchlbox.Text:=gobo1rotchlbox.Items[7];
  gobo2rotchlbox.Clear;
  for i:=0 to length(mainform.DeviceChannelNames)-1 do
    gobo2rotchlbox.items.add(mainform.DeviceChannelNames[i]);
  gobo2rotchlbox.ItemIndex:=9;
  gobo2rotchlbox.Text:=gobo2rotchlbox.Items[9];
  prismarotchanneledit.Clear;
  for i:=0 to length(mainform.DeviceChannelNames)-1 do
    prismarotchanneledit.items.add(mainform.DeviceChannelNames[i]);
  prismarotchanneledit.ItemIndex:=23;
  prismarotchanneledit.Text:=prismarotchanneledit.Items[23];

  DDFEcolorlist.Items.Clear;
  DDFEcoloredit.Text:='Neue Farbe';
  DDFEcolorlist2.Items.Clear;
  DDFEcoloredit2.Text:='Neue Farbe';
  colorbox.Visible:=false;
  colorbox2.Visible:=false;

  DDFEgobolist.Items.Clear;
  DDFEgoboedit.Text:='Gobo';
  DDFEgobolist2.Items.Clear;
  DDFEgoboedit2.Text:='Gobo';

  setlength(channels,0);
  PngBitBtn1Click(nil);

  functions[0].name:='InitDevice(Device: String)';
  functions[0].functext:='  begin'+#13#10+'  end;';
  functions[1].name:='FormShow';
  functions[1].functext:='  begin'+#13#10+'  end;';
  functions[2].name:='FormRefresh(channel:Integer)';
  functions[2].functext:='  var'+#13#10+'    value:integer;'+#13#10+'  begin'+#13#10+'  end;';
  functions[3].name:='FormClose';
  functions[3].functext:='  begin'+#13#10+'  end;';

  globalevariablen:='  var'+#13#10+'   DontRefresh:boolean;';

  unitnameedit.Text:='NewDeviceUnit';
  fadenkreuz.Visible:=false;
  colorpicker.Visible:=false;
  deviceimage.Visible:=true;
  deviceimage.top:=8;
  deviceimage.left:=8;
  deviceimage.width:=64;
  deviceimage.height:=64;
  deviceimage.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\64 x 64\Par56silber.png');
  devicename.Visible:=true;
  devicename.top:=24;
  devicename.left:=80;
  deviceadress.Visible:=true;
  deviceadress.top:=8;
  deviceadress.left:=80;
  dipswitchpanel.visible:=true;
  dipswitchpanel.top:=40;
  dipswitchpanel.Left:=80;

  PageControl1.TabIndex:=0;

  sizecontrolcheckedclick(nil);

  gobo1rotchlbox.ItemIndex:=7;
  gobo2rotchlbox.ItemIndex:=9;
  shutterchannellist.ItemIndex:=18;
  strobochannellist.ItemIndex:=18;
  prismarotchanneledit.ItemHeight:=23;
  

  RefreshSettings;
end;

procedure Tddfeditorform.DDFffnen1Click(Sender: TObject);
var
  j,k,l,m:integer;
  searchforglobalevariablen:boolean;
  endcount:integer;
  readyforend,bildvorhanden:boolean;
begin
  ScanGobosForOpen:=true;
  PageControl1Change(nil);

  OpenDialog1.InitialDir:=mainform.pcdimmerdirectory+'Devices';
  OpenDialog1.DefaultExt:='*.pcddevc';
  OpenDialog1.Filter:='DDF-Datei (*.pcddevc)|*.pcddevc|Alle Dateien (*.*)|*.*';
  if opendialog1.Execute then
  begin
    NeuesDDF1Click(nil);

    CurrentFileName:=opendialog1.Filename;
    XML.Xml.LoadFromFile(CurrentFileName);
    bildedit.text:=copy(Xml.xml.root.Properties.Value('image'),Pos('\',Xml.xml.root.Properties.Value('image'))+1,length(Xml.xml.root.Properties.Value('image')));
    deviceimage.width:=64;
    deviceimage.height:=64;
    deviceimage.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\64 x 64\'+bildedit.text);

    for j:=0 to XML.Xml.Root.Items.Count-1 do
    begin // <device>
      if lowercase(XML.XML.Root.Items[j].Name)='information' then
      begin // <information>
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          if XML.XML.Root.Items[j].Items[k].Name='name' then
          begin
            nameedit.text:=XML.XML.Root.Items[j].Items[k].Value;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='vendor' then
            vendoredit.text:=XML.XML.Root.Items[j].Items[k].Value;
          if XML.XML.Root.Items[j].Items[k].Name='author' then
            autoredit.text:=XML.XML.Root.Items[j].Items[k].Value;
          if XML.XML.Root.Items[j].Items[k].Name='description' then
            beschreibungedit.text:=XML.XML.Root.Items[j].Items[k].Value;
        end;
      end;
      if lowercase(XML.XML.Root.Items[j].Name)='channels' then
      begin // <channels>
        setlength(channels,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          channels[k].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          channels[k].typ:=XML.XML.Root.Items[j].Items[k].Properties.Value('type');
          channels[k].minvalue:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('minvalue'));
          channels[k].maxvalue:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('maxvalue'));
          if XML.XML.Root.Items[j].Items[k].Properties.Value('fade')='yes' then channels[k].fade:=true else channels[k].fade:=false;
        end;
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='amber' then
      begin // <amber>
          UseAmberMixingCheck.checked:=lowercase(XML.XML.Root.Items[j].Properties.Value('UseAmberMixing'))='yes';
          AmberMixingCompensateRGCheck.checked:=lowercase(XML.XML.Root.Items[j].Properties.Value('AmberMixingCompensateRG'))='yes';
          AmbermixingCompensateBlueCheck.checked:=lowercase(XML.XML.Root.Items[j].Properties.Value('AmberMixingCompensateBlue'))='yes';
          AmberratioRBox.value:=XML.XML.Root.Items[j].Properties.IntValue('AmberColorR');
          AmberratioGBox.value:=XML.XML.Root.Items[j].Properties.IntValue('AmberColorG');
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='initvalues' then
      begin // <initvalues>
        for k:=0 to length(channels)-1 do
        begin
          channels[k].initvalue:=XML.XML.Root.Items[j].Properties.IntValue('ch'+inttostr(k));
        end;
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='colors' then
      begin // <colors>
        setlength(colors,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          colors[k].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          colors[k].value:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          colors[k].valueend:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(colors[k].value)));
          colors[k].r:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('r'));
          colors[k].g:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('g'));
          colors[k].b:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('b'));
          DDFEcolorlist.Items.Add(colors[k].name);
        end;
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='colors2' then
      begin // <colors2>
        setlength(colors2,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          colors2[k].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          colors2[k].value:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          colors2[k].valueend:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(colors2[k].value)));
          colors2[k].r:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('r'));
          colors2[k].g:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('g'));
          colors2[k].b:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('b'));
          DDFEcolorlist2.Items.Add(colors2[k].name);
        end;
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='shutter' then
      begin
        shutterclosevalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('CloseValue'));
        shutteropenvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('OpenValue'));
        shutterchannellist.Text:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='strobe' then
      begin
        strobeoffvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        strobeminvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('MinValue'));
        strobemaxvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('MaxValue'));
        strobochannellist.Text:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;

      if (lowercase(XML.XML.Root.Items[j].Name)='dimmer') or (lowercase(XML.XML.Root.Items[j].Name)='virtualrgbadimmer') then
      begin
        dimmeroffvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        dimmermaxvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('MaxValue'));
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='gobo1rot' then
      begin
        goborotleftminvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMinValue'));
        goborotleftvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMaxValue'));
        goborotoffvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        goborotrightminvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMinValue'));
        goborotrightvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMaxValue'));
        gobo1rotchlbox.Text:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='gobo2rot' then
      begin
        gobo2rotleftminvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMinValue'));
        gobo2rotleftvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMaxValue'));
        gobo2rotoffvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        gobo2rotrightminvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMinValue'));
        gobo2rotrightvalueedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMaxValue'));
        gobo2rotchlbox.Text:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='prismarot' then
      begin
        prismarotleftminedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMinValue'));
        prismarotleftmaxedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMaxValue'));
        prismarotstopedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        prismarotrightminedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMinValue'));
        prismarotrightmaxedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMaxValue'));
        prismarotchanneledit.Text:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='prisma' then
      begin
        prismaoffedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('SingleValue'));
        prismatripleedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('TripleValue'));
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='iris' then
      begin
        irisoffedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('CloseValue'));
        irisopenedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('OpenValue'));
        irisminedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('MinValue'));
        irismaxedit.Value:=strtoint(XML.XML.Root.Items[j].Properties.Value('MaxValue'));
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='gobos' then
      begin // <gobos>
        setlength(gobos,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          gobos[k].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          gobos[k].value:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          gobos[k].valueend:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(gobos[k].value)));
          gobos[k].filename:=XML.XML.Root.Items[j].Items[k].Properties.Value('filename');
          DDFEgobolist.Items.Add;
          DDFEgobolist.Items.Items[DDFEgobolist.Items.Count-1].Text:=gobos[k].name;
          for m:=0 to goboselectbox.Items.Count-1 do
          begin
//            showmessage(lowercase(goboselectbox.Items.Strings[m]+'.png')+'  <->   '+lowercase(gobos[k].filename));
            if lowercase(goboselectbox.Items.Strings[m]+'.png')=lowercase(gobos[k].filename) then
            begin
              DDFEgobolist.Items.Items[DDFEgobolist.Items.Count-1].ImageIndex:=m;
              break;
            end;
          end;
        end;
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='gobos2' then
      begin // <gobos2>
        setlength(gobos2,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          gobos2[k].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          gobos2[k].value:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          gobos2[k].valueend:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(gobos2[k].value)));
          gobos2[k].filename:=XML.XML.Root.Items[j].Items[k].Properties.Value('filename');
          DDFEgobolist2.Items.Add;
          DDFEgobolist2.Items.Items[DDFEgobolist2.Items.Count-1].Text:=gobos2[k].name;
          for m:=0 to goboselectbox.Items.Count-1 do
          begin
            if lowercase(goboselectbox2.Items.Strings[m]+'.png')=lowercase(gobos2[k].filename) then
            begin
              DDFEgobolist2.Items.Items[DDFEgobolist2.Items.Count-1].ImageIndex:=m;
              break;
            end;
          end;
        end;
      end;

      if lowercase(XML.XML.Root.Items[j].Name)='form' then
      begin // <form>
//        ddfeditorform.width:=XML.XML.Root.Items[j].Properties.IntValue('width')+408;
//        ddfeditorform.Height:=XML.XML.Root.Items[j].Properties.IntValue('height')+92;
        widthspin.value:=XML.XML.Root.Items[j].Properties.IntValue('width');
        widthspinchange(widthspin);
        heightspin.value:=XML.XML.Root.Items[j].Properties.IntValue('height');
        heightspinChange(heightspin);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          if XML.XML.Root.Items[j].Items[k].Name='deviceimage' then
          begin
            deviceimage.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            deviceimage.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            deviceimage.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            deviceimage.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            deviceimage.Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='devicename' then
          begin
            devicename.Caption:='<Gerätename>';
            devicename.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            devicename.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
//              devicename.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
//              devicename.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            devicename.Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='deviceadress' then
          begin
            deviceadress.Caption:='Startadresse: <???>';
            deviceadress.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            deviceadress.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
//              deviceadress.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
//              deviceadress.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            deviceadress.Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='devicedipswitch' then
          begin
            dipswitchpanel.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            dipswitchpanel.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            dipswitchpanel.Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='position' then
          begin
            fadenkreuz.Visible:=true;
            fadenkreuz.top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            fadenkreuz.left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            fadenkreuz.width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            fadenkreuz.height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            horizontal_line.Left:=0;
            horizontal_line.Top:=fadenkreuz.Width div 2;
            horizontal_line.Width:=fadenkreuz.Height;
            vertical_line.Left:=fadenkreuz.Height div 2;
            vertical_line.Top:=0;
            vertical_line.Height:=fadenkreuz.Width;
            PositionXY.Top:=(fadenkreuz.Height div 2)-(PositionXY.Height div 2);
            PositionXY.Left:=(fadenkreuz.Width div 2)-(PositionXY.Width div 2);
          end;
          if XML.XML.Root.Items[j].Items[k].Name='label' then
          begin
            setlength(Labels,length(Labels)+1);
            Labels[length(Labels)-1]:=TLabel.Create(self);
            Labels[length(Labels)-1].Parent:=Panel1;
            Labels[length(Labels)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Labels[length(Labels)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Labels[length(Labels)-1].Caption:=XML.XML.Root.Items[j].Items[k].Properties.Value('caption');
            Labels[length(Labels)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Labels[length(Labels)-1].Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='slider' then
          begin
            setlength(Sliders,length(Sliders)+1);
            setlength(sliderproperties,length(sliderproperties)+1);
            Sliders[length(Sliders)-1]:=TScrollbar.Create(self);
            Sliders[length(Sliders)-1].Parent:=Panel1;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              Sliders[length(Sliders)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            sliderproperties[length(sliderproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            sliderproperties[length(sliderproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            sliderproperties[length(sliderproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Sliders[length(Sliders)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Sliders[length(Sliders)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Sliders[length(Sliders)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Sliders[length(Sliders)-1].Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            Sliders[length(Sliders)-1].Max:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('endvalue');
            Sliders[length(Sliders)-1].Min:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('startvalue');
            Sliders[length(Sliders)-1].position:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('default');
            Sliders[length(Sliders)-1].Visible:=true;
            Sliders[length(Sliders)-1].OnScroll:=sliderscroll;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='dropdown' then
          begin
            setlength(Comboboxs,length(Comboboxs)+1);
            setlength(ComboboxsImageList,length(ComboboxsImageList)+1);
            setlength(comboboxproperties,length(comboboxproperties)+1);
            Comboboxs[length(Comboboxs)-1]:=TmbXPImageComboBox.Create(self);//TCombobox.Create(self);
            Comboboxs[length(Comboboxs)-1].Parent:=Panel1;
            Comboboxs[length(Comboboxs)-1].Style:=csDropDownList;
            ComboboxsImageList[length(ComboboxsImageList)-1]:=TImageList.Create(self);

            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              Comboboxs[length(Comboboxs)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            comboboxproperties[length(comboboxproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            comboboxproperties[length(comboboxproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            comboboxproperties[length(comboboxproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Comboboxs[length(Comboboxs)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Comboboxs[length(Comboboxs)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Comboboxs[length(Comboboxs)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Comboboxs[length(Comboboxs)-1].Visible:=true;
            setlength(comboboxproperties[length(comboboxproperties)-1].itemvalue,XML.XML.Root.Items[j].Items[k].Items.Count);
            setlength(comboboxproperties[length(comboboxproperties)-1].itemvalueend,XML.XML.Root.Items[j].Items[k].Items.Count);
            setlength(comboboxproperties[length(comboboxproperties)-1].picture,XML.XML.Root.Items[j].Items[k].Items.Count);

            bildvorhanden:=false;
            for l:=0 to XML.XML.Root.Items[j].Items[k].Items.Count-1 do
            begin
              comboboxproperties[length(comboboxproperties)-1].itemvalue[l]:=XML.XML.Root.Items[j].Items[k].Items[l].Properties.IntValue('value');
              comboboxproperties[length(comboboxproperties)-1].itemvalueend[l]:=XML.XML.Root.Items[j].Items[k].Items[l].Properties.IntValue('valuemax');
              if lowercase(ExtractFileName(XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture')))='leer.bmp' then
                comboboxproperties[length(comboboxproperties)-1].picture[l]:=''
              else
                comboboxproperties[length(comboboxproperties)-1].picture[l]:=XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture');
              Comboboxs[length(Comboboxs)-1].Items.Add(XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('caption'));

              bildvorhanden:=false;
              if XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture')<>'' then
              begin
                bildvorhanden:=true;
                if FileExists(mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\'+XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture')) then
                  Bmp.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\'+XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture'))
                else
                  Bmp.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\leer.bmp');
                ComboboxsImageList[length(ComboboxsImageList)-1].Add(Bmp.Picture.Bitmap,Bmp.Picture.Bitmap);
              end else
              begin
                Bmp.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\leer.bmp');
                ComboboxsImageList[length(ComboboxsImageList)-1].Add(Bmp.Picture.Bitmap,Bmp.Picture.Bitmap);
              end;
            end;

            if (ComboboxsImageList[length(ComboboxsImageList)-1].Count>0) and bildvorhanden then
            begin
              Comboboxs[length(Comboboxs)-1].Style:=csOwnerDrawFixed;
              Comboboxs[length(Comboboxs)-1].Images:=ComboboxsImageList[length(ComboboxsImageList)-1];
            end;

            Comboboxs[length(Comboboxs)-1].ItemIndex:=0;
            Comboboxs[length(Comboboxs)-1].OnSelect:=startscript;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='line' then
          begin
            setlength(Shapes,length(Shapes)+1);
            Shapes[length(Shapes)-1]:=TShape.Create(self);
            Shapes[length(Shapes)-1].Parent:=Panel1;
            Shapes[length(Shapes)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Shapes[length(Shapes)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Shapes[length(Shapes)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Shapes[length(Shapes)-1].Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            Shapes[length(Shapes)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Shapes[length(Shapes)-1].Visible:=true;
          end;
          if (XML.XML.Root.Items[j].Items[k].Name='colorpicker') or (XML.XML.Root.Items[j].Items[k].Name='colorpicker2') then
          begin
            Colorpicker.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Colorpicker.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
//            Colorpicker.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
//            Colorpicker.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            Colorpickerchannel[0]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel1');
            Colorpickerchannel[1]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel2');
            Colorpickerchannel[2]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel3');
            Colorpicker.Visible:=true;
{
            R.Visible:=true;
            G.Visible:=true;
            B.Visible:=true;
}
          end;
          if (XML.XML.Root.Items[j].Items[k].Name='colorpicker') or (XML.XML.Root.Items[j].Items[k].Name='colorpicker2') then
          begin
            Colorpicker.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Colorpicker.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left'){+7};
{
            Colorpicker2.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Colorpicker2.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
}
            Colorpickerchannel[0]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel1');
            Colorpickerchannel[1]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel2');
            Colorpickerchannel[2]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel3');
            Colorpicker.Visible:=XML.XML.Root.Items[j].Items[k].Name='colorpicker';
{
            R.Visible:=true;
            G.Visible:=true;
            B.Visible:=true;
}
          end;
          if (XML.XML.Root.Items[j].Items[k].Name='colorbox') then
          begin
            colorbox.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            colorbox.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            colorbox.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            colorbox.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            colorbox.Visible:=true;
          end;
          if (XML.XML.Root.Items[j].Items[k].Name='colorbox2') then
          begin
            colorbox2.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            colorbox2.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            colorbox2.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            colorbox2.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            colorbox2.Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='button' then
          begin
            setlength(Buttons,length(Buttons)+1);
            setlength(buttonproperties,length(buttonproperties)+1);
            Buttons[length(Buttons)-1]:=TButton.Create(self);
            Buttons[length(Buttons)-1].Parent:=Panel1;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              Buttons[length(Buttons)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Buttonproperties[length(Buttonproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Buttonproperties[length(Buttonproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            Buttonproperties[length(Buttonproperties)-1].onvalue:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('onvalue');
            Buttonproperties[length(Buttonproperties)-1].offvalue:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('offvalue');
            Buttonproperties[length(Buttonproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Buttons[length(Buttons)-1].Caption:=XML.XML.Root.Items[j].Items[k].Properties.Value('caption');
            Buttons[length(Buttons)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Buttons[length(Buttons)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Buttons[length(Buttons)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Buttons[length(Buttons)-1].Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            Buttons[length(Buttons)-1].Hint:=XML.XML.Root.Items[j].Items[k].Properties.Value('hint');
            Buttons[length(Buttons)-1].showhint:=XML.XML.Root.Items[j].Items[k].Properties.Value('hint')<>'';
            Buttons[length(Buttons)-1].Visible:=true;
            Buttons[length(Buttons)-1].OnClick:=startscript;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='options' then
          begin
            setlength(Radiobuttons,length(Radiobuttons)+1);
            setlength(radiobuttonproperties,length(radiobuttonproperties)+1);
            Radiobuttons[length(Radiobuttons)-1]:=TRadioGroup.Create(self);
            Radiobuttons[length(Radiobuttons)-1].Parent:=Panel1;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              Radiobuttons[length(Radiobuttons)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            radiobuttonproperties[length(radiobuttonproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            radiobuttonproperties[length(radiobuttonproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            radiobuttonproperties[length(radiobuttonproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Radiobuttons[length(Radiobuttons)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top',50);
            Radiobuttons[length(Radiobuttons)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Radiobuttons[length(Radiobuttons)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width',100);
            Radiobuttons[length(Radiobuttons)-1].Visible:=true;
            setlength(radiobuttonproperties[length(radiobuttonproperties)-1].itemvalue,XML.XML.Root.Items[j].Items[k].Items.Count);
            setlength(radiobuttonproperties[length(radiobuttonproperties)-1].itemvalueend,XML.XML.Root.Items[j].Items[k].Items.Count);
            for l:=0 to XML.XML.Root.Items[j].Items[k].Items.Count-1 do
            begin
              radiobuttonproperties[length(radiobuttonproperties)-1].itemvalue[l]:=XML.XML.Root.Items[j].Items[k].Items[l].Properties.IntValue('value');
              radiobuttonproperties[length(radiobuttonproperties)-1].itemvalueend[l]:=XML.XML.Root.Items[j].Items[k].Items[l].Properties.IntValue('valuemax');
              Radiobuttons[length(Radiobuttons)-1].Items.Add(XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('caption'));
              if XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('default')='true' then
                Radiobuttons[length(Radiobuttons)-1].ItemIndex:=l;
            end;
            Radiobuttons[length(Radiobuttons)-1].OnClick:=startscript;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='checkbox' then
          begin
            setlength(checkboxs,length(checkboxs)+1);
            setlength(checkboxproperties,length(checkboxproperties)+1);
            checkboxs[length(checkboxs)-1]:=TCheckbox.Create(self);
            Checkboxs[length(checkboxs)-1].Parent:=Panel1;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              checkboxs[length(checkboxs)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Checkboxproperties[length(Checkboxproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Checkboxproperties[length(Checkboxproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            Checkboxproperties[length(Checkboxproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Checkboxs[length(Checkboxs)-1].Caption:=XML.XML.Root.Items[j].Items[k].Properties.Value('caption');
            Checkboxs[length(Checkboxs)-1].checked:=XML.XML.Root.Items[j].Items[k].Properties.Value('checked')='true';
            Checkboxs[length(Checkboxs)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top',50);
            Checkboxs[length(Checkboxs)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Checkboxs[length(Checkboxs)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width',100);
            Checkboxs[length(Checkboxs)-1].Visible:=true;
            Checkboxs[length(Checkboxs)-1].OnClick:=startscript;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='edit' then
          begin
            setlength(edits,length(Edits)+1);
            setlength(editproperties,length(editproperties)+1);
            Edits[length(Edits)-1]:=TEdit.Create(self);
            Edits[length(Edits)-1].Parent:=Panel1;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              Edits[length(Edits)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Editproperties[length(Editproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Editproperties[length(Editproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            Editproperties[length(Editproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Edits[length(Edits)-1].text:=XML.XML.Root.Items[j].Items[k].Properties.Value('text');
            Edits[length(Edits)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top',50);
            Edits[length(Edits)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Edits[length(Edits)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width',100);
            Edits[length(Edits)-1].Visible:=true;
            Edits[length(Edits)-1].OnChange:=startscript;
          end;
        end;
      end;
      if lowercase(XML.XML.Root.Items[j].Name)='code' then
      begin // <code>
        setlength(functions,0);
        Memo2.Lines.Clear;
        memo2.Text:=XML.XML.Root.Items[j].Value;
      end;
    end;

    while pos('implementation',memo2.lines[0])=0 do
    begin
      if pos('unit',memo2.lines[0])>0 then
        unitnameedit.text:=copy(copy(memo2.lines[0],pos('unit',memo2.lines[0])+5,length(memo2.lines[0])),0,length(copy(memo2.lines[0],pos('unit',memo2.lines[0])+5,length(memo2.lines[0])))-1);
      memo2.Lines.Delete(0);
    end;
    memo2.Lines.Delete(0);

    globalevariablen:='';
    searchforglobalevariablen:=true;

    for j:=0 to memo2.lines.count-1 do
    begin
      if (pos('procedure',memo2.lines[j])=0) and not (memo2.lines[j]='') and searchforglobalevariablen then
      begin
        if globalevariablen='' then
          globalevariablen:=memo2.lines[j]
        else
          globalevariablen:=globalevariablen+#13+#10+memo2.lines[j];
      end;

      if pos('procedure',memo2.lines[j])>0 then
      begin
        searchforglobalevariablen:=false;
        setlength(functions,length(functions)+1);
        functions[length(functions)-1].name:=copy(copy(memo2.lines[j],pos('procedure',memo2.lines[j])+10,length(memo2.lines[j])),0,length(copy(memo2.lines[j],pos('procedure',memo2.lines[j])+10,length(memo2.lines[j])))-1);
        endcount:=0;
        readyforend:=false;
        k:=j+1;
        repeat
          if (pos('begin',memo2.lines[k])>0) or (pos('case',memo2.lines[k])>0) then
          begin
            endcount:=endcount+1;
          end;
          if (pos('end',memo2.lines[k])>0) then
          begin
            endcount:=endcount-1;
            readyforend:=true;
          end;

          if functions[length(functions)-1].functext='' then
            functions[length(functions)-1].functext:=memo2.lines[k]
          else
            functions[length(functions)-1].functext:=functions[length(functions)-1].functext+#13+#10+memo2.lines[k];
          k:=k+1;
        until {(pos('end;',memo2.lines[k-1])>0) and (not (pos('end;',memo2.lines[k])>0)) and }(endcount=0) and readyforend;
      end;
    end;
    RefreshSettings;
    RefreshSelection;
  end;
end;

procedure Tddfeditorform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  UnRegComponents(Panel1,SizeCtrl);
  SizeCtrl.Enabled:=false;
end;

procedure Tddfeditorform.GridSizeTrackbarChange(Sender: TObject);
begin
  SizeCtrl.GridSize:=GridSizeTrackbar.Position*5;
  sizecontrolcheckedclick(nil);
end;

procedure Tddfeditorform.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if messagedlg(_('Soll die Gerätedatei vor dem Beenden gespeichert werden?'),mtConfirmation,
    [mbYes,mbNo],0)=mrYes then
      TBItem23.Click;
end;

procedure Tddfeditorform.PngBitBtn6Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(radiobuttons)-1 do
  begin
    if radiobuttons[i].name=LastSelectedComponent then
    begin
//      itemnameedit.Text:='Neuer Wert';
      radiobuttons[i].Items.Add(itemnameedit.Text+' '+inttostr(radiobuttons[i].Items.Count+1));
      setlength(radiobuttonproperties[i].itemvalue,radiobuttons[i].Items.Count);
      setlength(radiobuttonproperties[i].itemvalueend,radiobuttons[i].Items.Count);
      radiobuttonproperties[i].itemvalue[radiobuttons[i].Items.Count-1]:=0;
      radiobuttonproperties[i].itemvalueend[radiobuttons[i].Items.Count-1]:=0;
      itemlistbox.Items.Add(itemnameedit.Text+' '+inttostr(radiobuttons[i].Items.Count));
      itemvalueedit.value:=0;
      itemvalueendedit.value:=1;
      break;
    end;
  end;
  for i:=0 to length(comboboxs)-1 do
  begin
    if comboboxs[i].name=LastSelectedComponent then
    begin
//      itemnameedit.Text:='Neuer Wert';
      Comboboxs[i].Items.Add(itemnameedit.Text+' '+inttostr(Comboboxs[i].Items.Count+1));
      setlength(Comboboxproperties[i].itemvalue,Comboboxs[i].Items.Count);
      setlength(Comboboxproperties[i].itemvalueend,Comboboxs[i].Items.Count);
      setlength(Comboboxproperties[i].picture,Comboboxs[i].Items.Count);
      Comboboxproperties[i].itemvalue[Comboboxs[i].Items.Count-1]:=0;
      Comboboxproperties[i].itemvalueend[Comboboxs[i].Items.Count-1]:=0;
//      Comboboxproperties[i].picture[Comboboxs[i].Items.Count-1]:='weiss.bmp';
      itemlistbox.Items.Add(itemnameedit.Text+' '+inttostr(Comboboxs[i].Items.Count));
      itemvalueedit.value:=0;
      itemvalueendedit.value:=1;
      break;
    end;
  end;
end;

procedure Tddfeditorform.itemlistboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  itemlistboxchange;
  itemnameedit.SelectAll;
  itemnameedit.SetFocus;
end;

procedure Tddfeditorform.itemnameeditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
begin
    for i:=0 to length(radiobuttons)-1 do
    begin
      if radiobuttons[i].name=LastSelectedComponent then
      begin
        radiobuttons[i].Items[itemlistbox.ItemIndex]:=itemnameedit.text;
        itemlistbox.Items[itemlistbox.ItemIndex]:=itemnameedit.text;
      end;
    end;
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=LastSelectedComponent then
      begin
        comboboxs[i].Items[itemlistbox.ItemIndex]:=itemnameedit.text;
        itemlistbox.Items[itemlistbox.ItemIndex]:=itemnameedit.text;
      end;
    end;
end;

procedure Tddfeditorform.itemvalueeditChange(Sender: TObject);
var
  i:integer;
begin
  if not (Sender=itemvalueedit) then exit;

    for i:=0 to length(radiobuttons)-1 do
    begin
      if radiobuttons[i].name=LastSelectedComponent then
      begin
        radiobuttonproperties[i].itemvalue[itemlistbox.ItemIndex]:=round(itemvalueedit.Value);
      end;
    end;
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=LastSelectedComponent then
      begin
        comboboxproperties[i].itemvalue[itemlistbox.ItemIndex]:=round(itemvalueedit.Value);
      end;
    end;
end;

procedure Tddfeditorform.itemvalueendeditChange(Sender: TObject);
var
  i:integer;
begin
  if not (Sender=itemvalueendedit) then exit;

    for i:=0 to length(radiobuttons)-1 do
    begin
      if radiobuttons[i].name=LastSelectedComponent then
      begin
        radiobuttonproperties[i].itemvalueend[itemlistbox.ItemIndex]:=round(itemvalueendedit.Value);
      end;
    end;
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=LastSelectedComponent then
      begin
        comboboxproperties[i].itemvalueend[itemlistbox.ItemIndex]:=round(itemvalueendedit.Value);
      end;
    end;
end;

procedure Tddfeditorform.minvaluespinChange(Sender: TObject);
var
  i:integer;
begin
  if not (Sender=minvaluespin) then exit;

  for i:=0 to length(sliders)-1 do
  begin
    if sliders[i].name=LastSelectedComponent then
    begin
      sliders[i].Min:=round(minvaluespin.value);
      break;
    end;
  end;
  for i:=0 to length(progressbars)-1 do
  begin
    if progressbars[i].name=LastSelectedComponent then
    begin
      progressbars[i].Min:=round(minvaluespin.value);
      break;
    end;
  end;
end;

procedure Tddfeditorform.maxvaluespinChange(Sender: TObject);
var
  i:integer;
begin
  if not (Sender=maxvaluespin) then exit;

  for i:=0 to length(sliders)-1 do
  begin
    if sliders[i].name=LastSelectedComponent then
    begin
      if round(maxvaluespin.value)>sliders[i].Min then
        sliders[i].Max:=round(maxvaluespin.value);
      break;
    end;
  end;
  for i:=0 to length(progressbars)-1 do
  begin
    if progressbars[i].name=LastSelectedComponent then
    begin
      if round(maxvaluespin.value)>progressbars[i].Min then
        progressbars[i].Max:=round(maxvaluespin.value);
      break;
    end;
  end;
end;

procedure Tddfeditorform.standardfunktionenSelect(Sender: TObject);
begin
  memo2.SelText:=standardfunktionen.Items[standardfunktionen.itemindex];
end;

procedure Tddfeditorform.TBItem15Click(Sender: TObject);
begin
  setlength(progressbars,length(progressbars)+1);
  progressbars[length(progressbars)-1]:=TProgressBar.Create(progressbars[length(progressbars)-1]);
  progressbars[length(progressbars)-1].Parent:=panel1;
  progressbars[length(progressbars)-1].Name:='Progressbar'+inttostr(length(progressbars))+'_'+inttostr(Random(1000));
  progressbars[length(progressbars)-1].Top:=80;
  RefreshSelection;
end;

procedure Tddfeditorform.defaultvaluespinChange(Sender: TObject);
var
  i:integer;
begin
  if not (Sender=defaultvaluespin) then exit;

    for i:=0 to length(sliders)-1 do
    begin
      if sliders[i].name=LastSelectedComponent then
      begin
        sliders[i].Position:=round(defaultvaluespin.value);
      end;
    end;

    for i:=0 to length(progressbars)-1 do
    begin
      if progressbars[i].name=LastSelectedComponent then
      begin
        progressbars[i].Position:=round(defaultvaluespin.value);
      end;
    end;
end;

procedure Tddfeditorform.TBItem16Click(Sender: TObject);
begin
  close;
end;

procedure Tddfeditorform.CreateParams(var Params:TCreateParams);
begin
  inherited;// CreateParams(Params);

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

procedure Tddfeditorform.PngBitBtn8Click(Sender: TObject);
var
  i,errorline:integer;
begin
  errorline:=0;

  if funktionsliste1.ItemIndex < 0 then
  begin
    ShowMessage(_('Globale Variablen können nicht gesondert ausgeführt und getestet werden...'));
    exit;
  end;

  memo1.Lines.clear;
  memo1.Lines.Add('  unit '+unitnameedit.Text+';');
  memo1.Lines.Add('');
  memo1.Lines.Add('  interface');
  memo1.Lines.Add('');
  for i:=0 to length(functions)-1 do
    memo1.Lines.Add('  procedure '+functions[i].name+';');
  memo1.Lines.Add('  implementation');
  memo1.Lines.Add('');
  for i:=0 to length(functions)-1 do
  begin
    memo1.Lines.Add('  procedure '+functions[i].name+';');
//    memo1.Lines.Add('   begin');
    memo1.Lines.Add(functions[i].functext);
//    memo1.Lines.Add('   end;');
  end;
  memo1.Lines.Add('  end.');

  ScriptInterpreter.Pas:=memo1.Lines;
  try
    ScriptInterpreter.Compile;
//    for i:=0 to length(functions)-1 do
//      ScriptInterpreter.CallFunction(functions[i].name,nil, []);
    if functions[funktionsliste1.itemindex].name='FormRefresh(channel:Integer)' then
    begin
      argumente.Count:=1;
      argumente.Values[0]:=0;
      ScriptInterpreter.CallFunction('FormRefresh',argumente, []);
    end else
    if functions[funktionsliste1.itemindex].name='PositionXYChange(Top, Left: Integer)' then
    begin
      argumente.Count:=2;
      argumente.Values[0]:=127;
      argumente.Values[1]:=127;
      ScriptInterpreter.CallFunction('PositionXYChange',argumente, []);
    end else
    if functions[funktionsliste1.itemindex].name='ColorPickerChange(R, G, B: Byte)' then
    begin
      argumente.Count:=3;
      argumente.Values[0]:=127;
      argumente.Values[1]:=127;
      argumente.Values[2]:=127;
      ScriptInterpreter.CallFunction('ColorPickerChange',argumente, []);
    end else
    begin
      ScriptInterpreter.CallFunction(functions[funktionsliste1.itemindex].name,nil, []);
    end;
  except
    compileerrorform.listbox1.items.clear;
    compileerrorform.listbox1.Items:=memo1.Lines;
    for i:=0 to compileerrorform.listbox1.Items.Count-1 do
      compileerrorform.listbox1.Selected[i]:=false;

    if pos('on line ',ScriptInterpreter.LastError.Message)>0 then
      errorline:=strtoint(copy(ScriptInterpreter.LastError.Message,pos('on line ',ScriptInterpreter.LastError.Message)+8,pos(' : ',ScriptInterpreter.LastError.Message)-length(copy(ScriptInterpreter.LastError.Message,0,pos('on line ',ScriptInterpreter.LastError.Message)+8))));

    compileerrorform.listbox1.Selected[errorline-1]:=true;

    compileerrorform.Memo1.Lines.Clear;
    compileerrorform.Memo1.Lines.Add(ScriptInterpreter.LastError.ErrMessage);
    compileerrorform.memo1.lines.add('');
    compileerrorform.Memo1.Lines.Add(ScriptInterpreter.LastError.Message);

    compileerrorform.show;
  end;
end;

procedure Tddfeditorform.Memo2_oldKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_tab then
  begin
    LockWindow(memo2.Handle);
    memo2.SelText:='  ';
  end;
end;

procedure Tddfeditorform.Memo2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if funktionsliste1.itemindex<0 then exit;
  if funktionsliste1.ItemIndex=funktionsliste1.Items.Count-1 then
  begin
    globalevariablen:=Memo2.Text;
    exit;
  end;

  if (Key=Ord('S')) and (Shift=[ssCtrl]) then
  begin
    functions[funktionsliste1.itemindex].functext:=Memo2.Text;
    CreateCode;
  end;
end;

procedure Tddfeditorform.Memo2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if funktionsliste1.itemindex<0 then exit;
  if funktionsliste1.ItemIndex=funktionsliste1.Items.Count-1 then
  begin
    globalevariablen:=Memo2.Text;
    exit;
  end;

  if funktionsliste1.itemindex<0 then
  begin
    globalevariablen:=memo2.text;
    exit;
  end;
end;

procedure Tddfeditorform.ScriptInterpreterGetValue(Sender: TObject;
  Identifier: String; var Value: Variant; Args: TJvInterpreterArgs;
  var Done: Boolean);
var
  i:integer;
begin
  if lowercase(Identifier)='set_absolutchannel' then
  begin
    if args.Count=4 then
    begin
      mainform.Senddata(args.values[0],255-args.values[1],255-args.values[2],args.values[3]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_channel' then
  begin
    if args.Count=4 then
    begin
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_pantilt' then
  begin
    if args.Count=5 then
    begin
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_control' then
  begin
      for i:=0 to length(Edits)-1 do
      begin
        if args.values[0]=lowercase(editproperties[i].name) then
          Edits[i].text:=args.values[1];
      end;
      for i:=0 to length(Checkboxs)-1 do
      begin
        if args.values[0]=lowercase(checkboxproperties[i].name) then
          Checkboxs[i].Checked:=args.values[1];
      end;
      for i:=0 to length(Comboboxs)-1 do
      begin
        if args.values[0]=lowercase(comboboxproperties[i].name) then
          Comboboxs[i].ItemIndex:=args.values[1];
      end;
      for i:=0 to length(Sliders)-1 do
      begin
        if args.values[0]=lowercase(sliderproperties[i].name) then
          Sliders[i].Position:=args.values[1];
      end;
      for i:=0 to length(progressbars)-1 do
      begin
        if args.values[0]=lowercase(progressbars[i].name) then
          progressbars[i].Position:=args.values[1];
      end;
      for i:=0 to length(Radiobuttons)-1 do
      begin
        if args.values[0]=lowercase(radiobuttonproperties[i].name) then
          Radiobuttons[i].ItemIndex:=args.values[1];
      end;
    done:=true;
  end;

  if lowercase(Identifier)='get_absolutchannel' then
  begin
    Value:=255-mainform.data.ch[Integer(args.values[0])];
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='get_channel' then
  begin
    Value:=0;
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='levelstr' then
  begin
    Value:=mainform.levelstr(args.values[0]);
    args.HasResult:=true;
    Done:=true;
  end;

  // Objekte zuweisen
  if lowercase(Identifier)='mainform' then
  begin
    Value := O2V(mainform);
    Done := True;
  end;
  if lowercase(Identifier)='geraetesteuerung' then
  begin
    Value := O2V(geraetesteuerung);
    Done := True;
  end;
  if lowercase(Identifier)='ddfwindow' then
  begin
    Value := O2V(self);
    Done := True;
  end;

  // Controls zuweisen
    for i:=0 to length(Edits)-1 do
    begin
      if lowercase(Identifier)=lowercase(edits[i].name) then
      begin
        Value:=O2V(Edits[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Buttons)-1 do
    begin
      if lowercase(Identifier)=lowercase(Buttons[i].name) then
      begin
        Value:=O2V(Buttons[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Checkboxs)-1 do
    begin
      if lowercase(Identifier)=lowercase(Checkboxs[i].name) then
      begin
        Value:=O2V(Checkboxs[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Comboboxs)-1 do
    begin
      if lowercase(Identifier)=lowercase(Comboboxs[i].name) then
      begin
        Value:=O2V(Comboboxs[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Sliders)-1 do
    begin
      if lowercase(Identifier)=lowercase(Sliders[i].name) then
      begin
        Value:=O2V(Sliders[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(progressbars)-1 do
    begin
      if lowercase(Identifier)=lowercase(progressbars[i].name) then
      begin
        Value:=O2V(progressbars[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Radiobuttons)-1 do
    begin
      if lowercase(Identifier)=lowercase(Radiobuttons[i].name) then
      begin
        Value:=O2V(Radiobuttons[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Labels)-1 do
    begin
      if lowercase(Identifier)=lowercase(Labels[i].name) then
      begin
        Value:=O2V(Labels[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(shapes)-1 do
    begin
      if lowercase(Identifier)=lowercase(shapes[i].name) then
      begin
        Value:=O2V(shapes[i]);
        Done:=true;
      end;
    end;
    if lowercase(Identifier)='colorpicker' then
    begin
      Value:=O2V(colorpicker);
      Done:=true;
    end;
    if lowercase(Identifier)='colorpicker2' then
    begin
      Value:=O2V(colorpicker);
      Done:=true;
    end;
    if lowercase(Identifier)='positionxy' then
    begin
      Value:=O2V(positionxy);
      Done:=true;
    end;
    if lowercase(Identifier)='fadenkreuz' then
    begin
      Value:=O2V(fadenkreuz);
      Done:=true;
    end;

    if lowercase(Identifier)='panmirror' then
    begin
      Value:=O2V(panmirror);
      Done:=true;
    end;
    if lowercase(Identifier)='tiltmirror' then
    begin
      Value:=O2V(tiltmirror);
      Done:=true;
    end;
    if lowercase(Identifier)='colorbox' then
    begin
      Value:=O2V(colorbox);
      Done:=true;
    end;
    if lowercase(Identifier)='colorbox2' then
    begin
      Value:=O2V(colorbox2);
      Done:=true;
    end;
end;

procedure Tddfeditorform.sliderscroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  startscript(Sender);
end;

procedure Tddfeditorform.startscript(Sender: TObject);
var
  i:integer;
begin
//  mainform.ScriptInterpreter.Pas.Text:=funktionen;
//  mainform.ScriptInterpreter.Compile;

  for i:=0 to length(Edits)-1 do
  begin
    if Sender=Edits[i] then
    begin
      if editproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(editproperties[i].actionname,nil,[edits[i].text]);
    end;
  end;

  for i:=0 to length(CheckBoxs)-1 do
  begin
    if Sender=CheckBoxs[i] then
    begin
      if checkboxproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(checkboxproperties[i].actionname,nil,[Checkboxs[i].checked]);
    end;
  end;

  for i:=0 to length(ComboBoxs)-1 do
  begin
    if Sender=ComboBoxs[i] then
    begin
      if comboboxproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(comboboxproperties[i].actionname,nil,[Comboboxs[i].Itemindex]);
    end;
  end;

  for i:=0 to length(Sliders)-1 do
  begin
    if Sender=Sliders[i] then
    begin
      if sliderproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(sliderproperties[i].actionname,nil,[Sliders[i].Position]);
    end;
  end;

  for i:=0 to length(Buttons)-1 do
  begin
    if Sender=Buttons[i] then
    begin
      if buttonproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(buttonproperties[i].actionname,nil,[]);
    end;
  end;

  for i:=0 to length(Radiobuttons)-1 do
  begin
    if Sender=Radiobuttons[i] then
    begin
      if radiobuttonproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(radiobuttonproperties[i].actionname,nil,[radiobuttons[i].ItemIndex]);
    end;
  end;

  if Sender=Colorpicker then
  begin
    argumente.Count:=3;
    argumente.Values[0]:=red;
    argumente.Values[1]:=green;
    argumente.Values[2]:=blue;

    ScriptInterpreter.CallFunction('ColorPickerChange',argumente,[colorpicker.SelectedColor]);
  end;

  if Sender=PositionXY then
  begin
    argumente.Count:=2;
    argumente.Values[0]:=PositionXY.Top;
    argumente.Values[1]:=PositionXY.Left;

    ScriptInterpreter.CallFunction('PositionXYChange',argumente,[]);
  end;
end;

procedure Tddfeditorform.OwnColorPickerChange(Sender: TObject);
begin
  if ColorPicker.visible and (Sender=ColorPicker) then
  begin
    TColor2RGB(ColorPicker.SelectedColor,Red,Green,Blue);

    startscript(Colorpicker);
  end;
end;

procedure Tddfeditorform.PositionXYMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    if ((PositionXY.Left+x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((PositionXY.Left+x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=PositionXY.Left+x-(PositionXY.Width div 2);
    if ((PositionXY.Top+y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((PositionXY.Top+y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=PositionXY.Top+y-(PositionXY.Height div 2);
    PositionXY.Refresh;

    startscript(positionxy);
  end;
end;

procedure Tddfeditorform.fadenkreuzMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    if ((x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=x-(PositionXY.Width div 2);
    if ((y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=y-(PositionXY.Height div 2);
    PositionXY.Refresh;

    startscript(positionxy);
  end;
end;

procedure Tddfeditorform.fadenkreuzMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then
  begin
    PositionXY.Top:=Y-PositionXY.Height div 2;
    PositionXY.Left:=X-PositionXY.Width div 2;
  end else
  begin
    PositionXY.Top:=(fadenkreuz.Height div 2)-(PositionXY.Height div 2);
    PositionXY.Left:=(fadenkreuz.Width div 2)-(PositionXY.Width div 2);
  end;
  startscript(positionxy);
end;

procedure Tddfeditorform.widthspinChange(Sender: TObject);
var
  differenz:integer;
begin
  if not (Sender=widthspin) then exit;

  differenz:=Panel1.Width-round(widthspin.value);
  Panel4.Width:=round(widthspin.value);
//  Panel1.Width:=round(widthspin.value);
  ddfeditorform.Left:=ddfeditorform.Left+differenz;
  ddfeditorform.Width:=ddfeditorform.width-differenz;
end;

procedure Tddfeditorform.heightspinChange(Sender: TObject);
begin
  if not (Sender=heightspin) then exit;

  Panel1.height:=round(heightspin.value);
end;

procedure Tddfeditorform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  Bmp := TImage.Create(self);
  argumente:=TJvInterpreterArgs.Create;
  Randomize;
end;

procedure Tddfeditorform.FormDestroy(Sender: TObject);
begin
  Bmp.Free;
  argumente.free;
end;

procedure Tddfeditorform.PngBitBtn10Click(Sender: TObject);
begin
  ShowMessage(_('Standardfunktionen:'+#13#10+'InitDevice(Device: String)'+#13#10+'FormShow'+#13#10+'FormRefresh(channel: Integer)'+#13#10+'FormClose'+#13#10+'ColorPickerChange(R, G, B: Byte)'+#13#10+'PositionXYChange(Top, Left: Integer)'+#13#10#13#10+'Innerhalb der Funktionen kann auf die Komponenteneigenschaften mit einem Punkt zugegriffen werden. Beispiel: "Checkbox1.Checked:=true", oder "Edit1.Text:=''Hello World''"'));
end;

procedure Tddfeditorform.PngBitBtn11Click(Sender: TObject);
var
  i:integer;
  colorchannel:boolean;
begin
  colorchannel:=false;

  for i:=0 to length(channels)-1 do
    if lowercase(channels[i].typ)='color1' then
      colorchannel:=true;

  if not colorchannel then
    ShowMessage(_('Das aktuell bearbeitete Gerät besitzt keinen Farbkanal (Farbrad, oder ähnliches).'+#13#10+'Das Definieren von Farben wird ohne einen Farbkanal ("COLOR1" oder "COLOR2") keine Auwirkungen haben. Die Funktion "Autofarbe" wird ebenfalls nicht zur Verfügung stehen.'+#13#10#13#10+'Fügen Sie einen neuen Kanal mit dem Typ "COLOR1" oder "COLOR2" hinzu, um die Farbfunktionen im PC_DIMMER nutzen zu können.'));

  setlength(colors,length(colors)+1);
  colors[length(colors)-1].name:='Farbe '+inttostr(length(colors));
  colors[length(colors)-1].value:=0;
  colors[length(colors)-1].valueend:=0;
  colors[length(colors)-1].R:=0;
  colors[length(colors)-1].G:=0;
  colors[length(colors)-1].B:=0;
  DDFEcolorlist.Items.Add(colors[length(colors)-1].name);
end;

procedure Tddfeditorform.DDFEcolorlistMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (DDFEcolorlist.Items.count>0) and (DDFEcolorlist.ItemIndex>-1) then
  begin
    DDFEcoloredit.Text:=colors[DDFEcolorlist.itemindex].name;
    DDFEcolorbutton.Color:=RGB2TColor(colors[DDFEcolorlist.ItemIndex].r,colors[DDFEcolorlist.ItemIndex].g,colors[DDFEcolorlist.ItemIndex].b);
    colorvalueedit.value:=colors[DDFEcolorlist.itemindex].value;
    colorvalueendedit.value:=colors[DDFEcolorlist.itemindex].valueend;
    ddfecoloredit.SelectAll;
    ddfecoloredit.SetFocus;
  end;
end;

procedure Tddfeditorform.DDFEcoloreditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if DDFEcolorlist.ItemIndex>-1 then
  begin
    colors[DDFEcolorlist.itemindex].name:=DDFEcoloredit.text;
    DDFEcolorlist.Items[DDFEcolorlist.ItemIndex]:=DDFEcoloredit.text;
  end;
end;

procedure Tddfeditorform.colorvalueeditChange(Sender: TObject);
begin
  if DDFEcolorlist.ItemIndex>-1 then
    colors[DDFEcolorlist.itemindex].value:=round(colorvalueedit.value);
end;

procedure Tddfeditorform.PngBitBtn12Click(Sender: TObject);
var
  i:integer;
begin
  if DDFEcolorlist.ItemIndex=-1 then exit;
  if DDFEcolorlist.Items.count=0 then exit;

  if length(colors)>0 then
  begin
    if DDFEcolorlist.itemindex<length(colors)-1 then
    begin
      for i:=DDFEcolorlist.ItemIndex to length(colors)-2 do
      begin
        colors[i]:=colors[i+1];
        DDFEcolorlist.Items[i]:=DDFEcolorlist.Items[i+1];
      end;
    end;
    setlength(colors,length(colors)-1);
    DDFEcolorlist.Items.Delete(DDFEcolorlist.Items.Count-1);
  end;
end;

procedure Tddfeditorform.DDFEcolorbuttonChange(Sender: TObject);
begin
  if DDFEcolorlist.ItemIndex>-1 then
    TColor2RGB(DDFEcolorbutton.Color,colors[DDFEcolorlist.ItemIndex].r,colors[DDFEcolorlist.ItemIndex].g,colors[DDFEcolorlist.ItemIndex].b);
end;

procedure Tddfeditorform.DDFEcolorlistKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (DDFEcolorlist.Items.count>0) and (DDFEcolorlist.ItemIndex>-1) then
  begin
    DDFEcoloredit.Text:=colors[DDFEcolorlist.itemindex].name;
    DDFEcolorbutton.Color:=RGB2TColor(colors[DDFEcolorlist.ItemIndex].r,colors[DDFEcolorlist.ItemIndex].g,colors[DDFEcolorlist.ItemIndex].b);
    colorvalueedit.value:=colors[DDFEcolorlist.itemindex].value;
    colorvalueendedit.value:=colors[DDFEcolorlist.itemindex].valueend;
  end;
end;

procedure Tddfeditorform.TBItem17Click(Sender: TObject);
begin
  colorbox.Visible:=true;
  setlength(functions,length(functions)+1);
  functions[length(functions)-1].name:='ColorBoxChange';
  functions[length(functions)-1].functext:='  begin'+#13#10+'    // Werten Sie hier die eingestellte Farbe der Farbbox aus. z.B. wie folgt:'+#13#10+'    case colorbox.itemindex of'+#13#10+'      0: set_channel(''COLOR1'', -1, 0, 0);'+#13#10+'    end;'+#13#10+'  end;';
  RefreshSelection;
end;

procedure Tddfeditorform.ColorBoxChange(Sender: TObject);
begin
  if (Sender=ColorBox) then
  begin
    startscript(ColorBox);
  end;
end;

procedure Tddfeditorform.ColorBox2Change(Sender: TObject);
begin
  if (Sender=ColorBox2) then
  begin
    startscript(ColorBox2);
  end;
end;

procedure Tddfeditorform.bildchangeClick(Sender: TObject);
{
var
  dateiname:string;
  i:integer;
}
begin
{
  OpenDialog1.InitialDir:=mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\';
  OpenDialog1.DefaultExt:='*.bmp';
  OpenDialog1.Filter:='Bild-Datei (*.bmp;*.ico)|*.bmp;*.ico|Alle Dateien (*.*)|*.*';
  if opendialog1.Execute then
  begin
    dateiname:=OpenDialog1.FileName;
    if ExtractFilePath(dateiname)=mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\' then
    begin
      bildedt.text:=ExtractFileName(dateiname);
      itempicture.Picture.LoadFromFile(dateiname);
      if itemlistbox.ItemIndex>-1 then
      begin
        for i:=0 to length(comboboxs)-1 do
        begin
          if comboboxs[i].name=LastSelectedComponent then
          begin
            comboboxproperties[i].picture[itemlistbox.ItemIndex]:=bildedt.text;
          end;
        end;
      end;
    end else
    begin
      bildedt.text:=dateiname;
      itempicture.Picture.LoadFromFile(dateiname);
      if itemlistbox.ItemIndex>-1 then
      begin
        for i:=0 to length(comboboxs)-1 do
        begin
          if comboboxs[i].name=LastSelectedComponent then
          begin
            comboboxproperties[i].picture[itemlistbox.ItemIndex]:=bildedt.text;
          end;
        end;
      end;
    end;
  end;
}
end;

procedure Tddfeditorform.bildedtKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{
var
  i:integer;
}
begin
{
  if FileExists(mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\'+bildedt.Text) then
  begin
    itempicture.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\'+bildedt.Text);
  end else if FileExists(bildedt.Text) then
  begin
    itempicture.Picture.LoadFromFile(bildedt.Text);
  end;

  if itemlistbox.ItemIndex>-1 then
  begin
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=LastSelectedComponent then
      begin
        comboboxproperties[i].picture[itemlistbox.ItemIndex]:=bildedt.text;
      end;
    end;
  end;
}
end;

procedure Tddfeditorform.itemlistboxchange;
var
  i:integer;
begin
  if itemlistbox.ItemIndex=-1 then exit;

    for i:=0 to length(radiobuttons)-1 do
    begin
      if radiobuttons[i].name=LastSelectedComponent then
      begin
        itemnameedit.text:=radiobuttons[i].Items[itemlistbox.ItemIndex];
        itemvalueedit.Value:=radiobuttonproperties[i].itemvalue[itemlistbox.ItemIndex];
        itemvalueendedit.Value:=radiobuttonproperties[i].itemvalueend[itemlistbox.ItemIndex];
      end;
    end;
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=LastSelectedComponent then
      begin
        itemnameedit.text:=comboboxs[i].Items[itemlistbox.ItemIndex];
        itemvalueedit.Value:=comboboxproperties[i].itemvalue[itemlistbox.ItemIndex];
        itemvalueendedit.Value:=comboboxproperties[i].itemvalueend[itemlistbox.ItemIndex];

        if FileExists(mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\'+comboboxproperties[i].picture[itemlistbox.ItemIndex]) then
        begin
          itempicture.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\'+comboboxproperties[i].picture[itemlistbox.ItemIndex]);
        end else if FileExists(comboboxproperties[i].picture[itemlistbox.ItemIndex]) then
        begin
          itempicture.Picture.LoadFromFile(comboboxproperties[i].picture[itemlistbox.ItemIndex]);
        end else
        begin
          itempicture.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\'+'leer.bmp');
        end;
      end;
    end;
end;


procedure Tddfeditorform.itemlistboxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  itemlistboxchange;
end;

procedure Tddfeditorform.minvalueeditChange(Sender: TObject);
begin
  channels[round(JvSpinEdit1.Value)-1].minvalue:=strtoint(minvalueedit.text);
end;

procedure Tddfeditorform.maxvalueeditChange(Sender: TObject);
begin
  channels[round(JvSpinEdit1.Value)-1].maxvalue:=strtoint(maxvalueedit.text);
end;

procedure Tddfeditorform.initvalueeditChange(Sender: TObject);
begin
  channels[round(JvSpinEdit1.Value)-1].initvalue:=strtoint(initvalueedit.text);
end;

procedure Tddfeditorform.Memo2Exit(Sender: TObject);
begin
  if funktionsliste1.itemindex<0 then exit;
  if funktionsliste1.ItemIndex=funktionsliste1.Items.Count-1 then
  begin
    globalevariablen:=Memo2.Text;
    exit;
  end;

  functions[funktionsliste1.itemindex].functext:=Memo2.Text;
  CreateCode;
end;

procedure Tddfeditorform.TBItem19Click(Sender: TObject);
begin
  dipswitchpanel.Visible:=true;
  RefreshSelection;
end;

procedure Tddfeditorform.PngBitBtn7Click(Sender: TObject);
var
  i,j,positiontodelete:integer;
begin
  if itemlistbox.itemindex>-1 then
  begin
    for i:=0 to length(radiobuttons)-1 do
    begin
      if radiobuttons[i].name=LastSelectedComponent then
      begin
        positiontodelete:=itemlistbox.ItemIndex;

        for j:=positiontodelete to itemlistbox.Count-2 do
        begin
          radiobuttons[i].Items[j]:=radiobuttons[i].Items[j+1];
          radiobuttonproperties[i].itemvalue[j]:=radiobuttonproperties[i].itemvalue[j+1];
          radiobuttonproperties[i].itemvalueend[j]:=radiobuttonproperties[i].itemvalueend[j+1];
          itemlistbox.Items[j]:=itemlistbox.Items[j+1];
        end;
        radiobuttons[i].Items.Delete(radiobuttons[i].Items.Count-1);
        setlength(radiobuttonproperties[i].itemvalue,length(radiobuttonproperties[i].itemvalue)-1);
        setlength(radiobuttonproperties[i].itemvalueend,length(radiobuttonproperties[i].itemvalueend)-1);
        itemlistbox.Items.Delete(itemlistbox.items.count-1);
      end;
    end;
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=LastSelectedComponent then
      begin
        positiontodelete:=itemlistbox.ItemIndex;

        for j:=positiontodelete to itemlistbox.Count-2 do
        begin
          Comboboxs[i].Items[j]:=Comboboxs[i].Items[j+1];
          Comboboxproperties[i].itemvalue[j]:=Comboboxproperties[i].itemvalue[j+1];
          Comboboxproperties[i].itemvalueend[j]:=Comboboxproperties[i].itemvalueend[j+1];
          Comboboxproperties[i].picture[j]:=Comboboxproperties[i].picture[j+1];
          itemlistbox.Items[j]:=itemlistbox.Items[j+1];
        end;
        Comboboxs[i].Items.Delete(Comboboxs[i].Items.Count-1);
        setlength(Comboboxproperties[i].itemvalue,length(Comboboxproperties[i].itemvalue)-1);
        setlength(Comboboxproperties[i].itemvalueend,length(Comboboxproperties[i].itemvalueend)-1);
        setlength(Comboboxproperties[i].picture,length(Comboboxproperties[i].picture)-1);
        itemlistbox.Items.Delete(itemlistbox.items.count-1);
      end;
    end;
  end;
end;

procedure Tddfeditorform.colorvalueendeditChange(Sender: TObject);
begin
  if DDFEcolorlist.ItemIndex>-1 then
    colors[DDFEcolorlist.itemindex].valueend:=round(colorvalueendedit.value);
end;

procedure Tddfeditorform.mbXPImageComboBox1Select(Sender: TObject);
var
  i:integer;
begin
  itempicture.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\GobosSmall\'+mbXPImageComboBox1.Items[mbXPImageComboBox1.ItemIndex]+'.bmp');

  if itemlistbox.ItemIndex>-1 then
  begin
    for i:=0 to length(comboboxs)-1 do
    begin
      if comboboxs[i].name=LastSelectedComponent then
      begin
        comboboxproperties[i].picture[itemlistbox.ItemIndex]:=mbXPImageComboBox1.Items[mbXPImageComboBox1.ItemIndex]+'.bmp';
      end;
    end;
  end;
end;

procedure Tddfeditorform.TBItem21Click(Sender: TObject);
begin
  colorbox2.Visible:=true;
  setlength(functions,length(functions)+1);
  functions[length(functions)-1].name:='ColorBoxChange2';
  functions[length(functions)-1].functext:='  begin'+#13#10+'    // Werten Sie hier die eingestellte Farbe der Farbbox aus. z.B. wie folgt:'+#13#10+'    case colorbox2.itemindex of'+#13#10+'      0: set_channel(''COLOR2'', -1, 0, 0);'+#13#10+'    end;'+#13#10+'  end;';
  RefreshSelection;
end;

procedure Tddfeditorform.DDFEcolorlist2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (DDFEcolorlist2.Items.count>0) and (DDFEcolorlist2.ItemIndex>-1) then
  begin
    DDFEcoloredit2.Text:=colors2[DDFEcolorlist2.itemindex].name;
    DDFEcolorbutton2.Color:=RGB2TColor(colors2[DDFEcolorlist2.ItemIndex].r,colors2[DDFEcolorlist2.ItemIndex].g,colors2[DDFEcolorlist2.ItemIndex].b);
    colorvalueedit2.value:=colors2[DDFEcolorlist2.itemindex].value;
    colorvalueendedit2.value:=colors2[DDFEcolorlist2.itemindex].valueend;
  end;
end;

procedure Tddfeditorform.DDFEcolorlist2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (DDFEcolorlist2.Items.count>0) and (DDFEcolorlist2.ItemIndex>-1) then
  begin
    DDFEcoloredit2.Text:=colors2[DDFEcolorlist2.itemindex].name;
    DDFEcolorbutton2.Color:=RGB2TColor(colors2[DDFEcolorlist2.ItemIndex].r,colors2[DDFEcolorlist2.ItemIndex].g,colors2[DDFEcolorlist2.ItemIndex].b);
    colorvalueedit2.value:=colors2[DDFEcolorlist2.itemindex].value;
    colorvalueendedit2.value:=colors2[DDFEcolorlist2.itemindex].valueend;
    ddfecoloredit2.SelectAll;
    ddfecoloredit2.SetFocus;
  end;
end;

procedure Tddfeditorform.DDFEcoloredit2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if DDFEcolorlist2.ItemIndex>-1 then
  begin
    colors2[DDFEcolorlist2.itemindex].name:=DDFEcoloredit2.text;
    DDFEcolorlist2.Items[DDFEcolorlist2.ItemIndex]:=DDFEcoloredit2.text;
  end;
end;

procedure Tddfeditorform.colorvalueedit2Change(Sender: TObject);
begin
  if DDFEcolorlist2.ItemIndex>-1 then
    colors2[DDFEcolorlist2.itemindex].value:=round(colorvalueedit2.value);
end;

procedure Tddfeditorform.colorvalueendedit2Change(Sender: TObject);
begin
  if DDFEcolorlist2.ItemIndex>-1 then
    colors2[DDFEcolorlist2.itemindex].valueend:=round(colorvalueendedit2.value);
end;

procedure Tddfeditorform.PngBitBtn9Click(Sender: TObject);
var
  i:integer;
  colorchannel:boolean;
begin
  colorchannel:=false;

  for i:=0 to length(channels)-1 do
    if lowercase(channels[i].typ)='color2' then
      colorchannel:=true;

  if not colorchannel then
    ShowMessage(_('Das aktuell bearbeitete Gerät besitzt keinen Farbkanal (Farbrad, oder ähnliches).')+#13#10+_('Das Definieren von Farben wird ohne einen Farbkanal ("COLOR2") keine Auwirkungen haben. Die Funktion "Autofarbe" wird ebenfalls nicht zur Verfügung stehen.')+#13#10#13#10+_('Fügen Sie einen neuen Kanal mit dem Typ "COLOR2" hinzu, um die Farbfunktionen im PC_DIMMER nutzen zu können.'));

  setlength(colors2,length(colors2)+1);
  colors2[length(colors2)-1].name:='Farbe '+inttostr(length(colors2));
  colors2[length(colors2)-1].value:=0;
  colors2[length(colors2)-1].valueend:=0;
  colors2[length(colors2)-1].R:=0;
  colors2[length(colors2)-1].G:=0;
  colors2[length(colors2)-1].B:=0;
  DDFEcolorlist2.Items.Add(colors2[length(colors2)-1].name);
end;

procedure Tddfeditorform.PngBitBtn13Click(Sender: TObject);
var
  i:integer;
begin
  if DDFEcolorlist2.ItemIndex=-1 then exit;
  if DDFEcolorlist2.Items.count=0 then exit;

  if length(colors2)>0 then
  begin
    if DDFEcolorlist2.itemindex<length(colors2)-1 then
    begin
      for i:=DDFEcolorlist2.ItemIndex to length(colors2)-2 do
      begin
        colors2[i]:=colors2[i+1];
        DDFEcolorlist2.Items[i]:=DDFEcolorlist2.Items[i+1];
      end;
    end;
    setlength(colors2,length(colors2)-1);
    DDFEcolorlist2.Items.Delete(DDFEcolorlist2.Items.Count-1);
  end;
end;

procedure Tddfeditorform.DDFEcolorbutton2Change(Sender: TObject);
begin
  if DDFEcolorlist2.ItemIndex>-1 then
    TColor2RGB(DDFEcolorbutton2.Color,colors2[DDFEcolorlist2.ItemIndex].r,colors2[DDFEcolorlist2.ItemIndex].g,colors2[DDFEcolorlist2.ItemIndex].b);
end;

procedure Tddfeditorform.DDFEgobolistKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (DDFEgobolist.Items.count>0) and (DDFEgobolist.ItemIndex>-1) then
  begin
    DDFEgoboedit.Text:=gobos[DDFEgobolist.itemindex].name;
    gobovalueedit.value:=gobos[DDFEgobolist.itemindex].value;
    gobovalueendedit.value:=gobos[DDFEgobolist.itemindex].valueend;
  end;
  DDFEgobolistindex:=DDFEgobolist.itemindex;
end;

procedure Tddfeditorform.DDFEgobolistMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (DDFEgobolist.Items.count>0) and (DDFEgobolist.ItemIndex>-1) then
  begin
    DDFEgoboedit.Text:=gobos[DDFEgobolist.itemindex].name;
    gobovalueedit.value:=gobos[DDFEgobolist.itemindex].value;
    gobovalueendedit.value:=gobos[DDFEgobolist.itemindex].valueend;
    ddfegoboedit.SelectAll;
    ddfegoboedit.SetFocus;
  end;
  DDFEgobolistindex:=DDFEgobolist.itemindex;
end;

procedure Tddfeditorform.gobovalueeditChange(Sender: TObject);
begin
  if DDFEgobolist.ItemIndex>-1 then
    gobos[DDFEgobolist.itemindex].value:=round(gobovalueedit.value);
end;

procedure Tddfeditorform.gobovalueendeditChange(Sender: TObject);
begin
  if DDFEgobolist.ItemIndex>-1 then
    gobos[DDFEgobolist.itemindex].valueend:=round(gobovalueendedit.value);
end;

procedure Tddfeditorform.PngBitBtn14Click(Sender: TObject);
var
  i:integer;
  gobochannel:boolean;
begin
  gobochannel:=false;

  for i:=0 to length(channels)-1 do
    if lowercase(channels[i].typ)='gobo1' then
      gobochannel:=true;

  if not gobochannel then
    ShowMessage(_('Das aktuell bearbeitete Gerät besitzt keinen Gobokanal.'+#13#10+'Das Definieren von Gobos wird ohne einen Gobokanal ("Gobo1") keine Auwirkungen haben.'+#13#10#13#10+'Fügen Sie einen neuen Kanal mit dem Typ "Gobo1" hinzu, um die Gobofunktionen im PC_DIMMER nutzen zu können.'));

  setlength(gobos,length(gobos)+1);
  gobos[length(gobos)-1].name:='Gobo '+inttostr(length(gobos));
  gobos[length(gobos)-1].value:=0;
  gobos[length(gobos)-1].valueend:=0;
  gobos[length(gobos)-1].filename:='';
  DDFEgobolist.Items.Add;
  DDFEgobolist.Items.Items[DDFEgobolist.Items.Count-1].Text:=gobos[length(gobos)-1].name;
end;

procedure Tddfeditorform.PngBitBtn15Click(Sender: TObject);
var
  i:integer;
begin
  if DDFEgobolistindex=-1 then exit;
  if DDFEgobolist.Items.count=0 then exit;
  if DDFEgobolistindex>=DDFEgobolist.Items.count then exit;

  if length(gobos)>0 then
  begin
    if DDFEgobolistindex<length(gobos)-1 then
    begin
      for i:=DDFEgobolistindex to length(gobos)-2 do
      begin
        gobos[i]:=gobos[i+1];
        DDFEgobolist.Items[i]:=DDFEgobolist.Items[i+1];
      end;
    end;
    setlength(gobos,length(gobos)-1);
    DDFEgobolist.Items.Delete(DDFEgobolist.Items.Count-1);
  end;
end;

procedure Tddfeditorform.DDFEgoboeditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if DDFEgobolistindex>-1 then
  begin
    gobos[DDFEgobolistindex].name:=DDFEgoboedit.text;
    DDFEgobolist.Items.Items[DDFEgobolistindex].Text:=DDFEgoboedit.text;
  end;
end;

procedure Tddfeditorform.goboselectboxSelect(Sender: TObject);
begin
  if DDFEgobolistindex>-1 then
  begin
    gobos[DDFEgobolistindex].filename:=goboselectbox.Items[goboselectbox.ItemIndex]+'.png';
    DDFEgobolist.Items.Items[DDFEgobolistindex].ImageIndex:=goboselectbox.ItemIndex;
  end;
end;

procedure Tddfeditorform.DDFEgobolist2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (DDFEgobolist2.Items.count>0) and (DDFEgobolist2.ItemIndex>-1) then
  begin
    DDFEgoboedit2.Text:=gobos2[DDFEgobolist2.itemindex].name;
    gobovalueedit2.value:=gobos2[DDFEgobolist2.itemindex].value;
    gobovalueendedit2.value:=gobos2[DDFEgobolist2.itemindex].valueend;
  end;
  DDFEgobolist2index:=DDFEgobolist2.itemindex;
end;

procedure Tddfeditorform.DDFEgobolist2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (DDFEgobolist2.Items.count>0) and (DDFEgobolist2.ItemIndex>-1) then
  begin
    DDFEgoboedit2.Text:=gobos2[DDFEgobolist2.itemindex].name;
    gobovalueedit2.value:=gobos2[DDFEgobolist2.itemindex].value;
    gobovalueendedit2.value:=gobos2[DDFEgobolist2.itemindex].valueend;
    ddfegoboedit2.SelectAll;
    ddfegoboedit2.SetFocus;
  end;
  DDFEgobolist2index:=DDFEgobolist2.itemindex;
end;

procedure Tddfeditorform.DDFEgoboedit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if DDFEgobolist2index>-1 then
  begin
    gobos2[DDFEgobolist2index].name:=DDFEgoboedit2.text;
    DDFEgobolist2.Items.Items[DDFEgobolist2index].Text:=DDFEgoboedit2.text;
  end;
end;

procedure Tddfeditorform.goboselectbox2Select(Sender: TObject);
begin
  if DDFEgobolist2index>-1 then
  begin
    gobos2[DDFEgobolist2index].filename:=goboselectbox2.Items[goboselectbox2.ItemIndex]+'.png';
    DDFEgobolist2.Items.Items[DDFEgobolist2index].ImageIndex:=goboselectbox2.ItemIndex;
  end;
end;

procedure Tddfeditorform.gobovalueedit2Change(Sender: TObject);
begin
  if DDFEgobolist2.ItemIndex>-1 then
    gobos2[DDFEgobolist2.itemindex].value:=round(gobovalueedit2.value);
end;

procedure Tddfeditorform.gobovalueendedit2Change(Sender: TObject);
begin
  if DDFEgobolist2.ItemIndex>-1 then
    gobos2[DDFEgobolist2.itemindex].valueend:=round(gobovalueendedit2.value);
end;

procedure Tddfeditorform.PngBitBtn16Click(Sender: TObject);
var
  i:integer;
  gobochannel:boolean;
begin
  gobochannel:=false;

  for i:=0 to length(channels)-1 do
    if lowercase(channels[i].typ)='gobo2' then
      gobochannel:=true;

  if not gobochannel then
    ShowMessage(_('Das aktuell bearbeitete Gerät besitzt keinen Gobokanal.')+#13#10+_('Das Definieren von Gobos wird ohne einen Gobokanal ("Gobo2") keine Auwirkungen haben.')+#13#10#13#10+_('Fügen Sie einen neuen Kanal mit dem Typ "Gobo2" hinzu, um die Gobofunktionen im PC_DIMMER nutzen zu können.'));

  setlength(gobos2,length(gobos2)+1);
  gobos2[length(gobos2)-1].name:='Gobo '+inttostr(length(gobos2));
  gobos2[length(gobos2)-1].value:=0;
  gobos2[length(gobos2)-1].valueend:=0;
  gobos2[length(gobos2)-1].filename:='';
  DDFEgobolist2.Items.Add;
  DDFEgobolist2.Items.Items[DDFEgobolist2.Items.Count-1].Text:=gobos2[length(gobos2)-1].name;
end;

procedure Tddfeditorform.PngBitBtn17Click(Sender: TObject);
var
  i:integer;
begin
  if DDFEgobolist2index=-1 then exit;
  if DDFEgobolist2.Items.count=0 then exit;
  if DDFEgobolist2index>=DDFEgobolist2.Items.count then exit;

  if length(gobos2)>0 then
  begin
    if DDFEgobolist2index<length(gobos2)-1 then
    begin
      for i:=DDFEgobolist2index to length(gobos2)-2 do
      begin
        gobos2[i]:=gobos2[i+1];
        DDFEgobolist2.Items[i]:=DDFEgobolist2.Items[i+1];
      end;
    end;
    setlength(gobos2,length(gobos2)-1);
    DDFEgobolist2.Items.Delete(DDFEgobolist2.Items.Count-1);
  end;
end;

procedure Tddfeditorform.standardfunktionenDropDown(Sender: TObject);
begin
  standardfunktionen.Width:=193;//panel2.width-standardfunktionen.Top;
end;

procedure Tddfeditorform.standardfunktionenCloseUp(Sender: TObject);
begin
  standardfunktionen.Width:=225;
end;

procedure Tddfeditorform.spezialfunktionenSelect(Sender: TObject);
var
  funktion:string;
  i:integer;
begin
  case spezialfunktionen.ItemIndex of
    0:
    begin
      funktion:='    case colorbox.itemindex of'+#13#10;
      for i:=0 to length(colors)-1 do
        funktion:=funktion+'      '+inttostr(i)+': set_channel(''color1'', -1, '+inttostr(colors[i].value)+', 0);'+#13#10;
      funktion:=funktion+'    end;';
      memo2.SelText:=funktion;
    end;
    1:
    begin
      funktion:='    case colorbox2.itemindex of'+#13#10;
      for i:=0 to length(colors2)-1 do
        funktion:=funktion+'      '+inttostr(i)+': set_channel(''color2'', -1, '+inttostr(colors2[i].value)+', 0);'+#13#10;
      funktion:=funktion+'    end;';
      memo2.SelText:=funktion;
    end;
    2:
    begin
      funktion:='    case gobobox.itemindex of'+#13#10;
      for i:=0 to length(gobos)-1 do
        funktion:=funktion+'      '+inttostr(i)+': set_channel(''gobo1'', -1, '+inttostr(gobos[i].value)+', 0);'+#13#10;
      funktion:=funktion+'    end;';
      memo2.SelText:=funktion;
    end;
    3:
    begin
      funktion:='    case gobobox2.itemindex of'+#13#10;
      for i:=0 to length(gobos2)-1 do
        funktion:=funktion+'      '+inttostr(i)+': set_channel(''gobo2'', -1, '+inttostr(gobos2[i].value)+', 0);'+#13#10;
      funktion:=funktion+'    end;';
      memo2.SelText:=funktion;
    end;
    4:
    begin
      funktion:='    dontrefresh:=true;'+#13#10;
      funktion:=funktion+'    set_channel(''dimmer'', -1, dimmerslider.position, 0);';
      memo2.SelText:=funktion;
    end;
    5:
    begin
      funktion:='    dontrefresh:=true;'+#13#10;
      funktion:=funktion+'    // nachfolgend muss #KANAL# durch den korrekten Kanal ersetzt werden und mycombobox durch die korrekte Combobox. Auch der multiplizierte Wert muss an das Gerät angepasst werden.'+#13#10;
      funktion:=funktion+'    set_channel(''#KANAL#'', -1, mycombobox.itemindex*32, 0);'+#13#10;
      funktion:=funktion+'    // Alternativ kann folgendes verwendet werden'+#13#10;
      funktion:=funktion+'    {'+#13#10;
      funktion:=funktion+'    case mycombobox.itemindex of'+#13#10;
      funktion:=funktion+'      0:'+#13#10;
      funktion:=funktion+'      begin'+#13#10;
      funktion:=funktion+'        set_channel(''#KANAL#'', -1, 0, 0);'+#13#10;
      funktion:=funktion+'      end;'+#13#10;
      funktion:=funktion+'      1:'+#13#10;
      funktion:=funktion+'      begin'+#13#10;
      funktion:=funktion+'        set_channel(''#KANAL#'', -1, 32, 0);'+#13#10;
      funktion:=funktion+'      end;'+#13#10;
      funktion:=funktion+'      2:'+#13#10;
      funktion:=funktion+'      begin'+#13#10;
      funktion:=funktion+'        set_channel(''#KANAL#'', -1, 64, 0);'+#13#10;
      funktion:=funktion+'      end;'+#13#10;
      funktion:=funktion+'    end;'+#13#10;
      funktion:=funktion+'    }';
      memo2.SelText:=funktion;
    end;
    7:
    begin
      funktion:='    value:=get_channel(''color1'');'+#13#10;
      funktion:=funktion+'    case value of'+#13#10;
      for i:=0 to length(colors)-1 do
        funktion:=funktion+'      '+inttostr(colors[i].value)+'..'+inttostr(colors[i].valueend)+': colorbox.itemindex:='+inttostr(i)+';'+#13#10;
      funktion:=funktion+'    end;';
      memo2.SelText:=funktion;
    end;
    8:
    begin
      funktion:='    value:=get_channel(''color2'');'+#13#10;
      funktion:=funktion+'    case value of'+#13#10;
      for i:=0 to length(colors2)-1 do
        funktion:=funktion+'      '+inttostr(colors2[i].value)+'..'+inttostr(colors2[i].valueend)+': colorbox2.itemindex:='+inttostr(i)+';'+#13#10;
      funktion:=funktion+'    end;';
      memo2.SelText:=funktion;
    end;
    9:
    begin
      funktion:='    value:=get_channel(''gobo1'');'+#13#10;
      funktion:=funktion+'    case value of'+#13#10;
      for i:=0 to length(gobos)-1 do
        funktion:=funktion+'      '+inttostr(gobos[i].value)+'..'+inttostr(gobos[i].valueend)+': gobobox.itemindex:='+inttostr(i)+';'+#13#10;
      funktion:=funktion+'    end;';
      memo2.SelText:=funktion;
    end;
    10:
    begin
      funktion:='    value:=get_channel(''gobo2'');'+#13#10;
      funktion:=funktion+'    case value of'+#13#10;
      for i:=0 to length(gobos2)-1 do
        funktion:=funktion+'      '+inttostr(gobos2[i].value)+'..'+inttostr(gobos2[i].valueend)+': gobobox2.itemindex:='+inttostr(i)+';'+#13#10;
      funktion:=funktion+'    end;';
      memo2.SelText:=funktion;
    end;
    11:
    begin
      funktion:='    dimmerslider.position:=get_channel(''dimmer'');'+#13#10;
      memo2.SelText:=funktion;
    end;
    12:
    begin
      funktion:='    value:=get_channel(''#KANAL#'');'+#13#10;
      funktion:=funktion+'    // #KANAL# muss durch den korrekten Kanal ersetzt werden und mycombobox durch die korrekte Combobox. Auch der multiplizierte Wert muss an das Gerät angepasst werden.'+#13#10;
      funktion:=funktion+'    mycombobox.itemindex:=trunc(value/32);'+#13#10;
      funktion:=funktion+'    // Alternativ kann folgendes verwendet werden'+#13#10;
      funktion:=funktion+'    {'+#13#10;
      funktion:=funktion+'    case value of'+#13#10;
      funktion:=funktion+'      0..31:'+#13#10;
      funktion:=funktion+'      begin'+#13#10;
      funktion:=funktion+'        mycombobox.itemindex:=0;'+#13#10;
      funktion:=funktion+'      end;'+#13#10;
      funktion:=funktion+'      32..63:'+#13#10;
      funktion:=funktion+'      begin'+#13#10;
      funktion:=funktion+'        mycombobox.itemindex:=1;'+#13#10;
      funktion:=funktion+'      end;'+#13#10;
      funktion:=funktion+'      64..95:'+#13#10;
      funktion:=funktion+'      begin'+#13#10;
      funktion:=funktion+'        mycombobox.itemindex:=2;'+#13#10;
      funktion:=funktion+'      end;'+#13#10;
      funktion:=funktion+'    end;'+#13#10;
      funktion:=funktion+'    }';
      memo2.SelText:=funktion;
    end;
  end;
end;

procedure Tddfeditorform.autoddfbtnClick(Sender: TObject);
var
  i,j:integer;
  PANTILTinserted, RGBinserted, HasFineChannels:boolean;
  NumberOfSliders, TopOfRightSide:integer;
begin
  // Größe entsprechend anpassen
//  widthspin.value:=233+226+8;
//  heightspin.Value:=500;

  PANTILTinserted:=false;
  RGBinserted:=false;
  HasFineChannels:=false;
  NumberOfSliders:=0;
  TopOfRightSide:=8;
  
  for i:=0 to length(channels)-1 do
  begin
    if (Uppercase(channels[i].typ)='PAN') or (Uppercase(channels[i].typ)='TILT') then
    begin
      if not PANTILTinserted then
      begin
        PANTILTinserted:=true;

        fadenkreuz.Visible:=true;
        fadenkreuz.Left:=233;
        fadenkreuz.top:=TopOfRightSide;
        TopOfRightSide:=TopOfRightSide+226+8;

        setlength(functions,length(functions)+1);
        functions[length(functions)-1].name:='PositionXYChange(Top, Left: Integer)';
      //  functions[length(functions)-1].functext:='  begin'+#13#10+'    if panmirror.checked then'+#13#10+'      set_channel(''pan'',255-((PositionXY.Left+(PositionXY.Width div 2))/fadenkreuz.Width)*255,255-((PositionXY.Left+(PositionXY.Width div 2))/fadenkreuz.Width)*255,0)'+#13#10+'    else'+#13#10+'      set_channel(''pan'',((PositionXY.Left+(PositionXY.Width div 2))/fadenkreuz.Width)*255,((PositionXY.Left+(PositionXY.Width div 2))/fadenkreuz.Width)*255,0);'+#13#10+'  if tiltmirror.checked then'+#13#10+'      set_channel(''tilt'',255-((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255,255-((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255,0)'+#13#10+'    else'+#13#10+'      set_channel(''tilt'',((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255,((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255,0);'+#13#10+'  end;';
        functions[length(functions)-1].functext:='  var'+#13#10+'	phi,r,x,y:Double;'+#13#10+'	pan, tilt, panfine, tiltfine:Double;'+#13#10+'  begin'+#13#10+'	if usemhcontrol.checked then'+#13#10+'	begin'+#13#10+'		// Moving-Head-Steuerung (Polarkoordinaten)'+#13#10+'		x:=((PositionXY.Left+(PositionXY.Width div 2)-(fadenkreuz.Width/2))/fadenkreuz.Width)*2;	//-1..0..1'+#13#10+
      '		y:=((PositionXY.Top+(PositionXY.Height div 2)-(fadenkreuz.Width/2))/fadenkreuz.Height)*2;	//-1..0..1'+#13#10+'		r:=sqrt(x*x+y*y);'+#13#10+'	'+#13#10+'		if (r>0) then'+#13#10+'		begin'+#13#10+'			if (y>=0) then'+#13#10+'				phi:=arccos(x/r)'+#13#10+'			else'+#13#10+'				phi:=6.283185307179586476925286766559-arccos(x/r);'+#13#10+
      '		end else'+#13#10+'			phi:=64;'+#13#10+'		'+#13#10+'		r:=128-((r/2)*255);'+#13#10+'		phi:=(phi/6.283185307179586476925286766559)*255;'+#13#10+'		if 64>=phi then'+#13#10+'			phi:=phi+191'+#13#10+'		else'+#13#10+'			phi:=phi-64;'+#13#10+'	'+#13#10+'		pan:=255-phi;'+#13#10+'		tilt:=255-r;'+#13#10+'	end else'+#13#10+'	begin'+#13#10+
      '		// Scannersteuerung (Kartesische Koordinaten)'+#13#10+'		pan:=((PositionXY.Left+(PositionXY.Width div 2))/fadenkreuz.Width)*255;'+#13#10+'		tilt:=((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255;'+#13#10+'	end;'+#13#10+''+#13#10+'	// Ausgabe'+#13#10+'	if panmirror.checked then'+#13#10+'	begin'+#13#10+'		dontrefresh:=true;'+#13#10+
      '		set_channel(''pan'',trunc(255-pan),trunc(255-pan),0);'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''panfine'',trunc(frac(255-pan)*255),trunc(frac(255-pan)*255),0);'+#13#10+'	end	else'+#13#10+'	begin'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''pan'',trunc(pan),trunc(pan),0);'+#13#10+'		dontrefresh:=true;'+#13#10+
      '		set_channel(''panfine'',trunc(frac(pan)*255),trunc(frac(pan)*255),0);'+#13#10+'	end;'+#13#10+'	if tiltmirror.checked then'+#13#10+'	begin'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''tilt'',trunc(255-tilt),trunc(255-tilt),0);'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''tiltfine'',trunc(frac(255-tilt)*255),trunc(frac(255-tilt)*255),0);'+#13#10+
      '	end	else'+#13#10+'	begin'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''tilt'',trunc(tilt),trunc(tilt),0);'+#13#10+'		dontrefresh:=true;'+#13#10+'		set_channel(''tiltfine'',trunc(frac(tilt)*255),trunc(frac(tilt)*255),0);'+#13#10+'	end;'+#13#10+'  end;';
      end;
    end else if (Uppercase(channels[i].typ)='R') or (Uppercase(channels[i].typ)='G') or (Uppercase(channels[i].typ)='B') then
    begin
      if not RGBinserted then
      begin
        RGBinserted:=true;

        Colorpicker.visible:=true;
        Colorpicker.Left:=233;
        colorpicker.top:=TopOfRightSide;
        TopOfRightSide:=TopOfRightSide+137+8+25+4;

        setlength(buttons,length(buttons)+1);
        setlength(buttonproperties,length(buttonproperties)+1);
        buttons[length(buttons)-1]:=TButton.Create(buttons[length(buttons)-1]);
        buttons[length(buttons)-1].Parent:=panel1;
        buttons[length(buttons)-1].Caption:=_('Andere Farbauswahl');
        buttons[length(buttons)-1].Name:='SwitchColorPickerBtn';
        buttons[length(buttons)-1].Top:=colorpicker.top+133+4;
        buttons[length(buttons)-1].Left:=colorpicker.left+1;
        buttons[length(buttons)-1].Width:=150;
        buttonproperties[length(buttonproperties)-1].actionname:='SwitchColorPicker';


        setlength(functions,length(functions)+1);
        functions[length(functions)-1].name:='ColorPickerChange(R, G, B: Byte)';
        functions[length(functions)-1].functext:='  begin'+#13#10+'    set_channel(''r'',-1,r,0);'+#13#10+'    set_channel(''g'',-1,g,0);'+#13#10+'    set_channel(''b'',-1,b,0);'+#13#10+'    set_channel(''c'',-1,255-r,0);'+#13#10+'    set_channel(''m'',-1,255-g,0);'+#13#10+'    set_channel(''y'',-1,255-b,0);'+#13#10+'  end;';

        setlength(functions,length(functions)+1);
        functions[length(functions)-1].name:='SwitchColorPicker';
        functions[length(functions)-1].functext:=
        '  begin'+#13#10+
        '    if colorpicker.visible then'+#13#10+
        '    begin'+#13#10+
        '      colorpicker.visible:=false;'+#13#10+
        '      colorpicker2.visible:=true;'+#13#10+
        '    end else'+#13#10+
        '    begin'+#13#10+
        '      colorpicker.visible:=true;'+#13#10+
        '      colorpicker2.visible:=false;'+#13#10+
        '    end;'+#13#10+
        '  end;';
      end;
    end else if Uppercase(channels[i].typ)='COLOR1' then
    begin
      colorbox.Visible:=true;
      colorbox.Left:=233;
      colorbox.Top:=TopOfRightSide;
      TopOfRightSide:=TopOfRightSide+22+8;

      // Funktion für den Kanal erzeugen
      setlength(functions,length(functions)+1);
      funktionsliste1.items.Insert(funktionsliste1.items.Count-1 ,'ColorBoxChange');
      functions[length(functions)-1].name:='ColorBoxChange';
      functions[length(functions)-1].functext:=
      '  begin'+#13#10+
      '    case colorbox.itemindex of'+#13#10;
      for j:=0 to length(colors)-1 do
        functions[length(functions)-1].functext:=functions[length(functions)-1].functext+'      '+inttostr(j)+': set_channel(''color1'', -1, '+inttostr(colors[j].value)+', 0);'+#13#10;
      functions[length(functions)-1].functext:=functions[length(functions)-1].functext+
      '    end;'+#13#10+
      '  end;';
    end else if Uppercase(channels[i].typ)='COLOR2' then
    begin
      colorbox2.Visible:=true;
      colorbox2.Left:=233;
      colorbox2.Top:=TopOfRightSide;
      TopOfRightSide:=TopOfRightSide+22+8;

      // Funktion für den Kanal erzeugen
      setlength(functions,length(functions)+1);
      funktionsliste1.items.Insert(funktionsliste1.items.Count-1 ,'ColorBoxChange2');
      functions[length(functions)-1].name:='ColorBoxChange2';
      functions[length(functions)-1].functext:=
      '  begin'+#13#10+
      '    case colorbox2.itemindex of'+#13#10;
      for j:=0 to length(colors2)-1 do
        functions[length(functions)-1].functext:=functions[length(functions)-1].functext+'      '+inttostr(j)+': set_channel(''color2'', -1, '+inttostr(colors2[j].value)+', 0);'+#13#10;
      functions[length(functions)-1].functext:=functions[length(functions)-1].functext+
      '    end;'+#13#10+
      '  end;';
    end else if Uppercase(channels[i].typ)='GOBO1' then
    begin
      setlength(comboboxs,length(comboboxs)+1);
      setlength(ComboboxsImageList,length(ComboboxsImageList)+1);
      setlength(comboboxproperties,length(comboboxproperties)+1);
      comboboxs[length(comboboxs)-1]:=TmbXPImageCombobox.Create(comboboxs[length(comboboxs)-1]);//TCombobox.Create(comboboxs[length(comboboxs)-1]);
      comboboxs[length(comboboxs)-1].Parent:=panel1;
      comboboxs[length(comboboxs)-1].Text:='GOBOBOX1';
      comboboxs[length(comboboxs)-1].Name:='GOBOBOX1';
      comboboxs[length(comboboxs)-1].Left:=233;
      comboboxs[length(comboboxs)-1].Top:=TopOfRightSide;
      TopOfRightSide:=TopOfRightSide+22+8;
      ComboboxsImageList[length(ComboboxsImageList)-1]:=TImageList.Create(self);
      Comboboxproperties[length(comboboxs)-1].actionname:='gobo1change';

      for j:=0 to length(gobos)-1 do
      begin
        comboboxs[length(comboboxs)-1].Items.Add(gobos[j].name);
        setlength(Comboboxproperties[length(comboboxs)-1].itemvalue,Comboboxs[length(comboboxs)-1].Items.Count);
        setlength(Comboboxproperties[length(comboboxs)-1].itemvalueend,Comboboxs[length(comboboxs)-1].Items.Count);
        setlength(Comboboxproperties[length(comboboxs)-1].picture,Comboboxs[length(comboboxs)-1].Items.Count);
        Comboboxproperties[length(comboboxs)-1].itemvalue[Comboboxs[length(comboboxs)-1].Items.Count-1]:=gobos[j].value;
        Comboboxproperties[length(comboboxs)-1].itemvalueend[Comboboxs[length(comboboxs)-1].Items.Count-1]:=gobos[j].valueend;
        comboboxproperties[length(comboboxs)-1].picture[j]:=copy(gobos[j].filename, 0, length(gobos[j].filename)-4)+'.bmp';
      end;
                  
      setlength(functions,length(functions)+1);
      funktionsliste1.items.Insert(funktionsliste1.items.Count-1 ,channels[i].typ+'change');
      functions[length(functions)-1].name:=channels[i].typ+'change';
      functions[length(functions)-1].functext:=
      '  begin'+#13#10+
      '    case gobobox1.itemindex of'+#13#10;
      for j:=0 to length(gobos)-1 do
        functions[length(functions)-1].functext:=functions[length(functions)-1].functext+'      '+inttostr(j)+': set_channel(''gobo1'', -1, '+inttostr(gobos[j].value)+', 0);'+#13#10;
      functions[length(functions)-1].functext:=functions[length(functions)-1].functext+
      '    end;'+#13#10+
      '  end;';
    end else if Uppercase(channels[i].typ)='GOBO2' then
    begin
      setlength(comboboxs,length(comboboxs)+1);
      setlength(ComboboxsImageList,length(ComboboxsImageList)+1);
      setlength(comboboxproperties,length(comboboxproperties)+1);
      comboboxs[length(comboboxs)-1]:=TmbXPImageCombobox.Create(comboboxs[length(comboboxs)-1]);//TCombobox.Create(comboboxs[length(comboboxs)-1]);
      comboboxs[length(comboboxs)-1].Parent:=panel1;
      comboboxs[length(comboboxs)-1].Text:='GOBOBOX2';
      comboboxs[length(comboboxs)-1].Name:='GOBOBOX2';
      comboboxs[length(comboboxs)-1].Left:=233;
      comboboxs[length(comboboxs)-1].Top:=TopOfRightSide;
      TopOfRightSide:=TopOfRightSide+22+8;
      ComboboxsImageList[length(ComboboxsImageList)-1]:=TImageList.Create(self);
      Comboboxproperties[length(comboboxs)-1].actionname:='gobo2change';

      for j:=0 to length(gobos2)-1 do
      begin
        comboboxs[length(comboboxs)-1].Items.Add(gobos2[j].name);
        setlength(Comboboxproperties[length(comboboxs)-1].itemvalue,Comboboxs[length(comboboxs)-1].Items.Count);
        setlength(Comboboxproperties[length(comboboxs)-1].itemvalueend,Comboboxs[length(comboboxs)-1].Items.Count);
        setlength(Comboboxproperties[length(comboboxs)-1].picture,Comboboxs[length(comboboxs)-1].Items.Count);
        Comboboxproperties[length(comboboxs)-1].itemvalue[Comboboxs[length(comboboxs)-1].Items.Count-1]:=gobos2[j].value;
        Comboboxproperties[length(comboboxs)-1].itemvalueend[Comboboxs[length(comboboxs)-1].Items.Count-1]:=gobos2[j].valueend;
        comboboxproperties[length(comboboxs)-1].picture[j]:=copy(gobos2[j].filename, 0, length(gobos2[j].filename)-4)+'.bmp';
      end;

      setlength(functions,length(functions)+1);
      funktionsliste1.items.Insert(funktionsliste1.items.Count-1 ,channels[i].typ+'change');
      functions[length(functions)-1].name:=channels[i].typ+'change';
      functions[length(functions)-1].functext:=
      '  begin'+#13#10+
      '    case gobobox2.itemindex of'+#13#10;
      for j:=0 to length(gobos2)-1 do
        functions[length(functions)-1].functext:=functions[length(functions)-1].functext+'      '+inttostr(j)+': set_channel(''gobo2'', -1, '+inttostr(gobos2[j].value)+', 0);'+#13#10;
      functions[length(functions)-1].functext:=functions[length(functions)-1].functext+
      '    end;'+#13#10+
      '  end;';
    end else
    begin
      if not HasFineChannels then
        HasFineChannels:=((Uppercase(channels[i].typ)='PANFINE') or (Uppercase(channels[i].typ)='TILTFINE'));

      // Label des Kanals erzeugen
      setlength(Labels,length(Labels)+1);
      labels[length(labels)-1]:=TLabel.Create(labels[length(labels)-1]);
      labels[length(labels)-1].Parent:=panel1;
      labels[length(labels)-1].Caption:=channels[i].name;
      labels[length(labels)-1].Name:=channels[i].typ+'lbl'+inttostr(i);
      labels[length(labels)-1].Top:=80+NumberOfSliders*40;
      labels[length(labels)-1].Left:=8;

      // Slider für den Kanal erzeugen
      setlength(sliders,length(sliders)+1);
      setlength(sliderproperties,length(sliderproperties)+1);
      sliders[length(sliders)-1]:=TScrollbar.Create(sliders[length(sliders)-1]);
      sliders[length(sliders)-1].Parent:=panel1;
      sliders[length(sliders)-1].Name:=channels[i].typ+'slider'+inttostr(i);
      sliders[length(sliders)-1].Top:=96+NumberOfSliders*40;
      sliders[length(sliders)-1].Left:=8;
      sliders[length(sliders)-1].Min:=channels[i].minvalue;
      sliders[length(sliders)-1].Max:=channels[i].maxvalue;
      sliders[length(sliders)-1].Width:=217;
      sliders[length(sliders)-1].position:=channels[i].initvalue;
      sliderproperties[length(sliders)-1].actionname:=channels[i].typ+'change';

      NumberOfSliders:=NumberOfSliders+1;

      // Funktion für den Kanal erzeugen
      setlength(functions,length(functions)+1);
      funktionsliste1.items.Insert(funktionsliste1.items.Count-1 ,channels[i].typ+'change');
      functions[length(functions)-1].name:=channels[i].typ+'change';
      functions[length(functions)-1].functext:=
      '  begin'+#13#10+
      '    DontRefresh:=true;'+#13#10+#13#10+

      '    set_channel('''+channels[i].typ+''',-1,'+channels[i].typ+'slider'+inttostr(i)+'.position,0);'+#13#10+
      '  end;';
    end;
  end;

  if ((NumberOfSliders*40+96)>(TopOfRightSide+8)) and ((NumberOfSliders*40+96)>heightspin.value) then
    heightspin.value:=(NumberOfSliders*40+96)
  else if ((TopOfRightSide+8)>(NumberOfSliders*40+96)) and ((TopOfRightSide+8)>heightspin.value) then
    heightspin.value:=(TopOfRightSide+8);

  if TopOfRightSide>8 then
    widthspin.value:=470;

  // FormRefresh anpassen
  functions[2].functext:=
  '  var'+#13#10+
  '    Value:integer;'+#13#10+
  '    r,phi,temp:Double;'+#13#10+
  '  begin'+#13#10+
  '    if not DontRefresh then'+#13#10+
  '    case channel of'+#13#10;

  for i:=0 to length(channels)-1 do
  begin
    if (Uppercase(channels[i].typ)='PAN') or (Uppercase(channels[i].typ)='TILT') then
    begin
      // PAN/TILT Kanal
      if HasFineChannels then
      begin
        // 16-Bit PAN/TILT Ansteuerung
        functions[2].functext:=functions[2].functext+
        '      '+inttostr(i)+':'+#13#10+
        '      begin'+#13#10+
        '        if usemhcontrol.checked then'+#13#10+
        '        begin'+#13#10+
        '          // Moving-Head-Steuerung'+#13#10+
        '          temp:=get_channel(''tilt'')+(get_channel(''tiltfine'')/256);'+#13#10+
        '          case round(temp) of'+#13#10+
        '            0..127: r:=((127-temp)/127);'+#13#10+
        '            128..255: r:=((temp-128)/127);'+#13#10+
        '          end;'+#13#10+
        '          phi:=(get_channel(''pan'')+(get_channel(''panfine'')/256))/255*6.283185307179586476925286766559;	//(X/255)*PI'+#13#10+
        '          PositionXY.Left:=round(r*sin(phi)*(Fadenkreuz.Width/2)+(Fadenkreuz.Width/2)-(PositionXY.Width div 2));'+#13#10+
        '          PositionXY.Top:=round(r*cos(phi)*(Fadenkreuz.Height/2)+(Fadenkreuz.Height/2)-(PositionXY.Width div 2));'+#13#10+
        '        end else'+#13#10+
        '        begin'+#13#10+
        '          // Scanner-Steuerung'+#13#10+
        '          PositionXY.Left:=round(Fadenkreuz.Width * (get_channel(''pan'')+get_channel(''panfine'')/256)/255)-(PositionXY.Width div 2);'+#13#10+
        '          PositionXY.Top:=round(Fadenkreuz.Height * (get_channel(''tilt'')+get_channel(''tiltfine'')/256)/255)-(PositionXY.Height div 2);'+#13#10+
        '        end;'+#13#10+
        '      end;'+#13#10;
      end else
      begin
        // 8-Bit PAN/TILT Ansteurung
        functions[2].functext:=functions[2].functext+
        '      '+inttostr(i)+':'+#13#10+
        '      begin'+#13#10+
        '        PositionXY.Left:=round(Fadenkreuz.Width * get_channel(''pan'')/255)-(PositionXY.Width div 2);'+#13#10+
        '        PositionXY.Top:=round(Fadenkreuz.Height * get_channel(''tilt'')/255)-(PositionXY.Height div 2);'+#13#10+
        '      end;'+#13#10;
      end;
    end else if (Uppercase(channels[i].typ)='R') or (Uppercase(channels[i].typ)='G') or (Uppercase(channels[i].typ)='B') then
    begin
      // RGB-Kanal
      functions[2].functext:=functions[2].functext+
      '      '+inttostr(i)+':'+#13#10+
      '      begin'+#13#10+
      '        // RGB-Änderungen werden derzeit nicht im DDF angezeigt'+#13#10+
      '      end;'+#13#10;
    end else if Uppercase(channels[i].typ)='COLOR1' then
    begin
      functions[2].functext:=functions[2].functext+
      '      '+inttostr(i)+':'+#13#10+
      '      begin'+#13#10+
      '        value:=get_channel(''color1'');'+#13#10+
      '        case value of'+#13#10;
      for j:=0 to length(colors)-1 do
        functions[2].functext:=functions[2].functext+'          '+inttostr(colors[j].value)+'..'+inttostr(colors[j].valueend)+': colorbox.itemindex:='+inttostr(j)+';'+#13#10;
      functions[2].functext:=functions[2].functext+
      '        end;'+#13#10+
      '      end;'+#13#10;
    end else if Uppercase(channels[i].typ)='COLOR2' then
    begin
      functions[2].functext:=functions[2].functext+
      '      '+inttostr(i)+':'+#13#10+
      '      begin'+#13#10+
      '        value:=get_channel(''color2'');'+#13#10+
      '        case value of'+#13#10;
      for j:=0 to length(colors2)-1 do
        functions[2].functext:=functions[2].functext+'          '+inttostr(colors2[j].value)+'..'+inttostr(colors2[j].valueend)+': colorbox2.itemindex:='+inttostr(j)+';'+#13#10;
      functions[2].functext:=functions[2].functext+
      '        end;'+#13#10+
      '      end;'+#13#10;
    end else if Uppercase(channels[i].typ)='GOBO1' then
    begin
      functions[2].functext:=functions[2].functext+
      '      '+inttostr(i)+':'+#13#10+
      '      begin'+#13#10+
      '        value:=get_channel(''gobo1'');'+#13#10+
      '        case value of'+#13#10;
      for j:=0 to length(gobos)-1 do
        functions[2].functext:=functions[2].functext+'          '+inttostr(gobos[j].value)+'..'+inttostr(gobos[j].valueend)+': gobobox1.itemindex:='+inttostr(j)+';'+#13#10;
      functions[2].functext:=functions[2].functext+
      '        end;'+#13#10+
      '      end;'+#13#10;
    end else if Uppercase(channels[i].typ)='GOBO2' then
    begin
      functions[2].functext:=functions[2].functext+
      '      '+inttostr(i)+':'+#13#10+
      '      begin'+#13#10+
      '        value:=get_channel(''gobo2'');'+#13#10+
      '        case value of'+#13#10;
      for j:=0 to length(gobos2)-1 do
        functions[2].functext:=functions[2].functext+'          '+inttostr(gobos2[j].value)+'..'+inttostr(gobos2[j].valueend)+': gobobox2.itemindex:='+inttostr(j)+';'+#13#10;
      functions[2].functext:=functions[2].functext+
      '        end;'+#13#10+
      '      end;'+#13#10;
    end else
    begin
      // Standardkanal
      functions[2].functext:=functions[2].functext+
      '      '+inttostr(i)+':'+#13#10+
      '      begin'+#13#10+
      '        '+channels[i].typ+'slider'+inttostr(i)+'.position:=get_channel('''+channels[i].typ+''');'+#13#10+
      '      end;'+#13#10;
    end;
  end;

  functions[2].functext:=functions[2].functext+
  '    end;'+#13#10+
  '    DontRefresh:=false;'+#13#10+
  '  end;';

  RefreshSelection;
  RefreshSettings;
end;

procedure Tddfeditorform.TBItem23Click(Sender: TObject);
begin
  if CurrentFileName='' then
  begin
    GerteeinstellungenalsXMLspeichern1Click(Sender);
    exit;
  end;

  CreateXMLDDF;
  if FileExists(Savedialog1.FileName) then
  begin
    if not DirectoryExists(mainform.userdirectory+'Devices\Backup') then
      CreateDir(mainform.userdirectory+'Devices\Backup');
    CopyFile(PCHar(CurrentFileName),PChar(mainform.userdirectory+'Devices\Backup\~'+ExtractFileName(CurrentFileName)),false);
  end;
  Memo1.Lines.SaveToFile(CurrentFileName);
end;

procedure Tddfeditorform.channelfadeboxClick(Sender: TObject);
begin
  channels[round(JvSpinEdit1.Value)-1].fade:=channelfadebox.Checked;
end;

end.
