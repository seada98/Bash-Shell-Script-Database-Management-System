export NEWT_COLORS='
window=,gray
border=gray,black
textbox=white,gray
button=black,white
'
if [ ! -d "database" ]
then
    mkdir database
fi
 MAIN=$(whiptail --title "Welcome $USER" --menu "Choose an option" 15 60 5 \
    "1" "Create Databas" \
    "2" "List Database" \
    "3" "Connect To Database" \
    "4" "Drop Database" \
    "5" "Exit" 3>&1 1>&2 2>&3)
    exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         exit
      fi


case $MAIN in 
    1)
        source ./CreateDB.sh 
        ;;
    2)
        source ./ListDB.sh
        ;;
    3)
        source ./ConnectDB.sh
        ;;
    4)
        source ./DropDB.sh
        ;;
    5)
            exit
        ;;
esac


