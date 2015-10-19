unit settingfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, HSLColorPicker, ComCtrls,
  AdClasses, Math, Buttons, PngBitBtn, Mask, JvExMask, JvSpin, gnugettext;

type
  TSettingform = class(TForm)
    deviceimage: TImage;
    Label3: TLabel;
    Label4: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    channellbl: TLabel;
    startvaluelbl: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    endvaluelbl: TLabel;
    fadetimelbl: TLabel;
    namelbl: TLabel;
    fadenkreuz: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    PositionXY: TShape;
    ColorPicker: THSLColorPicker;
    SpecialList: TComboBox;
    GoboRotBar: TTrackBar;
    DimmerBar: TTrackBar;
    HeightBar: TTrackBar;
    WidthBar: TTrackBar;
    Button1: TButton;
    GoboList: TComboBox;
    CheckBox1: TCheckBox;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    GroupBox4: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Edit8: TEdit;
    RadioButton1: TRadioButton;
    Edit17: TEdit;
    RadioButton2: TRadioButton;
    TabSheet5: TTabSheet;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Label16: TLabel;
    Label2: TLabel;
    GroupBox5: TGroupBox;
    Label17: TLabel;
    Label19: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Edit11: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit18: TEdit;
    GroupBox6: TGroupBox;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    PaintBox1: TPaintBox;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    ListBox1: TListBox;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    Edit1: TEdit;
    ActualScanner: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure GoboListChange(Sender: TObject);
    procedure SpecialListChange(Sender: TObject);
    procedure ColorPickerChange(Sender: TObject);
    procedure ColorPickerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure fadenkreuzMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure fadenkreuzMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PositionXYMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GoboRotBarChange(Sender: TObject);
    procedure DimmerBarChange(Sender: TObject);
    procedure WidthBarChange(Sender: TObject);
    procedure HeightBarChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit17Change(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure Edit13Change(Sender: TObject);
    procedure Edit18Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure DrawAnglePreview;
    procedure UpdateControls;
    procedure PageControl2Change(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    changing:boolean;
  public
    { Public-Deklarationen }
    pc,pc2:double;
    interval:boolean;
    procedure PreparePresetList;
  end;

var
  Settingform: TSettingform;

implementation

uses main;

{$R *.dfm}

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

procedure TSettingform.FormShow(Sender: TObject);
begin
  UpdateControls;
end;

procedure TSettingform.GoboListChange(Sender: TObject);
begin
  mainform.actualgobowidth:=mainform.AdImageList.Items[GoboList.ItemIndex].Width;
  mainform.actualgoboheight:=mainform.AdImageList.Items[GoboList.ItemIndex].Height;

  mainform.Scanner[ActualScanner.ItemIndex].Image:=mainform.AdImageList.Items[GoboList.ItemIndex];
  mainform.Scanner[ActualScanner.ItemIndex].Width:=mainform.actualgobowidth*(mainform.Softscanner.Width/127);
  mainform.Scanner[ActualScanner.ItemIndex].Height:=mainform.actualgoboheight*(mainform.Softscanner.Height/127);

  mainform.PartSys.Texture:=mainform.AdImageList.Items[GoboList.ItemIndex].Texture;
  mainform.PartSys.DefaultParticle.SizeStart:=(mainform.Softscanner.Width/127);
  mainform.PartSys.DefaultParticle.SizeEnd:=(mainform.Softscanner.Width/127);
  mainform.PartSys.DefaultParticle.SizeStart:=(mainform.Softscanner.Height/127);
  mainform.PartSys.DefaultParticle.SizeEnd:=(mainform.Softscanner.Height/127);
  if listbox1.ItemIndex>-1 then
    mainform.LoadPreset(listbox1.Itemindex);
end;

procedure TSettingform.SpecialListChange(Sender: TObject);
begin
  case SpecialList.ItemIndex of
    0: mainform.Softscanner.Special:=0;
    1: mainform.Softscanner.Special:=10;
  end;
end;

procedure TSettingform.ColorPickerChange(Sender: TObject);
begin
  if Sender=ColorPicker then
  begin
    TColor2RGB(ColorPicker.SelectedColor,mainform.Softscanner.r,mainform.Softscanner.g,mainform.Softscanner.b);
    mainform.AdDraw.AmbientColor := RGB(round(mainform.Softscanner.R*mainform.Softscanner.Dimmer/255),round(mainform.Softscanner.G*mainform.Softscanner.Dimmer/255),round(mainform.Softscanner.B*mainform.Softscanner.Dimmer/255));
  end;
end;

procedure TSettingform.ColorPickerMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Sender=ColorPicker then
  begin
    TColor2RGB(ColorPicker.SelectedColor,mainform.Softscanner.r,mainform.Softscanner.g,mainform.Softscanner.b);
    mainform.AdDraw.AmbientColor := RGB(round(mainform.Softscanner.R*mainform.Softscanner.Dimmer/255),round(mainform.Softscanner.G*mainform.Softscanner.Dimmer/255),round(mainform.Softscanner.B*mainform.Softscanner.Dimmer/255));
  end;
end;

procedure TSettingform.fadenkreuzMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then
  begin
    PositionXY.Top:=Y-PositionXY.Height div 2;
    PositionXY.Left:=X-PositionXY.Width div 2;
  end else
  begin
    PositionXY.Top:=(fadenkreuz.Height div 2)-(PositionXY.Height div 2);
    PositionXY.Left:=(fadenkreuz.Width div 2)-(PositionXY.Width div 2);
  end;

    mainform.Softscanner.X:=round(((PositionXY.Left+(PositionXY.Width / 2))/fadenkreuz.Width)*255);
    mainform.Softscanner.Xfine:=0;
    mainform.Softscanner.Y:=round(((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255);
    mainform.Softscanner.Yfine:=0;

    mainform.Softscanner.Xcomplete:=mainform.Softscanner.X;
    mainform.Softscanner.Xcomplete:=mainform.Softscanner.Xcomplete shl 8;
    mainform.Softscanner.Xcomplete:=mainform.Softscanner.Xcomplete+mainform.Softscanner.Xfine;
    mainform.Softscanner.Ycomplete:=mainform.Softscanner.Y;
    mainform.Softscanner.Ycomplete:=mainform.Softscanner.Ycomplete shl 8;
    mainform.Softscanner.Ycomplete:=mainform.Softscanner.Ycomplete+mainform.Softscanner.Yfine;
end;

procedure TSettingform.fadenkreuzMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    if ((x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=x-(PositionXY.Width div 2);
    if ((y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=y-(PositionXY.Height div 2);
    PositionXY.Refresh;

    mainform.Softscanner.X:=round(((PositionXY.Left+(PositionXY.Width / 2))/fadenkreuz.Width)*255);
    mainform.Softscanner.Xfine:=0;
    mainform.Softscanner.Y:=round(((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255);
    mainform.Softscanner.Yfine:=0;

    mainform.Softscanner.Xcomplete:=mainform.Softscanner.X;
    mainform.Softscanner.Xcomplete:=mainform.Softscanner.Xcomplete shl 8;
    mainform.Softscanner.Xcomplete:=mainform.Softscanner.Xcomplete+mainform.Softscanner.Xfine;
    mainform.Softscanner.Ycomplete:=mainform.Softscanner.Y;
    mainform.Softscanner.Ycomplete:=mainform.Softscanner.Ycomplete shl 8;
    mainform.Softscanner.Ycomplete:=mainform.Softscanner.Ycomplete+mainform.Softscanner.Yfine;
  end;
end;

procedure TSettingform.PositionXYMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    if ((PositionXY.Left+x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((PositionXY.Left+x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=PositionXY.Left+x-(PositionXY.Width div 2);
    if ((PositionXY.Top+y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((PositionXY.Top+y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=PositionXY.Top+y-(PositionXY.Height div 2);

    mainform.Softscanner.X:=round(((PositionXY.Left+(PositionXY.Width / 2))/fadenkreuz.Width)*255);
    mainform.Softscanner.Xfine:=0;
    mainform.Softscanner.Y:=round(((PositionXY.Top+(PositionXY.Height div 2))/fadenkreuz.Height)*255);
    mainform.Softscanner.Yfine:=0;

    mainform.Softscanner.Xcomplete:=mainform.Softscanner.X;
    mainform.Softscanner.Xcomplete:=mainform.Softscanner.Xcomplete shl 8;
    mainform.Softscanner.Xcomplete:=mainform.Softscanner.Xcomplete+mainform.Softscanner.Xfine;
    mainform.Softscanner.Ycomplete:=mainform.Softscanner.Y;
    mainform.Softscanner.Ycomplete:=mainform.Softscanner.Ycomplete shl 8;
    mainform.Softscanner.Ycomplete:=mainform.Softscanner.Ycomplete+mainform.Softscanner.Yfine;
  end;
end;

procedure TSettingform.GoboRotBarChange(Sender: TObject);
begin
  mainform.Softscanner.GoboRotation:=goborotbar.Position;

  if mainform.Softscanner.GoboRotation=128 then
    mainform.ParticleRotationTimer.Enabled:=false
  else
    mainform.ParticleRotationTimer.Enabled:=true;

  if mainform.Softscanner.GoboRotation<128 then
    mainform.ParticleRotationTimer.Interval:=round(100*(mainform.Softscanner.GoboRotation/128))
  else
    mainform.ParticleRotationTimer.Interval:=round(100*((128-(mainform.Softscanner.GoboRotation-128))/128))
end;

procedure TSettingform.DimmerBarChange(Sender: TObject);
begin
  mainform.Softscanner.Dimmer:=dimmerbar.Position;
  mainform.AdDraw.AmbientColor := RGB(round(mainform.Softscanner.R*mainform.Softscanner.Dimmer/255),round(mainform.Softscanner.G*mainform.Softscanner.Dimmer/255),round(mainform.Softscanner.B*mainform.Softscanner.Dimmer/255));
end;

procedure TSettingform.WidthBarChange(Sender: TObject);
begin
  mainform.Softscanner.Width:=WidthBar.Position;
  mainform.Scanner[ActualScanner.ItemIndex].Width:=mainform.actualgobowidth*(WidthBar.Position/127);

  mainform.PartSys.DefaultParticle.SizeStart:=(WidthBar.Position/127);
  mainform.PartSys.DefaultParticle.SizeEnd:=(WidthBar.Position/127);

  if Checkbox1.Checked then
  begin
    Heightbar.Position:=WidthBar.Position;

    mainform.Softscanner.Height:=HeightBar.Position;
    mainform.Scanner[ActualScanner.ItemIndex].Height:=mainform.actualgoboheight*(HeightBar.Position/127);

    mainform.PartSys.DefaultParticle.SizeStart:=HeightBar.Position/127;
    mainform.PartSys.DefaultParticle.SizeEnd:=HeightBar.Position/127;
  end;
end;

procedure TSettingform.HeightBarChange(Sender: TObject);
begin
  mainform.Softscanner.Height:=HeightBar.Position;
  mainform.Scanner[ActualScanner.ItemIndex].Height:=mainform.actualgoboheight*(HeightBar.Position/127);

  mainform.PartSys.DefaultParticle.SizeStart:=HeightBar.Position/127;
  mainform.PartSys.DefaultParticle.SizeEnd:=HeightBar.Position/127;

  if Checkbox1.Checked then
  begin
    WidthBar.Position:=Heightbar.Position;

    mainform.Softscanner.Width:=WidthBar.Position;
    mainform.Scanner[ActualScanner.ItemIndex].Width:=mainform.actualgobowidth*(WidthBar.Position/127);

    mainform.PartSys.DefaultParticle.SizeStart:=(WidthBar.Position/127);
    mainform.PartSys.DefaultParticle.SizeEnd:=(WidthBar.Position/127);
  end;
end;

procedure TSettingform.Button1Click(Sender: TObject);
begin
  GoboRotBar.Position:=128;
  Dimmerbar.Position:=255;
  WidthBar.Position:=128;
  HeightBar.Position:=128;

  GoboRotBarChange(nil);
  DimmerbarChange(nil);
  WidthBarChange(nil);
  HeightBarChange(nil);
end;

procedure TSettingform.ComboBox1Change(Sender: TObject);
begin
  if changing then exit;
  case Combobox1.ItemIndex of
    0: mainform.PartSys.DefaultParticle.BlendMode := bmAlpha;
    1: mainform.PartSys.DefaultParticle.BlendMode := bmAdd;
    2: mainform.PartSys.DefaultParticle.BlendMode := bmMask;
  end;
end;

procedure TSettingform.Edit6Change(Sender: TObject);
begin
  if changing then exit;
  mainform.PartSys.DefaultParticle.LifeTime := StrToFloatDef(Edit6.Text,1);
end;

procedure TSettingform.Edit7Change(Sender: TObject);
begin
  if changing then exit;
  mainform.PartSys.DefaultParticle.LifeTimeVariation := StrToIntDef(Edit7.Text,0);
end;

procedure TSettingform.Edit8Change(Sender: TObject);
begin
  if changing then exit;
  RadioButton1.Checked := true;
  pc := StrToFloatDef(Edit8.Text,1);
  if pc < 0.1 then pc := 0.1;
  interval := true;
end;

procedure TSettingform.Edit17Change(Sender: TObject);
begin
  if changing then exit;
  RadioButton2.Checked := true;
  pc := StrToIntDef(Edit17.Text,100);
  interval := false;
end;

procedure TSettingform.RadioButton1Click(Sender: TObject);
begin
  if changing then exit;
  RadioButton1.Checked := true;
  pc := StrToFloatDef(Edit8.Text,1);
  if pc < 0.1 then pc := 0.1;
  interval := true;
end;

procedure TSettingform.RadioButton2Click(Sender: TObject);
begin
  if changing then exit;
  RadioButton2.Checked := true;
  pc := StrToIntDef(Edit17.Text,100);
  interval := false;
end;

procedure TSettingform.Edit9Change(Sender: TObject);
begin
  if changing then exit;
  mainform.PartSys.DefaultParticle.SizeStart := StrToFloatDef(Edit9.Text,1);
  mainform.PartSys.DefaultParticle.SizeEnd   := StrToFloatDef(Edit10.Text,1);
end;

procedure TSettingform.Edit11Change(Sender: TObject);
begin
  if changing then exit;
  mainform.PartSys.DefaultParticle.RotStart := StrToFloatDef(Edit11.Text,0);
  mainform.PartSys.DefaultParticle.RotEnd   := StrToFloatDef(Edit12.Text,0);
end;

procedure TSettingform.Edit13Change(Sender: TObject);
begin
  if changing then exit;
  mainform.PartSys.DefaultParticle.SpeedXStart := StrToFloatDef(Edit13.Text,100);
  mainform.PartSys.DefaultParticle.SpeedXEnd := StrToFloatDef(Edit14.Text,100);
  mainform.PartSys.DefaultParticle.SpeedYStart := StrToFloatDef(Edit15.Text,100);
  mainform.PartSys.DefaultParticle.SpeedYEnd := StrToFloatDef(Edit16.Text,100);
end;

procedure TSettingform.Edit18Change(Sender: TObject);
begin
  if changing then exit;
  mainform.PartSys.DefaultParticle.SpeedVariation := StrToIntDef(Edit18.Text,0);
end;

procedure TSettingform.ScrollBar2Change(Sender: TObject);
begin
  if changing then exit;
  with mainform.PartSys.DefaultParticle do
  begin
    CreationAngle := Scrollbar2.Position;
    CreationAngleOpen  := Scrollbar1.Position;
  end;
  Label32.Caption := 'Winkel: '+inttostr(Scrollbar2.Position)+'°';
  Label31.Caption := 'Offen: '+inttostr(Scrollbar1.Position)+'°';
  DrawAnglePreview;
end;

procedure TSettingform.ScrollBar3Change(Sender: TObject);
begin
  if changing then exit;
  with mainform.PartSys.DefaultParticle.Force do
  begin
    X := cos(ScrollBar3.Position * PI / 180)*ScrollBar4.Position;
    Y := sin(ScrollBar3.Position * PI / 180)*ScrollBar4.Position;
    Label39.Caption := inttostr(Scrollbar3.Position)+'°';
    Label40.Caption := inttostr(Scrollbar4.Position)+' px/s';
  end;
end;

procedure Tsettingform.DrawAnglePreview;
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
    with mainform.PartSys.DefaultParticle do
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

procedure Tsettingform.UpdateControls;
var
//  i:integer;
  nx,ny,l:double;
  w:integer;
begin
  changing := true;
  with mainform.PartSys.DefaultParticle do
  begin
{
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
}
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


procedure TSettingform.PageControl2Change(Sender: TObject);
var
  i,lastpos:integer;
begin
  case pagecontrol2.TabIndex of
    0: ;
    1: DrawAnglePreview;
    2:
    begin
      lastpos:=listbox1.ItemIndex;
      Listbox1.Items.Clear;
      for i:=0 to 255 do
      begin
        if not mainform.SoftScanner.PartikelPresets[i].used then
          mainform.SoftScanner.PartikelPresets[i].name:='Frei';
        Listbox1.Items.Add(inttostr(i)+': '+mainform.SoftScanner.PartikelPresets[i].name);
      end;
      listbox1.ItemIndex:=lastpos;
    end;
  end;
end;

procedure TSettingform.PngBitBtn2Click(Sender: TObject);
begin
  mainform.LoadPreset(listbox1.ItemIndex);
end;

procedure TSettingform.PngBitBtn1Click(Sender: TObject);
begin
  if listbox1.ItemIndex=0 then exit;

  if messagedlg('Partikel-Preset auf Platz "'+inttostr(listbox1.ItemIndex)+'" speichern?',mtConfirmation,
    [mbYes,mbNo],0)=mrYes then
  begin
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].used:=true;
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].name:=edit1.Text;
    listbox1.Items[listbox1.ItemIndex]:=inttostr(listbox1.ItemIndex)+': '+edit1.Text;
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].Blendmode:=combobox1.ItemIndex;
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].Lifetime:=StrToFloatDef(Edit6.Text,1);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].lifetimevariation:=StrToIntDef(Edit7.Text,0);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].createparticleallxsec:=radiobutton1.Checked;
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].createparticleallxsecvalue:=StrToFloatDef(Edit8.Text,1);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].particlecount:=StrToIntDef(Edit17.Text,100);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].HugeStartvalue:=StrToFloatDef(Edit9.Text,1);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].HugeEndvalue:=StrToFloatDef(Edit10.Text,1);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].RotationStartvalue:=StrToFloatDef(Edit11.Text,0);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].RotationEndvalue:=StrToFloatDef(Edit12.Text,0);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].SpeedXStartvalue:=StrToFloatDef(Edit13.Text,100);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].SpeedXEndvalue:=StrToFloatDef(Edit14.Text,100);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].SpeedYStartvalue:=StrToFloatDef(Edit15.Text,100);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].SpeedYEndvalue:=StrToFloatDef(Edit16.Text,100);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].SpeedVariation:=StrToIntDef(Edit18.Text,0);
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].Angle:=Scrollbar2.Position;
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].Open:=Scrollbar1.Position;
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].Angle2:=ScrollBar3.Position;
    mainform.Softscanner.PartikelPresets[listbox1.ItemIndex].Strength:=ScrollBar4.Position;
  end;
end;

procedure TSettingform.PreparePresetList;
var
  i,lastpos:integer;
begin
  // Presetliste vorbereiten
  lastpos:=listbox1.ItemIndex;
  Listbox1.Items.Clear;
  for i:=0 to 255 do
  begin
    if not mainform.SoftScanner.PartikelPresets[i].used then
      mainform.SoftScanner.PartikelPresets[i].name:='Frei';
    Listbox1.Items.Add(inttostr(i)+': '+mainform.SoftScanner.PartikelPresets[i].name);
  end;
  if lastpos>-1 then
    listbox1.ItemIndex:=lastpos
  else
    Listbox1.ItemIndex:=0;
end;

procedure TSettingform.FormCreate(Sender: TObject);
begin
//  TranslateComponent(self);
end;

end.
