library(shiny)

source("courses.R")


courses_choices <- courses_vector
default_course_B <- "Języki, automaty i obliczenia"
default_course_A <- "Matematyka dyskretna"

shinyUI(fluidPage(
  titlePanel("Porównanie przedmiotów z informatyki, MIMUW"),
  tabsetPanel(
    tabPanel("Znajdź skorelowane przedmioty",
      sidebarLayout(
        sidebarPanel(
          em("Zdanie lub niezdanie których przedmiotów najbardziej koreluje
             z uzyskaniem przynajmniej oceny X z przedmiotu B?"),
          hr(),
          selectInput(inputId = "selected_course",
                      label = "Przedmiot B",
                      choices = courses_choices,
                      selected = default_course_B
          ),
          selectInput(inputId = "min-grade",
                      label = "Ocena X",
                      choices = c(2, 3, 3.5, 4, 4.5, 5),
                      selected = 4),
          
          numericInput("min-common-students", "Minimalna liczba studentów z oceną co najmniej X",
                       10, min = 1),
          hr(),
          p("Kliknięcie na wiersz tabeli prowadzi do szczegółowego porównania dwóch
            przedmiotów.")
        ),
        mainPanel(
          h3(textOutput("headerPassed")),
          p(textOutput("descriptionPassed")),
          plotOutput("corDiagramPassed"),
          br(), br(),
          dataTableOutput("tablePassed"),
          tags$style(type="text/css", '#tablePassed tfoot {display:none;}'),
          h3(textOutput("headerFailed")),
          p(textOutput("descriptionFailed")),
          plotOutput("corDiagramFailed"),
          br(), br(),
          dataTableOutput("tableFailed"),
          br(), br(),
          tags$style(type="text/css", '#tableFailed tfoot {display:none;}')
        )
      )
    ),
    tabPanel("Porównaj dwa przedmioty",
      sidebarLayout(
        sidebarPanel(
          em("Jak zdanie bądź niezdanie przedmiotu A koreluje z uzyskaniem poszczególnych
             ocen z przedmiotu B?"),
          hr(),
          selectInput(inputId = "course_a",
                      label = "Przedmiot A",
                      choices = courses_choices,
                      selected = default_course_A),
          selectInput(inputId = "course_b",
                      label = "Przedmiot B",
                      choices = courses_choices,
                      selected = default_course_B), br(),
          actionButton("change-btn", "Zmień kolejność")
        ),
        mainPanel(
          h3(textOutput("headerTwoCourses")), br(),
          p(textOutput("legendCountSummary")),
          tableOutput("countSummary"), br(),
          p(textOutput("legendTwoCoursesDiagram")),
          plotOutput("corDiagramTwoCourses"), br(),
          p(textOutput("legendTwoCourses")),
          tableOutput("tableTwoCourses")
        )
      )
    ),
    tabPanel("O programie", br(),
      p("Program został przygotowany w ramach kursu JNP2 pod opieką
        pana dr. hab. Przemysława Biecka."),
      p("Autorzy: Szmon Dziewiątkowski, Michał Łuszczyk, Anna Prochowska."), br(),
      p("Prezentowane są przedmioty obowiązkowe i obieralne dla kierunku informatyka."),
      p("Wszystkie kursy o tej samej nazwie są złączone i traktowane jak jeden kurs."),
      p("Uwzględniamy tylko oceny z pierwszego terminu i z pierwszego podejścia studenta do przedmiotu."),
      p("W przypadku, gdy w bazie jest więcej niż jedna taka ocena, wybieramy najlepszą z nich.")
    )
  )
))
