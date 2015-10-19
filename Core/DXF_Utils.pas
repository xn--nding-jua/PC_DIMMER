///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//                      Assorted routines for DXF project                    //
//                             ©John Biddiscombe                             //
//                      Rutherford Appleton Laboratory, UK                   //
//                           j.biddiscombe@rl.ac.uk                          //
//                       DXF code release 3.0 - July 1997                    //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
unit DXF_Utils;

interface

uses
  Math, SysUtils;

type
  Point3D = record
    x,y,z : double;
  end;

  Point2D = record
    x,y : Double;
  end;

  PPoint3D   = ^Point3D;
  ppointlist = ^pointlist;
  pointlist  = array[0..0] of Point3D;

const
  origin3D : Point3D = (x:0; y:0; z:0);
  WCS_X    : Point3D = (x:1; y:0; z:0);
  WCS_Y    : Point3D = (x:0; y:1; z:0);
  WCS_Z    : Point3D = (x:0; y:0; z:1);

type
  pMatrix = ^Matrix;
  pM      = pMatrix;
  Matrix = record
    val : array[0..3,0..3] of double;
  end;

const
  identity : Matrix = (val:((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)));

///////////////////////////////////////////////////////////////////////////////
// General point 3D stuff
///////////////////////////////////////////////////////////////////////////////
function aPoint3D(a,b,c:double)       : Point3D;
function p1_eq_p2_3D(p1,p2:Point3D)   : boolean;
function p1_eq_p2_2D(p1,p2:Point3D)   : boolean;
function p1_minus_p2(p1,p2:Point3D)   : Point3D;
function p1_plus_p2 (p1,p2:Point3D)   : Point3D;
function normalize(p1:Point3D)        : Point3D;
function mag(p1:Point3D)              : double;
function dist3D(p1,p2:Point3D)        : double;
function dist2D(p1,p2:Point3D)        : double;
function sq_dist3D(p1,p2:Point3D)     : double;
function sq_dist2D(p1,p2:Point3D)     : double;
function sq_mag3D(p1:Point3D)         : double;
function p1_x_n(p1:Point3D; n:double) : Point3D;
function set_accuracy(factor:double; p:Point3D) : Point3D;
///////////////////////////////////////////////////////////////////////////////
// Vector 3D stuff
///////////////////////////////////////////////////////////////////////////////
function dot(p1,p2:Point3D)                     : double;
function cross(p1,p2:Point3D)                   : Point3D;
function angle(p1,p2,p3:Point3D; do_3D:boolean) : double;
///////////////////////////////////////////////////////////////////////////////
// Rotations for Insert/Block drawing
///////////////////////////////////////////////////////////////////////////////
function XRotateMatrix(cos_a,sin_a:double)      : Matrix;
function YRotateMatrix(cos_a,sin_a:double)      : Matrix;
function ZRotateMatrix(cos_a,sin_a:double)      : Matrix;
function ScaleMatrix(p:Point3D)                 : Matrix;
function TranslateMatrix(p:Point3D)             : Matrix;
function MatrixMultiply(matrix1,matrix2:Matrix) : Matrix;
function CreateTransformation(Ax,Ay,Az:Point3D) : Matrix;
function TransformPoint(TM:Matrix; p:Point3D) : Point3D;
function update_transformations(OCS_WCS,OCS:pMatrix) : pMatrix;
function RotationAxis(A:Point3D; angle:double) : Matrix;
///////////////////////////////////////////////////////////////////////////////
// Bounds
///////////////////////////////////////////////////////////////////////////////
procedure max_bound(var bounds:Point3D; point:Point3D);
procedure min_bound(var bounds:Point3D; point:Point3D);
function  dmin(a,b:double) : double;
function  dmax(a,b:double) : double;
function  imin(a,b:integer) : integer;
function  imax(a,b:integer) : integer;
///////////////////////////////////////////////////////////////////////////////
// Memory
///////////////////////////////////////////////////////////////////////////////
function  allocate_points(n:integer) : ppointlist;
procedure deallocate_points(var pts:ppointlist; n:integer);
function  allocate_matrix : pMatrix;
procedure deallocate_matrix(var m:pMatrix);
///////////////////////////////////////////////////////////////////////////////
// String
///////////////////////////////////////////////////////////////////////////////
function float_out(f:double)     : string;
function Point3DToStr(p:Point3D) : string;
function BoolToStr(b:boolean)    : string;

implementation

function aPoint3D(a,b,c:double) : Point3D;
begin
  result.x := a; result.y := b; result.z := c;
end;

function p1_eq_p2_3D(p1,p2:Point3D) : boolean;
begin
  result := (p1.x=p2.x) and (p1.y=p2.y) and (p1.z=p2.z);
end;

function p1_eq_p2_2D(p1,p2:Point3D) : boolean;
begin
  result := (p1.x=p2.x) and (p1.y=p2.y);
end;

function p1_minus_p2(p1,p2:Point3D) : Point3D;
begin
  result.x := p1.x-p2.x;
  result.y := p1.y-p2.y;
  result.z := p1.z-p2.z;
end;

function p1_plus_p2(p1,p2:Point3D) : Point3D;
begin
  result.x := p1.x+p2.x;
  result.y := p1.y+p2.y;
  result.z := p1.z+p2.z;
end;

function normalize(p1:Point3D) : Point3D;
var mag : double;
begin
  mag := Sqrt( sqr(p1.x) + sqr(p1.y) + sqr(p1.z) );
  result.x := p1.x/mag;
  result.y := p1.y/mag;
  result.z := p1.z/mag;
end;

function mag(p1:Point3D) : double;
begin
  with p1 do result := Sqrt( sqr(x) + sqr(y) + sqr(z) );
end;

function dist3D(p1,p2:Point3D) : double;
begin
  with p1_minus_p2(p2,p1) do result := Sqrt( sqr(x) + sqr(y) + sqr(z) );
end;

function dist2D(p1,p2:Point3D) : double;
begin
  with p1_minus_p2(p2,p1) do result := Sqrt( sqr(x) + sqr(y) );
end;

function sq_dist3D(p1,p2:Point3D) : double;
begin
  with p1_minus_p2(p2,p1) do result := sqr(x) + sqr(y) + sqr(z);
end;

function sq_dist2D(p1,p2:Point3D) : double;
begin
  with p1_minus_p2(p2,p1) do result := sqr(x) + sqr(y);
end;

function sq_mag3D(p1:Point3D) : double;
begin
  with p1 do result := sqr(x) + sqr(y) + sqr(z);
end;

function p1_x_n(p1:Point3D; n:double) : Point3D;
begin
  result.x := p1.x*n;
  result.y := p1.y*n;
  result.z := p1.z*n;
end;

function set_accuracy(factor:double; p:Point3D) : Point3D;
begin
  result.x := round(p.x*factor)/factor;
  result.y := round(p.y*factor)/factor;
  result.z := round(p.z*factor)/factor;
end;
///////////////////////////////////////////////////////////////////////////////
// Vector 3D stuff
///////////////////////////////////////////////////////////////////////////////
function dot(p1,p2:Point3D) : double;
begin
  result := p1.x*p2.x + p1.y*p2.y + p1.z*p2.z;
end;

function cross(p1,p2:Point3D) : Point3D;
begin
  result.x := p1.y*p2.z - p1.z*p2.y;
  result.y := p1.z*p2.x - p1.x*p2.z;
  result.z := p1.x*p2.y - p1.y*p2.x;
end;

function angle(p1,p2,p3:Point3D; do_3D:boolean) : double;
var v1,v2 : Point3D;
    d1,d2 : double;
begin
  v1 := p1_minus_p2(p2,p1);
  v2 := p1_minus_p2(p3,p2);
  if not do_3D then begin v1.z := 0; v2.z := 0; end;
  d1 := Mag(v1);
  d2 := Mag(v2);
  if ((d1=0) or (d2=0)) then result := 0
  else begin
    d1 := dot(v1,v2)/(d1*d2);
    if abs(d1)<=1 then result := ArcCos(d1)
    else result := 0;
  end;
end;
///////////////////////////////////////////////////////////////////////////////
// Rotations for Insert/Block drawing
///////////////////////////////////////////////////////////////////////////////
function XRotateMatrix(cos_a,sin_a:double) : Matrix;
begin
  result := identity;
  result.val[1,1]:= cos_a;   result.val[1,2]:=-sin_a;
  result.val[2,1]:= sin_a;   result.val[2,2]:= cos_a;
end;

function YRotateMatrix(cos_a,sin_a:double) : Matrix;
begin
  result := identity;
  result.val[0,0]:= cos_a;   result.val[0,2]:= sin_a;
  result.val[2,0]:=-sin_a;   result.val[2,2]:= cos_a;
end;

function ZRotateMatrix(cos_a,sin_a:double) : Matrix;
begin
  result := identity;
  result.val[0,0]:= cos_a;   result.val[0,1]:=-sin_a;
  result.val[1,0]:= sin_a;   result.val[1,1]:= cos_a;
end;

function ScaleMatrix(p:Point3D) : Matrix;
begin
  result := identity;
  result.val[0,0] := p.x;
  result.val[1,1] := p.y;
  result.val[2,2] := p.z;
end;

function TranslateMatrix(p:Point3D) : Matrix;
begin
  result := identity;
  result.val[3,0] := p.x;
  result.val[3,1] := p.y;
  result.val[3,2] := p.z;
end;

function MatrixMultiply(matrix1,matrix2:matrix) : Matrix;
var row,column : integer;
begin
  for row:=0 to 3 do begin
    for column:=0 to 3 do result.val[row,column]:=
      matrix1.val[row,0]*matrix2.val[0,column] + matrix1.val[row,1]*matrix2.val[1,column] +
      matrix1.val[row,2]*matrix2.val[2,column] + matrix1.val[row,3]*matrix2.val[3,column];
  end;
end;

var
  GlobalTempMatrix : Matrix;

function update_transformations(OCS_WCS,OCS:pMatrix) : pMatrix;
begin
  if OCS=nil then result := OCS_WCS
  else if OCS_WCS=nil then result := OCS
  else begin
    GlobalTempMatrix := MatrixMultiply(OCS_WCS^,OCS^);
    result := @GlobalTempMatrix;
  end;
end;

{ Matrix order : For reference

  start with a point at ( cos(30),sin(30),0 )
  rotate by 30 degrees - shifts point to (1,0,0)
  then translate by (10,0,0) shifts to (11,0,0)
  then rotate by -45 degrees goes to (7.77, 7.77 ,0) 7.77 = Sqrt(11^2 /2 )
  NOTE THE ORDER OF MATRIX OPERATIONS !

    test := aPoint3D( cos(degtorad(30)) , sin(degtorad(30)) , 0);
    mat  := ZRotateMatrix( cos(degtorad(30)) , sin(degtorad(30)) );
    mat  := MatrixMultiply( mat , TranslateMatrix(aPoint3D(10,0,0)) );
    mat  := MatrixMultiply( mat , ZRotateMatrix( cos(degtorad(-45)) , sin(degtorad(-45)) ) );
    test := TransformPoint(mat,test);
}

function CreateTransformation(Ax,Ay,Az:Point3D) : Matrix;
begin
  result := Identity;
  result.val[0,0] :=Ax.x;  result.val[1,0] :=Ay.x;  result.val[2,0] :=Az.x;
  result.val[0,1] :=Ax.y;  result.val[1,1] :=Ay.y;  result.val[2,1] :=Az.y;
  result.val[0,2] :=Ax.z;  result.val[1,2] :=Ay.z;  result.val[2,2] :=Az.z;
end;

function TransformPoint(TM:Matrix; p:Point3D) : Point3D;
begin
  with TM do begin
    result.x := p.x*val[0,0] + p.y*val[1,0] + p.z*val[2,0] + val[3,0];
    result.y := p.x*val[0,1] + p.y*val[1,1] + p.z*val[2,1] + val[3,1];
    result.z := p.x*val[0,2] + p.y*val[1,2] + p.z*val[2,2] + val[3,2];
  end;
end;

function RotationAxis(A:Point3D; angle:double) : Matrix;
var sin_a,cos_a : double;
begin
  result := Identity;
    sin_a := sin(angle);
    cos_a := cos(angle);
    result.val[0][0] := (A.x*A.x + (1. - A.x*A.x)*cos_a);
    result.val[1][0] := (A.x*A.y*(1. - cos_a) + A.z*sin_a);
    result.val[2][0] := (A.x*A.z*(1. - cos_a) - A.y*sin_a);

    result.val[0][1] := (A.x*A.y*(1. - cos_a) - A.z*sin_a);
    result.val[1][1] := (A.y*A.y + (1. - A.y*A.y)*cos_a);
    result.val[2][1] := (A.y*A.z*(1. - cos_a) + A.x*sin_a);

    result.val[0][2] := (A.x*A.z*(1. - cos_a) + A.y*sin_a);
    result.val[1][2] := (A.y*A.z*(1. - cos_a) - A.x*sin_a);
    result.val[2][2] := (A.z*A.z + (1. - A.z*A.z)*cos_a);
end;
///////////////////////////////////////////////////////////////////////////////
// Bounds
///////////////////////////////////////////////////////////////////////////////
procedure max_bound(var bounds:Point3D; point:Point3D);
begin
  if point.x>bounds.x then bounds.x := point.x;
  if point.y>bounds.y then bounds.y := point.y;
  if point.z>bounds.z then bounds.z := point.z;
end;

procedure min_bound(var bounds:Point3D; point:Point3D);
begin
  if point.x<bounds.x then bounds.x := point.x;
  if point.y<bounds.y then bounds.y := point.y;
  if point.z<bounds.z then bounds.z := point.z;
end;

function dmin(a,b:double) : double;
begin
  if a<b then result := a else result := b;
end;

function dmax(a,b:double) : double;
begin
  if a>b then result := a else result := b;
end;

function imax(a,b:integer) : integer;
begin
  if a>b then result :=a else result:=b;
end;

function imin(a,b:integer) : integer;
begin
  if a>b then result :=b else result:=a;
end;

///////////////////////////////////////////////////////////////////////////////
// Memory
///////////////////////////////////////////////////////////////////////////////
function allocate_points(n:integer) : ppointlist;
begin
  Getmem(result,n*SizeOf(Point3D));
end;

procedure deallocate_points(var pts:ppointlist; n:integer);
begin
  Freemem(pts,n*SizeOf(Point3D));
  pts := nil;
end;

function allocate_matrix : pMatrix;
begin
  Getmem(result,SizeOf(Matrix));
end;

procedure deallocate_matrix(var m:pMatrix);
begin
  Freemem(m,SizeOf(Matrix));
  m := nil;
end;
///////////////////////////////////////////////////////////////////////////////
// String
///////////////////////////////////////////////////////////////////////////////
function float_out(f:double) : string;
begin
  result := FloatToStrF(f,ffFixed,7,3);
  //result := FloatToStr(f);
end;

function Point3DToStr(p:Point3D) : string;
begin
  result := '(' + FloatToStrF(p.x,ffFixed,7,2) + ', ' +
                  FloatToStrF(p.y,ffFixed,7,2) + ', ' +
                  FloatToStrF(p.z,ffFixed,7,2) + ')';
end;

function BoolToStr(b:boolean) : string;
begin
  if b then result := 'TRUE'
  else result := 'FALSE';
end;

end.
