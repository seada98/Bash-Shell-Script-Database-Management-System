#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    whiptail --title "Error" --msgbox "Table Empty" 8 78
    source ./SelectIntoTable.sh
fi    
colname=$(whiptail --title "Column Name" --inputbox "Enter Column Name You Want To Select: " 8 40 3>&1 1>&2 2>&3)
exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi
while [[ -z $colname ]]
do 
            colname=$(whiptail --title "Invalid Input" --inputbox "PLease Enter Column Name Again : " 8 40 3>&1 1>&2 2>&3)
            exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi
done   

function selectcol(){

#check if column name exists
if [[ $colname =~ [`awk -F":" 'NR==1{for(i=1; i<=NF; i++) if ($i=="'$colname'") {a[i]++;} } { for (i in a) printf "%s\t", $i; printf "\n"}' ./database/$dbname/$tablename`] ]];
then
    #print chosen column

COLUMNSELECT=$(awk -F":" 'NR==1{for(i=1; i<=NF; i++) if ($i=="'$colname'") {a[i]++;} } { for (i in a) printf "%s\t", $i; printf "\n"}' ./database/$dbname/$tablename)
      whiptail --title "All Records" --msgbox "$COLUMNSELECT" 30 78
      #sed -n ''$coname'p' ./database/$dbname/$tablename    
    source ./Connect-Menu.sh
	  else              
                whiptail --title "Error" --msgbox "Column Not Exists" 8 78
                source ./SelectColumn.sh
fi
}
selectcol
