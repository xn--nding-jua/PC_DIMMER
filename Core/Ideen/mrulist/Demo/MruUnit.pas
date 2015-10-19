unit MruUnit;

// -----------------------------------------------------------------------------
// Component Name:  TMostRecentFiles                                           .
// Module:          MruUnit                                                    .
// Description:     Implements a Most Recently Used file list.                 .
// Version:         1.3                                                        .
// Date:            28-MAR-2003                                                .
// Target:          Win32, Delphi 3 - Delphi 7                                 .
// Authors:         Angus Johnson,   angusj-AT-myrealbox-DOT-com               .
// Copyright        © 2003 Angus Johnson                                       .
//                                                                             .
//                                                                             .
// Usage:           1. Add an MRU component to the main form.                  .
//                  2. Assign the OwnerMenuItem property                       .
//                     eg: to add an MRU list to the 'File' menu -             .
//                         MostRecentFiles1.OwnerMenuItem := File1;            .
//                  3. Assign the MenuPosition property                        .
//                  4. Optionally assign a storage location for the list,      .
//                     either an Ini file or the Registry -                    .
//                         eg: MostRecentFiles1.RegPath :=                     .
//                             '\Software\ACompanyName\AnAppName';             .
//                     (By omitting this step MRU will simply use the default  .
//                     ini filename based on the application's filename.)      .
//                  5. Assign the OnClick event to respond by opening the      .
//                     file named by the Filename parameter.                   .
//                  6. When a file is opened pass the filename to the AddFile  .
//                     method -                                                .
//                         eg: MostRecentFiles1.AddFile(aFilename);            .
// -----------------------------------------------------------------------------

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, Menus, IniFiles, Registry;

type

  TMRUMenuEvent = procedure (Sender: TObject; const Filename: string) of Object;

  TMostRecentFiles = class(TComponent)
  private
    fMaxFiles: cardinal;
    fMenuPosition: cardinal;
    fOwnerMenuItem: TMenuItem;
    fIniFilename: string;
    fRegPath: string;
    fShowFullPath: boolean;
    fFileList: TStrings;
    fMRUClickEvent: TMRUMenuEvent;
    fNoFileEvent: TMRUMenuEvent;
    procedure SetMaxFiles(count: cardinal);
    procedure SetShowFullPath(value: boolean);
    procedure LoadFilesFromReg;
    procedure LoadFilesFromIni;
    procedure SaveFilesToReg;
    procedure SaveFilesToIni;
    procedure SetIniFile(const aIniFile: string);
    procedure SetRegPath(const aRegPath: string);
    procedure SetOwnerMenu(aMenuItem: TMenuItem);
  protected
    procedure DoClick(Sender: TObject);
    procedure RefreshList;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    //include a call to this method where ever a file is opened ...
    function AddFile(const Filename: string): boolean;
  published
    property MaxFiles: cardinal read fMaxFiles write SetMaxFiles; {1..8}
    property ShowFullPath: boolean read fShowFullPath write SetShowFullPath;
    //the MRU list has to be attached somewhere ...
    property OwnerMenuItem: TMenuItem read fOwnerMenuItem write SetOwnerMenu;
    property MenuPosition: cardinal read fMenuPosition write fMenuPosition;
    //store the list either in an ini file or in the registry ...
    property IniFile: string read fIniFilename write SetIniFile;
    property RegPath: string read fRegPath write SetRegPath;
    //feedback an MRU menuItem click by assigning this event ...
    property OnMenuClick: TMRUMenuEvent read fMRUClickEvent write fMRUClickEvent;
    //optional event triggered whenever a clicked MRU file no longer exists...
    property OnFileNotExist: TMRUMenuEvent read fNoFileEvent write fNoFileEvent;
  end;

procedure Register;

const MRU_FLAG = $BAD1DEA;

implementation

resourceString
  s_no_file_exists = 'The file ...'#10'"%s"'#10'no longer exists.';

procedure Register;
begin
  RegisterComponents('Samples', [TMostRecentFiles]);
end;
//------------------------------------------------------------------------------

constructor TMostRecentFiles.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  fFileList := TStringList.create;
  fMaxFiles := 4;
end;
//------------------------------------------------------------------------------

destructor TMostRecentFiles.Destroy;
begin
  if not (csDesigning in ComponentState) then
  try
    if fRegPath = '' then
      SaveFilesToIni else
      SaveFilesToReg;
  except
  end;
  fFileList.free;
  inherited Destroy;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then
    if fRegPath = '' then
      LoadFilesFromIni else
      LoadFilesFromReg;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if (Operation = opRemove) and (AComponent = fOwnerMenuItem) then
    fOwnerMenuItem := nil;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.LoadFilesFromReg;
var
  i: cardinal;
  s: string;
begin
  fFileList.Clear;
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    if OpenKey(fRegPath, false) then
    begin
      for i := 1 to fMaxFiles do
      begin
        if ValueExists('MRU'+inttostr(i)) then
          s := readString('MRU'+inttostr(i)) else
          break;
        fFileList.Add(s);
      end;
      CloseKey;
    end;
  finally
    free;
  end;
  RefreshList;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.LoadFilesFromIni;
var
  i: cardinal;
  LoadFrom, s: string;
begin
  fFileList.Clear;
  LoadFrom := extractfilepath(fIniFilename);
  if LoadFrom <> '' then
    LoadFrom := fIniFilename
  else if fIniFilename = '' then
    LoadFrom := changefileext(paramstr(0),'.ini') //use default ini filename
  else
    LoadFrom := ExtractfilePath(Paramstr(0))+ fIniFilename; //add a path

  if fileExists(LoadFrom) then
    with TIniFile.Create(LoadFrom) do
    try
      for i := 1 to fMaxFiles do
      begin
        s := readString('MRU List',inttostr(i),'');
        if s = '' then break;
        fFileList.Add(s);
      end;
    finally
      free;
    end;
  RefreshList;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.SaveFilesToReg;
var
  i: integer;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    if OpenKey(fRegPath, true) then
    begin
      for i := 1 to fMaxFiles do
        if i > fFileList.Count then
          writeString('MRU'+inttostr(i),'') else
          writeString('MRU'+inttostr(i),fFileList[i-1]);
      CloseKey;
    end;
  finally
    free;
  end;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.SaveFilesToIni;
var
  i: integer;
  SaveTo: string;
begin
  SaveTo := extractfilepath(fIniFilename);
  if SaveTo <> '' then
    SaveTo := fIniFilename
  else if fIniFilename = '' then
    SaveTo := changefileext(paramstr(0),'.ini') //use default ini filename
  else
    SaveTo := ExtractfilePath(Paramstr(0))+ fIniFilename;
    
  with TIniFile.Create(SaveTo) do
  try
    for i := 1 to fMaxFiles do
      if i > fFileList.Count then
        writeString('MRU List',inttostr(i),'') else
        writeString('MRU List',inttostr(i),fFileList[i-1]);
  finally
    free;
  end;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.SetRegPath(const aRegPath: string);
begin
  fRegPath := aRegPath;
  //if neither designing nor loading ...
  if [csDesigning, csLoading] * ComponentState = [] then
    if fRegPath = '' then
      LoadFilesFromIni else
      LoadFilesFromReg;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.SetIniFile(const aIniFile: string);
begin
  fIniFilename := aIniFile;
  //if neither designing nor loading ...
  if [csDesigning, csLoading] * ComponentState = [] then
    if fRegPath = '' then
      LoadFilesFromIni;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.SetOwnerMenu(aMenuItem: TMenuItem);
begin
  fOwnerMenuItem := aMenuItem;
  //if neither designing nor loading ...
  if [csDesigning, csLoading] * ComponentState = [] then
    RefreshList;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.SetMaxFiles(count: cardinal);
begin
  if count = fMaxFiles then exit;
  if count < 1 then fMaxFiles := 1
  else if count > 8 then fMaxFiles := 8
  else fMaxFiles := count;
  RefreshList;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.SetShowFullPath(value: boolean);
begin
  if value = fShowFullPath then exit;
  fShowFullPath := value;
  RefreshList;
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.RefreshList;
var
  i, menuPos: integer;

  procedure AddMRUMenuItem(index: integer; const Caption: string);
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create(fOwnerMenuItem);
    try
      NewItem.Caption := Caption;
      NewItem.Tag := MRU_FLAG;
      fOwnerMenuItem.Insert(index,NewItem);
      if Caption <> '-' then
        NewItem.OnClick := DoClick;
    except
      NewItem.Free;
      raise;
    end;
  end;

begin
  if (csDesigning in ComponentState) or not assigned(fOwnerMenuItem)  then exit;

  //remove all existing MRU items ...
  for i := fOwnerMenuItem.Count-1 downto 0 do
    if fOwnerMenuItem.Items[i].Tag = MRU_FLAG then fOwnerMenuItem.Delete(i);

  if (fFileList.Count = 0) then exit; //that's it

  if (integer(fMenuPosition) >= fOwnerMenuItem.Count) then
    menuPos := fOwnerMenuItem.Count else
    menuPos := fMenuPosition;

  //? add a preceeding separator item...
  if (menuPos > 0) and (fOwnerMenuItem.Items[menuPos-1].Caption <> '-') then
  begin
    AddMRUMenuItem(MenuPos,'-');
    inc(MenuPos);
  end;

  for i := 0 to fFileList.Count-1 do
  begin
    if fShowFullPath then
      AddMRUMenuItem(MenuPos, format('&%d  %s',[i+1,fFileList[i]])) else
      AddMRUMenuItem(MenuPos, format('&%d  %s',[i+1,extractFilename(fFileList[i])]));
    inc(MenuPos);
  end;

  //? add a trailing separator item...
  if (menuPos < fOwnerMenuItem.Count ) and
    (fOwnerMenuItem.Items[menuPos].Caption <> '-') then
      AddMRUMenuItem(MenuPos,'-');
end;
//------------------------------------------------------------------------------

procedure TMostRecentFiles.DoClick(Sender: TObject);
var
  i,idx: integer;
  ParentMenuItem: TMenuItem;
  s, filename: string;
begin
  if not (Sender is TMenuItem) or not assigned(fMRUClickEvent) then exit;
  ParentMenuItem := TMenuItem(Sender).Parent;
  if not assigned(ParentMenuItem) then exit;
  //get index of Sender menuItem within Parent's menuItem list
  idx := ParentMenuItem.IndexOf(TMenuItem(Sender));
  //find index of first item ...
  i := 0;
  while (i < ParentMenuItem.Count) and
    (ParentMenuItem.items[i].Tag <> MRU_FLAG) do inc(i);
  if (i = ParentMenuItem.Count) then exit; //should never happen
  if ParentMenuItem.items[i].Caption = '-' then inc(i); //skips the separator
  idx := idx -i; //this is the real index into fFileList
  if (idx < 0) or (idx >= fFileList.Count) then exit; //should never happen
  filename := fFileList[idx];
  if not fileExists(filename) then
  begin
    //no file so warn then delete it from the list ...
    if assigned(fNoFileEvent) then
      fNoFileEvent(sender, filename) //eg: may prefer just a simple beep
    else
    begin
      s := format(s_no_file_exists,[filename]);
      if assigned(Owner) and (Owner is TCustomForm) then
        MessageBox(TCustomForm(Owner).handle,
          pchar(s),pchar(application.title), mb_iconInformation)
      else
        MessageBox(0, pchar(s),pchar(application.title), mb_iconInformation);
    end;
    fFileList.Delete(idx);
    RefreshList;
  end else
  begin
    //update order before doing something ...
    if idx > 0 then
    begin
      fFileList.Delete(idx);
      fFileList.Insert(0,Filename);
      RefreshList;
    end;
    if assigned(fMRUClickEvent) then
      fMRUClickEvent(Sender, filename);
  end;
end;
//------------------------------------------------------------------------------

function TMostRecentFiles.AddFile(const Filename: string): boolean;
var
  i: integer;
begin
  result := false;
  if not assigned(fOwnerMenuItem) then exit;
  i := fFileList.IndexOf(Filename);
  if i = 0 then exit //already the first file in list
  else if i > 0 then fFileList.Delete(i);
  fFileList.Insert(0,Filename);
  while fFileList.count > integer(fMaxFiles) do fFileList.delete(fMaxFiles);
  RefreshList;
end;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

end.
