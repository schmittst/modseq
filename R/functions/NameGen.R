### Trimmed reads
if (run[1] == 1 || qtrim.flag == 1) {
  if(qtrim.3end == 1) {  # Trimming at the 3'-end only
    aux <- unlist(strsplit(out.filename, "_"))
    if (length(aux) == 1) {
      out.filename.run1 <- paste(out.filename, "_3end", sep = "")
    } else { 
      out.filename.run1 <- paste(head(aux, n = 1), "_3end_", 
                                 paste(tail(aux, n = length(aux) - 1), 
                                       collapse = "_"), sep = "")
    }
    rm(aux)
  } else {  # Trimming at both termini
    out.filename.run1 <- out.filename
  }
}

if (qtrim.flag == 0 && run[1] == 0) {  # Untrimmed reads
  out.filename.run2 <- paste(out.filename, "_woTrim", sep = "")
} else if (qtrim.flag == 1 | run[1] == 1){  # Trimmed reads
  out.filename.run2 <- out.filename.run1
}

if (map.mode == "gls") {
  res.counts.filename <- out.filename.run2
  out.filename.run3 <- paste(out.filename.run2, "_gls", sep = "")
  if (paired.flag == 1 || run[2] == 1) {  # Paired reads
    res.listName <- out.filename.run2
  } else { 
    # Unpaired reads (trimmed or untrimmed) 
    if (paired.file == "f") {
      res.counts.filename <- paste(res.counts.filename, "_1", sep = "")
      res.listName <- paste(res.counts.filename, "_1", sep = "")
    } else if (paired.file == "r") {
      res.counts.filename <- paste(res.counts.filename, "_2", sep = "")
      res.listName <- paste(res.counts.filename, "_2", sep = "")
    } 
  }
  
  if (gls.ambiguity == FALSE) {
    res.counts.filename <- paste(res.counts.filename, "_woN", sep = "")
    res.listName <- paste(res.listName, "_woN", sep = "")
  }
  
  if (gls.direction == "f" ) {
    res.counts.filename <- paste(res.counts.filename, "_grepLike_forward", 
                                 sep = "")
    res.listName <- paste(res.listName, "_grepLike_forward", sep = "")
  } else {
    res.counts.filename <- paste(res.counts.filename, "_grepLike_reverse", 
                                 sep = "")
    res.listName <- paste(res.listName, "_grepLike_reverse", sep = "")
  }
  res.counts.filename <- paste(res.counts.filename, "_ModCounts", sep = "")
} else if (map.mode == "bwa") {
  out.filename.run3 <- paste(out.filename.run2, "_bwaMEM", sep = "")
  if (bwa.dupl) {
    out.filename.run3 <- paste(out.filename.run3, "_dedup", sep = "")
  }
}
