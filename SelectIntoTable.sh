#check if there is no tables in database 
if [ `ls ./database/$dbname | wc -l` == 0 ]
then
      whiptail --title "Error" --msgbox "No Table Found" 8 78
      source ./Connect-Menu.sh
fi      
tablename=$(whiptail --title "Select Table" --inputbox "Enter Table You Want To Select : " 8 40 3>&1 1>&2 2>&3)
exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi

while [[ -z $tablename ]]
do 
  tablename=$(whiptail --title "Invalid Input" --inputbox "PLease Enter Table Name Again : " 8 40 3>&1 1>&2 2>&3)
  exitstatus=$?
    if [ $exitstatus = 0 ]; then
         :
    else
            source ./Connect-Menu.sh
    fi
done

export tablename

if [ -f ./database/$dbname/$tablename ]
then
    SELECT=$(whiptail --title "Select Options" --menu "Choose an option" 15 60 5 \
    "1" "Select All Records" \
    "2" "Select Record" \
    "3" "Select Column" \
    "4" "Back To Table Menu" 3>&1 1>&2 2>&3)

    case $SELECT in 
    1)
        source ./SelectAllRecords.sh 
        ;;
    2)
        source ./SelectRecord.sh
        ;;
    3)
        source ./SelectColumn.sh
        ;;
    4)
        source ./Connect-Menu.sh
        ;;
    esac
else
whiptail --title "Error" --msgbox "Table Not Exists" 8 78
   source ./SelectIntoTable.sh
fi	
