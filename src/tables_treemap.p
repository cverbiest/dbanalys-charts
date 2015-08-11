/*
The MIT License (MIT)

Copyright (c) 2015 Carl Verbiest

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
/*

          ['Location', 'Parent', 'Market trade volume (size)', 'Market increase/decrease (color)'],
          ['Global',    null,                 0,                               0],

"Time Stamp" "DBUID" "DB name" "Area" "Area #" "Partition Type" "Tenancy" "Tenancy #" "Partition Policy" "Partition" "Partition #" "Owner" "Table" "Table #" "Records" "Size" "Min" "Max" "Mean" "Frag Count" "Frag Factor" "Scatter Factor"
2015-07-02T09:10:58.000+2:00 "oVMach4VG4TSE/RpuADR3A" "LISA" "Control Area" 1 "-" "-" 0 "-" "-" 0 "PUB" "_Area" -71 12 547 42 54 45 12 1.0 1.0

*/
block-level on error undo, throw.

def input param FileBase as character no-undo.
def var InputFileName as character no-undo.
def var OutputFileName as character no-undo.
def var AreaList as char no-undo.
def var Area as char.
def var Partition as char.
def var TableName as char.

def stream sOut.
def var reader as TextFileReader no-undo.

InputFileName = subst("&1.tab.txt", FileBase).
OutputFileName = subst("&1.tab.html", FileBase).

reader = new TextFileReader(InputFileName).
reader:ReadHeader().
if reader:HeaderRow[1] ne "Time Stamp"
then undo, throw new progress.lang.apperror(substitute("Header row now found in &1, expected &2 but found &3", InputFileName, "Time Stamp",  reader:HeaderRow[1], 0)).
copy-lob from file "templates/treemap_head.html" to file OutputFileName.
output stream sOut to value(OutputFileName) append.
put stream sOut unformatted "          ['Global', null, 0, 0, 0]," skip.

repeat while reader:ReadRow():
/*    disp reader:CurrentRow[13] reader:GetValue(13) reader:GetValue("Table").*/
    Area = subst("&1 area", reader:GetValue("Area")).
    if int64(reader:GetValue("Size")) > 0
    then do:
        if lookup(Area, AreaList) = 0
        then do:
            put stream sOut unformatted subst("          ['&1', 'Global', 0, 0, 0],", Area) skip.
            AreaList = subst("&1,&2", AreaList, Area).
        end.    
        Partition = reader:GetValue("Partition").
        TableName = reader:GetValue("Table").
        if Partition = "-" then Partition = TableName.
        put stream sOut unformatted subst("          ['&1', '&2', &3, 0, &4],",  Partition, Area, reader:GetValue("Size"), reader:GetValue("Records"), reader:GetValue("Mean")) skip.
    end.
end.
output stream sOut close.
copy-lob from file "templates/treemap_tail.html" to file OutputFileName append.
message substitute("Created &1", OutputFileName).
