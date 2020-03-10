library(tidyverse)
library(janitor)
library(broom)
library(scales)

ipeds <- read_csv("raw-data/ipeds-sfr-retention.csv") %>% 
  select(unit_id = UnitID, name = `Institution Name`,
         state_code = `State abbreviation (HD2018)`,
         control_code = `Control of institution (HD2018)`,
         undergrad_applicants = `Applicants total (ADM2018)`,
         retention_rate = `Full-time retention rate  2018 (EF2018D)`,
         student_faculty_ratio = `Student-to-faculty ratio (EF2018D)`)

states <- read_csv("raw-data/ipeds-sfr-retention-labels.csv") %>% 
  filter(VariableName == "State abbreviation (HD2018)") %>% 
  select(state_code = Value, state = ValueLabel)

ipeds <- left_join(ipeds, states, by = "state_code") 

control <- read_csv("raw-data/ipeds-sfr-retention-labels.csv") %>% 
  filter(VariableName == "Control of institution (HD2018)") %>% 
  select(control_code = Value, control = ValueLabel) %>% 
  mutate(control_code = as.integer(control_code))

ipeds <- left_join(ipeds, control, by = "control_code") 

ipeds %>% 
  select(name, state, undergrad_applicants, retention_rate, student_faculty_ratio) %>%
 # drop_na(undergrad_applicants, retention_rate, student_faculty_ratio) %>% 
  write_rds("processed-data/ipeds-sfr.rds")

