#sumstats_4d
#Calculate some summary stats for the capture object (y)
#Based off the scrbook::SCRsmy() function
#Adapted for a 4d array
sumstats_4d <- function(y4d) {
  nind <- dim(y4d)[1]
  totcaps <- nperiods <- ntraps <- nyrs <- sprecaps <- rep(NA, nind)
  for(i in 1:nind) {
    x <- y4d[i,,,]
    ntraps[i] <- sum(apply(x,1,sum) > 0)
    sprecaps[i] <- ifelse(ntraps[i] > 1, 1, 0)
    nyrs[i] <- sum(apply(x,3,sum) > 0)
    totcaps[i] <- sum(x)
  }
  
  out <- c(ss.totN=nind, #Total individuals captured
           ss.totcaps=sum(totcaps), #Total captures across individuals
           ss.avgcaps=mean(totcaps), #Average number of captures per individual
           ss.indwsprecap=sum(sprecaps), #Individuals captured at more than 1 trap
           ss.avgtraps=mean(ntraps), #Average number of traps per individual
           ss.avgyrs=mean(nyrs)) #Average number of years per individual
  return(out)
}

#sumstats_3d
#Calculate some summary stats for the capture object (y)
#Based off the scrbook::SCRsmy() function
#Adding a few stats...
sumstats_3d <- function(y4d) {
  nind <- dim(y4d)[1]
  totcaps <- nperiods <- ntraps <- sprecaps <- rep(NA, nind)
  for(i in 1:nind) {
    x <- y4d[i,,]
    ntraps[i] <- sum(apply(x,1,sum) > 0)
    sprecaps[i] <- ifelse(ntraps[i] > 1, 1, 0)
    totcaps[i] <- sum(x)
  }
  
  out <- c(ss.totN=nind, #Total individuals captured
           ss.totcaps=sum(totcaps), #Total captures across individuals
           ss.avgcaps=mean(totcaps), #Average number of captures per individual
           ss.indwsprecap=sum(sprecaps), #Individuals captured at more than 1 trap
           ss.avgtraps=mean(ntraps)) #Average number of traps per individual
  return(out)
}