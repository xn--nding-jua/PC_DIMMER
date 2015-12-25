unit sidebarselectfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, HSLColorPicker, ExtCtrls, Buttons, PngSpeedButton,
  pngimage, gnugettext, TiledImage, Math, ComCtrls,
  dxGDIPlusClasses, PngBitBtn;

const
  SmallWidth=15;
  SmallHeight=55;
  HugeWidth=250;
  HugeHeight=300;

type
  Tsidebarselectform = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    PngSpeedButton1: TPngSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    Image1: TImage;
    Image2: TImage;
    TiledImage1: TTiledImage;
    ListBox1: TListBox;
    AddBtn: TPngBitBtn;
    EditBtn: TPngBitBtn;
    DeleteBtn: TPngBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PngSpeedButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TiledImage1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngSpeedButton1Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AddBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    timer:byte;
    procedure SelectionChanged;
  public
    { Public-Deklarationen }
  end;

var
  sidebarselectform: Tsidebarselectform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tsidebarselectform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);

  sidebarselectform.ClientWidth:=SmallWidth;
  sidebarselectform.ClientHeight:=SmallHeight;
end;

procedure Tsidebarselectform.FormClick(Sender: TObject);
begin
  if sidebarselectform.ClientWidth=HugeWidth then
  begin
    sidebarselectform.ClientWidth:=SmallWidth;
    sidebarselectform.ClientHeight:=SmallHeight;
    PngSpeedButton1.Down:=false;
    Timer1.Enabled:=false;
    timer:=0;
  end else
  begin
    sidebarselectform.ClientWidth:=HugeWidth;
    sidebarselectform.ClientHeight:=HugeHeight;
    sidebarselectform.BringToFront;
  end;

  sidebarselectform.Left:=screen.Width-sidebarselectform.ClientWidth;
  sidebarselectform.Top:=mainform.top+mainform.dxRibbon1.height+SmallHeight+SmallHeight;
end;

procedure Tsidebarselectform.FormShow(Sender: TObject);
begin
  sidebarselectform.Left:=screen.Width-sidebarselectform.ClientWidth;
  sidebarselectform.Top:=mainform.top+mainform.dxRibbon1.height+SmallHeight+SmallHeight;
end;

procedure Tsidebarselectform.Timer1Timer(Sender: TObject);
begin
  if timer>=2 then
  begin
    Timer1.Enabled:=false;
    timer:=0;
    PngSpeedButton1.Down:=false;
    sidebarselectform.ClientWidth:=SmallWidth;
    sidebarselectform.ClientHeight:=SmallHeight;
    sidebarselectform.Left:=screen.Width-sidebarselectform.ClientWidth;
    sidebarselectform.Top:=mainform.top+mainform.dxRibbon1.height+SmallHeight+SmallHeight;
  end;

  timer:=timer+1;
end;

procedure Tsidebarselectform.PngSpeedButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormMouseMove(nil, [], 0,0);
end;

procedure Tsidebarselectform.Shape1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormClick(nil);
end;

procedure Tsidebarselectform.TiledImage1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled:=not PngSpeedButton1.Down;
  timer:=0;
end;

procedure Tsidebarselectform.PngSpeedButton1Click(Sender: TObject);
begin
  FormMouseMove(nil, [], 0,0);
end;

procedure Tsidebarselectform.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  Timer1.Enabled:=not PngSpeedButton1.Down;
  timer:=0;
  sidebarselectform.ClientWidth:=HugeWidth;
  sidebarselectform.ClientHeight:=HugeHeight;
  sidebarselectform.BringToFront;

  if (Shift=[]) and (not PngSpeedButton1.Down) then
  begin
    sidebarselectform.Left:=screen.Width-sidebarselectform.ClientWidth;
    sidebarselectform.Top:=mainform.top+mainform.dxRibbon1.height+SmallHeight+SmallHeight;
  end else
  begin
    PngSpeedButton1.Down:=true;
    ReleaseCapture;
    sidebarselectform.Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure Tsidebarselectform.AddBtnClick(Sender: TObject);
var
  i:integer;
begin
  setlength(mainform.DeviceSelectedIDs, length(mainform.DeviceSelectedIDs)+1);
  setlength(mainform.DeviceSelectedIDsName, length(mainform.DeviceSelectedIDsName)+1);
  for i:=0 to length(mainform.devices)-1 do
  if mainform.DeviceSelected[i] then
  begin
    setlength(mainform.DeviceSelectedIDs[length(mainform.DeviceSelectedIDs)-1], length(mainform.DeviceSelectedIDs[length(mainform.DeviceSelectedIDs)-1])+1);
    mainform.DeviceSelectedIDs[length(mainform.DeviceSelectedIDs)-1][length(mainform.DeviceSelectedIDs[length(mainform.DeviceSelectedIDs)-1])-1]:=mainform.devices[i].ID;
  end;
  mainform.DeviceSelectedIDsName[length(mainform.DeviceSelectedIDsName)-1]:=_('Neue Geräteselektion (')+DateToStr(now)+' '+TimeToStr(now)+')';
  Listbox1.Items.Add(mainform.DeviceSelectedIDsName[length(mainform.DeviceSelectedIDsName)-1]);
end;

procedure Tsidebarselectform.EditBtnClick(Sender: TObject);
begin
  if (Listbox1.itemindex>=0) and (Listbox1.itemindex<length(mainform.DeviceSelectedIDsName)) then
  begin
    mainform.DeviceSelectedIDsName[Listbox1.itemindex]:=InputBox(_('Selektionsbeschriftung ändern'),_('Bitte geben Sie eine neue Bezeichnung für diese Selektion ein:'),mainform.DeviceSelectedIDsName[Listbox1.itemindex]);
    Listbox1.Items[Listbox1.itemindex]:=mainform.DeviceSelectedIDsName[Listbox1.itemindex];
  end;
end;

procedure Tsidebarselectform.DeleteBtnClick(Sender: TObject);
var
  i,j:integer;
begin
  if (Listbox1.itemindex>=0) and (Listbox1.itemindex<length(mainform.DeviceSelectedIDs)) then
  begin
    for i:=Listbox1.itemindex to length(mainform.DeviceSelectedIDs)-2 do
    begin
      mainform.DeviceSelectedIDsName[i]:=mainform.DeviceSelectedIDsName[i+1];
      setlength(mainform.DeviceSelectedIDs[i], length(mainform.DeviceSelectedIDs[i+1]));

      for j:=0 to length(mainform.DeviceSelectedIDs[i])-1 do
      begin
        mainform.DeviceSelectedIDs[i][j]:=mainform.DeviceSelectedIDs[i+1][j];
      end;
    end;
    setlength(mainform.DeviceSelectedIDs, length(mainform.DeviceSelectedIDs)-1);
    setlength(mainform.DeviceSelectedIDsName, length(mainform.DeviceSelectedIDsName)-1);
    Listbox1.DeleteSelected;
  end;
end;

procedure Tsidebarselectform.ListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SelectionChanged;
end;

procedure Tsidebarselectform.SelectionChanged;
var
  i,j:integer;
begin
  if (Listbox1.itemindex>=0) and (Listbox1.itemindex<length(mainform.DeviceSelectedIDs)) then
  begin
    for i:=0 to length(mainform.devices)-1 do
    begin
      mainform.DeviceSelected[i]:=false;
    end;

    for i:=0 to length(mainform.DeviceSelectedIDs[Listbox1.itemindex])-1 do
    begin
      for j:=0 to length(mainform.devices)-1 do
      begin
        if IsEqualGUID(mainform.DeviceSelectedIDs[Listbox1.itemindex][i], mainform.devices[j].ID) then
        begin
          mainform.DeviceSelected[j]:=true;
          break;
        end;
      end;
    end;
    mainform.DeviceSelectionChanged(nil);
  end;
end;

procedure Tsidebarselectform.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SelectionChanged;
end;

end.
