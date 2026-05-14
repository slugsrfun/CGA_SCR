makeCH <- function(samps=NULL, traps=NULL, yrs=NULL) {
  #Make an ID for the capture history (row index)
  clone <- unique(samps$finalClone) #The finalClone identifier!
  
  chID <- c()
  for(i in 1:nrow(samps)) {
    chID[i] <- which(clone == samps$finalClone[i])
  }
  
  if(length(yrs) == 1) {
    pc <- y <- array(0, dim=c(max(chID),
                              nrow(traps),
                              max(samps$week)))
    for(i in 1:nrow(samps)) {
      y[chID[i],
        which(rownames(traps) == samps$utmSnare[i]),
        as.numeric(samps$week[i])] <- 1
    }
    #Now make the previous capture object
    for(i in 1:dim(y)[1]){
      for(j in 1:dim(y)[2]) {
        if(sum(y[i,j,]) > 0) {
          ij.capt1 <- which(y[i,j,] == 1)[1]
          if(ij.capt1 < dim(y)[3]) {
            pc[i,j,(ij.capt1+1):dim(y)[3]] <- 1
          }
        }
      }
    }
  } else {
    pc <- y <- array(0, dim=c(max(chID),
                              nrow(traps),
                              max(samps$week),
                              length(yrs)))
    
    for(i in 1:nrow(samps)) {
      y[chID[i],
        which(rownames(traps) == samps$utmSnare[i]),
        as.numeric(samps$week[i]),
        which(yrs == samps$year[i])] <- 1
    }
    
    #Now make the previous capture object
    occ_cntr <- data.frame(occno = c(1:(dim(y)[3]*dim(y)[4])), 
                           secocc = rep(c(1:dim(y)[3]),dim(y)[4]),
                           priocc = sort(rep(1:dim(y)[4],dim(y)[3])))
    
    for(i in 1:dim(y)[1]){
      for(j in 1:dim(y)[2]) {
        if(sum(y[i,j,,]) > 0) {
          ij.capt1 <- which(y[i,j,,] == 1, arr.ind = TRUE)[1,]
          ij.capt1occno <- occ_cntr$occno[ij.capt1[1] == occ_cntr$secocc & 
                                            ij.capt1[2] == occ_cntr$priocc]
          if(ij.capt1occno < nrow(occ_cntr)) {
            for(r in (ij.capt1occno+1):nrow(occ_cntr)) {
              pc[i,
                 j,
                 occ_cntr[r,2],
                 occ_cntr[r,3]] <- 1
            }
          }
          rm(ij.capt1, ij.capt1occno)
        }
      }
    }
    
  }
  
  out <- list(y, pc, clone)
  names(out) <- c("y","pc","clone")
  return(out)
}