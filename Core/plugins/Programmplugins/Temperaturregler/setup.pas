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
    Label5: TLabel;
    statuslabel: TLabel;
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
    procedure portchangeSelect(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure baudratechangeSelect(Sender: TObject);
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
end;

procedure Tsetupform.portchangeSelect(Sender: TObject);
var
  temp:string;
begin
  with config do
  begin
    if (portchange.Items.Count>0) and (portchange.itemindex>-1) then
    begin
      temp:=copy(portchange.Items[portchange.Itemindex],4,2);
      if temp[2]=' ' then
        comportnumber:=strtoint(temp[1])
      else
        comportnumber:=strtoint(temp);

      if comport.Connected then
        comport.Disconnect;
      case comportnumber of
        1: comport.port:=pnCOM1;   2: comport.port:=pnCOM2;
        3: comport.port:=pnCOM3;   4: comport.port:=pnCOM4;
        5: comport.port:=pnCOM5;   6: comport.port:=pnCOM6;
        7: comport.port:=pnCOM7;   8: comport.port:=pnCOM8;
        9: comport.port:=pnCOM9;   10: comport.port:=pnCOM10;
        11: comport.port:=pnCOM11;   12: comport.port:=pnCOM12;
        13: comport.port:=pnCOM13;   14: comport.port:=pnCOM14;
        15: comport.port:=pnCOM15;   16: comport.port:=pnCOM16;
      end;
      comport.Connect;
    end;

    if comport.Connected then
    begin
      statuslabel.Caption:=_('Verbunden mit COM')+inttostr(comportnumber)+' @ '+inttostr(baudrate);
      statuslabel.Font.Color:=clGreen;
    end else
    begin
      statuslabel.Caption:=_('Nicht verbunden...');
      statuslabel.Font.Color:=clRed;
    end;
  end;
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

procedure Tsetupform.baudratechangeSelect(Sender: TObject);
begin
  with config do
  begin
    baudrate:=strtoint(baudratechange.Items[baudratechange.Itemindex]);

    if comport.Connected then
      comport.Disconnect;
    comport.BaudRateValue:=baudrate;
    comport.Connect;

    if comport.Connected then
    begin
      statuslabel.Caption:=_('Verbunden mit COM')+inttostr(comportnumber)+' @ '+inttostr(baudrate);
      statuslabel.Font.Color:=clGreen;
    end else
    begin
      statuslabel.Caption:=_('Nicht verbunden...');
      statuslabel.Font.Color:=clRed;
    end;
  end;
end;

end.
