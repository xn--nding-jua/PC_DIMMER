unit SetNames;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, Buttons, gnugettext;

const
  {$I GlobaleKonstanten.inc}

type
  TSetNamesDlg = class(TForm)
    OKBtn: TButton;
    DefaultBtn: TButton;
    Groupbox1: TGroupBox;
    StringGrid1: TStringGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    JumpToChannel: TEdit;
    procedure DefaultBtnClick(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure JumpToChannelKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetNamesDlg: TSetNamesDlg;

implementation

{$R *.DFM}

uses
	pcdimmer;

procedure TSetNamesDlg.DefaultBtnClick(Sender: TObject);
var i:integer;
begin
if messagedlg(_('Alle Bezeichnungen auf Standard "Kanal x" zurücksetzen?'),mtWarning,
       [mbYes,mbNo],0)=mrYes then
  begin
    for i:=1 to mainform.lastchan do
    begin
      stringgrid1.cells[1,i]:=_('Kanal ')+inttostr(i);
      mainform.data.Names[i]:=_('Kanal ')+inttostr(i);
    end;
    mainform.pluginsaktualisieren(nil);
  end;
end;

procedure TSetNamesDlg.StringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  if (ACol=0) then StringGrid1.EditorMode:=false else StringGrid1.EditorMode:=true;
end;

procedure TSetNamesDlg.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if stringgrid1.Col=1 then
  begin
    mainform.data.Names[stringgrid1.row]:=stringgrid1.Cells[stringgrid1.Col,stringgrid1.row];
    mainform.pluginsaktualisieren(nil);
  end;
end;

procedure TSetNamesDlg.FormShow(Sender: TObject);
begin
	stringgrid1.Cols[0].Strings[0]:=_('Kanal');
	stringgrid1.Cols[1].Strings[0]:=_('Kanalname');
end;

procedure TSetNamesDlg.SpeedButton2Click(Sender: TObject);
var
	i:integer;
begin
  for i:=1 to mainform.lastchan do
    StringGrid1.Cells[1,i]:=mainform.data.Names[i];
  mainform.pluginsaktualisieren(nil);
end;

procedure TSetNamesDlg.SpeedButton3Click(Sender: TObject);
var
	i:integer;
begin
if messagedlg(_('Alle Bezeichnungen löschen?'),mtWarning,
       [mbYes,mbNo],0)=mrYes then
  begin
	  for i:=1 to mainform.lastchan do
    begin
      stringgrid1.cells[1,i]:='';
      mainform.data.Names[i]:='';
    end;
    mainform.pluginsaktualisieren(nil);
  end;
end;

procedure TSetNamesDlg.JumpToChannelKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
  if (JumpToChannel.Text<>'') and (strtoint(JumpToChannel.Text)>0) and (strtoint(JumpToChannel.Text)<= mainform.lastchan) then
    StringGrid1.TopRow:=strtoint(JumpToChannel.Text);
end;

procedure TSetNamesDlg.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

end.
