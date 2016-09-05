unit devicelistfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JvExControls, JvGradient, Grids,
  Buttons, PngBitBtn, gnugettext, PngImageList, pngimage;

type
  TDeviceOrder = record
    Startaddress:Word;
    PositionInDeviceArray:integer;
  end;
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
    DeviceOrder: array of TDeviceOrder;
    procedure SortDeviceOrder(iLo, iHi: integer);
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
  i,j:integer;
  png: TPngImageCollectionItem;
  bildadresse:string;
//  temptext:string;
//  dipstate:array[1..10] of boolean;
//  temp:byte;
begin
  if screen.Width>800 then
    devicelistform.Width:=925;

  setlength(DeviceOrder, length(mainform.devices));
  for i:=0 to length(mainform.devices)-1 do
  begin
    DeviceOrder[i].Startaddress:=mainform.devices[i].Startaddress;
    DeviceOrder[i].PositionInDeviceArray:=i;
  end;
  if length(DeviceOrder)>1 then
    SortDeviceOrder(Low(DeviceOrder),High(DeviceOrder));


  collection.Items.Clear;
  for j:=0 to length(mainform.Devices)-1 do
  begin
    i:=DeviceOrder[j].PositionInDeviceArray;

    if FileExists(mainform.pcdimmerdirectory+'Devicepictures\'+mainform.devices[i].Bildadresse) then
    begin                                    
      if FileExists(mainform.pcdimmerdirectory+'Devicepictures\32 x 32\'+ExtractFileName(mainform.pcdimmerdirectory+'Devicepictures\'+mainform.devices[i].Bildadresse)) then
        bildadresse:=mainform.pcdimmerdirectory+'Devicepictures\32 x 32\'+ExtractFileName(mainform.pcdimmerdirectory+'Devicepictures\'+mainform.devices[i].Bildadresse)
      else
        bildadresse:=mainform.pcdimmerdirectory+'Devicepictures\'+mainform.devices[i].Bildadresse;
    end;

    if FileExists(bildadresse) then
    begin
      png:=collection.Items.Add(false);
      png.PngImage.LoadFromFile(bildadresse);
    end else if FileExists(mainform.pcdimmerdirectory+'Devicepictures\32 x 32\par56silber.png') then
    begin
      png:=collection.Items.Add(false);
      png.PngImage.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\32 x 32\par56silber.png');
    end else
    begin
      //png:=collection.Items.Add(false);
      //png.PngImage.Canvas.Brush.Color:=clwhite;
      //png.PngImage.Canvas.Pen.Color:=clwhite;
      //png.PngImage.Canvas.Rectangle(0, 0, 32, 32);
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
  stringgrid1.ColWidths[9]:=50;
  stringgrid1.ColWidths[10]:=35;
  stringgrid1.ColWidths[11]:=35;
  stringgrid1.ColWidths[12]:=35;
  stringgrid1.ColWidths[13]:=35;
  stringgrid1.ColWidths[14]:=35;
  stringgrid1.ColWidths[15]:=35;
  stringgrid1.ColWidths[16]:=45;
  stringgrid1.ColWidths[17]:=45;
  stringgrid1.ColWidths[18]:=50;
  stringgrid1.ColWidths[19]:=45;
  stringgrid1.ColWidths[20]:=55;
  stringgrid1.ColWidths[21]:=55;
  stringgrid1.ColWidths[22]:=93;

  stringgrid1.Cells[0,0]:=_('Bild');
  stringgrid1.Cells[1,0]:=_('Gerätename');
  stringgrid1.Cells[2,0]:=_('Hersteller');
  stringgrid1.Cells[3,0]:=_('Adresse');
  stringgrid1.Cells[4,0]:=_('Kanäle');
  stringgrid1.Cells[5,0]:=_('P [W]');
  stringgrid1.Cells[6,0]:=_('Phase');

  stringgrid1.Cells[7,0]:=_('Dimmer');
  stringgrid1.Cells[8,0]:=_('Shutter');
  stringgrid1.Cells[9,0]:=_('V-Dimmer');
  stringgrid1.Cells[10,0]:=_('RGB');
  stringgrid1.Cells[11,0]:=_('CMY');
  stringgrid1.Cells[12,0]:=_('Amber');
  stringgrid1.Cells[13,0]:=_('Weiß');
  stringgrid1.Cells[14,0]:=_('UV');
  stringgrid1.Cells[15,0]:=_('Nebel');
  stringgrid1.Cells[16,0]:=_('Pan/Tilt');
  stringgrid1.Cells[17,0]:=_('Farbrad');
  stringgrid1.Cells[18,0]:=_('Farbrad 2');
  stringgrid1.Cells[19,0]:=_('Goborad');
  stringgrid1.Cells[20,0]:=_('Goborad 2');
  stringgrid1.Cells[21,0]:=_('Autoscening');

  stringgrid1.Cells[22,0]:=_('DIP-Switch');

  if length(mainform.devices)<1 then
  begin
    stringgrid1.RowCount:=2;
  end else
    stringgrid1.RowCount:=length(mainform.devices)+1;

  for i:=0 to stringgrid1.ColCount-1 do
    stringgrid1.Cells[i,1]:='';

  for j:=0 to length(mainform.devices)-1 do
  begin
    i:=DeviceOrder[j].PositionInDeviceArray;

    stringgrid1.Cells[1,j+1]:=mainform.devices[i].Name+#10#13+mainform.devices[i].Beschreibung;
    stringgrid1.Cells[2,j+1]:=mainform.devices[i].Vendor+#10#13+mainform.devices[i].DeviceName;
    if mainform.devices[i].MaxChan>1 then
      stringgrid1.Cells[3,j+1]:=inttostr(mainform.devices[i].Startaddress)+'..'+inttostr(mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1)
    else
      stringgrid1.Cells[3,j+1]:=inttostr(mainform.devices[i].Startaddress);
    stringgrid1.Cells[4,j+1]:=inttostr(mainform.devices[i].MaxChan);
    stringgrid1.Cells[5,j+1]:=inttostr(mainform.devices[i].Power);
    stringgrid1.Cells[6,j+1]:=inttostr(mainform.devices[i].Phase);
    if mainform.devices[i].hasDimmer then stringgrid1.Cells[7,j+1]:='X' else stringgrid1.Cells[7,j+1]:='';
    if mainform.devices[i].hasShutter then stringgrid1.Cells[8,j+1]:='X' else stringgrid1.Cells[8,j+1]:='';
    if mainform.devices[i].hasVirtualRGBAWDimmer then stringgrid1.Cells[9,j+1]:='X' else stringgrid1.Cells[9,j+1]:='';
    if mainform.devices[i].hasRGB then stringgrid1.Cells[10,j+1]:='X' else stringgrid1.Cells[10,j+1]:='';
    if mainform.devices[i].hasCMY then stringgrid1.Cells[11,j+1]:='X' else stringgrid1.Cells[11,j+1]:='';
    if mainform.devices[i].hasAmber then stringgrid1.Cells[12,j+1]:='X' else stringgrid1.Cells[12,j+1]:='';
    if mainform.devices[i].hasWhite then stringgrid1.Cells[13,j+1]:='X' else stringgrid1.Cells[13,j+1]:='';
    if mainform.devices[i].hasUV then stringgrid1.Cells[14,j+1]:='X' else stringgrid1.Cells[14,j+1]:='';
    if mainform.devices[i].hasFog then stringgrid1.Cells[15,j+1]:='X' else stringgrid1.Cells[15,j+1]:='';
    if mainform.devices[i].hasPANTILT then stringgrid1.Cells[16,j+1]:='X' else stringgrid1.Cells[16,j+1]:='';
    if mainform.devices[i].hasColor then stringgrid1.Cells[17,j+1]:='X' else stringgrid1.Cells[17,j+1]:='';
    if mainform.devices[i].hasColor2 then stringgrid1.Cells[18,j+1]:='X' else stringgrid1.Cells[18,j+1]:='';
    if mainform.devices[i].hasGobo then stringgrid1.Cells[19,j+1]:='X' else stringgrid1.Cells[19,j+1]:='';
    if mainform.devices[i].hasGobo2 then stringgrid1.Cells[20,j+1]:='X' else stringgrid1.Cells[20,j+1]:='';
    if mainform.devices[i].autoscening then stringgrid1.Cells[21,j+1]:='X' else stringgrid1.Cells[21,j+1]:='';

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
    stringgrid1.Cells[12,j+1]:=temptext;
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
      if (ARow>0) and (ACol = 22) then
      begin
        stringgrid1.Canvas.Draw(Rect.Left, Rect.Top, dipswitch.Picture.Graphic);

        temp:=DeviceOrder[ARow-1].Startaddress;
        dipstate[1]:=BitSet(temp, 1);
        dipstate[2]:=BitSet(temp, 2);
        dipstate[3]:=BitSet(temp, 4);
        dipstate[4]:=BitSet(temp, 8);
        dipstate[5]:=BitSet(temp, 16);
        dipstate[6]:=BitSet(temp, 32);
        dipstate[7]:=BitSet(temp, 64);
        dipstate[8]:=BitSet(temp, 128);
        temp:=DeviceOrder[ARow-1].Startaddress shr 8;
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

procedure Tdevicelistform.SortDeviceOrder(iLo, iHi:integer);
var
  Lo, Hi: Integer;
  Pivot:Integer;
begin
  Lo := iLo;
  Hi := iHi;
  Pivot := DeviceOrder[(Lo + Hi) div 2].Startaddress;
  repeat
    while DeviceOrder[Lo].Startaddress < Pivot do Inc(Lo) ;
    while DeviceOrder[Hi].Startaddress > Pivot do Dec(Hi) ;
    if Lo <= Hi then
    begin
      // in folgenden drei Zeilen Arrayinhalte kopieren
      setlength(DeviceOrder,length(DeviceOrder)+1);
      DeviceOrder[length(DeviceOrder)-1].Startaddress:=DeviceOrder[Lo].Startaddress;
      DeviceOrder[length(DeviceOrder)-1].PositionInDeviceArray:=DeviceOrder[Lo].PositionInDeviceArray;
//      T := A[Lo];
      DeviceOrder[Lo].Startaddress:=DeviceOrder[Hi].Startaddress;
      DeviceOrder[Lo].PositionInDeviceArray:=DeviceOrder[Hi].PositionInDeviceArray;
//      A[Hi] := T;
      DeviceOrder[Hi].Startaddress:=DeviceOrder[length(DeviceOrder)-1].Startaddress;
      DeviceOrder[Hi].PositionInDeviceArray:=DeviceOrder[length(DeviceOrder)-1].PositionInDeviceArray;
      setlength(DeviceOrder,length(DeviceOrder)-1);
      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > iLo then SortDeviceOrder(iLo, Hi);
  if Lo < iHi then SortDeviceOrder(Lo, iHi);
end;

end.
