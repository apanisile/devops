#!bin/bash

#update the system repo
sudo apt update

#what service is to be run?
read -p "What service would you like to check for: " software

#assigning the service to a variable
l=$service

echo "The service you are checking for is: ${l}"

sudo apt install $l -y

#function to check if the service is enabled
check_service_enabled() {
	
	service_enabled=$(sudo systemctl is-enabled $l)
	
	if [ $service_enabled = "enabled" ]
		then
			echo "$l is enabled"
	else
		echo "$l is not enabled"
		exit 1

	fi
}

#function to check if the service is active
check_service_active() {
	echo "The service you are checking for is: ${l}"
	
	service_is_activ=$(sudo systemctl is-active $l)

	if [ $service_is_activ = "active" ]
		then
			echo "$l is active"
	else 
		echo "$l is not active"
		exit 1

	fi
}


systemctl start l
check_service_enabled l
check_service_active l


