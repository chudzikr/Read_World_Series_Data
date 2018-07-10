# Sum players stats for whole tournament using data.table
# Get Player Stats
# See vignette at
# https://rawgit.com/wiki/Rdatatable/data.table/vignettes/datatable-intro-vignette.html
# Written Feb '16, updated Jul '16
library(data.table)

setwd("~/Dropbox/rugby_data/WSS_16/output")

totalStats <- fread("TOTAL-stats_2016-17_WSS_season_to_Singapore.csv")

DT <- as.data.table(totalStats)

# TO DO - how to subset multiple columns?
DT <- DT[, setdiff(colnames(DT), "annotations"), with=FALSE]
#################################################
# TO DO: need to select only applicable columns - annotations, and bio info cols  - BE SURE it doesn't affect the summing and averaging functions later in code #
#################################################
#
# select all teams by name, average points across all games
# teamPoints <- totalStats[, .(Avg_Points =
# mean(na.omit(scores))), by=name]

# Can't sum ALL columns using .SD (see documentation) won't
# work - can't sum character columns

# sum only columns containing integers -- need to remove
# percentage columns - .SDcols=c(7:24) contains them
totalSumStats <- DT[, lapply(.SD, sum, na.rm = TRUE), by = abbreviation,
  .SDcols = c(7:24)]

# get means of columns with percentages sumTeamStats2 <- DT[,
# lapply(.SD, mean, na.rm=TRUE), by=name,
# .SDcols=c('BallPossessionLast10Mins', 'PcTerritoryFirst',
# 'PcTerritorySecond', 'PcPossessionFirst',
# 'PcPossessionSecond', 'Possession', 'TackleSuccess',
# 'Territory', 'TerritoryLast10Mins') ]

# join dataframes -- MAKE SURE ALL COLUMNS ARE ACCOUNTED FOR;
# Need to round means totalSumStats <-
# merge(sumTeamStats1,sumTeamStats2,by='name')

write.csv(totalSumStats, file = "SUM_team-stats_2016-17_WSS_to_Singapore.csv",
  row.names = FALSE)

#### Get mean/avg for each indicator
totalAvgStats <- DT[, lapply(.SD, mean, na.rm = TRUE), by = abbreviation,
  .SDcols = c(7:24)]

write.csv(totalAvgStats, file = "AVG_team-stats_2016-17_WSS_to_Singapore.csv",
  row.names = FALSE)
