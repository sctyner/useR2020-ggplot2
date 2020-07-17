## ----setup, include=FALSE-----------------------------------------------------------------------------------------------------------------------------------
extrafont::loadfonts()


#' 
## ----pkgs, message=FALSE, eval=TRUE-------------------------------------------------------------------------------------------------------------------------
library(dplyr)


#' ### Data (Noun)
#' # `ggplot2` code
#' 
## ----echo=TRUE, out.width="30%"-----------------------------------------------------------------------------------------------------------------------------
mh_sims <- readr::read_csv("slides/dat/monty_hall.csv")
library(ggplot2)
ggplot(data = mh_sims)

#' 
#' 
#' 
#' ---
#' # Geom `r emo::ji("left_right_arrow")` Verb 
#' 
## ----echo=TRUE, out.width="50%", eval = FALSE---------------------------------------------------------------------------------------------------------------
ggplot(data = mh_sims) +
  geom_col()

#' 
#' 
#' ---
#' # aes mapping `r emo::ji("left_right_arrow")` Pronouns
#' 
## ----echo=TRUE, fig.width = 10, fig.height=5, out.width="70%"-----------------------------------------------------------------------------------------------
ggplot(data = mh_sims,
       aes(x = Win, y = perc, fill = Win)) + 
  geom_col()
#' ---
#' # In `ggplot2` code
#' 
#' - **Note**: aesthetics / aes values do not have to be connected to data. 
#' - To change an aes value for the entire plot, use the aes value *outside* of the `aes()` function.
#' 
## ----echo=TRUE, fig.width = 10, fig.height=5, out.width="65%"-----------------------------------------------------------------------------------------------
ggplot(data = mh_sims, aes(x = Win, y = perc, fill = Win)) + 
  geom_col(fill = "#4AA0BB")

#' 
#' 
#' 
#' ---
#' # Stat `r emo::ji("left_right_arrow")` Adverb
#' 
## ----echo=TRUE, fig.width = 10, fig.height=5, out.width="70%"-----------------------------------------------------------------------------------------------
ggplot(data = mh_sims,
       aes(x = Win, y = perc, fill = Win)) + 
  stat_identity(geom="col") #<<
#' 
#' ---
#' # Theme `r emo::ji("left_right_arrow")` Adjective 
#' 
## ----echo=TRUE, fig.width = 10, fig.height=5, out.width="100%"----------------------------------------------------------------------------------------------
p <- ggplot(data = mh_sims,
       aes(x = Win, y = perc, fill = Win)) + 
  geom_col()  
#' <i class="fas fa-bullhorn" style="color: #FF0035;"></i>  This is a common trick. Create an object `p` that is the `ggplot` to add to later on.
#' 
#' ---
#' # In `ggplot2` code
#' 
#' Can use pre-made `theme_*()` functions and the `theme()` function to alter any non-data element of the plot. 
#' 
## ----echo=TRUE, fig.width = 10, fig.height=5, out.width="100%", results='hide'------------------------------------------------------------------------------
p2 <- p +   
  theme_bw() + 
  theme(text = element_text(family = "serif", size = 20), 
        panel.grid = element_blank())   
p2
#' ---
#' # Guides `r emo::ji("left_right_arrow")` Prepositions
#' 
## ----echo=TRUE, fig.width = 10, fig.height=5, out.width="70%"-----------------------------------------------------------------------------------------------
p3 <- p2 + guides(fill = "none")
p3
#' 
#' ---
#' # Facets `r emo::ji("left_right_arrow")` Conjunctions 
#' 
p4 <- p3 + facet_grid(cols =  vars(Switch)) 
p4

#' 
#' ---
#' # Other grammar elements
#' 
## ----out.width="50%"----------------------------------------------------------------------------------------------------------------------------------------
p4 + 
  scale_y_continuous(name = NULL, 
                     breaks = seq(0, .7, by = .1), label = scales::label_percent(accuracy = 1)) + 
  scale_fill_manual(values =  c("#F6C40C", "#4AA0BB")) +
  labs(x = NULL, title = "Let's Make a Deal!")

#' 
#' ---
#' # Complete `ggplot2` code
#' 
## ----eval = FALSE, echo = TRUE------------------------------------------------------------------------------------------------------------------------------
ggplot(data = mh_sims,
       aes(x = Win, y = perc, fill = Win)) +
  geom_col() +
  facet_grid(cols =  vars(Switch)) +
  scale_y_continuous(name = NULL,
                     breaks = seq(0, .7, by = .1), label = scales::label_percent(accuracy = 1)) +
  scale_fill_manual(values =  c("#F6C40C", "#4AA0BB")) +
  labs(x = NULL, title = "Let's Make a Deal!") +
  theme_bw() +
  theme(text = element_text(family = "serif", size = 20),
        panel.grid = element_blank()) +
  guides(fill = "none")
#' 
#' ---
#' class: inverse, center 
#' # One-variable visualization 
#' ---
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
library(readr)
attendance <- read_csv("slides/dat/nfl_attendance.csv")
ggplot(data = ???, aes(x = ???)) +
  geom_???()


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
ggplot(??? = attendance, ???(??? = ???, weight = weekly_attendance)) +
  geom_bar() +
  coord_flip()

#' 
#' 
#' ---
#' # Density plot 
## ----fig.height=4, fig.width=9, out.width='75%', echo = TRUE------------------------------------------------------------------------------------------------
ggplot(data = attendance, aes(x = weekly_attendance)) + 
  geom_density() 
#' ---
#' # Other one-variable viz
#' `geom_freqpoly` + `geom_rug`:
## ---- out.width='100%', fig.width=8, fig.height=6-----------------------------------------------------------------------------------------------------------
ggplot(data = attendance, aes(x = weekly_attendance)) + 
  geom_freqpoly()+ 
  geom_rug()

#' `geom_dotplot`:
## ----out.width='100%',  fig.width=8, fig.height=6-----------------------------------------------------------------------------------------------------------
ggplot(data = attendance, aes(x = weekly_attendance)) + 
  geom_dotplot(binwidth = 200)

#' ---
#' class: inverse, center 
#' # Two-variable visualization
#' ---
#' # Two numeric variables 
#' 
#' ### `time`, `weekly_attendance`
## ----echo=TRUE----------------------------------------------------------------------------------------------------------------------------------------------
library(dplyr)
dc <- attendance %>% filter(team_name == "The DC Team")
#' 
#' ### **`geom_line`**
#' ---
#' # Your Turn
#' 
#' `r countdown::countdown(minutes = 2, top = 0, update_every = 20)`
#' 
#' Complete the code to make the time series chart of weekly attendance from 2000-2019 for the DC Team.  
#' 
## ---- echo=TRUE, eval = FALSE-------------------------------------------------------------------------------------------------------------------------------
???(data = ???, aes(x = ???, y = ???)) +
  geom_???()

#' 
#' ---
#' # One numeric, one categorical
#' 
#' ### `team`, `weekly_attendance`
#' 
#' Return to the full `attendance` dataset. 
#' 
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
#' ---
#' # Two categorical variables 
#' 
#' ### `year`, `week`
#' 
#' 
## ----out.width="72%",fig.width =9, fig.height = 4, echo=TRUE------------------------------------------------------------------------------------------------
ggplot(data = dc, aes(x = year, y = week, fill = weekly_attendance)) + 
  geom_tile(color = "grey40") + 
  scale_x_continuous(breaks = 2000:2019) + scale_y_continuous(breaks = 1:17) + 
  scale_fill_gradient(low = "white", high = "forestgreen")
 
#' ---
#' class: inverse, center 
#' # Three or more variable visualization
#' ---
#' # Add a discrete/categorical variable
#' 
#' New York has two teams: the Giants and the Jets. 
#' 
## ----echo = TRUE--------------------------------------------------------------------------------------------------------------------------------------------
ny <- attendance %>% filter(team == "New York")
glimpse(ny)

#' 
#' ---
#' # Two time series, one plot
#' 
#' Use color to indicate team
#' 
## ----echo = TRUE, fig.width=9, fig.height=4-----------------------------------------------------------------------------------------------------------------
ggplot(data = ny, aes(x = time, y = weekly_attendance, color =team_name)) + #<<
  geom_line(alpha = .7) 

#' Use linetype to indicate team
#' 
## ----echo = TRUE, fig.width=9, fig.height=4-----------------------------------------------------------------------------------------------------------------
ggplot(data = ny, aes(x = time, y = weekly_attendance, linetype = team_name)) + #<<
  geom_line(alpha = .7) 

#' 
#' Use size to indicate team. <i class="fas fa-bullhorn" style="color: #FF0035;"></i>  Note: I do not recommended this! Why? 
#' 
## ----echo = TRUE, fig.width=9, fig.height=4-----------------------------------------------------------------------------------------------------------------
ggplot(data = ny, aes(x = time, y = weekly_attendance, size =team_name)) + #<<
  geom_line(alpha = .7) 

#' 
#' ---
#' # Adding a continuous/numeric variable
#' 
#' Using the `games` data from [Tidy Tuesday](https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-02-04/readme.md):
#' 
## ----echo = T-----------------------------------------------------------------------------------------------------------------------------------------------
games <- read_csv("slides/dat/nfl_games.csv")
glimpse(games)

#' 
#' ---
#' # Size 
#' 
## ----echo = TRUE, fig.width=9, fig.height=4-----------------------------------------------------------------------------------------------------------------
ggplot(data = games, aes(x = yds_loss, y = yds_win, size = pt_spread)) + #<<
  geom_point(alpha = .1) 

#' 
#' 
#' ---
#' # Color
#' 
## ----echo = TRUE, fig.width=9, fig.height=4-----------------------------------------------------------------------------------------------------------------
ggplot(data = games, aes(x = yds_loss, y = yds_win, color = pt_spread)) + #<<
  geom_point(alpha = .3) 

#' 
#' ---
#' # Grouping
#' 
#' > The `group` aesthetic partitions the data for plotting into groups 
#' 
## ----echo = TRUE, fig.show='hold', out.width="50%", fig.height = 5, fig.align='default'---------------------------------------------------------------------
ny19 <- ny %>% filter(year == 2019)
ggplot(data = ny19, aes(x = time, y = weekly_attendance)) + geom_line(alpha = .7) 
ggplot(data = ny19, aes(x = time, y = weekly_attendance, group =team_name)) + geom_line(alpha = .5) 

#' ---
#' # Many groups 
#' 
#' Look at all attendance for all teams
#' 
## ----echo = TRUE, fig.width=9, fig.height=4-----------------------------------------------------------------------------------------------------------------
ggplot(data = attendance, aes(x = time, y = weekly_attendance, group =team_name))+
  geom_line(alpha = .4)

#' 
#' ---
#' # Add another variable 
#' 
## ----echo = TRUE, fig.width=9, fig.height=4-----------------------------------------------------------------------------------------------------------------
ggplot(data = attendance, aes(x = time, y = weekly_attendance, group =team_name, color = division))+
  geom_line(alpha = .4)

#' ---
#' # Facets 
#' 
#' .pull-right[
## ---- echo=TRUE, out.width="100%", fig.height=4-------------------------------------------------------------------------------------------------------------
p <- ggplot(data = attendance, aes(x = time, y = weekly_attendance, group =team_name, color = division))+
  geom_line(alpha = .4)
p

#' ]
#' ---
#' # Faceting example 
#' 
#' .pull-left[
## ----echo=TRUE----------------------------------------------------------------------------------------------------------------------------------------------
p + facet_grid(cols = vars(conference))

#' ]
#' .pull-right[
## ----echo = TRUE--------------------------------------------------------------------------------------------------------------------------------------------
p + facet_wrap(vars(conference), nrow = 2)


#' ---
#' # Using the same data 
#' 
#' Add another layer by adding a different geom 
#' 
## ----echo=TRUE, fig.height=4,fig.width=9, out.width="70%"---------------------------------------------------------------------------------------------------
ggplot(data = games, aes(x = yds_loss, y = yds_win)) +
  geom_point(aes(size = pt_spread), alpha = .1) + 
  geom_smooth(se = FALSE, method = "lm") #<<

#' 
#' ---
#' # Your Turn
#' 
#' `r countdown::countdown(minutes = 3, top = 0,  update_every = 20)`
#' 
#' Recreate this data visualization, which adds a layer to a previous viz. See the "Many Groups" slide. 
#' 
# your code here: 


#' 
#' ---
#' # Using different data 
#'  
## ----echo = TRUE, eval=TRUE, out.width = "80%", fig.height = 4, fig.width=9---------------------------------------------------------------------------------
ggplot() + 
 geom_line(data = attendance, aes(x = time, y = weekly_attendance, group = team_name), alpha = .1) + 
 geom_line(data = dc, aes(x = time, y = weekly_attendance), alpha = .7, color = "blue") #<<

#' 
#' 
#' 
#' ---
#' # Scales
#' 

## ----echo = TRUE, out.width="100%", fig.height=4------------------------------------------------------------------------------------------------------------
ggplot(dc, aes(x = time, y = weekly_attendance)) + 
  geom_line() + 
  scale_x_continuous(breaks = seq(1, 340, by = 17), 
                     labels = 2000:2019, name = "Year")

#' 

## ----echo = TRUE, out.width="100%", fig.height=4------------------------------------------------------------------------------------------------------------
ggplot(ny, aes(x = time, y = weekly_attendance, 
  color = team_name)) + geom_line(alpha = .7) + 
  scale_color_manual(name = NULL, 
    values = c("navy", "forestgreen"))

#' 
#' ---
## ----echo = TRUE, out.width="100%", fig.height=4------------------------------------------------------------------------------------------------------------
ggplot(data=games, aes(x = yds_loss, 
  y = yds_win, size = pt_spread)) +
  geom_point(alpha = .1) + 
  scale_size_binned("Point Spread",
                    n.breaks = 5)

#' 
#' ---
#' # Other scale functions
#' 
#' ---
#' # Labels 
#' 
#' ---
#' # Coordinates
#' 
#' 
#' All three visualizations below begin with the same plot code: 
#' ```r
#' ggplot(dc, aes(x = time, y = weekly_attendance)) + geom_line() +
#' ```
#' 
## ----echo = FALSE, fig.align = "default", out.width="33%", fig.height = 6, fig.show='hold'------------------------------------------------------------------
p <- ggplot(dc, aes(x = time, y = weekly_attendance)) + geom_line()
p +   scale_x_continuous(breaks = seq(1, 340, by = 17), labels = 2000:2019) +
  ggtitle('scale_x_continuous(breaks = seq(1, 340, by = 17), labels = 2000:2019)')
p + scale_x_continuous(breaks = seq(1, 340, by = 17), 
                       labels = 2000:2019, limits = c(307, 340)) + 
  ggtitle('scale_x_continuous(breaks = seq(1, 340, by = 17), labels = 2000:2019,\nlimits = c(324, 340))')
p + scale_x_continuous(breaks = seq(1, 340, by = 17), 
                       labels = 2000:2019) +
  coord_cartesian(xlim = c(307, 340)) + 
  ggtitle('scale_x_continuous(breaks = seq(1, 340, by = 17), labels = 2000:2019) +\ncoord_cartesian(xlim = c(307, 340)')

#' 
#' 
#' 
#' ---
#' # Themes
#' 
#' Specific themes: 
#' 
#' - `theme_grey()`: default
#' - `theme_bw()`: white background, gray gridlines
#' - `theme_classic()`: looks more like base R plots
#' - `theme_void()`: removes all background elements, all axes elements, keeps legends 
#' 
#' General `theme` function for advanced customization: 
#' 
#' - `theme()`
#'     * adjust the appearance every "non-data element" of the viz
#'     * fonts, background, text positioning, legend appearance, facet appearance, etc. 
#' - <i class="fas fa-bullhorn" style="color: #FF0035;"></i> Rule of thumb: when changing an element that shows data, use aes() and scales. Otherwise, use themes. 
#' 
#' ---
#' # Theme elements
#' 
#' Every theme element is either a line, a rect, or text. See [documentation](https://ggplot2.tidyverse.org/reference/theme.html) for more.
#' 
#' To modify a theme element, use: 
#' 
#' - `element_line()`: change lines' appearance (color, linetype, size, etc.)
#' - `element_rect()`: change rectangles' appearance (fill, border lines, etc.)
#' - `element_text()`: change text elements' appearance (family, face, color, etc.)
#' - `element_blank()`: draw nothing. Use to remove a theme element. 
#' 
#' <i class="fas fa-bullhorn" style="color: #FF0035;"></i> Note: there are 92 possible arguments used to modify a ggplot theme. Usually, we will only need to call on a handful. 
#' 
#' ---
#' # Example 
#' 
## ---- echo=TRUE, fig.width=10, fig.height=4-----------------------------------------------------------------------------------------------------------------
mytheme <- theme(legend.position =  "top", 
        axis.text = element_text(face = "italic", color = "navy"), 
        plot.background = element_rect(fill = "#a0d1f2"), 
        panel.background = element_blank(), 
        panel.grid = element_line(linetype = "dotdash"))
ggplot(data = mpg) + geom_jitter(aes(x = cty, y = hwy, color = class)) + mytheme

#' 
#' 
#' ---
#' # Legends 
#' 
#' The `guides()` family of functions control legends' appearance  
#' - `guide_colorbar()`: continuous colors
#' - `guide_legend()`: discrete values (shapes, colors)
#' - `guide_axis()`: control axis text/spacing, add a secondary axis 
#' - `guide_bins()`: creates "bins" of values in the legend
#' - `guide_colorsteps()`: makes colorbar discrete 

#' # Example 
#' 
## ---- echo=TRUE, fig.width=10, fig.height=4-----------------------------------------------------------------------------------------------------------------
ggplot(data = mpg) + 
  geom_jitter(aes(x = cty, y = hwy, color = class),key_glyph = draw_key_pointrange) + #<<
  mytheme + 
  guides(color = guide_legend(nrow = 1)) #<<

#' 
#' ---
#' # Fonts
#' 
#' To change fonts in a `ggplot2` viz: 
#' 
#' - Use the `element_text()` function inside of `theme()`
#'     * `family`: font family 
#'     * `face` : bold, italic, bold.italic, plain 
#'     * `color`, `size`, `angle`, etc. 
#' - Include additional fonts with the [`extrafont`](https://github.com/wch/extrafont) package: 
## ----eval=FALSE, echo=TRUE----------------------------------------------------------------------------------------------------------------------------------
library(extrafont)
## font_import() # will take 2-3 minutes. Only need to run once
# loadfonts()
fonts()
fonttable()

## ---- echo=TRUE, eval=FALSE---------------------------------------------------------------------------------------------------------------------------------
ggplot(data = mpg) +
  geom_jitter(aes(x = cty, y = hwy, color = class)) +
  theme(text = element_text(family = "Peralta")) #<<


#' ---
#' # Design principles

#' ---
#' class: inverse, center
#' # `ggplot2` extensions
#' 
#' ---
#' # Animation
#' 
#' [`gganimate`](https://gganimate.com/): a grammar of animated graphics 
#' 
#' <img src="img/gganimate.png" style="position: absolute; top: 5%; right: 5%;">
#' 
#' From the documentation, here are the `gganimate` function families: 
#' 
#' - `transition_*()`: defines how the data should be spread out and how it relates to itself across time.
#' - `view_*()`: defines how the positional scales should change along the animation.
#' - `shadow_*()`: defines how data from other points in time should be presented in the given point in time.
#' - `enter_*()/exit_*()`: defines how new data should appear and how old data should disappear during the course of the animation.
#' - `ease_aes()`: defines how different aesthetics should be eased during transitions.
#' 
#' ---
#' # Example (data)
#' 
#' Full simulated data: 
#' 
## -----------------------------------------------------------------------------------------------------------------------------------------------------------
sims <- read_csv("slides/dat/monty_hall_sims.csv")
glimpse(sims)

#' 
#' ---
#' # Example (code)
#' 
## ----echo=TRUE, eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
library(gganimate)
ggplot(data = sims) +
  geom_col(aes(x = Win, y = perc, fill = Win, group = seq_along(sim))) + #<<
  facet_grid(cols = vars(Switch), labeller = label_both) +
  scale_fill_manual(values = c("#F6C40C", "#4AA0BB")) +
  theme_bw() +
  theme(legend.position = "none",
        text = element_text(family = "Peralta", size = 20),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = NA),
        plot.title =  element_text(hjust = .5),
        plot.background = element_rect(fill = NA),
        panel.background = element_rect(fill = NA))  +
  labs(title = "Let's Make a Deal!", subtitle = "Sim: {frame_along}") + #<<
  transition_reveal(seq_along(sim))  #<<


#' 
#' 
#' ---
#' # Example (animation)
#' 
#' ---
#' # Your Turn
#' 
#' `r countdown::countdown(minutes = 6, seconds = 0, top = 0, update.every = 30)`
#' 
#' Complete the code to recreate the GIF from the motivating example. (GIF on next slide)
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

#' ---
#' # Additional resources 
#' 
#' - [ggplot2 book](https://ggplot2-book.org/)
#' - [plotly book](https://plotly-r.com/)
#' - [R for Data Science book](https://r4ds.had.co.nz/)
#' - [Tidy Tuesday](https://github.com/rfordatascience/tidytuesday)
#' - [My advice for getting help in R](https://sctyner.github.io/rhelp.html)
#' - Thomas Lin Pedersen's ggplot2 webinar: [part 1](https://youtu.be/h29g21z0a68) and [part 2](https://youtu.be/0m4yywqNPVY)
#' - [RStudio Cheat Sheets](https://github.com/rstudio/cheatsheets)
#' - [Will Chase's Design Talk](https://rstudio.com/resources/rstudioconf-2020/the-glamour-of-graphics/) at rstudio::conf
#' - The [4-hour version](https://rstudio.cloud/project/1116791) of this workshop 
#' - More in the `resources/` folder
#' 
