unit setup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvSpin, CPDrv, gnugettext;

type
  Tsetupform = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    baudratechange: TComboBox;
    portchange: TComboBox;
    Button1: TButton;
    Button2: TButton;
    CheckBox2: TCheckBox;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label9: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    datainchtemp: TJvSpinEdit;
    datainchon: TJvSpinEdit;
    TempFaktor: TJvSpinEdit;
    datainchmin: TJvSpinEdit;
    datainchmean: TJvSpinEdit;
    datainchmax: TJvSpinEdit;
    GroupBox5: TGroupBox;
    Label28: TLabel;
    Label30: TLabel;
    temp2_msb: TJvSpinEdit;
    temp2_lsb: TJvSpinEdit;
    Button3: TButton;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    temp3_msb: TJvSpinEdit;
    temp3_lsb: TJvSpinEdit;
    GroupBox3: TGroupBox;
    savefilestoedit: TEdit;
    Label10: TLabel;
    GroupBox4: TGroupBox;
    Label11: TLabel;
    MaxInstalledPowerEdit: TJvSpinEdit;
    Label12: TLabel;
    Label14: TLabel;
    PricePerkWhEdit: TJvSpinEdit;
    Label15: TLabel;
    Label16: TLabel;
    TimeForDeltaTEdit: TJvSpinEdit;
    Label17: TLabel;
    Temp2LabelEdit: TEdit;
    Temp3LabelEdit: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  setupform: Tsetupform;

implementation

uses configfrm;

{$R *.dfm}

procedure Tsetupform.Button1Click(Sender: TObject);
var
  i, TestHandle:integer;
begin
  if config.comport.Connected then
  	Config.comport.Disconnect;

	portchange.Clear;
	for i:=1 to 16 do
	begin
	  TestHandle := CreateFile(PChar('\\.\COM'+IntToStr(i)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,LongInt(0));
	  if (TestHandle > 0) then
	  begin
	    portchange.Items.Add('COM'+inttostr(i));
	    CloseHandle(TestHandle);
	  end;
	end;

  portchange.Visible:=portchange.Items.count>0;
end;

procedure Tsetupform.Button2Click(Sender: TObject);
begin
  ShowMessage(_('Es wird folgendes RS232-Protokoll für den Messwert verwendet:')+#13#10+#13#10+
              _('ALHE (bzw. AHLE bei aktiviertem "Vertausche L/H")')+#13#10+#13#10+
              _('A und E sind einfache ASCII-Zeichen')+#13#10+
              _('L und H sind entsprechend Low- und High-Byte des Temperaturwertes.')+#13#10+#13#10+
              _('Es wird im Programm folgende Formel für die Umrechnung verwendet:')+#13#10+
              '((WORD/2047)*200)-50');
end;

procedure Tsetupform.FormShow(Sender: TObject);
var
  i:integer;
  temp:string;
begin
  try
    portchange.ItemIndex:=0;
    for i:=0 to portchange.items.count-1 do
    begin
      temp:=copy(portchange.Items[i],4,2);
      if temp[2]=' ' then
      begin
        // einstellig
        if config.comportnumber=strtoint(temp[1]) then
        begin
          portchange.ItemIndex:=i;
          break;
        end;
      end else
      begin
        // zweistellig
        if config.comportnumber=strtoint(temp) then
        begin
          portchange.ItemIndex:=i;
          break;
        end;
      end;
    end;

    case config.baudrate of
      115200: baudratechange.ItemIndex:=0;
      57600: baudratechange.ItemIndex:=1;
      38400: baudratechange.ItemIndex:=2;
      19200: baudratechange.ItemIndex:=3;
      9600: baudratechange.ItemIndex:=4;
    else
      baudratechange.ItemIndex:=0;
    end;
  except
  end;
end;

end.
