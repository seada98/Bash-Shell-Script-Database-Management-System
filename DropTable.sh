if [ `ls ./database/$dbname | wc -l` == 0 ]
then
      echo -e "No Table Found"
      source ./Connect-Menu.sh
fi      

echo -e "Drop Tables\n"

read -p "Which Table Do You Want To Drop ? " tbname
while [[ ! -f ./database/$dbname/$tbname ]] || [[ -z $tbname ]]
  do
      echo -e "Invalid Input"
      read -p "Please Enter Valid Table Name : " tbname
     
done
while [[ -f ./database/$dbname/$tbname ]]
do   
     read -p "Are you sure? [y/n] " response
      case "$response" in
        [yY]) 
            rm ./database/$dbname/$tbname 
            rm ./database/$dbname/$tbname.Type
            echo -e "Table Deleted Successfully"
            source ./Connect-Menu.sh
            ;;
          
        [Nn])
            echo -e "Table Not Deleted"
            source ./Connect-Menu.sh
          ;;
        *)  
            echo -e "Invalid Input"
            source ./DropTable.sh
            ;;
       esac 
done
