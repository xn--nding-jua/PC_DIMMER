unit recoveryfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, JvExControls, JvGradient, gnugettext;

type
  Trecoveryform = class(TForm)
    Shape2: TShape;
    Button2: TButton;
    Shape1: TShape;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image2: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Button1: TButton;
    ListBox1: TListBox;
    sicherungskopienlabel: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    Label12: TLabel;
    projektversionlbl: TLabel;
    bearbeiterlbl: TLabel;
    projekttitellbl: TLabel;
    lastversionlbl: TLabel;
    speicherdatumlbl: TLabel;
    uhrzeitlbl: TLabel;
    speicherungenlbl: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    FileStream:TFileStream;
    projektprogrammversion,projektdatum,projektuhrzeit,projekttitel,projektversion,projektbearbeiter,projektspeicheranzahl:string[255];
    procedure LoadInfos(filename:string);
  public
    { Public-Deklarationen }
  end;

var
  recoveryform: Trecoveryform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Trecoveryform.LoadInfos(filename:string);
var
  MaximumChan:Cardinal;
  LastChan:integer;
begin
  if (listbox1.ItemIndex>-1) then
  begin
    FileStream:=TFileStream.Create(filename,fmOpenRead);
      FileStream.ReadBuffer(projektprogrammversion,256);
      FileStream.ReadBuffer(projektdatum,256);
      FileStream.ReadBuffer(projektuhrzeit,256);
      FileStream.ReadBuffer(MaximumChan,sizeof(MaximumChan));
      FileStream.ReadBuffer(LastChan,sizeof(LastChan));
      FileStream.ReadBuffer(projekttitel,256);
      FileStream.ReadBuffer(projektversion,256);
      FileStream.ReadBuffer(projektbearbeiter,256);
      FileStream.ReadBuffer(projektspeicheranzahl,256);
    FileStream.Free;

    if projekttitel<>mainform.projekttitel then
    begin
      projekttitellbl.Caption:=projekttitel+_(' [Projektfremd!]');
      projekttitellbl.Font.Style:=[fsBold];
      projekttitellbl.Font.Color:=clRed;
    end else
    begin
      projekttitellbl.Caption:=projekttitel+' [OK]';
      projekttitellbl.Font.Style:=[];
      projekttitellbl.Font.Color:=clGreen;
    end;

    projektversionlbl.Caption:=projektversion;
    bearbeiterlbl.Caption:=projektbearbeiter;
    lastversionlbl.Caption:=projektprogrammversion;
    speicherdatumlbl.Caption:=projektdatum;
    uhrzeitlbl.Caption:=projektuhrzeit;
    speicherungenlbl.Caption:=projektspeicheranzahl;

    Button1.Enabled:=(listbox1.ItemIndex>-1);
  end;
end;

procedure Trecoveryform.FormShow(Sender: TObject);
var
  i:integer;
begin
  projekttitellbl.Caption:='';
  projektversionlbl.Caption:='';
  bearbeiterlbl.Caption:='';
  lastversionlbl.Caption:='';
  speicherdatumlbl.Caption:='';
  uhrzeitlbl.Caption:='';
  speicherungenlbl.Caption:='';

  listbox1.Clear;

  if FileExists(mainform.userdirectory+'Autobackup.pcdbkup') then
    listbox1.Items.Add('Autobackup.pcdbkup');

  i:=0;
  repeat
    i:=i+1;
    if FileExists(mainform.userdirectory+'Autobackup~'+inttostr(i)+'.pcdbkup') then
      listbox1.Items.Add('Autobackup~'+inttostr(i)+'.pcdbkup');
  until (FileExists(mainform.userdirectory+'Autobackup~'+inttostr(i)+'.pcdbkup')=false);
end;

procedure Trecoveryform.ListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Listbox1.itemindex>-1) then
    LoadInfos(mainform.userdirectory+listbox1.Items[Listbox1.itemindex]);
end;

procedure Trecoveryform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Trecoveryform.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Listbox1.itemindex>-1) then
    LoadInfos(mainform.userdirectory+listbox1.Items[Listbox1.itemindex]);
end;

procedure Trecoveryform.Button1Click(Sender: TObject);
begin
  if messagedlg(_('Es wird versucht das Autobackup "')+projekttitel+_('" vom ')+projektdatum+', '+projektuhrzeit+_(' wiederherzustellen. Fortfahren?'),mtWarning,
    [mbYes,mbNo],0)=mrYes then
      Modalresult:=mrOK
    else
      ModalResult:=mrNone;
end;

procedure Trecoveryform.CreateParams(var Params:TCreateParams);
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
