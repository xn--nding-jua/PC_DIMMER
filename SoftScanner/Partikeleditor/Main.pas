{
* This program is licensed under the GNU Lesser General Public License Version 2
* You should have recieved a copy of the license with this file.
* If not, see http://www.gnu.org/licenses/lgpl.html for more informations
*
* Project: Andorra 2D
* Authors:  Andreas Stoeckel
* File: Main.pas
* Comment: This is a particle editor.
}

unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdDraws, AdParticles, AdClasses, ExtCtrls, StdCtrls, Menus, XPMan,
  ComCtrls, ExtDlgs, Math;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Close1: TMenuItem;
    Images1: TMenuItem;
    Loadnewimagefile1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Image1: TImage;
    ListBox1: TListBox;
    Button2: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit5: TEdit;
    Image2: TImage;
    XPManifest1: TXPManifest;
    CheckBox2: TCheckBox;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Button3: TButton;
    Button4: TButton;
    Environment1: TMenuItem;
    Backgroundcolor1: TMenuItem;
    ColorDialog1: TColorDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Edit7: TEdit;
    Label9: TLabel;
    Button5: TButton;
    GroupBox4: TGroupBox;
    Edit8: TEdit;
    Label11: TLabel;
    GroupBox5: TGroupBox;
    Label16: TLabel;
    Label19: TLabel;
    Edit11: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit12: TEdit;
    Label18: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Edit13: TEdit;
    Label22: TLabel;
    Edit14: TEdit;
    Label23: TLabel;
    Edit15: TEdit;
    Label24: TLabel;
    Edit16: TEdit;
    Label25: TLabel;
    GroupBox6: TGroupBox;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    ScrollBar3: TScrollBar;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    ScrollBar4: TScrollBar;
    Label33: TLabel;
    PaintBox1: TPaintBox;
    RadioButton1: TRadioButton;
    Label10: TLabel;
    Edit17: TEdit;
    RadioButton2: TRadioButton;
    Label34: TLabel;
    Edit18: TEdit;
    Label35: TLabel;
    Label36: TLabel;
    N1: TMenuItem;
    LoadFile1: TMenuItem;
    N2: TMenuItem;
    Save1: TMenuItem;
    Saveas1: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Label37: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ListBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox2Click(Sender: TObject);
    procedure Backgroundcolor1Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit6Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure Edit13Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Edit17Change(Sender: TObject);
    procedure Edit18Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure LoadFile1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
  private
    { Private-Deklarationen }
  public

    AdDraw1:TAdDraw;
    AdImg1:TAdImage;

    PerCount:TAdPerformanceCounter;
    PartSys:TAdParticleSystem;

    pc,pc2:double;
    interval:boolean;
    changing:boolean;

    mx,my:integer;
    BackgroundColor:TColor;

    CurrentFileName:string;
    procedure ApplicationIdle(Sender:TObject; var Done:boolean);
    procedure Render;
    procedure DrawColorPreview;
    procedure UpdateControls;
    procedure DrawAnglePreview;
  end;

var
  Form1: TForm1;

const
  path = 'particles\';

implementation

{$R *.dfm}

procedure TForm1.ApplicationIdle(Sender: TObject; var Done: boolean);
begin
  Render;
  done := false;
end;


procedure TForm1.Backgroundcolor1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    BackgroundColor := ColorDialog1.Color;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var bmp:TBitmap;
    adbmp:TAdBitmap;
begin
  if OpenPictureDialog1.FileName = '' then
  begin
    if not DirectoryExists(path) then
    begin
      OpenPictureDialog1.InitialDir := ExtractFilePath(ParamStr(0));
    end
    else
    begin
      OpenPictureDialog1.InitialDir := ExtractFilePath(ParamStr(0))+path;
    end;
  end;
  if OpenPictureDialog1.Execute then
  begin
    bmp := TBitmap.Create;
    bmp.LoadFromFile(OpenPictureDialog1.FileName);
    AdImg1 := TAdImage.Create(AdDraw1);
    adbmp := TAdBitmap.Create;
    adbmp.AssignBitmap(bmp);
    adbmp.AssignAlphaChannel(bmp);
    AdImg1.Texture.Texture.LoadFromBitmap(adbmp);
    adbmp.Free;
    AdImg1.Color := clWhite;
    AdImg1.Restore;
    PartSys.Texture.Free;
    PartSys.Texture := AdImg1.Texture;
    Image2.Picture.Bitmap.Assign(bmp);
    bmp.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  PartSys.DefaultParticle.Colors.Add(Ad_ARGB(StrToIntDef(Edit5.Text,255),
                                             StrToIntDef(Edit2.Text,255),
                                             StrToIntDef(Edit3.Text,255),
                                             StrToIntDef(Edit4.Text,255)));
  UpdateControls;
  ListBox1Click(nil);  
end;

procedure TForm1.Button3Click(Sender: TObject);
var i,e:integer;
begin
  i := ListBox1.ItemIndex;
  e := ListBox1.ItemIndex - 1;
  ListBox1.Items.Exchange(i,e);
  PartSys.DefaultParticle.Colors.Exchange(i,e);
  ListBox1.ItemIndex := e;
  ListBox1Click(nil);
  ListBox1.Repaint;
  DrawColorPreview;
end;

procedure TForm1.Button4Click(Sender: TObject);
var i,e:integer;
begin
  i := ListBox1.ItemIndex;
  e := ListBox1.ItemIndex + 1;
  ListBox1.Items.Exchange(i,e);
  PartSys.DefaultParticle.Colors.Exchange(i,e);
  ListBox1.ItemIndex := e;
  ListBox1Click(nil);
  ListBox1.Repaint;
  DrawColorPreview;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  PartSys.Items.Clear;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  UpdateControls;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  PartSys.DefaultParticle.DrawMask := CheckBox2.Checked;
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if changing then exit;
  case Combobox1.ItemIndex of
    0:PartSys.DefaultParticle.BlendMode := bmAlpha;
    1:PartSys.DefaultParticle.BlendMode := bmAdd;
    2:PartSys.DefaultParticle.BlendMode := bmMask;
  end;
end;

procedure TForm1.DrawAnglePreview;
var p1x,p1y,p2x,p2y:integer;
    abmp:TBitmap;
begin
  abmp := TBitmap.Create;
  abmp.Width := 100;
  abmp.Height := 100;
  abmp.Transparent := true;
  abmp.TransparentColor := clWhite;
  with abmp.Canvas do
  begin
    Brush.Color := clWhite;
    Pen.Color := Brush.Color;
    Rectangle(0,0,100,100);
    Pen.Color := clBlack;
    Brush.Color := rgb(235,235,255);
    Ellipse(0,0,100,100);
    Pen.Color := clGray;
    Brush.Color := clSkyBlue;
    with PartSys.DefaultParticle do
    begin
      p1x := round(cos((CreationAngle+CreationAngleOpen / 2)*PI/180)*50)+50;
      p1y := round(sin((CreationAngle+CreationAngleOpen / 2)*PI/180)*50)+50;
      p2x := round(cos((CreationAngle-CreationAngleOpen / 2)*PI/180)*50)+50;
      p2y := round(sin((CreationAngle-CreationAngleOpen / 2)*PI/180)*50)+50;
      Pie(0,0,100,100,p1x,p1y,p2x,p2y);
      Pen.Color := clSkyBlue;
      Brush.Color := clSkyBlue;
      Ellipse(40,40,60,60);
      Brush.Color := clBlue;
      Pen.Color := clGray;
      Pie(40,40,60,60,p1x,p1y,p2x,p2y);

      Pen.Color := clRed;
      MoveTo(50,50);
      LineTo(round(50+Force.X/10),round(50+Force.Y/10));
    end;
  end;
  PaintBox1.Canvas.Draw(0,0,abmp);
  abmp.Free;
end;

procedure TForm1.DrawColorPreview;
var x,y,i:integer;
    acol:TColor;
    acol2:TAndorraColor;
    a:double;
begin
  with Image1.Picture.Bitmap.Canvas do
  begin
    //First draw a black and white chess field
    i := 0;
    for x := 0 to 54 do
      for y := 0 to 6 do
      begin
        i := i + 1;
        if i mod 2 = 0 then
        begin
          brush.Color := clBlack;
          pen.Color := clBlack;
        end
        else
        begin
          brush.Color := clGray;
          pen.Color := clGray;
        end;
        rectangle(x*4,y*4,(x+1)*4,(y+1)*4);
      end;

    //Then draw the colors
    for x := 0 to 216 do
    begin
      for y := 0 to 24 do
      begin
        acol2 := PartSys.DefaultParticle.Colors.GetColor(216,x);
        a := acol2.a / 255;
        acol := RGB(round(GetRValue(Pixels[x,y])*(1-a)+acol2.r*a),
                    round(GetGValue(Pixels[x,y])*(1-a)+acol2.g*a),
                    round(GetBValue(Pixels[x,y])*(1-a)+acol2.b*a));
        Pixels[x,y] := acol;
      end;
    end;
  end;
end;

procedure TForm1.Edit11Change(Sender: TObject);
begin
  if changing then exit;
  PartSys.DefaultParticle.RotStart := StrToFloatDef(Edit11.Text,0);
  PartSys.DefaultParticle.RotEnd   := StrToFloatDef(Edit12.Text,0);
end;

procedure TForm1.Edit13Change(Sender: TObject);
begin
  if changing then exit;
  PartSys.DefaultParticle.SpeedXStart := StrToFloatDef(Edit13.Text,100);
  PartSys.DefaultParticle.SpeedXEnd := StrToFloatDef(Edit14.Text,100);
  PartSys.DefaultParticle.SpeedYStart := StrToFloatDef(Edit15.Text,100);
  PartSys.DefaultParticle.SpeedYEnd := StrToFloatDef(Edit16.Text,100);
end;

procedure TForm1.Edit17Change(Sender: TObject);
begin
  if changing then exit;
  RadioButton2.Checked := true;
  pc := StrToIntDef(Edit17.Text,100);
  interval := false;
end;

procedure TForm1.Edit18Change(Sender: TObject);
begin
  if changing then exit;
  PartSys.DefaultParticle.SpeedVariation := StrToIntDef(Edit18.Text,0);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if changing then exit;
  PartSys.DefaultParticle.Name:= Edit1.Text;
end;

procedure TForm1.Edit6Change(Sender: TObject);
begin
  if changing then exit;
  PartSys.DefaultParticle.LifeTime := StrToFloatDef(Edit6.Text,1);
end;

procedure TForm1.Edit7Change(Sender: TObject);
begin
  if changing then exit;
  PartSys.DefaultParticle.LifeTimeVariation := StrToIntDef(Edit7.Text,0);
end;

procedure TForm1.Edit8Change(Sender: TObject);
begin
  if changing then exit;
  RadioButton1.Checked := true;
  pc := StrToFloatDef(Edit8.Text,1);
  if pc < 0.1 then pc := 0.1;
  interval := true;
end;

procedure TForm1.Edit9Change(Sender: TObject);
begin
  if changing then exit;  
  PartSys.DefaultParticle.SizeStart := StrToFloatDef(Edit9.Text,1);
  PartSys.DefaultParticle.SizeEnd   := StrToFloatDef(Edit10.Text,1);
end;

procedure TForm1.FormCreate(Sender: TObject);
var bmp:TBitmap;
    adbmp:TAdBitmap;
begin
  Randomize;

  //Initialize Andorra 2D
  AdDraw1 := TAdDraw.Create(Panel1);
  AdDraw1.DllName := 'AndorraOGL.dll';

  if AdDraw1.Initialize then
  begin
    //Load the texture
    bmp := TBitmap.Create;
    bmp.Assign(Image2.Picture.Bitmap);
    adbmp := TAdBitmap.Create;
    AdImg1 := TAdImage.Create(AdDraw1);
    adbmp.AssignBitmap(bmp);
    adbmp.AssignAlphaChannel(bmp);
    AdImg1.Texture.Texture.LoadFromBitmap(adbmp);
    AdImg1.Color := clWhite;
    AdImg1.Restore;
    adbmp.Free;
    bmp.Free;

    Application.OnIdle := ApplicationIdle;

    PerCount := TAdPerformanceCounter.Create;

    PartSys := TAdParticleSystem.Create(AdDraw1);
    PartSys.Texture := AdImg1.Texture;

    Image1.Picture.Bitmap.Width := 216;
    Image1.Picture.Bitmap.Height := 23;
    UpdateControls;

    mx := Panel1.Width div 2;
    my := Panel1.Height div 2;
    BackgroundColor := ColorToRGB(clBtnFace);

    pc := 1;
    pc2 := 0;
    interval := true;
  end
  else
  begin
    ShowMessage('Error while initializing Andorra 2D.');
    halt;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  //Free everything
  PartSys.Free;
  PerCount.Free;
  AdImg1.Free;
  AdDraw1.Free;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssLeft in Shift then
  begin
    mx := x;
    my := y;
  end;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  DrawAnglePreview;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then
  begin
    if ListBox1.ItemIndex < ListBox1.Count-1 then Button4.Enabled := true else Button4.Enabled := false;
    if ListBox1.ItemIndex > 0                then Button3.Enabled := true else Button3.Enabled := false;
  end;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then
  begin
    Edit2.Text := inttostr(PartSys.DefaultParticle.Colors[ListBox1.ItemIndex].r);
    Edit3.Text := inttostr(PartSys.DefaultParticle.Colors[ListBox1.ItemIndex].g);
    Edit4.Text := inttostr(PartSys.DefaultParticle.Colors[ListBox1.ItemIndex].b);
    Edit5.Text := inttostr(PartSys.DefaultParticle.Colors[ListBox1.ItemIndex].a);
  end;
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with ListBox1.Canvas do
  begin
    Brush.Color := AdColorToColor(PartSys.DefaultParticle.Colors.Items[Index]);
    Pen.Color := Brush.Color;
    Rectangle(Rect);
    Font.Color := RGB(255-GetRValue(Pen.Color),255-GetGValue(Pen.Color),255-GetBValue(Pen.Color));
    Textout(Rect.Left,Rect.Top,ListBox1.Items[index]);
  end;
end;

procedure TForm1.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (ListBox1.ItemIndex <> -1) and (ListBox1.Items.Count > 1)then
  begin
    PartSys.DefaultParticle.Colors.Delete(ListBox1.ItemIndex);
    ListBox1.Items.Delete(ListBox1.ItemIndex);
    DrawColorPreview;
    ListBox1.Repaint;
  end
  else
  begin
    beep;
  end;
end;

procedure TForm1.LoadFile1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    PartSys.DefaultParticle.LoadFromFile(OpenDialog1.FileName);
    CurrentFileName := ChangeFileExt(OpenDialog1.FileName,'.apf');
    Save1.Enabled := true;
    Caption := 'Particle Editor ['+CurrentFileName+']';
    UpdateControls;
  end;
end;

procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
  begin
    mx := x;
    my := y;
  end;
end;

procedure TForm1.Panel1Resize(Sender: TObject);
begin
  if AdDraw1.Initialized then
  begin
    AdDraw1.Setup2DScene;
  end;
end;

procedure TForm1.Render;
begin
  PerCount.Calculate;
  StatusBar1.SimpleText := 'FPS: '+inttostr(PerCount.FPS)+' Particle Count: '+inttostr(PartSys.Items.Count);

  AdDraw1.BeginScene;
  AdDraw1.ClearSurface(BackgroundColor);

  if interval then
  begin
    if PerCount.TimeGap < pc then
    begin
      pc2 := pc2 + PerCount.TimeGap / pc;
    end
    else
    begin
      pc2 := PerCount.TimeGap / pc;
    end;
    if pc2 >= 1 then
    begin
      PartSys.CreateParticles(round(pc2),TAdParticle,mx,my);
      pc2 := 0;
    end;
  end
  else
  begin
    if PartSys.Items.Count = 0 then
    begin
      PartSys.CreateParticles(round(pc),TAdParticle,mx,my);
    end;
  end;

  PartSys.Move(PerCount.TimeGap/1000);
  PartSys.Draw(0,0);
  PartSys.Dead;
  AdDraw1.EndScene;
  AdDraw1.Flip;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  if CurrentFileName <> '' then
  begin
    PartSys.DefaultParticle.SaveToFile(CurrentFileName);
  end;
end;

procedure TForm1.Saveas1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    PartSys.DefaultParticle.SaveToFile(ChangeFileExt(SaveDialog1.FileName,'.apf'));
    CurrentFileName := ChangeFileExt(SaveDialog1.FileName,'.apf');
    Save1.Enabled := true;
    Caption := 'Particle Editor ['+CurrentFileName+']';
  end;
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  if changing then exit;
  with PartSys.DefaultParticle do
  begin
    CreationAngle := Scrollbar2.Position;
    CreationAngleOpen  := Scrollbar1.Position;
  end;
  Label27.Caption := 'Angle: '+inttostr(Scrollbar2.Position)+'°';
  Label26.Caption := 'Open: '+inttostr(Scrollbar1.Position)+'°';
  DrawAnglePreview;
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
begin
  if changing then exit;
  with PartSys.DefaultParticle.Force do
  begin
    X := cos(ScrollBar3.Position * PI / 180)*ScrollBar4.Position;
    Y := sin(ScrollBar3.Position * PI / 180)*ScrollBar4.Position;
    Label31.Caption := inttostr(Scrollbar3.Position)+'°';
    Label32.Caption := inttostr(Scrollbar4.Position)+' px/s';
  end;
end;

procedure TForm1.UpdateControls;
var i:integer;
    nx,ny,l:double;
    w:integer;
begin
  changing := true;
  with PartSys.DefaultParticle do
  begin
    ListBox1.Clear;
    for i := 0 to Colors.Count - 1 do
    begin
      ListBox1.Items.Add('a: '+inttostr(Colors[i].a)+' '+
                         'r: '+inttostr(Colors[i].r)+' '+
                         'g: '+inttostr(Colors[i].g)+' '+
                         'b: '+inttostr(Colors[i].b)+' ');
    end;
    DrawColorPreview;
    ListBox1.Repaint;
    CheckBox2.Checked := DrawMask;
    Edit1.Text := Name;
    Edit6.Text := FormatFloat('0.00',LifeTime);
    Edit7.Text := Inttostr(LifeTimeVariation);
    Edit9.Text := FormatFloat('0.00',SizeStart);
    Edit10.Text := FormatFloat('0.00',SizeEnd);
    Edit11.Text := FormatFloat('0',RotStart);
    Edit12.Text := FormatFloat('0',RotEnd);
    Edit13.Text := FormatFloat('0',SpeedXStart);
    Edit14.Text := FormatFloat('0',SpeedXEnd);
    Edit15.Text := FormatFloat('0',SpeedYStart);
    Edit16.Text := FormatFloat('0',SpeedYEnd);
    Edit18.Text := Inttostr(SpeedVariation);
    ScrollBar2.Position := CreationAngle;
    ScrollBar1.Position := CreationAngleOpen;

    case blendmode of
      bmAlpha: Combobox1.ItemIndex := 0;
      bmAdd: Combobox1.ItemIndex := 1;
      bmMask: Combobox1.ItemIndex := 2;
    end;

    l := sqrt(sqr(Force.X)+sqr(Force.Y));
    if l > 0 then
    begin
      nx := Force.X;
      ny := Force.Y;
      w := round(radtodeg(arccos(nx/l)));
      if ny < 0 then
      begin
        w := 360 - w;
      end;
      Scrollbar3.Position := w;
    end
    else
    begin
      ScrollBar3.Position := 0;
    end;
    ScrollBar4.Position := round(l);
    DrawAnglePreview;
  end;
  changing := false;
end;

end.
