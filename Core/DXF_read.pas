{$WARNINGS OFF}
///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//                         DXF File reader object/code                       //
//                             ©John Biddiscombe                             //
//                      Rutherford Appleton Laboratory, UK                   //
//                           j.biddiscombe@rl.ac.uk                          //
//                       DXF code release 3.0 - July 1997                    //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
//                                                                           //
// Thanks very much to John F Herbster for the original DXF reader class     //
// that got this started --- extract from his header follows...              //
//                                                                           //
// Pgm. 07/14/95 by John F Herbster, CIS:72714,3445, Houston, TX.            //
// for Rick Rogers (CIS:74323,3573).                                         //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

unit DXF_read;

interface

uses
  { Borland }
  Windows,SysUtils,StdCtrls,ComCtrls,Dialogs,Classes,Graphics,
  { Mine }
  DXF_structs,DXF_Utils,Thinkbox,Math;

const
  message_delay_ms = 1500;
  EOL = #13#10;

// Thanks to Ian L. Kaplan, whose code contained these ID's
// I've changed a few names here and there
const
  DXF_start            = 0;
  DXF_text_def         = 1;
  DXF_name             = 2;
  DXF_text_prompt      = 3;
  DXF_othername2       = 4;
  DXF_entity_handle    = 5;
  DXF_line_type        = 6;
  DXF_text_style       = 7;
  DXF_layer_name       = 8;
  DXF_var_name         = 9;
  DXF_primary_X        = 10;  DXF_primary_Y     = 20;
  DXF_primary_Z        = 30;
  DXF_other_X_1        = 11;  DXF_other_Y_1     = 21;
  DXF_other_Z_1        = 31;
  DXF_other_X_2        = 12;  DXF_other_Y_2     = 22;
  DXF_other_Z_2        = 32;
  DXF_other_X_3        = 13;  DXF_other_Y_3     = 23;
  DXF_other_Z_3        = 33;
  DXF_elevation        = 38;
  DXF_thickness        = 39;
  DXF_floatval         = 40;
  DXF_floatvals1       = 41;
  DXF_floatvals2       = 42;
  DXF_floatvals3       = 43;
  DXF_repeat           = 49;
  DXF_angle1           = 50;  DXF_angle2        = 51;
  DXF_angle3           = 52;  DXF_angle4        = 53;
  DXF_angle5           = 54;  DXF_angle6        = 55;
  DXF_angle7           = 56;  DXF_angle8        = 57;
  DXF_angle9           = 58;
  DXF_visible          = 60;
  DXF_colornum         = 62;
  DXF_entities_flg     = 66;
  DXF_ent_ident        = 67;
  DXF_view_state       = 69;
  DXF_70Flag           = 70;
  DXF_71Flag           = 71;  DXF_72Flag        = 72;
  DXF_73Flag           = 73;  DXF_74Flag        = 74;
  DXF_extrusionx       = 210;
  DXF_extrusiony       = 220;
  DXF_extrusionz       = 230;
  DXF_comment          = 999;

///////////////////////////////////////////////////////////////////////////////
// DXF_Reader class definition
///////////////////////////////////////////////////////////////////////////////
Const
  MaxSizeOfBuf = 4096;

type
  tCharArray = array [0..MaxSizeOfBuf-1] of char;

type
  abstract_entity = class;

  DXF_Reader = class
  private
    // used when reading data from the file
    IO_chan     : file;
    SizeOfBuf   : integer;
    num_in_buf  : integer;
    ii          : integer;
    EC,fCode    : integer;
    pBuf        : ^tCharArray;
    Line_num    : longint;
    fLine       : shortstring;
    progress    : TProgressBar;
    // useful bits to make parsing easier...
    file_pos   : integer;
    marked_pos : integer;
    backflag   : boolean;
    procedure   go_back_to_last(code:integer; str:shortstring);
    procedure   mark_position;
    procedure   goto_marked_position;
    //
//    procedure   go_back_to_start;
    function    NextGroupCode: integer;
    function    ValStr: shortstring;
    function    ValDbl: double;
    function    ValInt: integer;
    function    code_and_string(var group:integer; var s:string) : boolean;
    function    code_and_double(var group:integer; var d:double) : boolean;
    function    read_2Dpoint(var p1:Point3D)                     : boolean;
    function    skip_upto_section(name:string)                   : boolean;
                // lowest level read function
    function    read_entity_data(ent:abstract_entity)            : boolean;
    function    read_generic(var layer:integer)                  : abstract_entity;
                // we can read most entities with this one
    function    general_purpose_read(obj_type:TClass; var entity:DXF_Entity; var layer:integer) : boolean;
                // inserts/polylines need a little more complexity
    function    read_insert(var entity:DXF_Entity; var layer:integer)   : boolean;
    function    read_polyline(var entity:DXF_Entity; var layer:integer) : boolean;
                // this calls the others above
    function    read_entity(s,endstr:string; var entity:DXF_Entity; var layer:integer) : boolean;
  public
    // Extents in (x,y) of the dataset
    min_extents    : Point3D;
    max_extents    : Point3D;
    // We will read the Entities in the layers into this list
    DXF_Layers     : TList;
    colour_BYLAYER : boolean;
    skipped        : TStrings;
    // Constructors and destructors
    Constructor Create (const aName: shortstring);
    Destructor  Destroy;                           override;
    // Header section
    function    move_to_header_section : boolean;
    function    read_header            : boolean;
    function    get_min_extent         : Point3D;
    function    get_max_extent         : Point3D;
    // Blocks section
    function    move_to_blocks_section : boolean;
    function    read_blocks            : boolean;
    function    read_block             : boolean;
    function    block_list             : Entity_List;
    // Tables section
    function    move_to_tables_section : boolean;
    function    read_tables : boolean;
    function    read_layer_information : boolean;
    function    read_vport_information : boolean;
    function    layer_num(layername:string) : integer;
    // Entities section
    function    move_to_entity_section : boolean;
    function    read_entities          : boolean;
    // These are the main routines to use
    function    read_file                 : boolean;
    function    remove_empty_layers       : boolean;
    function    release_control_of_layers : TList;
    procedure   set_skipped_list(s:TStrings);
  end;

///////////////////////////////////////////////////////////////////////////////
// This is a simple class used only during file reads, it should not be used
// as a base for any objects.
// It is to allow all entities to be read using the same basic structure
// even though they all use different group codes
// Add extra group codes if you need to recognize them
///////////////////////////////////////////////////////////////////////////////
  abstract_entity = class
    p1,p2,p3,p4                             : Point3D;
    rad_hgt                                 : double;
    angle1,angle2                           : double;
    fv1,fv2,fv3                             : double;
    thickness                               : double;
    colour                                  : integer;
    flag_70,flag_71,flag_72,flag_73,flag_74 : integer;
    attflag                                 : integer;
    namestr,tagstr,promptstr                : string;
    layer                                   : string;
    elev                                    : double;
    OCS_Z                                   : Point3D;
    procedure clear;
  end;
///////////////////////////////////////////////////////////////////////////////
// DXF file read exceptions will be this type
///////////////////////////////////////////////////////////////////////////////
type
  DXF_read_exception = class(Exception)
    line_number : integer;
    constructor create(err_msg:string; line:integer);
  end;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// implementation
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
implementation

///////////////////////////////////////////////////////////////////////////////
// abstract_entity implementation
// used when reading vertexes - just to make sure all flags are reset
// quicker than using create/destroy for each vertex.
///////////////////////////////////////////////////////////////////////////////
procedure abstract_entity.clear;
begin
  InitInstance(self);
end;
///////////////////////////////////////////////////////////////////////////////
// DXFReader implementation
///////////////////////////////////////////////////////////////////////////////
Constructor DXF_Reader.Create (const aName: shortstring);
begin
  Inherited Create;
  AssignFile(IO_chan,aName);
  Reset(IO_chan,1);
  SizeOfBuf         := MaxSizeOfBuf;
  GetMem(pBuf,SizeOfBuf);
  DXF_Layers        := TList.Create;
  colour_BYLAYER    := false;
  Line_num          := 0;
  backflag          := false;
  progress          := Thinking_box.bar;
  progress.position := 0;
  progress.max      := FileSize(IO_chan) div MaxSizeOfBuf;
  min_extents       := origin3D;
  max_extents       := origin3D;
end;

destructor DXF_Reader.Destroy;
var lp1 : integer;
begin
  if (DXF_Layers<>nil) then
    for lp1 := 0 to DXF_Layers.count-1 do DXF_Layer(DXF_Layers[lp1]).Free;
  DXF_Layers.Free;
  CloseFile(IO_chan);
  FreeMem(pBuf,SizeOfBuf);
  Inherited Destroy;
end;
{ --------------------------------------------------------------------------- }
{ Routines for fetching codes and values
{ --------------------------------------------------------------------------- }
{
procedure DXF_Reader.go_back_to_start;
begin
  Reset(IO_chan,1);
  num_in_buf := 0;
  ii         := 0;
end;
}

procedure DXF_Reader.go_back_to_last(code:integer; str:shortstring);
begin
  fCode    := code;
  fLine    := str;
  backflag := true;
end;

procedure DXF_Reader.mark_position;
begin
  marked_pos := File_pos + ii;
end;

procedure DXF_Reader.goto_marked_position;
begin
  Seek(IO_chan,marked_pos);
  File_pos := marked_pos;
  num_in_buf := 0;
  ii         := 0;
end;

function DXF_Reader.NextGroupCode: integer;
  function GotMore: boolean;
  begin
    file_pos := FilePos(IO_chan);
    BlockRead(IO_chan,pBuf^,SizeOfBuf,num_in_buf); ec:=IoResult; ii:=0;
    If (ec=0) and (num_in_buf=0) then ec:=-1; GotMore:=(ec=0);
    progress.position := progress.position+1;
  end{GotMore};

  // Sometimes you get (download) a bad DXF file which has a couple of blank
  // lines in it. The commented retry code, can be used to skip blank lines, but you
  // should only use it as an emergency fix because you'll often find blank lines
  // in TEXT entities and other text strings.
  function GotLine: boolean;
  const CR=#13; LF=#10;
  var c: char;
//  label retry;
  begin
//  retry:
    byte(fLine[0]):=0;
    While (ii<num_in_buf) or GotMore do begin
      c:=pBuf^[ii]; inc(ii);
      If (c<>CR) and (c<>LF) and (length(fLine)<255) then begin
        inc(fLine[0]); fLine[length(fLine)]:=c
      end
      else begin      // Extra code added to handle C/Unix style LF not CR/LF
        if (c=CR) then begin
          if (ii<num_in_buf) or GotMore then begin
            if pBuf^[ii]=LF then begin inc(ii); break; end;
          end;
        end else if (c=LF) then break;
      end;
    end;
    GotLine:=(ec=0) and ((c=CR) or (c=LF));
    inc(Line_num);
//    if fLine='' then goto retry;
  end;

begin {NextGroupCode}
  if backflag then begin
    result   := fCode;
    backflag := false;
  end
  else begin
    repeat
      if not GotLine then begin
        fCode:=-2;
        Result:=fCode;
        exit;
      end;
    until fLine<>'';
    Val(fLine,fCode,ec);
    If ec<>0 then fCode:=-2
    else if not GotLine then fCode:=-2;
    Result:=fCode;
  end;
end {NextGroupCode};

function DXF_Reader.ValStr: shortstring;
begin Result:=fLine end;

function DXF_Reader.ValDbl: double;
begin
  Val(fLine,Result,ec);
  If ec<>0 then raise DXF_read_exception.Create('Invalid Floating point conversion',line_num);
end;

function DXF_Reader.ValInt: integer;
begin
  Val(fLine,Result,ec);
  If ec<>0 then raise DXF_read_exception.Create('Invalid Integer conversion',line_num);
end;

function DXF_Reader.code_and_string(var group:integer; var s:string) : boolean;
//var astr : string;
begin
  result := true;
  group  := NextGroupCode;
  if group>=0 then s := ValStr
  else result := false;
  // useful in debugging
  //  if (group=0) then begin astr := IntToStr(group)+' '+s; alb.Items.Add(astr); end;
end;

function DXF_Reader.code_and_double(var group:integer; var d:double) : boolean;
begin
  result := true;
  group  := NextGroupCode;
  if group>=0 then d := Valdbl
  else result := false;
end;

// This routine is just for the $EXT(max/min) and should be used with care....
function DXF_Reader.read_2Dpoint(var p1:Point3D) : boolean;
var Groupcode : integer;
begin
  repeat Groupcode:=NextGroupCode;
  until (Groupcode=DXF_primary_X) or (Groupcode<0);
  if Groupcode<0 then begin result:=false; exit; end;
  p1.x := Valdbl;
  result := code_and_double(Groupcode,p1.y);  { y next              }
end;

function DXF_Reader.skip_upto_section(name:string) : boolean;
var Group   : integer;
    s       : string;
begin
  result := false;
  repeat
    if not code_and_string(Group,s) then break;
    if (Group=0) then begin
      if (s='SECTION') then begin
        if not code_and_string(Group,s) then break;
        if (Group=DXF_name) then begin
          if (s=name) then result := true
          else exit;
        end
        else if skipped<>nil then Skipped.Add(s);
      end else if skipped<>nil then Skipped.Add(s);
    end;
  until (result);
end;
{ --------------------------------------------------------------------------- }
{ Header section
{ --------------------------------------------------------------------------- }
function DXF_Reader.move_to_header_section : boolean;
begin
  result := skip_upto_section('HEADER');
end;

function DXF_Reader.read_header : boolean;
var Group : integer;
    s     : string;
begin
  result := false;
  repeat
    if not code_and_string(Group,s) then break;
    if (group=9) and (s='$EXTMAX') then begin
      if not read_2Dpoint(max_extents) then break;
    end;
    if (group=9) and (s='$EXTMIN') then begin
      if not read_2Dpoint(min_extents) then break;
    end;
    if (group=9) and (s='$CECOLOR') then begin
      if (NextGroupCode=DXF_colornum) and (ValInt=256) then colour_BYLAYER := true;
    end;
    result := (Group=0) and (s='ENDSEC');
  until result;
end;

function DXF_Reader.get_min_extent : Point3D;
begin
  result := min_extents;
end;

function DXF_Reader.get_max_extent : Point3D;
begin
  result := max_extents;
end;
{ --------------------------------------------------------------------------- }
{ Blocks section
{ --------------------------------------------------------------------------- }
function DXF_Reader.move_to_blocks_section : boolean;
begin
  result := skip_upto_section('BLOCKS');
end;

function DXF_Reader.read_blocks : boolean;
var Group : integer;
    s     : string;
begin
  result := false;
  repeat
    if not code_and_string(Group,s) then break;
    if (Group=0) and (s='BLOCK') then begin
      if not read_block then break;
    end;
    result := (Group=0) and (s='ENDSEC');
  until result;
end;

function DXF_Reader.read_block : boolean;
var Groupcode  : integer;
    s          : string;
    ent        : abstract_entity;
    block      : Block_;
    layer  : integer;
    entity     : DXF_Entity;
begin
  result := false;
  ent := read_generic(layer);
  layer := layer_num('0'); // ALL BLOCKS GOING TO LAYER 0 (makes things easier)
  if layer<0 then layer := DXF_Layers.Add(DXF_Layer.create('0'));
  if ent<>nil then begin
    block := Block_.create(ent.namestr,ent.p1);
    DXF_Layer(DXF_Layers[layer]).add_entity_to_layer(block);
    repeat
      if not code_and_string(Groupcode,s) then break;
      if (Groupcode=0) then begin
        result := read_entity(s,'ENDBLK',entity,layer);
        if entity<>nil then block.entities.Add(entity);
      end;
    until result;
  end;
end;

// we need to know where the blocks are stored for lookup purposes
function DXF_Reader.block_list : Entity_List;
var lp1,lp2 : integer;
    layer   : DXF_Layer;
begin
  for lp1:=0 to DXF_Layers.count -1 do begin
    layer := DXF_Layers[lp1];
    for lp2:=0 to layer.entity_lists.count-1 do begin
      if Entity_List(layer.entity_lists[lp2]).name='Block_' then begin
        result := Entity_List(layer.entity_lists[lp2]);
        exit;
      end;
    end;
  end;
end;
{ --------------------------------------------------------------------------- }
{ Tables (Layers - VPort) section
{ --------------------------------------------------------------------------- }
function DXF_Reader.move_to_tables_section : boolean;
begin
  result := skip_upto_section('TABLES');
end;

function DXF_Reader.read_tables : boolean;
var Group : integer;
    s     : string;
begin
  result := false;
  repeat
    if not code_and_string(Group,s) then break;
    if (Group=0) and (s='TABLE') then begin
      if not code_and_string(Group,s) then break;
      if (Group=DXF_name) then begin
        if (s='LAYER') then read_layer_information
        else if (s='VPORT') then read_vport_information
        else if skipped<>nil then Skipped.Add(s);
      end;
    end;
    result := (Group=0) and (s='ENDSEC');
  until result;
end;

function DXF_Reader.read_layer_information : boolean;
var Group,Lay_num : integer;
    s             : string;
begin
  lay_num := -1;
  result  := false;
  repeat
    if not code_and_string(Group,s) then break;
    if (Group=0) then begin
      if (s='LAYER') then begin
        if not code_and_string(Group,s) then break;
        if (Group=DXF_name) then lay_num := DXF_Layers.Add(DXF_Layer.create(s));
      end
      else if (s='ENDTAB') then result := true
      else if skipped<>nil then Skipped.Add(s);
    end
    else if (Group=DXF_colornum) and (lay_num<>-1) then
      DXF_Layer(DXF_Layers[lay_num]).Colour := ValInt;
  until result;
end;

// This no longer does anything !
function DXF_Reader.read_vport_information : boolean;
var Group : integer;
    s     : string;
begin
  result := false;
  repeat
    if not code_and_string(Group,s) then break;
    if (Group=0) then begin
      if (s='VPORT') then begin
        if not code_and_string(Group,s) then break;
        if (Group=DXF_name) then begin
          if (s='*ACTIVE') then repeat
            if not code_and_string(Group,s) then break;
{ removed Aspectratio stuff since it never seems to make any difference
  and sometimes buggers everything up
            if (Group=DXF_floatvals1) then Aspect := ValDbl;
}
            result := (Group=0) and (s='ENDTAB');
          until (result)
          else if skipped<>nil then Skipped.Add(s);
        end;
      end
      else if skipped<>nil then Skipped.Add(s);
    end
  until (result);
end;

function DXF_Reader.layer_num(layername:string) : integer;
var lp1 : integer;
begin
  result := -1;
  for lp1:=0 to DXF_Layers.count-1 do begin
    if DXF_Layer(DXF_Layers[lp1]).name=layername then begin
      result := lp1;
      exit;
    end;
  end;
end;
{ --------------------------------------------------------------------------- }
{ Entities section
{ --------------------------------------------------------------------------- }
function DXF_Reader.move_to_entity_section : boolean;
begin
  result := skip_upto_section('ENTITIES');
end;

function DXF_Reader.read_entities : boolean;
var Groupcode,layer : integer;
    s               : string;
    entity          : DXF_Entity;
begin
  result := false;
  repeat
    try
      if not code_and_string(Groupcode,s) then break;
      if (Groupcode=0) then begin
        result := read_entity(s,'ENDSEC',entity,layer);
        // put the entity in the layer...
        if entity<>nil then DXF_Layer(DXF_Layers[layer]).add_entity_to_layer(entity);
      end;
    except
      on E:DXF_read_exception do begin
        stopped_thinking;
        if MessageBox(0,@E.message[1],'DXF read error warning',MB_OKCANCEL)=IDCANCEL then
          raise DXF_read_exception.Create('User aborted',-1);
        thinking_bar(nil,'Reading DXF file...');
      end;
      on E:Exception do Showmessage(E.Message);
    end;
  until result;
end;
{ --------------------------------------------------------------------------- }
{ Entity reading code
{ --------------------------------------------------------------------------- }
function DXF_Reader.read_entity_data(ent:abstract_entity) : boolean;
var Groupcode : integer;
begin
  ent.OCS_Z := WCS_Z;
  repeat
    Groupcode := NextGroupCode;
    case Groupcode of
      DXF_primary_X    : ent.p1.x      := Valdbl;
      DXF_primary_Y    : ent.p1.y      := Valdbl;
      DXF_primary_Z    : ent.p1.z      := Valdbl;
      DXF_other_X_1    : ent.p2.x      := Valdbl;
      DXF_other_Y_1    : ent.p2.y      := Valdbl;
      DXF_other_Z_1    : ent.p2.z      := Valdbl;
      DXF_other_X_2    : ent.p3.x      := Valdbl;
      DXF_other_Y_2    : ent.p3.y      := Valdbl;
      DXF_other_Z_2    : ent.p3.z      := Valdbl;
      DXF_other_X_3    : ent.p4.x      := Valdbl;
      DXF_other_Y_3    : ent.p4.y      := Valdbl;
      DXF_other_Z_3    : ent.p4.z      := Valdbl;
      DXF_floatval     : ent.rad_hgt   := Valdbl;
      DXF_floatvals1   : ent.fv1       := Valdbl;
      DXF_floatvals2   : ent.fv2       := Valdbl;
      DXF_floatvals3   : ent.fv3       := Valdbl;
      DXF_angle1       : ent.angle1    := Valdbl;
      DXF_angle2       : ent.angle2    := Valdbl;
      DXF_thickness    : ent.thickness := Valdbl;
      DXF_elevation    : ent.elev      := Valdbl;
      DXF_70Flag       : ent.flag_70   := ValInt;
      DXF_71Flag       : ent.flag_71   := ValInt;
      DXF_72Flag       : ent.flag_72   := ValInt;
      DXF_73Flag       : ent.flag_73   := ValInt;
      DXF_74Flag       : ent.flag_74   := ValInt;
      DXF_colornum     : ent.colour    := ValInt;
      DXF_entities_flg : ent.attflag   := ValInt;
      DXF_layer_name   : ent.layer     := ValStr;
      DXF_name         : ent.namestr   := ValStr;
      DXF_text_def     : ent.tagstr    := ValStr;
      DXF_text_prompt  : ent.promptstr := ValStr;
      DXF_extrusionx   : ent.OCS_Z.x   := Valdbl;
      DXF_extrusiony   : ent.OCS_Z.y   := Valdbl;
      DXF_extrusionz   : ent.OCS_Z.z   := Valdbl;
    end;
  until (Groupcode<=0); // end or fault;
  if Groupcode<0 then begin result:=false; exit; end;
  // we need to put the code=0, and valstr back, so the next entity starts
  // with the zero when neccessary
  go_back_to_last(Groupcode,fline);
  ent.OCS_Z := normalize(ent.OCS_Z); // for safety
  result := true;
end;

function DXF_Reader.read_generic(var layer:integer) : abstract_entity;
var ent : abstract_entity;
//    s   : string;
begin
  result := nil;
  ent    := abstract_entity.create; // set everything to zero EVERY time
  if read_entity_data(ent) then begin
    layer := layer_num(ent.layer);
    if layer<0 then layer := DXF_Layers.Add(DXF_Layer.create(ent.layer));
    result := ent;
  end else ent.free;
end;

{ These ones are straightforward, so we'll use a crafty TClass parameter }
function DXF_Reader.general_purpose_read(obj_type:TClass; var entity:DXF_Entity; var layer:integer) : boolean;
var ent   : abstract_entity;
begin
  entity := nil;
  ent := read_generic(layer);
  if ent<>nil then begin
    with ent do begin
      if      obj_type = Point_  then entity := Point_. create(OCS_Z,p1,colour)
      else if obj_type = Text_   then entity := Text_.  create(OCS_Z,p1,p2,tagstr,rad_hgt,colour,flag_72)
      else if obj_type = Line_   then entity := Line_.  create(p1,p2,colour)
      else if obj_type = Circle_ then entity := Circle_.create(OCS_Z,p1,rad_hgt,colour)
      else if obj_type = Arc_    then entity := Arc_.   create(OCS_Z,p1,rad_hgt,angle1,angle2,colour)
      // face3ds and solids can have 3 or 4 points, if 4=3, then 3 used
      else if obj_type = Face3D_ then begin
        if p1_eq_p2_3d(p3,p4) then entity := Face3D_.create(3, @p1, colour,true)
        else                       entity := Face3D_.create(4, @p1, colour,true)
      end
      else if obj_type = Solid_ then begin
        if p1_eq_p2_3d(p3,p4) then entity := Solid_.create(OCS_Z,3, @p1, colour,thickness)
        else                       entity := Solid_.create(OCS_Z,4, @p1, colour,thickness)
      end
      else if obj_type = Attdef_  then entity := Attdef_.create(OCS_Z,p1,p2,namestr,tagstr,promptstr,flag_70,flag_72,rad_hgt,colour)
      else if obj_type = Attrib_  then entity := Attrib_.create(OCS_Z,p1,p2,namestr,tagstr,flag_70,flag_72,rad_hgt,colour);
    end;
    ent.Free;
    result := true;
  end;
end;

{ INSERTs may have ATTRIBs + BLOCKs which makes it a little more complicated }
function DXF_Reader.read_insert(var entity:DXF_Entity; var layer:integer) : boolean;
var ent,ent2 : abstract_entity;
    num : integer;
    atts     : array[0..255] of Attrib_;
begin
  result := true;
  entity := nil;
  num := 0;
  ent := read_generic(layer);
  if ent<>nil then begin
    if ent.attflag=1 then begin
      repeat
        result := (Nextgroupcode=0);
        if result and (ValStr='ATTRIB') then begin
          ent2 := read_generic(layer);
          if ent2<>nil then with ent2 do begin
            atts[num] := Attrib_.create(OCS_Z,p1,p2,namestr,tagstr,flag_70,flag_72,rad_hgt,colour);
            ent2.Free;
            inc(num);
          end else result := false;
        end;
      until (not result) or (ValStr='SEQEND');
      if result then Nextgroupcode; // remove the SEQEND put back
    end;
    with ent do begin
      if fv1=0 then fv1 := 1;
      if fv2=0 then fv2 := 1;
      if fv3=0 then fv3 := 1;
      entity := Insert_.create(OCS_Z,p1,aPoint3D(fv1,fv2,fv3),angle1,colour,num,@atts[0],namestr);
      try
        Insert_(entity).update_block_links(block_list);
      except
        entity.Free;
        entity := nil;
        raise DXF_read_exception.Create('Cannot reference an undefined BLOCK'+EOL+EOL+
        '(File may not have been saved with BLOCKs)'+EOL,line_num);
      end;
    end;
    ent.Free;
  end
  else result := false;
end;

// POLYLINEs have variable number of points...
// Modified to accept polyface mesh variety of polyline ...
//   I've ignored the invisible flag for edges
// Modified to accept polygon MxN grid mesh ...
// It's a bit messy - you could simplify it a bit - but hey - what do you
// expect from free code.
function DXF_Reader.read_polyline(var entity:DXF_Entity; var layer:integer) : boolean;
var ent1,ent2    : abstract_entity;
    vertices : integer;
    faces        : integer;
    tempvert     : array[0..max_vertices_per_polyline-1] of Point3D;
    tempface     : array[0..4095] of polyface;
    closed_poly  : boolean;
    M,N,mn       : integer;
label vertex_overflow;
begin
  result := false; closed_poly := false; entity := nil;
  ent1   := abstract_entity.create;
  // read initial polyline data
  if not read_entity_data(ent1) then begin ent1.Free; exit; end;
  layer    := layer_num(ent1.layer);
  if (layer=-1) then layer := DXF_Layers.Add(DXF_Layer.create(ent1.layer));
  vertices := 0; faces := 0;
  ent2     := abstract_entity.create;
  //////////////////////////////////////////
  //////////////////////////////////////////
  if (ent1.flag_70 and (64+16))=0 then begin
    // THIS IS A NORMAL POLYLINE
    repeat
      if (NextGroupCode=0) and (ValStr = 'VERTEX') then begin
        ent2.clear;
        if read_entity_data(ent2) then begin
          tempvert[vertices] := ent2.p1; inc(vertices);
          if vertices>=max_vertices_per_polyline then goto vertex_overflow;
        end else begin ent1.Free; ent2.Free; exit; end; // error
      end;
    until fLine='SEQEND';
    // this should set result to true, because 0 SEQEND is next
    result := NextGroupCode=0;
    if ((ent1.flag_70) and 1)=1 then closed_poly := true;
    entity := Polyline_.create(ent1.OCS_Z,vertices,@tempvert[0],ent1.colour,closed_poly);
  end
  //////////////////////////////////////////
  //////////////////////////////////////////
  else if (ent1.flag_70 and 16)=16 then begin
    // THIS IS A POLYGON MESH - a grid of vertices joined along M & N
    M := ent1.flag_71; N := ent1.flag_72; mn := 0;
    repeat
      if (NextGroupCode=0) and (ValStr = 'VERTEX') then begin
        if read_entity_data(ent2) then begin
          inc(mn);
          if (ent2.Flag_70 and 64)=64 then begin
            tempvert[vertices] := ent2.p1; inc(vertices);
            if vertices>=max_vertices_per_polyline then goto vertex_overflow;
          end else begin ent1.Free; ent2.Free; exit; end; // error
        end else begin ent1.Free; ent2.Free; exit; end; // error
      end;
    until fLine='SEQEND';
    result := NextGroupCode=0;
    if mn<>M*N then begin ent1.Free; ent2.Free; exit; end; // error
    entity := Polygon_mesh_.create(vertices,M,N,@tempvert[0],ent1.flag_70,ent1.colour);
  end
  //////////////////////////////////////////
  //////////////////////////////////////////
  else if (ent1.flag_70 and 64)=64 then begin
    // THIS IS A POLYFACE MESH - a vertex array with facets
    repeat
      if (NextGroupCode=0) and (ValStr = 'VERTEX') then begin
        if read_entity_data(ent2) then begin
          if (ent2.Flag_70 and (128+64))=(128+64) then begin
            // this is a normal coordinate vertex
            tempvert[vertices] := ent2.p1; inc(vertices);
            if vertices>=max_vertices_per_polyline then goto vertex_overflow;
          end else if (ent2.Flag_70 and (128))=(128) then begin
            // this is a face definition vertex
            // negative indices indicate invisible edges (ignored for now)
            tempface[faces].nf[0] := Abs(ent2.flag_71)-1; // index 1..n -> 0..n-1
            tempface[faces].nf[1] := Abs(ent2.flag_72)-1;
            tempface[faces].nf[2] := Abs(ent2.flag_73)-1;
            tempface[faces].nf[3] := Abs(ent2.flag_74)-1;
            inc(faces);
          end else begin ent1.Free; ent2.Free; exit; end; // error
        end else begin ent1.Free; ent2.Free; exit; end; // error
      end;
    until fLine='SEQEND';
    result := NextGroupCode=0;
    entity := Polyface_mesh_.create(vertices,faces,@tempvert[0],@tempface[0],ent1.colour);
  end;
  //////////////////////////////////////////
  //////////////////////////////////////////
  ent1.Free; ent2.Free;
  exit; // next bit only when vertices overflow
vertex_overflow:
  ent1.Free; ent2.Free;
  raise DXF_read_exception.Create('Polyline contained more than '+
    IntToStr(max_vertices_per_polyline)+' vertices',line_num);
end;

function DXF_Reader.read_entity(s,endstr:string; var entity:DXF_Entity; var layer:integer) : boolean;
begin
  entity := nil; result := false;
  if (s='POINT') then begin if not general_purpose_read(Point_,entity,layer) then
    raise DXF_read_exception.Create('Error reading POINT entity',line_num); end
  else if (s='INSERT') then begin if not read_insert(entity,layer) then
    raise DXF_read_exception.Create('Error reading INSERT entity',line_num); end
  else if (s='TEXT') then begin if not general_purpose_read(Text_,entity,layer) then
    raise DXF_read_exception.Create('Error reading TEXT entity',line_num); end
  else if (s='LINE') then begin if not general_purpose_read(Line_,entity,layer) then
    raise DXF_read_exception.Create('Error reading LINE entity',line_num); end
  else if (s='POLYLINE') then begin if not read_polyline(entity,layer) then
    raise DXF_read_exception.Create('Error reading POLYLINE entity',line_num); end
  else if (s='3DFACE') then begin if not general_purpose_read(Face3D_,entity,layer) then
    raise DXF_read_exception.Create('Error reading 3DFACE entity',line_num); end
  else if (s='SOLID') then begin if not general_purpose_read(Solid_,entity,layer) then
    raise DXF_read_exception.Create('Error reading SOLID entity',line_num); end
  else if (s='CIRCLE') then begin if not general_purpose_read(Circle_,entity,layer) then
    raise DXF_read_exception.Create('Error reading CIRCLE entity',line_num); end
  else if (s='ARC') then begin if not general_purpose_read(Arc_,entity,layer) then
    raise DXF_read_exception.Create('Error reading ARC entity',line_num); end
  else if (s='ATTDEF') then begin if not general_purpose_read(AttDef_,entity,layer) then
    raise DXF_read_exception.Create('Error reading ATTDEF entity',line_num); end
  else if (s='ATTRIB') then begin if not general_purpose_read(Attrib_,entity,layer) then
    raise DXF_read_exception.Create('Error reading ATTRIB entity',line_num); end
  else if (s=endstr) then result := true
  else if skipped<>nil then Skipped.Add(s);
end;
///////////////////////////////////////////////////////////////////////////////
// Main routines to use
///////////////////////////////////////////////////////////////////////////////
function DXF_Reader.read_file : boolean;
var lp1 : integer;
begin
  result := true;
  thinking_bar(nil,'Reading DXF file...');
  try
    mark_position;
    if not (move_to_header_section and read_header) then begin
      Thinking(nil,'No Header or invalid Header section in DXF file');
      Sleep(message_delay_ms);
      goto_marked_position;
    end;
    mark_position;
    if not (move_to_tables_section and read_tables) then begin
      Thinking(nil,'No Layers or invalid Tables section in DXF file');
      Sleep(message_delay_ms);
      goto_marked_position;
    end;
    mark_position;
    if not (move_to_blocks_section and read_blocks) then begin
      Thinking(nil,'No Blocks or invalid Blocks section in DXF file');
      Sleep(message_delay_ms);
      goto_marked_position;
    end;
    mark_position;
    thinking_bar(nil,'Reading DXF file...');
    if not (move_to_entity_section and read_entities) then
      raise DXF_read_exception.Create('No Entities or invalid Entities section in DXF file',-1);
  except
    on E:DXF_read_exception do begin
      stopped_thinking;
      MessageBox(0,@E.message[1],'DXF Read Error',MB_ICONWARNING);
    end;
    on E:EAccessViolation do begin
      stopped_thinking;
      MessageDlg(E.message, mtWarning, [mbOK], 0);
    end;
  end;
  if p1_eq_p2_3D(min_extents,origin3D) or p1_eq_p2_3D(max_extents,origin3D) then begin
    thinking(nil,'File contained no Max/Min extents. Scanning...');
    sleep(message_delay_ms); // just a delay to let the message be visible
    for lp1:=0 to DXF_layers.count-1 do
      DXF_Layer(DXF_Layers[lp1]).max_min_extents(max_extents,min_extents);
  end;
  stopped_thinking;
end;

function DXF_Reader.remove_empty_layers : boolean;
var lp1   : integer;
    layer : DXF_layer;
begin
   for lp1 := DXF_Layers.count-1 downto 0 do begin
     layer :=  DXF_Layers[lp1];
     if layer.num_lists=0 then begin
       DXF_Layers.Remove(layer);
       layer.Free;
     end;
  end;
  result := (DXF_Layers.count>0);
end;

// Hand over ownership of the layers, the owner of the entity lists
// is now responsible for their destruction
function DXF_Reader.release_control_of_layers : TList;
begin
  result     := DXF_Layers;
  DXF_Layers := nil;
end;

// Since we're not reading all groupcodes, we offer the chance
// to dump the main titles into a list so we can see what
// we've missed
procedure DXF_Reader.set_skipped_list(s:TStrings);
begin
  skipped := s;
end;
///////////////////////////////////////////////////////////////////////////////
// DXF File exception
///////////////////////////////////////////////////////////////////////////////
constructor DXF_read_exception.create(err_msg:string; line:integer);
begin
  if line>-1 then
    message := err_msg + #13#10 + 'Error occured at or near line number ' + IntToStr(line)
  else message := err_msg;
end;

{$WARNINGS ON}
initialization
end.


