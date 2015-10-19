//---------------------------------------------------------------------------

#ifndef K8062H
#define K8062H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TScrollBar *ScrollBar1;
  TScrollBar *ScrollBar2;
  TScrollBar *ScrollBar3;
  TScrollBar *ScrollBar4;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label4;
  TLabel *Label5;
  TLabel *Label6;
  TLabel *Label7;
  TLabel *Label8;
  TEdit *Edit1;
  TLabel *Label9;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
  void __fastcall Edit1Change(TObject *Sender);
  void __fastcall ScrollBar1Change(TObject *Sender);
  void __fastcall ScrollBar2Change(TObject *Sender);
  void __fastcall ScrollBar3Change(TObject *Sender);
  void __fastcall ScrollBar4Change(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
