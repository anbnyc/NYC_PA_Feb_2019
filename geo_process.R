library(dplyr)
## Set working directory to source file location

data <- read.csv("data/data.csv", stringsAsFactors = F)
data2 <- tbl_df(data) %>%
  group_by(County, AD, ED) %>%
  summarise(Votes = sum(Votes)) %>%
  mutate(Key = paste0(
    substring(AD,3,4),
    ifelse(nchar(ED) == 3,
           "00",
           ifelse(nchar(ED) == 4,
                  "0",
                  "")
    ),
    substr(ED, 3, 5)
  ))

data$Key <- paste0(
  substring(data$AD,3,4),
  ifelse(nchar(data$ED) == 3,
         "00",
         ifelse(nchar(data$ED) == 4,
                "0",
                "")
  ),
  substr(data$ED, 3, 5)
)
write.csv(data, "data/data.csv", row.names = F, quote = F)
write.csv(data2, "data/ed_data.csv", row.names = F, quote = F)

cd2ed <- read.csv("data/cd_to_ed.csv", stringsAsFactors = F)
assembly <- data.frame(
  Name=c("MICHAEL A. BLAKE","DANIEL J. O'DONNELL","RON KIM","BENJAMIN L. YEE"), 
  AD=c("AD79", "AD69", "AD40", "AD66"),
  stringsAsFactors = F
)
council <- data.frame(
  Name=c("ERIC A. ULRICH", "JUMAANE D. WILLIAMS", "MELISSA MARK-VIVERITO", "RAFAEL L. ESPINAL JR.", "YDANIS RODRIGUEZ"),
  CD=c("CD42", "CD45", "CD8", "CD37", "CD10"),
  stringsAsFactors = F
)
geo_council <- merge(cd2ed, council, by="CD", all=T)
table(geo_council$AD, geo_council$Name)
geo <- merge(data2[,c("AD","ED")], assembly, by="AD", all.x=T)
geo <- merge(geo, geo_council, by=c("AD","ED"), all.x=T)
geo$Name <- ""
geo[is.na(geo$Name.x), "Name"] <- geo[is.na(geo$Name.x), "Name.y"]
geo[is.na(geo$Name.y), "Name"] <- geo[is.na(geo$Name.y), "Name.x"]
geo$Key <- paste0(
  substring(geo$AD,3,4),
  ifelse(nchar(geo$ED) == 3,
         "00",
         ifelse(nchar(geo$ED) == 4,
                "0",
                "")
  ),
  substr(geo$ED, 3, 5)
)
geo_clean <- geo[!is.na(geo$Name), c("Key","Name")]
write.csv(geo_clean, "data/candidate_with_home_eds.csv", quote = F, row.names = F)
