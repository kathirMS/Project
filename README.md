# Introduction

This Shell Script code Merge the BaseProparties file  and Given child  Proparties  file Then Save in runtime.proparties file.

## Requirements
1.vim editor

2.bash terminal

## required files
1.Base proparty file

2.Include files

3.Runtime proparty file
## Input
----
 **input format**

       application.sh  `include proparties file name`
       
## Output
----
      
**Return the Success message**

         Given Proparty file is ::--> given proparties file name  
         
**Return the Error message** 
  
       Given File Not Correct
       
##  commands for execute code
   
        chmod +x application.sh
        
        ./application.include proparties file name
       
## commands 

        ./application.sh dev.proparties 
        
        ./application.sh test.proparties
        
        ./application.sh stage.proparties
        
        ./application.sh final.proparties 
       

