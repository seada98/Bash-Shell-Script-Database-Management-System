if [ `ls ./database/ | wc -l` == 0 ]
then
       whiptail --title "Error" --msgbox "No Database Found " 8 78
      source ./main.sh
fi     
dbname=$(whiptail --title "Connect Database" --inputbox "Please Enter Database You Want To Connect: " 8 40 3>&1 1>&2 2>&3)

export dbname
if [[ ! -d ./database/$dbname ]] || [[ -z $dbname ]]
then  
      whiptail --title "Error" --msgbox "$dbname Database Not Exists Create New " 8 78
      source ./main.sh
else
      whiptail --title "Done" --msgbox "Database Exists" 8 78
      source ./Connect-Menu.sh
      
fi

 