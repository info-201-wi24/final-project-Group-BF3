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
}

