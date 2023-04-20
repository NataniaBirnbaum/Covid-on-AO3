BEGIN {
    FS = ","
    
    data = "./time-series.csv" #input = csv of COVID cases by day per country/province
    out = "./covidCases" #output = date|number of global cases

    #read first line = dates
    if ((getline < data) > 0) {
        split($0, dates)
    }
    #fix date formatting
    for (i = 1; i <= length(dates); i++) {
	split(dates[i], a, "/")
	if (length(a[1]) < 2) a[1] = "0" a[1]
	if (length(a[2]) < 2) a[2] = "0" a[2]
	dates[i] = "20" a[3] "-" a[1] "-" a[2]
    }
    #fields 1, 2, 3, 4 = State/Province, Country, Lat, Long
    while ((getline < data) > 0) {
	i = 5 #first field with dates
	while (dates[i]) {
	    totals[dates[i]] += $i
	    i++
	}
    }
    for (i in totals) {
	print i "|" totals[i] | "sort >" out
    }
}
