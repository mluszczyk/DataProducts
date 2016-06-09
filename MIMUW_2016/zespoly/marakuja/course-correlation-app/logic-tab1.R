source("courses.R")
source("utils.R")

get_subjects_codes_mock <- function() {
  courses_vector
}

summarise_data <- function(courseB, min_common, filterA, min_grade_B) {
  subjects <- get_subjects_codes_mock()
  subjects <- subjects[subjects != courseB]
  
  rate_data <- data.frame(subject=character(0), percent=numeric(0), students_min_grade=numeric(0),
                          all_students=numeric(0), stringsAsFactors=FALSE)
  
  for (subject in subjects) {
    dataA <- filterA(get_last_grade_for_course(data, subject))
    dataB <- get_last_grade_for_course(data, courseB)
    joined <- dataB %>% inner_join(dataA, by="OSOBA")
    all <- count(joined)
    filtered <- count(joined %>% filter(OCENA_LICZBOWA.x >= min_grade_B))
    if (filtered >= min_common) {
      percent <- round(filtered/all * 100, 2)
      rate_data <- rbind(rate_data, data.frame(subject=subject, percent=percent,
                                               students_min_grade=filtered, all_students=all))
    }
  }
  rate_data
}

sort_courses_passed <- function(courseB, min_common, min_grade_B) {
  data <- summarise_data(courseB, min_common, filter_passed, min_grade_B)
  names(data) <- c("Przedmiot A",
                   "Procent studentów, którzy uzyskali co najmniej wybraną ocenę",
                   "Liczba studentów, którzy zdali A, a z B uzyskali co najmniej wybraną ocenę",
                   "Liczba studentów, którzy zdali A")
  data %>% arrange(desc(`Procent studentów, którzy uzyskali co najmniej wybraną ocenę`))
}

sort_courses_failed <- function(courseB, min_common, min_grade_B) {
  data <- summarise_data(courseB, min_common, filter_failed, min_grade_B)
  names(data) <- c("Przedmiot A",
                   "Procent studentów, którzy uzyskali co najmniej wybraną ocenę",
                   "Liczba studentów, którzy nie zdali A, a z B uzyskali co najmniej wybraną ocenę",
                   "Liczba studentów, którzy nie zdali A")
  data %>% arrange(`Procent studentów, którzy uzyskali co najmniej wybraną ocenę`)
}