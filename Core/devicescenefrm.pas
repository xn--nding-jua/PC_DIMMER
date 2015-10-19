{$WARN COMPARING_SIGNED_UNSIGNED OFF}
{$WARN COMBINING_SIGNED_UNSIGNED OFF}

unit devicescenefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, gnugettext, pngimage,
  JvExControls, JvGradient, Buttons, PngBitBtn, befehleditorform2,
  VirtualTrees, Menus, Grids;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: byte; // 0=Vendor, 1=Type, 2=Device, 3=Channel
    DataType: integer; // 0=Devicechannel, 1=Groupchannel, 2=Befehlwert
    Caption:WideString;
    ID:TGUID;
    ChannelInDevice:integer;
  end;

  Tdevicesceneform = class(TForm)
    Panel1: TPanel;
    scenefade_timelabel: TLabel;
    Szenenname: TLabeledEdit;
    scenefade_time: TEdit;
    scenefade_time_min: TEdit;
    scenefade_time_h: TEdit;
    scenefade_time_msec: TEdit;
    Szenenbeschreibung: TLabeledEdit;
    OKBtn: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Button6: TButton;
    Button5: TButton;
    Panel4: TPanel;
    Button7: TButton;
    Label9: TLabel;
    ProgressBar1: TProgressBar;
    Panel5: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Button8: TButton;
    VST: TVirtualStringTree;
    selectedmenu: TPopupMenu;
    AktuellerKanalwert1: TMenuItem;
    activatedmenu: TPopupMenu;
    AktuelleWerte1: TMenuItem;
    deaktivieren1: TMenuItem;
    wholescenemenu: TPopupMenu;
    beinhaltetnurseitletzterSzenegenderteKanle1: TMenuItem;
    beinhaltetalleKanle1: TMenuItem;
    ChangedChannels: TTimer;
    beinhaltetseitletzterSzenegenderteKanleundaktuellselektierteGerte1: TMenuItem;
    beinhaltetnurderzeitselektierteGerte1: TMenuItem;
    matrixpanel: TPanel;
    Panel6: TPanel;
    StringGrid1: TStringGrid;
    SetAllChansBtn: TButton;
    ResetAllChansBtn: TButton;
    OnlyChangedChansBtn: TButton;
    Treeviewpanel: TPanel;
    Panel7: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox2: TGroupBox;
    Button4: TButton;
    Button9: TButton;
    Button1: TButton;
    Button10: TButton;
    GroupBox4: TGroupBox;
    AddBefehl: TPngBitBtn;
    DeleteBefehl: TPngBitBtn;
    EditBefehl: TPngBitBtn;
    Panel3: TPanel;
    cancelmatrixbtn: TButton;
    usematrixchannels: TButton;
    Panel8: TPanel;
    GroupBox3: TGroupBox;
    ListBox2: TListBox;
    Button15: TButton;
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure input_number(var pos:integer; var s:string);
    procedure input_number_minus(var pos:integer; var s:string);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure EditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit5KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure AddBefehlClick(Sender: TObject);
    procedure EditBefehlClick(Sender: TObject);
    procedure DeleteBefehlClick(Sender: TObject);
    procedure CopyBefehl(Source, Destination: integer; KeepID:boolean);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VSTPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure VSTKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure VSTDblClick(Sender: TObject);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VSTMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure beinhaltetalleKanle1Click(Sender: TObject);
    procedure Button9MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure beinhaltetnurseitletzterSzenegenderteKanle1Click(
      Sender: TObject);
    procedure ChangedChannelsTimer(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure beinhaltetseitletzterSzenegenderteKanleundaktuellselektierteGerte1Click(
      Sender: TObject);
    procedure beinhaltetnurderzeitselektierteGerte1Click(Sender: TObject);
    procedure ListBox2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure Button10Click(Sender: TObject);
    procedure usematrixchannelsClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetAllChansBtnClick(Sender: TObject);
    procedure ResetAllChansBtnClick(Sender: TObject);
    procedure OnlyChangedChansBtnClick(Sender: TObject);
    procedure cancelmatrixbtnClick(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    VSTCurrentNode: PVirtualNode;
    VSTVendorNodes: array of PVirtualNode;
    VSTTypeNodes: array of array of PVirtualNode;
    VSTDeviceNodes: array of array of array of PVirtualNode;
    VSTChannelNodes: array of array of array of array of PVirtualNode;

    ChannelMatrixAvailable:array of array of boolean;
    ChannelMatrixEnabled:array of array of boolean;
    UsedChannelList:array of string;

    procedure CheckButtons;
    procedure RefreshTreeNew;
    procedure WMMoving(var AMsg: TMessage); message WM_MOVING;
    procedure RefreshMatrix;
//    PROCEDURE TextRotOut(Canvas: TCanvas; x, y: INTEGER; Angle: INTEGER; FontName: TFontName; FontSize: INTEGER; FontStyle: TFontStyles; s: STRING);
    procedure StringGridRotateTextOut(Grid: TStringGrid; ARow, ACol: Integer; Rect: TRect; Schriftart: string; Size: Integer; Color: TColor; Alignment: TAlignment);
//    procedure StringGridRotateTextOut2(Grid:TStringGrid;ARow,ACol:Integer;Rect:TRect; Schriftart:String;Size:Integer;Color:TColor;Alignment:TAlignment);
    function GetAbsolutChannelNumber(Channelname:string):integer;
  public
    { Public-Deklarationen }
  end;

var
  devicesceneform: Tdevicesceneform;

implementation

uses PCDIMMER, geraetesteuerungfrm, buehnenansicht, ddfwindowfrm;

{$R *.dfm}

{
PROCEDURE Tdevicesceneform.TextRotOut(Canvas: TCanvas; x, y: INTEGER; Angle: INTEGER; FontName: TFontName; FontSize: INTEGER; FontStyle: TFontStyles; s: STRING);
CONST
  FONTWEIGHT: ARRAY[BOOLEAN] OF INTEGER = (FW_NORMAL, FW_BOLD);
VAR
  DC             : HDC;
  HFont, HFontOld: INTEGER;
begin
  IF (Length(s)>0) THEN
  begin
    DC := Canvas.Handle;
    SetBkMode(DC, Transparent);
    HFont := CreateFont(-FontSize,  // height
    0,          // width
    Angle*10,   // escapement
    0,          // orientation
    FONTWEIGHT[fsBold IN FontStyle],
    Ord(fsItalic    IN FontStyle),
    Ord(fsUnderline IN FontStyle),
    Ord(fsStrikeout IN FontStyle),
    1,          // char set
    4,          // output precision
    $10,        // clip precision
    2,          // quality
    4,          // pitch and family
    PCHAR(FontName));
    HFontOld := SelectObject(DC, HFont);
    TextOut(DC, x, y, PCHAR(s), Length(s));
    SelectObject(DC, HFontOld);
    DeleteObject(HFont)
  end
end;
}

// Display text vertically in StringGrid cells
// Vertikale Textausgabe in den Zellen eines StringGrid
procedure Tdevicesceneform.StringGridRotateTextOut(Grid: TStringGrid; ARow, ACol: Integer; Rect: TRect;
  Schriftart: string; Size: Integer; Color: TColor; Alignment: TAlignment);
var
  lf: TLogFont;
  tf: TFont;
begin
  // if the font is to big, resize it
  // wenn Schrift zu groß dann anpassen
//  if (Size > Grid.ColWidths[ACol] div 2) then
//    Size := Grid.ColWidths[ACol] div 2;
  with Grid.Canvas do
  begin
    // Replace the font
    // Font setzen
    Font.Name := Schriftart;
    Font.Size := Size;
    Font.Color := Color;
    tf := TFont.Create;
    try
      tf.Assign(Font);
      GetObject(tf.Handle, SizeOf(lf), @lf);
      lf.lfEscapement  := 900;
      lf.lfOrientation := 0;
      tf.Handle := CreateFontIndirect(lf);
      Font.Assign(tf);
    finally
      tf.Free;
    end;
    // fill the rectangle
    // Rechteck füllen
    FillRect(Rect);
    // Align text and write it
    // Text nach Ausrichtung ausgeben
    if Alignment = taLeftJustify then
      TextRect(Rect, Rect.Left + 2,Rect.Bottom - 2,Grid.Cells[ACol, ARow]);
    if Alignment = taCenter then
      TextRect(Rect, Rect.Left + Grid.ColWidths[ACol] div 2 - Size +
        Size div 3,Rect.Bottom - 2,Grid.Cells[ACol, ARow]);
    if Alignment = taRightJustify then
      TextRect(Rect, Rect.Right - Size - Size div 2 - 2,Rect.Bottom -
        2,Grid.Cells[ACol, ARow]);
  end;
end;

// 2. Alternative: Display text vertically in StringGrid cells
// 2. Variante: Vertikale Textausgabe in den Zellen eines StringGrid
{
procedure Tdevicesceneform.StringGridRotateTextOut2(Grid:TStringGrid;ARow,ACol:Integer;Rect:TRect;
          Schriftart:String;Size:Integer;Color:TColor;Alignment:TAlignment);
var
    NewFont, OldFont : Integer;
    FontStyle, FontItalic, FontUnderline, FontStrikeout: Integer;
begin
   // if the font is to big, resize it
   // wenn Schrift zu groß dann anpassen
   If (Size > Grid.ColWidths[ACol] DIV 2) Then
       Size := Grid.ColWidths[ACol] DIV 2;
   with Grid.Canvas do
   begin
       // Set font
       // Font setzen
       If (fsBold IN Font.Style) Then
          FontStyle := FW_BOLD
       Else
          FontStyle := FW_NORMAL;

       If (fsItalic IN Font.Style) Then
          FontItalic := 1
       Else
          FontItalic := 0;

       If (fsUnderline IN Font.Style) Then
          FontUnderline := 1
       Else
          FontUnderline := 0;

       If (fsStrikeOut IN Font.Style) Then
          FontStrikeout:=1
       Else
          FontStrikeout:=0;

       Font.Color := Color;

       NewFont := CreateFont(Size, 0, 900, 0, FontStyle, FontItalic,
                             FontUnderline, FontStrikeout, DEFAULT_CHARSET,
                             OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
                             DEFAULT_PITCH, PChar(Schriftart));

       OldFont := SelectObject(Handle, NewFont);
       // fill the rectangle
       // Rechteck füllen
       FillRect(Rect);
       // Write text depending on the alignment
       // Text nach Ausrichtung ausgeben
       If Alignment = taLeftJustify Then
          TextRect(Rect,Rect.Left+2,Rect.Bottom-2,Grid.Cells[ACol,ARow]);
       If Alignment = taCenter Then
          TextRect(Rect,Rect.Left+Grid.ColWidths[ACol] DIV 2 - Size + Size DIV 3,
            Rect.Bottom-2,Grid.Cells[ACol,ARow]);
       If Alignment = taRightJustify Then
          TextRect(Rect,Rect.Right-Size - Size DIV 2 - 2,Rect.Bottom-2,Grid.Cells[ACol,ARow]);

       // Recreate reference to the old font
       // Referenz auf alten Font wiederherstellen
       SelectObject(Handle, OldFont);
       // Recreate reference to the new font
       // Referenz auf neuen Font löschen
       DeleteObject(NewFont);
   end;
end;
}

procedure Tdevicesceneform.Edit1Enter(Sender: TObject);
begin
  if Edit1.text=_('Suchtext hier eingeben...') then
  begin
    Edit1.Text:='';
    Edit1.Font.Color:=clBlack;
  end;
end;

procedure Tdevicesceneform.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text='' then
  begin
    Edit1.Text:=_('Suchtext hier eingeben...');
    Edit1.Font.Color:=clGray;
  end;
end;

procedure Tdevicesceneform.CheckButtons;
var
  i,position:integer;
  Data:PTreeData;
begin
  label3.caption:='...';
  label5.caption:='...';

  checkbox1.Checked:=false;
  checkbox2.Checked:=false;
  checkbox3.Checked:=false;
  checkbox2.enabled:=false;
  checkbox3.enabled:=false;
  edit2.Text:='0';
  edit3.Text:='0';
  edit4.Text:='0';
  edit5.Text:='-1';
  edit2.Enabled:=false;
  edit3.Enabled:=false;
  edit4.Enabled:=false;
  edit5.Enabled:=false;

  EditBefehl.Enabled:=false;
  DeleteBefehl.Enabled:=false;

  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);
  if Data^.NodeType=2 then
  begin
    // Ist 3. Stufe
    if Data^.DataType=0 then
    begin
      // ist ein Gerät
      label3.caption:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].Name;

      DDFWindowDeviceScene.top:=devicesceneform.Top;
      DDFWindowDeviceScene.left:=devicesceneform.Left+devicesceneform.Width;
      DDFWindowDeviceScene.loadddf(Data^.ID);
      devicesceneform.SetFocus;
    end;

    if Data^.DataType=1 then
    begin
      // ist eine Gruppe
      label3.caption:=mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].Name;
    end;

    if Data^.DataType=2 then
    begin
      // ist ein Befehl
      position:=0;
      for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[i].ID, Data^.ID) then
        begin
          position:=i;
          break;
        end;
      end;

      // ist Befehls-Kanal
      label3.caption:=mainform.AktuelleDeviceScene.Befehle[position].Name;
      label5.caption:=mainform.AktuelleDeviceScene.Befehle[position].Beschreibung;
    end;
  end;

  if Data^.NodeType=3 then
  begin
    // Ist 4. Stufe
    if Data^.DataType=0 then
    begin
      // ist ein Geräte-Kanal
      label3.caption:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].Name;
      label5.caption:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].Kanalname[Data^.ChannelInDevice];

      // ist ein Kanal
      DDFWindowDeviceScene.top:=devicesceneform.Top;
      DDFWindowDeviceScene.left:=devicesceneform.Left+devicesceneform.Width;
      DDFWindowDeviceScene.loadddf(Data^.ID);
      devicesceneform.SetFocus;

      for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) then
        begin
          Checkbox1.checked:=mainform.AktuelleDeviceScene.Devices[i].ChanActive[Data^.ChannelInDevice];
          edit2.Text:=inttostr(round(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]/255*100));
          edit3.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]);
          edit4.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanDelay[Data^.ChannelInDevice]);
          edit4.Enabled:=Checkbox1.checked;
          edit5.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]);
          edit5.Enabled:=Checkbox1.checked;
          checkbox2.enabled:=Checkbox1.checked;
          checkbox3.enabled:=Checkbox1.checked;
          Checkbox2.Checked:=mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom[Data^.ChannelInDevice];
          Checkbox3.Checked:=mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom[Data^.ChannelInDevice];
          edit2.Enabled:=Checkbox1.checked;
          edit3.Enabled:=Checkbox1.checked;
          break;
        end;
      end;
    end;

    if Data^.DataType=1 then
    begin
      // ist ein Gruppen-Kanal
      label3.caption:=mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].Name;
      label5.caption:=mainform.DeviceChannelNames[Data^.ChannelInDevice];

      for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].ID) then
        begin
          Checkbox1.checked:=mainform.AktuelleDeviceScene.Devices[i].ChanActive[Data^.ChannelInDevice];
          edit2.Text:=inttostr(round(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]/255*100));
          edit3.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]);
          edit4.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanDelay[Data^.ChannelInDevice]);
          edit4.Enabled:=Checkbox1.checked;
          edit5.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]);
          edit5.Enabled:=Checkbox1.checked;
          checkbox2.enabled:=Checkbox1.checked;
          checkbox3.enabled:=Checkbox1.checked;
          Checkbox2.Checked:=mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom[Data^.ChannelInDevice];
          Checkbox3.Checked:=mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom[Data^.ChannelInDevice];
          edit2.Enabled:=Checkbox1.checked;
          edit3.Enabled:=Checkbox1.checked;
          break;
        end;
      end;
    end;

    if Data^.DataType=2 then
    begin
      // ist ein Befehl
      position:=0;
      for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[i].ID, Data^.ID) then
        begin
          position:=i;
          break;
        end;
      end;

      label3.caption:=mainform.AktuelleDeviceScene.Befehle[position].Name;
      label5.caption:=mainform.AktuelleDeviceScene.Befehle[position].Beschreibung;

      Checkbox1.checked:=mainform.AktuelleDeviceScene.Befehlswerte[position].ChanActive[Data^.ChannelInDevice];
      EditBefehl.Enabled:=Checkbox1.checked;
      DeleteBefehl.Enabled:=Checkbox1.checked;
      edit2.Text:=inttostr(round(mainform.AktuelleDeviceScene.Befehlswerte[position].ChanValue[Data^.ChannelInDevice]/255*100));
      edit3.Text:=inttostr(mainform.AktuelleDeviceScene.Befehlswerte[position].ChanValue[Data^.ChannelInDevice]);
      edit4.Text:=inttostr(mainform.AktuelleDeviceScene.Befehlswerte[position].ChanDelay[Data^.ChannelInDevice]);
      edit4.Enabled:=Checkbox1.checked;
      edit5.Text:=inttostr(mainform.AktuelleDeviceScene.Befehlswerte[position].ChanFadetime[Data^.ChannelInDevice]);
      edit5.Enabled:=Checkbox1.checked;
      checkbox2.enabled:=Checkbox1.checked;
      checkbox3.enabled:=Checkbox1.checked;
      Checkbox2.Checked:=mainform.AktuelleDeviceScene.Befehlswerte[position].ChanActiveRandom[Data^.ChannelInDevice];
      Checkbox3.Checked:=mainform.AktuelleDeviceScene.Befehlswerte[position].ChanValueRandom[Data^.ChannelInDevice];
      edit2.Enabled:=Checkbox1.checked;
      edit3.Enabled:=Checkbox1.checked;
    end;
  end;
end;

procedure Tdevicesceneform.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j,k,l,m,n, deviceposition:integer;
  exists,active:boolean;
  devicesfordelete:array of TGUID;
  Data:PTreeData;
begin
  for l:=0 to length(VSTChannelNodes)-1 do
  for m:=0 to length(VSTChannelNodes[l])-1 do
  for n:=0 to length(VSTChannelNodes[l][m])-1 do
  for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
  begin
    if not VST.Selected[VSTChannelNodes[l][m][n][k]] then continue;
    Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

    if (Data^.NodeType=3) then
    begin
      // 4. Stufe
      if Data^.DataType=0 then
      begin
        // ist Gerät
        // Existiert Gerät schon?
        exists:=false;
        for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) then
          begin
            exists:=true;
            break;
          end;
        end;
        deviceposition:=geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID);
        if checkbox1.Checked and not exists then
        begin
          // Gerät erzeugen/aktivieren
          setlength(mainform.AktuelleDeviceScene.Devices,length(mainform.AktuelleDeviceScene.Devices)+1);
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanActive,mainform.devices[deviceposition].MaxChan);
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanValue,mainform.devices[deviceposition].MaxChan);
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanActiveRandom,mainform.devices[deviceposition].MaxChan);
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanValueRandom,mainform.devices[deviceposition].MaxChan);
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanDelay,mainform.devices[deviceposition].MaxChan);
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanFadetime,mainform.devices[deviceposition].MaxChan);
          mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ID:=mainform.devices[deviceposition].ID;
        end;

        for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,mainform.devices[deviceposition].ID) then
          begin
            mainform.AktuelleDeviceScene.Devices[i].ChanActive[Data^.ChannelInDevice]:=Checkbox1.Checked;
            mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[deviceposition].ID, mainform.devices[deviceposition].kanaltyp[Data^.ChannelInDevice]);
            edit2.Enabled:=Checkbox1.Checked;
            edit2.Text:=inttostr(round(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]/255*100));
            edit3.Enabled:=Checkbox1.Checked;
            edit4.Enabled:=Checkbox1.Checked;
            edit5.Enabled:=Checkbox1.Checked;
            if checkbox1.Checked then
            begin
              mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]:=-1;
            end else
            begin
              // wenn kein Kanal mehr aktiviert, Gerät löschen
              active:=false;
              for j:=0 to length(mainform.AktuelleDeviceScene.Devices[i].ChanActive)-1 do
              begin
                if mainform.AktuelleDeviceScene.Devices[i].ChanActive[j] then
                  active:=true;
              end;

              if not active then
              begin // Kein Kanal des aktuellen Gerätes wird mehr verwendet
                setlength(devicesfordelete,length(devicesfordelete)+1);
                devicesfordelete[length(devicesfordelete)-1]:=mainform.AktuelleDeviceScene.Devices[i].ID;
              end;
            end;
            edit3.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]);
            edit4.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanDelay[Data^.ChannelInDevice]);
            edit5.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]);
            break;
          end;
        end;
      end;

      if Data^.DataType=1 then
      begin
        // Existiert Gruppe schon?
        exists:=false;
        for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].ID) then
          begin
            exists:=true;
            break;
          end;
        end;
        deviceposition:=geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID);
        if checkbox1.Checked and not exists then
        begin
          // Gruppe innerhalb Gerät erzeugen/aktivieren
          setlength(mainform.AktuelleDeviceScene.Devices,length(mainform.AktuelleDeviceScene.Devices)+1);
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanActive,length(mainform.DeviceChannelNames));
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanValue,length(mainform.DeviceChannelNames));
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanActiveRandom,length(mainform.DeviceChannelNames));
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanValueRandom,length(mainform.DeviceChannelNames));
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanDelay,length(mainform.DeviceChannelNames));
          setlength(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanFadetime,length(mainform.DeviceChannelNames));
          mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ID:=mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].ID;

          for i:=0 to length(mainform.DeviceChannelNames)-1 do
            mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanDelay[i]:=-1;
        end;

        for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,mainform.devicegroups[deviceposition].ID) then
          begin
            mainform.AktuelleDeviceScene.Devices[i].ChanActive[Data^.ChannelInDevice]:=Checkbox1.Checked;
            edit2.Enabled:=Checkbox1.Checked;
            edit2.Text:=inttostr(round(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]/255*100));
            edit3.Enabled:=Checkbox1.Checked;
            edit4.Enabled:=Checkbox1.Checked;
            edit5.Enabled:=Checkbox1.Checked;
            if checkbox1.Checked then
            begin
              mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]:=-1;
            end else
            begin
              // wenn kein Kanal mehr aktiviert, Gerät löschen
              active:=false;
              for j:=0 to length(mainform.AktuelleDeviceScene.Devices[i].ChanActive)-1 do
              begin
                if mainform.AktuelleDeviceScene.Devices[i].ChanActive[j] then
                  active:=true;
              end;

              if not active then
              begin // Kein Kanal des aktuellen Gerätes wird mehr verwendet
                setlength(devicesfordelete,length(devicesfordelete)+1);
                devicesfordelete[length(devicesfordelete)-1]:=mainform.AktuelleDeviceScene.Devices[i].ID;
              end;
            end;
            edit3.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]);
            edit4.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanDelay[Data^.ChannelInDevice]);
            edit5.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]);
            break;
          end;
        end;
      end;

      if (Data^.DataType=2) then
      begin
        // Befehl
        for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[i].ID,Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive[Data^.ChannelInDevice]:=Checkbox1.Checked;
            edit2.Enabled:=Checkbox1.Checked;
            edit2.Text:=inttostr(round(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[Data^.ChannelInDevice]/255*100));
            edit3.Enabled:=Checkbox1.Checked;
            edit4.Enabled:=Checkbox1.Checked;
            edit5.Enabled:=Checkbox1.Checked;

            if checkbox1.Checked then
            begin
              mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[Data^.ChannelInDevice]:=-1;
            end;
            edit3.Text:=inttostr(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[Data^.ChannelInDevice]);
            edit4.Text:=inttostr(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[Data^.ChannelInDevice]);
            edit5.Text:=inttostr(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[Data^.ChannelInDevice]);
          end;
        end;
      end;
    end;
  end;

  // Nicht mehr benötigte Geräte löschen
  for i:=0 to length(devicesfordelete)-1 do
  begin
    for j:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
    begin
      if IsEqualGUID(devicesfordelete[i],mainform.AktuelleDeviceScene.Devices[j].ID) then
      begin
        // Gerät in Array gefunden
        if j<length(mainform.AktuelleDeviceScene.Devices)-1 then
        begin
          // letztes Element hier einfügen
          mainform.AktuelleDeviceScene.Devices[j].ID:=mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ID;
          setlength(mainform.AktuelleDeviceScene.Devices[j].ChanActive,length(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanActive));
          for k:=0 to length(mainform.AktuelleDeviceScene.Devices[j].ChanActive)-1 do
            mainform.AktuelleDeviceScene.Devices[j].ChanActive[k]:=mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanActive[k];

          setlength(mainform.AktuelleDeviceScene.Devices[j].ChanValue,length(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanValue));
          for k:=0 to length(mainform.AktuelleDeviceScene.Devices[j].ChanValue)-1 do
            mainform.AktuelleDeviceScene.Devices[j].ChanValue[k]:=mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanValue[k];

          setlength(mainform.AktuelleDeviceScene.Devices[j].ChanActiveRandom,length(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanActiveRandom));
          for k:=0 to length(mainform.AktuelleDeviceScene.Devices[j].ChanActiveRandom)-1 do
            mainform.AktuelleDeviceScene.Devices[j].ChanActiveRandom[k]:=mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanActiveRandom[k];

          setlength(mainform.AktuelleDeviceScene.Devices[j].ChanValueRandom,length(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanValueRandom));
          for k:=0 to length(mainform.AktuelleDeviceScene.Devices[j].ChanValueRandom)-1 do
            mainform.AktuelleDeviceScene.Devices[j].ChanValueRandom[k]:=mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanValueRandom[k];

          setlength(mainform.AktuelleDeviceScene.Devices[j].ChanDelay,length(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanDelay));
          for k:=0 to length(mainform.AktuelleDeviceScene.Devices[j].ChanDelay)-1 do
            mainform.AktuelleDeviceScene.Devices[j].ChanDelay[k]:=mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanDelay[k];

          setlength(mainform.AktuelleDeviceScene.Devices[j].ChanFadetime,length(mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanFadetime));
          for k:=0 to length(mainform.AktuelleDeviceScene.Devices[j].ChanFadetime)-1 do
            mainform.AktuelleDeviceScene.Devices[j].ChanFadetime[k]:=mainform.AktuelleDeviceScene.Devices[length(mainform.AktuelleDeviceScene.Devices)-1].ChanFadetime[k];
        end;
        // Array um eins kürzen
        setlength(mainform.AktuelleDeviceScene.Devices,length(mainform.AktuelleDeviceScene.Devices)-1);
        break;
      end;
    end;
  end;
  setlength(devicesfordelete,0);

  VST.Refresh;
end;

procedure Tdevicesceneform.input_number(var pos:integer; var s:string);
var
  i:integer;
begin
  i:=1;
  while i<=length(s) do
    begin
      if (s[i]<'0') or (s[i]>'9') then
        begin
          delete(s,i,1);
          dec(pos);
        end
      else
        inc(i);
    end;
end;

procedure Tdevicesceneform.input_number_minus(var pos:integer; var s:string);
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

procedure Tdevicesceneform.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tdevicesceneform.Button1Click(Sender: TObject);
begin
//  if messagedlg(_('Alle Geräte dieser Szene werden deaktiviert. Dabei gehen alle eingestellten Gerätewerte der Szene verloren. Fortfahren?'),mtConfirmation,
//  [mbYes,mbNo],0)=mrYes then
  begin
    setlength(mainform.AktuelleDeviceScene.Devices,0);
//    RefreshTreeNew;
    CheckButtons;
    VST.Refresh;
  end;
end;

procedure Tdevicesceneform.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
  s:string;
  pressedkey:word;
begin
  if (TEdit(Sender).text='') then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  if strtoint(TEdit(Sender).text)>100 then
    TEdit(Sender).text:='100';

  Edit3.Text:=inttostr(round(strtoint(TEdit(Sender).Text)*2.55));
  pressedkey:=0;
  Edit3KeyUp(Edit3, pressedkey, []);

  if Key=vk_return then
    ModalResult:=mrOK;
end;

procedure Tdevicesceneform.Button3Click(Sender: TObject);
var
  i,j,k:integer;
begin
//  if messagedlg(_('Die Werte aller aktivierten Geräte werden auf die aktuellen Werte gesetzt. Fortfahren?'),mtConfirmation,
//    [mbYes,mbNo],0)=mrYes then
  begin
    for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
    begin
      for j:=0 to length(mainform.devices)-1 do
      if IsEqualGUID(mainform.devices[j].ID,mainform.AktuelleDeviceScene.Devices[i].ID) then
      begin
        for k:=0 to length(mainform.AktuelleDeviceScene.Devices[i].ChanActive)-1 do
        if mainform.AktuelleDeviceScene.Devices[i].ChanActive[k] then
        begin
          mainform.AktuelleDeviceScene.Devices[i].ChanValue[k]:=255-mainform.data.ch[mainform.devices[j].Startaddress+k];
        end;
        break;
      end;
    end;
    CheckButtons;
  end;
  VST.Refresh;
end;

procedure Tdevicesceneform.RefreshTreeNew;
var
  i,j:integer;
  vendornode, typenode, devicenode, channelnode:PVirtualNode;
  vendornodeok, typenodeok:integer;
  Data:PTreeData;
begin
  VST.BeginUpdate;

  VST.Clear;
  VST.NodeDataSize:=SizeOf(TTreeData);
  setlength(VSTVendorNodes,0);
  setlength(VSTTypeNodes,0);
  setlength(VSTDeviceNodes,0);
  setlength(VSTChannelNodes,0);

  ///////////////////////////////////////////////////////////////////////////
  // Geräte hinzufügen
  for i:=0 to length(mainform.devices)-1 do
  begin
    vendornodeok:=-1;
    typenodeok:=-1;
    // Herausfinden, ob für Vendor schon ein RootNode vorhanden ist
    for j:=0 to length(VSTVendorNodes)-1 do
    begin
      Data:=VST.GetNodeData(VSTVendorNodes[j]);
      if (Data^.Caption=mainform.devices[i].vendor) then
      begin
        vendornode:=VSTVendorNodes[j];
        vendornodeok:=j;
        break;
      end;
    end;

    // Wenn kein VendorNode verfügbar -> erstellen
    if vendornodeok=-1 then
    begin
      vendornode:=VST.AddChild(nil);
      Data:=VST.GetNodeData(vendornode);
      Data^.NodeType:=0;
      Data^.DataType:=-1;
      Data^.Caption:=mainform.devices[i].Vendor;
      Data^.ChannelInDevice:=-1;
      Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');

      setlength(VSTVendorNodes, length(VSTVendorNodes)+1);
      setlength(VSTTypeNodes, length(VSTTypeNodes)+1);
      setlength(VSTDeviceNodes, length(VSTDeviceNodes)+1);
      setlength(VSTChannelNodes, length(VSTChannelNodes)+1);
      VSTVendorNodes[length(VSTVendorNodes)-1]:=vendornode;
      vendornodeok:=length(VSTVendorNodes)-1;
    end;

    // Herausfinden, ob für Type schon ein Sub-Node vorhanden ist
    for j:=0 to length(VSTTypeNodes[vendornodeok])-1 do
    begin
      Data:=VST.GetNodeData(VSTTypeNodes[vendornodeok][j]);
      if (Data^.Caption=mainform.devices[i].DeviceName) then
      begin
        typenode:=VSTTypeNodes[vendornodeok][j];
        typenodeok:=j;
        break;
      end;
    end;

    // Wenn kein TypeNode verfügbar -> erstellen
    if typenodeok=-1 then
    begin
      typenode:=VST.AddChild(vendornode);
      Data:=VST.GetNodeData(typenode);
      Data^.NodeType:=1;
      Data^.DataType:=-1;
      Data^.Caption:=mainform.devices[i].DeviceName;
      Data^.ChannelInDevice:=-1;
      Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');

      setlength(VSTTypeNodes[vendornodeok], length(VSTTypeNodes[vendornodeok])+1);
      setlength(VSTDeviceNodes[vendornodeok], length(VSTDeviceNodes[vendornodeok])+1);
      setlength(VSTChannelNodes[vendornodeok], length(VSTChannelNodes[vendornodeok])+1);
      VSTTypeNodes[vendornodeok][length(VSTTypeNodes[vendornodeok])-1]:=typenode;
      typenodeok:=length(VSTTypeNodes[vendornodeok])-1;
    end;

    // Neuen Device-SubSubNode für Gerät erstellen
    devicenode:=VST.AddChild(typenode);
    Data:=VST.GetNodeData(devicenode);
    Data^.NodeType:=2;
    Data^.DataType:=0;
    Data^.Caption:=mainform.devices[i].Name;
    Data^.ID:=mainform.devices[i].ID;
    setlength(VSTDeviceNodes[vendornodeok][typenodeok], length(VSTDeviceNodes[vendornodeok][typenodeok])+1);
    setlength(VSTChannelNodes[vendornodeok][typenodeok], length(VSTChannelNodes[vendornodeok][typenodeok])+1);
    VSTDeviceNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1]:=devicenode;

    // Kanäle des Gerätes hinzufügen
    for j:=0 to length(mainform.devices[i].kanalname)-1 do
    begin
      channelnode:=VST.AddChild(devicenode);
      Data:=VST.GetNodeData(channelnode);
      Data^.NodeType:=3;
      Data^.DataType:=0;
      Data^.Caption:=mainform.devices[i].kanalname[j];
      Data^.ID:=mainform.devices[i].ID;
      Data^.ChannelInDevice:=j;

      setlength(VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1], length(VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1])+1);
      VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1][length(VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1])-1]:=channelnode;
    end;
  end;

  ///////////////////////////////////////////////////////////////////////////
  // Gerätegruppen hinzufügen
  for i:=0 to length(mainform.devicegroups)-1 do
  begin
    vendornodeok:=-1;
    typenodeok:=-1;

    // Herausfinden, ob für Device-Vendor schon ein Top-Node vorhanden ist
    for j:=0 to length(VSTVendorNodes)-1 do
    begin
      Data:=VST.GetNodeData(VSTVendorNodes[j]);
      if (Data^.Caption=_('Programmintern')) and (Data^.NodeType=0) then
      begin
        vendornode:=VSTVendorNodes[j];
        vendornodeok:=j;
        break;
      end;
    end;

    // Wenn kein DeviceVendorNode verfügbar -> erstellen
    if vendornodeok=-1 then
    begin
      vendornode:=VST.AddChild(nil);
      Data:=VST.GetNodeData(vendornode);
      Data^.NodeType:=0;
      Data^.DataType:=-1;
      Data^.Caption:=_('Programmintern');
      Data^.ChannelInDevice:=-1;
      Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');

      setlength(VSTVendorNodes, length(VSTVendorNodes)+1);
      setlength(VSTTypeNodes, length(VSTTypeNodes)+1);
      setlength(VSTDeviceNodes, length(VSTDeviceNodes)+1);
      setlength(VSTChannelNodes, length(VSTChannelNodes)+1);
      VSTVendorNodes[length(VSTVendorNodes)-1]:=vendornode;
      vendornodeok:=length(VSTVendorNodes)-1;
    end;

    // Herausfinden, ob für DeviceTyp schon ein Sub-Node vorhanden ist
    for j:=0 to length(VSTTypeNodes[vendornodeok])-1 do
    begin
      Data:=VST.GetNodeData(VSTTypeNodes[vendornodeok][j]);
      if (Data^.Caption=_('Gerätegruppen')) and (Data^.NodeType=1) then
      begin
        typenode:=VSTTypeNodes[vendornodeok][j];
        typenodeok:=j;
        break;
      end;
    end;

    // Wenn kein DeviceTypNode verfügbar -> erstellen
    if typenodeok=-1 then
    begin
      typenode:=VST.AddChild(vendornode);
      Data:=VST.GetNodeData(typenode);
      Data^.NodeType:=1;
      Data^.DataType:=-1;
      Data^.Caption:=_('Gerätegruppen');
      Data^.ChannelInDevice:=-1;
      Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');

      setlength(VSTTypeNodes[vendornodeok], length(VSTTypeNodes[vendornodeok])+1);
      setlength(VSTDeviceNodes[vendornodeok], length(VSTDeviceNodes[vendornodeok])+1);
      setlength(VSTChannelNodes[vendornodeok], length(VSTChannelNodes[vendornodeok])+1);
      VSTTypeNodes[vendornodeok][length(VSTTypeNodes[vendornodeok])-1]:=typenode;
      typenodeok:=length(VSTTypeNodes[vendornodeok])-1;
    end;

    // Neuen Device-SubSubNode für Gruppe erstellen
    devicenode:=VST.AddChild(typenode);
    Data:=VST.GetNodeData(devicenode);
    Data^.NodeType:=2;
    Data^.DataType:=1;
    Data^.Caption:=mainform.devicegroups[i].Name;
    Data^.ID:=mainform.devicegroups[i].ID;
    setlength(VSTDeviceNodes[vendornodeok][typenodeok], length(VSTDeviceNodes[vendornodeok][typenodeok])+1);
    setlength(VSTChannelNodes[vendornodeok][typenodeok], length(VSTChannelNodes[vendornodeok][typenodeok])+1);
    VSTDeviceNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1]:=devicenode;

    // Kanäle des Gerätes hinzufügen
    for j:=0 to length(mainform.DeviceChannelNames)-1 do
    begin
      channelnode:=VST.AddChild(devicenode);
      Data:=VST.GetNodeData(channelnode);
      Data^.NodeType:=3;
      Data^.DataType:=1;
      Data^.Caption:=mainform.DeviceChannelNames[j];
      Data^.ID:=mainform.devicegroups[i].ID;
      Data^.ChannelInDevice:=j;

      setlength(VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1], length(VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1])+1);
      VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1][length(VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1])-1]:=channelnode;
    end;
  end;


  ///////////////////////////////////////////////////////////////////////////
  // Befehle hinzufügen
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
  begin
    vendornodeok:=-1;
    typenodeok:=-1;

    // Herausfinden, ob für Device-Vendor schon ein Top-Node vorhanden ist
    for j:=0 to length(VSTVendorNodes)-1 do
    begin
      Data:=VST.GetNodeData(VSTVendorNodes[j]);
      if (Data^.Caption=_('Programmintern')) and (Data^.NodeType=0) then
      begin
        vendornode:=VSTVendorNodes[j];
        vendornodeok:=j;
        break;
      end;
    end;

    // Wenn kein DeviceVendorNode verfügbar -> erstellen
    if vendornodeok=-1 then
    begin
      vendornode:=VST.AddChild(nil);
      Data:=VST.GetNodeData(vendornode);
      Data^.NodeType:=0;
      Data^.DataType:=-1;
      Data^.Caption:=_('Programmintern');
      Data^.ChannelInDevice:=-1;
      Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');

      setlength(VSTVendorNodes, length(VSTVendorNodes)+1);
      setlength(VSTTypeNodes, length(VSTTypeNodes)+1);
      setlength(VSTDeviceNodes, length(VSTDeviceNodes)+1);
      setlength(VSTChannelNodes, length(VSTChannelNodes)+1);
      VSTVendorNodes[length(VSTVendorNodes)-1]:=vendornode;
      vendornodeok:=length(VSTVendorNodes)-1;
    end;

    // Herausfinden, ob für DeviceTyp schon ein Sub-Node vorhanden ist
    for j:=0 to length(VSTTypeNodes[vendornodeok])-1 do
    begin
      Data:=VST.GetNodeData(VSTTypeNodes[vendornodeok][j]);
      if (Data^.Caption=_('Szenenbefehle')) and (Data^.NodeType=1) then
      begin
        typenode:=VSTTypeNodes[vendornodeok][j];
        typenodeok:=j;
        break;
      end;
    end;

    // Wenn kein DeviceTypNode verfügbar -> erstellen
    if typenodeok=-1 then
    begin
      typenode:=VST.AddChild(vendornode);
      Data:=VST.GetNodeData(typenode);
      Data^.NodeType:=1;
      Data^.DataType:=-1;
      Data^.Caption:=_('Szenenbefehle');
      Data^.ChannelInDevice:=-1;
      Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');

      setlength(VSTTypeNodes[vendornodeok], length(VSTTypeNodes[vendornodeok])+1);
      setlength(VSTDeviceNodes[vendornodeok], length(VSTDeviceNodes[vendornodeok])+1);
      setlength(VSTChannelNodes[vendornodeok], length(VSTChannelNodes[vendornodeok])+1);
      VSTTypeNodes[vendornodeok][length(VSTTypeNodes[vendornodeok])-1]:=typenode;
      typenodeok:=length(VSTTypeNodes[vendornodeok])-1;
    end;

    // Neuen Device-SubSubNode für Befehl erstellen
    devicenode:=VST.AddChild(typenode);
    Data:=VST.GetNodeData(devicenode);
    Data^.NodeType:=2;
    Data^.DataType:=2;
    Data^.Caption:=mainform.AktuelleDeviceScene.Befehle[i].Name;
    Data^.ID:=mainform.AktuelleDeviceScene.Befehle[i].ID;
    setlength(VSTDeviceNodes[vendornodeok][typenodeok], length(VSTDeviceNodes[vendornodeok][typenodeok])+1);
    setlength(VSTChannelNodes[vendornodeok][typenodeok], length(VSTChannelNodes[vendornodeok][typenodeok])+1);
    VSTDeviceNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1]:=devicenode;

    // Kanal des Befehls hinzufügen
    channelnode:=VST.AddChild(devicenode);
    Data:=VST.GetNodeData(channelnode);
    Data^.NodeType:=3;
    Data^.DataType:=2;
    Data^.Caption:=_('Wert');
    Data^.ID:=mainform.AktuelleDeviceScene.Befehle[i].ID;
    Data^.ChannelInDevice:=0;

    setlength(VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1], length(VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1])+1);
    VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1][length(VSTChannelNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1])-1]:=channelnode;
  end;

  VST.EndUpdate;

  if VST.RootNodeCount>0 then
    VST.Selected[VSTCurrentNode]:=true
  else
    ShowMessage(_('Es sind derzeit keine Geräte installiert.'+#10#13#10#13+'Bitte fügen Sie mindestens ein Gerät über die Gerätesteuerung hinzu, damit die Geräteszene aufgerufen werden kann.'));
end;

procedure Tdevicesceneform.Edit3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,j,k,l,m,n:integer;
  s:string;
  Data:PTreeData;
begin
  if (TEdit(Sender).text='') then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  if strtoint(TEdit(Sender).text)>255 then
    TEdit(Sender).text:='255';

  edit2.text:=inttostr(round(strtoint(Edit3.text)*100/255));

  for l:=0 to length(VSTChannelNodes)-1 do
  for m:=0 to length(VSTChannelNodes[l])-1 do
  for n:=0 to length(VSTChannelNodes[l][m])-1 do
  for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
  begin
    if not VST.Selected[VSTChannelNodes[l][m][n][k]] then continue;
    Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

    if (Data^.NodeType=3) then
    begin
      if (Data^.DataType=0) or (Data^.DataType=1) then // Gerätekanal oder Gruppenkanal
      begin
        for j:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[j].ID, Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Devices[j].ChanValue[Data^.ChannelInDevice]:=strtoint(Edit3.text);
          end;
        end;
      end;

      if (Data^.DataType=2) then // Befehl
      begin
        for j:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[j].ID, Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Befehlswerte[j].ChanValue[Data^.ChannelInDevice]:=strtoint(Edit3.text);
          end;
        end;
      end;
    end;
  end;
  VST.Refresh;

  if Key=vk_return then
    ModalResult:=mrOK;
end;

procedure Tdevicesceneform.Button4Click(Sender: TObject);
var
  i,j,k,l,m,n:integer;
  Data:PTreeData;
begin
  for l:=0 to length(VSTChannelNodes)-1 do
  for m:=0 to length(VSTChannelNodes[l])-1 do
  for n:=0 to length(VSTChannelNodes[l][m])-1 do
  for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
  begin
    if not VST.Selected[VSTChannelNodes[l][m][n][k]] then continue;
    Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

    if (Data^.DataType=0) and (Data^.NodeType=3) then
    begin
      // ist ein Kanal
      for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) then
        begin
          for j:=0 to length(mainform.devices)-1 do
            if IsEqualGUID(mainform.devices[j].ID,mainform.AktuelleDeviceScene.Devices[i].ID) then
            begin
              mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);
              Edit2.Text:=inttostr(round(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]/255*100));
              Edit3.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]);
              Edit4.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanDelay[Data^.ChannelInDevice]);
              Edit5.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]);
            end;
          break;
        end;
      end;
    end;
  end;
  VST.Refresh;
end;

procedure Tdevicesceneform.WMMoving(var AMsg: TMessage);
begin
  if DDFWindowDeviceScene.showing then
  begin
    DDFWindowDeviceScene.top:=devicesceneform.Top;
    DDFWindowDeviceScene.left:=devicesceneform.Left+devicesceneform.Width;
  end;
end;

procedure Tdevicesceneform.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  deviceposition,delaytime:integer;
  i,j,k:integer;
begin
///////////////////
// PanFine / TiltFine-Fix
  for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
  begin
    deviceposition:=geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleDeviceScene.Devices[i].ID);
    if (deviceposition<0) or (deviceposition>length(mainform.devices)) then
      continue;

    if mainform.devices[deviceposition].hasPANTILT then
    begin
      for j:=0 to length(mainform.AktuelleDeviceScene.Devices[i].ChanActive)-1 do
      begin
        if mainform.AktuelleDeviceScene.Devices[i].ChanActive[j] and (lowercase(mainform.devices[deviceposition].kanaltyp[j])='panfine') then
        begin
          // PanFine soll verändert werden - ist Pan ebenfalls aktiviert?
          for k:=0 to length(mainform.AktuelleDeviceScene.Devices[i].ChanActive)-1 do
          begin
            if mainform.AktuelleDeviceScene.Devices[i].ChanActive[k] and (lowercase(mainform.devices[deviceposition].kanaltyp[k])='pan') then
            begin
              // PAN ist aktiviert -> also PanFine auf Einblendzeit=0 und Delay=Szenenzeit oder =Kanalzeit
              delaytime:=0;

              if mainform.AktuelleDeviceScene.Devices[i].ChanDelay[k]>=0 then
                delaytime:=mainform.AktuelleDeviceScene.Devices[i].ChanDelay[k];

              if mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[k]>=0 then
                delaytime:=delaytime+mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[k]
              else if mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[k]=-1 then
                delaytime:=delaytime+mainform.AktuelleDeviceScene.Fadetime;

              mainform.AktuelleDeviceScene.Devices[i].ChanDelay[j]:=delaytime;
              mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[j]:=0;
              break;
            end;
          end;
        end;
        if mainform.AktuelleDeviceScene.Devices[i].ChanActive[j] and (lowercase(mainform.devices[deviceposition].kanaltyp[j])='tiltfine') then
        begin
          // TiltFine soll verändert werden - ist Pan ebenfalls aktiviert?
          for k:=0 to length(mainform.AktuelleDeviceScene.Devices[i].ChanActive)-1 do
          begin
            if mainform.AktuelleDeviceScene.Devices[i].ChanActive[k] and (lowercase(mainform.devices[deviceposition].kanaltyp[k])='tilt') then
            begin
              // TILT ist aktiviert -> also PanFine auf Einblendzeit=0 und Delay=Szenenzeit
              delaytime:=0;

              if mainform.AktuelleDeviceScene.Devices[i].ChanDelay[k]>=0 then
                delaytime:=mainform.AktuelleDeviceScene.Devices[i].ChanDelay[k];

              if mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[k]>=0 then
                delaytime:=delaytime+mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[k]
              else if mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[k]=-1 then
                delaytime:=delaytime+mainform.AktuelleDeviceScene.Fadetime;

              mainform.AktuelleDeviceScene.Devices[i].ChanDelay[j]:=delaytime;
              mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[j]:=0;
              break;
            end;
          end;
        end;
      end;
    end;
  end;
///////////////////

  ChangedChannels.Enabled:=false;
  if DDFWindowDeviceScene.showing then
    DDFWindowDeviceScene.close;
end;

procedure Tdevicesceneform.Button6Click(Sender: TObject);
begin
  VST.FullCollapse(nil);
end;

procedure Tdevicesceneform.Button5Click(Sender: TObject);
begin
  VST.FullExpand(nil);
end;

procedure Tdevicesceneform.FormResize(Sender: TObject);
begin
  if DDFWindowDeviceScene.showing then
  begin
    DDFWindowDeviceScene.top:=devicesceneform.Top;
    DDFWindowDeviceScene.left:=devicesceneform.Left+devicesceneform.Width;
  end;
end;

procedure Tdevicesceneform.Button7Click(Sender: TObject);
var
  i,j,k,l,m:integer;
  Data: PTreeData;
begin
  VST.FullCollapse(nil);
  for i:=0 to length(VSTChannelNodes)-1 do
  for j:=0 to length(VSTChannelNodes[i])-1 do
  for k:=0 to length(VSTChannelNodes[i][j])-1 do
  for l:=0 to length(VSTChannelNodes[i][j][k])-1 do
  begin
    Data:=VST.GetNodeData(VSTChannelNodes[i][j][k][l]);

    if (Data^.NodeType=3) and ((Data^.DataType=0) or (Data^.DataType=1)) then
    begin
      for m:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[m].ID, Data^.ID) then
        begin
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent.Parent.Parent]:=true;
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent.Parent]:=true;
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent]:=true;
          break;
        end;
      end;
    end;
    if (Data^.NodeType=3) and (Data^.DataType=2) then
    begin
      for m:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[m].ID, Data^.ID) then
        begin
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent.Parent.Parent]:=true;
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent.Parent]:=true;
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent]:=true;
          break;
        end;
      end;
    end;
  end;
end;

procedure Tdevicesceneform.EditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
    ModalResult:=mrOK;
end;

procedure Tdevicesceneform.Edit4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,j,k,l,m,n:integer;
  s:string;
  Data:PTreeData;
begin
  if (TEdit(Sender).text='') then exit;
  if (TEdit(Sender).text='-') then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  for l:=0 to length(VSTChannelNodes)-1 do
  for m:=0 to length(VSTChannelNodes[l])-1 do
  for n:=0 to length(VSTChannelNodes[l][m])-1 do
  for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
  begin
    if not VST.Selected[VSTChannelNodes[l][m][n][k]] then continue;
    Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

    if (Data^.NodeType=3) then
    begin
      if (Data^.DataType=0) or (Data^.DataType=1) then // Gerätekanal oder Gruppenkanal
      begin
        for j:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[j].ID, Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Devices[j].ChanDelay[Data^.ChannelInDevice]:=strtoint(Edit4.text);
          end;
        end;
      end;

      if (Data^.DataType=2) then // Befehl
      begin
        for j:=0 to length(mainform.AktuelleDeviceScene.Befehlswerte)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[j].ID, Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Befehlswerte[j].ChanDelay[Data^.ChannelInDevice]:=strtoint(Edit4.text);
          end;
        end;
      end;
    end;
  end;
  VST.Refresh;

  if Key=vk_return then
    ModalResult:=mrOK;
end;

procedure Tdevicesceneform.Edit5KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,j,k,l,m,n:integer;
  s:string;
  Data:PTreeData;
begin
  if (TEdit(Sender).text='') then exit;
  if (TEdit(Sender).text='-') then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  for l:=0 to length(VSTChannelNodes)-1 do
  for m:=0 to length(VSTChannelNodes[l])-1 do
  for n:=0 to length(VSTChannelNodes[l][m])-1 do
  for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
  begin
    if not VST.Selected[VSTChannelNodes[l][m][n][k]] then continue;
    Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

    if (Data^.NodeType=3) then
    begin
      if (Data^.DataType=0) or (Data^.DataType=1) then // Gerätekanal oder Gruppenkanal
      begin
        for j:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[j].ID, Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Devices[j].ChanFadetime[Data^.ChannelInDevice]:=strtoint(Edit5.text);
          end;
        end;
      end;

      if (Data^.DataType=2) then // Befehl
      begin
        for j:=0 to length(mainform.AktuelleDeviceScene.Befehlswerte)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[j].ID, Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Befehlswerte[j].ChanFadetime[Data^.ChannelInDevice]:=strtoint(Edit5.text);
          end;
        end;
      end;
    end;
  end;
  VST.Refresh;

  if Key=vk_return then
    ModalResult:=mrOK;
end;

procedure Tdevicesceneform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tdevicesceneform.FormShow(Sender: TObject);
var
  i,j:integer;
  anyselected, anychanged:boolean;
begin
  ChangedChannels.Enabled:=true;
  RefreshTreeNew; // Baum neu zeichnen
  Button7Click(nil); // Alle aktiven Elemente ausklappen

  // Geräte für Matrix durchsuchen und herausfinden, welche Kanäle verwendet werden
  setlength(ChannelMatrixAvailable,length(mainform.DeviceChannelNames)+1);
  setlength(ChannelMatrixEnabled,length(mainform.DeviceChannelNames)+1);
  for i:=0 to length(ChannelMatrixAvailable)-1 do
  begin
    setlength(ChannelMatrixAvailable[i],length(mainform.devices)+1);
    setlength(ChannelMatrixEnabled[i],length(mainform.devices)+1);
  end;
  for i:=0 to length(ChannelMatrixEnabled)-1 do
  begin
    for j:=0 to length(ChannelMatrixEnabled[i])-1 do
    begin
      ChannelMatrixEnabled[i, j]:=false;
    end;
  end;
  matrixpanel.visible:=false;

  anyselected:=false;
  for i:=0 to length(mainform.DeviceSelected)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      anyselected:=true;
      break;
    end;
  end;
  beinhaltetnurderzeitselektierteGerte1.Enabled:=anyselected;

  anychanged:=false;
  for i:=1 to mainform.lastchan do
  begin
    if mainform.changedchannels[i] then
    begin
      anychanged:=true;
      break;
    end;
  end;

  // Szene nicht neu, sondern wird bearbeitet
  beinhaltetnurseitletzterSzenegenderteKanle1.Enabled:=(length(mainform.AktuelleDeviceScene.Devices)=0) and anychanged;
  beinhaltetseitletzterSzenegenderteKanleundaktuellselektierteGerte1.Enabled:=(length(mainform.AktuelleDeviceScene.Devices)=0) and (anychanged or anyselected);
end;

procedure Tdevicesceneform.Button8Click(Sender: TObject);
var
  i,j,t,positionindevicearray:integer;
begin
  for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
  begin
    positionindevicearray:=geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleDeviceScene.Devices[i].ID);

    for j:=0 to length(mainform.AktuelleDeviceScene.Devices[i].ChanActive)-1 do
    begin
      if mainform.AktuelleDeviceScene.Devices[i].ChanActive[j] then
      begin
        if mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[j]=-1 then
        begin
          t:=strtoint(scenefade_time_msec.Text);
          t:=t+1000*strtoint(scenefade_time.Text);
          t:=t+60*1000*strtoint(scenefade_time_min.Text);
          t:=t+60*60*1000*strtoint(scenefade_time_h.Text);

          if positionindevicearray>-1 then
            geraetesteuerung.set_channel(mainform.AktuelleDeviceScene.Devices[i].ID,mainform.Devices[positionindevicearray].kanaltyp[j],-1,mainform.AktuelleDeviceScene.Devices[i].ChanValue[j],t,mainform.AktuelleDeviceScene.Devices[i].ChanDelay[j])
          else
            geraetesteuerung.set_channel(mainform.AktuelleDeviceScene.Devices[i].ID,mainform.DeviceChannelNames[j],-1,mainform.AktuelleDeviceScene.Devices[i].ChanValue[j],t,mainform.AktuelleDeviceScene.Devices[i].ChanDelay[j]);
        end else
        begin
          if positionindevicearray>-1 then
            geraetesteuerung.set_channel(mainform.AktuelleDeviceScene.Devices[i].ID,mainform.Devices[positionindevicearray].kanaltyp[j],-1,mainform.AktuelleDeviceScene.Devices[i].ChanValue[j],mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[j],mainform.AktuelleDeviceScene.Devices[i].ChanDelay[j])
          else
            geraetesteuerung.set_channel(mainform.AktuelleDeviceScene.Devices[i].ID,mainform.DeviceChannelNames[j],-1,mainform.AktuelleDeviceScene.Devices[i].ChanValue[j],mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[j],mainform.AktuelleDeviceScene.Devices[i].ChanDelay[j]);
        end;
      end;
    end;
  end;

  // Szenenbefehle starten
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
  if mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive[0] then
  begin
    if mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[0]=-1 then
      mainform.StartDeviceSceneBefehl(mainform.AktuelleDeviceScene.Befehle[i].ID, mainform.AktuelleDeviceScene.Befehle[i].Typ, mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[0], mainform.AktuelleDeviceScene.Fadetime, mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[0])
    else
      mainform.StartDeviceSceneBefehl(mainform.AktuelleDeviceScene.Befehle[i].ID, mainform.AktuelleDeviceScene.Befehle[i].Typ, mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[0], mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[0], mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[0]);
  end;
end;

procedure Tdevicesceneform.AddBefehlClick(Sender: TObject);
begin
  setlength(mainform.AktuelleDeviceScene.Befehle,length(mainform.AktuelleDeviceScene.Befehle)+1);
  CreateGUID(mainform.AktuelleDeviceScene.Befehle[length(mainform.AktuelleDeviceScene.Befehle)-1].ID);
  setlength(mainform.AktuelleDeviceScene.Befehlswerte,length(mainform.AktuelleDeviceScene.Befehlswerte)+1);
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[length(mainform.AktuelleDeviceScene.Befehlswerte)-1].ChanActive,1);
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[length(mainform.AktuelleDeviceScene.Befehlswerte)-1].ChanValue,1);
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[length(mainform.AktuelleDeviceScene.Befehlswerte)-1].ChanActiveRandom,1);
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[length(mainform.AktuelleDeviceScene.Befehlswerte)-1].ChanValueRandom,1);
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[length(mainform.AktuelleDeviceScene.Befehlswerte)-1].ChanDelay,1);
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[length(mainform.AktuelleDeviceScene.Befehlswerte)-1].ChanFadetime,1);
  mainform.AktuelleDeviceScene.Befehle[length(mainform.AktuelleDeviceScene.Befehle)-1].Name:=_('Neuer Befehl');

  mainform.AktuelleDeviceScene.Befehle[length(mainform.AktuelleDeviceScene.Befehle)-1].OnValue:=255;
  mainform.AktuelleDeviceScene.Befehle[length(mainform.AktuelleDeviceScene.Befehle)-1].SwitchValue:=128;
  mainform.AktuelleDeviceScene.Befehle[length(mainform.AktuelleDeviceScene.Befehle)-1].OffValue:=0;
  mainform.AktuelleDeviceScene.Befehle[length(mainform.AktuelleDeviceScene.Befehle)-1].InvertSwitchValue:=false;
  mainform.AktuelleDeviceScene.Befehle[length(mainform.AktuelleDeviceScene.Befehle)-1].ScaleValue:=false;

  RefreshTreeNew;
  Button7Click(nil);
end;

procedure Tdevicesceneform.EditBefehlClick(Sender: TObject);
var
  i,j:integer;
  Data:PTreeData;
begin
  if VST.SelectedCount=0 then exit;
  
  Data:=VST.GetNodeData(VST.FocusedNode);
  if (Data^.DataType=2) and (Data^.NodeType=3) then
  begin
    j:=0;
    for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
    if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[i].ID, Data^.ID) then
    begin
      j:=i;
    end;

    setlength(befehlseditor_array2,length(befehlseditor_array2)+1);
    befehlseditor_array2[length(befehlseditor_array2)-1]:=Tbefehlseditor2.Create(self);
    befehlseditor_array2[length(befehlseditor_array2)-1].ShowInputValueToo:=true;

    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ID:=mainform.AktuelleDeviceScene.Befehle[j].ID;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Typ:=mainform.AktuelleDeviceScene.Befehle[j].Typ;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Name:=mainform.AktuelleDeviceScene.Befehle[j].Name;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Beschreibung:=mainform.AktuelleDeviceScene.Befehle[j].Beschreibung;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OnValue:=mainform.AktuelleDeviceScene.Befehle[j].OnValue;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OffValue:=mainform.AktuelleDeviceScene.Befehle[j].OffValue;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.SwitchValue:=mainform.AktuelleDeviceScene.Befehle[j].SwitchValue;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.InvertSwitchValue:=mainform.AktuelleDeviceScene.Befehle[j].InvertSwitchValue;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ScaleValue:=mainform.AktuelleDeviceScene.Befehle[j].ScaleValue;
    setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger,length(mainform.AktuelleDeviceScene.Befehle[j].ArgInteger));
    for i:=0 to length(mainform.AktuelleDeviceScene.Befehle[j].ArgInteger)-1 do
      befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger[i]:=mainform.AktuelleDeviceScene.Befehle[j].ArgInteger[i];
    setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString,length(mainform.AktuelleDeviceScene.Befehle[j].ArgString));
    for i:=0 to length(mainform.AktuelleDeviceScene.Befehle[j].ArgString)-1 do
      befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString[i]:=mainform.AktuelleDeviceScene.Befehle[j].ArgString[i];
    setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID,length(mainform.AktuelleDeviceScene.Befehle[j].ArgGUID));
    for i:=0 to length(mainform.AktuelleDeviceScene.Befehle[j].ArgGUID)-1 do
      befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID[i]:=mainform.AktuelleDeviceScene.Befehle[j].ArgGUID[i];

    befehlseditor_array2[length(befehlseditor_array2)-1].label13.visible:=true;
    befehlseditor_array2[length(befehlseditor_array2)-1].label8.visible:=true;
    befehlseditor_array2[length(befehlseditor_array2)-1].label12.visible:=true;
    befehlseditor_array2[length(befehlseditor_array2)-1].onvalue.visible:=true;
    befehlseditor_array2[length(befehlseditor_array2)-1].switchvalue.visible:=true;
    befehlseditor_array2[length(befehlseditor_array2)-1].offvalue.visible:=true;
    befehlseditor_array2[length(befehlseditor_array2)-1].invertswitchvalue.visible:=true;
    befehlseditor_array2[length(befehlseditor_array2)-1].scalevalue.visible:=true;

    befehlseditor_array2[length(befehlseditor_array2)-1].ShowModal;

    befehlseditor_array2[length(befehlseditor_array2)-1].label13.visible:=false;
    befehlseditor_array2[length(befehlseditor_array2)-1].label8.visible:=false;
    befehlseditor_array2[length(befehlseditor_array2)-1].label12.visible:=false;
    befehlseditor_array2[length(befehlseditor_array2)-1].onvalue.visible:=false;
    befehlseditor_array2[length(befehlseditor_array2)-1].switchvalue.visible:=false;
    befehlseditor_array2[length(befehlseditor_array2)-1].offvalue.visible:=false;
    befehlseditor_array2[length(befehlseditor_array2)-1].invertswitchvalue.visible:=false;
    befehlseditor_array2[length(befehlseditor_array2)-1].scalevalue.visible:=false;

    if befehlseditor_array2[length(befehlseditor_array2)-1].ModalResult=mrOK then
    begin
      mainform.AktuelleDeviceScene.Befehle[j].Typ:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Typ;
      mainform.AktuelleDeviceScene.Befehle[j].Name:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Name;
      mainform.AktuelleDeviceScene.Befehle[j].Beschreibung:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Beschreibung;
      mainform.AktuelleDeviceScene.Befehle[j].OnValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OnValue;
      mainform.AktuelleDeviceScene.Befehle[j].OffValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OffValue;
      mainform.AktuelleDeviceScene.Befehle[j].SwitchValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.SwitchValue;
      mainform.AktuelleDeviceScene.Befehle[j].InvertSwitchValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.InvertSwitchValue;
      mainform.AktuelleDeviceScene.Befehle[j].ScaleValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ScaleValue;
      setlength(mainform.AktuelleDeviceScene.Befehle[j].ArgInteger,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger));
      for i:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger)-1 do
        mainform.AktuelleDeviceScene.Befehle[j].ArgInteger[i]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger[i];
      setlength(mainform.AktuelleDeviceScene.Befehle[j].ArgString,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString));
      for i:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString)-1 do
        mainform.AktuelleDeviceScene.Befehle[j].ArgString[i]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString[i];
      setlength(mainform.AktuelleDeviceScene.Befehle[j].ArgGUID,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID));
      for i:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID)-1 do
        mainform.AktuelleDeviceScene.Befehle[j].ArgGUID[i]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID[i];
    end;

    befehlseditor_array2[length(befehlseditor_array2)-1].Free;
    setlength(befehlseditor_array2,length(befehlseditor_array2)-1);
  end;
  RefreshTreeNew;
end;

procedure Tdevicesceneform.DeleteBefehlClick(Sender: TObject);
var
  i,position:integer;
  Data:PTreeData;
begin
  if VST.SelectedCount=0 then exit;
  
  Data:=VST.GetNodeData(VST.FocusedNode);
  if ((Data^.DataType=2) and (Data^.NodeType=3)) or ((Data^.DataType=2) and (Data^.NodeType=2)) then
  begin
    position:=0;
    for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
    if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[i].ID, Data^.ID) then
    begin
      position:=i;
    end;

    for i:=position to length(mainform.AktuelleDeviceScene.Befehle)-2 do
    begin
      CopyBefehl(i+1, i, true);
    end;
    setlength(mainform.AktuelleDeviceScene.Befehle, length(mainform.AktuelleDeviceScene.Befehle)-1);
    setlength(mainform.AktuelleDeviceScene.Befehlswerte, length(mainform.AktuelleDeviceScene.Befehlswerte)-1);
  end;
  RefreshTreeNew;
end;

procedure Tdevicesceneform.CopyBefehl(Source, Destination: integer; KeepID:boolean);
var
  i:integer;
begin
  if KeepID then
    mainform.AktuelleDeviceScene.Befehle[Destination].ID:=mainform.AktuelleDeviceScene.Befehle[Source].ID
  else
    CreateGUID(mainform.AktuelleDeviceScene.Befehle[Destination].ID);
  mainform.AktuelleDeviceScene.Befehle[Destination].Typ:=mainform.AktuelleDeviceScene.Befehle[Source].Typ;
  mainform.AktuelleDeviceScene.Befehle[Destination].Name:=mainform.AktuelleDeviceScene.Befehle[Source].Name;
  mainform.AktuelleDeviceScene.Befehle[Destination].Beschreibung:=mainform.AktuelleDeviceScene.Befehle[Source].Beschreibung;
  mainform.AktuelleDeviceScene.Befehle[Destination].OnValue:=mainform.AktuelleDeviceScene.Befehle[Source].OnValue;
  mainform.AktuelleDeviceScene.Befehle[Destination].OffValue:=mainform.AktuelleDeviceScene.Befehle[Source].OffValue;
  mainform.AktuelleDeviceScene.Befehle[Destination].SwitchValue:=mainform.AktuelleDeviceScene.Befehle[Source].SwitchValue;
  mainform.AktuelleDeviceScene.Befehle[Destination].InvertSwitchValue:=mainform.AktuelleDeviceScene.Befehle[Source].InvertSwitchValue;
  mainform.AktuelleDeviceScene.Befehle[Destination].ScaleValue:=mainform.AktuelleDeviceScene.Befehle[Source].ScaleValue;

  setlength(mainform.AktuelleDeviceScene.Befehle[Destination].ArgInteger,length(mainform.AktuelleDeviceScene.Befehle[Source].ArgInteger));
  setlength(mainform.AktuelleDeviceScene.Befehle[Destination].ArgString,length(mainform.AktuelleDeviceScene.Befehle[Source].ArgString));
  setlength(mainform.AktuelleDeviceScene.Befehle[Destination].ArgGUID,length(mainform.AktuelleDeviceScene.Befehle[Source].ArgGUID));
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehle[Destination].ArgInteger)-1 do
    mainform.AktuelleDeviceScene.Befehle[Destination].ArgInteger[i]:=mainform.AktuelleDeviceScene.Befehle[Source].ArgInteger[i];
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehle[Destination].ArgString)-1 do
    mainform.AktuelleDeviceScene.Befehle[Destination].ArgString[i]:=mainform.AktuelleDeviceScene.Befehle[Source].ArgString[i];
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehle[Destination].ArgGUID)-1 do
    mainform.AktuelleDeviceScene.Befehle[Destination].ArgGUID[i]:=mainform.AktuelleDeviceScene.Befehle[Source].ArgGUID[i];

  mainform.AktuelleDeviceScene.Befehlswerte[Destination].ID:=mainform.AktuelleDeviceScene.Befehlswerte[Source].ID;

  setlength(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanActive,length(mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanActive));
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanValue,length(mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanValue));
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanActiveRandom,length(mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanActiveRandom));
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanValueRandom,length(mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanValueRandom));
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanDelay,length(mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanDelay));
  setlength(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanFadetime,length(mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanFadetime));

  for i:=0 to length(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanActive)-1 do
    mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanActive[i]:=mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanActive[i];
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanValue)-1 do
    mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanValue[i]:=mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanValue[i];
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanActiveRandom)-1 do
    mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanActiveRandom[i]:=mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanActiveRandom[i];
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanValueRandom)-1 do
    mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanValueRandom[i]:=mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanValueRandom[i];
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanDelay)-1 do
    mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanDelay[i]:=mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanDelay[i];
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanFadetime)-1 do
    mainform.AktuelleDeviceScene.Befehlswerte[Destination].ChanFadetime[i]:=mainform.AktuelleDeviceScene.Befehlswerte[Source].ChanFadetime[i];
end;

procedure Tdevicesceneform.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PTreeData;
  i:integer;
begin
  case Column of
    0:
    begin
      Data:=VST.GetNodeData(Node);
      if (Data^.NodeType=2) and (Data^.DataType=0) then
        CellText:=inttostr(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].Startaddress)+': '+Data^.Caption
      else
        CellText:=Data^.Caption;

      // Checkbox anzeigen
{
      if (Data^.ChannelInDevice>-1) then
      begin
        if Node.Parent.Parent.Parent=nil then
        begin
          Node.CheckType:=ctTriStateCheckBox;
          if not mainform.AktuelleDeviceScene.Devices[Data^.DeviceInScene].ChanActiveRandom[Data^.ChannelInDevice] then
            Node.CheckState:=csMixedNormal
          else
          begin
            if mainform.AktuelleDeviceScene.Devices[Data^.DeviceInScene].ChanActive[Data^.ChannelInDevice] then
              Node.CheckState:=csCheckedNormal
            else
              Node.CheckState:=csUncheckedNormal;
          end;
        end;
      end;
}
    end;
    1:
    begin
      // Werte anzeigen
      Data:=VST.GetNodeData(Node);

      case Data^.NodeType of
        3: // Channel
        begin
          CellText:='-';

          if (Data^.DataType=0) or (Data^.DataType=1) then
          begin
            for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
            begin
              if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              begin // Gerät gefunden
                if mainform.AktuelleDeviceScene.Devices[i].ChanActive[Data^.ChannelInDevice] then
                begin
                  if mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom[Data^.ChannelInDevice] then
                    CellText:=_('Zufall: ')+inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice])+' ('+mainform.levelstr(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice])+')'
                  else
                    CellText:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice])+' ('+mainform.levelstr(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice])+')';
                end;
                break;
              end;
            end;
          end;
          if (Data^.DataType=2) then
          begin
            for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
            begin
//              if IsEqualGUID(mainform.AktuelleDeviceScene.Befehlswerte[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              begin // Befehl gefunden
                if mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom[Data^.ChannelInDevice] then
                  CellText:=_('Zufall: ')+inttostr(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[Data^.ChannelInDevice])+' ('+mainform.levelstr(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[Data^.ChannelInDevice])+')'
                else
                  CellText:=inttostr(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[Data^.ChannelInDevice])+' ('+mainform.levelstr(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[Data^.ChannelInDevice])+')';
                break;
              end;
            end;
          end;
        end;
        else
          CellText:='';
      end;
    end;
    2:
    begin
      // Fadezeit anzeigen
      Data:=VST.GetNodeData(Node);

      case Data^.NodeType of
        3:
        begin
          CellText:='-';
          if (Data^.DataType=0) or (Data^.DataType=1) then
          begin
            for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
            begin
              if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              begin // Gerät gefunden
                if mainform.AktuelleDeviceScene.Devices[i].ChanActive[Data^.ChannelInDevice] then
                begin
                  if mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]=-1 then
                    CellText:=_('Szene')
                  else if mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]<-1 then
                    CellText:=_('Zufall: ')+mainform.MillisecondsToTimeShort(abs(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]))
                  else
                    CellText:=mainform.MillisecondsToTimeShort(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]);
                end;
                break;
              end;
            end;
          end;
          if (Data^.DataType=2) then
          begin
            for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
            begin
//              if IsEqualGUID(mainform.AktuelleDeviceScene.Befehlswerte[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              begin // Gerät gefunden
                  if mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[Data^.ChannelInDevice]=-1 then
                    CellText:=_('Szene')
                  else if mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[Data^.ChannelInDevice]<-1 then
                    CellText:=_('Zufall: ')+mainform.MillisecondsToTimeShort(abs(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[Data^.ChannelInDevice]))
                  else
                    CellText:=mainform.MillisecondsToTimeShort(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[Data^.ChannelInDevice]);
                break;
              end;
            end;
          end;
        end;
        else
          CellText:='';
      end;
    end;
    3:
    begin
      // Delay anzeigen
      Data:=VST.GetNodeData(Node);

      case Data^.NodeType of
        3:
        begin
          CellText:='-';
          if (Data^.DataType=0) or (Data^.DataType=1) then
          begin
            for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
            begin
              if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              begin // Gerät gefunden
                if mainform.AktuelleDeviceScene.Devices[i].ChanActive[Data^.ChannelInDevice] then
                begin
                  if mainform.AktuelleDeviceScene.Devices[i].ChanDelay[Data^.ChannelInDevice]<-1 then
                  begin
                    CellText:=_('Zufall: ')+mainform.MillisecondsToTimeShort(abs(mainform.AktuelleDeviceScene.Devices[i].ChanDelay[Data^.ChannelInDevice]));
                  end else if mainform.AktuelleDeviceScene.Devices[i].ChanDelay[Data^.ChannelInDevice]=-1 then
                  begin
                    CellText:=_('Gruppe');
                  end else
                    CellText:=mainform.MillisecondsToTimeShort(mainform.AktuelleDeviceScene.Devices[i].ChanDelay[Data^.ChannelInDevice]);
                end;
                break;
              end;
            end;
          end;
          if (Data^.DataType=2) then
          begin
            for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
            begin
//              if IsEqualGUID(mainform.AktuelleDeviceScene.Befehlswerte[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              begin // Gerät gefunden
                if mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[Data^.ChannelInDevice]<0 then
                  CellText:=_('Zufall: ')+mainform.MillisecondsToTimeShort(abs(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[Data^.ChannelInDevice]))
                else
                  CellText:=mainform.MillisecondsToTimeShort(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[Data^.ChannelInDevice]);
                break;
              end;
            end;
          end;
        end;
        else
          CellText:='';
      end;
    end;
  end;
end;

procedure Tdevicesceneform.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PTreeData;
  i:integer;
begin
  case Kind of ikNormal, ikSelected:
    case Column of
      0:
      begin
        Data:=VST.GetNodeData(Node);

        case Data^.NodeType of
          0: ImageIndex:=3;
          1: ImageIndex:=1;
          2:
          begin
            if (Data^.DataType=0) or (Data^.DataType=1) then
            begin
              // Geräte/Gruppen abklappern
              ImageIndex:=25;
              for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
              begin
                if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
                begin // Gerät gefunden
                  ImageIndex:=73;
                  break;
                end;
              end;
            end;
            if (Data^.DataType=2) then
            begin
              ImageIndex:=15;
              for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
              begin
                if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
                begin // Befehl gefunden
                  ImageIndex:=15;
                  break;
                end;
              end;
            end;
          end;
          3:
          begin
            if (Data^.DataType=0) or (Data^.DataType=1) then
            begin
              ImageIndex:=74;
              // Geräte/Gruppen abklappern
              for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
              begin
                if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
                begin // Gerät gefunden
                  if mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom[Data^.ChannelInDevice] then
                    ImageIndex:=105
                  else if mainform.AktuelleDeviceScene.Devices[i].ChanActive[Data^.ChannelInDevice] then
                    ImageIndex:=75
                  else
                    ImageIndex:=74;
                end;
              end;
            end;
            if Data^.DataType=2 then
            begin
              ImageIndex:=74;
              // Befehle abklappern
              for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
              begin
                if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
                begin // Gerät gefunden
                  if mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom[Data^.ChannelInDevice] then
                    ImageIndex:=105
                  else if mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive[Data^.ChannelInDevice] then
                    ImageIndex:=75
                  else
                    ImageIndex:=74;
                end;
              end;
            end;
          end;
        end;
      end;
{
      1: ImageIndex:=25;//if Sender.FocusedNode = Node then ImageIndex:=1;
      2: ImageIndex:=25;
      3: ImageIndex:=25;
}
      else
        ImageIndex:=-1;
    end;
  end;
end;

procedure Tdevicesceneform.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PTreeData;
begin
  with TargetCanvas do
    case Column of
      0:
      begin
        Data:=VST.GetNodeData(Node);

        if Data^.DataType=1 then
        begin
          if Data^.NodeType=3 then
          begin
            // ist ein Gruppen-Kanal
            if mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].HasChanType[Data^.ChannelInDevice] then
            begin
              Font.Color:=clBlack;
              Font.Style:=[fsBold];
            end else
            begin
              Font.Color:=clGray;
              Font.Style:=[];
            end;
          end else
          begin
            Font.Color:=clBlack;
            Font.Style:=[];
          end;
        end else
        begin
          if Data^.NodeType=3 then
          begin
            Font.Color:=clBlack;
            Font.Style:=[fsBold];
          end else
          begin
            Font.Color:=clBlack;
            Font.Style:=[];
          end;
        end;
      end;
      1:
      begin
        Font.Color:=clBlack;
        Font.Style:=[];
      end;
    end;
end;

procedure Tdevicesceneform.VSTKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_space then
  begin
    Checkbox1.Checked:=not checkbox1.Checked;
    Checkbox1Mouseup(nil,mbLeft,[],0,0);
  end;
  CheckButtons;
end;

procedure Tdevicesceneform.VSTDblClick(Sender: TObject);
begin
  Checkbox1.Checked:=not checkbox1.Checked;
  Checkbox1Mouseup(nil,mbLeft,[],0,0);
  CheckButtons;
end;

procedure Tdevicesceneform.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  k,j,l,m,n:integer;
  Data:PTreeData;
begin
  for l:=0 to length(VSTChannelNodes)-1 do
  for m:=0 to length(VSTChannelNodes[l])-1 do
  for n:=0 to length(VSTChannelNodes[l][m])-1 do
  for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
  begin
    if not VST.Selected[VSTChannelNodes[l][m][n][k]] then continue;
    Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

    if Data^.NodeType=3 then
    begin
      if Data^.DataType=0 then
      begin
        for j:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[j].ID, Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Devices[j].ChanActiveRandom[Data^.ChannelInDevice]:=Checkbox2.Checked;
          end;
        end;
      end;
      if Data^.DataType=1 then
      begin
        // Gruppe
        for j:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[j].ID, Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Devices[j].ChanActiveRandom[Data^.ChannelInDevice]:=Checkbox2.Checked;
          end;
        end;
      end;
      if Data^.DataType=2 then
      begin
        // Befehl
        for j:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[j].ID,Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Befehlswerte[j].ChanActiveRandom[Data^.ChannelInDevice]:=Checkbox2.Checked;
            break;
          end;
        end;
      end;
    end;
  end;
  VST.Refresh;
  CheckButtons;
end;

procedure Tdevicesceneform.CheckBox3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  k,j,l,m,n:integer;
  Data:PTreeData;
begin
  for l:=0 to length(VSTChannelNodes)-1 do
  for m:=0 to length(VSTChannelNodes[l])-1 do
  for n:=0 to length(VSTChannelNodes[l][m])-1 do
  for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
  begin
    if not VST.Selected[VSTChannelNodes[l][m][n][k]] then continue;
    Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

    if Data^.NodeType=3 then
    begin
      if Data^.DataType=0 then
      begin
        // Gerät
        for j:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[j].ID, Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Devices[j].ChanValueRandom[Data^.ChannelInDevice]:=Checkbox3.Checked;
          end;
        end;
      end;
      if Data^.DataType=1 then
      begin
        // Gruppe
        for j:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[j].ID, Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Devices[j].ChanValueRandom[Data^.ChannelInDevice]:=Checkbox3.Checked;
          end;
        end;
      end;
      if Data^.DataType=2 then
      begin
        // Befehl
        for j:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[j].ID,Data^.ID) then
          begin
            mainform.AktuelleDeviceScene.Befehlswerte[j].ChanValueRandom[Data^.ChannelInDevice]:=Checkbox3.Checked;
            break;
          end;
        end;
      end;
    end;
  end;
  VST.Refresh;
  CheckButtons;
end;

procedure Tdevicesceneform.VSTMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CheckButtons;
end;

procedure Tdevicesceneform.beinhaltetalleKanle1Click(Sender: TObject);
var
  i,j,k,l,m,n:integer;
  Data:PTreeData;
begin
//  if messagedlg(_('Es werden alle Kanäle der Szene hinzugefügt. Fortfahren?'),mtConfirmation,
//    [mbYes,mbNo],0)=mrYes then
  begin
    // Alle Geräte aktivieren
    VST.SelectAll(false);
    Checkbox1.Checked:=true;
    Checkbox1MouseUp(nil, mbLeft, [], 0, 0);
    VST.InvertSelection(false);

    // aktuelle Werte eintragen
    for l:=0 to length(VSTChannelNodes)-1 do
    for m:=0 to length(VSTChannelNodes[l])-1 do
    for n:=0 to length(VSTChannelNodes[l][m])-1 do
    for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
    begin
      Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

      if (Data^.DataType=0) and (Data^.NodeType=3) then
      begin
        // ist ein Kanal
        for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
        begin
          if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) then
          begin
            for j:=0 to length(mainform.devices)-1 do
            begin
              if IsEqualGUID(mainform.devices[j].ID,mainform.AktuelleDeviceScene.Devices[i].ID) then
              begin
                mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);
                Edit2.Text:=inttostr(round(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]/255*100));
                Edit3.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]);
                Edit4.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanDelay[Data^.ChannelInDevice]);
                Edit5.Text:=inttostr(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[Data^.ChannelInDevice]);
              end;
            end;
            break;
          end;
        end;
      end;
    end;

    CheckButtons;
    VST.Refresh;
  end;
end;

procedure Tdevicesceneform.Button9MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  activatedmenu.Popup(devicesceneform.Left+Treeviewpanel.left+panel2.left+GroupBox2.left+button9.Left+X,devicesceneform.Top+Treeviewpanel.top+panel2.top+GroupBox2.top+button9.Top+Y);
end;

procedure Tdevicesceneform.Button4MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  selectedmenu.Popup(devicesceneform.Left+panel2.left+GroupBox2.left+button4.Left+X,devicesceneform.Top+panel2.top+GroupBox2.top+button4.Top+Y);
end;

procedure Tdevicesceneform.Button1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  wholescenemenu.Popup(devicesceneform.Left+Treeviewpanel.left+panel2.left+GroupBox2.left+button1.Left+X,devicesceneform.Top+Treeviewpanel.top+panel2.top+GroupBox2.top+button1.Top+Y);
end;

procedure Tdevicesceneform.beinhaltetnurseitletzterSzenegenderteKanle1Click(
  Sender: TObject);
var
  i,j,k,l,m,n:integer;
  Data:PTreeData;
begin
//  if messagedlg(_('Es werden nur seit der letzten erstellten Szene geänderten Kanäle eingefügt. Fortfahren?'),mtConfirmation,
//    [mbYes,mbNo],0)=mrYes then
  begin
    // Alle Geräte aktivieren
    VST.SelectAll(false);
    Checkbox1.Checked:=false;
    Checkbox1MouseUp(nil, mbLeft, [], 0, 0);
    VST.InvertSelection(false);

    // nur geänderte Kanäle übriglassen
    for l:=0 to length(VSTChannelNodes)-1 do
    for m:=0 to length(VSTChannelNodes[l])-1 do
    for n:=0 to length(VSTChannelNodes[l][m])-1 do
    for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
    begin
      Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

      if (Data^.DataType=0) and (Data^.NodeType=3) then
      begin
        for j:=0 to length(mainform.devices)-1 do
        begin
          if IsEqualGUID(mainform.devices[j].ID, Data^.ID) then
          begin
            // Gerät gefunden
            if mainform.changedchannels[mainform.devices[j].startaddress+Data^.ChannelInDevice] then
            begin
              // Szenengerät erstellen
              VST.Selected[VSTChannelNodes[l][m][n][k]]:=true;
              Checkbox1.Checked:=true;
              Checkbox1MouseUp(nil, mbLeft, [], 0, 0);
              VST.Selected[VSTChannelNodes[l][m][n][k]]:=false;

              for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
              begin
                if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) then
                begin
                  // Eintrag in Array gefunden
                  mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);

                  break;
                end;
              end;
            end;
            
            break;
          end;
        end;
      end;
    end;

    // Markierung für geänderte Kanäle löschen
    for i:=1 to mainform.lastchan do
      mainform.changedchannels[i]:=false;

    CheckButtons;
    VST.Refresh;
    Button7Click(nil);
  end;
end;

procedure Tdevicesceneform.ChangedChannelsTimer(Sender: TObject);
var
  i:integer;
begin
  if Listbox2.Focused then exit;

  LockWindow(Listbox2.Handle);
  Listbox2.Clear;
  for i:=1 to mainform.lastchan do
  begin
    if mainform.changedchannels[i] then
      Listbox2.Items.Add(_('Kanal')+' '+inttostr(i)+' @ '+mainform.levelstr(mainform.channel_value[i]));
  end;
  UnlockWindow(Listbox2.Handle);
end;

procedure Tdevicesceneform.Button15Click(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to mainform.lastchan do
    mainform.changedchannels[i]:=false;
  ChangedChannelsTimer(nil);
end;

procedure Tdevicesceneform.beinhaltetseitletzterSzenegenderteKanleundaktuellselektierteGerte1Click(
  Sender: TObject);
var
  i,j,k,l,m,n:integer;
  Data:PTreeData;
begin
//  if messagedlg(_('Es werden nur seit der letzten erstellten Szene geänderte Kanäle und alle derzeit selektierten Geräte eingefügt. Fortfahren?'),mtConfirmation,
//    [mbYes,mbNo],0)=mrYes then
  begin
    // Alle Geräte deaktivieren
    VST.SelectAll(false);
    Checkbox1.Checked:=false;
    Checkbox1MouseUp(nil, mbLeft, [], 0, 0);
    VST.InvertSelection(false);

    // geänderte Kanäle und selektierte Geräte eintragen
    for l:=0 to length(VSTChannelNodes)-1 do
    for m:=0 to length(VSTChannelNodes[l])-1 do
    for n:=0 to length(VSTChannelNodes[l][m])-1 do
    for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
    begin
      Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

      if (Data^.DataType=0) and (Data^.NodeType=3) then
      begin
        for j:=0 to length(mainform.devices)-1 do
        begin
          if IsEqualGUID(mainform.devices[j].ID, Data^.ID) then
          begin
            // Gerät gefunden
            if (mainform.changedchannels[mainform.devices[j].startaddress+Data^.ChannelInDevice]) or (mainform.DeviceSelected[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.devices[j].ID)]) then
            begin
              // Szenengerät erstellen
              VST.Selected[VSTChannelNodes[l][m][n][k]]:=true;
              Checkbox1.Checked:=true;
              Checkbox1MouseUp(nil, mbLeft, [], 0, 0);
              VST.Selected[VSTChannelNodes[l][m][n][k]]:=false;

              for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
              begin
                if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) then
                begin
                  // Eintrag in Array gefunden
                  mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);

                  break;
                end;
              end;
            end;
            
            break;
          end;
        end;
      end;
    end;

    // Markierung für geänderte Kanäle löschen
    for i:=1 to mainform.lastchan do
      mainform.changedchannels[i]:=false;

    CheckButtons;
    VST.Refresh;
    Button7Click(nil);
  end;
end;

procedure Tdevicesceneform.beinhaltetnurderzeitselektierteGerte1Click(
  Sender: TObject);
var
  i,j,k,l,m,n:integer;
  Data:PTreeData;
begin
//  if messagedlg(_('Es werden nur die derzeit selektierten Geräte eingefügt. Fortfahren?'),mtConfirmation,
//    [mbYes,mbNo],0)=mrYes then
  begin
    // Alle Geräte deaktivieren
    VST.SelectAll(false);
    Checkbox1.Checked:=false;
    Checkbox1MouseUp(nil, mbLeft, [], 0, 0);
    VST.InvertSelection(false);

    // geänderte Kanäle und selektierte Geräte eintragen
    for l:=0 to length(VSTChannelNodes)-1 do
    for m:=0 to length(VSTChannelNodes[l])-1 do
    for n:=0 to length(VSTChannelNodes[l][m])-1 do
    for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
    begin
      Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

      if (Data^.DataType=0) and (Data^.NodeType=3) then
      begin
        for j:=0 to length(mainform.devices)-1 do
        begin
          if IsEqualGUID(mainform.devices[j].ID, Data^.ID) then
          begin
            // Gerät gefunden
            if (mainform.DeviceSelected[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.devices[j].ID)]) then
            begin
              // Szenengerät erstellen
              VST.Selected[VSTChannelNodes[l][m][n][k]]:=true;
              Checkbox1.Checked:=true;
              Checkbox1MouseUp(nil, mbLeft, [], 0, 0);
              VST.Selected[VSTChannelNodes[l][m][n][k]]:=false;

              for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
              begin
                if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) then
                begin
                  // Eintrag in Array gefunden
                  mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);

                  break;
                end;
              end;
            end;
            
            break;
          end;
        end;
      end;
    end;

    // Markierung für geänderte Kanäle löschen
    for i:=1 to mainform.lastchan do
      mainform.changedchannels[i]:=false;

    CheckButtons;
    VST.Refresh;
    Button7Click(nil);
  end;
end;

procedure Tdevicesceneform.ListBox2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Listbox2.SetFocus;
end;

procedure Tdevicesceneform.CreateParams(var Params:TCreateParams);
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

procedure Tdevicesceneform.Button10Click(Sender: TObject);
begin
  RefreshMatrix;
  matrixpanel.Visible:=true;
  matrixpanel.BringToFront;
end;

function Tdevicesceneform.GetAbsolutChannelNumber(Channelname:string):integer;
var
  i:integer;
begin
  result:=0;
  for i:=0 to length(UsedChannelList)-1 do
  begin
    if lowercase(UsedChannelList[i])=lowercase(Channelname) then
    begin
      result:=i;
      break;
    end;
  end;
end;

procedure Tdevicesceneform.usematrixchannelsClick(Sender: TObject);
var
  i,j,k,l,m,n:integer;
  Data:PTreeData;
begin
  matrixpanel.visible:=false;

  // Alle Geräte aktivieren
  VST.SelectAll(false);
  Checkbox1.Checked:=false;
  Checkbox1MouseUp(nil, mbLeft, [], 0, 0);
  VST.InvertSelection(false);

  // nur geänderte Kanäle übriglassen
  for l:=0 to length(VSTChannelNodes)-1 do
  for m:=0 to length(VSTChannelNodes[l])-1 do
  for n:=0 to length(VSTChannelNodes[l][m])-1 do
  for k:=0 to length(VSTChannelNodes[l][m][n])-1 do
  begin
    Data:=VST.GetNodeData(VSTChannelNodes[l][m][n][k]);

    if (Data^.DataType=0) and (Data^.NodeType=3) then
    begin
      for j:=0 to length(mainform.devices)-1 do
      begin
        if IsEqualGUID(mainform.devices[j].ID, Data^.ID) then
        begin
          // Gerät gefunden
          // ChannelMatrixEnabled[KANAL, j+1]             bzw.   [Channels, Devices]
          if ChannelMatrixEnabled[GetAbsolutChannelNumber(mainform.devices[j].kanaltyp[Data^.ChannelInDevice])+1, j+1] then
          begin
            // Szenengerät erstellen
            VST.Selected[VSTChannelNodes[l][m][n][k]]:=true;
            Checkbox1.Checked:=true;
            Checkbox1MouseUp(nil, mbLeft, [], 0, 0);
            VST.Selected[VSTChannelNodes[l][m][n][k]]:=false;

            for i:=0 to length(mainform.AktuelleDeviceScene.Devices)-1 do
            begin
              if IsEqualGUID(mainform.AktuelleDeviceScene.Devices[i].ID,Data^.ID) then
              begin
                // Eintrag in Array gefunden
                mainform.AktuelleDeviceScene.Devices[i].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);
                break;
              end;
            end;
          end;
          break;
        end;
      end;
    end;
  end;

  CheckButtons;
  VST.Refresh;
  Button7Click(nil);
end;

procedure Tdevicesceneform.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
	AOffSet : TPoint;
	AHaken1 : TPoint;
	AHaken2 : TPoint;
	AHaken3 : TPoint;
	ARect : TRect;
  i:integer;
begin
  // Geräte durchsuchen und herausfinden, welche Kanäle verwendet werden
  setlength(UsedChannelList,StringGrid1.ColCount-1);
  setlength(ChannelMatrixAvailable,length(mainform.DeviceChannelNames)+1);
  setlength(ChannelMatrixEnabled,length(mainform.DeviceChannelNames)+1);

  for i:=0 to length(ChannelMatrixAvailable)-1 do
  begin
    setlength(ChannelMatrixAvailable[i],length(mainform.devices)+1);
    setlength(ChannelMatrixEnabled[i],length(mainform.devices)+1);
  end;
  // ChannelMatrixAvailable[Col, Row]           bzw.   [Channels, Devices]
  // ChannelMatrixEnabled[Col, Row]             bzw.   [Channels, Devices]

  with StringGrid1.Canvas do
  begin
    if Rect.Top = 0 then
    begin
      Brush.Color := clBtnFace;
      FillRect(Rect);
      Pen.Color := clWhite;
      Rectangle(Rect);
      if (ARow=0) and (ACol>0) then
        StringGridRotateTextOut(StringGrid1, ARow, ACol, Rect, 'Arial', 8, clBlack, taLeftJustify)
      else
        TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
      Exit;
    end;

{
    if (ARow=0) and (ACol>0) then
    begin
      StringGridRotateTextOut(StringGrid1, ARow, ACol, Rect, 'ARIAL', 8, clBlack, taLeftJustify);
      //StringGridRotateTextOut(StringGrid1, ARow, ACol, Rect, 'ARIAL', 8, clBlack, taCenter);
      //StringGridRotateTextOut(StringGrid1, ARow, ACol, Rect, 'ARIAL', 8, clBlack, taRightJustify);
      //TextRotOut(StringGrid1.Canvas, StringGrid1.Col*15+125, 50, 90, 'Arial', 8, [], StringGrid1.Cells[ACol, ARow]);
    end;
}

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
    if (ARow=0) and (ACol>0) then
      StringGridRotateTextOut(StringGrid1, ARow, ACol, Rect, 'Arial', 8, clBlack, taLeftJustify)
    else
      TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);

    if ((ARow>0) and (ACol > 0) and ChannelMatrixAvailable[ACol, ARow]) then
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
      if ChannelMatrixEnabled[ACol, ARow] then
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
    if (ARow=0) and (ACol>0) then
      StringGridRotateTextOut(StringGrid1, ARow, ACol, Rect, 'Arial', 8, clBlack, taLeftJustify)
    else
      TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
  end;
end;

procedure Tdevicesceneform.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
  AlleTrue:boolean;
begin
  if (Button=mbLeft) and (Shift=[]) then
  begin
    ChannelMatrixEnabled[StringGrid1.Col, StringGrid1.Row]:=not ChannelMatrixEnabled[StringGrid1.Col, StringGrid1.Row];
  end else if (Button=mbLeft)  and (Shift=[ssCtrl]) then
  begin
    AlleTrue:=true;
    for i:=1 to length(ChannelMatrixEnabled)-1 do
    begin
      if not ChannelMatrixEnabled[i, StringGrid1.Row] then
      begin
        AlleTrue:=false;
        break;
      end;
    end;

    if not AlleTrue then
    begin
      for i:=1 to length(ChannelMatrixEnabled)-1 do
        ChannelMatrixEnabled[i, StringGrid1.Row]:=true;
    end else
    begin
      for i:=1 to length(ChannelMatrixEnabled)-1 do
        ChannelMatrixEnabled[i, StringGrid1.Row]:=false;
    end;
  end;

  StringGrid1.Repaint;
end;

procedure Tdevicesceneform.RefreshMatrix;
var
  ChannelInUse:array of boolean;
  UsedChannels:integer;
  i,j,k:integer;
  newtext:string;
begin
  setlength(ChannelInUse, length(mainform.DeviceChannelNames));

  for i:=0 to length(mainform.devices)-1 do
  begin
    for j:=0 to length(mainform.devices[i].kanaltyp)-1 do
    begin
      for k:=0 to length(mainform.DeviceChannelNames)-1 do begin
        if lowercase(mainform.DeviceChannelNames[k])=lowercase(mainform.devices[i].kanaltyp[j]) then
        begin
          ChannelInUse[k]:=true;
          break;
        end;
      end;
    end;
  end;

  UsedChannels:=0;
  for i:=0 to length(ChannelInUse)-1 do
  begin
    if ChannelInUse[i] then
    begin
      UsedChannels:=UsedChannels+1;
      setlength(UsedChannelList, length(UsedChannelList)+1);
      UsedChannelList[length(UsedChannelList)-1]:=mainform.DeviceChannelNames[i];
    end;
  end;

  for i:=0 to length(ChannelMatrixAvailable)-1 do
  begin
    for j:=0 to length(ChannelMatrixAvailable[i])-1 do
    begin
      ChannelMatrixAvailable[i][j]:=false;
    end;
  end;

  for i:=0 to length(mainform.devices)-1 do
  begin
    for j:=0 to length(mainform.devices[i].kanaltyp)-1 do
    begin
      for k:=0 to length(UsedChannelList)-1 do begin
        if lowercase(UsedChannelList[k])=lowercase(mainform.devices[i].kanaltyp[j]) then
        begin
          ChannelMatrixAvailable[k+1, i+1]:=true;
          break;
        end;
      end;
    end;
  end;

  // In Zeilen die Geräte anzeigen, in Spalten die verfügbaren Kanäle anzeigen
  StringGrid1.RowCount:=length(mainform.devices)+1;
  StringGrid1.ColCount:=UsedChannels+1;
  StringGrid1.RowHeights[0]:=75;
  StringGrid1.ColWidths[0]:=125;

  for i:=0 to length(mainform.devices)-1 do
  begin
    StringGrid1.Cells[0,i+1]:=mainform.devices[i].Name;
  end;

  for i:=0 to length(UsedChannelList)-1 do
  begin
    newtext:=lowercase(UsedChannelList[i]);
    newtext[1]:=UsedChannelList[i][1];
    StringGrid1.Cells[i+1,0]:=newtext;
  end;

  StringGrid1.Repaint;
end;

procedure Tdevicesceneform.SetAllChansBtnClick(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(ChannelMatrixEnabled)-1 do
  begin
    for j:=0 to length(ChannelMatrixEnabled[i])-1 do
    begin
      ChannelMatrixEnabled[i, j]:=true;
    end;
  end;
  RefreshMatrix;
end;

procedure Tdevicesceneform.ResetAllChansBtnClick(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(ChannelMatrixEnabled)-1 do
  begin
    for j:=0 to length(ChannelMatrixEnabled[i])-1 do
    begin
      ChannelMatrixEnabled[i, j]:=false;
    end;
  end;
  RefreshMatrix;
end;

procedure Tdevicesceneform.OnlyChangedChansBtnClick(Sender: TObject);
var
  i,j,k,ChannelOffset:integer;
begin
  for i:=0 to length(UsedChannelList)-1 do // Kanäle durchzählen
  begin
    for j:=0 to length(ChannelMatrixEnabled[i])-2 do // Geräte durchzählen
    begin
      ChannelOffset:=0;
      for k:=0 to length(mainform.devices[j].kanaltyp)-1 do
      begin
        if lowercase(UsedChannelList[i])=lowercase(mainform.devices[j].kanaltyp[k]) then
        begin
          ChannelOffset:=k;
          break;
        end;
      end;
      ChannelMatrixEnabled[i+1, j+1]:=mainform.changedchannels[mainform.devices[j].startaddress+ChannelOffset];
    end;
  end;
  RefreshMatrix;
end;

procedure Tdevicesceneform.cancelmatrixbtnClick(Sender: TObject);
begin
  matrixpanel.visible:=false;
end;

procedure Tdevicesceneform.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,j,k:integer;
  Suchtext:string;
  Data, Data2, Data3:PTreeData;
begin
  if key=vk_return then
  begin
    VST.FullCollapse(nil);
    Suchtext:=lowercase(Edit1.Text);

{
    for i:=0 to length(VSTVendorNodes)-1 do
    begin
      Data:=VST.GetNodeData(VSTVendorNodes[i]);

      if (pos(Suchtext, LowerCase(Data^.Caption))>0) then
      begin
        VST.Expanded[VSTVendorNodes[i]]:=true;
      end;
    end;

    for i:=0 to length(VSTTypeNodes)-1 do
    for j:=0 to length(VSTTypeNodes[i])-1 do
    begin
      Data:=VST.GetNodeData(VSTTypeNodes[i][j]);

      if (pos(Suchtext, LowerCase(Data^.Caption))>0) then
      begin
        VST.Expanded[VSTTypeNodes[i][j].Parent]:=true;
        VST.Expanded[VSTTypeNodes[i][j]]:=true;
      end;
    end;

    for i:=0 to length(VSTDeviceNodes)-1 do
    for j:=0 to length(VSTDeviceNodes[i])-1 do
    for k:=0 to length(VSTDeviceNodes[i][j])-1 do
    begin
      Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);

      if (pos(Suchtext, LowerCase(Data^.Caption))>0) then
      begin
        VST.Expanded[VSTDeviceNodes[i][j][k].Parent.Parent]:=true;
        VST.Expanded[VSTDeviceNodes[i][j][k].Parent]:=true;
        VST.Expanded[VSTDeviceNodes[i][j][k]]:=true;
        VST.Selected[VSTDeviceNodes[i][j][k]]:=true;
        VST.FocusedNode:=VSTDeviceNodes[i][j][k];
      end else
      begin
        VST.Selected[VSTDeviceNodes[i][j][k]]:=false;
      end;
    end;
}
  for i:=0 to length(VSTDeviceNodes)-1 do
  for j:=0 to length(VSTDeviceNodes[i])-1 do
  for k:=0 to length(VSTDeviceNodes[i][j])-1 do
  begin
    Data:=VST.GetNodeData(VSTDeviceNodes[i][j][k]);
    Data2:=VST.GetNodeData(VSTTypeNodes[i][j]);
    Data3:=VST.GetNodeData(VSTVendorNodes[i]);

    if (pos(suchtext, LowerCase(Data^.Caption))>0) or (pos(suchtext, LowerCase(Data2^.Caption))>0) or (pos(suchtext, LowerCase(Data3^.Caption))>0) then
    begin
      VST.Expanded[VSTDeviceNodes[i][j][k].Parent.Parent]:=true;
      VST.Expanded[VSTDeviceNodes[i][j][k].Parent]:=true;
      VST.Expanded[VSTDeviceNodes[i][j][k]]:=true;
      VST.Selected[VSTDeviceNodes[i][j][k]]:=true;
      VST.FocusedNode:=VSTDeviceNodes[i][j][k];
    end else
    begin
      VST.Selected[VSTDeviceNodes[i][j][k]]:=false;
    end;
  end;
  end;
end;

end.
