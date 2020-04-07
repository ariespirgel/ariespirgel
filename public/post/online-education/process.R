library(tidyverse)

distance <- read_csv("raw-data/distance-fall-2016-2018.csv") %>% 
  left_join(read_csv("raw-data/distance-fall-2014-2015.csv"),
            by = c("UnitID", "Institution Name")) %>% 
  left_join(read_csv("raw-data/distance-fall-2012-2013.csv"),
            by = c("UnitID", "Institution Name")) %>% 
  rename(sector_code = `Sector of institution (HD2018)`)


sector <- read_csv("raw-data/distance-value-labels.csv") %>% 
  select(sector_code = Value,
         sector = ValueLabel)

distance <- inner_join(distance, sector, by = "sector_code") 

distance <- distance %>% 
  select(UnitID, `Institution Name`, sector, everything(),
         -sector_code, -UnitID, -sector)

distance %>% 
  write_csv("raw-data/distance-fall-12-18.csv")
