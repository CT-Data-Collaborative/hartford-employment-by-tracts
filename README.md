Employment Data for Hartford, including Margins of Error
=========

Requirements
---------
get data from "Employment Status" table on
  * no. of people >= 16 y.o. in Hartford, per census tract;
  * Labor force participation rate, per census tract;
  * Unemployment rate, per census tract.

All three of these need to go with margins of errors.

Produce a CSV table with the following columns:
  * CensusTract (ID)
  * Total population over 16 years old
  * with accuracy
  * Labor Force Participation
  * Labor Force Participation Accuracy
  * Unemployment rate
  * Unemployment rate accuracy
  
Note
-----
  The census data includes the Labor Force Participation rate.\
  The data/*.csv files include this raw field, and the estimation based on multiplying the total population estimate with the rates\
  
