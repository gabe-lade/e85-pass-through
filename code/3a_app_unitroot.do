*************************************
*FUEL SUBSIDY PASS-THROUGH AND MARKET STRUCTURE 
* UNIT ROOT & COINTEGRATION TESTS
*************************************	
*********
*Individual Station ADF Tests
gen st=.
gen dfuller2=.
gen dfuller2_p=.
gen dfuller4=.
gen dfuller4_p=.
gen dfuller6=.
gen dfuller6_p=.

forvalues i=1/451 {
	di `i'
	capture noisily dfuller pe85_ret if id==`i', lags(2) trend
    capture noisily replace dfuller2=r(Zt) in `i'
	capture noisily replace dfuller2_p=r(p) in `i'
	
	capture noisily dfuller pe85_ret if id==`i', lags(4) trend
    capture noisily replace dfuller4=r(Zt) in `i'
	replace dfuller4_p=r(p) in `i'
	
	capture noisily dfuller pe85_ret if id==`i', lags(6) trend
    capture noisily replace dfuller6=r(Zt) in `i'
	capture noisily replace dfuller6_p=r(p) in `i'	
	
	replace st=`i' in `i'
	}
*
preserve
keep st dfuller2 dfuller2_p dfuller4 dfuller4_p dfuller6 dfuller6_p
drop if st==.

gen reject2_p1=0
	replace reject2_p1=1 if dfuller2_p<=0.01
	replace reject2_p1=. if dfuller2==.
gen reject2_p5=0
	replace reject2_p5=1 if dfuller2_p<=0.05
	replace reject2_p5=. if dfuller2==.
gen reject2_p10=0
	replace reject2_p10=1 if dfuller2_p<=0.10
	replace reject2_p10=. if dfuller2==.
gen reject4_p1=0
	replace reject4_p1=1 if dfuller4_p<=0.01
	replace reject4_p1=. if dfuller4==.
gen reject4_p5=0
	replace reject4_p5=1 if dfuller4_p<=0.05
	replace reject4_p5=. if dfuller4==.
gen reject4_p10=0
	replace reject4_p10=1 if dfuller4_p<=0.10
	replace reject4_p10=. if dfuller4==.
	
gen reject6_p1=0
	replace reject6_p1=1 if dfuller6_p<=0.01
	replace reject6_p1=. if dfuller6==.
gen reject6_p5=0
	replace reject6_p5=1 if dfuller6_p<=0.05
	replace reject6_p5=. if dfuller6==.
gen reject6_p10=0
	replace reject6_p10=1 if dfuller6_p<=0.10
	replace reject6_p10=. if dfuller6==.
	
export excel using "$output/station_unitroot_$outputdate.xlsx", ///
	firstrow(variables) replace
	
restore
drop st dfuller2 dfuller2_p dfuller4 dfuller4_p dfuller6 dfuller6_p

*********
*Individual Station Cointegration Tests
gen st=.
gen egranger2=.
gen egranger2_cv1=.
gen egranger2_cv5=.
gen egranger2_cv10=.
gen egranger4=.
gen egranger4_cv1=.
gen egranger4_cv5=.
gen egranger4_cv10=.
gen egranger6=.
gen egranger6_cv1=.
gen egranger6_cv5=.
gen egranger6_cv10=.

forvalues i=1/451 {
	di `i'
	capture noisily egranger  pe85_ret sub_e85 e85_whole if id==`i', lags(2) trend
    capture noisily replace egranger2=e(Zt) in `i'
	capture noisily replace egranger2_cv1=e(cv1) in `i'
	capture noisily replace egranger2_cv5=e(cv5) in `i'
	capture noisily replace egranger2_cv10=e(cv10) in `i'

	capture noisily egranger  pe85_ret sub_e85 e85_whole if id==`i', lags(4) trend
    capture noisily replace egranger4=e(Zt) in `i'
	capture noisily replace egranger4_cv1=e(cv1) in `i'
	capture noisily replace egranger4_cv5=e(cv5) in `i'
	capture noisily replace egranger4_cv10=e(cv10) in `i'
	
	capture noisily egranger  pe85_ret sub_e85 e85_whole if id==`i', lags(6) trend
    capture noisily replace egranger6=e(Zt) in `i'
	capture noisily replace egranger6_cv1=e(cv1) in `i'
	capture noisily replace egranger6_cv5=e(cv5) in `i'
	capture noisily replace egranger6_cv10=e(cv10) in `i'	
	
	replace st=`i' in `i'
	}
*
preserve
keep st egranger2* egranger4* egranger6*
drop if st==.

gen reject2_p1=0
	replace reject2_p1=1 if egranger2<egranger2_cv1
	replace reject2_p1=. if egranger2==.
gen reject2_p5=0
	replace reject2_p5=1 if egranger2<egranger2_cv5
	replace reject2_p5=. if egranger2==.
gen reject2_p10=0
	replace reject2_p10=1 if egranger2<egranger2_cv10
	replace reject2_p10=. if egranger2==.
	
gen reject4_p1=0
	replace reject4_p1=1 if egranger4<egranger4_cv1
	replace reject4_p1=. if egranger4==.
gen reject4_p5=0
	replace reject4_p5=1 if egranger4<egranger4_cv5
	replace reject4_p5=. if egranger4==.
gen reject4_p10=0
	replace reject4_p10=1 if egranger4<egranger4_cv10
	replace reject4_p10=. if egranger4==.

gen reject6_p1=0
	replace reject6_p1=1 if egranger6<egranger6_cv1
	replace reject6_p1=. if egranger6==.
gen reject6_p5=0
	replace reject6_p5=1 if egranger6<egranger6_cv5
	replace reject6_p5=. if egranger6==.
gen reject6_p10=0
	replace reject6_p10=1 if egranger6<egranger6_cv10
	replace reject6_p10=. if egranger6==.

export excel using "$output/station_cointegration_$outputdate.xlsx", ///
	firstrow(variables) replace
restore
drop st egranger2* egranger4* egranger6*


*Panel Unit Root Test - E85 Prices
matrix df_stat= J(12,5,.)

xtunitroot fisher pe85_ret, dfuller lags(2) trend
	matrix df_stat[1,1]=r(P)
	matrix df_stat[2,1]=r(p_P) 
xtunitroot fisher pe85_ret, dfuller lags(2) demean trend
	matrix df_stat[3,1]=r(P)
	matrix df_stat[4,1]=r(p_P) 
xtunitroot fisher pe85_ret, dfuller lags(4) trend
	matrix df_stat[5,1]=r(P)
	matrix df_stat[6,1]=r(p_P) 
xtunitroot fisher pe85_ret, dfuller lags(4) demean trend
	matrix df_stat[7,1]=r(P)
	matrix df_stat[8,1]=r(p_P) 
xtunitroot fisher pe85_ret, dfuller lags(6) trend
	matrix df_stat[9,1]=r(P)
	matrix df_stat[10,1]=r(p_P) 
xtunitroot fisher pe85_ret, dfuller lags(6) demean trend
	matrix df_stat[11,1]=r(P)
	matrix df_stat[12,1]=r(p_P) 

*Unit Root Test - E85 Subsidy
dfuller sub_e85 if id==395, lag(2) trend
	matrix df_stat[1,2]=r(Zt)
	matrix df_stat[2,2]=r(p) 
dfuller sub_e85 if id==395, lag(4) trend
	matrix df_stat[5,2]=r(Zt)
	matrix df_stat[6,2]=r(p)  
dfuller sub_e85 if id==395, lag(6) trend
	matrix df_stat[11,2]=r(Zt)
	matrix df_stat[12,2]=r(p)  
	
*Unit Root Test - E85 Wholesale Prices  
dfuller e85_whole if id==395, lag(2) trend
	matrix df_stat[1,3]=r(Zt)
	matrix df_stat[2,3]=r(p) 
dfuller e85_whole if id==395, lag(4) trend
	matrix df_stat[5,3]=r(Zt)
	matrix df_stat[6,3]=r(p)  
dfuller e85_whole if id==395, lag(6) trend
	matrix df_stat[11,3]=r(Zt)
	matrix df_stat[12,3]=r(p)   
	
*Unit Root Test - Ethanol Prices  
dfuller eth_whole_adj if id==395, lag(2) trend
	matrix df_stat[1,4]=r(Zt)
	matrix df_stat[2,4]=r(p) 
dfuller eth_whole_adj if id==395, lag(4) trend
	matrix df_stat[5,4]=r(Zt)
	matrix df_stat[6,4]=r(p)  
dfuller eth_whole_adj if id==395, lag(6) trend
	matrix df_stat[11,4]=r(Zt)
	matrix df_stat[12,4]=r(p)   
	
*Unit Root Test - Gasoline Prices  
dfuller gas_whole_adj if id==395, lag(2) trend
	matrix df_stat[1,5]=r(Zt)
	matrix df_stat[2,5]=r(p) 
dfuller gas_whole_adj if id==395, lag(4) trend
	matrix df_stat[5,5]=r(Zt)
	matrix df_stat[6,5]=r(p)  
dfuller gas_whole_adj if id==395, lag(6) trend
	matrix df_stat[11,5]=r(Zt)
	matrix df_stat[12,5]=r(p)  
outtable using $output/panel_unitroot_$outputdate, mat(df_stat) nobox replace ///
	caption("ADF Tests") format(%6.3f)
	
