unit pmm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons, PngBitBtn, CheckLst,
  JvExCheckLst, JvCheckListBox, gnugettext, ComCtrls, Mask, JvExMask,
  JvSpin, Registry;

type
  Tpmmform = class(TForm)
    Panel1: TPanel;
    Shape3: TShape;
    Image1: TImage;
    Panel2: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    OKBtn: TButton;
    GroupBox1: TGroupBox;
    add0: TPngBitBtn;
    rem0: TPngBitBtn;
    GroupBox2: TGroupBox;
    pmmtimer: TTimer;
    devbox0: TJvCheckListBox;
    fadezeitbar: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    delayzeitbar: TTrackBar;
    Label3: TLabel;
    Label4: TLabel;
    check1: TRadioButton;
    check2: TRadioButton;
    check3: TRadioButton;
    GroupBox3: TGroupBox;
    redcheck: TCheckBox;
    greencheck: TCheckBox;
    bluecheck: TCheckBox;
    redslider: TTrackBar;
    greenslider: TTrackBar;
    blueslider: TTrackBar;
    luminanceslider: TTrackBar;
    Label5: TLabel;
    luminancelbl: TLabel;
    bluelbl: TLabel;
    greenlbl: TLabel;
    redlbl: TLabel;
    allowmixing: TCheckBox;
    GroupBox4: TGroupBox;
    presetbox: TListBox;
    addpreset: TPngBitBtn;
    deletepreset: TPngBitBtn;
    Label6: TLabel;
    minluminancelbl: TLabel;
    minluminanceslider: TTrackBar;
    noblackouts: TCheckBox;
    usepantiltcheck: TCheckBox;
    fadezeitpantiltbar: TTrackBar;
    Label7: TLabel;
    Label8: TLabel;
    usergbcheck: TCheckBox;
    usedimmercheck: TCheckBox;
    usecolor12check: TCheckBox;
    randomcheck: TCheckBox;
    EditBtn: TPngBitBtn;
    beat_syncbtn: TButton;
    presettimer: TTimer;
    randompresetcheck: TCheckBox;
    Label9: TLabel;
    randompresettimeedit: TJvSpinEdit;
    Label10: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure add0Click(Sender: TObject);
    procedure rem0Click(Sender: TObject);
    procedure pmmtimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure devbox0KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure devbox0MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure fadezeitbarChange(Sender: TObject);
    procedure delayzeitbarChange(Sender: TObject);
    procedure check1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure check1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure redsliderChange(Sender: TObject);
    procedure greensliderChange(Sender: TObject);
    procedure bluesliderChange(Sender: TObject);
    procedure luminancesliderChange(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure minluminancesliderChange(Sender: TObject);
    procedure fadezeitpantiltbarChange(Sender: TObject);
    procedure addpresetClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure presetboxClick(Sender: TObject);
    procedure deletepresetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure beat_syncbtnClick(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure randompresetcheckMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure randompresetcheckKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure randompresettimeeditChange(Sender: TObject);
    procedure presettimerTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private-Deklarationen }
    beat_starttime,beat_endtime:TTimeStamp;
    beat_syncFirstclick:boolean;
    procedure CalculateColors(var R,G,B:byte);
  public
    { Public-Deklarationen }
    selected:array of boolean;
    procedure pmmstep;
    procedure RefreshListBoxes;
  end;

var
  pmmform: Tpmmform;

implementation

uses adddevicetogroupfrm, PCDIMMER, geraetesteuerungfrm, pcdUtils;

{$R *.dfm}

procedure Tpmmform.add0Click(Sender: TObject);
var
  i,j:integer;
  vorhanden:boolean;
begin
  adddevicetogroupform.showmodal;

  if adddevicetogroupform.modalresult=mrOK then
  begin
    for i:=0 to length(mainform.devices)-1 do
    begin
      if adddevicetogroupform.listbox1.Selected[i] then
      begin
        vorhanden:=false;
        for j:=0 to length(mainform.pmmlights)-1 do
        begin
          if IsEqualGUID(mainform.devices[i].ID,mainform.pmmlights[j]) then
          begin
            vorhanden:=true;
            break;
          end;
        end;
        if not vorhanden then
        begin
          setlength(mainform.pmmlights,length(mainform.pmmlights)+1);
          setlength(selected, length(selected)+1);
          selected[length(selected)-1]:=true;
          mainform.pmmlights[length(mainform.pmmlights)-1]:=mainform.devices[i].ID;
        end;
      end;
    end;
    RefreshListboxes;
  end;
end;

procedure Tpmmform.rem0Click(Sender: TObject);
var
  i:integer;
begin
  if devbox0.ItemIndex>-1 then
  begin
    for i:=devbox0.ItemIndex to length(mainform.pmmlights)-2 do
    begin
      mainform.pmmlights[i]:=mainform.pmmlights[i+1];
      selected[i]:=selected[i+1];
    end;

    setlength(mainform.pmmlights,length(mainform.pmmlights)-1);
    setlength(selected, length(selected)-1);
    RefreshListboxes;
  end;
end;

procedure Tpmmform.RefreshListBoxes;
var
  i:integer;
begin
  devbox0.Items.Clear;

  setlength(selected, length(mainform.pmmlights));

  for i:=0 to length(mainform.pmmlights)-1 do
  begin
    devbox0.Items.Add(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.pmmlights[i])].Name);
    devbox0.Checked[i]:=true;
  end;

  if (length(selected)>0) then
  for i:=0 to length(selected)-1 do
    selected[i]:=devbox0.Checked[i];

  presetbox.Items.clear;
  for i:=0 to length(mainform.PartyMuckenModul)-1 do
    presetbox.items.add(mainform.PartyMuckenModul[i].Name);
end;

procedure Tpmmform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);

  Randomize;
  beat_syncFirstclick:=true;

  RefreshListBoxes;
end;

procedure Tpmmform.pmmtimerTimer(Sender: TObject);
begin
  PMMstep;
end;

procedure Tpmmform.devbox0KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
begin
  if length(selected)>0 then
  for i:=0 to length(selected)-1 do
    selected[i]:=devbox0.Checked[i];
end;

procedure Tpmmform.devbox0MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  if length(selected)>0 then
  for i:=0 to length(selected)-1 do
    selected[i]:=devbox0.Checked[i];
end;

procedure Tpmmform.fadezeitbarChange(Sender: TObject);
begin
  label2.caption:=mainform.MillisecondsToTimeShort(fadezeitbar.position);
end;

procedure Tpmmform.delayzeitbarChange(Sender: TObject);
begin
  label4.caption:=mainform.MillisecondsToTimeShort(delayzeitbar.position);
end;

procedure Tpmmform.CalculateColors(var R,G,B:byte);
begin
  if allowmixing.checked then
  begin
    if redcheck.Checked then
      R:=Random(redslider.position)
    else
      R:=0;
    if greencheck.Checked then
      G:=Random(greenslider.position)
    else
      G:=0;
    if bluecheck.Checked then
      B:=Random(blueslider.position)
    else
      B:=0;
  end else
  begin
    case Random(3) of
      0:
      begin
        if redcheck.Checked then
          R:=Random(redslider.position)
        else
          R:=0;
        G:=0;
        B:=0;
      end;
      1:
      begin
        if greencheck.Checked then
          G:=Random(greenslider.position)
        else
          G:=0;
        R:=0;
        B:=0;
      end;
      2:
      begin
        if bluecheck.Checked then
          B:=Random(blueslider.position)
        else
          B:=0;
        R:=0;
        G:=0;
      end;
    end;
  end;

  SetLuminance(R, G, B, minluminanceslider.Position+Random(luminanceslider.position-minluminanceslider.Position));
  if (R=G) and (R=B) then
  begin
    R:=0;
    G:=0;
    B:=0;
  end else
    MaximizeSaturation(R, G, B);
end;

procedure Tpmmform.pmmstep;
var
  i,Counter:integer;
  R,G,B,Mode:byte;
begin
  for i:=0 to length(mainform.pmmlights)-1 do
  begin
    if (selected[i] and (not randomcheck.Checked)) or (randomcheck.Checked and (frac(Random(256)/2)=0)) then
    begin
      // Farbe berechnen
      CalculateColors(R,G,B);

      if noblackouts.Checked and ((R<=5) or (G<=5) or (B<=5)) then
      begin
        Counter:=0;
        repeat
          CalculateColors(R,G,B);
          inc(Counter);
        until (R>5) or (G>5) or (B>5) or (Counter>50);
      end;

      Mode:=0;
      if usergbcheck.checked then Mode:=1;
      if usecolor12check.checked then Mode:=Mode+2;
      if usedimmercheck.checked then Mode:=Mode+4;

      geraetesteuerung.set_color(mainform.pmmlights[i], R, G, B, Random(fadezeitbar.position), Random(delayzeitbar.position), Mode);
      if usepantiltcheck.Checked then
        geraetesteuerung.set_pantilt(mainform.pmmlights[i], -1, Random(256), -1, Random(256), Random(fadezeitpantiltbar.position));
    end;
  end;
end;

procedure Tpmmform.check1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  pmmtimer.Enabled:=check2.checked;
end;

procedure Tpmmform.check1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pmmtimer.Enabled:=check2.checked;
end;

procedure Tpmmform.redsliderChange(Sender: TObject);
begin
  redlbl.caption:=inttostr(round(redslider.position/2.55))+'%';
end;

procedure Tpmmform.greensliderChange(Sender: TObject);
begin
  greenlbl.caption:=inttostr(round(greenslider.position/2.55))+'%';
end;

procedure Tpmmform.bluesliderChange(Sender: TObject);
begin
  bluelbl.caption:=inttostr(round(blueslider.position/2.55))+'%';
end;

procedure Tpmmform.luminancesliderChange(Sender: TObject);
begin
  luminancelbl.caption:=inttostr(round(luminanceslider.position/2.55))+'%';
  minluminanceslider.Max:=luminanceslider.position-15;
end;

procedure Tpmmform.OKBtnClick(Sender: TObject);
begin
  close;
end;

procedure Tpmmform.minluminancesliderChange(Sender: TObject);
begin
  minluminancelbl.caption:=inttostr(round(minluminanceslider.position/2.55))+'%';
  luminanceslider.Min:=minluminanceslider.position+15;
end;

procedure Tpmmform.fadezeitpantiltbarChange(Sender: TObject);
begin
  label8.caption:=mainform.MillisecondsToTimeShort(fadezeitpantiltbar.position);
end;

procedure Tpmmform.addpresetClick(Sender: TObject);
begin
  setlength(mainform.PartyMuckenModul, length(mainform.PartyMuckenModul)+1);

  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].Name:=InputBox(_('Beschreibung eingeben'), _('Bitte geben Sie eine kurze Beschreibung für dieses Preset an:'),_('Neues Preset'));
  if check1.Checked then mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].ControlMode:=0;
  if check2.Checked then mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].ControlMode:=1;
  if check3.Checked then mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].ControlMode:=2;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].UsePanTilt:=usepantiltcheck.Checked;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].UseRandom:=randomcheck.checked;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].MaxFadetime:=fadezeitbar.position;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].MaxPanTiltTime:=fadezeitpantiltbar.position;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].MaxDelayTime:=delayzeitbar.position;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].UseRed:=redcheck.checked;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].UseGreen:=greencheck.checked;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].UseBlue:=bluecheck.checked;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].MaxRed:=redslider.position;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].MaxGreen:=greenslider.position;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].MaxBlue:=blueslider.position;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].AllowMixing:=allowmixing.checked;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].NoBlackDevices:=noblackouts.checked;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].UseRGB:=usergbcheck.checked;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].UseDimmer:=usedimmercheck.checked;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].UseColor12:=usecolor12check.checked;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].MaxLuminance:=luminanceslider.position;
  mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].MinLuminance:=minluminanceslider.position;

  presetbox.items.Add(mainform.PartyMuckenModul[length(mainform.PartyMuckenModul)-1].Name);
end;

procedure Tpmmform.EditBtnClick(Sender: TObject);
begin
  if (presetbox.itemindex>-1) and (presetbox.itemindex<length(mainform.PartyMuckenModul)) then
  begin
    mainform.PartyMuckenModul[presetbox.itemindex].Name:=InputBox(_('Beschreibung ändern'), _('Bitte geben Sie eine kurze Beschreibung für dieses Preset:'),mainform.PartyMuckenModul[presetbox.itemindex].Name);
    presetbox.Items[presetbox.itemindex]:=mainform.PartyMuckenModul[presetbox.itemindex].Name;
  end;
end;

procedure Tpmmform.presetboxClick(Sender: TObject);
begin
  if (presetbox.itemindex>-1) and (presetbox.itemindex<length(mainform.PartyMuckenModul)) then
  begin
    check1.Checked:=mainform.PartyMuckenModul[presetbox.itemindex].ControlMode=0;
    check2.Checked:=mainform.PartyMuckenModul[presetbox.itemindex].ControlMode=1;
    check3.Checked:=mainform.PartyMuckenModul[presetbox.itemindex].ControlMode=2;
    pmmtimer.Enabled:=check2.checked;
    usepantiltcheck.Checked:=mainform.PartyMuckenModul[presetbox.itemindex].UsePanTilt;
    randomcheck.checked:=mainform.PartyMuckenModul[presetbox.itemindex].UseRandom;
    fadezeitbar.position:=mainform.PartyMuckenModul[presetbox.itemindex].MaxFadetime;
    fadezeitpantiltbar.position:=mainform.PartyMuckenModul[presetbox.itemindex].MaxPanTiltTime;
    delayzeitbar.position:=mainform.PartyMuckenModul[presetbox.itemindex].MaxDelayTime;
    redcheck.checked:=mainform.PartyMuckenModul[presetbox.itemindex].UseRed;
    greencheck.checked:=mainform.PartyMuckenModul[presetbox.itemindex].UseGreen;
    bluecheck.checked:=mainform.PartyMuckenModul[presetbox.itemindex].UseBlue;
    redslider.position:=mainform.PartyMuckenModul[presetbox.itemindex].MaxRed;
    greenslider.position:=mainform.PartyMuckenModul[presetbox.itemindex].MaxGreen;
    blueslider.position:=mainform.PartyMuckenModul[presetbox.itemindex].MaxBlue;
    allowmixing.checked:=mainform.PartyMuckenModul[presetbox.itemindex].AllowMixing;
    noblackouts.checked:=mainform.PartyMuckenModul[presetbox.itemindex].NoBlackDevices;
    usergbcheck.checked:=mainform.PartyMuckenModul[presetbox.itemindex].UseRGB;
    usedimmercheck.checked:=mainform.PartyMuckenModul[presetbox.itemindex].UseDimmer;
    usecolor12check.checked:=mainform.PartyMuckenModul[presetbox.itemindex].UseColor12;
    luminanceslider.position:=mainform.PartyMuckenModul[presetbox.itemindex].MaxLuminance;
    minluminanceslider.position:=mainform.PartyMuckenModul[presetbox.itemindex].MinLuminance;
  end;
end;

procedure Tpmmform.deletepresetClick(Sender: TObject);
var
  i:integer;
begin
  if (presetbox.itemindex>-1) and (presetbox.itemindex<length(mainform.PartyMuckenModul)) then
  begin
    for i:=presetbox.itemindex to length(mainform.PartyMuckenModul)-2 do
      mainform.PartyMuckenModul[i]:=mainform.PartyMuckenModul[i+1];
    setlength(mainform.PartyMuckenModul, length(mainform.PartyMuckenModul)-1);

    presetbox.Items.clear;
    for i:=0 to length(mainform.PartyMuckenModul)-1 do
      presetbox.items.add(mainform.PartyMuckenModul[i].Name);
  end;
end;

procedure Tpmmform.FormShow(Sender: TObject);
var
  LReg:Tregistry;
begin
  RefreshListBoxes;

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
  			LReg.WriteBool('Showing PartyModul',true);

        if not LReg.KeyExists('PartyModul') then
	        LReg.CreateKey('PartyModul');
	      if LReg.OpenKey('PartyModul',true) then
	      begin
          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+pmmform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              pmmform.Left:=LReg.ReadInteger('PosX')
            else
              pmmform.Left:=0;
          end else
            pmmform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              pmmform.Top:=LReg.ReadInteger('PosY')
            else
              pmmform.Top:=0;
          end else
            pmmform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tpmmform.beat_syncbtnClick(Sender: TObject);
begin
  if beat_syncFirstclick then
  begin
    beat_starttime:=DateTimeToTimeStamp(now);
    beat_syncbtn.Caption:=_('Stop');
    beat_syncFirstclick:=false;
  end else
  begin
    beat_endtime:=DateTimeToTimeStamp(now);
    pmmTimer.Interval:=round(beat_endtime.Time-beat_starttime.Time);
    beat_syncbtn.Caption:=_('Sync');
    beat_syncFirstclick:=true;
  end;
end;

procedure Tpmmform.CreateParams(var Params:TCreateParams);
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

procedure Tpmmform.randompresetcheckMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  presettimer.Enabled:=randompresetcheck.Checked;
end;

procedure Tpmmform.randompresetcheckKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  presettimer.Enabled:=randompresetcheck.Checked;
end;

procedure Tpmmform.randompresettimeeditChange(Sender: TObject);
begin
  presettimer.Interval:=round(randompresettimeedit.value*1000);
end;

procedure Tpmmform.presettimerTimer(Sender: TObject);
begin
  if presetbox.Items.Count>0 then
  begin
    presetbox.ItemIndex:=Random(presetbox.Items.Count);
    presetboxClick(nil);
  end;
end;

procedure Tpmmform.SpeedButton1Click(Sender: TObject);
var
  i,Count:integer;
begin
	if SaveDialog1.Execute then
  begin
    with mainform do
    begin
      Filestream:=TFileStream.Create(SaveDialog1.FileName, fmCreate);

      Count:=length(PartyMuckenModul);
      Filestream.WriteBuffer(Count,sizeof(Count));
      for i:=0 to Count-1 do
      begin
        Filestream.WriteBuffer(PartyMuckenModul[i].Name,sizeof(PartyMuckenModul[i].Name));
        Filestream.WriteBuffer(PartyMuckenModul[i].ControlMode,sizeof(PartyMuckenModul[i].ControlMode));
        Filestream.WriteBuffer(PartyMuckenModul[i].UsePanTilt,sizeof(PartyMuckenModul[i].UsePanTilt));
        Filestream.WriteBuffer(PartyMuckenModul[i].UseRandom,sizeof(PartyMuckenModul[i].UseRandom));
        Filestream.WriteBuffer(PartyMuckenModul[i].MaxFadetime,sizeof(PartyMuckenModul[i].MaxFadetime));
        Filestream.WriteBuffer(PartyMuckenModul[i].MaxPanTiltTime,sizeof(PartyMuckenModul[i].MaxPanTiltTime));
        Filestream.WriteBuffer(PartyMuckenModul[i].MaxDelayTime,sizeof(PartyMuckenModul[i].MaxDelayTime));
        Filestream.WriteBuffer(PartyMuckenModul[i].UseRed,sizeof(PartyMuckenModul[i].UseRed));
        Filestream.WriteBuffer(PartyMuckenModul[i].UseGreen,sizeof(PartyMuckenModul[i].UseGreen));
        Filestream.WriteBuffer(PartyMuckenModul[i].UseBlue,sizeof(PartyMuckenModul[i].UseBlue));
        Filestream.WriteBuffer(PartyMuckenModul[i].MaxRed,sizeof(PartyMuckenModul[i].MaxRed));
        Filestream.WriteBuffer(PartyMuckenModul[i].MaxGreen,sizeof(PartyMuckenModul[i].MaxGreen));
        Filestream.WriteBuffer(PartyMuckenModul[i].MaxBlue,sizeof(PartyMuckenModul[i].MaxBlue));
        Filestream.WriteBuffer(PartyMuckenModul[i].AllowMixing,sizeof(PartyMuckenModul[i].AllowMixing));
        Filestream.WriteBuffer(PartyMuckenModul[i].NoBlackDevices,sizeof(PartyMuckenModul[i].NoBlackDevices));
        Filestream.WriteBuffer(PartyMuckenModul[i].UseRGB,sizeof(PartyMuckenModul[i].UseRGB));
        Filestream.WriteBuffer(PartyMuckenModul[i].UseDimmer,sizeof(PartyMuckenModul[i].UseDimmer));
        Filestream.WriteBuffer(PartyMuckenModul[i].UseColor12,sizeof(PartyMuckenModul[i].UseColor12));
        Filestream.WriteBuffer(PartyMuckenModul[i].MaxLuminance,sizeof(PartyMuckenModul[i].MaxLuminance));
        Filestream.WriteBuffer(PartyMuckenModul[i].MinLuminance,sizeof(PartyMuckenModul[i].MinLuminance));
      end;

      FileStream.Free;
    end;
  end;
end;

procedure Tpmmform.SpeedButton2Click(Sender: TObject);
var
  i,count:integer;
begin
  if OpenDialog1.Execute then
  begin
    with mainform do
    begin
      Filestream:=TFileStream.Create(OpenDialog1.Filename, fmOpenRead);

      Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(PartyMuckenModul, Count);
      for i:=0 to Count-1 do
      begin
        Filestream.ReadBuffer(PartyMuckenModul[i].Name,sizeof(PartyMuckenModul[i].Name));
        Filestream.ReadBuffer(PartyMuckenModul[i].ControlMode,sizeof(PartyMuckenModul[i].ControlMode));
        Filestream.ReadBuffer(PartyMuckenModul[i].UsePanTilt,sizeof(PartyMuckenModul[i].UsePanTilt));
        Filestream.ReadBuffer(PartyMuckenModul[i].UseRandom,sizeof(PartyMuckenModul[i].UseRandom));
        Filestream.ReadBuffer(PartyMuckenModul[i].MaxFadetime,sizeof(PartyMuckenModul[i].MaxFadetime));
        Filestream.ReadBuffer(PartyMuckenModul[i].MaxPanTiltTime,sizeof(PartyMuckenModul[i].MaxPanTiltTime));
        Filestream.ReadBuffer(PartyMuckenModul[i].MaxDelayTime,sizeof(PartyMuckenModul[i].MaxDelayTime));
        Filestream.ReadBuffer(PartyMuckenModul[i].UseRed,sizeof(PartyMuckenModul[i].UseRed));
        Filestream.ReadBuffer(PartyMuckenModul[i].UseGreen,sizeof(PartyMuckenModul[i].UseGreen));
        Filestream.ReadBuffer(PartyMuckenModul[i].UseBlue,sizeof(PartyMuckenModul[i].UseBlue));
        Filestream.ReadBuffer(PartyMuckenModul[i].MaxRed,sizeof(PartyMuckenModul[i].MaxRed));
        Filestream.ReadBuffer(PartyMuckenModul[i].MaxGreen,sizeof(PartyMuckenModul[i].MaxGreen));
        Filestream.ReadBuffer(PartyMuckenModul[i].MaxBlue,sizeof(PartyMuckenModul[i].MaxBlue));
        Filestream.ReadBuffer(PartyMuckenModul[i].AllowMixing,sizeof(PartyMuckenModul[i].AllowMixing));
        Filestream.ReadBuffer(PartyMuckenModul[i].NoBlackDevices,sizeof(PartyMuckenModul[i].NoBlackDevices));
        Filestream.ReadBuffer(PartyMuckenModul[i].UseRGB,sizeof(PartyMuckenModul[i].UseRGB));
        Filestream.ReadBuffer(PartyMuckenModul[i].UseDimmer,sizeof(PartyMuckenModul[i].UseDimmer));
        Filestream.ReadBuffer(PartyMuckenModul[i].UseColor12,sizeof(PartyMuckenModul[i].UseColor12));
        Filestream.ReadBuffer(PartyMuckenModul[i].MaxLuminance,sizeof(PartyMuckenModul[i].MaxLuminance));
        Filestream.ReadBuffer(PartyMuckenModul[i].MinLuminance,sizeof(PartyMuckenModul[i].MinLuminance));
      end;

      FileStream.Free;
    end;

    RefreshListboxes;
  end;
end;

procedure Tpmmform.FormHide(Sender: TObject);
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
          LReg.WriteBool('Showing PartyModul',false);
        end;
      end;
    end;
	end;
end;

end.
