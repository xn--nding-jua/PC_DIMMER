{$WARNINGS OFF}
///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//                       DXF Objects/Entities/Layers etc                     //
//                             ©John Biddiscombe                             //
//                      Rutherford Appleton Laboratory, UK                   //
//                           j.biddiscombe@rl.ac.uk                          //
//                       DXF code release 3.0 - July 1997                    //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
unit DXF_structs;

interface

uses
  { Borland }
  Windows,Classes,Graphics,SysUtils,Dialogs,Math,DXF_Utils,
  { Mine }
  Thinkbox;
///////////////////////////////////////////////////////////////////////////////
// Useful definitions
///////////////////////////////////////////////////////////////////////////////
const
  max_vertices_per_polyline = 8192; // AutoCAD places a limit on this, but
  max_attribs               = 16;   // I don't know what it is...
  max_my_attribs            = 16;

type
  file_type = (off,geo,pslg);

type
  polyface = record
    nf : array[0..3] of integer;
  end;

  pfacelist = ^facelist;
  facelist  = array[0..0] of polyface;

  pintlist = ^intlist;
  intlist  = array[0..0] of integer;

  pattrlist = ^attrlist;
  attrlist  = array[0..0] of double;

// note the addition of base and scale factor for drawing blocks
type
  coord_convert = function(P:Point3D; OCS:pMatrix) : TPoint of Object;

type
  planar_eq = record
    a,b,c,d : double;
  end;
///////////////////////////////////////////////////////////////////////////////
// DXF_Entity - abstract base class - override where neccessary
// All DXF objects will become sub classes of this
///////////////////////////////////////////////////////////////////////////////
type
  DXF_Entity = class
    colour   : TColor;
    colinx   : integer;
    OCS_WCS  : pMatrix;
    OCS_axis : Point3D;
    constructor create;
    destructor  destroy;                                                override;
    procedure   init_OCS_WCS_matrix(OCSaxis:Point3D);                   virtual;
    procedure   update_block_links(blist:TObject);                      virtual; abstract;
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);    virtual; abstract;
    procedure   DrawVertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);    virtual; abstract;
    procedure   setcolour_index(col:integer);                           virtual;
    procedure   setcolour(col:TColor);                                  virtual;
    procedure   translate(T:Point3D);                                   virtual; abstract;
    procedure   quantize_coords(epsilon:double; mask:byte);             virtual; abstract;
    function    count_points       : integer;                           virtual;
    function    count_lines        : integer;                           virtual;
    function    count_polys_open   : integer;                           virtual;
    function    count_polys_closed : integer;                           virtual;
    function    proper_name        : string;                            virtual;
    procedure   write_DXF_Point(var IO:textfile; n:integer; p:Point3D); virtual;
    procedure   write_to_DXF(var IO:textfile; layer:string);            virtual;
    function    details : string;                                       virtual; abstract;
    procedure   max_min_extents(var emax,emin:Point3D);                 virtual; abstract;
    function    closest_vertex_square_distance_2D(p:Point3D) : double;  virtual; abstract;
    function    closest_vertex(p:Point3D) : Point3D;                    virtual; abstract;
    function    is_point_inside_object2D(p:Point3D) : boolean;          virtual;
    function    Move_point(p,newpoint:Point3D) : boolean;               virtual;
  end;
///////////////////////////////////////////////////////////////////////////////
// Block_ Definition - special case - not to be used like other entities
// Blocks should always appear in layer '0'
// I'm still not quite sure what to do with them - but here goes anyway...
///////////////////////////////////////////////////////////////////////////////
type
  Block_ = class(DXF_Entity)
    name       : string;
    basepoint  : Point3D;
    entities   : TList;
    constructor create(bname:string; refpoint:Point3D);
    destructor  destroy; override;
    procedure   update_block_links(blist:TObject);                      override;
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    procedure   DrawVertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    function    details : string;                                       override;
    procedure   write_to_DXF(var IO:textfile; layer:string);            override;
    procedure   max_min_extents(var emax,emin:Point3D);                 override;
    function    closest_vertex_square_distance_2D(p:Point3D) : double;  override;
    function    closest_vertex(p:Point3D) : Point3D;                    override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Point Definition
///////////////////////////////////////////////////////////////////////////////
type
  Point_ = class(DXF_Entity) // always WCS
    p1 : Point3D;
    constructor create(OCSaxis,p:Point3D; col:integer);
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    procedure   DrawVertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    procedure   translate(T:Point3D);                                  override;
    procedure   quantize_coords(epsilon:double; mask:byte);            override;
    function    details : string;                                      override;
    procedure   write_to_DXF(var IO:textfile; layer:string);           override;
    procedure   max_min_extents(var emax,emin:Point3D);                override;
    function    closest_vertex_square_distance_2D(p:Point3D) : double; override;
    function    closest_vertex(p:Point3D) : Point3D;                   override;
    function    Move_point(p,newpoint:Point3D) : boolean;              override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Text Definition
///////////////////////////////////////////////////////////////////////////////
type
  Text_ = class(Point_) // always OCS
    h         : double;
    textstr   : string;
    align_pt  : Point3D; // alignment point
    hor_align : integer; // horizontal justification code
    constructor create(OCSaxis,p,ap:Point3D; ss:string; height:double; col,ha:integer);
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    procedure   calcText(acanvas:TCanvas; map_fn:coord_convert; OCS:pM; t:string);
    function    details : string;                                override;
    procedure   write_to_DXF(var IO:textfile; layer:string);     override;
    procedure   max_min_extents(var emax,emin:Point3D);          override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Attrib Definition
///////////////////////////////////////////////////////////////////////////////
type
  Attrib_ = class(Text_) // always OCS
    tagstr  : string;
    visible : boolean;
    constructor create(OCSaxis,p,ap:Point3D; ss,tag:string; flag70,flag72:integer; height:double; col:integer);
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    function    details : string;                                override;
    procedure   write_to_DXF(var IO:textfile; layer:string);     override;
  end;
type
  patt_array = ^att_array;
  att_array  = array[0..0] of Attrib_;
///////////////////////////////////////////////////////////////////////////////
// Attdef Definition
///////////////////////////////////////////////////////////////////////////////
type
  Attdef_ = class(Attrib_) // always OCS
    promptstr : string;
    constructor create(OCSaxis,p,ap:Point3D; ss,tag,prompt:string; flag70,flag72:integer; height:double; col:integer);
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    procedure   write_to_DXF(var IO:textfile; layer:string);     override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Insert Definition (optionally contains attribs)
///////////////////////////////////////////////////////////////////////////////
type
  Insert_ = class(Point_) // always OCS
    num_attribs   : integer;
    attribs       : array[0..max_attribs] of Attrib_;
    blockname     : string;
    scale         : Point3D;
    rotation      : double;
    blockptr      : Block_;  // use carefully
    blocklist     : TObject; // to cross reference the blocks
    constructor create(OCSaxis,p,s_f:Point3D; rot:double; col:integer; numatts:integer; atts:patt_array; block:string);
    destructor  destroy;                                     override;
    procedure   init_OCS_WCS_matrix(OCSaxis:Point3D);        override;
    procedure   update_block_links(blist:TObject);           override;
    function    block : Block_;
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    function    details : string;                            override;
    procedure   write_to_DXF(var IO:textfile; layer:string); override;
    procedure   max_min_extents(var emax,emin:Point3D);      override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Line Definition
///////////////////////////////////////////////////////////////////////////////
type
  Line_ = class(Point_) // always WCS
    p2 : Point3D;
    constructor create(p_1,p_2:Point3D; col:integer);
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    procedure   DrawVertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    procedure   translate(T:Point3D);                                  override;
    procedure   quantize_coords(epsilon:double; mask:byte);            override;
    function    count_points   : integer;                              override;
    function    count_lines    : integer;                              override;
    function    details : string;                                      override;
    procedure   write_to_DXF(var IO:textfile; layer:string);           override;
    procedure   max_min_extents(var emax,emin:Point3D);                override;
    function    closest_vertex_square_distance_2D(p:Point3D) : double; override;
    function    closest_vertex(p:Point3D) : Point3D;                   override;
    function    Move_point(p,newpoint:Point3D) : boolean;              override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Circle Definition
///////////////////////////////////////////////////////////////////////////////
type
  Circle_ = class(Point_) // always OCS
    radius : double;
    constructor create(OCSaxis,p_1:Point3D; radius_:double; col:integer);
    constructor create_from_polyline(ent1:DXF_Entity);
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    function    details : string;                                override;
    procedure   write_to_DXF(var IO:textfile; layer:string);     override;
    function    is_point_inside_object2D(p:Point3D) : boolean;   override;
    procedure   max_min_extents(var emax,emin:Point3D);          override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Arc Definition
///////////////////////////////////////////////////////////////////////////////
type
  Arc_ = class(Circle_)  // always OCS
    angle1,angle2 : double;
    constructor create(OCSaxis,p_1:Point3D; radius_,sa,ea:double; col:integer);
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    function    details : string;                                override;
    procedure   write_to_DXF(var IO:textfile; layer:string);     override;
    function    is_point_inside_object2D(p:Point3D) : boolean;   override;
    procedure   max_min_extents(var emax,emin:Point3D);          override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Polyline Definition
///////////////////////////////////////////////////////////////////////////////
type
  Polyline_ = class(DXF_Entity) // OCS/WCS depends
    closed      : boolean;
    numvertices : integer;
    polypoints  : ppointlist;
    numattrs    : integer;
    attribs     : array[0..max_my_attribs-1] of double;
    constructor create(OCSaxis:Point3D; numpoints:integer; points:ppointlist; col:integer; closed_:boolean);
    destructor  destroy;                                               override;
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    procedure   DrawVertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
    procedure   translate(T:Point3D);                                  override;
    procedure   quantize_coords(epsilon:double; mask:byte);            override;
    function    count_points   : integer;                              override;
    function    count_lines    : integer;                              override;
    function    count_polys_open   : integer;                          override;
    function    count_polys_closed : integer;                          override;
    function    details : string;                                      override;
    procedure   write_to_DXF(var IO:textfile; layer:string);           override;
    procedure   max_min_extents(var emax,emin:Point3D);                override;
    function    closest_vertex_square_distance_2D(p:Point3D) : double; override;
    function    closest_vertex(p:Point3D) : Point3D;                   override;
    // some functions I use...most removed....
    function    Move_point(p,newpoint:Point3D) : boolean;              override;
    function    is_point_inside_object2D(p:Point3D) : boolean;         override;
    function    triangle_centre : Point3D;
    procedure   set_attrib(i:integer; v:double);
    function    get_attrib(i:integer) : double;
    procedure   copy_attribs(p:Polyline_);
  end;
///////////////////////////////////////////////////////////////////////////////
// Face3D_ Definition - Should be 3DFace but can't name a type starting with 3
///////////////////////////////////////////////////////////////////////////////
type
  Face3D_ = class(Polyline_) // always WCS
    constructor create(numpoints:integer; points:ppointlist; col:integer; closed_:boolean);
    function    proper_name : string; override; // save as 3DFACE not Face3D
    procedure   write_to_DXF(var IO:textfile; layer:string);           override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Solid_ Definition
///////////////////////////////////////////////////////////////////////////////
type
  Solid_ = class(Face3D_) // always OCS
    thickness : double;
    constructor create(OCSaxis:Point3D; numpoints:integer; points:ppointlist; col:integer; t:double);
    function    proper_name : string;                                  override;
    procedure   write_to_DXF(var IO:textfile; layer:string);           override;
    function    details : string;                                      override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Polyline_ (polygon MxN grid mesh) Definition
///////////////////////////////////////////////////////////////////////////////
type
  Polygon_mesh_ = class(Polyline_) // always WCS ???
    M,N           : integer;
    closeM,closeN : boolean;
    constructor create(numpoints,Mc,Nc:integer; points:ppointlist; closebits,col:integer);
    function    proper_name : string;                                  override;
    procedure   write_to_DXF(var IO:textfile; layer:string);           override;
    function    details : string;                                      override;
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Polyline_ (polyface vertex array mesh) Definition
///////////////////////////////////////////////////////////////////////////////
type
  Polyface_mesh_ = class(Polyline_) // always WCS ???
    numfaces   : integer;
    facelist   : pfacelist;
    constructor create(numpoints,nfaces:integer; points:ppointlist; faces:pfacelist; col:integer);
    destructor  destroy;                                               override;
    function    proper_name : string;                                  override;
    procedure   write_to_DXF(var IO:textfile; layer:string);           override;
    function    details : string;                                      override;
    procedure   Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM); override;
  end;
///////////////////////////////////////////////////////////////////////////////
// Entity_List class definition
// An entity list is a collection of entities (in this case all the same type)
// I wanted to keep polylines & lines etc in separate lists, so the DXF_Layer
// will automatically handle this.
///////////////////////////////////////////////////////////////////////////////
type
  DXF_Layer   = class;

  Entity_List = class
  private
    function    add_at_end(entity:DXF_Entity) : boolean;
    function    insert(entity:DXF_Entity) : boolean;
  public
    list_name      : string;
    parent_layer   : DXF_Layer;
    Kludge_layer   : DXF_Layer; // see selection.save...
    entities       : TList;
    sorted         : boolean;
    constructor create(l_name:string);
    destructor  destroy; override;
    property    name : string read list_name write list_name;
    function    add_entity_to_list(entity:DXF_Entity) : boolean;
    function    remove_entity(ent:DXF_Entity) : boolean;
    procedure   draw_primitives(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
    procedure   draw_vertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
    function    num_entities : integer;
    function    count_points   : integer;
    function    count_lines    : integer;
    function    count_polys_open   : integer;
    function    count_polys_closed : integer;
    procedure   max_min_extents(var emax,emin:Point3D);
    procedure   setcolour(col:integer);
    function    closest_vertex_square_distance_2D(p:Point3D; var cl:DXF_Entity) : double;
    function    find_bounding_object(p:Point3D) : DXF_Entity;
  end;
///////////////////////////////////////////////////////////////////////////////
// DXF_layer class definition
// A collection of entity lists. One for each type.
///////////////////////////////////////////////////////////////////////////////
  DXF_Layer  = class
    layer_name   : string;
    layer_colinx : integer;
    entity_names : TStringList;
    entity_lists : TList;
    constructor create(l_name:string);
    destructor  destroy; override;
    procedure   delete(aname:string; releasemem:boolean);
    property    Colour : integer read layer_colinx write layer_colinx;
    property    name : string read layer_name write layer_name;
    function    add_entity_to_layer(entity:DXF_Entity) : boolean;
    // Add a pre filled list (save selected to file... see selected lists)
    procedure   add_entity_list(elist:Entity_List);
    // utilities
    function    num_lists : integer;
    procedure   max_min_extents(var emax,emin:Point3D);
    function    create_or_find_list_type(aname:string) : Entity_List;
  end;
///////////////////////////////////////////////////////////////////////////////
// DXF_Object class definition
// A Collection of DXF_Layers - eg a whole DXF file.
///////////////////////////////////////////////////////////////////////////////
type
  DXF_Object  = class
    DXF_name     : string;
    layer_lists  : TList;
    emax         : Point3D;
    emin         : Point3D;
    // Create an empty object
    constructor create(aname:string);
    // Create an object and load from file
    constructor create_from_file(aname:string; skipped:Tstrings);
    destructor  destroy; override;
    procedure   save_to_file(aname:string);
    property    name : string read DXF_name write DXF_name;
    function    num_layers : integer;
    // add an empty layer
    function    new_layer(aname:string; DUPs_OK:boolean) : DXF_Layer;
    // add a pre-filled layer
    function    add_layer(layer:DXF_Layer) : boolean;
    // return the layer with a given name
    function    layer(aname:string) : DXF_Layer;
    // add an entity to a named layer
    function    add_entity_to_layer(entity:DXF_Entity; aname:string) : boolean;
    // return layer and create if neccessary
    function    create_or_find_layer(aname:string) : DXF_Layer;
    // Add a second DXF file to this one
    function    merge_files(DXF_:DXF_Object) : boolean;
    // Useful ones
    procedure   remove_empty_layers_and_lists;
    procedure   copy_to_strings(ts:TStrings);
    function    get_min_extent         : Point3D;
    function    get_max_extent         : Point3D;
    // update the extents (not really needed)
    procedure   max_min_extents(var emax,emin:Point3D);
  end;
///////////////////////////////////////////////////////////////////////////////
// Selection_lists class definition
// A collection of entity lists. Used by mouse selection routines
///////////////////////////////////////////////////////////////////////////////
type
  selection_lists = class
    entity_lists : TList;
    constructor create;
    destructor  destroy; override;
    procedure   save_to_DXF_file(aname:string);
    function    find_closest_2D_point(p:Point3D; var ent:DXF_Entity) : Point3D;
    function    is_inside_object(p:Point3D; var ent:DXF_Entity) : Point3D;
  end;
///////////////////////////////////////////////////////////////////////////////
// DXF exceptions will be this type
///////////////////////////////////////////////////////////////////////////////
type
  DXF_exception = class(Exception);
///////////////////////////////////////////////////////////////////////////////
// Default AutoCad layer colours (1..7) - (8..user defined)
///////////////////////////////////////////////////////////////////////////////
const
  BYLAYER = 256;
const
  def_cols = 12;
  DXF_Layer_Colours : array[0..def_cols] of TColor = (clBlack, // zero - not used
    clRed,    clYellow, clLime,   clAqua,   clBlue,   clPurple, {clWhite}clBlack,
    clOlive,  clFuchsia,clTeal,   clGray,   clDkGray);
///////////////////////////////////////////////////////////////////////////////
// Memory check variables
///////////////////////////////////////////////////////////////////////////////
var
  entities_in_existence  : integer;
  Ent_lists_in_existence : integer;
  layers_in_existence    : integer;
  DXF_Obj_in_existence   : integer;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// implementation
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
implementation

uses
  DXF_read, DXF_write;

procedure draw_cross(acanvas:TCanvas; p1:TPoint);
var pa,pb : TPoint;
begin
  pa.x := p1.x-2; pa.y := p1.y-2;
  pb.x := p1.x+3; pb.y := p1.y+3;
  acanvas.Moveto(pa.x,pa.y);
  acanvas.Lineto(pb.x,pb.y);
  pa.x := p1.x-2; pa.y := p1.y+2;
  pb.x := p1.x+3; pb.y := p1.y-3;
  acanvas.Moveto(pa.x,pa.y);
  acanvas.Lineto(pb.x,pb.y);
end;
///////////////////////////////////////////////////////////////////////////////
// DXF_Entity - abstract base class - override where neccessary
///////////////////////////////////////////////////////////////////////////////
constructor DXF_Entity.create;
begin
  inc(entities_in_existence);
end;

destructor DXF_Entity.destroy;
begin
  if OCS_WCS<>nil then deallocate_matrix(OCS_WCS);
  dec(entities_in_existence);
  inherited destroy;
end;

procedure DXF_Entity.init_OCS_WCS_matrix(OCSaxis:Point3D);
var Ax,Ay : Point3D;
begin
  OCS_axis := OCSaxis;
  if not p1_eq_p2_3D(OCSaxis,WCS_Z) then begin
    OCS_WCS  := allocate_matrix;
    if (abs(OCSaxis.x)<1/64) and (abs(OCSaxis.y)<1/64) then Ax := normalize(cross(WCS_Y,OCSaxis))
    else                                                    Ax := normalize(cross(WCS_Z,OCSaxis));
    Ay       := normalize(cross(OCSaxis,Ax));
    OCS_WCS^ := CreateTransformation(Ax,Ay,OCSaxis);
  end;
end;

procedure DXF_Entity.setcolour_index(col:integer);
begin
  colinx := col;
  colour := DXF_Layer_Colours[col mod (def_cols+1)];
end;

procedure DXF_Entity.setcolour(col:TColor);
var lp1 : integer;
begin
  colinx := 0;
  for lp1:=0 to def_cols do if DXF_Layer_Colours[lp1]=col then colinx := lp1;
  colour := col;
end;

function DXF_Entity.count_points   : integer;
begin result := 1; end;

function DXF_Entity.count_lines    : integer;
begin result := 0; end;

function DXF_Entity.count_polys_open    : integer;
begin result := 0; end;

function DXF_Entity.count_polys_closed  : integer;
begin result := 0; end;

function DXF_Entity.proper_name : string;
var temp : string;
begin
  temp := UpperCase(ClassName);
  result := Copy(temp,1,Length(temp)-1);
end;

procedure DXF_Entity.write_DXF_Point(var IO:textfile; n:integer; p:Point3D);
begin
  writeln(IO, n    , EOL,float_out(p.x) );
  writeln(IO, n+10 , EOL,float_out(p.y) );
  writeln(IO, n+20 , EOL,float_out(p.z) );
end;

procedure DXF_Entity.write_to_DXF(var IO:textfile; layer:string);
begin
  writeln(IO,0 ,EOL,proper_name);
  writeln(IO,8 ,EOL,layer);
  writeln(IO,62,EOL,colinx);
  if OCS_WCS<>nil then write_DXF_Point(IO,210,OCS_axis);
end;

function DXF_Entity.is_point_inside_object2D(p:Point3D) : boolean;
begin
  result := false;
end;

function DXF_Entity.Move_point(p,newpoint:Point3D) : boolean;
begin
  result := false;
end;

///////////////////////////////////////////////////////////////////////////////
// Block_ class implementation
///////////////////////////////////////////////////////////////////////////////
constructor Block_.create(bname:string; refpoint:Point3D);
begin
  entities   := TList.Create;
  basepoint  := refpoint;
  if not p1_eq_p2_3D(basepoint,origin3D) then begin
    OCS_WCS  := allocate_matrix;
    OCS_WCS^ := TranslateMatrix(p1_minus_p2(origin3D,basepoint));
  end;
  name       := bname;
end;

destructor Block_.destroy;
var lp1 : integer;
begin
  for lp1:=0 to entities.count-1 do DXF_Entity(entities[lp1]).free;
  entities.Free;
end;

procedure Block_.update_block_links(blist:TObject);
var lp1 : integer;
begin
  for lp1:=0 to entities.count-1 do if (TObject(entities[lp1]) is Insert_) then
    Insert_(entities[lp1]).update_block_links(blist);
end;

procedure Block_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var lp1        : integer;
    t_matrix   : pMatrix;
    TempMatrix : Matrix;
begin
  // we mustn't use the update_transformations call because blocks may be
  // nested inside blocks inside other blocks, and update_transformations uses
  // a temp fixed matrix which will be overwritten.
  if OCS=nil then t_matrix := OCS_WCS
  else if OCS_WCS=nil then t_matrix := OCS
  else begin
    TempMatrix := MatrixMultiply(OCS_WCS^,OCS^);
    t_matrix   := @TempMatrix;
  end;
  for lp1:=0 to entities.count-1 do
    DXF_Entity(entities[lp1]).draw(acanvas,map_fn,t_matrix);
end;

procedure Block_.DrawVertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var lp1 : integer;
begin
  for lp1:=0 to entities.count-1 do
    DXF_Entity(entities[lp1]).drawvertices(acanvas,map_fn,OCS);
end;

function Block_.details : string;
var lp1 : integer;
begin
  result := 'Name :'#9 + name + EOL +
            'Base :'#9 + Point3DToStr(basepoint);
  for lp1:=0 to entities.count-1 do result := result + EOL + EOL + DXF_Entity(entities[lp1]).details;
end;

procedure Block_.write_to_DXF(var IO:textfile; layer:string);
var lp1 : integer;
begin
  writeln(IO,0 ,EOL,proper_name);
  writeln(IO,8 ,EOL,layer);
  writeln(IO,2 ,EOL,name);
  write_DXF_Point(IO,10,basepoint);
  for lp1:=0 to entities.count-1 do DXF_Entity(entities[lp1]).write_to_DXF(IO,layer);
  writeln(IO,0 ,EOL,'ENDBLK');
end;

procedure Block_.max_min_extents(var emax,emin:Point3D);
begin end;

function Block_.closest_vertex_square_distance_2D(p:Point3D) : double;
begin result := 1E9; end;

function Block_.closest_vertex(p:Point3D) : Point3D;
begin result := aPoint3D(1E9,1E9,1E9); end;
///////////////////////////////////////////////////////////////////////////////
// Point
///////////////////////////////////////////////////////////////////////////////
constructor Point_.create(OCSaxis,p:Point3D; col:integer);
begin
  inherited create;
  p1 := p;
  setcolour_index(col);
  init_OCS_WCS_matrix(OCSaxis);
end;

procedure Point_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var po       : TPoint;
    t_matrix : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  with acanvas.Pen do if Color<>colour then Color:=colour;
  po := map_fn(p1,t_matrix);
  draw_cross(acanvas,po);
end;

procedure Point_.DrawVertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var po       : TPoint;
    t_matrix : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  with acanvas.Pen do if Color<>colour then Color:=colour;
  po := map_fn(p1,t_matrix);
  draw_cross(acanvas,po);
end;

procedure Point_.translate(T:Point3D);
begin
  p1 := p1_plus_p2(p1,T);
end;

procedure Point_.quantize_coords(epsilon:double; mask:byte);
begin
  if (mask and 1)=1 then p1.x := round(p1.x*epsilon)/epsilon;
  if (mask and 2)=2 then p1.y := round(p1.y*epsilon)/epsilon;
  if (mask and 4)=4 then p1.z := round(p1.z*epsilon)/epsilon;
end;

function Point_.details : string;
var t : string;
begin
  if OCS_WCS<>nil then t := 'OCS Axis ' + Point3DToStr(OCS_axis)
  else t := 'WCS';
  result := ClassName + EOL + t + EOL + Point3DToStr(p1);
end;

procedure Point_.write_to_DXF(var IO:textfile; layer:string);
begin
  inherited;
  write_DXF_Point(IO,10,p1);
end;

procedure Point_.max_min_extents(var emax,emin:Point3D);
begin
  max_bound(emax,p1); min_bound(emin,p1);
end;

function Point_.closest_vertex_square_distance_2D(p:Point3D) : double;
begin
  result := sq_dist2D(p1,p);
end;

function Point_.closest_vertex(p:Point3D) : Point3D;
begin
  result := p1;
end;

function Point_.Move_point(p,newpoint:Point3D) : boolean;
begin
  if p1_eq_p2_3D(p1,p) then begin
    p1 := newpoint;
    result := true;
  end else result := false;
end;

///////////////////////////////////////////////////////////////////////////////
// Text
///////////////////////////////////////////////////////////////////////////////
constructor Text_.create(OCSaxis,p,ap:Point3D; ss:string; height:double; col,ha:integer);
begin
  inherited create(OCSaxis,p,col);
  h := height;
  if ss<>'' then textstr := ss;
  if p1_eq_p2_3D(ap,origin3D) then ap:=p;
  align_pt  := ap;
  hor_align := ha;
end;

procedure Text_.calcText(acanvas:TCanvas; map_fn:coord_convert; OCS:pM; t:string);
var pa,dummy1,dummy2 : TPoint;
    Fheight          : integer;
begin
  with acanvas.Pen do if Color<>colour then Color:=colour;
  // kludgy method for scaling text heights
  dummy1  := map_fn(origin3D,nil);
  dummy2  := map_fn(aPoint3D(0,h,0),nil);
  Fheight := 2+(dummy1.y-dummy2.y);
  if FHeight=2 then exit;
  with acanvas.Font do begin
    if Height<>Fheight then Height := Fheight;
    if color<>colour then color := colour;
  end;
  case hor_align of
    0 : SetTextAlign(acanvas.handle,TA_LEFT   + TA_BASELINE);
    1 : SetTextAlign(acanvas.handle,TA_CENTER + TA_BASELINE);
    2 : SetTextAlign(acanvas.handle,TA_RIGHT  + TA_BASELINE);
  end;
  pa := map_fn(align_pt,OCS_WCS);
  acanvas.TextOut(pa.x,pa.y,t);
end;

procedure Text_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var t_matrix : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  calcText(acanvas,map_fn,t_matrix,textstr);
end;

function Text_.details : string;
begin
  result := inherited details + EOL +
            'Text '#9 + textstr + EOL +
            'TextHeight = ' + float_out(h);
end;

procedure Text_.write_to_DXF(var IO:textfile; layer:string);
begin
  inherited;
  writeln(IO,40 ,EOL,float_out(h));
  writeln(IO,1  ,EOL,textstr);
  if hor_align<>0 then begin
    write_DXF_Point(IO,11,align_pt);
    writeln(IO,72 ,EOL,hor_align);
  end;
end;

procedure Text_.max_min_extents(var emax,emin:Point3D);
begin
  max_bound(emax,p1); min_bound(emin,p1);
end;
///////////////////////////////////////////////////////////////////////////////
// Attrib
///////////////////////////////////////////////////////////////////////////////
constructor Attrib_.create(OCSaxis,p,ap:Point3D; ss,tag:string; flag70,flag72:integer; height:double; col:integer);
begin
  inherited create(OCSaxis,p,ap,ss,height,col,flag72);
  tagstr := tag;
  if (flag70 and 1)=1 then visible:=false
  else visible := true;
end;

procedure Attrib_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var t_matrix : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  if not visible then exit;
  calcText(acanvas,map_fn,t_matrix,tagstr);
end;

function Attrib_.details : string;
var t : string;
begin
  if visible then t:='Visible' else t:='Invisible';
  result := inherited details + EOL +
            'Tag '#9 + TagStr + EOL + t;
end;

procedure Attrib_.write_to_DXF(var IO:textfile; layer:string);
begin
  inherited;
  writeln(IO,2 ,EOL,tagstr);
  if visible then writeln(IO,70 ,EOL,0)
  else            writeln(IO,70 ,EOL,1)
end;
///////////////////////////////////////////////////////////////////////////////
// Attdef
///////////////////////////////////////////////////////////////////////////////
constructor Attdef_.create(OCSaxis,p,ap:Point3D; ss,tag,prompt:string; flag70,flag72:integer; height:double; col:integer);
begin
  inherited create(OCSaxis,p,ap,ss,tag,flag70,flag72,height,col);
  promptstr := prompt;
end;

procedure Attdef_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
begin
  // Attdefs are used in the blocks section to act as templates for Attribs
  // so no need to draw them as there will be an Attrib in its place
end;

procedure Attdef_.write_to_DXF(var IO:textfile; layer:string);
begin
  inherited;
  writeln(IO,DXF_text_prompt ,EOL,promptstr);
end;
///////////////////////////////////////////////////////////////////////////////
// Insert
///////////////////////////////////////////////////////////////////////////////
constructor Insert_.create(OCSaxis,p,s_f:Point3D; rot:double; col:integer; numatts:integer; atts:patt_array; block:string);
var lp1 : integer;
begin
  inherited create(OCSaxis,p,col);
  blockname   := block;
  blockptr    := nil;
  scale       := s_f;
  rotation    := DegToRad(rot);
  init_OCS_WCS_matrix(OCSaxis);
  num_attribs := numatts;
  if num_attribs>max_attribs then raise Exception.Create('This version only handles '+IntToStr(max_attribs)+' ATTRIBs');
  for lp1:=0 to num_attribs-1 do attribs[lp1] := atts^[lp1];
end;

destructor Insert_.destroy;
var lp1 : integer;
begin
  for lp1:=0 to num_attribs-1 do attribs[lp1].Free;
  inherited destroy;
end;

procedure Insert_.init_OCS_WCS_matrix(OCSaxis:Point3D);
var Ax,Ay : Point3D;
begin
  // inserts always have a transformation matrix - to allow the translation
  // even when the other parameters are defauls
  OCS_axis := OCSaxis;
  OCS_WCS  := allocate_matrix;
  if (abs(OCSaxis.x)<1/64) and (abs(OCSaxis.y)<1/64) then Ax := normalize(cross(WCS_Y,OCSaxis))
  else                                                    Ax := normalize(cross(WCS_Z,OCSaxis));
  Ay       := normalize(cross(OCSaxis,Ax));
  OCS_WCS^ := Identity;
  OCS_WCS^ := MatrixMultiply(OCS_WCS^, ZRotateMatrix(cos(-rotation),sin(-rotation)));
  OCS_WCS^ := MatrixMultiply(OCS_WCS^, ScaleMatrix(scale) );
  OCS_WCS^ := MatrixMultiply(OCS_WCS^, TranslateMatrix(p1) );
  OCS_WCS^ := MatrixMultiply(OCS_WCS^, CreateTransformation(Ax,Ay,OCSaxis) );
end;

procedure Insert_.update_block_links(blist:TObject);
begin
  blocklist := blist;
  if blockname<>'' then block.update_block_links(blist);
end;

// instead of searching for the block every time it's needed, we'll store
// the object pointer after the first time it's used, and return it
// when needed. Only use this function to access it - for safety.
function Insert_.block : Block_;
var lp1 : integer;
begin
  result := blockptr;
  if blockptr=nil then
  begin // this bit called once
    for lp1:=0 to Entity_List(blocklist).entities.count-1 do begin
      if Block_(Entity_List(blocklist).entities[lp1]).name=blockname then begin
        blockptr := Block_(Entity_List(blocklist).entities[lp1]);
        result   := blockptr;
        exit;
      end;
    end;
  end // this bit every subsequent time
  else
    result := blockptr;
  if result=nil then
    raise Exception.Create('Block reference '+blockname+' not found');
end;

procedure Insert_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var lp1        : integer;
    t_matrix   : pMatrix;
    TempMatrix : Matrix;
begin
  // we mustn't use the update_transformations call because inserts may be
  // nested inside blocks inside other blocks, and update_transformations uses
  // a temp fixed matrix which will be overwritten.
  if OCS=nil then t_matrix := OCS_WCS
  else if OCS_WCS=nil then t_matrix := OCS
  else begin
    TempMatrix := MatrixMultiply(OCS_WCS^,OCS^);
    t_matrix := @TempMatrix;
  end;
  for lp1:=0 to num_attribs-1 do attribs[lp1].Draw(acanvas,map_fn,t_matrix);
  if blockname<>'' then block.Draw(acanvas,map_fn,t_matrix);
end;

function Insert_.details : string;
var lp1 : integer;
begin
  result := inherited details + EOL +
            'Block '#9 + blockname + EOL +
            'Scaling'#9 + Point3DToStr(scale) + EOL +
            'Rotation'#9 + float_out(RadToDeg(rotation)) + EOL +
            'Attribs '#9 + IntToStr(num_attribs);
  for lp1:=0 to num_attribs-1 do begin
    result := result + EOL + EOL;
    result := result + IntToStr(lp1+1) + ' : ' + attribs[lp1].details;
  end;
  result := result  + EOL + EOL +
            '----BLOCK-----' + EOL +
            block.details + EOL +
            '---ENDBLOCK---';
end;

procedure Insert_.write_to_DXF(var IO:textfile; layer:string);
var lp1 : integer;
begin
  inherited;
  if blockname<>'' then writeln(IO,2,EOL,blockname);
  if (scale.x<>1) or (scale.y<>1) or (scale.z<>1) then begin
    writeln(IO,41,EOL,float_out(scale.x));
    writeln(IO,42,EOL,float_out(scale.y));
    writeln(IO,43,EOL,float_out(scale.z));
  end;
  if rotation<>0 then writeln(IO,50,EOL,float_out(RadToDeg(rotation)));
  if num_attribs>0 then begin
    writeln(IO,66,EOL,1);
    for lp1:=0 to num_attribs-1 do attribs[lp1].write_to_DXF(IO,layer);
    writeln(IO,0,EOL,'SEQEND');
  end
  else writeln(IO,66,EOL,0);
end;

procedure Insert_.max_min_extents(var emax,emin:Point3D);
begin
  inherited;
end;
///////////////////////////////////////////////////////////////////////////////
// Line
///////////////////////////////////////////////////////////////////////////////
constructor Line_.create(p_1,p_2:Point3D; col:integer);
begin
  inherited create(WCS_Z,p_1,col);
  p2 := p_2;
end;

procedure Line_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var pa,pb    : TPoint;
    t_matrix : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  with acanvas.Pen do if Color<>colour then Color:=colour;
  pa := map_fn(p1,t_matrix);
  pb := map_fn(p2,t_matrix);
  acanvas.Moveto(pa.x,pa.y);
  acanvas.Lineto(pb.x,pb.y);
end;

procedure Line_.DrawVertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var po : TPoint;
    t_matrix : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  with acanvas.Pen do if Color<>colour then Color:=colour;
  po := map_fn(p1,t_matrix);
  draw_cross(acanvas,po);
  po := map_fn(p2,t_matrix);
  draw_cross(acanvas,po);
end;

procedure Line_.translate(T:Point3D);
begin
  p1 := p1_plus_p2(p1,T);
  p2 := p1_plus_p2(p2,T);
end;

procedure Line_.quantize_coords(epsilon:double; mask:byte);
begin
  if (mask and 1)=1 then begin
    p1.x := round(p1.x*epsilon)/epsilon;
    p2.x := round(p2.x*epsilon)/epsilon;
  end;
  if (mask and 2)=2 then begin
    p1.y := round(p1.y*epsilon)/epsilon;
    p2.y := round(p2.y*epsilon)/epsilon;
  end;
  if (mask and 4)=4 then begin
    p1.z := round(p1.z*epsilon)/epsilon;
    p2.z := round(p2.z*epsilon)/epsilon;
  end;
end;

function Line_.count_points : integer;
begin result := 2; end;

function Line_.count_lines : integer;
begin result := 1; end;

function Line_.details : string;
begin
  result := inherited details + EOL + Point3DToStr(p2);
end;

procedure Line_.write_to_DXF(var IO:textfile; layer:string);
begin
  inherited;
  write_DXF_Point(IO,11,p2);
end;

procedure Line_.max_min_extents(var emax,emin:Point3D);
begin
  max_bound(emax,p1); min_bound(emin,p1);
  max_bound(emax,p2); min_bound(emin,p2);
end;

function Line_.closest_vertex_square_distance_2D(p:Point3D) : double;
begin
  result := dmin(sq_dist2D(p1,p),sq_dist2D(p2,p));
end;

function Line_.closest_vertex(p:Point3D) : Point3D;
begin
  if sq_dist2D(p1,p)<sq_dist2D(p2,p) then result := p1 else result := p2;
end;

function Line_.Move_point(p,newpoint:Point3D) : boolean;
begin
  if p1_eq_p2_3D(p1,p) then begin
    p1 := newpoint;
    result := true;
  end
  else if p1_eq_p2_3D(p2,p) then begin
    p2 := newpoint;
    result := true;
  end
  else result := false;
end;
///////////////////////////////////////////////////////////////////////////////
// Circle
///////////////////////////////////////////////////////////////////////////////
constructor Circle_.create(OCSaxis,p_1:Point3D; radius_:double; col:integer);
begin
  inherited create(OCSaxis,p_1,col);
  radius := radius_;
end;

constructor Circle_.create_from_polyline(ent1:DXF_Entity);
var p_1 : Point3D;
    d   : double;
    lp1 : integer;
begin
  p_1 := origin3D;
  d   := 0;
  with Polyline_(ent1) do begin
    for lp1:=0 to numvertices-1 do p_1 := p1_plus_p2(polypoints^[lp1],p_1);
    p_1.x := p_1.x/numvertices;
    p_1.y := p_1.y/numvertices;
    p_1.z := p_1.z/numvertices;
    for lp1:=0 to numvertices-1 do d := d + dist3D(polypoints^[lp1],p_1);
    d := d/numvertices;
  end;
  inherited create(ent1.OCS_axis,p_1,ent1.colinx);
  radius := d;
end;

procedure Circle_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var pa,pb    : TPoint;
    t_matrix : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  with acanvas.Pen do if Color<>colour then Color:=colour;
  pa := map_fn(aPoint3D(p1.x-radius,p1.y-radius,p1.z-radius),t_matrix);
  pb := map_fn(aPoint3D(p1.x+radius,p1.y+radius,p1.z+radius),t_matrix);
  // bug in Ellipse routine causes crash if extents are too small
  if (pb.x>pa.x+1) and (pa.y>pb.y+1) then
    acanvas.Ellipse(pa.x,pa.y,pb.x,pb.y)
  else acanvas.pixels[pa.x,pa.y] := acanvas.Pen.Color;
end;

function Circle_.details : string;
begin
  result := inherited details + EOL +
            'Radius = ' + float_out(radius);
end;

procedure Circle_.write_to_DXF(var IO:textfile; layer:string);
begin
  inherited;
  writeln(IO,40,EOL,float_out(radius));
end;

function Circle_.is_point_inside_object2D(p:Point3D) : boolean;
begin
  result := dist2D(p,p1)<=radius;
end;

procedure Circle_.max_min_extents(var emax,emin:Point3D);
begin
  max_bound(emax, p1_plus_p2 (p1, aPoint3D(radius,radius,0)));
  min_bound(emin, p1_minus_p2(p1, aPoint3D(radius,radius,0)));
end;
///////////////////////////////////////////////////////////////////////////////
// Arc
///////////////////////////////////////////////////////////////////////////////
constructor Arc_.create(OCSaxis,p_1:Point3D; radius_,sa,ea:double; col:integer);
begin
  inherited create(OCSaxis,p_1,radius_,col);
  angle1 := DegToRad(sa);
  angle2 := DegToRad(ea);
end;

procedure Arc_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var pu,pv,pw,px : TPoint;
    t_matrix    : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  with acanvas.Pen do if Color<>colour then Color:=colour;
  pu := map_fn(aPoint3D(p1.x-radius,p1.y-radius,p1.z-radius),t_matrix);
  pv := map_fn(aPoint3D(p1.x+radius,p1.y+radius,p1.z+radius),t_matrix);
  pw := map_fn(aPoint3D(p1.x+cos(angle1)*radius,p1.y+sin(angle1)*radius,p1.z+radius),t_matrix);
  px := map_fn(aPoint3D(p1.x+cos(angle2)*radius,p1.y+sin(angle2)*radius,p1.z+radius),t_matrix);
  if (pv.x>pu.x+1) and (pu.y>pv.y+1) then
    acanvas.Arc(pu.x,pu.y,pv.x,pv.y,pw.x,pw.y,px.x,px.y)
  else
  acanvas.pixels[pu.x,pu.y] := acanvas.Pen.Color;
end;

function Arc_.details : string;
begin
  result := inherited details + EOL +
            'Angle 1 = ' + float_out(angle1) + EOL +
            'Angle 2 = ' + float_out(angle2);
end;

procedure Arc_.write_to_DXF(var IO:textfile; layer:string);
begin
  inherited;
  writeln(IO,50,EOL,float_out(RadToDeg(angle1)));
  writeln(IO,51,EOL,float_out(RadToDeg(angle2)));
end;

function Arc_.is_point_inside_object2D(p:Point3D) : boolean;
begin
  result := false;
end;

procedure Arc_.max_min_extents(var emax,emin:Point3D);
var ax,ay,bx,by  : double;
    thisboundary : integer;
    lastboundary : integer;
begin
  // the end points of the arc
  ax := p1.x + radius*cos(angle1);
  ay := p1.y + radius*sin(angle1);
  bx := p1.x + radius*cos(angle2);
  by := p1.y + radius*sin(angle2);
  max_bound(emax, aPoint3D(ax,ay,0));
  min_bound(emin, aPoint3D(ax,ay,0));
  max_bound(emax, aPoint3D(bx,by,0));
  min_bound(emin, aPoint3D(bx,by,0));
  // long arcs may extend along the axes (quadrants) (eg 1 to 359 ->90,180,270)
  lastboundary := 90*((trunc(RadToDeg(angle2))+89) div 90);
  if lastboundary=360 then lastboundary := 0;
  thisboundary := 90*((trunc(RadToDeg(angle1))+90) div 90);
  if thisboundary=360 then thisboundary := 0;
  while thisboundary<>lastboundary do begin
    ax := p1.x + radius*cos(DegToRad(thisboundary));
    ay := p1.y + radius*sin(DegToRad(thisboundary));
    max_bound(emax, aPoint3D(ax,ay,0));
    min_bound(emin, aPoint3D(ax,ay,0));
    thisboundary := thisboundary+90;
    if thisboundary=360 then thisboundary := 0;
  end;
end;
///////////////////////////////////////////////////////////////////////////////
// Polyline
///////////////////////////////////////////////////////////////////////////////
constructor Polyline_.create(OCSaxis:Point3D; numpoints:integer; points:ppointlist; col:integer; closed_:boolean);
var lp1 : integer;
begin
  inherited create;
  init_OCS_WCS_matrix(OCSaxis);
  numvertices := numpoints;
  if closed_ then closed := true
  else if p1_eq_p2_3D(points[0],points[numvertices-1]) then begin
    closed := true;
    dec(numvertices);
  end
  else closed := false;
  polypoints := allocate_points(numvertices);
  for lp1:=0 to numvertices-1 do polypoints^[lp1] := points^[lp1];
  setcolour_index(col);
end;

destructor Polyline_.destroy;
begin
  deallocate_points(polypoints,numvertices);
  inherited destroy;
end;

procedure Polyline_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var PointArray : array[0..max_vertices_per_polyline-1] of TPoint;
    lp1     : integer;
    t_matrix   : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  with acanvas.Pen do if Color<>colour then Color:=colour;
  for lp1:=0 to numvertices-1 do
    PointArray[lp1] := map_fn(polypoints^[lp1],t_matrix);
  if not closed then acanvas.Polyline(Slice(PointArray,numvertices))
  else acanvas.Polygon(Slice(PointArray,numvertices));
end;

procedure Polyline_.DrawVertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var po         : TPoint;
    lp1        : integer;
    t_matrix   : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  with acanvas.Pen do if Color<>colour then Color:=colour;
  for lp1:=0 to numvertices-1 do begin
    po := map_fn(polypoints^[lp1],t_matrix);
    draw_cross(acanvas,po);
  end;
end;

procedure Polyline_.translate(T:Point3D);
var lp1 : integer;
begin
  for lp1:=0 to numvertices-1 do polypoints^[lp1] := p1_plus_p2(polypoints^[lp1],T);
end;

procedure Polyline_.quantize_coords(epsilon:double; mask:byte);
var lp1 : integer;
begin
  for lp1:=0 to numvertices-1 do begin
    if (mask and 1)=1 then polypoints^[lp1].x := round(polypoints^[lp1].x*epsilon)/epsilon;
    if (mask and 2)=2 then polypoints^[lp1].y := round(polypoints^[lp1].y*epsilon)/epsilon;
    if (mask and 4)=4 then polypoints^[lp1].z := round(polypoints^[lp1].z*epsilon)/epsilon;
  end;
end;

function Polyline_.count_points   : integer;
begin result := numvertices; end;

function Polyline_.count_lines : integer;
begin result := numvertices; end;

function Polyline_.count_polys_open : integer;
begin if not closed then result := 1 else result := 0;end;

function Polyline_.count_polys_closed : integer;
begin if closed then result := 1 else result := 0;end;

function Polyline_.details : string;
var lp1 : integer;
    t   : string;
begin
  if OCS_WCS<>nil then t := 'OCS Axis ' + Point3DToStr(OCS_axis)
  else t := 'WCS';
  result := classname + EOL + t;
  if closed then result := result + EOL + 'Closed'
  else result := result + EOL + 'Open';
  for lp1:=0 to numvertices-1 do result := result + EOL + Point3DToStr(polypoints^[lp1]);
end;

procedure Polyline_.write_to_DXF(var IO:textfile; layer:string);
var lp1 : integer;
begin
  inherited;
  if closed then writeln(IO,70 ,EOL,1+8) // 1+8 = closed+3D
  else writeln(IO,70 ,EOL,8);
  for lp1:=0 to numvertices-1 do begin
    writeln(IO,0 ,EOL,'VERTEX');
    writeln(IO,70 ,EOL,32);    // 3D polyline mesh vertex
    write_DXF_Point(IO, 10, polypoints^[lp1]);
  end;
  writeln(IO,0 ,EOL,'SEQEND');
end;

procedure Polyline_.max_min_extents(var emax,emin:Point3D);
var lp1 : integer;
begin
  for lp1:=0 to numvertices-1 do begin
    max_bound(emax,polypoints^[lp1]); min_bound(emin,polypoints^[lp1]);
  end;
end;

function Polyline_.closest_vertex_square_distance_2D(p:Point3D) : double;
var lp1 : integer;
begin
  result := 1E10;
  for lp1:=0 to numvertices-1 do
    result := dmin(result,sq_dist2D(polypoints^[lp1],p));
end;

function Polyline_.closest_vertex(p:Point3D) : Point3D;
var lp1 : integer;
    d1,d2 : double;
begin
  d1 := 1E10;
  for lp1:=0 to numvertices-1 do begin
    d2 := sq_dist2D(polypoints^[lp1],p);
    if d2<d1 then begin
      result := polypoints^[lp1];
      d1 := d2;
    end;
  end;
end;

function Polyline_.Move_point(p,newpoint:Point3D) : boolean;
var lp1  : integer;
begin
  for lp1:=0 to numvertices-1 do begin
    if p1_eq_p2_3D(polypoints^[lp1],p) then begin
      polypoints^[lp1] := newpoint;
      result := true;
      exit;
    end;
  end;
  result := false;
end;

function Polyline_.triangle_centre : Point3D;
var s,t : integer;
begin
  if numvertices<>3 then
    raise Exception.Create('Shouldn''t call this for non triangular facets');
    s := 1; t := 2;
  result := p1_plus_p2(polypoints^[0],p1_plus_p2(polypoints^[s],polypoints^[t]));
  result := p1_x_n(result,1/3);
end;

procedure Polyline_.set_attrib(i:integer; v:double);
begin
  if (i+1)>numattrs then numattrs:=(i+1);
  attribs[i] := v;
end;

function Polyline_.get_attrib(i:integer) : double;
begin
  if i>=numattrs then result := 0
  else result := attribs[i];
end;

procedure Polyline_.copy_attribs(p:Polyline_);
var lp1 : integer;
begin
  p.numattrs := numattrs;
  for lp1:=0 to numattrs-1 do p.attribs[lp1] := attribs[lp1];
end;

function Polyline_.is_point_inside_object2D(p:Point3D) : boolean;
var i,j       : integer;
    p1_i,p1_j : Point3D;
begin
  result := false;
  if not closed then exit;
  j := numvertices-1;
  for i:=0 to numvertices-1 do with p do begin
    p1_i := polypoints^[i];
    p1_j := polypoints^[j];
    if ((((p1_i.y<=y) and (y<p1_j.y)) or
         ((p1_j.y<=y) and (y<p1_i.y))) and
          (x<(p1_j.x - p1_i.x)*(y-p1_i.y)/
          (p1_j.y - p1_i.y) + p1_i.x)) then result:= not result;
    j:=i;
  end;
end;

///////////////////////////////////////////////////////////////////////////////
// Face3D
///////////////////////////////////////////////////////////////////////////////
constructor Face3D_.create(numpoints:integer; points:ppointlist; col:integer; closed_:boolean);
begin
  inherited create(WCS_Z,numpoints,points,col,closed_);
end;

function Face3D_.proper_name : string;
begin
  result := '3DFACE';
end;

procedure Face3D_.write_to_DXF(var IO:textfile; layer:string);
var lp1 : integer;
begin
  writeln(IO,0 ,EOL,proper_name);
  writeln(IO,8 ,EOL,layer);
  writeln(IO,62,EOL,colinx);
  for lp1:=0 to numvertices-1 do
    write_DXF_Point(IO, 10 + lp1, polypoints^[lp1]);
  if numvertices=3 then begin // 4th point is same as third
    lp1 := 3;
    write_DXF_Point(IO, 10 + lp1, polypoints^[lp1-1]);
  end;
end;
///////////////////////////////////////////////////////////////////////////////
// Solid_
///////////////////////////////////////////////////////////////////////////////
constructor Solid_.create(OCSaxis:Point3D; numpoints:integer; points:ppointlist; col:integer; t:double);
begin
  inherited create(numpoints,points,col,true);
  thickness := t;
  init_OCS_WCS_matrix(OCSaxis);
end;

function Solid_.proper_name : string;
begin
  result := 'SOLID';
end;

procedure Solid_.write_to_DXF(var IO:textfile; layer:string);
begin
  inherited;
  writeln(IO,39,EOL,thickness);
end;

function Solid_.details : string;
begin
  result := inherited details + EOL +
            'Thickness'#9 + float_out(thickness);
end;

///////////////////////////////////////////////////////////////////////////////
// Polyline_ (polygon MxN grid mesh)
///////////////////////////////////////////////////////////////////////////////
constructor Polygon_mesh_.create(numpoints,Mc,Nc:integer; points:ppointlist; closebits,col:integer);
begin
  inherited create(WCS_Z,numpoints,points,col,false);
  M := Mc; N := Nc;
  closeM := (closebits and 1 )=1;
  closeN := (closebits and 32)=32;
end;

function Polygon_mesh_.proper_name : string;
begin
  result := 'POLYLINE';
end;

procedure Polygon_mesh_.write_to_DXF(var IO:textfile; layer:string);
var lp1,flag : integer;
begin
  writeln(IO,0 ,EOL,proper_name);
  writeln(IO,8 ,EOL,layer);
  writeln(IO,62,EOL,colinx);
  writeln(IO,66,EOL,1);
  flag := 16;
  if closeM then flag := flag+1;
  if closeN then flag := flag+32;
  writeln(IO,70 ,EOL,flag);
  writeln(IO,71 ,EOL,M);
  writeln(IO,72 ,EOL,N);
  for lp1:=0 to numvertices-1 do begin
    writeln(IO,0  ,EOL,'VERTEX');
    writeln(IO,70 ,EOL,64);    // polygon mesh vertex
    write_DXF_Point(IO, 10, polypoints^[lp1]);
  end;
  writeln(IO,0 ,EOL,'SEQEND');
end;

function Polygon_mesh_.details : string;
var t : string;
begin
  if OCS_WCS<>nil then t := 'OCS Axis ' + Point3DToStr(OCS_axis)
  else t := 'WCS';
  result := 'Polyline_ (polygon mesh)' + EOL + t + EOL +
            'Vertices'#9 + IntToStr(numvertices) + EOL +
            'M'#9 + IntToStr(M) + EOL +
            'N'#9 + IntToStr(N) + EOL +
            'Closed M'#9 + BoolToStr(closeM) + EOL +
            'Closed N'#9 + BoolToStr(closeN);
end;

type
  ptarray = array[0..max_vertices_per_polyline-1] of TPoint;
  pptarray = ^ptarray;

procedure Polygon_mesh_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var PointArray  : array[0..max_vertices_per_polyline-1] of TPoint;
    tp          : TPoint;
    lp1,lp2 : integer;
    t_matrix    : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  with acanvas.Pen do if Color<>colour then Color:=colour;
  for lp1:=0 to numvertices-1 do
    PointArray[lp1] := map_fn(polypoints^[lp1],t_matrix);
  // draw the M N-length polylines - we can use the array directly
  if closeN then for lp1:=0 to M-1 do acanvas.Polygon( Slice(pptarray(@PointArray[N*lp1])^,N))
  else           for lp1:=0 to M-1 do acanvas.Polyline(Slice(pptarray(@PointArray[N*lp1])^,N));
  // draw the N M-length polylines - we need to hop along the array in M steps
  for lp1:=0 to N-1 do begin
    acanvas.MoveTo(PointArray[lp1].x,PointArray[lp1].y);
    for lp2:=1 to M-1 do begin
      tp := PointArray[lp2*N+lp1];
      acanvas.LineTo(tp.x,tp.y);
    end;
    if closeM then acanvas.LineTo(PointArray[lp1].x,PointArray[lp1].y);
  end;
end;
///////////////////////////////////////////////////////////////////////////////
// Polyline_ (polyface vertex array mesh)
///////////////////////////////////////////////////////////////////////////////
constructor Polyface_mesh_.create(numpoints,nfaces:integer; points:ppointlist; faces:pfacelist; col:integer);
var lp1 : integer;
begin
{$WARNINGS OFF}
  DXF_Entity.create; // don't call polyline_constructor
  numvertices := numpoints;
  numfaces    := nfaces;
  polypoints  := allocate_points(numvertices);
  for lp1:=0 to numvertices-1 do polypoints^[lp1] := points^[lp1];
  Getmem(facelist,numfaces*SizeOf(polyface));
  for lp1:=0 to numfaces-1 do facelist^[lp1] := faces^[lp1];
  setcolour_index(col);
{$WARNINGS ON}
end;

destructor Polyface_mesh_.destroy;
begin
  Freemem(facelist,numfaces*SizeOf(polyface));
  inherited destroy;
end;

function Polyface_mesh_.proper_name : string;
begin
  result := 'POLYLINE';
end;

procedure Polyface_mesh_.write_to_DXF(var IO:textfile; layer:string);
var lp1,lp2 : integer;
begin
  writeln(IO,0 ,EOL,proper_name);
  writeln(IO,8 ,EOL,layer);
  writeln(IO,62,EOL,colinx);
  writeln(IO,66,EOL,1);
  writeln(IO,70,EOL,64);
  writeln(IO,71,EOL,numvertices);
  writeln(IO,72,EOL,numfaces);
  for lp1:=0 to numvertices-1 do begin
    writeln(IO,0  ,EOL,'VERTEX');
    writeln(IO,70 ,EOL,64+128);    // polyface mesh coordinate vertex
    write_DXF_Point(IO, 10, polypoints^[lp1]);
  end;
  for lp1:=0 to numfaces-1 do begin
    writeln(IO,0  ,EOL,'VERTEX');
    writeln(IO,70 ,EOL,128);    // polyface mesh face vertex
    for lp2:=0 to 3 do writeln(IO,71+lp2 ,EOL,facelist^[lp1].nf[lp2]+1);
  end;
  writeln(IO,0 ,EOL,'SEQEND');
end;

function Polyface_mesh_.details : string;
var t : string;
begin
  if OCS_WCS<>nil then t := 'OCS Axis ' + Point3DToStr(OCS_axis)
  else t := 'WCS';
  result := 'Polyline_ (polyface mesh)' + EOL + t + EOL +
            'Vertices'#9 + IntToStr(numvertices) + EOL +
            'Faces'#9 + IntToStr(numfaces);
end;

procedure Polyface_mesh_.Draw(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var PointArray  : array[0..3] of TPoint;
    lp1,lp2,inx : integer;
    t_matrix    : pMatrix;
begin
  t_matrix := update_transformations(OCS_WCS,OCS);
  with acanvas.Pen do if Color<>colour then Color:=colour;
  for lp1:=0 to numfaces-1 do begin
    for lp2:=0 to 3 do begin
      inx := facelist^[lp1].nf[lp2];
      if inx<0 then break; // index -> -1 = end of vertices
      PointArray[lp2] := map_fn(polypoints^[inx],t_matrix);
    end;
    acanvas.Polygon(Slice(PointArray,lp2));
  end;
end;
///////////////////////////////////////////////////////////////////////////////
// Entity_List class implementation
///////////////////////////////////////////////////////////////////////////////
constructor Entity_List.create(l_name:string);
begin
  list_name      := l_name;
  entities       := TList.Create;
  inc(Ent_lists_in_existence);
end;

destructor Entity_List.destroy;
var lp1 : integer;
begin
  for lp1:=0 to (entities.Count-1) do DXF_Entity(entities[lp1]).Free;
  entities.Free;
  dec(Ent_lists_in_existence);
  inherited destroy;
end;

function Entity_List.add_entity_to_list(entity:DXF_Entity) : boolean;
begin
  if sorted then result := insert(entity)
  else           result := add_at_end(entity);
end;

function Entity_List.remove_entity(ent:DXF_Entity) : boolean;
var lp1 : integer;
begin
  result := false;
  for lp1:=0 to (entities.Count-1) do begin
    if entities[lp1]=ent then begin
      entities.remove(ent);
      ent.free;
      result := true;
      exit;
    end;
  end;
end;

function Entity_List.add_at_end(entity:DXF_Entity) : boolean;
begin
  entities.Add(entity);
  Result:=true;
end;

function Entity_List.insert(entity:DXF_Entity) : boolean;
begin
  entities.Add(entity);
  Result:=true;
end;

procedure Entity_List.draw_primitives(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var lp1  : integer;
begin
  for lp1:=0 to (entities.Count-1) do begin
    DXF_Entity(entities[lp1]).Draw(acanvas, map_fn,OCS);
  end;
end;

procedure Entity_List.draw_vertices(acanvas:TCanvas; map_fn:coord_convert; OCS:pM);
var lp1 : integer;
begin
  for lp1:=0 to (entities.Count-1) do
    DXF_Entity(entities[lp1]).DrawVertices(acanvas, map_fn,OCS);
end;

function Entity_List.num_entities : integer;
begin
  result := entities.Count;
end;

function Entity_List.count_points : integer;
var lp1 : integer;
begin
  result := 0;
  for lp1:=0 to (entities.Count-1) do
    result := result + DXF_Entity(entities[lp1]).count_points;
end;

function Entity_List.count_lines : integer;
var lp1 : integer;
begin
  result := 0;
  for lp1:=0 to (entities.Count-1) do
    result := result + DXF_Entity(entities[lp1]).count_lines;
end;

function Entity_List.count_polys_open : integer;
var lp1 : integer;
begin
  result := 0;
  for lp1:=0 to (entities.Count-1) do
    result := result + DXF_Entity(entities[lp1]).count_polys_open;
end;

function Entity_List.count_polys_closed : integer;
var lp1 : integer;
begin
  result := 0;
  for lp1:=0 to (entities.Count-1) do
    result := result + DXF_Entity(entities[lp1]).count_polys_closed;
end;

procedure Entity_List.max_min_extents(var emax,emin:Point3D);
var lp1 : integer;
begin
  for lp1:=0 to (entities.Count-1) do
    DXF_Entity(entities[lp1]).max_min_extents(emax,emin);
end;

procedure Entity_List.setcolour(col:integer);
var lp1 : integer;
begin
  for lp1:=0 to (entities.Count-1) do
    DXF_Entity(entities[lp1]).colour := col;
end;

function Entity_List.closest_vertex_square_distance_2D(p:Point3D; var cl:DXF_Entity) : double;
var lp1 : integer;
    cl_ : DXF_Entity;
    t   : double;
begin
  result := 1E10;
  for lp1:=0 to (entities.Count-1) do begin
    cl_ := DXF_Entity(entities[lp1]);
    t   := cl_.closest_vertex_square_distance_2D(p);
    if t<result then begin
      cl := cl_;
      result := t;
    end;
  end;
end;

function Entity_List.find_bounding_object(p:Point3D) : DXF_Entity;
var lp1 : integer;
    ent : DXF_Entity;
begin
  result := nil;
  for lp1:=0 to (entities.Count-1) do begin
    ent := DXF_Entity(entities[lp1]);
    if ent.is_point_inside_object2D(p) then begin
      result := ent;
      exit;
    end;
  end;
end;
///////////////////////////////////////////////////////////////////////////////
// DXF_layer class implementation
///////////////////////////////////////////////////////////////////////////////
constructor DXF_Layer.create(l_name:string);
begin
  layer_name   := l_name;
  entity_names := TStringList.Create;
  entity_lists := TList.Create;
  inc(layers_in_existence);
end;

destructor DXF_Layer.destroy;
var lp1 : integer;
    el : Entity_List;
begin
  if num_lists>0 then for lp1:=num_lists-1 downto 0 do begin
    el := Entity_List(entity_lists[lp1]);
    el.Free;
  end;
  entity_names.Free;
  entity_lists.Free;
  dec(layers_in_existence);
  inherited destroy;
end;

procedure DXF_Layer.delete(aname:string; releasemem:boolean);
var lp1 : integer;
    el  : Entity_List;
begin
  for lp1:=num_lists-1 downto 0 do begin
    el := Entity_List(entity_lists[lp1]);
    if el.name=aname then begin
      entity_lists.remove(el);
      if releasemem then el.Free;
      entity_names.delete(lp1);
    end;
  end;
end;

function DXF_Layer.add_entity_to_layer(entity:DXF_Entity) : boolean;
var i  : integer;
    el : Entity_List;
begin
  i := entity_names.IndexOf(entity.ClassName);
  if i=-1 then begin
    el := Entity_List.create(entity.ClassName);
    el.parent_layer := self;
    i  := entity_lists.Add(el);
    if i<>entity_names.Add(entity.ClassName) then
      raise Exception.Create('Entity list ID mismatch');
    // This has never been raised yet, but might as well be sure.
  end;
  Entity_List(entity_lists[i]).add_entity_to_list(entity);
  if ((entity.colour=0) or (entity.colour=BYLAYER)) then
    entity.setcolour_index(layer_colinx);
  result := true;
end;

procedure DXF_Layer.add_entity_list(elist:Entity_List);
var i : integer;
begin
  i := entity_names.IndexOf(elist.name);
  if i<>-1 then raise Exception.create('Attempted to add two lists with same name');
  elist.parent_layer := self;
  i  := entity_lists.Add(elist);
  if i<>entity_names.Add(elist.Name) then
    raise Exception.Create('Entity list ID mismatch');
end;

function DXF_Layer.num_lists : integer;
begin
  result := entity_names.Count;
end;

procedure DXF_Layer.max_min_extents(var emax,emin:Point3D);
var lp1 : integer;
begin
  for lp1:=0 to num_lists-1 do Entity_List(entity_lists[lp1]).max_min_extents(emax,emin);
end;

function DXF_Layer.create_or_find_list_type(aname:string) : Entity_List;
var inx : integer;
begin
  inx := entity_names.IndexOf(aname);
  if inx=-1 then begin
    result := Entity_List.create(aname);
    result.parent_layer := self;
    inx    := entity_lists.Add(result);
    if inx<>entity_names.Add(aname) then
      raise Exception.Create('Entity list ID mismatch');
  end
  else result := Entity_List(entity_lists[inx]);
end;
///////////////////////////////////////////////////////////////////////////////
// DXF_Object class implementation
///////////////////////////////////////////////////////////////////////////////
constructor DXF_Object.create(aname:string);
begin
  layer_lists := TList.create;
  if aname<>'' then DXF_name := aname
  else DXF_name := 'Untitled';
  emax        := origin3D;
  emin        := origin3D;
  inc(DXF_Obj_in_existence);
end;

constructor DXF_Object.create_from_file(aname:string; skipped:Tstrings);
var reader : DXF_Reader;
begin
  Reader:=DXF_Reader.Create(aname);
  Reader.set_skipped_list(skipped);
  With Reader do if (read_file) then begin
    name := ExtractFileName(aname);
    emax := get_max_extent;
    emin := get_min_extent;
    layer_lists := release_control_of_layers;
  end
  else begin
    layer_lists := TList.create;
    DXF_name    := aname;
    emax        := origin3D;
    emin        := origin3D;
  end;                  
  Reader.Free;
  inc(DXF_Obj_in_existence);
end;

destructor DXF_Object.destroy;
var lp1 : integer;
begin
  for lp1:=0 to layer_lists.Count-1 do
    DXF_Layer(layer_lists.Items[lp1]).Free;
  layer_lists.Free;
  dec(DXF_Obj_in_existence);
  inherited destroy;
end;

procedure DXF_Object.save_to_file(aname:string);
var Writer : DXF_Writer;
begin
  writer := DXF_writer.create(aname,layer_lists);
  writer.write_file;
  writer.free;
end;

function DXF_Object.num_layers : integer;
begin
  result := layer_lists.Count
end;

function DXF_Object.new_layer(aname:string; DUPs_OK:boolean) : DXF_Layer;
var lp1 : integer;
begin
  for lp1:=0 to layer_lists.Count-1 do begin
    if DXF_Layer(layer_lists[lp1]).name=aname then begin
      if not DUPs_OK then raise DXF_Exception.Create('Attempted to create layer with existing name');
      result := DXF_Layer(layer_lists[lp1]);
      exit;
    end;
  end;
  result := DXF_Layer.Create(aname);
  layer_lists.Add(result);
end;

function DXF_Object.add_layer(layer:DXF_Layer) : boolean;
var lp1  : integer;
begin
  for lp1:=0 to layer_lists.Count-1 do
    if DXF_Layer(layer_lists[lp1]).name=layer.name then
      raise DXF_Exception.Create('Attempted to add layer with existing name');
  layer_lists.Add(layer);
  Result:=true;
end;

function DXF_Object.layer(aname:string) : DXF_Layer;
var lp1 : integer;
begin
  result := nil;
  for lp1:=0 to layer_lists.Count-1 do
    if DXF_Layer(layer_lists[lp1]).name=aname then begin
      result := DXF_Layer(layer_lists[lp1]);
      exit;
    end;
end;

// Avoid using this if possible because we have to search for layer name every time
function DXF_Object.add_entity_to_layer(entity:DXF_Entity; aname:string) : boolean;
var lp1 : integer;
begin
  for lp1:=0 to layer_lists.Count-1 do
    if DXF_Layer(layer_lists[lp1]).name=aname then begin
      DXF_Layer(layer_lists[lp1]).add_entity_to_layer(entity);
      result := true;
      exit;
    end;
  raise DXF_Exception.Create('Attempted to add to unnamed layer');
end;

function DXF_Object.create_or_find_layer(aname:string) : DXF_Layer;
var lp1  : integer;
begin
  for lp1:=0 to layer_lists.Count-1 do
    if DXF_Layer(layer_lists[lp1]).name=aname then begin
      result := DXF_Layer(layer_lists[lp1]);
      exit;
    end;
  result := new_layer(aname, true);
end;

function DXF_Object.merge_files(DXF_:DXF_Object) : boolean;
var lp1,lp2,lp3     : integer;
    layer1,layer2       : DXF_Layer;
    elist1,elist2,blist : Entity_List;
    ent                 : DXF_Entity;
begin
  // rather annoyingly we have to keep track of insert/block lookups
  layer2 := create_or_find_layer('0');
  blist  := layer2.create_or_find_list_type('Block_');
  //
  for lp1:=0 to DXF_.layer_lists.Count-1 do begin
    layer1 := DXF_.layer_lists[lp1];
    layer2 := create_or_find_layer(layer1.name);
    for lp2:=0 to layer1.entity_lists.count-1 do begin
      elist1 := layer1.entity_lists[lp2];
      elist2 := layer2.create_or_find_list_type(elist1.name);
      for lp3:=elist1.entities.count-1 downto 0 do begin
        ent := elist1.entities[lp3];
        elist2.Add_entity_to_list(ent);
        elist1.entities.remove(ent);
        if ent is Insert_ then ent.update_block_links(blist);
      end;
    end;
  end;
  Result:=true;
end;

procedure DXF_Object.remove_empty_layers_and_lists;
var lp1,lp2 : integer;
    layer   : DXF_Layer;
    el      : Entity_List;
begin
  for lp1:=layer_lists.Count-1 downto 0 do begin
    layer := DXF_Layer(layer_lists[lp1]);
    for lp2:=layer.num_lists-1 downto 0 do begin
      el := Entity_List(layer.entity_lists[lp2]);
      if el.num_entities=0 then begin
        layer.entity_lists.remove(el);
        layer.entity_names.delete(lp2);
        el.Free;
        if layer.entity_lists.count<>layer.entity_names.count then
          showmessage('Internal error : Layer lists and names mismatch'); 
      end;
    end;
    if layer.num_lists=0 then begin
      layer_lists.remove(layer);
      layer.Free;
    end;
  end;
end;

procedure DXF_Object.copy_to_strings(ts:TStrings);
var lp1,lp2,pos : integer;
    layer       : DXF_Layer;
begin
  ts.Add(DXF_name);
  for lp1:=0 to layer_lists.count-1 do begin
    layer := layer_lists[lp1];
    pos := ts.Add('  '+layer.name);
    ts.Objects[pos] := layer;
    for lp2:=0 to layer.num_lists-1 do begin
      pos := ts.Add('    '+Entity_List(layer.entity_lists[lp2]).name);
      ts.Objects[pos] := layer.entity_lists[lp2];
    end;
  end;
end;

function DXF_Object.get_min_extent : Point3D;
begin
  result := emin;
end;

function DXF_Object.get_max_extent : Point3D;
begin
  result := emax;
end;

procedure DXF_Object.max_min_extents(var emax,emin:Point3D);
var lp1 : integer;
begin
  for lp1:=0 to layer_lists.Count-1 do
    DXF_Layer(layer_lists[lp1]).max_min_extents(emax,emin);
end;
///////////////////////////////////////////////////////////////////////////////
// Selection_lists class implementation
///////////////////////////////////////////////////////////////////////////////
constructor selection_lists.create;
begin
  entity_lists := TList.Create;;
end;

destructor selection_lists.destroy;
begin
  entity_lists.Free;
  inherited destroy;
end;

procedure selection_lists.save_to_DXF_file(aname:string);
var lp1,lp2 : integer;
    DXF     : DXF_Object;
    layer   : DXF_layer;
    el      : Entity_List;
begin
  DXF := DXF_Object.create('');
  for lp1:=0 to entity_lists.count-1 do begin
    el := Entity_List(entity_lists[lp1]);
    el.Kludge_layer := el.parent_layer; // we need to keep track of where they came from
    layer := DXF.new_layer(el.parent_layer.name,true);
    layer.add_entity_list(el);
  end;
  DXF.save_to_file(aname);
  // now get the lists back from the temporary DXF object (without it deleting them)
  for lp1:=DXF.layer_lists.count-1 downto 0 do begin
    layer := DXF_Layer(DXF.layer_lists[lp1]);
    for lp2:=layer.entity_lists.count-1 downto 0 do
      layer.delete(Entity_List(layer.entity_lists[lp2]).name,FALSE);
  end;
  DXF.Free;
  // reset the parent layer of the entity_lists
  for lp1:=0 to entity_lists.count-1 do begin
    el := Entity_List(entity_lists[lp1]);
    el.parent_layer := el.Kludge_layer; // we stored them temporarily
  end;
end;

function selection_lists.find_closest_2D_point(p:Point3D; var ent:DXF_Entity) : Point3D;
var lp1       : integer;
    dist,mind : double;
    entx      : DXF_Entity;
begin
  mind := 1E10;
  for lp1:=0 to entity_lists.count-1 do begin
    dist := Entity_List(entity_lists[lp1]).closest_vertex_square_distance_2D(p,entx);
    if dist<mind then begin
      result := entx.closest_vertex(p);
      ent    := entx;
      mind   := dist;
    end;
  end;
end;

function selection_lists.is_inside_object(p:Point3D; var ent:DXF_Entity) : Point3D;
var lp1       : integer;
    entx      : DXF_Entity;
begin
  result := origin3D;
  for lp1:=0 to entity_lists.count-1 do begin
    entx := Entity_List(entity_lists[lp1]).find_bounding_object(p);
    if entx<>nil then begin
      result := entx.closest_vertex(p);
      ent    := entx;
      exit;
    end;
  end;
end;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// initialization
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
{$WARNINGS ON}
initialization
  entities_in_existence  := 0;
  Ent_lists_in_existence := 0;
  layers_in_existence    := 0;
  DXF_Obj_in_existence   := 0;
end.

