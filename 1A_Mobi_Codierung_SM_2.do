
	 *************************** Operationalisierung der sozialen Mobilität **********************

// Datensatz einlesen
use "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\SM_01.dta", clear 
numlabel _all, add

********************************************************************************
*************** Prestige-Bewertung der einzlenen Stellen *****************
********************************************************************************

****************************************************
************* Promovierende/Promotionsphase
****************************************************

// For-Schleife zur Recodierung der Variable Karriere/Prestige
// 0=neutral, plus = positiv, minus = negativ

foreach x of varlist promkarr1-promkarr5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==1, gen(`x'_NP)  // NP = Nicht Phasenübergreifend
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_NP, mi
}

egen total_posit_prom = rownonmiss(promkarr1_NP promkarr2_NP promkarr3_NP promkarr4_NP promkarr5_NP)
replace total_posit_prom=. if promkarr1_NP==.

egen last_prest_prom = rowlast(promkarr1_NP promkarr2_NP promkarr3_NP promkarr4_NP promkarr5_NP)
list promkarr1_NP promkarr2_NP promkarr3_NP promkarr4_NP promkarr5_NP total_posit_prom last_prest_prom if phase==1

gen last_first_prom= last_prest_prom - promkarr1_NP if total_posit_prom>=2 & total_posit_prom<.
list id promkarr1_NP promkarr2_NP promkarr3_NP promkarr4_NP promkarr5_NP total_posit_prom last_prest_prom last_prest_prom last_first_prom if phase==1

********* Weitere Differenzierungen (bsp. 2x positiv oder 2x negativ usw.) 

// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Promotionsphase/Promovierende)
gen diff_prom21 = promkarr2_NP - promkarr1_NP if total_posit_prom==3
gen diff_prom32 = promkarr3_NP - promkarr2_NP if total_posit_prom==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_prom_promph_0 = anycount(diff_prom21 diff_prom32), values(0)  // Konstant
egen verlauf_prom_promph_mx = anycount(diff_prom21 diff_prom32), values(-1,-2,-3,-4) // Abnahme
egen verlauf_prom_promph_px = anycount(diff_prom21 diff_prom32), values(1,2,3,4) // Zunahme

// Erzeugung der Verlaufsvariable "Verlauf_prom_promph" für die Promovierenden während Promotionsphase
gen verlauf_prom_promph=.
replace verlauf_prom_promph=1 if verlauf_prom_promph_mx==2 // 2 x negativ
replace verlauf_prom_promph=2 if verlauf_prom_promph_mx==1 & verlauf_prom_promph_0==1 // negativ + konstant
replace verlauf_prom_promph=3 if verlauf_prom_promph_0==2 // Kein Verlauf
replace verlauf_prom_promph=4 if verlauf_prom_promph_px==1 & verlauf_prom_promph_mx==1 // 1x positiv, 1x negativ
replace verlauf_prom_promph=5 if verlauf_prom_promph_px==1 & verlauf_prom_promph_0==1 // positiv + konstant
replace verlauf_prom_promph=6 if verlauf_prom_promph_px==2 // 2 x positiv
label define verlauf_lb 1 "2x negativ" 2 "Neg. Verlauf" 3 "Kein Verlauf" 4 "Wechselnder Verlauf" 5 "Pos. Verlauf" 6 "2 mal positiv" 
label values verlauf_prom_promph verlauf_lb
label var verlauf_prom_promph "Verlauf Prestigebewertung der Stellen der Promovierenden/Promotionsphase"
list id diff_prom21 diff_prom32 verlauf_prom_promph if phase==1 in 1/1599

// drop variables that are not necessary anymore
drop verlauf_prom_promph_mx verlauf_prom_promph_px verlauf_prom_promph_0

recode verlauf_prom_promph (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_prom_promph_r)
lab define verlauf_rec_lb 1 "Negativ" 2 "Konstant" 3 "Wechselnd" 4 "Positiv"
lab values verlauf_prom_promph_r verlauf_rec_lb

tab last_first_prom  // Vgl. Grafiken in 3_Grafiken_SM, Zeile 39-48
tab verlauf_prom_promph  // Vgl. Grafiken in 3_Grafiken_SM, Zeile 50-57


***************************************
************* Postdocs/Postdocphase
***************************************

foreach x of varlist pdockarr1-pdockarr5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==2, gen(`x'_NP) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_NP, mi
}

egen total_posit_pdoc = rownonmiss(pdockarr1_NP pdockarr2_NP pdockarr3_NP pdockarr4_NP pdockarr5_NP)
replace total_posit_pdoc=. if pdockarr1_NP==.

egen last_prest_pdoc = rowlast(pdockarr1_NP pdockarr2_NP pdockarr3_NP pdockarr4_NP pdockarr5_NP)
list pdockarr1_NP pdockarr2_NP pdockarr3_NP pdockarr4_NP pdockarr5_NP total_posit_pdoc last_prest_pdoc if phase==2

gen last_first_pdoc= last_prest_pdoc - pdockarr1_NP if total_posit_pdoc>=2 & total_posit_pdoc<.
list id pdockarr1_NP pdockarr2_NP pdockarr3_NP pdockarr4_NP pdockarr5_NP total_posit_pdoc last_prest_pdoc last_first_pdoc if phase==2

// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Postdocs/Postdocphase) 
gen diff_pdoc21 = pdockarr2_NP - pdockarr1_NP if total_posit_pdoc==3
gen diff_pdoc32 = pdockarr3_NP - pdockarr2_NP if total_posit_pdoc==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_pdoc_pdocph_0 = anycount(diff_pdoc21 diff_pdoc32), values(0) 
egen verlauf_pdoc_pdocph_mx = anycount(diff_pdoc21 diff_pdoc32), values(-1,-2,-3,-4) 
egen verlauf_pdoc_pdocph_px = anycount(diff_pdoc21 diff_pdoc32), values(1,2,3,4) 

// Erzeugung der Verlaufsvariable "Verlauf_prom_promph" für die Promovierenden während Promotionsphase
gen verlauf_pdoc_pdocph=.
replace verlauf_pdoc_pdocph=1 if verlauf_pdoc_pdocph_mx==2
replace verlauf_pdoc_pdocph=2 if verlauf_pdoc_pdocph_mx==1 & verlauf_pdoc_pdocph_0==1 
replace verlauf_pdoc_pdocph=3 if verlauf_pdoc_pdocph_0==2 
replace verlauf_pdoc_pdocph=4 if verlauf_pdoc_pdocph_px==1 & verlauf_pdoc_pdocph_mx==1 
replace verlauf_pdoc_pdocph=5 if verlauf_pdoc_pdocph_px==1 & verlauf_pdoc_pdocph_0==1 
replace verlauf_pdoc_pdocph=6 if verlauf_pdoc_pdocph_px==2 
label values verlauf_pdoc_pdocph verlauf_lb
label var verlauf_pdoc_pdocph "Verlauf Prestigebewertung der Stellen der Postdocs/Postdocs/Postdocphase"

// Drop Hilfsvariablen
drop verlauf_pdoc_pdocph_mx verlauf_pdoc_pdocph_px verlauf_pdoc_pdocph_0

recode verlauf_pdoc_pdocph (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_pdoc_pdocph_r)
lab values verlauf_pdoc_pdocph_r verlauf_rec_lb
tab verlauf_pdoc_pdocph_r


***************************************
************* Professoren/Profphase
***************************************

foreach x of varlist profkarr1-profkarr5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==3, gen(`x'_NP) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_NP, mi
}

egen total_posit_prof = rownonmiss(profkarr1_NP profkarr2_NP profkarr3_NP profkarr4_NP profkarr5_NP)
replace total_posit_prof=. if profkarr1_NP==.

egen last_prest_prof = rowlast(profkarr1_NP profkarr2_NP profkarr3_NP profkarr4_NP profkarr5_NP)
list profkarr1_NP profkarr2_NP profkarr3_NP profkarr4_NP profkarr5_NP total_posit_prof last_prest_prof if phase==3

gen last_first_prof= last_prest_prof - profkarr1_NP if total_posit_prof>=2 & total_posit_prof<.
list profkarr1_NP profkarr2_NP profkarr3_NP profkarr4_NP profkarr5_NP total_posit_prof last_prest_prof last_first_prof if phase==3


tab last_first_prof  //  Vgl. Grafiken in 3_Grafiken_SM, Zeile 62-72


         ********************************************************************************
*************************************** PHASENÜBERGREIFEND ***************************************
		 ********************************************************************************

***************************************
************* Profs/Promotionsphase
***************************************  

foreach x of varlist promkarr1-promkarr5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==3, gen(`x'_PrPr) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_PrPr, mi
}

egen total_posit_prof_prom = rownonmiss(promkarr1_PrPr promkarr2_PrPr promkarr3_PrPr promkarr4_PrPr promkarr5_PrPr)
replace total_posit_prof_prom=. if promkarr1_PrPr==.

egen last_prest_prof_prom = rowlast(promkarr1_PrPr promkarr2_PrPr promkarr3_PrPr promkarr4_PrPr promkarr5_PrPr)
list promkarr1_PrPr promkarr2_PrPr promkarr3_PrPr promkarr4_PrPr promkarr5_PrPr total_posit_prof_prom last_prest_prof_prom if phase==3

gen last_first_prof_prom = last_prest_prof_prom - promkarr1_PrPr if total_posit_prof_prom>=2 & total_posit_prof_prom<.


tab last_first_prof_prom // Vgl. Grafiken in 3_Grafiken_SM, Zeile 84-94

****** Weitere Differenzierungen aufgrund zu geringer Fallzahlen nicht möglich 


************************************
************* Profs/Pdocphase
************************************  

foreach x of varlist pdockarr1-pdockarr5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==3, gen(`x'_PrPd) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_PrPd, mi
}

egen total_posit_prof_pdoc = rownonmiss(pdockarr1_PrPd pdockarr2_PrPd pdockarr3_PrPd pdockarr4_PrPd pdockarr5_PrPd)
replace total_posit_prof_pdoc=. if pdockarr1_PrPd==.

egen last_prest_prof_pdoc = rowlast(pdockarr1_PrPd pdockarr2_PrPd pdockarr3_PrPd pdockarr4_PrPd pdockarr5_PrPd)
list pdockarr1_PrPd pdockarr2_PrPd pdockarr3_PrPd pdockarr4_PrPd pdockarr5_PrPd total_posit_prof_pdoc last_prest_prof_pdoc if phase==3

gen last_first_prof_pdoc = last_prest_prof_pdoc - pdockarr1_PrPd if total_posit_prof_pdoc>=2 & total_posit_prof_pdoc<.
list pdockarr1_PrPd pdockarr2_PrPd pdockarr3_PrPd pdockarr4_PrPd pdockarr5_PrPd total_posit_prof_pdoc /// 
last_prest_prof_pdoc last_first_prof_pdoc if phase==3

gen diff_prof_pdoc21 = pdockarr2_PrPd - pdockarr1_PrPd if total_posit_prof_pdoc==3
gen diff_prof_pdoc32 = pdockarr3_PrPd - pdockarr2_PrPd if total_posit_prof_pdoc==3

egen verlauf_prof_pdocph_0 = anycount(diff_prof_pdoc21 diff_prof_pdoc32), values(0) 
egen verlauf_prof_pdocph_mx = anycount(diff_prof_pdoc21 diff_prof_pdoc32), values(-1,-2,-3,-4) 
egen verlauf_prof_pdocph_px = anycount(diff_prof_pdoc21 diff_prof_pdoc32), values(1,2,3,4) 

gen verlauf_prof_pdocph=.
replace verlauf_prof_pdocph=1 if verlauf_prof_pdocph_mx==2 
replace verlauf_prof_pdocph=2 if verlauf_prof_pdocph_mx==1 & verlauf_prof_pdocph_0==1 
replace verlauf_prof_pdocph=3 if verlauf_prof_pdocph_0==2
replace verlauf_prof_pdocph=4 if verlauf_prof_pdocph_px==1 & verlauf_prof_pdocph_mx==1
replace verlauf_prof_pdocph=5 if verlauf_prof_pdocph_px==1 & verlauf_prof_pdocph_0==1 
replace verlauf_prof_pdocph=6 if verlauf_prof_pdocph_px==2 
label values verlauf_prof_pdocph verlauf_lb
label var verlauf_prof_pdocph "Verlauf Prestigebewertung der Stellen der Profs/Postdocphase"

// Drop Hilfsvariablen
drop verlauf_prof_pdocph_mx verlauf_prof_pdocph_px verlauf_prof_pdocph_0

recode verlauf_prof_pdocph (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_prof_pdocph_r)
lab values verlauf_prof_pdocph_r verlauf_rec_lb
tab verlauf_prof_pdocph_r


***************************************
************* Postdocs/Promotionsphase
***************************************  

foreach x of varlist promkarr1-promkarr5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==2, gen(`x'_PdPr) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_PdPr, mi
}

egen total_posit_pdoc_prom = rownonmiss(promkarr1_PdPr promkarr2_PdPr promkarr3_PdPr promkarr4_PdPr promkarr5_PdPr)
replace total_posit_pdoc_prom=. if promkarr1_PdPr==.

egen last_prest_pdoc_prom = rowlast(promkarr1_PdPr promkarr2_PdPr promkarr3_PdPr promkarr4_PdPr promkarr5_PdPr)
list promkarr1_PdPr promkarr2_PdPr promkarr3_PdPr promkarr4_PdPr promkarr5_PdPr total_posit_pdoc_prom last_prest_pdoc_prom if phase==2

gen last_first_pdoc_prom= last_prest_pdoc_prom - promkarr1_PdPr if total_posit_pdoc_prom>=2 & total_posit_pdoc_prom<.
list promkarr1_PdPr promkarr2_PdPr promkarr3_PdPr promkarr4_PdPr promkarr5_PdPr total_posit_pdoc_prom ///
last_first_pdoc_prom last_prest_pdoc_prom if phase==2

// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Postdocs/Postdocphase) 
gen diff_pdoc_prom21 = promkarr2_PdPr - promkarr1_PdPr if total_posit_pdoc_prom==3
gen diff_pdoc_prom32 = promkarr3_PdPr - promkarr2_PdPr if total_posit_pdoc_prom==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_pdoc_promph_0 = anycount(diff_pdoc_prom21 diff_pdoc_prom32), values(0) // Konstant
egen verlauf_pdoc_promph_mx = anycount(diff_pdoc_prom21 diff_pdoc_prom32), values(-1,-2,-3,-4) // Abnahme
egen verlauf_pdoc_promph_px = anycount(diff_pdoc_prom21 diff_pdoc_prom32), values(1,2,3,4) // Zunahme

// Erzeugung der Verlaufsvariable "Verlauf_pdoc_promph" für die Postdocs während Promotionsphase
gen verlauf_pdoc_promph=.
replace verlauf_pdoc_promph=1 if verlauf_pdoc_promph_mx==2 
replace verlauf_pdoc_promph=2 if verlauf_pdoc_promph_mx==1 & verlauf_pdoc_promph_0==1 
replace verlauf_pdoc_promph=3 if verlauf_pdoc_promph_0==2 
replace verlauf_pdoc_promph=4 if verlauf_pdoc_promph_px==1 & verlauf_pdoc_promph_mx==1 
replace verlauf_pdoc_promph=5 if verlauf_pdoc_promph_px==1 & verlauf_pdoc_promph_0==1 
replace verlauf_pdoc_promph=6 if verlauf_pdoc_promph_px==2 
label values verlauf_pdoc_promph verlauf_lb
label var verlauf_pdoc_promph "Verlauf Prestigebewertung der Stellen der Postdocs/Promotionsphase"

// Drop Hilfsvariablen
drop verlauf_pdoc_promph_mx verlauf_pdoc_promph_px verlauf_pdoc_promph_0

recode verlauf_pdoc_promph (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_pdoc_promph_r)
lab values verlauf_pdoc_promph_r verlauf_rec_lb

********************************************************************************
*************** Subjektive Bewertung der finanziellen Situation *****************
********************************************************************************

****************************************************
************* Promovierende/Promotionsphase
****************************************************

// For-Schleife zur Recodierung der Variable Karriere/Prestige
// 0=neutral, plus = positiv, minus = negativ

foreach x of varlist promfinz1-promfinz5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==1, gen(`x'_NP)  
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_NP, mi
}

// Als nächstes wird die letzte Stelle fixiert und der entsprechende Wert dieser Stelle bestimmt
egen total_posit_promF = rownonmiss(promfinz1_NP promfinz2_NP promfinz3_NP promfinz4_NP promfinz5_NP)
replace total_posit_promF=. if promfinz1_NP==.
// Wer hatte bei der letzten/aktuellen Stelle +1,+2 oder -1, -2, 0
egen last_finz_prom = rowlast(promfinz1_NP promfinz2_NP promfinz3_NP promfinz4_NP promfinz5_NP)
list promfinz1_NP promfinz2_NP promfinz3_NP promfinz4_NP promfinz5_NP total_posit_promF last_finz_prom if phase==1
// Bewertung (In Zahlen) der letzten/aktuellen Stelle - Bewertung (in Zahlen) der ersten Stelle 
gen last_first_promF = last_finz_prom - promfinz1_NP if total_posit_promF>=2 & total_posit_promF<.
list diszi promfinz1_NP promfinz2_NP promfinz3_NP promfinz4_NP promfinz5_NP total_posit_promF last_finz_prom last_first_promF if phase==1 & diszi ==1


// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Promotionsphase/Promovierende)
gen diff_promF21 = promfinz2_NP - promfinz1_NP if total_posit_promF==3
gen diff_promF32 = promfinz3_NP - promfinz2_NP if total_posit_promF==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_prom_promphF_0 = anycount(diff_promF21 diff_promF32), values(0)  // Konstant
egen verlauf_prom_promphF_mx = anycount(diff_promF21 diff_promF32), values(-1,-2,-3,-4) // Abnahme
egen verlauf_prom_promphF_px = anycount(diff_promF21 diff_promF32), values(1,2,3,4) // Zunahme

// Erzeugung der Verlaufsvariable "Verlauf_prom_promph" für die Promovierenden während Promotionsphase
gen verlauf_prom_promphF=.
replace verlauf_prom_promphF=1 if verlauf_prom_promphF_mx==2 // 2 x negativ
replace verlauf_prom_promphF=2 if verlauf_prom_promphF_mx==1 & verlauf_prom_promphF_0==1 // negativ + konstant
replace verlauf_prom_promphF=3 if verlauf_prom_promphF_0==2 // Kein Verlauf
replace verlauf_prom_promphF=4 if verlauf_prom_promphF_px==1 & verlauf_prom_promphF_mx==1 // 1x positiv, 1x negativ
replace verlauf_prom_promphF=5 if verlauf_prom_promphF_px==1 & verlauf_prom_promphF_0==1 // positiv + konstant
replace verlauf_prom_promphF=6 if verlauf_prom_promphF_px==2 // 2 x positiv
label values verlauf_prom_promphF verlauf_lb
label var verlauf_prom_promphF "Verlauf Sub. Bewertung der finanziellen Situation Promovierenden/Promotionsphase"

// drop variables that are not necessary anymore
drop verlauf_prom_promphF_mx verlauf_prom_promphF_px verlauf_prom_promphF_0

recode verlauf_prom_promphF (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_prom_promphF_r)
lab values verlauf_prom_promphF_r verlauf_rec_lb


********************************************
************* Postdocs/Postdocphase
********************************************

foreach x of varlist pdocfinz1-pdocfinz5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==2, gen(`x'_NP) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_NP, mi
}

egen total_posit_pdocF = rownonmiss(pdocfinz1_NP pdocfinz2_NP pdocfinz3_NP pdocfinz4_NP pdocfinz5_NP)
replace total_posit_pdocF=. if pdocfinz1_NP==.

egen last_finz_pdoc = rowlast(pdocfinz1_NP pdocfinz2_NP pdocfinz3_NP pdocfinz4_NP pdocfinz5_NP)
list pdocfinz1_NP pdocfinz2_NP pdocfinz3_NP pdocfinz4_NP pdocfinz5_NP total_posit_pdocF last_finz_pdoc if phase==2

gen last_first_pdocF= last_finz_pdoc - pdocfinz1_NP if total_posit_pdocF>=2 & total_posit_pdocF<.
list pdocfinz1_NP pdocfinz2_NP pdocfinz3_NP pdocfinz4_NP pdocfinz5_NP total_posit_pdocF last_finz_pdoc last_first_pdocF if phase==2
// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Postdocs/Postdocphase) 
gen diff_pdocF21 = pdocfinz2_NP - pdocfinz1_NP if total_posit_pdocF==3
gen diff_pdocF32 = pdocfinz3_NP - pdocfinz2_NP if total_posit_pdocF==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_pdoc_pdocphF_0 = anycount(diff_pdocF21 diff_pdocF32), values(0) 
egen verlauf_pdoc_pdocphF_mx = anycount(diff_pdocF21 diff_pdocF32), values(-1,-2,-3,-4) 
egen verlauf_pdoc_pdocphF_px = anycount(diff_pdocF21 diff_pdocF32), values(1,2,3,4) 

// Erzeugung der Verlaufsvariable "Verlauf_prom_promph" für die Promovierenden während Promotionsphase
gen verlauf_pdoc_pdocphF=.
replace verlauf_pdoc_pdocphF=1 if verlauf_pdoc_pdocphF_mx==2
replace verlauf_pdoc_pdocphF=2 if verlauf_pdoc_pdocphF_mx==1 & verlauf_pdoc_pdocphF_0==1 
replace verlauf_pdoc_pdocphF=3 if verlauf_pdoc_pdocphF_0==2 
replace verlauf_pdoc_pdocphF=4 if verlauf_pdoc_pdocphF_px==1 & verlauf_pdoc_pdocphF_mx==1 
replace verlauf_pdoc_pdocphF=5 if verlauf_pdoc_pdocphF_px==1 & verlauf_pdoc_pdocphF_0==1 
replace verlauf_pdoc_pdocphF=6 if verlauf_pdoc_pdocphF_px==2 
label values verlauf_pdoc_pdocphF verlauf_lb
label var verlauf_pdoc_pdocphF "Verlauf Prestigebewertung der Stellen der Postdocs/Postdocs/Postdocphase"

// Drop Hilfsvariablen
drop verlauf_pdoc_pdocphF_mx verlauf_pdoc_pdocphF_px verlauf_pdoc_pdocphF_0

recode verlauf_pdoc_pdocphF (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_pdoc_pdocphF_r)
lab values verlauf_pdoc_pdocphF_r verlauf_rec_lb

***************************************
************* Professoren/Profphase
***************************************

foreach x of varlist proffinz1-proffinz5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==3, gen(`x'_NP) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_NP, mi
}

egen total_posit_profF = rownonmiss(proffinz1_NP proffinz2_NP proffinz3_NP proffinz4_NP proffinz5_NP)
replace total_posit_profF=. if proffinz1_NP==.

egen last_finz_prof = rowlast(proffinz1_NP proffinz2_NP proffinz3_NP proffinz4_NP proffinz5_NP)
list proffinz1_NP proffinz2_NP proffinz3_NP proffinz4_NP proffinz5_NP total_posit_profF last_finz_prof if phase==3

gen last_first_profF= last_finz_prof - proffinz1_NP if total_posit_profF>=2 & total_posit_profF<.
list proffinz1_NP proffinz2_NP proffinz3_NP proffinz4_NP proffinz5_NP total_posit_profF last_finz_prof last_first_profF if phase==3

*************** Für weitere Differenzierungen zu wenige Stellen (proffinz3--> N=7)


         ********************************************************************************
*************************************** PHASENÜBERGREIFEND ***************************************
		 ********************************************************************************


***************************************
************* Professoren/Promophase
***************************************

foreach x of varlist promfinz1-promfinz5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==3, gen(`x'_PrPr) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_PrPr, mi
}

egen total_posit_prof_promF = rownonmiss(promfinz1_PrPr promfinz2_PrPr promfinz3_PrPr promfinz4_PrPr promfinz5_PrPr) if phase==3
replace total_posit_prof_promF=. if promfinz1_PrPr==. & phase==3

egen last_finz_prof_prom = rowlast(promfinz1_PrPr promfinz2_PrPr promfinz3_PrPr promfinz4_PrPr promfinz5_PrPr)
list promfinz1_PrPr promfinz2_PrPr promfinz3_PrPr promfinz4_PrPr promfinz5_PrPr total_posit_prof_promF last_finz_prof_prom if phase==3

gen last_first_prof_promF = last_finz_prof_prom - promfinz1_PrPr if total_posit_prof_promF>=2 & total_posit_prof_promF<.
list promfinz1_PrPr promfinz2_PrPr promfinz3_PrPr promfinz4_PrPr promfinz5_PrPr total_posit_prof_promF last_finz_prof_prom ///
last_first_prof_promF if phase==3

// Tabelle 5b Nicole Auswertungen meine Rückfrage Seite 5. 15.11.2022? 
egen total_mean_profpromFINZ = rowmean(promfinz1_PrPr promfinz2_PrPr promfinz3_PrPr promfinz4_PrPr promfinz5_PrPr) if phase==3 & promfinz1_PrPr != .
list id phase promfinz1_PrPr promfinz2_PrPr promfinz3_PrPr promfinz4_PrPr promfinz5_PrPr total_mean_profpromFINZ in 1/500 if phase==3
sum total_mean_profpromFINZ, detail  // mean = 0,41
by diszi, sort: sum total_mean_profpromFINZ if phase==3
// by diszi, sort: sum total_mean_profpromFINZ if promfinz1_PrPr>=2 & promfinz1_PrPr<=5 & phase==3  --> Zu wenige Fälle

***************************************
************* Professoren/Pdocphase
***************************************

foreach x of varlist pdocfinz1-pdocfinz5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==3, gen(`x'_PrPd) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_PrPd, mi
}

egen total_posit_prof_pdocF = rownonmiss(pdocfinz1_PrPd pdocfinz2_PrPd pdocfinz3_PrPd pdocfinz4_PrPd pdocfinz5_PrPd) 
replace total_posit_prof_pdocF=. if pdocfinz1_PrPd==.

egen last_finz_prof_pdocF = rowlast(pdocfinz1_PrPd pdocfinz2_PrPd pdocfinz3_PrPd pdocfinz4_PrPd pdocfinz5_PrPd)
list pdocfinz1_PrPd pdocfinz2_PrPd pdocfinz3_PrPd pdocfinz4_PrPd pdocfinz5_PrPd total_posit_prof_pdocF last_finz_prof_pdocF if phase==3

gen last_first_prof_pdocF = last_finz_prof_pdocF - pdocfinz1_PrPd if total_posit_prof_pdocF>=2 & total_posit_prof_pdocF<.
list pdocfinz1_PrPd pdocfinz2_PrPd pdocfinz3_PrPd pdocfinz4_PrPd pdocfinz5_PrPd total_posit_prof_pdocF last_finz_prof_pdocF ///
last_first_prof_pdocF if phase==3

// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Profs/Postdocphase) 
gen diff_prof_pdocF21 = pdocfinz2_PrPd - pdocfinz1_PrPd if total_posit_prof_pdocF==3
gen diff_prof_pdocF32 = pdocfinz3_PrPd - pdocfinz2_PrPd if total_posit_prof_pdocF==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_prof_pdocphF_0 = anycount(diff_prof_pdocF21 diff_prof_pdocF32), values(0) 
egen verlauf_prof_pdocphF_mx = anycount(diff_prof_pdocF21 diff_prof_pdocF32), values(-1,-2,-3,-4) 
egen verlauf_prof_pdocphF_px = anycount(diff_prof_pdocF21 diff_prof_pdocF32), values(1,2,3,4) 

// Erzeugung der Verlaufsvariable "Verlauf_prom_promph" für die Promovierenden während Promotionsphase
gen verlauf_prof_pdocphF=.
replace verlauf_prof_pdocphF=1 if verlauf_prof_pdocphF_mx==2
replace verlauf_prof_pdocphF=2 if verlauf_prof_pdocphF_mx==1 & verlauf_prof_pdocphF_0==1 
replace verlauf_prof_pdocphF=3 if verlauf_prof_pdocphF_0==2 
replace verlauf_prof_pdocphF=4 if verlauf_prof_pdocphF_px==1 & verlauf_prof_pdocphF_mx==1 
replace verlauf_prof_pdocphF=5 if verlauf_prof_pdocphF_px==1 & verlauf_prof_pdocphF_0==1 
replace verlauf_prof_pdocphF=6 if verlauf_prof_pdocphF_px==2 
label values verlauf_prof_pdocphF verlauf_lb
label var verlauf_prof_pdocphF "Verlauf finz.-Bewertung der Stellen der Profs/Postdocphase"

// Drop Hilfsvariablen
drop verlauf_prof_pdocphF_mx verlauf_prof_pdocphF_px verlauf_prof_pdocphF_0

recode verlauf_prof_pdocphF (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_prof_pdocphF_r)
lab values verlauf_prof_pdocphF_r verlauf_rec_lb


***************************************
************* Postdocs/Promotionsphase
***************************************

foreach x of varlist promfinz1-promfinz5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==2, gen(`x'_PdPr) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_PdPr, mi
}

egen total_posit_pdoc_promF = rownonmiss(promfinz1_PdPr promfinz2_PdPr promfinz3_PdPr promfinz4_PdPr promfinz5_PdPr) 
replace total_posit_pdoc_promF=. if promfinz1_PdPr==.

egen last_finz_pdoc_promF = rowlast(promfinz1_PdPr promfinz2_PdPr promfinz3_PdPr promfinz4_PdPr promfinz5_PdPr)
list promfinz1_PdPr promfinz2_PdPr promfinz3_PdPr promfinz4_PdPr promfinz5_PdPr total_posit_pdoc_promF last_finz_pdoc_promF if phase==2

gen last_first_pdoc_promF = last_finz_pdoc_promF - promfinz1_PdPr if total_posit_pdoc_promF>=2 & total_posit_pdoc_promF<.
list promfinz1_PdPr promfinz2_PdPr promfinz3_PdPr promfinz4_PdPr promfinz5_PdPr total_posit_pdoc_promF last_finz_pdoc_promF ///
last_first_pdoc_promF if phase==2

// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Pdocs/promphase) 
gen diff_pdoc_promF21 = promfinz2_PdPr - promfinz1_PdPr if total_posit_pdoc_promF==3
gen diff_pdoc_promF32 = promfinz3_PdPr - promfinz2_PdPr if total_posit_pdoc_promF==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_pdoc_promphF_0 = anycount(diff_pdoc_promF21 diff_pdoc_promF32), values(0) 
egen verlauf_pdoc_promphF_mx = anycount(diff_pdoc_promF21 diff_pdoc_promF32), values(-1,-2,-3,-4) 
egen verlauf_pdoc_promphF_px = anycount(diff_pdoc_promF21 diff_pdoc_promF32), values(1,2,3,4) 

// Erzeugung der Verlaufsvariable "Verlauf_prom_promph" für die Promovierenden während Promotionsphase
gen verlauf_pdoc_promphF=.
replace verlauf_pdoc_promphF=1 if verlauf_pdoc_promphF_mx==2
replace verlauf_pdoc_promphF=2 if verlauf_pdoc_promphF_mx==1 & verlauf_pdoc_promphF_0==1 
replace verlauf_pdoc_promphF=3 if verlauf_pdoc_promphF_0==2 
replace verlauf_pdoc_promphF=4 if verlauf_pdoc_promphF_px==1 & verlauf_pdoc_promphF_mx==1 
replace verlauf_pdoc_promphF=5 if verlauf_pdoc_promphF_px==1 & verlauf_pdoc_promphF_0==1 
replace verlauf_pdoc_promphF=6 if verlauf_pdoc_promphF_px==2 
label values verlauf_pdoc_promphF verlauf_lb
label var verlauf_pdoc_promphF "Verlauf finz.-Bewertung der Stellen der Pdocs/promphase"

// Drop Hilfsvariablen
drop verlauf_pdoc_promphF_mx verlauf_pdoc_promphF_px verlauf_pdoc_promphF_0

recode verlauf_pdoc_promphF (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_pdoc_promphF_r)
lab values verlauf_pdoc_promphF_r verlauf_rec_lb


********************************************************************************
********************** Stellenumfang Vollzeit- Teilzeit *********************
*******************************************************************************

// Promovierende/Promotionsphase    

// Als nächstes wird die letzte Stelle fixiert
egen total_posit_promU = rownonmiss(stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5) if phase==1
replace total_posit_promU=. if stpromoumf1==.
// Wer hatte bei der letzten/aktuellen Stelle vollzeit oder teilzeit?
egen last_umf_prom = rowlast(stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5) if phase==1
list stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5 total_posit_promU last_umf_prom if phase==1
// Bewertung (In Zahlen) der letzten/aktuellen Stelle - Bewertung (in Zahlen) der ersten Stelle 
gen last_first_promU = last_umf_prom - stpromoumf1 if total_posit_promU>=2 & total_posit_promU<.
list stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5 total_posit_promU last_umf_prom last_first_promU if phase==1

// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Promovierende/Promphase) 
gen diff_promU21 = stpromoumf2 - stpromoumf1 if total_posit_promU==3
gen diff_promU32 = stpromoumf3 - stpromoumf2 if total_posit_promU==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_prom_promphU_0 = anycount(diff_promU21 diff_promU32), values(0) // Konstant
egen verlauf_prom_promphU_mx = anycount(diff_promU21 diff_promU32), values(-1,-2) // Abnahme
egen verlauf_prom_promphU_px = anycount(diff_promU21 diff_promU32), values(1,2) // Zunahme

// Erzeugung der Verlaufsvariable "Verlauf_prom_promphU" für die Promovierenden während Promotionsphase
gen verlauf_prom_promphU=.
replace verlauf_prom_promphU=1 if verlauf_prom_promphU_mx==2 
replace verlauf_prom_promphU=2 if verlauf_prom_promphU_mx==1 & verlauf_prom_promphU_0==1 
replace verlauf_prom_promphU=3 if verlauf_prom_promphU_0==2 
replace verlauf_prom_promphU=4 if verlauf_prom_promphU_px==1 & verlauf_prom_promphU_mx==1 
replace verlauf_prom_promphU=5 if verlauf_prom_promphU_px==1 & verlauf_prom_promphU_0==1 
replace verlauf_prom_promphU=6 if verlauf_prom_promphU_px==2 
label values verlauf_prom_promphU verlauf_lb
label var verlauf_prom_promphU "Verlauf des Stellenumfangs unter 50%/50-75%/>=75% der Promovierenden/Promotionsphase"

// Drop Hilfsvariablen
drop verlauf_prom_promphU_mx verlauf_prom_promphU_px verlauf_prom_promphU_0

recode verlauf_prom_promphU (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_prom_promphU_r)
lab values verlauf_prom_promphU_r verlauf_rec_lb

// Postdocs/Postdocphase

// Als nächstes wird die letzte Stelle fixiert 
egen total_posit_pdocU = rownonmiss(stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5) if phase==2
replace total_posit_pdocU=. if stpdocumf1==.
// Wer hatte bei der letzten/aktuellen Stelle vollzeit oder teilzeit?
egen last_umf_pdoc = rowlast(stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5) if phase==2
list stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5 total_posit_pdocU last_umf_pdoc if phase==2
// Bewertung (In Zahlen) der letzten/aktuellen Stelle - Bewertung (in Zahlen) der ersten Stelle 
gen last_first_pdocU = last_umf_pdoc - stpdocumf1 if total_posit_pdocU>=2 & total_posit_pdocU<.
list stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5 total_posit_pdocU last_umf_pdoc last_first_pdocU if phase==2

// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Promovierende/Promphase) 
gen diff_pdocU21 = stpdocumf2 - stpdocumf1 if total_posit_pdocU==3
gen diff_pdocU32 = stpdocumf3 - stpdocumf2 if total_posit_pdocU==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_pdoc_pdocphU_0 = anycount(diff_pdocU21 diff_pdocU32), values(0) // Konstant
egen verlauf_pdoc_pdocphU_mx = anycount(diff_pdocU21 diff_pdocU32), values(-1,-2) // Abnahme
egen verlauf_pdoc_pdocphU_px = anycount(diff_pdocU21 diff_pdocU32), values(1,2) // Zunahme

// Erzeugung der Verlaufsvariable "Verlauf_pdoc_pdocph" für die Postdocs während Postdocphase
gen verlauf_pdoc_pdocphU=.
replace verlauf_pdoc_pdocphU=1 if verlauf_pdoc_pdocphU_mx==2 
replace verlauf_pdoc_pdocphU=2 if verlauf_pdoc_pdocphU_mx==1 & verlauf_pdoc_pdocphU_0==1 
replace verlauf_pdoc_pdocphU=3 if verlauf_pdoc_pdocphU_0==2 
replace verlauf_pdoc_pdocphU=4 if verlauf_pdoc_pdocphU_px==1 & verlauf_pdoc_pdocphU_mx==1 
replace verlauf_pdoc_pdocphU=5 if verlauf_pdoc_pdocphU_px==1 & verlauf_pdoc_pdocphU_0==1 
replace verlauf_pdoc_pdocphU=6 if verlauf_pdoc_pdocphU_px==2 
label values verlauf_pdoc_pdocphU verlauf_lb
label var verlauf_pdoc_pdocphU "Verlauf des Stellenumfangs unter 50%/50-75%/>=75% der Postdocs/Postdocphase"

// Drop Hilfsvariablen
drop verlauf_pdoc_pdocphU_mx verlauf_pdoc_pdocphU_px verlauf_pdoc_pdocphU_0

recode verlauf_pdoc_pdocphU (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_pdoc_pdocphU_r)
lab values verlauf_pdoc_pdocphU_r verlauf_rec_lb

         ********************************************************************************
*************************************** PHASENÜBERGREIFEND ***************************************
		 ********************************************************************************

// Profesoren/Promotionsphase

// Als nächstes wird die letzte Stelle fixiert
egen total_posit_PrPrU = rownonmiss(stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5) if phase==3
replace total_posit_PrPrU=. if stpromoumf1==.
// Wer hatte bei der letzten/aktuellen Stelle vollzeit oder teilzeit?
egen last_umf_PrPrU = rowlast(stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5) if phase==3
list stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5 total_posit_PrPrU last_umf_PrPrU if phase==3
// Bewertung (In Zahlen) der letzten/aktuellen Stelle - Bewertung (in Zahlen) der ersten Stelle 
gen last_first_PrPrU = last_umf_PrPrU - stpromoumf1 if total_posit_PrPrU>=2 & total_posit_PrPrU<.
list phase stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5 total_posit_PrPrU last_umf_PrPrU last_first_PrPrU if phase==3

// Profesoren/Postdocphase

// Als nächstes wird die letzte Stelle fixiert
egen total_posit_PrPdU = rownonmiss(stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5) if phase==3
replace total_posit_PrPdU=. if stpdocumf1==.
// Wer hatte bei der letzten/aktuellen Stelle vollzeit oder teilzeit?
egen last_umf_PrPdU = rowlast(stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5) if phase==3
list stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5 total_posit_PrPdU last_umf_PrPdU if phase==3
// Bewertung (In Zahlen) der letzten/aktuellen Stelle - Bewertung (in Zahlen) der ersten Stelle 
gen last_first_PrPdU = last_umf_PrPdU - stpdocumf1 if total_posit_PrPdU>=2 & total_posit_PrPdU<.
list phase stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5 total_posit_PrPdU last_umf_PrPdU last_first_PrPdU if phase==3

// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Promovierende/Promphase) 
gen diff_PrPdU21 = stpdocumf2 - stpdocumf1 if total_posit_PrPdU==3
gen diff_PrPdU32 = stpdocumf3 - stpdocumf2 if total_posit_PrPdU==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_prof_pdocphU_0 = anycount(diff_PrPdU21 diff_PrPdU32), values(0) // Konstant
egen verlauf_prof_pdocphU_mx = anycount(diff_PrPdU21 diff_PrPdU32), values(-1,-2) // Abnahme
egen verlauf_prof_pdocphU_px = anycount(diff_PrPdU21 diff_PrPdU32), values(1,2) // Zunahme

// Erzeugung der Verlaufsvariable "Verlauf_pdoc_pdocph" für die Postdocs während Postdocphase
gen verlauf_prof_pdocphU=.
replace verlauf_prof_pdocphU=1 if verlauf_prof_pdocphU_mx==2 
replace verlauf_prof_pdocphU=2 if verlauf_prof_pdocphU_mx==1 & verlauf_prof_pdocphU_0==1 
replace verlauf_prof_pdocphU=3 if verlauf_prof_pdocphU_0==2 
replace verlauf_prof_pdocphU=4 if verlauf_prof_pdocphU_px==1 & verlauf_prof_pdocphU_mx==1 
replace verlauf_prof_pdocphU=5 if verlauf_prof_pdocphU_px==1 & verlauf_prof_pdocphU_0==1 
replace verlauf_prof_pdocphU=6 if verlauf_prof_pdocphU_px==2 
label values verlauf_prof_pdocphU verlauf_lb
label var verlauf_prof_pdocphU "Verlauf des Stellenumfangs unter 50%/50-75%/>=75% der Professoren/Postdocphase"

// Drop Hilfsvariablen
drop verlauf_prof_pdocphU_mx verlauf_prof_pdocphU_px verlauf_prof_pdocphU_0

recode verlauf_prof_pdocphU (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_prof_pdocphU_r)
lab values verlauf_prof_pdocphU_r verlauf_rec_lb

// Postdocs/Promotionsphase

// Als nächstes wird die letzte Stelle fixiert 
egen total_posit_PdPrU = rownonmiss(stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5) if phase==2
replace total_posit_PdPrU=. if stpromoumf1==.
// Wer hatte bei der letzten/aktuellen Stelle vollzeit oder teilzeit?
egen last_umf_PdPrU = rowlast(stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5) if phase==2
list phase stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5 total_posit_PdPrU last_umf_PdPr if phase==2
// Bewertung (In Zahlen) der letzten/aktuellen Stelle - Bewertung (in Zahlen) der ersten Stelle 
gen last_first_PdPrU = last_umf_PdPrU - stpromoumf1 if total_posit_PdPrU>=2 & total_posit_PdPrU<.
list phase stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5 total_posit_PdPrU last_umf_PdPr last_first_PdPrU if phase==2

// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Promovierende/Promphase) 
gen diff_PdPrU21 = stpromoumf2 - stpromoumf1 if total_posit_PdPrU==3
gen diff_PdPrU32 = stpromoumf3 - stpromoumf2 if total_posit_PdPrU==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_pdoc_promphU_0 = anycount(diff_PdPrU21 diff_PdPrU32), values(0) // Konstant
egen verlauf_pdoc_promphU_mx = anycount(diff_PdPrU21 diff_PdPrU32), values(-1,-2) // Abnahme
egen verlauf_pdoc_promphU_px = anycount(diff_PdPrU21 diff_PdPrU32), values(1,2) // Zunahme

// Erzeugung der Verlaufsvariable "Verlauf_pdoc_pdocph" für die Postdocs während Postdocphase
gen verlauf_pdoc_promphU=.
replace verlauf_pdoc_promphU=1 if verlauf_pdoc_promphU_mx==2 
replace verlauf_pdoc_promphU=2 if verlauf_pdoc_promphU_mx==1 & verlauf_pdoc_promphU_0==1 
replace verlauf_pdoc_promphU=3 if verlauf_pdoc_promphU_0==2 
replace verlauf_pdoc_promphU=4 if verlauf_pdoc_promphU_px==1 & verlauf_pdoc_promphU_mx==1 
replace verlauf_pdoc_promphU=5 if verlauf_pdoc_promphU_px==1 & verlauf_pdoc_promphU_0==1 
replace verlauf_pdoc_promphU=6 if verlauf_pdoc_promphU_px==2 
label values verlauf_pdoc_promphU verlauf_lb
label var verlauf_pdoc_promphU "Verlauf des Stellenumfangs unter 50%/50-75%/>=75% der Postdocs/Promotionsphase"

recode verlauf_pdoc_promphU (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_pdoc_promphU_r)
lab values verlauf_pdoc_promphU_r verlauf_rec_lb
tab verlauf_pdoc_promphU_r

// Drop Hilfsvariablen
drop verlauf_pdoc_promphU_mx verlauf_pdoc_promphU_px verlauf_pdoc_promphU_0

*************************************************************************************************
******************************** Befristung/-Entfristung Ja/nein? *******************************
*************************************************************************************************

************* Profs/Promotionsphase
************* Viel zu wenige Fälle (stelle 1 = 5 unbefristet, stelle 2 = 2 unbefristet)

************* Profs/Postdocphase
************* Sehr wenige Fälle (stelle 1 = 13 unbefristet, stelle 2 = 9 unbefristet)

************* Postdocs/Promotionsphase
************* Sehr wenige Fälle (stelle 1 = 18 unbefristet, stelle 2 = 5 unbefristet)


***************************************
************* Postdocs/Postdocphase
*************************************** 

// 1 = befristet, 2 = unbefristet

// Als nächstes wird die letzte Stelle fixiert 
egen total_posit_PdocB = rownonmiss(stpdocbef1 stpdocbef2 stpdocbef3 stpdocbef4 stpdocbef5) if phase==2
replace total_posit_PdocB=. if stpromoumf1==.
// Wer hatte bei der letzten/aktuellen Stelle vollzeit oder teilzeit?
egen last_bef_Pdoc = rowlast(stpdocbef1 stpdocbef2 stpdocbef3 stpdocbef4 stpdocbef5) if phase==2
list phase stpdocbef1 stpdocbef2 stpdocbef3 stpdocbef4 stpdocbef5 total_posit_PdocB last_bef_Pdoc if phase==2
// Bewertung (In Zahlen) der letzten/aktuellen Stelle - Bewertung (in Zahlen) der ersten Stelle 
gen last_first_PdocB = last_bef_Pdoc - stpdocbef1 if total_posit_PdocB>=2 & total_posit_PdocB<.
list phase stpdocbef1 stpdocbef2 stpdocbef3 stpdocbef4 stpdocbef5 total_posit_PdocB last_bef_Pdoc last_first_PdocB if phase==2

// Bildung der Differenz zwischen 1. und 2. Stelle, sowie 2. und 3. Stelle (Promovierende/Promphase) 
gen diff_pdocB21 = stpdocbef2 - stpdocbef1 if total_posit_PdocB==3
gen diff_pdocB32 = stpdocbef3 - stpdocbef2 if total_posit_PdocB==3

// Mit egen + anycount werden die Bewertungen +,-,0 für die 3 Stellen d.h. 2 Übergänge gezählt
egen verlauf_pdoc_pdocphB_0 = anycount(diff_pdocB21 diff_pdocB32), values(0) // Konstant
egen verlauf_pdoc_pdocphB_mx = anycount(diff_pdocB21 diff_pdocB32), values(-1) // Abnahme
egen verlauf_pdoc_pdocphB_px = anycount(diff_pdocB21 diff_pdocB32), values(1) // Zunahme

// Erzeugung der Verlaufsvariable "Verlauf_pdoc_pdocph" für die Postdocs während Postdocphase
gen verlauf_pdoc_pdocphB=.
replace verlauf_pdoc_pdocphB=1 if verlauf_pdoc_pdocphB_mx==2 
replace verlauf_pdoc_pdocphB=2 if verlauf_pdoc_pdocphB_mx==1 & verlauf_pdoc_pdocphB_0==1 
replace verlauf_pdoc_pdocphB=3 if verlauf_pdoc_pdocphB_0==2 
replace verlauf_pdoc_pdocphB=4 if verlauf_pdoc_pdocphB_px==1 & verlauf_pdoc_pdocphB_mx==1 
replace verlauf_pdoc_pdocphB=5 if verlauf_pdoc_pdocphB_px==1 & verlauf_pdoc_pdocphB_0==1 
replace verlauf_pdoc_pdocphB=6 if verlauf_pdoc_pdocphB_px==2 
label values verlauf_pdoc_pdocphB verlauf_lb
label var verlauf_pdoc_pdocphB "Verlauf des Befristungsgrades Postdocs/Postdocphase"

recode verlauf_pdoc_pdocphB (1 2 = 1) (3 = 2) (4 = 3) (5 6 = 4), gen(verlauf_pdoc_pdocphB_r)
lab values verlauf_pdoc_pdocphB_r verlauf_rec_lb
tab verlauf_pdoc_pdocphB_r

// Drop Hilfsvariablen
drop verlauf_pdoc_pdocphB_mx verlauf_pdoc_pdocphB_px verlauf_pdoc_pdocphB_0



*************************************************************************************************
******************************** Worklife-Balance *******************************
*************************************************************************************************

// Variablen zum Rechnen (Nicht-Phasenübergreifend)

// Promovierende
foreach x of varlist prom_wlb1-prom_wlb5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==1, gen(`x'_WL) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab `x'_WL, mi
}

egen total_mean_promWL = rowmean(prom_wlb1_WL - prom_wlb5_WL) 
list id phase prom_wlb1_WL prom_wlb2_WL prom_wlb3_WL prom_wlb4_WL prom_wlb5_WL total_mean_promWL in 1/290 if phase==1
tab total_mean_promWL if phase==1, mi
sum total_mean_promWL if phase==1


// Postdocs
foreach x of varlist pdoc_wlb1-pdoc_wlb5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==2, gen(`x'_WL)  
		replace `x' =. if `x' > 2 & `x' < -2
		tab `x'_WL, mi
}

egen total_mean_pdocWL = rowmean(pdoc_wlb1_WL - pdoc_wlb5_WL) if pdoc_wlb1 != .
list id phase pdoc_wlb1_WL pdoc_wlb2_WL pdoc_wlb3_WL pdoc_wlb4_WL pdoc_wlb5_WL total_mean_pdocWL in 1/290 if phase==2
sum total_mean_pdocWL

by diszi, sort: sum total_mean_pdocWL

// Profs
foreach x of varlist prof_wlb1-prof_wlb5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==3, gen(`x'_WL)  
		replace `x' =. if `x' > 2 & `x' < -2
		tab `x'_WL, mi
}

egen total_mean_profWL = rowmean(prof_wlb1_WL - prof_wlb5_WL) if prof_wlb1 != .
list id phase prof_wlb1_WL prof_wlb2_WL prof_wlb3_WL prof_wlb4_WL prof_wlb5_WL total_mean_profWL in 1/290 if phase==3
sum total_mean_profWL

by diszi, sort: sum total_mean_profWL

// Phasenübergreifend (Promotionsphase)
foreach x of varlist prom_wlb1-prom_wlb5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2), gen(`x'_NP) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab `x'_NP, mi
}

egen total_mean_promph_WL = rowmean(prom_wlb1_NP - prom_wlb5_NP) if prom_wlb1 != .
list id phase prom_wlb1_NP prom_wlb2_NP prom_wlb3_NP prom_wlb4_NP prom_wlb5_NP total_mean_promph_WL in 1/1690 

by phase, sort: sum total_mean_promph_WL if phase==3
by phase, sort: sum total_mean_promph_WL if phase==2
by phase, sort: sum total_mean_promph_WL if phase==1

by diszi, sort: sum total_mean_promph_WL if phase==3
by diszi, sort: sum total_mean_promph_WL if phase==2

// Phasenübergreifend (Postdoc-Phase)
foreach x of varlist pdoc_wlb1-pdoc_wlb5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2), gen(`x'_NP) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab `x'_NP, mi
}

egen total_mean_pdocph_WL = rowmean(pdoc_wlb1_NP - pdoc_wlb5_NP) if pdoc_wlb1 != .
list id phase pdoc_wlb1_NP pdoc_wlb2_NP pdoc_wlb3_NP pdoc_wlb4_NP pdoc_wlb5_NP total_mean_pdocph_WL in 1/1690 

by phase, sort: sum total_mean_pdocph_WL if phase==3
by phase, sort: sum total_mean_pdocph_WL if phase==2

by diszi, sort: sum total_mean_pdocph_WL
by diszi, sort: sum total_mean_pdocph_WL if phase==3


******************************************************************
***************** Besoldungsgruppe der Professur *****************
******************************************************************

// Nachbearbeitungen Nicole vom 1.11.2022
// Wie viele wechseln von w2 auf w3 bzw. von c3 auf c4
gen w_prof_st1=.
replace w_prof_st1=1 if stprofart1==1 
replace w_prof_st1=2 if stprofart1==2 
label values w_prof_st1 wprof_lb
label var w_prof_st1 "W2 und W3-Professur (Stelle 1)"

gen w_prof_st2=.
replace w_prof_st2=1 if stprofart2==1 
replace w_prof_st2=2 if stprofart2==2 
label values w_prof_st2 wprof_lb
label var w_prof_st2 "W2 und W3-Professur (Stelle 2)"

gen w_prof_st3=.
replace w_prof_st3=1 if stprofart3==1 
replace w_prof_st3=2 if stprofart3==2
label values w_prof_st3 wprof_lb
label var w_prof_st3 "W2 und W3-Professur (Stelle 3)"

gen w_prof_st4=.
replace w_prof_st4=1 if stprofart4==1 
replace w_prof_st4=2 if stprofart4==2 
label values w_prof_st4 wprof_lb
label var w_prof_st4 "W2 und W3-Professur (Stelle 4)"

gen w_prof_st5=.
replace w_prof_st5=1 if stprofart5==1 
replace w_prof_st5=2 if stprofart5==2 
label values w_prof_st5 wprof_lb
label var w_prof_st5 "W2 und W3-Professur (Stelle 5)"

// Help variable
egen helpx = rownonmiss(w_prof_st1 w_prof_st2 w_prof_st3 w_prof_st4 w_prof_st5)
egen help_prof = rowmean(w_prof_st1 w_prof_st2 w_prof_st3 w_prof_st4 w_prof_st5) if helpx>=1
replace help_prof = . in 1081 // Wechsel von W3 auf W2 ? --> Auf missing gesetzt

gen w_prof=.
replace w_prof=1 if help_prof==1  // W2 beginnend und W2 bleibend
replace w_prof=2 if help_prof!=1 & help_prof!=2 & help_prof!=. // Wechsel von W2 auf W3
replace w_prof=3 if help_prof==2 // W3 beginnend und W3 bleibend
label define w_prof_lb 1 "W2 beginnend und/oder W2 bleibend" 2 "Wechsel von W2 auf W3" 3 "W3 beginnend und/oder W3 bleibend"
label values w_prof w_prof_lb
label var w_prof "W-Professuren"


**************************************************************************************************************
******************************** Weitere Codierungen (Recodierungen) *****************************************
**************************************************************************************************************


		    ********************************************************************************
	    *************  Stellenumfang (nach Phase + weitere Variablen usw.) *****************
		    ********************************************************************************

			
// Stellenumfang (PROMOTIONSPHASE)
// I1: Promotionsphase (>= 76 % immer, min 1 mal >= 76 %, immer >=50 % )
// I2: 1A_Mobi_SM_3_Results, Zeile 8-11
egen prom_stumf76 = anycount(stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5) if phase==1, values(3) // >= 76 %
egen prom_stumf50 = anycount(stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5) if phase==1, values(2) // >= 50 % 
egen prom_stumf0 = anycount(stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5) if phase==1, values(1) // < 50 %

gen prom_stumf=.
replace prom_stumf=1 if prom_stumf0>=1 & prom_stumf76==0 & prom_stumf50==0 & phase==1 // immer kleiner als 50 %
replace prom_stumf=2 if (prom_stumf50>=1 & prom_stumf76!=0) | (prom_stumf50>=1 & prom_stumf0!=0) & phase==1 // Mindestens 1 mal größer als 50 %
replace prom_stumf=3 if prom_stumf50>=1 & prom_stumf76==0 & prom_stumf0==0  & phase==1 // Immer größer als 50 %
replace prom_stumf=4 if (prom_stumf76>=1 & prom_stumf50!=0) | (prom_stumf76>=1 & prom_stumf0!=0) & phase==1 // Mindestens 1 mal größer als 76 %
replace prom_stumf=5 if prom_stumf76>=1 & prom_stumf50==0 & prom_stumf0==0 & phase==1 // Immer größer als 76 %
replace prom_stumf=. if stpromoumf1==. & phase==1
label define prom_stum_lb 1 "Immer kleiner als 50 %" 2 "Mind. 1 mal größer als 50 %" 3 "Immer größer als 50 %" /// 
						  4 "Mindestens 1 mal größer als 76 %" 5 "Immer größer als 76 %"
label values prom_stumf prom_stum_lb
label var prom_stumf "Stellenumfang Häufigkeit"


// Stellenumfang (POSTDOCPHASE)
// I1: Postdoc-Phase (>= 76 % immer, min 1 mal >= 76 %, immer >=50 % )
// I2: 1A_Mobi_SM_3_Results, Zeile 13-16
egen pdoc_stumf76 = anycount(stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5) if phase==2, values(3) // >= 76 %
egen pdoc_stumf50 = anycount(stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5) if phase==2, values(2) // >= 50 % 
egen pdoc_stumf0 = anycount(stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5) if phase==2, values(1) // < 50 %

gen pdoc_stumf=.
replace pdoc_stumf=1 if (pdoc_stumf50>=1 & pdoc_stumf76!=0) | (pdoc_stumf50>=1 & pdoc_stumf0!=0) & phase==2 // Mindestens 1 mal größer als 50 %
replace pdoc_stumf=2 if pdoc_stumf50>=1 & pdoc_stumf76==0 & pdoc_stumf0==0  & phase==2 // Immer größer als 50 %
replace pdoc_stumf=3 if (pdoc_stumf76>=1 & pdoc_stumf50!=0) | (pdoc_stumf76>=1 & pdoc_stumf0!=0) & phase==2 // Mindestens 1 mal größer als 76 %
replace pdoc_stumf=4 if pdoc_stumf76>=1 & pdoc_stumf50==0 & pdoc_stumf0==0 & phase==2 // Immer größer als 76 %
replace pdoc_stumf=. if stpdocumf1==. & phase==1
label define pdoc_umf_lb 1 "Mind. 1 mal größer als 50 %" 2 "Immer größer als 50 %" 3 "Mind. 1 mal größer als 76 %" 4 "Immer größer als 76 %"
label values pdoc_stumf pdoc_umf_lb
label var pdoc_stumf "Stellenumfang Häufigkeit"


*************************************************************************************
*********** SUBJEKTIVE PRESTIGEBEWERTUNG Promovierende/Promotionsphase **************
*************************************************************************************

// Mittelwert der Bewertungen über alle Stellen (Gesamt) und bei den drei Gruppen mit pos., neg. Differenz und Konstanz (Promovierende/Promotionsphase) 
egen total_mean_promprom = rowmean(promkarr1_NP - promkarr5_NP) if total_posit_prom<=5 & promkarr1_NP != .
egen stellen_sd = rowsd(promkarr1_NP - promkarr5_NP) if total_posit_prom>=2 & total_posit_prom<=5

// Durchschnittliche Prestigebewertung nach Fächern
// I2: Ergebnisse in 1A_Mobi_SM_3_Results, Zeile 65
egen prest_diszi = rowmean(promkarr1_NP promkarr2_NP promkarr3_NP promkarr4_NP promkarr5_NP) 


*************************************************************************************
*********** Durchschnittliche Promotionsdauer Promovierende, Pdocs, Profs ***********
*************************************************************************************

// Durchschnittliche Promotionsdauer bei den aktuell Promovierenden, Postdocs und Profs mit Stellenwechsel + Promodauer Länge <= 10 Jahre 
gen prom_stwchl=.
replace prom_stwchl=1 if stpromo>=2 & stpromo<=5 & phase==1  // Promovierende

gen pdoc_stwchl=.
replace pdoc_stwchl=1 if stpromo>=2 & stpromo<=5 & phase==2  // Postdocs

gen prof_stwchl=.
replace prof_stwchl=1 if stpromo>=2 & stpromo<=5 & phase==3  // Profs

// Differenz zw. erster und letzter Stelle unterschieden nach 1 - 2,99, 4 - 5,99, mindestens 6 Jahre Promotionsdauer
gen promdauer_kat=.
replace promdauer_kat=1 if promodauer>0 & promodauer<3 & phase==1
replace promdauer_kat=2 if promodauer>=3 & promodauer<6 & phase==1
replace promdauer_kat=3 if promodauer>=6 & promodauer<=20 & phase==1
label define promdkat_lb 1 "0 - 2,99" 2 "3 - 5,99" 3 ">=6 Jahre"
label values promdauer_kat promdkat_lb
label var promdauer_kat "Promotionsdauer kategorisiert für Promovierende/Promotionsphase"



					****************************************************************************************
					****************************************************************************************
					******* Operationalisierung der Variablen für Anova-Signifikanztest und tt-test ********
					****************************************************************************************
					****************************************************************************************
	
		******************************************************************************************
				*********** Subjektive Prestigebewertung Promovierende **************
		 ****************************************************************************************

// I1: Differenz zwischen erster und letzter Stelle (Prestigebwertung) nach Promotionsdauer (kategorisiert: 1 = 0 - 2,99, 1 = 3 - 5,99, 3 >= 6 Jahre)
// I2: Ergebnisse in 1A_Mobi_SM_3_Results, Zeile 44-52

// Gruppe 1
gen last_first_prom_g1 =.
replace last_first_prom_g1 = last_first_prom if promdauer_kat==1 & phase==1
sum last_first_prom_g1
// Gruppe 2
gen last_first_prom_g2 =.
replace last_first_prom_g2 = last_first_prom if promdauer_kat==2 & phase==1
sum last_first_prom_g2
// Gruppe 3
gen last_first_prom_g3 =.
replace last_first_prom_g3 = last_first_prom if promdauer_kat==3 & phase==1
sum last_first_prom_g3

// Generate UV
gen all_group_uv=.
replace all_group_uv=1 if last_first_prom_g1>=-1 & last_first_prom_g1<=2
replace all_group_uv=2 if last_first_prom_g2>=-3 & last_first_prom_g2<=4
replace all_group_uv=3 if last_first_prom_g3>=-2 & last_first_prom_g3<=2
label define all_lb 1 "Gruppe_1: 0-2,99 Jahre" 2 "Gruppe_2: 3-5,99 Jahre" 3 "Gruppe_3: Mindestens 6 Jahre"
label values all_group_uv all_lb
label var all_group_uv "Durchschnittliche Differenz erste letzte Stelle nach Promotionsdauer (Promovierende/Promotionsphase)"  
tab all_group_uv
// Generate AV
gen all_group_av=.
replace all_group_av=last_first_prom_g1 if all_group_uv==1
replace all_group_av=last_first_prom_g2 if all_group_uv==2
replace all_group_av=last_first_prom_g3 if all_group_uv==3

// Für ttest UV (Gruppe 1 und 3)
gen group1_3_uv=.
replace group1_3_uv=1 if last_first_prom_g1>=-1 & last_first_prom_g1<=2
replace group1_3_uv=2 if last_first_prom_g3>=-2 & last_first_prom_g3<=2
label define group1_3_lb 1 "Gruppe_1: 0-2,99 Jahre" 2 "Gruppe_3: Mindestens 6 Jahre"
label values group1_3_uv group1_3_lb
label var group1_3_uv "Durchschnittliche Differenz erste letzte Stelle nach Promotionsdauer (Promovierende/Promotionsphase)"  
// Generate AV
gen group1_3_av=.
replace group1_3_av=last_first_prom_g1 if group1_3_uv==1
replace group1_3_av=last_first_prom_g3 if group1_3_uv==2

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


****************************************************************************************************
*********** Subjektive Prestigebewertung Promovierende nach Disziplin **************
****************************************************************************************************

// I1: Finanzielle Stellenbewertung Promovierende/Promotionsphase nach Disziplin
// I2: Ergebnisse in 1A_Mobi_SM_3_Results, Zeile 72-79

// Gruppe 1
gen last_first_prom_F_g1 =.
replace last_first_prom_F_g1 = last_first_prom if diszi==1 & phase==1  // Biologie
sum last_first_prom_F_g1
// Gruppe 2
gen last_first_prom_F_g2 =.
replace last_first_prom_F_g2 = last_first_prom if diszi==2 & phase==1  // Informatik
sum last_first_prom_F_g2
// Gruppe 3
gen last_first_prom_F_g3 =.
replace last_first_prom_F_g3 = last_first_prom if diszi==3 & phase==1  // Soziologie
sum last_first_prom_F_g3

// Generate UV
gen all_group_uv_F=.
replace all_group_uv_F=1 if last_first_prom_F_g1>=-2 & last_first_prom_F_g1<=2
replace all_group_uv_F=2 if last_first_prom_F_g2>=-3 & last_first_prom_F_g2<=4
replace all_group_uv_F=3 if last_first_prom_F_g3>=-2 & last_first_prom_F_g3<=2
label define all_lbF 1 "Gruppe_1: Biologie" 2 "Gruppe_2: Informatik" 3 "Gruppe_3: Soziologie"
label values all_group_uv_F all_lbF
label var all_group_uv_F "Durchschnittliche Differenz erste letzte Stelle nach Fach (Promovierende/Promotionsphase)"  
tab all_group_uv_F
// Generate AV
gen all_group_avF=.
replace all_group_avF=last_first_prom_F_g1 if all_group_uv_F==1
replace all_group_avF=last_first_prom_F_g2 if all_group_uv_F==2
replace all_group_avF=last_first_prom_F_g3 if all_group_uv_F==3

// Für ttest UV (Gruppe 1 und 3) --> Biologie und Soziologie
gen group1_3_uv_F=.
replace group1_3_uv_F=1 if last_first_prom_F_g1>=-2 & last_first_prom_F_g1<=2
replace group1_3_uv_F=2 if last_first_prom_F_g3>=-2 & last_first_prom_F_g3<=2
label define group1_3_F_lb 1 "Gruppe_1: Biologie" 2 "Gruppe_3: Soziologie"
label values group1_3_uv_F group1_3_F_lb
label var group1_3_uv_F "Durchschnittliche Differenz erste letzte Stelle nach Fach (Promovierende/Promotionsphase)"  
tab group1_3_uv_F
// Generate AV
gen group1_3_av_F=.
replace group1_3_av_F=last_first_prom_F_g1 if group1_3_uv_F==1
replace group1_3_av_F=last_first_prom_F_g3 if group1_3_uv_F==2


*************************************************************************************
*********** SUBJEKTIVE PRESTIGEBEWERTUNG Postdocs/Postdocphase **************
*************************************************************************************

// Gruppe 1
gen last_first_pdoc_F_g1 =.
replace last_first_pdoc_F_g1 = last_first_pdoc if diszi==1 & phase==2  // Biologie
// Gruppe 2
gen last_first_pdoc_F_g2 =.
replace last_first_pdoc_F_g2 = last_first_pdoc if diszi==2 & phase==2  // Informatik
// Gruppe 3
gen last_first_pdoc_F_g3 =.
replace last_first_pdoc_F_g3 = last_first_pdoc if diszi==3 & phase==2  // Soziologie

// Generate UV
gen all_group_uv_Fpdoc=.
replace all_group_uv_Fpdoc=1 if last_first_pdoc_F_g1>=-3 & last_first_pdoc_F_g1<=3
replace all_group_uv_Fpdoc=2 if last_first_pdoc_F_g2>=-3 & last_first_pdoc_F_g2<=3
replace all_group_uv_Fpdoc=3 if last_first_pdoc_F_g3>=-2 & last_first_pdoc_F_g3<=3
label define all_lbFpdoc 1 "Gruppe_1: Biologie" 2 "Gruppe_2: Informatik" 3 "Gruppe_3: Soziologie"
label values all_group_uv_Fpdoc all_lbFpdoc
label var all_group_uv_Fpdoc "Durchschnittliche Differenz erste letzte Stelle nach Fach (Postdocphase/Postdocs)"  
tab all_group_uv_Fpdoc
// Generate AV
gen all_group_av_Fpdoc=.
replace all_group_av_Fpdoc=last_first_pdoc_F_g1 if all_group_uv_Fpdoc==1
replace all_group_av_Fpdoc=last_first_pdoc_F_g2 if all_group_uv_Fpdoc==2
replace all_group_av_Fpdoc=last_first_pdoc_F_g3 if all_group_uv_Fpdoc==3

// Für ttest UV (Gruppe 1 und 3) --> Biologie und Soziologie
gen group1_3_uv_F_pdoc=.
replace group1_3_uv_F_pdoc=1 if last_first_pdoc_F_g1>=-3 & last_first_pdoc_F_g1<=3
replace group1_3_uv_F_pdoc=2 if last_first_pdoc_F_g3>=-2 & last_first_pdoc_F_g3<=3
label values group1_3_uv_F_pdoc group1_3_F_lb
label var group1_3_uv_F_pdoc "Durchschnittliche Differenz erste letzte Stelle nach Fach (Postdocphase/Postdocs)"  
tab group1_3_uv_F_pdoc
// Generate AV
gen group1_3_av_Fpdoc=.
replace group1_3_av_Fpdoc=last_first_pdoc_F_g1 if group1_3_uv_F_pdoc==1
replace group1_3_av_Fpdoc=last_first_pdoc_F_g3 if group1_3_uv_F_pdoc==2


*************************************************************************************
*********** SUBJEKTIVE PRESTIGEBEWERTUNG Profs/Profphase, Pdocs/Pdoc-Phase **************
*************************************************************************************

// Pdocs/Pdoc-Phase. Durchschnittliche Prestigebewertung. Mittelwert der Bewertungen über alle Stellen hinweg 
egen total_mean_pdocpdoc = rowmean(pdockarr1_NP pdockarr2_NP pdockarr3_NP pdockarr4_NP pdockarr5_NP) if total_posit_pdoc<=5
// Pdocs/Pdoc-Phase. Durchschnittliche Prestigebewertung. Mittelwert der Bewertungen von Personen mit mindestens 2 Stellen
egen total_mean_pdocpdoc_st2 = rowmean(pdockarr1_NP pdockarr2_NP pdockarr3_NP pdockarr4_NP pdockarr5_NP) if total_posit_pdoc>=2 & total_posit_pdoc<=5 

// Profs/Profphase. Durchschnittliche Prestigebewertung. Mittelwert der Bewertungen über alle Stellen hinweg 
egen total_mean_profprof = rowmean(profkarr1_NP profkarr2_NP profkarr3_NP profkarr4_NP profkarr5_NP) if total_posit_prof<=5
// Profs/Profphase. Durchschnittliche Prestigebewertung. Mittelwert der Bewertungen von Personen mit mindestens 2 Stellen
egen total_mean_profprof_st2 = rowmean(profkarr1_NP profkarr2_NP profkarr3_NP profkarr4_NP profkarr5_NP) if total_posit_prof>=2 & total_posit_prof<=5



*************************************************************************************************************
************************* Finanzielle Bewertung der Stellen nach Phasen und Fach ****************************
*************************************************************************************************************

// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Promotionsphase/Promovierende)
egen total_mean_prompromFINZ = rowmean(promfinz1_NP - promfinz5_NP) if promfinz1_NP != .
// Stellenwechsler
egen total_mean_prompromFINZ_st2 = rowmean(promfinz1_NP - promfinz5_NP) if total_posit_prom>=2 & total_posit_prom<=5 & promfinz1_NP != .


// STELLENUMFANG PROMOVIERENDE Für Rückfrage von Nicole
*************** Promovierende/Promotionsphase  
gen          prom_umfang_st1_3kat= .
replace      prom_umfang_st1_3kat = 0 if phase==1 & stpromoart1 !=. & stpromoumf1==1 
replace      prom_umfang_st1_3kat = 1 if phase==1 & stpromoart1 !=. & stpromoumf1==2
replace      prom_umfang_st1_3kat = 2 if phase==1 & stpromoart1 !=. & stpromoumf1==3
label define UMF_LB 0 "Weniger als 50 %" 1 "zwischen 50 und 75 %" 2 "76 % bis 100 %-Stelle"
label values prom_umfang_st1_3kat UMF_LB
label var prom_umfang_st1_3kat "Arbeitsumfang der Stelle 1 (Promovierende/Promotionsphase)"

gen          prom_umfang_st2_3kat = .
replace      prom_umfang_st2_3kat = 0 if phase==1 & stpromoart2 !=. & stpromoumf2==1
replace      prom_umfang_st2_3kat = 1 if phase==1 & stpromoart2 !=. & stpromoumf2==2
replace      prom_umfang_st2_3kat = 2 if phase==1 & stpromoart2 !=. & stpromoumf2==3
label values prom_umfang_st2_3kat UMF_LB
label var prom_umfang_st2_3kat "Arbeitsumfang der Stelle 2 (Promovierende/Promotionsphase)"

gen          prom_umfang_st3_3kat = .
replace      prom_umfang_st3_3kat = 0 if phase==1 & stpromoart3 !=. & stpromoumf3==1
replace      prom_umfang_st3_3kat = 1 if phase==1 & stpromoart3 !=. & stpromoumf3==2
replace      prom_umfang_st3_3kat = 2 if phase==1 & stpromoart3 !=. & stpromoumf3==3
label values prom_umfang_st3_3kat UMF_LB
label var prom_umfang_st3_3kat "Arbeitsumfang der Stelle 3 (Promovierende/Promotionsphase)"

gen          prom_umfang_st4_3kat = .
replace      prom_umfang_st4_3kat = 0 if phase==1 & stpromoart4 !=. & stpromoumf4==1
replace      prom_umfang_st4_3kat = 1 if phase==1 & stpromoart4 !=. & stpromoumf4==2
replace      prom_umfang_st4_3kat = 2 if phase==1 & stpromoart4 !=. & stpromoumf4==3
label values prom_umfang_st4_3kat UMF_LB
label var prom_umfang_st4_3kat "Arbeitsumfang der Stelle 4 (Promovierende/Promotionsphase)"

gen          prom_umfang_st5_3kat = .
replace      prom_umfang_st5_3kat = 0 if phase==1 & stpromoart5 !=. & stpromoumf5==1
replace      prom_umfang_st5_3kat = 1 if phase==1 & stpromoart5 !=. & stpromoumf5==2
replace      prom_umfang_st5_3kat = 2 if phase==1 & stpromoart5 !=. & stpromoumf5==3
label values prom_umfang_st5_3kat UMF_LB
label var prom_umfang_st5_3kat "Arbeitsumfang der Stelle 5 (Promovierende/Promotionsphase)"

// Erzeugung einer 0/1-codierten Variable für alle fünf Stellen nach Stellenumfang (Promovierende/Promotionsphase)
egen prom_umf_help1 = anycount(prom_umfang_st1_3kat - prom_umfang_st5_3kat), values(0) // Anzahl <50 % Stellen
egen prom_umf_help2 = anycount(prom_umfang_st1_3kat - prom_umfang_st5_3kat), values(1) // Anzahl Teilzeitstellen
egen prom_umf_help3 = anycount(prom_umfang_st1_3kat - prom_umfang_st5_3kat), values(2) // Anzahl Vollzeitstellen

gen prom_umfang_B =.
replace prom_umfang_B=0 if prom_umf_help1>=1 & prom_umf_help1<. & prom_umf_help2==0 & prom_umf_help3==0
replace prom_umfang_B=1 if prom_umf_help2>=1 & prom_umf_help2<. & prom_umf_help3==0
replace prom_umfang_B=2 if prom_umf_help3>=1 & prom_umf_help3<.
replace prom_umfang_B=. if prom_umf_help1==0 & prom_umf_help2==0 & prom_umf_help3==0
label define UMF_LBnew 0 "<50 %" 1 "50 - 75 %" 2 "76% und mehr"
label values prom_umfang_B UMF_LBnew
label var prom_umfang_B "Verhältnis Vollzeittstellen zu Teilzeitstellen (Promovierende, Promotionsphase)"


// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Postdoc-Phase/Postdocs)
egen total_mean_pdocpdocFINZ = rowmean(pdocfinz1_NP - pdocfinz5_NP) if pdocfinz1_NP != .
// Stellenwechsler
egen total_mean_pdocpdocFINZ_st2 = rowmean(pdocfinz1_NP - pdocfinz5_NP) if total_posit_pdoc>=2 & total_posit_pdoc<=5 & pdocfinz1_NP != .

// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Prof-Phase/Profs)
egen total_mean_profprofFINZ = rowmean(proffinz1_NP - proffinz5_NP) if proffinz1_NP != . 
// Stellenwechsler
egen total_mean_profprofFINZ_st2 = rowmean(proffinz1_NP - proffinz5_NP) if total_posit_prof>=2 & total_posit_prof<=5 & proffinz1_NP != .


*************************************************************************************************************
************************* Subjektive Prestige-Bewertung der Stellen nach Phasen und Fach ****************************
*************************************************************************************************************

// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Promotionsphase/Promovierende)
egen total_mean_prompromPrest = rowmean(promkarr1_NP - promkarr5_NP) if promkarr1_NP != .
// Stellenwechsler
egen total_mean_prompromPrest_st2 = rowmean(promkarr1_NP - promkarr5_NP) if total_posit_prom>=2 & total_posit_prom<=5 & promkarr1_NP != .

// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Postdoc-Phase/Postdocs)
egen total_mean_pdocpdocPrest = rowmean(pdockarr1_NP - pdockarr5_NP) if pdockarr1_NP != .
// Stellenwechsler
egen total_mean_pdocpdocPrest_st2 = rowmean(pdockarr1_NP - pdockarr5_NP) if total_posit_pdoc>=2 & total_posit_pdoc<=5 & pdockarr1_NP != .


// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Prof-Phase/Profs)
egen total_mean_profprofPrest = rowmean(profkarr1_NP - profkarr5_NP) if profkarr1_NP != . 
// Stellenwechsler
egen total_mean_profprofPrest_st2 = rowmean(profkarr1_NP - profkarr5_NP) if total_posit_prof>=2 & total_posit_prof<=5 & profkarr1_NP != .



*~~~~~~~~ Gruppenvariable Promovierende/Promotionsphase erstellen
/*gen bwrtng_promprom=.
replace bwrtng_promprom=1 if total_mean_promprom < 0 & stellen_sd != 0 & total_posit_prom>=2 & total_posit_prom<=5 // Negative Bewertungsgruppe/Wechsel
replace bwrtng_promprom=2 if total_mean_promprom > 0 & stellen_sd != 0 & total_posit_prom>=2 & total_posit_prom<=5 // Positive Bewertungsgruppe/Wechsel
replace bwrtng_promprom=3 if stellen_sd == 0 & total_posit_prom>=2 & total_posit_prom<=5 // Konstant (Keine Veränderung)
replace bwrtng_promprom=4 if total_mean_promprom == 0 & total_posit_prom>=2 & total_posit_prom<=5 // Neutral bei 0
label define bwrtng_lb 1 "Verändernd/Negative Bewertungsgruppe" 2 "Verändernd/Positive Bewertungsgruppe" 3 "Konstante Gruppe" 4 "Neutrale Gruppe"
label values bwrtng_promprom bwrtng_lb
label var bwrtng_promprom "Durchschnittliche subjektive Prestige-Bewertung der Promovierenden/Promotionsphase (Mean)"
tab bwrtng_promprom

list id promkarr1_NP promkarr2_NP promkarr3_NP promkarr4_NP promkarr5_NP total_mean_promprom stellen_sd bwrtng_promprom if phase==1 in 1/500
*~~~~~~~~~~ Mittelwerte der einzelnen Gruppen
sum total_mean_promprom if bwrtng_promprom==1 // Mean = -.8190476 --> Negative Bewertungsgruppe/Wechsel
sum total_mean_promprom if bwrtng_promprom==2 // Mean =  .7713964 --> Positive Bewertungsgruppe/Wechsel
sum total_mean_promprom if bwrtng_promprom==3 // Mean =  .5873016 --> Konstante Gruppe



*******************************************************************************
*************** Prestige-Bewertung der einzlenen Stellen (Mittelwert) *****************
********************************************************************************

// For-Schleife zur Recodierung der Variable Karriere/Prestige
// 0=neutral, plus = positiv, minus = negativ

// Promotionsphase
foreach x of varlist promkarr1-promkarr5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2), gen(`x'_M_NP)  
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_M_NP, mi
}

egen total_M_NP_promphase = rowmean(promkarr1_M_NP - promkarr5_M_NP) if promkarr1_M_NP != .
// egen stellen_sd = rowsd(promkarr1_NP - promkarr5_NP) if total_posit_prom>=2 & total_posit_prom<=5
list id phase promkarr1_M_NP promkarr2_M_NP promkarr3_M_NP promkarr4_M_NP promkarr5_M_NP total_M_NP_promphase in 1/1680
by phase, sort: sum total_M_NP_promphase if phase==1

// Postdoc-Phase
foreach x of varlist pdockarr1-pdockarr5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2), gen(`x'_M_NP) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_M_NP, mi
}

egen total_mean_pdocph_M_NP = rowmean(pdockarr1_M_NP - pdockarr5_M_NP) if pdockarr1_M_NP != .
// egen stellen_sd = rowsd(promkarr1_NP - promkarr5_NP) if total_posit_prom>=2 & total_posit_prom<=5
list id phase pdockarr1_M_NP pdockarr2_M_NP pdockarr3_M_NP pdockarr4_M_NP pdockarr5_M_NP total_mean_pdocph_M_NP in 1/1690
by phase, sort: sum total_mean_pdocph_M_NP


// Prof-Phase
foreach x of varlist profkarr1-profkarr5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2), gen(`x'_M_NP) 
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_M_NP, mi
}

egen total_mean_profph_M_NP = rowmean(profkarr1_M_NP - profkarr5_M_NP) if profkarr1_M_NP != .
// egen stellen_sd = rowsd(promkarr1_NP - promkarr5_NP) if total_posit_prom>=2 & total_posit_prom<=5
list id phase profkarr1_M_NP profkarr2_M_NP profkarr3_M_NP profkarr4_M_NP profkarr5_M_NP total_mean_profph_M_NP in 1/1680
by phase, sort: sum total_mean_profph_M_NP


// Ergänzung 2 Nicole
// Ist subjektive Prestigebewertung bei der gegenwärtigen Stelle höher als die entsprechende in der Promotionsphase
sum total_mean_pdocph if phase==2
sum total_mean_promph if phase==2


// Ergänzung 3 Finanzielle Situation
foreach x of varlist promfinz1-promfinz5 {
    	recode `x' (5=2) (4=1) (3=0) (2=-1) (1=-2) if phase==1, gen(`x'_NF)  
		replace `x' =. if `x' > 2 & `x' < -2
		tab1 `x'_NF, mi
}

egen total_mean_promFinz = rowmean(promfinz1_NF - promfinz5_NF) if promfinz1_NF != .
// egen stellen_sd = rowsd(promkarr1_NP - promkarr5_NP) if total_posit_prom>=2 & total_posit_prom<=5
list id phase promfinz1_NF promfinz2_NF promfinz3_NF promfinz4_NF promfinz5_NF total_mean_promFinz if phase==1 in 1/300
by diszi, sort: sum total_mean_promFinz
by prom_umfang_B, sort: sum total_mean_promFinz*/	

recode relwisskar1 (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(karriere_mot)
label define karrmot_lb 1 "Sehr unwichtig" 5 "Sehr wichtig"
label values karriere_mot karrmot_lb
label var karriere_mot "Wie wichtig ist es Ihnen, später einmal eine Professur zu erhalten?"
tab karriere_mot 

// Allgemeine Lebenszufriedenheit
rename allgzufr_SQ001 zufriedenheit

// Datensatz speichern
save "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\SM_02.dta", replace 

