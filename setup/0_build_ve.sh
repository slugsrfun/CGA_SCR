#build_veCGA.sh
#Building a virtual environment on Sapelo2
# for bioinformatics and some limited pop gen analysis of black bear data

#Connect to the cluster and start an interactive session
ssh sapelo2
interact --mem 32gb

#Load the Miniforg3 module
ml Miniforge3/24.11.3-0

#Create the virtual environment
conda create -p /home/jdrobins/veGAbears

#...
#Type "y" to proceed after a short wait...
#...

#Activate the virtual environment
source activate /home/jdrobins/veGAbears

#Install software...
conda install --file veCGA_packageList.txt
# Type "y" to proceed 

#Save the explicit list of packages used to create this VE
conda list --explicit > veGAbears_pkglist.txt

#Clone scrbook R package from Andy Royle's GitHub page
cd /home/jdrobins
git clone https://github.com/jaroyle/scrbook.git

#Install R packages needed for analyses that follow
R 
#...
#Select a CRAN mirror for the installation
#...
install.packages("/home/jdrobins/scrbook/Rpackage/scrbook", repos=NULL, type = "source")
install.packages(c("tinytex","knitr","R2jags","rjags","nimble","nimbleSCR","usmap","sf","shapefiles","plotrix","rmarkdown", "igraph","vcfR","adegenet","pegas","raster","codetools","prettymapr"))
install.packages("network")
install.packages("areaplot"")

#Test that installation worked for all packages above
library(tinytex)
library(knitr)
library(R2jags)
library(rjags)
library(usmap)
library(sf)
library(shapefiles)
library(plotrix)
library(rmarkdown)
library(scrbook)
library(igraph)
library(nimble)
library(nimbleSCR)
library(vcfR)
library(adegenet)
library(pegas)
library(raster)
library(codetools)
library(prettymapr)
library(network)
library(scales)
library(vegan) 
library(areaplot)

#Once they're all installed, quit R
quit()

#Close the VE
conda deactivate

#Disconnect from the cluster!

# A few pieces of software will not be installed within this virtual environment
# They should still be executable from within the ve
# These include...
#   1 - COLONY - Download COLONY from https://www.zsl.org/about-zsl/resources/software/colony
#   2 - LinkNe - Download LinkNe from GitHub https://github.com/chollenbeck/LinkNe
#   3 - GONE - Download GONE from https://github.com/esrud/GONE
# See the markdowns associated with the analyses for some help with installation
