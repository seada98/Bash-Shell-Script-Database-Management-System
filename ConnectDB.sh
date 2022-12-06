if [ `ls ./database/ | wc -l` == 0 ]
then
      echo -e "No Database Found"
      source ./Main_menu.sh
fi      

echo -e "Connect Database\n"
read -p "Please Enter Database You Want To Connect: " dbname
export dbname
if [[ ! -d ./database/$dbname ]] || [[ -z $dbname ]]
then  
      echo -e "$dbname Database Not Exists Create New "
      source ./Main_menu.sh
else
      echo -e "Database Exists\n"
      source ./Connect-Menu.sh
fi

 