**************************************************************
*FUEL SUBSIDY PASS-THROUGH AND MARKET STRUCTURE
* APPENDIX ROBUSTNESS CHECKS
**************************************************************
set more off

*************************************
*TABLE B.1 PANEL A - PASS-THROUGH AND OBSERVATIONS PER STATION
*************************************	
************
*PT by Station Observations >(<) 105 Observations (2 Years)
eststo clear

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if countit<104, ///
			absorb(id) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.e85_whole==1
	estadd scalar e85_pt=r(p)
	estadd scalar pt = _b[l8.sub_e85]
	estadd scalar pt_se = _se[l8.sub_e85]
	estadd scalar e85=_b[l8.e85_whole]
	estadd scalar e85_se=_se[l8.e85_whole]
	estadd local sam "$<$ 2 Yrs"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "No"
est store A

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if countit>=104, ///
			absorb(id) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.e85_whole==1
	estadd scalar e85_pt=r(p)
	estadd scalar pt = _b[l8.sub_e85]
	estadd scalar pt_se = _se[l8.sub_e85]
	estadd scalar e85=_b[l8.e85_whole]
	estadd scalar e85_se=_se[l8.e85_whole]
	estadd local sam "$\geq$ 2 Yrs"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "No"
est store B
 
*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if countit<104, ///
			absorb(id month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.e85_whole==1
	estadd scalar e85_pt=r(p)
	estadd scalar pt = _b[l8.sub_e85]
	estadd scalar pt_se = _se[l8.sub_e85]
	estadd scalar e85=_b[l8.e85_whole]
	estadd scalar e85_se=_se[l8.e85_whole]
	estadd local sam "$<$ 2 Yrs"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store C

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if countit>=104, ///
			absorb(id month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.e85_whole==1
	estadd scalar e85_pt=r(p)
	estadd scalar pt = _b[l8.sub_e85]
	estadd scalar pt_se = _se[l8.sub_e85]
	estadd scalar e85=_b[l8.e85_whole]
	estadd scalar e85_se=_se[l8.e85_whole]
	estadd local sam "$\geq$ 2 Yrs"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store D

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if countit<104, ///
			absorb(cons) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.d.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.d.e85_whole==1
	estadd scalar e85_pt=r(p)			
	estadd scalar pt = _b[l8D.sub_e85]
	estadd scalar pt_se = _se[l8D.sub_e85]
	estadd scalar e85=_b[l8D.e85_whole]
	estadd scalar e85_se=_se[l8D.e85_whole]
	estadd local sam "$<$ 2 Yrs"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "No"
est store E

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if countit>=104, ///
			absorb(cons) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.d.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.d.e85_whole==1
	estadd scalar e85_pt=r(p)			
	estadd scalar pt = _b[l8D.sub_e85]
	estadd scalar pt_se = _se[l8D.sub_e85]
	estadd scalar e85=_b[l8D.e85_whole]
	estadd scalar e85_se=_se[l8D.e85_whole]
	estadd local sam "$\geq$ 2 Yrs"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "No"
est store F	

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if countit<104, ///
			absorb(month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.d.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.d.e85_whole==1
	estadd scalar e85_pt=r(p)				
	estadd scalar pt = _b[l8D.sub_e85]
	estadd scalar pt_se = _se[l8D.sub_e85]
	estadd scalar e85=_b[l8D.e85_whole]
	estadd scalar e85_se=_se[l8D.e85_whole]
	estadd local sam "$<$ 2 Yrs"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store G

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if countit>=104, ///
			absorb(month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.d.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.d.e85_whole==1
	estadd scalar e85_pt=r(p)				
	estadd scalar pt = _b[l8D.sub_e85]
	estadd scalar pt_se = _se[l8D.sub_e85]
	estadd scalar e85=_b[l8D.e85_whole]
	estadd scalar e85_se=_se[l8D.e85_whole]
	estadd local sam "$\geq$ 2 Yrs"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store H

esttab A B C D E F G H using $output\TableB1PanelA.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(LD* L2D* L3D* L4D* D*  L*) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(Long-Run E85 Cost Pass-Through: Robustness  \label{table:robust1})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note(Notes: The dependent variable is the retail E85 price (\$/gal). ///
	     The CDM model columns present the cumulative dynamic multipliers ///
		 for each variable after eight weeks. H$_0$: $\beta_L^{\tau}=1$ ///
		 and H$_0$: $\beta_L^{e}=1$   present p-values from a test of ///
		 complete pass-through of the RIN subsidy and E85 wholesale costs ///
		 after eight weeks, respectively.  Standard errors are two-way ///
		 clustered at the station and year-by-month. *, **, *** denotes ///
		 significance at the 10\%, 5\%, and 1\% level.) ///
	scalars("sub_pt H$_0$: $\beta_L^{\tau^{E85}}=1$" ///
	        "e85_pt H$_0$: $\beta_L^{e^{E85}}=1$  " ///
	        "pt E85 Subsidy (\$/gal)" "pt_se  SE" ///
			"e85 E85 Wholesale (\$/gal)" "e85_se  SE" ///
			"n_st N (Stations)" "sam Sample" "mod Model"	"spec Specification" ///
			"lag Lags (Weeks)" "st_fe Station FE"  "mo_fe Month FE")  ///
			 sfmt(%8.3f) mlabels((1) (2) (3) (4) (5) (6) (7) (8)) collabels(none)
		 				
	
*************************************
*TABLE B.1 PANEL B - METROPOLITAN VS. MICROPOLITAN/RURAL AREAS
*************************************	
eststo clear

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if urban_metro==1, ///
			absorb(id) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.e85_whole==1
	estadd scalar e85_pt=r(p)
	estadd scalar pt = _b[l8.sub_e85]
	estadd scalar pt_se = _se[l8.sub_e85]
	estadd scalar e85=_b[l8.e85_whole]
	estadd scalar e85_se=_se[l8.e85_whole]
	estadd local sam "Metro"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "No"
est store A

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if urban_micro==1|rural==1, ///
			absorb(id) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.e85_whole==1
	estadd scalar e85_pt=r(p)
	estadd scalar pt = _b[l8.sub_e85]
	estadd scalar pt_se = _se[l8.sub_e85]
	estadd scalar e85=_b[l8.e85_whole]
	estadd scalar e85_se=_se[l8.e85_whole]
	estadd local sam "Micro/Rural"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "No"
est store B
 
*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if urban_metro==1, ///
			absorb(id month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.e85_whole==1
	estadd scalar e85_pt=r(p)
	estadd scalar pt = _b[l8.sub_e85]
	estadd scalar pt_se = _se[l8.sub_e85]
	estadd scalar e85=_b[l8.e85_whole]
	estadd scalar e85_se=_se[l8.e85_whole]
	estadd local sam "Metro"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store C

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if urban_micro==1|rural==1, ///
			absorb(id month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.e85_whole==1
	estadd scalar e85_pt=r(p)
	estadd scalar pt = _b[l8.sub_e85]
	estadd scalar pt_se = _se[l8.sub_e85]
	estadd scalar e85=_b[l8.e85_whole]
	estadd scalar e85_se=_se[l8.e85_whole]
	estadd local sam "Micro/Rural"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store D

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if urban_metro==1, ///
			absorb(cons) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.d.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.d.e85_whole==1
	estadd scalar e85_pt=r(p)			
	estadd scalar pt = _b[l8D.sub_e85]
	estadd scalar pt_se = _se[l8D.sub_e85]
	estadd scalar e85=_b[l8D.e85_whole]
	estadd scalar e85_se=_se[l8D.e85_whole]
	estadd local sam "Metro"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "No"
est store E
	
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if urban_micro==1|rural==1, ///
			absorb(cons) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.d.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.d.e85_whole==1
	estadd scalar e85_pt=r(p)			
	estadd scalar pt = _b[l8D.sub_e85]
	estadd scalar pt_se = _se[l8D.sub_e85]
	estadd scalar e85=_b[l8D.e85_whole]
	estadd scalar e85_se=_se[l8D.e85_whole]
	estadd local sam "Micro/Rural"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "No"
est store F	

	*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if urban_metro==1, ///
			absorb(month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.d.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.d.e85_whole==1
	estadd scalar e85_pt=r(p)				
	estadd scalar pt = _b[l8D.sub_e85]
	estadd scalar pt_se = _se[l8D.sub_e85]
	estadd scalar e85=_b[l8D.e85_whole]
	estadd scalar e85_se=_se[l8D.e85_whole]
	estadd local sam "Metro"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store G

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if urban_micro==1|rural==1, ///
			absorb(month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test l8.d.sub_e85==1
	estadd scalar sub_pt=r(p)				
	test l8.d.e85_whole==1
	estadd scalar e85_pt=r(p)				
	estadd scalar pt = _b[l8D.sub_e85]
	estadd scalar pt_se = _se[l8D.sub_e85]
	estadd scalar e85=_b[l8D.e85_whole]
	estadd scalar e85_se=_se[l8D.e85_whole]
	estadd local sam "Micro/Rural"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store H

esttab A B C D E F G H using $output\TableB1PanelB.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(LD* L2D* L3D* L4D* D*  L*) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(Long-Run E85 Cost Pass-Through: Robustness  \label{table:robust1})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note(Notes: The dependent variable is the retail E85 price (\$/gal). ///
	     The CDM model columns present the cumulative dynamic multipliers ///
		 for each variable after eight weeks. H$_0$: $\beta_L^{\tau}=1$ ///
		 and H$_0$: $\beta_L^{e}=1$   present p-values from a test of ///
		 complete pass-through of the RIN subsidy and E85 wholesale costs ///
		 after eight weeks, respectively.  Standard errors are two-way ///
		 clustered at the station and year-by-month. *, **, *** denotes ///
		 significance at the 10\%, 5\%, and 1\% level.) ///
	scalars("sub_pt H$_0$: $\beta_L^{\tau^{E85}}=1$" ///
	        "e85_pt H$_0$: $\beta_L^{e^{E85}}=1$  " ///
	        "pt E85 Subsidy (\$/gal)" "pt_se  SE" ///
			"e85 E85 Wholesale (\$/gal)" "e85_se  SE" ///
			"n_st N (Stations)" "sam Sample" "mod Model"	"spec Specification" ///
			"lag Lags (Weeks)" "st_fe Station FE"  "mo_fe Month FE")  ///
			 sfmt(%8.3f) mlabels((1) (2) (3) (4) (5) (6) (7) (8)) collabels(none)
		 					
	
*************************************
*TABLE B.2 PANEL A - PASS-THROUGH, MARKET STRUCTURE, AND OBSERVATIONS PER STATION
*************************************
eststo clear

***
*Branded vs. Unbranded Stations
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_brand_l8 pt_de85_brand_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_brand_l0-d2sub_brand_l7 ///
		 d2e85_brand_l0-d2e85_brand_l7 if countit<104, ///
		 absorb(month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptbrand=_b[pt_dsub_brand_l8]
	estadd scalar ptbrand_se=_se[pt_dsub_brand_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85brand=_b[pt_de85_brand_l8]
	estadd scalar e85brand_se=_se[pt_de85_brand_l8]	
	estadd local sam "$<$ 2 Yrs"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store A
		 
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_brand_l8 pt_de85_brand_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_brand_l0-d2sub_brand_l7 ///
		 d2e85_brand_l0-d2e85_brand_l7 if countit>=104, ///
		 absorb(month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptbrand=_b[pt_dsub_brand_l8]
	estadd scalar ptbrand_se=_se[pt_dsub_brand_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85brand=_b[pt_de85_brand_l8]
	estadd scalar e85brand_se=_se[pt_de85_brand_l8]	
	estadd local sam "$\geq$ 2 Yrs"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store B
	
***
*Major Retailers versus Other Stations	

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_retail_l8 pt_de85_retail_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_retail_l0-d2sub_retail_l7 ///
		 d2e85_retail_l0-d2e85_retail_l7 if countit<104, ///
		 absorb(month) cluster(id ym)	
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptretail=_b[pt_dsub_retail_l8]
	estadd scalar ptretail_se=_se[pt_dsub_retail_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85retail=_b[pt_de85_retail_l8]
	estadd scalar e85retail_se=_se[pt_de85_retail_l8]	
	estadd local sam "$<$ 2 Yrs"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store C
	
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_retail_l8 pt_de85_retail_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_retail_l0-d2sub_retail_l7 ///
		 d2e85_retail_l0-d2e85_retail_l7 if countit>=104, ///
		 absorb(month) cluster(id ym)	
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptretail=_b[pt_dsub_retail_l8]
	estadd scalar ptretail_se=_se[pt_dsub_retail_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85retail=_b[pt_de85_retail_l8]
	estadd scalar e85retail_se=_se[pt_de85_retail_l8]	
	estadd local sam "$\geq$ 2 Yrs"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store D
		
	
***
*Stations <10 miles from competitor vs. >10 miles from competitor

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_dist10_l8 pt_de85_dist10_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_dist10_l0-d2sub_dist10_l7 ///
		 d2e85_dist10_l0-d2e85_dist10_l7 if countit<104, ///
		 absorb(month) cluster(id ym)	
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptdist10=_b[pt_dsub_dist10_l8]
	estadd scalar ptdist10_se=_se[pt_dsub_dist10_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85dist10=_b[pt_de85_dist10_l8]
	estadd scalar e85dist10_se=_se[pt_de85_dist10_l8]		
	estadd local sam "$<$ 2 Yrs"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store E

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_dist10_l8 pt_de85_dist10_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_dist10_l0-d2sub_dist10_l7 ///
		 d2e85_dist10_l0-d2e85_dist10_l7 if countit>=104, ///
		 absorb(month) cluster(id ym)	
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptdist10=_b[pt_dsub_dist10_l8]
	estadd scalar ptdist10_se=_se[pt_dsub_dist10_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85dist10=_b[pt_de85_dist10_l8]
	estadd scalar e85dist10_se=_se[pt_de85_dist10_l8]		
	estadd local sam "$\geq$ 2 Yrs"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store F

esttab A B C D E F using $output\TableB2PanelA.tex, ///
	replace label ///
    booktabs b(a2) nonumber drop(pt* d*) ///
	starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(\caption{Long-Run E85 Pass-Through and Market Structure: ///
	Robustness \label{table:robust2}})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note(Notes: The dependent variable is the retail E85 price (\$/gal).  ///
	     All results are from a model estimated in first-differences with ///
		 month fixed effects. $\times$ Branded Major is an indicator ///
		 variable for whether a station is affiliated with a large, ///
		 vertically integrated oil company.  $\times$  Major Retailer ///
		 is an indicator for whether the station is affiliated with a large, ///
		 independent gasoline retail company. $\times$  $>$ 10 mi. to ///
		 Competitor is an indicator that equals 1 if the closest competitor ///
		 selling E85 is more than 10 miles away. Standard errors are robust ///
		 to heteroskedasticity and clustering at the station and ///
		 month-by-year level. *, **, *** denotes significance at ///
		 the 10\%, 5\%, and 1\% level.) ///
	scalars("pt E85 Subsidy (\$/gal)" "pt_se  SE" ///
	        "ptbrand $\times$ Branded Major" "ptbrand_se  SE" ///
	        "ptretail $\times$ Major Retailer" "ptretail_se  SE" ///
	        "ptdist10 $\times$ $>$ 10 mi. to Competitor" "ptdist10_se  SE" ///
			"e85 E85 Wholesale Cost (\$/gal)" "e85_se  SE" ///
	        "e85brand $\times$ Branded Major" "e85brand_se  SE" ///
	        "e85retail $\times$ Major Retailer" "e85retail_se  SE" ///
	        "e85dist10 $\times$ $>$ 10 mi. to Competitor" "e85dist10_se  SE" ///
			"n_st N (Stations)" "mod Model"	"spec Specification" ///
			"lag Lags (Weeks)" "st_fe Station FE" ///
			"mo_fe Month FE" "sam Sample") ///
			sfmt(%8.3f)  mlabels((1) (2) (3) (4) (5) (6)) ///
			collabels(none) 


*************************************
*TABLE B.2 PANEL B - PASS-THROUGH, MARKET STRUCTURE, AND METROPOLITAN VS. MICROPOLITAN
*************************************
eststo clear
 
***
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_brand_l8 pt_de85_brand_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_brand_l0-d2sub_brand_l7 ///
		 d2e85_brand_l0-d2e85_brand_l7 if urban_metro==1, ///
		 absorb(month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptbrand=_b[pt_dsub_brand_l8]
	estadd scalar ptbrand_se=_se[pt_dsub_brand_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85brand=_b[pt_de85_brand_l8]
	estadd scalar e85brand_se=_se[pt_de85_brand_l8]	
	estadd local sam "Metro"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store A
		 
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_brand_l8 pt_de85_brand_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_brand_l0-d2sub_brand_l7 ///
		 d2e85_brand_l0-d2e85_brand_l7 if urban_micro==1|rural==1, ///
		 absorb(month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptbrand=_b[pt_dsub_brand_l8]
	estadd scalar ptbrand_se=_se[pt_dsub_brand_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85brand=_b[pt_de85_brand_l8]
	estadd scalar e85brand_se=_se[pt_de85_brand_l8]	
	estadd local sam "Micro/Rural"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store B
	
	
***
*Major Retailers versus Other Stations	

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_retail_l8 pt_de85_retail_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_retail_l0-d2sub_retail_l7 ///
		 d2e85_retail_l0-d2e85_retail_l7 if urban_metro==1, ///
		 absorb(month) cluster(id ym)	
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptretail=_b[pt_dsub_retail_l8]
	estadd scalar ptretail_se=_se[pt_dsub_retail_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85retail=_b[pt_de85_retail_l8]
	estadd scalar e85retail_se=_se[pt_de85_retail_l8]	
	estadd local sam "Metro"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store C
	
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_retail_l8 pt_de85_retail_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_retail_l0-d2sub_retail_l7 ///
		 d2e85_retail_l0-d2e85_retail_l7 if urban_micro==1|rural==1, ///
		 absorb(month) cluster(id ym)	
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptretail=_b[pt_dsub_retail_l8]
	estadd scalar ptretail_se=_se[pt_dsub_retail_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85retail=_b[pt_de85_retail_l8]
	estadd scalar e85retail_se=_se[pt_de85_retail_l8]	
	estadd local sam "Micro/Rural"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store D
		
	
***
*Stations <10 miles from competitor vs. >10 miles from competitor

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_dist10_l8 pt_de85_dist10_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_dist10_l0-d2sub_dist10_l7 ///
		 d2e85_dist10_l0-d2e85_dist10_l7 if urban_metro==1, ///
		 absorb(month) cluster(id ym)	
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptdist10=_b[pt_dsub_dist10_l8]
	estadd scalar ptdist10_se=_se[pt_dsub_dist10_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85dist10=_b[pt_de85_dist10_l8]
	estadd scalar e85dist10_se=_se[pt_de85_dist10_l8]		
	estadd local sam "Metro"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store E

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_dist10_l8 pt_de85_dist10_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_dist10_l0-d2sub_dist10_l7 ///
		 d2e85_dist10_l0-d2e85_dist10_l7 if urban_micro==1|rural==1, ///
		 absorb(month) cluster(id ym)	
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_dsub_l8]
	estadd scalar pt_se=_se[pt_dsub_l8]	
	estadd scalar ptdist10=_b[pt_dsub_dist10_l8]
	estadd scalar ptdist10_se=_se[pt_dsub_dist10_l8]	
	estadd scalar e85=_b[pt_de85_l8]
	estadd scalar e85_se=_se[pt_de85_l8]
	estadd scalar e85dist10=_b[pt_de85_dist10_l8]
	estadd scalar e85dist10_se=_se[pt_de85_dist10_l8]		
	estadd local sam "Micro/Rural"		
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store F

esttab A B C D E F using $output\TableB2PanelB.tex, ///
	replace label ///
    booktabs b(a2) nonumber drop(pt* d*) ///
	starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(\caption{Long-Run E85 Pass-Through and Market Structure: ///
	Robustness \label{table:robust2}})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note(Notes: The dependent variable is the retail E85 price (\$/gal).  ///
	     All results are from a model estimated in first-differences with ///
		 month fixed effects. $\times$ Branded Major is an indicator ///
		 variable for whether a station is affiliated with a large, ///
		 vertically integrated oil company.  $\times$  Major Retailer ///
		 is an indicator for whether the station is affiliated with a large, ///
		 independent gasoline retail company. $\times$  $>$ 10 mi. to ///
		 Competitor is an indicator that equals 1 if the closest competitor ///
		 selling E85 is more than 10 miles away. Standard errors are robust ///
		 to heteroskedasticity and clustering at the station and ///
		 month-by-year level. *, **, *** denotes significance at ///
		 the 10\%, 5\%, and 1\% level.) ///
	scalars("pt E85 Subsidy (\$/gal)" "pt_se  SE" ///
	        "ptbrand $\times$ Branded Major" "ptbrand_se  SE" ///
	        "ptretail $\times$ Major Retailer" "ptretail_se  SE" ///
	        "ptdist10 $\times$ $>$ 10 mi. to Competitor" "ptdist10_se  SE" ///
			"e85 E85 Wholesale Cost (\$/gal)" "e85_se  SE" ///
	        "e85brand $\times$ Branded Major" "e85brand_se  SE" ///
	        "e85retail $\times$ Major Retailer" "e85retail_se  SE" ///
	        "e85dist10 $\times$ $>$ 10 mi. to Competitor" "e85dist10_se  SE" ///
			"n_st N (Stations)" "mod Model"	"spec Specification" ///
			"lag Lags (Weeks)" "st_fe Station FE" ///
			"mo_fe Month FE" "sam Sample") ///
			sfmt(%8.3f)  mlabels((1) (2) (3) (4) (5) (6)) ///
			collabels(none) 


*************************************
*TABLE B.3 PANEL A - INSTRUMENTAL VARIABLE, ALL ENDOGENOUS
*************************************
tab month, gen(month_)
eststo clear	

	*OLS - STATION AND MONTH FE
	eststo: xtivreg2 pe85_ret (sub_e85 e85_whole = brent ///
					 fr_13 pr_14l pr_14 ///
					 pr_1416 fr_1416 pr_17) ///
					 month_1-month_12, ///
					 partial(month_*) fe robust cluster(id ym) small
		estadd scalar pt = _b[sub_e85]
		estadd scalar pt_se = _se[sub_e85]
		estadd scalar e85=_b[e85_whole]
		estadd scalar e85_se=_se[e85_whole]
		estadd scalar fstat1 =e(widstat)
		estadd scalar fstat2 =e(cdf)
		estadd local mod "OLS"
		estadd local spec "Level"
		estadd local lag "N/A"
		estadd local st_fe "Yes"
		estadd local mo_fe "Yes"
	est store A	
	
	*CDM Model - LEVEL, STATION FE
	eststo: xtivreg2 pe85_ret (l(0/7).d.sub_e85 l8.sub_e85 ///
	        l(0/7).d.e85_whole l8.e85_whole = ///
			l(0/8).d.brent l(0/2).fr_13 l(0/2).pr_14l ///
			l(0/2).pr_14 l(0/2).pr_1416 l(0/2).fr_1416 l(0/2).pr_17), ///
			fe robust cluster(id ym) small
		estadd scalar pt = _b[l8.sub_e85]
		estadd scalar pt_se = _se[l8.sub_e85]
		estadd scalar e85=_b[l8.e85]
		estadd scalar e85_se=_se[l8.e85]
		estadd scalar fstat1 =e(widstat)
		estadd scalar fstat2 =e(cdf)
		estadd local mod "CDM"
		estadd local spec "Level"
		estadd local lag "8"
		estadd local st_fe "Yes"
		estadd local mo_fe "No"
	est store B

	*CDM Model - LEVEL, STATION AND MONTH FE 
	eststo: xtivreg2 pe85_ret (l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole = ///
			l(0/8).d.brent l(0/2).fr_13 l(0/2).pr_14l ///
			l(0/2).pr_14 l(0/2).pr_1416 l(0/2).fr_1416 l(0/2).pr_17) ///
			month_1-month_12, partial(month_*) ///
			fe robust cluster(id ym) small
 		estadd scalar pt = _b[l8.sub_e85]
		estadd scalar pt_se = _se[l8.sub_e85]
		estadd scalar e85=_b[l8.e85_whole]
		estadd scalar e85_se=_se[l8.e85_whole]
		estadd scalar fstat1 =e(widstat)
		estadd scalar fstat2 =e(cdf)
		estadd local mod "CDM"
		estadd local spec "Level"
		estadd local lag "8"
		estadd local st_fe "Yes"
		estadd local mo_fe "Yes"
	est store C
	
	*CDM Model - FIRST DIFFERENCES
	eststo:	xtivreg2 pe85_ret (l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole = ///
			l(0/8).d.brent l(0/2).fr_13 l(0/2).pr_14l l(0/2).pr_14 ///
			l(0/2).pr_1416 l(0/2).fr_1416 l(0/2).pr_17), ///
			fd robust cluster(id ym) small 
		estadd scalar pt = _b[l8d.sub_e85]
		estadd scalar pt_se = _se[l8d.sub_e85]
		estadd scalar e85=_b[l8d.e85_whole]
		estadd scalar e85_se=_se[l8d.e85_whole]
		estadd scalar fstat1 =e(widstat)
		estadd scalar fstat2 =e(cdf)
		estadd local mod "CDM"
		estadd local spec "FD"
		estadd local lag "8"
		estadd local st_fe "No"
		estadd local mo_fe "No"
	est store D

	*CDM Model - FIRST DIFFERENCES, MONTH FE
	eststo:	reghdfe d.pe85_ret (l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole = ///
			l(0/8).d2.brent l(0/2).fr_13 l(0/2).pr_14l l(0/2).pr_14 ///
			l(0/2).pr_1416 l(0/2).fr_1416 l(0/2).pr_17), ///
			absorb(month) cluster(id ym) 
		estadd scalar pt = _b[l8d.sub_e85]
		estadd scalar pt_se = _se[l8d.sub_e85]
		estadd scalar e85=_b[l8d.e85_whole]
		estadd scalar e85_se=_se[l8d.e85_whole]
		estadd scalar fstat1 =e(widstat)
		estadd scalar fstat2 =e(cdf)
		estadd local mod "CDM"
		estadd local spec "FD"
		estadd local lag "8"
		estadd local st_fe "No"
		estadd local mo_fe "Yes"
	est store E
		
esttab A B C D E using $output\TableB3PanelA.tex, replace label ///
    booktabs b(a2) nonumber drop(D* L* sub_e85 e85_whole _cons) ///
	starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title("Long-Run E85 Pass-Through: Instrumental Variables")  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note(Notes: The dependent variable is the retail E85 price (\$/gal). ///
	     The top  panel presents estimates from our IV model that assumes ///
		 all contemporaneous and lagged prices are endogenous, and the ///
		 bottom panel presents estimates from our IV model assuming only ///
		 contemporaneous prices are endogenous.  Standard errors are ///
		 robust to heteroskedasticity and are two-way clustered at the ///
		 station and year-by-month.   *, **, *** denotes significance ///
		 at the 10\%, 5\%, and 1\% level.) ///
	scalars("pt E85 Subsidy (\$/gal)" "pt_se  SE" ///
			"e85 E85 Wholesale Costs (\$/gal)" "e85_se  SE" ///
			"fstat1 Kleibergen-Paap rk Wald F statistic" ///
			"fstat2 Cragg-Donald Wald F statistic" ///
			"mod Model"	"spec Specification" ///
			"lag Lags (Weeks)" "st_fe Station FE" ///
			"mo_fe Month FE")  ///
			 sfmt(%8.3f) mlabels((1) (2) (3) (4) (5)) collabels(none) 		
				

*************************************
*TABLE B.3 PANEL B - INSTRUMENTAL VARIABLE, CONTEMPORANEOUS ENDOGENOUS
*************************************
eststo clear	

	*OLS - STATION AND MONTH FE
	eststo: xtivreg2 pe85_ret (sub_e85 e85_whole = brent ///
					 fr_13 pr_14l pr_14 ///
					 pr_1416 fr_1416 pr_17) ///
					 month_1-month_12, ///
					 partial(month_*) fe robust cluster(id ym) small
		estadd scalar pt = _b[sub_e85]
		estadd scalar pt_se = _se[sub_e85]
		estadd scalar e85=_b[e85_whole]
		estadd scalar e85_se=_se[e85_whole]
		estadd scalar fstat1 =e(widstat)
		estadd scalar fstat2 =e(cdf)
		estadd local mod "OLS"
		estadd local spec "Level"
		estadd local lag "N/A"
		estadd local st_fe "Yes"
		estadd local mo_fe "Yes"
	est store A	
	
	*CDM Model - FE 
	eststo: xtivreg2 pe85_ret (d.sub_e85 d.e85_whole =  ///
			d.brent fr_13 pr_14l pr_14 pr_1416 fr_1416 pr_17) ///
			l(1/7).d.sub_e85 l8.sub_e85 ///
	        l(1/7).d.e85_whole l8.e85_whole, ///
			fe robust cluster(id ym) small
		estadd scalar pt = _b[l8.sub_e85]
		estadd scalar pt_se = _se[l8.sub_e85]
		estadd scalar e85=_b[l8.e85_whole]
		estadd scalar e85_se=_se[l8.e85_whole]
		estadd scalar fstat1 =e(widstat)
		estadd scalar fstat2 =e(cdf)
		estadd local mod "CDM"
		estadd local spec "Level"
		estadd local lag "8"
		estadd local st_fe "Yes"
		estadd local mo_fe "No"
	est store B


	*CDM Model - FE, MONTH & YEAR FE
	eststo: xtivreg2 pe85_ret (d.sub_e85 d.e85_whole = ///
			d.brent fr_13 pr_14l pr_14 pr_1416 fr_1416 pr_17) ///
			l(1/7).d.sub_e85 l8.sub_e85  ///
			l(1/7).d.e85_whole l8.e85_whole month_1-month_12, ///
			fe partial(month_*) robust cluster(id ym) small
 		estadd scalar pt = _b[l8.sub_e85]
		estadd scalar pt_se = _se[l8.sub_e85]
		estadd scalar e85=_b[l8.e85_whole]
		estadd scalar e85_se=_se[l8.e85_whole]
		estadd scalar fstat1 =e(widstat)
		estadd scalar fstat2 =e(cdf)
		estadd local mod "CDM"
		estadd local spec "Level"
		estadd local lag "8"
		estadd local st_fe "Yes"
		estadd local mo_fe "Yes"
	est store C

	*CDM Model - FD 
	eststo:	xtivreg2 pe85_ret (d.sub_e85 d.e85_whole = ///
			d.brent fr_13 pr_14l pr_14 pr_1416 fr_1416 pr_17) ///
			l(1/7).d.sub_e85 l8.sub_e85 ///
			l(1/7).d.e85_whole l8.e85_whole, ///
			fd robust cluster(id ym) small 
		estadd scalar pt = _b[l8d.sub_e85]
		estadd scalar pt_se = _se[l8d.sub_e85]
		estadd scalar e85=_b[l8d.e85_whole]
		estadd scalar e85_se=_se[l8d.e85_whole]
		estadd scalar fstat1 =e(widstat)
		estadd scalar fstat2 =e(cdf)
		estadd local mod "CDM"
		estadd local spec "FD"
		estadd local lag "8"
		estadd local st_fe "No"
		estadd local mo_fe "No"
	est store D
			
	*CDM Model - FD, MONTH & YEAR FE
	eststo:	reghdfe d.pe85_ret l(1/7).d2.sub_e85 l8.d.sub_e85 ///
			l(1/7).d2.e85_whole l8.d.e85_whole ///
	       (d2.sub_e85 d2.e85_whole = d2.brent fr_13 ///
		    pr_14l pr_14 pr_1416 fr_1416 pr_17), absorb(month) cluster(id ym) 
		estadd scalar pt = _b[l8d.sub_e85]
		estadd scalar pt_se = _se[l8d.sub_e85]
		estadd scalar e85=_b[l8d.e85_whole]
		estadd scalar e85_se=_se[l8d.e85_whole]
		estadd scalar fstat1 =e(widstat)
		estadd scalar fstat2 =e(cdf)
		estadd local mod "CDM"
		estadd local spec "FD"
		estadd local lag "8"
		estadd local st_fe "No"
		estadd local mo_fe "Yes"
	est store E
	
esttab A B C D E using $output\TableB3PanelB.tex, replace label ///
    booktabs b(a2) nonumber drop(D* L* _cons sub_e85 e85_whole) ///
	starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title("E85 Subsidy Pass-Through: Instrumental Variables Estimation")  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note(Notes: The dependent variable is the retail E85 price (\$/gal). ///
	     The top  panel presents estimates from our IV model that assumes ///
		 all contemporaneous and lagged prices are endogenous, and the ///
		 bottom panel presents estimates from our IV model assuming only ///
		 contemporaneous prices are endogenous.  Standard errors are ///
		 robust to heteroskedasticity and are two-way clustered at the ///
		 station and year-by-month.   *, **, *** denotes significance ///
		 at the 10\%, 5\%, and 1\% level.) ///
	scalars("pt E85 Subsidy (\$/gal)" "pt_se  SE" ///
			"e85 E85 Wholesale Costs (\$/gal)" "e85_se  SE" ///
			"fstat1 Kleibergen-Paap rk Wald F statistic" ///
			"fstat2 Cragg-Donald Wald F statistic" ///
			"mod Model"	"spec Specification" ///
			"lag Lags (Weeks)" "st_fe Station FE"  ///
			"mo_fe Month FE")  ///
			 sfmt(%8.3f) mlabels((1) (2) (3) (4) (5)) collabels(none) 
			 
			 
*************************************
*FIGURE B.1 - ASYMMETRIC PASS-THROUGH
*************************************
set matsize 800
	
****
*Creating variables
gen dsub_e85_p=max(d.sub_e85,0)
gen dsub_e85_n=min(d.sub_e85,0)
	replace dsub_e85_p=. if dsub_e85_p==0 & dsub_e85_n==0
	replace dsub_e85_n=. if dsub_e85_p==. & dsub_e85_n==0
gen de85_p=max(d.e85_whole,0)
gen de85_n=min(d.e85_whole,0)
	replace de85_p=. if de85_p==0 & de85_n==0
	replace de85_n=. if de85_p==. & de85_n==0

*E85 Subsidy PT Variables
gen pt1p=.
	gen pt1p_95l=.
	gen pt1p_95u=.
gen pt1n=.
	gen pt1n_95l=.
	gen pt1n_95u=.
	
gen e85p=.
	gen e85p_95l=.
	gen e85p_95u=.
gen e85n=.
	gen e85n_95l=.
	gen e85n_95u=.
	
gen wk_shock=.	
	replace wk_shock=0 in 1
	replace wk_shock=1 in 2
	replace wk_shock=2 in 3
	replace wk_shock=3 in 4
	replace wk_shock=4 in 5
	replace wk_shock=5 in 6
	replace wk_shock=6 in 7
	replace wk_shock=7 in 8
	replace wk_shock=8 in 9
	 

****
*Estimation
*CDM Model - FD, 8 lags
reghdfe d.pe85_ret l(0/8).dsub_e85_p  l(0/8).dsub_e85_n ///
   		  l(0/8).de85_p  l(0/8).de85_n, ///
		  absorb(month) cluster(id ym)
		 
	*Positive Subsidy Shock
	replace pt1p=_b[dsub_e85_p] in 1
		replace pt1p_95l=_b[dsub_e85_p]- 1.96*_se[dsub_e85_p] in 1
		replace pt1p_95u=_b[dsub_e85_p]+ 1.96*_se[dsub_e85_p] in 1
	lincom dsub_e85_p+L1.dsub_e85_p
		replace pt1p=r(estimate) in 2
		replace pt1p_95u=r(estimate)+1.96*r(se) in 2
		replace pt1p_95l=r(estimate)-1.96*r(se) in 2
	lincom dsub_e85_p+L1.dsub_e85_p+L2.dsub_e85_p
		replace pt1p=r(estimate) in 3
		replace pt1p_95u=r(estimate)+1.96*r(se) in 3
		replace pt1p_95l=r(estimate)-1.96*r(se) in 3
	lincom dsub_e85_p+L1.dsub_e85_p+L2.dsub_e85_p+L3.dsub_e85_p
		replace pt1p=r(estimate) in 4
		replace pt1p_95u=r(estimate)+1.96*r(se) in 4
		replace pt1p_95l=r(estimate)-1.96*r(se) in 4
	lincom dsub_e85_p+L1.dsub_e85_p+L2.dsub_e85_p+L3.dsub_e85_p+L4.dsub_e85_p
		replace pt1p=r(estimate) in 5
		replace pt1p_95u=r(estimate)+1.96*r(se) in 5
		replace pt1p_95l=r(estimate)-1.96*r(se) in 5
	lincom dsub_e85_p+L1.dsub_e85_p+L2.dsub_e85_p+L3.dsub_e85_p+L4.dsub_e85_p+ ///
		   L5.dsub_e85_p
		replace pt1p=r(estimate) in 6
		replace pt1p_95u=r(estimate)+1.96*r(se) in 6
		replace pt1p_95l=r(estimate)-1.96*r(se) in 6			
	lincom dsub_e85_p+L1.dsub_e85_p+L2.dsub_e85_p+L3.dsub_e85_p+L4.dsub_e85_p+ ///
		   L5.dsub_e85_p+L6.dsub_e85_p
		replace pt1p=r(estimate) in 7
		replace pt1p_95u=r(estimate)+1.96*r(se) in 7
		replace pt1p_95l=r(estimate)-1.96*r(se) in 7	
	lincom dsub_e85_p+L1.dsub_e85_p+L2.dsub_e85_p+L3.dsub_e85_p+L4.dsub_e85_p+ ///
		   L5.dsub_e85_p+L6.dsub_e85_p+L7.dsub_e85_p
		replace pt1p=r(estimate) in 8
		replace pt1p_95u=r(estimate)+1.96*r(se) in 8
		replace pt1p_95l=r(estimate)-1.96*r(se) in 8			
	lincom dsub_e85_p+L1.dsub_e85_p+L2.dsub_e85_p+L3.dsub_e85_p+L4.dsub_e85_p+ ///
		   L5.dsub_e85_p+L6.dsub_e85_p+L7.dsub_e85_p+L8.dsub_e85_p
		replace pt1p=r(estimate) in 9
		replace pt1p_95u=r(estimate)+1.96*r(se) in 9
		replace pt1p_95l=r(estimate)-1.96*r(se) in 9			
			
	*Negative Subsidy Shock
	replace pt1n=_b[dsub_e85_n] in 1
		replace pt1n_95l=_b[dsub_e85_n]- 1.96*_se[dsub_e85_n] in 1
		replace pt1n_95u=_b[dsub_e85_n]+ 1.96*_se[dsub_e85_n] in 1
	lincom dsub_e85_n+L1.dsub_e85_n
		replace pt1n=r(estimate) in 2
		replace pt1n_95u=r(estimate)+1.96*r(se) in 2
		replace pt1n_95l=r(estimate)-1.96*r(se) in 2
	lincom dsub_e85_n+L1.dsub_e85_n+L2.dsub_e85_n
		replace pt1n=r(estimate) in 3
		replace pt1n_95u=r(estimate)+1.96*r(se) in 3
		replace pt1n_95l=r(estimate)-1.96*r(se) in 3
	lincom dsub_e85_n+L1.dsub_e85_n+L2.dsub_e85_n+L3.dsub_e85_n
		replace pt1n=r(estimate) in 4
		replace pt1n_95u=r(estimate)+1.96*r(se) in 4
		replace pt1n_95l=r(estimate)-1.96*r(se) in 4
	lincom dsub_e85_n+L1.dsub_e85_n+L2.dsub_e85_n+L3.dsub_e85_n+ ///
		   L4.dsub_e85_n
		replace pt1n=r(estimate) in 5
		replace pt1n_95u=r(estimate)+1.96*r(se) in 5
		replace pt1n_95l=r(estimate)-1.96*r(se) in 5
	lincom dsub_e85_n+L1.dsub_e85_n+L2.dsub_e85_n+L3.dsub_e85_n+ ///
		   L4.dsub_e85_n+L5.dsub_e85_n
		replace pt1n=r(estimate) in 6
		replace pt1n_95u=r(estimate)+1.96*r(se) in 6
		replace pt1n_95l=r(estimate)-1.96*r(se) in 6			
	lincom dsub_e85_n+L1.dsub_e85_n+L2.dsub_e85_n+L3.dsub_e85_n+ ///
		   L4.dsub_e85_n+L5.dsub_e85_n+L6.dsub_e85_n
		replace pt1n=r(estimate) in 7
		replace pt1n_95u=r(estimate)+1.96*r(se) in 7
		replace pt1n_95l=r(estimate)-1.96*r(se) in 7		
	lincom dsub_e85_n+L1.dsub_e85_n+L2.dsub_e85_n+L3.dsub_e85_n+ ///
		   L4.dsub_e85_n+L5.dsub_e85_n+L6.dsub_e85_n+L7.dsub_e85_n
		replace pt1n=r(estimate) in 8
		replace pt1n_95u=r(estimate)+1.96*r(se) in 8
		replace pt1n_95l=r(estimate)-1.96*r(se) in 8		
	lincom dsub_e85_n+L1.dsub_e85_n+L2.dsub_e85_n+L3.dsub_e85_n+ ///
		   L4.dsub_e85_n+L5.dsub_e85_n+L6.dsub_e85_n+L7.dsub_e85_n+L8.dsub_e85_n
		replace pt1n=r(estimate) in 9
		replace pt1n_95u=r(estimate)+1.96*r(se) in 9
		replace pt1n_95l=r(estimate)-1.96*r(se) in 9	
	
	*Positive E85 Shock
	replace e85p=_b[de85_p] in 1
		replace e85p_95l=_b[de85_p]- 1.96*_se[de85_p] in 1
		replace e85p_95u=_b[de85_p]+ 1.96*_se[de85_p] in 1
	lincom de85_p+L.de85_p
		replace e85p=r(estimate) in 2
		replace e85p_95u=r(estimate)+1.96*r(se) in 2
		replace e85p_95l=r(estimate)-1.96*r(se) in 2
	lincom de85_p+L.de85_p+L2.de85_p
		replace e85p=r(estimate) in 3
		replace e85p_95u=r(estimate)+1.96*r(se) in 3
		replace e85p_95l=r(estimate)-1.96*r(se) in 3
	lincom de85_p+L.de85_p+L2.de85_p+L3.de85_p
		replace e85p=r(estimate) in 4
		replace e85p_95u=r(estimate)+1.96*r(se) in 4
		replace e85p_95l=r(estimate)-1.96*r(se) in 4
	lincom de85_p+L.de85_p+L2.de85_p+L3.de85_p+L4.de85_p
		replace e85p=r(estimate) in 5
		replace e85p_95u=r(estimate)+1.96*r(se) in 5
		replace e85p_95l=r(estimate)-1.96*r(se) in 5
	lincom de85_p+L.de85_p+L2.de85_p+L3.de85_p+L4.de85_p+L5.de85_p
		replace e85p=r(estimate) in 6
		replace e85p_95u=r(estimate)+1.96*r(se) in 6
		replace e85p_95l=r(estimate)-1.96*r(se) in 6			
	lincom de85_p+L.de85_p+L2.de85_p+L3.de85_p+L4.de85_p+L5.de85_p+ ///
	       L6.de85_p
		replace e85p=r(estimate) in 7
		replace e85p_95u=r(estimate)+1.96*r(se) in 7
		replace e85p_95l=r(estimate)-1.96*r(se) in 7	
	lincom de85_p+L.de85_p+L2.de85_p+L3.de85_p+L4.de85_p+L5.de85_p+ ///
	       L6.de85_p+L7.de85_p
		replace e85p=r(estimate) in 8
		replace e85p_95u=r(estimate)+1.96*r(se) in 8
		replace e85p_95l=r(estimate)-1.96*r(se) in 8
	lincom de85_p+L.de85_p+L2.de85_p+L3.de85_p+L4.de85_p+L5.de85_p+ ///
	       L6.de85_p+L7.de85_p+L8.de85_p
		replace e85p=r(estimate) in 9
		replace e85p_95u=r(estimate)+1.96*r(se) in 9
		replace e85p_95l=r(estimate)-1.96*r(se) in 9

	*Negative E85 Shock
	replace e85n=_b[de85_n] in 1
		replace e85n_95l=_b[de85_n]- 1.96*_se[de85_n] in 1
		replace e85n_95u=_b[de85_n]+ 1.96*_se[de85_n] in 1
	lincom de85_n+L.de85_n
		replace e85n=r(estimate) in 2
		replace e85n_95u=r(estimate)+1.96*r(se) in 2
		replace e85n_95l=r(estimate)-1.96*r(se) in 2
	lincom de85_n+L.de85_n+L2.de85_n
		replace e85n=r(estimate) in 3
		replace e85n_95u=r(estimate)+1.96*r(se) in 3
		replace e85n_95l=r(estimate)-1.96*r(se) in 3
	lincom de85_n+L.de85_n+L2.de85_n+L3.de85_n
		replace e85n=r(estimate) in 4
		replace e85n_95u=r(estimate)+1.96*r(se) in 4
		replace e85n_95l=r(estimate)-1.96*r(se) in 4
	lincom de85_n+L.de85_n+L2.de85_n+L3.de85_n+L4.de85_n
		replace e85n=r(estimate) in 5
		replace e85n_95u=r(estimate)+1.96*r(se) in 5
		replace e85n_95l=r(estimate)-1.96*r(se) in 5
	lincom de85_n+L.de85_n+L2.de85_n+L3.de85_n+L4.de85_n+L5.de85_n
		replace e85n=r(estimate) in 6
		replace e85n_95u=r(estimate)+1.96*r(se) in 6
		replace e85n_95l=r(estimate)-1.96*r(se) in 6			
	lincom de85_n+L.de85_n+L2.de85_n+L3.de85_n+L4.de85_n+L5.de85_n+ ///
	       L6.de85_n
		replace e85n=r(estimate) in 7
		replace e85n_95u=r(estimate)+1.96*r(se) in 7
		replace e85n_95l=r(estimate)-1.96*r(se) in 7
	lincom de85_n+L.de85_n+L2.de85_n+L3.de85_n+L4.de85_n+L5.de85_n+ ///
	       L6.de85_n+L7.de85_n
		replace e85n=r(estimate) in 8
		replace e85n_95u=r(estimate)+1.96*r(se) in 8
		replace e85n_95l=r(estimate)-1.96*r(se) in 8
	lincom de85_n+L.de85_n+L2.de85_n+L3.de85_n+L4.de85_n+L5.de85_n+ ///
	       L6.de85_n+L7.de85_n+L8.de85_n
		replace e85n=r(estimate) in 9
		replace e85n_95u=r(estimate)+1.96*r(se) in 9
		replace e85n_95l=r(estimate)-1.96*r(se) in 9
	
****
*Graphing 
preserve  
drop if wk_shock==.

*Staggering
gen wk_shock1=wk_shock+0.1
gen wk_shock2=wk_shock-0.1

*E85 Subsidy PT  
twoway scatter pt1p wk_shock2, m(diamond) mc(edkblue) msize(medium) || /// 
	   rcap pt1p_95u pt1p_95l wk_shock2, lstyle(ci) lc(edkblue) || ///
	   rcap pt1n_95u pt1n_95l wk_shock1, lstyle(ci) lc(cranberry) || ///
	   scatter pt1n wk_shock1, m(triangle) mc(cranberry) msize(medium)  ///                 
	   graphregion(color(white)) bgcolor(white) ///
	   legend(order(1 "Decrease in E85 Subsidy" 4 "Increase in E85 Subsidy" ) ///
	   rows(1) region(lcolor(white))) ///
	   xtitle(Weeks After E85 Subsidy Cost Shock) ///  
	   ytitle(Pass Through ($/gal)) xlabel(0(1)8) ///
	   ylabel(0(0.5)1, nogrid)  ///
	   yline(0 0.5  1, lstyle(grid) lcolor(black*0.05))
	   graph export $figs\FigureB1a.png, width(4000) replace

*E85 PT  
twoway scatter e85p wk_shock2, m(diamond) mc(edkblue) msize(medium) || /// 
	   rcap e85p_95u e85p_95l wk_shock2, lstyle(ci) lc(edkblue) || ///
	   rcap e85n_95u e85n_95l wk_shock1, lstyle(ci) lc(cranberry) || ///
	   scatter e85n wk_shock1, m(triangle) mc(cranberry) msize(medium)  ///                 
	   graphregion(color(white)) bgcolor(white) ///
	   legend(order(1 "Increase in E85 Cost" 4 "Decrease in E85 Cost" ) ///
	   rows(1) region(lcolor(white))) ///
	   xtitle(Weeks After E85 Wholesale Cost Shock) ///  
	   ytitle(Pass Through ($/gal)) xlabel(0(1)8) ///
	   ylabel(0(0.5)1, nogrid)  ///
	   yline(0 0.5 1, lstyle(grid) lcolor(black*0.05))
	   graph export $figs\FigureB1b.png, width(4000) replace
	   
restore	   
			 