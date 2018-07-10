###################################################################################
# Import directory of JSON files, extract specified player data, create single dataframe,
#
# TO DO: Remove bio columns - birthdate, etc.
#
# Written Feb '16, update Jul '16, update Dec '16
###################################################################################

library(jsonlite)

# Change to tournament's JSON data directory
# ~/Dropbox/WSS_15/json_data/TOURNAMENTDIR
setwd("~/Dropbox/rugby_data/WSS_16/json_data/downloads")

# code snippet from https://psychwire.wordpress.com/2011/06/03/merge-all-files-in-a-directory-using-r-into-a-single-dataframe/

file_list <- list.files(pattern="*.json")

for (file in file_list){

  # if the merged dataset doesn't exist, create it
  if (!exists("playerData")){

    playerData <- fromJSON(file)
    # playerData <- fromJSON("23300.json") # for single file - testing

    match <- (playerData$match)

    #create array from list
    a <- array(match)

    # data.frame match is rectangular (n_rows!= n_cols). Therefore, you cannot make a data.frame out of the column- and rownames, because each column in a data.frame must be the same length. use "reshape2:melt"

    require(reshape2)
    # match <- rownames(match)
    match <- melt(a)

    # flatten data frame, get rid of nested objects
    match <- flatten(match, recursive = TRUE)

    # Get match ID/data to join
    match.id <- (playerData$match$matchId)

    # Get team IDs
    team.id <- (playerData$match$teams$id)
    team1.id <- (team.id[1])
    team2.id <- (team.id[2])

    # Get team name
    team.name <- (playerData$match$teams$name)
    team1.name <- (team.id[1])
    team2.name <- (team.id[2])

    #Get player data
    players <- (playerData$teamStats$playerStats)

    team1 <- (players[1])
    team2 <- (players[2])
    #View(team1)
    #View(team2)
    #names(team1)

    # coerce to a data frame
    team1Df <- data.frame(team1)
    team2Df <- data.frame(team2)

    # flatten data frame, get rid of nested objects
    team1Flat <- flatten(team1Df, recursive = TRUE)
    team2Flat <- flatten(team2Df, recursive = TRUE)
    #View(team1Flat)

    # Merge the two dataframes
    team1PlyrStats <- cbind(match.id, team1.id, team1Flat)
    team2PlyrStats <- cbind(match.id, team2.id, team2Flat)

    library(gtools) #for smartbind

    # Bind two dataframes together
    totalPlyrStats <- smartbind(team1PlyrStats, team2PlyrStats, fill=NA, verbose=TRUE)

  }

  ## if the merged dataset does exist, append to it
  if (exists("playerData")) {

    library(gtools)

    temp_dataset <- fromJSON(file)
    # change the read.table(file, header=TRUE, sep="\t") to the code that reads

    #*************************
    # CREATE A FUNCTION FOR THIS?
    # match <- (temp_dataset$match)

    match <- (temp_dataset$match)

    #create array from list
    a <- array(match)

    # data.frame match is rectangular (n_rows!= n_cols). Therefore, you cannot make a data.frame out of the column and     rownames, because each column in a data.frame must be the same length. use "reshape2:melt"

    require(reshape2)
    # match <- rownames(match)
    match <- melt(a)

    # flatten data frame, get rid of nested objects
    match <- flatten(match, recursive = TRUE)

    # Get match ID/data
    match.id <- (temp_dataset$match$matchId)

    team.id <- (temp_dataset$match$teams$id)
    team1.id <- (team.id[1])
    team2.id <- (team.id[2])

    #Need to insert team.id or team name into dataframes

    #Get player data
    players <- (temp_dataset$teamStats$playerStats)

    team1 <- (players[1])
    team2 <- (players[2])

    # coerce to a data frame
    team1Df <- data.frame(team1)
    team2Df <- data.frame(team2)

    # flatten data frame, get rid of nested objects
    team1Flat <- flatten(team1Df, recursive = TRUE)
    team2Flat <- flatten(team2Df, recursive = TRUE)
    #View(team1Flat)

    # Merge the two dataframes
    ###### Need to change the column names for team1Id, team2Id (see column headers #############
    # team1PlyrStats <- cbind(match.id, team1.id, team1Flat)
    team1PlyrStats <- cbind(match.id, team1Flat)
    # team2PlyrStats <- cbind(match.id, team2.id, team2Flat)
    team2PlyrStats <- cbind(match.id, team2Flat)

    library(gtools) #for smartbind

    #Need to create a temporary DF to hold current match's records, then add the temp DF to the "total" DF

    #doesn't work... mistmatch error: "numbers of columns of arguments do not match" > use smartbind
    # totalPlyrStats <- rbind(team1PlyrStats, team2PlyrStats)
    temp_totalPlyrStats <- smartbind(team1PlyrStats, team2PlyrStats, fill=NA)

    totalPlyrStats <- smartbind(temp_totalPlyrStats, totalPlyrStats, fill=NA, verbose=TRUE)

    # remove temp dataset
    rm(temp_dataset)

  }
}
# remove the duplicate first two rows - not sure why they appear?
# Also have an extra column in the first position
# Data <- Data[,-(2:3),drop=FALSE]
# totalStats <- totalStats[-c(1, 2),]

write.csv(totalPlyrStats, file = "~/Dropbox/rugby_data/WSS_16/output/TOTAL-plyr-stats_2016-17_WSS_to_Singapore.csv", row.names = FALSE)
