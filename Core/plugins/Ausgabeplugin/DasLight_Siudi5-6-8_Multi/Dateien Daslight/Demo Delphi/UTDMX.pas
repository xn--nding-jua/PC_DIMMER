{
 CD : Christophe Dufeutrelle - 20010515 - c.dufeutrelle@system-d.fr

 Pgm basé sur du code delphi de Micheal Ebner.

 Ce petit programme reprend les fonctionalités de slmini

 Toutes utilisations possibles.
 Sans aucunes garanties de fonctionnement.

 Au lieu de sélectioner les ports un par un dans une liste déroulante, je
 les ai tous affichés à l'aide de 8 TSHAPES. Les boutons permettent de
 passer du mode Input (Bouton au repos) au mode Output (Bouton enfoncé)
 pour chaque port. En mode Output on peut passé du mode off au mode On du port
 en cliquant sur le TShape concerné.

 N'utilise que la VCL Standard.
 Testé en DELPHI 5.

 Grosses différences d'analyse par rapport à slmini.cpp :

 Le tableau booleen ports_out est remplacé par la propriété down du tableau de
 SpeedButton SB
 Le tableau Out_mode est conservé, mais il est mis à jour par le click sur les
 tshape indiquant les 8 bits des ports.
 La gestion de la glissière des valeurs est négative pour avoir la valeur minimale
 en bas, les valeurs sont donc -<valeur glissière>

 SP : Stéphane PEREZ - 16-02-2006 - dmx@avtek.fr
 adaptation pour le SUIDI 6C
 }

unit UTDMX;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, AdStatLt, ComCtrls, Buttons,Math;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    GB_Ports: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Shape0: TShape;
    Bevel2: TBevel;
    Shape1: TShape;
    GB_DMX: TGroupBox;
    DMX_V: TTrackBar;
    DMX_C: TTrackBar;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SB1: TSpeedButton;
    SB2: TSpeedButton;
    SB3: TSpeedButton;
    SB4: TSpeedButton;
    SB5: TSpeedButton;
    SB6: TSpeedButton;
    SB7: TSpeedButton;
    SB8: TSpeedButton;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Label7: TLabel;
    Label8: TLabel;
    StatusBar1: TStatusBar;
    btSerial: TSpeedButton;
    btVersion: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure DMX_CChange(Sender: TObject);
    procedure DMX_VChange(Sender: TObject);
    procedure DMX_display_channel;
    procedure DMX_Display_ports(ports : integer);
    procedure DMX_Display_Shape(ports,i : integer);
    procedure ShapeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMX_Set_Port;
    procedure SBClick(Sender: TObject);
    procedure btSerialClick(Sender: TObject);
    procedure btVersionClick(Sender: TObject);
  private
    { Déclarations privées }
    interface_open: integer;
    dmx_level: array[0..511] of char;
    ShapePortColor : TColor;
    SB       : array[2..9] of TSpeedButton;
    SH       : array[0..9] of TShape;
    Out_Mode : array[2..9] of boolean;
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

const
  DHC_OPEN       =  1;
  DHC_CLOSE			 =	2;
  DHC_DMXOUTOFF	 =	3;
  DHC_DMXOUT		 =	4;
  DHC_PORTREAD	 =	5;
  DHC_PORTCONFIG =  6;
  DHC_VERSION		 =  7;
  DHC_DMXIN			 =	8;
  DHC_INIT			 =	9;
  DHC_EXIT			 = 10;
  DHC_DMXSCODE	 = 11;
  DHC_DMX2ENABLE = 12;
  DHC_DMX2OUT		 = 13;
  DHC_SERIAL		 = 14;



// CD stdcall plante , la pile n'est pas restaurée !!!
//function DasHardCommand(Command, Param: integer; Bloc: PChar): integer;
//  stdcall; external 'dashard.dll';
// SP : Changement de la DLL .

function DasUsbCommand(Command, Param: integer; Bloc: PChar): integer;
  cdecl; external 'dashard2006.dll';

{$R *.DFM}

////////////////////////////////////////////////////////////////////////////////
// CD - Initialisation
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.FormCreate(Sender: TObject);
var
   i,
   v: integer;
begin
     // SP : Modification de la commande d'ouverture de l'interface
     interface_open := DasUSBCommand(DHC_INIT, 0, nil);
     interface_open := DasUSBCommand(DHC_OPEN, 0, nil);
     if interface_open > 0 then
         v := DasUSBCommand(DHC_DMXOUTOFF, 0, nil)
        else
     begin
          showmessage ('Erreur : Ne trouve pas l''interface "Intelligent USB DMX"');
          application.terminate;
          exit;
     end;

     for i := 0 to 511
          do dmx_level[i] := Char(0);

     for i := 2 to 9 do // CD - Attention démarrage à 2
       Out_Mode[i] := False;

     DMX_C.position := 1;
     dmx_display_channel;

     // CD - Pas joli, mais efficace !!!

     SB[2] := SB1;
     SB[3] := SB2;
     SB[4] := SB3;
     SB[5] := SB4;
     SB[6] := SB5;
     SB[7] := SB6;
     SB[8] := SB7;
     SB[9] := SB8;
     SH[0] := Shape0; // CD - Bt Next
     SH[1] := Shape1; // CD - Bt Prev
     SH[2] := Shape2; // CD - Port N° 1
     SH[3] := Shape3;
     SH[4] := Shape4;
     SH[5] := Shape5;
     SH[6] := Shape6;
     SH[7] := Shape7;
     SH[8] := Shape8;
     SH[9] := Shape9; // CD - Port N° 8

     btSerial.Click;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     // SP : Modification de la fermeture de l'interface .
     Timer1.Enabled := false;
     if interface_open > 0 then
       interface_open := DasUSBCommand(DHC_CLOSE, 0, nil);
     interface_open := DasUSBCommand(DHC_EXIT, 0, nil);
end;

////////////////////////////////////////////////////////////////////////////////
// CD - Gestion du timer
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Timer1Timer(Sender: TObject);
var
   v, ports: integer;
begin
     if interface_open > 0 then
     begin
          // CD - Lecteur des ports sur 10 Bits
          ports := DasUSBCommand(DHC_PORTREAD, 0, nil);
          DMX_Display_Ports(ports);

          // CD - Envoi du block dmx_level à l'interface
          v := DasUSBCommand(DHC_DMXOUT, 512, dmx_level);
          if v < 0 then
          begin
               DasUSBCommand(DHC_CLOSE, 0, nil);
               interface_open := DasUSBCommand(DHC_OPEN, 0, nil);
          end;
     end;
end;


////////////////////////////////////////////////////////////////////////////////
// CD Affichage
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.DMX_Display_Shape(ports,i : integer);
var
   bit : integer;
   Shape : TShape;
begin
     Shape := SH[i];
{$B-}
     if (i < 2) or (not SB[i].down) then // CD - Next Prev et Input
     begin
          bit := trunc(Intpower(2,i));
          // CD - Gestion de la couleur des tshapes pour les ports input
          if ((ports and bit) = 0) and (Shape.Brush.color <> ShapePortColor) then
               Shape.Brush.Color := ShapePortColor;
          if ((ports and bit) = bit) and (Shape.Brush.color <> clgray) then
               Shape.Brush.color := clGray;
     end
        else // CD - mode Output
     begin
          if Out_Mode[i] and (Shape.Brush.color <> clLime) then
              Shape.Brush.Color := clLime;
          if (not Out_Mode[i]) and (Shape.Brush.color <> clgray) then
              Shape.Brush.color := clGray;
     end;
{$B+}
end;

procedure TForm1.DMX_Display_ports(ports : integer);
var
   i : integer;
begin
     GB_Ports.caption := 'Ports : ' + inttostr(Ports);

     ShapePortColor := clred;

     for i := 0 to 9 do
            DMX_Display_Shape (ports,i);
end;

////////////////////////////////////////////////////////////////////////////////
// CD - Gestion des glissieres avec leurs libelles
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.dmx_display_channel;
begin
     Label3.caption := 'Channel : ' + inttostr(DMX_C.position);
     DMX_V.position := -ord(dmx_level[DMX_C.position-1]);
     Label5.caption := inttostr(-DMX_V.position);
end;

procedure TForm1.DMX_CChange(Sender: TObject);
begin
     DMX_Display_Channel;
end;

procedure TForm1.DMX_VChange(Sender: TObject);
begin
     dmx_level[DMX_C.position-1] := chr(-DMX_V.position);
     DMX_Display_Channel;
end;

////////////////////////////////////////////////////////////////////////////////
// CD - Gestion des ports en output
////////////////////////////////////////////////////////////////////////////////

procedure TForm1.ShapeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   i : integer;
   Sh : TShape;
begin
     Sh := TShape(sender);
     i := strtoint(copy (Sh.name,6,1));
     if SB[i].down then
          Out_Mode[i] := not Out_Mode[i];
     DMX_Set_Port;
end;

procedure TForm1.SBClick(Sender: TObject);
begin
     DMX_Set_Port;
end;

//
// CD - Dans la documentation les 8 bits de poids faibles indiquent Input/output
// et les 8 bits de poids fort indiquent Off ou On
// Or dans l'exemple en CPP (slmini.cpp - fonction Send_Config_port) c'est
// exactement le contraire qui est écrit
// L'exemple suivant prend comme hypothèse que les bits de poids faibles sont
// les bits 0 à 7 (0 à 255), ce qui normalement le cas. Et considère la doc
// sur la DLL DASHARD.DLL correcte.
// De plus peut on envoyer 256 par exemple qui donnerait le port 1 en input ON ?
//
procedure TForm1.DMX_Set_Port;
var
   i,conf,ok : integer;
begin
     conf := 0;
     for i := 2 to 9 do
     begin
          if SB[i].down then
          begin
               conf := conf + trunc(IntPower(2,i-2)); // CD - -2 car array [2..9]
               if Out_Mode[i] then
                    conf := conf + trunc(IntPower(2,i-2+8)); // CD - -2 car array [2..9] + 8 pour le décalage des bits de poids fort
          end;
     end;
     ok := DasUSBCommand(DHC_PORTCONFIG, conf, nil);
     StatusBar1.Simpletext := 'Status pour configuration ('+inttostr(conf)+') : ' + inttostr(ok);
end;


procedure TForm1.btSerialClick(Sender: TObject);
var
   ok : integer;
begin
     // SP : Lecture du n° de  Série .

     ok := DasUSBCommand(DHC_SERIAL, 0, nil);
     StatusBar1.Simpletext := 'Serial : ' + inttostr(ok);
end;

procedure TForm1.btVersionClick(Sender: TObject);
var
   ok : integer;
begin
     // SP : Lecture de la version du firmware .
     ok := DasUSBCommand(DHC_VERSION, 0, nil);
     StatusBar1.Simpletext := 'Version : ' + inttostr(ok);
end;

end.
