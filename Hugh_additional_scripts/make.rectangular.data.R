library(jsonlite)
dat <- read_json("./data.pretty.json", simplifyVector = TRUE)
data <- data.frame(
	file_name = dat$file_name,
	md5sum = dat$md5sum,
	description = dat$metadata$gold_data$description,
	biosample_accession = dat$metadata$gold_data$biosample_accession,
	goldv5_project_id = dat$metadata$gold_data$goldv5_project_id,
    gold_stamp_id = dat$metadata$gold_data$gold_stamp_id,
    gold_project_url = dat$metadata$gold_data$gold_project_url
)
save(data,file="data.Rdata")
