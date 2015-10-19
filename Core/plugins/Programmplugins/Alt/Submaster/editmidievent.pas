unit editmidievent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Teditmidieventfrm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    okbtn: TButton;
    cancelbtn: TButton;
    typ: TComboBox;
    typcaption: TLabel;
    wert1caption: TLabel;
    wert2caption: TLabel;
    wert1: TEdit;
    wert2: TEdit;
    data1chk: TRadioButton;
    data2chk: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    recordmidi: TCheckBox;
    message1a: TLabel;
    message1b: TLabel;
    data1a: TLabel;
    data1b: TLabel;
    data2a: TLabel;
    data2b: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    procedure typChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  editmidieventfrm: Teditmidieventfrm;

implementation

{$R *.dfm}

procedure Teditmidieventfrm.typChange(Sender: TObject);
begin
	case typ.ItemIndex of
		0: // Submasterregler (Dynamisch)
		begin
			wert1.visible:=true;
			wert1caption.caption:=_('Kanal:');
			wert1caption.visible:=true;
			wert2.visible:=false;
			wert2caption.visible:=false;
		end;
		1: // Submasterregler
		begin
			wert1.visible:=true;
			wert1caption.caption:=_('Kanal:');
			wert1caption.visible:=true;
			wert2.visible:=true;
			wert2caption.caption:=_('Endwert:');
			wert2caption.visible:=true;
		end;
	end;
end;

end.
