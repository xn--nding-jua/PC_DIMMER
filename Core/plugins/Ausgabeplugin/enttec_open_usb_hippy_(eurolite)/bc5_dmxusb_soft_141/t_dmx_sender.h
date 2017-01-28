/*
 *  Copyright (C) 2004 Nicolas Moreau ENTTEC Pty Ltd
 */

//---------------------------------------------------------------------------

#ifndef t_dmx_senderH
#define t_dmx_senderH

#include "FTD2XX.h"
//---------------------------------------------------------------------------
#include <Classes.hpp>
//---------------------------------------------------------------------------
class TDmxSender : public TThread
{
private:
    void inline send_byte(unsigned char byte);
    int inter_frame_delay;
protected:
    void __fastcall Execute();
public:
    FT_HANDLE ftHandle;
    unsigned char DMXData[512];
    unsigned char StartCode;
    unsigned int NbFramesSent;
    __fastcall TDmxSender(bool CreateSuspended);
    void SetRefreshRate(int rate);
};
//---------------------------------------------------------------------------
#endif
