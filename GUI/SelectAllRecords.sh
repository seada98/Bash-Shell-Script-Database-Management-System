#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    whiptail --title "Error" --msgbox "Table Empty" 8 78
    source ./SelectIntoTable.sh
fi    


 
##echo -e "All Records\n"

#value of $1 is assigned to field $1, 
#awk actually rebuilds its $0 by concatenating them with default field delimiter(or OFS) space.

#awk '$1=$1' FS=" " OFS="    " ./database/$dbname/$tablename.Type
#cat ./database/$dbname/$tablename.Type
#New Delimeter
ALLRECORD=$(awk '$1=$1' FS=":" OFS="    " ./database/$dbname/$tablename)
whiptail --title "All Records" --msgbox "$ALLRECORD" 30 78
#cat ./database/$dbname/$tablename
source ./Connect-Menu.sh


