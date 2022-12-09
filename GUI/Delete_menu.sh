#! /bin/bash

if [ `ls ./database/$dbname | wc -l` == 0 ]
then
    whiptail --title "Error" --msgbox "No Table Found" 8 78
      source ./Connect-Menu.sh
fi      
tablename=$(whiptail --title "Delete From Table" --inputbox "Enter Table You Want To Delete from : " 8 40 3>&1 1>&2 2>&3)
exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi
export tablename
while [[ -z $tablename ]] || [[ $tablebname == *['!''*\ *@#/$\"*{^})(+_/=-]>[<?']* ]] || [[ $tablename == " " ]]
do 
tablename=$(whiptail --title "Invalid Input" --inputbox "PLease Enter Table Name Again : " 8 40 3>&1 1>&2 2>&3)
exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi
done

if [ -f ./database/$dbname/$tablename ]
then
    DELETE=$(whiptail --title "Delete Options" --menu "Choose an option" 15 60 5 \
    "1" "Delete All Records" \
    "2" "Delete Record" \
    "3" "Back To Menu" 3>&1 1>&2 2>&3)

    case $DELETE in 
    1)
        source ./DeleteAllRecord.sh 
        ;;
    2)
        source ./DeleteRecord.sh
        ;;
    3)
        source ./Connect-Menu.sh
        ;;
    esac
else
    whiptail --title "Error" --msgbox "Table Not Exist" 8 78
    source ./Delete_menu.sh
fi	

