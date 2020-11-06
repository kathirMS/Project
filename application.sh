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

            length=$(cat $i | wc -l)

       count=1;
       
       while read line; 
       do 
             
               flag=0
	       flag1=0
	       for ((j=$count;j<length;j++));
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

#call the validate function
validate

#store the base.properties value in array
 arr=()
         while IFS= read -r line;
         do
            arr+=("$line")
         done <base.properties

            length=$(cat $i | wc -l)

#override process
cd include	    
for i in $fileList
do
   sectionName="no"
   sectionName1="no"
   for ((j=0;j<length;j++))
   do   
	   if [ $(echo ${arr[j]} | cut -b 2-8) == "section" ]
	   then
                  sectionName=${arr[j]}
		  continue;
	   fi
	   while read line;
           do
		if [ $(echo $line | cut -b 2-8) == "section"  ]
		then
                    sectionName1=$line 
		fi	
                if [ $(echo $line | cut -d '=' -f1) = $(echo ${arr[j]} | cut -d '=' -f1)  ]
		then
			if [ $sectionName = $sectionName1 ]
			then
				echo "Override"
				echo "File Name    : $i" 
				echo "Section Name : $sectionName"
				echo "Property     : $(echo $line | cut -d '=' -f1)"
				echo "Value        : $(echo $line | cut -d '=' -f2)"
				arr[j]=$line
                               
			fi
		fi

           done<$i	     
   done    

done
#finally store in runtime.properties file
cd ../
cat /dev/null > runtime/runtime.properties  
for i in ${arr[@]}
do
	echo "$i" >>runtime/runtime.properties
done


