unit dimmcurvefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Math, pngimage, JvExControls,
  JvGradient, gnugettext;

type
  Tdimmcurveform = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    TreeView1: TTreeView;
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    Label5: TLabel;
    PaintBox2: TPaintBox;
    ComboBox2: TComboBox;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    ComboBox1: TComboBox;
    Label1: TLabel;
    PaintBox1: TPaintBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private-Deklarationen }
    _Buffer:TBitmap;
    procedure TreeviewChanged;
    procedure RepaintGraph;
  public
    { Public-Deklarationen }
    aktuellesgeraet:integer;
  end;

var
  dimmcurveform: Tdimmcurveform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tdimmcurveform.FormShow(Sender: TObject);
var
  i:integer;
begin
  Paintbox1.Canvas.Brush.Color := clBlack;
  Paintbox1.Canvas.FillRect(Paintbox1.Canvas.ClipRect);
  Paintbox2.Canvas.Brush.Color := clBlack;
  Paintbox2.Canvas.FillRect(Paintbox2.Canvas.ClipRect);

  if (aktuellesgeraet>=0) and (aktuellesgeraet<length(mainform.devices)) then
  begin
    label4.Caption:=mainform.devices[aktuellesgeraet].Name;

    Treeview1.Items.Clear;
    for i:=0 to mainform.devices[aktuellesgeraet].MaxChan-1 do
    begin
      Treeview1.Items.Add(nil,mainform.devices[aktuellesgeraet].kanalname[i])
    end;
  end;

  if Treeview1.Items.Count>0 then
  begin
    Treeview1.Select(Treeview1.Items[0]);
    TreeviewChanged;
  end;

  Combobox1.Enabled:=Treeview1.Selected.Index>-1;
  Combobox2.Enabled:=Treeview1.Selected.Index>-1;

  Timer1.Enabled:=true;
end;

procedure Tdimmcurveform.TreeView1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TreeviewChanged;
end;

procedure Tdimmcurveform.TreeviewChanged;
begin
  Combobox1.Enabled:=Treeview1.Selected.Index>-1;
  Combobox2.Enabled:=Treeview1.Selected.Index>-1;

  if Treeview1.Selected.Index>-1 then
  begin
    Combobox1.ItemIndex:=mainform.Devices[aktuellesgeraet].kanaldimmcurve[Treeview1.Selected.Index];
    Combobox1Change(nil);
    Combobox2.ItemIndex:=mainform.Devices[aktuellesgeraet].kanalabsolutedimmcurve[Treeview1.Selected.Index];
    Combobox2Change(nil);
  end;
end;

procedure Tdimmcurveform.TreeView1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TreeviewChanged;
end;

procedure Tdimmcurveform.Timer1Timer(Sender: TObject);
begin
  RepaintGraph;
end;

procedure Tdimmcurveform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled:=false;
end;

procedure Tdimmcurveform.RepaintGraph;
var
  i,y,lasty:integer;
  maxres:byte;
begin
  // Graph 1
  _Buffer.Canvas.Brush.Color := clBlack;
  _Buffer.Canvas.FillRect(_Buffer.Canvas.ClipRect);

  if Treeview1.Selected.Index>-1 then
  begin
    maxres:=127;
    _Buffer.Width:=Paintbox1.Width;
    _Buffer.Height:=Paintbox1.Height;

    _Buffer.Canvas.Brush.Color := clBlack;
    _Buffer.Canvas.FillRect(_Buffer.Canvas.ClipRect);

    _Buffer.Canvas.Pen.Color:=clYellow;
    _Buffer.Canvas.MoveTo(15+0,_Buffer.Height-0-15);
    _Buffer.Canvas.LineTo(15+0,_Buffer.Height-maxres-15);
    _Buffer.Canvas.MoveTo(15+0,_Buffer.Height-0-15);
    _Buffer.Canvas.LineTo(15+maxres,_Buffer.Height-0-15);

    _Buffer.Canvas.Pen.Color:=clLime;
    y:=0;
    lasty:=0;
    for i:=0 to maxres do
    begin
      case Combobox1.ItemIndex of
        0: y:=i;  // Linear
        1: if i < (maxres div 2) then y:=0 else y:=maxres; // Schalten
        2: y:=round(sin((i/maxres)*(pi/2))*maxres); // Viertel-Sinus
        3: y:=maxres-round(sin(((maxres-i)/maxres)*(pi/2))*maxres); // Viertel-Sinus Invertiert
        4: y:=round(((cos(((maxres-i)/maxres)*pi)+1)/2)*maxres); // Halber Cosinus
        5: y:=round(power(((cos(power(((maxres-i)/maxres),2)*pi)+1)/2),4)*maxres); // Gestauchter halber Cosinus
        6: y:=round((power(((i-64)/16),3)+64));
        7:
        begin
          if (i>=0) and (i<(maxres div 5 * 1)) then y:=0;
          if (i>=(maxres div 5 * 1)) and (i<(maxres div 5 * 2)) then y:=(maxres div 5 * 1);
          if (i>=(maxres div 5 * 2)) and (i<(maxres div 5 * 3)) then y:=(maxres div 5 * 2);
          if (i>=(maxres div 5 * 3)) and (i<(maxres div 5 * 4)) then y:=(maxres div 5 * 3);
          if (i>=(maxres div 5 * 4)) and (i<(maxres div 5 * 5)) then y:=(maxres div 5 * 4);
          if (i>=maxres) then y:=maxres;
        end;
        8: y:=round(i+sin(i/4)*10);
        9: y:=round(i+sin(i/4)*40);
        10: if i=maxres then y:=maxres else y:=round((log2((255-((i/maxres)*255))/255)/(-8))*maxres);
        11: if i=maxres then y:=maxres else y:=round((((power(100,(((i/maxres)*255)/500))-1)/(((i/maxres)*255)-1))*(((i/maxres)*255)/9.5))*maxres);
      end;
      if y<0 then y:=0;
      if y>maxres then y:=maxres;

      _Buffer.Canvas.MoveTo(15+i,_Buffer.Height-lasty-15);
      _Buffer.Canvas.LineTo(15+i+1,_Buffer.Height-y-15);
      lasty:=y;
    end;
  end;

  BitBlt(Paintbox1.Canvas.Handle,0,0,Paintbox1.Width,Paintbox1.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);

// Graph 2
  _Buffer.Canvas.Brush.Color := clBlack;
  _Buffer.Canvas.FillRect(_Buffer.Canvas.ClipRect);

  if Treeview1.Selected.Index>-1 then
  begin
    maxres:=127;
    _Buffer.Width:=Paintbox2.Width;
    _Buffer.Height:=Paintbox2.Height;

    _Buffer.Canvas.Brush.Color := clBlack;
    _Buffer.Canvas.FillRect(_Buffer.Canvas.ClipRect);

    _Buffer.Canvas.Pen.Color:=clYellow;
    _Buffer.Canvas.MoveTo(15+0,_Buffer.Height-0-15);
    _Buffer.Canvas.LineTo(15+0,_Buffer.Height-maxres-15);
    _Buffer.Canvas.MoveTo(15+0,_Buffer.Height-0-15);
    _Buffer.Canvas.LineTo(15+maxres,_Buffer.Height-0-15);

    _Buffer.Canvas.Pen.Color:=clLime;
    y:=0;
    lasty:=0;
    for i:=0 to maxres do
    begin
      case Combobox2.ItemIndex of
        0: y:=i;  // Linear
        1: if i < (maxres div 2) then y:=0 else y:=maxres; // Schalten
        2: y:=round(sin((i/maxres)*(pi/2))*maxres); // Viertel-Sinus
        3: y:=maxres-round(sin(((maxres-i)/maxres)*(pi/2))*maxres); // Viertel-Sinus Invertiert
        4: y:=round(((cos(((maxres-i)/maxres)*pi)+1)/2)*maxres); // Halber Cosinus
        5: y:=round(power(((cos(power(((maxres-i)/maxres),2)*pi)+1)/2),4)*maxres); // Gestauchter halber Cosinus
        6: y:=round((power(((i-64)/16),3)+64));
        7:
        begin
          if (i>=0) and (i<(maxres div 5 * 1)) then y:=0;
          if (i>=(maxres div 5 * 1)) and (i<(maxres div 5 * 2)) then y:=(maxres div 5 * 1);
          if (i>=(maxres div 5 * 2)) and (i<(maxres div 5 * 3)) then y:=(maxres div 5 * 2);
          if (i>=(maxres div 5 * 3)) and (i<(maxres div 5 * 4)) then y:=(maxres div 5 * 3);
          if (i>=(maxres div 5 * 4)) and (i<(maxres div 5 * 5)) then y:=(maxres div 5 * 4);
          if (i>=maxres) then y:=maxres;
        end;
        8: y:=round(i+sin(i/4)*10);
        9: y:=round(i+sin(i/4)*40);
        10: if i=maxres then y:=maxres else y:=round((log2((255-((i/maxres)*255))/255)/(-8))*maxres);
        11: if i=maxres then y:=maxres else y:=round((((power(100,(((i/maxres)*255)/500))-1)/(((i/maxres)*255)-1))*(((i/maxres)*255)/9.5))*maxres);
      end;
      if y<0 then y:=0;
      if y>maxres then y:=maxres;

      _Buffer.Canvas.MoveTo(15+i,_Buffer.Height-lasty-15);
      _Buffer.Canvas.LineTo(15+i+1,_Buffer.Height-y-15);
      lasty:=y;
    end;
  end;

  BitBlt(Paintbox2.Canvas.Handle,0,0,Paintbox2.Width,Paintbox2.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Tdimmcurveform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  _Buffer := TBitmap.Create;
end;

procedure Tdimmcurveform.ComboBox2Change(Sender: TObject);
var
  i:integer;
begin
  RepaintGraph;

  if Treeview1.Selected.Index>-1 then
  begin
    if Sender<>nil then
    begin
      for i:=0 to length(mainform.devices)-1 do
      begin
        if (mainform.devices[i].Startaddress>=(mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index)) and (mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1<=(mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index)) and (i<>aktuellesgeraet) and (mainform.Devices[i].kanalabsolutedimmcurve[mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index-mainform.devices[i].Startaddress]<>Combobox2.ItemIndex) then
        begin
          if messagedlg(_('Ein anderer Gerätekanal (')+mainform.Devices[i].Name+': '+mainform.Devices[i].Kanalname[mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index-mainform.devices[i].Startaddress]+(') belegt die gleiche Adresse wie der ausgewählte Kanal.')+#10#13+_('Es kann allerdings nur eine Kurve pro Kanal genutzt werden.')+#10#13#10#13+_('Soll die Kurvenform des anderen Gerätekanals nun automatisch angepasst werden?'),mtConfirmation,
            [mbYes,mbNo],0)=mrYes then
              mainform.Devices[i].kanalabsolutedimmcurve[mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index-mainform.devices[i].Startaddress]:=Combobox2.ItemIndex;
        end;
      end;

      mainform.Devices[aktuellesgeraet].kanalabsolutedimmcurve[Treeview1.Selected.Index]:=Combobox2.ItemIndex;
      mainform.channel_absolutedimmcurve[mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index]:=mainform.Devices[aktuellesgeraet].kanalabsolutedimmcurve[Treeview1.Selected.Index];
    end;
  end;
end;

procedure Tdimmcurveform.CreateParams(var Params:TCreateParams);
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

procedure Tdimmcurveform.ComboBox1Change(Sender: TObject);
var
  i:integer;
begin
  RepaintGraph;

  if Treeview1.Selected.Index>-1 then
  begin
    if Sender<>nil then
    begin
      for i:=0 to length(mainform.devices)-1 do
      begin
        if (mainform.devices[i].Startaddress>=(mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index)) and (mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1<=(mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index)) and (i<>aktuellesgeraet) and (mainform.Devices[i].kanaldimmcurve[mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index-mainform.devices[i].Startaddress]<>Combobox1.ItemIndex) then
        begin
          if messagedlg(_('Ein anderer Gerätekanal (')+mainform.Devices[i].Name+': '+mainform.Devices[i].Kanalname[mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index-mainform.devices[i].Startaddress]+_(') belegt die gleiche Adresse wie der ausgewählte Kanal.')+#10#13+_('Es kann allerdings nur eine Kurve pro Kanal genutzt werden.')+#10#13#10#13+_('Soll die Kurvenform des anderen Gerätekanals nun automatisch angepasst werden?'),mtConfirmation,
            [mbYes,mbNo],0)=mrYes then
              mainform.Devices[i].kanaldimmcurve[mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index-mainform.devices[i].Startaddress]:=Combobox1.ItemIndex;
        end;
      end;

      mainform.Devices[aktuellesgeraet].kanaldimmcurve[Treeview1.Selected.Index]:=Combobox1.ItemIndex;
      mainform.channel_dimmcurve[mainform.Devices[aktuellesgeraet].Startaddress+Treeview1.Selected.Index]:=mainform.Devices[aktuellesgeraet].kanaldimmcurve[Treeview1.Selected.Index];
    end;
  end;
end;

end.
