# Pooya Shirazi
# September 2018

shiny::shinyServer(func = function(input, output, session) {
    
    loadStuNum <- loadData()
    
    n <- loadStuNum %>%
        group_by(Date) %>%
        summarise(count = n()) %>% 
        filter(count >= 2) %>% 
        pull(Date)
    
    
        
    
    

    # Only Enable The Submit Button When The Mandatory Fields Are Validated
    shiny::observe({
        if (input$studentNum == "" || input$nationalCode == "" || !validateStudentNum(input$studentNum) || !validateNationalCode(input$nationalCode) || !checkNN(input$nationalCode) || !any(studentNumber == input$studentNum) || any(loadStuNum[1] == input$studentNum) || any(n == input$selectDate)) {
            shinyjs::toggleState(id = "submitButton", condition = FALSE)
        } else {
            shinyjs::toggleState(id = "submitButton", condition = TRUE)
        }
    })
    
    # Gather All The Form Inputs
    formData <- reactive({
        data <- data.frame("Student Number" = input$studentNum,
                           "National Code" = input$nationalCode,
                           "Date" = input$selectDate)
        data
    })
    
    # When The Submit Button Is Clicked, Submit The Response
    shiny::observeEvent(
        eventExpr = input$submitButton,
        {
            # User Experience Stuff
            shinyjs::disable(id = "submitButton")
            shinyjs::show(id = "submit_msg")
            shinyjs::hide(id = "error")
            
            # Save The Data (Show An Error Message In Case Of Error)
            tryCatch(
                expr = {
                    saveData(formData())
                    shinyjs::reset("form")
                    shinyjs::hide("form")
                    shinyjs::show("thankyou_msg")
                },
                error = function(err){
                    shinyjs::html("error_msg", err$message)
                    shinyjs::show(id = "error", anim = TRUE, animType = "fade")
                },
                finally = {
                    shinyjs::enable("submit")
                    shinyjs::hide("submit_msg")
                }
            )
        }
    )
})
