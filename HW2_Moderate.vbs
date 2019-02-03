sub StockData():

'Define variables for tickers, open value, close value, and volume
dim Ticker as string
dim TotalVolume as double
dim Open_Price as double
dim Close_Price as double
dim Yearly_Change as double
Dim Percent_Change as double
dim i as long

'create summary table by determining where it is going to start in the sheet as an integer
dim Summary_Table_Row as integer
Summary_Table_Row = 2

' loop through all the worksheets
dim ws as Worksheet
For Each ws in Worksheets

'create summary table titles
ws.cells(1,10).Value = "Ticker"
ws.cells(1,11).Value = "Yearly Change"
ws.cells(1,12).Value = "Percent Change"
ws.cells(1,13).Value = "Total Volume"

    'determine last row
    LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row

    ' set the open value
    Open_Price = ws.Cells(2,3).Value

    'loop through stocks
    For i = 2 to LastRow

        'check if next ticker is equal to previous ticker , if not start summing total volume
        If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then

            ' set ticker name in summary table 
            Ticker = ws.Cells(i, 1).Value

            'set close value
            Close_Price = ws.Cells(i,6).Value

            'print ticker in summary table
            ws.range("J" & Summary_Table_Row).Value = Ticker 

            'set and print yearly change in summary table
            Yearly_Change = Close_Price - Open_Price
            ws.range("K" & Summary_Table_Row).Value = Yearly_Change

            'set and print Percent change in summary table using logic if denominator (open price) is 0
            if (Open_Price = 0)  Then
                Percent_Change = 0
            Else    
                Percent_Change = Yearly_Change/Open_Price
                 ws.Range("L" & Summary_Table_Row).Value = Percent_Change
                 ws.Range("L" & Summary_Table_Row).NumberFormat = "0.00%"
            End if

            ' Add to the Total Volume
            TotalVolume = TotalVolume + ws.Cells(i, 7).Value

            'print total volume in summary table
            ws.range("M" & Summary_Table_Row).Value = TotalVolume

            'add one to summary table row
            Summary_Table_Row = Summary_Table_Row + 1

            'reset open value
            Open_Price = ws.Cells(i + 1,3).Value

            'reset Total Volume
            TotalVolume = 0

        ' If the cell right after the row is the same ticker then add to total volume
        Else

            'add to total volume
            TotalVolume = TotalVolume + ws.Cells(i, 7).Value

        End If

    Next i

Summary_Table_Row = 2

    'Determine last row of yearly change
    LastRowYC = ws.Cells(Rows.Count, 11).End(xlUp).Row

    'change cell colors
    For j = 2 to LastRowYC
        If (ws.cells(j,11).Value > 0 or ws.cells(j,11).Value = 0 ) Then
            ws.Cells(j,11).interior.ColorIndex = 10
        ElseIf Cells(j,11).Value < 0 Then
            ws.Cells(j,11).Interior.ColorIndex = 3
        End If
    Next j 




Next ws    

End sub