#validation Process

validate(){

#get the all propeties files
ls config/include |sort -n > .sortNames
fileNameList=$(echo "base.properties" >>.sortNames | cat .sortNames) 

#echo "$fileNameList" 

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

       #stor the file content
        arr=()
                while IFS= read -r line; 
                do
                  arr+=("$line")
                done <$i

            N=$(cat $i | wc -l)

       count=1;
       
       while read line; 
       do 
             
               flag=0
	       flag1=0
	       for ((j=$count;j<N;j++));
               do
			 
			
			 if [  $(echo $line | cut -b 2-8) == "section" ] 
			 then
                                 flag=1
			 else
				 flag=0
			 fi
		
			 if [ $(echo ${arr[j]} | cut -b 2-8) == "section" ]
                         then
                              flag1=1
                         else
		              flag1=0
			 fi

                    
			 
                         if [ $flag == 1 ]
			 then
				  if [ $line == ${arr[j]} ]
                                     then
                                         echo "Error Found Duplicate Section"
                                         echo "File Name : $i"
					 echo "Duplicate : $line"
                                  fi

			  else
				  if [ $flag1 == 0 ]
				  then   
					   if [ $(echo $line | cut -d '=' -f1) = $(echo ${arr[j]} | cut -d '=' -f1) ]
					   then
						  echo "Error Found Duplicate Property"
						  echo "File Name : $i"
						  echo "Duplicate : $( echo $line |cut -d '=' -f1 )"
					   fi
					   if [ $(echo $line | cut -d '=' -f2) = $(echo ${arr[j]} | cut -d '=' -f2) ]
                                           then   
						  echo "Error Found duplicate value"
						  echo "file Name : $i"
						  echo "Duplicate : $( echo $line | cut -d '=' -f2 )"
                                           fi

				  else
					 break
				  fi 

			 fi
               done 
	   count=$((count+1))    
     done < $i
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




