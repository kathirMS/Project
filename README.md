# Introduction

This Shell Script code validate the all properties files and override the base properties file by include properties files.finally store in runtime properties file

## Requirements
1.vim editor

2.bash terminal

## required files
1.Base property file

2.Include files

3.Runtime property file
## Input
----
 **input format**

       application.sh 
       
## Output
----
      
**Return the Success message**

      *Example*
      
          Override
          
          File Name    : dev.properties
          
          Section Name : [section1]
          
          Property     : property5
          
          Value        : value78
  
         
**Return the Error message** 

  *Example*
  
      Error Found Duplicate Property
      
      File Name : dev.properties 
      
      Duplicate : property6
      
      Error Found duplicate value
 
      file Name : dev.properties
 
      Duplicate : value6
 
      Error Found duplicate Section
 
      file Name : dev.properties
 
      Duplicate : [section0]
      
       
##  Validation of properties files 
----

**Return the Success Message**
      
      none
**Return the Error Message** 
  
     Error Duplicate 
     
     file : File Name Of Properties 
     
     Duplicate : Property Name And Value
       
##  commands for execute code
   
        chmod +x application.sh
        
        ./application.sh 
       
