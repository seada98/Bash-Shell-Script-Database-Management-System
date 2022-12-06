#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    echo -e "Table Empty"
    source ./Connect-Menu.sh
fi    
echo -e "Select Record\n"

function selectrecord()
{
read -p "Enter PK Record " record
while [[ -z $record ]]
do 
    echo -e "Invalid Input"
    read -p "PLease Enter PK Record Again : " record
done   
##check that the input pk exists       
## if input record = cut first column from the table then search for input pk record  
if [[ $record =~ [`cut -d':' -f1 ./database/$dbname/$tablename | grep -x $record`] ]]; then
    #then,(recordnumber = NR) we search in all rows using awk, if the first column field matches the record 
    #then prints number of records 
     recordnumber=`awk -F":" '{if ($1=="'$record'") print NR}' ./database/$dbname/$tablename `
#select the recordnumber
    #print columns name
    head -n 1 ./database/$dbname/$tablename
    #sed (print) the line of given NR
    sed -n ''$recordnumber'p' ./database/$dbname/$tablename  
    source ./Connect-Menu.sh                  
else              
    echo -e "Record Not Found"
    selectrecord               
fi
}
selectrecord