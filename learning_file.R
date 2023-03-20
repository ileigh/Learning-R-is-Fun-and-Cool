# LEARNING R SO I CAN BE A BRAIN GENIUS!
# BEGINNING OF LECTURE 1: R BASICS
# Using R like a fancy graphing calculator
1 + 2 # Addition 
6 - 7 # Subtraction
5 / 2 # Division
2 ^ 3 # Exponentiation
2 + 4 * 1 ^ 3 # Standard order of operations

# Logical operators follow standard programming conventions
1 > 2
1> 2 & 1 > 0.5 # "&" means and
1 > 2 | 1 > 0.5  # "|" means or 
!(1 > 2) # Negation

# Commenting
# R ignores the line after #, use this for comments
# Commenting conventions: comment BEFORE code, use present tense
# Test whether 4 is greater than 3
4 > 3

# Evaluation
# Note that "=" is reserved for assignment
#1 = 1 ##Error in 1 = 1 : invalid (do_set) left-hand side to assignment
# https://www.statology.org/r-invalid-do_set-left-hand-side-to-assignment/#:~:text=This%20error%20occurs%20when%20you,a%20character%20or%20a%20dot.
# Always read error message and if I don't understand, google it
# Instead use == for equal to
1 == 1
# Use != for not equal to
1 != 2

# Objects and Functions
  # Objects
bill = 18.45
percentage = 0.2 
# Can use <- instead of =, just be consistent
bill <- 18.45
percentage <- 0.2
# Want to see the object? Type its name. Note objects are now in environment pane
bill
# Calculate tip
bill * percentage
# Assign new value to bill and recalculate tip
bill = 90
bill * percentage
# CHALLENGE: Calculate sum of first 100 positive integers
n = 100
m = (n + 1) / 2
n * m 
  # Functions
log(50)
# Find arguments
?log
# keeping things in order, don't need argument names
log(50, 10)
# Argument names can help
log(50, base = 10)
# If you name all the arguments you can put them out of order 
log( base = 10, x =50)
# Can use objects as arguments or nest functions
log(bill)
log(exp(50))

# Data types (vectors, matrices, data frames, lists, functions)
# class will tell you which type
a = 2
class(a)
class("a")
class(TRUE)

# Data frames
# packages; install dslabs
install.packages("dslabs")
# only need to install once, but need to load it each time
library(dslabs)
data(murders)
# Data frame is like a table, row=observation, column=variable
class(murders)
# examine structure 
str(murders)
# summ stats
summary(murders)
# show first few rows
head(murders)
# directly inspect the data (can also just click in Environment pane)
View(murders)
# accessor ( to refer to individual variables/columns in the data frame)
murders$population #this is a vector
# number of entries/rows in vector
length(murders$population)
# make a histogram
hist(murders$total)
# make a scatterplot
plot(x = murders$population, y = murders$total)
with(murders, plot(x = population, y =total)) # these lines are equivalent

# cleaning up: remove objects using rm, better to start a new r session instead
a = "hi"
rm(a)
# environment is transient, don't get attached to objects in it
# exit R when you're done working, NEVER SAVE ENVIRONMENT
# to recreate objects later, re-run script
# when you want to save something, save it to a file

# Vectors: most basic object in R
# a = 1 produces a vector of length 1, to make a longer vector use c() concatenate
codes = c(380, 124, 818)
countries = c("italy", "canada", "egypt")
class(codes)
class(countries)
# can use " or '
countries = c('italy', 'canada', 'egypt') # need the quotations to ensure string
# name the entries with/without quotes
codes = c(italy = 380, canada = 124, egypt = 818)
codes
# can also use names funtion
codes = c(380, 124, 818)
country = c('italy', 'canada', 'egypt')
names(codes) = country
codes
# Use vectors to generate sequences
seq(1, 10)
# shortcut for consecutive
1:10
#counting by 5
seq(5, 50, 5)
# square brackets to access specific vector elements
codes[2]
# get multiple entries with multi-entry vector as index
codes[c(1,3)]
# use sequence to get first 2 elements
codes[1:2]
# index using names
codes['canada']
#assign new values to indexed elements
codes[2] = 125
codes

#CHALLENGE
library(dslabs)
data(murders)
murders[5]
# switch to murders
colnames(murders) = c('state', 'abb', 'region', 'population', 'murders') 
# switch back to total
colnames(murders) = c('state', 'abb', 'region', 'population', 'total')

# Converting (coercing) types
#turn numbers into characters, and back again
x = 1:5
y = as.character(x)
y
as.numeric(y)
# vector can't mix types, so R will guess
z = c(1, 'canada', 3)
z
class(z)
# if convesion isn't obvious, you'll get NA
as.numeric(z)
# NA contains no information, useful for missing data
NA == NA
NA + 0
is.na(NA +0)
# other special values
1/0 # Inf
-1/0 # -Inf
0/0 # NaN

# Vector arithmetic
# multiply vector by scalar
inches = 1:12
cm = inches * 2.54
cm
# divide element wise vectors
murder_rate = murders$total / murders$population * 1e5
mean(murder_rate)
# can add the murder rate as a new column
murders$rate = murders$total / murders$population * 1e5
head(murders) # not necessarily the best way to edit data frames
# redundant, complex syntax, modifies master, overwrites existing column with same name
# try instead cbind
murders_with_rate = cbind(murders, murder_rate)
head(murders_with_rate)
# be sure to watch out for order? 
# subsetting with logicals
# generate a logical vector that says wheter each element of a vector passes a test
low = murder_rate <= 0.6
low
# now subset(index) states using the logical
murders$state[low]
# how many states meet this test, sum converts logical to numeric
sum(low)

#CHALLENGE
# which state has the most murders
most = murders$total == max(murders$total)
most
murders$total[most]

# MISC BASICS
# useful trick %in%
"Montana" %in% murders$state
c('District of Columbia', 'Puerto Rico') %in% murders$state
# Lists: objects that can store any combo of types
record = list(
  name = 'John Doe',
  id = 1234,
  grades = c(94, 88, 95)
  )
record
# A data frame is a list of vectors that follows certain rules
# access the components with $ or with [[]]
record$id
record[['id']]
record[[2]]
record$grades[3]
# END OF LECTURE 1: R BASICS
#####################################
# BEGINNING OF LECTURE 2: PROGRAMMING IN R
# Topics: if/else, for-loop, function, vectorization, parallelization
# if/ else
a = 0 
if(a != 0){
  print(1/a)
} else {
  print("Reciprocal does not exist")
}
# related function: ifelse(test, yes, no)
a = 0
ifelse(a > 0, 1/a, NA) #useful bc vectorized
# change negative to missing
b = c(0, 1, 2, -3, 4)
ifelse(b < 0, NA, b)

#for-loops, avoids redundant code, repeats are annoying
# hard to change later, prone to bugs, so want to abstract code
# which means define it once and run multiple times
# NEVER copy-paste more than twice
for (i in 1:5) {
  print(i)
}

library(dslabs)
data(murders)
murders2 = cbind(murders, rate = murders$total / murders$population * 1e5)
# wtf mean of numeric columns in murders, also want mean murder rate
# option 1: with copy paste
mean(murders2$total)
mean(murders2$population)
mean(murders$rate) #ERROR!
# now try forloop
numeric_cols = c('total', 'population', 'rate')
for(var in numeric_cols) {
  print(mean(murders2[[var]]))
}
# instead of printing can also populate a vector
numeric_cols = c('total', 'population', 'rate')
murder_means = vector()
for(var in numeric_cols) {
  murder_means[[var]] = mean(murders2[[var]])
}
murder_means
# Problem! vector storing output grows at each iteration which is slow
# to make loop more efficient, give the empty vector the right
#length before starting the loop
numeric_cols = c('total', 'population', 'rate')
murder_numbers = murders2[numeric_cols]
murder_means = vector('numeric', length = length(murder_numbers))
for(i in 1:length(murder_numbers)) {
  murder_means[[i]] = mean(murder_numbers[[i]])
}
names(murder_means) = numeric_cols
murder_means
# For-loops are discouraged in R, but are important to know
# ^ bc R has vectorization, but we have to cover functions first
# I want to standardize (calc z-score) of numeric variable
z_population = (murders$population - mean(murders$population)) / sd(murders$population)
# This works, but is hard to follow
# if wanted to standardize another vector would have to rewrite
# Write a function!
# calculate_z is the name
# x is an argument (user supplies x each time, placeholder for calculations)
# the stuff the function does is in {}
# return() defines the result of the function, objects defined like z exist onl within the function
calculate_z = function(x) { 
  z = (x - mean(x)) / sd(x)
  return(z)
}
# now use the function!
z_population = calculate_z(murders$population)
head(z_population)
# Now I can use this funtion in different contexts!
z_population = calculate_z(murders$population)
z_rate = calculate_z(murders2$rate)
z_seq = calculate_z(seq(1:100))
# when to prefer function over a for loop
# CHALLENGE
average = function(x) {
  z = (sum(x)) / length(x)
  return(z)
}
average(murders$population)
average_new = function(x, median) {
  if(median == FALSE){
    print(mean(x))
  } else {
    print(median(x))
  } 
}
average_new(c(1, 9, 10), FALSE)
average_new(c(1, 9, 10), TRUE)
# Nice!

# Vectorizations and Functionals
# iterating using the apply family, applies function to all elements of an object
nums = 1:10
sapply(X = nums, FUN = sqrt)
# silly example bc sqrt is already vectorized
sqrt(nums)
# apply calculate_z to all cols of murder_numbers, we didn't vectorize it so it won't work
# calculate_z(murder_numbers) Error! How to fix:
z_total = calculate_z(murder_numbers$total)
z_population = calculate_z(murder_numbers$population)
z_rate = calculate_z(murder_numbers$rate)
murders_z = data.frame(z_total, z_population, z_rate)
head(murders_z, n = 3)
# but if murder_numbers has a lot of cols, trouble
# put it inside of a for loop
murders_z = list()
for(col in names(murder_numbers)) {
  murders_z[[col]] = calculate_z(murder_numbers[[col]])
}
head(as.data.frame(murders_z))
# but hard to read and write! SO simplify it w/ sapply
murders_z = sapply(murder_numbers, calculate_z)
head(as.data.frame(murders_z))
# this is why for loops are discouraged in R-dont need them!
# functional: function of functions, sapply is an example

# Parallelization
install.packages("future")
install.packages("future.apply")
install.packages("tictoc")
library(future)
library(future.apply)
library(tictoc)
plan(multisession)
# make a deliberately slow function
slow_square = function(x = 1) {
  Sys.sleep(1/3) # just wait 1/3 of a second
  return(x^2)
}
# We can speed this up by running iterations in parallel
availableCores()
# parallelize via future.appl
tic()
future_sapply(1:24, slow_square)
toc()
# to make it parallel there are 2 steps:
# 1) Declare intent: plan(multisession)
# 2) use future_sapply instead of sapply
# future is useful bc simple and don;t need to know about hardware
# pllztn is useful when code takes a long time and is easy to break into chunks
# not useful for already fast code, takes overhead
# chunks must be independent, can't have to communicate w/each other
# ex: bootstrapping, simulation, iteration problems
# Other functions for vectorization
# lapply(): returns list instead vector, can always unlist
# mapply(): multivariate version, vectorizes in 2+ dim
# purrr: map() and map2() similar but interact better w/ Tidyverse
# furrr: pllzd tidy-friendly vectorization, combine purrr and future

# LECTURE 3 PRODUCTIVITY TOOLS
# Yoooooooo we're gonna learn VERSION CONTROL
#testing a change!

# LECTURE 4: DATA WRANGLING IN THE TIDYVERSE!
# going to wrangle, clean data, and do some webscraping
# there appear to have been homeworks maybe I should try them

# Tidyverse basics
# intuitive, similar to Stata, front end for big data/ML tools
# need to use a combo of base R and tidyverse to do stuff
# data.table is also popular, not in this tutorial
# tidyverse::snake_case vs base::period.case
# REMEMBER: tidyverse is consistent and easy to visualize
  # Each column is a variable
  # Each row is an observation
# Wide vs long: Tidy is in LONG, many R packages assume in LONG (like Stata tbh)
install.packages('tidyverse')  # installs a handful at once 
install.packages('nycflights13')
library(tidyverse)
tidyverse_packages()
# lubridate for dates, rvest for webscraping
# we will focus on dplyr and tidyr

# laying pipe ;) 
# New: |> or Old: %>%, take the output of ine function and feed it into 
# the first argument of the next (which you then skip)
# dataframe |> filter(condition) equivalent to filter(dataframe, condition)
# %>% is from magrittr, works identically to |>
# shortcut: ctrl+shift+M, need to make a setting to make |> default
# pipes make it easier to read/write
# These lines of code do the same thing, first reads Left to Right
mpg |> filter(manufacturer == "audi") |> group_by(model) |> summarize(hwy_mean = mean(hwy))
summarize(group_by(filter(mpg, manufacturer == "audi"), model), hwy_mean = mean(hwy))
# now make it a PIPELINE BEYBEE
mpg |>
  filter(manufacturer == "audi") |>
  group_by(model) |>
  summarize(hwy_mean = mean(hwy))

# dplyr: filter, arrange, select, mutate, summarize
# filter: subset rows based on values
starwars |> 
  filter(
    species == "Human",
    height >= 190
  )
starwars |>
  filter(grepl("Skywalker", name))
# filtering by removing missings
starwars |>
  filter(is.na(height))
# to remove missings use this:
starwars |>
  filter(!is.na(height))

# arrange: reorder rows based on values
starwars |>
  arrange(birth_year)
# descending order
starwars |>
  arrange(desc(birth_year))
# select: subset columns by their names
starwars |>
  select(name:skin_color, species, -height)
# can rename 
starwars |>
  select(alias=name, crib=homeworld)
starwars |>
  rename(crib = homeworld)
# celect(contains(PATTERN)), nice shortcut
starwars |>
  select(name, contains('color'))
# mutate: create new columns==new variables
starwars |>
  select(name, birth_year) |>
  mutate(dog_years = birth_year * 7) |>
  mutate(comment = paste0(name, 'is', dog_years, 'in dog years.'))
# mutate is order aware, can chain multiple
starwars |>
  select(name, birth_year) |>
  mutate(
    dog_years = birth_year * 7, #separate w/ comma
    comment = paste0(name, "is", dog_years, "in dog years.")
  )
# boolean, logical, conditional operators all work w/ mutate too
starwars |>
  select(name, height) |>
  filter(name %in% c('Luke Skywalker', 'Anakin Skywalker')) |>
  mutate(tall1 = height > 180) |>
  mutate(tall2 = ifelse(height > 180, 'Tall', 'Short'))
# combine mutate and across to perform the same operation on a subset of variables
starwars |>
  select(name:eye_color) |>
  mutate(across(where(is.character), toupper))
# summariz(s)e: collapse multiple rows into single summ value
# useful with the group_by command
starwars |>
  group_by(species) |>
  summarize(mean_height = mean(height))
# to ignore missing values, use na.rm = T
starwars |>
  group_by(species) |>
  summarize(mean_height = mean(height, na.rm = T))
# can use same across-based workflow as mutate
starwars |>
  group_by(species) |>
  summarize(across(where(is.numeric), mean, na.rm = T))

# other dplyr goodies
# ungroup, for ungrouping after using group_by
# use after grouped summarize or mutate operation or everything will be SLOW
# slice: subset rows by position rather than filtering by values
starwars |> slice(1:10)
# pull: extract a column from data frame as a vector or scalar
starwars |> filter(sex == "female") |> pull(height)
# count and distinct: number and isolate unique obsv
starwars |> count(species)
starwars |> distinct(species)
starwars |> group_by(species) |> summarize(num = n())

# CHALLENGE! 
starwars |> 
  filter(sex =='female') |> 
  count(eye_color) |>
  arrange(desc(n)) # this last line I needed help with

# Storing results in memory
women = starwars |> filter(sex == 'female')
brown_eyed_women = women |> filter(eye_color == 'brown')
# DO NOT DO "CLOBBERING
# STARWARS = STARWARS |> FILTER(SEX == 'FEMALE)

# JOINS
#most data analysis requires combining info from multiple table, 
# to do this we use joins (similar to base::merge())
#TYPES
  #inner join: returns datafram of all rows that appear in both x and y
  # left join: keeps all rows in x. For matched rows merges in values of y, for unmatched fills in NA from y
  # right join: keeps all rows in y, same as left just reversef
  # full join: keeps all rows in x and y
# left is safer than inner (can lose observations)
# use left unless you have a good reason
library(nycflights13)
data(flights)  
data(planes)
# do a LEft JoiN Yay
flights |>
  left_join(planes)
# but there's trouble in paradise! Year does not have a consistent meaning across our databases!
# one refers to year of flight and the other refers to year of construction
# can fix this problem using ?dplyr::join
flights |>
  left_join(
    planes |> rename(year_built = year),
    by = "tailnum"
  )
# tidyr: pivot_longer, pivot_wider, separate, unite
# pivot_longer: pivot wide to long
stocks = data.frame(
  time = as.Date('2009-01-01') + 0:1,
  X = rnorm(2, 10, 1),
  Y = rnorm(2, 10, 2),
  Z = rnorm(2, 10, 5)
)
stocks

tidy_stocks = stocks |>
  pivot_longer(cols=X:Z, names_to = "stock", values_to ="price")
tidy_stocks

# pivot_wider: pivot long to wide
tidy_stocks |> pivot_wider(names_from = stock, values_from = price)
# can transpose it
tidy_stocks |> pivot_wider(names_from = time, values_from = price)

# separate: split one column into multiple
economists = data.frame(name = c("Adam_Smith", "Paul_Samuelson", "Milton_Friedman"))
economists

economists |> separate(name, c("first_name", "last_name"))
# can also define what is used to separate 
economists |> separate(name, c("first_name", "last_name"), sep = "_")

# related: separate_rows for splitting up cells that contain multiple fields or obsv
jobs = data.frame(
  name = c("Jack", "Jill"),
  occupation = c("Homemaker", "Philosopher, Philanthropist, Troublemaker")
)
jobs
jobs |> separate_rows(occupation)

# unite: combine multiple columns into one
gdp = data.frame(
  yr = rep(2016, times = 4),
  mnth = rep(1, times = 4),
  dy = 1:4,
  gdp = rnorm(4, mean = 100, sd = 2)
)
gdp
gdp |> unite(date, c("yr", "mnth", "dy"), sep = "-")
# unite will create a character variable. Easier to see if convert to tibble
gdp_u = gdp |> unite(date, c("yr", "mnth", "dy"), sep = "-") |> as_tibble()
gdp_u

library(lubridate)
gdp_u |> mutate(date = ymd(date))

# create a table of avg arrival delay in minutes by day and carrier
flights |>
  group_by(carrier) |>
  summarize(avg_late = mean(arr_delay, na.rm=T))

delay_long = flights |>
  group_by(carrier, day) |>
  summarize(avg_late = mean(arr_delay, na.rm=T))
delay_wide = delay_long |>
  pivot_wider(names_from = carrier, values_from = avg_late)
head(delay_wide, 4)

# Importing data with readr
# download colleges into the c drive so it's in the same world as the R stuff 
# working directory: current location in the file system 
getwd() # full or absolute path, starts with C:/ on windows or / on Mac
#Relative paths: defined relative to the full path of the working directory
# example: C:/git/ecns-560/"
# if file saves at C:/git/ecns-560/assignment-3/assignment-3.Rmd"
# relative path is assignmane-3/assignment-3.Rmd
# can use absolute or relative path, relative is easier b/c shorter

# Set the working directory
setwd("C:/Users/ileigh/Documents/GitHub/Learning-R-is-Fun-and-Cool")
# Do not use setwd() in scripts because you want your code to be portable
dat = read_csv("colleges.csv")
view
str(dat)
# Challenge
# which state has the least total reported covid-19 
dat2 = dat |>
  group_by(state) |>
  summarize(tot_cases = sum(cases)) |>
  arrange(tot_cases)
dat2
# other tips: csv files can be wonky, read_csv has options, look @ help file
# can read files directly from the internet, avoid doing this
# write_csv: outputs dataframe as a csv to my computer
# readxl :: read_excel reads directly from Excel
# googlesheets4 :: read_sheet reads directly from google sheets
# haven :: read_dta reads directly from Stata!!!
