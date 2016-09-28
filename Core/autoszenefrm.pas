unit autoszenefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, HSLColorPicker, ExtCtrls, JvExControls, JvColorBox,
  JvColorButton, gnugettext, pngimage, JvGradient, HSLRingPicker;

type
  Tautoszeneform = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    scenefade_timelabel: TLabel;
    scenefade_time_h: TEdit;
    scenefade_time_min: TEdit;
    scenefade_time: TEdit;
    scenefade_time_msec: TEdit;
    Label3: TLabel;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label4: TLabel;
    ScrollBar1: TScrollBar;
    Label5: TLabel;
    buttonfarbe: TJvColorButton;
    Shape1: TShape;
    Label6: TLabel;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Shape4: TShape;
    Shape2: TShape;
    HSLColorPicker1: THSLRingPicker;
    usea_checkbox: TCheckBox;
    usew_checkbox: TCheckBox;
    a_slider: TScrollBar;
    w_slider: TScrollBar;
    procedure FormShow(Sender: TObject);
    procedure scenefade_time_hChange(Sender: TObject);
    procedure scenefade_time_hKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure buttonfarbeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure HSLColorPicker1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  autoszeneform: Tautoszeneform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

function RGB2TColor(const R, G, B: Byte): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := R + G shl 8 + B shl 16;
//  Result := R or (G shl 8) or (B shl 16);
end;

procedure Tautoszeneform.FormShow(Sender: TObject);
var
  h,min,s,ms,t:integer;
begin
  Combobox1.ItemIndex:=1;

  Edit1.text:=mainform.AktuelleAutoszene.Name;
  Edit2.Text:=mainform.AktuelleAutoszene.Beschreibung;
  Combobox1.ItemIndex:=mainform.AktuelleAutoszene.accuracy;
  Scrollbar1.Position:=mainform.AktuelleAutoszene.helligkeit;
//  Shape1.Brush.Color:=RGB(mainform.AktuelleAutoszene.R,mainform.AktuelleAutoszene.G,mainform.AktuelleAutoszene.B);
  Shape1.Brush.Color:=RGB2TColor(mainform.AktuelleAutoszene.R,mainform.AktuelleAutoszene.G,mainform.AktuelleAutoszene.B);
  buttonfarbe.Color:=RGB2TColor(mainform.AktuelleAutoszene.R,mainform.AktuelleAutoszene.G,mainform.AktuelleAutoszene.B);
  HSLColorPicker1.SelectedColor:=RGB2TColor(mainform.AktuelleAutoszene.R,mainform.AktuelleAutoszene.G,mainform.AktuelleAutoszene.B);
  if mainform.AktuelleAutoszene.A>-1 then
    a_slider.position:=255-mainform.AktuelleAutoszene.A;
  if mainform.AktuelleAutoszene.W>-1 then
    w_slider.position:=255-mainform.AktuelleAutoszene.W;
  usea_checkbox.checked:=(mainform.AktuelleAutoszene.A>-1);
  usew_checkbox.checked:=(mainform.AktuelleAutoszene.W>-1);

  // Fadezeit in Dialogfeld schreiben
  t:=mainform.AktuelleAutoszene.fadetime;
  h:=t div 3600000;
  t:=t mod 3600000;
  min:=t div 60000;
  t:=t mod 60000;
  s:=t div 1000;
  t:=t mod 1000;
  ms:=t;

  scenefade_time_h.Text:=inttostr(h);
  scenefade_time_min.Text:=inttostr(min);
  scenefade_time.Text:=inttostr(s);
  scenefade_time_msec.Text:=inttostr(ms);
end;

procedure Tautoszeneform.scenefade_time_hChange(Sender: TObject);
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

procedure Tautoszeneform.scenefade_time_hKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then
    mainform.AktuelleAutoszene.fadetime:=strtoint(scenefade_time_h.Text)*60*60*1000+strtoint(scenefade_time_min.Text)*60*1000+strtoint(scenefade_time.Text)*1000+strtoint(scenefade_time_msec.Text);
end;

procedure Tautoszeneform.Button1Click(Sender: TObject);
var
  R,G,B:byte;
begin
  mainform.AktuelleAutoszene.Name:=Edit1.text;
  mainform.AktuelleAutoszene.Beschreibung:=Edit2.text;
  mainform.AktuelleAutoszene.fadetime:=strtoint(scenefade_time_h.Text)*60*60*1000+strtoint(scenefade_time_min.Text)*60*1000+strtoint(scenefade_time.Text)*1000+strtoint(scenefade_time_msec.Text);

  TColor2RGB(buttonfarbe.Color,R,G,B);
  mainform.AktuelleAutoszene.R:=R;
  mainform.AktuelleAutoszene.G:=G;
  mainform.AktuelleAutoszene.B:=B;
  if usea_checkbox.checked then
    mainform.AktuelleAutoszene.A:=255-a_slider.position
  else
    mainform.AktuelleAutoszene.A:=-1;
  if usew_checkbox.checked then
    mainform.AktuelleAutoszene.W:=255-w_slider.position
  else
    mainform.AktuelleAutoszene.W:=-1;

  mainform.AktuelleAutoszene.accuracy:=Combobox1.ItemIndex;
  mainform.AktuelleAutoszene.helligkeit:=Scrollbar1.Position;
end;

procedure Tautoszeneform.buttonfarbeChange(Sender: TObject);
begin
  if Sender=buttonfarbe then
  begin
    Shape1.Brush.Color:=buttonfarbe.Color;
    HSLColorPicker1.SelectedColor:=buttonfarbe.Color;
  end;
end;

procedure Tautoszeneform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tautoszeneform.CreateParams(var Params:TCreateParams);
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

procedure Tautoszeneform.HSLColorPicker1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    Shape1.Brush.Color:=HSLColorPicker1.SelectedColor;
    buttonfarbe.Color:=HSLColorPicker1.SelectedColor;
  end;
end;

end.
