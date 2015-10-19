// slmini.h : main header file for the SLMINI application
//

#if !defined(AFX_SLMINI_H__E11AC6E5_F663_11D3_BAC2_0040954A111E__INCLUDED_)
#define AFX_SLMINI_H__E11AC6E5_F663_11D3_BAC2_0040954A111E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CSlminiApp:
// See slmini.cpp for the implementation of this class
//

class CSlminiApp : public CWinApp
{
public:
	CSlminiApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSlminiApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CSlminiApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SLMINI_H__E11AC6E5_F663_11D3_BAC2_0040954A111E__INCLUDED_)
