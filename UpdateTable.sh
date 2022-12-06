if [ `ls ./database/$dbname | wc -l` == 0 ]
then
      echo -e "No Table Found"
      source ./Connect-Menu.sh
fi      

echo -e "Update Table\n"

function update()
{
    re='^[0-9]+$'
    read -p "Enter Table You Want To Update : " tablename
    #export tablename
    while [[ -z $tablename ]] || [[ $tablebname == *['!''@#/$\"*{^})(+_/=|,;:~`.%&-]>[<?']* ]]
    do 
        echo -e "Invalid Input"
        read -p "PLease Enter Table Name Again : " tablename
    done
    declare -a valueofcnamearray
    if [ -f ./database/$dbname/$tablename ]
    then
         echo -e "You Shouldn't Change PK"
         read -p "Please Enter Name Of Primary Key Column : " colname
         
        #print record number of the pk row
        colno=`awk -F":" '{if ($1=="'$colname'") print NR}' ./database/$dbname/$tablename`
       
        #check that is integer
        if [ -n "$colno" ]
        then 
            read -p "Enter Value of Primary Key You Want ToUpdate: " record
            
            #check if pk exists
            if [[ $record =~ [`cut -d':' -f1 ./database/$dbname/$tablename | grep -x $record`] ]]  
                then              
                #take the new value from user in array
                    for (( j=1 ; j < `cat ./database/$dbname/$tablename.Type | wc -w` ; j++ ))
                    do
                        #put value of pk in first position[0]
                        valueofcnamearray[0]=$record
                        read -p "Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " valueofcname
                        ## check datatype of record
                        function checkdatatype()
                        {
                        datatype=`cut -f $((j+1)) -d " " ./database/$dbname/$tablename.Type`
                        ###check if value is integer
                        if [[ "$datatype" == "int" ]]
                        then 
                            while ! [[ $valueofcname =~ $re ]]
                            do
                                echo -e "Column Must Be Integer"
                                read -p "Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " valueofcname
      
                            done
                        fi
                        ###check if value is string
                        if [[ "$datatype" == "string" ]] 
                        then 
                            while  [[ $valueofcname =~ $re ]] || [[ -z $valueofcname ]] || [[ $valueofcname == *['!''@#/$\"*{^})(+_/=-]>[<?']* ]]
                            do
                                echo -e "Column Must Be String"
                                read -p "Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " valueofcname
        
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
                     
                     echo -e "Value Changes Successfully"
                     source ./Connect-Menu.sh
            else
                echo -e "Value Not Exists" 
                update 
            fi   
        else
            echo -e "Wrong Column"
            update
        fi

    else
        echo -e "Table Not Exists"
        update
    fi
    }
update    #calling update function
