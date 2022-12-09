tbname=$(whiptail --title "Create Table" --inputbox "Enter Table Name : " 8 40 3>&1 1>&2 2>&3)
exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi
declare -a cnamearray 
declare -a ctypearray 
re='^[0-9]+$'


while [[ -z $tbname ]] || [[ $tbname == *['!''*\ *@#/$\"*{^})(+_/|,;:~`.%&.=-]>[<?']* ]] || [[ $tbname =~ [0-9]  ]] || [[ $tbname == " " ]]
do 
    tbname=$(whiptail --title "Invalid Input" --inputbox "PLease Enter Table Name Again : " 8 40 3>&1 1>&2 2>&3)
    exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi
done

while [ -f ./database/$dbname/$tbname ] 
do
    whiptail --title "Error" --msgbox "Table Already Exists" 8 78
    source ./Connect-Menu.sh
done
#read column number from user
cnumber=$(whiptail --title "Table Configuration" --inputbox "Enter Number Of Columns : " 8 40 3>&1 1>&2 2>&3)
exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
      rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type 
         source ./Connect-Menu.sh
      fi
# function to check validation of cnumber
function valcnumber()
{
  while [[ -z $cnumber ]] || [[ $cnumber == *['!''*\ *@#/$\"*{^})(+_/|,;:~`.%&.=-]>[<?']* ]] || [[ $cnumber =~ [a-zA-Z] ]] || [[ $tbname == " " ]]
do 
   cnumber=$(whiptail --title "Invalid Input It Must Be A Number" --inputbox "PLease Enter Number Of Columns Again : " 8 40 3>&1 1>&2 2>&3)
  exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
      rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
         source ./Connect-Menu.sh
      fi
done

}
valcnumber                    #calling function
export cnumber
 whiptail --title "Table Configuration" --msgbox "First Column Must Be Primary Key" 8 78
touch ./database/$dbname/$tbname ./database/$dbname/$tbname.Type 
# to enter the columns name with input column numbers
for (( i=0 ; i < $cnumber ; i++ ))
do
  cname=$(whiptail --title "Table Configuratio" --inputbox "Enter Name Of Column $((i+1)): " 8 40 3>&1 1>&2 2>&3)
  exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
      rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
         source ./Connect-Menu.sh
      fi
  while [[ -z $cname ]] || [[ $cname == *['!''*\ *@#/$\"*{^})(+_/|,;:~`.%&=-]>[<?']* ]] || [[ $cname =~ $re ]] || [[ $tbname == " " ]]
  do 
    cname=$(whiptail --title "Invalid Input" --inputbox "PLease Enter column Name Again : " 8 40 3>&1 1>&2 2>&3)
    exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
      rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
         source ./Connect-Menu.sh
      fi
  done
 
  ##### check if the cname is exists or not 
  while [[ "${cnamearray[$tbname]}" =~ "$cname" ]]
  do
    cname=$(whiptail --title "This Name Is Already Exists" --inputbox "PLease Enter Column Name Again : " 8 40 3>&1 1>&2 2>&3)
    exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
      rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
         source ./Connect-Menu.sh
      fi
  done
   #enter datatype     
     ctype=$(whiptail --title "Table Configuratio" --inputbox "Enter DataType Of Column $((i+1)): [string/int] " 8 40 3>&1 1>&2 2>&3)
     exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
      rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
         source ./Connect-Menu.sh
      fi
 
  #check on datatype
  while [[ $ctype != int ]] && [[ $ctype != string ]] 
  do
  ctype=$(whiptail --title "Invalid DataType" --inputbox "Enter DataType of column $((i+1)): [string/int] " 8 40 3>&1 1>&2 2>&3)
  exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
      rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
         source ./Connect-Menu.sh
      fi
  done
        
        cnamearray[$i]=$cname
        ctypearray[$i]=$ctype
done
#put delimeter
for (( i=0 ; i < $cnumber ; i++ ))
do
  echo -ne "${cnamearray[$i]}:" >> ./database/$dbname/$tbname
done
echo "" >> ./database/$dbname/$tbname
##Append data to table and tabletype
echo ${ctypearray[@]} >> ./database/$dbname/$tbname.Type
 whiptail --title "Table Configuration" --msgbox "Congratulations Your Table Is Created" 8 78
source ./Connect-Menu.sh
