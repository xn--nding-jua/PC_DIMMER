unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdCustomTCPServer, IdTCPServer, IdContext;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Image1: TImage;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    idclient: TIdTCPClient;
    Label5: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    ipaddress, portaddress, befehl:string;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if paramcount <> 3 then begin close; exit; end;

  Timer1.Enabled:=false;
  form1.Refresh;

  try
    idclient.Connect(ipaddress, strtoint(portaddress));
    idclient.Socket.WriteLn(befehl);

    if idclient.Socket.ReadLn=befehl then
    begin
      label5.Visible:=true;
      idclient.Disconnect;
    end else
    begin
      idclient.Socket.WriteLn(befehl);

      if idclient.Socket.ReadLn=befehl then
      begin
        label5.Visible:=true;
        idclient.Disconnect;
      end else
      begin
        idclient.Socket.WriteLn(befehl);

        if idclient.Socket.ReadLn=befehl then
        begin
          label5.Visible:=true;
          idclient.Disconnect;
        end else
        begin
          Showmessage('Server nicht erreichbar bzw. mehrfach fehlerhafte Übertragung...');
        end;
      end;
    end;
  except
  end;

  idclient.Disconnect;
  close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if paramcount <> 3 then
  begin
    showmessage('Bitte das Programm mit folgenden Parametern starten (Beispiel siehe unten):'+#13#10#13#10+
    '"C:\...\PC_DIMMER_CMD.exe" IP Port "Befehl"'+#13#10#13#10#13#10+
    'Mögliche Befehle:'+#13#10+
    '"set_channel ID KANALNAME START END ZEIT DELAY"'+#13#10+
    '"set_absolutchannel KANAL START END ZEIT DELAY"'+#13#10+
    '"start_scene ID"'+#13#10+
    '"stop_scene ID"'+#13#10#13#10+
    'Informationen zu weiteren Befehlen auf http://www.pcdimmer.de.'+#13#10#13#10+
    'Befehle können auch durch Semikola aneinandergereiht werden. Beispiel:'+#13#10+
    '"C:\...\PC_DIMMER_CMD.exe" 127.0.0.1 10160 "set_absolutchannel 1 -1 255 4000 0;set_absolutchannel 2 -1 255 4000 0"');
  end;
  ipaddress:=paramstr(1);
  portaddress:=paramstr(2);
  befehl:=paramstr(3);

  Application.ShowMainForm:=paramcount<>3;

  label2.Caption:=ipaddress;
  label3.Caption:=portaddress;
  label4.Caption:=befehl;

  timer1.Enabled:=true;
end;

end.
