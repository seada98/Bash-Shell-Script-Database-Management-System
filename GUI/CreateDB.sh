
name=$(whiptail --title "Create Database" --inputbox "Enter Database Name : " 8 40 3>&1 1>&2 2>&3)
exitstatus=$?
      if [ $exitstatus = 0 ]; then
         ...
      else
         source ./main.sh
      fi

while [[ -z $name ]] || [[ $name == *['!''*\ *@#/$\"*{^})(+|,;:~`._%&/=-]>[<?']* ]] || [[ $name =~ [0-9] ]]
do 
    name=$(whiptail --title "It Must Be Only Characters" --inputbox "PLease Enter Database Name Again : " 8 40 3>&1 1>&2 2>&3) 
    exitstatus=$?
      if [ $exitstatus = 0 ]; then
         ...
      else
         source ./main.sh
      fi
done
if [ -d ./database/$name ] 
then
    whiptail --title "Error" --msgbox "Database Already Exists " 8 78
    source ./CreateDB.sh
fi
    mkdir ./database/$name  
    whiptail --title "Done" --msgbox "Database Is Created Succuflly " 8 78	
    source ./main.sh
          