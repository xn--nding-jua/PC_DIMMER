unit lauflichtassistentfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, JvExControls, JvGradient, CheckLst,
  gnugettext, Buttons, PngBitBtn, ComCtrls, PngImageList, XPMan, JvgListBox,
  JvExCheckLst, JvCheckListBox, GR32;

type
  Tlauflichtrecord = record
    enabled : boolean;
    intensity : byte;
    channel : byte;
    delay : integer;
    fadetime : integer;
    r,g,b,a,w:byte;
    useonlyrgb:boolean;
  end;

  Tlauflichtassistentform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Notebook1: TNotebook;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    gobtn: TButton;
    cancelbtn: TButton;
    backbtn: TButton;
    Panel4: TPanel;
    upbtn: TPngBitBtn;
    downbtn: TPngBitBtn;
    Timer1: TTimer;
    Panel5: TPanel;
    Panel7: TPanel;
    GroupBox1: TGroupBox;
    PaintBox1: TPaintBox;
    offimage: TImage;
    onimage: TImage;
    Panel8: TPanel;
    Label5: TLabel;
    TrackBar2: TTrackBar;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Panel6: TPanel;
    Panel9: TPanel;
    Panel11: TPanel;
    Panel13: TPanel;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Shape1: TShape;
    Label8: TLabel;
    Label9: TLabel;
    channeltype: TComboBox;
    TrackBar1: TTrackBar;
    GroupBox2: TGroupBox;
    ComboBox1: TComboBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    inverted: TCheckBox;
    editbtn: TPngBitBtn;
    loadbtn: TPngBitBtn;
    savebtn: TPngBitBtn;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    hedit: TEdit;
    minedit: TEdit;
    sedit: TEdit;
    msedit: TEdit;
    Panel14: TPanel;
    Panel12: TPanel;
    Panel10: TPanel;
    previewtodevices: TCheckBox;
    newbtn: TPngBitBtn;
    Shape4: TShape;
    Shape2: TShape;
    Button1: TButton;
    procedure cancelbtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gobtnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure backbtnClick(Sender: TObject);
    procedure upbtnClick(Sender: TObject);
    procedure downbtnClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure invertedMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1Select(Sender: TObject);
    procedure channeltypeSelect(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editbtnClick(Sender: TObject);
    procedure heditChange(Sender: TObject);
    procedure savebtnClick(Sender: TObject);
    procedure loadbtnClick(Sender: TObject);
    procedure newbtnClick(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    GedrehteSchrift:HGDIOBJ;
    devicecount:integer;
    lauflichtcounter:integer;

    selecteddevice:integer;
    FileStream:TFileStream;

    procedure BuildArray;
  public
    { Public-Deklarationen }
    lauflichtarray:array of array of Tlauflichtrecord;
    lauflichtdevices:array of TGUID;
    lauflichtfadetime:Cardinal;
  end;

var
  lauflichtassistentform: Tlauflichtassistentform;

implementation

uses PCDIMMER, geraetesteuerungfrm, lauflichtassistentownpatternfrm;

{$R *.dfm}

function RGB2TColor(const R, G, B: Byte): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := R + G shl 8 + B shl 16;
end;

function RGBAW2TColor(const R, G, B, A, W: Byte): Integer;
var
  Rint, Gint, Bint:integer;
  Rbyte, Gbyte, Bbyte: byte;
begin
  // convert hexa-decimal values to RGB
  Rint:=R+W+A;
  Gint:=round(G+W+(A*0.75));
  Bint:=B+W;

  if Rint>255 then Rint:=255;
  if Gint>255 then Gint:=255;
  if Bint>255 then Bint:=255;
  
  Rbyte:=Rint;
  Gbyte:=Gint;
  Bbyte:=Bint;
  
  Result := Rbyte + Gbyte shl 8 + Bbyte shl 16;
end;

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

procedure Tlauflichtassistentform.cancelbtnClick(Sender: TObject);
begin
  timer1.Enabled:=false;
  modalresult:=mrCancel;
end;

procedure Tlauflichtassistentform.FormShow(Sender: TObject);
var
  i:integer;
begin
  gobtn.enabled:=false;
  listbox1.Clear;
  for i:=0 to length(mainform.devices)-1 do
  begin
//    listbox1.Items.Add(mainform.devices[i].Name);
    if mainform.devices[i].MaxChan>1 then
      listbox1.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+'..'+inttostr(mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1)+', '+mainform.devices[i].DeviceName+']')
    else
      listbox1.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+', '+mainform.devices[i].DeviceName+']');
  end;
  for i:=0 to length(mainform.DeviceGroups)-1 do
  begin
    listbox1.Items.Add(_('Gerätegruppe: ')+mainform.DeviceGroups[i].Name);
  end;

  channeltype.Items.Clear;
  for i:=0 to length(mainform.DeviceChannelNames)-1 do
  begin
    channeltype.Items.Add(mainform.DeviceChannelNames[i]);
  end;

  label34.Caption:=_('Schritt 1/3: Geräte auswählen');
  gobtn.Caption:=_('Weiter >');
  notebook1.PageIndex:=0;
end;

procedure Tlauflichtassistentform.gobtnClick(Sender: TObject);
var
  i,count,position:integer;
begin
  case notebook1.PageIndex of
    0: // Geräte
    begin
{
      if listbox1.SelCount<2 then
      begin
        showmessage(_('Bitte wählen Sie mindestens zwei Geräte aus...'));
        exit;
      end else
}
      begin
        notebook1.PageIndex:=1;
        label34.Caption:=_('Schritt 2/3: Reihenfolge und Kanal bestimmten');
        backbtn.Enabled:=true;

        devicecount:=listbox1.SelCount;
        lauflichtassistentownpatternform.devicecount:=devicecount;
        setlength(lauflichtdevices, devicecount);
        count:=0;
        listbox2.Items.Clear;
        for i:=0 to listbox1.Items.Count-1 do
        begin
          if i<length(mainform.devices) then
          begin
            if listbox1.Selected[i] then
            begin
              lauflichtdevices[count]:=mainform.devices[i].ID;
              count:=count+1;
//              listbox2.items.Add(mainform.devices[i].Name);
              if mainform.devices[i].MaxChan>1 then
                listbox2.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+'..'+inttostr(mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1)+', '+mainform.devices[i].DeviceName+']')
              else
                listbox2.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+', '+mainform.devices[i].DeviceName+']');
            end;
          end else
          begin
            if listbox1.Selected[i] then
            begin
              lauflichtdevices[count]:=mainform.devicegroups[i-length(mainform.devices)].ID;
              count:=count+1;
              listbox2.items.Add(_('Gerätegruppe: ')+mainform.devicegroups[i-length(mainform.devices)].Name);
            end;
          end;
        end;
      end;
    end;
    1: // Reihenfolge
    begin
      notebook1.PageIndex:=2;
      label34.Caption:=_('Schritt 3/3: Muster und Einstellungen');
      gobtn.Caption:=_('Fertig');

      label5.Visible:=true;
      trackbar2.Visible:=true;
      previewtodevices.Visible:=true;
      lauflichtcounter:=-1;

      setlength(lauflichtarray, 1);
      setlength(lauflichtarray[0], devicecount);
      for i:=0 to length(lauflichtarray[0])-1 do
      begin
        lauflichtarray[0][i].enabled:=true;
        lauflichtarray[0][i].intensity:=255;
        lauflichtarray[0][i].channel:=19;
        lauflichtarray[0][i].delay:=0;
        lauflichtarray[0][i].fadetime:=0;
        lauflichtarray[0][i].r:=0;
        lauflichtarray[0][i].g:=0;
        lauflichtarray[0][i].b:=0;
        lauflichtarray[0][i].a:=0;
        lauflichtarray[0][i].w:=0;
        position:=geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[i]);
        if position>-1 then
          lauflichtarray[0][i].useonlyrgb:=mainform.Devices[position].hasRGB;
      end;

      BuildArray;
      timer1.Enabled:=true;
    end;
    2: // Muster
    begin
      timer1.Enabled:=false;
      modalresult:=mrok;
      channeltype.Enabled:=false;
      trackbar1.Enabled:=false;
    end;
  end;
end;

procedure Tlauflichtassistentform.Timer1Timer(Sender: TObject);
var
  i,abstand:integer;
begin
  if devicecount<=0 then exit;

  // Lauflichvorschau darstellen
  lauflichtcounter:=lauflichtcounter+1;
  if lauflichtcounter>=length(lauflichtarray) then
    lauflichtcounter:=0;

  abstand:=round((paintbox1.Width-25)/devicecount);

  paintbox1.Canvas.Brush.Color:=groupbox1.Color;
  paintbox1.Canvas.Pen.Style:=psClear;
  paintbox1.Canvas.Rectangle(0,0,paintbox1.Width,paintbox1.Height);

  for i:=0 to devicecount-1 do
  begin
    if radiobutton1.Checked then
    begin
      if lauflichtcounter>=length(lauflichtarray) then
        lauflichtcounter:=0;

      // Normales Schaltlicht
      if lauflichtarray[lauflichtcounter][i].enabled then
        paintbox1.Canvas.Draw(round(abstand*i+abstand/2), 0, onimage.Picture.Graphic)
      else
        paintbox1.Canvas.Draw(round(abstand*i+abstand/2), 0, offimage.Picture.Graphic);

      if previewtodevices.Checked then
      begin
        if lauflichtarray[lauflichtcounter][i].enabled then
        begin
          geraetesteuerung.set_channel(lauflichtdevices[i], mainform.DeviceChannelNames[lauflichtarray[lauflichtcounter][i].channel], -1, lauflichtarray[lauflichtcounter][i].intensity, lauflichtfadetime);
        end else
        begin
          geraetesteuerung.set_channel(lauflichtdevices[i], mainform.DeviceChannelNames[lauflichtarray[lauflichtcounter][i].channel], -1, 0, lauflichtfadetime);
        end;
      end;
    end else if radiobutton2.Checked then
    begin
      if lauflichtcounter>=length(lauflichtarray) then
        lauflichtcounter:=0;
      if i<=length(lauflichtarray[lauflichtcounter])-1 then
      begin
        // Eigenes Muster
        if lauflichtarray[lauflichtcounter][i].enabled then
        begin
          if lauflichtarray[lauflichtcounter][i].useonlyrgb then
            paintbox1.Canvas.Brush.Color:=RGBAW2TColor(lauflichtarray[lauflichtcounter][i].r,lauflichtarray[lauflichtcounter][i].g,lauflichtarray[lauflichtcounter][i].b,lauflichtarray[lauflichtcounter][i].a,lauflichtarray[lauflichtcounter][i].w)
          else
            paintbox1.canvas.Brush.Color:=RGB2TColor(lauflichtarray[lauflichtcounter][i].intensity,lauflichtarray[lauflichtcounter][i].intensity, lauflichtarray[lauflichtcounter][i].intensity);
        end else
          paintbox1.canvas.Brush.Color:=clBlack;
        paintbox1.Canvas.Rectangle(round(abstand*i+abstand/2),0,round(abstand*i+abstand/2)+25,41);
        paintbox1.Canvas.Brush.Color:=groupbox1.Color;

        if previewtodevices.Checked then
        begin
          if lauflichtarray[lauflichtcounter][i].enabled then
          begin
            if lauflichtarray[lauflichtcounter][i].useonlyrgb then
            begin
              if lauflichtarray[lauflichtcounter][i].fadetime=-1 then
              begin
                geraetesteuerung.set_channel(lauflichtdevices[i], 'R', -1, lauflichtarray[lauflichtcounter][i].r, lauflichtfadetime, lauflichtarray[lauflichtcounter][i].delay);
                geraetesteuerung.set_channel(lauflichtdevices[i], 'G', -1, lauflichtarray[lauflichtcounter][i].g, lauflichtfadetime, lauflichtarray[lauflichtcounter][i].delay);
                geraetesteuerung.set_channel(lauflichtdevices[i], 'B', -1, lauflichtarray[lauflichtcounter][i].b, lauflichtfadetime, lauflichtarray[lauflichtcounter][i].delay);
                geraetesteuerung.set_channel(lauflichtdevices[i], 'A', -1, lauflichtarray[lauflichtcounter][i].a, lauflichtfadetime, lauflichtarray[lauflichtcounter][i].delay);
                geraetesteuerung.set_channel(lauflichtdevices[i], 'W', -1, lauflichtarray[lauflichtcounter][i].w, lauflichtfadetime, lauflichtarray[lauflichtcounter][i].delay);
              end else
              begin
                geraetesteuerung.set_channel(lauflichtdevices[i], 'R', -1, lauflichtarray[lauflichtcounter][i].r, lauflichtarray[lauflichtcounter][i].fadetime, lauflichtarray[lauflichtcounter][i].delay);
                geraetesteuerung.set_channel(lauflichtdevices[i], 'G', -1, lauflichtarray[lauflichtcounter][i].g, lauflichtarray[lauflichtcounter][i].fadetime, lauflichtarray[lauflichtcounter][i].delay);
                geraetesteuerung.set_channel(lauflichtdevices[i], 'B', -1, lauflichtarray[lauflichtcounter][i].b, lauflichtarray[lauflichtcounter][i].fadetime, lauflichtarray[lauflichtcounter][i].delay);
                geraetesteuerung.set_channel(lauflichtdevices[i], 'A', -1, lauflichtarray[lauflichtcounter][i].a, lauflichtarray[lauflichtcounter][i].fadetime, lauflichtarray[lauflichtcounter][i].delay);
                geraetesteuerung.set_channel(lauflichtdevices[i], 'W', -1, lauflichtarray[lauflichtcounter][i].w, lauflichtarray[lauflichtcounter][i].fadetime, lauflichtarray[lauflichtcounter][i].delay);
              end;
            end else
            begin
              if lauflichtarray[lauflichtcounter][i].fadetime=-1 then
                geraetesteuerung.set_channel(lauflichtdevices[i], mainform.DeviceChannelNames[lauflichtarray[lauflichtcounter][i].channel], -1, lauflichtarray[lauflichtcounter][i].intensity, lauflichtfadetime, lauflichtarray[lauflichtcounter][i].delay)
              else
                geraetesteuerung.set_channel(lauflichtdevices[i], mainform.DeviceChannelNames[lauflichtarray[lauflichtcounter][i].channel], -1, lauflichtarray[lauflichtcounter][i].intensity, lauflichtarray[lauflichtcounter][i].fadetime, lauflichtarray[lauflichtcounter][i].delay);
            end;
          end;
        end;
      end;
    end;

  	paintbox1.Canvas.Brush.Style:=bsClear;
    SelectObject(paintbox1.Canvas.Handle, GedrehteSchrift);
    if geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtdevices[i])=-1 then
      paintbox1.Canvas.TextOut(round(abstand*i+abstand/2)+18, 45, mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(lauflichtdevices[i])].Name) // Beschreibung
    else
      paintbox1.Canvas.TextOut(round(abstand*i+abstand/2)+18, 45, mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtdevices[i])].Name); // Beschreibung
  end;

  if lauflichtassistentownpatternform.Showing then
    lauflichtassistentownpatternform.DrawPreview;
end;

procedure Tlauflichtassistentform.TrackBar2Change(Sender: TObject);
begin
  timer1.Interval:=round((100-trackbar2.Position)/100*2000);
  lauflichtassistentownpatternform.trackbar2.position:=trackbar2.Position;
end;

procedure Tlauflichtassistentform.ListBox2Click(Sender: TObject);
begin
  upbtn.Enabled:=listbox2.ItemIndex>0;
  downbtn.Enabled:=listbox2.ItemIndex<listbox2.Items.Count-1;
end;

procedure Tlauflichtassistentform.backbtnClick(Sender: TObject);
begin
  notebook1.PageIndex:=notebook1.PageIndex-1;

  case notebook1.PageIndex of
    0: label34.Caption:=_('Schritt 1/3: Geräte auswählen');
    1: label34.Caption:=_('Schritt 2/3: Reihenfolge und Kanal bestimmten');
  end;

  backbtn.enabled:=notebook1.PageIndex>0;
  label5.Visible:=false;
  trackbar2.Visible:=false;
  previewtodevices.Visible:=false;
  gobtn.Caption:=_('Weiter >');
end;

procedure Tlauflichtassistentform.upbtnClick(Sender: TObject);
var
  temp:TGUID;
  name:string;
begin
  temp:=lauflichtdevices[listbox2.ItemIndex-1];
  name:=listbox2.Items[listbox2.ItemIndex-1];

  lauflichtdevices[listbox2.ItemIndex-1]:=lauflichtdevices[listbox2.ItemIndex];
  listbox2.Items[listbox2.ItemIndex-1]:=listbox2.Items[listbox2.ItemIndex];

  lauflichtdevices[listbox2.ItemIndex]:=temp;
  listbox2.Items[listbox2.ItemIndex]:=name;

  listbox2.ItemIndex:=listbox2.ItemIndex-1;

  upbtn.Enabled:=listbox2.ItemIndex>0;
  downbtn.Enabled:=listbox2.ItemIndex<listbox2.Items.Count-1;
end;

procedure Tlauflichtassistentform.downbtnClick(Sender: TObject);
var
  temp:TGUID;
  name:string;
begin
  temp:=lauflichtdevices[listbox2.ItemIndex+1];
  name:=listbox2.Items[listbox2.ItemIndex+1];

  lauflichtdevices[listbox2.ItemIndex+1]:=lauflichtdevices[listbox2.ItemIndex];
  listbox2.Items[listbox2.ItemIndex+1]:=listbox2.Items[listbox2.ItemIndex];

  lauflichtdevices[listbox2.ItemIndex]:=temp;
  listbox2.Items[listbox2.ItemIndex]:=name;

  listbox2.ItemIndex:=listbox2.ItemIndex+1;

  upbtn.Enabled:=listbox2.ItemIndex>0;
  downbtn.Enabled:=listbox2.ItemIndex<listbox2.Items.Count-1;
end;

procedure Tlauflichtassistentform.BuildArray;
var
  i,k:integer;
  intensity:array of byte;
  channel:array of byte;
begin
  if devicecount<=0 then exit;

  setlength(intensity, devicecount);
  setlength(channel, devicecount);

  for i:=0 to length(lauflichtarray[0])-1 do
  begin
    intensity[i]:=255;//lauflichtarray[0][i].intensity;
    channel[i]:=19//;lauflichtarray[0][i].channel;
  end;

  // Array säubern
  for i:=0 to length(lauflichtarray)-1 do
  begin
    for k:=0 to length(lauflichtarray[i])-1 do
    begin
      lauflichtarray[i][k].enabled:=false;
    end;
  end;

  case combobox1.ItemIndex of
    0: // Fortschreitend
    begin
      setlength(lauflichtarray, devicecount);

      for k:=0 to devicecount-1 do
      begin
        setlength(lauflichtarray[k], devicecount);
        for i:=0 to length(lauflichtarray[k])-1 do
        begin
          if not inverted.Checked then
            lauflichtarray[k][i].enabled:=(i=k)
          else
            lauflichtarray[k][i].enabled:=not (i=k);
        end;
      end;
    end;
    1: // Fortschreitend rückwärts
    begin
      setlength(lauflichtarray, devicecount);

      for k:=0 to devicecount-1 do
      begin
        setlength(lauflichtarray[k], devicecount);
        for i:=0 to length(lauflichtarray[k])-1 do
        begin
          if not inverted.Checked then
            lauflichtarray[k][i].enabled:=((devicecount-1-i)=k)
          else
            lauflichtarray[k][i].enabled:=not ((devicecount-1-i)=k);
        end;
      end;
    end;
    2: // Fortschreitend doppelt (BUGGY)
    begin
      setlength(lauflichtarray, devicecount);

      for k:=0 to devicecount-1 do
      begin
        setlength(lauflichtarray[k], devicecount);
        for i:=0 to length(lauflichtarray[k])-1 do
        begin
          if not inverted.Checked then
          begin
            lauflichtarray[k][i].enabled:=(i=k);

            if lauflichtarray[k][i].enabled=true then
            begin
              if (i=0) then
                lauflichtarray[k][length(lauflichtarray[k])-1].enabled:=true
              else
                lauflichtarray[k][i-1].enabled:=true;
            end;
          end else
          begin
            lauflichtarray[k][i].enabled:=(i<>k);

            if lauflichtarray[k][i].enabled=false then
            begin
              if (i=0) then
                lauflichtarray[k][length(lauflichtarray[k])-1].enabled:=false
              else
                lauflichtarray[k][i-1].enabled:=false;
            end;
          end;
        end;
      end;
    end;
    3: // Aufbauend/Abbauend L>R
    begin
      setlength(lauflichtarray, 2*devicecount);

      for k:=0 to 2*devicecount-1 do
      begin
        setlength(lauflichtarray[k], devicecount);
        if k<length(lauflichtarray[k]) then
        begin
          // Aufbauend
          for i:=0 to k do
            lauflichtarray[k][i].enabled:=true;
        end else
        begin
          // Abbauend
          for i:=devicecount-1 downto k-devicecount+1 do
            lauflichtarray[k][i].enabled:=true;
        end;
      end;
    end;
    4: // Aufbauend/Abbauend L<>R
    begin
      setlength(lauflichtarray, 2*devicecount);

      for k:=0 to 2*devicecount-1 do
      begin
        setlength(lauflichtarray[k], devicecount);
        if k<length(lauflichtarray[k]) then
        begin
          // Aufbauend
          for i:=0 to k do
            lauflichtarray[k][i].enabled:=true;
        end else
        begin
          // Abbauend
          for i:=0 to devicecount-1 do
            lauflichtarray[k][i].enabled:=false;
          for i:=0 to (devicecount-1)-(k-devicecount+1) do
            lauflichtarray[k][i].enabled:=true;
        end;
      end;
    end;
    5: // Pendeln 1 L<>R
    begin
      setlength(lauflichtarray, 2*devicecount);

      for k:=0 to 2*devicecount-1 do
      begin
        setlength(lauflichtarray[k], devicecount);
        if k<length(lauflichtarray[k]) then
        begin
          // Aufbauend
          for i:=0 to k do
            lauflichtarray[k][i].enabled:=true;
        end else
        begin
          // Abbauend
          for i:=0 to devicecount-1 do
            lauflichtarray[k][i].enabled:=true;
          for i:=0 to (devicecount-1)-(k-devicecount+1) do
            lauflichtarray[k][i].enabled:=false;
        end;
      end;
    end;
    6: // Pendeln 2 L<>R
    begin
      setlength(lauflichtarray, 2*devicecount-2);

//      if lauflichtcounter=devicecount then
//        lauflichtcounter:=lauflichtcounter+1;

      for k:=0 to 2*devicecount-3 do
      begin
        setlength(lauflichtarray[k], devicecount);
        if k<length(lauflichtarray[k]) then
        begin
          // Hochzählen
          for i:=0 to length(lauflichtarray[k])-1 do
          begin
            if not inverted.Checked then
              lauflichtarray[k][i].enabled:=(i=k)
            else
              lauflichtarray[k][i].enabled:=not (i=k);
          end;
        end else
        begin
          // Runterzählen
          for i:=0 to length(lauflichtarray[k])-1 do
          begin
            if not inverted.Checked then
              lauflichtarray[k][i].enabled:=(i=devicecount-(k-devicecount+2))
            else
              lauflichtarray[k][i].enabled:=not (i=devicecount-(k-devicecount+2));
          end;
        end;
      end;
    end;
    7: // Rechts/Links-Blinkend
    begin
      setlength(lauflichtarray, 2);

      for k:=0 to 1 do
      begin
        setlength(lauflichtarray[k], devicecount);
        if k=0 then
        begin
          for i:=0 to round(length(lauflichtarray[k])/2) do
          begin
            lauflichtarray[k][i].enabled:=true;
          end;
          for i:=round(length(lauflichtarray[k])/2) to length(lauflichtarray[k])-1 do
          begin
            lauflichtarray[k][i].enabled:=false;
          end;
        end else
        begin
          for i:=0 to round(length(lauflichtarray[k])/2) do
          begin
            lauflichtarray[k][i].enabled:=false;
          end;
          for i:=round(length(lauflichtarray[k])/2) to length(lauflichtarray[k])-1 do
          begin
            lauflichtarray[k][i].enabled:=true;
          end;
        end;
      end;
    end;
    8: // RechtsA/LinksA/RechtsM/LinksM-Blinkend
    begin
      setlength(lauflichtarray, 8);

      for k:=0 to 7 do
      begin
        setlength(lauflichtarray[k], devicecount);
        case k of
          0,2:
          begin
            // Rechtsaußen
            for i:=0 to round(length(lauflichtarray[k])/4) do
            begin
              lauflichtarray[k][i].enabled:=true;
            end;
            for i:=round(length(lauflichtarray[k])/4) to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=false;
            end;
          end;
          1,3:
          begin
            // Linksaußen
            for i:=round(3*length(lauflichtarray[k])/4-1) to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=true;
            end;
            for i:=0 to round(3*length(lauflichtarray[k])/4-1) do
            begin
              lauflichtarray[k][i].enabled:=false;
            end;
          end;
          4,6:
          begin
            // Linksmitte
            for i:=0 to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=false;
            end;
            for i:=round(length(lauflichtarray[k])/4) to round(2*length(lauflichtarray[k])/4-1) do
            begin
              lauflichtarray[k][i].enabled:=true;
            end;
          end;
          5,7:
          begin
            // Rechtsmitte
            for i:=0 to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=false;
            end;
            for i:=round(2*length(lauflichtarray[k])/4) to round(3*length(lauflichtarray[k])/4-1) do
            begin
              lauflichtarray[k][i].enabled:=true;
            end;
          end;
        end;
      end;
    end;
    9: // Gerade/Ungerade
    begin
      setlength(lauflichtarray, 4);

      for k:=0 to 3 do
      begin
        setlength(lauflichtarray[k], devicecount);
        case k of
          0:
          begin
            for i:=0 to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=(i mod 2)>0;
            end;
          end;
          1,3:
          begin
            for i:=0 to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=false;
            end;
          end;
          2:
          begin
            for i:=0 to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=(i mod 2)=0;
            end;
          end;
        end;
      end;
    end;
    10: // Äußere, Innere, Gerade, Ungerade
    begin
      setlength(lauflichtarray, 16);

      for k:=0 to 15 do
      begin
        setlength(lauflichtarray[k], devicecount);
        case k of
          0,2: // Außen
          begin
            for i:=0 to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=false;
            end;
            for i:=0 to round(length(lauflichtarray[k])/4-1) do
            begin
              lauflichtarray[k][i].enabled:=true;
            end;
            for i:=round(3*length(lauflichtarray[k])/4) to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=true;
            end;
          end;
          1,3,5,7,9,11,13,15:
          begin
            for i:=0 to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=false;
            end;
          end;
          4,6: // Innen
          begin
            for i:=0 to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=false;
            end;
            for i:=round(length(lauflichtarray[k])/4) to round(3*length(lauflichtarray[k])/4-1) do
            begin
              lauflichtarray[k][i].enabled:=true;
            end;
          end;
          8,10:
          begin
            for i:=0 to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=(i mod 2)>0;
            end;
          end;
          12,14:
          begin
            for i:=0 to length(lauflichtarray[k])-1 do
            begin
              lauflichtarray[k][i].enabled:=(i mod 2)=0;
            end;
          end;
        end;
      end;
    end;
  end;

  for i:=0 to length(lauflichtarray)-1 do
  begin
    for k:=0 to length(lauflichtarray[i])-1 do
    begin
      lauflichtarray[i][k].intensity:=intensity[k];
      lauflichtarray[i][k].channel:=channel[k];
      lauflichtarray[i][k].fadetime:=-1;
      lauflichtarray[i][k].delay:=0;
      lauflichtarray[i][k].r:=0;
      lauflichtarray[i][k].g:=0;
      lauflichtarray[i][k].b:=0;
      lauflichtarray[i][k].a:=0;
      lauflichtarray[i][k].w:=0;
      lauflichtarray[i][k].useonlyrgb:=false;
    end;
  end;

  lauflichtassistentownpatternform.devicecount:=devicecount;
  lauflichtassistentownpatternform.rowcount.Value:=length(lauflichtarray);
end;

procedure Tlauflichtassistentform.ComboBox1Change(Sender: TObject);
begin
  timer1.Enabled:=false;
  BuildArray;
  timer1.Enabled:=true;
end;

procedure Tlauflichtassistentform.invertedMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ComboBox1Change(nil);
end;

procedure Tlauflichtassistentform.RadioButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ComboBox1Change(nil);
end;

procedure Tlauflichtassistentform.RadioButton2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ComboBox1Change(nil);
end;

procedure Tlauflichtassistentform.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  abstand, i:integer;
begin
  abstand:=round((paintbox1.Width-25)/devicecount);

  for i:=0 to devicecount-1 do
  begin
    if (x>round(abstand*i+abstand/2)) and (x<round(abstand*i+abstand/2+25)) then
    begin
      selecteddevice:=i;

      channeltype.Enabled:=true;
      trackbar1.Enabled:=true;

      channeltype.ItemIndex:=lauflichtarray[0][i].channel;
      trackbar1.position:=lauflichtarray[0][i].intensity;

      if geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtdevices[i])=-1 then
      begin
        label8.Caption:=mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(lauflichtdevices[i])].Name;
        label9.Caption:=_('n/a');
      end else
      begin
        label8.Caption:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtdevices[i])].Name;
        if mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtdevices[i])].MaxChan>1 then
          label9.Caption:=inttostr(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtdevices[i])].Startaddress)+'..'+inttostr(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtdevices[i])].Startaddress+mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtdevices[i])].MaxChan-1)
        else
          label9.Caption:=inttostr(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtdevices[i])].Startaddress);
      end;
    end;
  end;
end;

procedure Tlauflichtassistentform.ComboBox1Select(Sender: TObject);
begin
  timer1.Enabled:=false;
  BuildArray;
  timer1.Enabled:=true;
end;

procedure Tlauflichtassistentform.channeltypeSelect(Sender: TObject);
var
  i:integer;
begin
  if (selecteddevice>-1) and (selecteddevice<length(lauflichtarray)) then
  begin
    for i:=0 to length(lauflichtarray)-1 do
      lauflichtarray[i][selecteddevice].channel:=channeltype.ItemIndex;
  end;
end;

procedure Tlauflichtassistentform.TrackBar1Change(Sender: TObject);
var
  i:integer;
begin
  if (selecteddevice>-1) and (selecteddevice<length(lauflichtarray)) then
  begin
    for i:=0 to length(lauflichtarray)-1 do
      lauflichtarray[i][selecteddevice].intensity:=trackbar1.Position;
  end;
end;

procedure Tlauflichtassistentform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  GedrehteSchrift:=CreateFont(10, 4, 2700, 0, fw_normal, 0, 0, 0, 1, 0, $10, 2, 4, PChar('Arial'));
end;

procedure Tlauflichtassistentform.editbtnClick(Sender: TObject);
var
  i,j,position:integer;
begin
  Radiobutton2.Checked:=true;
//  ComboBox1Change(nil);

  lauflichtassistentownpatternform.devicecount:=devicecount;

  if length(lauflichtarray)<2 then
  begin
    setlength(lauflichtarray,2);
    setlength(lauflichtarray[0],devicecount);
    setlength(lauflichtarray[1],devicecount);

    for i:=0 to devicecount-1 do
    begin
      lauflichtassistentform.lauflichtarray[0][i].enabled:=true;
      lauflichtassistentform.lauflichtarray[0][i].delay:=-1;
      lauflichtassistentform.lauflichtarray[0][i].fadetime:=-1;
      lauflichtassistentform.lauflichtarray[0][i].intensity:=0;
      lauflichtassistentform.lauflichtarray[0][i].channel:=19;
      lauflichtassistentform.lauflichtarray[0][i].r:=0;
      lauflichtassistentform.lauflichtarray[0][i].g:=0;
      lauflichtassistentform.lauflichtarray[0][i].b:=0;
      lauflichtassistentform.lauflichtarray[0][i].a:=0;
      lauflichtassistentform.lauflichtarray[0][i].w:=0;

      lauflichtassistentform.lauflichtarray[1][i].enabled:=true;
      lauflichtassistentform.lauflichtarray[1][i].delay:=-1;
      lauflichtassistentform.lauflichtarray[1][i].fadetime:=-1;
      lauflichtassistentform.lauflichtarray[1][i].intensity:=0;
      lauflichtassistentform.lauflichtarray[1][i].channel:=19;
      lauflichtassistentform.lauflichtarray[1][i].r:=0;
      lauflichtassistentform.lauflichtarray[1][i].g:=0;
      lauflichtassistentform.lauflichtarray[1][i].b:=0;
      lauflichtassistentform.lauflichtarray[1][i].a:=0;
      lauflichtassistentform.lauflichtarray[1][i].w:=0;

      position:=geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[i]);
      if position>-1 then
      begin
        lauflichtassistentform.lauflichtarray[0][i].useonlyrgb:=mainform.Devices[position].hasRGB;
        lauflichtassistentform.lauflichtarray[1][i].useonlyrgb:=mainform.Devices[position].hasRGB;
      end;
    end;
  end;

  for i:=0 to length(lauflichtarray)-1 do
  begin
    for j:=0 to devicecount-1 do
    begin
      if not lauflichtarray[i][j].enabled then
      begin
        lauflichtarray[i][j].intensity:=0;
        lauflichtarray[i][j].enabled:=true;
      end;
    end;
  end;

  lauflichtassistentownpatternform.rowcount.Value:=length(lauflichtarray);
  lauflichtassistentownpatternform.showmodal;
end;

procedure Tlauflichtassistentform.heditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  lauflichtfadetime:=strtoint(hedit.Text)*3600000+strtoint(minedit.Text)*60000+strtoint(sedit.Text)*1000+strtoint(msedit.Text);
end;

procedure Tlauflichtassistentform.savebtnClick(Sender: TObject);
var
  i,j, counter:integer;
begin
  if savedialog1.Execute then
  begin
		FileStream:=TFileStream.Create(savedialog1.FileName,fmCreate);

    // Projektversion
    counter:=mainform.currentprojectversion;
    Filestream.WriteBuffer(counter, sizeof(counter));

    counter:=length(lauflichtarray);
    FileStream.WriteBuffer(counter,sizeof(counter));
    for i:=0 to length(lauflichtarray)-1 do
    begin
      counter:=length(lauflichtarray[i]);
      FileStream.WriteBuffer(counter,sizeof(counter));
      for j:=0 to length(lauflichtarray[i])-1 do
      begin
        FileStream.WriteBuffer(lauflichtarray[i][j].enabled,sizeof(lauflichtarray[i][j].enabled));
        FileStream.WriteBuffer(lauflichtarray[i][j].intensity,sizeof(lauflichtarray[i][j].intensity));
        FileStream.WriteBuffer(lauflichtarray[i][j].channel,sizeof(lauflichtarray[i][j].channel));
        FileStream.WriteBuffer(lauflichtarray[i][j].delay,sizeof(lauflichtarray[i][j].delay));
        FileStream.WriteBuffer(lauflichtarray[i][j].fadetime,sizeof(lauflichtarray[i][j].fadetime));
        FileStream.WriteBuffer(lauflichtarray[i][j].r,sizeof(lauflichtarray[i][j].r));
        FileStream.WriteBuffer(lauflichtarray[i][j].g,sizeof(lauflichtarray[i][j].g));
        FileStream.WriteBuffer(lauflichtarray[i][j].b,sizeof(lauflichtarray[i][j].b));
        FileStream.WriteBuffer(lauflichtarray[i][j].a,sizeof(lauflichtarray[i][j].a));
        FileStream.WriteBuffer(lauflichtarray[i][j].w,sizeof(lauflichtarray[i][j].w));
        FileStream.WriteBuffer(lauflichtarray[i][j].useonlyrgb,sizeof(lauflichtarray[i][j].useonlyrgb));
      end;
    end;

    FileStream.Free;
  end;
end;

procedure Tlauflichtassistentform.loadbtnClick(Sender: TObject);
var
  i, j, maxsteps, maxdevices, oldlength, FileVersion:integer;
  lauflichtarray_temp:array of array of Tlauflichtrecord;
begin
  if opendialog1.Execute then
  begin
    Radiobutton2.Checked:=true;
    ComboBox1Change(nil);
    Timer1.Enabled:=false;

		FileStream:=TFileStream.Create(opendialog1.FileName,fmOpenRead);

    // Projektversion
    Filestream.ReadBuffer(FileVersion, sizeof(FileVersion));
    if FileVersion>=442 then
    begin
      FileStream.ReadBuffer(maxsteps,sizeof(maxsteps))
    end else
    begin
      // ist noch eine alte Version: Position von FileVersion ist hier noch an gleicher Stelle, wie maxsteps
      maxsteps:=FileVersion;
    end;

    setlength(lauflichtarray_temp,maxsteps);
    for i:=0 to length(lauflichtarray_temp)-1 do
    begin
      FileStream.ReadBuffer(maxdevices,sizeof(maxdevices));
      setlength(lauflichtarray_temp[i],maxdevices);
      for j:=0 to length(lauflichtarray_temp[i])-1 do
      begin
        FileStream.ReadBuffer(lauflichtarray_temp[i][j].enabled,sizeof(lauflichtarray_temp[i][j].enabled));
        FileStream.ReadBuffer(lauflichtarray_temp[i][j].intensity,sizeof(lauflichtarray_temp[i][j].intensity));
        FileStream.ReadBuffer(lauflichtarray_temp[i][j].channel,sizeof(lauflichtarray_temp[i][j].channel));
        FileStream.ReadBuffer(lauflichtarray_temp[i][j].delay,sizeof(lauflichtarray_temp[i][j].delay));
        FileStream.ReadBuffer(lauflichtarray_temp[i][j].fadetime,sizeof(lauflichtarray_temp[i][j].fadetime));
        FileStream.ReadBuffer(lauflichtarray_temp[i][j].r,sizeof(lauflichtarray_temp[i][j].r));
        FileStream.ReadBuffer(lauflichtarray_temp[i][j].g,sizeof(lauflichtarray_temp[i][j].g));
        FileStream.ReadBuffer(lauflichtarray_temp[i][j].b,sizeof(lauflichtarray_temp[i][j].b));
        if FileVersion>=472 then
        begin
          FileStream.ReadBuffer(lauflichtarray_temp[i][j].a,sizeof(lauflichtarray_temp[i][j].a));
          FileStream.ReadBuffer(lauflichtarray_temp[i][j].w,sizeof(lauflichtarray_temp[i][j].w));
        end else
        begin
          lauflichtarray_temp[i][j].a:=0;
          lauflichtarray_temp[i][j].w:=0;
        end;
        FileStream.ReadBuffer(lauflichtarray_temp[i][j].useonlyrgb,sizeof(lauflichtarray_temp[i][j].useonlyrgb));
      end;
    end;
    FileStream.Free;

    
    if length(lauflichtarray_temp)>length(lauflichtarray) then
    begin
      oldlength:=length(lauflichtarray);
      setlength(lauflichtarray, length(lauflichtarray_temp));
      for i:=oldlength to length(lauflichtarray)-1 do
        setlength(lauflichtarray[i], devicecount);
    end;

    lauflichtassistentownpatternform.rowcount.Value:=length(lauflichtarray);

    for i:=0 to length(lauflichtarray)-1 do
    begin
      if i<length(lauflichtarray_temp) then
      for j:=0 to length(lauflichtarray[i])-1 do
      begin
        if j<length(lauflichtarray_temp[i]) then
        begin
          lauflichtarray[i][j].enabled:=lauflichtarray_temp[i][j].enabled;
          lauflichtarray[i][j].intensity:=lauflichtarray_temp[i][j].intensity;
          lauflichtarray[i][j].channel:=lauflichtarray_temp[i][j].channel;
          lauflichtarray[i][j].delay:=lauflichtarray_temp[i][j].delay;
          lauflichtarray[i][j].fadetime:=lauflichtarray_temp[i][j].fadetime;
          lauflichtarray[i][j].r:=lauflichtarray_temp[i][j].r;
          lauflichtarray[i][j].g:=lauflichtarray_temp[i][j].g;
          lauflichtarray[i][j].b:=lauflichtarray_temp[i][j].b;
          lauflichtarray[i][j].a:=lauflichtarray_temp[i][j].a;
          lauflichtarray[i][j].w:=lauflichtarray_temp[i][j].w;
          lauflichtarray[i][j].useonlyrgb:=lauflichtarray_temp[i][j].useonlyrgb;
        end;
      end;
    end;
  end;

  lauflichtcounter:=0;
  Timer1.Enabled:=true;
end;

procedure Tlauflichtassistentform.newbtnClick(Sender: TObject);
var
  i,j:integer;
  position:integer;
begin
  Timer1.Enabled:=false;
  radiobutton2.Checked:=true;;
  ComboBox1Change(nil);

  setlength(lauflichtarray,2);
  setlength(lauflichtarray[0],devicecount);
  setlength(lauflichtarray[1],devicecount);
  lauflichtassistentownpatternform.devicecount:=devicecount;
  lauflichtassistentownpatternform.rowcount.Value:=length(lauflichtarray);

  for j:=0 to length(lauflichtarray)-1 do
  begin
    for i:=0 to devicecount-1 do
    begin
      lauflichtarray[j][i].enabled:=true;
      lauflichtarray[j][i].delay:=-1;
      lauflichtarray[j][i].fadetime:=-1;
      lauflichtarray[j][i].intensity:=0;
      lauflichtarray[j][i].channel:=19;
      lauflichtarray[j][i].r:=0;
      lauflichtarray[j][i].g:=0;
      lauflichtarray[j][i].b:=0;
      lauflichtarray[j][i].a:=0;
      lauflichtarray[j][i].w:=0;

      position:=geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtdevices[i]);
      if position>-1 then
      begin
        // Gerät
        lauflichtarray[j][i].useonlyrgb:=mainform.Devices[position].hasRGB;
      end;
    end;
  end;
  Timer1.Enabled:=true;
end;

procedure Tlauflichtassistentform.CreateParams(var Params:TCreateParams);
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

procedure Tlauflichtassistentform.ListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  gobtn.enabled:=listbox1.SelCount>0;
end;

procedure Tlauflichtassistentform.ListBox1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  gobtn.enabled:=listbox1.SelCount>0;
end;

procedure Tlauflichtassistentform.Button1Click(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(lauflichtarray)-1 do
    for j:=0 to length(lauflichtarray[i])-1 do
    begin
      lauflichtarray[i][j].channel:=channeltype.ItemIndex;
      lauflichtarray[i][j].intensity:=trackbar1.Position
    end;
end;

end.
