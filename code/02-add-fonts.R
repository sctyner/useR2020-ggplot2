# 4-10-2020: xkcd font is not working right now. 

# install.packages("extrafont")
# install.packages("xkcd")
library(extrafont)
library(xkcd)

download.file("http://simonsoftware.se/other/xkcd.ttf", dest="fonts/xkcd.ttf", mode="wb")
download.file("https://github.com/ipython/xkcd-font/raw/master/xkcd-script/font/xkcd-script.ttf", dest = "fonts/xkcd-script.ttf", mode = "wb")
font_import() 
# type y in console when prompted
font_import(pattern = "FontdinerSwanky", prompt=FALSE, paths = "fonts")
font_import(pattern = "Peralta", prompt=FALSE, paths = "fonts")
font_import(pattern = "Risque", prompt = FALSE, paths = "fonts")
loadfonts(device = "postscript")
# see the fonts available
fonts()
fonttable()

# visualize fonts 
library(ggplot2)

fontTable = extrafont::fonttable()

fontTable$Face = with(fontTable, ifelse(Bold & Italic, "bold.italic", 
                                        ifelse(Bold, "bold",
                                               ifelse(Italic, "italic", "plain"))))
fontTable$Face = factor(fontTable$Face, levels = c("plain","bold","italic","bold.italic"), ordered = TRUE)
fontTable$FamilyName = factor(fontTable$FamilyName, levels = rev(sort(unique(fontTable$FamilyName))), ordered = TRUE)

p = ggplot(fontTable) +
  geom_text(aes(x=Face, y=FamilyName, label=FullName, family=FamilyName, fontface=Face)) +
  labs(title="Windows Fonts in R", x=NULL, y=NULL) +
  theme_bw() +
  theme(axis.ticks = element_blank(),
        axis.text=element_text(size=12, colour="gray40", family='Arial'),
        axis.text.x=element_text(face=c("plain","bold","italic","bold.italic")),
        plot.title=element_text(size=16, family='Arial'))
p


ggplot() + geom_point(aes(x=mpg, y=wt), data=mtcars) +
  ggtitle("HELLO DARKNESS MY OLD FRIEND") + theme(text = element_text(family = ""))

# ------------------------------------------------

# trying showtext package 

install.packages("showtext")

library(showtext)

font_add(family = "xkcd", regular = "fonts/xkcd.ttf")

font_add("heiti", "simhei.ttf")
## Constantia font with regular and italic font faces
font_add("constan", regular = "constan.ttf", italic = "constani.ttf")

library(ggplot2)
p = ggplot(NULL, aes(x = 1, y = 1)) + ylim(0.8, 1.2) +
  theme(axis.title = element_blank(), axis.ticks = element_blank(),
        axis.text = element_blank()) +
  annotate("text", 1, 1.1, family = "heiti", size = 15,
           label = "\u4F60\u597D\uFF0C\u4E16\u754C") +
  annotate("text", 1, 0.9, label = 'Chinese for "Hello, world!"',
           family = "constan", fontface = "italic", size = 12)
x11()
font_add_google("Gochi Hand", "gochi")
font_add_google("Schoolbell", "bell")
showtext_auto()
hist(rnorm(1000), breaks = 30, col = "steelblue", border = "white",
     main = "", xlab = "", ylab = "")
title("Histogram of Normal Random Numbers", family = "bell", cex.main = 2)
title(ylab = "Frequency", family = "gochi", cex.lab = 2)
