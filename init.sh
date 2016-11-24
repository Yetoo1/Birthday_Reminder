#!/bin/bash
#The license to this is that if you copy it, fuck you, you know what, since you want my beautifully crafted work so bad why don't you write your name before and after each command and word 5 times in comment form. No screw "why don't you", YOU MUST!
#Author: Yetoo Happy
#Yeah I could have the verify utility in here but this is the init shell script, not the verify shell script.
#Also, the idea behind this script is that it helps the user have a guidline on what to input into the config. After the init is done, it is encouraged to manually edit the file with all their will, joy, and effort.  
DIRECTORY=~/.config/bdayrmndr/
CONFIGP=~/.config/bdayrmndr/.bdayrmndrc #config path
#echo "$DIRECTORY"
#echo "$CONFIGP"
echo "This is bday reminder version <insert version access ability>. If you have already ran this, you dont need to do any thing. You just need to go to ~/.config/bdayrmndr/.bday and shange what you want, all this does is create the directory and sets the start up daemon."
echo "Checking if config exists..."
#add possibility of capital y/n answers
if [ -d "$DIRECTORY" ]; then
	echo "Directory already exists. If shit broke or nothing is in there use the verify utility in this folder."
	read -p "Do you want to use it now? y/n " line1 </dev/tty
	case $line1 in
		"y") echo "Calling the validation script."
		     sh ./validation.sh
		     echo "Exiting..."
		     exit 1
	             ;;
		"n") read -p "Do you want to overwrite? You can trust me buddy ol' boy. y/n " line12 </dev/tty
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
echo "Initiating the creation of the configuration folder and file(s)..."
mkdir -v "$DIRECTORY"
while :
do
read -p "Give your birthdate in mm/dd/yyyy format: " line2 </dev/tty
#echo ${#line2}
#no need to check for slashes because if there is a discrepancy, the if loop will take care of it
mm=$(echo $line2| cut -d'/' -f 1)
tt=$(echo $line2| cut -d'/' -f 2)
yyyy=$(echo $line2| sed 's/.*\///')
re='^[0-9]+$'
#echo "$mm"
#echo "$tt"
#echo "$yyyy"
if [[ ${#mm} == 2 ]] && [[ $mm =~ $re ]]; then
#fix below, make ability to 
#if [[ $mm -ge 13 ]] || [[ $mm -le 0 ]]; then
#	read -p "You have impossible months according to the gregorian calendar. You will have the option to continue or change your date. You will have the option to continue just in case of the possibility of the date command to which your inputted date is compared to updates to a calendar that supports your date becomes absolute. Continue? y/n" line21 </dev/tty		
#	case $line21 in 
#		"y") break 
#		     ;;
#
#		"n") ;;
#	esac 	
	if [[ ${#tt} == 2 ]] && [[ $tt =~ $re ]]; then
		
		if [[ ${#yyyy} == 4 ]] && [[ $yyyy =~ $re ]]; then
			break
		else
			echo "Fix your year field."
		fi		
	else
		echo "Fix your day field."
	fi
else
	echo "Fix your month field."
fi
done
touch "$CONFIGP"
echo "Created $CONFIGP"
#file already deleted so can write whatever, but to be safe first line should not append
echo "$line2" > "$CONFIGP"
echo "Wrote birth date to $CONFIGP"
#this next section allows the user to choose the personalization of their file, recommend that editing the config manually would be easier and give option to get off (add that to top)
#read -p "what files do you want" file1 </dev/tty 
