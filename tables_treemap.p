/*

          ['Location', 'Parent', 'Market trade volume (size)', 'Market increase/decrease (color)'],
          ['Global',    null,                 0,                               0],

"Time Stamp" "DBUID" "DB name" "Area" "Area #" "Partition Type" "Tenancy" "Tenancy #" "Partition Policy" "Partition" "Partition #" "Owner" "Table" "Table #" "Records" "Size" "Min" "Max" "Mean" "Frag Count" "Frag Factor" "Scatter Factor"
2015-07-02T09:10:58.000+2:00 "oVMach4VG4TSE/RpuADR3A" "LISA" "Control Area" 1 "-" "-" 0 "-" "-" 0 "PUB" "_Area" -71 12 547 42 54 45 12 1.0 1.0

*/

def var FileBase as character initial "LISA". /* sample/sports2000 */
def var InputFileName as character initial "sample/sports2000.tab.txt".
def var OutputFileName as character initial "sample/sports2000.tab.html".

InputFileName = subst("&1.tab.txt", FileBase).
OutputFileName = subst("&1.tab.html", FileBase).

def var AreaList as char no-undo.
def var Area as char.

def stream sOut.
def var reader as TextFileReader no-undo.

reader = new TextFileReader(InputFileName).
reader:ReadHeader().
message reader:HeaderRow[1] .
copy-lob from file "treemap_head.html" to file OutputFileName.
output stream sOut to value(OutputFileName) append.
put stream sOut unformatted "          ['Global', null, 0, 0, 0]," skip.

repeat while reader:ReadRow():
/*    disp reader:CurrentRow[13] reader:GetValue(13) reader:GetValue("Table").*/
    Area = subst("&1 area", reader:GetValue("Area")).
    if integer(reader:GetValue("Size")) > 0
    then do:
        if lookup(Area, AreaList) = 0
        then do:
            put stream sOut unformatted subst("          ['&1', 'Global', 0, 0, 0],", Area) skip.
            AreaList = subst("&1,&2", AreaList, Area).
        end.    
        put stream sOut unformatted subst("          ['&1', '&2', &3, 0, &4],",  reader:GetValue("Table"), Area, reader:GetValue("Size"), reader:GetValue("Records"), reader:GetValue("Mean")) skip.
    end.
end.
output stream sOut close.
copy-lob from file "treemap_tail.html" to file OutputFileName append.

