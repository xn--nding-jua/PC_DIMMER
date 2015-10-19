unit arbeitsbereichfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, gnugettext;

type
  Tarbeitsbereichform = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  arbeitsbereichform: Tarbeitsbereichform;

implementation

{$R *.dfm}

procedure Tarbeitsbereichform.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return then
    modalresult:=mrOK;
end;

procedure Tarbeitsbereichform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

end.
