unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, jpeg;

type
  TConfig = class(TForm)
    lptchange: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    switchvaluechange: TComboBox;
    Image1: TImage;
    XPManifest1: TXPManifest;
    prefading: TCheckBox;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Label3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Config: TConfig;

implementation

{$R *.dfm}

procedure TConfig.FormCreate(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to 100 do
    switchvaluechange.Items.Add(inttostr(100-i)+'%');
  switchvaluechange.ItemIndex:=50;  
end;

procedure TConfig.Label3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  prefading.Checked:=not prefading.Checked;
end;

end.
