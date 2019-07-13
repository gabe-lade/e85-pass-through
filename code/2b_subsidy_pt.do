********************************************* 
*FUEL SUBSIDY PASS-THROUGH AND MARKET STRUCTURE
* MAIN REGRESSIONS
********************************************* 
set more off

*************************************
*TABLE 2 - LONG-RUN E85 COST PASS-THROUGH
*************************************	
*Baseline regressions
eststo clear
	
*OLS - YM and ST FE
eststo: reghdfe pe85_ret sub_e85 e85_whole, absorb(id month) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)				
	test sub_e85==1
	estadd scalar sub_pt=r(p)				
	test e85_whole==1
	estadd scalar e85_pt=r(p)
	estadd scalar pt = _b[sub_e85]
	estadd scalar pt_se = _se[sub_e85]
	estadd scalar e85=_b[e85_whole]
	estadd scalar e85_se=_se[e85_whole]
	estadd local mod "OLS"
	estadd local spec "Level"
	estadd local lag "N/A"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store A

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole, ///
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
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "No"
est store B
	 
*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole, ///
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
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store C
	
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole, ///
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
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "No"
est store D
	
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole, ///
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
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store E
	
esttab A B C D E using $output\Table2.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(LD* L2D* L3D* L4D* D*  L* sub_e85 e85_whole) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(Long-Run E85 Cost Pass-Through \label{table:res1})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note( Notes: The dependent variable is the retail E85 price (\$/gal). ///
	     The CDM columns present the cumulative dynamic multipliers for each ///
		 variable after eight weeks. H$_0$: $\beta_L^{\tau}=1$ ///
		 and H$_0$: $\beta_L^{e}=1$  present p-values from a test of ///
		 complete pass-through of the RIN subsidy and E85 wholesale costs ///
		 after eight weeks, respectively.  Standard errors are two-way ///
		 clustered at the station and year-by-month. *, **, *** denotes ///
		 significance at the 10\%, 5\%, and 1\% level.) ///
	scalars("sub_pt Subsidy PT" "e85_pt Wholesale PT" ///
	        "pt E85 Subsidy (\$/gal)" "pt_se  SE" ///
			"e85 E85 Wholesale (\$/gal)" "e85_se  SE" ///
			"n_st N (Stations)" "mod Model"	"spec Specification" ///
			"lag Lags (Weeks)" "st_fe Station FE"  "mo_fe Month FE")  ///
			 sfmt(%8.3f) mlabels((1) (2) (3) (4) (5)) collabels(none) 
	
*************************************
*TABLE 3 - LONG-RUN PASS-THROUGH AND MARKET STRUCTURE  
*************************************	
eststo clear		 
		 
*********
*Branded vs. Unbranded Stations

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret pt_sub_l8 pt_e85_l8 ///
         pt_sub_brand_l8 pt_e85_brand_l8 /// 
		 dsub_l0-dsub_l7 de85_l0-de85_l7 ///
		 dsub_brand_l0-dsub_brand_l7 ///
		 de85_brand_l0-de85_brand_l7, ///
		 absorb(id month##brand_maj) cluster(id ym)
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_sub_l8]
	estadd scalar pt_se=_se[pt_sub_l8]	
	estadd scalar ptbrand=_b[pt_sub_brand_l8]
	estadd scalar ptbrand_se=_se[pt_sub_brand_l8]	
	estadd scalar e85=_b[pt_e85_l8]
	estadd scalar e85_se=_se[pt_e85_l8]
	estadd scalar e85brand=_b[pt_e85_brand_l8]
	estadd scalar e85brand_se=_se[pt_e85_brand_l8]	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store A
		 
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_brand_l8 pt_de85_brand_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_brand_l0-d2sub_brand_l7 ///
		 d2e85_brand_l0-d2e85_brand_l7, absorb(month) cluster(id ym)
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
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store B
	
	
*********
*Major Retailers versus Other Stations	

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret pt_sub_l8 pt_e85_l8 ///
         pt_sub_retail_l8 pt_e85_retail_l8 /// 
		 dsub_l0-dsub_l7 de85_l0-de85_l7 ///
		 dsub_retail_l0-dsub_retail_l7 ///
		 de85_retail_l0-de85_retail_l7 if brand_maj==0, ///
		 absorb(id month##ret_maj) cluster(id ym)	
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_sub_l8]
	estadd scalar pt_se=_se[pt_sub_l8]	
	estadd scalar ptretail=_b[pt_sub_retail_l8]
	estadd scalar ptretail_se=_se[pt_sub_retail_l8]	
	estadd scalar e85=_b[pt_e85_l8]
	estadd scalar e85_se=_se[pt_e85_l8]
	estadd scalar e85retail=_b[pt_e85_retail_l8]
	estadd scalar e85retail_se=_se[pt_e85_retail_l8]	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store C
	
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_retail_l8 pt_de85_retail_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_retail_l0-d2sub_retail_l7 ///
		 d2e85_retail_l0-d2e85_retail_l7 if brand_maj==0, absorb(month) cluster(id ym)	
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
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store D
		
	
*********
*Stations <10 miles from competitor vs. >10 miles from competitor

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret pt_sub_l8 pt_e85_l8 ///
         pt_sub_dist10_l8 pt_e85_dist10_l8 /// 
		 dsub_l0-dsub_l7 de85_l0-de85_l7 ///
		 dsub_dist10_l0-dsub_dist10_l7 ///
		 de85_dist10_l0-de85_dist10_l7, ///
		 absorb(id month##dist10) cluster(id ym)	
	distinct id if e(sample)
	estadd scalar n_st=r(ndistinct)
	estadd scalar pt=_b[pt_sub_l8]
	estadd scalar pt_se=_se[pt_sub_l8]	
	estadd scalar ptdist10=_b[pt_sub_dist10_l8]
	estadd scalar ptdist10_se=_se[pt_sub_dist10_l8]	
	estadd scalar e85=_b[pt_e85_l8]
	estadd scalar e85_se=_se[pt_e85_l8]
	estadd scalar e85dist10=_b[pt_e85_dist10_l8]
	estadd scalar e85dist10_se=_se[pt_e85_dist10_l8]	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store E		 

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_dist10_l8 pt_de85_dist10_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_dist10_l0-d2sub_dist10_l7 ///
		 d2e85_dist10_l0-d2e85_dist10_l7, absorb(month) cluster(id ym)	
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
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store F

esttab A B C D E F using $output\Table3.tex, replace label ///
    booktabs b(a2) nonumber drop(pt* d*) ///
	starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(Long-Run E85  Pass-Through and  Market Structure \label{table:res2})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note(Notes: The dependent variable is the retail E85 price (\$/gal).  ///
	     $\times$ Branded Major is an indicator variable for whether a ///
		 station is affiliated with a large, vertically integrated oil ///
		 company.  $\times$  Major Retailer is an indicator for ///
		 whether the station is affiliated with a large, independent ///
		 gasoline retail company. $\times$  $>$ 10 mi. to Competitor is ///
		 an indicator for whether the closest competitor selling E85 is ///
		 more than 10 miles away. Standard errors are robust to ///
		 heteroskedasticity and clustering at the station and ///
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
			"mo_fe Month FE") ///
			sfmt(%8.3f)  mlabels((1) (2) (3) (4) (5) (6)) ///
			collabels(none) 
		
*************************************
*TABLE 4 - EVOLUTION OF PASS-THROUGH OVER TIME
*************************************	
eststo clear

*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if year<=2014, ///
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
	estadd local sam "'13-'14"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "No"
est store A
	
*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if year>2014, ///
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
	estadd local sam "'15-'16"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "No"
est store B
	 
*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if year<=2014, ///
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
	estadd local sam "'13-'14"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store C
	
*CDM Model - Station, Year, and Month FEs, 8 lags
eststo: reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
			l(0/7).d.e85_whole l8.e85_whole if year>2014, ///
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
	estadd local sam "'15-'16"	
	estadd local mod "CDM"
	estadd local spec "Level"
	estadd local lag "8"
	estadd local st_fe "Yes"
	estadd local mo_fe "Yes"
est store D
	
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if year<=2014, ///
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
	estadd local sam "'13-'14"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "No"
est store E
	
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if year>2014, ///
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
	estadd local sam "'15-'16"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "No"
est store F	
	
*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if year<=2014, ///
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
	estadd local sam "'13-'14"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store G

*CDM Model - First-Difference, Month FEs, 8 lags
eststo: reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole if year>2014, ///
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
	estadd local sam "'15-'16"	
	estadd local mod "CDM"
	estadd local spec "FD"
	estadd local lag "8"
	estadd local st_fe "No"
	estadd local mo_fe "Yes"
est store H
	
esttab A B C D E F G H using $output\Table4.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(LD* L2D* L3D* L4D* D*  L*) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(Long-Run E85 Cost Pass-Through: Evolution over Time  \label{table:res3})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	note(Notes: The dependent variable is the retail E85 price (\$/gal). ///
	The CDM columns present the cumulative dynamic multipliers for each ///
	variable after eight weeks. H$_0$: $\beta_L^{\tau}=1$ and H$_0$: ///
	$\beta_L^{e}=1$   present p-values from a test of complete pass-through ///
	of the RIN subsidy and E85 wholesale costs after eight weeks, ///
	respectively.  Standard errors are two-way clustered at the station ///
	and year-by-month. *, **, *** denotes significance at the 10\%, 5\%, ///
	and 1\% level.) ///
	scalars("sub_pt H$_0$: $\beta_L^{\tau^{E85}}=1$" ///
	        "e85_pt H$_0$: $\beta_L^{e^{E85}}=1$  " ///
	        "pt E85 Subsidy (\$/gal)" "pt_se  SE" ///
			"e85 E85 Wholesale (\$/gal)" "e85_se  SE" ///
			"n_st N (Stations)" "sam Sample" "mod Model"	"spec Specification" ///
			"lag Lags (Weeks)" "st_fe Station FE"  "mo_fe Month FE")  ///
			 sfmt(%8.3f) mlabels((1) (2) (3) (4) (5) (6) (7) (8)) collabels(none)
		 				