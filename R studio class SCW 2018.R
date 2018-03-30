getwd()
setwd("/Users/Aparna/scw_2018/intro-R/")

# this will be ignored
cats <- 10 # crazy cat lady
cats - 9
# avoid these letters for names of variables: c, C, F, t T, S
# 6 main Data types are: Characters,'adfdsfdg' "afggagh"
# integers
# complex
# logical
# numeric

class(cats)
typeof(cats)
i <- 2L
j<-2
class(i)
typeof(i)

#complex
k<-2i
class(k)
typeof(k)

X * i
X * 1i

# Data structures

Logical_vector <- c(TRUE, TRUE, FALSE, TRUE)

char_vector <- c("Aparna", "Shamik")

class(Logical_vector)
length(Logical_vector)
anyNA(Logical_vector)
mixed <- c("True", TRUE)
class(mixed)
anothermixed <- c("Stanford",FALSE, 2L, 3.14)
class(anothermixed)
anothermixed <- c(FALSE, 2L, 3.14)
class(anothermixed)

anothermixed <- c(4i,FALSE, 2L, 3.14)
class(anothermixed)

# class hierarchy: Character, Complex, Numeric, Integer, Logical

#list
mylist <- list(chars = 'cofee', nums = c(1,4,5), logicals = TRUE, anotherlist = list(a = 'a', b=2))
mylist
class(mylist)

char_vector[2]
mylist[2]
str(mylist)

mylist[3]
mylist$logicals

mylist2 <- list(chars = 'cofee', nums = c(1,4,5), Logical3 = FALSE, logicals = TRUE,logical2 = FALSE, anotherlist = list(a = 'a', b=2))
mylist2[3]
mylist2$logicals
mylist2$nums

# matrix 

m<-matrix(nrow=2, ncol=3)
class(m)
m<-matrix(data=1:6, nrow=2, ncol=3)
m
m<-matrix(data=1:6, nrow=2, ncol=3, byrow=TRUE)
m

#dataframe: can have different classes of elements

df<-data.frame(id=letters[1:10],x=1:10, y=11:20)
df
str(df) #Str is structure
class(df)
typeof(df)
head(df)
tail(df)
#dimension
dim(df)
#column names
names(df)
summary(df)

#Factor: uses less memory while doing statistics
state<-factor(c("Arizona", "California", "Mass"))
state
state<-factor(c("AZ","CA","CA"))
state
nlevels(state)
levels(state)

ratings<-factor(c("low", "high", "medium","low"))
ratings
#to force an order, rather than the default alphabetical:
#r<-c("low","high","medium","low")
#ratings<-factor(r)
ratings<-factor(ratings, levels=c("low","medium","high"), ordered=TRUE)
min(ratings)


survey<-data.frame(number=c(1,2,2,1,2), group=c("A","B","A","A","B"))
str(survey) #if you make the variable Str, it will default make it a factor

Day=1:5
Magnification=c(2,10,5,2,5)
Observation=c("growth", "death", "no change", "death", "growth")

results=data.frame(Day, Magnification, Observation)
results

#to read files from xcel spreadsheets
gapminder <-read.csv("gapminder-FiveYearData.csv")
dim(gapminder)
head(gapminder)
str(gapminder)

View(gapminder)
gapminder$country #all elemnts of country column
gapminder[1,1]
gapminder[3,2]
gapminder[,1] #all elements of column1
gapminder[7,] #all elements of row 7

gapminder[10:15, 5:6]
gapminder[gapminder$country == 'Gabon', ]
gapminder[10:15, c("lifeExp", "gdpPercap")]

install.packages('dplyr')
library(dplyr)

#this is a pipe %>%

select(gapminder, lifeExp, gdpPercap) # data set name, coulumn names

gapminder %>% select(lifeExp, gdpPercap) # data set name, coulumn names to select
gapminder %>% filter(lifeExp > 71) #filters by row condition >71

Mexico <- gapminder %>%
  select(year, country, gdpPercap) %>%
  filter(country=='Mexico')
View('Mexico')

Europe<- gapminder %>%
  select(year, continent, gdpPercap) %>%
  filter(continent == 'Europe'& year>1980)
View(Europe)
  
#Summarize
gapminder %>% group_by(country) %>% tally()
gapminder %>% group_by(country) %>% summarize(avg = mean(pop), std= sd(pop), total = n())

# Using arrange function in dplyr
gapminder %>% group_by(country) %>% summarise(avg = mean(pop), std= sd(pop), total = n()) %>%
  arrange(avg)

#Mutate
gapminder_mod <- gapminder
gapminder_mod %>% mutate(gdp = pop * gdpPercap)
gapminder_mod %>% mutate(gdp = pop * gdpPercap) %>% head()

#Calculate the average life expectancy per country. Which nation has the longest average life expectancy and which has the shortest average life expectancy? 

gapminder %>% group_by(country) %>% 
  summarise(avg = mean(lifeExp)) %>% 
  filter(avg == max(avg) | avg == min(avg)) 

names(gapminder)  #display coulumn names                                                                         

#Plotting
   
   plot(gapminder_mod$gdpPercap, y = gapminder_mod$lifeExp)

#ggplot2
   library(ggplot2)
ggplot(gapminder_mod,aes(x=gdpPercap, y=lifeExp)) + geom_point()

#log10 conversion
ggplot(gapminder_mod,aes(x=log10(gdpPercap), y=lifeExp)) + geom_point()

#transparency
ggplot(gapminder_mod,aes(x=log10(gdpPercap), y=lifeExp)) + geom_point(alpha = 1/3, size=3)

#color
ggplot(gapminder_mod,aes(x=log10(gdpPercap), y=lifeExp, color = continent)) + geom_point(alpha = 1/3, size=3)

#assign to a variable
p <- ggplot(gapminder_mod,aes(x=log10(gdpPercap), y=lifeExp, color = continent)) + geom_point(alpha = 1/3, size=3)

p

q <- p+facet_wrap(~ continent)
q

#smooth line
q2 <- q + geom_smooth(color="Orange")
q2


#combining dplyr with ggplot2

gapminder %>% mutate (gdp = pop * gdpPercap) %>% 
  ggplot(aes(gdp, lifeExp)) + geom_point(alpha = 1/3, size=3)

#Histogram
p_1<- ggplot(gapminder_mod, aes(gdpPercap)) + geom_histogram(alpha = 1/3, size=3, bins = 20)
p_1

p_2<- ggplot(gapminder_mod, aes(lifeExp, color = continent)) + geom_histogram(alpha = 1/3, size=3, binwidth = 1)
p_2

p_3<- ggplot(gapminder_mod, aes(lifeExp, fill = continent)) + geom_histogram(alpha = 1/3, size=3, binwidth = 1)
ggtitle("histogram_gapminder")
p_3

#saving plots
ggsave(p_3, file = "histogram_lifeExp.png")

ggsave(p_3, file = "~/scw_2018/intro-R/histogram_lifeExp.png") #with path name

#help
?ggplot2

#Line plot

gapminder_mod %>% filter(country=="Afghanistan") %>% 
ggplot(aes(x = year, y = lifeExp)) + 
  geom_line(color="blue")

plot1 <- ggplot(gapminder, aes(x = year, y = lifeExp))
plot <- plot1 + facet_wrap(~ continent) + geom_point(alpha = 1/3, size=3) + geom_smooth(color="Orange", lwd =2, se = FALSE)
plot

plot1 <- ggplot(gapminder, aes(x = year, y = lifeExp))
plot <- plot1 + facet_wrap(~ continent) + geom_point(alpha = 1/3, size=3) + geom_smooth(method = "lm",color="Orange")
plot

plot1 <- ggplot(gapminder, aes(x = year, y = lifeExp))
plot <- plot1 + facet_wrap(~ continent) + geom_point(alpha = 1/3, size=3) + geom_smooth(method = "lm",color="Blue") + geom_smooth(color="Orange")
plot

ggsave(plot, file = "geom_smooth_type.png")

#density plot

ggplot(gapminder_mod, aes(x = gdpPercap, y = lifeExp)) + geom_point(size = 0.25) +
  geom_density_2d() + scale_x_log10()

#combining plots
#grid extra

# library(gridExtra)
# gridExtra::grid.arrange(())

#loops

gapminder_mod %>%  filter(continent == "Asia") %>% 
  summarise(avg = mean(lifeExp))

contin <- unique(gapminder_mod$continent)
contin

for (c in contin) {
  #print c
  res <- gapminder_mod %>%  filter(continent == c) %>% 
    summarise(avg = mean(lifeExp))
print(paste0("The average life expextancy of", c, "is:", res))
  #print res
}

gapminder_mod %>% group_by(continent, year) %>%
  summarise (avg = mean(lifeExp))

#Functions
mean(2,3)

adder <- function(x, y){
  return(x+y)
}
adder(2,3)