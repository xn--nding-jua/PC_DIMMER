// HwInfoWnd.cpp: Implementierungsdatei
//

#include "stdafx.h"
#include "DMXDemo.h"
#include "HwInfoWnd.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// Dialogfeld CHwInfoWnd 


CHwInfoWnd::CHwInfoWnd(CWnd* pParent /*=NULL*/)
	: CDialog(CHwInfoWnd::IDD, pParent)
{
	//{{AFX_DATA_INIT(CHwInfoWnd)
	m_HWinfo = _T("");
	//}}AFX_DATA_INIT
}


void CHwInfoWnd::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CHwInfoWnd)
	DDX_Text(pDX, IDC_HW_INFO, m_HWinfo);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CHwInfoWnd, CDialog)
	//{{AFX_MSG_MAP(CHwInfoWnd)
		// HINWEIS: Der Klassen-Assistent fügt hier Zuordnungsmakros für Nachrichten ein
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// Behandlungsroutinen für Nachrichten CHwInfoWnd 
