Fix error: cannot open table because in use by you in resource environment

Sometimes I get one of these error.

ERROR: You cannot open WORK.NORMAL.DATA for output access with member-level control
because WORK.NORMAL.DATA is in use by you in resource environment DMS Process.

OR

ERROR: The data set WORK.NORMAL is in use, cannot be created.

GiyHub
https://tinyurl.com/33p235nm
https://github.com/rogerjdeangelis/utl-fix-error-cannot-open-table-because-in-use-by-you-in-resource-environment-

Related to
https://tinyurl.com/ybb6s85f
https://communities.sas.com/t5/New-SAS-User/Error-SAS-ERROR-You-cannot-open-WORK-T-DATA-for-input-access/td-p/507964

Jagadishkatam
https://communities.sas.com/t5/user/viewprofilepage/user-id/12151


*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

There are many ways this can happen.

proc datasets lib=work;
  delete normal;
run;quit;

proc iml;
X={5 3 1  0.2,
3.9 3 1.4 5.2,
9.9 3.2 1.3 0.2};

varNames = "x1":"x4";
create Normal from X[c=varNames]; append from X;
create Normal from X[c=varNames]; append from X;

%let rc=%sysfunc(open(work.normal));

data normal;
 set sashelp.class;
run;

ERROR: You cannot open WORK.NORMAL.DATA for output access with member-level control
because WORK.NORMAL.DATA is in use by you in resource environment DMS Process.

or

ERROR: The data set WORK.NORMAL is in use, cannot be created.

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%macro close_all_dsid;
  %local i rc;
  %do i=1 %to 1000;
    %let rc=%sysfunc(close(&i));
  %end;
%mend;

%close_all_dsid;

data normal;
 set sashelp.class;
run;

NOTE: There were 19 observations read from the data set SASHELP.CLASS.
NOTE: The data set WORK.NORMAL has 19 observations and 5 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds


*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

Up to 40 obs from NORMAL total obs=19

Obs    NAME       SEX    AGE    HEIGHT    WEIGHT

  1    Joyce       F      11     51.3       50.5
  2    Louise      F      12     56.3       77.0
  3    Alice       F      13     56.5       84.0
...

