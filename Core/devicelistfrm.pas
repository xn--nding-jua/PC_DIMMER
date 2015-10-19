unit devicelistfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, JvExControls, JvGradient, Grids,
  Buttons, PngBitBtn, gnugettext, PngImageList;

type
  Tdevicelistform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    StringGrid1: TStringGrid;
    Panel2: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Button1: TButton;
    PngBitBtn1: TPngBitBtn;
    collection: TPngImageCollection;
    dipswitch: TImage;
    DIPON: TImage;
    DIPOFF: TImage;
    procedure FormShow(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  devicelistform: Tdevicelistform;

implementation

uses PCDIMMER;

{$R *.dfm}

function BitSet(Value: Byte; BitCnt: Byte): Boolean;
begin
  result := ((Value AND bitcnt) = bitcnt);
end;

procedure Tdevicelistform.FormShow(Sender: TObject);
var
  i:integer;
  png: TPngImageCollectionItem;
  bildadresse:string;
//  temptext:string;
//  dipstate:array[1..10] of boolean;
//  temp:byte;
begin
  if screen.Width>800 then
    devicelistform.Width:=925;

  collection.Items.Clear;
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if FileExists(mainform.workingdirectory+'Devicepictures\'+mainform.devices[i].Bildadresse) then
    begin                                    
      if FileExists(mainform.workingdirectory+'Devicepictures\32 x 32\'+ExtractFileName(mainform.workingdirectory+'Devicepictures\'+mainform.devices[i].Bildadresse)) then
        bildadresse:=mainform.workingdirectory+'Devicepictures\32 x 32\'+ExtractFileName(mainform.workingdirectory+'Devicepictures\'+mainform.devices[i].Bildadresse)
      else
        bildadresse:=mainform.workingdirectory+'Devicepictures\'+mainform.devices[i].Bildadresse;
    end;

    if FileExists(bildadresse) then
    begin
      png:=collection.Items.Add(false);
      png.PngImage.LoadFromFile(bildadresse);
    end else if FileExists(mainform.workingdirectory+'Devicepictures\32 x 32\par56silber.png') then
    begin
      png:=collection.Items.Add(false);
      png.PngImage.LoadFromFile(mainform.workingdirectory+'Devicepictures\32 x 32\par56silber.png');
    end else
    begin
      png:=collection.Items.Add(false);
      png.PngImage.Canvas.Brush.Color:=clwhite;
      png.PngImage.Canvas.Pen.Color:=clwhite;
      png.PngImage.Canvas.Rectangle(0, 0, 32, 32);
    end;
  end;

  stringgrid1.RowHeights[0]:=15;

  stringgrid1.ColWidths[0]:=32;
  stringgrid1.ColWidths[1]:=225;
  stringgrid1.ColWidths[2]:=100;
  stringgrid1.ColWidths[3]:=45;
  stringgrid1.ColWidths[4]:=40;
  stringgrid1.ColWidths[5]:=40;
  stringgrid1.ColWidths[6]:=40;
  stringgrid1.ColWidths[7]:=45;
  stringgrid1.ColWidths[8]:=45;
  stringgrid1.ColWidths[9]:=45;
  stringgrid1.ColWidths[10]:=40;
  stringgrid1.ColWidths[11]:=64;
  stringgrid1.ColWidths[12]:=93;

  stringgrid1.Cells[0,0]:=_('Bild');
  stringgrid1.Cells[1,0]:=_('Gerätename');
  stringgrid1.Cells[2,0]:=_('Hersteller');
  stringgrid1.Cells[3,0]:=_('Adresse');
  stringgrid1.Cells[4,0]:=_('Kanäle');
  stringgrid1.Cells[5,0]:=_('P [W]');
  stringgrid1.Cells[6,0]:=_('Phase');
  stringgrid1.Cells[7,0]:=_('Farbrad');
  stringgrid1.Cells[8,0]:=_('Pan/Tilt');
  stringgrid1.Cells[9,0]:=_('RGB');
  stringgrid1.Cells[10,0]:=_('Dimmer');
  stringgrid1.Cells[11,0]:=_('Autoscening');
  stringgrid1.Cells[12,0]:=_('DIP-Switch');

  if length(mainform.devices)<1 then
  begin
    stringgrid1.RowCount:=2;
  end else
    stringgrid1.RowCount:=length(mainform.devices)+1;

  for i:=0 to stringgrid1.ColCount-1 do
    stringgrid1.Cells[i,1]:='';

  for i:=0 to length(mainform.devices)-1 do
  begin
    stringgrid1.Cells[1,i+1]:=mainform.devices[i].Name+#10#13+mainform.devices[i].Beschreibung;
    stringgrid1.Cells[2,i+1]:=mainform.devices[i].Vendor+#10#13+mainform.devices[i].DeviceName;
    if mainform.devices[i].MaxChan>1 then
      stringgrid1.Cells[3,i+1]:=inttostr(mainform.devices[i].Startaddress)+'..'+inttostr(mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1)
    else
      stringgrid1.Cells[3,i+1]:=inttostr(mainform.devices[i].Startaddress);
    stringgrid1.Cells[4,i+1]:=inttostr(mainform.devices[i].MaxChan);
    stringgrid1.Cells[5,i+1]:=inttostr(mainform.devices[i].Power);
    stringgrid1.Cells[6,i+1]:=inttostr(mainform.devices[i].Phase);
    if mainform.devices[i].hasColor then stringgrid1.Cells[7,i+1]:='X' else stringgrid1.Cells[7,i+1]:='';
    if mainform.devices[i].hasPANTILT then stringgrid1.Cells[8,i+1]:='X' else stringgrid1.Cells[8,i+1]:='';
    if mainform.devices[i].hasRGB then stringgrid1.Cells[9,i+1]:='X' else stringgrid1.Cells[9,i+1]:='';
    if mainform.devices[i].hasDimmer then stringgrid1.Cells[10,i+1]:='X' else stringgrid1.Cells[10,i+1]:='';
    if mainform.devices[i].autoscening then stringgrid1.Cells[11,i+1]:='X' else stringgrid1.Cells[11,i+1]:='';

{
    temp:=mainform.devices[i].Startaddress;
    dipstate[1]:=BitSet(temp, 1);
    dipstate[2]:=BitSet(temp, 2);
    dipstate[3]:=BitSet(temp, 4);
    dipstate[4]:=BitSet(temp, 8);
    dipstate[5]:=BitSet(temp, 16);
    dipstate[6]:=BitSet(temp, 32);
    dipstate[7]:=BitSet(temp, 64);
    dipstate[8]:=BitSet(temp, 128);
    temp:=mainform.devices[i].Startaddress shr 8;
    dipstate[9]:=BitSet(temp, 1);
    dipstate[10]:=BitSet(temp, 2);

    temptext:='';
    for j:=1 to 10 do
    begin
      if dipstate[j] then
        temptext:=temptext+'1'
      else
        temptext:=temptext+'0';
    end;
    stringgrid1.Cells[12,i+1]:=temptext;
}
  end;

  for i:=0 to Stringgrid1.RowCount-1 do
    Stringgrid1.RowHeights[i]:=32;
end;

procedure Tdevicelistform.PngBitBtn1Click(Sender: TObject);
begin
  mainform.tbitem66click(nil);
end;

procedure Tdevicelistform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tdevicelistform.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  S: String;
  drawrect, ownrect :trect;
  i:integer;
  dipstate:array[1..10] of boolean;
  temp:byte;
begin
  // Doppelreihigen Text anzeigen
  S:= (Sender As TStringgrid).Cells[ ACol, ARow ];
  if Length(S) > 0 then
  begin
    drawrect:=rect;

    DrawText((Sender As TStringgrid).canvas.handle, Pchar(S), Length(S), drawrect, dt_calcrect or dt_wordbreak or dt_left);
    if (drawrect.bottom - drawrect.top) > (Sender As TStringgrid).RowHeights[Arow] then
    begin
      (Sender As TStringgrid).RowHeights[Arow]:=(drawrect.bottom - drawrect.top);
    end else
    begin
      drawrect.Right := rect.right;
      (Sender As TStringgrid).canvas.fillrect( drawrect );

      DrawText((Sender As TStringgrid).canvas.handle, Pchar(S), Length(S), drawrect, dt_wordbreak or dt_left);
    end;
  end;

  // Gerätebilder anzeigen
  if length(mainform.Devices)>0 then
  begin
    with StringGrid1.Canvas do
    begin
      if (ARow>0) and (ACol = 0) then
      begin
        ownrect.Left:=rect.Left;
        ownrect.Top:=rect.Top;
        ownrect.Right:=ownrect.Left+32;
        ownrect.Bottom:=ownrect.Top+32;
        collection.Items.Items[ARow-1].PngImage.Draw(StringGrid1.Canvas, OwnRect);
      end;
      if (ARow>0) and (ACol = 12) then
      begin
        stringgrid1.Canvas.Draw(Rect.Left, Rect.Top, dipswitch.Picture.Graphic);

        temp:=mainform.devices[ARow-1].Startaddress;
        dipstate[1]:=BitSet(temp, 1);
        dipstate[2]:=BitSet(temp, 2);
        dipstate[3]:=BitSet(temp, 4);
        dipstate[4]:=BitSet(temp, 8);
        dipstate[5]:=BitSet(temp, 16);
        dipstate[6]:=BitSet(temp, 32);
        dipstate[7]:=BitSet(temp, 64);
        dipstate[8]:=BitSet(temp, 128);
        temp:=mainform.devices[ARow-1].Startaddress shr 8;
        dipstate[9]:=BitSet(temp, 1);
        dipstate[10]:=BitSet(temp, 2);

        for i:=1 to 10 do
        begin
          if dipstate[i] then
            stringgrid1.Canvas.Draw(Rect.Left+(8*i), Rect.Top+3, dipon.Picture.Graphic)
          else
            stringgrid1.Canvas.Draw(Rect.Left+(8*i), Rect.Top+3, dipoff.Picture.Graphic);
        end;
      end;
    end;
  end;
end;

procedure Tdevicelistform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tdevicelistform.CreateParams(var Params:TCreateParams);
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
