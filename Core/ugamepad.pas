unit uGamePad;

{
    uGamePad
    - written by Markus Rudolph aka Markhoernchen
    - Version 0.2.2
    - created on 2006/11/28
    - last edit on 2006/12/02
    - Homepage: http://people.freenet.de/derfreunddeinermutter/

    This unit contains the class TGamePad which allows you to handle your
    game pad or joy1stick via the DirectInput8 interface.
    It supports six axis, two sliders, 32 buttons and four hats.
    You can additionally set the dead zone, the max zone and the range of each
    axis.

    Requirements:
        - DirectX 8
        - delphi-dx9sdk
        - a game pad of course ;-)

    Feature-History:
        Version 0.1:
            TCustomGamePad
            - max.  8 axes (incl. 2 sliders)
            - max. 32 buttons
            - max.  4 hats

        Version 0.2.1;
            TGamePad
            - axes contains information about current position, velocity and
              acceleration
            - button have change states to signal a pressing, a releasing and a
              timed "pressing" of the concerning button

        Version 0.2.2:
        - restructured entire unit
        - written the wrapper class TCustomDInputDevice as parent class of
          TCustomGamePad

    License:
        - You can edit or just use it for private or commercial uses, but be so kind
          to mention my name in the credits.

    This unit uses the DirectInput and connected unit to run.
    Download it from, if you need:
        - http://clootie.ru
        - http://sourceforge.net/projects/delphi-dx9sdk

}

interface

uses
    DirectInput, Math, Windows, SysUtils, Classes;

const
    JOY_BTN_INTERVAL_DEFAULT: Cardinal = 333; //ms
    JOY_AXIS_DEADZONE_DEFAULT: Byte    =   5; //%
    JOY_AXIS_MAXZONE_DEFAULT: Byte     = 100; //%

type
    ////////////////////////////////////////////////////////////////////////////
    //                     Direct Input Wrapper Class                        ///
    ////////////////////////////////////////////////////////////////////////////
    TCustomDInputDevice = class
    protected
        bEnabled: Boolean;
        Dev: IDirectInputDevice8;
        guidProduct,
        guidInstance: TGUID;
        sProductName,
        sInstanceName: String;
        procedure Initialize; virtual; abstract;
        procedure Finalize; virtual; abstract;
        procedure CreateDevice(GUID: TGUID);

        function Enable: Boolean; virtual;
        function Disable: Boolean; virtual;
        procedure SetEnabled(V: Boolean); virtual;

        procedure EnumObjects; virtual;
        procedure EnumObjCallBack(var obj: TDIDeviceObjectInstanceA); virtual;
    public
        constructor Create; virtual;
        destructor Destroy; override;
        function Update: Boolean; virtual;
        procedure RunControlPanel;

        property Enabled: Boolean read bEnabled write SetEnabled;

        property ProductName: String read sProductName;
        property InstanceName: String read sInstanceName;
        property ProductGUID: TGUID read guidProduct;
        property InstanceGUID: TGUID read guidInstance;
    end;


    ////////////////////////////////////////////////////////////////////////////
    ///                            Game Pad Area                             ///
    ////////////////////////////////////////////////////////////////////////////
    PHatState = ^THatState;
    THatState = (hsCentered, hsUp, hsRight, hsDown, hsLeft, hsRightUp,
        hsRightDown, hsLeftUp, hsLeftDown);
    THatStateArray = array[0..3]of THatState;
    PHatStateArray = ^THatStateArray;

    TJoyButtonChangeState = (bcNoChange, bcPressed, bcReleased, bcRepeated);
    {
        TJoyButton.Down
            True  = Button is pressed
            False = Button is not pressed
        TJoyButton.Interval
            - represents the "repeat time", see ChangeState
            - 0, deactivates the 'bcRepeated' state
        TJoyButton.ChangeState
            bcNoChange = "Down" didn't change since the last update (but the
                         Button can be pressed)
            bcPressed  = "Down" changed from 'false' to 'true' since the last
                         update -=> the button was pressed
            bcReleased = "Down" changed from 'true' to 'false' since the last
                         update -=> the button was released
            bcRepeated = the "repeat time" represented by "Interval" elapsed
                         -=> the button was repeatly "pressed"
                         (useful for menus or shooter games)
        TJoyButton.ClickAge
            - interaly used for the 'bcRepeated' state
    }
    PJoyButton = ^TJoyButton;
    TJoyButton = class
    private
        bDown: Boolean;
        csChangeState: TJoyButtonChangeState;
        dwInterval,
        dwClickAge: Cardinal;
        procedure SetDown(V: Boolean; dTime: Cardinal);
        procedure Reset;
    public
        constructor Create;
        destructor Destroy;

        property Down: Boolean read bDown;
        property ChangeState: TJoyButtonChangeState read csChangeState;
        property Interval: Cardinal read dwInterval write dwInterval;
    end;
    TJoyButtonArray = array[0..31] of TJoyButton;
    PJoyButtonArray = ^TJoyButtonArray;

    TAxisType = (atX,atY,atZ,atRX,atRY,atRZ,atS1,atS2);
    TJoyAxis = class
    protected
        bIsSlider: Boolean;
        bEnabled: Boolean;
        iPos,
        iVelo,
        iAccel: Integer;
        ubDeadZone,
        ubMaxZone: Byte;
        dwRange: Cardinal;
        procedure SetPos(aPos, dTime: Integer);
        procedure SetByteVal(Index: Integer; V: Byte);
        procedure SetRange(V: Cardinal);
        procedure Reset;
    public
        constructor Create;
        destructor Destroy;

        property IsSlider: Boolean read bIsSlider;
        property Enabled: Boolean read bEnabled;
        property Pos: Integer read iPos;
        property Velo: Integer read iVelo;
        property Accel: Integer read iAccel;

        property DeadZone: Byte index 0 read ubDeadZone write SetByteVal;
        property MaxZone: Byte index 1 read ubMaxZone write SetByteVal;
        property Range: Cardinal read dwRange write SetRange;
    end;

    TCustomGamePad = class(TCustomDInputDevice)
    protected
        iID: integer;

        dwTimeStamp: Cardinal;

        dwNumAxes,
        dwNumButtons,
        dwNumHats,
        dwNumSliders: Cardinal;

        aaxAxes: array[0..7]of TJoyAxis;
        phsHats: PHatState;
        pbsButtons: PJoyButton;

        function GetAxisP(Index: Integer): TJoyAxis; virtual;
        function GetAxis(Axis: TAxisType): TJoyAxis;
        function GetHat(Index: Integer): THatState; virtual;
        function GetButton(Index: Integer): TJoyButton; virtual;

        procedure EnumObjCallBack(var obj: TDIDeviceObjectInstanceA); override;
        procedure SetID(ID: Integer);
        function Enable: Boolean; override;
        function Disable: Boolean; override;
        procedure Initialize; override;
        procedure Finalize; override;

        property Axes[Axis: TAxisType]: TJoyAxis read GetAxis;
        property X: TJoyAxis index 0 read GetAxisP;
        property Y: TJoyAxis index 1 read GetAxisP;
        property Z: TJoyAxis index 2 read GetAxisP;
        property RX: TJoyAxis index 3 read GetAxisP;
        property RY: TJoyAxis index 4 read GetAxisP;
        property RZ: TJoyAxis index 5 read GetAxisP;
        property SliderA: TJoyAxis index 6 read GetAxis;
        property SliderB: TJoyAxis index 7 read GetAxis;

        property Button[Index: Integer]: TJoyButton read GetButton;
        property Hat[Index: Integer]: THatState read GetHat;

        property NumAxes: Cardinal read dwNumAxes;
        property NumButtons: Cardinal read dwNumButtons;
        property NumHats: Cardinal read dwNumHats;
        property NumSliders: Cardinal read dwNumSliders;
    public
        constructor Create(ID: Integer);
        destructor Destroy; override;
        function Update: Boolean; override;

        procedure SetRange(Range: Cardinal);
        procedure SetDeadZone(Percent: Byte);
        procedure SetMaxZone(Percent: Byte);

        property ID: Integer read iID write SetID;
    end;

    TGamePad = class(TCustomGamePad)
    protected
    public
        //axes
        property Axes;
        property X;
        property Y;
        property Z;
        property RX;
        property RY;
        property RZ;
        property SliderA;
        property SliderB;

        //capabilities
        property NumAxes;
        property NumButtons;
        property NumHats;
        property NumSliders;

        //buttons
        property Button;

        //hats
        property Hat;
    end;

(*
    Mouse
        Maybe for a future use...
        + more than one mouse can be handled
        - who would use this???

    ////////////////////////////////////////////////////////////////////////////
    ///                              Mouse Area                              ///
    ////////////////////////////////////////////////////////////////////////////
    TMouseButtonChangeState = (mcNoChange, mcPressed, mcReleased);
    TMouseButton = class
    protected
        bDown: Boolean;
        mcChangeState: TMouseButtonChangeState;
        procedure Reset;
        procedure SetDown(V: Boolean);
    public
        constructor Create;
        property ChangeState: TMouseButtonChangeState read mcChangeState;
        property Down: Boolean read bDown;
    end;
    TCustomMouse = class(TCustomDInputDevice)
    protected
        iID: Integer;
        procedure SetID(ID: Integer);
        function Enable: Boolean; override;
        function Disable: Boolean; override;
        procedure Initialize; override;
        procedure Finalize; override;
    public
        constructor Create(ID: Integer);
        destructor Destroy; override;
        function Update: Boolean; override;
        property ID: Integer read iID write SetID;
    end;

    TMouse = class(TCustomMouse)
    public

    end;                       *)

//functions
    procedure UpdateDevices;
    {updates the list of attached game controllers, keyboards and mouse
     pointers}
    function GamePadCount: Integer;
    function GamePad(Index: Integer): TDIDeviceInstanceA;

    function DIEnumDeviceObjectsCallback(var lpddoi: TDIDeviceObjectInstanceA; pvRef : Pointer): LongBool; stdcall;
    function DIEnumDevicesCallback(var lpddi: TDIDeviceInstanceA; pvRef: Pointer): BOOL; stdcall;

var
    DI: IDirectInput8;

implementation

var
    CustomDIDList,
    joyDevList: TList;


//-----=> TCustomDInputDevice <=----------------------------------------------//
constructor TCustomDInputDevice.Create;
begin
    //register in the custom device list (needed for enumerating objects)
    CustomDIDList.Add(Self);

    //init props
    FillChar(guidProduct, SizeOf(TGUID), 0);
    FillChar(guidInstance, SizeOf(TGUID), 0);
    sProductName:='';
    sInstanceName:='';

    //init internal vars
    Dev:=nil;
    bEnabled:=False;
end;

destructor TCustomDInputDevice.Destroy;
begin
    Finalize;

    //unregister
    with CustomDIDList do
        CustomDIDList.Delete(IndexOf(Self));
    inherited;
end;

function TCustomDInputDevice.Enable: Boolean;
begin
    Result:=False;
    if(bEnabled)or(Dev=nil)then
        Exit;
    Dev.Acquire;
    bEnabled:=True;
    Result:=True;
end;

function TCustomDInputDevice.Disable: Boolean;
begin
    Result:=False;
    if not(bEnabled)then
        Exit;
    Dev.Unacquire;
    bEnabled:=False;
    Result:=True;
end;

procedure TCustomDInputDevice.SetEnabled(V: Boolean);
begin
    if(bEnabled<>V)then
        if(V)
        then Enable
        else Disable;
end;

procedure TCustomDInputDevice.CreateDevice(GUID: TGUID);
begin
    DI.CreateDevice(guidInstance, Dev, nil);
end;

function TCustomDInputDevice.Update: Boolean;
begin
    //device is still attached?
    if(Dev=nil)or(Failed(Dev.Poll))then
    begin
        Disable;                             //no -=> disable
        Result:=False;
    end else Result:=True;
end;

procedure TCustomDInputDevice.EnumObjects;
//starts enumerating objects
begin
    if(Assigned(Dev))then
        Dev.EnumObjects(DIEnumDeviceObjectsCallback, Self, DIDFT_ALL);
end;

procedure TCustomDInputDevice.EnumObjCallBack(var obj: TDIDeviceObjectInstanceA);
//callback proc for enumerating device objects
begin
end;

procedure TCustomDInputDevice.RunControlPanel;
//runs the control panel of the device
begin
    if(Assigned(dev))then
        Dev.RunControlPanel(0,0);
end;
//-----=> END TCustomDInputDevice <=------------------------------------------//







////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///                                                                          ///
///                                GamePad Area                              ///
///                                                                          ///
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//-----=> TJoyButton <=-------------------------------------------------------//
constructor TJoyButton.Create;
begin
    inherited;
    Reset;
end;

destructor TJoyButton.Destroy;    
begin

    inherited;
end;

procedure TJoyButton.Reset;
begin
    bDown:=False;
    csChangeState:=bcNoChange;
    dwInterval:=JOY_BTN_INTERVAL_DEFAULT;
    dwClickAge:=0;
end;

procedure TJoyButton.SetDown(V: Boolean; dTime: Cardinal);
begin
    //update change state
    if(V=bDown)then
    begin
        if(V)and(dwInterval>0)then
        begin
            Inc(dwClickAge, dTime);
            if(dwClickAge>dwInterval)then
            begin
                dwClickAge:=dwClickAge mod dwInterval;
                csChangeState:=bcRepeated;
            end else
                csChangeState:=bcNoChange;
        end else
            csChangeState:=bcNoChange;
    end else
    if(V)and not(bDown)then //button pressed
    begin
        csChangeState:=bcPressed;
        dwClickAge:=0;
    end else               //button released
        csChangeState:=bcReleased;

    //update down-state
    bDown:=V;
end;
//-----=> END TJoyButton <=---------------------------------------------------//


//-----=> TJoyAxis <=---------------------------------------------------------//
constructor TJoyAxis.Create;
//creates an JoyAxis object
begin
    inherited;
    bIsSlider:=False;
    bEnabled:=False;
    ubDeadZone:=JOY_AXIS_DEADZONE_DEFAULT;
    ubMaxZone:=JOY_AXIS_MAXZONE_DEFAULT;
    dwRange:=1000;
    Reset;
end;

destructor TJoyAxis.Destroy;
begin

    inherited;
end;

procedure TJoyAxis.Reset;
begin
    iPos:=0;
    iVelo:=0;
    iAccel:=0;
end;

procedure TJoyAxis.SetPos(aPos, dTime: Integer);
{
    - this procedure converts a axis position value (0..$FFFF) to an user
      definied axis position value (0..Range for sliders, -Range..Range for
      normal axes) and considers the since the last update elapsed time, the
      range, the dead zone and the max zone (0..100%)
}
    var iMin, iMax, {iOldPos,} iOldVelo: Integer;
        iSign: ShortInt;
begin
    if(bEnabled)then
    begin
        //---=> calculate position of this axis
//        iOldPos:=iPos;

        iMin:=(ubDeadZone*$FFFF)div 100;
        iMax:=(ubMaxZone*$FFFF)div 100;

        if(bIsSlider)then
        begin
            if(aPos>iMax)then
                aPos:=iMax;
            Dec(aPos, iMin);
            if(aPos<0)then
                aPos:=0;
        end else
        begin
            iMin:=iMin div 2;
            iMax:=iMax div 2;

            Dec(aPos, $8000);
            iSign:=Sign(aPos);
            if(Abs(aPos)>iMax)then
                aPos:=iSign*iMax;

            iOldVelo:=(Abs(aPos)-iMin);
            aPos:=iSign*iOldVelo*Byte(iOldVelo>0);
        end;

{$WARNINGS OFF}
        iPos:=(aPos*dwRange)div(iMax-iMin);
{$WARNINGS ON}

        //---=> calculate velocity
{
        iOldVelo:=iVelo;
        try
            iVelo:=((iPos-iOldPos)*1000)div dTime;
        except
            iVelo:=0;
        end;
}

        //---=> calculate acceleration
{
        try
            iAccel:=((iVelo-iOldVelo)*1000)div dTime;
        except
            iAccel:=0;
        end;
}
    end else
    begin
        iPos:=0;
        iVelo:=0;
        iAccel:=0;
    end;
end;

procedure TJoyAxis.SetByteVal(Index: Integer; V: Byte);
{
    - sets the dead zone for Index != 1 and the max zone for Index = 1
    - both zones are percentage values (0..100%)
}
begin
    if(V>100)then
        V:=100;

    if(Index=1)then   //set max zone
    begin
        if(V>ubDeadZone)then
            ubMaxZone:=V;
    end else          //set dead zone
    begin
        if(V<ubMaxZone)then
            ubDeadZone:=V;
    end;
end;

procedure TJoyAxis.SetRange(V: Cardinal);
//sets the range of the axis (a value between 0 and 65535)
begin
    if(V>$FFFF)then
        V:=$FFFF;
    dwRange:=V;
end;
//-----=> END TJoyAxis <=-----------------------------------------------------//






//-----=> TCustomGamePad <=---------------------------------------------------//
constructor TCustomGamePad.Create(ID: Integer);
// creates a TCustomGamePad object
begin
    inherited Create;
    FillChar(aaxAxes, SizeOf(aaxAxes), 0);
    phsHats:=nil;
    pbsButtons:=nil;
    Self.ID:=ID;
    Enabled:=True;
end;

destructor TCustomGamePad.Destroy;
begin

    inherited;
end;

procedure TCustomGamePad.EnumObjCallback(var obj: TDIDeviceObjectInstanceA);
{
    - this function is used to count the single objects of the device,
      like axes, sliders, buttons and hats (POVs)
    - it is also used to enable the used axes
}
    function CompareGUIDs(g1,g2: TGUID): Boolean;
    begin
        Result:=CompareMem(@g1, @g2, SizeOf(TGUID));
    end;
    var b: array[0..5]of Boolean;
        i: Byte;
        g: PGUID;
begin
    if(CompareGUIDs(GUID_Button, obj.guidType))then Inc(dwNumButtons) else //Buttons
    begin
        FillChar(b, SizeOf(b), 0);                                         //Axis
        i:=0;
        while(i<6)do
        begin
            case i of
                1: g:=@GUID_YAxis;
                2: g:=@GUID_ZAxis;
                3: g:=@GUID_RXAxis;
                4: g:=@GUID_RYAxis;
                5: g:=@GUID_RZAxis;
                else g:=@GUID_XAxis;
            end;
            b[i]:=CompareGUIDs(g^, obj.guidType);
            if(b[i])then
                Break;
            Inc(i);
        end;

        if(b[i])then
        begin
            Inc(dwNumAxes);
            aaxAxes[i].bEnabled:=True;
        end else
        if(CompareGUIDs(GUID_Slider, obj.guidType))then                    //Sliders
        begin
            Inc(dwNumSliders);
            if(dwNumSliders=2)then
            begin
                aaxAxes[Ord(atS2)].bEnabled:=True;
                aaxAxes[Ord(atS2)].bIsSlider:=True;
            end else
            begin
                aaxAxes[Ord(atS1)].bEnabled:=True;
                aaxAxes[Ord(atS1)].bIsSlider:=True;
            end;
        end else
        if(CompareGUIDs(GUID_POV, obj.guidType))then Inc(dwNumHats);       //Hats
    end;
end;

procedure TCustomGamePad.SetID(ID: Integer);
{
    - sets the new index of the game control device concerning the position in
      the joystick device list
}
    var pdevInfo: ^TDIDeviceInstance;
begin
    Finalize;
    iID:=ID;
    if(iID<joyDevList.Count)then
    begin
        pdevInfo:=joyDevList[ID];
        with pdevInfo^ do
        begin
            Move(guidProduct, Self.guidProduct, SizeOf(TGUID));
            Move(guidInstance, Self.guidInstance, SizeOf(TGUID));
            sProductName:=tszProductName;
            sInstanceName:=tszInstanceName;
        end;
        Initialize;
    end else iID:=-1;
end;

procedure TCustomGamePad.Initialize;
{
    - initializes the device:
        - creates the device
        - sets the data format
        - sets the cooperative level

        - enums device objects
        - initializes device object depended vars
}
    var b: Boolean; i: Integer;
        pH: PHatStateArray;
        pBtns: PJoyButtonArray;
begin
    b:=Enabled;
    Finalize;

    //reset properties
    dwTimeStamp:=0;
    dwNumAxes:=0;
    dwNumButtons:=0;
    dwNumHats:=0;
    dwNumSliders:=0;

    //create device
    CreateDevice(guidInstance);
    Dev.SetDataFormat(c_dfDIJoystick);
    Dev.SetCooperativeLevel(0, DISCL_NONEXCLUSIVE or DISCL_BACKGROUND);

    //--=> state init
    //axes
    for i := 0 to 7 do
        aaxAxes[i]:=TJoyAxis.Create;

    //enumerate objects
    EnumObjects;

    //hats
    if(dwNumHats>0)then
    begin
        GetMem(phsHats, dwNumHats*SizeOf(THatState));
        pH:=Pointer(phsHats);
        for i := 0 to dwNumHats-1 do
            pH^[i]:=hsCentered;
    end;

    //buttons
    if(dwNumButtons>0)then
    begin
        GetMem(pbsButtons, dwNumButtons*SizeOf(TJoyButton));
        pBtns:=Pointer(pbsButtons);
        for i := 0 to dwNumButtons-1 do
            pBtns^[i]:=TJoyButton.Create;
    end;

    Enabled:=b;
end;

procedure TCustomGamePad.Finalize;
{
    - finalizes the game control device
        - disables device
        - frees device object depended vars
}
    var i: Integer;
        pBtns: PJoyButtonArray;
begin
    if(Dev=nil)then Exit;
    Disable;
    Dev:=nil;

    if(NumHats>9)then
    begin
        FreeMem(phsHats, SizeOf(THatState)*NumHats);
        phsHats:=nil;
    end;

    if(NumButtons>0)then
    begin
        pBtns:=Pointer(pbsButtons);
        for i := 0 to NumButtons-1 do
            pBtns^[i].Free;
        FreeMem(pbsButtons, SizeOf(TJoyButton)*NumButtons);
        pbsButtons:=nil;
    end;

    for i := 0 to 7 do
    if(aaxAxes[i]<>nil)then
    begin
        aaxAxes[i].Free;
        aaxAxes[i]:=nil;
    end;
    dwTimeStamp:=0;
    dwNumAxes:=0;
    dwNumButtons:=0;
    dwNumHats:=0;
    dwNumSliders:=0;
end;

function TCustomGamePad.Enable: Boolean;
begin
    Result:=inherited Enable;
end;

function TCustomGamePad.Disable: Boolean;
    var i: Integer;
        pH: PHatState;
        pBtns: PJoyButtonArray;
begin
    Result:=inherited Disable;
    if not(Result)then
        Exit;

    //reset axes
    for i := 0 to 7 do
    if(Assigned(aaxAxes[i]))then
        aaxAxes[i].Reset;

    //reset buttons
    if(NumButtons>0)then
    begin
        pBtns:=Pointer(pbsButtons);
        for i := 0 to NumButtons-1 do
            pBtns^[i].Reset;
    end;

    //reset hats
    if(NumHats>0)then
    begin
        pH:=phsHats;
        for i := 0 to NumHats-1 do
        begin
            pH^:=hsCentered;
            Inc(pH);
        end;
    end;
end;

function TCustomGamePad.Update: Boolean;
{
    - updates axis, button and hat states
}
    function IntToHat(state: Integer): THatState;
    begin
        case state of
                0: Result:=hsUp;
             4500: Result:=hsRightUp;
             9000: Result:=hsRight;
            13500: Result:=hsRightDown;
            18000: Result:=hsDown;
            22500: Result:=hsLeftDown;
            27000: Result:=hsLeft;
            31500: Result:=hsLeftUp;
            else Result:=hsCentered;
        end;
    end;
    var Data: DIJOYSTATE;
        i: byte;
        t1, t2, dt: Cardinal;
        pH: PHatStateArray;
        pBtns: PJoyButtonArray;
begin
    Result:=inherited Update;
    if not(Result)then Exit;

    //init time vars (for btns and axes)
    t1:=dwTimeStamp;
    t2:=GetTickCount;
    dt:=t2-t1;

    //get device state
    if(Enabled)then
    begin
        Dev.GetDeviceState(SizeOf(DIJOYSTATE), @Data);
        with Data do
        begin
            //update axes
            X.SetPos(lX, dt);
            Y.SetPos(lY, dt);
            Z.SetPos(lZ, dt);
            RX.SetPos(lRx, dt);
            RY.SetPos(lRy, dt);
            RZ.SetPos(lRz, dt);
            SliderA.SetPos(rglSlider[0], dt);
            SliderB.SetPos(rglSlider[1], dt);

            //update hats
            if(NumHats>0)then
            begin
                pH:=Pointer(phsHats);
                for i := 0 to NumHats-1 do
                    pH^[i]:=IntToHat(rgdwPOV[i]);
            end;

            //update buttons
            if(NumButtons>0)then
            begin
                pBtns:=Pointer(pbsButtons);
                for i := 0 to NumButtons-1 do
                    pBtns[i].SetDown(rgbButtons[i]=$80, dt);
            end;
        end;
    end;

    //update time stamp
    dwTimeStamp:=t2;
end;

function TCustomGamePad.GetAxisP(Index: Integer): TJoyAxis;
//returns an axis considering an axis index between 0 and 7 (8 axes)
begin
    if(Index<0)then Index:=0 else
    if(Index>7)then Index:=7;
    Result:=aaxAxes[Index];
end;

function TCustomGamePad.GetAxis(Axis: TAxisType): TJoyAxis;
//returns an axis considering the value Value of Axis
begin
    Result:=GetAxisP(Ord(Axis));
end;

function TCustomGamePad.GetHat(Index: Integer): THatState;
//returns hat state
begin
{$WARNINGS OFF}
    if(Index>-1)and(Index<NumHats)
    then Result:=PHatState(Cardinal(phsHats)+Index*SizeOf(THatState))^
    else Result:=hsCentered;
{$WARNINGS ON}
end;

function TCustomGamePad.GetButton(Index: Integer): TJoyButton;
//returns "button pressed" state
begin
{$WARNINGS OFF}
    if(Index>-1)and(Index<NumButtons)
    then Result:=PJoyButton(Cardinal(pbsButtons)+Index*SizeOf(TJoyButton))^
    else Result:=nil;
{$WARNINGS ON}
end;

procedure TCustomGamePad.SetRange(Range: Cardinal);
    //sets the range of all axes
    var i: Integer;
begin
    for i := 0 to 7 do
        aaxAxes[i].Range:=Range;
end;

procedure TCustomGamePad.SetDeadZone(Percent: Byte);
    //sets the DeadZone of all axes
    var i: Integer;
begin
    for i := 0 to 7 do
        aaxAxes[i].DeadZone:=Percent;
end;

procedure TCustomGamePad.SetMaxZone(Percent: Byte);
    //sets the MaxZone of all axes
    var i: Integer;
begin
    for i := 0 to 7 do
        aaxAxes[i].MaxZone:=Percent;
end;
//-----=> END TCustomGamePad <=-----------------------------------------------//





(*
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///                                                                          ///
///                                 Mouse Area                               ///
///                                                                          ///
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//-----=> TMouseButton <=-----------------------------------------------------//
constructor TMouseButton.Create;
begin
    inherited;
    Reset;
end;

procedure TMouseButton.Reset;
begin
    bDown:=False;
    mcChangeState:=mcNoChange;
end;

procedure TMouseButton.SetDown(V: Boolean);
begin

end;
//-----=> END TMouseButton <=-------------------------------------------------//






//-----=> TCustomMouse <=-----------------------------------------------------//
constructor TCustomMouse.Create(ID: Integer);
begin
    inherited Create;
    Self.ID:=ID;
    Enabled:=True;
end;

destructor TCustomMouse.Destroy;
begin
    inherited;
end;

function TCustomMouse.Update: Boolean;
begin

end;

procedure TCustomMouse.SetID(ID: Integer);
begin

end;

function TCustomMouse.Enable: Boolean;
begin
    Result:=inherited Enable;
end;

function TCustomMouse.Disable: Boolean;
begin
    Result:=inherited Disable;
end;

procedure TCustomMouse.Initialize;
begin

end;

procedure TCustomMouse.Finalize;
begin

end;
//-----=> END TCustomMouse <=-------------------------------------------------//*)






////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///                                                                          ///
///                               Internal Stuff                             ///
///                                                                          ///
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//-----=> CALLBACK FUNCTIONS <=-----------------------------------------------//
function DIEnumDeviceObjectsCallback(var lpddoi: TDIDeviceObjectInstanceA; pvRef : Pointer): LongBool;
{
    - enumerates the objects of a DirectInput device and send the information
      about an object to the device that has requested the enumeration
}
stdcall;
    var i: Integer;
begin
    for i := 0 to CustomDIDList.Count-1 do
    if(CustomDIDList[i]=pvRef)then
    begin
        TCustomDInputDevice(pvRef).EnumObjCallBack(lpddoi);
        Break;
    end;
    Result:=DIENUM_CONTINUE;
end;

function DIEnumDevicesCallback(var lpddi: TDIDeviceInstanceA; pvRef: Pointer): BOOL; stdcall;
{
    - this function enumerates the game control devices and saves the
      information of each device in the "joyDevList"
}
    procedure AppendDev(List: TList);
        var p: ^TDIDeviceInstanceA;
    begin
        New(p);
        Move(lpddi, p^, SizeOf(TDIDeviceInstanceA));
        List.Add(p);
    end;
begin
    case lpddi.wUsagePage of
         1: if(lpddi.wUsage=4)then
                AppendDev(joyDevList);
    end;
    Result:=DIENUM_CONTINUE;
end;
//-----=> END CALLBACK FUNCTIONS <=-------------------------------------------//


//-----=> Device List <=------------------------------------------------------//
procedure ClearDevList;
{
    - clears the "JoyDevList" and frees the used memory that is used by its
      items
}
    var i: Integer;
        p: ^TDIDeviceInstanceA;
begin
    for i := 0 to joyDevList.Count-1 do
    begin
        p:=joyDevList[i];
        Dispose(p);
    end;
    joyDevList.Clear;
end;

procedure UpdateDevices;
{
    - clears the device lists and fills them with the currently attached devices
}
begin
    //clear device list
    ClearDevList;
    //enum all plugged gamepads
    DI.EnumDevices(DI8DEVCLASS_ALL, DIEnumDevicesCallback, nil, DIEDFL_ATTACHEDONLY);
end;

function GamePadCount: Integer;
begin
    Result:=joyDevList.Count;
end;

function GamePad(Index: Integer): TDIDeviceInstanceA;
begin
    Result:=TDIDeviceInstanceA(joyDevList[Index]^);
end;
//-----=> END Device List <=--------------------------------------------------//

initialization
    joyDevList:=TList.Create;
    CustomDIDList:=TList.Create;

    //init directInput
    DI:=nil;
    DirectInput8Create(hInstance, $0800, IID_IDirectInput8A, DI, nil);

    //enum all attached game controls
    UpdateDevices;
finalization
    DI:=nil;

    CustomDIDList.Free;
    ClearDevList;
    joyDevList.Free;
end.
