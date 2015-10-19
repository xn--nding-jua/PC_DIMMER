unit videoscreensynchronisierenfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gnugettext;

type
  Tvideoscreensynchronisierenform = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    CheckBox2: TCheckBox;
    Edit2: TEdit;
    Button2: TButton;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    CheckBox3: TCheckBox;
    Edit3: TEdit;
    Button3: TButton;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    CheckBox4: TCheckBox;
    Edit4: TEdit;
    Button4: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure ValueRefresh;
  end;

var
  videoscreensynchronisierenform: Tvideoscreensynchronisierenform;

implementation

uses PCDIMMER, audioeffektplayerfrm, videoscreenfrm;

{$R *.dfm}

procedure Tvideoscreensynchronisierenform.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.Effektaudiodatei_record.videoseeking[1].enabled:=CheckBox1.Checked;
end;

procedure Tvideoscreensynchronisierenform.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.Effektaudiodatei_record.videoseeking[2].enabled:=CheckBox2.Checked;
end;

procedure Tvideoscreensynchronisierenform.CheckBox3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.Effektaudiodatei_record.videoseeking[3].enabled:=CheckBox3.Checked;
end;

procedure Tvideoscreensynchronisierenform.CheckBox4MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.Effektaudiodatei_record.videoseeking[4].enabled:=CheckBox4.Checked;
end;

procedure Tvideoscreensynchronisierenform.Button1Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[1].starttime:=audioeffektplayerform.GetPositionInMilliseconds;
  label5.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[1].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button2Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[2].starttime:=audioeffektplayerform.GetPositionInMilliseconds;
  label6.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[2].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button3Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[3].starttime:=audioeffektplayerform.GetPositionInMilliseconds;
  label7.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[3].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button4Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[4].starttime:=audioeffektplayerform.GetPositionInMilliseconds;
  label8.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[4].starttime);
end;

procedure Tvideoscreensynchronisierenform.Edit1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then
  begin
    mainform.Effektaudiodatei_record.videoseeking[1].starttime:=strtoint(edit1.Text);
    label5.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[1].starttime);
  end;
end;

procedure Tvideoscreensynchronisierenform.Edit2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then
  begin
    mainform.Effektaudiodatei_record.videoseeking[2].starttime:=strtoint(edit2.Text);
    label6.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[2].starttime);
  end;
end;

procedure Tvideoscreensynchronisierenform.Edit3KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then
  begin
    mainform.Effektaudiodatei_record.videoseeking[3].starttime:=strtoint(edit3.Text);
    label7.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[3].starttime);
  end;
end;

procedure Tvideoscreensynchronisierenform.Edit4KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then
  begin
    mainform.Effektaudiodatei_record.videoseeking[4].starttime:=strtoint(edit4.Text);
    label8.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[4].starttime);
  end;
end;

procedure Tvideoscreensynchronisierenform.Button5Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[1].starttime:=mainform.Effektaudiodatei_record.videoseeking[1].starttime-1;
  label5.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[1].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button6Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[1].starttime:=mainform.Effektaudiodatei_record.videoseeking[1].starttime+1;
  label5.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[1].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button8Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[2].starttime:=mainform.Effektaudiodatei_record.videoseeking[2].starttime-1;
  label6.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[2].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button10Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[2].starttime:=mainform.Effektaudiodatei_record.videoseeking[2].starttime-1;
  label6.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[2].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button11Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[3].starttime:=mainform.Effektaudiodatei_record.videoseeking[3].starttime-1;
  label7.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[3].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button13Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[3].starttime:=mainform.Effektaudiodatei_record.videoseeking[3].starttime-1;
  label7.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[3].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button14Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[4].starttime:=mainform.Effektaudiodatei_record.videoseeking[4].starttime-1;
  label8.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[4].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button16Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[4].starttime:=mainform.Effektaudiodatei_record.videoseeking[4].starttime-1;
  label8.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[4].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button7Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[1].starttime:=audioeffektplayerform.GetPositionInMilliseconds-videoscreenform.GetPositionInMilliseconds(1);
  label5.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[1].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button9Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[2].starttime:=audioeffektplayerform.GetPositionInMilliseconds-videoscreenform.GetPositionInMilliseconds(2);
  label6.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[2].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button12Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[3].starttime:=audioeffektplayerform.GetPositionInMilliseconds-videoscreenform.GetPositionInMilliseconds(3);
  label7.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[3].starttime);
end;

procedure Tvideoscreensynchronisierenform.Button15Click(Sender: TObject);
begin
  mainform.Effektaudiodatei_record.videoseeking[4].starttime:=audioeffektplayerform.GetPositionInMilliseconds-videoscreenform.GetPositionInMilliseconds(4);
  label8.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[4].starttime);
end;

procedure Tvideoscreensynchronisierenform.FormShow(Sender: TObject);
begin
  ValueRefresh;
end;

procedure Tvideoscreensynchronisierenform.ValueRefresh;
begin
  label5.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[1].starttime);
  label6.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[2].starttime);
  label7.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[3].starttime);
  label8.caption:=mainform.MillisecondsToTime(mainform.Effektaudiodatei_record.videoseeking[4].starttime);
  Edit1.Text:=inttostr(mainform.Effektaudiodatei_record.videoseeking[1].starttime);
  Edit2.Text:=inttostr(mainform.Effektaudiodatei_record.videoseeking[2].starttime);
  Edit3.Text:=inttostr(mainform.Effektaudiodatei_record.videoseeking[3].starttime);
  Edit4.Text:=inttostr(mainform.Effektaudiodatei_record.videoseeking[4].starttime);
  Checkbox1.Checked:=mainform.Effektaudiodatei_record.videoseeking[1].enabled;
  Checkbox2.Checked:=mainform.Effektaudiodatei_record.videoseeking[2].enabled;
  Checkbox3.Checked:=mainform.Effektaudiodatei_record.videoseeking[3].enabled;
  Checkbox4.Checked:=mainform.Effektaudiodatei_record.videoseeking[4].enabled;
end;

procedure Tvideoscreensynchronisierenform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tvideoscreensynchronisierenform.CreateParams(var Params:TCreateParams);
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
