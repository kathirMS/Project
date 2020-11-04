#validation Process

validate(){
 
fileNameList=$(ls config/include | sort -n)
cd config/include
for i in $fileNameList
do

        cat $i |  unique out
        cat out > $i
        rm out
done

cd ../

 cat base.properties | unique out
 cat out > base.properties
 rm out
  
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




