********************************************* 
*FUEL SUBSIDY PASS-THROUGH AND MARKET STRUCTURE
* RECONCILING WITH PRIOR LITERATURE
********************************************* 

********************************************* 
*KMS COMPARISON
********************************************* 
preserve
set more off
use  $clean\e85retail_daily_jaere.dta, clear
drop t

*Dropping E85 prices from IA/IL/MN for comparison and to make time variables
* consistent. 
drop if pe85_ret==.|e85_whole==.

*Replacing net E85 subsidy so that equals the net tax on E85-E10
replace sub_e85e10 = -sub_e85e10

*Seasonals as used in KMS
gen doy366 = doy(date)
forvalues i = 1/6 {
 gen s`i' = sin(`i'*2*_pi*doy366/366)
 gen c`i' = cos(`i'*2*_pi*doy366/366)
}
global savars "s1 c1 s2 c2 s3 c3 s4 c4 "

*Keeping Tuesdays as in KMS (similar results if we use weekly average prices)
gen dow=dow(date)
keep if dow==2

******************
*Regressions comparing results from two series
* KMS have data from 1/1/2013-3/9/2015 (date==20157, yw==2870)
sort date
gen t=_n //Ignoring gaps between days rather than imputing missing values
sort t
tsset t

*******************************************
*CDL Regressions using IA/IL/MN Average E85 Price
eststo clear
	
*Dep Var: E85-E10 Spread - 5 Lags, Date<=3/10/2015
eststo: newey d.spread_alt l(6).d.sub_e85e10 l(0/5).d2.sub_e85e10 $savars  if date<=20157, lag(8)
		test l6.d.sub_e85e10==1
		estadd scalar sub_pt=r(p)				
		estadd scalar pt = _b[l6.d.sub_e85e10]
		estadd scalar pt_se = _se[l6.d.sub_e85e10]
		estadd local lags "6"					//Lags
		estadd local per "KMS" //Period
	est store A

*Dep Var: E85-E10 Spread - 5 Lags 
eststo: newey d.spread_alt l(6).d.sub_e85e10 l(0/5).d2.sub_e85e10 $savars , lag(8)
		test l6.d.sub_e85e10==1
		estadd scalar sub_pt=r(p)				  
		estadd scalar pt = _b[l6.d.sub_e85e10]
		estadd scalar pt_se = _se[l6.d.sub_e85e10]
		estadd local lags "6" //Lags
		estadd local per "Full" //Period
	est store B
	
*Dep Var: E85-E10 Spread - 8 Lags 
eststo: newey d.spread_alt l(8).d.sub_e85e10 l(0/7).d2.sub_e85e10 $savars, lag(8)
		test l8.d.sub_e85e10==1
		estadd scalar sub_pt=r(p)				
		estadd scalar pt = _b[l8.d.sub_e85e10]
		estadd scalar pt_se = _se[l8.d.sub_e85e10]
		estadd local lags "8"					//Lags
		estadd local per "Full" //Period
	est store C	
		
*Dep Var: E85 Price - 5 Lag
eststo: newey d.pe85_ret l(6).d.sub_e85 l(6).d.e85_whole   ///
			   l(0/5).d2.sub_e85 l(0/5).d2.e85_whole $savars, lag(8)	
		test l6.d.sub_e85==1
		estadd scalar sub_pt=r(p)				
		test l6.d.e85_whole==1			   
		estadd scalar pt = _b[l6.d.sub_e85]
		estadd scalar pt_se = _se[l6.d.sub_e85]
		estadd scalar eth = _b[l6.d.e85_whole]
		estadd scalar eth_se = _se[l6.d.e85_whole]
		estadd local lags "6"					//Lags
		estadd local per "Full" //Period
	est store D
	
*Dep Var: E85 Price - 8 Lags
eststo: newey d.pe85_ret l(8).d.sub_e85 l(8).d.e85_whole   ///
			   l(0/7).d2.sub_e85 l(0/7)d2.e85_whole $savars, lag(8)	
		test l8.d.sub_e85==1
		estadd scalar sub_pt=r(p)				
		test l8.d.e85_whole==1
		estadd scalar e85_pt=r(p)				   
		estadd scalar pt = _b[l8.d.sub_e85]
		estadd scalar pt_se = _se[l8.d.sub_e85]
		estadd scalar eth = _b[l8.d.e85_whole]
		estadd scalar eth_se = _se[l8.d.e85_whole]
		estadd local lags "8"					//Lags
		estadd local per "Full" //Period
	est store E	
	
esttab A B C D E using $output\Table5.tex, replace label ///
    booktabs b(a2) nonumber drop(LD* D*  L* s* c*  _cons) ///
	starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(E85 Subsidy Pass-Through: Daily CDL Model )  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note(Notes: The dependent variable is either the E85-E10 price spread or ///
	     the first difference E85 price.  The table presents cumulative ///
		 pass-through estimates from a CDM model after the specified ///
		 number of weeks. The `KMS' period is 1/1/2013-3/10/2015 and ///
		 the `Full' period is 1/1/2013-6/30/2016. H$_0$: $\beta_L^{\tau}=1$  ///
		 and H$_0$: $\beta_L^{e}=1$  present p-values from a test of ///
		 complete RIN and wholesale cost pass-through, respectively.  ///
		 Standard errors are Newey-West with 6 weekly lags. All ///
		 specifications include seasonality controls as in KMS.   ///
		 *, **, and *** denotes significance at the 10\%, 5\%, and 1\% level.) ///
	scalars("sub_pt Subsidy PT" "e85_pt Wholesale PT" ///
	        "pt E85 Subsidy (\$/gal)" "pt_se  SE" ///
			"eth Ethanol (\$/gal)" "eth_se  SE" ///
			"lags Lags" "per Period") ///
			sfmt(%8.3f)  mlabels("E85-E10" ///
			"E85-E10" "E85-E10" "E85" "E85") ///
			collabels(none)  	
restore

********************************************* 
*LS COMPARISON
********************************************
preserve
*Collapsing to monthly data
collapse (mean) pe85_ret sub_e85 e85_whole ///
		 (first) state month urban_micro rural urban_metro, by(id ym)
		
xtset id ym
		
*Baseline regressions
eststo clear

	*CDM Model - Station and Month FEs, 1 lag, MN
	eststo: reghdfe d.pe85_ret l(0).d2.sub_e85 l.d.sub_e85 ///
				l(0).d2.e85_whole l.d.e85_whole if state=="MN", ///
				absorb(month) cluster(id ym)
		distinct id if e(sample)
		estadd scalar n_st=r(ndistinct)				
		test l.d.sub_e85==1
		estadd scalar sub_pt=r(p)				
		test l.d.e85_whole==1
		estadd scalar e85_pt=r(p)
		estadd scalar pt = _b[l.d.sub_e85]
		estadd scalar pt_se = _se[l.d.sub_e85]
		estadd scalar e85=_b[l.d.e85_whole]
		estadd scalar e85_se=_se[l.d.e85_whole]
		estadd local state "MN"
		estadd local sam "All"
		estadd local mod "CDM"
		estadd local spec "Level"
		estadd local lag "1"
		estadd local st_fe "Yes"
		estadd local mo_fe "Yes"
	est store A
	
	*CDM Model - Station and Month FEs, 1 lag, MN, Urban
	eststo: reghdfe d.pe85_ret l(0).d2.sub_e85 l1.d.sub_e85 ///
				l(0).d2.e85_whole l1.d.e85_whole if state=="MN" & urban_metro==1, ///
				absorb(month) cluster(id ym)
		distinct id if e(sample)
		estadd scalar n_st=r(ndistinct)				
		test l.d.sub_e85==1
		estadd scalar sub_pt=r(p)				
		test l.d.e85_whole==1
		estadd scalar e85_pt=r(p)
		estadd scalar pt = _b[l.d.sub_e85]
		estadd scalar pt_se = _se[l.d.sub_e85]
		estadd scalar e85=_b[l.d.e85_whole]
		estadd scalar e85_se=_se[l.d.e85_whole]
		estadd local state "MN"
		estadd local sam "Metro"
		estadd local mod "CDM"
		estadd local spec "Level"
		estadd local lag "1"
		estadd local st_fe "Yes"
		estadd local mo_fe "Yes"
	est store B
	
	*CDM Model - Station and Month FEs, 1 lag, MN, Rural/Micro
	eststo: reghdfe d.pe85_ret l(0).d2.sub_e85 l.d.sub_e85 ///
				l(0).d2.e85_whole l.d.e85_whole if state=="MN" & urban_metro==0, ///
				absorb(month) cluster(id ym)
		distinct id if e(sample)
		estadd scalar n_st=r(ndistinct)				
		test l.d.sub_e85==1
		estadd scalar sub_pt=r(p)				
		test l.d.e85_whole==1
		estadd scalar e85_pt=r(p)
		estadd scalar pt = _b[l.d.sub_e85]
		estadd scalar pt_se = _se[l.d.sub_e85]
		estadd scalar e85=_b[l.d.e85_whole]
		estadd scalar e85_se=_se[l.d.e85_whole]
		estadd local state "MN"
		estadd local sam "Micro/Rural"
		estadd local mod "CDM"
		estadd local spec "Level"
		estadd local lag "1"
		estadd local st_fe "Yes"
		estadd local mo_fe "Yes"
	est store C
	
	*CDM Model - Station and Month FEs, 2 lags, MN
	eststo: reghdfe d.pe85_ret l(0/1).d2.sub_e85 l2.d.sub_e85 ///
				l(0/1).d2.e85_whole l2.d.e85_whole if state=="MN", ///
				absorb(month) cluster(id ym)
		distinct id if e(sample)
		estadd scalar n_st=r(ndistinct)				
		test l2.d.sub_e85==1
		estadd scalar sub_pt=r(p)				
		test l2.d.e85_whole==1
		estadd scalar e85_pt=r(p)
		estadd scalar pt = _b[l2.d.sub_e85]
		estadd scalar pt_se = _se[l2.d.sub_e85]
		estadd scalar e85=_b[l2.d.e85_whole]
		estadd scalar e85_se=_se[l2.d.e85_whole]
		estadd local state "MN"
		estadd local sam "All"
		estadd local mod "CDM"
		estadd local spec "Level"
		estadd local lag "2"
		estadd local st_fe "Yes"
		estadd local mo_fe "Yes"
	est store D
	
	*CDM Model - Station and FEs, 1 lag, IA/IL
	eststo: reghdfe d.pe85_ret l(0).d2.sub_e85 l.d.sub_e85 ///
				l(0).d2.e85_whole l.d.e85_whole if state!="MN", ///
				absorb(month) cluster(id ym)
		distinct id if e(sample)
		estadd scalar n_st=r(ndistinct)				
		test l.d.sub_e85==1
		estadd scalar sub_pt=r(p)				
		test l.d.e85_whole==1
		estadd scalar e85_pt=r(p)
		estadd scalar pt = _b[l.d.sub_e85]
		estadd scalar pt_se = _se[l.d.sub_e85]
		estadd scalar e85=_b[l.d.e85_whole]
		estadd scalar e85_se=_se[l.d.e85_whole]
		estadd local state "IA/IL"
		estadd local sam "All"
		estadd local mod "CDM"
		estadd local spec "Level"
		estadd local lag "1"
		estadd local st_fe "Yes"
		estadd local mo_fe "Yes"
	est store E
	
	*CDM Model - Station and FEs, 1 lag, IA/IL
	eststo: reghdfe d.pe85_ret l(0/1).d2.sub_e85 l2.d.sub_e85 ///
				l(0/1).d2.e85_whole l2.d.e85_whole if state!="MN", ///
				absorb(month) cluster(id ym)
		distinct id if e(sample)
		estadd scalar n_st=r(ndistinct)				
		test l2.d.sub_e85==1
		estadd scalar sub_pt=r(p)				
		test l2.d.e85_whole==1
		estadd scalar e85_pt=r(p)
		estadd scalar pt = _b[l2.d.sub_e85]
		estadd scalar pt_se = _se[l2.d.sub_e85]
		estadd scalar e85=_b[l2.d.e85_whole]
		estadd scalar e85_se=_se[l2.d.e85_whole]
		estadd local state "IA/IL"
		estadd local sam "All"
		estadd local mod "CDM"
		estadd local spec "Level"
		estadd local lag "2"
		estadd local st_fe "Yes"
		estadd local mo_fe "Yes"
	est store F
	
esttab A B C D E F using $output\Table6.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(LD*  D*  L*) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(Long-Run E85 Cost Pass-Through \label{table:res1})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note(Notes: The dependent variable is the retail E85 price (\$/gal). ///
	     The table  presents cumulative estimated pass-through rates after ///
		 the specified number of months. H$_0$: $\beta_L^{\tau}=1$ ///
		 and H$_0$: $\beta_L^{e}=1$  present p-values from a test of ///
		 complete RIN and wholesale cost pass-through, respectively.  ///
		 Standard errors are two-way clustered at the station and ///
		 year-by-month. *, **, *** denotes significance at the ///
		 10\%, 5\%, and 1\% level.) ///
	scalars("sub_pt Subsidy PT" "e85_pt Wholesale PT" ///
	        "pt E85 Subsidy (\$/gal)" "pt_se  SE" ///
			"e85 E85 Wholesale (\$/gal)" "e85_se  SE" ///
			"n_st N (Stations)" "mod Model"	"spec Specification" ///
			"state States"  "sam Sample" ///
			"lag Lags (Months)" "st_fe Station FE"  "mo_fe Month FE")  ///
			 sfmt(%8.3f) mlabels((1) (2) (3) (4) (5) (6)) collabels(none) 
restore
