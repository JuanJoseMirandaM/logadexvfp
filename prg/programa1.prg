CLOSE DATABASES
SET CENTURY ON
SET SAFETY OFF

Use \facturacion\tabla\temp_ImpNR
zap
append from d:\2020\pruebaxxx.txt delimited with character |

**MESSAGEBOX("Datos cargados correctamente",16+0,"Error")
CLOSE DATABASES

sele 0
use c:\facturacion\tabla\temp_ImpNR alias IM

SELE 0
USE c:\facturacion\tabla\nota_remision alias NR


nreg=reccount(IM.id_nr2b)

**select * from Imp where NOT exists(select 1 from NR where NR.id_nr = Imp.id_nr2b)
**select * from Imp where exists(select 1 from NR where NR.id_nr = Imp.id_nr2b)
select IM.id_nr2b, IM.fecha, IM.numero2b, IM.Numero_NR from IM where exists(select 1 from NR where NR.id_nr = IM.id_nr2b)

if reccount(IM.id_nr2b)>0

	CLOSE DATABASES
	**Use \facturacion\tabla\nota_remision
	**append from d:\2020\pruebaxxx.txt delimited with character |
	Messagebox(STR(nreg,20))
	MESSAGEBOX("Archivo procesado correctamente",16+0,"Error")

ELSE
	
	**MESSAGEBOX("El archivo duplicaria" & STR(nreg,20) & "Notas de Remision en la base... verifique e intente nuevamente!!! ",16+0,"Error")
	Messagebox(STR(nreg,20))
	MESSAGEBOX("El archivo duplicaria Notas de Remision en la base... verifique e intente nuevamente!!! ",16+0,"Error")
	
endif 

close data
return