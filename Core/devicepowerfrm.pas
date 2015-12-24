unit devicepowerfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, JvExControls, JvGradient, Mask,
  JvExMask, JvSpin, gnugettext;

type
  Tdevicepowerform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Button1: TButton;
    Shape1: TShape;
    Shape2: TShape;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    JvSpinEdit2: TJvSpinEdit;
    Button2: TButton;
    JvSpinEdit3: TJvSpinEdit;
    Label4: TLabel;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    ComboBox1: TComboBox;
    JvSpinEdit1: TJvSpinEdit;
    JvSpinEdit4: TJvSpinEdit;
    CheckBox2: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckButtons;
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    aktuellesgeraet:integer;
  end;

var
  devicepowerform: Tdevicepowerform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tdevicepowerform.FormShow(Sender: TObject);
var
  i:integer;
begin
  Checkbox1.Checked:=mainform.devices[aktuellesgeraet].UseChannelBasedPower;
  Checkbox2.Checked:=mainform.devices[aktuellesgeraet].UseFullPowerOnChannelvalue;
  JvSpinEdit1.Value:=mainform.devices[aktuellesgeraet].Power;
  JvSpinEdit2.Value:=mainform.devices[aktuellesgeraet].Phase;
  JvSpinEdit3.Value:=mainform.devices[aktuellesgeraet].ContinuousPower;
  JvSpinEdit4.Value:=mainform.devices[aktuellesgeraet].CalcPowerAboveValue;
  Combobox1.Items.Clear;
  for i:=0 to length(mainform.devices[aktuellesgeraet].kanalname)-1 do
  begin
    Combobox1.Items.Add(mainform.devices[aktuellesgeraet].kanalname[i]);
  end;
  Combobox1.ItemIndex:=0;

  CheckButtons;
end;

procedure Tdevicepowerform.Button1Click(Sender: TObject);
begin
  mainform.devices[aktuellesgeraet].UseChannelBasedPower:=Checkbox1.Checked;
  mainform.devices[aktuellesgeraet].CalcPowerAboveValue:=round(JvSpinEdit4.value);
  mainform.devices[aktuellesgeraet].Power:=round(JvSpinEdit1.Value);
  mainform.devices[aktuellesgeraet].ContinuousPower:=round(JvSpinEdit3.Value);
  mainform.devices[aktuellesgeraet].Phase:=round(JvSpinEdit2.Value);
  mainform.devices[aktuellesgeraet].ChannelForPower:=Combobox1.ItemIndex;
  mainform.devices[aktuellesgeraet].UseFullPowerOnChannelvalue:=Checkbox2.Checked;
end;

procedure Tdevicepowerform.CheckButtons;
begin
  JvSpinEdit1.Enabled:=Checkbox1.Checked;
  Combobox1.Enabled:=Checkbox1.Checked;
  JvSpinEdit4.Enabled:=Checkbox1.Checked;
  Checkbox2.Enabled:=Checkbox1.Checked;
end;

procedure Tdevicepowerform.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CheckButtons;
end;

procedure Tdevicepowerform.CheckBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CheckButtons;
end;

procedure Tdevicepowerform.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CheckButtons;
end;

procedure Tdevicepowerform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tdevicepowerform.CreateParams(var Params:TCreateParams);
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
