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
def var FileBase as character form "x(65)" initial "sample/sports2000".
if session:icfparam > ""
then FileBase = session:icfparam.

if not session:batch-mode then update FileBase.
run tables_treemap.p(FileBase).
 
if num-dbs = 1 and search("advisor.p") > ""
then do:
    /*
    run the advisor if it is available and there is a db connected 
    the advisor.p can be found on http://www.progresstalk.com/threads/how-much-free-information-is-too-much.140432/page-2
    */
    run advisor.p (subst("&1.dbana", FileBase), subst("&1.advisor.html", FileBase), "", 0).
end.

if session:batch-mode then quit.
