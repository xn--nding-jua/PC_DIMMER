//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "K8062D_DLL.h"
#include "K8062.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
int StartAddress = 1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
  StartDevice();   
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormClose(TObject *Sender, TCloseAction &Action)
{
  StopDevice();      
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Edit1Change(TObject *Sender)
{
  if (StrToInt(Edit1->Text)>0)
  {
    if (StrToInt(Edit1->Text)<509)
    {         
      StartAddress = StrToInt(Edit1->Text);
      SetChannelCount(StartAddress+3);
      Label5->Caption = IntToStr(StartAddress);
      Label6->Caption = IntToStr(StartAddress+1);
      Label7->Caption = IntToStr(StartAddress+2);
      Label8->Caption = IntToStr(StartAddress+3);
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ScrollBar1Change(TObject *Sender)
{
  Label1->Caption = IntToStr(255-ScrollBar1->Position);
  SetData(StartAddress, 255-ScrollBar1->Position);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ScrollBar2Change(TObject *Sender)
{
  Label2->Caption = IntToStr(255-ScrollBar2->Position);
  SetData(StartAddress + 1, 255-ScrollBar2->Position);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ScrollBar3Change(TObject *Sender)
{
  Label3->Caption = IntToStr(255-ScrollBar3->Position);
  SetData(StartAddress + 2, 255-ScrollBar3->Position);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ScrollBar4Change(TObject *Sender)
{
  Label4->Caption = IntToStr(255-ScrollBar4->Position);
  SetData(StartAddress + 3, 255-ScrollBar4->Position);
}
//---------------------------------------------------------------------------

