/*
 *  OksiD DMX 3/1 interface test program
 * 
 *                     Copyright (c) 2003, O'ksi'D
 *                        All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 
 *       Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 * 
 *       Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 * 
 *       Neither the name of O'ksi'D nor the names of its contributors
 *       may be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 * 
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#include "stdafx.h"
#include "test_cpp.h"
#include "test_cppDlg.h"
#include "okdmx31.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CTest_cppDlg dialog

CTest_cppDlg::CTest_cppDlg(CWnd* pParent /*=NULL*/)
	: CDialog()
{
	static DLGTEMPLATE tpl;

	tpl.style = DS_3DLOOK | DS_MODALFRAME | WS_SYSMENU \
			| WS_CAPTION | DS_ABSALIGN | DS_CENTER; 
	tpl.x = 1;
	tpl.y = 1;
	tpl.cx = 400;
	tpl.cy = 200;

	InitModalIndirect(&tpl, pParent);
	
	//{{AFX_DATA_INIT(CTest_cppDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

	OutUniv = 0;
	Port = 0;

}

void CTest_cppDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CTest_cppDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CTest_cppDlg, CDialog)
	//{{AFX_MSG_MAP(CTest_cppDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_VSCROLL()
	ON_WM_TIMER()
	ON_CBN_SELCHANGE(5003, OnCbnSelChangePort)
	ON_CBN_SELCHANGE(5004, OnCbnSelChangeUniv)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTest_cppDlg message handlers

BOOL CTest_cppDlg::OnInitDialog()
{
	int i;
	RECT rect;

	CDialog::OnInitDialog();

	SetWindowText("O'ksi'D DMX test app");

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here

	for (i = 0; i < 12; i++) {
		char buf[1024];
		int n;

		rect.top = 5;
		rect.left = 5 + 40 * i;
		rect.bottom = rect.top + 16;
		rect.right = rect.left + 35;

		sprintf(buf, "%d", 0);

		OutValues[i].Create(WS_VISIBLE | ES_CENTER, rect, this, 4000 + i);
		OutValues[i].SetWindowText(buf);

		rect.top = rect.bottom + 5;
		rect.bottom = rect.top + 200;
		rect.left += 5;
		Sliders[i].Create(TBS_VERT | TBS_BOTH | TBS_NOTICKS | WS_VISIBLE, 
			rect, this, 1000 + i);
		Sliders[i].SetRange(0, 255);
		Sliders[i].SetPos(255);
		rect.left -= 5;

		switch (i) {
		case 11:
			n = 512; break;
		case 10:
			n = 511; break;
		case 9:
			n = 32; break;
		case 8:
			n = 31; break;
		default:
			n = i + 1;		
		}

		sprintf(buf, "%d", n);
		rect.top = rect.bottom;
		rect.bottom = rect.top + 15;
		Channels[i].Create(buf, WS_VISIBLE | SS_CENTER, rect, this, 2000 + i);

		sprintf(buf, "%d", 0);
		rect.top = rect.bottom + 30;
		rect.bottom = rect.top + 16;
		InValues[i].Create(WS_VISIBLE | ES_CENTER, rect, this, 3000 + i);
		InValues[i].SetWindowText(buf);
		
	}	

	rect.left = 5;
	rect.right = rect.left + 200;
	rect.top = 250;
	rect.bottom = rect.top + 16;
	InTitle.Create("Input Universe values :", WS_VISIBLE | SS_LEFT, rect, this, 5001);

	rect.left = 490;
	rect.right = rect.left + 100;
	rect.top = 10;
	rect.bottom = rect.top + 25;
	Quit.Create("Exit", WS_VISIBLE, rect, this, IDCANCEL);

	rect.top = rect.bottom + 30;
	rect.bottom = rect.top + 20 + 140;
	PortSel.Create(WS_VISIBLE | CBS_DROPDOWNLIST, rect, this, 5003);

	i = PortSel.AddString("None");
	PortSel.SetItemData(i, 0);
	i = PortSel.AddString("LPT1:");
	PortSel.SetItemData(i, 0x378);	
	i = PortSel.AddString("LPT2:");
	PortSel.SetItemData(i, 0x278);

	PortSel.SelectString(-1, "None");


	rect.top = rect.bottom + 30 - 140;
	rect.bottom = rect.top + 20 + 140;
	UnivSel.Create(WS_VISIBLE | CBS_DROPDOWNLIST, rect, this, 5004);

	i = UnivSel.AddString("Universe 1");
	UnivSel.SetItemData(i, 0);
	i = UnivSel.AddString("Universe 2");
	UnivSel.SetItemData(i, 1);	
	i = UnivSel.AddString("Universe 3");
	UnivSel.SetItemData(i, 2);
	
	UnivSel.SelectString(-1, "Universe 1");

	for (i = 0; i < 511; i++) {
		InDmx[i] = 0;
		OutDmx[0][i] = 0;
		OutDmx[1][i] = 0;
		OutDmx[2][i] = 0;
	}

	SetTimer(1, 100, NULL);

	return TRUE;  // return TRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CTest_cppDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CTest_cppDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CTest_cppDlg::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	int n;
	CSliderCtrl *pSlider = (CSliderCtrl*) pScrollBar;

	n = pSlider->GetDlgCtrlID() - 1000;
	if (n >= 0 && n < 12) {
		char buf[32];
		unsigned char value;

		value = 255 - pSlider->GetPos();
		sprintf(buf, "%d", value);
		OutValues[n].SetWindowText(buf);

		switch (n) {
		case 11:
			n = 512; break;
		case 10:
			n = 511; break;
		case 9:
			n = 32; break;
		case 8:
			n = 31; break;
		default:
			n = n + 1;		
		}
		OutDmx[OutUniv][n - 1] = value;
	}
	CDialog::OnVScroll(nSBCode, nPos, pScrollBar);
}
	

void CTest_cppDlg::OnTimer(UINT nIDEvent) 
{

	SetTimer(nIDEvent, 50, NULL);

	// Use Okdmx31Read to read the data from the input universe
	// Use Okdmx31Write to write data to the 3 output universes
	// If one of these functions returns non-zero it means that there is no
	// device attached to the port.

	if (Port > 0) {
		int n, m;
		char buf[32];

		if (Okdmx31Read(Port, 0, InDmx)) {
			Port = 0;
			PortSel.SetCurSel(0);
		} 
		
		for (n = 0; n < 12; n++) {
			switch (n) {
			case 11:
				m = 511;
				if (InBuf[n] != InDmx[m]) {
					InBuf[n] = InDmx[m];
					sprintf(buf, "%d", InBuf[n]);
					InValues[n].SetWindowText(buf);	
				} 
				break;
			case 10:
				m = 510;
				if (InBuf[n] != InDmx[m]) {
					InBuf[n] = InDmx[m];
					sprintf(buf, "%d", InBuf[n]);
					InValues[n].SetWindowText(buf);	
				} 
				break;
			case 9:
				m = 31; 
				if (InBuf[n] != InDmx[m]) {
					InBuf[n] = InDmx[m];
					sprintf(buf, "%d", InBuf[n]);
					InValues[n].SetWindowText(buf);	
				}
				break;
			case 8:
				m = 30; 
				if (InBuf[n] != InDmx[m]) {
					InBuf[n] = InDmx[m];
					sprintf(buf, "%d", InBuf[n]);
					InValues[n].SetWindowText(buf);	
				}
				break;
			default:
				if (InBuf[n] != InDmx[n]) {
					InBuf[n] = InDmx[n];
					sprintf(buf, "%d", InBuf[n]);
					InValues[n].SetWindowText(buf);	
				}
			}
		}
	}

	if (Port > 0) {
		if (Okdmx31Write(Port, 0, OutDmx[0])) {
			Port = 0;
			PortSel.SetCurSel(0);
		} 
	}

	if (Port > 0) {
		if (Okdmx31Write(Port, 1, OutDmx[1])) {
			Port = 0;
			PortSel.SetCurSel(0);
		} 
	}

	if (Port > 0) {
		if (Okdmx31Write(Port, 2, OutDmx[2])) {
			Port = 0;
			PortSel.SetCurSel(0);
		} 
	}	

	CDialog::OnTimer(nIDEvent);
}

void CTest_cppDlg::OnCbnSelChangePort()
{
	int n;
	
	n = PortSel.GetCurSel();
	
	switch (n) {
	case 1:
		Port = 0x378; break;
	case 2:
		Port = 0x278; break;
	default:
		Port = 0;
	}
}

void CTest_cppDlg::OnCbnSelChangeUniv()
{
	int n;
	
	n = UnivSel.GetCurSel();

	if (n < 0 || n > 2) n = 0;

	OutUniv = n;	
}
