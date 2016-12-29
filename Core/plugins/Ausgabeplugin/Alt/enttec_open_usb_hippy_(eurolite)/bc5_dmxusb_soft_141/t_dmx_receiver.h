
/*
 *  Copyright (C) 2004 Nicolas Moreau ENTTEC Pty Ltd
 */

 //---------------------------------------------------------------------------

#ifndef t_dmx_receiverH
#define t_dmx_receiverH

#include "FTD2XX.h"
//---------------------------------------------------------------------------
#include <Classes.hpp>
//---------------------------------------------------------------------------
class TDmxReceiver : public TThread
{
private:
    unsigned char temp_DMXData[512];
    unsigned char temp_StartCode;
    void __fastcall UpdateScreen(void);
protected:
    void __fastcall Execute();
public:
    FT_HANDLE ftHandle;
    unsigned char DMXData[512];
    unsigned char StartCode;
    unsigned int NbFramesSent;
    __fastcall TDmxReceiver(bool CreateSuspended);
};
//---------------------------------------------------------------------------
#endif
