#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    echo -e "Table empty"
    source ./Connect-Menu.sh
fi    

echo -e "Delete All Record\n"


#get first line in the table (columns name) then append it to the file

echo `head -n 1 ./database/$dbname/$tablename` > ./database/$dbname/$tablename

echo -e "Record Deleted Successfully$"

source ./Connect-Menu.sh