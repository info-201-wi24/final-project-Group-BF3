library(dplyr)
library(lubridate)

# Load GDP data
gdp_data <- read.csv("world_country_gdp_usd.csv")

# Load COVID-19 data
covid_data <- read.csv('owid-covid-data.csv')

# Select relevant columns
covid_data <- covid_data %>%
  select(iso_code, continent, location, date, total_vaccinations, people_vaccinated_per_hundred)

# Filter GDP data for years 2020 and 2021
gdp_data <- gdp_data[gdp_data$year >= 2020 & gdp_data$year <= 2021, ]

# Rename columns for join operation
gdp_data <- rename(gdp_data, "iso_code" = "Country.Code")

# Perform inner join operation
joined_data <- covid_data %>%
  inner_join(gdp_data, by = "iso_code", relationship = "many-to-many")

# Extract year from date column
joined_data <- joined_data %>%
  mutate(year = year(date))
