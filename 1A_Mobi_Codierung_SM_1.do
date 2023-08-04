*********************************************************************************************************
	 *************************** Operationalisierung der sozialen Mobilität **********************
*********************************************************************************************************

// Datensatz einlesen
use "C:\Users\sonon001\Desktop\Online-Fragebogen\Mobi_BN.dta", clear 

numlabel _all, add


********************************************************************************
********************************************************************************
*************** Erzeugung Variablen Prestige-Bewertung Stellen *****************
********************************************************************************
********************************************************************************

// Promovierende/Promotionsphase

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Promotionsphase
** Stelle 1, Promotion
gen          prom_prest_st1_n = .
replace      prom_prest_st1_n = 0 if stpromoart1 !=. & promkarr1 >= 1 & promkarr1 <= 3 & phase == 1
replace      prom_prest_st1_n = 1 if stpromoart1 !=. & promkarr1 >= 4 & promkarr1 <= 5 & phase == 1
label values prom_prest_st1_n ho_ni
label var    prom_prest_st1_n "Hohes/niedriges Prestige Stelle 1 (Promotion, Promovierende)"
tab prom_prest_st1_n

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Promotionsphase
** Stelle 2, Promotion
gen          prom_prest_st2_n = .
replace      prom_prest_st2_n = 0 if stpromoart2 !=. & promkarr2 >= 1 & promkarr2 <= 3 & phase == 1
replace      prom_prest_st2_n = 1 if stpromoart2 !=. & promkarr2 >= 4 & promkarr2 <= 5 & phase == 1
label values prom_prest_st2_n ho_ni
label var    prom_prest_st2_n "Hohes/niedriges Prestige Stelle 2 (Promotion, Promovierende)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Promotionsphase
** Stelle 3, Promotion
gen          prom_prest_st3_n = .
replace      prom_prest_st3_n = 0 if stpromoart3 !=. & promkarr3 >= 1 & promkarr3 <= 3 & phase == 1
replace      prom_prest_st3_n = 1 if stpromoart3 !=. & promkarr3 >= 4 & promkarr3 <= 5 & phase == 1
label values prom_prest_st3_n ho_ni
label var    prom_prest_st3_n "Hohes/niedriges Prestige Stelle 3 (Promotion, Promovierende)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Promotionsphase
** Stelle 4, Promotion
gen          prom_prest_st4_n = .
replace      prom_prest_st4_n = 0 if stpromoart4 !=. & promkarr4 >= 1 & promkarr4 <= 3 & phase == 1
replace      prom_prest_st4_n = 1 if stpromoart4 !=. & promkarr4 >= 4 & promkarr4 <= 5 & phase == 1
label values prom_prest_st4_n ho_ni
label var    prom_prest_st4_n "Hohes/niedriges Prestige Stelle 4 (Promotion, Promovierende)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Promotionsphase
** Stelle 5, Promotion
gen          prom_prest_st5_n = .
replace      prom_prest_st5_n = 0 if stpromoart5 !=. & promkarr5 >= 1 & promkarr5 <= 3 & phase == 1
replace      prom_prest_st5_n = 1 if stpromoart5 !=. & promkarr5 >= 4 & promkarr5 <= 5 & phase == 1
label values prom_prest_st5_n ho_ni
label var    prom_prest_st5_n "Hohes/niedriges Prestige Stelle 5 (Promotion, Promovierende)"


********* Aggregierte Variablen ********
// Gesamt-Prestige-Variable Hilfsvariable 1 und Hilfsvariable 2 mit egen
egen prom_prest_help1 = anycount(prom_prest_st1_n - prom_prest_st5_n), values(1) // Hohe Bewertung
egen prom_prest_help2 = anycount(prom_prest_st1_n - prom_prest_st5_n), values(0) // Niedrige Bewertung

gen prom_prest_all_n=.
replace prom_prest_all_n=1 if prom_prest_help1 > prom_prest_help2  
replace prom_prest_all_n=0 if prom_prest_help1 <= prom_prest_help2 
replace prom_prest_all_n=. if prom_prest_help1==0 & prom_prest_help2==0  
label define BEWERTER_lb 0 "Schlechte Bewertung" 1 "Gute Bewertung"
label values prom_prest_all_n BEWERTER_lb
label var prom_prest_all_n "Prestige-Bewertung aller Stellen (Promotion, Promovierende)"
tab prom_prest_all_n

drop prom_prest_help1 prom_prest_help2


// Postdocs in Postocphase Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Postdocphase
** Stelle 1, Postdoc
gen          pdoc_prest_st1_n = .
replace      pdoc_prest_st1_n = 0 if stpdocart1 !=. & pdockarr1 >= 1 & pdockarr1  <= 3 & phase == 2
replace      pdoc_prest_st1_n = 1 if stpdocart1 !=. & pdockarr1 >= 4 & pdockarr1 <= 5 & phase == 2
label values pdoc_prest_st1_n ho_ni
label var    pdoc_prest_st1_n "Hohes/niedriges Prestige Stelle 1 (Postdocphase, Postdocs)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Postdocphase
** Stelle 2, Postdoc
gen          pdoc_prest_st2_n = .
replace      pdoc_prest_st2_n = 0 if stpdocart2 !=. & pdockarr2 >= 1 & pdockarr2 <= 3 & phase == 2
replace      pdoc_prest_st2_n = 1 if stpdocart2 !=. & pdockarr2 >= 4 & pdockarr2 <= 5 & phase == 2
label values pdoc_prest_st2_n ho_ni
label var    pdoc_prest_st2_n "Hohes/niedriges Prestige Stelle 2 (Postdocphase, Postdocs)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Postdocphase
** Stelle 3, Postdoc
gen          pdoc_prest_st3_n = .
replace      pdoc_prest_st3_n = 0 if stpdocart3 !=. & pdockarr3 >= 1 & pdockarr3 <= 3 & phase == 2
replace      pdoc_prest_st3_n = 1 if stpdocart3 !=. & pdockarr3 >= 4 & pdockarr3 <= 5 & phase == 2
label values pdoc_prest_st3_n ho_ni
label var    pdoc_prest_st3_n "Hohes/niedriges Prestige Stelle 3 (Postdocphase, Postdocs)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Postdocphase
** Stelle 4, Postdoc
gen          pdoc_prest_st4_n = .
replace      pdoc_prest_st4_n = 0 if stpdocart4 !=. & pdockarr4 >= 1 & pdockarr4 <= 3 & phase == 2
replace      pdoc_prest_st4_n = 1 if stpdocart4 !=. & pdockarr4 >= 4 & pdockarr4 <= 5 & phase == 2
label values pdoc_prest_st4_n ho_ni
label var    pdoc_prest_st4_n "Hohes/niedriges Prestige Stelle 4 (Postdocphase, Postdocs)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Postdocphase
** Stelle 5, Postdoc
gen          pdoc_prest_st5_n = .
replace      pdoc_prest_st5_n = 0 if stpdocart5 !=. & pdockarr5 >= 1 & pdockarr5 <= 3 & phase == 2
replace      pdoc_prest_st5_n = 1 if stpdocart5 !=. & pdockarr5 >= 4 & pdockarr5 <= 5 & phase == 2
label values pdoc_prest_st5_n ho_ni
label var    pdoc_prest_st5_n "Hohes/niedriges Prestige Stelle 5 (Postdocphase, Postdocs)"


// Gesamt-Prestige-Variable Hilfsvariable 1 und Hilfsvariable 2 mit egen
egen pdoc_prest_help1 = anycount(pdoc_prest_st1_n - pdoc_prest_st5_n), values(1) // Hohe Bewertung
egen pdoc_prest_help2 = anycount(pdoc_prest_st1_n - pdoc_prest_st5_n), values(0) // Niedrige Bewertung

gen pdoc_prest_all_n =.
replace pdoc_prest_all_n=1 if pdoc_prest_help1 > pdoc_prest_help2
replace pdoc_prest_all_n=0 if pdoc_prest_help1 <= pdoc_prest_help2
replace pdoc_prest_all_n=. if pdoc_prest_help1==0 & pdoc_prest_help2==0
label values pdoc_prest_all_n BEWERTER_lb
label var pdoc_prest_all_n "Prestige-Bewertung aller Stellen (Postdocphase, Postdocs)"
tab pdoc_prest_all_n 

drop pdoc_prest_help1 pdoc_prest_help2


// Profs in Profphase Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Professorenphase
** Stelle 1, Profs
gen          prof_prest_st1_n = .
replace      prof_prest_st1_n = 0 if stprofart1 !=. & profkarr1  >= 1 & profkarr1  <= 3 & phase == 3
replace      prof_prest_st1_n = 1 if stprofart1 !=. & profkarr1  >= 4 & profkarr1  <= 5 & phase == 3
label values prof_prest_st1_n ho_ni
label var    prof_prest_st1_n "Hohes/niedriges Prestige Stelle 1 (Professor*innen, Professorenphase)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 
** Stelle 2, Profs
gen          prof_prest_st2_n = .
replace      prof_prest_st2_n = 0 if stprofart2 !=. & profkarr2 >= 1 & profkarr2 <= 3 & phase == 3
replace      prof_prest_st2_n = 1 if stprofart2 !=. & profkarr2 >= 4 & profkarr2 <= 5 & phase == 3
label values prof_prest_st2_n ho_ni
label var    prof_prest_st2_n "Hohes/niedriges Prestige Stelle 2 (Professor*innen, Professorenphase)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 
** Stelle 3, Profs
gen          prof_prest_st3_n = .
replace      prof_prest_st3_n = 0 if stprofart3 !=. & profkarr3 >= 1 & profkarr3 <= 3 & phase == 3
replace      prof_prest_st3_n = 1 if stprofart3 !=. & profkarr3 >= 4 & profkarr3 <= 5 & phase == 3
label values prof_prest_st3_n ho_ni
label var    prof_prest_st3_n "Hohes/niedriges Prestige Stelle 3 (Professor*innen, Professorenphase)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 
** Stelle 4, Profs
gen          prof_prest_st4_n = .
replace      prof_prest_st4_n = 0 if stprofart4 !=. & profkarr4 >= 1 & profkarr4 <= 3 & phase == 3
replace      prof_prest_st4_n = 1 if stprofart4 !=. & profkarr4 >= 4 & profkarr4 <= 5 & phase == 3
label values prof_prest_st4_n ho_ni
label var    prof_prest_st4_n "Hohes/niedriges Prestige Stelle 4 (Professor*innen, Professorenphase)"

**** Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 
** Stelle 5, Profs
gen          prof_prest_st5_n = .
replace      prof_prest_st5_n = 0 if stprofart5 !=. & pdockarr5 >= 1 & pdockarr5 <= 3 & phase == 3
replace      prof_prest_st5_n = 1 if stprofart5 !=. & pdockarr5 >= 4 & pdockarr5 <= 5 & phase == 3
label values prof_prest_st5_n ho_ni
label var    prof_prest_st5_n "Hohes/niedriges Prestige Stelle 5 (Professor*innen, Professorenphase)"


// Gesamt-Prestige-Variable Hilfsvariable 1 und Hilfsvariable 2 mit egen
egen prof_prest_help1 = anycount(prof_prest_st1_n - prof_prest_st5_n), values(1) // Hohe Bewertung
egen prof_prest_help2 = anycount(prof_prest_st1_n - prof_prest_st5_n), values(0) // Niedrige Bewertung

gen prof_prest_all_n =.
replace prof_prest_all_n=1 if prof_prest_help1 > prof_prest_help2
replace prof_prest_all_n=0 if prof_prest_help1 <= prof_prest_help2
replace prof_prest_all_n=. if prof_prest_help1==0 & prof_prest_help2==0
label values prof_prest_all_n BEWERTER_lb
label var prof_prest_all_n "Prestige-Bewertung aller Stellen (Professoren, Professorenphase)"
tab prof_prest_all_n 

drop prof_prest_help1 prof_prest_help2


// Postocs/Promotionsphsae
* Postdocs, Stelle 1, Promotion
gen          pdoc_prom_prest_st1_n = .
replace      pdoc_prom_prest_st1_n = 0 if stpromoart1 !=. & promkarr1 >= 1 & promkarr1 <= 3 & phase == 2
replace      pdoc_prom_prest_st1_n = 1 if stpromoart1 !=. & promkarr1 >= 4 & promkarr1 <= 5 & phase == 2
label values pdoc_prom_prest_st1_n ho_ni
label var    pdoc_prom_prest_st1_n "Hohes/niedriges Prestige Stelle 1 (Promotion, Postdocs)"

** Postdocs, Stelle 2, Promotion
gen          pdoc_prom_prest_st2_n = .
replace      pdoc_prom_prest_st2_n = 0 if stpromoart2 !=. & promkarr2 >= 1 & promkarr2 <= 3 & phase == 2
replace      pdoc_prom_prest_st2_n = 1 if stpromoart1 !=. & promkarr2 >= 4 & promkarr2 <= 5 & phase == 2
label values pdoc_prom_prest_st2_n ho_ni
label var    pdoc_prom_prest_st2_n "Hohes/niedriges Prestige Stelle 2 (Promotion, Postdocs)"

** Postdocs, Stelle 3, Promotion
gen          pdoc_prom_prest_st3_n = .
replace      pdoc_prom_prest_st3_n = 0 if stpromoart3 !=. & promkarr3 >= 1 & promkarr3 <= 3 & phase == 2
replace      pdoc_prom_prest_st3_n = 1 if stpromoart3 !=. & promkarr3 >= 4 & promkarr3 <= 5 & phase == 2
label values pdoc_prom_prest_st3_n ho_ni
label var    pdoc_prom_prest_st3_n "Hohes/niedriges Prestige Stelle 3 (Promotion, Postdocs)"

** Postdocs, Stelle 4, Promotion
gen          pdoc_prom_prest_st4_n = .
replace      pdoc_prom_prest_st4_n = 0 if stpromoart4 !=. & promkarr4 >= 1 & promkarr4 <= 3 & phase == 2
replace      pdoc_prom_prest_st4_n = 1 if stpromoart4 !=. & promkarr4 >= 4 & promkarr4 <= 5 & phase == 2
label values pdoc_prom_prest_st4_n ho_ni
label var    pdoc_prom_prest_st4_n "Hohes/niedriges Prestige Stelle 4 (Promotion, Postdocs)"

** Postdocs, Stelle 5, Promotion
gen          pdoc_prom_prest_st5_n = .
replace      pdoc_prom_prest_st5_n = 0 if stpromoart5 !=. & promkarr5 >= 1 & promkarr5 <= 3 & phase == 2
replace      pdoc_prom_prest_st5_n = 1 if stpromoart5 !=. & promkarr5 >= 4 & promkarr5 <= 5 & phase == 2
label values pdoc_prom_prest_st5_n ho_ni
label var    pdoc_prom_prest_st5_n "Hohes/niedriges Prestige Stelle 5 (Promotion, Postdocs)"


// Gesamt-Prestige-Variable Hilfsvariable 1 und Hilfsvariable 2 mit egen
egen pdoc_prom_help1 = anycount(pdoc_prom_prest_st1_n - pdoc_prom_prest_st5_n), values(1) // Hohe Bewertung
egen pdoc_prom_help2 = anycount(pdoc_prom_prest_st1_n - pdoc_prom_prest_st5_n), values(0) // Niedrige Bewertung

gen pdoc_prom_prest_all_n=.
replace pdoc_prom_prest_all_n=1 if pdoc_prom_help1 > pdoc_prom_help2
replace pdoc_prom_prest_all_n=0 if pdoc_prom_help1 <= pdoc_prom_help2
replace pdoc_prom_prest_all_n=. if pdoc_prom_help1==0 & pdoc_prom_help2==0
label values pdoc_prom_prest_all_n BEWERTER_lb
label var pdoc_prom_prest_all_n "Prestige-Bewertung aller Stellen (Promotionsphase, Postdocs)"
tab pdoc_prom_prest_all_n 

drop pdoc_prom_help1 pdoc_prom_help2


** Professor*innen, Stelle 1, Promotion
gen          prof_prom_prest_st1_n = .
replace      prof_prom_prest_st1_n = 0 if stpromoart1 !=. & promkarr1 >= 1 & promkarr1 <= 3 & phase == 3
replace      prof_prom_prest_st1_n = 1 if stpromoart1 !=. & promkarr1 >= 4 & promkarr1 <= 5 & phase == 3
label values prof_prom_prest_st1_n ho_ni
label var    prof_prom_prest_st1_n "Hohes/niedriges Prestige Stelle 1 (Promotion, Professor*innen)"

** Professor*innen, Stelle 2, Promotion
gen          prof_prom_prest_st2_n = .
replace      prof_prom_prest_st2_n = 0 if stpromoart2 !=. & promkarr2 >= 1 & promkarr2 <= 3 & phase == 3
replace      prof_prom_prest_st2_n = 1 if stpromoart2 !=. & promkarr2 >= 4 & promkarr2 <= 5 & phase == 3
label values prof_prom_prest_st2_n ho_ni
label var    prof_prom_prest_st2_n "Hohes/niedriges Prestige Stelle 2 (Promotion, Professor*innen)"

** Professor*innen, Stelle 3, Promotion
gen          prof_prom_prest_st3_n = .
replace      prof_prom_prest_st3_n = 0 if stpromoart3 !=. & promkarr3 >= 1 & promkarr3 <= 3 & phase == 3
replace      prof_prom_prest_st3_n = 1 if stpromoart3 !=. & promkarr3 >= 4 & promkarr3 <= 5 & phase == 3
label values prof_prom_prest_st3_n ho_ni
label var    prof_prom_prest_st3_n "Hohes/niedriges Prestige Stelle 3 (Promotion, Professor*innen)"

** Professor*innen, Stelle 4, Promotion
gen          prof_prom_prest_st4_n = .
replace      prof_prom_prest_st4_n = 0 if stpromoart4 !=. & promkarr4 >= 1 & promkarr4 <= 3 & phase == 3
replace      prof_prom_prest_st4_n = 1 if stpromoart4 !=. & promkarr4 >= 4 & promkarr4 <= 5 & phase == 3
label values prof_prom_prest_st4_n ho_ni
label var    prof_prom_prest_st4_n "Hohes/niedriges Prestige Stelle 4 (Promotion, Professor*innen)"

** Professor*innen, Stelle 5, Promotion
gen          prof_prom_prest_st5_n = .
replace      prof_prom_prest_st5_n = 0 if stpromoart5 !=. & promkarr5 >= 1 & promkarr5 <= 3 & phase == 3
replace      prof_prom_prest_st5_n = 1 if stpromoart5 !=. & promkarr5 >= 4 & promkarr5 <= 5 & phase == 3
label values prof_prom_prest_st5_n ho_ni
label var    prof_prom_prest_st5_n "Hohes/niedriges Prestige Stelle 5 (Promotion, Professor*innen)"

// Gesamt-Prestige-Variable Hilfsvariable 1 und Hilfsvariable 2 mit egen
egen prof_prom_help1 = anycount(prof_prom_prest_st1_n - prof_prom_prest_st5_n), values(1) // Hohe Bewertung
egen prof_prom_help2 = anycount(prof_prom_prest_st1_n - prof_prom_prest_st5_n), values(0) // Niedrige Bewertung

gen prof_prom_prest_all_n =.
replace prof_prom_prest_all_n=1 if prof_prom_help1 > prof_prom_help2
replace prof_prom_prest_all_n=0 if prof_prom_help1 <= prof_prom_help2
replace prof_prom_prest_all_n=. if prof_prom_help1==0 & prof_prom_help2==0
label values prof_prom_prest_all_n BEWERTER_lb
label var prof_prom_prest_all_n "Prestige-Bewertung aller Stellen (Promotionsphase, Professoren)"
tab prof_prom_prest_all_n 

drop prof_prom_help1 prof_prom_help2

// Bewertungen (Karriere/Prestige, hoch/niedrig) der Stellen 1 bis 5 Professor*innen, Postdocphase
** Professor*innen, Stelle 1, Postdocs
gen          prof_pdoc_prest_st1_n = .
replace      prof_pdoc_prest_st1_n = 0 if stpdocart1 !=. & pdockarr1 >= 1 & pdockarr1 <= 3 & phase == 3
replace      prof_pdoc_prest_st1_n = 1 if stpdocart1 !=. & pdockarr1 >= 4 & pdockarr1 <= 5 & phase == 3
label values prof_pdoc_prest_st1_n ho_ni
label var    prof_pdoc_prest_st1_n "Hohes/niedriges Prestige Stelle 1 (Postdocphase, Professor*innen)"

** Professor*innen, Stelle 2, Postdocs
gen          prof_pdoc_prest_st2_n = .
replace      prof_pdoc_prest_st2_n = 0 if stpdocart2 !=. & pdockarr2 >= 1 & pdockarr2 <= 3 & phase == 3
replace      prof_pdoc_prest_st2_n = 1 if stpdocart2 !=. & pdockarr2 >= 4 & pdockarr2 <= 5 & phase == 3
label values prof_pdoc_prest_st2_n ho_ni
label var    prof_pdoc_prest_st2_n "Hohes/niedriges Prestige Stelle 2 (Postdocphase, Professor*innen)"

** Professor*innen, Stelle 3, Postdocs
gen          prof_pdoc_prest_st3_n = .
replace      prof_pdoc_prest_st3_n = 0 if stpdocart3 !=. & pdockarr3 >= 1 & pdockarr3 <= 3 & phase == 3
replace      prof_pdoc_prest_st3_n = 1 if stpdocart3 !=. & pdockarr3 >= 4 & pdockarr3 <= 5 & phase == 3
label values prof_pdoc_prest_st3_n ho_ni
label var    prof_pdoc_prest_st3_n "Hohes/niedriges Prestige Stelle 3 (Postdocphase, Professor*innen)"

** Professor*innen, Stelle 4, Postdocs
gen          prof_pdoc_prest_st4_n = .
replace      prof_pdoc_prest_st4_n = 0 if stpdocart4 !=. & pdockarr4 >= 1 & pdockarr4 <= 3 & phase == 3
replace      prof_pdoc_prest_st4_n = 1 if stpdocart4 !=. & pdockarr4 >= 4 & pdockarr4 <= 5 & phase == 3
label values prof_pdoc_prest_st4_n ho_ni
label var    prof_pdoc_prest_st4_n "Hohes/niedriges Prestige Stelle 4 (Postdocphase, Professor*innen)"

** Professor*innen, Stelle 5, Postdocs
gen          prof_pdoc_prest_st5_n = .
replace      prof_pdoc_prest_st5_n = 0 if stpdocart5 !=. & pdockarr5 >= 1 & pdockarr5 <= 3 & phase == 3
replace      prof_pdoc_prest_st5_n = 1 if stpdocart5 !=. & pdockarr5 >= 4 & pdockarr5 <= 5 & phase == 3
label values prof_pdoc_prest_st5_n ho_ni
label var    prof_pdoc_prest_st5_n "Hohes/niedriges Prestige Stelle 5 (Postdocphase, Professor*innen)"

// Gesamt-Prestige-Variable Hilfsvariable 1 und Hilfsvariable 2 mit egen
egen prof_pdoc_help1 = anycount(prof_pdoc_prest_st1_n - prof_pdoc_prest_st5_n), values(1) // Hohe Bewertung
egen prof_pdoc_help2 = anycount(prof_pdoc_prest_st1_n - prof_pdoc_prest_st5_n), values(0) // Niedrige Bewertung

gen prof_pdoc_prest_all_n =.
replace prof_pdoc_prest_all_n=1 if prof_pdoc_help1 > prof_pdoc_help2
replace prof_pdoc_prest_all_n=0 if prof_pdoc_help1 <= prof_pdoc_help2
replace prof_pdoc_prest_all_n=. if prof_pdoc_help1==0 & prof_pdoc_help2==0
label values prof_pdoc_prest_all_n BEWERTER_lb
label var prof_pdoc_prest_all_n "Prestige-Bewertung aller Stellen (Postdocphase, Professoren)"
tab prof_pdoc_prest_all_n 

drop prof_pdoc_help1 prof_pdoc_help2


********************************************************************************
********************************************************************************
*************** Erzeugung Variablen finanzielle Bewertung Stellen **************
********************************************************************************
********************************************************************************


**** Bewertungen (Finanzielle Situation, gut/schlecht) der Stellen 1 bis 5 Promotionsphase
** Stelle 1, Promotion
gen          prom_finz_st1_n = .
replace      prom_finz_st1_n = 0 if stpromoart1 !=. & promfinz1 >= 1 & promfinz1 <= 3 & phase == 1
replace      prom_finz_st1_n = 1 if stpromoart1 !=. & promfinz1 >= 4 & promfinz1 <= 5 & phase == 1
label values prom_finz_st1_n gutschl
label var    prom_finz_st1_n "Gute/Schlechte finaz. Situation Stelle 1 (Promotion, Promovierende)"
tab prom_finz_st1_n

** Stelle 2, Promotion
gen          prom_finz_st2_n = .
replace      prom_finz_st2_n = 0 if stpromoart2 !=. & promfinz2 >= 1 & promfinz2 <= 3 & phase == 1
replace      prom_finz_st2_n = 1 if stpromoart2 !=. & promfinz2 >= 4 & promfinz2 <= 5 & phase == 1
label values prom_finz_st2_n gutschl
label var    prom_finz_st2_n "Gute/Schlechte finaz. Situation Stelle 2 (Promotion, Promovierende)"

** Stelle 3, Promotion
gen          prom_finz_st3_n = .
replace      prom_finz_st3_n = 0 if stpromoart3 !=. & promfinz3 >= 1 & promfinz3 <= 3 & phase == 1
replace      prom_finz_st3_n = 1 if stpromoart3 !=. & promfinz3 >= 4 & promfinz3 <= 5 & phase == 1
label values prom_finz_st3_n gutschl
label var    prom_finz_st3_n "Gute/Schlechte finaz. Situation Stelle 3 (Promotion, Promovierende)"

** Stelle 4, Promotion
gen          prom_finz_st4_n = .
replace      prom_finz_st4_n = 0 if stpromoart4 !=. & promfinz4 >= 1 & promfinz4 <= 3 & phase == 1
replace      prom_finz_st4_n = 1 if stpromoart4 !=. & promfinz4 >= 4 & promfinz4 <= 5 & phase == 1
label values prom_finz_st4_n gutschl
label var    prom_finz_st4_n "Gute/Schlechte finaz. Situation Stelle 4 (Promotion, Promovierende)"

** Stelle 5, Promotion
gen          prom_finz_st5_n = .
replace      prom_finz_st5_n = 0 if stpromoart5 !=. & promfinz5 >= 1 & promfinz5 <= 3 & phase == 1
replace      prom_finz_st5_n = 1 if stpromoart5 !=. & promfinz5 >= 4 & promfinz5 <= 5 & phase == 1
label values prom_finz_st5_n gutschl
label var    prom_finz_st5_n "Gute/Schlechte finaz. Situation Stelle 5 (Promotion, Promovierende)"


// Gesamt-Finanz-Variable Hilfsvariable 1 und Hilfsvariable 2 mit egen
egen prom_finz_help1 = anycount(prom_finz_st1_n - prom_finz_st5_n), values(1) // Hohe Bewertung
egen prom_finz_help2 = anycount(prom_finz_st1_n - prom_finz_st5_n), values(0) // Niedrige Bewertung

gen prom_finz_all_n=.
replace prom_finz_all_n=1 if prom_finz_help1 > prom_finz_help2
replace prom_finz_all_n=0 if prom_finz_help1 <= prom_finz_help2
replace prom_finz_all_n=. if prom_finz_help1==0 & prom_finz_help2==0
label values prom_finz_all_n BEWERTER_lb
label var prom_finz_all_n "Finanzielle Bewertung aller Stellen (Promotionsphase, Promovierende)"
tab prom_finz_all_n

// Für Signifikanztests
/*tab prom_finz_all_n diszi, chi2 V column
by diszi, sort: tab prom_finz_all_n if phase==1

gen diszi_bio_inf=.
replace diszi_bio_inf=1 if diszi==1
replace diszi_bio_inf=2 if diszi==2

gen diszi_bio_soz=.
replace diszi_bio_soz=1 if diszi==1
replace diszi_bio_soz=3 if diszi==3

gen diszi_inf_soz=.
replace diszi_inf_soz=2 if diszi==2
replace diszi_inf_soz=3 if diszi==3

ttest prom_finz_all_n, by(diszi_inf_soz)*/



drop prom_finz_help1 prom_finz_help2


**** Bewertungen (Finanzielle Situation, gut/schlecht) der Stellen 1 bis 5 Postdocphase
** Stelle 1, Postdocs
gen          pdoc_finz_st1_n = .
replace      pdoc_finz_st1_n = 0 if stpdocart1 !=. & pdocfinz1 >= 1 & pdocfinz1 <= 3 & phase == 2
replace      pdoc_finz_st1_n = 1 if stpdocart1 !=. & pdocfinz1 >= 4 & pdocfinz1 <= 5 & phase == 2
label values pdoc_finz_st1_n gutschl
label var    pdoc_finz_st1_n "Gute/Schlechte finaz. Situation Stelle 1 (Postdocphase, Postdocs)"

** Stelle 2, Postdocs
gen          pdoc_finz_st2_n = .
replace      pdoc_finz_st2_n = 0 if stpdocart2 !=. & pdocfinz2 >= 1 & pdocfinz2 <= 3 & phase == 2
replace      pdoc_finz_st2_n = 1 if stpdocart2 !=. & pdocfinz2 >= 4 & pdocfinz2 <= 5 & phase == 2
label values pdoc_finz_st2_n gutschl
label var    pdoc_finz_st2_n "Gute/Schlechte finaz. Situation Stelle 2 (Postdocphase, Postdocs)"

** Stelle 3, Postdocs
gen          pdoc_finz_st3_n = .
replace      pdoc_finz_st3_n = 0 if stpdocart3 !=. & pdocfinz3 >= 1 & pdocfinz3 <= 3 & phase == 2
replace      pdoc_finz_st3_n = 1 if stpdocart3 !=. & pdocfinz3 >= 4 & pdocfinz3 <= 5 & phase == 2
label values pdoc_finz_st3_n gutschl
label var    pdoc_finz_st3_n "Gute/Schlechte finaz. Situation Stelle 3 (Postdocphase, Postdocs)"

** Stelle 4, Postdocs
gen          pdoc_finz_st4_n = .
replace      pdoc_finz_st4_n = 0 if stpdocart4 !=. & pdocfinz4 >= 1 & pdocfinz4 <= 3 & phase == 2
replace      pdoc_finz_st4_n = 1 if stpdocart4 !=. & pdocfinz4 >= 4 & pdocfinz4 <= 5 & phase == 2
label values pdoc_finz_st4_n gutschl
label var    pdoc_finz_st4_n "Gute/Schlechte finaz. Situation Stelle 4 (Postdocphase, Postdocs)"

** Stelle 5, Postdocs
gen          pdoc_finz_st5_n = .
replace      pdoc_finz_st5_n = 0 if stpdocart5 !=. & pdocfinz5 >= 1 & pdocfinz5 <= 3 & phase == 2
replace      pdoc_finz_st5_n = 1 if stpdocart5 !=. & pdocfinz5 >= 4 & pdocfinz5 <= 5 & phase == 2
label values pdoc_finz_st5_n gutschl
label var    pdoc_finz_st5_n "Gute/Schlechte finaz. Situation Stelle 5 (Postdocphase, Postdocs)"


// Gesamt-Finanz-Variable Hilfsvariable 1 und Hilfsvariable 2 mit egen
egen pdoc_finz_help1 = anycount(pdoc_finz_st1_n - pdoc_finz_st5_n), values(1) // Hohe Bewertung
egen pdoc_finz_help2 = anycount(pdoc_finz_st1_n - pdoc_finz_st5_n), values(0) // Niedrige Bewertung

gen pdoc_finz_all_n=.
replace pdoc_finz_all_n=1 if pdoc_finz_help1 > pdoc_finz_help2
replace pdoc_finz_all_n=0 if pdoc_finz_help1 <= pdoc_finz_help2
replace pdoc_finz_all_n=. if pdoc_finz_help1==0 & pdoc_finz_help2==0
label values pdoc_finz_all_n BEWERTER_lb
label var pdoc_finz_all_n "Finanzielle Bewertung aller Stellen (Postdocphase, Postdocs)"
tab pdoc_finz_all_n


// Signifikanztests
/*tab pdoc_finz_all_n diszi, chi2 V column
by diszi, sort: tab pdoc_finz_all_n if phase==2

gen diszi_bio_inf=.
replace diszi_bio_inf=1 if diszi==1
replace diszi_bio_inf=2 if diszi==2

gen diszi_bio_soz=.
replace diszi_bio_soz=1 if diszi==1
replace diszi_bio_soz=3 if diszi==3

gen diszi_inf_soz=.
replace diszi_inf_soz=2 if diszi==2
replace diszi_inf_soz=3 if diszi==3

ttest pdoc_finz_all_n, by(diszi_inf_soz)*/

drop pdoc_finz_help1 pdoc_finz_help2


**** Bewertungen (Finanzielle Situation, gut/schlecht) der Stellen 1 bis 5 Professurphase
** Stelle 1, Professor*innen
gen          prof_finz_st1_n = .
replace      prof_finz_st1_n = 0 if stprofart1 !=. & proffinz1 >= 1 & proffinz1 <= 3 & phase == 3
replace      prof_finz_st1_n = 1 if stprofart1 !=. & proffinz1 >= 4 & proffinz1 <= 5 & phase == 3
label values prof_finz_st1_n gutschl
label var    prof_finz_st1_n "Gute/Schlechte finaz. Situation Stelle 1 (Professurphase, Professor*innen)"

** Stelle 2, Professor*innen
gen          prof_finz_st2_n = .
replace      prof_finz_st2_n = 0 if stprofart2 !=. & proffinz2 >= 1 & proffinz2 <= 3 & phase == 3
replace      prof_finz_st2_n = 1 if stprofart2 !=. & proffinz2 >= 4 & proffinz2 <= 5 & phase == 3
label values prof_finz_st2_n gutschl
label var    prof_finz_st2_n "Gute/Schlechte finaz. Situation Stelle 2 (Professurphase, Professor*innen)"

** Stelle 3, Professor*innen
gen          prof_finz_st3_n = .
replace      prof_finz_st3_n = 0 if stprofart3 !=. & proffinz3 >= 1 & proffinz3 <= 3 & phase == 3
replace      prof_finz_st3_n = 1 if stprofart3 !=. & proffinz3 >= 4 & proffinz3 <= 5 & phase == 3
label values prof_finz_st3_n gutschl
label var    prof_finz_st3_n "Gute/Schlechte finaz. Situation Stelle 3 (Professurphase, Professor*innen)"

** Stelle 4, Professor*innen
gen          prof_finz_st4_n = .
replace      prof_finz_st4_n = 0 if stprofart4 !=. & proffinz4 >= 1 & proffinz4 <= 3 & phase == 3
replace      prof_finz_st4_n = 1 if stprofart4 !=. & proffinz4 >= 4 & proffinz4 <= 5 & phase == 3
label values prof_finz_st4_n gutschl
label var    prof_finz_st4_n "Gute/Schlechte finaz. Situation Stelle 4 (Professurphase, Professor*innen)"

** Stelle 5, Professor*innen
gen          prof_finz_st5_n = .
replace      prof_finz_st5_n = 0 if stprofart5 !=. & proffinz5 >= 1 & proffinz5 <= 3 & phase == 3
replace      prof_finz_st5_n = 1 if stprofart5 !=. & proffinz5 >= 4 & proffinz5 <= 5 & phase == 3
label values prof_finz_st5_n gutschl
label var    prof_finz_st5_n "Gute/Schlechte finaz. Situation Stelle 5 (Professurphase, Professor*innen)"


** Erzeugung einer 0/1-codierten Variable für alle fünf Stellen mit Bewertung 
** (Professor*innen)// Gesamt-Finanz-Variable Hilfsvariable 1 und Hilfsvariable 2 mit egen
egen prof_finz_help1 = anycount(prof_finz_st1_n - prof_finz_st5_n), values(1) // Hohe Bewertung
egen prof_finz_help2 = anycount(prof_finz_st1_n - prof_finz_st5_n), values(0) // Niedrige Bewertung

gen prof_finz_all_n=.
replace prof_finz_all_n=1 if prof_finz_help1 > prof_finz_help2
replace prof_finz_all_n=0 if prof_finz_help1 <= prof_finz_help2
replace prof_finz_all_n=. if prof_finz_help1==0 & prof_finz_help2==0
label values prof_finz_all_n BEWERTER_lb
label var prof_finz_all_n "Finanzielle Bewertung aller Stellen (Professorenphase, Professoren)"
tab prof_finz_all_n


/// Bewertungen (Finanzielle Situation, gut/schlecht) der Stellen 1 bis 5 Postdocs, Promotionsphase
 ** Postdocs, Stelle 1, Promotion
gen          pdoc_prom_finz_st1_n = .
replace      pdoc_prom_finz_st1_n = 0 if stpromoart1 !=. & promfinz1 >= 1 & promfinz1 <= 3 & phase == 2
replace      pdoc_prom_finz_st1_n = 1 if stpromoart1 !=. & promfinz1 >= 4 & promfinz1 <= 5 & phase == 2
label values pdoc_prom_finz_st1_n gutschl
label var    pdoc_prom_finz_st1_n "Gute/Schlechte finanz. Situation Stelle 1 (Promotion, Postdocs)"

** Postdocs, Stelle 2, Promotion
gen          pdoc_prom_finz_st2_n = .
replace      pdoc_prom_finz_st2_n = 0 if stpromoart2 !=. & promfinz2 >= 1 & promfinz2 <= 3 & phase == 2
replace      pdoc_prom_finz_st2_n = 1 if stpromoart2 !=. & promfinz2 >= 4 & promfinz2 <= 5 & phase == 2
label values pdoc_prom_finz_st2_n gutschl
label var    pdoc_prom_finz_st2_n "Gute/Schlechte finanz. Situation Stelle 2 (Promotion, Postdocs)"

** Postdocs, Stelle 3, Promotion
gen          pdoc_prom_finz_st3_n = .
replace      pdoc_prom_finz_st3_n = 0 if stpromoart3 !=. & promfinz3 >= 1 & promfinz3 <= 3 & phase == 2
replace      pdoc_prom_finz_st3_n = 1 if stpromoart3 !=. & promfinz3 >= 4 & promfinz3 <= 5 & phase == 2
label values pdoc_prom_finz_st3_n gutschl
label var    pdoc_prom_finz_st3_n "Gute/Schlechte finanz. Situation Stelle 3 (Promotion, Postdocs)"

** Postdocs, Stelle 4, Promotion
gen          pdoc_prom_finz_st4_n = .
replace      pdoc_prom_finz_st4_n = 0 if stpromoart4 !=. & promfinz4 >= 1 & promfinz4 <= 3 & phase == 2
replace      pdoc_prom_finz_st4_n = 1 if stpromoart4 !=. & promfinz4 >= 4 & promfinz4 <= 5 & phase == 2
label values pdoc_prom_finz_st4_n gutschl
label var    pdoc_prom_finz_st4_n "Gute/Schlechte finanz. Situation Stelle 4 (Promotion, Postdocs)"

** Postdocs, Stelle 5, Promotion
gen          pdoc_prom_finz_st5_n = .
replace      pdoc_prom_finz_st5_n = 0 if stpromoart5 !=. & promfinz5 >= 1 & promfinz5 <= 3 & phase == 2
replace      pdoc_prom_finz_st5_n = 1 if stpromoart5 !=. & promfinz5 >= 4 & promfinz5 <= 5 & phase == 2
label values pdoc_prom_finz_st5_n gutschl
label var    pdoc_prom_finz_st5_n "Gute/Schlechte finanz. Situation Stelle 5 (Promotion, Postdocs)"


** Erzeugung einer 0/1-codierten Variable für alle fünf Stellen mit Bewertung der Postdocs für ihre Promotionsphase
// Gesamt-Prestige-Variable Hilfsvariable 1 und Hilfsvariable 2 mit egen
egen pdoc_prom_help1 = anycount(pdoc_prom_finz_st1_n - pdoc_prom_finz_st5_n), values(1) // Hohe Bewertung
egen pdoc_prom_help2 = anycount(pdoc_prom_finz_st1_n - pdoc_prom_finz_st5_n), values(0) // Niedrige Bewertung

gen pdoc_prom_finz_all_n =.
replace pdoc_prom_finz_all_n=1 if pdoc_prom_help1 > pdoc_prom_help2
replace pdoc_prom_finz_all_n=0 if pdoc_prom_help1 <= pdoc_prom_help2
replace pdoc_prom_finz_all_n=. if pdoc_prom_help1==0 & pdoc_prom_help2==0
label values pdoc_prom_finz_all_n BEWERTER_lb
label var pdoc_prom_finz_all_n "Finanzielle Bewertung aller Stellen (Promotionsphase, Postdocs)"
tab pdoc_prom_finz_all_n 

drop pdoc_prom_help1 pdoc_prom_help2


**** Bewertungen (Finanzielle Situation, gut/schlecht) der Stellen 1 bis 5 Professor*innen, Promotionsphase
 ** Professor*innen, Stelle 1, Promotion
gen          prof_prom_finz_st1_n = .
replace      prof_prom_finz_st1_n = 0 if stpromoart1 !=. & promfinz1 >= 1 & promfinz1 <= 3 & phase == 3
replace      prof_prom_finz_st1_n = 1 if stpromoart1 !=. & promfinz1 >= 4 & promfinz1 <= 5 & phase == 3
label values prof_prom_finz_st1_n gutschl
label var    prof_prom_finz_st1_n "Gute/Schlechte finanz. Situation Stelle 1 (Promotion, Professor*innen)"

** Professor*innen, Stelle 2, Promotion
gen          prof_prom_finz_st2_n = .
replace      prof_prom_finz_st2_n = 0 if stpromoart2 !=. & promfinz2 >= 1 & promfinz2 <= 3 & phase == 3
replace      prof_prom_finz_st2_n = 1 if stpromoart2 !=. & promfinz2 >= 4 & promfinz2 <= 5 & phase == 3
label values prof_prom_finz_st2_n gutschl
label var    prof_prom_finz_st2_n "Gute/Schlechte finanz. Situation Stelle 2 (Promotion, Professor*innen)"

** Professor*innen, Stelle 3, Promotion
gen          prof_prom_finz_st3_n = .
replace      prof_prom_finz_st3_n = 0 if stpromoart3 !=. & promfinz3 >= 1 & promfinz3 <= 3 & phase == 3
replace      prof_prom_finz_st3_n = 1 if stpromoart3 !=. & promfinz3 >= 4 & promfinz3 <= 5 & phase == 3
label values prof_prom_finz_st3_n gutschl
label var    prof_prom_finz_st3_n "Gute/Schlechte finanz. Situation Stelle 3 (Promotion, Professor*innen)"

** Professor*innen, Stelle 4, Promotion
gen          prof_prom_finz_st4_n = .
replace      prof_prom_finz_st4_n = 0 if stpromoart4 !=. & promfinz4 >= 1 & promfinz4 <= 3 & phase == 3
replace      prof_prom_finz_st4_n = 1 if stpromoart4 !=. & promfinz4 >= 4 & promfinz4 <= 5 & phase == 3
label values prof_prom_finz_st4_n gutschl
label var    prof_prom_finz_st4_n "Gute/Schlechte finanz. Situation Stelle 4 (Promotion, Professor*innen)"

** Professor*innen, Stelle 5, Promotion
gen          prof_prom_finz_st5_n = .
replace      prof_prom_finz_st5_n = 0 if stpromoart5 !=. & promfinz5 >= 1 & promfinz5 <= 3 & phase == 3
replace      prof_prom_finz_st5_n = 1 if stpromoart5 !=. & promfinz5 >= 4 & promfinz5 <= 5 & phase == 3
label values prof_prom_finz_st5_n gutschl
label var    prof_prom_finz_st5_n "Gute/Schlechte finanz. Situation Stelle 5 (Promotion, Professor*innen)"

** Erzeugung einer 0/1-codierten Variable für alle fünf Stellen mit Bewertung der Professor*innen für ihre Promotionsphase
egen prof_prom_help1 = anycount(prof_prom_finz_st1_n - prof_prom_finz_st5_n), values(1) // Hohe Bewertung
egen prof_prom_help2 = anycount(prof_prom_finz_st1_n - prof_prom_finz_st5_n), values(0) // Niedrige Bewertung

gen prof_prom_finz_all_n =.
replace prof_prom_finz_all_n=1 if prof_prom_help1 > prof_prom_help2
replace prof_prom_finz_all_n=0 if prof_prom_help1 <= prof_prom_help2
replace prof_prom_finz_all_n=. if prof_prom_help1==0 & prof_prom_help2==0
label values prof_prom_finz_all_n BEWERTER_lb
label var prof_prom_finz_all_n "Finanzielle Bewertung aller Stellen (Promotionsphase, Professoren)"
tab prof_prom_finz_all_n 

drop prof_prom_help1 prof_prom_help2


**** Bewertungen (Finanzielle Situation, gut/schlecht) der Stellen 1 bis 5 Professor*innen, Postdocphase
** Professor*innen, Stelle 1, Postdocs
gen          prof_pdoc_finz_st1_n = .
replace      prof_pdoc_finz_st1_n = 0 if stpdocart1 !=. & pdocfinz1 >= 1 & pdocfinz1 <= 3 & phase == 3
replace      prof_pdoc_finz_st1_n = 1 if stpdocart1 !=. & pdocfinz1 >= 4 & pdocfinz1 <= 5 & phase == 3
label values prof_pdoc_finz_st1_n gutschl
label var    prof_pdoc_finz_st1_n "Gute/Schlechte finanz. Situation Stelle 1 (Postdocphase, Professor*innen)"

** Professor*innen, Stelle 2, Postdocs
gen          prof_pdoc_finz_st2_n = .
replace      prof_pdoc_finz_st2_n = 0 if stpdocart2 !=. & pdocfinz2 >= 1 & pdocfinz2 <= 3 & phase == 3
replace      prof_pdoc_finz_st2_n = 1 if stpdocart2 !=. & pdockarr2 >= 4 & pdocfinz2 <= 5 & phase == 3
label values prof_pdoc_finz_st2_n gutschl
label var    prof_pdoc_finz_st2_n "Gute/Schlechte finanz. Situation Stelle 2 (Postdocphase, Professor*innen)"

** Professor*innen, Stelle 3, Postdocs
gen          prof_pdoc_finz_st3_n = .
replace      prof_pdoc_finz_st3_n = 0 if stpdocart3 !=. & pdocfinz3 >= 1 & pdocfinz3 <= 3 & phase == 3
replace      prof_pdoc_finz_st3_n = 1 if stpdocart3 !=. & pdocfinz3 >= 4 & pdocfinz3 <= 5 & phase == 3
label values prof_pdoc_finz_st3_n gutschl
label var    prof_pdoc_finz_st3_n "Gute/Schlechte finanz. Situation Stelle 3 (Postdocphase, Professor*innen)"

** Professor*innen, Stelle 4, Postdocs
gen          prof_pdoc_finz_st4_n = .
replace      prof_pdoc_finz_st4_n = 0 if stpdocart4 !=. & pdocfinz4 >= 1 & pdocfinz4 <= 3 & phase == 3
replace      prof_pdoc_finz_st4_n = 1 if stpdocart4 !=. & pdocfinz4 >= 4 & pdocfinz4 <= 5 & phase == 3
label values prof_pdoc_finz_st4_n gutschl
label var    prof_pdoc_finz_st4_n "Gute/Schlechte finanz. Situation Stelle 4 (Postdocphase, Professor*innen)"

** Professor*innen, Stelle 5, Postdocs
gen          prof_pdoc_finz_st5_n = .
replace      prof_pdoc_finz_st5_n = 0 if stpdocart5 !=. & pdocfinz5 >= 1 & pdocfinz5 <= 3 & phase == 3
replace      prof_pdoc_finz_st5_n = 1 if stpdocart5 !=. & pdocfinz5 >= 4 & pdocfinz5 <= 5 & phase == 3
label values prof_pdoc_finz_st5_n gutschl
label var    prof_pdoc_finz_st5_n "Gute/Schlechte finanz. Situation Stelle 5 (Postdocphase, Professor*innen)"

** Erzeugung einer 0/1-codierten Variable für alle fünf Stellen mit Bewertung der Professor*innen für ihre Postdocphase
egen prof_pdoc_help1 = anycount(prof_pdoc_finz_st1_n - prof_pdoc_finz_st5_n), values(1) // Hohe Bewertung
egen prof_pdoc_help2 = anycount(prof_pdoc_finz_st1_n - prof_pdoc_finz_st5_n), values(0) // Niedrige Bewertung

gen prof_pdoc_finz_all_n =.
replace prof_pdoc_finz_all_n=1 if prof_pdoc_help1 > prof_pdoc_help2
replace prof_pdoc_finz_all_n=0 if prof_pdoc_help1 <= prof_pdoc_help2
replace prof_pdoc_finz_all_n=. if prof_pdoc_help1==0 & prof_pdoc_help2==0
label values prof_pdoc_finz_all_n BEWERTER_lb
label var prof_pdoc_finz_all_n "Finanzielle Bewertung aller Stellen (Postdocphase, Professoren)"
tab prof_pdoc_finz_all_n 

drop prof_pdoc_help1 prof_pdoc_help2


**************************************************************************************************************
**************************************************************************************************************
******************************** Stellenumfang Vollzeit- Teilzeit ********************************************
**************************************************************************************************************
**************************************************************************************************************

*************** Promovierende/Promotionsphase  
gen          prom_umfang_st1_n = .
replace      prom_umfang_st1_n = 0 if phase==1 & stpromoart1 !=. & stpromoumf1>=1 & stpromoumf1<=2
replace      prom_umfang_st1_n = 1 if phase==1 & stpromoart1 !=. & stpromoumf1==3
label define UMF_lb 0 "75 % und Weniger" 1 "76 % bis 100 %-Stelle"
label values prom_umfang_st1_n UMF_lb
label var prom_umfang_st1_n "Arbeitsumfang der Stelle 1 (Promovierende/Promotionsphase)"

gen          prom_umfang_st2_n = .
replace      prom_umfang_st2_n = 0 if phase==1 & stpromoart2 !=. & stpromoumf2>=1 & stpromoumf2<=2
replace      prom_umfang_st2_n = 1 if phase==1 & stpromoart2 !=. & stpromoumf2==3
label values prom_umfang_st2_n UMF_lb
label var prom_umfang_st2_n "Arbeitsumfang der Stelle 2 (Promovierende/Promotionsphase)"

gen          prom_umfang_st3_n = .
replace      prom_umfang_st3_n = 0 if phase==1 & stpromoart3 !=. & stpromoumf3>=1 & stpromoumf3<=2
replace      prom_umfang_st3_n = 1 if phase==1 & stpromoart3 !=. & stpromoumf3==3
label values prom_umfang_st3_n UMF_lb
label var prom_umfang_st3_n "Arbeitsumfang der Stelle 3 (Promovierende/Promotionsphase)"

gen          prom_umfang_st4_n = .
replace      prom_umfang_st4_n = 0 if phase==1 & stpromoart4 !=. & stpromoumf4>=1 & stpromoumf4<=2
replace      prom_umfang_st4_n = 1 if phase==1 & stpromoart4 !=. & stpromoumf4==3
label values prom_umfang_st4_n UMF_lb
label var prom_umfang_st4_n "Arbeitsumfang der Stelle 4 (Promovierende/Promotionsphase)"

gen          prom_umfang_st5_n = .
replace      prom_umfang_st5_n = 0 if phase==1 & stpromoart5 !=. & stpromoumf5>=1 & stpromoumf5<=2
replace      prom_umfang_st5_n = 1 if phase==1 & stpromoart5 !=. & stpromoumf5==3
label values prom_umfang_st5_n UMF_lb
label var prom_umfang_st5_n "Arbeitsumfang der Stelle 5 (Promovierende/Promotionsphase)"
tab prom_umfang_st5_n

// Erzeugung einer 0/1-codierten Variable für alle fünf Stellen nach Stellenumfang (Promovierende/Promotionsphase)
/*egen prom_umf_help1 = anycount(prom_umfang_st1_n - prom_umfang_st5_n), values(1) // Anzahl Vollzeitstellen
egen prom_umf_help2 = anycount(prom_umfang_st1_n - prom_umfang_st5_n), values(0) // Anzahl Teilzeitstellen

gen prom_umfang_B =.
replace prom_umfang_B=1 if prom_umf_help1>=1 & prom_umf_help1<.  
replace prom_umfang_B=0 if prom_umf_help2>=1 & prom_umf_help1==0
replace prom_umfang_B=. if prom_umf_help1==0 & prom_umf_help2==0
label values prom_umfang_B UMF_lb
label var prom_umfang_B "Verhältnis Vollzeittstellen zu Teilzeitstellen (Promovierende, Promotionsphase)"
tab prom_umfang_B

gen prom_umfang_all_n =.
replace prom_umfang_all_n=1 if prom_umf_help1 > prom_umf_help2
replace prom_umfang_all_n=0 if prom_umf_help1 <= prom_umf_help2
replace prom_umfang_all_n=. if prom_umf_help1==0 & prom_umf_help2==0
label values prom_umfang_all_n UMF_lb
label var prom_umfang_all_n "Stellenumfang (Promovierende, Promotionsphase)"
tab prom_umfang_all_n 

by diszi, sort: tab prom_umfang_B 

drop prom_umf_help1 prom_umf_help2


********************** Postdocs/Postdocphase
gen          pdoc_umfang_st1_n = .
replace      pdoc_umfang_st1_n = 0 if phase==2 & stpdocart1 !=. & stpdocumf1>=1 & stpdocumf1<=2
replace      pdoc_umfang_st1_n = 1 if phase==2 & stpdocart1 !=. & stpdocumf1==3 
label values pdoc_umfang_st1_n UMF_lb
label var pdoc_umfang_st1_n "Arbeitsumfang der Stelle 1 (Postdocs/Postdocphase)"

gen          pdoc_umfang_st2_n = .
replace      pdoc_umfang_st2_n = 0 if phase==2 & stpdocart2 !=. & stpdocumf2>=1 & stpdocumf2<=2
replace      pdoc_umfang_st2_n = 1 if phase==2 & stpdocart2 !=. & stpdocumf2==3 
label values pdoc_umfang_st2_n UMF_lb
label var pdoc_umfang_st2_n "Arbeitsumfang der Stelle 2 (Postdocs/Postdocphase)"

gen          pdoc_umfang_st3_n = .
replace      pdoc_umfang_st3_n = 0 if phase==2 & stpdocart3 !=. & stpdocumf3>=1 & stpdocumf3<=2
replace      pdoc_umfang_st3_n = 1 if phase==2 & stpdocart3 !=. & stpdocumf3==3 
label values pdoc_umfang_st3_n UMF_lb
label var pdoc_umfang_st3_n "Arbeitsumfang der Stelle 3 (Postdocs/Postdocphase)"

gen          pdoc_umfang_st4_n = .
replace      pdoc_umfang_st4_n = 0 if phase==2 & stpdocart4 !=. & stpdocumf4>=1 & stpdocumf4<=2
replace      pdoc_umfang_st4_n = 1 if phase==2 & stpdocart4 !=. & stpdocumf4==3 
label values pdoc_umfang_st4_n UMF_lb
label var pdoc_umfang_st4_n "Arbeitsumfang der Stelle 4 (Postdocs/Postdocphase)"

gen          pdoc_umfang_st5_n = .
replace      pdoc_umfang_st5_n = 0 if phase==2 & stpdocart5 !=. & stpdocumf5>=1 & stpdocumf5<=2
replace      pdoc_umfang_st5_n = 1 if phase==2 & stpdocart5 !=. & stpdocumf5==3 
label values pdoc_umfang_st5_n UMF_lb
label var pdoc_umfang_st5_n "Arbeitsumfang der Stelle 5 (Postdocs/Postdocphase)"

// Erzeugung einer 0/1-codierten Variable für alle fünf Stellen nach Stellenumfang (Postdocs/Postdocphase)
egen pdoc_umf_help1 = anycount(pdoc_umfang_st1_n - pdoc_umfang_st5_n), values(1) // Anzahl Vollzeitstellen
egen pdoc_umf_help2 = anycount(pdoc_umfang_st1_n - pdoc_umfang_st5_n), values(0) // Anzahl Teilzeitstellen


gen pdoc_umfang_B =.
replace pdoc_umfang_B=1 if pdoc_umf_help1>=1 & pdoc_umf_help1<.  
replace pdoc_umfang_B=0 if pdoc_umf_help2>=1 & pdoc_umf_help1==0
replace pdoc_umfang_B=. if pdoc_umf_help1==0 & pdoc_umf_help2==0
label values pdoc_umfang_B UMF_lb
label var pdoc_umfang_B "Verhältnis Vollzeittstellen zu Teilzeitstellen (Postdocs, Postdocphase)"
tab pdoc_umfang_B

by diszi, sort: tab pdoc_umfang_B if phase==2

gen pdoc_umfang_all_n =.
replace pdoc_umfang_all_n=1 if pdoc_umf_help1 > pdoc_umf_help2
replace pdoc_umfang_all_n=0 if pdoc_umf_help1 <= pdoc_umf_help2
replace pdoc_umfang_all_n=. if pdoc_umf_help1==0 & pdoc_umf_help2==0
label values pdoc_umfang_all_n UMF_lb
label var pdoc_umfang_all_n "Stellenumfang (Postdocs, Promotionsphase)"
tab pdoc_umfang_all_n 

drop pdoc_umf_help1 pdoc_umf_help2


********************** Postdocs/Promotionsphase
gen          pdoc_prom_umfang_st1_n = .
replace      pdoc_prom_umfang_st1_n = 0 if phase==2 & stpromoart1 !=. & stpromoumf1>=1 & stpromoumf1<=2
replace      pdoc_prom_umfang_st1_n = 1 if phase==2 & stpromoart1 !=. & stpromoumf1==3 
label values pdoc_prom_umfang_st1_n UMF_lb
label var pdoc_prom_umfang_st1_n "Arbeitsumfang der Stelle 1 (Postdcos/Promotionsphase)"
tab pdoc_prom_umfang_st1_n

gen          pdoc_prom_umfang_st2_n = .
replace      pdoc_prom_umfang_st2_n = 0 if phase==2 & stpromoart2 !=. & stpromoumf2>=1 & stpromoumf2<=2
replace      pdoc_prom_umfang_st2_n = 1 if phase==2 & stpromoart2 !=. & stpromoumf2==3 
label values pdoc_prom_umfang_st2_n UMF_lb
label var pdoc_prom_umfang_st2_n "Arbeitsumfang der Stelle 2 (Postdcos/Promotionsphase)"

gen          pdoc_prom_umfang_st3_n = .
replace      pdoc_prom_umfang_st3_n = 0 if phase==2 & stpromoart3 !=. & stpromoumf3>=1 & stpromoumf3<=2
replace      pdoc_prom_umfang_st3_n = 1 if phase==2 & stpromoart3 !=. & stpromoumf3==3 
label values pdoc_prom_umfang_st3_n UMF_lb
label var pdoc_prom_umfang_st3_n "Arbeitsumfang der Stelle 3 (Postdcos/Promotionsphase)"

gen          pdoc_prom_umfang_st4_n = .
replace      pdoc_prom_umfang_st4_n = 0 if phase==2 & stpromoart4 !=. & stpromoumf4>=1 & stpromoumf4<=2
replace      pdoc_prom_umfang_st4_n = 1 if phase==2 & stpromoart4 !=. & stpromoumf4==3 
label values pdoc_prom_umfang_st4_n UMF_lb
label var pdoc_prom_umfang_st4_n "Arbeitsumfang der Stelle 4 (Postdcos/Promotionsphase)"

gen          pdoc_prom_umfang_st5_n = .
replace      pdoc_prom_umfang_st5_n = 0 if phase==2 & stpromoart5 !=. & stpromoumf5>=1 & stpromoumf5<=2
replace      pdoc_prom_umfang_st5_n = 1 if phase==2 & stpromoart5 !=. & stpromoumf5==3 
label values pdoc_prom_umfang_st5_n UMF_lb
label var pdoc_prom_umfang_st5_n "Arbeitsumfang der Stelle 5 (Postdcos/Promotionsphase)"


// Erzeugung einer 0/1-codierten Variable für alle fünf Stellen nach Stellenumfang (Postdocs/Postdocphase)
egen pdoc_prom_umf_help1 = anycount(pdoc_prom_umfang_st1_n - pdoc_prom_umfang_st5_n), values(1) // Anzahl Vollzeitstellen
egen pdoc_prom_umf_help2 = anycount(pdoc_prom_umfang_st1_n - pdoc_prom_umfang_st5_n), values(0) // Anzahl Teilzeitstellen


gen pdoc_prom_umfang_B =.
replace pdoc_prom_umfang_B=1 if pdoc_prom_umf_help1>=1 & pdoc_prom_umf_help1<.  
replace pdoc_prom_umfang_B=0 if pdoc_prom_umf_help2>=1 & pdoc_prom_umf_help1==0
replace pdoc_prom_umfang_B=. if pdoc_prom_umf_help1==0 & pdoc_prom_umf_help2==0
label values pdoc_prom_umfang_B UMF_lb
label var pdoc_prom_umfang_B "Verhältnis Vollzeittstellen zu Teilzeitstellen (Postdocs, Promotionsphase)"
tab pdoc_prom_umfang_B

gen pdoc_prom_umfang_all_n =.
replace pdoc_prom_umfang_all_n=1 if pdoc_prom_umf_help1 > pdoc_prom_umf_help2
replace pdoc_prom_umfang_all_n=0 if pdoc_prom_umf_help1 <= pdoc_prom_umf_help2
replace pdoc_prom_umfang_all_n=. if pdoc_prom_umf_help1==0 & pdoc_prom_umf_help2==0
label values pdoc_prom_umfang_all_n UMF_lb
label var pdoc_prom_umfang_all_n "Stellenumfang (Postdocs, Promotionsphase)"
tab pdoc_prom_umfang_all_n 

drop pdoc_prom_umf_help1 pdoc_prom_umf_help2*/

*************** evtl. noch "Profs/Promotionsphase" UND "Profs/Postdocphase"  (Eher nicht notwendig!)


*************************************************************************
*************************************************************************
******************* Unbefristete/Befristete Stelle **********************
*************************************************************************
*************************************************************************

*************** Promovierende/Promotionsphase  
gen          prom_befrist_st1_n = .
replace      prom_befrist_st1_n = 0 if phase==1 & stpromoart1 !=. & stpromobef1==1
replace      prom_befrist_st1_n = 1 if phase==1 & stpromoart1 !=. & stpromobef1==2
label define BEFRIST_lb 0 "Befristet" 1 "Unbefristet"
label values prom_befrist_st1_n BEFRIST_lb
label var prom_befrist_st1_n "Befristung 1 Stelle (Promovierende/Promotionsphase)"
tab prom_befrist_st1_n

gen          prom_befrist_st2_n = .
replace      prom_befrist_st2_n = 0 if phase==1 & stpromoart2 !=. & stpromobef2==1
replace      prom_befrist_st2_n = 1 if phase==1 & stpromoart2 !=. & stpromobef2==2
label values prom_befrist_st2_n BEFRIST_lb
label var prom_befrist_st2_n "Befristung 2 Stelle (Promovierende/Promotionsphase)"
tab prom_befrist_st2_n

gen          prom_befrist_st3_n = .
replace      prom_befrist_st3_n = 0 if phase==1 & stpromoart3 !=. & stpromobef3==1
replace      prom_befrist_st3_n = 1 if phase==1 & stpromoart3 !=. & stpromobef3==2
label values prom_befrist_st3_n BEFRIST_lb
label var prom_befrist_st3_n "Befristung 3 Stelle (Promovierende/Promotionsphase)"
tab prom_befrist_st3_n

gen          prom_befrist_st4_n = .
replace      prom_befrist_st4_n = 0 if phase==1 & stpromoart4 !=. & stpromobef4==1
replace      prom_befrist_st4_n = 1 if phase==1 & stpromoart4 !=. & stpromobef4==2
label values prom_befrist_st4_n BEFRIST_lb
label var prom_befrist_st4_n "Befristung 4 Stelle (Promovierende/Promotionsphase)"
tab prom_befrist_st4_n

gen          prom_befrist_st5_n = .
replace      prom_befrist_st5_n = 0 if phase==1 & stpromoart5 !=. & stpromobef5==1
replace      prom_befrist_st5_n = 1 if phase==1 & stpromoart5 !=. & stpromobef5==2
label values prom_befrist_st5_n BEFRIST_lb
label var prom_befrist_st5_n "Befristung 5 Stelle (Promovierende/Promotionsphase)"
tab prom_befrist_st5_n


// Wechsel von unbefristet auf befristet (N=1) sowie Wechsel von befristet auf unebfristet (N=3)
list id prom_befrist_st1_n prom_befrist_st2_n prom_befrist_st3_n if (prom_befrist_st1_n==1 & prom_befrist_st2_n==0 & phase==1) in 1/1698
list id prom_befrist_st1_n prom_befrist_st2_n prom_befrist_st3_n if (prom_befrist_st1_n==0 & prom_befrist_st2_n==1 & phase==1) in 1/1698

// Erzeugung einer 0/1-codierten Variable für alle fünf Stellen nach Stellenumfang (Promovierende/Promotionsphase)
egen prom_befrist_help1 = anycount(prom_befrist_st1_n - prom_befrist_st5_n), values(1) // Anzahl unbefristete Stellen
egen prom_befrist_help2 = anycount(prom_befrist_st1_n - prom_befrist_st5_n), values(0) // Anzahl befristete Stellen

gen prom_befrist_B =.
replace prom_befrist_B=1 if prom_befrist_help1 >= 1 & prom_befrist_help1 <.  
replace prom_befrist_B=0 if prom_befrist_help2 >= 1 & prom_befrist_help1==0
replace prom_befrist_B=. if prom_befrist_help1==0 & prom_befrist_help2==0
label values prom_befrist_B BEFRIST_lb
label var prom_befrist_B "Durchschnittliche Befristung über alle Stellen (Promovierende, Promotionsphase)"
tab prom_befrist_B

// Als nächstes wird die letzte Stelle fixiert und der entsprechende Prestigewert dieser Stelle bestimmt
/*egen total_posit_prom = rownonmiss(prom_befrist_st1_n prom_befrist_st2_n prom_befrist_st3_n prom_befrist_st4_n prom_befrist_st5_n)
replace total_posit_prom=. if prom_befrist_st1_n==.
sum total_posit_prom  // --> 1,36 Stellen im Schnitt*/

gen prom_befrist_all_n =.
replace prom_befrist_all_n=1 if prom_befrist_help1 >= prom_befrist_help2  
replace prom_befrist_all_n=0 if prom_befrist_help1 < prom_befrist_help2   
replace prom_befrist_all_n=. if prom_befrist_help1==0 & prom_befrist_help2==0
label values prom_befrist_all_n BEFRIST_lb
label var prom_befrist_all_n "Durchschnittliche Befristung über alle Stellen (Promovierende, Promotionsphase)"
tab prom_befrist_all_n 

drop prom_befrist_help1 prom_befrist_help2

*************** Postdocs/Postdocphase  
gen          pdoc_befrist_st1_n = .
replace      pdoc_befrist_st1_n = 0 if phase==2 & stpdocart1 !=. & stpdocbef1==1
replace      pdoc_befrist_st1_n = 1 if phase==2 & stpdocart1 !=. & stpdocbef1==2
label values pdoc_befrist_st1_n BEFRIST_lb
label var pdoc_befrist_st1_n "Befristung 1 Stelle (Postdocs/Postdocphase)"
tab pdoc_befrist_st1_n

gen          pdoc_befrist_st2_n = .
replace      pdoc_befrist_st2_n = 0 if phase==2 & stpdocart2 !=. & stpdocbef2==1
replace      pdoc_befrist_st2_n = 1 if phase==2 & stpdocart2 !=. & stpdocbef2==2
label values pdoc_befrist_st2_n BEFRIST_lb
label var pdoc_befrist_st2_n "Befristung 2 Stelle (Postdocs/Postdocphase)"
tab pdoc_befrist_st2_n

gen          pdoc_befrist_st3_n = .
replace      pdoc_befrist_st3_n = 0 if phase==2 & stpdocart3 !=. & stpdocbef3==1
replace      pdoc_befrist_st3_n = 1 if phase==2 & stpdocart3 !=. & stpdocbef3==2
label values pdoc_befrist_st3_n BEFRIST_lb
label var pdoc_befrist_st3_n "Befristung 3 Stelle (Postdocs/Postdocphase)"
tab pdoc_befrist_st3_n

gen          pdoc_befrist_st4_n = .
replace      pdoc_befrist_st4_n = 0 if phase==2 & stpdocart4 !=. & stpdocbef4==1
replace      pdoc_befrist_st4_n = 1 if phase==2 & stpdocart4 !=. & stpdocbef4==2
label values pdoc_befrist_st4_n BEFRIST_lb
label var pdoc_befrist_st4_n "Befristung 4 Stelle (Postdocs/Postdocphase)"
tab pdoc_befrist_st4_n

gen          pdoc_befrist_st5_n = .
replace      pdoc_befrist_st5_n = 0 if phase==2 & stpdocart5 !=. & stpdocbef5==1
replace      pdoc_befrist_st5_n = 1 if phase==2 & stpdocart5 !=. & stpdocbef5==2
label values pdoc_befrist_st5_n BEFRIST_lb
label var pdoc_befrist_st5_n "Befristung 5 Stelle (Postdocs/Postdocphase)"
tab pdoc_befrist_st5_n

// Erzeugung einer 0/1-codierten Variable für alle fünf Stellen Befristung (Postdocs/Postdocphase)
egen pdoc_befrist_help1 = anycount(pdoc_befrist_st1_n - pdoc_befrist_st5_n), values(1) // Anzahl unbefristete Stellen
egen pdoc_befrist_help2 = anycount(pdoc_befrist_st1_n - pdoc_befrist_st5_n), values(0) // Anzahl befristete Stellen

gen pdoc_befrist_B =.
replace pdoc_befrist_B=1 if pdoc_befrist_help1 >= 1 & pdoc_befrist_help1 <.  
replace pdoc_befrist_B=0 if pdoc_befrist_help2 >= 1 & pdoc_befrist_help1==0
replace pdoc_befrist_B=. if pdoc_befrist_help1==0 & pdoc_befrist_help2==0
label values pdoc_befrist_B BEFRIST_lb
label var pdoc_befrist_B "Durchschnittliche Befristung über alle Stellen (Postdocs, Pdoc-Phase)"
tab pdoc_befrist_B
// Als nächstes wird die letzte Stelle fixiert und der entsprechende Prestigewert dieser Stelle bestimmt
// egen total_posit_pdoc = rownonmiss(pdoc_befrist_st1_n pdoc_befrist_st2_n pdoc_befrist_st3_n pdoc_befrist_st4_n pdoc_befrist_st5_n)
// replace total_posit_pdoc=. if pdoc_befrist_st1_n==.
// sum total_posit_pdoc // --> 2,15 Stellen im Schnitt

gen pdoc_befrist_all_n =.
replace pdoc_befrist_all_n=1 if pdoc_befrist_help1 >= pdoc_befrist_help2  
replace pdoc_befrist_all_n=0 if pdoc_befrist_help1 < pdoc_befrist_help2
replace pdoc_befrist_all_n=. if pdoc_befrist_help1==0 & pdoc_befrist_help2==0
label values pdoc_befrist_all_n BEFRIST_lb
label var pdoc_befrist_all_n "Durchschnittliche Befristung über alle Stellen (Postdocs, Postdocphase)"
tab pdoc_befrist_all_n 

drop pdoc_befrist_help1 pdoc_befrist_help2


*************** Postdocs/Promotionsphase  
gen          pdoc_prom_befrist_st1_n = .
replace      pdoc_prom_befrist_st1_n = 0 if phase==2 & stpromoart1 !=. & stpromobef1==1
replace      pdoc_prom_befrist_st1_n = 1 if phase==2 & stpromoart1 !=. & stpromobef1==2
label values pdoc_prom_befrist_st1_n BEFRIST_lb
label var pdoc_prom_befrist_st1_n "Befristung 1 Stelle (Postdocs/Promotionsphase)"
tab pdoc_prom_befrist_st1_n

gen          pdoc_prom_befrist_st2_n = .
replace      pdoc_prom_befrist_st2_n = 0 if phase==2 & stpromoart2 !=. & stpromobef2==1
replace      pdoc_prom_befrist_st2_n = 1 if phase==2 & stpromoart2 !=. & stpromobef2==2
label values pdoc_prom_befrist_st2_n BEFRIST_lb
label var pdoc_prom_befrist_st2_n "Befristung 2 Stelle (Postdocs/Promotionsphase)"
tab pdoc_prom_befrist_st2_n

gen          pdoc_prom_befrist_st3_n = .
replace      pdoc_prom_befrist_st3_n = 0 if phase==2 & stpromoart3 !=. & stpromobef3==1
replace      pdoc_prom_befrist_st3_n = 1 if phase==2 & stpromoart3 !=. & stpromobef3==2
label values pdoc_prom_befrist_st3_n BEFRIST_lb
label var pdoc_prom_befrist_st3_n "Befristung 3 Stelle (Postdocs/Promotionsphase)"
tab pdoc_prom_befrist_st3_n

gen          pdoc_prom_befrist_st4_n = .
replace      pdoc_prom_befrist_st4_n = 0 if phase==2 & stpromoart4 !=. & stpromobef4==1
replace      pdoc_prom_befrist_st4_n = 1 if phase==2 & stpromoart4 !=. & stpromobef4==2
label values pdoc_prom_befrist_st4_n BEFRIST_lb
label var pdoc_prom_befrist_st4_n "Befristung 4 Stelle (Postdocs/Promotionsphase)"
tab pdoc_prom_befrist_st4_n

gen          pdoc_prom_befrist_st5_n = .
replace      pdoc_prom_befrist_st5_n = 0 if phase==2 & stpromoart5 !=. & stpromobef5==1
replace      pdoc_prom_befrist_st5_n = 1 if phase==2 & stpromoart5 !=. & stpromobef5==2
label values pdoc_prom_befrist_st5_n BEFRIST_lb
label var pdoc_prom_befrist_st5_n "Befristung 5 Stelle (Postdocs/Promotionsphase)"
tab pdoc_prom_befrist_st5_n

// Erzeugung einer 0/1-codierten Variable für alle fünf Stellen nach Befristung (Postdocs/Promotionsphase)
egen pdoc_prom_befrist_help1 = anycount(pdoc_prom_befrist_st1_n - pdoc_prom_befrist_st5_n), values(1) // Unbefristet
egen pdoc_prom_befrist_help2 = anycount(pdoc_prom_befrist_st1_n - pdoc_prom_befrist_st5_n), values(0) // Befristet

gen pdoc_prom_befrist_B =.
replace pdoc_prom_befrist_B=1 if pdoc_prom_befrist_help1>= 1 & pdoc_prom_befrist_help1 <.  
replace pdoc_prom_befrist_B=0 if pdoc_prom_befrist_help2>= 1 & pdoc_prom_befrist_help1==0
replace pdoc_prom_befrist_B=. if pdoc_prom_befrist_help1==0 & pdoc_prom_befrist_help2==0
label values pdoc_prom_befrist_B BEFRIST_lb
label var pdoc_prom_befrist_B "Durchschnittliche Befristung über alle Stellen (Postdocs, Prom-Phase)"
tab pdoc_prom_befrist_B
// Als nächstes wird die letzte Stelle fixiert und der entsprechende Prestigewert dieser Stelle bestimmt
/*egen total_posit_pdoc_prom = rownonmiss(pdoc_prom_befrist_st1_n pdoc_prom_befrist_st2_n pdoc_prom_befrist_st3_n ///
							 pdoc_prom_befrist_st4_n pdoc_prom_befrist_st5_n)
replace total_posit_pdoc_prom=. if pdoc_prom_befrist_st1_n==.
sum total_posit_pdoc_prom // --> 1,62 Stellen im Schnitt*/

gen pdoc_prom_befrist_all_n =.
replace pdoc_prom_befrist_all_n=1 if pdoc_prom_befrist_help1 >= pdoc_prom_befrist_help2  
replace pdoc_prom_befrist_all_n=0 if pdoc_prom_befrist_help1 < pdoc_prom_befrist_help2   
replace pdoc_prom_befrist_all_n=. if pdoc_prom_befrist_help1==0 & pdoc_prom_befrist_help2==0
label values pdoc_prom_befrist_all_n BEFRIST_lb
label var pdoc_prom_befrist_all_n "Durchschnittliche Befristung über alle Stellen (Postdocs, Promotionsphase)"
tab pdoc_prom_befrist_all_n 

drop pdoc_prom_befrist_help1 pdoc_prom_befrist_help2

*************** Profs/Promotionsphase  (noch nicht gemacht)
*************** Profs/Postdocphase  

*******************************************************************
***************** Besoldungsgruppe der Professur *****************
******************************************************************


// W1-Professur habe ich aufgrund der extrem geringen Fallzahl von n=3 nicht verwendet
// Unterscheidung daher in W2 = 0 und W3-Professur = 1. + 32 fehlende Werte als sonstige

// Es macht sinn die erste Stelle zu nehmen und zu schauen, wer hier zuerst eine w3 stelle hatte
// da in den kommenden stellen zunehmend mehr w3-stellen dazukommen 
gen w_professur_st1=.
replace w_professur_st1=0 if stprofart1==1 | stprofart1==4
replace w_professur_st1=1 if stprofart1==2 | stprofart1==5 | stprofart1==6
label define wprof_lb 0 "W2-Professur" 1 "W3-Professur"
label values w_professur_st1 wprof_lb
label var w_professur_st1 "Unterscheidung in W2-Professur und W3-Professur"
tab w_professur_st1

gen w_professur_st2=.
replace w_professur_st2=0 if stprofart2==1
replace w_professur_st2=1 if stprofart2>=2 & stprofart2<=6
label values w_professur_st2 wprof_lb
label var w_professur_st2 "Unterscheidung in W2-Professur und W3-Professur"
tab w_professur_st2

gen w_professur_st3=.
replace w_professur_st3=0 if stprofart3==1
replace w_professur_st3=1 if stprofart3>=2 & stprofart3<=6
label values w_professur_st3 wprof_lb
label var w_professur_st3 "Unterscheidung in W2-Professur und W3-Professur"
tab w_professur_st3

gen w_professur_st4=.
replace w_professur_st4=0 if stprofart4==1
replace w_professur_st4=1 if stprofart4==2
label values w_professur_st4 wprof_lb
label var w_professur_st4 "Unterscheidung in W2-Professur und W3-Professur"
tab w_professur_st4

gen w_professur_st5=.
replace w_professur_st5=0 if stprofart5==1
replace w_professur_st5=1 if stprofart5==2
label values w_professur_st5 wprof_lb
label var w_professur_st5 "Unterscheidung in W2-Professur und W3-Professur"
tab w_professur_st5

// Datensatz speichern
save "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\SM_01.dta", replace 

