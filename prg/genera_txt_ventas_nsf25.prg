CLOSE ALL

wkcont=0
wkcontf=1

USE C:\Facturacion\tabla\conso_ventas

do while .not. eof()

*************

SELECT * FROM C:\Facturacion\tabla\conso_ventas WHERE TIPO_FACT=4 order BY n_autoriza, n_factura INTO CURSOR c_micursor1

@ 5,50 say "Espere!!!! ............... estamos PROCESANDO 3 modulos"
@ 8,52 say "PROCESANDO AGRUPADAS...."

do while .not. eof()
	wkcont=wkcont+1
	**wkfile='standar_'+strtran(str(wkcontf,2),' ','0')+'.txt'
	**? wkfile
	set print to C:\temporal\2020mm_V_agrupadas.txt
	**set print to c:\temporal\&wkfile
	set printer on
	set devi to prin
	set console off
	scan
	**do while wkcont<100000000 and .not. eof()
	do while .not. eof()
			??5
			??'|'
			??alltrim(str(wkcont))
			??'|'
			?? fecha
			??'|'
			??subSTR(nombre,1,ATC('.',nombre)-1)
			??'|'
			??subSTR(nombre,ATC('.',nombre)+1)
			??'|'
			??alltrim(str(nvl(n_autoriza,0),17,0))
			??'|'
			??alltrim(estado_fac)
			??'|'
			??alltrim(str(nvl(total,0),12,2))
			??'|'
			??alltrim(str(nvl(no_iva_ice,0),12,2))
			??'|'
			??alltrim(str(nvl(descuento,0),12,2))
			??'|'
			??0.00
			??'|'
			??alltrim(str(nvl(importe_ne,0),12,2))
			??'|'
			??alltrim(str(nvl((importe_ne)*0.13,0),12,2))
			?
			skip
		wkcont=wkcont+1
	ENDDO
	
	endscan	
	set devi to scree
	set print off
	set print to
	set console on
	
	**wkcontf=wkcontf+1
	wkcont=0
ENDDO

@ 9,58 say "FINALIZADO PROCESO AGRUPADAS..." color RGB(255,0,0,255,255,255)

**********************
SELECT * FROM C:\Facturacion\tabla\conso_ventas WHERE TIPO_FACT=6 INTO CURSOR c_micursor2

@ 11,52 say "PROCESANDO REINTEGROS...."

do while .not. eof()
	wkcont=wkcont+1
	**wkfile='standar_'+strtran(str(wkcontf,2),' ','0')+'.txt'
	**? wkfile
	set print to c:\temporal\2020mm_V_reintegros.txt
	**set print to c:\temporal\&wkfile
	set printer on
	set devi to prin
	set console off
	scan
	**do while wkcont<100000000 and .not. eof()
	do while .not. eof()
			?? 6
			??'|'
			??alltrim(str(wkcont))
			??'|'
			?? fecha
			??'|'
			??alltrim(str(nvl(total-ice-excentos,0),12,2))
			??'|'
			??alltrim(str(nvl((total-ice-excentos)*0.13,0),12,2))
			?
			skip
		wkcont=wkcont+1
	ENDDO
	
	endscan	
	set devi to scree
	set print off
	set print to
	set console on
	
	**wkcontf=wkcontf+1
	wkcont=0
enddo
@ 12,58 say "FINALIZADO PROCESO REINTEGROS..." color RGB(255,0,0,255,255,255)

enddo
********************
SELECT * FROM C:\Facturacion\tabla\conso_ventas WHERE TIPO_FACT=7 INTO CURSOR c_micursor2

@ 14,52 say "PROCESANDO NOTAS DEBITO-CREDITO...."

do while .not. eof()
	wkcont=wkcont+1
	**wkfile='standar_'+strtran(str(wkcontf,2),' ','0')+'.txt'
	**? wkfile
	set print to c:\temporal\2020mm_V_NotasDebito.txt
	**set print to c:\temporal\&wkfile
	set printer on
	set devi to prin
	set console off
	scan
	**do while wkcont<100000000 and .not. eof()
	do while .not. eof()
			?? 7
			??'|'
			??alltrim(str(wkcont))
			??'|'
			?? fecha
			??'|'
			??alltrim(str(nvl(numero,0),17,0))
			??'|'
			??alltrim(str(nvl(autoriza,0),17,0))
			??'|'
			??alltrim(str(nvl(nit,0),17,0))
			??'|'
			??alltrim(nombre)
			??'|'
			??alltrim(str(nvl(total,0),12,2))
			??'|'
			??alltrim(str(nvl((iva),0),12,2))
			??'|'
			??alltrim(c_control)			
			??'|'
			?? nd_fecha
			??'|'
			??alltrim(str(nvl(nd_numero,0),17,0))
			??'|'
			??alltrim(str(nvl(nd_autoriz,0),17,0))
			??'|'
			??alltrim(str(nvl(nd_importe,0),12,2))
			?
			skip
		wkcont=wkcont+1
	ENDDO
	
	endscan	
	set devi to scree
	set print off
	set print to
	set console on
	
	**wkcontf=wkcontf+1
	wkcont=0
enddo
@ 15,58 say "FINALIZADO PROCESO NOTAS DEBITO CREDITO..." color RGB(255,0,0,255,255,255)

*********************
SELECT * FROM C:\Facturacion\tabla\conso_ventas WHERE TIPO_FACT=1 OR TIPO_FACT=3 order BY n_autoriza, n_factura INTO CURSOR c_micursor3

@ 17,52 say "PROCESANDO STANDAR....... ESPERE!!!"
do while .not. eof()
	wkcont=wkcont+1
	**wkfile='standar_'+strtran(str(wkcontf,2),' ','0')+'.txt'
	**? wkfile
	set print to c:\temporal\2020mm_V_estandar.txt
	**set print to c:\temporal\&wkfile
	set printer on
	set devi to prin
	set console off
	scan
	**do while wkcont<100000000 and .not. eof()
	do while .not. eof()
			?? 3
			??'|'
			??alltrim(str(wkcont))
			??'|'
			?? fecha
			??'|'
			??alltrim(str(nvl(n_factura,0),17,0))
			??'|'
			??alltrim(n_autoriza)
			??'|'
			??alltrim(estado_fac)
			??'|'
			??alltrim(nit)
			??'|'
			??alltrim(nombre)
			??'|'
			??alltrim(str(nvl(total,0),12,2))
			??'|'
			??alltrim(str(nvl(no_iva_ice,0),12,2))
			??'|'
			?? 0.00
			??'|'
			?? 0.00
			??'|'
			??alltrim(str(nvl(sub_tota,0),12,2))
			??'|'
			??alltrim(str(nvl(descuento,0),12,2))
			??'|'
			??alltrim(str(nvl(importe_ne,0),12,2))
			??'|'
			??alltrim(str(nvl((importe_ne)*0.13,0),12,2))
			??'|'
			??alltrim(c_control)
			?
			skip
		wkcont=wkcont+1
	ENDDO
	
	endscan	
	set devi to scree
	set print off
	set print to
	set console on
	
	**wkcontf=wkcontf+1
	wkcont=0
enddo
@ 18,58 say "FINALIZADO PROCESO STANDAR" color RGB(255,0,0,255,255,255)

RETURN
**clear
**close all
CLOSE DATABASES