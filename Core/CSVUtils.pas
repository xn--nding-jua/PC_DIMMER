unit CSVUtils;

interface

uses Classes;

procedure ParseCSVLine(const ALine: string; AFields: TStrings; delim, quote:char);
function MakeCSVLine(AFields: TStrings; delim, quote:Char):string;


implementation

uses SysUtils;


//  ParseCSVLine Orginal by Perry Way
//  redesign by Andreas Schmidt
procedure ParseCSVLine(const ALine: string; AFields: TStrings; delim, quote:char);
var
   iState:  cardinal;
   i:       cardinal;
   iLength: cardinal;
   sField:  string;
   aChar: Char;
begin
   Assert(Assigned(AFields));
   AFields.Clear;

  // determine length of input //
  iLength := Length(ALine);
  // exit if empty string //
  if iLength = 0 then
    Exit;
  // initialize State Machine //
  iState := 0;
  sField := '';

  // state machine //
  for i := 1 to iLength do
  begin
    aChar := ALine[i];
    case iState of
//--------------------------------------------------------------//
      0: // unknown //
      begin
        sField := '';
        if aChar = quote then // start of embedded quotes or commas //
           iState := 2
        else if aChar=delim then // empty field //
            AFields.Add(sField)
        else
          begin // start of regular field //
            sField := ALine[i];
            iState := 1;
          end;
      end; 
//--------------------------------------------------------------// 
      1: // continuation of regular field // 
      begin 
        if aChar = delim then // end of regular field //
          begin
            AFields.Add(sField);
            // if end of input, then we know there remains a "null" field //
            if (i = iLength) then
            begin
              AFields.Add('');
            end // (i = iLength) //
            else
            begin
              iState := 0;
            end;
          end
          else // concatenate current char //
          begin
            sField := sField + aChar;
            if (i = iLength) then // EOL //
              AFields.Add(sField);
          end;
      end;
//--------------------------------------------------------------//
      2: // continuation of embedded quotes or commas //
      begin
        if aChar = quote then // end of embedded comma field or beginning of embedded quote
          begin
            if i < iLength then // NotTheEndPos //
            begin
              if ALine[i+1] = delim then
              begin // end of embedded comma field //
                iState := 1
              end
              else
              begin
                iState := 3;
              end;
            end
            else
            begin // end of field since end of line //
              AFields.Add(sField);
            end;
          end
          else // concatenate current char //
          begin
            sField := sField + aChar;
          end;
      end;
//--------------------------------------------------------------//
      3: // beginning of embedded quote //
      begin
        if aChar = quote then
          begin
            sField := sField + aChar;
            iState := 2;
          end;
      end;
//--------------------------------------------------------------//
    end; // case iState //
  end;
end;

function CharsInString(const s, search : string):Boolean;
var
   i,j : Integer;
begin
   for i := 1 to Length(s) do
   begin
      for j:= 1 to Length(search) do
         if s[i] = search[j] then
         begin
            Result := True;
            Exit;
         end;
   end;
   Result := False;
end;


function MakeCSVLine(AFields: TStrings; delim, quote:Char):string;
var
   i : Integer;
   s : string;
begin
   Result := '';
   for i := 0 to AFields.Count-1 do
   begin
      s := AFields.Strings[i];
      if quote <> Chr(0) then
      begin
         if CharsInString(s, ' '+delim+quote) then
            s := AnsiQuotedStr(s, quote);
      end;
      if i <> 0 then
         Result := Result + delim + s
      else
         Result := s;
   end;
end;


end.
