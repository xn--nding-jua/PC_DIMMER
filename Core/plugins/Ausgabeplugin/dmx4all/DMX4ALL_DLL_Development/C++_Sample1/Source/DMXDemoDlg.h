// DMXDemoDlg.h : Header-Datei
//

#if !defined(AFX_DMXDEMODLG_H__01E3DE25_09E1_11D5_B6C5_0010A701C436__INCLUDED_)
#define AFX_DMXDEMODLG_H__01E3DE25_09E1_11D5_B6C5_0010A701C436__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CDMXDemoDlg Dialogfeld

class CDMXDemoDlg : public CDialog
{
// Konstruktion
public:
	CDMXDemoDlg(CWnd* pParent = NULL);	// Standard-Konstruktor

// Dialogfelddaten
	//{{AFX_DATA(CDMXDemoDlg)
	enum { IDD = IDD_DMXDEMO_DIALOG };
	int		m_ch1;
	int		m_ch10;
	int		m_ch2;
	int		m_ch3;
	int		m_ch4;
	int		m_ch5;
	int		m_ch6;
	int		m_ch7;
	int		m_ch8;
	int		m_ch9;
	int		m_out1;
	int		m_out10;
	int		m_out2;
	int		m_out3;
	int		m_out4;
	int		m_out5;
	int		m_out6;
	int		m_out7;
	int		m_out8;
	int		m_out9;
	//}}AFX_DATA

	// Vom Klassenassistenten generierte Überladungen virtueller Funktionen
	//{{AFX_VIRTUAL(CDMXDemoDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV-Unterstützung
	//}}AFX_VIRTUAL

// Implementierung
protected:
	HICON			m_hIcon;
	unsigned short	m_ComPort;
	int				m_FirstChannel;
	bool			m_InterfaceConnected;

	// Generierte Message-Map-Funktionen
	//{{AFX_MSG(CDMXDemoDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnCancel();
	afx_msg void OnCustomdrawChannel(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnInfo();
	afx_msg void OnEinstellungenInternationalepinbelegung();
	afx_msg void OnEinstellungen19200baud();
	afx_msg void OnEinstellungen38400baud();
	afx_msg void OnEinstellungenMartinpinbelegung();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ fügt unmittelbar vor der vorhergehenden Zeile zusätzliche Deklarationen ein.

#endif // !defined(AFX_DMXDEMODLG_H__01E3DE25_09E1_11D5_B6C5_0010A701C436__INCLUDED_)
