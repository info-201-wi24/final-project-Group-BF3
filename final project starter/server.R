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




  
joined_data <- joined_data
server <- function(input, output){
  
  
  output$Plot3 <- renderPlotly({
    print(class(joined_data))
    filteredData <- joined_data %>%
      dplyr:: filter(year == as.numeric(input$dataChoice))
    
    my_plot <- ggplotly(filteredData,
                        x = GDP_USD,
                        y = people_vaccinated_per_hundred,
                        type = "scatter",
                        mode = "markers",
                        marker = list(size = 9,
                                      color = GDP_USD,
                                      colorscale = "red"),              

  
)

  
  })
  
  
}

}  
