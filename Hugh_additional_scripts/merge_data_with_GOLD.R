library(jsonlite)
load("data.Rdata")

gold <- read.table("../GOLD_DATA_DUMP_PUBLIC_ONLY/BIOSAMPLE_DATA_TABLE.dsv",sep="\t",header=T)

data$goldid <- sapply(1:length(data$gold_project_url), function(X) {as.factor(as.numeric(as.character(strsplit(as.character(data$gold_project_url[X]),"=Gp")[[1]][2])))})

data.merged.all.sequencing <- merge(data,gold,by.x="goldid",by.y="BIOSAMPLE_ID")

data.merged.all.sequencing <- data.merged.all.sequencing[, unlist(lapply(data.merged.all.sequencing, function(x) !all(is.na(x))))]
write_json(list(samples=data.merged.all.sequencing),"data.merged_with_gold.json")
