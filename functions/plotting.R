# Define the function - tells us all the things we will define (data, x_collumn etc etc)

plot_boxplot <- function(data, 
                         x_collumn,
                         y_collumn,
                         x_label,
                         y_label,
                         colour_mapping) {
  # Drop the na
  data <- data %>% 
    drop_na({{ y_collumn }})
  # Make the plot 
  flipper_boxplot <- ggplot(
    data = data,
    aes (x = {{x_collumn}}, 
         y = {{y_collumn}}, 
    color = {{x_collumn}} )) +
    geom_boxplot(aes(color = species),
                 width = 0.3,
                 show.legend = FALSE) +
    geom_jitter(size = 1,
                alpha = 0.3,
                show.legend = FALSE, 
                position = position_jitter(
                  width = 0.2,
                  seed = 0)) +
    scale_colour_manual(values = species_colours) +
    labs(x = "Penguin Species",
         y = "Flipper Length (mm)") }

species_colours <- c("Adelie" = "darkorange",
                     "Chinstrap" = "purple",
                     "Gentoo" = "cyan4")


# Using the function
plot_boxplot(penguins_clean, "species", "flipper_length_mm", "Penguin Species", "Flipper Length (mm), species_colours")

