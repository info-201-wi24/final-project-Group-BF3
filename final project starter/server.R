library(ggplot2)
library(plotly)
library(dplyr)
joined_data<-joined_data
server <- function(input, output) {
  output$gdpVaccinationPlot <- renderPlotly({
    # Filter data based on selected year
    filtered_data <- joined_data %>%
      filter(year == input$yearChoice) %>%
      mutate(TotalVaccinationsLog = log10(total_vaccinations + 1)) # Add 1 to avoid log(0)
    
    plot_ly(filtered_data, x = ~GDP_per_capita_USD, y = ~TotalVaccinationsLog,
            type = 'scatter', mode = 'markers',
            color = ~continent, text = ~paste("Location:", location, "<br>Total Vaccinations:", total_vaccinations, "<br>GDP per Capita (USD):", GDP_per_capita_USD),
            marker = list(size = 10)) %>%
      layout(title = paste("GDP per Capita vs. Total Vaccinations (Log Scale) in", input$yearChoice),
             xaxis = list(title = "GDP per Capita (USD)"),
             yaxis = list(title = "Total Vaccinations (Log Scale)", type = "log"),
             hovermode = "closest")
  })
  
  
  output$VaccinesByCountry <- renderPlotly({
    # Filter data based on country and year
    filtered_data <- joined_data %>%
      filter(Country.Name == input$Country.NameChoice) %>%
      group_by(Country.Name, year) %>%
      mutate(TotalVaccinations = total_vaccinations)
    
    plot_ly(filtered_data, x = ~year, y = ~TotalVaccinations,
            type = 'bar',
            color = 'blue',
            marker = list(size = 50)) %>%
      layout(title = paste("Total Vaccinations by Year in", input$CountryChoice),
             xaxis = list(title = "Year"),
             yaxis = list(title = "Total Vaccinations", showticklabels = FALSE),
             hovermode = "closest")
  })
  
  output$continentPlot <- renderPlotly({
  filtered_data<- joined_data %>%
  group_by(continent) %>%
  summarise(average_gdp_per_year = mean(gdp_per_year, na.rm = TRUE),
  average_gdp_growth_rate = mean(average_gdp_per_year/year, na.rm = TRUE),
  vaccination_rate = mean(people_vaccinated_per_hundred, na.rm = TRUE))
  y_data <- if(input$dataChoice == "average_gdp_growth_rate") 
  filtered_data$average_gdp_growth_rate else filtered_data$vaccination_rate 
  y_label <- if(input$dataChoice == "average_gdp_growth_rate") "Average GDP Growth Rate" else "Vaccination Rate (%)" 
  plot_ly(filtered_data, x = ~average_gdp_per_year, y = ~y_data, 
  type = 'scatter',
  mode = 'markers',
  text = ~continent,
  marker = list(size = 15)) %>% 
  layout(title = paste("GDP Growth Rate vs. Vaccine Rollout Speed", input$dataChoice),
  xaxis = list(title = "Average GDP per Year"), 
  yaxis = list(title = y_label)) 
  })
  output$continentPlot <- renderPlotly({
  data_to_plot <- joined_data %>% group_by(continent) %>% 
    summarise(average_gdp_per_year = mean(gdp_per_year, na.rm = TRUE), 
    average_total_cases = mean(total_cases_per_million, na.rm = TRUE), 
    Vaccine_rollout_speed = mean(people_vaccinated_per_hundred, na.rm = TRUE)) 
  y_data <- if(input$dataChoice == "average_total_cases") 
  data_to_plot$average_total_cases else data_to_plot$Vaccine_rollout_speed 
  y_label <- if(input$dataChoice == "average_total_cases") "Average Total Cases per Million" else "Vaccination Rate (%)" 
  plot_ly(data_to_plot, 
  x = ~average_gdp_per_year, 
  y = ~y_data, type = 'scatter', 
  mode = 'markers', 
  text = ~continent, marker = list(size = 15))%>% 
  layout(title = "GDP Growth Rate vs. Vaccine Rollout Speed", 
  xaxis = list(title = "Average GDP per year”), 
  yaxis = list(title = y_label)
  )
  })

}  