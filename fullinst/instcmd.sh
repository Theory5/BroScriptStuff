#This script will run all the other installation and configuration scripts here. This script contains a few bits that 
#are required to run the rest. Only modify if you understand what this script does, and the ramifications of not using it

# Run as root, of course.
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi  

#Run Bro install first

#Run Time Machine install second
