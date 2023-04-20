# This program trims the two histograms to be within the relevant date range.

from datetime import datetime as dt

start = dt(2019, 3, 11) #Mar 11 2019, a year before the first spike
end = dt(2021, 2, 26) #Feb 26 2021, end of AO3 data

#input
fics = open("ficlist")
cases = open("covidCases")
#output
ficData = open("ficData", 'w')
caseData = open("caseData", 'w')

fmt = "%Y-%m-%d" #date format

#loop through ficlist
line = fics.readline()
while line:
    l = line.split("|")
    d = dt.strptime(l[0], fmt)
    if d >= start and d <= end: ficData.write(line)
    if d >= end: break
    line = fics.readline()
ficData.close()

#loop through covid cases
line = cases.readline()
while line:
    l = line.split("|")
    d = dt.strptime(l[0], fmt)
    if d >= start and d <= end: caseData.write(line)
    if d >= end: break
    line = cases.readline()
caseData.close()
