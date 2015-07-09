def var FileBase as character form "x(65)" initial "sample/sports2000".
if session:icfparam > ""
then FileBase = session:icfparam.

if not session:batch-mode then update FileBase.
run tables_treemap.p(FileBase).
if session:batch-mode then quit.
