unit ddfeditorassistant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, gnugettext, StdCtrls, ComCtrls, ExtCtrls,
  JvExControls, JvGradient, dxGDIPlusClasses;

type
  Tddfeditorassistantform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel2: TPanel;
    nextbtn: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    TabSheet5: TTabSheet;
    Memo5: TMemo;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    Memo6: TMemo;
    Memo7: TMemo;
    Memo8: TMemo;
    Memo9: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure FormShow(Sender: TObject);
    procedure nextbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    step:integer;
  public
    { Public-Deklarationen }
  end;

var
  ddfeditorassistantform: Tddfeditorassistantform;

implementation

uses PCDIMMER, ddfeditorfrm;

{$R *.dfm}

procedure Tddfeditorassistantform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tddfeditorassistantform.CreateParams(var Params:TCreateParams);
begin
  inherited;// CreateParams(Params);

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

procedure Tddfeditorassistantform.FormShow(Sender: TObject);
begin
  pagecontrol1.TabIndex:=0;
  step:=0;
end;

procedure Tddfeditorassistantform.nextbtnClick(Sender: TObject);
begin
  case step of
    0:
    begin
      pagecontrol1.TabIndex:=pagecontrol1.TabIndex+1;
      ddfeditorform.show;
      ddfeditorform.PageControl1.TabIndex:=0;
      ddfeditorform.PageControl2.TabIndex:=0;
      ddfeditorassistantform.BringToFront;
    end;
    1:
    begin
      pagecontrol1.TabIndex:=pagecontrol1.TabIndex+1;
      ddfeditorform.PageControl1.TabIndex:=ddfeditorform.PageControl1.TabIndex+1;
    end;
    2:
    begin
      pagecontrol1.TabIndex:=pagecontrol1.TabIndex+1;
    end;
    3:
    begin
      // GOBOS
      pagecontrol1.TabIndex:=pagecontrol1.TabIndex+1;
      ddfeditorform.PageControl2.TabIndex:=ddfeditorform.PageControl2.TabIndex+1;
    end;
    4:
    begin
      // Prisma/Dimmer
      pagecontrol1.TabIndex:=pagecontrol1.TabIndex+1;
      ddfeditorform.PageControl2.TabIndex:=ddfeditorform.PageControl2.TabIndex+1;
    end;
    5:
    begin
      // Dimmer
      pagecontrol1.TabIndex:=pagecontrol1.TabIndex+1;
      ddfeditorform.PageControl2.TabIndex:=ddfeditorform.PageControl2.TabIndex+1;
    end;
    6:
    begin
      // DDF Erstellen
      pagecontrol1.TabIndex:=pagecontrol1.TabIndex+1;
      ddfeditorform.autoddfbtn.Click;
    end;
    7:
    begin
      // Fertig
      pagecontrol1.TabIndex:=pagecontrol1.TabIndex+1;
      ddfeditorform.GerteeinstellungenalsXMLspeichern1Click(nil);
    end;
    8:
    begin
      // Schluss
      ddfeditorassistantform.Close;
    end;
  end;
  inc(step);
end;

end.
