' Steps:
' ----------------------------------------------------------------------------

' Easy Section:
' ----------------------------------------------------------------------------
' 1. Loop through each of the sheets.
' 2. Create a summary section for the ticker symbol / ticker symbol stock volume in columns I and J of each sheet
' 3. Within the sheet loop create a row loop to read each of the rows
' 4. Total the stock volume by ticker symbol
' 5. When there is a break on the ticker symbol write the ticker symbol / total stock volume to columns I and J of the sheet


' Moderate Section
' ----------------------------------------------------------------------------
' Create a script that will loop through all the stocks and take the following info.
' 1. Yearly change from what the stock opened the year at to what the closing price was.
' 2. The percent change from the what it opened the year at to what it closed.
' 3. The total Volume of the stock
' 4. Ticker symbol
' 5. You should also have conditional formatting that will highlight positive change in green and negative change in red.

' Hard Section
' ----------------------------------------------------------------------------
' 1. Your solution will include everything from the moderate challenge.
' 2. Your solution will also be able to locate the stock with the "Greatest % increase", "Greatest % Decrease" and "Greatest total volume".

' Make the appropriate adjustments to your script that will allow it to run on every worksheet just by running it once.
' This can be applied to any of the difficulties.'

Sub Stock_Market_HW()
    ' Set up Variables
      Dim Save_Ticker_Symbol As String
      Dim Save_Ticker_Total As Double
      Dim Ticker_Pct_Change As Double
      Dim Ticker_Vol_Change As Double
      Dim Summary_Row_Cnt As Integer
      Dim Save_Start_Amt As Double
      Dim Save_End_Amt As Double
      Dim Greatest_increase_Amt As Double
      Dim Greatest_increase_Ticker As String
      Dim Greatest_decrease_Amt As Double
      Dim Greatest_decrease_Ticker As String
      Dim Greatest_Tot_Vol As Double
      Dim Greatest_Tot_Ticker As String
 
 ' Loop through each worksheet

   For Each ws In Worksheets

    ' Initalize Summary Table

      Summary_Row_Cnt = 2
      Save_Ticker_Symbol = ws.Cells(2, 1).Value
      Save_Start_Amt = ws.Cells(2, 3).Value
      Greatest_increase_Amt = ws.Cells(2, 3).Value
      Greatest_increase_Ticker = ws.Cells(2, 1).Value
      Greatest_decrease_Amt = ws.Cells(2, 3).Value
      Greatest_decrease_Ticker = ws.Cells(2, 1).Value
      Greatest_Tot_Vol = ws.Cells(2, 3).Value
      Greatest_Tot_Ticker = ws.Cells(2, 1).Value

    ' Determine the Last Row for the active sheet
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row

    ' Add the Summary Section Column Headers
       
        ws.Range("I1") = "Ticker"
        ws.Range("J1") = "Yearly Change"
        ws.Range("K1") = "Percent Change"
        ws.Range("L1") = "Total Stock Volume"

    ' Add the Greatest Change Column Headers

        ws.Range("P1") = "Ticker"
        ws.Range("Q1") = "Value"

     ' Add the Greatest Change Row Labels
    
        ws.Range("O2") = "Greatest % Increase"
        ws.Range("O3") = "Greatest % Decrease"
        ws.Range("O4") = "Greatest Total Volume"

   ' Loop through every row on the page to total the volume by ticker symbol
        For i = 2 To LastRow

         'Check to see if there is a change in the ticker symbol. If the ticker symbol changes then print the ticker symbol and ticker sub total.
         'Reset the saved ticker symbol total, update the save ticker symbol and update the summary row count to the next value.

          If Save_Ticker_Symbol <> ws.Cells(i, 1).Value Then
            Ticker_Vol_Change = (Save_End_Amt - Save_Start_Amt)
            
            If Save_Start_Amt = 0 Then
              Ticker_Pct_Change = 100
            Else
              Ticker_Pct_Change = (Save_End_Amt / Save_Start_Amt) - 1
            End If

            ws.Range("I" & Summary_Row_Cnt).Value = Save_Ticker_Symbol
            ws.Range("J" & Summary_Row_Cnt).Value = Ticker_Vol_Change
            ws.Range("K" & Summary_Row_Cnt).Value = Ticker_Pct_Change
            ws.Range("L" & Summary_Row_Cnt).Value = Save_Ticker_Total
            If (Save_End_Amt - Save_Start_Amt) >= 0 Then
              ws.Range("K" & Summary_Row_Cnt).Interior.ColorIndex = 4
            Else
              ws.Range("K" & Summary_Row_Cnt).Interior.ColorIndex = 3
            End If

            If Ticker_Vol_Change < Greatest_decrease_Amt Then
              Greatest_decrease_Amt = Ticker_Vol_Change
              Greatest_decrease_Ticker = Save_Ticker_Symbol
            End If

            If Ticker_Vol_Change > Greatest_increase_Amt Then
              Greatest_increase_Amt = Ticker_Vol_Change
              Greatest_increase_Ticker = Save_Ticker_Symbol
            End If

            If Save_Ticker_Total > Greatest_Tot_Vol Then
              Greatest_Tot_Vol = Save_Ticker_Total
              Greatest_Tot_Ticker = Save_Ticker_Symbol
            End If

            Save_Ticker_Total = 0
            Save_Ticker_Symbol = ws.Cells(i, 1).Value
            Summary_Row_Cnt = Summary_Row_Cnt + 1
            Save_Start_Amt = ws.Cells(i, 3).Value

          End If
         
         'Add the current ticker total to the save ticker total for use in the summary table.

          Save_Ticker_Total = Save_Ticker_Total + ws.Cells(i, 7).Value
          Save_End_Amt = ws.Cells(i, 6).Value

        Next i

       ' Print the last ticker symbol to the summary table.

         Ticker_Vol_Change = (Save_End_Amt - Save_Start_Amt)
         
         If Save_Start_Amt = 0 Then
              Ticker_Pct_Change = 100
            Else
              Ticker_Pct_Change = (Save_End_Amt / Save_Start_Amt) - 1
         End If
         
         ws.Range("I" & Summary_Row_Cnt).Value = Save_Ticker_Symbol
         ws.Range("J" & Summary_Row_Cnt).Value = Ticker_Vol_Change
         ws.Range("K" & Summary_Row_Cnt).Value = Ticker_Pct_Change
         ws.Range("L" & Summary_Row_Cnt).Value = Save_Ticker_Total
        
        If (Save_End_Amt - Save_Start_Amt) >= 0 Then
          ws.Range("K" & Summary_Row_Cnt).Interior.ColorIndex = 4
        Else
          ws.Range("K" & Summary_Row_Cnt).Interior.ColorIndex = 3
        End If

        If Ticker_Vol_Change < Greatest_decrease_Amt Then
           Greatest_decrease_Amt = Ticker_Vol_Change
           Greatest_decrease_Ticker = Save_Ticker_Symbol
        End If

        If Ticker_Vol_Change > Greatest_increase_Amt Then
          Greatest_increase_Amt = Ticker_Vol_Change
          Greatest_increase_Ticker = Save_Ticker_Symbol
        End If

        If Save_Ticker_Total > Greatest_Tot_Vol Then
          Greatest_Tot_Vol = Save_Ticker_Total
          Greatest_Tot_Ticker = Save_Ticker_Symbol
        End If

     ' Print Greatest Increase / Decrease and Volume Section.

        ws.Range("P2") = Greatest_increase_Ticker
        ws.Range("Q2") = Greatest_increase_Amt
        ws.Range("P3") = Greatest_decrease_Ticker
        ws.Range("Q3") = Greatest_decrease_Amt
        ws.Range("P4") = Greatest_Tot_Ticker
        ws.Range("Q4") = Greatest_Tot_Vol
        
        Sheets(1).Select
        Selection.EntireColumn.AutoFit
        
        Sheets(2).Select
        Selection.EntireColumn.AutoFit
        
        Sheets(3).Select
        Selection.EntireColumn.AutoFit
        
        MsgBox ("Worksheet Finished")
        
     ' Get next worksheet

    Next ws

     'Print a message box to show that the process has ended.

      MsgBox ("Update Complete")

End Sub
