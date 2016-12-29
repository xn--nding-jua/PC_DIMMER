/*
 *  Copyright (C) 2004 Nicolas Moreau ENTTEC Pty Ltd
 */

//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "main.h"
#include "t_dmx_sender.h"

#include "FTD2XX.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
    : TForm(Owner)
{
    dmx_send_thread_started = false;
    dmx_receive_thread_started = false;
    is_usb_connected = false;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
    if(!is_usb_connected) {
        Application->MessageBoxA("Not Connected","Error",MB_OK);
        return;
    }

    if(dmx_send_thread_started == true) {
        dmx_sender_thread->Terminate();
        dmx_send_thread_started = false;
        Button1->Caption = "Send";
        Button1->Enabled = true;
        Button3->Enabled = true;
    } else {
        dmx_sender_thread = new  TDmxSender(true);
        dmx_sender_thread->ftHandle = ftHandle;
        dmx_sender_thread->Priority = tpTimeCritical;
        dmx_sender_thread->StartCode = 0;
        dmx_send_thread_started = true;
        dmx_sender_thread->Resume();
        Button1->Caption = "Stop";
        Button3->Enabled = false;
    }

}
//---------------------------------------------------------------------------
void __fastcall TForm1::TrackBar1Change(TObject *Sender)
{
    if(dmx_send_thread_started == true) {
        memset(dmx_sender_thread->DMXData,255-TrackBar1->Position,512);
    }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)
{
    FT_STATUS ftStatus;
    char Buf[64];

    if(is_usb_connected) {
       Button2->Caption = "Connect";
       is_usb_connected = false;
       dmx_sender_thread->Terminate();
       FT_W32_CloseHandle(ftHandle);
       Button1->Enabled = false;
       Button3->Enabled = false;
       return;
    }

    ftStatus = FT_ListDevices(0,Buf,FT_LIST_BY_INDEX|FT_OPEN_BY_DESCRIPTION);

    ftHandle = FT_W32_CreateFile(Buf,GENERIC_READ|GENERIC_WRITE,0,0,
        OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL | FT_OPEN_BY_DESCRIPTION,0);

    // connect to first device
    if (ftHandle == INVALID_HANDLE_VALUE) {
        Application->MessageBoxA("No device","Error",MB_OK);
        return;
    }

    FTDCB ftDCB;
    if (FT_W32_GetCommState(ftHandle,&ftDCB)) {
        // FT_W32_GetCommState ok, device state is in ftDCB
        ftDCB.BaudRate = 250000;
        ftDCB.Parity = FT_PARITY_NONE;
        ftDCB.StopBits = FT_STOP_BITS_2;
        ftDCB.ByteSize = FT_BITS_8;
        ftDCB.fOutX = false;
        ftDCB.fInX = false;
        ftDCB.fErrorChar = false;
        ftDCB.fBinary = true;
        ftDCB.fRtsControl = false;
        ftDCB.fAbortOnError = false;

        if (!FT_W32_SetCommState(ftHandle,&ftDCB)) {
            Application->MessageBoxA("Set baud rate error","Error",MB_OK);
            return;
        }
    }

    FT_W32_PurgeComm(ftHandle,FT_PURGE_TX | FT_PURGE_RX);

    Sleep(1000L);

    is_usb_connected = true;
    Button2->Caption = "Disconnect";
    Button1->Enabled = true;
    Button3->Enabled = true;


}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button3Click(TObject *Sender)
{
     if(!is_usb_connected) {
        Application->MessageBoxA("Not Connected","Error",MB_OK);
        return;
    }

    if(dmx_receive_thread_started == true) {
        dmx_receiver_thread->Terminate();
        dmx_receive_thread_started = false;
        Button3->Caption = "Receive";
        Button1->Enabled = true;
        Button3->Enabled = true;
    } else {
        dmx_receiver_thread = new  TDmxReceiver(true);
        dmx_receiver_thread->ftHandle = ftHandle;
        dmx_receiver_thread->Priority = tpTimeCritical;
        dmx_receiver_thread->StartCode = 0;
        dmx_receive_thread_started = true;
        dmx_receiver_thread->Resume();
        Button3->Caption = "Stop";
        Button1->Enabled = false;
    }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormShow(TObject *Sender)
{
    int i,j;
    
    for(i=1;i<=32;i++) {
       for(j=1;j<=16;j++) {
           StringGrid->Cells[j][i]=0;
       }
    }

    for(j=1;j<=16;j++) {
       StringGrid->Cells[j][0]=j;
    }

    for(j=1;j<=32;j++) {
       StringGrid->Cells[0][j]=(j-1)*16;
    }
}
//---------------------------------------------------------------------------


void __fastcall TForm1::Button4Click(TObject *Sender)
{
    if(!dmx_send_thread_started) return;
    dmx_sender_thread->SetRefreshRate(Edit2->Text.ToInt());    
}
//---------------------------------------------------------------------------

