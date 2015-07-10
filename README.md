# OpenEdge Database dbanalys graphs #
Just started, nothing much yet

## How to use
### Create dbanalys output
  proutil sports2000 -C dbanalys -csoutput -verbose > sports2000.dbana

### Invoke start procedure
  PROPATH=src _progres -p start.p -icfparam sample/sports2000 -b | tee

  or if you also want output from the advisor (see Dependencies) connect the db

  PROPATH=.,src _progres -db sports2000 -p start.p -icfparam sample/sports2000 -b | tee

## db record size treemap ##
[Sports sample](https://cdn.rawgit.com/cverbiest/dbanalys-charts/master/sample/sports2000.tab.html)

## Dependencies ##
### Required ###
### Optional ###
* PCT : download jar and put in $ANT_HOMEZ/lib [https://github.com/jakejustus/pct/releases](https://github.com/jakejustus/pct/releases)
* advisor : download advisor.p and put in src or other directory in PROPATH [progresstalk.com thread](http://www.progresstalk.com/threads/how-much-free-information-is-too-much.140432/page-2a)

## Todo's ##
* PCT build.xml
* Popup window improvement
* Colors
* Process other dbanalys files
* Alternate layout focusing on tables instead of areas

