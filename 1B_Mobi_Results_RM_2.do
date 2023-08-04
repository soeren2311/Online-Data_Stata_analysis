// Auswertungen basierende auf Codierungen von DS_02_SM_RM.dta

use "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\RM_SM_04.dta", clear 

**********************************************************************************************
********************* Frage 1: Welche Mobilitätsformen (Fernpendeln, *************************
************* Wochenendpendeln, Umzug, Auslandsaufenthalte usw.) kommen wie oft vor? *********
**********************************************************************************************

// I1: Tägliches Fernpendeln nach Phasen (Ursprungsvariablen)
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab 1R: Häufigkeit Pendeln unter der Woche (Tägliches Fernpendeln) nach Phasen und 
//     Entfernungen unterteilt), S. 2

// Fernpendeln nach Phasen
tab prommobkm_u20 if phase==1
tab prommobkm_b50 if phase==1
tab prommobkm_ü50 if phase==1

tab pdocmobkm_u20 if phase==2
tab pdocmobkm_b50 if phase==2 		
tab pdocmobkm_ü50 if phase==2

tab profmobkm_u20 if phase==3
tab profmobkm_b50 if phase==3 
tab profmobkm_ü50 if phase==3

// I1: Wochenendpendeln nach Phasen (Ursprungsvariablen)
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab 3R: Häufigkeit Wochenendpendeln nach Phasen und Entfernungen unterteilt), S.3 

// Wochenendpendeln nach Phasen
tab prommobkmwe_u100 if phase==1 
tab prommobkmwe_u250 if phase==1
tab prommobkmwe_u500 if phase==1
tab prommobkmwe_ü500 if phase==1

tab pdocmobkmwe_u100 if phase==2 
tab pdocmobkmwe_u250 if phase==2
tab pdocmobkmwe_u500 if phase==2 
tab pdocmobkmwe_ü500 if phase==2

tab profmobkmwe_u100 if phase==3 
tab profmobkmwe_u250 if phase==3			
tab profmobkmwe_u500 if phase==3 
tab profmobkmwe_ü500 if phase==3	


***********************************************************************************
*************** Pendelmobilität nach Fächern unterteilt ***********************
***********************************************************************************


// I1: Tägliches Fernpendeln nach Phasen und Fach 
// I3: 1_RM (Formen univariat nach Phase und Fach, Grafik 1R, Grafik 2R Pendeln unter 20 km unter der Woche nach Phasen und 
// 	   Fach unterteilt (Nicht-Phasenübergreifend + phasenübergreifend), S.6 
// I3: 1_RM (Formen univariat nach Phase und Fach, Grafik 3R, Grafik 4R. Pendeln über 50 km unter der Woche nach Phasen und 
// 	   Fach unterteilt (Nicht-Phasenübergreifend + phasenübergreifend), S.7

// Fernpendeln nach Fach (Promovierende und Postdocs)  --> Nicht-Phasenübergreifend
by diszi, sort: tab prommobkm_u20 if phase==1
by diszi, sort: tab prommobkm_ü50 if phase==1

by diszi, sort: tab pdocmobkm_u20 if phase==2	
by diszi, sort: tab pdocmobkm_ü50 if phase==2

by diszi, sort: tab profmobkm_u20 if phase==3
by diszi, sort: tab profmobkm_ü50 if phase==3

// Fernpendeln nach Fach (Promovierende und Postdocs)  --> Phasenübergreifend
by diszi, sort: tab prommobkm_u20 if phase==3  // Profs/Promotionsphase
by diszi, sort: tab pdocmobkm_u20 if phase==3  // Profs/Postdocphase
by diszi, sort: tab prommobkm_u20 if phase==2  // Postdocs/Promotionsphase

by diszi, sort: tab prommobkm_ü50 if phase==3  // Profs/Promotionsphase
by diszi, sort: tab pdocmobkm_ü50 if phase==3  // Profs/Postdocphase
by diszi, sort: tab prommobkm_ü50 if phase==2  // Postdocs/Promotionsphase

// Wochenendpendeln nach Fach (Promovierende und Postdocs) --> Nicht-Phasenübergreifend
by diszi, sort: tab prommobkmwe_u100 if phase==1 
by diszi, sort: tab prommobkmwe_u250 if phase==1
by diszi, sort: tab prommobkmwe_u500 if phase==1
by diszi, sort: tab prommobkmwe_ü500 if phase==1

by diszi, sort: tab pdocmobkmwe_u100 if phase==2 
by diszi, sort: tab pdocmobkmwe_u250 if phase==2
by diszi, sort: tab pdocmobkmwe_u500 if phase==2 
by diszi, sort: tab pdocmobkmwe_ü500 if phase==2

// Profs? Wenige Fälle
by diszi, sort: tab profmobkmwe_u100 if phase==3 
by diszi, sort: tab profmobkmwe_u250 if phase==3			
by diszi, sort: tab profmobkmwe_u500 if phase==3 
by diszi, sort: tab profmobkmwe_ü500 if phase==3


**********************************************************************************************************
**************************** Häufigkeit Umzüge nach Phase und Fach ***************************************
**********************************************************************************************************


// I1: Häufigkeit Umzüge nach Phase und Fach unterteilt
// I3: 1_RM (Formen Univariat nach Phase und Fach, Tab 200R: Häufigkeit Umzüge nach Phase und Fach, S.10)

// Umzüge nach Fächern   
by diszi, sort: tab umzüge_prom_prompha 
by diszi, sort: tab umzüge_pdoc_pdocpha 
by diszi, sort: tab umzüge_prof_profpha 
by diszi, sort: tab umzüge_prof_pdocpha 
by diszi, sort: tab umzüge_prof_prompha 
by diszi, sort: tab umzüge_pdoc_prompha


**********************************************************************************************************
**************************** Häufigkeit Pendeln am Wochenende ********************************************
**********************************************************************************************************

// I1: Tab. 14R: Häufigkeit Wochenendpendeln
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab. 14R: Häufigkeit Wochenendpendeln, S. 9)

// Wochenendpendler (Prozentwerte nach Phasen)
by diszi, sort: tab promowepenjn if phase==1
by diszi, sort: tab promowepenjn if phase==2
by diszi, sort: tab promowepenjn if phase==3
by diszi, sort: tab pdocwepenjn if phase==2

// I1: Anteil am Wochenendpendeln nach Phase und Fach (Mobilitätstypen) 
// I3: 1_RM (Formen Univariat nach Phase und Fach, Tab 13R: Anteil am Wochenendpendeln (mehr als 250 km) nach Phase und Fach (Mobilitätstypen), S.8 

// Wochenendpendeln nach Fächern
by diszi, sort: tab prommobkmwe_3kat 
by diszi, sort: tab pdocmobkmwe_3kat
by diszi, sort: tab profmobkmwe_3kat


********************************************************************************
**************** Bahncard 100 ************************************************
********************************************************************************

// I3: 1_RM (Formen univariat nach Phase und Fach, Tab. 22R: Besitz einer Bahncard, S. 11)
// Nicht-Phasenübergreifend
tab promobc if phase==1
tab pdocbc if phase==2
tab profbc if phase==3

// Phasenübergreifend
tab promobc if phase==3
tab pdocbc if phase==3
tab promobc if phase==2


*********************************************************************
********** RM als Anforderung oder Möglichkeit **********************
*********************************************************************

// I3: 3_RM (Analysen mit Einstellungen, Tab. 40R: Bewertung der Anforderungen von räumlicher Mobilität in verschiedenen Karrierephasen (in %))
// Nicht-Phasenübergreifend
tab anford_promo if phase==1
tab anford_pdoc if phase==2
tab anford_prof if phase==3
// phasenübergreifend
tab anford_promo if phase==3
tab anford_promo if phase==2
tab anford_pdoc if phase==3

// Nicht-Phasenübergreifend
by diszi, sort: tab promoanfmgl if phase==1
by diszi, sort: tab pdocanfmgl if phase==2
by diszi, sort: tab profanfmgl if phase==3

// Phasenübergreifend
by diszi, sort: tab promoanfmgl if phase==3
by diszi, sort: tab pdocanfmgl if phase==3
by diszi, sort: tab promoanfmgl if phase==2

// I3: 3_RM (Analysen mit Einstellungen, Tab. 42R: Anforderungen an räumliche Mobilität und Bedeutung einer Professur (Zeilenprozente)), S.2
// Beudeung professur und anforderungen an Mobilität
tab btprof_promo anford_promo if phase==1, row
tab btprof_pdoc anford_pdoc if phase==2, row

// Anforderungen und räumliche Mobilität
tab anford_promo PromProm_mobil if phase==1, column
tab anford_pdoc PdocPdoc_mobil if phase==2, column
tab anford_prof ProfProf_mobil if phase==3, column
 
// Anforderung und Index-Variablen
tab verlauf_rm_Prof anford_prof, row
tab verlauf_rm_Pdoc anford_pdoc, row

// Verlauf der Anforderungen über die Phasenübergreifend
// I3: 3_RM (Analysen mit Einstellungen, Tab 41R: RM als Verlauft der Anforderung oder Möglichkeit (Postdocs)) --> Seite 2
tab verlauf_Anford_Pdoc
tab verlauf_Anford_Prof
 
 
************************************************************************************
************** Auswirkungen der Coronapandemie auf räumliche Mobilität *************
************************************************************************************

tab mobicovid_SQ001 if phase==1
tab mobicovid_SQ001 if phase==2
tab mobicovid_SQ001 if phase==3

tab mobicovid_SQ002 if phase==1
tab mobicovid_SQ002 if phase==2
tab mobicovid_SQ002 if phase==3

tab mobicovid_SQ003 if phase==1
tab mobicovid_SQ003 if phase==2
tab mobicovid_SQ003 if phase==3

tab mobicovid_SQ004 if phase==1
tab mobicovid_SQ004 if phase==2
tab mobicovid_SQ004 if phase==3

tab mobicovid_SQ005 if phase==1 
tab mobicovid_SQ005 if phase==2
tab mobicovid_SQ005 if phase==3

// Corona auswirkungen nach Fächern und Phase
by diszi, sort: tab mobicovid_SQ005 if phase==3


******************************************************************************************
************************* Weitere Einstellungsvariablen *****************************
******************************************************************************************

// Nächste 5 Jahre räumlich mobiler?
tab gewpersp1 if phase==1
tab gewpersp1 if phase==2
tab gewpersp1 if phase==3

// Bedeutung professor und Verlauf der bisherigen räumlichen Mobilität
tab verlauf_rm_Pdoc relwisskar1 if phase==2, row

// Besser ausgestattete Professur haben? Profs/Postdoc-Phase
by diszi, sort: tab relwisskar2_SQ001

// Frage 1: Welchen Stellenwert räumen Sie Ihrem Beruf für eine wissenschaftliche Karriere im Verhältnis 
// zu anderen Bereichen Ihres Lebens ein (Familie, Freizeit, etc.) ein?
tab bedlebb_SQ003 if phase==1
tab bedlebb_SQ003 if phase==2
tab bedlebb_SQ003 if phase==3

// Bevorzugte Mobilität
tab gewmobi_SQ001 if phase==1
tab gewmobi_SQ001 if phase==2
tab gewmobi_SQ001 if phase==3

tab gewmobi_SQ004 if phase==1
tab gewmobi_SQ004 if phase==2
tab gewmobi_SQ004 if phase==3

tab gewpersp2a_SQ001 if phase==1
tab gewpersp2a_SQ001 if phase==2
tab gewpersp2a_SQ001 if phase==3


************************************************************************************************************
****************** Relevanz von Auslandsaufenthalten von im (nicht)-europäischen Ausland ******************
************************************************************************************************************

by diszi, sort: tab relevausl_13 if phase==1
by diszi, sort: tab relevausl_13 if phase==2
by diszi, sort: tab relevausl_13 if phase==3

// Relevanz von Auslandsaufenthalten von mehr als 3 Monaten im (nicht)-europäischen Ausland
by diszi, sort: tab relevausl_3 if phase==1
by diszi, sort: tab relevausl_3 if phase==2
by diszi, sort: tab relevausl_3 if phase==3

// Relevanz nach Phasen
tab relevausl_3 if phase==1
tab relevausl_3 if phase==2
tab relevausl_3 if phase==3


*******************************************************************************************************************
************************** WLB und Prestige nach räumlicher Mobilität und Phase ***********************************
*******************************************************************************************************************

// WLB Nach Mobilität 
by PromProm_mobil, sort: sum total_mean_promWL if phase==1 
by PdocPdoc_mobil, sort: sum total_mean_pdocWL if phase==2 
by ProfProf_mobil, sort: sum total_mean_profWL 

// Prestige nach Mobilität
by PromProm_mobil, sort: sum total_mean_promprom if phase==1
by PdocPdoc_mobil, sort: sum total_mean_pdocpdoc if phase==2
by ProfProf_mobil, sort: sum total_mean_profprof 



