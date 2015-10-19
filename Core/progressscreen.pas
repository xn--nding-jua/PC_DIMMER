unit progressscreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, pngimage, JvExControls, JvGradient,
  JvSpecialProgress, UbuntuProgress, gnugettext;

type
  Tinprogress = class(TForm)
    Panel2: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    JvGradient1: TJvGradient;
    filename: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ProgressBar2: TUbuntuProgress;
    ProgressBar1: TUbuntuProgress;
    Panel1: TPanel;
    Image1: TImage;
    progressbar11: TJvSpecialProgress;
    Label9: TLabel;
    Shape1: TShape;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure Refresh;
  end;

var
  inprogress: Tinprogress;

implementation

uses PCDIMMER, About;

{$R *.dfm}

procedure Tinprogress.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  canclose:=false;
end;

function RDTSC: Int64; assembler;
asm
  RDTSC  // result Int64 in EAX and EDX
end;

procedure Tinprogress.FormShow(Sender: TObject);
var
  t, h, min:integer;
begin
  if mainform.splashscreenvalue=2 then
  begin
    progressbar11.Position:=0;
    label9.caption:=_('Verarbeite Daten...');
    inprogress.ClientHeight:=105;
    panel1.Visible:=true;
    panel2.Visible:=false;
  end else
  begin
    inprogress.ClientHeight:=201;
    panel1.Visible:=false;
    panel2.Visible:=true;

    Progressbar2.Position:=0;

    label4.Caption:=mainform.GetFileVersionBuild(paramstr(0));
    label5.Caption:=mainform.osversion;
  //  t:=round(RDTSC / (mainform.JvComputerInfoEx1.CPU.NormFreq*1000));
    t:=mainform.JvComputerInfoEx1.Misc.TimeRunning;
    h:=t div 3600000; t:=t mod 3600000;
    min:=t div 60000;
    label6.Caption:=_('Computerlaufzeit: ')+inttostr(h)+'h '+inttostr(min)+'min';
    label6.Refresh;
  end;
end;

procedure Tinprogress.FormCreate(Sender: TObject);
begin
//  TranslateComponent(self);
end;

procedure Tinprogress.Refresh;
begin
  if mainform.splashscreenvalue=2 then
  begin
    progressbar11.Maximum:=progressbar1.Max;
    progressbar11.Position:=progressbar1.Position;
    label9.caption:=filename.Caption;
//    progressbar11.Refresh;
//    label9.Refresh;
  end else
  begin
    filename.Refresh;
  end;
end;

end.
