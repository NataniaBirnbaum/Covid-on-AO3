#for more detail, see "notes"

#run final program
all: plot.pdf
	python3 plot.py

#remove intermediate files
clean:
	rm caseData covidCases ficData ficlist taglist plot.pdf

#covid data to be plotted - trimmed from histogram
caseData: setrange.py covidCases ficlist
	python3 setrange.py

#covid histogram - compiled from time series
covidCases: caseHisto.awk time-series.csv
	gawk -f caseHisto.awk

#ao3 data to be plotted - trimmed from histogram
ficData: setrange.py covidCases ficlist
	python3 setrange.py

#ao3 histogram - compiled from works that contain relevant tags
ficlist: findfics.awk taglist works-20210226.csv
	gawk -f findfics.awk

#plot and export pdf
plot.pdf: plot.py ficData caseData
	python3 plot.py

#list of relevant tags - compiled from tags containing keywords
taglist: findtags.awk keywords tags-20210226.csv
	gawk -f findtags.awk
