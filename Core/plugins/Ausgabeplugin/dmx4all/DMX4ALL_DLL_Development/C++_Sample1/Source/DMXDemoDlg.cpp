// DMXDemoDlg.cpp : Implementierungsdatei
//

#include "stdafx.h"
#include "DMXDemo.h"
#include "DMXDemoDlg.h"
#include "HwInfoWnd.h"
#include "DMX4ALLinit.h"
#include "DMX4ALLdefs.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg-Dialogfeld für Anwendungsbefehl "Info"

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialogfelddaten
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// Vom Klassenassistenten generierte Überladungen virtueller Funktionen
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV-Unterstützung
	//}}AFX_VIRTUAL

// Implementierung
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// Keine Nachrichten-Handler
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDMXDemoDlg Dialogfeld

CDMXDemoDlg::CDMXDemoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDMXDemoDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDMXDemoDlg)
	m_ch1   = 100;
	m_ch10  = 100;
	m_ch2   = 100;
	m_ch3   = 100;
	m_ch4   = 100;
	m_ch5   = 100;
	m_ch6   = 100;
	m_ch7   = 100;
	m_ch8   = 100;
	m_ch9   = 100;
	m_out1  = 0;
	m_out10 = 0;
	m_out2  = 0;
	m_out3  = 0;
	m_out4  = 0;
	m_out5  = 0;
	m_out6  = 0;
	m_out7  = 0;
	m_out8  = 0;
	m_out9  = 0;
	//}}AFX_DATA_INIT
	// Beachten Sie, dass LoadIcon unter Win32 keinen nachfolgenden DestroyIcon-Aufruf benötigt
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_FirstChannel = 1;
}

void CDMXDemoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDMXDemoDlg)
	DDX_Slider(pDX, IDC_CHANNEL1, m_ch1);
	DDX_Slider(pDX, IDC_CHANNEL10, m_ch10);
	DDX_Slider(pDX, IDC_CHANNEL2, m_ch2);
	DDX_Slider(pDX, IDC_CHANNEL3, m_ch3);
	DDX_Slider(pDX, IDC_CHANNEL4, m_ch4);
	DDX_Slider(pDX, IDC_CHANNEL5, m_ch5);
	DDX_Slider(pDX, IDC_CHANNEL6, m_ch6);
	DDX_Slider(pDX, IDC_CHANNEL7, m_ch7);
	DDX_Slider(pDX, IDC_CHANNEL8, m_ch8);
	DDX_Slider(pDX, IDC_CHANNEL9, m_ch9);
	DDX_Text(pDX, IDC_CHOUT1, m_out1);
	DDX_Text(pDX, IDC_CHOUT10, m_out10);
	DDX_Text(pDX, IDC_CHOUT2, m_out2);
	DDX_Text(pDX, IDC_CHOUT3, m_out3);
	DDX_Text(pDX, IDC_CHOUT4, m_out4);
	DDX_Text(pDX, IDC_CHOUT5, m_out5);
	DDX_Text(pDX, IDC_CHOUT6, m_out6);
	DDX_Text(pDX, IDC_CHOUT7, m_out7);
	DDX_Text(pDX, IDC_CHOUT8, m_out8);
	DDX_Text(pDX, IDC_CHOUT9, m_out9);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CDMXDemoDlg, CDialog)
	//{{AFX_MSG_MAP(CDMXDemoDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_CHANNEL1, OnCustomdrawChannel)
	ON_COMMAND(ID__INFO, OnInfo)
	ON_COMMAND(ID_EINSTELLUNGEN_INTERNATIONALEPINBELEGUNG, OnEinstellungenInternationalepinbelegung)
	ON_COMMAND(ID_EINSTELLUNGEN_19200BAUD, OnEinstellungen19200baud)
	ON_COMMAND(ID_EINSTELLUNGEN_38400BAUD, OnEinstellungen38400baud)
	ON_COMMAND(ID_EINSTELLUNGEN_MARTINPINBELEGUNG, OnEinstellungenMartinpinbelegung)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_CHANNEL2, OnCustomdrawChannel)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_CHANNEL3, OnCustomdrawChannel)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_CHANNEL4, OnCustomdrawChannel)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_CHANNEL5, OnCustomdrawChannel)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_CHANNEL6, OnCustomdrawChannel)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_CHANNEL7, OnCustomdrawChannel)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_CHANNEL8, OnCustomdrawChannel)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_CHANNEL9, OnCustomdrawChannel)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_CHANNEL10, OnCustomdrawChannel)
	ON_COMMAND(ID_DATEI_BEENDEN, OnCancel)
	ON_WM_TIMER()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDMXDemoDlg Nachrichten-Handler

BOOL CDMXDemoDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// IDM_ABOUTBOX muss sich im Bereich der Systembefehle befinden.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	Dmx4allDllOpen();

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{	
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Symbol für dieses Dialogfeld festlegen. Wird automatisch erledigt
	//  wenn das Hauptfenster der Anwendung kein Dialogfeld ist
	SetIcon(m_hIcon, TRUE);			// Großes Symbol verwenden
	SetIcon(m_hIcon, FALSE);		// Kleines Symbol verwenden
	
	// If you need a special COM port for your interface,
	// please enter this line with the index
//	Dmx4allSetComPort(12);	// for example COM 12

	// Open and connect to the DMX4ALL-PC-Interface
	Dmx4allFindInterface();

	// Get the actual used port
	int Port;
	Dmx4allGetComParameters(&Port,NULL);

	// Show COM-PORT into window title
	CString TitleStr;
	if(Port==USB_PORT)
	{
		TitleStr.Format("DMX-Demo - USB");
		m_InterfaceConnected = true;
	}
	else if(Port!=0)
	{
		TitleStr.Format("DMX-Demo - COM%d",Port);
		m_InterfaceConnected = true;
	}
	else
	{
		TitleStr.Format("DMX-Demo - OFFLINE");
		m_InterfaceConnected = false;
	}
	(AfxGetMainWnd())->SetWindowText(TitleStr);

	return TRUE;  // Geben Sie TRUE zurück, außer ein Steuerelement soll den Fokus erhalten
}

void CDMXDemoDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

void CDMXDemoDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // Gerätekontext für Zeichnen

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Symbol in Client-Rechteck zentrieren
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Symbol zeichnen
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// Die Systemaufrufe fragen den Cursorform ab, die angezeigt werden soll, während der Benutzer
//  das zum Symbol verkleinerte Fenster mit der Maus zieht.
HCURSOR CDMXDemoDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CDMXDemoDlg::OnCustomdrawChannel(NMHDR* pNMHDR, LRESULT* pResult) 
{
	BYTE Data[10];
	UpdateData(true);
	m_out1  = (BYTE)((100-m_ch1)*2.551);
	m_out2  = (BYTE)((100-m_ch2)*2.551);
	m_out3  = (BYTE)((100-m_ch3)*2.551);
	m_out4  = (BYTE)((100-m_ch4)*2.551);
	m_out5  = (BYTE)((100-m_ch5)*2.551);
	m_out6  = (BYTE)((100-m_ch6)*2.551);
	m_out7  = (BYTE)((100-m_ch7)*2.551);
	m_out8  = (BYTE)((100-m_ch8)*2.551);
	m_out9  = (BYTE)((100-m_ch9)*2.551);
	m_out10 = (BYTE)((100-m_ch10)*2.551);

	// fill in data
	Data[0] = (BYTE)((100-m_ch1)*2.551) ;
	Data[1] = (BYTE)((100-m_ch2)*2.551) ;
	Data[2] = (BYTE)((100-m_ch3)*2.551) ;
	Data[3] = (BYTE)((100-m_ch4)*2.551) ;
	Data[4] = (BYTE)((100-m_ch5)*2.551) ;
	Data[5] = (BYTE)((100-m_ch6)*2.551) ;
	Data[6] = (BYTE)((100-m_ch7)*2.551) ;
	Data[7] = (BYTE)((100-m_ch8)*2.551) ;
	Data[8] = (BYTE)((100-m_ch9)*2.551) ;
	Data[9] = (BYTE)((100-m_ch10)*2.551);
	UpdateData(false);

	// check if DMX-Interface is connected
	if(m_InterfaceConnected)
	{
		if(!Dmx4allGetComParameters(NULL,NULL))
		{
			Beep(100,100);
			m_InterfaceConnected = false;
			AfxMessageBox("DMX-Interface disconnected!");
			(AfxGetMainWnd())->SetWindowText("DMX-Demo - OFFLINE");
		}
	}

	// send data to DMX-Interface
	Dmx4allSetDmx(m_FirstChannel, 10, Data);
	*pResult = 0;
}


//----------------------------------------------------------------------------------------
// Menu-Routinen

void CDMXDemoDlg::OnCancel() 
{	
	Dmx4allClearComPort();
	CDialog::OnCancel();
}

void CDMXDemoDlg::OnInfo() 
{
	CAboutDlg dlgAbout;
	dlgAbout.DoModal();
}

void CDMXDemoDlg::OnEinstellungenMartinpinbelegung() 
{
	Dmx4allSetPinout(false);	
	GetMenu()->CheckMenuItem(ID_EINSTELLUNGEN_INTERNATIONALEPINBELEGUNG,MF_UNCHECKED | MF_BYCOMMAND);
	GetMenu()->CheckMenuItem(ID_EINSTELLUNGEN_MARTINPINBELEGUNG,MF_CHECKED | MF_BYCOMMAND);
}

void CDMXDemoDlg::OnEinstellungenInternationalepinbelegung() 
{
	Dmx4allSetPinout(true);	
	GetMenu()->CheckMenuItem(ID_EINSTELLUNGEN_INTERNATIONALEPINBELEGUNG,MF_CHECKED | MF_BYCOMMAND);
	GetMenu()->CheckMenuItem(ID_EINSTELLUNGEN_MARTINPINBELEGUNG,MF_UNCHECKED | MF_BYCOMMAND);
}

void CDMXDemoDlg::OnEinstellungen19200baud() 
{
	Dmx4allSetComParameters(19200);
	GetMenu()->CheckMenuItem(ID_EINSTELLUNGEN_19200BAUD,  MF_CHECKED | MF_BYCOMMAND);
	GetMenu()->CheckMenuItem(ID_EINSTELLUNGEN_38400BAUD,MF_UNCHECKED | MF_BYCOMMAND);
}

void CDMXDemoDlg::OnEinstellungen38400baud() 
{
	Dmx4allSetComParameters(38400);
	GetMenu()->CheckMenuItem(ID_EINSTELLUNGEN_19200BAUD,MF_UNCHECKED | MF_BYCOMMAND);
	GetMenu()->CheckMenuItem(ID_EINSTELLUNGEN_38400BAUD,MF_CHECKED | MF_BYCOMMAND);
}
