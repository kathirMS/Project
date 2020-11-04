#validation Process

validate(){

#get the all propeties files
ls config/include |sort -n > .sortNames
fileNameList=$(echo "base.properties" >>.sortNames | cat .sortNames) 

echo "base.properties" >>$fileNameList 

#change directory to properties files
cd config/include

#validation process
for i in $fileNameList
do
	#vaildate the base.properties file
	if [ "base.properties" = $i ]
	then
                cd ../		
	fi


       filename=$i 
       count=1;
       while read line; 
       do	    

           filename2=$i
           count1=1
           while read line1;
           do
	   	 
	       if [ $count1 == $count ] 
               then
		    
	             count1=$((count1+1))  	     
                     continue;   
	       fi
	      
 	     
	      if [ $(echo $line | cut -d '=' -f1) = $(echo $line1 | cut -d '=' -f1) ] || [ $(echo $line | cut -d '=' -f2) = $(echo $line1 | cut -d '=' -f2) ];
              then
                    echo "Error Duplicate "
                    echo "file :$i"
	            echo "Duplicate : $line"
              fi
	
           count1=$((count1+1))
       	   done < $filename2


   
      count=$((count+1))
      done < $filename
done


  
}


#sort the files
fileList=$(ls config/include | sort -n)

flage=0
#call the validate function
validate
#Find the given file is correct or Not
for i in $fileList
do
    if [ $1".properties" == $i ]
    then
           
           echo "Given Property file is ::-->  $i"

           #get the base properties data and save in runtime.properties
	   cat  base.properties > runtime/runtime.properties

           #get given file properties and save in runTimeproperties
	   cat include/$1".properties" >> runtime/runtime.properties

	    
	   flage=0

	   break

    else

	   flage=1

    fi

done

#when the given file name is Not correct  
if [ $flage == 1 ]
    then

            echo "Given File is Not Correct "
  
    fi




