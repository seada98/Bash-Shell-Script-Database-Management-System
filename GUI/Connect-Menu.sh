MAIN=$(whiptail --title "Welcome $USER" --menu "Choose an option" 25 60 15 \
    "1" "Create Table" \
    "2" "List Tables" \
    "3" "Drop Table" \
    "4" "Insert into Table" \
    "5" "Select From Table" \
    "6" "Delete From Table" \
    "7" "Update From Table" \
    "8" "Back to menu" 3>&1 1>&2 2>&3)

    exitstatus=$?
if [ $exitstatus = 0 ]; then
         ...
      else
         source ./main.sh
      fi

case $MAIN in 
    1)
        source ./CreateTable.sh 
        ;;
    2)
        source ./ListTable.sh
        ;;
    3)
        source ./DropTable.sh
        ;;
    4)
        source ./InsertIntoTable.sh
        ;;
    5)
        source ./SelectIntoTable.sh
        ;;  
    6)
        source ./Delete_menu.sh
        ;;    
    7)
        source ./UpdateTable.sh
        ;;
    8)
        source ./main.sh
        ;;  
esac