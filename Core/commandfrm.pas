unit commandfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, gnugettext;

const
  {$I GlobaleKonstanten.inc} // maximale Kanalzahl für PC_DIMMER !Vorsicht! Bei Ändern des Wertes müssen einzelne Plugins und Forms ebenfalls verändert werden, da dort auch chan gesetzt wird! Auch die GUI muss angepasst werden

type
  Tcommandform = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button13: TButton;
    Button15: TButton;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    changechannel:array[1..chan] of bool;
  public
    { Public-Deklarationen }
  end;

var
  commandform: Tcommandform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tcommandform.Edit1Enter(Sender: TObject);
begin
  if Edit1.text=_('Kommando hier eingeben...') then
  begin
    Edit1.Text:='';
    Edit1.Font.Color:=clBlack;
  end;
end;

procedure Tcommandform.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text='' then
  begin
    Edit1.Text:=_('Kommando hier eingeben...');
    Edit1.Font.Color:=clGray;
  end;
end;

procedure Tcommandform.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
  begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
    Button11Click(Button11);
  end;

  if length(Edit1.Text)>0 then
  begin
    if Edit1.Text[length(Edit1.Text)]='-' then
    begin
      Edit1.Text:=Copy(Edit1.Text, 0, length(Edit1.Text)-1);
      Edit1.Text:=Edit1.Text+' Thru ';
      Edit1.SelStart:=length(Edit1.Text);
    end;

    if Edit1.Text[length(Edit1.Text)]='+' then
    begin
      Edit1.Text:=Copy(Edit1.Text, 0, length(Edit1.Text)-1);
      Edit1.Text:=Edit1.Text+' @ ';
      Edit1.SelStart:=length(Edit1.Text);
    end;
  end;
end;

procedure Tcommandform.Button11Click(Sender: TObject);
var
  kommando,temp:string;
  first, last, value, i:integer;
  changevalue:boolean;
begin
  value:=0;
  changevalue:=false;
  kommando:=Edit1.Text;

  // Kommando Stück für Stück auswerten
  temp:=kommando;

  if length(temp)>0 then
  begin
    while (temp[1]=' ') do
    begin
      temp:=Copy(temp, 2, length(temp));
    end;
    Label1.caption:=temp;

    if pos('Thru',temp)>0 then            //1 Thru 5 @ 255
    begin
      for i:=1 to chan do changechannel[i]:=false;
      first:=strtoint(copy(temp,0,pos(' ',temp)-1));

      if pos('@',temp)>0 then
      begin
        last:=strtoint(copy(temp,pos('Thru',temp)+5,pos('@',temp)-1-(pos('Thru',temp)+5)));
        value:=strtoint(copy(temp,pos('@',temp)+2,length(temp)));
        changevalue:=true;
      end else
      begin
        // nur Kanäle auswählen
        last:=strtoint(copy(temp,pos('Thru',temp)+5,length(temp)));
      end;

      for i:=first to last do changechannel[i]:=true;
      temp:='';
    end;

    if pos('@',temp)=1 then
    begin
      value:=strtoint(copy(temp,2,length(temp)));
      changevalue:=true;
      temp:='';
    end;

    if pos('@',temp)>0 then
    begin
      for i:=1 to chan do changechannel[i]:=false;
      changechannel[strtoint(copy(temp,0,pos(' ',temp)-1))]:=true;
      value:=strtoint(copy(temp,pos('@',temp)+2,length(temp)));
      changevalue:=true;
      temp:='';
    end;

    if changevalue then
    for i:=1 to mainform.lastchan do
    begin
      if changechannel[i] then
      begin
        mainform.Senddata(i, 255-mainform.channel_value[i], 255-value, 0);
      end;
    end;
  end;
  Edit1.text:='';
end;

procedure Tcommandform.Button1Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+'1';
end;

procedure Tcommandform.Button2Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+'2';
end;

procedure Tcommandform.Button3Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+'3';
end;

procedure Tcommandform.Button4Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+'4';
end;

procedure Tcommandform.Button5Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+'5';
end;

procedure Tcommandform.Button6Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+'6';
end;

procedure Tcommandform.Button7Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+'7';
end;

procedure Tcommandform.Button8Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+'8';
end;

procedure Tcommandform.Button9Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+'9';
end;

procedure Tcommandform.Button10Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+'0';
end;

procedure Tcommandform.Button13Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;
   Edit1.Text:=Edit1.Text+' Thru ';
end;

procedure Tcommandform.Button15Click(Sender: TObject);
begin
    if Edit1.text=_('Kommando hier eingeben...') then
    begin
      Edit1.Text:='';
      Edit1.Font.Color:=clBlack;
    end;

  if Edit1.Text='' then
    Edit1.Text:='@ '
  else
    Edit1.Text:=Edit1.Text+' @ ';
end;

procedure Tcommandform.TrackBar1Change(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to mainform.lastchan do
  begin
    if changechannel[i] then
    begin
      mainform.Senddata(i, Trackbar1.Position, Trackbar1.Position, 0);
    end;
  end;
end;

procedure Tcommandform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tcommandform.CreateParams(var Params:TCreateParams);
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
