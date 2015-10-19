unit DimmerKernelQueue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, gnugettext;

type
  TDimmerkernelQueueForm = class(TForm)
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  DimmerkernelQueueForm: TDimmerkernelQueueForm;

implementation

uses PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

procedure TDimmerkernelQueueForm.FormShow(Sender: TObject);
begin
//  mainform.MeasureKernelLaufzeit:=true;
  Timer1.enabled:=true;
  StringGrid1.Cells[0,0]:=_('Jobbezeichnung');
  StringGrid1.Cells[1,0]:=_('Fortschritt / Wert');
  StringGrid1.Cells[2,0]:=_('Restzeit');
end;

procedure TDimmerkernelQueueForm.FormHide(Sender: TObject);
begin
  Timer1.Enabled:=false;
//  mainform.MeasureKernelLaufzeit:=false;
end;

procedure TDimmerkernelQueueForm.Timer1Timer(Sender: TObject);
var
  i:integer;
begin
  // DimmerKernel mit Array
  if length(mainform.DimmerkernelChannelArray)>1 then
  begin
    StringGrid1.RowCount:=length(mainform.DimmerkernelChannelArray)+1;
  end else
  begin
    StringGrid1.RowCount:=2;
    if length(mainform.DimmerkernelChannelArray)=0 then
    begin
      StringGrid1.Cells[0,1]:='';
      StringGrid1.Cells[1,1]:='';
      StringGrid1.Cells[2,1]:='';
    end;
  end;
  try
    if length(mainform.DimmerkernelChannelArray)=1 then
      DimmerKernelQueueForm.Caption:='Dimmerkernel Queue ('+inttostr(length(mainform.DimmerkernelChannelArray))+' Job) ['+FloatToStrF(mainform.KernelLaufzeit*1000000, ffGeneral, 4, 2)+'us]'
    else
      DimmerKernelQueueForm.Caption:='Dimmerkernel Queue ('+inttostr(length(mainform.DimmerkernelChannelArray))+' Jobs) ['+FloatToStrF(mainform.KernelLaufzeit*1000000, ffGeneral, 4, 2)+'us]';
    for i:=0 to length(mainform.DimmerkernelChannelArray)-1 do
    begin
      mainform.pDimmerChannel:=mainform.DimmerkernelChannelArray[i];
      case mainform.pDimmerChannel.ChannelType of
        0:
        begin
          StringGrid1.Cells[0,i+1]:='Dimmer: Fading Channel '+inttostr(mainform.pDimmerChannel.channel);
          StringGrid1.Cells[1,i+1]:=inttostr(mainform.pDimmerChannel.channel_delay)+'ms ('+inttostr(round((255-abs(mainform.channel_value[mainform.pDimmerChannel.channel]-mainform.pDimmerChannel.channel_endvalue))/255*100))+'%)'+'   ['+floattostrf(mainform.channel_value_highresolution[mainform.pDimmerChannel.channel]/257, ffFixed, 15, 3)+' -> '+inttostr(mainform.channel_endvalue[mainform.pDimmerChannel.channel])+']';
          StringGrid1.Cells[2,i+1]:=mainform.MillisecondsToTimeShort(Round(((mainform.pDimmerChannel.channel_fadetime) / (mainform.pDimmerChannel.channel_steps/mainform.pDimmerKernelChannel.channel_fadetime))*(abs(mainform.channel_value[mainform.pDimmerChannel.channel]-mainform.pDimmerChannel.channel_endvalue))));

//          (mainform.pDimmerChannel.channel_fadetime / mainform.pDimmerChannel.channel_steps)
//          (255-abs(mainform.channel_value[mainform.pDimmerChannel.channel]-mainform.pDimmerChannel.channel_endvalue))
        end;
        1:
        begin
          StringGrid1.Cells[0,i+1]:=_('Audio: Volume');
          StringGrid1.Cells[1,i+1]:=inttostr(round(mainform.pDimmerChannel.channel_increase/65535*100))+'%';
          StringGrid1.Cells[2,i+1]:='-';
        end;
        2:
        begin
          StringGrid1.Cells[0,i+1]:=_('Befehl: Fading');
          StringGrid1.Cells[1,i+1]:=inttostr(mainform.pDimmerChannel.channel_delay)+'ms ('+inttostr(round((255-abs(mainform.pDimmerChannel.CurrentValue-mainform.pDimmerChannel.channel_endvalue))/255*100))+'%)';
          StringGrid1.Cells[2,i+1]:=mainform.MillisecondsToTimeShort(Round(((mainform.pDimmerChannel.channel_fadetime) / mainform.pDimmerChannel.channel_steps)*(abs(mainform.pDimmerChannel.CurrentValue-mainform.pDimmerChannel.channel_endvalue))));
        end;
        else begin
          StringGrid1.Cells[0,i+1]:=_('Error');
          StringGrid1.Cells[1,i+1]:='';
          StringGrid1.Cells[2,i+1]:='';
        end;
      end;
    end;
  except
  end;
end;

procedure TDimmerkernelQueueForm.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure TDimmerkernelQueueForm.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure TDimmerkernelQueueForm.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure TDimmerkernelQueueForm.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssShift, ssCtrl] then
  begin
    mainform.UseBilinearInterpolation:=not mainform.UseBilinearInterpolation;
    if mainform.UseBilinearInterpolation then
      ShowMessage('UseBilinearInterpolation=True')
    else
      ShowMessage('UseBilinearInterpolation=False');
  end;
end;

procedure TDimmerkernelQueueForm.CreateParams(var Params:TCreateParams);
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

procedure TDimmerkernelQueueForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled:=false;
//  mainform.MeasureKernelLaufzeit:=false;
end;

end.
