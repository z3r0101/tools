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


if [ "$1" == "create" ]
then
		
	if [ ! -d "$2" ]
	then
		mkdir $2
		cd $2
		git clone https://github.com/z3r0101/application.git
		git clone https://github.com/z3r0101/vendors.git
		mkdir compiles
		mkdir compiles/cms
		chmod -R 777 compiles #Use approriate write permission when moving to production
		mkdir uploads
		mkdir uploads/cms
		chmod -R 777 uploads #Use approriate write permission when moving to production	
		wget https://raw.githubusercontent.com/z3r0101/siteroot/master/.htaccess
		wget https://raw.githubusercontent.com/z3r0101/siteroot/master/.gitignore
	 

		is_executed=1
	else
		echo "Directory \"$2\" already exist.";
	fi
fi

if [ "$1" == "remove" ]
then
	if [ -d "$2" ]
	then
		rm -rf $2
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


