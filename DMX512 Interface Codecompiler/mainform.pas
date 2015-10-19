unit mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, ShellAPI, ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    XPManifest1: TXPManifest;
    Memo2: TMemo;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    procedure SetSerialNumber(Serial:string);
    procedure GenerateRandomSN;
    procedure CreateFirmware;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SetSerialNumber(Serial: string);
var
  serialstring:string;
  i:integer;
begin
  serialstring:='';
  for i:=1 to 16 do
  begin
    serialstring:=serialstring+''''+serial[i]+''',';
  end;
  serialstring:=copy(serialstring, 0, length(serialstring)-1);

  if FileExists(ExtractFilePath(paramstr(0))+'usbconfig.h') then
  begin
    memo1.Lines.LoadFromFile(ExtractFilePath(paramstr(0))+'usbconfig.h');
    memo2.Text:=stringreplace(memo1.Text,'''1'',''2'',''3'',''4'',''5'',''6'',''7'',''8'',''9'',''A'',''B'',''C'',''D'',''E'',''F'',''G''', serialstring, [rfReplaceAll, rfIgnoreCase]);
    memo2.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'usbconfig.h');
  end else
  begin
    ShowMessage('usbconfig.h wurde nicht gefunden. Bitte laden Sie das Firmwarepaket erneut von www.pcdimmer.de herunter. Vielen Dank.');
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (16-length(edit1.text))<0 then
  begin
    ShowMessage('Sie haben zu viele Zeichen eingegeben!');
  end else if (16-length(edit1.text))>0 then
  begin
    ShowMessage('Sie haben zu wenig Zeichen eingegeben!');
  end else if (16-length(edit1.text))=0 then
  begin
    SetSerialNumber(edit1.text);
    CreateFirmware;
  end;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if (16-length(edit1.text))<0 then
  begin
    label2.caption:='(max. 16 Zeichen!)';
    label2.Font.Color:=clRed;
  end else if (16-length(edit1.text))>0 then
  begin
    label2.Caption:='(noch '+inttostr(16-length(edit1.text))+' Zeichen)';
    label2.Font.Color:=clRed;
  end else if (16-length(edit1.text))=0 then
  begin
    label2.Caption:='(OK)';
    label2.font.Color:=clBlack;
  end;
end;

procedure TForm1.CreateFirmware;
begin
  if FileExists(ExtractFilePath(paramstr(0))+'\CompileAs.bat') then
  begin
    ShellExecute(Handle, 'open', PAnsiChar(ExtractFilePath(paramstr(0))+'\CompileAs.bat'), PAnsiChar(Edit1.text), nil, SW_SHOW);
    ShowMessage('Ihre Firmware wurde erstellt und ist nun im Ordner "'+ExtractFilePath(paramstr(0))+'output" verfügbar.');
  end else
  begin
    ShowMessage('Die Datei "CompileAs.bat" konnte nicht gefunden werden. Bitte laden Sie die Firmware neu von www.pcdimmer.de herunter.');
    close;
  end;
end;

procedure TForm1.GenerateRandomSN;
var
  j:integer;
begin
  Randomize;

  case RadioGroup1.itemindex of
    0:
    begin
      edit1.text:=inttostr(Random(9999))+inttostr(Random(9999))+inttostr(Random(9999))+inttostr(Random(9999));
      while length(edit1.Text)<16 do
      begin
        edit1.text:=edit1.text+inttostr(Random(10));
      end;
    end;
    1:
    begin
      edit1.text:=inttohex(Random(65536), 4)+inttohex(Random(65536), 4)+inttohex(Random(65536), 4)+inttohex(Random(65536), 4);
    end;
    2:
    begin
      edit1.text:='';
      while length(edit1.text)<16 do
      begin
        j:=Random(91);
        if (j>=65) then
          edit1.text:=edit1.Text+chr(j);
      end;
    end;
    3:
    begin
      edit1.text:='';
      while length(edit1.text)<16 do
      begin
        j:=Random(91);
        if (j>=65) or ((j>=48) and (j<=57)) then
          edit1.text:=edit1.Text+chr(j);
      end;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  GenerateRandomSN;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GenerateRandomSN;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  GenerateRandomSN;
end;

end.
