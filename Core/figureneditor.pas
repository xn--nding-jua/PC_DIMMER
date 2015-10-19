unit figureneditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Mask, Menus, Buttons, Registry,
  messagesystem, Math, gnugettext, PngBitBtn, jpeg, pngimage;

type
  TPointF = record
    X:Extended;
    Y:Extended;
  end;

  Tfigureneditorform = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    OKBtn: TButton;
    GroupBox1: TGroupBox;
    PaintBox1: TPaintBox;
    ComboBox1: TComboBox;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Button4: TButton;
    StepsEdit: TEdit;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    printtext: TCheckBox;
    CreateStandardForm: TComboBox;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    ListBox1: TListBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Repaint: TTimer;
    Button3: TButton;
    OpenDialog2: TOpenDialog;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    PngBitBtn3: TPngBitBtn;
    PngBitBtn4: TPngBitBtn;
    loadpicture: TButton;
    OpenDialog3: TOpenDialog;
    Image1: TImage;
    AddBtn: TPngBitBtn;
    DeleteBtn: TPngBitBtn;
    RenameBtn: TPngBitBtn;
    GroupBox5: TGroupBox;
    Label7: TLabel;
    ComboBox2: TComboBox;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    ComboBox3: TComboBox;
    Shape4: TShape;
    Shape1: TShape;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RedrawAll;
    procedure AddBtnClick(Sender: TObject);
    procedure RenameBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure CreateSineClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure printtextMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListboxAktualisieren;
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RepaintTimer(Sender: TObject);
    procedure FormHide(Sender: TObject);
//    procedure Blubb( ACanvas: TCanvas; AnfangsPosition: TPointF; Laenge, Winkel: Integer; var Durchgaenge: Integer );
    procedure BlubbFigur(AnfangsPosition: TPointF; Laenge, Winkel: Integer; var Durchgaenge: Integer);
    function PointF(X, Y:Extended):TPointF;
    procedure Button3Click(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure PngBitBtn3Click(Sender: TObject);
    procedure loadpictureClick(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    _Buffer: TBitmap;
    Punktselektiert: integer;
    backgroundpicture:string;
  public
    { Public-Deklarationen }
    FileStream:TFileStream;
    LoadFigure:Integer;

    procedure NewFile;
    procedure OpenFile(FileName: string);
    procedure AddFile(FileName: string);
    procedure SaveFile(FileName: string; NurAktuelleFigur:boolean);
  end;

var
  figureneditorform: Tfigureneditorform;

implementation

uses PCDIMMER, bewegungsszeneneditor, dxf_previewfrm, geraetesteuerungfrm;

{$R *.dfm}

procedure Tfigureneditorform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  LoadFigure:=-1;
  _Buffer := TBitmap.Create;
	_Buffer.Width:= Paintbox1.Width;
	_Buffer.Height:= Paintbox1.Height;

  Punktselektiert:=-1;
end;

procedure Tfigureneditorform.FormShow(Sender: TObject);
var
  i:integer;
begin
  Combobox1.Clear;
  for i:=0 to length(mainform.Figuren)-1 do
    Combobox1.Items.Add(mainform.Figuren[i].Name);

  Combobox2.Clear;
  for i:=0 to length(mainform.devices)-1 do
    Combobox2.Items.Add(mainform.devices[i].Name);
  Combobox2.Items.Add(_('Keine Vorschau'));
  Combobox2.ItemIndex:=Combobox2.Items.Count-1;

  Combobox3.Clear;
  for i:=0 to length(mainform.DeviceChannelNames)-1 do
    Combobox3.Items.Add(mainform.DeviceChannelNames[i]);
  Combobox3.ItemIndex:=19;

  if length(mainform.Figuren)>0 then
  begin
    RenameBtn.Enabled:=true;
    DeleteBtn.Enabled:=true;
    Combobox1.Enabled:=true;
    GroupBox1.visible:=true;
    GroupBox4.Enabled:=true;
    Combobox1.ItemIndex:=0;
  end;

  if (LoadFigure>-1) then
  begin
    Combobox1.ItemIndex:=LoadFigure;
  end;

  ListboxAktualisieren;
  Repaint.enabled:=true;
end;

procedure Tfigureneditorform.NewFile;
begin
  setlength(mainform.Figuren,0);
  Combobox1.clear;
  RedrawAll;
end;

procedure Tfigureneditorform.OpenFile(FileName: string);
var
  i, k, FigurenCount, PositionenCount:integer;
begin
  if FileExists(FileName) then
  begin
    FileStream:=TFileStream.Create(FileName,fmOpenRead);
	  Filestream.ReadBuffer(FigurenCount,sizeof(FigurenCount));
    setlength(mainform.Figuren,FigurenCount);
    for i:=0 to FigurenCount-1 do
    begin
  	  Filestream.ReadBuffer(mainform.Figuren[i].name,sizeof(mainform.Figuren[i].name));
  	  Filestream.ReadBuffer(mainform.Figuren[i].invertpan,sizeof(mainform.Figuren[i].invertpan));
  	  Filestream.ReadBuffer(mainform.Figuren[i].inverttilt,sizeof(mainform.Figuren[i].inverttilt));
  	  Filestream.ReadBuffer(PositionenCount,sizeof(PositionenCount));
      setlength(mainform.Figuren[i].posx,PositionenCount);
      setlength(mainform.Figuren[i].posy,PositionenCount);
      for k:=0 to PositionenCount-1 do
      begin
    	  Filestream.ReadBuffer(mainform.Figuren[i].posx[k],sizeof(mainform.Figuren[i].posx[k]));
    	  Filestream.ReadBuffer(mainform.Figuren[i].posy[k],sizeof(mainform.Figuren[i].posy[k]));
      end;
    end;
	  FileStream.Free;
  end;

  Combobox1.Clear;

  for i:=0 to length(mainform.Figuren)-1 do
    Combobox1.Items.Add(mainform.Figuren[i].Name);

  if length(mainform.Figuren)>0 then
  begin
    RenameBtn.Enabled:=true;
    DeleteBtn.Enabled:=true;
    Combobox1.Enabled:=true;
    GroupBox1.visible:=true;
    GroupBox4.Enabled:=true;
    Combobox1.ItemIndex:=0;
//    Combobox1.Text:=Combobox1.Items.Strings[Combobox1.ItemIndex];
    RedrawAll;
  end;
end;

procedure Tfigureneditorform.AddFile(FileName: string);
var
  i, k, FigurenCount, PositionenCount,startposition:integer;
begin
  if FileExists(FileName) then
  begin
    FileStream:=TFileStream.Create(FileName,fmOpenRead);

    startposition:=length(mainform.Figuren);

	  Filestream.ReadBuffer(FigurenCount,sizeof(FigurenCount));
    setlength(mainform.Figuren,startposition+FigurenCount);
    for i:=startposition to length(mainform.Figuren)-1 do
    begin
  	  Filestream.ReadBuffer(mainform.Figuren[i].name,sizeof(mainform.Figuren[i].name));
  	  Filestream.ReadBuffer(mainform.Figuren[i].invertpan,sizeof(mainform.Figuren[i].invertpan));
  	  Filestream.ReadBuffer(mainform.Figuren[i].inverttilt,sizeof(mainform.Figuren[i].inverttilt));
  	  Filestream.ReadBuffer(PositionenCount,sizeof(PositionenCount));
      setlength(mainform.Figuren[i].posx,PositionenCount);
      setlength(mainform.Figuren[i].posy,PositionenCount);
      for k:=0 to PositionenCount-1 do
      begin
    	  Filestream.ReadBuffer(mainform.Figuren[i].posx[k],sizeof(mainform.Figuren[i].posx[k]));
    	  Filestream.ReadBuffer(mainform.Figuren[i].posy[k],sizeof(mainform.Figuren[i].posy[k]));
      end;
    end;
	  FileStream.Free;
  end;

  Combobox1.Clear;

  for i:=0 to length(mainform.Figuren)-1 do
    Combobox1.Items.Add(mainform.Figuren[i].Name);

  if length(mainform.Figuren)>0 then
  begin
    RenameBtn.Enabled:=true;
    DeleteBtn.Enabled:=true;
    Combobox1.Enabled:=true;
    GroupBox1.visible:=true;
    GroupBox4.Enabled:=true;
    Combobox1.ItemIndex:=0;
//    Combobox1.Text:=Combobox1.Items.Strings[Combobox1.ItemIndex];
    RedrawAll;
  end;
end;

procedure Tfigureneditorform.SaveFile(FileName: string; NurAktuelleFigur:boolean);
var
  i, k, FigurenCount, PositionenCount:integer;
begin
    if not DirectoryExists(ExtractFilepath(Filename)) then
      CreateDir(ExtractFilepath(Filename));
    FileStream:=TFileStream.Create(FileName,fmCreate);
    FigurenCount:=length(mainform.Figuren);
	  Filestream.WriteBuffer(FigurenCount,sizeof(FigurenCount));
    for i:=0 to FigurenCount-1 do
    begin
      if (NurAktuelleFigur and (i=Combobox1.ItemIndex)) or (not NurAktuelleFigur) then
      begin
    	  Filestream.WriteBuffer(mainform.Figuren[i].name,sizeof(mainform.Figuren[i].name));
    	  Filestream.WriteBuffer(mainform.Figuren[i].invertpan,sizeof(mainform.Figuren[i].invertpan));
    	  Filestream.WriteBuffer(mainform.Figuren[i].inverttilt,sizeof(mainform.Figuren[i].inverttilt));
        PositionenCount:=length(mainform.Figuren[i].posx);
    	  Filestream.WriteBuffer(PositionenCount,sizeof(PositionenCount));
        for k:=0 to PositionenCount-1 do
        begin
      	  Filestream.WriteBuffer(mainform.Figuren[i].posx[k],sizeof(mainform.Figuren[i].posx[k]));
      	  Filestream.WriteBuffer(mainform.Figuren[i].posy[k],sizeof(mainform.Figuren[i].posy[k]));
        end;
      end;
    end;
	  FileStream.Free;
end;

procedure Tfigureneditorform.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, k:integer;
begin
  if Combobox1.ItemIndex>-1 then
  begin
    if RadioButton1.Checked then // Punkt hinzufügen
    begin
      setlength(mainform.Figuren[Combobox1.ItemIndex].posx,length(mainform.Figuren[Combobox1.ItemIndex].posx)+1);
      setlength(mainform.Figuren[Combobox1.ItemIndex].posy,length(mainform.Figuren[Combobox1.ItemIndex].posy)+1);
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-1]:=x;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-1]:=y;
//      Paintbox1.Canvas.Brush.Color:=clYellow;
//      Paintbox1.Canvas.Ellipse(x-3,y-3,x+3,y+3);
      ListBox1.Items.Add(inttostr(length(mainform.Figuren[Combobox1.ItemIndex].posx)-1)+' x: '+inttostr(mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-1])+' y: '+inttostr(mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posx)-1]));
      RedrawAll;
    end;
    if RadioButton3.Checked then // Punkt löschen
    begin
      for i:=0 to length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 do
      begin
        if Punktselektiert=-1 then
        if (mainform.Figuren[Combobox1.ItemIndex].posx[i]>(x-3)) and (mainform.Figuren[Combobox1.ItemIndex].posx[i]<(x+3)) then
          if (mainform.Figuren[Combobox1.ItemIndex].posy[i]>(y-3)) and (mainform.Figuren[Combobox1.ItemIndex].posy[i]<(y+3)) then
          begin
            Punktselektiert:=i;
            ListBox1.Items.Delete(i);
            // Alle späteren Punkte um eine Position nach vorne holen
            for k:=i to length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 do
            begin
              mainform.Figuren[Combobox1.ItemIndex].posx[k]:=mainform.Figuren[Combobox1.ItemIndex].posx[k+1];
              mainform.Figuren[Combobox1.ItemIndex].posy[k]:=mainform.Figuren[Combobox1.ItemIndex].posy[k+1];
            end;
            // letzte Position löschen und neuzeichnen
            setlength(mainform.Figuren[Combobox1.ItemIndex].posx,length(mainform.Figuren[Combobox1.ItemIndex].posx)-1);
            setlength(mainform.Figuren[Combobox1.ItemIndex].posy,length(mainform.Figuren[Combobox1.ItemIndex].posy)-1);
            RedrawAll;
          end;
      end;
    end;
  end;
end;

procedure Tfigureneditorform.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  i:integer;
	pan, tilt:Extended;
begin
  if (Combobox1.ItemIndex>-1) and (Shift=[ssLeft]) and (RadioButton2.Checked) then
  begin
    // Punkt verschieben
    if punktselektiert>-1 then
    begin
      Listbox1.Items.Strings[punktselektiert]:=inttostr(punktselektiert)+' x: '+inttostr(mainform.Figuren[Combobox1.ItemIndex].posx[punktselektiert])+' y: '+inttostr(mainform.Figuren[Combobox1.ItemIndex].posy[punktselektiert]);
      mainform.Figuren[Combobox1.ItemIndex].posx[Punktselektiert]:=x;
      mainform.Figuren[Combobox1.ItemIndex].posy[Punktselektiert]:=y;

      if Combobox2.ItemIndex<length(mainform.devices) then
      begin
        if Radiobutton5.Checked then
        begin
          // Vorschau auf speziellem Gerätekanal
          geraetesteuerung.set_channel(mainform.devices[combobox2.itemindex].ID, mainform.devicechannelnames[combobox3.itemindex], -1, round(255*(mainform.Figuren[Combobox1.ItemIndex].posy[punktselektiert]/400)), 0, 0);
        end else
        begin
          // Vorschau auf Pan/Tilt des Gerätes
          pan:=255*(mainform.Figuren[Combobox1.ItemIndex].posx[punktselektiert]/400);
          tilt:=255*(mainform.Figuren[Combobox1.ItemIndex].posy[punktselektiert]/400);
          geraetesteuerung.set_channel(mainform.devices[combobox2.itemindex].ID, 'PAN', -1, trunc(pan), 0, 0);
          geraetesteuerung.set_channel(mainform.devices[combobox2.itemindex].ID, 'PANFINE', -1, trunc(frac(pan)*255), 0, 0);
          geraetesteuerung.set_channel(mainform.devices[combobox2.itemindex].ID, 'TILT', -1, trunc(tilt), 0, 0);
          geraetesteuerung.set_channel(mainform.devices[combobox2.itemindex].ID, 'TILTFINE', -1, trunc(frac(tilt)*255), 0, 0);
        end;
      end;
    end else
    begin
      for i:=0 to length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 do
      begin
        if (mainform.Figuren[Combobox1.ItemIndex].posx[i]>(x-3)) and (mainform.Figuren[Combobox1.ItemIndex].posx[i]<(x+3)) then
        begin
          if (mainform.Figuren[Combobox1.ItemIndex].posy[i]>(y-3)) and (mainform.Figuren[Combobox1.ItemIndex].posy[i]<(y+3)) then
          begin
            Punktselektiert:=i;
            break;
          end;
        end;
      end;
    end;

    // Alles neu zeichnen
    RedrawAll;
  end;
end;

procedure Tfigureneditorform.RedrawAll;
var
  i:integer;
begin
  if backgroundpicture='' then
  begin
    _Buffer.Canvas.Brush.Color := clBlack;
    _Buffer.Canvas.FillRect(_Buffer.Canvas.ClipRect);
  end else
  begin
    try
      _Buffer.LoadFromFile(backgroundpicture);
    except
      _Buffer.Canvas.Brush.Color := clBlack;
      _Buffer.Canvas.FillRect(_Buffer.Canvas.ClipRect);
    end;
  end;

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

  if (Combobox1.enabled) and (Combobox1.items.count>0) and (Combobox1.itemindex>-1) then
  begin
    // Punkte und Linien zeichnen
    if length(mainform.Figuren[Combobox1.ItemIndex].posx) >0 then
    begin
      for i:=0 to length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 do
      begin
        // Linien zeichnen
//        _Buffer.Canvas.Pen.Color:=clWhite;
        _Buffer.Canvas.Pen.Color:=clYellow;
        if ((i+1)<=length(mainform.Figuren[Combobox1.ItemIndex].posx)-1) then
        begin
          // Normale Punkteverbindung zeichnen
          _Buffer.Canvas.MoveTo(mainform.Figuren[Combobox1.ItemIndex].posx[i],mainform.Figuren[Combobox1.ItemIndex].posy[i]);
          _Buffer.Canvas.LineTo(mainform.Figuren[Combobox1.ItemIndex].posx[i+1],mainform.Figuren[Combobox1.ItemIndex].posy[i+1]);
        end else
        begin
          // Zurück zum ersten Punkt
          _Buffer.Canvas.Pen.Color:=clRed;
          _Buffer.Canvas.MoveTo(mainform.Figuren[Combobox1.ItemIndex].posx[i],mainform.Figuren[Combobox1.ItemIndex].posy[i]);
          _Buffer.Canvas.LineTo(mainform.Figuren[Combobox1.ItemIndex].posx[0],mainform.Figuren[Combobox1.ItemIndex].posy[0]);
        end;

        // Punkte zeichnen
        if Punktselektiert=i then
          _Buffer.Canvas.Brush.Color:=$000080FF//clRed
        else
        begin
          if i=0 then
            _Buffer.Canvas.Brush.Color:=clLime
          else if i=length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 then
          _Buffer.Canvas.Brush.Color:=clRed
          else
          _Buffer.Canvas.Brush.Color:=clYellow;
        end;
        _Buffer.Canvas.Pen.Color:=-1;
        _Buffer.Canvas.Ellipse(mainform.Figuren[Combobox1.ItemIndex].posx[i]-3,mainform.Figuren[Combobox1.ItemIndex].posy[i]-3,mainform.Figuren[Combobox1.ItemIndex].posx[i]+3,mainform.Figuren[Combobox1.ItemIndex].posy[i]+3);

      // Bezeichnungen ausgeben
        if printtext.Checked then
        begin
          _Buffer.Canvas.Brush.Color:=clBlack;
          if i=Punktselektiert then
          begin
            _Buffer.Canvas.Font.Color:=$000080FF;
            if mainform.Figuren[Combobox1.ItemIndex].posx[i]<375 then
              _Buffer.Canvas.TextOut(mainform.Figuren[Combobox1.ItemIndex].posx[i],mainform.Figuren[Combobox1.ItemIndex].posy[i]-15,_('Aktuell'))
            else
              _Buffer.Canvas.TextOut(mainform.Figuren[Combobox1.ItemIndex].posx[i]-30,mainform.Figuren[Combobox1.ItemIndex].posy[i]-15,_('Aktuell'));
          end else if i=0 then
          begin
            _Buffer.Canvas.Font.Color:=clLime;
            if mainform.Figuren[Combobox1.ItemIndex].posx[i]<375 then
              _Buffer.Canvas.TextOut(mainform.Figuren[Combobox1.ItemIndex].posx[i],mainform.Figuren[Combobox1.ItemIndex].posy[i]-15,_('Start'))
            else
              _Buffer.Canvas.TextOut(mainform.Figuren[Combobox1.ItemIndex].posx[i]-25,mainform.Figuren[Combobox1.ItemIndex].posy[i]-15,_('Start'));
          end else if i=length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 then
          begin
            _Buffer.Canvas.Font.Color:=clRed;
            if mainform.Figuren[Combobox1.ItemIndex].posx[i]<375 then
              _Buffer.Canvas.TextOut(mainform.Figuren[Combobox1.ItemIndex].posx[i],mainform.Figuren[Combobox1.ItemIndex].posy[i]-15,_('Stop'))
            else
              _Buffer.Canvas.TextOut(mainform.Figuren[Combobox1.ItemIndex].posx[i]-25,mainform.Figuren[Combobox1.ItemIndex].posy[i]-15,_('Stop'));
          end else
          begin
            _Buffer.Canvas.Font.Color:=clYellow;
            if mainform.Figuren[Combobox1.ItemIndex].posx[i]<385 then
              _Buffer.Canvas.TextOut(mainform.Figuren[Combobox1.ItemIndex].posx[i],mainform.Figuren[Combobox1.ItemIndex].posy[i]-15,inttostr(i))
            else
              _Buffer.Canvas.TextOut(mainform.Figuren[Combobox1.ItemIndex].posx[i]-15,mainform.Figuren[Combobox1.ItemIndex].posy[i]-15,inttostr(i));
          end;
        end;
      end;
    end else
    begin
      _Buffer.Canvas.Pen.Color:=clWhite;
      _Buffer.Canvas.Font.Color:=clWhite;
      _Buffer.Canvas.Font.Size:=10;
      _Buffer.Canvas.Font.Name:='Arial';
      _Buffer.Canvas.Font.Style:=[fsBold];
      _Buffer.Canvas.TextOut(8,25,_('Klicken Sie in dieses Fenster, um Punkte hinzuzufügen...'));
    end;

    // Informationen aktualisieren
    label5.Caption:=inttostr(length(mainform.Figuren[Combobox1.ItemIndex].posx));
    label6.Caption:=inttostr(round(bewegungsszeneneditorform.FigurLength(mainform.Figuren[Combobox1.ItemIndex].ID)))+' Pixel';
  end else if not (Combobox1.enabled) then
  begin
    _Buffer.Canvas.Pen.Color:=clWhite;
    _Buffer.Canvas.Font.Color:=clWhite;
    _Buffer.Canvas.Font.Size:=10;
    _Buffer.Canvas.Font.Name:='Arial';
    _Buffer.Canvas.Font.Style:=[fsBold];
    _Buffer.Canvas.TextOut(8,_Buffer.Height div 2-5,_('Bitte oben über "Hinzufügen" eine neue Figur erstellen...'));
  end;
  BitBlt(PaintBox1.canvas.Handle,0,0,400,400,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Tfigureneditorform.AddBtnClick(Sender: TObject);
var
  NewGUID: TGUID;
begin
  Combobox1.Items.Add(_('Neue Figur'));
  Combobox1.ItemIndex:=Combobox1.Items.Count-1;
  LoadFigure:=Combobox1.itemindex;
  setlength(mainform.Figuren,length(mainform.Figuren)+1);
  mainform.Figuren[Combobox1.ItemIndex].Name:=_('Neue Figur');

  CreateGUID(NewGUID);
  mainform.Figuren[Combobox1.ItemIndex].ID:=NewGUID;

  ListboxAktualisieren;
  RenameBtn.Enabled:=true;
  DeleteBtn.Enabled:=true;
  GroupBox1.visible:=true;
  GroupBox4.Enabled:=true;
  Combobox1.Enabled:=true;
  RenameBtnClick(nil);
  RedrawAll;
end;

procedure Tfigureneditorform.RenameBtnClick(Sender: TObject);
var
  position:integer;
begin
  position:=Combobox1.ItemIndex;
  mainform.Figuren[Combobox1.ItemIndex].Name:=InputBox(_('Bewegungsszene umbenennen'),_('Bitte geben Sie eine neue Bezeichnung für diese Bewegungsszene ein:'),mainform.Figuren[Combobox1.ItemIndex].Name);
  Combobox1.Items.Strings[position]:=mainform.Figuren[Combobox1.ItemIndex].Name;
  Combobox1.ItemIndex:=position;
  RedrawAll;
end;

procedure Tfigureneditorform.DeleteBtnClick(Sender: TObject);
var
  i, k, position:integer;
begin
  if messagedlg(_('Aktuelle Figur löschen?'),mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    position:=Combobox1.ItemIndex;
    if position<Combobox1.Items.Count-1 then
    begin
      // Alle späteren Einträge um eins nach vorne holen
      for i:=Combobox1.ItemIndex to length(mainform.Figuren)-2 do
      begin
        Combobox1.Items.Strings[i]:=Combobox1.Items.Strings[i+1];
        mainform.Figuren[i].Name:=mainform.Figuren[i+1].Name;
        mainform.Figuren[i].invertpan:=mainform.Figuren[i+1].invertpan;
        mainform.Figuren[i].inverttilt:=mainform.Figuren[i+1].inverttilt;
        for k:=0 to length(mainform.Figuren[i].posx)-1 do
        begin
          mainform.Figuren[i].posx[k]:=mainform.Figuren[i+1].posx[k];
          mainform.Figuren[i].posy[k]:=mainform.Figuren[i+1].posy[k];
        end;
      end;
    end;

    // letzten Eintrag löschen
    Combobox1.Items.Delete(Combobox1.Items.Count-1);
    setlength(mainform.Figuren,length(mainform.Figuren)-1);

    if Combobox1.Items.Count=0 then
    begin
      RenameBtn.Enabled:=false;
      DeleteBtn.Enabled:=false;
      GroupBox1.visible:=false;
      GroupBox4.Enabled:=false;
      Combobox1.Enabled:=false;
      LoadFigure:=-1;
    end else
      if position<Combobox1.Items.Count then
        Combobox1.ItemIndex:=position
      else
        Combobox1.ItemIndex:=0;

    Combobox1.Refresh;
    ListboxAktualisieren;
    RedrawAll;
  end;
end;

procedure Tfigureneditorform.ComboBox1Change(Sender: TObject);
begin
  LoadFigure:=Combobox1.itemindex;
  ListboxAktualisieren;
  RedrawAll;
end;

procedure Tfigureneditorform.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Punktselektiert:=-1;
  RedrawAll;
end;

procedure Tfigureneditorform.Button4Click(Sender: TObject);
begin
  if messagedlg(_('Alle Punkte der aktuellen Figur löschen?'),mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    setlength(mainform.Figuren[Combobox1.ItemIndex].posx,0);
    setlength(mainform.Figuren[Combobox1.ItemIndex].posy,0);
    ListboxAktualisieren;
    RedrawAll;
  end;
end;

procedure Tfigureneditorform.CreateSineClick(Sender: TObject);
var
  i, startposition, steps, stepshalb,e:integer;
begin
  steps:=strtoint(StepsEdit.text)-1;
  stepshalb:=steps div 2;
  startposition:=length(mainform.Figuren[Combobox1.ItemIndex].posx);

  case CreateStandardForm.ItemIndex of
    0..4,6:
    begin
      setlength(mainform.Figuren[Combobox1.ItemIndex].posx,length(mainform.Figuren[Combobox1.ItemIndex].posx)+steps+1);
      setlength(mainform.Figuren[Combobox1.ItemIndex].posy,length(mainform.Figuren[Combobox1.ItemIndex].posy)+steps+1);
    end;
    5:
    begin
      setlength(mainform.Figuren[Combobox1.ItemIndex].posx,length(mainform.Figuren[Combobox1.ItemIndex].posx)+steps);
      setlength(mainform.Figuren[Combobox1.ItemIndex].posy,length(mainform.Figuren[Combobox1.ItemIndex].posy)+steps);
    end;
    7:
    begin
      // Array wird innerhalb rekursiver Funktion erweitert
    end;
    8:
    begin
      setlength(mainform.Figuren[Combobox1.ItemIndex].posx,length(mainform.Figuren[Combobox1.ItemIndex].posx)+48);
      setlength(mainform.Figuren[Combobox1.ItemIndex].posy,length(mainform.Figuren[Combobox1.ItemIndex].posy)+48);
    end;
  end;

  if CreateStandardForm.ItemIndex=6 then
    Randomize;

  case CreateStandardForm.ItemIndex of
    0:
    begin
      for i:=0 to steps do
      begin
        mainform.Figuren[Combobox1.ItemIndex].posx[i+startposition]:=round((i/steps)*400);
        mainform.Figuren[Combobox1.ItemIndex].posy[i+startposition]:=round((1-sin(degtorad(round((i/steps)*360))))*200);
      end;
    end;
    1:
    begin
      for i:=0 to steps do
      begin
        mainform.Figuren[Combobox1.ItemIndex].posx[i+startposition]:=round((i/steps)*400);
        mainform.Figuren[Combobox1.ItemIndex].posy[i+startposition]:=round((1-cos(degtorad(round((i/steps)*360))))*200);
      end;
    end;
    2:
    begin
      for i:=0 to steps do
      begin
        if i<=stepshalb then
        begin
          // erster Sinus
          mainform.Figuren[Combobox1.ItemIndex].posx[i+startposition]:=round((i/(stepshalb+1))*400);
          mainform.Figuren[Combobox1.ItemIndex].posy[i+startposition]:=round((1-sin(degtorad(round((i/(stepshalb+1))*360))))*200);
        end else if i<steps then
        begin
          // invertierter Sinus
          mainform.Figuren[Combobox1.ItemIndex].posx[steps-(i-stepshalb)+startposition]:=round(((i+1-stepshalb)/(stepshalb+1))*400);
          mainform.Figuren[Combobox1.ItemIndex].posy[steps-(i-stepshalb)+startposition]:=400-round((1-sin(degtorad(round(((i+1-stepshalb)/(stepshalb+1))*360))))*200);
        end else
        begin
          // Endpunkt
          mainform.Figuren[Combobox1.ItemIndex].posx[i+startposition]:=round(((i+1-steps)/(steps))*400);
          mainform.Figuren[Combobox1.ItemIndex].posy[i+startposition]:=400-round((1-sin(degtorad(round(((i+1-steps)/(steps))*360))))*200);
        end;
      end;
    end;
    3:
    begin
      for i:=0 to steps do
      begin
        mainform.Figuren[Combobox1.ItemIndex].posx[i+startposition]:=round((i/steps)*400);
        mainform.Figuren[Combobox1.ItemIndex].posy[i+startposition]:=200-round(sqrt(power(200,2)-power(200-((i/steps)*400),2)));
      end;
    end;
    4:
    begin
      for i:=0 to steps do
      begin
        mainform.Figuren[Combobox1.ItemIndex].posx[(steps-i)+startposition]:=round((i/steps)*400);
        mainform.Figuren[Combobox1.ItemIndex].posy[i+startposition]:=round(sqrt(power(200,2)-power(200-((i/steps)*400),2)))+200;
      end;
    end;
{
    if Sender=CreateCircle then
    begin
      if i<=stepshalb then
      begin
        // 0 bis steps/2
        mainform.Figuren[Combobox1.ItemIndex].posx[i+startposition]:=round((i/stepshalb)*400);
        mainform.Figuren[Combobox1.ItemIndex].posy[i+startposition]:=200-round(sqrt(power(200,2)-power(200-((i/stepshalb)*400),2)));
      end else
      if (i>stepshalb) and (i<steps) then
      begin
        // steps/2 bis steps
        mainform.Figuren[Combobox1.ItemIndex].posx[(steps-(i-stepshalb))+startposition]:=round(((i-stepshalb)/stepshalb)*400);
        mainform.Figuren[Combobox1.ItemIndex].posy[(steps-(i-stepshalb))+startposition]:=round(sqrt(power(200,2)-power(200-(((i-stepshalb)/stepshalb)*400),2)))+200;
      end;
    end;
}
    5:
    begin
      for i:=0 to steps do
      begin
        if i<steps then
        begin
          mainform.Figuren[Combobox1.ItemIndex].posx[i+startposition]:=round(cos(degtorad((i/steps)*360))*200)+200;
          mainform.Figuren[Combobox1.ItemIndex].posy[i+startposition]:=round(sin(degtorad((i/steps)*360))*200)+200;
        end;
      end;
    end;
    6:
    begin
      for i:=0 to steps do
      begin
        mainform.Figuren[Combobox1.ItemIndex].posx[i+startposition]:=Random(401);
        mainform.Figuren[Combobox1.ItemIndex].posy[i+startposition]:=Random(401);
      end;
    end;
    7:
    begin
      e:=steps;
      BlubbFigur(pointF(210, 390), 335, 90, e );
    end;
    8:
    begin
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-48]:=6;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-48]:=7;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-47]:=45;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-47]:=27;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-46]:=83;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-46]:=42;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-45]:=122;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-45]:=50;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-44]:=161;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-44]:=52;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-43]:=200;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-43]:=54;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-42]:=238;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-42]:=52;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-41]:=276;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-41]:=47;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-40]:=310;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-40]:=39;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-39]:=351;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-39]:=27;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-38]:=395;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-38]:=4;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-37]:=322;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-37]:=49;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-36]:=280;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-36]:=73;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-35]:=242;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-35]:=95;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-34]:=209;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-34]:=121;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-33]:=181;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-33]:=150;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-32]:=171;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-32]:=172;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-31]:=167;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-31]:=199;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-30]:=170;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-30]:=225;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-29]:=179;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-29]:=248;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-28]:=210;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-28]:=280;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-27]:=241;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-27]:=302;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-26]:=280;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-26]:=328;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-25]:=319;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-25]:=351;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-24]:=392;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-24]:=393;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-23]:=348;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-23]:=376;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-22]:=309;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-22]:=363;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-21]:=278;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-21]:=354;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-20]:=240;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-20]:=346;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-19]:=200;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-19]:=343;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-18]:=160;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-18]:=345;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-17]:=120;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-17]:=349;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-16]:=79;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-16]:=359;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-15]:=46;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-15]:=376;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-14]:=4;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-14]:=396;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-13]:=81;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-13]:=350;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-12]:=119;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-12]:=326;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-11]:=160;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-11]:=302;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-10]:=191;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-10]:=281;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-9]:=224;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-9]:=250;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-8]:=235;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-8]:=225;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-7]:=236;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-7]:=201;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-6]:=230;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-6]:=172;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-5]:=220;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-5]:=150;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-4]:=192;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-4]:=121;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-3]:=158;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-3]:=96;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-2]:=121;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-2]:=74;
      mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-1]:=80;
      mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posy)-1]:=52;
    end;
  end;
  ListboxAktualisieren;
  RedrawAll;
end;

procedure Tfigureneditorform.SpeedButton3Click(Sender: TObject);
begin
  if messagedlg(_('Möchten Sie wirklich alle Figuren löschen?'),mtWarning,[mbYes,mbNo],0)=mrYes then
    NewFile;
end;

procedure Tfigureneditorform.SpeedButton1Click(Sender: TObject);
begin
	case mainform.mymessagedlg(_('Wie sollen die Figuren aus der Datei geladen werden?'),mtConfirmation,[mbYes,mbAll,mbCancel],[_('&Hinzufügen'),_('&Ersetzen'),_('Ab&brechen')]) of
    mrYes:
      if OpenDialog1.Execute then
        AddFile(OpenDialog1.filename);
    mrCancel:
      if OpenDialog1.Execute then
        OpenFile(OpenDialog1.filename);
  end;
end;

procedure Tfigureneditorform.SpeedButton2Click(Sender: TObject);
begin
	case mainform.mymessagedlg(_('Welche Figuren sollen gespeichert werden?'),mtConfirmation,[mbYes,mbAll,mbCancel],[_('&Nur aktuelle'),_('&Alle'),_('Ab&brechen')]) of
    mrYes:
      if SaveDialog1.Execute then
        SaveFile(SaveDialog1.filename, true);
    mrCancel:
      if SaveDialog1.Execute then
        SaveFile(SaveDialog1.filename, false);
  end;
end;

procedure Tfigureneditorform.printtextMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RedrawAll;
end;

procedure Tfigureneditorform.ListboxAktualisieren;
var
  i:integer;
begin
  LockWindow(Listbox1.Handle);
  Listbox1.Clear;
  if (length(mainform.Figuren)>0) and (Combobox1.ItemIndex<length(mainform.Figuren)) then
    for i:=0 to length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 do
      ListBox1.Items.Add(inttostr(i)+' x: '+inttostr(mainform.Figuren[Combobox1.ItemIndex].posx[i])+' y: '+inttostr(mainform.Figuren[Combobox1.ItemIndex].posy[i]));
  UnLockWindow(Listbox1.Handle);
end;

procedure Tfigureneditorform.ListBox1Click(Sender: TObject);
begin
  Punktselektiert:=Listbox1.ItemIndex;
  RedrawAll;
end;

procedure Tfigureneditorform.Button2Click(Sender: TObject);
var
  i,k:integer;
begin
      for i:=length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 downto 0 do
      begin
        if Listbox1.Selected[i] then
          begin
            // Alle späteren Punkte um eine Position nach vorne holen
            for k:=i to length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 do
            begin
              mainform.Figuren[Combobox1.ItemIndex].posx[k]:=mainform.Figuren[Combobox1.ItemIndex].posx[k+1];
              mainform.Figuren[Combobox1.ItemIndex].posy[k]:=mainform.Figuren[Combobox1.ItemIndex].posy[k+1];
            end;
            // letzte Position löschen und neuzeichnen
            setlength(mainform.Figuren[Combobox1.ItemIndex].posx,length(mainform.Figuren[Combobox1.ItemIndex].posx)-1);
            setlength(mainform.Figuren[Combobox1.ItemIndex].posy,length(mainform.Figuren[Combobox1.ItemIndex].posy)-1);
            RedrawAll;
          end;
      end;
      ListboxAktualisieren;
end;

procedure Tfigureneditorform.Button1Click(Sender: TObject);
var
  i,position:integer;
begin
  position:=Listbox1.ItemIndex;
  // Array um eins erweitern
  setlength(mainform.Figuren[Combobox1.ItemIndex].posx,length(mainform.Figuren[Combobox1.ItemIndex].posx)+1);
  setlength(mainform.Figuren[Combobox1.ItemIndex].posy,length(mainform.Figuren[Combobox1.ItemIndex].posy)+1);

  // Alle Punkte ab Listenindex um eine Position nach hinten schieben
  for i:=length(mainform.Figuren[Combobox1.ItemIndex].posx)-1 downto Listbox1.ItemIndex do
  begin
    mainform.Figuren[Combobox1.ItemIndex].posx[i]:=mainform.Figuren[Combobox1.ItemIndex].posx[i-1];
    mainform.Figuren[Combobox1.ItemIndex].posy[i]:=mainform.Figuren[Combobox1.ItemIndex].posy[i-1];
  end;

  // Neuen Punkt auf 200x200 setzen
  mainform.Figuren[Combobox1.ItemIndex].posx[position]:=200;
  mainform.Figuren[Combobox1.ItemIndex].posy[position]:=200;

  RedrawAll;
  ListboxAktualisieren;
end;

procedure Tfigureneditorform.OKBtnClick(Sender: TObject);
begin
  if length(mainform.Figuren)>0 then
    mainform.Figuren[Combobox1.ItemIndex].Gesamtlaenge:=round(bewegungsszeneneditorform.FigurLength(mainform.Figuren[Combobox1.ItemIndex].ID));
end;

procedure Tfigureneditorform.ListBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Punktselektiert:=Listbox1.ItemIndex;
  RedrawAll;
end;

procedure Tfigureneditorform.RepaintTimer(Sender: TObject);
begin
  Repaint.Enabled:=false;
  RedrawAll;
end;

procedure Tfigureneditorform.FormHide(Sender: TObject);
begin
  Repaint.enabled:=false;
end;

{
procedure Tfigureneditorform.Blubb( ACanvas: TCanvas; AnfangsPosition: TPointF; Laenge, Winkel: Integer;
  var Durchgaenge: Integer );
var
  b: integer;
  Richtung, Temp: TPointF;
begin
  if Durchgaenge > 0 then
  begin
    dec( Durchgaenge );
    Richtung.X := Cos( Winkel ) * Laenge;
    Richtung.Y := Sin( Winkel ) * Laenge;
    with ACanvas do
    begin
      MoveTo( Round(AnfangsPosition.x), Round(AnfangsPosition.Y) );
      LineTo( Round(AnfangsPosition.x-Richtung.X), Round(AnfangsPosition.Y-Richtung.Y) );
    end;

    Blubb( ACanvas, PointF( AnfangsPosition.x-Richtung.X, AnfangsPosition.Y-Richtung.Y ),
      Laenge - ( Laenge * 2 ), WInkel + 45, Durchgaenge );
  end;
end;
}

procedure Tfigureneditorform.BlubbFigur(AnfangsPosition: TPointF; Laenge, Winkel: Integer; var Durchgaenge: Integer);
var
  Richtung: TPointF;
begin
  if Durchgaenge > 0 then
  begin
    dec(Durchgaenge);
    Richtung.X:=Cos(Winkel)*Laenge;
    Richtung.Y:=Sin(Winkel)*Laenge;
    setlength(mainform.Figuren[Combobox1.ItemIndex].posx,length(mainform.Figuren[Combobox1.ItemIndex].posx)+1);
    setlength(mainform.Figuren[Combobox1.ItemIndex].posy,length(mainform.Figuren[Combobox1.ItemIndex].posy)+1);
    mainform.Figuren[Combobox1.ItemIndex].posx[length(mainform.Figuren[Combobox1.ItemIndex].posx)-1]:=Round(AnfangsPosition.x-Richtung.X);
    mainform.Figuren[Combobox1.ItemIndex].posy[length(mainform.Figuren[Combobox1.ItemIndex].posx)-1]:=Round(AnfangsPosition.Y-Richtung.Y);

    // Funktion rekursiv ausführen
    BlubbFigur(PointF(AnfangsPosition.x-Richtung.X, AnfangsPosition.Y-Richtung.Y), Laenge-(Laenge*2), Winkel+45, Durchgaenge);
  end;
end;

function Tfigureneditorform.PointF(X, Y:Extended):TPointF;
var
  Temp:TPointF;
begin
  Temp.X:=X;
  Temp.Y:=Y;
  Result:=Temp;
end;

procedure Tfigureneditorform.Button3Click(Sender: TObject);
begin
  if OpenDialog2.Execute then
  begin
    dxf_previewform:=Tdxf_previewform.Create(dxf_previewform);

    dxf_previewform.LoadDXFFile(OpenDialog2.Filename);
    dxf_previewform.showmodal;
    ListboxAktualisieren;
    RedrawAll;

    dxf_previewform.DXF_main.Free;
    dxf_previewform.DXF_main:=nil;
    dxf_previewform.Free;
    dxf_previewform:=nil;
  end;
end;

procedure Tfigureneditorform.PngBitBtn2Click(Sender: TObject);
var
  x,y:Word;
  Position:Integer;
begin
  if Listbox1.ItemIndex>0 then
  begin
    // Oberen Punkt speichern
    x:=mainform.Figuren[Combobox1.ItemIndex].posx[Listbox1.ItemIndex-1];
    y:=mainform.Figuren[Combobox1.ItemIndex].posy[Listbox1.ItemIndex-1];

    // aktuellen auf oberen Punkt
    mainform.Figuren[Combobox1.ItemIndex].posx[Listbox1.ItemIndex-1]:=mainform.Figuren[Combobox1.ItemIndex].posx[Listbox1.ItemIndex];
    mainform.Figuren[Combobox1.ItemIndex].posy[Listbox1.ItemIndex-1]:=mainform.Figuren[Combobox1.ItemIndex].posy[Listbox1.ItemIndex];

    // Temporären auf aktuellen
    mainform.Figuren[Combobox1.ItemIndex].posx[Listbox1.ItemIndex]:=x;
    mainform.Figuren[Combobox1.ItemIndex].posy[Listbox1.ItemIndex]:=y;

    // Position anpassen
    Position:=Listbox1.ItemIndex-1;

    RedrawAll;
    ListboxAktualisieren;

    Listbox1.ItemIndex:=Position;
  end;
end;

procedure Tfigureneditorform.PngBitBtn3Click(Sender: TObject);
var
  x,y:Word;
  Position:Integer;
begin
  if Listbox1.ItemIndex<Listbox1.items.count-1 then
  begin
    // unteren Punkt speichern
    x:=mainform.Figuren[Combobox1.ItemIndex].posx[Listbox1.ItemIndex+1];
    y:=mainform.Figuren[Combobox1.ItemIndex].posy[Listbox1.ItemIndex+1];

    // aktuellen auf unteren Punkt
    mainform.Figuren[Combobox1.ItemIndex].posx[Listbox1.ItemIndex+1]:=mainform.Figuren[Combobox1.ItemIndex].posx[Listbox1.ItemIndex];
    mainform.Figuren[Combobox1.ItemIndex].posy[Listbox1.ItemIndex+1]:=mainform.Figuren[Combobox1.ItemIndex].posy[Listbox1.ItemIndex];

    // Temporären auf aktuellen
    mainform.Figuren[Combobox1.ItemIndex].posx[Listbox1.ItemIndex]:=x;
    mainform.Figuren[Combobox1.ItemIndex].posy[Listbox1.ItemIndex]:=y;

    // Position anpassen
    Position:=Listbox1.ItemIndex+1;

    RedrawAll;
    ListboxAktualisieren;

    Listbox1.ItemIndex:=Position;
  end;
end;

procedure Tfigureneditorform.loadpictureClick(Sender: TObject);
begin
  if OpenDialog3.Execute then
  begin
    backgroundpicture:=OpenDialog3.FileName;
  end else
  begin
    backgroundpicture:='';
  end;
  RedrawAll;
end;

procedure Tfigureneditorform.CreateParams(var Params:TCreateParams);
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
