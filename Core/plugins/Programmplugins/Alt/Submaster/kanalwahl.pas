unit kanalwahl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, JvExGrids, JvStringGrid, DBGrids,
  JvExDBGrids, JvDBGrid, Buttons;

const chan = 512;

type
  Tkanalwahlform = class(TForm)
    OKBtn: TButton;
    a: TLabel;
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    JumpToChannel: TEdit;
    Label1: TLabel;
    procedure input_number(var pos:integer; var s:string);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure JumpToChannelKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    active:array[1..chan] of boolean;
  end;

var
  kanalwahlform: Tkanalwahlform;

implementation

uses main;

{$R *.dfm}

procedure Tkanalwahlform.StringGrid1DrawCell(Sender: TObject; ACol,
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

procedure Tkanalwahlform.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i,highest:integer;
  allchecked:boolean;
begin
  if StringGrid1.Col=0 then
  begin
  	if Shift=[ssCtrl] then
    begin
    	for i:=1 to chan do
      	active[i]:=true;
    end else if Shift=[ssAlt] then
    begin
    	for i:=1 to chan do
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

procedure Tkanalwahlform.FormShow(Sender: TObject);
begin
	stringgrid1.Cols[1].Strings[0]:=_('Kanal');
	stringgrid1.Cols[2].Strings[0]:=_('Kanalname');
end;

procedure Tkanalwahlform.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
	channelname:string[255];
begin
	if stringgrid1.Col=2 then
  begin
    mainform.channelnames[stringgrid1.row]:=stringgrid1.Cells[stringgrid1.Col,stringgrid1.row];
    channelname:=mainform.channelnames[stringgrid1.row]+#0;
    mainform.RefreshDLLNames(stringgrid1.row,@channelname);
  end;
end;

procedure Tkanalwahlform.StringGrid1GetEditMask(Sender: TObject; ACol,
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

procedure Tkanalwahlform.JumpToChannelKeyUp(Sender: TObject; var Key: Word;
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

procedure Tkanalwahlform.input_number(var pos:integer; var s:string);
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

end.
