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
<<<<<<< HEAD

=======
>>>>>>> 3a3f3bc2307060148a4896314a3a0fe00104a1c1
