# Create a list of the packages required
Assignment3Packages <- c(
  'tidyverse',
  'ggplot2',
  'plotly',
  'viridis')

# ggplot2 provides commands to create plots from data in a data frame
# plotly needed for visualisation of data (creating plots)
# tidyverse, always a useful package to use in order to keep code neat and concise
# viridis allows for colourblind friendly visualisations
# shiny allows our shiny app to run

# Install listed packages
install.packages(Assignment3Packages)

# Load the packages so we can use them!
library(tidyverse) 
library(plotly)
library(ggplot2)
library(viridis)

# Load dataset into RStudio
RawData <- read.csv("Data/Dataset3_Assessment3.csv")

# Access the dataset
str(Dataset3_Assessment3)

TeamShootingAccuracy <- ggplot(RawData, aes (x = Team, y = Statistic)) +
  geom_jitter(aes(colour = Team)) +
  scale_color_viridis_d() +
  theme_classic()
# Make interactive
ggplotly(TeamShootingAccuracy)

# Filter the dataset to include only "attempts1" and "attempts2" rows
filtered_data <- RawData %>%
  filter(Statistic %in% c("attempts1", "attempts2"))

# Pivot the data to create a column for each type of attempt
tidy_data <- filtered_data %>%
  pivot_wider(names_from = Statistic, values_from = Total) %>%
  select(Athlete, Team, attempts1, attempts2) %>%
  mutate(TotalAttempts = attempts1 + attempts2)  # Calculate total attempts

# Create a bar plot of total attempts by athlete
ggplot(tidy_data, aes(x = Athlete, y = TotalAttempts, fill = Team)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Total Attempts by Athlete", x = "Athlete", y = "Total Attempts") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
