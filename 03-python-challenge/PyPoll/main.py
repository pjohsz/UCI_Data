# This program is a Python script that will analyze votes. 
# Calculations include the following: 
#  1. Total number of votes cast.
#  2. Complete list of candidates who received votes. 
#  3. Percentage of votes each candidate won. 
#  4. Total number of votes each candidate won. 
#  5. The winner of the election based on popular vote. 

# Modules
import os
import csv

# Set path for file
csvpath = os.path.join("..", "Resources", "election_data.csv")

#Read File   
with open(csvpath) as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    total_counter = 0
    found_counter = 0
    item_fnd_cnt = 0
    kahn_cnt = 0
    correy_cnt = 0
    li_cnt = 0
    otooley_cnt = 0 

# Read each row in the file
    for row in readCSV:
        if (row[0]).lstrip('-').isdigit():
            total_counter += 1 
            if row[2] == 'Khan':
                kahn_cnt += 1 
            elif row[2] == 'Correy':
                correy_cnt += 1 
            elif row[2] == 'Li':
                li_cnt += 1
            else:
                otooley_cnt += 1   
winner = " "
tot_win = 0

if correy_cnt > tot_win:
    tot_win = correy_cnt
    winner = "Correy"

if li_cnt > tot_win:
    tot_win = li_cnt
    winner = "Li"

if kahn_cnt > tot_win:
    tot_win = kahn_cnt
    winner = "Kahn"   

if otooley_cnt > tot_win:
    tot_win = otooley_cnt
    winner = "Otooley"
            
kahn_pct = (float(kahn_cnt)/float(total_counter))
correy_pct = (float(correy_cnt)/float(total_counter))
li_pct = (float(li_cnt)/float(total_counter))
otooley_pct = (float(otooley_cnt)/float(total_counter))

# Print Summary Totals
# Format all of the dollar values to include dollar sign, commas and two decimal places. 
print ("Election Results")
print ("----------------------------------------------------------------------")
print ("Total Votes:    ", '{:,}'.format(total_counter))
print ("----------------------------------------------------------------------")
print ("Candidate Name  " + " Total Votes              " + " Pecentage of Vote")
print ("Kahn            ", '{:,}'.format(kahn_cnt) + "                 " + '{:%}'.format(kahn_pct))
print ("Correy          ", '{:,}'.format(correy_cnt) + "                   " + '{:%}'.format(correy_pct))
print ("Li              ", '{:,}'.format(li_cnt) + "                   " + '{:%}'.format(li_pct))
print ("OTooley         ", '{:,}'.format(otooley_cnt) + "                   " + '{:%}'.format(otooley_pct))
print ("----------------------------------------------------------------------")
print (" ")
print ("Election Winner is ", winner)
csvfile.close()    

#End logic   