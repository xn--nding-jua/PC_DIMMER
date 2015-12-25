unit schedulerfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, Buttons, PngBitBtn, pngimage,
  JvExControls, JvGradient, DateUtils, PLNClock, Types, gnugettext, Math;

type
  Tschedulerform = class(TForm)
    Shape2: TShape;
    OKBtn: TButton;
    Shape1: TShape;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label1: TLabel;
    Bevel14: TBevel;
    skripttimer_add: TPngBitBtn;
    skripttimer_edit: TPngBitBtn;
    skripttimer_delete: TPngBitBtn;
    skripttimer_stop: TPngBitBtn;
    skripttimer_play: TPngBitBtn;
    skripttimer_listbox: TListBox;
    Skripttimer_timer: TTimer;
    skripttimer_popup: TPopupMenu;
    ffnen2: TMenuItem;
    Speichern3: TMenuItem;
    Lschen1: TMenuItem;
    skripttimer_time: TLabel;
    skripttimer_date: TLabel;
    PLNClock1: TPLNClock;
    skripttimer_start: TPngBitBtn;
    Bevel1: TBevel;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SkripttimerupdateTimer: TTimer;
    TimerDeaktiviertCheckbox: TCheckBox;
    Label2: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure skripttimer_listboxClick(Sender: TObject);
    procedure skripttimer_listboxDblClick(Sender: TObject);
    procedure skripttimer_listboxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure skripttimer_addClick(Sender: TObject);
    procedure skripttimer_editClick(Sender: TObject);
    procedure skripttimer_deleteClick(Sender: TObject);
    procedure skripttimer_stopClick(Sender: TObject);
    procedure skripttimer_playClick(Sender: TObject);
    procedure Skripttimer_timerTimer(Sender: TObject);
    procedure checkskripttimerbuttons();
    procedure Lschen1Click(Sender: TObject);
    procedure Speichern3Click(Sender: TObject);
    procedure ffnen2Click(Sender: TObject);
    procedure skripttimer_listboxDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure SkripttimerupdateTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure skripttimer_listboxMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TimerDeaktiviertCheckboxMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TimerDeaktiviertCheckboxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  schedulerform: Tschedulerform;

implementation

uses PCDIMMER, skripttimer_edit, pcdUtils;

{$R *.dfm}

procedure Tschedulerform.OKBtnClick(Sender: TObject);
begin
  close;
end;

procedure Tschedulerform.skripttimer_listboxClick(Sender: TObject);
begin
  checkskripttimerbuttons();
end;

procedure Tschedulerform.skripttimer_listboxDblClick(Sender: TObject);
begin
  if skripttimer_edit.Enabled then
    skripttimer_edit.Click;
end;

procedure Tschedulerform.skripttimer_listboxKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  checkskripttimerbuttons;
end;

procedure Tschedulerform.skripttimer_addClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  with mainform do
  begin
    AktuellerTimer.Aktiviert:=true;
    AktuellerTimer.Name:='';
    AktuellerTimer.Beschreibung:='';
    AktuellerTimer.TimerTyp:=0;
    AktuellerTimer.LoadTyp:=0;
    AktuellerTimer.Skriptdatei:='';

    AktuellerTimer.Datum:=DateToStr(date);
    if strtoint(copy(TimeToStr(now),0,2))<23 then
    begin
      AktuellerTimer.Uhrzeit:=inttostr(strtoint(copy(TimeToStr(now),0,2))+1)+':00:00';
      if length(AktuellerTimer.Uhrzeit)=7 then
        AktuellerTimer.Uhrzeit:='0'+AktuellerTimer.Uhrzeit;
    end else
    begin
      AktuellerTimer.Uhrzeit:='00:00:00';
      AktuellerTimer.Datum:=AktuellerTimer.Datum[1]+inttostr(strtoint(AktuellerTimer.Datum[2])+1)+copy(AktuellerTimer.Datum,3,length(AktuellerTimer.Datum));
    end;

    skripttimer_editform.timeoption1.checked:=true;
    skripttimer_editform.longitudeedit.Enabled:=false;
    skripttimer_editform.latitudeedit.Enabled:=false;
    skripttimer_editform.citydropdown.Enabled:=false;
    skripttimer_editform.skripttimer_hour.Enabled:=true;
    skripttimer_editform.skripttimer_minute.Enabled:=true;
    skripttimer_editform.skripttimer_second.Enabled:=true;
    skripttimer_editform.skripttimer_date1.Enabled:=true;

    skripttimer_editform.skripttimer_active1.Checked:=true;
    skripttimer_editform.skripttimer_file1.Text:='';
    skripttimer_editform.Skripttimer_typechange1.ItemIndex:=0;
    skripttimer_editform.ComboBox1.ItemIndex:=0;
    skripttimer_editform.Skripttimer_date1.Date:=date;
    if strtoint(copy(TimeToStr(now),0,2))<23 then
    begin
      skripttimer_editform.skripttimer_hour.Text:=inttostr(strtoint(copy(TimeToStr(now),0,2))+1);
      if length(skripttimer_editform.skripttimer_hour.Text)=1 then
        skripttimer_editform.skripttimer_hour.Text:='0'+skripttimer_editform.skripttimer_hour.Text;
    end else
      skripttimer_editform.skripttimer_hour.Text:='00';
    skripttimer_editform.skripttimer_minute.text:='00';//copy(TimeToStr(now),4,2));
    skripttimer_editform.skripttimer_second.text:='00';//copy(TimeToStr(now),7,2);
    try
      skripttimer_editform.Skripttimer_date1.Date:=StrToDate(AktuellerTimer.Datum);
    except
    end;

    if skripttimer_editform.ShowModal=mrOK then
    begin
      setlength(Ablauftimer,length(Ablauftimer)+1);
      Ablauftimer[length(Ablauftimer)-1]:=AktuellerTimer;

      case Ablauftimer[length(Ablauftimer)-1].LoadTyp of
        0..1:
        begin
          case Ablauftimer[length(Ablauftimer)-1].TimerTyp of
            0, 100, 200: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<EINMALIG>    ')+Ablauftimer[length(Ablauftimer)-1].Datum+' '+Ablauftimer[length(Ablauftimer)-1].Uhrzeit+' : '+Ablauftimer[length(Ablauftimer)-1].Name);
            1, 101, 201: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<TÄGLICH>     ')+'-          '+Ablauftimer[length(Ablauftimer)-1].Uhrzeit+' : '+Ablauftimer[length(Ablauftimer)-1].Name);
            2, 102, 202: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<WÖCHENTLICH> ')+Wochentag(StrToDate(Ablauftimer[length(Ablauftimer)-1].Datum))+'         '+Ablauftimer[length(Ablauftimer)-1].Uhrzeit+' : '+Ablauftimer[length(Ablauftimer)-1].Name);
            3, 103, 203: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<MONATLICH>   ')+_('jeden')+' '+copy(Ablauftimer[length(Ablauftimer)-1].Datum,0,2)+'.  '+Ablauftimer[length(Ablauftimer)-1].Uhrzeit+' : '+Ablauftimer[length(Ablauftimer)-1].Name);
            4, 104, 204: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<JÄHRLICH>    ')+copy(Ablauftimer[length(Ablauftimer)-1].Datum,0,6)+'     '+Ablauftimer[length(Ablauftimer)-1].Uhrzeit+' : '+Ablauftimer[length(Ablauftimer)-1].Name);
          end;
        end;
        2:
        begin
          case Ablauftimer[length(Ablauftimer)-1].TimerTyp of
            0, 100, 200: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<EINMALIG>    ')+Ablauftimer[length(Ablauftimer)-1].Datum+' '+Ablauftimer[length(Ablauftimer)-1].Uhrzeit+' : '+ExtractFileName(Ablauftimer[length(Ablauftimer)-1].Skriptdatei));
            1, 101, 201: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<TÄGLICH>     ')+'-          '+Ablauftimer[length(Ablauftimer)-1].Uhrzeit+' : '+ExtractFileName(Ablauftimer[length(Ablauftimer)-1].Skriptdatei));
            2, 102, 202: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<WÖCHENTLICH> ')+Wochentag(StrToDate(Ablauftimer[length(Ablauftimer)-1].Datum))+Ablauftimer[length(Ablauftimer)-1].Uhrzeit+' : '+ExtractFileName(Ablauftimer[length(Ablauftimer)-1].Skriptdatei));
            3, 103, 203: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<MONATLICH>   ')+_('jeden')+' '+copy(Ablauftimer[length(Ablauftimer)-1].Datum,0,2)+'.  '+Ablauftimer[length(Ablauftimer)-1].Uhrzeit+' : '+ExtractFileName(Ablauftimer[length(Ablauftimer)-1].Skriptdatei));
            4, 104, 204: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<JÄHRLICH>    ')+copy(Ablauftimer[length(Ablauftimer)-1].Datum,0,6)+'     '+Ablauftimer[length(Ablauftimer)-1].Uhrzeit+' : '+ExtractFileName(Ablauftimer[length(Ablauftimer)-1].Skriptdatei));
          end;
        end;
      end;
      skripttimer_listbox.Hint:=Ablauftimer[length(Ablauftimer)-1].Beschreibung;
    end;
    checkskripttimerbuttons();
    skripttimer_listbox.Refresh;
  end;
end;

procedure Tschedulerform.skripttimer_editClick(Sender: TObject);
var
  aktuelleposition:integer;
  TypeOfTimer:byte;
begin
  if not mainform.UserAccessGranted(1) then exit;

  with mainform do
  begin
    if skripttimer_listbox.ItemIndex>-1 then
    begin
      aktuelleposition:=skripttimer_listbox.itemindex;
      AktuellerTimer:=AblaufTimer[aktuelleposition];

      skripttimer_editform.skripttimer_active1.Checked:=AktuellerTimer.Aktiviert;

      if AktuellerTimer.TimerTyp>=200 then
      begin
        skripttimer_editform.Skripttimer_typechange1.ItemIndex:=AktuellerTimer.TimerTyp-200;
        skripttimer_editform.timeoption3.Checked:=true;
        skripttimer_editform.skripttimer_hour.Enabled:=false;
        skripttimer_editform.skripttimer_minute.Enabled:=false;
        skripttimer_editform.skripttimer_second.Enabled:=false;

        skripttimer_editform.longitudeedit.Enabled:=false;
        skripttimer_editform.latitudeedit.Enabled:=false;
        skripttimer_editform.citydropdown.Enabled:=false;
      end else if AktuellerTimer.TimerTyp>=100 then
      begin
        skripttimer_editform.Skripttimer_typechange1.ItemIndex:=AktuellerTimer.TimerTyp-100;
        skripttimer_editform.timeoption2.Checked:=true;
        skripttimer_editform.skripttimer_hour.Enabled:=false;
        skripttimer_editform.skripttimer_minute.Enabled:=false;
        skripttimer_editform.skripttimer_second.Enabled:=false;

        skripttimer_editform.longitudeedit.Enabled:=true;
        skripttimer_editform.latitudeedit.Enabled:=true;
        skripttimer_editform.citydropdown.Enabled:=true;
      end else if AktuellerTimer.TimerTyp<100 then
      begin
        skripttimer_editform.Skripttimer_typechange1.ItemIndex:=AktuellerTimer.TimerTyp;
        skripttimer_editform.timeoption1.Checked:=true;
        skripttimer_editform.skripttimer_hour.Enabled:=true;
        skripttimer_editform.skripttimer_minute.Enabled:=true;
        skripttimer_editform.skripttimer_second.Enabled:=true;

        skripttimer_editform.longitudeedit.Enabled:=true;
        skripttimer_editform.latitudeedit.Enabled:=true;
        skripttimer_editform.citydropdown.Enabled:=true;
      end;

      skripttimer_editform.Skripttimer_date1.Date:=StrtoDate(AktuellerTimer.Datum);
      skripttimer_editform.ComboBox1.ItemIndex:=AktuellerTimer.LoadTyp;
      Skripttimer_editform.ComboBox1Change(nil);
      case AktuellerTimer.LoadTyp of
        0: skripttimer_editform.skripttimer_file1.text:=AktuellerTimer.Name;
        1: skripttimer_editform.skripttimer_file1.text:=AktuellerTimer.Name;
        2: skripttimer_editform.skripttimer_file1.text:=AktuellerTimer.Skriptdatei;
      end;
                                                
      skripttimer_editform.skripttimer_hour.Text:=copy(AblaufTimer[aktuelleposition].Uhrzeit,1,2);
      skripttimer_editform.skripttimer_minute.Text:=copy(AblaufTimer[aktuelleposition].Uhrzeit,4,2);
      skripttimer_editform.skripttimer_second.Text:=copy(AblaufTimer[aktuelleposition].Uhrzeit,7,2);

      if skripttimer_editform.ShowModal=mrOK then
      begin
        Ablauftimer[aktuelleposition]:=AktuellerTimer;

        case Ablauftimer[aktuelleposition].LoadTyp of
          0..1:
          begin
            case Ablauftimer[aktuelleposition].TimerTyp of
              0, 100, 200: skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<EINMALIG>    ')+Ablauftimer[aktuelleposition].Datum+' '+Ablauftimer[aktuelleposition].Uhrzeit+' : '+Ablauftimer[aktuelleposition].Name);
              1, 101, 201: skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<TÄGLICH>     ')+'-          '+Ablauftimer[aktuelleposition].Uhrzeit+' : '+Ablauftimer[aktuelleposition].Name);
              2, 102, 202: skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<WÖCHENTLICH> ')+Wochentag(StrToDate(Ablauftimer[aktuelleposition].Datum))+'         '+Ablauftimer[aktuelleposition].Uhrzeit+' : '+Ablauftimer[aktuelleposition].Name);
              3, 103, 203: skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<MONATLICH>   ')+_('jeden')+' '+copy(Ablauftimer[aktuelleposition].Datum,0,2)+'.  '+Ablauftimer[aktuelleposition].Uhrzeit+' : '+Ablauftimer[aktuelleposition].Name);
              4, 104, 204: skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<JÄHRLICH>    ')+copy(Ablauftimer[aktuelleposition].Datum,0,6)+'     '+Ablauftimer[aktuelleposition].Uhrzeit+' : '+Ablauftimer[aktuelleposition].Name);
            end;
          end;
          2:
          begin
            case Ablauftimer[aktuelleposition].TimerTyp of
              0, 100, 200: skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<EINMALIG>    ')+Ablauftimer[aktuelleposition].Datum+' '+Ablauftimer[aktuelleposition].Uhrzeit+' : '+ExtractFileName(Ablauftimer[aktuelleposition].Skriptdatei));
              1, 101, 201: skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<TÄGLICH>     ')+'-          '+Ablauftimer[aktuelleposition].Uhrzeit+' : '+ExtractFileName(Ablauftimer[aktuelleposition].Skriptdatei));
              2, 102, 202: skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<WÖCHENTLICH> ')+Wochentag(StrToDate(Ablauftimer[aktuelleposition].Datum))+Ablauftimer[aktuelleposition].Uhrzeit+' : '+ExtractFileName(Ablauftimer[aktuelleposition].Skriptdatei));
              3, 103, 203: skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<MONATLICH>   ')+_('jeden')+' '+copy(Ablauftimer[aktuelleposition].Datum,0,2)+'.  '+Ablauftimer[aktuelleposition].Uhrzeit+' : '+ExtractFileName(Ablauftimer[aktuelleposition].Skriptdatei));
              4, 104, 204: skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<JÄHRLICH>    ')+copy(Ablauftimer[aktuelleposition].Datum,0,6)+'     '+Ablauftimer[aktuelleposition].Uhrzeit+' : '+ExtractFileName(Ablauftimer[aktuelleposition].Skriptdatei));
            end;
          end;
        end;
        skripttimer_listbox.Hint:=Ablauftimer[aktuelleposition].Beschreibung;

        TypeOfTimer:=0;
        if Ablauftimer[aktuelleposition].TimerTyp>=200 then
          TypeOfTimer:=Ablauftimer[aktuelleposition].TimerTyp-200
        else if Ablauftimer[aktuelleposition].TimerTyp>=100 then
          TypeOfTimer:=Ablauftimer[aktuelleposition].TimerTyp-100
        else if Ablauftimer[aktuelleposition].TimerTyp<100 then
          TypeOfTimer:=Ablauftimer[aktuelleposition].TimerTyp;

        //Auf Plausibilität prüfen
        skripttimer_listbox.Items.Objects[aktuelleposition]:=TObject(clBlack);

        if (((CompareTime(StrToTime(Ablauftimer[aktuelleposition].Uhrzeit), Now)=LessThanValue) and (CompareDate(StrToDate(Ablauftimer[aktuelleposition].Datum), Now)=LessThanValue)) and (TypeOfTimer=0)) then
        begin
    //      ErrorPop('Achtung! Der gerade hinzugefügte Eintrag ist bereits abgelaufen!');
          skripttimer_listbox.Items.Strings[aktuelleposition]:=(_('<ABGELAUFEN!> ')+Ablauftimer[aktuelleposition].Datum+' '+Ablauftimer[aktuelleposition].Uhrzeit+' : '+Ablauftimer[aktuelleposition].Name);
          skripttimer_listbox.Items.Objects[aktuelleposition]:=TObject(clMaroon);
        end;

        if (Ablauftimer[aktuelleposition].LoadTyp=2) and (not FileExists(Ablauftimer[aktuelleposition].Skriptdatei)) then
        begin
          ErrorPop(_('Achtung! Die Skriptdatei "')+Ablauftimer[aktuelleposition].Skriptdatei+_('" existiert nicht!'));
          skripttimer_listbox.Items.Objects[aktuelleposition]:=TObject(clMaroon);
        end;
        //Ende der Plausibilitätsprüfung
      end;
    end;
  	checkskripttimerbuttons();
  end;
  skripttimer_listbox.Refresh;
end;

procedure Tschedulerform.skripttimer_deleteClick(Sender: TObject);
var
  i,aktuelleposition:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  with mainform do
  begin
  aktuelleposition:=skripttimer_listbox.ItemIndex;
  if aktuelleposition>skripttimer_listbox.Items.count then
    for i:=aktuelleposition to length(Ablauftimer)-2 do
      AblaufTimer[i]:=AblaufTimer[i+1];
  setlength(Ablauftimer, length(Ablauftimer)-1);

  skripttimer_listbox.Items.Delete(aktuelleposition);
  checkskripttimerbuttons();
  end;
end;

procedure Tschedulerform.skripttimer_stopClick(Sender: TObject);
begin
  with mainform do
  begin
    case AblaufTimer[skripttimer_listbox.itemindex].LoadTyp of
      0: StopScene(AblaufTimer[skripttimer_listbox.itemindex].LoadID);
      1: StopEffekt(AblaufTimer[skripttimer_listbox.itemindex].LoadID);
    end;
  end;
end;

procedure Tschedulerform.skripttimer_playClick(Sender: TObject);
begin
  with mainform do
  begin
    case AblaufTimer[skripttimer_listbox.itemindex].LoadTyp of
      0: StartScene(AblaufTimer[skripttimer_listbox.itemindex].LoadID,false,false,-1);
      1: StartEffekt(AblaufTimer[skripttimer_listbox.itemindex].LoadID);
    end;
  end;
end;

procedure Tschedulerform.Skripttimer_timerTimer(Sender: TObject);
var
  i:integer;
  TypeOfTimer:byte;
  hour, minute:integer;
  hour_s, minute_s:string;
  sunset, sunrise:double;
begin
  with mainform do
  begin
    skripttimer_todo:=0;
    for i:=0 to length(AblaufTimer)-1 do
    begin
      TypeOfTimer:=0;
      if AblaufTimer[i].TimerTyp>=200 then
      begin
        TypeOfTimer:=AblaufTimer[i].TimerTyp-200;

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
        AblaufTimer[i].Uhrzeit:=hour_s+':'+minute_s+':00';
      end else if AblaufTimer[i].TimerTyp>=100 then
      begin
        TypeOfTimer:=AblaufTimer[i].TimerTyp-100;

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
        AblaufTimer[i].Uhrzeit:=hour_s+':'+minute_s+':00';
      end else if AblaufTimer[i].TimerTyp<100 then
      begin
        TypeOfTimer:=AblaufTimer[i].TimerTyp;
      end;

      //Auf Plausibilität prüfen
      skripttimer_listbox.Items.Objects[i]:=TObject(clBlack);

      if ((TypeOfTimer=0) and (((CompareTime(StrToTime(AblaufTimer[i].Uhrzeit), Now)=LessThanValue) and (CompareDate(StrToDate(AblaufTimer[i].Datum), Now)=LessThanValue)) or ((CompareTime(StrToTime(AblaufTimer[i].Uhrzeit), Now)=LessThanValue) and (CompareDate(StrToDate(AblaufTimer[i].Datum), Now)=0)))) then
      begin
        skripttimer_listbox.Items.Strings[i]:=(_('<ABGELAUFEN!> ')+Ablauftimer[i].Datum+' '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
        skripttimer_listbox.Items.Objects[i]:=TObject(clMaroon);
      end else
  	  begin
        skripttimer_todo:=skripttimer_todo+1;
      end;

      if (AblaufTimer[i].LoadTyp=2) and (not FileExists(AblaufTimer[i].Skriptdatei)) then
      begin
        ErrorPop(_('Achtung! Die Skriptdatei "')+AblaufTimer[i].Skriptdatei+_('" existiert nicht!'));
        skripttimer_listbox.Items.Objects[i]:=TObject(clMaroon);
      end;
      //Ende der Plausibilitätsprüfung
    end;
  end;

  if mainform.skripttimer_offline then exit;

  with mainform do
  begin
    for i:=0 to length(AblaufTimer)-1 do
    begin
      if AblaufTimer[i].Aktiviert then
      begin
        TypeOfTimer:=0;
        if AblaufTimer[i].TimerTyp>=200 then
          TypeOfTimer:=AblaufTimer[i].TimerTyp-200
        else if AblaufTimer[i].TimerTyp>=100 then
          TypeOfTimer:=AblaufTimer[i].TimerTyp-100
        else if AblaufTimer[i].TimerTyp<100 then
          TypeOfTimer:=AblaufTimer[i].TimerTyp;

        case TypeOfTimer of
        0: // Einmalig: Tag, Monat und Jahr müssen passen
          begin
            if (AblaufTimer[i].Datum=DateToStr(date)) and (AblaufTimer[i].Uhrzeit=TimeToStr(time)) then
            begin
              dxRibbonStatusBar1.Panels[5].Text:=_('Scheduler: Ausgeführt');
      //	      skripttimer_listbox.Items.Objects[i]:=TObject(clGreen);

              case AblaufTimer[i].LoadTyp of
                0:
                begin
                  StartScene(AblaufTimer[i].LoadID,false,false,-1);
                end;
                1:
                begin
                  StartEffekt(AblaufTimer[i].LoadID);
                end;
              end;

      //				skripttimer_todo:=skripttimer_todo-1;
            end;
          end;
        1: // Täglich: Datum wird ignoriert
          begin
            if (AblaufTimer[i].Uhrzeit=TimeToStr(time)) then
            begin
              dxRibbonStatusBar1.Panels[5].Text:=_('Scheduler: Ausgeführt');
    //	      skripttimer_listbox.Items.Objects[i]:=TObject(clGreen);

            case AblaufTimer[i].LoadTyp of
              0:
              begin
                StartScene(AblaufTimer[i].LoadID,false,false,-1);
              end;
              1:
              begin
                StartEffekt(AblaufTimer[i].LoadID);
              end;
            end;

    //				skripttimer_todo:=skripttimer_todo-1;
            end;
          end;
        2: // Wöchentlich: Wochentag muss passen
          begin
            if (DayOfTheWeek(StrToDate(AblaufTimer[i].Datum))=DayOfTheWeek(date)) and (AblaufTimer[i].Uhrzeit=TimeToStr(time)) then
            begin
              dxRibbonStatusBar1.Panels[5].Text:=_('Scheduler: Ausgeführt');
    //	      skripttimer_listbox.Items.Objects[i]:=TObject(clGreen);

            case AblaufTimer[i].LoadTyp of
              0:
              begin
                StartScene(AblaufTimer[i].LoadID,false,false,-1);
              end;
              1:
              begin
                StartEffekt(AblaufTimer[i].LoadID);
              end;
            end;

    //				skripttimer_todo:=skripttimer_todo-1;
            end;
          end;
        3: // Monatlich: Tag muss passen
          begin
            if (copy(AblaufTimer[i].Datum,0,2)=copy(DateToStr(date),0,2)) and (AblaufTimer[i].Uhrzeit=TimeToStr(time)) then
            begin
              dxRibbonStatusBar1.Panels[5].Text:=_('Scheduler: Ausgeführt');
    //	      skripttimer_listbox.Items.Objects[i]:=TObject(clGreen);

            case AblaufTimer[i].LoadTyp of
              0:
              begin
                StartScene(AblaufTimer[i].LoadID,false,false,-1);
              end;
              1:
              begin
                StartEffekt(AblaufTimer[i].LoadID);
              end;
            end;

    //				skripttimer_todo:=skripttimer_todo-1;
            end;
          end;
        4: // Jährlich: Tag und Monat müssen passen
          begin
            if (copy(AblaufTimer[i].Datum,0,2)=copy(DateToStr(date),0,2)) and (copy(AblaufTimer[i].Datum,4,2)=copy(DateToStr(date),4,2)) and (AblaufTimer[i].Uhrzeit=TimeToStr(time)) then
            begin
              dxRibbonStatusBar1.Panels[5].Text:=_('Scheduler: Ausgeführt');
    //	      skripttimer_listbox.Items.Objects[i]:=TObject(clGreen);

            case AblaufTimer[i].LoadTyp of
              0:
              begin
                StartScene(AblaufTimer[i].LoadID,false,false,-1);
              end;
              1:
              begin
                StartEffekt(AblaufTimer[i].LoadID);
              end;
            end;

    //				skripttimer_todo:=skripttimer_todo-1;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure Tschedulerform.checkskripttimerbuttons();
begin
  if skripttimer_listbox.Items.Count>0 then
  begin
    skripttimer_start.Enabled:=true;
    skripttimer_listbox.Hint:=mainform.AblaufTimer[skripttimer_listbox.itemindex].Beschreibung;
  end else
  begin
    skripttimer_start.Enabled:=false;
  end;

  skripttimer_add.Enabled:=true;
  skripttimer_edit.enabled:=skripttimer_listbox.itemindex>-1;
  skripttimer_stop.Enabled:=skripttimer_listbox.Itemindex>-1;
  skripttimer_play.Enabled:=skripttimer_listbox.Itemindex>-1;
  skripttimer_delete.Enabled:=skripttimer_listbox.ItemIndex>-1;

  skripttimer_listbox.Refresh;
end;

procedure Tschedulerform.Lschen1Click(Sender: TObject);
begin
if messagedlg(_('Aktuelle Timereinstellungen löschen?'),mtWarning,
  [mbYes,mbNo],0)=mrYes then
  begin
    schedulerform.skripttimer_listbox.Clear;
    schedulerform.checkskripttimerbuttons();
  end;
end;

procedure Tschedulerform.Speichern3Click(Sender: TObject);
var
  i, Count:integer;
begin
  mainform.savedialog.Title:=_('PC_DIMMER Skripttimerliste speichern...');
  mainform.savedialog.Filter:=_('PC_DIMMER Skripttimerliste (*.pcdstmr)|*.pcdstmr|*.*|*.*');
  mainform.savedialog.FileName:='';
  mainform.savedialog.DefaultExt:='*.pcdstmr';
  if mainform.savedialog.execute then
  begin
    mainform.Filestream.Create(mainform.savedialog.FileName,fmCreate);
    Count:=length(mainform.AblaufTimer);
		mainform.Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to Count-1 do
  	begin
    	mainform.Filestream.WriteBuffer(mainform.AblaufTimer[i],sizeof(mainform.AblaufTimer[i]));
    end;
    mainform.Filestream.Free;
//    skripttimer_listbox.Items.SaveToFile(savedialog.FileName);
  end;
end;

procedure Tschedulerform.ffnen2Click(Sender: TObject);
var
  i, Count:integer;
begin
  with mainform do
  begin
  opendialog.Title:=_('PC_DIMMER Skripttimerliste öffnen...');
  opendialog.Filter:=_('PC_DIMMER Skripttimerliste (*.pcdstmr)|*.pcdstmr|*.*|*.*');
  opendialog.FileName:='';
  opendialog.DefaultExt:='*.pcdstmr';
  if project_folder<>'' then opendialog.InitialDir:=project_folder;
  if opendialog.execute then
  begin
//    skripttimer_listbox.Items.LoadFromFile(opendialog.FileName);
    Filestream.Create(opendialog.FileName,fmOpenRead);
		Filestream.ReadBuffer(Count,sizeof(Count));
    setlength(AblaufTimer,Count);
    for i:=0 to Count-1 do
  		Filestream.ReadBuffer(AblaufTimer[i],sizeof(AblaufTimer[i]));
    Filestream.Free;
    skripttimer_listbox.Clear;
    for i:=0 to Count-1 do
    begin
      case Ablauftimer[i].LoadTyp of
        0..1:
        begin
          case Ablauftimer[i].TimerTyp of
            0, 100, 200: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<EINMALIG>    ')+Ablauftimer[i].Datum+' '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
            1, 101, 201: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<TÄGLICH>     ')+'-          '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
            2, 102, 202: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<WÖCHENTLICH> ')+Wochentag(StrToDate(Ablauftimer[i].Datum))+'         '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
            3, 103, 203: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<MONATLICH>   ')+_('jeden')+' '+copy(Ablauftimer[i].Datum,0,2)+'.  '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
            4, 104, 204: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<JÄHRLICH>    ')+copy(Ablauftimer[i].Datum,0,6)+'     '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
          end;
        end;
        2:
        begin
          case Ablauftimer[i].TimerTyp of
            0, 100, 200: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<EINMALIG>    ')+Ablauftimer[i].Datum+' '+Ablauftimer[i].Uhrzeit+' : '+ExtractFileName(Ablauftimer[i].Skriptdatei));
            1, 101, 201: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<TÄGLICH>     ')+'-          '+Ablauftimer[i].Uhrzeit+' : '+ExtractFileName(Ablauftimer[i].Skriptdatei));
            2, 102, 202: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<WÖCHENTLICH> ')+Wochentag(StrToDate(Ablauftimer[i].Datum))+'         '+Ablauftimer[i].Uhrzeit+' : '+ExtractFileName(Ablauftimer[i].Skriptdatei));
            3, 103, 203: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<MONATLICH>   ')+_('jeden')+' '+copy(Ablauftimer[i].Datum,0,2)+'.  '+Ablauftimer[i].Uhrzeit+' : '+ExtractFileName(Ablauftimer[i].Skriptdatei));
            4, 104, 204: skripttimer_listbox.ItemIndex:=skripttimer_listbox.Items.Add(_('<JÄHRLICH>    ')+copy(Ablauftimer[i].Datum,0,6)+'     '+Ablauftimer[i].Uhrzeit+' : '+ExtractFileName(Ablauftimer[i].Skriptdatei));
          end;
        end;
      end;
    end;
    checkskripttimerbuttons();
  end;
  end;
end;

procedure Tschedulerform.skripttimer_listboxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  skripttimer_listbox.Canvas.Brush.Color := clBtnFace;
  skripttimer_listbox.Canvas.FillRect(Rect);
  skripttimer_listbox.Canvas.Font.Color:=TColor(skripttimer_listbox.Items.Objects[Index]);
  skripttimer_listbox.Canvas.TextOut(Rect.Left+1, Rect.Top, skripttimer_listbox.Items[Index]);
end;

procedure Tschedulerform.SkripttimerupdateTimerTimer(Sender: TObject);
var
  i:integer;
begin
  with mainform do
  begin
    for i:=0 to length(Ablauftimer)-1 do
    begin
      case Ablauftimer[i].LoadTyp of
        0..1:
        begin
          case Ablauftimer[i].TimerTyp of
            0, 100, 200: skripttimer_listbox.Items.Strings[i]:=(_('<EINMALIG>    ')+Ablauftimer[i].Datum+' '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
            1, 101, 201: skripttimer_listbox.Items.Strings[i]:=(_('<TÄGLICH>     ')+'-          '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
            2, 102, 202: skripttimer_listbox.Items.Strings[i]:=(_('<WÖCHENTLICH> ')+Wochentag(StrToDate(Ablauftimer[i].Datum))+'         '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
            3, 103, 203: skripttimer_listbox.Items.Strings[i]:=(_('<MONATLICH>   ')+_('jeden')+' '+copy(Ablauftimer[i].Datum,0,2)+'.  '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
            4, 104, 204: skripttimer_listbox.Items.Strings[i]:=(_('<JÄHRLICH>    ')+copy(Ablauftimer[i].Datum,0,6)+'     '+Ablauftimer[i].Uhrzeit+' : '+Ablauftimer[i].Name);
          end;
        end;
        2:
        begin
          case Ablauftimer[i].TimerTyp of
            0, 100, 200: skripttimer_listbox.Items.Strings[i]:=(_('<EINMALIG>    ')+Ablauftimer[i].Datum+' '+Ablauftimer[i].Uhrzeit+' : '+ExtractFileName(Ablauftimer[i].Skriptdatei));
            1, 101, 201: skripttimer_listbox.Items.Strings[i]:=(_('<TÄGLICH>     ')+'-          '+Ablauftimer[i].Uhrzeit+' : '+ExtractFileName(Ablauftimer[i].Skriptdatei));
            2, 102, 202: skripttimer_listbox.Items.Strings[i]:=(_('<WÖCHENTLICH> ')+Wochentag(StrToDate(Ablauftimer[i].Datum))+'         '+Ablauftimer[i].Uhrzeit+' : '+ExtractFileName(Ablauftimer[i].Skriptdatei));
            3, 103, 203: skripttimer_listbox.Items.Strings[i]:=(_('<MONATLICH>   ')+_('jeden')+' '+copy(Ablauftimer[i].Datum,0,2)+'.  '+Ablauftimer[i].Uhrzeit+' : '+ExtractFileName(Ablauftimer[i].Skriptdatei));
            4, 104, 204: skripttimer_listbox.Items.Strings[i]:=(_('<JÄHRLICH>    ')+copy(Ablauftimer[i].Datum,0,6)+'     '+Ablauftimer[i].Uhrzeit+' : '+ExtractFileName(Ablauftimer[i].Skriptdatei));
          end;
        end;
      end;
    end;
  end;
  
  skripttimer_listbox.Refresh;
end;

procedure Tschedulerform.FormShow(Sender: TObject);
begin
  if skripttimer_editform=nil then
    skripttimer_editform:=Tskripttimer_editform.Create(skripttimer_editform);

  SkripttimerupdateTimer.enabled:=true;
end;

procedure Tschedulerform.FormHide(Sender: TObject);
begin
  SkripttimerupdateTimer.enabled:=false;
end;

procedure Tschedulerform.skripttimer_listboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  checkskripttimerbuttons;
end;

procedure Tschedulerform.TimerDeaktiviertCheckboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.skripttimer_offline:=TimerDeaktiviertCheckbox.checked;
end;

procedure Tschedulerform.TimerDeaktiviertCheckboxKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  mainform.skripttimer_offline:=TimerDeaktiviertCheckbox.checked;
end;

procedure Tschedulerform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tschedulerform.CreateParams(var Params:TCreateParams);
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

end.
