library(jsonlite)
dat <- read_json("../../JAMO_metadata_example/20190410.JAMO.Metagenome_metadata.pretty.NaNtonull.json", simplifyVector = TRUE)
data <- data.frame(
	md5sum = dat$md5sum,
    sequencing_project_id = as.vector(unlist(dat$metadata$sequencing_project_id)),
	biosample_accession = dat$metadata$gold_data$biosample_accession,
    habitat = dat$metadata$gold_data$habitat,
    gold_stamp_id = dat$metadata$gold_data$gold_stamp_id,
    gold_project_url = dat$metadata$gold_data$gold_project_url
)

gold <- read.table("../../GOLD_DATA_DUMP_PUBLIC_ONLY/BIOSAMPLE_DATA_TABLE.dsv",sep="\t",header=T)

data$goldid <- sapply(1:length(data$gold_project_url), function(X) {as.factor(as.numeric(as.character(strsplit(as.character(data$gold_project_url[X]),"=Gp")[[1]][2])))})

data.merged.all.sequencing <- merge(data,gold,by.x="goldid",by.y="BIOSAMPLE_ID",all.x=T)

data.merged.all.sequencing <- data.merged.all.sequencing[, unlist(lapply(data.merged.all.sequencing, function(x) !all(is.na(x))))]
#write_json(list(sequencefiles=data.merged.all.sequencing),"twelve_metagenomes.fastafiles.metadata.merged_with_gold.json")

#terms <- unique(data$habitat)
#for(i in terms) {
#        url <- paste("http://data.bioontology.org/recommender?input=",URLencode(i),"&apikey=895bdcf2-33d3-4ecd-92ca-7363060b0fc8&ontologies=ENVO",sep="")
#        ret <- fromJSON(url)
#        write_json(list(term=i,field="habitat",envo=ret),paste("habitat",gsub("/","_",i),".json",sep=""))
#}

terms <- unique(data.merged.all.sequencing$ECOSYSTEM_SUBTYPE)
for(i in terms) {
        if(!is.na(i) && !(i == "")) {
                url <- paste("http://data.bioontology.org/recommender?input=",URLencode(i),"&apikey=895bdcf2-33d3-4ecd-92ca-7363060b0fc8&ontologies=ENVO",sep="")
                print(url)
                ret <- fromJSON(url)
                write_json(list(term=i,field="ECOSYSTEM_SUBTYPE",envo=ret),paste("ECOSYSTEM_SUBTYPE",gsub("/","_",i),".json",sep=""))
        }
}
