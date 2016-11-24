#!/bin/bash
#The license to this is that if you copy it, fuck you, you know what, since you want my beautifully crafted work so bad why don't you write your name before and after each command and word 5 times in comment form. No screw "why don't you", YOU MUST!
#Author: Yetoo Happy
#Contact: yetoohappy@gmail.com
#Yeah I could have the verify utility in here but this is the init shell script, not the verify shell script.
#Also, the idea behind this script is that it helps the user have a guidline on what to input into the config. After the init is done, it is encouraged to manually edit the file with all their will, joy, and effort.
#change all the y/n cases to if statements 
#in the event of the requirement of the calling of terminal, make a function or some shit that checks what terminal the user uses. If in the event that there is a different terminal than the ones supported, this script has got to say something
#also speaking of functions, make some functions and shit to clean this thing up 
DIRECTORY=~/.config/bdayrmndr/
CONFIGP=~/.config/bdayrmndr/.bdayrmndrc #config path
#echo "$DIRECTORY"
#echo "$CONFIGP"
#start the service
#make sure to check if it's already running because we wouldn't want a fuck up would we?

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
		"n") read -p "Do you want to overwrite? If you choose 'no' this script will exit but you can trust me buddy ol' boy can't you? y/n " line12 </dev/tty
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
echo -e "Please understand that all this does is help you understand the format of the configuration file by making examples of the things you input. If you know the config format by heart you can skip this."
read -p "Do you want to continue? y/n " continuel </dev/tty
#yes, i'm aware that if any other key is entered into the case it just goes onto the next sequence
case $continuel in
	"y") ;;
	"n") echo "Exiting..."
	     exit 1
	     ;;
esac
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
#re='^[0-9]+$'
#echo "$mm"
#echo "$tt"
#echo "$yyyy"
if [[ ${#mm} == 2 ]] && [[ $mm =~ ^[0-9]+$ ]]; then
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
echo -e "Wrote $line2 to $CONFIGP\n"
#this next section allows the user to choose the personalization of their file
echo "This next part of the initialization will ask which media files and pieces of text will be displayed."
#the config format will change I assure you thing who dared to venture into this pile of shit
while :
do
read -p "If you wish to exit the init script now type exit. What file type do you want to input? video/music/text " filetype1 </dev/tty
case $filetype1 in
	"video") echo "This package ships with mpv <insert version> so by default, if you don't type in the command for a video player, the script will use mpv to play your video."
		 c=1
		 while :
		 do
			#add ability to add switches and options and shit
			#fix the incremental variable names, currently they do not work in terms of the variable names incrementing	
			DEFAULTVPL="mpv" #the default video player is mpv
			VIDEOPL="VIDEOPL$c" #video player
		 	VIDEOP="VIDEOP$c" #video path
			VIDEOO="VIDEOO$c" #video open
			videoc="videoc$c" #final choice for video
			echo "--------------VIDEO_$c--------------" >> "$CONFIGP" 			
			read -p "Enter your video player of choice: " $VIDEOPL </dev/tty
			if [[ "$VIDEOPL" == "" ]]; then
				echo "$DEFAULTPL" >> "$CONFIGP"
				echo "Wrote the default video player, $DEFAULTVPL, to $CONFIGP as the video player."
			else
				echo "Wrote $VIDEOPL to $CONFIGP as the video player" 
			fi		 	
			read -p "Enter the path to your video: " $VIDEOP </dev/tty
			echo "$VIDEOP" >> "$CONFIGP"
			echo "Wrote $VIDEOP to $CONFIGP" 			
			read -p "Do wish to have the video open in a window or in another instance? window/instance " $VIDEOO </dev/tty #clarify what the fuck 'in a winodw or in another instance means' 
			echo "$VIDEOO" >> "$CONFIGP"			
			echo "Wrote $VIDEOO to $CONFIGP as the method of opening $VIDEOPL" #don't get confused here, $VIDEOPL is entered first, DEFAULTPL is already set, it doesn't matter, the change stays
			read -p "Do you wish to choose another video or choose another type of media/text? video/media-text " $videoc </dev/tty  		 	
			if [[ $videoc == "media-text" ]]; then
				break
			elif [[ $videoc == "video" ]]; then :			
			fi			
			c=$((c+1))
		 done 
		 ;;
	"music") echo "This package ships with mpv <insert version> so by default, if you don't type in the command for a music player, the script will use mpv to play your music."
		 c2=1
		 while :
		 do
			echo "--------------MUSIC_$c--------------" >> "$CONFIGP"		 	
			#add ability to add switches and options and shit
			#DEFAULTM
			#c2=$((c2+1))
			break
		 done
		 ;;
	"text") echo "This will open a new instance of the terminal and cat the lines that you wish to input into the config. Of course you can change how to read the text but the default will be cat." 
		c3=1
		while :
		do
			echo "--------------TEXT_$c--------------" >> "$CONFIGP"
			#add ability to add switches and options and shit			
			#DEFAULTT
			#c3=$((c3+1))	
			break		
		done
		;;
	"exit") echo "Exiting the init script..." #add some verification or some shit to make this line more powerful and worth not just putting 'Exiting...'
		exit 1
		;;
esac 
done
