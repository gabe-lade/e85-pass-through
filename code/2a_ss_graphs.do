********************************************* 
*FUEL SUBSIDY PASS-THROUGH AND MARKET STRUCTURE 
* SUMMARY STATISTICS AND GRAPHS
* NOTES: - CALCULATES SUMMARY STATISTICS FOR E85 STATIONS BY MAJOR BRANDED.
* 		 - GRAPHS AVERAGE E85 PRICES & E85 SUBSIDIES 
********************************************* 

******************* 
*TABLE 1 - SUMMARY STATISTICS
*******************
gen p85_b=pe85_ret if brand_maj==1
	label var p85_b "Major Branded"
 
gen p85_r=pe85_ret if ret_maj==1
	label var p85_r "Major Retailer"

gen p85_d10=pe85_ret if dist10==1
	label var p85_d10 ">10 Miles to Competitor"
	
sutex pe85_ret p85_b p85_r p85_d10 sub_e85 e85_whole gas_whole eth_whole ///
	  brand_maj ret_maj min_dist_df, ///
	  digits(2) title(Summary Statistics)  labels minmax ///
	  file($output\Table1) replace
	  
	  
************************
*FIGURE 3 -  AVG. E85 PRICES & E85 SUBSIDY
*NOTES: 2013 FINAL RULE - 8/6/2016 (YW=2787)
*		REUTERS ARTICLE LEAK- 10/11/2013 (YW=2796)
*		2014 PROPOSED RULE - 11/15/2013 (YW=2801)
*		2014-2016 PROPOSED RULE - 6/10/2015 (YW=2882)
*		2014-2016 FINAL RULE - 11/30/2015 (YW=2907)
preserve
gen pe85_ret_l=pe85_ret
gen pe85_ret_u=pe85_ret
gen eth_whole_l=eth_whole_adj
gen eth_whole_u=eth_whole_adj
gen gas_whole_l=gas_whole_adj
gen gas_whole_u=gas_whole_adj

collapse (mean) pe85_ret eth_whole_adj gas_whole_adj e85_whole sub_e85 ///
		 (p5) pe85_ret_l eth_whole_l gas_whole_l ///
		 (p95) pe85_ret_u eth_whole_u gas_whole_u ///
		 (first) date, by(yw)
replace sub_e85=-sub_e85
label var sub_e85 "E85 Subsidy ($/gal)"
label var yw "Date"
label var pe85_ret "Average E85 Price ($/gal)" 
label var pe85_ret_l "5th Pct." 
label var pe85_ret_u "95th Pct." 
label var eth_whole_adj "Wholesale Ethanol Price ($/gal)"
label var gas_whole_adj "Wholesale Gasoline Price ($/gal)"

*E85 Subsidy 
twoway(line sub_e85 date, color(cranberry) lwidth(0.5)), ///
	ytitle("E85 Subsidy ($/gal)") /// 
	xtitle("") graphregion(color(white)) bgcolor(white) xlabel(, angle(45)) ///
	ylabel(0(0.2)1.2, format(%9.2f) nogrid angle(0)) legend(off) ///
	xline(19576,lc(black) lp(dash))  xline(19639,lc(black) lp(dash)) /// 
	xline(19674,lc(black) lp(dash))  xline(20248,lc(black) lp(dash)) /// 
	xline(20423,lc(black) lp(dash))  xline(20587,lc(black) lp(dash)) 
	graph export $figs\Figure3a.png, width(4000) replace
	
*E85 Retail Prices 
twoway(line pe85_ret date, color(orange_red) lwidth(0.5)) ///
	  (line pe85_ret_l date, color(orange_red) lpattern(dash) ) ///
	  (line pe85_ret_u date, color(orange_red) lpattern(dash) ), ///
	  graphregion(color(white)) bgcolor(white)  xtitle("")  ///
	  ylabel(0(0.5)3.5, format(%9.2f) nogrid angle(0)) ///
	  ytitle("E85 Price ($/gal)") ///
	  legend(on rows(1) order(1 "Average E85 Price ($/gal)")) ///
	  xlabel(,angle(45)) legend(off)
	graph export $figs\Figure3b.png, width(4000) replace
restore
 
 
*************************************
*FIGURE 8 - E85 PRICES AND WHOLESALE COST DECOMPOSITION   
*************************************	
preserve
collapse (mean) pe85_ret e85_whole eth_whole_adj eth_whole gas_whole_adj gas_whole sub_e85 month (first) date, by(yw state)
sort state yw

*************** 
*Average Tax (IA)
* Note: - Fed + State + Other State Tax 
gen tax_ia=.
	replace tax_ia=0.184+0.19+0.01 if yw<2873  & state=="IA"
	replace tax_ia=0.184+0.29+0.01 if yw>=2873 & yw<2886  & state=="IA"
	replace tax_ia=0.184+0.293+0.01 if yw>=2886 & state=="IA"

*Average Tax (IL)
* Note: - Fed + State + Freight
gen tax_il=.
	replace tax_il=0.184+0.391 if yw<2808  & state=="IL"
	replace tax_il=0.184+0.403 if yw>=2808 & yw<2860 & state=="IL"
	replace tax_il=0.184+0.383 if yw>=2860 & yw<2912 & state=="IL"
	replace tax_il=0.184+0.318 if yw>=2912 & state=="IL"

*Average Tax (MN)
gen tax_mn=0.184+0.203+0.021 if state=="MN"

*Tax for all three states
egen tax=rowtotal(tax_ia tax_il tax_mn)
	
*************** 
*Tax + Wholesale Gasoline Costs (IA)
gen gas_wh_ia=tax_ia+gas_whole_adj if state=="IA"

*Tax + Wholesale Gasoline Costs (IL)
gen gas_wh_il=tax_il+gas_whole_adj if state=="IL"
	
*Tax + Wholesale Gasoline Costs (MN)
gen gas_wh_mn=tax_mn+gas_whole_adj if state=="MN"
	
*Tax + Wholesale Gasoline Costs for all three states
egen gas_wh=rowtotal(gas_wh_ia gas_wh_il gas_wh_mn)
	
*************** 
*Tax + Wholesale Gasoline Costs + Wholesale Ethanol (IA)
gen eth_wh_ia=gas_wh_ia+eth_whole_adj if state=="IA"

*Tax + Wholesale Gasoline Costs + Wholesale Ethanol (IL)
gen eth_wh_il=gas_wh_il+eth_whole_adj if state=="IL"
	
*Tax + Wholesale Gasoline Costs + Wholesale Ethanol (MN)
gen eth_wh_mn=gas_wh_mn+eth_whole_adj if state=="MN"
	
*Tax + Wholesale Gasoline Costs + Wholesale Ethanol for all three states
egen eth_wh=rowtotal(eth_wh_ia eth_wh_il eth_wh_mn)
	
*************** 
*Reversing Sign of E85 Subsidy
replace sub_e85=-sub_e85

*************** 
*Retails Margins with Full & Immediate PT (IA)
gen pe85_ret_ia=pe85_ret if state=="IA"	
gen pe85_ret_adj_ia=pe85_ret+sub_e85 if state=="IA"	
gen pe85_ret_adj50_ia=pe85_ret+0.5*sub_e85 if state=="IA"	
gen pe85_ret_adj75_ia=pe85_ret+0.75*sub_e85 if state=="IA"	


*Retails Margins with Full & Immediate PT (IL)
gen pe85_ret_il=pe85_ret if state=="IL"	
gen pe85_ret_adj_il=pe85_ret+sub_e85 if state=="IL"	
gen pe85_ret_adj50_il=pe85_ret+0.5*sub_e85 if state=="IL"	
gen pe85_ret_adj75_il=pe85_ret+0.75*sub_e85 if state=="IL"

*Retails Margins with Full & Immediate PT (MN)
gen pe85_ret_mn=pe85_ret if state=="MN"	
gen pe85_ret_adj_mn=pe85_ret+sub_e85 if state=="MN"	
gen pe85_ret_adj50_mn=pe85_ret+0.5*sub_e85 if state=="MN"	
gen pe85_ret_adj75_mn=pe85_ret+0.75*sub_e85 if state=="MN"

*Retails Margins for all three states
egen pe85_ret_adj=rowtotal(pe85_ret_adj_ia pe85_ret_adj_il pe85_ret_adj_mn)
egen pe85_ret_adj50=rowtotal(pe85_ret_adj50_ia pe85_ret_adj50_il pe85_ret_adj50_mn)
egen pe85_ret_adj75=rowtotal(pe85_ret_adj75_ia pe85_ret_adj75_il pe85_ret_adj75_mn)

*************************************
*Graph of E85 Prices and Wholesale Costs - Avg. Across All States
*************************************	
collapse (mean) eth_wh gas_wh tax pe85_ret_adj pe85_ret_adj50 pe85_ret_adj75 pe85_ret (first) date, by(yw)

*Average Margin
gen margin=pe85_ret-eth_wh
gen margin_sub=pe85_ret_adj-eth_wh
gen margin_sub50=pe85_ret_adj50-eth_wh
gen margin_sub75=pe85_ret_adj75-eth_wh
summarize margin margin_sub

*Graph of Retail Margins
twoway(area eth_wh gas_wh tax yw, color(orange edkblue gray)) ///
	  (line pe85_ret_adj yw, lcolor(cranberry) lw(medthick)) ///
	  (line pe85_ret yw, lcolor(black) lw(medthick) lp(longdash)),  ///
	ylabel(0(1)4.4, nogrid angle(0)) ///	
	legend(pos(1) ring(0) col(1)  ///
		   order(4 "Retail Price + Subsidy" 5 "Retail Price"  ///
		         1 "Wholesale Ethanol" ///
		         2 "Wholesale Gas" 3 "Taxes") ///
		   region(lcolor(white))) ///
	name(wh1, replace) graphregion(color(white)) bgcolor(white) ///
	xtitle("") ytitle("Margins ($/gal)")  ///
		xlabel(2756 "Jan 2013" 2782 "July 2013"  ///
	       2808 "Jan 2014" 2834 "July 2014" ///
		   2860 "Jan 2015" 2886 "July 2015" ///
		   2912 "Jan 2016" 2937 "July 2016",  angle(45)) 
graph export $figs\Figure8.png, width(4000) replace	
restore
