unit devicechannelselectionfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, gnugettext, VirtualTrees, Menus;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: byte; // 0=Vendor, 1=Type, 2=Device, 3=Channel
    DataType: integer; // 0=Devicechannel, 1=Groupchannel, 2=Befehlwert
    Caption:WideString;
    ID:TGUID;
    ChannelInDevice:integer;
  end;

  Tdevicechannelselectionform = class(TForm)
    Panel1: TPanel;
    OKBtn: TButton;
    Button2: TButton;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Panel3: TPanel;
    Edit1: TEdit;
    Button6: TButton;
    Button5: TButton;
    Panel4: TPanel;
    Button7: TButton;
    ShowDDFCheckbox: TCheckBox;
    Label1: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Edit4: TEdit;
    Label9: TLabel;
    VST: TVirtualStringTree;
    GroupBox3: TGroupBox;
    Button4: TButton;
    Button9: TButton;
    Button3: TButton;
    activatedmenu: TPopupMenu;
    AktuelleWerte1: TMenuItem;
    deaktivieren1: TMenuItem;
    selectedmenu: TPopupMenu;
    AktuellerKanalwert1: TMenuItem;
    wholescenemenu: TPopupMenu;
    beinhaltetnurseitletzterSzenegenderteKanle1: TMenuItem;
    beinhaltetnurderzeitselektierteGerte1: TMenuItem;
    beinhaltetseitletzterSzenegenderteKanleundaktuellselektierteGerte1: TMenuItem;
    beinhaltetalleKanle1: TMenuItem;
    GroupBox4: TGroupBox;
    ListBox2: TListBox;
    Button15: TButton;
    ChangedChannels: TTimer;
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure input_number(var pos:integer; var s:string);
    procedure input_number_minus(var pos:integer; var s:string);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure EditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
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
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VSTDblClick(Sender: TObject);
    procedure Button9MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AktuelleWerte1Click(Sender: TObject);
    procedure AktuellerKanalwert1Click(Sender: TObject);
    procedure beinhaltetnurseitletzterSzenegenderteKanle1Click(
      Sender: TObject);
    procedure beinhaltetnurderzeitselektierteGerte1Click(Sender: TObject);
    procedure beinhaltetseitletzterSzenegenderteKanleundaktuellselektierteGerte1Click(
      Sender: TObject);
    procedure beinhaltetalleKanle1Click(Sender: TObject);
    procedure ChangedChannelsTimer(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure Edit3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    VSTCurrentNode: PVirtualNode;
    VSTVendorNodes: array of PVirtualNode;
    VSTTypeNodes: array of array of PVirtualNode;
    VSTDeviceNodes: array of array of array of PVirtualNode;
    VSTChannelNodes: array of array of array of array of PVirtualNode;

    procedure CheckButtons;
    procedure RefreshTreeNew;
    procedure WMMoving(var AMsg: TMessage); message WM_MOVING;
  public
    { Public-Deklarationen }
  end;

procedure LockWindow(const Handle: HWND);
procedure UnLockWindow(const Handle: HWND);

var
  devicechannelselectionform: Tdevicechannelselectionform;

implementation

uses PCDIMMER, geraetesteuerungfrm, buehnenansicht, ddfwindowfrm;

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

procedure Tdevicechannelselectionform.Edit1Enter(Sender: TObject);
begin
  if Edit1.text=_('Suchtext hier eingeben...') then
  begin
    Edit1.Text:='';
    Edit1.Font.Color:=clBlack;
  end;
end;

procedure Tdevicechannelselectionform.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text='' then
  begin
    Edit1.Text:=_('Suchtext hier eingeben...');
    Edit1.Font.Color:=clGray;
  end;
end;

procedure Tdevicechannelselectionform.CheckButtons;
var
  i:integer;
  Data:PTreeData;
begin
  label3.caption:='...';
  label5.caption:='...';
  checkbox1.Checked:=false;

  checkbox1.Checked:=false;
  edit2.Text:='0';
  edit3.Text:='0';
  edit4.Text:='0';
  edit2.Enabled:=false;
  edit3.Enabled:=false;
  edit4.Enabled:=false;

  if VST.SelectedCount=0 then exit;
  Data:=VST.GetNodeData(VST.FocusedNode);
  if Data^.NodeType=2 then
  begin
    // Ist 3. Stufe
    if Data^.DataType=0 then
    begin
      // ist ein Gerät
      label3.caption:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID)].Name;

      DDFWindowDeviceScene.top:=devicechannelselectionform.Top;
      DDFWindowDeviceScene.left:=devicechannelselectionform.Left+devicechannelselectionform.Width;
      DDFWindowDeviceScene.loadddf(Data^.ID);
      devicechannelselectionform.SetFocus;
    end;

    if Data^.DataType=1 then
    begin
      // ist eine Gruppe
      label3.caption:=mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].Name;
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
      DDFWindowDeviceScene.top:=devicechannelselectionform.Top;
      DDFWindowDeviceScene.left:=devicechannelselectionform.Left+devicechannelselectionform.Width;
      DDFWindowDeviceScene.loadddf(Data^.ID);
      devicechannelselectionform.SetFocus;

      for i:=0 to length(mainform.DeviceChannelSelection)-1 do
      begin
        if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,Data^.ID) then
        begin
          Checkbox1.checked:=mainform.DeviceChannelSelection[i].ChanActive[Data^.ChannelInDevice];
          edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]/255*100));
          edit3.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]);
          edit4.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanDelay[Data^.ChannelInDevice]);
          edit4.Enabled:=Checkbox1.checked;
          edit3.Enabled:=Checkbox1.checked;
          edit2.Enabled:=Checkbox1.checked;
          break;
        end;
      end;
    end;

    if Data^.DataType=1 then
    begin
      // ist ein Gruppen-Kanal
      label3.caption:=mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].Name;
      label5.caption:=mainform.DeviceChannelNames[Data^.ChannelInDevice];

      for i:=0 to length(mainform.DeviceChannelSelection)-1 do
      begin
        if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].ID) then
        begin
          Checkbox1.checked:=mainform.DeviceChannelSelection[i].ChanActive[Data^.ChannelInDevice];
          edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]/255*100));
          edit3.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]);
          edit4.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanDelay[Data^.ChannelInDevice]);
          edit4.Enabled:=Checkbox1.checked;
          edit3.Enabled:=Checkbox1.checked;
          edit2.Enabled:=Checkbox1.checked;
          break;
        end;
      end;
    end;
  end;
{
  if Treeview1.SelectionCount>0 then
  if Treeview1.Selected.Parent.Index>-1 then // kein Vendor-Item
    if Treeview1.Selected.Parent.Parent.Index>-1 then // kein Device-Item
    begin
      if Treeview1.Selected.Parent.Parent.Parent.Index=-1 then
      begin
        if (Treeview1.Selected.Parent.Text='Gerätegruppen') then
        begin
          // ist eine Gruppe
          label3.caption:=mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(NodeGUID[TreeView1.Selected.Parent.Parent.Index][TreeView1.Selected.Parent.Index][Treeview1.Selected.index])].Name;

          if Treeview1.SelectionCount>0 then
          if Treeview1.Selected.Parent.Index>-1 then // kein Vendor-Item
          if Treeview1.Selected.Parent.Parent.Index>-1 then // kein Device-Item
          begin
            if Treeview1.Selected.Parent.Parent.Parent.Index>-1 then
            begin
              // ist ein Gruppen-Kanal
            end else
            begin
              // Ist eine Gruppe
            end;
          end;
        end else
        begin
          // ist ein Gerät
          label3.caption:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selected.Parent.Parent.Index][TreeView1.Selected.Parent.Index][Treeview1.Selected.index])].Name;

          if ShowDDFCheckbox.Checked then
          if Treeview1.SelectionCount>0 then
          if Treeview1.Selected.Parent.Index>-1 then // kein Vendor-Item
          if Treeview1.Selected.Parent.Parent.Index>-1 then // kein Device-Item
          begin
            if Treeview1.Selected.Parent.Parent.Parent.Index>-1 then
            begin
              // ist ein Kanal
              DDFWindowDeviceScene.top:=devicechannelselectionform.Top;
              DDFWindowDeviceScene.left:=devicechannelselectionform.Left+devicechannelselectionform.Width;
              DDFWindowDeviceScene.loadddf(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selected.Parent.Parent.Parent.Index][TreeView1.Selected.Parent.Parent.Index][Treeview1.Selected.Parent.index])].ID);
              devicechannelselectionform.SetFocus;
            end else
            begin
              // Ist ein Gerät
              DDFWindowDeviceScene.top:=devicechannelselectionform.Top;
              DDFWindowDeviceScene.left:=devicechannelselectionform.Left+devicechannelselectionform.Width;
              DDFWindowDeviceScene.loadddf(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selected.Parent.Parent.Index][TreeView1.Selected.Parent.Index][Treeview1.Selected.index])].ID);
              devicechannelselectionform.SetFocus;
            end;
          end;
        end;
      end;

      if Treeview1.Selected.Parent.Parent.Parent.Index>-1 then
      begin
        if (Treeview1.Selected.Parent.Parent.Text='Gerätegruppen') then
        begin
          // ist ein Gruppen-Kanal
          label3.caption:=mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(NodeGUID[TreeView1.Selected.Parent.Parent.Parent.Index][TreeView1.Selected.Parent.Parent.Index][Treeview1.Selected.Parent.index])].Name;
          label5.caption:=mainform.DeviceChannelNames[Treeview1.Selected.index];

          if Treeview1.SelectionCount>0 then
          if Treeview1.Selected.Parent.Index>-1 then // kein Vendor-Item
          if Treeview1.Selected.Parent.Parent.Index>-1 then // kein Device-Item
          begin
            if Treeview1.Selected.Parent.Parent.Parent.Index>-1 then
            begin
              // ist ein Kanal
            end else
            begin
              // Ist eine Gruppe
            end;
          end;

          for i:=0 to length(mainform.DeviceChannelSelection)-1 do
          begin
            if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(NodeGUID[TreeView1.Selected.Parent.Parent.Parent.Index][TreeView1.Selected.Parent.Parent.Index][Treeview1.Selected.Parent.index])].ID) then
            begin
              Checkbox1.checked:=mainform.DeviceChannelSelection[i].ChanActive[Treeview1.Selected.Index];
              edit2.Enabled:=Checkbox1.checked;
              edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[i].ChanValue[Treeview1.Selected.Index]/255*100));
              edit3.Enabled:=Checkbox1.checked;
              edit3.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[Treeview1.Selected.Index]);
              edit4.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanDelay[Treeview1.Selected.Index]);
              edit4.Enabled:=Checkbox1.checked;
              break;
            end;
          end;
        end else
        begin
          // ist ein Geräte-Kanal
          label3.caption:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selected.Parent.Parent.Parent.Index][TreeView1.Selected.Parent.Parent.Index][Treeview1.Selected.Parent.index])].Name;
          label5.caption:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selected.Parent.Parent.Parent.Index][TreeView1.Selected.Parent.Parent.Index][Treeview1.Selected.Parent.index])].Kanalname[Treeview1.Selected.index];

          if ShowDDFCheckbox.Checked then
          if Treeview1.SelectionCount>0 then
          if Treeview1.Selected.Parent.Index>-1 then // kein Vendor-Item
          if Treeview1.Selected.Parent.Parent.Index>-1 then // kein Device-Item
          begin
            if Treeview1.Selected.Parent.Parent.Parent.Index>-1 then
            begin
              // ist ein Kanal
              DDFWindowDeviceScene.top:=devicechannelselectionform.Top;
              DDFWindowDeviceScene.left:=devicechannelselectionform.Left+devicechannelselectionform.Width;
              DDFWindowDeviceScene.loadddf(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selected.Parent.Parent.Parent.Index][TreeView1.Selected.Parent.Parent.Index][Treeview1.Selected.Parent.index])].ID);
              devicechannelselectionform.SetFocus;
            end else
            begin
              // Ist ein Gerät
              DDFWindowDeviceScene.top:=devicechannelselectionform.Top;
              DDFWindowDeviceScene.left:=devicechannelselectionform.Left+devicechannelselectionform.Width;
              DDFWindowDeviceScene.loadddf(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selected.Parent.Parent.Index][TreeView1.Selected.Parent.Index][Treeview1.Selected.index])].ID);
              devicechannelselectionform.SetFocus;
            end;
          end;

          for i:=0 to length(mainform.DeviceChannelSelection)-1 do
          begin
            if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selected.Parent.Parent.Parent.Index][TreeView1.Selected.Parent.Parent.Index][Treeview1.Selected.Parent.index])].ID) then
            begin
              Checkbox1.checked:=mainform.DeviceChannelSelection[i].ChanActive[Treeview1.Selected.Index];
              edit2.Enabled:=Checkbox1.checked;
              edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[i].ChanValue[Treeview1.Selected.Index]/255*100));
              edit3.Enabled:=Checkbox1.checked;
              edit3.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[Treeview1.Selected.Index]);
              edit4.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanDelay[Treeview1.Selected.Index]);
              edit4.Enabled:=Checkbox1.checked;
              break;
            end;
          end;
        end;
      end;
    end;
}
end;

procedure Tdevicechannelselectionform.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j,k,l,m,n:integer;
  exists,active:boolean;
  devicesfordelete:array of TGUID;
  Data:PTreeData;
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
      if Data^.DataType=0 then
      begin
        // ist Gerät
        // Existiert Gerät schon?
        exists:=false;
        for i:=0 to length(mainform.DeviceChannelSelection)-1 do
        begin
          if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,Data^.ID) then
          begin
            exists:=true;
            break;
          end;
        end;
        deviceposition:=geraetesteuerung.GetDevicePositionInDeviceArray(@Data^.ID);
        if checkbox1.Checked and not exists then
        begin
          // Gerät erzeugen/aktivieren
          setlength(mainform.DeviceChannelSelection,length(mainform.DeviceChannelSelection)+1);
          setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanActive,mainform.devices[deviceposition].MaxChan);
          setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue,mainform.devices[deviceposition].MaxChan);
          setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay,mainform.devices[deviceposition].MaxChan);
          mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID:=mainform.devices[deviceposition].ID;

          for i:=0 to mainform.devices[deviceposition].MaxChan-1 do
          begin
            mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[i]:=255;
            mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay[i]:=0;
          end;
        end;

        for i:=0 to length(mainform.DeviceChannelSelection)-1 do
        begin
          if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devices[deviceposition].ID) then
          begin
            mainform.DeviceChannelSelection[i].ChanActive[Data^.ChannelInDevice]:=Checkbox1.Checked;
            edit2.Enabled:=Checkbox1.Checked;
            edit3.Enabled:=Checkbox1.Checked;
            edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]/255*100));
            edit3.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]);
            edit4.Enabled:=Checkbox1.Checked;
            if checkbox1.Checked then
            begin
            end else
            begin
              // wenn kein Kanal mehr aktiviert, Gerät löschen
              active:=false;
              for j:=0 to length(mainform.DeviceChannelSelection[i].ChanActive)-1 do
              begin
                if mainform.DeviceChannelSelection[i].ChanActive[j] then
                  active:=true;
              end;

              if not active then
              begin // Kein Kanal des aktuellen Gerätes wird mehr verwendet
                setlength(devicesfordelete,length(devicesfordelete)+1);
                devicesfordelete[length(devicesfordelete)-1]:=mainform.DeviceChannelSelection[i].ID;
              end;
            end;
            edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]/2.55));
            edit3.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]);
            edit4.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanDelay[Data^.ChannelInDevice]);
            break;
          end;
        end;
      end;

      if Data^.DataType=1 then
      begin
        // Existiert Gruppe schon?
        exists:=false;
        for i:=0 to length(mainform.DeviceChannelSelection)-1 do
        begin
          if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].ID) then
          begin
            exists:=true;
            break;
          end;
        end;
        deviceposition:=geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID);
        if checkbox1.Checked and not exists then
        begin
          // Gruppe innerhalb Gerät erzeugen/aktivieren
          setlength(mainform.DeviceChannelSelection,length(mainform.DeviceChannelSelection)+1);
          setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanActive,length(mainform.DeviceChannelNames));
          setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue,length(mainform.DeviceChannelNames));
          setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay,length(mainform.DeviceChannelNames));
          mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID:=mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(Data^.ID)].ID;

          for i:=0 to length(mainform.DeviceChannelNames)-1 do
          begin
            mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[i]:=255;
            mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay[i]:=-1;
          end;
        end;

        for i:=0 to length(mainform.DeviceChannelSelection)-1 do
        begin
          if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devicegroups[deviceposition].ID) then
          begin
            mainform.DeviceChannelSelection[i].ChanActive[Data^.ChannelInDevice]:=Checkbox1.Checked;
            edit2.Enabled:=Checkbox1.Checked;
            edit3.Enabled:=Checkbox1.Checked;
            edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]/255*100));
            edit3.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]);
            edit4.Enabled:=Checkbox1.Checked;
            if checkbox1.Checked then
            begin
            end else
            begin
              // wenn kein Kanal mehr aktiviert, Gerät löschen
              active:=false;
              for j:=0 to length(mainform.DeviceChannelSelection[i].ChanActive)-1 do
              begin
                if mainform.DeviceChannelSelection[i].ChanActive[j] then
                  active:=true;
              end;

              if not active then
              begin // Kein Kanal des aktuellen Gerätes wird mehr verwendet
                setlength(devicesfordelete,length(devicesfordelete)+1);
                devicesfordelete[length(devicesfordelete)-1]:=mainform.DeviceChannelSelection[i].ID;
              end;
            end;
            edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]/2.55));
            edit3.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice]);
            edit4.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanDelay[Data^.ChannelInDevice]);
            break;
          end;
        end;
      end;
    end;
  end;

  // Nicht mehr benötigte Geräte löschen
  for i:=0 to length(devicesfordelete)-1 do
  begin
    for j:=0 to length(mainform.DeviceChannelSelection)-1 do
    begin
      if IsEqualGUID(devicesfordelete[i],mainform.DeviceChannelSelection[j].ID) then
      begin
        // Gerät in Array gefunden
        if j<length(mainform.DeviceChannelSelection)-1 then
        begin
          // letztes Element hier einfügen
          mainform.DeviceChannelSelection[j].ID:=mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID;
          setlength(mainform.DeviceChannelSelection[j].ChanActive,length(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanActive));
          for k:=0 to length(mainform.DeviceChannelSelection[j].ChanActive)-1 do
            mainform.DeviceChannelSelection[j].ChanActive[k]:=mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanActive[k];

          setlength(mainform.DeviceChannelSelection[j].ChanValue,length(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue));
          for k:=0 to length(mainform.DeviceChannelSelection[j].ChanValue)-1 do
            mainform.DeviceChannelSelection[j].ChanValue[k]:=mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[k];

          setlength(mainform.DeviceChannelSelection[j].ChanDelay,length(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay));
          for k:=0 to length(mainform.DeviceChannelSelection[j].ChanDelay)-1 do
            mainform.DeviceChannelSelection[j].ChanDelay[k]:=mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay[k];
        end;
        // Array um eins kürzen
        setlength(mainform.DeviceChannelSelection,length(mainform.DeviceChannelSelection)-1);
        break;
      end;
    end;
  end;
  setlength(devicesfordelete,0);

  VST.Refresh;
{
  for k:=0 to Treeview1.SelectionCount-1 do
  begin
    if Treeview1.Selections[k].Parent.Index>-1 then // kein Vendor-Item
    if Treeview1.Selections[k].Parent.Parent.Index>-1 then // kein Device-Item
    begin
      if Treeview1.Selections[k].Parent.Parent.Parent.Index>-1 then // kein Device
      begin
        // ist ein Kanal
        if (Treeview1.Selections[k].Parent.Parent.Parent.Text='Programmintern') then
        begin
          // ist Programmkomponente
          if (Treeview1.Selections[k].Parent.Parent.Text='Gerätegruppen') then
          begin
            // Existiert Gruppe schon?
            exists:=false;
            for i:=0 to length(mainform.DeviceChannelSelection)-1 do
            begin
              if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].ID) then
              begin
                exists:=true;
                break;
              end;
            end;

            if checkbox1.Checked and not exists then
            begin
              // Gruppe innerhalb Gerät erzeugen/aktivieren
              setlength(mainform.DeviceChannelSelection,length(mainform.DeviceChannelSelection)+1);
              setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanActive,length(mainform.DeviceChannelNames));
              setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue,length(mainform.DeviceChannelNames));
              setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay,length(mainform.DeviceChannelNames));
              mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID:=mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].ID;

              for i:=0 to length(mainform.DeviceChannelNames)-1 do
              begin
                mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[i]:=255;
                mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay[i]:=-1;
              end;

              Treeview1.Selections[k].Parent.Imageindex:=73;
              Treeview1.Selections[k].Parent.Selectedindex:=73;
            end;

            for i:=0 to length(mainform.DeviceChannelSelection)-1 do
            begin
              if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].ID) then
              begin
                mainform.DeviceChannelSelection[i].ChanActive[TreeView1.Selections[k].Index]:=Checkbox1.Checked;
                edit2.Enabled:=Checkbox1.Checked;
                edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[i].ChanValue[TreeView1.Selections[k].Index]/255*100));
                edit3.Enabled:=Checkbox1.Checked;
                edit4.Enabled:=Checkbox1.Checked;
                if checkbox1.Checked then
                begin
                  // Kanalwerte eintragen
                  Treeview1.Selections[k].Imageindex:=75;
                  Treeview1.Selections[k].Selectedindex:=75;

                  // Text aktualisieren
                  for j:=0 to length(mainform.devicegroups)-1 do
                  begin
                    if IsEqualGUID(mainform.devicegroups[j].ID,mainform.DeviceChannelSelection[i].ID) then
                    begin
                      Treeview1.Selections[k].Text:=mainform.DeviceChannelNames[Treeview1.Selections[k].Index];
                      break;
                    end;
                  end;
                end else
                begin
                  // Kanal deaktiviert
                  Treeview1.Selections[k].Imageindex:=74;
                  Treeview1.Selections[k].Selectedindex:=74;

                  // Text aktualisieren
                  for j:=0 to length(mainform.devicegroups)-1 do
                  begin
                    if IsEqualGUID(mainform.devicegroups[j].ID,mainform.DeviceChannelSelection[i].ID) then
                    begin
                      Treeview1.Selections[k].Text:=mainform.DeviceChannelNames[Treeview1.Selections[k].Index];
                      break;
                    end;
                  end;

                  // wenn kein Kanal mehr aktiviert, Gerät löschen
                  active:=false;
                  for j:=0 to length(mainform.DeviceChannelSelection[i].ChanActive)-1 do
                  begin
                    if mainform.DeviceChannelSelection[i].ChanActive[j] then
                      active:=true;
                  end;

                  if not active then
                  begin // Kein Kanal des aktuellen Gerätes wird mehr verwendet
                    setlength(devicesfordelete,length(devicesfordelete)+1);
                    devicesfordelete[length(devicesfordelete)-1]:=mainform.DeviceChannelSelection[i].ID;

                    Treeview1.Selections[k].Parent.Imageindex:=25;
                    Treeview1.Selections[k].Parent.Selectedindex:=25;
                  end;
                end;
                edit3.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[TreeView1.Selections[k].Index]);
                edit4.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanDelay[TreeView1.Selections[k].Index]);
                break;
              end;
            end;
          end;
        end else
        begin
          // ist Gerät
          // Existiert Gerät schon?
          exists:=false;
          for i:=0 to length(mainform.DeviceChannelSelection)-1 do
          begin
            if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].ID) then
            begin
              exists:=true;
              break;
            end;
          end;

          if checkbox1.Checked and not exists then
          begin
            // Gerät erzeugen/aktivieren
            setlength(mainform.DeviceChannelSelection,length(mainform.DeviceChannelSelection)+1);
            setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanActive,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].MaxChan);
            setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].MaxChan);
            setlength(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].MaxChan);
            mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID:=mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].ID;

            for i:=0 to mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].MaxChan-1 do
            begin
              mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[i]:=255;
              mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay[i]:=-1;
            end;

            Treeview1.Selections[k].Parent.Imageindex:=73;
            Treeview1.Selections[k].Parent.Selectedindex:=73;
          end;

          for i:=0 to length(mainform.DeviceChannelSelection)-1 do
          begin
            if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].ID) then
            begin
              mainform.DeviceChannelSelection[i].ChanActive[TreeView1.Selections[k].Index]:=Checkbox1.Checked;
              edit2.Enabled:=Checkbox1.Checked;
              edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[i].ChanValue[TreeView1.Selections[k].Index]/255*100));
              edit3.Enabled:=Checkbox1.Checked;
              edit4.Enabled:=Checkbox1.Checked;
              if checkbox1.Checked then
              begin
                // Kanalwerte eintragen
                Treeview1.Selections[k].Imageindex:=75;
                Treeview1.Selections[k].Selectedindex:=75;

                // Text aktualisieren
                for j:=0 to length(mainform.devices)-1 do
                begin
                  if IsEqualGUID(mainform.devices[j].ID,mainform.DeviceChannelSelection[i].ID) then
                  begin
                  //  Als Option gleich aktuelle Kanalwerte eintragen:
//                    mainform.DeviceChannelSelection[i].ChanValue[TreeView1.Selections[k].Index]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Treeview1.Selections[k].Index]);
                    Treeview1.Selections[k].Text:=mainform.devices[j].kanalname[Treeview1.Selections[k].Index]+' ('+mainform.levelstr(mainform.DeviceChannelSelection[i].ChanValue[Treeview1.Selections[k].Index])+', Delay: '+inttostr(mainform.DeviceChannelSelection[i].ChanDelay[Treeview1.Selections[k].Index])+'ms)';
                    break;
                  end;
                end;
              end else
              begin
                // Kanal deaktiviert
                Treeview1.Selections[k].Imageindex:=74;
                Treeview1.Selections[k].Selectedindex:=74;

                // Text aktualisieren
                for j:=0 to length(mainform.devices)-1 do
                begin
                  if IsEqualGUID(mainform.devices[j].ID,mainform.DeviceChannelSelection[i].ID) then
                  begin
                    Treeview1.Selections[k].Text:=mainform.devices[j].kanalname[Treeview1.Selections[k].Index];
                    break;
                  end;
                end;

                // wenn kein Kanal mehr aktiviert, Gerät löschen
                active:=false;
                for j:=0 to length(mainform.DeviceChannelSelection[i].ChanActive)-1 do
                begin
                  if mainform.DeviceChannelSelection[i].ChanActive[j] then
                    active:=true;
                end;

                if not active then
                begin // Kein Kanal des aktuellen Gerätes wird mehr verwendet
                  setlength(devicesfordelete,length(devicesfordelete)+1);
                  devicesfordelete[length(devicesfordelete)-1]:=mainform.DeviceChannelSelection[i].ID;

                  Treeview1.Selections[k].Parent.Imageindex:=25;
                  Treeview1.Selections[k].Parent.Selectedindex:=25;
                end;
              end;
              edit3.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[TreeView1.Selections[k].Index]);
              edit4.Text:=inttostr(mainform.DeviceChannelSelection[i].ChanDelay[TreeView1.Selections[k].Index]);
              break;
            end;
          end;
        end;
      end;
    end;
  end;

  // Nicht mehr benötigte Geräte löschen
  for i:=0 to length(devicesfordelete)-1 do
  begin
    for j:=0 to length(mainform.DeviceChannelSelection)-1 do
    begin
      if IsEqualGUID(devicesfordelete[i],mainform.DeviceChannelSelection[j].ID) then
      begin
        // Gerät in Array gefunden
        if j<length(mainform.DeviceChannelSelection)-1 then
        begin
          // letztes Element hier einfügen
          mainform.DeviceChannelSelection[j].ID:=mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID;
          setlength(mainform.DeviceChannelSelection[j].ChanActive,length(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanActive));
          for k:=0 to length(mainform.DeviceChannelSelection[j].ChanActive)-1 do
            mainform.DeviceChannelSelection[j].ChanActive[k]:=mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanActive[k];

          setlength(mainform.DeviceChannelSelection[j].ChanValue,length(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue));
          for k:=0 to length(mainform.DeviceChannelSelection[j].ChanValue)-1 do
            mainform.DeviceChannelSelection[j].ChanValue[k]:=mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[k];

          setlength(mainform.DeviceChannelSelection[j].ChanDelay,length(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay));
          for k:=0 to length(mainform.DeviceChannelSelection[j].ChanDelay)-1 do
            mainform.DeviceChannelSelection[j].ChanDelay[k]:=mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay[k];
        end;
        // Array um eins kürzen
        setlength(mainform.DeviceChannelSelection,length(mainform.DeviceChannelSelection)-1);
        break;
      end;
    end;
  end;
  setlength(devicesfordelete,0);

  Treeview1.Refresh;
}
end;

procedure Tdevicechannelselectionform.input_number(var pos:integer; var s:string);
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

procedure Tdevicechannelselectionform.input_number_minus(var pos:integer; var s:string);
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

procedure Tdevicechannelselectionform.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tdevicechannelselectionform.Button1Click(Sender: TObject);
begin
if messagedlg(_(_('Alle Geräte dieser Szene werden deaktiviert. Dabei gehen alle eingestellten Gerätewerte der Szene verloren. Fortfahren?')),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    setlength(mainform.DeviceChannelSelection,0);
//    RefreshTree;
    CheckButtons;
    VST.Refresh;
  end;
end;

procedure Tdevicechannelselectionform.WMMoving(var AMsg: TMessage);
begin
  if DDFWindowDeviceScene.showing then
  begin
    DDFWindowDeviceScene.top:=devicechannelselectionform.Top;
    DDFWindowDeviceScene.left:=devicechannelselectionform.Left+devicechannelselectionform.Width;
  end;
end;

procedure Tdevicechannelselectionform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DDFWindowDeviceScene.showing then
    DDFWindowDeviceScene.close;
end;

procedure Tdevicechannelselectionform.FormResize(Sender: TObject);
begin
  if DDFWindowDeviceScene.showing then
  begin
    DDFWindowDeviceScene.top:=devicechannelselectionform.Top;
    DDFWindowDeviceScene.left:=devicechannelselectionform.Left+devicechannelselectionform.Width;
  end;
end;

procedure Tdevicechannelselectionform.EditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
    ModalResult:=mrOK;
end;

procedure Tdevicechannelselectionform.Edit2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

  if strtoint(TEdit(Sender).text)>100 then
    TEdit(Sender).text:='100';

  Edit3.Text:=inttostr(round(strtoint(TEdit(Sender).text)*2.55));

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
        for j:=0 to length(mainform.DeviceChannelSelection)-1 do
        begin
          if IsEqualGUID(mainform.DeviceChannelSelection[j].ID, Data^.ID) then
          begin
            mainform.DeviceChannelSelection[j].ChanValue[Data^.ChannelInDevice]:=round(strtoint(Edit2.text)*2.55);
          end;
        end;
      end;
    end;
  end;
  VST.Refresh;

  if Key=vk_return then
    ModalResult:=mrOK;
end;

procedure Tdevicechannelselectionform.Edit4KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

  if strtoint(TEdit(Sender).text)<-1 then
    TEdit(Sender).text:='-1';

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
        for j:=0 to length(mainform.DeviceChannelSelection)-1 do
        begin
          if IsEqualGUID(mainform.DeviceChannelSelection[j].ID, Data^.ID) then
          begin
            mainform.DeviceChannelSelection[j].ChanDelay[Data^.ChannelInDevice]:=strtoint(Edit4.text);
          end;
        end;
      end;
    end;
  end;
  VST.Refresh;
{
  for k:=0 to Treeview1.SelectionCount-1 do
  if Treeview1.Selections[k].Parent.Index>-1 then // kein Vendor-Item
    if Treeview1.Selections[k].Parent.Parent.Index>-1 then // kein Device-Item
    begin
      if Treeview1.Selections[k].Parent.Parent.Parent.Index>-1 then
      begin
        if Treeview1.Selections[k].Parent.Parent.Text='Gerätegruppen' then
        begin
          // ist ein Gruppen-Kanal
          for i:=0 to length(mainform.DeviceChannelSelection)-1 do
          begin
            if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devicegroups[geraetesteuerung.GetGroupPositionInGroupArray(NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].ID) then
            begin
              mainform.DeviceChannelSelection[i].ChanDelay[TreeView1.Selections[k].Index]:=strtoint(Edit4.text);
              for j:=0 to length(mainform.devicegroups)-1 do
                if IsEqualGUID(mainform.devicegroups[j].ID,mainform.DeviceChannelSelection[i].ID) then//GUIDtoString(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selections[k].Parent.Parent.Index][TreeView1.Selections[k].Parent.Index][Treeview1.Selections[k].index])].ID) then
                  Treeview1.Selections[k].Text:=mainform.DeviceChannelNames[Treeview1.Selections[k].Index]+' ('+mainform.levelstr(mainform.DeviceChannelSelection[i].ChanValue[Treeview1.Selections[k].Index])+', Delay: '+inttostr(mainform.DeviceChannelSelection[i].ChanDelay[Treeview1.Selections[k].Index])+'ms)';
              break;
            end;
          end;
        end else
        begin
          // ist ein Kanal
          for i:=0 to length(mainform.DeviceChannelSelection)-1 do
          begin
            if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selections[k].Parent.Parent.Parent.Index][TreeView1.Selections[k].Parent.Parent.Index][Treeview1.Selections[k].Parent.index])].ID) then
            begin
              mainform.DeviceChannelSelection[i].ChanDelay[TreeView1.Selections[k].Index]:=strtoint(Edit4.text);
              for j:=0 to length(mainform.devices)-1 do
                if IsEqualGUID(mainform.devices[j].ID,mainform.DeviceChannelSelection[i].ID) then//GUIDtoString(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[TreeView1.Selections[k].Parent.Parent.Index][TreeView1.Selections[k].Parent.Index][Treeview1.Selections[k].index])].ID) then
                  Treeview1.Selections[k].Text:=mainform.devices[j].kanalname[Treeview1.Selections[k].Index]+' ('+mainform.levelstr(mainform.DeviceChannelSelection[i].ChanValue[Treeview1.Selections[k].Index])+', Delay: '+inttostr(mainform.DeviceChannelSelection[i].ChanDelay[Treeview1.Selections[k].Index])+'ms)';
              break;
            end;
          end;
        end;
      end;
    end;
}
  if Key=vk_return then
    ModalResult:=mrOK;
end;

procedure Tdevicechannelselectionform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tdevicechannelselectionform.VSTPaintText(
  Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
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

procedure Tdevicechannelselectionform.VSTMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CheckButtons;
end;

procedure Tdevicechannelselectionform.VSTKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_space then
  begin
    Checkbox1.Checked:=not checkbox1.Checked;
    Checkbox1Mouseup(nil,mbLeft,[],0,0);
  end;
  CheckButtons;
end;

procedure Tdevicechannelselectionform.VSTGetText(Sender: TBaseVirtualTree;
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
          if not mainform.DeviceChannelSelection[Data^.DeviceInScene].ChanActiveRandom[Data^.ChannelInDevice] then
            Node.CheckState:=csMixedNormal
          else
          begin
            if mainform.DeviceChannelSelection[Data^.DeviceInScene].ChanActive[Data^.ChannelInDevice] then
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
            for i:=0 to length(mainform.DeviceChannelSelection)-1 do
            begin
              if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              begin // Gerät gefunden
                if mainform.DeviceChannelSelection[i].ChanActive[Data^.ChannelInDevice] then
                  CellText:=inttostr(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice])+' ('+mainform.levelstr(mainform.DeviceChannelSelection[i].ChanValue[Data^.ChannelInDevice])+')';
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
      // Delay anzeigen
      Data:=VST.GetNodeData(Node);

      case Data^.NodeType of
        3:
        begin
          CellText:='-';
          if (Data^.DataType=0) or (Data^.DataType=1) then
          begin
            for i:=0 to length(mainform.DeviceChannelSelection)-1 do
            begin
              if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
              begin // Gerät gefunden
                if mainform.DeviceChannelSelection[i].ChanActive[Data^.ChannelInDevice] then
                begin
                  if mainform.DeviceChannelSelection[i].ChanDelay[Data^.ChannelInDevice]=-1 then
                  begin
                    CellText:=_('Gruppe');
                  end else
                    CellText:=mainform.MillisecondsToTimeShort(mainform.DeviceChannelSelection[i].ChanDelay[Data^.ChannelInDevice]);
                end;
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

procedure Tdevicechannelselectionform.VSTGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
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
              for i:=0 to length(mainform.DeviceChannelSelection)-1 do
              begin
                if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
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
              for i:=0 to length(mainform.DeviceChannelSelection)-1 do
              begin
                if IsEqualGUID(mainform.DeviceChannelSelection[i].ID,Data^.ID) and (Data^.ChannelInDevice>-1) then
                begin // Gerät gefunden
                  if mainform.DeviceChannelSelection[i].ChanActive[Data^.ChannelInDevice] then
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

procedure Tdevicechannelselectionform.RefreshTreeNew;
var
  i,j,k:integer;
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

  VST.EndUpdate;

  if VST.RootNodeCount>0 then
    VST.Selected[VSTCurrentNode]:=true
  else
    ShowMessage(_('Es sind derzeit keine Geräte installiert.'+#10#13#10#13+'Bitte fügen Sie mindestens ein Gerät über die Gerätesteuerung hinzu, damit die Geräteszene aufgerufen werden kann.'));
end;

procedure Tdevicechannelselectionform.Button6Click(Sender: TObject);
begin
  VST.FullCollapse(nil);
end;

procedure Tdevicechannelselectionform.Button7Click(Sender: TObject);
var
  i,j,k,l,m:integer;
  Data: PTreeData;
begin
//  RefreshTreeNew;
  VST.FullCollapse(nil);
  for i:=0 to length(VSTChannelNodes)-1 do
  for j:=0 to length(VSTChannelNodes[i])-1 do
  for k:=0 to length(VSTChannelNodes[i][j])-1 do
  for l:=0 to length(VSTChannelNodes[i][j][k])-1 do
  begin
    Data:=VST.GetNodeData(VSTChannelNodes[i][j][k][l]);

    if (Data^.NodeType=3) and ((Data^.DataType=0) or (Data^.DataType=1)) then
    begin
      for m:=0 to length(mainform.DeviceChannelSelection)-1 do
      begin
        if IsEqualGUID(mainform.DeviceChannelSelection[m].ID, Data^.ID) then
        begin
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent]:=true;
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent.Parent]:=true;
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent.Parent.Parent]:=true;
        end;
      end;
    end;
    if (Data^.NodeType=3) and (Data^.DataType=2) then
    begin
      for m:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
      begin
        if IsEqualGUID(mainform.AktuelleDeviceScene.Befehle[m].ID, Data^.ID) then
        begin
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent]:=true;
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent.Parent]:=true;
          VST.Expanded[VSTChannelNodes[i][j][k][l].Parent.Parent.Parent]:=true;
        end;
      end;
    end;
  end;
end;

procedure Tdevicechannelselectionform.Button5Click(Sender: TObject);
begin
  VST.FullExpand(nil);
end;

procedure Tdevicechannelselectionform.FormShow(Sender: TObject);
begin
  RefreshTreeNew; // Baum neu zeichnen
  Button7Click(nil); // Alle aktiven Elemente ausklappen
end;

procedure Tdevicechannelselectionform.VSTDblClick(Sender: TObject);
begin
  Checkbox1.Checked:=not checkbox1.Checked;
  Checkbox1Mouseup(nil,mbLeft,[],0,0);
  CheckButtons;
end;

procedure Tdevicechannelselectionform.Button9MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  activatedmenu.Popup(devicechannelselectionform.Left+panel1.left+GroupBox3.left+button9.Left+X,devicechannelselectionform.Top+panel1.top+GroupBox3.top+button9.Top+Y);
end;

procedure Tdevicechannelselectionform.Button4Click(Sender: TObject);
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
      for i:=0 to length(mainform.DeviceChannelSelection)-1 do
      begin
        if IsEqualGUID(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID,Data^.ID) then
        begin
          for j:=0 to length(mainform.devices)-1 do
            if IsEqualGUID(mainform.devices[j].ID,mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID) then
            begin
              mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);
              Edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]/255*100));
              Edit3.Text:=inttostr(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]);
              Edit4.Text:=inttostr(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay[Data^.ChannelInDevice]);
            end;
          break;
        end;
      end;
    end;
  end;
  VST.Refresh;
end;

procedure Tdevicechannelselectionform.Button4MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  selectedmenu.Popup(devicechannelselectionform.Left+panel1.left+GroupBox3.left+button4.Left+X,devicechannelselectionform.Top+panel1.top+GroupBox3.top+button4.Top+Y);
end;

procedure Tdevicechannelselectionform.Button3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  wholescenemenu.Popup(devicechannelselectionform.Left+panel1.left+GroupBox3.left+button3.Left+X,devicechannelselectionform.Top+panel1.top+GroupBox3.top+button3.Top+Y);
end;

procedure Tdevicechannelselectionform.AktuelleWerte1Click(Sender: TObject);
var
  i,j,k:integer;
begin
  if messagedlg(_('Die Werte aller aktivierten Geräte werden auf die aktuellen Werte gesetzt. Fortfahren?'),mtConfirmation,
    [mbYes,mbNo],0)=mrYes then
  begin
    for i:=0 to length(mainform.DeviceChannelSelection)-1 do
    begin
      for j:=0 to length(mainform.devices)-1 do
      if IsEqualGUID(mainform.devices[j].ID,mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID) then
      begin
        for k:=0 to length(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanActive)-1 do
        if mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanActive[k] then
        begin
          mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[k]:=255-mainform.data.ch[mainform.devices[j].Startaddress+k];
        end;
        break;
      end;
    end;
    CheckButtons;
  end;
  VST.Refresh;
end;

procedure Tdevicechannelselectionform.AktuellerKanalwert1Click(
  Sender: TObject);
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
      for i:=0 to length(mainform.DeviceChannelSelection)-1 do
      begin
        if IsEqualGUID(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID,Data^.ID) then
        begin
          for j:=0 to length(mainform.devices)-1 do
            if IsEqualGUID(mainform.devices[j].ID,mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID) then
            begin
              mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);
              Edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]/255*100));
              Edit3.Text:=inttostr(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]);
              Edit4.Text:=inttostr(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay[Data^.ChannelInDevice]);
            end;
          break;
        end;
      end;
    end;
  end;
  VST.Refresh;
end;

procedure Tdevicechannelselectionform.beinhaltetnurseitletzterSzenegenderteKanle1Click(
  Sender: TObject);
var
  i,j,k,l,m,n:integer;
  Data:PTreeData;
begin
  if messagedlg(_('Es werden nur seit der letzten erstellten Szene geänderten Kanäle eingefügt. Fortfahren?'),mtConfirmation,
    [mbYes,mbNo],0)=mrYes then
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

              for i:=0 to length(mainform.DeviceChannelSelection)-1 do
              begin
                if IsEqualGUID(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID,Data^.ID) then
                begin
                  // Eintrag in Array gefunden
                  mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);

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

procedure Tdevicechannelselectionform.beinhaltetnurderzeitselektierteGerte1Click(
  Sender: TObject);
var
  i,j,k,l,m,n:integer;
  Data:PTreeData;
begin
  if messagedlg(_('Es werden nur die derzeit selektierten Geräte eingefügt. Fortfahren?'),mtConfirmation,
    [mbYes,mbNo],0)=mrYes then
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

              for i:=0 to length(mainform.DeviceChannelSelection)-1 do
              begin
                if IsEqualGUID(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID,Data^.ID) then
                begin
                  // Eintrag in Array gefunden
                  mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);

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

procedure Tdevicechannelselectionform.beinhaltetseitletzterSzenegenderteKanleundaktuellselektierteGerte1Click(
  Sender: TObject);
var
  i,j,k,l,m,n:integer;
  Data:PTreeData;
begin
  if messagedlg(_('Es werden nur seit der letzten erstellten Szene geänderte Kanäle und alle derzeit selektierten Geräte eingefügt. Fortfahren?'),mtConfirmation,
    [mbYes,mbNo],0)=mrYes then
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

              for i:=0 to length(mainform.DeviceChannelSelection)-1 do
              begin
                if IsEqualGUID(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID,Data^.ID) then
                begin
                  // Eintrag in Array gefunden
                  mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);

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

procedure Tdevicechannelselectionform.beinhaltetalleKanle1Click(
  Sender: TObject);
var
  i,j,k,l,m,n:integer;
  Data:PTreeData;
begin
  if messagedlg(_('Es werden alle Kanäle der Szene hinzugefügt. Fortfahren?'),mtConfirmation,
    [mbYes,mbNo],0)=mrYes then
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
        for i:=0 to length(mainform.DeviceChannelSelection)-1 do
        begin
          if IsEqualGUID(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID,Data^.ID) then
          begin
            for j:=0 to length(mainform.devices)-1 do
            begin
              if IsEqualGUID(mainform.devices[j].ID,mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ID) then
              begin
                mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]:=geraetesteuerung.get_channel(mainform.devices[j].ID,mainform.devices[j].kanaltyp[Data^.ChannelInDevice]);
                Edit2.Text:=inttostr(round(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]/255*100));
                Edit3.Text:=inttostr(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanValue[Data^.ChannelInDevice]);
                Edit4.Text:=inttostr(mainform.DeviceChannelSelection[length(mainform.DeviceChannelSelection)-1].ChanDelay[Data^.ChannelInDevice]);
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

procedure Tdevicechannelselectionform.ChangedChannelsTimer(
  Sender: TObject);
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

procedure Tdevicechannelselectionform.Button15Click(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to mainform.lastchan do
    mainform.changedchannels[i]:=false;
  ChangedChannelsTimer(nil);
end;

procedure Tdevicechannelselectionform.CreateParams(var Params:TCreateParams);
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

procedure Tdevicechannelselectionform.Edit3KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

  Edit2.Text:=inttostr(round(strtoint(TEdit(Sender).text)/2.55));

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
        for j:=0 to length(mainform.DeviceChannelSelection)-1 do
        begin
          if IsEqualGUID(mainform.DeviceChannelSelection[j].ID, Data^.ID) then
          begin
            mainform.DeviceChannelSelection[j].ChanValue[Data^.ChannelInDevice]:=strtoint(Edit3.text);
          end;
        end;
      end;
    end;
  end;
  VST.Refresh;

  if Key=vk_return then
    ModalResult:=mrOK;
end;

procedure Tdevicechannelselectionform.Edit1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  i,j,k:integer;
  Suchtext:string;
  Data, Data2, Data3:PTreeData;
begin
  if key=vk_return then
  begin
    VST.FullCollapse(nil);
    Suchtext:=lowercase(Edit1.Text);

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
