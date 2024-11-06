# Load libraries #
library(tidyverse)
library(palmerpenguins)
library(here)
library(janitor)

# Better alternative to setwd() 
here::here()

# Show first six rows 
head(palmerpenguins)

# Show column names 


# Write data to csv using here
write.csv(penguins_raw, here("data", "penguins_raw.csv"))

# Use select and hyphen to remove comment column 

penguins_raw <- select(penguins_raw, -Comments)
colnames(penguins_raw)

# use select and starts_with to remove delta columns
# BAD CODE = OVERWRITTEN IT 
colnames(penguins_raw)
penguins_raw <- select(penguins_raw, -Comments)
penguins_raw <- select(penguins_raw, -Comments)

# Load raw data again from csv using here 
penguins_raw <- read.csv(here("data", "penguins_raw.csv"))

# Show column names 
colnames(penguins_raw)

# Make new variable, remove comments
penguins_clean <- select (penguins_raw, -Comments)

# Remove delta columns - STILL BAD CODE
penguins_clean <- select(penguins_clean, -starts_with("Delta"))
colnames(penguins_clean)                        

# BETTER CODE -

## Using piping to remove comments and delta columns ##
# The %>% means "and then" and we can use it to chain commands together. 
# Use Ctrl + Shift + M to write one quickly.

penguins_clean <- penguins_raw %>%
  select (-Comments) %>%
  select(-starts_with("Delta")) 

colnames(penguins_clean)

# Use pipe to remove comments and delta columns 
# and clean names using janitor package
# clean_names = clean the column names for us

penguins_clean <- penguins_raw %>%
  select (-Comments) %>%
  select(-starts_with("Delta")) %>% 
  clean_names()

colnames(penguins_clean)

## All the code together ##

library(tidyverse)
library(janitor)
library (palmerpenguins)
library(here)

# write the safe code
# check column names
# load raw data from csv
# clean it up using the pipe

#########################

# Making a function #

# We can make a new function called cleaning_penguin_columns:

cleaning_penguin_columns <- function(raw_data){
  raw_data %>% 
    clean_names %>% 
    remove_empty(c("rows", "cols")) %>% 
    select(-starts_with("delta"))
  select(-comments)
}

# remove_empty = removes empty enteries 
# Note, it doesn't matter what we call the function! 
# We're keeping this function generally applicable, so the input can just have a generic name like data or raw_data. 
# Unlike before, we don't specify what the new variable will be called, as the function will simply output it. 
# The {} brackets specify what is inside the function.

# Defining the function with more steps:

cleaning_penguin_columns <- function(raw_data){
  print("Cleaned names, removed comments, removed empty rows and cols, removed delta. ")
  raw_data %>% 
    clean_names %>% 
    remove_empty(c("rows", "cols")) %>% 
    select(-comments) %>% 
    select(-starts_with("delta"))
}

# print tells the person using the function what the function does 


# Loading the raw data again:
penguins_raw <- read.csv(here("data", "penguins_raw.csv"))

# Check the column names:
colnames(penguins_raw)

# Running the function:
penguins_clean <- cleaning_penguin_columns(penguins_raw)

# Checking the output:
colnames(penguins_clean)

# Fun fact Part 2: It doesn't matter if the input
# when you call the function is different to the input
# in the definition.

# penguins_raw is different to raw_data, but R knows what we mean. this
# is helpful because we don't need to remember the exact name we used
# in the function definition. And it makes it reuseable!

## Write the clean data to csv using here 

write.csv(penguins_clean, here("data", "penguins_clean.csv"))

#################################################

# Saving safe version of our cleaning code 

# Make sub-folder where we can put reuseable code
# dir.create(here("functions")) - IN CONSOLE NOT SCRIPT

# Make a new R script (not markdown)in our "functions" folder
# file.create(here("functions", "cleaning.R")) - IN CONSOLE NOT SCRIPT







