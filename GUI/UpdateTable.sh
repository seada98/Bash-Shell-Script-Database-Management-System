if [ `ls ./database/$dbname | wc -l` == 0 ]
then
whiptail --title "Error" --msgbox "No Table Found" 8 78
      source ./Connect-Menu.sh
fi      

function update()
{
    re='^[0-9]+$'
    tablename=$(whiptail --title "Update Tables" --inputbox "Enter Table You Want To Update : " 8 40 3>&1 1>&2 2>&3)
    exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         source ./Connect-Menu.sh
      fi
    #export tablename
    while [[ -z $tablename ]] || [[ $tablebname == *['!''*\ *@#/$\"*{^})(+_/=|,;:~`.%&-]>[<?']* ]] || [[ $tablename == " " ]]
    do 
    tablename=$(whiptail --title "Invalid Input" --inputbox "PLease Enter Table Name Again : " 8 40 3>&1 1>&2 2>&3)
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
     colname=$(whiptail --title "You Shouldn't Change PK" --inputbox "Please Enter Name Of Primary Key Column : " 8 40 3>&1 1>&2 2>&3)
         exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         update
      fi
        #print record number of the pk row
        colno=`awk -F":" '{if ($1=="'$colname'") print NR}' ./database/$dbname/$tablename`
       
        #check that is integer
        if [ -n "$colno" ]
        then 
            record=$(whiptail --title "Update Configuration" --inputbox "Enter Value of Primary Key You Want To Update: " 8 40 3>&1 1>&2 2>&3)
            exitstatus=$?
      if [ $exitstatus = 0 ]; then
         :
      else
         update
      fi
            #check if pk exists
            if [[ $record =~ [`cut -d':' -f1 ./database/$dbname/$tablename | grep -x $record`] ]]  
                then              
                #take the new value from user in array
                    for (( j=1 ; j < `cat ./database/$dbname/$tablename.Type | wc -w` ; j++ ))
                    do
                        #put value of pk in first position[0]
                        valueofcnamearray[0]=$record
                        valueofcname=$(whiptail --title "Update Configuration" --inputbox "Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " 8 40 3>&1 1>&2 2>&3)
                        exitstatus=$?
                    if [ $exitstatus = 0 ]; then
                            :
                    else
                            update
                    fi
                        ## check datatype of record
                        function checkdatatype()
                        {
                        datatype=`cut -f $((j+1)) -d " " ./database/$dbname/$tablename.Type`
                        ###check if value is integer
                        if [[ "$datatype" == "int" ]]
                        then 
                            while ! [[ $valueofcname =~ $re ]]
                            do
                                valueofcname=$(whiptail --title "Column Must Be Integer" --inputbox "Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " 8 40 3>&1 1>&2 2>&3)
                                exitstatus=$?
                                if [ $exitstatus = 0 ]; then
                                    :
                                else
                                    update
                                fi
                            done
                        fi
                        ###check if value is string
                        if [[ "$datatype" == "string" ]] 
                        then 
                            while  [[ $valueofcname =~ $re ]] || [[ -z $valueofcname ]] || [[ $valueofcname == *['!''@#/$\"*{^})(+_/=-]>[<?']* ]]
                            do
                                valueofcname=$(whiptail --title "Column Must Be String" --inputbox "Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " 8 40 3>&1 1>&2 2>&3)
                                exitstatus=$?
                                if [ $exitstatus = 0 ]; then
                                    :
                                else
                                    update
                                fi
                            done
                        fi
                        }
                        checkdatatype                        
                        valueofcnamearray[$j]=${valueofcname}       
                    done  
                    #delete the old record then insert the new one
                    recordnumber=`awk -F":" '{if ($1=="'$record'") print NR}' ./database/$dbname/$tablename`  
                    sed -i ''$recordnumber'd' ./database/$dbname/$tablename            
                     
                     #take the array and pass it to the file
                     #Array to count number of columns
                     for (( j=0 ; j < `cat ./database/$dbname/$tablename.Type | wc -w` ; j++ ))
                     do
                        echo -ne "${valueofcnamearray[$j]}:" >> ./database/$dbname/$tablename
                     done
                     echo "" >> ./database/$dbname/$tablename                
                     whiptail --title "Done" --msgbox "Value Changes Successfully" 8 78
                     source ./Connect-Menu.sh
            else
                whiptail --title "Error" --msgbox "Value Not Exists" 8 78 
                update 
            fi   
        else
        whiptail --title "Error" --msgbox "Wrong Column" 8 78
            update
        fi

    else
        whiptail --title "Error" --msgbox "Table Not Exists" 8 78
        update
    fi
    }
update    #calling update function
