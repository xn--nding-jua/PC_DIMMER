// test_cppDlg.h : header file
//

#if !defined(AFX_TEST_CPPDLG_H__07E43752_E8AE_4DEA_9907_C0B57A4D38C9__INCLUDED_)
#define AFX_TEST_CPPDLG_H__07E43752_E8AE_4DEA_9907_C0B57A4D38C9__INCLUDED_


#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CTest_cppDlg dialog

class CTest_cppDlg : public CDialog
{
// Construction
public:
	CSliderCtrl Sliders[12];
	CEdit OutValues[12];
	CEdit InValues[12];
	CStatic Channels[12];
	CStatic InTitle;
	CButton Quit;
	CComboBox PortSel;
	CComboBox UnivSel;
	int OutUniv;
	unsigned char OutDmx[3][512];
	unsigned char InDmx[512];
	unsigned char InBuf[12];
	unsigned int Port;

	CTest_cppDlg(CWnd* pParent = NULL);	// standard constructor


// Dialog Data
	//{{AFX_DATA(CTest_cppDlg)
	//enum { IDD = IDD_TEST_CPP_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTest_cppDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CTest_cppDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnCbnSelChangePort();
	afx_msg void OnCbnSelChangeUniv();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TEST_CPPDLG_H__07E43752_E8AE_4DEA_9907_C0B57A4D38C9__INCLUDED_)
