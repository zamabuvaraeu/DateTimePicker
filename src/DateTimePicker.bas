#include once "DateTimePicker.bi"
#include once "windows.bi"
#include once "win\shlwapi.bi"
#include once "WinMain.bi"

#ifdef WITHOUT_RUNTIME
Sub EntryPoint()
#endif
	
	Dim hMod As HMODULE = GetModuleHandle(0)
	Dim RetCode As Integer = wWinMain( _
		hMod _
	)
	
	#ifdef WITHOUT_RUNTIME
		ExitProcess(RetCode)
	#else
		End(RetCode)
	#endif
	
#ifdef WITHOUT_RUNTIME
End Sub
#endif
