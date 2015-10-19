{******************************************************************************
                            Beispielprojekt für DMX4ALL Interfaces
                     der Code ist OpenSource und darf frei verändert werden
                                    FreeStylers® GmbH 2007
                                         Thomas Franke
                               E-Mail: t.franke@freestylers.tv
                                      www.freestylers.tv
                                      www.seelightbox.de
                                    www.lbos.seelightbox.de
********************************************************************************
}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,DMX4ALL_Defines, Menus;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Ch1: TScrollBar;
    Ch2: TScrollBar;
    Ch3: TScrollBar;
    Ch4: TScrollBar;
    CL1: TLabel;
    CL2: TLabel;
    CL3: TLabel;
    CL4: TLabel;
    ScrollBar5: TScrollBar;
    StatusBar1: TStatusBar;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button1: TButton;
    Button2: TButton;
    VL1: TLabel;
    VL2: TLabel;
    VL3: TLabel;
    VL4: TLabel;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    SetallDMXchannelsto2551: TMenuItem;
    ResetallDMXchannelsto01: TMenuItem;
    procedure ScrollBar5Change(Sender: TObject);
    procedure ChChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SetallDMXchannelsto2551Click(Sender: TObject);
    procedure ResetallDMXchannelsto01Click(Sender: TObject);
  private
    Procedure SetInfoBox;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  Values : Array [1..512] of Byte;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
 if not DMX4ALLRebootinterface then ErrorMess;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 DMX4ALLUpdateFirmware;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
SetInfoBox;
end;

procedure TForm1.ChChange(Sender: TObject);
VAR Value:Byte;
    Slider : TScrollbar;
    VLabel : TLabel;
begin
 Slider:=(Sender as TScrollbar);
 VLabel:=(FindComponent('VL'+inttostr(Slider.tag-Scrollbar5.Position))as TLabel);
 Value:=255-Slider.Position;
 VLabel.caption:=inttostr(Value);
 Values[Slider.Tag]:=Value;
 DMX4ALLSetDMXch(Slider.tag,Value);
end;

Function GetVerString(V:Integer):String;
VAR Ver:String;
begin
 Ver:=inttostr(V);
 Result:=Ver[1]+'.'+Ver[2]+Ver[3];
end;

procedure TForm1.SetallDMXchannelsto2551Click(Sender: TObject);
VAR I:integer;
begin
 SetLength(DMX_Data,512);
 for I := 0 to high(DMX_Data) do
  begin
   DMX_Data[i]:=255;
   Values[i+1]:=255;
  end;
  Scrollbar5.OnChange(Sender);
 DMX4ALLSetDMX(1,length(DMX_Data),DMX_Data);
end;

procedure TForm1.ResetallDMXchannelsto01Click(Sender: TObject);
VAR I:Integer;
begin
 SetLength(DMX_Data,512);
 for I := 0 to high(DMX_Data) do
  begin
   DMX_Data[i]:=0;
   Values[i+1]:=0;
  end;
 Scrollbar5.OnChange(Sender);
 DMX4ALLSetDMX(1,length(DMX_Data),DMX_Data);
end;

Procedure TForm1.SetInfoBox;
begin
//Das Record Version_Info wird mit Daten gefüllt
//The record Version_Info will be filled with data
 if DMX4ALLGetInfo then
  begin
   Memo1.Clear;
   Memo1.Lines.Add(Version_Info.InfoText);
   Memo1.Lines.add('');
   Memo1.Lines.add('Hardware Version:  '+getverstring(Version_Info.HW_Version));
   Memo1.Lines.add('DLL Version:       '+getverstring(Version_Info.DLL_Verison));
   Memo1.Lines.add('Used DMX Channels: '+inttostr(Version_Info.NrOfDMXData));
   Memo1.Lines.add('Signal Output:     '+Booltostr(Version_Info.SignalOutput,true));
   if Version_Info.SignalOutput then Radiobutton2.Checked:=true;
  end;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DMX4ALLClearComPort;
end;

procedure TForm1.FormShow(Sender: TObject);
VAR Port:Integer;
    Baudrate:DWord;
begin
//Es wird nach einem Interface von Port1 - 256 gesucht.
//Search an interface from port 1 up to 256.
 DMX4ALLFindInterface(255);
  if DMX4ALLGetComParameters(Port,Baudrate) then
  // Wenn ein Interface gefunden wurde ist port immer größer als 0
  // If they found an interface, port will be higher as 0.
    begin
     if Port>0 then
      begin
       Statusbar1.Panels[0].Text:='ONLINE';
       SetInfoBox;
       //USB-Port = 256
       if Port=USB_PORT then Statusbar1.Panels[1].Text:='USB-Port' else
        StatusBar1.Panels[1].Text:='COM '+inttostr(PORT);
      end
       else
        Statusbar1.Panels[0].Text:='OFFLINE';
    end;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
//XLR Pins werden auf Internationale Belegung geschaltet
//XLR Pins will be switched to international pins
 DMX4ALLSetPinOut(True);
 SetInfoBox;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
//XLR Pins werden auf Martin Belegung geschaltet (verdreht)
//XLR Pins will be swiched to Martin Pins (swap)
 DMX4ALLSetPinOut(False);
  SetInfoBox;
end;



procedure TForm1.ScrollBar5Change(Sender: TObject);
VAR I : Integer;
    Slider : TScrollbar;
    ALabel : TLabel;
    VLabel : TLabel;
begin
 for I := 1 to 4 do
  begin
   Slider:=(FindComponent('Ch'+inttostr(i))as TScrollbar);
   ALabel:=(FindComponent('CL'+inttostr(i))as TLabel);
   VLabel:=(FindComponent('VL'+inttostr(i))as TLabel);
   Slider.Tag:=Scrollbar5.Position+i;
   VLabel.Tag:=Scrollbar5.Position+i;
   Slider.Position:=255-Values[Slider.Tag];
   VLabel.Caption:=Inttostr(Values[Slider.tag]);
   ALabel.Caption:=Inttostr(Scrollbar5.Position+i);
  end;
end;

end.
