*res = CodC1("7904006306693",876814,"1665979","20080519",35958.60,"zZ7Z]xssKqkEf_6K9uH(EcV+%x+u[Cca9T%+_$kiLjT8(zr3T9b5Fx2xG-D+_EBS")
*7904006306693|876814|1665979|2008/05/19|35958,6|zZ7Z]xssKqkEf_6K9uH(EcV+%x+u[Cca9T%+_$kiLjT8(zr3T9b5Fx2xG-D+_EBS|27773|7904006306693zZ787681455Z]xssKqk166597949Ef_6K9uH2008051967(EcV+%x+3595999u[Cc|15847127|ySxN|7B-F3-48-A8|
*?res
FUNCTION CodC1(cNA, nF, cNIT, dF, nM, cLD)
	LOCAL NA, NF, NIT, F, M, LD, VNF, VNIT, VF, VM, t, T, VT, p, CC, LPC, TRC4, ST, SP1, SP2, SP3, SP4, SP5, ST64, CDC

	
*NA = "30040010595"
*NF = "10015"
*NIT = "953387014"
*F = "20070825"
*M = "5726"
*LD = "33E265B43C4435sdTuyBVssD355FC4A6F46sdQWasdA)d56666fDsmp9846636B3"	
	&&?nF
	qNA = STRTRAN(cNA,' ','')
	qNF = STRTRAN(STR(INT(nF)),' ','')
	qNIT = STRTRAN(cNIT,' ','')
	qF = STRTRAN(DTOS(dF), ' ', '')
	*qF = dF 
	qM = STRTRAN(STR(INT(ROUND(nM,0))),' ','')
	qLD = STRTRAN(cLD,' ','')
	VNF = GenerarVerhoeff(qNF , 2)
	*?LEN(NIT)
	*?qNIT
	VNIT = GenerarVerhoeff(qNIT , 2)
	*?VNIT
	VF = GenerarVerhoeff(qF , 2)
	VM = GenerarVerhoeff(qM , 2)
	

	qNF = qNF + VNF
	qNIT = qNIT + VNIT
	qF = qF + VF
	qM = qM + VM


	t = VAL(qNF)+VAL(qNIT)+VAL(qF)+VAL(qM)	
	T = STR(t,30,0)
	T = LTRIM(T)
	VT = GenerarVerhoeff(T, 5)
	T = T + VT
	*?"V5 "+VT && verhoeff 5 digitos
	p = 1
	qNA = qNA + SUBSTR(qLD,p,VAL(SUBSTR(VT,1,1))+1)
	p = p + VAL(SUBSTR(VT,1,1)) + 1
	qNF = qNF + SUBSTR(qLD,p,VAL(SUBSTR(VT,2,1))+1)
	p = p + VAL(SUBSTR(VT,2,1)) + 1
	qNIT = qNIT + SUBSTR(qLD,p,VAL(SUBSTR(VT,3,1))+1)
	p = p + VAL(SUBSTR(VT,3,1)) + 1
	qF = qF + SUBSTR(qLD,p,VAL(SUBSTR(VT,4,1))+1)
	p = p + VAL(SUBSTR(VT,4,1)) + 1
	qM = qM + SUBSTR(qLD,p,VAL(SUBSTR(VT,5,1))+1)
	
	
	CC = qNA + qNF + qNIT + qF + qM
	LPC = qLD + VT
	*?CC
	*?LPC	
	TRC4 = RC4(CC , LPC)
	*?"pepe"
	*?TRC4
	TRC4 = QuitarGuion(TRC4)
	*?TRC4
	
	ST = SUMAASCII(TRC4, 1, 1)
	SP1 = SUMAASCII(TRC4, 1, 5)
	SP2 = SUMAASCII(TRC4, 2, 5)
	SP3 = SUMAASCII(TRC4, 3, 5)
	SP4 = SUMAASCII(TRC4, 4, 5)
	SP5 = SUMAASCII(TRC4, 5, 5)
	
	SP1 = INT((ST * SP1)/(VAL(SUBSTR(VT,1,1))+1))
	SP2 = INT((ST * SP2)/(VAL(SUBSTR(VT,2,1))+1))
	SP3 = INT((ST * SP3)/(VAL(SUBSTR(VT,3,1))+1))
	SP4 = INT((ST * SP4)/(VAL(SUBSTR(VT,4,1))+1))
	SP5 = INT((ST * SP5)/(VAL(SUBSTR(VT,5,1))+1))
	
	ST = SP1 + SP2 + SP3 + SP4 + SP5
	ST64 = Base64(ST)
	*?ST
	*?"64 "+ST64 
	CDC = RC4(ST64 , LPC)
	
	RETURN CDC
ENDFUNC
	
	FUNCTION Dec2Base(tnDec, tnBase)
		LOCAL lcNro, lnResto, lcChr
		IF EMPTY(tnBase)
		 tnBase = 10
		ENDIF 
		lcNro = ''
		DO WHILE tnDec > 0
		 lnResto = MOD(tnDec, tnBase)
		 tnDec = INT(tnDec / tnBase)
		 lcChr = IIF(lnResto < 10, STR(lnResto,1), CHR(lnResto+55))
		 lcNro = lcChr + lcNro
		ENDDO
	RETURN(lcNro)

	
	FUNCTION  GenerarVerhoeff( x,  n){
		s = ""
		v = ""
		FOR j=1 TO n
			v = verhoeff(x)
			x = x + v
			s = s + v
		ENDFOR
		RETURN s
	ENDFUNC 
	
	FUNCTION QuitarGuion(s)
		n = ""
		FOR i = 1 TO LEN(s)
			IF SUBSTR(s,i,1) != '-' 
			n = n + SUBSTR(s,i,1)
			ENDIF
		ENDFOR 
		RETURN n
	ENDFUNC
	
	FUNCTION SUMAASCII( S, a , n){
		t=0
		i = a
		DO WHILE i <= LEN(S)
			t = t + ASC(SUBSTR(S,i,1))	
			i = i + n
			*? t
		ENDDO 
		RETURN t
	ENDFUNC
	
	FUNCTION base64(tnDec)
	tnBase = 64	
	LOCAL lcNro, lnResto, lcChr
	DIMENSION D[64] 	
	D[1]='0'
	D[2]='1'
	D[3]='2'
	D[4]='3'
	D[5]='4'
	D[6]='5'
	D[7]='6'
	D[8]='7'
	D[9]='8'
	D[10]='9'
	D[11]='A'	
	D[12]='B'
	D[13]='C'
	D[14]='D'
	D[15]='E'
	D[16]='F'
	D[17]='G'
	D[18]='H'
	D[19]='I'
	D[20]='J'
	D[21]='K'
	D[22]='L'
	D[23]='M'
	D[24]='N'
	D[25]='O'
	D[26]='P'
	D[27]='Q'
	D[28]='R'
	D[29]='S'
	D[30]='T'
	D[31]='U'
	D[32]='V'
	D[33]='W'	
	D[34]='X'	
	D[35]='Y'
	D[36]='Z'
	D[37]='a'
	D[38]='b'
	D[39]='c'
	D[40]='d'
	D[41]='e'
	D[42]='f'
	D[43]='g'
	D[44]='h'
	D[45]='i'
	D[46]='j'
	D[47]='k'
	D[48]='l'
	D[49]='m'
	D[50]='n'
	D[51]='o'
	D[52]='p'
	D[53]='q'	
	D[54]='r'
	D[55]='s'
	D[56]='t'
	D[57]='u'
	D[58]='v'
	D[59]='w'
	D[60]='x'
	D[61]='y'
	D[62]='z'
	D[63]='+'
	D[64]='/'	
	
	lcNro = ''
	DO WHILE tnDec > 0
		lnResto = MOD(tnDec, tnBase)
 		tnDec = INT(tnDec / tnBase)
 		lcChr = D[lnResto+1]
 		lcNro = lcChr + lcNro
	ENDDO
	
	RETURN lcNro
	ENDFUNC


	FUNCTION RC4(mensaje,k)
	
	DIMENSION D[16] 
	D[1]='0'
	D[2]='1'
	D[3]='2'
	D[4]='3'
	D[5]='4'
	D[6]='5'
	D[7]='6'
	D[8]='7'
	D[9]='8'
	D[10]='9'
	D[11]='A'
	D[12]='B'	
	D[13]='C'
	D[14]='D'		
	D[15]='E'
	D[16]='F'
	
	DIMENSION state[256]
	x = 0
	y = 0	
	index1 = 0
	index2 = 0
	MensajeCifrado = ""
	
	
	FOR i=1 TO 256
		state[i] = i-1
	ENDFOR	

	FOR i=0 TO 255
		index2 = MOD((ASC( SUBSTR(k,index1+1,1)) + state[i+1] + index2),256)
		aux1 = state[i+1]
		state[i+1] = state[index2+1]
		state[index2+1] = aux1
		index1 = MOD((index1 + 1),LEN(k))	
		*?STR(index1)+" "+STR(index2)	
	ENDFOR	
	
	*?"pepe"+STR(mensaje)
	FOR i=0 TO LEN(mensaje)-1
		x = MOD((x+1),256)
		y = MOD((state[x+1] + y),256)	
		aux1 = state[x+1]	
		state[x+1] = state[y+1]	
		state[y+1] = aux1		
		NMen = BITXOR(ASC( SUBSTR(mensaje,i+1,1)),state[MOD(state[x+1] + state[y+1],256)+1])
		num = NMen
		cad = Dec2Base(num, 16)	
		IF LEN(cad)=1	
			cad = '0' + cad
		ENDIF
		
		IF LEN(cad)=0
		 	cad = "00"
		ENDIF
		MensajeCifrado = MensajeCifrado + '-' + cad
	ENDFOR
		*?MensajeCifrado
		MensajeCifrado = SUBSTR(MensajeCifrado,2,LEN(MensajeCifrado)-1)
		RETURN MensajeCifrado
	ENDFUNC


	FUNCTION verhoeff(n)

	*n = "200707020"	
	DIMENSION Mul[10,10]

	Mul[1,1]=0
	Mul[1,2]=1
	Mul[1,3]=2
	Mul[1,4]=3
	Mul[1,5]=4
	Mul[1,6]=5
	Mul[1,7]=6
	Mul[1,8]=7
	Mul[1,9]=8
	Mul[1,10]=9

	Mul[2,1]=1
	Mul[2,2]=2
	Mul[2,3]=3
	Mul[2,4]=4
	Mul[2,5]=0
	Mul[2,6]=6
	Mul[2,7]=7
	Mul[2,8]=8
	Mul[2,9]=9
	Mul[2,10]=5
	
	Mul[3,1]=2
	Mul[3,2]=3
	Mul[3,3]=4	
	Mul[3,4]=0
	Mul[3,5]=1
	Mul[3,6]=7
	Mul[3,7]=8	
	Mul[3,8]=9	
	Mul[3,9]=5
	Mul[3,10]=6

	Mul[4,1]=3
	Mul[4,2]=4
	Mul[4,3]=0
	Mul[4,4]=1	
	Mul[4,5]=2	
	Mul[4,6]=8
	Mul[4,7]=9	
	Mul[4,8]=5
	Mul[4,9]=6
	Mul[4,10]=7	

	Mul[5,1]=4
	Mul[5,2]=0	
	Mul[5,3]=1	
	Mul[5,4]=2	
	Mul[5,5]=3	
	Mul[5,6]=9	
	Mul[5,7]=5
	Mul[5,8]=6
	Mul[5,9]=7
	Mul[5,10]=8
	
	Mul[6,1]=5
	Mul[6,2]=9
	Mul[6,3]=8	
	Mul[6,4]=7
	Mul[6,5]=6
	Mul[6,6]=0
	Mul[6,7]=4
	Mul[6,8]=3
	Mul[6,9]=2
	Mul[6,10]=1
	
	Mul[7,1]=6
	Mul[7,2]=5
	Mul[7,3]=9
	Mul[7,4]=8
	Mul[7,5]=7
	Mul[7,6]=1
	Mul[7,7]=0
	Mul[7,8]=4	
	Mul[7,9]=3
	Mul[7,10]=2	

	Mul[8,1]=7	
	Mul[8,2]=6
	Mul[8,3]=5
	Mul[8,4]=9
	Mul[8,5]=8
	Mul[8,6]=2
	Mul[8,7]=1
	Mul[8,8]=0
	Mul[8,9]=4
	Mul[8,10]=3
	
	Mul[9,1]=8
	Mul[9,2]=7
	Mul[9,3]=6
	Mul[9,4]=5
	Mul[9,5]=9
	Mul[9,6]=3
	Mul[9,7]=2
	Mul[9,8]=1
	Mul[9,9]=0
	Mul[9,10]=4	

	Mul[10,1]=9
	Mul[10,2]=8
	Mul[10,3]=7
	Mul[10,4]=6
	Mul[10,5]=5	
	Mul[10,6]=4	
	Mul[10,7]=3	
	Mul[10,8]=2
	Mul[10,9]=1
	Mul[10,10]=0

	DIMENSION Per[8,10]


	Per[1,1]=0
	Per[1,2]=1
	Per[1,3]=2
	Per[1,4]=3
	Per[1,5]=4
	Per[1,6]=5
	Per[1,7]=6
	Per[1,8]=7
	Per[1,9]=8
	Per[1,10]=9
	
	Per[2,1]=1
	Per[2,2]=5
	Per[2,3]=7
	Per[2,4]=6
	Per[2,5]=2
	Per[2,6]=8
	Per[2,7]=3
	Per[2,8]=0
	Per[2,9]=9
	Per[2,10]=4

	Per[3,1]=5
	Per[3,2]=8
	Per[3,3]=0
	Per[3,4]=3
	Per[3,5]=7
	Per[3,6]=9
	Per[3,7]=6
	Per[3,8]=1
	Per[3,9]=4
	Per[3,10]=2
	
	Per[4,1]=8
	Per[4,2]=9
	Per[4,3]=1
	Per[4,4]=6
	Per[4,5]=0
	Per[4,6]=4
	Per[4,7]=3
	Per[4,8]=5
	Per[4,9]=2	
	Per[4,10]=7
	
	Per[5,1]=9	
	Per[5,2]=4	
	Per[5,3]=5
	Per[5,4]=3
	Per[5,5]=1
	Per[5,6]=2
	Per[5,7]=6
	Per[5,8]=8
	Per[5,9]=7	
	Per[5,10]=0			
	
	Per[6,1]=4
	Per[6,2]=2	
	Per[6,3]=8	
	Per[6,4]=6	
	Per[6,5]=5
	Per[6,6]=7
	Per[6,7]=3
	Per[6,8]=9
	Per[6,9]=0
	Per[6,10]=1
	
	Per[7,1]=2
	Per[7,2]=7
	Per[7,3]=9	
	Per[7,4]=3
	Per[7,5]=8
	Per[7,6]=0
	Per[7,7]=6
	Per[7,8]=4
	Per[7,9]=1
	Per[7,10]=5
	
	Per[8,1]=7
	Per[8,2]=0
	Per[8,3]=4
	Per[8,4]=6
	Per[8,5]=9
	Per[8,6]=1
	Per[8,7]=3
	Per[8,8]=2
	Per[8,9]=5
	Per[8,10]=8
	
	DIMENSION Inv[10] 
	Inv[1] = 0
	Inv[2] = 4
	Inv[3] = 3
	Inv[4] = 2	
	Inv[5] = 1
	Inv[6] = 5
	Inv[7] = 6
	Inv[8] = 7
	Inv[9] = 8
	Inv[10] = 9
	
	Check = 0
	
	NumeroInvertido="";
	
	FOR i = 1 TO LEN(n)
		NumeroInvertido = SUBSTR(n,i,1) + NumeroInvertido		
	ENDFOR

	FOR i = 0 TO LEN(NumeroInvertido)-1
		Check = Mul[Check+1,( Per[MOD((i + 1), 8)+1,VAL(SUBSTR(NumeroInvertido,i+1,1))+1] )+1]
	ENDFOR
		res = STR(Inv[Check+1],1,0)

	RETURN res
	ENDFUNC 
