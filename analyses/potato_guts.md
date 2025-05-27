BLH Gut Diversity in Potato
================
Riley M. Anderson
May 27, 2025

  

- [Overview](#overview)
  - [Summary of Results](#summary-of-results)
- [BCTV by richness](#bctv-by-richness)
- [CPt by richness](#cpt-by-richness)
- [Proportion plants infected](#proportion-plants-infected)
- [Plants in the gut over time](#plants-in-the-gut-over-time)
  - [Crops by time](#crops-by-time)
  - [Non-crops by time](#non-crops-by-time)
  - [Trees by time](#trees-by-time)
    - [Gut contents by sample date](#gut-contents-by-sample-date)
    - [One figure for both NMDS](#one-figure-for-both-nmds)
    - [Genus by year](#genus-by-year)
  - [Session Information](#session-information)

## Overview

What is this analysis about?

### Summary of Results

- 

# BCTV by richness

    ##  Family: binomial  ( logit )
    ## Formula:          BCTV ~ richness + (1 | region)
    ## Data: richness
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##    263.3    273.6   -128.7    257.3      225 
    ## 
    ## Random effects:
    ## 
    ## Conditional model:
    ##  Groups Name        Variance Std.Dev.
    ##  region (Intercept) 0.5871   0.7662  
    ## Number of obs: 228, groups:  region, 5
    ## 
    ## Conditional model:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -0.04784    0.45048  -0.106 0.915427    
    ## richness    -0.16319    0.04923  -3.315 0.000916 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

![](potato_guts_files/figure-gfm/bctv_richness-1.png)<!-- -->

- Simple models show a robust effect of gut species richness on BCTV
  infection
  (![\beta](https://latex.codecogs.com/png.latex?%5Cbeta "\beta") =
  -0.16, SE = 0.05, *P* \< 0.001, AIC = 263.35. This effect is
  independent of region. That is, each region has varying levels of BCTV
  infection, but the effect of richness does not vary by region.

- However, there may be an effect of **year** on the variation in BCTV.
  In the plot above, the raw data are shown and colored by year with
  2019 in yellow, 2020 in blue, and 2021 in purple. Let’s have a
  detailed look below:

<!-- -->

    ##  Family: binomial  ( logit )
    ## Formula:          BCTV ~ Year + (1 | region)
    ## Data: richness
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##    246.1    259.9   -119.1    238.1      224 
    ## 
    ## Random effects:
    ## 
    ## Conditional model:
    ##  Groups Name        Variance Std.Dev.
    ##  region (Intercept) 0.9713   0.9856  
    ## Number of obs: 228, groups:  region, 5
    ## 
    ## Conditional model:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)  -2.9916     0.6787  -4.408 1.04e-05 ***
    ## Year2020      2.5697     0.5494   4.678 2.90e-06 ***
    ## Year2021      2.6392     0.6583   4.009 6.10e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

![](potato_guts_files/figure-gfm/bctv_year-1.png)<!-- -->

- Okay, so 2019 had much lower levels of BCTV, relative to 2020
  and 2021. Moreover, **year** is a better predictor of BCTV than
  **richness** (AIC = 246.15)

- Did gut species richness also vary across years? Let’s find out:

<!-- -->

    ## Overdispersion ratio for model: richness_mod1 
    ## formula: richness ~ Year + (1 | region) 
    ## 
    ## Acceptable range: 1 - 1.4
    ## Overdispersion ratio: 1.016  df: 223  p = 0.421 
    ##  Data are not overdispersed
    ##    ratio deviance       df   pvalue 
    ##   1.0160 226.5496 223.0000   0.4210
    ##  Family: nbinom2  ( log )
    ## Formula:          richness ~ Year + (1 | region)
    ## Data: richness
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##   1117.2   1134.4   -553.6   1107.2      223 
    ## 
    ## Random effects:
    ## 
    ## Conditional model:
    ##  Groups Name        Variance  Std.Dev. 
    ##  region (Intercept) 2.398e-10 1.548e-05
    ## Number of obs: 228, groups:  region, 5
    ## 
    ## Dispersion parameter for nbinom2 family (): 8.46 
    ## 
    ## Conditional model:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)  2.19026    0.05996   36.53  < 2e-16 ***
    ## Year2020    -0.51025    0.08288   -6.16 7.44e-10 ***
    ## Year2021    -1.01486    0.09801  -10.35  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

![](potato_guts_files/figure-gfm/richness_year-1.png)<!-- -->

- Yes, gut species richness varies significantly across years, with
  richness declining over time. This evidence suggests that **richness**
  and **year** are both important predictors of BCTV. Is this because
  they are collinear? Or do they each contribute to model fit?

- This is not the same as a statistical interaction. When two
  independent variables are collinear, we may be fooled into thinking
  one is significant when in reality, its significance comes from its
  proxy as the other.

- Test for collinearity and model fit with AIC:

<!-- -->

    ##             (Intercept)   richness      nYear
    ## (Intercept)   1.0000000 -0.4217605 -0.9999997
    ## richness     -0.4217605  1.0000000  0.4214301
    ## nYear        -0.9999997  0.4214301  1.0000000
    ##  Family: binomial  ( logit )
    ## Formula:          BCTV ~ richness + nYear + (1 | region)
    ## Data: richness
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##    256.0    269.7   -124.0    248.0      224 
    ## 
    ## Random effects:
    ## 
    ## Conditional model:
    ##  Groups Name        Variance Std.Dev.
    ##  region (Intercept) 1.033    1.016   
    ## Number of obs: 228, groups:  region, 5
    ## 
    ## Conditional model:
    ##               Estimate Std. Error z value Pr(>|z|)   
    ## (Intercept) -1.899e+03  6.584e+02  -2.885  0.00392 **
    ## richness    -8.811e-02  5.439e-02  -1.620  0.10525   
    ## nYear        9.400e-01  3.259e-01   2.885  0.00392 **
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

![](potato_guts_files/figure-gfm/bctv_richness_and_year-1.png)<!-- -->

- Correlation between **year** and **richness** is weak (*r* = 0.42), so
  no collinearity. However, including **year** in the model loses the
  **richness** effect.

- We’ve now fit three versions of models to predict BCTV. Lets compare
  with AIC and decide which model to use:

``` r

AIC(bctv_mod1, bctv_mod2, bctv_mod3)
##           df      AIC
## bctv_mod1  3 263.3452
## bctv_mod2  4 246.1459
## bctv_mod3  4 255.9598
```

- Model selection with AIC suggests the model with **year** alone is the
  best predictor.

- This means that our evidence of the dilution effect in BCTV is weak.
  Probably should not make this the main point of the paper.

# CPt by richness

    ##  Family: binomial  ( logit )
    ## Formula:          CPt ~ richness + Year + (1 | region)
    ## Data: richness
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##    278.1    295.3   -134.1    268.1      223 
    ## 
    ## Random effects:
    ## 
    ## Conditional model:
    ##  Groups Name        Variance Std.Dev.
    ##  region (Intercept) 0.08371  0.2893  
    ## Number of obs: 228, groups:  region, 5
    ## 
    ## Conditional model:
    ##             Estimate Std. Error z value Pr(>|z|)  
    ## (Intercept) -0.78833    0.53405  -1.476   0.1399  
    ## richness    -0.02993    0.04516  -0.663   0.5075  
    ## Year2020     0.79665    0.42428   1.878   0.0604 .
    ## Year2021    -0.55283    0.64374  -0.859   0.3905  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

![](potato_guts_files/figure-gfm/CPt_richness_year_fig-1.png)<!-- -->

- Both **richness** and **year** have no effect on CPt infection (*P* \>
  0.5).

# Proportion plants infected

![](potato_guts_files/figure-gfm/plant_inf_props-1.png)<!-- -->

![](potato_guts_files/figure-gfm/prop_infected_fig-1.png)<!-- -->

![](potato_guts_files/figure-gfm/prop_infected_all_fig-1.png)<!-- -->

![](potato_guts_files/figure-gfm/prop_infected_distribution-1.png)<!-- -->

    ## Analysis of Variance Table
    ## 
    ## Response: n
    ##                   Df Sum Sq Mean Sq  F value Pr(>F)    
    ## status             3 99.808  33.269 148.6013 <2e-16 ***
    ## crop_type          2  0.000   0.000   0.0000  1.000    
    ## status:crop_type   6  1.196   0.199   0.8906  0.504    
    ## Residuals        128 28.657   0.224                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Call:
    ## lm(formula = n ~ status * crop_type, data = inf_stat_data, weights = total)
    ## 
    ## Weighted Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.97774 -0.25395 -0.09989  0.21430  1.48012 
    ## 
    ## Coefficients:
    ##                                   Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)                       0.534456   0.018516  28.864   <2e-16 ***
    ## statusBCTV                       -0.404288   0.026186 -15.439   <2e-16 ***
    ## statusCPt                        -0.321593   0.026186 -12.281   <2e-16 ***
    ## statusCo-infected                -0.411945   0.026186 -15.731   <2e-16 ***
    ## crop_typeCrops                    0.001907   0.048766   0.039   0.9689    
    ## crop_typeTrees                    0.107335   0.060699   1.768   0.0794 .  
    ## statusBCTV:crop_typeCrops         0.013379   0.068966   0.194   0.8465    
    ## statusCPt:crop_typeCrops          0.021593   0.068966   0.313   0.7547    
    ## statusCo-infected:crop_typeCrops -0.042601   0.068966  -0.618   0.5379    
    ## statusBCTV:crop_typeTrees        -0.133026   0.085842  -1.550   0.1237    
    ## statusCPt:crop_typeTrees         -0.156019   0.085842  -1.818   0.0715 .  
    ## statusCo-infected:crop_typeTrees -0.140294   0.085842  -1.634   0.1046    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4732 on 128 degrees of freedom
    ## Multiple R-squared:  0.779,  Adjusted R-squared:   0.76 
    ## F-statistic: 41.01 on 11 and 128 DF,  p-value: < 2.2e-16

![](potato_guts_files/figure-gfm/prop_infected_stats-1.png)<!-- -->

    ## [[1]]

![](potato_guts_files/figure-gfm/prop_infected_stats-2.png)<!-- -->

    ## 
    ## [[2]]

![](potato_guts_files/figure-gfm/prop_infected_stats-3.png)<!-- -->

    ## 
    ## [[3]]

![](potato_guts_files/figure-gfm/prop_infected_stats-4.png)<!-- -->

    ## 
    ## [[4]]

![](potato_guts_files/figure-gfm/prop_infected_stats-5.png)<!-- -->

# Plants in the gut over time

## Crops by time

## Non-crops by time

## Trees by time

![](potato_guts_files/figure-gfm/ridgeplot_one_figure-1.png)<!-- -->

    ## Run 0 stress 0.1309904 
    ## Run 1 stress 0.1310302 
    ## ... Procrustes: rmse 0.00532567  max resid 0.06308665 
    ## Run 2 stress 0.1313773 
    ## ... Procrustes: rmse 0.01434485  max resid 0.1761882 
    ## Run 3 stress 0.1319975 
    ## Run 4 stress 0.1313632 
    ## ... Procrustes: rmse 0.01499318  max resid 0.1762227 
    ## Run 5 stress 0.1325809 
    ## Run 6 stress 0.1311989 
    ## ... Procrustes: rmse 0.005518641  max resid 0.06042408 
    ## Run 7 stress 0.1309889 
    ## ... New best solution
    ## ... Procrustes: rmse 0.0003727393  max resid 0.00328345 
    ## ... Similar to previous best
    ## Run 8 stress 0.1310094 
    ## ... Procrustes: rmse 0.002982306  max resid 0.03895269 
    ## Run 9 stress 0.1326548 
    ## Run 10 stress 0.1339058 
    ## Run 11 stress 0.1311069 
    ## ... Procrustes: rmse 0.002480452  max resid 0.03555698 
    ## Run 12 stress 0.1309218 
    ## ... New best solution
    ## ... Procrustes: rmse 0.006178661  max resid 0.08459303 
    ## Run 13 stress 0.1309218 
    ## ... Procrustes: rmse 0.0003609704  max resid 0.002709652 
    ## ... Similar to previous best
    ## Run 14 stress 0.1315687 
    ## Run 15 stress 0.1312189 
    ## ... Procrustes: rmse 0.009949781  max resid 0.08173589 
    ## Run 16 stress 0.1331063 
    ## Run 17 stress 0.1341411 
    ## Run 18 stress 0.132696 
    ## Run 19 stress 0.1311407 
    ## ... Procrustes: rmse 0.01463112  max resid 0.2044815 
    ## Run 20 stress 0.1310285 
    ## ... Procrustes: rmse 0.008182429  max resid 0.08599073 
    ## *** Best solution repeated 1 times
    ## [1] 0.1309218

![](potato_guts_files/figure-gfm/nmds-1.png)<!-- -->![](potato_guts_files/figure-gfm/nmds-2.png)<!-- -->

    ## 
    ## ***VECTORS
    ## 
    ##                NMDS1    NMDS2    NMDS3     r2 Pr(>r)    
    ## sample_date -0.95408  0.18006  0.23941 0.1949  0.001 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## Blocks:  strata 
    ## Permutation: free
    ## Number of permutations: 999
    ## 
    ## ***FACTORS:
    ## 
    ## Centroids:
    ##                   NMDS1   NMDS2   NMDS3
    ## regionMattawa   -0.3454  0.0944  0.0411
    ## regionMoxee      0.3262 -0.0953 -0.0230
    ## regionOthello   -0.1154 -0.2724  0.2980
    ## regionPasco      0.1489  0.0585 -0.0588
    ## regionPaterson  -0.2275  0.0909 -0.1517
    ## healthyInfected -0.0775 -0.0465  0.0370
    ## healthyHealthy   0.0768  0.0461 -0.0367
    ## Year2019        -0.3961  0.2710 -0.1513
    ## Year2020        -0.1789 -0.1184  0.1055
    ## Year2021         0.5999 -0.0905 -0.0018
    ## 
    ## Goodness of fit:
    ##             r2 Pr(>r)    
    ## region  0.1371  0.001 ***
    ## healthy 0.0136  0.047 *  
    ## Year    0.2997  0.001 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## Blocks:  strata 
    ## Permutation: free
    ## Number of permutations: 999
    ## 
    ## Family: gaussian 
    ## Link function: identity 
    ## 
    ## Formula:
    ## log(sample_date) ~ s(NMDS1, NMDS2, k = 5)
    ## 
    ## Parametric coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  5.00491    0.05905   84.75   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Approximate significance of smooth terms:
    ##                  edf Ref.df     F  p-value    
    ## s(NMDS1,NMDS2) 3.391  3.391 8.709 1.16e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## R-sq.(adj) =  0.186   
    ## lmer.REML = -92.676  Scale est. = 0.03291   n = 227

![](potato_guts_files/figure-gfm/nmds-3.png)<!-- -->

    ## Permutation test for adonis under reduced model
    ## Terms added sequentially (first to last)
    ## Blocks:  strata 
    ## Permutation: free
    ## Number of permutations: 999
    ## 
    ## adonis2(formula = gut_mat_species ~ splines::ns(sample_date, df = 5) + BCTV * Year + region, data = gut_matrix, strata = gut_matrix$host_plant)
    ##                                   Df SumOfSqs      R2       F Pr(>F)    
    ## splines::ns(sample_date, df = 5)   5    9.465 0.16009 10.1979  0.001 ***
    ## BCTV                               1    0.633 0.01071  3.4099  0.006 ** 
    ## Year                               2    8.042 0.13602 21.6611  0.001 ***
    ## region                             4    1.008 0.01705  1.3578  0.420    
    ## BCTV:Year                          2    0.622 0.01052  1.6754  0.210    
    ## Residual                         212   39.354 0.66561                   
    ## Total                            226   59.125 1.00000                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### Gut contents by sample date

### One figure for both NMDS

![](potato_guts_files/figure-gfm/NMDS_A_and_B-1.png)<!-- -->

### Genus by year

![](potato_guts_files/figure-gfm/gut_sample_date_year_fig-1.png)<!-- -->

## Session Information

    R version 4.2.3 (2023-03-15 ucrt)
    Platform: x86_64-w64-mingw32/x64 (64-bit)
    Running under: Windows 10 x64 (build 19045)

    Matrix products: default

    locale:
    [1] LC_COLLATE=English_United States.utf8 
    [2] LC_CTYPE=English_United States.utf8   
    [3] LC_MONETARY=English_United States.utf8
    [4] LC_NUMERIC=C                          
    [5] LC_TIME=English_United States.utf8    

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base     

    other attached packages:
     [1] gamm4_0.2-6        mgcv_1.8-42        nlme_3.1-162       lme4_1.1-35.3     
     [5] Matrix_1.5-3       knitr_1.47         ggridges_0.5.6     yardstick_1.3.1   
     [9] workflowsets_1.1.0 workflows_1.1.4    tune_1.2.1         rsample_1.2.1     
    [13] recipes_1.0.10     parsnip_1.2.1      modeldata_1.3.0    infer_1.0.7       
    [17] dials_1.2.1        scales_1.3.0       broom_1.0.6        tidymodels_1.2.0  
    [21] sjPlot_2.8.16      glmmTMB_1.1.9      emmeans_1.10.2     vegan_2.6-6.1     
    [25] lattice_0.20-45    permute_0.9-7      cowplot_1.1.3      lubridate_1.9.3   
    [29] forcats_1.0.0      stringr_1.5.1      dplyr_1.1.4        purrr_1.0.2       
    [33] readr_2.1.5        tidyr_1.3.1        tibble_3.2.1       ggplot2_3.5.1     
    [37] tidyverse_2.0.0   

    loaded via a namespace (and not attached):
     [1] TH.data_1.1-2       minqa_1.2.7         colorspace_2.1-0   
     [4] class_7.3-21        sjlabelled_1.2.0    rprojroot_2.0.4    
     [7] estimability_1.5.1  rstudioapi_0.16.0   farver_2.1.2       
    [10] furrr_0.3.1         listenv_0.9.1       prodlim_2023.08.28 
    [13] fansi_1.0.6         mvtnorm_1.2-5       codetools_0.2-19   
    [16] splines_4.2.3       sjmisc_2.8.10       nloptr_2.0.3       
    [19] ggeffects_1.6.0     cluster_2.1.4       compiler_4.2.3     
    [22] sjstats_0.19.0      backports_1.5.0     fastmap_1.2.0      
    [25] cli_3.6.2           htmltools_0.5.8.1   tools_4.2.3        
    [28] coda_0.19-4.1       gtable_0.3.5        glue_1.7.0         
    [31] Rcpp_1.0.12         DiceDesign_1.10     vctrs_0.6.5        
    [34] iterators_1.0.14    insight_1.0.1       timeDate_4032.109  
    [37] xfun_0.44           gower_1.0.1         globals_0.16.3     
    [40] timechange_0.3.0    lifecycle_1.0.4     future_1.33.2      
    [43] MASS_7.3-58.2       zoo_1.8-12          ipred_0.9-14       
    [46] hms_1.1.3           parallel_4.2.3      sandwich_3.1-0     
    [49] TMB_1.9.11          yaml_2.3.8          rpart_4.1.23       
    [52] stringi_1.8.4       highr_0.11          foreach_1.5.2      
    [55] lhs_1.1.6           hardhat_1.4.0       boot_1.3-28.1      
    [58] lava_1.8.0          rlang_1.1.4         pkgconfig_2.0.3    
    [61] evaluate_0.24.0     labeling_0.4.3      tidyselect_1.2.1   
    [64] parallelly_1.37.1   magrittr_2.0.3      R6_2.5.1           
    [67] generics_0.1.3      multcomp_1.4-25     pillar_1.9.0       
    [70] withr_3.0.0         survival_3.5-3      datawizard_0.11.0  
    [73] nnet_7.3-18         future.apply_1.11.2 performance_0.12.0 
    [76] utf8_1.2.4          tzdb_0.4.0          rmarkdown_2.27     
    [79] grid_4.2.3          data.table_1.15.4   digest_0.6.35      
    [82] xtable_1.8-4        numDeriv_2016.8-1.1 GPfit_1.0-8        
    [85] munsell_0.5.1       viridisLite_0.4.2  
