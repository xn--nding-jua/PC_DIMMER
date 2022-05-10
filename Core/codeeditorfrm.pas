unit codeeditorfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, PngBitBtn, StdCtrls, ExtCtrls, SynEdit,
  JvComponentBase, JvInterpreter, SynEditHighlighter, SynHighlighterPas,
  gnugettext;

type
  Tcodeeditorform = class(TForm)
    Memo1: TSynEdit;
    Panel1: TPanel;
    Button1: TButton;
    MouseDown: TPngBitBtn;
    Button2: TButton;
    ScriptInterpreter: TJvInterpreterProgram;
    MouseUp: TPngBitBtn;
    SynPasSyn1: TSynPasSyn;
    Panel2: TPanel;
    Memo2: TMemo;
    Splitter1: TSplitter;
    Button3: TButton;
    Panel3: TPanel;
    StartSceneTest: TPngBitBtn;
    StopSceneTest: TPngBitBtn;
    nameedit: TEdit;
    descriptionedit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    InitSceneTest: TPngBitBtn;
    procedure ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    argumente:TJvInterpreterArgs;
  public
    { Public-Deklarationen }
  end;

var
  codeeditorform: Tcodeeditorform;

implementation

uses PCDIMMER, geraetesteuerungfrm, kontrollpanelform, compileerrorfrm,
  addfunctionfrm;

{$R *.dfm}

procedure Tcodeeditorform.ButtonClick(Sender: TObject);
var
  i,errorline:integer;
begin
  errorline:=0;
  ScriptInterpreter.Pas:=memo1.Lines;
  try
    ScriptInterpreter.Compile;
    argumente.Count:=0;
    if Sender=MouseDown then
      ScriptInterpreter.CallFunction('ButtonMouseDown',argumente, []);
    if Sender=MouseUp then
      ScriptInterpreter.CallFunction('ButtonMouseUp',argumente, []);
    if Sender=InitSceneTest then
      ScriptInterpreter.CallFunction('InitScene',argumente, []);
    if Sender=StartSceneTest then
      ScriptInterpreter.CallFunction('StartScene',argumente, []);
    if Sender=StopSceneTest then
      ScriptInterpreter.CallFunction('StopScene',argumente, []);
  except
    compileerrorform.listbox1.items.clear;
    compileerrorform.listbox1.Items:=memo1.Lines;
    for i:=0 to compileerrorform.listbox1.Items.Count-1 do
      compileerrorform.listbox1.Selected[i]:=false;

    if pos('on line ',ScriptInterpreter.LastError.Message)>0 then
      errorline:=strtoint(copy(ScriptInterpreter.LastError.Message,pos('on line ',ScriptInterpreter.LastError.Message)+8,pos(' : ',ScriptInterpreter.LastError.Message)-length(copy(ScriptInterpreter.LastError.Message,0,pos('on line ',ScriptInterpreter.LastError.Message)+8))));

    compileerrorform.listbox1.Selected[errorline-1]:=true;

    compileerrorform.Memo1.Lines.Clear;
    compileerrorform.Memo1.Lines.Add(ScriptInterpreter.LastError.ErrMessage);
    compileerrorform.memo1.lines.add('');
    compileerrorform.Memo1.Lines.Add(ScriptInterpreter.LastError.Message);

    compileerrorform.show;
  end;
end;

procedure Tcodeeditorform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  argumente:=TJvInterpreterArgs.Create;
  ScriptInterpreter.OnGetValue:=kontrollpanel.ScriptInterpreterGetValue;
end;

procedure Tcodeeditorform.Button3Click(Sender: TObject);
begin
  if addfunctionform.showmodal=mrOK then
  begin
    Memo1.PasteFromClipboard;
  end;
end;

procedure Tcodeeditorform.CreateParams(var Params:TCreateParams);
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
