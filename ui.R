# Pooya Shirazi
# September 2018

# CSS to use in the app
appCSS <- "
.mandatory_star { color: red; }
.shiny-input-container { margin-top: 25px; }
#submit_msg { margin-left: 15px; }
#error { color: red; }
body { background: #fcfcfc; }
#header { background: #fff; border-bottom: 1px solid #ddd; margin: -20px -15px 0; padding: 15px 15px 10px; }
"

shiny::shinyUI(
    shiny::fluidPage(
        
        shinyjs::useShinyjs(),
        
        shinyjs::inlineCSS(appCSS),
        
        title = "Choose Practical Irrigation Class",
        
        shiny::hr(),
        
        h1("This Page is for Choosing the Date of Practical Irrigation Class."),
        
        h2("Attention:"),
        
        p("1. Pay Attention to your Schedule, because Changing the Time and the Date of the Class is Impossible!"),
        
        p("2. Enter your National Code Correctly (10 Digits)."),
        
        shiny::hr(),
        
        div(id = "form",
            
            shiny::textInput(
                inputId = "studentNum",
                label = labelMandatory("FUM Student Number:"),
                placeholder = "Like This: 9016594018"
            ),

            shiny::textInput(
                inputId = "nationalCode",
                label = labelMandatory("National Code:"),
                placeholder = "Like This: 0715265241"
            ),

            shiny::selectInput(
                inputId = "selectDate",
                label = "Select Date For Your Class:",
                choices = list(
                    "Sunday    : 08-10" = 01,
                    "Sunday    : 10-12" = 02,
                    "Sunday    : 12-14" = 03,
                    "Sunday    : 14-16" = 04,
                    "Sunday    : 16-18" = 05,
                    "Monday    : 08-10" = 06,
                    "Monday    : 10-12" = 07,
                    "Monday    : 12-14" = 08,
                    "Monday    : 14-16" = 09,
                    "Monday    : 16-18" = 10,
                    "Tuesday   : 08-10" = 11,
                    "Tuesday   : 10-12" = 12,
                    "Tuesday   : 12-14" = 13,
                    "Tuesday   : 14-16" = 14,
                    "Tuesday   : 16-18" = 15
                ),
                selected = 1
            )
        ),
        
        shiny::br(),
        
        shiny::actionButton(
            inputId = "submitButton",
            label = "Submit"
        ),
        
        shinyjs::hidden(
            span(id = "submit_msg", "Submitting..."),
            div(id = "error", div(br(), tags$b("Error: "), span(id = "error_msg"))
            )
        ),
        
        shinyjs::hidden(
            div(id = "thankyou_msg",
                h3("Thanks, Your Response Was Submitted Successfully!"))
        ),
        
        shiny::hr(),
        
        shiny::em(
            shiny::span("Created by "),
            shiny::a("Pooya Shirazi", href = "https://shirazipooya.github.io"),
            shiny::span(", Sept 2018"),
            shiny::br(),
            shiny::br()
        )
    )
)


