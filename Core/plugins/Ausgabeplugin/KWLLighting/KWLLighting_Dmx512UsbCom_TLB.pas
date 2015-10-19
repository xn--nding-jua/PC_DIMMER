unit KWLLighting_Dmx512UsbCom_TLB;

// ************************************************************************ //
// WARNUNG                                                                    
// -------                                                                    
// Die in dieser Datei deklarierten Typen wurden aus Daten einer Typbibliothek
// generiert. Wenn diese Typbibliothek explizit oder indirekt (über eine     
// andere Typbibliothek) reimportiert wird oder wenn die Anweisung            
// 'Aktualisieren' im Typbibliotheks-Editor während des Bearbeitens der     
// Typbibliothek aktiviert ist, wird der Inhalt dieser Datei neu generiert und 
// alle manuell vorgenommenen Änderungen gehen verloren.                           
// ************************************************************************ //

// PASTLWTR : 1.2
// Datei generiert am 02.07.2008 18:59:43 aus der unten beschriebenen Typbibliothek.

// ************************************************************************  //
// Typbib: C:\Programmieren\Delphi\230V 512 Kanal PC_DIMMER Source\plugins\Ausgabeplugin\KWLLighting\KWL-Lighting.Dmx512UsbCom.tlb (1)
// LIBID: {3ED5C13C-2F2F-4255-828C-D51955E95443}
// LCID: 0
// Hilfedatei: 
// Hilfe-String: Driver for DMX-512-USB
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v2.0 mscorlib, (C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\mscorlib.tlb)
// Fehler
//   Hinweis: Der Name der Typbibliothek KWL-Lighting_Dmx512UsbCom wurde geändert zu KWL_Lighting_Dmx512UsbCom
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit muß ohne Typüberprüfung für Zeiger compiliert werden. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, mscorlib_TLB, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// In dieser Typbibliothek deklarierte GUIDS . Es werden folgende         
// Präfixe verwendet:                                                     
//   Typbibliotheken     : LIBID_xxxx                                     
//   CoClasses           : CLASS_xxxx                                     
//   DISPInterfaces      : DIID_xxxx                                      
//   Nicht-DISP-Schnittstellen: IID_xxxx                                       
// *********************************************************************//
const
  // Haupt- und Nebenversionen der Typbibliothek
  KWL_Lighting_Dmx512UsbComMajorVersion = 1;
  KWL_Lighting_Dmx512UsbComMinorVersion = 0;

  LIBID_KWL_Lighting_Dmx512UsbCom: TGUID = '{3ED5C13C-2F2F-4255-828C-D51955E95443}';

  IID__Dmx512Usb_Com: TGUID = '{2B5BD9BC-401F-367B-AC60-34E66E9F89D8}';
  CLASS_Dmx512Usb_Com: TGUID = '{2F1C3323-AC3B-4E9B-9DC4-F03599675BD6}';
type

// *********************************************************************//
// Forward-Deklaration von in der Typbibliothek definierten Typen         
// *********************************************************************//
  _Dmx512Usb_Com = interface;
  _Dmx512Usb_ComDisp = dispinterface;

// *********************************************************************//
// Deklaration von in der Typbibliothek definierten CoClasses             
// (HINWEIS: Hier wird jede CoClass zu ihrer Standardschnittstelle        
// zugewiesen)                                                            
// *********************************************************************//
  Dmx512Usb_Com = _Dmx512Usb_Com;


// *********************************************************************//
// Schnittstelle: _Dmx512Usb_Com
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2B5BD9BC-401F-367B-AC60-34E66E9F89D8}
// *********************************************************************//
  _Dmx512Usb_Com = interface(IDispatch)
    ['{2B5BD9BC-401F-367B-AC60-34E66E9F89D8}']
    function Get_ToString: WideString; safecall;
    function Equals(obj: OleVariant): WordBool; safecall;
    function GetHashCode: Integer; safecall;
    function GetType: _Type; safecall;
    function SetChannel(channel: Integer; value: Integer): Integer; safecall;
    procedure Init; safecall;
    procedure Term; safecall;
    procedure Configure; safecall;
    property ToString: WideString read Get_ToString;
  end;

// *********************************************************************//
// DispIntf:  _Dmx512Usb_ComDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2B5BD9BC-401F-367B-AC60-34E66E9F89D8}
// *********************************************************************//
  _Dmx512Usb_ComDisp = dispinterface
    ['{2B5BD9BC-401F-367B-AC60-34E66E9F89D8}']
    property ToString: WideString readonly dispid 0;
    function Equals(obj: OleVariant): WordBool; dispid 1610743809;
    function GetHashCode: Integer; dispid 1610743810;
    function GetType: _Type; dispid 1610743811;
    function SetChannel(channel: Integer; value: Integer): Integer; dispid 1610743812;
    procedure Init; dispid 1610743813;
    procedure Term; dispid 1610743814;
    procedure Configure; dispid 1610743815;
  end;

// *********************************************************************//
// Die Klasse CoDmx512Usb_Com stellt die Methoden Create und CreateRemote zur      
// Verfügung, um Instanzen der Standardschnittstelle _Dmx512Usb_Com, dargestellt von
// CoClass Dmx512Usb_Com, zu erzeugen. Diese Funktionen können                     
// von einem Client verwendet werden, der die CoClasses automatisieren    
// möchte, die von dieser Typbibliothek dargestellt werden.               
// *********************************************************************//
  CoDmx512Usb_Com = class
    class function Create: _Dmx512Usb_Com;
    class function CreateRemote(const MachineName: string): _Dmx512Usb_Com;
  end;

implementation

uses ComObj;

class function CoDmx512Usb_Com.Create: _Dmx512Usb_Com;
begin
  Result := CreateComObject(CLASS_Dmx512Usb_Com) as _Dmx512Usb_Com;
end;

class function CoDmx512Usb_Com.CreateRemote(const MachineName: string): _Dmx512Usb_Com;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Dmx512Usb_Com) as _Dmx512Usb_Com;
end;

end.
