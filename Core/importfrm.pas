unit importfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, JvExControls, JvGradient,
  dxGDIPlusClasses;

type
  TInfo = record
    Name:string;
    Description:string;
  end;
  Timportform = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Panel2: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Memo1: TMemo;
    Panel5: TPanel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    Info:array of TInfo;
  end;

var
  importform: Timportform;

implementation

{$R *.dfm}

end.
