unit usermgmtfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, gnugettext, StdCtrls, dxGDIPlusClasses, ExtCtrls, JvExControls,
  JvGradient, Buttons, PngBitBtn;

type
  Tusermgmtform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Panel2: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Button1: TButton;
    Label1: TLabel;
    userbox: TListBox;
    GroupBox1: TGroupBox;
    AddUserBtn: TPngBitBtn;
    DeleteUserBtn: TPngBitBtn;
    Label2: TLabel;
    passwordedit: TEdit;
    Label3: TLabel;
    nameedit: TEdit;
    Label4: TLabel;
    accesslevelbox: TComboBox;
    Label5: TLabel;
    Button2: TButton;
    procedure CreateParams(var Params:TCreateParams);override;
    procedure FormCreate(Sender: TObject);
    procedure accesslevelboxChange(Sender: TObject);
    procedure AddUserBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DeleteUserBtnClick(Sender: TObject);
    procedure userboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure userboxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure userboxClick(Sender: TObject);
  private
    { Private-Deklarationen }
    LastSelected:string;
    procedure RefreshGUI;
  public
    { Public-Deklarationen }
  end;

var
  usermgmtform: Tusermgmtform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tusermgmtform.CreateParams(var Params:TCreateParams);
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

procedure Tusermgmtform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tusermgmtform.accesslevelboxChange(Sender: TObject);
begin
  case accesslevelbox.ItemIndex of
    0: label5.Caption:=_('Vollzugriff in der gesamten Software');
    1: label5.Caption:=_('Vollzugriff in der gesamten Software, jedoch keine Benutzerbearbeitung.');
    2: label5.Caption:=_('Steuerkontrolle, aber keine Benutzer-, Geräte-, Szenen- oder Effektbearbeitung.');
    3: label5.Caption:=_('Lediglich Benutzung des Kontrollpanels');
    4: label5.Caption:=_('Keinerlei Rechte - Nur für Demozwecke geeignet');
  end;
end;

procedure Tusermgmtform.AddUserBtnClick(Sender: TObject);
begin
  setlength(mainform.UserAccounts, length(mainform.UserAccounts)+1);

  CreateGUID(mainform.UserAccounts[length(mainform.UserAccounts)-1].ID);
  mainform.UserAccounts[length(mainform.UserAccounts)-1].Name:='Neuer Benutzer';
  mainform.UserAccounts[length(mainform.UserAccounts)-1].Name:=InputBox(_('Benutzername'),_('Bitte geben Sie einen Namen für den neuen Benutzer an:'), mainform.UserAccounts[length(mainform.UserAccounts)-1].Name);
  mainform.UserAccounts[length(mainform.UserAccounts)-1].Password:='';
  mainform.UserAccounts[length(mainform.UserAccounts)-1].AccessLevel:=4;

  LastSelected:=mainform.UserAccounts[length(mainform.UserAccounts)-1].Name;
  FormShow(nil);
end;

procedure Tusermgmtform.FormShow(Sender: TObject);
var
  i:integer;
begin
  userbox.Items.clear;
  for i:=0 to length(mainform.UserAccounts)-1 do
  begin
    userbox.Items.Add(mainform.UserAccounts[i].Name);
  end;
  for i:=0 to userbox.items.count-1 do
  begin
    if LastSelected=userbox.Items[i] then
    begin
      userbox.itemindex:=i;
      break;
    end;
  end;
  if userbox.itemindex<0 then
    userbox.itemindex:=0;
  RefreshGUI;
end;

procedure Tusermgmtform.DeleteUserBtnClick(Sender: TObject);
var
  i:integer;
begin
  if userbox.itemindex>=0 then
  begin
    if userbox.Items[userbox.itemindex]<>'Admin' then
    begin
      for i:=userbox.ItemIndex to userbox.items.count-2 do
      begin
        mainform.UserAccounts[i].ID:=mainform.UserAccounts[i+1].ID;
        mainform.UserAccounts[i].Name:=mainform.UserAccounts[i+1].Name;
        mainform.UserAccounts[i].Password:=mainform.UserAccounts[i+1].Password;
        mainform.UserAccounts[i].AccessLevel:=mainform.UserAccounts[i+1].AccessLevel;
      end;
      setlength(mainform.UserAccounts, length(mainform.UserAccounts)-1);
      FormShow(nil);
    end else
      ShowMessage(_('Sie können den Administrator nicht entfernen'));
  end;
end;

procedure Tusermgmtform.userboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RefreshGUI
end;

procedure Tusermgmtform.Button2Click(Sender: TObject);
begin
  if (userbox.itemindex>-1) and (userbox.itemindex<length(mainform.UserAccounts)) then
  begin
    if ((mainform.UserAccounts[userbox.itemindex].Name='Admin') and (mainform.UserAccounts[userbox.itemindex].Name=nameedit.Text)) or
      (mainform.UserAccounts[userbox.itemindex].Name<>'Admin') then
    begin
      mainform.UserAccounts[userbox.itemindex].Name:=nameedit.Text;
      mainform.UserAccounts[userbox.itemindex].Password:=passwordedit.Text;
      if mainform.UserAccounts[userbox.itemindex].Name='Admin' then
        mainform.UserAccounts[userbox.itemindex].AccessLevel:=0;
    end else
    begin
      ShowMessage(_('Sie können den Benutzer "Admin" nicht umbenennen.'));
    end;
    FormShow(nil);
  end;
end;

procedure Tusermgmtform.userboxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  RefreshGUI;
end;

procedure Tusermgmtform.userboxClick(Sender: TObject);
begin
  RefreshGUI;
end;

procedure Tusermgmtform.RefreshGUI;
begin
  if (userbox.itemindex>-1) and (userbox.itemindex<length(mainform.UserAccounts)) then
  begin
    nameedit.text:=mainform.UserAccounts[userbox.itemindex].Name;
    passwordedit.text:=mainform.UserAccounts[userbox.itemindex].Password;
    accesslevelbox.ItemIndex:=mainform.UserAccounts[userbox.itemindex].AccessLevel;

    nameedit.Enabled:=mainform.UserAccounts[userbox.itemindex].Name='Admin';
    accesslevelbox.Enabled:=mainform.UserAccounts[userbox.itemindex].Name='Admin';
  end;

  DeleteUserBtn.Enabled:=(userbox.itemindex>-1) and (userbox.itemindex<length(mainform.UserAccounts));
end;

end.
