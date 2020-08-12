library(tidyverse)  
library(rvest) 

u <- 'https://www.zillow.com/homes/20744_rb/'
pg <- read_html(u)

Sys.sleep(20)

temp_link <- pg %>% 
  html_nodes('.kdxFbt a') %>% 
  html_attr('href')

links <- paste0('https://www.zillow.com', temp_link)

scraper <- function(x){
  Sys.sleep(sample(7:12, 1, T))
  cat('.')
  pg <- read_html(x)
  
  price <- pg %>% 
    html_nodes(".list-card-price") %>% 
    html_text() %>% 
    tolower() %>% 
    str_replace_all(string = ., pattern = '[est|.|$|,|\\s]', replacement = '') %>% 
    as.numeric()
  
  address <- pg %>% 
    html_nodes('.list-card-addr') %>% 
    html_text(trim = T)
  
  itemlinks <- pg %>% 
    html_nodes('.list-card-info .list-card-link') %>% 
    html_attr(name = 'href')
  
  type <- pg %>% 
    html_nodes('.list-card-type') %>% 
    html_text(trim = T)
  
  tibble(address, price, type, itemlinks)
}

mydata <- links %>% 
  map_df(.x = ., .f = scraper)

nrow(mydata)

write_csv(x = mydata,
          path = paste0('C:/Users/rjeut/Documents/Code/R Hacks/zillow-',Sys.Date(),'.csv'))
