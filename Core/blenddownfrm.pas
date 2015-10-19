unit blenddownfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, gnugettext;

type
  Tblenddown = class(TForm)
    blendfadein: TTimer;
    blendfadeout: TTimer;
    procedure blendfadeinTimer(Sender: TObject);
    procedure blendfadeoutTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    endalphablendvalue:integer;
    screenfaded:boolean;
  end;

var
  blenddown: Tblenddown;

implementation

{$R *.dfm}

procedure Tblenddown.blendfadeinTimer(Sender: TObject);
begin
  // Bildschirm schwarz färben
  blenddown.AlphaBlendValue:=blenddown.AlphaBlendValue+10;

  if blenddown.AlphaBlendValue>=endalphablendvalue then
  begin
    blendfadein.Enabled:=false;
    screenfaded:=true;
  end;
end;

procedure Tblenddown.blendfadeoutTimer(Sender: TObject);
begin
  // Bildschirm wieder erhellen
  blenddown.AlphaBlendValue:=blenddown.AlphaBlendValue-20;

  if blenddown.AlphaBlendValue<=20 then
  begin
    blendfadeout.Enabled:=false;
    screenfaded:=false;
    close;
  end;
end;

procedure Tblenddown.FormShow(Sender: TObject);
begin
//  setWindowLong(Handle, GWL_EXSTYLE,
//    getWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TRANSPARENT);
  setWindowLong(Handle, GWL_EXSTYLE,
    getWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TRANSPARENT or WS_EX_LAYERED);
end;

procedure Tblenddown.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

end.
