; Generador de Cartones BINGO MUSICAL v1.0
; Creado por David Hidalgo Marsal - DHM@hotmail.es
; Fecha 12/04/2025 - Fecha compilación 17/04/2025
; Para Jose Medina
; Creado en unas 4h aprox.

#include <WinAPIFiles.au3>
#include <FileConstants.au3>
#include <WinAPIError.au3>
#include <WinAPIFiles.au3>
#include <WinAPIHObj.au3>
#include <WindowsConstants.au3>
#include <GuiListBox.au3>
#include <WinAPIEx.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <File.au3>
#include <date.au3>
#include <GDIPlus.au3>
#include <MPDF_UDF.au3>
#include <StringSize.au3>

Opt("GUIOnEventMode", 1)

Global $hBitmap, $hImage, $hGraphic, $hFamily, $hFont, $tLayout, $hFormat, $aInfo, $hBrush1, $hBrush2, $iWidth, $iHeight, $hPen

; Initialize GDI+ library
_GDIPlus_StartUp()

;Declaramos las variables GLBOALES para poder usar las tablas hash
Global $tha = ObjCreate("Scripting.Dictionary"), $than = ObjCreate("Scripting.Dictionary"), $has[1]

VENTANA()

eliminarfilestemporales()

while 1
	sleep(200)
WEnd

Func VENTANA()
	Global $VENTANA = GUICreate("BingoMusical v1.0", 275, 175,-1,-1)
	GUISetIcon(@ScriptDir & '\app.ico')
	GUISetOnEvent($GUI_EVENT_CLOSE, "wClose",$VENTANA)

	Local $ACERCADE = " BingoMusical v1.0 - Generador de Cartones" & @CRLF & _
		" Fch compilación 17/04/2025 - DHM@hotmail.es" & @CRLF & _
		" Creado por David Hidalgo Marsal (Programación)" & @CRLF & _
		" Jose Medina\Martí Medina (Idea\Diseño cartones)"  & @CRLF
	local $VENTANAID1 = GUICtrlCreateEdit($ACERCADE,10,10,250,60,$ES_READONLY)
   
	Global $VENTANAProgress = GUICtrlCreateLabel("",10,90,250,20)
	GUICtrlSetBkColor(-1, 0x89F80E)
   	Global $VENTANAProgressLabel = GUICtrlCreateLabel("En espera..", 10, 93, 250, 20,  $SS_CENTER, $WS_EX_TOPMOST)
  	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
   
	;Ocultamos el progress hasta que nos haga falta..
  	GUICtrlSetState($VENTANAProgress,$GUI_HIDE)
   
	Global $VENTANAID2 = GUICtrlCreateLabel("Número de cartones a generar:",10,116)
	Global $VENTANAID3 = GUICtrlCreateInput("",165,114,50,20)
	Global $VENTANAID4 = GUICtrlCreateButton("Generar Cartones", 10,135,250,30)
	GUICtrlSetOnEvent(-1, 'Gee')
   
	GUISetState(@SW_SHOW,$VENTANA)
EndFunc

Func gee()
	VENTANAHABDESH(128)
	if GUICtrlRead($VENTANAID3) = '' or 1 > GUICtrlRead($VENTANAID3) Then
		MsgBox(0,'ERROR',"El número de cartones debe ser superior a 0")
		VENTANAHABDESH(64)
		Return
	EndIf
	Global $lista = FileOpenDialog("Selecciona el archivo .txt donde están las canciones listadas", @ScriptDir & "\", "Archivo de texto (*.txt;)")
	If @error Then
		VENTANAHABDESH(64)
		Return
	EndIf
	if Not FileExists($lista) or _FileCountLines($lista) = 0 or Not FileReadLine($lista,1) or 6 > _FileCountLines($lista) Then
		MsgBox(0,"ERROR, No existe el archivo " & @CRLF & $lista & @CRLF & "o no tiene contenido suficiente!")
		VENTANAHABDESH(64)
		Return
	EndIf
	Global $generacartonestotal = GUICtrlRead($VENTANAID3)
	genera()

	generapdf()

EndFunc
Func VENTANAHABDESH($1)
	GUICtrlSetState($VENTANAID3,$1)
    GUICtrlSetState($VENTANAID4,$1)
	GUICtrlSetState($VENTANAProgressLabel,$GUI_FOCUS)
EndFunc
Func wClose()
    Switch @GUI_WinHandle ; See which GUI sent the CLOSE message
	Case $VENTANA
		_GDIPlus_ShutDown()
		Exit
	 EndSwitch
EndFunc

Func generapdf()
	local $archivopdf = @ScriptDir & "\CARTONES.pdf"
	if FileExists($archivopdf) Then FileDelete($archivopdf)
		
	GUICtrlSetPos($VENTANAProgress, 10, 90, 0, 20)
	GUICtrlSetData($VENTANAProgressLabel, 'Generando PDF.. (0%)')

	_SetUnit($PDF_UNIT_CM)
	_SetPaperSize("A4")
	_SetZoomMode($PDF_ZOOM_CUSTOM,90)
	_SetOrientation($PDF_ORIENTATION_PORTRAIT)
	_SetLayoutMode($PDF_LAYOUT_CONTINOUS)
	;initialize the pdf
	_InitPDF($archivopdf)
	;fonts:
	_LoadFontTT("_Arial", $PDF_FONT_ARIAL)
	_LoadFontTT("_TimesT", $PDF_FONT_TIMES)
	_LoadFontTT("_Calibri", $PDF_FONT_CALIBRI)
	_LoadFontStandard("_Garamond", $PDF_FONT_GARAMOND)
	_LoadFontStandard("_Courier", $PDF_FONT_COURIER)
	_SetTextHorizontalScaling(100)
	GLOBAL $PDFNPAGE = 1, $PDFCUENTACART = 1

   Local $hFileFind = FileFindFirstFile(@ScriptDir & '/temp/*'), $a = 0
   If $hFileFind = -1 Then Return
	While 1
        $sFileName = FileFindNextFile($hFileFind)
        If @error Then ExitLoop
		_LoadResImage($sFileName, @ScriptDir & '/temp/' & $sFileName)
		$a += 1
		GUICtrlSetPos($VENTANAProgress, 10, 90, $a * 250 / ($generacartonestotal * 2), 20)
     	GUICtrlSetData($VENTANAProgressLabel, 'Generando PDF.. (' & Round($a * 100 / ($generacartonestotal * 2)) & '%)')
	WEnd
	
	Local $hFileFind = FileFindFirstFile(@ScriptDir & '/temp/*')
   If $hFileFind = -1 Then Return
	While 1
        $sFileName = FileFindNextFile($hFileFind)
        If @error Then ExitLoop
		if $PDFCUENTACART = 1 Then
			_BeginPage()
			_InsertImage($sFileName, 0.5, 15.2, 6, 14)
			_DrawText(19.5, 0.1, 'P' & $PDFNPAGE,"_Arial", 8, $PDF_ALIGN_LEFT, 0)
		EndIf
		if $PDFCUENTACART = 2 Then _InsertImage($sFileName, 7.5, 15.2, 6, 14)
		if $PDFCUENTACART = 3 Then _InsertImage($sFileName, 14.5, 15.2, 6, 14)
		if $PDFCUENTACART = 4 Then _InsertImage($sFileName, 0.5, 0.5, 6, 14)
		if $PDFCUENTACART = 5 Then _InsertImage($sFileName, 7.5, 0.5, 6, 14)
		if $PDFCUENTACART = 6 Then
			_InsertImage($sFileName, 14.5, 0.5, 6, 14)
			$PDFNPAGE += 1
			_EndPage()
			$PDFCUENTACART = 0
		EndIf
		$a += 1
		GUICtrlSetPos($VENTANAProgress, 10, 90, $a * 250 / ($generacartonestotal * 2), 20)
     		GUICtrlSetData($VENTANAProgressLabel, 'Generando PDF.. (' & Round($a * 100 / ($generacartonestotal * 2)) & '%)')
		$PDFCUENTACART += 1
	WEnd
	
	_EndPage()
	_ClosePDFFile()
	VENTANAHABDESH(64)
	eliminarfilestemporales()
	ShellExecute($archivopdf)
EndFunc

Func eliminarfilestemporales()
   Local $hFileFind = FileFindFirstFile(@ScriptDir & '/temp/*')
   If $hFileFind = -1 Then Return
	While 1
        $sFileName = FileFindNextFile($hFileFind)
        If @error Then ExitLoop
		FileDelete(@ScriptDir & '/temp/' & $sFileName)
	WEnd
EndFunc

;GENERAMOS LOS CARTONES A IMAGENES..
Func escribeimagen($textocancion,$artista,$textocancion2,$artista2,$textocancion3,$artista3,$textocancion4,$artista4,$textocancion5,$artista5,$textocancion6,$artista6)
	$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & '\carton.jpg')
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage)
	
	$globalgrosor = 32
	escribetextimg($textocancion,30,270,$globalgrosor)
   	escribetextimg($artista,30,345,$globalgrosor)
	$globalgrosor = 32
	escribetextimg($textocancion2,665,270,$globalgrosor)
   	escribetextimg($artista2,665,345,$globalgrosor)
	$globalgrosor = 32
	escribetextimg($textocancion3,1295,270,$globalgrosor)
    escribetextimg($artista3,1295,345,$globalgrosor)
	$globalgrosor = 32
  	escribetextimg($textocancion4,30,690,$globalgrosor)
    escribetextimg($artista4,30,765,$globalgrosor)
	$globalgrosor = 32
	escribetextimg($textocancion5,665,690,$globalgrosor)
   	escribetextimg($artista5,665,765,$globalgrosor)
	$globalgrosor = 32
	escribetextimg($textocancion6,1295,690,$globalgrosor)
   	escribetextimg($artista6,1295,765,$globalgrosor)
	
	_GDIPlus_ImageRotateFlip($hImage, 1)
	$imagcarton += 1
	_GDIPlus_ImageSaveToFile($hImage, @ScriptDir & '\temp\' & $imagcarton & '.jpg')

	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BrushDispose($hBrush1)
	_GDIPlus_BrushDispose($hBrush2)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose ($hFamily)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_ImageDispose($hImage)
EndFunc
Func escribetextimg($texto,$x,$y,$grosor)
	$texto = StringUpper($texto)
	;Ajustamos la fuente para que quepa dentro del recuadro..
	local $maxlen = 550
	$aSize = _StringSize($texto, $grosor, Default, 0, "Arial", 800)
	if 2 > UBound($aSize) or $aSize[2] > $maxlen Then
		While 1
			$grosor -= 0.008
			$aSize = _StringSize($texto, $grosor, Default, 0, "Arial", 800)
			if UBound($aSize) >= 2 And $maxlen >= $aSize[2] Then ExitLoop
		WEnd
	EndIf
	$globalgrosor = $grosor
	$hFamily  = _GDIPlus_FontFamilyCreate("Arial")
	$hFont    = _GDIPlus_FontCreate($hFamily, $grosor, 1)
	$hFormat  = _GDIPlus_StringFormatCreate(0x4000)
	$hBrush2  = _GDIPlus_BrushCreateSolid(0xff000000)
	$hPen     = _GDIPlus_PenCreate(0xC4000000, 1)
	$tLayout = _GDIPlus_RectFCreate ($x, $y)
	$aInfo    = _GDIPlus_GraphicsMeasureString($hGraphic, $texto, $hFont, $tLayout, $hFormat)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, $texto, $hFont, $aInfo[0], $hFormat, $hBrush2)
EndFunc

;GENERAMOS LOS CARTONES.. COMBINACIONES
Func genera()
    GUICtrlSetPos($VENTANAProgress, 10, 90, 0, 20)
	GUICtrlSetData($VENTANAProgressLabel, 'Generado 0 de ' & $generacartonestotal & ' cartones (0%)')

    GUICtrlSetState($VENTANAProgress,$GUI_SHOW)
    GUICtrlSetState($VENTANAProgressLabel,$GUI_SHOW)
      
	hf("dupli")
	hm("dupli")
	hf("duplib")
	hm("duplib")
	hf("listaazar")
	hm("listaazar")	
	Global $ncancion = 0, $totalcanciones = _FileCountLines($lista), $ndupli = 0, $nduplib = 0, $imagcarton = 0, $globalgrosor = 32
	For $a = 1 to $generacartonestotal
		Local $hTimer = TimerInit(), $lineafinal1 = generalinea()
		while 1
			Local $d = 0, $lineafinal2 = generalinea()
			;Miramos que no repita una cancion en LINEA y LINEA2..
			local $split = StringSplit($lineafinal2,chr(2))
			For $o = 1 to UBound($split) - 1
				if $split[$o] <> '' And StringInStr($lineafinal1,chr(2) & $split[$o] & chr(2)) Then $d = 1
			Next
			if Not $d Then
				if Not norepitascartones($lineafinal1 & $lineafinal2) Then ExitLoop
				$lineafinal1 = generalinea()
			EndIf
			if TimerDiff($hTimer) >= 10000 Then
				MsgBox(0,'ERROR',"Parece que no hay suficientes nombres para generar los cartones..")
				exit
			EndIf
		WEnd
		
		;Metemos el carton en la lista para no generar un carton con los mismos nombres..
		$nduplib += 1
		ha("duplib",$nduplib,$lineafinal1 & $lineafinal2)
		;Metemos las las lineas generadas en la lista para que no se puedan generar ninguna mas con los mismos nombres..
		ha("dupli",$ndupli + 1,$lineafinal1)
		ha("dupli",$ndupli + 2,$lineafinal2)
		$split = StringSplit($lineafinal1 & $lineafinal2,chr(2))
		;Generamos la imagen del carton..
		escribeimagen(gettok($split[2],'2-',45),gettok($split[2],1,45),gettok($split[4],'2-',45),gettok($split[4],1,45),gettok($split[6],'2-',45),gettok($split[6],1,45),gettok($split[8],'2-',45),gettok($split[8],1,45),gettok($split[10],'2-',45),gettok($split[10],1,45),gettok($split[12],'2-',45),gettok($split[12],1,45))
		;Metemos las canciones que nos sirven en la lista temporal listazar para duplicar el menor numero de canciones..
		For $o = 1 to UBound($split) - 1
			if $split[$o] Then
				ha("listaazar",$split[$o],1)
				$ncancion += 1
			EndIf
		Next
		$ndupli += 2
		if $ncancion + 5 >= $totalcanciones Then
			hf("listaazar")
			hm("listaazar")
			$ncancion = 0
		EndIf
		GUICtrlSetPos($VENTANAProgress, 10, 90, $a * 250 / $generacartonestotal, 20)
		GUICtrlSetData($VENTANAProgressLabel, 'Generado ' & $a & ' de ' & $generacartonestotal & ' cartones (' & Round($a * 100 / $generacartonestotal) & '%)')
	Next
EndFunc
;Comprobamos que no haya 2 cartones con las mismas canciones..
Func norepitascartones($carton)
	local $split = StringSplit($carton,chr(2)), $d
	For $a = 1 To $nduplib
		$d = 0
		For $b = 1 to UBound($split)-1
			if $split[$b] And StringInStr(hg("duplib",$a),chr(2) & $split[$b] & chr(2)) Then $d += 1
		Next
		if $d >= 6 Then	Return 1
	Next
EndFunc
Func generalinea()
	While 1
		local $linea1 = chr(2) & cancion() & chr(2), $linea2 = chr(2) & cancion() & chr(2), $linea3 = chr(2) & cancion() & chr(2)
		local $carlineas = $linea1, $d = 0
		if Not StringInStr($carlineas,$linea2) Then
			$carlineas &= $linea2
			if Not StringInStr($carlineas,$linea3) Then
				For $a = 1 To $ndupli
					if StringInStr(hg("dupli",$a),$linea1) and StringInStr(hg("dupli",$a),$linea2) and StringInStr(hg("dupli",$a),$linea3) Then
						$d = 1
						ExitLoop
					EndIf
				Next
				if Not $d Then Return $carlineas & $linea3
			EndIf
		EndIf
	WEnd
EndFunc
Func cancion()
	while 1
		local $cancion = FileReadLine($lista,Random(1,$totalcanciones,1))
		;ToolTip($cancion & ' ' & $ncancion & " " & $totalcanciones)
		if Not hg("listaazar",$cancion) Then Return $cancion
	WEnd
EndFunc

;Funcion gettok, ejemplos:
;=> gettok('hola esto es un ejemplo',1,32) = 32 es el ascii del espacio (separador) devuelve: hola
;=> gettok('hola esto es un ejemplo',2-4,32) = 32 devuelve: esto es un
;=> gettok('hola esto es un ejemplo','2-',32) = 32 devuelve: esto es un ejemplo
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
		  ;if $z > UBound($a)-1 Then ExitLoop
		 $r &= $a[$z] & chr($3)
	  Next
	  if StringRight($r,1) = chr($3) then $r = StringMid($r,1,stringlen($r) - 1)
	  Return $r
   EndIf
   if $2 >= UBound($a) then Return
   return $a[$2]
EndFunc

;Tablas Hash
;FUNC HL cargamos un archivo a la tabla
Func hl($1,$2)
	$1 = StringLower($1)
	local $t = $tha.item($1)
   if $has[$t] = '' or Not $1 or Not $2 Then return ''
   $has[$t] = ObjCreate("Scripting.Dictionary")
   if FileExists($2) Then
		local $dn = gettok($2,gettok($2,0,92),92), $h = FileOpen($2), $sF
		while 1
			$sF = FileReadLine($h)
			If @error = -1 Then ExitLoop
			if $sF <> '' Then ha($1,gettok($sF,1,32),gettok($sF,'2-',32))
		WEnd
		FileClose($h)
		return 1
   EndIf
EndFunc
;FUNC HS guardamos una tabla a un archivo
Func hs($1,$2)
   $1 = StringLower($1)
	Local $t = $tha.item($1)
   if Not $1 or Not $2 or $has[$t] = '' Then Return
	if FileExists(@scriptdir & '\temp.h') Then FileDelete(@scriptdir & '\temp.h')
   Local $h = FileOpen(@scriptdir & '\temp.h',2), $s
   For $v in $has[$t]
	   $s = $has[$t].Item($v)
		if $s <> '' Then FileWrite($h,$v & ' ' & $s & @CRLF)
   Next
   FileClose($h)
   FileMove(@scriptdir & '\temp.h',$2,1)
EndFunc
;FUNC HG leemos un item de una tabla (SIN DIFERENCIAS DE MAYUS Y MINUS)
Func hg($1,$2)
   $1 = StringLower($1)
   $2 = StringLower($2)
   local $t = $tha.item($1)
   if $has[$t] = '' or $has[$t].Item($2) = '' or $2 = '' Then Return ''
   Return $has[$t].Item($2)
EndFunc
;FUNC HD borramos un item de una tabla (SIN DIFERENCIAS DE MAYUS Y MINUS)
Func hd($1,$2)
	$1 = StringLower($1)
	$2 = StringLower($2)
	local $t = $tha.item($1)
	if $has[$t] = '' Then Return
	if $has[$t].exists($2) Then $has[$t].remove($2)
EndFunc
;FUNC HA agregamos un item en una tabla (SIN DIFERENCIAS DE MAYUS Y MINUS)
Func ha($1,$2,$3)
	$1 = StringLower($1)
	$2 = StringLower($2)
   local $t = $tha.item($1)
   if Not $1 or Not $2 or $has[$t] = '' Then Return ''
   if $has[$t].exists($2) Then $has[$t].remove($2)
	$has[$t].add($2,$3)
EndFunc

;FUNC HM Creamos una tabla  (SIN DIFERENCIAS DE MAYUS Y MINUS)
Func hm($1)
   if Not $1 Then return False
   $1 = StringLower($1)
   if $has[$tha.item($1)] = '' Then
	  For $n = 1 to UBound($has) - 1
		 if $than.item($n) = '' Then
			ha_t($1,$n)
			ha_tn($n,$1)
			$has[$n] = ObjCreate("Scripting.Dictionary")
			return 1
		 EndIf
	  Next
	  $n = UBound($has)
	  ReDim $has[$n + 1]
	  ha_t($1,$n)
	  ha_tn($n,$1)
	  $has[$n] = ObjCreate("Scripting.Dictionary")
   EndIf
   return 0
EndFunc
;FUNC HF Borramos una tabla  (SIN DIFERENCIAS DE MAYUS Y MINUS)
Func hf($1)
	$1 = StringLower($1)
	if Not $1 Then return False
	local $t = $tha.item($1)
	if $1 = "*" Then
	  Global $tha = ObjCreate("Scripting.Dictionary")
	  Global $than = ObjCreate("Scripting.Dictionary")
	  For $n = 1 to UBound($has)
		 $has[$n] = ObjCreate("Scripting.Dictionary")
	  Next
	  return 1
   EndIf
   if Not $t Then return False
   $has[$t] = ObjCreate("Scripting.Dictionary")
   hd_tn($t)
   hd_t($1)
   return 1
EndFunc
;FUNCIONES INTERNAS DE TABLAS HASH (NO USADAS POR EL PROGRAMDOR)
func haa_t($i,$v)
   if $tha.Exists($i) Then $tha.remove($i)
   $tha.add($i,$v)
EndFunc
func hdd_t($i)
   if $tha.Exists($i) Then $tha.remove($i)
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
