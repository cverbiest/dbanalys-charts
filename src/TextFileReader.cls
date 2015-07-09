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
class TextFileReader:

    define private stream Sin.
    define public variable HeaderRow as character no-undo extent 50.
    define public variable CurrentRow as character no-undo extent 50.
    define private variable HeaderList as character no-undo.

    define public property Delimiter as character initial " "
        get.
        set.

    define public property CurrentLine as integer initial 0
        get.
        private set.
        
    define public property LastError as progress.lang.error no-undo
        get.
        private set.

    constructor public TextFileReader(input iFileName as character):
        input stream Sin from value(iFileName).
    end constructor.
 
    method public logical ReadHeader():
        def var i as int no-undo.
        import stream sIn delimiter " " HeaderRow.
        do i = 1 to extent(HeaderRow):
            HeaderList = substitute("&1&2&3", HeaderList, chr(2), HeaderRow[i]).
        end.
        HeaderList = trim(HeaderList, chr(2)).
        return true.
    end method.
 
    method public logical ReadRow():
        import stream sIn delimiter " " CurrentRow.
        return true.
        catch e as progress.lang.error:
            LastError = e.
            return false.
        end catch.
    end method.
 
    method public character GetValue(input iKey as character):

        return GetValue(lookup(iKey, HeaderList, chr(2))).

    end method.
 
    method public character GetValue(input iCount as integer):
        return CurrentRow[iCount].

    end method.

    destructor public TextFileReader():
        input stream Sin close.
    end destructor.

   
end class.
