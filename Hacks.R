library(tidyverse)

## use keep or discard to select only a specific data type
iris %>% head()
iris %>% keep(is.numeric) %>% head()
iris %>% keep(is.factor) %>% head()
iris %>% discard(is.numeric) %>% head()

## Create an expression to feed to map ##
ethnicities <- c("asian", "middle eastern", "black", "native american", "indian", 
                 "pacific islander", "hispanic / latin", "white", "other")

ethnicity_vars <- ethnicities %>% 
  purrr::map(~ expr(ifelse(like(ethnicity, !!.x), 1, 0))) %>%
  purrr::set_names(paste0("ethnicity_", gsub("\\s|/", "", ethnicities)))

ethnicity_vars <- ethnicities %>% 
  purrr::map(~ expr(ifelse(like(ethnicity, !!.x), 1, 0))) %>%
  purrr::set_names(paste0("ethnicity_",
                          str_replace_all(ethnicities, "\\s|/", replacement = "")))

##### split data while running regression
mtcars %>% 
  split(.$cyl) %>% 
  map(~lm(mpg ~ wt, data = .)) %>% 
  map(summary) %>% 
  map_dbl(~.$r.squared)
