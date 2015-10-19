unit DemoMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  Searches, Menus, StdCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    SearchFile1: TMenuItem;
    OpenDialog1: TOpenDialog;
    CaseSensitive1: TMenuItem;
    N3: TMenuItem;
    Memo1: TMemo;
    SearchMemo1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure SearchFile1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure CaseSensitive1Click(Sender: TObject);
    procedure SearchMemo1Click(Sender: TObject);
  private
    TextSearch: TSearch;
    FileSearch: TFileSearch;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

//------------------------------------------------------------------------------

procedure TForm1.FormCreate(Sender: TObject);
begin
  TextSearch := TSearch.create(self);
  FileSearch := TFileSearch.create(self);
end;
//------------------------------------------------------------------------------

procedure TForm1.Exit1Click(Sender: TObject);
begin
  close;
end;
//------------------------------------------------------------------------------

procedure TForm1.CaseSensitive1Click(Sender: TObject);
begin
  CaseSensitive1.Checked := not CaseSensitive1.Checked;
  FileSearch.CaseSensitive := CaseSensitive1.Checked;
  TextSearch.CaseSensitive := CaseSensitive1.Checked;
end;
//------------------------------------------------------------------------------

procedure TForm1.SearchMemo1Click(Sender: TObject);
var
  str: string;
  i: integer;
begin
  //get the sub-text (pattern) ...
  TextSearch.pattern := InputBox('Search for ...', '', TextSearch.pattern);
  if TextSearch.pattern = '' then exit;
  //assign the text to search ...
  str := Memo1.text;
  TextSearch.SetData(pchar(str),length(str));
  //find the first occurrence ...
  i := TextSearch.Findfirst;
  if i = POSITION_EOF then
  begin
    beep; //not found!
    exit;
  end;
  //highlight the first match ...
  Memo1.SelStart := i;
  Memo1.SelLength := length(TextSearch.pattern);
end;
//------------------------------------------------------------------------------

procedure TForm1.SearchFile1Click(Sender: TObject);
var
  i, cnt: integer;
begin
  //get the file to be searched ...
  if not OpenDialog1.execute then exit;
  FileSearch.Filename := OpenDialog1.filename;
  //get the sub-text ...
  FileSearch.pattern :=
    InputBox('Search for ...', '', FileSearch.pattern);
  if FileSearch.pattern = '' then exit;
  //do the search ...
  cnt := 0;

  //you could add a performance monitor to time this ...
  i := FileSearch.Findfirst;
  while i <> POSITION_EOF do
  begin
    inc(cnt);
    i := FileSearch.FindNext;
  end;

  //report the number of occurrences ...
  memo1.clear;
  memo1.Lines.add(format('Searching the file "%s" ...', [OpenDialog1.filename]));
  memo1.Lines.add(format('%d occurrences of "%s" found',
    [cnt, FileSearch.pattern]));
end;
//------------------------------------------------------------------------------

end.
