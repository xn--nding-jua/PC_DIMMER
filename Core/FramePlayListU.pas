{******************************************************************************}
{                                                                              }
{ Version 2.4 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit FramePlayListU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, FileCtrl, 
  PlaylistU, InterpretU, LiedU, BassTypenU;

type
  TFramePlayList = class(TFrame)
    Panel3: TPanel;
    BtnLaden: TButton;
    BtnSpeichern: TButton;
    BtnAddDatei: TButton;
    BtnAddVerzeichnis: TButton;
    TvPlaylist: TTreeView;
    BtnSpeichernUnter: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    procedure BtnAddVerzeichnisClick(Sender: TObject);
    procedure BtnAddDateiClick(Sender: TObject);
    procedure BtnSpeichernClick(Sender: TObject);
    procedure BtnSpeichernUnterClick(Sender: TObject);
    procedure BtnLadenClick(Sender: TObject);
    procedure TvPlaylistCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure TvPlaylistDblClick(Sender: TObject);
  private
    { Private-Deklarationen }
    _PlayList:TPlaylist;
    _LiedToChannelEvent:TGetLiedEvent;
    _M3Uname:string;
    function GetGetLiedEvent: TGetLiedEvent;
    function GetGetFileEvent: TGetFileEvent;
  public
    { Public-Deklarationen }
    constructor create(AOwner:TComponent); override;
    destructor destroy; override;
    property GetLiedEvent:TGetLiedEvent
      read GetGetLiedEvent;
    property GetFileEvent:TGetFileEvent
      read GetGetFileEvent;
    property LiedToChannelEvent:TGetLiedEvent
      read _LiedToChannelEvent write _LiedToChannelEvent;
  end;

implementation

{$R *.dfm}

constructor TFramePlayList.create(AOwner: TComponent);
begin
  inherited create(AOwner);
  _PlayList:=TPlaylist.create;
  _M3Uname:='';
end;

destructor TFramePlayList.destroy;
begin
  _PlayList.free;
  inherited;
end;

procedure TFramePlayList.BtnAddVerzeichnisClick(Sender: TObject);

  procedure Verzeichnisse(path:string; Liste:TStrings);
  var SR:TSearchRec;
  begin
    if FindFirst(path+'*.*', faDirectory, SR) = 0 then begin
      repeat
        Application.ProcessMessages;
        if (SR.Name <> '.') and (SR.Name <> '..') then begin
          if (SR.Attr and faDirectory) = faDirectory then
            Verzeichnisse(path+SR.Name+'\', Liste)
          else
            Liste.Append(path+SR.Name);
        end;
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;
  end;

var Verzeichnis:String;
    Liste:TStringList;
    i:integer;
begin
  SelectDirectory('', '', Verzeichnis);
  if Verzeichnis <> '' then begin
    Liste:=TStringList.create;
    try
      Verzeichnisse(IncludeTrailingPathDelimiter(Verzeichnis), Liste);
      for i:=1 to Liste.Count do
        _PlayList.addDatei(Liste[i-1], '');
      _PlayList.GetTree(TvPlaylist);
    finally
      Liste.free;
    end;
  end;
  TvPlaylist.SetFocus;
end;

procedure TFramePlayList.BtnAddDateiClick(Sender: TObject);
var i:integer;
    Fenster:TOpenDialog;
begin
  Fenster:=TOpenDialog.create(nil);
  try
    Fenster.Options:=Fenster.Options + [ofAllowMultiSelect];
    Fenster.Filter:='MP3, WAV|*.mp3;*.wav';
    Fenster.FileName:='';
    if Fenster.Execute then begin
      for i:=1 to Fenster.Files.count do
        _PlayList.addDatei(Fenster.Files[i-1], '');
      _PlayList.GetTree(TvPlaylist);
    end;
  finally
    Fenster.free;
  end;
  TvPlaylist.SetFocus;
end;

procedure TFramePlayList.BtnSpeichernClick(Sender: TObject);
begin
  if _M3Uname = '' then
    BtnSpeichernUnterClick(nil);
  if _M3Uname <> '' then
    _PlayList.speichern(_M3Uname);
end;

procedure TFramePlayList.BtnSpeichernUnterClick(Sender: TObject);
begin
  SaveDialog.InitialDir:=ExtractFilePath(Application.ExeName);
  SaveDialog.Filter:='M3U Playlist|*.M3U';
  if SaveDialog.Execute then begin
    _M3Uname:=SaveDialog.Filename;
    _PlayList.speichern(_M3Uname);
  end;
end;

procedure TFramePlayList.BtnLadenClick(Sender: TObject);
begin
  OpenDialog.InitialDir:=ExtractFilePath(Application.ExeName);
  OpenDialog.Filter:='M3U Playlist|*.M3U';
  OpenDialog.FileName:='';
  if OpenDialog.Execute then begin
    _M3Uname:=OpenDialog.Filename;
    if _PlayList.laden(_M3Uname) then
      _PlayList.GetTree(TvPlaylist)
    else
      MessageDlg('Fehler beim Einlesen der Playlist', mtError, [mbOK], 0);
  end;
end;

procedure TFramePlayList.TvPlaylistCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var Typ:TObject;
begin
  Typ:=Node.Data;
  if Typ is TLied then
    Node.Text:=TLied(Typ).Bezeichnung
  else if Typ is TInterpret then
    Node.Text:=TInterpret(Typ).Bezeichnung;
end;

procedure TFramePlayList.TvPlaylistDblClick(Sender: TObject);
var Typ:TObject;
begin
  if assigned(TvPlaylist.Selected) then begin
    Typ:=TvPlaylist.Selected.Data;
    if Typ is TLied then begin
      _LiedToChannelEvent(TLied(Typ));
      TvPlaylist.Refresh;
    end;
  end;
end;

function TFramePlayList.GetGetFileEvent: TGetFileEvent;
begin
  if assigned(_PlayList) then
    Result:=_PlayList.GetFileEvent
  else
    Result:=nil;
end;

function TFramePlayList.GetGetLiedEvent: TGetLiedEvent;
begin
  if assigned(_PlayList) then
    Result:=_PlayList.GetLiedEvent
  else
    Result:=nil;
end;

end.
