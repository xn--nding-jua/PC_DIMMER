#if !defined(AFX_HWINFOWND_H__C4A41E35_54AF_471B_B6A2_C9E6820AF05C__INCLUDED_)
#define AFX_HWINFOWND_H__C4A41E35_54AF_471B_B6A2_C9E6820AF05C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// HwInfoWnd.h : Header-Datei
//

/////////////////////////////////////////////////////////////////////////////
// Dialogfeld CHwInfoWnd 

class CHwInfoWnd : public CDialog
{
// Konstruktion
public:
	CHwInfoWnd(CWnd* pParent = NULL);   // Standardkonstruktor

// Dialogfelddaten
	//{{AFX_DATA(CHwInfoWnd)
	enum { IDD = IDD_HWINFO };
	CString	m_HWinfo;
	//}}AFX_DATA


// Überschreibungen
	// Vom Klassen-Assistenten generierte virtuelle Funktionsüberschreibungen
	//{{AFX_VIRTUAL(CHwInfoWnd)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV-Unterstützung
	//}}AFX_VIRTUAL

// Implementierung
protected:

	// Generierte Nachrichtenzuordnungsfunktionen
	//{{AFX_MSG(CHwInfoWnd)
		// HINWEIS: Der Klassen-Assistent fügt hier Member-Funktionen ein
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ fügt unmittelbar vor der vorhergehenden Zeile zusätzliche Deklarationen ein.

#endif // AFX_HWINFOWND_H__C4A41E35_54AF_471B_B6A2_C9E6820AF05C__INCLUDED_
