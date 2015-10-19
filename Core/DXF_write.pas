{$WARNINGS OFF}
///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//                         DXF File writer object/code                       //
//                             ©John Biddiscombe                             //
//                      Rutherford Appleton Laboratory, UK                   //
//                           j.biddiscombe@rl.ac.uk                          //
//                       DXF code release 3.0 - July 1997                    //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
unit DXF_write;

interface

uses
  { Borland }
  SysUtils,StdCtrls,Dialogs,Classes,Graphics,
  { Mine }
  DXF_Utils,DXF_structs;

///////////////////////////////////////////////////////////////////////////////
// DXF_Writer class definition
///////////////////////////////////////////////////////////////////////////////
type
  DXF_Writer = class
  private
    IO_Chan   : Text;
  public
    // Extents in (x,y) of the dataset
    min_extents    : Point3D;
    max_extents    : Point3D;
    DXF_Layers     : TList;
    // Constructors and destructors
    Constructor create(aname:string; data_list:TList);
    Destructor  destroy; override;
    procedure   write_file;
    // Header section
    function    write_header : boolean;
    // Tables section
    function    write_tables : boolean;
    function    write_layer_information : boolean;
    function    write_vport_information : boolean;
    // BLocks section
    function    write_blocks            : boolean;
    // Entities section
    function    write_entities          : boolean;
  end;

// DXF File write exceptions will be this type
type
  DXF_write_exception = class(Exception);

implementation
  
const
  EOL = #13#10;

{ --------------------------------------------------------------------------- }
{ -------------------             DXFWriter           ----------------------- }
{ --------------------------------------------------------------------------- }
Constructor DXF_Writer.Create(aname:string; data_list:TList);
begin
  Inherited Create;
  AssignFile(IO_Chan,aName);
  Rewrite(IO_Chan);
  DXF_Layers     := data_list;
end;

destructor DXF_Writer.Destroy;
begin
  CloseFile(IO_chan);
  Inherited Destroy;
end;

procedure DXF_Writer.write_file;
begin
  write_header;
  write_tables;
  write_blocks;
  write_entities;
  writeln(IO_chan,0,EOL,'EOF');
end;

function DXF_Writer.write_header : boolean;
var lp1 : integer;
begin
  min_extents := aPoint3D( 1E10, 1E10, 1E10);
  max_extents := aPoint3D(-1E10,-1E10,-1E10);
  writeln(IO_chan,0,EOL,'SECTION');
  writeln(IO_chan,2,EOL,'HEADER');
  for lp1:=0 to DXF_layers.count-1 do
    DXF_Layer(DXF_Layers[lp1]).max_min_extents(max_extents,min_extents);
  writeln(IO_chan,9 ,EOL,'$EXTMIN');
  writeln(IO_chan,10,EOL,FloatToStr(min_extents.x));
  writeln(IO_chan,20,EOL,FloatToStr(min_extents.y));
  writeln(IO_chan,30,EOL,FloatToStr(min_extents.z));
  writeln(IO_chan,9 ,EOL,'$EXTMAX');
  writeln(IO_chan,10,EOL,FloatToStr(max_extents.x));
  writeln(IO_chan,20,EOL,FloatToStr(max_extents.y));
  writeln(IO_chan,30,EOL,FloatToStr(max_extents.z));
  writeln(IO_chan,0,EOL,'ENDSEC');
end;

function DXF_Writer.write_tables : boolean;
begin
  writeln(IO_chan,0,EOL,'SECTION');
  writeln(IO_chan,2,EOL,'TABLES');
  write_vport_information;
  write_layer_information;
  writeln(IO_chan,0,EOL,'ENDSEC');
end;

function DXF_Writer.write_layer_information : boolean;
var lp1   : integer;
    layer : DXF_Layer;
begin
  writeln(IO_chan,0,EOL,'TABLE');
  writeln(IO_chan,2,EOL,'LAYER');
  for lp1:=DXF_layers.count-1 downto 0 do begin
    layer := DXF_Layer(DXF_Layers[lp1]);
    writeln(IO_chan,0 ,EOL,'LAYER');
    writeln(IO_chan,2 ,EOL,layer.name);
    writeln(IO_chan,62,EOL,layer.layer_colinx);
  end;
  writeln(IO_chan,0,EOL,'ENDTAB');
end;

function DXF_Writer.write_vport_information : boolean;
begin
  writeln(IO_chan,0,EOL,'TABLE');
  writeln(IO_chan,2,EOL,'VPORT');
  writeln(IO_chan,0,EOL,'VPORT');
  writeln(IO_chan,2,EOL,'*ACTIVE');
  writeln(IO_chan,41,EOL,1.0{aspect}:10:6);
  writeln(IO_chan,0,EOL,'ENDTAB');
end;

function DXF_Writer.write_blocks : boolean;
var lp1,lp2,lp3 : integer;
    layer       : DXF_Layer;
    eList       : Entity_List;
begin
  writeln(IO_chan,0,EOL,'SECTION');
  writeln(IO_chan,2,EOL,'BLOCKS');
  // find the layer with the blocks in it (should be '0')
  layer := nil;
  for lp1:=0 to DXF_Layers.count-1 do
    if DXF_Layer(DXF_Layers[lp1]).name='0' then layer := DXF_Layer(DXF_Layers[lp1]);
  if layer<>nil then begin
    for lp2:=0 to layer.num_lists-1 do begin
      eList := Entity_List(layer.entity_lists[lp2]);
      if eList.name=Block_.ClassName then begin
        for lp3:=0 to eList.entities.Count-1 do begin
          DXF_Entity(eList.entities[lp3]).write_to_DXF(IO_chan,layer.name);
        end;
      end;
    end;
  end;
  writeln(IO_chan,0,EOL,'ENDSEC');
end;

function DXF_Writer.write_entities : boolean;
var lp1,lp2,lp3 : integer;
    layer       : DXF_Layer;
    eList       : Entity_List;
begin
  writeln(IO_chan,0,EOL,'SECTION');
  writeln(IO_chan,2,EOL,'ENTITIES');
  for lp1:=0 to DXF_layers.count-1 do begin
    layer := DXF_Layer(DXF_Layers[lp1]);
    for lp2:=0 to layer.num_lists-1 do begin
      eList := Entity_List(layer.entity_lists[lp2]);
      if eList.name<>Block_.ClassName then begin
        for lp3:=0 to eList.entities.Count-1 do begin
          DXF_Entity(eList.entities[lp3]).write_to_DXF(IO_chan,layer.name);
        end;
      end;
    end;
  end;
  writeln(IO_chan,0,EOL,'ENDSEC');
end;
{$WARNINGS ON}
initialization
end.


