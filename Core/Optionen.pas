unit Optionen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, blenddownfrm, Grids,
  CheckLst, pngimage, JvExControls, JvGradient, gnugettext, Mask, JvExMask,
  JvSpin, Buttons, PngBitBtn, Menus, PngImageList;

const
  {$I GlobaleKonstanten.inc}

type
  TOptionenBox = class(TForm)
    Notebook1: TNotebook;
    startupwitholdscene_checkbox: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    powerswitch_checkbox: TCheckBox;
    Label9: TLabel;
    levelanzeigeoptionen: TRadioGroup;
    Label13: TLabel;
    sounddevices: TComboBox;
    Label14: TLabel;
    Plugingrid: TStringGrid;
    askforsaveproject_checkbox: TCheckBox;
    deactivateoutputdllsonclose: TCheckBox;
    deactivateinputdllsonclose: TCheckBox;
    bildschirmhelligkeit: TEdit;
    Label23: TLabel;
    showlastplugins_checkbox: TCheckBox;
    scrolllockled_checkbox: TCheckBox;
    showaccuwarnings: TCheckBox;
    RadioGroup1: TRadioGroup;
    Label27: TLabel;
    Button1: TButton;
    Label25: TLabel;
    Label39: TLabel;
    BlendOutFormsCheckbox: TCheckBox;
    Panel2: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel3: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    Label26: TLabel;
    Label46: TLabel;
    Panel4: TPanel;
    pluginconfigure: TButton;
    pluginabout: TButton;
    Panel5: TPanel;
    Panel6: TPanel;
    GroupBox3: TGroupBox;
    frontspeaker: TCheckBox;
    rearspeaker: TCheckBox;
    centerlfespeaker: TCheckBox;
    backsurroundspeaker: TCheckBox;
    GroupBox4: TGroupBox;
    Label38: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    mbs_onlineCheckbox: TCheckBox;
    mbs_msgonEdit: TEdit;
    mbs_data1onEdit: TEdit;
    mbs_data2onEdit: TEdit;
    mbs_msgoffEdit: TEdit;
    mbs_data1offEdit: TEdit;
    mbs_data2offEdit: TEdit;
    GroupBox5: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    lastchan: TTrackBar;
    lastchan_edit: TEdit;
    GroupBox6: TGroupBox;
    prioritaet_label: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    prioritaet: TTrackBar;
    Label4: TLabel;
    GroupBox7: TGroupBox;
    mevpdir: TEdit;
    Label15: TLabel;
    OpenDialog1: TOpenDialog;
    PngBitBtn1: TPngBitBtn;
    Label47: TLabel;
    Button2: TButton;
    Label48: TLabel;
    GroupBox2: TGroupBox;
    Label24: TLabel;
    Label45: TLabel;
    Autosavelabel: TLabel;
    Autosavetrackbar: TTrackBar;
    maxautobackupfilesedit: TJvSpinEdit;
    GroupBox8: TGroupBox;
    Label49: TLabel;
    autolocktime: TComboBox;
    Label50: TLabel;
    autolockcode: TEdit;
    GroupBox9: TGroupBox;
    HTTPServerPasswordCheckbox: TCheckBox;
    HTTPServerPassword: TEdit;
    Label37: TLabel;
    GroupBox10: TGroupBox;
    terminalportedit: TJvSpinEdit;
    Label51: TLabel;
    GroupBox11: TGroupBox;
    mediacenterportedit: TJvSpinEdit;
    Label52: TLabel;
    GroupBox12: TGroupBox;
    Label53: TLabel;
    midibacktrackintervaledit: TJvSpinEdit;
    Label54: TLabel;
    Label55: TLabel;
    GroupBox13: TGroupBox;
    dimmerkernelresolutionedit: TJvSpinEdit;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    bassrefreshbtn: TButton;
    switchofflightsatshutdown: TCheckBox;
    Panel7: TPanel;
    optionlabel2: TLabel;
    optionlabel3: TLabel;
    optionlabel4: TLabel;
    optionlabel5: TLabel;
    optionlabel6: TLabel;
    optionlabel7: TLabel;
    optionlabel8: TLabel;
    Label60: TLabel;
    optionlabel1: TLabel;
    optionlabel0: TLabel;
    optionimage0: TImage;
    optionimage1: TImage;
    optionimage2: TImage;
    optionimage3: TImage;
    optionimage4: TImage;
    optionimage5: TImage;
    optionimage6: TImage;
    optionimage7: TImage;
    optionimage8: TImage;
    Shape3: TShape;
    Shape4: TShape;
    optionshape0: TShape;
    optionshape1: TShape;
    optionshape2: TShape;
    optionshape3: TShape;
    optionshape4: TShape;
    optionshape5: TShape;
    optionshape6: TShape;
    optionshape7: TShape;
    optionshape8: TShape;
    Timer1: TTimer;
    Label34: TLabel;
    GroupBox14: TGroupBox;
    Label35: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    rfr_main: TJvSpinEdit;
    rfr_aep: TJvSpinEdit;
    rfr_buehnenansicht: TJvSpinEdit;
    rfr_cuelist: TJvSpinEdit;
    rfr_faderpanel: TJvSpinEdit;
    rfr_kanaluebersicht: TJvSpinEdit;
    rfr_kontrollpanel: TJvSpinEdit;
    rfr_kontrollpanelcheckforactive: TJvSpinEdit;
    rfr_submaster: TJvSpinEdit;
    Label69: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Button3: TButton;
    dimmerkernelresolutioncheck: TCheckBox;
    Timer2: TTimer;
    Label63: TLabel;
    CheckUpdatesOnStartup: TCheckBox;
    MevpUseThread: TCheckBox;
    GroupBox15: TGroupBox;
    MevpThreadPriorityLabel: TLabel;
    Label74: TLabel;
    Label79: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    MevpThreadPriority: TTrackBar;
    Label64: TLabel;
    QuitWithoutConfirmation: TCheckBox;
    Label86: TLabel;
    GroupBox1: TGroupBox;
    Label36: TLabel;
    autologouttime: TComboBox;
    startupuseredit: TComboBox;
    Label87: TLabel;
    autoambercheckbox: TCheckBox;
    GroupBox16: TGroupBox;
    Label88: TLabel;
    MQTTBrokerIP: TEdit;
    Label89: TLabel;
    MQTTBrokerPort: TJvSpinEdit;
    MQTTBrokerUser: TEdit;
    Label90: TLabel;
    MQTTBrokerPassword: TEdit;
    Label91: TLabel;
    procedure input_number(var pos:integer; var s:string);
    procedure FormShow(Sender: TObject);
    procedure prioritaetChange(Sender: TObject);
    procedure pluginconfigureClick(Sender: TObject);
    procedure pluginaboutClick(Sender: TObject);
    procedure PlugingridDblClick(Sender: TObject);
    procedure PlugingridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lastchanChange(Sender: TObject);
    procedure lastchan_editKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PlugingridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure PlugingridGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure PlugingridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bildschirmhelligkeitChange(Sender: TObject);
    procedure sounddevicesChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AutosavetrackbarChange(Sender: TObject);
    procedure PlugingridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure PlugingridKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure OnlyNumbersInTEdit(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure optionimage0MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure optionimage0MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure MevpUseThreadClick(Sender: TObject);
    procedure MevpThreadPriorityChange(Sender: TObject);
  private
    { Private-Deklarationen }
    MyHoverTickCount:byte;
  public
    { Public-Deklarationen }
  end;

var
  OptionenBox: TOptionenBox;

implementation

{$R *.dfm}

uses
	PCDIMMER, accumessagefrm;

procedure TOptionenBox.FormShow(Sender: TObject);
var
  i:integer;
begin
  mainform.debuglistbox.Items.LoadFromFile(mainform.userdirectory+'\PC_DIMMER.log');

  for i:=0 to 8 do
  begin
    if Notebook1.PageIndex=i then
    begin
      TShape(FindComponent('optionshape'+inttostr(i))).Brush.Color:=$00FFB9AE;
      TLabel(FindComponent('optionlabel'+inttostr(i))).Font.Style:=[fsBold];
    end else
    begin
      TShape(FindComponent('optionshape'+inttostr(i))).Brush.Color:=clWhite;
      TLabel(FindComponent('optionlabel'+inttostr(i))).Font.Style:=[];
    end;
  end;

  if mainform.OutputPlugins[plugingrid.Row].IsEnabled then
  begin
    pluginconfigure.Enabled:=true;
    pluginabout.Enabled:=true;
  end else
  begin
    pluginconfigure.Enabled:=false;
    pluginabout.Enabled:=false;
  end;

  if (length(mainform.plugin_blacklist)>0) or (length(mainform.plugin_blacklist_new)>0) then
  begin
    label48.Visible:=true;
    button2.Visible:=true;
  end;

  Timer2.enabled:=true;
end;

procedure TOptionenBox.prioritaetChange(Sender: TObject);
begin
  case prioritaet.Position of
    0: begin SetPriorityClass(GetCurrentProcess, IDLE_PRIORITY_CLASS); prioritaet_label.Caption:=_('Leerlauf'); end;
    1: begin SetPriorityClass(GetCurrentProcess, 16384); prioritaet_label.Caption:=_('Niedriger'); end;
    2: begin SetPriorityClass(GetCurrentProcess, NORMAL_PRIORITY_CLASS); prioritaet_label.Caption:=_('Normal'); end;
    3: begin SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS); prioritaet_label.Caption:=_('Höher'); end;
    4: begin SetPriorityClass(GetCurrentProcess, 32768); prioritaet_label.Caption:=_('Hoch'); end;
    5: begin SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS); prioritaet_label.Caption:=_('Echtzeit'); end;
  end;
  if prioritaet.Position=5 then
  begin
    prioritaet_label.Font.Style:=[fsBold];
    prioritaet_label.Font.Color:=clRed;
  end else
  begin
    prioritaet_label.Font.Style:=[];
    prioritaet_label.Font.Color:=clBlack;
  end;
end;

procedure TOptionenBox.input_number(var pos:integer; var s:string);
var i:integer;
begin
  i:=1;
  while i<=length(s) do
    begin
      if (s[i]<'-') or (s[i]>'9') then
        begin delete(s,i,1); dec(pos); end
      else
        inc(i);
    end;
end;

procedure TOptionenBox.pluginconfigureClick(Sender: TObject);
var
  ProcCall: procedure;stdcall;
begin
  if mainform.OutputPlugins[plugingrid.Row].Handle <> 0 then
  begin
    try
      ProcCall := GetProcAddress(mainform.OutputPlugins[plugingrid.Row].Handle,'DLLConfigure');
      if Assigned(ProcCall) then ProcCall else ShowMessage('Fehler in DLL-Prozedur "DLLConfigure"!');
    except
      ShowMessage('Fehler in DLL!');
    end;
  end
  else
    ShowMessage('Plugin nicht geladen...');
end;

procedure TOptionenBox.pluginaboutClick(Sender: TObject);
var
  ProcCall: procedure;stdcall;
begin
  if mainform.OutputPlugins[plugingrid.Row].Handle <> 0 then
  begin
    try
      ProcCall := GetProcAddress(mainform.OutputPlugins[plugingrid.Row].Handle,'DLLAbout');
      if Assigned(ProcCall) then ProcCall else ShowMessage('Fehler in DLL-Prozedur "DLLAbout"!');
    except
      ShowMessage('Fehler in DLL!');
    end;
  end else
    ShowMessage('Plugin nicht geladen...');
end;

procedure TOptionenBox.PlugingridDblClick(Sender: TObject);
begin
  if (Plugingrid.Col=1) and pluginconfigure.Enabled then
		pluginconfigure.Click;
end;

procedure TOptionenBox.PlugingridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ProcCall: procedure(funktionsadresse0,funktionsadresse1,funktionsadresse2,funktionsadresse3,funktionsadresse4:Pointer);stdcall;
  ProcCall2: procedure;stdcall;
  funccall: function:boolean;stdcall;
begin
  if Plugingrid.Col=0 then
  begin
	  if mainform.OutputPlugins[plugingrid.Row].IsEnabled=true then
	  begin
      mainform.OutputPlugins[Plugingrid.Row].IsEnabled:=false;

      @mainform.OutputPlugins[plugingrid.Row].SendData := nil;
      @mainform.OutputPlugins[plugingrid.Row].IsSending := nil;
      @mainform.OutputPlugins[plugingrid.Row].SendMessage := nil;

	    funccall := GetProcAddress(mainform.OutputPlugins[plugingrid.Row].Handle,'DLLDestroy');
      if not Assigned(funccall) then
  	    funccall := GetProcAddress(mainform.OutputPlugins[plugingrid.Row].Handle,'DLLDeactivate');
	   	if Assigned(funccall) then funccall else ShowMessage('Fehler in DLL-Prozedur "DLLDestroy" bzw. "DLLDeactivate"!');
	 	  FreeLibrary(mainform.OutputPlugins[plugingrid.Row].Handle);
	  	mainform.OutputPlugins[plugingrid.Row].Handle:=0;

	    mainform.debuglistbox.Items.Add('['+inttostr(mainform.debuglistbox.Items.Count)+'] ['+Timetostr(now)+'] ['+Datetostr(now)+'] PLUGIN: Deactivated Outputplugin '+mainform.OutputPlugins[plugingrid.Row].Filename);
	    mainform.debuglistbox.Items.SaveToFile(mainform.userdirectory+'\PC_DIMMER.log');

      mainform.OutputPlugins[plugingrid.Row].IsActive:=false;

	    pluginabout.Enabled:=false;
	    pluginconfigure.Enabled:=false;
	  end else
	  begin
	    mainform.OutputPlugins[plugingrid.Row].IsEnabled:=true;

	    mainform.OutputPlugins[plugingrid.Row].Handle := LoadLibrary(PChar(mainform.pcdimmerdirectory+'\plugins\'+mainform.OutputPlugins[plugingrid.Row].Filename));

	    ProcCall := GetProcAddress(mainform.OutputPlugins[plugingrid.Row].Handle,'DLLCreate');
      if not Assigned(ProcCall) then
        ProcCall := GetProcAddress(mainform.OutputPlugins[plugingrid.Row].Handle,'DLLActivate');
	    if Assigned(ProcCall) then
	    begin
        Proccall(@CallbackGetDLLValue,@CallbackGetDLLValueEvent,@CallbackGetDLLName,@CallbackSetDLLValue,@CallbackMessage);
	      mainform.debuglistbox.Items.Add('['+inttostr(mainform.debuglistbox.Items.Count)+'] ['+Timetostr(now)+'] ['+Datetostr(now)+'] PLUGIN: Activated Outputplugin '+mainform.OutputPlugins[plugingrid.Row].Filename);
	      mainform.debuglistbox.Items.SaveToFile(mainform.userdirectory+'\PC_DIMMER.log');
	    end else
	    begin
	      ShowMessage('Fehler in DLL-Prozedur "DLLCreate" bzw. "DLLActivate"!');
	      mainform.debuglistbox.Items.Add('['+inttostr(mainform.debuglistbox.Items.Count)+'] ['+Timetostr(now)+'] ['+Datetostr(now)+'] PLUGIN: Error in Outputplugin '+mainform.OutputPlugins[plugingrid.Row].Filename);
	      mainform.debuglistbox.Items.SaveToFile(mainform.userdirectory+'\PC_DIMMER.log');
	    end;

      @mainform.OutputPlugins[plugingrid.Row].SendData := GetProcAddress(mainform.OutputPlugins[plugingrid.Row].Handle,'DLLSendData');
      @mainform.OutputPlugins[plugingrid.Row].IsSending := GetProcAddress(mainform.OutputPlugins[plugingrid.Row].Handle,'DLLIsSending');
      @mainform.OutputPlugins[plugingrid.Row].SendMessage := GetProcAddress(mainform.OutputPlugins[plugingrid.Row].Handle,'DLLSendMessage');

	    pluginabout.Enabled:=true;
	    pluginconfigure.Enabled:=true;

      Application.ProcessMessages;
      sleep(100);

      ProcCall2 := GetProcAddress(mainform.OutputPlugins[plugingrid.Row].Handle,'DLLStart');
      if Assigned(ProcCall2) then
      begin
        Proccall2;
   	    mainform.OutputPlugins[plugingrid.Row].IsActive:=true;
      end;
	  end;
	end;
  if Plugingrid.Col=6 then
  begin
    mainform.OutputPlugins[plugingrid.Row].IsBlacklisted:=not mainform.OutputPlugins[plugingrid.Row].IsBlacklisted;
	end;

  if mainform.OutputPlugins[plugingrid.Row].IsEnabled then
  begin
    pluginconfigure.Enabled:=true;
    pluginabout.Enabled:=true;
  end else
  begin
    pluginconfigure.Enabled:=false;
    pluginabout.Enabled:=false;
  end;

	Plugingrid.Refresh;
end;

procedure TOptionenBox.lastchanChange(Sender: TObject);
begin
  lastchan_edit.text:=inttostr(lastchan.Position);
end;

procedure TOptionenBox.lastchan_editKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
	i:integer;
  s:string;
begin
//  if Key=vk_return then
  begin
	  s:=lastchan_edit.text;
	  i:=lastchan_edit.selstart;
	  mainform.input_number(i,s);
	  lastchan_edit.text:=s;
	  lastchan_edit.selstart:=i;
    if strtoint(lastchan_edit.text)>chan then lastchan_edit.text:=inttostr(chan);
    if strtoint(lastchan_edit.text)>=32 then
  	  lastchan.Position:=strtoint(lastchan_edit.text);
  end;
end;

procedure TOptionenBox.PlugingridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
	AOffSet : TPoint;
	AHaken1 : TPoint;
	AHaken2 : TPoint;
	AHaken3 : TPoint;
	ARect : TRect;
begin
  with Plugingrid.Canvas do
  begin
    if (ACol=Plugingrid.Col) and (ARow=Plugingrid.Row) then
    begin
      Brush.Color := clHighlight;
      Font.Color:=clHighlightText;
    end else
    begin
      Brush.Color := clWhite;
      Font.Color:=clWindowText;
    end;
    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, Plugingrid.Cells[ACol, ARow]);

    if (ACol = 0) then
    begin
      //Kasten zeichnen
      AOffSet.X := (Rect.Right - Rect.Left - 11) div 2;
      AOffSet.Y := (Rect.Bottom - Rect.Top - 11) div 2;

      ARect.Left := AOffSet.X + Rect.Left;
      ARect.Top := AOffSet.Y + Rect.Top;
      ARect.Right := AOffSet.X + Rect.Left + 11;
      ARect.Bottom := AOffSet.Y + Rect.Top + 11;

      Pen.Color := clGray;
      Rectangle(ARect);

      // Abfrage ob Haken zeichnen oder nicht
      if mainform.OutputPlugins[ARow].IsEnabled then
      begin
        //Haken zeichnen
        AHaken1.X := ARect.Left + 2;
        AHaken1.Y := ARect.Top + 6;
        AHaken2.X := ARect.Left + 4;
        AHaken2.Y := ARect.Top + 8;
        AHaken3.X := ARect.Left + 9;
        AHaken3.Y := ARect.Top + 3;

        Pen.Color := clBlack; // Farbe des Häkchens

        MoveTo(AHaken1.X, AHaken1.Y - 0);
        LineTo(AHaken2.X, AHaken2.Y - 0);
        LineTo(AHaken3.X, AHaken3.Y - 0);

        MoveTo(AHaken1.X, AHaken1.Y - 1);
        LineTo(AHaken2.X, AHaken2.Y - 1);
        LineTo(AHaken3.X, AHaken3.Y - 1);

        MoveTo(AHaken1.X, AHaken1.Y - 2);
        LineTo(AHaken2.X, AHaken2.Y - 2);
        LineTo(AHaken3.X, AHaken3.Y - 2);
      end;
    end;
    if (ACol = 6) then
    begin
      //Kasten zeichnen
      AOffSet.X := (Rect.Right - Rect.Left - 11) div 2;
      AOffSet.Y := (Rect.Bottom - Rect.Top - 11) div 2;

      ARect.Left := AOffSet.X + Rect.Left;
      ARect.Top := AOffSet.Y + Rect.Top;
      ARect.Right := AOffSet.X + Rect.Left + 11;
      ARect.Bottom := AOffSet.Y + Rect.Top + 11;

      Pen.Color := clGray;
      Rectangle(ARect);

      // Abfrage ob Haken zeichnen oder nicht
      if mainform.OutputPlugins[ARow].IsBlacklisted then
      begin
        //Haken zeichnen
        AHaken1.X := ARect.Left + 2;
        AHaken1.Y := ARect.Top + 6;
        AHaken2.X := ARect.Left + 4;
        AHaken2.Y := ARect.Top + 8;
        AHaken3.X := ARect.Left + 9;
        AHaken3.Y := ARect.Top + 3;

        Pen.Color := clRed; // Farbe des Häkchens

        MoveTo(AHaken1.X, AHaken1.Y - 0);
        LineTo(AHaken2.X, AHaken2.Y - 0);
        LineTo(AHaken3.X, AHaken3.Y - 0);

        MoveTo(AHaken1.X, AHaken1.Y - 1);
        LineTo(AHaken2.X, AHaken2.Y - 1);
        LineTo(AHaken3.X, AHaken3.Y - 1);

        MoveTo(AHaken1.X, AHaken1.Y - 2);
        LineTo(AHaken2.X, AHaken2.Y - 2);
        LineTo(AHaken3.X, AHaken3.Y - 2);
      end;
    end;
    TextOut(Rect.Left, Rect.Top, Plugingrid.Cells[ACol, ARow]);
  end;
end;

procedure TOptionenBox.PlugingridGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
var
	text:string;
begin
  if (ACol=1) or (ACol=2) or (ACol=5) then
    text:=Plugingrid.Cells[ACol,ARow];

  if (ACol=3) or (ACol=4) then
    Plugingrid.EditorMode:=true
  else
    Plugingrid.EditorMode:=false;

  if (ACol=1) or (ACol=2) or (ACol=5) then
    Plugingrid.Cells[ACol,ARow]:=text;
end;

procedure TOptionenBox.PlugingridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{
	if (Key=vk_return) then
  begin
    case Plugingrid.Col of
    3:
    begin
      ShowMessage(plugingrid.Cells[plugingrid.Col,plugingrid.Row]);
  	  try
  			if strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])>mainform.MaximumChan then
  	    	plugingrid.Cells[plugingrid.Col,plugingrid.Row]:=inttostr(mainform.MaximumChan);
  			if strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])<(-1*mainform.MaximumChan) then
  	    	plugingrid.Cells[plugingrid.Col,plugingrid.Row]:='-'+inttostr(mainform.MaximumChan);
        if strtoint(plugingrid.Cells[plugingrid.Col+1,plugingrid.Row])<strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row]) then
          plugingrid.Cells[plugingrid.Col+1,plugingrid.Row]:=inttostr(strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])+1);
  	  except
  		  plugingrid.Cells[plugingrid.Col,plugingrid.Row]:='1';
  	  end;
  	end;
    4:
    begin
  	  try
  			if strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])>mainform.MaximumChan then
  	    	plugingrid.Cells[plugingrid.Col,plugingrid.Row]:=inttostr(mainform.MaximumChan);
  			if strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])<(-1*mainform.MaximumChan) then
  	    	plugingrid.Cells[plugingrid.Col,plugingrid.Row]:='-'+inttostr(mainform.MaximumChan);
        if strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])<strtoint(plugingrid.Cells[plugingrid.Col-1,plugingrid.Row]) then
          plugingrid.Cells[plugingrid.Col,plugingrid.Row]:=inttostr(strtoint(plugingrid.Cells[plugingrid.Col-1,plugingrid.Row])+1);
  	  except
  		  plugingrid.Cells[plugingrid.Col,plugingrid.Row]:='1';
  	  end;
    end;
    end;
  end;
}
end;

procedure TOptionenBox.bildschirmhelligkeitChange(Sender: TObject);
var
	i:integer;
  s:string;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure TOptionenBox.sounddevicesChange(Sender: TObject);
begin
  sounddevices.Hint:='Soundkarte: '+sounddevices.Items.Strings[sounddevices.ItemIndex];
end;

procedure TOptionenBox.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure TOptionenBox.AutosavetrackbarChange(Sender: TObject);
begin
  if Autosavetrackbar.Position=0 then
  begin
    Autosavelabel.Caption:='Aus';
  end else
  begin
    Autosavelabel.Caption:=inttostr(Autosavetrackbar.Position)+' min';
  end;
end;

procedure TOptionenBox.PlugingridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
{
    case ACol of
    3:
    begin
      ShowMessage(Value);
  	  try
  			if strtoint(Value)>mainform.MaximumChan then
  	    	Value:=inttostr(mainform.MaximumChan);
  			if strtoint(Value)<(-1*mainform.MaximumChan) then
  	    	Value:='-'+inttostr(mainform.MaximumChan);
        if strtoint(plugingrid.Cells[ACol+1,ARow])<strtoint(Value) then
          plugingrid.Cells[ACol+1,ARow]:=inttostr(strtoint(Value)+1);
  	  except
  		  Value:='1';
  	  end;
  	end;
    4:
    begin
  	  try
  			if strtoint(Value)>mainform.MaximumChan then
  	    	Value:=inttostr(mainform.MaximumChan);
  			if strtoint(Value)<(-1*mainform.MaximumChan) then
  	    	Value:='-'+inttostr(mainform.MaximumChan);
        if strtoint(Value)<strtoint(plugingrid.Cells[ACol-1,ARow]) then
          Value:=inttostr(strtoint(plugingrid.Cells[ACol-1,ARow])+1);
  	  except
  		  Value:='1';
  	  end;
    end;
    end;
}
end;

procedure TOptionenBox.PlugingridKeyPress(Sender: TObject; var Key: Char);
begin
  begin
    case Plugingrid.Col of
    3:
    begin
      if (plugingrid.Cells[plugingrid.Col,plugingrid.Row]='-') or (plugingrid.Cells[plugingrid.Col,plugingrid.Row]='') then exit;
  	  try
  			if strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])>lastchan.Position then
  	    	plugingrid.Cells[plugingrid.Col,plugingrid.Row]:=inttostr(lastchan.Position);
//  			if strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])<(-1*mainform.lastchan) then
//  	    	plugingrid.Cells[plugingrid.Col,plugingrid.Row]:='-'+inttostr(mainform.lastchan);
//        if strtoint(plugingrid.Cells[plugingrid.Col+1,plugingrid.Row])<strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row]) then
//          plugingrid.Cells[plugingrid.Col+1,plugingrid.Row]:=inttostr(strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])+1);
  	  except
  		  plugingrid.Cells[plugingrid.Col,plugingrid.Row]:='1';
  	  end;
  	end;
    4:
    begin
      if (plugingrid.Cells[plugingrid.Col,plugingrid.Row]='-') or (plugingrid.Cells[plugingrid.Col,plugingrid.Row]='') then exit;
  	  try
  			if strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])>lastchan.Position then
  	    	plugingrid.Cells[plugingrid.Col,plugingrid.Row]:=inttostr(lastchan.Position);
//  			if strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])<(-1*mainform.lastchan) then
//  	    	plugingrid.Cells[plugingrid.Col,plugingrid.Row]:='-'+inttostr(mainform.lastchan);
//        if strtoint(plugingrid.Cells[plugingrid.Col,plugingrid.Row])<strtoint(plugingrid.Cells[plugingrid.Col-1,plugingrid.Row]) then
//          plugingrid.Cells[plugingrid.Col,plugingrid.Row]:=inttostr(strtoint(plugingrid.Cells[plugingrid.Col-1,plugingrid.Row])+1);
  	  except
  		  plugingrid.Cells[plugingrid.Col,plugingrid.Row]:='1';
  	  end;
    end;
    end;
  end;
end;

procedure TOptionenBox.Button1Click(Sender: TObject);
begin
  if mainform.akkulevel>-1 then
    accumessageform.percent.Caption:='< '+inttostr(mainform.akkulevel)+'%'
  else
    accumessageform.percent.Caption:='- kein Akku gefunden -';
  accumessageform.show;
end;

procedure TOptionenBox.OnlyNumbersInTEdit(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s:string;
  i:integer;
begin
  s:=(Sender as TEdit).text;
	i:=(Sender as TEdit).selstart;
	mainform.input_number(i,s);
	(Sender as TEdit).text:=s;
	(Sender as TEdit).selstart:=i;
end;

procedure TOptionenBox.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure TOptionenBox.PngBitBtn1Click(Sender: TObject);
begin
  if opendialog1.Execute then
  begin
    mevpdir.text:=OpenDialog1.FileName;
  end;
end;

procedure TOptionenBox.Button2Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Outputplugins)-1 do
    mainform.OutputPlugins[i].IsBlacklisted:=false;
  mainform.plugin_blacklist:='';
  mainform.plugin_blacklist_new:='';
  Showmessage(_('Nach einem Neustart stehen wieder alle Plugins zur Verfügung.'));
end;

procedure TOptionenBox.CreateParams(var Params:TCreateParams);
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

procedure TOptionenBox.optionimage0MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=0 to 8 do
  begin
    if (Sender=FindComponent('optionshape'+inttostr(i))) or
      (Sender=FindComponent('optionlabel'+inttostr(i))) or
      (Sender=FindComponent('optionimage'+inttostr(i))) then
    begin
      TShape(FindComponent('optionshape'+inttostr(i))).Brush.Color:=$00FFB9AE;
      TLabel(FindComponent('optionlabel'+inttostr(i))).Font.Style:=[fsBold];
      Notebook1.PageIndex:=i;
    end else
    begin
      TShape(FindComponent('optionshape'+inttostr(i))).Brush.Color:=clWhite;
      TLabel(FindComponent('optionlabel'+inttostr(i))).Font.Style:=[];
    end;
  end;
end;

procedure TOptionenBox.optionimage0MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  MyHoverTickCount:=0;
  Timer1.Enabled:=true;

  for i:=0 to 8 do
  begin
    if (Sender=FindComponent('optionshape'+inttostr(i))) or
      (Sender=FindComponent('optionlabel'+inttostr(i))) or
      (Sender=FindComponent('optionimage'+inttostr(i))) then
    begin
      TShape(FindComponent('optionshape'+inttostr(i))).Brush.Color:=$00FFDAD5;
    end else
    begin
      if Notebook1.PageIndex=i then
      begin
        TShape(FindComponent('optionshape'+inttostr(i))).Brush.Color:=$00FFB9AE;
        TLabel(FindComponent('optionlabel'+inttostr(i))).Font.Style:=[fsBold];
      end else
      begin
        TShape(FindComponent('optionshape'+inttostr(i))).Brush.Color:=clWhite;
        TLabel(FindComponent('optionlabel'+inttostr(i))).Font.Style:=[];
      end;
    end;
  end;
end;

procedure TOptionenBox.Timer1Timer(Sender: TObject);
var
  i:integer;
begin
  inc(MyHoverTickCount);

  if MyHoverTickCount=5 then
  begin
    Timer1.Enabled:=false;

    for i:=0 to 8 do
    begin
      if Notebook1.PageIndex=i then
      begin
        TShape(FindComponent('optionshape'+inttostr(i))).Brush.Color:=$00FFB9AE;
        TLabel(FindComponent('optionlabel'+inttostr(i))).Font.Style:=[fsBold];
      end else
      begin
        TShape(FindComponent('optionshape'+inttostr(i))).Brush.Color:=clWhite;
        TLabel(FindComponent('optionlabel'+inttostr(i))).Font.Style:=[];
      end;
    end;
  end;
end;

procedure TOptionenBox.Button3Click(Sender: TObject);
begin
  rfr_main.value:=50;
  rfr_aep.value:=100;
  rfr_buehnenansicht.value:=50;
  rfr_cuelist.value:=250;
  rfr_faderpanel.value:=50;
  rfr_kanaluebersicht.value:=50;
  rfr_kontrollpanel.value:=50;
  rfr_kontrollpanelcheckforactive.value:=250;
  rfr_submaster.value:=50;
end;

procedure TOptionenBox.FormHide(Sender: TObject);
begin
  Timer2.enabled:=false;
end;

procedure TOptionenBox.Timer2Timer(Sender: TObject);
begin
  // Prüfen, ob MEVP.DLL gefunden werden kann:
  if FileExists(mevpdir.Text) then
  begin
    mevpdir.Color:=$00C1FFC1;
    Label63.Visible:=false;
  end else
  begin
    mevpdir.Color:=$00B9B9FF;
    Label63.Visible:=true;
  end;
end;

procedure TOptionenBox.MevpUseThreadClick(Sender: TObject);
begin
  GroupBox15.Enabled := MevpUseThread.Checked;
end;

procedure TOptionenBox.MevpThreadPriorityChange(Sender: TObject);
begin
  case MevpThreadPriority.Position of
    0: begin MevpThreadPriorityLabel.Caption:=_('Leerlauf'); end;
    1: begin MevpThreadPriorityLabel.Caption:=_('Niedriger'); end;
    2: begin MevpThreadPriorityLabel.Caption:=_('Normal'); end;
    3: begin MevpThreadPriorityLabel.Caption:=_('Höher'); end;
    4: begin MevpThreadPriorityLabel.Caption:=_('Hoch'); end;
    5: begin MevpThreadPriorityLabel.Caption:=_('Echtzeit'); end;
  end;
  if MevpThreadPriority.Position=5 then
  begin
    MevpThreadPriorityLabel.Font.Style:=[fsBold];
    MevpThreadPriorityLabel.Font.Color:=clRed;
  end else
  begin
    MevpThreadPriorityLabel.Font.Style:=[];
    MevpThreadPriorityLabel.Font.Color:=clBlack;
  end;
end;

end.


