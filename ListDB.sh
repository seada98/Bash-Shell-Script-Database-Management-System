if [ `ls ./database/ | wc -l` == 0 ]
then  
    whiptail --title "Error" --msgbox "No Database Found" 8 78 
    source ./main.sh
else
    whiptail --title "Database" --msgbox "$(ls ./database/)" 8 78
     source ./main.sh
fi