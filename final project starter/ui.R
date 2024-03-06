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

## OVERVIEW TAB INFO
library(shiny)
library(plotly)
library(dplyr)

overview_tab <-
  tabPanel("Overview Tab Title",
  mainPanel(img(src="CovidImage.png", height="50%", width="50%", align="center")),
   h1("Country Covid Vaccination Numbers vs GDP"),
   p("Our project aims to explain the relationship 
     between country GDP throughout the pandemic and 
     COVID vaccination totals and rates. The reason for our 
     focus on this is to help people understand the relationship
     between these two and make inferences about the causation 
     of each and how they affect each other, if in any way."),
  p("We would likefor our project to show interactive data and progression of Covid 19 Vaccinations per country and year.
     Aditionally, we hope to be able to show the timeline and speed of worldwide vaccinations in order 
     to understand health authorities' the response to the pandemic ")
)

## VIZ 1 TAB INFO
viz_1_sidebar <- sidebarPanel(
  h2("Visualization Options"),
  selectInput("yearChoice", "Select Year:",
              choices = unique(joined_data$year)) # Ensure 'joined_data$year' contains unique years
)

viz_1_main_panel <- mainPanel(
  h2("GDP and Vaccination Progress"),
  plotlyOutput(outputId = "gdpVaccinationPlot")
)

viz_1_tab <- tabPanel("GDP vs. Vaccinations",
                      sidebarLayout(
                        viz_1_sidebar,
                        viz_1_main_panel
                      )
)

## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Select Country"),
  selectInput("Country.NameChoice", "Country:",
              choices = unique(joined_data$Country.Name))
  #TODO: Put inputs for modifying graph here
)

viz_2_main_panel <- mainPanel(
  h2("Vacination total by country"),
  plotlyOutput(outputId = "VaccinesByCountry")
)

viz_2_tab <- tabPanel("Country vs. Vaccination total",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO
viz_3_sidebar<- mainPanel(
  h3("GDP Growth Rate and Vaccine Rollout Speed by Continent"))

viz_3_main_panel<-sidebarLayout(sidebarPanel( h3("Visualization Options")), 
                                selectInput("dataChoice", "Choose Data to Display:",
                                choices = c(("GDP Growth Rate" = average_gdp_growth_rate),
                                ("Vaccination Rates" = people_vaccinated_per_hundred)))
)
mainPanel(h3("Interactive Data Visualization"),
plotlyOutput("continentPlot"))

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion Tab Title",
 h1("Some title"),
 p("Viz_1 conclusion: From the graph we draw, We can't see a obvius relationship between conutry GDP and vaccination progress, but we did see they were making progressing yearly, and Countries that have comparatively high GDP per capita indeed has more advanced  vaccination progression.")
)



ui <- navbarPage("Group BF-3: Country Covid Vaccination Numbers vs GDP",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
