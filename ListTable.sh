echo -e "Tables\n"
if [ `ls ./database/$dbname/ | wc -l` == 0 ]
then     
    echo -e "No Table Found\n"
    source ./Connect-Menu.sh   
else
    ls -I "*Type" ./database/$dbname
    source ./Connect-Menu.sh
fi

