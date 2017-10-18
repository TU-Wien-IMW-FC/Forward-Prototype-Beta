jscode <- " 
shinyjs.collapse = function(boxid) {
$('#' + boxid).closest('.box').find('[data-widget=collapse]').click();
}
"

ui <- dashboardPage(
  
  dashboardHeader(
    title = "OntoREA© Prototype"
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Forward Pricing", tabName = "forwardpricing", icon = icon("balance-scale")),
      menuItem("Option Pricing", tabName = "optionpricing", badgeColor = "red", badgeLabel = "help!", icon = icon("road")),
      menuItem("Table Explorer", tabName = "tableexplorer", icon = icon("gear"))
    )
  ),
  
  dashboardBody(
    useShinyjs(), #necessary for remote box-collapsing
    extendShinyjs(text = jscode),#necessary for remote box-collapsing
    
    tabItems(
      # First tab content
      tabItem(tabName = "forwardpricing",
              h2("Forward Pricing"),
              fluidRow(
                box(
                  id = "box_Do", title = "First Step", width = 3, align="center", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  collapsed = FALSE,
                  
                  
                  
                  
                  
               #   title = "Subsequent Pricings",width = 4, status = "primary", solidHeader = TRUE, collapsible = TRUE,
                  textInput("subsequentPricingStock_ID", "Stock ID", value = 1, width = 150),
                  textInput("subsequentPricingStock_Derivative", "Stock Derivative ID", value = 1, width = 150),
                  dateInput("subsequentPricingDate", "Actual pricing date", value= "2020-01-01", min = "2020-01-01"),
                  sliderInput("subsequentStockPrice", "Actual stock price:", 0, 250, 0),
                #  sliderInput("subsequentPricingVolatility", "Actual stock volatility", 0, 100, 0),
                  actionButton("addSubsequentPricingObservation", "Add Observation!"),
                  
                  
                  
                  
                  
                  
                  
                  actionButton("button_Do", "Do")
                ),
                
                box(
                  id = "box_Plan", title = "Second Step", width = 3, align="center", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  collapsed = TRUE,
                  actionButton("button_Plan", "Plan")
                ),
                
                box(
                  id = "box_Check", title = "Third Step", width = 3, align="center", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  collapsed = TRUE,
                  actionButton("button_Check", "Check")
                ),
                
                box(
                  id = "box_Act", title = "Fourth Step", width = 3, align="center", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  collapsed = TRUE,
                  actionButton("button_Act", "Act")
                ),
                box(
                  title = "Clear DB",width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE,
                  actionButton("clearStock_InformationDB", "Clear DB")
                  
                ),
                
                box(
                  title = "Initial Pricing",width = 6, status = "primary", solidHeader = TRUE, collapsible = TRUE,
                  
                  dateInput("initialPricingDate", "Initial pricing date", value= "2020-01-01", min = "2020-01-01"),
                  dateInput("initialMaturityDate", "Maturity date", value= "2021-01-01", min = "2020-01-01"),
                  
                  sliderInput("initialStockPrice", "Initial stock price:", 0, 250, 0),
                  sliderInput("initialInterestRate", "Interest rate:", 0, 100, 0),
                  
                  actionButton("initialReadFile", "Load from ini.rds"),
                  actionButton("initialSaveFile", "Save to ini.rds")
                ),
                
                box(
                  title = "Subsequent Pricings",width = 4, status = "primary", solidHeader = TRUE, collapsible = TRUE,
                  textInput("subsequentPricingStock_ID", "Stock ID", value = 1, width = 150),
                  textInput("subsequentPricingStock_Derivative", "Stock Derivative ID", value = 1, width = 150),
                  dateInput("subsequentPricingDate", "Actual pricing date", value= "2020-01-01", min = "2020-01-01"),
                  sliderInput("subsequentStockPrice", "Actual stock price:", 0, 250, 0),
                  sliderInput("subsequentPricingVolatility", "Actual stock volatility", 0, 100, 0),
                  actionButton("addSubsequentPricingObservation", "Add Observation!")
                  
                ),
                
                box(
                  title = "Timeline",width = 12, status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  dygraphOutput("timeline", height = 250))
              )
              
      ),
      # Second tab content
      tabItem(tabName = "optionpricing",
              h2("Option Pricing")
      ),
      
      # third tab content
      tabItem(tabName = "tableexplorer",
              h2("Table Explorer"),
              
              fluidRow(
                box(
                  title = "Table: Stock_Information", width = 12, align="center", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  actionButton("load_table_Stock_Information", "Load from database"),
                  dataTableOutput('table_Stock_Information')
                  ),
                
                box(
                  title = "Table: Liability", width = 3, align="center", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  actionButton("load_table_Liability", "Load from database"),
                  dataTableOutput('table_Liability')
                )
                
              )
      )
    )
  )
)
