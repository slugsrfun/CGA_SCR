# CGA_BlackBears
Data analyses for central GA black bear SCR / PopGen project at UGA

## Directory Structure


+ `/PDFs/` - markdowns for all analyses
+ `/setup/` - code to create a virtual environment for data analysis
    + `0_build_ve.sh` - script used (interactively) to build the virtual environment for analyses that follow
        + `veGAbears_pkglist.txt` - explicit list of packages installed in creation of the virtual environment `veGAbears`
    + `/data/jax_bbear/` - folder with reference genome information for SNP annotation in  [`snpEff`](https://pcingola.github.io/SnpEff/) ([Cingolani et al. 2012](http://dx.doi.org/10.4161/fly.19695)), downloaded from [NCBI](https://www.ncbi.nlm.nih.gov/datasets/taxonomy/9643/)
        + `sequences.fa` - the reference genome in FASTA format ("Genome sequences" from [NCBI download](https://www.ncbi.nlm.nih.gov/datasets/taxonomy/9643/))
        + `genes.gtf` - annotation information in GTF format ("Annotation features (GTF)" from [NCBI download](https://www.ncbi.nlm.nih.gov/datasets/taxonomy/9643/))
+ `/input/` - variety of files needed as input in analysis scripts
    + `CGA_info.txt` & `CGA_option.txt` - input files for `NeEstimator` (see `21_effectiveSize`)
    + `CGAmortalities.csv` - DNR records on mortality due to legal harvest, illegal take, and roadkill in the central GA black bear population
    + `Clearcut` - polygon of Southern Timber clearcut boundaries (shapefile format) for solar farm project (2023-2024) 
    + `colonydat_create2.R` - modified version of function to create `COLONY` input files, from [Ellie Weise's GitHub](https://github.com/weiseell/NbdLamprey/blob/master/Homebrew/colonydat_create.R)
    + `Finalized Hair Samples w Metadata_Carr` - information on the locations (hair snares), weeks, and years where samples were collected along with sample IDs (both `.csv` and `.xlsx` versions)
    + `forc-h0.gzip` - forecasted abundance from PVA simulations under status quo harvest, created during `24_assessPVA`
    + `forc-h5.gzip` - forecasted abundance from PVA simulations with 5 additional female mortalities, created during `24_assessPVA`
    + `forc-h10.gzip` - forecasted abundance from PVA simulations with 10 additional female mortalities, created during `24_assessPVA`
    + `GTSeek_rd#_Metadata.csv` - four files of metadata for samples submitted to GTSeek (samples were submitted in four batches - `rd1`, `rd2`, `rd3`, and `rd4` in the filename)
    + `Hair Snare Summaries (Both Years)` - separate tabs with 2023 and 2024 hair snares, locations, dates checked, etc. converted to separate `.csv` files for analyses
        + `HS23_coords.csv` - hair snare IDs, landowners, GPS coordinates, and dates installed and baited for snares in 2023
        + `HS24_coords.csv` - hair snare IDs, landowners, GPS coordinates, and dates installed and baited for snares in 2024
    + `HookerModel-noDensDep.jag` - `JAGS` model from [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887) without density-dependent recruitment, modified from code hosted on [Richard Chandler's GitHub](https://github.com/rbchan/ga-bear-pva/blob/master/R/dT-s0-rPDD2-phi0-pYB-sig0.jag)
    + `HookerModel-noDensDep_move.jag` - `JAGS` model above, with the addition of activity center movement between primary sampling periods (years)
    + `HookerModel-noDensDep_bothSexes2.jag` - `JAGS` model above, without movement of activity centers and modeling both sexes in the same analysis (two separate capture history objects)
    + `makeCH.R` - function to build a capture history from clone ID information (used in `makeCapHist` below)
    + `SCR0.jag` - `JAGS` model code for a simple closed population, single season model 
    + `spatial_covariates` - folder with USDA Cropland data layers for 2023 and 2024, saved as `.tif` files
        + `CropScape_2023_TotalForest.tif` - forest cover in 2023, 30x30m resolution, from UDSA Cropland Data
        + `CropScape_2024_TotalForest.tif` - forest cover in 2024, 30x30m resolution, from UDSA Cropland Data
        + `DistInv_Agriculture_2023.tif` - distance to agricultural fields in 2023, 30x30m resolution, from UDSA Cropland Data
        + `DistInv_Agriculture_2024.tif` - distance to agricultural fields in 2024, 30x30m resolution, from UDSA Cropland Data
    + `state-space360.tif` - state space as defined by [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887), raster saved in `.tif` format
    + `sumstats_4d.R` - functions to calculate summary statistics from 3-d and 4-d capture history arrays (based on a function from Andy Royle's [`scrbook` R package](https://github.com/jaroyle/scrbook))
    + `tl_2019_13_prisecroads` - Primary and secondary road shapefile (GA) downloaded from https://catalog.data.gov/dataset/tiger-line-shapefile-2019-state-georgia-primary-and-secondary-roads-state-based-shapefile
    + `UGA_bbh_Prod1_all_Genotypes.csv` - genetic data for samples submitted for GT-seq genotyping at GTSeek
    + `UGA_173101_Summary_Sheet.csv` - information on the Rapid Genomics ID, corresponding fastq file, and original customer code, used to match `rgID` to `ugaID`
+ `/sampleinfo/` - information about the bears, samples, and the state space
    + `1_snareLocations` - Create objects with information about the hair snares used in the study
    + `2_compileMetadata` - Build the basic metadata file, will be added to in steps that follow
    + `9_sexSamples` - Assign sexes to individual samples based on SNPs on the Y-chromosome
+ `/snpfiltering/` - steps involved in filtering capture-seq and GT-seq data for recapture / population genetic analyses
    + `3_filterSCR` - Apply filters for spatial capture-recapture analyses
        + `LGC_SCR.vcf` - filtered VCF for recapture analysis, prior to incorporating GTSeek samples
    + `4_combineGTSeek` - Combine markers from filterSCR above with SNPs genotyped by GTSeek
        + `finalSCR.recode.vcf` - filtered VCF for recapture analysis, after incorporating GTSeek samples
    + `18_filterPopGen` - Apply initial filters for population genetic analyses, remove duplicated genotypes
        + `PopGen.vcf` - filtered VCF for population genetic analysis
+ `/recaps/` - identifying and mapping recaptures
    + `6_format4COLONY` - create `COLONY` input files
    + `7_runCOLONY` - run a "clone analysis" in `COLONY`
        + `CGA.*` - outputs from `COLONY` run - the `COLONY2` manual can be downloaded from [this site](https://www.zsl.org/about-zsl/resources/software/colony) - note that the `.OffGenotype` file is large and was not included in the repository
    + `8_recapCOLONY` - summarize output of `COLONY` clone analysis
    + `5_recapPLINK` - calculate pairwise KING kinship coefficient estimates in `PLINK2`
    + `10_recapFinal` - identify inferred of recaptures from combined `COLONY` and `PLINK2` output
    + `12_recapMaps` - mapping recaptures for all individuals with spatial recaptures
+ `/scr/` - spatial capture-recapture modeling
    + `11_makeCapHist` - create a capture history object for SCR modeling
        + `CGA_CH.Rda` - saved capture history objects created in the step above
    + `13_fitSCR0` - fit a basic SCR0 model to the data - males, females, 2023, 2024 separately
    + `14_fitHooker` - fit the (modified) Hooker et al. (2020) model to the data for females
    + `15_fitHookerM` - fit the (modified) Hooker et al. (2020) model to the data for males
    + `16_fitHooker_move` - fit a version of the Hooker et al. (2020) model that allows movement of activity centers - females
    + `17_fitHookerM_move` - fit a version of the Hooker et al. (2020) model that allows movement of activity centers - males
    + `23_fitHooker_bothSexes` - fit a version of the Hooker et al. (2020) model that incorporates data from both male and female bears
    + `23_fitHooker_bothSexes2` - fit a version of the Hooker et al. (2020) model that incorporates data from both male and female bears, using separate capture history objects
    + `25_fitSpatialModel_fem` - fit a model with spatial covariates for density, survival, and recruitment to data from female bears
    + `26_fitSpatialModel_both` - fit a model with spatial covariates for density, survival, and recruitment to data from both male and female bears
+ `/popgen/` - characterizing genetic diveristy and population structure
    + `19_diversity` - calculate summaries of genetic diversity for each population in the dataset
    + `20_structure` - calculate measures of genetic differentiation among populations, run `admixture` and DAPC
        + `ADMIX.*` - various outputs from the `admixture` analysis
        + `structure.vcf` - vcf file used for structure analyses
    + `21_effectiveSize` - estimate contemporary effective population size ($N_e$) for each population, estimate past changes in $N_e$ using `GONE` and `LinkNe`
        + `CGA_Ne*` - outputs from Ne estimation from LD
        + `combined.vcf` - vcf file used for diversity and effective population size analyses
    + `22_MHCdiversity` - summarize diversity at SNPs in MHC loci (exon 2 of *DQB*) across populations
        + `DQB*.vcf` - various `.vcf` files created for exons 2 and 6 of *DQB*
        + `DQBex2anns.csv` - annotation of SNPs within exon 2 of *DQB* (filtered for quality, etc. in the `MHCdiversity` analysis)
        + `DQBex2.hap` & `DQBex2.samples` - statistically phased (via `beagle`) SNPs in exon 2 of *DQB*, extacted with `bcftools convert --hapsample`
+ `/other/` - additional analyses that don't fit into the categories above
    + `24_assessPVA` - comparing abundances estimated in our SCR models to predictions from the PVA of Hooker et al. (2020), given observed mortalities
        
## The pipeline / order of events for the analysis

0. `setup/0_build_ve.sh` - create the virtual environment on the UGA cluster, install R packages, etc.
1. `sampleinfo/1_snareLocations` - create spatial objects for the modeling, name snares, etc.
2. `sampleinfo/2_compileMetadata` - record pertinent info for all samples
3. `snpfiltering/3_filterSCR` - filter SNPs for recapture analyses
4. `snpfiltering/4_combineGTSeek` - extract genotypes for the SNP loci targeted by GTSeek, combine with LGC data
5. `recaps/5_recapPLINK` - calculate pairwise KING kinship coefficients in `PLINK2`
6. `recaps/6_format4COLONY` - create input files for `COLONY` clone analysis 
7. `recaps/7_runCOLONY.sh` - submission script to run the `COLONY` job (no markdown)
8. `recaps/8_recapCOLONY` - brief summaries of `COLONY` output generated in step above
9. `sampleinfo/9_sexSamples` - extract sexing information from raw VCF, establish genotype sex for all samples
10. `recaps/10_recapFinal` - combine output from `PLINK2` and `COLONY`, check for missed recaptures in duplicated samples, check sex inference in sets of recaptures, map inferred spatial recaptures, assign final `cloneID` and sex
11. `scr/11_makeCapHist` - create capture histories for SCR analyses
12. `recaps/12_recapMaps` - creating maps of detections for all individuals with spatial recaptures (run locally!)
13. `scr/13_fitSCR0` - fit a simple closed population model to recaptures (total of 4 year- and sex-specific models: F23, F24, M23, M24) in `rjags`
14. `scr/14_fitHooker` - fit the open population model from [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887) to data from females in `rjags`
15. `scr/15_fitHookerM` - fit the open population model from [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887) to data from *males* in `rjags`
16. `scr/16_fitHooker_move` - fit a version of the model from [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887) that allows movement of AC to data from females in `rjags`
17. `scr/17_fitHookerM_move` - fit a version of the model from [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887) that allows movement of AC to data from males in `rjags`
18. `snpfiltering/18_filterPopGen` - filter SNPs for pop gen analyses
19. `popgen/19_diversity` - calculate summaries of genetic diversity for populations in the dataset (heterozygosity, allelic richness, inbreeding coefficients, etc.)
20. `popgen/20_structure` - estimate measures of population genetic differentiation ($F_{ST}$), apply model-free (PCA) and model-based (`admixture`) clustering analyses 
21. `popgen/21_effectiveSize` - estimate $N_e$ using the LD method ([Hill 1981](https://doi.org/10.1017/S0016672300020553), [Waples et al. 2016](https://doi.org/10.1038/hdy.2016.60)) in `NeEstimator` ([Do et al. 2014](https://doi.org/10.1111/1755-0998.12157))
22. `popgen/22_MHCdiversity` - extract SNPs in exon II of *DQB* (an MHC class II gene) and summarize diversity across Georgia's black bear populations
23. `scr/23_fitHooker_bothSexes2` - fit a version of the model from [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887) that incorporates data from both sexes in `rjags` - with separate data augmentation for males and females
24. `other/24_assessPVA` - compare the abundance estimates from SCR models to predictions from PVA in [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887), given information on mortalities
25. `scr/25_fitSpatialModel_fem` - fit a similar SCR model that incorporates spatial covariates for density, survival, and recruitment to data from female bears
26. `scr/26_fitSpatialModel_both` - fit a similar SCR model that incorporates spatial covariates for density, survival, and recruitment to data from male and female bears

