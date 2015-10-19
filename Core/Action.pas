unit Action;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, Tabnotbk, Mask, Grids, Dialogs, gnugettext;

const
  {$I GlobaleKonstanten.inc}
  optWait=1;
  optSwitch=2;
  optFade=3;
  optSync=4;

type
  TSCRIPTAction = record
              option : integer;
              ch : array[1..chan] of boolean;
              wait : longint;
              svalue : integer;
              evalue : integer;
              fadetime : longint;
              sync : integer;
            end;
  TActionDlg = class(TForm)
    Notebook1: TNotebook;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Edit7: TEdit;
    OkBtn: TButton;
    Edit5: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit6: TEdit;
    Edit10: TEdit;
    WaitButton: TButton;
    SwitchButton: TButton;
    FadeButton: TButton;
    CancelBtn: TButton;
    BackButton: TButton;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    SyncButton: TButton;
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    RadioGroup1: TRadioGroup;
    waitbutton2: TButton;
    switchbutton2: TButton;
    fadebutton2: TButton;
    syncbutton2: TButton;
    Bevel1: TBevel;
    hinweisbtn: TButton;
    JumpToChannelLbl: TLabel;
    JumpToChannel: TEdit;
    procedure ActionButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure Edit10Change(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure Edit7Exit(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
    procedure Edit9Exit(Sender: TObject);
    procedure Edit10Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure hinweisbtnClick(Sender: TObject);
    procedure JumpToChannelKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private declarations }
    procedure input_number(var pos:integer; var s:string);
    procedure input_number_minus(var pos:integer; var s:string);
  public
    { Public declarations }
    Faction: Tscriptaction;
    Procedure CheckChannels;
    Procedure Reset;
    Procedure EditMode;
    Function Execute : boolean;
    property action: Tscriptaction read Faction write Faction;
  end;

var
  ActionDlg: TActionDlg;
  device:integer;

implementation

{$R *.DFM}

uses
	pcdimmer;

procedure TActionDlg.CheckChannels;
var i:integer;
    ok:boolean;
begin
  if not syncbutton2.Enabled then ok:=true else ok:=false;
  for i:=1 to mainform.lastchan do
    if action.ch[i] then ok:=true;

  OkBtn.enabled:=ok;
end;

procedure TActionDlg.Reset;
var
  i: integer;
begin
  notebook1.pageindex:=0;
  Faction.option:=0;
  for i:=1 to 10 do
    TEdit(FindComponent('edit'+inttostr(i))).Text:='0';
  radiogroup1.itemindex:=0;
  for i:=1 to mainform.lastchan do Faction.ch[i]:=false;
end;

procedure TActionDlg.EditMode;
begin
  with Faction do
    begin
      if option=optWait then
        begin
          edit1.text:=inttostr(wait div 360000); wait:=wait mod 360000;
          edit2.text:=inttostr(wait div 6000); wait:=wait mod 6000;
          edit3.text:=inttostr(wait div 100); wait:=wait mod 100;
          edit4.text:=inttostr(wait*10);
          ActionButtonClick(WaitButton);
        end;
      if option=optSwitch then
        begin
          edit5.text:=inttostr(svalue);
          ActionButtonClick(SwitchButton);
        end;
      if option=optFade then
        begin
          edit5.text:=inttostr(svalue);
          edit6.text:=inttostr(evalue);
          edit7.text:=inttostr(fadetime div 360000); fadetime:=fadetime mod 360000;
          edit8.text:=inttostr(fadetime div 6000); fadetime:=fadetime mod 6000;
          edit9.text:=inttostr(fadetime div 100); fadetime:=fadetime mod 100;
          edit10.text:=inttostr(fadetime*10);
          ActionButtonClick(FadeButton);
        end;
      if option=optSync then
        begin
          radiogroup1.itemindex:=action.sync-1;
          ActionButtonClick(SyncButton);
        end;
    end;
end;

function TActionDlg.execute : boolean;
begin
  if showmodal=mrOK then
    begin
      with Faction do
        begin
          if option=optWait then
            begin
              wait:=(strtoint(edit1.text)*3600)+(strtoint(edit2.text)*60)+
                    (strtoint(edit3.text));
              wait:=wait*100;
              wait:=wait+round(strtoint(edit4.text) / 10);
            end;
          if option=optSwitch then
            begin
              svalue:=strtoint(edit5.text);
            end;
          if option=optFade then
            begin
              svalue:=strtoint(edit5.text);
              evalue:=strtoint(edit6.text);
              fadetime:=(strtoint(edit7.text)*3600)+(strtoint(edit8.text)*60)+
                        (strtoint(edit9.text));
              fadetime:=fadetime*100;
              fadetime:=fadetime+round(strtoint(edit10.text) / 10);
            end;
          if option=optSync then
            begin
              sync:=radiogroup1.itemindex+1;
            end;
        end;
      result:=true;
    end
  else
    result:=false;
end;

procedure TActionDlg.ActionButtonClick(Sender: TObject);
begin
  waitbutton2.enabled:=true;
  switchbutton2.enabled:=true;
  fadebutton2.enabled:=true;
  syncbutton2.enabled:=true;

  notebook1.pageindex:=1;
  if ((sender=Waitbutton) or (Sender=WaitButton2)) then
    begin
      Hinweisbtn.Visible:=true;
      waitbutton2.Enabled:=false;
      Faction.option:=optWait;
      groupbox3.visible:=true;
      groupbox4.visible:=false;
      groupbox5.visible:=false;
      StringGrid1.visible:=true;
      RadioGroup1.Visible:=false;
			CheckChannels;
    end;
  if ((sender=SwitchButton) or (Sender=SwitchButton2)) then
    begin
      Hinweisbtn.Visible:=false;
      switchbutton2.Enabled:=false;
      Faction.option:=optSwitch;
      groupbox3.visible:=false;
      groupbox4.visible:=true;
      groupbox5.visible:=false;
      groupbox4.left:=240;
      groupbox4.top:=8;
      groupbox4.caption:=_(' Neuer Wert');
      edit6.visible:=false;
      edit5.width:=153;
      edit5.hint:='';
      StringGrid1.visible:=true;
      RadioGroup1.Visible:=false;
			CheckChannels;
    end;
  if ((sender=FadeButton) or (Sender=FadeButton2)) then
    begin
      Hinweisbtn.Visible:=true;
      fadebutton2.Enabled:=false;
      Faction.option:=optFade;
      groupbox3.visible:=false;
      groupbox4.visible:=true;
      groupbox5.visible:=true;
      groupbox4.left:=240;
      groupbox4.top:=8;
      groupbox5.left:=240;
      groupbox5.top:=64;
      groupbox4.caption:=_(' Start- und Endwert (von:bis)');
      edit6.visible:=true;
      edit5.width:=73;
      edit5.hint:=_('Startwert in % bzw. -1 für aktuellen Wert');
      StringGrid1.visible:=true;
      RadioGroup1.Visible:=false;
			CheckChannels;
    end;
  if ((sender=SyncButton) or (Sender=SyncButton2)) then
    begin
      Hinweisbtn.Visible:=false;
      groupbox3.visible:=false;
      groupbox4.visible:=false;
      groupbox5.visible:=false;
      RadioGroup1.Visible:=true;
      syncbutton2.Enabled:=false;
      Faction.option:=optSync;
      StringGrid1.visible:=false;
      OkBtn.Enabled:=true;
    end;
  JumpToChannel.Visible:=StringGrid1.visible;
  JumpToChannelLbl.visible:=StringGrid1.visible;
end;

procedure TActionDlg.FormShow(Sender: TObject);
begin
//  waitbutton2.Visible:=false;
//  switchbutton2.Visible:=false;
//  fadebutton2.Visible:=false;
//  syncbutton2.Visible:=false;
//  Bevel1.Visible:=false;
  CheckChannels;
end;

procedure TActionDlg.input_number(var pos:integer; var s:string);
var
  i:integer;
begin
  i:=1;
  while i<=length(s) do
    begin
      if (s[i]<'0') or (s[i]>'9') then
        begin delete(s,i,1); dec(pos); end
      else
        inc(i);
    end;
end;

procedure TActionDlg.input_number_minus(var pos:integer; var s:string);
var
  i:integer;
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


procedure TActionDlg.Edit1Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=edit1.text;
  i:=edit1.selstart;
  input_number(i,s);
  edit1.text:=s;
  edit1.selstart:=i;
end;

procedure TActionDlg.Edit2Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=edit2.text;
  i:=edit2.selstart;
  input_number(i,s);
  edit2.text:=s;
  edit2.selstart:=i;
end;

procedure TActionDlg.Edit3Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=edit3.text;
  i:=edit3.selstart;
  input_number(i,s);
  edit3.text:=s;
  edit3.selstart:=i;
end;

procedure TActionDlg.Edit4Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=edit4.text;
  i:=edit4.selstart;
  input_number(i,s);
  edit4.text:=s;
  edit4.selstart:=i;
end;

procedure TActionDlg.Edit5Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=edit5.text;
  i:=edit5.selstart;
  input_number_minus(i,s);
  edit5.text:=s;
  edit5.selstart:=i;
end;

procedure TActionDlg.Edit6Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=edit6.text;
  i:=edit6.selstart;
  input_number(i,s);
  edit6.text:=s;
  edit6.selstart:=i;
end;

procedure TActionDlg.Edit7Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=edit7.text;
  i:=edit7.selstart;
  input_number(i,s);
  edit7.text:=s;
  edit7.selstart:=i;
end;

procedure TActionDlg.Edit8Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=edit8.text;
  i:=edit8.selstart;
  input_number(i,s);
  edit8.text:=s;
  edit8.selstart:=i;
end;

procedure TActionDlg.Edit9Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=edit9.text;
  i:=edit9.selstart;
  input_number(i,s);
  edit9.text:=s;
  edit9.selstart:=i;
end;

procedure TActionDlg.Edit10Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=edit10.text;
  i:=edit10.selstart;
  input_number(i,s);
  edit10.text:=s;
  edit10.selstart:=i;
end;

procedure TActionDlg.Edit1Exit(Sender: TObject);
var
  s:string;
begin
  s:=edit1.text;
  if s='' then s:=inttostr(0);
  if strtoint(s)>23 then s:=inttostr(23);
  edit1.text:=s;
end;

procedure TActionDlg.Edit2Exit(Sender: TObject);
var
  s:string;
begin
  s:=edit2.text;
  if s='' then s:=inttostr(0);
  if strtoint(s)>59 then s:=inttostr(59);
  edit2.text:=s;
end;

procedure TActionDlg.Edit3Exit(Sender: TObject);
var
  s:string;
begin
  s:=edit3.text;
  if s='' then s:=inttostr(0);
  if strtoint(s)>59 then s:=inttostr(59);
  edit3.text:=s;
end;

procedure TActionDlg.Edit4Exit(Sender: TObject);
var
  s:string;
begin
  s:=edit4.text;
  if s='' then s:=inttostr(0);
  if strtoint(s)>999 then s:=inttostr(999);
  edit4.text:=s;
end;

procedure TActionDlg.Edit5Exit(Sender: TObject);
var
  s:string;
begin
  s:=edit5.text;
  if s='' then s:=inttostr(0);
  if strtoint(s)>100 then s:=inttostr(100);
  edit5.text:=s;
end;

procedure TActionDlg.Edit6Exit(Sender: TObject);
var
  s:string;
begin
  s:=edit6.text;
  if s='' then s:=inttostr(0);
  if strtoint(s)>100 then s:=inttostr(100);
  edit6.text:=s;
end;

procedure TActionDlg.Edit7Exit(Sender: TObject);
var
  s:string;
begin
  s:=edit7.text;
  if s='' then s:=inttostr(0);
  if strtoint(s)>4 then s:=inttostr(4);
  edit7.text:=s;
end;

procedure TActionDlg.Edit8Exit(Sender: TObject);
var
  s:string;
begin
  s:=edit8.text;
  if s='' then s:=inttostr(0);
  if strtoint(s)>59 then s:=inttostr(59);
  edit8.text:=s;
end;

procedure TActionDlg.Edit9Exit(Sender: TObject);
var
  s:string;
begin
  s:=edit9.text;
  if s='' then s:=inttostr(0);
  if strtoint(s)>59 then s:=inttostr(59);
  edit9.text:=s;
end;

procedure TActionDlg.Edit10Exit(Sender: TObject);
var
  s:string;
begin
  s:=edit10.text;
  if s='' then s:=inttostr(0);
  if strtoint(s)>999 then s:=inttostr(999);
  edit10.text:=s;
end;

procedure TActionDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_escape then backbutton.Click;
end;

procedure TActionDlg.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return then if okbtn.Enabled then okbtn.Click;
end;

procedure TActionDlg.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
	AOffSet : TPoint;
	AHaken1 : TPoint;
	AHaken2 : TPoint;
	AHaken3 : TPoint;
	ARect : TRect;
begin
with StringGrid1.Canvas do
begin
	if Rect.Top = 0 then
	begin
		Brush.Color := clBtnFace;
		FillRect(Rect);
		Pen.Color := clWhite;
		Rectangle(Rect);
		TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
		Exit;
	end;

	Brush.Color := clWhite;
	FillRect(Rect);

	if (ARow > 0) and (ACol = 0) then
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
    if ARow>0 then
    if action.ch[ARow] then
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

TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
end;
end;

procedure TActionDlg.StringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
var
	text:string;
begin
  if ACol=1 then
    text:=StringGrid1.Cells[ACol,ARow];

  if (ACol=0) or (ACol=1) then StringGrid1.EditorMode:=false else StringGrid1.EditorMode:=true;

  if ACol=1 then
    StringGrid1.Cells[ACol,ARow]:=text;
end;

procedure TActionDlg.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if stringgrid1.Col=3 then
  try
		if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])>100 then
    	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='100';
		if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<0 then
    	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='0';
  except
	  stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='0';
  end;

	if stringgrid1.Col=2 then
  begin
    mainform.data.Names[stringgrid1.row]:=stringgrid1.Cells[stringgrid1.Col,stringgrid1.row];
    mainform.pluginsaktualisieren(nil);
  end;
end;

procedure TActionDlg.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i,highest:integer;
  allchecked:boolean;
begin
  if StringGrid1.Col=0 then
  begin
  	if Shift=[ssCtrl] then
    begin
    	for i:=1 to mainform.lastchan do
      	Faction.ch[i]:=true;
    end else if Shift=[ssAlt] then
    begin
    	for i:=1 to mainform.lastchan do
      	Faction.ch[i]:=false;
    end else if Button=mbRight then
    begin
      i:=StringGrid1.Row-1;
    	repeat
        i:=i+1;
    	until (i mod 8 =0);
     	highest:=i;
     	allchecked:=true;
        for i:=highest-7 to highest do
          if not Faction.ch[i] then
          begin
            Faction.ch[i]:=true;
          	allchecked:=false;
          end;

	      if allchecked then
	  	    for i:=highest-7 to highest do
	    	  	Faction.ch[i]:=false;
    end else
  	begin
			Faction.ch[StringGrid1.Row]:=not action.ch[StringGrid1.Row];
	  end;

		StringGrid1.Refresh;
    CheckChannels;
  end;
end;

procedure TActionDlg.hinweisbtnClick(Sender: TObject);
begin
  ShowMessage(_('Bei einer Fade- bzw. Wartezeit von 0h 0min 0s 0ms wird automatisch die Beatzeit')+#13+_('des Temposliders der Effekttimeline, bzw. der Beat-Toolbox eingesetzt...')+#13+#13+_('Somit können taktgesteuerte Skriptabläufe und Einblendungen erzielt werden.'));
end;

procedure TActionDlg.JumpToChannelKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
  if (JumpToChannel.Text<>'') and (strtoint(JumpToChannel.Text)>0) and (strtoint(JumpToChannel.Text)<= mainform.lastchan) then
    StringGrid1.TopRow:=strtoint(JumpToChannel.Text);
end;

procedure TActionDlg.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure TActionDlg.CreateParams(var Params:TCreateParams);
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
