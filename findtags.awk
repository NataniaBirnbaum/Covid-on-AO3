BEGIN {
    FS = ","

    tags = "./tags-20210226.csv" #list of all tags used in works
    out = "./taglist" #output file of related tags found
    keywords = "./keywords" #input = pipe delimited list of keywords

    #read input
    if ((getline < keywords) > 0) {
	options = $0
    }

    #create regex
    options = "[^a-z]" options "[^a-z]"
    #print options # debugging
    
    #search through all tags
    while ((getline < tags) > 0) {
        line = tolower($3) #for consistency
        if (line ~ options) {
	    #print $0 # debugging
            print $1 > out #only need numerical tag id
	}
    }
}
