*!* Letras a Numeros
*!* Samuel Monjaraz Vázquez
*!* Creación 1996
*!* Ultima modificación Oct 2013

*** EJEMPLOS DE USO o TEST
CLEAR
** Si quieres algo mas grande....mejor como letra ;)
*? n2c("765798743289987543987887765997354794203841531897242.67")
*? n2c(0)
*? n2c(1.1)
** "765,798,743,289,987,543,987,887,765,997,354,794,203,841,531,897,242.67"
**** Pruba subir a nonillon, le denes agregar 6 digitos más y
**** en los case finales (fSepa), agregar valores 19 y 20 y en lugar de Oct pon Non
**** Fin de TEST

PROCEDURE n2c(numero)
SET UDFPARMS TO REFERENCE
*** Normado el numero
IF TYPE("numero")="N"
	nNum    = ABS(numero)
	cNumStr = ALLTRIM(TRANSFORM(nNum,"@#"))
ELSE
	cNumStr = numero
ENDIF 

*** Separando parte entera de la decimal
nPosDec = AT(".", cNumStr)
IF nPosDec # 0
	cNumEnt = SUBSTR(cNumStr, 1, nPosDec-1)
	cNumDec = SUBSTR(cNumStr, nPosDec+1 , 2)
ELSE
	cNumEnt = cNumStr
	cNumDec = "00"
ENDIF 
IF VAL(cNumEnt)#0
	lPlural = IIF(VAL(cNumEnt) = 1, .F., .T.)
	*** Rellenando ceros al inicio del entero para completar juegos de tres.
	nRes = MOD(LEN(cNumEnt), 3)
	IF nRes # 0
		cNumEnt = REPLICATE("0", 3-nRes) + cNumEnt
	ENDIF
	*** Iniciando ciclo / periodos
	nPosFin   = LEN(cNumEnt)
	nPeriodos = nPosFin/3
	cCadFin = ""
	nBan = 0
	wBan = 0
	FOR t=1 TO nPeriodos
	    uni = VAL(SUBSTR(cNumEnt, nPosFin, 1))
	    nPosFin = nPosFin - 1
	    dec = VAL(SUBSTR(cNumEnt, nPosFin, 1))
	    nPosFin = nPosFin - 1
	    cen = VAL(SUBSTR(cNumEnt, nPosFin, 1))
	    nPosFin = nPosFin - 1
	    *** Leyendas
		 letra3 = centena(uni, dec, cen)
		 letra2 = decenas(uni, dec, cen)
		 letra1 = unidads(uni, dec, cen) 
		 *** Serie y periodos
		 cSepa = fSepa(t, uni+(dec*10)+(cen*100), nBan, wBan)
		 *** Cadena final
		 cCadFin = letra3 + letra2 + letra1 + cSepa +cCadFin
	ENDFOR
	IF wBan = 0
   	cCadFin = cCadFin + "de "
	ENDIF	
  ELSE
   cCadFin = "cero "
   lPlural = .T.
ENDIF

***
*** Para otra moneda, cambia las leyendas entre comillas a tu gusto
*** 
IF !lPlural
	cCadFin = cCadFin + " " + cNumDec + "/100 Boliviano"
  ELSE
	cCadFin = cCadFin + " " + cNumDec + "/100 Bolivianos"
ENDIF
Return cCadFin

** Unidades
Procedure unidads
Parameter uni,dec,cen
Do Case
Case uni = 1 .And. dec#1
     ctexto = "un "
Case uni = 2 .And. dec#1
     ctexto = "dos "
Case uni = 3 .And. dec#1
     ctexto = "tres "
Case uni = 4 .And. dec#1
     ctexto = "cuatro "
Case uni = 5 .And. dec#1
     ctexto = "cinco "
Case uni = 6
     ctexto = "seis "
Case uni = 7
     ctexto = "siete "
Case uni = 8
     ctexto = "ocho "
Case uni = 9
     ctexto = "nueve "
OtherWise
     ctexto = ""
EndCase
Return ctexto

** Centenas
Procedure centena
Parameter uni,dec,cen
Do Case
Case cen=1 .And. (dec=0 .And. uni=0)
     ctexto = "cien "
Case cen=1 .And. (dec>0 .Or. uni>0)
     ctexto = "ciento "
Case cen=2
     ctexto = "doscientos "
Case cen=3
     ctexto = "trescientos "
Case cen=4
     ctexto = "cuatrocientos "
Case cen=5
     ctexto = "quinientos "
Case cen=6
     ctexto = "seiscientos "
Case cen=7
     ctexto = "setecientos "
Case cen=8
     ctexto = "ochocientos "
Case cen=9
     ctexto = "novecientos "
OtherWise
     ctexto = ""
EndCase
Return ctexto

** Decenas
Procedure decenas
Parameter uni,dec,cen
Do Case
Case dec=1 .and. uni=0
     ctexto = "diez "
Case dec=1 .and. uni=1
     ctexto = "once "
Case dec=1 .and. uni=2
     ctexto = "doce "
Case dec=1 .and. uni=3
     ctexto = "trece "
Case dec=1 .and. uni=4
     ctexto = "catorce "
Case dec=1 .and. uni=5
     ctexto = "quince "
Case dec=1 .and. (uni>5 .and. uni<10)
     ctexto = "dieci"
Case dec=2 .and. uni=0
     ctexto = "veinte "
Case dec=2 .and. uni>0
     ctexto = "veinti"
Case dec=3 .and. uni=0
     ctexto = "treinta "
Case dec=3 .and. uni>0
     ctexto = "treinta y "
Case dec=4 .and. uni=0
     ctexto = "cuarenta "
Case dec=4 .and. uni>0
     ctexto = "cuarenta y "
Case dec=5 .and. uni=0
     ctexto = "cincuenta "
Case dec=5 .and. uni>0
     ctexto = "cincuenta y "
Case dec=6 .and. uni=0
     ctexto = "sesenta "
Case dec=6 .and. uni>0
     ctexto = "sesenta y "
Case dec=7 .and. uni=0
     ctexto = "setenta "
Case dec=7 .and. uni>0
     ctexto = "setenta y "
Case dec=8 .and. uni=0
     ctexto = "ochenta "
Case dec=8 .and. uni>0
     ctexto = "ochenta y "
Case dec=9 .and. uni=0
     ctexto = "noventa "
Case dec=9 .and. uni>0
     ctexto = "noventa y "
OtherWise
     ctexto = ""
EndCase
Return ctexto

*** Series y periodos
PROCEDURE fSepa(nSepa, nCan, nBan, wBan)
cSepa = ""
DO CASE
   CASE nSepa = 1
      IF nCan # 0
         wBan = 1
   	ENDIF
   CASE nSepa = 2
      IF nCan # 0
   	   cSepa = "mil "
   	   wBan = 1
   	ENDIF
   CASE nSepa = 3
      DO CASE
         CASE nCan = 1
         	cSepa = "millon "
         	nBan = 1
         CASE nCan > 1
            cSepa = "millones "
            nBan = 1
      ENDCASE
   CASE nSepa = 4
      xx = 1
      DO CASE 
         CASE nCan # 0 .And. nBan = 1
	   	     cSepa = "mil "
	   	CASE nCan # 0 .And. nBan = 0
	   	     cSepa = "mil millones "
      ENDCASE 
   	nBan = 0
   CASE nSepa = 5
      DO CASE
         CASE nCan = 1
         	cSepa = "billon "
         	nBan = 1
         CASE nCan > 1
            cSepa = "billones "
            nBan = 1
      ENDCASE 
   CASE nSepa = 6
      DO CASE 
		   CASE nCan # 0 .And. nBan = 1
		      cSepa = "mil "
         CASE nCan # 0 .And. nBan = 0
				cSepa = "mil billones "
   	ENDCASE
   	nBan = 0
   CASE nSepa = 7
      DO CASE
         CASE nCan = 1
         	cSepa = "trillon "
         	nBan = 1
         CASE nCan > 1
            cSepa = "trillones "
            nBan = 1
      ENDCASE 
   CASE nSepa = 8
      DO CASE 
		   CASE nCan # 0 .And. nBan = 1
		      cSepa = "mil "
         CASE nCan # 0 .And. nBan = 0
				cSepa = "mil trillones "
   	ENDCASE
   	nBan = 0
   CASE nSepa = 9
      DO CASE
         CASE nCan = 1
         	cSepa = "cuatrillon "
         	nBan = 1
         CASE nCan > 1
            cSepa = "cuatrillones "
            nBan = 1
      ENDCASE 
   CASE nSepa = 10
      DO CASE 
		   CASE nCan # 0 .And. nBan = 1
		      cSepa = "mil "
         CASE nCan # 0 .And. nBan = 0
				cSepa = "mil cuatrillones "
   	ENDCASE
   	nBan = 0
   CASE nSepa = 11
      DO CASE
         CASE nCan = 1
         	cSepa = "quintillon "
         	nBan = 1
         CASE nCan > 1
            cSepa = "quintillones "
            nBan = 1
      ENDCASE 
   CASE nSepa = 12
      DO CASE 
		   CASE nCan # 0 .And. nBan = 1
		      cSepa = "mil "
         CASE nCan # 0 .And. nBan = 0
				cSepa = "mil quintillones "
   	ENDCASE
   	nBan = 0
   CASE nSepa = 13
      DO CASE
         CASE nCan = 1
         	cSepa = "sextillon "
         	nBan = 1
         CASE nCan > 1
            cSepa = "sextillones "
            nBan = 1
      ENDCASE 
   CASE nSepa = 14
      DO CASE 
		   CASE nCan # 0 .And. nBan = 1
		      cSepa = "mil "
         CASE nCan # 0 .And. nBan = 0
				cSepa = "mil sextillones "
   	ENDCASE
   	nBan = 0
   CASE nSepa = 15
      DO CASE
         CASE nCan = 1
         	cSepa = "septillon "
         	nBan = 1
         CASE nCan > 1
            cSepa = "septillones "
            nBan = 1
      ENDCASE 
   CASE nSepa = 16
      DO CASE 
		   CASE nCan # 0 .And. nBan = 1
		      cSepa = "mil "
         CASE nCan # 0 .And. nBan = 0
				cSepa = "mil septillones "
   	ENDCASE
   	nBan = 0
   CASE nSepa = 17
      DO CASE
         CASE nCan = 1
         	cSepa = "octillon "
         	nBan = 1
         CASE nCan > 1
            cSepa = "octillones "
            nBan = 1
      ENDCASE 
   CASE nSepa = 18
      DO CASE 
		   CASE nCan # 0 .And. nBan = 1
		      cSepa = "mil "
         CASE nCan # 0 .And. nBan = 0
				cSepa = "mil octillones "
   	ENDCASE
   	nBan = 0
ENDCASE 
RETURN cSepa

*****  MONEDAS, SOLO INFORMATIVO SON MONEDAS...
* € EURO
* $ USD DOLAR ESTADOS UNIDOS
* $ AUD DOLAR AUTRALIANO
* $ CAD DOLAR CANADIENSE
* $ 	  DOLAR DE HONG KONG
* $ NZD DOLAR NEOZELANDES
* $     DOLAR BELIZE
* ¥ YEN
* $ PESO / CENTAVOS ¢
* LIBRA
* £ LIBRA ESTERLINA / PENIQUES
* BRL REAL
* FRANCO SUIZO
* CORONA SUECA
* CORONA NORUEGA
* COLON
* QUETZAL
* LEMPIRA
* CORDOBA
* PESO BOLIVIANO
* PESO ARGENTINO
* POUND
* GUARANI
* NUEVO SOL
* BOLIVAR / CENTINO