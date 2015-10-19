unit UpdateFoundForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, InternetUpdate, ComCtrls, ExtCtrls, ImgList,
  JvAnimatedImage, JvGIFCtrl, JvExControls, JvGradient, pngimage, gnugettext;

type
  TfrmInternetUpdateFound = class(TForm)
    LV: TListView;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    ImageList1: TImageList;
    lblHeader: TLabel;
    Button1: TButton;
    Button2: TButton;
    memDetails: TMemo;
    Panel3: TPanel;
    JvGradient1: TJvGradient;
    Label34: TLabel;
    Label35: TLabel;
    Image2: TImage;
    procedure LVClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LVSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure LVChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private declarations }
    FInfo : TDownloadInfo ;
    procedure ShowItem(Index: integer);
  public
    { Public declarations }
    function Execute (AInternetUpdate : TInternetUpdate) : boolean ;
  end;

implementation

uses PCDIMMER;

{$R *.dfm}

{ TfrmNewVersionFound }

function TfrmInternetUpdateFound.Execute (AInternetUpdate : TInternetUpdate) : boolean ;
var
 LI : TListItem ;
 i : integer ;
begin
     FInfo := AInternetUpdate.Download ;
//     caption := Format(caption,[AInternetUpdate.ProjectCode]) ;
//     lblHeader.caption := Format(lblHeader.caption,[AInternetUpdate.ProjectCode]) ;

     for i := 0 to FInfo.WhatsNew.count-1 do begin
        LI := LV.Items.Add ;
        LI.ImageIndex := 0 ;
        LI.Caption := FInfo.WhatsNew[i] ;
     end ;

     Showmodal ;

     Result := ModalResult = mrYes ;
end;


procedure TfrmInternetUpdateFound.LVClick(Sender: TObject);
var
 ind : integer ;
begin
     try
        ind := LV.ItemIndex ;
        ShowItem (ind) ;
     except
     end ;
end;

procedure TfrmInternetUpdateFound.ShowItem (Index : integer) ;
begin
     if (index <> -1) and (index <= FInfo.WhatsNew.count-1) then begin
        memDetails.Lines.Text := FInfo.Description[Index] ;
        //html.LoadFromString (FInfo.Description[Index]) ;
        //LV.ItemIndex := Index ;
     end else begin
        memDetails.Lines.text := '' ;
        //html.LoadFromString('');
     end ;
end;

procedure TfrmInternetUpdateFound.FormShow(Sender: TObject);
begin
     //html.DefFontName := Self.Font.Name ;
     ShowItem (0) ;
end;

procedure TfrmInternetUpdateFound.LVSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
 ind : integer ;
begin
     ind := LV.ItemIndex ;
     ShowItem (ind) ;
end;


procedure TfrmInternetUpdateFound.LVChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
 ind : integer ;
begin
     try
        ind := LV.ItemIndex ;
        ShowItem (ind) ;
     except
     end ;
end;

procedure TfrmInternetUpdateFound.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure TfrmInternetUpdateFound.CreateParams(var Params:TCreateParams);
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

end.



