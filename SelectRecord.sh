#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    whiptail --title "Error" --msgbox "Table Empty" 8 78
    source ./SelectIntoTable.sh
fi    



function selectrecord()
{
record=$(whiptail --title "Select Record" --inputbox "Enter PK Record" 8 40 3>&1 1>&2 2>&3)
exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
         fi
while [[ -z $record ]]
do 
    record=$(whiptail --title "Invalid Input" --inputbox "PLease Enter PK Record Again : " 8 40 3>&1 1>&2 2>&3)
    exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
         fi
done   
##check that the input pk exists       
## if input record = cut first column from the table then search for input pk record  
if [[ $record =~ [`cut -d':' -f1 ./database/$dbname/$tablename | grep -x $record`] ]]; then
    #then,(recordnumber = NR) we search in all rows using awk, if the first column field matches the record 
    #then prints number of records 
 
     recordnumber=`awk -F":" '{if ($1=="'$record'") print NR}' ./database/$dbname/$tablename `
#select the recordnumber
    #print columns name
    SELECTHEAD=$(head -n 1 ./database/$dbname/$tablename)
    #sed (print) the line of given NR
    SELECTRECORD=$(sed -n ''$recordnumber'p' ./database/$dbname/$tablename)
    whiptail --title "Selected Record" --msgbox "$SELECTHEAD\n$SELECTRECORD" 30 78
    source ./Connect-Menu.sh                  
else              
    whiptail --title "Error" --msgbox "Record Not Found" 8 78
    selectrecord               
fi
}
selectrecord