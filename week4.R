# Put at the top of your script
library(tidyverse)
library(here)
library(dplyr)
library(janitor)

# --- We need this for the boxplot --- 
library(ggplot2)

source(here("functions", "cleaning.R")) 

# -------------------------------------

penguins_raw <- read_csv(here("data", "penguins_raw.csv"))

penguins_clean <- penguins_raw %>% 
  clean_column_names() %>% 
  remove_columns(c("comments", "delta")) %>% 
  shorten_species() %>% 
  remove_empty_columns_rows()

penguins_clean <- read_csv(here("data", "penguins_clean"))

### A place to start 

# flipper_boxplot <- ggplot(
#  data = penguins_clean,
#  aes(x = species,
#      y = flipper_length_mm)) +
#    geom_boxplot() 

# flipper_boxplot

## BAD CODE - REWRITE below with pipes
# penguins_flippers <- select(penguins_clean , species, flipper_length_mm)
# saying find columns with these names and only select these

# colnames(penguins_flippers)

# Remove any nas

#penguins_flippers <- drop_na(penguins_flippers)

# GOOD CODE 

penguins_flippers <- penguins_clean %>%
  select(species, flipper_length_mm) %>% 
  drop_na()

head(penguins_flippers)

# Define color mapping with names for each species
# adelie = darkorange, chinstrap = purple, gentoo = cyan4
# This method ensures colour and species are paired regardless of later order

species_colours <- c("Adelie" = "darkorange",
                     "Chinstrap" = "purple",
                     "Gentoo" = "cyan4")

# New box plot with removed nas
flipper_boxplot <- ggplot(
  data = penguins_flippers,
  aes (x = species, y = flipper_length_mm)) +
  geom_boxplot(aes(color = species),
               width = 0.3,
               show.legend = FALSE) +
  geom_jitter(aes(color = species),
              alpha = 0.3,
              show.legend = FALSE, 
              position = position_jitter(
                width = 0.2,
                seed = 0)) +
  scale_colour_manual(values = species_colours) +
                labs(x = "Penguin Species",
                     y = "Flipper Length (mm)") 
              

flipper_boxplot

# geom_jitter gives a random x value for each point
# seed = 0 -> Can be any number - ensures repeatibilty of random
# alpha changes transpearecny

# Define plot as a function so we can reuse... 


