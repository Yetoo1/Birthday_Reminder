#!/bin/bash
#Yeah I could have the verify utility in here but this is the init shell script, not the verify shell script.
DIRECTORY=~/.config/bdayrmndr/
CONFIGP=~/.config/bdayrmndr/.bdayrmndrc
#echo "$DIRECTORY"
#echo "$CONFIGP"
echo "This is bday reminder version <insert version access ability>. If you have already ran this, you dont need to do any thing. You just need to go to ~/.config/bdayrmndr/.bday and shange what you want, all this does is create the directory and sets the start up daemon."
echo "Checking if config exists..."
if [ -d "$DIRECTORY" ]; then
	echo "Directory already exists. If shit broke or nothing is in there use the verify utility in this folder."
	read -p "Do you want to use it now? y/n " line1 </dev/tty
	case $line1 in
		"y") echo "Calling the validation script."
		     sh ./validation.sh
		     echo "Exiting..."
		     exit 1
	             ;;
		"n") read -p "Do you want to overwrite? You and me both know how fucking dangerous this is. y/n " line12 </dev/tty
		     case $line12 in
			"y") echo "Going to overwrite..." #add timer
			     rm -rv "$DIRECTORY"
			     ;;	 
			"n") echo "Exiting..." 	             
			     exit 1
			     ;;	
		     esac	
	esac
	
fi 
echo "Creating the configuration folder and file(s)..."
mkdir -v "$DIRECTORY"
read -p "Give your birthdate in mm/dd/yyyy format: " line2 </dev/tty

echo "Creating $CONFIGP..."
#file already deleted so can write whatever, but to be safe first line should not append
echo "$line2" > "$CONFIGP"
