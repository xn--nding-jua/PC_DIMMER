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
    procedure ScriptInterpreterGetValue(Sender: TObject;
      Identifier: String; var Value: Variant; Args: TJvInterpreterArgs;
      var Done: Boolean);
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

procedure Tcodeeditorform.ScriptInterpreterGetValue(Sender: TObject;
  Identifier: String; var Value: Variant; Args: TJvInterpreterArgs;
  var Done: Boolean);
var
  ID:TGUID;
begin
  if lowercase(Identifier)='set_absolutechannel' then
  begin
    if args.Count=4 then
    begin
      if args.values[1]>-1 then
        mainform.Senddata(args.values[0],255-args.values[1],255-args.values[2],args.values[3]);
      if args.values[1]=-1 then
        mainform.Senddata(args.values[0],mainform.channel_value[Integer(args.values[0])],255-args.values[2],args.values[3]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_pantilt' then
  begin
    if args.Count=6 then
    begin
      geraetesteuerung.set_pantilt(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4],args.values[5]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_channel' then
  begin
    if args.Count=5 then
    begin
      if args.values[2]>-1 then
        geraetesteuerung.set_channel(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4]);
      if args.values[2]=-1 then
        geraetesteuerung.set_channel(StringToGUID(args.values[0]),args.values[1],geraetesteuerung.get_channel(StringToGUID(args.values[0]),args.values[1]),args.values[3],args.values[4]);
    end;
    if args.Count=6 then
    begin
      if args.values[2]>-1 then
        geraetesteuerung.set_channel(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4],args.values[5]);
      if args.values[2]=-1 then
        geraetesteuerung.set_channel(StringToGUID(args.values[0]),args.values[1],geraetesteuerung.get_channel(StringToGUID(args.values[0]),args.values[1]),args.values[3],args.values[4],args.values[5]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_groupchannel' then
  begin
    if args.Count=5 then
    begin
      if args.values[2]>-1 then
        geraetesteuerung.set_group(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4]);
      if args.values[2]=-1 then
        geraetesteuerung.set_group(StringToGUID(args.values[0]),args.values[1],geraetesteuerung.get_channel(StringToGUID(args.values[0]),args.values[1]),args.values[3],args.values[4]);
    end;
    if args.Count=6 then
    begin
      if args.values[2]>-1 then
        geraetesteuerung.set_group(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4],args.values[5]);
      if args.values[2]=-1 then
        geraetesteuerung.set_group(StringToGUID(args.values[0]),args.values[1],geraetesteuerung.get_channel(StringToGUID(args.values[0]),args.values[1]),args.values[3],args.values[4],args.values[5]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='get_absolutechannel' then
  begin
    Value:=255-mainform.data.ch[Integer(args.values[0])];
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='get_channel' then
  begin
    ID:=StringToGUID(args.values[0]);
    Value:=geraetesteuerung.get_channel(mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@ID)].ID,args.values[1]);
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='levelstr' then
  begin
    Value:=mainform.levelstr(args.values[0]);
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='startscene' then
  begin
    if args.Count=1 then
    begin
      mainform.startscene(StringToGUID(args.values[0]),false,false);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='stopscene' then
  begin
    if args.Count=1 then
    begin
      mainform.stopscene(StringToGUID(args.values[0]));
    end;
    done:=true;
  end;

  if lowercase(Identifier)='startstopscene' then
  begin
    if args.Count=1 then
    begin
      if mainform.IsSceneActive(StringToGUID(args.values[0])) then
        mainform.StopScene(StringToGUID(args.values[0])) // Szene stoppen
      else
        mainform.StartScene(StringToGUID(args.values[0]),false,false); // Szene starten
    end;
    done:=true;
  end;

  if lowercase(Identifier)='starteffect' then
  begin
    if args.Count=1 then
    begin
      mainform.startscene(StringToGUID(args.values[0]),false,false);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='stopeffect' then
  begin
    if args.Count=1 then
    begin
      mainform.stopscene(StringToGUID(args.values[0]));
    end;
    done:=true;
  end;

  if lowercase(Identifier)='startstopeffect' then
  begin
    if args.Count=1 then
    begin
      if mainform.IsSceneActive(StringToGUID(args.values[0])) then
        mainform.StopScene(StringToGUID(args.values[0])) // Szene stoppen
      else
        mainform.StartScene(StringToGUID(args.values[0]),false,false); // Szene starten
    end;
    done:=true;
  end;

  if lowercase(Identifier)='openfile' then
  begin
    if args.Count=1 then
    begin
      if FileExists(mainform.SearchFileBeneathProject(args.values[0])) then
        mainform.OpenPCDIMMERFile(mainform.SearchFileBeneathProject(args.values[0]))
      else
        ShowMessage(_('Die Datei "')+args.values[0]+_('" existiert nicht.'));
    end;
    done:=true;
  end;

  // Objekte zuweisen
  if lowercase(Identifier)='mainform' then
  begin
    Value := O2V(mainform);
    Done := True;
  end;
  if lowercase(Identifier)='controlpanel' then
  begin
    Value := O2V(self);
    Done := True;
  end;
  if lowercase(Identifier)='sync_btn' then
  begin
    Value := O2V(kontrollpanel.sync_btn);
    Done := True;
  end;
{
  if lowercase(Identifier)='set_absolutchannel' then
  begin
    if args.Count=4 then
    begin
      mainform.Senddata(args.values[0],255-args.values[1],255-args.values[2],args.values[3]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_pantilt' then
  begin
    if args.Count=6 then
    begin
      geraetesteuerung.set_pantilt(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4],args.values[5]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_channel' then
  begin
    if args.Count=5 then
    begin
      geraetesteuerung.set_channel(StringToGUID(args.values[0]),args.values[1],args.values[2],args.values[3],args.values[4]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='get_absolutchannel' then
  begin
    Value:=255-mainform.data.ch[Integer(args.values[0])];
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='get_channel' then
  begin
    ID:=StringToGUID(args.values[0]);
    Value:=geraetesteuerung.get_channel(mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@ID)].ID,args.values[1]);
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='levelstr' then
  begin
    Value:=mainform.levelstr(args.values[0]);
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='startscene' then
  begin
    if args.Count=1 then
    begin
      mainform.startscene(StringToGUID(args.values[0]),false,false);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='stopscene' then
  begin
    if args.Count=1 then
    begin
      mainform.stopscene(StringToGUID(args.values[0]));
    end;
    done:=true;
  end;

  if lowercase(Identifier)='starteffect' then
  begin
    if args.Count=1 then
    begin
      mainform.startscene(StringToGUID(args.values[0]),false,false);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='stopeffect' then
  begin
    if args.Count=1 then
    begin
      mainform.stopscene(StringToGUID(args.values[0]));
    end;
    done:=true;
  end;

  // Objekte zuweisen
  if lowercase(Identifier)='mainform' then
  begin
    Value := O2V(mainform);
    Done := True;
  end;
  if lowercase(Identifier)='kontrollpanel' then
  begin
    Value := O2V(kontrollpanel);
    Done := True;
  end;
  if lowercase(Identifier)='sync_btn' then
  begin
    Done := True;
  end;
}
end;

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
