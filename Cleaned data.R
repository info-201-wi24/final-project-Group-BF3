library(dplyr)

gdp_data <- read.csv("world_country_gdp_usd.csv")
covid_data <- read.csv('owid-covid-data.csv')

colnames(gdp_data)
colnames(covid_data)


# Perform the join operation
joined_data <- covid_data %>%
  inner_join(gdp_data, by = "iso_code")

gdp_data <- rename(gdp_data, iso_code = `Country.Code`)
head(joined_data$continent)

colnames(joined_data)

cleaned_data <- na.omit(joined_data)
sum(is.na(joined_data))


joined_data$gdp_per_capita_USD <- as.numeric(as.character(joined_data$GDP_per_capita_USD))


joined_data$gdp_category <- cut(joined_data$gdp_per_capita_USD,
                                breaks = c(-Inf, 10000, 20000, Inf),
                                labels = c("Low", "Medium", "High"))

joined_data$new_cases_to_tests_ratio <- joined_data$new_cases / joined_data$total_tests

# Summarizing average total cases and GDP per capita by continent
summary_df <- joined_data %>%
  group_by(continent) %>%
  summarise(average_total_cases = mean(total_cases, na.rm = TRUE),
            average_gdp_per_capita = mean(GDP_per_capita_USD, na.rm = TRUE))

print(summary_df)



