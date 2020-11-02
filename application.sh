#goto the include file
#cd include

#sort the files
fileList=$(ls include| sort -n)

flage=0

#Find the given file is correct or Not
for i in $fileList
do
    if [ $1 == $i ];
    then
           
           echo "Given Proparty file is ::-->  $i"

           #get the base proparties data and save in runTime.proparties
	   cat config/base.proparties > runtime/runtime.proparties

           #get given file proparties and save in runTimeproparties
	   cat include/$1 >> runtime/runtime.proparties

	   flage=0

	   break

    else

	   flage=1

    fi

done

#when the given file name is Not correct  
if [ $flage == 1 ];
    then

            echo "Given File is Not Correct "
  
    fi





