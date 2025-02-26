
/** shorten on March 7 by Ruifeng Li**/ 
%macro meta_subtype_trend (     
             data   =     ,       /* Input data set with the following variables */                   
             logRR   = logRR,      /* the estimated log relative risk for each cancer subtype in relation to the exposure */ 
             var    = var,      /* estimated variances of the estimated log relative risk */ 
             subtype = ,       /* the cancer subtype */ 
             score = ,         /* the ordinal score assigned to each cancer/disease subtype */
             notes=nonotes
           ); 
    
%let notes=%upcase(&notes);
options center &notes; 
 
title "The input data is:";
proc print data=&data;
run;
title;

data new; 
set &data; 
w=1/&var; 
run; 


/** random **/
  proc mixed data=new  asycov method=ml;
  make 'solutionf' out=fixest ;
  class &subtype;
  model &logRR = &score / s covb ;
  random &subtype;
  repeated ;
  weight w ;
  parms (0) ( 1) / eqcons=2 ;
run;


title "Fix effect results";
proc print data=fixest;
run;


proc iml;     
   use fixest; 
   read all var{estimate} into estr ; 
   read all var{stderr}   into semr ;    
      
  if (semr[2]=0) then do ; 
      pchr = . ; 
   end ; 
   else do ;  
      zscr = estr[2]/semr[2] ; 
      chir = zscr*zscr ; 
      point=estr[2];
      rr=estr[2]*estr[2];
    
      pchr = round((1 - probchi(chir,1)), .0001); 
   end ; 
   close fixest  ; 
   file print;
   put @5 "------------------------------------------------------------------------------------------------------";
   put @5 "The regression coefficient of score is:" point; 
   put @5 "P-value for testing the exposure of interest has an increasing or decreasing ordinal effect on subtypes is:" pchr;
   put @5 "------------------------------------------------------------------------------------------------------";


%if &notes eq NOTES %then %do;
  proc contents data=fixest;  run;
  proc print data=fixest;  run;
%end;
options notes; 
 
%mend; 
   

