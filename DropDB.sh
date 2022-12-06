if [ `ls ./database/ | wc -l` == 0 ]
then
      echo -e "No Database Found"
      source ./Main_menu.sh
fi      

echo -e "Drop Database\n"
read -p "Which Database Do You Want To Drop ? " name

while [[ ! -d ./database/$name ]] || [[ -z $name ]]
  do
      echo -e "Invalid Input"
      read -p "Please Enter Valid Database Again : " name
     
done
while [[ -d ./database/$name ]]
do   
     read -p "Are you sure? [y/n] " response
      case "$response" in
       [yY]) 
      rm -r ./database/$name  
      echo -e "\nDatabase Deleted Successfully "
      source ./Main_menu.sh
        ;;
      [Nn])
      echo -e "\nDatabase Not Deleted"
      source ./Main_menu.sh
       ;;  
    *)
        echo -e "\nInvalid Input Try Again"
        source ./DropDb.sh
        ;;
       esac 
done