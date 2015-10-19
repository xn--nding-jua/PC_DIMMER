unit USBViewMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ImgList, USBDeviceTree, PngImageList, gnugettext,
  pngimage, ExtCtrls, JvExControls, JvGradient;

type
  TUSBViewForm = class(TForm)
    DeviceListView: TTreeView;
    USBDeviceTree: TUSBDeviceTree;
    DeviceIcons: TPngImageList;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DeviceListViewDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  public
    VendorList: TStringList;
    function FindVendorLine(VID: Integer): Integer;
    function FindVendorName(VID: Integer): string;
    function FindProductName(VID, PID: Integer): string;
  published
    procedure Refresh(Sender: TObject);
  end;

var
  USBViewForm: TUSBViewForm;

implementation

uses
  Cfg, CfgMgr32, USB100, USBDesc,
  JwaWinType, PCDIMMER;

{$R *.dfm}

procedure TUSBViewForm.FormCreate(Sender: TObject);
var
  I: Integer;
  UsbText: TResourceStream;
begin
  TranslateComponent(self);

  VendorList := TStringList.Create;

  UsbText:=TResourceStream.Create(HInstance, 'USBTXT', RT_RCDATA);
  VendorList.LoadFromStream(UsbText);

  for I := VendorList.Count - 1 downto 0 do
    if VendorList[I] = '' then
      VendorList.Delete(I);
  Refresh(Self);
end;

procedure TUSBViewForm.FormDestroy(Sender: TObject);
begin
  VendorList.Free;
end;

function TUSBViewForm.FindVendorLine(VID: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to VendorList.Count - 1 do
    if VendorList[I][1] <> #9 then
      if StrToInt('$' + Copy(VendorList[I], 1, 4)) = VID then
      begin
        Result := I;
        Break;
      end;
end;

function TUSBViewForm.FindVendorName(VID: Integer): string;
var
  I: Integer;
begin
  Result := Format('VID=%.4x', [VID]);
  I := FindVendorLine(VID);
  if I >= 0 then
    Result := Copy(VendorList[I], 7, Length(VendorList[I]));
end;

function TUSBViewForm.FindProductName(VID, PID: Integer): string;
var
  I: Integer;
begin
  Result := Format('PID=%.4x', [PID]);
  I := FindVendorLine(VID);
  if I >= 0 then
  begin
    Inc(I);
    while (I < VendorList.Count) and (VendorList[I][1] = #9) do
      if StrToInt('$' + Copy(VendorList[I], 2, 4)) = PID then
      begin
        Result := Copy(VendorList[I], 8, Length(VendorList[I]));
        Break;
      end
      else
        Inc(I);
  end;
end;

// from JclSysInfo.pas

function GetLocalComputerName: string;
var
  Count: DWORD;
begin
  Count := MAX_COMPUTERNAME_LENGTH + 1;
  // set buffer size to MAX_COMPUTERNAME_LENGTH + 2 characters for safety
  { TODO : Win2k solution }
  SetLength(Result, Count);
  if GetComputerName(PChar(Result), Count) then
    SetLength(Result, StrLen(PChar(Result)))
  else
    Result := '';
end;

procedure TUSBViewForm.Refresh(Sender: TObject);
var
  I: Integer;
  Root, HCN: TTreeNode;
  HC: TUSBHostController;
  MS, PS: string;

  procedure AddNodes(HCN: TTreeNode; Dev: TUSBDevice);
  var
    I: Integer;
    Node: TTreeNode;
  begin
    if Dev <> nil then
    begin
      if Dev.IsHub then
      begin
        MS := FindVendorName(Dev.ConnectionInfo.DeviceDescriptor.idVendor);
        PS := FindProductName(Dev.ConnectionInfo.DeviceDescriptor.idVendor,
          Dev.ConnectionInfo.DeviceDescriptor.idProduct);
        if Dev.IsRootHub then
          Node := DeviceListView.Items.AddChildObject(HCN, Dev.DeviceDescription, Dev)
        else
          Node := DeviceListView.Items.AddChildObject(HCN, Format('%d) %s %s %s',
            [Dev.ConnectionIndex, Dev.DeviceDescription, MS, PS]), Dev);
        Node.ImageIndex := 1;
        Node.SelectedIndex := 1;
        for I := 0 to Dev.Count - 1 do
          AddNodes(Node, Dev.Devices[I]);
      end
      else
      begin
        if Dev.Manufacturer = '' then
          MS := FindVendorName(Dev.ConnectionInfo.DeviceDescriptor.idVendor)
        else
          MS := Dev.Manufacturer;
        if Dev.Product = '' then
          PS := FindProductName(Dev.ConnectionInfo.DeviceDescriptor.idVendor,
            Dev.ConnectionInfo.DeviceDescriptor.idProduct)
        else
          PS := Dev.Product;
        Node := DeviceListView.Items.AddChildObject(HCN, Format('%d) %s  %s  %s',
          [Dev.ConnectionIndex, Dev.DeviceDescription, MS, PS]), Dev);
        if Dev.SerialNumber <> '' then
          Node.Text := Node.Text + Format('  [%s]', [Dev.SerialNumber]);
        if Dev.ConnectionInfo.CurrentConfigurationValue <> 0 then
        begin
          Node.ImageIndex := 2;
          Node.SelectedIndex := 2;
        end
        else
        begin
          Node.ImageIndex := 4;
          Node.SelectedIndex := 4;
        end;
      end;
    end
    else
    begin
      Node := DeviceListView.Items.AddChild(HCN, _('Frei'));
      Node.ImageIndex := 3;
      Node.SelectedIndex := 3;
    end;
  end;

begin
  DeviceListView.Items.BeginUpdate;
  DeviceListView.Items.Clear;
  Root := DeviceListView.Items.Add(nil, GetLocalComputerName);
  Root.ImageIndex := 0;
  Root.SelectedIndex := 0;
  for I := 0 to USBDeviceTree.Count - 1 do
  begin
    HC := USBDeviceTree.HostControllers[I];
    HCN := DeviceListView.Items.AddChild(Root,
      Format('%d) %s', [I + 1, HC.DeviceDescription]));
    HCN.ImageIndex := 2;
    HCN.SelectedIndex := 2;
    AddNodes(HCN, HC.RootHub);
  end;
  DeviceListView.FullExpand;
  DeviceListView.Items.EndUpdate;
end;

procedure TUSBViewForm.DeviceListViewDblClick(Sender: TObject);
var
  I: Integer;
  Dev: TUSBDevice;
  IsMassStorage: Boolean;
//  VetoType: PNP_VETO_TYPE;
  //VetoBuffer: array [0..MAX_PATH-1] of TCHAR;
begin
  if DeviceListView.Selected <> nil then
  begin
    if DeviceListView.Selected.Data <> nil then
    begin
      Dev := DeviceListView.Selected.Data;
      if Dev.DeviceInstance <> 0 then
      begin
        IsMassStorage := False;
        for I := 0 to Dev.DescriptorCount - 1 do
        begin
          if Dev.Descriptors[I].DescriptorType = USB_INTERFACE_DESCRIPTOR_TYPE then
            IsMassStorage := Dev.Descriptors[I].InterfaceDescr.bInterfaceClass = USB_DEVICE_CLASS_STORAGE;
          if IsMassStorage then
            Break;
        end;
{
        if IsMassStorage then
          //CM_Request_Device_Eject(Dev.DeviceInstance,
          //  @VetoType, @VetoBuffer[0], Length(VetoBuffer), 0);
          CM_Request_Device_Eject(Dev.DeviceInstance,
            @VetoType, nil, 0, 0);
}
      end;
    end;
  end;
end;

procedure TUSBViewForm.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure TUSBViewForm.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

end.
