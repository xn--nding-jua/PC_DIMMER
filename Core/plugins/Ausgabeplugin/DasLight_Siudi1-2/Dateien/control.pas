const
  DHC_OPEN = 1;
  DHC_CLOSE = 2;
  DHC_DMXOUTOFF = 3;
  DHC_DMXOUT = 4;
  DHC_PORTREAD = 5;
  DHC_PORTCONFIG = 6;
  DHC_RESET = 11;

  private
    interface_open: integer;
	LastAnswer: integer;


function DasHardCommand(Command, Param: integer; Bloc: PChar): integer;
  cdecl; external 'DasHard_Siudi12.dll';



// FormCreate
  interface_open := DasHardCommand(DHC_OPEN, 0, nil);
  if interface_open > 0 then
    LastAnswer:=DasHardCommand(DHC_DMXOUTOFF, 0, nil);


	
// FormDestroy
  if interface_open > 0 then
    interface_open := DasHardCommand(DHC_CLOSE, 0, nil);



// Timer
begin
  if interface_open > 0 then
  begin
//    ports := DasHardCommand(DHC_PORTREAD, 0, nil);
//    DMX_Display_Ports(ports);

    LastAnswer:=DasHardCommand(DHC_DMXOUT, 512, DMXOutArray); // DMXOutArray:array[0..511] of byte
    if LastAnswer < 0 then
    begin
     DasHardCommand(DHC_CLOSE, 0, nil);
     interface_open := DasHardCommand(DHC_OPEN, 0, nil);
    end;
  end;
end;



// Reset
LastAnswer:=DasHardCommand(DHC_RESET, 0, nil);
