unit CPDReg;

interface

procedure Register;

implementation

uses
  // Delphi units
  Classes,
  // ComDrv32 units
  CPDrv;

{$R ComDrv32.dcr}

const
  TargetTab = 'System';

procedure Register;
begin
  RegisterComponents( TargetTab, [CPDrv.TCommPortDriver]);
end;

end.
