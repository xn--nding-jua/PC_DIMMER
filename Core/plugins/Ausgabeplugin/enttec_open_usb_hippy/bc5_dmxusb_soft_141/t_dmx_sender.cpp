/*
 *  Copyright (C) 2004 Nicolas Moreau ENTTEC Pty Ltd
 */

//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "t_dmx_sender.h"
#include "FTD2XX.h"
#pragma package(smart_init)
//---------------------------------------------------------------------------

__fastcall TDmxSender::TDmxSender(bool CreateSuspended)
    : TThread(CreateSuspended)
{
    NbFramesSent = 0;
    inter_frame_delay = 30;
}
//---------------------------------------------------------------------------
void __fastcall TDmxSender::Execute()
{
    int i;
    ULONG bytesWritten;

     // set RS485 for sendin
    FT_W32_EscapeCommFunction(ftHandle,CLRRTS);

    while (!Terminated) {

        FT_W32_SetCommBreak(ftHandle);
        FT_W32_ClearCommBreak(ftHandle);


        FT_W32_WriteFile(ftHandle, &StartCode, 1, &bytesWritten, NULL);
        FT_W32_WriteFile(ftHandle, DMXData, 512, &bytesWritten, NULL);
      
        Sleep(inter_frame_delay);
        NbFramesSent++;
    }
    

}
//---------------------------------------------------------------------------

 void TDmxSender::SetRefreshRate(int rate)
 {
    float packet_time;

    if((rate>44) || (rate < 1)) return;
        packet_time = (1/(float)rate) * 1000;
        inter_frame_delay = packet_time - 20;
 }


