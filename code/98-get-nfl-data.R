# determining which new data sources to use 

library(tidyverse)
library(skimr)


###########################################################################################
# football data 


attendance <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/attendance.csv')
standings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/standings.csv')
games <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/games.csv')

skim(attendance)
skim(standings)
skim(games)

# change some names
attendance %>% 
  mutate(team_name = ifelse(team_name == "Redskins", "The DC Team", team_name), 
                      team_name = ifelse(team_name == "Chiefs", "The KC Team", team_name)) -> attendance

games %>% 
  mutate(home_team_name = ifelse(home_team_name == "Redskins", "The DC Team", home_team_name),
         away_team_name = ifelse(away_team_name == "Redskins", "The DC Team", away_team_name),
         home_team_name = ifelse(home_team_name == "Chiefs", "The KC Team", home_team_name),
         away_team_name = ifelse(away_team_name == "Chiefs", "The KC Team", away_team_name), 
         home_team = str_replace(home_team, "Chiefs|Redskins", "Team"), 
         away_team = str_replace(away_team, "Chiefs|Redskins", "Team"), 
         pt_spread = pts_win - pts_loss) -> games
write_csv(games, "slides/dat/nfl_games.csv")

# create a time variable 
attendance %>% 
  group_by(team_name) %>% 
  mutate(time = row_number()) -> attendance


attendance %>% 
  ggplot(aes(x= time, y = weekly_attendance, group = team_name, color = team_name)) + 
  geom_smooth(se = F)
  
teams <- read_csv("slides/dat/nfl_teams.csv")
attendance %>% left_join(teams)  -> attendance

#write_csv(attendance, "slides/dat/nfl_attendance.csv")

# exploratory plots 
ggplot(data = attendance, aes(x =weekly_attendance)) + 
  geom_histogram()

ggplot(data = attendance, aes(x = team_name, weight = weekly_attendance)) + 
  geom_bar()

attendance %>% 
  group_by(team_name) %>% 
  summarize(total = sum(weekly_attendance, na.rm = T))

games %>% 
  ggplot(aes(x = yds_loss, y = yds_win, size = pts_win - pts_loss)) + 
  geom_point(alpha = .3)

games %>% 
  ggplot(aes(x = yds_win, y = pts_win)) + 
  geom_point(alpha = .3) + 
  geom_smooth(method = "lm")

games %>% 
  ggplot(aes(x = yds_loss, y = pts_loss)) + 
  geom_point(aes(color = as.factor(turnovers_loss)), alpha = .3) + 
  geom_smooth(method = "lm") + 
  facet_wrap(vars(turnovers_loss))

