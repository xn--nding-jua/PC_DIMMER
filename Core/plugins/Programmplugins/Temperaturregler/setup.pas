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
    Button3: TButton;
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
    autoconnectcheckbox: TCheckBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    ch1_src: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ch1_msb: TJvSpinEdit;
    ch1_lsb: TJvSpinEdit;
    ch1_url: TEdit;
    ch1_usr: TEdit;
    ch1_pwd: TEdit;
    ch1_start: TEdit;
    ch1_stop: TEdit;
    Label8: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label26: TLabel;
    ch2_src: TComboBox;
    ch2_msb: TJvSpinEdit;
    ch2_lsb: TJvSpinEdit;
    ch2_url: TEdit;
    ch2_usr: TEdit;
    ch2_pwd: TEdit;
    ch2_start: TEdit;
    ch2_stop: TEdit;
    Label27: TLabel;
    ch3_src: TComboBox;
    ch3_msb: TJvSpinEdit;
    ch3_lsb: TJvSpinEdit;
    ch3_url: TEdit;
    ch3_usr: TEdit;
    ch3_pwd: TEdit;
    ch3_start: TEdit;
    ch3_stop: TEdit;
    Label28: TLabel;
    ch4_src: TComboBox;
    ch4_msb: TJvSpinEdit;
    ch4_lsb: TJvSpinEdit;
    ch4_url: TEdit;
    ch4_usr: TEdit;
    ch4_pwd: TEdit;
    ch4_start: TEdit;
    ch4_stop: TEdit;
    Label29: TLabel;
    ch5_src: TComboBox;
    ch5_msb: TJvSpinEdit;
    ch5_lsb: TJvSpinEdit;
    ch5_url: TEdit;
    ch5_usr: TEdit;
    ch5_pwd: TEdit;
    ch5_start: TEdit;
    ch5_stop: TEdit;
    Label30: TLabel;
    ch6_src: TComboBox;
    ch6_msb: TJvSpinEdit;
    ch6_lsb: TJvSpinEdit;
    ch6_url: TEdit;
    ch6_usr: TEdit;
    ch6_pwd: TEdit;
    ch6_start: TEdit;
    ch6_stop: TEdit;
    Label31: TLabel;
    ch7_src: TComboBox;
    ch7_msb: TJvSpinEdit;
    ch7_lsb: TJvSpinEdit;
    ch7_url: TEdit;
    ch7_usr: TEdit;
    ch7_pwd: TEdit;
    ch7_start: TEdit;
    ch7_stop: TEdit;
    Label32: TLabel;
    ch8_src: TComboBox;
    ch8_msb: TJvSpinEdit;
    ch8_lsb: TJvSpinEdit;
    ch8_url: TEdit;
    ch8_usr: TEdit;
    ch8_pwd: TEdit;
    ch8_start: TEdit;
    ch8_stop: TEdit;  
    Label33: TLabel;
    ch1_percent: TJvSpinEdit;
    ch2_percent: TJvSpinEdit;
    ch3_percent: TJvSpinEdit;
    ch4_percent: TJvSpinEdit;
    ch5_percent: TJvSpinEdit;
    ch6_percent: TJvSpinEdit;
    ch7_percent: TJvSpinEdit;
    ch8_percent: TJvSpinEdit;
    ch1_name: TEdit;
    Label34: TLabel;
    ch2_name: TEdit;
    ch3_name: TEdit;
    ch4_name: TEdit;
    ch5_name: TEdit;
    ch6_name: TEdit;
    ch7_name: TEdit;
    ch8_name: TEdit;
    Label35: TLabel;
    ch1_mean: TJvSpinEdit;
    ch2_mean: TJvSpinEdit;
    ch3_mean: TJvSpinEdit;
    ch4_mean: TJvSpinEdit;
    ch5_mean: TJvSpinEdit;
    ch6_mean: TJvSpinEdit;
    ch7_mean: TJvSpinEdit;
    ch8_mean: TJvSpinEdit;
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
