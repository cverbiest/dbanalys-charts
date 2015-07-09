# OpenEdge Database dbanalys graphs #
Just started, nothing much yet

## How to use
### Create dbanalys output
  proutil sports2000 -C dbanalys -csoutput -verbose > sports2000.dbana

### Invoke start procedure
  PROPATH=src _progres -p start.p -icfparam sample/sports2000 -b | tee

  or if you also want output from the advisor, download it from http://www.progresstalk.com/threads/how-much-free-information-is-too-much.140432/page-2a, put in the propath and connect the db

  PROPATH=.,src _progres -db sports2000 -p start.p -icfparam sample/sports2000 -b | tee

## db record size treemap ##
[Sports sample](https://cdn.rawgit.com/cverbiest/dbanalys-charts/master/sample/sports2000.tab.html)

## Todo's ##
* PCT build.xml
* Popup window improvement
* Colors
* Process other dbanalys files
* Alternate layout focusing on tables instead of areas

