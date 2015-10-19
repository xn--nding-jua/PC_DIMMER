unit EstimatedTime;



interface

uses Classes;

type

   TTimeHist = record
      time : TDateTime;
      value : Integer;
   end;



   TEstimatedTime = class(TPersistent)
  private
    FValue: Integer;
    FMaxValue: Integer;
    FMinValue: Integer;
    FStarttime : TDateTime;
    FHistory : TTimeHist;
    FStepsPerSecond : Double;

    procedure SetMaxValue(const Value: Integer);
    procedure SetMinValue(const Value: Integer);
    procedure SetValue(const Value: Integer);
    function GetElapsedTime: TDateTime;
    function GetLeftTime: TDateTime;
    function GetDoneRatio: Double;
    function GetDonePercent: Integer;
    function GetStepsPerSecond: Double;

   public
      constructor Create;

      procedure Start;
      procedure Step(const x:Integer=1);

      property MinValue:Integer read FMinValue write SetMinValue;
      property MaxValue:Integer read FMaxValue write SetMaxValue;
      property Value:Integer read FValue write SetValue;

      // geschätzte Restzeit (1 Tag = 1.0)
      property LeftTime : TDateTime read GetLeftTime;

      // vergangene Zeit
      property ElapsedTime : TDateTime read GetElapsedTime;

      // Anteil der Aufgabe, die schon erledigt ist (0.0 bis 1.0)
      property DoneRatio : Double read GetDoneRatio;
      // Erledigt n Prozent
      property DonePercent: Integer read GetDonePercent;
      property StepsPerSecond:Double read GetStepsPerSecond;


   end;



function UserFriendlyTime(t : TDateTime):string;


implementation

uses SysUtils;


{ TEstimatedTime }

constructor TEstimatedTime.Create;
begin
   inherited;
end;

function TEstimatedTime.GetDonePercent: Integer;
begin
   Result := Round(DoneRatio*100.0);
end;

function TEstimatedTime.GetDoneRatio: Double;
begin
   if (MinValue < MaxValue) and (Value >= MinValue) and (Value <= MaxValue) then
      Result := (Value-MinValue) / (MaxValue-MinValue)
   else
      Result := 1.0;
end;

function TEstimatedTime.GetElapsedTime: TDateTime;
begin
   Result := Now-FStarttime;
end;

function TEstimatedTime.GetLeftTime: TDateTime;
var
   dr : Double;
begin
   dr := DoneRatio;
   if dr > 0.0 then
      Result := (ElapsedTime / dr) - ElapsedTime
   else
      Result := 0.0;
end;

function TEstimatedTime.GetStepsPerSecond: Double;
begin
   Result := FStepsPerSecond;
end;

procedure TEstimatedTime.SetMaxValue(const Value: Integer);
begin
   FMaxValue := Value;
end;

procedure TEstimatedTime.SetMinValue(const Value: Integer);
begin
   FMinValue := Value;
end;

procedure TEstimatedTime.SetValue(const Value: Integer);
const
   ZEHNSEC = 1.0/(24*60*60)*10;
var
   jetzt : TDateTime;
begin
   jetzt := SysUtils.Now;
   FStepsPerSecond := (Value-FHistory.value) / ((jetzt-FHistory.time) * 24*60*60);


   if (jetzt-FHistory.time) > ZEHNSEC then
   begin
      FHistory.value := Value;
      FHistory.time  := jetzt;
   end;
   FValue := Value;
end;

procedure TEstimatedTime.Start;
begin
   FStarttime := Now;
   FStepsPerSecond := 0;
   FHistory.value := FMinValue;
   FHistory.time := FStarttime;
end;


procedure TEstimatedTime.Step(const x: Integer);
begin
   if FStarttime = 0.0 then
      Start;
   Value := Value + x;
end;


function UserFriendlyTime(t : TDateTime):string;
var
   days, hours, min, secs, msecs : Word;
begin
   days := 0;

   if t > 1.0 then
   begin
      days := trunc(t);
      t := t - days;
   end;
   DecodeTime(t, hours, min, secs, msecs);

   if days > 3 then
      Result := Format('%dd', [days])
   else if days > 0 then
      Result := Format('%dd %dh', [days, hours])
   else if hours > 3 then
      Result := Format('%dh', [hours])
   else if hours > 0 then
      Result := Format('%dh %dmin', [hours, min])
   else if min > 3 then
      Result := Format('%dmin', [min])
   else if min > 0 then
      Result := Format('%dmin %ds', [min, secs])
   else
      Result := Format('%ds', [secs]);
end;


end.
