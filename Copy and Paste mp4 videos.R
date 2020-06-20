
library(tidyverse)

#create the folder where all the vidoes will be places
to_path <- 'C:\\Users\\rjeut\\Documents\\Programming R a Modern Approach\\Course mp4 Videos'

#run this once to create the folder
dir.create(path = to_path)

#main folder. Vidoes are in different folder from this folder
my_path <- "C:\\Users\\rjeut\\Documents\\Camtasia\\1 R Course"

#get the .tscproj. these are files not folders
proj_files <- dir(path = my_path, pattern = '.tscproj', full.names = F)

#all the files in the my_path folder
all_files <- list.files(path = my_path)

#Separate the folders and keep their names in a vector
folders <- all_files[!all_files %in% proj_files]

#try for one
#The whole path to the mp4
mp4 <- dir(path = paste0(my_path,'\\',folders[1]),
           pattern = '.mp4', full.names = T)

file.copy(from = mp4,
          to = to_path)

# prepare function for map() or walk()

copymp4 <- function(x){
  mp4 <- dir(path = paste0(my_path,'\\',x),
      pattern = '.mp4', full.names = T)
  file.copy(from = mp4,
            to = 'C:\\Users\\rjeut\\Documents\\Programming R a Modern Approach\\Course mp4 Videos')
}

folders %>% 
  purrr::walk(.x = ., .f = copymp4)


