unit layerbezeichnungenfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, gnugettext;

type
  Tlayerbezeichnungenform = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    Shape4: TShape;
    Shape1: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure LabeledEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  layerbezeichnungenform: Tlayerbezeichnungenform;

implementation

uses audioeffektplayerfrm, PCDIMMER;

{$R *.dfm}

procedure Tlayerbezeichnungenform.FormShow(Sender: TObject);
begin
  LabeledEdit1.Text:=mainform.Effektaudiodatei_record.layername[1];
  LabeledEdit2.Text:=mainform.Effektaudiodatei_record.layername[2];
  LabeledEdit3.Text:=mainform.Effektaudiodatei_record.layername[3];
  LabeledEdit4.Text:=mainform.Effektaudiodatei_record.layername[4];
  LabeledEdit5.Text:=mainform.Effektaudiodatei_record.layername[5];
  LabeledEdit6.Text:=mainform.Effektaudiodatei_record.layername[6];
  LabeledEdit7.Text:=mainform.Effektaudiodatei_record.layername[7];
  LabeledEdit8.Text:=mainform.Effektaudiodatei_record.layername[8];
end;

procedure Tlayerbezeichnungenform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tlayerbezeichnungenform.CreateParams(var Params:TCreateParams);
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

procedure Tlayerbezeichnungenform.LabeledEdit1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_return then
  begin
    layerbezeichnungenform.ModalResult:=mrOK;
  end;
end;

end.
