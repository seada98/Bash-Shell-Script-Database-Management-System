#check if there is no tables in database 
if [ `ls ./database/$dbname | wc -l` == 0 ]
then
      echo -e "No Table Found"
      source ./Connect-Menu.sh
fi      

echo -e "Select Table\n"

read -p "Enter Table You Want To Select : " tablename

while [[ -z $tablename ]]
do 
  echo -e "Invalid Input"
  read -p "PLease Enter Table Name Again : " tablename
done

export tablename

if [ -f ./database/$dbname/$tablename ]
then
    select choice in "Select All Records" "Select Record" "Select Column" "Back To Table Menu"
    do
      case $REPLY in
        1) source ./SelectAllRecords.sh ;;
        2) source ./SelectRecord.sh ;;
        3) source ./SelectColumn.sh ;;
        4) source ./Connect-Menu.sh ;;
        *) echo -e "Invalid Option" ;; 
      esac
    done
else
    echo -e "Table Not Exists"
    source ./SelectIntoTable.sh
fi	
