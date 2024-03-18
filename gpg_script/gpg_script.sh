#! /bin/bash
source ./configure.sh
banner() {
        echo "---------------------------------------------------------------------------------------"
    echo """                                
 _____ _____ _____         _     
|   __|  _  |   __|___ ___|_|___ 
|  |  |   __|  |  | -_|   | | -_|
|_____|__|  |_____|___|_|_|_|___|
                                 """
   
    echo
    echo "---------------------------------------------------------------------------------------"
    
}
gpg_gen() {
    gpg --full-generate-key
    echo
    echo "------------------------------------------"
    echo
}

add_to_git() {
    echo "Select a key using its index from the given list: "
    echo 
    counter=1
    gpg --list-secret-keys --keyid-format=long | grep "^sec" | while read -r line; do
        key_id=$(echo "$line" | awk '{print $2}' | awk -F "/" '{print $2}')
        echo "$counter) $key_id"
        ((counter++))
        
    done
    read n
    integer_pattern='^[0-9]+$'
    if [[ "$n" =~ $integer_pattern ]]; then

        gkey=$(gpg --list-secret-keys --keyid-format=long | grep "^sec" | awk '{print $2}'| awk -F '/' '{print $2}' | sed -n "${n}p")

        echo "Exporting selected key..."
        gpg --armor --export "$gkey" > gpg_key.pub
        git config --global user.signingkey "$gkey"
        git config --global commit.gpgsign true
        gpg --armour --export $gkey
        echo "Successfully added this key to your Git configuration."
        echo
        echo "------------------------------------------"
        echo
    else
        echo "Please choose a valid option"
        true
    fi
}


delete_key() {
    echo "Enter the index of the key you want to delete: "
    echo
    
    counter=1
    gpg --list-secret-keys --keyid-format=long | grep "^sec" | while read -r line; do
        key_id=$(echo "$line" | awk '{print $2}' | awk -F "/" '{print $2}')
        echo "$counter) $key_id"
        ((counter++))
        
    done
    read n
    integer_pattern='^[0-9]+$'
    if [[ "$n" =~ $integer_pattern ]]; then

        key_count=$(gpg --list-secret-keys --keyid-format=long | grep "^sec" | wc -l)

        if [ "$n" -le $key_count ];then
            key_id=$(gpg --list-secret-keys --keyid-format=long | grep "^sec" | awk '{print $2}' |awk -F "/" '{print $2}'| sed -n "${n}p")

            echo "Deleting the specified GPG key..."
            gpg --delete-secret-keys "$key_id"
            echo
            echo "------------------------------------------"
            echo
        else
            true
        fi
    else
        echo "Please choose a valid option"
        true
    fi
    
}
view_key() {
    counter=1
    gpg --list-secret-keys --keyid-format=long | grep "^sec" | while read -r line; do
        key_id=$(echo "$line" | awk '{print $2}' | awk -F "/" '{print $2}')
        echo "$counter) $key_id"
        ((counter++))

    done

    echo
    echo "-----------------------------------------"
    echo "-> Enter the index of the key whose PGP you would like to see"
    echo
    echo "-> 0 to Go back"

    read n
    
    key_count=$(gpg --list-secret-keys --keyid-format=long | grep "^sec" | wc -l)
    integer_pattern='^[0-9]+$'
    if [[ "$n" =~ $integer_pattern ]]; then
        if [ "$n" -eq 0 ]; then
            true
        
        elif [ "$n" -le $key_count ]; then
            key_id=$(gpg --list-secret-keys --keyid-format=long | grep "^sec" | awk '{print $2}' |awk -F "/" '{print $2}'| sed -n "${n}p")
            
            gpg --armour --export $key_id
        else 
            true
        fi
    else
        echo "Please choose a valid option"
        true
    fi
    echo
    echo "------------------------------------------"
    echo
    
}

menu() {
    echo -e "1.) Create GPG Key"
    echo
    echo -e "2.) Add GPG Key to Git"
    echo
    echo -e "3.) Delete GPG Key"
    echo
    echo -e "4.) View all ur GPG keys"
    echo  
    echo -e "5.) Exit"

    read choice
    integer_pattern='^[0-9]+$'
    if [[ "$choice" =~ $integer_pattern ]]; then
        if [ "$choice" -eq 1 ]; then
            gpg_gen
            menu
        elif [ "$choice" -eq 2 ]; then
            add_to_git
            menu

        elif [ "$choice" -eq 4 ]; then
            view_key
            menu


        elif [ "$choice" -eq 3 ]; then
            delete_key
            menu
            
        elif [ "$choice" -eq 5 ]; then
            exit
        else 
            echo "Please choose a valid option"
            menu
        fi
    else
        echo "Please choose a valid option"
            menu
    fi
}

banner
menu
