;Organizador de archivos v1.7.3
;Programado y creado por David Hidalgo Marsal [RoK]
;DHM@hotmail.es \ rokmarsal@gmail.com
;Fecha inicio proyecto: 24/08/2020
;Ultima actualización: 11/04/2026

; Los autor(es) no se hacen responsables de los daños o fallos que pueda causar\tenga el programa.

#include <Array.au3>
#include <File.au3>
#include <WinAPIFiles.au3>
#include <Date.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPIError.au3>
#include <WinAPIFiles.au3>
#include <WinAPIHObj.au3>
#include <WindowsConstants.au3>
#include <GuiListBox.au3>
#include <WinAPIEx.au3>
#include <Crypt.au3>
#include <EditConstants.au3>
#include <image_get_info.au3>

TraySetIcon("korganizer_todo.ico")
TraySetState(2)

Global $tha = ObjCreate("Scripting.Dictionary"), $than = ObjCreate("Scripting.Dictionary"), $has[32], $ONTOP

hm("c")
hl("c",@scriptdir & "\conf.txt")

if hg("c","ontop") = 1 Then $ONTOP = 1

Global $diro = hg("c","rorg"), $noduplicar = 0, $mover = 0, $rest, $ancopy, $bytestemp, $bytescop

Local $m = GUICreate("Organizador de archivos v1.7.3",518,240)
GUICtrlCreateTab(5, 5, 510, 230)
GUICtrlCreateTabItem("Organizar && Buscar archivos duplicados")
local $m1 = GUICtrlCreateLabel("Carpeta destino",10,42)
local $m2 = GUICtrlCreateInput("",90,40,396,20)
Local $m3 = GUICtrlCreateButton("?", 488, 38, 20, 25)
local $m7 = GUICtrlCreateProgress(10, 84, 248, 20)
local $m11 = GUICtrlCreateProgress(260, 84, 248, 20)
Local $m6 = GUICtrlCreateButton("Seleccionar carpeta para organizar (incluyendo subcarpetas)", 10, 168, 498, 30)
local $m8 = GUICtrlCreateInput("",10,63,498,20)
Local $m9 = GUICtrlCreateCheckbox("No duplicar archivos (Validado por Hash)", 11, 148, 212, 20)
Local $r2 = GUICtrlCreateRadio("Copiar archivos", 280, 148, 90, 20)
Local $r1 = GUICtrlCreateRadio("Mover archivos", 410, 148, 90, 20)
Local $m5 = GUICtrlCreateButton("Buscar archivos duplicados", 10, 198, 498, 30)
local $m10 = GUICtrlCreateInput("",10,105,498,20)
local $m12 = GUICtrlCreateInput("",10,126,498,20)
Local $m13 = GUICtrlCreateCheckbox("ONTOP", 450, 5, 60, 20)
GUICtrlCreateTabItem("Información")

Local $cf = "Creado por David Hidalgo Marsal" & @CRLF & _
		 "E-mail DHM@hotmail.es" & @CRLF & _
         "Version 1.7.3" & @CRLF & _
         "Fecha compilación 11/04/2026" & @CRLF & _
		 @CRLF & _
         "Al organizar los archivos el programa creará carpetas con los años y dentro las carpetas con los meses donde dispersara cada archivo en el lugar que le corresponda, determinado" & @CRLF & _
		 "primero por los siguientes factores:" & @CRLF & _
		 "1. Se determinará si en el nombre del archivo contiene la fecha de creación, si no existe pasará al punto 2" & @CRLF & _
		 "2. Se determinará en las propiedades del archivo donde se cogerá la fecha" & @CRLF & _
		 "de disparo si existe, de lo contrario cogera la de creación\modificación, en la cual se cogerá la más vieja." & @CRLF & _
		 @CRLF & _
		 "En el caso de que dos archivos coincidan con el mismo nombre, se añadirán números aleatorios" & @CRLF & _
		 "en el nombre del archivo." & @CRLF & _
		 @CRLF & _
		 "Si se marca la casilla 'No duplicar' el sistema determinará si son el mismo archivo" & @CRLF & _
		 "por el mismo tamaño y por una comprobación hash para asegurarse que son el mismo archivo." & @CRLF & _
		 @CRLF & _
		 "NO me hago responsable de cualquier problema o fallo que pueda presentar el programa."
local $m15 = GUICtrlCreateEdit($cf,10,33,498,195,$ES_READONLY + $WS_VSCROLL)
GUISetIcon("korganizer_todo.ico")
GUICtrlSetState($m2,128)
GUICtrlSetState($m8,128)
GUICtrlSetState($m10,128)
GUICtrlSetState($m12,128)
;GUICtrlSetState($m15,128)

GUICtrlSetData($m2,$diro)

if hg("c","mover") = 1 Then
   $mover = 1
   GUICtrlSetState($r1, $GUI_CHECKED)
 Else
   GUICtrlSetState($r2, $GUI_CHECKED)
 EndIf
if hg("c","noduplicar") = 1 Then
   $noduplicar = 1
   GUICtrlSetState($m9, $GUI_CHECKED)
EndIf

if $ONTOP Then GUICtrlSetState($m13, $GUI_CHECKED)

GUISetState(@SW_SHOW, $m)

if $ONTOP Then
	Local $hWnd = WinGetHandle("[ACTIVE]")
	 WinSetOnTop($hWnd, "", 1)
EndIf

GUICtrlSetData($m7,0)
GUICtrlSetData($m11,0)
While 1
   ve()
WEnd
Func ve()
   Switch GUIGetMsg()
   Case $r1
	  If _IsChecked($r1) Then
		 ha("c","mover",1)
		 hs("c","conf.txt")
	  EndIf
   Case $r2
	  If _IsChecked($r2) Then
		 hd("c","mover")
		 hs("c","conf.txt")
   EndIf
   Case $m13
	Local $hWnd = WinGetHandle("[ACTIVE]")
	If _IsChecked($m13) Then
		 $ONTOP = 1
		 ha("c","ontop",1)
		 hs("c","conf.txt")
		 WinSetOnTop($hWnd, "", 1)
		 WinSetState($hWnd, "", @SW_SHOW)
	  Else
		 $ONTOP = 0
		 hd("c","ontop")
		 hs("c","conf.txt")
		WinSetOnTop($hWnd, "", 0)
		WinSetState($hWnd, "", @SW_SHOW)
   EndIf
   Case $m9
	  If _IsChecked($m9) Then
		 $noduplicar = 1
		 ha("c","noduplicar",1)
		 hs("c","conf.txt")
	  Else
		 $noduplicar = 0
		 hd("c","noduplicar")
		 hs("c","conf.txt")
   EndIf
   Case $m5
		 GUICtrlSetState($m3,128)
		 GUICtrlSetState($m6,128)
		 GUICtrlSetState($m9,128)
		 GUICtrlSetState($r1,128)
		 GUICtrlSetState($r2,128)
		 GUICtrlSetState($m5,128)
		 GUICtrlSetData($m7,0)
		 GUICtrlSetData($m11,0)
		 GUICtrlSetData($m8,"")
		 GUICtrlSetData($m10,"")
		 GUICtrlSetData($m12,"")
		 buscaduplicados()
		 hf("du")
		 hf("ds")
		; winmove($m,'',(@Desktopwidth - wingetpos($m)[2]) / 2,(@Desktopheight - wingetpos($m)[3]) / 2)
		 GUICtrlSetData($m8,"")
		 GUICtrlSetData($m10,"")
		 GUICtrlSetData($m12,"")
		 GUICtrlSetData($m7,0)
		 GUICtrlSetData($m11,0)
		 GUICtrlSetState($m5,64)
		 GUICtrlSetState($m3,64)
		 GUICtrlSetState($m6,64)
		 GUICtrlSetState($m9,64)
		 GUICtrlSetState($r1,64)
		 GUICtrlSetState($r2,64)
   Case $m6
		 GUICtrlSetState($m3,128)
		 GUICtrlSetState($m5,128)
		 GUICtrlSetState($m6,128)
		 GUICtrlSetState($m9,128)
		 GUICtrlSetState($r1,128)
		 GUICtrlSetState($r2,128)
		 GUICtrlSetData($m7,0)
		 GUICtrlSetData($m11,0)
		 GUICtrlSetData($m8,"")
		 GUICtrlSetData($m10,"")
		 GUICtrlSetData($m12,"")
		 organiza()
		 GUICtrlSetData($m7,0)
		 GUICtrlSetData($m11,0)
		 GUICtrlSetState($m3,64)
		 GUICtrlSetState($m5,64)
		 GUICtrlSetState($m6,64)
		 GUICtrlSetState($m9,64)
		 GUICtrlSetState($r1,64)
		 GUICtrlSetState($r2,64)
		 GUICtrlSetData($m8,"")
		 GUICtrlSetData($m10,"")
		 GUICtrlSetData($m12,"")
	  Case $m3
		 Local $dirt = FileSelectFolder("Selecciona la carpeta donde quieres que se organicen los archivos", "")
		 if FileExists($dirt) <> 0 or $dirt <> "" Then
			$dirt = $dirt & "\"
			$diro = $dirt
			ha("c","rorg",$diro)
			hs("c","conf.txt")
			GUICtrlSetData($m2,$diro)
		 EndIf
	  Case $GUI_EVENT_CLOSE
			Exit
   EndSwitch
EndFunc
Func _HASHFile($Data, $HASH = -1)
   Return _Crypt_HashFile($Data, $CALG_MD5)
EndFunc
Func ctime()
 return _DateDiff( 's',"1970/01/01 00:00:00",_NowCalc())
EndFunc
Func _IsChecked($idControlID)
        Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc
Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
    #forceref $hWnd, $iMsg
    Local $hWndFrom, $iIDFrom, $iCode, $hWndListBox, $sItems
    If Not IsHWnd($idListBox) Then $hWndListBox = GUICtrlGetHandle($idListBox)
    $hWndFrom = $lParam
    $iIDFrom = BitAND($wParam, 0xFFFF)
    $iCode = BitShift($wParam, 16)
    Switch $hWndFrom
	Case $idListBox, $hWndListBox
	  Switch $iCode
			Case $LBN_DBLCLK
			   Local $aItems = _GUICtrlListBox_GetSelItemsText($idListBox)
			   For $iI = 1 To $aItems[0]
				  if $aItems[$iI] Then
					 ShellExecute($aItems[$iI])
					 ExitLoop
				  EndIf
			   Next
		 EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
 EndFunc
Func DELFILESSUPR()
   if WinGetTitle("[ACTIVE]") = "Archivos duplicados" Then DELFILES()
EndFunc
Func DELFILES()
	  Local $aItems = _GUICtrlListBox_GetSelItemsText($idListBox), $ttt
	  For $iI = 1 To $aItems[0]
		 if $aItems[$iI] Then
			Local $confir = MsgBox (4, "Confirmación" ,"¿Seguro que desea eliminar" & @crlf & $aItems[$iI] & "?")
			if $confir = 6 Then
			   ha("ds",$aItems[$iI],1)
			   $ttt = 1
			EndIf
		 EndIf
	  Next
	  if $ttt = 1 Then
		 _GUICtrlListBox_ResetContent($idListBox)
		 _GUICtrlListBox_BeginUpdate($idListBox)
		 For $iIs = 1 To $s[0]
			if $s[$iIs] Then
			   if hg("ds",$s[$iIs]) = "" Then
					 _GUICtrlListBox_AddString($idListBox,$s[$iIs])
				  Else
				  if FileExists($s[$iIs]) Then
					 if FileDelete($s[$iIs]) = 0 Then
						   hd("ds",$s[$iIs])
						   msgbox(0,"ERROR","No se pudo eliminar el archivo" & @CRLF & $s[$iIs] & @crlf "Parece que puede estar en uso por algún programa")
						_	GUICtrlListBox_AddString($idListBox,$s[$iIs])
						Else
						   ha("ds",$s[$iIs],1)
					 EndIf
				  EndIf
			   EndIf
			EndIf
		 Next
	  _GUICtrlListBox_EndUpdate($idListBox)
   EndIf
EndFunc

;Formateamos los tiempos..
Func _FormatElapsedTime($Input_Seconds)
  If $Input_Seconds < 1 Then Return
  Global $ElapsedMessage = ''
  Global $Input = $Input_Seconds
  Switch $Input_Seconds
    Case 0 To 59
      GetSeconds()
    Case 60 To 3599
      GetMinutes()
      GetSeconds()
    Case 3600 To 86399
      GetHours()
      GetMinutes()
      GetSeconds()
    Case Else
      GetDays()
      GetHours()
      GetMinutes()
      GetSeconds()
  EndSwitch
Return $ElapsedMessage
EndFunc   ;==>FormatElapsedTime
Func GetDays()
  $Days = Int($Input / 86400)
  $Input -= ($Days * 86400)
  $ElapsedMessage &= $Days & 'd '
  Return $ElapsedMessage
EndFunc   ;==>GetDays
Func GetHours()
  $Hours = Int($Input / 3600)
  $Input -= ($Hours * 3600)
  $ElapsedMessage &= $Hours & 'h '
  Return $ElapsedMessage
EndFunc   ;==>GetHours
Func GetMinutes()
  $Minutes = Int($Input / 60)
  $Input -= ($Minutes * 60)
  $ElapsedMessage &= $Minutes & 'm '
Return $ElapsedMessage
EndFunc   ;==>GetMinutes
Func GetSeconds()
  $ElapsedMessage &= Int($Input) & 's '
Return $ElapsedMessage
EndFunc   ;==>GetSeconds


Func buscaduplicados()
   Local $dir = FileSelectFolder("Selecciona la carpeta donde están los archivos para buscar duplicados", ""), $atime, $calc, $g, $a, $cr, $size, $tini = TimerInit(), $tve, $tr, $trm, $trs, $tra
   Global $s
   if FileExists($dir) = 0 or $dir = "" Then Return
   hf("du")
   hm("du")
   hf("du2")
   hm("du2")
   $dir = $dir & "\"
   GUICtrlSetData($m8,"Calculando número de archivos")
   $size = DirGetSize($dir,1)
   GetFilesD(0,0,0)
   GetFilesD($dir,$size[1],nump($size[1]))
   $g = nump($size[1])
   GUICtrlSetData($m8,"Calculando hash..")
   $tve = TimerInit()
   $a = 0
   $tr = TimerInit()
   $trm = 0
   $trs = 0
   $tra = 0
   For $v in $has[$tha.item("du")]
	  if TimerDiff($tve) >= 500 Then
		 For $k = 1 to 2
			ve()
		 Next
		 $tve = TimerInit()
	  EndIf
	  if $has[$tha.item("du")].Item($v) <> "" Then
		 $tra += 1
		 $a += 1
		 if TimerDiff($tr) >= 1000 Then
			$tr = TimerInit()
			$trm += 1
			$trs += $tra
			$tra = 0
		 EndIf
		 $s = StringSplit($has[$tha.item("du")].Item($v),"?")
		 GUICtrlSetData($m10,$s)
		 if UBound($s) > 3 Then
			For $c = 1 to UBound($s) - 1
			   GUICtrlSetData($m10,$s[$c])
			   $cr = $v & _HASHFile($s[$c])
			   ha("du2",$cr,hg("du2",$cr) & $s[$c] & "?")
			Next
		 EndIf
		 $calc = Round($a * 100 / $size[1])
		 $cat = _FormatElapsedTime(($size[1] - $a) / ($trs / $trm))
		 if StringLeft($cat,1) = "-" then $cat = "..."
		 GUICtrlSetData($m8,"Calc hash.. " & nump($a) & " de " & $g & " - Faltan " & nump($size[1] - $a) & " - " & $calc & "% - T. Restante " & $cat)
		 GUICtrlSetData($m11,$calc)
	  EndIf
   Next
   GUICtrlSetData($m11,100)
   GUICtrlSetData($m8,"Comprobando archivos..")
   GUICtrlSetData($m10,"")
   $a = 1
   For $v in $has[$tha.item("du2")]
	  if TimerDiff($tve) >= 500 Then
		 For $k = 1 to 2
			ve()
		 Next
		 $tve = TimerInit()
	  EndIf
	  if $has[$tha.item("du2")].Item($v) <> "" Then
		 $s = StringSplit($has[$tha.item("du2")].Item($v),"?")
		 GUICtrlSetData($m8,"Esperando acción para los archivos duplicados")
		 GUICtrlSetData($m10,$s[1])
		 if UBound($s) > 3 Then
			hf("ds")
			hm("ds")
		;	winmove($m,'',(@Desktopwidth - wingetpos($m)[2]) / 2,(@Desktopheight - wingetpos($m)[3]) / 6)
			Global $hGUI = GUICreate("Archivos duplicados", 800, 220)
			Global $idListBox = GUICtrlCreateList("", 2, 2, 696, 218, BitOR($LBS_STANDARD, $LBS_EXTENDEDSEL))
			Global $buteliminar = GUICtrlCreateButton("Eliminar", 700, 92, 98, 30)
			Global $butstelim = GUICtrlCreateButton("Dejar solo 1 copia", 700, 63, 98, 30)
			Global $butelstop = GUICtrlCreateButton("Parar", 700, 2, 98, 30)
			Global $butelrun = GUICtrlCreateButton("Abrir ubicación", 700, 32, 98, 30)
			Global $butelcerr = GUICtrlCreateButton("Cerrar", 700, 184, 98, 30)
			GUISetIcon("korganizer_todo.ico")
			GUISetState(@SW_SHOW)
			GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
			_GUICtrlListBox_BeginUpdate($idListBox)
			For $iI = 1 To $s[0]
			   if $s[$iI] Then _GUICtrlListBox_AddString($idListBox,$s[$iI])
			Next
			_GUICtrlListBox_EndUpdate($idListBox)
			while 1
			   Switch GUIGetMsg()
			   Case $butstelim
				  local $ssfi = "", $confir = MsgBox (4, "Confirmación" ,"¿Seguro que desea eliminar TODOS los archivos menos 1?")
				  if $confir = 6 Then
				  _GUICtrlListBox_ResetContent($idListBox)
				  _GUICtrlListBox_BeginUpdate($idListBox)
				  For $iIs = 1 To $s[0]
				  if $s[$iIs] Then
					 if hg("ds",$s[$iIs]) = "" Then
						if FileExists($s[$iIs]) then
						   if $ssfi Then
								 if FileDelete($s[$iIs]) = 0 Then
									   hd("ds",$s[$iIs])
									   msgbox(0,"ERROR","No se pudo eliminar el archivo" & @CRLF & $s[$iIs] & @crlf "Parece que puede estar en uso por algún programa")
									Else
									   ha("ds",$s[$iIs],1)
								 EndIf
							  Else
								 $ssfi = $s[$iIs]
						   EndIf
						EndIf
					 EndIf
				  EndIf
				  Next
				  _GUICtrlListBox_AddString($idListBox,$ssfi)
				  _GUICtrlListBox_EndUpdate($idListBox)
				  EndIf
			   Case $buteliminar
				  DELFILES()
			   Case $butelrun
				  Local $aItems = _GUICtrlListBox_GetSelItemsText($idListBox)
				  For $iI = 1 To $aItems[0]
					 if $aItems[$iI] Then
						ShellExecute(gettok($aItems[$iI],"1-" & gettok($aItems[$iI],0,92) - 1,92) & "\")
						ExitLoop
					 EndIf
				  Next
			   Case $butelcerr
				  GUIDelete($hGUI)
				  ExitLoop
			   Case $butelstop
					 GUICtrlSetData($m8,"")
					 GUICtrlSetData($m10,"")
					 hf("du")
					 hf("du2")
					 GUIDelete($hGUI)
					 Return
				  Case $GUI_EVENT_CLOSE
					 GUIDelete($hGUI)
					 Exit
					 ExitLoop
			   EndSwitch
			WEnd
			GUIDelete($hGUI)
			hf("ds")
		 EndIf
		; winmove($m,'',(@Desktopwidth - wingetpos($m)[2]) / 2,(@Desktopheight - wingetpos($m)[3]) / 2)
	  EndIf
	 ; GUICtrlSetData($m11,Round($a * 100 / $size[1]))
	  $a += 1
   Next
   GUICtrlSetData($m7,100)
   GUICtrlSetData($m11,100)
   MsgBox(0,"","No hay más archivos duplicados!")
   GUICtrlSetData($m8,"")
   GUICtrlSetData($m10,"")
EndFunc
Func GetFilesD($sFilePath,$t,$t2)
   Local Static $a = 0
   Local Static $tr = TimerInit()
   Local Static $trm = 0
   Local Static $trs = 0
   Local Static $tra = 0
   Local Static $tve = TimerInit()
   if $sFilePath = 0 and $t = 0 Then
	  $a = 0
	  $tr = TimerInit()
	  $trm = 0
	  $trs = 0
	  $tra = 0
	  $tve = TimerInit()
	  Return
   EndIf
   Local $hFileFind = FileFindFirstFile($sFilePath & '*'), $tt, $g, $calc, $cat
   If $hFileFind = -1 Then Return
   While 1
	  if TimerDiff($tve) >= 1000 Then
		 For $k = 1 to 3
			ve()
		 Next
		 $tve = TimerInit()
	  EndIf
        $sFileName = FileFindNextFile($hFileFind)
        If @error Then ExitLoop
		 $tt = $sFilePath & $sFileName
        If @extended Then ; Is directory.
            GetFilesD($tt & "\",$t,$t2)
		 Else
			$a += 1
			$tra += 1
			if TimerDiff($tr) >= 1000 Then
			   $tr = TimerInit()
			   $trm += 1
			   $trs += $tra
			   $tra = 0
			EndIf
			$calc = Round($a * 100 / $t)
			$cat = _FormatElapsedTime(($t - $a) / ($trs / $trm))
			if StringLeft($cat,1) = "-" then $cat = "..."
			GUICtrlSetData($m8,"Leyendo archivos " & nump($a) & " de " & $t2 & " - Faltan " & nump($t - $a) & " - " & $calc & "% - T. Restante " & $cat)
			GUICtrlSetData($m10,$tt)
			$g = FileGetSize($tt)
			$g &= ">"
			ha("du2",$g,1)
			ha("du",$g,hg("du",$g) & $tt & "?")
			GUICtrlSetData($m7,$calc)
        EndIf
    WEnd
    FileClose($hFileFind)
EndFunc
Func organiza()
   if FileExists($diro) = 0 Then
	  MsgBox(0,"","ERROR! La carpeta donde hay que organizar los archivos no existe!")
	  Return
   EndIf
   Local $dir = FileSelectFolder("Selecciona la carpeta donde están los archivos a organizar", ""), $total2, $size
   if FileExists($dir) = 0 or $dir = "" Then Return
   $dir = $dir & "\"
   GUICtrlSetData($m8,"Calculando número de archivos")
   $total2 = DirGetSize($dir,1)
   $total = $total2[1]
   Local $confir = MsgBox (4, "Confirmación" ,"¿Seguro que desea organizar" & @crlf & $dir & "?" & @CRLF & @CRLF & "Hay " & nump($total) & " archivos!" & @CRLF & @CRLF & "NOTA: Antes de proceder verifique la fecha del ordenador " & _NowDate() & " es correcto.")
   if $confir <> 6 Then Return
   $rest = 0
   $ancopy = 0
   hf("du")
   hm("du")
   hf("du2")
   hm("du2")
   if $noduplicar Then
	  $size = DirGetSize($diro,1)
	  GetFilesD(0,0,0)
	  GetFilesD($diro,$size[1],nump($size[1]))
   EndIf
   GUICtrlSetData($m7,100)
   sleep(500)
   GUICtrlSetData($m7,0)
   $bytestemp = 0
   $bytescop = 0
   GetFilesS(0,0,0,0)
   GetFilesS($dir,$total,nump($total),$total2[0])
   GUICtrlSetData($m11,100)
   GUICtrlSetData($m8,"")
   hf("du")
   hf("du2")
   if $noduplicar Then
	  $rest = nump($rest) & " archivos omitidos por ser duplicados."
   Else
	  $rest = ""
   EndIf
   MsgBox(0,"",nump(($total - $rest) - $ancopy) & " de " & nump($total) & " archivos organizados!" & @CRLF & $rest & @CRLF & $ancopy & " Archivos no copiados\movidos por errores al copiar")
EndFunc
Func GetFilesS($sFilePath,$t,$t2,$siz)
   Local Static $y = 0
   Local Static $trm = 0
   Local Static $trs = 0
   Local Static $tra = 0
   Local Static $tve = TimerInit()
   Local Static $tr = TimerInit()
   if $sFilePath = 0 and $t = 0 Then
	  $y = 0
	  $trm = 0
	  $trs = 0
	  $tra = 0
	  $tve = TimerInit()
	  $tr = TimerInit()
	  Return
   EndIf
   Local $hFileFind = FileFindFirstFile($sFilePath & '*'), $tt, $g, $calc, $cat, $g, $porc, $pst, $atime, $atimec, $diram, $rn, $dirtot, $g2, $s, $ttt, $acc, $fsf, $atimedisparo
   if $mover Then
		 $acc = "Moviendo"
	  Else
		 $acc = "Copiando"
   EndIf
   If $hFileFind = -1 Then Return
   While 1
	  GUICtrlSetData($m7,0)
	  if TimerDiff($tve) >= 1000 Then
		 For $k = 1 to 3
			ve()
		 Next
		 $tve = TimerInit()
	  EndIf
        $sFileName = FileFindNextFile($hFileFind)
        If @error Then ExitLoop
		 $dirtot = $sFilePath & $sFileName
        If @extended Then ; Is directory.
            GetFilesS($dirtot & "\",$t,$t2,$siz)
		 Else
			$y += 1
			if TimerDiff($tr) >= 1000 Then
			   $tr = TimerInit()
			   $trm += 1
			   $trs += $bytestemp
			   $bytestemp = 0
			EndIf
			$calc = Round($y * 100 / $t)
			$cat = _FormatElapsedTime(($siz - $bytescop) / ($trs / $trm))
			if StringLeft($cat,1) = "-" then $cat = "..."
			GUICtrlSetData($m8,$acc & " archivos " & nump($y) & " de " & $t2 & " - Faltan " & nump($t - $y) & " - " & $calc & "% - T. Restante " & $cat)
			GUICtrlSetData($m10,$dirtot)
			GUICtrlSetData($m11,$calc)
			GUICtrlSetData($m12,"")
   $g = 0
   $g2 = FileGetSize($dirtot)
   if $noduplicar Then
	  $g2 &= ">"
	  if hg("du",$g2) Then
		 $s = StringSplit(hg("du",$g2),"?")
		 For $z = 1 to UBound($s) - 1
			ha("du",$g2 & _HASHFile($s[$z]),1)
		 Next
		 hd("du",$g2)
	  EndIf
	  if hg("du2",$g2) Then
			$ttt = _HASHFile($dirtot)
			if hg("du",$g2 & $ttt) Then
			   $g = 1
			   $rest += 1
			Else
			   ha("du",$g2 & $ttt,1)
			EndIf
		 Else
			ha("du2",$g2,1)
			ha("du",$g2,hg("du",$g2) & $dirtot & "?")
	  EndIf
   EndIf
   if $g = 1 Then
	  $siz -= $g2
   Else
	  $bytestemp += $g2
	  $bytescop += $g2
	  ;Fecha ultima modificación
	  $atime = FileGetTime($dirtot,0)
	  ;Fecha creación
	  $atimec = FileGetTime($dirtot,1)
	  ;Fecha disparo (DateTimeOriginal)
	  $atimedisparo = _ImageGetInfo($dirtot)

	  local $split = StringSplit($atimedisparo,@CRLF)
	  ;Cogemos la fecha real de disparo si existe y comprobamos que el valor del split sea el correcto por seguridad
	  if UBound($split) >= 9 And StringLeft($split[9],17) = 'DateTimeOriginal=' and _DateIsValid(StringReplace(gettok(StringMid($split[9],18),1,32),':','/')) Then
		 ;Cogemos solo la fecha (Entrada: 2022:10:23 15:13:40 Salida: 2022\10\23)
		 $atime = StringReplace(gettok(StringMid($split[9],18),1,32),':','\')
		 ;Declaramos y normalizamos el nuevo split con los datos de la fecha del disparo
		 $atime = StringSplit($atime,'\',2)
	  Else
		 ;Si la fecha de creación es más grande que la de modificación, le pasamos $atime la fecha de creación
		 if _DateDiff('d',$atimec[0] & "/" & $atimec[1] & "/" & $atimec[2],$atime[0] & "/" & $atime[1] & "/" & $atime[2]) > 0 Then $atime = $atimec
	  EndIf

	  ;Comprobamos que el archivo exista y tengamos el array con los datos
	  if UBound($atime) = 6 Then
		 $fsf = filesacafecha($dirtot)
		 if $fsf = 0 Then
			   $diram = $diro & $atime[0] & "\" & $atime[1] & "\"
			   if FileExists($diro & $atime[0]) = 0 Then DirCreate($diro & $atime[0])
			Else
			   $diram = $diro & $fsf
			   if FileExists($diro & gettok($fsf,1,92)) = 0 Then DirCreate($diro & gettok($fsf,1,92))
		 EndIf
		 if FileExists($diram) = 0 Then DirCreate($diram)
		 if FileExists($diram & $sFileName) = 1 Then
			While 1
			   $rn = random(1000,900000,1) & "_"
			   if FileExists($diram & $rn & $sFileName) = 0 Then
				  $diram = $diram & $rn & $sFileName
				  ExitLoop
			   EndIf
			WEnd
		 Else
			$diram &= $sFileName
		 EndIf
		 GUICtrlSetData($m12,$diram)
		 $cat = _Copy($dirtot,$diram, 2048)
		 FileSetTime($diram, FileGetTime($dirtot,0,1), 0)
		 FileSetTime($diram, FileGetTime($dirtot,1,1), 1)
		 if $cat = 1 Then
			   if $mover Then FileDelete($dirtot)
			Else
			   $ancopy += 1
		 EndIf
	  EndIf
	  EndIf
	  EndIf
    WEnd
    FileClose($hFileFind)
EndFunc
Func filesacafecha($1)
   local $np = StringSplit($1,"\")
   $1 = $np[UBound($np) - 1]
   Local $f, $a, $m, $d, $t = 0
   For $z = 1 to StringLen($1)
	  $f = stringmid($1,$z,8)
	  if StringIsDigit($f) And stringlen($f) = 8 Then
		 $a = stringleft($f,4)
		 $m = stringmid($f,5,2)
		 $d = stringmid($f,7,2)
		 if $z > 1 And Not StringIsDigit(stringmid($1,$z - 1,1)) Then
			   $t = 0
			ElseIf $z > 1 Then
			   $t = 1
		 EndIf
		 if $t = 0 And Not StringIsDigit(stringmid($1,$z + 8,1)) And @year >= $a And $a >= 1970 and $m >= 1 And 12 >= $m And 31 >= $d And $d >= 1 Then Return $a & "\" & $m & "\"
	  EndIf
   Next
EndFunc

;Func _copy: grabar archivo..
Func _Copy($inSource, $inDest, $ChunkSize = 2048)
    $SourceFile = FileOpen($inSource, 16)
    If $SourceFile = -1 Then Return 0
    $DestFile = FileOpen($inDest, 26)
    If $SourceFile = -1 Then Return 0
    $SourceSize = FileGetSize($inSource)
    $Chunks = $SourceSize / $ChunkSize
    For $i = 0 to $Chunks
        $Data = FileRead($SourceFile, $ChunkSize)
        FileWrite($DestFile, $Data)
		GUICtrlSetData($m7,(($i + 1) / $Chunks) * 100)
    Next
    FileClose($SourceFile)
    FileClose($DestFile)
    $DestSize = FileGetSize($inDest)
    If $SourceSize = $DestSize Then Return 1
    Return 0
EndFunc

;Función nump: Ponemos los puntos cada 3 números
;Entrada de ejemplo: 1000 salida: 1.000
Func nump($n)
    Return StringRegExpReplace(StringReplace($n, ".", ""), "(?<=\d)(?=(\d{3})+$)", ".")
EndFunc


;Funcion gettok, ejemplos:
;=> gettok('hola esto es un ejemplo',1,32) = 32 es el ascii del espacio (separador) devuelve: hola
;=> gettok('hola esto es un ejemplo',2-4,32) = 32 devuelve: esto es un
;=> gettok('hola esto es un ejemplo','2-',32) = 32 devuelve: esto es un ejemplo
;=> gettok('hola esto es un ejemplo','0',32) = 32 devuelve: El Nº total del contenido
Func gettok($1,$2,$3)
   local $b, $c, $p, $r, $a
   if stringleft($1,1) = chr($3) then $1 = StringMid($1,2,-1)
   if StringRight($1,1) = chr($3) then $1 = StringMid($1,1,stringlen($1) - 1)
   if $2 = 0 then
	  $r = 0
	  $a = StringSplit($1, chr($3))
	  if $1 <> "" Then $r = 1
	  Return UBound($a) - 3 + $r
   EndIf
   $a = StringSplit($1, chr($3))
   if StringInStr($2,"-") Then
	  $b = Number(stringmid($2,1,StringInStr($2,"-") - 1))
	  $c = Number(stringmid($2,StringInStr($2,"-") + 1,-1))
	  $p = $c
	  if Not $c Then
			$p = UBound($a) - 1
		 Else
			if $b > $c Then Return
	  EndIf
	  For $z = $b to $p
		 $r = $r & $a[$z] & chr($3)
	  Next
	  if StringRight($r,1) = chr($3) then $r = StringMid($r,1,stringlen($r) - 1)
	  Return $r
   EndIf
   if $2 >= UBound($a) then Return
   return $a[$2]
EndFunc

;Tablas Hash y funciones auxiliares
Func hgi($1)
   $1 = StringLower($1)
   if $has[$tha.item($1)] = "" then Return 0
   return $has[$tha.item($1)].Count
EndFunc
Func hl($1,$2)
   $1 = StringLower($1)
   if $has[$tha.item($1)] = "" or Not $1 or Not $2 Then return ""
   $has[$tha.item($1)] = ObjCreate("Scripting.Dictionary")
   if FileExists($2) Then
	  local $dn = gettok($2,gettok($2,0,92),92), $tl2 = _FileCountLines($2), $h = FileOpen($2), $sF, $lin = 1
	  while 1
		 $sF = FileReadLine($h)
		 If @error = -1 Then ExitLoop
		 if $sF <> "" Then ha($1,gettok($sF,1,32),gettok($sF,"2-",32))
		 $lin += 1
	  WEnd
	  FileClose($h)
	  return 1
   EndIf
EndFunc
Func hs($1,$2)
   $1 = StringLower($1)
   if Not $1 or Not $2 Then return ""
   if $has[$tha.item($1)] = "" Then Return
   Local $h = FileOpen($2, 2), $ping
   For $v in $has[$tha.item($1)]
	  if $has[$tha.item($1)].Item($v) <> "" Then FileWrite($h,$v & " " & $has[$tha.item($1)].Item($v) & @CRLF)
   Next
   FileClose($h)
EndFunc

;Normal
Func hg($1,$2)
   $1 = StringReplace(StringLower($1),chr(32),"")
   if $has[$tha.item($1)] = "" or $has[$tha.item($1)].Item($2) = "" or $2 = "" Then return ""
   Return $has[$tha.item($1)].Item($2)
EndFunc
Func hd($1,$2)
   $1 = StringLower($1)
   if $has[$tha.item($1)] = "" then Return
   if $has[$tha.item($1)].exists($2) Then $has[$tha.item($1)].remove($2)
EndFunc
Func ha($1,$2,$3)
   $1 = StringReplace(StringLower($1),chr(32),"")
   if Not $1 or Not $2 or $has[$tha.item($1)] = "" then return ""
   hd($1,$2)
   if $3 <> "" Then $has[$tha.item($1)].add($2,$3)
EndFunc
;-------------
;Diferencias
Func _hg($1,$2)
   $1 = StringReplace($1,chr(32),"")
   if $has[$tha.item($1)] = "" or $has[$tha.item($1)].Item($2) = "" or $2 = "" Then return ""
   Return $has[$tha.item($1)].Item($2)
EndFunc
Func _hd($1,$2)
   if $has[$tha.item($1)] = "" then Return
   if $has[$tha.item($1)].exists($2) Then $has[$tha.item($1)].remove($2)
EndFunc
Func _ha($1,$2,$3)
   $1 = StringReplace($1,chr(32),"")
   if Not $1 or Not $2 or $has[$tha.item($1)] = "" then return ""
   _hd($1,$2)
   $has[$tha.item($1)].add($2,$3)
EndFunc
;------------
Func hm($1)
   if Not $1 Then return False
   $1 = StringLower($1)
   if $has[$tha.item($1)] = "" Then
	  For $n = 1 to UBound($has)
		 if $than.item($n) = "" Then
			ha_t($1,$n)
			ha_tn($n,$1)
			$has[$n] = ObjCreate("Scripting.Dictionary")
			return 1
		 EndIf
	  Next
   EndIf
   return 0
EndFunc
Func hf($1)
   $1 = StringLower($1)
   if Not $1 Then return False
   if $1 = "*" Then
	  Global $tha = ObjCreate("Scripting.Dictionary")
	  Global $than = ObjCreate("Scripting.Dictionary")
	  For $n = 1 to UBound($has)
		 $has[$n] = ObjCreate("Scripting.Dictionary")
	  Next
	  return 1
   EndIf
   $1 = StringLower($1)
   if Not $tha.item($1) Then return False
   $has[$tha.item($1)] = ObjCreate("Scripting.Dictionary")
   hd_tn($tha.item($1))
   hd_t($1)
   return 1
EndFunc
func ha_t($i,$v)
   $i = stringlower($i)
   if $tha.Exists($i) Then $tha.remove($i)
   $tha.add($i,$v)
EndFunc
func hd_t($i)
   $i = StringLower($i)
   if $tha.Exists($i) Then $tha.remove($i)
EndFunc
func ha_tn($i,$v)
   if $than.Exists($i) Then $than.remove($i)
   $than.add($i,$v)
EndFunc
func hd_tn($i)
   if $than.Exists($i) Then $than.remove($i)
EndFunc