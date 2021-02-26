# z3r0101 v1 PHP framework

# chmod +x z3r0101.ssh

# Command:
# ./z3r0101.ssh [create|remove] [website name]
# E.g.
# ./z3r0101.ssh create hellow-world


clear
printf "\033c"


is_executed=0

param_option=$1
param_website_name=$2


if [ "$1" == "" ]
then
        echo "Option param is required. Type create or remove."
        exit
fi


#if ls -1qA $param_website_name | grep -q .
#then
#	echo 'Not empty!'
#else
#	echo 'Empty!'	
#fi	
#exit


if [ "$1" == "create" ]
then

	if [ ! -d "$param_website_name" ]
	then
		mkdir $param_website_name
	fi

	bol_create=0

	if ls -1qA $param_website_name | grep -q .
	then
		echo "The directory is not empty, do you want to continue?"
		select yn in "Yes" "No"; do
			case $yn in
				Yes ) bol_create=1; break;;
				No ) break;;
			esac
		done
	else
		bol_create=1	
	fi

	if [ $bol_create -eq 0 ]
	then
		exit;
	else	

		cd $param_website_name
		git clone https://github.com/z3r0101/application.git
		git clone https://github.com/z3r0101/vendors.git
		mkdir compiles
		mkdir compiles/cms
		chmod -R 777 compiles #Use approriate write permission when moving to production
		mkdir assets
		mkdir assets/uploads
		mkdir assets/uploads/temp
		chmod -R 777 assets #Use approriate write permission when moving to production	
		wget https://raw.githubusercontent.com/z3r0101/siteroot/master/.htaccess
		wget https://raw.githubusercontent.com/z3r0101/siteroot/master/.gitignore
	 
		is_executed=1
	fi

fi

if [ "$1" == "remove" ]
then
	if [ -d "$param_website_name" ]
	then
		bol_remove_dir=0
		echo "Do you also want to remove the directory \"${param_website_name}\""
		select yn in "Yes" "No"; do
			case $yn in
				Yes ) bol_remove_dir=1; break;;
				No ) break;;
			esac
		done

		if [ $bol_remove_dir -eq 1 ]
		then
			rm -rf $param_website_name
		else
			cd $param_website_name && rm -rf `ls -Ab`	
		fi	

		
		is_executed=1
	else
		echo "Directory \"$2\" does not exist."; 
	fi
fi

if [ $is_executed -eq 0 ]
then
	echo "Option param not found. Type create or remove"
	exit
else
	if [ $is_executed -eq 1 ]
	then
		if [ "$1" == "create"  ]
		then
			echo "z3r0101 php framework project successfully created."
		fi
		if [ "$1" == "remove"  ]
		then	
			echo "z3r0101 php framework project has been removed."
		fi
	fi
fi
