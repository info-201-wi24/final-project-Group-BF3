
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
     COVID vaccination totals and rates")
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

viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)

viz_3_main_panel <- mainPanel(
  h2("Vizualization 3 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_3_tab <- tabPanel("Viz 3 tab title",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion Tab Title",
 h1("Some title"),
 p("some conclusions")
)



ui <- navbarPage("Group BF-3: Country Covid Vaccination Numbers vs GDP",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
