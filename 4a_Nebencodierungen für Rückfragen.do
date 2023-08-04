**************************************************************************************************************
**************************************************************************************************************
******************************** Stellenumfang Vollzeit- Teilzeit ********************************************
**************************************************************************************************************
**************************************************************************************************************

*********************************************************************************************************
	 *************************** Operationalisierung der sozialen Mobilität **********************
*********************************************************************************************************

// Datensatz einlesen
use "C:\Users\sonon001\Desktop\Online-Fragebogen\Mobi_BN.dta", clear 

numlabel _all, add

keep id diszi phase stpromoart1 stpromoart2 stpromoart3 stpromoart4 stpromoart5 stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 ///
stpromoumf5 stpdocart1 stpdocart2 stpdocart3 stpdocart4 stpdocart5 stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5



*************** Promovierende/Promotionsphase  
gen          prom_umfang_st1_n = .
replace      prom_umfang_st1_n = 0 if phase==1 & stpromoart1 !=. & stpromoumf1==1 
replace      prom_umfang_st1_n = 1 if phase==1 & stpromoart1 !=. & stpromoumf1==2
replace      prom_umfang_st1_n = 2 if phase==1 & stpromoart1 !=. & stpromoumf1==3
label define UMF_lb 0 "Weniger als 50 %" 1 "zwischen 50 und 75 %" 2 "76 % bis 100 %-Stelle"
label values prom_umfang_st1_n UMF_lb
label var prom_umfang_st1_n "Arbeitsumfang der Stelle 1 (Promovierende/Promotionsphase)"

gen          prom_umfang_st2_n = .
replace      prom_umfang_st2_n = 0 if phase==1 & stpromoart2 !=. & stpromoumf2==1
replace      prom_umfang_st2_n = 1 if phase==1 & stpromoart2 !=. & stpromoumf2==2
replace      prom_umfang_st2_n = 2 if phase==1 & stpromoart2 !=. & stpromoumf2==3
label values prom_umfang_st2_n UMF_lb
label var prom_umfang_st2_n "Arbeitsumfang der Stelle 2 (Promovierende/Promotionsphase)"

gen          prom_umfang_st3_n = .
replace      prom_umfang_st3_n = 0 if phase==1 & stpromoart3 !=. & stpromoumf3==1
replace      prom_umfang_st3_n = 1 if phase==1 & stpromoart3 !=. & stpromoumf3==2
replace      prom_umfang_st3_n = 2 if phase==1 & stpromoart3 !=. & stpromoumf3==3
label values prom_umfang_st3_n UMF_lb
label var prom_umfang_st3_n "Arbeitsumfang der Stelle 3 (Promovierende/Promotionsphase)"

gen          prom_umfang_st4_n = .
replace      prom_umfang_st4_n = 0 if phase==1 & stpromoart4 !=. & stpromoumf4==1
replace      prom_umfang_st4_n = 1 if phase==1 & stpromoart4 !=. & stpromoumf4==2
replace      prom_umfang_st4_n = 2 if phase==1 & stpromoart4 !=. & stpromoumf4==3
label values prom_umfang_st4_n UMF_lb
label var prom_umfang_st4_n "Arbeitsumfang der Stelle 4 (Promovierende/Promotionsphase)"

gen          prom_umfang_st5_n = .
replace      prom_umfang_st5_n = 0 if phase==1 & stpromoart5 !=. & stpromoumf5==1
replace      prom_umfang_st5_n = 1 if phase==1 & stpromoart5 !=. & stpromoumf5==2
replace      prom_umfang_st5_n = 2 if phase==1 & stpromoart5 !=. & stpromoumf5==3
label values prom_umfang_st5_n UMF_lb
label var prom_umfang_st5_n "Arbeitsumfang der Stelle 5 (Promovierende/Promotionsphase)"

// Erzeugung einer 0/1-codierten Variable für alle fünf Stellen nach Stellenumfang (Promovierende/Promotionsphase)
egen prom_umf_help1 = anycount(prom_umfang_st1_n - prom_umfang_st5_n), values(0) // Anzahl <50 % Stellen
egen prom_umf_help2 = anycount(prom_umfang_st1_n - prom_umfang_st5_n), values(1) // Anzahl Teilzeitstellen
egen prom_umf_help3 = anycount(prom_umfang_st1_n - prom_umfang_st5_n), values(2) // Anzahl Vollzeitstellen

gen prom_umfang_B =.
replace prom_umfang_B=0 if prom_umf_help1>=1 & prom_umf_help1<. & prom_umf_help2==0 & prom_umf_help3==0
replace prom_umfang_B=1 if prom_umf_help2>=1 & prom_umf_help2<. & prom_umf_help3==0
replace prom_umfang_B=2 if prom_umf_help3>=1 & prom_umf_help3<.
replace prom_umfang_B=. if prom_umf_help1==0 & prom_umf_help2==0 & prom_umf_help3==0
label define UMF_LB 0 "<50 %" 1 "50 - 75 %" 2 "76% und mehr"
label values prom_umfang_B UMF_LB
label var prom_umfang_B "Verhältnis Vollzeittstellen zu Teilzeitstellen (Promovierende, Promotionsphase)"

list id phase prom_umfang_st1_n prom_umfang_st2_n prom_umfang_st3_n prom_umfang_st4_n prom_umfang_st5_n prom_umf_help1 prom_umf_help2 prom_umf_help3 ///
	 prom_umfang_B if phase==1 in 1/500

// Für Benjamin (Signifikanztests)
/*by diszi, sort: tab prom_umfang_B
tab prom_umfang_B diszi, chi2 V column

gen diszi_bio_inf=.
replace diszi_bio_inf=1 if diszi==1
replace diszi_bio_inf=2 if diszi==2

gen diszi_bio_soz=.
replace diszi_bio_soz=1 if diszi==1
replace diszi_bio_soz=3 if diszi==3

gen diszi_inf_soz=.
replace diszi_inf_soz=2 if diszi==2
replace diszi_inf_soz=3 if diszi==3

ttest prom_umfang_B, by(diszi_inf_soz)*/


list phase diszi prom_umfang_st1_n prom_umfang_st2_n prom_umfang_st3_n prom_umfang_st4_n prom_umfang_st5_n prom_umf_help1 ///
prom_umf_help2 prom_umf_help3 prom_umfang_B in 1/1000 if phase==1


********************** Postdocs/Postdocphase
gen          pdoc_umfang_st1_n = .
replace      pdoc_umfang_st1_n = 0 if phase==2 & stpdocart1 !=. & stpdocumf1==1 
replace      pdoc_umfang_st1_n = 1 if phase==2 & stpdocart1 !=. & stpdocumf1==2
replace      pdoc_umfang_st1_n = 2 if phase==2 & stpdocart1 !=. & stpdocumf1==3
label values pdoc_umfang_st1_n UMF_lb
label var pdoc_umfang_st1_n "Arbeitsumfang der Stelle 1 (Postdocs/Postdocphase)"

gen          pdoc_umfang_st2_n = .
replace      pdoc_umfang_st2_n = 0 if phase==2 & stpdocart2 !=. & stpdocumf2==1 
replace      pdoc_umfang_st2_n = 1 if phase==2 & stpdocart2 !=. & stpdocumf2==2
replace      pdoc_umfang_st2_n = 2 if phase==2 & stpdocart2 !=. & stpdocumf2==3
label values pdoc_umfang_st2_n UMF_lb
label var pdoc_umfang_st2_n "Arbeitsumfang der Stelle 2 (Postdocs/Postdocphase)"

gen          pdoc_umfang_st3_n = .
replace      pdoc_umfang_st3_n = 0 if phase==2 & stpdocart3 !=. & stpdocumf3==1 
replace      pdoc_umfang_st3_n = 1 if phase==2 & stpdocart3 !=. & stpdocumf3==2
replace      pdoc_umfang_st3_n = 2 if phase==2 & stpdocart3 !=. & stpdocumf3==3
label values pdoc_umfang_st3_n UMF_lb
label var pdoc_umfang_st3_n "Arbeitsumfang der Stelle 3 (Postdocs/Postdocphase)"

gen          pdoc_umfang_st4_n = .
replace      pdoc_umfang_st4_n = 0 if phase==2 & stpdocart4 !=. & stpdocumf4==1 
replace      pdoc_umfang_st4_n = 1 if phase==2 & stpdocart4 !=. & stpdocumf4==2
replace      pdoc_umfang_st4_n = 2 if phase==2 & stpdocart4 !=. & stpdocumf4==3
label values pdoc_umfang_st4_n UMF_lb
label var pdoc_umfang_st4_n "Arbeitsumfang der Stelle 4 (Postdocs/Postdocphase)"

gen          pdoc_umfang_st5_n = .
replace      pdoc_umfang_st5_n = 0 if phase==2 & stpdocart5 !=. & stpdocumf5==1 
replace      pdoc_umfang_st5_n = 1 if phase==2 & stpdocart5 !=. & stpdocumf5==2
replace      pdoc_umfang_st5_n = 2 if phase==2 & stpdocart5 !=. & stpdocumf5==3
label values pdoc_umfang_st5_n UMF_lb
label var pdoc_umfang_st5_n "Arbeitsumfang der Stelle 5 (Postdocs/Postdocphase)"

// Erzeugung einer 0/1-codierten Variable für alle fünf Stellen nach Stellenumfang (Postdocs/Postdocphase)
egen pdoc_umf_help1 = anycount(pdoc_umfang_st1_n - pdoc_umfang_st5_n), values(0) // Anzahl <50 % Stellen
egen pdoc_umf_help2 = anycount(pdoc_umfang_st1_n - pdoc_umfang_st5_n), values(1) // Anzahl Teilzeitstellen
egen pdoc_umf_help3 = anycount(pdoc_umfang_st1_n - pdoc_umfang_st5_n), values(2) // Anzahl Vollzeitstellen


gen pdoc_umfang_B =.
replace pdoc_umfang_B=0 if pdoc_umf_help1>=1 & pdoc_umf_help1<. & pdoc_umf_help2==0 & pdoc_umf_help3==0
replace pdoc_umfang_B=1 if pdoc_umf_help2>=1 & pdoc_umf_help2<. & pdoc_umf_help3==0
replace pdoc_umfang_B=2 if pdoc_umf_help3>=1 & pdoc_umf_help3<.
replace pdoc_umfang_B=. if pdoc_umf_help1==0 & pdoc_umf_help2==0 & pdoc_umf_help3==0
label values pdoc_umfang_B UMF_LB
label var pdoc_umfang_B "Verhältnis Vollzeittstellen zu Teilzeitstellen (Postdocs, Postdocphase)"
tab pdoc_umfang_B


// Für Benjamin (Signifikanztests)
/*by diszi, sort: tab pdoc_umfang_B
tab pdoc_umfang_B diszi, chi2 V column

gen diszi_bio_inf=.
replace diszi_bio_inf=1 if diszi==1
replace diszi_bio_inf=2 if diszi==2

gen diszi_bio_soz=.
replace diszi_bio_soz=1 if diszi==1
replace diszi_bio_soz=3 if diszi==3

gen diszi_inf_soz=.
replace diszi_inf_soz=2 if diszi==2
replace diszi_inf_soz=3 if diszi==3

ttest pdoc_umfang_B, by(diszi_inf_soz)*/



list phase diszi pdoc_umfang_st1_n pdoc_umfang_st2_n pdoc_umfang_st3_n pdoc_umfang_st4_n pdoc_umfang_st5_n pdoc_umf_help1 ///
pdoc_umf_help2 pdoc_umf_help3 pdoc_umfang_B in 1/1000 if phase==2