/*
 *  Copyright (C) 2004 Nicolas Moreau ENTTEC Pty Ltd
 */

//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "t_dmx_receiver.h"
#include "main.h"
#pragma package(smart_init)

__fastcall TDmxReceiver::TDmxReceiver(bool CreateSuspended)
    : TThread(CreateSuspended)
{
}
//---------------------------------------------------------------------------
void __fastcall TDmxReceiver::Execute()
{
    int i;
    int recv_count = 0;
    bool wait_for_break = true;
    ULONG bytesWritten;
    unsigned char data;

    static COMSTAT oldCS = {0};
    static DWORD dwOldErrors = 0;
    COMSTAT newCS;
    DWORD dwErrors;
    BOOL bChanged = false;

     // set RS485 for receive
    FT_W32_EscapeCommFunction(ftHandle,SETRTS);

    FTTIMEOUTS ftTS;
    ftTS.ReadIntervalTimeout = 0;
    ftTS.ReadTotalTimeoutMultiplier = 0;
    ftTS.ReadTotalTimeoutConstant = 1000;
    ftTS.WriteTotalTimeoutMultiplier = 0;
    ftTS.WriteTotalTimeoutConstant = 200;
    FT_W32_SetCommTimeouts(ftHandle,&ftTS);

    DWORD dwMask = EV_ERR;
    FT_W32_SetCommMask(ftHandle,dwMask);
    DWORD dwEvents;

    while (!Terminated) {

        FT_W32_WaitCommEvent(ftHandle, &dwEvents, NULL);


        FT_W32_ClearCommError(ftHandle, &dwErrors, (FTCOMSTAT *)&newCS);

        if (dwErrors != dwOldErrors) {
            bChanged = true;
            dwOldErrors = dwErrors;
        }

        if (bChanged) {
            if ((dwErrors & CE_BREAK) || (dwErrors & CE_FRAME)) {
                FT_W32_ReadFile(ftHandle, &temp_StartCode, 1, &bytesWritten, NULL);
                FT_W32_ReadFile(ftHandle, temp_DMXData, 512, &bytesWritten, NULL);
                Synchronize(UpdateScreen);
            }
        }
        FT_W32_PurgeComm(ftHandle,FT_PURGE_TX | FT_PURGE_RX);

    }
}
//---------------------------------------------------------------------------

void __fastcall TDmxReceiver::UpdateScreen(void)
{
    int c,i,j,k;

    Form1->Edit1->Text = temp_StartCode;

    c=0;
    for(i=1;i<=32;i++) {
        for(j=1;j<=16;j++) {
            c=(i-1)*16+(j-1);
            k=temp_DMXData[c];
            Form1->StringGrid->Cells[j][i]=k;
        }
    }
}
