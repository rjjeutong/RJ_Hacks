#install.packages('downloader')

#library(downloader)
library(rvest)
library(tidyverse)
library(XML)

folder_location <- choose.dir(getwd(), "Choose a suitable folder")

u <- 'https://towardsdatascience.com/springer-has-released-65-machine-learning-and-data-books-for-free-961f8181f189'

pg <- read_html(u)

links <- pg %>% 
  html_nodes('.ih') %>% 
  html_attr('href')

getbooks <- function(x){
  pg2 <- read_html(x)
  
  pdflink <- pg2 %>% 
    html_nodes('.test-bookpdf-link') %>% 
    html_attr('href') %>% 
    .[1]
  
  booklink <- paste0('https://link.springer.com', pdflink)
  
  booktitle <- pg2 %>% 
    html_nodes('h1') %>%
    html_text(trim = T)
  
  download.file(url = booklink,
                destfile = paste0(folder_location,'\\', booktitle,'.pdf'), mode = 'wb')
  
  Sys.sleep(time = sample(5:10, size = 1, replace = T))
}

links[-1] %>% 
  walk(.x = ., .f = safely(getbooks))
