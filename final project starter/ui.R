
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
     to understand health authorities' the response to the pandemic"),
  p("Our data comes from:"),
  url<-a("World GDP", href="https://data.worldbank.org/indicator/NY.GDP.MKTP.CD", align="center"), 
  url<-a("Vaccination Data", href="https://ourworldindata.org/covid-vaccinations", align = "center")
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
  h2("Visualization Options"),
  selectInput(
      input = "continentChoice",
      label = "Choose continent to display:", 
      choices =unique(joined_data$continent) 
      ),
    h2("Year"),
    selectInput(
      input = "yearChoice",
      label = "Choose year to Display:", 
      choices = unique(joined_data$year)
    ))

viz_3_main_panel <- mainPanel(
  h2("Does higher continent GDP mean higher total vaccination totals?"),
  plotlyOutput("continentGDPVaccinationPlot")
)

viz_3_tab <- tabPanel("GDP and Vacinations by Continent",
                      sidebarLayout(
                        viz_3_sidebar,
                        viz_3_main_panel
                      )
)
## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion Tab Title",
 h1("Conclusion"),
 p("From the graph we draw, We can't see a obvius relationship between conutry GDP and vaccination progress, but we did see they were making progressing yearly, and Countries that have comparatively high GDP per capita indeed has more advanced  vaccination progression.")
)



ui <- navbarPage("Group BF-3: Country Covid Vaccination Numbers vs GDP",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
