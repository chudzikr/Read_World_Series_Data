#Process World Sevens Series match timeline
# Written Feb '16, update Jul '16
#
library(jsonlite)
setwd("/json_data/downloads")

#
# matchData <- fromJSON("22893.json")
#
# # Get team stats
# #teamstats1 <- (matchData$teamStats[1])
#
# teams <- (matchData$match$teams)
# # transpose teams
# # teamCols <- t(teams)
#
# # Get match ID/data to join
# matchId <- (matchData$match$matchId)
# # View(match)
#
# # get scores
# scores <- (matchData$match$scores)
#
# # get team stats
# teamstats <- (matchData$teamStats$stats)
#
# # Get player stats (need to unlist)
# # teamstats2 <- data.frame(unlist(data$teamStats[2]))
#
# # Merge the two dataframes
# totalStats <- cbind(matchId, teams, scores, teamstats)
#
# write.csv(totalStats, file = "TOTAL-stats.csv")

############################################################

# code snippet from https://psychwire.wordpress.com/2011/06/03/merge-all-files-in-a-directory-using-r-into-a-single-dataframe/

file_list <- list.files(pattern="*.json")

for (file in file_list){

  # if the merged dataset doesn't exist, create it
  if (!exists("matchData")){
    # matchData <- fromJSON(file, flatten=TRUE)
    matchData <- fromJSON(file)
    # change the read.table(file, header=TRUE, sep="\t") to the code that reads

    teams <- (matchData$match$teams)
    # transpose teams
    # teamCols <- t(teams)

    # Get match ID/data to join
    # Need to insert into both rows... ????
    matchId <- (matchData$match$matchId)
    # View(match)

    # Get Event ID - i.e., which tournament in the series
    eventStop <- (matchData$match$events$id)

    # get scores
    scores <- (matchData$match$scores)
    # View(scores)
    # Need to join to table/df

    teamstats <- (matchData$teamStats$stats)

    # Merge the two dataframes
    totalStats <- cbind(matchId, eventStop, teams, scores, teamstats)

  }
  # } #TESTING

  ## if the merged dataset does exist, append to it
  if (exists("matchData")) {

    library(gtools)

    temp_dataset <- fromJSON(file)
    # change the read.table(file, header=TRUE, sep="\t") to the code that reads

    #*************************
    # CREATE A FUNCTION FOR THIS?
    match <- (temp_dataset$match)

    #create array from list
    #temp_match_arr <- array(match)

    # data.frame match is rectangular (n_rows!= n_cols). Therefore, you cannot make a data.frame out of the column- and rownames, because each column in a data.frame must be the same length. use "reshape2:melt"

    # NEED TO FIX - FLATTENINGN MATCH DATA INTO ONE STRING/ROW

    #require(reshape2)
    # match <- rownames(match)
    #match <- melt(a)

    #************************
    teams <- (temp_dataset$match$teams)
    # RE_ENABLE
    # transpose teams

    # Get match ID/data to join
    matchId <- (temp_dataset$match$matchId)

    # Get Event ID - i.e., which tournament in the series
    eventStop <- (temp_dataset$match$events$id)

    # get scores
    scores <- (temp_dataset$match$scores)
    # RE_ENABLE

    teamstats <- (temp_dataset$teamStats$stats)
    teamstats1 <- teamstats[1,]
    teamstats2 <- teamstats[2,]
    totalTeamStats <- smartbind(teamstats1, teamstats2)
    #temp_teamstats_arr <- array(temp_teamstats)

    # data.frame match is rectangular (n_rows!= n_cols). Therefore, you cannot make a data.frame out of the column- and rownames, because each column in a data.frame must be the same length. use "reshape2:melt"


    # Merge the two dataframes
    # temp_totalStats <- cbind(temp_matchId, temp_teams, temp_scores, temp_teamstats)
    temp_totalStats <- cbind(matchId, eventStop, teams, scores, totalTeamStats)



    #matchData<-rbind(matchData, temp_dataset)
    #totalStats <- smartbind(totalStats, temp_totalStats, fill=0)
    totalStats <- smartbind(totalStats, temp_totalStats)
    #totalStats <- totalStats[-annotations]

    # remove temp dataset
    #rm(temp_totalStats)

  }
}
# remove the duplicate first two rows - not sure why they appear?
# Also remove column 7 -c(7) - "annotations"
# Data <- Data[,-(2:3),drop=FALSE]
totalStats <- totalStats[-c(1, 2),-c(7)]

write.csv(totalStats, file = "~/Dropbox/rugby_data/WSS_16/output/TOTAL-stats_2016-17_WSS_season.csv", row.names = FALSE)
