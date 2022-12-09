#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    whiptail --title "Error" --msgbox "Table empty" 8 78
    source ./Connect-Menu.sh
fi    

#get first line in the table (columns name) then append it to the file

echo `head -n 1 ./database/$dbname/$tablename` > ./database/$dbname/$tablename
whiptail --title "Done" --msgbox "Table Record Deleted Successfully" 8 78
source ./Connect-Menu.sh