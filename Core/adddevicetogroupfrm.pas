unit adddevicetogroupfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, gnugettext, Buttons, PngBitBtn;

type
  Tadddevicetogroupform = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Shape1: TShape;
    Shape2: TShape;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    geraetegruppenlbl: TLabel;
    upbtn: TPngBitBtn;
    downbtn: TPngBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure upbtnClick(Sender: TObject);
    procedure downbtnClick(Sender: TObject);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox1Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    DeviceAndGroupMode:boolean;
    GUIDList:array of TGUID;
  end;

var
  adddevicetogroupform: Tadddevicetogroupform;

implementation

uses PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

procedure Tadddevicetogroupform.FormShow(Sender: TObject);
var
  i:integer;
begin
  listbox1.Items.Clear;

  if DeviceAndGroupMode then
  begin
    // add devices AND groups without moving options
    setlength(GUIDList, length(mainform.devices)+length(mainform.DeviceGroups));

    for i:=0 to length(mainform.devices)-1 do
    begin
      GUIDList[i]:=mainform.devices[i].ID;

      if mainform.devices[i].MaxChan>1 then
        listbox1.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+'..'+inttostr(mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1)+', '+mainform.devices[i].DeviceName+']')
      else
        listbox1.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+', '+mainform.devices[i].DeviceName+']');
    end;
    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      GUIDList[length(mainform.devices)+i]:=mainform.DeviceGroups[i].ID;
      listbox1.Items.Add(_('Gerätegruppe')+': '+mainform.DeviceGroups[i].Name);
    end;
  end else
  begin
    // add devices and allow moving of devices
    setlength(GUIDList, length(mainform.devices));

    for i:=0 to length(mainform.devices)-1 do
    begin
      GUIDList[i]:=mainform.devices[i].ID;

      if mainform.devices[i].MaxChan>1 then
        listbox1.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+'..'+inttostr(mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1)+', '+mainform.devices[i].DeviceName+']')
      else
        listbox1.items.add(mainform.devices[i].Name+' ['+_('Adresse:')+' '+inttostr(mainform.devices[i].Startaddress)+', '+mainform.devices[i].DeviceName+']');
    end;

    upbtn.Enabled:=((listbox1.ItemIndex>0) and (listbox1.itemindex>-1));
    downbtn.Enabled:=((listbox1.ItemIndex<(listbox1.items.Count-1)) and (listbox1.itemindex>-1));
  end;

  panel5.visible:=not DeviceAndGroupMode;
end;

procedure Tadddevicetogroupform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tadddevicetogroupform.upbtnClick(Sender: TObject);
var
  ActualPosition:integer;
begin
  ActualPosition:=listbox1.ItemIndex;

  if ActualPosition<=0 then exit;

  geraetesteuerung.position:=mainform.devices[ActualPosition].ID;

  setlength(mainform.devices,length(mainform.devices)+1);

  // Obere Position ans Ende kopieren
  geraetesteuerung.CopyDevice(ActualPosition-1,length(mainform.devices)-1);
  // Aktuelle Position auf obere Position
  geraetesteuerung.CopyDevice(ActualPosition, ActualPosition-1);
  // Letzte Position auf aktuelle Position
  geraetesteuerung.CopyDevice(length(mainform.devices)-1,ActualPosition);

  setlength(mainform.devices,length(mainform.devices)-1);

  Listbox1.Items.Exchange(ActualPosition, ActualPosition-1);

  if geraetesteuerung.showing then
    geraetesteuerung.RefreshTreeNew;

  upbtn.Enabled:=((listbox1.ItemIndex>0) and (listbox1.itemindex>-1));
  downbtn.Enabled:=((listbox1.ItemIndex<(listbox1.items.Count-1)) and (listbox1.itemindex>-1));
end;

procedure Tadddevicetogroupform.downbtnClick(Sender: TObject);
var
  ActualPosition:integer;
begin
  ActualPosition:=Listbox1.ItemIndex;

  if ActualPosition<0 then exit;
  if ActualPosition>=(length(mainform.Devices)-1) then exit;

  geraetesteuerung.position:=mainform.devices[ActualPosition].ID;

  setlength(mainform.devices,length(mainform.devices)+1);

  // Untere Position ans Ende kopieren
  geraetesteuerung.CopyDevice(ActualPosition+1,length(mainform.devices)-1);
  // Aktuelle Position auf untere Position
  geraetesteuerung.CopyDevice(ActualPosition, ActualPosition+1);
  // Letzte Position auf aktuelle Position
  geraetesteuerung.CopyDevice(length(mainform.devices)-1,ActualPosition);

  setlength(mainform.devices,length(mainform.devices)-1);

  Listbox1.Items.Exchange(ActualPosition, ActualPosition+1);

  if geraetesteuerung.showing then
    geraetesteuerung.RefreshTreeNew;

  upbtn.Enabled:=((listbox1.ItemIndex>0) and (listbox1.itemindex>-1));
  downbtn.Enabled:=((listbox1.ItemIndex<(listbox1.items.Count-1)) and (listbox1.itemindex>-1));
end;

procedure Tadddevicetogroupform.ListBox1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  upbtn.Enabled:=((listbox1.ItemIndex>0) and (listbox1.itemindex>-1));
  downbtn.Enabled:=((listbox1.ItemIndex<(listbox1.items.Count-1)) and (listbox1.itemindex>-1));
end;

procedure Tadddevicetogroupform.ListBox1Click(Sender: TObject);
begin
  upbtn.Enabled:=((listbox1.ItemIndex>0) and (listbox1.itemindex>-1));
  downbtn.Enabled:=((listbox1.ItemIndex<(listbox1.items.Count-1)) and (listbox1.itemindex>-1));
end;

procedure Tadddevicetogroupform.CreateParams(var Params:TCreateParams);
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
