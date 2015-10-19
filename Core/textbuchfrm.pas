unit textbuchfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, JvRichEditToHtml, JvComponentBase, IdComponent,
  JvHtmlParser, HTMLLite, OleCtrls, MSHTML, JvExStdCtrls,
  JvCombobox, JvColorCombo, ExtCtrls, ImgList, PngImageList, TB2Item,
  TB2Dock, TB2Toolbar, szenenverwaltung, syncobjs, URLSubs,IdHTTP, ToolWin,
  Menus, Registry, SHDocVw, gnugettext;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: integer; // 0 Einfache Szenen, 1 Geräteszenen, 2 Audioszenen, 3 Bewegungsszenen, 4 Befehle, 5 Kombinationsszenen, 6 Presets, 7 Automatikszenen, 8 Effekt, 9 MediaCenter Szenen
    IsRootNode:boolean;
    IsCatNode:boolean;
    Caption:WideString;
    Beschreibung:WideString;
    Fadetime:WideString;
    ID:TGUID;
  end;

  Ttextbuchform = class(TForm)
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    btnSave: TTBItem;
    btnOpen: TTBItem;
    btnUnderline: TTBItem;
    btnItalic: TTBItem;
    btnBold: TTBItem;
    PngImageList1: TPngImageList;
    btnStartScene: TTBItem;
    btnRight: TTBItem;
    btnCenter: TTBItem;
    btnLeft: TTBItem;
    Timer1: TTimer;
    TBToolbar2: TTBToolbar;
    TBControlItem2: TTBControlItem;
    ColorBox1: TColorBox;
    TBControlItem3: TTBControlItem;
    ColorBox2: TColorBox;
    TBSeparatorItem1: TTBSeparatorItem;
    TBSeparatorItem2: TTBSeparatorItem;
    TBControlItem1: TTBControlItem;
    FontBox: TJvFontComboBox;
    TBItem4: TTBItem;
    TBItem5: TTBItem;
    TBSeparatorItem3: TTBSeparatorItem;
    TBControlItem4: TTBControlItem;
    ComboBox1: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    WebBrowser1: TWebBrowser;
    Panel1: TPanel;
    htmlLite1: ThtmlLite;
    Splitter1: TSplitter;
    TBSeparatorItem4: TTBSeparatorItem;
    Splitter2: TSplitter;
    TBSubmenuItem3: TTBSubmenuItem;
    btnStopScene: TTBItem;
    OpenDialog1: TOpenDialog;
    btnNew: TTBItem;
    btnEdit: TTBItem;
    htmlLite2: ThtmlLite;
    SaveDialog1: TSaveDialog;
    Memo1: TMemo;
    PopupMenu1: TPopupMenu;
    extbuchffnen1: TMenuItem;
    TBDock2: TTBDock;
    TBToolbar3: TTBToolbar;
    TBItem1: TTBItem;
    procedure htmlLite1HotSpotClick(Sender: TObject; const SRC: String;
      var Handled: Boolean);
    procedure btnBoldClick(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure btnItalicClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnCenterClick(Sender: TObject);
    procedure btnUnderlineClick(Sender: TObject);
    procedure FontBoxChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnUnlinkClick(Sender: TObject);
    procedure btnLinkClick(Sender: TObject);
    procedure ColorBox1Select(Sender: TObject);
    procedure ColorBox2Select(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnStartSceneClick(Sender: TObject);
    procedure WebBrowser1NavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure FormHide(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnOpenReadClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private-Deklarationen }
    HTMLDocument2Ifc:IHTMLDocument2;
  public
    { Public-Deklarationen }
    TextbuchFile:string[255];
    function ColorToHTML(AColor : TColor) : string;
    procedure MSGNew;
    procedure MSGOpen(textbuchfile: string);
  end;

var
  textbuchform: Ttextbuchform;

implementation

uses PCDIMMER;

{$R *.dfm}

function Ttextbuchform.ColorToHTML(AColor : TColor) : string;
var
  r, g, b: Byte;
  RGB:integer;
begin
  RGB:=ColorToRGB(aColor);
  R:=GetRValue(RGB);
  G:=GetGValue(RGB);
  B:=GetBValue(RGB);
  result:= '#'+IntToHex(r, 2)+IntToHex(g, 2)+IntToHex(b, 2);
end;

procedure Ttextbuchform.htmlLite1HotSpotClick(Sender: TObject;
  const SRC: String; var Handled: Boolean);
var
  befehl:string;
  GUID:TGUID;
begin
  befehl:=copy(src,0,pos(':',src)-1);

  if lowercase(befehl)='start' then
  begin
    GUID:=StringToGUID(copy(src,pos(':',src)+1,length(src)));
    mainform.StartScene(GUID,false,false,-1);
  end else if lowercase(befehl)='stop' then
  begin
    GUID:=StringToGUID(copy(src,pos(':',src)+1,length(src)));
    mainform.StopScene(GUID);
  end else if (lowercase(befehl)='http') or (lowercase(befehl)='file') then
  begin
    case pagecontrol1.ActivePageIndex of
      0:
      begin
        htmllite2.LoadFromFile(src);
      end;
      1:
      begin
        webbrowser1.Navigate(src);
      end;
    end;
  end;

  handled:=true;
end;

procedure Ttextbuchform.btnBoldClick(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('Bold', False, 0);
end;

procedure Ttextbuchform.ComboBox1Select(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('FontSize', False, Combobox1.ItemIndex+1);
end;

procedure Ttextbuchform.btnItalicClick(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('Italic', False, 0);
end;

procedure Ttextbuchform.btnLeftClick(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('JustifyLeft', False, 0);
end;

procedure Ttextbuchform.btnRightClick(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('JustifyRight', False, 0);
end;

procedure Ttextbuchform.btnCenterClick(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('JustifyCenter', False, 0);
end;

procedure Ttextbuchform.btnUnderlineClick(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('Underline', False, 0);
end;

procedure Ttextbuchform.FontBoxChange(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('FontName', False, FontBox.FontName);
end;

procedure Ttextbuchform.btnSaveClick(Sender: TObject);
begin
//  HTMLDocument2Ifc.execCommand('saveas', True, 0);
  //(WebBrowser.Document as IPersistFile).Load('c:\test.html', 0);
  //(WebBrowser.Document as IPersistFile).Save('c:\test.html', True);

  if SaveDialog1.Execute then
  begin
    memo1.Lines.SaveToFile(savedialog1.FileName);
  end;
end;

procedure Ttextbuchform.btnUnlinkClick(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('Unlink', False, 0);
end;

procedure Ttextbuchform.btnLinkClick(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('HyperLink', True, 'file:///c/test.html');
end;

procedure Ttextbuchform.ColorBox1Select(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('ForeColor', False, ColorToHTML(colorbox1.Selected));
end;

procedure Ttextbuchform.ColorBox2Select(Sender: TObject);
begin
  HTMLDocument2Ifc.execCommand('BackColor', False, ColorToHTML(colorbox2.Selected));
end;

procedure Ttextbuchform.Timer1Timer(Sender: TObject);
begin
  if (HTMLDocument2Ifc<>nil) then
  begin
    if HTMLDocument2Ifc.queryCommandSupported('Bold') and HTMLDocument2Ifc.queryCommandEnabled('Bold') then
      btnBold.Checked:=HTMLDocument2Ifc.queryCommandValue('Bold');

    if HTMLDocument2Ifc.queryCommandSupported('Italic') and HTMLDocument2Ifc.queryCommandEnabled('Italic') then
      btnItalic.Checked:=HTMLDocument2Ifc.queryCommandValue('Italic');

    if HTMLDocument2Ifc.queryCommandSupported('Underline') and HTMLDocument2Ifc.queryCommandEnabled('Underline') then
      btnUnderline.Checked:=HTMLDocument2Ifc.queryCommandValue('Underline');

    if HTMLDocument2Ifc.queryCommandSupported('FontSize') and HTMLDocument2Ifc.queryCommandEnabled('FontSize') and (not Combobox1.Focused) and (not Combobox1.DroppedDown) then
      Combobox1.ItemIndex:=HTMLDocument2Ifc.queryCommandValue('FontSize');

    if HTMLDocument2Ifc.queryCommandSupported('FontName') and HTMLDocument2Ifc.queryCommandEnabled('FontName') and (not FontBox.Focused) and (not FontBox.DroppedDown) and (HTMLDocument2Ifc.queryCommandValue('FontName')<>'') then
      FontBox.FontName:=HTMLDocument2Ifc.queryCommandValue('FontName');

    if not memo1.Focused then
      memo1.text:=HTMLDocument2Ifc.body.innerHTML;

    btnEdit.Checked:=HTMLDocument2Ifc.designMode='On';

    htmllite1.LoadFromString(HTMLDocument2Ifc.body.innerHTML,'');
  end;
end;

procedure Ttextbuchform.btnOpenClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    WebBrowser1.Navigate(OpenDialog1.FileName);
  end;
end;

procedure Ttextbuchform.btnStartSceneClick(Sender: TObject);
var
  szenenname:string;
  szenenguid:tguid;
  SzenenData:PTreeData;
begin
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

//  if szenenverwaltungform.showmodal=mrOK then
  if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
  begin
    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
    SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

    szenenname:=mainform.GetSceneInfo2(SzenenData^.ID,'name');
    szenenguid:=SzenenData^.ID;

//    HTMLDocument2Ifc.body.insertAdjacentHTML('afterBegin','<a href="start:'+GUIDtoString(szenenguid)+'">'+szenenname+'</a>');
    if Sender=btnStartScene then
      Webbrowser1.OleObject.Document.Selection.createRange.pasteHTML('<a href="start:'+GUIDtoString(szenenguid)+'">'+szenenname+'</a>')
    else if Sender=btnStopScene then
      Webbrowser1.OleObject.Document.Selection.createRange.pasteHTML('<a href="stop:'+GUIDtoString(szenenguid)+'">'+szenenname+'</a>');
  end;

  szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
end;

procedure Ttextbuchform.WebBrowser1NavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  HTMLDocument2Ifc := WebBrowser1.Document as IHTMLDocument2;
  HTMLDocument2IFC.designMode:='On';
end;

procedure Ttextbuchform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  Timer1.enabled:=false;

	if not mainform.shutdown then
  begin
	  LReg := TRegistry.Create;
	  LReg.RootKey:=HKEY_CURRENT_USER;

	  if LReg.OpenKey('Software', True) then
	  begin
	    if not LReg.KeyExists('PHOENIXstudios') then
	      LReg.CreateKey('PHOENIXstudios');
	    if LReg.OpenKey('PHOENIXstudios',true) then
	    begin
	      if not LReg.KeyExists('PC_DIMMER') then
	        LReg.CreateKey('PC_DIMMER');
	      if LReg.OpenKey('PC_DIMMER',true) then
	      begin
					LReg.WriteBool('Showing Textbuch',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;
  mainform.SaveWindowPositions('textbuch');
end;

procedure Ttextbuchform.btnNewClick(Sender: TObject);
begin
  Webbrowser1.Navigate('about:blank');
//  HTMLDocument2Ifc := WebBrowser1.Document as IHTMLDocument2;
//  HTMLDocument2Ifc.designMode:='On';
  HTMLDocument2Ifc:=nil;
end;

procedure Ttextbuchform.MSGNew;
begin
  Webbrowser1.Navigate('about:blank');
  HTMLDocument2Ifc:=nil;
end;

procedure Ttextbuchform.btnEditClick(Sender: TObject);
begin
  if HTMLDocument2Ifc.designMode='On' then
    HTMLDocument2Ifc.designMode:='Off'
  else
    HTMLDocument2Ifc.designMode:='On';
end;

procedure Ttextbuchform.PageControl1Change(Sender: TObject);
begin
  Timer1.enabled:=(PageControl1.ActivePageIndex=1);
end;

procedure Ttextbuchform.btnOpenReadClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    TextbuchFile:=OpenDialog1.FileName;
    MSGOpen(TextbuchFile);
  end;
end;

procedure Ttextbuchform.Memo1Change(Sender: TObject);
begin
  if (HTMLDocument2Ifc<>nil) and memo1.Focused then
  begin
    HTMLDocument2Ifc.body.innerHTML:=memo1.text;
  end;
end;

procedure Ttextbuchform.CreateParams(var Params:TCreateParams);
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

procedure Ttextbuchform.FormShow(Sender: TObject);
var
	LReg:TRegistry;
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
  			LReg.WriteBool('Showing Textbuch',true);

        if not LReg.KeyExists('Textbuch') then
	        LReg.CreateKey('Textbuch');
	      if LReg.OpenKey('Textbuch',true) then
	      begin
            if LReg.ValueExists('Width') then
              Textbuchform.ClientWidth:=LReg.ReadInteger('Width')
            else
              Textbuchform.ClientWidth:=825;
            if LReg.ValueExists('Height') then
              Textbuchform.ClientHeight:=LReg.ReadInteger('Height')
            else
              Textbuchform.ClientHeight:=411;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+Textbuchform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              Textbuchform.Left:=LReg.ReadInteger('PosX')
            else
              Textbuchform.Left:=0;
          end else
            Textbuchform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+Textbuchform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              Textbuchform.Top:=LReg.ReadInteger('PosY')
            else
              Textbuchform.Top:=0;
          end else
            Textbuchform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Ttextbuchform.MSGOpen(textbuchfile: string);
begin
  if fileexists(mainform.SearchFileBeneathProject(textbuchfile)) then
    htmllite2.loadfromfile(mainform.SearchFileBeneathProject(textbuchfile));
end;

procedure Ttextbuchform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Ttextbuchform.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Ttextbuchform.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

end.
