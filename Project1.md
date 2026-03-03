          . use "C:\Users\cooks\OneDrive\Documents\DMAV26\Proj1\ansur2allV2_raw.dta

          . generate id = "ID" + string(_n, "%05.0f")

          . ds, has(type numeric)
          subjectnum~e  weightlbs     span          waistheigh~n  trochanter~t  chestcircu~e  hipbreadth~g
          dodrace       heightin      footlength    functional~h  stature       bicristalb~h  weightkg
          age           thumbtipre~h  kneeheight~a  cervicaleh~t  waistcircu~e  hipbreadth    date

          . mvdecode `r(varlist)', mv(-77=.a \ -88=.b \ -99=.c)
          thumbtipre~h: 1 missing value generated
                  span: 1 missing value generated
            footlength: 1 missing value generated
          kneeheight~a: 1 missing value generated
          waistheigh~n: 1 missing value generated
          functional~h: 1 missing value generated
          cervicaleh~t: 1 missing value generated
          trochanter~t: 1 missing value generated
               stature: 1 missing value generated
          waistcircu~e: 1 missing value generated
          chestcircu~e: 1 missing value generated
          bicristalb~h: 1 missing value generated
            hipbreadth: 1 missing value generated
          hipbreadth~g: 1 missing value generated
              weightkg: 1 missing value generated

          . label define missing_vals .a "missing: not recorded" .b "missing: refused measurement" .c "missing: unknown"

          . ds, has(type numeric)
          subjectnum~e  weightlbs     span          waistheigh~n  trochanter~t  chestcircu~e  hipbreadth~g
          dodrace       heightin      footlength    functional~h  stature       bicristalb~h  weightkg
          age           thumbtipre~h  kneeheight~a  cervicaleh~t  waistcircu~e  hipbreadth    date

          . label values `r(varlist)' missing_vals

          . replace thumbtipreach = thumbtipreach / 10
          variable thumbtipreach was int now float
          (7,031 real changes made, 1 to missing)

          . replace span = span / 10
          variable span was int now float
          (7,031 real changes made, 1 to missing)

          . replace footlength = footlength / 10
          variable footlength was int now float
          (7,031 real changes made, 1 to missing)

          . replace kneeheightmidpatella = kneeheightmidpatella / 10
          variable kneeheightmidpatella was int now float
          (7,031 real changes made, 1 to missing)

          . replace waistheightomphalion = waistheightomphalion / 10
          variable waistheightomphalion was int now float
          (7,031 real changes made, 1 to missing)

          . replace functionalleglength = functionalleglength / 10
          variable functionalleglength was int now float
          (7,031 real changes made, 1 to missing)

          . replace cervicaleheight = cervicaleheight / 10
          variable cervicaleheight was int now float
          (7,031 real changes made, 1 to missing)

          . replace trochanterionheight = trochanterionheight / 10
          variable trochanterionheight was int now float
          (7,031 real changes made, 1 to missing)

          . replace stature = stature / 10
          variable stature was int now float
          (7,031 real changes made, 1 to missing)

          . replace waistcircumference = waistcircumference / 10
          variable waistcircumference was int now float
          (7,031 real changes made, 1 to missing)

          . replace chestcircumference = chestcircumference / 10
          variable chestcircumference was int now float
          (7,031 real changes made, 1 to missing)

          . replace bicristalbreadth = bicristalbreadth / 10
          variable bicristalbreadth was int now float
          (7,031 real changes made, 1 to missing)

          . replace hipbreadth = hipbreadth / 10
          variable hipbreadth was int now float
          (7,031 real changes made, 1 to missing)

          . replace hipbreadthsitting = hipbreadthsitting / 10
          variable hipbreadthsitting was int now float
          (7,031 real changes made, 1 to missing)

          . format thumbtipreach span footlength kneeheightmidpatella waistheightomphalion functionalleglength cervicaleheight trochanterionheight stature waistcircumference chestcircumference bicristalbreadth hipbreadth hipbreadthsitting %9.2f

          . label var id "unique ID"

          . label var dodrace "self-reported single race"

          . label define race 1 "white" 2 "black" 3 "hispanic" 4 "asian" 5 "native american" 6 "pacific islander" 7 "missing: unknown" 8 "other"

          . label values dodrace race

          . label var ethnicity "self-reported ethnicity"

          . label var gender "gender (male or female)"

          . label var age "age in years"

          . label var component "military component"

          . label var branch "military branch"

          . label var writingpreference "preferred writing hand"

          . label var installation "installation where measurement occurred"

          . label var test_date "date measurement was taken, in string form"

          . label var weightlbs "self-reported weight in pounds"

          . label var heightin "self-reported height in inches"

          . label var thumbtipreach "thumbtip reach (cm)"

          . label var span "span (cm)"

          . label var footlength "foot lenght (cm)"

          . label var kneeheightmidpatella "knee height, midpatella (cm)"

          . label var waistheightomphalion "waist height (omphalion) (cm)"

          . label var functionalleglength "functional leg lenght (cm)"

          . label var cervicaleheight "cervial height (cm)"

          . label var trochanterionheight "trochanterion height (cm)"

          . label var stature "stature (cm)"

          . label var waistcircumference "waist circumference (cm)"

          . label var chestcircumference "chest circumference (cm)"

          . label var bicristalbreadth "bicristal breadth (cm)"

          . label var hipbreadth "hip breadth (cm)"

          . label var hipbreadthsitting "seated hip breadth (cm)"

          . label var weightkg "measured weight in kg"

          . label var date "date the participant was measured"

          . label var strdate "date the participant was measured, in string form"

          . list age id if age<18

                +---------------+
                | age        id |
                |---------------|
          2786. |  17   ID02786 |
          5594. |  17   ID05594 |
                +---------------+

          . drop if age == 17
          (2 observations deleted)



          . generate suspect = 0

          . label var suspect "observation contains at least one suspicious value"

          . label define suss 0 "no" 1 "yes"

          . label values suspect suss

          . generate duplicate = 0

          . label var duplicate "observation is a duplicate"

          . label define dupe 0 "no" 1 "yes"

          . label values duplicate dupe

          . duplicates report *

          Duplicates in terms of subjectnumericrace dodrace ethnicity gender age component branch writingpreference installation
              test_date weightlbs heightin thumbtipreach span footlength kneeheightmidpatella waistheightomphalion
              functionalleglength cervicaleheight trochanterionheight stature waistcircumference chestcircumference
              bicristalbreadth hipbreadth hipbreadthsitting weightkg date strdate id suspect duplicate

          --------------------------------------
             Copies | Observations       Surplus
          ----------+---------------------------
                  1 |         7029             0
          --------------------------------------

          . duplicates report dodrace ethnicity gender age thumbtipreach span footlength kneeheightmidpatella chestcircumference

          Duplicates in terms of dodrace ethnicity gender age thumbtipreach span footlength kneeheightmidpatella
              chestcircumference

          --------------------------------------
             Copies | Observations       Surplus
          ----------+---------------------------
                  1 |         5165             0
                  2 |         1864           932
          --------------------------------------

          . bysort dodrace ethnicity gender age thumbtipreach span footlength kneeheightmidpatella chestcircumference: replace duplicate = 1 if _n > 1
          (932 real changes made)

          . preserve

          . keep if duplicate == 1
          (6,097 observations deleted)

          . save "duplicates_only.dta", replace
          file duplicates_only.dta saved

          . restore

          . drop if duplicate == 1
          (932 observations deleted)

          . gen height_meters=(stature/100)
          (1 missing value generated)

          . gen bmi=weightkg/(height_meters*height_meters)
          (1 missing value generated)

          . label var bmi "body mass index"

          . label var height_meters "height in meters"

          . format bmi %9.2f

          . summ bmi, detail

                                 body mass index
          -------------------------------------------------------------
                Percentiles      Smallest
           1%      19.2137       15.35156
           5%     20.96458       16.36616
          10%     21.99924       16.52117       Obs               6,096
          25%     24.11262       17.16434       Sum of wgt.       6,096

          50%     26.70425                      Mean           27.85263
                                  Largest       Std. dev.      15.37835
          75%     29.50872       314.6784
          90%     32.43026       320.7723       Variance       236.4936
          95%     34.24491       344.5361       Skewness       15.52252
          99%     38.59181       361.5917       Kurtosis       266.0971

          . tab bmi if bmi>40 /*no bmi values exist between 44-100*/

            body mass |
                index |      Freq.     Percent        Cum.
          ------------+-----------------------------------
                40.04 |          1        2.38        2.38
                40.22 |          1        2.38        4.76
                40.43 |          1        2.38        7.14
                40.45 |          1        2.38        9.52
                40.55 |          1        2.38       11.90
                40.65 |          1        2.38       14.29
                40.76 |          1        2.38       16.67
                40.77 |          1        2.38       19.05
                40.78 |          1        2.38       21.43
                40.82 |          1        2.38       23.81
                40.99 |          1        2.38       26.19
                41.00 |          1        2.38       28.57
                41.23 |          1        2.38       30.95
                41.34 |          1        2.38       33.33
                41.35 |          1        2.38       35.71
                41.46 |          1        2.38       38.10
                41.59 |          1        2.38       40.48
                41.99 |          1        2.38       42.86
                42.05 |          1        2.38       45.24
                43.45 |          1        2.38       47.62
               197.71 |          1        2.38       50.00
               211.68 |          1        2.38       52.38
               217.98 |          1        2.38       54.76
               219.24 |          1        2.38       57.14
               231.69 |          1        2.38       59.52
               241.45 |          1        2.38       61.90
               260.10 |          1        2.38       64.29
               265.32 |          1        2.38       66.67
               266.05 |          1        2.38       69.05
               266.62 |          1        2.38       71.43
               269.85 |          1        2.38       73.81
               271.03 |          1        2.38       76.19
               271.84 |          1        2.38       78.57
               276.47 |          1        2.38       80.95
               279.02 |          1        2.38       83.33
               291.22 |          1        2.38       85.71
               291.93 |          1        2.38       88.10
               295.90 |          1        2.38       90.48
               314.68 |          1        2.38       92.86
               320.77 |          1        2.38       95.24
               344.54 |          1        2.38       97.62
               361.59 |          1        2.38      100.00
          ------------+-----------------------------------
                Total |         42      100.00

          . replace suspect = 1 if bmi > 44 & bmi < .
          (22 real changes made)

          . recode bmi (0/18.5=1 "underweight")(18.5/25=2 "healthy weight")(25/30=3 "overweight")(30/99=4 "obese")(99/.c=5 "missing"), generate (bmiweight)
          (6,097 differences between bmi and bmiweight)

          . encode gender, generate(gender_num)

          . label var gender_num "gender"

          . tab writingpreference

               preferred writing hand |      Freq.     Percent        Cum.
          ----------------------------+-----------------------------------
                           Either han |         23        0.38        0.38
          Either hand (No preference) |         39        0.64        1.02
                            Left hand |        659       10.81       11.83
                           Right hand |      5,376       88.17      100.00
          ----------------------------+-----------------------------------
                                Total |      6,097      100.00

          . replace writingpreference = "Either hand (No preference)" if writingpreference == "Either han"
          (23 real changes made)

          . generate hand = .
          (6,097 missing values generated)

          . replace hand = 1 if writingpreference == "Right hand"
          (5,376 real changes made)

          . replace hand = 2 if writingpreference == "Left hand"
          (659 real changes made)

          . replace hand = 3 if writingpreference == "Either hand (No preference)"
          (62 real changes made)

          . label define hand_label 1 "Right hand" 2 "Left hand" 3 "Either hand (No preference)"

          . label values hand hand_label

          . label var hand "dominant hand"

          . generate month = month(date)
          (523 missing values generated)

          . generate season = .
          (6,097 missing values generated)

          . replace season = 1 if inlist(month, 12, 1, 2)    // Winter
          (1,480 real changes made)

          . replace season = 2 if inlist(month, 3, 4, 5)     // Spring
          (1,883 real changes made)

          . replace season = 3 if inlist(month, 6, 7, 8)     // Summer
          (926 real changes made)

          . replace season = 4 if inlist(month, 9, 10, 11)   // Fall
          (1,285 real changes made)

          . label define seasons 1 "Winter" 2 "Spring" 3 "Summer" 4 "Fall"

          . label values season seasons

          . label var season "Season of data collection"

          . label var month "month of data collection"

          . summ waistcircumference if gender_num==1, detail

                            waist circumference (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         66.5           61.1
           5%           71           61.5
          10%         73.9             62       Obs               1,990
          25%           79           62.4       Sum of wgt.       1,990

          50%         85.2                      Mean           86.09452
                                  Largest       Std. dev.       9.98552
          75%         92.5          117.6
          90%         99.5          119.8       Variance        99.7106
          95%          104          130.5       Skewness       .4643916
          99%        112.1          133.4       Kurtosis       3.275694

          . summ waistcircumference if gender_num==2, detail

                            waist circumference (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         72.5           64.8
           5%         76.8             65
          10%         79.7             67       Obs               4,106
          25%         85.7           67.7       Sum of wgt.       4,106

          50%         93.8                      Mean           94.06939
                                  Largest       Std. dev.      11.16478
          75%        101.6          133.4
          90%        108.6          135.6       Variance       124.6524
          95%        113.1          135.8       Skewness       .2949301
          99%        121.4          137.9       Kurtosis       2.855261

          . sum chestcircumference if gender_num==1, detail

                            chest circumference (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         78.4           69.5
           5%         82.4           72.6
          10%         84.5           73.7       Obs               1,990
          25%         88.8           75.7       Sum of wgt.       1,990

          50%           94                      Mean           94.68744
                                  Largest       Std. dev.      8.267867
          75%         99.9          121.4
          90%        105.7            122       Variance       68.35762
          95%        109.4          122.2       Skewness       .4234202
          99%        116.1          126.6       Kurtosis       3.116301

          . sum chestcircumference if gender_num==2, detail

                            chest circumference (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         87.3           77.4
           5%         92.2             81
          10%         94.8             82       Obs               4,106
          25%         99.6           82.6       Sum of wgt.       4,106

          50%        105.6                      Mean           105.8704
                                  Largest       Std. dev.      8.739721
          75%        111.7          135.8
          90%        117.2          137.2       Variance       76.38272
          95%        120.8          137.4       Skewness       .2329176
          99%        127.6          146.9       Kurtosis       2.948313

          . sum hipbreadth if gender_num==1, detail

                                hip breadth (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         29.3           27.6
           5%         31.1             28
          10%        32.05           28.4       Obs               1,990
          25%         33.6           28.4       Sum of wgt.       1,990

          50%         35.3                      Mean           35.38437
                                  Largest       Std. dev.      2.668518
          75%           37           44.8
          90%         38.7           45.7       Variance       7.120987
          95%           40             47       Skewness          .3262
          99%         42.3           47.3       Kurtosis       3.525435

          . sum hipbreadth if gender_num==2, detail

                                hip breadth (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         29.5           26.4
           5%         30.8           26.4
          10%         31.6           26.8       Obs               4,106
          25%           33           27.7       Sum of wgt.       4,106

          50%         34.4                      Mean           34.57691
                                  Largest       Std. dev.      2.415252
          75%         36.1           44.3
          90%         37.7           44.4       Variance        5.83344
          95%         38.7           44.8       Skewness       .3651308
          99%         40.8           45.2       Kurtosis       3.464464

          . sum bmi if gender_num==1, detail

                                 body mass index
          -------------------------------------------------------------
                Percentiles      Smallest
           1%     18.79469       16.36616
           5%     20.25888       16.52117
          10%     21.28893       17.16434       Obs               1,990
          25%     23.07696       17.71152       Sum of wgt.       1,990

          50%     25.26885                      Mean           25.73593
                                  Largest       Std. dev.      8.381623
          75%     27.61511       40.42726
          90%      29.9228         40.779       Variance       70.25161
          95%     31.79107       231.6867       Skewness       24.32398
          99%     35.15125       295.8996       Kurtosis       726.4435

          . sum bmi if gender_num==2, detail

                                 body mass index
          -------------------------------------------------------------
                Percentiles      Smallest
           1%      19.5227       15.35156
           5%     21.41939       17.46245
          10%     22.58641       17.70765       Obs               4,106
          25%      24.8826       17.91212       Sum of wgt.       4,106

          50%     27.49494                      Mean            28.8785
                                  Largest       Std. dev.      17.71654
          75%     30.35048       314.6784
          90%     33.08938       320.7723       Variance        313.876
          95%     35.00193       344.5361       Skewness       13.69209
          99%     39.62029       361.5917       Kurtosis       204.0818

          . generate body_type = .
          (6,097 missing values generated)

          . replace body_type = 1 if(gender_num==2 & waistcircumference<86) //ectomorph_m
          (1,060 real changes made)

          . replace body_type = 2 if(gender_num==1 & waistcircumference<79) //ectomorph_f
          (492 real changes made)

          . replace body_type = 3 if(gender_num==2 & (chestcircumference>100 & (bmi>25 & bmi<30)) | (bmi>25 & waistcircumference<100)) //mesomorph_m
          (2,943 real changes made)

          . replace body_type = 4 if(gender_num==1 & (chestcircumference>90 & (bmi>23 & bmi<27.5)) | (bmi>25 & waistcircumference<92)) //mesomorph_f
          (1,757 real changes made)

          . replace body_type = 5 if(gender_num==2 & (bmi>30 | (bmi>25 & waistcircumference>100))) //endomorph_m
          (1,411 real changes made)

          . replace body_type = 6 if(gender_num==1 & (bmi>27.5 | (bmi>25 & waistcircumference>92))) //endomorph_f
          (640 real changes made)

          . label define body_types 1 "ectomorph_m" 2 "ectomorph_f" 3 "mesomorph_m" 4 "mesomorph_f" 5 "endomorph_m" 6 "endomorph_f"

          . label values body_type body_types

          . label var body_type "body type based on anthropometrics"

          . tab bmiweight if body_type==.

           RECODE of bmi |
              (body mass |
                  index) |      Freq.     Percent        Cum.
          ---------------+-----------------------------------
          healthy weight |        481      100.00      100.00
          ---------------+-----------------------------------
                   Total |        481      100.00

          . replace body_type = 3 if(gender_num==2 & body_type==.) //mesomorph_m
          (246 real changes made)

          . replace body_type = 4 if(gender_num==1 & body_type==.) //mesomorph_f
          (235 real changes made)

          . summ chestcircumference, detail

                            chest circumference (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         80.7           69.5
           5%         86.1           72.6
          10%         89.3           73.7       Obs               6,096
          25%           95           75.7       Sum of wgt.       6,096

          50%        102.1                      Mean           102.2198
                                  Largest       Std. dev.      10.06248
          75%        109.2          135.8
          90%        115.3          137.2       Variance       101.2534
          95%        119.1          137.4       Skewness       .1328555
          99%          126          146.9       Kurtosis       2.769271

          . summ waistcircumference, detail

                            waist circumference (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         69.3           61.1
           5%         74.2           61.5
          10%         77.3             62       Obs               6,096
          25%         82.9           62.4       Sum of wgt.       6,096

          50%        90.75                      Mean           91.46604
                                  Largest       Std. dev.      11.42273
          75%         99.2          133.4
          90%        106.7          135.6       Variance       130.4788
          95%        111.2          135.8       Skewness       .3488408
          99%        119.4          137.9       Kurtosis       2.906995

          . summ hipbreadth, detail

                                hip breadth (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         29.4           26.4
           5%         30.9           26.4
          10%         31.7           26.8       Obs               6,096
          25%         33.2           27.6       Sum of wgt.       6,096

          50%         34.7                      Mean            34.8405
                                  Largest       Std. dev.      2.529038
          75%         36.4           45.2
          90%         38.1           45.7       Variance       6.396034
          95%         39.2             47       Skewness       .3840362
          99%         41.6           47.3       Kurtosis       3.526216

          . summ hipbreadthsitting, detail

                             seated hip breadth (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         31.8             28
           5%         33.6           28.8
          10%         34.6           29.1       Obs               6,096
          25%         36.4           29.5       Sum of wgt.       6,096

          50%         38.4                      Mean           38.57618
                                  Largest       Std. dev.        3.2417
          75%         40.6           51.8
          90%         42.8           53.3       Variance       10.50862
          95%         44.2           53.8       Skewness       .4206331
          99%         47.5           54.1       Kurtosis       3.433386

          . summ bicristalbreadth, detail

                             bicristal breadth (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         23.1           19.7
           5%         24.4           20.1
          10%         25.1           20.5       Obs               6,096
          25%         26.2           20.9       Sum of wgt.       6,096

          50%         27.4                      Mean            27.4749
                                  Largest       Std. dev.      1.921021
          75%         28.8           34.3
          90%         29.9           34.7       Variance        3.69032
          95%         30.6           35.6       Skewness       .1119331
          99%         32.4           36.2       Kurtosis       3.270123

          . summ stature, detail

                                  stature (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%        150.9          140.9
           5%        156.3          143.5
          10%        159.3          143.9       Obs               6,096
          25%        165.2          144.2       Sum of wgt.       6,096

          50%          172                      Mean           171.4554
                                  Largest       Std. dev.      9.003976
          75%        177.9          197.2
          90%        182.7          197.9       Variance       81.07159
          95%        185.5            198       Skewness      -.1062138
          99%        191.6          199.3       Kurtosis       2.691257

          . summ kneeheightmidpatella, detail

                          knee height, midpatella (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         40.1           34.6
           5%         42.2             35
          10%         43.4           35.6       Obs               6,096
          25%         45.2             36       Sum of wgt.       6,096

          50%         47.6                      Mean           47.55131
                                  Largest       Std. dev.      3.307387
          75%         49.7             59
          90%         51.8           59.4       Variance       10.93881
          95%         52.9           59.6       Skewness       .0482584
          99%         55.4           61.2       Kurtosis       2.956477

          . summ cervicaleheight, detail

                               cervial height (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%        128.7          118.4
           5%        133.4          120.8
          10%        136.4          120.9       Obs               6,096
          25%        141.8          121.8       Sum of wgt.       6,096

          50%        148.4                      Mean           147.7635
                                  Largest       Std. dev.      8.434605
          75%        153.7          171.7
          90%        158.3          171.8       Variance       71.14255
          95%        160.8          171.8       Skewness      -.1332813
          99%        166.1          173.8       Kurtosis       2.662845

          . summ trochanterionheight, detail

                            trochanterion height (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         76.3             66
           5%         79.6           67.7
          10%         81.5           69.6       Obs               6,096
          25%         84.5           69.8       Sum of wgt.       6,096

          50%         88.2                      Mean           88.27703
                                  Largest       Std. dev.      5.439398
          75%         91.8          108.1
          90%         95.3          108.3       Variance       29.58705
          95%         97.4            109       Skewness       .1498555
          99%        101.8          109.5       Kurtosis       3.102936

          . summ waistheightomphalion, detail

                          waist height (omphalion) (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         88.8           80.5
           5%         92.8           80.5
          10%         94.9           80.8       Obs               6,096
          25%         98.8           81.9       Sum of wgt.       6,096

          50%        103.3                      Mean           103.1595
                                  Largest       Std. dev.      6.270659
          75%        107.6          122.5
          90%        111.2          122.5       Variance       39.32117
          95%        113.3          124.2       Skewness      -.0308547
          99%        117.9          124.5       Kurtosis       2.856871

          . summ functionalleglength, detail

                           functional leg lenght (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         94.8           83.5
           5%         98.7           84.6
          10%        101.2           86.8       Obs               6,096
          25%        105.5           88.4       Sum of wgt.       6,096

          50%        110.4                      Mean           110.2129
                                  Largest       Std. dev.      6.855304
          75%        114.9          130.8
          90%        118.9          131.2       Variance       46.99519
          95%        121.3          131.6       Skewness       -.058745
          99%        125.8          131.6       Kurtosis       2.827685

          . summ footlength, detail

                                foot lenght (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         22.4           19.8
           5%         23.3             21
          10%         23.9           21.2       Obs               6,096
          25%         25.1           21.3       Sum of wgt.       6,096

          50%         26.4                      Mean           26.30541
                                  Largest       Std. dev.      1.738459
          75%         27.6           31.3
          90%         28.5           31.6       Variance       3.022241
          95%           29           31.8       Skewness       -.144512
          99%           30           32.3       Kurtosis       2.635256

          . summ thumbtipreach, detail

                               thumbtip reach (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         66.7           60.2
           5%         70.1           60.7
          10%         71.9           61.4       Obs               6,096
          25%         75.3           62.5       Sum of wgt.       6,096

          50%         79.2                      Mean           80.18279
                                  Largest       Std. dev.      30.29036
          75%         82.7            828
          90%         85.8            844       Variance       917.5061
          95%         87.7            914       Skewness       23.73268
          99%         91.8            934       Kurtosis       587.3257

          . summ span, detail

                                    span (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%        151.3          132.3
           5%        157.7          140.8
          10%        161.5          141.4       Obs               6,096
          25%        168.7          142.4       Sum of wgt.       6,096

          50%        177.1                      Mean           176.4021
                                  Largest       Std. dev.      11.08397
          75%        184.2          210.7
          90%        190.1          210.9       Variance       122.8543
          95%        193.8          211.1       Skewness      -.1091017
          99%        200.6          212.1       Kurtosis       2.769456

          . summ weightkg, detail

                              measured weight in kg
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         49.7           35.8
           5%         56.3           39.3
          10%         60.3             40       Obs               6,096
          25%        68.25           42.6       Sum of wgt.       6,096

          50%         78.6                      Mean           82.43975
                                  Largest       Std. dev.       48.5265
          75%         89.8            971
          90%        100.7            979       Variance       2354.821
          95%        108.1           1045       Skewness       14.66338
          99%        125.4           1099       Kurtosis       247.0037

          . replace suspect = 1 if hipbreadth < 30
          (112 real changes made)

          . tab thumbtipreach if thumbtipreach>92

                   thumbtip reach (cm) |      Freq.     Percent        Cum.
          -----------------------------+-----------------------------------
                                 92.20 |          2        3.77        3.77
                                 92.30 |          2        3.77        7.55
                                 92.50 |          2        3.77       11.32
                                 92.60 |          3        5.66       16.98
                                 92.70 |          3        5.66       22.64
                                 92.80 |          2        3.77       26.42
                                 92.90 |          3        5.66       32.08
                                 93.10 |          1        1.89       33.96
                                 93.20 |          2        3.77       37.74
                                 93.40 |          2        3.77       41.51
                                 93.60 |          1        1.89       43.40
                                 93.70 |          2        3.77       47.17
                                 93.80 |          1        1.89       49.06
                                 94.10 |          1        1.89       50.94
                                 94.30 |          1        1.89       52.83
                                 94.40 |          1        1.89       54.72
                                 94.50 |          1        1.89       56.60
                                 94.60 |          1        1.89       58.49
                                 94.80 |          1        1.89       60.38
                                 95.00 |          1        1.89       62.26
                                 95.30 |          1        1.89       64.15
                                 95.50 |          1        1.89       66.04
                                 95.80 |          1        1.89       67.92
                                 96.20 |          1        1.89       69.81
                                 96.30 |          1        1.89       71.70
                                 96.40 |          1        1.89       73.58
                                 96.70 |          1        1.89       75.47
                                 97.70 |          1        1.89       77.36
                                 97.90 |          1        1.89       79.25
                                 99.80 |          1        1.89       81.13
                                760.00 |          2        3.77       84.91
                                765.00 |          1        1.89       86.79
                                772.00 |          1        1.89       88.68
                                773.00 |          1        1.89       90.57
                                779.00 |          1        1.89       92.45
                                828.00 |          1        1.89       94.34
                                844.00 |          1        1.89       96.23
                                914.00 |          1        1.89       98.11
                                934.00 |          1        1.89      100.00
          -----------------------------+-----------------------------------
                                 Total |         53      100.00

          . replace suspect = 1 if thumbtipreach>100
          (11 real changes made)

          . tab weightkg if weightkg>150

                 measured weight in kg |      Freq.     Percent        Cum.
          -----------------------------+-----------------------------------
                                   601 |          1        4.55        4.55
                                   618 |          1        4.55        9.09
                                   664 |          1        4.55       13.64
                                   668 |          1        4.55       18.18
                                   700 |          1        4.55       22.73
                                   732 |          1        4.55       27.27
                                   760 |          1        4.55       31.82
                                   788 |          1        4.55       36.36
                                   804 |          1        4.55       40.91
                                   824 |          1        4.55       45.45
                                   838 |          1        4.55       50.00
                                   843 |          1        4.55       54.55
                                   855 |          1        4.55       59.09
                                   892 |          1        4.55       63.64
                                   895 |          1        4.55       68.18
                                   898 |          1        4.55       72.73
                                   918 |          1        4.55       77.27
                                   961 |          1        4.55       81.82
                                   971 |          1        4.55       86.36
                                   979 |          1        4.55       90.91
                                  1045 |          1        4.55       95.45
                                  1099 |          1        4.55      100.00
          -----------------------------+-----------------------------------
                                 Total |         22      100.00

          . replace suspect = 1 if weightkg>500 /*this one already handled with BMI*/
          (0 real changes made)

          . generate byhip = ((trochanterionheight/stature)*100)
          (1 missing value generated)

          . format byhip %9.2f

          . label var byhip "% of total height attributable to the height to hip"

          . graph box byhip, over(gender_num, label(labcolor("black"))) box(1, fcolor(gray) lcolor(black)) ytitle("% Height to Hip") title("Figure 3.1: % Height Attributable to Height-to-Hip, by Gender") scheme(s2mono)


          . pwcorr stature kneeheightmidpatella cervicaleheight trochanterionheight waistheightomphalion functionalleglength footlength thumbtipreach span, sig star(0.05) listwise

                       |  stature kneehe~a cervic~t trocha~t waisth~n functi~h footle~h
          -------------+---------------------------------------------------------------
               stature |   1.0000 
                       |
                       |
          kneeheight~a |   0.8892*  1.0000 
                       |   0.0000
                       |
          cervicaleh~t |   0.9912*  0.9028*  1.0000 
                       |   0.0000   0.0000
                       |
          trochanter~t |   0.8773*  0.9255*  0.8881*  1.0000 
                       |   0.0000   0.0000   0.0000
                       |
          waistheigh~n |   0.9368*  0.9133*  0.9414*  0.9120*  1.0000 
                       |   0.0000   0.0000   0.0000   0.0000
                       |
          functional~h |   0.8876*  0.8759*  0.9021*  0.8657*  0.8788*  1.0000 
                       |   0.0000   0.0000   0.0000   0.0000   0.0000
                       |
            footlength |   0.8446*  0.8075*  0.8501*  0.7696*  0.8068*  0.8002*  1.0000 
                       |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
                       |
          thumbtipre~h |   0.1630*  0.1427*  0.1669*  0.1481*  0.1537*  0.1622*  0.1421*
                       |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
                       |
                  span |   0.8989*  0.8730*  0.9080*  0.8595*  0.8837*  0.8720*  0.8627*
                       |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
                       |

                       | thumbt~h     span
          -------------+------------------
          thumbtipre~h |   1.0000 
                       |
                       |
                  span |   0.1738*  1.0000 
                       |   0.0000
                       |

          . twoway (scatter cervicaleheight stature), title("Figure 4.1: Correlation between Stature and Neck Height") scheme(s2mono)


          . pwcorr stature kneeheightmidpatella cervicaleheight trochanterionheight waistheightomphalion functionalleglength footlength thumbtipreach span if gender_num == 1, sig star(0.05)

                       |  stature kneehe~a cervic~t trocha~t waisth~n functi~h footle~h
          -------------+---------------------------------------------------------------
               stature |   1.0000 
                       |
                       |
          kneeheight~a |   0.8432*  1.0000 
                       |   0.0000
                       |
          cervicaleh~t |   0.9843*  0.8664*  1.0000 
                       |   0.0000   0.0000
                       |
          trochanter~t |   0.8577*  0.9165*  0.8785*  1.0000 
                       |   0.0000   0.0000   0.0000
                       |
          waistheigh~n |   0.9088*  0.8800*  0.9234*  0.8896*  1.0000 
                       |   0.0000   0.0000   0.0000   0.0000
                       |
          functional~h |   0.8320*  0.8336*  0.8495*  0.8484*  0.8290*  1.0000 
                       |   0.0000   0.0000   0.0000   0.0000   0.0000
                       |
            footlength |   0.7219*  0.7314*  0.7262*  0.7182*  0.7016*  0.7124*  1.0000 
                       |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
                       |
          thumbtipre~h |   0.1354*  0.1257*  0.1414*  0.1505*  0.1415*  0.1670*  0.1407*
                       |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
                       |
                  span |   0.8186*  0.8313*  0.8306*  0.8419*  0.8280*  0.8129*  0.7728*
                       |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
                       |

                       | thumbt~h     span
          -------------+------------------
          thumbtipre~h |   1.0000 
                       |
                       |
                  span |   0.1755*  1.0000 
                       |   0.0000
                       |

          . pwcorr stature kneeheightmidpatella cervicaleheight trochanterionheight waistheightomphalion functionalleglength footlength thumbtipreach span if gender_num == 2, sig star(0.05)

                       |  stature kneehe~a cervic~t trocha~t waisth~n functi~h footle~h
          -------------+---------------------------------------------------------------
               stature |   1.0000 
                       |
                       |
          kneeheight~a |   0.8331*  1.0000 
                       |   0.0000
                       |
          cervicaleh~t |   0.9842*  0.8569*  1.0000 
                       |   0.0000   0.0000
                       |
          trochanter~t |   0.8504*  0.8982*  0.8700*  1.0000 
                       |   0.0000   0.0000   0.0000
                       |
          waistheigh~n |   0.9087*  0.8700*  0.9160*  0.8847*  1.0000 
                       |   0.0000   0.0000   0.0000   0.0000
                       |
          functional~h |   0.8181*  0.8090*  0.8459*  0.8118*  0.8128*  1.0000 
                       |   0.0000   0.0000   0.0000   0.0000   0.0000
                       |
            footlength |   0.7176*  0.6924*  0.7248*  0.6762*  0.6933*  0.6610*  1.0000 
                       |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
                       |
          thumbtipre~h |   0.1100*  0.0855*  0.1151*  0.0934*  0.0973*  0.1022*  0.0709*
                       |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
                       |
                  span |   0.8233*  0.8001*  0.8390*  0.8139*  0.8186*  0.7897*  0.7491*
                       |   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
                       |

                       | thumbt~h     span
          -------------+------------------
          thumbtipre~h |   1.0000 
                       |
                       |
                  span |   0.1171*  1.0000 
                       |   0.0000
                       |

          . generate weightdiff = (weightlbs*0.453)-weightkg
          (1 missing value generated)

          . format weightdiff %9.2f

          . label var weightdiff "weight difference in kg (self-reported minus measured)"

          . graph box weightdiff if weightdiff > -40 & weightdiff < 40, box(1, fcolor(gray) lcolor(black)) ytitle("Weight Difference in kg") title("Figure 4.2-1: Difference in self-reported and measured weights, kg") note("Extreme outliers (>|40|kg) excluded for visualization") scheme(s2mono) 


          . graph box weightdiff if weightdiff > -40 & weightdiff < 40, over(gender_num, label(labcolor("black"))) box(1, fcolor(gray) lcolor(black)) ytitle("Weight Difference in kg") title("Figure 4.2-2: Difference in self-reported and measured weights, kg") note("Extreme outliers (>|40|kg) excluded for visualization") scheme(s2mono) 


          . generate heightdiff = (heightin*2.54)-stature
          (1 missing value generated)

          . format heightdiff %9.2f

          . label var heightdiff "height difference in cm (self-reported minus measured)"

          . graph box heightdiff if heightdiff > -20 & heightdiff < 20, over(gender_num, label(labcolor("black"))) box(1, fcolor(gray) lcolor(black)) ytitle("Height Difference in cm") title("Figure 4.2-3: Difference in self-reported and measured heights, cm") note("Extreme outliers (>|20|cm) excluded for visualization") scheme(s2mono) 


          . summ heightin, detail

                         self-reported height in inches
          -------------------------------------------------------------
                Percentiles      Smallest
           1%           60             56
           5%           62             56
          10%           63             56       Obs               6,097
          25%           66             57       Sum of wgt.       6,097

          50%           68                      Mean            68.2639
                                  Largest       Std. dev.      3.862685
          75%           71             81
          90%           73             86       Variance       14.92034
          95%           74             87       Skewness      -.0157806
          99%           77             94       Kurtosis       3.084434

          . summ weightlb, detail

                         self-reported weight in pounds
          -------------------------------------------------------------
                Percentiles      Smallest
           1%          110              0
           5%          125             86
          10%          133             88       Obs               6,097
          25%          150             90       Sum of wgt.       6,097

          50%          173                      Mean           174.7992
                                  Largest       Std. dev.      33.68422
          75%          196            310
          90%          220            310       Variance       1134.626
          95%          235            315       Skewness       .3845383
          99%          260            321       Kurtosis        3.17105

          . replace suspect = 1 if weightlb==0
          (1 real change made)

          . summ stature, detail

                                  stature (cm)
          -------------------------------------------------------------
                Percentiles      Smallest
           1%        150.9          140.9
           5%        156.3          143.5
          10%        159.3          143.9       Obs               6,096
          25%        165.2          144.2       Sum of wgt.       6,096

          50%          172                      Mean           171.4554
                                  Largest       Std. dev.      9.003976
          75%        177.9          197.2
          90%        182.7          197.9       Variance       81.07159
          95%        185.5            198       Skewness      -.1062138
          99%        191.6          199.3       Kurtosis       2.691257

          . summ weightkg, detail /*issue with measured weight for some observations*/

                              measured weight in kg
          -------------------------------------------------------------
                Percentiles      Smallest
           1%         49.7           35.8
           5%         56.3           39.3
          10%         60.3             40       Obs               6,096
          25%        68.25           42.6       Sum of wgt.       6,096

          50%         78.6                      Mean           82.43975
                                  Largest       Std. dev.       48.5265
          75%         89.8            971
          90%        100.7            979       Variance       2354.821
          95%        108.1           1045       Skewness       14.66338
          99%        125.4           1099       Kurtosis       247.0037

          . tab weightkg if weightkg>125

                 measured weight in kg |      Freq.     Percent        Cum.
          -----------------------------+-----------------------------------
                                 125.1 |          1        1.59        1.59
                                 125.3 |          1        1.59        3.17
                                 125.4 |          1        1.59        4.76
                                 125.6 |          1        1.59        6.35
                                 125.8 |          2        3.17        9.52
                                   126 |          1        1.59       11.11
                                 126.2 |          2        3.17       14.29
                                 126.3 |          1        1.59       15.87
                                 126.4 |          1        1.59       17.46
                                 126.5 |          1        1.59       19.05
                                 126.6 |          1        1.59       20.63
                                 126.8 |          1        1.59       22.22
                                 127.1 |          1        1.59       23.81
                                 127.3 |          1        1.59       25.40
                                 127.4 |          1        1.59       26.98
                                 127.8 |          1        1.59       28.57
                                 128.5 |          1        1.59       30.16
                                 128.7 |          1        1.59       31.75
                                 129.2 |          1        1.59       33.33
                                 129.8 |          1        1.59       34.92
                                 130.1 |          1        1.59       36.51
                                 130.2 |          1        1.59       38.10
                                 130.7 |          1        1.59       39.68
                                 131.2 |          1        1.59       41.27
                                 132.5 |          1        1.59       42.86
                                 132.9 |          1        1.59       44.44
                                 133.6 |          1        1.59       46.03
                                 133.7 |          1        1.59       47.62
                                 134.4 |          1        1.59       49.21
                                 134.5 |          1        1.59       50.79
                                 134.6 |          1        1.59       52.38
                                 135.4 |          1        1.59       53.97
                                 136.9 |          1        1.59       55.56
                                 137.1 |          1        1.59       57.14
                                 137.5 |          1        1.59       58.73
                                   140 |          1        1.59       60.32
                                 141.3 |          1        1.59       61.90
                                 142.9 |          1        1.59       63.49
                                 144.2 |          1        1.59       65.08
                                   601 |          1        1.59       66.67
                                   618 |          1        1.59       68.25
                                   664 |          1        1.59       69.84
                                   668 |          1        1.59       71.43
                                   700 |          1        1.59       73.02
                                   732 |          1        1.59       74.60
                                   760 |          1        1.59       76.19
                                   788 |          1        1.59       77.78
                                   804 |          1        1.59       79.37
                                   824 |          1        1.59       80.95
                                   838 |          1        1.59       82.54
                                   843 |          1        1.59       84.13
                                   855 |          1        1.59       85.71
                                   892 |          1        1.59       87.30
                                   895 |          1        1.59       88.89
                                   898 |          1        1.59       90.48
                                   918 |          1        1.59       92.06
                                   961 |          1        1.59       93.65
                                   971 |          1        1.59       95.24
                                   979 |          1        1.59       96.83
                                  1045 |          1        1.59       98.41
                                  1099 |          1        1.59      100.00
          -----------------------------+-----------------------------------
                                 Total |         63      100.00

          . tab weightkg if weightkg>500

                 measured weight in kg |      Freq.     Percent        Cum.
          -----------------------------+-----------------------------------
                                   601 |          1        4.55        4.55
                                   618 |          1        4.55        9.09
                                   664 |          1        4.55       13.64
                                   668 |          1        4.55       18.18
                                   700 |          1        4.55       22.73
                                   732 |          1        4.55       27.27
                                   760 |          1        4.55       31.82
                                   788 |          1        4.55       36.36
                                   804 |          1        4.55       40.91
                                   824 |          1        4.55       45.45
                                   838 |          1        4.55       50.00
                                   843 |          1        4.55       54.55
                                   855 |          1        4.55       59.09
                                   892 |          1        4.55       63.64
                                   895 |          1        4.55       68.18
                                   898 |          1        4.55       72.73
                                   918 |          1        4.55       77.27
                                   961 |          1        4.55       81.82
                                   971 |          1        4.55       86.36
                                   979 |          1        4.55       90.91
                                  1045 |          1        4.55       95.45
                                  1099 |          1        4.55      100.00
          -----------------------------+-----------------------------------
                                 Total |         22      100.00

          . tab bmiweight body_type if gender_num==1

           RECODE of bmi |        body type based on
              (body mass |         anthropometrics
                  index) | ectomorph  mesomorph  endomorph |     Total
          ---------------+---------------------------------+----------
             underweight |        13          0          0 |        13 
          healthy weight |       411        525          0 |       936 
              overweight |         0        401        448 |       849 
                   obese |         0          0        190 |       190 
                 missing |         0          0          2 |         2 
          ---------------+---------------------------------+----------
                   Total |       424        926        640 |     1,990 

          . tab bmiweight body_type if gender_num==2

           RECODE of bmi |
              (body mass |     body type based on anthropometrics
                  index) | ectomorph  mesomorph  mesomorph  endomorph |     Total
          ---------------+--------------------------------------------+----------
             underweight |         9          0          0          0 |         9 
          healthy weight |       817        246          0          0 |     1,063 
              overweight |         0        827        797        280 |     1,904 
                   obese |         0          0          0      1,110 |     1,110 
                 missing |         0          0          0         21 |        21 
          ---------------+--------------------------------------------+----------
                   Total |       826      1,073        797      1,411 |     4,107 



