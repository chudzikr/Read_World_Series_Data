#!/bin/bash

# FETCH EACH MATCH'S JSON FILE, SET A TIMER BETWEEN EACH FETCH 		#
# MATCH IS FORMATTED AS http://www.rugbyworldcup.com/match/14195	#
# curl 'http://cmsapi.pulselive.com/rugby/match/23341/timeline?language=en&altId=hgv&client=pulse' -H 'Origin: http://www.worldrugby.org' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: http://www.worldrugby.org/sevens-series/stage/1617/match/23341' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' --compressed

for F in $(cat filelist.txt) ; do


	# sleep for 5 min before executing each CURL request
	sleep 10
	# echo $F
	# curl "https://cmsapi.pulselive.com/rugby/match/${F}/stats?language=en&client=pulse" -H 'Origin: https://www.rugbyworldcup.com' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H "Referer: https://www.rugbyworldcup.com/match/${F}" -H 'Connection: keep-alive' --compressed > "${F}_timeline.json"
	# 
	#  SEVENS SERIES FETCH curl 'http://cmsapi.pulselive.com/rugby/match/23000/summary?language=en&altId=hgv&client=pulse' -H 'Origin: http://www.worldrugby.org' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.97 Safari/537.36' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: http://www.worldrugby.org/sevens-series/stage/1613/match/23000' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' --compressed
	curl "http://cmsapi.pulselive.com/rugby/match/${F}/stats?language=en&altId=hgv&client=pulse" -H 'Origin: http://www.worldrugby.org' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.80 Safari/537.36' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H "Referer: http://www.worldrugby.org/sevens-series/stage/1692/match/${F}" -H 'Connection: keep-alive' --compressed > "${F}.json"
done