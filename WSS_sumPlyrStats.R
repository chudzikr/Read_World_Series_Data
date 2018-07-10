# Sum players stats for whole tournament using data.table
# Get Player Stats
# Written Feb '16, updated Jul '16
# See vignette at https://rawgit.com/wiki/Rdatatable/data.table/vignettes/datatable-intro-vignette.html
library(data.table)

setwd("/output")

PlyrStats <- fread("TOTAL-plyr-stats_2016-17_WSS_Capetown.csv")

DT <- as.data.table(PlyrStats)

# select all teams by name, average points across all games
#teamPoints <- totalStats[, .(Avg_Points = mean(na.omit(scores))), by=name]

# See sumTeamStats

# sum only integer columns
sumPlyrStats <- DT[, lapply(.SD, sum, na.rm=TRUE), by=player.name.display, .SDcols=c(21:33) ]

write.csv(sumPlyrStats, file = "SUM-plyr-stats_2016-17_WSS_Capetown.csv", row.names = FALSE)

