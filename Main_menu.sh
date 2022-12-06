PS3="Your Choose Is : "
if [ ! -d "database" ]
then
    mkdir database
fi
echo -e "\nWelcome ${USER^}\n"
select choice in "Create Database" "List Database" "Connect To Database" "Drop Database" "Exit"
do
    case $REPLY in
      1) source ./CreateDB.sh  ;;
      2) source ./ListDB.sh ;;
      3) source ./ConnectDB.sh ;;
      4) source ./DropDB.sh ;;
      5) break ;;
      *) echo -e "\nInvalid Option" 
            source ./Main_menu.sh;; 
esac
done
