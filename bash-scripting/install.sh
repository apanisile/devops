#!/bin/bash

while true
do
    echo "Hey there! what would you like to do today? "
    echo "1. Install a software"
    echo "2. Check if a software is enabled:"
    echo "3. Check if a software is running: "
    read -p "The selected option is: " choice

    if [ $choice -eq 1 ]
    then 
        read -p "Do you want to update the system repo? (Y)es or (N)o: " update
        if [ $update = "Y" ]
            then 
                #update the system repo
                sudo apt update
        else
            echo "Skipping to the installation process: "
        fi

        #what software to be installed?
        read -p "What software would you like to install: " software
        
        #assigning the service to a variable
        l=$software
        
        echo "Declaration: You are about to install ${l} on your system"
        
        #Install the package
        sudo apt install ${l} -y

        sudo systemctl enable ${l}

        sudo systemctl start ${l}

    elif [ $choice -eq 2 ]
    then
        #what software to be installed?
        read -p "What service would you like to enable: " software
        
        #assigning the service to a variable
        l=$software

        #function to check if the service is enabled
        check_service_enabled() {
            
            service_enabled=$(sudo systemctl is-enabled $l)
            
            if [ $service_enabled = "enabled" ]
                then
                    echo "$l is enabled"
            else
                echo "$l is not enabled"
                echo "Do you want to enable it? "
                read -p "(Y)es or (N)o" answer
                if [ $answer = "Y"]
                    then 
                        sudo systemctl enable $l
                else
                    echo "Okay Chief"
                    break
                fi

                exit 1
            fi
        }
        #check if the software is enabled
        check_service_enabled l

    elif [ $choice -eq 3 ]
    then
        #prompt to activate a service
        read -p "What service would you like to activate: " software
        
        #assigning the service to a variable
        l=$software

        #function to check if the service is active
        check_service_active() {	
            service_is_activ=$(sudo systemctl is-active $l)

            if [ $service_is_activ = "active" ]
                then
                    echo "$l is active"
            else 
                echo "$l is not active"
                break
            fi
        }
        
        #Check if the software is active and running
        check_service_active l
    fi  

    echo "Do you want to perform another function? "
    read -p "(Y)es or (N)o: " again
    if [ $again != "Y" ]
        then
            exit 1
        fi
done
