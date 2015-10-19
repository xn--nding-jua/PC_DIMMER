unit K8062_1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  StartAddress: Longint;

implementation

{$R *.DFM}
PROCEDURE StartDevice; stdcall; external 'K8062d.dll';
PROCEDURE SetData(Channel: Longint ; Data: Longint); stdcall; external 'K8062d.dll';
PROCEDURE SetChannelCount(Count: Longint); stdcall; external 'K8062d.dll';
PROCEDURE StopDevice; stdcall; external 'K8062d.dll';


procedure TForm1.FormCreate(Sender: TObject);
begin
  StartDevice;
  StartAddress:=1;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StopDevice;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if (StrToInt(Edit1.Text)>0) and (StrToInt(Edit1.Text)<509) then
  begin          
    StartAddress:=StrToInt(Edit1.Text);
    SetChannelCount(StartAddress+3);
    Label5.Caption:=IntToStr(StartAddress);
    Label6.Caption:=IntToStr(StartAddress+1);
    Label7.Caption:=IntToStr(StartAddress+2);
    Label8.Caption:=IntToStr(StartAddress+3);
  end;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Label1.Caption:=IntToStr(255-ScrollBar1.Position);
  SetData(StartAddress, 255-ScrollBar1.Position);
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  Label2.Caption:=IntToStr(255-ScrollBar2.Position);
  SetData(StartAddress+1, 255-ScrollBar2.Position);
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
begin
  Label3.Caption:=IntToStr(255-ScrollBar3.Position);
  SetData(StartAddress+2, 255-ScrollBar3.Position);
end;

procedure TForm1.ScrollBar4Change(Sender: TObject);
begin
  Label4.Caption:=IntToStr(255-ScrollBar4.Position);
  SetData(StartAddress+3, 255-ScrollBar4.Position);
end;

end.
