unit audioeffektplayerstretchfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvSpin, gnugettext, ExtCtrls;

type
  Taudioeffektplayerstretchform = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    percent_edit: TJvSpinEdit;
    Label1: TLabel;
    h_edit: TJvSpinEdit;
    m_edit: TJvSpinEdit;
    s_edit: TJvSpinEdit;
    ms_edit: TJvSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Shape4: TShape;
    Shape1: TShape;
    procedure FormShow(Sender: TObject);
    procedure FillTimeEdit(Time: Cardinal);
    procedure percent_editKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure percent_editMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure h_editKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure h_editMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    OldLength:Cardinal;
    Factor:Extended;
  end;

var
  audioeffektplayerstretchform: Taudioeffektplayerstretchform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Taudioeffektplayerstretchform.FillTimeEdit(Time: Cardinal);
var
  t,h,m,s,ms:integer;
begin
  t:=Time;
  h:=t div 3600000;
  t:=t mod 3600000;
  m:=t div 60000;
  t:=t mod 60000;
  s:=t div 1000;
  t:=t mod 1000;
  ms:=t;

  h_edit.Value:=h;
  m_edit.Value:=m;
  s_edit.Value:=s;
  ms_edit.Value:=ms;
end;

procedure Taudioeffektplayerstretchform.FormShow(Sender: TObject);
begin
  label4.caption:=mainform.MillisecondsToTimeShort(OldLength);

  FillTimeEdit(OldLength);

  percent_edit.Value:=100.000;
end;

procedure Taudioeffektplayerstretchform.percent_editKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  newlength:Cardinal;
begin
  Factor:=100/percent_edit.Value;

  newlength:=round(OldLength*Factor);
  FillTimeEdit(newlength);
end;

procedure Taudioeffektplayerstretchform.percent_editMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  key:word;
begin
  percent_editKeyUp(nil, key, []);
end;

procedure Taudioeffektplayerstretchform.h_editKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  newlength:cardinal;
begin
  newlength:=3600000*round(h_edit.value);
  newlength:=newlength+60000*round(m_edit.value);
  newlength:=newlength+1000*round(s_edit.value);
  newlength:=newlength+round(ms_edit.value);

  factor:=(newlength/oldlength);
  percent_edit.Value:=factor*100;
end;

procedure Taudioeffektplayerstretchform.h_editMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  key:word;
begin
  h_editKeyUp(nil, key, []);
end;

procedure Taudioeffektplayerstretchform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Taudioeffektplayerstretchform.CreateParams(var Params:TCreateParams);
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
