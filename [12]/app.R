library(shiny)
library(ggplot2)
library(dplyr)
library(skimr)
library(scales)
library(ggthemes)

# Load data
df = read.csv("CaseStudy1-data.csv")
df = df[, !(names(df) %in% c("ID", "EmployeeCount", "EmployeeNumber", "Over18", "StandardHours"))]
cat_vars = c("Attrition", "BusinessTravel", "Department", "EducationField", "Gender", "JobRole", "MaritalStatus", "OverTime")
df[cat_vars] = lapply(df[cat_vars], as.factor)
cat_vars_no_attrition = setdiff(cat_vars, "Attrition")

continuous_vars = c("Age", "DailyRate", "DistanceFromHome", "HourlyRate", "MonthlyIncome", "MonthlyRate", 
                    "PercentSalaryHike", "TotalWorkingYears", "YearsAtCompany", "YearsInCurrentRole", 
                    "YearsSinceLastPromotion", "YearsWithCurrManager")
discrete_vars = c("Education", "EnvironmentSatisfaction", "JobInvolvement", "JobLevel", "JobSatisfaction", 
                  "NumCompaniesWorked", "PerformanceRating", "RelationshipSatisfaction", 
                  "StockOptionLevel", "TrainingTimesLastYear", "WorkLifeBalance")

# UI
ui = fluidPage(
  titlePanel("Attrition Case Study - Exploratory Data Analysis"),
  tabsetPanel(
    tabPanel("Categorical Variables", 
             sidebarLayout(
               sidebarPanel(
                 selectInput("attrition_filter", "Filter by Attrition:", choices = c("All", "Yes", "No")),
                 selectInput("cat_var", "Select Categorical Variable:", choices = cat_vars_no_attrition)
               ),
               mainPanel(
                 div(style = "height: 1000px; overflow-y: auto;",
                     plotOutput("cat_plot", height = "500px"),
                     plotOutput("cat_count_plot", height = "500px")
                 )
               )
             )
    ),
    tabPanel("Continuous Variables", 
             sidebarLayout(
               sidebarPanel(
                 selectInput("attrition_filter", "Filter by Attrition:", choices = c("All", "Yes", "No")),
                 selectInput("cont_var", "Select Continuous Variable:", choices = continuous_vars)
               ),
               mainPanel(
                 div(style = "height: 1000px; overflow-y: auto;",
                     plotOutput("cont_hist", height = "500px"),
                     plotOutput("cont_boxplot", height = "500px")
                 )
               )
             )
    ),
    tabPanel("Discrete Variables",
             sidebarLayout(
               sidebarPanel(
                 selectInput("attrition_filter", "Filter by Attrition:", choices = c("All", "Yes", "No")),
                 selectInput("discrete_var", "Select Discrete Variable:", choices = discrete_vars)
               ),
               mainPanel(
                 div(style = "height: 1000px; overflow-y: auto;",
                     plotOutput("discrete_bar", height = "500px")
                 )
               )
             )
    )
  )
)

# Server
server = function(input, output) {
  # Filter data based on Attrition
  filtered_data = reactive({
    if (input$attrition_filter == "All") {
      df
    } else {
      df[df$Attrition == input$attrition_filter, ]
    }
  })
  
  # Categorical variables
  output$cat_plot = renderPlot({
    col_name = input$cat_var
    container_df = data.frame(value = filtered_data()[[col_name]])
    
    ggplot(container_df, aes(x = value)) +
      geom_bar(aes(y = (..count..) / sum(..count..)), fill = "#7495B8") +
      scale_y_continuous(labels = scales::percent_format()) +
      labs(x = col_name, y = "Percentage", title = paste("Percentage of", col_name)) +
      theme_few() +
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 8))
  })
  
  output$cat_count_plot = renderPlot({
    col_name = input$cat_var
    container_df = data.frame(value = filtered_data()[[col_name]])
    
    ggplot(container_df, aes(x = value)) +
      geom_bar(fill = "#7495B8") +
      labs(x = col_name, y = "Count", title = paste("Count of", col_name)) +
      theme_few() +
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 8))
  })
  
  # Continuous variables
  output$cont_hist = renderPlot({
    col_name = input$cont_var
    container_df = data.frame(value = filtered_data()[[col_name]])
    
    ggplot(container_df, aes(x = value)) +
      geom_histogram(fill = "#7495B8", bins = 30) +
      labs(x = col_name, y = "Count", title = paste("Histogram of", col_name)) +
      theme_few() +
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 8))
  })
  
  output$cont_boxplot = renderPlot({
    col_name = input$cont_var
    container_df = data.frame(value = filtered_data()[[col_name]])
    
    ggplot(container_df, aes(x = value, y = "")) +
      geom_boxplot(fill = "#7495B8") +
      labs(x = col_name, y = "", title = paste("Boxplot of", col_name)) +
      theme_few() +
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
  })
  
  # Discrete variables
  output$discrete_bar = renderPlot({
    col_name = input$discrete_var
    container_df = data.frame(value = filtered_data()[[col_name]])
    
    ggplot(container_df, aes(x = as.factor(value))) +
      geom_bar(fill = "#7495B8") +
      labs(x = col_name, y = "Count", title = paste("Bar Chart of", col_name)) +
      theme_few() +
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 8))
  })
}

# Run
shinyApp(ui, server)