//---------------------------------------------------------------------------

#ifndef mainH
#define mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include "t_dmx_sender.h"
#include "t_dmx_receiver.h"
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TButton *Button2;
    TStatusBar *StatusBar1;
    TButton *Button3;
    TGroupBox *GroupBox1;
    TGroupBox *GroupBox2;
    TButton *Button1;
    TTrackBar *TrackBar1;
    TLabel *Label1;
    TLabel *Label2;
    TEdit *Edit1;
    TStringGrid *StringGrid;
    TGroupBox *GroupBox3;
    TEdit *Edit2;
    TButton *Button4;
    TLabel *Label3;
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall TrackBar1Change(TObject *Sender);
    void __fastcall Button2Click(TObject *Sender);
    void __fastcall Button3Click(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
    void __fastcall Button4Click(TObject *Sender);
private:	// User declarations
    bool dmx_send_thread_started;
    bool dmx_receive_thread_started;
    bool is_usb_connected;
    TDmxSender *dmx_sender_thread;
    TDmxReceiver *dmx_receiver_thread;
public:		// User declarations
    FT_HANDLE ftHandle;
    __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
