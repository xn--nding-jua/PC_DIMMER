// slminiDlg.h : header file
//

#if !defined(AFX_SLMINIDLG_H__E11AC6E7_F663_11D3_BAC2_0040954A111E__INCLUDED_)
#define AFX_SLMINIDLG_H__E11AC6E7_F663_11D3_BAC2_0040954A111E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


#define DMX_MAXCHANNEL		512					// dmx standard
#define DMX_MAXVALUE		255					// dmx standard
#define DMXIN_SIZEBLOCK		(DMX_MAXCHANNEL+3)	// need 3 more bytes
#define DMXIN_DISPLAY		5					// number of channel displayed
#define NB_PORT				8					// number of ports on Ref. SIUDI

#define TIMEFREQ			30


#define REF_SIUDI					1

#define REF_SIUDI_EC				11

#define REF_SIUDI_IN				21




/////////////////////////////////////////////////////////////////////////////
// CSlminiDlg dialog

class CSlminiDlg : public CDialog
{
// Construction
public:
	void Display_dmxin();
	void Display_dmxout();
	void Display_next_previous_state();
	void Display_port_state();
	int  dmxout_channel;
	int  dmxin_offset;
	int  dmxin_length;
	void Send_config_port();
	int ports;
	bool port_out[NB_PORT];
	bool out_mode[NB_PORT];
	CSlminiDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CSlminiDlg)
	enum { IDD = IDD_SLMINI_DIALOG };
	CStatic	m_info_port;
	CStatic	m_info_out;
	CStatic	m_info_in;
	CScrollBar	m_pot_channel_in;
	CComboBox	m_port;
	CScrollBar	m_dmxvalue;
	CScrollBar	m_pot_channel;
	CString	m_text_nextprevious;
	CString	m_text_channel;
	CString	m_text_value;
	CString	m_combo_port;
	CString	m_text_channel_in;
	CString	m_text_value_in;
	CString	m_text_value_in1;
	CString	m_text_value_in2;
	CString	m_text_value_in3;
	CString	m_text_value_in4;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSlminiDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	void DisableDisplayPort();
	void DisableDisplayIn();
	void DisableDisplayOut();

	
	HICON m_hIcon;
	unsigned char block_dmxout[DMX_MAXCHANNEL];
	unsigned char block_dmxin[DMX_MAXCHANNEL];
	// Generated message map functions
	//{{AFX_MSG(CSlminiDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnSelchangeComboPort();
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnOutMode();
	afx_msg void OnInOut();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnClose();
	afx_msg void OnButDemo3d();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SLMINIDLG_H__E11AC6E7_F663_11D3_BAC2_0040954A111E__INCLUDED_)
