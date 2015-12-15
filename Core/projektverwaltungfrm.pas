unit projektverwaltungfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, ExtCtrls, ShellApi, gnugettext,
  pngimage, JvExControls, JvGradient;

type
  Tprojektverwaltung = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    TreeView1: TTreeView;
    PopupMenu1: TPopupMenu;
    Lschen1: TMenuItem;
    Unterverzeichniserstellen1: TMenuItem;
    Dateienhinzufgen1: TMenuItem;
    Umbenennen1: TMenuItem;
    N1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    Button2: TButton;
    Kopieren1: TMenuItem;
    Einfgen1: TMenuItem;
    Ausschneiden: TMenuItem;
    N2: TMenuItem;
    Label2: TLabel;
    DateiendemHauptverzeichnishinzufgen1: TMenuItem;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    Label16: TLabel;
    Label17: TLabel;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    CopyAbortBtn: TButton;
    ffnen1: TMenuItem;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Shape4: TShape;
    Shape1: TShape;
		procedure Einlesen(Tree : TTreeView; Verzeichnis : String; Eintrag : TTreeNode; Mit_Dateien : Boolean);
    procedure FormShow(Sender: TObject);
    procedure TreeView1GetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure TreeView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeView1Editing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure Umbenennen1Click(Sender: TObject);
    procedure Lschen1Click(Sender: TObject);
    procedure Dateienhinzufgen1Click(Sender: TObject);
    procedure Unterverzeichniserstellen1Click(Sender: TObject);
		function NodePath(node: TTreeNode): String;
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Kopieren1Click(Sender: TObject);
    procedure Einfgen1Click(Sender: TObject);
    procedure AusschneidenClick(Sender: TObject);
    procedure FWM_DropFiles(var Msg: TMessage); message WM_DROPFILES;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DateiendemHauptverzeichnishinzufgen1Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure CopyAbortBtnClick(Sender: TObject);
    procedure TreeView1DblClick(Sender: TObject);
    procedure ffnen1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure ProgressCopyFile(SourceFile,DestinationFile:String;FailIfExists:Boolean);
  public
    { Public-Deklarationen }
    OldNodeText:string;
    NewNodeText:string;
    FiletoCopy:string;
    copyorcut:boolean;
    CopiedBytes:Integer;
    FastCopyResult:Integer;
    CopyAbort:boolean;
  end;

var
  projektverwaltung: Tprojektverwaltung;

implementation

{$R *.dfm}

uses pcdimmer, progressscreen;

procedure Tprojektverwaltung.FWM_DropFiles(var Msg: TMessage);
var
	anzahl, size, i: integer;
  Dateiname: String;
begin
  inherited;
  Dateiname := '';
  anzahl := DragQueryFile(Msg.WParam, $FFFFFFFF, nil, 0);
  for i := 0 to (anzahl - 1) do
  begin
    size := DragQueryFile(Msg.WParam, i , nil, 0) + 1;
    SetLength(Dateiname, size);
    SetLength(Dateiname, DragQueryFile(Msg.WParam,i , @Dateiname[1], size));

    if TreeView1.Selected<>nil then
    begin
      if DirectoryExists(mainform.userdirectory+''+NodePath(TreeView1.Selected)) then
      begin
       	ProgressCopyFile(PChar(Dateiname),PChar(mainform.userdirectory+''+NodePath(TreeView1.Selected)+'\'+ExtractFileName(Dateiname)),True);
      end else if DirectoryExists(ExtractFilePath(mainform.userdirectory+''+NodePath(TreeView1.Selected))) then
  	  begin
      	ProgressCopyFile(PChar(Dateiname),PChar(ExtractFilePath(mainform.userdirectory+''+NodePath(TreeView1.Selected))+ExtractFileName(Dateiname)),True);
      end;
    end else
    begin
      ProgressCopyFile(PChar(Dateiname),PChar(mainform.userdirectory+''+ExtractFileName(Dateiname)),True);
    end;
  end;
  OnShow(nil);
  DragFinish(Msg.WParam);
end;

function Tprojektverwaltung.NodePath(node: TTreeNode): String;
begin
	if (Treeview1.Items.Count>0) then
  begin
	  Result := node.Text;
		try
		  if Assigned(node.Parent) then
		    Result := NodePath(node.Parent) + {'\' +} Result;
		except
		end;
  end;
end;

procedure Tprojektverwaltung.Einlesen(Tree : TTreeView; Verzeichnis : String; Eintrag : TTreeNode; Mit_Dateien : Boolean);
Var
SearchRec   : TSearchRec;
EintragTemp : TTreeNode;
begin
  Tree.Items.BeginUpdate;
  If Verzeichnis[length(Verzeichnis)]<>'\' then
    Verzeichnis:=Verzeichnis+'\';
  If FindFirst(Verzeichnis+ '*.*', faDirectory, SearchRec)=0 then
    begin
      repeat
        If (SearchRec.Attr and faDirectory = faDirectory) and (SearchRec.Name[1] <> '.') then
        begin
          //Eintrag ist ein Verzeichnis
          If (SearchRec.Attr and faDirectory > 0) then
          begin
            //zum aktuellen Eintrag hinzufügen
            Eintrag := Tree.Items.AddChild(Eintrag, SearchRec.Name+'\');
            Tree.Items.Item[Tree.Items.Count-1].ImageIndex:=1;
            Tree.Items.Item[Tree.Items.Count-1].SelectedIndex:=1;
          end;
          //Eintrag merken
          EintragTemp := Eintrag.Parent;
          //auf Untereinträge prüfen
          Einlesen(Tree,Verzeichnis + SearchRec.Name,Eintrag, True);
         //Eintrag wiederholen
          Eintrag := EintragTemp;
        end else
        begin
          //Eintrag ist eine Datei
          If Mit_Dateien then
            If SearchRec.Name[1] <> '.' then
            begin
              Tree.Items.AddChild(Eintrag, SearchRec.Name);
              if (copy(SearchRec.Name,length(SearchRec.Name)-6,3)='pcd') or (copy(SearchRec.Name,length(SearchRec.Name)-6,3)='PCD') then
	            begin
                Tree.Items.Item[Tree.Items.Count-1].ImageIndex:=31; // 31=PC_DIMMER Symbol
                Tree.Items.Item[Tree.Items.Count-1].SelectedIndex:=31; // 31=PC_DIMMER Symbol
              end else if (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='mp3') or (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='wav') or (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='mid') or
                          (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='MP3') or (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='WAV') or (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='MID') then
	            begin
                Tree.Items.Item[Tree.Items.Count-1].ImageIndex:=71; // 71=Musik-Symbol
                Tree.Items.Item[Tree.Items.Count-1].SelectedIndex:=71; // 71=Musik-Symbol
              end else if (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='jpg') or (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='bmp') or (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='gif') or (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='png') or
                          (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='JPG') or (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='BMP') or (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='GIF') or (copy(SearchRec.Name,length(SearchRec.Name)-2,3)='PNG') then
	            begin
                Tree.Items.Item[Tree.Items.Count-1].ImageIndex:=72; // 72=Bild-Symbol
                Tree.Items.Item[Tree.Items.Count-1].SelectedIndex:=72; // 72=Bild-Symbol
              end else
              begin
              	Tree.Items.Item[Tree.Items.Count-1].ImageIndex:=0; // 0=Dateisymbol
              	Tree.Items.Item[Tree.Items.Count-1].SelectedIndex:=0; // 0=Dateisymbol
              end;
        		end;
        end;
      until FindNext(SearchRec)<>0;
      FindClose(SearchRec);
    end;
    Tree.Items.EndUpdate;
end;

procedure Tprojektverwaltung.FormShow(Sender: TObject);
var
	i:integer;
  expanded:array of boolean;
begin
  If not DirectoryExists(mainform.userdirectory+'ProjectTemp') then
   	CreateDir(mainform.userdirectory+'ProjectTemp');

  setlength(expanded, TreeView1.Items.Count);
  for i:=0 to TreeView1.Items.Count-1 do
	  if TreeView1.Items.Item[i].Expanded then expanded[i]:=true else expanded[i]:=false;

  TreeView1.Items.Clear;
//  einlesen(TreeView1, mainform.userdirectory+'ProjectTemp\', nil, True);
  TreeView1.Items.AddChild(nil, 'ProjectTemp\');
  TreeView1.Items.Item[0].ImageIndex:=31; // 31=PC_DIMMER Symbol
  TreeView1.Items.Item[0].SelectedIndex:=31; // 31=PC_DIMMER Symbol
  einlesen(TreeView1, mainform.userdirectory+'ProjectTemp\', TreeView1.Items[0], True);

  setlength(expanded, TreeView1.Items.Count);
  for i:=0 to TreeView1.Items.Count-1 do
	  if expanded[i] then TreeView1.Items.Item[i].Expanded:=true else TreeView1.Items.Item[i].Expanded:=false;

  Label4.Caption:='wird ermittelt...';
  Label4.Refresh;
  Label4.Caption:=FloatToStrf(mainform.GetDirSize(mainform.userdirectory+'ProjectTemp', True) / 1048576, ffGeneral , 4, 2) + ' MB';
  TreeView1.Items[0].Expand(false);
  TreeView1.Select(Treeview1.Items[0]);

  if mainform.autoinsertcomputerusername then
    mainform.projektbearbeiter:=mainform.JvComputerInfoEx1.Identification.LocalUserName;

  Edit1.Text:=mainform.projekttitel;
  Edit2.Text:=mainform.projektversion;
  Edit3.Text:=mainform.projektbearbeiter;
  label1.caption:=mainform.userdirectory+'ProjectTemp\';
  label9.caption:=mainform.projektprogrammversion;
  label11.Caption:=mainform.projektdatum;
  label14.Caption:=mainform.projektuhrzeit;
  Label13.Caption:=mainform.projektspeicheranzahl;
  CheckBox1.Checked:=mainform.autoinsertcomputerusername;
  Label17.caption:=ExtractFilepath(mainform.project_file);
end;

procedure Tprojektverwaltung.TreeView1GetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.IsFirstNode then
    Node.Text:='ProjectTemp\';
 	NewNodeText:=Node.Text;
end;

procedure Tprojektverwaltung.TreeView1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Treeview1.SelectionCount=0) and (Treeview1.Items.Count>0) then Treeview1.Items.Item[0].Selected:=true;
  Label1.Caption:=ExtractFilePath(mainform.userdirectory+''+NodePath(Treeview1.Selected));

	if Key=vk_return then
  begin
 	  RenameFile(mainform.userdirectory+''+OldNodeText,mainform.userdirectory+''+NewNodeText);
  end;
  if Key=vk_f2 then
  begin
    TreeView1.Selected.Text:=inputbox(_('Datei umbenennen'),_('Bitte geben eine neue Bezeichnung für das Objekt ein:'),TreeView1.Selected.Text);
	  RenameFile(mainform.userdirectory+''+OldNodeText,mainform.userdirectory+''+NewNodeText);
  end;
end;

procedure Tprojektverwaltung.TreeView1Editing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
 	OldNodeText:=Node.Text;
end;

procedure Tprojektverwaltung.Umbenennen1Click(Sender: TObject);
var
	oldfilename,newfilename:string;
begin
  if (Treeview1.Items.Count>0) then
  begin
		oldfilename:=NodePath(TreeView1.Selected);
		newfilename:=ExtractFilePath(NodePath(TreeView1.Selected))+InputBox(_('Umbenennen...'),_('Bitte geben Sie eine neue Bezeichnung ein:'),ExtractFileName(oldfilename));
	  TreeView1.Selected.Text:=newfilename;
	  RenameFile(mainform.userdirectory+''+oldfilename,mainform.userdirectory+''+newfilename);
		OnShow(nil);
  end;
end;

procedure Tprojektverwaltung.Lschen1Click(Sender: TObject);
var
	i:integer;
begin
  if (Treeview1.Items.Count>0) then
  begin
  if treeview1.SelectionCount>1 then
  begin
		if messagedlg(_('Alle markierten Elemente löschen?'),mtConfirmation,
	  	[mbYes,mbNo],0)=mrYes then
  	for i:=0 to treeview1.SelectionCount-1 do
    begin
      if DirectoryExists(mainform.userdirectory+''+NodePath(treeview1.Selections[i])) then
      begin
        mainform.DeleteDirectory(mainform.userdirectory+''+NodePath(treeview1.Selections[i]));
//        mainform.DeleteDir(mainform.userdirectory+''+NodePath(treeview1.Selections[i]));
      end else
    	begin
	    	DeleteFile(mainform.userdirectory+''+NodePath(treeview1.Selections[i]));
	    end;
    end;
		OnShow(nil);
  end else
  begin
    if DirectoryExists(mainform.userdirectory+''+NodePath(treeview1.Selected)) then
    begin
			if messagedlg(_('Das Verzeichnis "')+TreeView1.Selected.Text+_('" wirklich löschen?'),mtConfirmation,
		  	[mbYes,mbNo],0)=mrYes then
		  	begin
          mainform.DeleteDirectory(mainform.userdirectory+''+NodePath(TreeView1.Selected));
//        	mainform.DeleteDir(mainform.userdirectory+''+NodePath(TreeView1.Selected));
          TreeView1.Items.Delete(TreeView1.Selected);
        end;
    end else
    begin
			if messagedlg(_('Die Datei "')+TreeView1.Selected.Text+_('" wirklich löschen?'),mtConfirmation,
		  	[mbYes,mbNo],0)=mrYes then
		  	begin
		  		DeleteFile(mainform.userdirectory+''+NodePath(TreeView1.Selected));
          TreeView1.Items.Delete(TreeView1.Selected);
        end;
    end;
  end;
  end;
  FormShow(nil);
end;

procedure Tprojektverwaltung.Dateienhinzufgen1Click(Sender: TObject);
var
	i:integer;
begin
	if OpenDialog1.Execute then
  begin
    inprogress.label8.Caption:=_(' Kopiere Dateien ins Projektverzeichnis... ');
    application.processmessages;
    inprogress.Show;
    inprogress.ProgressBar2.max:=OpenDialog1.Files.Count;

  	for i:=0 to OpenDialog1.Files.Count-1 do
    begin
      inprogress.filename.Caption:=_('Kopiere: ')+ExtractFileName(OpenDialog1.Files[i]);
      inprogress.ProgressBar2.Position:=inprogress.ProgressBar2.Position+1;
      // Vista Progressbar Workaround
      if mainform.windowsmajorversion>=6 then
      begin
        inprogress.ProgressBar2.Position:=inprogress.ProgressBar2.Position-1;
        inprogress.ProgressBar2.Position:=inprogress.ProgressBar2.Position+1;
      end;
      inprogress.Label1.Caption:=_('Datei (')+inttostr(inprogress.ProgressBar2.Position)+'/'+inttostr(OpenDialog1.Files.Count)+')';
      inprogress.Label1.Refresh;
      inprogress.filename.Refresh;

      if DirectoryExists(mainform.userdirectory+''+NodePath(TreeView1.Selected)) then
	    	ProgressCopyFile(PChar(OpenDialog1.Files[i]),PChar(mainform.userdirectory+''+NodePath(TreeView1.Selected)+'\'+ExtractFileName(OpenDialog1.Files[i])),True)
      else if DirectoryExists(ExtractFilePath(mainform.userdirectory+''+NodePath(TreeView1.Selected))) then
	    	ProgressCopyFile(PChar(OpenDialog1.Files[i]),PChar(ExtractFilePath(mainform.userdirectory+''+NodePath(TreeView1.Selected))+ExtractFileName(OpenDialog1.Files[i])),True);
    end;
    inprogress.Hide;
		OnShow(nil);
  end;
end;

procedure Tprojektverwaltung.Unterverzeichniserstellen1Click(
  Sender: TObject);
var
	newdir:string;
begin
	newdir:=InputBox(_('Neues Verzeichnis erstellen...'),_('Bitte geben Sie eine Bezeichnung für das neue Verzeichnis ein:'),'');
  if DirectoryExists(mainform.userdirectory+''+NodePath(TreeView1.Selected)) then
    CreateDir(mainform.userdirectory+''+NodePath(TreeView1.Selected)+'\'+newdir+'\')
	else
    CreateDir(mainform.userdirectory+''+ExtractFilePath(NodePath(TreeView1.Selected))+'\'+newdir+'\');
	OnShow(nil);
end;

procedure Tprojektverwaltung.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Treeview1.SelectionCount=0) and (Treeview1.Items.Count>0) then Treeview1.Items.Item[0].Selected:=true;
  Label1.Caption:=ExtractFilePath(mainform.userdirectory+''+NodePath(Treeview1.Selected));
end;

procedure Tprojektverwaltung.AusschneidenClick(Sender: TObject);
begin
	FileToCopy:=mainform.userdirectory+''+NodePath(TreeView1.Selected);
  Einfgen1.Enabled:=true;
  copyorcut:=false;
end;

procedure Tprojektverwaltung.Kopieren1Click(Sender: TObject);
begin
	FileToCopy:=mainform.userdirectory+''+NodePath(TreeView1.Selected);
  Einfgen1.Enabled:=true;
  copyorcut:=true;
end;

procedure Tprojektverwaltung.Einfgen1Click(Sender: TObject);
var
	dest:string;
begin
  if DirectoryExists(mainform.userdirectory+''+NodePath(treeview1.Selected)) then
  	dest:=mainform.userdirectory+''+NodePath(treeview1.Selected)
  else
    dest:=mainform.userdirectory+''+ExtractFilePath(NodePath(treeview1.Selected));

  if copyorcut=true then
		ProgressCopyFile(PChar(FileToCopy),PChar(dest+'\'+ExtractFileName(FileToCopy)),True)
  else
		MoveFile(PChar(FileToCopy),PChar(dest+'\'+ExtractFileName(FileToCopy)));
  Einfgen1.Enabled:=false;
	OnShow(nil);
end;

procedure Tprojektverwaltung.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  DragAcceptFiles(projektverwaltung.Handle, True);
end;

procedure Tprojektverwaltung.Button1Click(Sender: TObject);
begin
  mainform.projekttitel:=Edit1.Text;
  mainform.projektversion:=Edit2.Text;
  mainform.projektbearbeiter:=Edit3.Text;
  projektverwaltung.Hide;
end;

procedure Tprojektverwaltung.DateiendemHauptverzeichnishinzufgen1Click(
  Sender: TObject);
var
	i:integer;
begin
	if OpenDialog1.Execute then
  begin
    inprogress.label8.Caption:=_(' Kopiere Dateien ins Projektverzeichnis... ');
    application.processmessages;
    inprogress.Show;
    inprogress.ProgressBar2.max:=OpenDialog1.Files.Count;

  	for i:=0 to OpenDialog1.Files.Count-1 do
    begin
      inprogress.filename.Caption:=_('Kopiere: ')+ExtractFileName(OpenDialog1.Files[i]);
      inprogress.ProgressBar2.Position:=inprogress.ProgressBar2.Position+1;
      // Vista Progressbar Workaround
      if mainform.windowsmajorversion>=6 then
      begin
        inprogress.ProgressBar2.Position:=inprogress.ProgressBar2.Position-1;
        inprogress.ProgressBar2.Position:=inprogress.ProgressBar2.Position+1;
      end;
      inprogress.Label1.Caption:=_('Datei (')+inttostr(inprogress.ProgressBar2.Position)+'/'+inttostr(OpenDialog1.Files.Count)+')';
      inprogress.Label1.Refresh;
      inprogress.filename.Refresh;

     	ProgressCopyFile(PChar(OpenDialog1.Files[i]),PChar(mainform.userdirectory+'ProjectTemp\'+ExtractFileName(OpenDialog1.Files[i])),True);
    end;
    inprogress.Hide;
		OnShow(nil);
  end;
end;

procedure Tprojektverwaltung.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);

  if mainform.ShowButtonInTaskbar then
  begin
    Params.ExStyle:=WS_EX_APPWINDOW; // Params.ExStyle sorgt dafür, dass das Form einen eigenen Taskbareintrag erhält
    if mainform.ShowIconInTaskSwitcher then
    begin
      Params.WndParent:=GetDesktopWindow;
      self.ParentWindow := GetDesktopWindow;
    end;
  end;
end;

procedure Tprojektverwaltung.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edit3.text:=mainform.JvComputerInfoEx1.Identification.LocalUserName;
end;

procedure Tprojektverwaltung.ProgressCopyFile(SourceFile,DestinationFile:String;FailIfExists:Boolean);
const
  BufferSize = 32768;
var
  Sou,Des:file;
  Buffer:Array[1..BufferSize] of Byte;
  NumRead, NumSave:Integer;
begin
  Timer1.Enabled:=true;
  ProgressBar1.Visible:=true;
  Progressbar1.Max:=Mainform.GetFileSize2(SourceFile);
  CopyAbortBtn.Visible:=true;

  CopyAbort:=false;
  CopiedBytes:=0;

  If FailIfExists and FileExists(DestinationFile) then exit;

  AssignFile(Sou,SourceFile); {$I-} reset(Sou,1); {$I+}
  FastCopyResult:=IOresult;
  if FastCopyResult<>0 then exit;

  AssignFile(Des,DestinationFile); {$I-} rewrite(Des,1); {$I+}
  FastCopyResult:=IOresult;
  if FastCopyResult<>0 then exit;

  repeat
    BlockRead (Sou,Buffer,SizeOf(Buffer),NumRead);
    BlockWrite(Des,Buffer,NumRead,       NumSave);
    inc(CopiedBytes,NumSave);
    Application.ProcessMessages;
  until (NumRead=0) or (NumSave<>NumRead) or (CopyAbort);
  
  CopyAbortBtn.Visible:=false;
  Timer1.Enabled:=false;

  CloseFile(Sou);
  CloseFile(Des);

  if CopyAbort then
    Erase(Des);

  ProgressBar1.Visible:=false;
end;

procedure Tprojektverwaltung.Timer1Timer(Sender: TObject);
begin
  ProgressBar1.Position:=CopiedBytes;
end;

procedure Tprojektverwaltung.CopyAbortBtnClick(Sender: TObject);
begin
  CopyAbort:=true;
end;

procedure Tprojektverwaltung.TreeView1DblClick(Sender: TObject);
begin
  shellexecute(application.handle,'open',PChar(mainform.userdirectory+''+NodePath(TreeView1.Selected)),'',PChar(ExtractFilePath(mainform.userdirectory+''+NodePath(TreeView1.Selected))),SW_SHOWNORMAL);
end;

procedure Tprojektverwaltung.ffnen1Click(Sender: TObject);
begin
  shellexecute(application.handle,'open',PChar(mainform.userdirectory+''+NodePath(TreeView1.Selected)),'',PChar(ExtractFilePath(mainform.userdirectory+''+NodePath(TreeView1.Selected))),SW_SHOWNORMAL);
end;

end.
