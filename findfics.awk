function makeArray(file, arr) {
    while ((getline < file) > 0) {
	arr[$0] = $0
    }
    if (close(file)) {
	print "Could not close file" > "/dev/stderr"
	return 0
    }
    return 1
}

BEGIN {
    FS = ","
    taglist = "./taglist" #related tags
    fics = "./works-20210226.csv" #list of all works on site
    ficlist = "./ficlist" #output: date|numworks
    makeArray(taglist, tags)

    getline < fics #skip first line because it contains field names, not data
    
    while ((getline < fics) > 0) {
	hasTag = 0 #reset flag
	split($6, ftags, "+") #$6 is + delimited list of tag ids
	for (i in ftags) {
	    if (ftags[i] in tags) hasTag = 1 #set flag if list contains a relevant tag
	}
	if (hasTag) {
	    #only need the date
	    stats[$1]++
	} else if (!stats[$1]) {
	    stats[$1] = 0 #still need the other works in the list
	}
    }

    #sort by date and output
    for (i in stats) print i "|" stats[i] | "sort > " ficlist
}
