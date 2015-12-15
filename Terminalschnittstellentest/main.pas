unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  StdCtrls, Mask, JvExMask, JvSpin, StrUtils, XPMan;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    idclient: TIdTCPClient;
    ipaddress: TEdit;
    Label6: TLabel;
    portaddress: TEdit;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    ScrollBar1: TScrollBar;
    JvSpinEdit1: TJvSpinEdit;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Edit1: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    GroupBox4: TGroupBox;
    Button8: TButton;
    ListBox1: TListBox;
    Label8: TLabel;
    ComboBox1: TComboBox;
    ScrollBar2: TScrollBar;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    XPManifest1: TXPManifest;
    GroupBox3: TGroupBox;
    Memo1: TMemo;
    GroupBox5: TGroupBox;
    Memo2: TMemo;
    Button12: TButton;
    Button13: TButton;
    buttony: TJvSpinEdit;
    buttonx: TJvSpinEdit;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    DeviceChannelNames:array of string;
    devices:array of string;
    deviceids:array of TGUID;
    procedure SendCmd(Befehl:string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  idclient.Connect(ipaddress.text, strtoint(portaddress.text));
  label8.Visible:=idclient.Connected;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  idclient.Disconnect;
  label8.Visible:=idclient.Connected;
end;

procedure Tform1.SendCmd(Befehl:String);
begin
  if idclient.Connected then
  begin
    try
      idclient.Socket.WriteLn(befehl);

      if not (idclient.Socket.ReadLn=befehl) then
      begin
        idclient.Socket.WriteLn(befehl);

        if not (idclient.Socket.ReadLn=befehl) then
        begin
          idclient.Socket.WriteLn(befehl);

          if not (idclient.Socket.ReadLn=befehl) then
          begin
            Showmessage('Server nicht erreichbar bzw. mehrfach fehlerhafte Übertragung...');
          end;
        end;
      end;
    except
    end;
  end else
  begin
    ShowMessage('Bitte erst mit Server verbinden...');
  end;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  SendCmd('set_absolutchannel '+jvspinedit1.Text+' -1 '+inttostr(scrollbar1.Position)+' 0 0');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  SendCmd('set_absolutchannel '+jvspinedit1.Text+' -1 0 3000 0');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  SendCmd('set_absolutchannel '+jvspinedit1.Text+' -1 127 3000 0');
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  SendCmd('set_absolutchannel '+jvspinedit1.Text+' -1 255 3000 0');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SendCmd('start_scene '+edit1.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  SendCmd('stop_scene '+edit1.Text);
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  if listbox1.itemindex>-1 then
  begin
    SendCmd('set_channel '+guidtostring(deviceids[listbox1.itemindex])+' '+combobox1.Text+' -1 '+inttostr(scrollbar2.Position)+' 0 0');
  end;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  answer:string;
  i:integer;
begin
  SendCmd('get_devices');
  answer:=idclient.Socket.ReadLn;

  if pos('devices',answer)>0 then
  begin
    setlength(devices,0);
    setlength(deviceids,0);

    answer:=copy(answer, 9, length(answer));

    setlength(devices,strtoint(copy(answer, 0, pos(' ', answer)-1)));
    setlength(deviceids,length(devices));

    answer:=copy(answer, pos(' ', answer)+1, length(answer));

    if length(devices)>0 then
    begin
      if length(devices)>1 then
      begin
        for i:=0 to length(devices)-2 do
        begin
          devices[i]:=copy(answer, pos(':', answer)+1, pos(',', answer)-(pos(':', answer)+1));
          answer:=copy(answer, pos(',', answer)+1, length(answer));
          deviceids[i]:=stringtoguid(copy(answer, 0, pos(' ', answer)-1));
          answer:=copy(answer, pos(' ', answer), length(answer));
        end;
      end;
      devices[length(devices)-1]:=copy(answer, pos(':', answer)+1, pos(',', answer)-(pos(':', answer)+1));
      answer:=copy(answer, pos(',', answer)+1, length(answer));
      deviceids[length(deviceids)-1]:=stringtoguid(answer);
    end;
  end;

  listbox1.Items.Clear;
  for i:=0 to length(devices)-1 do
    listbox1.Items.Add(devices[i]);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
begin
  setlength(DeviceChannelNames,28);
  DeviceChannelNames[0]:='PAN';
  DeviceChannelNames[1]:='TILT';
  DeviceChannelNames[2]:='PANFINE';
  DeviceChannelNames[3]:='TILTFINE';
  DeviceChannelNames[4]:='MOVES';
  DeviceChannelNames[5]:='SPEED';
  DeviceChannelNames[6]:='GOBO1';
  DeviceChannelNames[7]:='GOBO1ROT';
  DeviceChannelNames[8]:='GOBO2';
  DeviceChannelNames[9]:='GOBO2ROT';
  DeviceChannelNames[10]:='GOBO3';
  DeviceChannelNames[11]:='EXTRA';
  DeviceChannelNames[12]:='COLOR1';
  DeviceChannelNames[13]:='COLOR2';
  DeviceChannelNames[14]:='R'; // Magenta
  DeviceChannelNames[15]:='G'; // Yellow
  DeviceChannelNames[16]:='B'; // Cyan
  DeviceChannelNames[17]:='IRIS';
  DeviceChannelNames[18]:='SHUTTER';
  DeviceChannelNames[19]:='DIMMER';
  DeviceChannelNames[20]:='ZOOM';
  DeviceChannelNames[21]:='FOCUS';
  DeviceChannelNames[22]:='PRISMA';
  DeviceChannelNames[23]:='PRISMAROT';
  DeviceChannelNames[24]:='FROST';
  DeviceChannelNames[25]:='SPECIAL1';
  DeviceChannelNames[26]:='SPECIAL2';
  DeviceChannelNames[27]:='SPECIAL3';

  combobox1.Items.Clear;
  for i:=0 to length(DeviceChannelNames)-1 do
    combobox1.Items.Add(DeviceChannelNames[i]);
  combobox1.ItemIndex:=19;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  if listbox1.itemindex>-1 then
  begin
    SendCmd('set_channel '+guidtostring(deviceids[listbox1.itemindex])+' '+combobox1.Text+' -1 0 3000 0');
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  if listbox1.itemindex>-1 then
  begin
    SendCmd('set_channel '+guidtostring(deviceids[listbox1.itemindex])+' '+combobox1.Text+' -1 127 3000 0');
  end;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  if listbox1.itemindex>-1 then
  begin
    SendCmd('set_channel '+guidtostring(deviceids[listbox1.itemindex])+' '+combobox1.Text+' -1 255 3000 0');
  end;
end;

procedure TForm1.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if listbox1.itemindex>-1 then
  begin
    SendCmd('get_deviceinfo '+guidtostring(deviceids[listbox1.itemindex]));
    memo1.Text:=idclient.Socket.ReadLn;
  end;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  SendCmd('get_controlpanel');
  memo2.Text:=idclient.Socket.ReadLn;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  SendCmd('get_controlpanel '+inttostr(round(buttonx.value))+' '+inttostr(round(buttony.value)));
  memo2.Text:=idclient.Socket.ReadLn;
end;

end.
