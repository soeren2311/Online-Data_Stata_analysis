// Einflussfaktoren auf räumliche Mobilität?
// Welche Einflussfaktoren gibt es für räumliche Mobilität 


// Datensatz verwenden
// Working directory

clear all
version 16.1
set more off
set scrollbufsize 500000

use "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\RM_SM_04.dta", clear 

*Globals
	
	global Verzeichnis "C:\Users\sonon001\Desktop\Online-Fragebogen\Ergebnisse"
	global Abbildungen "cd "${Verzeichnis}/Abbildungen""
	global Tabellen "cd "${Verzeichnis}/Tabellen""

	
describe, short
numlabel _all, add



******************************************************************************************
************************** Signifikanztests (rho) **********************************************
******************************************************************************************

// I3: 2_RM (Analysen mit Phase und Fach, Tab 80R, Tab80R_a & Tab80R_b: Tägliches Pendeln differenziert nach Karrierephase (in %)) --> Seite 9

// Pendelmobilität unter der Woche 
spearman commute_group_av commute_allgroup_uv  // tab commute_group_av if phase==1
// Pendelmobilität am Wochenende
spearman WE_commute_allgroup_uv WE_commute_group_av  // tab WE_commute_group_av if phase==2
// Umzugsmobilität
spearman Umzug_allgroup_uv Umzug_group_av_rec // tab Umzug_group_av_rec if phase==3

// Anova-Signifikanztest + posthoc-Test
/*oneway Umzug_group_av Umzug_allgroup_uv
oneway Umzug_group_av Umzug_allgroup_uv, scheffe 
tab Umzug_group_av Umzug_allgroup_uv, chi2 V expected
tabchi Umzug_allgroup_uv Umzug_group_av, a

// Anova-Signifikanztest + posthoc-Test (Optional)
oneway WE_commute_group_av WE_commute_allgroup_uv
oneway WE_commute_group_av WE_commute_allgroup_uv, scheffe // n.s.
tab WE_commute_allgroup_uv WE_commute_group_av, chi2 V column
tabchi WE_commute_allgroup_uv WE_commute_group_av, a*/


// I3: 2_RM (Analysen mit Phase und Fach, Tabelle 83R: Mobilität ins nicht-deutschsprachige Ausland differenziert 
// nach Dauer und Karrierephase (in %) --> Seite 9

// Kurzaufenthalte 
tab all_auslkurz_uv allauslKurz_av, row
spearman all_auslkurz_uv allauslKurz_av

// 1-3 Monate: Spearman’s rho
tab all_ausl1_3Mon_uv allausl1_3Mon_av, row
spearman all_ausl1_3Mon_uv allausl1_3Mon_av

// Aufenthalte >= 3 Monate
tab all_ausl3Mon_uv allausl3Mon_av, row
spearman all_ausl3Mon_uv allausl3Mon_av

// I1: Durchschnittliche Prestigebewertung der Stellen der Mobilen nach Phase 
// I3: 2_RM (Analysen mit Phase und Fach, Tabelle 85R: Durchschnittliche Prestigebewertung der Stellen 
// (in der Phase) differenziert nach Mobilität (Index) und Karrierephase in %   --> Seite 10
sum all_av if phase==2 
spearman all_uv all_av

// I1: Durchschnittliche Prestigebewertung der Stellen der Mobilen nach Phase 
// I3: 2_RM (Analysen mit Phase und Fach,  Tab 81R: Wochenendpendeln differenziert nach Karrierephase   --> Seite 9
spearman WePndl_uv WePndl_av_rec

// I1: Anforderungen an räumliche Mobilität nach Phase  
tab all_AM_av if phase==1
spearman all_AM_uv all_AM_av


*****************************************************************************************************
************************* Pendelmobilität u.d.W (Chi2-Tets und Logit-Regressionen ************************
*************************************************************************************************

// Nicht-Phasenübergreifend (PENDEL UdW)

// Pendelmobilität unter der Woche >= 50 km (Nicht-Phasenübergreifend) --> Logit-Regressionen (keine Tabellen in Word)
/*logit prommobkm_ü50_N ib1.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_promo ib1.btprof_promo if phase==1
  logit pdocmobkm_ü50_N ib1.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_pdoc ib1.btprof_pdoc if phase==2
  logit profmobkm_ü50_N ib1.diszi ib2.gender ib2.partner ib1.kinder ib1.anford_prof if phase==3*/


// I1:Pendeln unter der Woche (Mobilitätstypen) nach Disziplin
// I3: 2_RM (Analysen mit Phase und Fach, Tab 25R, Tab 26R & Tab 27R: Pendelmobilität u.d.W. (Mobilitätstypen) und Disziplin 
// (Promovierende, Postdocs, Profs) --> Seite 2

tab prommobkm_ü50_3kat diszi if phase==1, chi2 V colum  // Promovierende
tab pdocmobkm_ü50_3kat diszi if phase==2, chi2 V colum  // Postdocs
tab profmobkm_ü50_3kat diszi if phase==3, chi2 V colum  // Profs


// Phasenübergreifend (PENDEL UdW)


// Pendelmobilität unter der Woche >= 50 km (Phasenübergreifend) --> Logit-Regressionen (keine Tabellen in Word)
/*logit prof_prommobkm_ü50_N ib1.diszi ib1.gender ib1.anford_promo if phase==3 
logit pdoc_prommobkm_ü50_N ib1.diszi ib1.gender ib1.anford_promo if phase==2  
logit prof_pdocmobkm_ü50_N ib2.diszi ib1.gender ib1.anford_pdoc if phase==3*/

// I1:Pendeln unter der Woche (Mobilitätstypen) nach Disziplin
// I3: 2_RM (Analysen mit Phase und Fach, Tab 28R, Tab 29R & Tab 30R: Pendelmobilität u.d.W. (Mobilitätstypen) und Disziplin 
// (Promovierende, Postdocs, Profs) phasenübergreifend --> Seite 3

tab prommobkm_ü50_3kat diszi if phase==3, chi2 V colum  // Profs/Promotionsphase
tab prommobkm_ü50_3kat diszi if phase==2, chi2 V colum // Postdocs/Promotionsphase
tab pdocmobkm_ü50_3kat diszi if phase==3, chi2 V expected // Profs/Postdoc-Phase


**********************************************************************************
************************* Pendelmobilität am Wochenende *************************
**********************************************************************************

// Nicht-Phasenübergreifend (PENDEL am WE)

// Wochenendpendeln (Nicht-Phasenübergreifend) --> Logit-Regressionen (keine Tabellen in Word)
/*logit prommobkmwe_ü100_N ib1.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_promo ib1.btprof_promo if phase==1
logit pdocmobkmwe_ü100_N ib1.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_pdoc ib1.btprof_pdoc if phase==2
logit profmobkmwe_ü100_N ib1.diszi ib1.gender ib2.partner ib1.kinder if phase==3*/


// I1:Pendeln am Wochenende nach Phase und Fach
// I3: 2_RM (Analysen mit Phase und Fach, Tab 31R: Chi2-Test Wochenendpendeln nach Fach und Phase (Nicht-Phasenübergreifend) --> Seite 4

tab prommobkmwe_ü100_N diszi if phase==1, chi2 V colum  // Promovierende
tab pdocmobkmwe_ü100_N diszi if phase==2, chi2 V colum  // Postdocs
tab profmobkmwe_ü100_N diszi if phase==3, chi2 V colum  // Profs


// Phasenübergreifend (PENDELN am Wochenende)
// Wochenendpendeln (Phasenübergreifend) --> Logit-Regressionen (keine Tabellen in Word)
/*logit prof_prommobkmwe_ü100_N ib2.diszi ib1.gender ib1.anford_promo if phase==3  // Profs/Promotionsphase
logit prof_pdocmobkmwe_ü100_N ib2.diszi ib1.gender ib1.anford_pdoc if phase==3  // Profs/Postdoc-Phase
logit pdoc_prommobkmwe_ü100_N ib2.diszi ib1.gender ib1.anford_promo if phase==2 // Postdocs/Promo-Phase*/


// I1:Pendeln am Wochenende nach Phase und Fach
// I3: 2_RM (Analysen mit Phase und Fach, Tab 32R: Chi2-Test Wochenendpendeln nach Fach und Phase (Phasenübergreifend) --> Seite 4

tab prof_prommobkmwe_ü100_N diszi if phase==3, chi2 V colum
tab prof_pdocmobkmwe_ü100_N diszi if phase==3, chi2 V colum
tab pdoc_prommobkmwe_ü100_N diszi if phase==2, chi2 V colum


**********************************************************************************
************************* Auslandsmobilität mehr als 3 Monate ********************
**********************************************************************************

// Auslandsaufenthalte >= 3 Monate (Nicht-Phasenübergreifend) --> Logit-Regressionen (keine Tabellen in Word)
/*logit niausl3prom_r ib1.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_promo ib1.btprof_promo if phase==1
logit niausl3pdoc_r ib1.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_pdoc ib1.btprof_pdoc if phase==2
logit niausl3prof_r ib1.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_pdoc if phase==3

// Auslandsaufenthalte >= 3 Monate (Phasenübergreifend) --> Logit-Regressionen (keine Tabellen in Word)
logit niausl3prom_r ib1.diszi ib1.gender ib1.anford_promo if phase==3 // Promotionsphase/Profs
logit niausl3pdoc_r ib1.diszi ib1.gender ib1.anford_pdoc if phase==3 // Postdoc-Phase/Profs
logit niausl3prom_r ib1.diszi ib1.gender ib1.anford_promo if phase==2 // Postdocs/Promo-Phase*/


// I1: Auslandsmobilität >= 3 Monate 0=Nein, 1=Ja nach Phase und Disziplin (Nicht-Phasenübergreifend)
// I3: 2_RM (Analysen mit Phase und Fach, Tab 36R.: Chi2-Test Auslandsmobilität > 3 Monate nach Fach und Phase (Nicht-Phasenübergreifend)) S.7
tab niausl3prom_r diszi if phase==1, chi2 V colum  // Promovierende
tab niausl3pdoc_r diszi if phase==2, chi2 V colum  // Postdocs
tab niausl3prof_r diszi if phase==3, chi2 V colum  // Profs

// I1: Auslandsmobilität >= 3 Monate 0=Nein, 1=Ja nach Phase und Disziplin (Phasenübergreifend)
// I3: 2_RM (Analysen mit Phase und Fach, Tab 37R.: Chi2-Test Auslandsmobilität > 3 Monate nach Fach und Phase (Phasenübergreifend) S.7
tab niausl3prom_r diszi if phase==3, chi2 V colum  // Profs/Promotionsphase
tab niausl3pdoc_r diszi if phase==3, chi2 V colum  // Profs/Postdocsphase
tab niausl3prom_r diszi if phase==2, chi2 V colum  // Postdocs/Promotionsphase



**********************************************************************************
************************* Auslandsmobilität Kurzaufenthalte ********************
**********************************************************************************

// Nicht phasenübergreifend
/*logit niauslkurzprom_r ib2.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_promo ib1.btprof_promo if phase==1
logit niauslkurzpdoc_r ib2.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_pdoc ib1.btprof_pdoc if phase==2
logit niauslkurzprof_r ib2.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_prof if phase==3
// Phasenübergreifend
logit niauslkurzprom_r ib2.diszi ib1.gender ib1.anford_promo if phase==3
logit niauslkurzpdoc_r ib2.diszi ib1.gender ib1.anford_promo if phase==3
logit niauslkurzprom_r ib2.diszi ib1.gender ib1.anford_promo if phase==2*/


// I1: Auslandsmobilität Kurzaufenthalte 0=Nein, 1=Ja nach Phase und Disziplin (Nicht-Phasenübergreifend)
// I3: 2_RM (Analysen mit Phase und Fach, Tab 38R.: Chi2-Test Kurzaufenthalte im Ausland nach Fach und Phase (Nicht-Phasenübergreifend) S.8
tab niauslkurzprom_r diszi if phase==1, chi2 V colum
tab niauslkurzpdoc_r diszi if phase==2, chi2 V colum
tab niauslkurzprof_r diszi if phase==3, chi2 V colum

// I1: Auslandsmobilität Kurzaufenthalte 0=Nein, 1=Ja nach Phase und Disziplin (Phasenübergreifend)
// I3: 2_RM (Analysen mit Phase und Fach, Tab 39R.: Chi2-Test Kurzaufenthalte im Ausland nach Fach und Phase (Phasenübergreifend) S.8
tab niauslkurzprom_r diszi if phase==3, chi2 V colum
tab niauslkurzpdoc_r diszi if phase==3, chi2 V colum
tab niauslkurzprom_r diszi if phase==2, chi2 V colum


**********************************************************************************
************************* Geasamte Mobilitüt über 3 Phasen **********************
******************************* Index-variablen  ********************************
**********************************************************************************

// OLS-Regression nicht gut geeignet. Kategorien nicht-metrisch. Daher keine Tabellen
/*reg verlauf_rm_Prof ib1.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_prof if phase==3
reg verlauf_rm_Pdoc ib1.diszi ib1.gender ib2.partner ib1.kinder ib1.anford_pdoc ib1.btprof_pdoc if phase==2*/

// I1: Chi2-Tets (Nachträglich eingefügt, daher andere Tabellenbezeichnungen um chronologische Reihenfolge nicht zu unterbrechen)
// I3: 2_RM (Analysen mit Phase und Fach, Tab 100R, Tab 101R.: Chi2-Test Verlaufsindexvariable nach Disziplin (Professoren, Postdocs)) S. 6
tab verlauf_rm_Prof diszi, chi2 V column
tab verlauf_rm_Pdoc diszi, chi2 V column

// Nach Phasen und räumlicher Mobilität (Index)
tab verlauf_rm_Prof anford_prof, chi2 V row
tab verlauf_rm_Pdoc anford_pdoc, chi2 V row


// Einstellungen zu räumlicher Mobilität und praktizierte räumliche Mobilität

// Bevorzugte räumliche Mobilität 
// Wenig pendeln und umziehen, Lieber pendeln als umziehen, lieber umziehen als pendeln, offen für Umzüge und pendeln, 
// offen für Wochenendpendeln
// Gewünschte Entwicklung der Mobilität	
// Mobilitätsfördernde Faktoten
// Mobilitätshemmende Faktoren
// Beurteilung der Relevanz von Auslandsaufenthalten
// Bereitschaft zu Auslandsaufenthalten
// Bereitschaft für eine Stelle umzuziehen
// Bereitschaft zur Arbeitslosigkeitsvermeidung umzuziehen 
// Auswirkung der Pandemie auf räumliche Mobilität*/

// Gründe warum jemand mobiler/weniger mobil werden will nach räumlichem Mobilitätsgrad


// I1: Gewünschte Entwicklung der Mobilität in den nächsten 5 Jahren 
// I3: 3_RM (Analysen mit Einstellungen, Tab 50R, Tab 51R, Tab 52R.: In den nächsten 5 Jahren räumlich mobiler werden nach Fach 
// (Promovierende)) S. 5  (Mit Chi2)
tab mobi5jahre diszi if phase==1, chi2 V column  // Promovierende
tab mobi5jahre diszi if phase==2, chi2 V column  // Postdocs
tab mobi5jahre diszi if phase==3, chi2 V column  // Profs


// I1: Postdocs: 1=stetig immobil, 4=Stetig mobil, Profs: 1=stetig immobil, 5=Stetig mobil
// I3: 3_RM (Analysen mit Einstellungen, Tab 69R, 70R: Wunsch mobiler werden zu wollen und Verlauf der räumlichen 
// Mobilität (Profs, postdocs)) S. 12

// Chi2-Test zwischen gewünschter Entwicklung der Mobilität in den nächsten 5 Jahren und Mobilitätstyp (Postdocs/Postdoc-Phase)
tab mobi5jahre verlauf_rm_Pdoc, chi2 V column
// Chi2-Test zwischen gewünschter Entwicklung der Mobilität in den nächsten 5 Jahren und Mobilitätstyp (Profs/Profphase)
tab mobi5jahre verlauf_rm_Prof, chi2 V column


// I1: Umzüge und Wunsch nach Zunahme von räumlicher Mobilität (Alle Phasen)
// I3: 3_RM (Analysen mit Einstellungen, Tab 71R, 72R, 73R: Häufigkeit Umzüge und Wunsch nach Zunahme von räumlicher Mobilität (phasen) S. 13
// Umzugsmobilität und Einstellungen zu räumlicher Mobilität
tab mobi5jahre umzüge_prom_prompha, chi2 V column 
tab mobi5jahre umzüge_pdoc_pdocpha, chi2 V column 
tab mobi5jahre umzüge_prof_profpha, chi2 V column 


// Anforderungen an räumliche Mobilität und Index-Variable
tab anford_promo PromProm_mobil, chi2 V column
tab anford_pdoc PdocPdoc_mobil, chi2 V expected
tab anford_prof ProfProf_mobil, chi2 V expected

// Anforderungen an räumliche Mobilität und Index-Verlaufsvariable
by verlauf_rm_Prof, sort: tab anford_prof
by verlauf_rm_Pdoc, sort: tab anford_pdoc


// I3: 2_RM (Analysen mit Phase und Fach, Tab 100R, Tab 101R, Verlaufsindexvariable nach Disziplin (Postdocs und Profs)), S.5
// Verlaufsvariable nach Disziplin
tab verlauf_rm_Pdoc diszi, chi2 V column
tab verlauf_rm_Prof diszi, chi2 V column


// Weitere Berechnungen: Wunsch nach Zunahme von räumlicher Mobilität, Relevanz von Auslandsaufenthalten, Zukünftige räumliche Mobilität

// a.	Wünsche nächsten 5 Jahre nach Fach (Alle Phasen)
by diszi, sort: tab gewpersp1 if phase==1
by diszi, sort: tab gewpersp1 if phase==2
by diszi, sort: tab gewpersp1 if phase==3

// b. Relevanz von Auslandsaufenthalten und Bereitschaft dazu nach Phase und Fach 
by diszi, sort: tab relevausl_3 if phase==1
by diszi, sort: tab relevausl_3 if phase==2
by diszi, sort: tab relevausl_3 if phase==3

// Kommen für Sie persönlich in den nächsten fünf Jahren kürzere und/oder längere Aufenthalte im Ausland in Frage?
by diszi, sort: tab zkunftausl if phase==1
by diszi, sort: tab zkunftausl if phase==2
by diszi, sort: tab zkunftausl if phase==3

by diszi, sort: tab anderes_bula if phase==1
by diszi, sort: tab anderes_bula if phase==2
by diszi, sort: tab anderes_bula if phase==3


// I1: Einschätzung eigene Leistung/äußere Faktoren nach Phase und Fach, auch in indivi-dueller Kombi: 2 x (sehr) wenig, 
// 2 x sehr stark, wenig/stark, stark/wenig
// I3: 3_RM (Analysen mit Einstellungen, Tab 59R, Tab 60R: Einschätzung wissenschaftlichen Erfolgs aufgrund von 
// eigenen Leistungen oder äußerer Faktoren (Phase und Fach)) S.8
by diszi, sort: tab glkleist_SQ001 if phase==1  // Eigene Leistung
by diszi, sort: tab glkleist_SQ001 if phase==2
by diszi, sort: tab glkleist_SQ001 if phase==3

by diszi, sort: tab glkleist_SQ002 if phase==1  // Äußere Faktoren
by diszi, sort: tab glkleist_SQ002 if phase==2
by diszi, sort: tab glkleist_SQ002 if phase==3


// I1: In welchem Maße ist wissenschaftlicher Karriereerfolg eigene Leistung? (1=(sehr) wenig - 4 (sehr) viel)
// I3: 3_RM (Analysen mit Einstellungen, Tab 61R: Kombi zur Einschätzung ob eigene Leistung oder äußere Faktoren relevant (phasen))
/// Promovierende
by diszi, sort: tab kombi_eflg_1 if phase==1
/// Postdocs
by diszi, sort: tab kombi_eflg_2 if phase==2
/// Profs
by diszi, sort: tab kombi_eflg_3 if phase==3


**********************************************************************************
************** Mobilitätswunsch nach Phase und Fach *****************************
**********************************************************************************

// I3: 3_RM (Analysen mit Einstellungen, Tab 74R, 75R, 76R: Verlaufsindex und Wunsch nach Zunahme von räumlicher Mobilität (phasen), S.14
// Bevorzugte Mobilität nach Fach
tab mobi5jahre diszi if phase==1, column
tab mobi5jahre diszi if phase==2, column
tab mobi5jahre diszi if phase==3, column

// Nach Phase und Fach
by diszi, sort: tab mobi5jahre if phase==1
by diszi, sort: tab mobi5jahre if phase==2
by diszi, sort: tab mobi5jahre if phase==3


// Mobilitätsverläufe und Bedeutung Professur
// tab verlauf_rm_Pdoc karriere_mot if phase==2, row

// Anforderung nach Disziplin
tab diszi anford_promo if phase==1, row
tab diszi anford_pdoc if phase==2, row
tab diszi anford_prof if phase==3, row

// Phasenübergreifend
tab diszi anford_promo if phase==3, row
tab diszi anford_pdoc if phase==3, row
tab diszi anford_promo if phase==2, row

// Häufigkeit
tab lkrastelausland if phase==1
tab lkrastelausland if phase==2
tab lkrastelausland if phase==3
tab lkrastelausland phase, chi2 V expected

by PromProm_mobil, sort: sum total_mean_promprom 
by PdocPdoc_mobil, sort: sum total_mean_pdocpdoc 
by ProfProf_mobil, sort: sum total_mean_profprof 

// How is spatial mobility related to social mobility, i.e. do spatially mobile scientists enjoy career advantage?
// Frage zusammenhang RM und SM (Rückfrage Benjamin call IAB)
tab verlauf_prom_promph_r PromProm_mobil, chi2 V column
tab verlauf_pdoc_pdocph_r PdocPdoc_mobil, chi2 V column
// Differenz zwischen erster und letzter Stelle (Recodiert)
tab last_first_prom_recoded PromProm_mobil, chi2 V column
tab last_first_pdoc_recoded PdocPdoc_mobil, chi2 V column


			****************************************************************************************
			************ Einflussfaktoren auf räumliche Mobilität (Logit-Regressionen) *************
			****************************************************************************************
			
// I1: AV= Index-Variable je Phase (Residenziell + zirkulär verknüpft), UV = Disziplin, Geschlecht, Partnerschaft, Kinder, 
//     edup = Bildungsabschluss der Eltern, bedlebb_SQ001 = Bedeutung von Beruf und Karriere im Leben 
// I3: 5_Einflussfaktoren RM und SM, 2 Einflussfaktoren auf räumliche Mobilität (Logit-Regression), S. 5-7
			
// Mulitvariate Regressionsanalyse (X = Fach, Phase, Partnerschaft ja/nein, akademische Herkunft ja/nein, Bedeutung des Lebensbereichs Beruf.)
logit ProfProf_mobil ib3.diszi men ib1.partner ib1.kinder ib1.edup ib1.bedlebb_SQ001 if phase==3
logit PdocPdoc_mobil ib3.diszi karriere_mot ib2.gender ib1.partner ib1.kinder ib1.edup ib1.bedlebb_SQ001 if phase==2
logit PromProm_mobil ib3.diszi karriere_mot ib1.gender ib1.partner ib1.kinder ib1.edup ib1.bedlebb_SQ001 if phase==1


*****************************************************************************************************************
**************************** ZUSAMMENHANG VON RÄUMLICHER UND SOZIALER MOBILITÄT *************************
*****************************************************************************************************************

// I1: Mittelwert der subjektiven Prestige-Bewertungen über alle Stellen (Gesamt), UV =  Index-Variable je Phase (Residenziell + zirkulär 
// 	   verknüpft), karriere_mot (Bedeutung später mal eine Professur zu haben), Disziplin, Geschlecht, Partnerschaft, Kinder, 
//     edup = Bildungsabschluss der Eltern, bedlebb_SQ001 = Bedeutung von Beruf und Karriere im Leben 
// I3: 5_Einflussfaktoren RM und SM, 1 Zusammenhang von räumlicher und sozialer Mobilität (OLS-Regression), S. 2-4

// Promovierende
reg total_mean_promprom ib0.PromProm_mobil karriere_mot ib3.diszi ib0.men ib1.partner ib1.kinder ib1.edup ib1.bedlebb_SQ001 if phase==1
// Postdocs
reg total_mean_pdocpdoc ib0.PdocPdoc_mobil karriere_mot ib3.diszi ib0.men ib1.partner ib1.kinder ib1.edup ib1.bedlebb_SQ001 if phase==2
// Profs
reg total_mean_profprof ib0.ProfProf_mobil ib3.diszi men ib1.partner ib1.kinder ib1.edup ib1.bedlebb_SQ001 if phase==3




// Weitere Chi2-Tests zu Einstellungsfragen (Eigene Ideen) --> Keine Tabellen 

/*// Beurteilung der Relevanz von Auslandsaufenthalten (3 Monate im (nicht)-europäischen Ausland) und bisherige Auslandsmobilität 
// im nicht-deutschsprachigen Ausland von mehr als 3 Monaten
tab relevausl_3 niausl3prom_r if phase==1, chi2 V column  // Promovierende/Promotionsphase
tab relevausl_3 niausl3pdoc_r if phase==2, chi2 V column  // Postdocs/Postdoc-Phase
tab relevausl_3 niausl3prof_r if phase==3, chi2 V column  // Profs/Profphase

// Einstellungen zu räumlicher Mobilität (Breitschaft zu Auslandsaufenthalten)
tab zkunftausl niausl3prom_r if phase==1, chi2 V column 
tab zkunftausl niausl3pdoc_r if phase==2, chi2 V column 
tab zkunftausl niausl3prof_r if phase==3, chi2 V column 

// Relevanz von Auslandsaufenthalten nach Fächern
tab relevausl_3 diszi if phase==1, chi2 V column  // Promovierende/Promotionsphase
tab relevausl_3 diszi if phase==2, chi2 V column  // Postdocs/Postdoc-Phase
tab relevausl_3 diszi if phase==3, chi2 V column  // Profs/Profphase

// Relevanz von Auslandsaufenthalten nach Bedeutung einer Professur
tab relevausl_3 btprof_prom if phase==1, chi2 V column 
tab relevausl_3 btprof_pdoc if phase==2, chi2 V column 

// Postdocs (Mehr mobil)
tab gewpersp2a_SQ001 verlauf_rm_Pdoc if phase==2, chi2 V column
tab gewpersp2a_SQ002 verlauf_rm_Pdoc if phase==2, chi2 V column
tab gewpersp2a_SQ003 verlauf_rm_Pdoc if phase==2, chi2 V column
tab gewpersp2a_SQ004 verlauf_rm_Pdoc if phase==2, chi2 V column

// Promovierende (Mehr mobil)
tab gewpersp2a_SQ001 index_11 if phase==1, chi2 V column
tab gewpersp2a_SQ002 index_11 if phase==1, chi2 V column
tab gewpersp2a_SQ003 index_11 if phase==1, chi2 V column
tab gewpersp2a_SQ004 index_11 if phase==1, chi2 V column

// Postdocs (weniger mobil)
tab gewpersp2b_SQ001 verlauf_rm_Pdoc if phase==2, chi2 V column
tab gewpersp2b_SQ002 verlauf_rm_Pdoc if phase==2, chi2 V column
tab gewpersp2b_SQ003 verlauf_rm_Pdoc if phase==2, chi2 V column
tab gewpersp2b_SQ004 verlauf_rm_Pdoc if phase==2, chi2 V column
tab gewpersp2b_SQ005 verlauf_rm_Pdoc if phase==2, chi2 V column

// Profs (Weniger mobil)
tab gewpersp2b_SQ001 verlauf_rm_Prof if phase==3, chi2 V column
tab gewpersp2b_SQ002 verlauf_rm_Prof if phase==3, chi2 V column
tab gewpersp2b_SQ003 verlauf_rm_Prof if phase==3, chi2 V column
tab gewpersp2b_SQ004 verlauf_rm_Prof if phase==3, chi2 V column
tab gewpersp2b_SQ005 verlauf_rm_Prof if phase==3, chi2 V column

// Auslandsaufenthalte nach Phase (chi2-Tetss)
tab allauslKurz_av all_auslkurz_uv, chi2 V column
tab allausl1_3Mon_av all_ausl1_3Mon_uv, chi2 V column
tab allausl3Mon_av all_ausl3Mon_uv, chi2 V column

*~~~~~~ Pendeln unter der Woche über 50 km (Keine Tabellen)
tab gewpersp2a_SQ001 PromProm_mobil if phase==1, chi2 V column
tab gewpersp2a_SQ002 PromProm_mobil if phase==1, chi2 V column
tab gewpersp2a_SQ003 PromProm_mobil if phase==1, chi2 V column
tab gewpersp2a_SQ004 PromProm_mobil if phase==1, chi2 V column

tab gewpersp2a_SQ001 PdocPdoc_mobil if phase==2, chi2 V column
tab gewpersp2a_SQ002 PdocPdoc_mobil if phase==2, chi2 V column
tab gewpersp2a_SQ003 PdocPdoc_mobil if phase==2, chi2 V column
tab gewpersp2a_SQ004 PdocPdoc_mobil if phase==2, chi2 V column

// Weitere Untersuchungen (Keine Tabellen)

// Gründe für mehr/weniger mobil werden wollen nach Fach und Phase (insbes. Post-doc/Prof)
by diszi, sort: tab gewpersp2a_SQ001 if phase==3
by diszi, sort: tab gewpersp2a_SQ002 if phase==3
by diszi, sort: tab gewpersp2a_SQ003 if phase==3
by diszi, sort: tab gewpersp2a_SQ004 if phase==3

by diszi, sort: tab gewpersp2b_SQ001 if phase==3
by diszi, sort: tab gewpersp2b_SQ002 if phase==3
by diszi, sort: tab gewpersp2b_SQ003 if phase==3
by diszi, sort: tab gewpersp2b_SQ004 if phase==3
by diszi, sort: tab gewpersp2b_SQ005 if phase==3*/