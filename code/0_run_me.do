**************************************************************
*FUEL SUBSIDY PASS-THROUGH AND MARKET STRUCTURE: CODE
*CODE BY GABRIEL LADE 
* LAST MAJOR UPDATE: 09/06/2017
**************************************************************
clear all
capture log close
set more off
set excelxlsxlargefile on

*SET DIRECTORY
cd ""

*FOLDER DESIGNATIONS
global code "codeSTATA"
global clean "dataSTATA"
global output "outSTATA"
global figs "figSTATA"


******** 
*LOAD DATA
******** 
use  $clean\e85retail_jaere.dta, clear
xtset id yw

******** 
*DATA PREPARATION 
******** 
do $code\1a_data_prep

******** 
*RESULTS - MAIN TEXT
******** 
do $code\2a_ss_graphs
do $code\2b_subsidy_pt
do $code\2c_subsidy_pt_sr
do $code\2d_subsidy_pt_station
do $code\2e_kms_ls_comparison

******** 
*RESULTS - APPENDIX
********
do $code\3a_app_unitroot
do $code\3b_robustness
