unit szenenverwaltung;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, Buttons, ExtCtrls, PngBitBtn, Registry,
  gnugettext, pngimage, JvExControls, JvGradient, Mask, JvExMask, JvSpin,
  VirtualTrees, messagesystem;

const
  maxaudioeffektlayers = 8;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: integer; // 0 Einfache Szenen, 1 Geräteszenen, 2 Audioszenen, 3 Bewegungsszenen, 4 Befehle, 5 Kombinationsszenen, 6 Presets, 7 Automatikszenen, 8 Effekt, 9 MediaCenter Szenen, 10 PresetSzenen, 11 Code-Szenen, 12 PluginSzene
    IsRootNode:boolean;
    IsCatNode:boolean;
    Caption:WideString;
    Beschreibung:WideString;
    Fadetime:WideString;
    ID:TGUID;
  end;

  Tszenenverwaltungform = class(TForm)
    PopupMenu1: TPopupMenu;
    EinfacheSzene1: TMenuItem;
    Audioszene1: TMenuItem;
    Bewegungsszene1: TMenuItem;
    Befehle1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Kompositionsszene1: TMenuItem;
    N1: TMenuItem;
    Hinzufgen1: TMenuItem;
    Preset1: TMenuItem;
    Gerteszene1: TMenuItem;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Panel2: TPanel;
    AddBtn: TPngBitBtn;
    EditBtn: TPngBitBtn;
    Button5: TPngBitBtn;
    DeleteBtn: TPngBitBtn;
    RefreshSzenenverwaltungBtn: TPngBitBtn;
    SpeedButton4: TPngBitBtn;
    SpeedButton5: TPngBitBtn;
    Bevel1: TBevel;
    Edit1: TEdit;
    Button4: TButton;
    Button3: TButton;
    Label1: TLabel;
    TreeView2: TTreeView;
    Automatikszene1: TMenuItem;
    Button6: TButton;
    Splitter1: TSplitter;
    MediaCenterSzene1: TMenuItem;
    Panel3: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    VST: TVirtualStringTree;
    CatBtn: TPngBitBtn;
    recordbtn: TPngBitBtn;
    PopupMenu2: TPopupMenu;
    AlleKanleaufnehmen1: TMenuItem;
    NurselektierteGerteaufnehmen1: TMenuItem;
    NurseitletzterSzenegenderteKanleaufnehmen1: TMenuItem;
    SelektierteGerteUNDgenderteKanleaufnehmen1: TMenuItem;
    Kanlemanuellwhlen1: TMenuItem;
    PresetSzene1: TMenuItem;
    CodeSzene1: TMenuItem;
    procedure AddBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EinfacheSzene1Click(Sender: TObject);
    procedure Audioszene1Click(Sender: TObject);
    procedure Bewegungsszene1Click(Sender: TObject);
    procedure Befehle1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Kompositionsszene1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Preset1Click(Sender: TObject);
    procedure RefreshSzenenverwaltungBtnClick(Sender: TObject);
    procedure Gerteszene1Click(Sender: TObject);
    procedure Automatikszene1Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MediaCenterSzene1Click(Sender: TObject);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure VSTNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure VSTPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure CatBtnClick(Sender: TObject);
    procedure AlleKanleaufnehmen1Click(Sender: TObject);
    procedure NurselektierteGerteaufnehmen1Click(Sender: TObject);
    procedure NurseitletzterSzenegenderteKanleaufnehmen1Click(
      Sender: TObject);
    procedure SelektierteGerteUNDgenderteKanleaufnehmen1Click(
      Sender: TObject);
    procedure recordbtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Kanlemanuellwhlen1Click(Sender: TObject);
    procedure Button6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PresetSzene1Click(Sender: TObject);
    procedure VSTEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure VSTMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CodeSzene1Click(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    NewGUID: TGUID;
    VSTRootNodes: array of PVirtualNode;
    procedure RefreshSceneDependencies;
  public
    { Public-Deklarationen }
    positionselection:TGUID;
    IsNonModal:boolean;
    Effektmodus:boolean;

    ActualEffekt:TGUID;
    multiselect:boolean;
    positionen:array of TGUID;

    function FindSceneConnections(ID:TGUID; var TreeView:TTreeView):boolean;
    procedure MSGSave;
  end;

var
  szenenverwaltung_formarray: array of Tszenenverwaltungform;

implementation

uses PCDIMMER, bewegungsszeneneditor, insscene, audioszeneeditorform,
  kompositionsszeneeditorform, geraetesteuerungfrm, preseteditorform,
  devicescenefrm, geraeteremovedfrm, autoszenefrm, effektsequenzerfrm,
  befehleditorform2, mediacenterfrm, presetsceneeditorform,
  audioeffektplayerfrm, codeeditorfrm;

{$R *.dfm}

procedure Tszenenverwaltungform.AddBtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  Popupmenu1.Popup(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Left+Panel1.Left+AddBtn.Left+x,szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Top+AddBtn.Top+Panel1.Top+AddBtn.Height+y);
end;

procedure Tszenenverwaltungform.EinfacheSzene1Click(Sender: TObject);
var
  i,t:integer;
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

//  insscenedlg:=Tinsscenedlg.Create(self);

  insscenedlg.Szenenname.Text:=_('Neue Szene');

	for i:=1 to mainform.lastchan do
	  insscenedlg.active[i]:=false;

  // Kanalnamen in Dialogfeld schreiben
  insscenedlg.StringGrid1.RowCount:=mainform.lastchan+1;
  for i:=1 to mainform.lastchan do
  begin
    insscenedlg.StringGrid1.Cells[1,i]:=inttostr(i);
    insscenedlg.StringGrid1.Cells[2,i]:=mainform.data.Names[i];
    insscenedlg.StringGrid1.Cells[3,i]:='0';
    insscenedlg.StringGrid1.Cells[4,i]:='0';
  end;

  // Fadezeit in Dialogfeld schreiben
  insscenedlg.scenefade_time_h.Text:='0';
  insscenedlg.scenefade_time_min.Text:='0';
  insscenedlg.scenefade_time.Text:='5';
  insscenedlg.scenefade_time_msec.Text:='0';

  insscenedlg.Caption:=_('Einfache Szene hinzufügen');
  insscenedlg.Szenenbeschreibung.Enabled:=true;

  if Insscenedlg.Showmodal=mrOK then
  begin
    // Array erweitern
    setlength(mainform.Einfacheszenen,length(mainform.Einfacheszenen)+1);
    CreateGUID(NewGUID);
    mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].ID:=NewGUID;
    positionselection:=mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].ID;
    mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].Name:=insscenedlg.Szenenname.text;
    mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].beschreibung:=insscenedlg.Szenenbeschreibung.Text;

    // Fadezeit in Speicher schreiben
    t:=strtoint(insscenedlg.scenefade_time_msec.Text);
    t:=t+1000*strtoint(insscenedlg.scenefade_time.Text);
    t:=t+60*1000*strtoint(insscenedlg.scenefade_time_min.Text);
    t:=t+60*60*1000*strtoint(insscenedlg.scenefade_time_h.Text);
    mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].einblendzeit:=t;

    // Fade-Endwerte in Speicher schreiben
  	for i:=1 to mainform.lastchan do
  	  mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].kanal[i]:=strtoint(insscenedlg.StringGrid1.Cells[4,i]);
    for i:=1 to mainform.lastchan do
  	  mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].kanalaktiv[i]:=insscenedlg.active[i];

    TempNode:=VST.AddChild(VSTRootNodes[0]);
    Data:=VST.GetNodeData(TempNode);
    Data^.NodeType:=0;
    Data^.IsRootNode:=false;
    Data^.IsCatNode:=false;
    Data^.Caption:=mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].Name;
    Data^.Beschreibung:=mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].Beschreibung;
    Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].ID,'time');
    Data^.ID:=mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].ID;
    VST.Expanded[TempNode]:=true;
    VST.Expanded[TempNode.Parent]:=true;
    VST.Selected[TempNode]:=true;
    VST.FocusedNode:=TempNode;

    // noch schnell die Einträge alphabetisch sortieren
    VST.Sort(VSTRootNodes[0], 0, sdAscending);
  end;
  insscenedlg.Szenenbeschreibung.Enabled:=false;
//  insscenedlg.Free;
end;

procedure Tszenenverwaltungform.Audioszene1Click(Sender: TObject);
var
  t,i:integer;
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

//  audioszeneneditor:=Taudioszeneneditor.Create(self);

  audioszeneneditor.Edit1.Text:='';
  audioszeneneditor.Edit2.Text:='';
  audioszeneneditor.Edit3.Text:='';
  audioszeneneditor.Edit4.Text:='0';
  audioszeneneditor.Edit5.Text:='0';
  audioszeneneditor.Edit6.Text:='0';
  audioszeneneditor.Edit7.Text:='0';
  audioszeneneditor.editvolume.text:='100';
  audioszeneneditor.editfadeinh.text:='0';
  audioszeneneditor.editfadeinmin.text:='0';
  audioszeneneditor.editfadeins.text:='0';
  audioszeneneditor.editfadeinms.text:='0';
  audioszeneneditor.editfadeouth.text:='0';
  audioszeneneditor.editfadeoutmin.text:='0';
  audioszeneneditor.editfadeouts.text:='0';
  audioszeneneditor.editfadeoutms.text:='0';

  for i:=0 to 7 do
  begin
    TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(i))).Value:=0;
    TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(i))).Value:=0;
    TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(i))).Value:=0;
    TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(i))).Value:=0;
    TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(i))).Value:=0;
    TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(i))).Value:=0;
    TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(i))).Value:=0;
    TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(i))).Value:=0;
  end;
  TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(0))).Value:=1;
  TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(1))).Value:=1;
  TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(2))).Value:=1;
  TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(3))).Value:=1;
  TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(4))).Value:=1;
  TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(5))).Value:=1;
  TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(6))).Value:=1;
  TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(7))).Value:=1;


//  audioszeneneditor.audio_mono.Checked:=false;

  audioszeneneditor.ShowModal;
  if audioszeneneditor.ModalResult=mrOK then
  begin
    setlength(mainform.Audioszenen,length(mainform.Audioszenen)+1);
    setlength(mainform.AudioszenenCHAN,length(mainform.AudioszenenCHAN)+1);
    CreateGUID(NewGUID);
    mainform.Audioszenen[length(mainform.Audioszenen)-1].ID:=NewGUID;
    positionselection:=mainform.Audioszenen[length(mainform.Audioszenen)-1].ID;
    mainform.Audioszenen[length(mainform.Audioszenen)-1].Name:=audioszeneneditor.Edit1.text;
    mainform.Audioszenen[length(mainform.Audioszenen)-1].Beschreibung:=audioszeneneditor.edit2.Text;
    mainform.Audioszenen[length(mainform.Audioszenen)-1].Datei:=audioszeneneditor.Edit3.Text;

    for i:=0 to 7 do
    begin
      mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[0][i]:=TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(i))).Value;
      mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[1][i]:=TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(i))).Value;
      mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[2][i]:=TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(i))).Value;
      mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[3][i]:=TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(i))).Value;
      mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[4][i]:=TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(i))).Value;
      mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[5][i]:=TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(i))).Value;
      mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[6][i]:=TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(i))).Value;
      mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[7][i]:=TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(i))).Value;
    end;

{
    if audioszeneneditor.audio_mono.Checked then
      mainform.Audioszenen[length(mainform.Audioszenen)-1].Kanalsettings[0]:=255
    else
      mainform.Audioszenen[length(mainform.Audioszenen)-1].Kanalsettings[0]:=0;
}

    t:=strtoint(audioszeneneditor.Edit7.Text);
    t:=t+strtoint(audioszeneneditor.Edit6.Text)*1000;
    t:=t+strtoint(audioszeneneditor.Edit5.Text)*60*1000;
    t:=t+strtoint(audioszeneneditor.Edit4.Text)*60*60*1000;
    mainform.Audioszenen[length(mainform.Audioszenen)-1].Dauer:=t;

    t:=strtoint(audioszeneneditor.editfadeinms.Text);
    t:=t+strtoint(audioszeneneditor.editfadeins.Text)*1000;
    t:=t+strtoint(audioszeneneditor.editfadeinmin.Text)*60*1000;
    t:=t+strtoint(audioszeneneditor.editfadeinh.Text)*60*60*1000;
    mainform.Audioszenen[length(mainform.Audioszenen)-1].fadeintime:=t;

    t:=strtoint(audioszeneneditor.editfadeoutms.Text);
    t:=t+strtoint(audioszeneneditor.editfadeouts.Text)*1000;
    t:=t+strtoint(audioszeneneditor.editfadeoutmin.Text)*60*1000;
    t:=t+strtoint(audioszeneneditor.editfadeouth.Text)*60*60*1000;
    mainform.Audioszenen[length(mainform.Audioszenen)-1].fadeouttime:=t;

    mainform.Audioszenen[length(mainform.Audioszenen)-1].Volume:=strtoint(audioszeneneditor.editVolume.text)/100;

    TempNode:=VST.AddChild(VSTRootNodes[2]);
    Data:=VST.GetNodeData(TempNode);
    Data^.NodeType:=2;
    Data^.IsRootNode:=false;
    Data^.IsCatNode:=false;
    Data^.Caption:=mainform.Audioszenen[length(mainform.Audioszenen)-1].Name;
    Data^.Beschreibung:=mainform.Audioszenen[length(mainform.Audioszenen)-1].Beschreibung;
    Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Audioszenen[length(mainform.Audioszenen)-1].ID,'time');
    Data^.ID:=mainform.Audioszenen[length(mainform.Audioszenen)-1].ID;
    VST.Expanded[TempNode]:=true;
    VST.Expanded[TempNode.Parent]:=true;
    VST.Selected[TempNode]:=true;
    VST.FocusedNode:=TempNode;

    // noch schnell die Einträge alphabetisch sortieren
    VST.Sort(VSTRootNodes[2], 0, sdAscending);
  end;
//  audioszeneneditor.free;
end;

procedure Tszenenverwaltungform.Bewegungsszene1Click(Sender: TObject);
var
  i,k,l:integer;
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

//  bewegungsszeneneditorform:=Tbewegungsszeneneditorform.Create(self);

  setlength(mainform.Bewegungsszenen,length(mainform.Bewegungsszenen)+1);
  setlength(mainform.BewegungsszenenZeit,length(mainform.BewegungsszenenZeit)+1);
  setlength(mainform.BewegungsszenenAktiv,length(mainform.BewegungsszenenAktiv)+1);

  CreateGUID(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].ID);
  positionselection:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].ID;
  mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Name:=_('Neue Bewegungsszene');
  mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Beschreibung:='';
  mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Dauer:=5000;
  mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].repeats:=-1;

  mainform.AktuelleBewegungsszene.ID:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].ID;
  mainform.AktuelleBewegungsszene.Name:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Name;
  mainform.AktuelleBewegungsszene.Beschreibung:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Beschreibung;
  mainform.AktuelleBewegungsszene.IsBeatControlled:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].IsBeatControlled;
  mainform.AktuelleBewegungsszene.figur:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].figur;
  mainform.AktuelleBewegungsszene.dauer:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].dauer;
  mainform.AktuelleBewegungsszene.DontFade:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].DontFade;
  mainform.AktuelleBewegungsszene.repeats:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].repeats;
  mainform.AktuelleBewegungsszene.identischespurgeschwidigkeit:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].identischespurgeschwidigkeit;
  mainform.AktuelleBewegungsszene.startpositionrelativ:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].startpositionrelativ;

  setlength(mainform.AktuelleBewegungsszene.Devices,0);

  setlength(bewegungsszeneneditorform.Zeit,0);
  setlength(bewegungsszeneneditorform.AktuelleBewegungsszeneZeit,0);
  setlength(bewegungsszeneneditorform.AktuelleBewegungsszenePosition,0);

  if bewegungsszeneneditorform.showmodal=mrOK then
  begin
    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].ID:=mainform.AktuelleBewegungsszene.ID;
    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Name:=mainform.AktuelleBewegungsszene.Name;
    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Beschreibung:=mainform.AktuelleBewegungsszene.Beschreibung;
    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].IsBeatControlled:=mainform.AktuelleBewegungsszene.IsBeatControlled;
    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].figur:=mainform.AktuelleBewegungsszene.figur;
    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].dauer:=mainform.AktuelleBewegungsszene.dauer;
    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].DontFade:=mainform.AktuelleBewegungsszene.DontFade;
    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].repeats:=mainform.AktuelleBewegungsszene.repeats;
    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].identischespurgeschwidigkeit:=mainform.AktuelleBewegungsszene.identischespurgeschwidigkeit;
    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].startpositionrelativ:=mainform.AktuelleBewegungsszene.startpositionrelativ;

    setlength(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices,length(mainform.AktuelleBewegungsszene.Devices));
    setlength(mainform.BewegungsszenenZeit[length(mainform.Bewegungsszenen)-1],length(mainform.AktuelleBewegungsszene.Devices));
    setlength(mainform.BewegungsszenenAktiv[length(mainform.BewegungsszenenAktiv)-1].Zeit,length(mainform.AktuelleBewegungsszene.Devices));
    setlength(mainform.BewegungsszenenAktiv[length(mainform.BewegungsszenenAktiv)-1].Repeats,length(mainform.AktuelleBewegungsszene.Devices));
    setlength(mainform.BewegungsszenenAktiv[length(mainform.BewegungsszenenAktiv)-1].Position,length(mainform.AktuelleBewegungsszene.Devices));

    for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
    begin
      mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].ID:=mainform.AktuelleBewegungsszene.Devices[i].ID;

      setlength(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].DeviceChannel,length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel));
      setlength(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].Szenen,length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel));

      setlength(mainform.BewegungsszenenZeit[length(mainform.Bewegungsszenen)-1][i],length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel));
      setlength(mainform.BewegungsszenenAktiv[length(mainform.BewegungsszenenAktiv)-1].Zeit[i],length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel));
      setlength(mainform.BewegungsszenenAktiv[length(mainform.BewegungsszenenAktiv)-1].Repeats[i],length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel));
      setlength(mainform.BewegungsszenenAktiv[length(mainform.BewegungsszenenAktiv)-1].Position[i],length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel));

      for k:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel)-1 do
      begin
        mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].DeviceChannel[k]:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[k];

        setlength(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].Szenen[k], length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[k]));
        for l:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[k])-1 do
        begin
          mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].Szenen[k][l]:=mainform.AktuelleBewegungsszene.Devices[i].Szenen[k][l];
        end;
      end;
    end;

    TempNode:=VST.AddChild(VSTRootNodes[3]);
    Data:=VST.GetNodeData(TempNode);
    Data^.NodeType:=3;
    Data^.IsRootNode:=false;
    Data^.IsCatNode:=false;
    Data^.Caption:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Name;
    Data^.Beschreibung:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Beschreibung;
    Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].ID,'time');
    Data^.ID:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].ID;
    VST.Expanded[TempNode]:=true;
    VST.Expanded[TempNode.Parent]:=true;
    VST.Selected[TempNode]:=true;
    VST.FocusedNode:=TempNode;

    // noch schnell die Einträge alphabetisch sortieren
    VST.Sort(VSTRootNodes[3], 0, sdAscending);
  end else
  begin
    setlength(mainform.Bewegungsszenen,length(mainform.Bewegungsszenen)-1);
    setlength(mainform.BewegungsszenenZeit,length(mainform.BewegungsszenenZeit)-1);
    setlength(mainform.BewegungsszenenAktiv,length(mainform.BewegungsszenenAktiv)-1);
  end;

//  bewegungsszeneneditorform.Free;
end;

procedure Tszenenverwaltungform.Befehle1Click(Sender: TObject);
var
  i:integer;
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

  setlength(befehlseditor_array2,length(befehlseditor_array2)+1);
  befehlseditor_array2[length(befehlseditor_array2)-1]:=Tbefehlseditor2.Create(self);
  befehlseditor_array2[length(befehlseditor_array2)-1].CheckBox1.Visible:=true;

  CreateGUID(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ID);
  befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Typ:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Name:=_('Neuer Befehl');
  befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Beschreibung:='';
  befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OnValue:=255;
  befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OffValue:=0;
  befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.RunOnProjectLoad:=false;
  setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger,0);
  setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString,0);
  setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID,0);

  befehlseditor_array2[length(befehlseditor_array2)-1].ShowModal;
  if befehlseditor_array2[length(befehlseditor_array2)-1].ModalResult=mrOK then
  begin
    setlength(mainform.Befehle2,length(mainform.Befehle2)+1);
    CreateGUID(mainform.Befehle2[length(mainform.Befehle2)-1].ID);
    positionselection:=mainform.Befehle2[length(mainform.Befehle2)-1].ID;
    mainform.Befehle2[length(mainform.Befehle2)-1].Typ:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Typ;
    mainform.Befehle2[length(mainform.Befehle2)-1].Name:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Name;
    mainform.Befehle2[length(mainform.Befehle2)-1].Beschreibung:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Beschreibung;
    mainform.Befehle2[length(mainform.Befehle2)-1].OnValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OnValue;
    mainform.Befehle2[length(mainform.Befehle2)-1].OffValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OffValue;
    mainform.Befehle2[length(mainform.Befehle2)-1].RunOnProjectLoad:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.RunOnProjectLoad;
    setlength(mainform.Befehle2[length(mainform.Befehle2)-1].ArgInteger,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger));
    for i:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger)-1 do
      mainform.Befehle2[length(mainform.Befehle2)-1].ArgInteger[i]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger[i];
    setlength(mainform.Befehle2[length(mainform.Befehle2)-1].ArgString,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString));
    for i:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString)-1 do
      mainform.Befehle2[length(mainform.Befehle2)-1].ArgString[i]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString[i];
    setlength(mainform.Befehle2[length(mainform.Befehle2)-1].ArgGUID,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID));
    for i:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID)-1 do
      mainform.Befehle2[length(mainform.Befehle2)-1].ArgGUID[i]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID[i];

    TempNode:=VST.AddChild(VSTRootNodes[4]);
    Data:=VST.GetNodeData(TempNode);
    Data^.NodeType:=4;
    Data^.IsRootNode:=false;
    Data^.IsCatNode:=false;
    Data^.Caption:=mainform.Befehle2[length(mainform.Befehle2)-1].Name;
    Data^.Beschreibung:=mainform.Befehle2[length(mainform.Befehle2)-1].Beschreibung;
    Data^.Fadetime:='';
    Data^.ID:=mainform.Befehle2[length(mainform.Befehle2)-1].ID;
    VST.Expanded[TempNode]:=true;
    VST.Expanded[TempNode.Parent]:=true;
    VST.Selected[TempNode]:=true;
    VST.FocusedNode:=TempNode;

    // noch schnell die Einträge alphabetisch sortieren
    VST.Sort(VSTRootNodes[4], 0, sdAscending);
  end;

  befehlseditor_array2[length(befehlseditor_array2)-1].Free;
  setlength(befehlseditor_array2,length(befehlseditor_array2)-1);
end;

procedure Tszenenverwaltungform.FormShow(Sender: TObject);
var
  i,k:integer;
  LReg:TRegistry;
  Data: PTreeData;
  TempNode, Temp2Node, CatNode:PVirtualNode;
begin
  if multiselect or IsNonModal then
    VST.TreeOptions.SelectionOptions:=[toMultiSelect]
  else
    VST.TreeOptions.SelectionOptions:=[];

  recordbtn.enabled:=not Effektmodus;
  CatBtn.enabled:=not Effektmodus;
  EditBtn.enabled:=not Effektmodus;
  Button5.enabled:=not Effektmodus;
  AddBtn.enabled:=not Effektmodus;
  DeleteBtn.enabled:=not Effektmodus;

  if IsNonModal then
  begin
    if Sender<>nil then
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
            LReg.WriteBool('Showing Szenenverwaltung',true);

            if not LReg.KeyExists('Szenenverwaltung') then
              LReg.CreateKey('Szenenverwaltung');
            if LReg.OpenKey('Szenenverwaltung',true) then
            begin
              if LReg.ValueExists('Width') then
                szenenverwaltung_formarray[0].ClientWidth:=LReg.ReadInteger('Width')
              else
                szenenverwaltung_formarray[0].ClientWidth:=522;
              if LReg.ValueExists('Height') then
                szenenverwaltung_formarray[0].ClientHeight:=LReg.ReadInteger('Height')
              else
                szenenverwaltung_formarray[0].ClientHeight:=418;

              if LReg.ValueExists('PosX') then
              begin
                if (not (LReg.ReadInteger('PosX')+szenenverwaltung_formarray[0].Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
                  szenenverwaltung_formarray[0].Left:=LReg.ReadInteger('PosX')
                else
                  szenenverwaltung_formarray[0].Left:=0;
              end else
              begin
                szenenverwaltung_formarray[0].Left:=0;
              end;

              if LReg.ValueExists('PosY') then
              begin
                if (not (LReg.ReadInteger('PosY')+szenenverwaltung_formarray[0].Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
                  szenenverwaltung_formarray[0].Top:=LReg.ReadInteger('PosY')
                else
                  szenenverwaltung_formarray[0].Top:=0;
              end else
              begin
                szenenverwaltung_formarray[0].Top:=0;
              end;
            end;
          end;
        end;
      end;
      LReg.CloseKey;
      LReg.Free;
    end;
  end else
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
          LReg.WriteBool('Showing Szenenverwaltung',true);

          if not LReg.KeyExists('Szenenverwaltung') then
            LReg.CreateKey('Szenenverwaltung');
          if LReg.OpenKey('Szenenverwaltung',true) then
          begin
            if LReg.ValueExists('Width') then
              szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ClientWidth:=LReg.ReadInteger('Width')
            else
              szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ClientWidth:=522;
            if LReg.ValueExists('Height') then
              szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ClientHeight:=LReg.ReadInteger('Height')
            else
              szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ClientHeight:=418;
          end;
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
  end;

  VST.BeginUpdate;

  VST.Clear;
  VST.NodeDataSize:=sizeof(TTreeData);
  setlength(VSTRootNodes,0);

  if not Effektmodus then
  begin
    setlength(VSTRootNodes, 13);

    VSTRootNodes[0]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[0]);
    Data^.NodeType:=0;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Einfache Szenen');
    VSTRootNodes[1]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[1]);
    Data^.NodeType:=1;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Geräteszenen');
    VSTRootNodes[2]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[2]);
    Data^.NodeType:=2;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Audioszenen');
    VSTRootNodes[3]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[3]);
    Data^.NodeType:=3;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.Caption:=_('Bewegungsszenen');
    VSTRootNodes[4]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[4]);
    Data^.NodeType:=4;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Befehle');
    VSTRootNodes[5]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[5]);
    Data^.NodeType:=5;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Kombinationsszenen');
    VSTRootNodes[6]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[6]);
    Data^.NodeType:=6;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Presets');
    VSTRootNodes[7]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[7]);
    Data^.NodeType:=7;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Automatikszenen');
    VSTRootNodes[8]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[8]);
    Data^.NodeType:=8;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Effekte');
    VSTRootNodes[9]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[9]);
    Data^.NodeType:=9;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('MediaCenter Szenen');
    VSTRootNodes[10]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[10]);
    Data^.NodeType:=10;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Preset-Szenen');
    VSTRootNodes[11]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[11]);
    Data^.NodeType:=11;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Code-Szenen');
    VSTRootNodes[12]:=VST.AddChild(nil);
    Data:=VST.GetNodeData(VSTRootNodes[12]);
    Data^.NodeType:=12;
    Data^.IsRootNode:=true;
    Data^.IsCatNode:=false;
    Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    Data^.Caption:=_('Pluginszenen');

    for i:=0 to length(mainform.EinfacheSzenen)-1 do
    begin
      if mainform.EinfacheSzenen[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=0) and (Data^.Caption=mainform.EinfacheSzenen[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[0]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=0;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.EinfacheSzenen[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[0];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=0;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.EinfacheSzenen[i].Name;
      Data^.Beschreibung:=mainform.EinfacheSzenen[i].Beschreibung;
      Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Einfacheszenen[i].ID, 'time');
      Data^.ID:=mainform.EinfacheSzenen[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.DeviceScenes)-1 do
    begin
      if mainform.DeviceScenes[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=1) and (Data^.Caption=mainform.DeviceScenes[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[1]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=1;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.DeviceScenes[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[1];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=1;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.DeviceScenes[i].Name;
      Data^.Beschreibung:=mainform.DeviceScenes[i].Beschreibung;
      Data^.Fadetime:=mainform.GetSceneInfo2(mainform.DeviceScenes[i].ID, 'time');
      Data^.ID:=mainform.DeviceScenes[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.Audioszenen)-1 do
    begin
      if mainform.Audioszenen[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=2) and (Data^.Caption=mainform.Audioszenen[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[2]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=2;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.Audioszenen[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[2];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=2;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.Audioszenen[i].Name;
      Data^.Beschreibung:=mainform.Audioszenen[i].Beschreibung;
      Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Audioszenen[i].ID, 'time');
      Data^.ID:=mainform.Audioszenen[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.Bewegungsszenen)-1 do
    begin
      if mainform.Bewegungsszenen[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=3) and (Data^.Caption=mainform.Bewegungsszenen[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[3]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=3;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.Bewegungsszenen[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[3];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=3;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.Bewegungsszenen[i].Name;
      Data^.Beschreibung:=mainform.Bewegungsszenen[i].Beschreibung;
      Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Bewegungsszenen[i].ID, 'time');
      Data^.ID:=mainform.Bewegungsszenen[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.Befehle2)-1 do
    begin
      if mainform.Befehle2[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=4) and (Data^.Caption=mainform.Befehle2[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[4]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=4;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.Befehle2[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[4];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=4;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.Befehle2[i].Name;
      Data^.Beschreibung:=mainform.Befehle2[i].Beschreibung;
      Data^.ID:=mainform.Befehle2[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.Kompositionsszenen)-1 do
    begin
      if mainform.Kompositionsszenen[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=5) and (Data^.Caption=mainform.Kompositionsszenen[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[5]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=5;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.Kompositionsszenen[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[5];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=5;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.Kompositionsszenen[i].Name;
      Data^.Beschreibung:=mainform.Kompositionsszenen[i].Beschreibung;
      Data^.Fadetime:='';
      Data^.ID:=mainform.Kompositionsszenen[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.DevicePresets)-1 do
    begin
      if mainform.Devicepresets[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=6) and (Data^.Caption=mainform.Devicepresets[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[6]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=6;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.Devicepresets[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[6];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=6;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.DevicePresets[i].Name;
      Data^.Beschreibung:=mainform.DevicePresets[i].Beschreibung;
      Data^.Fadetime:='';
      Data^.ID:=mainform.DevicePresets[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.Autoszenen)-1 do
    begin
      if mainform.Autoszenen[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=7) and (Data^.Caption=mainform.AutoSzenen[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[7]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=7;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.AutoSzenen[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[7];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=7;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.Autoszenen[i].Name;
      Data^.Beschreibung:=mainform.Autoszenen[i].Beschreibung;
      Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Autoszenen[i].ID, 'time');
      Data^.ID:=mainform.Autoszenen[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.effektsequenzereffekte)-1 do
    begin
      if mainform.effektsequenzereffekte[i].TabPosition<>0 then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=8) and (Data^.Caption=mainform.EffektsequenzerTabs[mainform.effektsequenzereffekte[i].TabPosition]) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[8]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=8;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.EffektsequenzerTabs[mainform.effektsequenzereffekte[i].TabPosition];
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[8];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=8;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.effektsequenzereffekte[i].Name;
      Data^.Beschreibung:=mainform.effektsequenzereffekte[i].Beschreibung;
      Data^.Fadetime:='';
      Data^.ID:=mainform.effektsequenzereffekte[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.Mediacenterszenen)-1 do
    begin
      if mainform.MediaCenterSzenen[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=9) and (Data^.Caption=mainform.MediaCenterSzenen[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[9]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=9;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.MediaCenterSzenen[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[9];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=9;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.Mediacenterszenen[i].Name;
      Data^.Beschreibung:=mainform.Mediacenterszenen[i].Beschreibung;
      Data^.Fadetime:='';
      Data^.ID:=mainform.Mediacenterszenen[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.presetscenes)-1 do
    begin
      if mainform.presetscenes[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=10) and (Data^.Caption=mainform.presetscenes[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[10]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=10;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.presetscenes[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[10];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=10;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.presetscenes[i].Name;
      Data^.Beschreibung:=mainform.presetscenes[i].Beschreibung;
      Data^.Fadetime:='';
      Data^.ID:=mainform.presetscenes[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.codescenes)-1 do
    begin
      if mainform.codescenes[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=11) and (Data^.Caption=mainform.codescenes[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[11]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=11;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.codescenes[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUId('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[11];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=11;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.codescenes[i].Name;
      Data^.Beschreibung:=mainform.codescenes[i].Beschreibung;
      Data^.Fadetime:='';
      Data^.ID:=mainform.codescenes[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    for i:=0 to length(mainform.PluginSzenen)-1 do
    begin
      if mainform.PluginSzenen[i].Category<>'' then
      begin
        CatNode:=nil;
        TempNode:=VST.GetFirst;
        while Assigned(TempNode) and (not Assigned(CatNode)) do
        begin
          Data:=VST.GetNodeData(TempNode);
          if Data^.IsCatNode and (Data^.NodeType=0) and (Data^.Caption=mainform.PluginSzenen[i].Category) then
            CatNode:=TempNode;
          TempNode:=VST.GetNext(TempNode);
        end;

        if not Assigned(CatNode) then
        begin
          CatNode:=VST.AddChild(VSTRootNodes[12]);
          Data:=VST.GetNodeData(CatNode);
          Data^.NodeType:=12;
          Data^.IsRootNode:=false;
          Data^.IsCatNode:=true;
          Data^.Caption:=mainform.PluginSzenen[i].Category;
          Data^.Beschreibung:='';
          Data^.Fadetime:='0';
          Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
        end;
      end else
        CatNode:=VSTRootNodes[12];

      TempNode:=VST.AddChild(CatNode);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=12;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.PluginSzenen[i].Name;
      Data^.Beschreibung:='';
      Data^.Fadetime:='0';
      Data^.ID:=mainform.PluginSzenen[i].ID;

      VST.Sort(CatNode, 0, sdAscending);
    end;

    // noch schnell die Einträge alphabetisch sortieren
    for i:=0 to length(VSTRootNodes)-1 do
    begin
      VST.Sort(VSTRootNodes[i], 0, sdAscending);
    end;
  end else
  begin
    if length(mainform.Effektsequenzereffekte)>0 then
    begin
      setlength(VSTRootNodes,1);
      VSTRootNodes[0]:=VST.AddChild(nil);
      Data:=VST.GetNodeData(VSTRootNodes[0]);
      Data^.NodeType:=8;
      Data^.IsRootNode:=true;
      Data^.IsCatNode:=false;
      Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
      Data^.Caption:=_('Effekte');

      for i:=0 to length(mainform.Effektsequenzereffekte)-1 do
      begin
        TempNode:=VST.AddChild(VSTRootNodes[0]);
        Data:=VST.GetNodeData(TempNode);
        Data^.ID:=mainform.Effektsequenzereffekte[i].ID;
        Data^.NodeType:=8;
        Data^.IsRootNode:=false;
        Data^.IsCatNode:=false;
        Data^.Caption:=mainform.Effektsequenzereffekte[i].Name+' ['+mainform.EffektsequenzerTabs[mainform.effektsequenzereffekte[i].TabPosition]+']';
        Data^.Beschreibung:=mainform.Effektsequenzereffekte[i].Beschreibung;
        Data^.Fadetime:='';

        // Effekt selektieren
        for k:=0 to length(positionen)-1 do
        begin
          if IsEqualGUID(positionen[k],mainform.Effektsequenzereffekte[i].ID) then
          begin
            VST.FocusedNode:=TempNode;
            VST.Selected[TempNode]:=true;
            break;
          end;
        end;
      end;

      VST.Expanded[VSTRootNodes[0]]:=true;
    end;
  end;

  VST.EndUpdate;

  TempNode:=VST.GetFirst;
  Data:=VST.GetNodeData(TempNode);

  while Assigned(TempNode) and (not IsEqualGUID(Data^.ID, positionselection)) do
  begin
    TempNode:=VST.GetNext(TempNode);
    Data:=VST.GetNodeData(TempNode);
  end;
  if Assigned(TempNode) and IsEqualGUID(Data^.ID, positionselection) and (not Data^.IsRootNode) and (not Data^.IsCatNode) then
  begin
    VST.Expanded[TempNode]:=true;
    VST.FocusedNode:=TempNode;
    VST.Selected[TempNode]:=true;
  end;

  AddBtn.Enabled:=not Effektmodus;
  EditBtn.Enabled:=not Effektmodus;
//    Button5.Enabled:=not Effektmodus;
//    DeleteBtn.Enabled:=not Effektmodus;
  SpeedButton1.Enabled:=not Effektmodus;
  SpeedButton2.Enabled:=not Effektmodus;
  SpeedButton3.Enabled:=not Effektmodus;
//    SpeedButton4.Enabled:=not Effektmodus;
//    SpeedButton5.Enabled:=not Effektmodus;
  if not Effektmodus then
    VST.PopupMenu:=PopupMenu1
  else
    VST.PopupMenu:=nil;
end;

procedure Tszenenverwaltungform.DeleteBtnClick(Sender: TObject);
var
  i, j, k, l, m, n, position:integer;
  IDfordelete:TGUID;
  sceneinuse:boolean;
  Data: PTreeData;
  TempNode: PVirtualNode;
  DeleteTreeNode:boolean;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if messagedlg(_('Die selektierten Szenen werden gelöscht. Fortfahren?'),mtWarning,
    [mbYes,mbNo],0)=mrNo then exit;

  position:=0;
  DeleteTreeNode:=false;

  if VST.SelectedCount=0 then exit;

  TempNode:=VST.GetFirst;

  while Assigned(TempNode) do
  begin
    if VST.Selected[TempNode] then
    begin
      Data:=VST.GetNodeData(TempNode);
      if not ((Data^.IsRootNode) or (Data^.IsCatNode)) then
      begin
        if not (Data^.IsRootNode or Data^.IsCatNode) then
        begin
          if not Effektmodus then
          begin
            case Data^.NodeType of
              0: // Einfache Szene
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Einfache Szene');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  // Szenen verschieben
                  for i:=0 to length(mainform.EinfacheSzenen)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.EinfacheSzenen[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.Einfacheszenen)-2 do
                  begin
                    mainform.Einfacheszenen[i]:=mainform.Einfacheszenen[i+1];
                  end;

                  // letzte Szene löschen
                  setlength(mainform.Einfacheszenen,length(mainform.Einfacheszenen)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              1: // Geräteszene
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Geräteszene');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  for i:=0 to length(mainform.DeviceScenes)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.DeviceScenes[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.DeviceScenes)-2 do
                  begin
                    mainform.DeviceScenes[i].ID:=mainform.DeviceScenes[i+1].ID;
                    mainform.DeviceScenes[i].Name:=mainform.DeviceScenes[i+1].Name;
                    mainform.DeviceScenes[i].Beschreibung:=mainform.DeviceScenes[i+1].Beschreibung;
                    mainform.DeviceScenes[i].Fadetime:=mainform.DeviceScenes[i+1].Fadetime;
                    mainform.DeviceScenes[i].Category:=mainform.DeviceScenes[i+1].Category;

                    setlength(mainform.DeviceScenes[i].Devices,length(mainform.DeviceScenes[i+1].Devices));
                    for j:=0 to length(mainform.DeviceScenes[i].Devices)-1 do
                    begin
                      mainform.DeviceScenes[i].Devices[j].ID:=mainform.DeviceScenes[i+1].Devices[j].ID;
                      setlength(mainform.DeviceScenes[i].Devices[j].ChanActive,length(mainform.DeviceScenes[i+1].Devices[j].ChanActive));
                      setlength(mainform.DeviceScenes[i].Devices[j].ChanValue,length(mainform.DeviceScenes[i+1].Devices[j].ChanValue));
                      setlength(mainform.DeviceScenes[i].Devices[j].ChanActiveRandom,length(mainform.DeviceScenes[i+1].Devices[j].ChanActiveRandom));
                      setlength(mainform.DeviceScenes[i].Devices[j].ChanValueRandom,length(mainform.DeviceScenes[i+1].Devices[j].ChanValueRandom));
                      setlength(mainform.DeviceScenes[i].Devices[j].ChanDelay,length(mainform.DeviceScenes[i+1].Devices[j].ChanDelay));
                      setlength(mainform.DeviceScenes[i].Devices[j].ChanFadetime,length(mainform.DeviceScenes[i+1].Devices[j].ChanFadetime));

                      for k:=0 to length(mainform.DeviceScenes[i].Devices[j].ChanActive)-1 do
                      begin
                        mainform.DeviceScenes[i].Devices[j].ChanActive[k]:=mainform.DeviceScenes[i+1].Devices[j].ChanActive[k];
                        mainform.DeviceScenes[i].Devices[j].ChanValue[k]:=mainform.DeviceScenes[i+1].Devices[j].ChanValue[k];
                        mainform.DeviceScenes[i].Devices[j].ChanActiveRandom[k]:=mainform.DeviceScenes[i+1].Devices[j].ChanActiveRandom[k];
                        mainform.DeviceScenes[i].Devices[j].ChanValueRandom[k]:=mainform.DeviceScenes[i+1].Devices[j].ChanValueRandom[k];
                        mainform.DeviceScenes[i].Devices[j].ChanDelay[k]:=mainform.DeviceScenes[i+1].Devices[j].ChanDelay[k];
                        mainform.DeviceScenes[i].Devices[j].ChanFadetime[k]:=mainform.DeviceScenes[i+1].Devices[j].ChanFadetime[k];
                      end;
                    end;

                    setlength(mainform.DeviceScenes[i].Befehle,length(mainform.DeviceScenes[i+1].Befehle));
                    for j:=0 to length(mainform.DeviceScenes[i].Befehle)-1 do
                    begin
                      mainform.DeviceScenes[i].Befehle[j].ID:=mainform.DeviceScenes[i+1].Befehle[j].ID;
                      mainform.DeviceScenes[i].Befehle[j].Typ:=mainform.DeviceScenes[i+1].Befehle[j].Typ;
                      mainform.DeviceScenes[i].Befehle[j].Name:=mainform.DeviceScenes[i+1].Befehle[j].Name;
                      mainform.DeviceScenes[i].Befehle[j].Beschreibung:=mainform.DeviceScenes[i+1].Befehle[j].Beschreibung;
                      mainform.DeviceScenes[i].Befehle[j].OnValue:=mainform.DeviceScenes[i+1].Befehle[j].OnValue;
                      mainform.DeviceScenes[i].Befehle[j].OffValue:=mainform.DeviceScenes[i+1].Befehle[j].OffValue;
                      mainform.DeviceScenes[i].Befehle[j].ScaleValue:=mainform.DeviceScenes[i+1].Befehle[j].ScaleValue;
                      mainform.DeviceScenes[i].Befehle[j].SwitchValue:=mainform.DeviceScenes[i+1].Befehle[j].SwitchValue;
                      mainform.DeviceScenes[i].Befehle[j].InvertSwitchValue:=mainform.DeviceScenes[i+1].Befehle[j].InvertSwitchValue;

                      setlength(mainform.DeviceScenes[i].Befehle[j].ArgInteger, length(mainform.DeviceScenes[i+1].Befehle[j].ArgInteger));
                      setlength(mainform.DeviceScenes[i].Befehle[j].ArgString, length(mainform.DeviceScenes[i+1].Befehle[j].ArgString));
                      setlength(mainform.DeviceScenes[i].Befehle[j].ArgGUID, length(mainform.DeviceScenes[i+1].Befehle[j].ArgGUID));

                      for k:=0 to length(mainform.DeviceScenes[i].Befehle[j].ArgInteger)-1 do
                        mainform.DeviceScenes[i].Befehle[j].ArgInteger[k]:=mainform.DeviceScenes[i+1].Befehle[j].ArgInteger[k];
                      for k:=0 to length(mainform.DeviceScenes[i].Befehle[j].ArgString)-1 do
                        mainform.DeviceScenes[i].Befehle[j].ArgString[k]:=mainform.DeviceScenes[i+1].Befehle[j].ArgString[k];
                      for k:=0 to length(mainform.DeviceScenes[i].Befehle[j].ArgGUID)-1 do
                        mainform.DeviceScenes[i].Befehle[j].ArgGUID[k]:=mainform.DeviceScenes[i+1].Befehle[j].ArgGUID[k];
                    end;

                    setlength(mainform.DeviceScenes[i].Befehlswerte,length(mainform.DeviceScenes[i+1].Befehlswerte));
                    for j:=0 to length(mainform.DeviceScenes[i].Befehlswerte)-1 do
                    begin
                      mainform.DeviceScenes[i].Befehlswerte[j].ID:=mainform.DeviceScenes[i+1].Befehlswerte[j].ID;

                      setlength(mainform.DeviceScenes[i].Befehlswerte[j].ChanActive,length(mainform.DeviceScenes[i+1].Befehlswerte[j].ChanActive));
                      setlength(mainform.DeviceScenes[i].Befehlswerte[j].ChanValue,length(mainform.DeviceScenes[i+1].Befehlswerte[j].ChanValue));
                      setlength(mainform.DeviceScenes[i].Befehlswerte[j].ChanActiveRandom,length(mainform.DeviceScenes[i+1].Befehlswerte[j].ChanActiveRandom));
                      setlength(mainform.DeviceScenes[i].Befehlswerte[j].ChanValueRandom,length(mainform.DeviceScenes[i+1].Befehlswerte[j].ChanValueRandom));
                      setlength(mainform.DeviceScenes[i].Befehlswerte[j].ChanDelay,length(mainform.DeviceScenes[i+1].Befehlswerte[j].ChanDelay));
                      setlength(mainform.DeviceScenes[i].Befehlswerte[j].ChanFadetime,length(mainform.DeviceScenes[i+1].Befehlswerte[j].ChanFadetime));

                      for k:=0 to length(mainform.DeviceScenes[i].Befehlswerte[j].ChanActive)-1 do
                      begin
                        mainform.DeviceScenes[i].Befehlswerte[j].ChanActive[k]:=mainform.DeviceScenes[i+1].Befehlswerte[j].ChanActive[k];
                        mainform.DeviceScenes[i].Befehlswerte[j].ChanValue[k]:=mainform.DeviceScenes[i+1].Befehlswerte[j].ChanValue[k];
                        mainform.DeviceScenes[i].Befehlswerte[j].ChanActiveRandom[k]:=mainform.DeviceScenes[i+1].Befehlswerte[j].ChanActiveRandom[k];
                        mainform.DeviceScenes[i].Befehlswerte[j].ChanValueRandom[k]:=mainform.DeviceScenes[i+1].Befehlswerte[j].ChanValueRandom[k];
                        mainform.DeviceScenes[i].Befehlswerte[j].ChanDelay[k]:=mainform.DeviceScenes[i+1].Befehlswerte[j].ChanDelay[k];
                        mainform.DeviceScenes[i].Befehlswerte[j].ChanFadetime[k]:=mainform.DeviceScenes[i+1].Befehlswerte[j].ChanFadetime[k];
                      end;
                    end;
                  end;
                  setlength(mainform.DeviceScenes,length(mainform.DeviceScenes)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              2: // Audioszene
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Audioszene');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  // Szenen verschieben
                  for i:=0 to length(mainform.Audioszenen)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.Audioszenen[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.Audioszenen)-2 do
                  begin
                    mainform.Audioszenen[i]:=mainform.Audioszenen[i+1];
                  end;
                  // letzte Szene löschen
                  setlength(mainform.Audioszenen,length(mainform.Audioszenen)-1);
                  setlength(mainform.AudioszenenCHAN,length(mainform.AudioszenenCHAN)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              3: // Bewegungsszene
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Bewegungsszene');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  // Szenen verschieben
                  for i:=0 to length(mainform.Bewegungsszenen)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.Bewegungsszenen[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.Bewegungsszenen)-2 do
                  begin
                    mainform.Bewegungsszenen[i].ID:=mainform.Bewegungsszenen[i+1].ID;
                    mainform.Bewegungsszenen[i].Name:=mainform.Bewegungsszenen[i+1].Name;
                    mainform.Bewegungsszenen[i].Beschreibung:=mainform.Bewegungsszenen[i+1].Beschreibung;
                    mainform.Bewegungsszenen[i].IsBeatControlled:=mainform.Bewegungsszenen[i+1].IsBeatControlled;
                    mainform.Bewegungsszenen[i].figur:=mainform.Bewegungsszenen[i+1].figur;
                    mainform.Bewegungsszenen[i].dauer:=mainform.Bewegungsszenen[i+1].dauer;
                    mainform.Bewegungsszenen[i].DontFade:=mainform.Bewegungsszenen[i+1].DontFade;
                    mainform.Bewegungsszenen[i].repeats:=mainform.Bewegungsszenen[i+1].repeats;
                    mainform.Bewegungsszenen[i].identischespurgeschwidigkeit:=mainform.Bewegungsszenen[i+1].identischespurgeschwidigkeit;
                    mainform.Bewegungsszenen[i].startpositionrelativ:=mainform.Bewegungsszenen[i+1].startpositionrelativ;
                    mainform.Bewegungsszenen[i].Category:=mainform.Bewegungsszenen[i+1].Category;

                    setlength(mainform.Bewegungsszenen[i].Devices,length(mainform.Bewegungsszenen[i+1].Devices));
                    for j:=0 to length(mainform.Bewegungsszenen[i].Devices)-1 do
                    begin
                      mainform.Bewegungsszenen[i].Devices[j].ID:=mainform.Bewegungsszenen[i+1].Devices[j].ID;

                      setlength(mainform.Bewegungsszenen[i].Devices[j].DeviceChannel, length(mainform.Bewegungsszenen[i+1].Devices[j].DeviceChannel));
                      for k:=0 to length(mainform.Bewegungsszenen[i].Devices[j].DeviceChannel)-1 do
                        mainform.Bewegungsszenen[i].Devices[j].DeviceChannel[k]:=mainform.Bewegungsszenen[i+1].Devices[j].DeviceChannel[k];

                      setlength(mainform.Bewegungsszenen[i].Devices[j].Szenen, length(mainform.Bewegungsszenen[i+1].Devices[j].Szenen));
                      for k:=0 to length(mainform.Bewegungsszenen[i].Devices[j].Szenen)-1 do
                      begin
                        setlength(mainform.Bewegungsszenen[i].Devices[j].Szenen[k],length(mainform.Bewegungsszenen[i+1].Devices[j].Szenen[k]));
                        for l:=0 to length(mainform.Bewegungsszenen[i].Devices[j].Szenen[k])-1 do
                          mainform.Bewegungsszenen[i].Devices[j].Szenen[k][l]:=mainform.Bewegungsszenen[i+1].Devices[j].Szenen[k][l];
                      end;
                    end;
                  end;
                  // letzte Szene löschen
                  setlength(mainform.Bewegungsszenen,length(mainform.Bewegungsszenen)-1);
                  setlength(mainform.BewegungsszenenZeit,length(mainform.BewegungsszenenZeit)-1);
                  setlength(mainform.BewegungsszenenAktiv,length(mainform.BewegungsszenenAktiv)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              4: // Befehl
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Befehl');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  // Befehle verschieben
                  for i:=0 to length(mainform.Befehle2)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.Befehle2[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.Befehle2)-2 do
                  begin
                    mainform.Befehle2[i].ID:=mainform.Befehle2[i+1].ID;
                    mainform.Befehle2[i].Typ:=mainform.Befehle2[i+1].Typ;
                    mainform.Befehle2[i].Name:=mainform.Befehle2[i+1].Name;
                    mainform.Befehle2[i].Beschreibung:=mainform.Befehle2[i+1].Beschreibung;
                    mainform.Befehle2[i].OnValue:=mainform.Befehle2[i+1].OnValue;
                    mainform.Befehle2[i].OffValue:=mainform.Befehle2[i+1].OffValue;
                    mainform.Befehle2[i].RunOnProjectLoad:=mainform.Befehle2[i+1].RunOnProjectLoad;
                    mainform.Befehle2[i].Category:=mainform.Befehle2[i+1].Category;

                    setlength(mainform.Befehle2[i].ArgInteger,length(mainform.Befehle2[i+1].ArgInteger));
                    setlength(mainform.Befehle2[i].ArgString,length(mainform.Befehle2[i+1].ArgString));
                    setlength(mainform.Befehle2[i].ArgGUID,length(mainform.Befehle2[i+1].ArgGUID));
                    for j:=0 to length(mainform.Befehle2[i].ArgInteger)-1 do
                      mainform.Befehle2[i].ArgInteger[j]:=mainform.Befehle2[i+1].ArgInteger[j];
                    for j:=0 to length(mainform.Befehle2[i].ArgString)-1 do
                      mainform.Befehle2[i].ArgString[j]:=mainform.Befehle2[i+1].ArgString[j];
                    for j:=0 to length(mainform.Befehle2[i].ArgGUID)-1 do
                      mainform.Befehle2[i].ArgGUID[j]:=mainform.Befehle2[i+1].ArgGUID[j];
                  end;
                  // letzte Szene löschen
                  setlength(mainform.Befehle2,length(mainform.Befehle2)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              5: // Kompositionsszene
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Kombinationsszene');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  // Szenen verschieben
                  for i:=0 to length(mainform.Kompositionsszenen)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.Kompositionsszenen[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.Kompositionsszenen)-2 do
                  begin
                    mainform.Kompositionsszenen[i].ID:=mainform.Kompositionsszenen[i+1].ID;
                    mainform.Kompositionsszenen[i].Name:=mainform.Kompositionsszenen[i+1].Name;
                    mainform.Kompositionsszenen[i].Beschreibung:=mainform.Kompositionsszenen[i+1].Beschreibung;

                    setlength(mainform.Kompositionsszenen[i].IDs, length(mainform.Kompositionsszenen[i+1].IDs));
                    setlength(mainform.Kompositionsszenen[i].StopScene, length(mainform.Kompositionsszenen[i+1].StopScene));
                    for j:=0 to length(mainform.Kompositionsszenen[i].IDs)-1 do
                    begin
                      mainform.Kompositionsszenen[i].IDs[j]:=mainform.Kompositionsszenen[i+1].IDs[j];
                      mainform.Kompositionsszenen[i].StopScene[j]:=mainform.Kompositionsszenen[i+1].StopScene[j];
                    end;
                    mainform.Kompositionsszenen[i].Category:=mainform.Kompositionsszenen[i+1].Category;
                  end;
                  // letzte Szene löschen
                  setlength(mainform.Kompositionsszenen,length(mainform.Kompositionsszenen)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              6: // Presets
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Gerätepreset');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  for i:=0 to length(mainform.DevicePresets)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.DevicePresets[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.DevicePresets)-2 do
                  begin
                    mainform.DevicePresets[i].ID:=mainform.DevicePresets[i+1].ID;
                    mainform.DevicePresets[i].Name:=mainform.DevicePresets[i+1].Name;
                    mainform.DevicePresets[i].Beschreibung:=mainform.DevicePresets[i+1].Beschreibung;
                    mainform.DevicePresets[i].Category:=mainform.DevicePresets[i+1].Category;

                    setlength(mainform.DevicePresets[i].ChanTyp,length(mainform.DevicePresets[i+1].ChanTyp));
                    setlength(mainform.DevicePresets[i].ChanValue,length(mainform.DevicePresets[i+1].ChanValue));
                    setlength(mainform.DevicePresets[i].ChanActive,length(mainform.DevicePresets[i+1].ChanActive));

                    for k:=0 to length(mainform.DevicePresets[i].ChanTyp)-1 do
                    begin
                      mainform.DevicePresets[i].ChanTyp[k]:=mainform.DevicePresets[i+1].ChanTyp[k];
                      mainform.DevicePresets[i].ChanValue[k]:=mainform.DevicePresets[i+1].ChanValue[k];
                      mainform.DevicePresets[i].ChanActive[k]:=mainform.DevicePresets[i+1].ChanActive[k];
                    end;
                    mainform.DevicePresets[i].UseNewInterface:=mainform.DevicePresets[i+1].UseNewInterface;
                    mainform.DevicePresets[i].Color:=mainform.DevicePresets[i+1].Color;
                    mainform.DevicePresets[i].Shutter:=mainform.DevicePresets[i+1].Shutter;
                    mainform.DevicePresets[i].Dimmer:=mainform.DevicePresets[i+1].Dimmer;
                    mainform.DevicePresets[i].Iris:=mainform.DevicePresets[i+1].Iris;
                    mainform.DevicePresets[i].Focus:=mainform.DevicePresets[i+1].Focus;
                    mainform.DevicePresets[i].PrismaRot:=mainform.DevicePresets[i+1].PrismaRot;
                    mainform.DevicePresets[i].PrismaEnabled:=mainform.DevicePresets[i+1].PrismaEnabled;
                    mainform.DevicePresets[i].Strobe:=mainform.DevicePresets[i+1].Strobe;
                    mainform.DevicePresets[i].Pan:=mainform.DevicePresets[i+1].Pan;
                    mainform.DevicePresets[i].Tilt:=mainform.DevicePresets[i+1].Tilt;
                    mainform.DevicePresets[i].PanFine:=mainform.DevicePresets[i+1].PanFine;
                    mainform.DevicePresets[i].TiltFine:=mainform.DevicePresets[i+1].TiltFine;
                    mainform.DevicePresets[i].Gobo:=mainform.DevicePresets[i+1].Gobo;
                    mainform.DevicePresets[i].GoboRot1:=mainform.DevicePresets[i+1].GoboRot1;
                    mainform.DevicePresets[i].GoboRot2:=mainform.DevicePresets[i+1].GoboRot2;
                  end;
                  setlength(mainform.DevicePresets,length(mainform.DevicePresets)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              7: // Automatikszene löschen
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Automatikszene');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  for i:=0 to length(mainform.autoszenen)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.autoszenen[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.autoszenen)-2 do
                  begin
                    mainform.autoszenen[i].ID:=mainform.autoszenen[i+1].ID;
                    mainform.autoszenen[i].Name:=mainform.autoszenen[i+1].Name;
                    mainform.autoszenen[i].Beschreibung:=mainform.autoszenen[i+1].Beschreibung;
                    mainform.autoszenen[i].fadetime:=mainform.autoszenen[i+1].fadetime;
                    mainform.autoszenen[i].R:=mainform.autoszenen[i+1].R;
                    mainform.autoszenen[i].G:=mainform.autoszenen[i+1].G;
                    mainform.autoszenen[i].B:=mainform.autoszenen[i+1].B;
                    mainform.autoszenen[i].accuracy:=mainform.autoszenen[i+1].accuracy;
                    mainform.autoszenen[i].helligkeit:=mainform.autoszenen[i+1].helligkeit;
                    mainform.autoszenen[i].Category:=mainform.autoszenen[i+1].Category;
                  end;
                  setlength(mainform.autoszenen,length(mainform.autoszenen)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              8: // Effekt löschen
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Effektname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:='Effekt';

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Der zu löschende Effekt wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Effekt löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  for i:=0 to length(mainform.effektsequenzereffekte)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.effektsequenzereffekte[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  if (length(mainform.Effektsequenzereffekte)>1) and (position<length(mainform.Effektsequenzereffekte)-1) then
                  for i:=position to length(mainform.Effektsequenzereffekte)-2 do
                  begin
                    effektsequenzer.CopyEffect(i+1,i,true);
                  end;
                  setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)-1);
                  DeleteTreeNode:=true;
                end;

                mainform.EffectsChanged;
              end;
              9: // Mediacenterszene löschen
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('MediaCenter Szene');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  for i:=0 to length(mainform.mediacenterszenen)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.mediacenterszenen[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.mediacenterszenen)-2 do
                  begin
                    mainform.mediacenterszenen[i].ID:=mainform.mediacenterszenen[i+1].ID;
                    mainform.mediacenterszenen[i].Name:=mainform.mediacenterszenen[i+1].Name;
                    mainform.mediacenterszenen[i].Beschreibung:=mainform.mediacenterszenen[i+1].Beschreibung;
                    mainform.mediacenterszenen[i].Befehl:=mainform.mediacenterszenen[i+1].Befehl;
                    mainform.mediacenterszenen[i].Data1:=mainform.mediacenterszenen[i+1].Data1;
                    mainform.mediacenterszenen[i].Data2:=mainform.mediacenterszenen[i+1].Data2;
                    mainform.mediacenterszenen[i].Text:=mainform.mediacenterszenen[i+1].Text;
                    mainform.mediacenterszenen[i].Category:=mainform.mediacenterszenen[i+1].Category;
                    mainform.mediacenterszenen[i].Port:=mainform.mediacenterszenen[i+1].Port;
                    mainform.mediacenterszenen[i].Adresse:=mainform.mediacenterszenen[i+1].Adresse;
                  end;
                  setlength(mainform.mediacenterszenen,length(mainform.mediacenterszenen)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              10: // Presets
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Gerätepreset');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  for i:=0 to length(mainform.PresetScenes)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.presetscenes[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.PresetScenes)-2 do
                  begin
                    mainform.PresetScenes[i].ID:=mainform.PresetScenes[i+1].ID;
                    mainform.PresetScenes[i].Name:=mainform.PresetScenes[i+1].Name;
                    mainform.PresetScenes[i].Beschreibung:=mainform.PresetScenes[i+1].Beschreibung;
                    mainform.PresetScenes[i].Category:=mainform.PresetScenes[i+1].Category;

                    setlength(mainform.PresetScenes[i].devices,length(mainform.PresetScenes[i+1].devices));

                    for k:=0 to length(mainform.PresetScenes[i].devices)-1 do
                      mainform.PresetScenes[i].devices[k]:=mainform.PresetScenes[i+1].devices[k];

                    mainform.PresetScenes[i].Color:=mainform.PresetScenes[i+1].Color;
                    mainform.PresetScenes[i].Shutter:=mainform.PresetScenes[i+1].Shutter;
                    mainform.PresetScenes[i].Dimmer:=mainform.PresetScenes[i+1].Dimmer;
                    mainform.PresetScenes[i].Iris:=mainform.PresetScenes[i+1].Iris;
                    mainform.PresetScenes[i].Focus:=mainform.PresetScenes[i+1].Focus;
                    mainform.PresetScenes[i].PrismaRot:=mainform.PresetScenes[i+1].PrismaRot;
                    mainform.PresetScenes[i].PrismaEnabled:=mainform.PresetScenes[i+1].PrismaEnabled;
                    mainform.PresetScenes[i].Strobe:=mainform.PresetScenes[i+1].Strobe;
                    mainform.PresetScenes[i].Pan:=mainform.PresetScenes[i+1].Pan;
                    mainform.PresetScenes[i].Tilt:=mainform.PresetScenes[i+1].Tilt;
                    mainform.PresetScenes[i].PanFine:=mainform.PresetScenes[i+1].PanFine;
                    mainform.PresetScenes[i].TiltFine:=mainform.PresetScenes[i+1].TiltFine;
                    mainform.PresetScenes[i].Gobo:=mainform.PresetScenes[i+1].Gobo;
                    mainform.PresetScenes[i].GoboRot1:=mainform.PresetScenes[i+1].GoboRot1;
                    mainform.PresetScenes[i].GoboRot2:=mainform.PresetScenes[i+1].GoboRot2;
                  end;
                  setlength(mainform.PresetScenes,length(mainform.PresetScenes)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              11: // Codeszene löschen
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Code Szene');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  for i:=0 to length(mainform.codescenes)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.codescenes[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.codescenes)-2 do
                  begin
                    mainform.codescenes[i].ID:=mainform.codescenes[i+1].ID;
                    mainform.codescenes[i].Name:=mainform.codescenes[i+1].Name;
                    mainform.codescenes[i].Beschreibung:=mainform.codescenes[i+1].Beschreibung;
                    mainform.codescenes[i].Category:=mainform.codescenes[i+1].Category;
                    mainform.codescenes[i].Code:=mainform.codescenes[i+1].Code;
                  end;
                  setlength(mainform.codescenes,length(mainform.codescenes)-1);
                  DeleteTreeNode:=true;
                end;
              end;
              12: // PluginSzene löschen
              begin
                IDfordelete:=Data^.ID;
                sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

                askforremovingform.Label4.Caption:=_('Szenenname:');
                askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
                askforremovingform.Label2.Caption:=_('Beschreibung:');
                askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
                askforremovingform.Label6.Caption:=_('Szenentyp:');
                askforremovingform.startadresselabel.Caption:=_('Plugin Szene');

                // Gerät wird noch verwendet -> Dialogbox anzeigen
                if sceneinuse then
                begin
                  askforremovingform.Label35.Caption:=_('Die zu löschende Szene wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
                  askforremovingform.Button1.Caption:=_('Szene löschen');
                  askforremovingform.showmodal;
                end;

                if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
                begin
                  for i:=0 to length(mainform.pluginszenen)-1 do
                  begin
                    if IsEqualGUID(Data^.ID, mainform.pluginszenen[i].ID) then
                    begin
                      position:=i;
                      break;
                    end;
                  end;

                  for i:=position to length(mainform.pluginszenen)-2 do
                  begin
                    mainform.pluginszenen[i].ID:=mainform.pluginszenen[i+1].ID;
                    mainform.pluginszenen[i].Name:=mainform.pluginszenen[i+1].Name;
                    mainform.pluginszenen[i].Category:=mainform.pluginszenen[i+1].Category;
                  end;
                  setlength(mainform.pluginszenen,length(mainform.pluginszenen)-1);
                  mainform.SendMSG(MSG_REMOVEPLUGINSCENE, GUIDToString(Data^.ID), 0);
                  DeleteTreeNode:=true;
                end;
              end;
            end;
          end else
          begin
            IDfordelete:=Data^.ID;
            sceneinuse:=FindSceneConnections(IDfordelete,askforremovingform.Treeview1);

            askforremovingform.Label4.Caption:=_('Effektname:');
            askforremovingform.devicenamelabel.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
            askforremovingform.Label2.Caption:=_('Beschreibung:');
            askforremovingform.devicedescription.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
            askforremovingform.Label6.Caption:=_('Szenentyp:');
            askforremovingform.startadresselabel.Caption:=_('Effekt');

            // Gerät wird noch verwendet -> Dialogbox anzeigen
            if sceneinuse then
            begin
              askforremovingform.Label35.Caption:=_('Der zu löschende Effekt wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
              askforremovingform.Button1.Caption:=_('Effekt löschen');
              askforremovingform.showmodal;
            end;

            if (sceneinuse=false) or (askforremovingform.modalresult=mrOK) then
            begin
              for i:=0 to length(mainform.DeviceScenes)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.Effektsequenzereffekte[i].ID) then
                begin
                  position:=i;
                  break;
                end;
              end;

              if (length(mainform.Effektsequenzereffekte)>1) and (position<length(mainform.Effektsequenzereffekte)-1) then
              for i:=position to length(mainform.Effektsequenzereffekte)-2 do
              begin
                effektsequenzer.CopyEffect(i+1,i,true);
              end;
              setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)-1);
              DeleteTreeNode:=true;
            end;

            mainform.EffectsChanged;
          end;

          if DeleteTreeNode then
            VST.DeleteNode(TempNode, true);
        end;
      end;
    end;
    TempNode:=VST.GetNext(TempNode);
  end;
end;

procedure Tszenenverwaltungform.Button1Click(Sender: TObject);
var
  Data:PTreeData;
begin
  if (VST.SelectedCount>0) then
    Data:=VST.GetNodeData(VST.FocusedNode);

  if Assigned(Data) and (VST.SelectedCount>0) and (not IsEqualGuid(Data^.ID, StringToGUID('{00000000-0000-0000-0000-000000000000}'))) then
    modalresult:=mrOK
  else
    modalresult:=mrCancel;

  szenenverwaltung_formarray[0].FormShow(nil);
end;

procedure Tszenenverwaltungform.SpeedButton2Click(Sender: TObject);
var
  i, j, k, l, Count, Count2, Count3, Count4:integer;
begin
  if Savedialog1.Execute then
  with mainform do
  begin
//Figuren speichern
    FileStream:=TFileStream.Create(Savedialog1.FileName,fmCreate);

    Count:=length(Figuren);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to Count-1 do
    begin
      Filestream.WriteBuffer(Figuren[i].ID,sizeof(Figuren[i].ID));
      Filestream.WriteBuffer(Figuren[i].name,sizeof(Figuren[i].name));
      Filestream.WriteBuffer(Figuren[i].invertpan,sizeof(Figuren[i].invertpan));
      Filestream.WriteBuffer(Figuren[i].inverttilt,sizeof(Figuren[i].inverttilt));
      Count2:=length(Figuren[i].posx);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for k:=0 to Count2-1 do
      begin
        Filestream.WriteBuffer(Figuren[i].posx[k],sizeof(Figuren[i].posx[k]));
        Filestream.WriteBuffer(Figuren[i].posy[k],sizeof(Figuren[i].posy[k]));
      end;
      Filestream.WriteBuffer(Figuren[i].gesamtlaenge,sizeof(Figuren[i].gesamtlaenge));
    end;
// Ende Figuren speichern
// Einfache-, Bewegungs- und Audioszenen, sowie Befehle speichern
    Count:=length(Einfacheszenen);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to length(Einfacheszenen)-1 do
      Filestream.WriteBuffer(Einfacheszenen[i],sizeof(Einfacheszenen[i]));

    Count:=length(DeviceScenes);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to length(DeviceScenes)-1 do
    begin
      Filestream.WriteBuffer(DeviceScenes[i].ID,sizeof(DeviceScenes[i].ID));
      Filestream.WriteBuffer(DeviceScenes[i].Name,sizeof(DeviceScenes[i].Name));
      Filestream.WriteBuffer(DeviceScenes[i].Beschreibung,sizeof(DeviceScenes[i].Beschreibung));
      Filestream.WriteBuffer(DeviceScenes[i].Fadetime,sizeof(DeviceScenes[i].Fadetime));
      Filestream.WriteBuffer(DeviceScenes[i].Category,sizeof(DeviceScenes[i].Category));
      Count2:=length(DeviceScenes[i].Devices);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
      begin
        Filestream.WriteBuffer(DeviceScenes[i].Devices[j].ID,sizeof(DeviceScenes[i].Devices[j].ID));
        Count3:=length(DeviceScenes[i].Devices[j].ChanActive);
        Filestream.WriteBuffer(Count3,sizeof(Count3));
        for k:=0 to Count3-1 do
          Filestream.WriteBuffer(DeviceScenes[i].Devices[j].ChanActive[k],sizeof(DeviceScenes[i].Devices[j].ChanActive[k]));

        Count3:=length(DeviceScenes[i].Devices[j].ChanValue);
        Filestream.WriteBuffer(Count3,sizeof(Count3));
        for k:=0 to Count3-1 do
          Filestream.WriteBuffer(DeviceScenes[i].Devices[j].ChanValue[k],sizeof(DeviceScenes[i].Devices[j].ChanValue[k]));

        Count3:=length(DeviceScenes[i].Devices[j].ChanActiveRandom);
        Filestream.WriteBuffer(Count3,sizeof(Count3));
        for k:=0 to Count3-1 do
          Filestream.WriteBuffer(DeviceScenes[i].Devices[j].ChanActiveRandom[k],sizeof(DeviceScenes[i].Devices[j].ChanActiveRandom[k]));

        Count3:=length(DeviceScenes[i].Devices[j].ChanValueRandom);
        Filestream.WriteBuffer(Count3,sizeof(Count3));
        for k:=0 to Count3-1 do
          Filestream.WriteBuffer(DeviceScenes[i].Devices[j].ChanValueRandom[k],sizeof(DeviceScenes[i].Devices[j].ChanValueRandom[k]));

        Count3:=length(DeviceScenes[i].Devices[j].ChanDelay);
        Filestream.WriteBuffer(Count3,sizeof(Count3));
        for k:=0 to Count3-1 do
          Filestream.WriteBuffer(DeviceScenes[i].Devices[j].ChanDelay[k],sizeof(DeviceScenes[i].Devices[j].ChanDelay[k]));

        Count3:=length(DeviceScenes[i].Devices[j].ChanFadetime);
        Filestream.WriteBuffer(Count3,sizeof(Count3));
        for k:=0 to Count3-1 do
          Filestream.WriteBuffer(DeviceScenes[i].Devices[j].ChanFadetime[k],sizeof(DeviceScenes[i].Devices[j].ChanFadetime[k]));
      end;
    end;

    Count:=length(Audioszenen);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to length(Audioszenen)-1 do
      Filestream.WriteBuffer(Audioszenen[i],sizeof(Audioszenen[i]));

    Count:=length(Bewegungsszenen);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to length(Bewegungsszenen)-1 do
    begin
      Filestream.WriteBuffer(Bewegungsszenen[i].ID,sizeof(Bewegungsszenen[i].ID));
      Filestream.WriteBuffer(Bewegungsszenen[i].Name,sizeof(Bewegungsszenen[i].Name));
      Filestream.WriteBuffer(Bewegungsszenen[i].Beschreibung,sizeof(Bewegungsszenen[i].Beschreibung));
      Filestream.WriteBuffer(Bewegungsszenen[i].figur,sizeof(Bewegungsszenen[i].figur));
      Filestream.WriteBuffer(Bewegungsszenen[i].dauer,sizeof(Bewegungsszenen[i].dauer));
      Filestream.WriteBuffer(Bewegungsszenen[i].dontfade,sizeof(Bewegungsszenen[i].dontfade));
      Filestream.WriteBuffer(Bewegungsszenen[i].repeats,sizeof(Bewegungsszenen[i].repeats));
      Filestream.WriteBuffer(Bewegungsszenen[i].identischespurgeschwidigkeit,sizeof(Bewegungsszenen[i].identischespurgeschwidigkeit));
      Filestream.WriteBuffer(Bewegungsszenen[i].startpositionrelativ,sizeof(Bewegungsszenen[i].startpositionrelativ));
      Filestream.WriteBuffer(Bewegungsszenen[i].Category,sizeof(Bewegungsszenen[i].Category));
      Count2:=length(Bewegungsszenen[i].Devices);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
      begin
        Filestream.WriteBuffer(Bewegungsszenen[i].Devices[j].ID,sizeof(Bewegungsszenen[i].Devices[j].ID));

        Count3:=length(Bewegungsszenen[i].Devices[j].DeviceChannel);
        Filestream.WriteBuffer(Count3,sizeof(Count3));
        for k:=0 to Count3-1 do
        begin
          Filestream.WriteBuffer(Bewegungsszenen[i].Devices[j].DeviceChannel[k],sizeof(Bewegungsszenen[i].Devices[j].DeviceChannel[k]));

          Count4:=length(Bewegungsszenen[i].Devices[j].Szenen[k]);
          Filestream.WriteBuffer(Count4,sizeof(Count4));
          for l:=0 to Count4-1 do
          begin
            Filestream.WriteBuffer(Bewegungsszenen[i].Devices[j].Szenen[k][l],sizeof(Bewegungsszenen[i].Devices[j].Szenen[k][l]));
          end;
        end;
      end;
    end;

    Count:=length(Befehle2);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to Count-1 do
    begin
      Filestream.WriteBuffer(Befehle2[i].ID,sizeof(Befehle2[i].ID));
      Filestream.WriteBuffer(Befehle2[i].Typ,sizeof(Befehle2[i].Typ));
      Filestream.WriteBuffer(Befehle2[i].Name,sizeof(Befehle2[i].Name));
      Filestream.WriteBuffer(Befehle2[i].Beschreibung,sizeof(Befehle2[i].Beschreibung));
      Filestream.WriteBuffer(Befehle2[i].OnValue,sizeof(Befehle2[i].OnValue));
      Filestream.WriteBuffer(Befehle2[i].OffValue,sizeof(Befehle2[i].OffValue));
      Filestream.WriteBuffer(Befehle2[i].RunOnProjectLoad,sizeof(Befehle2[i].RunOnProjectLoad));
      Filestream.WriteBuffer(Befehle2[i].Category,sizeof(Befehle2[i].Category));
      Count2:=length(Befehle2[i].ArgInteger);
      Filestream.WriteBuffer(Count,sizeof(Count));
      for j:=0 to Count2-1 do
      begin
        Filestream.WriteBuffer(Befehle2[i].ArgInteger[j],sizeof(Befehle2[i].ArgInteger[j]));
      end;
      Count2:=length(Befehle2[i].ArgString);
      Filestream.WriteBuffer(Count,sizeof(Count));
      for j:=0 to Count2-1 do
      begin
        Filestream.WriteBuffer(Befehle2[i].ArgString[j],sizeof(Befehle2[i].ArgString[j]));
      end;
      Count2:=length(Befehle2[i].ArgGUID);
      Filestream.WriteBuffer(Count,sizeof(Count));
      for j:=0 to Count2-1 do
      begin
        Filestream.WriteBuffer(Befehle2[i].ArgGUID[j],sizeof(Befehle2[i].ArgGUID[j]));
      end;
    end;

    Count:=length(Kompositionsszenen);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to length(Kompositionsszenen)-1 do
    begin
      Filestream.WriteBuffer(Kompositionsszenen[i].ID,sizeof(Kompositionsszenen[i].ID));
      Filestream.WriteBuffer(Kompositionsszenen[i].Name,sizeof(Kompositionsszenen[i].Name));
      Filestream.WriteBuffer(Kompositionsszenen[i].Beschreibung,sizeof(Kompositionsszenen[i].Beschreibung));
      Filestream.WriteBuffer(Kompositionsszenen[i].Category,sizeof(Kompositionsszenen[i].Category));
      Count2:=length(Kompositionsszenen[i].IDs);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for k:=0 to length(Kompositionsszenen[i].IDs)-1 do
      begin
        Filestream.WriteBuffer(Kompositionsszenen[i].IDs[k],sizeof(Kompositionsszenen[i].IDs[k]));
        Filestream.WriteBuffer(Kompositionsszenen[i].StopScene[k],sizeof(Kompositionsszenen[i].StopScene[k]));
      end;
    end;

    Count:=length(mainform.DevicePresets);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to Count-1 do
    begin
      Filestream.WriteBuffer(mainform.DevicePresets[i].ID,sizeof(mainform.DevicePresets[i].ID));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Name,sizeof(mainform.DevicePresets[i].Name));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Beschreibung,sizeof(mainform.DevicePresets[i].Beschreibung));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Category,sizeof(mainform.DevicePresets[i].Category));
      count2:=length(mainform.DevicePresets[i].ChanTyp);
      Filestream.WriteBuffer(count2,sizeof(count2));
      for k:=0 to count2-1 do
      begin
        Filestream.WriteBuffer(mainform.DevicePresets[i].ChanTyp[k],sizeof(mainform.DevicePresets[i].ChanTyp[k]));
        Filestream.WriteBuffer(mainform.DevicePresets[i].ChanValue[k],sizeof(mainform.DevicePresets[i].ChanValue[k]));
        Filestream.WriteBuffer(mainform.DevicePresets[i].ChanActive[k],sizeof(mainform.DevicePresets[i].ChanActive[k]));
      end;
      Filestream.WriteBuffer(mainform.DevicePresets[i].UseNewInterface,sizeof(mainform.DevicePresets[i].UseNewInterface));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Color,sizeof(mainform.DevicePresets[i].Color));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Shutter,sizeof(mainform.DevicePresets[i].Shutter));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Dimmer,sizeof(mainform.DevicePresets[i].Dimmer));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Iris,sizeof(mainform.DevicePresets[i].Iris));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Focus,sizeof(mainform.DevicePresets[i].Focus));
      Filestream.WriteBuffer(mainform.DevicePresets[i].PrismaRot,sizeof(mainform.DevicePresets[i].PrismaRot));
      Filestream.WriteBuffer(mainform.DevicePresets[i].PrismaEnabled,sizeof(mainform.DevicePresets[i].PrismaEnabled));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Strobe,sizeof(mainform.DevicePresets[i].Strobe));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Pan,sizeof(mainform.DevicePresets[i].Pan));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Tilt,sizeof(mainform.DevicePresets[i].Tilt));
      Filestream.WriteBuffer(mainform.DevicePresets[i].PanFine,sizeof(mainform.DevicePresets[i].PanFine));
      Filestream.WriteBuffer(mainform.DevicePresets[i].TiltFine,sizeof(mainform.DevicePresets[i].TiltFine));
      Filestream.WriteBuffer(mainform.DevicePresets[i].Gobo,sizeof(mainform.DevicePresets[i].Gobo));
      Filestream.WriteBuffer(mainform.DevicePresets[i].GoboRot1,sizeof(mainform.DevicePresets[i].GoboRot1));
      Filestream.WriteBuffer(mainform.DevicePresets[i].GoboRot2,sizeof(mainform.DevicePresets[i].GoboRot2));
    end;

    Count:=length(autoszenen);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to length(autoszenen)-1 do
    begin
      Filestream.WriteBuffer(autoszenen[i].ID,sizeof(autoszenen[i].ID));
      Filestream.WriteBuffer(autoszenen[i].Name,sizeof(autoszenen[i].Name));
      Filestream.WriteBuffer(autoszenen[i].Beschreibung,sizeof(autoszenen[i].Beschreibung));
      Filestream.WriteBuffer(autoszenen[i].Fadetime,sizeof(autoszenen[i].Fadetime));
      Filestream.WriteBuffer(autoszenen[i].R,sizeof(autoszenen[i].R));
      Filestream.WriteBuffer(autoszenen[i].G,sizeof(autoszenen[i].G));
      Filestream.WriteBuffer(autoszenen[i].B,sizeof(autoszenen[i].B));
      Filestream.WriteBuffer(autoszenen[i].accuracy,sizeof(autoszenen[i].accuracy));
      Filestream.WriteBuffer(autoszenen[i].helligkeit,sizeof(autoszenen[i].helligkeit));
      Filestream.WriteBuffer(autoszenen[i].Category,sizeof(autoszenen[i].Category));
    end;

    Count:=length(mainform.MediaCenterSzenen);
	  Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to Count-1 do
    begin
   	  Filestream.WriteBuffer(mainform.MediaCenterSzenen[i].ID,sizeof(mainform.MediaCenterSzenen[i].ID));
   	  Filestream.WriteBuffer(mainform.MediaCenterSzenen[i].Name,sizeof(mainform.MediaCenterSzenen[i].Name));
   	  Filestream.WriteBuffer(mainform.MediaCenterSzenen[i].Beschreibung,sizeof(mainform.MediaCenterSzenen[i].Beschreibung));
   	  Filestream.WriteBuffer(mainform.MediaCenterSzenen[i].Adresse,sizeof(mainform.MediaCenterSzenen[i].Adresse));
   	  Filestream.WriteBuffer(mainform.MediaCenterSzenen[i].Port,sizeof(mainform.MediaCenterSzenen[i].Port));
   	  Filestream.WriteBuffer(mainform.MediaCenterSzenen[i].Befehl,sizeof(mainform.MediaCenterSzenen[i].Befehl));
   	  Filestream.WriteBuffer(mainform.MediaCenterSzenen[i].Data1,sizeof(mainform.MediaCenterSzenen[i].Data1));
   	  Filestream.WriteBuffer(mainform.MediaCenterSzenen[i].Data2,sizeof(mainform.MediaCenterSzenen[i].Data2));
   	  Filestream.WriteBuffer(mainform.MediaCenterSzenen[i].Text,sizeof(mainform.MediaCenterSzenen[i].Text));
   	  Filestream.WriteBuffer(mainform.MediaCenterSzenen[i].Category,sizeof(mainform.MediaCenterSzenen[i].Category));
    end;

    Count:=length(mainform.PluginSzenen);
	  Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to Count-1 do
    begin
   	  Filestream.WriteBuffer(mainform.PluginSzenen[i].ID,sizeof(mainform.PluginSzenen[i].ID));
   	  Filestream.WriteBuffer(mainform.PluginSzenen[i].Name,sizeof(mainform.PluginSzenen[i].Name));
   	  Filestream.WriteBuffer(mainform.PluginSzenen[i].Category,sizeof(mainform.PluginSzenen[i].Category));
    end;

    FileStream.Free;
  end;
end;

procedure Tszenenverwaltungform.SpeedButton1Click(Sender: TObject);
var
  i,j,k,l,Count,Count2,Count3,Count4:Integer;
begin
  if Opendialog1.Execute then
  with mainform do
  begin
    FileStream:=TFileStream.Create(Opendialog1.FileName,fmOpenRead);
// Lese Figurendaten
    Filestream.ReadBuffer(Count,sizeof(Count));
    setlength(Figuren,Count);
    for i:=0 to Count-1 do
    begin
      Filestream.ReadBuffer(Figuren[i].ID,sizeof(Figuren[i].ID));
      Filestream.ReadBuffer(Figuren[i].name,sizeof(Figuren[i].name));
      Filestream.ReadBuffer(Figuren[i].invertpan,sizeof(Figuren[i].invertpan));
      Filestream.ReadBuffer(Figuren[i].inverttilt,sizeof(Figuren[i].inverttilt));
      Filestream.ReadBuffer(Count2,sizeof(Count2));
      setlength(Figuren[i].posx,Count2);
      setlength(Figuren[i].posy,Count2);
      for k:=0 to Count2-1 do
      begin
        Filestream.ReadBuffer(Figuren[i].posx[k],sizeof(Figuren[i].posx[k]));
        Filestream.ReadBuffer(Figuren[i].posy[k],sizeof(Figuren[i].posy[k]));
      end;
        Filestream.ReadBuffer(Figuren[i].gesamtlaenge,sizeof(Figuren[i].gesamtlaenge));
    end;
// Ende Figurendaten
// Einfache-, Bewegungs- und Audioszenen, sowie Befehle öffnen
   	  Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(Einfacheszenen,Count);
      for i:=0 to Count-1 do
        Filestream.ReadBuffer(Einfacheszenen[i],sizeof(Einfacheszenen[i]));

   	  Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(DeviceScenes,Count);
      for i:=0 to length(DeviceScenes)-1 do
    	begin
        Filestream.ReadBuffer(DeviceScenes[i].ID,sizeof(DeviceScenes[i].ID));
        Filestream.ReadBuffer(DeviceScenes[i].Name,sizeof(DeviceScenes[i].Name));
        Filestream.ReadBuffer(DeviceScenes[i].Beschreibung,sizeof(DeviceScenes[i].Beschreibung));
        Filestream.ReadBuffer(DeviceScenes[i].Fadetime,sizeof(DeviceScenes[i].Fadetime));
        Filestream.ReadBuffer(DeviceScenes[i].Category,sizeof(DeviceScenes[i].Category));
     	  Filestream.ReadBuffer(Count2,sizeof(Count2));
        setlength(DeviceScenes[i].Devices,Count2);
        for j:=0 to Count2-1 do
        begin
          Filestream.ReadBuffer(DeviceScenes[i].Devices[j].ID,sizeof(DeviceScenes[i].Devices[j].ID));
       	  Filestream.ReadBuffer(Count3,sizeof(Count3));
          setlength(DeviceScenes[i].Devices[j].ChanActive,Count3);
          for k:=0 to Count3-1 do
            Filestream.ReadBuffer(DeviceScenes[i].Devices[j].ChanActive[k],sizeof(DeviceScenes[i].Devices[j].ChanActive[k]));

       	  Filestream.ReadBuffer(Count3,sizeof(Count3));
          setlength(DeviceScenes[i].Devices[j].ChanValue,Count3);
          for k:=0 to Count3-1 do
            Filestream.ReadBuffer(DeviceScenes[i].Devices[j].ChanValue[k],sizeof(DeviceScenes[i].Devices[j].ChanValue[k]));

       	  Filestream.ReadBuffer(Count3,sizeof(Count3));
          setlength(DeviceScenes[i].Devices[j].ChanActiveRandom,Count3);
          for k:=0 to Count3-1 do
            Filestream.ReadBuffer(DeviceScenes[i].Devices[j].ChanActiveRandom[k],sizeof(DeviceScenes[i].Devices[j].ChanActiveRandom[k]));

       	  Filestream.ReadBuffer(Count3,sizeof(Count3));
          setlength(DeviceScenes[i].Devices[j].ChanValueRandom,Count3);
          for k:=0 to Count3-1 do
            Filestream.ReadBuffer(DeviceScenes[i].Devices[j].ChanValueRandom[k],sizeof(DeviceScenes[i].Devices[j].ChanValueRandom[k]));

       	  Filestream.ReadBuffer(Count3,sizeof(Count3));
          setlength(DeviceScenes[i].Devices[j].ChanDelay,Count3);
          for k:=0 to Count3-1 do
            Filestream.ReadBuffer(DeviceScenes[i].Devices[j].ChanDelay[k],sizeof(DeviceScenes[i].Devices[j].ChanDelay[k]));

       	  Filestream.ReadBuffer(Count3,sizeof(Count3));
          setlength(DeviceScenes[i].Devices[j].ChanFadetime,Count3);
          for k:=0 to Count3-1 do
            Filestream.ReadBuffer(DeviceScenes[i].Devices[j].ChanFadetime[k],sizeof(DeviceScenes[i].Devices[j].ChanFadetime[k]));
        end;
      end;

   	  Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(Audioszenen,Count);
      setlength(AudioszenenCHAN,Count);
      for i:=0 to Count-1 do
        Filestream.ReadBuffer(Audioszenen[i],sizeof(Audioszenen[i]));

   	  Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(Bewegungsszenen,Count);
      setlength(BewegungsszenenZeit,Count);
      setlength(BewegungsszenenAktiv,Count);
      for i:=0 to Count-1 do
      begin
          Filestream.ReadBuffer(Bewegungsszenen[i].ID,sizeof(Bewegungsszenen[i].ID));
          Filestream.ReadBuffer(Bewegungsszenen[i].Name,sizeof(Bewegungsszenen[i].Name));
          Filestream.ReadBuffer(Bewegungsszenen[i].Beschreibung,sizeof(Bewegungsszenen[i].Beschreibung));
          Filestream.ReadBuffer(Bewegungsszenen[i].figur,sizeof(Bewegungsszenen[i].figur));
          Filestream.ReadBuffer(Bewegungsszenen[i].dauer,sizeof(Bewegungsszenen[i].dauer));
          Filestream.ReadBuffer(Bewegungsszenen[i].dontfade,sizeof(Bewegungsszenen[i].dontfade));
          Filestream.ReadBuffer(Bewegungsszenen[i].repeats,sizeof(Bewegungsszenen[i].repeats));
          Filestream.ReadBuffer(Bewegungsszenen[i].identischespurgeschwidigkeit,sizeof(Bewegungsszenen[i].identischespurgeschwidigkeit));
          Filestream.ReadBuffer(Bewegungsszenen[i].startpositionrelativ,sizeof(Bewegungsszenen[i].startpositionrelativ));
          Filestream.ReadBuffer(Bewegungsszenen[i].Category,sizeof(Bewegungsszenen[i].Category));
     	    Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(Bewegungsszenen[i].Devices,Count2);
          setlength(BewegungsszenenZeit[i],Count2);
          setlength(BewegungsszenenAktiv[i].Zeit,Count2);
          setlength(BewegungsszenenAktiv[i].Position,Count2);
          for j:=0 to Count2-1 do
          begin
            Filestream.ReadBuffer(Bewegungsszenen[i].Devices[j].ID,sizeof(Bewegungsszenen[i].Devices[j].ID));

            Filestream.ReadBuffer(Count3,sizeof(Count3));
            setlength(BewegungsszenenZeit[i][j],Count3);
            setlength(Bewegungsszenen[i].Devices[j].DeviceChannel,Count3);
            setlength(Bewegungsszenen[i].Devices[j].Szenen,Count3);
            setlength(BewegungsszenenAktiv[i].Zeit[j],Count3);
            setlength(BewegungsszenenAktiv[i].Position[j],Count3);
            for k:=0 to Count3-1 do
            begin
              Filestream.ReadBuffer(Bewegungsszenen[i].Devices[j].DeviceChannel[k],sizeof(Bewegungsszenen[i].Devices[j].DeviceChannel[k]));

              Filestream.ReadBuffer(Count4,sizeof(Count4));
              setlength(Bewegungsszenen[i].Devices[j].Szenen[k],Count4);
              for l:=0 to Count4-1 do
              begin
                Filestream.ReadBuffer(Bewegungsszenen[i].Devices[j].Szenen[k][l],sizeof(Bewegungsszenen[i].Devices[j].Szenen[k][l]));
              end;
            end;
          end;
      end;

      Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(Befehle2,Count);
      for k:=0 to Count-1 do
      begin
        Filestream.ReadBuffer(Befehle2[k].ID,sizeof(Befehle2[k].ID));
        Filestream.ReadBuffer(Befehle2[k].Typ,sizeof(Befehle2[k].Typ));
        Filestream.ReadBuffer(Befehle2[k].Name,sizeof(Befehle2[k].Name));
        Filestream.ReadBuffer(Befehle2[k].Beschreibung,sizeof(Befehle2[k].Beschreibung));
        Filestream.ReadBuffer(Befehle2[k].OnValue,sizeof(Befehle2[k].OnValue));
        Filestream.ReadBuffer(Befehle2[k].OffValue,sizeof(Befehle2[k].OffValue));
        Filestream.ReadBuffer(Befehle2[k].RunOnProjectLoad,sizeof(Befehle2[k].RunOnProjectLoad));
        Filestream.ReadBuffer(Befehle2[k].Category,sizeof(Befehle2[k].Category));
        Filestream.ReadBuffer(Count,sizeof(Count));
        setlength(Befehle2[k].ArgInteger,Count2);
        for j:=0 to Count2-1 do
        begin
          Filestream.ReadBuffer(Befehle2[k].ArgInteger[j],sizeof(Befehle2[k].ArgInteger[j]));
        end;
        Filestream.ReadBuffer(Count,sizeof(Count));
        setlength(Befehle2[k].ArgString,Count2);
        for j:=0 to Count2-1 do
        begin
          Filestream.ReadBuffer(Befehle2[k].ArgString[j],sizeof(Befehle2[k].ArgString[j]));
        end;
        Filestream.ReadBuffer(Count,sizeof(Count));
        setlength(Befehle2[k].ArgGUID,Count2);
        for j:=0 to Count2-1 do
        begin
          Filestream.ReadBuffer(Befehle2[k].ArgGUID[j],sizeof(Befehle2[k].ArgGUID[j]));
        end;
      end;

   	  Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(Kompositionsszenen,Count);
      for i:=0 to Count-1 do
      begin
        Filestream.ReadBuffer(Kompositionsszenen[i].ID,sizeof(Kompositionsszenen[i].ID));
        Filestream.ReadBuffer(Kompositionsszenen[i].Name,sizeof(Kompositionsszenen[i].Name));
        Filestream.ReadBuffer(Kompositionsszenen[i].Beschreibung,sizeof(Kompositionsszenen[i].Beschreibung));
        Filestream.ReadBuffer(Kompositionsszenen[i].Category,sizeof(Kompositionsszenen[i].Category));
        Filestream.ReadBuffer(Count2, sizeof(Count2));
        setlength(Kompositionsszenen[i].IDs, Count2);
        setlength(Kompositionsszenen[i].StopScene, Count2);
        for k:=0 to Count2-1 do
        begin
          Filestream.ReadBuffer(Kompositionsszenen[i].IDs[k],sizeof(Kompositionsszenen[i].IDs[k]));
          Filestream.ReadBuffer(Kompositionsszenen[i].StopScene[k],sizeof(Kompositionsszenen[i].StopScene[k]));
        end;
      end;

   	  Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(DevicePresets,Count);
      for i:=0 to length(DevicePresets)-1 do
    	begin
        Filestream.ReadBuffer(DevicePresets[i].ID,sizeof(DevicePresets[i].ID));
        Filestream.ReadBuffer(DevicePresets[i].Name,sizeof(DevicePresets[i].Name));
        Filestream.ReadBuffer(DevicePresets[i].Beschreibung,sizeof(DevicePresets[i].Beschreibung));
        Filestream.ReadBuffer(DevicePresets[i].Category,sizeof(DevicePresets[i].Category));
    	  Filestream.ReadBuffer(Count2,sizeof(Count2));
        setlength(DevicePresets[i].ChanTyp,Count2);
        setlength(DevicePresets[i].ChanValue,Count2);
        setlength(DevicePresets[i].ChanActive,Count2);
        for k:=0 to length(DevicePresets[i].ChanTyp)-1 do
        begin
          Filestream.ReadBuffer(DevicePresets[i].ChanTyp[k],sizeof(DevicePresets[i].ChanTyp[k]));
          Filestream.ReadBuffer(DevicePresets[i].ChanValue[k],sizeof(DevicePresets[i].ChanValue[k]));
          Filestream.ReadBuffer(DevicePresets[i].ChanActive[k],sizeof(DevicePresets[i].ChanActive[k]));
        end;
        Filestream.ReadBuffer(mainform.DevicePresets[i].UseNewInterface,sizeof(mainform.DevicePresets[i].UseNewInterface));
        Filestream.ReadBuffer(mainform.DevicePresets[i].Color,sizeof(mainform.DevicePresets[i].Color));
        Filestream.ReadBuffer(mainform.DevicePresets[i].Shutter,sizeof(mainform.DevicePresets[i].Shutter));
        Filestream.ReadBuffer(mainform.DevicePresets[i].Dimmer,sizeof(mainform.DevicePresets[i].Dimmer));
        Filestream.ReadBuffer(mainform.DevicePresets[i].Iris,sizeof(mainform.DevicePresets[i].Iris));
        Filestream.ReadBuffer(mainform.DevicePresets[i].Focus,sizeof(mainform.DevicePresets[i].Focus));
        Filestream.ReadBuffer(mainform.DevicePresets[i].PrismaRot,sizeof(mainform.DevicePresets[i].PrismaRot));
        Filestream.ReadBuffer(mainform.DevicePresets[i].PrismaEnabled,sizeof(mainform.DevicePresets[i].PrismaEnabled));
        Filestream.ReadBuffer(mainform.DevicePresets[i].Strobe,sizeof(mainform.DevicePresets[i].Strobe));
        Filestream.ReadBuffer(mainform.DevicePresets[i].Pan,sizeof(mainform.DevicePresets[i].Pan));
        Filestream.ReadBuffer(mainform.DevicePresets[i].Tilt,sizeof(mainform.DevicePresets[i].Tilt));
        Filestream.ReadBuffer(mainform.DevicePresets[i].PanFine,sizeof(mainform.DevicePresets[i].PanFine));
        Filestream.ReadBuffer(mainform.DevicePresets[i].TiltFine,sizeof(mainform.DevicePresets[i].TiltFine));
        Filestream.ReadBuffer(mainform.DevicePresets[i].Gobo,sizeof(mainform.DevicePresets[i].Gobo));
        Filestream.ReadBuffer(mainform.DevicePresets[i].GoboRot1,sizeof(mainform.DevicePresets[i].GoboRot1));
        Filestream.ReadBuffer(mainform.DevicePresets[i].GoboRot2,sizeof(mainform.DevicePresets[i].GoboRot2));
      end;

   	  Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(autoszenen,Count);
      for i:=0 to length(autoszenen)-1 do
    	begin
        Filestream.ReadBuffer(autoszenen[i].ID,sizeof(autoszenen[i].ID));
        Filestream.ReadBuffer(autoszenen[i].Name,sizeof(autoszenen[i].Name));
        Filestream.ReadBuffer(autoszenen[i].Beschreibung,sizeof(autoszenen[i].Beschreibung));
        Filestream.ReadBuffer(autoszenen[i].fadetime,sizeof(autoszenen[i].fadetime));
        Filestream.ReadBuffer(autoszenen[i].R,sizeof(autoszenen[i].R));
        Filestream.ReadBuffer(autoszenen[i].G,sizeof(autoszenen[i].G));
        Filestream.ReadBuffer(autoszenen[i].B,sizeof(autoszenen[i].B));
        Filestream.ReadBuffer(autoszenen[i].accuracy,sizeof(autoszenen[i].accuracy));
        Filestream.ReadBuffer(autoszenen[i].helligkeit,sizeof(autoszenen[i].helligkeit));
        Filestream.ReadBuffer(autoszenen[i].Category,sizeof(autoszenen[i].Category));
      end;

	  Filestream.ReadBuffer(Count,sizeof(Count));
    setlength(mainform.MediaCenterSzenen,Count);
    for i:=0 to Count-1 do
    begin
   	  Filestream.ReadBuffer(mainform.MediaCenterSzenen[i].ID,sizeof(mainform.MediaCenterSzenen[i].ID));
   	  Filestream.ReadBuffer(mainform.MediaCenterSzenen[i].Name,sizeof(mainform.MediaCenterSzenen[i].Name));
   	  Filestream.ReadBuffer(mainform.MediaCenterSzenen[i].Beschreibung,sizeof(mainform.MediaCenterSzenen[i].Beschreibung));
   	  Filestream.ReadBuffer(mainform.MediaCenterSzenen[i].Adresse,sizeof(mainform.MediaCenterSzenen[i].Adresse));
   	  Filestream.ReadBuffer(mainform.MediaCenterSzenen[i].Port,sizeof(mainform.MediaCenterSzenen[i].Port));
   	  Filestream.ReadBuffer(mainform.MediaCenterSzenen[i].Befehl,sizeof(mainform.MediaCenterSzenen[i].Befehl));
   	  Filestream.ReadBuffer(mainform.MediaCenterSzenen[i].Data1,sizeof(mainform.MediaCenterSzenen[i].Data1));
   	  Filestream.ReadBuffer(mainform.MediaCenterSzenen[i].Data2,sizeof(mainform.MediaCenterSzenen[i].Data2));
   	  Filestream.ReadBuffer(mainform.MediaCenterSzenen[i].Text,sizeof(mainform.MediaCenterSzenen[i].Text));
   	  Filestream.ReadBuffer(mainform.MediaCenterSzenen[i].Category,sizeof(mainform.MediaCenterSzenen[i].Category));
    end;

	  Filestream.ReadBuffer(Count,sizeof(Count));
    setlength(mainform.PluginSzenen,Count);
    for i:=0 to Count-1 do
    begin
   	  Filestream.ReadBuffer(mainform.PluginSzenen[i].ID,sizeof(mainform.PluginSzenen[i].ID));
   	  Filestream.ReadBuffer(mainform.PluginSzenen[i].Name,sizeof(mainform.PluginSzenen[i].Name));
   	  Filestream.ReadBuffer(mainform.PluginSzenen[i].Category,sizeof(mainform.PluginSzenen[i].Category));
    end;

    FileStream.Free;
  end;
  FormShow(nil);
end;

procedure Tszenenverwaltungform.Kompositionsszene1Click(Sender: TObject);
var
  i:integer;
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

  setlength(kompositionsszeneeditor_array,length(kompositionsszeneeditor_array)+1);
  kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1]:=Tkompositionsszeneeditor.Create(self);
//  setlength(AktuelleKompositionsszene,length(AktuelleKompositionsszene)+1);

  kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].Edit1.Text:=_('Neue Kombinationsszene');
  kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].Edit2.Text:='';
  kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].ListBox1.Clear;
  kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.Name:=_('Neue Kombinationsszene');
  kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.Beschreibung:='';
  setlength(kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.IDs,0);
  setlength(kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.StopScene,0);

  kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].showmodal;

  if kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].ModalResult=mrOK then
  begin
    setlength(mainform.Kompositionsszenen,length(mainform.Kompositionsszenen)+1);
    CreateGUID(NewGUID);
    mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].ID:=NewGUID;
    positionselection:=mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].ID;
    mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].Name:=kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.Name;
    mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].Beschreibung:=kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.Beschreibung;
    setlength(mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].IDs,length(kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.IDs));
    setlength(mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].StopScene,length(kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.IDs));
    for i:=0 to length(kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.IDs)-1 do
    begin
      mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].IDs[i]:=kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.IDs[i];
      mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].StopScene[i]:=kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].AktuelleKompositionsszene.StopScene[i];
    end;

    TempNode:=VST.AddChild(VSTRootNodes[5]);
    Data:=VST.GetNodeData(TempNode);
    Data^.NodeType:=5;
    Data^.IsRootNode:=false;
    Data^.IsCatNode:=false;
    Data^.Caption:=mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].Name;
    Data^.Beschreibung:=mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].Beschreibung;
    Data^.Fadetime:='';
    Data^.ID:=mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].ID;
    VST.Expanded[TempNode]:=true;
    VST.Expanded[TempNode.Parent]:=true;
    VST.Selected[TempNode]:=true;
    VST.FocusedNode:=TempNode;

    // noch schnell die Einträge alphabetisch sortieren
    VST.Sort(VSTRootNodes[5], 0, sdAscending);
  end;

//  setlength(AktuelleKompositionsszene,length(AktuelleKompositionsszene)-1);
  kompositionsszeneeditor_array[length(kompositionsszeneeditor_array)-1].Free;
  setlength(kompositionsszeneeditor_array,length(kompositionsszeneeditor_array)-1);
end;

procedure Tszenenverwaltungform.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tszenenverwaltungform.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text='' then
  begin
    Edit1.Text:=_('Suchtext hier eingeben...');
    Edit1.Font.Color:=clGray;
  end;
end;

procedure Tszenenverwaltungform.Edit1Enter(Sender: TObject);
begin
  if Edit1.text=_('Suchtext hier eingeben...') then
  begin
    Edit1.Text:='';
    Edit1.Font.Color:=clBlack;
  end;
end;

procedure Tszenenverwaltungform.Button3Click(Sender: TObject);
begin
  VST.FullExpand(nil);
end;

procedure Tszenenverwaltungform.Button4Click(Sender: TObject);
begin
  VST.FullCollapse(nil);
end;

procedure Tszenenverwaltungform.Button5Click(Sender: TObject);
var
  i,j,k,m,n,position:integer;
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

  position:=-1;

  if VST.SelectedCount=0 then exit;

  TempNode:=VST.GetFirst;

  while Assigned(TempNode) do
  begin
    if VST.Selected[TempNode] then
    begin
      Data:=VST.GetNodeData(TempNode);
      if not ((Data^.IsRootNode) or (Data^.IsCatNode)) then
      begin
        if not Effektmodus then
        begin
          case Data^.NodeType of
            0: // Einfache Szene
            begin
              for k:=0 to length(mainform.Einfacheszenen)-1 do
              begin
                if IsEqualGUID(mainform.Einfacheszenen[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;
              setlength(mainform.Einfacheszenen,length(mainform.Einfacheszenen)+1);
              mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1]:=mainform.Einfacheszenen[position];
              mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].Name:=mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].Name+_(' - Kopie');
              CreateGUID(NewGUID);
              mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].ID:=NewGuid;
              positionselection:=mainform.einfacheszenen[length(mainform.Einfacheszenen)-1].ID;

              TempNode:=VST.AddChild(VSTRootNodes[0]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=0;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].Name;
              Data^.Beschreibung:=mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].ID, 'time');
              Data^.ID:=mainform.Einfacheszenen[length(mainform.Einfacheszenen)-1].ID;
              VST.Sort(VSTRootNodes[0], 0, sdAscending);
            end;

            1: // Geräteszene
            begin
              for k:=0 to length(mainform.DeviceScenes)-1 do
              begin
                if IsEqualGUID(mainform.DeviceScenes[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;
              setlength(mainform.DeviceScenes,length(mainform.DeviceScenes)+1);
              CreateGUID(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].ID);
              mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Name:=mainform.DeviceScenes[position].Name+_(' - Kopie');
              mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Beschreibung:=mainform.DeviceScenes[position].Beschreibung;
              mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Fadetime:=mainform.DeviceScenes[position].Fadetime;
              mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Category:=mainform.DeviceScenes[position].Category;

              setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices,length(mainform.DeviceScenes[position].Devices));
              for i:=0 to length(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices)-1 do
              begin
                mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ID:=mainform.DeviceScenes[position].Devices[i].ID;
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanActive,length(mainform.DeviceScenes[position].Devices[i].ChanActive));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanValue,length(mainform.DeviceScenes[position].Devices[i].ChanValue));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanActiveRandom,length(mainform.DeviceScenes[position].Devices[i].ChanActiveRandom));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanValueRandom,length(mainform.DeviceScenes[position].Devices[i].ChanValueRandom));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanDelay,length(mainform.DeviceScenes[position].Devices[i].ChanDelay));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanFadetime,length(mainform.DeviceScenes[position].Devices[i].ChanFadetime));

                for j:=0 to length(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanActive)-1 do
                begin
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanActive[j]:=mainform.DeviceScenes[position].Devices[i].ChanActive[j];
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanValue[j]:=mainform.DeviceScenes[position].Devices[i].ChanValue[j];
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanActiveRandom[j]:=mainform.DeviceScenes[position].Devices[i].ChanActiveRandom[j];
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanValueRandom[j]:=mainform.DeviceScenes[position].Devices[i].ChanValueRandom[j];
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanDelay[j]:=mainform.DeviceScenes[position].Devices[i].ChanDelay[j];
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Devices[i].ChanFadetime[j]:=mainform.DeviceScenes[position].Devices[i].ChanFadetime[j];
                end;
              end;

              setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle,length(mainform.DeviceScenes[position].Befehle));
              setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte,length(mainform.DeviceScenes[position].Befehlswerte));
              for i:=0 to length(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle)-1 do
              begin
    //            mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ID:=mainform.DeviceScenes[position].Befehle[i].ID;
                CreateGUID(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ID);
                mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].Typ:=mainform.DeviceScenes[position].Befehle[i].Typ;
                mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].Name:=mainform.DeviceScenes[position].Befehle[i].Name;
                mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].Beschreibung:=mainform.DeviceScenes[position].Befehle[i].Beschreibung;
                mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].OnValue:=mainform.DeviceScenes[position].Befehle[i].OnValue;
                mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].OffValue:=mainform.DeviceScenes[position].Befehle[i].OffValue;
                mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ScaleValue:=mainform.DeviceScenes[position].Befehle[i].ScaleValue;
                mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].SwitchValue:=mainform.DeviceScenes[position].Befehle[i].SwitchValue;
                mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].InvertSwitchValue:=mainform.DeviceScenes[position].Befehle[i].InvertSwitchValue;

                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgInteger, length(mainform.DeviceScenes[position].Befehle[i].ArgInteger));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgString, length(mainform.DeviceScenes[position].Befehle[i].ArgString));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgGUID, length(mainform.DeviceScenes[position].Befehle[i].ArgGUID));
                for j:=0 to length(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgInteger)-1 do
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgInteger[j]:=mainform.DeviceScenes[position].Befehle[i].ArgInteger[j];
                for j:=0 to length(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgString)-1 do
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgString[j]:=mainform.DeviceScenes[position].Befehle[i].ArgString[j];
                for j:=0 to length(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgGUID)-1 do
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgGUID[j]:=mainform.DeviceScenes[position].Befehle[i].ArgGUID[j];

                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanActive, length(mainform.devicescenes[position].Befehlswerte[i].ChanActive));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanValue, length(mainform.devicescenes[position].Befehlswerte[i].ChanValue));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanActiveRandom, length(mainform.devicescenes[position].Befehlswerte[i].ChanActiveRandom));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanValueRandom, length(mainform.devicescenes[position].Befehlswerte[i].ChanValueRandom));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanDelay, length(mainform.devicescenes[position].Befehlswerte[i].ChanDelay));
                setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanFadetime, length(mainform.devicescenes[position].Befehlswerte[i].ChanFadetime));
                for k:=0 to length(mainform.devicescenes[position].Befehlswerte[i].ChanActive)-1 do
                begin
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanActive[k]:=mainform.devicescenes[position].Befehlswerte[i].ChanActive[k];
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanValue[k]:=mainform.devicescenes[position].Befehlswerte[i].ChanValue[k];
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanActiveRAndom[k]:=mainform.devicescenes[position].Befehlswerte[i].ChanActiveRandom[k];
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanValueRandom[k]:=mainform.devicescenes[position].Befehlswerte[i].ChanValueRandom[k];
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanDelay[k]:=mainform.devicescenes[position].Befehlswerte[i].ChanDelay[k];
                  mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanFadetime[k]:=mainform.devicescenes[position].Befehlswerte[i].ChanFadetime[k];
                end;
              end;

              positionselection:=mainform.DeviceScenes[length(mainform.DeviceScenes)-1].ID;

              TempNode:=VST.AddChild(VSTRootNodes[1]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=1;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Name;
              Data^.Beschreibung:=mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].ID, 'time');
              Data^.ID:=mainform.DeviceScenes[length(mainform.DeviceScenes)-1].ID;
              VST.Sort(VSTRootNodes[1], 0, sdAscending);
            end;

            2: // Audioszene
            begin
              for k:=0 to length(mainform.Audioszenen)-1 do
              begin
                if IsEqualGUID(mainform.Audioszenen[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;
              setlength(mainform.Audioszenen,length(mainform.Audioszenen)+1);
              setlength(mainform.AudioszenenCHAN,length(mainform.AudioszenenCHAN)+1);
              CreateGUID(NewGUID);
              mainform.Audioszenen[length(mainform.Audioszenen)-1].ID:=NewGuid;
              positionselection:=mainform.Audioszenen[length(mainform.Audioszenen)-1].ID;
              mainform.Audioszenen[length(mainform.Audioszenen)-1].Name:=mainform.Audioszenen[k].Name+_(' - Kopie');
              mainform.Audioszenen[length(mainform.Audioszenen)-1].Beschreibung:=mainform.Audioszenen[k].Beschreibung;
              mainform.Audioszenen[length(mainform.Audioszenen)-1].Datei:=mainform.Audioszenen[k].Datei;
              mainform.Audioszenen[length(mainform.Audioszenen)-1].Dauer:=mainform.Audioszenen[k].Dauer;
              mainform.Audioszenen[length(mainform.Audioszenen)-1].Volume:=mainform.Audioszenen[k].Volume;
              mainform.Audioszenen[length(mainform.Audioszenen)-1].FadeinTime:=mainform.Audioszenen[k].FadeinTime;
              mainform.Audioszenen[length(mainform.Audioszenen)-1].FadeoutTime:=mainform.Audioszenen[k].FadeoutTime;
              mainform.Audioszenen[length(mainform.Audioszenen)-1].Category:=mainform.Audioszenen[k].Category;

              for i:=0 to 7 do
              begin
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[0][i]:=mainform.Audioszenen[k].matrix[0][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[1][i]:=mainform.Audioszenen[k].matrix[1][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[2][i]:=mainform.Audioszenen[k].matrix[2][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[3][i]:=mainform.Audioszenen[k].matrix[3][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[4][i]:=mainform.Audioszenen[k].matrix[4][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[5][i]:=mainform.Audioszenen[k].matrix[5][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[6][i]:=mainform.Audioszenen[k].matrix[6][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix[7][i]:=mainform.Audioszenen[k].matrix[7][i];
              end;

              for i:=0 to 7 do
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix1[i]:=mainform.Audioszenen[k].matrix1[i];

              for i:=0 to 1 do
              begin
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix2[0][i]:=mainform.Audioszenen[k].matrix2[0][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix2[1][i]:=mainform.Audioszenen[k].matrix2[1][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix2[2][i]:=mainform.Audioszenen[k].matrix2[2][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix2[3][i]:=mainform.Audioszenen[k].matrix2[3][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix2[4][i]:=mainform.Audioszenen[k].matrix2[4][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix2[5][i]:=mainform.Audioszenen[k].matrix2[5][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix2[6][i]:=mainform.Audioszenen[k].matrix2[6][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix2[7][i]:=mainform.Audioszenen[k].matrix2[7][i];
              end;
              for i:=0 to 3 do
              begin
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix4[0][i]:=mainform.Audioszenen[k].matrix4[0][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix4[1][i]:=mainform.Audioszenen[k].matrix4[1][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix4[2][i]:=mainform.Audioszenen[k].matrix4[2][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix4[3][i]:=mainform.Audioszenen[k].matrix4[3][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix4[4][i]:=mainform.Audioszenen[k].matrix4[4][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix4[5][i]:=mainform.Audioszenen[k].matrix4[5][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix4[6][i]:=mainform.Audioszenen[k].matrix4[6][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix4[7][i]:=mainform.Audioszenen[k].matrix4[7][i];
              end;
              for i:=0 to 5 do
              begin
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix6[0][i]:=mainform.Audioszenen[k].matrix6[0][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix6[1][i]:=mainform.Audioszenen[k].matrix6[1][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix6[2][i]:=mainform.Audioszenen[k].matrix6[2][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix6[3][i]:=mainform.Audioszenen[k].matrix6[3][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix6[4][i]:=mainform.Audioszenen[k].matrix6[4][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix6[5][i]:=mainform.Audioszenen[k].matrix6[5][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix6[6][i]:=mainform.Audioszenen[k].matrix6[6][i];
                mainform.Audioszenen[length(mainform.Audioszenen)-1].matrix6[7][i]:=mainform.Audioszenen[k].matrix6[7][i];
              end;

              for i:=0 to 7 do
                mainform.Audioszenen[length(mainform.Audioszenen)-1].Kanalsettings[i]:=mainform.Audioszenen[k].Kanalsettings[i];

              TempNode:=VST.AddChild(VSTRootNodes[2]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=2;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.Audioszenen[length(mainform.Audioszenen)-1].Name;
              Data^.Beschreibung:=mainform.Audioszenen[length(mainform.Audioszenen)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Audioszenen[length(mainform.Audioszenen)-1].ID, 'time');
              Data^.ID:=mainform.Audioszenen[length(mainform.Audioszenen)-1].ID;
              VST.Sort(VSTRootNodes[2], 0, sdAscending);
            end;

            3: // Bewegungsszene
            begin
              for k:=0 to length(mainform.Bewegungsszenen)-1 do
              begin
                if IsEqualGUID(mainform.Bewegungsszenen[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              setlength(mainform.Bewegungsszenen,length(mainform.Bewegungsszenen)+1);
              setlength(mainform.BewegungsszenenAktiv,length(mainform.Bewegungsszenen));
              setlength(mainform.BewegungsszenenZeit,length(mainform.Bewegungsszenen));
              mainform.BewegungsszenenAktiv[length(mainform.BewegungsszenenAktiv)-1].Aktiv:=false;

              CreateGUID(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].ID);
              positionselection:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].ID;

              mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Name:=mainform.Bewegungsszenen[position].Name+_(' - Kopie');
              mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Beschreibung:=mainform.Bewegungsszenen[position].Beschreibung;
              mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Category:=mainform.Bewegungsszenen[position].Category;

              mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].figur:=mainform.Bewegungsszenen[position].figur;
              mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].dauer:=mainform.Bewegungsszenen[position].dauer;
              mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].repeats:=mainform.Bewegungsszenen[position].repeats;
              mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].identischespurgeschwidigkeit:=mainform.Bewegungsszenen[position].identischespurgeschwidigkeit;
              mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].startpositionrelativ:=mainform.Bewegungsszenen[position].startpositionrelativ;

              setlength(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices,length(mainform.Bewegungsszenen[position].Devices));
              setlength(mainform.BewegungsszenenAktiv[length(mainform.BewegungsszenenAktiv)-1].Zeit,length(mainform.BewegungsszenenAktiv[position].Zeit));
              setlength(mainform.BewegungsszenenAktiv[length(mainform.BewegungsszenenAktiv)-1].Position,length(mainform.BewegungsszenenAktiv[position].Position));
              setlength(mainform.BewegungsszenenZeit[length(mainform.BewegungsszenenZeit)-1],length(mainform.BewegungsszenenZeit[position]));

              for i:=0 to length(mainform.Bewegungsszenen[position].Devices)-1 do
              begin
                setlength(mainform.BewegungsszenenAktiv[length(mainform.Bewegungsszenen)-1].Zeit[i],length(mainform.BewegungsszenenAktiv[position].Zeit[i]));
                setlength(mainform.BewegungsszenenAktiv[length(mainform.Bewegungsszenen)-1].Position[i],length(mainform.BewegungsszenenAktiv[position].Position[i]));
                setlength(mainform.BewegungsszenenZeit[length(mainform.Bewegungsszenen)-1][i],length(mainform.BewegungsszenenZeit[position][i]));

                mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].ID:=mainform.Bewegungsszenen[position].Devices[i].ID;
                setlength(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].DeviceChannel,length(mainform.Bewegungsszenen[position].Devices[i].DeviceChannel));
                for j:=0 to length(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].DeviceChannel)-1 do
                begin
                  mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].DeviceChannel[j]:=mainform.Bewegungsszenen[position].Devices[i].DeviceChannel[j];
                end;

                setlength(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].Szenen,length(mainform.Bewegungsszenen[position].Devices[i].Szenen));
                for j:=0 to length(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].Szenen)-1 do
                begin
                  setlength(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].Szenen[j],length(mainform.Bewegungsszenen[position].Devices[i].Szenen[j]));
                  for k:=0 to length(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].Szenen[j])-1 do
                    mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Devices[i].Szenen[j][k]:=mainform.Bewegungsszenen[position].Devices[i].Szenen[j][k];
                end;
              end;

              TempNode:=VST.AddChild(VSTRootNodes[3]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=3;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Name;
              Data^.Beschreibung:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].ID, 'time');
              Data^.ID:=mainform.Bewegungsszenen[length(mainform.Bewegungsszenen)-1].ID;
              VST.Sort(VSTRootNodes[3], 0, sdAscending);
            end;

            4: // Befehl
            begin
              for k:=0 to length(mainform.Befehle2)-1 do
              begin
                if IsEqualGUID(mainform.Befehle2[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;

              setlength(mainform.Befehle2,length(mainform.Befehle2)+1);
              CreateGUID(mainform.Befehle2[length(mainform.Befehle2)-1].ID);
              mainform.Befehle2[length(mainform.Befehle2)-1].Typ:=mainform.Befehle2[position].Typ;
              mainform.Befehle2[length(mainform.Befehle2)-1].Name:=mainform.Befehle2[position].Name+_(' - Kopie');
              mainform.Befehle2[length(mainform.Befehle2)-1].Beschreibung:=mainform.Befehle2[position].Beschreibung;
              mainform.Befehle2[length(mainform.Befehle2)-1].OnValue:=mainform.Befehle2[position].OnValue;
              mainform.Befehle2[length(mainform.Befehle2)-1].OffValue:=mainform.Befehle2[position].OffValue;
              mainform.Befehle2[length(mainform.Befehle2)-1].RunOnProjectLoad:=mainform.Befehle2[position].RunOnProjectLoad;
              mainform.Befehle2[length(mainform.Befehle2)-1].Category:=mainform.Befehle2[position].Category;

              setlength(mainform.Befehle2[length(mainform.Befehle2)-1].ArgInteger, length(mainform.Befehle2[position].ArgInteger));
              setlength(mainform.Befehle2[length(mainform.Befehle2)-1].ArgString, length(mainform.Befehle2[position].ArgString));
              setlength(mainform.Befehle2[length(mainform.Befehle2)-1].ArgGUID, length(mainform.Befehle2[position].ArgGUID));

              for i:=0 to length(mainform.Befehle2[length(mainform.Befehle2)-1].ArgInteger)-1 do
                mainform.Befehle2[length(mainform.Befehle2)-1].ArgInteger[i]:=mainform.Befehle2[position].ArgInteger[i];
              for i:=0 to length(mainform.Befehle2[length(mainform.Befehle2)-1].ArgString)-1 do
                mainform.Befehle2[length(mainform.Befehle2)-1].ArgString[i]:=mainform.Befehle2[position].ArgString[i];
              for i:=0 to length(mainform.Befehle2[length(mainform.Befehle2)-1].ArgGUID)-1 do
                mainform.Befehle2[length(mainform.Befehle2)-1].ArgGUID[i]:=mainform.Befehle2[position].ArgGUID[i];

              positionselection:=mainform.Befehle2[length(mainform.Befehle2)-1].ID;

              TempNode:=VST.AddChild(VSTRootNodes[4]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=4;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.Befehle2[length(mainform.Befehle2)-1].Name;
              Data^.Beschreibung:=mainform.Befehle2[length(mainform.Befehle2)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Befehle2[length(mainform.Befehle2)-1].ID, 'time');
              Data^.ID:=mainform.Befehle2[length(mainform.Befehle2)-1].ID;
              VST.Sort(VSTRootNodes[4], 0, sdAscending);
            end;

            5: // Kombinationsszene
            begin
              for k:=0 to length(mainform.Kompositionsszenen)-1 do
              begin
                if IsEqualGUID(mainform.Kompositionsszenen[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;

              setlength(mainform.Kompositionsszenen,length(mainform.Kompositionsszenen)+1);
              CreateGUID(NewGUID);
              mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].ID:=NewGuid;
              mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].Name:=mainform.Kompositionsszenen[position].Name+_(' - Kopie');
              mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].Beschreibung:=mainform.Kompositionsszenen[position].Beschreibung;
              mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].Category:=mainform.Kompositionsszenen[position].Category;
              setlength(mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].IDs,length(mainform.Kompositionsszenen[position].IDs));
              setlength(mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].StopScene,length(mainform.Kompositionsszenen[position].IDs));
              for i:=0 to length(mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].IDs)-1 do
              begin
                mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].IDs[i]:=mainform.Kompositionsszenen[position].IDs[i];
                mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].StopScene[i]:=mainform.Kompositionsszenen[position].StopScene[i];
              end;
              positionselection:=mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].ID;

              TempNode:=VST.AddChild(VSTRootNodes[5]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=5;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].Name;
              Data^.Beschreibung:=mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].ID, 'time');
              Data^.ID:=mainform.Kompositionsszenen[length(mainform.Kompositionsszenen)-1].ID;
              VST.Sort(VSTRootNodes[5], 0, sdAscending);
            end;

            6: // Preset
            begin
              for k:=0 to length(mainform.DevicePresets)-1 do
              begin
                if IsEqualGUID(mainform.DevicePresets[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;

              setlength(mainform.DevicePresets,length(mainform.DevicePresets)+1);  //k
              CreateGUID(mainform.DevicePresets[length(mainform.DevicePresets)-1].ID);
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Name:=mainform.DevicePresets[position].Name+_(' - Kopie');
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Beschreibung:=mainform.DevicePresets[position].Beschreibung;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Category:=mainform.DevicePresets[position].Category;

              setlength(mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp,length(mainform.DevicePresets[position].ChanTyp));
              setlength(mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue,length(mainform.DevicePresets[position].ChanValue));
              setlength(mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive,length(mainform.DevicePresets[position].ChanActive));

              for i:=0 to length(mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp)-1 do
              begin
                mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[i]:=mainform.DevicePresets[position].ChanTyp[i];
                mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[i]:=mainform.DevicePresets[position].ChanValue[i];
                mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[i]:=mainform.DevicePresets[position].ChanActive[i];
              end;

              mainform.DevicePresets[length(mainform.DevicePresets)-1].UseNewInterface:=mainform.DevicePresets[position].UseNewInterface;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Color:=mainform.DevicePresets[position].Color;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Shutter:=mainform.DevicePresets[position].Shutter;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Dimmer:=mainform.DevicePresets[position].Dimmer;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Iris:=mainform.DevicePresets[position].Iris;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Focus:=mainform.DevicePresets[position].Focus;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].PrismaRot:=mainform.DevicePresets[position].PrismaRot;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].PrismaEnabled:=mainform.DevicePresets[position].PrismaEnabled;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Strobe:=mainform.DevicePresets[position].Strobe;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Pan:=mainform.DevicePresets[position].Pan;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Tilt:=mainform.DevicePresets[position].Tilt;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].PanFine:=mainform.DevicePresets[position].PanFine;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].TiltFine:=mainform.DevicePresets[position].TiltFine;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].Gobo:=mainform.DevicePresets[position].Gobo;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].GoboRot1:=mainform.DevicePresets[position].GoboRot1;
              mainform.DevicePresets[length(mainform.DevicePresets)-1].GoboRot2:=mainform.DevicePresets[position].GoboRot2;

              positionselection:=mainform.devicepresets[length(mainform.devicepresets)-1].ID;

              TempNode:=VST.AddChild(VSTRootNodes[6]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=6;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.DevicePresets[length(mainform.DevicePresets)-1].Name;
              Data^.Beschreibung:=mainform.DevicePresets[length(mainform.DevicePresets)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.DevicePresets[length(mainform.DevicePresets)-1].ID, 'time');
              Data^.ID:=mainform.DevicePresets[length(mainform.DevicePresets)-1].ID;
              VST.Sort(VSTRootNodes[6], 0, sdAscending);
            end;

            7: // Automatikszene kopieren
            begin
              for k:=0 to length(mainform.autoszenen)-1 do
              begin
                if IsEqualGUID(mainform.Autoszenen[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;

              setlength(mainform.autoszenen,length(mainform.autoszenen)+1);  //k
              CreateGUID(mainform.autoszenen[length(mainform.autoszenen)-1].ID);
              mainform.autoszenen[length(mainform.autoszenen)-1].Name:=mainform.autoszenen[position].Name+_(' - Kopie');
              mainform.autoszenen[length(mainform.autoszenen)-1].Beschreibung:=mainform.autoszenen[position].Beschreibung;
              mainform.autoszenen[length(mainform.autoszenen)-1].fadetime:=mainform.autoszenen[position].fadetime;
              mainform.autoszenen[length(mainform.autoszenen)-1].R:=mainform.autoszenen[position].R;
              mainform.autoszenen[length(mainform.autoszenen)-1].G:=mainform.autoszenen[position].G;
              mainform.autoszenen[length(mainform.autoszenen)-1].B:=mainform.autoszenen[position].B;
              mainform.autoszenen[length(mainform.autoszenen)-1].accuracy:=mainform.autoszenen[position].accuracy;
              mainform.autoszenen[length(mainform.autoszenen)-1].helligkeit:=mainform.autoszenen[position].helligkeit;
              mainform.autoszenen[length(mainform.autoszenen)-1].Category:=mainform.autoszenen[position].Category;

              positionselection:=mainform.autoszenen[length(mainform.autoszenen)-1].ID;

              TempNode:=VST.AddChild(VSTRootNodes[7]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=7;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.Autoszenen[length(mainform.Autoszenen)-1].Name;
              Data^.Beschreibung:=mainform.Autoszenen[length(mainform.Autoszenen)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Autoszenen[length(mainform.Autoszenen)-1].ID, 'time');
              Data^.ID:=mainform.Autoszenen[length(mainform.Autoszenen)-1].ID;
              VST.Sort(VSTRootNodes[7], 0, sdAscending);
            end;

            8: // Effekt kopieren
            begin
              for k:=0 to length(mainform.Effektsequenzereffekte)-1 do
              begin
                if IsEqualGUID(mainform.Effektsequenzereffekte[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;

              setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)+1);
              setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)+1);

              Effektsequenzer.CopyEffect(position, length(mainform.Effektsequenzereffekte)-1,false);
              mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Name:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Name+_(' - Kopie');
              mainform.EffectsChanged;

              positionselection:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].ID;

              TempNode:=VST.AddChild(VSTRootNodes[8]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=8;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Name;
              Data^.Beschreibung:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].ID, 'time');
              Data^.ID:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].ID;
              VST.Sort(VSTRootNodes[8], 0, sdAscending);
            end;

            9: // Mediacenter szene kopieren
            begin
              for k:=0 to length(mainform.mediacenterszenen)-1 do
              begin
                if IsEqualGUID(mainform.mediacenterszenen[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;

              setlength(mainform.mediacenterszenen,length(mainform.mediacenterszenen)+1);
              CreateGUID(mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].ID);
              mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Name:=mainform.mediacenterszenen[position].Name+_(' - Kopie');
              mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Beschreibung:=mainform.mediacenterszenen[position].Beschreibung;
              mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Befehl:=mainform.mediacenterszenen[position].Befehl;
              mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Data1:=mainform.mediacenterszenen[position].Data1;
              mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Data2:=mainform.mediacenterszenen[position].Data2;
              mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Text:=mainform.mediacenterszenen[position].Text;
              mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Category:=mainform.mediacenterszenen[position].Category;

              mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Adresse:=mainform.mediacenterszenen[position].Adresse;
              mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Port:=mainform.mediacenterszenen[position].Port;

              positionselection:=mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].ID;

              TempNode:=VST.AddChild(VSTRootNodes[9]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=9;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.MediaCenterSzenen[length(mainform.MediaCenterSzenen)-1].Name;
              Data^.Beschreibung:=mainform.MediaCenterSzenen[length(mainform.MediaCenterSzenen)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.MediaCenterSzenen[length(mainform.MediaCenterSzenen)-1].ID, 'time');
              Data^.ID:=mainform.MediaCenterSzenen[length(mainform.MediaCenterSzenen)-1].ID;
              VST.Sort(VSTRootNodes[9], 0, sdAscending);
            end;

            10: // Presetszenen
            begin
              for k:=0 to length(mainform.PresetScenes)-1 do
              begin
                if IsEqualGUID(mainform.PresetScenes[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;

              setlength(mainform.PresetScenes,length(mainform.PresetScenes)+1);  //k
              CreateGUID(mainform.PresetScenes[length(mainform.PresetScenes)-1].ID);
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Name:=mainform.PresetScenes[position].Name+_(' - Kopie');
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Beschreibung:=mainform.PresetScenes[position].Beschreibung;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Category:=mainform.PresetScenes[position].Category;

              setlength(mainform.PresetScenes[length(mainform.PresetScenes)-1].Devices,length(mainform.PresetScenes[position].Devices));

              for i:=0 to length(mainform.PresetScenes[length(mainform.PresetScenes)-1].Devices)-1 do
                mainform.PresetScenes[length(mainform.PresetScenes)-1].Devices[i]:=mainform.PresetScenes[position].Devices[i];

              mainform.PresetScenes[length(mainform.PresetScenes)-1].Color:=mainform.PresetScenes[position].Color;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Shutter:=mainform.PresetScenes[position].Shutter;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Dimmer:=mainform.PresetScenes[position].Dimmer;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Iris:=mainform.PresetScenes[position].Iris;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Focus:=mainform.PresetScenes[position].Focus;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].PrismaRot:=mainform.PresetScenes[position].PrismaRot;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].PrismaEnabled:=mainform.PresetScenes[position].PrismaEnabled;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Strobe:=mainform.PresetScenes[position].Strobe;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Pan:=mainform.PresetScenes[position].Pan;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Tilt:=mainform.PresetScenes[position].Tilt;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].PanFine:=mainform.PresetScenes[position].PanFine;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].TiltFine:=mainform.PresetScenes[position].TiltFine;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].Gobo:=mainform.PresetScenes[position].Gobo;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].GoboRot1:=mainform.PresetScenes[position].GoboRot1;
              mainform.PresetScenes[length(mainform.PresetScenes)-1].GoboRot2:=mainform.PresetScenes[position].GoboRot2;

              positionselection:=mainform.PresetScenes[length(mainform.PresetScenes)-1].ID;

              TempNode:=VST.AddChild(VSTRootNodes[10]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=10;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.PresetScenes[length(mainform.PresetScenes)-1].Name;
              Data^.Beschreibung:=mainform.PresetScenes[length(mainform.PresetScenes)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.PresetScenes[length(mainform.PresetScenes)-1].ID, 'time');
              Data^.ID:=mainform.PresetScenes[length(mainform.PresetScenes)-1].ID;
              VST.Sort(VSTRootNodes[10], 0, sdAscending);
            end;

            11: // Codeszenen
            begin
              for k:=0 to length(mainform.CodeScenes)-1 do
              begin
                if IsEqualGUID(mainform.CodeScenes[k].ID,Data^.ID) then
                begin
                  position:=k;
                  break;
                end;
              end;
              if position=-1 then exit;

              setlength(mainform.CodeScenes,length(mainform.CodeScenes)+1);  //k
              CreateGUID(mainform.CodeScenes[length(mainform.CodeScenes)-1].ID);
              mainform.CodeScenes[length(mainform.CodeScenes)-1].Name:=mainform.CodeScenes[position].Name+_(' - Kopie');
              mainform.CodeScenes[length(mainform.CodeScenes)-1].Beschreibung:=mainform.CodeScenes[position].Beschreibung;
              mainform.CodeScenes[length(mainform.CodeScenes)-1].Category:=mainform.CodeScenes[position].Category;

              mainform.CodeScenes[length(mainform.CodeScenes)-1].Code:=mainform.CodeScenes[position].Code;

              positionselection:=mainform.CodeScenes[length(mainform.CodeScenes)-1].ID;

              TempNode:=VST.AddChild(VSTRootNodes[11]);
              Data:=VST.GetNodeData(TempNode);
              Data^.NodeType:=11;
              Data^.IsRootNode:=false;
              Data^.IsCatNode:=false;
              Data^.Caption:=mainform.CodeScenes[length(mainform.CodeScenes)-1].Name;
              Data^.Beschreibung:=mainform.CodeScenes[length(mainform.CodeScenes)-1].Beschreibung;
              Data^.Fadetime:=mainform.GetSceneInfo2(mainform.CodeScenes[length(mainform.CodeScenes)-1].ID, 'time');
              Data^.ID:=mainform.CodeScenes[length(mainform.CodeScenes)-1].ID;
              VST.Sort(VSTRootNodes[11], 0, sdAscending);
            end;

            12: // Plugin szene kopieren
            begin
              ShowMessage(_('Pluginszenen können nur innerhalb des Host-Plugins kopiert werden.'));
            end;
          end;
        end else
        begin
          for k:=0 to length(mainform.Effektsequenzereffekte)-1 do
          begin
            if IsEqualGUID(mainform.Effektsequenzereffekte[k].ID,Data^.ID) then
            begin
              position:=k;
              break;
            end;
          end;
          if position=-1 then exit;

          setlength(mainform.Effektsequenzereffekte,length(mainform.Effektsequenzereffekte)+1);
          setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)+1);

          Effektsequenzer.CopyEffect(position, length(mainform.Effektsequenzereffekte)-1,false);
          mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Name:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].Name+_(' - Kopie');
          mainform.EffectsChanged;

          positionselection:=mainform.Effektsequenzereffekte[length(mainform.Effektsequenzereffekte)-1].ID;
        end;
      end;
      TempNode:=nil;
    end else
    begin
      TempNode:=VST.GetNext(TempNode);
    end;
  end;
end;

procedure Tszenenverwaltungform.SpeedButton3Click(Sender: TObject);
begin
  if messagedlg(_('Möchten Sie wirklich alle Szenen löschen?'),mtWarning,
    [mbYes,mbNo],0)=mrYes then
  begin
    with mainform do
    begin
      setlength(Einfacheszenen,0);

      setlength(Devicescenes, 0);

      setlength(Audioszenen,0);
      setlength(AudioszenenCHAN,0);

      setlength(Bewegungsszenen,0);
      setlength(BewegungsszenenZeit,0);
      setlength(BewegungsszenenAktiv,0);

      setlength(Befehle2, 0);
      setlength(OldBefehle,0);

      setlength(Kompositionsszenen,0);

      setlength(DevicePresets, 0);

      setlength(Autoszenen, 0);

      setlength(Mediacenterszenen, 0);
    end;
    FormShow(nil);
  end;
end;

procedure Tszenenverwaltungform.SpeedButton4Click(Sender: TObject);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if Assigned(Data) and (not (Data^.IsRootNode or Data^.IsCatNode)) then
    mainform.StartScene(Data^.ID, false, false);
end;

procedure Tszenenverwaltungform.SpeedButton5Click(Sender: TObject);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if Assigned(Data) and (not (Data^.IsRootNode or Data^.IsCatNode)) then
    mainform.StopScene(Data^.ID);
end;

procedure Tszenenverwaltungform.Preset1Click(Sender: TObject);
var
  i:integer;
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for i:=0 to preseteditor.CheckListBox1.Items.Count-1 do
    preseteditor.CheckListBox1.Checked[i]:=false;

  preseteditor.CheckState;
  preseteditor.Edit1.Text:=_('Neues Preset');
  preseteditor.Edit2.Text:='';

  for i:=0 to preseteditor.CheckListBox1.Items.Count-1 do
    preseteditor.CheckListBox1.checked[i]:=false;

  preseteditor.change(nil);

  preseteditor.PositionXY.Left:=(preseteditor.fadenkreuz.Width div 2)-(preseteditor.PositionXY.Width div 2);
  preseteditor.PositionXY.Top:=(preseteditor.fadenkreuz.Height div 2)-(preseteditor.PositionXY.Height div 2);
  preseteditor.moves.position:=0;
  preseteditor.speed.position:=0;
  preseteditor.gobo1.position:=0;
  preseteditor.gobo1rot.position:=0;
  preseteditor.gobo2.position:=0;
  preseteditor.gobo2rot.position:=0;
  preseteditor.gobo3.position:=0;
  preseteditor.goboextra.position:=0;
  preseteditor.color1.position:=0;
  preseteditor.color2.position:=0;
  preseteditor.r.position:=0;
  preseteditor.g.position:=0;
  preseteditor.b.position:=0;
  preseteditor.iris.position:=0;
  preseteditor.shutter.position:=0;
  preseteditor.dimmer.position:=0;
  preseteditor.zoom.position:=0;
  preseteditor.focus.position:=0;
  preseteditor.prism.position:=0;
  preseteditor.frost.position:=0;
  preseteditor.special1.position:=0;
  preseteditor.special2.position:=0;
  preseteditor.special3.position:=0;

  preseteditor.CheckBox1.Checked:=false;
  preseteditor.Panel2.visible:=false;
  preseteditor.Panel3.Visible:=true;
  preseteditor.groupbox3.visible:=false;
  preseteditor.groupbox2.height:=345;
  preseteditor.treeview1.height:=297;

  preseteditor.shuttercheck.state:=cbGrayed;
  preseteditor.prismacheck.Checked:=false;
  preseteditor.dimmerslider.position:=0;
  preseteditor.stroboslider.position:=0;
  preseteditor.irisslider.position:=0;
  preseteditor.fokusslider.position:=0;
  preseteditor.prismaslider.position:=127;
  preseteditor.goborot1slider.position:=127;
  preseteditor.goborot2slider.position:=127;
  preseteditor.PositionXY2.Top:=(preseteditor.fadenkreuz2.Height div 2)-(preseteditor.PositionXY2.Height div 2);
  preseteditor.PositionXY2.Left:=(preseteditor.fadenkreuz2.Width div 2)-(preseteditor.PositionXY2.Width div 2);
  preseteditor.colorpicker2.SelectedColor:=clRed;

  preseteditor.Showmodal;
  if preseteditor.ModalResult=mrOK then
  begin
    setlength(mainform.DevicePresets,length(mainform.DevicePresets)+1);
    CreateGUID(mainform.DevicePresets[length(mainform.DevicePresets)-1].ID);
    positionselection:=mainform.DevicePresets[length(mainform.DevicePresets)-1].ID;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].Name:=preseteditor.Edit1.Text;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].Beschreibung:=preseteditor.Edit2.Text;
    setlength(mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp,25);
    setlength(mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue,25);
    setlength(mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive,25);

    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[0]:='pan';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[0]:=preseteditor.CheckListBox1.checked[0];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[0]:=round(((preseteditor.PositionXY.Left+(preseteditor.PositionXY.Width/2))/preseteditor.Fadenkreuz.Width)*255);
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[1]:='tilt';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[1]:=preseteditor.CheckListBox1.checked[1];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[1]:=round(((preseteditor.PositionXY.Top+(preseteditor.PositionXY.Height/2))/preseteditor.Fadenkreuz.Height)*255);
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[2]:='moves';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[2]:=preseteditor.CheckListBox1.checked[2];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[2]:=preseteditor.moves.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[3]:='speed ';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[3]:=preseteditor.CheckListBox1.checked[3];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[3]:=preseteditor.speed.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[4]:='gobo1';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[4]:=preseteditor.CheckListBox1.checked[4];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[4]:=preseteditor.gobo1.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[5]:='gobo1rot';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[5]:=preseteditor.CheckListBox1.checked[5];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[5]:=preseteditor.gobo1rot.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[6]:='gobo2';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[6]:=preseteditor.CheckListBox1.checked[6];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[6]:=preseteditor.gobo2.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[7]:='gobo2rot';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[7]:=preseteditor.CheckListBox1.checked[7];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[7]:=preseteditor.gobo2rot.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[8]:='gobo3';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[8]:=preseteditor.CheckListBox1.checked[8];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[8]:=preseteditor.gobo3.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[9]:='goboextra';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[9]:=preseteditor.CheckListBox1.checked[9];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[9]:=preseteditor.goboextra.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[10]:='color1';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[10]:=preseteditor.CheckListBox1.checked[10];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[10]:=preseteditor.color1.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[11]:='color2';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[11]:=preseteditor.CheckListBox1.checked[11];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[11]:=preseteditor.color2.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[12]:='r';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[12]:=preseteditor.CheckListBox1.checked[12];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[12]:=preseteditor.r.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[13]:='g';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[13]:=preseteditor.CheckListBox1.checked[13];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[13]:=preseteditor.g.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[14]:='b';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[14]:=preseteditor.CheckListBox1.checked[14];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[14]:=preseteditor.b.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[15]:='iris';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[15]:=preseteditor.CheckListBox1.checked[15];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[15]:=preseteditor.iris.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[16]:='shutter';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[16]:=preseteditor.CheckListBox1.checked[16];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[16]:=preseteditor.shutter.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[17]:='dimmer';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[17]:=preseteditor.CheckListBox1.checked[17];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[17]:=preseteditor.dimmer.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[18]:='zoom';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[18]:=preseteditor.CheckListBox1.checked[18];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[18]:=preseteditor.zoom.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[19]:='focus';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[19]:=preseteditor.CheckListBox1.checked[19];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[19]:=preseteditor.focus.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[20]:='prism';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[20]:=preseteditor.CheckListBox1.checked[20];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[20]:=preseteditor.prism.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[21]:='frost';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[21]:=preseteditor.CheckListBox1.checked[21];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[21]:=preseteditor.frost.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[22]:='special1';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[22]:=preseteditor.CheckListBox1.checked[22];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[22]:=preseteditor.special1.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[23]:='special2';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[23]:=preseteditor.CheckListBox1.checked[23];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[23]:=preseteditor.special2.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanTyp[24]:='special3';
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanActive[24]:=preseteditor.CheckListBox1.checked[24];
    mainform.DevicePresets[length(mainform.DevicePresets)-1].ChanValue[24]:=preseteditor.special3.position;

    mainform.DevicePresets[length(mainform.DevicePresets)-1].UseNewInterface:=not preseteditor.CheckBox1.Checked;

    case preseteditor.shuttercheck.State of
      cbChecked: mainform.DevicePresets[length(mainform.DevicePresets)-1].Shutter:=255;
      cbGrayed: mainform.DevicePresets[length(mainform.DevicePresets)-1].Shutter:=128;
      cbUnchecked: mainform.DevicePresets[length(mainform.DevicePresets)-1].Shutter:=0;
    end;
    case preseteditor.prismacheck.State of
      cbChecked: mainform.DevicePresets[length(mainform.DevicePresets)-1].PrismaEnabled:=255;
      cbGrayed: mainform.DevicePresets[length(mainform.DevicePresets)-1].PrismaEnabled:=128;
      cbUnchecked: mainform.DevicePresets[length(mainform.DevicePresets)-1].PrismaEnabled:=0;
    end;

    mainform.DevicePresets[length(mainform.DevicePresets)-1].Dimmer:=preseteditor.dimmerslider.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].Strobe:=preseteditor.stroboslider.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].Iris:=preseteditor.irisslider.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].Focus:=preseteditor.fokusslider.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].PrismaRot:=preseteditor.prismaslider.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].GoboRot1:=preseteditor.goborot1slider.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].GoboRot2:=preseteditor.goborot2slider.position;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].Color:=preseteditor.colorpicker2.SelectedColor;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].Pan:=preseteditor.panval;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].PanFine:=preseteditor.panfineval;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].Tilt:=preseteditor.tiltval;
    mainform.DevicePresets[length(mainform.DevicePresets)-1].TiltFine:=preseteditor.tiltfineval;

    mainform.DevicePresets[length(mainform.DevicePresets)-1].Gobo:=preseteditor.selectedgobo;

    TempNode:=VST.AddChild(VSTRootNodes[6]);
    Data:=VST.GetNodeData(TempNode);
    Data^.NodeType:=6;
    Data^.IsRootNode:=false;
    Data^.IsCatNode:=false;
    Data^.Caption:=mainform.DevicePresets[length(mainform.DevicePresets)-1].Name;
    Data^.Beschreibung:=mainform.DevicePresets[length(mainform.DevicePresets)-1].Beschreibung;
    Data^.Fadetime:='';
    Data^.ID:=mainform.DevicePresets[length(mainform.DevicePresets)-1].ID;
    VST.Expanded[TempNode]:=true;
    VST.Expanded[TempNode.Parent]:=true;
    VST.Selected[TempNode]:=true;
    VST.FocusedNode:=TempNode;

    // noch schnell die Einträge alphabetisch sortieren
    VST.Sort(VSTRootNodes[6], 0, sdAscending);
  end;
end;

procedure Tszenenverwaltungform.RefreshSzenenverwaltungBtnClick(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  FormShow(nil);
end;

procedure Tszenenverwaltungform.Gerteszene1Click(Sender: TObject);
var
  t,i,j,k:integer;
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

  devicesceneform.Szenenname.Text:=_('Neue Geräteszene');
  devicesceneform.Szenenbeschreibung.Text:='';
  devicesceneform.scenefade_time.text:='5';
  devicesceneform.scenefade_time_min.text:='0';
  devicesceneform.scenefade_time_h.text:='0';
  devicesceneform.scenefade_time_msec.text:='0';
  setlength(mainform.DeviceScenes,length(mainform.devicescenes)+1);

  mainform.AktuelleDeviceScene.ID:=mainform.devicescenes[length(mainform.devicescenes)-1].ID;
  mainform.AktuelleDeviceScene.Name:=mainform.devicescenes[length(mainform.devicescenes)-1].Name;
  mainform.AktuelleDeviceScene.Beschreibung:=mainform.devicescenes[length(mainform.devicescenes)-1].Beschreibung;
  mainform.AktuelleDeviceScene.Fadetime:=mainform.devicescenes[length(mainform.devicescenes)-1].Fadetime;

  setlength(mainform.AktuelleDeviceScene.Devices,length(mainform.devicescenes[length(mainform.devicescenes)-1].Devices));
  for i:=0 to length(mainform.devicescenes[length(mainform.devicescenes)-1].Devices)-1 do
  begin
    mainform.AktuelleDeviceScene.Devices[i].ID:=mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ID;
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanActive,length(mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanActive));
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanValue,length(mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanValue));
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom,length(mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanActiveRandom));
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom,length(mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanValueRandom));
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanDelay,length(mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanDelay));
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime,length(mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanFadetime));
    for j:=0 to length(mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanActive)-1 do
    begin
      mainform.AktuelleDeviceScene.Devices[i].ChanActive[j]:=mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanActive[j];
      mainform.AktuelleDeviceScene.Devices[i].ChanValue[j]:=mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanValue[j];
      mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom[j]:=mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanActiveRandom[j];
      mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom[j]:=mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanValueRandom[j];
      mainform.AktuelleDeviceScene.Devices[i].ChanDelay[j]:=mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanDelay[j];
      mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[j]:=mainform.devicescenes[length(mainform.devicescenes)-1].Devices[i].ChanFadetime[j];
    end;
  end;
  setlength(mainform.AktuelleDeviceScene.Befehle,0);
  setlength(mainform.AktuelleDeviceScene.Befehlswerte,0);

  devicesceneform.ShowModal;

  if devicesceneform.ModalResult=mrOK then
  begin
    CreateGUID(mainform.devicescenes[length(mainform.DeviceScenes)-1].ID);

    mainform.devicescenes[length(mainform.DeviceScenes)-1].Name:=mainform.AktuelleDeviceScene.Name;
    mainform.devicescenes[length(mainform.DeviceScenes)-1].Beschreibung:=mainform.AktuelleDeviceScene.Beschreibung;
    mainform.devicescenes[length(mainform.DeviceScenes)-1].Fadetime:=mainform.AktuelleDeviceScene.Fadetime;

    setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices,length(mainform.AktuelleDeviceScene.Devices));
    for i:=0 to length(mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices)-1 do
    begin
      mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ID:=mainform.AktuelleDeviceScene.Devices[i].ID;
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanActive,length(mainform.AktuelleDeviceScene.Devices[i].ChanActive));
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanValue,length(mainform.AktuelleDeviceScene.Devices[i].ChanValue));
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanActiveRandom,length(mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom));
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanValueRandom,length(mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom));
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanDelay,length(mainform.AktuelleDeviceScene.Devices[i].ChanDelay));
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanFadetime,length(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime));
      for k:=0 to length(mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanActive)-1 do
      begin
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanActive[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanActive[k];
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanValue[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanValue[k];
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanActiveRandom[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom[k];
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanValueRandom[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom[k];
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanDelay[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanDelay[k];
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Devices[i].ChanFadetime[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[k];
      end;
    end;

    setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle, length(mainform.AktuelleDeviceScene.Befehle));
    setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehlswerte, length(mainform.AktuelleDeviceScene.Befehlswerte));
    for i:=0 to length(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle)-1 do
    begin
      mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ID:=mainform.AktuelleDeviceScene.Befehle[i].ID;
      mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].Typ:=mainform.AktuelleDeviceScene.Befehle[i].Typ;
      mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].Name:=mainform.AktuelleDeviceScene.Befehle[i].Name;
      mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].Beschreibung:=mainform.AktuelleDeviceScene.Befehle[i].Beschreibung;
      mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].OnValue:=mainform.AktuelleDeviceScene.Befehle[i].OnValue;
      mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].OffValue:=mainform.AktuelleDeviceScene.Befehle[i].OffValue;
      mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].SwitchValue:=mainform.AktuelleDeviceScene.Befehle[i].SwitchValue;
      mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].InvertSwitchValue:=mainform.AktuelleDeviceScene.Befehle[i].InvertSwitchValue;
      mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ScaleValue:=mainform.AktuelleDeviceScene.Befehle[i].ScaleValue;

      setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgInteger, length(mainform.AktuelleDeviceScene.Befehle[i].ArgInteger));
      setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgString, length(mainform.AktuelleDeviceScene.Befehle[i].ArgString));
      setlength(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgGUID, length(mainform.AktuelleDeviceScene.Befehle[i].ArgGUID));
      for k:=0 to length(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgInteger)-1 do
        mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgInteger[k]:=mainform.AktuelleDeviceScene.Befehle[i].ArgInteger[k];
      for k:=0 to length(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgString)-1 do
        mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgString[k]:=mainform.AktuelleDeviceScene.Befehle[i].ArgString[k];
      for k:=0 to length(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgGUID)-1 do
        mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Befehle[i].ArgGUID[k]:=mainform.AktuelleDeviceScene.Befehle[i].ArgGUID[k];

      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanActive,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive));
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanValue,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue));
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanActiveRandom,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom));
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanValueRandom,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom));
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanDelay,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay));
      setlength(mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanFadetime,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime));
      for k:=0 to length(mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanActive)-1 do
      begin
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanActive[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive[k];
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanValue[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[k];
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanActiveRandom[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom[k];
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanValueRandom[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom[k];
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanDelay[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[k];
        mainform.devicescenes[length(mainform.DeviceScenes)-1].Befehlswerte[i].ChanFadetime[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[k];
      end;
    end;

    mainform.devicescenes[length(mainform.DeviceScenes)-1].Name:=devicesceneform.Szenenname.Text;
    mainform.devicescenes[length(mainform.DeviceScenes)-1].Beschreibung:=devicesceneform.Szenenbeschreibung.Text;

    // Fadezeit in Speicher schreiben
    t:=strtoint(devicesceneform.scenefade_time_msec.Text);
    t:=t+1000*strtoint(devicesceneform.scenefade_time.Text);
    t:=t+60*1000*strtoint(devicesceneform.scenefade_time_min.Text);
    t:=t+60*60*1000*strtoint(devicesceneform.scenefade_time_h.Text);

    mainform.devicescenes[length(mainform.DeviceScenes)-1].Fadetime:=t;

    if Sender<>mainform then
    begin
      TempNode:=VST.AddChild(VSTRootNodes[1]);
      Data:=VST.GetNodeData(TempNode);
      Data^.NodeType:=1;
      Data^.IsRootNode:=false;
      Data^.IsCatNode:=false;
      Data^.Caption:=mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Name;
      Data^.Beschreibung:=mainform.DeviceScenes[length(mainform.DeviceScenes)-1].Beschreibung;
      Data^.Fadetime:=mainform.GetSceneInfo2(mainform.DeviceScenes[length(mainform.DeviceScenes)-1].ID, 'time');
      Data^.ID:=mainform.DeviceScenes[length(mainform.DeviceScenes)-1].ID;
      VST.Expanded[TempNode]:=true;
      VST.Expanded[TempNode.Parent]:=true;
      VST.Selected[TempNode]:=true;
      VST.FocusedNode:=TempNode;

      // noch schnell die Einträge alphabetisch sortieren
      VST.Sort(VSTRootNodes[1], 0, sdAscending);
    end;
  end else
  begin
    setlength(mainform.DeviceScenes,length(mainform.devicescenes)-1);
  end;
end;

function Tszenenverwaltungform.FindSceneConnections(ID: TGUID; var Treeview:TTreeview):boolean;
var
  sceneinuse:boolean;
  i,j,k,l,m,t:integer;
  h,min,s,ms:string;
  Bewegungsszenen, Befehle, Kombinationsszenen, Effekte, mKontrollpanel, MIDIIn,
  DataIn, Tastatursteuerung, Joysticksteuerung, Audioeffektplayer, Cuelist,
  Geraeteszene,Submaster,Sonstige:TTreeNode;
begin
  Treeview.Items.Clear;
  sceneinuse:=false;
  Bewegungsszenen:=nil;
  Befehle:=nil;
  Kombinationsszenen:=nil;
  Effekte:=nil;
  mKontrollpanel:=nil;
  MidiIn:=nil;
  DataIn:=nil;
  Tastatursteuerung:=nil;
  Joysticksteuerung:=nil;
  Audioeffektplayer:=nil;
  Cuelist:=nil;
  Geraeteszene:=nil;
  Sonstige:=nil;

  //  Bewegungsszenen
  for i:=0 to length(mainform.Bewegungsszenen)-1 do
  begin
    for j:=0 to length(mainform.Bewegungsszenen[i].Devices)-1 do
    for l:=0 to length(mainform.Bewegungsszenen[i].Devices[j].Szenen)-1 do
    for k:=0 to length(mainform.Bewegungsszenen[i].Devices[j].Szenen[l])-1 do
    if IsEqualGUID(mainform.Bewegungsszenen[i].Devices[j].Szenen[l][k].ID,ID) then
    begin
      if Bewegungsszenen=nil then
        Bewegungsszenen:=Treeview.Items.Add(nil, _('Bewegungsszenen'));
      Bewegungsszenen.ImageIndex:=23;
      Bewegungsszenen.SelectedIndex:=23;
      Treeview.Items.AddChild(Bewegungsszenen,mainform.Bewegungsszenen[i].Name);
      sceneinuse:=true;
    end;
  end;
// Ende Bewegungsszenen
//  Befehle
  if not sceneinuse then
  for i:=0 to length(mainform.Befehle2)-1 do
  begin
    for j:=0 to length(mainform.Befehle2[i].ArgGUID)-1 do
    begin
      if IsEqualGUID(mainform.Befehle2[i].ArgGUID[j],ID) then
      begin
        if Befehle=nil then
          Befehle:=Treeview.Items.Add(nil, _('Befehle'));
        Befehle.ImageIndex:=15;
        Befehle.SelectedIndex:=15;
        Treeview.Items.AddChild(Befehle,mainform.Befehle2[i].Name);
        sceneinuse:=true;
      end;
    end;
  end;
// Ende Befehle
//  Kombinationsszenen
  if not sceneinuse then
  for i:=0 to length(mainform.Kompositionsszenen)-1 do
  begin
    for j:=0 to length(mainform.Kompositionsszenen[i].IDs)-1 do
    if IsEqualGUID(mainform.Kompositionsszenen[i].IDs[j],ID) then
    begin
      if Kombinationsszenen=nil then
        Kombinationsszenen:=Treeview.Items.Add(nil, _('Kombinationsszenen'));
      Kombinationsszenen.ImageIndex:=89;
      Kombinationsszenen.SelectedIndex:=89;
      Treeview.Items.AddChild(Kombinationsszenen,mainform.Kompositionsszenen[i].Name);
      sceneinuse:=true;
    end;
  end;
// Ende Kombinationsszenen
//  Effekte
  if not sceneinuse then
  for i:=0 to length(mainform.Effektsequenzereffekte)-1 do
  begin
    for j:=0 to length(mainform.Effektsequenzereffekte[i].Effektschritte)-1 do
    for k:=0 to length(mainform.Effektsequenzereffekte[i].Effektschritte[j].IDs)-1 do
    if IsEqualGUID(mainform.Effektsequenzereffekte[i].Effektschritte[j].IDs[k],ID) then
    begin
      if Effekte=nil then
        Effekte:=Treeview.Items.Add(nil, _('Effekte'));
      Effekte.ImageIndex:=20;
      Effekte.SelectedIndex:=20;
      Treeview.Items.AddChild(Effekte,mainform.Effektsequenzereffekte[i].Name+', '+mainform.Effektsequenzereffekte[i].Effektschritte[j].Name);
      sceneinuse:=true;
    end;

    if IsEqualGUID(mainform.Effektsequenzereffekte[i].Startscene, ID) then
    begin
      if Effekte=nil then
        Effekte:=Treeview.Items.Add(nil, _('Effekte'));
      Effekte.ImageIndex:=20;
      Effekte.SelectedIndex:=20;
      Treeview.Items.AddChild(Effekte, _('Bei Start von')+' '+mainform.Effektsequenzereffekte[i].Name);
      sceneinuse:=true;
    end;

    if IsEqualGUID(mainform.Effektsequenzereffekte[i].Stopscene, ID) then
    begin
      if Effekte=nil then
        Effekte:=Treeview.Items.Add(nil, _('Effekte'));
      Effekte.ImageIndex:=20;
      Effekte.SelectedIndex:=20;
      Treeview.Items.AddChild(Effekte, _('Bei Stop von')+' '+mainform.Effektsequenzereffekte[i].Name);
      sceneinuse:=true;
    end;
  end;
// Ende Effekte
//  Kontrollpanel
  if not sceneinuse then
  begin
    for i:=0 to length(mainform.kontrollpanelbuttons)-1 do
    begin
      for j:=0 to length(mainform.kontrollpanelbuttons[i])-1 do
      begin
        if IsEqualGUID(mainform.kontrollpanelbuttons[i][j].ID, ID) then
        begin
          if mKontrollpanel=nil then
            mKontrollpanel:=Treeview.Items.Add(nil, _('Kontrollpanelbuttons'));
          mKontrollpanel.ImageIndex:=21;
          mKontrollpanel.SelectedIndex:=21;
          Treeview.Items.AddChild(mKontrollpanel,_('Button ')+inttostr(i+1)+'x'+inttostr(j+1)+': '+mainform.kontrollpanelbuttons[i][j].Name);
          sceneinuse:=true;
        end;
      end;
    end;
  end;
// Ende Kontrollpanel
//  MIDI-Events
  if not sceneinuse then
  for i:=0 to length(mainform.MidiEventArray)-1 do
  begin
    if length(mainform.MidiEventArray[i].Befehl.ArgGUID)>0 then
    if IsEqualGUID(mainform.MidiEventArray[i].Befehl.ArgGUID[0],ID) then
    begin
      if MIDIIn=nil then
        MIDIIn:=Treeview.Items.Add(nil, _('MIDI-In'));
      MIDIIn.ImageIndex:=17;
      MIDIIn.SelectedIndex:=17;
      Treeview.Items.AddChild(MIDIIn,_('Message: ')+inttostr(mainform.MidiEventArray[i].MIDIMessage));
      sceneinuse:=true;
    end;
  end;
// Ende MIDI-Events
//  DataIn-Events
  if not sceneinuse then
  for i:=0 to length(mainform.DataInEventArray)-1 do
  begin
    if length(mainform.DataInEventArray[i].Befehl.ArgGUID)>0 then
    if IsEqualGUID(mainform.DataInEventArray[i].Befehl.ArgGUID[0],ID) then
    begin
      if DataIn=nil then
        DataIn:=Treeview.Items.Add(nil, _('Data-In'));
      DataIn.ImageIndex:=49;
      DataIn.SelectedIndex:=49;
      Treeview.Items.AddChild(DataIn,_('Kanal: ')+inttostr(mainform.DataInEventArray[i].Channel));
      sceneinuse:=true;
    end;
  end;
// Ende DataIn-Events
//  Tastatursteuerung
  if not sceneinuse then
  for i:=0 to length(mainform.TastencodeArray)-1 do
  begin
    if length(mainform.TastencodeArray[i].Befehl.ArgGUID)>0 then
    if IsEqualGUID(mainform.TastencodeArray[i].Befehl.ArgGUID[0],ID) then
    begin
      if Tastatursteuerung=nil then
        Tastatursteuerung:=Treeview.Items.Add(nil, _('Tastatursteuerung'));
      Tastatursteuerung.ImageIndex:=24;
      Tastatursteuerung.SelectedIndex:=24;
      Treeview.Items.AddChild(Tastatursteuerung,ShortCutToText(mainform.TastencodeArray[i].Hotkey));
      sceneinuse:=true;
    end;
  end;
// Ende Tastatursteuerung
//  Joysticksteuerung
  if not sceneinuse then
  for i:=0 to 43 do
  begin
    if length(mainform.JoystickEvents[i].Befehl.ArgGUID)>0 then
    if IsEqualGUID(mainform.JoystickEvents[i].Befehl.ArgGUID[0],ID) then
    begin
      if Joysticksteuerung=nil then
        Joysticksteuerung:=Treeview.Items.Add(nil, _('Joysticksteuerung'));
      Joysticksteuerung.ImageIndex:=28;
      Joysticksteuerung.SelectedIndex:=28;
      Treeview.Items.AddChild(Joysticksteuerung,_('Button ')+inttostr(i));
      sceneinuse:=true;
    end;
  end;
// Ende Joysticksteuerung
//  Audioeffektplayer
  if not sceneinuse then
  for i:=0 to length(mainform.Effektaudio_record)-1 do
  begin
    for j:=1 to maxaudioeffektlayers do
    begin
      for k:=0 to length(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt)-1 do
      begin
        if IsEqualGUID(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].ID,ID) then
        begin
          if Audioeffektplayer=nil then
            Audioeffektplayer:=Treeview.Items.Add(nil, _('Audioeffektplayer'));
          Audioeffektplayer.ImageIndex:=50;
          Audioeffektplayer.SelectedIndex:=50;

          t:=trunc(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].audioeffektposition*1000);
          h:=inttostr(t div 3600000); t:=t mod 3600000;
          min:=inttostr(t div 60000); t:=t mod 60000;
          s:=inttostr(t div 1000); t:=t mod 1000;
          ms:=inttostr(t);
          if length(min)=1 then min:='0'+min;
          if length(s)=1 then s:='0'+s;
          if length(ms)=1 then ms:='0'+ms;
          if length(ms)=2 then ms:='0'+ms;

          Treeview.Items.AddChild(Audioeffektplayer,mainform.Effektaudio_record[i].audiodatei+_(', Layer: ')+inttostr(j)+_(', Position: ')+h+':'+min+':'+s+':'+ms+_(', Effekt: ')+inttostr(k));
          sceneinuse:=true;
        end;

        for l:=0 to length(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Befehle)-1 do
        for m:=0 to length(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Befehle[l].ArgGUID)-1 do
        begin
          if IsEqualGUID(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Befehle[l].ArgGUID[m],ID) then
          begin
            if Audioeffektplayer=nil then
              Audioeffektplayer:=Treeview.Items.Add(nil, _('Audioeffektplayer'));
            Audioeffektplayer.ImageIndex:=50;
            Audioeffektplayer.SelectedIndex:=50;

            t:=trunc(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].audioeffektposition*1000);
            h:=inttostr(t div 3600000); t:=t mod 3600000;
            min:=inttostr(t div 60000); t:=t mod 60000;
            s:=inttostr(t div 1000); t:=t mod 1000;
            ms:=inttostr(t);
            if length(min)=1 then min:='0'+min;
            if length(s)=1 then s:='0'+s;
            if length(ms)=1 then ms:='0'+ms;
            if length(ms)=2 then ms:='0'+ms;

            Treeview.Items.AddChild(Audioeffektplayer,mainform.Effektaudio_record[i].audiodatei+_(', Layer: ')+inttostr(j)+_(', Position: ')+h+':'+min+':'+s+':'+ms+_(', Effekt: ')+inttostr(k));
            sceneinuse:=true;
          end;
        end;
      end;
    end;
  end;
// Ende Audioeffektplayer
// Cuelist
  if not sceneinuse then
  for i:=0 to length(mainform.Cuelistbank)-1 do
  begin
    for j:=0 to length(mainform.Cuelistbank[i].cuelistbankitems)-1 do
    begin
      if IsEqualGUID(mainform.Cuelistbank[i].cuelistbankitems[j].ID,ID) then
      begin
        if Cuelist=nil then
          Cuelist:=Treeview.Items.Add(nil, _('Cuelist'));
        Cuelist.ImageIndex:=63;
        Cuelist.SelectedIndex:=63;
        Treeview.Items.AddChild(Cuelist,_('Bank ')+inttostr(i));
        sceneinuse:=true;
      end;
    end;
  end;
// Ende Cuelist
// Geräteszene
  if not sceneinuse then
  for i:=0 to length(mainform.DeviceScenes)-1 do
  begin
    for j:=0 to length(mainform.DeviceScenes[i].Befehle)-1 do
    for k:=0 to length(mainform.DeviceScenes[i].Befehle[j].ArgGUID)-1 do
    begin
      if IsEqualGUID(mainform.DeviceScenes[i].Befehle[j].ArgGUID[k],ID) then
      begin
        if Geraeteszene=nil then
          Geraeteszene:=Treeview.Items.Add(nil, _('Geräteszene'));
        Geraeteszene.ImageIndex:=25;
        Geraeteszene.SelectedIndex:=25;
        Treeview.Items.AddChild(Geraeteszene,mainform.DeviceScenes[i].Name);
        sceneinuse:=true;
      end;
    end;
  end;
// Ende Geräteszene
// Submaster
  if not sceneinuse then
  for i:=0 to length(mainform.Submasterbank)-1 do
  begin
    for j:=1 to 16 do
    for k:=0 to length(mainform.Submasterbank[i].Befehl[j].ArgGUID)-1 do
    begin
      if IsEqualGUID(mainform.Submasterbank[i].Befehl[j].ArgGUID[k],ID) then
      begin
        if Geraeteszene=nil then
          Geraeteszene:=Treeview.Items.Add(nil, _('Geräteszene'));
        Geraeteszene.ImageIndex:=25;
        Geraeteszene.SelectedIndex:=25;
        Treeview.Items.AddChild(Geraeteszene,mainform.DeviceScenes[i].Name);
        sceneinuse:=true;
      end;
    end;
  end;
  // Ende Submaster
  // Beattool
  if not sceneinuse then
  begin
    if IsEqualGUID(mainform.BeatImpuls.SceneOnBeatLost, ID) then
    begin
      if Sonstige=nil then
        Sonstige:=Treeview.Items.Add(nil, _('Sonstiges'));
      Sonstige.ImageIndex:=31;
      Sonstige.SelectedIndex:=31;
      Treeview.Items.AddChild(Sonstige,_('Beattool: Bei Beatverlust'));
      sceneinuse:=true;
    end;

    if IsEqualGUID(mainform.BeatImpuls.SceneOnBeatStart, ID) then
    begin
      if Sonstige=nil then
        Sonstige:=Treeview.Items.Add(nil, _('Sonstiges'));
      Sonstige.ImageIndex:=31;
      Sonstige.SelectedIndex:=31;
      Treeview.Items.AddChild(Sonstige,_('Beattool: Bei Beatbeginn'));
      sceneinuse:=true;
    end;
  end;
  // Ende Beattool


  Treeview.FullExpand;
  result:=sceneinuse;
end;

procedure Tszenenverwaltungform.RefreshSceneDependencies;
var
  Data: PTreeData;
begin
  Treeview2.Items.Clear;

  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);
  if Assigned(Data) and (not (Data^.IsRootNode or Data^.IsCatNode)) then
    FindSceneConnections(Data^.ID,Treeview2);
end;

procedure Tszenenverwaltungform.Automatikszene1Click(Sender: TObject);
var
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

  // Automatikszene erstellen
  setlength(mainform.autoszenen,length(mainform.autoszenen)+1);

  CreateGUID(mainform.AktuelleAutoszene.ID);
  mainform.AktuelleAutoszene.Name:=_('Neue Autoszene');
  mainform.AktuelleAutoszene.Beschreibung:='';
  mainform.AktuelleAutoszene.fadetime:=3000;
  mainform.AktuelleAutoszene.R:=255;
  mainform.AktuelleAutoszene.G:=0;
  mainform.AktuelleAutoszene.B:=0;
  mainform.AktuelleAutoszene.A:=-1;
  mainform.AktuelleAutoszene.W:=-1;
  mainform.AktuelleAutoszene.accuracy:=1;
  mainform.AktuelleAutoszene.helligkeit:=255;

  autoszeneform.showmodal;

  if autoszeneform.ModalResult=mrOK then
  begin
    mainform.autoszenen[length(mainform.autoszenen)-1].ID:=mainform.AktuelleAutoszene.ID;
    mainform.autoszenen[length(mainform.autoszenen)-1].Name:=mainform.AktuelleAutoszene.Name;
    mainform.autoszenen[length(mainform.autoszenen)-1].Beschreibung:=mainform.AktuelleAutoszene.Beschreibung;
    mainform.autoszenen[length(mainform.autoszenen)-1].fadetime:=mainform.AktuelleAutoszene.fadetime;
    mainform.autoszenen[length(mainform.autoszenen)-1].R:=mainform.AktuelleAutoszene.R;
    mainform.autoszenen[length(mainform.autoszenen)-1].G:=mainform.AktuelleAutoszene.G;
    mainform.autoszenen[length(mainform.autoszenen)-1].B:=mainform.AktuelleAutoszene.B;
    mainform.autoszenen[length(mainform.autoszenen)-1].A:=mainform.AktuelleAutoszene.A;
    mainform.autoszenen[length(mainform.autoszenen)-1].W:=mainform.AktuelleAutoszene.W;
    mainform.autoszenen[length(mainform.autoszenen)-1].accuracy:=mainform.AktuelleAutoszene.accuracy;
    mainform.autoszenen[length(mainform.autoszenen)-1].helligkeit:=mainform.AktuelleAutoszene.helligkeit;

    TempNode:=VST.AddChild(VSTRootNodes[7]);
    Data:=VST.GetNodeData(TempNode);
    Data^.NodeType:=7;
    Data^.IsRootNode:=false;
    Data^.IsCatNode:=false;
    Data^.Caption:=mainform.Autoszenen[length(mainform.Autoszenen)-1].Name;
    Data^.Beschreibung:=mainform.Autoszenen[length(mainform.Autoszenen)-1].Beschreibung;
    Data^.Fadetime:=mainform.GetSceneInfo2(mainform.Autoszenen[length(mainform.Autoszenen)-1].ID, 'time');
    Data^.ID:=mainform.Autoszenen[length(mainform.Autoszenen)-1].ID;
    VST.Expanded[TempNode]:=true;
    VST.Expanded[TempNode.Parent]:=true;
    VST.Selected[TempNode]:=true;
    VST.FocusedNode:=TempNode;

    // noch schnell die Einträge alphabetisch sortieren
    VST.Sort(VSTRootNodes[7], 0, sdAscending);
  end else
  begin
    setlength(mainform.autoszenen,length(mainform.autoszenen)-1);
  end;
end;

procedure Tszenenverwaltungform.FormCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  if NewWidth<530 then
    Resize:=false;
  if NewHeight<450 then
    Resize:=false;
end;

procedure Tszenenverwaltungform.FormResize(Sender: TObject);
begin
  Treeview2.Width:=width div 3;
end;

procedure Tszenenverwaltungform.MSGSave;
begin
//
end;

procedure Tszenenverwaltungform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  mainform.SaveWindowPositions('szenenverwaltung');

  if (not mainform.shutdown) then
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
        	LReg.WriteBool('Showing Szenenverwaltung',false);
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
  end;
end;

procedure Tszenenverwaltungform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tszenenverwaltungform.MediaCenterSzene1Click(Sender: TObject);
var
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

  // Automatikszene erstellen
  setlength(mainform.mediacenterszenen,length(mainform.mediacenterszenen)+1);

  CreateGUID(mainform.AktuelleMediaCenterSzene.ID);
  mainform.AktuelleMediaCenterSzene.Name:=_('Neue MediaCenter Szene');
  mainform.AktuelleMediaCenterSzene.Beschreibung:='';
  mainform.AktuelleMediaCenterSzene.Adresse:=mainform.MediaCenterSocket.Address;
  mainform.AktuelleMediaCenterSzene.Port:=mainform.MediaCenterSocket.Port;
  mainform.AktuelleMediaCenterSzene.Befehl:=0;
  mainform.AktuelleMediaCenterSzene.Data1:=0;
  mainform.AktuelleMediaCenterSzene.Data2:=0;
  mainform.AktuelleMediaCenterSzene.Text:='';

  mediacenterform.showmodal;

  if mediacenterform.ModalResult=mrOK then
  begin
    mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].ID:=mainform.AktuelleMediaCenterSzene.ID;
    mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Name:=mainform.AktuelleMediaCenterSzene.Name;
    mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Beschreibung:=mainform.AktuelleMediaCenterSzene.Beschreibung;
    mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Adresse:=mainform.AktuelleMediaCenterSzene.Adresse;
    mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Port:=mainform.AktuelleMediaCenterSzene.Port;
    mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Befehl:=mainform.AktuelleMediaCenterSzene.Befehl;
    mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Data1:=mainform.AktuelleMediaCenterSzene.Data1;
    mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Data2:=mainform.AktuelleMediaCenterSzene.Data2;
    mainform.mediacenterszenen[length(mainform.mediacenterszenen)-1].Text:=mainform.AktuelleMediaCenterSzene.Text;

    TempNode:=VST.AddChild(VSTRootNodes[9]);
    Data:=VST.GetNodeData(TempNode);
    Data^.NodeType:=9;
    Data^.IsRootNode:=false;
    Data^.IsCatNode:=false;
    Data^.Caption:=mainform.MediaCenterSzenen[length(mainform.MediaCenterSzenen)-1].Name;
    Data^.Beschreibung:=mainform.MediaCenterSzenen[length(mainform.MediaCenterSzenen)-1].Beschreibung;
    Data^.Fadetime:='';
    Data^.ID:=mainform.MediaCenterSzenen[length(mainform.MediaCenterSzenen)-1].ID;
    VST.Expanded[TempNode]:=true;
    VST.Expanded[TempNode.Parent]:=true;
    VST.Selected[TempNode]:=true;
    VST.FocusedNode:=TempNode;

    // noch schnell die Einträge alphabetisch sortieren
    VST.Sort(VSTRootNodes[9], 0, sdAscending);
  end else
  begin
    setlength(mainform.mediacenterszenen,length(mainform.mediacenterszenen)-1);
  end;
end;

procedure Tszenenverwaltungform.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PTreeData;
  i,j,k:integer;
begin
  case Column of
    0:
    begin
      Data:=VST.GetNodeData(Node);
      CellText:=Data^.Caption;
    end;
    1:
    begin
      // Fadezeit anzeigen
      Data:=VST.GetNodeData(Node);
      if Data^.IsRootNode or Data^.IsCatNode then
        CellText:=''
      else
      case Data^.NodeType of
        0..3, 5..10: CellText:=Data^.Fadetime;
        4:
        begin
          CellText:='';
          for i:=0 to length(mainform.Befehle2)-1 do
          begin
            if IsEqualGUID(mainform.Befehle2[i].ID,Data^.ID) then
            begin
              for j:=0 to length(mainform.Befehlssystem)-1 do
              begin
                for k:=0 to length(mainform.Befehlssystem[j].Steuerung)-1 do
                begin
                  if IsEqualGUID(mainform.Befehlssystem[j].Steuerung[k].GUID,mainform.Befehle2[i].Typ) then
                  begin
                    CellText:=mainform.Befehlssystem[j].Steuerung[k].Bezeichnung;
                    break;
                  end;
                end;
              end;
              break;
            end;
          end;
        end;
        11..12: CellText:='';
      end;
    end;
    2:
    begin
      // Werte anzeigen
      Data:=VST.GetNodeData(Node);
      if Data^.IsRootNode or Data^.IsCatNode then
        CellText:=''
      else
        CellText:=Data^.Beschreibung;
    end;
  end;
end;

procedure Tszenenverwaltungform.VSTGetImageIndex(Sender: TBaseVirtualTree;
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
          0: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=26 else ImageIndex:=92;
          1: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=25 else ImageIndex:=93;
          2: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=50 else ImageIndex:=94;
          3: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=23 else ImageIndex:=95;
          4: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=15 else ImageIndex:=96;
          5: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=89 else ImageIndex:=97;
          6: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=91 else ImageIndex:=98;
          7: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=67 else ImageIndex:=99;
          8: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=20 else ImageIndex:=100;
          9: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=83 else ImageIndex:=101;
          10: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=91 else ImageIndex:=98;
          11: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=83 else ImageIndex:=101;
          12: if Data^.IsRootNode or Data^.IsCatNode then ImageIndex:=31 else ImageIndex:=106;
        end;
      end;
    end;
  end;
end;

procedure Tszenenverwaltungform.VSTChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PTreeData;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  if not Effektmodus then
  begin
    RefreshSceneDependencies;

    if Assigned(Data) and (not (Data^.IsRootNode or Data^.IsCatNode)) then
    begin
      positionselection:=Data^.ID;
      
      if checkbox1.Checked then
      begin
        Label1.Caption:=GUIDtostring(Data^.ID);
      end else
      begin
        Label1.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
      end;
    end else
    begin
      if Assigned(Data) then
      begin
        case Data^.NodeType of
          0: Label1.Caption:=_('Ermöglicht die Erstellung kanalbezogener Einblendszenen mit Einblendzeit.');
          1: Label1.Caption:=_('Dieser Szenentyp speichert Szenen Gerätebezogen mit einer Einblendzeit ab.');
          2: Label1.Caption:=_('Spielt verlinkte Audiodateien ab');
          3: Label1.Caption:=_('Automatische Scannerbewegungen, bzw. Kanaleffekte');
          4: Label1.Caption:=_('Steuerungen der einzelnen PC_DIMMER Funktionen');
          5: Label1.Caption:=_('Kombinationen einzelner Szenen die zusammen gestartet und beendet werden');
          6: Label1.Caption:=_('Mit Presets können mehreren Geräten gleichzeitig Werte zugewiesen werden.');
          7: Label1.Caption:=_('Automatikszenen erlauben das automatische Setzen einer Lichtstimmung.');
          8: Label1.Caption:=_('Effekte sind eine Ansammlung aufeinanderfolgender Szenen.');
          9: Label1.Caption:=_('MediaCenter Szenen steuern die Medienwiedergabe an entfernten Computern.');
          10: Label1.Caption:=_('Presetszenen sind ähnlich wie Presets, wenden die Eigenschaften aber nur auf bestimmte Geräte an');
          11: Label1.Caption:=_('Codeszenen enthalten Programm-Code, der vielfältige Funktionen beinhalten kann - auch eigene Oberflächen');
          12: Label1.Caption:=_('Pluginszenen werden von Plugins bereit gestellt und besitzen unterschiedliche Funktionen');
          else
             Label1.Caption:='';
        end;
      end;
    end;
  end else
  begin
    Treeview2.Items.Clear;

    if not (Data^.IsRootNode or Data^.IsCatNode) then
    begin
      FindSceneConnections(Data^.ID,Treeview2);

      if checkbox1.Checked then
      begin
        Label1.Caption:=GUIDtoString(Data^.ID);
      end else
      begin
        case Data^.NodeType of
          0: Label1.Caption:=mainform.GetSceneInfo2(Data^.ID, 'desc');
          else
            Label1.Caption:='';
        end;
      end;

      if IsEqualGUID(Data^.ID,ActualEffekt) then
      begin
        Label1.Caption:=_('Dies ist der derzeit bearbeitete Effekt. Er darf sich nicht selbst aufrufen!');
      end;
    end else
    begin
      case Data^.NodeType of
        0: Label1.Caption:=_('Effekte sind eine Ansammlung aufeinanderfolgender Szenen.');
        else
           Label1.Caption:='';
      end;
    end;
  end;
end;

procedure Tszenenverwaltungform.VSTEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed:=not VST.HasChildren[Node];
end;

procedure Tszenenverwaltungform.VSTNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  i,position:integer;
  Data: PTreeData;
begin
  position:=-1;

  Data:=VST.GetNodeData(Node);
  Data^.Caption:=NewText;

  if not Effektmodus then
  begin
    if not (Data^.IsRootNode or Data^.IsCatNode) then
    begin
      case Data^.NodeType of
        0:
        begin
          for i:=0 to length(mainform.EinfacheSzenen)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.EinfacheSzenen[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.EinfacheSzenen[Position].Name:=NewText;
        end;
        1:
        begin
          for i:=0 to length(mainform.Devicescenes)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.Devicescenes[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.Devicescenes[Position].Name:=NewText;
        end;
        2:
        begin
          for i:=0 to length(mainform.AudioSzenen)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.AudioSzenen[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.AudioSzenen[Position].Name:=NewText;
        end;
        3:
        begin
          for i:=0 to length(mainform.Bewegungsszenen)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.Bewegungsszenen[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.Bewegungsszenen[Position].Name:=NewText;
        end;
        4:
        begin
          for i:=0 to length(mainform.Befehle2)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.Befehle2[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.Befehle2[Position].Name:=NewText;
        end;
        5:
        begin
          for i:=0 to length(mainform.Kompositionsszenen)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.Kompositionsszenen[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.Kompositionsszenen[Position].Name:=NewText;
        end;
        6:
        begin
          for i:=0 to length(mainform.DevicePresets)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.DevicePresets[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.DevicePresets[Position].Name:=NewText;
        end;
        7:
        begin
          for i:=0 to length(mainform.Autoszenen)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.Autoszenen[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.Autoszenen[Position].Name:=NewText;
        end;
        8:
        begin
          for i:=0 to length(mainform.effektsequenzereffekte)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.effektsequenzereffekte[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.effektsequenzereffekte[Position].Name:=NewText;

          mainform.EffectsChanged;
        end;
        9:
        begin
          for i:=0 to length(mainform.Mediacenterszenen)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.Mediacenterszenen[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.Mediacenterszenen[Position].Name:=NewText;
        end;
        10:
        begin
          for i:=0 to length(mainform.PresetScenes)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.PresetScenes[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.PresetScenes[Position].Name:=NewText;
        end;
        11:
        begin
          for i:=0 to length(mainform.CodeScenes)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.CodeScenes[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.CodeScenes[Position].Name:=NewText;
        end;
        12:
        begin
          for i:=0 to length(mainform.PluginSzenen)-1 do
          begin
            if IsEqualGUID(Data^.ID, mainform.PluginSzenen[i].ID) then
            begin
              position:=i;
            end;
          end;
          if position=-1 then exit;
          mainform.PluginSzenen[Position].Name:=NewText;
          mainform.SendMSG(MSG_REFRESHPLUGINSCENE, GUIDtoString(mainform.PluginSzenen[Position].ID), mainform.PluginSzenen[Position].Name);
        end;
      end;
    end;
  end else
  begin
    for i:=0 to length(mainform.effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(Data^.ID, mainform.effektsequenzereffekte[i].ID) then
      begin
        position:=i;
      end;
    end;
    if position=-1 then exit;
    mainform.effektsequenzereffekte[position].Name:=NewText;

    mainform.EffectsChanged;
  end;
  vst.refresh;
end;

procedure Tszenenverwaltungform.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PTreeData;
begin
  with TargetCanvas do
  case Column of
    0:
    begin
      Data:=VST.GetNodeData(Node);

      if Effektmodus then
      begin
        if not VST.HasChildren[Node] then
        begin
          if IsEqualGUID(Data^.ID,ActualEffekt) then
          begin
            Font.Style:=[fsBold];
            Font.Color:=clRed;
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

procedure Tszenenverwaltungform.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
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

procedure Tszenenverwaltungform.CatBtnClick(Sender: TObject);
var
  Data: PTreeData;
  TempNode:PVirtualNode;
  CatName:string;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if VST.SelectedCount=0 then exit;

  CatName:=InputBox(_('Kategorie ändern'),_('Bitte geben Sie eine neue Kategorie für die selektierten Elemente ein, oder lassen Sie die Eingabe frei:'),CatName);

  TempNode:=VST.GetFirst;
  while Assigned(TempNode) do
  begin
    Data:=VST.GetNodeData(TempNode);
    if VST.Selected[TempNode] and Assigned(Data) and (not (Data^.IsRootNode or Data^.IsCatNode or (Data^.NodeType=8))) then
      mainform.SetSceneCategory(Data^.ID, CatName);
    TempNode:=VST.GetNext(TempNode);
  end;

  RefreshSzenenverwaltungBtnClick(nil);
end;

procedure Tszenenverwaltungform.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);

  if IsNonModal then
  begin
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
end;

procedure Tszenenverwaltungform.AlleKanleaufnehmen1Click(Sender: TObject);
begin
  positionselection:=mainform.RecordScene(0);
  FormShow(nil);
end;

procedure Tszenenverwaltungform.NurselektierteGerteaufnehmen1Click(
  Sender: TObject);
begin
  positionselection:=mainform.RecordScene(1);
  FormShow(nil);
end;

procedure Tszenenverwaltungform.NurseitletzterSzenegenderteKanleaufnehmen1Click(
  Sender: TObject);
begin
  positionselection:=mainform.RecordScene(2);
  FormShow(nil);
end;

procedure Tszenenverwaltungform.SelektierteGerteUNDgenderteKanleaufnehmen1Click(
  Sender: TObject);
begin
  positionselection:=mainform.RecordScene(3);
  FormShow(nil);
end;

procedure Tszenenverwaltungform.recordbtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  Popupmenu2.Popup(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Left+Panel1.Left+RecordBtn.Left+x,szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Top+AddBtn.Top+Panel1.Top+RecordBtn.Height+y);
end;

procedure Tszenenverwaltungform.Kanlemanuellwhlen1Click(Sender: TObject);
begin
  mainform.RecordScene(4);
end;

procedure Tszenenverwaltungform.Button6MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Data: PTreeData;
  OldID, NewID:TGUID;
  i,position:integer;
begin
  position:=-1;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if Assigned(Data) and (not (Data^.IsRootNode or Data^.IsCatNode)) then
  begin
    OldID:=Data^.ID;

    if Shift=[] then
      InputBox(_('Objekt-ID'),_('Die ID des aktuellen Objektes lautet wie folgt:'),GuidToString(OldID));

    if Shift=[ssCtrl] then
    begin
      NewID:=StringToGUID(InputBox(_('Objekt-ID'),_('Geben Sie eine neue ID des gewählten Objektes an:'),GuidToString(OldID)));

      if not Effektmodus then
      begin
        if not (Data^.IsRootNode or Data^.IsCatNode) then
        begin
          case Data^.NodeType of
            0:
            begin
              for i:=0 to length(mainform.EinfacheSzenen)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.EinfacheSzenen[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.EinfacheSzenen[Position].ID:=NewID;
            end;
            1:
            begin
              for i:=0 to length(mainform.Devicescenes)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.Devicescenes[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.Devicescenes[Position].ID:=NewID;
            end;
            2:
            begin
              for i:=0 to length(mainform.AudioSzenen)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.AudioSzenen[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.AudioSzenen[Position].ID:=NewID;
            end;
            3:
            begin
              for i:=0 to length(mainform.Bewegungsszenen)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.Bewegungsszenen[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.Bewegungsszenen[Position].ID:=NewID;
            end;
            4:
            begin
              for i:=0 to length(mainform.Befehle2)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.Befehle2[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.Befehle2[Position].ID:=NewID;
            end;
            5:
            begin
              for i:=0 to length(mainform.Kompositionsszenen)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.Kompositionsszenen[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.Kompositionsszenen[Position].ID:=NewID;
            end;
            6:
            begin
              for i:=0 to length(mainform.DevicePresets)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.DevicePresets[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.DevicePresets[Position].ID:=NewID;
            end;
            7:
            begin
              for i:=0 to length(mainform.Autoszenen)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.Autoszenen[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.Autoszenen[Position].ID:=NewID;
            end;
            8:
            begin
              for i:=0 to length(mainform.effektsequenzereffekte)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.effektsequenzereffekte[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.effektsequenzereffekte[Position].ID:=NewID;

              mainform.EffectsChanged;
            end;
            9:
            begin
              for i:=0 to length(mainform.Mediacenterszenen)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.Mediacenterszenen[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.Mediacenterszenen[Position].ID:=NewID;
            end;
            10:
            begin
              for i:=0 to length(mainform.PresetScenes)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.PresetScenes[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.PresetScenes[Position].ID:=NewID;
            end;
            11:
            begin
              for i:=0 to length(mainform.CodeScenes)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.CodeScenes[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.CodeScenes[Position].ID:=NewID;
            end;
            12:
            begin
              for i:=0 to length(mainform.PluginSzenen)-1 do
              begin
                if IsEqualGUID(Data^.ID, mainform.PluginSzenen[i].ID) then
                begin
                  position:=i;
                end;
              end;
              if position=-1 then exit;
              mainform.PluginSzenen[Position].ID:=NewID;
              mainform.SendMSG(MSG_REFRESHPLUGINSCENE, GUIDtoString(mainform.PluginSzenen[Position].ID), mainform.PluginSzenen[Position].Name);
            end;
          end;
        end;
      end else
      begin
        for i:=0 to length(mainform.effektsequenzereffekte)-1 do
        begin
          if IsEqualGUID(Data^.ID, mainform.effektsequenzereffekte[i].ID) then
          begin
            position:=i;
          end;
        end;
        if position=-1 then exit;
        mainform.effektsequenzereffekte[position].ID:=NewID;

        mainform.EffectsChanged;
      end;

      Data^.ID:=NewID;

      vst.refresh;
    end;
  end;
end;

procedure Tszenenverwaltungform.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Suchtext:string;
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if key=vk_return then
  begin
    VST.FullCollapse(nil);

    Suchtext:=lowercase(Edit1.Text);

    TempNode:=VST.GetFirst;
    while Assigned(TempNode) do
    begin
      Data:=VST.GetNodeData(TempNode);

      if (pos(Suchtext, LowerCase(Data^.Caption))>0) or (pos(Suchtext, LowerCase(Data^.Beschreibung))>0) then
      begin
        VST.Expanded[TempNode.Parent]:=true;
        VST.Expanded[TempNode]:=true;
        VST.Selected[TempNode]:=true;
        VST.FocusedNode:=TempNode;
      end else
      begin
        VST.Selected[TempNode]:=false;
      end;

      TempNode:=VST.GetNext(TempNode);
    end;
  end;
end;

procedure Tszenenverwaltungform.PresetSzene1Click(Sender: TObject);
var
  i:integer;
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

  PresetSceneEditor.Edit1.Text:=_('Neue Presetszene');
  PresetSceneEditor.Edit2.Text:='';

  presetsceneeditor.mbXPImageComboBox1.Clear;
  for i:=0 to mainform.GoboPictures.Items.Count-1 do
  begin
{
    Rect.Left:=0;
    Rect.Top:=0;
    Rect.Right:=mainform.GoboPictures.Items.Items[i].PngImage.Width;
    Rect.Bottom:=mainform.GoboPictures.Items.Items[i].PngImage.Height;
    mainform.GoboPictures.Items.Items[i].PngImage.Draw(bmp.Picture.Bitmap.Canvas, Rect);

    ImageList1.Add(bmp.Picture.Bitmap, bmp.Picture.Bitmap);
}
    presetsceneeditor.mbXPImageComboBox1.Items.Add(mainform.GoboPictures.Items.Items[i].Name);
  end;
//  mbXPImageComboBox1.Images:=ImageList1;
  presetsceneeditor.gobolbl.caption:='...';

  PresetSceneEditor.shuttercheck.state:=cbGrayed;
  PresetSceneEditor.prismacheck.Checked:=false;
  PresetSceneEditor.dimmerslider.position:=0;
  PresetSceneEditor.stroboslider.position:=0;
  PresetSceneEditor.irisslider.position:=0;
  PresetSceneEditor.fokusslider.position:=0;
  PresetSceneEditor.prismaslider.position:=127;
  PresetSceneEditor.goborot1slider.position:=127;
  PresetSceneEditor.goborot2slider.position:=127;
  PresetSceneEditor.PositionXY2.Top:=(PresetSceneEditor.fadenkreuz2.Height div 2)-(PresetSceneEditor.PositionXY2.Height div 2);
  PresetSceneEditor.PositionXY2.Left:=(PresetSceneEditor.fadenkreuz2.Width div 2)-(PresetSceneEditor.PositionXY2.Width div 2);
  PresetSceneEditor.colorpicker2.SelectedColor:=clRed;

  presetsceneeditor.TreeViewRefresh;

  PresetSceneEditor.Showmodal;

  if PresetSceneEditor.ModalResult=mrOK then
  begin
    setlength(mainform.PresetScenes,length(mainform.PresetScenes)+1);
    CreateGUID(mainform.PresetScenes[length(mainform.PresetScenes)-1].ID);
    positionselection:=mainform.PresetScenes[length(mainform.PresetScenes)-1].ID;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].Name:=PresetSceneEditor.Edit1.Text;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].Beschreibung:=PresetSceneEditor.Edit2.Text;

    // Selektierte Geräte in Preset speichern
    for i:=0 to PresetSceneEditor.Treeview1.SelectionCount-1 do
    begin
      if (PresetSceneEditor.Treeview1.Selections[i].HasChildren=false) {and PresetSceneEditor.Treeview1.Selections[i].Selected} then
      begin
        setlength(mainform.PresetScenes[length(mainform.PresetScenes)-1].Devices, length(mainform.PresetScenes[length(mainform.PresetScenes)-1].Devices)+1);
        mainform.PresetScenes[length(mainform.PresetScenes)-1].Devices[length(mainform.PresetScenes[length(mainform.PresetScenes)-1].Devices)-1]:=PresetSceneEditor.NodeGUID[PresetSceneEditor.Treeview1.Selections[i].Parent.Parent.Index][PresetSceneEditor.Treeview1.Selections[i].Parent.Index][PresetSceneEditor.Treeview1.Selections[i].Index];
      end;
    end;

    case PresetSceneEditor.shuttercheck.State of
      cbChecked: mainform.PresetScenes[length(mainform.PresetScenes)-1].Shutter:=255;
      cbGrayed: mainform.PresetScenes[length(mainform.PresetScenes)-1].Shutter:=128;
      cbUnchecked: mainform.PresetScenes[length(mainform.PresetScenes)-1].Shutter:=0;
    end;
    case PresetSceneEditor.prismacheck.State of
      cbChecked: mainform.PresetScenes[length(mainform.PresetScenes)-1].PrismaEnabled:=255;
      cbGrayed: mainform.PresetScenes[length(mainform.PresetScenes)-1].PrismaEnabled:=128;
      cbUnchecked: mainform.PresetScenes[length(mainform.PresetScenes)-1].PrismaEnabled:=0;
    end;

    mainform.PresetScenes[length(mainform.PresetScenes)-1].Dimmer:=PresetSceneEditor.dimmerslider.position;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].Strobe:=PresetSceneEditor.stroboslider.position;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].Iris:=PresetSceneEditor.irisslider.position;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].Focus:=PresetSceneEditor.fokusslider.position;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].PrismaRot:=PresetSceneEditor.prismaslider.position;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].GoboRot1:=PresetSceneEditor.goborot1slider.position;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].GoboRot2:=PresetSceneEditor.goborot2slider.position;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].Color:=PresetSceneEditor.colorpicker2.SelectedColor;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].Pan:=PresetSceneEditor.panval;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].PanFine:=PresetSceneEditor.panfineval;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].Tilt:=PresetSceneEditor.tiltval;
    mainform.PresetScenes[length(mainform.PresetScenes)-1].TiltFine:=PresetSceneEditor.tiltfineval;

    mainform.PresetScenes[length(mainform.PresetScenes)-1].Gobo:=PresetSceneEditor.selectedgobo;

    TempNode:=VST.AddChild(VSTRootNodes[10]);
    Data:=VST.GetNodeData(TempNode);
    Data^.NodeType:=10;
    Data^.IsRootNode:=false;
    Data^.IsCatNode:=false;
    Data^.Caption:=mainform.PresetScenes[length(mainform.PresetScenes)-1].Name;
    Data^.Beschreibung:=mainform.PresetScenes[length(mainform.PresetScenes)-1].Beschreibung;
    Data^.Fadetime:='';
    Data^.ID:=mainform.PresetScenes[length(mainform.PresetScenes)-1].ID;
    VST.Expanded[TempNode]:=true;
    VST.Expanded[TempNode.Parent]:=true;
    VST.Selected[TempNode]:=true;
    VST.FocusedNode:=TempNode;

    // noch schnell die Einträge alphabetisch sortieren
    VST.Sort(VSTRootNodes[10], 0, sdAscending);
  end;
end;

procedure Tszenenverwaltungform.VSTEndDrag(Sender, Target: TObject; X,
  Y: Integer);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if (Target=audioeffektplayerform.waveform) and (VST.SelectedCount>0) then
  begin
    // Call add-scene function within the audioeffectplayer
    Data:=VST.GetNodeData(VST.FocusedNode);
    if Assigned(Data) and (not Data^.IsRootNode) and (audioeffektplayerform.mouseoverlayer>0) then
    begin
      audioeffektplayerform.RecordAudioeffekt(Data^.ID, false, audioeffektplayerform.mouseoverlayer, true);
    end;
    audioeffektplayerform._mousedwn:=0;
  end;
end;

procedure Tszenenverwaltungform.VSTMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Data: PTreeData;
begin
  if Shift=[ssLeft, ssDouble] then
  begin
    if not mainform.UserAccessGranted(2) then exit;
    if VST.SelectedCount=0 then exit;

    Data:=VST.GetNodeData(VST.FocusedNode);

    if Assigned(Data) and (not Data^.IsRootNode) then
    begin
      mainform.EditScene(Data^.ID);

      Data:=VST.GetNodeData(VST.FocusedNode);
      Data^.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
      Data^.Beschreibung:=mainform.GetSceneInfo2(Data^.ID, 'desc');
      Data^.Fadetime:=mainform.GetSceneInfo2(Data^.ID, 'time');
      positionselection:=Data^.ID;
      VST.Refresh;
    end;
  end;

  if (Shift=[ssLeft]) and (Button=mbLeft) then
  begin
    VST.BeginDrag(False);
  end;
end;

procedure Tszenenverwaltungform.CodeSzene1Click(Sender: TObject);
var
  Data: PTreeData;
  TempNode:PVirtualNode;
begin
  if not mainform.UserAccessGranted(2) then exit;

  codeeditorform.nameedit.Text:=_('Neue Code-Szene');
  codeeditorform.descriptionedit.Text:='';
  codeeditorform.Memo1.Text:='unit CodeScene;'+#13#10+
  'interface'+#13#10+
  'procedure InitScene;'+#13#10+
  'procedure StartScene;'+#13#10+
  'procedure StopScene;'+#13#10+
  'implementation'+#13#10#13#10+
  'procedure InitScene;'+#13#10+
  'begin'+#13#10+
  'end;'+#13#10#13#10+
  'procedure StartScene;'+#13#10+
  'begin'+#13#10+
  'end;'+#13#10#13#10+
  'procedure StopScene;'+#13#10+
  'begin'+#13#10+
  'end;'+#13#10#13#10+
  'end.';

  codeeditorform.Panel3.Visible:=true;
  codeeditorform.MouseDown.Visible:=false;
  codeeditorform.MouseUp.Visible:=false;

  codeeditorform.ShowModal;

  if codeeditorform.ModalResult=mrOK then
  begin
    setlength(mainform.CodeScenes,length(mainform.CodeScenes)+1);
    CreateGUID(mainform.CodeScenes[length(mainform.CodeScenes)-1].ID);
    positionselection:=mainform.CodeScenes[length(mainform.CodeScenes)-1].ID;
    mainform.CodeScenes[length(mainform.CodeScenes)-1].Name:=codeeditorform.nameedit.Text;
    mainform.CodeScenes[length(mainform.CodeScenes)-1].Beschreibung:=codeeditorform.descriptionedit.Text;
    mainform.CodeScenes[length(mainform.CodeScenes)-1].Code:=codeeditorform.Memo1.Text;
    mainform.InitCodeScene(mainform.CodeScenes[length(mainform.CodeScenes)-1].ID);

    TempNode:=VST.AddChild(VSTRootNodes[11]);
    Data:=VST.GetNodeData(TempNode);
    Data^.NodeType:=11;
    Data^.IsRootNode:=false;
    Data^.IsCatNode:=false;
    Data^.Caption:=mainform.CodeScenes[length(mainform.CodeScenes)-1].Name;
    Data^.Beschreibung:=mainform.CodeScenes[length(mainform.CodeScenes)-1].Beschreibung;
    Data^.Fadetime:='';
    Data^.ID:=mainform.CodeScenes[length(mainform.CodeScenes)-1].ID;
    VST.Expanded[TempNode]:=true;
    VST.Expanded[TempNode.Parent]:=true;
    VST.Selected[TempNode]:=true;
    VST.FocusedNode:=TempNode;

    // noch schnell die Einträge alphabetisch sortieren
    VST.Sort(VSTRootNodes[11], 0, sdAscending);
  end;

  codeeditorform.Panel3.Visible:=false;
  codeeditorform.MouseDown.Visible:=true;
  codeeditorform.MouseUp.Visible:=true;
end;

procedure Tszenenverwaltungform.EditBtnClick(Sender: TObject);
var
  Data: PTreeData;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if VST.SelectedCount=0 then exit;

  Data:=VST.GetNodeData(VST.FocusedNode);

  if Assigned(Data) and (not Data^.IsRootNode) then
  begin
    mainform.EditScene(Data^.ID);

    Data:=VST.GetNodeData(VST.FocusedNode);
    Data^.Caption:=mainform.GetSceneInfo2(Data^.ID, 'name');
    Data^.Beschreibung:=mainform.GetSceneInfo2(Data^.ID, 'desc');
    Data^.Fadetime:=mainform.GetSceneInfo2(Data^.ID, 'time');
    positionselection:=Data^.ID;
    VST.Refresh;
  end;
end;

end.
