# packages 

# to run all the code in the slides
install.packages(c("dplyr", "ggplot2", "knitr", "readr", "stringr", "rmarkdown", "xaringan", 
                   "remotes", "sf", "USAboundaries", "xkcd", "extrafont", "gganimate", "plotly", 
                   "showtext", "rgeos", "rnaturalearth", "rnaturalearthdata"))

# to fully compile the slides
remotes::install_github("gadenbuie/xaringanthemer")
remotes::install_github("gadenbuie/countdown")
remotes::install_github("hadley/emo")

# extras 
remotes::install_github("ropensci/USAboundariesData")

