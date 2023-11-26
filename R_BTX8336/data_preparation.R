# Authors: Christian Franke, Fabian Bürki
# Data Preparation for R-Project
# Source: https://archive.ics.uci.edu/ml/datasets/Simulated+Falls+and+Daily+Living+Activities+Data+Set
# Download Data Folder and unzip Tests.rar to your own path
# copy your path to the variable .path_f
rm(list=ls())


# Load libraries, set options and paths
library(tidyverse)
options(digits = 20)
.path_c <- "C:/Users/chris/Desktop/BFH/S04/R/project_data/"
.path_f <- "~/Desktop/BFH/Semester 4/R/Projekt/data/Tests/"
path_data <- ifelse(Sys.info()[["user"]] == "chris", .path_c, .path_f)


# extract meta-data (Gender, Weight, Height, Age of participants) from Bilgi.txt files
all_bilgi <- paste0(path_data, list.files(path_data, recursive = TRUE, pattern = 'Bilgi.txt'))
bilgi<-data.frame()
for (i in all_bilgi) {
  tmp <- read.table(i, header=FALSE, sep = ":")
  tmp <- cbind(str_sub(str_sub(i, -13,-1),1,3), tmp)
  bilgi <- rbind(bilgi,tmp)
}
rm(tmp, i)


# Load data files of person 101
path_data_import <- paste0(path_data, "101", "/Testler Export/")
all_value_files <- paste0(path_data_import, list.files(path_data_import, recursive = TRUE, pattern = '[0-9]{6}.txt'))


# Loop through files to populate dataframe with >500'000 obs. for one participant (Might take a while!)
test_data <- data.frame()
for (i in all_value_files) {
  tmp <- read.table(i
                    , header=TRUE               # column names
                    , sep= "\t"                 # tabuar separator of text-files
                    # , numerals = "no.loss"      # Numeric not as "precise" like char, because 64 bits
                    , comment.char="/"          # ignore comments (lines 1 to 4)
  )
  tmp <- cbind(i, tmp)
  test_data <- rbind(test_data, tmp)
}
rm(tmp, i, all_bilgi, all_value_files, path_data, path_data_import)



# Definition of the sensors
sensor_mapping <- data.frame(sensor_nr = c("340506", "340527", "340535", "340537", "340539", "340540"),
                             sensor_name = c("Head", "Chest", "Waist", "Wrist", "Thigh", "Ankle"))


# save data to R.Data
save(list=ls(), file = "data_preparation.RData")


# end of file
