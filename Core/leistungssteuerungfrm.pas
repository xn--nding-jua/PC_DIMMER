unit leistungssteuerungfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, XPMan, Math, Buttons, Grids, Registry,
  PngBitBtn, gnugettext;

const
  {$I GlobaleKonstanten.inc}

type
  Tleistungssteuerung = class(TForm)
    Label3: TLabel;
    Button1: TButton;
    XPManifest1: TXPManifest;
    leistung_l1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    leistung_l2: TEdit;
    leistung_l3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    GroupBox6: TGroupBox;
    Label9: TLabel;
    GroupBox7: TGroupBox;
    Label10: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Button4: TButton;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    GroupBox3: TGroupBox;
    StringGrid1: TStringGrid;
    GroupBox4: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    leistung_l4: TEdit;
    Label28: TLabel;
    Calculate: TTimer;
    Label11: TLabel;
    CheckBox1: TCheckBox;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    upBtn: TPngBitBtn;
    downBtn: TPngBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Speichern(Sender: TObject);
    procedure Laden(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Neu(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CalculateTimer(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure leistung_l1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
		procedure SaveFile(FileName: String);
		procedure NewFile;
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure managepower(Phase: Byte);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure leistung_l1KeyPress(Sender: TObject; var Key: Char);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure upBtnClick(Sender: TObject);
    procedure downBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure FlipEntry(Source, Destination:integer);
  public
    { Public-Deklarationen }
    Filestream:TFileStream;
    pL1array,pL2array,pL3array,pL4array:array of single;
    function CalculatePower(Channel, Endvalue: Integer):Integer;
    procedure RefreshGrid;
    procedure MSGSave;
  end;

var
  leistungssteuerung: Tleistungssteuerung;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tleistungssteuerung.Button1Click(Sender: TObject);
begin
  leistungssteuerung.Hide;
end;

procedure Tleistungssteuerung.Speichern(Sender: TObject);
begin
  if SaveDialog.Execute then
		SaveFile(SaveDialog.FileName);
end;

procedure Tleistungssteuerung.Laden(Sender: TObject);
var
	i,Count,startindex:integer;
  additiv:boolean;
begin
  additiv:=true;

	case mainform.mymessagedlg('Wie sollen die Leistungswerte aus der Datei geladen werden?',mtConfirmation,[mbYes,mbAll,mbCancel],['&Hinzufügen','&Ersetzen','Ab&brechen']) of
    mrYes: additiv:=true;
    mrCancel: additiv:=false;
    mrAll: exit;
  end;

  if OpenDialog.Execute then
	begin
    if additiv then
    begin
      startindex:=length(mainform.leistungsdaten.channel)-1;

      FileStream:=TFileStream.Create(OpenDialog.filename,fmOpenRead);
      Filestream.ReadBuffer(mainform.leistungsdaten.ampere,sizeof(mainform.leistungsdaten.ampere));
      Filestream.ReadBuffer(mainform.leistungsdaten.usesinus,sizeof(mainform.leistungsdaten.usesinus));
      Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(mainform.leistungsdaten.channel,startindex+1+Count);
      setlength(mainform.leistungsdaten.phase,startindex+1+Count);
      setlength(mainform.leistungsdaten.leistung,startindex+1+Count);
      setlength(mainform.leistungsdaten.deactivatechannelonoverload,startindex+1+Count);
      setlength(pL1array,startindex+1+Count);
      setlength(pL2array,startindex+1+Count);
      setlength(pL3array,startindex+1+Count);
      setlength(pL4array,startindex+1+Count);

      for i:=(startindex+1) to length(mainform.leistungsdaten.channel)-1 do
      begin
        Filestream.ReadBuffer(mainform.leistungsdaten.channel[i],sizeof(mainform.leistungsdaten.channel[i]));
        Filestream.ReadBuffer(mainform.leistungsdaten.phase[i],sizeof(mainform.leistungsdaten.phase[i]));
        Filestream.ReadBuffer(mainform.leistungsdaten.leistung[i],sizeof(mainform.leistungsdaten.leistung[i]));
        Filestream.ReadBuffer(mainform.leistungsdaten.deactivatechannelonoverload[i],sizeof(mainform.leistungsdaten.deactivatechannelonoverload[i]));
      end;
      FileStream.Free;
    end else
    begin
      FileStream:=TFileStream.Create(OpenDialog.filename,fmOpenRead);
      Filestream.ReadBuffer(mainform.leistungsdaten.ampere,sizeof(mainform.leistungsdaten.ampere));
      Filestream.ReadBuffer(mainform.leistungsdaten.usesinus,sizeof(mainform.leistungsdaten.usesinus));
      Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(mainform.leistungsdaten.channel,Count);
      setlength(mainform.leistungsdaten.phase,Count);
      setlength(mainform.leistungsdaten.leistung,Count);
      setlength(mainform.leistungsdaten.deactivatechannelonoverload,Count);
      setlength(pL1array,Count);
      setlength(pL2array,Count);
      setlength(pL3array,Count);
      setlength(pL4array,Count);

      for i:=0 to Count-1 do
      begin
        Filestream.ReadBuffer(mainform.leistungsdaten.channel[i],sizeof(mainform.leistungsdaten.channel[i]));
        Filestream.ReadBuffer(mainform.leistungsdaten.phase[i],sizeof(mainform.leistungsdaten.phase[i]));
        Filestream.ReadBuffer(mainform.leistungsdaten.leistung[i],sizeof(mainform.leistungsdaten.leistung[i]));
        Filestream.ReadBuffer(mainform.leistungsdaten.deactivatechannelonoverload[i],sizeof(mainform.leistungsdaten.deactivatechannelonoverload[i]));
      end;
      FileStream.Free;
    end;
    refreshGrid;
    CalculateTimer(nil);
  end;
end;

procedure Tleistungssteuerung.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
	if not mainform.shutdown then
  begin
	  LReg := TRegistry.Create;
	  LReg.RootKey:=HKEY_CURRENT_USER;

	  if LReg.OpenKey('Software', True) then
	  begin
	    if not LReg.KeyExists('PHOENIXstudios') then
	      LReg.CreateKey('PHOENIXstudios');
	    if LReg.OpenKey('PHOENIXstudios',true) then
	    begin
	      if not LReg.KeyExists('PC_DIMMER') then
	        LReg.CreateKey('PC_DIMMER');
	      if LReg.OpenKey('PC_DIMMER',true) then
	      begin
         	LReg.WriteBool('Showing Leistungssteuerung',false);

          if not LReg.KeyExists('Leistungssteuerung') then
  	        LReg.CreateKey('Leistungssteuerung');
  	      if LReg.OpenKey('Leistungssteuerung',true) then
          begin
          end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
  end;
end;

procedure Tleistungssteuerung.FormDblClick(Sender: TObject);
begin
  if clientheight<=55 then
  	clientheight:=521
  else
  	clientheight:=55;
end;

procedure Tleistungssteuerung.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MSGSave;
	FormHide(Sender);
end;

procedure Tleistungssteuerung.FormShow(Sender: TObject);
var
	LReg:TRegistry;
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
      	LReg.WriteBool('Showing Leistungssteuerung',true);

        if not LReg.KeyExists('Leistungssteuerung') then
	        LReg.CreateKey('Leistungssteuerung');
 	      if LReg.OpenKey('Leistungssteuerung',true) then
        begin
          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+leistungssteuerung.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              leistungssteuerung.Left:=LReg.ReadInteger('PosX')
            else
              leistungssteuerung.Left:=0;
          end else
            leistungssteuerung.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              leistungssteuerung.Top:=LReg.ReadInteger('PosY')
            else
              leistungssteuerung.Top:=0;
          end else
            leistungssteuerung.Top:=0;
        end;
      end;
    end;
  end;
  LReg.CloseKey;

	leistungssteuerung.ClientHeight:=55;

  refreshGrid;
  Calculate.Enabled:=true;
end;

procedure Tleistungssteuerung.RadioButton1Click(Sender: TObject);
begin
	CalculateTimer(Sender);
end;

procedure Tleistungssteuerung.Neu(Sender: TObject);
begin
	if messagedlg('Leistungstabellen zurücksetzen?',mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
	begin
		NewFile;
  end;

	CalculateTimer(Sender);
end;

procedure Tleistungssteuerung.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  Stringgrid1.ColWidths[0]:=40;
  Stringgrid1.ColWidths[1]:=40;
  Stringgrid1.ColWidths[2]:=40;
  Stringgrid1.ColWidths[3]:=200;
  Stringgrid1.ColWidths[4]:=40;
  Stringgrid1.ColWidths[5]:=45;
  Stringgrid1.ColWidths[6]:=85;

  Stringgrid1.Cells[0,0]:='Kanal';
  Stringgrid1.Cells[1,0]:='Phase';
  Stringgrid1.Cells[2,0]:='P';
  Stringgrid1.Cells[3,0]:='Kanalname';
  Stringgrid1.Cells[4,0]:='%';
  Stringgrid1.Cells[5,0]:='Pnow';
  Stringgrid1.Cells[6,0]:='Auto-Regulieren';

  mainform.leistungsdaten.ampere[1]:=20;
  mainform.leistungsdaten.ampere[2]:=20;
  mainform.leistungsdaten.ampere[3]:=20;
  mainform.leistungsdaten.ampere[4]:=16;
end;

procedure Tleistungssteuerung.CalculateTimer(Sender: TObject);
var
	i:integer;
  pl1local,pl2local,pl3local,pl4local:Single;
  winkel,faktor:single;
begin
  faktor:=0;

  if mainform.pcdimmerresetting then exit;

  LockWindow(Stringgrid1.Handle);

  Calculate.Enabled:=false;

  pl1local:=0;
  pl2local:=0;
  pl3local:=0;
  pl4local:=0;

  for i:=0 to length(mainform.leistungsdaten.channel)-1 do
  begin
    if (mainform.leistungsdaten.phase[i]>4) then
    	stringgrid1.Cells[1,i+1]:='0';

  	if mainform.leistungsdaten.phase[i]>0 then
    begin
      if not mainform.leistungsdaten.usesinus then
      begin
        winkel:=((255-mainform.data.ch[mainform.leistungsdaten.channel[i]])/255);
        faktor:=winkel;
      end else
      begin
				winkel:=((mainform.data.ch[mainform.leistungsdaten.channel[i]])/255)*180; // Winkel von 0%=180° bis 100%=0°
				winkel:=DegToRad(winkel);	// Winkel ins Bogenmaß konvertieren
        if ((1-(winkel / pi))+((1/(2*pi))*sin(2*winkel)))>=0 then
  				faktor:=sqrt((1-(winkel / pi))+((1/(2*pi))*sin(2*winkel))); // U_Last_effektiv berechnen
        faktor:=faktor*faktor; // Quadrieren
      end;

      case mainform.leistungsdaten.phase[i] of
      	1: pl1local:=pl1local+faktor*mainform.leistungsdaten.leistung[i];
      	2: pl2local:=pl2local+faktor*mainform.leistungsdaten.leistung[i];
      	3: pl3local:=pl3local+faktor*mainform.leistungsdaten.leistung[i];
      	4: pl4local:=pl4local+faktor*mainform.leistungsdaten.leistung[i];
      end;
			stringgrid1.Cells[5,i+1]:=inttostr(round(faktor*mainform.leistungsdaten.leistung[i]))+' W';
    end;
		stringgrid1.Cells[3,i+1]:=mainform.data.names[mainform.leistungsdaten.channel[i]];
		stringgrid1.Cells[4,i+1]:=inttostr(round(((255-mainform.data.ch[mainform.leistungsdaten.channel[i]])/255)*100))+'%';
  end;

  label8.Caption:=inttostr(round(pl1local))+' W';
  label9.Caption:=inttostr(round(pl2local))+' W';
  label10.Caption:=inttostr(round(pl3local))+' W';
  label25.Caption:=inttostr(round(pl4local))+' W';

  label20.caption:='(max. '+inttostr(mainform.leistungsdaten.ampere[1]*230)+' W)';
  label21.caption:='(max. '+inttostr(mainform.leistungsdaten.ampere[2]*230)+' W)';
  label22.caption:='(max. '+inttostr(mainform.leistungsdaten.ampere[3]*230)+' W)';
  label26.caption:='(max. '+inttostr(mainform.leistungsdaten.ampere[4]*230)+' W)';

  if pl1local>mainform.leistungsdaten.ampere[1]*230 then
  begin
  	label8.Font.Color:=clRed;
    managepower(1);
  end else
  begin
  	label8.Font.Color:=clGreen;
  end;

  if pl2local>mainform.leistungsdaten.ampere[2]*230 then
  begin
  	label9.Font.Color:=clRed;
    managepower(2);
  end else
  begin
  	label9.Font.Color:=clGreen;
  end;

  if pl3local>mainform.leistungsdaten.ampere[3]*230 then
  begin
  	label10.Font.Color:=clRed;
    managepower(3);
  end else
  begin
  	label10.Font.Color:=clGreen;
  end;

  if pl4local>mainform.leistungsdaten.ampere[4]*230 then
  begin
  	label25.Font.Color:=clRed;
    managepower(4);
  end else
  begin
  	label25.Font.Color:=clGreen;
  end;

  UnLockWindow(Stringgrid1.Handle);
end;

procedure Tleistungssteuerung.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
	channelname:string[255];
begin
  if (stringgrid1.Col=0) and (key=vk_return) then
  begin
    try
      if stringgrid1.Cells[0,stringgrid1.Row]='' then
        stringgrid1.Cells[0,stringgrid1.Row]:='0';

{$WARNINGS OFF}
  		if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])>mainform.lastchan then
      	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:=inttostr(mainform.lastchan);
{$WARNINGS ON}
		  if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<0 then
      	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='1';
      CalculateTimer(Sender);
    except
	    stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='1';
    end;

    mainform.leistungsdaten.channel[stringgrid1.row-1]:=strtoint(stringgrid1.Cells[0,stringgrid1.Row]);
    refreshGrid;
    CalculateTimer(Sender);
  end;

  if (stringgrid1.Col=1) and (key=vk_return) then
  begin
    try
      if stringgrid1.Cells[1,stringgrid1.Row]='' then
        stringgrid1.Cells[1,stringgrid1.Row]:='0';

  		if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])>4 then
      	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='4';
		  if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<0 then
      	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='0';
      CalculateTimer(Sender);
    except
	    stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='0';
    end;

    mainform.leistungsdaten.phase[stringgrid1.row-1]:=strtoint(stringgrid1.Cells[1,stringgrid1.Row]);
    CalculateTimer(Sender);
  end;

  if (stringgrid1.Col=2) and (key=vk_return) then
  begin
    if stringgrid1.Cells[2,stringgrid1.Row]<>'' then
      mainform.leistungsdaten.leistung[stringgrid1.row-1]:=strtoint(stringgrid1.Cells[2,stringgrid1.Row]);
    CalculateTimer(Sender);
  end;

	if (stringgrid1.Col=3) and (key=vk_return) then
  begin
    mainform.data.names[stringgrid1.row]:=stringgrid1.Cells[stringgrid1.Col,stringgrid1.row];
    channelname:=mainform.data.names[stringgrid1.row]+#0;

    mainform.data.names[stringgrid1.row]:=channelname;
    mainform.pluginsaktualisieren(Sender);
//    RefreshDLLNames(stringgrid1.row,@channelname);
  end;
end;

procedure Tleistungssteuerung.leistung_l1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
begin
	if key=vk_return then
  begin
    for i:=1 to 4 do
      if Sender=TEdit(FindComponent('leistung_l'+inttostr(i))) then
        mainform.leistungsdaten.ampere[i]:=strtoint(TEdit(FindComponent('leistung_l'+inttostr(i))).Text);
    CalculateTimer(Sender);
  end;
end;

procedure Tleistungssteuerung.StringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
var
	text:string;
begin
	case ACol of
  	4: text:=StringGrid1.Cells[ACol,ARow];
  	5: text:=StringGrid1.Cells[ACol,ARow];
  end;

  if (ACol=4) or (ACol=5) or (ACol=6) then StringGrid1.EditorMode:=false else StringGrid1.EditorMode:=true;

	case ACol of
  	4: StringGrid1.Cells[ACol,ARow]:=text;
  	5: StringGrid1.Cells[ACol,ARow]:=text;
  end;
end;

procedure Tleistungssteuerung.StringGrid1DrawCell(Sender: TObject; ACol,
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

	if (ARow>0) and (ACol = 6) then
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
		if (ARow>0) and (ACol = 6) and (length(mainform.leistungsdaten.channel)>0) then
    if mainform.leistungsdaten.deactivatechannelonoverload[ARow-1] then
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

		TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
	end;
end;

procedure Tleistungssteuerung.SaveFile(FileName: String);
var
	i,Count:integer;
begin
 	for i:=0 to length(mainform.leistungsdaten.channel)-1 do
 	begin
  	mainform.leistungsdaten.channel[i]:=strtoint(stringgrid1.Cells[0,i+1]);
    mainform.leistungsdaten.phase[i]:=strtoint(stringgrid1.Cells[1,i+1]);
    mainform.leistungsdaten.leistung[i]:=strtoint(stringgrid1.Cells[2,i+1]);
 	end;

  mainform.leistungsdaten.ampere[1]:=strtoint(leistung_l1.Text);
  mainform.leistungsdaten.ampere[2]:=strtoint(leistung_l2.Text);
  mainform.leistungsdaten.ampere[3]:=strtoint(leistung_l3.Text);
  mainform.leistungsdaten.ampere[4]:=strtoint(leistung_l4.Text);

  FileStream:=TFileStream.Create(filename,fmCreate);
  Filestream.WriteBuffer(mainform.leistungsdaten.ampere,sizeof(mainform.leistungsdaten.ampere));
  Filestream.WriteBuffer(mainform.leistungsdaten.usesinus,sizeof(mainform.leistungsdaten.usesinus));
  Count:=length(mainform.leistungsdaten.channel);
  Filestream.WriteBuffer(Count,sizeof(Count));
  for i:=0 to Count-1 do
  begin
    Filestream.WriteBuffer(mainform.leistungsdaten.channel[i],sizeof(mainform.leistungsdaten.channel[i]));
    Filestream.WriteBuffer(mainform.leistungsdaten.phase[i],sizeof(mainform.leistungsdaten.phase[i]));
    Filestream.WriteBuffer(mainform.leistungsdaten.leistung[i],sizeof(mainform.leistungsdaten.leistung[i]));
    Filestream.WriteBuffer(mainform.leistungsdaten.deactivatechannelonoverload[i],sizeof(mainform.leistungsdaten.deactivatechannelonoverload[i]));
  end;
  FileStream.Free;
end;

procedure Tleistungssteuerung.NewFile;
begin
    mainform.leistungsdaten.usesinus:=true;

    mainform.leistungsdaten.ampere[1]:=20;
    mainform.leistungsdaten.ampere[2]:=20;
    mainform.leistungsdaten.ampere[3]:=20;
    mainform.leistungsdaten.ampere[4]:=16;

    setlength(mainform.leistungsdaten.channel,0);
    setlength(mainform.leistungsdaten.phase,0);
    setlength(mainform.leistungsdaten.leistung,0);
    setlength(mainform.leistungsdaten.deactivatechannelonoverload,0);
    setlength(pL1array,0);
    setlength(pL2array,0);
    setlength(pL3array,0);
    setlength(pL4array,0);

    leistung_l1.Text:=inttostr(mainform.leistungsdaten.ampere[1]);
    leistung_l2.Text:=inttostr(mainform.leistungsdaten.ampere[2]);
    leistung_l3.Text:=inttostr(mainform.leistungsdaten.ampere[3]);
    leistung_l4.Text:=inttostr(mainform.leistungsdaten.ampere[4]);

    refreshGrid;
    Calculate.Enabled:=true;
end;

procedure Tleistungssteuerung.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i,highest:integer;
  allchecked:boolean;
begin
  if StringGrid1.Col=6 then
  begin
  	if Shift=[ssCtrl] then
    begin
    	for i:=0 to length(mainform.leistungsdaten.channel)-1 do
      	mainform.leistungsdaten.deactivatechannelonoverload[i]:=true;
    end else if Shift=[ssAlt] then
    begin
    	for i:=0 to length(mainform.leistungsdaten.channel)-1 do
      	mainform.leistungsdaten.deactivatechannelonoverload[i]:=false;
    end else if Button=mbRight then
    begin
      i:=StringGrid1.Row-1;
    	repeat
        i:=i+1;
    	until (i mod 8 =0);
     	highest:=i;
     	allchecked:=true;
        for i:=highest-7 to highest do
          if not mainform.leistungsdaten.deactivatechannelonoverload[i-1] then
          begin
            mainform.leistungsdaten.deactivatechannelonoverload[i-1]:=true;
          	allchecked:=false;
          end;

	      if allchecked then
	  	    for i:=highest-7 to highest do
	    	  	mainform.leistungsdaten.deactivatechannelonoverload[i-1]:=false;
    end else
  	begin
			mainform.leistungsdaten.deactivatechannelonoverload[StringGrid1.Row-1]:=not mainform.leistungsdaten.deactivatechannelonoverload[StringGrid1.Row-1];
	  end;

    CalculateTimer(nil);
		StringGrid1.Refresh;
  end;
end;

procedure Tleistungssteuerung.managepower(Phase: Byte);
var
  i:integer;
begin
      case Phase of // Leistung reduzieren
        1:
        begin
          for i:=0 to length(mainform.leistungsdaten.channel)-1 do
          begin
            if mainform.leistungsdaten.deactivatechannelonoverload[i] and (mainform.leistungsdaten.phase[i]=1) then
            begin
              if ((255-mainform.data.ch[mainform.leistungsdaten.channel[i]])>19) then
                mainform.SendData(mainform.leistungsdaten.channel[i],mainform.data.ch[mainform.leistungsdaten.channel[i]]+20,mainform.data.ch[mainform.leistungsdaten.channel[i]]+20,0);
            end;
          end;
        end;
        2:
        begin
          for i:=0 to length(mainform.leistungsdaten.channel)-1 do
          begin
            if mainform.leistungsdaten.deactivatechannelonoverload[i] and (mainform.leistungsdaten.phase[i]=2) then
            begin
              if ((255-mainform.data.ch[mainform.leistungsdaten.channel[i]])>19) then
                mainform.SendData(mainform.leistungsdaten.channel[i],mainform.data.ch[mainform.leistungsdaten.channel[i]]+20,mainform.data.ch[mainform.leistungsdaten.channel[i]]+20,0);
            end;
          end;
        end;
        3:
        begin
          for i:=0 to length(mainform.leistungsdaten.channel)-1 do
          begin
            if mainform.leistungsdaten.deactivatechannelonoverload[i] and (mainform.leistungsdaten.phase[i]=3) then
            begin
              if ((255-mainform.data.ch[mainform.leistungsdaten.channel[i]])>19) then
                mainform.SendData(mainform.leistungsdaten.channel[i],mainform.data.ch[mainform.leistungsdaten.channel[i]]+20,mainform.data.ch[mainform.leistungsdaten.channel[i]]+20,0);
            end;
          end;
        end;
        4:
        begin
          for i:=0 to length(mainform.leistungsdaten.channel)-1 do
          begin
            if mainform.leistungsdaten.deactivatechannelonoverload[i] and (mainform.leistungsdaten.phase[i]=4) then
            begin
              if ((255-mainform.data.ch[mainform.leistungsdaten.channel[i]])>19) then
                mainform.SendData(mainform.leistungsdaten.channel[i],mainform.data.ch[mainform.leistungsdaten.channel[i]]+20,mainform.data.ch[mainform.leistungsdaten.channel[i]]+20,0);
            end;
          end;
        end;
      end;
end;

procedure Tleistungssteuerung.CreateParams(var Params:TCreateParams);
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

function Tleistungssteuerung.CalculatePower(Channel, Endvalue: Integer):Integer;
var
	i:integer;
  pl1,pl2,pl3,pl4:Single;
  winkel,faktor:single;
  newendvalue:integer;
begin
  faktor:=0;

  pl1:=0;
  pl2:=0;
  pl3:=0;
  pl4:=0;

  newendvalue:=endvalue;

  for i:=0 to length(mainform.leistungsdaten.channel)-1 do
  if channel=mainform.leistungsdaten.channel[i] then
  begin
    // Phasen-Winkel für weitere Verarbeitung berechnen
    if not mainform.leistungsdaten.usesinus then
    begin // Lineare Berechnung
      winkel:=((255-newendvalue)/255); // Winkel von 0%=180° bis 100%=0°
      faktor:=winkel;
    end else
    begin // Sinus Berechnung
      winkel:=(newendvalue/255)*180; // Winkel von 0%=180° bis 100%=0°
  		winkel:=DegToRad(winkel);	// Winkel ins Bogenmaß konvertieren
      if ((1-(winkel / pi))+((1/(2*pi))*sin(2*winkel)))>=0 then
        faktor:=sqrt((1-(winkel / pi))+((1/(2*pi))*sin(2*winkel))); // U_Last_effektiv berechnen
    end;

    // Alte Leistung subtrahieren
    case mainform.leistungsdaten.phase[i] of
      1: pl1:=pl1-pl1array[i];
      2: pl2:=pl2-pl2array[i];
      3: pl3:=pl3-pl3array[i];
      4: pl4:=pl4-pl4array[i];
    end;

    // Kanal-Leistung im Array aktualisieren
    case mainform.leistungsdaten.phase[i] of
   	  1: pl1array[i]:=faktor*faktor*mainform.leistungsdaten.leistung[i];
      2: pl2array[i]:=faktor*faktor*mainform.leistungsdaten.leistung[i];
     	3: pl3array[i]:=faktor*faktor*mainform.leistungsdaten.leistung[i];
     	4: pl4array[i]:=faktor*faktor*mainform.leistungsdaten.leistung[i];
    end;

    // Neue Leistung addieren
    case mainform.leistungsdaten.phase[i] of
      1: pl1:=pl1+pl1array[i];
      2: pl2:=pl2+pl2array[i];
      3: pl3:=pl3+pl3array[i];
      4: pl4:=pl4+pl4array[i];
    end;

    if pl1>mainform.leistungsdaten.ampere[1]*230 then
    begin
      //leistung für Phase 1 reduzieren
      if (mainform.leistungsdaten.deactivatechannelonoverload[i]) and (mainform.leistungsdaten.phase[i]=1) then
      begin
        if newendvalue<255 then
        begin
          newendvalue:=newendvalue+1;
        end;
      end;
    end;

    if pl2>mainform.leistungsdaten.ampere[2]*230 then
    begin
      //leistung für Phase 2 reduzieren
      if (mainform.leistungsdaten.deactivatechannelonoverload[i]) and (mainform.leistungsdaten.phase[i]=2) then
      begin
        if newendvalue<255 then
        begin
          newendvalue:=newendvalue+1;
        end;
      end;
    end;

    if pl3>mainform.leistungsdaten.ampere[3]*230 then
    begin
      //leistung für Phase 3 reduzieren
      if (mainform.leistungsdaten.deactivatechannelonoverload[i]) and (mainform.leistungsdaten.phase[i]=3) then
      begin
        if newendvalue<255 then
        begin
          newendvalue:=newendvalue+1;
        end;
      end;
    end;

    if pl4>mainform.leistungsdaten.ampere[4]*230 then
    begin
      //leistung für Phase 4 reduzieren
      if (mainform.leistungsdaten.deactivatechannelonoverload[i]) and (mainform.leistungsdaten.phase[i]=4) then
      begin
        if newendvalue<255 then
        begin
          newendvalue:=newendvalue+1;
        end;
      end;
    end;
  end;
  result:=newendvalue;
end;

procedure Tleistungssteuerung.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.usepowermanagement:=Checkbox1.Checked;
end;

procedure Tleistungssteuerung.RadioButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.leistungsdaten.usesinus:=true;
end;

procedure Tleistungssteuerung.RadioButton2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.leistungsdaten.usesinus:=false;
end;

procedure Tleistungssteuerung.leistung_l1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    key := #0;
end;

procedure Tleistungssteuerung.PngBitBtn1Click(Sender: TObject);
begin
  setlength(mainform.leistungsdaten.channel,length(mainform.leistungsdaten.channel)+1);
  setlength(mainform.leistungsdaten.phase,length(mainform.leistungsdaten.phase)+1);
  setlength(mainform.leistungsdaten.leistung,length(mainform.leistungsdaten.leistung)+1);
  setlength(mainform.leistungsdaten.deactivatechannelonoverload,length(mainform.leistungsdaten.deactivatechannelonoverload)+1);
  setlength(pL1array,length(pL1array)+1);
  setlength(pL2array,length(pL2array)+1);
  setlength(pL3array,length(pL3array)+1);
  setlength(pL4array,length(pL4array)+1);

  mainform.leistungsdaten.channel[length(mainform.leistungsdaten.channel)-1]:=0;
  mainform.leistungsdaten.phase[length(mainform.leistungsdaten.phase)-1]:=0;
  mainform.leistungsdaten.leistung[length(mainform.leistungsdaten.leistung)-1]:=0;
  mainform.leistungsdaten.deactivatechannelonoverload[length(mainform.leistungsdaten.deactivatechannelonoverload)-1]:=false;

  refreshGrid;
end;

procedure Tleistungssteuerung.RefreshGrid;
var
  i:integer;
begin
  leistung_l1.Text:=inttostr(mainform.leistungsdaten.ampere[1]);
  leistung_l2.Text:=inttostr(mainform.leistungsdaten.ampere[2]);
  leistung_l3.Text:=inttostr(mainform.leistungsdaten.ampere[3]);
  leistung_l4.Text:=inttostr(mainform.leistungsdaten.ampere[4]);

  radiobutton1.Checked:=mainform.leistungsdaten.usesinus;

  if length(mainform.leistungsdaten.channel)=0 then
    stringgrid1.RowCount:=2
  else
    stringgrid1.RowCount:=length(mainform.leistungsdaten.channel)+1;

  for i:=0 to length(mainform.leistungsdaten.channel)-1 do
  begin
    Stringgrid1.Cells[0,i+1]:=inttostr(mainform.leistungsdaten.channel[i]);
    Stringgrid1.Cells[1,i+1]:=inttostr(mainform.leistungsdaten.phase[i]);
    Stringgrid1.Cells[2,i+1]:=inttostr(mainform.leistungsdaten.leistung[i]);
    Stringgrid1.Cells[3,i+1]:=mainform.data.names[mainform.leistungsdaten.channel[i]];
  end;

  PngBitBtn2.enabled:=length(mainform.leistungsdaten.channel)>0;
  upBtn.enabled:=length(mainform.leistungsdaten.channel)>0;
  downBtn.enabled:=length(mainform.leistungsdaten.channel)>0;
  StringGrid1.Enabled:=length(mainform.leistungsdaten.channel)>0;

  if length(mainform.leistungsdaten.channel)=0 then
  begin
    Stringgrid1.Cells[0,1]:='-';
    Stringgrid1.Cells[1,1]:='-';
    Stringgrid1.Cells[2,1]:='-';
    Stringgrid1.Cells[3,1]:='-';
    Stringgrid1.Cells[4,1]:='-';
    Stringgrid1.Cells[5,1]:='-';
  end;
end;

procedure Tleistungssteuerung.PngBitBtn2Click(Sender: TObject);
var
  i:integer;
begin
  if (length(mainform.leistungsdaten.channel)>0) and (Stringgrid1.Row>0) and (Stringgrid1.Row-1<length(mainform.leistungsdaten.channel)) then
  begin
    // Alle Elemente um eine Position nach vorne schieben
    for i:=Stringgrid1.Row-1 to length(mainform.leistungsdaten.channel)-2 do
    begin
      mainform.leistungsdaten.channel[i]:=mainform.leistungsdaten.channel[i+1];
      mainform.leistungsdaten.phase[i]:=mainform.leistungsdaten.phase[i+1];
      mainform.leistungsdaten.leistung[i]:=mainform.leistungsdaten.leistung[i+1];
      mainform.leistungsdaten.deactivatechannelonoverload[i]:=mainform.leistungsdaten.deactivatechannelonoverload[i+1];
    end;

    // Letzte Position löschen
    setlength(mainform.leistungsdaten.channel,length(mainform.leistungsdaten.channel)-1);
    setlength(mainform.leistungsdaten.phase,length(mainform.leistungsdaten.phase)-1);
    setlength(mainform.leistungsdaten.leistung,length(mainform.leistungsdaten.leistung)-1);
    setlength(mainform.leistungsdaten.deactivatechannelonoverload,length(mainform.leistungsdaten.deactivatechannelonoverload)-1);
    setlength(pL1array,length(pL1array)-1);
    setlength(pL2array,length(pL2array)-1);
    setlength(pL3array,length(pL3array)-1);
    setlength(pL4array,length(pL4array)-1);

    // Fenster aktualisieren
    RefreshGrid;
    CalculateTimer(nil);
  end;
end;

procedure Tleistungssteuerung.MSGSave;
var
  LReg:TRegistry;
begin
	  LReg := TRegistry.Create;
	  LReg.RootKey:=HKEY_CURRENT_USER;

	  if LReg.OpenKey('Software', True) then
	  begin
	    if not LReg.KeyExists('PHOENIXstudios') then
	      LReg.CreateKey('PHOENIXstudios');
	    if LReg.OpenKey('PHOENIXstudios',true) then
	    begin
	      if not LReg.KeyExists('PC_DIMMER') then
	        LReg.CreateKey('PC_DIMMER');
	      if LReg.OpenKey('PC_DIMMER',true) then
	      begin
          if not LReg.KeyExists('Leistungssteuerung') then
  	        LReg.CreateKey('Leistungssteuerung');
  	      if LReg.OpenKey('Leistungssteuerung',true) then
          begin
            LReg.WriteInteger('PosX',leistungssteuerung.Left);
            LReg.WriteInteger('PosY',leistungssteuerung.Top);
          end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
end;

procedure Tleistungssteuerung.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Tleistungssteuerung.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tleistungssteuerung.FlipEntry(Source, Destination:integer);
begin
  // aktuellen Eintrag temporär ans Ende kopieren
  setlength(mainform.leistungsdaten.channel,length(mainform.leistungsdaten.channel)+1);
  setlength(mainform.leistungsdaten.phase,length(mainform.leistungsdaten.phase)+1);
  setlength(mainform.leistungsdaten.leistung,length(mainform.leistungsdaten.leistung)+1);
  setlength(mainform.leistungsdaten.deactivatechannelonoverload,length(mainform.leistungsdaten.deactivatechannelonoverload)+1);
  mainform.leistungsdaten.channel[length(mainform.leistungsdaten.channel)-1]:=mainform.leistungsdaten.channel[Source];
  mainform.leistungsdaten.phase[length(mainform.leistungsdaten.phase)-1]:=mainform.leistungsdaten.phase[Source];
  mainform.leistungsdaten.leistung[length(mainform.leistungsdaten.leistung)-1]:=mainform.leistungsdaten.leistung[Source];
  mainform.leistungsdaten.deactivatechannelonoverload[length(mainform.leistungsdaten.deactivatechannelonoverload)-1]:=mainform.leistungsdaten.deactivatechannelonoverload[Source];

  // oberen Einträge aufrutschen
  mainform.leistungsdaten.channel[Source]:=mainform.leistungsdaten.channel[Destination];
  mainform.leistungsdaten.phase[Source]:=mainform.leistungsdaten.phase[Destination];
  mainform.leistungsdaten.leistung[Source]:=mainform.leistungsdaten.leistung[Destination];
  mainform.leistungsdaten.deactivatechannelonoverload[Source]:=mainform.leistungsdaten.deactivatechannelonoverload[Destination];

  // letzten Eintrag einfügen
  mainform.leistungsdaten.channel[Destination]:=mainform.leistungsdaten.channel[length(mainform.leistungsdaten.channel)-1];
  mainform.leistungsdaten.phase[Destination]:=mainform.leistungsdaten.phase[length(mainform.leistungsdaten.channel)-1];
  mainform.leistungsdaten.leistung[Destination]:=mainform.leistungsdaten.leistung[length(mainform.leistungsdaten.channel)-1];
  mainform.leistungsdaten.deactivatechannelonoverload[Destination]:=mainform.leistungsdaten.deactivatechannelonoverload[length(mainform.leistungsdaten.channel)-1];
  setlength(mainform.leistungsdaten.channel,length(mainform.leistungsdaten.channel)-1);
  setlength(mainform.leistungsdaten.phase,length(mainform.leistungsdaten.phase)-1);
  setlength(mainform.leistungsdaten.leistung,length(mainform.leistungsdaten.leistung)-1);
  setlength(mainform.leistungsdaten.deactivatechannelonoverload,length(mainform.leistungsdaten.deactivatechannelonoverload)-1);
end;

procedure Tleistungssteuerung.upBtnClick(Sender: TObject);
begin
  if StringGrid1.Row>1 then
  begin
    // nach unten verschieben
    FlipEntry(StringGrid1.Row-1,StringGrid1.Row-2);
    // Position mitführen
    StringGrid1.Row:=StringGrid1.Row-1;
  end;
  RefreshGrid;
  CalculateTimer(Sender);
end;

procedure Tleistungssteuerung.downBtnClick(Sender: TObject);
begin
  if StringGrid1.Row<StringGrid1.RowCount-1 then
  begin
    // nach unten verschieben
    FlipEntry(StringGrid1.Row-1,StringGrid1.Row);
    // Position mitführen
    StringGrid1.Row:=StringGrid1.Row+1;
  end;
  RefreshGrid;
  CalculateTimer(Sender);
end;

end.
