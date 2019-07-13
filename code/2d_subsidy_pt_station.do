********************************************* 
*FUEL SUBSIDY PASS-THROUGH AND MARKET STRUCTURE
* STATION-LEVEL PASS-THROUGH ESTIMATES AND FIGURES
*********************************************
preserve
set more off

*Seasonality controls
gen spr = 0
replace spr = 1 if month>=3 & month<=6
gen sum = 0
replace sum = 1 if month>=6 & month<=9
gen fall = 0
replace fall = 1 if month>=9 & month<=11
gen win = 0
replace win = 1 if month==12 | month<=3
global savars "spr sum fall win"

*Creating Variables 
gen station=.	
gen pt_sub_st=.
	label var pt_sub_st "Subsidy Pass Through (8 Lags)"
gen pt_sub_st_se=.
	label var pt_sub_st_se "Subsidy PT Std. Error"
gen n_st=.
	label var n_st "Number Observations"	
gen pt_cost_st=.
	label var pt_cost_st "Cost Pass Through (8 Lags)"
gen pt_cost_st_se=.
	label var pt_cost_st_se "Cost PT Std. Error"


*Estimating Station-level Pass-Through
forvalues i=1/451 {
	di `i'
	replace station=`i' in `i'
	
	***
	*Pass-Through (8 weeks)
	capture noisily xi: newey d.pe85_ret l(0/7).d2.sub_e85 l8.d.sub_e85 ///
							l(0/7).d2.e85_whole l8.d.e85_whole ///  
							$savars if id==`i', lag(4) force
	*PT After 8 Weeks & SE
	capture noisily replace pt_sub_st=_b[l8d.sub_e85] in `i'
	capture noisily replace pt_sub_st_se=_se[l8d.sub_e85] in `i'
	capture noisily replace pt_cost_st=_b[l8d.e85_whole] in `i'
	capture noisily replace pt_cost_st_se=_se[l8d.e85_whole] in `i'	
	capture noisily replace n_st=e(N) in `i'	
	
	*Short-Run PT Dynamics
	gen pt1_sr_st`i'=.
		capture noisily replace pt1_sr_st`i'=_b[d2.sub_e85] in 1
		capture noisily replace pt1_sr_st`i'=_b[l.d2.sub_e85] in 2
		capture noisily replace pt1_sr_st`i'=_b[l2.d2.sub_e85] in 3
		capture noisily replace pt1_sr_st`i'=_b[l3.d2.sub_e85] in 4
		capture noisily replace pt1_sr_st`i'=_b[l4.d2.sub_e85] in 5
		capture noisily replace pt1_sr_st`i'=_b[l5.d2.sub_e85] in 6
		capture noisily replace pt1_sr_st`i'=_b[l6d.sub_e85] in 7
}
*
*******************************************************
*Station-Level Pass-Through - 6 Week PT Graphs
*Keeping station PT estimates and merging with station characteristics
keep station pt_sub_st pt_sub_st_se n_st pt_cost_st pt_cost_st_se pt1_sr_st*

rename station id
drop if id==.

*Dropping noisy estimates
replace pt_sub_st=. if pt_sub_st_se==0 //Matters most
replace pt_sub_st=. if pt_sub_st>3 | pt_sub_st<-3 //Only matters for a few stations and mostly for differenced model
replace pt_cost_st=. if pt_cost_st_se==0 //Matters most
replace pt_cost_st=. if pt_cost_st>3 | pt_cost_st<-3 //Only matters for a few stations and mostly for differenced model

*Truncating estimates
replace pt_sub_st=0 if pt_sub_st<0 & !missing(pt_sub_st)
replace pt_sub_st=1 if pt_sub_st>1 & !missing(pt_sub_st)
replace pt_cost_st=0 if pt_cost_st<0 & !missing(pt_cost_st)
replace pt_cost_st=1 if pt_cost_st>1 & !missing(pt_cost_st)

*Keeping only pass-through estimates after 6 weeks
keep id pt_sub_st pt_sub_st_se n_st  
duplicates drop 

drop if missing(pt_sub_st)

*Merging with local characteristics
merge 1:m id using $clean\e85retail_jaere.dta
keep if _merge==3

keep id pt_sub_st pt_sub_st_se n_st brand_maj min_dist_df ///
	 lat lon housemed_1115 popden_1115 popden_10 state 
duplicates drop

*Taking average distance, home value, and population density
collapse (mean) min_dist_df housemed_1115 popden_1115 popden_10 ///
		 (first) pt_sub_st pt_sub_st_se n_st brand_maj state lat lon, by(id)
	
*State-by-State Heat Map of Pass-Through Rates with Histograms
label define pt_cat 1 "<=0" 2 "(0,0.25]" 3 "(0.25,0.5]" 4 "(0.5,0.75]" ///
				    5 "(0.75, 0.99)" 6 ">=1", replace
					
gen pt1_cat = 1 if pt_sub_st<=0
	replace pt1_cat = 2 if pt_sub_st >0 & pt_sub_st <=0.25
	replace pt1_cat = 3 if pt_sub_st >0.25 & pt_sub_st <=0.5
	replace pt1_cat = 4 if pt_sub_st >0.5 & pt_sub_st <=0.75
	replace pt1_cat = 5 if pt_sub_st >0.75 & pt_sub_st <=0.99
	replace pt1_cat = 6 if pt_sub_st >0.99
label values pt1_cat pt_cat

gen _ID=_n	

****
*IA Pass-Through Heat Map	
spmap using $clean\uscoord.dta if _ID ==14, ///
		id(_ID) fcolor(white) ocolor(black) osize(thin)  ///
		point(sel(keep if state =="IA") x(lon) y(lat) by(pt1_cat) ///
		shape(O O O O O O) size(medium) fcolor(Reds) ///
		ocolor(black*0.7 black*0.7 black*0.7 black*0.7 black*0.7) ///
		osize(thin thin thin thin thin thin) legenda(on)) ///
		name(ia1, replace) fxsize(90) fysize(90) ///
		legend(size(*2) pos(6) col(3) ring(1)) 
		
*IA Histogram
hist pt_sub_st if state=="IA", frac bcolor(cranberry) lcolor(black)  ///
		 graphregion(color(white)) bgcolor(white) xscale(range(0 1)) ///
		 xlabel(0[0.5]1) xtitle("Subsidy Pass-Through") ytitle("Density") ///
		 name(ia2, replace) fxsize(40) fysize(35)  ylabel(0[0.25]0.5, nogrid)
		 
*IA Combined		 
graph combine ia1 ia2, cols(2)  iscale(1) /// 
              graphregion(color(white))  imargin(0 0 0 0) ///
			title("", color(black))	 
graph export $figs\Figure6a.png, width(4000) replace	

****
*IL Pass-Through Heat Map	
spmap using $maps\uscoord.dta if _ID ==16, ///
		id(_ID) fcolor(white) ocolor(black) osize(thin)  ///
		point(sel(keep if state =="IL") x(lon) y(lat) by(pt1_cat) ///
		shape(O O O O O O) size(medium) fcolor(Reds) ///
		ocolor(black*0.7 black*0.7 black*0.7 black*0.7 black*0.7) ///
		osize(thin thin thin thin thin thin) legenda(on)) ///
		name(il1, replace) fysize(120) ///
		legend(size(*2) pos(6) col(3) ring(1)) 

*IL Histogram
hist pt_sub_st if state=="IL", frac bcolor(cranberry) lcolor(black)  ///
		 graphregion(color(white)) bgcolor(white) xscale(range(0 1)) ///
		 xlabel(0[0.5]1) xtitle("Subsidy Pass-Through") ytitle("Density") ///
		 name(il2, replace) fxsize(45) fysize(30)  ylabel(0[0.4]0.8, nogrid)
		 		
*IL Combined		 
graph combine il1 il2, cols(2)  iscale(1) /// 
              graphregion(color(white))  imargin(0 0 0 0) ///
			title("", color(black))	 
graph export $figs\Figure6b.png, width(4000) replace	
	
****
*MN Pass-Through Heat Map
spmap using $maps\uscoord.dta if _ID ==24, ///
		id(_ID) fcolor(white) ocolor(black) osize(thin)  ///
		point(sel(keep if state =="MN") x(lon) y(lat) by(pt1_cat) ///
		shape(O O O O O O) size(medium) fcolor(Reds) ///
		ocolor(black*0.7 black*0.7 black*0.7 black*0.7 black*0.7) ///
		osize(thin thin thin thin thin thin) legenda(on))  ///
		name(mn1, replace) fysize(100) ///
		legend(size(*2) pos(6) col(3) ring(1)) 
		
*MN Histogram
hist pt_sub_st if state=="MN", frac bcolor(cranberry) lcolor(black)  ///
		 graphregion(color(white)) bgcolor(white) xscale(range(0 1)) ///
		 xlabel(0[0.5]1) xtitle("Subsidy Pass-Through") ytitle("Density") ///
		 name(mn2, replace) fxsize(40) fysize(35) ylabel(0[0.2]0.4, nogrid)
		 		
*MN Combined		 
graph combine mn1 mn2, cols(2)  iscale(1) /// 
              graphregion(color(white))  imargin(0 0 0 0) ///
			title("", color(black))	 
graph export $figs\Figure6c.png, width(4000) replace	
			
			
			 
****
*Graphing Station-Level PT and Market Structure
twoway lfit pt_sub_st min_dist_df if id!=32, lwidth(0.6) lcolor(black) || ///
	   scatter pt_sub_st min_dist_df if id!=32, ///
       m(circle) mc(edkblue) msize(small)  ///
	   graphregion(color(white)) bgcolor(white) ///
	   xtitle("Distance from Competitor") ///  
	   ytitle("Pass Through")  ///
	   ylabel(0(0.5)1, nogrid) legend(off) ///
	   yline(0 0.5 1, lstyle(grid) lcolor(black*0.05)) ///
	   xlabel(0(5)30, nogrid)  name(g1, replace) 

twoway lfit pt_sub_st brand_maj, lwidth(0.6) lcolor(black) || ///
       scatter pt_sub_st brand_maj, ///
       m(circle) mc(edkblue) msize(small)  ///
	   graphregion(color(white)) bgcolor(white) ///
	   xtitle("Branded Major") ///  
	   ytitle("Pass Through")  ///
	   ylabel(0(0.5)1, nogrid) ///
	   yline(0 0.5 1, lstyle(grid) lcolor(black*0.05)) ///
	   xlabel(0 (1) 1, nogrid)  xsc(r(-0.2 1.2)) legend(off) name(g2, replace) 

twoway lfit pt_sub_st popden_1115 , lwidth(0.6) lcolor(black) || ///
       scatter pt_sub_st popden_1115 , ///
       m(circle) mc(edkblue) msize(small)  ///
	   graphregion(color(white)) bgcolor(white) ///
	   xtitle("Population Density (Zip Code)") ///  
	   ytitle("Pass Through")  ///
	   ylabel(0(0.5)1, nogrid) ///
	   xlabel(0(2000)10000) ///
	   yline(0 0.5 1, lstyle(grid) lcolor(black*0.05)) legend(off) name(g3, replace) 

twoway lfit pt_sub_st housemed_1115, lwidth(0.6) lcolor(black) || ///
       scatter pt_sub_st housemed_1115, ///
       m(circle) mc(edkblue) msize(small)  ///
	   graphregion(color(white)) bgcolor(white) ///
	   xtitle("Median Home Values (Zip Code)") ///  
	   ytitle("Pass Through")  ///
	   ylabel(0(0.5)1, nogrid) legend(off) xlabel(100000 (100000) 400000) ///
	   yline(0 0.5 1, lstyle(grid) lcolor(black*0.05)) name(g4, replace) 

graph combine g1 g2 g3 g4, cols(2)  iscale(1) /// 
              graphregion(color(white))   ///
			title("", color(black))	 
graph export $figs\Figure7.png, width(4000) replace	

restore
