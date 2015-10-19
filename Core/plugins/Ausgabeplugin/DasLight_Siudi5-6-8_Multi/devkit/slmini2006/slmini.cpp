// slmini.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "slmini.h"
#include "slminiDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////
/////////////////////// DASHARD.DLL   USB ////////////////////////////////
/////////////////////////////////////////////////////////////////////////
#include "_DasHard.h"

HINSTANCE g_dasusbdll = NULL;
typedef int (*DASHARDCOMMAND)(int, int, unsigned char*);
DASHARDCOMMAND  DasUsbCommand = NULL;
int ref_open = 0;

int HardDllOpen()
{
	g_dasusbdll = LoadLibrary("DasHard2006.dll");

	if (g_dasusbdll)
		DasUsbCommand  = (DASHARDCOMMAND)::GetProcAddress((HMODULE)g_dasusbdll, "DasUsbCommand");
	if (DasUsbCommand)
		return 1;
	return 0;
}

int HardDllClose()
{
	if (g_dasusbdll!=NULL)
		return	FreeLibrary(g_dasusbdll);
	return 0;
}

int HardDllCommand(int command, int param, unsigned char *bloc)
{
	if (DasUsbCommand)
		return (*DasUsbCommand)(command, param, bloc);
	return 0;
}



/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
// CSlminiApp

BEGIN_MESSAGE_MAP(CSlminiApp, CWinApp)
	//{{AFX_MSG_MAP(CSlminiApp)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSlminiApp construction

CSlminiApp::CSlminiApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CSlminiApp object

CSlminiApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CSlminiApp initialization

BOOL CSlminiApp::InitInstance()
{
	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	//////////////////////////// USB ///////////////////////////
	int dll_open=0, ok=0;
	dll_open = HardDllOpen();
	if (dll_open>0)
	{
		// New command
		HardDllCommand(DHC_INIT,0,NULL);
		ref_open = HardDllCommand(DHC_OPEN,0,NULL);


	}
	else
		MessageBox(NULL, "'DasHard2006.dll' not found !", "DLL", MB_OK); 

	//////////////////////////// USB ///////////////////////////

	CSlminiDlg dlg;
	m_pMainWnd = &dlg;

	int nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with OK
	}
	else if (nResponse == IDCANCEL)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with Cancel
	}

	if (ref_open>0)
		ok = HardDllCommand(DHC_CLOSE,0,0);
	if (dll_open>0)
	{
		Sleep(10);
		// New command
		HardDllCommand(DHC_EXIT	,0,NULL);	
		ok = HardDllClose();
	}

	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
}
