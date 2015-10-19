{******************************************************************************}
{                                                                              }
{ Version 2.0 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version 2.1 by omata (Thorsten)                                      }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit FrameEquiliserU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, BassEquiliserU, StdCtrls;

type
  TFrameEquiliser = class(TFrame)
    RbAn: TRadioButton;
    RbAus: TRadioButton;
    BtnReset: TButton;
    procedure RbAnClick(Sender: TObject);
    procedure RbAusClick(Sender: TObject);
    procedure BtnResetClick(Sender: TObject);
  private
    { Private-Deklarationen }
    _Equilisor:TBassEquiliser;
    _TrackBars:array of TTrackBar;
    procedure TrackBarChange(Sender: TObject);
  public
    { Public-Deklarationen }
    constructor create(AOwner:TComponent;
                       Equiliser:TBassEquiliser); reintroduce;
    destructor destroy; override;
  end;

implementation

{$R *.dfm}

{ TFrameEquiliser }

constructor TFrameEquiliser.create(AOwner: TComponent;
                                   Equiliser:TBassEquiliser);
var i:integer;
    TrackBar:TTrackBar;
    MyLabel:TLabel;
begin
  inherited create(AOwner);
  _Equilisor:=Equiliser;
  setlength(_TrackBars, Equiliser.count);
  for i:=1 to Equiliser.count do begin
    TrackBar:=TTrackBar.Create(Self);
    Trackbar.Parent:=Self;
    Trackbar.Min:=-15;
    Trackbar.Max:=15;
    Trackbar.Orientation:=trVertical;
    Trackbar.Frequency:=2;
    Trackbar.ThumbLength:=15;
    Trackbar.Top:=0;
    Trackbar.Height:=140;
    Trackbar.Left:=((i-1) * (Trackbar.Width-5)) + 50;
    Trackbar.OnChange:=TrackBarChange;
    Trackbar.Tag:=i-1;
    TrackBar.Position:=_Equilisor.Gain[i-1] * -1;
    _TrackBars[i-1]:=TrackBar;

    MyLabel:=TLabel.Create(Self);
    MyLabel.Parent:=Self;
    MyLabel.AutoSize:=false;
    MyLabel.Alignment:=taCenter;
    MyLabel.Left:=TrackBar.Left - 10;
    MyLabel.Width:=TrackBar.Width;
    MyLabel.Caption:=floattostr(_Equilisor.Frequenz[i-1]);
    MyLabel.Top:=TrackBar.Top + TrackBar.Height;
  end;
end;

destructor TFrameEquiliser.destroy;
begin
  inherited;
end;

procedure TFrameEquiliser.TrackBarChange(Sender: TObject);
begin
  _Equilisor.SetIndexGain(
    TTrackBar(Sender).Tag, TTrackBar(Sender).Position * -1
  );
end;

procedure TFrameEquiliser.RbAnClick(Sender: TObject);
begin
  _Equilisor.Start;
end;

procedure TFrameEquiliser.RbAusClick(Sender: TObject);
begin
  _Equilisor.Stop;
end;

procedure TFrameEquiliser.BtnResetClick(Sender: TObject);
var i:integer;
begin
  _Equilisor.ResetDefaultValues;
  for i:=1 to length(_TrackBars) do
    _TrackBars[i-1].Position:=0;
end;

end.
