; example1.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of example1.nsi
; there. 

;--------------------------------

; The name of the installer
Name "CM_CapitalName Setup"
Caption "CM_CapitalName cryptocurrency coin setup"

; The file to write
OutFile "CM_LowerName-setup.exe"

; The default installation directory
InstallDir $PROGRAMFILES\CM_CapitalName

; Request application privileges for Windows Vista
RequestExecutionLevel admin

Icon "CM_LowerName.ico"
BrandingText "(c) 2015 CM_CapitalName Developers"

SetDatablockOptimize on

;--------------------------------

; Pages

Page license
LicenseData "CM_LowerName-license.rtf"

Page directory
Page instfiles

!define MUI_FINISHPAGE_RUN "$INSTDIR\CM_LowerName-qt.exe"

UninstPage uninstConfirm
UninstPage instfiles


;--------------------------------

; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File ..\release\CM_LowerName-qt.exe
  File libwinpthread-1.dll
  
  ; write uninstall strings
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CM_CapitalName" "DisplayName" "CM_CapitalName (remove only)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CM_CapitalName" "UninstallString" '"$INSTDIR\cc-uninst.exe"'
  WriteUninstaller "cc-uninst.exe"
  
  CreateShortcut "$DESKTOP\CM_CapitalName.lnk" "$INSTDIR\CM_LowerName-qt.exe"
  
SectionEnd ; end the section

Function .onInstSuccess
  ExecShell open "$DESKTOP\CM_CapitalName.lnk"
FunctionEnd


;--------------------------------

; Uninstaller

UninstallText "This will uninstall CM_CapitalName. Hit next to continue."
UninstallIcon "CM_LowerName.ico"

Section "Uninstall"

  Delete "$DESKTOP\CM_CapitalName.lnk"
  Delete "$INSTDIR\CM_LowerName-qt.exe"
  Delete "$INSTDIR\libwinpthread-1.dll"
  Delete "$INSTDIR\cc-uninst.exe"
  
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CM_CapitalName"
SectionEnd
