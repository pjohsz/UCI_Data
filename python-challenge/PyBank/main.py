# This program is a Python script for analyzing the financial records.
# Calculations include the following: 
# The total number of months included in the dataset
# The total net amount of "Profit/Losses" over the entire period
# The average change in "Profit/Losses" between months over the entire period
# The greatest increase in profits (date and amount) over the entire period
# The greatest decrease in losses (date and amount) over the entire period

# Modules
import os
import csv

# Set path for file
csvpath = os.path.join("..", "Resources", "budget_data.csv")

# Declare Variables
greatest_increase_month = " " 
greatest_increase = 0.0
greatest_decrease_month = " " 
greatest_decrease = 0.0

#Read File   
with open(csvpath) as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    totalRevenue  = 0.0
    counter = 0
    twoFieldsAverage = 0.0
    currentField = 0.0
    twoFieldsAverageList = []
    
    for row in readCSV:
        if (row[1]).lstrip('-').isdigit():
            totalRevenue += float(row[1])
            currentField = float(row[1])
            counter += 1
            if (counter == 1):
                twoFieldsAverage = (twoFieldsAverage + currentField)
            else:    
                twoFieldsAverage = (twoFieldsAverage + currentField)/2
                twoFieldsAverageList.insert(counter, twoFieldsAverage)
                if twoFieldsAverage > greatest_increase:
                    greatest_increase = twoFieldsAverage
                    greatest_increase_month = row[0]
                if twoFieldsAverage < greatest_decrease:
                    greatest_decrease = twoFieldsAverage
                    greatest_decrease_month = row[0]    
    revenueAverage = totalRevenue/counter        

# Print Summary Totals
# Format all of the dollar values to include dollar sign, commas and two decimal places. 

print ("Total Months: ", counter)
print ("Total: " , '${:,.2f}'.format(totalRevenue))
print ("Average Change: " , '${:,.2f}'.format(revenueAverage))
print ("Greatest Increase in profits: ", greatest_increase_month, " ", '${:,.2f}'.format(greatest_increase))
print ("Greatest Decrease in profits: ", greatest_decrease_month, " ", '${:,.2f}'.format(greatest_decrease))
csvfile.close()    
#End logic   