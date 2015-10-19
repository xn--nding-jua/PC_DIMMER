/*______________________________________________________________*\
 |                                                              |
 |   Copyright © Digital Art System 2006, All Rights Reserved   |
 |   spec for Memory-Mapped DMX Visualization                   |
\*______________________________________________________________*/

// DLL
#define MEVP_STR_DLL				"MEVP.dll"

// memory map version / Dll version
#define MEVP_VERSION				12

// nb DMX universes max
#define MEVP_NB_UNIVERSES			4
// nb fixtures max
#define MEVP_MAX_FIXTURES			1000

// nb DMX channels
#define MEVP_DMX_MAX_CHANNEL		512
// size of the DMX buffer
#define MEVP_DMX_ARRAY_SIZE			MEVP_NB_UNIVERSES * MEVP_DMX_MAX_CHANNEL

// String length
#define MEVP_MAX_STR_LEN			300

// DasMevCommand parameters
#define MEVP_CLOSE_VISUALIZER		0
#define MEVP_SET_LANGUAGE			1
#define MEVP_READ_PATCH				2

// called only from visualizer
#define MEVP_CREATE_SHARED_MEM		0
#define MEVP_FREE_SHARED_MEM		1
#define MEVP_WRITE_PATCH			2


