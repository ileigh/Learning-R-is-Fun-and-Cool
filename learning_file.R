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

# LECTURE 3: PRODUCTIVITY TOOLS
# Yoooooooo we're gonna learn VERSION CONTROL
#testing a change!