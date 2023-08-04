// Datensatz verwenden
// Working directory

use "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\SM_03.dta", clear 
describe, short

numlabel _all, add


*****************************************************************************************************
      	   ************ Aufbereitung der Daten zur Räumlichen Mobilität ***************
*****************************************************************************************************


// Stand: 05.07.2023. In diesem Do-File werden die Variablen aufbereitet um diese für die Auswertungen/Analysen zu verwenden. 

// 1. Ihr erhaltet zu jeder Variable entsprechende (Schriftliche) Informationen, die ich oberhalb der Variable bereistelle (Abk: I1)
// 2. Es werden (wo notwendig) Bezüge zu den entsprechenden Code-Zeilen in den Do-Files hergestellt, in denen die Auswertungen 
// 	  vorgenommen werden (Abk: I2)
// 3. Es werden Bezüge zu den Word-Dokumenten (FDM) hergestellt, in denen die Ergebnisse/Tabellen aufgelistet sin mit Seitenanzahl (Abk: I3)



									********************************
									****** PROMOTIONSPHASE *********
									********************************
									

// I1: Anzahl der Stellen in Promotionsphase der Promovierenden
gen stpromo_n=.
replace stpromo_n=0 if stpromo==0 & phase==1  
replace stpromo_n=1 if stpromo==1 & phase==1
replace stpromo_n=2 if stpromo==2 & phase==1
replace stpromo_n=3 if stpromo==3 & phase==1
replace stpromo_n=4 if stpromo==4 & phase==1
replace stpromo_n=5 if stpromo>=5 & stpromo<. & phase==1
label define stellen_lb 0 "0 Stellen" 1 "1 Stellen" 2 "2 Stellen" 3 "3 Stellen" 4 "4 Stellen" 5 "5 Stellen und mehr"
label values stpromo_n stellen_lb
label var stpromo_n "Wie viele Stellen an einer Hochschule oder wissenschaftlichen Einrichtung hatten Sie? (Promotionsphase)"
tab stpromo_n

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~ Zirkuläre Mobilität ~~~~~~~~~~~~~
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// I1: Pendeln unter der Woche (Promovierende/Promotionsphase). Mobilitätstypen: (sehr) häufig unter 20km (1), zwischen 20-50km (2), 50km und mehr (3)
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab. 2R: Pendelentfernungen unter der Woche nach Karrierephase (in %) --> Seite 2

// Mobilitätstypen Pendeln unter der Woche   (W! = DIESE VARIABLE WIRD SOWOHL FÜR nicht-phasenübergreifende als auch für phasenübergreifende Analysen verwendet)
gen prommobkm_ü50_3kat=.						// Daher hier keine Codierungen bei Zeile 291-325
replace prommobkm_ü50_3kat=1 if prommobkm_u20>=1 & prommobkm_u20<=2
replace prommobkm_ü50_3kat=2 if prommobkm_b50>=1 & prommobkm_b50<=2  
replace prommobkm_ü50_3kat=3 if prommobkm_ü50>=1 & prommobkm_ü50<=2  
label define PENDEL3kat_lb 1 "Unter 20 km" 2 "20 - 50 km" 3 "50 km und mehr"
label values prommobkm_ü50_3kat PENDEL3kat_lb
label var prommobkm_ü50_3kat "Pendelmobilität unter der Woche: (Promotionsphase)"
tab prommobkm_ü50_3kat if phase==1


// I1: Häufigkeit Wochendpendeln unter 100 km = 0 und über 100 km = 1
// I3: Nicht als Tabelle agebildet 
gen prommobkmwe_ü100_N=.
replace prommobkmwe_ü100_N=0 if (prommobkmwe_u100>=1 & prommobkmwe_u100<=3) | /// 
								(prommobkmwe_u100>=4 & prommobkmwe_u100<=5 & prommobkmwe_u250>=4 & prommobkmwe_u250<=5 & ///
								prommobkmwe_u500>=4 & prommobkmwe_u500<=5 & prommobkmwe_ü500>=4 & prommobkmwe_ü500<=5) 
replace prommobkmwe_ü100_N=1 if (prommobkmwe_u250>=1 & prommobkmwe_u250<=3) | /// 
								(prommobkmwe_u500>=1 & prommobkmwe_u500<=3) | ///
							    (prommobkmwe_ü500>=1 & prommobkmwe_ü500<=3) 
label values prommobkmwe_ü100_N PENDEL_lb
label var prommobkmwe_ü100_N "Pendelmobilität am Wochenende: Kurze versus lange Strecken (Promovierende/Promotionsphase)"
tab prommobkmwe_ü100_N if phase==1


// Mobilitätstypen Wochenendpendeln (Nur Promovierende)
// I1: Wochenendpendeln mit 3 Kategorien: Unter 100 km (manchmal, häufig, sehr häufig), zwischen 100 und 250 km, über 250 km Hier auf Phase==1 beschränkt.
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab. 4R: Wochenendpendeln nach Karrierephase (in %) --> Seite 3
gen prommobkmwe_3kat=.
replace prommobkmwe_3kat=1 if (prommobkmwe_u100>=1 & prommobkmwe_u100<=3) & phase==1 
replace prommobkmwe_3kat=2 if (prommobkmwe_u250>=1 & prommobkmwe_u250<=3) & phase==1  
replace prommobkmwe_3kat=3 if (prommobkmwe_u500>=1 & prommobkmwe_u500<=2) & phase==1 | ///
							  (prommobkmwe_ü500>=1 & prommobkmwe_ü500<=2) & phase==1 
replace prommobkmwe_3kat=. if (prommobkmwe_u100>=4 & prommobkmwe_u100<=5) & (prommobkmwe_u250>=4 & prommobkmwe_u250<=5) & ///
							  (prommobkmwe_u500>=4 & prommobkmwe_u500<=5) & (prommobkmwe_ü500>=4 & prommobkmwe_ü500<=5) & phase==1
label define promwekat3_lb 1 "Unter 100 km" 2 "Zwischen 100 und 250 km" 3 "über 250 km"
label values prommobkmwe_3kat promwekat3_lb
label var prommobkmwe_3kat "Pendelmobilität am Wochenende: Kurze versus lange Strecken (Promovierende/Promotionsphase)"
tab prommobkmwe_3kat


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~ Residentielle Mobilität ~~~~~~~~~~~~~~~~
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// I1: Häufigkeit Umzüge bei Stellenwechsel in Promotionsphase 
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab 6R: Umzugsmobilität je Phase und phasenübergreifend (Umzug bei Stellenwechsel) --> Seite 4
gen umzüge_prom_prompha=.
replace umzüge_prom_prompha=0 if stpromomove==0 & phase==1 
replace umzüge_prom_prompha=1 if stpromomove==1 & phase==1 
replace umzüge_prom_prompha=2 if stpromomove>=2 & stpromomove<. & stpromo_n>=2 & phase==1  // Müssen mindestens 2 Stellen gehabt haben
label define umzüge_anz_lb 0 "Keine Umzüge" 1 "1 Umzug" 2 "2 Umzüge und mehr"
label values umzüge_prom_prompha umzüge_anz_lb
label var umzüge_prom_prompha "Umzüge bei Stellenwechsel? (Promovierende/Promotionsphase)"
tab umzüge_prom_prompha 



							    ************************************
								********** Postdocphase ************
								************************************



// Anzahl Stellen (3 und mehr)
gen stpdoc_n=.
replace stpdoc_n=0 if stpdoc==0 & phase==2
replace stpdoc_n=1 if stpdoc==1 & phase==2
replace stpdoc_n=2 if stpdoc==2 & phase==2
replace stpdoc_n=3 if stpdoc==3 & phase==2
replace stpdoc_n=4 if stpdoc==4 & phase==2
replace stpdoc_n=5 if stpdoc>=5 & stpdoc<. & phase==2
label values stpdoc_n stellen_lb
label var stpdoc_n "Wie viele Stellen an einer Hochschule oder wissenschaftlichen Einrichtung hatten Sie? (Postdocphase)"
tab stpdoc_n 

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~ Zirkuläre Mobilität ~~~~~~~~~~~~~
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// I1: Pendeln unter der Woche (Postdocs/Postdoc-Phase). 
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab. 2R: Pendelentfernungen unter der Woche nach Karrierephase (in %) --> Seite 2

// Mobilitätstypen Pendeln unter der Woche
gen pdocmobkm_ü50_3kat=.
replace pdocmobkm_ü50_3kat=1 if pdocmobkm_u20>=1 & pdocmobkm_u20<=2
replace pdocmobkm_ü50_3kat=2 if pdocmobkm_b50>=1 & pdocmobkm_b50<=2  
replace pdocmobkm_ü50_3kat=3 if pdocmobkm_ü50>=1 & pdocmobkm_ü50<=2  
label values pdocmobkm_ü50_3kat PENDEL3kat_lb
label var pdocmobkm_ü50_3kat "Pendelmobilität unter der Woche: (Postdoc-Phase)"
tab pdocmobkm_ü50_3kat if phase==2


// I1: Häufigkeit Wochendpendeln unter 100 km = 0 und über 100 km = 1
gen pdocmobkmwe_ü100_N=.
replace pdocmobkmwe_ü100_N=0 if (pdocmobkmwe_u100>=1 & pdocmobkmwe_u100<=3) | ///
								(pdocmobkmwe_u100>=4 & pdocmobkmwe_u100<=5 & pdocmobkmwe_u250>=4 & pdocmobkmwe_u250<=5 & ///
								pdocmobkmwe_u500>=4 & pdocmobkmwe_u500<=5 & pdocmobkmwe_ü500>=4 & pdocmobkmwe_ü500<=5) 
replace pdocmobkmwe_ü100_N=1 if (pdocmobkmwe_u250>=1 & pdocmobkmwe_u250<=3) | /// 
								(pdocmobkmwe_u500>=1 & pdocmobkmwe_u500<=3) | ///
								(pdocmobkmwe_ü500>=1 & pdocmobkmwe_ü500<=3) 
label values pdocmobkmwe_ü100_N PENDEL_lb
label var pdocmobkmwe_ü100_N "Pendelmobilität am Wochenende: Kurze versus lange Strecken (Postdocphase)"
tab pdocmobkmwe_ü100_N if phase==2
// Mit list-Befehl kontrollieren wenn gewünscht
list id pdocmobkmwe_u100 pdocmobkmwe_u250 pdocmobkmwe_u500 pdocmobkmwe_ü500 pdocmobkmwe_ü100_N phase if (phase==2) & pdocmobkmwe_ü100_N !=. in 1/500


// Mobilitätstypen Wochenendpendeln
// I1: Wochenendpendeln mit 3 Kategorien: Unter 100 km (manchmal, häufig, sehr häufig), zwischen 100 und 250 km, über 250 km. Hier auf Phase==1 beschränkt. 
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab. 4R: Wochenendpendeln nach Karrierephase (in %) --> Seite 3
gen pdocmobkmwe_3kat=.
replace pdocmobkmwe_3kat=1 if (pdocmobkmwe_u100>=1 & pdocmobkmwe_u100<=3) & phase==2 
replace pdocmobkmwe_3kat=2 if (pdocmobkmwe_u250>=1 & pdocmobkmwe_u250<=3) & phase==2  
replace pdocmobkmwe_3kat=3 if (pdocmobkmwe_u500>=1 & pdocmobkmwe_u500<=2) & phase==2 | ///
							  (pdocmobkmwe_ü500>=1 & pdocmobkmwe_ü500<=2) & phase==2 
replace pdocmobkmwe_3kat=. if (pdocmobkmwe_u100>=4 & pdocmobkmwe_u100<=5) & (pdocmobkmwe_u250>=4 & pdocmobkmwe_u250<=5) & ///
							  (pdocmobkmwe_u500>=4 & pdocmobkmwe_u500<=5) & (pdocmobkmwe_ü500>=4 & pdocmobkmwe_ü500<=5) & phase==2
label values pdocmobkmwe_3kat promwekat3_lb
label var pdocmobkmwe_3kat "Pendelmobilität am Wochenende: Kurze versus lange Strecken (Postdocs/Postdoc-Phase)"
tab pdocmobkmwe_3kat


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~ Residentielle Mobilität ~~~~~~~~~~~~~~~~
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// I1: Häufigkeit Umzüge bei Stellenwechsel in Postdoc-Phase (Info: Wenn Phasenübergreifend untersucht werden soll, dann phase==1 entfernen)
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab 6R: Umzugsmobilität je Phase und phasenübergreifend (Umzug bei Stellenwechsel) --> 
// Seite 4
gen umzüge_pdoc_pdocpha=.
replace umzüge_pdoc_pdocpha=0 if stpdocmove==0 & stpdoc_n>=2 & phase==2
replace umzüge_pdoc_pdocpha=1 if stpdocmove==1 & stpdoc_n>=2 & phase==2
replace umzüge_pdoc_pdocpha=2 if stpdocmove>=2 & stpdocmove<. & stpdoc_n>=2 & phase==2 // Müssen mindestens 2 Stellen gehabt haben
label values umzüge_pdoc_pdocpha umzüge_anz_lb
label var umzüge_pdoc_pdocpha "Umzüge bei Stellenwechsel? (Postdocs/Postdocphase)"
tab umzüge_pdoc_pdocpha 



							********************************
							****** Professorenphase ********
							********************************

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~ Zirkuläre Mobilität ~~~~~~~~~~~~~
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// I1: Mobilitätstypen: Pendeln unter der Woche (Professoren/Professorenphase). 
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab. 2R: Pendelentfernungen unter der Woche nach Karrierephase (in %) --> Seite 2
gen profmobkm_ü50_3kat=.
replace profmobkm_ü50_3kat=1 if profmobkm_u20>=1 & profmobkm_u20<=2
replace profmobkm_ü50_3kat=2 if profmobkm_b50>=1 & profmobkm_b50<=2  
replace profmobkm_ü50_3kat=3 if profmobkm_ü50>=1 & profmobkm_ü50<=2  
label values profmobkm_ü50_3kat PENDEL3kat_lb
label var profmobkm_ü50_3kat "Pendelmobilität unter der Woche: (Prof-Phase)"
tab profmobkm_ü50_3kat

// I1: Häufigkeit Wochendpendeln unter 100 km = 0 und über 100 km = 1
gen profmobkmwe_ü100_N=.
replace profmobkmwe_ü100_N=0 if (profmobkmwe_u100>=1 & profmobkmwe_u100<=3) | ///
								(profmobkmwe_u100>=4 & profmobkmwe_u100<=5 & profmobkmwe_u250>=4 & profmobkmwe_u250<=5 & ///							
								 profmobkmwe_u500>=4 & profmobkmwe_u500<=5 & profmobkmwe_ü500>=4 & profmobkmwe_ü500<=5) 			
replace profmobkmwe_ü100_N=1 if (profmobkmwe_u250>=1 & profmobkmwe_u250<=3) | /// 
								(profmobkmwe_u500>=1 & profmobkmwe_u500<=3) | ///
								(profmobkmwe_ü500>=1 & profmobkmwe_ü500<=3)
label values profmobkmwe_ü100_N PENDEL_lb
label var profmobkmwe_ü100_N "Pendelmobilität am Wochenende: Kurze versus lange Strecken (Professorenphase)"
tab profmobkmwe_ü100_N
list id profmobkmwe_u100 profmobkmwe_u250 profmobkmwe_u500 profmobkmwe_ü500 profmobkmwe_ü100_N if (phase==3) & profmobkmwe_ü100_N != . in 1/1000

// Mobilitätstypen Wochenendpendeln
// I1: Wochenendpendeln mit 3 Kategorien: Unter 100 km (manchmal, häufig, sehr häufig), zwischen 100 und 250 km, über 250 km. Hier auf Phase==1 beschränkt. 
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab. 4R: Wochenendpendeln nach Karrierephase (in %) --> Seite 3
gen profmobkmwe_3kat=.
replace profmobkmwe_3kat=1 if (profmobkmwe_u100>=1 & profmobkmwe_u100<=3) 
replace profmobkmwe_3kat=2 if (profmobkmwe_u250>=1 & profmobkmwe_u250<=3) 
replace profmobkmwe_3kat=3 if (profmobkmwe_u500>=1 & profmobkmwe_u500<=2) | ///
							  (profmobkmwe_ü500>=1 & profmobkmwe_ü500<=2)
replace profmobkmwe_3kat=. if (profmobkmwe_u100>=4 & profmobkmwe_u100<=5) & (profmobkmwe_u250>=4 & profmobkmwe_u250<=5) & ///
							  (profmobkmwe_u500>=4 & profmobkmwe_u500<=5) & (profmobkmwe_ü500>=4 & profmobkmwe_ü500<=5) 
label values profmobkmwe_3kat promwekat3_lb
label var profmobkmwe_3kat "Pendelmobilität am Wochenende: Kurze versus lange Strecken (Profs/Prof-Phase)"
tab profmobkmwe_3kat


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~ Residentielle Mobilität ~~~~~~~~~~~~~~~~
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// I1: Häufigkeit Umzüge bei Stellenwechsel in Prof-Phase 
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab 6R: Umzugsmobilität je Phase und phasenübergreifend (Umzug bei Stellenwechsel) --> Seite 4
gen umzüge_prof_profpha=.
replace umzüge_prof_profpha=0 if stprofmove==0 & stprof>=2
replace umzüge_prof_profpha=1 if stprofmove==1 & stprof>=2
replace umzüge_prof_profpha=2 if stprofmove>=2 & stprofmove<. & stprof>=2
label values umzüge_prof_profpha umzüge_anz_lb
label var umzüge_prof_profpha "Umzüge bei Stellenwechsel? (Professoren/Professorenphase)"
tab umzüge_prof_profpha


********************************************************************************************
****************************** PHASENÜBERGREIFEND *******************************************
********************************************************************************************

// Residentielle Mobilität

// I1: Umzugsvaribale phasenübergreifend (Anzahl Umzüge der Profs in Postdocphase)
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab 6R: Umzugsmobilität je Phase und phasenübergreifend (Umzug bei Stellenwechsel) --> Seite 4

gen umzüge_prof_pdocpha=.
replace umzüge_prof_pdocpha=0 if stpdocmove==0 & stpdoc>=2 & phase==3 
replace umzüge_prof_pdocpha=1 if stpdocmove==1 & stpdoc>=2 & phase==3
replace umzüge_prof_pdocpha=2 if stpdocmove>=2 & stpdocmove<. & stpdoc>=2 & phase==3
label values umzüge_prof_pdocpha umzüge_anz_lb
label var umzüge_prof_pdocpha "Umzüge bei Stellenwechsel? (Professoren/Postdocphase)"
tab umzüge_prof_pdocpha
 
// Umzugsvaribale codieren (Anzahl Umzüge der Profs in Promotionsphase)
gen umzüge_prof_prompha=.
replace umzüge_prof_prompha=0 if stpromomove==0 & stpromo>=2 & phase==3
replace umzüge_prof_prompha=1 if stpromomove==1 & stpromo>=2 & phase==3
replace umzüge_prof_prompha=2 if stpromomove>=2 & stpromomove<. & stpromo>=2 & phase==3
label values umzüge_prof_prompha umzüge_anz_lb
label var umzüge_prof_prompha "Umzüge bei Stellenwechsel? (Professoren/Promotionsphase)"
tab umzüge_prof_prompha

// Umzugsvaribale codieren (Anzahl Umzüge der Pdocs in Promotionsphase)
gen umzüge_pdoc_prompha=.
replace umzüge_pdoc_prompha=0 if stpromomove==0 & stpromo>=2 & phase==2
replace umzüge_pdoc_prompha=1 if stpromomove==1 & stpromo>=2 & phase==2
replace umzüge_pdoc_prompha=2 if stpromomove>=2 & stpromomove<. & stpromo>=2 & phase==2
label values umzüge_pdoc_prompha umzüge_anz_lb
label var umzüge_pdoc_prompha "Umzüge bei Stellenwechsel? (Postdocs/Promotionsphase)"
tab umzüge_pdoc_prompha


// Wochenendpendeln 

// I1: Wochenendpendeln phasenübergreifend (Wird für Verlaufsvariable verwendet)
// I3: Keine Tabellen vorhanden zu diesen Verteilungen (Wird nur für operationalisierung der Index-Variable verwendet)

// Wochend-Pendeln über 100 km (Profs/Postdocphase)
gen prof_pdocmobkmwe_ü100_N=.
replace prof_pdocmobkmwe_ü100_N=0 if (pdocmobkmwe_u100>=1 & pdocmobkmwe_u100<=3) & phase==3 | ///
								(pdocmobkmwe_u100>=4 & pdocmobkmwe_u100<=5 & pdocmobkmwe_u250>=4 & pdocmobkmwe_u250<=5 & ///
								pdocmobkmwe_u500>=4 & pdocmobkmwe_u500<=5 & pdocmobkmwe_ü500>=4 & pdocmobkmwe_ü500<=5) & phase==3
replace prof_pdocmobkmwe_ü100_N=1 if (pdocmobkmwe_u250>=1 & pdocmobkmwe_u250<=3) & phase==3 | /// 
								(pdocmobkmwe_u500>=1 & pdocmobkmwe_u500<=3) & phase==3 | ///
								(pdocmobkmwe_ü500>=1 & pdocmobkmwe_ü500<=3) & phase==3
label values prof_pdocmobkmwe_ü100_N PENDEL_lb
label var prof_pdocmobkmwe_ü100_N "Pendelmobilität von mindestens 100 km am Wochenende (Professoren/Postdocphase)"
tab prof_pdocmobkmwe_ü100_N

// Wochend-Pendeln über 100 km = 1 und unter 100 km = 0 (Profs/Promotionsphase)
gen prof_prommobkmwe_ü100_N=.
replace prof_prommobkmwe_ü100_N=0 if (prommobkmwe_u100>=1 & prommobkmwe_u100<=3) & phase==3 | /// 
								(prommobkmwe_u100>=4 & prommobkmwe_u100<=5 & prommobkmwe_u250>=4 & prommobkmwe_u250<=5 & ///
								prommobkmwe_u500>=4 & prommobkmwe_u500<=5 & prommobkmwe_ü500>=4 & prommobkmwe_ü500<=5) & phase==3
replace prof_prommobkmwe_ü100_N=1 if (prommobkmwe_u250>=1 & prommobkmwe_u250<=3) & phase==3 | /// 
								(prommobkmwe_u500>=1 & prommobkmwe_u500<=3) & phase==3 | ///
							    (prommobkmwe_ü500>=1 & prommobkmwe_ü500<=3) & phase==3 
label values prof_prommobkmwe_ü100_N PENDEL_lb
label var prof_prommobkmwe_ü100_N "Pendelmobilität von mindestens 100 km am Wochenende (Professoren/Promotionsphase)"
tab prof_prommobkmwe_ü100_N

// Wochend-Pendeln über 100 km (Postdocs/Promotionsphase)
gen pdoc_prommobkmwe_ü100_N=.
replace pdoc_prommobkmwe_ü100_N=0 if (prommobkmwe_u100>=1 & prommobkmwe_u100<=3) & phase==2 | /// 
								(prommobkmwe_u100>=4 & prommobkmwe_u100<=5 & prommobkmwe_u250>=4 & prommobkmwe_u250<=5 & ///
								prommobkmwe_u500>=4 & prommobkmwe_u500<=5 & prommobkmwe_ü500>=4 & prommobkmwe_ü500<=5) & phase==2
replace pdoc_prommobkmwe_ü100_N=1 if (prommobkmwe_u250>=1 & prommobkmwe_u250<=3) & phase==2 | /// 
								(prommobkmwe_u500>=1 & prommobkmwe_u500<=3) & phase==2 | ///
							    (prommobkmwe_ü500>=1 & prommobkmwe_ü500<=3) & phase==2 
label values pdoc_prommobkmwe_ü100_N PENDEL_lb
label var pdoc_prommobkmwe_ü100_N "Pendelmobilität von mindestens 100 km am Wochenende (Postdocs/Promotionsphase)"
tab pdoc_prommobkmwe_ü100_N


****************************************************************************************************************************************************
********************************** Verlaufsform der räumlichen Mobilität über alle Phasen **********************************************************
****************************************************************************************************************************************************


							*****************************************
							   *********** Professoren ***********
							*****************************************
							
							
// I1: Zunächst werden Variablen codiert, die residientielle und zirkuläre Mobilität zum Zeitpunkt der gegenwärtigen und der vorherigen Phasen abbilden
// I3: 1_RM (Formen univariat nach Phase und Fach, 18R: Indexvariable aus Fernpendeln, Wochenendpendeln und Umzugsmobilität --> Seite 10 

// Räumliche Mobilität der Professoren während Promotionspahse (Residenzielle und zirkuläre Mobilität verknüpft)
// 0 = immobil, 1 = mobil
gen ProfProm_mobil=.
replace ProfProm_mobil=0 if (prommobkm_ü50_3kat<=2 & prof_prommobkmwe_ü100_N==0 & umzüge_prof_prompha==0) & phase==3 | ///
							(prommobkm_ü50_3kat<=2 & prof_prommobkmwe_ü100_N==0 & umzüge_prof_prompha==.) & phase==3 | ///
							(prommobkm_ü50_3kat<=2 & prof_prommobkmwe_ü100_N==. & umzüge_prof_prompha==0) & phase==3 | ///
							(prommobkm_ü50_3kat==. & prof_prommobkmwe_ü100_N==0 & umzüge_prof_prompha==0) & phase==3 | ///
							(prommobkm_ü50_3kat<=2 & prof_prommobkmwe_ü100_N==. & umzüge_prof_prompha==.) & phase==3 | ///
							(prommobkm_ü50_3kat==. & prof_prommobkmwe_ü100_N==0 & umzüge_prof_prompha==.) & phase==3 | ///
							(prommobkm_ü50_3kat==. & prof_prommobkmwe_ü100_N==. & umzüge_prof_prompha==0) 
replace ProfProm_mobil=1 if (prommobkm_ü50_3kat==3 | prof_prommobkmwe_ü100_N==1 | umzüge_prof_prompha>=1 & umzüge_prof_prompha<.) & phase==3
label define individual_lb 0 "immobil" 1 "Mobil" 
label values ProfProm_mobil individual_lb
label var ProfProm_mobil "Räumliche Mobilität (Residenziell und Zirkulär) bei den Profs/Promotionsphase"
tab ProfProm_mobil

// Prof-Promphase (Residenzielle und zirkuläre Mobilität verknüpft)
gen ProfPdoc_mobil=.
replace ProfPdoc_mobil=0 if (pdocmobkm_ü50_3kat<=2 & prof_pdocmobkmwe_ü100_N==0 & umzüge_prof_pdocpha==0) & phase==3 | ///
							(pdocmobkm_ü50_3kat<=2 & prof_pdocmobkmwe_ü100_N==0 & umzüge_prof_pdocpha==.) & phase==3 | ///
							(pdocmobkm_ü50_3kat<=2 & prof_pdocmobkmwe_ü100_N==. & umzüge_prof_pdocpha==0) & phase==3 | ///
							(pdocmobkm_ü50_3kat==. & prof_pdocmobkmwe_ü100_N==0 & umzüge_prof_pdocpha==0) & phase==3 | ///
							(pdocmobkm_ü50_3kat<=2 & prof_pdocmobkmwe_ü100_N==. & umzüge_prof_pdocpha==.) & phase==3 | ///
							(pdocmobkm_ü50_3kat==. & prof_pdocmobkmwe_ü100_N==0 & umzüge_prof_pdocpha==.) & phase==3 | ///
							(pdocmobkm_ü50_3kat==. & prof_pdocmobkmwe_ü100_N==. & umzüge_prof_pdocpha==0)
replace ProfPdoc_mobil=1 if (pdocmobkm_ü50_3kat==3 | prof_pdocmobkmwe_ü100_N==1 | umzüge_prof_pdocpha>=1 & umzüge_prof_pdocpha<.) & phase==3
label values ProfPdoc_mobil individual_lb
label var ProfPdoc_mobil "Räumliche Mobilität (Residenziell und Zirkulär) bei den Profs/Pdoc-Phase"
tab ProfPdoc_mobil

// Prof-Profphase (Residenzielle und zirkuläre Mobilität verknüpft)
gen ProfProf_mobil=.
replace ProfProf_mobil=0 if (profmobkm_ü50_3kat<=2 & profmobkmwe_ü100_N==0 & umzüge_prof_profpha==0) & phase==3 | ///
							(profmobkm_ü50_3kat<=2 & profmobkmwe_ü100_N==0 & umzüge_prof_profpha==.) & phase==3 | ///
							(profmobkm_ü50_3kat<=2 & profmobkmwe_ü100_N==. & umzüge_prof_profpha==0) & phase==3 | ///
							(profmobkm_ü50_3kat==. & profmobkmwe_ü100_N==0 & umzüge_prof_profpha==0) & phase==3 | ///
							(profmobkm_ü50_3kat<=2 & profmobkmwe_ü100_N==. & umzüge_prof_profpha==.) & phase==3 | ///
							(profmobkm_ü50_3kat==. & profmobkmwe_ü100_N==0 & umzüge_prof_profpha==.) & phase==3 | ///
							(profmobkm_ü50_3kat==. & profmobkmwe_ü100_N==. & umzüge_prof_profpha==0) 
replace ProfProf_mobil=1 if (profmobkm_ü50_3kat==3 | profmobkmwe_ü100_N==1 | umzüge_prof_profpha>=1 & umzüge_prof_profpha<.) & phase==3
label values ProfProf_mobil individual_lb
label var ProfProf_mobil "Räumliche Mobilität (Residenziell und Zirkulär) bei den Profs/Prof-Phase"
tab ProfProf_mobil


// I1: Verlauf der räumlichen Mobilität der Professoren zusammengesetzt aus den obigen Variablen
// I2: Verlaufsvariable nach Fach in 1B_Mobi_Results_RM_2, Zeile 247-254
// I3: 1_RM (Formen univariat nach Phase und Fach, Verlaufsvariable aus Fernpendeln, Wochenendpendeln und Umzugsmobilität --> Seite 10

// 8 Kombinationsmöglichkeiten zur Bildung der individuellen Mobilitätsverläufe der Professoren über alle 3 Phasen
// 0-0-0 // Stetig immobil
// 1-0-0 // Abnehmend mobil
// 1-1-0 // Abnehmend mobil
// 0-1-0 // Wechselnd mobil
// 1-0-1 // Wechselnd mobil
// 0-0-1 // Zunehmend mobil
// 0-1-1 // Zunehmend mobil
// 1-1-1 // Stetig mobil

gen verlauf_rm_Prof=.
replace verlauf_rm_Prof=1 if ProfProm_mobil==0 & ProfPdoc_mobil==0 & ProfProf_mobil==0
replace verlauf_rm_Prof=2 if (ProfProm_mobil==1 & ProfPdoc_mobil==0 & ProfProf_mobil==0) | ///
							 (ProfProm_mobil==1 & ProfPdoc_mobil==1 & ProfProf_mobil==0)
replace verlauf_rm_Prof=3 if (ProfProm_mobil==0 & ProfPdoc_mobil==1 & ProfProf_mobil==0) | ///
							 (ProfProm_mobil==1 & ProfPdoc_mobil==0 & ProfProf_mobil==1)
replace verlauf_rm_Prof=4 if (ProfProm_mobil==0 & ProfPdoc_mobil==0 & ProfProf_mobil==1) | ///
							 (ProfProm_mobil==0 & ProfPdoc_mobil==1 & ProfProf_mobil==1)
replace verlauf_rm_Prof=5 if (ProfProm_mobil==1 & ProfPdoc_mobil==1 & ProfProf_mobil==1)
label define profmobi_lb 1 "Stetig immobil" 2 "Abnehmend mobil" 3 "Wechselnd mobil" 4 "Zunehmend mobil" 5 "Stetig mobil"
label values verlauf_rm_Prof profmobi_lb
label var verlauf_rm_Prof "Verlauf der räumlichen Mobilität über die Phasen der Professoren"
tab verlauf_rm_Prof


									************************************
									  *********** Postdocs ***********
									************************************
						
// Pdoc-Promphase (Residenzielle und zirkuläre Mobilität verknüpft)
gen PdocProm_mobil=.
replace PdocProm_mobil=0 if (prommobkm_ü50_3kat<=2 & pdoc_prommobkmwe_ü100_N==0 & umzüge_pdoc_prompha==0) & phase==2 | ///
							(prommobkm_ü50_3kat<=2 & pdoc_prommobkmwe_ü100_N==0 & umzüge_pdoc_prompha==.) & phase==2 | ///
							(prommobkm_ü50_3kat<=2 & pdoc_prommobkmwe_ü100_N==. & umzüge_pdoc_prompha==0) & phase==2 | ///
							(prommobkm_ü50_3kat==. & pdoc_prommobkmwe_ü100_N==0 & umzüge_pdoc_prompha==0) & phase==2 | ///
							(prommobkm_ü50_3kat<=2 & pdoc_prommobkmwe_ü100_N==. & umzüge_pdoc_prompha==.) & phase==2 | ///
							(prommobkm_ü50_3kat==. & pdoc_prommobkmwe_ü100_N==0 & umzüge_pdoc_prompha==.) & phase==2 | ///
							(prommobkm_ü50_3kat==. & pdoc_prommobkmwe_ü100_N==. & umzüge_pdoc_prompha==0) 
replace PdocProm_mobil=1 if (prommobkm_ü50_3kat==3 | pdoc_prommobkmwe_ü100_N==1 | umzüge_pdoc_prompha>=1 & umzüge_pdoc_prompha<.) & phase==2
label values PdocProm_mobil individual_lb
label var PdocProm_mobil "Räumliche Mobilität (Residenziell und Zirkulär) bei den Pdocs/Promotionsphase"
tab PdocProm_mobil 

// Pdoc-Pdocphase (Residenzielle und zirkuläre Mobilität verknüpft)
gen PdocPdoc_mobil=.
replace PdocPdoc_mobil=0 if (pdocmobkm_ü50_3kat<=2 & pdocmobkmwe_ü100_N==0 & umzüge_pdoc_pdocpha==0) & phase==2 | ///
							(pdocmobkm_ü50_3kat<=2 & pdocmobkmwe_ü100_N==0 & umzüge_pdoc_pdocpha==.) & phase==2 | ///
							(pdocmobkm_ü50_3kat<=2 & pdocmobkmwe_ü100_N==. & umzüge_pdoc_pdocpha==0) & phase==2 | ///
							(pdocmobkm_ü50_3kat==. & pdocmobkmwe_ü100_N==0 & umzüge_pdoc_pdocpha==0) & phase==2 | ///
							(pdocmobkm_ü50_3kat<=2 & pdocmobkmwe_ü100_N==. & umzüge_pdoc_pdocpha==.) & phase==2 | ///
							(pdocmobkm_ü50_3kat==. & pdocmobkmwe_ü100_N==0 & umzüge_pdoc_pdocpha==.) & phase==2 | ///
							(pdocmobkm_ü50_3kat==. & pdocmobkmwe_ü100_N==. & umzüge_pdoc_pdocpha==0)
replace PdocPdoc_mobil=1 if (pdocmobkm_ü50_3kat==3 | pdocmobkmwe_ü100_N==1 | umzüge_pdoc_pdocpha>=1 & umzüge_pdoc_pdocpha<.) & phase==2
label values PdocPdoc_mobil individual_lb
label var PdocPdoc_mobil "Räumliche Mobilität (Residenziell und Zirkulär) bei den Pdocs/Pdoc-Phase"
tab PdocPdoc_mobil 

// I1: Gleiche Logik wie bei den Professoren
// I2: Verlaufsvariable nach Fach in 1B_Mobi_Results_RM_2, Zeile 247-254
// I3: Gleiche Word-Datei, gleiche Tabelle wie bei den Professoren

// 4 Kombinationsmöglichkeiten zur Bildung der individuellen Mobilitätsverläufe der Postdocs über beide Phasen
// 0-0 // Stetig immobil
// 0-1 // Zunehmend mobil
// 1-0 // Abnehmend mobil
// 1-1 // Stetig mobil
gen verlauf_rm_Pdoc=.
replace verlauf_rm_Pdoc=1 if PdocProm_mobil==0 & PdocPdoc_mobil==0
replace verlauf_rm_Pdoc=2 if PdocProm_mobil==1 & PdocPdoc_mobil==0
replace verlauf_rm_Pdoc=3 if PdocProm_mobil==0 & PdocPdoc_mobil==1
replace verlauf_rm_Pdoc=4 if PdocProm_mobil==1 & PdocPdoc_mobil==1
label define pdocmobi_lb 1 "Stetig immobil" 2 "Abnehmend mobil" 3 "Zunehmend mobil" 4 "Stetig mobil"
label values verlauf_rm_Pdoc pdocmobi_lb
label var verlauf_rm_Pdoc "Verlauf der räumlichen Mobilität über die Phasen der Postdocs"
tab verlauf_rm_Pdoc 

*****************************************
*********** Für Promovierende ***********
*****************************************

// I1: Gleiche Logik wie bei den Professoren
// I3: Gleiche Word-Datei, gleiche Tabelle wie bei den Professoren
gen PromProm_mobil=.
replace PromProm_mobil=0 if (prommobkm_ü50_3kat<=2 & prommobkmwe_ü100_N==0 & umzüge_prom_prompha==0) & phase==1 | ///
							(prommobkm_ü50_3kat<=2 & prommobkmwe_ü100_N==0 & umzüge_prom_prompha==.) & phase==1 | ///
							(prommobkm_ü50_3kat<=2 & prommobkmwe_ü100_N==. & umzüge_prom_prompha==0) & phase==1 | ///
							(prommobkm_ü50_3kat==. & prommobkmwe_ü100_N==0 & umzüge_prom_prompha==0) & phase==1 | ///
							(prommobkm_ü50_3kat<=2 & prommobkmwe_ü100_N==. & umzüge_prom_prompha==.) & phase==1 | ///
							(prommobkm_ü50_3kat==. & prommobkmwe_ü100_N==0 & umzüge_prom_prompha==.) & phase==1 | ///
							(prommobkm_ü50_3kat==. & prommobkmwe_ü100_N==. & umzüge_prom_prompha==0)
replace PromProm_mobil=1 if (prommobkm_ü50_3kat==3 | prommobkmwe_ü100_N==1 | umzüge_prom_prompha>=1 & umzüge_prom_prompha<.) & phase==1
label values PromProm_mobil individual_lb
label var PromProm_mobil "Räumliche Mobilität (Residenziell und Zirkulär) bei den Promoviernde/Promotionsphase"
tab PromProm_mobil


					*************************************************
						********* Auslandsaufenthalte **********

						
						
************************************************
********* >= 3 Monate Aufenthalt im Ausland *******
************************************************* 

// Nicht deutschsprachiges Ausland >= 3 Monate

// I1: Auslandsmobilität >=3 Monate
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab 9R: Aufenthalte mehr als 3 Monate im nicht-deutschsprachigen Ausland 
//     je Phase und phasenübergreifend --> Seite 5

// Promotionsphase
encode promoaufenth_SQ006, gen(s_promoaufenth_SQ006)
recode       s_promoaufenth_SQ006 (1 = .)
recode       s_promoaufenth_SQ006 (2 = 1)
recode       s_promoaufenth_SQ006 (3 = 2)
recode       s_promoaufenth_SQ006 (4 = 3)
recode       s_promoaufenth_SQ006 (5 = 4)
recode       s_promoaufenth_SQ006 (6 = 5)
gen niausl3prom=.
replace niausl3prom=1 if s_promoaufenth_SQ006>=1 & s_promoaufenth_SQ006<=3
replace niausl3prom=2 if s_promoaufenth_SQ006>=4 & s_promoaufenth_SQ006<=5 
label define niaus_lb 1 "Sehr häufig/Häufig/Manchmal" 2 "Selten/Nie"
label values niausl3prom niaus_lb
label var niausl3prom "Auslandsaufenthalte von mehr als 3 Monaten im nicht-deutschsprachigen Ausland (Promotionsphase)"
tab niausl3prom if phase==1
// by diszi, sort: tab niausl3prom if phase==1

// Postdoc-Phase
encode pdocaufenth_SQ006, gen(s_pdocaufenth_SQ006)
recode       s_pdocaufenth_SQ006 (1 = .)
recode       s_pdocaufenth_SQ006 (2 = 1)
recode       s_pdocaufenth_SQ006 (3 = 2)
recode       s_pdocaufenth_SQ006 (4 = 3)
recode       s_pdocaufenth_SQ006 (5 = 4)
recode       s_pdocaufenth_SQ006 (6 = 5)
gen niausl3pdoc=.
replace niausl3pdoc=1 if s_pdocaufenth_SQ006>=1 & s_pdocaufenth_SQ006<=3
replace niausl3pdoc=2 if s_pdocaufenth_SQ006>=4 & s_pdocaufenth_SQ006<=5
label values niausl3pdoc niaus_lb
label var niausl3pdoc "Auslandsaufenthalte von mehr als 3 Monaten im nicht-deutschsprachigen Ausland (Postdoc-Phase)"
tab niausl3pdoc if phase==2
// by diszi, sort: tab niausl3pdoc if phase==2

// Profphase
encode profaufenth_SQ006, gen(s_profaufenth_SQ006)
recode       s_profaufenth_SQ006 (1 = .)
recode       s_profaufenth_SQ006 (2 = 1)
recode       s_profaufenth_SQ006 (3 = 2)
recode       s_profaufenth_SQ006 (4 = 3)
recode       s_profaufenth_SQ006 (5 = 4)
recode       s_profaufenth_SQ006 (6 = 5)
gen niausl3prof=.
replace niausl3prof=1 if s_profaufenth_SQ006>=1 & s_profaufenth_SQ006<=3
replace niausl3prof=2 if s_profaufenth_SQ006>=4 & s_profaufenth_SQ006<=5
label values niausl3prof niaus_lb
label var niausl3prof "Auslandsaufenthalte von mehr als 3 Monaten im nicht-deutschsprachigen Ausland (Prof-Phase)"
tab niausl3prof if phase==3
// by diszi, sort: tab niausl3prof if phase==3


*************************************************
********* Kurzaufenthalte ********************
************************************************* 

// Nicht deutschsprachiges Ausland Kurzaufenthalte

// I1: Kurzaufenthalte 
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab 7R: Kurzaufenthalte im nicht-deutschsprachigen Ausland je Phase und phasenübergreifend
//     je Phase und phasenübergreifend --> Seite 4

// Promotionsphase
encode promoaufenth_SQ004, gen(s_promoaufenth_SQ004)
recode       s_promoaufenth_SQ004 (1 = .)
recode       s_promoaufenth_SQ004 (2 = 1)
recode       s_promoaufenth_SQ004 (3 = 2)
recode       s_promoaufenth_SQ004 (4 = 3)
recode       s_promoaufenth_SQ004 (5 = 4)
recode       s_promoaufenth_SQ004 (6 = 5)
gen niauslkurzprom=.
replace niauslkurzprom=1 if s_promoaufenth_SQ004>=1 & s_promoaufenth_SQ004<=3
replace niauslkurzprom=2 if s_promoaufenth_SQ004>=4 & s_promoaufenth_SQ004<=5
label define niauslkurz_lb 1 "Sehr häufig/Häufig/Manchmal" 2 "Selten/Nie"
label values niauslkurzprom niauslkurz_lb
label var niauslkurzprom "Kurzfufenthalte im nicht-deutschprachigen Ausland (Promotionsphase)"
tab niauslkurzprom if phase==1
// by diszi, sort: tab niauslkurzprom if phase==1


// Postdoc-Phase
encode pdocaufenth_SQ004, gen(s_pdocaufenth_SQ004)
recode       s_pdocaufenth_SQ004 (1 = .)
recode       s_pdocaufenth_SQ004 (2 = 1)
recode       s_pdocaufenth_SQ004 (3 = 2)
recode       s_pdocaufenth_SQ004 (4 = 3)
recode       s_pdocaufenth_SQ004 (5 = 4)
recode       s_pdocaufenth_SQ004 (6 = 5)
gen niauslkurzpdoc=.
replace niauslkurzpdoc=1 if s_pdocaufenth_SQ004>=1 & s_pdocaufenth_SQ004<=3
replace niauslkurzpdoc=2 if s_pdocaufenth_SQ004>=4 & s_pdocaufenth_SQ004<=5
label values niauslkurzpdoc niauslkurz_lb
label var niauslkurzpdoc "Kurzfufenthalte im nicht-deutschprachigen Ausland (Postdoc-Phase)"
tab niauslkurzpdoc if phase==2
// by diszi, sort: tab niauslkurzpdoc if phase==2

// Prof-Phase
encode profaufenth_SQ004, gen(s_profaufenth_SQ004)
recode       s_profaufenth_SQ004 (1 = .)
recode       s_profaufenth_SQ004 (2 = 1)
recode       s_profaufenth_SQ004 (3 = 2)
recode       s_profaufenth_SQ004 (4 = 3)
recode       s_profaufenth_SQ004 (5 = 4)
recode       s_profaufenth_SQ004 (6 = 5)
gen niauslkurzprof=.
replace niauslkurzprof=1 if s_profaufenth_SQ004>=1 & s_profaufenth_SQ004<=3
replace niauslkurzprof=2 if s_profaufenth_SQ004>=4 & s_profaufenth_SQ004<=5
label values niauslkurzprof niauslkurz_lb
label var niauslkurzprof "Kurzfufenthalte im nicht-deutschprachigen Ausland (Prof-Phase)"
tab niauslkurzprof
// by diszi, sort: tab niauslkurzprof if phase==3


*************************************************
********* Zwischen 1-3 Monaten Aufenthalt ********
************************************************* 


// I1: Aufenthalte von 1-3 Monaten
// I3: 1_RM (Formen univariat nach Phase und Fach, Tab 8R. Aufenthalte zwischen 1-3 Monate im nicht-deutschsprachigen Ausland je 
// Phase + phasenübergreifend --> Seite 5

// Promotionsphase
encode promoaufenth_SQ005, gen(s_promoaufenth_SQ005)
recode       s_promoaufenth_SQ005 (1 = .)
recode       s_promoaufenth_SQ005 (2 = 1)
recode       s_promoaufenth_SQ005 (3 = 2)
recode       s_promoaufenth_SQ005 (4 = 3)
recode       s_promoaufenth_SQ005 (5 = 4)
recode       s_promoaufenth_SQ005 (6 = 5)
gen niausl1bis3prom=.
replace niausl1bis3prom=1 if s_promoaufenth_SQ005>=1 & s_promoaufenth_SQ005<=3
replace niausl1bis3prom=2 if s_promoaufenth_SQ005>=4 & s_promoaufenth_SQ005<=5
label values niausl1bis3prom niauslkurz_lb
label var niausl1bis3prom "Auslandsaufenthalte von 1-3 Monaten im nicht-deutschsprachigen Ausland (Promotionsphase)"
tab niausl1bis3prom if phase==1

// Postdoc-Phase
encode pdocaufenth_SQ005, gen(s_pdocaufenth_SQ005)
recode       s_pdocaufenth_SQ005 (1 = .)
recode       s_pdocaufenth_SQ005 (2 = 1)
recode       s_pdocaufenth_SQ005 (3 = 2)
recode       s_pdocaufenth_SQ005 (4 = 3)
recode       s_pdocaufenth_SQ005 (5 = 4)
recode       s_pdocaufenth_SQ005 (6 = 5)
gen niausl1bis3pdoc=.
replace niausl1bis3pdoc=1 if s_pdocaufenth_SQ005>=1 & s_pdocaufenth_SQ005<=3
replace niausl1bis3pdoc=2 if s_pdocaufenth_SQ005>=4 & s_pdocaufenth_SQ005<=5
label values niausl1bis3pdoc niauslkurz_lb
label var niausl1bis3pdoc "Auslandsaufenthalte von 1-3 Monaten im nicht-deutschsprachigen Ausland (Postdoc-Phase)"
tab niausl1bis3pdoc if phase==2

// Prof-Phase
encode profaufenth_SQ005, gen(s_profaufenth_SQ005)
recode       s_profaufenth_SQ005 (1 = .)
recode       s_profaufenth_SQ005 (2 = 1)
recode       s_profaufenth_SQ005 (3 = 2)
recode       s_profaufenth_SQ005 (4 = 3)
recode       s_profaufenth_SQ005 (5 = 4)
recode       s_profaufenth_SQ005 (6 = 5)
gen niausl1bis3prof=.
replace niausl1bis3prof=1 if s_profaufenth_SQ005>=1 & s_profaufenth_SQ005<=3
replace niausl1bis3prof=2 if s_profaufenth_SQ005>=4 & s_profaufenth_SQ005<=5
label values niausl1bis3prof niauslkurz_lb
label var niausl1bis3prof "Auslandsaufenthalte von 1-3 Monaten im nicht-deutschsprachigen Ausland (Prof-Phase)"
tab niausl1bis3prof


*********************************************************************************************************************
*************************   Aufbereitung für Signifikanztests (ANOVA, Chi2-Test, Rho)  ******************************
*********************************************************************************************************************

*~~~~~~~~~~~~~~~~ Pendelmobilität unter der Woche

// I1: Pendelmobilität unter der Woche nach Phase
// I2: Ergebnisse in 1B_Mobi_Signifikanztests_3_Results --> Zeile 33-39

// Gruppe 1 (Promovierende)
gen commute_prom_g1=.
replace commute_prom_g1 = prommobkm_ü50_3kat if phase==1 // Ausprägungen zur Pendelmobilität werden Gruppe 1 zugeordnet
// Gruppe 2 (Postdocs)
gen commute_pdoc_g2=.
replace commute_pdoc_g2 = pdocmobkm_ü50_3kat if phase==2 // Ausprägungen zur Pendelmobilität werden Gruppe 2 zugeordnet
// Gruppe 3 (Profs)
gen commute_prof_g3=.
replace commute_prof_g3 = profmobkm_ü50_3kat if phase==3 // Ausprägungen zur Pendelmobilität werden Gruppe 3 zugeordnet

// Generate UV (Ausprägungen werden der Variable "commute_allgroup_uv" zugeordnet, enthält Anzahl Personen pro Phase)
gen commute_allgroup_uv=.
replace commute_allgroup_uv=1 if commute_prom_g1>=1 & commute_prom_g1<=3
replace commute_allgroup_uv=2 if commute_pdoc_g2>=1 & commute_pdoc_g2<=3
replace commute_allgroup_uv=3 if commute_prof_g3>=1 & commute_prof_g3<=3
label define phcomm_lb 1 "Promovierende" 2 "Postdocs" 3 "Profs"
label values commute_allgroup_uv phcomm_lb
label var commute_allgroup_uv "Pendelmobilität u.d.W. zwischen den Phasen"
tab commute_allgroup_uv 

// Generate AV  (Hier werden die Ausprägungen den entsprechenden Phasen zugeordnet)
gen commute_group_av=.
replace commute_group_av=commute_prom_g1 if commute_allgroup_uv==1
replace commute_group_av=commute_pdoc_g2 if commute_allgroup_uv==2
replace commute_group_av=commute_prof_g3 if commute_allgroup_uv==3
label define phcommav_lb 1 "Unter 20 km" 2 "20-50 km" 3 "Über 50 km"
label values commute_group_av phcommav_lb
label var commute_group_av "Pendelmobilität u.d.W. zwischen den Phasen"
tab commute_group_av 


*~~~~~~~~~~~~~~~~ WE-Pendelmobilität
// Gruppe 1
gen WE_commute_prom_g1=.
replace WE_commute_prom_g1 = prommobkmwe_3kat if phase==1
sum WE_commute_prom_g1
// Gruppe 2
gen WE_commute_pdoc_g2=.
replace WE_commute_pdoc_g2 = pdocmobkmwe_3kat if phase==2
sum WE_commute_pdoc_g2
// Gruppe 3
gen WE_commute_prof_g3=.
replace WE_commute_prof_g3 = profmobkmwe_3kat if phase==3
sum WE_commute_prof_g3

// Generate UV
gen WE_commute_allgroup_uv=.
replace WE_commute_allgroup_uv=1 if WE_commute_prom_g1>=1 & WE_commute_prom_g1<=3
replace WE_commute_allgroup_uv=2 if WE_commute_pdoc_g2>=1 & WE_commute_pdoc_g2<=3
replace WE_commute_allgroup_uv=3 if WE_commute_prof_g3>=1 & WE_commute_prof_g3<=3
label values WE_commute_allgroup_uv phcomm_lb
label var WE_commute_allgroup_uv "WE-Pendelmobilität zwischen den Phasen"
tab WE_commute_allgroup_uv, mi

// Generate AV
gen WE_commute_group_av=.
replace WE_commute_group_av=WE_commute_prom_g1 if WE_commute_allgroup_uv==1
replace WE_commute_group_av=WE_commute_pdoc_g2 if WE_commute_allgroup_uv==2
replace WE_commute_group_av=WE_commute_prof_g3 if WE_commute_allgroup_uv==3
label define we_comm_lb 1 "Unter 100 km" 2 "100-250 km" 3 "Über 250 km"
label values WE_commute_group_av we_comm_lb
label var WE_commute_group_av "WE-Pendelmobilität zwischen den Phasen"
tab WE_commute_group_av 


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~  Spearmans rho WE-pendeln (ja, nein) und Phase

// I2: 1B_Mobi_Signifikanztests_RM_3, Zeile 74-76
// Für ordinalen Test (Wochenendpendeln und Phase)
gen WePndl_g1=.
replace WePndl_g1 = promowepenjn if phase==1
// Gruppe 2
gen WePndl_g2=.
replace WePndl_g2 = pdocwepenjn if phase==2
// Gruppe 3
gen WePndl_g3=.
replace WePndl_g3 = profwepenjn if phase==3

// Generate UV
gen WePndl_uv=.
replace WePndl_uv=1 if WePndl_g1>=1 & WePndl_g1<=2
replace WePndl_uv=2 if WePndl_g2>=1 & WePndl_g2<=2
replace WePndl_uv=3 if WePndl_g3>=1 & WePndl_g3<=2
label values WePndl_uv umzge_lb
label var WePndl_uv "WE-Pendeln (Phase)"
tab WePndl_uv, mi

// Generate AV
gen WePndl_av=.
replace WePndl_av = WePndl_g1 if WePndl_uv==1
replace WePndl_av = WePndl_g2 if WePndl_uv==2
replace WePndl_av = WePndl_g3 if WePndl_uv==3
label define WePndl_lb 1 "Ja" 2 "Nein" 
label values WePndl_av WePndl_lb
label var WePndl_av "We-Pendelmobilität (1=Nein, 2=ja)"
tab WePndl_av 
recode WePndl_av (2 = 1 "Nein") (1 = 2 "Ja"), gen(WePndl_av_rec)
tab WePndl_av_rec 

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Umzugsmobilität
// Gruppe 1
gen Umzug_prom_g1=.
replace Umzug_prom_g1 = umzüge_prom_prompha if phase==1
sum Umzug_prom_g1
// Gruppe 2
gen Umzug_pdoc_g2=.
replace Umzug_pdoc_g2 = umzüge_pdoc_pdocpha if phase==2
sum Umzug_pdoc_g2
// Gruppe 3
gen Umzug_prof_g3=.
replace Umzug_prof_g3 = umzüge_prof_profpha if phase==3
sum Umzug_prof_g3

// Generate UV
gen Umzug_allgroup_uv=.
replace Umzug_allgroup_uv=1 if Umzug_prom_g1>=0 & Umzug_prom_g1<=2
replace Umzug_allgroup_uv=2 if Umzug_pdoc_g2>=0 & Umzug_pdoc_g2<=2
replace Umzug_allgroup_uv=3 if Umzug_prof_g3>=0 & Umzug_prof_g3<=2
label define umzge_lb 1 "Promovierende" 2 "Postdocs" 3 "Profs"
label values Umzug_allgroup_uv umzge_lb
label var Umzug_allgroup_uv "Vergleich Umzugsmobilität zwischen den Phasen"
tab Umzug_allgroup_uv, mi

// Generate AV
gen Umzug_group_av=.
replace Umzug_group_av = Umzug_prom_g1 if Umzug_allgroup_uv==1
replace Umzug_group_av = Umzug_pdoc_g2 if Umzug_allgroup_uv==2
replace Umzug_group_av = Umzug_prof_g3 if Umzug_allgroup_uv==3
label define Umzge_lb 0 "Keine Umzüge" 1 "1 Umzug" 2 "2 Umzüge und mehr"
label values Umzug_group_av Umzge_lb
label var Umzug_group_av "Umzugsmobilität zwischen den Phasen"
tab Umzug_group_av 
recode Umzug_group_av (0=1 "Keine Umzüge") (1=2 "1 Umzug") (2=3 "2 Umzüge und mehr"), gen(Umzug_group_av_rec)
tab Umzug_group_av_rec

             *************************************************************************************
    ********************************* Auslandsmobilität je Phase unterteilt *******************************
             *************************************************************************************

// Auslandsaufenthalte von mehr als 3 Monaten 
// Recodierung der Variablen für Spearmans rho (Hohe Werte sprechen für hohe Auslandsmobilität = bessere Interpretation) 
recode s_promoaufenth_SQ006 (5=1 "Nie") (4=2 "Selten") (3=3 "manchmal") (2=4 "häufig") (1=5 "Sehr häufig") if phase==1, gen(s_promoaufenth_SQ006_r) 
recode s_pdocaufenth_SQ006 (5=1 "Nie") (4=2 "Selten") (3=3 "manchmal") (2=4 "häufig") (1=5 "Sehr häufig") if phase==2, gen(s_pdocaufenth_SQ006_r) 
recode s_profaufenth_SQ006 (5=1 "Nie") (4=2 "Selten") (3=3 "manchmal") (2=4 "häufig") (1=5 "Sehr häufig"), gen(s_profaufenth_SQ006_r) 

// Kurzaufenthalte im nicht-deutschsprachigen Ausland
// Recodierung der Variablen für Spearmans rho (Hohe Werte sprechen für hohe Auslandsmobilität)
recode s_promoaufenth_SQ004 (5=1 "Nie") (4=2 "Selten") (3=3 "manchmal") (2=4 "häufig") (1=5 "Sehr häufig") if phase==1, gen(s_promoaufenth_SQ004_r) 
recode s_pdocaufenth_SQ004 (5=1 "Nie") (4=2 "Selten") (3=3 "manchmal") (2=4 "häufig") (1=5 "Sehr häufig") if phase==2, gen(s_pdocaufenth_SQ004_r) 
recode s_profaufenth_SQ004 (5=1 "Nie") (4=2 "Selten") (3=3 "manchmal") (2=4 "häufig") (1=5 "Sehr häufig"), gen(s_profaufenth_SQ004_r) 

// Aufenthalte 1-3 Monate im nicht-deutschsprachigen Ausland
// Recodierung der Variablen für Spearmans rho (Hohe Werte sprechen für hohe Auslandsmobilität)
recode s_promoaufenth_SQ005 (5=1 "Nie") (4=2 "Selten") (3=3 "manchmal") (2=4 "häufig") (1=5 "Sehr häufig") if phase==1, gen(s_promoaufenth_SQ005_r) 
recode s_pdocaufenth_SQ005 (5=1 "Nie") (4=2 "Selten") (3=3 "manchmal") (2=4 "häufig") (1=5 "Sehr häufig") if phase==2, gen(s_pdocaufenth_SQ005_r) 
recode s_profaufenth_SQ005 (5=1 "Nie") (4=2 "Selten") (3=3 "manchmal") (2=4 "häufig") (1=5 "Sehr häufig"), gen(s_profaufenth_SQ005_r) 


		 *************************************************************************************
  ************  Auslandsaufenthalte mehr als 3 Monaten im nicht-deutschsprachigen Ausland  ********************
		*************************************************************************************
		
// I1: "tab ausl_ALLgroup_av" auf Phase beschränken um Informationen zu univariaten Häufigkeitsverteilung zu erhalten 
// I3: 2_RM (Analysen mit Phase und Fach), Tabelle 83R: Mobilität ins nicht-deutschsprachige Ausland differenziert nach Dauer 
// und Karrierephase (in %)) --> Seite 9

// Gruppe 1
gen auslprom_g1=.
replace auslprom_g1 = s_promoaufenth_SQ006_r
// Gruppe 2
gen auslpdoc_g2=.
replace auslpdoc_g2 = s_pdocaufenth_SQ006_r
// Gruppe 3
gen auslprof_g2=.
replace auslprof_g2 = s_profaufenth_SQ006_r

// Generate UV
gen ausl_ALLgroup_uv=.
replace ausl_ALLgroup_uv=1 if auslprom_g1>=1 & auslprom_g1<=5
replace ausl_ALLgroup_uv=2 if auslpdoc_g2>=1 & auslpdoc_g2<=5
replace ausl_ALLgroup_uv=3 if auslprof_g2>=1 & auslprof_g2<=5
label values ausl_ALLgroup_uv phcomm_lb
label var ausl_ALLgroup_uv "Auslandsmobilität Phase"
tab ausl_ALLgroup_uv

// Generate AV
gen ausl_ALLgroup_av=.
replace ausl_ALLgroup_av=auslprom_g1 if ausl_ALLgroup_uv==1
replace ausl_ALLgroup_av=auslpdoc_g2 if ausl_ALLgroup_uv==2
replace ausl_ALLgroup_av=auslprof_g2 if ausl_ALLgroup_uv==3
label define ausl_allgr_lb 1 "Nie" 2 "Selten" 3 "Manchmale" 4 "Häufig" 5 "Sehr häufig"
label values ausl_ALLgroup_av ausl_allgr_lb
label var ausl_ALLgroup_av "Häufigkeit der Auslandsmobilität nach Phase"
tab ausl_ALLgroup_av if phase==2


		 ****************************************************************************
      ************  Kurzaufenthalte im nicht-deutschsprachigen Ausland  ********************
		*****************************************************************************

// I3: 2_RM (Analysen mit Phase und Fach), Tabelle 83R: Mobilität ins nicht-deutschsprachige Ausland differenziert nach Dauer 
// und Karrierephase (in %)) --> Seite 9

// Gruppe 1
gen auslpromkurz_g1=.
replace auslpromkurz_g1 = s_promoaufenth_SQ004_r
// Gruppe 2
gen auslpdockurz_g2=.
replace auslpdockurz_g2 = s_pdocaufenth_SQ004_r
// Gruppe 3
gen auslprofkurz_g2=.
replace auslprofkurz_g2 = s_profaufenth_SQ004_r

// Generate UV
gen ausl_ALLgroupkurz_uv=.
replace ausl_ALLgroupkurz_uv=1 if auslpromkurz_g1>=1 & auslpromkurz_g1<=5
replace ausl_ALLgroupkurz_uv=2 if auslpdockurz_g2>=1 & auslpdockurz_g2<=5
replace ausl_ALLgroupkurz_uv=3 if auslprofkurz_g2>=1 & auslprofkurz_g2<=5
label values ausl_ALLgroupkurz_uv phcomm_lb
label var ausl_ALLgroupkurz_uv "Auslandsmobilität (kurzaufenthalte) Phase"
tab ausl_ALLgroupkurz_uv

// Generate AV
gen ausl_ALLgroupkurz_av=.
replace ausl_ALLgroupkurz_av=auslpromkurz_g1 if ausl_ALLgroupkurz_uv==1
replace ausl_ALLgroupkurz_av=auslpdockurz_g2 if ausl_ALLgroupkurz_uv==2
replace ausl_ALLgroupkurz_av=auslprofkurz_g2 if ausl_ALLgroupkurz_uv==3
label values ausl_ALLgroupkurz_av ausl_allgr_lb
label var ausl_ALLgroupkurz_av "Häufigkeit der Auslandsmobilität nach Phase"
tab ausl_ALLgroupkurz_av if phase==2 // Auf Phase beschränken Informationen zu univariaten Häufigkeitsverteilung zu erhalten 


		 ****************************************************************************
      ************  1-3 Monate Aufenthalt nicht-deutschsprachigen Ausland  *****************
		*****************************************************************************

// I3: 2_RM (Analysen mit Phase und Fach), Tabelle 83R: Mobilität ins nicht-deutschsprachige Ausland differenziert nach Dauer 
// und Karrierephase (in %)) --> Seite 9

// Gruppe 1
gen auslprom1_3m_g1=.
replace auslprom1_3m_g1 = s_promoaufenth_SQ005_r
// Gruppe 2
gen auslpdoc1_3m_g2=.
replace auslpdoc1_3m_g2 = s_pdocaufenth_SQ005_r
// Gruppe 3
gen auslprof1_3m_g3=.
replace auslprof1_3m_g3 = s_profaufenth_SQ005_r

// Generate UV
gen ausl_ALLgroup1_3m_uv=.
replace ausl_ALLgroup1_3m_uv=1 if auslprom1_3m_g1>=1 & auslprom1_3m_g1<=5
replace ausl_ALLgroup1_3m_uv=2 if auslpdoc1_3m_g2>=1 & auslpdoc1_3m_g2<=5
replace ausl_ALLgroup1_3m_uv=3 if auslprof1_3m_g3>=1 & auslprof1_3m_g3<=5
label values ausl_ALLgroup1_3m_uv phcomm_lb
label var ausl_ALLgroup1_3m_uv "Auslandsmobilität (1-3 Monate) Phase"
tab ausl_ALLgroup1_3m_uv


// Generate AV
gen ausl_ALLgroup1_3m_av=.
replace ausl_ALLgroup1_3m_av=auslprom1_3m_g1 if ausl_ALLgroup1_3m_uv==1
replace ausl_ALLgroup1_3m_av=auslpdoc1_3m_g2 if ausl_ALLgroup1_3m_uv==2
replace ausl_ALLgroup1_3m_av=auslprof1_3m_g3 if ausl_ALLgroup1_3m_uv==3
label values ausl_ALLgroup1_3m_av ausl_allgr_lb
label var ausl_ALLgroup1_3m_av "Häufigkeit der Auslandsmobilität nach Phase"
tab ausl_ALLgroup1_3m_av if phase==3


// I1: Kurzaufenthalte im (nicht-)europäischen Ausland
// I2: Code für die Ergebnisse in 1B_Mobi_Signifikanztests_RM_3, Zeile 53-66
// Gruppe 1
gen nieurauslKurz_G1 =.
replace nieurauslKurz_G1 = niauslkurzprom if phase==1
// Gruppe 2
gen nieurauslKurz_G2 =.
replace nieurauslKurz_G2 = niauslkurzpdoc if phase==2
// Gruppe 3
gen nieurauslKurz_G3 =.
replace nieurauslKurz_G3 = niauslkurzprof if phase==3

// Generate UV
gen all_auslkurz_uv=.
replace all_auslkurz_uv=1 if nieurauslKurz_G1==1 | nieurauslKurz_G1==2
replace all_auslkurz_uv=2 if nieurauslKurz_G2==1 | nieurauslKurz_G2==2
replace all_auslkurz_uv=3 if nieurauslKurz_G3==1 | nieurauslKurz_G3==2
label define allGausl_lb 1 "Gruppe_1: Promovierende" 2 "Gruppe_2: Postdocs" 3 "Gruppe_3: Profs"
label values all_auslkurz_uv allGausl_lb
label var all_auslkurz_uv "Kurzaufenthalte nach Phasen (manchmal, (sehr) häufig))"  
tab all_auslkurz_uv
// Generate AV
gen allauslKurz_av=.
replace allauslKurz_av=nieurauslKurz_G1 if nieurauslKurz_G1==1 | nieurauslKurz_G1==2
replace allauslKurz_av=nieurauslKurz_G2 if nieurauslKurz_G2==1 | nieurauslKurz_G2==2
replace allauslKurz_av=nieurauslKurz_G3 if nieurauslKurz_G3==1 | nieurauslKurz_G3==2
tab allauslKurz_av 

// Aufenthalte 1-3 Monate im nicht-deutschsprachigen Ausland
// Gruppe 1
gen nieurausl1_3Mon_G1 =.
replace nieurausl1_3Mon_G1 = niausl1bis3prom if phase==1
// Gruppe 2
gen nieurausl1_3Mon_G2 =.
replace nieurausl1_3Mon_G2 = niausl1bis3pdoc if phase==2
// Gruppe 3
gen nieurausl1_3Mon_G3 =.
replace nieurausl1_3Mon_G3 = niausl1bis3prof if phase==3

// Generate UV
gen all_ausl1_3Mon_uv=.
replace all_ausl1_3Mon_uv=1 if nieurausl1_3Mon_G1==1 | nieurausl1_3Mon_G1==2
replace all_ausl1_3Mon_uv=2 if nieurausl1_3Mon_G2==1 | nieurausl1_3Mon_G2==2
replace all_ausl1_3Mon_uv=3 if nieurausl1_3Mon_G3==1 | nieurausl1_3Mon_G3==2
label values all_ausl1_3Mon_uv allGausl_lb
label var all_ausl1_3Mon_uv "Aufenthalte 1-3 Monate nach Phasen (manchmal, (sehr) häufig))"  
tab all_ausl1_3Mon_uv
// Generate AV
gen allausl1_3Mon_av=.
replace allausl1_3Mon_av=nieurausl1_3Mon_G1 if nieurausl1_3Mon_G1==1 | nieurausl1_3Mon_G1==2
replace allausl1_3Mon_av=nieurausl1_3Mon_G2 if nieurausl1_3Mon_G2==1 | nieurausl1_3Mon_G2==2
replace allausl1_3Mon_av=nieurausl1_3Mon_G3 if nieurausl1_3Mon_G3==1 | nieurausl1_3Mon_G3==2
tab allausl1_3Mon_av if phase==3

// Aufenthalte >3 Monate im nicht-deutschsprachigen Ausland

// Gruppe 1
gen nieurausl3Mon_G1 =.
replace nieurausl3Mon_G1 = niausl3prom if phase==1
// Gruppe 2
gen nieurausl3Mon_G2 =.
replace nieurausl3Mon_G2 = niausl3pdoc if phase==2
// Gruppe 3
gen nieurausl3Mon_G3 =.
replace nieurausl3Mon_G3 = niausl3prof if phase==3
// Generate UV
gen all_ausl3Mon_uv=.
replace all_ausl3Mon_uv=1 if nieurausl3Mon_G1==1 | nieurausl3Mon_G1==2
replace all_ausl3Mon_uv=2 if nieurausl3Mon_G2==1 | nieurausl3Mon_G2==2
replace all_ausl3Mon_uv=3 if nieurausl3Mon_G3==1 | nieurausl3Mon_G3==2
label values all_ausl3Mon_uv allGausl_lb
label var all_ausl3Mon_uv "Aufenthalte >3 Monate nach Phasen (manchmal, (sehr) häufig))"  
tab all_ausl3Mon_uv
// Generate AV
gen allausl3Mon_av=.
replace allausl3Mon_av=nieurausl3Mon_G1 if nieurausl3Mon_G1==1 | nieurausl3Mon_G1==2
replace allausl3Mon_av=nieurausl3Mon_G2 if nieurausl3Mon_G2==1 | nieurausl3Mon_G2==2
replace allausl3Mon_av=nieurausl3Mon_G3 if nieurausl3Mon_G3==1 | nieurausl3Mon_G3==2

                        ********************************************************************
                  ********************* (Einstellungen) Relevanz von Auslandsaufenthalten *******************
                       **********************************************************************

// I1: Beurteilung Forschungsaufenthalte nach Relevanz von 3monat. Aufenthalten im europäischen "aufentrelev" und nicht-euorpäische Ausland 
// "aufentrelev_nieurop" verknüpft 
// I3: 3_RM (Analysen mit Einstellungen, Tab 65/66R: Beurteilung der Relevanz von 3monatigen Auslandsaufenthalten im (nicht)-europäischen 
// Ausland nach Phase) --> Seite 10

// Beurteilung der Relevanz von Auslandsaufenthalten (3 Monate im nicht-europäischen Ausland)
encode aufentrelev_SQ006, gen(aufentrelev_nieurop)
recode       aufentrelev_nieurop (1 = .)
recode       aufentrelev_nieurop (2 = 1)
recode       aufentrelev_nieurop (3 = 2)
recode       aufentrelev_nieurop (4 = 3)
recode       aufentrelev_nieurop (5 = 4)
recode       aufentrelev_nieurop (6 = 5)
// Beurteilung der Relevanz von Auslandsaufenthalten (3 Monate im europäischen ausland)
encode aufentrelev_SQ005, gen(aufentrelev)
recode       aufentrelev (1 = .)
recode       aufentrelev (2 = 1)
recode       aufentrelev (3 = 2)
recode       aufentrelev (4 = 3)
recode       aufentrelev (5 = 4)
recode       aufentrelev (6 = 5)

gen relevausl_3=.
replace relevausl_3=1 if (aufentrelev>=1 & aufentrelev<=2) | (aufentrelev_nieurop>=1 & aufentrelev_nieurop<=2)
replace relevausl_3=2 if aufentrelev==3 | aufentrelev_nieurop==3
replace relevausl_3=3 if (aufentrelev>=4 & aufentrelev<=5) | (aufentrelev_nieurop>=4 & aufentrelev_nieurop<=5)
label define relausl_lb 1 "Sehr wichtig/wichtig" 2 "Teils/Teils" 3 "Unwichtig/Sehr Unwichtig" 
label values relevausl_3 relausl_lb
label var relevausl_3 "Beurteilung der Relevanz von Auslandsaufenthalten (3 Monate im (nicht)-europäischen ausland)"
tab relevausl_3 if phase==3

// Beurteilung der Relevanz von Auslandsaufenthalten (1-3 Monate im nicht-europäischen Ausland)
encode aufentrelev_SQ003, gen(aufentrelev_nieurop13)
recode       aufentrelev_nieurop13 (1 = .)
recode       aufentrelev_nieurop13 (2 = 1)
recode       aufentrelev_nieurop13 (3 = 2)
recode       aufentrelev_nieurop13 (4 = 3)
recode       aufentrelev_nieurop13 (5 = 4)
recode       aufentrelev_nieurop13 (6 = 5)
// Beurteilung der Relevanz von Auslandsaufenthalten (1-3 Monate im europäischen Ausland)
encode aufentrelev_SQ002, gen(aufentrelev_europ13)
recode       aufentrelev_europ13 (1 = .)
recode       aufentrelev_europ13 (2 = 1)
recode       aufentrelev_europ13 (3 = 2)
recode       aufentrelev_europ13 (4 = 3)
recode       aufentrelev_europ13 (5 = 4)
recode       aufentrelev_europ13 (6 = 5)

gen relevausl_13=.
replace relevausl_13=1 if (aufentrelev_europ13>=1 & aufentrelev_europ13<=2) | (aufentrelev_nieurop13>=1 & aufentrelev_nieurop13<=2)
replace relevausl_13=2 if aufentrelev_europ13==3 | aufentrelev_nieurop==3
replace relevausl_13=3 if (aufentrelev_europ13>=4 & aufentrelev_europ13<=5) | (aufentrelev_nieurop13>=4 & aufentrelev_nieurop13<=5)
label values relevausl_13 relausl_lb
label var relevausl_13 "Beurteilung der Relevanz von Auslandsaufenthalten (1-3 Monate im (nicht)-europäischen ausland)"
tab relevausl_13 if phase==1

// I1: Bereitschaft zu räumlicher Mobilität (3 Monate und mehr Breitschaft zu Auslandsaufenthalten im (nicht)-europäischen Ausland)
// I3: 3_RM (Analysen mit Einstellungen, Tab 67R: Bereitschaft von 3monatigen Auslandsaufenthalten im (nicht)-europäischen Ausland nach Phase) --> S. 11
encode aufentausl_SQ005, gen(aufentausl)
recode       aufentausl (1 = .)
recode       aufentausl (2 = 1)
recode       aufentausl (3 = 2)
recode       aufentausl (4 = 3)
recode       aufentausl (5 = 4)
gen zkunftausl=.
replace zkunftausl=1 if aufentausl>=1 & aufentausl<=2
replace zkunftausl=2 if aufentausl>=3 & aufentausl<=4
label define zkunftausl_lb 1 "Ja/Eher Ja" 2 "Eher nein/Nein"
label values zkunftausl zkunftausl_lb
label var zkunftausl "Kommen Auslandsaufenthalte (3 Monate und mehr) im europäischen Ausland in den nächsten 5 Jahren in Frage?"
tab zkunftausl if phase==1



******************************************************************************************************
*************************** Räumliche und soziale Mobilität Aufbereitung für Sig.-Tests *************
******************************************************************************************************

// I1: Durchschnittliche Prestigebeurteilung der räumlich Mobilen nach Phase. 
// I2: 1B_Mobi_Signifikanztests_RM_3, Zeile 68-72

// Gruppe 1
gen prom_g1 =.
replace prom_g1 = total_mean_promprom if PromProm_mobil==1 // mit PromProm_mobil==1 auf die Mobilen (nach Index-variable) beschränkt
sum prom_g1
// Gruppe 2
gen pdoc_g2 =.
replace pdoc_g2 = total_mean_pdocpdoc if PdocPdoc_mobil==1 
sum pdoc_g2
// Gruppe 3
gen prof_g3 =.
replace prof_g3 = total_mean_profprof if ProfProf_mobil==1 
sum prof_g3

gen all_uv=.
replace all_uv=1 if prom_g1>=-2 & prom_g1<=2
replace all_uv=2 if pdoc_g2>=-2 & pdoc_g2<=2
replace all_uv=3 if prof_g3>=-2 & prof_g3<=2
label define allG_lb 1 "Gruppe_1: Promovierende" 2 "Gruppe_2: Postdocs" 3 "Gruppe_3: Profs"
label values all_uv allG_lb
label var all_uv "Durchschnittliche Prestigebewertung der Mobilen nach Phasen"  
tab all_uv
// Generate AV
gen all_av=.
replace all_av=prom_g1 if all_uv==1
replace all_av=pdoc_g2 if all_uv==2
replace all_av=prof_g3 if all_uv==3
tab all_av


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

************************************************************************************************************************
****************************** Anforderungen an räumliche Mobilität *********************************
************************************************************************************************************************

// I1: Anforderungen an räumliche Mobilität 
// I3: 3_RM (Analysen mit Einstellungen, Tab. 40R: Bewertung der Anforderungen von räumlicher Mobilität in verschiedenen Karrierephasen (in %) --> Seite 2

//Promovierende
gen anford_promo=.
replace anford_promo=1 if promoanfmgl>=1 & promoanfmgl<=2
replace anford_promo=2 if promoanfmgl>=3 & promoanfmgl<=4
label define anf_promo_lb 1 " Anforderung/Eher Anforderung" 2 "Eher Möglichkeit/Möglichkeit"
label values anford_promo anf_promo_lb
label var anford_promo "Räumliche Mobilität Anforderung oder Möglichkeit"
tab anford_promo if phase==1

// Postdocs
gen anford_pdoc=.
replace anford_pdoc=1 if pdocanfmgl>=1 & pdocanfmgl<=2 
replace anford_pdoc=2 if pdocanfmgl>=3 & pdocanfmgl<=4
label values anford_pdoc anf_promo_lb
label var anford_pdoc "Räumliche Mobilität Anforderung oder Möglichkeit"
tab anford_pdoc if phase==2

// Professur
gen anford_prof=.
replace anford_prof=1 if profanfmgl>=1 & profanfmgl<=2 
replace anford_prof=2 if profanfmgl>=3 & profanfmgl<=4 
label values anford_prof anf_promo_lb
label var anford_prof "Räumliche Mobilität Anforderung oder Möglichkeit"
tab anford_prof 

// Phasenübergreifend (profs/Promo-Phase)
gen anford_profprom=.
replace anford_profprom=1 if promoanfmgl>=1 & promoanfmgl<=2 & phase==3
replace anford_profprom=2 if promoanfmgl>=3 & promoanfmgl<=4 & phase==3
label values anford_profprom anf_promo_lb
label var anford_profprom "Räumliche Mobilität Anforderung oder Möglichkeit"
tab anford_profprom 

// Phasenübergreifend (Postdocs/Promo-Phase)
gen anford_pdocprom=.
replace anford_pdocprom=1 if promoanfmgl>=1 & promoanfmgl<=2 & phase==2
replace anford_pdocprom=2 if promoanfmgl>=3 & promoanfmgl<=4 & phase==2
label values anford_pdocprom anf_promo_lb
label var anford_pdocprom "Räumliche Mobilität Anforderung oder Möglichkeit"
tab anford_pdocprom

// Phasenübergreifend (profs/Postdoc-Phase-Phase)
gen anford_profpdoc=.
replace anford_profpdoc=1 if pdocanfmgl>=1 & pdocanfmgl<=2 & phase==3
replace anford_profpdoc=2 if pdocanfmgl>=3 & pdocanfmgl<=4 & phase==3
label values anford_profpdoc anf_promo_lb
label var anford_profpdoc "Räumliche Mobilität Anforderung oder Möglichkeit"
tab anford_profpdoc 


// I1: Bedeutung Prof 3 Ausprägungen der (Promovierende/Promotionsphase)
// I3: 3_RM (Analysen mit Einstellungen, Tab 45R: Bedeutung der Professur nach Phase) --> Seite 3
gen btprof_promo=.
replace btprof_promo=1 if relwisskar1>=1 & relwisskar1<=2 
replace btprof_promo=2 if relwisskar1==3
replace btprof_promo=3 if relwisskar1>=4 & relwisskar1<=5
label define btprof_lb 1 "Sehr wichtig/wichtig" 2 "Unentschieden" 3 "Unwichtig/Sehr unwichtig"
label values btprof_promo btprof_lb
label var btprof_promo "Bedeutung Professur (3 Kategorien)"
tab btprof_promo if phase==1

// Bedeutung Prof 3 Ausprägungen der (Postdocs/Postdoc-Phase)
gen btprof_pdoc=.
replace btprof_pdoc=1 if relwisskar1>=1 & relwisskar1<=2 
replace btprof_pdoc=2 if relwisskar1==3
replace btprof_pdoc=3 if relwisskar1>=4 & relwisskar1<=5
label values btprof_pdoc btprof_lb
label var btprof_pdoc "Bedeutung Professur (3 Kategorien)"
tab btprof_pdoc if phase==2


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Anforderungen nach Phase (Für Signifikanztests)

// I2: 1B_Mobi_Signifikanztests_RM_3, Zeile 78-81
// Gruppe 1
gen prom_g1_AM =.
replace prom_g1_AM = promoanfmgl if phase==1

// Gruppe 2
gen pdoc_g2_AM =.
replace pdoc_g2_AM = pdocanfmgl if phase==2

// Gruppe 3
gen prof_g3_AM =.
replace prof_g3_AM = profanfmgl 


gen all_AM_uv=.
replace all_AM_uv=1 if prom_g1_AM>=1 & prom_g1_AM<=4
replace all_AM_uv=2 if pdoc_g2_AM>=1 & pdoc_g2_AM<=4
replace all_AM_uv=3 if prof_g3_AM>=1 & prof_g3_AM<=4
label define allAM_lb 1 "Gruppe_1: Promovierende" 2 "Gruppe_2: Postdocs" 3 "Gruppe_3: Profs"
label values all_AM_uv allAM_lb
label var all_AM_uv "Anforderung oder Möglichkeit nach Phasen"  
tab all_AM_uv
// Generate AV
gen all_AM_av=.
replace all_AM_av=prom_g1_AM if all_AM_uv==1
replace all_AM_av=pdoc_g2_AM if all_AM_uv==2
replace all_AM_av=prof_g3_AM if all_AM_uv==3
label define ALLAM_lb 1 "Anforderung" 2 "Eher Anforderung" 3 "Eher Möglichkeit" 4 "Möglichkeit"
label values all_AM_av ALLAM_lb
label var all_AM_av "Anforderung oder Möglichkeit: 1 (Anforderung), 4 (Möglichkeit)"
tab all_AM_av

// Wie viele der Wochenendpendler leben alleine (Berechnung muss mit Dreisatz selbst vorgenommen werden)
gen we_pendpromo=.
replace we_pendpromo=1 if promowepenjn==1 & phase==1
tab we_pendpromo

gen we_pendpdoc=.
replace we_pendpdoc=1 if pdocwepenjn==1 & phase==2
tab we_pendpdoc

gen we_pendprof=.
replace we_pendprof=1 if profwepenjn==1 & phase==3
tab we_pendprof


// I1: Individueller Verlauf Bewertung Postdocs und Profs, A/eher A und M/eher M jeweils zusammengefasst 
// Postdocs: A-A, A-M, M-M, M-A
// I3: 3_RM (Analysen mit Einstellungen, Tab 41R: RM als Verlauft der Anforderung oder Möglichkeit (Postdocs)) --> Seite 2
gen verlauf_Anford_Pdoc=.
replace verlauf_Anford_Pdoc=1 if anford_pdocprom==1 & anford_pdoc==1 
replace verlauf_Anford_Pdoc=2 if anford_pdocprom==1 & anford_pdoc==2
replace verlauf_Anford_Pdoc=3 if anford_pdocprom==2 & anford_pdoc==1
replace verlauf_Anford_Pdoc=4 if anford_pdocprom==2 & anford_pdoc==2
label define anfmögpdoc_lb 1 "A-A" 2 " A-M" 3 "M-A" 4 "M-M"
label values verlauf_Anford_Pdoc anfmögpdoc_lb
label var verlauf_Anford_Pdoc "Räumliche Mobilität als Anforderung oder Möglichkeit im Verlauf der Phasen (Postdocs)"
tab verlauf_Anford_Pdoc 

// Profs
// Profs zunächst v.a. M-A-M, A-A-M, andere Verläufe)
gen verlauf_Anford_Prof=.
replace verlauf_Anford_Prof=1 if anford_profprom==1 & anford_profpdoc==1 & anford_prof==1
replace verlauf_Anford_Prof=2 if anford_profprom==1 & anford_profpdoc==1 & anford_prof==2 | ///
								 anford_profprom==1 & anford_profpdoc==2 & anford_prof==2
replace verlauf_Anford_Prof=3 if anford_profprom==2 & anford_profpdoc==1 & anford_prof==2 
replace verlauf_Anford_Prof=4 if anford_profprom==1 & anford_profpdoc==2 & anford_prof==1 
replace verlauf_Anford_Prof=5 if anford_profprom==2 & anford_profpdoc==1 & anford_prof==1 | ///
								 anford_profprom==2 & anford_profpdoc==2 & anford_prof==1
replace verlauf_Anford_Prof=6 if anford_profprom==2 & anford_profpdoc==2 & anford_prof==2								 
label define anfmögprof_lb 1 "A-A-A" 2 "A-A-M/A-M-M" 3 "M-A-M" 4 "A-M-A" 5 "M-A-A/M-M-A" 6 "M-M-M"
label values verlauf_Anford_Prof anfmögprof_lb
label var verlauf_Anford_Prof "Räumliche Mobilität als Anforderung oder Möglichkeit im Verlauf der Phasen (Profs)"
tab verlauf_Anford_Prof 

// (M-A-M, A-A-M)
gen verlauf_prof_test=.
replace verlauf_prof_test=1 if anford_profprom==2 & anford_profpdoc==1 & anford_prof==2
replace verlauf_prof_test=2 if anford_profprom==1 & anford_profpdoc==1 & anford_prof==2 
tab verlauf_prof_test


**********************************************************************************
************************* Auslandsmobilität mehr als 3 Monate ********************
**********************************************************************************

// Nicht-Phasenübergreifend (Recodierung Dummy-Variable)

recode niausl3prom (2=0) (1=1), gen(niausl3prom_r)
recode niausl3pdoc (2=0) (1=1), gen(niausl3pdoc_r)
recode niausl3prof (2=0) (1=1), gen(niausl3prof_r)

**********************************************************************************
************************* Auslandsmobilität Kurzaufenthalte ********************
**********************************************************************************

recode niauslkurzprom (2=0) (1=1), gen(niauslkurzprom_r)
recode niauslkurzpdoc (2=0) (1=1), gen(niauslkurzpdoc_r)
recode niauslkurzprof (2=0) (1=1), gen(niauslkurzprof_r)


// In welchem Maße ist wissenschaftlicher Karriereerfolg eigene Leistung?
*~~~~ Codierung (2x sehr wenig, 2 mal sehr stark, wenig/stark, stark/wenig)  

// I3: 3_RM (Analysen mit Einstellungen, Tab 61R: Kombi zur Einschätzung ob eigene Leistung oder äußere Faktoren relevant (Promovierende)) --> Seite 9

/// Promovierende
gen kombi_eflg_1=.
replace kombi_eflg_1=1 if (glkleist_SQ001>=1 & glkleist_SQ001<=2) & (glkleist_SQ002>=1 & glkleist_SQ002<=2) & phase==1
replace kombi_eflg_1=2 if (glkleist_SQ001>=1 & glkleist_SQ001<=2) & (glkleist_SQ002>=3 & glkleist_SQ002<=4) & phase==1
replace kombi_eflg_1=3 if (glkleist_SQ001>=3 & glkleist_SQ001<=4) & (glkleist_SQ002>=1 & glkleist_SQ002<=2) & phase==1
replace kombi_eflg_1=4 if (glkleist_SQ001>=3 & glkleist_SQ001<=4) & (glkleist_SQ002>=3 & glkleist_SQ002<=4) & phase==1
label define kombi_lb 1 "2x (sehr) wenig" 2 "Wenig/Stark" 3 "Stark/Wenig" 4 "2x (sehr) stark"
label values kombi_eflg_1 kombi_lb
label var kombi_eflg_1 "Kobminationen zur Einschätzung eigene Leistung oder äußere Faktoren (Promovierende)"
by diszi, sort: tab kombi_eflg_1

// Postdocs
*~~~~ Codierung (2x sehr wenig, 2 mal sehr stark, wenig/stark, stark/wenig) 
gen kombi_eflg_2=.
replace kombi_eflg_2=1 if (glkleist_SQ001>=1 & glkleist_SQ001<=2) & (glkleist_SQ002>=1 & glkleist_SQ002<=2) & phase==2
replace kombi_eflg_2=2 if (glkleist_SQ001>=1 & glkleist_SQ001<=2) & (glkleist_SQ002>=3 & glkleist_SQ002<=4) & phase==2
replace kombi_eflg_2=3 if (glkleist_SQ001>=3 & glkleist_SQ001<=4) & (glkleist_SQ002>=1 & glkleist_SQ002<=2) & phase==2
replace kombi_eflg_2=4 if (glkleist_SQ001>=3 & glkleist_SQ001<=4) & (glkleist_SQ002>=3 & glkleist_SQ002<=4) & phase==2
label values kombi_eflg_2 kombi_lb
label var kombi_eflg_2 "Kobminationen zur Einschätzung eigene Leistung oder äußere Faktoren (Postdocs)"
by diszi, sort: tab kombi_eflg_2


/// Profs
*~~~~ Codierung (2x sehr wenig, 2 mal sehr stark, wenig/stark, stark/wenig) 
gen kombi_eflg_3=.
replace kombi_eflg_3=1 if (glkleist_SQ001>=1 & glkleist_SQ001<=2) & (glkleist_SQ002>=1 & glkleist_SQ002<=2) & phase==3
replace kombi_eflg_3=2 if (glkleist_SQ001>=1 & glkleist_SQ001<=2) & (glkleist_SQ002>=3 & glkleist_SQ002<=4) & phase==3
replace kombi_eflg_3=3 if (glkleist_SQ001>=3 & glkleist_SQ001<=4) & (glkleist_SQ002>=1 & glkleist_SQ002<=2) & phase==3
replace kombi_eflg_3=4 if (glkleist_SQ001>=3 & glkleist_SQ001<=4) & (glkleist_SQ002>=3 & glkleist_SQ002<=4) & phase==3
label values kombi_eflg_3 kombi_lb
label var kombi_eflg_3 "Kobminationen zur Einschätzung eigene Leistung oder äußere Faktoren (Profs)"
by diszi, sort: tab kombi_eflg_3

		   
// Für eine lukrative Stelle ins Ausland umziehen
recode berkarr_SQ004 (1/2=1 "(Sehr) wahrscheinlich") (3=2 "Unschlüssig") (4/5=3 "(Sehr) unwahrscheinlich"), gen(lukra_europ)
recode berkarr_SQ005 (1/2=1 "(Sehr) wahrscheinlich") (3=2 "Unschlüssig") (4/5=3 "(Sehr) unwahrscheinlich"), gen(lukra_nieurop)
tab1 lukra_europ lukra_nieurop

// I3: 3_RM (Analysen mit Einstellungen, Tab 68R: Bereitschaft für eine lukrative Stelle ins (nicht)-europäische Ausland zu ziehen --> Seite 11
// Variable generieren: lkrastelausland (Verknüpfung nicht-europäisches Ausland und europäisches Ausland)
gen lkrastelausland=.
replace lkrastelausland=1 if lukra_europ==1 | lukra_nieurop==2
replace lkrastelausland=2 if lukra_europ==2 | lukra_nieurop==2
replace lkrastelausland=3 if lukra_europ==3 | lukra_nieurop==3
label define lkra_lb 1 "(Sehr) wahrscheinlich" 2 "Unschlüssig" 3 "(Sehr) unwahrscheinlich"
label values lkrastelausland lkra_lb
label var lkrastelausland "Wahrscheinlichkeit für eine lukrative Stelle ins Nicht-(europäische) Ausland zu ziehen"
tab lkrastelausland if phase==3
					   

// Einstellungen und Absichten zu räumlicher Mobilität 

// Gewünschte Entwicklung der Mobilität in den nächsten 5 Jahren (Recodierung)
recode gewpersp1 (1/2=1 "Mobiler werden") (3 = 2 "Nichts ändern") (4/5 = 3 "Weniger mobil") (6=4 "Unschlüssig"), gen(mobi5jahre)
tab mobi5jahre 

// In ein anderes Bundesland ziehen?
recode berkarr_SQ002 (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(anderes_bula)
label define anbul_lb 1 "Sehr unwahrscheinlich" 5 "Sehr wahrscheinlich"
label values anderes_bula anbul_lb
label var anderes_bula "Wie wahrscheinlich für neue Stelle in anderes Bundesland ziehen?"
tab anderes_bula



*************************************************************************************************************************
****************** Codierungen, die nicht für Analysen und Auswertungen verwendet wurden, da  ******************
*************************  sich im Laufe der Zeit im Rahmen der Meetings *********************************************
****************************************************************************************************************************

// Änderungen bzgl. der Operationalisierung ergeben haben


// Häufigkeit Mobilität unter der Woche >= 50 km (Häufigkeit Fernpendeln unter der Woche) --> Promotionsphase
/*gen prommobkm_ü50_N=.
replace prommobkm_ü50_N=0 if (prommobkm_u20<=2 | prommobkm_b50<=2) & phase==1 |  ///
	   (prommobkm_u20>=3 & prommobkm_u20<=5 & prommobkm_b50>=3 & prommobkm_b50<=5 & prommobkm_ü50>=4 & prommobkm_ü50<=5) & phase==1 
replace prommobkm_ü50_N=1 if prommobkm_ü50<=2 & phase==1 
label define PENDEL_lb 0 "Immobile" 1 "Mobile"
label values prommobkm_ü50_N PENDEL_lb
label var prommobkm_ü50_N "Pendelmobilität unter der Woche: Kurze versus lange Strecken (Promovierende/Promotionsphase)"
tab prommobkm_ü50_N
by diszi, sort: tab prommobkm_ü50_N
list id prommobkm_u20 prommobkm_b50 prommobkm_ü50 prommobkm_ü50_N phase if phase==1 & prommobkm_ü50_N!=. in 51/1600


Hilfsvariablen erstellen (Zirkuläre Mobilität)
egen prom_prom_help0 = anycount(prommobkm_ü50_N prommobkmwe_ü100_N), values(0) // Immobile
egen prom_prom_help1 = anycount(prommobkm_ü50_N prommobkmwe_ü100_N), values(1) // Mobile
gen Prom_prom_pen=.
replace Prom_prom_pen=0 if prom_prom_help0>=1 & prom_prom_help1==0 
replace Prom_prom_pen=1 if prom_prom_help1>=1 | prom_prom_help1>=prom_prom_help0 
replace Prom_prom_pen=. if prom_prom_help0==0 & prom_prom_help1==0
label define pendel_lb 0 "Immobile" 1 "Mobile"
label values Prom_prom_pen pendel_lb
label var Prom_prom_pen "Wochenend- und tägliches Fernpendeln (Promovierende/Promotionsphase)"
drop prom_prom_help0 prom_prom_help1

// Häufigkeit Mobilität unter der Woche >= 50 km (Häufigkeit Fernpendeln unter der Woche) --> Postdocphase
gen pdocmobkm_ü50_N=.
replace pdocmobkm_ü50_N=0 if (pdocmobkm_u20<=2 | pdocmobkm_b50<=2) & phase==2 | ///
		(pdocmobkm_u20>=3 & pdocmobkm_u20<=5 & pdocmobkm_b50>=3 & pdocmobkm_b50<=5 & pdocmobkm_ü50>=3 & pdocmobkm_ü50<=5) & phase==2 
replace pdocmobkm_ü50_N=1 if pdocmobkm_ü50<=2 & phase==2 
label values pdocmobkm_ü50_N PENDEL_lb
label var pdocmobkm_ü50_N "Pendelmobilität unter der Woche: Kurze versus lange Strecken (Postdoc-Phase)"
tab pdocmobkm_ü50_N if phase==2
list id pdocmobkm_u20 pdocmobkm_b50 pdocmobkm_ü50 pdocmobkm_ü50_N phase if (phase==2) in 51/250

gen pdocmobkmwe_3kat_N=.
replace pdocmobkmwe_3kat_N=1 if (pdocmobkmwe_u100>=1 & pdocmobkmwe_u100<=3) 
replace pdocmobkmwe_3kat_N=2 if (pdocmobkmwe_u250>=1 & pdocmobkmwe_u250<=3) 
replace pdocmobkmwe_3kat_N=3 if (pdocmobkmwe_u500>=1 & pdocmobkmwe_u500<=3) | (pdocmobkmwe_ü500>=1 & pdocmobkmwe_ü500<=3)
replace pdocmobkmwe_3kat_N=. if (pdocmobkmwe_u100>=4 & pdocmobkmwe_u100<=5) & (pdocmobkmwe_u250>=4 & pdocmobkmwe_u250<=5) & ///
							    (pdocmobkmwe_u500>=4 & pdocmobkmwe_u500<=5) & (pdocmobkmwe_ü500>=4 & pdocmobkmwe_ü500<=5) 
label values pdocmobkmwe_3kat_N promwekat3_lb
label var pdocmobkmwe_3kat_N "Pendelmobilität am Wochenende: Kurze versus lange Strecken (Promotionsphase)"
tab pdocmobkmwe_3kat_N if phase==2
by diszi, sort: tab pdocmobkmwe_3kat_N

// Hilfsvariablen erstellen
egen pdoc_pdoc_help0 = anycount(pdocmobkm_ü50_N pdocmobkmwe_ü100_N), values(0) // Immobile
egen pdoc_pdoc_help1 = anycount(pdocmobkm_ü50_N pdocmobkmwe_ü100_N), values(1) // Mobile

gen Pdoc_pdoc_pen=.
replace Pdoc_pdoc_pen=0 if pdoc_pdoc_help0>=1 & pdoc_pdoc_help1==0 
replace Pdoc_pdoc_pen=1 if pdoc_pdoc_help1>=1 | pdoc_pdoc_help1>=pdoc_pdoc_help0 
replace Pdoc_pdoc_pen=. if pdoc_pdoc_help0==0 & pdoc_pdoc_help1==0
label values Pdoc_pdoc_pen PENDEL_lb
label var Pdoc_pdoc_pen "Wochend- und Tägliches Fernpendeln (Postdocphase)"

drop pdoc_pdoc_help0 pdoc_pdoc_help1

// ---> Zirkuläre räumliche Mobilität

// Häufigkeit Mobilität unter der Woche >= 50 km (Häufigkeit Fernpendeln unter der Woche) --> Profphase
gen profmobkm_ü50_N=.
replace profmobkm_ü50_N=0 if (profmobkm_u20<=2 | profmobkm_b50<=2) & phase==3 | ///
		(profmobkm_u20>=3 & profmobkm_u20<=5 & profmobkm_b50>=3 & profmobkm_b50<=5 & profmobkm_ü50>=4 & profmobkm_ü50<=5) & phase==3
replace profmobkm_ü50_N=1 if profmobkm_ü50<=2 & phase==3
label values profmobkm_ü50_N PENDEL_lb
label var profmobkm_ü50_N "Pendelmobilität unter der Woche: Kurze versus lange Strecken (Prof-Phase)"
list id profmobkm_u20 profmobkm_b50 profmobkm_ü50 profmobkm_ü50_N phase if (phase==3) in 1/1000

// Hilfsvariablen erstellen
egen prof_prof_help0 = anycount(profmobkm_ü50_N profmobkmwe_ü100_N), values(0) // Immobile
egen prof_prof_help1 = anycount(profmobkm_ü50_N profmobkmwe_ü100_N), values(1) // Mobile

gen Prof_prof_pen=.
replace Prof_prof_pen=0 if prof_prof_help0>=1 & prof_prof_help1==0 
replace Prof_prof_pen=1 if prof_prof_help1>=1 | prof_prof_help1>=prof_prof_help0 
replace Prof_prof_pen=. if prof_prof_help0==0 & prof_prof_help1==0
label values Prof_prof_pen PENDEL_lb
label var Prof_prof_pen "Unterteilung in 0=Immobile und 1=Mobile (Professorenphase)"
list profmobkm_ü50_N profmobkmwe_ü100_N prof_prof_help0 prof_prof_help1 Prof_prof_pen if phase==3 in 1/1000
prof_prof_help0 prof_prof_help1 

// ---> Zirkuläre räumliche Mobilität 

// Pendeln unter der Woche (Tägliches Fernpendeln)

// Profs in Promotionsphase
gen prof_prommobkm_ü50_N=.
replace prof_prommobkm_ü50_N=0 if (prommobkm_u20<=2 | prommobkm_b50<=2) & phase==3 | ///
		(prommobkm_u20>=3 & prommobkm_u20<=5 & prommobkm_b50>=3 & prommobkm_b50<=5 & prommobkm_ü50>=3 & prommobkm_ü50<=5) & phase==3
replace prof_prommobkm_ü50_N=1 if prommobkm_ü50<=2 & phase==3
label values prof_prommobkm_ü50_N PENDEL_lb
label var prof_prommobkm_ü50_N "Pendelmobilität von mehr als 50km unter der Woche (Profs/Promotionsphase)"
tab prof_prommobkm_ü50_N

// Profs in Postdocphase
gen prof_pdocmobkm_ü50_N=.
replace prof_pdocmobkm_ü50_N=0 if (pdocmobkm_u20<=2 | pdocmobkm_b50<=2) & phase==3 | ///
		(pdocmobkm_u20>=3 & pdocmobkm_u20<=5 & pdocmobkm_b50>=3 & pdocmobkm_b50<=5 & pdocmobkm_ü50>=3 & pdocmobkm_ü50<=5) & phase==3
replace prof_pdocmobkm_ü50_N=1 if pdocmobkm_ü50<=2 & phase==3
label values prof_pdocmobkm_ü50_N PENDEL_lb
label var prof_pdocmobkm_ü50_N "Pendelmobilität von mehr als 50km unter der Woche (Profs/Postdocphase)"
tab prof_pdocmobkm_ü50_N

// Postdocs in Promotionsphase
gen pdoc_prommobkm_ü50_N=.
replace pdoc_prommobkm_ü50_N=0 if (prommobkm_u20<=2 | prommobkm_b50<=2) & phase==2 | ///
		(prommobkm_u20>=3 & prommobkm_u20<=5 & prommobkm_b50>=3 & prommobkm_b50<=5 & prommobkm_ü50>=3 & prommobkm_ü50<=5) & phase==2
replace pdoc_prommobkm_ü50_N=1 if prommobkm_ü50<=2 & phase==2
label values pdoc_prommobkm_ü50_N PENDEL_lb
label var pdoc_prommobkm_ü50_N "Pendelmobilität von mehr als 50km unter der Woche (Profs/Promotionsphase)"
list id prommobkm_u20 prommobkm_b50 prommobkm_ü50 pdoc_prommobkm_ü50_N if phase==2 & pdoc_prommobkm_ü50_N != . in 51/500

// Hilfsvariablen erstellen für Verlaufsvariablen (Profs/Promotionsphase) --> Pendelmobilität (WE-Pendelmobilität und 
// Unter der Woche-Pendelmobilität zusammen)

// RM der Profs während Promotionsphase
egen prof_prom_help0 = anycount(prof_prommobkm_ü50_N prof_prommobkmwe_ü100_N), values(0) // Immobile
egen prof_prom_help1 = anycount(prof_prommobkm_ü50_N prof_prommobkmwe_ü100_N), values(1) // Mobile

gen Prof_prom_pen=.  
replace Prof_prom_pen=0 if prof_prom_help0>=1 & prof_prom_help1==0 
replace Prof_prom_pen=1 if prof_prom_help1>=1 | prof_prom_help1>=prof_prom_help0 
replace Prof_prom_pen=. if prof_prom_help0==0 & prof_prom_help1==0
label values Prof_prom_pen PENDEL_lb
label var Prof_prom_pen "Zirkuläre Mobilität P.u.W & WE-Pendeln (Promotionsphase/Professoren)"
 
drop prof_prom_help0 prof_prom_help1

// RM der Profs während Postdocphase
egen prof_pdoc_help0 = anycount(prof_pdocmobkm_ü50_N prof_pdocmobkmwe_ü100_N), values(0) // Immobile
egen prof_pdoc_help1 = anycount(prof_pdocmobkm_ü50_N prof_pdocmobkmwe_ü100_N), values(1) // Mobile

gen Prof_pdoc_pen=.  
replace Prof_pdoc_pen=0 if prof_pdoc_help0>=1 & prof_pdoc_help1==0 
replace Prof_pdoc_pen=1 if prof_pdoc_help1>=1 | prof_pdoc_help1>=prof_pdoc_help0 
replace Prof_pdoc_pen=. if prof_pdoc_help0==0 & prof_pdoc_help1==0
label values Prof_pdoc_pen PENDEL_lb
label var Prof_pdoc_pen "Zirkuläre Mobilität P.u.W & WE-Pendeln (Postdocphase/Professoren)"

drop prof_pdoc_help0 prof_pdoc_help1


// RM der Pdocs während Promotionsphase
egen pdoc_prom_help0 = anycount(pdoc_prommobkm_ü50_N pdoc_prommobkmwe_ü100_N), values(0) // Immobile
egen pdoc_prom_help1 = anycount(pdoc_prommobkm_ü50_N pdoc_prommobkmwe_ü100_N), values(1) // Mobile

gen Pdoc_prom_pen=.  
replace Pdoc_prom_pen=0 if pdoc_prom_help0>=1 & pdoc_prom_help1==0 
replace Pdoc_prom_pen=1 if pdoc_prom_help1>=1 | pdoc_prom_help1>=pdoc_prom_help0 
replace Pdoc_prom_pen=. if pdoc_prom_help0==0 & pdoc_prom_help1==0
label values Pdoc_prom_pen PENDEL_lb
label var Pdoc_prom_pen "Zirkuläre Mobilität P.u.W & WE-Pendeln (Promotionsphase/Postdocs)"

drop pdoc_prom_help0 pdoc_prom_help1

Index-Variable
// 1=Weder Fern- noch WE-Pendeln pro Phase, 2=Nur eins davon pro Phase, 3=Beides je Phase
// Promovenden/Promotionsphase
gen index_11=.
replace index_11=1 if prommobkm_ü50_N==0 & prommobkmwe_ü100_N==0 // UdW.<50km (häufig, sehr häufig) + am WE<100km (manchmal, häufig, sehr häufig)
replace index_11=2 if prommobkm_ü50_N==1 | prommobkmwe_ü100_N==1 
replace index_11=3 if prommobkm_ü50_N==1 & prommobkmwe_ü100_N==1
label define index_lb 1 "Weder häufig Fern- noch WE-Pendeln" 2 "Mind. 1 Mal häufiges Fern- oder WE-Pendeln" 3 "Sowohl häufiges Fern- als auch WE-Pendeln"
label values index_11 index_lb
label var index_11 "Index Pendelmobilität (Promovierende/Promotionsphase)"

// Postdocs/Postdoc-Phase
gen index_22=.
replace index_22=1 if pdocmobkm_ü50_N==0 & pdocmobkmwe_ü100_N==0 // UdW.<50km (häufig, sehr häufig) + am WE<100km (manchmal, häufig, sehr häufig)
replace index_22=2 if pdocmobkm_ü50_N==1 | pdocmobkmwe_ü100_N==1 
replace index_22=3 if pdocmobkm_ü50_N==1 & pdocmobkmwe_ü100_N==1
label values index_22 index_lb
label var index_22 "Index Pendelmobilität (Postdocs/Postdoc-Phase)"

// Profs/Profphase
gen index_33=.
replace index_33=1 if profmobkm_ü50_N==0 & profmobkmwe_ü100_N==0 // UdW.<50km (häufig, sehr häufig) + am WE<100km (manchmal, häufig, sehr häufig)
replace index_33=2 if profmobkm_ü50_N==1 | profmobkmwe_ü100_N==1 
replace index_33=3 if profmobkm_ü50_N==1 & profmobkmwe_ü100_N==1
label values index_33 index_lb
label var index_33 "Index Pendelmobilität (Profs/Prof-Phase)"


// Auslandsmobilität von mehr als 3 Monaten
// Promovierende/Promphase
encode promoaufenth_SQ003, gen(s_promoaufenth_SQ003)
recode       s_promoaufenth_SQ003 (1 = .)
recode       s_promoaufenth_SQ003 (2 = 1)
recode       s_promoaufenth_SQ003 (3 = 2)
recode       s_promoaufenth_SQ003 (4 = 3)
recode       s_promoaufenth_SQ003 (5 = 4)
recode       s_promoaufenth_SQ003 (6 = 5)
gen ausl3prom=.
replace ausl3prom=1 if s_promoaufenth_SQ003==1 
replace ausl3prom=2 if s_promoaufenth_SQ003==2 
replace ausl3prom=3 if s_promoaufenth_SQ003==3 
replace ausl3prom=4 if s_promoaufenth_SQ003==4 
replace ausl3prom=5 if s_promoaufenth_SQ003==5 
label define auslaufent_lb 1 "Sehr häufig" 2 "Häufig" 3 "Manchmal" 4 "Selten" 5 "Nie"
label values ausl3prom auslaufent_lb
label var ausl3prom "Auslandsaufenthalte von mehr als 3 Monaten im deutschsprachigen Ausland (Promotionsphase)"
tab ausl3prom 

// Postdocs/Postdocphase
encode pdocaufenth_SQ003, gen(s_pdocaufenth_SQ003)
recode       s_pdocaufenth_SQ003 (1 = .)
recode       s_pdocaufenth_SQ003 (2 = 1)
recode       s_pdocaufenth_SQ003 (3 = 2)
recode       s_pdocaufenth_SQ003 (4 = 3)
recode       s_pdocaufenth_SQ003 (5 = 4)
recode       s_pdocaufenth_SQ003 (6 = 5)
gen ausl3pdoc=.
replace ausl3pdoc=1 if s_pdocaufenth_SQ003==1 
replace ausl3pdoc=2 if s_pdocaufenth_SQ003==2 
replace ausl3pdoc=3 if s_pdocaufenth_SQ003==3 
replace ausl3pdoc=4 if s_pdocaufenth_SQ003==4 
replace ausl3pdoc=5 if s_pdocaufenth_SQ003==5 
label values ausl3pdoc auslaufent_lb
label var ausl3pdoc "Auslandsaufenthalte von mehr als 3 Monaten im deutschsprachigen Ausland (Postdoc-Phase)"
tab ausl3pdoc 

// Profs/Profphase
encode profaufenth_SQ003, gen(s_profaufenth_SQ003)
recode       s_profaufenth_SQ003 (1 = .)
recode       s_profaufenth_SQ003 (2 = 1)
recode       s_profaufenth_SQ003 (3 = 2)
recode       s_profaufenth_SQ003 (4 = 3)
recode       s_profaufenth_SQ003 (5 = 4)
recode       s_profaufenth_SQ003 (6 = 5)
gen ausl3prof=.
replace ausl3prof=1 if s_profaufenth_SQ003==1 
replace ausl3prof=2 if s_profaufenth_SQ003==2 
replace ausl3prof=3 if s_profaufenth_SQ003==3 
replace ausl3prof=4 if s_profaufenth_SQ003==4 
replace ausl3prof=5 if s_profaufenth_SQ003==5 
label values ausl3prof auslaufent_lb
label var ausl3prof "Auslandsaufenthalte von mehr als 3 Monaten im deutschsprachigen Ausland (Prof-Phase)"
tab ausl3prof

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Auslandsaufenthalte (Signifikanztests)
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Auslandsaufenthalte im nicht-deutschprachigen Ausland über 3 Monate

// Gruppe 1
gen ausland_prom_g1=.
replace ausland_prom_g1 = niausl3prom if phase==1
// Gruppe 2
gen ausland_pdoc_g2=.
replace ausland_pdoc_g2 = niausl3pdoc if phase==2
// Gruppe 3
gen ausland_prof_g3=.
replace ausland_prof_g3 = niausl3prof if phase==3

// Generate UV
gen aslanide_allgroup_uv=.
replace aslanide_allgroup_uv = 1 if ausland_prom_g1>=1 & ausland_prom_g1<=2
replace aslanide_allgroup_uv = 2 if ausland_pdoc_g2>=1 & ausland_pdoc_g2<=2
replace aslanide_allgroup_uv = 3 if ausland_prof_g3>=1 & ausland_prof_g3<=2
label define phaseausl_lb 1 "Promovierende" 2 "Postdocs" 3 "Profs"
label values aslanide_allgroup_uv phaseausl_lb
label var aslanide_allgroup_uv "Auslandsmobilität (Phasen)"
tab aslanide_allgroup_uv, mi

// Generate AV
gen aslanide_allgroup_av=.
replace aslanide_allgroup_av = ausland_prom_g1 if aslanide_allgroup_uv==1 // Promovierende
replace aslanide_allgroup_av = ausland_pdoc_g2 if aslanide_allgroup_uv==2 // Postdocs
replace aslanide_allgroup_av = ausland_prof_g3 if aslanide_allgroup_uv==3 // Profs
label define auslnideutsch_lb 1 "Manchmal, (sehr) häufig" 2 "selten/nie"
label values aslanide_allgroup_av auslnideutsch_lb
label var aslanide_allgroup_av "Auslandsmobilität im nicht-deutschprachigen Ausland zwischen den Phasen"
tab aslanide_allgroup_av 

tab aslanide_allgroup_uv aslanide_allgroup_av, chi2 V expected

gen test1=.
replace test1=1 if anford_profprom==1 & anford_profpdoc==1 & anford_prof==1
replace test1=2 if anford_profprom==1 & anford_profpdoc==1 & anford_prof==2 | anford_profprom==1 & anford_profpdoc==2 & anford_prof==2
replace test1=3 if anford_profprom==2 & anford_profpdoc==1 & anford_prof==2 
replace test1=4 if anford_profprom==1 & anford_profpdoc==2 & anford_prof==1 
replace test1=5 if anford_profprom==2 & anford_profpdoc==1 & anford_prof==1 
replace test1=6 if anford_profprom==2 & anford_profpdoc==2 & anford_prof==1
replace test1=7 if anford_profprom==2 & anford_profpdoc==2 & anford_prof==2								 
label var test1 "Räumliche Mobilität als Anforderung oder Möglichkeit im Verlauf der Phasen (Profs)"
tab test1

// I1: Formen von Auslandsmobilität nach Phase (Kurzaufenthalte, 1-3 Monate, >=3 Monate)


// Promovierende
gen ausland_prom_3kat=.
replace ausland_prom_3kat=1 if niauslkurzprom==1 & phase==1
replace ausland_prom_3kat=2 if niausl1bis3prom==1 & phase==1
replace ausland_prom_3kat=3 if niausl3prom==1 & phase==1
label define auslprom_lb 1 "Kurzaufenthalte" 2 "1-3 Monate" 3 "3 Monate und mehr"
label values ausland_prom_3kat auslprom_lb
label var ausland_prom_3kat "Auslandsmobilität: (Promotionsphase)"
tab ausland_prom_3kat 

// Postdocs 
gen ausland_pdoc_3kat=.
replace ausland_pdoc_3kat=1 if niauslkurzpdoc==1 & phase==2
replace ausland_pdoc_3kat=2 if niausl1bis3pdoc==1 & phase==2
replace ausland_pdoc_3kat=3 if niausl3pdoc==1 & phase==2
label values ausland_pdoc_3kat auslprom_lb
label var ausland_pdoc_3kat "Auslandsmobilität: (Postoc-Phase)"
tab ausland_pdoc_3kat 

// Profs 
gen ausland_prof_3kat=.
replace ausland_prof_3kat=1 if niauslkurzprof==1 & phase==3
replace ausland_prof_3kat=2 if niausl1bis3prof==1 & phase==3
replace ausland_prof_3kat=3 if niausl3prof==1 & phase==3
label values ausland_prof_3kat auslprom_lb
label var ausland_prof_3kat "Auslandsmobilität: (Prof-Phase)"
tab ausland_prof_3kat

// Gruppe 1
gen ausl_prom_g1=.
replace ausl_prom_g1 = ausland_prom_3kat
// Gruppe 2
gen ausl_pdoc_g2=.
replace ausl_pdoc_g2 = ausland_pdoc_3kat
// Gruppe 3
gen ausl_prof_g3=.
replace ausl_prof_g3 = ausland_prof_3kat

// Generate UV
gen ausl_allgroup_uv=.
replace ausl_allgroup_uv=1 if ausl_prom_g1>=1 & ausl_prom_g1<=3
replace ausl_allgroup_uv=2 if ausl_pdoc_g2>=1 & ausl_pdoc_g2<=3
replace ausl_allgroup_uv=3 if ausl_prof_g3>=1 & ausl_prof_g3<=3
label values ausl_allgroup_uv phcomm_lb
label var ausl_allgroup_uv "Auslandsmobilität Phase"
tab ausl_allgroup_uv

// Generate AV
gen ausl_group_av=.
replace ausl_group_av=ausl_prom_g1 if ausl_allgroup_uv==1
replace ausl_group_av=ausl_pdoc_g2 if ausl_allgroup_uv==2
replace ausl_group_av=ausl_prof_g3 if ausl_allgroup_uv==3
label define AUSLND_lb 1 "Kurzaufenthalte" 2 "1-3 Monate" 3 "Mehr als 3 Moante"
label values ausl_group_av AUSLND_lb
label var ausl_group_av "Auslandsmobilität nach Phase"
tab ausl_group_av*/



save "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\RM_SM_04.dta", replace 



