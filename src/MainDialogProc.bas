#include once "MainDialogProc.bi"
#include once "win\commctrl.bi"
#include once "Resources.RH"

Function MainDialogProc( _
		ByVal hwndDlg As HWND, _
		ByVal uMsg As UINT, _
		ByVal wParam As WPARAM, _
		ByVal lParam As LPARAM _
	)As INT_PTR
	
	Select Case uMsg
		
		Case WM_INITDIALOG
			Dim pparam As MainDialogProcParam Ptr = CPtr(MainDialogProcParam Ptr, lParam)
			Dim ico As HICON = LoadIcon( _
				pparam->hInst, _
				Cast(LPTSTR, IDI_MAIN) _
			)
			
			SendMessage(hwndDlg, WM_SETICON, ICON_BIG, Cast(LPARAM, ico))
			SendMessage(hwndDlg, WM_SETICON, ICON_SMALL, Cast(LPARAM, ico))
			
			SetWindowLongPtr(hwndDlg, GWLP_USERDATA, Cast(LONG_PTR, pparam))
			
		Case WM_COMMAND
			
			Select Case LOWORD(wParam)
				
				Case IDOK
					Dim pparam As MainDialogProcParam Ptr = Cast( _
						MainDialogProcParam Ptr, _
						GetWindowLongPtr(hwndDlg, GWLP_USERDATA) _
					)
					Dim hTime As HWND = GetDlgItem(hwndDlg, IDC_DTP_TIME)
					Dim hDate As HWND = GetDlgItem(hwndDlg, IDC_DTP_DATE)
					
					DateTime_GetSystemtime(hTime, @pparam->tTime)
					DateTime_GetSystemtime(hDate, @pparam->tDate)
					
					EndDialog(hwndDlg, IDOK)
					
				Case IDCANCEL
					EndDialog(hwndDlg, IDCANCEL)
					
			End Select
			
		Case WM_CLOSE
			EndDialog(hwndDlg, IDCANCEL)
			
		Case Else
			Return False
			
	End Select
	
	Return True
	
End Function
