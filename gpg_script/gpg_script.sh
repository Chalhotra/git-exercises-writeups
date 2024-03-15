#! /bin/bash
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
}
add_to_git() {
    echo "Select a key from the given list: "
    echo 
    echo $(gpg --list-secret-keys --keyid-format=long | grep "^sec" | awk '{print $2}')

    read -r gkey

    echo "Exporting selected key..."
    gpg --armor --export "$gkey" > gpg_key.pub
    git config --global user.signingkey "$gkey"
    git config --global commit.gpgsign true

    echo "Successfully added this key to your Git configuration."
}



delete_key() {
    echo "Enter the key ID you want to delete: "
    echo
    echo $(gpg --list-secret-keys --keyid-format=long | grep "^sec" | awk '{print $2}')

    read -r key_id


    if gpg --list-secret-keys --keyid-format=long "$key_id" &>/dev/null; then
        echo "Deleting the specified GPG key..."
        gpg --delete-secret-keys "$key_id"
        echo "Key with ID $key_id has been deleted."
    else
        echo "Error: Key with ID $key_id does not exist."
    fi
}

menu() {
    echo -e "1.) Create GPG Key"
    echo
    echo -e "2.) Add GPG Key to Git and GitHub"
    echo
    echo -e "3.) Delete GPG Key"
    echo
    echo -e "4.) Exit"

    read -r choice

    if [ "$choice" -eq 1 ]; then
        gpg_gen
        menu
    elif [ "$choice" -eq 2 ]; then
        add_to_git
        menu
    elif [ "$choice" -eq 3 ]; then
        delete_key
        menu
    

        
    elif [ "$choice" -eq 4 ]; then
        exit
    else 
        echo "Please choose a valid option"
        menu
    fi
}
banner
menu
