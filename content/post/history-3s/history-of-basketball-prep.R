library(tidyverse)
library(broom)
library(nbastatR)
library(tidyverse)

history <- teams_players_stats(seasons = c(1988:2018), types = c("player"),
                         modes = c("PerGame"),
                         tables = c("general"),
                         season_types = "Regular Season")

history %>% 
  unnest(dataTable) %>% 
  select(yearSeason, gp,
         player = namePlayer,
         fgm:pctFT, 
         minutes:plusminus, pts) %>% 
  filter(!is.na(player)) %>%
  saveRDS("data/history-of-basketball.rds")

