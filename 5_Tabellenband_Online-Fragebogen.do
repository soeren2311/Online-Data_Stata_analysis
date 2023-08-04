// Datensatz verwenden
use "C:\Users\sonon001\Desktop\Online-Fragebogen\Daten\SM_02.dta", clear 

****~~~~~~~ Weitere Fragen (Nicole)
numlabel _all, add

// Soziodemographische Faktoren

tab diszi
tab phase 
tab ybirth 
tab gender 
tab handicap 
tab msprache 
tab fsprachen 
tab eduabi 
tab staatsang 
tab xstaat 
tab edupromo 
tab jdeg 
tab edup 
tab partner 
tab partnerhh 
tab kinder 
tab kinderzahl 

// Promotion 
tab promoumz 
tab stpromo 
tab stpromoart1 
tab stpromoumf1 
tab stpromobef1 
tab1 promkarr1 promkarr2 promkarr3 promkarr4 promkarr5
tab1 promfinz1 promfinz2 promfinz3 promfinz4 promfinz5

tab stpromoart2 
tab stpromoumf2 
tab stpromobef2 
tab stpromoart3 
tab stpromoumf3 
tab stpromobef3 
tab stpromoart4 
tab stpromoumf4 
tab stpromobef4 
tab stpromoart5 
tab stpromoumf5 
tab stpromobef5 


tab promodauer 
tab promoalter 
tab promoarbausl 
tab promoarbauslzahl 
tab promoewalos ezpzpromo
tab promokinderbet 
tab promosupport 
tab promoexz 
tab promoewaext 
tab promoaufenth_SQ001 
tab promoaufenth_SQ002
tab promoaufenth_SQ003 
tab promoaufenth_SQ004 
tab promoaufenth_SQ005 
tab promoaufenth_SQ006 
tab stpromoloc 
tab stpromomove
tab promomobikm_SQ001 
tab promomobikm_SQ002 
tab promomobikm_SQ003 
tab promomobizeit_SQ001 
tab promomobizeit_SQ002 
tab promomobizeit_SQ003 
tab promowepenjn 
tab promodistanzwe_SQ001 
tab promodistanzwe_SQ002 
tab promodistanzwe_SQ003 
tab promodistanzwe_SQ004 
tab promozeitwe_SQ001 
tab promozeitwe_SQ002 
tab promozeitwe_SQ003 
tab promozeitwe_SQ004 
tab promozeitwe_SQ005 
tab promosparen 
tab promostip 
tab promobc 
tab promosprache 
tab promoanfmgl


// Postdocs

tab stpdoc 
tab stpdocart1 
tab stpdocumf1 
tab stpdocbef1 
tab1 pdockarr1 pdockarr2 pdockarr3 pdockarr4 pdockarr5
tab1 pdocfinz1 pdocfinz2 pdocfinz3 pdocfinz4 pdocfinz5
tab stpdocart2 
tab stpdocumf2 
tab stpdocbef2 
tab stpdocart3 
tab stpdocumf3 
tab stpdocbef3 
tab stpdocart4 
tab stpdocumf4 
tab stpdocbef4 
tab stpdocart5 
tab stpdocumf5 
tab stpdocbef5 
tab pdocdauer 
tab pdocarbausl 
tab pdocarbauslzahl 
tab pdocewalos 
tab ezpzpdoc 
tab pdockinderbet 
tab pdocsupport 
tab pdocexz 
tab pdocewxt 
tab pdocaufenth_SQ001 
tab pdocaufenth_SQ002 
tab pdocaufenth_SQ003 
tab pdocaufenth_SQ004 
tab pdocaufenth_SQ005 
tab pdocaufenth_SQ006 
tab stpdocloc 
tab stpdocmove 
tab pdocmobikm_SQ001 
tab pdocmobikm_SQ002 
tab pdocmobikm_SQ003 
tab pdocmobizeit_SQ001 
tab pdocmobizeit_SQ002 
tab pdocmobizeit_SQ003 
tab pdocwepenjn 
tab pdocdistwe_SQ001 
tab pdocdistwe_SQ002 
tab pdocdistwe_SQ003 
tab pdocdistwe_SQ004 
tab pdoczeitwe_SQ001 
tab pdoczeitwe_SQ002 
tab pdoczeitwe_SQ003 
tab pdoczeitwe_SQ004 
tab pdoczeitwe_SQ005 
tab pdocsparen 
tab pdocstip 
tab pdocbc 
tab pdocsprache 
tab pdocanfmgl


// Profs
// Stellensituation
tab stprof 
tab1 stprofart1 stprofbef1 
tab1 stprofeva1_SQ001 stprofeva2_SQ001 stprofeva3_SQ001 stprofeva4_SQ001
tab1 stprofeva1_SQ002 stprofeva2_SQ002 stprofeva3_SQ002 stprofeva4_SQ002
tab1 stprofart2 stprofbef2   
tab1 stprofart3 stprofbef3 
tab1 stprofart4 stprofbef4 
tab1 stprofart5 stprofbef5 
tab profdauer 

// Ausland
tab1 profarbausl profarbauslzahl 
tab1 profaufenth_SQ001 profaufenth_SQ002 profaufenth_SQ003 
tab1 profaufenth_SQ004 profaufenth_SQ005 profaufenth_SQ006 

// Umzüge
tab1 stprofloc stprofmove 

// Pendeln
tab1 profmobikm_SQ001 profmobikm_SQ002 profmobikm_SQ003 
tab1 profmobizeit_SQ001 profmobizeit_SQ002 profmobizeit_SQ003 
tab profwepenjn 
tab1 profdistwe_SQ001 profdistwe_SQ002 profdistwe_SQ003 profdistwe_SQ004 
tab1 profzeitwe_SQ001 profzeitwe_SQ002 profzeitwe_SQ003 profzeitwe_SQ004 profzeitwe_SQ005
 
// finanzielle Rücklagen
tab profsparen 
tab profbc 

// Anforderung u Möglichkeit
tab profanfmgl

// Einstellungsfragen