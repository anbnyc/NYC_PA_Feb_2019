# NYC_PA_Feb_2019
These are the unofficial election night results of the special election for New York City Public Advocate on February 26, 2019. These data were scraped from the [NYC Board of Elections website](https://web.enrboenyc.us/index.html) on March 9, 2019.

The primary dataset, `data/data.csv` is structured "long": one record is one candidate's vote count in one election district. Records contain identifying borough/county and assembly district for easy aggregation.

For geographic analysis, this can be joined with the [election district map](https://data.cityofnewyork.us/City-Government/Election-Districts/h2n3-98hq) at NYC's Open Data Portal.

Secondary datasets include `data/ed_data.csv`, an ED level total of votes cast; `data/cd_to_ed.csv`, a lookup table of EDs to City Council districts as of 2019; and `data/candidate_with_home_eds.csv`, a lookup table of EDs to PA candidates who represented City Council or Assembly districts at the start of, or recently before, 2019. The file `cd_to_ed.csv` was coded semi-manually using QGIS and shapefiles of the Council Districts and Election Districts.

This includes processing scripts in Python (for web scraping) and R (for reshaping and joining).
