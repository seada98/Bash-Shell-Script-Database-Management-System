echo -e "\nCreate Database\n"
read -p "Enter Database Name : " name
while [[ -z $name ]] || [[ $name == *['!''@#/$\"*{^})(+|,;:~`._%&/=-]>[<?']* ]] || [[ $name =~ [0-9] ]]
do 
            echo -e "It Must Be Only Characters"
            read -p "PLease Enter Database Name Again : " name
done
if [ -d ./database/$name ] 
then
    echo -e "Database Already Exists "
    source ./CreateDB.sh
fi
mkdir ./database/$name  
echo -e "Database Is Created Succuflly "	
source ./Main_menu.sh
          

