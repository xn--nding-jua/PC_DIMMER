unit adddevicefrm;

interface
       
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, JvSimpleXml, JvComponent, JvOfficeColorPanel,
  JvAppXMLStorage, ExtCtrls, JvAppStorage, JvComponentBase, gnugettext,
  pngimage, JvExControls, JvGradient, Buttons, PngBitBtn, ShellApi,
  VirtualTrees;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: byte; // 0=Vendor, 1=Type, 2=Device
    Caption:WideString;
    Beschreibung:WideString;
    Kanalzahl: Word;
    Autor:WideString;
    ID:TGUID;
  end;

  Tadddevice = class(TForm)
    XML: TJvAppXMLFileStorage;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    namelabel: TLabel;
    vendorlabel: TLabel;
    authorlabel: TLabel;
    maxchanlabel: TLabel;
    Label5: TLabel;
    beschreibunglabel: TLabel;
    Label6: TLabel;
    dateilabel: TLabel;
    ListBox1: TListBox;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    ProgressBar1: TProgressBar;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lastaddress: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Panel9: TPanel;
    Edit1: TEdit;
    Panel10: TPanel;
    Panel11: TPanel;
    Image1: TImage;
    standardpicture: TImage;
    adddeviceicon: TCheckBox;
    Timer1: TTimer;
    Panel12: TPanel;
    JvGradient1: TJvGradient;
    Image2: TImage;
    Label34: TLabel;
    Label35: TLabel;
    dipswitcha: TImage;
    DIPON: TImage;
    DIPOFF: TImage;
    DIP9: TImage;
    DIP8: TImage;
    DIP7: TImage;
    DIP6: TImage;
    DIP5: TImage;
    DIP4: TImage;
    DIP3: TImage;
    DIP2: TImage;
    DIP10: TImage;
    DIP1: TImage;
    Edit4: TEdit;
    Label10: TLabel;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    PngBitBtn3: TPngBitBtn;
    PngBitBtn4: TPngBitBtn;
    adddevicegroupcheck: TCheckBox;
    VST: TVirtualStringTree;
    SuchTimer: TTimer;
    plus: TButton;
    minus: TButton;
    procedure FormShow(Sender: TObject);
    procedure checkinformations;
    procedure Button3Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DIP1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure Edit2Change(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure VSTKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure VSTMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VSTPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure SuchTimerTimer(Sender: TObject);
    procedure minusClick(Sender: TObject);
    procedure plusClick(Sender: TObject);
  private
    { Private-Deklarationen }
    dipstate:array[1..10] of boolean;
    VSTVendorNodes: array of PVirtualNode;
    VSTTypeNodes: array of array of PVirtualNode;
    procedure LoadDDFs;
    procedure TreeviewRefresh;
  public
    { Public-Deklarationen }
    SelectedPrototype:TGUID;
    DeviceSelectionOK:boolean;
    function GetDevicePositionInDeviceArray(ID: PGUID):integer;
  end;

procedure LockWindow(const Handle: HWND);
procedure UnLockWindow(const Handle: HWND);

var
  adddevice: Tadddevice;

implementation

uses PCDIMMER, geraetesteuerungfrm, ddfeditorfrm, ProgressScreenSmallFrm;

{$R *.dfm}

procedure LockWindow(const Handle: HWND);
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
end;

procedure UnlockWindow(const Handle: HWND);
begin
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  RedrawWindow(Handle, nil, 0,
    RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

function BitSet(Value: Byte; BitCnt: Byte): Boolean;
begin
//  Result := (( Value AND Round ( power (2, BitCnt-1) )) = Round ( power (2, BitCnt-1) ));
//  result:=(Value AND (1 shl bitcnt )) = (1 shl bitcnt);
  result := ((Value AND bitcnt) = bitcnt);
end;

procedure Tadddevice.FormShow(Sender: TObject);
var
  i,temp:integer;
begin
  Edit1.Text:=_('Suchtext hier eingeben...');
  Edit1.Font.Color:=clGray;

  Edit2.Text:='1';
  temp:=0;
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if temp<mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1 then
      temp:=mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1;
  end;
  adddevice.lastaddress.Caption:=inttostr(temp);
  if Edit3.enabled=true then
    Edit3.Text:=inttostr(temp+1);

  DeviceSelectionOK:=false;
  VST.BeginUpdate;
  VST.Clear;
  VST.EndUpdate;
  Timer1.enabled:=true;
end;

procedure Tadddevice.TreeviewRefresh;
var
  i,j:integer;
  vendornode, typenode:PVirtualNode;
  vendornodeok, typenodeok:integer;
  Data:PTreeData;
begin
  VST.BeginUpdate;
  VST.Clear;
  VST.NodeDataSize:=SizeOf(TTreeData);
  setlength(VSTVendorNodes,0);
  setlength(VSTTypeNodes,0);

  ///////////////////////////////////////////////////////////////////////////
  // Geräte hinzufügen
  for i:=0 to length(geraetesteuerung.DevicePrototyp)-1 do
  begin
    vendornodeok:=-1;
    typenodeok:=-1;
    // Herausfinden, ob für Vendor schon ein RootNode vorhanden ist
    for j:=0 to length(VSTVendorNodes)-1 do
    begin
      Data:=VST.GetNodeData(VSTVendorNodes[j]);
      if (Data^.Caption=geraetesteuerung.DevicePrototyp[i].vendor) then
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
      Data^.Caption:=geraetesteuerung.DevicePrototyp[i].Vendor;
      Data^.ID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');

      setlength(VSTVendorNodes, length(VSTVendorNodes)+1);
      setlength(VSTTypeNodes, length(VSTTypeNodes)+1);
      VSTVendorNodes[length(VSTVendorNodes)-1]:=vendornode;
      vendornodeok:=length(VSTVendorNodes)-1;
    end;

    // Herausfinden, ob für Type schon ein Sub-Node vorhanden ist
    for j:=0 to length(VSTTypeNodes[vendornodeok])-1 do
    begin
      Data:=VST.GetNodeData(VSTTypeNodes[vendornodeok][j]);
      if (Data^.Caption=geraetesteuerung.DevicePrototyp[i].DeviceName) then
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
      Data^.Caption:=geraetesteuerung.DevicePrototyp[i].DeviceName;
      Data^.Beschreibung:=geraetesteuerung.DevicePrototyp[i].Beschreibung;
      Data^.Kanalzahl:=geraetesteuerung.DevicePrototyp[i].MaxChan;
      Data^.Autor:=geraetesteuerung.DevicePrototyp[i].Author;
      Data^.ID:=geraetesteuerung.DevicePrototyp[i].ID;

      setlength(VSTTypeNodes[vendornodeok], length(VSTTypeNodes[vendornodeok])+1);
      VSTTypeNodes[vendornodeok][length(VSTTypeNodes[vendornodeok])-1]:=typenode;
//      typenodeok:=length(VSTTypeNodes[vendornodeok])-1;
    end;
  end;

  VST.EndUpdate;
end;

procedure Tadddevice.checkinformations;
var
  i,j,l:integer;
  Data: PTreeData;
  SomethingSelected:boolean;
begin
  DeviceSelectionOK:=false;

  SomethingSelected:=false;
  for i:=0 to length(VSTTypeNodes)-1 do
  for j:=0 to length(VSTTypeNodes[i])-1 do
  if VST.Selected[VSTTypeNodes[i][j]] then
  begin
    Data:=VST.GetNodeData(VSTTypeNodes[i][j]);

    if Data^.NodeType=1 then
    for l:=0 to length(geraetesteuerung.DevicePrototyp)-1 do
    begin
      if IsEqualGUID(Data^.ID, geraetesteuerung.DevicePrototyp[l].ID) then
      begin
        //VST.Selected[VSTTypeNodes[i][j]] // Boolean
        SelectedPrototype:=geraetesteuerung.DevicePrototyp[l].ID;
        DeviceSelectionOK:=true;

        if FileExists(mainform.pcdimmerdirectory+'Devicepictures\'+geraetesteuerung.DevicePrototyp[GetDevicePositionInDeviceArray(@geraetesteuerung.DevicePrototyp[l].ID)].Bildadresse) then
          image1.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\'+geraetesteuerung.DevicePrototyp[GetDevicePositionInDeviceArray(@geraetesteuerung.DevicePrototyp[l].ID)].Bildadresse)
        else
          image1.Picture:=standardpicture.Picture;
        namelabel.Caption:=geraetesteuerung.DevicePrototyp[GetDevicePositionInDeviceArray(@geraetesteuerung.DevicePrototyp[l].ID)].Name;
        beschreibunglabel.Caption:=geraetesteuerung.DevicePrototyp[GetDevicePositionInDeviceArray(@geraetesteuerung.DevicePrototyp[l].ID)].Beschreibung;
        vendorlabel.Caption:=geraetesteuerung.DevicePrototyp[GetDevicePositionInDeviceArray(@geraetesteuerung.DevicePrototyp[l].ID)].Vendor;
        authorlabel.Caption:=geraetesteuerung.DevicePrototyp[GetDevicePositionInDeviceArray(@geraetesteuerung.DevicePrototyp[l].ID)].Author;
        maxchanlabel.Caption:=inttostr(geraetesteuerung.DevicePrototyp[GetDevicePositionInDeviceArray(@geraetesteuerung.DevicePrototyp[l].ID)].MaxChan);
        dateilabel.Caption:=ExtractFileName(geraetesteuerung.DevicePrototyp[GetDevicePositionInDeviceArray(@geraetesteuerung.DevicePrototyp[l].ID)].ddffilename);

        SomethingSelected:=true;
        break;
      end;
    end;
  end;

  if not SomethingSelected then
  begin
    image1.Picture.Bitmap.Canvas.Pen.Color:=clBtnFace;
    image1.Picture.Bitmap.Canvas.Brush.Color:=clBtnFace;
    image1.Picture.Bitmap.Canvas.Rectangle(0,0,64,64);
    namelabel.Caption:='-';
    beschreibunglabel.Caption:='-';
    vendorlabel.Caption:='-';
    authorlabel.Caption:='-';
    maxchanlabel.Caption:='-';
    dateilabel.Caption:='-';
  end;
end;

function Tadddevice.GetDevicePositionInDeviceArray(ID: PGUID):Integer;
var
  i:integer;
begin
  Result:=-1;
  for i:=0 to length(geraetesteuerung.DevicePrototyp)-1 do
  begin
    if IsEqualGUID(ID^,geraetesteuerung.DevicePrototyp[i].ID) then
    begin
      Result:=i;
      exit;
    end;
  end;
end;

procedure Tadddevice.Button3Click(Sender: TObject);
begin
  LoadDDFs;
  TreeviewRefresh;
end;

procedure Tadddevice.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tadddevice.Edit1Enter(Sender: TObject);
begin
  if Edit1.text=_('Suchtext hier eingeben...') then
  begin
    Edit1.Text:='';
    Edit1.Font.Color:=clBlack;
  end;
end;

procedure Tadddevice.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text='' then
  begin
    Edit1.Text:=_('Suchtext hier eingeben...');
    Edit1.Font.Color:=clGray;
  end;
end;

procedure Tadddevice.Edit3Change(Sender: TObject);
var
  s:string;
  i, temp, newaddress:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  newaddress:=strtoint(Edit3.text);

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
    if dipstate[i] then
      Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPON.Picture
    else
      Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPOFF.Picture;
end;

procedure Tadddevice.Button4Click(Sender: TObject);
begin
  ddfeditorform.show;
end;

procedure Tadddevice.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return then
    ModalResult:=mrOk;
end;

procedure Tadddevice.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tadddevice.Timer1Timer(Sender: TObject);
begin
  Timer1.enabled:=false;

  if length(geraetesteuerung.DevicePrototyp)=0 then
    LoadDDFs;

  TreeviewRefresh;
end;

procedure Tadddevice.DIP1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;
  LSB,MSB:byte;
  temp:integer;
begin
  if (button=mbLeft) then
  begin
    for i:=1 to 10 do
    begin
      if Sender=Timage(FindComponent('DIP'+inttostr(i))) then
      begin
        if dipstate[i] then
        begin
          // ausschalten
          dipstate[i]:=false;
          Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPOFF.Picture;
        end else
        begin
          // einschalten
          dipstate[i]:=true;
          Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPON.Picture;
        end;
      end;
    end;

    LSB:=0;
    if dipstate[1] then LSB:=LSB or 1;
    if dipstate[2] then LSB:=LSB or 2;
    if dipstate[3] then LSB:=LSB or 4;
    if dipstate[4] then LSB:=LSB or 8;
    if dipstate[5] then LSB:=LSB or 16;
    if dipstate[6] then LSB:=LSB or 32;
    if dipstate[7] then LSB:=LSB or 64;
    if dipstate[8] then LSB:=LSB or 128;
    MSB:=0;
    if dipstate[9] then MSB:=MSB or 1;
    if dipstate[10] then MSB:=MSB or 2;
    temp:=MSB;
    temp:=temp shl 8;
    temp:=temp+LSB;

    if (temp > 0) then
      Edit3.Text:=inttostr(temp);
  end;
end;

function CopyFileEx(const ASource, ADest: string; ARenameCheck: boolean = false): boolean;
var
  sh: TSHFileOpStruct;
begin
  sh.Wnd := Application.Handle;
  sh.wFunc := FO_COPY;

  // String muss mit #0#0 Terminiert werden, um das Listenende zu setzen
  sh.pFrom := PChar(ASource + #0);
  sh.pTo := PChar(ADest + #0);
  sh.fFlags := fof_Silent or fof_MultiDestFiles;
  if ARenameCheck then
    sh.fFlags := sh.fFlags or fof_RenameOnCollision;
  Result:=ShFileOperation(sh)=0;
end;

procedure Tadddevice.LoadDDFs;
var
  ddfliste:array of string;
  dateianzahlinverzeichnis,dateicounter:integer;
  i,j,k:integer;
  R,G,B:byte;
  SR: TSearchRec;
  tempstr:string;
begin
  setlength(ddfliste,0);
  setlength(geraetesteuerung.DevicePrototyp,0);

  ProgressScreenSmall.show;
  ProgressScreenSmall.Label1.Caption:=_('Suche DDFs...');
  ProgressScreenSmall.Label2.Caption:='';
  ProgressScreenSmall.ProgressBar1.Position:=0;
  ProgressScreenSmall.Refresh;

  progressbar1.Visible:=true;

{
  // Alte XML-DDFs verschieben
  if (FindFirst(mainform.pcdimmerdirectory+'\Devices\*.xml',faAnyFile-faDirectory,SR)=0) then
  begin
    repeat
      if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
      begin
        if not DirectoryExists(mainform.pcdimmerdirectory+'\Devices\XMLDDFs') then
          CreateDirectory(PChar(mainform.pcdimmerdirectory+'\Devices\XMLDDFs'), nil);
        CopyFileEx(mainform.pcdimmerdirectory+'\Devices\'+SR.Name, mainform.pcdimmerdirectory+'\Devices\XMLDDFs\'+SR.Name);
        DeleteFile(mainform.pcdimmerdirectory+'\Devices\'+SR.Name);
      end;
    until FindNext(SR)<>0;
    FindClose(SR);
  end;
}

  // DDFs auflisten
  dateianzahlinverzeichnis:=mainform.CountFiles(mainform.pcdimmerdirectory+'Devices\','*.pcddevc');
  dateicounter:=0;
  if (FindFirst(mainform.pcdimmerdirectory+'\Devices\*.pcddevc',faAnyFile-faDirectory,SR)=0) then
  begin
    repeat
      if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
      begin
        setlength(ddfliste,length(ddfliste)+1);
        setlength(geraetesteuerung.DevicePrototyp,length(geraetesteuerung.DevicePrototyp)+1);
        CreateGUID(geraetesteuerung.DevicePrototyp[length(geraetesteuerung.DevicePrototyp)-1].ID);
        ddfliste[length(ddfliste)-1]:=SR.Name;
        geraetesteuerung.DevicePrototyp[length(geraetesteuerung.DevicePrototyp)-1].ddffilename:=SR.Name;
        dateicounter:=dateicounter+1;

        if (round((dateicounter/dateianzahlinverzeichnis)*50) mod 10)=0 then
        begin
          progressbar1.Position:=round((dateicounter/dateianzahlinverzeichnis)*50);
          ProgressScreenSmall.Label2.Caption:=SR.Name;
          ProgressScreenSmall.ProgressBar1.Position:=round((dateicounter/dateianzahlinverzeichnis)*50);
          ProgressScreenSmall.Refresh;
        end;
      end;
    until FindNext(SR)<>0;
    FindClose(SR);
  end;

  ProgressScreenSmall.Label1.Caption:=_('Verarbeite DDFs...');
  ProgressScreenSmall.Refresh;

  // DDFs laden und auswerten
  dateicounter:=0;
  for i:=0 to length(ddfliste)-1 do
  begin
    dateicounter:=dateicounter+1;
    if (round((dateicounter/dateianzahlinverzeichnis)*50) mod 10)=0 then
    begin
      progressbar1.Position:=50+round((dateicounter/dateianzahlinverzeichnis)*50);
      ProgressScreenSmall.Label2.Caption:=ddfliste[i];
      ProgressScreenSmall.ProgressBar1.Position:=50+round((dateicounter/dateianzahlinverzeichnis)*50);
      ProgressScreenSmall.Refresh;
    end;

    XML.Xml.LoadFromFile(mainform.pcdimmerdirectory+'\Devices\'+ddfliste[i]);
    geraetesteuerung.DevicePrototyp[i].Bildadresse:=XML.XML.Root.Properties.Value('image');

    // nur zur Sicherheit
    geraetesteuerung.DevicePrototyp[i].DimmerOffValue:=0;
    geraetesteuerung.DevicePrototyp[i].DimmerMaxValue:=255;

    for j:=0 to XML.Xml.Root.Items.Count-1 do
    begin // <device>
      if (XML.XML.Root.Items[j].Name='information') then
      begin // <information>
        if (XML.Xml.Root.Items[j].Properties.Value('id', 'n/a')<>'PC_DIMMER') then
        begin
          ShowMessage(_('Die DDF-Datei "')+ddfliste[i]+_('" ist nicht zu dieser Version von PC_DIMMER kompatibel.')+#13#10+#13#10+_('DMXControl-DDFs können aufgrund konzeptioneller Unterschiede nicht verwendet werden.'));
          continue;
        end;

        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          if XML.XML.Root.Items[j].Items[k].Name='name' then
          begin
            geraetesteuerung.DevicePrototyp[i].Name:=XML.XML.Root.Items[j].Items[k].Value;
            geraetesteuerung.DevicePrototyp[i].DeviceName:=XML.XML.Root.Items[j].Items[k].Value;
          end;
          if XML.XML.Root.Items[j].Items[k].Name='vendor' then
            geraetesteuerung.DevicePrototyp[i].vendor:=XML.XML.Root.Items[j].Items[k].Value;
          if XML.XML.Root.Items[j].Items[k].Name='author' then
            geraetesteuerung.DevicePrototyp[i].author:=XML.XML.Root.Items[j].Items[k].Value;
          if XML.XML.Root.Items[j].Items[k].Name='description' then
            geraetesteuerung.DevicePrototyp[i].Beschreibung:=XML.XML.Root.Items[j].Items[k].Value;
        end;
      end;
      if XML.XML.Root.Items[j].Name='channels' then
      begin // <channels>
        geraetesteuerung.DevicePrototyp[i].MaxChan:=XML.XML.Root.Items[j].Items.Count;
        setlength(geraetesteuerung.DevicePrototyp[i].kanalminvalue,geraetesteuerung.DevicePrototyp[i].MaxChan);
        setlength(geraetesteuerung.DevicePrototyp[i].kanalmaxvalue,geraetesteuerung.DevicePrototyp[i].MaxChan);
        setlength(geraetesteuerung.DevicePrototyp[i].kanaltyp,geraetesteuerung.DevicePrototyp[i].MaxChan);
        setlength(geraetesteuerung.DevicePrototyp[i].kanalname,geraetesteuerung.DevicePrototyp[i].MaxChan);
        setlength(geraetesteuerung.DevicePrototyp[i].kanalfade,geraetesteuerung.DevicePrototyp[i].MaxChan);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          geraetesteuerung.DevicePrototyp[i].kanalname[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'));
          geraetesteuerung.DevicePrototyp[i].kanalfade[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('fade'))='yes';
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('DIMMER') then geraetesteuerung.DevicePrototyp[i].hasDimmer:=true;
          if (lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('VIRTUALRGBDIMMER')) or
            (lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('VIRTUALRGBADIMMER')) or
            (lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('VIRTUALRGBAWDIMMER')) then
          begin
            geraetesteuerung.DevicePrototyp[i].hasVirtualRGBAWDimmer:=true;
            geraetesteuerung.DevicePrototyp[i].hasDimmer:=true;
            geraetesteuerung.DevicePrototyp[i].kanaltyp[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=lowercase('DIMMER'); // VirtualRGBDimmer als normalen DIMMER maskieren
          end;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('R') then geraetesteuerung.DevicePrototyp[i].hasRGB:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('G') then geraetesteuerung.DevicePrototyp[i].hasRGB:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('B') then geraetesteuerung.DevicePrototyp[i].hasRGB:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('C') then geraetesteuerung.DevicePrototyp[i].hasCMY:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('M') then geraetesteuerung.DevicePrototyp[i].hasCMY:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('Y') then geraetesteuerung.DevicePrototyp[i].hasCMY:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('A') then geraetesteuerung.DevicePrototyp[i].hasAmber:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('W') then geraetesteuerung.DevicePrototyp[i].hasWhite:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('UV') then geraetesteuerung.DevicePrototyp[i].hasUV:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('PAN') then geraetesteuerung.DevicePrototyp[i].hasPANTILT:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('TILT') then geraetesteuerung.DevicePrototyp[i].hasPANTILT:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('COLOR1') then geraetesteuerung.DevicePrototyp[i].hasColor:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('COLOR2') then geraetesteuerung.DevicePrototyp[i].hasColor2:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('GOBO1') then geraetesteuerung.DevicePrototyp[i].hasGobo:=true;
          if lowercase(XML.XML.Root.Items[j].Items[k].Properties.Value('type'))=lowercase('GOBO2') then geraetesteuerung.DevicePrototyp[i].hasGobo2:=true;
          geraetesteuerung.DevicePrototyp[i].KanalMinValue[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('minvalue'));
          geraetesteuerung.DevicePrototyp[i].KanalMaxValue[strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('channel'))]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('maxvalue'));
        end;
      end;
      if XML.XML.Root.Items[j].Name='amber' then
      begin // <amber>
        geraetesteuerung.DevicePrototyp[i].UseAmberMixing:=(lowercase(XML.XML.Root.Items[j].Properties.Value('UseAmberMixing'))='yes');
        geraetesteuerung.DevicePrototyp[i].AmberMixingCompensateRG:=(lowercase(XML.XML.Root.Items[j].Properties.Value('AmberMixingCompensateRG'))='yes');
        geraetesteuerung.DevicePrototyp[i].AmberMixingCompensateBlue:=(lowercase(XML.XML.Root.Items[j].Properties.Value('AmberMixingCompensateBlue'))='yes');
        geraetesteuerung.DevicePrototyp[i].AmberRatioR:=XML.XML.Root.Items[j].Properties.IntValue('AmberColorR');
        geraetesteuerung.DevicePrototyp[i].AmberRatioG:=XML.XML.Root.Items[j].Properties.IntValue('AmberColorG');
      end;
      if XML.XML.Root.Items[j].Name='colors' then
      begin // <colors>
        setlength(geraetesteuerung.DevicePrototyp[i].colors,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colorlevels,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colorendlevels,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colornames,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          geraetesteuerung.DevicePrototyp[i].colors[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('r')) + strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('g')) shl 8 + strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('b')) shl 16;
          geraetesteuerung.DevicePrototyp[i].colornames[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          geraetesteuerung.DevicePrototyp[i].colorlevels[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          geraetesteuerung.DevicePrototyp[i].colorendlevels[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(geraetesteuerung.DevicePrototyp[i].colorlevels[k])));
        end;
      end;
      if XML.XML.Root.Items[j].Name='colors2' then
      begin // <colors2>
        setlength(geraetesteuerung.DevicePrototyp[i].colors2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colorlevels2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colorendlevels2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].colornames2,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          geraetesteuerung.DevicePrototyp[i].colors2[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('r')) + strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('g')) shl 8 + strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('b')) shl 16;
          geraetesteuerung.DevicePrototyp[i].colornames2[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          geraetesteuerung.DevicePrototyp[i].colorlevels2[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          geraetesteuerung.DevicePrototyp[i].colorendlevels2[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(geraetesteuerung.DevicePrototyp[i].colorlevels2[k])));
        end;
      end;
      if XML.XML.Root.Items[j].Name='shutter' then
      begin // <shutter>
        geraetesteuerung.DevicePrototyp[i].ShutterOpenValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OpenValue'));
        geraetesteuerung.DevicePrototyp[i].ShutterCloseValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('CloseValue'));
        geraetesteuerung.DevicePrototyp[i].ShutterChannel:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;
      if XML.XML.Root.Items[j].Name='strobe' then
      begin // <strobe>
        geraetesteuerung.DevicePrototyp[i].StrobeOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].StrobeMinValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MinValue'));
        geraetesteuerung.DevicePrototyp[i].StrobeMaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MaxValue'));
        geraetesteuerung.DevicePrototyp[i].StrobeChannel:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;
      if (XML.XML.Root.Items[j].Name='dimmer') or (XML.XML.Root.Items[j].Name='virtualrgbadimmer') then
      begin // <dimmer>
        geraetesteuerung.DevicePrototyp[i].DimmerOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].DimmerMaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MaxValue'));
      end;
      if XML.XML.Root.Items[j].Name='gobo1rot' then
      begin // <gobo1rot>
        geraetesteuerung.DevicePrototyp[i].Gobo1RotLeftminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMinValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo1RotLeftValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMaxValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo1RotOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo1RotRightminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMinValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo1RotRightValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMaxValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo1RotChannel:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;
      if XML.XML.Root.Items[j].Name='gobo2rot' then
      begin // <gobo2rot>
        geraetesteuerung.DevicePrototyp[i].Gobo2RotLeftminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMinValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo2RotLeftValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMaxValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo2RotOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo2RotRightminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMinValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo2RotRightValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMaxValue'));
        geraetesteuerung.DevicePrototyp[i].Gobo2RotChannel:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;
      if XML.XML.Root.Items[j].Name='prismarot' then
      begin // <PrismaRotation>
        geraetesteuerung.DevicePrototyp[i].PrismaRotLeftminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMinValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaRotLeftmaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('LeftMaxValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaRotOffValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OffValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaRotRightminValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMinValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaRotRightmaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('RightMaxValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaRotChannel:=XML.XML.Root.Items[j].Properties.Value('ChannelName');
      end;
      if XML.XML.Root.Items[j].Name='prisma' then
      begin // <Prisma>
        geraetesteuerung.DevicePrototyp[i].PrismaSingleValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('SingleValue'));
        geraetesteuerung.DevicePrototyp[i].PrismaTripleValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('TripleValue'));
      end;
      if XML.XML.Root.Items[j].Name='iris' then
      begin // <Iris>
        geraetesteuerung.DevicePrototyp[i].IrisCloseValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('CloseValue'));
        geraetesteuerung.DevicePrototyp[i].IrisOpenValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('OpenValue'));
        geraetesteuerung.DevicePrototyp[i].IrisMinValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MinValue'));
        geraetesteuerung.DevicePrototyp[i].IrisMaxValue:=strtoint(XML.XML.Root.Items[j].Properties.Value('MaxValue'));
      end;
      if XML.XML.Root.Items[j].Name='gobos' then
      begin // <channels>
        setlength(geraetesteuerung.DevicePrototyp[i].gobos,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].gobolevels,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].goboendlevels,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].gobonames,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          geraetesteuerung.DevicePrototyp[i].gobos[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('filename');
          geraetesteuerung.DevicePrototyp[i].gobonames[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          geraetesteuerung.DevicePrototyp[i].gobolevels[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          geraetesteuerung.DevicePrototyp[i].goboendlevels[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(geraetesteuerung.DevicePrototyp[i].gobolevels[k])));
        end;
      end;
      if XML.XML.Root.Items[j].Name='gobos2' then
      begin // <channels>
        setlength(geraetesteuerung.DevicePrototyp[i].gobos2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].gobolevels2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].goboendlevels2,XML.XML.Root.Items[j].Items.Count);
        setlength(geraetesteuerung.DevicePrototyp[i].gobonames2,XML.XML.Root.Items[j].Items.Count);
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          geraetesteuerung.DevicePrototyp[i].gobos2[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('filename');
          geraetesteuerung.DevicePrototyp[i].gobonames2[k]:=XML.XML.Root.Items[j].Items[k].Properties.Value('name');
          geraetesteuerung.DevicePrototyp[i].gobolevels2[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('value'));
          geraetesteuerung.DevicePrototyp[i].goboendlevels2[k]:=strtoint(XML.XML.Root.Items[j].Items[k].Properties.Value('valueend',inttostr(geraetesteuerung.DevicePrototyp[i].gobolevels2[k])));
        end;
      end;
    end;

    if FileExists(copy(mainform.pcdimmerdirectory+'\Devices\'+ddfliste[i],0,length(mainform.pcdimmerdirectory+'\Devices\'+ddfliste[i])-3)+'colorlist') then
    begin
      listbox1.Items.LoadFromFile(copy(mainform.pcdimmerdirectory+'\Devices\'+ddfliste[i],0,length(mainform.pcdimmerdirectory+'\Devices\'+ddfliste[i])-3)+'colorlist');
      setlength(geraetesteuerung.DevicePrototyp[i].colors,listbox1.Items.Count);
      setlength(geraetesteuerung.DevicePrototyp[i].colorlevels,listbox1.Items.Count);
      setlength(geraetesteuerung.DevicePrototyp[i].colorendlevels,listbox1.Items.Count);
      setlength(geraetesteuerung.DevicePrototyp[i].colornames,listbox1.Items.Count);
      for j:=0 to listbox1.items.count-1 do
      begin
        tempstr:=listbox1.items[j];
        R:=strtoint(copy(tempstr,0,pos(',',tempstr)-1));
        tempstr:=copy(tempstr,pos(',',tempstr)+1,length(tempstr));
        G:=strtoint(copy(tempstr,0,pos(',',tempstr)-1));
        tempstr:=copy(tempstr,pos(',',tempstr)+1,length(tempstr));
        B:=strtoint(copy(tempstr,0,pos(',',tempstr)-1));
        geraetesteuerung.DevicePrototyp[i].colors[j]:=R + G shl 8 + B shl 16;

        tempstr:=copy(tempstr,pos(',',tempstr)+1,length(tempstr));
        geraetesteuerung.DevicePrototyp[i].colornames[j]:=copy(tempstr,0,pos(',',tempstr)-1);
        tempstr:=copy(tempstr,pos(',',tempstr)+1,length(tempstr));
        geraetesteuerung.DevicePrototyp[i].colorlevels[j]:=strtoint(tempstr);
        tempstr:=copy(tempstr,pos(',',tempstr)+1,length(tempstr));
        geraetesteuerung.DevicePrototyp[i].colorendlevels[j]:=strtoint(tempstr);
      end;
    end;
  end;

  ProgressScreenSmall.Label1.Caption:=_('Fertig.');
  ProgressScreenSmall.Label2.Caption:=_('DDFs geladen und ausgewertet.');
  ProgressScreenSmall.ProgressBar1.Position:=100;
  ProgressScreenSmall.Refresh;
  ProgressScreenSmall.Timer1.Enabled:=true;
  progressbar1.Visible:=false;
end;

procedure Tadddevice.CreateParams(var Params:TCreateParams);
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

procedure Tadddevice.Edit2Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure Tadddevice.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
    SuchTimer.Enabled:=true;
end;

procedure Tadddevice.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PTreeData;
begin
  case Kind of ikNormal, ikSelected:
    case Column of
      0:
      begin
        Data:=VST.GetNodeData(Node);

        case Data^.NodeType of
          0: ImageIndex:=1;
          1: ImageIndex:=25;
        end;
      end else
      begin
        ImageIndex:=-1;
      end;
    end;
  end;
end;

procedure Tadddevice.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PTreeData;
begin
  case Column of
    0:
    begin
      // Vendor, Typ und Name anzeigen
      Data:=VST.GetNodeData(Node);
      CellText:=Data^.Caption;
    end;
    1:
    begin
      // Kanalanzahl
      Data:=VST.GetNodeData(Node);
      if Data^.NodeType=1 then
        CellText:=inttostr(Data^.Kanalzahl)
      else
        CellText:='';
    end;
    2:
    begin
      // Beschreibung
      Data:=VST.GetNodeData(Node);
      if Data^.NodeType=1 then
        CellText:=Data^.Beschreibung
      else
        CellText:='';
    end;
    3:
    begin
      // Autor
      Data:=VST.GetNodeData(Node);
      if Data^.NodeType=1 then
        CellText:=Data^.Autor
      else
        CellText:='';
    end;
  end;
end;

procedure Tadddevice.VSTKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  checkinformations;
end;

procedure Tadddevice.VSTMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  checkinformations;
end;

procedure Tadddevice.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PTreeData;
begin
  with TargetCanvas do
  begin
    Data:=VST.GetNodeData(Node);
    if ((Data^.NodeType=0) and (Data^.Caption='Generic')) or ((Data^.NodeType=1) and (Data^.Caption='Dimmer')) or
      ((Data^.NodeType=1) and (Data^.Caption='Switch')) or ((Data^.NodeType=1) and (Data^.Caption='RGB Scheinwerfer')) then
    begin
      // Generic
      Font.Style:=[fsBold];
      Font.Color:=clGreen;
    end else
    begin
      // Alle anderen
      Font.Style:=[];
      Font.Color:=clBlack;
    end;
  end;
end;

procedure Tadddevice.VSTChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  checkinformations;
end;

procedure Tadddevice.SuchTimerTimer(Sender: TObject);
var
  i,j:integer;
  Suchtext:string;
  Data, Data2: PTreeData;
begin
  SuchTimer.Enabled:=false;
  VST.FullCollapse;
  Suchtext:=lowercase(Edit1.Text);

  for i:=0 to length(VSTTypeNodes)-1 do
  for j:=0 to length(VSTTypeNodes[i])-1 do
  begin
    Data:=VST.GetNodeData(VSTTypeNodes[i][j]);
    Data2:=VST.GetNodeData(VSTVendorNodes[i]);

    if (pos(suchtext, lowercase(Data2^.Caption))>0) or (pos(suchtext, lowercase(Data^.Caption))>0) or (pos(suchtext, lowercase(Data^.Beschreibung))>0) or (pos(suchtext, lowercase(Data^.Autor))>0) then
    begin
      VST.Expanded[VSTTypeNodes[i][j].Parent]:=true;
      VST.Expanded[VSTTypeNodes[i][j]]:=true;
      VST.Selected[VSTTypeNodes[i][j]]:=true;
      VST.FocusedNode:=VSTTypeNodes[i][j];
    end;
  end;
  checkinformations;
end;

procedure Tadddevice.minusClick(Sender: TObject);
begin
  VST.FullCollapse;
end;

procedure Tadddevice.plusClick(Sender: TObject);
begin
  VST.FullExpand;
end;

end.
