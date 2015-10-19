unit lockedfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, pngimage, Mask, GnuGetText;

type
  Tlockedform = class(TForm)
    Shape1: TShape;
    Image1: TImage;
    enterthematrix: TMaskEdit;
    Label1: TLabel;
    okbtn: TButton;
    Timer1: TTimer;
    ListBox1: TListBox;
    Image2: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure okbtnClick(Sender: TObject);
    procedure enterthematrixKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private-Deklarationen }
    joystick, keyboard, dmx, midi:boolean;
  public
    { Public-Deklarationen }
    itsmylife:string;
    darfbeenden:boolean;
  end;

var
  lockedform: Tlockedform;

implementation

uses joystickfrm, PCDIMMER;

{$R *.dfm}

procedure Tlockedform.FormShow(Sender: TObject);
begin
  darfbeenden:=false;

  timer1.Enabled:=true;
  listbox1.Visible:=false;
  listbox1.Items.Clear;
  image1.Visible:=true;
  image2.Visible:=false;
  okbtn.SetFocus;

  joystick:=joystickform.CheckBox1.Checked;
  joystickform.JoystickTimer.Enabled:=false;

  keyboard:=mainform.ShortCutChecker.enabled;
  mainform.ShortCutChecker.enabled:=false;

  dmx:=mainform.DataInActiveRibbonBox.Down;
  mainform.DataInActiveRibbonBox.Down:=false;

  midi:=mainform.MIDIActiveRibbonBox.Down;
  mainform.MIDIActiveRibbonBox.Down:=false;
end;

procedure Tlockedform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tlockedform.okbtnClick(Sender: TObject);
begin
  if enterthematrix.Text=itsmylife then
  begin
    enterthematrix.Text:='';
    timer1.Enabled:=false;
    darfbeenden:=true;
    modalresult:=mrOK;
  end else
  begin
    image1.Visible:=false;
    image2.Visible:=true;
    listbox1.Visible:=true;
    listbox1.ItemIndex:=listbox1.Items.Add(timetostr(now)+' '+datetostr(now)+': Kennwort falsch!');
    darfbeenden:=false;
  end;
end;

procedure Tlockedform.enterthematrixKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return then
  begin
    okbtnClick(nil);
  end;
end;

procedure Tlockedform.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled:=false;
  enterthematrix.SetFocus;
end;

procedure Tlockedform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  joystickform.CheckBox1.Checked:=joystick;
  joystickform.JoystickTimer.Enabled:=joystick;

  mainform.ShortCutChecker.enabled:=keyboard;

  mainform.DataInActiveRibbonBox.Down:=dmx;

  mainform.MIDIActiveRibbonBox.Down:=midi;
end;

procedure Tlockedform.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  canclose:=darfbeenden;
end;

end.
