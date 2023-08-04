// Datensatz speichern
use "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\SM_02.dta", clear

numlabel _all, add 

************************************************
********** Prestigebewertung der Stelle ********
************************************************

*~~~~~~~~~~~~~Promovierende/Promotionsphase)

// Grafik 1 

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_prom, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_prom, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x') 
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'") 
xlabel(-3 -2 -1 0 `x' "m" 1 2 3 4) ylabel(0(5)50, valuelabel angle(0))
name(hist1, replace); 
# delimit cr

// Grafik 2 (Gruppen mit exakt 3 Stellen Promovierende/Promotionsphase)
# delimit ;
twoway histogram verlauf_prom_promph_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Prozentuale Verteilung der Bewertungen bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)40, valuelabel angle(0)) 
name(hist2, replace); 
# delimit cr


*~~~~~~~~~~~~~Postdocs/Postdocphase)

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_pdoc, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_pdoc, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x') 
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'") 
xlabel(-3 -2 -1 0 `x' "m" 1 2 3) ylabel(0(5)45, valuelabel angle(0))
name(hist3, replace); 
# delimit cr

// Grafik 2
# delimit ;
twoway histogram verlauf_pdoc_pdocph_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Proz. Verteilung der Bewertungen bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)30, valuelabel angle(0)) 
name(hist4, replace); 
# delimit cr


*~~~~~~~~~~~~~~~~~~~~~~Professoren/Profphase

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_prof, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_prof, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-2 -1 0 `x' "m" 1 2) ylabel(0(5)50, valuelabel angle(0))
name(hist5, replace); 
# delimit cr
****** Weitere Differenzierungen aufgrund zu geringer Fallzahlen nicht 


********************************************************************************
*************************************** PHASENÜBERGREIFEND ***************************************
		 ********************************************************************************

****************************************
************* Profs/Promotionsphase ****
****************************************

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_prof_prom, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_prof_prom, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-3 -2 -1 0 `x' "m" 1 2) ylabel(0(5)60, valuelabel angle(0))
name(hist6, replace); 
# delimit cr


************************************
************* Profs/Pdocphase ******
************************************

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_prof_pdoc, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_prof_pdoc, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-3 -2 -1 0 `x' "m" 1 2 3 4) ylabel(0(5)55, valuelabel angle(0))
name(hist7, replace); 
# delimit cr


// Grafik 2
# delimit ;
twoway histogram verlauf_prof_pdocph_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Proz. Verteilung der Bewertungen bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)35, valuelabel angle(0)) 
name(hist8, replace); 
# delimit cr  


***************************************
************* Postdocs/Promotionsphase
***************************************

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_pdoc_prom, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_pdoc_prom, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-3 -2 -1 0 `x' "m" 1 2) ylabel(0(5)55, valuelabel angle(0))
name(his9, replace); 
# delimit cr

// Grafik 2
# delimit ;
twoway histogram verlauf_pdoc_promph_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Häufigkeit der Bewertungen bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)35, valuelabel angle(0)) 
name(hist10, replace); 
# delimit cr

********************************************************************************
*************** Subjektive Bewertung der finanziellen Situation *****************
********************************************************************************

****************************************************
************* Promovierende/Promotionsphase
****************************************************

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_promF, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_promF, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-3 -2 -1 0 `x' "m" 1 2 3) ylabel(0(5)60, valuelabel angle(0))
name(hist11, replace); 
# delimit cr

********* Weitere Differenzierungen (bsp. 2x positiv oder 2x negativ usw.

// Grafik 2
# delimit ;
twoway histogram verlauf_prom_promphF_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Proz. der Bewertungen bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)50, valuelabel angle(0)) 
name(hist12, replace); 
# delimit cr

********************************************
************* Postdocs/Postdocphase
********************************************

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_pdocF, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_pdocF, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-4 -3 -2 -1 0 `x' "m" 1 2 3 4) ylabel(0(5)60, valuelabel angle(0))
name(hist13, replace); 
# delimit cr

// Grafik 2
# delimit ;
twoway histogram verlauf_pdoc_pdocphF_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Proz. Verteilung der Bewertungen bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)40, valuelabel angle(0)) 
name(hist14, replace); 
# delimit cr


***************************************
************* Professoren/Profphase
***************************************

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_profF, detail
local x = r(mean)
// Grafik 2
# delimit ;
twoway histogram last_first_profF, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-2 -1 0 `x' "m" 1 2 3 4) ylabel(0(5)55, valuelabel angle(0))
name(hist15, replace); 
# delimit cr

*************** Für weitere Differenzierungen zu wenige Stellen (proffinz3--> N=7)


         ********************************************************************************
*************************************** PHASENÜBERGREIFEND ***************************************
		 ********************************************************************************


***************************************
************* Professoren/Promophase
***************************************

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_prof_promF, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_prof_promF, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-3 -2 -1 0 `x' "m" 1 2 3) ylabel(0(5)50, valuelabel angle(0))
name(hist16, replace); 
# delimit cr

*************** Für weitere Differenzierungen zu wenige Stellen (promfinz3_PrPr--> N=9)


***************************************
************* Professoren/Pdocphase
***************************************

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_prof_pdocF, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_prof_pdocF, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-3 -2 -1 0 `x' "m" 1 2 3 4) ylabel(0(5)50, valuelabel angle(0))
name(hist17, replace); 
# delimit cr


// Grafik 2
# delimit ;
twoway histogram verlauf_prof_pdocphF_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Proz. Verteilung der Bewertungen bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)40, valuelabel angle(0)) 
name(hist18, replace); 
# delimit cr

***************************************
************* Postdocs/Promotionsphase
***************************************

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_pdoc_promF, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_pdoc_promF, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-3 -2 -1 0 `x' "m" 1 2 3 4) ylabel(0(5)50, valuelabel angle(0))
name(hist19, replace); 
# delimit cr

// Grafik 2
# delimit ;
twoway histogram verlauf_pdoc_promphF_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Proz. Verteilung der Bewertungen bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)50, valuelabel angle(0)) 
name(hist20, replace); 
# delimit cr


********************************************************************************
********************** Stellenumfang Vollzeit- Teilzeit *********************
*******************************************************************************

// Promovierende/Promotionsphase    

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_promU, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_promU, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-2 -1 0 `x' "m" 1 2) ylabel(0(5)70, valuelabel angle(0))
name(hist21, replace); 
# delimit cr


// Grafik 2
# delimit ;
twoway histogram verlauf_prom_promphU_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Angaben Stellenumfang bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)55, valuelabel angle(0)) 
name(hist22, replace); 
# delimit cr


// Postdocs/Postdocphase
// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_pdocU, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_pdocU, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-2 -1 0 `x' "m" 1 2) ylabel(0(5)80, valuelabel angle(0))
name(hist23, replace); 
# delimit cr

// Grafik 2
# delimit ;
twoway histogram verlauf_pdoc_pdocphU_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Angaben Stellenumfang bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)65, valuelabel angle(0)) 
name(hist24, replace); 
# delimit cr


         ********************************************************************************
*************************************** PHASENÜBERGREIFEND ***************************************
		 ********************************************************************************

// Profesoren/Promotionsphase

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_PrPrU, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_PrPrU, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-2 -1 0 `x' "m" 1 2) ylabel(0(5)50, valuelabel angle(0))
name(hist25, replace); 
# delimit cr

************* ZU wenige Fälle für weitere Differenzierungen


// Profesoren/Postdocphase
// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_PrPdU, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_PrPdU, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-2 -1 0 `x' "m" 1 2) ylabel(0(5)90, valuelabel angle(0))
name(hist26, replace); 
# delimit cr

// Grafik 2
# delimit ;
twoway histogram verlauf_prof_pdocphU_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Angaben Stellenumfang bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)85, valuelabel angle(0)) 
name(hist27, replace); 
# delimit cr


// Postdocs/Promotionsphase

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_PdPrU, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_PdPrU, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-2 -1 0 `x' "m" 1 2) ylabel(0(5)70, valuelabel angle(0))
name(hist28, replace); 
# delimit cr


// Grafik 2
# delimit ;
twoway histogram verlauf_pdoc_promphU_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Angaben Stellenumfang bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)50, valuelabel angle(0)) 
name(hist27, replace); 
# delimit cr

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

// Summe bilden für Grafik und mean in lokaler Variable speichern
sum last_first_PdocB, detail
local x = r(mean)
// Grafik
# delimit ;
twoway histogram last_first_PdocB, discrete fcolor(blue) lcolor(black) gap(10) width(1) percent xline(`x')
title("Differenz zwischen erster und letzter Stelle") xtitle("Differenzwerte") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(-1 0 `x' "m" 1) ylabel(0(5)75, valuelabel angle(0))
name(hist28, replace); 
# delimit cr

// Grafik 2
# delimit ;
twoway histogram verlauf_pdoc_pdocphB_r, discrete fcolor(green) lcolor(black) gap(10) width(1) percent 
title("Angaben Stellenumfang bei 2 Stellenwechsel") xtitle("Bewertungen") ytitle("Prozent")
note("Source: Online-Fragebogen des Mobilitätsprojekts: 'Akademisch Beschäftigte in Bewegung'")
xlabel(1(1)4) ylabel(0(5)75, valuelabel angle(0)) 
name(hist27, replace); 
# delimit cr