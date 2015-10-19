unit settingfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, XPMan, Math, Buttons, Grids, Registry,
  VistaAltFixUnit;

const
  chan=512;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;

type
  TLeistungsdaten = record
  	channels : array[1..chan] of Word;
    phase : array[1..chan] of byte;
    leistung : array[1..chan] of Word;
    ampere : array[1..10] of Word;
    deactivatechannelonoverload : array[1..chan] of boolean;
  end;

type
  TSettings = class(TForm)
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
    Label23: TLabel;
    Label24: TLabel;
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
    VistaAltFix1: TVistaAltFix;
    procedure Button1Click(Sender: TObject);
    procedure input_number(var pos:integer; var s:string);
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
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpenFile(FileName: String);
		procedure SaveFile(FileName: String);
		procedure NewFile;
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure managepower(Phase: Byte);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
	  channelvalue:array[1..chan] of integer;
	  channelnames:array[1..chan] of string;
    leistungsdaten:TLeistungsdaten;
    lastchan:word;
    RefreshDLLValues:TCallbackValues;
    RefreshDLLNames:TCallbackNames;
    shutdown:Boolean;
    Filestream:TFileStream;
  end;

var
  Settings: TSettings;

implementation

{$R *.dfm}

function GetModulePath : String;
var
  QueryRes: TMemoryBasicInformation;
  LBuffer: String;
begin
  VirtualQuery(@GetModulePath, QueryRes, SizeOf(QueryRes));
  SetLength(LBuffer, MAX_PATH);
  SetLength(LBuffer, GetModuleFileName(Cardinal(QueryRes.AllocationBase),
  PChar(LBuffer), Length(LBuffer)));
  result:=LBuffer;
end;

procedure TSettings.input_number(var pos:integer; var s:string);
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


procedure TSettings.Button1Click(Sender: TObject);
begin
  Settings.Hide;
end;

procedure TSettings.Speichern(Sender: TObject);
begin
  if SaveDialog.Execute then
		SaveFile(SaveDialog.FileName);
end;

procedure TSettings.Laden(Sender: TObject);
begin
  if OpenDialog.Execute then
		OpenFile(OpenDialog.FileName);

//	CalculateTimer(Sender);
end;

procedure TSettings.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
	if not shutdown then
  begin
	  LReg := TRegistry.Create;
	  LReg.RootKey:=HKEY_LOCAL_MACHINE;

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
	        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
		        LReg.CreateKey(ExtractFileName(GetModulePath));
		      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
		      begin
          	LReg.WriteBool('Showing Plugin',false);
		      end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
  end;

  SaveFile(ExtractFilePath(paramstr(0))+'Projekt\Leistungsplugin');
end;

procedure TSettings.FormDblClick(Sender: TObject);
begin
  if clientheight<=55 then
  	clientheight:=722
  else
  	clientheight:=55;
end;

procedure TSettings.FormClose(Sender: TObject; var Action: TCloseAction);
var
  LReg:TRegistry;
begin
	  LReg := TRegistry.Create;
	  LReg.RootKey:=HKEY_LOCAL_MACHINE;

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
	        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
		        LReg.CreateKey(ExtractFileName(GetModulePath));
		      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
		      begin
            LReg.WriteInteger('PosX',settings.Left);
            LReg.WriteInteger('PosY',settings.Top);
		      end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;

	FormHide(Sender);
end;

procedure TSettings.FormShow(Sender: TObject);
var
	LReg:TRegistry;
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_LOCAL_MACHINE;

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
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
        	LReg.WriteBool('Showing Plugin',true);

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+settings.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              settings.Left:=LReg.ReadInteger('PosX')
            else
              settings.Left:=screen.DesktopLeft;
          end else
            settings.Left:=screen.DesktopLeft;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              settings.Top:=LReg.ReadInteger('PosY')
            else
              settings.Top:=screen.DesktopTop;
          end else
            settings.Top:=screen.DesktopTop;
	      end;
      end;
    end;
  end;
  LReg.CloseKey;

	settings.ClientHeight:=55;

  if FileExists(ExtractFilePath(paramstr(0))+'Projekt\Leistungsplugin') then
		OpenFile(ExtractFilePath(paramstr(0))+'Projekt\Leistungsplugin')
  else
		NewFile;

  Calculate.Enabled:=true;
end;

procedure TSettings.RadioButton1Click(Sender: TObject);
begin
	CalculateTimer(Sender);
end;

procedure TSettings.Neu(Sender: TObject);
begin
	if messagedlg(_('Leistungstabellen zurücksetzen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
	begin
		NewFile;
  end;
  
	CalculateTimer(Sender);
end;

procedure TSettings.FormCreate(Sender: TObject);
var
	LReg:TRegistry;
begin
	shutdown:=false;
  
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_LOCAL_MACHINE;

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
        if not LReg.ValueExists('Last channel') then
          LReg.WriteInteger('Last channel',128);
        lastchan:=LReg.ReadInteger('Last channel');
        if lastchan<32 then lastchan:=32;
        if lastchan>chan then lastchan:=chan;
      end;
    end;
  end;
  LReg.CloseKey;

  stringgrid1.RowCount:=lastchan+1;

  Stringgrid1.ColWidths[0]:=40;
  Stringgrid1.ColWidths[1]:=40;
  Stringgrid1.ColWidths[2]:=40;
  Stringgrid1.ColWidths[3]:=200;
  Stringgrid1.ColWidths[4]:=40;
  Stringgrid1.ColWidths[5]:=45;
  Stringgrid1.ColWidths[6]:=85;

  Stringgrid1.Cells[0,0]:=_('Kanal');
  Stringgrid1.Cells[1,0]:=_('Phase');
  Stringgrid1.Cells[2,0]:=_('P');
  Stringgrid1.Cells[3,0]:=_('Kanalname');
  Stringgrid1.Cells[4,0]:=_('%');
  Stringgrid1.Cells[5,0]:=_('Pnow');
  Stringgrid1.Cells[6,0]:=_('Auto-Regulieren');

  NewFile;
end;

procedure TSettings.CalculateTimer(Sender: TObject);
var
	i:integer;
  pl1,pl2,pl3,pl4:Single;
  winkel,faktor:single;
begin
  Calculate.Enabled:=false;

  pl1:=0;
  pl2:=0;
  pl3:=0;
  pl4:=0;

  for i:=1 to lastchan do
  begin
    if ((strtoint(stringgrid1.Cells[1,i])>4) or (strtoint(stringgrid1.Cells[1,i])<0)) then
    	stringgrid1.Cells[1,i]:='0';

//  	if strtoint(stringgrid1.Cells[1,i])>0 then
    begin
      if RadioButton2.Checked then
      begin
        winkel:=((channelvalue[strtoint(stringgrid1.Cells[0,i])])/255);
        faktor:=winkel;
      end else
      begin
				winkel:=((255-channelvalue[strtoint(stringgrid1.Cells[0,i])])/255)*180; // Winkel von 0%=180° bis 100%=0°
				winkel:=DegToRad(winkel);	// Winkel ins Bogenmaß konvertieren
				faktor:=sqrt((1-(winkel / pi))+((1/(2*pi))*sin(2*winkel))); // U_Last_effektiv berechnen
      end;

      case strtoint(stringgrid1.Cells[1,i]) of
      	1: pl1:=pl1+faktor*faktor*strtoint(stringgrid1.Cells[2,i]);
      	2: pl2:=pl2+faktor*faktor*strtoint(stringgrid1.Cells[2,i]);
      	3: pl3:=pl3+faktor*faktor*strtoint(stringgrid1.Cells[2,i]);
      	4: pl4:=pl4+faktor*faktor*strtoint(stringgrid1.Cells[2,i]);
      end;
			stringgrid1.Cells[5,i]:=inttostr(round(faktor*faktor*strtoint(stringgrid1.Cells[2,i])))+' W';
    end;
		stringgrid1.Cells[3,i]:=channelnames[strtoint(stringgrid1.Cells[0,i])];
		stringgrid1.Cells[4,i]:=inttostr(round(channelvalue[strtoint(stringgrid1.Cells[0,i])]*100/255))+'%';
  end;

  label8.Caption:=inttostr(round(pl1))+' W';
  label9.Caption:=inttostr(round(pl2))+' W';
  label10.Caption:=inttostr(round(pl3))+' W';
  label25.Caption:=inttostr(round(pl4))+' W';

  label20.caption:='(max. '+inttostr(strtoint(leistung_l1.Text)*230)+' W)';
  label21.caption:='(max. '+inttostr(strtoint(leistung_l2.Text)*230)+' W)';
  label22.caption:='(max. '+inttostr(strtoint(leistung_l3.Text)*230)+' W)';
  label26.caption:='(max. '+inttostr(strtoint(leistung_l4.Text)*230)+' W)';

  if pl1>strtoint(leistung_l1.Text)*230 then
  begin
  	label8.Font.Color:=clRed;
    managepower(1);
  end else
  begin
  	label8.Font.Color:=clGreen;
  end;

  if pl2>strtoint(leistung_l2.Text)*230 then
  begin
  	label9.Font.Color:=clRed;
    managepower(2);
  end else
  begin
  	label9.Font.Color:=clGreen;
  end;

  if pl3>strtoint(leistung_l3.Text)*230 then
  begin
  	label10.Font.Color:=clRed;
    managepower(3);
  end else
  begin
  	label10.Font.Color:=clGreen;
  end;

  if pl4>strtoint(leistung_l4.Text)*230 then
  begin
  	label25.Font.Color:=clRed;
    managepower(4);
  end else
  begin
  	label25.Font.Color:=clGreen;
  end;
end;

procedure TSettings.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if stringgrid1.Col=1 then
  try
		if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])>4 then
    	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='4';
		if strtoint(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<0 then
    	stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='0';
    CalculateTimer(Sender);
  except
	  stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:='0';
  end;

  if stringgrid1.Col=2 then
    CalculateTimer(Sender);
end;

procedure TSettings.leistung_l1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if key=vk_return then	CalculateTimer(Sender);
end;

procedure TSettings.StringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
var
	text:string;
begin
	case ACol of
	  0: text:=StringGrid1.Cells[ACol,ARow];
  	4: text:=StringGrid1.Cells[ACol,ARow];
  	5: text:=StringGrid1.Cells[ACol,ARow];
  end;

  if (ACol=0) or (ACol=4) or (ACol=5) or (ACol=6) then StringGrid1.EditorMode:=false else StringGrid1.EditorMode:=true;

	case ACol of
	  0: StringGrid1.Cells[ACol,ARow]:=text;
  	4: StringGrid1.Cells[ACol,ARow]:=text;
  	5: StringGrid1.Cells[ACol,ARow]:=text;
  end;
end;

procedure TSettings.StringGrid1DrawCell(Sender: TObject; ACol,
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
		if (ARow>0) and (ACol = 6) then
    if leistungsdaten.deactivatechannelonoverload[ARow] then
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

procedure TSettings.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
	channelname:string[255];
begin
	if (stringgrid1.Col=3) and (key=vk_return) then
  begin
    channelnames[stringgrid1.row]:=stringgrid1.Cells[stringgrid1.Col,stringgrid1.row];
    channelname:=channelnames[stringgrid1.row]+#0;
    RefreshDLLNames(stringgrid1.row,@channelname);
  end;
end;

procedure TSettings.OpenFile(FileName: String);
var
	i:integer;
begin
  FileStream:=TFileStream.Create(filename,fmOpenRead);
  FileStream.ReadBuffer(leistungsdaten,sizeof(leistungsdaten));
  FileStream.Free;

 	for i:=1 to lastchan do
 	begin
   	stringgrid1.Cells[0,i]:=inttostr(leistungsdaten.channels[i]);
    stringgrid1.Cells[1,i]:=inttostr(leistungsdaten.phase[i]);
    stringgrid1.Cells[2,i]:=inttostr(leistungsdaten.leistung[i]);
 	end;

  leistung_l1.Text:=inttostr(leistungsdaten.ampere[1]);
  leistung_l2.Text:=inttostr(leistungsdaten.ampere[2]);
  leistung_l3.Text:=inttostr(leistungsdaten.ampere[3]);
  leistung_l4.Text:=inttostr(leistungsdaten.ampere[4]);

  CalculateTimer(nil);
end;

procedure TSettings.SaveFile(FileName: String);
var
	i:integer;
begin
 	for i:=1 to lastchan do
 	begin
  	leistungsdaten.channels[i]:=strtoint(stringgrid1.Cells[0,i]);
    leistungsdaten.phase[i]:=strtoint(stringgrid1.Cells[1,i]);
    leistungsdaten.leistung[i]:=strtoint(stringgrid1.Cells[2,i]);
 	end;

  leistungsdaten.ampere[1]:=strtoint(leistung_l1.Text);
  leistungsdaten.ampere[2]:=strtoint(leistung_l2.Text);
  leistungsdaten.ampere[3]:=strtoint(leistung_l3.Text);
  leistungsdaten.ampere[4]:=strtoint(leistung_l4.Text);

  FileStream:=TFileStream.Create(filename,fmCreate);
  FileStream.WriteBuffer(leistungsdaten,sizeof(leistungsdaten));
  FileStream.Free;
end;

procedure TSettings.NewFile;
var
	i:integer;
begin
    leistungsdaten.ampere[1]:=20;
    leistungsdaten.ampere[2]:=20;
    leistungsdaten.ampere[3]:=20;
    leistungsdaten.ampere[4]:=16;
    leistung_l1.Text:=inttostr(leistungsdaten.ampere[1]);
    leistung_l2.Text:=inttostr(leistungsdaten.ampere[2]);
    leistung_l3.Text:=inttostr(leistungsdaten.ampere[3]);
    leistung_l4.Text:=inttostr(leistungsdaten.ampere[4]);

    for i:=1 to lastchan do
	  begin
			leistungsdaten.channels[i]:=i;
	    leistungsdaten.phase[i]:=0;
	    leistungsdaten.leistung[i]:=0;

	  	stringgrid1.Cells[0,i]:=inttostr(leistungsdaten.channels[i]);
	    stringgrid1.Cells[1,i]:=inttostr(leistungsdaten.phase[i]);
	    stringgrid1.Cells[2,i]:=inttostr(leistungsdaten.leistung[i]);
		end;
end;

procedure TSettings.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if StringGrid1.Col=6 then
  begin
		leistungsdaten.deactivatechannelonoverload[Stringgrid1.Row]:=not leistungsdaten.deactivatechannelonoverload[Stringgrid1.Row];
    CalculateTimer(nil);
    StringGrid1.Refresh;
  end;
end;

procedure TSettings.managepower(Phase: Byte);
var
  i:integer;
begin
      case Phase of // Leistung reduzieren
        1:
        begin
          for i:=1 to lastchan do
          begin
            if leistungsdaten.deactivatechannelonoverload[i] and (leistungsdaten.phase[i]=1) then
            begin
              if (channelvalue[i]>19) then
                RefreshDLLValues(i,channelvalue[i]-20,channelvalue[i]-20,0);
            end;
          end;
        end;
        2:
        begin
          for i:=1 to lastchan do
          begin
            if leistungsdaten.deactivatechannelonoverload[i] and (leistungsdaten.phase[i]=2) then
            begin
              if (channelvalue[i]>19) then
                RefreshDLLValues(i,channelvalue[i]-20,channelvalue[i]-20,0);
            end;
          end;
        end;
        3:
        begin
          for i:=1 to lastchan do
          begin
            if leistungsdaten.deactivatechannelonoverload[i] and (leistungsdaten.phase[i]=3) then
            begin
              if (channelvalue[i]>19) then
                RefreshDLLValues(i,channelvalue[i]-20,channelvalue[i]-20,0);
            end;
          end;
        end;
        4:
        begin
          for i:=1 to lastchan do
          begin
            if leistungsdaten.deactivatechannelonoverload[i] and (leistungsdaten.phase[i]=4) then
            begin
              if (channelvalue[i]>19) then
                RefreshDLLValues(i,channelvalue[i]-20,channelvalue[i]-20,0);
            end;
          end;
        end;
      end;
end;

end.
