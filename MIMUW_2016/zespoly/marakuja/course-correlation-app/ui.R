library(shiny)

source("input.R")

nazwyPrzedmiotow <- get_subjects_names() 

shinyUI(fluidPage(
  titlePanel("Zależność rozkładu ocen z przedmiotu B od przedmiotu A"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "przedmiot1", 
                  label = "Wybierz przedmiot A",
                  choices = nazwyPrzedmiotow,
                  selected = "Bazy danych"
                  ),
      selectInput(inputId = "przedmiot2", 
                  label = "Wybierz przedmiot B",
                  choices = nazwyPrzedmiotow,
                  selected = "Aplikacje WWW"
      )
    ),
    mainPanel(
      plotOutput("corDiagram"),
      dataTableOutput("corTable")
    )
  )
))
