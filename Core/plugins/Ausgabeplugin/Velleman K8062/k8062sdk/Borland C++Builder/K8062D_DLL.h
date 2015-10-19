#ifdef __cplusplus
extern "C" {         /* Assume C declarations for C++ */
#endif

#define FUNCTION __declspec(dllimport)

FUNCTION __stdcall StartDevice();
FUNCTION __stdcall SetData(long Channel, long Data);
FUNCTION __stdcall SetChannelCount(long Count);
FUNCTION __stdcall StopDevice();

#ifdef __cplusplus
}
#endif

