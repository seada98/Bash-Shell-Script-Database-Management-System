      if [ `ls ./database/$dbname | wc -l` == 0 ]
      then
      whiptail --title "Error" --msgbox "No Table Found" 8 78
      source ./Connect-Menu.sh
fi      

tbname=$(whiptail --title "Drop Tables" --inputbox "Which Table Do You Want To Drop ? " 8 40 3>&1 1>&2 2>&3)
exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi
while [[ ! -f ./database/$dbname/$tbname ]] || [[ -z $tbname ]] || [[ $tbname == *['!''*\ *@#/$\"*{^})(+_/|,;:~`.%&.=-]>[<?']* ]] || [[ $tbname == " " ]]
  do
  tbname=$(whiptail --title "Invalid Input" --inputbox "Please Enter Valid Table Name : " 8 40 3>&1 1>&2 2>&3)
  exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi
done

while [[ -f ./database/$dbname/$tbname ]]
do   
if whiptail --yesno "Are you sure ? " 8 78; 
    then
        rm ./database/$dbname/$tbname 
        rm ./database/$dbname/$tbname.Type
        whiptail --title "Done" --msgbox "Table Deleted Successfully" 8 78 
        source ./Connect-Menu.sh
  else
        whiptail --title "Error" --msgbox "Table Not Deleted" 8 78
      source ./Connect-Menu.sh
  fi
done