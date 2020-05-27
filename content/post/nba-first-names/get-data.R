library(tidyverse)
library(nbastatR)

df <- bref_players_stats(seasons = 1951:2020, tables = c("advanced", "totals"))

write_rds(df, "data/nba-player-stats-1951-2020.R")
