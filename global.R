
library(package = "shiny")
library(package = "shinyjs")
library(package = "rdrop2")
library(package = "digest")
library(package = "dplyr")


# Validate The Student Number
validateStudentNum <- function(x)
{
    return(grepl(pattern = "[[:digit:]]",
                 x = x,
                 perl = T))
}

# Validate The National Code
validateNationalCode <- function(x)
{
    return(grepl(pattern = "^[0-9]{10}$",
                 x = x,
                 perl = T))
}

# Add An Asterisk To An Input Label
labelMandatory <- function(label) {
    tagList(
        label,
        span("*", class = "mandatory_star")
    )
}

# Get Working Directory
wd <- getwd()

# Accessing Dropbox On Shiny And Remote Servers
token <- readRDS("droptoken.rds")
drop_acc(dtoken = token)

# Save The Results To A File
saveData <- function(data) {
    # Create A Unique File Name
    fileName <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest(data))
    # Write The Data To A Temporary File Locally
    filePath <- paste(wd, "/data/", fileName, sep = "")
    write.csv(x = data, file = filePath, row.names = FALSE, quote = TRUE)
    # Upload The File To Dropbox
    rdrop2::drop_upload(file = filePath, path = "classForm", dtoken = token)
}

# Load The Results To A File
loadData <- function() {
    # Read all the files into a list
    files <- list.files(paste(wd, "/data/", sep = ""), full.names = TRUE)
    data <- lapply(files, read.csv, stringsAsFactors = FALSE) 
    # Concatenate all data together into one data.frame
    data <- do.call(rbind, data)
    data
}

# Which Fields Get Saved 
fieldsAll <- c("studentNum", "nationalCode", "selectDate")

# Load All Student Number
studentNumber <- read.csv(file = "studentNumber.csv", header = TRUE, colClasses = "character")

# 
checkNN <- function(data)
{
    splitted <- as.numeric(sapply(X = data, FUN = function(x) substring(text = x, first = 1:10, last = 1:10)))
    num <- c(10:1)
    mul <- num * splitted
    r <- sum(mul[1:9]) %% 11
    
    if (r < 2) {
        if (r == splitted[10]) {
            result = TRUE
        } else {
            result = FALSE
        }
    } else {
        if ((11 - r) == splitted[10]) {
            result = TRUE
        } else {
            result = FALSE
        }
    }
    
    return(result)
}








