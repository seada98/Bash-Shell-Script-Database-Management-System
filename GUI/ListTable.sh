#whiptail --title "Tables" --msgbox "List Of Tables" 8 78
if [ `ls ./database/$dbname/ | wc -l` == 0 ]
then     
     whiptail --title "Error" --msgbox "No Table Found" 20 78
    source ./Connect-Menu.sh   
else
    whiptail --title "Tables" --msgbox "$(ls -I "*Type" ./database/$dbname)" 20 78
    source ./Connect-Menu.sh
fi

