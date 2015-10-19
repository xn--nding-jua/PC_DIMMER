{$A+,B-,C+,D-,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
(*************************************************************************

Copyright (c) 2006 Andreas Hausladen (http://unvclx.sourceforge.net)


This software is provided 'as-is', without any express or implied
warranty. In no event will the author be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented, you must 
     not claim that you wrote the original software. If you use this 
     software in a product, an acknowledgment in the product documentation 
     would be appreciated but is not required.

  2. Altered source versions must be plainly marked as such, and must not 
     be misrepresented as being the original software.

  3. This notice may not be removed or altered from any source distribution.

*************************************************************************)

(*************************************************************************
History:
2006-10-03:
  - fixed RangeChecks disabled
*************************************************************************)

unit VCLFlickerReduce;

{$IFDEF CONDITIONALEXPRESSIONS}
 {$IF RTLVersion >= 15.00}
  {$DEFINE HAS_THEMES_UNIT}
 {$IFEND}
{$ENDIF CONDITIONALEXPRESSIONS}

interface

uses
  Windows, Messages, SysUtils, Classes,
  {$IFDEF HAS_THEMES_UNIT}
  Themes,
  {$ENDIF HAS_THEMES_UNIT}
  Controls, StdCtrls, ExtCtrls, ComCtrls, Forms, Grids, Buttons;

implementation

// ------- BEGIN Memory manipulation functions ----------

type
  PPointer = ^Pointer; // Delphi 5

type
  TRedirectCode = packed record
    Code: packed record
      PushEBP: Byte; // $55
      PopEBP: Byte; // $5D
      Jump: Byte;
      Offset: Integer;
    end;
    // additional data
    RealProc: Pointer;
    Count: Integer;
  end;

function WriteProtectedMemory(BaseAddress, Buffer: Pointer; Size: Cardinal;
  out WrittenBytes: Cardinal): Boolean;
var
  OldProt: Cardinal;
begin
  VirtualProtect(BaseAddress, Size, PAGE_EXECUTE_READWRITE, OldProt);
  Result := WriteProcessMemory(GetCurrentProcess, BaseAddress, Buffer, Size, WrittenBytes);
  VirtualProtect(BaseAddress, Size, OldProt, nil);
  FlushInstructionCache(GetCurrentProcess, BaseAddress, WrittenBytes);
end;

function ReadProtectedMemory(BaseAddress, Buffer: Pointer; Size: Cardinal;
  out ReadBytes: Cardinal): Boolean;
begin
  Result := ReadProcessMemory(GetCurrentProcess, BaseAddress, Buffer, Size, ReadBytes);
end;

procedure CodeRedirectEx(Proc: Pointer; NewProc: Pointer; out Data: TRedirectCode);
type
  PPointer = ^Pointer;
  TRelocationRec = packed record
    Jump: Word;
    Address: PPointer;
  end;

var
  Code: TRedirectCode;
  Relocation: TRelocationRec;
  n: Cardinal;
begin
  if Proc = nil then
  begin
    Data.RealProc := nil;
    Exit;
  end;
  if Data.Count = 0 then // do not overwrite an already backuped code
  begin
    ReadProtectedMemory(Proc, @Data.Code, SizeOf(Data.Code), n);
    if (Data.Code.PushEBP = $FF) and (Data.Code.PopEBP = $25) then // Proc is in a dll/so or package
    begin
      ReadProtectedMemory(Proc, @Relocation, SizeOf(Relocation), n);
      Data.RealProc := Relocation.Address^;
      Proc := Data.RealProc;
      ReadProtectedMemory(Proc, @Data.Code, SizeOf(Data.Code), n);
    end
    else
      Data.RealProc := Proc;
    Code.Code.PushEBP := $55;
    Code.Code.PopEBP := $5D;
    Code.Code.Jump := $E9;
    Code.Code.Offset := Integer(NewProc) - Integer(Proc) - SizeOf(Data.Code);
    WriteProtectedMemory(Proc, @Code.Code, SizeOf(Data.Code), n);
  end;
  Inc(Data.Count);
end;

function CodeRedirect(Proc: Pointer; NewProc: Pointer): TRedirectCode;
begin
  Result.Count := 0;
  Result.RealProc := nil;
  CodeRedirectEx(Proc, NewProc, Result);
end;

procedure CodeRestore(var Data: TRedirectCode);
var
  n: Cardinal;
begin
  if (Data.RealProc <> nil) and (Data.Count = 1) then
    WriteProtectedMemory(Data.RealProc, @Data.Code, SizeOf(Data.Code), n);
  Dec(Data.Count);
end;

function GetDynamicMethod(AClass: TClass; Index: Integer): Pointer; assembler;
asm
        CALL    System.@FindDynaClass
end;

// ------- END Memory manipulation functions ----------

type
  TOpenWinControl = class(TWinControl);
  TOpenCustomControl = class(TCustomControl);

procedure WinControlWMEraseBkgnd(Control: TWinControl; var Message: TWMEraseBkgnd);
var
  SaveIndex, Clip, I: Integer;
  R: TRect;
  H, Flags: Integer;
begin
  with TOpenWinControl(Control) do
  begin
    if (ClassName = 'TGroupButton') then
      ControlStyle := ControlStyle + [csOpaque];

    {$IFDEF HAS_THEMES_UNIT}
    with ThemeServices do
    {$ENDIF HAS_THEMES_UNIT}
    begin
      {$IFDEF HAS_THEMES_UNIT}
      if ThemesEnabled and Assigned(Parent) and (csParentBackground in ControlStyle) then
      begin
        { Get the parent to draw its background into the control's background. }
        if (TMessage(Message).wParam <> TMessage(Message).lParam) and (Control is TCustomPanel) then
        begin
          R := Control.ClientRect;
          AdjustClientRect(R);
          IntersectClipRect(Message.DC, R.Left, R.Top, R.Right, R.Bottom);
        end;
        DrawParentBackground(Handle, Message.DC, nil, False);
      end
      else
      {$ENDIF HAS_THEMES_UNIT}
      begin
        { Only erase background if we're not doublebuffering or painting to memory. }
        if not DoubleBuffered or (TMessage(Message).wParam = TMessage(Message).lParam) then
        begin
          if TMessage(Message).wParam <> TMessage(Message).lParam then
          begin
            if (Control is TCustomPanel) or
               (Control is TCustomGrid) then
            begin
              Message.Result := 1;
              Exit;
            end;

            if (Control is TCustomEdit) or
               (Control is TCustomStaticText) or
               (Control is TCustomFrame) or
               (Control is TCustomListControl) or
               (Control is TCustomTreeView) or
               (Control is TButtonControl) or
               (Control is TCommonCalendar) or
               (Control is TCustomHotKey) or
               (Control is TProgressBar) or
               (Control is TAnimate) then
            begin
              { These controls do not need to paint their own background because
                the WM_PAINT handler fills the whole area. }
              DefaultHandler(Message);
              Exit;
            end;

            { Paint the background only where no opaque control is }
            SaveIndex := SaveDC(Message.DC);

            if Control is TCustomGroupBox then
            begin
              GetWindowRect(Handle, R);
              OffsetRect(R, -R.Left, -R.Top);
              H := TOpenCustomControl(Control).Canvas.TextHeight('0');
              Inc(R.Top, H  div 2 - 1);
              ExcludeClipRect(Message.DC, R.Left, R.Top, R.Left + 2, R.Bottom);
              ExcludeClipRect(Message.DC, R.Right, R.Top, R.Right - 2, R.Bottom);
              ExcludeClipRect(Message.DC, R.Left, R.Bottom - 2, R.Right, R.Bottom);
              ExcludeClipRect(Message.DC, R.Left, R.Top, R.Right, R.Top + 2);

              if Text <> '' then
              begin
                if not UseRightToLeftAlignment then
                  R := Rect(8, 0, 0, H)
                else
                  R := Rect(R.Right - TOpenCustomControl(Control).Canvas.TextWidth(Text) - 8, 0, 0, H);
                Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
                Windows.DrawText(TOpenCustomControl(Control).Canvas.Handle, PChar(Text), Length(Text), R, Flags or DT_CALCRECT);
                ExcludeClipRect(Message.DC, R.Left, R.Top, R.Right, R.Bottom);
              end;
            end;

            Clip := SimpleRegion;
            for I := 0 to ControlCount - 1 do
              with Controls[I] do
                if (Visible or (csDesigning in ComponentState) and
                  not (csNoDesignVisible in ControlStyle)) and
                  (csOpaque in ControlStyle) then
                begin
                  Clip := ExcludeClipRect(Message.DC, Left, Top, Left + Width, Top + Height);
                  if Clip = NullRegion then
                    Break;
                end;
            if Clip <> NullRegion then
              FillRect(Message.DC, ClientRect, Brush.Handle);
            RestoreDC(Message.DC, SaveIndex);
          end
          else
            FillRect(Message.DC, ClientRect, Brush.Handle);
        end;
      end;
      Message.Result := 1;
    end;
  end;
end;

type
  TOpenTabSheet = class(TTabSheet);

procedure TabSheetCreateParams(TabSheet: TTabSheet; var Params: TCreateParams);
var
  Inherit: procedure(TabSheet: TTabSheet; var Params: TCreateParams);
begin
  Inherit := @TOpenWinControl.CreateParams;
  Inherit(TabSheet, Params);
  with TabSheet do
  begin
    ControlStyle := ControlStyle + [csOpaque]; // add the missing csOpaque style
    {$IFDEF HAS_THEMES_UNIT}
    if not ThemeServices.ThemesAvailable then
    {$ENDIF HAS_THEMES_UNIT}
      with Params.WindowClass do
        style := style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure WinControlWMPaint(Control: TWinControl; var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
begin
  with TOpenWinControl(Control) do
  begin
    if not DoubleBuffered or (Message.DC <> 0) then
    begin
      if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      begin
        { Paint ListControl background here to keep flickering short }
        DC := 0;
        if Assigned(Parent) and (
           ((Control is TCustomListControl) and not (Control is TCustomCombo)) or
           (Control is TCommonCalendar) or
           (Control is TCustomHotKey) or
           (Control is TProgressBar) or
           ((Control is TCustomMemo) and not (Control is TCustomRichEdit)) 
           ) then
        begin
          if Message.DC = 0 then
          begin
            DC := BeginPaint(Handle, PS);
            Message.DC := DC;
          end;
          FillRect(Message.DC, ClientRect, Brush.Handle);
        end;
        DefaultHandler(Message);
        if DC <> 0 then
          EndPaint(Handle, PS);
      end
      else
        PaintHandler(Message);
    end
    else
    begin
      DC := GetDC(0);
      MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
      ReleaseDC(0, DC);
      MemDC := CreateCompatibleDC(0);
      OldBitmap := SelectObject(MemDC, MemBitmap);
      try
        DC := BeginPaint(Handle, PS);
        Perform(WM_ERASEBKGND, Integer(MemDC), Integer(MemDC));
        Message.DC := MemDC;
        Message.Result := Perform(WM_PAINT, Integer(Message.DC), Integer(Message.Unused));
        Message.DC := 0;
        BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
        EndPaint(Handle, PS);
      finally
        SelectObject(MemDC, OldBitmap);
        DeleteDC(MemDC);
        DeleteObject(MemBitmap);
      end;
    end;
  end;
end;

type
  TOpenButtonControl = class(TButtonControl);
  TOpenButton = class(TButton);

procedure ButtonCreateParams(Button: TButton; var Params: TCreateParams);
const
  ButtonStyles: array[Boolean] of DWORD = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
var
  Inherit: procedure(Button: TButton; var Params: TCreateParams);
begin
  Inherit := @TOpenButtonControl.CreateParams;
  Inherit(Button, Params);
  with TOpenButton(Button) do
  begin
    {$IFDEF HAS_THEMES_UNIT}
    if not ThemeServices.ThemesAvailable then
    {$ENDIF HAS_THEMES_UNIT}
      ControlStyle := ControlStyle + [csOpaque]; // add the missing csOpaque style
    CreateSubClass(Params, 'BUTTON');
    Params.Style := Params.Style or ButtonStyles[Default];
  end;
end;

procedure ButtonWMEraseBkgnd(Control: TWinControl; var Message: TWMEraseBkgnd);
begin
  Message.Result := 1
end;

var
  WinControlWMEraseBkgndHook: TRedirectCode;
  WinControlWMPaintHook: TRedirectCode;
  TabSheetCreateParamsHook: TRedirectCode;
  ButtonCreateParamsHook: TRedirectCode;
  ButtonWMEraseBkgndHook: TRedirectCode;

initialization
  WinControlWMEraseBkgndHook := CodeRedirect(GetDynamicMethod(TWinControl, WM_ERASEBKGND), @WinControlWMEraseBkgnd);
  WinControlWMPaintHook := CodeRedirect(GetDynamicMethod(TWinControl, WM_PAINT), @WinControlWMPaint);
  TabSheetCreateParamsHook := CodeRedirect(@TOpenTabSheet.CreateParams, @TabSheetCreateParams);
  ButtonCreateParamsHook := CodeRedirect(@TOpenButton.CreateParams, @ButtonCreateParams);
  ButtonWMEraseBkgndHook := CodeRedirect(GetDynamicMethod(TButton, WM_ERASEBKGND), @ButtonWMEraseBkgnd);


finalization
  CodeRestore(WinControlWMEraseBkgndHook);
  CodeRestore(WinControlWMPaintHook);
  CodeRestore(TabSheetCreateParamsHook);
  CodeRestore(ButtonCreateParamsHook);
  CodeRestore(ButtonWMEraseBkgndHook);

end.
