;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;
; Addon: Cliente MC FTP v1.1 FINAL
; Trabajo realizado por:
; David Hidalgo Marsal [RoK] (Programación)
; Publicado: 06/04/2011
; E-mail: rokscripter@terra.es
; Web: Www.MainCenter.Ya.St
;
; Queda totalmente prohibida la copia sin el permiso de
; Su(s) Autor(es). Prohibido Modificar el codigo del addon "Copiar no es la solución"
; Los autores no se hacen responsables de los daños que pueda causar el usuario.
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Menu menubar {
  Cliente MC FTP v1.1: rokftp
}
alias rokftp.acercade { if (!$dialog(rokftp.acercade)) { dialog -dm rokftp.acercade rokftp.acercade } }
Dialog rokftp.acercade {
  Title "Addon Cliente MC FTP v1.1 - Acerca de.."
  Size -1 -1 300 250
  EDiT "" 1, 15 30 270 190,read,autohs,multi,autovs,vsbar,hsbar
  Button "Cerrar" 2, 10 225 280 20,ok
  TEXT "Acerca de.." 3, 10 10 100 20
}
on *:dialog:rokftp.acercade:init:*:{
  .did -a $dname 1 $crlf
  .did -a $dname 1 Addon: Cliente MC FTP $crlf
  .did -a $dname 1 Version: v1.1 Final $crlf
  .did -a $dname 1 $crlf
  .did -a $dname 1 Trabajo realizado por: $crlf
  .did -a $dname 1 RoK, (David Hidalgo Marsal) $crlf
  .did -a $dname 1 $crlf
  .did -a $dname 1 Beta-Testers: $crlf
  .did -a $dname 1 Dark[Byte] y FsDk $crlf
  .did -a $dname 1 $crlf
  .did -a $dname 1 Publicado: 06/04/2011 $crlf
  .did -a $dname 1 E-mail: rokscripter@terra.es $crlf
  .did -a $dname 1 Web: Www.MainCenter.Ya.St $crlf
  .did -a $dname 1 $crlf
  .did -a $dname 1 Queda totalmente prohibida la copia del trabajo $crlf
  .did -a $dname 1 o modificar el codigo. $crlf
  .did -a $dname 1 El autor no se hace responsable de los daños $crlf
  .did -a $dname 1 que pueda causar el usuario o addon. $crlf
}
dialog rokftp.atributos {
  Title "Cambiar los atributos del archivo"
  Size -1 -1 300 230
  TEXT "Seleccione los nuevos atributos para el archivo:" 1, 10 10 300 20
  TEXT "" 2, 10 25 300 20
  BOX "Permisos de propietario" 3, 10 45 280 40
  Check "Leer" 4, 20 60 40 20
  Check "Escribir" 5, 120 60 50 20
  Check "Ejecutar" 6, 230 60 55 20
  BOX "Permisos de grupo" 7, 10 85 280 40
  Check "Leer" 8, 20 100 40 20
  Check "Escribir" 9, 120 100 50 20
  Check "Ejecutar" 10, 230 100 55 20
  BOX "Permisos públicos" 11, 10 125 280 40
  Check "Leer" 12, 20 140 40 20
  Check "Escribir" 13, 120 140 50 20
  Check "Ejecutar" 14, 230 140 55 20
  TEXT "Valor numérico:" 15, 10 170 100 20
  EDIT "" 16, 90 168 100 20,read,center
  Button "Cancelar" 17, 10 200 120 20
  Button "Aceptar" 18, 140 200 120 20
}
on *:dialog:rokftp.atributos:*:*:{
  if ($devent == close) { unset %rokftp.atribut* }
  if ($devent == init) {
    did -ra $dname 2 %rokftp.atribut1 | if (%rokftp.atributctcpcar) { dialog -t $dname Cambiar los atributos del directorio | did -ra $dname 1 Seleccione los nuevos atributos para el directorio: }
    if (r isin %rokftp.atributppr) { set %rokftp.atributttttt1 o | inc %rokftp.atributtt1 4 | did -ck $dname 4 }
    if (w isin %rokftp.atributppr) { set %rokftp.atributttttt2 o | inc %rokftp.atributtt1 2 | did -ck $dname 5 }
    if (x isin %rokftp.atributppr) { set %rokftp.atributttttt3 o | inc %rokftp.atributtt1 1 | did -ck $dname 6 }
    if (r isin %rokftp.atributpgr) { set %rokftp.atributttttt4 o | inc %rokftp.atributtt2 4 | did -ck $dname 8 }
    if (w isin %rokftp.atributpgr) { set %rokftp.atributttttt5 o | inc %rokftp.atributtt2 2 | did -ck $dname 9 }
    if (x isin %rokftp.atributpgr) { set %rokftp.atributttttt6 o | inc %rokftp.atributtt2 1 | did -ck $dname 10 }
    if (r isin %rokftp.atributppu) { set %rokftp.atributttttt7 o | inc %rokftp.atributtt3 4 | did -ck $dname 12 }
    if (w isin %rokftp.atributppu) { set %rokftp.atributttttt8 o | inc %rokftp.atributtt3 2 | did -ck $dname 13 }
    if (x isin %rokftp.atributppu) { set %rokftp.atributttttt9 o | inc %rokftp.atributtt3 1 | did -ck $dname 14 }
    did -ra $dname 16 $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0)
  }
  if ($devent == sclick) {
    if ($did == 18) { rokftp.sockw SITE CHMOD $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0) %rokftp.atribut1 | unset %rokftp.atribut* | dialog -x $dname $dname | rokftp.cwd }
    if ($did == 14) {
      if (%rokftp.atributttttt9) { unset %rokftp.atributttttt9 | dec %rokftp.atributtt3 1 }
      else { set %rokftp.atributttttt9 o | inc %rokftp.atributtt3 1 }
      did -ra $dname 16 $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0)
    }
    if ($did == 13) {
      if (%rokftp.atributttttt8) { unset %rokftp.atributttttt8 | dec %rokftp.atributtt3 2 }
      else { set %rokftp.atributttttt8 o | inc %rokftp.atributtt3 2 }
      did -ra $dname 16 $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0)
    }
    if ($did == 12) {
      if (%rokftp.atributttttt7) { unset %rokftp.atributttttt7 | dec %rokftp.atributtt3 4 }
      else { set %rokftp.atributttttt7 o | inc %rokftp.atributtt3 4 }
      did -ra $dname 16 $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0)
    }
    if ($did == 10) {
      if (%rokftp.atributttttt6) { unset %rokftp.atributttttt6 | dec %rokftp.atributtt2 1 }
      else { set %rokftp.atributttttt6 o | inc %rokftp.atributtt2 1 }
      did -ra $dname 16 $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0)
    }
    if ($did == 9) {
      if (%rokftp.atributttttt5) { unset %rokftp.atributttttt5 | dec %rokftp.atributtt2 2 }
      else { set %rokftp.atributttttt5 o | inc %rokftp.atributtt2 2 }
      did -ra $dname 16 $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0)
    }
    if ($did == 8) {
      if (%rokftp.atributttttt4) { unset %rokftp.atributttttt4 | dec %rokftp.atributtt2 4 }
      else { set %rokftp.atributttttt4 o | inc %rokftp.atributtt2 4 }
      did -ra $dname 16 $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0)
    }
    if ($did == 6) {
      if (%rokftp.atributttttt3) { unset %rokftp.atributttttt3 | dec %rokftp.atributtt1 1 }
      else { set %rokftp.atributttttt3 o | inc %rokftp.atributtt1 1 }
      did -ra $dname 16 $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0)
    }
    if ($did == 5) {
      if (%rokftp.atributttttt2) { unset %rokftp.atributttttt2 | dec %rokftp.atributtt1 2 }
      else { set %rokftp.atributttttt2 o | inc %rokftp.atributtt1 2 }
      did -ra $dname 16 $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0)
    }
    if ($did == 4) {
      if (%rokftp.atributttttt1) { unset %rokftp.atributttttt1 | dec %rokftp.atributtt1 4 }
      else { set %rokftp.atributttttt1 o | inc %rokftp.atributtt1 4 }
      did -ra $dname 16 $iif(%rokftp.atributtt1,%rokftp.atributtt1,0) $+ $iif(%rokftp.atributtt2,%rokftp.atributtt2,0) $+ $iif(%rokftp.atributtt3,%rokftp.atributtt3,0)
    }
    if ($did == 17) { unset %rokftp.atribut* | dialog -x $dname $dname }
} }
alias rokftp.atributos { unset %rokftp.atributtt* | if (%rokftp.atribut1) && (!$dialog(rokftp.atributos)) { dialog -md rokftp.atributos rokftp.atributos } }
dialog rokftp.exists {
  Title "[MC FTP v1.1] El archivo ya existe!"
  Size -1 -1 400 150
  TEXT "El archivo de destino ya existe. Elija una opción:" 1, 20 10 250 20
  TEXT "Archivo origen:" 2, 20 30 100 20
  EDIT "" 3, 100 28 280 20,read,center,autohs
  TEXT "" 4, 20 50 380 20
  TEXT "Archivo destino:" 5, 20 70 100 20
  EDIT "" 6, 100 68 280 20,read,center,autohs
  TEXT "" 7, 20 90 380 20
  Button "Sobreescribir" 8, 10 120 100 20
  Button "Renombrar" 9, 110 120 100 20
  Button "Cancelar" 10, 210 120 100 20
}
on *:dialog:rokftp.exists:*:*:{
  if ($devent == close) { unset %rokftp.temexists1 %rokftp.temexists2 %rokftp.temexists3 }
  if ($devent == init) {
    if (!$dialog(rokftp)) || (!%rokftp.temexists1) || (!%rokftp.temexists2) || (!%rokftp.temexists3) { dialog -x $dname $dname }
    else {
      did -ra $dname 3 $replace($remove($mid($gettok(%rokftp.temexists1,1,34),1,-1) $+ $gettok(%rokftp.temexists1,2,34),"),+%,$chr(32))
      did -ra $dname 4 $remove($gettok(%rokftp.temexists1,3-,34),")
      did -ra $dname 6 $replace($remove($mid($gettok(%rokftp.temexists2,1,34),1,-1) $+ $gettok(%rokftp.temexists2,2,34),"),+%,$chr(32))
      did -ra $dname 7 $remove($gettok(%rokftp.temexists2,3-,34),")
  } }
  if ($devent == sclick) {
    if ($did == 9) {
      var %rokftp.existsn = $replace($input(Escribe el nuevo nombre para $replace($gettok($gettok(%rokftp.temexists3,2,32),$gettok($gettok(%rokftp.temexists3,2,32),0,92),92),+%,$chr(32)) $+ ,eq,rokftp,$null),$chr(32),+%)
      var %rokftp.exists = $mid($gettok(%rokftp.temexists3,2,32),1,$calc($len($gettok(%rokftp.temexists3,2,32)) - $len($gettok($gettok(%rokftp.temexists3,2,32),$gettok($gettok(%rokftp.temexists3,2,32),0,92),92)))) $+ %rokftp.existsn $gettok(%rokftp.temexists3,3-,32)
      if ($rokftp.existsc1($replace(%rokftp.existsn,+%,$chr(32))) != $null) { rokftp.men Error, Escoja otro nombre para el archivo. | halt }
      hadd $gettok(%rokftp.temexists3,1,32) %rokftp.exists | rokftp.csb | unset %rokftp.temexists1 %rokftp.temexists2 %rokftp.temexists3 | dialog -x $dname $dname
    }
    if ($did == 8) { hadd %rokftp.temexists3 | rokftp.csb | unset %rokftp.temexists1 %rokftp.temexists2 %rokftp.temexists3 | dialog -x $dname $dname }
    if ($did == 10) { unset %rokftp.temexists1 %rokftp.temexists2 %rokftp.temexists3 | dialog -x $dname $dname }
} }
dialog rokftp.exists2 {
  Title "[MC FTP v1.1] El archivo ya existe!"
  Size -1 -1 400 150
  TEXT "El archivo de destino ya existe. Elija una opción:" 1, 20 10 250 20
  TEXT "Archivo origen:" 2, 20 30 100 20
  EDIT "" 3, 100 28 280 20,read,center,autohs
  TEXT "" 4, 20 50 380 20
  TEXT "Archivo destino:" 5, 20 70 100 20
  EDIT "" 6, 100 68 280 20,read,center,autohs
  TEXT "" 7, 20 90 380 20
  Button "Sobreescribir" 8, 10 120 100 20
  Button "Renombrar" 9, 110 120 100 20
  Button "Cancelar" 10, 210 120 100 20
}
on *:dialog:rokftp.exists2:*:*:{
  if ($devent == close) { unset %rokftp.temexistss1 %rokftp.temexistss2 %rokftp.temexistss3 }
  if ($devent == init) {
    if (!$dialog(rokftp)) || (!%rokftp.temexistss1) || (!%rokftp.temexistss2) || (!%rokftp.temexistss3) { dialog -x $dname $dname }
    else {
      did -ra $dname 3 $replace($gettok(%rokftp.temexistss1,1,32) $+ $gettok(%rokftp.temexistss1,2,34),+%,$chr(32))
      did -ra $dname 4 $remove($gettok(%rokftp.temexistss1,3-,34),")
      did -ra $dname 6 $replace($gettok(%rokftp.temexistss3,4,32) $+ $gettok(%rokftp.temexistss1,2,34),+%,$chr(32))
      did -ra $dname 7 $remove($gettok(%rokftp.temexistss2,3-,34),")
  } }
  if ($devent == sclick) {
    if ($did == 9) {
      var %rokftp.existsn = $replace($input(Escribe el nuevo nombre para $replace($gettok(%rokftp.temexistss1,2,34),+%,$chr(32)) $+ ?,eq,rokftp,$null),$chr(32),+%)
      if ($rokftp.existsc2($replace(%rokftp.existsn,+%,$chr(32))) != $null) { rokftp.men Error, Escoja otro nombre para el archivo. | halt }
      hadd $gettok(%rokftp.temexistss3,1-4,32) $replace(%rokftp.existsn,$chr(32),+%) | rokftp.csb | unset %rokftp.temexistss1 %rokftp.temexistss2 %rokftp.temexistss3 | dialog -x $dname $dname
    }
    if ($did == 8) { if ($exists(" $+ $replace($gettok(%rokftp.temexistss3,4,32) $+ $gettok(%rokftp.temexistss3,5,32),+%,$chr(32)) $+ ") == $true) { .remove " $+ $replace($gettok(%rokftp.temexistss3,4,32) $+ $gettok(%rokftp.temexistss3,5,32),+%,$chr(32)) $+ " } | hadd %rokftp.temexistss3 | rokftp.csb | unset %rokftp.temexistss1 %rokftp.temexistss2 %rokftp.temexistss3 | dialog -x $dname $dname }
    if ($did == 10) { unset %rokftp.temexistss1 %rokftp.temexistss2 %rokftp.temexistss3 | dialog -x $dname $dname }
} }
alias rokftp { if (!$dialog(rokftp)) { dialog -md rokftp rokftp } }
Dialog rokFTP {
  Title "[Cliente MC FTP v1.1] - By RoK - Www.MainCenter.ya.st"
  Size -1 -1 820 710
  TEXT "Servidor" 1, 10 20 100 20
  combo 2, 60 18 170 100,autohs,center,edit,drop
  TEXT "Usuario" 3, 240 20 100 20
  EDIT "" 4, 290 18 120 20,autohs,center
  TEXT "Clave" 5, 420 20 90 20
  EDIT "" 6, 460 18 100 20,autohs,center,pass
  TEXT "Puerto" 7, 570 20 90 20
  EDIT "" 8, 610 18 50 20,autohs,center
  BUTTON "Conectar" 9, 710 18 100 20
  EDIT "" 10, 10 50 800 100,read,autohs,multi,autovs,vsbar,hsbar
  BOX "Sitio local" 11, 10 160 395 400
  TEXT "Dirección:" 12, 20 180 100 20
  EDIT "" 13, 70 178 250 20,read,center,autohs
  BUTTON "Examinar" 14, 322 179 80 20
  Button "Eliminar archivo" 33, 20 530 100 20
  Button "Subir archivo" 16, 125 530 100 20
  Button "Refrescar" 35, 315 530 85 20
  Button "Ocultar cola" 36, 160 355 100 20
  BOX "Sitio remoto" 17, 410 160 400 400
  Button "Eliminar archivo" 26, 420 530 100 20
  Button "Crear directorio" 27, 660 355 140 20
  Button "Atributos" 24, 630 530 85 20
  Button "Descargar archivo" 22, 525 530 100 20
  TEXT "Dirección:" 23, 420 180 100 20
  EDIT "" 28, 472 178 328 20,read,center,autohs
  BOX "Archivos en cola" 29, 10 560 800 145
  Button "Cancelar todo" 31, 20 680 200 20
  Button "Cancelar selección" 32, 220 680 200 20
  Button "Refrescar" 37, 720 530 80 20
  Button "Eliminar directorio" 43, 420 355 140 20
  Button "Crear directorio" 44, 260 355 140 20
  Button "Eliminar directorio" 45, 20 355 140 20
  Button "Abrir archivo" 46, 230 530 80 20
  Button "Atributos" 47, 560 355 100 20
  BUTTON "X" 48, 670 18 30 20
  Button "Acerca de.." 49, 420 680 170 20
  Button "Cerrar" 50, 590 680 210 20
}
alias xdid {
  if ( $isid ) return $dcx( _xdid, $1 $2 $prop $3- )
  dcx xdid $2 $3 $1 $4-
}
alias xdialog {
  if ( $isid ) return $dcx( _xdialog, $1 $prop $2- )
  dcx xdialog $2 $1 $3-
}
alias dcx {
  if ($isid) return $dll($shortfn($scriptdirdcx.dll),$1,$2-)
  else dll $shortfn($scriptdirdcx.dll) $1 $2-
}
alias rokftp.ctpcar { hfree -w rokftp.ctpcar | hmake rokftp.ctpcar }
alias dcxtv1 {
  xdid -r rokftp 40
  xdid -a rokftp 40 $dcxtab(-1,+ebcu 1 2 1 1 0 255 2, tooltip)
  xdid -a rokftp 40 $dcxtab(-1,+sbcu 1 2 1 2 0 $rgb(0,0,255) 1,Sitio local)
  xdid -a rokftp 40 $dcxtab(1 -1,+ 1 0 0 0 0 0 Item %rokftp.sdir,Sitio local)
  if ($gettok(%rokftp.sdir,0,92) > 1) { xdid -a rokftp 40 $dcxtab(-1 -1,+ 1 0 0 0 0 0 Item "..",Atras) }
  %a = 1 | while ($finddir(%rokftp.sdir,*,0,0) >= %a) { xdid -a rokftp 40 $dcxtab(-1 -1,+ 1 0 0 0 0 0 Item $remove($finddir(%rokftp.sdir,*,%a,0),%rokftp.sdir,\)) | inc %a }
  xdid -t rokftp 40 +a root
}
alias dcxtv2 {
  xdid -r rokftp 41
  xdid -a rokftp 41 $dcxtab(-1,+ebcu 1 2 1 1 0 255 2,Sitio remoto)
  xdid -a rokftp 41 $dcxtab(-1,+sbcu 1 2 1 2 0 $rgb(0,0,255) 1,Sitio remoto)
  xdid -a rokftp 41 $dcxtab(1 -1,+ 1 0 0 0 0 0 Item $replace(%rokftp.pwd,+%,$chr(32)))
}
alias dcxtab {
  var %i = 1, %tab
  while (%i <= $0) {
    if ($eval($+($,%i),2) != $null) { %tab = $instok(%tab,$eval($+($,%i),2),$calc($numtok(%tab,9) + 1),9) }
    inc %i
  }
  return %tab
}
alias rokdcxclick {
  if ($3 == 40) && (labelend == $2) {
    if ($4) && (".." != $xdid(rokftp,40).seltext) { %rokftp.tem = $xdid(rokftp,40).seltext | if (\ !isin %rokftp.tem) { %rokftp.renom = $4- | .timerrokftpsdirrename -m 1 50 .rename $shortfn(%rokftp.sdir $+ %rokftp.tem) " $+ $shortfn(%rokftp.sdir) $+ %rokftp.renom $+ " } }
    .timerrokftpsdir -m 1 100 dcxtv1
  }
  if ($3 == 21) && (labelend == $2) { if ($4) { %rokftp.tem = $xdid(rokftp,21,0).seltext | %rokftp.renom = $4- | rokftp.sockw RNFR %rokftp.tem | rokftp.sockw RNTO %rokftp.renom } | rokftp.cwd  }
  if ($3 == 15) && (labelend == $2) { if ($4) { %rokftp.tem = $xdid(rokftp,15,0).seltext | %rokftp.renom = $4- | .rename $shortfn(%rokftp.sdir $+ %rokftp.tem) " $+ $shortfn(%rokftp.sdir) $+ %rokftp.renom $+ " } | rokftp.sdir n }
  if ($3 == 41) && (labelend == $2) { if ($4) { rokftp.sockw RNFR $xdid(rokftp,41).seltext | rokftp.sockw RNTO $4- } | rokftp.cwd }
  if ($2 == dclick) {
    if ($sock(rokftp).status == active) {
      if ($3 == 15) && ($xdid(rokftp,15,0).seltext) {
        var %rokftp.tem = $gettok($xdid(rokftp,15,2).seltext,$gettok($xdid(rokftp,15,2).seltext,0,32),32)
        var %ftp.tempp = $shortfn(%rokftp.sdir) $+ $replace($xdid(rokftp,15,0).seltext,$chr(32),+%)
        if ($hget(rokftp.sub,%ftp.tempp)) { rokftp.men Error, Ya esta en cola el archivo $replace(%ftp.tempp,+%,$chr(32)) => | return }
        if ($rokftp.existsc1($xdid(rokftp,15,0).seltext) != $null) {
          set %rokftp.temexists2 $iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) " $+ $xdid(rokftp,15,0).seltext $+ " Tamaño $rokftp.existsc1($xdid(rokftp,15,0).seltext)
          set %rokftp.temexists1 %rokftp.sdir " $+ $xdid(rokftp,15,0).seltext $+ " Tamaño $file($shortfn(%rokftp.sdir $+ $xdid(rokftp,15,0).seltext)).size
          set %rokftp.temexists3 rokftp.sub %ftp.tempp $remove($xdid(rokftp,15,1).seltext,") $iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) $shortfn(%rokftp.sdir $+ $xdid(rokftp,15,0).seltext)
          if ($dialog(rokftp.exists)) { rokftp.men Error, Intente añadir el archivo a la cola cuando cierre la ventana de acciónes.. | halt }
          dialog -md rokftp.exists rokftp.exists | halt
        }
        hadd rokftp.sub %ftp.tempp $remove($xdid(rokftp,15,1).seltext,") $iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) $shortfn(%rokftp.sdir $+ $xdid(rokftp,15,0).seltext) | rokftp.csb
      }
      if ($3 == 21) && ($xdid(rokftp,21,0).seltext) {
        %rokftp.tem = $xdid(rokftp,21,2).seltext | var %ftp.tempp = $replace($iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) $+ $xdid(rokftp,21,0).seltext,$chr(32),+%)
        if (%ftp.tempp != /) {
          if ($hget(rokftp.des,%ftp.tempp)) { rokftp.men Error, Ya esta en cola el archivo $replace(%ftp.tempp,+%,$chr(32)) <= | return }
          if ($rokftp.existsc2($xdid(rokftp,21,0).seltext) != $null) {
            set %rokftp.temexistss1 $iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) " $+ $xdid(rokftp,21,0).seltext $+ " Tamaño $xdid(rokftp,21,1).seltext $xdid(rokftp,21,3).seltext
            set %rokftp.temexistss2 %rokftp.sdir " $+ $xdid(rokftp,21,0).seltext $+ " Tamaño $rokftp.existsc2($xdid(rokftp,21,0).seltext)
            set %rokftp.temexistss3 rokftp.des %ftp.tempp $xdid(rokftp,21,1).seltext $shortfn(%rokftp.sdir) $replace($xdid(rokftp,21,0).seltext,$chr(32),+%)
            if ($dialog(rokftp.exists2)) { rokftp.men Error, Intente añadir el archivo a la cola cuando cierre la ventana de acciónes.. | halt }
            dialog -md rokftp.exists2 rokftp.exists2 | halt
          }
          hadd rokftp.des %ftp.tempp $xdid(rokftp,21,1).seltext $shortfn(%rokftp.sdir) $replace($xdid(rokftp,21,0).seltext,$chr(32),+%) | rokftp.csb
    } } }
    if ($3 == 41) && ($xdid(rokftp,41).seltext) { rokftp.sockw CWD $xdid(rokftp,41).seltext | rokftp.cwd }
    if ($3 == 40) && ($xdid(rokftp,40).seltext) {
      if (%rokftp.sdir === $xdid(rokftp,40).seltext) || (\ isin $xdid(rokftp,40).seltext) { rokftp.sdir | return }
      if (".." == $xdid(rokftp,40).seltext) { set %rokftp.sdir $left(%rokftp.sdir,$calc($len(%rokftp.sdir) - $calc($len($gettok(%rokftp.sdir,$gettok(%rokftp.sdir,0,92),92)) + 1))) }
      else { set %rokftp.sdir %rokftp.sdir $+ $xdid(rokftp,40).seltext $+ \ } | rokftp.sdir
} } }
alias rokftp.ctabhisto { hfree -w rokftp.ctabhisto | hmake rokftp.ctabhisto | if ($exists(rokftp.his) == $true) { hload rokftp.ctabhisto rokftp.his } }
alias rokftp.ctabhisto.load {
  if ($dialog(rokftp)) {
    did -r $dname 2 | did -r $dname 4 | did -r $dname 6 | did -r $dname 8
    if ($hget(rokftp.ctabhisto,0).item > 0) { %rokftp.temp32 = 1 | while ($hget(rokftp.ctabhisto,%rokftp.temp32).item) { did -a $dname 2 $decode($hget(rokftp.ctabhisto,%rokftp.temp32).item,m) | inc %rokftp.temp32 } }
} }
alias rokftp.ctabhisto.hadd { if ($4) { hadd rokftp.ctabhisto $1- | rokftp.ctabhisto.save } }
alias rokftp.ctabhisto.save { hsave -o rokftp.ctabhisto rokftp.his }
alias rokftp.ctabhisto.del { if ($1) { hdel rokftp.ctabhisto $1 | rokftp.ctabhisto.save } }
alias rokftp.cierrato {
  sockclose rokftp* | unset %ftprok.psvretr %rokftp.s | .fclose FTPRoK.d.*
  if ($dialog(rokftp)) { dialog -x rokftp rokftp }
  if ($dialog(rokftp.exists)) { dialog -x rokftp.exists rokftp.exists }
  if ($dialog(rokftp.exists2)) { dialog -x rokftp.exists2 rokftp.exists2 }
  if ($dialog(rokftp.atributos)) { dialog -x rokftp.atributos rokftp.atributos }
}
on *:dialog:rokftp:*:*:{
  if ($devent == close) { rokftp.cierrato }
  if ($devent == init) {
    dcx Mark $dname rokdcxclick
    xdialog -c rokftp 41 treeview 420 200 380 150 hasbuttons haslines fullrow linesatroot showsel checkbox editlabel
    xdialog -c rokftp 40 treeview 20 200 380 150 hasbuttons haslines fullrow linesatroot showsel checkbox editlabel
    xdialog -c rokftp 30 listview 20 580 780 100 report showsel fullrow tooltip
    xdid -t rokftp 30 +l 10 180 Carpeta / Archivo local $chr(9) +c 1 80 Dirección $chr(9) +c 10 180 Carpeta / Archivo remoto $chr(9) +c 1 70 Tamaño $chr(9) +c 1 80 Porcentaje $chr(9) +c 1 90 Velocidad $chr(9) +c 1 96 Tiempo Restante
    xdialog -c rokftp 15 listview 20 380 380 150 report showsel fullrow editlabel tooltip flatsb
    xdid -t rokftp 15 +l 10 160 Nombre $chr(9) +c 1 98 Tamaño $chr(9) +c 10 115 Tipo de archivo $chr(9) +c 10 150 Ultima modificación
    xdialog -c rokftp 21 listview 420 380 380 150 report showsel fullrow editlabel tooltip flatsb
    xdid -t rokftp 21 +l 10 160 Nombre $chr(9) +c 1 98 Tamaño $chr(9) +c 10 115 Tipo de archivo $chr(9) +c 10 150 Ultima modificación $chr(9) +c 10 100 Permisos $chr(9) +c 10 150 Propietario / Grupo
    if (!%rokftp.sdir) { set %rokftp.sdir $mircdir }
    unset %rokftp.temexists1 %rokftp.temexists2 %rokftp.temexists3
    unset %rokftp.temexistss1 %rokftp.temexistss2 %rokftp.temexistss3
    unset %ftprok.psvretr %rokftp.s
    .fclose FTPRoK.d.* | sockclose rokftp* | unset %ftprok.psvretr %rokftp.s | rokftp.ctd0 | rokftp.ctabhisto | rokftp.ctabhisto.load
    did -ra $dname 13 %rokftp.sdir
    rokftp.ctpcar | rokftp.sdir
  }
  if ($devent == EDIT) {
    if ($did == 2) && ($hget(rokftp.ctabhisto,$encode($did(2),m))) {
      did -ra $dname 4 $decode($gettok($hget(rokftp.ctabhisto,$encode($did(2),m)),1,32),m)
      did -ra $dname 6 $decode($gettok($hget(rokftp.ctabhisto,$encode($did(2),m)),2,32),m)
      did -ra $dname 8 $decode($gettok($hget(rokftp.ctabhisto,$encode($did(2),m)),3,32),m)
  } }
  if ($devent == sclick) {
    if ($did == 49) { rokftp.acercade }
    if ($did == 50) { rokftp.cierrato }
    if ($did == 48) && ($hget(rokftp.ctabhisto,$encode($did(2),m))) { rokftp.ctabhisto.del $encode($did(2),m) | rokftp.ctabhisto.load }
    if ($did == 2) && ($hget(rokftp.ctabhisto,$encode($did(2),m))) {
      did -ra $dname 4 $decode($gettok($hget(rokftp.ctabhisto,$encode($did(2),m)),1,32),m)
      did -ra $dname 6 $decode($gettok($hget(rokftp.ctabhisto,$encode($did(2),m)),2,32),m)
      did -ra $dname 8 $decode($gettok($hget(rokftp.ctabhisto,$encode($did(2),m)),3,32),m)
    }
    if ($did == 36) {
      if (Ocultar isin $did(36)) { .did -ra $dname 36 Mostrar cola | dialog -s rokftp -1 -1 820 561 }
      else { .did -ra $dname 36 Ocultar cola | dialog -s rokftp -1 -1 820 710 }
    }
    if ($did == 46) && ($xdid(rokftp,15,0).seltext) { run " $+ $shortfn(%rokftp.sdir) $+ $xdid(rokftp,15,0).seltext $+ " }
    if ($did == 45) && ($xdid(rokftp,40).seltext) && ($xdid(rokftp,40,1).text != $xdid(rokftp,40).seltext) && ($xdid(rokftp,40).seltext != "..") && ($input(Seguro que deseas eliminar la carpeta $xdid(rokftp,40).seltext $+ ? (No se eliminara si la carpeta no esta vacia),yq,rokftp,$null) == $true) { .rmdir " $+ $shortfn(%rokftp.sdir) $+ $xdid(rokftp,40).seltext $+ " | dcxtv1 }
    if ($did == 44) { if ($input(Escribe el nombre de la nueva carpeta?,eq,rokftp,$null) != $null) { .mkdir " $+ $shortfn(%rokftp.sdir) $+ $ifmatch $+ " | dcxtv1 } }
    if ($did == 14) { set %rokftp.sdir $$sdir="Selecciona el directorio a explorar" | rokftp.sdir }
    if ($did == 9) && ($did(6)) && ($did(4)) && ($did(2)) { if ($did(8) !isnum) { did -ra $dname 8 21 } | rokftp.ctabhisto.hadd $encode($remove($did(2),$chr(32)),m) $encode($did(4),m) $encode($did(6),m) $encode($did(8),m) | set %rokftp.serv $remove($did(2),$chr(32)) | set %rokftp.port $did(8) | set %rokftp.userpass $did(6) | set %rokftp.user $did(4) | ftprok.conecta }
    if ($did == 33) { %rokftp.tem = $xdid(rokftp,15,0).seltext | if (%rokftp.tem) && ($input(Seguro que deseas eliminar el archivo %rokftp.tem $+ ?,yq,rokftp,$null) == $true) { .remove $shortfn(%rokftp.sdir $+ %rokftp.tem) | rokftp.sdir } }
    if ($did == 35) { did -ra $dname 13 %rokftp.sdir | rokftp.sdir }
    if ($did == 32) {
      if (> isin $xdid(rokftp,30,1).seltext) {
        %rokftp.tempxitem = $replace($xdid(rokftp,30,0).seltext,$chr(32),+%)
        xdid -d rokftp 30 $rokftp.xitem(.sub,%rokftp.tempxitem) | if (%rokftp.tempxitem == %rokftp.s) { sockclose rokftp4 | sockclose rokftp4.1 | unset %rokftp.s }  
        hdel rokftp.sub %rokftp.tempxitem | rokftp.csb | rokftp.cwd
      }
      if (< isin $xdid(rokftp,30,1).seltext) {
        %rokftp.tempxitem = $replace($xdid(rokftp,30,2).seltext,$chr(32),+%) | xdid -d rokftp 30 $rokftp.xitem(.des,%rokftp.tempxitem) | hdel rokftp.des %rokftp.tempxitem
        if (%rokftp.tempxitem == %ftprok.psvretr) { sockclose rokftp3 | sockclose rokftp3.1 | .fclose FTPRoK.d.* | unset %ftprok.psvretr %ftprok.psvretr.n %ftprok.psvretr.dd }
        rokftp.csb | rokftp.sdir
    } }
    if ($sock(rokftp).status == active) {
      if ($did == 24) && ($xdid(rokftp,21,0).seltext) && (!$dialog(rokftp.atributos)) { unset %rokftp.atribut* | set %rokftp.atribut1 $xdid(rokftp,21,0).seltext | set %rokftp.atributppr $mid($xdid(rokftp,21,4).seltext,2,3) | set %rokftp.atributpgr $mid($xdid(rokftp,21,4).seltext,5,3) | set %rokftp.atributppu $mid($xdid(rokftp,21,4).seltext,8,3) | rokftp.atributos }
      if ($did == 47) && ($xdid(rokftp,41).seltext) && (!$dialog(rokftp.atributos)) {
        var %rokftp.ctcpcar $hget(rokftp.ctpcar,$remove($xdid(rokftp,41).seltext,$chr(32)))
        if (%rokftp.ctcpcar) {
          unset %rokftp.atribut* | set %rokftp.atributctcpcar o | set %rokftp.atribut1 $xdid(rokftp,41).seltext | set %rokftp.atributppr $mid(%rokftp.ctcpcar,2,3) | set %rokftp.atributpgr $mid(%rokftp.ctcpcar,5,3) | set %rokftp.atributppu $mid(%rokftp.ctcpcar,8,3)
          rokftp.atributos
      } }
      if ($did == 43) && ($xdid(rokftp,41).seltext) && ($xdid(rokftp,41,1).text != $xdid(rokftp,41).seltext) && ($input(Seguro que deseas eliminar la carpeta $xdid(rokftp,41).seltext $+ ? (No se eliminara si la carpeta no esta vacia),yq,rokftp,$null) == $true) { rokftp.sockw RMD $iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) $+ $xdid(rokftp,41).seltext | rokftp.cwd }
      if ($did == 31) {
        if ($hget(rokftp.sub,0).item > 0) || ($hget(rokftp.des,0).item > 0) { var %rokftp.tempr o }
        sockclose rokftp3 | sockclose rokftp3.1 | sockclose rokftp4 | sockclose rokftp4.1 | rokftp.ctd0
        unset %rokftp.temexists1 %rokftp.temexists2 %rokftp.temexists3 | unset %rokftp.temexistss1 %rokftp.temexistss2 %rokftp.temexistss3
        .fclose FTPRoK.d.* | xdid -r rokftp 30 | unset %ftprok.psvretr %rokftp.s %ftprok.psvretr.n %ftprok.psvretr.dd | rokftp.ctd0
        if (%rokftp.tempr) { rokftp.cwd | rokftp.sdir }
      }
      if ($did == 37) { rokftp.cwd }
      if ($did == 27) { if ($input(Escribe el nombre de la nueva carpeta?,eq,rokftp,$null) != $null) { rokftp.sockw MKD $ifmatch | rokftp.cwd } }
      if ($did == 26) {
        %rokftp.tem = $xdid(rokftp,21,0).seltext
        if (%rokftp.tem != $null) && ($input(Seguro que deseas eliminar el archivo %rokftp.tem $+ ?,yq,rokftp,$null) == $true) { rokftp.sockw DELE %rokftp.tem | rokftp.cwd }
      }
      if ($did == 16) && ($xdid(rokftp,15,0).seltext) {
        var %rokftp.tem = $gettok($xdid(rokftp,15,2).seltext,$gettok($xdid(rokftp,15,2).seltext,0,32),32)
        var %ftp.tempp = $shortfn(%rokftp.sdir) $+ $replace($xdid(rokftp,15,0).seltext,$chr(32),+%)
        if ($hget(rokftp.sub,%ftp.tempp)) { rokftp.men Error, Ya esta en cola el archivo $replace(%ftp.tempp,+%,$chr(32)) => | return }
        if ($rokftp.existsc1($xdid(rokftp,15,0).seltext) != $null) {
          set %rokftp.temexists2 $iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) " $+ $xdid(rokftp,15,0).seltext $+ " Tamaño $rokftp.existsc1($xdid(rokftp,15,0).seltext)
          set %rokftp.temexists1 %rokftp.sdir " $+ $xdid(rokftp,15,0).seltext $+ " Tamaño $file($shortfn(%rokftp.sdir $+ $xdid(rokftp,15,0).seltext)).size
          set %rokftp.temexists3 rokftp.sub %ftp.tempp $remove($xdid(rokftp,15,1).seltext,") $iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) $shortfn(%rokftp.sdir $+ $xdid(rokftp,15,0).seltext)
          if ($dialog(rokftp.exists)) { rokftp.men Error, Intente añadir el archivo a la cola cuando cierre la ventana de acciónes.. | halt }
          dialog -md rokftp.exists rokftp.exists | halt
        }
        hadd rokftp.sub %ftp.tempp $remove($xdid(rokftp,15,1).seltext,") $iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) $shortfn(%rokftp.sdir $+ $xdid(rokftp,15,0).seltext) | rokftp.csb
      }
      if ($did == 22) && ($xdid(rokftp,21,0).seltext) {
        %rokftp.tem = $xdid(rokftp,21,2).seltext
        var %ftp.tempp = $replace($iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) $+ $xdid(rokftp,21,0).seltext,$chr(32),+%)
        if (%ftp.tempp != /) {
          if ($hget(rokftp.des,%ftp.tempp)) { rokftp.men Error, Ya esta en cola el archivo $replace(%ftp.tempp,+%,$chr(32)) <= | return }
          if ($rokftp.existsc2($xdid(rokftp,21,0).seltext) != $null) {
            set %rokftp.temexistss1 $iif(%rokftp.pwd != /,%rokftp.pwd $+ /,/) " $+ $xdid(rokftp,21,0).seltext $+ " Tamaño $xdid(rokftp,21,1).seltext $xdid(rokftp,21,3).seltext
            set %rokftp.temexistss2 %rokftp.sdir " $+ $xdid(rokftp,21,0).seltext $+ " Tamaño $rokftp.existsc2($xdid(rokftp,21,0).seltext)
            set %rokftp.temexistss3 rokftp.des %ftp.tempp $xdid(rokftp,21,1).seltext $shortfn(%rokftp.sdir) $replace($xdid(rokftp,21,0).seltext,$chr(32),+%)
            if ($dialog(rokftp.exists2)) { rokftp.men Error, Intente añadir el archivo a la cola cuando cierre la ventana de acciónes.. | halt }
            dialog -md rokftp.exists2 rokftp.exists2 | halt
          }
          hadd rokftp.des %ftp.tempp $xdid(rokftp,21,1).seltext $shortfn(%rokftp.sdir) $replace($xdid(rokftp,21,0).seltext,$chr(32),+%) | rokftp.csb
} } } } }
alias ftprok.conecta {
  if (!%rokftp.serv) || (!%rokftp.user) || (!%rokftp.port) { rokftp.men Error, Faltan datos para poder conectar! }
  else { sockclose rokftp | rokftp.men Conectando con %rokftp.serv $+ : $+ %rokftp.port $+ ... | sockopen rokftp %rokftp.serv %rokftp.port }
}
Alias rokftp.sdir {
  if ($1 != n) { dcxtv1 }
  did -ra rokftp 13 %rokftp.sdir
  xdid -r rokftp 15
  %rokftp.direct = 1
  while ($findfile(%rokftp.sdir,*.*,%rokftp.direct,1)) {
    xdid -a rokftp 15 1 0 +k 1 0 0 0 -1 $rgb(255,255,255) $nopath($findfile(%rokftp.sdir,*.*,%rokftp.direct,1)) $chr(9) 0 0 $file($findfile(%rokftp.sdir,*.*,%rokftp.direct,1)).size $chr(9) 0 0 $gettok($nopath($findfile(%rokftp.sdir,*.*,%rokftp.direct,1)),$gettok($nopath($findfile(%rokftp.sdir,*.*,%rokftp.direct,1)),0,46),46) $chr(9) 0 0 $replace($asctime($file($findfile(%rokftp.sdir,*.*,%rokftp.direct,1)).mtime),mon,Lunes,tue,Martes,wed,Miércoles,thu,Jueves,fri,Viernes,sat,Sábado,sun,Domingo)
    inc %rokftp.direct
} }
alias rokftp.men { did -a rokftp 10 < $+ $time $+ > $1- $crlf }
alias rokftp.sockw { rokftp.acsks | rokftp.men Comando: $iif($1 == PASS,$1 $str(*,$len($2-)),$1-) | if ($sock(rokftp).status == active) { sockwrite -n RoKFTP $1- } }
alias rokftp.acsks { if ($sock(rokftp).status != active) { xdid -r rokftp 21 | rokftp.ctd0 } }
on *:sockopen:RoKFTP:{ if ($sockerr > 0) { rokftp.men Error, Fallo al intentar establecer conexión con el servidor! } | else { rokftp.men OK, Conexión establecida con $sock($sockname,1).ip $+ : $+ $sock($sockname,1).port } }
on *:sockread:RoKFTP:{
  sockread %rokftp | tokenize 32 %rokftp | rokftp.men Respuesta: $1-
  if (220 == $1) { rokftp.sockw USER %rokftp.user }
  if (331 == $1) { rokftp.sockw PASS %rokftp.userpass }
  if (230 == $1) { rokftp.cwd }
  if (227 == $1) {
    var %a = $remove($replace($gettok($5,1-4,44),$chr(44),$chr(46)) $calc($gettok($5,-2,44) * 256 + $gettok($5,-1,44)),$chr(40))
    if (%ftprok.psv == list) { unset %ftprok.psv | xdid -r rokftp 21 | sockclose rokftp2 | sockopen rokftp2 %a }
  }
  if (257 == $1) { set %rokftp.pwd $replace($gettok($1-,2,34),$chr(32),+%) | did -ra rokftp 28 $gettok($1-,2,34) }
  if (530 == $1) { rokftp.men Error: Compruebe el usuario y contraseña para voler a intentarlo! | sockclose rokftp* }
}
on *:SOCKOPEN:RoKFTP4.1:{
  if ($sockerr > 0) { rokftp.men Error, Al intentar cargar el archivo. }
  else { bunset &rokftpbread | set %rokftp.svi 0 | set %rokftp.bytevelo 8192 | unset %ftprok.psvretr.subvel | rokftp.men Cargando archivo.. | sockwriterokftp4.1 }
}
on *:sockread:RoKFTP4.1:{ sockread %rokftp | tokenize 32 %rokftp | if ($1 == 553) { xdid -d rokftp 30 $rokftp.xitem(.sub,%rokftp.s) | hdel rokftp.sub %rokftp.s | unset %rokftp.s | sockclose $sockname | sockclose RoKFTP4 | rokftp.csb } }
on *:SOCKWRITE:RoKFTP4.1:{ sockwriterokftp4.1 }
alias sockwriterokftp4.1 {
  if ($file(%rokftp.s2).size > %rokftp.svi) { bunset &rokftpbread | bread %rokftp.s2 %rokftp.svi %rokftp.bytevelo &rokftpbread | sockwrite rokftp4.1 &rokftpbread | inc %rokftp.svi $bvar(&rokftpbread,0) }
  else { .timerrokftp.4.1.c 1 3 rokftp4.1.c }
}
alias rokftp4.1.c { xdid -d rokftp 30 $rokftp.xitem(.sub,%rokftp.s) | hdel rokftp.sub %rokftp.s | unset %rokftp.s %rokftp.s2 | sockclose RoKFTP4 | sockclose rokftp4.1 | rokftp.csb | rokftp.cwd }
on *:SOCKCLOSE:RoKFTP4.1:{ rokftp4.1.c }
on *:SOCKOPEN:RoKFTP4:{ if ($sockerr > 0) { rokftp.men Error, Al intentar cargar el archivo. } }
on *:sockread:RoKFTP4:{
  sockread %rokftp | tokenize 32 %rokftp | if (220 == $1) { sockwrite -n $sockname USER %rokftp.user } | if (331 == $1) { sockwrite -n $sockname PASS %rokftp.userpass }
  if (230 == $1) { sockwrite -n $sockname TYPE I | sockwrite -n $sockname PASV | sockwrite -n $sockname STOR $replace($gettok($hget(rokftp.sub,%rokftp.s),2,32),+%,$chr(32)) $+ $replace($gettok(%rokftp.s,$gettok(%rokftp.s,0,92),92),+%,$chr(32)) }
  if (227 == $1) { var %a = $remove($replace($gettok($5,1-4,44),$chr(44),$chr(46)) $calc($gettok($5,-2,44) * 256 + $gettok($5,-1,44)),$chr(40)) | sockclose rokftp4.1 | sockopen rokftp4.1 %a }
}
on *:SOCKCLOSE:RoKFTP4:{ xdid -d rokftp 30 $rokftp.xitem(.sub,%rokftp.s) | hdel rokftp.sub %rokftp.s | unset %rokftp.s | sockclose RoKFTP4.1 | sockclose $sockname | rokftp.csb }
on *:sockclose:RoKFTP:{ if ($dialog(rokftp)) { xdid -r rokftp 21 | did -ra rokftp 28 | xdid -r rokftp 41 } }
alias rokftp.cwd { set %ftprok.psv list | rokftp.sockw PWD | rokftp.sockw PASV | rokftp.sockw LIST }
on *:sockopen:RoKFTP2:{ rokftp.ctpcar | if ($sockerr > 0) { xdid -r rokftp 41 | xdid -r rokftp 21 | rokftp.men Error, Al intentar listar los archivos. } | else { xdid -r rokftp 21 | dcxtv2 | rokftp.men Listando archivos.. } }
on *:sockread:RoKFTP2:{
  sockread %rokftp2 | tokenize 32 %rokftp2
  if ($1 == 226) { sockclose $sockname }
  if ($mid($1,1,1) == -) { xdid -a rokftp 21 1 0 +k 1 0 0 0 -1 $rgb(255,255,255) $9- $chr(9) 0 0 $5 $chr(9) 0 0 $gettok($gettok($1-,$gettok($1-,0,32),32),$gettok($gettok($1-,$gettok($1-,0,32),32),0,46),46) $chr(9) 0 0 $6 $7 $8 $chr(9) 0 0 $1 $chr(9) 0 0 $3 $4 }
  if ($mid($1,1,1) == d) && ($gettok($1-,$gettok($1-,0,32),32)) {
    if ($gettok($1-,$gettok($1-,0,32),32) != .) {
      xdid -a rokftp 41 $dcxtab(-1 -1,+ 1 0 0 0 0 0 Item $9-)
      if ($9- != ..) { hadd rokftp.ctpcar $remove($9-,$chr(32)) $1 }
} } }
on *:sockclose:rokftp2:{ xdid -t rokftp 41 +a root }
on *:sockopen:RoKFTP3.1:{ if ($sockerr > 0) { xdid -d rokftp 30 $rokftp.xitem(.des,$replace(%ftprok.psvretr,$chr(32),+%)) | rokftp.men Error, Al intentar descargar el archivo. } | else { unset %ftprok.psvretr.des | .fopen -o FTPRoK.d. " $+ %ftprok.psvretr.dd $+ %ftprok.psvretr.n $+ " } }
on *:sockread:RoKFTP3.1:{ sockread &rokftp3 | .fwrite -b FTPRoK.d. &rokftp3 | inc %ftprok.psvretr.des $bvar(&rokftp3,0) }
on *:sockclose:RoKFTP3.1:{
  xdid -d rokftp 30 $rokftp.xitem(.des,$replace(%ftprok.psvretr,$chr(32),+%))
  if ($exists(" $+ %ftprok.psvretr.dd $+ %ftprok.psvretr.n $+ ") == $true) { .fclose FTPRoK.d.* | rokftp.men Archivo %ftprok.psvretr descargado. }
  else { rokftp.men Error al descargar %ftprok.psvretr }
  hdel rokftp.des $replace(%ftprok.psvretr,$chr(32),+%) | unset %ftprok.psvretr %ftprok.psvretr.n | sockclose RoKFTP3 | rokftp.sdir | rokftp.csb
}
on *:sockopen:RoKFTP3:{ if ($sockerr > 0) { rokftp.men Error, Al intentar descargar el archivo. } }
on *:sockread:RoKFTP3:{
  sockread %rokftp | tokenize 32 %rokftp
  if (220 == $1) { sockwrite -n $sockname USER %rokftp.user }
  if (331 == $1) { sockwrite -n $sockname PASS %rokftp.userpass }
  if (230 == $1) { sockwrite -n $sockname TYPE I | sockwrite -n $sockname PASV | sockwrite -n $sockname RETR %ftprok.psvretr }
  if (227 == $1) { var %a = $remove($replace($gettok($5,1-4,44),$chr(44),$chr(46)) $calc($gettok($5,-2,44) * 256 + $gettok($5,-1,44)),$chr(40)) | sockclose rokftp3.1 | sockopen rokftp3.1 %a }
}
on *:sockclose:RoKFTP3:{
  if ($exists(" $+ %ftprok.psvretr.dd $+ %ftprok.psvretr.n $+ ") == $true) { .fclose FTPRoK.d.* | rokftp.men Archivo %ftprok.psvretr descargado. }
  hdel rokftp.des $replace(%ftprok.psvretr,$chr(32),+%) | unset %ftprok.psvretr %ftprok.psvretr.n | sockclose RoKFTP3.1 | sockclose $sockname | rokftp.csb
}
alias rokftp.ctd0 { hfree -w rokftp.des | hfree -w rokftp.sub | hmake rokftp.des | hmake rokftp.sub | rokftp.csb }
alias rokftp.xitem { if ($1 == .sub) || ($1 == .des) { %a = 1 | while ($hget(rokftp $+ $1,0).item >= %a) { if ($2 == $replace($xdid(rokftp,30,%a,$iif(.des == $1,2,0)).text,$chr(32),+%)) { return %a } | inc %a } } }
alias rokftp.csb {
  if ($dialog(rokftp)) {
    if ($hget(rokftp.des,0).item > 0) {
      %rokftp.temp32 = 1
      while ($hget(rokftp.des,%rokftp.temp32).item) {
        if (%ftprok.psvretr == $null) {
          set %ftprok.psvretr.dd $gettok($hget(rokftp.des,$hget(rokftp.des,%rokftp.temp32).item),2,32)
          set %ftprok.psvretr $replace($hget(rokftp.des,%rokftp.temp32).item,+%,$chr(32))
          set %ftprok.psvretr.n $replace($gettok($hget(rokftp.des,$hget(rokftp.des,%rokftp.temp32).item),3,32),+%,$chr(32))
          sockclose rokftp3 | sockclose rokftp3.1 | sockopen rokftp3 %rokftp.serv %rokftp.port
        }
        if ($rokftp.xitem(.des,$hget(rokftp.des,%rokftp.temp32).item) == $null) { xdid -a rokftp 30 1 0 +k 1 0 0 0 -1 $rgb(255,255,255) %rokftp.sdir $chr(9) 0 0 <<====== $chr(9) 0 0 $replace($hget(rokftp.des,%rokftp.temp32).item,+%,$chr(32)) $chr(9) 0 0 $gettok($hget(rokftp.des,$hget(rokftp.des,%rokftp.temp32).item),1,32) $chr(9) +p }
        inc %rokftp.temp32
    } }
    if ($hget(rokftp.sub,0).item > 0) {
      %rokftp.temp32 = 1
      while ($hget(rokftp.sub,%rokftp.temp32).item) {
        if (%rokftp.s == $null) {
          set %rokftp.s $hget(rokftp.sub,%rokftp.temp32).item
          set %rokftp.s2 $gettok($hget(rokftp.sub,$hget(rokftp.sub,%rokftp.temp32).item),3,32)
          sockclose rokftp4 | sockclose rokftp4.1
          sockopen rokftp4 %rokftp.serv %rokftp.port
        }
        if ($rokftp.xitem(.sub,$hget(rokftp.sub,%rokftp.temp32).item) == $null) { xdid -a rokftp 30 1 0 +k 1 0 0 0 -1 $rgb(255,255,255) $replace($hget(rokftp.sub,%rokftp.temp32).item,+%,$chr(32)) $chr(9) 0 0 ======>> $chr(9) 0 0 $replace($gettok($hget(rokftp.sub,$hget(rokftp.sub,%rokftp.temp32).item),2,32),+%,$chr(32)) $chr(9) 0 0 $gettok($hget(rokftp.sub,$hget(rokftp.sub,%rokftp.temp32).item),1,32) $chr(9) +p }
        inc %rokftp.temp32
    } }
    rokftp.dsbv
} }
alias rokftp.dsbv {
  if ($dialog(rokftp)) {
    var %rokftp.descarga.tempo = $pn00($duration($calc($calc($hget(rokftp.des,$replace(%ftprok.psvretr,$chr(32),+%)) - %ftprok.psvretr.des) / $remove($calc(%ftprok.psvretr.desvel - %ftprok.psvretr.des),+,-))))
    var %rokftp.carga.tempo = $pn00($duration($calc($calc($gettok($hget(rokftp.sub,%rokftp.s),1,32) - %rokftp.svi) / $remove($calc(%ftprok.psvretr.subvel - %rokftp.svi),+,-))))
    if (%rokftp.svi) { xdid -v rokftp 30 $rokftp.xitem(.sub,%rokftp.s) 4 -v $round($calc($calc(%rokftp.svi * 100) / $gettok($hget(rokftp.sub,%rokftp.s),1,32)),1) }
    xdid -v rokftp 30 $rokftp.xitem(.sub,%rokftp.s) 5 $gettok($remove($calc($calc(%ftprok.psvretr.subvel - %rokftp.svi) / 1024),+,-),1,46) $iif($gettok($remove($calc($calc(%rokftp.bytevelo - %rokftp.svi) / 1024),+,-),1,46) == 0,Bytes,KB\Seg)
    xdid -v rokftp 30 $rokftp.xitem(.sub,%rokftp.s) 6 $iif(%rokftp.carga.tempo == 00:00:00,desconocido,%rokftp.carga.tempo)
    if (%ftprok.psvretr.des) { xdid -v rokftp 30 $rokftp.xitem(.des,%ftprok.psvretr) 4 -v $round($calc($calc(%ftprok.psvretr.des * 100) / $hget(rokftp.des,$replace(%ftprok.psvretr,$chr(32),+%))),1) }
    xdid -v rokftp 30 $rokftp.xitem(.des,%ftprok.psvretr) 5 $gettok($remove($calc($calc(%ftprok.psvretr.desvel - %ftprok.psvretr.des) / 1024),+,-),1,46) $iif($gettok($remove($calc($calc(%ftprok.psvretr.desvel - %ftprok.psvretr.des) / 1024),+,-),1,46) == 0,Bytes,KB\Seg)
    xdid -v rokftp 30 $rokftp.xitem(.des,%ftprok.psvretr) 6 %rokftp.descarga.tempo
    set %ftprok.psvretr.desvel %ftprok.psvretr.des | set %ftprok.psvretr.subvel %rokftp.svi | .timerrokftp.dsbv 1 1 rokftp.dsbv
} }
alias rokftp.existsc1 {
  if ($1 != $null) && ($dialog(rokftp)) {
    %rokftp.temp = 1 | while ($xdid(rokftp,21,%rokftp.temp,0).text) {
      if ($xdid(rokftp,21,%rokftp.temp,0).text == $1-) { return $xdid(rokftp,21,%rokftp.temp,1).text $xdid(rokftp,21,%rokftp.temp,3).text | halt }
      inc %rokftp.temp
} } }
alias rokftp.existsc2 {
  if ($1 != $null) && ($dialog(rokftp)) {
    %rokftp.direct = 1 | while ($findfile(%rokftp.sdir,*.*,%rokftp.direct,1)) {
      if ($nopath($findfile(%rokftp.sdir,*.*,%rokftp.direct,1)) == $remove($1-,")) { return $file($findfile(%rokftp.sdir,*.*,%rokftp.direct,1)).size | halt }
      inc %rokftp.direct
} } }
Alias pn00 {
  if ($1) {
    %pn00 = â ê î:ô:û | %pn01 = $replace($remove($1-,s),ec,$chr(32) ec,min,$chr(32) min,hr,$chr(32) hr,wk,$chr(32) wk,day,$chr(32) day)
    %pn02 = $gettok(%pn01,$calc($findtok(%pn01,ec,32) - 1),32)) | %pn03 = $gettok(%pn01,$calc($findtok(%pn01,min,32) - 1),32))
    %pn04 = $gettok(%pn01,$calc($findtok(%pn01,hr,32) - 1),32)) | %pn05 = $gettok(%pn01,$calc($findtok(%pn01,day,32) - 1),32))
    %pn06 = $gettok(%pn01,$calc($findtok(%pn01,wk,32) - 1),32)) | if (ec isin %pn01) { %pn00 = $replace(%pn00,û,$iif($len(%pn02) == 1,0 $+ %pn02,%pn02)) }
    if (min isin %pn01) { %pn00 = $replace(%pn00,ô,$iif($len(%pn03) == 1,0 $+ %pn03,%pn03)) } | if (hr isin %pn01) { %pn00 = $replace(%pn00,î,$iif($len(%pn04) == 1,0 $+ %pn04,%pn04)) }
    if (day isin %pn01) { %pn00 = $replace(%pn00,ê,%pn05 $+ ds) } | if (wk isin %pn01) { %pn00 = $replace(%pn00,â,%pn06 $+ sems) } | return $replace($remove(%pn00,â,ê),î,00,ô,00,û,00)
} }
