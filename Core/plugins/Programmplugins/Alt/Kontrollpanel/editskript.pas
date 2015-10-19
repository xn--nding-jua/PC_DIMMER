Unit editskript;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Action;

type
  Teditskriptfrm = class(TForm)
    GroupBox1: TGroupBox;
    OK: TButton;
    ListBox: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    OpenDialog1: TOpenDialog;
    Button9: TButton;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    aktuellezeile, aktuellespalte:integer;
  end;

var
  editskriptfrm: Teditskriptfrm;

implementation

uses szenenpanelfrm;

{$R *.dfm}

function timestr(t:integer):string;
var
  h,m,s:integer;
begin
  h:=t div 360000; t:=t mod 360000;
  m:=t div 6000; t:=t mod 6000;
  s:=t div 100; t:=t mod 100;
  result:=inttostr(h)+':';
  if m<10 then result:=result+'0';
  result:=result+inttostr(m)+':';
  if s<10 then result:=result+'0';
  result:=result+inttostr(s)+'.';
  if t<10 then result:=result+'0';
  result:=result+inttostr(t)+'0';
end;

procedure Teditskriptfrm.Button1Click(Sender: TObject);
var
  action: Tscriptaction;
  i,cnt: integer;
  s: string;
begin
  actiondlg.reset; {Aktionsmanager vorbereiten}

	for i:=1 to chan do
	  actiondlg.Faction.ch[i]:=false;

  actiondlg.StringGrid1.RowCount:=mainform.lastchan+1;

  for i:=1 to mainform.lastchan do
  begin
    actiondlg.StringGrid1.Cells[1,i]:=inttostr(i);
    actiondlg.StringGrid1.Cells[2,i]:=mainform.channelnames[i];
    actiondlg.StringGrid1.Cells[3,i]:='0';
  end;

  if actiondlg.execute then
    begin
      action:=actiondlg.action;
      cnt:=listbox.items.count;
      if action.option=optWait then
        begin
          s:=_('Warte auf Kanal:  ');
          for i:=1 to chan do
            if action.ch[i] then s:=s+inttostr(i)+',';
          delete(s,length(s),1);
          s:=s+' for '+timestr(action.wait);
          listbox.itemindex:=listbox.items.add(s);
        end;
      if action.option=optSwitch then
        begin
          s:=_('Schalte Kanal:  ');
          for i:=1 to chan do
            if action.ch[i] then s:=s+inttostr(i)+',';
          delete(s,length(s),1);
          s:=s+' to '+inttostr(action.svalue)+'%';
          listbox.itemindex:=listbox.items.add(s);
        end;
      if action.option=optFade then
        begin
          s:=_('Fade Kanal:  ');
          for i:=1 to chan do
            if action.ch[i] then s:=s+inttostr(i)+',';
          delete(s,length(s),1);
          s:=s+' from '+inttostr(action.svalue)
             +'% to '+inttostr(action.evalue)+'% in '
             +timestr(action.fadetime);
          listbox.itemindex:=listbox.items.add(s);
        end;
      if action.option=optSync then
        begin
          if action.sync=1 then
            s:=_('Letzte Aktionen abschließen');
          if action.sync=2 then
            s:=_('Letzte Aktionen abschließen und auf Tastendruck warten');
          listbox.itemindex:=listbox.items.add(s);
        end;
      listbox.itemindex:=cnt;
    end;
end;

procedure Teditskriptfrm.Button2Click(Sender: TObject);
var
  action: Tscriptaction;
  i,cnt: integer;
  s: string;
begin
  actiondlg.reset; {Aktionen initiieren}

	for i:=1 to chan do
	  actiondlg.Faction.ch[i]:=false;

  actiondlg.StringGrid1.RowCount:=mainform.lastchan+1;

  for i:=1 to mainform.lastchan do
  begin
    actiondlg.StringGrid1.Cells[1,i]:=inttostr(i);
    actiondlg.StringGrid1.Cells[2,i]:=mainform.channelnames[i];
    actiondlg.StringGrid1.Cells[3,i]:='0';
  end;

  if actiondlg.execute then
    begin
      action:=actiondlg.action;
      cnt:=listbox.itemindex;
      if action.option=optWait then
        begin
          s:=_('Warte auf Kanal:  ');
          for i:=1 to chan do
            if action.ch[i] then s:=s+inttostr(i)+',';
          delete(s,length(s),1);
          s:=s+' for '+timestr(action.wait);
          listbox.items.insert(listbox.itemindex,s);
        end;
      if action.option=optSwitch then
        begin
          s:=_('Schalte Kanal:  ');
          for i:=1 to chan do
            if action.ch[i] then s:=s+inttostr(i)+',';
          delete(s,length(s),1);
          s:=s+' to '+inttostr(action.svalue)+'%';
          listbox.items.insert(listbox.itemindex,s);
        end;
      if action.option=optFade then
        begin
          s:=_('Fade Kanal:  ');
          for i:=1 to chan do
            if action.ch[i] then s:=s+inttostr(i)+',';
          delete(s,length(s),1);
          s:=s+' from '+inttostr(action.svalue)
             +'% to '+inttostr(action.evalue)+'% in '
             +timestr(action.fadetime);
          listbox.items.insert(listbox.itemindex,s);
        end;
      if action.option=optSync then
        begin
          if action.sync=1 then
            s:=_('Letzte Aktionen abschließen');
          if action.sync=2 then
            s:=_('Letzte Aktionen abschließen und auf Tastendruck warten');
          listbox.items.insert(listbox.itemindex,s);
        end;
      listbox.itemindex:=cnt;
    end;
end;

procedure Teditskriptfrm.Button7Click(Sender: TObject);
var
  cnt: integer;
begin
  if listbox.itemindex>=0 then
    begin
      cnt:=listbox.itemindex;
      listbox.items.delete(listbox.itemindex);
      if listbox.ItemIndex<listbox.Items.Count then listbox.itemindex:=cnt;
      if listbox.ItemIndex<0 then listbox.itemindex:=(cnt-1);
    end;
end;

procedure Teditskriptfrm.Button4Click(Sender: TObject);
var
  cnt: integer;
begin
  if ((listbox.itemindex>0) and (listbox.ItemIndex>-1)) then
    begin
      cnt:=listbox.itemindex;
      listbox.items.exchange(listbox.itemindex-1,listbox.itemindex);
      listbox.itemindex:=cnt-1;
    end;
end;
procedure Teditskriptfrm.Button5Click(Sender: TObject);
var
  cnt: integer;
begin
  if ((listbox.itemindex<listbox.items.count-1) and (listbox.ItemIndex>-1)) then
    begin
      cnt:=listbox.itemindex;
      listbox.items.exchange(listbox.itemindex,listbox.itemindex+1);
      listbox.itemindex:=cnt+1;
    end;
end;

procedure Teditskriptfrm.Button6Click(Sender: TObject);
var
  action: Tscriptaction;
  i,cnt: integer;
  s: string;
begin
  if listbox.itemindex>=0 then
  begin
  actiondlg.StringGrid1.RowCount:=mainform.lastchan+1;

  for i:=1 to mainform.lastchan do
  begin
    actiondlg.StringGrid1.Cells[1,i]:=inttostr(i);
    actiondlg.StringGrid1.Cells[2,i]:=mainform.channelnames[i];
    actiondlg.StringGrid1.Cells[3,i]:='0';
  end;

  s:=listbox.items[listbox.itemindex];
  delete(s,pos(':',s),1); {Lösche zuerst ':'}
  for i:=1 to chan do action.ch[i]:=false;
  while pos(',',s)<>0 do {Suche nach Kanälen}
    begin
      cnt:=strtoint(copy(s,pos(',',s)-3,3));
      action.ch[cnt]:=true;
      if cnt<10 then delete(s,pos(inttostr(cnt),s),2)
      else
      if cnt<100 then delete(s,pos(inttostr(cnt),s),3)
      else delete(s,pos(inttostr(cnt),s),4);
    end;
  if copy(s,1,1)='W' then
    begin
      action.ch[strtoint(copy(s,pos('for',s)-4,3))]:=true;
      action.option:=optWait;
      action.wait:=strtoint(copy(s,pos(':',s)-2,2)) * 3600;
      action.wait:=action.wait + strtoint(copy(s,pos(':',s)+1,2)) * 60;
      action.wait:=action.wait + strtoint(copy(s,pos('.',s)-2,2));
      action.wait:=action.wait * 100;
      action.wait:=action.wait + (strtoint(copy(s,pos('.',s)+1,3)) div 10);
		  actiondlg.waitbutton2.enabled:=false;
		  actiondlg.switchbutton2.enabled:=true;
		  actiondlg.fadebutton2.enabled:=true;
		  actiondlg.syncbutton2.enabled:=true;
    end;
  if copy(s,1,1)='S' then
    begin
      action.ch[strtoint(copy(s,pos('to',s)-4,3))]:=true;
      action.option:=optSwitch;
      action.svalue:=strtoint(copy(s,pos('to',s)+3,pos('%',s)-(pos('to',s)+3)));
		  actiondlg.waitbutton2.enabled:=true;
		  actiondlg.switchbutton2.enabled:=false;
		  actiondlg.fadebutton2.enabled:=true;
		  actiondlg.syncbutton2.enabled:=true;
    end;
  if copy(s,1,1)='F' then
    begin
      action.ch[strtoint(copy(s,pos('from',s)-4,3))]:=true;
      action.option:=optFade;
      action.svalue:=strtoint(copy(s,pos('from',s)+5,pos('%',s)-(pos('from',s)+5)));
      action.evalue:=strtoint(copy(s,pos('to',s)+3,pos('% in',s)-(pos('to',s)+3)));
      action.fadetime:=strtoint(copy(s,pos(':',s)-2,2)) * 3600;
      action.fadetime:=action.fadetime + strtoint(copy(s,pos(':',s)+1,2)) * 60;
      action.fadetime:=action.fadetime + strtoint(copy(s,pos('.',s)-2,2));
      action.fadetime:=action.fadetime * 100;
      action.fadetime:=action.fadetime + (strtoint(copy(s,pos('.',s)+1,3)) div 10);
		  actiondlg.waitbutton2.enabled:=true;
		  actiondlg.switchbutton2.enabled:=true;
		  actiondlg.fadebutton2.enabled:=false;
		  actiondlg.syncbutton2.enabled:=true;
    end;
  if copy(s,1,1)='L' then
    begin
      action.option:=optSync;
      if length(s)<=30 then
        action.sync:=1
      else
        action.sync:=2;
		  actiondlg.waitbutton2.enabled:=true;
		  actiondlg.switchbutton2.enabled:=true;
		  actiondlg.fadebutton2.enabled:=true;
		  actiondlg.syncbutton2.enabled:=false;
    end;
  actiondlg.action:=action;
  ActionDlg.EditMode;
  if actiondlg.execute then
    begin
      action:=actiondlg.action;
      cnt:=listbox.itemindex;
      if action.option=optWait then
        begin
          s:=_('Warte auf Kanal:  ');
          for i:=1 to chan do
            if action.ch[i] then s:=s+inttostr(i)+',';
          delete(s,length(s),1);
          s:=s+' for '+timestr(action.wait);
          listbox.items.insert(listbox.itemindex,s);
          listbox.items.delete(listbox.itemindex);
        end;
      if action.option=optSwitch then
        begin
          s:=_('Schalte Kanal:  ');
          for i:=1 to chan do
            if action.ch[i] then s:=s+inttostr(i)+',';
          delete(s,length(s),1);
          s:=s+' to '+inttostr(action.svalue)+'%';
          listbox.items.insert(listbox.itemindex,s);
          listbox.items.delete(listbox.itemindex);
        end;
      if action.option=optFade then
        begin
          s:=_('Fade Kanal:  ');
          for i:=1 to chan do
            if action.ch[i] then s:=s+inttostr(i)+',';
          delete(s,length(s),1);
          s:=s+' from '+inttostr(action.svalue)
             +'% to '+inttostr(action.evalue)+'% in '
             +timestr(action.fadetime);
          listbox.items.insert(listbox.itemindex,s);
          listbox.items.delete(listbox.itemindex);
        end;
      if action.option=optSync then
        begin
          if action.sync=1 then
            s:=_('Letzte Aktionen abschließen');
          if action.sync=2 then
            s:=_('Letzte Aktionen abschließen und auf Tastendruck warten');
          listbox.items.insert(listbox.itemindex,s);
          listbox.items.delete(listbox.itemindex);
        end;
      listbox.itemindex:=cnt;
    end;
	end;
end;

procedure Teditskriptfrm.Button3Click(Sender: TObject);
var
  cnt: integer;
begin
  if listbox.itemindex>=0 then
    begin
      cnt:=listbox.itemindex;
      listbox.items.insert(cnt+1,listbox.items[cnt]);
      listbox.itemindex:=cnt+1;
    end;
end;

procedure Teditskriptfrm.OKClick(Sender: TObject);
begin
  If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt') then
   	CreateDir(ExtractFilepath(paramstr(0))+'Projekt');
  if not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel') then
  	CreateDir(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel');
	listbox.items.insert(0,inttostr(listbox.items.count));
	listbox.Items.SaveToFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp');
end;

procedure Teditskriptfrm.Button8Click(Sender: TObject);
begin
	if opendialog1.Execute then
  begin
  	listbox.Items.LoadFromFile(opendialog1.FileName);
    	if listbox.Items.Count>0 then
        if listbox.items[0]<>inttostr(listbox.items.count-1) then
          begin
            listbox.items.clear;
            messagedlg(_('Sorry, fehlerhafte Skriptdatei!'),mtError,[mbOK],0);
          end
        else
          listbox.items.delete(0);
  end;
end;

procedure Teditskriptfrm.Button9Click(Sender: TObject);
begin
  if savedialog1.Execute then
  begin
		listbox.Items.Insert(0,inttostr(listbox.Items.Count));
  	listbox.Items.SaveToFile(savedialog1.FileName);
    listbox.Items.Delete(0);
  end;
end;

end.
