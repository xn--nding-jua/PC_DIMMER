unit skripttimer_edit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gnugettext, Mask,
  JvExMask, JvSpin, Math, DateUtils, Registry, jpeg, JvExControls,
  JvGradient, pngimage;

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

  Tskripttimer_editform = class(TForm)
    skripttimer_file1: TEdit;
    skripttimer_filechange1: TButton;
    Skripttimer_date1: TDateTimePicker;
    Skripttimer_typechange1: TComboBox;
    skripttimer_active1: TCheckBox;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    skripttimer_openfile: TOpenDialog;
    Label5: TLabel;
    Label6: TLabel;
    skripttimer_time: TLabel;
    skripttimer_date: TLabel;
    Clocktimer: TTimer;
    ComboBox1: TComboBox;
    Label7: TLabel;
    Shape4: TShape;
    Shape1: TShape;
    timeoption1: TRadioButton;
    timeoption2: TRadioButton;
    timeoption3: TRadioButton;
    Label8: TLabel;
    Label9: TLabel;
    longitudeedit: TJvSpinEdit;
    latitudeedit: TJvSpinEdit;
    Label10: TLabel;
    Shape2: TShape;
    risingtimelbl: TLabel;
    citydropdown: TComboBox;
    Image1: TImage;
    Label11: TLabel;
    Label12: TLabel;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image2: TImage;
    Label34: TLabel;
    Label35: TLabel;
    skripttimer_hour: TEdit;
    skripttimer_minute: TEdit;
    skripttimer_second: TEdit;
    mo_check: TCheckBox;
    di_check: TCheckBox;
    mi_check: TCheckBox;
    do_check: TCheckBox;
    fr_check: TCheckBox;
    sa_check: TCheckBox;
    so_check: TCheckBox;
    procedure skripttimer_filechange1Click(Sender: TObject);
    procedure Skripttimer_typechange1Change(Sender: TObject);
    procedure ClocktimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    procedure Skripttimer_date1Change(Sender: TObject);
    procedure skripttimer_hourChange(Sender: TObject);
    procedure skripttimer_active1MouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure citydropdownChange(Sender: TObject);
    procedure longitudeeditChange(Sender: TObject);
    procedure latitudeeditChange(Sender: TObject);
    procedure citydropdownDropDown(Sender: TObject);
    procedure citydropdownCloseUp(Sender: TObject);
    procedure timeoption1Click(Sender: TObject);
    procedure timeoption2Click(Sender: TObject);
    procedure timeoption3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  skripttimer_editform: Tskripttimer_editform;

implementation

{$R *.dfm}

uses
	PCDIMMER, szenenverwaltung, pcdUtils;

procedure Tskripttimer_editform.skripttimer_filechange1Click(
  Sender: TObject);
var
  SzenenData:PTreeData;
begin
  case Combobox1.ItemIndex of
    0:
    begin
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionselection:=mainform.AktuellerTimer.LoadID;
      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal=mrOK then
      begin
        if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
        SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

        mainform.AktuellerTimer.LoadID:=SzenenData^.ID;
        mainform.AktuellerTimer.Name:=mainform.GetSceneInfo2(SzenenData^.ID,'name');
        mainform.AktuellerTimer.Beschreibung:=mainform.GetSceneInfo2(SzenenData^.ID,'desc');
        skripttimer_file1.text:=mainform.AktuellerTimer.Name;
      end;
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
    end;
    1:
    begin
      // Effekt
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Effektmodus:=true;
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Caption:=_('Effektverwaltung');
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionselection:=mainform.AktuellerTimer.LoadID;
      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal=mrOK then
      begin
        if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
        SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

        mainform.AktuellerTimer.LoadID:=SzenenData^.ID;
        mainform.AktuellerTimer.Name:=mainform.GetSceneInfo2(SzenenData^.ID,'name');
        mainform.AktuellerTimer.Beschreibung:=mainform.GetSceneInfo2(SzenenData^.ID,'desc');
        skripttimer_file1.text:=mainform.AktuellerTimer.Name;
      end;
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
    end;
    2:
    begin
      if skripttimer_openfile.Execute then
      begin
        mainform.AktuellerTimer.Skriptdatei:=skripttimer_openfile.filename;
        skripttimer_file1.Text:=skripttimer_openfile.filename;
        mainform.AktuellerTimer.Name:=ExtractFileName(mainform.AktuellerTimer.Skriptdatei);
        mainform.AktuellerTimer.Beschreibung:='';
      end;
    end;
  end;
end;

procedure Tskripttimer_editform.Skripttimer_typechange1Change(
  Sender: TObject);
begin
  case Skripttimer_typechange1.ItemIndex of
  0:
    begin
      Skripttimer_date1.Enabled:=true;
    end;
  1:
    begin
      Skripttimer_date1.Enabled:=false;
    end;
  2:
    begin
      Skripttimer_date1.Enabled:=true;
    end;
  3:
    begin
      Skripttimer_date1.Enabled:=true;
    end;
  4:
    begin
      Skripttimer_date1.Enabled:=true;
    end;
  end;

  mo_check.Enabled:=(Skripttimer_typechange1.ItemIndex=1);
  di_check.Enabled:=mo_check.Enabled;
  mi_check.Enabled:=mo_check.Enabled;
  do_check.Enabled:=mo_check.Enabled;
  fr_check.Enabled:=mo_check.Enabled;
  sa_check.Enabled:=mo_check.Enabled;
  so_check.Enabled:=mo_check.Enabled;

  if timeoption1.Checked then
    mainform.AktuellerTimer.TimerTyp:=Skripttimer_typechange1.ItemIndex
  else if timeoption2.Checked then
    mainform.AktuellerTimer.TimerTyp:=Skripttimer_typechange1.ItemIndex+100
  else if timeoption3.Checked then
    mainform.AktuellerTimer.TimerTyp:=Skripttimer_typechange1.ItemIndex+200;
end;

procedure Tskripttimer_editform.ClocktimerTimer(Sender: TObject);
begin
  if skripttimer_editform.Visible then
  begin
    skripttimer_time.Caption:=TimeToStr(Time);
    skripttimer_date.Caption:=DateToStr(Date);
  end;
end;

procedure Tskripttimer_editform.FormShow(Sender: TObject);
var
  sunrise, sunset:double;
  sunrise_hour, sunrise_minute, sunset_hour, sunset_minute:integer;
  sunrise_hour_s, sunrise_minute_s, sunset_hour_s, sunset_minute_s:string;
begin
  skripttimer_time.Caption:=TimeToStr(Time);
  skripttimer_date.Caption:=DateToStr(Date);

  sunrise := CalcSunrise(mainform.Longitude, mainform.Latitude);
  sunset := CalcSunset(mainform.Longitude, mainform.Latitude);

  sunrise_hour:=trunc(sunrise);
  sunrise_minute:=floor(frac(sunrise)*60);
  sunset_hour:=trunc(sunset);
  sunset_minute:=floor(frac(sunset)*60);
  if sunset_hour<0 then sunset_hour:=0; if sunset_hour>23 then sunset_hour:=23;
  if sunset_minute<0 then sunset_minute:=0; if sunset_minute>59 then sunset_minute:=59;
  if sunrise_hour<0 then sunrise_hour:=0; if sunrise_hour>23 then sunrise_hour:=23;
  if sunrise_minute<0 then sunrise_minute:=0; if sunrise_minute>59 then sunrise_minute:=59;
  sunrise_hour_s:=inttostr(sunrise_hour);
  sunrise_minute_s:=inttostr(sunrise_minute);
  sunset_hour_s:=inttostr(sunset_hour);
  sunset_minute_s:=inttostr(sunset_minute);
  if length(sunrise_hour_s)=1 then sunrise_hour_s:='0'+sunrise_hour_s;
  if length(sunrise_minute_s)=1 then sunrise_minute_s:='0'+sunrise_minute_s;
  if length(sunset_hour_s)=1 then sunset_hour_s:='0'+sunset_hour_s;
  if length(sunset_minute_s)=1 then sunset_minute_s:='0'+sunset_minute_s;

  risingtimelbl.Caption:=sunrise_hour_s+':'+sunrise_minute_s+' / '+sunset_hour_s+':'+sunset_minute_s;
end;

procedure Tskripttimer_editform.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tskripttimer_editform.ComboBox1Change(Sender: TObject);
begin
  case Combobox1.ItemIndex of
    0:
    begin
      Label4.Caption:=_('Zu ladende Szene:');
      skripttimer_file1.Text:=mainform.AktuellerTimer.Name;
    end;
    1:
    begin
      Label4.Caption:=_('Zu ladender Effekt:');
      skripttimer_file1.Text:=mainform.AktuellerTimer.Name;
    end;
    2:
    begin
      Label4.Caption:=_('Zu ladendes Skript:');
      skripttimer_file1.Text:=mainform.AktuellerTimer.Skriptdatei;
    end;
  end;
  mainform.AktuellerTimer.LoadTyp:=Combobox1.ItemIndex;
end;

procedure Tskripttimer_editform.Skripttimer_date1Change(Sender: TObject);
begin
  mainform.AktuellerTimer.Datum:=DateToStr(Skripttimer_date1.Date);
end;

procedure Tskripttimer_editform.skripttimer_hourChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.AktuellerTimer.Uhrzeit:=(skripttimer_hour.text)+':'+(skripttimer_minute.text)+':'+(skripttimer_second.text);
end;

procedure Tskripttimer_editform.skripttimer_active1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.AktuellerTimer.Aktiviert:=skripttimer_active1.Checked;
end;

procedure Tskripttimer_editform.Button1Click(Sender: TObject);
var
  hour_s, minute_s, second_s:string;
  hour, minute:integer;
  sunset, sunrise:double;
begin
  mainform.AktuellerTimer.Aktiviert:=skripttimer_active1.Checked;

  if timeoption1.Checked then
  begin
    mainform.AktuellerTimer.TimerTyp:=Skripttimer_typechange1.ItemIndex;
    hour_s:=inttostr(strtoint(skripttimer_hour.text));
    minute_s:=inttostr(strtoint(skripttimer_minute.text));
    second_s:=inttostr(strtoint(skripttimer_second.text));
    if length(hour_s)=1 then hour_s:='0'+hour_s;
    if length(minute_s)=1 then minute_s:='0'+minute_s;
    if length(second_s)=1 then second_s:='0'+second_s;
    mainform.AktuellerTimer.Uhrzeit:=hour_s+':'+minute_s+':'+second_s;
  end else if timeoption2.Checked then
  begin
    mainform.AktuellerTimer.TimerTyp:=Skripttimer_typechange1.ItemIndex+100;
    // Sonnenaufgangszeit berechnen und eintragen
    sunrise := CalcSunrise(mainform.Longitude, mainform.Latitude);
    hour:=trunc(sunrise);
    minute:=floor(frac(sunrise)*60);
    hour_s:=inttostr(hour);
    minute_s:=inttostr(minute);
    if length(hour_s)=1 then hour_s:='0'+hour_s;
    if length(minute_s)=1 then minute_s:='0'+minute_s;
    mainform.AktuellerTimer.Uhrzeit:=hour_s+':'+minute_s+':00';
  end else if timeoption3.Checked then
  begin
    mainform.AktuellerTimer.TimerTyp:=Skripttimer_typechange1.ItemIndex+200;
    // Sonnenuntergangszeit berechnen und eintragen
    sunset := CalcSunset(mainform.Longitude, mainform.Latitude);
    hour:=trunc(sunset);
    minute:=floor(frac(sunset)*60);
    if hour<0 then hour:=0; if hour>23 then hour:=23;
    if minute<0 then minute:=0; if minute>59 then minute:=59;
    hour_s:=inttostr(hour);
    minute_s:=inttostr(minute);
    if length(hour_s)=1 then hour_s:='0'+hour_s;
    if length(minute_s)=1 then minute_s:='0'+minute_s;
    mainform.AktuellerTimer.Uhrzeit:=hour_s+':'+minute_s+':00';
  end;

  mainform.AktuellerTimer.Datum:=DateToStr(Skripttimer_date1.Date);
  mainform.AktuellerTimer.Weekday[1]:=mo_check.Checked;
  mainform.AktuellerTimer.Weekday[2]:=di_check.Checked;
  mainform.AktuellerTimer.Weekday[3]:=mi_check.Checked;
  mainform.AktuellerTimer.Weekday[4]:=do_check.Checked;
  mainform.AktuellerTimer.Weekday[5]:=fr_check.Checked;
  mainform.AktuellerTimer.Weekday[6]:=sa_check.Checked;
  mainform.AktuellerTimer.Weekday[7]:=so_check.Checked;

  mainform.AktuellerTimer.LoadTyp:=Combobox1.ItemIndex;
end;

procedure Tskripttimer_editform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tskripttimer_editform.CreateParams(var Params:TCreateParams);
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

procedure Tskripttimer_editform.citydropdownChange(Sender: TObject);
begin
  case citydropdown.ItemIndex of
    0: begin longitudeedit.Value:=52.31; latitudeedit.Value:=13.25; end;
    1: begin longitudeedit.Value:=51.5161111; latitudeedit.Value:=7.46833333; end;
    2: begin longitudeedit.Value:=50.1065358; latitudeedit.Value:=8.66231; end;
    3: begin longitudeedit.Value:=52.22; latitudeedit.Value:=9.44; end;
    4: begin longitudeedit.Value:=51.0333300; latitudeedit.Value:=9.4000000; end;
    5: begin longitudeedit.Value:=51.3667; latitudeedit.Value:=12.3833; end;
    6: begin longitudeedit.Value:=51.3167; latitudeedit.Value:=9.5; end;
    7: begin longitudeedit.Value:=50.9770800; latitudeedit.Value:=9.4864600; end;
    8: begin longitudeedit.Value:=48.81394; latitudeedit.Value:=11.343198; end;
  end;
end;

procedure Tskripttimer_editform.longitudeeditChange(Sender: TObject);
var
	LReg:TRegistry;
  sunrise, sunset:double;
  sunrise_hour, sunrise_minute, sunset_hour, sunset_minute:integer;
  sunrise_hour_s, sunrise_minute_s, sunset_hour_s, sunset_minute_s:string;
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
        LReg.WriteFloat('Longitude',longitudeedit.Value);
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  mainform.Longitude:=longitudeedit.Value;

  sunrise := CalcSunrise(longitudeedit.Value, latitudeedit.Value);
  sunset := CalcSunset(longitudeedit.Value, latitudeedit.Value);

  sunrise_hour:=trunc(sunrise);
  sunrise_minute:=floor(frac(sunrise)*60);
  sunset_hour:=trunc(sunset);
  sunset_minute:=floor(frac(sunset)*60);
  if sunset_hour<0 then sunset_hour:=0; if sunset_hour>23 then sunset_hour:=23;
  if sunset_minute<0 then sunset_minute:=0; if sunset_minute>59 then sunset_minute:=59;
  if sunrise_hour<0 then sunrise_hour:=0; if sunrise_hour>23 then sunrise_hour:=23;
  if sunrise_minute<0 then sunrise_minute:=0; if sunrise_minute>59 then sunrise_minute:=59;
  sunrise_hour_s:=inttostr(sunrise_hour);
  sunrise_minute_s:=inttostr(sunrise_minute);
  sunset_hour_s:=inttostr(sunset_hour);
  sunset_minute_s:=inttostr(sunset_minute);
  if length(sunrise_hour_s)=1 then sunrise_hour_s:='0'+sunrise_hour_s;
  if length(sunrise_minute_s)=1 then sunrise_minute_s:='0'+sunrise_minute_s;
  if length(sunset_hour_s)=1 then sunset_hour_s:='0'+sunset_hour_s;
  if length(sunset_minute_s)=1 then sunset_minute_s:='0'+sunset_minute_s;

  risingtimelbl.Caption:=sunrise_hour_s+':'+sunrise_minute_s+' / '+sunset_hour_s+':'+sunset_minute_s;
end;

procedure Tskripttimer_editform.latitudeeditChange(Sender: TObject);
var
	LReg:TRegistry;
  sunrise, sunset:double;
  sunrise_hour, sunrise_minute, sunset_hour, sunset_minute:integer;
  sunrise_hour_s, sunrise_minute_s, sunset_hour_s, sunset_minute_s:string;
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
        LReg.WriteFloat('Latitude',latitudeedit.Value);
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  mainform.Latitude:=latitudeedit.Value;

  sunrise := CalcSunrise(longitudeedit.Value, latitudeedit.Value);
  sunset := CalcSunset(longitudeedit.Value, latitudeedit.Value);

  sunrise_hour:=trunc(sunrise);
  sunrise_minute:=floor(frac(sunrise)*60);
  sunset_hour:=trunc(sunset);
  sunset_minute:=floor(frac(sunset)*60);
  if sunset_hour<0 then sunset_hour:=0; if sunset_hour>23 then sunset_hour:=23;
  if sunset_minute<0 then sunset_minute:=0; if sunset_minute>59 then sunset_minute:=59;
  if sunrise_hour<0 then sunrise_hour:=0; if sunrise_hour>23 then sunrise_hour:=23;
  if sunrise_minute<0 then sunrise_minute:=0; if sunrise_minute>59 then sunrise_minute:=59;
  sunrise_hour_s:=inttostr(sunrise_hour);
  sunrise_minute_s:=inttostr(sunrise_minute);
  sunset_hour_s:=inttostr(sunset_hour);
  sunset_minute_s:=inttostr(sunset_minute);
  if length(sunrise_hour_s)=1 then sunrise_hour_s:='0'+sunrise_hour_s;
  if length(sunrise_minute_s)=1 then sunrise_minute_s:='0'+sunrise_minute_s;
  if length(sunset_hour_s)=1 then sunset_hour_s:='0'+sunset_hour_s;
  if length(sunset_minute_s)=1 then sunset_minute_s:='0'+sunset_minute_s;

  risingtimelbl.Caption:=sunrise_hour_s+':'+sunrise_minute_s+' / '+sunset_hour_s+':'+sunset_minute_s;
end;

procedure Tskripttimer_editform.citydropdownDropDown(Sender: TObject);
begin
//  citydropdown.Width:=193;
//  citydropdown.Left:=336;
end;

procedure Tskripttimer_editform.citydropdownCloseUp(Sender: TObject);
begin
//  citydropdown.Width:=25;
//  citydropdown.Left:=504;
end;

procedure Tskripttimer_editform.timeoption1Click(Sender: TObject);
begin
  skripttimer_hour.Enabled:=true;
  skripttimer_minute.Enabled:=true;
  skripttimer_second.Enabled:=true;

  longitudeedit.Enabled:=false;
  latitudeedit.Enabled:=false;
  citydropdown.Enabled:=false;
end;

procedure Tskripttimer_editform.timeoption2Click(Sender: TObject);
var
  sunrise:double;
  hour, minute:integer;
  hour_s, minute_s:string;
begin
  skripttimer_hour.Enabled:=false;
  skripttimer_minute.Enabled:=false;
  skripttimer_second.Enabled:=false;

  longitudeedit.Enabled:=true;
  latitudeedit.Enabled:=true;
  citydropdown.Enabled:=true;

  // Sonnenaufgangszeit berechnen und eintragen
  sunrise := CalcSunrise(mainform.Longitude, mainform.Latitude);
  hour:=trunc(sunrise);
  minute:=floor(frac(sunrise)*60);
  if hour<0 then hour:=0; if hour>23 then hour:=23;
  if minute<0 then minute:=0; if minute>59 then minute:=59;
  hour_s:=inttostr(hour);
  minute_s:=inttostr(minute);
  if length(hour_s)=1 then hour_s:='0'+hour_s;
  if length(minute_s)=1 then minute_s:='0'+minute_s;
  skripttimer_hour.Text:=hour_s;
  skripttimer_minute.Text:=minute_s;
  skripttimer_second.Text:='00';
end;

procedure Tskripttimer_editform.timeoption3Click(Sender: TObject);
var
  sunset:double;
  hour, minute:integer;
  hour_s, minute_s:string;
begin
  skripttimer_hour.Enabled:=false;
  skripttimer_minute.Enabled:=false;
  skripttimer_second.Enabled:=false;

  longitudeedit.Enabled:=true;
  latitudeedit.Enabled:=true;
  citydropdown.Enabled:=true;

  // Sonnenuntergangszeit berechnen und eintragen
  sunset := CalcSunset(mainform.Longitude, mainform.Latitude);
  hour:=trunc(sunset);
  minute:=floor(frac(sunset)*60);
  if hour<0 then hour:=0; if hour>23 then hour:=23;
  if minute<0 then minute:=0; if minute>59 then minute:=59;
  hour_s:=inttostr(hour);
  minute_s:=inttostr(minute);
  if length(hour_s)=1 then hour_s:='0'+hour_s;
  if length(minute_s)=1 then minute_s:='0'+minute_s;
  skripttimer_hour.Text:=hour_s;
  skripttimer_minute.Text:=minute_s;
  skripttimer_second.Text:='00';
end;

end.

