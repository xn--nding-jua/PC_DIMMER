// test_cpp.h : main header file for the TEST_CPP application
//

#if !defined(AFX_TEST_CPP_H__0E4A548B_679C_40E1_B2D1_851A5A0C221A__INCLUDED_)
#define AFX_TEST_CPP_H__0E4A548B_679C_40E1_B2D1_851A5A0C221A__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CTest_cppApp:
// See test_cpp.cpp for the implementation of this class
//

class CTest_cppApp : public CWinApp
{
public:
	CTest_cppApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTest_cppApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CTest_cppApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TEST_CPP_H__0E4A548B_679C_40E1_B2D1_851A5A0C221A__INCLUDED_)
