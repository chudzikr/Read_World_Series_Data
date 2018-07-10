#Process World Sevens Series match timeline

library(jsonlite)
setwd("~/Dropbox/WSS_16/json_data/Sydney")


matchData <- fromJSON("24357.json")

# Get team stats
#teamstats1 <- (matchData$teamStats[1])

teams <- (matchData$match$teams)
# transpose teams
# teamCols <- t(teams)

# Get match ID/data to join
matchId <- (matchData$match$matchId)

# Get Event ID - i.e., which tournament in the series
eventStop <- (matchData$match$events$id)

# get scores
scores <- (matchData$match$scores)

# get team stats
teamstats <- (matchData$teamStats$stats)

# Get player stats (need to unlist)
teamstats2 <- (matchData$teamStats$playerStats$player[1])

# Merge the two dataframes
totalStats <- cbind(matchId, eventStop, teams, scores, teamstats)

write.csv(totalStats, file = "single-game_23088.csv", row.names = FALSE)
