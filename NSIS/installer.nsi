; example1.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of example1.nsi
; there. 

;--------------------------------

; The name of the installer
Name "NexchangeCoin Setup"
Caption "NexchangeCoin cryptocurrency coin setup"

; The file to write
OutFile "nexchangecoin-setup.exe"

; The default installation directory
InstallDir $PROGRAMFILES\NexchangeCoin

; Request application privileges for Windows Vista
RequestExecutionLevel admin

Icon "nexchangecoin.ico"
BrandingText "(c) 2015 NexchangeCoin Developers"

SetDatablockOptimize on

;--------------------------------

; Pages

Page license
LicenseData "nexchangecoin-license.rtf"

Page directory
Page instfiles

!define MUI_FINISHPAGE_RUN "$INSTDIR\nexchangecoin-qt.exe"

UninstPage uninstConfirm
UninstPage instfiles


;--------------------------------

; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File ..\release\nexchangecoin-qt.exe
  File libwinpthread-1.dll
  
  ; write uninstall strings
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NexchangeCoin" "DisplayName" "NexchangeCoin (remove only)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NexchangeCoin" "UninstallString" '"$INSTDIR\cc-uninst.exe"'
  WriteUninstaller "cc-uninst.exe"
  
  CreateShortcut "$DESKTOP\NexchangeCoin.lnk" "$INSTDIR\nexchangecoin-qt.exe"
  
SectionEnd ; end the section

Function .onInstSuccess
  ExecShell open "$DESKTOP\NexchangeCoin.lnk"
FunctionEnd


;--------------------------------

; Uninstaller

UninstallText "This will uninstall NexchangeCoin. Hit next to continue."
UninstallIcon "nexchangecoin.ico"

Section "Uninstall"

  Delete "$DESKTOP\NexchangeCoin.lnk"
  Delete "$INSTDIR\nexchangecoin-qt.exe"
  Delete "$INSTDIR\libwinpthread-1.dll"
  Delete "$INSTDIR\cc-uninst.exe"
  
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NexchangeCoin"
SectionEnd
