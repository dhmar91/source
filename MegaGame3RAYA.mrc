;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;
; Addon: MegaGame 3 en Raya v2.0
; Trabajo realizado por:
; David Hidalgo Marsal [RoK] (Programación del Addon)
; David Quintana del Castillo [dqc] (Diseño y gráficos)
; Publicado: 31/01/2012
; E-mail: Devel.MainCenter@gmail.com & RoKScripter@terra.es
; Web: Www.MainCenter.Ya.St
;
; Queda totalmente prohibida la copia sin el permiso de
; Su(s) Autor(es). Prohibido Modificar el codigo del addon "Copiar no es la solución"
; Los autores no se hacen responsables de los daños que pueda causar el usuario.
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ON *:LOAD:{
  echo -s [MegaGame 3 en RAYA v2.0 Cargado]
  echo -s Comprobando archivos..
  if ($exists(" $+ $scriptdirtablero.jpg $+ ") == $false) { echo -s 3RAYA: ERROR!! Tablero no encontrado. }
  if ($exists(" $+ $scriptdirx.jpg $+ ") == $false) { echo -s 3RAYA: ERROR!! Ficha X no encontrada. }
  if ($exists(" $+ $scriptdiro.jpg $+ ") == $false) { echo -s 3RAYA: ERROR!! Ficha O no encontrada. }
  echo -s Archivos comprobados.
}
Raw 401:*:{ if (%MegaGame.3RAYA.C == $2) && (%MegaGame.3RAYA.GO) { unset %MegaGame.3RAYA.C %MegaGame.3RAYA.GO | window -c @MegaGame.3Raya } }
ON *:QUIT:{ if (%MegaGame.3RAYA.C == $nick) && (%MegaGame.3RAYA.GO) { unset %MegaGame.3RAYA.C %MegaGame.3RAYA.GO | window -c @MegaGame.3Raya } }
ON *:START:{ unset %MegaGame.3RAYA.C %MegaGame.3RAYA.GO }
ON *:Connect:{ unset %MegaGame.3RAYA.C %MegaGame.3RAYA.GO | window -c @MegaGame.3Raya }
Ctcp *:*:*:{
  if (%MegaGame.3RAYA.C == $nick) && (%MegaGame.3RAYA.GO) {
    if (%3raya.toka == ttno) {
      if ($1 == Mx) && ($2 == 2) && ($3 == 2) && (%3Raya.x-22 != Ocp) && (%3Raya.o-22 != Ocp) { set %3Raya.x-22 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mx) && ($2 == 2) && ($3 == 87) && (%3Raya.x-287 != Ocp) && (%3Raya.o-287 != Ocp) { set %3Raya.x-287 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mx) && ($2 == 2) && ($3 == 168) && (%3Raya.x-2168 != Ocp) && (%3Raya.o-2168 != Ocp) { set %3Raya.x-2168 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mx) && ($2 == 87) && ($3 == 2) && (%3Raya.x-872 != Ocp) && (%3Raya.o-872 != Ocp) { set %3Raya.x-872 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mx) && ($2 == 87) && ($3 == 87) && (%3Raya.x-8787 != Ocp) && (%3Raya.o-8787 != Ocp) { set %3Raya.x-8787 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mx) && ($2 == 87) && ($3 == 171) && (%3Raya.x-87171 != Ocp) && (%3Raya.o-87171 != Ocp) { set %3Raya.x-87171 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mx) && ($2 == 171) && ($3 == 2) && (%3Raya.x-1712 != Ocp) && (%3Raya.o-1712 != Ocp) { set %3Raya.x-1712 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mx) && ($2 == 171) && ($3 == 87) && (%3Raya.x-17187 != Ocp) && (%3Raya.o-17187 != Ocp) { set %3Raya.x-17187 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mx) && ($2 == 171) && ($3 == 171) && (%3Raya.x-171171 != Ocp) && (%3Raya.o-171171 != Ocp) { set %3Raya.x-171171 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mo) && ($2 == 2) && ($3 == 2) && (%3Raya.x-22 != Ocp) && (%3Raya.o-22 != Ocp) { set %3Raya.o-22 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mo) && ($2 == 2) && ($3 == 87) && (%3Raya.x-287 != Ocp) && (%3Raya.o-287 != Ocp) { set %3Raya.o-287 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mo) && ($2 == 2) && ($3 == 168) && (%3Raya.x-2168 != Ocp) && (%3Raya.o-2168 != Ocp) { set %3Raya.o-2168 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mo) && ($2 == 87) && ($3 == 2) && (%3Raya.x-872 != Ocp) && (%3Raya.o-872 != Ocp) { set %3Raya.o-872 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mo) && ($2 == 87) && ($3 == 87) && (%3Raya.x-8787 != Ocp) && (%3Raya.o-8787 != Ocp) { set %3Raya.o-8787 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mo) && ($2 == 87) && ($3 == 171) && (%3Raya.x-87171 != Ocp) && (%3Raya.o-87171 != Ocp) { set %3Raya.o-87171 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mo) && ($2 == 171) && ($3 == 2) && (%3Raya.x-1712 != Ocp) && (%3Raya.o-1712 != Ocp) { set %3Raya.o-1712 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mo) && ($2 == 171) && ($3 == 87) && (%3Raya.x-17187 != Ocp) && (%3Raya.o-17187 != Ocp) { set %3Raya.o-17187 Ocp | set %3raya.toka me | 3raya.pnts }
      if ($1 == Mo) && ($2 == 171) && ($3 == 171) && (%3Raya.x-171171 != Ocp) && (%3Raya.o-171171 != Ocp) { set %3Raya.o-171171 Ocp | set %3raya.toka me | 3raya.pnts }
      3raya.cmp
    }
    if ($1 == 3RAYA.CLOSE) { unset %MegaGame.3RAYA.C %MegaGame.3RAYA.GO | window -c @MegaGame.3Raya | haltdef }
  }
  if ($1 == Mo) || ($1 == t) || ($1 == Mx) { haltdef }
  if ($1 == MegaGame.3RAYA.OK) { if (%MegaGame.3RAYA.C == $nick) { .ctcp $nick MegaGame.3RAYA.OPN | 3raya.opn } | haltdef }
  if ($1 == MegaGame.3RAYA.OPN) { if (%MegaGame.3RAYA.C == $nick) { 3raya.opn } | haltdef }
  if ($1 == MegaGame.3RAYA.P) { if ($window(@MegaGame.3Raya.Respuesta).state == $null) && (%MegaGame.3enraya.nm == $null) { set %3raya.reto.s2 31 | set %3raya.reto.s3 $nick $2 | 3raya.sol3 } | haltdef }
  if ($1 == 3RAYA.CLOSE) { haltdef }
}
Menu Nicklist,Query {
  Jugar al 3 en Raya con $$1: if ($1 == $me) { echo -a ERROR! No puedes jugar al 3 en raya contra ti mismo. } | elseif ($1) { if ($window(@MegaGame.3Raya).state != $null) && (%MegaGame.3RAYA.GO) && (%MegaGame.3RAYA.C) { .ctcp %MegaGame.3RAYA.C 3RAYA.CLOSE | window -c @MegaGame.3Raya } | 3raya.o | set %MegaGame.3RAYA.CY O | set %MegaGame.3RAYA.C $1 | .ctcp $1 MegaGame.3RAYA.P $iif(%3raya.toka == me,ttno,me) | set %3raya.reto.s 31 | 3raya.sol $1 }
}
Menu Menubar,status,query {
  MegaGame 3Raya v2.0
  .$iif(!%MegaGame.3enraya.nm,$style(1)) Preguntar si deseo aceptar retos: unset %MegaGame.3enraya.nm
  .$iif(%MegaGame.3enraya.nm,$style(1)) Ignorar todos los retos: set %MegaGame.3enraya.nm o
  .-
  .Ayuda && Creditos: 3raya.ayuda.cred
}
alias 3raya.ayuda.cred {
  echo -s  | echo -s 12Creditos:
  echo -s 2MegaGame 3 en Raya2. Version 2.02. By RoK2 & dqc
  echo -s 2Web Oficial: 12Www.MainCenter.Ya.St 2Creado el 31/01/2012
  echo -s 2E-mail: 12Devel.MainCenter@gmail.com | echo -s 
  echo -s 12Ayuda: | echo -s 2Para jugar pulsa encima del nick con el que deseas jugar,
  echo -s 2o en privado. Boton derecho -> Jugar al 3 en raya con.. | echo -s 
}
alias 3raya.opn { if (%MegaGame.3RAYA.CY) { set %3raya.s o } | else { set %3raya.s x } | set %MegaGame.3RAYA.GO ON | window -c @MegaGame.3Raya.reto | unset %3raya.reto.s | .timer3raya.sol off | window -c @MegaGame.3Raya | window -odkp +n2t @MegaGame.3Raya 40 50 258 377 v2.0 | titlebar @MegaGame.3Raya v2.0 | 3raya.pnts }
alias 3raya.o { unset %3Raya.* %MegaGame.3RAYA.* | if ($rand(1,1000) >= 500) { set %3raya.toka ttno } | else { set %3raya.toka me } | set %MegaGame.3RAYA.EMPP %3raya.toka }
alias 3raya.sol { window -c @MegaGame.3Raya.reto | window -odkp +n2t @MegaGame.3Raya.reto 40 50 275 90 v2.0 | titlebar @MegaGame.3Raya.reto v2.0 | 3raya.sol2 $1 }
alias 3raya.sol2 {
  dec %3raya.reto.s | if (%3raya.reto.s >= 0) { clear @MegaGame.3Raya.reto | drawtext -p @MegaGame.3Raya.reto Times-New-Roman 10 10 2Esperando respuesta de12 $1 2.. | drawtext -p @MegaGame.3Raya.reto Times-New-Roman 10 30 2La solicitud caduca en3 %3raya.reto.s 2segundos | .timer3raya.sol -o 1 1 3raya.sol2 $1 }
  else { unset %3raya.reto.s %MegaGame.3RAYA.C %MegaGame.3RAYA.GO | window -c @MegaGame.3Raya.reto }
}
on *:Close:@MegaGame.3Raya.reto:{ .timer3raya.sol off | unset %3raya.reto.s %MegaGame.3RAYA.C %MegaGame.3RAYA.GO | window -c @MegaGame.3Raya }
alias 3raya.sol3 { window -c @MegaGame.3Raya.reto | window -odkp +n2t @MegaGame.3Raya.Respuesta 40 50 275 110 v2.0 | titlebar @MegaGame.3Raya.Respuesta v2.0 | 3raya.sol4 }
alias 3raya.sol4 {
  dec %3raya.reto.s2 | if (%3raya.reto.s2 >= 0) && (%3raya.reto.s3) { clear @MegaGame.3Raya.Respuesta | drawtext -p @MegaGame.3Raya.Respuesta Times-New-Roman 10 10 12 $+ $gettok(%3raya.reto.s3,1,32) 2Te ha retado al 3 en Raya. | drawtext -p @MegaGame.3Raya.Respuesta Times-New-Roman 10 30 2La solicitud caduca en3 %3raya.reto.s2 2segundos | drawtext -p @MegaGame.3Raya.Respuesta Times-New-Roman 30 50 4Rechazar | drawtext -p @MegaGame.3Raya.Respuesta Times-New-Roman 179 50 3Aceptar | .timer3raya.sol4 -o 1 1 3raya.sol4 }
  else { unset %3raya.reto.s2 | window -c @MegaGame.3Raya.Respuesta }
}
on *:Close:@MegaGame.3Raya.Respuesta:{ .timer3raya.sol4 off | unset %3raya.reto.s2 %3raya.reto.s3 | window -c @MegaGame.3Raya.Respuesta }
Menu @MegaGame.3RAYA.respuesta {
  sclick: {
    if ($mouse.y >= 53) && ($mouse.y < 66) {
      if ($mouse.x > 31) && ($mouse.x < 84) { .timer3raya.sol4 off | unset %3raya.reto.s2 %3raya.reto.s3 | window -c @MegaGame.3Raya.Respuesta }
      if ($mouse.x > 179) && ($mouse.x < 223) { if ($gettok(%3raya.reto.s3,2,32) != $null) { .timer3raya.sol4 off | window -c @MegaGame.3Raya.Respuesta | 3raya.accept.reto %3raya.reto.s3 } | else { .timer3raya.sol4 off | unset %3raya.reto.s2 %3raya.reto.s3 | window -c @MegaGame.3Raya.Respuesta } }
} } }
alias 3raya.accept.reto {
  if ($window(@MegaGame.3Raya).state != $null) && (%MegaGame.3RAYA.GO) && (%MegaGame.3RAYA.C) { .ctcp %MegaGame.3RAYA.C 3RAYA.CLOSE | window -c @MegaGame.3Raya }
  unset %3Raya.* %MegaGame.3RAYA.* | set %MegaGame.3RAYA.EMPP $2 | set %MegaGame.3RAYA.C $1 | set %3raya.toka $2 | .ctcp $1 MegaGame.3RAYA.OK
}
menu @MegaGame.3Raya {
  sclick: {
    if ($mouse.y >= 324) && ($mouse.y < 336) && ($mouse.x > 120) && ($mouse.x < 243) { run http://www.maincenter.ya.st }
    if (%MegaGame.3RAYA.GO) {
      3raya.cmp
      if (%3raya.toka == me) {
        if ($mouse.x <= 82) {
          if ($mouse.y <= 82) {
            if (%3raya.toka == me) {
              if (%3raya.s == o) && (%3Raya.x-22 != Ocp) && (%3Raya.o-22 != Ocp) { set %3Raya.o-22 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mo 2 2 }
              if (%3raya.s == x) && (%3Raya.x-22 != Ocp) && (%3Raya.o-22 != Ocp) { set %3Raya.x-22 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mx 2 2 }
          } }
          if ($mouse.y >= 85) && ($mouse.y <= 166) {
            if (%3raya.toka == me) {
              if (%3raya.s == o) && (%3Raya.x-287 != Ocp) && (%3Raya.o-287 != Ocp) { set %3Raya.o-287 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mo 2 87 }
              if (%3raya.s == x) && (%3Raya.x-287 != Ocp) && (%3Raya.o-287 != Ocp) { set %3Raya.x-287 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mx 2 87 }
          } }
          if ($mouse.y >= 169) && ($mouse.y <= 250) {
            if (%3raya.toka == me) {
              if (%3raya.s == o) && (%3Raya.x-2168 != Ocp) && (%3Raya.o-2168 != Ocp) { set %3Raya.o-2168 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mo 2 168 }
              if (%3raya.s == x) && (%3Raya.x-2168 != Ocp) && (%3Raya.o-2168 != Ocp) { set %3Raya.x-2168 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mx 2 168 }
        } } }
        if ($mouse.x >= 85) && ($mouse.x <= 166) {
          if ($mouse.y <= 82) {
            if (%3raya.toka == me) {
              if (%3raya.s == o) && (%3Raya.x-872 != Ocp) && (%3Raya.o-872 != Ocp) { set %3Raya.o-872 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mo 87 2 }
              if (%3raya.s == x) && (%3Raya.x-872 != Ocp) && (%3Raya.o-872 != Ocp) { set %3Raya.x-872 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mx 87 2 }
          } }
          if ($mouse.y >= 85) && ($mouse.y <= 166) {
            if (%3raya.toka == me) {
              if (%3raya.s == o) && (%3Raya.x-8787 != Ocp) && (%3Raya.o-8787 != Ocp) { set %3Raya.o-8787 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mo 87 87 }
              if (%3raya.s == x) && (%3Raya.x-8787 != Ocp) && (%3Raya.o-8787 != Ocp) { set %3Raya.x-8787 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mx 87 87 }
          } }
          if ($mouse.y >= 169) && ($mouse.y <= 250) {
            if (%3raya.toka == me) {
              if (%3raya.s == o) && (%3Raya.x-87171 != Ocp) && (%3Raya.o-87171 != Ocp) { set %3Raya.o-87171 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mo 87 171 }
              if (%3raya.s == x) && (%3Raya.x-87171 != Ocp) && (%3Raya.o-87171 != Ocp) { set %3Raya.x-87171 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mx 87 171 }
        } } }
        if ($mouse.x >= 169) && ($mouse.x <= 250) {
          if ($mouse.y <= 82) {
            if (%3raya.toka == me) {
              if (%3raya.s == o) && (%3Raya.x-1712 != Ocp) && (%3Raya.o-1712 != Ocp) { set %3Raya.o-1712 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mo 171 2 }
              if (%3raya.s == x) && (%3Raya.x-1712 != Ocp) && (%3Raya.o-1712 != Ocp) { set %3Raya.x-1712 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mx 171 2 }
          } }
          if ($mouse.y >= 85) && ($mouse.y <= 166) {
            if (%3raya.toka == me) {
              if (%3raya.s == o) && (%3Raya.x-17187 != Ocp) && (%3Raya.o-17187 != Ocp) { set %3Raya.o-17187 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mo 171 87 }
              if (%3raya.s == x) && (%3Raya.x-17187 != Ocp) && (%3Raya.o-17187 != Ocp) { set %3Raya.x-17187 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mx 171 87 }
          } }
          if ($mouse.y >= 169) && ($mouse.y <= 250) {
            if (%3raya.toka == me) {
              if (%3raya.s == o) && (%3Raya.x-171171 != Ocp) && (%3Raya.o-171171 != Ocp) { set %3Raya.o-171171 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mo 171 171 }
              if (%3raya.s == x) && (%3Raya.x-171171 != Ocp) && (%3Raya.o-171171 != Ocp) { set %3Raya.x-171171 Ocp | set %3raya.toka ttno | 3raya.pnts | .ctcp %MegaGame.3RAYA.C Mx 171 171 }
      } } } }
      3raya.cmp
} } }
Alias 3raya.cmp {
  if (%3Raya.o-2168 === Ocp) && (%3Raya.o-287 === Ocp) && (%3Raya.o-22 === Ocp) { if (%3raya.s == o) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.o-87171 === Ocp) && (%3Raya.o-8787 === Ocp) && (%3Raya.o-872 === Ocp) { if (%3raya.s == o) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.o-171171 === Ocp) && (%3Raya.o-17187 === Ocp) && (%3Raya.o-1712 === Ocp) { if (%3raya.s == o) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.o-22 === Ocp) && (%3Raya.o-872 === Ocp) && (%3Raya.o-1712 === Ocp) { if (%3raya.s == o) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.o-287 === Ocp) && (%3Raya.o-8787 === Ocp) && (%3Raya.o-17187 === Ocp) { if (%3raya.s == o) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.o-2168 === Ocp) && (%3Raya.o-87171 === Ocp) && (%3Raya.o-171171 === Ocp) { if (%3raya.s == o) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.o-2168 === Ocp) && (%3Raya.o-8787 === Ocp) && (%3Raya.o-1712 === Ocp) { if (%3raya.s == o) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.o-22 === Ocp) && (%3Raya.o-171171 === Ocp) && (%3Raya.o-8787 === Ocp) { if (%3raya.s == o) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.x-2168 === Ocp) && (%3Raya.x-287 === Ocp) && (%3Raya.x-22 === Ocp) { if (%3raya.s == x) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.x-87171 === Ocp) && (%3Raya.x-8787 === Ocp) && (%3Raya.x-872 === Ocp) { if (%3raya.s == x) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.x-171171 === Ocp) && (%3Raya.x-17187 === Ocp) && (%3Raya.x-1712 === Ocp) { if (%3raya.s == x) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.x-22 === Ocp) && (%3Raya.x-872 === Ocp) && (%3Raya.x-1712 === Ocp) { if (%3raya.s == x) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.x-287 === Ocp) && (%3Raya.x-8787 === Ocp) && (%3Raya.x-17187 === Ocp) { if (%3raya.s == x) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.x-2168 === Ocp) && (%3Raya.x-87171 === Ocp) && (%3Raya.x-171171 === Ocp) { if (%3raya.s == x) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.x-2168 === Ocp) && (%3Raya.x-8787 === Ocp) && (%3Raya.x-1712 === Ocp) { if (%3raya.s == x) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.x-22 === Ocp) && (%3Raya.x-171171 === Ocp) && (%3Raya.x-8787 === Ocp) { if (%3raya.s == x) { inc %3raya.pnts1 } | else { inc %3raya.pnts2 } | 3raya.c | halt }
  if (%3Raya.o-2168 === Ocp) || (%3Raya.x-2168 === Ocp) {
    if (%3Raya.o-87171 === Ocp) || (%3Raya.x-87171 === Ocp) {
      if (%3Raya.o-171171 === Ocp) || (%3Raya.x-171171 === Ocp) {
        if (%3Raya.o-287 === Ocp) || (%3Raya.x-287 === Ocp) {
          if (%3Raya.o-8787 === Ocp) || (%3Raya.x-8787 === Ocp) {
            if (%3Raya.o-17187 === Ocp) || (%3Raya.x-17187 === Ocp) {
              if (%3Raya.o-22 === Ocp) || (%3Raya.x-22 === Ocp) {
                if (%3Raya.o-872 === Ocp) || (%3Raya.x-872 === Ocp) {
                  if (%3Raya.o-1712 === Ocp) || (%3Raya.x-1712 === Ocp) {
                    inc %3raya.pnts3 | 3raya.c | halt
} } } } } } } } } }
Alias 3raya.c { if (%MegaGame.3RAYA.EMPP == ttno) { set %MegaGame.3RAYA.EMPP me | set %3raya.toka me } | else { set %MegaGame.3RAYA.EMPP ttno | set %3raya.toka ttno } | unset %3Raya.o* %3Raya.x* | 3raya.pnts }
on *:Close:@MegaGame.3Raya:{ if (%MegaGame.3RAYA.C) && (%MegaGame.3RAYA.GO) { .ctcp %MegaGame.3RAYA.C 3RAYA.CLOSE } | unset %MegaGame.3RAYA.C %MegaGame.3RAYA.GO }
Alias 3raya.pnts {
  clear @MegaGame.3Raya | drawpic -cn @MegaGame.3Raya 0 0 " $+ $scriptdirtablero.jpg $+ " | 3raya.rcfch
  drawtext -p @MegaGame.3Raya Times-New-Roman 10 262 2Tu eres la10 $upper(%3raya.s)
  drawtext -p @MegaGame.3Raya Times-New-Roman 10 282 2Ganadas:12 $iif(%3raya.pnts1 == $null,0,%3raya.pnts1)
  drawtext -p @MegaGame.3Raya Times-New-Roman 10 302 2Perdidas:4 $iif(%3raya.pnts2 == $null,0,%3raya.pnts2)
  drawtext -p @MegaGame.3Raya Times-New-Roman 10 322 2Empatadas:6 $iif(%3raya.pnts3 == $null,0,%3raya.pnts3)
  drawtext -p @MegaGame.3Raya Times-New-Roman 120 262 2Rival:12 %MegaGame.3RAYA.C
  drawtext -p @MegaGame.3Raya Times-New-Roman 120 282  $+ $iif(%3raya.toka == me, 3¡Su Turno!, 4Espere su Turno.)
  drawtext -p @MegaGame.3Raya Times-New-Roman 120 302 2By 2RoK &2 dqc
  drawtext -p @MegaGame.3Raya Times-New-Roman 120 322 12Www.MainCenter.ya.St | drawdot @MegaGame.3Raya
}
Alias 3raya.rcfch {
  if (%3Raya.o-22 == Ocp) { drawpic -cn @MegaGame.3Raya 7 7 " $+ $scriptdiro.jpg $+ " }
  if (%3Raya.o-287 == Ocp) { drawpic -cn @MegaGame.3Raya 7 94 " $+ $scriptdiro.jpg $+ " }
  if (%3Raya.o-2168 == Ocp) { drawpic -cn @MegaGame.3Raya 7 181 " $+ $scriptdiro.jpg $+ " }
  if (%3Raya.o-872 == Ocp) { drawpic -cn @MegaGame.3Raya 93 7 " $+ $scriptdiro.jpg $+ " }
  if (%3Raya.o-8787 == Ocp) { drawpic -cn @MegaGame.3Raya 93 94 " $+ $scriptdiro.jpg $+ " }
  if (%3Raya.o-87171 == Ocp) { drawpic -cn @MegaGame.3Raya 93 181 " $+ $scriptdiro.jpg $+ " }
  if (%3Raya.o-1712 == Ocp) { drawpic -cn @MegaGame.3Raya 179 7 " $+ $scriptdiro.jpg $+ " }
  if (%3Raya.o-17187 == Ocp) { drawpic -cn @MegaGame.3Raya 179 94 " $+ $scriptdiro.jpg $+ " }
  if (%3Raya.o-171171 == Ocp) { drawpic -cn @MegaGame.3Raya 179 181 " $+ $scriptdiro.jpg $+ " }
  if (%3Raya.x-22 == Ocp) { drawpic -cn @MegaGame.3Raya 7 7 " $+ $scriptdirx.jpg $+ " }
  if (%3Raya.x-287 == Ocp) { drawpic -cn @MegaGame.3Raya 7 94 " $+ $scriptdirx.jpg $+ " }
  if (%3Raya.x-2168 == Ocp) { drawpic -cn @MegaGame.3Raya 7 181 " $+ $scriptdirx.jpg $+ " }
  if (%3Raya.x-872 == Ocp) { drawpic -cn @MegaGame.3Raya 93 7 " $+ $scriptdirx.jpg $+ " }
  if (%3Raya.x-8787 == Ocp) { drawpic -cn @MegaGame.3Raya 93 94 " $+ $scriptdirx.jpg $+ " }
  if (%3Raya.x-87171 == Ocp) { drawpic -cn @MegaGame.3Raya 93 181 " $+ $scriptdirx.jpg $+ " }
  if (%3Raya.x-1712 == Ocp) { drawpic -cn @MegaGame.3Raya 179 7 " $+ $scriptdirx.jpg $+ " }
  if (%3Raya.x-17187 == Ocp) { drawpic -cn @MegaGame.3Raya 179 94 " $+ $scriptdirx.jpg $+ " }
  if (%3Raya.x-171171 == Ocp) { drawpic -cn @MegaGame.3Raya 179 181 " $+ $scriptdirx.jpg $+ " }
}
