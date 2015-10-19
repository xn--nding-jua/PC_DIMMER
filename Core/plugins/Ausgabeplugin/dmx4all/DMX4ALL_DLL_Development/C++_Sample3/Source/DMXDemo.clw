; CLW-Datei enthält Informationen für den MFC-Klassen-Assistenten

[General Info]
Version=1
LastClass=CDMXDemoDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "DMXDemo.h"

ClassCount=4
Class1=CDMXDemoApp
Class2=CDMXDemoDlg
Class3=CAboutDlg

ResourceCount=5
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Resource3=IDD_DMXDEMO_DIALOG
Resource4=IDD_HWINFO
Class4=CHwInfoWnd
Resource5=IDR_MENU1

[CLS:CDMXDemoApp]
Type=0
HeaderFile=DMXDemo.h
ImplementationFile=DMXDemo.cpp
Filter=N

[CLS:CDMXDemoDlg]
Type=0
HeaderFile=DMXDemoDlg.h
ImplementationFile=DMXDemoDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=ID__HARDWREINFO

[CLS:CAboutDlg]
Type=0
HeaderFile=DMXDemoDlg.h
ImplementationFile=DMXDemoDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_DMXDEMO_DIALOG]
Type=1
Class=CDMXDemoDlg
ControlCount=30
Control1=IDC_CHANNEL1,msctls_trackbar32,1342242842
Control2=IDC_CHANNEL4,msctls_trackbar32,1342242842
Control3=IDC_CHANNEL3,msctls_trackbar32,1342242842
Control4=IDC_CHANNEL2,msctls_trackbar32,1342242842
Control5=IDC_CHANNEL5,msctls_trackbar32,1342242842
Control6=IDC_CHANNEL6,msctls_trackbar32,1342242842
Control7=IDC_CHANNEL9,msctls_trackbar32,1342242842
Control8=IDC_CHANNEL8,msctls_trackbar32,1342242842
Control9=IDC_CHANNEL7,msctls_trackbar32,1342242842
Control10=IDC_CHANNEL10,msctls_trackbar32,1342242842
Control11=IDC_STATIC,static,1342308352
Control12=IDC_STATIC,static,1342308352
Control13=IDC_STATIC,static,1342308352
Control14=IDC_STATIC,static,1342308352
Control15=IDC_STATIC,static,1342308352
Control16=IDC_STATIC,static,1342308352
Control17=IDC_STATIC,static,1342308352
Control18=IDC_STATIC,static,1342308352
Control19=IDC_STATIC,static,1342308352
Control20=IDC_STATIC,static,1342308352
Control21=IDC_CHOUT1,edit,1342244993
Control22=IDC_CHOUT2,edit,1342244993
Control23=IDC_CHOUT3,edit,1342244993
Control24=IDC_CHOUT4,edit,1342244993
Control25=IDC_CHOUT5,edit,1342244993
Control26=IDC_CHOUT6,edit,1342244993
Control27=IDC_CHOUT7,edit,1342244993
Control28=IDC_CHOUT8,edit,1342244993
Control29=IDC_CHOUT9,edit,1342244993
Control30=IDC_CHOUT10,edit,1342244993

[MNU:IDR_MENU1]
Type=1
Class=CDMXDemoDlg
Command1=ID_DATEI_BEENDEN
Command2=ID_EINSTELLUNGEN_MARTINPINBELEGUNG
Command3=ID_EINSTELLUNGEN_INTERNATIONALEPINBELEGUNG
Command4=ID_EINSTELLUNGEN_19200BAUD
Command5=ID_EINSTELLUNGEN_38400BAUD
Command6=ID__INFO
CommandCount=6

[DLG:IDD_HWINFO]
Type=1
Class=CHwInfoWnd
ControlCount=3
Control1=IDOK,button,1342242817
Control2=IDC_STATIC,static,1342308352
Control3=IDC_HW_INFO,edit,1352730756

[CLS:CHwInfoWnd]
Type=0
HeaderFile=HwInfoWnd.h
ImplementationFile=HwInfoWnd.cpp
BaseClass=CDialog
Filter=D
LastObject=IDC_HW_VERSION
VirtualFilter=dWC

