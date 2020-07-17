# Your turn solutions 

#' # Histogram 
#' 
#' ---
#' # Your Turn
#' 
#' `r countdown::countdown(minutes = 2, top = 0,  update_every = 30)`
#' 
#' Complete the code below to recreate the histogram of weekly NFL attendance. (Source: [Tidy Tuesday](https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-02-04/readme.md))
#' 
## ----echo=TRUE, eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## library(readr)
## attendance <- read_csv("dat/nfl_attendance.csv")
## ggplot(data = ???, aes(x = ???)) +
##   geom_???()

#' 
## ---- fig.height=4, fig.width=9, out.width='75%'------------------------------------------------------------------------------------------------------------
library(readr)
attendance <- read_csv("dat/nfl_attendance.csv")
ggplot(data = attendance, aes(x = weekly_attendance)) + 
  geom_histogram()


#' ---
#' # Bar chart 
#' ---
#' # Your Turn
#' 
#' `r countdown::countdown(minutes = 2, top = 0, update_every = 30)`
#' 
#' Complete the code below to display a bar chart of total NFL attendance from 2000-2019 by team. 
#' 
## ----echo=TRUE, eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## ggplot(??? = attendance, ???(??? = ???, weight = weekly_attendance)) +
##   geom_bar() +
##   coord_flip()

## ----fig.height=5, fig.width=10, out.width='70%'------------------------------------------------------------------------------------------------------------
ggplot(data = attendance, aes(x = team_name, weight = weekly_attendance)) + 
  geom_bar()+ 
  coord_flip()


#' ### **`geom_line`**
#' ---
#' # Your Turn
#' 
#' 
library(dplyr)
dc <- attendance %>% filter(team_name == "The DC Team")


#' `r countdown::countdown(minutes = 2, top = 0, update_every = 20)`
#' 
#' Complete the code to make the time series chart of weekly attendance from 2000-2019 for the DC Team.  
#' 
## ---- echo=TRUE, eval = FALSE-------------------------------------------------------------------------------------------------------------------------------
## ???(data = ???, aes(x = ???, y = ???)) +
##   geom_???()

#' 
#' 
## ----out.width="75%", fig.height=4, fig.width=8-------------------------------------------------------------------------------------------------------------
ggplot(data = dc, aes(x = time, y = weekly_attendance)) + 
  geom_line()


#' ### **`geom_boxplot`**
#' ---
#' # Your Turn 
#' 
#' `r countdown::countdown(minutes = 2, top = 0, update_every = 20)`
#' 
#' Modify the code below to create box plots for weekly attendance by team name. 
#' 
## ---- eval = FALSE, echo= TRUE------------------------------------------------------------------------------------------------------------------------------
## ggplot(data = ???, aes( ??? , ???)) +
##   geom_???() +
##   coord_flip()

#' 
#' 
## ----out.width="75%", fig.height=4, fig.width=9-------------------------------------------------------------------------------------------------------------
ggplot(data = attendance, aes(x = team_name, y = weekly_attendance)) + 
  geom_boxplot() + coord_flip()


#' 
#' ---
#' # Your Turn
#' 
#' `r countdown::countdown(minutes = 3, top = 0,  update_every = 20)`
#' 
#' Recreate this data visualization, which adds a layer to a previous viz. See the "Many Groups" slide. 
#' 
# your code here

#' 
#' 
## ----fig.height=4,fig.width=9-------------------------------------------------------------------------------------------------------------------------------
ggplot(data = attendance, aes(x = time, y = weekly_attendance)) + 
  geom_line(aes(group = team_name), alpha = .3) + 
  geom_smooth(aes(color = division), se = FALSE)


# gganimate your turn
#' ---
#' ---
#' # Example (animation)
#' 
#' ---
#' # Your Turn
#' 
#' `r countdown::countdown(minutes = 6, seconds = 0, top = 0, update.every = 30)`
#' 
#' Complete the code to recreate the GIF from the motivating example. (GIF in slides/gifs/monty_hall.gif)
#' 
## ----eval = FALSE, echo=TRUE--------------------------------------------------------------------------------------------------------------------------------
ggplot(data = sims) +
  geom_???(aes(xmin = win - .5, xmax = win + .5, ymin = perc2, ymax = perc, fill = Win,
               group = seq_along(sim)),
           color = "grey40") +
  facet_grid(cols = vars(Switch), labeller = label_both) +
  scale_x_continuous(breaks = c(0,1), labels = ??? ) +
  scale_y_continuous(breaks = ???, labels = scales::label_percent(accuracy = 1)) +
  scale_fill_manual(values = c("#F6C40C", "#4AA0BB")) +
  theme_bw() +
  theme(legend.position = "none",
        text = element_text(family = "Peralta", size = 20),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = NA),
        plot.title =  element_text(hjust = .5),
        plot.background = element_rect(fill = NA),
        panel.background = element_rect(fill = NA))  +
  labs(title = "Let's Make a Deal!")  +
  transition_???(sim, transition_length = 10, state_length = 5) +
  shadow_???(color = NA)


# soln 
p_to_anim <- ggplot(data = sims) +
  geom_rect(aes(xmin = win - .5, xmax = win + .5, ymin = perc2, ymax = perc, fill = Win,
               group = seq_along(sim)),
           color = "grey40") +
  facet_grid(cols = vars(Switch), labeller = label_both) +
  scale_x_continuous(breaks = c(0,1), labels = c("Lose", "Win") ) +
  scale_y_continuous(breaks = seq(0, .7, by = .1), labels = scales::label_percent(accuracy = 1)) +
  scale_fill_manual(values = c("#F6C40C", "#4AA0BB")) +
  theme_bw() +
  theme(legend.position = "none",
        text = element_text(family = "Peralta", size = 20),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = NA),
        plot.title =  element_text(hjust = .5),
        plot.background = element_rect(fill = NA),
        panel.background = element_rect(fill = NA))  +
  labs(title = "Let's Make a Deal!")  +
  transition_states(sim, transition_length = 10, state_length = 5) +
  shadow_mark(color = NA)

# get the full animation with the animate function 

my_anim <- animate(p_to_anim, fps = 40, end_pause = 20, duration = 20) 

my_anim

# save gif to file 
anim_save(my_anim, "my_animation.gif")