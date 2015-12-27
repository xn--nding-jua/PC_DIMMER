unit cuelistfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, PngBitBtn, ExtCtrls, Registry,
  szenenverwaltung, gnugettext, PngImageList, Menus, ComCtrls,
  SVATimer;

const
  {$I GlobaleKonstanten.inc} // maximale Kanalzahl für PC_DIMMER !Vorsicht! Bei Ändern des Wertes müssen einzelne Plugins und Forms ebenfalls verändert werden, da dort auch chan gesetzt wird! Auch die GUI muss angepasst werden

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: integer; // 0 Einfache Szenen, 1 Geräteszenen, 2 Audioszenen, 3 Bewegungsszenen, 4 Befehle, 5 Kombinationsszenen, 6 Presets, 7 Automatikszenen, 8 Effekt, 9 MediaCenter Szenen, 10 PluginSzenen
    IsRootNode:boolean;
    IsCatNode:boolean;
    Caption:WideString;
    Beschreibung:WideString;
    Fadetime:WideString;
    ID:TGUID;
  end;

  Tcuelistform = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BankSelect: TComboBox;
    Label1: TLabel;
    addBankBtn: TPngBitBtn;
    editBankBtn: TPngBitBtn;
    deleteBankBtn: TPngBitBtn;
    StringGrid1: TStringGrid;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Bevel1: TBevel;
    playBtn: TPngBitBtn;
    nextBtn: TPngBitBtn;
    backBtn: TPngBitBtn;
    upBtn: TPngBitBtn;
    downBtn: TPngBitBtn;
    addBtn: TPngBitBtn;
    editBtn: TPngBitBtn;
    deleteBtn: TPngBitBtn;
    stopBtn: TPngBitBtn;
    Timer1: TTimer;
    insertBtn: TPngBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    collection: TPngImageCollection;
    optionsbtn: TPngBitBtn;
    recordbtn: TPngBitBtn;
    GoBtn: TButton;
    PopupMenu2: TPopupMenu;
    AlleKanleaufnehmen1: TMenuItem;
    NurselektierteGerteaufnehmen1: TMenuItem;
    NurseitletzterSzenegenderteKanleaufnehmen1: TMenuItem;
    SelektierteGerteUNDgenderteKanleaufnehmen1: TMenuItem;
    Szenemanuelleinstellen1: TMenuItem;
    TrackBar1: TTrackBar;
    PopupMenu1: TPopupMenu;
    Beschreibungstextndern1: TMenuItem;
    EigeneFadezeitdefinieren1: TMenuItem;
    Laufzeitndern1: TMenuItem;
    Label2: TLabel;
    GoTimerLbl: TLabel;
    StopGoTimerBtn: TButton;
    GoTimer: TSVATimer;
    procedure CreateParams(var Params:TCreateParams);override;
    procedure editBankBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure addBankBtnClick(Sender: TObject);
    procedure deleteBankBtnClick(Sender: TObject);
    procedure BankSelectChange(Sender: TObject);
    procedure addBtnClick(Sender: TObject);
    procedure editBtnClick(Sender: TObject);
    procedure playBtnClick(Sender: TObject);
    procedure stopBtnClick(Sender: TObject);
    procedure nextBtnClick(Sender: TObject);
    procedure backBtnClick(Sender: TObject);
    procedure deleteBtnClick(Sender: TObject);
    procedure upBtnClick(Sender: TObject);
    procedure downBtnClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure insertBtnClick(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OwnFadeTimeBtnClick(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);
    procedure AlleKanleaufnehmen1Click(Sender: TObject);
    procedure NurselektierteGerteaufnehmen1Click(Sender: TObject);
    procedure NurseitletzterSzenegenderteKanleaufnehmen1Click(
      Sender: TObject);
    procedure SelektierteGerteUNDgenderteKanleaufnehmen1Click(
      Sender: TObject);
    procedure recordbtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Szenemanuelleinstellen1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar1Enter(Sender: TObject);
    procedure GoTimerTimer(Sender: TObject);
    procedure Laufzeitndern1Click(Sender: TObject);
    procedure optionsbtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Beschreibungstextndern1Click(Sender: TObject);
    procedure StopGoTimerBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    strgpressed:boolean;
    FileStream:TFileStream;
    toggled:boolean;
    CrossfadeStartValues, CrossfadeEndValues:array[1..chan] of byte;
    CrossfadeChannelEnabled:array[1..chan] of boolean;
    GoTimerValue:integer;
    procedure CopyBank(Source, Destination:integer);
    procedure FlipBankEntry(Source, Destination:integer);
    procedure CheckButtons;
    procedure PlayCue;
  public
    { Public-Deklarationen }
    procedure MSGNew;
    procedure MSGOpen;
    procedure MSGSave;
    procedure Openfile(Filename:string);
  end;

var
  cuelistform: Tcuelistform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tcuelistform.editBankBtnClick(Sender: TObject);
var
  Index:integer;
begin
  if (length(mainform.cuelistbank)<=0) or (BankSelect.ItemIndex>=length(mainform.cuelistbank)) then
    exit;

  Index:=BankSelect.ItemIndex;
  mainform.cuelistbank[BankSelect.ItemIndex].BankName:=InputBox(_('Neue Bank-Beschriftung'),_('Bitte geben Sie eine neue Bezeichnung für diese Cue-Bank ein:'),mainform.cuelistbank[BankSelect.ItemIndex].BankName);
  BankSelect.Items[BankSelect.ItemIndex]:=mainform.cuelistbank[BankSelect.ItemIndex].BankName;
  BankSelect.ItemIndex:=Index;
end;

procedure Tcuelistform.CreateParams(var Params:TCreateParams);
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

procedure Tcuelistform.MSGNew;
begin
  setlength(mainform.cuelistbank,0);
  BankSelect.items.Clear;
  BankSelectChange(BankSelect);

  setlength(mainform.cuelistbank,length(mainform.cuelistbank)+1);
  mainform.cuelistbank[length(mainform.cuelistbank)-1].BankName:=_('Neue Cue-Liste');
  BankSelect.ItemIndex:=BankSelect.Items.Add(_('Neue Cue-Liste'));
  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.MSGOpen;
var
  i:integer;
begin
  BankSelect.Items.Clear;

  for i:=0 to length(mainform.Cuelistbank)-1 do
    BankSelect.Items.Add(mainform.Cuelistbank[i].BankName);

  BankSelect.ItemIndex:=0;
  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.MSGSave;
begin
//
end;

procedure Tcuelistform.FormShow(Sender: TObject);
var
	LReg:TRegistry;
begin
  StringGrid1.DoubleBuffered:=true;

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
  			LReg.WriteBool('Showing Cuelist',true);

        if not LReg.KeyExists('Cuelist') then
	        LReg.CreateKey('Cuelist');
	      if LReg.OpenKey('Cuelist',true) then
	      begin
          if LReg.ValueExists('Width') then
            cuelistform.ClientWidth:=LReg.ReadInteger('Width')
            else
              cuelistform.ClientWidth:=779;
          if LReg.ValueExists('Heigth') then
            cuelistform.ClientHeight:=LReg.ReadInteger('Heigth')
            else
              cuelistform.ClientHeight:=476;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+cuelistform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              cuelistform.Left:=LReg.ReadInteger('PosX')
            else
              cuelistform.Left:=0;
          end else
            cuelistform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+cuelistform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              cuelistform.Top:=LReg.ReadInteger('PosY')
            else
              cuelistform.Top:=0;
          end else
            cuelistform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  Timer1.Enabled:=true;

  StringGrid1.Cells[0, 0]:=_('Position');
  StringGrid1.Cells[1, 0]:=_('Bild');
  StringGrid1.Cells[2, 0]:=_('Name')+#10#13+_('Beschreibung');
  StringGrid1.Cells[3, 0]:=_('Blendzeit')+#10#13+_('Typ');
  StringGrid1.Cells[4, 0]:=_('Eigene Beschreibung')+#10#13+_('Stichworte');
  StringGrid1.Cells[5, 0]:=_('Verwende Fadezeit');
  StringGrid1.Cells[6, 0]:=_('Eigene')+#10#13+_('Einblendzeit');
  StringGrid1.Cells[7, 0]:=_('Laufzeit');
  StringGrid1.Cells[8, 0]:=_('Stop nach')+#10#13+_('Ende Laufzeit');
end;

procedure Tcuelistform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  Timer1.Enabled:=false;

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
					LReg.WriteBool('Showing Cuelist',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;
  mainform.SaveWindowPositions('cuelist');
end;

procedure Tcuelistform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  MSGSave;
end;

procedure Tcuelistform.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tcuelistform.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Tcuelistform.addBankBtnClick(Sender: TObject);
begin
  setlength(mainform.cuelistbank,length(mainform.cuelistbank)+1);
  mainform.cuelistbank[length(mainform.cuelistbank)-1].BankName:=_('Neue Cue-Liste');
  BankSelect.ItemIndex:=BankSelect.Items.Add(_('Neue Cue-Liste'));
  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.deleteBankBtnClick(Sender: TObject);
var
  BankToDelete,i:integer;
begin
  if (length(mainform.cuelistbank)<=0) or (BankSelect.ItemIndex>=length(mainform.cuelistbank)) then
    exit;

  if messagedlg(_('Möchten Sie die aktuelle Bank wirklich löschen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    BankToDelete:=BankSelect.ItemIndex;

    if BankToDelete=length(mainform.cuelistbank)-1 then
    begin
      // Letzte Bank einfach löschen
      setlength(mainform.cuelistbank,length(mainform.cuelistbank)-1);
      BankSelect.Items.Delete(BankSelect.Items.Count-1);
      BankSelect.ItemIndex:=BankSelect.Items.Count-1;
    end else
    begin
      // alle nachliegenden Bänke um eins vorkopieren
      for i:=BankToDelete to length(mainform.cuelistbank)-2 do
        CopyBank(i+1, i);
      setlength(mainform.cuelistbank,length(mainform.cuelistbank)-1);
      BankSelect.Items.Delete(BankToDelete);
      BankSelect.ItemIndex:=BankToDelete;
    end;
    BankSelectChange(BankSelect);
  end;
  CheckButtons;
end;

procedure Tcuelistform.CopyBank(Source, Destination:integer);
var
  i:integer;
begin
  mainform.cuelistbank[Destination].BankName:=mainform.cuelistbank[Source].BankName;

  setlength(mainform.cuelistbank[Destination].cuelistbankitems,length(mainform.cuelistbank[Source].cuelistbankitems));
  for i:=0 to length(mainform.cuelistbank[Source].cuelistbankitems)-1 do
  begin
    mainform.cuelistbank[Destination].cuelistbankitems[i].ID:=mainform.cuelistbank[Source].cuelistbankitems[i].ID;
    mainform.cuelistbank[Destination].cuelistbankitems[i].OwnDescription:=mainform.cuelistbank[Source].cuelistbankitems[i].OwnDescription;
    mainform.cuelistbank[Destination].cuelistbankitems[i].Typ:=mainform.cuelistbank[Source].cuelistbankitems[i].Typ;

    mainform.cuelistbank[Destination].cuelistbankitems[i].UseFadetime:=mainform.cuelistbank[Source].cuelistbankitems[i].UseFadetime;
    mainform.cuelistbank[Destination].cuelistbankitems[i].FadeTime:=mainform.cuelistbank[Source].cuelistbankitems[i].FadeTime;
    mainform.cuelistbank[Destination].cuelistbankitems[i].LiveTime:=mainform.cuelistbank[Source].cuelistbankitems[i].LiveTime;
    mainform.cuelistbank[Destination].cuelistbankitems[i].StopCueIfTimeOver:=mainform.cuelistbank[Source].cuelistbankitems[i].StopCueIfTimeOver;
  end;
end;

procedure Tcuelistform.FlipBankEntry(Source, Destination:integer);
begin
  // aktuellen Eintrag temporär ans Ende kopieren
  setlength(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems,length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)+1);
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].ID:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].ID;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].OwnDescription:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].OwnDescription;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].Typ:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].Typ;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].UseFadetime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].UseFadetime;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].FadeTime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].FadeTime;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].LiveTime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].LiveTime;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].StopCueIfTimeOver:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].StopCueIfTimeOver;

  // oberen Einträge aufrutschen
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].ID:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].ID;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].OwnDescription:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].OwnDescription;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].Typ:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].Typ;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].UseFadetime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].UseFadetime;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].FadeTime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].FadeTime;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].LiveTime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].LiveTime;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Source].StopCueIfTimeOver:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].StopCueIfTimeOver;

  // letzten Eintrag einfügen
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].ID:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].ID;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].OwnDescription:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].OwnDescription;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].Typ:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].Typ;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].UseFadeTime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].UseFadeTime;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].FadeTime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].FadeTime;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].LiveTime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].LiveTime;
  mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[Destination].StopCueIfTimeOver:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1].StopCueIfTimeOver;
  setlength(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems,length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1);
end;

procedure Tcuelistform.BankSelectChange(Sender: TObject);
var
  i:integer;
  Name, Beschreibung, Blendzeit, Typ:string;
  BtnsEnabled:boolean;
begin
  BtnsEnabled:=(length(mainform.cuelistbank)>0) and (BankSelect.ItemIndex<length(mainform.cuelistbank));
  addBtn.enabled:=BtnsEnabled;
  recordbtn.Enabled:=BtnsEnabled;
  insertBtn.Enabled:=BtnsEnabled;

  if (length(mainform.cuelistbank)<=0) or (BankSelect.ItemIndex>=length(mainform.cuelistbank)) then
  begin
    StringGrid1.RowCount:=2;
    StringGrid1.Cells[0,1]:='';
    StringGrid1.Cells[1,1]:='-';
    StringGrid1.Cells[2,1]:='-';
    StringGrid1.Cells[3,1]:='-';
    StringGrid1.Cells[4,1]:='-';
    StringGrid1.Cells[5,1]:='';
    StringGrid1.Cells[6,1]:='-';
    StringGrid1.Cells[7,1]:='-';
    exit;
  end else
  begin
    if length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)>=1 then
      StringGrid1.RowCount:=length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)+1
    else
    begin
      StringGrid1.RowCount:=2;
      if length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)=0 then
      begin
        StringGrid1.Cells[0,1]:=' ';
        StringGrid1.Cells[1,1]:='-';
        StringGrid1.Cells[2,1]:='-';
        StringGrid1.Cells[3,1]:='-';
        StringGrid1.Cells[4,1]:='-';
        StringGrid1.Cells[5,1]:='';
        StringGrid1.Cells[6,1]:='-';
        StringGrid1.Cells[7,1]:='-';
      end;
    end;

    for i:=0 to length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1 do
    begin
      mainform.GetSceneInfo(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[i].ID, Name, Beschreibung, Blendzeit, Typ);
      StringGrid1.Cells[0,i+1]:=inttostr(i+1);
      StringGrid1.Cells[2,i+1]:=Name+#10#13+Beschreibung;
      StringGrid1.Cells[3,i+1]:=Blendzeit+#10#13+Typ;
      StringGrid1.Cells[4,i+1]:=mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[i].OwnDescription;
      StringGrid1.Cells[6,i+1]:=mainform.MillisecondsToTimeShort(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[i].FadeTime);
      if mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[i].LiveTime>=0 then
        StringGrid1.Cells[7,i+1]:=mainform.MillisecondsToTimeShort(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[i].LiveTime)
      else
        StringGrid1.Cells[7,i+1]:='oo';
    end;
  end;
  CheckButtons;

  for i:=0 to Stringgrid1.RowCount-1 do
    Stringgrid1.RowHeights[i]:=32;
end;

procedure Tcuelistform.addBtnClick(Sender: TObject);
var
  SzenenData:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

//  if szenenverwaltungform.showmodal=mrOK then
  if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
  begin
    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
    SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

    setlength(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems,length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)+1);
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].ID:=SzenenData^.ID;
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].OwnDescription:='';
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].Typ:=mainform.GetSceneType(SzenenData^.ID);
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].LiveTime:=-1;
  end;

  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);

  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.editBtnClick(Sender: TObject);
begin
//  if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
//    mainform.EditScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID);
  if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
    mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID:=mainform.ChangeSceneWithLibrary(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID);

  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.playBtnClick(Sender: TObject);
begin
  PlayCue;
end;

procedure Tcuelistform.stopBtnClick(Sender: TObject);
begin
  if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
  begin
    mainform.StopScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID);
    GoTimer.Enabled:=false;
    GoTimerValue:=0;
  end;
end;

procedure Tcuelistform.nextBtnClick(Sender: TObject);
begin
  if StringGrid1.Row<StringGrid1.RowCount-1 then
  begin
    StringGrid1.Row:=StringGrid1.Row+1;
    if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
    begin
      if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].UseFadetime then
        mainform.StartScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID,false,false,mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Fadetime)
      else
        mainform.StartScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID,false,false);

      if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime>=0 then
      begin
        GoTimerValue:=mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime;
        GoTimer.Enabled:=true;
      end;
    end;
  end;
end;

procedure Tcuelistform.backBtnClick(Sender: TObject);
begin
  if StringGrid1.Row>1 then
  begin
    StringGrid1.Row:=StringGrid1.Row-1;
    if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
    begin
      if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].UseFadetime then
        mainform.StartScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID,false,false,mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Fadetime)
      else
        mainform.StartScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID,false,false);

      if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime>=0 then
      begin
        GoTimerValue:=mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime;
        GoTimer.Enabled:=true;
      end;
    end;
  end;
end;

procedure Tcuelistform.deleteBtnClick(Sender: TObject);
var
  EntryToDelete,i:integer;
begin
  EntryToDelete:=StringGrid1.Row-1;
  if EntryToDelete=length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1 then
  begin
    // Letzten Eintrag einfach löschen
    setlength(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems,length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1);
  end else
  begin
    // alle nachliegenden Einträge um eins vorkopieren
    for i:=EntryToDelete to length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-2 do
    begin
      mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i].ID:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i+1].ID;
      mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i].OwnDescription:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i+1].OwnDescription;
      mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i].Typ:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i+1].Typ;
      mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i].UseFadeTime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i+1].UseFadeTime;
      mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i].Fadetime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i+1].FadeTime;
      mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i].LiveTime:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i+1].LiveTime;
      mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i].StopCueIfTimeOver:=mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems[i+1].StopCueIfTimeOver;
    end;
    setlength(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems,length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)-1);
  end;

  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.upBtnClick(Sender: TObject);
begin
  if StringGrid1.Row>1 then
  begin
    // nach unten verschieben
    FlipBankEntry(StringGrid1.Row-1,StringGrid1.Row-2);
    // Position mitführen
    StringGrid1.Row:=StringGrid1.Row-1;
  end;

  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.downBtnClick(Sender: TObject);
begin
  if StringGrid1.Row<StringGrid1.RowCount-1 then
  begin
    // nach unten verschieben
    FlipBankEntry(StringGrid1.Row-1,StringGrid1.Row);
    // Position mitführen
    StringGrid1.Row:=StringGrid1.Row+1;
  end;

  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  S: String;
  drawrect,ownrect :trect;

	AOffSet : TPoint;
	AHaken1 : TPoint;
	AHaken2 : TPoint;
	AHaken3 : TPoint;
	ARect : TRect;
begin
  if (BankSelect.ItemIndex>-1) and (BankSelect.ItemIndex<length(mainform.cuelistbank)) and
    (length(mainform.cuelistbank[BankSelect.ItemIndex].cuelistbankitems)>0) and
    ((ARow-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems)) then
  begin
    if ((ARow-1)>=0) and mainform.IsSceneActive(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[ARow-1].ID) then
    begin
      S:=(Sender As TStringgrid).Cells[ ACol, ARow ];
  //    if Length(S) > 0 then
      begin
        drawrect := rect;

        DrawText((Sender As TStringgrid).canvas.handle, Pchar(S), Length(S), drawrect, dt_calcrect or dt_wordbreak or dt_left);
        if (drawrect.bottom - drawrect.top) > (Sender As TStringgrid).RowHeights[Arow] then
        begin
          (Sender As TStringgrid).RowHeights[Arow]:=(drawrect.bottom - drawrect.top);
        end else
        begin
          drawrect.Right := rect.right;
          (Sender As TStringgrid).canvas.fillrect( drawrect );

          if (GoTimerValue<5000) and (GoTimerValue>0) then
            (sender as TStringgrid).canvas.Brush.color:=clRed
          else
            (sender as TStringgrid).canvas.Brush.color:=clLime;
          (sender as TStringgrid).canvas.FillRect(rect);
          (sender as TStringgrid).canvas.Font.Color:=clBlack;
          (sender as TStringgrid).canvas.Font.Style:=[fsBold];

          DrawText((Sender As TStringgrid).canvas.handle, Pchar(S), Length(S), drawrect, dt_wordbreak or dt_left);
        end;
      end;
    end else
    begin
      if (ARow=0) or (ACol=0) then
      begin
        (sender as TStringgrid).canvas.Brush.color:=clSilver;//clBtnFace;
        (sender as TStringgrid).canvas.Font.Color:=clBlack;
      end else
      begin
        if StringGrid1.Row=ARow then
        begin
          if (GoTimerValue<5000) and (GoTimerValue>0) then
            (sender as TStringgrid).canvas.Brush.color:=clRed
          else
            (sender as TStringgrid).canvas.Brush.color:=clNavy;//clMenuHighlight
        end else
          (sender as TStringgrid).canvas.Brush.color:=(sender as TStringgrid).color;
        (sender as TStringgrid).canvas.Font.Color:=clWhite;
      end;

      S:= (Sender As TStringgrid).Cells[ ACol, ARow ];
  //    if Length(S) > 0 then
      begin
        drawrect := rect;

        DrawText((Sender As TStringgrid).canvas.handle, Pchar(S), Length(S), drawrect, dt_calcrect or dt_wordbreak or dt_left);
        if (drawrect.bottom - drawrect.top) > (Sender As TStringgrid).RowHeights[Arow] then
        begin
          (Sender As TStringgrid).RowHeights[Arow]:=(drawrect.bottom - drawrect.top);
        end else
        begin
          drawrect.Right := rect.right;
          (Sender As TStringgrid).canvas.fillrect( drawrect );

          (sender as TStringgrid).canvas.Font.Style:=[];
//          if (ARow=0) or (ACol=0) then
//            (sender as TStringgrid).canvas.Font.Style:=[fsBold];
          (sender as TStringgrid).canvas.FillRect(rect);

          DrawText((Sender As TStringgrid).canvas.handle, Pchar(S), Length(S), drawrect, dt_wordbreak or dt_left);
        end;
      end;
    end;
  end else
  begin
    if (ARow=0) or (ACol=0) then
    begin
      (sender as TStringgrid).canvas.Brush.color:=clSilver;//clBtnFace;
      (sender as TStringgrid).canvas.Font.Color:=clBlack;
    end else
    begin
      if StringGrid1.Row=ARow then
      begin
        if (GoTimerValue<5000) and (GoTimerValue>0) then
          (sender as TStringgrid).canvas.Brush.color:=clRed
        else
          (sender as TStringgrid).canvas.Brush.color:=clNavy;//clMenuHighlight
      end else
        (sender as TStringgrid).canvas.Brush.color:=(sender as TStringgrid).color;
      (sender as TStringgrid).canvas.Font.Color:=clWhite;
    end;

    S:= (Sender As TStringgrid).Cells[ ACol, ARow ];
//    if Length(S) > 0 then
    begin
      drawrect := rect;

      DrawText((Sender As TStringgrid).canvas.handle, Pchar(S), Length(S), drawrect, dt_calcrect or dt_wordbreak or dt_left);
      if (drawrect.bottom - drawrect.top) > (Sender As TStringgrid).RowHeights[Arow] then
      begin
        (Sender As TStringgrid).RowHeights[Arow]:=(drawrect.bottom - drawrect.top);
      end else
      begin
        drawrect.Right := rect.right;
        (Sender As TStringgrid).canvas.fillrect( drawrect );

        (sender as TStringgrid).canvas.Font.Style:=[];
//        if (ARow=0) or (ACol=0) then
//          (sender as TStringgrid).canvas.Font.Style:=[fsBold];
        (sender as TStringgrid).canvas.FillRect(rect);

        DrawText((Sender As TStringgrid).canvas.handle, Pchar(S), Length(S), drawrect, dt_wordbreak or dt_left);
      end;
    end;
  end;

  // Gerätebilder anzeigen
  if (BankSelect.Itemindex>-1) then
  if (ARow>0) and (ACol = 1) and (ARow<=length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems)) then
  begin
    ownrect.Left:=rect.Left;
    ownrect.Top:=rect.Top;
    ownrect.Right:=ownrect.Left+32;
    ownrect.Bottom:=ownrect.Top+32;
    collection.Items.Items[mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[ARow-1].Typ].PngImage.Draw(StringGrid1.Canvas, ownrect);
  end;

  // Checkbox anzeigen
  if (BankSelect.Itemindex>-1) then
  with (sender as TStringgrid).canvas do
  if (ARow>0) and (ACol = 5) then
  begin
    //Kasten zeichnen
    AOffSet.X := (Rect.Right - Rect.Left - 11) div 2;
    AOffSet.Y := (Rect.Bottom - Rect.Top - 11) div 2;

    ARect.Left := AOffSet.X + Rect.Left;
    ARect.Top := AOffSet.Y + Rect.Top;
    ARect.Right := AOffSet.X + Rect.Left + 11;
    ARect.Bottom := AOffSet.Y + Rect.Top + 11;

    Pen.Color := clSilver;
    Rectangle(ARect);

    // Abfrage ob Haken zeichnen oder nicht
    if (ARow>0) and (ARow<=length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems)) then
    if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[ARow-1].UseFadetime then
    begin
      //Haken zeichnen
      AHaken1.X := ARect.Left + 2;
      AHaken1.Y := ARect.Top + 6;
      AHaken2.X := ARect.Left + 4;
      AHaken2.Y := ARect.Top + 8;
      AHaken3.X := ARect.Left + 9;
      AHaken3.Y := ARect.Top + 3;

      Pen.Color := clWhite; // Farbe des Häkchens

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
  // Checkbox anzeigen
  if (BankSelect.Itemindex>-1) then
  with (sender as TStringgrid).canvas do
  if (ARow>0) and (ACol = 8) then
  begin
    //Kasten zeichnen
    AOffSet.X := (Rect.Right - Rect.Left - 11) div 2;
    AOffSet.Y := (Rect.Bottom - Rect.Top - 11) div 2;

    ARect.Left := AOffSet.X + Rect.Left;
    ARect.Top := AOffSet.Y + Rect.Top;
    ARect.Right := AOffSet.X + Rect.Left + 11;
    ARect.Bottom := AOffSet.Y + Rect.Top + 11;

    Pen.Color := clSilver;
    Rectangle(ARect);

    // Abfrage ob Haken zeichnen oder nicht
    if (ARow>0) and (ARow<=length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems)) then
    if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[ARow-1].StopCueIfTimeOver then
    begin
      //Haken zeichnen
      AHaken1.X := ARect.Left + 2;
      AHaken1.Y := ARect.Top + 6;
      AHaken2.X := ARect.Left + 4;
      AHaken2.Y := ARect.Top + 8;
      AHaken3.X := ARect.Left + 9;
      AHaken3.Y := ARect.Top + 3;

      Pen.Color := clWhite; // Farbe des Häkchens

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
end;

procedure Tcuelistform.Timer1Timer(Sender: TObject);
begin
  StringGrid1.Refresh;
end;

procedure Tcuelistform.insertBtnClick(Sender: TObject);
var
  AktuellePosition,i:integer;
  SzenenData:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  AktuellePosition:=StringGrid1.Row-1;

  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

//  if szenenverwaltungform.showmodal=mrOK then
  if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
  begin
    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
    SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

    setlength(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems,length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)+1);
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].ID:=SzenenData^.ID;
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].OwnDescription:='';
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].Typ:=mainform.GetSceneType(SzenenData^.ID);
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].LiveTime:=-1;
  end;

  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);

  if Stringgrid1.Row<Stringgrid1.RowCount-1 then
  begin
    setlength(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems,length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)+1);
    for i:=length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-2 downto AktuellePosition+2 do
    begin
      FlipBankEntry(i, i-1);
    end;
    setlength(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems,length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1);
    StringGrid1.Row:=StringGrid1.Row+1;
  end;

  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift=[ssctrl] then
    strgpressed:=true;
  StringGrid1.Refresh;
end;

procedure Tcuelistform.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not mainform.UserAccessGranted(2) then exit;

  GoTimer.enabled:=false;
  GoTimerLbl.caption:=mainform.MillisecondsToTime(0);

  strgpressed:=false;
  CheckButtons;

  if ((StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems)) then
  begin
    if (key=vk_return) then
    begin
      GoBtnClick(nil);
    end else if (key=190) then // Punkttaste gedrückt
    begin
      mainform.StopScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID);
    end else if (key=vk_space) then
    begin
      PlayCue;
    end;
  end;
  StringGrid1.Refresh;

  Trackbar1.Position:=0;
  Toggled:=false;
end;

procedure Tcuelistform.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  if Shift=[ssctrl] then
    strgpressed:=true;
  StringGrid1.Refresh;
end;

procedure Tcuelistform.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  GoTimer.enabled:=false;
  GoTimerLbl.caption:=mainform.MillisecondsToTime(0);

  if (StringGrid1.Col=5) and (StringGrid1.Row>0) and (BankSelect.Itemindex>-1) and ((StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems)) then
  begin
    mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].UseFadetime:=not mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].UseFadetime;
  end;
  if (StringGrid1.Col=8) and (StringGrid1.Row>0) and (BankSelect.Itemindex>-1) and ((StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems)) then
  begin
    mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].StopCueIfTimeOver:=not mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].StopCueIfTimeOver;
  end;

  if Shift=[] then
    strgpressed:=false;
  CheckButtons;
  StringGrid1.Refresh;

  Trackbar1.Position:=0;
  Toggled:=false;
end;

procedure Tcuelistform.SpeedButton3Click(Sender: TObject);
begin
  if (length(mainform.Cuelistbank)=0) or (BankSelect.ItemIndex>=length(mainform.Cuelistbank)) then
    exit;

  if messagedlg(_('Möchten Sie die aktuelle Cue-Liste löschen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    setlength(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems,0);
    BankSelectChange(BankSelect);
  end;
end;

procedure Tcuelistform.Openfile(Filename:string);
var
  j, count2, FileVersion:integer;
begin
  if FileExists(Filename) then
  begin
    FileStream:=TFileStream.Create(FileName, fmOpenRead);

    // Projektversion
    Filestream.ReadBuffer(FileVersion, sizeof(FileVersion));

    FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].BankName, sizeof(mainform.Cuelistbank[BankSelect.Itemindex].BankName));
    FileStream.ReadBuffer(count2, sizeof(count2));
    setlength(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems,count2);
    for j:=0 to count2-1 do
    begin
      FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].ID,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].ID));
      FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].OwnDescription,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].OwnDescription));
      FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Typ,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Typ));
      if FileVersion>=455 then
      begin
        FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].UseFadetime,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].UseFadetime));
        FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Fadetime,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Fadetime));
        FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].LiveTime,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].LiveTime));
        FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].StopCueIfTimeOver,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].StopCueIfTimeOver));
      end;
    end;

    FileStream.Free;
  end;
end;

procedure Tcuelistform.SpeedButton2Click(Sender: TObject);
var
  j, startindex, count2, FileVersion:integer;
  additiv:boolean;
begin
  if (length(mainform.Cuelistbank)=0) or (BankSelect.ItemIndex>=length(mainform.Cuelistbank)) then
    exit;

  additiv:=true;

	case mainform.mymessagedlg(_('Wie soll die Cue-Liste aus der Datei geladen werden?'),mtConfirmation,[mbYes,mbAll,mbCancel],[_('&Hinzufügen'),_('&Ersetzen'),_('Ab&brechen')]) of
    mrYes: additiv:=true;
    mrCancel: additiv:=false;
    mrAll: exit;
  end;

  if OpenDialog1.Execute then
  begin
    if additiv then
    begin
      startindex:=length(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems)-1;

      FileStream:=TFileStream.Create(Opendialog1.FileName, fmOpenRead);

      // Projektversion
      Filestream.ReadBuffer(FileVersion, sizeof(FileVersion));

      FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].BankName,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].BankName));
      FileStream.ReadBuffer(count2,sizeof(count2));
      setlength(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems,startindex+1+count2);
      for j:=(startindex+1) to length(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems)-1 do
      begin
        FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].ID,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].ID));
        FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].OwnDescription,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].OwnDescription));
        FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Typ,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Typ));
        if FileVersion>=455 then
        begin
          FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].UseFadetime,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].UseFadetime));
          FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Fadetime,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Fadetime));
          FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].LiveTime,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].LiveTime));
          FileStream.ReadBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].StopCueIfTimeOver,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].StopCueIfTimeOver));
        end;
      end;

      FileStream.Free;
    end else
    begin
      Openfile(Opendialog1.Filename);
    end;

    BankSelectChange(BankSelect);
  end;
end;

procedure Tcuelistform.SpeedButton1Click(Sender: TObject);
var
  j, count, count2:integer;
begin
  if (length(mainform.Cuelistbank)=0) or (BankSelect.ItemIndex>=length(mainform.Cuelistbank)) then
    exit;

  if SaveDialog1.Execute then
  begin
    FileStream:=TFileStream.Create(Savedialog1.FileName, fmCreate);

    // Projektversion
    count:=mainform.currentprojectversion;
    Filestream.WriteBuffer(Count, sizeof(Count));

    FileStream.WriteBuffer(mainform.Cuelistbank[BankSelect.Itemindex].BankName,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].BankName));
    count2:=length(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems);
    FileStream.WriteBuffer(count2,sizeof(count2));
    for j:=0 to count2-1 do
    begin
      FileStream.WriteBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].ID,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].ID));
      FileStream.WriteBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].OwnDescription,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].OwnDescription));
      FileStream.WriteBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Typ,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Typ));
      FileStream.WriteBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].UseFadetime,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].UseFadetime));
      FileStream.WriteBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Fadetime,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].Fadetime));
      FileStream.WriteBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].LiveTime,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].LiveTime));
      FileStream.WriteBuffer(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].StopCueIfTimeOver,sizeof(mainform.Cuelistbank[BankSelect.Itemindex].Cuelistbankitems[j].StopCueIfTimeOver));
    end;

    FileStream.Free;
  end;
end;

procedure Tcuelistform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tcuelistform.StringGrid1DblClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (BankSelect.Itemindex>-1) and ((StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems)) then
    mainform.EditScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID);
  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.CheckButtons;
var
  BtnsEnabled:boolean;
begin
  BtnsEnabled:=(BankSelect.Itemindex>-1) and (length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems)>0) and (StringGrid1.Row>0) and (StringGrid1.Row<=length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems));
  backBtn.enabled:=BtnsEnabled;
  playBtn.enabled:=BtnsEnabled;
  Trackbar1.Enabled:=BtnsEnabled;
  GoBtn.Enabled:=BtnsEnabled;
  stopBtn.enabled:=BtnsEnabled;
  nextBtn.enabled:=BtnsEnabled;
  editBtn.enabled:=BtnsEnabled;
  optionsbtn.enabled:=BtnsEnabled;
  Beschreibungstextndern1.Enabled:=BtnsEnabled;
  EigeneFadezeitdefinieren1.Enabled:=BtnsEnabled;
  Laufzeitndern1.Enabled:=BtnsEnabled;

  deleteBtn.enabled:=BtnsEnabled;
  upBtn.enabled:=BtnsEnabled;
  downBtn.enabled:=BtnsEnabled;

  editBankBtn.enabled:=(BankSelect.ItemIndex>-1) and (BankSelect.Items.Count>0);
  deleteBankBtn.enabled:=(BankSelect.ItemIndex>-1) and (BankSelect.Items.Count>0);
end;

procedure Tcuelistform.OwnFadeTimeBtnClick(Sender: TObject);
begin
  if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
    mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].FadeTime:=strtoint(InputBox(_('Einblendzeit ändern'), _('Bitte geben Sie eine eigene Einblendzeit für diesen Cue an (Szenen werden nicht verändert, negative Werte=Zufall):'),inttostr(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].FadeTime)));

  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.GoBtnClick(Sender: TObject);
begin
  if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].UseFadetime then
    mainform.StartScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID,false,false,mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Fadetime)
  else
    mainform.StartScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID,false,false);

  // die nächste Zeile anspringen
  if StringGrid1.Row<StringGrid1.RowCount-1 then
    StringGrid1.Row:=StringGrid1.Row+1;
end;

procedure Tcuelistform.AlleKanleaufnehmen1Click(Sender: TObject);
var
  ID:TGUID;
begin
  if not mainform.UserAccessGranted(1) then exit;

  ID:=mainform.RecordScene(0);

  setlength(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems,length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)+1);
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].ID:=ID;
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].OwnDescription:='';
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].Typ:=mainform.GetSceneType(ID);
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].LiveTime:=-1;
  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.NurselektierteGerteaufnehmen1Click(Sender: TObject);
var
  ID:TGUID;
begin
  if not mainform.UserAccessGranted(1) then exit;

  ID:=mainform.RecordScene(1);

  setlength(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems,length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)+1);
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].ID:=ID;
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].OwnDescription:='';
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].Typ:=mainform.GetSceneType(ID);
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].LiveTime:=-1;
  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.NurseitletzterSzenegenderteKanleaufnehmen1Click(
  Sender: TObject);
var
  ID:TGUID;
begin
  if not mainform.UserAccessGranted(1) then exit;

  ID:=mainform.RecordScene(2);

  setlength(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems,length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)+1);
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].ID:=ID;
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].OwnDescription:='';
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].Typ:=mainform.GetSceneType(ID);
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].LiveTime:=-1;
  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.SelektierteGerteUNDgenderteKanleaufnehmen1Click(
  Sender: TObject);
var
  ID:TGUID;
begin
  if not mainform.UserAccessGranted(1) then exit;

  ID:=mainform.RecordScene(3);

  setlength(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems,length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)+1);
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].ID:=ID;
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].OwnDescription:='';
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].Typ:=mainform.GetSceneType(ID);
  mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].LiveTime:=-1;
  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.recordbtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(1) then exit;

  Popupmenu2.Popup(cuelistform.Left+Panel1.Left+RecordBtn.Left+x,cuelistform.Top+RecordBtn.Top+Panel1.Top+RecordBtn.Height+y);
end;

procedure Tcuelistform.Szenemanuelleinstellen1Click(Sender: TObject);
var
  ID:TGUID;
begin
  if not mainform.UserAccessGranted(1) then exit;

  ID:=mainform.RecordScene(4);

  if GUIDtoString(ID)<>'{00000000-0000-0000-0000-000000000000}' then
  begin
    setlength(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems,length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)+1);
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].ID:=ID;
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].OwnDescription:='';
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].Typ:=mainform.GetSceneType(ID);
    mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems[length(mainform.Cuelistbank[BankSelect.Itemindex].cuelistbankitems)-1].LiveTime:=-1;
    BankSelectChange(BankSelect);
  end;
end;

procedure Tcuelistform.TrackBar1Change(Sender: TObject);
var
  i, value:integer;
begin
  if not Trackbar1.Focused then exit;

  if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
  begin
    if toggled then
    begin
      if (mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Typ=0) or (mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Typ=1) then
      for i:=1 to mainform.lastchan do
      begin
        if CrossfadeChannelEnabled[i] then
          mainform.Senddata(i, -1, 255-(round(CrossfadeStartValues[i]*(Trackbar1.Position/255))+round(CrossfadeEndValues[i]*((255-Trackbar1.Position)/255))), 0);
      end;

      if (Trackbar1.position>100) and (Trackbar1.position<156) and (mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Typ>=2) then
      begin
        PlayCue;
        TrackBar1Enter(nil);
      end;

      if Trackbar1.position=0 then
      begin
        if StringGrid1.Row<StringGrid1.RowCount-1 then
          StringGrid1.Row:=StringGrid1.Row+1;

        if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Typ<2 then
        begin
          for i:=1 to mainform.lastchan do
          begin
            CrossfadeStartValues[i]:=mainform.channel_value[i];

            value:=mainform.GetDeviceSceneChannelValue(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID, i);
            CrossfadeChannelEnabled[i]:=(value>-512);
            if value<0 then value:=abs(value);
            if value>255 then value:=255;
            CrossfadeEndValues[i]:=value;
          end;
        end else
        begin
          //PlayCue;
          //TrackBar1Enter(nil);
        end;

        toggled:=not toggled;
      end;
    end else
    begin
      if (mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Typ=0) or (mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Typ=1) then
      for i:=1 to mainform.lastchan do
      begin
        if CrossfadeChannelEnabled[i] then
          mainform.Senddata(i, -1, 255-(round(CrossfadeStartValues[i]*((255-Trackbar1.Position)/255))+round(CrossfadeEndValues[i]*(Trackbar1.Position/255))), 0);
      end;

      if (Trackbar1.position>100) and (Trackbar1.position<156) and (mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Typ>=2) then
      begin
        PlayCue;
        TrackBar1Enter(nil);
      end;

      if Trackbar1.position=255 then
      begin
        if StringGrid1.Row<StringGrid1.RowCount-1 then
          StringGrid1.Row:=StringGrid1.Row+1;

        if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Typ<2 then
        begin
          for i:=1 to mainform.lastchan do
          begin
            CrossfadeStartValues[i]:=mainform.channel_value[i];

            value:=mainform.GetDeviceSceneChannelValue(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID, i);
            CrossfadeChannelEnabled[i]:=(value>-512);
            if value<0 then value:=abs(value);
            if value>255 then value:=255;
            CrossfadeEndValues[i]:=value;
          end;
        end else
        begin
          //PlayCue;
          //TrackBar1Enter(nil);
        end;

        toggled:=not toggled;
      end;
    end;
  end;
end;

procedure Tcuelistform.TrackBar1Enter(Sender: TObject);
var
  i,value:integer;
begin
  if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
  if (mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Typ=0) or (mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Typ=1) then
  if (Trackbar1.Position=0) or (Trackbar1.Position=255) then
  for i:=1 to mainform.lastchan do
  begin
    CrossfadeStartValues[i]:=mainform.channel_value[i];

    value:=mainform.GetDeviceSceneChannelValue(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID, i);
    CrossfadeChannelEnabled[i]:=(value>-512);
    if value<0 then value:=abs(value);
    if value>255 then value:=255;
    CrossfadeEndValues[i]:=value;
  end;
end;

procedure Tcuelistform.GoTimerTimer(Sender: TObject);
begin
  GoTimerValue:=GoTimerValue-1;

  if ((GoTimerValue>0) and (frac(GoTimerValue/10)=0)) or (GoTimerValue=0) then
  begin
    GoTimerLbl.caption:=mainform.MillisecondsToTime(GoTimerValue);
  end;

  if GoTimerValue<=0 then
  begin
    GoTimer.enabled:=false;
    GoTimerValue:=0;
    GoTimerLbl.caption:=mainform.MillisecondsToTime(GoTimerValue);

    if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
    begin
      if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].StopCueIfTimeOver then
        mainform.StopScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID);

      // die nächste Zeile anspringen
      if (StringGrid1.Row+1)<StringGrid1.RowCount then
      begin
        if StringGrid1.Row<StringGrid1.RowCount-1 then
          StringGrid1.Row:=StringGrid1.Row+1;
        PlayCue;
        Exit;
      end;
    end;
  end;
end;

procedure Tcuelistform.Laufzeitndern1Click(Sender: TObject);
begin
  if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
    mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime:=strtoint(InputBox(_('Laufzeit ändern'), _('Bitte geben Sie eine Laufzeit für diesen Cue an (-1=Unendlich, 0=Sofort, ansonsten Zeiten >500ms):'),inttostr(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime)));
  if (mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime>0) and (mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime<500) then
  begin
    mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime:=500;
  end;
  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.optionsbtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Popupmenu1.Popup(cuelistform.Left+Panel1.Left+optionsbtn.Left+x,cuelistform.Top+optionsbtn.Top+Panel1.Top+optionsbtn.Height+y);
end;

procedure Tcuelistform.Beschreibungstextndern1Click(Sender: TObject);
begin
  if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
    mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].OwnDescription:=InputBox(_('Beschreibung ändern'), _('Bitte geben Sie eine kurze Beschreibung für diesen Cue an:'),mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].OwnDescription);

  BankSelectChange(BankSelect);
end;

procedure Tcuelistform.StopGoTimerBtnClick(Sender: TObject);
begin
  GoTimer.enabled:=false;
  GoTimerLbl.caption:=mainform.MillisecondsToTime(0);
end;

procedure Tcuelistform.PlayCue;
begin
  if (StringGrid1.Row-1)<length(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems) then
  begin
    if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].UseFadetime then
      mainform.StartScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID,false,false,mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].Fadetime)
    else
      mainform.StartScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID,false,false);

    if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime>=500 then
    begin
      GoTimerValue:=mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime;
      GoTimer.Enabled:=true;
    end else if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].LiveTime>=0 then
    begin
      if mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].StopCueIfTimeOver then
        mainform.StopScene(mainform.cuelistbank[BankSelect.Itemindex].cuelistbankitems[StringGrid1.Row-1].ID);

      // die nächste Zeile anspringen
      if (StringGrid1.Row+1)<StringGrid1.RowCount then
      begin
        if StringGrid1.Row<StringGrid1.RowCount-1 then
          StringGrid1.Row:=StringGrid1.Row+1;
        PlayCue;
        Exit;
      end;
    end;
  end;
end;

end.
