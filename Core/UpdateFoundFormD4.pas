unit UpdateFoundFormD4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ImgList, InternetUpdate;

type
  TfrmInternetUpdateFound = class(TForm)
    ImageList1: TImageList;
    Panel1: TPanel;
    lblHeader: TLabel;
    LV: TListView;
    memDetails: TMemo;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Image1: TImage;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure LVClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LVChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    FInfo : TDownloadInfo ;
    procedure LVSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ShowItem(Index: integer);
    { Private declarations }
  public
    { Public declarations }
    function Execute(AInternetUpdate: TInternetUpdate): boolean;
  end;

var
  frmInternetUpdateFound: TfrmInternetUpdateFound;

implementation

{$R *.DFM}


function TfrmInternetUpdateFound.Execute (AInternetUpdate : TInternetUpdate) : boolean ;
var
 LI : TListItem ;
 i : integer ;
begin
     FInfo := AInternetUpdate.Download ;
     caption := Format(caption,[AInternetUpdate.ProjectCode]) ;
     lblHeader.caption := Format(lblHeader.caption,[AInternetUpdate.ProjectCode]) ;

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
        ind := LV.selected.index ;
        ShowItem (ind) ;
      except
      end 
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

procedure TfrmInternetUpdateFound.LVSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
 ind : integer ;
begin
     // ind := LV.ItemIndex ;
     ind := LV.selected.index ;
     ShowItem (ind) ;
end;

procedure TfrmInternetUpdateFound.FormShow(Sender: TObject);
begin
     ShowItem (0) ;
end;

procedure TfrmInternetUpdateFound.LVChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
 ind : integer ;
begin
     // ind := LV.ItemIndex ;
    try
       ind := LV.selected.index ;
       ShowItem (ind) ;
    except
    end ;
end;

end.
