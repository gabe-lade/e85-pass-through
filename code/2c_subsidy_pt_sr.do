********************************************* 
*FUEL SUBSIDY PASS-THROUGH AND MARKET STRUCTURE
* MAIN FIGURES
********************************************* 
set more off

*************************************
*FIGURE 4 - MAIN SUBSITY PASS-THROUGH GRAPHS
*************************************
gen wk_shock=.
label var wk_shock "Week Since Shock"

*E85 Subsidy PT Variables
gen pt1=.
	gen pt1_95l=.
	gen pt1_95u=.
	label var pt1 "Levels"
gen pt2=.
	gen pt2_95l=.
	gen pt2_95u=.
	label var pt2 "First Dif"
	
*E85 Wholesale PT Variables
gen e85_pt1=.
	gen e85_pt1_95l=.
	gen e85_pt1_95u=.
	label var e85_pt1 "Levels"
gen e85_pt2=.
	gen e85_pt2_95l=.
	gen e85_pt2_95u=.
	label var e85_pt2 "First Dif"

********
*CDM Model - Station, Year-Month FEs, 8 lags
reghdfe pe85_ret l(0/7).d.sub_e85 l8.sub_e85 ///
				l(0/7).d.e85_whole l8.e85_whole, ///
				absorb(id month) cluster(id ym)				

	*Week 0
	replace wk_shock=0 in 1
	replace pt1=_b[D1.sub_e85]   in 1
	replace pt1_95l=_b[D1.sub_e85]-1.96*_se[D1.sub_e85] in 1
	replace pt1_95u=_b[D1.sub_e85]+1.96*_se[D1.sub_e85] in 1
	replace e85_pt1=_b[D1.e85_whole]   in 1
	replace e85_pt1_95l=_b[D1.e85_whole]-1.96*_se[D1.e85_whole] in 1
	replace e85_pt1_95u=_b[D1.e85_whole]+1.96*_se[D1.e85_whole] in 1
	
	*Week 1
	replace wk_shock=1 in 2
	replace pt1=_b[LD.sub_e85] in 2
	replace pt1_95l=_b[LD.sub_e85]-1.96*_se[LD.sub_e85] in 2
	replace pt1_95u=_b[LD.sub_e85]+1.96*_se[LD.sub_e85] in 2
	replace e85_pt1=_b[LD.e85_whole]   in 2
	replace e85_pt1_95l=_b[LD.e85_whole]-1.96*_se[LD.e85_whole] in 2
	replace e85_pt1_95u=_b[LD.e85_whole]+1.96*_se[LD.e85_whole] in 2
	
	*Week 2
	replace wk_shock=2 in 3
	replace pt1=_b[L2D.sub_e85] in 3
	replace pt1_95l=_b[L2D.sub_e85]-1.96*_se[L2D.sub_e85] in 3
	replace pt1_95u=_b[L2D.sub_e85]+1.96*_se[L2D.sub_e85] in 3
	replace e85_pt1=_b[L2D.e85_whole]   in 3
	replace e85_pt1_95l=_b[L2D.e85_whole]-1.96*_se[L2D.e85_whole] in 3
	replace e85_pt1_95u=_b[L2D.e85_whole]+1.96*_se[L2D.e85_whole] in 3
	
	*Week 3
	replace wk_shock=3 in 4
	replace pt1=_b[L3D.sub_e85] in 4
	replace pt1_95l=_b[L3D.sub_e85]-1.96*_se[L3D.sub_e85] in 4
	replace pt1_95u=_b[L3D.sub_e85]+1.96*_se[L3D.sub_e85] in 4
	replace e85_pt1=_b[L3D.e85_whole]   in 4
	replace e85_pt1_95l=_b[L3D.e85_whole]-1.96*_se[L3D.e85_whole] in 4
	replace e85_pt1_95u=_b[L3D.e85_whole]+1.96*_se[L3D.e85_whole] in 4
	
	*Week 4
	replace wk_shock=4 in 5
	replace pt1=_b[L4D.sub_e85] in 5
	replace pt1_95l=_b[L4D.sub_e85]-1.96*_se[L4D.sub_e85] in 5
	replace pt1_95u=_b[L4D.sub_e85]+1.96*_se[L4D.sub_e85] in 5
	replace e85_pt1=_b[L4D.e85_whole]   in 5
	replace e85_pt1_95l=_b[L4D.e85_whole]-1.96*_se[L4D.e85_whole] in 5
	replace e85_pt1_95u=_b[L4D.e85_whole]+1.96*_se[L4D.e85_whole] in 5
	
	*Week 5
	replace wk_shock=5 in 6
	replace pt1=_b[L5D.sub_e85] in 6
	replace pt1_95l=_b[L5D.sub_e85]-1.96*_se[L5D.sub_e85] in 6
	replace pt1_95u=_b[L5D.sub_e85]+1.96*_se[L5D.sub_e85] in 6
	replace e85_pt1=_b[L5D.e85_whole]   in 6
	replace e85_pt1_95l=_b[L5D.e85_whole]-1.96*_se[L5D.e85_whole] in 6
	replace e85_pt1_95u=_b[L5D.e85_whole]+1.96*_se[L5D.e85_whole] in 6
	
	*Week 6
	replace wk_shock=6 in 7
	replace pt1=_b[L6D.sub_e85] in 7
	replace pt1_95l=_b[L6D.sub_e85]-1.96*_se[L6D.sub_e85] in 7
	replace pt1_95u=_b[L6D.sub_e85]+1.96*_se[L6D.sub_e85] in 7
	replace e85_pt1=_b[L6D.e85_whole]   in 7
	replace e85_pt1_95l=_b[L6D.e85_whole]-1.96*_se[L6D.e85_whole] in 7
	replace e85_pt1_95u=_b[L6D.e85_whole]+1.96*_se[L6D.e85_whole] in 7	
	
	*Week 7
	replace wk_shock=7 in 8
	replace pt1=_b[L7D.sub_e85] in 8
	replace pt1_95l=_b[L7D.sub_e85]-1.96*_se[L7D.sub_e85] in 8
	replace pt1_95u=_b[L7D.sub_e85]+1.96*_se[L7D.sub_e85] in 8
	replace e85_pt1=_b[L7D.e85_whole]   in 8
	replace e85_pt1_95l=_b[L7D.e85_whole]-1.96*_se[L7D.e85_whole] in 8
	replace e85_pt1_95u=_b[L7D.e85_whole]+1.96*_se[L7D.e85_whole] in 8
	
	*Week 8
	replace wk_shock=8 in 9
	replace pt1=_b[L8.sub_e85] in 9
	replace pt1_95l=_b[L8.sub_e85]-1.96*_se[L8.sub_e85] in 9
	replace pt1_95u=_b[L8.sub_e85]+1.96*_se[L8.sub_e85] in 9
	replace e85_pt1=_b[L8.e85_whole]   in 9
	replace e85_pt1_95l=_b[L8.e85_whole]-1.96*_se[L8.e85_whole] in 9
	replace e85_pt1_95u=_b[L8.e85_whole]+1.96*_se[L8.e85_whole] in 9

********
*CDM Model - First-Difference, Month FEs, 8 lags
reghdfe d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
			l(0/7).d2.e85_whole l8.d.e85_whole, ///
			absorb(month) cluster(id ym)
	
	*Week 0
	replace pt2=_b[D2.sub_e85]   in 1
	replace pt2_95l=_b[D2.sub_e85]-1.96*_se[D2.sub_e85] in 1
	replace pt2_95u=_b[D2.sub_e85]+1.96*_se[D2.sub_e85] in 1
	replace e85_pt2=_b[D2.e85_whole]   in 1
	replace e85_pt2_95l=_b[D2.e85_whole]-1.96*_se[D2.e85_whole] in 1
	replace e85_pt2_95u=_b[D2.e85_whole]+1.96*_se[D2.e85_whole] in 1
	
	*Week 1
	replace pt2=_b[LD2.sub_e85] in 2
	replace pt2_95l=_b[LD2.sub_e85]-1.96*_se[LD2.sub_e85] in 2
	replace pt2_95u=_b[LD2.sub_e85]+1.96*_se[LD2.sub_e85] in 2
	replace e85_pt2=_b[LD2.e85_whole]   in 2
	replace e85_pt2_95l=_b[LD2.e85_whole]-1.96*_se[LD2.e85_whole] in 2
	replace e85_pt2_95u=_b[LD2.e85_whole]+1.96*_se[LD2.e85_whole] in 2
	
	*Week 2
	replace pt2=_b[L2D2.sub_e85] in 3
	replace pt2_95l=_b[L2D2.sub_e85]-1.96*_se[L2D2.sub_e85] in 3
	replace pt2_95u=_b[L2D2.sub_e85]+1.96*_se[L2D2.sub_e85] in 3
	replace e85_pt2=_b[L2D2.e85_whole]   in 3
	replace e85_pt2_95l=_b[L2D2.e85_whole]-1.96*_se[L2D2.e85_whole] in 3
	replace e85_pt2_95u=_b[L2D2.e85_whole]+1.96*_se[L2D2.e85_whole] in 3
	
	*Week 3
	replace pt2=_b[L3D2.sub_e85] in 4
	replace pt2_95l=_b[L3D2.sub_e85]-1.96*_se[L3D2.sub_e85] in 4
	replace pt2_95u=_b[L3D2.sub_e85]+1.96*_se[L3D2.sub_e85] in 4
	replace e85_pt2=_b[L3D2.e85_whole]   in 4
	replace e85_pt2_95l=_b[L3D2.e85_whole]-1.96*_se[L3D2.e85_whole] in 4
	replace e85_pt2_95u=_b[L3D2.e85_whole]+1.96*_se[L3D2.e85_whole] in 4
	
	*Week 4
	replace pt2=_b[L4D2.sub_e85] in 5
	replace pt2_95l=_b[L4D2.sub_e85]-1.96*_se[L4D2.sub_e85] in 5
	replace pt2_95u=_b[L4D2.sub_e85]+1.96*_se[L4D2.sub_e85] in 5
	replace e85_pt2=_b[L4D2.e85_whole]   in 5
	replace e85_pt2_95l=_b[L4D2.e85_whole]-1.96*_se[L4D2.e85_whole] in 5
	replace e85_pt2_95u=_b[L4D2.e85_whole]+1.96*_se[L4D2.e85_whole] in 5
	
	*Week 5
	replace pt2=_b[L5D2.sub_e85] in 6
	replace pt2_95l=_b[L5D2.sub_e85]-1.96*_se[L5D2.sub_e85] in 6
	replace pt2_95u=_b[L5D2.sub_e85]+1.96*_se[L5D2.sub_e85] in 6
	replace e85_pt2=_b[L5D2.e85_whole]   in 6
	replace e85_pt2_95l=_b[L5D2.e85_whole]-1.96*_se[L5D2.e85_whole] in 6
	replace e85_pt2_95u=_b[L5D2.e85_whole]+1.96*_se[L5D2.e85_whole] in 6
	
	*Week 6
	replace pt2=_b[L6D2.sub_e85] in 7
	replace pt2_95l=_b[L6D2.sub_e85]-1.96*_se[L6D2.sub_e85] in 7
	replace pt2_95u=_b[L6D2.sub_e85]+1.96*_se[L6D2.sub_e85] in 7
	replace e85_pt2=_b[L6D2.e85_whole]   in 7
	replace e85_pt2_95l=_b[L6D2.e85_whole]-1.96*_se[L6D2.e85_whole] in 7
	replace e85_pt2_95u=_b[L6D2.e85_whole]+1.96*_se[L6D2.e85_whole] in 7
	
	*Week 7
	replace pt2=_b[L7D2.sub_e85] in 8
	replace pt2_95l=_b[L7D2.sub_e85]-1.96*_se[L7D2.sub_e85] in 8
	replace pt2_95u=_b[L7D2.sub_e85]+1.96*_se[L7D2.sub_e85] in 8
	replace e85_pt2=_b[L7D2.e85_whole]   in 8
	replace e85_pt2_95l=_b[L7D2.e85_whole]-1.96*_se[L7D2.e85_whole] in 8
	replace e85_pt2_95u=_b[L7D2.e85_whole]+1.96*_se[L7D2.e85_whole] in 8
	
	*Week 8
	replace pt2=_b[L8D.sub_e85] in 9
	replace pt2_95l=_b[L8D.sub_e85]-1.96*_se[L8D.sub_e85] in 9
	replace pt2_95u=_b[L8D.sub_e85]+1.96*_se[L8D.sub_e85] in 9
	replace e85_pt2=_b[L8D.e85_whole] in 9
	replace e85_pt2_95l=_b[L8D.e85_whole]-1.96*_se[L8D.e85_whole] in 9
	replace e85_pt2_95u=_b[L8D.e85_whole]+1.96*_se[L8D.e85_whole] in 9

********
*Graphing Baseline Dynamic PT Estimates
preserve  
keep wk_shock pt1* pt2* e85_pt1* e85_pt2*
drop if wk_shock==.

*Staggering
gen wk_shock1=wk_shock+0.1
gen wk_shock2=wk_shock-0.1

*E85 Subsidy PT
twoway scatter pt1 wk_shock2, m(diamond) mc(edkblue) msize(medlarge) || /// 
	   rcap pt1_95u pt1_95l wk_shock2, lstyle(ci) lc(edkblue) || ///
	   rcap pt2_95u pt2_95l wk_shock1, lstyle(ci) lc(cranberry) || ///
	   scatter pt2 wk_shock1, m(triangle) mc(cranberry) msize(medlarge)  ///                 
	   graphregion(color(white)) bgcolor(white) ///
	   legend(order(1 "Levels" 4 "First Differences" ) ///
	   rows(1) region(lcolor(white))) ///
	   xtitle(Weeks After E85 Subsidy Cost Shock) ///  
	   ytitle(Pass Through ($/gal)) xlabel(0(1)8, nogrid) ///
	   ylabel(0(0.5)1, nogrid)  ///
	   yline(0 0.5  1, lstyle(grid) lcolor(black*0.05))
	   graph export $figs\Figure4a.png, width(4000) replace

*E85 Wholesale PT
twoway scatter e85_pt1 wk_shock2, m(diamond) mc(edkblue) msize(medlarge) || /// 
	   rcap e85_pt1_95u e85_pt1_95l wk_shock2, lstyle(ci) lc(edkblue) || ///
	   rcap e85_pt2_95u e85_pt2_95l wk_shock1, lstyle(ci) lc(cranberry) || ///
	   scatter e85_pt2 wk_shock1, m(triangle) mc(cranberry) msize(medlarge)  ///                 
	   graphregion(color(white)) bgcolor(white) ///
	   legend(order(1 "Levels" 4 "First Differences" ) ///
	   rows(1) region(lcolor(white))) ///
	   xtitle(Weeks After E85 Wholesale Cost Shock) ///  
	   ytitle(Pass Through ($/gal)) xlabel(0(1)8) ///
	   ylabel(0(0.5)1, nogrid)  ///
	   yline(0 0.5 1, lstyle(grid) lcolor(black*0.05))
	   graph export $figs\Figure4b.png, width(4000) replace
restore
drop pt1* pt2* e85_pt1* e85_pt2* 
      
	 
*************************************
*FIGURE 5 - SUBSIDY PASS-THROUGH AT BRANDED/UNBRANDED STATIONS
*************************************
	 
*E85 Subsidy PT Variables
* - Notes: Graphing for both level and first differences specifications
gen pt1=.
	gen pt1_95l=.
	gen pt1_95u=.
	label var pt1 "Unbranded"
gen pt1_brand=.
	gen pt1_brand_95l=.
	gen pt1_brand_95u=.
	label var pt1_brand "Branded"
	
*CDM Model - FD by Branded and Unbranded Stations
reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8  ///
         pt_dsub_brand_l8 pt_de85_brand_l8  /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7  ///
		 d2sub_brand_l0-d2sub_brand_l7 ///
		 d2e85_brand_l0-d2e85_brand_l7, absorb(month) cluster(id ym)
	
	*Week 0 - Non-Branded
	replace pt1=_b[d2sub_l0]   in 1
	replace pt1_95l=_b[d2sub_l0]-1.96*_se[d2sub_l0] in 1
	replace pt1_95u=_b[d2sub_l0]+1.96*_se[d2sub_l0] in 1
	
	*Week 0 - Branded
	lincom d2sub_l0+d2sub_brand_l0
		replace pt1_brand=r(estimate)   in 1
		replace pt1_brand_95l=r(estimate)-1.96*r(se) in 1
		replace pt1_brand_95u=r(estimate)+1.96*r(se) in 1
	
	*Week 1 - Non-Branded
	replace pt1=_b[d2sub_l1]   in 2
	replace pt1_95l=_b[d2sub_l1]-1.96*_se[d2sub_l1] in 2
	replace pt1_95u=_b[d2sub_l1]+1.96*_se[d2sub_l1] in 2
	
	*Week 1 - Branded
	lincom d2sub_l1+d2sub_brand_l1
		replace pt1_brand=r(estimate)   in 2
		replace pt1_brand_95l=r(estimate)-1.96*r(se) in 2
		replace pt1_brand_95u=r(estimate)+1.96*r(se) in 2
		
	*Week 2 - Non-Branded
	replace pt1=_b[d2sub_l2]   in 3
	replace pt1_95l=_b[d2sub_l2]-1.96*_se[d2sub_l2] in 3
	replace pt1_95u=_b[d2sub_l2]+1.96*_se[d2sub_l2] in 3
	
	*Week 2 - Branded
	lincom d2sub_l2+d2sub_brand_l2
		replace pt1_brand=r(estimate)   in 3
		replace pt1_brand_95l=r(estimate)-1.96*r(se) in 3
		replace pt1_brand_95u=r(estimate)+1.96*r(se) in 3
		
	*Week 3 - Non-Branded
	replace pt1=_b[d2sub_l3]   in 4
	replace pt1_95l=_b[d2sub_l3]-1.96*_se[d2sub_l3] in 4
	replace pt1_95u=_b[d2sub_l3]+1.96*_se[d2sub_l3] in 4
	
	*Week 3 - Branded
	lincom d2sub_l3+d2sub_brand_l3
		replace pt1_brand=r(estimate)   in 4
		replace pt1_brand_95l=r(estimate)-1.96*r(se) in 4
		replace pt1_brand_95u=r(estimate)+1.96*r(se) in 4
		
	*Week 4 - Non-Branded
	replace pt1=_b[d2sub_l4]   in 5
	replace pt1_95l=_b[d2sub_l4]-1.96*_se[d2sub_l4] in 5
	replace pt1_95u=_b[d2sub_l4]+1.96*_se[d2sub_l4] in 5
	
	*Week 4 - Branded
	lincom d2sub_l4+d2sub_brand_l4
		replace pt1_brand=r(estimate)   in 5
		replace pt1_brand_95l=r(estimate)-1.96*r(se) in 5
		replace pt1_brand_95u=r(estimate)+1.96*r(se) in 5
		
	*Week 5 - Non-Branded
	replace pt1=_b[d2sub_l5]   in 6
	replace pt1_95l=_b[d2sub_l5]-1.96*_se[d2sub_l5] in 6
	replace pt1_95u=_b[d2sub_l5]+1.96*_se[d2sub_l5] in 6
	
	*Week 5 - Branded
	lincom d2sub_l5+d2sub_brand_l5
		replace pt1_brand=r(estimate)   in 6
		replace pt1_brand_95l=r(estimate)-1.96*r(se) in 6
		replace pt1_brand_95u=r(estimate)+1.96*r(se) in 6
		
	*Week 6 - Non-Branded
	replace pt1=_b[d2sub_l6]   in 7
	replace pt1_95l=_b[d2sub_l6]-1.96*_se[d2sub_l6] in 7
	replace pt1_95u=_b[d2sub_l6]+1.96*_se[d2sub_l6] in 7
	
	*Week 6 - Branded
	lincom d2sub_l6+d2sub_brand_l6
		replace pt1_brand=r(estimate)   in 7
		replace pt1_brand_95l=r(estimate)-1.96*r(se) in 7
		replace pt1_brand_95u=r(estimate)+1.96*r(se) in 7
		
	*Week 7 - Non-Branded
	replace pt1=_b[d2sub_l7]   in 8
	replace pt1_95l=_b[d2sub_l7]-1.96*_se[d2sub_l7] in 8
	replace pt1_95u=_b[d2sub_l7]+1.96*_se[d2sub_l7] in 8
	
	*Week 7 - Branded
	lincom d2sub_l7+d2sub_brand_l7
		replace pt1_brand=r(estimate)   in 8
		replace pt1_brand_95l=r(estimate)-1.96*r(se) in 8
		replace pt1_brand_95u=r(estimate)+1.96*r(se) in 8
		
	*Week 8 - Non-Branded
	replace pt1=_b[pt_dsub_l8]   in 9
	replace pt1_95l=_b[pt_dsub_l8]-1.96*_se[pt_dsub_l8] in 9
	replace pt1_95u=_b[pt_dsub_l8]+1.96*_se[pt_dsub_l8] in 9
	
	*Week 8 - Branded
	lincom pt_dsub_l8+pt_dsub_brand_l8
		replace pt1_brand=r(estimate)   in 9
		replace pt1_brand_95l=r(estimate)-1.96*r(se) in 9
		replace pt1_brand_95u=r(estimate)+1.96*r(se) in 9	
		
		
*********
*Graphing
preserve
keep wk_shock pt1 pt1_95l pt1_95u pt1_brand pt1_brand_95l pt1_brand_95u ///
	
drop if wk_shock==.

*Staggering
gen wk_shock1=wk_shock-0.1
replace wk_shock=wk_shock+0.1

*E85 Subsidy PT
twoway scatter pt1 wk_shock1, m(diamond) mc(edkblue) msize(medlarge) || ///
	   rcap pt1_95u pt1_95l wk_shock1, lstyle(ci) lc(edkblue) || ///
       scatter pt1_brand wk_shock, m(triangle) mc(cranberry) msize(medlarge) || /// 
	   rcap pt1_brand_95u pt1_brand_95l wk_shock, lstyle(ci) lc(cranberry) ///                 
	   graphregion(color(white)) bgcolor(white) ///
	   legend(order(1 "Unbranded Stations"  ///
	    3 "Branded Stations") ///
	   rows(1) region(lcolor(white))) ///
	   xtitle(Weeks After E85 Subsidy Cost Shock) ///  
	   ytitle(Pass Through ($/gal)) xlabel(0(1)8) ///
	   ylabel(0(0.5)1, nogrid)  ///
	   yline(0 0.5 1, lstyle(grid) lcolor(black*0.05))
	graph export $figs\Figure5a.png, width(4000) replace

restore
drop pt1 pt1_95l pt1_95u pt1_brand pt1_brand_95l pt1_brand_95u 
	 
	 
*************************************
* SR Subsidy PT & Market Power - CDM Model, Stations >10 Miles from Others
************************************* 
*E85 Subsidy PT Variables
gen pt1=.
	gen pt1_95l=.
	gen pt1_95u=.
gen pt1_dist10=.
	gen pt1_dist10_95l=.
	gen pt1_dist10_95u=.
	
*CDM Model - FD with Stations >10 Miles from Other Stations
reghdfe d.pe85_ret pt_dsub_l8 pt_de85_l8 ///
         pt_dsub_dist10_l8 pt_de85_dist10_l8 /// 
		 d2sub_l0-d2sub_l7 d2e85_l0-d2e85_l7 ///
		 d2sub_dist10_l0-d2sub_dist10_l7 ///
		 d2e85_dist10_l0-d2e85_dist10_l7, absorb(month) cluster(id ym)	
		 
	*Week 0 - <10 Miles
	replace pt1=_b[d2sub_l0]   in 1
	replace pt1_95l=_b[d2sub_l0]-1.96*_se[d2sub_l0] in 1
	replace pt1_95u=_b[d2sub_l0]+1.96*_se[d2sub_l0] in 1
	
	*Week 0 - >10 Miles
	lincom d2sub_l0+d2sub_dist10_l0
		replace pt1_dist10=r(estimate)   in 1
		replace pt1_dist10_95l=r(estimate)-1.96*r(se) in 1
		replace pt1_dist10_95u=r(estimate)+1.96*r(se) in 1
	
	*Week 1 - <10 Miles
	replace pt1=_b[d2sub_l1]   in 2
	replace pt1_95l=_b[d2sub_l1]-1.96*_se[d2sub_l1] in 2
	replace pt1_95u=_b[d2sub_l1]+1.96*_se[d2sub_l1] in 2
	
	*Week 1 - >10 Miles
	lincom d2sub_l1+d2sub_dist10_l1
		replace pt1_dist10=r(estimate)   in 2
		replace pt1_dist10_95l=r(estimate)-1.96*r(se) in 2
		replace pt1_dist10_95u=r(estimate)+1.96*r(se) in 2
		
	*Week 2 - <10 Miles
	replace pt1=_b[d2sub_l2]   in 3
	replace pt1_95l=_b[d2sub_l2]-1.96*_se[d2sub_l2] in 3
	replace pt1_95u=_b[d2sub_l2]+1.96*_se[d2sub_l2] in 3
	
	*Week 2 - >10 Miles
	lincom d2sub_l2+d2sub_dist10_l2
		replace pt1_dist10=r(estimate)   in 3
		replace pt1_dist10_95l=r(estimate)-1.96*r(se) in 3
		replace pt1_dist10_95u=r(estimate)+1.96*r(se) in 3
				
	*Week 3 - <10 Miles
	replace pt1=_b[d2sub_l3]   in 4
	replace pt1_95l=_b[d2sub_l3]-1.96*_se[d2sub_l3] in 4
	replace pt1_95u=_b[d2sub_l3]+1.96*_se[d2sub_l3] in 4
	
	*Week 3 - >10 Miles
	lincom d2sub_l3+d2sub_dist10_l3
		replace pt1_dist10=r(estimate)   in 4
		replace pt1_dist10_95l=r(estimate)-1.96*r(se) in 4
		replace pt1_dist10_95u=r(estimate)+1.96*r(se) in 4	
		
	*Week 4 - <10 Miles
	replace pt1=_b[d2sub_l4]   in 5
	replace pt1_95l=_b[d2sub_l4]-1.96*_se[d2sub_l4] in 5
	replace pt1_95u=_b[d2sub_l4]+1.96*_se[d2sub_l4] in 5
	
	*Week 4 - >10 Miles
	lincom d2sub_l4+d2sub_dist10_l4
		replace pt1_dist10=r(estimate)   in 5
		replace pt1_dist10_95l=r(estimate)-1.96*r(se) in 5
		replace pt1_dist10_95u=r(estimate)+1.96*r(se) in 5	
				
	*Week 5 - <10 Miles
	replace pt1=_b[d2sub_l5]   in 6
	replace pt1_95l=_b[d2sub_l5]-1.96*_se[d2sub_l5] in 6
	replace pt1_95u=_b[d2sub_l5]+1.96*_se[d2sub_l5] in 6
	
	*Week 5 - >10 Miles
	lincom d2sub_l5+d2sub_dist10_l5
		replace pt1_dist10=r(estimate)   in 6
		replace pt1_dist10_95l=r(estimate)-1.96*r(se) in 6
		replace pt1_dist10_95u=r(estimate)+1.96*r(se) in 6			
		
	*Week 6 - <10 Miles
	replace pt1=_b[d2sub_l6]   in 7
	replace pt1_95l=_b[d2sub_l6]-1.96*_se[d2sub_l6] in 7
	replace pt1_95u=_b[d2sub_l6]+1.96*_se[d2sub_l6] in 7
	
	*Week 6 - >10 Miles
	lincom d2sub_l6+d2sub_dist10_l6
		replace pt1_dist10=r(estimate)   in 7
		replace pt1_dist10_95l=r(estimate)-1.96*r(se) in 7
		replace pt1_dist10_95u=r(estimate)+1.96*r(se) in 7	
		
	*Week 7 - <10 Miles
	replace pt1=_b[d2sub_l7]   in 8
	replace pt1_95l=_b[d2sub_l7]-1.96*_se[d2sub_l7] in 8
	replace pt1_95u=_b[d2sub_l7]+1.96*_se[d2sub_l7] in 8
	
	*Week 7 - >10 Miles
	lincom d2sub_l7+d2sub_dist10_l7
		replace pt1_dist10=r(estimate)   in 8
		replace pt1_dist10_95l=r(estimate)-1.96*r(se) in 8
		replace pt1_dist10_95u=r(estimate)+1.96*r(se) in 8		
		
	*Week 8 - <10 Miles
	replace pt1=_b[pt_dsub_l8]   in 9
	replace pt1_95l=_b[pt_dsub_l8]-1.96*_se[pt_dsub_l8] in 9
	replace pt1_95u=_b[pt_dsub_l8]+1.96*_se[pt_dsub_l8] in 9
	
	*Week 8 - >10 Miles
	lincom pt_dsub_l8+pt_dsub_dist10_l8 
		replace pt1_dist10=r(estimate)   in 9
		replace pt1_dist10_95l=r(estimate)-1.96*r(se) in 9
		replace pt1_dist10_95u=r(estimate)+1.96*r(se) in 9
		
*********
*Graphing
preserve
keep wk_shock pt1 pt1_95l pt1_95u pt1_dist10 pt1_dist10_95l pt1_dist10_95u ///
	
drop if wk_shock==.

*Staggering
gen wk_shock1=wk_shock-0.1
replace wk_shock=wk_shock+0.1

*E85 Subsidy PT
twoway scatter pt1 wk_shock1, m(diamond) mc(edkblue) msize(medlarge) || ///
	   rcap pt1_95u pt1_95l wk_shock1, lstyle(ci) lc(edkblue) || ///
       scatter pt1_dist10 wk_shock, m(triangle) mc(cranberry) msize(medlarge) || /// 
	   rcap pt1_dist10_95u pt1_dist10_95l wk_shock, lstyle(ci) lc(cranberry) ///                 
	   graphregion(color(white)) bgcolor(white) ///
	   legend(order(1 "<10 Miles"  ///
	    3 "> 10 Miles") ///
	   rows(1) region(lcolor(white))) ///
	   xtitle(Weeks After E85 Subsidy Cost Shock) ///  
	   ytitle(Pass Through ($/gal)) xlabel(0(1)8) ///
	   ylabel(0(0.5)1, nogrid)  ///
	   yline(0 0.5 1, lstyle(grid) lcolor(black*0.05))
	graph export $figs\Figure5b.png, width(4000) replace
restore

drop wk_shock pt1 pt1_95l pt1_95u pt1_dist10 pt1_dist10_95l pt1_dist10_95u 
