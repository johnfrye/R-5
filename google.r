

# google.search.count("due on monday")
al3x.google.search.count = function(search=NULL) {
  fromJSON(getForm("http://ajax.googleapis.com/ajax/services/search/web",
    q =search, v = "1.0"))$responseData$cursor$estimatedResultCount
}

al3x.google.spreadsheet = function (key) {
  al3x.lib("RCurl")
  # ssl validation off
  ssl.verifypeer = FALSE

  tt = getForm("https://spreadsheets.google.com/spreadsheet/pub", 
                hl ="en_GB",
                key = key, 
                single = "true", gid ="0", 
                output = "csv", 
                .opts = list(followlocation = TRUE, verbose = TRUE)) 

  read.csv(textConnection(tt), header = TRUE)
}