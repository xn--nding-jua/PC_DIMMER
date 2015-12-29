unit timecodeplayerfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, midievent, gnugettext, Buttons, PngBitBtn,
  Grids, szenenverwaltung, Registry, SVATimer;

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

  Ttimecodeplayerform = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    MidiTimecodeLbl: TLabel;
    mtc_mode: TLabel;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Label2: TLabel;
    editBtn: TPngBitBtn;
    deleteBtn: TPngBitBtn;
    addBtn: TPngBitBtn;
    playBtn: TPngBitBtn;
    stopBtn: TPngBitBtn;
    GroupBox2: TGroupBox;
    BankSelect: TComboBox;
    addBankBtn: TPngBitBtn;
    editBankBtn: TPngBitBtn;
    deleteBankBtn: TPngBitBtn;
    seteffecttoactualpositionbtn: TPngBitBtn;
    Timer1: TTimer;
    Timer2: TTimer;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    GetMIDITimecodeTimer: TSVATimer;
    procedure CreateParams(var Params:TCreateParams);override;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BankSelectChange(Sender: TObject);
    procedure addBankBtnClick(Sender: TObject);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure deleteBankBtnClick(Sender: TObject);
    procedure editBankBtnClick(Sender: TObject);
    procedure playBtnClick(Sender: TObject);
    procedure stopBtnClick(Sender: TObject);
    procedure deleteBtnClick(Sender: TObject);
    procedure editBtnClick(Sender: TObject);
    procedure addBtnClick(Sender: TObject);
    procedure seteffecttoactualpositionbtnClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure EntrySort(iLo, iHi:integer);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    function MIDITimeToString(Time, Frame:Integer):String;
    procedure Timer1Timer(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BankSelectDropDown(Sender: TObject);
    procedure BankSelectCloseUp(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure GetMIDITimecodeTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
    FileStream:TFilestream;
    AlreadyPlayed:array of Boolean;
    CurrentTimecodeSource:integer;
    CurrentTimecodeBank:integer;
    procedure CopyBank(Source, Destination:integer);
//    procedure FlipBankEntry(Source, Destination:integer);
    procedure CopyEntry(Source, Destination:integer);
    procedure CheckButtons;
  public
    { Public-Deklarationen }
    MidiTime:Cardinal;
    procedure NewFile;
    procedure MSGOpen;
    procedure Openfile(Filename: string);
  end;

var
  timecodeplayerform: Ttimecodeplayerform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Ttimecodeplayerform.FormShow(Sender: TObject);
var
  LReg:TRegistry;
  i:integer;
begin
  Combobox1.Items.Clear;
  for i:=0 to midieventfrm.midiindevicelist.items.count-1 do
    Combobox1.Items.Add(midieventfrm.midiindevicelist.items[i]);
  Combobox1.Items.Add(_('MediaCenter Timecode'));

  if Combobox1.Items.Count>0 then
    Combobox1.Itemindex:=0;

  Timer1.Enabled:=true;
  Timer2.Enabled:=(Combobox1.Items.Count>0);

  StringGrid1.Cells[0, 0]:=_('Position');
  StringGrid1.Cells[1, 0]:=_('Zeit');
  StringGrid1.Cells[2, 0]:=_('Name');
  StringGrid1.Cells[3, 0]:=_('Beschreibung');
  StringGrid1.Cells[4, 0]:=_('Blendzeit');
  StringGrid1.Cells[5, 0]:=_('Typ');

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
  			LReg.WriteBool('Showing Timecodeplayer',true);

        if not LReg.KeyExists('Timecodeplayer') then
	        LReg.CreateKey('Timecodeplayer');
	      if LReg.OpenKey('Timecodeplayer',true) then
	      begin
          if LReg.ValueExists('Width') then
            timecodeplayerform.ClientWidth:=LReg.ReadInteger('Width')
            else
              timecodeplayerform.ClientWidth:=774;
          if LReg.ValueExists('Heigth') then
            timecodeplayerform.ClientHeight:=LReg.ReadInteger('Heigth')
            else
              timecodeplayerform.ClientHeight:=394;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+timecodeplayerform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              timecodeplayerform.Left:=LReg.ReadInteger('PosX')
            else
              timecodeplayerform.Left:=0;
          end else
            timecodeplayerform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+timecodeplayerform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              timecodeplayerform.Top:=LReg.ReadInteger('PosY')
            else
              timecodeplayerform.Top:=0;
          end else
            timecodeplayerform.Top:=0;
        end;
      end;
    end;
  end;
end;

procedure Ttimecodeplayerform.FormHide(Sender: TObject);
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
					LReg.WriteBool('Showing Timecodeplayer',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;
  mainform.SaveWindowPositions('timecodeplayer');

  Timer1.Enabled:=false;
  Timer2.Enabled:=false;
end;

procedure Ttimecodeplayerform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  CurrentTimecodeSource:=-1;
  CurrentTimecodeBank:=-1;
end;

procedure Ttimecodeplayerform.CreateParams(var Params:TCreateParams);
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

procedure TTimeCodePlayerForm.NewFile;
begin
  setlength(mainform.TimeCodePlayerBank,0);
  BankSelect.items.Clear;
  BankSelectChange(BankSelect);

  setlength(mainform.TimeCodePlayerBank,length(mainform.TimeCodePlayerBank)+1);
  mainform.TimeCodePlayerBank[length(mainform.TimeCodePlayerBank)-1].BankName:=_('Neue Timecode-Liste');
  BankSelect.ItemIndex:=BankSelect.Items.Add(_('Neue Timecode-Liste'));
  BankSelectChange(BankSelect);
end;

procedure TTimeCodeplayerform.MSGOpen;
begin
  BankSelectChange(BankSelect);
end;

function Ttimecodeplayerform.MIDITimeToString(Time, Frame:Integer):String;
var
  h, m, s, frames:string;
begin
	h:=inttostr(Time div 3600);
  m:=inttostr((Time mod 3600) div 60);
  s:=inttostr((Time mod 3600) mod 60);
  frames:=inttostr(frame);

  if length(h)=1 then h:='0'+h;
  if length(m)=1 then m:='0'+m;
  if length(s)=1 then s:='0'+s;
  if length(frames)=1 then frames:='0'+frames;

  Result:=h+':'+m+':'+s+'.'+frames;
end;

procedure Ttimecodeplayerform.BankSelectChange(Sender: TObject);
var
  i:integer;
  Name, Beschreibung, Blendzeit, Typ:string;
  BtnsEnabled:boolean;
begin
  BtnsEnabled:=(length(mainform.timecodeplayerbank)>0) and (BankSelect.ItemIndex<length(mainform.timecodeplayerbank));

  addBtn.enabled:=BtnsEnabled;
  editBankBtn.enabled:=BtnsEnabled;
  deleteBankBtn.enabled:=BtnsEnabled;

  if not ((length(mainform.timecodeplayerbank)>0) and (BankSelect.ItemIndex<length(mainform.timecodeplayerbank))) then
//  if (length(mainform.timecodeplayerbank)<=0) or (BankSelect.ItemIndex>=length(mainform.timecodeplayerbank)) then
  begin
    StringGrid1.RowCount:=2;
    StringGrid1.Cells[0,1]:='';
    StringGrid1.Cells[1,1]:='-';
    StringGrid1.Cells[2,1]:='-';
    StringGrid1.Cells[3,1]:='-';
    StringGrid1.Cells[4,1]:='-';
    StringGrid1.Cells[5,1]:='-';
    CurrentTimecodeBank:=-1;
    exit;
  end else
  begin
    if length(mainform.timecodeplayerbank[BankSelect.Itemindex].time)>1 then
      EntrySort(Low(mainform.timecodeplayerbank[BankSelect.Itemindex].time),High(mainform.timecodeplayerbank[BankSelect.Itemindex].time));

    if length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems)>=1 then
      StringGrid1.RowCount:=length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems)+1
    else
    begin
      StringGrid1.RowCount:=2;
      if length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems)=0 then
      begin
        StringGrid1.Cells[0,1]:='';
        StringGrid1.Cells[1,1]:='-';
        StringGrid1.Cells[2,1]:='-';
        StringGrid1.Cells[3,1]:='-';
        StringGrid1.Cells[4,1]:='-';
        StringGrid1.Cells[5,1]:='-';
      end;
    end;

    for i:=0 to length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems)-1 do
    begin
      mainform.GetSceneInfo(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems[i], Name, Beschreibung, Blendzeit, Typ);
      StringGrid1.Cells[0,i+1]:=inttostr(i+1);
      StringGrid1.Cells[1,i+1]:=MIDITimeToString(mainform.timecodeplayerbank[BankSelect.Itemindex].Time[i],mainform.timecodeplayerbank[BankSelect.Itemindex].Frame[i]);
      StringGrid1.Cells[2,i+1]:=Name;
      StringGrid1.Cells[3,i+1]:=Beschreibung;
      StringGrid1.Cells[4,i+1]:=Blendzeit;
      StringGrid1.Cells[5,i+1]:=Typ;
    end;

    setlength(AlreadyPlayed, length(mainform.timecodeplayerbank[BankSelect.Itemindex].Time));

    CurrentTimecodeBank:=BankSelect.Itemindex;
  end;
  CheckButtons;
end;

procedure Ttimecodeplayerform.StringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
var
	text:string;
begin
  if ACol<>1 then
    text:=StringGrid1.Cells[ACol,ARow];

  if (ACol=1) then StringGrid1.EditorMode:=true else StringGrid1.EditorMode:=false;

  if ACol<>1 then
    StringGrid1.Cells[ACol,ARow]:=text;
end;

procedure Ttimecodeplayerform.addBankBtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  setlength(mainform.timecodeplayerbank,length(mainform.timecodeplayerbank)+1);
  mainform.timecodeplayerbank[length(mainform.timecodeplayerbank)-1].BankName:=_('Neue Timecode-Liste');
  BankSelect.ItemIndex:=BankSelect.Items.Add(_('Neue Timecode-Liste'));
  BankSelectChange(BankSelect);
  CheckButtons;
end;

procedure Ttimecodeplayerform.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Stringgrid1.Refresh;
  CheckButtons;
end;

procedure Ttimecodeplayerform.deleteBankBtnClick(Sender: TObject);
var
  BankToDelete,i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (length(mainform.timecodeplayerbank)<=0) or (BankSelect.ItemIndex>=length(mainform.timecodeplayerbank)) then
    exit;

  if messagedlg(_('Möchten Sie die aktuelle Bank wirklich löschen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    BankToDelete:=BankSelect.ItemIndex;

    if BankToDelete=length(mainform.timecodeplayerbank)-1 then
    begin
      // Letzte Bank einfach löschen
      setlength(mainform.timecodeplayerbank,length(mainform.timecodeplayerbank)-1);
      BankSelect.Items.Delete(BankSelect.Items.Count-1);
      BankSelect.ItemIndex:=BankSelect.Items.Count-1;
    end else
    begin
      // alle nachliegenden Bänke um eins vorkopieren
      for i:=BankToDelete to length(mainform.timecodeplayerbank)-2 do
        CopyBank(i+1, i);
      setlength(mainform.timecodeplayerbank,length(mainform.timecodeplayerbank)-1);
      BankSelect.Items.Delete(BankToDelete);
      BankSelect.ItemIndex:=BankToDelete;
    end;
    BankSelectChange(BankSelect);
  end;
  CheckButtons;
end;

procedure Ttimecodeplayerform.CopyBank(Source, Destination:integer);
var
  i:integer;
begin
  mainform.timecodeplayerbank[Destination].BankName:=mainform.timecodeplayerbank[Source].BankName;

  setlength(mainform.timecodeplayerbank[Destination].timecodeplayerbankitems,length(mainform.timecodeplayerbank[Source].timecodeplayerbankitems));
  setlength(mainform.timecodeplayerbank[Destination].Time,length(mainform.timecodeplayerbank[Source].Time));
  setlength(mainform.timecodeplayerbank[Destination].Frame,length(mainform.timecodeplayerbank[Source].Frame));
  for i:=0 to length(mainform.timecodeplayerbank[Source].timecodeplayerbankitems)-1 do
  begin
    mainform.timecodeplayerbank[Destination].timecodeplayerbankitems[i]:=mainform.timecodeplayerbank[Source].timecodeplayerbankitems[i];
    mainform.timecodeplayerbank[Destination].Time[i]:=mainform.timecodeplayerbank[Source].Time[i];
    mainform.timecodeplayerbank[Destination].Frame[i]:=mainform.timecodeplayerbank[Source].Frame[i];
  end;
end;

{
procedure Ttimecodeplayerform.FlipBankEntry(Source, Destination:integer);
begin
  // aktuellen Eintrag temporär ans Ende kopieren
  setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems)+1);
  setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].Time,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Time)+1);
  setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame)+1);
  mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems[length(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems)-1]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems[Source];
  mainform.timecodeplayerbank[BankSelect.ItemIndex].Time[length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Time)-1]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].Time[Source];
  mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame[length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame)-1]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame[Source];

  // oberen Einträge aufrutschen
  mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems[Source]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems[Destination];
  mainform.timecodeplayerbank[BankSelect.ItemIndex].Time[Source]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].Time[Destination];
  mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame[Source]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame[Destination];

  // letzten Eintrag einfügen
  mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems[Destination]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems[length(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems)-1];
  mainform.timecodeplayerbank[BankSelect.ItemIndex].Time[Destination]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].Time[length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Time)-1];
  mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame[Destination]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame[length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame)-1];
  setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems)-1);
  setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].Time,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Time)-1);
  setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame)-1);
end;
}

procedure Ttimecodeplayerform.CopyEntry(Source, Destination:integer);
begin
  mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems[Destination]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems[Source];
  mainform.timecodeplayerbank[BankSelect.ItemIndex].Time[Destination]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].Time[Source];
  mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame[Destination]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame[Source];
end;

procedure Ttimecodeplayerform.editBankBtnClick(Sender: TObject);
var
  Index:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (length(mainform.timecodeplayerbank)<=0) or (BankSelect.ItemIndex>=length(mainform.timecodeplayerbank)) then
    exit;

  Index:=BankSelect.ItemIndex;
  mainform.timecodeplayerbank[BankSelect.ItemIndex].BankName:=InputBox(_('Neue Bank-Beschriftung'),_('Bitte geben Sie eine neue Bezeichnung für diese Timecode-Bank ein:'),mainform.timecodeplayerbank[BankSelect.ItemIndex].BankName);
  BankSelect.Items[BankSelect.ItemIndex]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].BankName;
  BankSelect.ItemIndex:=Index;
end;

procedure Ttimecodeplayerform.playBtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  if (StringGrid1.Row-1)<length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems) then
    mainform.StartScene(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems[StringGrid1.Row-1],false,false,-1);
end;

procedure Ttimecodeplayerform.stopBtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  if (StringGrid1.Row-1)<length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems) then
    mainform.StopScene(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems[StringGrid1.Row-1]);
end;

procedure Ttimecodeplayerform.deleteBtnClick(Sender: TObject);
var
  EntryToDelete,i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  EntryToDelete:=StringGrid1.Row-1;
  if EntryToDelete=length(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems)-1 then
  begin
    // Letzten Eintrag einfach löschen
    setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems)-1);
    setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].Time,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Time)-1);
    setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame)-1);
  end else
  begin
    // alle nachliegenden Einträge um eins vorkopieren
    for i:=EntryToDelete to length(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems)-2 do
    begin
      mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems[i]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems[i+1];
      mainform.timecodeplayerbank[BankSelect.ItemIndex].Time[i]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].Time[i+1];
      mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame[i]:=mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame[i+1];
    end;
    setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems)-1);
    setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].Time,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Time)-1);
    setlength(mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame,length(mainform.timecodeplayerbank[BankSelect.ItemIndex].Frame)-1);
  end;

  BankSelectChange(BankSelect);
end;

procedure Ttimecodeplayerform.editBtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

//  if (StringGrid1.Row-1)<length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems) then
//    mainform.EditScene(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems[StringGrid1.Row-1]);
  if (StringGrid1.Row-1)<length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems) then
    mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems[StringGrid1.Row-1]:=mainform.ChangeSceneWithLibrary(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems[StringGrid1.Row-1]);

  BankSelectChange(BankSelect);
end;

procedure Ttimecodeplayerform.addBtnClick(Sender: TObject);
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

    setlength(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems,length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems)+1);
    setlength(mainform.timecodeplayerbank[BankSelect.Itemindex].time,length(mainform.timecodeplayerbank[BankSelect.Itemindex].time)+1);
    setlength(mainform.timecodeplayerbank[BankSelect.Itemindex].Frame,length(mainform.timecodeplayerbank[BankSelect.Itemindex].Frame)+1);
    setlength(AlreadyPlayed, length(mainform.timecodeplayerbank[BankSelect.Itemindex].Time));

    mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems[length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems)-1]:=SzenenData^.ID;

    mainform.timecodeplayerbank[BankSelect.Itemindex].time[length(mainform.timecodeplayerbank[BankSelect.Itemindex].time)-1]:=mainform.MidiInTimecode[Combobox1.Itemindex].s+mainform.MidiInTimecode[Combobox1.Itemindex].min*60+mainform.MidiInTimecode[Combobox1.Itemindex].h*3600;
    mainform.timecodeplayerbank[BankSelect.Itemindex].Frame[length(mainform.timecodeplayerbank[BankSelect.Itemindex].Frame)-1]:=mainform.MidiInTimecode[Combobox1.Itemindex].Frame;
  end;
  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);

  BankSelectChange(BankSelect);
  CheckButtons;
end;

procedure Ttimecodeplayerform.seteffecttoactualpositionbtnClick(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (StringGrid1.Row-1)<length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems) then
  begin
    mainform.timecodeplayerbank[BankSelect.Itemindex].time[StringGrid1.Row-1]:=mainform.MidiInTimecode[Combobox1.Itemindex].s+mainform.MidiInTimecode[Combobox1.Itemindex].min*60+mainform.MidiInTimecode[Combobox1.Itemindex].h*3600;
    mainform.timecodeplayerbank[BankSelect.Itemindex].Frame[StringGrid1.Row-1]:=mainform.MidiInTimecode[Combobox1.Itemindex].Frame;
  end;
  BankSelectChange(BankSelect);
end;

procedure Ttimecodeplayerform.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (length(mainform.timecodeplayerbank)<=0) or (BankSelect.ItemIndex>=length(mainform.timecodeplayerbank)) or (BankSelect.ItemIndex<0) then
    exit;

  if (BankSelect.ItemIndex<length(mainform.timecodeplayerbank)) and (length(mainform.timecodeplayerbank[BankSelect.ItemIndex].timecodeplayerbankitems)>0) and mainform.IsSceneActive(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems[ARow-1]) then
  begin
    (sender as TStringgrid).canvas.Brush.color:=clLime;
    (sender as TStringgrid).canvas.FillRect(rect);
    (sender as TStringgrid).canvas.Font.Style:=[fsBold];
    if (ARow>0) and ((ARow-1)<length(AlreadyPlayed)) and (AlreadyPlayed[ARow-1]) then
      (sender as TStringgrid).canvas.Font.Color:=clGreen
    else
      (sender as TStringgrid).canvas.Font.Color:=clBlack;
    (sender as TStringgrid).canvas.TextOut(rect.left+2,rect.top+2,(sender as TStringgrid).Cells[acol,arow]);
  end else
  begin
    if StringGrid1.Row=ARow then
      (sender as TStringgrid).canvas.Brush.color:=clMenuHighlight
    else
      (sender as TStringgrid).canvas.Brush.color:=(sender as TStringgrid).color;

    if (ARow=0) or (ACol=0) then
      (sender as TStringgrid).canvas.Brush.color:=clBtnFace;

    (sender as TStringgrid).canvas.Font.Style:=[];
    if (ARow>0) and ((ARow-1)<length(AlreadyPlayed)) and (AlreadyPlayed[ARow-1]) then
      (sender as TStringgrid).canvas.Font.Color:=clGreen
    else
      (sender as TStringgrid).canvas.Font.Color:=clBlack;
    (sender as TStringgrid).canvas.FillRect(rect);
    (sender as TStringgrid).canvas.TextOut(rect.left+2,rect.top+2,(sender as TStringgrid).Cells[acol,arow]);
  end;
end;

procedure TTimecodeplayerForm.CheckButtons;
var
  BtnsEnabled:boolean;
begin
  BtnsEnabled:=(BankSelect.Itemindex>-1) and (length(mainform.TimeCodePlayerBank[BankSelect.Itemindex].timecodeplayerbankitems)>0) and (StringGrid1.Row>0) and (StringGrid1.Row<=length(mainform.TimeCodePlayerBank[BankSelect.Itemindex].timecodeplayerbankitems));
  editBtn.enabled:=BtnsEnabled;
  deleteBtn.enabled:=BtnsEnabled;
  seteffecttoactualpositionbtn.Enabled:=BtnsEnabled;
  playBtn.enabled:=BtnsEnabled;
  stopBtn.enabled:=BtnsEnabled;

  editBankBtn.Enabled:=(BankSelect.ItemIndex>-1) and (BankSelect.Items.Count>0);
  deleteBankBtn.Enabled:=(BankSelect.ItemIndex>-1) and (BankSelect.Items.Count>0);
end;

procedure Ttimecodeplayerform.EntrySort(iLo, iHi:integer);
var
  Lo, Hi: Integer;
  Pivot:Single;
begin
  Lo := iLo;
  Hi := iHi;
  Pivot := mainform.TimeCodePlayerBank[BankSelect.Itemindex].Time[(Lo + Hi) div 2];
  repeat
    while mainform.TimeCodePlayerBank[BankSelect.Itemindex].Time[Lo] < Pivot do Inc(Lo) ;
    while mainform.TimeCodePlayerBank[BankSelect.Itemindex].Time[Hi] > Pivot do Dec(Hi) ;
    if Lo <= Hi then
    begin
      // in folgenden drei Zeilen Arrayinhalte kopieren
      setlength(mainform.TimeCodePlayerBank[BankSelect.Itemindex].timecodeplayerbankitems,length(mainform.TimeCodePlayerBank[BankSelect.Itemindex].timecodeplayerbankitems)+1);
      setlength(mainform.TimeCodePlayerBank[BankSelect.Itemindex].Time,length(mainform.TimeCodePlayerBank[BankSelect.Itemindex].Time)+1);
      setlength(mainform.TimeCodePlayerBank[BankSelect.Itemindex].Frame,length(mainform.TimeCodePlayerBank[BankSelect.Itemindex].Frame)+1);
      CopyEntry(Lo,length(mainform.TimeCodePlayerBank[BankSelect.Itemindex].Time)-1);
      CopyEntry(Hi,Lo);
      CopyEntry(length(mainform.TimeCodePlayerBank[BankSelect.Itemindex].Time)-1,Hi);
      setlength(mainform.TimeCodePlayerBank[BankSelect.Itemindex].timecodeplayerbankitems,length(mainform.TimeCodePlayerBank[BankSelect.Itemindex].timecodeplayerbankitems)-1);
      setlength(mainform.TimeCodePlayerBank[BankSelect.Itemindex].Time,length(mainform.TimeCodePlayerBank[BankSelect.Itemindex].Time)-1);
      setlength(mainform.TimeCodePlayerBank[BankSelect.Itemindex].Frame,length(mainform.TimeCodePlayerBank[BankSelect.Itemindex].Frame)-1);
      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > iLo then EntrySort(iLo, Hi);
  if Lo < iHi then EntrySort(Lo, iHi);
end;

procedure Ttimecodeplayerform.Timer1Timer(Sender: TObject);
begin
  StringGrid1.Refresh;
end;

procedure Ttimecodeplayerform.StringGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  text:string;
  h, min, s, frame:integer;
begin
  if (stringgrid1.Col=1) then
  begin
    text:=stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row];
    if (length(text)=11) and (text[3]=':') and (text[6]=':') and (text[9]='.') and (Key=vk_return) then // 00:00:00.00
    begin
      h:=strtoint(copy(text, 1, 2));
      min:=strtoint(copy(text, 4, 2));
      s:=strtoint(copy(text, 7, 2));
      frame:=strtoint(copy(text, 10, 2));

      mainform.timecodeplayerbank[BankSelect.Itemindex].time[StringGrid1.Row-1]:=h*3600+min*60+s;
      mainform.timecodeplayerbank[BankSelect.Itemindex].Frame[StringGrid1.Row-1]:=frame;
      BankSelectChange(BankSelect);
    end else
    begin
      exit;
    end;
  end;
  Stringgrid1.Refresh;
end;

procedure Ttimecodeplayerform.Timer2Timer(Sender: TObject);
var
  h, min, s, frame:string;
begin
  h:=inttostr(mainform.MidiInTimecode[Combobox1.Itemindex].h);
  min:=inttostr(mainform.MidiInTimecode[Combobox1.Itemindex].min);
  s:=inttostr(mainform.MidiInTimecode[Combobox1.Itemindex].s);
  frame:=inttostr(mainform.MidiInTimecode[Combobox1.Itemindex].frame);

  if length(h)=1 then h:='0'+h;
  if length(min)=1 then min:='0'+min;
  if length(s)=1 then s:='0'+s;
  if length(frame)=1 then frame:='0'+frame;

  MidiTimecodeLbl.Caption:=h+':'+min+':'+s+'.'+frame;

  case mainform.MidiInTimecode[Combobox1.Itemindex].Framemode of
    0: mtc_mode.caption:='24 fps';
    1: mtc_mode.caption:='25 fps';
    2: mtc_mode.caption:='30 fps (dropped)';
    3: mtc_mode.caption:='30 fps (non-dropped)';
  end;
end;

procedure Ttimecodeplayerform.SpeedButton3Click(Sender: TObject);
begin
  if (length(mainform.Timecodeplayerbank)=0) or (BankSelect.ItemIndex>=length(mainform.Timecodeplayerbank)) then
    exit;

  if messagedlg(_(_('Möchten Sie die aktuelle Timecodeplayerbank löschen?')),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    setlength(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems,0);
    setlength(mainform.Timecodeplayerbank[BankSelect.Itemindex].Time,0);
    setlength(mainform.Timecodeplayerbank[BankSelect.Itemindex].Frame,0);
    BankSelectChange(BankSelect);
  end;
end;

procedure Ttimecodeplayerform.Openfile(Filename: string);
var
  j,startindex,count2:integer;
begin
  FileStream:=TFileStream.Create(Opendialog1.FileName,fmOpenRead);

  FileStream.ReadBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].BankName,sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].BankName));
  FileStream.ReadBuffer(count2,sizeof(count2));
  setlength(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems,count2);
  setlength(mainform.Timecodeplayerbank[BankSelect.Itemindex].Time,count2);
  setlength(mainform.Timecodeplayerbank[BankSelect.Itemindex].Frame,count2);
  for j:=0 to count2-1 do
  begin
    FileStream.ReadBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems[j],sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems[j]));
    FileStream.ReadBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].Time[j],sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].Time[j]));
    FileStream.ReadBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].Frame[j],sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].Frame[j]));
  end;

  FileStream.Free;

  BankSelectChange(BankSelect);
end;

procedure Ttimecodeplayerform.SpeedButton2Click(Sender: TObject);
var
  j,startindex,count2:integer;
  additiv:boolean;
begin
  if (length(mainform.Timecodeplayerbank)=0) or (BankSelect.ItemIndex>=length(mainform.Timecodeplayerbank)) then
    exit;

  additiv:=true;

	case mainform.mymessagedlg(_('Wie soll die Timecodeplayer-Liste aus der Datei geladen werden?'),mtConfirmation,[mbYes,mbAll,mbCancel],[_('&Hinzufügen'),_('&Ersetzen'),_('Ab&brechen')]) of
    mrYes: additiv:=true;
    mrCancel: additiv:=false;
    mrAll: exit;
  end;

  if OpenDialog1.Execute then
  begin
    if additiv then
    begin
      startindex:=length(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems)-1;

      FileStream:=TFileStream.Create(Opendialog1.FileName,fmOpenRead);

      FileStream.ReadBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].BankName,sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].BankName));
      FileStream.ReadBuffer(count2,sizeof(count2));
      setlength(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems,startindex+1+count2);
      setlength(mainform.Timecodeplayerbank[BankSelect.Itemindex].Time,startindex+1+count2);
      setlength(mainform.Timecodeplayerbank[BankSelect.Itemindex].Frame,startindex+1+count2);
      for j:=(startindex+1) to length(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems)-1 do
      begin
        FileStream.ReadBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems[j],sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems[j]));
        FileStream.ReadBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].Time[j],sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].Time[j]));
        FileStream.ReadBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].Frame[j],sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].Frame[j]));
      end;

      FileStream.Free;
    end else
    begin
      Openfile(Opendialog1.FileName);
    end;

    BankSelectChange(BankSelect);
  end;
end;

procedure Ttimecodeplayerform.SpeedButton1Click(Sender: TObject);
var
  j,count2:integer;
begin
  if (length(mainform.Timecodeplayerbank)=0) or (BankSelect.ItemIndex>=length(mainform.Timecodeplayerbank)) then
    exit;

  if SaveDialog1.Execute then
  begin
    FileStream:=TFileStream.Create(Savedialog1.FileName,fmCreate);

    FileStream.WriteBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].BankName,sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].BankName));
    count2:=length(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems);
    FileStream.WriteBuffer(count2,sizeof(count2));
    for j:=0 to count2-1 do
    begin
      FileStream.WriteBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems[j],sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].Timecodeplayerbankitems[j]));
      FileStream.WriteBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].Time[j],sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].Time[j]));
      FileStream.WriteBuffer(mainform.Timecodeplayerbank[BankSelect.Itemindex].Frame[j],sizeof(mainform.Timecodeplayerbank[BankSelect.Itemindex].Frame[j]));
    end;

    FileStream.Free;
  end;
end;

procedure Ttimecodeplayerform.StringGrid1DblClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (BankSelect.Itemindex>-1) and ((StringGrid1.Row-1)<length(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems)) then
    mainform.EditScene(mainform.timecodeplayerbank[BankSelect.Itemindex].timecodeplayerbankitems[StringGrid1.Row-1]);
  BankSelectChange(BankSelect);
end;

procedure Ttimecodeplayerform.StringGrid1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CheckButtons;
end;

procedure Ttimecodeplayerform.BankSelectDropDown(Sender: TObject);
begin
  CurrentTimecodeBank:=-1;
end;

procedure Ttimecodeplayerform.BankSelectCloseUp(Sender: TObject);
begin
  CurrentTimecodeBank:=BankSelect.Itemindex;
end;

procedure Ttimecodeplayerform.ComboBox1Select(Sender: TObject);
begin
  CurrentTimecodeSource:=Combobox1.ItemIndex;
end;

procedure Ttimecodeplayerform.GetMIDITimecodeTimerTimer(Sender: TObject);
var
  i:integer;
begin
  if mainform.shutdown then
    GetMIDITimecodeTimer.Enabled:=false;

  if (CurrentTimecodeSource>-1) and (CurrentTimecodeSource<length(mainform.MidiInTimeCode)) and (CurrentTimecodeBank>-1) then
  begin
    MidiTime:=(mainform.MidiInTimecode[CurrentTimecodeSource].h*3600+mainform.MidiInTimecode[CurrentTimecodeSource].min*60+mainform.MidiInTimecode[CurrentTimecodeSource].s)*1000+mainform.MidiInTimecode[CurrentTimecodeSource].Frame;

    for i:=0 to length(mainform.TimeCodePlayerBank[CurrentTimecodeBank].Time)-1 do
    begin
      if i>=length(mainform.TimeCodePlayerBank[CurrentTimecodeBank].Time) then
        break;
        
      if length(AlreadyPlayed)=length(mainform.TimeCodePlayerBank[CurrentTimecodeBank].Time) then
      if (((mainform.TimeCodePlayerBank[CurrentTimecodeBank].Time[i]*1000)+mainform.TimeCodePlayerBank[CurrentTimecodeBank].Frame[i])<=MidiTime) then
      begin
        // Arrayeintrag ist vor aktueller Zeit
        if (not AlreadyPlayed[i]) then
        begin
          // Arrayeintrag ist noch nicht abgespielt
          AlreadyPlayed[i]:=true;
          mainform.StartScene(mainform.timecodeplayerbank[CurrentTimecodeBank].timecodeplayerbankitems[i],false,false,-1);
        end;
      end else
      begin
        // Arrayeintrag ist nach aktueller Zeit
        AlreadyPlayed[i]:=false;
      end;
    end;
  end;
end;

end.
