library(jsonlite)
dat <- read_json("./data.merged_with_gold.json", simplifyVector = TRUE)
envo <- read_json("combined_stripped_data.json",simplifyVector = TRUE)

e <- vector()

e[paste(envo$term," ",envo$field,sep="")] <- envo$envo

dat$samples$envo <- lapply(1:length(dat$samples$ECOSYSTEM_CATEGORY), function(X){na.omit(unlist(c(e[paste(dat$samples$ECOSYSTEM_CATEGORY[X]," ECOSYSTEM_CATEGORY",sep="")],e[paste(dat$samples$ECOSYSTEM_TYPE[X]," ECOSYSTEM_TYPE",sep="")],e[paste(dat$samples$ECOSYSTEM_SUBTYPE[X]," ECOSYSTEM_SUBTYPE",sep="")],e[paste(dat$samples$HABITAT[X]," habitat",sep="")])))})

write_json(dat,"merged.json")
