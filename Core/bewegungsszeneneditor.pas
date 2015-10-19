unit bewegungsszeneneditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Grids, figureneditor, Math,
  Buttons, PngBitBtn,szenenverwaltung, Menus, gnugettext,
  VirtualTrees, SVATimer;

const
  {$I GlobaleKonstanten.inc}

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: integer; // 0 Einfache Szenen, 1 Geräteszenen, 2 Audioszenen, 3 Bewegungsszenen, 4 Befehle, 5 Kombinationsszenen, 6 Presets, 7 Automatikszenen, 8 Effekt, 9 MediaCenter Szenen
    IsRootNode:boolean;
    Caption:WideString;
    Beschreibung:WideString;
    Fadetime:WideString;
    ID:TGUID;
  end;

  PTreeData2 = ^TTreeData2;
  TTreeData2 = record
    NodeType: byte; // 0=Vendor, 1=Type, 2=Device, 3=Channel
    DataType: integer; // 0=Devicechannel, 1=Groupchannel, 2=Befehlwert
    Caption:WideString;
    ID:TGUID;
    ChannelInDevice:integer;
  end;

  Tbewegungsszeneneditorform = class(TForm)
    Repaint: TTimer;
    SuchTimer: TTimer;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    Kanaleinstellungenzurcksetzen1: TMenuItem;
    Panel2: TPanel;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    Panel4: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Time_h: TEdit;
    Time_m: TEdit;
    Time_s: TEdit;
    FigureneditorBtn: TButton;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    StartpositionAbsolut: TRadioButton;
    Edit3: TEdit;
    Time_ms: TEdit;
    StartpositionRelativ: TRadioButton;
    CheckBox3: TCheckBox;
    Panel5: TPanel;
    Button1: TButton;
    Button3: TButton;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Edit5: TEdit;
    Button5: TButton;
    Button6: TButton;
    CheckBox2: TCheckBox;
    Panel11: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    InvertXCheckbox: TCheckBox;
    InvertYCheckbox: TCheckBox;
    PositionX: TTrackBar;
    ScaleXTrackbar: TTrackBar;
    PositionY: TTrackBar;
    ScaleYTrackbar: TTrackBar;
    LinkScalexyTrackbar: TCheckBox;
    mixXY: TCheckBox;
    OffsetTrackbar: TTrackBar;
    Edit4: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Button8: TButton;
    Panel12: TPanel;
    Panel13: TPanel;
    Button9: TButton;
    GroupBox4: TGroupBox;
    SceneList: TStringGrid;
    Panel16: TPanel;
    Panel18: TPanel;
    AddScene: TPngBitBtn;
    EditScene: TPngBitBtn;
    DeleteScene: TPngBitBtn;
    Panel19: TPanel;
    Panel20: TPanel;
    Button7: TPngBitBtn;
    Button4: TPngBitBtn;
    Button2: TPngBitBtn;
    printPoints: TCheckBox;
    printText: TCheckBox;
    Panel15: TPanel;
    Panel14: TPanel;
    Label14: TLabel;
    Edit10: TEdit;
    CheckBox4: TCheckBox;
    VST: TVirtualStringTree;
    BewegungsszeneTimer: TSVATimer;
    procedure RedrawAll;
    procedure FigureneditorBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure PositionXChange(Sender: TObject);
    procedure PositionYChange(Sender: TObject);
    procedure ScaleXTrackbarChange(Sender: TObject);
    procedure ScaleYTrackbarChange(Sender: TObject);
    procedure InvertXCheckboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InvertYCheckboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1Change(Sender: TObject);
    procedure ResetBtnClick(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Time_hChange(Sender: TObject);
    function FigurLength(Figur: TGUID):Extended;
    function Laenge(x1,y1,x2,y2:integer):Extended;
    function ZeitzwischenzweiPunkten(x1,y1,x2,y2, maxPunkte:integer; Bewegungsszene:TGUID):Extended;
    function ZeitzwischenzweiPunktenActual(x1,y1,x2,y2, maxPunkte:integer):Extended;
    function GetX(Device, DeviceChannel, Position: integer; Bewegungsszene:TGUID):integer;
    function GetY(Device, DeviceChannel, Position: integer; Bewegungsszene:TGUID):integer;
    function GetXActual(Device, DeviceChannel, Position: integer):integer;
    function GetYActual(Device, DeviceChannel, Position: integer):integer;
    procedure BewegungsszeneTimerTimer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure printPointsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure printTextMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mixXYMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure OffsetTrackbarChange(Sender: TObject);
    procedure StartpositionRelativMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SaveBewegungsDaten;
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RepaintTimer(Sender: TObject);
    procedure AddSceneClick(Sender: TObject);
    procedure EditSceneClick(Sender: TObject);
    procedure DeleteSceneClick(Sender: TObject);
    procedure SceneListGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure SceneListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RefreshSceneList;
    procedure SuchTimerTimer(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit5Enter(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit5KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure OffsetTrackbarEnter(Sender: TObject);
    procedure Edit4Enter(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button9Click(Sender: TObject);
    procedure Edit10Change(Sender: TObject);
    procedure CheckBox4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VSTPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure VSTMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VSTKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VSTDblClick(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    VSTCurrentNode: PVirtualNode;
    VSTVendorNodes: array of PVirtualNode;
    VSTTypeNodes: array of array of PVirtualNode;
    VSTDeviceNodes: array of array of array of PVirtualNode;
    VSTChannelNodes: array of array of array of array of PVirtualNode;

    _Buffer: TBitmap;
    AktuelleBewegungsszeneAktiv:boolean;
//    dontredrawtreeview:boolean;
    nodeviceactive:boolean;
    procedure CheckButtons;
    procedure RefreshTreeNew;
  public
    { Public-Deklarationen }
    AktuelleBewegungsszeneZeit: array of array of Cardinal;
    AktuelleBewegungsszeneRepeats:array of array of Word;
    AktuelleBewegungsszenePosition: array of array of Word;
    Zeit : array of array of Cardinal;
  end;

var
  bewegungsszeneneditorform: Tbewegungsszeneneditorform;

implementation

uses PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

procedure Tbewegungsszeneneditorform.FigureneditorBtnClick(Sender: TObject);
begin
  Button4Click(nil);
  
  if Combobox1.ItemIndex>-1 then
    figureneditorform.LoadFigure:=Combobox1.ItemIndex
  else
    figureneditorform.LoadFigure:=-1;

  figureneditorform.ShowModal;

  bewegungsszeneneditorform.FormShow(FigureneditorBtn);
  if (length(mainform.Figuren)>0) then
  begin
    Combobox1.ItemIndex:=Combobox1.Items.Count-1;
    mainform.AktuelleBewegungsszene.figur:=mainform.Figuren[Combobox1.ItemIndex].ID;
  end;
end;

procedure Tbewegungsszeneneditorform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  _Buffer := TBitmap.Create;
	_Buffer.Width:= Paintbox1.Width;
	_Buffer.Height:= Paintbox1.Height;
end;

procedure Tbewegungsszeneneditorform.FormShow(Sender: TObject);
var
  i,t:integer;
begin
  nodeviceactive:=true;
  RefreshTreeNew;

  Combobox1.Clear;

  for i:=0 to length(mainform.Figuren)-1 do
    Combobox1.Items.Add(mainform.Figuren[i].Name);

  if length(mainform.Figuren)>0 then
  begin
    Edit1.Enabled:=true;
    Edit3.Enabled:=true;
    Combobox1.Enabled:=true;
    GroupBox2.Enabled:=true;
    vst.Visible:=true;
    Combobox1.ItemIndex:=0;
    Time_h.Enabled:=true;
    Time_m.Enabled:=true;
    Time_s.Enabled:=true;
    Time_ms.Enabled:=true;

    t:=mainform.AktuelleBewegungsszene.dauer;
    Time_h.text:=inttostr(t div 3600000);
    t:=t mod 3600000;
    Time_m.text:=inttostr(t div 60000);
    t:=t mod 60000;
    Time_s.text:=inttostr(t div 1000);
    t:=t mod 1000;
    Time_ms.text:=inttostr(t);
  end else
  begin
    Edit1.Enabled:=false;
    Edit3.Enabled:=false;
    Combobox1.Enabled:=false;
    GroupBox2.Enabled:=false;
    vst.Visible:=false;
    Combobox1.ItemIndex:=-1;
    Time_h.Text:='0';
    Time_m.Text:='0';
    Time_s.Text:='5';
    Time_ms.Text:='0';
    Time_h.Enabled:=false;
    Time_m.Enabled:=false;
    Time_s.Enabled:=false;
    Time_ms.Enabled:=false;
  end;

  Combobox1.ItemIndex:=-1;

  if (figureneditorform.LoadFigure>-1) and (Sender=FigurenEditorBtn) and (figureneditorform.LoadFigure<Combobox1.Items.Count) then
  begin
    Combobox1.ItemIndex:=figureneditorform.LoadFigure;
    mainform.AktuelleBewegungsszene.figur:=mainform.Figuren[Combobox1.ItemIndex].ID;
    OffsetTrackbar.Max:=length(mainform.Figuren[Combobox1.ItemIndex].posx);
  end else
  begin
    if length(mainform.Figuren)>0 then
    for i:=0 to Combobox1.Items.Count-1 do
      if IsEqualGUID(mainform.Figuren[i].ID,mainform.AktuelleBewegungsszene.figur) then
      begin
        Combobox1.ItemIndex:=i;
        mainform.AktuelleBewegungsszene.figur:=mainform.Figuren[Combobox1.ItemIndex].ID;
        OffsetTrackbar.Max:=length(mainform.Figuren[Combobox1.ItemIndex].posx);
        break;
      end;
  end;

  Edit1.Text:=mainform.AktuelleBewegungsszene.Name;
  Edit2.Text:=inttostr(mainform.AktuelleBewegungsszene.repeats);
  Edit3.Text:=mainform.AktuelleBewegungsszene.Beschreibung;
  CheckBox1.Checked:=mainform.AktuelleBewegungsszene.identischespurgeschwidigkeit;
  CheckBox3.Checked:=mainform.AktuelleBewegungsszene.DontFade;
  CheckBox4.Checked:=mainform.AktuelleBewegungsszene.IsBeatControlled;
    Checkbox1.Enabled:=not Checkbox4.checked;
    Time_h.Enabled:=not Checkbox4.checked;
    Time_m.Enabled:=not Checkbox4.checked;
    Time_s.Enabled:=not Checkbox4.checked;
    Time_ms.Enabled:=not Checkbox4.checked;

  PositionX.Position:=800;
  PositionY.Position:=800;
  ScaleXTrackbar.Position:=10000;
  ScaleYTrackbar.Position:=10000;
  InvertXCheckbox.Checked:=false;
  InvertYCheckbox.Checked:=false;
  MixXY.Checked:=false;
  OffsetTrackbar.Position:=0;
  Edit4.Text:=inttostr(offsettrackbar.Position);
  Edit10.Text:='0';
  StartpositionRelativ.checked:=mainform.AktuelleBewegungsszene.startpositionrelativ;

  Repaint.Enabled:=true;
  Timer1.enabled:=true;
  Button9Click(nil);
end;

procedure Tbewegungsszeneneditorform.RedrawAll;
var
  i, k, l:integer;
begin
  _Buffer.Canvas.Brush.Color := clBlack;
  _Buffer.Canvas.FillRect(_Buffer.Canvas.ClipRect);

  // Vertikale Linien zeichnen
  i:=20;
  _Buffer.Canvas.Pen.Color:=clBlue;
  while i <= _Buffer.Height do
  begin
    _Buffer.Canvas.MoveTo(i,0);
    _Buffer.Canvas.LineTo(i,_Buffer.Height);
    i:=i+20;
  end;

  // Horizontale Linien zeichnen
  i:=20;
  _Buffer.Canvas.Pen.Color:=clBlue;
  while i <= _Buffer.Width do
  begin
    _Buffer.Canvas.MoveTo(0,i);
    _Buffer.Canvas.LineTo(_Buffer.Width,i);
    i:=i+20;
  end;
  _Buffer.Canvas.Pen.Color:=-1;

  // Fadenkreuz zeichnen
  _Buffer.Canvas.Pen.Color:=$000080FF;
  _Buffer.Canvas.MoveTo(200,0);
  _Buffer.Canvas.LineTo(200,_Buffer.Height);
  _Buffer.Canvas.MoveTo(0,200);
  _Buffer.Canvas.LineTo(_Buffer.Width,200);
  _Buffer.Canvas.Pen.Color:=-1;

  if Combobox1.itemindex<length(mainform.Figuren) then
  begin
    if (Combobox1.enabled) and (Combobox1.items.count>0) and (Combobox1.itemindex>-1) then
    begin
      // Linien zeichnen
      for k:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
      for l:=0 to length(mainform.AktuelleBewegungsszene.Devices[k].DeviceChannel)-1 do
      if mainform.AktuelleBewegungsszene.Devices[k].DeviceChannel[l].ChanActive then
      begin
        nodeviceactive:=false;
        if mainform.AktuelleBewegungsszene.Devices[k].DeviceChannel[l].x or mainform.AktuelleBewegungsszene.Devices[k].DeviceChannel[l].y then
        if length(mainform.Figuren[Combobox1.itemindex].posx) >0 then
        for i:=0 to length(mainform.Figuren[Combobox1.itemindex].posx)-1 do
        begin
          if ((i+1)<=length(mainform.Figuren[Combobox1.itemindex].posx)-1) then
          begin // Normale Punkteverbindungen zeichnen
    //        if AktuelleBewegungsszenePosition[StringGrid1.Row-1]=i then
            if AktuelleBewegungsszenePosition[k][l]=i+1 then
            begin
              // Aktuelle Punkteverbindung zeichnen
              _Buffer.Canvas.Pen.Color:=$000080FF;
              _Buffer.Canvas.MoveTo(GetXActual(k,l,i),GetYActual(k,l,i));
              _Buffer.Canvas.LineTo(GetXActual(k,l,i+1),GetYActual(k,l,i+1));
            end else
            begin
              // Normale Punkteverbindung zeichnen
              _Buffer.Canvas.Pen.Color:=clYellow;
              _Buffer.Canvas.MoveTo(GetXActual(k,l,i),GetYActual(k,l,i));
              _Buffer.Canvas.LineTo(GetXActual(k,l,i+1),GetYActual(k,l,i+1));
            end;
          end else
          begin // Letzte Punktverbindung zeichnen
            // Zurück zum ersten Punkt
    //        if AktuelleBewegungsszenePosition[StringGrid1.Row-1]=i then
            if AktuelleBewegungsszenePosition[k][l]=0 then
            begin
              _Buffer.Canvas.Pen.Color:=$000080FF;
              _Buffer.Canvas.MoveTo(GetXActual(k,l,i),GetYActual(k,l,i));
              _Buffer.Canvas.LineTo(GetXActual(k,l,0),GetYActual(k,l,0));
            end else
            begin
              _Buffer.Canvas.Pen.Color:=clYellow;
              _Buffer.Canvas.MoveTo(GetXActual(k,l,i),GetYActual(k,l,i));
              _Buffer.Canvas.LineTo(GetXActual(k,l,0),GetYActual(k,l,0));
            end;
          end;

          if printPoints.checked then
          begin
            // Punkte zeichnen
    //        if AktuelleBewegungsszenePosition[StringGrid1.Row-1]=i then
            if AktuelleBewegungsszenePosition[k][l]=i+1 then
              _Buffer.Canvas.Brush.Color:=$000080FF
            else begin
              if i=0 then
                _Buffer.Canvas.Brush.Color:=clLime
              else if i=length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 then
              _Buffer.Canvas.Brush.Color:=clRed
              else
              _Buffer.Canvas.Brush.Color:=clYellow;
            end;
            _Buffer.Canvas.Pen.Color:=-1;
            _Buffer.Canvas.Ellipse(GetXActual(k,l,i)-3,GetYActual(k,l,i)-3,GetXActual(k,l,i)+3,GetYActual(k,l,i)+3);
          end;
          // Ende von Punkte zeichnen
          // Bezeichnungen ausgeben
            if printtext.Checked then
            begin
              _Buffer.Canvas.Brush.Color:=clBlack;
    //          if AktuelleBewegungsszenePosition[StringGrid1.Row-1]=i then
              if AktuelleBewegungsszenePosition[k][l]=i+1 then
              begin
                _Buffer.Canvas.Font.Color:=$000080FF;
                if mainform.Figuren[Combobox1.ItemIndex].posx[i]<375 then
                  _Buffer.Canvas.TextOut(GetXActual(k,l,i),GetYActual(k,l,i)-15,_('Aktuell'))
                else
                  _Buffer.Canvas.TextOut(GetXActual(k,l,i)-30,GetYActual(k,l,i)-15,_('Aktuell'));
              end else if i=0 then
              begin
                _Buffer.Canvas.Font.Color:=clLime;
                if mainform.Figuren[Combobox1.ItemIndex].posx[i]<375 then
                  _Buffer.Canvas.TextOut(GetXActual(k,l,i),GetYActual(k,l,i)-15,_('Start'))
                else
                  _Buffer.Canvas.TextOut(GetXActual(k,l,i)-25,GetYActual(k,l,i)-15,_('Start'));
              end else if i=length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 then
              begin
                _Buffer.Canvas.Font.Color:=clRed;
                if GetXActual(k,l,i)<375 then
                  _Buffer.Canvas.TextOut(GetXActual(k,l,i),GetYActual(k,l,i)-15,_('Stop'))
                else
                  _Buffer.Canvas.TextOut(GetXActual(k,l,i)-25,GetYActual(k,l,i)-15,_('Stop'));
              end else
              begin
                _Buffer.Canvas.Font.Color:=clYellow;
                if mainform.Figuren[Combobox1.ItemIndex].posx[i]<385 then
                  _Buffer.Canvas.TextOut(GetXActual(k,l,i),GetYActual(k,l,i)-15,inttostr(i))
                else
                  _Buffer.Canvas.TextOut(GetXActual(k,l,i)-15,GetYActual(k,l,i)-15,inttostr(i));
              end;
            end;
          // Ende von Bezeichnungen ausgeben
        end;
      end;
      if nodeviceactive then
      begin
        _Buffer.Canvas.Pen.Color:=clWhite;
        _Buffer.Canvas.Font.Color:=clWhite;
        _Buffer.Canvas.Font.Size:=10;
        _Buffer.Canvas.Font.Name:='Arial';
        _Buffer.Canvas.Font.Style:=[fsBold];
        _Buffer.Canvas.TextOut(8,_Buffer.Height div 2-5-10,_('Bitte haken sie einen Kanal eines Gerätes an,'));
        _Buffer.Canvas.TextOut(8,_Buffer.Height div 2-5+10,_('um Einstellungen vornehmen zu können...'));
      end;
    end else if (Combobox1.itemindex=-1) and (Combobox1.enabled) then
    begin
      _Buffer.Canvas.Pen.Color:=clWhite;
      _Buffer.Canvas.Font.Color:=clWhite;
      _Buffer.Canvas.Font.Size:=10;
      _Buffer.Canvas.Font.Name:='Arial';
      _Buffer.Canvas.Font.Style:=[fsBold];
      _Buffer.Canvas.TextOut(8,_Buffer.Height div 2-5,_('Bitte oben links eine Figur auswählen...'));
    end else
    begin
      _Buffer.Canvas.Pen.Color:=clWhite;
      _Buffer.Canvas.Font.Color:=clWhite;
      _Buffer.Canvas.Font.Size:=10;
      _Buffer.Canvas.Font.Name:='Arial';
      _Buffer.Canvas.Font.Style:=[fsBold];
      _Buffer.Canvas.TextOut(8,_Buffer.Height div 2-5,_('Bitte eine neue Figur über den Figureneditor hinzufügen...'));
    end;
  end;
  BitBlt(PaintBox1.canvas.Handle,0,0,400,400,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Tbewegungsszeneneditorform.ComboBox1Change(Sender: TObject);
begin
  mainform.AktuelleBewegungsszene.figur:=mainform.Figuren[Combobox1.ItemIndex].ID;
  VST.Visible:=(Combobox1.ItemIndex>-1);
  RedrawAll;
end;

procedure Tbewegungsszeneneditorform.PositionXChange(Sender: TObject);
var
  i:integer;
  Data:PTreeData2;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mittelpunktx:=PositionX.Position;
    break;
  end;
  RedrawAll;

  if not (Sender=Edit6) then
    Edit6.text:=inttostr(PositionX.position-800);
end;

procedure Tbewegungsszeneneditorform.PositionYChange(Sender: TObject);
var
  i:integer;
  Data:PTreeData2;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mittelpunkty:=PositionY.Position;
    break;
  end;
  RedrawAll;

  if not (Sender=Edit7) then
    Edit7.text:=inttostr(PositionY.position-800);
end;

procedure Tbewegungsszeneneditorform.ScaleXTrackbarChange(Sender: TObject);
var
  i:integer;
  Data:PTreeData2;
begin
  Edit8.text:=inttostr(ScaleXTrackbar.position);
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].scalex:=ScaleXTrackbar.Position;
    break;
  end;
  if LinkScalexyTrackbar.Checked then
    ScaleYTrackbar.Position:=ScaleXTrackbar.Position;

  RedrawAll;
end;

procedure Tbewegungsszeneneditorform.ScaleYTrackbarChange(Sender: TObject);
var
  i:integer;
  Data:PTreeData2;
begin
  Edit9.text:=inttostr(ScaleYTrackbar.position);
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].scaley:=ScaleYTrackbar.Position;
    break;
  end;
  if LinkScalexyTrackbar.Checked then
    ScaleXTrackbar.Position:=ScaleYTrackbar.Position;

  RedrawAll;
end;

procedure Tbewegungsszeneneditorform.InvertXCheckboxMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  i:integer;
  Data:PTreeData2;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].invertx:=InvertXCheckbox.Checked;
    break;
  end;
  RedrawAll;
end;

procedure Tbewegungsszeneneditorform.InvertYCheckboxMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  i:integer;
  Data:PTreeData2;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].inverty:=InvertYCheckbox.Checked;
    break;
  end;
  RedrawAll;
end;

procedure Tbewegungsszeneneditorform.Edit1Change(Sender: TObject);
begin
  mainform.AktuelleBewegungsszene.Name:=Edit1.Text;
end;

procedure Tbewegungsszeneneditorform.ResetBtnClick(Sender: TObject);
begin
  PositionX.Position:=800;
  PositionY.Position:=800;
  LinkScaleXYTrackbar.Checked:=false;
  ScaleXTrackbar.Position:=10000;
  ScaleYTrackbar.Position:=10000;
  InvertXCheckbox.Checked:=false;
  InvertXCheckboxMouseUp(InvertXCheckbox,mbLeft,[],0,0);
  InvertYCheckbox.Checked:=false;
  InvertYCheckboxMouseUp(InvertXCheckbox,mbLeft,[],0,0);
  MixXY.Checked:=false;
  MixXYMouseUp(InvertXCheckbox,mbLeft,[],0,0);
  OffsetTrackbar.Position:=0;
  edit10.text:='0';
  RedrawAll;
end;

procedure Tbewegungsszeneneditorform.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.AktuelleBewegungsszene.identischespurgeschwidigkeit:=CheckBox1.Checked;
end;

procedure Tbewegungsszeneneditorform.Button2Click(Sender: TObject);
var
  i,j,t:integer;
  tempdelay:cardinal;
begin
  mainform.AktuelleBewegungsszene.Name:=Edit1.Text;
  mainform.AktuelleBewegungsszene.Beschreibung:=Edit3.Text;
  mainform.AktuelleBewegungsszene.Repeats:=StrToInt(Edit2.Text);
  if Combobox1.ItemIndex>-1 then
    mainform.AktuelleBewegungsszene.figur:=mainform.Figuren[Combobox1.ItemIndex].ID;
  mainform.AktuelleBewegungsszene.identischespurgeschwidigkeit:=Checkbox1.Checked;
  mainform.AktuelleBewegungsszene.DontFade:=Checkbox3.Checked;
  mainform.AktuelleBewegungsszene.IsBeatControlled:=CheckBox4.Checked;

  t:=strtoint(Time_ms.Text);
  t:=t+1000*strtoint(Time_s.text);
  t:=t+60*1000*strtoint(Time_m.text);
  t:=t+60*60*1000*strtoint(Time_h.text);

  if t>0 then
    mainform.AktuelleBewegungsszene.dauer:=t
  else
    mainform.AktuelleBewegungsszene.dauer:=1000;

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  for j:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel)-1 do
  begin
    AktuelleBewegungsszeneZeit[i][j]:=0;
    AktuelleBewegungsszeneRepeats[i][j]:=0;
//    if not mainform.AktuelleBewegungsszene.startpositionrelativ then
      AktuelleBewegungsszenePosition[i][j]:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].offset;
  end;

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  begin
    if geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)>=0 then
    begin
      for j:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel)-1 do
      begin
        // Dimmzeit zwischen aktuellem Punkt und nächstem Punkt berechnen
        if AktuelleBewegungsszenePosition[i][j]+1>length(mainform.figuren[Combobox1.ItemIndex].posx)-1 then
          Zeit[i][j]:=round(ZeitzwischenzweiPunktenActual(GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetXActual(i,j,0),GetYActual(i,j,0),length(mainform.Figuren[Combobox1.ItemIndex].posx)))
        else
          Zeit[i][j]:=round(ZeitzwischenzweiPunktenActual(GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]+1),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]+1),length(mainform.Figuren[Combobox1.ItemIndex].posx)));

        // Kanalwerte ausgeben
        if mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay<0 then
          tempdelay:=0
        else
          tempdelay:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay;

        if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) then
        begin
          if not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY then
            geraetesteuerung.set_channel(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j], (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400),0,tempdelay)
          else
            geraetesteuerung.set_channel(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j], (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400),0,tempdelay);
        end else if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) then
        begin
          if not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY then
            geraetesteuerung.set_channel(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j], (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400),0,tempdelay)
          else
            geraetesteuerung.set_channel(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j], (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400),0,tempdelay);
        end else if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) then
        begin
        end;

        AktuelleBewegungsszeneZeit[i][j]:=mainform.AktuelleBewegungsszene.dauer;
      end;
    end else if geraetesteuerung.GetGroupPositionInGroupArray(mainform.AktuelleBewegungsszene.Devices[i].ID)>=0 then
    begin
      for j:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel)-1 do
      begin
        // Dimmzeit zwischen aktuellem Punkt und nächstem Punkt berechnen
        if AktuelleBewegungsszenePosition[i][j]+1>length(mainform.figuren[Combobox1.ItemIndex].posx)-1 then
          Zeit[i][j]:=round(ZeitzwischenzweiPunktenActual(GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetXActual(i,j,0),GetYActual(i,j,0),length(mainform.Figuren[Combobox1.ItemIndex].posx)))
        else
          Zeit[i][j]:=round(ZeitzwischenzweiPunktenActual(GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]+1),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]+1),length(mainform.Figuren[Combobox1.ItemIndex].posx)));

        // Kanalwerte ausgeben
        if mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay<0 then
          tempdelay:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(mainform.AktuelleBewegungsszene.Devices[i].ID)].Delay
        else
          tempdelay:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay;

        if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) then
        begin
          if not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY then
            geraetesteuerung.set_group(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.DeviceChannelNames[j], (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400),0,tempdelay)
          else
            geraetesteuerung.set_group(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.DeviceChannelNames[j], (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400),0,tempdelay);
        end else if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) then
        begin
          if not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY then
            geraetesteuerung.set_group(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.DeviceChannelNames[j], (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400),0,tempdelay)
          else
            geraetesteuerung.set_group(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.DeviceChannelNames[j], (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400),0,tempdelay);
        end else if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) then
        begin
        end;

        AktuelleBewegungsszeneZeit[i][j]:=mainform.AktuelleBewegungsszene.dauer;
      end;
    end;
  end;

  RedrawAll;
  AktuelleBewegungsszeneAktiv:=true;
  BewegungsszeneTimer.Enabled:=true;
end;

procedure Tbewegungsszeneneditorform.Button1Click(Sender: TObject);
begin
  Button4Click(nil);
  SaveBewegungsDaten;
end;

procedure Tbewegungsszeneneditorform.Time_hChange(Sender: TObject);
var
  i,t:integer;
  s:string;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  t:=strtoint(Time_ms.Text);
  t:=t+1000*strtoint(Time_s.text);
  t:=t+60*1000*strtoint(Time_m.text);
  t:=t+60*60*1000*strtoint(Time_h.text);
  if t>=100 then
    mainform.AktuelleBewegungsszene.dauer:=t
  else
    mainform.AktuelleBewegungsszene.dauer:=100;
end;

function Tbewegungsszeneneditorform.FigurLength(Figur: TGUID):Extended;
var
  i,k:integer;
  figurenlaenge:Extended;
begin
  figurenlaenge:=0;

  with mainform do
  // aktuelle Figur herausfinden
  for i:=0 to length(Figuren)-1 do
  begin
    if IsEqualGUID(Figur,Figuren[i].ID) then
    begin
      // länge der aktuelle Figur herausfinden
      for k:=0 to length(Figuren[i].posx)-2 do
      begin
        figurenlaenge:=figurenlaenge+Laenge(Figuren[i].posx[k],Figuren[i].posy[k],Figuren[i].posx[k+1],Figuren[i].posy[k+1]);
      end;
      break;
    end;
  end;
  Result:=figurenlaenge;
end;

function Tbewegungsszeneneditorform.Laenge(x1,y1,x2,y2:Integer):Extended;
begin
  Result:=sqrt(power((x1-x2),2)+power((y1-y2),2));
end;

procedure Tbewegungsszeneneditorform.BewegungsszeneTimerTimer(
  Sender: TObject);
var
  i,j,k:integer;
  tempzeit,tempdelay:cardinal;
begin
  if AktuelleBewegungsszeneAktiv then
  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  begin
    if geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)>=0 then
    begin
      for j:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel)-1 do
      if mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].ChanActive then
      begin
        // Wartezeiten für jeden Kanal einzeln inkrementieren
        AktuelleBewegungsszeneZeit[i][j]:=AktuelleBewegungsszeneZeit[i][j]+1;

        // Falls aktuelle Zeit abgewartet, dann wechseln zu nächstem Punkt
        if (AktuelleBewegungsszeneZeit[i][j] >= Zeit[i][j]) then
        begin
          AktuelleBewegungsszeneZeit[i][j]:=0;

          // Dimmzeit zwischen aktuellem Punkt und nächstem Punkt berechnen
          if AktuelleBewegungsszenePosition[i][j]+1>=length(mainform.figuren[Combobox1.ItemIndex].posx) then
            Zeit[i][j]:=round(ZeitzwischenzweiPunktenActual(GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetXActual(i,j,0),GetYActual(i,j,0),length(mainform.Figuren[Combobox1.ItemIndex].posx)))
          else
            Zeit[i][j]:=round(ZeitzwischenzweiPunktenActual(GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]+1),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]+1),length(mainform.Figuren[Combobox1.ItemIndex].posx)));

          if mainform.AktuelleBewegungsszene.DontFade then tempzeit:=0 else tempzeit:=Zeit[i][j];

          // Kanalwerte ausgeben
          if mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay<0 then
            tempdelay:=0
          else
            tempdelay:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay;

          if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY)) or (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY)) then
          begin
            // Falls nur Y
            if AktuelleBewegungsszenePosition[i][j]+1>=length(mainform.figuren[Combobox1.ItemIndex].posx) then
            begin
              if (mainform.AktuelleBewegungsszene.repeats=-1) or (AktuelleBewegungsszeneRepeats[i][j]<mainform.AktuelleBewegungsszene.repeats) then
              begin
                geraetesteuerung.set_channel(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j], (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetYActual(i,j,0) * 255 div 400),tempzeit,tempdelay);
              end;
            end else
            begin
              geraetesteuerung.set_channel(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j], (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]+1) * 255 div 400),tempzeit,tempdelay);
            end;
          end else
          if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY)) or (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY)) then
          begin
            // Falls nur X
            if AktuelleBewegungsszenePosition[i][j]+1>=length(mainform.figuren[Combobox1.ItemIndex].posx) then
            begin
              if (mainform.AktuelleBewegungsszene.repeats=-1) or (AktuelleBewegungsszeneRepeats[i][j]<mainform.AktuelleBewegungsszene.repeats) then
              begin
                geraetesteuerung.set_channel(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j], (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetXActual(i,j,0) * 255 div 400),tempzeit,tempdelay);
              end;
            end else
            begin
              geraetesteuerung.set_channel(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j], (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]+1) * 255 div 400),tempzeit,tempdelay);
            end;
          end;

//        if (printText.Checked or printPoints.Checked) and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].channel=Stringgrid1.Row) then
//          RedrawAll;

          // Szene an aktuelle Position abspielen
          for k:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[j])-1 do
            if mainform.AktuelleBewegungsszene.Devices[i].Szenen[j][k].Position=AktuelleBewegungsszenePosition[i][j] then
              mainform.StartScene(mainform.AktuelleBewegungsszene.Devices[i].Szenen[j][k].ID,false,false);

          // nächste Position
          AktuelleBewegungsszenePosition[i][j]:=AktuelleBewegungsszenePosition[i][j]+1;

          if AktuelleBewegungsszenePosition[i][j]>=length(mainform.figuren[Combobox1.ItemIndex].posx) then
          begin
            AktuelleBewegungsszenePosition[i][j]:=0;

            if mainform.AktuelleBewegungsszene.repeats>-1 then
            begin
              if AktuelleBewegungsszeneRepeats[i][j]>=mainform.AktuelleBewegungsszene.repeats then
              begin
                AktuelleBewegungsszeneAktiv:=false;
              end else
              begin
                AktuelleBewegungsszeneRepeats[i][j]:=AktuelleBewegungsszeneRepeats[i][j]+1;
              end;
            end else
            begin
              AktuelleBewegungsszeneRepeats[i][j]:=AktuelleBewegungsszeneRepeats[i][j]+1;
            end;
          end;
          //RedrawAll;
          Repaint.Enabled:=true;
        end;
      end;
    end else if geraetesteuerung.GetGroupPositionInGroupArray(mainform.AktuelleBewegungsszene.Devices[i].ID)>=0 then
    begin
      for j:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel)-1 do
      if mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].ChanActive then
      begin
        if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x or mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) then
        begin
          // Wartezeiten für jeden Kanal einzeln inkrementieren
          AktuelleBewegungsszeneZeit[i][j]:=AktuelleBewegungsszeneZeit[i][j]+1;

          // Falls aktuelle Zeit abgewartet, dann wechseln zu nächstem Punkt
          if (AktuelleBewegungsszeneZeit[i][j] >= Zeit[i][j]) then
          begin
            AktuelleBewegungsszeneZeit[i][j]:=0;

            // Dimmzeit zwischen aktuellem Punkt und nächstem Punkt berechnen
            if AktuelleBewegungsszenePosition[i][j]+1>=length(mainform.figuren[Combobox1.ItemIndex].posx) then
              Zeit[i][j]:=round(ZeitzwischenzweiPunktenActual(GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetXActual(i,j,0),GetYActual(i,j,0),length(mainform.Figuren[Combobox1.ItemIndex].posx)))
            else
              Zeit[i][j]:=round(ZeitzwischenzweiPunktenActual(GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]),GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]+1),GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]+1),length(mainform.Figuren[Combobox1.ItemIndex].posx)));

            if mainform.AktuelleBewegungsszene.DontFade then tempzeit:=0 else tempzeit:=Zeit[i][j];

            // Kanalwerte ausgeben
            if mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay<0 then
              tempdelay:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(mainform.AktuelleBewegungsszene.Devices[i].ID)].Delay
            else
              tempdelay:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay;

            if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY)) or (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY)) then
            begin
              // Falls nur Y
              if AktuelleBewegungsszenePosition[i][j]+1>=length(mainform.figuren[Combobox1.ItemIndex].posx) then
              begin
                if (mainform.AktuelleBewegungsszene.repeats=-1) or (AktuelleBewegungsszeneRepeats[i][j]<mainform.AktuelleBewegungsszene.repeats) then
                begin
                  geraetesteuerung.set_group(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.DeviceChannelNames[j], (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetYActual(i,j,0) * 255 div 400),tempzeit,tempdelay);
                end;
              end else
              begin
                geraetesteuerung.set_group(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.DeviceChannelNames[j], (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetYActual(i,j,AktuelleBewegungsszenePosition[i][j]+1) * 255 div 400),tempzeit,tempdelay);
              end;
            end else if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY)) or (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY)) then
            begin
              // Falls nur X
              if AktuelleBewegungsszenePosition[i][j]+1>=length(mainform.figuren[Combobox1.ItemIndex].posx) then
              begin
                if (mainform.AktuelleBewegungsszene.repeats=-1) or (AktuelleBewegungsszeneRepeats[i][j]<mainform.AktuelleBewegungsszene.repeats) then
                begin
                  geraetesteuerung.set_group(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.DeviceChannelNames[j], (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetXActual(i,j,0) * 255 div 400),tempzeit,tempdelay);
                end;
              end else
              begin
                geraetesteuerung.set_group(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.DeviceChannelNames[j], (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]) * 255 div 400), (GetXActual(i,j,AktuelleBewegungsszenePosition[i][j]+1) * 255 div 400),tempzeit,tempdelay);
              end;
            end;

  //        if (printText.Checked or printPoints.Checked) and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].channel=Stringgrid1.Row) then
  //          RedrawAll;

            // Szene an aktuelle Position abspielen
            for k:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[j])-1 do
              if mainform.AktuelleBewegungsszene.Devices[i].Szenen[j][k].Position=AktuelleBewegungsszenePosition[i][j] then
                mainform.StartScene(mainform.AktuelleBewegungsszene.Devices[i].Szenen[j][k].ID,false,false);

            // nächste Position
            AktuelleBewegungsszenePosition[i][j]:=AktuelleBewegungsszenePosition[i][j]+1;

            if AktuelleBewegungsszenePosition[i][j]>=length(mainform.figuren[Combobox1.ItemIndex].posx) then
            begin
              AktuelleBewegungsszenePosition[i][j]:=0;

              if mainform.AktuelleBewegungsszene.repeats>-1 then
              begin
                if AktuelleBewegungsszeneRepeats[i][j]>=mainform.AktuelleBewegungsszene.repeats then
                begin
                  AktuelleBewegungsszeneAktiv:=false;
                end else
                begin
                  AktuelleBewegungsszeneRepeats[i][j]:=AktuelleBewegungsszeneRepeats[i][j]+1;
                end;
              end else
              begin
                AktuelleBewegungsszeneRepeats[i][j]:=AktuelleBewegungsszeneRepeats[i][j]+1;
              end;
            end;
            //RedrawAll;
            Repaint.Enabled:=true;
          end;
        end;
      end;
    end;
  end;
end;

procedure Tbewegungsszeneneditorform.Button4Click(Sender: TObject);
var
  i,j:integer;
  tempdelay:cardinal;
begin
  AktuelleBewegungsszeneAktiv:=false;
  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  begin
    if geraetesteuerung.GetGroupPositionInGroupArray(mainform.AktuelleBewegungsszene.Devices[i].ID)>=0 then
    begin
{
      // Gruppenkanäle ausgeben
      for j:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel)-1 do
      begin
        if mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay<0 then
          tempdelay:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(mainform.AktuelleBewegungsszene.Devices[i].ID)].Delay
        else
          tempdelay:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay;

        if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) then
        begin
          geraetesteuerung.set_group(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.DeviceChannelNames[j], -1, -1, 0,tempdelay);
        end else if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) then
        begin
          geraetesteuerung.set_group(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.DeviceChannelNames[j], -1, -1, 0,tempdelay);
        end else if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) then
        if not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY then
        begin
        end;
      end;
}
    end else if geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)>=0 then
    begin
      // Kanalwerte ausgeben
      for j:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel)-1 do
      begin
        if mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay<0 then
          tempdelay:=0
        else
          tempdelay:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].delay;

        if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) then
        begin
          geraetesteuerung.set_channel(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j], geraetesteuerung.get_channel(mainform.AktuelleBewegungsszene.Devices[i].ID,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j]),geraetesteuerung.get_channel(mainform.AktuelleBewegungsszene.Devices[i].ID,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j]),0,tempdelay);
        end else if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) then
        begin
          geraetesteuerung.set_channel(mainform.AktuelleBewegungsszene.Devices[i].ID, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j], geraetesteuerung.get_channel(mainform.AktuelleBewegungsszene.Devices[i].ID,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j]),geraetesteuerung.get_channel(mainform.AktuelleBewegungsszene.Devices[i].ID,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.AktuelleBewegungsszene.Devices[i].ID)].kanaltyp[j]),0,tempdelay);
        end else if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].x) and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].y) then
        if not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].mixXY then
        begin
        end;
      end;
    end;
  end;
  BewegungsszeneTimer.Enabled:=false;
end;

function Tbewegungsszeneneditorform.ZeitzwischenzweiPunktenActual(x1,y1,x2,y2, maxPunkte:integer):Extended;
var
  i, Gesamtzeit:integer;
  Gesamtlaenge : Single;
  Teillaenge, Teilzeit:Extended;
begin
  Gesamtlaenge:=1;
  Teilzeit:=1000;

  Gesamtzeit:=mainform.AktuelleBewegungsszene.dauer;

  if mainform.AktuelleBewegungsszene.identischespurgeschwidigkeit then
  begin
    for i:=0 to length(mainform.Figuren)-1 do
      if IsEqualGUID(mainform.Figuren[i].ID,mainform.AktuelleBewegungsszene.figur) then
      begin
        Gesamtlaenge:=mainform.Figuren[i].Gesamtlaenge;
        break;
      end;
    Teillaenge:=Laenge(x1,y1,x2,y2);
    if Gesamtlaenge > 0 then
      Teilzeit:=(Gesamtzeit/Gesamtlaenge)*Teillaenge;
  end else
  begin
    if maxPunkte > 0 then
      Teilzeit:=Gesamtzeit/maxPunkte;
  end;
  Result:=Teilzeit;
end;

function Tbewegungsszeneneditorform.ZeitzwischenzweiPunkten(x1,y1,x2,y2, maxPunkte:integer; Bewegungsszene:TGUID):Extended;
var
  i, k, Gesamtzeit:integer;
  Gesamtlaenge:Single;
  Teillaenge, Teilzeit:Extended;
begin
  Gesamtlaenge:=1;
  Teilzeit:=1000;
  Result:=-1;

  for k:=0 to length(mainform.Bewegungsszenen)-1 do
  begin
    if IsEqualGUID(mainform.bewegungsszenen[k].ID,Bewegungsszene) then
    begin
      Gesamtzeit:=mainform.bewegungsszenen[k].dauer;

      if mainform.bewegungsszenen[k].identischespurgeschwidigkeit then
      begin
        for i:=0 to length(mainform.Figuren)-1 do
          if IsEqualGUID(mainform.Figuren[i].ID,mainform.bewegungsszenen[k].figur) then
          begin
            Gesamtlaenge:=mainform.Figuren[i].Gesamtlaenge;
            break;
          end;
        Teillaenge:=Laenge(x1,y1,x2,y2);
        if Gesamtlaenge > 0 then
          Teilzeit:=(Gesamtzeit/Gesamtlaenge)*Teillaenge;
      end else
      begin
        if maxPunkte > 0 then
          Teilzeit:=Gesamtzeit/maxPunkte;
      end;
      Result:=Teilzeit;
      break;
    end;
  end;
end;

function tbewegungsszeneneditorform.GetX(Device, DeviceChannel, Position: integer; Bewegungsszene:TGUID):integer;
var
  i,k:integer;
begin
  result:=0;
  for k:=0 to length(mainform.Bewegungsszenen)-1 do
  begin
    if IsEqualGUID(mainform.bewegungsszenen[k].ID,Bewegungsszene) then
    begin // Bewegungsszene gefunden
      for i:=0 to length(mainform.Figuren)-1 do
      begin
        if IsEqualGUID(mainform.Bewegungsszenen[k].figur,mainform.figuren[i].ID) then
        begin // Figur gefunden
          with mainform.Figuren[i] do
          begin // Alle Geräte abklappern, und aktive Kanäle nutzen
{
                if mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].invertx then
                  result:=round(200*((10000-mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scalex)/10000))+round((400-posx[Position]+mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].mittelpunktx-800)*mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scalex/10000)
                else
                  result:=round(200*((10000-mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scalex)/10000))+round((posx[position]+mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].mittelpunktx-800)*mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scalex/10000);
}
            if mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].invertx then
              result:=round(((400-posx[position]-200)*(mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scalex/10000)+200)+(mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].mittelpunktx-800))
            else
              result:=round(((posx[position]-200)*(mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scalex/10000)+200)+(mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].mittelpunktx-800));
          end;
          break;
        end;
      end;
      break;
    end;
  end;
end;

function tbewegungsszeneneditorform.GetY(Device, DeviceChannel, Position: integer; Bewegungsszene:TGUID):integer;
var
  i,k:integer;
begin
  result:=0;
  for k:=0 to length(mainform.Bewegungsszenen)-1 do
  begin
    if IsEqualGUID(mainform.bewegungsszenen[k].ID,Bewegungsszene) then
    begin // Bewegungsszene gefunden
      for i:=0 to length(mainform.Figuren)-1 do
      begin
        if IsEqualGUID(mainform.Bewegungsszenen[k].figur,mainform.figuren[i].ID) then
        begin // Figur gefunden
          with mainform.Figuren[i] do
          begin // Alle Geräte abklappern, und aktive Kanäle nutzen
{
            if mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].inverty then
              result:=round(200*((10000-mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scaley)/10000))+round((400-posy[Position]+mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].mittelpunkty-800)*mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scaley/10000)
            else
              result:=round(200*((10000-mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scaley)/10000))+round((posy[position]+mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].mittelpunkty-800)*mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scaley/10000);
}
            if mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].inverty then
              result:=round(((400-posy[position]-200)*(mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scaley/10000)+200)+(mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].mittelpunkty-800))
            else
              result:=round(((posy[position]-200)*(mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].scaley/10000)+200)+(mainform.Bewegungsszenen[k].Devices[Device].DeviceChannel[DeviceChannel].mittelpunkty-800));
          end;
          break;
        end;
      end;
      break;
    end;
  end;
end;

function tbewegungsszeneneditorform.GetXActual(Device, DeviceChannel, Position: integer):integer;
var
  i:integer;
begin
  result:=0;
      for i:=0 to length(mainform.Figuren)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleBewegungsszene.figur,mainform.figuren[i].ID) then
        begin // Figur gefunden
          with mainform.Figuren[i] do
          begin // Alle Geräte abklappern, und aktive Kanäle nutzen
              if mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].ChanActive then
              begin // Kanal des Gerätes ist aktiviert
{
                if mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].invertx then
                  result:=round(200*((10000-mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scalex)/10000))+round((400-posx[Position]+mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].mittelpunktx-800)*mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scalex/10000)
                else
                  result:=round(200*((10000-mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scalex)/10000))+round((posx[position]+mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].mittelpunktx-800)*mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scalex/10000);
}
                if mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].invertx then
                  result:=round(((400-posx[position]-200)*(mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scalex/10000)+200)+(mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].mittelpunktx-800))
                else
                  result:=round(((posx[position]-200)*(mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scalex/10000)+200)+(mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].mittelpunktx-800));
              end;
          end;
          break;
        end;
  end;
end;

function tbewegungsszeneneditorform.GetYActual(Device, DeviceChannel, Position: integer):integer;
var
  i:integer;
begin
  result:=0;
      for i:=0 to length(mainform.Figuren)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleBewegungsszene.figur,mainform.figuren[i].ID) then
        begin // Figur gefunden
          with mainform.Figuren[i] do
          begin // Alle Geräte abklappern, und aktive Kanäle nutzen
              if mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].ChanActive then
              begin // Kanal des Gerätes ist aktiviert
{
                if mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].inverty then
                  result:=round(200*((10000-mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scaley)/10000))+round((400-posy[Position]+mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].mittelpunkty-800)*mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scaley/10000)
                else
                  result:=round(200*((10000-mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scaley)/10000))+round((posy[position]+mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].mittelpunkty-800)*mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scaley/10000);
}
                if mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].inverty then
                  result:=round(((400-posy[position]-200)*(mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scaley/10000)+200)+(mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].mittelpunkty-800))
                else
                  result:=round(((posy[position]-200)*(mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].scaley/10000)+200)+(mainform.AktuelleBewegungsszene.Devices[Device].DeviceChannel[DeviceChannel].mittelpunkty-800));
              end;
          end;
          break;
        end;
  end;
end;

procedure Tbewegungsszeneneditorform.printPointsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RedrawAll;
end;

procedure Tbewegungsszeneneditorform.printTextMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RedrawAll;
end;

procedure Tbewegungsszeneneditorform.mixXYMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
  Data:PTreeData2;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mixXY:=mixXY.Checked;
    break;
  end;
  checkbuttons;
end;

procedure Tbewegungsszeneneditorform.Edit2Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure Tbewegungsszeneneditorform.Edit2Exit(Sender: TObject);
begin
  mainform.AktuelleBewegungsszene.repeats:=Strtoint(Edit2.Text);
end;

procedure Tbewegungsszeneneditorform.OffsetTrackbarChange(Sender: TObject);
var
  i:integer;
  Data:PTreeData2;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].Offset:=OffsetTrackbar.Position;
    break;
  end;
  if not (Sender=Edit4) then
    Edit4.Text:=inttostr(offsettrackbar.position);
end;

procedure Tbewegungsszeneneditorform.StartpositionRelativMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  mainform.AktuelleBewegungsszene.startpositionrelativ:=StartpositionRelativ.checked;
end;

procedure Tbewegungsszeneneditorform.SaveBewegungsDaten;
var
  t:integer;
begin
  mainform.AktuelleBewegungsszene.Name:=Edit1.Text;
  mainform.AktuelleBewegungsszene.Beschreibung:=Edit3.Text;
  mainform.AktuelleBewegungsszene.Repeats:=StrToInt(Edit2.Text);
  if Combobox1.ItemIndex>-1 then
    mainform.AktuelleBewegungsszene.figur:=mainform.Figuren[Combobox1.ItemIndex].ID;
  mainform.AktuelleBewegungsszene.identischespurgeschwidigkeit:=Checkbox1.Checked;

  t:=strtoint(Time_ms.Text);
  t:=t+1000*strtoint(Time_s.text);
  t:=t+60*1000*strtoint(Time_m.text);
  t:=t+60*60*1000*strtoint(Time_h.text);
  if t>0 then
    mainform.AktuelleBewegungsszene.dauer:=t
  else
    mainform.AktuelleBewegungsszene.dauer:=1000;
end;

procedure Tbewegungsszeneneditorform.Edit3Change(Sender: TObject);
begin
  mainform.AktuelleBewegungsszene.Beschreibung:=Edit3.Text;
end;

procedure Tbewegungsszeneneditorform.Edit4Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if length(TEdit(Sender).text)=0 then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  try
    strtoint(s);
  except
    exit;
  end;

  if strtoint(s)<=OffsetTrackbar.Max then
    OffsetTrackbar.Position:=strtoint(s);
end;

procedure Tbewegungsszeneneditorform.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tbewegungsszeneneditorform.RepaintTimer(Sender: TObject);
begin
  Repaint.Enabled:=false;
  RedrawAll;
end;

procedure Tbewegungsszeneneditorform.AddSceneClick(Sender: TObject);
var
  SzenenData:PTreeData;
  Data:PTreeData2;
  i:integer;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    // ist ein Kanal
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
    if (szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal=mrOK) then
    begin
      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
      SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

      setlength(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice],length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice])+1);
      mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice][length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice])-1].ID:=SzenenData^.ID;
      mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice][length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice])-1].Name:=SzenenData^.Caption;
    end;
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);

    RefreshSceneList;
  end;
end;

procedure Tbewegungsszeneneditorform.RefreshSceneList;
var
  i,j:integer;
  Data:PTreeData2;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    if length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice])>0 then
    begin
      SceneList.Cells[0,0]:=_('Pos');
      SceneList.Cells[1,0]:=_('Szene');

      SceneList.RowCount:=length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice])+1;
      if SceneList.RowCount<2 then
        SceneList.RowCount:=2;
      SceneList.FixedRows:=1;

      for j:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice])-1 do
      begin
        SceneList.Cells[0,j+1]:=inttostr(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice][j].Position);
        SceneList.Cells[1,j+1]:=mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice][j].Name;
      end;
    end else
    begin
      SceneList.RowCount:=2;
      SceneList.FixedRows:=1;
      SceneList.Cells[0,1]:='';
      SceneList.Cells[1,1]:='';
    end;
    break;
  end;
end;

procedure Tbewegungsszeneneditorform.EditSceneClick(Sender: TObject);
var
  SzenenData:PTreeData;
  Data:PTreeData2;
  i:integer;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    if length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice])>0 then
    begin
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionselection:=mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice][SceneList.Row-1].ID;
      if (szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal=mrOK) then
      begin
        if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
        SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

        mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice][SceneList.Row-1].ID:=SzenenData^.ID;
        mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice][SceneList.Row-1].Name:=SzenenData^.Caption;
      end;
      szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
      setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
    end;

    RefreshSceneList;
  end;
end;

procedure Tbewegungsszeneneditorform.DeleteSceneClick(Sender: TObject);
var
  i,j:integer;
  Data:PTreeData2;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    if length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice])>0 then
    begin
      // Alle Elemente um eins nach vorne kopieren
      for j:=SceneList.Row-1 to length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice])-2 do
        mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice][j]:=mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice][j+1];
      // Letztes Element löschen
      setlength(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice],length(mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice])-1);
      // Liste aktualisieren
    end;
    RefreshSceneList;
  end;
end;

procedure Tbewegungsszeneneditorform.SceneListGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
var
	text:string;
begin
  if ACol=1 then
    text:=SceneList.Cells[ACol,ARow];

  if (ACol=1) then
    SceneList.EditorMode:=false else SceneList.EditorMode:=true;

  if ACol=1 then
    SceneList.Cells[ACol,ARow]:=text;
end;

procedure Tbewegungsszeneneditorform.SceneListKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Data:PTreeData2;
  i:integer;
begin
  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    // ist ein Kanal
    if SceneList.Col=0 then
    begin
      try
        mainform.AktuelleBewegungsszene.Devices[i].Szenen[Data^.ChannelInDevice][SceneList.Row-1].Position:=strtoint(SceneList.Cells[SceneList.Col,SceneList.row]);
      except
      end;
    end;
  end;
end;

procedure Tbewegungsszeneneditorform.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j,k,l,m,n:integer;
  exists,active:boolean;
  devicesfordelete:array of TGUID;
  Data:PTreeData2;
  deviceposition:integer;
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
      // Existiert Gerät/Gruppe schon?
      exists:=false;
      for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID,Data^.ID) then
        begin
          exists:=true;
          break;
        end;
      end;

      if checkbox2.Checked and not exists then
      begin
        // Gerät/Gruppe erzeugen/aktivieren
        setlength(mainform.AktuelleBewegungsszene.Devices,length(mainform.AktuelleBewegungsszene.Devices)+1);
        setlength(AktuelleBewegungsszeneZeit,length(mainform.AktuelleBewegungsszene.Devices));
        setlength(AktuelleBewegungsszeneRepeats,length(mainform.AktuelleBewegungsszene.Devices));
        setlength(AktuelleBewegungsszenePosition,length(mainform.AktuelleBewegungsszene.Devices));
        setlength(Zeit,length(mainform.AktuelleBewegungsszene.Devices));
        if Data^.DataType=0 then
        begin
          setlength(mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].DeviceChannel,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].MaxChan);
          setlength(mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].Szenen,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].MaxChan);
        end else
        begin
          setlength(mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].DeviceChannel,length(mainform.DeviceChannelNames));
          setlength(mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].Szenen,length(mainform.DeviceChannelNames));
        end;
        setlength(AktuelleBewegungsszenePosition[length(AktuelleBewegungsszenePosition)-1],length(mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].DeviceChannel));
        setlength(AktuelleBewegungsszeneZeit[length(AktuelleBewegungsszeneZeit)-1],length(mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].DeviceChannel));
        setlength(AktuelleBewegungsszeneRepeats[length(AktuelleBewegungsszeneRepeats)-1],length(mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].DeviceChannel));
        setlength(Zeit[length(Zeit)-1],length(mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].DeviceChannel));

        mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].ID:=Data^.ID;
      end;

      for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID,Data^.ID) then
        begin
          mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].ChanActive:=Checkbox2.Checked;

          if checkbox2.Checked then
          begin
            mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].invertx:=false;
            mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].inverty:=false;
            mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mittelpunktx:=800;
            mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mittelpunkty:=800;
            mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].scalex:=10000;
            mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].scaley:=10000;

            if Data^.DataType=0 then
            begin
              if mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].hasPANTILT
                and ((mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].kanaltyp[Data^.ChannelInDevice]='pan')
                or (mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].kanaltyp[Data^.ChannelInDevice]='tilt')) then
              begin
                mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].x:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].kanaltyp[Data^.ChannelInDevice]='pan';
                mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].y:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].kanaltyp[Data^.ChannelInDevice]='tilt';
              end else
              begin
                mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].x:=false;
                mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].y:=true;
              end;
            end else
            begin
              mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].x:=false;
              mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].y:=true;
            end;

            mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mixXY:=false;
            mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].offset:=0;
          end else
          begin
            // wenn kein Kanal mehr aktiviert, Gerät löschen
            active:=false;
            for j:=0 to length(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel)-1 do
            begin
              if mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[j].ChanActive then
                active:=true;
            end;

            if not active then
            begin // Kein Kanal des aktuellen Gerätes wird mehr verwendet
              setlength(devicesfordelete,length(devicesfordelete)+1);
              devicesfordelete[length(devicesfordelete)-1]:=mainform.AktuelleBewegungsszene.Devices[i].ID;
            end;
          end;
          break;
        end;
      end;
    end;
  end;

  // Nicht mehr benötigte Geräte löschen
  for i:=0 to length(devicesfordelete)-1 do
  begin
    for j:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
    begin
      if IsEqualGUID(devicesfordelete[i],mainform.AktuelleBewegungsszene.Devices[j].ID) then
      begin
        // Gerät in Array gefunden
        if j<length(mainform.AktuelleBewegungsszene.Devices)-1 then
        begin
          // letztes Element hier einfügen
          mainform.AktuelleBewegungsszene.Devices[j].ID:=mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].ID;
          setlength(mainform.AktuelleBewegungsszene.Devices[j].DeviceChannel,length(mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].DeviceChannel));
          setlength(AktuelleBewegungsszeneZeit[j],length(mainform.AktuelleBewegungsszene.Devices[j].DeviceChannel));
          setlength(AktuelleBewegungsszeneRepeats[j],length(mainform.AktuelleBewegungsszene.Devices[j].DeviceChannel));
          setlength(AktuelleBewegungsszenePosition[j],length(mainform.AktuelleBewegungsszene.Devices[j].DeviceChannel));
          setlength(Zeit[j],length(mainform.AktuelleBewegungsszene.Devices[j].DeviceChannel));
          for k:=0 to length(mainform.AktuelleBewegungsszene.Devices[j].DeviceChannel)-1 do
          begin
            mainform.AktuelleBewegungsszene.Devices[j].DeviceChannel[k]:=mainform.AktuelleBewegungsszene.Devices[length(mainform.AktuelleBewegungsszene.Devices)-1].DeviceChannel[k];
          end;
        end;
        // Array um eins kürzen
        setlength(mainform.AktuelleBewegungsszene.Devices,length(mainform.AktuelleBewegungsszene.Devices)-1);
        break;
      end;
    end;
  end;
  setlength(devicesfordelete,0);

  RedrawAll;
  VST.Refresh;
end;

procedure Tbewegungsszeneneditorform.CheckButtons;
var
  i:integer;
  Data:PTreeData2;
begin
  checkbox2.Checked:=false;

  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);
  if Data^.NodeType<3 then exit;

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    Checkbox2.checked:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].ChanActive;

    if (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].x and (not mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mixXY)) or
      (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].y and (mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mixXY)) then
      label8.Caption:=_('Der Kanal nutzt den X-Wert')
    else
      label8.Caption:=_('Der Kanal nutzt den Y-Wert');

    PositionX.Position:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mittelpunktx;
    PositionY.Position:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mittelpunkty;
    ScaleXTrackbar.Position:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].scalex;
    ScaleYTrackbar.Position:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].scaley;
    InvertXCheckbox.Checked:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].invertx;
    InvertYCheckbox.Checked:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].inverty;
    MixXY.Checked:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].mixXY;
    OffsetTrackbar.Position:=mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].Offset;
    Edit4.Text:=inttostr(offsettrackbar.Position);
    Edit10.Text:=inttostr(mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].delay);
    StartpositionRelativ.checked:=mainform.AktuelleBewegungsszene.startpositionrelativ;

    RefreshSceneList;
    break;
  end;
end;

procedure Tbewegungsszeneneditorform.SuchTimerTimer(Sender: TObject);
var
  i,j,k:integer;
  Suchtext:string;
  Data:PTreeData2;
begin
  VST.FullCollapse(nil);
  Suchtext:=Edit1.Text;

  for i:=0 to length(VSTVendorNodes)-1 do
  begin
    Data:=VST.GetNodeData(VSTVendorNodes[i]);

    if StrPos(PChar(LowerCase(String(Data^.Caption))), PChar(LowerCase(Suchtext)))<>nil then
    begin
      VST.Expanded[VSTVendorNodes[i]]:=true;
    end;
  end;

  for i:=0 to length(VSTTypeNodes)-1 do
  for j:=0 to length(VSTTypeNodes[i])-1 do
  begin
    Data:=VST.GetNodeData(VSTTypeNodes[i][j]);

    if StrPos(PChar(LowerCase(String(Data^.Caption))), PChar(LowerCase(Suchtext)))<>nil then
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

    if StrPos(PChar(LowerCase(String(Data^.Caption))), PChar(LowerCase(Suchtext)))<>nil then
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

procedure Tbewegungsszeneneditorform.Edit5Change(Sender: TObject);
begin
  SuchTimer.Enabled:=false;
  SuchTimer.Enabled:=true;
end;

procedure Tbewegungsszeneneditorform.Edit5Enter(Sender: TObject);
begin
  if Edit5.text=_('Suchtext hier eingeben...') then
  begin
    Edit5.Text:='';
    Edit5.Font.Color:=clBlack;
  end;
end;

procedure Tbewegungsszeneneditorform.Edit5Exit(Sender: TObject);
begin
  if Edit5.Text='' then
  begin
    Edit5.Text:=_('Suchtext hier eingeben...');
    Edit5.Font.Color:=clGray;
  end;
end;

procedure Tbewegungsszeneneditorform.Edit5KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then
    SuchTimerTimer(nil);
end;

procedure Tbewegungsszeneneditorform.Button5Click(Sender: TObject);
begin
  VST.FullCollapse(nil);
end;

procedure Tbewegungsszeneneditorform.Button6Click(Sender: TObject);
begin
  VST.FullExpand(nil);
end;

procedure Tbewegungsszeneneditorform.Button7Click(Sender: TObject);
begin
  Repaint.Enabled:=true;
end;

procedure Tbewegungsszeneneditorform.Edit6Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if length(TEdit(Sender).text)=0 then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  try
    strtoint(s);
  except
    exit;
  end;

  if (strtoint(s)>=-800) and (strtoint(s)<=800) then
    PositionX.Position:=strtoint(s)+800;
end;

procedure Tbewegungsszeneneditorform.Edit7Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if length(TEdit(Sender).text)=0 then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  try
    strtoint(s);
  except
    exit;
  end;

  if (strtoint(s)>=-800) and (strtoint(s)<=800) then
    PositionY.Position:=strtoint(s)+800;
end;

procedure Tbewegungsszeneneditorform.Edit8Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if length(TEdit(Sender).text)=0 then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  try
    strtoint(s);
  except
    exit;
  end;

  ScaleXTrackbar.Position:=strtoint(s);
end;

procedure Tbewegungsszeneneditorform.Edit9Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if length(TEdit(Sender).text)=0 then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  try
    strtoint(s);
  except
    exit;
  end;

  ScaleYTrackbar.Position:=strtoint(s);
end;

procedure Tbewegungsszeneneditorform.OffsetTrackbarEnter(Sender: TObject);
begin
  if Combobox1.Items.Count>0 then
    OffsetTrackbar.Max:=length(mainform.Figuren[Combobox1.ItemIndex].posx);
end;

procedure Tbewegungsszeneneditorform.Edit4Enter(Sender: TObject);
begin
  if Combobox1.Items.Count>0 then
    OffsetTrackbar.Max:=length(mainform.Figuren[Combobox1.ItemIndex].posx);
end;

procedure Tbewegungsszeneneditorform.Timer1Timer(Sender: TObject);
begin
  RedrawAll;
end;

procedure Tbewegungsszeneneditorform.FormHide(Sender: TObject);
begin
  Timer1.enabled:=false;
  BewegungsszeneTimer.Enabled:=false;
end;

procedure Tbewegungsszeneneditorform.Button8MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Popupmenu1.Popup(bewegungsszeneneditorform.Left+GroupBox2.Left+Panel11.Left+Button8.Left+x,bewegungsszeneneditorform.Top+GroupBox2.Top+Panel11.Top+Button8.Top+Button8.Height+y);
end;

procedure Tbewegungsszeneneditorform.CheckBox3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.AktuelleBewegungsszene.DontFade:=CheckBox3.Checked;
end;

procedure Tbewegungsszeneneditorform.Button9Click(Sender: TObject);
var
  i,j,k,l,m:integer;
  Data: PTreeData2;
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
      for m:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[m].ID, Data^.ID) then
        begin
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent.Parent.Parent]:=true;
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent.Parent]:=true;
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent]:=true;
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
        end;
      end;
    end;
  end;
end;

procedure Tbewegungsszeneneditorform.Edit10Change(Sender: TObject);
var
  i:integer;
  Data:PTreeData2;
begin
  try
    strtoint(edit10.text);
  except
    exit;
  end;

  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);

  for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
  if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID, Data^.ID) then
  begin
    mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].Delay:=strtoint(edit10.text);
    break;
  end;
end;

procedure Tbewegungsszeneneditorform.CheckBox4MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.AktuelleBewegungsszene.IsBeatControlled:=CheckBox4.Checked;
    Checkbox1.Enabled:=not Checkbox4.checked;
    Time_h.Enabled:=not Checkbox4.checked;
    Time_m.Enabled:=not Checkbox4.checked;
    Time_s.Enabled:=not Checkbox4.checked;
    Time_ms.Enabled:=not Checkbox4.checked;
end;

procedure Tbewegungsszeneneditorform.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PTreeData2;
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

procedure Tbewegungsszeneneditorform.VSTMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CheckButtons;
end;

procedure Tbewegungsszeneneditorform.VSTKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_space then
  begin
    Checkbox1.Checked:=not checkbox1.Checked;
    Checkbox1Mouseup(nil,mbLeft,[],0,0);
  end;
  CheckButtons;
end;

procedure Tbewegungsszeneneditorform.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PTreeData2;
begin
  case Column of
    0:
    begin
      Data:=VST.GetNodeData(Node);
      CellText:=Data^.Caption;

      // Checkbox anzeigen
{
      if (Data^.ChannelInDevice>-1) then
      begin
        if Node.Parent.Parent.Parent=nil then
        begin
          Node.CheckType:=ctTriStateCheckBox;
          if not mainform.AktuelleBewegungsszene.Devices[Data^.DeviceInScene].ChanActiveRandom[Data^.ChannelInDevice] then
            Node.CheckState:=csMixedNormal
          else
          begin
            if mainform.AktuelleBewegungsszene.Devices[Data^.DeviceInScene].ChanActive[Data^.ChannelInDevice] then
              Node.CheckState:=csCheckedNormal
            else
              Node.CheckState:=csUncheckedNormal;
          end;
        end;
      end;
}
    end;
  end;
end;

procedure Tbewegungsszeneneditorform.VSTGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PTreeData2;
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
              for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
              begin
                if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID,Data^.ID) then
                begin // Gerät gefunden
                  ImageIndex:=73;
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
              for i:=0 to length(mainform.AktuelleBewegungsszene.Devices)-1 do
              begin
                if IsEqualGUID(mainform.AktuelleBewegungsszene.Devices[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
                begin // Gerät gefunden
                  if mainform.AktuelleBewegungsszene.Devices[i].DeviceChannel[Data^.ChannelInDevice].ChanActive then
                    ImageIndex:=75
                  else
                    ImageIndex:=74;
                end;
              end;
            end;
          end;
        end;
      end;
      else
        ImageIndex:=-1;
    end;
  end;
end;

procedure Tbewegungsszeneneditorform.VSTDblClick(Sender: TObject);
begin
  Checkbox2.Checked:=not checkbox2.Checked;
  Checkbox2Mouseup(nil,mbLeft,[],0,0);
  CheckButtons;
end;

procedure Tbewegungsszeneneditorform.RefreshTreeNew;
var
  i,j,k:integer;
  vendornode, typenode, devicenode, channelnode:PVirtualNode;
  vendornodeok, typenodeok:integer;
  Data:PTreeData2;
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
    for j:=0 to length(VSTTypeNodes)-1 do
    for k:=0 to length(VSTTypeNodes[j])-1 do
    begin
      Data:=VST.GetNodeData(VSTTypeNodes[j][k]);
      if (Data^.Caption=mainform.devices[i].DeviceName) then
      begin
        typenode:=VSTTypeNodes[j][k];
        typenodeok:=k;
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
    Data^.ChannelInDevice:=-1;
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
    Data^.ChannelInDevice:=-1;
    setlength(VSTDeviceNodes[vendornodeok][typenodeok], length(VSTDeviceNodes[vendornodeok][typenodeok])+1);
    setlength(VSTChannelNodes[vendornodeok][typenodeok], length(VSTChannelNodes[vendornodeok][typenodeok])+1);
    VSTDeviceNodes[vendornodeok][typenodeok][length(VSTDeviceNodes[vendornodeok][typenodeok])-1]:=devicenode;

    // Kanäle der Gruppe hinzufügen
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

  VST.EndUpdate;

  if VST.RootNodeCount>0 then
    VST.Selected[VSTCurrentNode]:=true
  else
    ShowMessage(_('Es sind derzeit keine Geräte installiert.')+#10#13#10#13+_('Bitte fügen Sie mindestens ein Gerät über die Gerätesteuerung hinzu, damit die Geräteszene aufgerufen werden kann.'));
end;

procedure Tbewegungsszeneneditorform.CreateParams(var Params:TCreateParams);
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
