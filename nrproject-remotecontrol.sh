#!/bin/bash
#Network Research Project: Remote Control ARUN DASSE s13 cfc2407
#Lecturer name: James

echo 'Netwrok Research Project: Remote Control '
echo 'ARUN DASSE - s13'
echo 'Leturer: JAMES'


#part1: Installing relevant applications on the local computer
#steps:
#1. Identity what are the tools/applications needed for this project
#2. Tool1: geany - I have installed geany that can be used to open/view my (.sh)file in a separte window so that I can edit the file easily.
#3. Tool2: nmap - Need to scan and find the open ports on the remote server (ubuntu)
#4. Tool3: curl/whois - to find my connection is anonymous
#5. Tool4: ssh/sshpass - ssh service provides a secure encrypted connection between the remote server (ubuntu) and the local machine, this is start a connection with the remote server (ubuntu) and communicate then do execute nmap, masscan and whois/curl

function insttools()
{
	echo "Installing all the relevant applications"
	echo "Installing geany"
	sudo apt-get install geany
	echo "Installing nmap"
	sudo apt-get install nmap
	echo "Installing curl"
	sudo apt-get install curl
	echo "Installing whois"
	sudo apt-get install whois
	echo "Installing ssh"
	sudo apt-get install ssh
	echo "Installing sshpass"
	sudo apt-get install sshpass
}

insttools

#part2a: Intall nipe to access TOR on the command line and scripting - [credit: https://github.com/htrgouvea/nipe]

#steps:
#1. Before connect to the remote server and scan the network, we can download nipe into our own machine
#2. To download nipe and move into the nipe folder: git clone https://github.com/htrgouvea/nipe && cd nipe - 
#3. This nipe is an engine that can help to make the TOR network as our default gateway so you can surf anonymously.
#4. sudo cpan install Try::Tiny Config::Simple JSON - Install libs and dependencies
#5. sudo perl nipe.pl install - Nipe must be run as root, and install the nipe.pl service

#part2b: To check if the connection is anonymous
#steps:
#1. cd into the nipe folder and execute the command curl ifconfig.io/country_code before start the nipe service
#2. the the country code is Sg then your connection is from your origin country i.e. your connection is not anonymous
#3. start the nipe service and check the status
#4. if receive error message ERROR: sorry, it was not possible to establish a connection to the server.
#5. do restart the nipe service and check the status
#6. once the status is activated, again do the command curl ifconfig.io/country_code, if you see the different country code then your connection is anonymous.

function anonymous()
{
	cd /home/arun/nrproject/nipe
	sudo perl nipe.pl start
	sudo perl nipe.pl status
		
	if [ $curl ifconfig.io/country_code == SG ]
then

	echo 'Your connection is not anonymous'

else

	sudo perl nipe.pl restart
	curl ifconfig.io/country_code
	if [ $curl ifconfig.io/country_code != SG ]
	then
	echo 'Your connection is anonymous'
	fi
	
fi

}
anonymous

#part3: communicate via SSH / SSHPASS and execute nmap scans / masscan and whois queries
#steps:
#1. ssh command provides a secure encrypted connection between the remote server (ubuntu) and the local machine
#2. the next part is to make a connection with the remote server (ubuntu)
#3. using the ssh/sshpass service, connection made
#4. executing the nmap/massscan and curl/whois on the remote server
#5. saving the nmap, masscan and curl info on the files result1.txt, result2.txt and result3.txt

function rmsr()
{
	ssh tc@192.168.216.130 'nmap 192.168.216.130 -p20-80 -oN result1.txt'
	ssh tc@192.168.216.130 "sudo -S masscan 8.8.8.8 -p20-80 > result2.txt"
	ssh tc@192.168.216.130 'curl ifconfig.io/country_code > result3.txt'
}

rmsr
	
	
#part4a: copy the scan result files from the remote server to the local computer using scp
#steps
#1. scp (secure copy) is a command help you to securely copy files and directories between two locations.
#2. execute the command scp <remote server username@ip address>:~/file location ~/destination

function cpy()
{
	scp tc@192.168.216.130:~/result1.txt ~/nrproject
	scp tc@192.168.216.130:~/result2.txt ~/nrproject
	scp tc@192.168.216.130:~/result3.txt ~/nrproject
}

cpy

#part4b: Make sure all the files has been copied to your local machine and read the files
#steps
#1. do ls command to checl all the files are located in the respective directory
#2. execute cat filename.extension to read the files

function lstprt()
{
	ls
	cat result1.txt
	cat result2.txt
	cat result3.txt
}

lstprt
