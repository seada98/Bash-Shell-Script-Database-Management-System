'''
echo -e "\nDataBases : \n"
if [ `ls ./database/ | wc -l` == 0 ]
then     
    echo -e "\nNo Database Found" 
    source ./Main_menu.sh
else
            ls ./database/
            source ./Main_menu.sh
fi
'''
#@whiptail --title "Done" --msgbox "DataBases" 8 78 
if [ `ls ./database/ | wc -l` == 0 ]
then  
    whiptail --title "Error" --msgbox "No Database Found" 8 78 
    source ./main.sh
else
    whiptail --title "Database" --msgbox "$(ls ./database/)" 8 78
     source ./main.sh
fi