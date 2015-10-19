unit ddfwindowfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, JvExExtCtrls, JvExtComponent,
  JvPanel, JvOfficeColorPanel, HSLColorPicker, JvComponentBase,
  JvAppStorage, JvAppXMLStorage, JvInterpreter, JvExStdCtrls, JvCombobox,
  JvColorCombo, mbXPImageComboBox, ImgList, PngImageList, PngImage,
  gnugettext, TiledImage, Math, SVATimer;

const
{$I GlobaleKonstanten.inc} // maximale Kanalzahl für PC_DIMMER !Vorsicht! Bei Ändern des Wertes müssen einzelne Plugins und Forms ebenfalls verändert werden, da dort auch chan gesetzt wird! Auch die GUI muss angepasst werden

type
  Teditproperties = record
    name:string;
    channel:Integer;
    actionname:string;
  end;

  Tcheckboxproperties = record
    name:string;
    channel:Integer;
    actionname:string;
  end;

  Tcomboboxproperties = record
    name:string;
    channel:Integer;
    actionname:string;
    itemvalue:array of integer;
  end;

  Tsliderproperties = record
    name:string;
    channel:Integer;
    actionname:string;
  end;

  Tbuttonproperties = record
    name:string;
    channel:Integer;
    onvalue:Integer;
    offvalue:Integer;
    actionname:string;
  end;

  Tradiobuttonproperties = record
    name:string;
    channel:Integer;
    actionname:string;
    itemvalue:array of integer;
  end;

  TDDFWindow = class(TForm)
    deviceimage: TImage;
    devicename: TLabel;
    deviceadress: TLabel;
    fadenkreuz: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    PositionXY: TShape;
    ColorPicker: TJvOfficeColorPanel;
    panmirror: TCheckBox;
    tiltmirror: TCheckBox;
    ColorPicker2: THSLColorPicker;
    XML: TJvAppXMLFileStorage;
    ScriptInterpreter: TJvInterpreterProgram;
    ColorBox: TJvColorComboBox;
    DIPON: TImage;
    DIPOFF: TImage;
    dipswitchpanel: TPanel;
    Image1: TImage;
    DIP1: TImage;
    DIP2: TImage;
    DIP3: TImage;
    DIP4: TImage;
    DIP5: TImage;
    DIP6: TImage;
    DIP7: TImage;
    DIP8: TImage;
    DIP9: TImage;
    DIP10: TImage;
    standardpicture: TImage;
    TiledImage1: TTiledImage;
    TiledImage2: TTiledImage;
    usemhcontrol: TCheckBox;
    HorTrack: TTrackBar;
    VertTrack: TTrackBar;
    colorbox2: TJvColorComboBox;
    RefreshTimer: TSVATimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure fadenkreuzMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure fadenkreuzMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PositionXYMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ColorPickerColorChange(Sender: TObject);
    procedure ColorPicker2Change(Sender: TObject);
    procedure ScriptInterpreterGetValue(Sender: TObject;
      Identifier: String; var Value: Variant; Args: TJvInterpreterArgs;
      var Done: Boolean);
    procedure ColorPickerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ColorBoxChange(Sender: TObject);
    procedure PositionXYMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure fadenkreuzMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PositionXYMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RefreshTimerTimer(Sender: TObject);
    procedure usemhcontrolMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure HorTrackChange(Sender: TObject);
    procedure VertTrackChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure colorbox2Change(Sender: TObject);
  private
    { Private-Deklarationen }
    loadDDFWindow:boolean;
    Red,Green,Blue:byte;
    ddffenstervorhanden:boolean;
    argumente:TJvInterpreterArgs;
    dipstate:array[1..10] of boolean;
    oldaddress:word;
    rgn:HRGN;
    positionindevicearray:integer;
  public
    { Public-Deklarationen }
    // Arrays für DDF Darstellung
    dontrefreshDDFWindow:boolean;
    refreshchannel:array[1..chan] of boolean;
    dontrefreshXY:boolean;
    Edits: array of TEdit;
    CheckBoxs: array of TCheckBox;
    ComboBoxs: array of TmbXPImageCombobox;//TComboBox;
    ComboBoxsImageList: array of TImageList;
    Labels: array of TLabel;
    Sliders: array of TScrollbar;
    Progressbars: array of TProgressbar;
    Shapes: array of TShape;
    Buttons: array of TButton;
    Radiobuttons: array of TRadioGroup;
    // DDF-Control-Eigenschaften
    checkboxproperties:array of Tcheckboxproperties;
    comboboxproperties:array of Tcomboboxproperties;
    sliderproperties:array of Tsliderproperties;
    buttonproperties:array of Tbuttonproperties;
    radiobuttonproperties:array of Tradiobuttonproperties;
    editproperties:array of Teditproperties;
    funktionen:string;
    Colorpickerchannel:array[0..2] of integer;
    DeviceID:TGUID;
    thisddfwindowDeviceID:TGUID;
    readyfordelete:boolean;
    Bmp : TImage;
    procedure startscript(Sender: TObject);
    procedure sliderscroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure loadDDF(ID:TGUID);
    procedure deleteDDFwindow;
    procedure RefreshDDFWindow(channel:integer);
  end;

var
//  DDFWindow: TDDFWindow;
  DDFWindowDeviceScene: TDDFWindow;
  DDFWindows:array of TDDFWindow;

implementation

uses PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

function BitSet(Value: Byte; BitCnt: Byte): Boolean;
begin
  result := ((Value AND bitcnt) = bitcnt);
end;

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

procedure TDDFWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ScriptInterpreter.CallFunction('FormClose',nil,[]);
  deleteDDFwindow;
  readyfordelete:=true;
end;

procedure TDDFWindow.startscript(Sender: TObject);
var
  i:integer;
begin
//  mainform.ScriptInterpreter.Pas.Text:=funktionen;
//  mainform.ScriptInterpreter.Compile;
  for i:=0 to length(Edits)-1 do
  begin
    if Sender=Edits[i] then
    begin
      if editproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(editproperties[i].actionname,nil,[]);
    end;
  end;

  for i:=0 to length(CheckBoxs)-1 do
  begin
    if Sender=CheckBoxs[i] then
    begin
      if checkboxproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(checkboxproperties[i].actionname,nil,[]);
    end;
  end;

  for i:=0 to length(ComboBoxs)-1 do
  begin
    if Sender=ComboBoxs[i] then
    begin
      if comboboxproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(comboboxproperties[i].actionname,nil,[]);
    end;
  end;

  for i:=0 to length(Sliders)-1 do
  begin
    if Sender=Sliders[i] then
    begin
      if sliderproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(sliderproperties[i].actionname,nil,[]);
    end;
  end;

  for i:=0 to length(Buttons)-1 do
  begin
    if Sender=Buttons[i] then
    begin
      if buttonproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(buttonproperties[i].actionname,nil,[]);
    end;
  end;

  for i:=0 to length(Radiobuttons)-1 do
  begin
    if Sender=Radiobuttons[i] then
    begin
      if radiobuttonproperties[i].actionname<>'' then
        ScriptInterpreter.CallFunction(radiobuttonproperties[i].actionname,nil,[]);
    end;
  end;

  if Sender=Colorpicker then
  begin
    TColor2RGB(colorpicker.SelectedColor,Red,Green,Blue);
    argumente.Count:=3;
    argumente.Values[0]:=red;
    argumente.Values[1]:=green;
    argumente.Values[2]:=blue;

    ScriptInterpreter.CallFunction('ColorPickerChange',argumente,[]);
  end;

  if Sender=PositionXY then
  begin
    argumente.Count:=2;
    argumente.Values[0]:=PositionXY.Top;
    argumente.Values[1]:=PositionXY.Left;

    ScriptInterpreter.CallFunction('PositionXYChange',argumente,[]);
  end;

  if Sender=ColorBox then
  begin
    ScriptInterpreter.CallFunction('ColorBoxChange',nil,[]);
  end;

  if Sender=ColorBox2 then
  begin
    ScriptInterpreter.CallFunction('ColorBoxChange2',nil,[]);
  end;
end;

procedure TDDFWindow.BScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  startscript(Colorpicker);
end;

procedure TDDFWindow.fadenkreuzMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dontrefreshXY:=true;

  if Button=mbLeft then
  begin
    PositionXY.Top:=Y-PositionXY.Height div 2;
    PositionXY.Left:=X-PositionXY.Width div 2;
  end else
  begin
    PositionXY.Top:=(fadenkreuz.Height div 2)-(PositionXY.Height div 2);
    PositionXY.Left:=(fadenkreuz.Width div 2)-(PositionXY.Width div 2);
  end;
  startscript(positionxy);
end;

procedure TDDFWindow.fadenkreuzMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  pan,tilt,r,phi:extended;
begin
  if Shift=[ssLeft] then
  begin
    if usemhcontrol.checked then
    begin
	    pan:=((x-(fadenkreuz.Width/2))/fadenkreuz.Width)*2;	//-1..0..1
	    tilt:=((y-(fadenkreuz.Width/2))/fadenkreuz.Height)*2;	//-1..0..1
      r:=sqrt(pan*pan+tilt*tilt);

      if (r<=1) then  // prüfen, ob Punkt innerhalb von maximalem Radius
      begin
        PositionXY.Left:=x-(PositionXY.Width div 2);
        PositionXY.Top:=y-(PositionXY.Height div 2);
      end else
      begin
        // Punkt an äußerem Radius entlangführen
        if (tilt>=0) then
          phi:=arccos(pan/r)
        else
          phi:=(2*Pi)-arccos(pan/r);

        if (Pi/2)>=phi then
          phi:=phi+(Pi*1.5)
        else
          phi:=phi-(Pi/2);
        phi:=2*Pi-phi;

        PositionXY.Left:=round((sin(phi)*fadenkreuz.Width/2)+(fadenkreuz.Width/2)-(PositionXY.Width/2));
        PositionXY.Top:=round((cos(phi)*fadenkreuz.Height/2)+(fadenkreuz.Height/2)-(PositionXY.Height/2));
      end;
      PositionXY.Refresh;
      startscript(positionxy);
    end else
    begin
      if ((x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=x-(PositionXY.Width div 2);
      if ((y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=y-(PositionXY.Height div 2);

      PositionXY.Refresh;
      startscript(positionxy);
    end;
  end;
end;

procedure TDDFWindow.PositionXYMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  pan, tilt, r, phi:extended;
begin
  if Shift=[ssLeft] then
  begin
    if usemhcontrol.checked then
    begin
	    pan:=(((PositionXY.Left+x)-(fadenkreuz.Width/2))/fadenkreuz.Width)*2;	//-1..0..1
	    tilt:=(((PositionXY.Top+y)-(fadenkreuz.Width/2))/fadenkreuz.Height)*2;	//-1..0..1
      r:=sqrt(pan*pan+tilt*tilt);

      if (r<=1) then  // prüfen, ob Punkt innerhalb von maximalem Radius
      begin
        PositionXY.Left:=(PositionXY.Left+x)-(PositionXY.Width div 2);
        PositionXY.Top:=(PositionXY.Top+y)-(PositionXY.Height div 2);
      end else
      begin
        // Punkt an äußerem Radius entlangführen
        if (tilt>=0) then
          phi:=arccos(pan/r)
        else
          phi:=(2*Pi)-arccos(pan/r);

        if (Pi/2)>=phi then
          phi:=phi+(Pi*1.5)
        else
          phi:=phi-(Pi/2);
        phi:=2*Pi-phi;

        PositionXY.Left:=round((sin(phi)*fadenkreuz.Width/2)+(fadenkreuz.Width/2)-(PositionXY.Width/2));
        PositionXY.Top:=round((cos(phi)*fadenkreuz.Height/2)+(fadenkreuz.Height/2)-(PositionXY.Height/2));
      end;
      PositionXY.Refresh;
      startscript(positionxy);
    end else
    begin
      if ((PositionXY.Left+x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((PositionXY.Left+x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=PositionXY.Left+x-(PositionXY.Width div 2);
      if ((PositionXY.Top+y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((PositionXY.Top+y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=PositionXY.Top+y-(PositionXY.Height div 2);
      PositionXY.Refresh;
      startscript(positionxy);
    end;
  end;
end;

procedure TDDFWindow.loadDDF(ID:TGUID);
var
  i,j,k,l:integer;
  DevicePrototypPosition:integer;
  bildvorhanden:boolean;
  newaddress:word;
  temp:byte;
begin
  positionindevicearray:=-1;

  LockWindow(Handle);

  DevicePrototypPosition:=0;
  deleteDDFwindow;

  for i:=0 to length(mainform.devices)-1 do
  if IsEqualGUID(mainform.devices[i].ID,ID) then
  begin
    positionindevicearray:=i;

    for j:=0 to length(geraetesteuerung.DevicePrototyp)-1 do
    begin
      if (mainform.devices[i].DeviceName=geraetesteuerung.deviceprototyp[j].DeviceName) and (mainform.devices[i].Vendor=geraetesteuerung.deviceprototyp[j].Vendor) then
        DevicePrototypPosition:=j;
    end;

    DeviceID:=mainform.devices[i].ID;

    XML.Xml.LoadFromFile(mainform.workingdirectory+'\Devices\'+geraetesteuerung.deviceprototyp[DevicePrototypPosition].ddffilename);
    for j:=0 to XML.Xml.Root.Items.Count-1 do
    begin // <device>
      if XML.XML.Root.Items[j].Name='form' then
      begin // <form>
        ClientWidth:=XML.XML.Root.Items[j].Properties.IntValue('width');
        ClientHeight:=XML.XML.Root.Items[j].Properties.IntValue('height');
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          if XML.XML.Root.Items[j].Items[k].Name='deviceimage' then
          begin
            if FileExists(mainform.workingdirectory+'Devicepictures\'+'64 x 64'+copy(mainform.devices[i].Bildadresse,8,length(mainform.devices[i].Bildadresse))) then
            begin
              // versuche 64x64 Bild zu laden
              deviceimage.Picture.LoadFromFile(mainform.workingdirectory+'Devicepictures\'+'64 x 64'+copy(mainform.devices[i].Bildadresse,8,length(mainform.devices[i].Bildadresse)));
            end else
            if FileExists(mainform.workingdirectory+'Devicepictures\'+mainform.devices[i].Bildadresse) then
            begin
              // 64x64 existiert nicht, eingestelltes Bild laden
              deviceimage.Picture.LoadFromFile(mainform.workingdirectory+'Devicepictures\'+mainform.devices[i].Bildadresse);
            end else if FileExists(mainform.workingdirectory+'\Devicepictures\'+geraetesteuerung.deviceprototyp[DevicePrototypPosition].Bildadresse) then
            begin
              // Gerätebild nicht verfügbar, Gerätegruppenbild laden
              deviceimage.Picture.LoadFromFile(mainform.workingdirectory+'\Devicepictures\'+geraetesteuerung.deviceprototyp[DevicePrototypPosition].Bildadresse);
            end else
            begin
              deviceimage.Picture:=standardpicture.Picture;
            end;

            deviceimage.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            deviceimage.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            deviceimage.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            deviceimage.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            deviceimage.Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='devicename' then
          begin
            devicename.Caption:=mainform.Devices[i].Name;
            Caption:='Gerät: '+mainform.Devices[i].DeviceName;
            devicename.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            devicename.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
//              devicename.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
//              devicename.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            devicename.Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='deviceadress' then
          begin
            deviceadress.Caption:='Startadresse: '+inttostr(mainform.Devices[i].Startaddress);
            deviceadress.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            deviceadress.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
//              deviceadress.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
//              deviceadress.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            deviceadress.Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='devicedipswitch' then
          begin
            dipswitchpanel.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            dipswitchpanel.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            dipswitchpanel.Visible:=true;

            newaddress:=mainform.Devices[i].Startaddress;
            oldaddress:=newaddress;
            temp:=newaddress;
            dipstate[1]:=BitSet(temp, 1);
            dipstate[2]:=BitSet(temp, 2);
            dipstate[3]:=BitSet(temp, 4);
            dipstate[4]:=BitSet(temp, 8);
            dipstate[5]:=BitSet(temp, 16);
            dipstate[6]:=BitSet(temp, 32);
            dipstate[7]:=BitSet(temp, 64);
            dipstate[8]:=BitSet(temp, 128);

            temp:=newaddress shr 8;
            dipstate[9]:=BitSet(temp, 1);
            dipstate[10]:=BitSet(temp, 2);

            for l:=1 to 10 do
            begin
              if dipstate[l] then
                Timage(FindComponent('DIP'+inttostr(l))).Picture:=DIPON.Picture
              else
                Timage(FindComponent('DIP'+inttostr(l))).Picture:=DIPOFF.Picture;
            end;
          end;

          if XML.XML.Root.Items[j].Items[k].Name='position' then
          begin
            fadenkreuz.Visible:=true;
            fadenkreuz.top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            fadenkreuz.left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            fadenkreuz.width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            fadenkreuz.height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            if XML.XML.Root.Items[j].Items[k].Properties.BoolValue('mhcontrol',false) then
            begin
              // Fadenkreuz abrunden
              usemhcontrol.checked:=true;
              rgn := CreateRoundRectRgn(1,1,fadenkreuz.Width,fadenkreuz.Height,fadenkreuz.Width,fadenkreuz.Height);
              SetWindowRgn(fadenkreuz.Handle, rgn, True);
            end else
            begin
              usemhcontrol.checked:=false;
              SetWindowRgn(fadenkreuz.Handle, 0, True);
            end;
            
            Bevel1.Left:=fadenkreuz.Width div 2;
            Bevel1.Height:=fadenkreuz.Height;
            Bevel2.Top:=fadenkreuz.Height div 2;
            Bevel2.Width:=fadenkreuz.Width;
            PositionXY.Top:=(fadenkreuz.Height div 2)-(PositionXY.Height div 2);
            PositionXY.Left:=(fadenkreuz.Width div 2)-(PositionXY.Width div 2);
          end;
          if XML.XML.Root.Items[j].Items[k].Name='label' then
          begin
            setlength(Labels,length(Labels)+1);
            Labels[length(Labels)-1]:=TLabel.Create(self);
            Labels[length(Labels)-1].Parent:=self;
            Labels[length(Labels)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Labels[length(Labels)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Labels[length(Labels)-1].Caption:=XML.XML.Root.Items[j].Items[k].Properties.Value('caption');
            Labels[length(Labels)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Labels[length(Labels)-1].Transparent:=true;
            Labels[length(Labels)-1].Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='slider' then
          begin
            setlength(Sliders,length(Sliders)+1);
            setlength(sliderproperties,length(sliderproperties)+1);
            Sliders[length(Sliders)-1]:=TScrollbar.Create(self);
            Sliders[length(Sliders)-1].Parent:=self;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              Sliders[length(Sliders)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            sliderproperties[length(sliderproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            sliderproperties[length(sliderproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            sliderproperties[length(sliderproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Sliders[length(Sliders)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Sliders[length(Sliders)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Sliders[length(Sliders)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Sliders[length(Sliders)-1].Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            Sliders[length(Sliders)-1].Max:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('endvalue');
            Sliders[length(Sliders)-1].Min:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('startvalue');
            Sliders[length(Sliders)-1].position:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('default');
            Sliders[length(Sliders)-1].Visible:=true;
            Sliders[length(Sliders)-1].OnScroll:=sliderscroll;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='progressbar' then
          begin
            setlength(progressbars,length(progressbars)+1);
            progressbars[length(progressbars)-1]:=TProgressbar.Create(self);
            progressbars[length(progressbars)-1].Parent:=self;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              progressbars[length(progressbars)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            progressbars[length(progressbars)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            progressbars[length(progressbars)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            progressbars[length(progressbars)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            progressbars[length(progressbars)-1].Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            progressbars[length(progressbars)-1].Min:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('startvalue');
            progressbars[length(progressbars)-1].Max:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('endvalue');
            progressbars[length(progressbars)-1].position:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('default');
            progressbars[length(progressbars)-1].Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='dropdown' then
          begin
            setlength(Comboboxs,length(Comboboxs)+1);
            setlength(ComboboxsImageList,length(ComboboxsImageList)+1);
            setlength(comboboxproperties,length(comboboxproperties)+1);
            Comboboxs[length(Comboboxs)-1]:=TmbXPImageCombobox.Create(self);//TCombobox.Create(self);
            Comboboxs[length(Comboboxs)-1].Parent:=self;
            Comboboxs[length(Comboboxs)-1].Style:=csDropDownList;
            ComboboxsImageList[length(ComboboxsImageList)-1]:=TImageList.Create(self);

            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              Comboboxs[length(Comboboxs)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            comboboxproperties[length(comboboxproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            comboboxproperties[length(comboboxproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            comboboxproperties[length(comboboxproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Comboboxs[length(Comboboxs)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Comboboxs[length(Comboboxs)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Comboboxs[length(Comboboxs)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Comboboxs[length(Comboboxs)-1].Visible:=true;
            setlength(comboboxproperties[length(comboboxproperties)-1].itemvalue,XML.XML.Root.Items[j].Items[k].Items.Count);

            bildvorhanden:=false;
            for l:=0 to XML.XML.Root.Items[j].Items[k].Items.Count-1 do
            begin
              comboboxproperties[length(comboboxproperties)-1].itemvalue[l]:=XML.XML.Root.Items[j].Items[k].Items[l].Properties.IntValue('value');
              Comboboxs[length(Comboboxs)-1].Items.Add(XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('caption'));

              bildvorhanden:=false;
              if XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture')<>'' then
              begin
                bildvorhanden:=true;
                if FileExists(mainform.workingdirectory+'Devices\Icons\'+XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture')) then
                begin
                  Bmp.Picture.LoadFromFile(mainform.workingdirectory+'Devices\Icons\'+XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture'));
                end else if FileExists(mainform.workingdirectory+'Devicepictures\GobosSmall\'+XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture')) then
                begin
                  Bmp.Picture.LoadFromFile(mainform.workingdirectory+'Devicepictures\GobosSmall\'+XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture'));
                end else if FileExists(XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture')) then
                begin
                  Bmp.Picture.LoadFromFile(XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('picture'));
                end else
                begin
                  Bmp.Picture.LoadFromFile(mainform.workingdirectory+'Devices\Icons\leer.bmp');
                end;
                ComboboxsImageList[length(ComboboxsImageList)-1].Add(Bmp.Picture.Bitmap,Bmp.Picture.Bitmap);
              end else
              begin
                Bmp.Picture.LoadFromFile(mainform.workingdirectory+'Devices\Icons\leer.bmp');
                ComboboxsImageList[length(ComboboxsImageList)-1].Add(Bmp.Picture.Bitmap,Bmp.Picture.Bitmap);
              end;
            end;

            if (ComboboxsImageList[length(ComboboxsImageList)-1].Count>0) and bildvorhanden then
            begin
              Comboboxs[length(Comboboxs)-1].Style:=csOwnerDrawFixed;
              Comboboxs[length(Comboboxs)-1].Images:=ComboboxsImageList[length(ComboboxsImageList)-1];
            end;

            Comboboxs[length(Comboboxs)-1].ItemIndex:=0;
            Comboboxs[length(Comboboxs)-1].OnSelect:=startscript;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='line' then
          begin
            setlength(Shapes,length(Shapes)+1);
            Shapes[length(Shapes)-1]:=TShape.Create(self);
            Shapes[length(Shapes)-1].Parent:=self;
            Shapes[length(Shapes)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Shapes[length(Shapes)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Shapes[length(Shapes)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Shapes[length(Shapes)-1].Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            Shapes[length(Shapes)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Shapes[length(Shapes)-1].Visible:=true;
          end;
          if (XML.XML.Root.Items[j].Items[k].Name='colorpicker') or (XML.XML.Root.Items[j].Items[k].Name='colorpicker2') then
          begin
            Colorpicker.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Colorpicker.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Colorpicker.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Colorpicker.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            Colorpickerchannel[0]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel1');
            Colorpickerchannel[1]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel2');
            Colorpickerchannel[2]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel3');
            Colorpicker.Visible:=XML.XML.Root.Items[j].Items[k].Name='colorpicker';
{
            R.Visible:=true;
            G.Visible:=true;
            B.Visible:=true;
}
          end;
          if (XML.XML.Root.Items[j].Items[k].Name='colorpicker') or (XML.XML.Root.Items[j].Items[k].Name='colorpicker2') then
          begin
            Colorpicker2.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Colorpicker2.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left')+7;
{
            Colorpicker2.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Colorpicker2.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
}
            Colorpickerchannel[0]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel1');
            Colorpickerchannel[1]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel2');
            Colorpickerchannel[2]:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel3');
            Colorpicker2.Visible:=XML.XML.Root.Items[j].Items[k].Name='colorpicker2';
{
            R.Visible:=true;
            G.Visible:=true;
            B.Visible:=true;
}
          end;
          if (XML.XML.Root.Items[j].Items[k].Name='colorbox') then
          begin
            colorbox.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            colorbox.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            colorbox.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            colorbox.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            colorbox.Items.clear;
            for l:=0 to length(mainform.devices[i].colors)-1 do
              colorbox.AddColor(mainform.devices[i].colors[l],mainform.devices[i].colornames[l]);
            colorbox.Visible:=true;
          end;
          if (XML.XML.Root.Items[j].Items[k].Name='colorbox2') then
          begin
            colorbox2.Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            colorbox2.Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            colorbox2.Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            colorbox2.Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            colorbox2.Items.clear;
            for l:=0 to length(mainform.devices[i].colors2)-1 do
              colorbox2.AddColor(mainform.devices[i].colors2[l],mainform.devices[i].colornames2[l]);
            colorbox2.Visible:=true;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='button' then
          begin
            setlength(Buttons,length(Buttons)+1);
            setlength(buttonproperties,length(buttonproperties)+1);
            Buttons[length(Buttons)-1]:=TButton.Create(self);
            Buttons[length(Buttons)-1].Parent:=self;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              Buttons[length(Buttons)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Buttonproperties[length(Buttonproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Buttonproperties[length(Buttonproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            Buttonproperties[length(Buttonproperties)-1].onvalue:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('onvalue');
            Buttonproperties[length(Buttonproperties)-1].offvalue:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('offvalue');
            Buttonproperties[length(Buttonproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Buttons[length(Buttons)-1].Caption:=XML.XML.Root.Items[j].Items[k].Properties.Value('caption');
            Buttons[length(Buttons)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top');
            Buttons[length(Buttons)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Buttons[length(Buttons)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width');
            Buttons[length(Buttons)-1].Height:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('height');
            Buttons[length(Buttons)-1].Hint:=XML.XML.Root.Items[j].Items[k].Properties.Value('hint');
            Buttons[length(Buttons)-1].showhint:=XML.XML.Root.Items[j].Items[k].Properties.Value('hint')<>'';
            Buttons[length(Buttons)-1].Visible:=true;
            Buttons[length(Buttons)-1].OnClick:=startscript;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='options' then
          begin
            setlength(Radiobuttons,length(Radiobuttons)+1);
            setlength(radiobuttonproperties,length(radiobuttonproperties)+1);
            Radiobuttons[length(Radiobuttons)-1]:=TRadioGroup.Create(self);
            Radiobuttons[length(Radiobuttons)-1].Parent:=self;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              Radiobuttons[length(Radiobuttons)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            radiobuttonproperties[length(radiobuttonproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            radiobuttonproperties[length(radiobuttonproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            radiobuttonproperties[length(radiobuttonproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Radiobuttons[length(Radiobuttons)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top',50);
            Radiobuttons[length(Radiobuttons)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Radiobuttons[length(Radiobuttons)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width',100);
            Radiobuttons[length(Radiobuttons)-1].Visible:=true;
            setlength(radiobuttonproperties[length(radiobuttonproperties)-1].itemvalue,XML.XML.Root.Items[j].Items[k].Items.Count);
            for l:=0 to XML.XML.Root.Items[j].Items[k].Items.Count-1 do
            begin
              radiobuttonproperties[length(radiobuttonproperties)-1].itemvalue[l]:=XML.XML.Root.Items[j].Items[k].Items[l].Properties.IntValue('value');
              Radiobuttons[length(Radiobuttons)-1].Items.Add(XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('caption'));
              if XML.XML.Root.Items[j].Items[k].Items[l].Properties.Value('default')='true' then
                Radiobuttons[length(Radiobuttons)-1].ItemIndex:=l;
            end;
            Radiobuttons[length(Radiobuttons)-1].OnClick:=startscript;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='checkbox' then
          begin
            setlength(checkboxs,length(checkboxs)+1);
            setlength(checkboxproperties,length(checkboxproperties)+1);
            checkboxs[length(checkboxs)-1]:=TCheckbox.Create(self);
            Checkboxs[length(checkboxs)-1].Parent:=self;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              checkboxs[length(checkboxs)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Checkboxproperties[length(Checkboxproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Checkboxproperties[length(Checkboxproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            Checkboxproperties[length(Checkboxproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Checkboxs[length(Checkboxs)-1].Caption:=XML.XML.Root.Items[j].Items[k].Properties.Value('caption');
            Checkboxs[length(Checkboxs)-1].checked:=XML.XML.Root.Items[j].Items[k].Properties.Value('checked')='true';
            Checkboxs[length(Checkboxs)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top',50);
            Checkboxs[length(Checkboxs)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Checkboxs[length(Checkboxs)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width',100);
            Checkboxs[length(Checkboxs)-1].Visible:=true;
            Checkboxs[length(Checkboxs)-1].OnClick:=startscript;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='edit' then
          begin
            setlength(edits,length(Edits)+1);
            setlength(editproperties,length(editproperties)+1);
            Edits[length(Edits)-1]:=TEdit.Create(self);
            Edits[length(Edits)-1].Parent:=self;
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')<>'' then
              Edits[length(Edits)-1].Name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Editproperties[length(Editproperties)-1].name:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
            Editproperties[length(Editproperties)-1].channel:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('channel');
            Editproperties[length(Editproperties)-1].actionname:=XML.XML.Root.Items[j].Items[k].Properties.Value('action');
            Edits[length(Edits)-1].text:=XML.XML.Root.Items[j].Items[k].Properties.Value('text');
            Edits[length(Edits)-1].Top:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('top',50);
            Edits[length(Edits)-1].Left:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('left');
            Edits[length(Edits)-1].Width:=XML.XML.Root.Items[j].Items[k].Properties.IntValue('width',100);
            Edits[length(Edits)-1].Visible:=true;
            Edits[length(Edits)-1].OnChange:=startscript;
          end;
        end;
      end;
      if XML.XML.Root.Items[j].Name='code' then
      begin // <code>
        funktionen:=XML.XML.Root.Items[j].Value;
        ScriptInterpreter.Pas.Text:=XML.XML.Root.Items[j].Value;
        ScriptInterpreter.Compile;
      end;
    end;
  end;

  ddffenstervorhanden:=true;

  Show;
  ScriptInterpreter.CallFunction('FormShow',nil,[]);

  UnLockWindow(Handle);

  loadDDFWindow:=false;

  if positionindevicearray>-1 then
    for i:=0 to mainform.devices[positionindevicearray].MaxChan-1 do
      RefreshDDFWindow(mainform.devices[positionindevicearray].Startaddress+i);
end;

procedure TDDFWindow.deleteDDFwindow;
var
  i:integer;
begin
  ddffenstervorhanden:=false;

  ScriptInterpreter.Pas.Text:='unit noDDFloaded; interface implementation procedure FormRefresh; begin end; end.';
  ScriptInterpreter.Compile;

  deviceimage.Width:=128;
  deviceimage.Height:=128;
  deviceimage.Picture.LoadFromFile(mainform.workingdirectory+'\Devicepictures\128x128\par56silber.png');

  devicename.Top:=150;
  devicename.Left:=8;
  devicename.Caption:=_('PC_DIMMER Gerätesteuerung');
  deviceadress.Top:=165;
  deviceadress.Left:=8;
  deviceadress.Caption:=_('Derzeit keine Geräte selektiert.');

  // zunächst alle Controls der Form löschen
  for i:=0 to length(Edits)-1 do
    Edits[i].Free;
  setlength(Edits,0);
  setlength(editproperties,0);

  for i:=0 to length(CheckBoxs)-1 do
    CheckBoxs[i].Free;
  setlength(Checkboxs,0);
  setlength(checkboxproperties,0);

  for i:=0 to length(ComboBoxs)-1 do
    ComboBoxs[i].Free;
  for i:=0 to length(ComboboxsImageList)-1 do
    ComboboxsImageList[i].Free;
  setlength(Comboboxs,0);
  setlength(ComboboxsImageList,0);
  setlength(comboboxproperties,0);

  for i:=0 to length(Labels)-1 do
    Labels[i].Free;
  setlength(Labels,0);

  for i:=0 to length(Sliders)-1 do
    Sliders[i].Free;
  setlength(Sliders,0);
  setlength(sliderproperties,0);

  for i:=0 to length(progressbars)-1 do
    progressbars[i].Free;
  setlength(progressbars,0);

  for i:=0 to length(Shapes)-1 do
    Shapes[i].Free;
  setlength(Shapes,0);

  for i:=0 to length(Buttons)-1 do
    Buttons[i].Free;
  setlength(Buttons,0);
  setlength(buttonproperties,0);

  for i:=0 to length(Radiobuttons)-1 do
    Radiobuttons[i].Free;
  setlength(Radiobuttons,0);
  setlength(radiobuttonproperties,0);

  Colorpicker.Visible:=false;
  Colorpicker2.Visible:=false;
  Colorbox.Visible:=false;
  Colorbox2.Visible:=false;
{
  R.Visible:=false;
  G.Visible:=false;
  B.Visible:=false;
}
  fadenkreuz.Visible:=false;
  dipswitchpanel.visible:=false;
end;

procedure TDDFWindow.RefreshDDFWindow(channel: integer);
var
  positionindevicearray:integer;
begin
  positionindevicearray:=geraetesteuerung.GetDevicePositionInDeviceArray(@DeviceID);
  if positionindevicearray=-1 then exit;

  if (channel>=mainform.devices[positionindevicearray].Startaddress) and (channel<(mainform.Devices[positionindevicearray].Startaddress+mainform.Devices[positionindevicearray].MaxChan)) then
  begin
    argumente.Count:=1;
    argumente.Values[0]:=channel-mainform.devices[positionindevicearray].Startaddress;

    if ddffenstervorhanden then
      ScriptInterpreter.CallFunction('FormRefresh',argumente,[]);
  end;
end;

procedure TDDFWindow.sliderscroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  startscript(Sender);
end;

procedure TDDFWindow.ColorPickerColorChange(Sender: TObject);
begin
  if ColorPicker.visible and (Sender=ColorPicker) then
  begin
    TColor2RGB(colorpicker.SelectedColor,Red,Green,Blue);
    Colorpicker2.selectedColor:=ColorPicker.SelectedColor;

    startscript(Colorpicker);
  end;
end;

procedure TDDFWindow.ColorPicker2Change(Sender: TObject);
begin
  if ColorPicker2.visible and (Sender=ColorPicker2) then
  begin
    TColor2RGB(ColorPicker2.SelectedColor,Red,Green,Blue);
    Colorpicker.selectedColor:=ColorPicker2.SelectedColor;

    startscript(Colorpicker);
  end;
end;

procedure TDDFWindow.ScriptInterpreterGetValue(Sender: TObject;
  Identifier: String; var Value: Variant; Args: TJvInterpreterArgs;
  var Done: Boolean);
var
  i:integer;
begin
  if (lowercase(Identifier)='set_absolutchannel') or (lowercase(Identifier)='set_absolutechannel') then
  begin
    if args.Count=4 then
    begin
      dontrefreshDDFWindow:=true;
      mainform.Senddata(args.values[0],maxres-args.values[1],maxres-args.values[2],args.values[3]);
    end;
    if args.Count=5 then
    begin
      dontrefreshDDFWindow:=true;
      mainform.Senddata(args.values[0],maxres-args.values[1],maxres-args.values[2],args.values[3],args.values[4]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_pantilt' then
  begin
    if args.Count=5 then
    begin
      dontrefreshDDFWindow:=true;
      geraetesteuerung.set_pantilt(deviceid,args.values[0],args.values[1],args.values[2],args.values[3],args.values[4]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_channel' then
  begin
    if args.Count=4 then
    begin
      dontrefreshDDFWindow:=true;
      geraetesteuerung.set_channel(deviceid,args.values[0],args.values[1],args.values[2],args.values[3]);
    end;
    if args.Count=5 then
    begin
      dontrefreshDDFWindow:=true;
      geraetesteuerung.set_channel(deviceid,args.values[0],args.values[1],args.values[2],args.values[3],args.values[4]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_color' then
  begin
    if args.Count=4 then
    begin
      dontrefreshDDFWindow:=true;
      geraetesteuerung.set_color(deviceid,args.values[0],args.values[1],args.values[2],args.values[3],0);
    end;
    if args.Count=5 then
    begin
      dontrefreshDDFWindow:=true;
      geraetesteuerung.set_color(deviceid,args.values[0],args.values[1],args.values[2],args.values[3],args.values[4]);
    end;
    done:=true;
  end;

  if lowercase(Identifier)='set_control' then
  begin
      for i:=0 to length(Edits)-1 do
      begin
        if args.values[0]=lowercase(editproperties[i].name) then
          Edits[i].text:=args.values[1];
      end;
      for i:=0 to length(Checkboxs)-1 do
      begin
        if args.values[0]=lowercase(checkboxproperties[i].name) then
          Checkboxs[i].Checked:=args.values[1];
      end;
      for i:=0 to length(Comboboxs)-1 do
      begin
        if args.values[0]=lowercase(comboboxproperties[i].name) then
          Comboboxs[i].ItemIndex:=args.values[1];
      end;
      for i:=0 to length(Sliders)-1 do
      begin
        if args.values[0]=lowercase(sliderproperties[i].name) then
          Sliders[i].Position:=args.values[1];
      end;
      for i:=0 to length(progressbars)-1 do
      begin
        if args.values[0]=lowercase(progressbars[i].name) then
          progressbars[i].Position:=args.values[1];
      end;
      for i:=0 to length(Radiobuttons)-1 do
      begin
        if args.values[0]=lowercase(radiobuttonproperties[i].name) then
          Radiobuttons[i].ItemIndex:=args.values[1];
      end;
    done:=true;
  end;

  if lowercase(Identifier)='get_absolutechannel' then
  begin
    Value:=maxres-mainform.data.ch[Integer(args.values[0])];
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='get_channel' then
  begin
    Value:=geraetesteuerung.get_channel(mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@DeviceID)].ID,args.values[0]);
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='levelstr' then
  begin
    Value:=mainform.levelstr(args.values[0]);
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='sin' then
  begin
    Value:=sin(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='cos' then
  begin
    Value:=cos(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='arccos' then
  begin
    Value:=arccos(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='degtorad' then
  begin
    Value:=degtorad(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='radtodeg' then
  begin
    Value:=radtodeg(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  if lowercase(Identifier)='frac' then
  begin
    Value:=frac(Extended(args.values[0]));
    args.HasResult:=true;
    Done:=true;
  end;

  // Objekte zuweisen
  if lowercase(Identifier)='mainform' then
  begin
    Value := O2V(mainform);
    Done := True;
  end;
  if lowercase(Identifier)='geraetesteuerung' then
  begin
    Value := O2V(geraetesteuerung);
    Done := True;
  end;
  if lowercase(Identifier)='ddfwindow' then
  begin
    Value := O2V(self);
    Done := True;
  end;

  // Controls zuweisen
    for i:=0 to length(Edits)-1 do
    begin
      if lowercase(Identifier)=lowercase(edits[i].name) then
      begin
        Value:=O2V(Edits[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Buttons)-1 do
    begin
      if lowercase(Identifier)=lowercase(Buttons[i].name) then
      begin
        Value:=O2V(Buttons[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Checkboxs)-1 do
    begin
      if lowercase(Identifier)=lowercase(Checkboxs[i].name) then
      begin
        Value:=O2V(Checkboxs[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Comboboxs)-1 do
    begin
      if lowercase(Identifier)=lowercase(Comboboxs[i].name) then
      begin
        Value:=O2V(Comboboxs[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Sliders)-1 do
    begin
      if lowercase(Identifier)=lowercase(Sliders[i].name) then
      begin
        Value:=O2V(Sliders[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(progressbars)-1 do
    begin
      if lowercase(Identifier)=lowercase(progressbars[i].name) then
      begin
        Value:=O2V(progressbars[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Radiobuttons)-1 do
    begin
      if lowercase(Identifier)=lowercase(Radiobuttons[i].name) then
      begin
        Value:=O2V(Radiobuttons[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(Labels)-1 do
    begin
      if lowercase(Identifier)=lowercase(Labels[i].name) then
      begin
        Value:=O2V(Labels[i]);
        Done:=true;
      end;
    end;
    for i:=0 to length(shapes)-1 do
    begin
      if lowercase(Identifier)=lowercase(shapes[i].name) then
      begin
        Value:=O2V(shapes[i]);
        Done:=true;
      end;
    end;
    if lowercase(Identifier)='colorpicker' then
    begin
      Value:=O2V(colorpicker);
      Done:=true;
    end;
    if lowercase(Identifier)='colorpicker2' then
    begin
      Value:=O2V(colorpicker2);
      Done:=true;
    end;
    if lowercase(Identifier)='positionxy' then
    begin
      Value:=O2V(positionxy);
      Done:=true;
    end;
    if lowercase(Identifier)='fadenkreuz' then
    begin
      Value:=O2V(fadenkreuz);
      Done:=true;
    end;
    if lowercase(Identifier)='HorTrack' then
    begin
      Value:=O2V(HorTrack);
      Done:=true;
    end;
    if lowercase(Identifier)='VertTrack' then
    begin
      Value:=O2V(VertTrack);
      Done:=true;
    end;
    if lowercase(Identifier)='colorbox' then
    begin
      Value:=O2V(colorbox);
      Done:=true;
    end;
    if lowercase(Identifier)='colorbox2' then
    begin
      Value:=O2V(colorbox2);
      Done:=true;
    end;

    if lowercase(Identifier)='panmirror' then
    begin
      Value:=O2V(panmirror);
      Done:=true;
    end;
    if lowercase(Identifier)='tiltmirror' then
    begin
      Value:=O2V(tiltmirror);
      Done:=true;
    end;
    if lowercase(Identifier)='usemhcontrol' then
    begin
      Value:=O2V(usemhcontrol);
      Done:=true;
    end;
end;

procedure TDDFWindow.ColorPickerMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Sender=ColorPicker) then
  begin
    TColor2RGB(colorpicker.SelectedColor,Red,Green,Blue);
    Colorpicker2.selectedColor:=ColorPicker.SelectedColor;

    startscript(Colorpicker);
  end;
end;

procedure TDDFWindow.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  loadDDFWindow:=true;

  Bmp := TImage.Create(self);
  argumente:=TJvInterpreterArgs.Create;
end;

procedure TDDFWindow.FormDestroy(Sender: TObject);
begin
  Bmp.Free;
  argumente.free;
end;

procedure TDDFWindow.ColorBoxChange(Sender: TObject);
begin
  if (Sender=ColorBox) then
  begin
    startscript(ColorBox);
  end;
end;

procedure TDDFWindow.PositionXYMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dontrefreshXY:=true;
end;

procedure TDDFWindow.fadenkreuzMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  dontrefreshXY:=false;

  if Shift=[ssCtrl] then
  begin
    usemhcontrol.checked:=not usemhcontrol.checked;
    if usemhcontrol.checked then
    begin
      rgn := CreateRoundRectRgn(1,1,fadenkreuz.Width,fadenkreuz.Height,fadenkreuz.Width,fadenkreuz.Height);
      SetWindowRgn(fadenkreuz.Handle, rgn, True);
    end else
    begin
      SetWindowRgn(fadenkreuz.Handle, 0, True);
    end;

    if positionindevicearray>-1 then
      for i:=0 to mainform.devices[positionindevicearray].MaxChan-1 do
        RefreshDDFWindow(mainform.devices[positionindevicearray].Startaddress+i);
  end;

  if Shift=[ssShift] then
  begin
    VertTrack.Visible:=not VertTrack.Visible;
    HorTrack.Visible:=VertTrack.Visible;
  end;
end;

procedure TDDFWindow.PositionXYMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  dontrefreshXY:=false;

  if Shift=[ssCtrl] then
  begin
    usemhcontrol.checked:=not usemhcontrol.checked;
    if usemhcontrol.checked then
    begin
      rgn := CreateRoundRectRgn(1,1,fadenkreuz.Width,fadenkreuz.Height,fadenkreuz.Width,fadenkreuz.Height);
      SetWindowRgn(fadenkreuz.Handle, rgn, True);
    end else
    begin
      SetWindowRgn(fadenkreuz.Handle, 0, True);
    end;

    if positionindevicearray>-1 then
      for i:=0 to mainform.devices[positionindevicearray].MaxChan-1 do
        RefreshDDFWindow(mainform.devices[positionindevicearray].Startaddress+i);
  end;

  if Shift=[ssShift] then
  begin
    VertTrack.Visible:=not VertTrack.Visible;
    HorTrack.Visible:=VertTrack.Visible;
  end;
end;

procedure TDDFWindow.RefreshTimerTimer(Sender: TObject);
var
  i:integer;
begin
  if loadDDFWindow then exit;

  for i:=1 to mainform.lastchan do
  begin
    if RefreshChannel[i] then
    begin
      RefreshChannel[i]:=false;
      RefreshDDFWindow(i);
    end;
  end;
end;

procedure TDDFWindow.usemhcontrolMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  if usemhcontrol.checked then
  begin
    rgn := CreateRoundRectRgn(1,1,fadenkreuz.Width,fadenkreuz.Height,fadenkreuz.Width,fadenkreuz.Height);
    SetWindowRgn(fadenkreuz.Handle, rgn, True);
  end else
  begin
    SetWindowRgn(fadenkreuz.Handle, 0, True);
  end;

  if positionindevicearray>-1 then
    for i:=0 to mainform.devices[positionindevicearray].MaxChan-1 do
      RefreshDDFWindow(mainform.devices[positionindevicearray].Startaddress+i);
end;

procedure TDDFWindow.HorTrackChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'pan',trunc(HorTrack.Position/257),trunc(HorTrack.Position/257),0);
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'panfine',trunc(frac(HorTrack.Position/257)*255),trunc(frac(HorTrack.Position/257)*255),0);
    end;
  end;

  PositionXY.Left:=round((HorTrack.Position/65535)*fadenkreuz.Width-(PositionXY.Width/2));

  PositionXY.Refresh;
  startscript(positionxy);
end;

procedure TDDFWindow.VertTrackChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'tilt',trunc(VertTrack.Position/257),trunc(VertTrack.Position/257),0);
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'tiltfine',trunc(frac(VertTrack.Position/257)*255),trunc(frac(VertTrack.Position/257)*255),0);
    end;
  end;

  PositionXY.Top:=round((VertTrack.Position/65535)*fadenkreuz.Height-(PositionXY.Height/2));

  PositionXY.Refresh;
  startscript(positionxy);
end;

procedure TDDFWindow.FormShow(Sender: TObject);
var
  newaddress:word;
  temp:byte;
  i:integer;
begin
  positionindevicearray:=-1;
  positionindevicearray:=geraetesteuerung.GetDevicePositionInDeviceArray(@DeviceID);
  if positionindevicearray=-1 then exit;

  newaddress:=mainform.Devices[positionindevicearray].Startaddress;
  if (newaddress<>oldaddress) and dipswitchpanel.Visible then
  begin
    oldaddress:=newaddress;
    temp:=newaddress;
    dipstate[1]:=BitSet(temp, 1);
    dipstate[2]:=BitSet(temp, 2);
    dipstate[3]:=BitSet(temp, 4);
    dipstate[4]:=BitSet(temp, 8);
    dipstate[5]:=BitSet(temp, 16);
    dipstate[6]:=BitSet(temp, 32);
    dipstate[7]:=BitSet(temp, 64);
    dipstate[8]:=BitSet(temp, 128);

    temp:=newaddress shr 8;
    dipstate[9]:=BitSet(temp, 1);
    dipstate[10]:=BitSet(temp, 2);

    for i:=1 to 10 do
    begin
      if dipstate[i] then
        Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPON.Picture
      else
        Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPOFF.Picture;
    end;
  end;
end;

procedure TDDFWindow.colorbox2Change(Sender: TObject);
begin
  if (Sender=ColorBox2) then
  begin
    startscript(ColorBox2);
  end;
end;

end.
