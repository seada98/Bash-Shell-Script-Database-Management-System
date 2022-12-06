echo -e "\nDataBases : \n"
if [ `ls ./database/ | wc -l` == 0 ]
then     
    echo -e "\nNo Database Found" 
    source ./Main_menu.sh
else
            ls ./database/
            source ./Main_menu.sh
fi

