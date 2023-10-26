unit effektsequenzerfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Registry, szenenverwaltung, Buttons,
  PngBitBtn, ExtCtrls, gnugettext, Menus, VirtualTrees;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: integer; // 0 Effekt, 1 Effektschritt 
    Caption:WideString;
    Beschreibung:WideString;
    Effektnummer:integer;
    EffektnummerInTree:integer;
    Position:integer;
    ID:TGUID;
  end;

  PTreeData2 = ^TTreeData2;
  TTreeData2 = record
    NodeType: integer; // 0 Einfache Szenen, 1 Geräteszenen, 2 Audioszenen, 3 Bewegungsszenen, 4 Befehle, 5 Kombinationsszenen, 6 Presets, 7 Automatikszenen, 8 Effekt, 9 MediaCenter Szenen
    IsRootNode:boolean;
    IsCatNode:boolean;
    Caption:WideString;
    Beschreibung:WideString;
    Fadetime:WideString;
    ID:TGUID;
  end;

  Teffektsequenzer = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel1: TPanel;
    GroupBox4: TGroupBox;
    Button3: TPngBitBtn;
    duplicateeffect: TPngBitBtn;
    deleteeffectbtn: TPngBitBtn;
    moveeffectupbtn: TPngBitBtn;
    moveeffectdownbtn: TPngBitBtn;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    Edit7: TEdit;
    CheckBox1: TCheckBox;
    CheckBox4: TCheckBox;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    EditBtn: TPngBitBtn;
    deletestepbtn: TPngBitBtn;
    Button5: TPngBitBtn;
    movestepupbtn: TPngBitBtn;
    movestepdownbtn: TPngBitBtn;
    ComboBox2: TComboBox;
    copybtn: TPngBitBtn;
    GroupBox5: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    einblendzeit_s: TEdit;
    einblendzeit_min: TEdit;
    einblendzeit_h: TEdit;
    einblendzeit_ms: TEdit;
    wartezeit_h: TEdit;
    wartezeit_min: TEdit;
    wartezeit_s: TEdit;
    wartezeit_ms: TEdit;
    Button8: TButton;
    Button9: TButton;
    Edit3: TEdit;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Panel3: TPanel;
    Panel2: TPanel;
    SaveEffectsBtn: TSpeedButton;
    OpenEffectsBtn: TSpeedButton;
    NewEffectsBtn: TSpeedButton;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    intensity: TTrackBar;
    speed: TTrackBar;
    Button11: TButton;
    Button2: TPngBitBtn;
    Button4: TPngBitBtn;
    Button10: TPngBitBtn;
    Button6: TPngBitBtn;
    PngBitBtn1: TPngBitBtn;
    RefreshTimer: TTimer;
    Button12: TButton;
    TabControl1: TTabControl;
    lauflichtbtn: TPngBitBtn;
    PopupMenu1: TPopupMenu;
    Eigenschaftenausblenden1: TMenuItem;
    VST: TVirtualStringTree;
    effekttotab: TComboBox;
    Label8: TLabel;
    PopupMenu2: TPopupMenu;
    NeuesTabhinzufgen1: TMenuItem;
    abumbennen1: TMenuItem;
    ablschen1: TMenuItem;
    Panel4: TPanel;
    Panel5: TPanel;
    PngBitBtn4: TPngBitBtn;
    PngBitBtn5: TPngBitBtn;
    PngBitBtn6: TPngBitBtn;
    CheckBox5: TCheckBox;
    matrixbtn: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    Button7: TButton;
    GroupBox6: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    editstopscenebtn: TPngBitBtn;
    removestopscenebtn: TPngBitBtn;
    Label18: TLabel;
    editstartscenebtn: TPngBitBtn;
    removestartscenebtn: TPngBitBtn;
    Label19: TLabel;
    PngBitBtn3: TPngBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure movestepupbtnClick(Sender: TObject);
    procedure movestepdownbtnClick(Sender: TObject);
    procedure deleteeffectbtnClick(Sender: TObject);
    procedure deletestepbtnClick(Sender: TObject);
    procedure checkbuttons;
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit5KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit6KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit7KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit7Change(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormHide(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure einblendzeit_hChange(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure intensityChange(Sender: TObject);
    procedure speedChange(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure Button11Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure NewEffectsBtnClick(Sender: TObject);
    procedure OpenEffectsBtnClick(Sender: TObject);
    procedure SaveEffectsBtnClick(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox2Select(Sender: TObject);
    procedure CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure duplicateeffectClick(Sender: TObject);
    procedure copybtnClick(Sender: TObject);
    procedure wartezeit_hChange(Sender: TObject);
    procedure einblendzeit_hKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wartezeit_hKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure moveeffectupbtnClick(Sender: TObject);
    procedure CopyEffect(Source, Destination:integer; KeepID: boolean);
    procedure CopyEffectStep(SourceEffect, SourceStep, DestinationEffect, DestinationStep:integer; AddCopyTitle:boolean);
    procedure moveeffectdownbtnClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure RefreshTimerTimer(Sender: TObject);
    procedure SaveSelection;
    procedure RecallSelection;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure EffektSort(iLo, iHi: Integer);
    procedure Button12Click(Sender: TObject);
    procedure lauflichtbtnClick(Sender: TObject);
    procedure Eigenschaftenausblenden1Click(Sender: TObject);
    procedure VSTPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VSTClick(Sender: TObject);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure NeuesTabhinzufgen1Click(Sender: TObject);
    procedure abumbennen1Click(Sender: TObject);
    procedure ablschen1Click(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure CheckBox5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure matrixbtnClick(Sender: TObject);
    procedure effekttotabSelect(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure editstopscenebtnClick(Sender: TObject);
    procedure removestopscenebtnClick(Sender: TObject);
    procedure editstartscenebtnClick(Sender: TObject);
    procedure removestartscenebtnClick(Sender: TObject);
    procedure PngBitBtn3Click(Sender: TObject);
    procedure VSTMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VSTEndDrag(Sender, Target: TObject; X, Y: Integer);
  private
    { Private-Deklarationen }
    ExpandedNodes:array of boolean;
    SelectedNodes:array of array of boolean;
    FileStream:TFileStream;
  public
    { Public-Deklarationen }
    RefreshGUI:boolean;
    SelectedID:TGuid;
    SelectedEffekt:integer;

    VSTRootNodes: array of PVirtualNode;
    VSTEffektNodes: array of array of PVirtualNode;

    procedure NewFile;
    procedure MSGOpen;
    procedure MSGSave;
    procedure AddFile(filename: string);
    procedure OpenFile(filename: string);
    procedure SaveFile(filename: string);
    procedure RefreshTreeView;
  end;

var
  effektsequenzer: Teffektsequenzer;

implementation

uses PCDIMMER, kontrollpanelform, insscene, devicescenefrm,
  lauflichtassistentfrm, geraetesteuerungfrm,
  matrixeditorfrm, addcolorandgobotoeffectfrm, audioeffektplayerfrm;

{$R *.dfm}

procedure Teffektsequenzer.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Teffektsequenzer.Button3Click(Sender: TObject);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  setlength(mainform.effektsequenzereffekte,length(mainform.effektsequenzereffekte)+1);
  setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte,0);
  setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)+1);
  mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Name:=_('Neuer Effekt (')+inttostr(length(mainform.effektsequenzereffekte))+')';
  mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].AnzahlderDurchlaufe:=-1;
  mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Repeating:=true;
  mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].speed:=128;
  mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].intensitaet:=255;
  mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].TabPosition:=TabControl1.TabIndex;
  CreateGUID(mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].ID);

  setlength(VSTRootNodes, length(VSTRootNodes)+1);
  setlength(VSTEffektNodes, length(VSTEffektNodes)+1);
  VSTRootNodes[length(VSTRootNodes)-1]:=VST.AddChild(nil);
  Data:=VST.GetNodeData(VSTRootNodes[length(VSTRootNodes)-1]);
  Data^.NodeType:=0;
  Data^.Caption:=mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Name;
  Data^.Beschreibung:=mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Beschreibung;
  Data^.Effektnummer:=length(mainform.effektsequenzereffekte)-1;
  Data^.EffektnummerInTree:=length(VSTRootNodes)-1;
  Data^.Position:=length(mainform.effektsequenzereffekte)-1;
  Data^.ID:=mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].ID;

  VST.FocusedNode:=VSTRootNodes[length(VSTRootNodes)-1];
  VST.Selected[VSTRootNodes[length(VSTRootNodes)-1]]:=true;
  checkbuttons;
  VST.FocusedNode:=VSTRootNodes[length(VSTRootNodes)-1];
  VST.Selected[VSTRootNodes[length(VSTRootNodes)-1]]:=true;

  VSTChange(vst, VSTRootNodes[length(VSTRootNodes)-1]);
  mainform.EffectsChanged;

  VSTClick(nil);
  VST.FocusedNode:=VSTRootNodes[length(VSTRootNodes)-1];
  VST.Selected[VSTRootNodes[length(VSTRootNodes)-1]]:=true;
end;

function levelstr(pos,max:integer):string;
begin
  result:='';
  case MainForm.levelanzeigeoptionen of
    0: result:=inttostr(round((pos*100) / max))+'%';
    1: result:=inttostr(round((pos*100) / max))+'.'+copy(inttostr((pos*100) mod max),0,1)+'%';
    2: result:=inttostr(pos);
  end;
end;

procedure Teffektsequenzer.FormShow(Sender: TObject);
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
  			LReg.WriteBool('Showing Effektsequenzer',true);

        if not LReg.KeyExists('Effektsequenzer') then
	        LReg.CreateKey('Effektsequenzer');
	      if LReg.OpenKey('Effektsequenzer',true) then
	      begin
            if LReg.ValueExists('Width') then
              Effektsequenzer.ClientWidth:=LReg.ReadInteger('Width')
            else
              effektsequenzer.ClientWidth:=682;
            if LReg.ValueExists('Height') then
              Effektsequenzer.ClientHeight:=LReg.ReadInteger('Height')
            else
              effektsequenzer.ClientHeight:=545;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+Effektsequenzer.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              Effektsequenzer.Left:=LReg.ReadInteger('PosX')
            else
              Effektsequenzer.Left:=0;
          end else
            Effektsequenzer.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+Effektsequenzer.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              Effektsequenzer.Top:=LReg.ReadInteger('PosY')
            else
              Effektsequenzer.Top:=0;
          end else
            Effektsequenzer.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  RefreshTreeView;
  Checkbuttons;

  RefreshTimer.enabled:=true;
end;

procedure Teffektsequenzer.Button5Click(Sender: TObject);
var
  Data: PTreeData;
  DataNew:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  mainform.AktuellerEffekt[Data^.Effektnummer].Aktiv:=false;
  setlength(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte,length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)+1);
  mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].Name:=_('Neuer Effektschritt (')+inttostr(length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte))+')';
  mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].wartezeit:=1000;
  mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].DeactivateLastScene:=true;

  setlength(VSTEffektNodes[Data^.EffektnummerInTree], length(VSTEffektNodes[Data^.EffektnummerInTree])+1);
  VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]:=VST.AddChild(VSTRootNodes[Data^.EffektnummerInTree]);
  DataNew:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]);
  DataNew^.NodeType:=1;
  DataNew^.Caption:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].Name;
  DataNew^.Beschreibung:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].Beschreibung;
  DataNew^.Effektnummer:=Data^.Effektnummer;
  DataNew^.EffektnummerInTree:=Data^.EffektnummerInTree;
  DataNew^.Position:=length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1;
  DataNew^.ID:=mainform.Effektsequenzereffekte[Data^.Effektnummer].ID;

  VST.SelectAll(false);
  VST.InvertSelection(false);
  VST.FocusedNode:=VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1];
  VST.Selected[VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]]:=true;

  checkbuttons;
  VSTChange(vst,VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]);
end;

procedure Teffektsequenzer.movestepupbtnClick(Sender: TObject);
var
  Data: PTreeData;
  oldtext,olddesc:string;
  newtext,newdesc:string;
  aktuellereffekt,aktuellereffektschritt:integer;
  Old, New:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  aktuellereffekt:=Data^.Effektnummer;
  aktuellereffektschritt:=Data^.Position;
  mainform.AktuellerEffekt[aktuellereffekt].Aktiv:=false;

  oldtext:=mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte[aktuellereffektschritt].Name;
  olddesc:=mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte[aktuellereffektschritt].Beschreibung;
  newtext:=mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte[aktuellereffektschritt-1].Name;
  newdesc:=mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte[aktuellereffektschritt-1].Beschreibung;

  // Array um eins erhöhen
  setlength(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte,length(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte)+1);

  // Obere Arrayposition in letztes Element kopieren
  CopyEffectStep(aktuellereffekt, aktuellereffektschritt-1, aktuellereffekt, length(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte)-1, false);

  // Aktuelles Element eine Position nach oben kopieren
  CopyEffectStep(aktuellereffekt, aktuellereffektschritt, aktuellereffekt, aktuellereffektschritt-1, false);

  // Letzte Position auf aktuelle Position kopieren
  CopyEffectStep(aktuellereffekt, length(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte)-1, aktuellereffekt, aktuellereffektschritt, false);

  // Array um eins kürzen
  setlength(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte,length(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte)-1);

  if TabControl1.TabIndex=0 then
  begin
    Old:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][Data^.Position]);
    New:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][Data^.Position-1]);

    Old^.Caption:=newtext;
    Old^.Beschreibung:=newdesc;
    New^.Caption:=oldtext;
    New^.Beschreibung:=olddesc;
    VST.SelectAll(false);
    VST.InvertSelection(false);
    VST.FocusedNode:=VSTEffektNodes[New^.Effektnummer][New^.Position];
    VST.Selected[VSTEffektNodes[New^.Effektnummer][New^.Position]]:=true;
  end else
  begin
//    RefreshTreeView;
    Old:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][Data^.Position]);
    New:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][Data^.Position-1]);

    Old^.Caption:=newtext;
    Old^.Beschreibung:=newdesc;
    New^.Caption:=oldtext;
    New^.Beschreibung:=olddesc;
    VST.SelectAll(false);
    VST.InvertSelection(false);
    VST.FocusedNode:=VSTEffektNodes[New^.EffektnummerInTree][New^.Position];
    VST.Selected[VSTEffektNodes[New^.EffektnummerInTree][New^.Position]]:=true;
  end;
  
  checkbuttons;
end;

procedure Teffektsequenzer.movestepdownbtnClick(Sender: TObject);
var
  Data: PTreeData;
  oldtext,olddesc:string;
  newtext,newdesc:string;
  aktuellereffekt,aktuellereffektschritt:integer;
  Old, New:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  aktuellereffekt:=Data^.Effektnummer;
  aktuellereffektschritt:=Data^.Position;
  mainform.AktuellerEffekt[aktuellereffekt].Aktiv:=false;

  oldtext:=mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte[aktuellereffektschritt].Name;
  olddesc:=mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte[aktuellereffektschritt].Beschreibung;
  newtext:=mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte[aktuellereffektschritt+1].Name;
  newdesc:=mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte[aktuellereffektschritt+1].Beschreibung;

  // Array um eins erhöhen
  setlength(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte,length(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte)+1);

  // Untere Arrayposition in letztes Element kopieren
  CopyEffectStep(aktuellereffekt, aktuellereffektschritt+1, aktuellereffekt, length(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte)-1, false);

  // Aktuelles Element eine Position nach unten kopieren
  CopyEffectStep(aktuellereffekt, aktuellereffektschritt, aktuellereffekt, aktuellereffektschritt+1, false);

  // Letzte Position auf aktuelle Position kopieren
  CopyEffectStep(aktuellereffekt, length(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte)-1, aktuellereffekt, aktuellereffektschritt, false);

  // Array um eins kürzen
  setlength(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte,length(mainform.Effektsequenzereffekte[aktuellereffekt].Effektschritte)-1);


  if TabControl1.TabIndex=0 then
  begin
    Old:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][Data^.Position]);
    New:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][Data^.Position+1]);

    Old^.Caption:=newtext;
    Old^.Beschreibung:=newdesc;
    New^.Caption:=oldtext;
    New^.Beschreibung:=olddesc;

    VST.SelectAll(false);
    VST.InvertSelection(false);
    VST.FocusedNode:=VSTEffektNodes[New^.Effektnummer][New^.Position];
    VST.Selected[VSTEffektNodes[New^.Effektnummer][New^.Position]]:=true;
  end else
  begin
    //RefreshTreeView;
    Old:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][Data^.Position]);
    New:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][Data^.Position+1]);

    Old^.Caption:=newtext;
    Old^.Beschreibung:=newdesc;
    New^.Caption:=oldtext;
    New^.Beschreibung:=olddesc;

    VST.SelectAll(false);
    VST.InvertSelection(false);
    VST.FocusedNode:=VSTEffektNodes[New^.EffektnummerInTree][New^.Position];
    VST.Selected[VSTEffektNodes[New^.EffektnummerInTree][New^.Position]]:=true;
  end;

  checkbuttons;
end;

procedure Teffektsequenzer.deleteeffectbtnClick(Sender: TObject);
var
  Data: PTreeData;
  i,Differenz:integer;
  TempNode:PVirtualNode;
  SomethingDeleted:boolean;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;

  // Effekt anhalten, falls er läuft
  Button4Click(Button4);

  SomethingDeleted:=false;
  Differenz:=0;
  TempNode:=VST.GetFirst;
  while Assigned(TempNode) do
  begin
    if VST.Selected[TempNode] then
    begin
      Data:=VST.GetNodeData(TempNode);

      if (length(mainform.Effektsequenzereffekte)>1) and ((Data^.Effektnummer-Differenz)<length(mainform.Effektsequenzereffekte)-1) then
      for i:=Data^.Effektnummer-Differenz to length(mainform.Effektsequenzereffekte)-2 do
      begin
        CopyEffect(i+1,i, true);
      end;

      if (Data^.NodeType=1) then
      begin
        // Effektschritt
        VST.DeleteNode(TempNode.Parent);
      end else
      begin
        // Effektknoten
        VST.DeleteNode(TempNode);
      end;

      Differenz:=Differenz+1;
      SomethingDeleted:=true;
      setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)-1);
    end;

    if SomethingDeleted then
    begin
      SomethingDeleted:=false;
      TempNode:=VST.GetFirst;
    end else
    begin
      TempNode:=VST.GetNext(TempNode);
    end;
  end;
  RefreshTreeView;
  checkbuttons;
  mainform.EffectsChanged;

{
  Data:=VST.GetNodeData(VST.FocusedNode);

  if (length(mainform.Effektsequenzereffekte)>1) and (Data^.Effektnummer<length(mainform.Effektsequenzereffekte)-1) then
  for i:=Data^.Effektnummer to length(mainform.Effektsequenzereffekte)-2 do
  begin
    CopyEffect(i+1,i, true);
  end;
  setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)-1);

  RefreshTreeView;
  checkbuttons;

  mainform.EffectsChanged;
}
end;

procedure Teffektsequenzer.deletestepbtnClick(Sender: TObject);
var
  i,j:integer;
//  oldindex:integer;
//  oldparentindex:integer;
  TempNode:PVirtualNode;
  NodeToDelete:array of PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;

  // Effekt anhalten, falls er läuft
  Button4Click(Button4);

  TempNode:=VST.GetFirst;
  while Assigned(TempNode) do
  begin
    if VST.Selected[TempNode] and (TempNode.ChildCount=0) then
    begin
      setlength(NodeToDelete, length(NodeToDelete)+1);
      NodeToDelete[length(NodeToDelete)-1]:=VST.GetNodeData(TempNode);
    end;
    TempNode:=VST.GetNext(TempNode);
  end;

//  Data:=VST.GetNodeData(VST.FocusedNode);
//  NodeToDelete:=VST.FocusedNode;

  for j:=0 to length(NodeToDelete)-1 do
  begin
    mainform.AktuellerEffekt[NodeToDelete[j]^.Effektnummer].Aktiv:=false;
    if length(mainform.Effektsequenzereffekte[NodeToDelete[j]^.Effektnummer].Effektschritte)>1 then
    begin
      for i:=NodeToDelete[j]^.Position to length(mainform.Effektsequenzereffekte[NodeToDelete[j]^.Effektnummer].Effektschritte)-2 do
      begin
        CopyEffectStep(NodeToDelete[j]^.Effektnummer, i+1, NodeToDelete[j]^.Effektnummer, i, false);
        VSTEffektNodes[NodeToDelete[j]^.EffektnummerInTree][i]:=VSTEffektNodes[NodeToDelete[j]^.EffektnummerInTree][i+1];
      end;
    end;
    setlength(mainform.Effektsequenzereffekte[NodeToDelete[j]^.Effektnummer].Effektschritte,length(mainform.Effektsequenzereffekte[NodeToDelete[j]^.Effektnummer].Effektschritte)-1);
    setlength(VSTEffektNodes[NodeToDelete[j]^.EffektnummerInTree],length(VSTEffektNodes[NodeToDelete[j]^.EffektnummerInTree])-1);
  end;
  deletestepbtn.Enabled:=false;

  RefreshTreeView;
  checkbuttons;
end;

procedure Teffektsequenzer.checkbuttons;
var
  Data: PTreeData;
begin
  if (length(mainform.Effektsequenzereffekte)>0) then
  begin
    if (VST.SelectedCount>0) then
    begin
      deleteeffectbtn.Enabled:=true;
      duplicateeffect.Enabled:=true;
      editstartscenebtn.Enabled:=true;
      removestartscenebtn.Enabled:=true;
      editstopscenebtn.Enabled:=true;
      removestopscenebtn.Enabled:=true;
      moveeffectupbtn.Enabled:=true;
      moveeffectdownbtn.Enabled:=true;
      Button5.Enabled:=true;
      Button2.Enabled:=true;
      Button4.Enabled:=true;
      Button6.Enabled:=true;
      Button10.Enabled:=true;
      PngBitBtn1.enabled:=true;
      lauflichtbtn.enabled:=true;
      matrixbtn.Enabled:=true;

      intensity.Enabled:=true;
      speed.Enabled:=true;
      groupbox3.Enabled:=true;

      Data:=VST.GetNodeData(VST.FocusedNode);
      if not Assigned(Data) then exit;

      if Data^.NodeType=1 then // wenn innerhalb der Unterobjekte
      begin
        if length(mainform.Effektsequenzereffekte)>0 then
        begin
          if (length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)>1) and (Data^.Position>0) then
            movestepupbtn.Enabled:=true
          else
            movestepupbtn.Enabled:=false;

          if (length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)>1) and (Data^.Position<length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1) then
            movestepdownbtn.Enabled:=true
          else
            movestepdownbtn.Enabled:=false;

          if Data^.Position<length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte) then
            deletestepbtn.Enabled:=true
          else
            deletestepbtn.Enabled:=false;
        end;

        deleteeffectbtn.Enabled:=true;
        duplicateeffect.Enabled:=true;
        editstartscenebtn.Enabled:=true;
        removestartscenebtn.Enabled:=true;
        editstopscenebtn.Enabled:=true;
        removestopscenebtn.Enabled:=true;
        moveeffectupbtn.Enabled:=true;
        moveeffectdownbtn.Enabled:=true;
        Combobox2.enabled:=true;
        EditBtn.enabled:=true;
        CopyBtn.Enabled:=true;
      end else if (Data^.NodeType=0) then // wenn Toplevel
      begin
        movestepupbtn.Enabled:=false;
        movestepdownbtn.Enabled:=false;
        deletestepbtn.Enabled:=false;
        deleteeffectbtn.Enabled:=true;
        duplicateeffect.Enabled:=true;
        editstartscenebtn.Enabled:=true;
        removestartscenebtn.Enabled:=true;
        editstopscenebtn.Enabled:=true;
        removestopscenebtn.Enabled:=true;
        moveeffectupbtn.Enabled:=true;
        moveeffectdownbtn.Enabled:=true;
      end else
      begin
        deleteeffectbtn.Enabled:=false;
        duplicateeffect.Enabled:=false;
        editstartscenebtn.Enabled:=false;
        removestartscenebtn.Enabled:=false;
        editstopscenebtn.Enabled:=false;
        removestopscenebtn.Enabled:=false;
        moveeffectupbtn.Enabled:=false;
        moveeffectdownbtn.Enabled:=false;
      end;
    end else
    begin
      deleteeffectbtn.Enabled:=false;
      duplicateeffect.Enabled:=false;
      editstartscenebtn.Enabled:=false;
      removestartscenebtn.Enabled:=false;
      editstopscenebtn.Enabled:=false;
      removestopscenebtn.Enabled:=false;
      moveeffectupbtn.Enabled:=false;
      moveeffectdownbtn.Enabled:=false;
      Button5.Enabled:=false;
      intensity.Enabled:=false;
      speed.Enabled:=false;
      groupbox3.Enabled:=false;
      EditBtn.Enabled:=false;
      CopyBtn.Enabled:=false;
      Combobox2.enabled:=false;
      deletestepbtn.Enabled:=false;
      lauflichtbtn.enabled:=false;
      matrixbtn.Enabled:=false;

      Button2.Enabled:=false;
      Button4.Enabled:=false;
      Button6.Enabled:=false;
      Button10.Enabled:=false;
      PngBitBtn1.enabled:=false;
    end;
  end else
  begin // keine Elemente mehr im TreeView
    deleteeffectbtn.Enabled:=false;
    duplicateeffect.Enabled:=false;
    editstartscenebtn.Enabled:=false;
    removestartscenebtn.Enabled:=false;
    editstopscenebtn.Enabled:=false;
    removestopscenebtn.Enabled:=false;
    moveeffectupbtn.Enabled:=false;
    moveeffectdownbtn.Enabled:=false;
    Button5.Enabled:=false;
    intensity.Enabled:=false;
    speed.Enabled:=false;
    groupbox3.Enabled:=false;
    Combobox2.enabled:=false;
    EditBtn.Enabled:=false;
    CopyBtn.Enabled:=false;
    deletestepbtn.Enabled:=false;
    lauflichtbtn.enabled:=false;
    matrixbtn.Enabled:=false;

    Button2.Enabled:=false;
    Button4.Enabled:=false;
    Button6.Enabled:=false;
    Button10.Enabled:=false;
    PngBitBtn1.enabled:=false;
  end;
end;

procedure Teffektsequenzer.Button2Click(Sender: TObject);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    mainform.StartEffekt(Data^.ID);
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.Button4Click(Sender: TObject);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    mainform.StopEffekt(Data^.ID);
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.Edit5KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=1 then
  begin
    Data:=VST.GetNodeData(VST.FocusedNode);
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name:=edit5.Text;
    Data^.Caption:=edit5.Text;
  end else
  begin
    for i:=0 to length(VSTEffektNodes)-1 do
    for j:=0 to length(VSTEffektNodes[i])-1 do
    if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
    begin
      Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name:=edit5.Text+' '+inttostr(Data^.Position+1);
      Data^.Caption:=edit5.Text+' '+inttostr(Data^.Position+1);
    end;
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.Edit6KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Beschreibung:=edit6.Text;
    Data^.Beschreibung:=edit6.Text;
  end;
end;

procedure Teffektsequenzer.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);
  if Data^.NodeType=0 then
  begin
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Name:=edit1.Text;
    Data^.Caption:=edit1.Text;
  end else
  begin
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Name:=edit1.Text;
    Data:=VST.GetNodeData(VST.FocusedNode.Parent);
    Data^.Caption:=edit1.Text;
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);
  if Data^.NodeType=0 then
  begin
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Beschreibung:=edit2.Text;
    Data^.Beschreibung:=edit2.Text;
  end else
  begin
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Beschreibung:=edit2.Text;
    Data:=VST.GetNodeData(VST.FocusedNode.Parent);
    Data^.Beschreibung:=edit2.Text;
  end;
end;

procedure Teffektsequenzer.Edit7KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

//  if VST.SelectedCount=0 then exit;

  if Sender=Edit7 then
  begin
{
    Data:=VST.GetNodeData(VST.FocusedNode);
    mainform.Effektsequenzereffekte[Data^.Effektnummer].AnzahlderDurchlaufe:=strtoint(Edit7.text);
}
    if VST.SelectedCount=1 then
    begin
      Data:=VST.GetNodeData(VST.FocusedNode);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].AnzahlderDurchlaufe:=strtoint(Edit7.text);
    end else
    begin
      for i:=0 to length(VSTEffektNodes)-1 do
      for j:=0 to length(VSTEffektNodes[i])-1 do
      if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
      begin
        Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
        mainform.Effektsequenzereffekte[Data^.Effektnummer].AnzahlderDurchlaufe:=strtoint(Edit7.text);
      end;
    end;
  end;
end;

procedure Teffektsequenzer.Edit7Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if not mainform.UserAccessGranted(1, false) then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure Teffektsequenzer.Button10Click(Sender: TObject);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    mainform.AktuellerEffekt[Data^.Effektnummer].PleaseStopOnNextStep:=false;
    mainform.EffektSchaltvorgang(Data^.Effektnummer, Sender);
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  MSGSave;
end;

procedure Teffektsequenzer.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  RefreshTimer.enabled:=false;

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
					LReg.WriteBool('Showing Effektsequenzer',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;
  mainform.SaveWindowPositions('effektsequenzer');
end;

procedure Teffektsequenzer.RefreshTreeView;
var
  Data: PTreeData;
  i,j:integer;
  expanded:array of boolean;
  selected:array of array of boolean;
begin
  VST.BeginUpdate;

  setlength(expanded, length(VSTRootNodes));
  setlength(selected, length(VSTEffektNodes));
  for i:=0 to length(VSTRootNodes)-1 do
  begin
    expanded[i]:=VST.Expanded[VSTRootNodes[i]];

    setlength(selected[i], length(VSTEffektNodes[i]));
    for j:=0 to length(selected[i])-1 do
    begin
      selected[i][j]:=VST.Selected[VSTEffektNodes[i][j]];
    end;
  end;

  VST.Clear;
  VST.NodeDataSize:=sizeof(TTreeData);
  setlength(VSTRootNodes,0);
  setlength(VSTEffektNodes,0);

  for i:=0 to length(mainform.Effektsequenzereffekte)-1 do
  if (mainform.effektsequenzereffekte[i].TabPosition=Tabcontrol1.TabIndex) or (TabControl1.TabIndex=0) then
  begin
    setlength(VSTRootNodes, length(VSTRootNodes)+1);
    setlength(VSTEffektNodes, length(VSTEffektNodes)+1);

    VSTRootNodes[length(VSTRootNodes)-1]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[length(VSTRootNodes)-1]);
    Data^.NodeType:=0;
    Data^.Caption:=mainform.Effektsequenzereffekte[i].Name;
    Data^.Beschreibung:=mainform.Effektsequenzereffekte[i].Beschreibung;
    Data^.Effektnummer:=i;
    Data^.EffektnummerInTree:=length(VSTRootNodes)-1;
    Data^.Position:=i;
    Data^.ID:=mainform.Effektsequenzereffekte[i].ID;

    for j:=0 to length(mainform.Effektsequenzereffekte[i].Effektschritte)-1 do
    begin
      setlength(VSTEffektNodes[length(VSTRootNodes)-1],length(VSTEffektNodes[length(VSTRootNodes)-1])+1);

      VSTEffektNodes[length(VSTRootNodes)-1][j]:=VST.AddChild(VSTRootNodes[length(VSTRootNodes)-1]);
      Data:=VST.GetNodeData(VSTEffektNodes[length(VSTRootNodes)-1][j]);
      Data^.NodeType:=1;
      Data^.Caption:=mainform.Effektsequenzereffekte[i].Effektschritte[j].Name;
      Data^.Beschreibung:=mainform.Effektsequenzereffekte[i].Effektschritte[j].Beschreibung;
      Data^.Effektnummer:=i;
      Data^.EffektnummerInTree:=length(VSTRootNodes)-1;
      Data^.Position:=j;
      Data^.ID:=mainform.Effektsequenzereffekte[i].ID;
    end;
  end;

//  VST.Sort(nil, 0, sdAscending);

  setlength(expanded, length(VSTEffektNodes));
  setlength(selected, length(VSTEffektNodes));
  for i:=0 to length(VSTEffektNodes)-1 do
	begin
    VST.Expanded[VSTRootNodes[i]]:=expanded[i];

    setlength(selected[i], length(VSTEffektNodes[i]));
    for j:=0 to length(selected[i])-1 do
    begin
      VST.Selected[VSTEffektNodes[i][j]]:=selected[i][j];
    end;
  end;

  VST.EndUpdate;
end;

procedure Teffektsequenzer.EditBtnClick(Sender: TObject);
var
  Data: PTreeData;
  SzenenData:PTreeData2;
  i,j,k,t,h,min,s,ms:integer;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if (Sender=EditBtn) and Assigned(Data) then
  begin
    if mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Typ=1 then
    begin
      // Szene aus Verwaltung editieren
      setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs,1);
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].multiselect:=true;

      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].positionselection:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs[0];

      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
      begin
        if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
        SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

        setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs,1);
        mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs[0]:=SzenenData^.ID;
        mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name:=mainform.GetSceneInfo2(SzenenData^.ID,'name');
        mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].beschreibung:=mainform.GetSceneInfo2(SzenenData^.ID,'desc');

        szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
        setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);

        edit5.text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name;
        edit6.text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].beschreibung;
        Data^.Caption:=edit5.Text;
        VST.Refresh;
      end;
    end else if mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Typ=0 then
    begin
      // Direktszene editieren
      mainform.AktuelleDeviceScene.Name:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name;
      mainform.AktuelleDeviceScene.Beschreibung:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Beschreibung;
      mainform.AktuelleDeviceScene.Fadetime:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].einblendzeit;

      t:=mainform.AktuelleDeviceScene.Fadetime;
      h:=t div 3600000;
      t:=t mod 3600000;
      min:=t div 60000;
      t:=t mod 60000;
      s:=t div 1000;
      t:=t mod 1000;
      ms:=t;

      devicesceneform.scenefade_time_h.Text:=inttostr(h);
      devicesceneform.scenefade_time_min.Text:=inttostr(min);
      devicesceneform.scenefade_time.Text:=inttostr(s);
      devicesceneform.scenefade_time_msec.Text:=inttostr(ms);

      devicesceneform.Szenenname.text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name;
      devicesceneform.Szenenbeschreibung.text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Beschreibung;
      devicesceneform.scenefade_time_h.text:=inttostr(h);
      devicesceneform.scenefade_time_min.text:=inttostr(min);
      devicesceneform.scenefade_time.text:=inttostr(s);
      devicesceneform.scenefade_time_msec.text:=inttostr(ms);

      setlength(mainform.AktuelleDeviceScene.Devices,length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices));

      for i:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices)-1 do
      begin
        mainform.AktuelleDeviceScene.Devices[i].ID:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ID;
        setlength(mainform.AktuelleDeviceScene.Devices[i].ChanActive,length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanActive));
        setlength(mainform.AktuelleDeviceScene.Devices[i].ChanValue,length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanValue));
        setlength(mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom,length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanActiveRandom));
        setlength(mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom,length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanValueRandom));
        setlength(mainform.AktuelleDeviceScene.Devices[i].ChanDelay,length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanDelay));
        setlength(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime,length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanFadetime));
        for j:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanActive)-1 do
        begin
          mainform.AktuelleDeviceScene.Devices[i].ChanActive[j]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanActive[j];
          mainform.AktuelleDeviceScene.Devices[i].ChanValue[j]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanValue[j];
          mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom[j]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanActiveRandom[j];
          mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom[j]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanValueRandom[j];
          mainform.AktuelleDeviceScene.Devices[i].ChanDelay[j]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanDelay[j];
          mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[j]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanFadetime[j];
        end;
      end;

      setlength(mainform.AktuelleDeviceScene.Befehle, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle));
      setlength(mainform.AktuelleDeviceScene.Befehlswerte, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte));
      for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
      begin
        mainform.AktuelleDeviceScene.Befehle[i].ID:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ID;
        mainform.AktuelleDeviceScene.Befehle[i].Typ:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].Typ;
        mainform.AktuelleDeviceScene.Befehle[i].Name:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].Name;
        mainform.AktuelleDeviceScene.Befehle[i].Beschreibung:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].Beschreibung;
        mainform.AktuelleDeviceScene.Befehle[i].OnValue:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].OnValue;
        mainform.AktuelleDeviceScene.Befehle[i].OffValue:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].OffValue;
        mainform.AktuelleDeviceScene.Befehle[i].SwitchValue:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].SwitchValue;
        mainform.AktuelleDeviceScene.Befehle[i].InvertSwitchValue:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].InvertSwitchValue;
        mainform.AktuelleDeviceScene.Befehle[i].ScaleValue:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ScaleValue;

        setlength(mainform.AktuelleDeviceScene.Befehle[i].ArgInteger, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgInteger));
        setlength(mainform.AktuelleDeviceScene.Befehle[i].ArgString, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgString));
        setlength(mainform.AktuelleDeviceScene.Befehle[i].ArgGUID, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgGUID));
        for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgInteger)-1 do
          mainform.AktuelleDeviceScene.Befehle[i].ArgInteger[k]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgInteger[k];
        for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgString)-1 do
          mainform.AktuelleDeviceScene.Befehle[i].ArgString[k]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgString[k];
        for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgGUID)-1 do
          mainform.AktuelleDeviceScene.Befehle[i].ArgGUID[k]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgGUID[k];

        setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanActive));
        setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanValue));
        setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanActiveRandom));
        setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanValueRandom));
        setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanDelay));
        setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanFadetime));
        for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanActive)-1 do
        begin
          mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive[k]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanActive[k];
          mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[k]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanValue[k];
          mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom[k]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanActiveRandom[k];
          mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom[k]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanValueRandom[k];
          mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[k]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanDelay[k];
          mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[k]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanFadetime[k];
        end;
      end;

      devicesceneform.ShowModal;

      if devicesceneform.ModalResult=mrOK then
      begin
        mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name:=mainform.AktuelleDeviceScene.Name;
        mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Beschreibung:=mainform.AktuelleDeviceScene.Beschreibung;
        mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].einblendzeit:=mainform.AktuelleDeviceScene.Fadetime;
        Edit5.text:=mainform.AktuelleDeviceScene.Name;
        Edit6.Text:=mainform.AktuelleDeviceScene.Beschreibung;

        setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices,length(mainform.AktuelleDeviceScene.Devices));
        for i:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices)-1 do
        begin
          mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ID:=mainform.AktuelleDeviceScene.Devices[i].ID;
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanActive,length(mainform.AktuelleDeviceScene.Devices[i].ChanActive));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanValue,length(mainform.AktuelleDeviceScene.Devices[i].ChanValue));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanActiveRandom,length(mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanValueRandom,length(mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanDelay,length(mainform.AktuelleDeviceScene.Devices[i].ChanDelay));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanFadetime,length(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime));
          for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanActive)-1 do
          begin
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanActive[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanActive[k];
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanValue[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanValue[k];
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanActiveRandom[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom[k];
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanValueRandom[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom[k];
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanDelay[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanDelay[k];
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Devices[i].ChanFadetime[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[k];
          end;
        end;

        setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle, length(mainform.AktuelleDeviceScene.Befehle));
        setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte, length(mainform.AktuelleDeviceScene.Befehlswerte));
        for i:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle)-1 do
        begin
          mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ID:=mainform.AktuelleDeviceScene.Befehle[i].ID;
          mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].Typ:=mainform.AktuelleDeviceScene.Befehle[i].Typ;
          mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].Name:=mainform.AktuelleDeviceScene.Befehle[i].Name;
          mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].Beschreibung:=mainform.AktuelleDeviceScene.Befehle[i].Beschreibung;
          mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].OnValue:=mainform.AktuelleDeviceScene.Befehle[i].OnValue;
          mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].OffValue:=mainform.AktuelleDeviceScene.Befehle[i].OffValue;
          mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].SwitchValue:=mainform.AktuelleDeviceScene.Befehle[i].SwitchValue;
          mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].InvertSwitchValue:=mainform.AktuelleDeviceScene.Befehle[i].InvertSwitchValue;
          mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ScaleValue:=mainform.AktuelleDeviceScene.Befehle[i].ScaleValue;

          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgInteger, length(mainform.AktuelleDeviceScene.Befehle[i].ArgInteger));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgString, length(mainform.AktuelleDeviceScene.Befehle[i].ArgString));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgGUID, length(mainform.AktuelleDeviceScene.Befehle[i].ArgGUID));
          for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgInteger)-1 do
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgInteger[k]:=mainform.AktuelleDeviceScene.Befehle[i].ArgInteger[k];
          for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgString)-1 do
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgString[k]:=mainform.AktuelleDeviceScene.Befehle[i].ArgString[k];
          for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgGUID)-1 do
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehle[i].ArgGUID[k]:=mainform.AktuelleDeviceScene.Befehle[i].ArgGUID[k];

          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanActive,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanValue,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanActiveRandom,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanValueRandom,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanDelay,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanFadetime,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime));
          for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanActive)-1 do
          begin
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanActive[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive[k];
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanValue[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[k];
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanActiveRandom[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom[k];
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanValueRandom[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom[k];
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanDelay[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[k];
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Befehlswerte[i].ChanFadetime[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[k];
          end;
        end;

        // Fadezeit in Speicher schreiben
        t:=strtoint(devicesceneform.scenefade_time_msec.Text);
        t:=t+1000*strtoint(devicesceneform.scenefade_time.Text);
        t:=t+60*1000*strtoint(devicesceneform.scenefade_time_min.Text);
        t:=t+60*60*1000*strtoint(devicesceneform.scenefade_time_h.Text);

        mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name:=devicesceneform.Szenenname.text;
        mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Beschreibung:=devicesceneform.Szenenbeschreibung.text;
        mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].einblendzeit:=t;

        h:=t div 3600000; t:=t mod 3600000;
        min:=t div 60000; t:=t mod 60000;
        s:=t div 1000;
        ms:=t mod 1000;
        einblendzeit_h.Text:=inttostr(h);
        einblendzeit_min.Text:=inttostr(min);
        einblendzeit_s.Text:=inttostr(s);
        einblendzeit_ms.Text:=inttostr(ms);

        checkbuttons;

        edit5.text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name;
        edit6.text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].beschreibung;
        Data^.Caption:=edit5.Text;
        VST.Refresh;

        VSTChange(vst,VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]);
      end else
      begin
      end;
    end else if mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Typ=2 then
    begin
      // Effekt bearbeiten
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Effektmodus:=true;
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].multiselect:=true;
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ActualEffekt:=mainform.Effektsequenzereffekte[Data^.Effektnummer].ID;
      setlength(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].positionen,length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs));
      for i:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs)-1 do
      begin
        szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].positionen[i]:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs[i];
      end;

      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
      begin
        if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;

        // Effekt
        setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs,0);

        TempNode:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirst;
        while Assigned(TempNode) do
        begin
          if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.Selected[TempNode] then
          begin
            SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(TempNode);

            if not (IsEqualGUID(SzenenData^.ID,mainform.Effektsequenzereffekte[Data^.Effektnummer].ID)) then
            begin
              setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs,length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs)+1);
              mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs[length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].IDs)-1]:=SzenenData^.ID;
              mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name:=SzenenData^.Caption;
              mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].beschreibung:=SzenenData^.Beschreibung;
            end else
            begin
              ShowMessage(_('Kein Effektschritt darf den eigenen Effekt wiederaufrufen, da sonst eine Endlosschleife erzeugt wird!'));
            end;
          end;
          TempNode:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNext(TempNode);
        end;
      end;

      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
    end;
  end;
end;

procedure Teffektsequenzer.einblendzeit_hChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if not mainform.UserAccessGranted(1, false) then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure Teffektsequenzer.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

{
  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);
  mainform.Effektsequenzereffekte[Data^.Effektnummer].Repeating:=CheckBox1.Checked;
}
    if VST.SelectedCount=1 then
    begin
      Data:=VST.GetNodeData(VST.FocusedNode);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].Repeating:=CheckBox1.Checked;
    end else
    begin
      for i:=0 to length(VSTEffektNodes)-1 do
      for j:=0 to length(VSTEffektNodes[i])-1 do
      if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
      begin
        Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
        mainform.Effektsequenzereffekte[Data^.Effektnummer].Repeating:=CheckBox1.Checked;
      end;
    end;
end;

procedure Teffektsequenzer.intensityChange(Sender: TObject);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  if Sender=intensity then
  begin
    for i:=0 to length(VSTEffektNodes)-1 do
    for j:=0 to length(VSTEffektNodes[i])-1 do
    if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
    begin
      Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].intensitaet:=intensity.position;
    end;
  end;
  label13.Caption:=levelstr(intensity.Position,maxres);
end;

procedure Teffektsequenzer.speedChange(Sender: TObject);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  if Sender=speed then
  begin
    for i:=0 to length(VSTEffektNodes)-1 do
    for j:=0 to length(VSTEffektNodes[i])-1 do
    if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
    begin
      Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].speed:=speed.position;
    end;
  end;
  label14.Caption:=inttostr(speed.Position-128);
end;

procedure Teffektsequenzer.Button8Click(Sender: TObject);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if messagedlg(_('Die aktuelle Einblendzeit des aktuellen Schrittes wird auf alle anderen markierten Schritte angewendet. Fortfahren?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    for i:=0 to length(VSTEffektNodes)-1 do
    for j:=0 to length(VSTEffektNodes[i])-1 do
    if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
    begin
      Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].einblendzeit:=strtoint(einblendzeit_h.Text)*60*60*1000+strtoint(einblendzeit_min.Text)*60*1000+strtoint(einblendzeit_s.Text)*1000+strtoint(einblendzeit_ms.Text);
    end;
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.Button9Click(Sender: TObject);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if messagedlg(_('Die aktuelle Wartezeit des aktuellen Schrittes wird auf alle anderen markierten Schritte angewendet. Fortfahren?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    for i:=0 to length(VSTEffektNodes)-1 do
    for j:=0 to length(VSTEffektNodes[i])-1 do
    if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
    begin
      Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].wartezeit:=strtoint(wartezeit_h.Text)*60*60*1000+strtoint(wartezeit_min.Text)*60*1000+strtoint(wartezeit_s.Text)*1000+strtoint(wartezeit_ms.Text);;
    end;
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.CreateParams(var Params:TCreateParams);
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

procedure Teffektsequenzer.Button11Click(Sender: TObject);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if speed.Enabled then
  begin
    speed.Position:=128;

    for i:=0 to length(VSTEffektNodes)-1 do
    for j:=0 to length(VSTEffektNodes[i])-1 do
    if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
    begin
      Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].speed:=speed.Position;
    end;
  end;
end;

procedure Teffektsequenzer.Button6Click(Sender: TObject);
var
  Data: PTreeData;
  i,j,k:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    // Selektierten Effektschritt stoppen
    for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].effektschritte[Data^.Position].IDs)-1 do
      mainform.StopScene(mainform.Effektsequenzereffekte[Data^.Effektnummer].effektschritte[Data^.Position].IDs[k]);
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.MSGopen;
var
  i:integer;
begin
  TabControl1.Tabs.Clear;
  if length(mainform.EffektsequenzerTabs)=0 then
  begin
    setlength(mainform.EffektsequenzerTabs,1);
  end;

  mainform.EffektsequenzerTabs[0]:=_('Alle');
  for i:=0 to length(mainform.EffektsequenzerTabs)-1 do
    TabControl1.Tabs.Add(mainform.EffektsequenzerTabs[i]);

  RefreshTreeView;
  Checkbuttons;
end;

procedure Teffektsequenzer.MSGSave;
begin
  //
end;

procedure Teffektsequenzer.NewEffectsBtnClick(Sender: TObject);
begin
if messagedlg(_('Möchten Sie wirklich alle Effekte zurücksetzen?'),mtWarning,
  [mbYes,mbNo],0)=mrYes then
    NewFile;
end;

procedure Teffektsequenzer.OpenEffectsBtnClick(Sender: TObject);
begin
	case mainform.mymessagedlg(_('Wie sollen die Effekte aus der Datei geladen werden?'),mtConfirmation,[mbYes,mbAll,mbCancel],[_('&Hinzufügen'),_('&Ersetzen'),_('Ab&brechen')]) of
    mrYes:
      if OpenDialog1.Execute then
        AddFile(OpenDialog1.filename);
    mrCancel:
      if OpenDialog1.Execute then
        OpenFile(OpenDialog1.filename);
  end;
end;

procedure Teffektsequenzer.SaveEffectsBtnClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveFile(SaveDialog1.FileName);
  end;
end;

procedure Teffektsequenzer.AddFile(filename: string);
var
  i,k,l,m,Count,Count2,Count3,Count4,startposition,Version:integer;
begin
  FileStream:=TFileStream.Create(FileName,fmOpenRead);

  startposition:=length(mainform.Effektsequenzereffekte);

  // Projektversion
  Filestream.ReadBuffer(Version, sizeof(Count));

  Filestream.ReadBuffer(Count, sizeof(Count));
  setlength(mainform.Effektsequenzereffekte, startposition+Count);
  setlength(mainform.AktuellerEffekt, startposition+Count);
  for i:=startposition to length(mainform.Effektsequenzereffekte)-1 do
  begin
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].ID,sizeof(mainform.Effektsequenzereffekte[i].ID));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].Name,sizeof(mainform.Effektsequenzereffekte[i].Name));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].Beschreibung,sizeof(mainform.Effektsequenzereffekte[i].Beschreibung));
    if Version>=431 then
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].TabPosition,sizeof(mainform.Effektsequenzereffekte[i].TabPosition));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].AnzahlderDurchlaufe,sizeof(mainform.Effektsequenzereffekte[i].AnzahlderDurchlaufe));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].modus,sizeof(mainform.Effektsequenzereffekte[i].modus));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].Repeating,sizeof(mainform.Effektsequenzereffekte[i].Repeating));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].intensitaet,sizeof(mainform.Effektsequenzereffekte[i].intensitaet));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].speed,sizeof(mainform.Effektsequenzereffekte[i].speed));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].startwithstepone,sizeof(mainform.Effektsequenzereffekte[i].startwithstepone));
    if Version>=442 then
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].blackoutonstop,sizeof(mainform.Effektsequenzereffekte[i].blackoutonstop));
    if Version>=465 then
    begin
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].Startscene,sizeof(mainform.Effektsequenzereffekte[i].Startscene));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].Stopscene,sizeof(mainform.Effektsequenzereffekte[i].Stopscene));
    end;

    Filestream.ReadBuffer(Count2, sizeof(Count2));
    setlength(mainform.Effektsequenzereffekte[i].effektschritte,Count2);
    for k:=0 to Count2-1 do
    begin
      Filestream.ReadBuffer(Count3, sizeof(Count3));
      setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].IDs,Count3);
      for l:=0 to Count3-1 do
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].IDs[l],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].IDs[l]));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Typ,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Typ));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Name,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Name));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Beschreibung,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Beschreibung));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].einblendzeit,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].einblendzeit));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].wartezeit,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].wartezeit));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].AnzahlBeats,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].ANzahlBeats));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].DeactivateLastScene,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].DeactivateLastScene));

      Filestream.ReadBuffer(Count3,sizeof(Count3));
      setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices,Count3);
      for l:=0 to Count3-1 do
      begin
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ID,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ID));
        Filestream.ReadBuffer(Count4,sizeof(Count4));
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActive,Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValue,Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActiveRandom,Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValueRandom,Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanDelay,Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanFadetime,Count4);
        for m:=0 to Count4-1 do
        begin
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActive[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActive[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValue[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValue[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActiveRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActiveRandom[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValueRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValueRandom[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanDelay[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanDelay[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanFadetime[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanFadetime[m]));
        end;
      end;

      Filestream.ReadBuffer(Count3,sizeof(Count3));
      setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle,Count3);
      for l:=0 to Count3-1 do
      begin
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ID,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ID));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Typ,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Typ));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Name,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Name));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Beschreibung,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Beschreibung));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].OnValue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].OnValue));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Offvalue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].OffValue));
        if Version>=462 then
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].SwitchValue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].SwitchValue));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].InvertSwitchValue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].InvertSwitchValue));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Scalevalue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ScaleValue));

        Filestream.ReadBuffer(Count4,sizeof(Count4));
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgInteger,count4);
        for m:=0 to Count4-1 do
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgInteger[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgInteger[m]));
        Filestream.ReadBuffer(Count4,sizeof(Count4));
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgString,count4);
        for m:=0 to Count4-1 do
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgString[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgString[m]));
        Filestream.ReadBuffer(Count4,sizeof(Count4));
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgGUID,count4);
        for m:=0 to Count4-1 do
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgGUID[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgGUID[m]));

        Filestream.ReadBuffer(Count4,sizeof(Count4));
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActive, Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValue, Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActiveRandom, Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValueRandom, Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanDelay, Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanFadetime, Count4);
        for m:=0 to Count4-1 do
        begin
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActive[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActive[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValue[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValue[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActiveRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActiveRandom[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValueRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValueRandom[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanDelay[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanDelay[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanFadetime[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanFadetime[m]));
        end;
      end;

      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].ActivateTimecontrol,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].ActivateTimecontrol));
    end;
  end;
  FileStream.Free;

  RefreshTreeView;
  Checkbuttons;
end;

procedure Teffektsequenzer.OpenFile(filename: string);
var
  i,k,l,m,Count,Count2,Count3,Count4, Version:integer;
begin
  FileStream:=TFileStream.Create(FileName,fmOpenRead);

  // Projektversion
  Filestream.ReadBuffer(Version, sizeof(Count));

  Filestream.ReadBuffer(Count, sizeof(Count));
  setlength(mainform.Effektsequenzereffekte, Count);
  setlength(mainform.AktuellerEffekt, Count);
  for i:=0 to Count-1 do
  begin
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].ID,sizeof(mainform.Effektsequenzereffekte[i].ID));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].Name,sizeof(mainform.Effektsequenzereffekte[i].Name));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].Beschreibung,sizeof(mainform.Effektsequenzereffekte[i].Beschreibung));
    if Version>=431 then
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].TabPosition,sizeof(mainform.Effektsequenzereffekte[i].TabPosition));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].AnzahlderDurchlaufe,sizeof(mainform.Effektsequenzereffekte[i].AnzahlderDurchlaufe));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].modus,sizeof(mainform.Effektsequenzereffekte[i].modus));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].Repeating,sizeof(mainform.Effektsequenzereffekte[i].Repeating));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].intensitaet,sizeof(mainform.Effektsequenzereffekte[i].intensitaet));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].speed,sizeof(mainform.Effektsequenzereffekte[i].speed));
    Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].startwithstepone,sizeof(mainform.Effektsequenzereffekte[i].startwithstepone));
    if Version>=442 then
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].blackoutonstop,sizeof(mainform.Effektsequenzereffekte[i].blackoutonstop));
    if Version>=465 then
    begin
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].Startscene,sizeof(mainform.Effektsequenzereffekte[i].Startscene));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].Stopscene,sizeof(mainform.Effektsequenzereffekte[i].Stopscene));
    end;

    Filestream.ReadBuffer(Count2, sizeof(Count2));
    setlength(mainform.Effektsequenzereffekte[i].effektschritte,Count2);
    for k:=0 to Count2-1 do
    begin
      Filestream.ReadBuffer(Count3, sizeof(Count3));
      setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].IDs,Count3);
      for l:=0 to Count3-1 do
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].IDs[l],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].IDs[l]));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Typ,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Typ));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Name,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Name));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Beschreibung,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Beschreibung));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].einblendzeit,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].einblendzeit));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].wartezeit,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].wartezeit));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].AnzahlBeats,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].ANzahlBeats));
      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].DeactivateLastScene,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].DeactivateLastScene));

      Filestream.ReadBuffer(Count3,sizeof(Count3));
      setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices,Count3);
      for l:=0 to Count3-1 do
      begin
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ID,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ID));
        Filestream.ReadBuffer(Count4,sizeof(Count4));
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActive,Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValue,Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActiveRandom,Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValueRandom,Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanDelay,Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanFadetime,Count4);
        for m:=0 to Count4-1 do
        begin
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActive[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActive[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValue[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValue[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActiveRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActiveRandom[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValueRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValueRandom[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanDelay[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanDelay[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanFadetime[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanFadetime[m]));
        end;
      end;

      Filestream.ReadBuffer(Count3,sizeof(Count3));
      setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle,Count3);
      for l:=0 to Count3-1 do
      begin
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ID,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ID));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Typ,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Typ));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Name,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Name));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Beschreibung,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Beschreibung));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].OnValue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].OnValue));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Offvalue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].OffValue));
        if Version>=462 then
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].SwitchValue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].SwitchValue));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].InvertSwitchValue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].InvertSwitchValue));
        Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Scalevalue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ScaleValue));

        Filestream.ReadBuffer(Count4,sizeof(Count4));
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgInteger,count4);
        for m:=0 to Count4-1 do
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgInteger[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgInteger[m]));
        Filestream.ReadBuffer(Count4,sizeof(Count4));
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgString,count4);
        for m:=0 to Count4-1 do
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgString[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgString[m]));
        Filestream.ReadBuffer(Count4,sizeof(Count4));
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgGUID,count4);
        for m:=0 to Count4-1 do
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgGUID[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgGUID[m]));

        Filestream.ReadBuffer(Count4,sizeof(Count4));
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActive, Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValue, Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActiveRandom, Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValueRandom, Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanDelay, Count4);
        setlength(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanFadetime, Count4);
        for m:=0 to Count4-1 do
        begin
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActive[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActive[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValue[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValue[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActiveRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActiveRandom[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValueRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValueRandom[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanDelay[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanDelay[m]));
          Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanFadetime[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanFadetime[m]));
        end;
      end;

      Filestream.ReadBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].ActivateTimecontrol,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].ActivateTimecontrol));
    end;
  end;
  FileStream.Free;

  RefreshTreeView;
  Checkbuttons;
end;

procedure Teffektsequenzer.SaveFile(filename: string);
var
  i,k,l,m,Count,Count2,Count3,Count4:integer;
begin
  FileStream:=TFileStream.Create(FileName,fmCreate);
                    
  // Projektversion
  Count:=mainform.currentprojectversion;
  Filestream.WriteBuffer(Count, sizeof(Count));

  Count:=length(mainform.Effektsequenzereffekte);
  Filestream.WriteBuffer(Count, sizeof(Count));
  for i:=0 to Count-1 do
  begin
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].ID,sizeof(mainform.Effektsequenzereffekte[i].ID));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].Name,sizeof(mainform.Effektsequenzereffekte[i].Name));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].Beschreibung,sizeof(mainform.Effektsequenzereffekte[i].Beschreibung));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].TabPosition,sizeof(mainform.Effektsequenzereffekte[i].TabPosition));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].AnzahlderDurchlaufe,sizeof(mainform.Effektsequenzereffekte[i].AnzahlderDurchlaufe));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].modus,sizeof(mainform.Effektsequenzereffekte[i].modus));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].Repeating,sizeof(mainform.Effektsequenzereffekte[i].Repeating));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].intensitaet,sizeof(mainform.Effektsequenzereffekte[i].intensitaet));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].speed,sizeof(mainform.Effektsequenzereffekte[i].speed));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].StartwithStepOne,sizeof(mainform.Effektsequenzereffekte[i].StartwithStepOne));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].blackoutonstop,sizeof(mainform.Effektsequenzereffekte[i].blackoutonstop));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].Startscene,sizeof(mainform.Effektsequenzereffekte[i].Startscene));
    Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].Stopscene,sizeof(mainform.Effektsequenzereffekte[i].Stopscene));

    Count2:=length(mainform.Effektsequenzereffekte[i].effektschritte);
    Filestream.WriteBuffer(Count2, sizeof(Count2));
    for k:=0 to Count2-1 do
    begin
      Count3:=length(mainform.Effektsequenzereffekte[i].effektschritte[k].IDs);
      Filestream.WriteBuffer(Count3, sizeof(Count3));
      for l:=0 to Count3-1 do
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].IDs[l],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].IDs[l]));
      Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Typ,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Typ));
      Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Name,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Name));
      Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Beschreibung,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Beschreibung));
      Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].einblendzeit,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].einblendzeit));
      Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].wartezeit,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].wartezeit));
      Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].AnzahlBeats,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].ANzahlBeats));
      Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].DeactivateLastScene,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].DeactivateLastScene));

      Count3:=length(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices);
      Filestream.WriteBuffer(Count3,sizeof(Count3));
      for l:=0 to Count3-1 do
      begin
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ID,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ID));
        Count4:=length(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActive);
        Filestream.WriteBuffer(Count4,sizeof(Count4));
        for m:=0 to Count4-1 do
        begin
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActive[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActive[m]));
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValue[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValue[m]));
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActiveRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanActiveRandom[m]));
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValueRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanValueRandom[m]));
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanDelay[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanDelay[m]));
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanFadetime[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Devices[l].ChanFadetime[m]));
        end;
      end;

      Count3:=length(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle);
      Filestream.WriteBuffer(Count3,sizeof(Count3));
      for l:=0 to Count3-1 do
      begin
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ID,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ID));
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Typ,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Typ));
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Name,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Name));
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Beschreibung,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Beschreibung));
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].OnValue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].OnValue));
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Offvalue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].OffValue));
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].SwitchValue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].SwitchValue));
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].InvertSwitchValue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].InvertSwitchValue));
        Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].Scalevalue,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ScaleValue));

        Count4:=length(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgInteger);
        Filestream.WriteBuffer(Count4,sizeof(Count4));
        for m:=0 to Count4-1 do
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgInteger[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgInteger[m]));
        Count4:=length(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgString);
        Filestream.WriteBuffer(Count4,sizeof(Count4));
        for m:=0 to Count4-1 do
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgString[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgString[m]));
        Count4:=length(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgGUID);
        Filestream.WriteBuffer(Count4,sizeof(Count4));
        for m:=0 to Count4-1 do
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgGUID[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehle[l].ArgGUID[m]));

        Count2:=length(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActive);
        Filestream.WriteBuffer(Count2,sizeof(Count2));
        for m:=0 to Count2-1 do
        begin
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActive[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActive[m]));
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValue[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValue[m]));
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActiveRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanActiveRandom[m]));
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValueRandom[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanValueRandom[m]));
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanDelay[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanDelay[m]));
          Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanFadetime[m],sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].Befehlswerte[l].ChanFadetime[m]));
        end;
      end;
      Filestream.WriteBuffer(mainform.Effektsequenzereffekte[i].effektschritte[k].ActivateTimecontrol,sizeof(mainform.Effektsequenzereffekte[i].effektschritte[k].ActivateTimecontrol));
    end;
  end;

  FileStream.Free;
end;

procedure Teffektsequenzer.NewFile;
var
  i:integer;
begin
  for i:=0 to length(mainform.effektsequenzereffekte)-1 do
    mainform.AktuellerEffekt[i].Aktiv:=false;

  VST.Clear;
  VST.NodeDataSize:=sizeof(TTreeData);
  setlength(VSTRootNodes,0);
  setlength(VSTEffektNodes,0);

  deleteeffectbtn.Enabled:=false;
  duplicateeffect.Enabled:=false;
  editstartscenebtn.Enabled:=false;
  removestartscenebtn.Enabled:=false;
  editstopscenebtn.Enabled:=false;
  removestopscenebtn.Enabled:=false;
  moveeffectupbtn.Enabled:=false;
  moveeffectdownbtn.Enabled:=false;
  Button5.Enabled:=false;
  intensity.Enabled:=false;
  speed.Enabled:=false;
  groupbox3.Enabled:=false;
  Combobox2.enabled:=false;
  EditBtn.Enabled:=false;
  CopyBtn.Enabled:=false;
  deletestepbtn.Enabled:=false;
  lauflichtbtn.enabled:=false;
  matrixbtn.Enabled:=false;

  Button2.Enabled:=false;
  Button4.Enabled:=false;
  Button6.Enabled:=false;
  Button10.Enabled:=false;
  PngBitBtn1.enabled:=false;

  setlength(mainform.effektsequenzereffekte,0);
  setlength(mainform.AktuellerEffekt,0);
end;

procedure Teffektsequenzer.Edit3Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if not mainform.UserAccessGranted(1, false) then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure Teffektsequenzer.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].ActivateTimecontrol:=CheckBox2.Checked;
  end;

  wartezeit_h.Enabled:=checkbox2.Checked and checkbox2.Enabled;
  wartezeit_min.Enabled:=wartezeit_h.Enabled;
  wartezeit_s.Enabled:=wartezeit_h.Enabled;
  wartezeit_ms.Enabled:=wartezeit_h.Enabled;
end;

procedure Teffektsequenzer.ComboBox2Select(Sender: TObject);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  EditBtn.enabled:=true;
  CopyBtn.Enabled:=true;

  case Combobox2.ItemIndex of
    0: mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Typ:=3;
    1: mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Typ:=0;
    2: mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Typ:=1;
    3: mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Typ:=2;
  end;

  einblendzeit_h.Enabled:=(combobox2.itemindex=1) and combobox2.enabled;
  wartezeit_h.Enabled:=checkbox2.Checked and checkbox2.Enabled;
  einblendzeit_min.Enabled:=einblendzeit_h.Enabled;
  einblendzeit_s.Enabled:=einblendzeit_h.Enabled;
  einblendzeit_ms.Enabled:=einblendzeit_h.Enabled;
  wartezeit_min.Enabled:=wartezeit_h.Enabled;
  wartezeit_s.Enabled:=wartezeit_h.Enabled;
  wartezeit_ms.Enabled:=wartezeit_h.Enabled;
end;

procedure Teffektsequenzer.CheckBox3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].DeactivateLastScene:=CheckBox3.Checked;
  end;
end;

procedure Teffektsequenzer.CheckBox4MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=1 then
  begin
    Data:=VST.GetNodeData(VST.FocusedNode);
    mainform.Effektsequenzereffekte[Data^.Effektnummer].startwithstepone:=CheckBox4.Checked;
  end else
  begin
    for i:=0 to length(VSTEffektNodes)-1 do
    for j:=0 to length(VSTEffektNodes[i])-1 do
    if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
    begin
      Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].startwithstepone:=CheckBox4.Checked;
    end;
  end;
end;

procedure Teffektsequenzer.PngBitBtn1Click(Sender: TObject);
var
  Data: PTreeData;
  i,j,k:integer;
begin
  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].effektschritte[Data^.Position].IDs)-1 do
      mainform.StartScene(mainform.Effektsequenzereffekte[Data^.Effektnummer].effektschritte[Data^.Position].IDs[k],false,false,-1);
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.duplicateeffectClick(Sender: TObject);
var
  Data: PTreeData;
//  j:integer;
//  NewNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  if Data^.NodeType=1 then // Sublevel
  begin
    setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)+1);
    setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)+1);

    CopyEffect(Data^.Effektnummer, length(mainform.Effektsequenzereffekte)-1, false);
    mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Name:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Name+' - '+_('Kopie');
  end else if Data^.NodeType=0 then // Toplevel
  begin
    setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)+1);
    setlength(mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Effektschritte,length(mainform.Effektsequenzereffekte[Data^.Position].Effektschritte));
    setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)+1);

    CopyEffect(Data^.Effektnummer, length(mainform.Effektsequenzereffekte)-1, false);
    mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Name:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Name+' - '+_('Kopie');
  end;

{
  setlength(VSTRootNodes, length(VSTRootNodes)+1);
  setlength(VSTEffektNodes, length(VSTEffektNodes)+1);
  NewNode:=VST.AddChild(nil);
  Data:=VST.GetNodeData(NewNode);
  Data^.NodeType:=0;
  Data^.Caption:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Name;
  Data^.Beschreibung:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Beschreibung;
  Data^.Effektnummer:=length(mainform.Effektsequenzereffekte)-1;
  Data^.EffektnummerInTree:=length(VSTRootNodes)-1;
  Data^.Position:=length(mainform.Effektsequenzereffekte)-1;
  Data^.ID:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].ID;

  for j:=0 to length(mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Effektschritte)-1 do
  begin
    setlength(VSTEffektNodes[length(mainform.Effektsequenzereffekte)-1],length(VSTEffektNodes[length(mainform.Effektsequenzereffekte)-1])+1);

    VSTEffektNodes[length(mainform.Effektsequenzereffekte)-1][j]:=VST.AddChild(VSTRootNodes[length(mainform.Effektsequenzereffekte)-1]);
    Data:=VST.GetNodeData(VSTEffektNodes[length(mainform.Effektsequenzereffekte)-1][j]);
    Data^.NodeType:=1;
    Data^.Caption:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Effektschritte[j].Name;
    Data^.Beschreibung:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Effektschritte[j].Beschreibung;
    Data^.Effektnummer:=length(mainform.Effektsequenzereffekte)-1;
    Data^.EffektnummerInTree:=length(VSTRootNodes)-1;
    Data^.Position:=j;
    Data^.ID:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].ID;
  end;

  VST.FocusedNode:=VSTRootNodes[length(mainform.Effektsequenzereffekte)-1];
  VST.Selected[VSTRootNodes[length(mainform.Effektsequenzereffekte)-1]]:=true;

  checkbuttons;

  mainform.EffectsChanged;
}
  Button12Click(nil);
end;


procedure Teffektsequenzer.CopyEffectStep(SourceEffect, SourceStep, DestinationEffect, DestinationStep:integer; AddCopyTitle:boolean);
var
  i,j,k:integer;
begin
  // Aktuelle Position in neues Array kopieren
  mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Typ:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Typ;
  if AddCopyTitle then
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Name:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Name+' - '+_('Kopie')
  else
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Name:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Name;
  mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Beschreibung:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Beschreibung;
  mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].einblendzeit:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].einblendzeit;
  mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].wartezeit:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].wartezeit;
  mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].AnzahlBeats:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].AnzahlBeats;
  mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].ActivateTimecontrol:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].ActivateTimecontrol;
  mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].DeactivateLastScene:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].DeactivateLastScene;

  setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].IDs,length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].IDs));
  for i:=0 to length(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].IDs)-1 do
  begin
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].IDs[i]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].IDs[i];
  end;

  setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices,length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices));
  for i:=0 to length(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices)-1 do
  begin
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ID:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ID;
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanActive,length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanActive));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanValue,length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanValue));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanActiveRandom,length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanActiveRandom));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanValueRandom,length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanValueRandom));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanDelay,length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanDelay));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanFadetime,length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanFadetime));

    for j:=0 to length(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanActive)-1 do
    begin
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanActive[j]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanActive[j];
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanValue[j]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanValue[j];
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanActiveRandom[j]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanActiveRandom[j];
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanValueRandom[j]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanValueRandom[j];
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanDelay[j]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanDelay[j];
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Devices[i].ChanFadetime[j]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Devices[i].ChanFadetime[j];
    end;
  end;

  setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle,length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle));
  setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte,length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte));
  for i:=0 to length(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle)-1 do
  begin
    CreateGUID(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ID);
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].Typ:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].Typ;
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].Name:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].Name;
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].Beschreibung:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].Beschreibung;
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].OnValue:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].OnValue;
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].OffValue:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].OffValue;
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].SwitchValue:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].SwitchValue;
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].InvertSwitchValue:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].InvertSwitchValue;
    mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ScaleValue:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].ScaleValue;

    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ArgInteger, length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].ArgInteger));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ArgString, length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].ArgString));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ArgGUID, length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].ArgGUID));
    for j:=0 to length(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ArgInteger)-1 do
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ArgInteger[j]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].ArgInteger[j];
    for j:=0 to length(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ArgString)-1 do
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ArgString[j]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].ArgString[j];
    for j:=0 to length(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ArgGUID)-1 do
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehle[i].ArgGUID[j]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehle[i].ArgGUID[j];

    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanActive, length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanActive));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanValue, length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanValue));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanActiveRandom, length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanActiveRandom));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanValueRandom, length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanValueRandom));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanDelay, length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanDelay));
    setlength(mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanFadetime, length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanFadetime));
    for k:=0 to length(mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanActive)-1 do
    begin
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanActive[k]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanActive[k];
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanValue[k]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanValue[k];
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanActiveRAndom[k]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanActiveRandom[k];
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanValueRandom[k]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanValueRandom[k];
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanDelay[k]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanDelay[k];
      mainform.Effektsequenzereffekte[DestinationEffect].Effektschritte[DestinationStep].Befehlswerte[i].ChanFadetime[k]:=mainform.Effektsequenzereffekte[SourceEffect].Effektschritte[SourceStep].Befehlswerte[i].ChanFadetime[k];
    end;
  end;
end;

procedure Teffektsequenzer.copybtnClick(Sender: TObject);
var
  Data{, DataNew}: PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;
  
  Data:=VST.GetNodeData(VST.FocusedNode);

  if Data^.NodeType<>1 then exit;

  // Neuen Effektschritt anlegen
  setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte,length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)+1);

  CopyEffectStep(Data^.Effektnummer, Data^.Position, Data^.Effektnummer, length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1, true);

  RefreshTreeView;
  checkbuttons;
//  Button12Click(nil);

{
  setlength(VSTEffektNodes[Data^.EffektnummerInTree],length(VSTEffektNodes[Data^.EffektnummerInTree])+1);

  VSTEffektNodes[Data^.EffektnummerInTree][length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1]:=VST.AddChild(VSTRootNodes[Data^.EffektnummerInTree]);
  DataNew:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1]);
  DataNew^.NodeType:=1;
  DataNew^.Caption:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].Name;
  DataNew^.Beschreibung:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].Beschreibung;
  DataNew^.Effektnummer:=Data^.Effektnummer;
  DataNew^.Position:=length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1;
  DataNew^.ID:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].ID;

  VST.FocusedNode:=VSTEffektNodes[DataNew^.EffektnummerInTree][length(mainform.Effektsequenzereffekte[DataNew^.Effektnummer].Effektschritte)-1];
  VST.Selected[VSTEffektNodes[DataNew^.EffektnummerInTree][length(mainform.Effektsequenzereffekte[DataNew^.Effektnummer].Effektschritte)-1]]:=true;
}
end;

procedure Teffektsequenzer.wartezeit_hChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if not mainform.UserAccessGranted(1, false) then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure Teffektsequenzer.einblendzeit_hKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Einblendzeit:=strtoint(einblendzeit_h.Text)*60*60*1000+strtoint(einblendzeit_min.Text)*60*1000+strtoint(einblendzeit_s.Text)*1000+strtoint(einblendzeit_ms.Text);
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.wartezeit_hKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Wartezeit:=strtoint(wartezeit_h.Text)*60*60*1000+strtoint(wartezeit_min.Text)*60*1000+strtoint(wartezeit_s.Text)*1000+strtoint(wartezeit_ms.Text);
    if mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].einblendzeit+mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].wartezeit<10 then
      mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Wartezeit:=10;
  end;
  VST.Refresh;
end;

procedure Teffektsequenzer.Edit3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  for i:=0 to length(VSTEffektNodes)-1 do
  for j:=0 to length(VSTEffektNodes[i])-1 do
  if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
  begin
    Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].AnzahlBeats:=strtoint(Edit3.text);
    if mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].AnzahlBeats<1 then Edit3.Text:='1';
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].AnzahlBeats:=strtoint(Edit3.text);
  end;
end;

procedure Teffektsequenzer.moveeffectupbtnClick(Sender: TObject);
var
  Data: PTreeData;
  i,aktuellereffekt:integer;
  oldid:TGUID;
begin
  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);
  oldid:=Data^.ID;

  aktuellereffekt:=Data^.Effektnummer;
  mainform.AktuellerEffekt[aktuellereffekt].Aktiv:=false;

  if aktuellereffekt=0 then exit;

  // Effektarray um eins erweitern
  setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)+1);
  setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)+1);

  // Aktuellen Effekt auf letzte Position kopieren
  CopyEffect(aktuellereffekt,length(mainform.AktuellerEffekt)-1, true);
  // Oberen Effekt auf aktuelle Position kopieren
  CopyEffect(aktuellereffekt-1,aktuellereffekt, true);
  // Letzten Effekt auf oberen Effekt kopieren
  CopyEffect(length(mainform.AktuellerEffekt)-1,aktuellereffekt-1, true);

  // Effektarray um ein kürzen
  setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)-1);
  setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)-1);

  RefreshTreeView;

  for i:=0 to length(VSTRootNodes)-1 do
  begin
    Data:=VST.GetNodeData(VSTRootNodes[i]);
    if IsEqualGUID(Data^.ID, oldid) then
    begin
      VST.FocusedNode:=VSTRootNodes[i];
      VST.Selected[VSTRootNodes[i]]:=true;
      break;
    end;
  end;

  Checkbuttons;

  mainform.EffectsChanged;
end;

procedure Teffektsequenzer.moveeffectdownbtnClick(Sender: TObject);
var
  Data: PTreeData;
  i,aktuellereffekt:integer;
  oldid:TGUID;
begin
  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);
  oldid:=Data^.ID;

  aktuellereffekt:=Data^.Effektnummer;
  mainform.AktuellerEffekt[aktuellereffekt].Aktiv:=false;

  if aktuellereffekt=length(mainform.Effektsequenzereffekte)-1 then exit;

  // Effektarray um eins erweitern
  setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)+1);
  setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)+1);

  // Aktuellen Effekt auf letzte Position kopieren
  CopyEffect(aktuellereffekt,length(mainform.AktuellerEffekt)-1, true);
  // Unteren Effekt auf aktuelle Position kopieren
  CopyEffect(aktuellereffekt+1,aktuellereffekt, true);
  // Letzten Effekt auf unteren Effekt kopieren
  CopyEffect(length(mainform.AktuellerEffekt)-1,aktuellereffekt+1, true);

  // Effektarray um ein kürzen
  setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)-1);
  setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)-1);
    
  RefreshTreeView;

  for i:=0 to length(VSTRootNodes)-1 do
  begin
    Data:=VST.GetNodeData(VSTRootNodes[i]);
    if IsEqualGUID(Data^.ID, oldid) then
    begin
      VST.FocusedNode:=VSTRootNodes[i];
      VST.Selected[VSTRootNodes[i]]:=true;
      break;
    end;
  end;

  Checkbuttons;

  mainform.EffectsChanged;
end;

procedure Teffektsequenzer.CopyEffect(Source, Destination:integer; KeepID: boolean);
var
  i:integer;
begin
  if KeepID then
    mainform.Effektsequenzereffekte[Destination].ID:=mainform.Effektsequenzereffekte[Source].ID
  else
    CreateGUID(mainform.Effektsequenzereffekte[Destination].ID);

  mainform.Effektsequenzereffekte[Destination].Name:=mainform.Effektsequenzereffekte[Source].Name;
  mainform.Effektsequenzereffekte[Destination].Beschreibung:=mainform.Effektsequenzereffekte[Source].Beschreibung;
  setlength(mainform.Effektsequenzereffekte[Destination].Effektschritte,length(mainform.Effektsequenzereffekte[Source].Effektschritte));
  for i:=0 to length(mainform.Effektsequenzereffekte[Source].Effektschritte)-1 do
  begin
    CopyEffectStep(Source, i, Destination, i, false);
  end;

  mainform.Effektsequenzereffekte[Destination].TabPosition:=mainform.Effektsequenzereffekte[Source].TabPosition;
  mainform.Effektsequenzereffekte[Destination].AnzahlderDurchlaufe:=mainform.Effektsequenzereffekte[Source].AnzahlderDurchlaufe;
  mainform.Effektsequenzereffekte[Destination].Repeating:=mainform.Effektsequenzereffekte[Source].Repeating;
  mainform.Effektsequenzereffekte[Destination].modus:=mainform.Effektsequenzereffekte[Source].modus;
  mainform.Effektsequenzereffekte[Destination].intensitaet:=mainform.Effektsequenzereffekte[Source].intensitaet;
  mainform.Effektsequenzereffekte[Destination].speed:=mainform.Effektsequenzereffekte[Source].speed;
  mainform.Effektsequenzereffekte[Destination].startwithstepone:=mainform.Effektsequenzereffekte[Source].startwithstepone;
  mainform.Effektsequenzereffekte[Destination].blackoutonstop:=mainform.Effektsequenzereffekte[Source].blackoutonstop;
  mainform.Effektsequenzereffekte[Destination].Startscene:=mainform.Effektsequenzereffekte[Source].Startscene;
  mainform.Effektsequenzereffekte[Destination].Stopscene:=mainform.Effektsequenzereffekte[Source].Stopscene;

  mainform.AktuellerEffekt[Destination].Aktiv:=mainform.AktuellerEffekt[Source].Aktiv;
  mainform.AktuellerEffekt[Destination].rueckwaerts:=mainform.AktuellerEffekt[Source].rueckwaerts;
  mainform.AktuellerEffekt[Destination].AktuellerSchritt:=mainform.AktuellerEffekt[Source].AktuellerSchritt;
  mainform.AktuellerEffekt[Destination].Zeit:=mainform.AktuellerEffekt[Source].Zeit;
  mainform.AktuellerEffekt[Destination].Durchlauf:=mainform.AktuellerEffekt[Source].Durchlauf;
  mainform.AktuellerEffekt[Destination].AnzahlderSchritte:=mainform.AktuellerEffekt[Source].AnzahlderSchritte;
  mainform.AktuellerEffekt[Destination].SingleStep:=mainform.AktuellerEffekt[Source].SingleStep;
  setlength(mainform.AktuellerEffekt[Destination].LastScene,length(mainform.AktuellerEffekt[Source].LastScene));
  for i:=0 to length(mainform.AktuellerEffekt[Source].LastScene)-1 do
    mainform.AktuellerEffekt[Destination].LastScene[i]:=mainform.AktuellerEffekt[Source].LastScene[i];
  mainform.AktuellerEffekt[Destination].AnzahlBeats:=mainform.AktuellerEffekt[Source].AnzahlBeats;
  mainform.AktuellerEffekt[Destination].Beatgesteuert:=mainform.AktuellerEffekt[Source].Beatgesteuert;
  mainform.AktuellerEffekt[Destination].DeactivateZeitsteuerung:=mainform.AktuellerEffekt[Source].DeactivateZeitsteuerung;
end;

procedure Teffektsequenzer.Button7Click(Sender: TObject);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);
  InputBox(_('Effekt-ID'),_('Die ID des aktuellen Effektes lautet wie folgt:'),GUIDtoString(Data^.ID));
end;

procedure Teffektsequenzer.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if (not Eigenschaftenausblenden1.Checked) and ((NewWidth<690) or (NewHeight<548)) then
    Resize:=false;
end;

procedure Teffektsequenzer.PngBitBtn2Click(Sender: TObject);
begin
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Effektmodus:=true;
  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Caption:='Effektverwaltung';
  setlength(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionen,1);

  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal;

  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
end;

procedure Teffektsequenzer.RefreshTimerTimer(Sender: TObject);
begin
  if RefreshGUI then
  begin
    RefreshGUI:=false;
    vst.refresh;
  end;
end;

procedure Teffektsequenzer.SaveSelection;
var
  i,j:integer;
begin
  setlength(ExpandedNodes,length(VSTRootNodes));
  setlength(SelectedNodes,length(VSTEffektNodes));

  for i:=0 to length(VSTRootNodes)-1 do
  begin
    ExpandedNodes[i]:=VST.Expanded[VSTRootNodes[i]];

    for j:=0 to length(VSTEffektNodes)-1 do
    begin
      SelectedNodes[i][j]:=VST.Selected[VSTEffektNodes[i][j]];
    end;
  end;
end;

procedure Teffektsequenzer.RecallSelection;
var
  i,j:integer;
begin
  try
    if (length(VSTRootNodes)=length(ExpandedNodes)) and (length(VSTEffektNodes)=length(SelectedNodes)) then
    begin
      for i:=0 to length(VSTRootNodes)-1 do
      begin
        VST.Expanded[VSTRootNodes[i]]:=ExpandedNodes[i];

        for j:=0 to length(VSTEffektNodes)-1 do
        begin
          VST.Selected[VSTEffektNodes[i][j]]:=SelectedNodes[i][j];
        end;
      end;
    end;
  except
  end;
end;


procedure Teffektsequenzer.FormCreate(Sender: TObject);
var
  i:integer;
begin
  TranslateComponent(self);

  TabControl1.Tabs.Clear;
  setlength(mainform.EffektsequenzerTabs,1);
  mainform.EffektsequenzerTabs[0]:=_('Alle');

  for i:=0 to length(mainform.EffektsequenzerTabs)-1 do
    TabControl1.Tabs.Add(mainform.EffektsequenzerTabs[i]);
end;

procedure Teffektsequenzer.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Teffektsequenzer.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Teffektsequenzer.EffektSort(iLo, iHi:integer);
var
  Lo, Hi: Integer;
//  Pivot:Single;
  CompareName:string;
begin
  Lo := iLo;
  Hi := iHi;
//  Pivot := mainform.Effektsequenzereffekte[(Lo + Hi) div 2].AnzahlderDurchlaufe;
  CompareName:=mainform.Effektsequenzereffekte[(Lo + Hi) div 2].Name;
  repeat
//    while mainform.Effektsequenzereffekte[Lo].AnzahlderDurchlaufe < Pivot do Inc(Lo) ;
//    while mainform.Effektsequenzereffekte[Hi].AnzahlderDurchlaufe > Pivot do Dec(Hi) ;
    while CompareStr(mainform.Effektsequenzereffekte[Lo].Name, CompareName) < 0 do Inc(Lo) ;
    while CompareStr(mainform.Effektsequenzereffekte[Hi].Name, CompareName) > 0 do Dec(Hi) ;
    if Lo <= Hi then
    begin
      // in folgenden drei Zeilen Arrayinhalte kopieren
      setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)+1);
      setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)+1);
      CopyEffect(Lo,length(mainform.Effektsequenzereffekte)-1, true);
//      T := A[Lo];
      CopyEffect(Hi,Lo,true);
//      A[Hi] := T;
      CopyEffect(length(mainform.Effektsequenzereffekte)-1,Hi,true);
      setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)-1);
      setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)-1);
      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > iLo then EffektSort(iLo, Hi);
  if Lo < iHi then EffektSort(Lo, iHi);
end;

procedure Teffektsequenzer.Button12Click(Sender: TObject);
begin
  if length(mainform.Effektsequenzereffekte)>1 then
  begin
    EffektSort(Low(mainform.Effektsequenzereffekte),High(mainform.Effektsequenzereffekte));
  end;

  RefreshTreeView;
  checkbuttons;

  mainform.EffectsChanged;
end;

procedure Teffektsequenzer.lauflichtbtnClick(Sender: TObject);
var
  Data: PTreeData;
  i,j,k:integer;
  effectnodeindex:integer;
  DataNew:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

//  effectnodeindex:=-1;

  lauflichtassistentform.showmodal;

  if lauflichtassistentform.ModalResult=mrOk then
  begin
    for i:=0 to length(lauflichtassistentform.lauflichtarray)-1 do
    begin
      effectnodeindex:=Data^.Effektnummer;

      if effectnodeindex=-1 then exit;
      
      mainform.AktuellerEffekt[effectnodeindex].Aktiv:=false;
      setlength(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte,length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)+1);
      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Name:=lauflichtassistentform.edit1.text+' ('+inttostr(i)+')';
      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].wartezeit:=lauflichtassistentform.Timer1.Interval;
      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].DeactivateLastScene:=true;

      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Typ:=0;
      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].ActivateTimecontrol:=true;
      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].einblendzeit:=strtoint(lauflichtassistentform.hedit.text)*3600000+strtoint(lauflichtassistentform.minedit.text)*60000+strtoint(lauflichtassistentform.sedit.text)*1000+strtoint(lauflichtassistentform.msedit.text);

      setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices, length(lauflichtassistentform.lauflichtdevices));
      for j:=0 to length(lauflichtassistentform.lauflichtdevices)-1 do
      begin
        mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ID:=lauflichtassistentform.lauflichtdevices[j];

        if geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])=-1 then
        begin
          // Gruppe
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive, length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue, length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActiveRandom, length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValueRandom, length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay, length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime, length(mainform.DeviceChannelNames));

          if (lauflichtassistentform.lauflichtarray[i][j].useonlyrgb) then
          begin
            // R-Kanal eintragen
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[14]:=true;
            if lauflichtassistentform.lauflichtarray[i][j].enabled then
            begin
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[14]:=lauflichtassistentform.lauflichtarray[i][j].r;
            end else
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[14]:=0;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[14]:=lauflichtassistentform.lauflichtarray[i][j].delay;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[14]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;

            // G-Kanal eintragen
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[15]:=true;
            if lauflichtassistentform.lauflichtarray[i][j].enabled then
            begin
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[15]:=lauflichtassistentform.lauflichtarray[i][j].g;
            end else
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[15]:=0;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[15]:=lauflichtassistentform.lauflichtarray[i][j].delay;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[15]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;

            // B-Kanal eintragen
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[16]:=true;
            if lauflichtassistentform.lauflichtarray[i][j].enabled then
            begin
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[16]:=lauflichtassistentform.lauflichtarray[i][j].b;
            end else
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[16]:=0;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[16]:=lauflichtassistentform.lauflichtarray[i][j].delay;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[16]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;

            // A-Kanal eintragen
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[41]:=true;
            if lauflichtassistentform.lauflichtarray[i][j].enabled then
            begin
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[41]:=lauflichtassistentform.lauflichtarray[i][j].a;
            end else
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[41]:=0;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[41]:=lauflichtassistentform.lauflichtarray[i][j].delay;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[41]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;

            // W-Kanal eintragen
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[40]:=true;
            if lauflichtassistentform.lauflichtarray[i][j].enabled then
            begin
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[40]:=lauflichtassistentform.lauflichtarray[i][j].w;
            end else
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[40]:=0;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[40]:=lauflichtassistentform.lauflichtarray[i][j].delay;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[40]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;
          end else
          begin
            // Standardkanal eintragen
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[lauflichtassistentform.lauflichtarray[i][j].channel]:=true;
            if lauflichtassistentform.lauflichtarray[i][j].enabled then
            begin
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[lauflichtassistentform.lauflichtarray[i][j].channel]:=lauflichtassistentform.lauflichtarray[i][j].intensity;
            end else
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[lauflichtassistentform.lauflichtarray[i][j].channel]:=0;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[lauflichtassistentform.lauflichtarray[i][j].channel]:=lauflichtassistentform.lauflichtarray[i][j].delay;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[lauflichtassistentform.lauflichtarray[i][j].channel]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;
          end;
        end else
        begin
          // Gerät
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].MaxChan);
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].MaxChan);
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActiveRandom, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].MaxChan);
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValueRandom, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].MaxChan);
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].MaxChan);
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].MaxChan);

          if (lauflichtassistentform.lauflichtarray[i][j].useonlyrgb) then
          begin
            // RGB-Kanäle eintragen
            for k:=0 to length(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive)-1 do
            begin
              // Alle Gerätekanäle abklappern
              if ('r'=lowercase(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].kanaltyp[k])) then
              begin
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[k]:=true;
                if lauflichtassistentform.lauflichtarray[i][j].enabled then
                begin
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=lauflichtassistentform.lauflichtarray[i][j].r;
                end else
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=0;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[k]:=lauflichtassistentform.lauflichtarray[i][j].delay;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[k]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;
              end;
              if ('g'=lowercase(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].kanaltyp[k])) then
              begin
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[k]:=true;
                if lauflichtassistentform.lauflichtarray[i][j].enabled then
                begin
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=lauflichtassistentform.lauflichtarray[i][j].g;
                end else
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=0;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[k]:=lauflichtassistentform.lauflichtarray[i][j].delay;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[k]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;
              end;
              if ('b'=lowercase(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].kanaltyp[k])) then
              begin
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[k]:=true;
                if lauflichtassistentform.lauflichtarray[i][j].enabled then
                begin
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=lauflichtassistentform.lauflichtarray[i][j].b;
                end else
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=0;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[k]:=lauflichtassistentform.lauflichtarray[i][j].delay;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[k]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;
              end;
              if ('a'=lowercase(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].kanaltyp[k])) then
              begin
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[k]:=true;
                if lauflichtassistentform.lauflichtarray[i][j].enabled then
                begin
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=lauflichtassistentform.lauflichtarray[i][j].a;
                end else
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=0;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[k]:=lauflichtassistentform.lauflichtarray[i][j].delay;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[k]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;
              end;
              if ('w'=lowercase(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].kanaltyp[k])) then
              begin
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[k]:=true;
                if lauflichtassistentform.lauflichtarray[i][j].enabled then
                begin
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=lauflichtassistentform.lauflichtarray[i][j].w;
                end else
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=0;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[k]:=lauflichtassistentform.lauflichtarray[i][j].delay;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[k]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;
              end;
            end;
          end else
          begin
            // Standardkanal eintragen
            for k:=0 to length(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive)-1 do
            begin
              // Alle Gerätekanäle abklappern
              if (lowercase(mainform.DeviceChannelNames[lauflichtassistentform.lauflichtarray[i][j].channel])=lowercase(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[j])].kanaltyp[k])) then
              begin
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanActive[k]:=true;
                if lauflichtassistentform.lauflichtarray[i][j].enabled then
                begin
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=lauflichtassistentform.lauflichtarray[i][j].intensity;
                end else
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanValue[k]:=0;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanDelay[k]:=lauflichtassistentform.lauflichtarray[i][j].delay;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[j].ChanFadetime[k]:=lauflichtassistentform.lauflichtarray[i][j].fadetime;
                break;
              end;
            end;
          end;
        end;
      end;
      setlength(VSTEffektNodes[Data^.EffektnummerInTree],length(VSTEffektNodes[Data^.EffektnummerInTree])+1);
      VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]:=VST.AddChild(VSTRootNodes[Data^.EffektnummerInTree]);
      DataNew:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]);
      DataNew^.NodeType:=1;
      DataNew^.Caption:=mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Name;
      DataNew^.Beschreibung:=mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Beschreibung;
      DataNew^.Effektnummer:=Data^.Effektnummer;
      DataNew^.Position:=length(VSTEffektNodes[Data^.EffektnummerInTree])-1;
      DataNew^.ID:=Data^.ID;
    end;

    VST.Selected[VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]]:=true;
    checkbuttons;
    VSTChange(vst, VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]);
  end;
end;

procedure Teffektsequenzer.Eigenschaftenausblenden1Click(Sender: TObject);
begin
  panel1.Visible:=not Eigenschaftenausblenden1.Checked;
  if panel2.height=0 then
    panel2.Height:=241
  else
    panel2.Height:=0;

  TabControl1.Top:=0;
end;

procedure Teffektsequenzer.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PTreeData;
  i:integer;
begin
  with TargetCanvas do
  case Column of
    0:
    begin
      Data:=VST.GetNodeData(Node);

      if Data^.NodeType=0 then
      begin
        // Effekt
        for i:=0 to length(mainform.effektsequenzereffekte)-1 do
        if IsEqualGUID(Data^.ID, mainform.effektsequenzereffekte[i].ID) then
        begin
          if mainform.AktuellerEffekt[i].Aktiv then
          begin
            Font.Style:=[fsBold];
            Font.Color:=clGreen;
          end else
          begin
            Font.Style:=[];
            Font.Color:=clBlack;
          end;
          break;
        end;
      end else
      begin
        // Effektitem
        for i:=0 to length(mainform.effektsequenzereffekte)-1 do
        if IsEqualGUID(Data^.ID, mainform.effektsequenzereffekte[i].ID) then
        begin
          if (mainform.AktuellerEffekt[i].AktuellerSchritt=Data^.Position) then
          begin
            Font.Style:=[fsBold];
            Font.Color:=clBlack;
          end else
          begin
            Font.Style:=[];
            Font.Color:=clBlack;
          end;
        end;
      end;
    end;
  end;
end;

procedure Teffektsequenzer.VSTGetText(Sender: TBaseVirtualTree;
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
      // Blendzeit anzeigen
      CellText:='';
      Data:=VST.GetNodeData(Node);
      if Data^.NodeType=1 then
      begin
        for i:=0 to length(mainform.effektsequenzereffekte)-1 do
        if IsEqualGUID(mainform.effektsequenzereffekte[i].ID, Data^.ID) then
        begin
          CellText:=mainform.MillisecondsToTimeShort(mainform.effektsequenzereffekte[i].Effektschritte[Data^.Position].einblendzeit);
          break;
        end;
      end;
    end;
    2:
    begin
      // Wartezeit anzeigen
      CellText:='';
      Data:=VST.GetNodeData(Node);
      if Data^.NodeType=1 then
      begin
        for i:=0 to length(mainform.effektsequenzereffekte)-1 do
        if IsEqualGUID(mainform.effektsequenzereffekte[i].ID, Data^.ID) then
        begin
          CellText:=mainform.MillisecondsToTimeShort(mainform.effektsequenzereffekte[i].Effektschritte[Data^.Position].wartezeit);
          break;
        end;
      end;
    end;
  end;
end;

procedure Teffektsequenzer.VSTGetImageIndex(Sender: TBaseVirtualTree;
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
          0: ImageIndex:=20;
          1: ImageIndex:=100;
        end;
      end;
    end;
  end;
end;

procedure Teffektsequenzer.VSTClick(Sender: TObject);
begin
  checkbuttons;
end;

procedure Teffektsequenzer.VSTChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PTreeData;
  t,h,min,s,ms,i:integer;
begin
  if (not (Sender=vst)) or (VST.SelectedCount=0) then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if not Assigned(Data) then exit;
  
  if Data^.NodeType=1 then
  begin
    edit1.Text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Name;
    edit2.Text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Beschreibung;
    Combobox1.ItemIndex:=mainform.Effektsequenzereffekte[Data^.Effektnummer].modus;
    edit7.Text:=inttostr(mainform.Effektsequenzereffekte[Data^.Effektnummer].AnzahlderDurchlaufe);

    case mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Typ of
      0: Combobox2.itemindex:=1;
      1: Combobox2.itemindex:=2;
      2: Combobox2.itemindex:=3;
      3: Combobox2.itemindex:=0;
    end;

    Checkbox2.Checked:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].ActivateTimecontrol;
    CheckBox3.Checked:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].DeactivateLastScene;

    effekttotab.Clear;
    for i:=0 to length(mainform.EffektsequenzerTabs)-1 do
      effekttotab.Items.Add(mainform.EffektsequenzerTabs[i]);
    effekttotab.ItemIndex:=mainform.Effektsequenzereffekte[Data^.Effektnummer].TabPosition;

    intensity.Position:=mainform.Effektsequenzereffekte[Data^.Effektnummer].intensitaet;
    speed.Position:=mainform.Effektsequenzereffekte[Data^.Effektnummer].speed;
    checkbox1.Checked:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Repeating;
    checkbox4.Checked:=mainform.Effektsequenzereffekte[Data^.Effektnummer].startwithstepone;
    checkbox5.Checked:=mainform.Effektsequenzereffekte[Data^.Effektnummer].blackoutonstop;
    label19.Caption:=mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene, 'type')+': '+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene, 'name')+' ('+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene, 'desc')+')';
    label17.Caption:=mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene, 'type')+': '+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene, 'name')+' ('+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene, 'desc')+')';

    edit5.Text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Name;
    edit6.Text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Beschreibung;
    edit3.Text:=inttostr(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].AnzahlBeats);

    t:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Einblendzeit;
    h:=t div 3600000; t:=t mod 3600000;
    min:=t div 60000; t:=t mod 60000;
    s:=t div 1000;
    ms:=t mod 1000;
    einblendzeit_h.Text:=inttostr(h);
    einblendzeit_min.Text:=inttostr(min);
    einblendzeit_s.Text:=inttostr(s);
    einblendzeit_ms.Text:=inttostr(ms);

    t:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[Data^.Position].Wartezeit;
    h:=t div 3600000; t:=t mod 3600000;
    min:=t div 60000; t:=t mod 60000;
    s:=t div 1000;
    ms:=t mod 1000;
    wartezeit_h.Text:=inttostr(h);
    wartezeit_min.Text:=inttostr(min);
    wartezeit_s.Text:=inttostr(s);
    wartezeit_ms.Text:=inttostr(ms);

    if (length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)>1) and (Data^.Position>0) then
      movestepupbtn.Enabled:=true
    else
      movestepupbtn.Enabled:=false;

    if (length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)>1) and (Data^.Position<length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1) then
      movestepdownbtn.Enabled:=true
    else
      movestepdownbtn.Enabled:=false;

    if Data^.Position<length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte) then
      deletestepbtn.Enabled:=true
    else
      deletestepbtn.Enabled:=false;

    Combobox2.enabled:=true;
    EditBtn.Enabled:=true;
    CopyBtn.Enabled:=true;

    button8.Enabled:=true;
    button9.enabled:=true;
    Checkbox2.enabled:=true;
    Checkbox3.enabled:=true;

    Edit5.Enabled:=true;
    Edit6.Enabled:=true;
    Edit3.Enabled:=true;

    deleteeffectbtn.Enabled:=true;
    duplicateeffect.Enabled:=true;
    editstartscenebtn.Enabled:=true;
    removestartscenebtn.Enabled:=true;
    editstopscenebtn.Enabled:=true;
    removestopscenebtn.Enabled:=true;
    moveeffectupbtn.Enabled:=true;
    moveeffectdownbtn.Enabled:=true;

    einblendzeit_h.Enabled:=(combobox2.itemindex=1) and combobox2.enabled;
    wartezeit_h.Enabled:=checkbox2.Checked and checkbox2.Enabled;
    einblendzeit_min.Enabled:=einblendzeit_h.Enabled;
    einblendzeit_s.Enabled:=einblendzeit_h.Enabled;
    einblendzeit_ms.Enabled:=einblendzeit_h.Enabled;
    wartezeit_min.Enabled:=wartezeit_h.Enabled;
    wartezeit_s.Enabled:=wartezeit_h.Enabled;
    wartezeit_ms.Enabled:=wartezeit_h.Enabled;
  end else if (Data^.NodeType=0) then // wenn Toplevel
  begin
    edit1.Text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Name;
    edit2.Text:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Beschreibung;
    Combobox1.ItemIndex:=mainform.Effektsequenzereffekte[Data^.Effektnummer].modus;
    edit7.Text:=inttostr(mainform.Effektsequenzereffekte[Data^.Effektnummer].AnzahlderDurchlaufe);
    intensity.Position:=mainform.Effektsequenzereffekte[Data^.Effektnummer].intensitaet;
    speed.Position:=mainform.Effektsequenzereffekte[Data^.Effektnummer].speed;
    checkbox1.Checked:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Repeating;
    checkbox4.Checked:=mainform.Effektsequenzereffekte[Data^.Effektnummer].startwithstepone;
    checkbox5.Checked:=mainform.Effektsequenzereffekte[Data^.Effektnummer].blackoutonstop;
    label19.Caption:=mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene, 'type')+': '+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene, 'name')+' ('+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene, 'desc')+')';
    label17.Caption:=mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene, 'type')+': '+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene, 'name')+' ('+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene, 'desc')+')';

    effekttotab.Clear;
    for i:=0 to length(mainform.EffektsequenzerTabs)-1 do
      effekttotab.Items.Add(mainform.EffektsequenzerTabs[i]);
    effekttotab.ItemIndex:=mainform.Effektsequenzereffekte[Data^.Effektnummer].TabPosition;

    Combobox2.enabled:=false;
    EditBtn.Enabled:=false;
    CopyBtn.Enabled:=false;
    DeleteStepBtn.Enabled:=false;

    einblendzeit_h.Enabled:=false;
    einblendzeit_min.Enabled:=false;
    einblendzeit_s.Enabled:=false;
    einblendzeit_ms.Enabled:=false;
    wartezeit_h.Enabled:=false;
    wartezeit_min.Enabled:=false;
    wartezeit_s.Enabled:=false;
    wartezeit_ms.Enabled:=false;
    button8.Enabled:=false;
    button9.enabled:=false;
    Checkbox2.enabled:=false;
    Checkbox3.enabled:=false;

    Edit5.Enabled:=false;
    Edit6.Enabled:=false;
    Edit3.Enabled:=false;

    movestepupbtn.Enabled:=false;
    movestepdownbtn.Enabled:=false;
    deletestepbtn.Enabled:=false;
    deleteeffectbtn.Enabled:=true;
    duplicateeffect.Enabled:=true;
    editstartscenebtn.Enabled:=true;
    removestartscenebtn.Enabled:=true;
    editstopscenebtn.Enabled:=true;
    removestopscenebtn.Enabled:=true;
    moveeffectupbtn.Enabled:=true;
    moveeffectdownbtn.Enabled:=true;
  end else
  begin
    deleteeffectbtn.Enabled:=false;
    duplicateeffect.Enabled:=false;
    editstartscenebtn.Enabled:=false;
    removestartscenebtn.Enabled:=false;
    editstopscenebtn.Enabled:=false;
    removestopscenebtn.Enabled:=false;
    moveeffectupbtn.Enabled:=false;
    moveeffectdownbtn.Enabled:=false;
  end;

  checkbuttons;
end;

procedure Teffektsequenzer.NeuesTabhinzufgen1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  setlength(mainform.EffektsequenzerTabs, length(mainform.EffektsequenzerTabs)+1);
  mainform.EffektsequenzerTabs[length(mainform.EffektsequenzerTabs)-1]:=InputBox(_('Tab bezeichnen...'),_('Bitte geben Sie eine Bezeichnung für das neue Tab ein:'),_('Neuer Tab'));
  TabControl1.Tabs.Add(mainform.EffektsequenzerTabs[length(mainform.EffektsequenzerTabs)-1]);
  effekttotab.Items.Add(mainform.EffektsequenzerTabs[length(mainform.EffektsequenzerTabs)-1]);
end;

procedure Teffektsequenzer.abumbennen1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if TabControl1.Tabindex=0 then exit;

  mainform.EffektsequenzerTabs[TabControl1.TabIndex]:=InputBox(_('Tab bezeichnen...'),_('Bitte geben Sie eine Bezeichnung für das gewählte Tab ein:'),mainform.EffektsequenzerTabs[TabControl1.TabIndex]);
  effekttotab.Items.Strings[TabControl1.TabIndex]:=mainform.EffektsequenzerTabs[TabControl1.TabIndex];
  TabControl1.Tabs.Strings[TabControl1.TabIndex]:=mainform.EffektsequenzerTabs[TabControl1.TabIndex];

  pngbitbtn5.Enabled:=(length(mainform.EffektsequenzerTabs)>1) and (TabControl1.Tabindex>0);
  pngbitbtn6.Enabled:=(length(mainform.EffektsequenzerTabs)>1) and (TabControl1.Tabindex>0);
end;

procedure Teffektsequenzer.ablschen1Click(Sender: TObject);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if TabControl1.Tabindex=0 then exit;
  
  for i:=TabControl1.Tabindex to length(mainform.EffektsequenzerTabs)-2 do
    mainform.EffektsequenzerTabs[i]:=mainform.EffektsequenzerTabs[i+1];

  TabControl1.Tabs.Delete(TabControl1.Tabindex);
  effekttotab.Items.Delete(TabControl1.Tabindex);

  setlength(mainform.EffektsequenzerTabs, length(mainform.EffektsequenzerTabs)-1);

  pngbitbtn5.Enabled:=(length(mainform.EffektsequenzerTabs)>1) and (TabControl1.Tabindex>0);
  pngbitbtn6.Enabled:=(length(mainform.EffektsequenzerTabs)>1) and (TabControl1.Tabindex>0);
end;

procedure Teffektsequenzer.TabControl1Change(Sender: TObject);
begin
  pngbitbtn5.Enabled:=TabControl1.TabIndex>0;
  pngbitbtn6.Enabled:=TabControl1.TabIndex>0;
  abumbennen1.enabled:=TabControl1.TabIndex>0;
  ablschen1.enabled:=TabControl1.TabIndex>0;
  RefreshTreeView;
end;

procedure Teffektsequenzer.VSTCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1: PTreeData;
  Data2: PTreeData;
begin
  Data1:=vst.GetNodeData(Node1);
  Data2:=vst.GetNodeData(Node2);
  
  if (not Assigned(Data1)) or (not Assigned(Data2)) then
    Result:=0
  else
    Result:=CompareText(Data1.Caption, Data2.Caption);
end;

procedure Teffektsequenzer.CheckBox5MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=1 then
  begin
    Data:=VST.GetNodeData(VST.FocusedNode);
    mainform.Effektsequenzereffekte[Data^.Effektnummer].blackoutonstop:=CheckBox5.Checked;
  end else
  begin
    for i:=0 to length(VSTEffektNodes)-1 do
    for j:=0 to length(VSTEffektNodes[i])-1 do
    if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
    begin
      Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].blackoutonstop:=CheckBox5.Checked;
    end;
  end;
end;

procedure Teffektsequenzer.matrixbtnClick(Sender: TObject);
var
  Data: PTreeData;
  i,j,k,l,devicecounter:integer;
  effectnodeindex:integer;
  DataNew:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);
  effectnodeindex:=Data^.Effektnummer;
  if effectnodeindex=-1 then exit;

  matrixeditorform.showmodal;

  if matrixeditorform.ModalResult=mrOk then
  begin
    mainform.AktuellerEffekt[effectnodeindex].Aktiv:=false;

    for i:=0 to length(matrixeditorform.matrixarray)-1 do
    begin
      setlength(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte,length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)+1);
      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Name:=_('Neuer Matrixschritt')+' ('+inttostr(i)+')';
      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].wartezeit:=round((100-matrixeditorform.trackbar2.Position)/100*2000);
      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].DeactivateLastScene:=true;

      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Typ:=0;
      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].ActivateTimecontrol:=true;
      mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].einblendzeit:=strtoint(matrixeditorform.hedit.text)*3600000+strtoint(matrixeditorform.minedit.text)*60000+strtoint(matrixeditorform.sedit.text)*1000+strtoint(matrixeditorform.msedit.text);

      setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices, length(matrixeditorform.matrixarray[i])*length(matrixeditorform.matrixarray[i][0]));
      devicecounter:=-1;

      for j:=0 to length(matrixeditorform.matrixarray[i])-1 do
      for l:=0 to length(matrixeditorform.matrixarray[i][j])-1 do
      begin
        devicecounter:=devicecounter+1;
        mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ID:=matrixeditorform.matrixarray[0][j][l].device;

        if geraetesteuerung.GetGroupPositionInGroupArray(matrixeditorform.matrixarray[0][j][l].device)>-1 then
        begin
          // Gruppe
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive, length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue, length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActiveRandom, length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValueRandom, length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanDelay, length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanFadetime, length(mainform.DeviceChannelNames));

          if (matrixeditorform.matrixarray[i][j][l].useonlyrgb) then
          begin
            // R-Kanal eintragen
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive[14]:=true;
            if matrixeditorform.matrixarray[i][j][l].enabled then
            begin
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[14]:=matrixeditorform.matrixarray[i][j][l].r;
            end else
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[14]:=0;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanDelay[14]:=matrixeditorform.matrixarray[i][j][l].delay;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanFadetime[14]:=matrixeditorform.matrixarray[i][j][l].fadetime;

            // G-Kanal eintragen
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive[15]:=true;
            if matrixeditorform.matrixarray[i][j][l].enabled then
            begin
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[15]:=matrixeditorform.matrixarray[i][j][l].g;
            end else
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[15]:=0;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanDelay[15]:=matrixeditorform.matrixarray[i][j][l].delay;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanFadetime[15]:=matrixeditorform.matrixarray[i][j][l].fadetime;

            // B-Kanal eintragen
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive[16]:=true;
            if matrixeditorform.matrixarray[i][j][l].enabled then
            begin
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[16]:=matrixeditorform.matrixarray[i][j][l].b;
            end else
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[16]:=0;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanDelay[16]:=matrixeditorform.matrixarray[i][j][l].delay;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanFadetime[16]:=matrixeditorform.matrixarray[i][j][l].fadetime;
          end else
          begin
            // Standardkanal eintragen
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive[matrixeditorform.matrixarray[i][j][l].channel]:=true;
            if matrixeditorform.matrixarray[i][j][l].enabled then
            begin
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[matrixeditorform.matrixarray[i][j][l].channel]:=matrixeditorform.matrixarray[i][j][l].intensity;
            end else
              mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[matrixeditorform.matrixarray[i][j][l].channel]:=0;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanDelay[matrixeditorform.matrixarray[i][j][l].channel]:=matrixeditorform.matrixarray[i][j][l].delay;
            mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanFadetime[matrixeditorform.matrixarray[i][j][l].channel]:=matrixeditorform.matrixarray[i][j][l].fadetime;
          end;
        end else if geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)>-1 then
        begin
          // Gerät
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)].MaxChan);
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)].MaxChan);
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActiveRandom, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)].MaxChan);
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValueRandom, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)].MaxChan);
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanDelay, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)].MaxChan);
          setlength(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanFadetime, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)].MaxChan);

          if (matrixeditorform.matrixarray[i][j][l].useonlyrgb) then
          begin
            // RGB-Kanäle eintragen
            for k:=0 to length(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive)-1 do
            begin
              // Alle Gerätekanäle abklappern
              if ('r'=lowercase(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)].kanaltyp[k])) then
              begin
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive[k]:=true;
                if matrixeditorform.matrixarray[i][j][l].enabled then
                begin
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[k]:=matrixeditorform.matrixarray[i][j][l].r;
                end else
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[k]:=0;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanDelay[k]:=matrixeditorform.matrixarray[i][j][l].delay;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanFadetime[k]:=matrixeditorform.matrixarray[i][j][l].fadetime;
              end;
              if ('g'=lowercase(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)].kanaltyp[k])) then
              begin
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive[k]:=true;
                if matrixeditorform.matrixarray[i][j][l].enabled then
                begin
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[k]:=matrixeditorform.matrixarray[i][j][l].g;
                end else
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[k]:=0;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanDelay[k]:=matrixeditorform.matrixarray[i][j][l].delay;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanFadetime[k]:=matrixeditorform.matrixarray[i][j][l].fadetime;
              end;
              if ('b'=lowercase(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)].kanaltyp[k])) then
              begin
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive[k]:=true;
                if matrixeditorform.matrixarray[i][j][l].enabled then
                begin
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[k]:=matrixeditorform.matrixarray[i][j][l].b;
                end else
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[k]:=0;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanDelay[k]:=matrixeditorform.matrixarray[i][j][l].delay;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanFadetime[k]:=matrixeditorform.matrixarray[i][j][l].fadetime;
              end;
            end;
          end else
          begin
            // Standardkanal eintragen
            for k:=0 to length(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive)-1 do
            begin
              // Alle Gerätekanäle abklappern
              if (lowercase(mainform.DeviceChannelNames[matrixeditorform.matrixarray[i][j][l].channel])=lowercase(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixeditorform.matrixarray[0][j][l].device)].kanaltyp[k])) then
              begin
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanActive[k]:=true;
                if matrixeditorform.matrixarray[i][j][l].enabled then
                begin
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[k]:=matrixeditorform.matrixarray[i][j][l].intensity;
                end else
                  mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanValue[k]:=0;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanDelay[k]:=matrixeditorform.matrixarray[0][j][l].delay;
                mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Devices[devicecounter].ChanFadetime[k]:=matrixeditorform.matrixarray[i][j][l].fadetime;
                break;
              end;
            end;
          end;
        end;
      end;
      setlength(VSTEffektNodes[Data^.EffektnummerInTree],length(VSTEffektNodes[Data^.EffektnummerInTree])+1);
      VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]:=VST.AddChild(VSTRootNodes[Data^.EffektnummerInTree]);
      DataNew:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]);
      DataNew^.NodeType:=1;
      DataNew^.Caption:=mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Name;
      DataNew^.Beschreibung:=mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte[length(mainform.Effektsequenzereffekte[effectnodeindex].Effektschritte)-1].Beschreibung;
      DataNew^.Effektnummer:=Data^.Effektnummer;
      DataNew^.Position:=length(VSTEffektNodes[Data^.EffektnummerInTree])-1;
      DataNew^.ID:=Data^.ID;
    end;

    VST.Selected[VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]]:=true;
    checkbuttons;
    VSTChange(vst, VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]);
  end;
end;

procedure Teffektsequenzer.effekttotabSelect(Sender: TObject);
var
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if Sender=effekttotab then
  begin
    if VST.SelectedCount=1 then
    begin
      Data:=VST.GetNodeData(VST.FocusedNode);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].TabPosition:=effekttotab.ItemIndex;
    end else
    begin
      TempNode:=VST.GetFirst;
      while Assigned(TempNode) do
      begin
        if VST.Selected[TempNode] then
        begin
          Data:=VST.GetNodeData(TempNode);
          if (Data^.Effektnummer<length(mainform.Effektsequenzereffekte)) and (Data^.Effektnummer>-1) then
            mainform.Effektsequenzereffekte[Data^.Effektnummer].TabPosition:=effekttotab.ItemIndex;
        end;

        TempNode:=VST.GetNext(TempNode);
      end;
    end;
  end;
  RefreshTreeView;
end;

procedure Teffektsequenzer.ComboBox1Select(Sender: TObject);
var
  Data: PTreeData;
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if Sender=Combobox1 then
  begin
    if VST.SelectedCount=1 then
    begin
      Data:=VST.GetNodeData(VST.FocusedNode);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].modus:=Combobox1.ItemIndex;
    end else
    begin
      for i:=0 to length(VSTEffektNodes)-1 do
      for j:=0 to length(VSTEffektNodes[i])-1 do
      if VST.Selected[VSTEffektNodes[i][j]] or VST.Selected[VSTEffektNodes[i][j].Parent] then
      begin
        Data:=VST.GetNodeData(VSTEffektNodes[i][j]);
        mainform.Effektsequenzereffekte[Data^.Effektnummer].modus:=Combobox1.ItemIndex;
      end;
    end;
{
    if VST.SelectedCount=0 then exit;
    Data:=VST.GetNodeData(VST.FocusedNode);

    mainform.Effektsequenzereffekte[Data^.Effektnummer].modus:=Combobox1.ItemIndex;
}
  end;
end;

procedure Teffektsequenzer.editstopscenebtnClick(Sender: TObject);
var
  Data: PTreeData;
  SzenenData:PTreeData2;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if Assigned(Data) then
  begin
    // Szene aus Verwaltung editieren
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].multiselect:=false;

    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].positionselection:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene;

    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
    begin
      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
      SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

      mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene:=SzenenData^.ID;
      label17.Caption:=mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene, 'type')+': '+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene, 'name')+' ('+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene, 'desc')+')';

      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
      VST.Refresh;
    end;
  end;
end;

procedure Teffektsequenzer.removestopscenebtnClick(Sender: TObject);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if Assigned(Data) then
  begin
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Stopscene:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    label17.Caption:='...';
  end;
end;

procedure Teffektsequenzer.editstartscenebtnClick(Sender: TObject);
var
  Data: PTreeData;
  SzenenData:PTreeData2;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if Assigned(Data) then
  begin
    // Szene aus Verwaltung editieren
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].multiselect:=false;

    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].positionselection:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene;

    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
    begin
      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
      SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

      mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene:=SzenenData^.ID;
      label19.Caption:=mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene, 'type')+': '+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene, 'name')+' ('+mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene, 'desc')+')';

      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
      VST.Refresh;
    end;
  end;
end;

procedure Teffektsequenzer.removestartscenebtnClick(Sender: TObject);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if VST.SelectedCount=0 then exit;
  if not Assigned(VST.FocusedNode) then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if Assigned(Data) then
  begin
    mainform.Effektsequenzereffekte[Data^.Effektnummer].Startscene:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    label19.Caption:='...';
  end;
end;

procedure Teffektsequenzer.PngBitBtn3Click(Sender: TObject);
var
  Data: PTreeData;
  DataNew:PTreeData;
  i,k,m, myPosition, OriginalDevice:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  // Wizard-Fenster erstellen und anzeigen
//  Application.CreateForm(Taddcolorandgobotoeffectform, addcolorandgobotoeffectform);
  addcolorandgobotoeffectform:=Taddcolorandgobotoeffectform.Create(self);
  addcolorandgobotoeffectform.ShowModal;

  if addcolorandgobotoeffectform.ModalResult=mrOK then
  begin
    // neuen Effekt hinzufügen
    setlength(mainform.effektsequenzereffekte,length(mainform.effektsequenzereffekte)+1);
    setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte,0);
    setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)+1);
    mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Name:=uppercase(addcolorandgobotoeffectform.Kanaltyp)+' '+_('von')+' '+addcolorandgobotoeffectform.ListBox1.Items[addcolorandgobotoeffectform.ListBox1.itemindex];
    mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Beschreibung:=_('Effekt aus DDF-Eigenschaften erstellt');
    mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].AnzahlderDurchlaufe:=-1;
    mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Repeating:=true;
    mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].speed:=128;
    mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].intensitaet:=255;
    mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].TabPosition:=TabControl1.TabIndex;
    CreateGUID(mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].ID);

    setlength(VSTRootNodes, length(VSTRootNodes)+1);
    setlength(VSTEffektNodes, length(VSTEffektNodes)+1);
    VSTRootNodes[length(VSTRootNodes)-1]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[length(VSTRootNodes)-1]);
    Data^.NodeType:=0;
    Data^.Caption:=mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Name;
    Data^.Beschreibung:=mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Beschreibung;
    Data^.Effektnummer:=length(mainform.effektsequenzereffekte)-1;
    Data^.EffektnummerInTree:=length(VSTRootNodes)-1;
    Data^.Position:=length(mainform.effektsequenzereffekte)-1;
    Data^.ID:=mainform.Effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].ID;

    // neue Effektschritte hinzufügen
    for m:=0 to addcolorandgobotoeffectform.ListBox3.Items.Count-1 do
    if addcolorandgobotoeffectform.ListBox3.Selected[m] then
    begin
      // neuen Effektschritt hinzufügen und als Direktszene mit Werten füllen
      setlength(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte,length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)+1);
      mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].Name:=addcolorandgobotoeffectform.ListBox3.Items[m];
      mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].Beschreibung:=_('Aus DDF-Werten erstellt');
      mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].wartezeit:=1000;
      mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].DeactivateLastScene:=false;

      setlength(VSTEffektNodes[Data^.EffektnummerInTree], length(VSTEffektNodes[Data^.EffektnummerInTree])+1);
      VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]:=VST.AddChild(VSTRootNodes[Data^.EffektnummerInTree]);
      DataNew:=VST.GetNodeData(VSTEffektNodes[Data^.EffektnummerInTree][length(VSTEffektNodes[Data^.EffektnummerInTree])-1]);
      DataNew^.NodeType:=1;
      DataNew^.Caption:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].Name;
      DataNew^.Beschreibung:=mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1].Beschreibung;
      DataNew^.Effektnummer:=Data^.Effektnummer;
      DataNew^.EffektnummerInTree:=Data^.EffektnummerInTree;
      DataNew^.Position:=length(mainform.effektsequenzereffekte[Data^.Effektnummer].Effektschritte)-1;
      DataNew^.ID:=mainform.Effektsequenzereffekte[Data^.Effektnummer].ID;

      mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Typ:=0; // Direktszene
      mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].einblendzeit:=0;

      // Hier nun die Kanaldaten einfügen
      OriginalDevice:=geraetesteuerung.GetDevicePositionInDeviceArray(@addcolorandgobotoeffectform.DeviceListForExport[0]);
      setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices, length(addcolorandgobotoeffectform.DeviceListForExport));
      for i:=0 to length(addcolorandgobotoeffectform.DeviceListForExport)-1 do
      begin
        mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ID:=addcolorandgobotoeffectform.DeviceListForExport[i];

        myPosition:=geraetesteuerung.GetDevicePositionInDeviceArray(@addcolorandgobotoeffectform.DeviceListForExport[i]);
        if myPosition>-1 then
        begin
          // Ist ein Gerät
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive,length(mainform.Devices[myPosition].kanaltyp));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue,length(mainform.Devices[myPosition].kanaltyp));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActiveRandom,length(mainform.Devices[myPosition].kanaltyp));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValueRandom,length(mainform.Devices[myPosition].kanaltyp));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanDelay,length(mainform.Devices[myPosition].kanaltyp));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanFadetime,length(mainform.Devices[myPosition].kanaltyp));
          for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive)-1 do
          begin
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive[k]:=false;
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue[k]:=0;
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActiveRandom[k]:=false;
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValueRandom[k]:=false;
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanDelay[k]:=0;
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanFadetime[k]:=0;
          end;
          for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive)-1 do
          begin
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive[k]:=(lowercase(mainform.Devices[myPosition].kanaltyp[k])=lowercase(addcolorandgobotoeffectform.Kanaltyp));
            if mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive[k] then
            begin
              if lowercase(addcolorandgobotoeffectform.Kanaltyp)='gobo1' then
                mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue[k]:=mainform.devices[myPosition].gobolevels[m]
              else if lowercase(addcolorandgobotoeffectform.Kanaltyp)='gobo2' then
                mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue[k]:=mainform.devices[myPosition].gobolevels2[m]
              else if lowercase(addcolorandgobotoeffectform.Kanaltyp)='color1' then
                mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue[k]:=mainform.devices[myPosition].colorlevels[m]
              else if lowercase(addcolorandgobotoeffectform.Kanaltyp)='color2' then
                mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue[k]:=mainform.devices[myPosition].colorlevels2[m];
            end;
          end;
        end else
        begin
          // Ist eine Gruppe
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive,length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue,length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActiveRandom,length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValueRandom,length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanDelay,length(mainform.DeviceChannelNames));
          setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanFadetime,length(mainform.DeviceChannelNames));
          for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive)-1 do
          begin
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive[k]:=false;
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue[k]:=0;
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActiveRandom[k]:=false;
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValueRandom[k]:=false;
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanDelay[k]:=0;
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanFadetime[k]:=0;
          end;
          for k:=0 to length(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive)-1 do
          begin
            mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive[k]:=(lowercase(mainform.DeviceChannelNames[k])=lowercase(addcolorandgobotoeffectform.Kanaltyp));
            if mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanActive[k] then
            begin
              if lowercase(addcolorandgobotoeffectform.Kanaltyp)='gobo1' then
                mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue[k]:=mainform.devices[OriginalDevice].gobolevels[m]
              else if lowercase(addcolorandgobotoeffectform.Kanaltyp)='gobo2' then
                mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue[k]:=mainform.devices[OriginalDevice].gobolevels2[m]
              else if lowercase(addcolorandgobotoeffectform.Kanaltyp)='color1' then
                mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue[k]:=mainform.devices[OriginalDevice].colorlevels[m]
              else if lowercase(addcolorandgobotoeffectform.Kanaltyp)='color2' then
                mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Devices[i].ChanValue[k]:=mainform.devices[OriginalDevice].colorlevels2[m];
            end;
          end;
        end;
      end;

      // Wir brauchen hier keine Befehle - also auf 0 setzen
      setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Befehle, 0);
      setlength(mainform.Effektsequenzereffekte[Data^.Effektnummer].Effektschritte[DataNew^.Position].Befehlswerte, 0);
    end;
  end;

  // noch die Form kaputt machen
  addcolorandgobotoeffectform.Free;
end;

procedure Teffektsequenzer.VSTMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Shift=[ssLeft]) and (Button = mbLeft) then
  begin
    VST.BeginDrag(False);
  end else if (Shift=[ssLeft, ssDouble]) and EditBtn.Enabled then
    EditBtn.Click;
end;

procedure Teffektsequenzer.VSTEndDrag(Sender, Target: TObject; X,
  Y: Integer);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if (VST.SelectedCount=0) then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if (Target=audioeffektplayerform.waveform) and (VST.SelectedCount>0) then
  begin
    // Call add-scene function within the audioeffectplayer

    if (Assigned(Data) and (audioeffektplayerform.mouseoverlayer>0)) then
    begin
      if Data^.NodeType=1 then
      begin
        audioeffektplayerform.RecordAudioeffekt(Data^.ID, false, audioeffektplayerform.mouseoverlayer, true);
      end else
      begin
        audioeffektplayerform.RecordAudioeffekt(Data^.ID, false, audioeffektplayerform.mouseoverlayer, true);
      end;
    end;
    audioeffektplayerform._mousedwn:=0;
  end;
end;

end.
