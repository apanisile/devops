#!bin/bash


read -p "Do you want to update the system repo? (Y)es or (N)o: " update
if [ $update = "Y" ]
    then 
        #update the system repo
        sudo apt update
else
    echo "Skipping to the installation process: "
fi


#what service is to be run?
read -p "What service would you like to check for: " software

#assigning the service to a variable
l=$software

echo "The service you are checking for is: ${l}"

#Install the package
sudo apt install $l -y


#function to check if the service is enabled
check_service_enabled() {
	
	service_enabled=$(sudo systemctl is-enabled $l)
	
	if [ $service_enabled = "enabled" ]
		then
			echo "$l is enabled"
	else
		echo "$l is not enabled"
        read -p "Do you want to enable it? (Y)es or (N)o" answer
        if [ $answer = "Y"]
            then 
                sudo systemctl enable $l
        else
            echo "Okay Chief"
        fi

        exit 1

	fi
}

#function to check if the service is active
check_service_active() {	
	service_is_activ=$(sudo systemctl is-active $l)

	if [ $service_is_activ = "active" ]
		then
			echo "$l is active"
	else 
		echo "$l is not active"
		exit 1

	fi
}

#start the downloaded software
systemctl start l

#check if the software is enabled
check_service_enabled l

#Check if the software is active and running
check_service_active l


