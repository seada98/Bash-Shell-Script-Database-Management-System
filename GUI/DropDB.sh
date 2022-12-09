if [ `ls ./database/ | wc -l` == 0 ]
then
       whiptail --title "Error" --msgbox "No Database Found " 8 78
      source ./main.sh
fi      
name=$(whiptail --title "Drop Database" --inputbox "Which Database Do You Want To Drop ? " 8 40 3>&1 1>&2 2>&3)
exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./main.sh
      fi
while [[ ! -d ./database/$name ]] || [[ -z $name ]]
  do
      name=$(whiptail --title "Invalid Input" --inputbox "Please Enter Valid Database Again : " 8 40 3>&1 1>&2 2>&3)
     exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./main.sh
      fi
done
while [[ -d ./database/$name ]]
do  
    
    if whiptail --yesno "Are you sure ? " 8 78; 
    then
        rm -r ./database/$name 
        whiptail --title "Done" --msgbox "Database Deleted Successfully " 8 78 
        source ./main.sh
  else
        whiptail --title "Error" --msgbox "Database Not Deleted" 8 78
      source ./main.sh
  fi 
done