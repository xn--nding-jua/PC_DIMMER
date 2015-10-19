//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dmxusb.res");
USEFORM("main.cpp", Form1);
USEUNIT("t_dmx_sender.cpp");
USELIB("\\Tiger\Projects\Clients\enttec\dmx_usb\soft\FTD2XX.lib");
USEUNIT("t_dmx_receiver.cpp");
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
         Application->Initialize();
         Application->CreateForm(__classid(TForm1), &Form1);
         Application->Run();
    }
    catch (Exception &exception)
    {
         Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
