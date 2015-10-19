unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, MruUnit, Menus, ComCtrls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure MostRecentFiles1MenuClick(Sender: TObject;
      const Filename: String);
    procedure FormCreate(Sender: TObject);
  private
    MostRecentFiles1: TMostRecentFiles;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  MostRecentFiles1 := TMostRecentFiles.Create(self);
  //specifiy either an iniFile OR a regPath where the MRU List is to be saved ...
  MostRecentFiles1.IniFile := changefileext(paramstr(0),'.ini');
  //MostRecentFiles1.RegPath := '\Software\ACompanyName\AnAppName';

  MostRecentFiles1.OwnerMenuItem := File1;
  MostRecentFiles1.MenuPosition := 1;
  MostRecentFiles1.ShowFullPath := true;
  MostRecentFiles1.OnMenuClick := MostRecentFiles1MenuClick;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then exit;
  OpenDialog1.InitialDir := extractfilepath(OpenDialog1.FileName);
  //whenever a file is opened, simply add it to the MRU List ...
  MostRecentFiles1.AddFile(OpenDialog1.FileName);
end;

procedure TForm1.MostRecentFiles1MenuClick(Sender: TObject;
  const Filename: String);
begin
  //whenever an MRU menuitem is clicked - do something with it ...
  OpenDialog1.InitialDir := extractfilepath(FileName);
end;

end.
