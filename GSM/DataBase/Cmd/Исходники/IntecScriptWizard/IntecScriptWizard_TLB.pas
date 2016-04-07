unit IntecScriptWizard_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 45604 $
// File generated on 17.05.2013 13:16:22 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Work\MobileTariff\Lontana\trunk\DataBase\Cmd\Исходники\IntecScriptWizard\IntecScriptWizard (1)
// LIBID: {40B77445-AEDA-4B74-B13D-3D853F2397B3}
// LCID: 0
// Helpfile:
// HelpString: IntecScriptWizard Library
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  IntecScriptWizardMajorVersion = 1;
  IntecScriptWizardMinorVersion = 0;

  LIBID_IntecScriptWizard: TGUID = '{40B77445-AEDA-4B74-B13D-3D853F2397B3}';

  IID_IShowScript: TGUID = '{BA8D5F8B-F442-4CF3-A29E-02A12D4D13E7}';
  CLASS_ShowScript: TGUID = '{1EA27CCC-E076-4CF4-B63C-B78CD8903858}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum ScriptCriticalEnum
type
  ScriptCriticalEnum = TOleEnum;
const
  scOrdinary = $00000000;
  scImportant = $00000001;
  scCritical = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IShowScript = interface;
  IShowScriptDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  ShowScript = IShowScript;


// *********************************************************************//
// Interface: IShowScript
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BA8D5F8B-F442-4CF3-A29E-02A12D4D13E7}
// *********************************************************************//
  IShowScript = interface(IDispatch)
    ['{BA8D5F8B-F442-4CF3-A29E-02A12D4D13E7}']
    procedure Clear; safecall;
    procedure Add(const ScriptName: WideString; const ScriptText: WideString;
                  const ScriptComment: WideString; const FileName: WideString;
                  const CriticalFlag: WideString); safecall;
    procedure Run; safecall;
    function Get_Connection: IDispatch; safecall;
    procedure Set_Connection(const Value: IDispatch); safecall;
    property Connection: IDispatch read Get_Connection write Set_Connection;
  end;

// *********************************************************************//
// DispIntf:  IShowScriptDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BA8D5F8B-F442-4CF3-A29E-02A12D4D13E7}
// *********************************************************************//
  IShowScriptDisp = dispinterface
    ['{BA8D5F8B-F442-4CF3-A29E-02A12D4D13E7}']
    procedure Clear; dispid 2;
    procedure Add(const ScriptName: WideString; const ScriptText: WideString;
                  const ScriptComment: WideString; const FileName: WideString;
                  const CriticalFlag: WideString); dispid 3;
    procedure Run; dispid 4;
    property Connection: IDispatch dispid 1;
  end;

// *********************************************************************//
// The Class CoShowScript provides a Create and CreateRemote method to
// create instances of the default interface IShowScript exposed by
// the CoClass ShowScript. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoShowScript = class
    class function Create: IShowScript;
    class function CreateRemote(const MachineName: string): IShowScript;
  end;

implementation

uses System.Win.ComObj;

class function CoShowScript.Create: IShowScript;
begin
  Result := CreateComObject(CLASS_ShowScript) as IShowScript;
end;

class function CoShowScript.CreateRemote(const MachineName: string): IShowScript;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ShowScript) as IShowScript;
end;

end.

