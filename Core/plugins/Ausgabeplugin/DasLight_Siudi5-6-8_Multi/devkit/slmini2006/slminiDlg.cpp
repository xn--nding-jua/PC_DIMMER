//// slminiDlg.cpp : implementation file
////

#include "stdafx.h"
#include <math.h>
#include "slmini.h"
#include "slminiDlg.h"

/*
#include <windows.h>
#include <io.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
/**/

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

///////////////////////////////////////////////// USB DMX /////////////////////////////////////////////////////////////////////////////////////
#include "_dashard.h"
extern int HardDllCommand(int command, int param, unsigned char *bloc);
extern int ref_open;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// CSlminiDlg dialog

CSlminiDlg::CSlminiDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSlminiDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSlminiDlg)
	m_text_nextprevious = _T("");
	m_text_channel = _T("");
	m_text_value = _T("");
	m_combo_port = _T("");
	m_text_channel_in = _T("");
	m_text_value_in = _T("");
	m_text_value_in1 = _T("");
	m_text_value_in2 = _T("");
	m_text_value_in3 = _T("");
	m_text_value_in4 = _T("");
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CSlminiDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSlminiDlg)
	DDX_Control(pDX, IDC_STATIC_INFO_PORT, m_info_port);
	DDX_Control(pDX, IDC_STATIC_INFO_OUT, m_info_out);
	DDX_Control(pDX, IDC_STATIC_INFO_IN, m_info_in);
	DDX_Control(pDX, IDC_DMXCHANNELIN, m_pot_channel_in);
	DDX_Control(pDX, IDC_COMBO_PORT, m_port);
	DDX_Control(pDX, IDC_DMXVALUE, m_dmxvalue);
	DDX_Control(pDX, IDC_DMXCHANNEL, m_pot_channel);
	DDX_Text(pDX, IDC_NEXTPREVIOUS, m_text_nextprevious);
	DDX_Text(pDX, IDC_STATIC_CHANNEL, m_text_channel);
	DDX_Text(pDX, IDC_STATIC_VALUE, m_text_value);
	DDX_CBString(pDX, IDC_COMBO_PORT, m_combo_port);
	DDX_Text(pDX, IDC_STATIC_CHANNEL2, m_text_channel_in);
	DDX_Text(pDX, IDC_STATIC_VALUE_DMXIN, m_text_value_in);
	DDX_Text(pDX, IDC_STATIC_VALUE_DMXIN1, m_text_value_in1);
	DDX_Text(pDX, IDC_STATIC_VALUE_DMXIN2, m_text_value_in2);
	DDX_Text(pDX, IDC_STATIC_VALUE_DMXIN3, m_text_value_in3);
	DDX_Text(pDX, IDC_STATIC_VALUE_DMXIN4, m_text_value_in4);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CSlminiDlg, CDialog)
	//{{AFX_MSG_MAP(CSlminiDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_CBN_SELCHANGE(IDC_COMBO_PORT, OnSelchangeComboPort)
	ON_WM_HSCROLL()
	ON_WM_VSCROLL()
	ON_BN_CLICKED(IDC_OFF, OnOutMode)
	ON_BN_CLICKED(IDC_INPUT, OnInOut)
	ON_WM_TIMER()
	ON_WM_CLOSE()
	ON_BN_CLICKED(IDC_ON, OnOutMode)
	ON_BN_CLICKED(IDC_OUTPUT, OnInOut)
	ON_BN_CLICKED(IDC_BUT_DEMO3D, OnButDemo3d)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// CSlminiDlg message handlers

BOOL CSlminiDlg::OnInitDialog()
{
	CDialog::OnInitDialog();
	int i;


	//// Set the icon for this dialog.  The framework does this automatically
	////  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			//// Set big icon
	SetIcon(m_hIcon, FALSE);		//// Set small icon
	
	//// TODO: Add extra initialization here
	for(i=0 ; i<DMX_MAXCHANNEL ; i++) {
		block_dmxout[i]	= 0;
		block_dmxin[i]	= 0;
	}

	m_pot_channel.SetScrollRange(0, DMX_MAXCHANNEL+1);
	m_pot_channel_in.SetScrollRange(0, DMX_MAXCHANNEL-DMXIN_DISPLAY);
	m_dmxvalue.SetScrollRange(0, DMX_MAXVALUE);
	m_dmxvalue.SetScrollPos(DMX_MAXVALUE);
	dmxout_channel = 1;
	dmxin_offset = 0;
	dmxin_length = 0;
	
	Display_dmxout();
	Display_dmxin();
	

	CString str;
	if(ref_open == DHE_OK)
	{
		int version = HardDllCommand(DHC_VERSION,0,0);
		str.Format("Ref. SIUDI  OK (ver: %d) !",version);
		m_info_out.SetWindowText(str);
		m_info_port.SetWindowText(str);
		m_info_in.SetWindowText(str);

		HardDllCommand(DHC_DMX2ENABLE,0,0);
	}
	else
	{	
		m_info_in.SetWindowText("NO INTERFACE !");
		m_info_out.SetWindowText("NO INTERFACE !");
		m_info_port.SetWindowText("NO INTERFACE !");
		DisableDisplayOut();
		DisableDisplayPort();
		DisableDisplayIn();
		GetDlgItem(IDC_BUT_DEMO3D)->EnableWindow(FALSE);
	}
	

	m_port.SetCurSel(0);
	for(i=0 ; i<NB_PORT ; i++)
	{
		out_mode[i] = FALSE;
		port_out[i] = FALSE;
	}
	OnSelchangeComboPort();
	
	Display_next_previous_state();

	Send_config_port();

	SetTimer(0,1000/TIMEFREQ,NULL);

	return TRUE;  //// return TRUE  unless you set the focus to a control
}

//// If you add a minimize button to your dialog, you will need the code below
////  to draw the icon.  For MFC applications using the document/view model,
////  this is automatically done for you by the framework.

void CSlminiDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); //// device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		//// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		//// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		Display_next_previous_state();
		Display_port_state();
		CDialog::OnPaint();
	}
}

//// The system calls this to obtain the cursor to display while the user drags
////  the minimized window.
HCURSOR CSlminiDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CSlminiDlg::OnSelchangeComboPort() 
{
	//// TODO: Add your control notification handler code here
	Display_port_state();
}

void CSlminiDlg::OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	//// TODO: Add your message handler code here and/or call default
	if(pScrollBar == &m_pot_channel){
		int g_pos = m_pot_channel.GetScrollPos();
		switch (nSBCode)
		{
		case SB_LINERIGHT:
		case SB_RIGHT:
			g_pos += 1;	
			break;
		case SB_PAGERIGHT:
			g_pos += 10;				
			break;
		case SB_LINELEFT:
		case SB_LEFT:
			g_pos -= 1;				
			break;
		case SB_PAGELEFT:
			g_pos -= 10;				
			break;
		case SB_THUMBTRACK:
		case SB_THUMBPOSITION:
			g_pos = nPos+1;
			break;
		}
		if(g_pos<1)
			g_pos = 1;
		if(g_pos>DMX_MAXCHANNEL)
			g_pos = DMX_MAXCHANNEL;
		m_pot_channel.SetScrollPos(g_pos);
		dmxout_channel = g_pos;
		Display_dmxout();
	}

	// For the DMX-IN
	else{
		int g_pos = m_pot_channel_in.GetScrollPos();
		switch (nSBCode)
		{
		case SB_LINERIGHT:
		case SB_RIGHT:
			g_pos += 1;	
			break;
		case SB_PAGERIGHT:
			g_pos += 10;				
			break;
		case SB_LINELEFT:
		case SB_LEFT:
			g_pos -= 1;				
			break;
		case SB_PAGELEFT:
			g_pos -= 10;				
			break;
		case SB_THUMBTRACK:
		case SB_THUMBPOSITION:
			g_pos = nPos;
			break;
		}
		if(g_pos<0)
			g_pos = 0;
		if(g_pos>DMX_MAXCHANNEL-DMXIN_DISPLAY)
			g_pos = DMX_MAXCHANNEL-DMXIN_DISPLAY;
		m_pot_channel_in.SetScrollPos(g_pos);
		dmxin_offset = g_pos;
	}

	CDialog::OnHScroll(nSBCode, nPos, pScrollBar);
}

void CSlminiDlg::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	//// TODO: Add your message handler code here and/or call default
	int g_pos = DMX_MAXVALUE-m_dmxvalue.GetScrollPos();
	switch (nSBCode)
	{
	case SB_LINEUP:
		g_pos += 1;	
		break;
	case SB_PAGEUP:
		g_pos += 10;				
		break;
	case SB_LINEDOWN:
		g_pos -= 1;				
		break;
	case SB_PAGEDOWN:
		g_pos -= 10;				
		break;
	case SB_THUMBTRACK:
	case SB_THUMBPOSITION:
		g_pos = DMX_MAXVALUE-nPos;
		break;
	}
	if(g_pos<0)
		g_pos = DMX_MAXVALUE;
	if(g_pos>DMX_MAXVALUE)
		g_pos = 0;
	m_dmxvalue.SetScrollPos(g_pos);
	block_dmxout[dmxout_channel-1] = g_pos;
	Display_dmxout();
	
	CDialog::OnVScroll(nSBCode, nPos, pScrollBar);
}

void CSlminiDlg::Display_dmxout()
{
	CString str;

	CWnd *dmxchannel = GetDlgItem(IDC_STATIC_CHANNEL);
	str.Format("DMX Channel: %d", dmxout_channel);
	dmxchannel->SetWindowText(str);

	m_dmxvalue.SetScrollPos(DMX_MAXVALUE-block_dmxout[dmxout_channel-1]);
	CWnd *dmxvalue = GetDlgItem(IDC_STATIC_VALUE);
	str.Format("DMX\nValue\n%d", block_dmxout[dmxout_channel-1]);
	dmxvalue->SetWindowText(str);

}

void CSlminiDlg::Display_dmxin()
{
	CString str;

	CWnd *dmxchannel = GetDlgItem(IDC_STATIC_CHANNEL2);
	str.Format("DMX Starting Channel: %d", dmxin_offset+1);
	dmxchannel->SetWindowText(str);

	str.Format("%d", dmxin_offset+1);
	GetDlgItem(IDC_STATIC_VALUE_CH_DMXIN)->SetWindowText(str);;
	str.Format("%d", dmxin_offset+2);
	GetDlgItem(IDC_STATIC_VALUE_CH_DMXIN1)->SetWindowText(str);;
	str.Format("%d", dmxin_offset+3);
	GetDlgItem(IDC_STATIC_VALUE_CH_DMXIN2)->SetWindowText(str);;
	str.Format("%d", dmxin_offset+4);
	GetDlgItem(IDC_STATIC_VALUE_CH_DMXIN3)->SetWindowText(str);;
	str.Format("%d", dmxin_offset+5);
	GetDlgItem(IDC_STATIC_VALUE_CH_DMXIN4)->SetWindowText(str);;

	CWnd *nbChannel	 = GetDlgItem(IDC_STATIC_NB_CHANNEL);
	str.Format("DMX INPUT channels:  %d",dmxin_length);
	nbChannel->SetWindowText(str);

	CWnd *dmxvalue = GetDlgItem(IDC_STATIC_VALUE_DMXIN);
	CWnd *dmxvalue1 = GetDlgItem(IDC_STATIC_VALUE_DMXIN1);
	CWnd *dmxvalue2 = GetDlgItem(IDC_STATIC_VALUE_DMXIN2);
	CWnd *dmxvalue3 = GetDlgItem(IDC_STATIC_VALUE_DMXIN3);
	CWnd *dmxvalue4 = GetDlgItem(IDC_STATIC_VALUE_DMXIN4);

	str.Format("%d", block_dmxin[dmxin_offset ]);
	dmxvalue->SetWindowText(str);
	str.Format("%d", block_dmxin[dmxin_offset +1]);
	dmxvalue1->SetWindowText(str);
	str.Format("%d", block_dmxin[dmxin_offset +2]);
	dmxvalue2->SetWindowText(str);
	str.Format("%d", block_dmxin[dmxin_offset +3]);
	dmxvalue3->SetWindowText(str);
	str.Format("%d", block_dmxin[dmxin_offset +4]);
	dmxvalue4->SetWindowText(str);



}


void CSlminiDlg::DisableDisplayOut()
{
	GetDlgItem(IDC_DMXVALUE)->EnableWindow(FALSE);
	GetDlgItem(IDC_DMXCHANNEL)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_CHANNEL)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_VALUE)->EnableWindow(FALSE);
	
}



void CSlminiDlg::DisableDisplayPort()
{
	GetDlgItem(IDC_COMBO_PORT)->EnableWindow(FALSE);
	GetDlgItem(IDC_INPUT)->EnableWindow(FALSE);
	GetDlgItem(IDC_OUTPUT)->EnableWindow(FALSE);
	GetDlgItem(IDC_ON)->EnableWindow(FALSE);
	GetDlgItem(IDC_OFF)->EnableWindow(FALSE);
	GetDlgItem(IDC_NEXTPREVIOUS)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_BAR)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_PORT)->EnableWindow(FALSE);

	
	

}



void CSlminiDlg::DisableDisplayIn()
{
	GetDlgItem(IDC_STATIC_VALUE_DMXIN)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_VALUE_DMXIN1)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_VALUE_DMXIN2)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_VALUE_DMXIN3)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_VALUE_DMXIN4)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_VALUE_CH_DMXIN)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_VALUE_CH_DMXIN1)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_VALUE_CH_DMXIN2)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_VALUE_CH_DMXIN3)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_VALUE_CH_DMXIN4)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_BAR)->EnableWindow(FALSE);
	GetDlgItem(IDC_DMXCHANNELIN)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_CHANNEL2)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_CH)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_DMXV)->EnableWindow(FALSE);
	GetDlgItem(IDC_STATIC_NB_CHANNEL)->EnableWindow(FALSE);
	
		
}


void CSlminiDlg::OnOutMode() 
{
	//// TODO: Add your control notification handler code here
	out_mode[m_port.GetCurSel()] = !out_mode[m_port.GetCurSel()];
	if(out_mode[m_port.GetCurSel()])
		Send_config_port();
	Display_port_state();
}

void CSlminiDlg::OnInOut() 
{
	//// TODO: Add your control notification handler code here
	port_out[m_port.GetCurSel()] = !port_out[m_port.GetCurSel()];
	Send_config_port();
	Display_port_state();
}

void CSlminiDlg::Display_port_state()
{

	if(port_out[m_port.GetCurSel()])
	{
		CheckRadioButton(IDC_INPUT, IDC_OUTPUT, IDC_OUTPUT);
		GetDlgItem(IDC_ON)->EnableWindow(TRUE);
		GetDlgItem(IDC_OFF)->EnableWindow(TRUE);
		if(out_mode[m_port.GetCurSel()])
			CheckRadioButton(IDC_ON, IDC_OFF, IDC_ON);
		else
			CheckRadioButton(IDC_ON, IDC_OFF, IDC_OFF);
	}
	else
	{
		CheckRadioButton(IDC_INPUT, IDC_OUTPUT, IDC_INPUT);
		GetDlgItem(IDC_ON)->EnableWindow(FALSE);
		GetDlgItem(IDC_OFF)->EnableWindow(FALSE);
		int i = (int)pow((double)2, (m_port.GetCurSel()+2));
		if(ports&i)
			CheckRadioButton(IDC_ON, IDC_OFF, IDC_OFF);
		else
			CheckRadioButton(IDC_ON, IDC_OFF, IDC_ON);
	}
}

void CSlminiDlg::Display_next_previous_state()
{
	CWnd *next_previous_txt = GetDlgItem(IDC_NEXTPREVIOUS);
	CString next, previous, str;
	if(ports&1)
		next = "OFF";
	else
		next = "ON";
	if(ports&2)
		previous = "OFF";
	else
		previous = "ON";
	str.Format("NEXT button:  %s\n\nPREVIOUS button: %s", next, previous);
	next_previous_txt->SetWindowText(str);
}

void CSlminiDlg::OnTimer(UINT nIDEvent) 
{
	// TODO: Add your message handler code here and/or call default

	if(ref_open == DHE_OK)
	{
		ports = HardDllCommand(DHC_PORTREAD, 0, 0);
		HardDllCommand(DHC_DMXOUT, DMX_MAXCHANNEL, block_dmxout);
		Display_next_previous_state();
		Display_port_state();
		unsigned char block512[512];
		dmxin_length = HardDllCommand(DHC_DMX2IN, 512, block512);		
		dmxin_length;
		if(dmxin_length>0)
			CopyMemory(block_dmxin, block512, dmxin_length);
		Display_dmxin();
	}
	CDialog::OnTimer(nIDEvent);
}

void CSlminiDlg::OnClose() 
{
	// TODO: Add your message handler code here and/or call default
	KillTimer(0);
	CDialog::OnClose();
}

void CSlminiDlg::Send_config_port()
{
	unsigned short config = 0;
	for(int i=0 ; i<NB_PORT ; i++)
	{
		if(port_out[i])
			config += (int)pow((double)2, (i+8));
		if(out_mode[i])
			config += (int)pow((double)2, i);
	}
	int ok = HardDllCommand(DHC_PORTCONFIG, config, 0);
}




void CSlminiDlg::OnButDemo3d() 
{
	MessageBox("Not yet available !", "Error", MB_OK); 
}



