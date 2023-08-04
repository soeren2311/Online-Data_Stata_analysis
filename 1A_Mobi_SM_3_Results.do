// Datensatz verwenden
use "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\SM_02.dta", clear 

****~~~~~~~ Weitere Fragen (Nicole)
numlabel _all, add


// I3: 4_SM (Arten Univariat nach Phase und Fach, 6 Weitere Tabellen zur sozialen Mobilität (Noch erweiterbar), S.8)
// Stellenumfang (PROMOTIONSPHASE)
tab prom_stumf 
tab prom_stumf if stpromo>=2 & stpromo<. & phase==1 // Mit mindestens 1 Stellenwechsel
list id phase stpromoumf1 stpromoumf2 stpromoumf3 stpromoumf4 stpromoumf5 prom_stumf0 prom_stumf50 prom_stumf76 prom_stumf in 1/550 if phase==1

// Stellenumfang (POSTDOCPHASE)
tab pdoc_stumf 
tab pdoc_stumf if stpdoc>=2 & stpdoc<. & phase==2 // Mit mindestens 1 Stellenwechsel
list id phase stpdocumf1 stpdocumf2 stpdocumf3 stpdocumf4 stpdocumf5 pdoc_stumf0 pdoc_stumf50 pdoc_stumf76 pdoc_stumf in 1/550 if phase==2


*************************************************************************************
*********** SUBJEKTIVE PRESTIGEBEWERTUNG Promovierende/Promotionsphase **************
*************************************************************************************

list id promkarr1_NP promkarr2_NP promkarr3_NP promkarr4_NP promkarr5_NP total_mean_promprom if phase==1 in 1/200
sum total_mean_promprom, detail  // mean = 0,65
sum total_mean_promprom if total_posit_prom>=2 & total_posit_prom<=5, detail  // mean bei mehr als 2 Stellen

// Durchschnittliche Promotionsdauer bei den aktuell Promovierenden, Postdocs und Profs mit 
// Stellenwechsel + Promodauer Länge <= 10 Jahre 
sum promodauer if prom_stwchl==1 & (promodauer>=0 & promodauer<=80), detail
sum promodauer if pdoc_stwchl==1 & (promodauer>=0 & promodauer<=80), detail   
sum promodauer if prof_stwchl==1 & (promodauer>=0 & promodauer<=80), detail

// Differenz zw. erster und letzter Stelle unterschieden nach 1 - 2,99, 4 - 5,99, mindestens 6 Jahre Promotionsdauer
sum last_first_prom if promdauer_kat==1 & phase==1
sum last_first_prom if promdauer_kat==2 & phase==1
sum last_first_prom if promdauer_kat==3 & phase==1


************************************************************************
******* Signifikanztests (Anova-Signifikanztest und tt-test) ***********
************************************************************************

// Differenz der Prestige-Bewertung zwischen erster und letzter Stelle nach Promotionsdauer (kategorisiert)    
// Anova-Signifikanztest + posthoc-Test
oneway all_group_av all_group_uv
oneway all_group_av all_group_uv, scheffe // n.s.

// sd-test (prüft ob standardabweichungen in beiden Gruppen gleich oder ähnlich groß ist)
sdtest group1_3_av, by(group1_3_uv)  // Standardbweichungen gleich groß
// t-test 
ttest group1_3_av, by(group1_3_uv)  // zweiseitig: p-wert = 0.1083 


*************************************************************************************************************
*************************************************************************************************************

// Grafik 1 nach Fächern unterscheiden (Durchschnitt pro Fach berechnen s.o)
tab last_first_prom diszi if phase==1, column
sum last_first_prom if diszi==1 
sum last_first_prom if diszi==2 
sum last_first_prom if diszi==3 

// Durchschnittliche Prestigebewertung nach Fächern
by diszi, sort: summarize prest_diszi if phase==1


****************************************************************************************************
*********** Differenz Prestigebewertung Promovierende/Promotionsphase nach Disziplin ***************
****************************************************************************************************

// Anova-Signifikanztest + post-hoc Test
oneway all_group_avF all_group_uv_F
oneway all_group_avF all_group_uv_F, scheffe

// sd-test (prüft ob standardabweichungen in beiden Gruppen gleich oder ähnlich groß ist)
sdtest group1_3_av_F, by(group1_3_uv_F)  // Standardbweichungen gleich groß
// t-test 
ttest group1_3_av_F, by(group1_3_uv_F)  // zweiseitig: p-wert = 0.0607


*************************************************************************************
*********** SUBJEKTIVE PRESTIGEBEWERTUNG Postdocs/Postdocphase **************
*************************************************************************************

// Ist subjektive Prestigebewertung bei der gegenwärtigen Stelle höher als die entsprechende in der Promotionsphase

// Bildung der Differenz zwischen den Stellen der Prom- und Postdocphase (st. 1 Promphase - st. 1 Postdocphase)

*~~~~~~~~~~~~~ Differenz Stelle 1 der Promovierenden zu Stelle 1 der Postdocs
sum pdockarr1_NP
local pdoc_1, r(mean)
di `pdoc_1' // .62096774
sum promkarr1_NP  
local prom_1 = r(mean)
di `prom_1' // .62662808

*~~~~~~~~~~~~~ Differenz Stelle 2 Promo und Postdocphase der Postdocs
sum pdockarr2_NP
local pdoc_2, r(mean)
di `pdoc_2' // .8178808
sum promkarr2_NP  
local prom_2 = r(mean)
di `prom_2' // .4444444

*~~~~~~~~~~~~~ Differenz Stelle 3 Promo und Postdocphase der Postdocs
sum pdockarr3_NP
local pdoc_3, r(mean)
di `pdoc_3' 
sum promkarr3_NP  
local prom_3 = r(mean)
di `prom_3'

*~~~~~~~~~~~~~ Differenz Stelle 4 Promo und Postdocphase der Postdocs
sum pdockarr4_NP
local pdoc_4, r(mean)
di `pdoc_4' 
sum promkarr4_NP  
local prom_4 = r(mean)
di `prom_4'

// Grafik 3 nach Fächern unterscheiden
tab last_first_pdoc diszi if phase==2, column
sum last_first_pdoc if diszi==1 
sum last_first_pdoc if diszi==2 
sum last_first_pdoc if diszi==3 

// Signifikanztests: Durchschnittliche Differenz der Bewertungen zwischen erster und letzter 
// Stelle nach der Disziplin der Postdocs in der Postdoc-Phase

// Gruppe 1
sum last_first_pdoc_F_g1  // Biologie
// Gruppe 2
sum last_first_pdoc_F_g2  // Informatik
// Gruppe 3
sum last_first_pdoc_F_g3  // Soziologie


// Anova-Signifikanztest + post-hoc Test
oneway all_group_av_Fpdoc all_group_uv_Fpdoc
oneway all_group_av_Fpdoc all_group_uv_Fpdoc, scheffe

// sd-test (prüft ob standardabweichungen in beiden Gruppen gleich oder ähnlich groß ist)
sdtest group1_3_av_Fpdoc, by(group1_3_uv_F_pdoc)  // Standardbweichungen gleich groß
// t-test 
ttest group1_3_av_Fpdoc, by(group1_3_uv_F_pdoc)  // zweiseitig: p-wert = 0.0029 


*************************************************************************************
*********** SUBJEKTIVE PRESTIGEBEWERTUNG Profs/Profphase, Pdocs/Pdoc-Phase **************
*************************************************************************************

// Pdocs/Pdoc-Phase. Durchschnittliche Prestigebewertung. Mittelwert der Bewertungen über alle Stellen hinweg 
list id pdockarr1_NP pdockarr2_NP pdockarr3_NP pdockarr4_NP pdockarr5_NP total_mean_pdocpdoc in 1/500
sum total_mean_pdocpdoc, detail  // mean = 0,68
sum total_mean_pdocpdoc if total_posit_pdoc>=2 & total_posit_pdoc<=5 & phase==2  // 0.73 (mind. 2 stellen)
// Pdocs/Pdoc-Phase. Durchschnittliche Prestigebewertung. Mittelwert der Bewertungen von Personen mit mindestens 2 Stellen
list id pdockarr1_NP pdockarr2_NP pdockarr3_NP pdockarr4_NP pdockarr5_NP total_mean_pdocpdoc_st2 in 1/500
sum total_mean_pdocpdoc_st2, detail  // mean = 1,30
tab total_mean_pdocpdoc_st2

// Profs/Profphase. Durchschnittliche Prestigebewertung. Mittelwert der Bewertungen über alle Stellen hinweg 
list id profkarr1_NP profkarr2_NP profkarr3_NP profkarr4_NP profkarr5_NP total_mean_profprof in 1/500
sum total_mean_profprof, detail  // mean = 1,35
tab total_mean_profprof
// Profs/Profphase. Durchschnittliche Prestigebewertung. Mittelwert der Bewertungen von Personen mit mindestens 2 Stellen
list id profkarr1_NP profkarr2_NP profkarr3_NP profkarr4_NP profkarr5_NP total_mean_profprof_st2 in 1/500
sum total_mean_profprof_st2, detail  // mean = 1,30
tab total_mean_profprof_st2

// Wie viele Promovenden und Postdocs haben durchschnittlich über die Stellen hinweg innerhalb der Phasen 
// welchen Stellenumfang

// Promovierende/Promotionsphase (Durchschnittlicher Stellenumfang über alle Stellen hinweg)
tab stpromoumf1 
tab stpromoumf2 
tab stpromoumf3 
tab stpromoumf4 
tab stpromoumf5 if phase==1 & total_posit_promU<=5

// Postdocs/Postdocphase (Durchschnittlicher Stellenumfang über alle Stellen hinweg)
tab stpdocumf1 
tab stpdocumf2 
tab stpdocumf3 
tab stpdocumf4 
tab stpdocumf5 if phase==2 & total_posit_pdocU<=5

// Kreuztabelle Stellenumfang und Bewertung der finanziellen Situation? pro Phase und Stelle
tab promfinz3 stpromoumf3 if phase==1, column

*~~~~~ Promotionsphase/Promovierende  
tab promfinz1 stpromoumf1 if phase==1, chi2 V expected
tab promfinz2 stpromoumf2 if phase==1, chi2 V expected
tab promfinz3 stpromoumf3 if phase==1, chi2 V expected
tab promfinz4 stpromoumf4 if phase==1, chi2 V expected
*~~~~~ Postdocphase/Postdocs
tab pdocfinz1 stpdocumf1 if phase==2, chi2 V expected
tab pdocfinz2 stpdocumf2 if phase==2, chi2 V expected
tab pdocfinz3 stpdocumf3 if phase==2, chi2 V expected
tab pdocfinz4 stpdocumf4 if phase==2, chi2 V expected
tab pdocfinz5 stpdocumf5 if phase==2, chi2 V expected

// Univariate Verteilung der finanziellen Situation? Also auf welchem Niveau ändert sich die Zufriedenheit (nicht) ?
tab promfinz1_NP
egen mean_promfinz = rowmean(promfinz1_NP - promfinz5_NP)
list id promfinz1_NP promfinz2_NP promfinz3_NP promfinz4_NP promfinz5_NP mean_promfinz in 1/500 if phase==1
sum mean_promfinz

// Kreuztabelle Prestige-Bewertung und Bewertung der finanziellen Situation pro Phase und Stelle, auch durchschnittlich pro Phase

*~~~~~ Promotionsphase/Promovierende
tab promkarr1 promfinz1 if phase==1, chi2 V expected
tab promkarr2 promfinz2 if phase==1, chi2 V expected
tab promkarr3 promfinz3 if phase==1, chi2 V expected
tab promkarr4 promfinz4 if phase==1, chi2 V expected
tab promkarr5 promfinz5 if phase==1, chi2 V expected

*~~~~~ Postdocphase/Postdocs
tab pdockarr1 pdocfinz1 if phase==2, chi2 V expected
tab pdockarr2 pdocfinz2 if phase==2, chi2 V expected
tab pdockarr3 pdocfinz3 if phase==2, chi2 V expected
tab pdockarr4 pdocfinz4 if phase==2, chi2 V expected
tab pdockarr5 pdocfinz5 if phase==2, chi2 V expected

*************************************************************************************************************
************************* Finanzielle Bewertung der Stellen nach Phasen und Fach ****************************
*************************************************************************************************************

// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Promotionsphase/Promovierende)
list id phase promfinz1_NP promfinz2_NP promfinz3_NP promfinz4_NP promfinz5_NP total_mean_prompromFINZ if phase==1 in 1/200
sum total_mean_prompromFINZ, detail  // mean = 0,52
by diszi, sort: sum total_mean_prompromFINZ  // Biologie = -0,03, Informatik = 0,85, Soziologie = 0,44
// Stellenwechsler
list id phase promfinz1_NP promfinz2_NP promfinz3_NP promfinz4_NP promfinz5_NP total_mean_prompromFINZ_st2 in 1/500 if phase==1
sum total_mean_prompromFINZ_st2, detail  // mean = 0,38 
by diszi, sort: sum total_mean_prompromFINZ_st2  // Biologie = -0,03, Informatik = 0,85, Soziologie = 0,44
sum last_first_promF
by diszi, sort: sum last_first_promF 

// STELLENUMFANG PROMOVIERENDE Für Rückfrage von Nicole
sum prom_umfang_B
by prom_umfang_B, sort: sum total_mean_prompromFINZ  // Finanzielle Bewertung der Stellen nach Stellenumfang
by diszi, sort: sum prom_umfang_B  

// Durchschnittliche finanzielle Stellenbewertung nach Stellenumfang und Fach
by prom_umfang_B, sort: sum total_mean_prompromFINZ if diszi==1
by prom_umfang_B, sort: sum total_mean_prompromFINZ if diszi==2
by prom_umfang_B, sort: sum total_mean_prompromFINZ if diszi==3

// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Postdoc-Phase/Postdocs)
list id phase pdocfinz1_NP pdocfinz2_NP pdocfinz3_NP pdocfinz4_NP pdocfinz5_NP total_mean_pdocpdocFINZ if phase==2 in 1/200
sum total_mean_pdocpdocFINZ, detail  // mean = 0,86
by diszi, sort: sum total_mean_pdocpdocFINZ 
// Stellenwechsler
list id phase pdocfinz1_NP pdocfinz2_NP pdocfinz3_NP pdocfinz4_NP pdocfinz5_NP total_mean_pdocpdocFINZ_st2 if phase==2 in 1/500
sum total_mean_pdocpdocFINZ_st2, detail  // mean = 0,81
by diszi, sort: sum total_mean_pdocpdocFINZ_st2 
sum last_first_pdocF
by diszi, sort: sum last_first_pdocF

// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Prof-Phase/Profs)
list id phase proffinz1_NP proffinz2_NP proffinz3_NP proffinz4_NP proffinz5_NP total_mean_profprofFINZ if phase==3 in 1/200
sum total_mean_profprofFINZ, detail  // mean = 1,29
by diszi, sort: sum total_mean_profprofFINZ 
// Stellenwechsler
list id proffinz1_NP proffinz2_NP proffinz3_NP proffinz4_NP proffinz5_NP total_mean_profprofFINZ_st2 in 1/500
sum total_mean_profprofFINZ_st2, detail  // mean = 1,27 
by diszi, sort: sum total_mean_profprofFINZ_st2
by diszi, sort: sum last_first_profF
sum last_first_profF
by diszi, sort: sum last_first_profF
 
 
*************************************************************************************************************
************************* Subjektive Prestige-Bewertung der Stellen nach Phasen und Fach ****************************
*************************************************************************************************************

// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Promotionsphase/Promovierende)
list id phase promkarr1_NP promkarr2_NP promkarr3_NP promkarr4_NP promkarr5_NP total_mean_prompromPrest if phase==1 in 1/200
sum total_mean_prompromPrest  
by diszi, sort: sum total_mean_prompromPrest  
// Stellenwechsler
list id phase promkarr1_NP promkarr2_NP promkarr3_NP promkarr4_NP promkarr5_NP total_mean_prompromPrest_st2 in 1/500 if phase==1
sum total_mean_prompromPrest_st2 
by diszi, sort: sum total_mean_prompromPrest_st2  
sum last_first_prom
by diszi, sort: sum last_first_prom


// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Postdoc-Phase/Postdocs)
list id phase pdockarr1_NP pdockarr2_NP pdockarr3_NP pdockarr4_NP pdockarr5_NP total_mean_pdocpdocPrest if phase==2 in 1/200
sum total_mean_pdocpdocPrest  
by diszi, sort: sum total_mean_pdocpdocPrest 
// Stellenwechsler
list id phase pdockarr1_NP pdockarr2_NP pdockarr3_NP pdockarr4_NP pdockarr5_NP total_mean_pdocpdocPrest_st2 if phase==2 in 1/500
sum total_mean_pdocpdocPrest_st2  
by diszi, sort: sum total_mean_pdocpdocPrest_st2
by diszi, sort: sum last_first_pdoc 
sum last_first_pdoc

// Mittelwert der Bewertungen über alle Stellen (Gesamt) nach Phase und Fach (Prof-Phase/Profs)
list id phase profkarr1_NP profkarr2_NP profkarr3_NP profkarr4_NP profkarr5_NP total_mean_profprofPrest if phase==3 in 1/200
sum total_mean_profprofPrest
by diszi, sort: sum total_mean_profprofPrest 
// Stellenwechsler
list id phase profkarr1_NP profkarr2_NP profkarr3_NP profkarr4_NP profkarr5_NP total_mean_profprofPrest_st2 if phase==3 in 1/500
sum total_mean_profprofPrest_st2
by diszi, sort: sum total_mean_profprofPrest_st2
sum last_first_prof
by diszi, sort: sum last_first_prof
 
// Bedeutung professur zu erhalten?
sum relwisskar1 if phase==2
by diszi, sort: sum relwisskar1 if phase==2

recode last_first_prom (-3 -2 = -2 "Viel schlechter") (-1 = -1 "Schlechter") (0=0 "Keine Veränderung") ///
					   (1=1 "Besser") (2 4 = 2 "Viel besser"), gen(last_first_prom_recoded)
					   
recode last_first_pdoc (-3 -2 = -2 "Viel schlechter") (-1 = -1 "Schlechter") (0=0 "Keine Veränderung") ///
					   (1=1 "Besser") (2 3 = 2 "Viel besser"), gen(last_first_pdoc_recoded)
					   
	   
// Promovierende und Profs nach bestimmten Merkmalen
by diszi, sort: sum age if phase==1 // Promovierende
by diszi, sort: sum age if phase==3 // Profs
by diszi, sort: sum promoalter if phase==1 // Promovierende
by diszi, sort: sum promoalter if phase==3 // Profs
by diszi, sort: sum promodauer if phase==1 // Promovierende
by diszi, sort: sum profdauer if phase==3 // Profs
by diszi, sort: sum pdocdauer if phase==2
by diszi, sort: tab promoewalos if phase==1 // Promovierende
by diszi, sort: tab profewalos if phase==3 // Profs
by diszi, sort: tab partner if phase==1 // Promovierende
by diszi, sort: tab partner if phase==3 // Profs
by diszi, sort: tab kinder if phase==1 // Promovierende
by diszi, sort: tab kinder if phase==3 // Profs
by diszi, sort: tab prom_wlb_all if phase==1 // Promovierende
by diszi, sort: tab prof_wlb_all if phase==3 // Profs
by diszi, sort: sum belcarekids_SQ002 if phase==1 // Promovierende
by diszi, sort: sum belcarekids_SQ002 if phase==3 // Profs


// Besoldungsgruppen erstellen für Profs
// Datensatz verwenden
save "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\SM_03.dta", replace 
