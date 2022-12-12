#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    whiptail --title "Failed" --msgbox "Table Empty" 8 78
    source ./Connect-Menu.sh
fi    
function delete()
{
    record=$(whiptail --title "Delete Record" --inputbox "Enter PK Record : " 8 40 3>&1 1>&2 2>&3)
    exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Delete_menu.sh
      fi
    while [[ -z $record ]]
    do 
    Record=$(whiptail --title "Invalid Input" --inputbox "PLease Enter PK Record Again : " 8 40 3>&1 1>&2 2>&3)
    exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Delete_menu.sh
      fi
    done   
    ##check that the input pk exists       
    ## if input record = cut first column from the table then search for input pk record  
    if [[ $record =~ [`cut -d':' -f1 ./database/$dbname/$tablename | grep -x $record`] ]] 
    then
    #then,(recordnumber = NR) we search in all rows using awk, if the first column field matches the record 
    #then prints number of records 
    #like 1- /n 2- /n 3- ......
            recordnumber=`awk -F":" '{if ($1=="'$record'") print NR}' ./database/$dbname/$tablename`
    #delete the recordnumber .. line 1 .or 2 .....
            sed -i ''$recordnumber'd' ./database/$dbname/$tablename  
            whiptail --title "Done" --msgbox "Record Deleted Successfuly" 8 78  
            source ./Connect-Menu.sh
     else
     whiptail --title "Error" --msgbox "Invalid Record" 8 78              
        #call delete function
        delete
    fi
}
delete