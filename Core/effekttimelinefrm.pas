unit effekttimelinefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, PngBitBtn, Grids, ExtCtrls, gnugettext;

const
  {$I GlobaleKonstanten.inc} // maximale Kanalzahl für PC_DIMMER !Vorsicht! Bei Ändern des Wertes müssen einzelne Plugins und Forms ebenfalls verändert werden, da dort auch chan gesetzt wird! Auch die GUI muss angepasst werden

type
  TTimeline = record
               Name: string[255];
               value : array of array[1..chan] of Word;
               fadetime : array of array[1..chan] of integer;
               delay : array of array[1..chan] of integer;
               checked : array[1..chan] of boolean;
               steps : Word;
               blendzeit:Cardinal;
               blitzfunktion:boolean;
               blitzzeit:Word;
               pendeln:boolean;
               zufall:boolean;
              end;

  Teffekttimelineform = class(TForm)
    timeline_blitztimer: TTimer;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    effektgrid: TStringGrid;
    outputdevicescrollbar: TScrollBar;
    Label21: TLabel;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    timeline_steps: TEdit;
    timeline_scrollbar: TScrollBar;
    GroupBox3: TGroupBox;
    Label16: TLabel;
    timeline_zufall: TCheckBox;
    timeline_pendelnchk: TCheckBox;
    timeline_blitz: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    PngBitBtn1: TPngBitBtn;
    Label22: TLabel;
    Shape4: TShape;
    Shape1: TShape;
    procedure timeline_scrollbarChange(Sender: TObject);
    procedure timeline_zufallMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure timeline_blitzMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1Change(Sender: TObject);
    procedure timeline_pendelnchkMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure timeline_stepsChange(Sender: TObject);
    procedure effektgridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure effektgridGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure effektgridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure effektgridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure effektgridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure effekttimelineaktualisieren(Sender: TObject);
    procedure timeline_blitztimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure outputdevicescrollbarScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure outputdevicescrollbarEnter(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    timeline_backwards:boolean;
    outputdevice:integer;
  public
    { Public-Deklarationen }
    Effekttimeline : TTimeline;
  end;

var
  effekttimelineform: Teffekttimelineform;

implementation

uses PCDIMMER, effektsequenzerfrm;

{$R *.dfm}

procedure Teffekttimelineform.timeline_scrollbarChange(Sender: TObject);
var
	i,percent,fadetime:integer;
begin
  label10.Caption:=inttostr(timeline_scrollbar.position+1);

// Hardwareausgabe der Faderwerte
  for i:=1 to mainform.lastchan do
  begin
    if Effekttimeline.checked[i] then
    begin
      percent:=maxres-round((Effekttimeline.value[timeline_scrollbar.Position][i]*maxres)/100);
      mainform.data.ch[i]:=percent;
      if Effekttimeline.fadetime[timeline_scrollbar.Position][i]=-1 then
        fadetime:=Effekttimeline.blendzeit
      else
        fadetime:=Effekttimeline.fadetime[timeline_scrollbar.Position][i];
      mainform.senddata(i, 255-mainform.channel_value[i], percent, fadetime, Effekttimeline.delay[timeline_scrollbar.Position][i]);
    end;
  end;
  effekttimelineaktualisieren(Sender);
end;

procedure Teffekttimelineform.timeline_zufallMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Effekttimeline.zufall:=timeline_zufall.Checked;
end;

procedure Teffekttimelineform.timeline_blitzMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edit1.Enabled:=timeline_blitz.Checked;
  Effekttimeline.blitzfunktion:=timeline_blitz.Checked;
end;

procedure Teffekttimelineform.Edit1Change(Sender: TObject);
var
	s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  if (Edit1.Text<>'') then
	begin
  	timeline_blitztimer.Interval:=strtoint(edit1.text);
    Effekttimeline.blitzzeit:=strtoint(edit1.Text);
  end;
end;

procedure Teffekttimelineform.timeline_pendelnchkMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if timeline_backwards then
    timeline_scrollbar.Position:=1;
  Effekttimeline.pendeln:=timeline_pendelnchk.Checked;
end;

procedure Teffekttimelineform.timeline_stepsChange(Sender: TObject);
var
  s:string;
  i,j,startposition,steps:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  if (timeline_steps.Text<>'') then
  begin
    steps:=strtoint(timeline_steps.text);
    if (steps<1) then
      timeline_steps.text:='1';
    timeline_scrollbar.Max:=strtoint(timeline_steps.text)-1;
    Effekttimeline.steps:=strtoint(timeline_steps.text);

    startposition:=length(Effekttimeline.fadetime);

    setlength(Effekttimeline.value,strtoint(timeline_steps.text));
    setlength(Effekttimeline.delay,strtoint(timeline_steps.text));
    setlength(Effekttimeline.fadetime,strtoint(timeline_steps.text));

    for i:=startposition to length(Effekttimeline.fadetime)-1 do
    begin
      for j:=1 to mainform.lastchan do
      begin
        Effekttimeline.fadetime[i][j]:=-1;
        Effekttimeline.delay[i][j]:=-1;
      end;
    end;
  end;
end;

procedure Teffekttimelineform.effektgridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
	AOffSet : TPoint;
	AHaken1 : TPoint;
	AHaken2 : TPoint;
	AHaken3 : TPoint;
	ARect : TRect;
  offset:integer;
begin
  with effektgrid.Canvas do
  begin
    Brush.Color := clGradientInactiveCaption;
    FillRect(Rect);

    if (ACol = 0) or (ACol = 5) or (ACol = 10) or (ACol = 15) then
    begin
      offset:=1;
      case ACol of
        0: offset:=1;
        5: offset:=9;
        10: offset:=17;
        15: offset:=25;
      end;
      //Kasten zeichnen
      AOffSet.X := (Rect.Right - Rect.Left - 11) div 2;
      AOffSet.Y := (Rect.Bottom - Rect.Top - 11) div 2;

      ARect.Left := AOffSet.X + Rect.Left;
      ARect.Top := AOffSet.Y + Rect.Top;
      ARect.Right := AOffSet.X + Rect.Left + 11;
      ARect.Bottom := AOffSet.Y + Rect.Top + 11;

      Pen.Color := clGray;
      Brush.Color := clWhite;
      Rectangle(ARect);

      // Abfrage ob Haken zeichnen oder nicht
      if Effekttimeline.checked[ARow+outputdevice+offset] then
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
    TextOut(Rect.Left, Rect.Top, effektgrid.Cells[ACol, ARow]);
  end;
end;

procedure Teffekttimelineform.effektgridGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  if (ACol=0) or (ACol=5) or (ACol=10) or (ACol=15) then effektgrid.EditorMode:=false else effektgrid.EditorMode:=true;
end;

procedure Teffekttimelineform.effektgridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
  begin
    effekttimelineaktualisieren(nil);
    timeline_scrollbarChange(Sender);
  end;
end;

procedure Teffekttimelineform.effektgridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
	offset:integer;
begin
  //0,5,10,15=Checkbox  //1,6,11,16=Name //2,7,12,17=Wert //3,8,13,18=Fadetime //4,9,14,19=Delay

  offset:=0;

  // Name
  if (((effektgrid.Col=1) or (effektgrid.Col=6) or (effektgrid.Col=11) or (effektgrid.Col=16))) then
  begin
    case effektgrid.col of
      1: offset:=1;
      4: offset:=9;
      7: offset:=17;
      10: offset:=25;
    end;
    mainform.data.Names[effektgrid.Row+outputdevice+offset]:=effektgrid.Cells[effektgrid.Col,effektgrid.row];
  end;

  // Wert
  if (((effektgrid.Col=2) or (effektgrid.Col=7) or (effektgrid.Col=12) or (effektgrid.Col=17))) then
  begin
    try
      if strtoint(effektgrid.Cells[effektgrid.Col,effektgrid.Row])>100 then
        effektgrid.Cells[effektgrid.Col,effektgrid.Row]:='100';
      if strtoint(effektgrid.Cells[effektgrid.Col,effektgrid.Row])<0 then
        effektgrid.Cells[effektgrid.Col,effektgrid.Row]:='0';
    except
      effektgrid.Cells[effektgrid.Col,effektgrid.Row]:='0';
    end;
    case effektgrid.col of
      2: offset:=1;
      6: offset:=9;
      11: offset:=17;
      16: offset:=25;
    end;
    if (effektgrid.Cells[effektgrid.Col,effektgrid.Row]<>'-') and (effektgrid.Cells[effektgrid.Col,effektgrid.Row]<>'') then
      Effekttimeline.value[timeline_scrollbar.Position][effektgrid.Row+outputdevice+offset]:=strtoint(effektgrid.Cells[effektgrid.Col,effektgrid.Row]);
  end;

  // Fadetime
  if (((effektgrid.Col=3) or (effektgrid.Col=8) or (effektgrid.Col=13) or (effektgrid.Col=18))) then
  begin
    case effektgrid.col of
      3: offset:=1;
      8: offset:=9;
      13: offset:=17;
      18: offset:=25;
    end;
    if (effektgrid.Cells[effektgrid.Col,effektgrid.Row]<>'-') and (effektgrid.Cells[effektgrid.Col,effektgrid.Row]<>'') then
      Effekttimeline.fadetime[timeline_scrollbar.Position][effektgrid.Row+outputdevice+offset]:=strtoint(effektgrid.Cells[effektgrid.Col,effektgrid.Row]);
  end;

  // Delay
  if (((effektgrid.Col=4) or (effektgrid.Col=9) or (effektgrid.Col=14) or (effektgrid.Col=19))) then
  begin
    case effektgrid.col of
      4: offset:=1;
      9: offset:=9;
      14: offset:=17;
      19: offset:=25;
    end;
    if (effektgrid.Cells[effektgrid.Col,effektgrid.Row]<>'-') and (effektgrid.Cells[effektgrid.Col,effektgrid.Row]<>'') then
      Effekttimeline.delay[timeline_scrollbar.Position][effektgrid.Row+outputdevice+offset]:=strtoint(effektgrid.Cells[effektgrid.Col,effektgrid.Row]);
  end;

  if key=vk_return then
    effekttimelineaktualisieren(nil);
end;

procedure Teffekttimelineform.effektgridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
	i:integer;
  allchecked:boolean;
  offset:integer;
begin
  if (effektgrid.Col=0) or (effektgrid.col=5) or (effektgrid.col=10) or (effektgrid.col=15) then
  begin
    offset:=1;
  	case effektgrid.col of
	    0: offset:=1;
	    5: offset:=9;
	    10: offset:=17;
	    15: offset:=25;
    end;

  	if Shift=[ssCtrl] then
    begin
    	for i:=1 to chan do
      	Effekttimeline.checked[i]:=true;
    end else if Shift=[ssAlt] then
    begin
    	for i:=1 to chan do
      	Effekttimeline.checked[i]:=false;
    end else if (Button=mbRight) then
    begin
     	allchecked:=true;
        for i:=0 to 7 do
          if not Effekttimeline.checked[i+outputdevice+offset] then
          begin
            Effekttimeline.checked[i+outputdevice+offset]:=true;
          	allchecked:=false;
          end;

	      if allchecked then
	  	    for i:=0 to 7 do
	    	  	Effekttimeline.checked[i+outputdevice+offset]:=false;
    end else
  	begin
			Effekttimeline.checked[effektgrid.Row+outputdevice+offset]:=not Effekttimeline.checked[effektgrid.Row+outputdevice+offset];
	  end;

		effektgrid.Refresh;
	  timeline_scrollbarChange(Sender);
  end;
end;

procedure Teffekttimelineform.PngBitBtn1Click(Sender: TObject);
var
  i,k,l,m,vorhanden:integer;
  isblitz:boolean;
begin
  setlength(mainform.effektsequenzereffekte,length(mainform.effektsequenzereffekte)+1);
  CreateGUID(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].ID);
  mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Name:=_('Neuer Effekt (')+inttostr(length(mainform.effektsequenzereffekte))+')';
  setlength(mainform.AktuellerEffekt,length(mainform.AktuellerEffekt)+1);
  mainform.AktuellerEffekt[length(mainform.AktuellerEffekt)-1].Aktiv:=false;

  if Effekttimeline.blitzfunktion then
  begin
    setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte,Effekttimeline.steps*2);
    mainform.AktuellerEffekt[length(mainform.AktuellerEffekt)-1].AnzahlderSchritte:=Effekttimeline.steps*2;
  end else
  begin
    setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte,Effekttimeline.steps);
    mainform.AktuellerEffekt[length(mainform.AktuellerEffekt)-1].AnzahlderSchritte:=Effekttimeline.steps;
  end;
  mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].AnzahlderDurchlaufe:=1;
  mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Repeating:=true;
  mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].intensitaet:=255;
  mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].speed:=128;

  if Effekttimeline.pendeln then
    mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].modus:=2
  else if Effekttimeline.zufall then
    mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].modus:=3;

  isblitz:=false;
  for i:=0 to length(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].effektschritte)-1 do
  begin
    if not isblitz then
    begin
      // Geräteszene generieren
      for m:=0 to length(mainform.devices)-1 do
      begin
        for l:=0 to mainform.devices[m].MaxChan-1 do
        begin
          if Effekttimeline.checked[(mainform.devices[m].Startaddress+l)] then
          begin
            // Gerät besitzt Kanal, welcher aufgenommen werden soll
            // Testen, ob Gerät nicht schon vorhanden
            vorhanden:=-1;
            for k:=0 to length(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices)-1 do
            begin
              if IsEqualGUID(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[k].ID,mainform.devices[m].ID) then
              begin
                vorhanden:=k;
                break;
              end;
            end;
            if vorhanden=-1 then
            begin
              setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices,length(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices)+1);
              vorhanden:=length(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices)-1;
              setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanActive,mainform.devices[m].MaxChan);
              setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanValue,mainform.devices[m].MaxChan);
              setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanDelay,mainform.devices[m].MaxChan);
              setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanFadetime,mainform.devices[m].MaxChan);
            end;
            mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ID:=mainform.devices[m].ID;
            mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanActive[l]:=true;
            if Effekttimeline.blitzfunktion then
            begin
              mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanValue[l]:=round(Effekttimeline.value[(i div 2)][(mainform.devices[m].Startaddress+l)]*255/100);
              mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanDelay[l]:=Effekttimeline.Delay[(i div 2)][(mainform.devices[m].Startaddress+l)];
              mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanFadetime[l]:=Effekttimeline.Fadetime[(i div 2)][(mainform.devices[m].Startaddress+l)];
            end else
            begin
              mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanValue[l]:=round(Effekttimeline.value[i][(mainform.devices[m].Startaddress+l)]*255/100);
              mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanDelay[l]:=Effekttimeline.Delay[i][(mainform.devices[m].Startaddress+l)];
              mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanFadetime[l]:=Effekttimeline.Fadetime[i][(mainform.devices[m].Startaddress+l)];
            end;
          end;
        end;
      end;

      if Effekttimeline.blitzfunktion then
      begin
        mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].Name:=_('Schritt (')+inttostr((i div 2)+1)+')';
        mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].wartezeit:=Effekttimeline.blitzzeit;
        mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].ActivateTimecontrol:=true;
      end else
      begin
        mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].Name:=_('Schritt (')+inttostr(i+1)+')';
        mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].wartezeit:=Effekttimeline.blendzeit;
      end;
      mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].Typ:=0;
      mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].einblendzeit:=Effekttimeline.blendzeit;

      if mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].wartezeit<10 then
        mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].wartezeit:=1000;
    end else
    begin
      // Geräteszene generieren
      for m:=0 to length(mainform.devices)-1 do
      begin
        for l:=0 to mainform.devices[m].MaxChan-1 do
        begin
          if Effekttimeline.checked[(mainform.devices[m].Startaddress+l)] then
          begin
            // Gerät besitzt Kanal, welcher aufgenommen werden soll
            // Testen, ob Gerät nicht schon vorhanden
            vorhanden:=-1;
            for k:=0 to length(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices)-1 do
            begin
              if IsEqualGUID(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[k].ID,mainform.devices[m].ID) then
              begin
                vorhanden:=k;
                break;
              end;
            end;
            if vorhanden=-1 then
            begin
              setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices,length(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices)+1);
              vorhanden:=length(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices)-1;
              setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanActive,mainform.devices[m].MaxChan);
              setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanValue,mainform.devices[m].MaxChan);
              setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanDelay,mainform.devices[m].MaxChan);
              setlength(mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanFadetime,mainform.devices[m].MaxChan);
            end;
            mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ID:=mainform.devices[m].ID;
            mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanActive[l]:=true;
            mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanValue[l]:=0;
            mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanDelay[l]:=0;
            mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].devices[vorhanden].ChanFadetime[l]:=-1;
          end;
        end;
      end;
      mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].Name:=_('Aus');
      mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].Typ:=0;
      mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].einblendzeit:=0;
      mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].wartezeit:=abs(Effekttimeline.blendzeit-Effekttimeline.blitzzeit);
      if mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].wartezeit<10 then
        mainform.effektsequenzereffekte[length(mainform.effektsequenzereffekte)-1].Effektschritte[i].wartezeit:=1000;
    end;

    if Effekttimeline.blitzfunktion then
      isblitz:=not isblitz;
  end;
  effektsequenzer.RefreshTreeView;
  effektsequenzer.Show;
end;

procedure Teffekttimelineform.effekttimelineaktualisieren(Sender: TObject);
var
	i:integer;
begin
  for i:=1 to 8 do
  begin
    effektgrid.Cells[1,i-1]:=mainform.data.names[i+outputdevice];
	    effektgrid.Cells[2,i-1]:=inttostr((Effekttimeline.value[timeline_scrollbar.Position][i+outputdevice]));
	    effektgrid.Cells[3,i-1]:=inttostr((Effekttimeline.fadetime[timeline_scrollbar.Position][i+outputdevice]));
	    effektgrid.Cells[4,i-1]:=inttostr((Effekttimeline.delay[timeline_scrollbar.Position][i+outputdevice]));
    effektgrid.Cells[6,i-1]:=mainform.data.names[i+outputdevice+8];
	    effektgrid.Cells[7,i-1]:=inttostr((Effekttimeline.value[timeline_scrollbar.Position][i+outputdevice+8]));
	    effektgrid.Cells[8,i-1]:=inttostr((Effekttimeline.fadetime[timeline_scrollbar.Position][i+outputdevice+8]));
	    effektgrid.Cells[9,i-1]:=inttostr((Effekttimeline.delay[timeline_scrollbar.Position][i+outputdevice+8]));
    effektgrid.Cells[11,i-1]:=mainform.data.names[i+outputdevice+16];
	    effektgrid.Cells[12,i-1]:=inttostr((Effekttimeline.value[timeline_scrollbar.Position][i+outputdevice+16]));
	    effektgrid.Cells[13,i-1]:=inttostr((Effekttimeline.fadetime[timeline_scrollbar.Position][i+outputdevice+16]));
	    effektgrid.Cells[14,i-1]:=inttostr((Effekttimeline.delay[timeline_scrollbar.Position][i+outputdevice+16]));
    effektgrid.Cells[16,i-1]:=mainform.data.names[i+outputdevice+24];
	    effektgrid.Cells[17,i-1]:=inttostr((Effekttimeline.value[timeline_scrollbar.Position][i+outputdevice+24]));
	    effektgrid.Cells[18,i-1]:=inttostr((Effekttimeline.fadetime[timeline_scrollbar.Position][i+outputdevice+24]));
	    effektgrid.Cells[19,i-1]:=inttostr((Effekttimeline.delay[timeline_scrollbar.Position][i+outputdevice+24]));
  end;
  Effektgrid.Refresh;
end;

procedure Teffekttimelineform.timeline_blitztimerTimer(Sender: TObject);
var
	i:integer;
begin
  timeline_blitztimer.Enabled:=false;

  label10.Caption:=inttostr(timeline_scrollbar.position)+_(' - Off');

// Hardwareausgabe der Faderwerte
  for i:=1 to mainform.lastchan do
  begin
    if Effekttimeline.checked[i] then
      begin
        mainform.data.ch[i]:=255;
        mainform.senddata(i,255,255,0);
      end;
  end;
  effekttimelineaktualisieren(Sender);
end;

procedure Teffekttimelineform.FormCreate(Sender: TObject);
var
  i,j:integer;
begin
  TranslateComponent(self);

	effektgrid.ColWidths[0]:=15;
	effektgrid.ColWidths[1]:=89;
	effektgrid.ColWidths[2]:=28;
	effektgrid.ColWidths[3]:=28;
	effektgrid.ColWidths[4]:=28;

	effektgrid.ColWidths[5]:=15;
	effektgrid.ColWidths[6]:=89;
	effektgrid.ColWidths[7]:=28;
	effektgrid.ColWidths[8]:=28;
	effektgrid.ColWidths[9]:=28;

	effektgrid.ColWidths[10]:=15;
	effektgrid.ColWidths[11]:=89;
	effektgrid.ColWidths[12]:=28;
	effektgrid.ColWidths[13]:=28;
	effektgrid.ColWidths[14]:=28;

	effektgrid.ColWidths[15]:=15;
	effektgrid.ColWidths[16]:=89;
	effektgrid.ColWidths[17]:=28;
	effektgrid.ColWidths[18]:=28;
	effektgrid.ColWidths[19]:=28;

  outputdevice:=0;
  setlength(Effekttimeline.value, 4);
  setlength(Effekttimeline.fadetime, 4);
  setlength(Effekttimeline.delay, 4);

  for i:=0 to length(Effekttimeline.fadetime)-1 do
    for j:=1 to mainform.lastchan do
      Effekttimeline.fadetime[i][j]:=-1;
  for i:=0 to length(Effekttimeline.delay)-1 do
    for j:=1 to mainform.lastchan do
      Effekttimeline.delay[i][j]:=-1;

  Effekttimeline.steps:=strtoint(timeline_steps.text);
  Effekttimeline.blendzeit:=1000;
  effekttimelineaktualisieren(nil);
end;

procedure Teffekttimelineform.outputdevicescrollbarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  outputdevicescrollbar.Max:=mainform.lastchan-32;

  outputdevice:=outputdevicescrollbar.position;
  effekttimelineaktualisieren(Sender);
end;

procedure Teffekttimelineform.outputdevicescrollbarEnter(Sender: TObject);
begin
  outputdevicescrollbar.Max:=mainform.lastchan-32;
end;

procedure Teffekttimelineform.Edit2Change(Sender: TObject);
var
	s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  if (Edit2.Text<>'') then
	begin
    Effekttimeline.blendzeit:=strtoint(edit2.Text);
  end;
end;

procedure Teffekttimelineform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Teffekttimelineform.CreateParams(var Params:TCreateParams);
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
