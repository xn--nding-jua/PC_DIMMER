unit uDIKeyboardConsts;

interface

uses
    Windows;

function ScanCodeTASCII(ScanCode: Cardinal): Char;

implementation

function ScanCodeTASCII(ScanCode: Cardinal): Char;
    var h: HKL; State: TKeyboardState; vk: Cardinal;
begin
    h:=GetKeyboardLayout(0);

    if not(GetKeyboardState(State))then
        Result:=#0 else
    begin
        vk:=MapVirtualKeyEx(scancode,1,h);
        if(ToAsciiEx(vk,scancode,State,@Result,0,h)=0)
        then Result:=#0;
    end;
end;

end.
