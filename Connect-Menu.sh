select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Back To Menu"
do
case $REPLY in
  1) source ./CreateTable.sh ;;
  2) source ./ListTable.sh ;;
  3) source ./DropTable.sh ;;
  4) source ./InsertIntoTable.sh ;;
  5) source ./SelectIntoTable.sh ;;
  6) source ./Delete_menu.sh ;;
  7) source ./UpdateTable.sh ;;
  8) source ./Main_menu.sh ;;
  *) echo -e "Invalid Option" ;; 
esac
done