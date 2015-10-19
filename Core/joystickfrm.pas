unit joystickfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, directinput, ugamepad, mmsystem,
  Grids, StrUtils, gnugettext, pngimage, JvExControls,
  JvGradient, SVATimer;

type
  Tjoystickform = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    fadenkreuz: TPanel;
    Center: TShape;
    Bevel1: TBevel;
    Bevel2: TBevel;
    PositionXY: TShape;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    Button32: TButton;
    ProgressBar1: TProgressBar;
    StringGrid1: TStringGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    axiscountlabel: TLabel;
    buttonscountlabel: TLabel;
    hatscountlabel: TLabel;
    sliderscountlabel: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    SetCalibrationBtn: TButton;
    DeleteCalibrationBtn: TButton;
    Label6: TLabel;
    RadioButton5: TRadioButton;
    CenterBtn: TButton;
    Label8: TLabel;
    Panel3: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    GroupBox3: TGroupBox;
    SearchDeviceBtn: TButton;
    cbGamePads: TComboBox;
    CheckBox1: TCheckBox;
    Label7: TLabel;
    Edit1: TEdit;
    ConfigureBtn: TButton;
    Panel1: TPanel;
    Shape4: TShape;
    Shape1: TShape;
    CloseBtn: TButton;
    lblgpdisabled: TLabel;
    JoystickTimer: TSVATimer;
    procedure CloseBtnClick(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ConfigureBtnClick(Sender: TObject);
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbGamePadsChange(Sender: TObject);
    procedure SetCalibrationBtnClick(Sender: TObject);
    procedure DeleteCalibrationBtnClick(Sender: TObject);
    procedure SearchDeviceBtnClick(Sender: TObject);
    procedure CenterBtnClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure JoystickTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    {$IFNDEF USETIMER}
    t3,xy,ticks: Cardinal;
    {$ENDIF}
    LastAxisValue:array[0..7] of Integer;
    ActualPosition:array[0..7] of Single;
  public
    { Public-Deklarationen }
    gcp: TGamePad;
    buttonpressed:array[0..31] of boolean;
    offset:array[0..7] of Integer;
    procedure PositionXYMoved;
    procedure InitializeJoystick;
  end;

var
  joystickform: Tjoystickform;

implementation

uses joysticksetupfrm, PCDIMMER, preseteditorform, geraetesteuerungfrm;

{$R *.dfm}

procedure Tjoystickform.CloseBtnClick(Sender: TObject);
begin
  close;
end;

procedure Tjoystickform.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Caption:=_('Joysticksteuerung');
  mainform.ActiveJoystickRibbonBox.Down:=Checkbox1.Checked;
  joystickform.JoystickTimer.Enabled:=Checkbox1.Checked;
end;

procedure Tjoystickform.ConfigureBtnClick(Sender: TObject);
begin
  joysticksetupform.showmodal;
end;

procedure Tjoystickform.PositionXYMoved;
var
  X,Y:Extended;
begin
  X:=(PositionXY.Left+(PositionXY.Width/2))/fadenkreuz.Width; // 0.255-> 0..1
  Y:=(PositionXY.Top+(PositionXY.Height/2))/fadenkreuz.Height; // 0..255-> 0..1

  if preseteditor.fadenkreuz.Visible then
  begin
    preseteditor.PositionXY.Left:=round((X*preseteditor.fadenkreuz.width-(preseteditor.PositionXY.Width/2)));
    preseteditor.PositionXY.Top:=round((Y*preseteditor.fadenkreuz.height-(preseteditor.PositionXY.Height/2)));
    preseteditor.change(preseteditor.fadenkreuz);
  end;
end;

procedure Tjoystickform.Button1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=1 to 32 do
  begin
    if Sender=TButton(FindComponent('Button'+inttostr(i))) then
    begin
      if mainform.JoystickEvents[i+11].invert then
        mainform.StartBefehl(mainform.JoystickEvents[i+11].ID, 0)
      else
        mainform.StartBefehl(mainform.JoystickEvents[i+11].ID, 255);
    end;
  end;
end;

procedure Tjoystickform.Button1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=1 to 32 do
  begin
    if Sender=TButton(FindComponent('Button'+inttostr(i))) then
    begin
      if mainform.JoystickEvents[i+11].invert then
        mainform.StartBefehl(mainform.JoystickEvents[i+11].ID, 255)
      else
        mainform.StartBefehl(mainform.JoystickEvents[i+11].ID, 0);
    end;
  end;
end;

procedure Tjoystickform.cbGamePadsChange(Sender: TObject);
var
  i:integer;
begin
    gcp.ID:=cbgamepads.ItemIndex;
    with gcp do
    begin
//        devicenamelabel.caption:=InstanceName;
        axiscountlabel.Caption:=inttostr(NumAxes);
        buttonscountlabel.Caption:=inttostr(NumButtons);
        hatscountlabel.Caption:=inttostr(NumHats);
        sliderscountlabel.Caption:=inttostr(NumSliders);

        for i:=1 to 32 do
          TButton(FindComponent('Button'+inttostr(i))).Enabled:=false;

        for i:=1 to NumButtons do
          TButton(FindComponent('Button'+inttostr(i))).Enabled:=true;

        StringGrid1.RowCount:=1+NumAxes+NumSliders;
    end;
end;

procedure Tjoystickform.SetCalibrationBtnClick(Sender: TObject);
begin
  mainform.JoystickEvents[Stringgrid1.Row-1].offset:=offset[Stringgrid1.Row-1];
end;

procedure Tjoystickform.DeleteCalibrationBtnClick(Sender: TObject);
begin
  mainform.JoystickEvents[Stringgrid1.Row-1].offset:=0;
end;

procedure Tjoystickform.SearchDeviceBtnClick(Sender: TObject);
var
  i:integer;
begin
    UpdateDevices;

    if(GamePadCount>0)then
    begin
        gcp.Free;
        gcp:=TGamePad.Create(0);
        cbgamepads.Items.Clear;
        i:=0;
        repeat
            if(i>0)then
                gcp.ID:=i;

            cbgamepads.Items.Add(gcp.InstanceName);

            Inc(i);
        until i=GamePadCount;
        cbgamepads.ItemIndex:=0;
        cbgamepadsChange(nil);
    end;
end;

procedure Tjoystickform.CenterBtnClick(Sender: TObject);
var
  i:integer;
  value:integer;
begin
  PositionXY.Top:=(fadenkreuz.Height div 2)-(PositionXY.Height div 2);
  PositionXY.Left:=(fadenkreuz.Width div 2)-(PositionXY.Width div 2);;
  PositionXYMoved;

  for i := 0 to 7 do
  begin
    ActualPosition[i]:=0;
    value:=round(((ActualPosition[i]+1000)/2000)*255);
    if mainform.JoystickEvents[i].invert then
      value:=255-value;
    //if (value>=mainform.JoystickEvents[i].Befehl.OnValue) and (value<=mainform.JoystickEvents[i].Befehl.OffValue) then
      mainform.StartBefehl(mainform.JoystickEvents[i].ID, value);
  end;
end;

procedure Tjoystickform.Edit1Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
  if Edit1.text<>'' then
    if strtoint(Edit1.Text)>0 then
      Joysticktimer.Interval:=strtoint(Edit1.text);
end;

procedure Tjoystickform.JoystickTimerTimer(Sender: TObject);
var
  btnpressed:array[0..31] of boolean;
  k:integer;
  function DataToStr(p: PByte; Size: Cardinal): String;
      var i: Integer;
  begin
    Result:='';
    repeat
      for i := 7 downto 0 do
          Result:=Result+IntToStr(p^shr i and 1);
      Result:= Result+' ';
      Inc(p);
      Dec(Size);
    until Size=0;
  end;
  function HatToStr(hat: THatState): String;
  begin
    case hat of
      hsUp: Result:='up';
      hsLeft: Result:='left';
      hsRight: Result:='right';
      hsDown: Result:='down';
      hsRightUp: Result:='right up';
      hsRightDown: Result:='right down';
      hsLeftUp: Result:='left up';
      hsLeftDown: Result:='left down';
      else Result:='centered';
    end;
  end;
var
  s: String; i, j, value: Integer;
  {$IFNDEF USETIMER}
  t2: Cardinal;
  {$ENDIF}
  CalibratedPos:integer;
begin
  if(gcp=nil)then
    Exit;

  if not(gcp.Enabled)then
  begin
    lblgpdisabled.Visible:=True;
    gcp.Enabled:=True;
  end else
  begin
    lblgpdisabled.Visible:=False;
  end;
  
  if(gcp.Update)then
  with gcp do
  begin
    j:=1;

    for i := 0 to 7 do
    with Axes[TAxisType(i)] do
    if(Enabled)then
    begin
      case i of
        0: s:=_('X-Achse');
        1: s:=_('Y-Achse');
        2: s:=_('Z-Achse');
        3: s:=_('Rx-Achse');
        4: s:=_('Ry-Achse');
        5: s:=_('Rz-Achse');
        6: s:=_('Slider A');
        7: s:=_('Slider B');
      end;

      with StringGrid1 do
      begin
        Cells[0, j]:=s;
        Cells[1, j]:=IntToStr(Pos-mainform.JoystickEvents[i].offset);
        Cells[2, j]:=IntToStr(Velo);
        Cells[3, j]:=IntToStr(Accel);
        Cells[4, j]:=IntToStr(Range);
      end;
      inc(j);

      // Offsets aktualisieren
      offset[i]:=Pos;
      // Aktion für Achsen und Slider
      //Achse 1
      case i of
        0:
        begin
          CalibratedPos:=Pos-mainform.JoystickEvents[0].offset;

          if Radiobutton1.Checked then
          begin
            if mainform.JoystickEvents[0].positionrelativ then
            begin
              // Relative Position
              LastAxisValue[0]:=CalibratedPos;

              if (Pos<>0) or mainform.JoystickEvents[0].PermanentUpdate then
              begin
                if (ActualPosition[0]<1000) or (ActualPosition[0]>-1000) then
                  ActualPosition[0]:=ActualPosition[0]+(CalibratedPos/mainform.JoystickEvents[0].beschleunigung*(abs(CalibratedPos)/5));

                if ActualPosition[0]>1000 then
                  ActualPosition[0]:=1000;
                if ActualPosition[0]<-1000 then
                  ActualPosition[0]:=-1000;

                if mainform.JoystickEvents[0].UseEvent then
                begin
                  PositionXY.Left:=round(((ActualPosition[0]+1000)/2000)*255)-(PositionXY.Width div 2);

                  value:=round(((ActualPosition[0]+1000)/2000)*255);
                  if mainform.JoystickEvents[0].invert then
                    value:=255-value;
                  //if (value>=mainform.JoystickEvents[0].Befehl.OnValue) and (value<=mainform.JoystickEvents[0].Befehl.OffValue) then
                    mainform.StartBefehl(mainform.JoystickEvents[0].ID, value);
                  PositionXYMoved;
                end;
              end;
            end else
            // Absolute Position
            if (LastAxisValue[0]<>CalibratedPos) or mainform.JoystickEvents[0].PermanentUpdate then
            begin
              LastAxisValue[0]:=CalibratedPos;
              if mainform.JoystickEvents[0].UseEvent then
              begin
{$WARNINGS OFF}
                PositionXY.Left:=round(((LastAxisValue[0]+Range)/(Range*2))*fadenkreuz.Width-PositionXY.Width/2);
{$WARNINGS ON}
                value:=round(((LastAxisValue[0]+1000)/2000)*255);
                if mainform.JoystickEvents[0].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[0].Befehl.OnValue) and (value<=mainform.JoystickEvents[0].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[0].ID, value);
                PositionXYMoved;
              end;
            end;
          end else
          begin
            if (LastAxisValue[0]<>CalibratedPos) or mainform.JoystickEvents[0].PermanentUpdate then
            begin
              if mainform.JoystickEvents[0].UseEvent then
              begin
                value:=round(((LastAxisValue[0]+1000)/2000)*255);
                if mainform.JoystickEvents[0].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[0].Befehl.OnValue) and (value<=mainform.JoystickEvents[0].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[0].ID, value);
              end;
              LastAxisValue[0]:=CalibratedPos;
            end;
          end;
        end;
        1:
        begin
          CalibratedPos:=Pos-mainform.JoystickEvents[1].offset;

          if Radiobutton1.Checked then
          begin
            if mainform.JoystickEvents[1].positionrelativ then
            begin
              LastAxisValue[1]:=CalibratedPos;

              if (Pos<>0) or mainform.JoystickEvents[1].PermanentUpdate then
              begin
                if (ActualPosition[1]<1000) or (ActualPosition[1]>-1000) then
                  ActualPosition[1]:=ActualPosition[1]+(CalibratedPos/mainform.JoystickEvents[1].beschleunigung*(abs(CalibratedPos)/5));

                if ActualPosition[1]>1000 then
                  ActualPosition[1]:=1000;
                if ActualPosition[1]<-1000 then
                  ActualPosition[1]:=-1000;

                if mainform.JoystickEvents[1].UseEvent then
                begin
                  PositionXY.Top:=round(((ActualPosition[1]+1000)/2000)*255)-(PositionXY.Height div 2);
                  value:=round(((ActualPosition[1]+1000)/2000)*255);
                  if mainform.JoystickEvents[1].invert then
                    value:=255-value;
                  //if (value>=mainform.JoystickEvents[1].Befehl.OnValue) and (value<=mainform.JoystickEvents[1].Befehl.OffValue) then
                    mainform.StartBefehl(mainform.JoystickEvents[1].ID, value);
                  PositionXYMoved;
                end;
              end;
            end else
            if (LastAxisValue[1]<>CalibratedPos) or mainform.JoystickEvents[1].PermanentUpdate then
            begin
              LastAxisValue[1]:=CalibratedPos;
              if mainform.JoystickEvents[1].UseEvent then
              begin
{$WARNINGS OFF}
                PositionXY.Top:=round(((LastAxisValue[1]+Range)/(Range*2))*fadenkreuz.Height-PositionXY.Height/2);
{$WARNINGS ON}
                value:=round(((LastAxisValue[1]+1000)/2000)*255);
                if mainform.JoystickEvents[1].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[1].Befehl.OnValue) and (value<=mainform.JoystickEvents[1].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[1].ID, value);
                PositionXYMoved;
              end;
            end;
          end else
          begin
            if (LastAxisValue[1]<>CalibratedPos) or mainform.JoystickEvents[1].PermanentUpdate then
            begin
              if mainform.JoystickEvents[1].UseEvent then
              begin
                value:=round(((LastAxisValue[1]+1000)/2000)*255);
                if mainform.JoystickEvents[1].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[1].Befehl.OnValue) and (value<=mainform.JoystickEvents[1].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[1].ID, value);
              end;
              LastAxisValue[1]:=CalibratedPos;
            end;
          end;
        end;
        2:
        begin
          CalibratedPos:=Pos-mainform.JoystickEvents[2].offset;

          if Radiobutton1.Checked then
          begin
            if (LastAxisValue[2]<>CalibratedPos) or mainform.JoystickEvents[2].PermanentUpdate then
            begin
              LastAxisValue[2]:=CalibratedPos;

              if mainform.JoystickEvents[2].UseEvent then
              begin
                value:=round(((LastAxisValue[2]+1000)/2000)*255);
                if mainform.JoystickEvents[2].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[2].Befehl.OnValue) and (value<=mainform.JoystickEvents[2].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[2].ID, value);
{$WARNINGS OFF}
                Progressbar1.Position:=2000-round(((LastAxisValue[2]+Range)/(Range*2))*2000);
{$WARNINGS ON}
              end;
            end;
          end;
          if Radiobutton2.Checked then
          begin
            if mainform.JoystickEvents[2].positionrelativ then
            begin
              LastAxisValue[2]:=CalibratedPos;

              if (Pos<>0) or mainform.JoystickEvents[2].PermanentUpdate then
              begin
                if (ActualPosition[2]<1000) or (ActualPosition[2]>-1000) then
                  ActualPosition[2]:=ActualPosition[2]+(CalibratedPos/mainform.JoystickEvents[2].beschleunigung*(abs(CalibratedPos)/5));

                if ActualPosition[2]>1000 then
                  ActualPosition[2]:=1000;
                if ActualPosition[2]<-1000 then
                  ActualPosition[2]:=-1000;

                if mainform.JoystickEvents[2].UseEvent then
                begin
                  PositionXY.Left:=round(((ActualPosition[2]+1000)/2000)*255)-(PositionXY.Width div 2);
                  value:=round(((ActualPosition[2]+1000)/2000)*255);
                  if mainform.JoystickEvents[2].invert then
                    value:=255-value;
                  //if (value>=mainform.JoystickEvents[2].Befehl.OnValue) and (value<=mainform.JoystickEvents[2].Befehl.OffValue) then
                    mainform.StartBefehl(mainform.JoystickEvents[2].ID, value);
                  PositionXYMoved;
                end;
              end;
            end else
            if (LastAxisValue[2]<>CalibratedPos) or mainform.JoystickEvents[2].PermanentUpdate then
            begin
              LastAxisValue[2]:=CalibratedPos;

              if mainform.JoystickEvents[2].UseEvent then
              begin
                PositionXY.Left:=round(((LastAxisValue[2]+1000)/1000)*fadenkreuz.Width-PositionXY.Width/2);
                value:=round(((LastAxisValue[2]+1000)/2000)*255);
                if mainform.JoystickEvents[2].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[2].Befehl.OnValue) and (value<=mainform.JoystickEvents[2].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[2].ID, value);
                PositionXYMoved;
              end;
            end;
          end else
          begin
            if (LastAxisValue[2]<>CalibratedPos) or mainform.JoystickEvents[2].PermanentUpdate then
            begin
              if mainform.JoystickEvents[2].UseEvent then
              begin
                value:=round(((LastAxisValue[2]+1000)/2000)*255);
                if mainform.JoystickEvents[2].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[2].Befehl.OnValue) and (value<=mainform.JoystickEvents[2].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[2].ID, value);
              end;
              LastAxisValue[2]:=CalibratedPos;
            end;
          end;
        end;
        3:
        begin
          CalibratedPos:=Pos-mainform.JoystickEvents[3].offset;

          if Radiobutton2.Checked then
          begin
            if mainform.JoystickEvents[3].positionrelativ then
            begin
              LastAxisValue[3]:=CalibratedPos;

              if (Pos<>0) or mainform.JoystickEvents[3].PermanentUpdate then
              begin
                if (ActualPosition[3]<1000) or (ActualPosition[3]>-1000) then
                  ActualPosition[3]:=ActualPosition[3]+(CalibratedPos/mainform.JoystickEvents[3].beschleunigung*(abs(CalibratedPos)/5));

                if ActualPosition[3]>1000 then
                  ActualPosition[3]:=1000;
                if ActualPosition[3]<-1000 then
                  ActualPosition[3]:=-1000;

                if mainform.JoystickEvents[3].UseEvent then
                begin
                  PositionXY.Left:=round(((ActualPosition[3]+1000)/2000)*255)-(PositionXY.Width div 2);
                  value:=round(((ActualPosition[3]+1000)/2000)*255);
                  if mainform.JoystickEvents[3].invert then
                    value:=255-value;
                  //if (value>=mainform.JoystickEvents[3].Befehl.OnValue) and (value<=mainform.JoystickEvents[3].Befehl.OffValue) then
                    mainform.StartBefehl(mainform.JoystickEvents[3].ID, value);
                  PositionXYMoved;
                end;
              end;
            end else
            if (LastAxisValue[3]<>CalibratedPos) or mainform.JoystickEvents[3].PermanentUpdate then
            begin
              LastAxisValue[3]:=CalibratedPos;

              if mainform.JoystickEvents[3].UseEvent then
              begin
                PositionXY.Top:=round(((LastAxisValue[3]+1000)/1000)*fadenkreuz.Height-PositionXY.Height/2);
                value:=round(((LastAxisValue[3]+1000)/2000)*255);
                if mainform.JoystickEvents[3].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[3].Befehl.OnValue) and (value<=mainform.JoystickEvents[3].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[3].ID, value);
                PositionXYMoved;
              end;
            end;
          end else
          begin
            if (LastAxisValue[3]<>CalibratedPos) or mainform.JoystickEvents[3].PermanentUpdate then
            begin
              if mainform.JoystickEvents[3].UseEvent then
              begin
                value:=round(((LastAxisValue[3]+1000)/2000)*255);
                if mainform.JoystickEvents[3].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[3].Befehl.OnValue) and (value<=mainform.JoystickEvents[3].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[3].ID, value);
              end;
              LastAxisValue[3]:=CalibratedPos;
            end;
          end;
        end;

        4:
        begin
          CalibratedPos:=Pos-mainform.JoystickEvents[4].offset;

          if Radiobutton2.Checked then
          begin
            if (LastAxisValue[4]<>CalibratedPos) or mainform.JoystickEvents[4].PermanentUpdate then
            begin
              LastAxisValue[4]:=CalibratedPos;
              if mainform.JoystickEvents[4].UseEvent then
              begin
                value:=round(((LastAxisValue[4]+1000)/2000)*255);
                if mainform.JoystickEvents[4].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[4].Befehl.OnValue) and (value<=mainform.JoystickEvents[4].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[4].ID, value);
{$WARNINGS OFF}
                Progressbar1.Position:=2000-round(((LastAxisValue[4]+Range)/(Range*2))*2000);
{$WARNINGS ON}
              end;
            end;
          end;
          if Radiobutton3.Checked then
          begin
            if (mainform.JoystickEvents[4].positionrelativ) or mainform.JoystickEvents[4].PermanentUpdate then
            begin
              LastAxisValue[4]:=CalibratedPos;

              if (Pos<>0) then
              begin
                if (ActualPosition[4]<1000) or (ActualPosition[4]>-1000) then
                  ActualPosition[4]:=ActualPosition[4]+(CalibratedPos/mainform.JoystickEvents[4].beschleunigung*(abs(CalibratedPos)/5));

                if ActualPosition[4]>1000 then
                  ActualPosition[4]:=1000;
                if ActualPosition[4]<-1000 then
                  ActualPosition[4]:=-1000;

                if mainform.JoystickEvents[4].UseEvent then
                begin
                  PositionXY.Left:=round(((ActualPosition[4]+1000)/2000)*255)-(PositionXY.Width div 2);
                  value:=round(((ActualPosition[4]+1000)/2000)*255);
                  if mainform.JoystickEvents[4].invert then
                    value:=255-value;
                  //if (value>=mainform.JoystickEvents[4].Befehl.OnValue) and (value<=mainform.JoystickEvents[4].Befehl.OffValue) then
                    mainform.StartBefehl(mainform.JoystickEvents[4].ID, value);
                  PositionXYMoved;
                end;
              end;
            end else
            if (LastAxisValue[4]<>CalibratedPos) or mainform.JoystickEvents[4].PermanentUpdate then
            begin
              LastAxisValue[4]:=CalibratedPos;

              if mainform.JoystickEvents[4].UseEvent then
              begin
                PositionXY.Left:=round(((LastAxisValue[4]+1000)/1000)*fadenkreuz.Width-PositionXY.Width/2);
                value:=round(((LastAxisValue[4]+1000)/2000)*255);
                if mainform.JoystickEvents[4].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[4].Befehl.OnValue) and (value<=mainform.JoystickEvents[4].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[4].ID, value);
                PositionXYMoved;
              end;
            end;
          end else
          begin
            if (LastAxisValue[4]<>CalibratedPos) or mainform.JoystickEvents[4].PermanentUpdate then
            begin
              if mainform.JoystickEvents[4].UseEvent then
              begin
                value:=round(((LastAxisValue[4]+1000)/2000)*255);
                if mainform.JoystickEvents[4].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[4].Befehl.OnValue) and (value<=mainform.JoystickEvents[4].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[4].ID, value);
              end;
              LastAxisValue[4]:=CalibratedPos;
            end;
          end;
        end;
        5:
        begin
          CalibratedPos:=Pos-mainform.JoystickEvents[5].offset;

          if Radiobutton3.Checked then
          begin
            if mainform.JoystickEvents[5].positionrelativ then
            begin
              LastAxisValue[5]:=CalibratedPos;

              if (Pos<>0) or mainform.JoystickEvents[5].PermanentUpdate then
              begin
                if (ActualPosition[5]<1000) or (ActualPosition[5]>-1000) then
                  ActualPosition[5]:=ActualPosition[5]+(CalibratedPos/mainform.JoystickEvents[5].beschleunigung*(abs(CalibratedPos)/5));

                if ActualPosition[5]>1000 then
                  ActualPosition[5]:=1000;
                if ActualPosition[5]<-1000 then
                  ActualPosition[5]:=-1000;

                if mainform.JoystickEvents[5].UseEvent then
                begin
                  PositionXY.Left:=round(((ActualPosition[5]+1000)/2000)*255)-(PositionXY.Width div 2);
                  value:=round(((ActualPosition[5]+1000)/2000)*255);
                  if mainform.JoystickEvents[5].invert then
                    value:=255-value;
                  //if (value>=mainform.JoystickEvents[5].Befehl.OnValue) and (value<=mainform.JoystickEvents[5].Befehl.OffValue) then
                    mainform.StartBefehl(mainform.JoystickEvents[5].ID, value);
                  PositionXYMoved;
                end;
              end;
            end else
            if (LastAxisValue[5]<>CalibratedPos) or mainform.JoystickEvents[5].PermanentUpdate then
            begin
              LastAxisValue[5]:=CalibratedPos;

              if mainform.JoystickEvents[5].UseEvent then
              begin
                PositionXY.Top:=round(((LastAxisValue[5]+1000)/1000)*fadenkreuz.Height-PositionXY.Height/2);
                value:=round(((LastAxisValue[5]+1000)/2000)*255);
                if mainform.JoystickEvents[5].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[5].Befehl.OnValue) and (value<=mainform.JoystickEvents[5].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[5].ID, value);
                PositionXYMoved;
              end;
            end;
          end else
          begin
            if (LastAxisValue[5]<>CalibratedPos) or mainform.JoystickEvents[5].PermanentUpdate then
            begin
              if mainform.JoystickEvents[5].UseEvent then
              begin
                value:=round(((LastAxisValue[5]+1000)/2000)*255);
                if mainform.JoystickEvents[5].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[5].Befehl.OnValue) and (value<=mainform.JoystickEvents[5].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[5].ID, value);
              end;
              LastAxisValue[5]:=CalibratedPos;
            end;
          end;
        end;

        6:
        begin
          CalibratedPos:=Pos-mainform.JoystickEvents[6].offset;

          if Radiobutton4.Checked then
          begin
            if mainform.JoystickEvents[6].positionrelativ then
            begin
              LastAxisValue[6]:=CalibratedPos;                                

              if (Pos<>0) or mainform.JoystickEvents[6].PermanentUpdate then
              begin
                if (ActualPosition[6]<1000) or (ActualPosition[6]>-1000) then
                  ActualPosition[6]:=ActualPosition[6]+(CalibratedPos/mainform.JoystickEvents[6].beschleunigung*(abs(CalibratedPos)/5));

                if ActualPosition[6]>1000 then
                  ActualPosition[6]:=1000;
                if ActualPosition[6]<-1000 then
                  ActualPosition[6]:=-1000;

                if mainform.JoystickEvents[6].UseEvent then
                begin
                  PositionXY.Left:=round(((ActualPosition[6]+1000)/2000)*255)-(PositionXY.Width div 2);
                  value:=round(((ActualPosition[6]+1000)/2000)*255);
                  if mainform.JoystickEvents[6].invert then
                    value:=255-value;
                  //if (value>=mainform.JoystickEvents[6].Befehl.OnValue) and (value<=mainform.JoystickEvents[6].Befehl.OffValue) then
                    mainform.StartBefehl(mainform.JoystickEvents[6].ID, value);
                  PositionXYMoved;
                end;
              end;
            end else
            if (LastAxisValue[6]<>CalibratedPos) or mainform.JoystickEvents[6].PermanentUpdate then
            begin
              LastAxisValue[6]:=CalibratedPos;

              if mainform.JoystickEvents[6].UseEvent then
              begin
                PositionXY.Left:=round(((LastAxisValue[6]+1000)/1000)*fadenkreuz.Width-PositionXY.Width/2);
                value:=round(((LastAxisValue[6]+1000)/2000)*255);
                if mainform.JoystickEvents[6].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[6].Befehl.OnValue) and (value<=mainform.JoystickEvents[6].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[6].ID, value);
                PositionXYMoved;
              end;
            end;
          end else
          begin
            if (LastAxisValue[6]<>CalibratedPos) or mainform.JoystickEvents[6].PermanentUpdate then
            begin
              if mainform.JoystickEvents[6].UseEvent then
              begin
                value:=round(((LastAxisValue[6]+1000)/2000)*255);
                if mainform.JoystickEvents[6].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[6].Befehl.OnValue) and (value<=mainform.JoystickEvents[6].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[6].ID, value);
              end;
              LastAxisValue[6]:=CalibratedPos;
            end;
          end;
        end;
        7:
        begin
          CalibratedPos:=Pos-mainform.JoystickEvents[7].offset;

          if Radiobutton4.Checked then
          begin
            if mainform.JoystickEvents[7].positionrelativ then
            begin
              LastAxisValue[7]:=CalibratedPos;

              if (Pos<>0) or mainform.JoystickEvents[7].PermanentUpdate then
              begin
                if (ActualPosition[7]<1000) or (ActualPosition[7]>-1000) then
                  ActualPosition[7]:=ActualPosition[7]+(CalibratedPos/1000*(abs(CalibratedPos)/5));

                if ActualPosition[7]>1000 then
                  ActualPosition[7]:=1000;
                if ActualPosition[7]<-1000 then
                  ActualPosition[7]:=-1000;

                if mainform.JoystickEvents[7].UseEvent then
                begin
                  PositionXY.Left:=round(((ActualPosition[7]+1000)/2000)*255)-(PositionXY.Width div 2);
                  value:=round(((ActualPosition[7]+1000)/2000)*255);
                  if mainform.JoystickEvents[7].invert then
                    value:=255-value;
                  //if (value>=mainform.JoystickEvents[7].Befehl.OnValue) and (value<=mainform.JoystickEvents[7].Befehl.OffValue) then
                    mainform.StartBefehl(mainform.JoystickEvents[7].ID, value);
                  PositionXYMoved;
                end;
              end;
            end else
            if (LastAxisValue[7]<>CalibratedPos) or mainform.JoystickEvents[7].PermanentUpdate then
            begin
              LastAxisValue[7]:=CalibratedPos;

              if mainform.JoystickEvents[7].UseEvent then
              begin
                PositionXY.Top:=round(((LastAxisValue[7]+1000)/1000)*fadenkreuz.Height-PositionXY.Height/2);
                value:=round(((LastAxisValue[7]+1000)/2000)*255);
                if mainform.JoystickEvents[7].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[7].Befehl.OnValue) and (value<=mainform.JoystickEvents[7].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[7].ID, value);
                PositionXYMoved;
              end;
            end;
          end else
          begin
            if (LastAxisValue[7]<>CalibratedPos) or mainform.JoystickEvents[7].PermanentUpdate then
            begin
              if mainform.JoystickEvents[7].UseEvent then
              begin
                value:=round(((LastAxisValue[7]+1000)/2000)*255);
                if mainform.JoystickEvents[7].invert then
                  value:=255-value;
                //if (value>=mainform.JoystickEvents[7].Befehl.OnValue) and (value<=mainform.JoystickEvents[7].Befehl.OffValue) then
                  mainform.StartBefehl(mainform.JoystickEvents[7].ID, value);
              end;
              LastAxisValue[7]:=CalibratedPos;
            end;
          end;
        end;
      end;
    end;

    //Buttons
    s:='';
    for i := 0 to NumButtons-1 do
    begin
      if joystickform.Visible then
      begin
        if(Button[i].ChangeState=bcPressed)
        then Listbox1.ItemIndex:=ListBox1.Items.Add(Format(_('Button %d gedrückt'), [i+1]))else
        if(Button[i].ChangeState=bcReleased)
        then Listbox1.ItemIndex:=ListBox1.Items.Add(Format(_('Button %d losgelassen'), [i+1]))else
        if(Button[i].ChangeState=bcRepeated)
        then Listbox1.ItemIndex:=ListBox1.Items.Add(Format(_('Button %d gehalten'), [i+1]));
        if(ListBox1.Items.Count>9)then
          ListBox1.Items.Delete(0);
      end;

      // Aktion für Buttons hier
      if not Button[i].Down then
      begin
        if buttonpressed[i] then
        begin
          buttonpressed[i]:=false;

          if mainform.JoystickEvents[i+12].UseEvent then
          begin
            if mainform.JoystickEvents[i+12].invert then
              mainform.StartBefehl(mainform.JoystickEvents[i+12].ID, 255)
            else
              mainform.StartBefehl(mainform.JoystickEvents[i+12].ID, 0);
          end;

          if joystickform.Visible then
          begin
            TButton(FindComponent('Button'+inttostr(i+1))).Caption:=inttostr(i+1);
          end;
        end;
      end else
      begin
        if not buttonpressed[i] then
        begin
          buttonpressed[i]:=true;

          if mainform.JoystickEvents[i+12].UseEvent then
          begin
            if mainform.JoystickEvents[i+12].invert then
              mainform.StartBefehl(mainform.JoystickEvents[i+12].ID, 0)
            else
              mainform.StartBefehl(mainform.JoystickEvents[i+12].ID, 255);
          end;

          if joystickform.Visible then
          begin
            TButton(FindComponent('Button'+inttostr(i+1))).Caption:='['+inttostr(i+1)+']';

            joysticksetupform.ListBox1.ItemIndex:=i+12;
            for k:=0 to joysticksetupform.ListBox1.Items.Count-1 do
              joysticksetupform.ListBox1.Selected[k]:=false;
            joysticksetupform.ListBox1.Selected[i+12]:=true;
          end;
        end;
      end;
    end;

    if joystickform.Visible then
    begin
      //Hats
      Listbox2.Items.Clear;
      for i:=0 to NumHats-1 do
        Listbox2.items.add(_('Hat_')+Inttostr(i)+': '+HatToStr(Hat[i]));
    end;
  end;

  {$IFNDEF USETIMER}
  t2:=GetTickCount;
  inc(xy);
  if((t2-t3)>500)then
  begin
      try
        Caption:=_('Joysticksteuerung - ')+FloatToStrF(1000*xy/(t2-t3),ffFixed,7,2)+' updates/s';
      except
        Caption:=_('Joysticksteuerung');
      end;
      t3:=t2;
      xy:=0;
  end;
  ticks:=t2;
  {$ENDIF}
end;

procedure Tjoystickform.InitializeJoystick;
begin
    {$IFNDEF USETIMER}
    ticks:=GetTickCount;
    t3:=ticks;
    xy:=0;
    {$ELSE}
    Timer1.Enabled:=True;
    {$ENDIF}
    with StringGrid1 do
    begin
        DefaultRowHeight:=15;
        Cells[0,0]:=_('Achsen');
        Cells[1,0]:=_('Position');
        Cells[2,0]:=_('[u/s]');
        Cells[3,0]:=_('[u/s²]');
        Cells[4,0]:=_('Bereich');
        RowCount:=9;
        ColWidths[0]:=50;
        ColWidths[1]:=50;
        ColWidths[2]:=50;
        ColWidths[3]:=50;
        ColWidths[4]:=50;
    end;

    gcp:=nil;
    SearchDeviceBtnClick(nil);
end;

procedure Tjoystickform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tjoystickform.FormShow(Sender: TObject);
begin
  Checkbox1.checked:=mainform.ActiveJoystickRibbonBox.Down;
end;

procedure Tjoystickform.CreateParams(var Params:TCreateParams);
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
