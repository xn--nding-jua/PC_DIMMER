unit kompositionsszeneeditorform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, szenenverwaltung, gnugettext, Buttons, PngBitBtn,
  pngimage, ExtCtrls, JvExControls, JvGradient, VirtualTrees;

type
  TAktuelleKompositionsszene = record
    ID:TGUID;
    Name : string[255];
    Beschreibung : string[255];
    IDs : array of TGUID;
    StopScene:array of boolean;
  end;

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

  Tkompositionsszeneeditor = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Panel5: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Panel1: TPanel;
    Button2: TButton;
    Button1: TButton;
    Panel4: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label4: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Panel6: TPanel;
    Button3: TPngBitBtn;
    Button5: TPngBitBtn;
    Button4: TPngBitBtn;
    Panel7: TPanel;
    Panel8: TPanel;
    Shape4: TShape;
    Shape1: TShape;
    CheckBox1: TCheckBox;
    Panel9: TPanel;
    upbtn: TPngBitBtn;
    downbtn: TPngBitBtn;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure upbtnClick(Sender: TObject);
    procedure downbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    cancel:boolean;
    procedure Checkbuttons;
  public
    { Public-Deklarationen }
    AktuelleKompositionsszene : TAktuelleKompositionsszene;
  end;

var
//  kompositionsszeneeditor: Tkompositionsszeneeditor;
  kompositionsszeneeditor_array: array of Tkompositionsszeneeditor;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tkompositionsszeneeditor.Button3Click(Sender: TObject);
var
  i,arrayposition:integer;
  Data:PTreeData;
  TempNode:PVirtualNode;
begin
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
  arrayposition:=length(szenenverwaltung_formarray)-1;
  szenenverwaltung_formarray[arrayposition]:=Tszenenverwaltungform.Create(self);

  szenenverwaltung_formarray[arrayposition].multiselect:=true;
  szenenverwaltung_formarray[arrayposition].showmodal;
  if szenenverwaltung_formarray[arrayposition].ModalResult=mrOK then
  begin
    TempNode:=szenenverwaltung_formarray[arrayposition].VST.GetFirst;
    while Assigned(TempNode) do
    begin
      if szenenverwaltung_formarray[arrayposition].VST.Selected[TempNode] then
      begin
        Data:=szenenverwaltung_formarray[arrayposition].VST.GetNodeData(TempNode);
        if not (Data^.IsRootNode or Data^.IsCatNode) then
        begin
          setlength(AktuelleKompositionsszene.IDs,length(AktuelleKompositionsszene.IDs)+1);
          setlength(AktuelleKompositionsszene.StopScene,length(AktuelleKompositionsszene.StopScene)+1);
          case Data^.NodeType of
            0..3,6..9,10..12:
            begin
              AktuelleKompositionsszene.IDs[length(AktuelleKompositionsszene.IDs)-1]:=Data^.ID;
              Listbox1.Items.Add(mainform.GetSceneInfo2(Data^.ID,'name'));
            end;
            4:
            begin
            // Befehl
              for i:=0 to length(mainform.Befehle2)-1 do
                if IsEqualGUID(mainform.Befehle2[i].ID,Data^.ID) then
                  if length(mainform.Befehle2[i].ArgGUID)>0 then
                  if (IsEqualGUID(mainform.Befehle2[i].ArgGUID[0],AktuelleKompositionsszene.ID)) and (GUIDtoString(AktuelleKompositionsszene.ID)<>'{00000000-0000-0000-0000-000000000000}') then
                  begin
                    MessageDlg(_('Es wird gerade versucht eine sich selbst aufrufende Kompositionsszene zu erstellen.'+#10+'Da dies zu einer Endlosschleife führen würde, wird der Vorgang automatisch abgebrochen.'), mtError, [mbOk], 0);
                    cancel:=true;
                  end;
              if not cancel then
              begin
                ShowMessage(_('Bitte stellen Sie sicher, dass der Befehl den Sie gerade hinzufügen möchten nicht die zu bearbeitende Kombinationsszene aufruft.'+#10+'Ringaufrufe können nicht vollständig erkannt werden und führen zum Absturz.'));
                AktuelleKompositionsszene.IDs[length(AktuelleKompositionsszene.IDs)-1]:=Data^.ID;
                Listbox1.Items.Add(mainform.GetSceneInfo2(Data^.ID,'name'));
              end;
            end;
            5:
            begin
            // Komposition
              cancel:=false;
              for i:=0 to length(kompositionsszeneeditor_array)-1 do
              begin
                if IsEqualGUID(kompositionsszeneeditor_array[i].AktuelleKompositionsszene.ID,Data^.ID) then
                begin
                  MessageDlg(_('Es wird gerade versucht eine sich selbst aufrufende Kombinationsszene zu erstellen.'+#10+'Da dies zu einer Endlosschleife führen würde, wird der Vorgang automatisch abgebrochen.'), mtError, [mbOk], 0);
                  cancel:=true;
                end;
              end;
              if not cancel then
              begin
                AktuelleKompositionsszene.IDs[length(AktuelleKompositionsszene.IDs)-1]:=Data^.ID;
                Listbox1.Items.Add(mainform.GetSceneInfo2(Data^.ID,'name'));
              end;
            end;
          end;
        end;
      end;
      TempNode:=szenenverwaltung_formarray[arrayposition].VST.GetNext(TempNode);
    end;
  end;
  szenenverwaltung_formarray[arrayposition].Free;
  setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1); // müsste eigentlich funktionieren, wenn alle vorherigen Fenster schön brav ihre erzeugten Forms auch wieder beendet haben
  CheckButtons;
end;

procedure Tkompositionsszeneeditor.Button4Click(Sender: TObject);
var
  i:integer;
begin
  if Listbox1.Items.Count>0 then
  begin
    if Listbox1.Items.Count>1 then
    begin
      for i:=Listbox1.ItemIndex to Listbox1.Items.Count-2 do
      begin
        AktuelleKompositionsszene.IDs[i]:=AktuelleKompositionsszene.IDs[i+1];
        AktuelleKompositionsszene.StopScene[i]:=AktuelleKompositionsszene.StopScene[i+1];
        Listbox1.Items.Strings[i]:=Listbox1.Items.Strings[i+1];
      end;
    end;
    Listbox1.Items.Delete(Listbox1.Items.Count-1);
    setlength(AktuelleKompositionsszene.IDs,length(AktuelleKompositionsszene.IDs)-1);
    setlength(AktuelleKompositionsszene.StopScene,length(AktuelleKompositionsszene.StopScene)-1);
  end;
  CheckButtons;
end;

procedure Tkompositionsszeneeditor.Edit1Change(Sender: TObject);
begin
  AktuelleKompositionsszene.Name:=Edit1.Text;
end;

procedure Tkompositionsszeneeditor.Edit2Change(Sender: TObject);
begin
  AktuelleKompositionsszene.Beschreibung:=Edit2.Text;
end;

procedure Tkompositionsszeneeditor.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tkompositionsszeneeditor.Button5Click(Sender: TObject);
begin
  if Listbox1.ItemIndex>-1 then
    mainform.EditScene(AktuelleKompositionsszene.IDs[Listbox1.ItemIndex]);
end;

procedure Tkompositionsszeneeditor.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tkompositionsszeneeditor.ListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Checkbuttons;
end;

procedure Tkompositionsszeneeditor.ListBox1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Checkbuttons;
end;

procedure Tkompositionsszeneeditor.Checkbuttons;
begin
  Button4.enabled:=(Listbox1.ItemIndex>-1);
  Button5.enabled:=(Listbox1.ItemIndex>-1);
  upbtn.enabled:=(Listbox1.ItemIndex>-1);
  downbtn.enabled:=(Listbox1.ItemIndex>-1);
  if Listbox1.itemindex>-1 then
    Checkbox1.Checked:=AktuelleKompositionsszene.StopScene[Listbox1.itemindex];
end;

procedure Tkompositionsszeneeditor.CreateParams(var Params:TCreateParams);
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

procedure Tkompositionsszeneeditor.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Listbox1.itemindex>-1 then
    AktuelleKompositionsszene.StopScene[Listbox1.itemindex]:=Checkbox1.checked;
end;

procedure Tkompositionsszeneeditor.upbtnClick(Sender: TObject);
var
  ID_top, ID_current:TGUID;
  StopScene_top, StopScene_current: boolean;
  text_top, text_current:string;
begin
  if Listbox1.Items.Count>1 then
  begin
    if Listbox1.itemindex>0 then
    begin
      // Oberen Punkt speichern
      ID_top:=AktuelleKompositionsszene.IDs[Listbox1.itemindex-1];
      StopScene_top:=AktuelleKompositionsszene.StopScene[Listbox1.itemindex-1];
      text_top:=Listbox1.Items.Strings[Listbox1.itemindex-1];
      // Aktuellen Punkt speichern
      ID_current:=AktuelleKompositionsszene.IDs[Listbox1.itemindex];
      StopScene_current:=AktuelleKompositionsszene.StopScene[Listbox1.itemindex];
      text_current:=Listbox1.Items.Strings[Listbox1.itemindex];

      // Vertauschen
      AktuelleKompositionsszene.IDs[Listbox1.itemindex-1]:=ID_current;
      AktuelleKompositionsszene.StopScene[Listbox1.itemindex-1]:=StopScene_current;
      Listbox1.Items.Strings[Listbox1.itemindex-1]:=text_current;
      AktuelleKompositionsszene.IDs[Listbox1.itemindex]:=ID_top;
      AktuelleKompositionsszene.StopScene[Listbox1.itemindex]:=StopScene_top;
      Listbox1.Items.Strings[Listbox1.itemindex]:=text_top;

      Listbox1.itemindex:=Listbox1.itemindex-1;
    end;
  end;
  CheckButtons;
end;

procedure Tkompositionsszeneeditor.downbtnClick(Sender: TObject);
var
  ID_bottom, ID_current:TGUID;
  StopScene_bottom, StopScene_current: boolean;
  text_bottom, text_current:string;
begin
  if Listbox1.Items.Count>1 then
  begin
    if Listbox1.itemindex<(listbox1.items.count-1) then
    begin
      // Unteren Punkt speichern
      ID_bottom:=AktuelleKompositionsszene.IDs[Listbox1.itemindex+1];
      StopScene_bottom:=AktuelleKompositionsszene.StopScene[Listbox1.itemindex+1];
      text_bottom:=Listbox1.Items.Strings[Listbox1.itemindex+1];
      // Aktuellen Punkt speichern
      ID_current:=AktuelleKompositionsszene.IDs[Listbox1.itemindex];
      StopScene_current:=AktuelleKompositionsszene.StopScene[Listbox1.itemindex];
      text_current:=Listbox1.Items.Strings[Listbox1.itemindex];

      // Vertauschen
      AktuelleKompositionsszene.IDs[Listbox1.itemindex+1]:=ID_current;
      AktuelleKompositionsszene.StopScene[Listbox1.itemindex+1]:=StopScene_current;
      Listbox1.Items.Strings[Listbox1.itemindex+1]:=text_current;
      AktuelleKompositionsszene.IDs[Listbox1.itemindex]:=ID_bottom;
      AktuelleKompositionsszene.StopScene[Listbox1.itemindex]:=StopScene_bottom;
      Listbox1.Items.Strings[Listbox1.itemindex]:=text_bottom;

      Listbox1.itemindex:=Listbox1.itemindex+1;
    end;
  end;
  CheckButtons;
end;

end.
