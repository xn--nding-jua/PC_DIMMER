unit dmxstranscode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TIDtag = record
    Header:array[0..2] of char;
    Titel:array[0..29] of char;
    Projectname:array[0..29] of char;
    Description:array[0..29] of char;
    Year:array[0..3] of char;
    Comment:array[0..29] of char;
    Reserved:char;
  end;
  PIDTag = ^TIDtag;
  PFileStream = ^TFileStream;
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    sourceaedit: TEdit;
    openabtn: TButton;
    GroupBox2: TGroupBox;
    sourcebedit: TEdit;
    openbbtn: TButton;
    GroupBox3: TGroupBox;
    destinationedit: TEdit;
    mergebabtn: TButton;
    mergeabbtn: TButton;
    procedure openabtnClick(Sender: TObject);
    procedure openbbtnClick(Sender: TObject);
    procedure mergebabtnClick(Sender: TObject);
    procedure mergeabbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure ReadID(FileStream:PFileStream; IDTag:PIDTag);
    procedure WriteID(FileStream:PFileStream; IDTag:PIDTag);
  public
    { Public-Deklarationen }
    FileStreamA, FileStreamB, FileStreamC:TFileStream;
    IDTagA, IDTagB:TIDTag;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.openabtnClick(Sender: TObject);
begin
  FileStreamA:=TFileStream.Create(sourceaedit.text, fmOpenRead);
  ReadID(@FileStreamA, @IDTagA);
  openabtn.Enabled:=false;

  if (not openabtn.Enabled) and (not openbbtn.Enabled) then
  begin
    mergeabbtn.Enabled:=true;
    mergebabtn.Enabled:=true;
  end;
end;

procedure TForm1.ReadID(FileStream:PFileStream; IDTag:PIDTag);
var
  StoreFilePosition:Int64;
  NextFrameA, NextFrameB, NextFrameC:byte;
begin
  StoreFilePosition:=FileStream^.Position;
  FileStream^.Position:=FileStream^.Size-128;

  FileStream^.Read(NextFrameA, sizeof(NextFrameA)); 			          // nächstmögliches Byte auslesen
	FileStream^.Read(NextFrameB, sizeof(NextFrameB)); 			          // nächstmögliches Byte auslesen
	FileStream^.Read(NextFrameC, sizeof(NextFrameC)); 			          // nächstmögliches Byte auslesen
  if ((char(NextFrameA)='T') and (char(NextFrameB)='A') and (char(NextFrameC)='G')) then
  begin
    FileStream^.Position:=FileStream^.Size-128;
    FileStream^.Read(IDTag^, sizeof(IDTag^));
  end else
  begin
    IDTag^.Titel:='<kein TAG gefunden>';
    IDTag^.Projectname:='';
    IDTag^.Description:='';
    IDTag^.Year:='';
    IDTag^.Comment:='';
    IDTag^.Reserved:=' ';
  end;

  FileStream^.Position:=StoreFilePosition;
end;

procedure TForm1.WriteID(FileStream:PFileStream; IDTag:PIDTag);
begin
  FileStream^.WriteBuffer(IDTag^, sizeof(IDTag^));
end;

procedure TForm1.openbbtnClick(Sender: TObject);
begin
  FileStreamB:=TFileStream.Create(sourcebedit.text, fmOpenRead);
  ReadID(@FileStreamB, @IDTagB);
  openbbtn.Enabled:=false;

  if (not openabtn.Enabled) and (not openbbtn.Enabled) then
  begin
    mergeabbtn.Enabled:=true;
    mergebabtn.Enabled:=true;
  end;
end;

procedure TForm1.mergebabtnClick(Sender: TObject);
begin
  FileStreamC:=TFileStream.Create(destinationedit.Text, fmCreate);
  FileStreamA.Position:=0;
  FileStreamB.Position:=0;

  FileStreamC.CopyFrom(FileStreamA, FileStreamA.Size-128);
  FileStreamC.CopyFrom(FileStreamB, FileStreamB.Size-128);
  WriteID(@FileStreamC, @IDTagB);

  FileStreamC.Free;
end;

procedure TForm1.mergeabbtnClick(Sender: TObject);
begin
  FileStreamC:=TFileStream.Create(destinationedit.Text, fmCreate);
  FileStreamA.Position:=0;
  FileStreamB.Position:=0;

  FileStreamC.CopyFrom(FileStreamB, FileStreamB.Size-128);
  FileStreamC.CopyFrom(FileStreamA, FileStreamA.Size-128);
  WriteID(@FileStreamC, @IDTagA);

  FileStreamC.Free;
end;

end.
