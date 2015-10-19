unit audioszeneeditorform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, gnugettext, pngimage, ExtCtrls, JvExControls,
  JvGradient, BASS, BASS_AC3, BassMix, Mask, JvExMask, GR32, JvSpin, PngBitBtn,
  JvLabel;

type
  Taudioszeneneditor = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    SpeedButton1: TSpeedButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button4: TButton;
    Edit7: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    editVolume: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    editFadeinh: TEdit;
    editFadeinmin: TEdit;
    editfadeins: TEdit;
    editfadeinms: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    editfadeouth: TEdit;
    editfadeoutmin: TEdit;
    editfadeouts: TEdit;
    editfadeoutms: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Panel5: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    GroupBox2: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    l0: TJvSpinEdit;
    l1: TJvSpinEdit;
    l2: TJvSpinEdit;
    l3: TJvSpinEdit;
    l4: TJvSpinEdit;
    l5: TJvSpinEdit;
    l6: TJvSpinEdit;
    l7: TJvSpinEdit;
    r0: TJvSpinEdit;
    r1: TJvSpinEdit;
    r2: TJvSpinEdit;
    r3: TJvSpinEdit;
    r4: TJvSpinEdit;
    r5: TJvSpinEdit;
    r6: TJvSpinEdit;
    r7: TJvSpinEdit;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    GroupBox4: TGroupBox;
    PaintBox1: TPaintBox;
    refreshtimer: TTimer;
    Label36: TLabel;
    chancountlbl: TLabel;
    Label38: TLabel;
    frequencylbl: TLabel;
    openmedia: TOpenDialog;
    Label39: TLabel;
    cen0: TJvSpinEdit;
    cen1: TJvSpinEdit;
    cen2: TJvSpinEdit;
    cen3: TJvSpinEdit;
    cen4: TJvSpinEdit;
    cen5: TJvSpinEdit;
    cen6: TJvSpinEdit;
    cen7: TJvSpinEdit;
    Label40: TLabel;
    lfe0: TJvSpinEdit;
    lfe1: TJvSpinEdit;
    lfe2: TJvSpinEdit;
    lfe3: TJvSpinEdit;
    lfe4: TJvSpinEdit;
    lfe5: TJvSpinEdit;
    lfe6: TJvSpinEdit;
    lfe7: TJvSpinEdit;
    Label41: TLabel;
    hl0: TJvSpinEdit;
    hl1: TJvSpinEdit;
    hl2: TJvSpinEdit;
    hl3: TJvSpinEdit;
    hl4: TJvSpinEdit;
    hl5: TJvSpinEdit;
    hl6: TJvSpinEdit;
    hl7: TJvSpinEdit;
    Label42: TLabel;
    hr0: TJvSpinEdit;
    hr1: TJvSpinEdit;
    hr2: TJvSpinEdit;
    hr3: TJvSpinEdit;
    hr4: TJvSpinEdit;
    hr5: TJvSpinEdit;
    hr6: TJvSpinEdit;
    hr7: TJvSpinEdit;
    Label43: TLabel;
    sl0: TJvSpinEdit;
    sl1: TJvSpinEdit;
    sl2: TJvSpinEdit;
    sl3: TJvSpinEdit;
    sl4: TJvSpinEdit;
    sl5: TJvSpinEdit;
    sl6: TJvSpinEdit;
    sl7: TJvSpinEdit;
    Label44: TLabel;
    sr0: TJvSpinEdit;
    sr1: TJvSpinEdit;
    sr2: TJvSpinEdit;
    sr3: TJvSpinEdit;
    sr4: TJvSpinEdit;
    sr5: TJvSpinEdit;
    sr6: TJvSpinEdit;
    sr7: TJvSpinEdit;
    Button2: TButton;
    Label33: TLabel;
    Button6: TButton;
    Button3: TButton;
    Button5: TButton;
    GroupBox3: TGroupBox;
    PngBitBtn2: TPngBitBtn;
    PngBitBtn1: TPngBitBtn;
    Shape4: TShape;
    Shape1: TShape;
    PngBitBtn3: TPngBitBtn;
    JvLabel1: TJvLabel;
    Button7: TButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure refreshtimerTimer(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure l0MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure l0KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure editVolumeChange(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure PngBitBtn3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private-Deklarationen }
    _Buffer: TBitmap32;
    chanpositionx:array[0..7] of byte;
    chanpositiony:array[0..7] of byte;
    chanselect:array[0..7] of boolean;

    TempChan, TempMixChan:HSTREAM;
    matrix1:array[0..7] of float;
    matrix2:array[0..7] of array[0..1] of float;
    matrix4:array[0..7] of array[0..3] of float;
    matrix6:array[0..7] of array[0..5] of float;
    matrix8:array[0..7] of array[0..7] of float;
    chancount:integer;
    procedure RefreshMatrix;
  public
    { Public-Deklarationen }
  end;

var
  audioszeneneditor: Taudioszeneneditor;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Taudioszeneneditor.SpeedButton1Click(Sender: TObject);
var
  i:BASS_ChannelInfo;
  j,k:integer;
begin
  if TempMixChan<>0 then
  begin
    BASS_ChannelStop(TempMixChan);
    BASS_Mixer_ChannelRemove(TempChan);
    BASS_StreamFree(TempMixChan);
    BASS_StreamFree(TempChan);
    TempMixChan:=0;
    TempChan:=0;
  end;

  // Standardpositionen laden (nicht für Mono geeignet!)
  chanpositionx[0]:=5;    // FL
  chanpositionx[1]:=105;  // FR
  chanpositionx[2]:=55;   // Center
  chanpositionx[3]:=55;   // LFE
  chanpositionx[4]:=5;    // RL
  chanpositionx[5]:=105;  // RR
  chanpositionx[6]:=5;    // SL
  chanpositionx[7]:=105;  // SR

  chanpositiony[0]:=5;    // FL
  chanpositiony[1]:=5;    // FR
  chanpositiony[2]:=5;    // Center
  chanpositiony[3]:=55;   // LFE
  chanpositiony[4]:=105;  // RL
  chanpositiony[5]:=105;  // RR
  chanpositiony[6]:=55;   // SL
  chanpositiony[7]:=55;   // SR

  if mainform.project_folder<>'' then
    openmedia.InitialDir:=mainform.project_folder;

  if openmedia.Execute then
  begin
    if Edit1.Text='' then
      Edit1.Text:=ExtractFileName(openmedia.FileName);
    if pos(mainform.workingdirectory+'ProjectTemp\',openmedia.FileName)>0 then
    begin
      Edit3.Text:=copy(openmedia.FileName,length(mainform.workingdirectory+'ProjectTemp\')+1,length(openmedia.FileName));
      label6.Caption:=copy(openmedia.FileName,length(mainform.workingdirectory+'ProjectTemp\')+1,length(openmedia.FileName));
    end else if pos(ExtractFilePath(mainform.project_file),openmedia.FileName)>0 then
    begin
      Edit3.Text:=copy(openmedia.FileName,length(ExtractFilePath(mainform.project_file))+1,length(openmedia.FileName));
      label6.Caption:=copy(openmedia.FileName,length(ExtractFilePath(mainform.project_file))+1,length(openmedia.FileName));
    end else
    begin
      Edit3.Text:=mainform.SearchFileBeneathProject(openmedia.FileName);
      label6.Caption:=mainform.SearchFileBeneathProject(openmedia.FileName);
    end;         
  end;

  if lowercase(copy(PChar(mainform.SearchFileBeneathProject(edit3.Text)), length(PChar(mainform.SearchFileBeneathProject(edit3.Text)))-2, length(PChar(mainform.SearchFileBeneathProject(edit3.Text)))))='ac3' then
    TempChan:=BASS_AC3_StreamCreateFile(FALSE, PChar(mainform.SearchFileBeneathProject(edit3.Text)), 0, 0, BASS_STREAM_DECODE)
  else
    TempChan:=BASS_StreamCreateFile(FALSE, PChar(mainform.SearchFileBeneathProject(edit3.Text)), 0, 0, BASS_STREAM_DECODE);
  TempMixChan:=BASS_Mixer_StreamCreate(BASSDLLFREQUENZ, 8, BASS_MIXER_END); // 8ch Mixerkanal erstellen
  BASS_Mixer_StreamAddChannel(TempMixChan, TempChan, BASS_MIXER_MATRIX); // Audiokanal dem Mixerkanal zuweisen

  BASS_ChannelGetInfo(TempChan, i);
  chancount:=i.chans;
  chancountlbl.Caption:=inttostr(i.chans);
  frequencylbl.Caption:=inttostr(i.freq);

  // Korrektur der einzelnen Positionen anhand Kanalanzahl
  case chancount of
    1: // Mono
    begin
      chanpositionx[0]:=55;   // FL
      chanpositionx[1]:=105;  // FR
      chanpositionx[2]:=55;   // Center
      chanpositionx[3]:=55;   // LFE
      chanpositionx[4]:=5;    // RL
      chanpositionx[5]:=105;  // RR
      chanpositionx[6]:=5;    // SL
      chanpositionx[7]:=105;  // SR

      chanpositiony[0]:=55;   // FL
      chanpositiony[1]:=5;    // FR
      chanpositiony[2]:=5;    // Center
      chanpositiony[3]:=105;  // LFE
      chanpositiony[4]:=105;  // RL
      chanpositiony[5]:=105;  // RR
      chanpositiony[6]:=55;   // SL
      chanpositiony[7]:=55;   // SR
    end;
    2: // Stereo
    begin
      chanpositionx[0]:=5;    // FL
      chanpositionx[1]:=105;  // FR
      chanpositionx[2]:=55;   // Center
      chanpositionx[3]:=55;   // LFE
      chanpositionx[4]:=5;    // RL
      chanpositionx[5]:=105;  // RR
      chanpositionx[6]:=5;    // SL
      chanpositionx[7]:=105;  // SR

      chanpositiony[0]:=55;   // FL
      chanpositiony[1]:=55;   // FR
      chanpositiony[2]:=5;    // Center
      chanpositiony[3]:=105;  // LFE
      chanpositiony[4]:=105;  // RL
      chanpositiony[5]:=105;  // RR
      chanpositiony[6]:=55;   // SL
      chanpositiony[7]:=55;   // SR
    end;
    3: // LCR
    begin
      chanpositionx[0]:=5;   // FL
      chanpositionx[1]:=105;  // FR
      chanpositionx[2]:=55;   // Center
      chanpositionx[3]:=55;   // LFE
      chanpositionx[4]:=5;    // RL
      chanpositionx[5]:=105;  // RR
      chanpositionx[6]:=5;    // SL
      chanpositionx[7]:=105;  // SR

      chanpositiony[0]:=55;   // FL
      chanpositiony[1]:=55;    // FR
      chanpositiony[2]:=5;    // Center
      chanpositiony[3]:=105;  // LFE
      chanpositiony[4]:=105;  // RL
      chanpositiony[5]:=105;  // RR
      chanpositiony[6]:=55;   // SL
      chanpositiony[7]:=55;   // SR
    end;
    4..8: // Restliche
    begin
      chanpositionx[0]:=5;    // FL
      chanpositionx[1]:=105;  // FR
      chanpositionx[2]:=55;   // Center
      chanpositionx[3]:=55;   // LFE
      chanpositionx[4]:=5;    // RL
      chanpositionx[5]:=105;  // RR
      chanpositionx[6]:=5;    // SL
      chanpositionx[7]:=105;  // SR

      chanpositiony[0]:=5;    // FL
      chanpositiony[1]:=5;    // FR
      chanpositiony[2]:=5;    // Center
      chanpositiony[3]:=55;  // LFE
      chanpositiony[4]:=105;  // RL
      chanpositiony[5]:=105;  // RR
      chanpositiony[6]:=55;   // SL
      chanpositiony[7]:=55;   // SR
    end;
  end;

  PaintBox1MouseMove(nil, [ssLeft], 0, 0);

  // hier nun alle Werte maximieren
  for j:=0 to 20 do
  begin
    for k:=0 to 7 do
    begin
      if TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value+0.05;
    end;
  end;

  RefreshMatrix;
end;

procedure Taudioszeneneditor.Edit4Change(Sender: TObject);
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

procedure Taudioszeneneditor.Edit4Exit(Sender: TObject);
begin
  if TEdit(Sender).Text='' then TEdit(Sender).Text:='0';
end;

procedure Taudioszeneneditor.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Taudioszeneneditor.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  _Buffer := TBitmap32.Create;
  _Buffer.Width:= PaintBox1.Width;
  _Buffer.Height:= PaintBox1.Height;
end;

procedure Taudioszeneneditor.FormShow(Sender: TObject);
var
  i:BASS_ChannelInfo;
begin
  refreshtimer.enabled:=true;

  audioszeneneditor.Width:=541;
  button2.Caption:=_('Optionen >>');

  if (edit3.Text<>'') and FileExists(mainform.SearchFileBeneathProject(edit3.Text)) then
  begin
    if lowercase(copy(PChar(mainform.SearchFileBeneathProject(edit3.Text)), length(PChar(mainform.SearchFileBeneathProject(edit3.Text)))-2, length(PChar(mainform.SearchFileBeneathProject(edit3.Text)))))='ac3' then
      TempChan:=BASS_AC3_StreamCreateFile(FALSE, PChar(mainform.SearchFileBeneathProject(edit3.Text)), 0, 0, BASS_STREAM_DECODE)
    else
      TempChan:=BASS_StreamCreateFile(FALSE, PChar(mainform.SearchFileBeneathProject(edit3.Text)), 0, 0, BASS_STREAM_DECODE);

    TempMixChan:=BASS_Mixer_StreamCreate(BASSDLLFREQUENZ, 8, BASS_MIXER_END); // 8ch Mixerkanal erstellen
    BASS_Mixer_StreamAddChannel(TempMixChan, TempChan, BASS_MIXER_MATRIX); // Audiokanal dem Mixerkanal zuweisen

    BASS_ChannelGetInfo(TempChan, i);
    chancount:=i.chans;
    chancountlbl.Caption:=inttostr(i.chans);
    frequencylbl.Caption:=inttostr(i.freq);

    // Korrektur der einzelnen Positionen anhand Kanalanzahl
    case chancount of
      1: // Mono
      begin
        chanpositionx[0]:=55;   // FL
        chanpositionx[1]:=105;  // FR
        chanpositionx[2]:=55;   // Center
        chanpositionx[3]:=55;   // LFE
        chanpositionx[4]:=5;    // RL
        chanpositionx[5]:=105;  // RR
        chanpositionx[6]:=5;    // SL
        chanpositionx[7]:=105;  // SR

        chanpositiony[0]:=55;   // FL
        chanpositiony[1]:=5;    // FR
        chanpositiony[2]:=5;    // Center
        chanpositiony[3]:=105;  // LFE
        chanpositiony[4]:=105;  // RL
        chanpositiony[5]:=105;  // RR
        chanpositiony[6]:=55;   // SL
        chanpositiony[7]:=55;   // SR
      end;
      2: // Stereo
      begin
        chanpositionx[0]:=5;    // FL
        chanpositionx[1]:=105;  // FR
        chanpositionx[2]:=55;   // Center
        chanpositionx[3]:=55;   // LFE
        chanpositionx[4]:=5;    // RL
        chanpositionx[5]:=105;  // RR
        chanpositionx[6]:=5;    // SL
        chanpositionx[7]:=105;  // SR

        chanpositiony[0]:=55;   // FL
        chanpositiony[1]:=55;   // FR
        chanpositiony[2]:=5;    // Center
        chanpositiony[3]:=105;  // LFE
        chanpositiony[4]:=105;  // RL
        chanpositiony[5]:=105;  // RR
        chanpositiony[6]:=55;   // SL
        chanpositiony[7]:=55;   // SR
      end;
      3: // LCR
      begin
        chanpositionx[0]:=5;    // FL
        chanpositionx[1]:=105;  // FR
        chanpositionx[2]:=55;   // Center
        chanpositionx[3]:=55;   // LFE
        chanpositionx[4]:=5;    // RL
        chanpositionx[5]:=105;  // RR
        chanpositionx[6]:=5;    // SL
        chanpositionx[7]:=105;  // SR

        chanpositiony[0]:=55;   // FL
        chanpositiony[1]:=55;   // FR
        chanpositiony[2]:=5;    // Center
        chanpositiony[3]:=105;  // LFE
        chanpositiony[4]:=105;  // RL
        chanpositiony[5]:=105;  // RR
        chanpositiony[6]:=55;   // SL
        chanpositiony[7]:=55;   // SR
      end;
      4..8: // Restliche
      begin
        chanpositionx[0]:=5;    // FL
        chanpositionx[1]:=105;  // FR
        chanpositionx[2]:=55;   // Center
        chanpositionx[3]:=55;   // LFE
        chanpositionx[4]:=5;    // RL
        chanpositionx[5]:=105;  // RR
        chanpositionx[6]:=5;    // SL
        chanpositionx[7]:=105;  // SR

        chanpositiony[0]:=5;    // FL
        chanpositiony[1]:=5;    // FR
        chanpositiony[2]:=5;    // Center
        chanpositiony[3]:=55;   // LFE
        chanpositiony[4]:=105;  // RL
        chanpositiony[5]:=105;  // RR
        chanpositiony[6]:=55;   // SL
        chanpositiony[7]:=55;   // SR
      end;
    end;

    RefreshMatrix;
  end;
end;

procedure Taudioszeneneditor.FormHide(Sender: TObject);
begin
  refreshtimer.enabled:=false;
end;

procedure Taudioszeneneditor.refreshtimerTimer(Sender: TObject);
begin
  // Fenster resetten
  _Buffer.Canvas.Brush.Color:=clBtnFace;
  _Buffer.Canvas.Pen.Style:=psClear;
  _Buffer.Canvas.FillRect(_Buffer.ClipRect);
  _Buffer.Canvas.Pen.Style:=psSolid;
  _Buffer.Canvas.Rectangle(5, 5, _Buffer.Width-5, _Buffer.Height-5);

  // Lautsprecherkreise zeichnen
  _Buffer.Canvas.Pen.Color:=clBlack;
  _Buffer.Canvas.Brush.Color:=clBtnShadow;
  _Buffer.Canvas.Ellipse(0,0,10,10);
  _Buffer.Canvas.Ellipse(50,0,60,10);
  _Buffer.Canvas.Ellipse(100,0,110,10);
  _Buffer.Canvas.Ellipse(0,50,10,60);
  _Buffer.Canvas.Ellipse(100,50,110,60);
  _Buffer.Canvas.Ellipse(0,100,10,110);
  _Buffer.Canvas.Ellipse(100,100,110,110);

  // Kreise an den inneren Seiten aufbrechen
  _Buffer.Canvas.Brush.Color:=clBtnShadow;
  _Buffer.Canvas.Pen.Style:=psClear;
  _Buffer.Canvas.Rectangle(6, 6, _Buffer.Width-5, _Buffer.Height-5);
  _Buffer.Canvas.Pen.Style:=psSolid;

  // Fadenkreuz zeichnen
  _Buffer.Canvas.Pen.Color:=clGray;
  _Buffer.Canvas.MoveTo(55,5);
  _Buffer.Canvas.LineTo(55,105);
  _Buffer.Canvas.MoveTo(5,55);
  _Buffer.Canvas.LineTo(105,55);

  // Soundquellen zeichnen
  _Buffer.Canvas.Pen.Color:=clBlack;

  if chancount>0 then // Mono
  begin
    // Vorne Links
    _Buffer.Canvas.Brush.Color:=clGreen;
    _Buffer.Canvas.Ellipse(chanpositionx[0]-5, chanpositiony[0]-5, chanpositionx[0]+5, chanpositiony[0]+5);
  end;
  if chancount>1 then // Stereo
  begin
    // Vorne Rechts
    _Buffer.Canvas.Brush.Color:=clRed;
    _Buffer.Canvas.Ellipse(chanpositionx[1]-5, chanpositiony[1]-5, chanpositionx[1]+5, chanpositiony[1]+5);
  end;
  if chancount>3 then // Quad
  begin
    // Hinten Links
    _Buffer.Canvas.Pen.Color:=clLime;
    _Buffer.Canvas.Brush.Color:=clBlue;
    _Buffer.Canvas.Ellipse(chanpositionx[4]-5, chanpositiony[4]-5, chanpositionx[4]+5, chanpositiony[4]+5);
    // Hinten Rechts
    _Buffer.Canvas.Pen.Color:=clRed;
    _Buffer.Canvas.Brush.Color:=clBlue;
    _Buffer.Canvas.Ellipse(chanpositionx[5]-5, chanpositiony[5]-5, chanpositionx[5]+5, chanpositiony[5]+5);
  end;
  if chancount>4 then // 5.1
  begin
    // Center
    _Buffer.Canvas.Pen.Color:=clBlack;
    _Buffer.Canvas.Brush.Color:=clWhite;
    _Buffer.Canvas.Ellipse(chanpositionx[2]-5, chanpositiony[2]-5, chanpositionx[2]+5, chanpositiony[2]+5);
    // LFE
    _Buffer.Canvas.Pen.Color:=clBlack;
    _Buffer.Canvas.Brush.Color:=clBlack;
    _Buffer.Canvas.Ellipse(chanpositionx[3]-5, chanpositiony[3]-5, chanpositionx[3]+5, chanpositiony[3]+5);
  end;
  if chancount>6 then // 7.1
  begin
    // Seite Links
    _Buffer.Canvas.Pen.Color:=clLime;
    _Buffer.Canvas.Brush.Color:=clPurple;
    _Buffer.Canvas.Ellipse(chanpositionx[6]-5, chanpositiony[6]-5, chanpositionx[6]+5, chanpositiony[6]+5);
    // Seite Rechts
    _Buffer.Canvas.Pen.Color:=clRed;
    _Buffer.Canvas.Brush.Color:=clPurple;
    _Buffer.Canvas.Ellipse(chanpositionx[7]-5, chanpositiony[7]-5, chanpositionx[7]+5, chanpositiony[7]+5);
  end;

  // Buffer auf Zeichenfläche plotten
  BitBlt(PaintBox1.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Taudioszeneneditor.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  valuex:array[0..7] of float;
  valuey:array[0..7] of float;
var
  i:integer;
begin
  if Shift=[ssLeft] then
  begin
    if (x<=105) and (x>=5) then
    begin
      for i:=0 to 7 do
        if chanselect[i] then chanpositionx[i]:=x;
    end else
    begin
      if (x>=5) then
      begin
      for i:=0 to 7 do
        if chanselect[i] then chanpositionx[i]:=105;
      end else
      begin
      for i:=0 to 7 do
        if chanselect[i] then chanpositionx[i]:=5;
      end;
    end;

    if (y<=105) and (y>=5) then
    begin
      for i:=0 to 7 do
        if chanselect[i] then chanpositiony[i]:=y;
    end else
    begin
      if (y>=5) then
      begin
      for i:=0 to 7 do
        if chanselect[i] then chanpositiony[i]:=105;
      end else
      begin
      for i:=0 to 7 do
        if chanselect[i] then chanpositiony[i]:=5;
      end;
    end;

    for i:=0 to 7 do
    begin
      valuex[i]:=(chanpositionx[i]-5)/100;
      valuey[i]:=(chanpositiony[i]-5)/100;
    end;

    // Einzelne Kanäle berechnen
    for i:=0 to chancount-1 do
    begin
      if (i=2) or (i=3) then
      begin
        // LFE und Center anders bei L/R behandeln
        TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(i))).Value:=((1-valuex[i]-0.5)*2)*(1-valuey[i]); // L -> Vorne L
        TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(i))).Value:=(valuex[i]-0.5)*2*(1-valuey[i]); // L -> Vorne R
        TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(i))).Value:=(1-(abs(valuex[i]-0.5)*2))*(1-valuey[i]); // L -> Center

        TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(i))).Value:=((1-valuex[i]-0.5)*2)*(1-abs(valuey[i]-0.5)*2); // L -> CenterL;
        TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(i))).Value:=(valuex[i]-0.5)*2*(1-abs(valuey[i]-0.5)*2); // L -> CenterR;

        TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(i))).Value:=((1-valuex[i]-0.5)*2)*valuey[i]; // L -> Hinten L
        TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(i))).Value:=(valuex[i]-0.5)*2*valuey[i]; // L -> Hinten R
      end else
      begin
        TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(i))).Value:=1-sqrt(valuex[i]*valuex[i]+valuey[i]*valuey[i]); // L -> Vorne L
        TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(i))).Value:=1-sqrt((1-valuex[i])*(1-valuex[i])+valuey[i]*valuey[i]); // L -> Vorne R
        TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(i))).Value:=(1-(abs(valuex[i]-0.5)*2))*(1-valuey[i]); // L -> Center

        TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(i))).Value:=(1-(abs(valuey[i]-0.5)*2))*(1-valuex[i]); // L -> CenterL;
        TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(i))).Value:=(1-(abs(valuey[i]-0.5)*2))*(valuex[i]); // L -> CenterR;

        TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(i))).Value:=1-sqrt(valuex[i]*valuex[i]+(1-valuey[i])*(1-valuey[i])); // L -> Hinten L
        TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(i))).Value:=1-sqrt((1-valuex[i])*(1-valuex[i])+(1-valuey[i])*(1-valuey[i])); // L -> Hinten R
      end;
    end;

    RefreshMatrix;
  end;
end;

procedure Taudioszeneneditor.PngBitBtn1Click(Sender: TObject);
begin
  BASS_ChannelPlay(TempMixChan, False);
  BASS_ChannelSetAttribute(TempMixChan, BASS_ATTRIB_VOL, strtoint(editvolume.text)/100);
end;

procedure Taudioszeneneditor.RefreshMatrix;
var
  k:integer;
  BassInfo: BASS_INFO;
begin
  BASS_ChannelSetAttribute(TempMixChan, BASS_ATTRIB_VOL, strtoint(editvolume.text)/100);

  begin
    matrix1[0]:=TJvSpinEdit(FindComponent('l'+inttostr(0))).Value; // L
    matrix1[1]:=TJvSpinEdit(FindComponent('r'+inttostr(0))).Value; // R
    matrix1[2]:=TJvSpinEdit(FindComponent('cen'+inttostr(0))).Value; // CEN
    matrix1[3]:=TJvSpinEdit(FindComponent('lfe'+inttostr(0))).Value; // LFE
    matrix1[4]:=TJvSpinEdit(FindComponent('sl'+inttostr(0))).Value; // SL
    matrix1[5]:=TJvSpinEdit(FindComponent('sr'+inttostr(0))).Value; // SR
    matrix1[6]:=TJvSpinEdit(FindComponent('hl'+inttostr(0))).Value; // HL
    matrix1[7]:=TJvSpinEdit(FindComponent('hr'+inttostr(0))).Value; // HR
  end;
  for k:=0 to 1 do
  begin    // [OUT] [IN]
    matrix2[0][k]:=TJvSpinEdit(FindComponent('l'+inttostr(k))).Value; // L
    matrix2[1][k]:=TJvSpinEdit(FindComponent('r'+inttostr(k))).Value; // R
    matrix2[2][k]:=TJvSpinEdit(FindComponent('cen'+inttostr(k))).Value; // CEN
    matrix2[3][k]:=TJvSpinEdit(FindComponent('lfe'+inttostr(k))).Value; // LFE
    matrix2[4][k]:=TJvSpinEdit(FindComponent('sl'+inttostr(k))).Value; // SL
    matrix2[5][k]:=TJvSpinEdit(FindComponent('sr'+inttostr(k))).Value; // SR
    matrix2[6][k]:=TJvSpinEdit(FindComponent('hl'+inttostr(k))).Value; // HL
    matrix2[7][k]:=TJvSpinEdit(FindComponent('hr'+inttostr(k))).Value; // HR
  end;
  for k:=0 to 3 do
  begin    // [OUT][k] [IN][k]
    matrix4[0][k]:=TJvSpinEdit(FindComponent('l'+inttostr(k))).Value; // L
    matrix4[1][k]:=TJvSpinEdit(FindComponent('r'+inttostr(k))).Value; // R
    matrix4[2][k]:=TJvSpinEdit(FindComponent('cen'+inttostr(k))).Value; // CEN
    matrix4[3][k]:=TJvSpinEdit(FindComponent('lfe'+inttostr(k))).Value; // LFE
    matrix4[4][k]:=TJvSpinEdit(FindComponent('sl'+inttostr(k))).Value; // SL
    matrix4[5][k]:=TJvSpinEdit(FindComponent('sr'+inttostr(k))).Value; // SR
    matrix4[6][k]:=TJvSpinEdit(FindComponent('hl'+inttostr(k))).Value; // HL
    matrix4[7][k]:=TJvSpinEdit(FindComponent('hr'+inttostr(k))).Value; // HR
  end;
  for k:=0 to 5 do
  begin    // [OUT][k] [IN][k]
    matrix6[0][k]:=TJvSpinEdit(FindComponent('l'+inttostr(k))).Value; // L
    matrix6[1][k]:=TJvSpinEdit(FindComponent('r'+inttostr(k))).Value; // R
    matrix6[2][k]:=TJvSpinEdit(FindComponent('cen'+inttostr(k))).Value; // CEN
    matrix6[3][k]:=TJvSpinEdit(FindComponent('lfe'+inttostr(k))).Value; // LFE
    matrix6[4][k]:=TJvSpinEdit(FindComponent('sl'+inttostr(k))).Value; // SL
    matrix6[5][k]:=TJvSpinEdit(FindComponent('sr'+inttostr(k))).Value; // SR
    matrix6[6][k]:=TJvSpinEdit(FindComponent('hl'+inttostr(k))).Value; // HL
    matrix6[7][k]:=TJvSpinEdit(FindComponent('hr'+inttostr(k))).Value; // HR
  end;
  for k:=0 to 7 do
  begin    // [OUT][k] [IN][k]
    matrix8[0][k]:=TJvSpinEdit(FindComponent('l'+inttostr(k))).Value; // L
    matrix8[1][k]:=TJvSpinEdit(FindComponent('r'+inttostr(k))).Value; // R
    matrix8[2][k]:=TJvSpinEdit(FindComponent('cen'+inttostr(k))).Value; // CEN
    matrix8[3][k]:=TJvSpinEdit(FindComponent('lfe'+inttostr(k))).Value; // LFE
    matrix8[4][k]:=TJvSpinEdit(FindComponent('sl'+inttostr(k))).Value; // SL
    matrix8[5][k]:=TJvSpinEdit(FindComponent('sr'+inttostr(k))).Value; // SR
    matrix8[6][k]:=TJvSpinEdit(FindComponent('hl'+inttostr(k))).Value; // HL
    matrix8[7][k]:=TJvSpinEdit(FindComponent('hr'+inttostr(k))).Value; // HR
  end;

  case chancount of
    1: BASS_Mixer_ChannelSetMatrix(TempChan, @matrix1);
    2: BASS_Mixer_ChannelSetMatrix(TempChan, @matrix2);
    4: BASS_Mixer_ChannelSetMatrix(TempChan, @matrix4);
    6: BASS_Mixer_ChannelSetMatrix(TempChan, @matrix6);
    8: BASS_Mixer_ChannelSetMatrix(TempChan, @matrix8);
  end;

  BASS_GetInfo(BassInfo);
  for k:=0 to 7 do
  begin
    TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).Visible:=(k<chancount) and (BassInfo.speakers>0);
    TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).Visible:=(k<chancount) and (BassInfo.speakers>1);
    TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).Visible:=(k<chancount) and (BassInfo.speakers>5);
    TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).Visible:=(k<chancount) and (BassInfo.speakers>5);
    TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).Visible:=(k<chancount) and (BassInfo.speakers>7);
    TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).Visible:=(k<chancount) and (BassInfo.speakers>7);
    TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).Visible:=(k<chancount) and (BassInfo.speakers>3);
    TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).Visible:=(k<chancount) and (BassInfo.speakers>3);
  end;
end;

procedure Taudioszeneneditor.PngBitBtn2Click(Sender: TObject);
begin
  BASS_ChannelSetPosition(TempChan, 0, BASS_POS_BYTE);

  Application.ProcessMessages;
  sleep(100);

  BASS_ChannelStop(TempMixChan);
end;

procedure Taudioszeneneditor.Button1Click(Sender: TObject);
begin
  if TempMixChan<>0 then
  begin
    BASS_ChannelStop(TempMixChan);
    BASS_Mixer_ChannelRemove(TempChan);
    BASS_StreamFree(TempMixChan);
    BASS_StreamFree(TempChan);
    TempMixChan:=0;
    TempChan:=0;
  end;
end;

procedure Taudioszeneneditor.Button4Click(Sender: TObject);
begin
  if TempMixChan<>0 then
  begin
    BASS_ChannelStop(TempMixChan);
    BASS_Mixer_ChannelRemove(TempChan);
    BASS_StreamFree(TempMixChan);
    BASS_StreamFree(TempChan);
    TempMixChan:=0;
    TempChan:=0;
  end;
end;

procedure Taudioszeneneditor.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=0 to 7 do
  begin
    if chanpositionx[i]<5 then chanpositionx[i]:=5;
    if chanpositiony[i]<5 then chanpositiony[i]:=5;
    if chanpositionx[i]>105 then chanpositionx[i]:=105;
    if chanpositiony[i]>105 then chanpositiony[i]:=105;
    chanselect[i]:=false;
  end;

  for i:=0 to 7 do
  begin
    if (x>chanpositionx[i]-5) and (x<chanpositionx[i]+5) and (y>chanpositiony[i]-5) and (y<chanpositiony[i]+5) then
    begin
      chanselect[i]:=true;
      break;
    end;
  end;
end;

procedure Taudioszeneneditor.l0MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RefreshMatrix;
end;

procedure Taudioszeneneditor.l0KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  RefreshMatrix;
end;

procedure Taudioszeneneditor.Button2Click(Sender: TObject);
begin
  if audioszeneneditor.ClientWidth<1001 then
  begin
    audioszeneneditor.ClientWidth:=1001;
    button2.Caption:=_('<< Optionen');
  end else
  begin
    audioszeneneditor.ClientWidth:=541;
    button2.Caption:=_('Optionen >>');
  end;
end;

procedure Taudioszeneneditor.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=0 to 7 do
  begin
    chanselect[i]:=false;
  end;
end;

procedure Taudioszeneneditor.Button3Click(Sender: TObject);
var
  k:integer;
begin
  for k:=0 to 7 do
  begin
      TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value-0.05;
      TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value-0.05;
      TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value-0.05;
      TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value-0.05;
      TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value-0.05;
      TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value-0.05;
      TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value-0.05;
      TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value-0.05;
  end;
  RefreshMatrix;
end;

procedure Taudioszeneneditor.Button5Click(Sender: TObject);
var
  k:integer;
begin
  for k:=0 to 7 do
  begin
    if TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value>0 then
      TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value+0.05;
    if TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value>0 then
      TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value+0.05;
    if TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value>0 then
      TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value+0.05;
    if TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value>0 then
      TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value+0.05;
    if TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value>0 then
      TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value+0.05;
    if TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value>0 then
      TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value+0.05;
    if TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value>0 then
      TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value+0.05;
    if TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value>0 then
      TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value+0.05;
  end;
  RefreshMatrix;
end;

procedure Taudioszeneneditor.Button6Click(Sender: TObject);
begin
  ShowMessage(_('Mit der angezeigten Matrix können sämtliche Audiokanäle der Datei beliebig den entsprechenden Lautsprecherkanälen zugewiesen werden.')+#10#13+#10#13+_('Gehen Sie die Matrix von Links nach Rechts durch und geben Sie einen entsprechenden Wert (0.0 bis 1.0) in das Feld des oben angegebenen Lautsprecherkanals ein.'));
end;

procedure Taudioszeneneditor.editVolumeChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
  BASS_ChannelSetAttribute(TempMixChan, BASS_ATTRIB_VOL, strtoint(editvolume.text)/100);
end;

procedure Taudioszeneneditor.CreateParams(var Params:TCreateParams);
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

procedure Taudioszeneneditor.PngBitBtn3Click(Sender: TObject);
begin
  BASS_ChannelPause(TempMixChan);
end;

procedure Taudioszeneneditor.Button7Click(Sender: TObject);
var
  i,k:integer;
begin
  // Korrektur der einzelnen Positionen anhand Kanalanzahl
  case chancount of
    1: // Mono
    begin
      chanpositionx[0]:=55;   // FL
      chanpositionx[1]:=105;  // FR
      chanpositionx[2]:=55;   // Center
      chanpositionx[3]:=55;   // LFE
      chanpositionx[4]:=5;    // RL
      chanpositionx[5]:=105;  // RR
      chanpositionx[6]:=5;    // SL
      chanpositionx[7]:=105;  // SR

      chanpositiony[0]:=55;   // FL
      chanpositiony[1]:=5;    // FR
      chanpositiony[2]:=5;    // Center
      chanpositiony[3]:=105;  // LFE
      chanpositiony[4]:=105;  // RL
      chanpositiony[5]:=105;  // RR
      chanpositiony[6]:=55;   // SL
      chanpositiony[7]:=55;   // SR
    end;
    2: // Stereo
    begin
      chanpositionx[0]:=5;    // FL
      chanpositionx[1]:=105;  // FR
      chanpositionx[2]:=55;   // Center
      chanpositionx[3]:=55;   // LFE
      chanpositionx[4]:=5;    // RL
      chanpositionx[5]:=105;  // RR
      chanpositionx[6]:=5;    // SL
      chanpositionx[7]:=105;  // SR

      chanpositiony[0]:=55;   // FL
      chanpositiony[1]:=55;   // FR
      chanpositiony[2]:=5;    // Center
      chanpositiony[3]:=105;  // LFE
      chanpositiony[4]:=105;  // RL
      chanpositiony[5]:=105;  // RR
      chanpositiony[6]:=55;   // SL
      chanpositiony[7]:=55;   // SR
    end;
    3: // LCR
    begin
      chanpositionx[0]:=5;   // FL
      chanpositionx[1]:=105;  // FR
      chanpositionx[2]:=55;   // Center
      chanpositionx[3]:=55;   // LFE
      chanpositionx[4]:=5;    // RL
      chanpositionx[5]:=105;  // RR
      chanpositionx[6]:=5;    // SL
      chanpositionx[7]:=105;  // SR

      chanpositiony[0]:=55;   // FL
      chanpositiony[1]:=55;    // FR
      chanpositiony[2]:=5;    // Center
      chanpositiony[3]:=105;  // LFE
      chanpositiony[4]:=105;  // RL
      chanpositiony[5]:=105;  // RR
      chanpositiony[6]:=55;   // SL
      chanpositiony[7]:=55;   // SR
    end;
    4..8: // Restliche
    begin
      chanpositionx[0]:=5;    // FL
      chanpositionx[1]:=105;  // FR
      chanpositionx[2]:=55;   // Center
      chanpositionx[3]:=55;   // LFE
      chanpositionx[4]:=5;    // RL
      chanpositionx[5]:=105;  // RR
      chanpositionx[6]:=5;    // SL
      chanpositionx[7]:=105;  // SR

      chanpositiony[0]:=5;    // FL
      chanpositiony[1]:=5;    // FR
      chanpositiony[2]:=5;    // Center
      chanpositiony[3]:=55;  // LFE
      chanpositiony[4]:=105;  // RL
      chanpositiony[5]:=105;  // RR
      chanpositiony[6]:=55;   // SL
      chanpositiony[7]:=55;   // SR
    end;
  end;

  PaintBox1MouseMove(nil, [ssLeft], 0, 0);

  // hier nun alle Werte maximieren
  for i:=0 to 20 do
  begin
    for k:=0 to 7 do
    begin
      if TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('l'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('r'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('cen'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('lfe'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('sl'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('sr'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('hl'+inttostr(k))).value+0.05;
      if TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value>0 then
        TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value:=TJvSpinEdit(audioszeneneditor.FindComponent('hr'+inttostr(k))).value+0.05;
    end;
  end;
  RefreshMatrix;
end;

end.
