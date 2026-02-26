*****TITLE: DMAV Project 1
*****AUTHOR: Sarah Cook
*****DATE: 24Feb2026
*****PURPOSE: Preparation and Exploratory Data Analysis of the ANSUR Anthropometric Measure Dataset

use "C:\Users\cooks\OneDrive\Documents\DMAV26\Proj1\ansur2allV2_raw.dta

*Generate unique ID for each observation

generate id = "ID" + string(_n, "%05.0f")

*Recode placeholders with smvs:

ds, has(type numeric)
mvdecode `r(varlist)', mv(-77=.a \ -88=.b \ -99=.c)
label define missing_vals .a "missing: not recorded" .b "missing: refused measurement" .c "missing: unknown"
ds, has(type numeric)
label values `r(varlist)' missing_vals

*Convert measurements from mm to cm:

replace thumbtipreach = thumbtipreach / 10

replace span = span / 10

replace footlength = footlength / 10

replace kneeheightmidpatella = kneeheightmidpatella / 10

replace waistheightomphalion = waistheightomphalion / 10

replace functionalleglength = functionalleglength / 10

replace cervicaleheight = cervicaleheight / 10

replace trochanterionheight = trochanterionheight / 10

replace stature = stature / 10

replace waistcircumference = waistcircumference / 10

replace chestcircumference = chestcircumference / 10

replace bicristalbreadth = bicristalbreadth / 10

replace hipbreadth = hipbreadth / 10

replace hipbreadthsitting = hipbreadthsitting / 10

format thumbtipreach span footlength kneeheightmidpatella waistheightomphalion functionalleglength cervicaleheight trochanterionheight stature waistcircumference chestcircumference bicristalbreadth hipbreadth hipbreadthsitting %9.2f

*Label everything!

label var id "unique ID"

label var dodrace "self-reported single race"
label define race 1 "white" 2 "black" 3 "hispanic" 4 "asian" 5 "native american" 6 "pacific islander" 7 "missing: unknown" 8 "other"
label values dodrace race

label var ethnicity "self-reported ethnicity"

label var gender "gender (male or female)"

label var age "age in years"

label var component "military component"

label var branch "military branch"

label var writingpreference "preferred writing hand"

label var installation "installation where measurement occurred"

label var test_date "date measurement was taken, in string form"

label var weightlbs "self-reported weight in pounds"

label var heightin "self-reported height in inches"

label var thumbtipreach "thumbtip reach (cm)"

label var span "span (cm)"

label var footlength "foot lenght (cm)"

label var kneeheightmidpatella "knee height, midpatella (cm)"

label var waistheightomphalion "waist height (omphalion) (cm)"

label var functionalleglength "functional leg lenght (cm)"

label var cervicaleheight "cervial height (cm)"

label var trochanterionheight "trochanterion height (cm)"

label var stature "stature (cm)"

label var waistcircumference "waist circumference (cm)"

label var chestcircumference "chest circumference (cm)"

label var bicristalbreadth "bicristal breadth (cm)"

label var hipbreadth "hip breadth (cm)"

label var hipbreadthsitting "seated hip breadth (cm)"

label var weightkg "measured weight in kg"

label var date "date the participant was measured"

label var strdate "date the participant was measured, in string form"

*remove minors:

list age id if age<18
/*
      | age        id |
      |---------------|
2786. |  17   ID02786 |
5594. |  17   ID05594 
*/

drop if age == 17

///ID02786 and ID05594 removed due to age<18

*create a mechanism for flagging observations with suspicious values:

generate suspect = 0
label var suspect "observation contains at least one suspicious value"
label define suss 0 "no" 1 "yes"
label values suspect suss

*and one for flagging duplicate observations:

generate duplicate = 0
label var duplicate "observation is a duplicate"
label define dupe 0 "no" 1 "yes"
label values duplicate dupe

duplicates report *

*Determine duplicate criteria

duplicates report dodrace ethnicity gender age thumbtipreach span footlength kneeheightmidpatella chestcircumference

/*
   Copies | Observations       Surplus
----------+---------------------------
        1 |         5165             0
        2 |         1864           932
 */
 
*label duplicates with flag variable
bysort dodrace ethnicity gender age thumbtipreach span footlength kneeheightmidpatella chestcircumference: replace duplicate = 1 if _n > 1

*move duplicate values to a new dataset
preserve
keep if duplicate == 1
save "duplicates_only.dta", replace
restore

drop if duplicate == 1

*Calculate BMI:

gen height_meters=(stature/100)
gen bmi=weightkg/(height_meters*height_meters)
label var bmi "body mass index"
label var height_meters "height in meters"
format bmi %9.2f

*flag high BMI values as suspicious:

summ bmi, detail
tab bmi if bmi>40 /*no bmi values exist between 44-100*/
replace suspect = 1 if bmi > 44 & bmi < .

*create a categorical variable to classify individual weight based on BMI and CDC cut points

recode bmi (0/18.5=1 "underweight")(18.5/25=2 "healthy weight")(25/30=3 "overweight")(30/99=4 "obese")(99/.c=5 "missing"), generate (bmiweight)

*Encode a new numerical categorical variable for gender

encode gender, generate(gender_num)
label var gender_num "gender"

*Encode a new numerical categorical variable for preferred hand

tab writingpreference
replace writingpreference = "Either hand (No preference)" if writingpreference == "Either han"
generate hand = .
replace hand = 1 if writingpreference == "Right hand"
replace hand = 2 if writingpreference == "Left hand"
replace hand = 3 if writingpreference == "Either hand (No preference)"
label define hand_label 1 "Right hand" 2 "Left hand" 3 "Either hand (No preference)"
label values hand hand_label
label var hand "dominant hand"

*create a variable that indicates the season the measurements were made

generate month = month(date)
generate season = .
replace season = 1 if inlist(month, 12, 1, 2)    // Winter
replace season = 2 if inlist(month, 3, 4, 5)     // Spring
replace season = 3 if inlist(month, 6, 7, 8)     // Summer
replace season = 4 if inlist(month, 9, 10, 11)   // Fall
label define seasons 1 "Winter" 2 "Spring" 3 "Summer" 4 "Fall"
label values season seasons
label var season "Season of data collection"
label var month "month of data collection"

*Create a variable that creates categories of body types based on height, weight and other measurements:

*Evaluate measures of BMI and body width/girth for males and females:

summ waistcircumference if gender_num==1, detail
summ waistcircumference if gender_num==2, detail

sum chestcircumference if gender_num==1, detail
sum chestcircumference if gender_num==2, detail

sum hipbreadth if gender_num==1, detail
sum hipbreadth if gender_num==2, detail

sum bmi if gender_num==1, detail
sum bmi if gender_num==2, detail

*****different cutoffs for males vs females, based on quartiles*****

*ectomorph(_m and _f): low bmi, narrow hips/shoulders
*mesomorph(_m and _f): narrow waist and joints, wider shoulders
*endomorph(_m and _f): wide hips, shorter limbs

generate body_type = .
replace body_type = 1 if(gender_num==2 & waistcircumference<86) //ectomorph_m
replace body_type = 2 if(gender_num==1 & waistcircumference<79) //ectomorph_f
replace body_type = 3 if(gender_num==2 & (chestcircumference>100 & (bmi>25 & bmi<30)) | (bmi>25 & waistcircumference<100)) //mesomorph_m
replace body_type = 4 if(gender_num==1 & (chestcircumference>90 & (bmi>23 & bmi<27.5)) | (bmi>25 & waistcircumference<92)) //mesomorph_f
replace body_type = 5 if(gender_num==2 & (bmi>30 | (bmi>25 & waistcircumference>100))) //endomorph_m
replace body_type = 6 if(gender_num==1 & (bmi>27.5 | (bmi>25 & waistcircumference>92))) //endomorph_f
label define body_types 1 "ectomorph_m" 2 "ectomorph_f" 3 "mesomorph_m" 4 "mesomorph_f" 5 "endomorph_m" 6 "endomorph_f"
label values body_type body_types
label var body_type "body type based on anthropometrics"

tab bmiweight if body_type==.
/* 
 RECODE of bmi |
    (body mass |
        index) |      Freq.     Percent        Cum.
---------------+-----------------------------------
healthy weight |        544      100.00      100.00
---------------+-----------------------------------
         Total |        544      100.00
*/

*recode all "healthy weight" soldiers who didn't fall into any of the above categories as mesomorphs.

replace body_type = 3 if(gender_num==2 & body_type==.) //mesomorph_m
replace body_type = 4 if(gender_num==1 & body_type==.) //mesomorph_f

*save cleaned data
/*save "C:\Users\cooks\OneDrive\Documents\DMAV26\Proj1\Project1 dataset V2.dta"*/

*create a table of anthropometric observations

summ chestcircumference, detail
summ waistcircumference, detail
summ hipbreadth, detail
summ hipbreadthsitting, detail
summ bicristalbreadth, detail
summ stature, detail
summ kneeheightmidpatella, detail
summ cervicaleheight, detail
summ trochanterionheight, detail
summ waistheightomphalion, detail
summ functionalleglength, detail
summ footlength, detail
summ thumbtipreach, detail
summ span, detail
summ weightkg, detail

*deal with suspcious values:

replace suspect = 1 if hipbreadth < 30

tab thumbtipreach if thumbtipreach>92
replace suspect = 1 if thumbtipreach>100

tab weightkg if weightkg>150
replace suspect = 1 if weightkg>500 /*this one already handled with BMI*/

*****calculate % of total height attributable to the height to hip

generate byhip = ((trochanterionheight/stature)*100)
format byhip %9.2f
label var byhip "% of total height attributable to the height to hip"

*create a figure, sorted by gender:

graph box byhip, over(gender_num, label(labcolor("black"))) box(1, fcolor(gray) lcolor(black)) ytitle("% Height to Hip") title("Figure 3.1: % Height Attributable to Height-to-Hip, by Gender") scheme(s2mono)

*****Explore correlations between measures of stature:

pwcorr stature kneeheightmidpatella cervicaleheight trochanterionheight waistheightomphalion functionalleglength footlength thumbtipreach span, sig star(0.05) listwise

*strongest correlations:
	*cervicaleheight and stature (0.9912)
	*cervicaleheight and waistheightomphalion (0.9414)
	
* weakest correlation: trochanterionheight and thumbtipreach (0.1427)

*graph correlation between cervicaleheight and stature:

twoway (scatter cervicaleheight stature), title("Figure 4.1: Correlation between Stature and Neck Height") scheme(s2mono)

*****correlation of stature with other measures of stature (by gender):

*female:
pwcorr stature kneeheightmidpatella cervicaleheight trochanterionheight waistheightomphalion functionalleglength footlength thumbtipreach span if gender_num == 1, sig star(0.05)

*male:
pwcorr stature kneeheightmidpatella cervicaleheight trochanterionheight waistheightomphalion functionalleglength footlength thumbtipreach span if gender_num == 2, sig star(0.05)

*****reported vs actual weight

generate weightdiff = (weightlbs*0.453)-weightkg
format weightdiff %9.2f
label var weightdiff "weight difference in kg (self-reported minus measured)"

graph box weightdiff if weightdiff > -40 & weightdiff < 40, over(gender_num, label(labcolor("black"))) box(1, fcolor(gray) lcolor(black)) ytitle("Weight Difference in kg") title("Figure 4.2-1: Difference in self-reported and measured weights, kg") note("Extreme outliers (>|40|kg) excluded for visualization") scheme(s2mono) 

*****reported vs actual height

generate heightdiff = (heightin*2.54)-stature
format heightdiff %9.2f
label var heightdiff "height difference in cm (self-reported minus measured)"

graph box heightdiff if heightdiff > -20 & heightdiff < 20, over(gender_num, label(labcolor("black"))) box(1, fcolor(gray) lcolor(black)) ytitle("Height Difference in cm") title("Figure 4.2-2: Difference in self-reported and measured heights, cm") note("Extreme outliers (>|20|cm) excluded for visualization") scheme(s2mono) 

*Attemting to understand the nature of discrepancies between reported and measured values:

summ heightin, detail
summ weightlb, detail

replace suspect = 1 if weightlb==0

summ stature, detail
summ weightkg, detail /*issue with measured weight for some observations*/

tab weightkg if weightkg>125
tab weightkg if weightkg>500
*17 observations have a measured weight > 500kg, which seems extremely unlikely - possibly some issue with units at the time of measurement or during data entry. Already flagged suspicious.

*****compare distribution of weight/BMI by body type:

tab bmiweight body_type if gender_num==1
tab bmiweight body_type if gender_num==2
