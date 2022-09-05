#ifndef FORMULADIALOGPROC_BI
#define FORMULADIALOGPROC_BI

#include once "windows.bi"

Type MainDialogProcParam
	hInst As HINSTANCE
	tTime As SYSTEMTIME
	tDate As SYSTEMTIME
End Type

Declare Function MainDialogProc( _
	ByVal hwndDlg As HWND, _
	ByVal uMsg As UINT, _
	ByVal wParam As WPARAM, _
	ByVal lParam As LPARAM _
)As INT_PTR

#endif
