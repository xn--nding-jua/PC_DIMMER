unit insscene;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Buttons, gnugettext, pngimage,
  JvExControls, JvGradient;

const
  {$I GlobaleKonstanten.inc}

type
  Tinsscenedlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Szenenname: TLabeledEdit;
    scenefade_time: TEdit;
    scenefade_timelabel: TLabel;
    scenefade_time_min: TEdit;
    scenefade_time_h: TEdit;
    scenefade_time_msec: TEdit;
    a: TLabel;
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ListBox1: TListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    JumpToChannel: TEdit;
    Szenenbeschreibung: TLabeledEdit;
    ChangedChannels: TTimer;
    GroupBox2: TGroupBox;
    ListBox2: TListBox;
    Button3: TButton;
    GroupBox3: TGroupBox;
    refreshonlyactivechannels: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure SzenennameChange(Sender: TObject);
    procedure input_number(var pos:integer; var s:string);
    procedure SzenennameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure JumpToChannelKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure ChangedChannelsTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private declarations }
    resetchangedchannels:boolean;
  public
    { Public declarations }
    active:array[1..chan] of boolean;
  end;

var
  insscenedlg: Tinsscenedlg;

implementation

{$R *.dfm}

uses
	pcdimmer, masterfrm;

function levelstr(pos,max:integer):string;
begin
  result:='';
  case MainForm.levelanzeigeoptionen of
    0: result:=inttostr(round((pos*100) / max))+'%';
    1: result:=inttostr(round((pos*100) / max))+'.'+copy(inttostr((pos*100) mod max),0,1)+'%';
    2: result:=inttostr(pos);
  end;
end;

procedure Tinsscenedlg.SzenennameChange(Sender: TObject);
begin
  if length(Szenenname.Text)>0 then okbtn.Enabled:=true else okbtn.Enabled:=false;
  if length(Szenenname.Text)>255 then
  begin
    messagedlg(_('Sie können maximal 255 Zeichen eingeben'),mtWarning,[mbOK],0);
    Szenenname.Text:=copy(Szenenname.Text,0,255);
  end;
end;

procedure Tinsscenedlg.SzenennameKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 case key of
	 vk_return: if okbtn.Enabled then okbtn.Click;
	 vk_escape: cancelbtn.Click;
 end;
end;

procedure Tinsscenedlg.input_number(var pos:integer; var s:string);
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

procedure Tinsscenedlg.Edit1Change(Sender: TObject);
var
  i:integer;
  s:string;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

if length(TEdit(Sender).Text)>0 then
begin
if strtoint(scenefade_time_h.Text)>4 then scenefade_time_h.Text:='4';
if strtoint(scenefade_time_min.Text)>59 then scenefade_time_min.Text:='59';
if strtoint(scenefade_time.Text)>59 then scenefade_time.Text:='59';
if strtoint(scenefade_time_msec.Text)>999 then scenefade_time_msec.Text:='999';
end;
end;

procedure Tinsscenedlg.Edit1Exit(Sender: TObject);
begin
  if length(TEdit(Sender).Text)<=0 then TEdit(Sender).Text:='0';
end;

procedure Tinsscenedlg.StringGrid1DrawCell(Sender: TObject; ACol,
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

    if (ACol=Stringgrid1.Col) and (ARow=Stringgrid1.Row) then
    begin
      Brush.Color := clHighlight;
      Font.Color:=clHighlightText;
    end else
    begin
      Brush.Color := clWhite;
      Font.Color:=clWindowText;
    end;
    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);

    if (ARow>0) and (ACol = 0) then
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
      if (ARow>0) then
      if active[ARow] then
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

procedure Tinsscenedlg.StringGrid1MouseUp(Sender: TObject;
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
      	active[i]:=true;
    end else if Shift=[ssAlt] then
    begin
    	for i:=1 to mainform.lastchan do
      	active[i]:=false;
    end else if Button=mbRight then
    begin
      i:=StringGrid1.Row-1;
    	repeat
        i:=i+1;
    	until (i mod 8 =0);
     	highest:=i;
     	allchecked:=true;
        for i:=highest-7 to highest do
          if not active[i] then
          begin
            active[i]:=true;
          	allchecked:=false;
          end;

	      if allchecked then
	  	    for i:=highest-7 to highest do
	    	  	active[i]:=false;
    end else
  	begin
			active[StringGrid1.Row]:=not active[StringGrid1.Row];
	  end;

		StringGrid1.Refresh;
  end;
end;

procedure Tinsscenedlg.FormShow(Sender: TObject);
begin
  ChangedChannels.enabled:=true;
  resetchangedchannels:=false;
	stringgrid1.Cols[1].Strings[0]:=_('Kanal');
	stringgrid1.Cols[2].Strings[0]:=_('Kanalname');
	stringgrid1.Cols[3].Strings[0]:=_('Wert [%]');
	stringgrid1.Cols[4].Strings[0]:=_('Wert [Byte]');
  StringGrid1.Col:=1;
end;

procedure Tinsscenedlg.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if stringgrid1.Col=4 then
  try
		if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])>255 then
    	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='255';
		if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<0 then
    	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='0';
    stringgrid1.Cells[3,stringgrid1.Row]:=Inttostr(Round(strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])*100/255));
  except
	  stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='0';
  end;

  if stringgrid1.Col=3 then
  try
		if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])>100 then
    	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='100';
		if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<0 then
    	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='0';
    stringgrid1.Cells[4,stringgrid1.Row]:=Inttostr(Round(strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])*255/100));
  except
	  stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='0';
  end;

	if stringgrid1.Col=2 then
  begin
    mainform.data.Names[stringgrid1.row]:=stringgrid1.Cells[stringgrid1.Col,stringgrid1.row];
    mainform.pluginsaktualisieren(nil);
  end;
end;

procedure Tinsscenedlg.StringGrid1GetEditMask(Sender: TObject; ACol,
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

procedure Tinsscenedlg.SpeedButton2Click(Sender: TObject);
var
	i:integer;
begin
  If Opendialog1.Execute then
  begin
	  listbox1.Items.LoadFromFile(opendialog1.FileName);
		for i:=1 to StringGrid1.RowCount-1 do
	  begin
			if listbox1.Items.Strings[i]<>'-1' then
      begin
      	active[i]:=true;
	    	StringGrid1.Cells[3,i]:=inttostr(round((strtoint(listbox1.Items.Strings[i]))*100/255));
	    	StringGrid1.Cells[4,i]:=listbox1.Items.Strings[i];
      end else
      begin
      	active[i]:=false;
	    	StringGrid1.Cells[3,i]:='0';
	    	StringGrid1.Cells[4,i]:='0';
      end;
    end;
		StringGrid1.Refresh;
  end;
end;

procedure Tinsscenedlg.SpeedButton3Click(Sender: TObject);
var
	i:integer;
begin
  If Savedialog1.Execute then
  begin
    listbox1.Clear;
		for i:=1 to StringGrid1.RowCount-1 do
      if active[i] then
	  	begin
      	listbox1.Items.Add(StringGrid1.Cells[4,i]);
      end else
	  	begin
      	listbox1.Items.Add('-1');
      end;
	  listbox1.Items.Insert(0,inttostr(StringGrid1.RowCount-1));
	  listbox1.Items.SaveToFile(savedialog1.FileName);
  end;
end;

procedure Tinsscenedlg.SpeedButton1Click(Sender: TObject);
var
	i:integer;
begin
if messagedlg(_('Komplette Szene zurücksetzen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
	for i:=1 to StringGrid1.RowCount-1 do
	begin
   	active[i]:=false;
 		StringGrid1.Cells[3,i]:='0';
 		StringGrid1.Cells[4,i]:='0';
  end;
	StringGrid1.Refresh;
end;

procedure Tinsscenedlg.JumpToChannelKeyUp(Sender: TObject; var Key: Word;
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

procedure Tinsscenedlg.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tinsscenedlg.Button1Click(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to mainform.lastchan do
  begin
    if refreshonlyactivechannels.Checked then
    begin
      if active[i] then
      begin
        Stringgrid1.Cells[3,i]:=inttostr(round((255-mainform.data.ch[i])*100/255));
        Stringgrid1.Cells[4,i]:=inttostr(255-mainform.data.ch[i]);
      end;
    end else
    begin
      Stringgrid1.Cells[3,i]:=inttostr(round((255-mainform.data.ch[i])*100/255));
      Stringgrid1.Cells[4,i]:=inttostr(255-mainform.data.ch[i]);
    end;
  end;
end;

procedure Tinsscenedlg.Button2Click(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to mainform.lastchan do
    active[i]:=mainform.changedchannels[i];

  for i:=1 to mainform.lastchan do
  begin
    if refreshonlyactivechannels.Checked then
    begin
      if active[i] then
      begin
        Stringgrid1.Cells[3,i]:=inttostr(round((255-mainform.data.ch[i])*100/255));
        Stringgrid1.Cells[4,i]:=inttostr(255-mainform.data.ch[i]);
      end;
    end else
    begin
      Stringgrid1.Cells[3,i]:=inttostr(round((255-mainform.data.ch[i])*100/255));
      Stringgrid1.Cells[4,i]:=inttostr(255-mainform.data.ch[i]);
    end;
  end;

  resetchangedchannels:=true;
	StringGrid1.Refresh;
end;

procedure Tinsscenedlg.OKBtnClick(Sender: TObject);
var
  i:integer;
begin
  if resetchangedchannels then
    for i:=1 to mainform.lastchan do
      mainform.changedchannels[i]:=false;
end;

procedure Tinsscenedlg.ChangedChannelsTimer(Sender: TObject);
var
  i:integer;
begin
  if Listbox2.Focused then exit;

  LockWindow(Listbox2.Handle);
  Listbox2.Clear;
  for i:=1 to mainform.lastchan do
  begin
    if mainform.changedchannels[i] then
      Listbox2.Items.Add(_('Kanal ')+inttostr(i)+_(' auf ')+levelstr(round(((100-masterform.DimmerMaster.Position)/100)*(mainform.channel_value[i])),maxres));
  end;
  UnlockWindow(Listbox2.Handle);
end;

procedure Tinsscenedlg.Button3Click(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to mainform.lastchan do
    mainform.changedchannels[i]:=false;
  ChangedChannelsTimer(nil);
end;

procedure Tinsscenedlg.FormHide(Sender: TObject);
begin
  ChangedChannels.enabled:=false;
end;

procedure Tinsscenedlg.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tinsscenedlg.CreateParams(var Params:TCreateParams);
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
