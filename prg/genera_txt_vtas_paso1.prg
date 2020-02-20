USE C:\Facturacion\tabla\conso_ventas.dbf

replace estado_fac with "C" for TIPO_FACT=3 AND TOTAL<>0
replace estado_fac with "V" for TIPO_FACT=1 AND TOTAL<>0 AND ESTADO_FACT<>"A"
replace nombre with "ANULADO" for ESTADO_FAC="A"
replace nit with "0" for ESTADO_FAC="A"
replace total with 0.00 for ESTADO_FAC="A"
replace no_iva_ice with 0.00 for ESTADO_FAC="A"
replace exporta with 0.00 for ESTADO_FAC="A"
replace sub_tota with 0.00 for ESTADO_FAC="A"
replace descuento with 0.00 for ESTADO_FAC="A"
replace importe_ne with 0.00 for ESTADO_FAC="A"
replace iva_df with 0.00 for ESTADO_FAC="A"
replace c_control with "0" for ESTADO_FAC="A"

replace C_CONTROL with "0" for TIPO_FACT=3

CLOSE all