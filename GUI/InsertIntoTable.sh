if [ `ls ./database/$dbname | wc -l` == 0 ]
then
    whiptail --title "ُError" --msgbox "No Table Found" 8 78
      source ./Connect-Menu.sh
fi      
    tablename=$(whiptail --title "Insert Into Table" --inputbox "Enter Table You Want To Insert : " 8 40 3>&1 1>&2 2>&3)
    exitstatus=$?
         if [ $exitstatus = 0 ]; then
           :
         else
            source ./Connect-Menu.sh
         fi
re='^[0-9]+$'
while [[ -z $tablename ]] || [[ $tablebname == *['!''@#/$\"*{^})(+_/|,;:~`.%&.=-]>[<?']* ]] || [[ $tbname == " " ]]
    do 
      tablename=$(whiptail --title "Invalid Input" --inputbox "PLease Enter Table Name Again :" 8 40 3>&1 1>&2 2>&3)
      exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi

done
declare -a valueofcnamearray

if [ -f ./database/$dbname/$tablename ]
then
    whiptail --title "ُNote" --msgbox "Primary Key Must Be Unique" 8 78
    #iterate on tablename.type to know the number of fields to insert in it
    for (( j=0 ; j < `cat ./database/$dbname/$tablename.Type | wc -w` ; j++ ))
    do
        valueofcname=$(whiptail --title "Insert Into Table" --inputbox "Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " 8 40 3>&1 1>&2 2>&3)
       ## check datatype of record
       function checkdatatype()
       {
           #know the datatype of the column in the table type
            datatype=`cut -f $((j+1)) -d " " ./database/$dbname/$tablename.Type`
       ###check if value is integer

       if [[ "$datatype" == "int" ]] 
       then 
           while ! [[ $valueofcname =~ $re ]]
           do
              valueofcname=$(whiptail --title "Column Must Be Integer" --inputbox "Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " 8 40 3>&1 1>&2 2>&3)
      
           done
       fi
       ###check if value is string
       if [[ "$datatype" == "string" ]] 
       then 
           while  [[ $valueofcname =~ $re ]] || [[ -z $valueofcname ]] || [[ $valueofcname == *['!''@#/$\"*{^})(+_|,;:~`.%&/=-]>[<?']* ]]
              do
                  valueofcname=$(whiptail --title "Column Must Be String" --inputbox "Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " 8 40 3>&1 1>&2 2>&3)
             done
        fi
        }
        ###########check primary key
        function checkpk()
        {
        pkvalue=`cut -f 1 -d ":" ./database/$dbname/$tablename | grep -w $valueofcname`
        #check that pkvalue = input value of colname ,,&&,, check that it belong in the first column onlyyyyy
        while [[ $pkvalue == $valueofcname ]] && [[ $j == 0 ]]
        do 
            valueofcname=$(whiptail --title "This Value Is Already Exists (Pk)" --inputbox "Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " 8 40 3>&1 1>&2 2>&3)
        done    
        }
        checkdatatype
        checkpk
            #insert values of array
        valueofcnamearray[$j]=$valueofcname
    done

#take the array and pass it to the file
    for (( j=0 ; j < `cat ./database/$dbname/$tablename.Type | wc -w` ; j++ ))
    do
        echo -ne "${valueofcnamearray[$j]}:" >> ./database/$dbname/$tablename
    done
        echo "" >> ./database/$dbname/$tablename
else
        whiptail --title "ُError" --msgbox "Table Not Exists" 8 78
        source ./InsertIntoTable.sh
fi
whiptail --title "ُDone" --msgbox "Insertion Complete" 8 78
source ./Connect-Menu.sh


  
