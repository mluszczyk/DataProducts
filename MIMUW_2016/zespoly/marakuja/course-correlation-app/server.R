# library(ggplot2)

source("input.R")
source("logic.R")


shinyServer(function(input, output) {
  
  positive_subject <- reactive ({
    validate(
      need(input$`min-common`, "Wybierz minimalną liczbę wspólnych uczestników")
    )
    course <- input$przedmiot
    sorted <- sort_courses_passed(course, input$`min-common`)
    validate(
      need(nrow(sorted) > 0, "Brak pasujących przedmiotów")
    )
    # działa tylko przy N = 1
    print(sorted)
    sorted
  })
  
  negative_subject <- reactive ({
    course <- input$przedmiot
    validate(
      need(input$`min-common`, "Wybierz minimalną liczbę wspólnych uczestników")
    )
    sorted <- sort_courses_failed(course, input$`min-common`)
    validate(
      need(nrow(sorted) > 0, "Brak pasujących przedmiotów")
    )
    # działa tylko przy N = 1
    print(sorted)
    sorted
  })
  
  output$tableNegative = renderDataTable({positive_subject()})
  output$tablePositive = renderDataTable(negative_subject())
})
