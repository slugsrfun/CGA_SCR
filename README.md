# CGA_BlackBears
Data analyses for central GA black bear SCR / PopGen project at UGA

## Directory Structure


+ `/PDFs/` - markdowns for all analyses
+ `/setup/` - code to create a virtual environment for data analysis
    + `0_build_ve.sh` - script used (interactively) to build the virtual environment for analyses that follow
    + `veGAbears_pkglist.txt` - explicit list of packages installed in creation of the virtual environment `veGAbears`
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
    + `HookerModel-noDensDep_bothSexes2.jag` - `JAGS` model modified from [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887), without density-dependent recruitment and modeling both sexes in the same analysis (two separate capture history objects)
    + `makeCH.R` - function to build a capture history from clone ID information (used in `makeCapHist` below)
    + `state-space360.tif` - state space as defined by [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887), raster saved in `.tif` format
    + `sumstats_4d.R` - functions to calculate summary statistics from 3-d and 4-d capture history arrays (based on a function from Andy Royle's [`scrbook` R package](https://github.com/jaroyle/scrbook))
    + `tl_2019_13_prisecroads` - Primary and secondary road shapefile (GA) downloaded from https://catalog.data.gov/dataset/tiger-line-shapefile-2019-state-georgia-primary-and-secondary-roads-state-based-shapefile
    + `UGA_bbh_Prod1_all_Genotypes.csv` - genetic data for samples submitted for GT-seq genotyping at GTSeek
    + `UGA_173101_Summary_Sheet.csv` - information on the Rapid Genomics ID, corresponding fastq file, and original customer code, used to match `rgID` to `ugaID`
+ `/sampleinfo/` - information about the bears, samples, and the state space
    + `1_snareLocations` - Create objects with information about the hair snares used in the study
       + `snareLocations.Rda` - R data file with information on snare locations
    + `2_compileMetadata` - Build the basic metadata file, will be added to in steps that follow
       + `sampleMetadata_...csv` - Metadata files created in the pipeline
       + `sampleMetaData_cloneID.csv` - the final metadata file after identification of unique individuals
    + `9_sexSamples` - Assign sexes to individual samples based on SNPs on the Y-chromosome
+ `/snpfiltering/` - steps involved in filtering capture-seq and GT-seq data for recapture / population genetic analyses
    + `3_filterSCR` - Apply filters for spatial capture-recapture analyses
        + `LGC_SCR.vcf` - filtered VCF for recapture analysis, prior to incorporating GTSeek samples
    + `4_combineGTSeek` - Combine markers from filterSCR above with SNPs genotyped by GTSeek
        + `finalSCR.recode.vcf` - filtered VCF for recapture analysis, after incorporating GTSeek samples
+ `/recaps/` - identifying and mapping recaptures
    + `5_recapPLINK` - calculate pairwise KING kinship coefficient estimates in `PLINK2`
       + `recapPLINK.kin0` - output file with pairwise kinship coefficients for samples in the dataset
    + `6_format4COLONY` - create `COLONY` input files
       + `CGA_COLONY.dat` - input file for `COLONY` analysis, created above
    + `7_runCOLONY` - run a "clone analysis" in `COLONY`
        + `CGA.*` - outputs from `COLONY` run - the `COLONY2` manual can be downloaded from [this site](https://www.zsl.org/about-zsl/resources/software/colony) - note that the `.OffGenotype` file is large and was not included in the repository
    + `8_recapCOLONY` - summarize output of `COLONY` clone analysis
    + `10_recapFinal` - identify inferred of recaptures from combined `COLONY` and `PLINK2` output
    + `12_recapMaps` - mapping recaptures for all individuals with spatial recaptures
+ `/scr/` - spatial capture-recapture modeling
    + `11_makeCapHist` - create a capture history object for SCR modeling
        + `CGA_CH.Rda` - saved capture history objects created in the step above
    + `23_fitHooker_bothSexes2` - fit a version of the Hooker et al. (2020) model that incorporates data from both male and female bears, using separate capture history objects
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
13. `scr/23_fitHooker_bothSexes2` - fit a version of the model from [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887) that incorporates data from both sexes in `rjags` - with separate data augmentation for males and females
14. `other/24_assessPVA` - compare the abundance estimates from SCR models to predictions from PVA in [Hooker et al. (2020)](https://doi.org/10.1002/jwmg.21887), given information on mortalities

