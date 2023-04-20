import matplotlib.pyplot as plt
from datetime import datetime as dt

#input
fics = open("ficData")
cases = open("caseData")

fmt = "%Y-%m-%d" #date format

line = fics.readline()
dates = []
numWorks = [] #x and y coords = date and number of works
#fencepost loop
while (line):
    l = line.split("|")
    dates.append(dt.strptime(l[0], fmt))
    numWorks.append(int(l[1]))
    line = fics.readline()

line = cases.readline()
dates2 = []
numCases = [] #x and y coords = date and number of cases
prev = 0
#fencepost loop
while (line):
    l = line.split("|")
    dates2.append(dt.strptime(l[0], fmt))
    numCases.append(int(l[1]) - prev) #only want increase in cases
    prev = int(l[1])
    line = cases.readline()

fig, ax1 = plt.subplots()

#plot works
ax1.set_xlabel('Date')
ax1.set_ylabel('Works Created', color='red')
ax1.plot(dates, numWorks, 'r', label='Works')
ax1.tick_params(axis='y', labelcolor='red')

#plot cases
ax2 = ax1.twinx()
ax2.set_ylabel('Increase in Cases', color='blue')
ax2.plot(dates2, numCases, 'b', label='COVID cases')
ax2.tick_params(axis='y', labelcolor='blue')

#formatting stuff
ax1.tick_params(axis='x', rotation=45)
ax1.minorticks_on()
ax1.grid(which='both', axis='x')
ax1.set_title("Global COVID cases and pandemic-themed works on AO3 by day")

#fig.legend()
fig.savefig("plot.pdf", bbox_inches="tight")
#plt.show()

