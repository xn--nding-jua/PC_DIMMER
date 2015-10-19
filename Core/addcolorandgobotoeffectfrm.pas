unit addcolorandgobotoeffectfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, dxGDIPlusClasses, JvExControls, JvGradient,
  gnugettext;

type
  Taddcolorandgobotoeffectform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Panel2: TPanel;
    nextbtn: TButton;
    Notebook1: TNotebook;
    Panel5: TPanel;
    Panel4: TPanel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    ListBox3: TListBox;
    Label1: TLabel;
    backbtn: TButton;
    Panel3: TPanel;
    Panel6: TPanel;
    Label4: TLabel;
    ListBox4: TListBox;
    Panel7: TPanel;
    Button1: TButton;
    ListBox5: TListBox;
    Label5: TLabel;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure nextbtnClick(Sender: TObject);
    procedure backbtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    DeviceList, DeviceList2:array of TGUID;
  public
    { Public-Deklarationen }
    DeviceListForExport:array of TGUID;
    Kanaltyp:string;
  end;

var
  addcolorandgobotoeffectform: Taddcolorandgobotoeffectform;

implementation

uses PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

procedure Taddcolorandgobotoeffectform.FormShow(Sender: TObject);
var
  i:integer;
begin
  // Geräteliste aktualisieren
  listbox1.Items.Clear;
  setlength(DeviceList, 0);

  for i:=0 to length(mainform.devices)-1 do
  begin
    if mainform.devices[i].hasColor or mainform.devices[i].hasColor2 or mainform.devices[i].hasGobo or mainform.devices[i].hasGobo2 then
    begin
      setlength(DeviceList, length(DeviceList)+1);
      DeviceList[length(DeviceList)-1]:=mainform.devices[i].ID;

      if mainform.devices[i].MaxChan>1 then
        listbox1.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+'..'+inttostr(mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1)+', '+mainform.devices[i].DeviceName+']')
      else
        listbox1.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+', '+mainform.devices[i].DeviceName+']');
      end;
  end;
  if listbox1.Items.Count>0 then
    listbox1.Itemindex:=0;

  listbox2.Items.Clear;
  listbox3.Items.Clear;

  ListBox1MouseUp(nil, mbLeft, [], 0, 0);
end;

procedure Taddcolorandgobotoeffectform.ListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  myPosition:integer;
begin
  listbox2.Items.Clear;
  listbox3.Items.Clear;

  if listbox1.Items.Count>0 then
  begin
    myPosition:=geraetesteuerung.GetDevicePositionInDeviceArray(@DeviceList[listbox1.itemindex]);

    if mainform.devices[myPosition].hasGobo then
      listbox2.items.add(_('Goborad 1'));
    if mainform.devices[myPosition].hasGobo2 then
      listbox2.items.add(_('Goborad 2'));
    if mainform.devices[myPosition].hasColor then
      listbox2.items.add(_('Farbrad 1'));
    if mainform.devices[myPosition].hasColor2 then
      listbox2.items.add(_('Farbrad 2'));
  end;
  
  if listbox2.Items.Count>0 then
  begin
    Listbox2.ItemIndex:=0;
    ListBox2MouseUp(nil, mbLeft, [], 0, 0);
  end;
end;

procedure Taddcolorandgobotoeffectform.ListBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  myPosition:integer;
  i:integer;
begin
  listbox3.Items.Clear;

  if listbox1.Items.count>0 then
  begin
    myPosition:=geraetesteuerung.GetDevicePositionInDeviceArray(@DeviceList[listbox1.itemindex]);

    if (listbox2.Items.Count>0) and (listbox2.Itemindex>-1) then
    begin
      if listbox2.Items[listbox2.ItemIndex]=_('Goborad 1') then
      begin
        Kanaltyp:='gobo1';
        for i:=0 to length(mainform.Devices[myPosition].gobos)-1 do
        begin
          listbox3.Items.Add(mainform.Devices[myPosition].gobonames[i]);
        end;
      end else if listbox2.Items[listbox2.ItemIndex]=_('Goborad 2') then
      begin
        Kanaltyp:='gobo2';
        for i:=0 to length(mainform.Devices[myPosition].gobos2)-1 do
        begin
          listbox3.Items.Add(mainform.Devices[myPosition].gobonames2[i]);
        end;
      end else if listbox2.Items[listbox2.ItemIndex]=_('Farbrad 1') then
      begin
        Kanaltyp:='color1';
        for i:=0 to length(mainform.Devices[myPosition].colors)-1 do
        begin
          listbox3.Items.Add(mainform.Devices[myPosition].colornames[i]);
        end;
      end else if listbox2.Items[listbox2.ItemIndex]=_('Farbrad 2') then
      begin
        Kanaltyp:='color2';
        for i:=0 to length(mainform.Devices[myPosition].colors2)-1 do
        begin
          listbox3.Items.Add(mainform.Devices[myPosition].colornames2[i]);
        end;
      end;
    end;
  end;
  
  if listbox3.Items.Count>0 then
  begin
    Listbox3.ItemIndex:=0;
    listbox3.SelectAll;
    nextbtn.Enabled:=true;
  end;
end;

procedure Taddcolorandgobotoeffectform.ListBox1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  myPosition:integer;
begin
  listbox2.Items.Clear;
  listbox3.Items.Clear;

  myPosition:=geraetesteuerung.GetDevicePositionInDeviceArray(@DeviceList[listbox1.itemindex]);

  if listbox1.Items.Count>0 then
  begin
    if mainform.devices[myPosition].hasGobo then
      listbox2.items.add(_('Goborad 1'));
    if mainform.devices[myPosition].hasGobo2 then
      listbox2.items.add(_('Goborad 2'));
    if mainform.devices[myPosition].hasColor then
      listbox2.items.add(_('Farbrad 1'));
    if mainform.devices[myPosition].hasColor2 then
      listbox2.items.add(_('Farbrad 2'));
  end;
  
  if listbox2.Items.Count>0 then
  begin
    Listbox2.ItemIndex:=0;
    ListBox2MouseUp(nil, mbLeft, [], 0, 0);
  end;
end;

procedure Taddcolorandgobotoeffectform.ListBox2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  myPosition:integer;
  i:integer;
begin
  listbox3.Items.Clear;

  if listbox1.Items.count>0 then
  begin
    myPosition:=geraetesteuerung.GetDevicePositionInDeviceArray(@DeviceList[listbox1.itemindex]);

    if (listbox2.Items.Count>0) and (listbox2.Itemindex>-1) then
    begin
      if listbox2.Items[listbox2.ItemIndex]=_('Goborad 1') then
      begin
        Kanaltyp:='gobo1';
        for i:=0 to length(mainform.Devices[myPosition].gobos)-1 do
        begin
          listbox3.Items.Add(mainform.Devices[myPosition].gobonames[i]);
        end;
      end else if listbox2.Items[listbox2.ItemIndex]=_('Goborad 2') then
      begin
        Kanaltyp:='gobo2';
        for i:=0 to length(mainform.Devices[myPosition].gobos2)-1 do
        begin
          listbox3.Items.Add(mainform.Devices[myPosition].gobonames2[i]);
        end;
      end else if listbox2.Items[listbox2.ItemIndex]=_('Farbrad 1') then
      begin
        Kanaltyp:='color1';
        for i:=0 to length(mainform.Devices[myPosition].colors)-1 do
        begin
          listbox3.Items.Add(mainform.Devices[myPosition].colornames[i]);
        end;
      end else if listbox2.Items[listbox2.ItemIndex]=_('Farbrad 2') then
      begin
        Kanaltyp:='color2';
        for i:=0 to length(mainform.Devices[myPosition].colors2)-1 do
        begin
          listbox3.Items.Add(mainform.Devices[myPosition].colornames2[i]);
        end;
      end;
    end;
  end;
  
  if listbox3.Items.Count>0 then
  begin
    Listbox3.ItemIndex:=0;
    listbox3.SelectAll;
    nextbtn.Enabled:=true;
  end;
end;

procedure Taddcolorandgobotoeffectform.ListBox3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  nextbtn.enabled:=(listbox3.SelCount>0);
end;

procedure Taddcolorandgobotoeffectform.ListBox3KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  nextbtn.enabled:=(listbox3.SelCount>0);
end;

procedure Taddcolorandgobotoeffectform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Taddcolorandgobotoeffectform.nextbtnClick(Sender: TObject);
var
  myPosition:integer;
  i:integer;
begin
  if notebook1.PageIndex=0 then
  begin
    notebook1.PageIndex:=1;
    backbtn.caption:=_('< Zurück');
    nextbtn.Caption:=_('Fertig');

    listbox4.Items.Clear;
    setlength(DeviceList2, 0);
    myPosition:=geraetesteuerung.GetDevicePositionInDeviceArray(@DeviceList[listbox1.itemindex]);
    for i:=0 to length(mainform.devices)-1 do
    begin
      if (mainform.Devices[i].Vendor=mainform.devices[myposition].Vendor) and (mainform.devices[i].DeviceName=mainform.devices[myPosition].DeviceName) and (myposition<>i) then
      begin
        // Gleicher Gerätetyp, aber anderes Gerät
        setlength(DeviceList2, length(DeviceList2)+1);
        DeviceList2[length(DeviceList2)-1]:=mainform.devices[i].ID;
        if mainform.devices[i].MaxChan>1 then
        begin
          listbox4.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+'..'+inttostr(mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1)+', '+mainform.devices[i].DeviceName+']');
        end else
        begin
          listbox4.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+', '+mainform.devices[i].DeviceName+']');
        end;
      end;
    end;

    listbox5.Items.Clear;
    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      if mainform.DeviceGroups[i].Beschreibung<>'' then
        listbox5.items.add(mainform.DeviceGroups[i].Name+' ('+mainform.DeviceGroups[i].Beschreibung+')')
      else
        listbox5.items.add(mainform.DeviceGroups[i].Name);
    end;
  end else if notebook1.PageIndex=1 then
  begin
    // Geräteliste erstellen für Effektschritte

    setlength(DeviceListForExport, 1);
    DeviceListForExport[0]:=DeviceList[listbox1.itemindex];

    for i:=0 to listbox4.Items.Count-1 do
    begin
      if listbox4.Selected[i] then
      begin
        setlength(DeviceListForExport, length(DeviceListForExport)+1);
        DeviceListForExport[length(DeviceListForExport)-1]:=DeviceList2[i];
      end;
    end;

    for i:=0 to listbox5.Items.Count-1 do
    begin
      if listbox5.Selected[i] then
      begin
        setlength(DeviceListForExport, length(DeviceListForExport)+1);
        DeviceListForExport[length(DeviceListForExport)-1]:=mainform.devicegroups[i].ID;
      end;
    end;

    ModalResult:=mrOK;
  end;
end;

procedure Taddcolorandgobotoeffectform.backbtnClick(Sender: TObject);
begin
  if notebook1.PageIndex=0 then
  begin
    ModalResult:=mrCancel;
  end else if notebook1.PageIndex=1 then
  begin
    notebook1.PageIndex:=0;
    backbtn.Caption:=_('Abbrechen');
    nextbtn.Caption:=_('Weiter >');
  end;
end;

procedure Taddcolorandgobotoeffectform.Button1Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to listbox4.Items.Count-1 do
    listbox4.Selected[i]:=false;
end;

procedure Taddcolorandgobotoeffectform.Button2Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to listbox5.Items.Count-1 do
    listbox5.Selected[i]:=false;
end;

end.
