unit dxf_previewfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DXF_read, DXF_Structs, DXF_Utils, Zoomer,
  gnugettext;

type
  Tdxf_previewform = class(TForm)
    Panel1: TPanel;
    Zoombox: Zoom_panel;
    Panel2: TPanel;
    Files_listbox: TListBox;
    messages: TListBox;
    Panel3: TPanel;
    delete: TButton;
    Track_Timer: TTimer;
    Track_mouse: TCheckBox;
    Thick_lines: TCheckBox;
    Button1: TButton;
    Panel4: TPanel;
    Button2: TButton;
    Button3: TButton;
    procedure refresh_listbox(SelectAll:boolean);
    procedure update_selection;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ZoomboxPaint(Sender: TObject);
    procedure Files_listboxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Files_listboxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Files_listboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure deleteClick(Sender: TObject);
    procedure ZoomboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZoomboxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZoomboxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Track_TimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Thick_linesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Track_mouseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
    selection        : selection_lists;
    highlight_obj    : DXF_Entity;
    highlight_point  : Point3D;
    Captured_obj     : DXF_Entity;
    Captured_point   : Point3D;
    mouseX,mouseY    : integer;
    database_loaded  : boolean;
    procedure GenerateXYArray;
  public
    { Public-Deklarationen }
    DXF_main    : DXF_Object;
    emax,emin   : Point3D;
    ArrayOfXYValues: array of TPoint;
    procedure LoadDXFFile(Filename:string);
  end;

var
  dxf_previewform: Tdxf_previewform;

implementation

uses PCDIMMER, figureneditor;

{$R *.dfm}

procedure Tdxf_previewform.refresh_listbox(SelectAll:boolean);
var
  lp1 : integer;
begin
  Files_listbox.Clear;
  if DXF_main<>nil then
  begin
//    if C_remove_layers.Checked then DXF_main.remove_empty_layers_and_lists;
    if DXF_main.num_layers=0 then
    begin
      DXF_main.Free;
      DXF_main:=nil;
      ModalResult:=mrCancel;
    end else
    begin
      DXF_main.copy_to_strings(Files_listbox.Items);
    end;
  end;
  if SelectAll then
  begin
    for lp1:=0 to Files_listbox.Items.count-1 do
      Files_listbox.Selected[lp1] := true;
  end;
  update_selection;
end;

procedure Tdxf_previewform.update_selection;
var
  lp1{,vct,lct,pcto,pctc }: integer;
begin
//  vct := 0; lct := 0; pcto := 0; pctc := 0;
  selection.entity_lists.Clear;
  with Files_Listbox do begin
    for lp1:=Items.Count-1 downto 0 do with Items do begin
      if (Selected[lp1]) then begin
        if (not (objects[lp1] is Entity_List)) or
          ((Entity_List(objects[lp1]).name='Block_') {and block_defs.checked})
          then Selected[lp1] := false
        else selection.entity_lists.Add(objects[lp1]);
      end;
    end;
//    for lp1:=Items.Count-1 downto 0 do with Items do if Selected[lp1] then begin
//      vct   :=   vct  + Entity_List(Objects[lp1]).count_points;
//      lct   :=   lct  + Entity_List(Objects[lp1]).count_lines;
//      pcto  :=   pcto + Entity_List(Objects[lp1]).count_polys_open;
//      pctc  :=   pctc + Entity_List(Objects[lp1]).count_polys_closed;
//    end;
  end;
{
  vert_lab.Caption    := IntToStr(vct);
  line_lab.Caption    := IntToStr(lct);
  polyo_lab.Caption   := IntToStr(pcto);
  polyc_lab.Caption   := IntToStr(pctc);

  T_entities.Caption  := IntToStr(entities_in_existence);
  T_Lists.Caption     := IntToStr(Ent_lists_in_existence);
  T_Layers.Caption    := IntToStr(layers_in_existence);
  T_Objs.Caption      := IntToStr(DXF_Obj_in_existence);
}
  // If data changes, we must clear the highlight_obj to prevent access violation
  highlight_obj       := nil;
  highlight_point     := aPoint3D(0,0,0);
end;

procedure Tdxf_previewform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);

  selection := selection_lists.create;
  emax := aPoint3D(-1E10,-1E10,-1E10);
  emin := aPoint3D( 1E10, 1E10, 1E10);
  database_loaded:=false;
end;

procedure Tdxf_previewform.FormDestroy(Sender: TObject);
begin
  selection.Free;
end;

procedure Tdxf_previewform.ZoomboxPaint(Sender: TObject);
var lp0        : integer;
    data_list  : Entity_List;
//    metafile   : TMetaFile;
//    metaCanvas : TMetaFileCanvas;
    drawcanvas : TCanvas;
begin
  drawcanvas := Zoombox.ClientArea.Canvas;
  drawcanvas.Font.name := 'FF_ROMAN';

  if Thick_lines.checked then
    drawcanvas.Pen.Width := 2
  else
    drawcanvas.Pen.Width := 1;

  drawcanvas.Pen.Color := clBlack;

//  if Fill_closed.checked then
//  begin
//    drawcanvas.Brush.Style := bsSolid;
//    drawcanvas.Brush.Color := clBlack;
//  end else
    drawcanvas.Brush.Style := bsClear;

  for lp0:=0 to Files_listbox.Items.Count-1 do
  begin
    if (not Files_listbox.Selected[lp0]) then continue;
    if Files_listbox.Items.Objects[lp0] is Entity_List then
    begin
      data_list := Entity_List(Files_listbox.Items.Objects[lp0]);
      data_list.draw_primitives(drawcanvas,Zoombox.real_to_screen,nil);
//      if draw_vertices.checked then
//        data_list.draw_vertices(drawcanvas,Zoombox.real_to_screen,nil);
    end;
  end;
end;

procedure Tdxf_previewform.LoadDXFFile(Filename:string);
begin
  DXF_main := DXF_Object.Create_from_file(Filename, messages.items);
  emax := DXF_main.get_max_extent;
  emin := DXF_main.get_min_extent;
  database_loaded := true;
  refresh_listbox(true);
  Zoombox.set_parameters(emin.x,emax.x,emin.y,emax.y, 20,20);
  Zoombox.ClientArea.repaint;
end;

procedure Tdxf_previewform.Files_listboxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_DELETE then deleteClick(nil);
end;

procedure Tdxf_previewform.Files_listboxKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  update_selection;
end;

procedure Tdxf_previewform.Files_listboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  update_selection;
  Zoombox.ClientArea.repaint;
end;

procedure Tdxf_previewform.deleteClick(Sender: TObject);
var lp1 : integer;
begin
  with selection do
    for lp1:=0 to entity_lists.count-1 do
      DXF_Layer(Entity_list(entity_lists[lp1]).parent_layer).delete(Entity_list(entity_lists[lp1]).name,true);
  refresh_listbox(false);
  Zoombox.ClientArea.repaint;
end;

procedure Tdxf_previewform.ZoomboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var new_p : Point2D;
    new_q : Point3D;
begin
  if Captured_obj<>nil then begin
    new_p   := zoombox.screen_to_real(Point(X,Y));
    new_q   := set_accuracy(1000,aPoint3D(new_p.x,new_p.y,Captured_point.z));
    if not Captured_obj.Move_point(Captured_point,new_q) then
      Showmessage('An error occurred moving point')
    else Zoombox.ClientArea.repaint;
    Captured_point := aPoint3D(0,0,0);
    Captured_obj   := nil;
  end;
end;

procedure Tdxf_previewform.ZoomboxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ssShift in Shift then begin
    Captured_point := Highlight_point;
    Captured_obj   := Highlight_obj;
  end
  else begin
    Captured_point := aPoint3D(0,0,0);
    Captured_obj   := nil;
  end;
end;

procedure Tdxf_previewform.ZoomboxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  mouseX := X;
  mouseY := Y;
  if Track_mouse.checked then Track_timer.enabled := true;
end;

procedure Tdxf_previewform.Track_TimerTimer(Sender: TObject);
var p0        : Point2D;
    t         : TColor;
    old_obj   : DXF_Entity;
    old_point : Point3D;
begin
  if (not Track_mouse.checked) or (not database_loaded) then begin
    Track_timer.enabled := false;
    exit;
  end;
  old_obj   := highlight_obj;
  old_point := highlight_point;
  p0 := zoombox.screen_to_real(Point(mouseX,mouseY));
//  if TrackingForm.R_Nearest.checked then
    highlight_point := selection.find_closest_2D_point(aPoint3D(p0.x,p0.y,0),highlight_obj);
{
  else begin
    // lets see if the last object is still the highlighted one
    if (highlight_obj<>nil) and highlight_obj.is_point_inside_object2D(aPoint3D(p0.x,p0.y,0)) then
      highlight_point := highlight_obj.closest_vertex(aPoint3D(p0.x,p0.y,0))
    else
      highlight_point := selection.is_inside_object(aPoint3D(p0.x,p0.y,0),highlight_obj);
  end;
}
  if (highlight_obj<>nil) then begin
    if (highlight_obj<>old_obj) then begin
      if old_obj<>nil then old_obj.draw(zoombox.clientarea.canvas,zoombox.real_to_screen,nil);
      t := highlight_obj.colour;
      highlight_obj.setcolour(t XOR $00FFFFFF);
      highlight_obj.draw(zoombox.clientarea.canvas,zoombox.real_to_screen,nil);
      highlight_obj.setcolour(t);
    end;
{
    if not p1_eq_p2_3D(highlight_point,old_point) then with TrackingForm do begin
      Tr_X.Caption := FloatToStrF(highlight_point.x,ffGeneral,7,2);
      Tr_Y.Caption := FloatToStrF(highlight_point.y,ffGeneral,7,2);
      Tr_Z.Caption := FloatToStrF(highlight_point.z,ffGeneral,7,2);
      Tr_P.Caption := FloatToStr(highlight_obj.count_points);
      if T_extended.checked then T_info_box.Text := highlight_obj.details;
    end;
}
  end;
  // turn it off until the next mouse move
  Track_timer.enabled := false;
end;

procedure Tdxf_previewform.Button1Click(Sender: TObject);
begin
  Zoombox.ClientArea.repaint;
end;

procedure Tdxf_previewform.GenerateXYArray;
{
var lp0,j      : integer;
    data_list  : Entity_List;
    data       : ^DXF_Entity;
}
{
var p0        : Point2D;
    t         : TColor;
    old_obj   : DXF_Entity;
    old_point : Point3D;
}
var
  i,j:integer;
begin
  setlength(ArrayOfXYValues,0);
  
  for i:=0 to 399 do // Y-Werte
  for j:=0 to 399 do // X-Werte
  begin
    if Zoombox.ClientArea.Canvas.Pixels[i,j]<>$00f4f4f4 then
    begin
      setlength(mainform.Figuren[figureneditorform.Combobox1.ItemIndex].posx,length(mainform.Figuren[figureneditorform.Combobox1.ItemIndex].posx)+1);
      setlength(mainform.Figuren[figureneditorform.Combobox1.ItemIndex].posy,length(mainform.Figuren[figureneditorform.Combobox1.ItemIndex].posy)+1);
      mainform.Figuren[figureneditorform.Combobox1.ItemIndex].posx[length(mainform.Figuren[figureneditorform.Combobox1.ItemIndex].posx)-1]:=i;
      mainform.Figuren[figureneditorform.Combobox1.ItemIndex].posy[length(mainform.Figuren[figureneditorform.Combobox1.ItemIndex].posy)-1]:=j;
    end;
  end;

{
  for lp0:=0 to Files_listbox.Items.Count-1 do
  begin
    if (not Files_listbox.Selected[lp0]) then continue;
    if Files_listbox.Items.Objects[lp0] is Entity_List then
    begin
      data_list := Entity_List(Files_listbox.Items.Objects[lp0]);
      for j:=0 to data_list.entities.Count-1 do
      begin
//        data:=data_list.entities.Items[j];
        DXF_Entity(data_list.entities[j]);

        setlength(ArrayOfXYValues,length(ArrayOfXYValues)+1);
        ArrayOfXYValues[length(ArrayOfXYValues)-1].X:=round(data.OCS_axis.x);
        ArrayOfXYValues[length(ArrayOfXYValues)-1].Y:=round(data.OCS_axis.y);
//        data.OCS_axis.z;
      end;
    end;
  end;
}

{
  old_obj   := highlight_obj;
  old_point := highlight_point;
  p0 := zoombox.screen_to_real(Point(mouseX,mouseY));
  highlight_point := selection.find_closest_2D_point(aPoint3D(p0.x,p0.y,0),highlight_obj);

  if (highlight_obj<>nil) then
  begin
    if (highlight_obj<>old_obj) then
    begin
      if old_obj<>nil then
        old_obj.draw(zoombox.clientarea.canvas,zoombox.real_to_screen,nil);
      t := highlight_obj.colour;
      highlight_obj.setcolour(t XOR $00FFFFFF);
      highlight_obj.draw(zoombox.clientarea.canvas,zoombox.real_to_screen,nil);
      highlight_obj.setcolour(t);
    end;

    if not p1_eq_p2_3D(highlight_point,old_point) then
    begin
      with TrackingForm do
      begin
        Tr_X.Caption := FloatToStrF(highlight_point.x,ffGeneral,7,2);
        Tr_Y.Caption := FloatToStrF(highlight_point.y,ffGeneral,7,2);
        Tr_Z.Caption := FloatToStrF(highlight_point.z,ffGeneral,7,2);
        Tr_P.Caption := FloatToStr(highlight_obj.count_points);
        if T_extended.checked then T_info_box.Text := highlight_obj.details;
      end;
    end;
  end;
}
end;

procedure Tdxf_previewform.Button2Click(Sender: TObject);
begin
  GenerateXYArray;
  ModalResult:=mrOK;
end;

procedure Tdxf_previewform.Thick_linesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Zoombox.ClientArea.repaint;
end;

procedure Tdxf_previewform.Track_mouseMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Zoombox.ClientArea.repaint;
end;

end.
