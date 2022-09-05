#include once "WinMain.bi"
#include once "win\commctrl.bi"
#include once "MainDialogProc.bi"
#include once "Resources.RH"

Const RESOURCE_STRING_CAPACITY = 255
Const SUMMARY_STRING_CAPACITY = 4095

Type ResourceStringBuffer
	ResourceString(RESOURCE_STRING_CAPACITY) As TCHAR
End Type

Type SummaryStringBuffer
	SummaryString(SUMMARY_STRING_CAPACITY) As TCHAR
End Type

Function wWinMain( _
		Byval hInst As HINSTANCE _
	)As Integer
	
	Dim icc As INITCOMMONCONTROLSEX = Any
	icc.dwSize = SizeOf(INITCOMMONCONTROLSEX)
	icc.dwICC = ICC_ANIMATE_CLASS Or _
		ICC_BAR_CLASSES Or _
		ICC_COOL_CLASSES Or _
		ICC_DATE_CLASSES Or _
		ICC_HOTKEY_CLASS Or _
		ICC_INTERNET_CLASSES Or _
		ICC_LINK_CLASS Or _
		ICC_LISTVIEW_CLASSES Or _
		ICC_NATIVEFNTCTL_CLASS Or _
		ICC_PAGESCROLLER_CLASS Or _
		ICC_PROGRESS_CLASS Or _
		ICC_STANDARD_CLASSES Or _
		ICC_TAB_CLASSES Or _
		ICC_TREEVIEW_CLASSES Or _
		ICC_UPDOWN_CLASS Or _
		ICC_USEREX_CLASSES Or _
	ICC_WIN95_CLASSES
	
	Dim res As BOOL = InitCommonControlsEx(@icc)
	If res = 0 Then
		Return 1
	End If
	
	Dim param As MainDialogProcParam = Any
	param.hInst = hInst
	
	Dim DialogBoxParamResult As INT_PTR = DialogBoxParam( _
		hInst, _
		MAKEINTRESOURCE(IDD_DLG_MAIN), _
		NULL, _
		@MainDialogProc, _
		Cast(LPARAM, @param) _
	)
	If DialogBoxParamResult <= 0 Then
		Return 1
	End If
	
	If DialogBoxParamResult = IDOK Then
		Dim tszResText As ResourceStringBuffer = Any
		LoadString( _
			hInst, _
			IDS_SUMMARY, _
			@tszResText.ResourceString(0), _
			RESOURCE_STRING_CAPACITY _
		)
		
		Dim tszResCaption As ResourceStringBuffer = Any
		LoadString( _
			hInst, _
			IDS_DTP, _
			@tszResCaption.ResourceString(0), _
			RESOURCE_STRING_CAPACITY _
		)
		
		Dim uHour As UShort = param.tTime.wHour
		Dim uMinute As UShort = param.tTime.wMinute
		Dim uSecond As UShort = param.tTime.wSecond
		Dim uYear As UShort = param.tDate.wYear
		Dim uMonth As UShort = param.tDate.wMonth
		Dim uDay As UShort = param.tDate.wDay
		
		Dim buffer As SummaryStringBuffer = Any
		wsprintf( _
			@buffer.SummaryString(0), _
			@tszResText.ResourceString(0), _
			uHour, uMinute, uSecond, _
			uYear, uMonth, uDay _
		)
		
		MessageBox( _
			NULL, _
			@buffer.SummaryString(0), _
			@tszResCaption.ResourceString(0), _
			MB_OK Or MB_ICONINFORMATION _
		)
	End If
	
	Return 0
	
End Function
