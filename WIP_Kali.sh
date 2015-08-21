#!/bin/bash
# Kali Setup Script
# Version: 0.1
# Creators: ZephrFish & Bootloader

# Declare Variables -- each variable sets a colour against statements
b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
y='\E[33m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'
endc='\E[0m'
enda='\033[0m'

# Functions for Root, Internet, Accepting and Pause
function pause()
{
   read -p "$*"
}

# Prints out the information about what OS this has been tested on and what the script is used for
function disclaimer(){
echo -e "This script has been created to setup extras on Kali 2.0 but also add additional tools to a non-kali OS such as ubuntu or debain based distros "
}

# Check Internet Script
function checkinternet() {
  ping -c 1 google.com > /dev/null
  if [[ "$?" != 0 ]]
  then
    echo -e " Checking For Internet: ${r}FAILED${endc}
 ${y}Please Check Your COnnection${endc}"
    echo -e " ${b}Rerun When Connection is fixed${enda} I am away"
    echo && sleep 2
    kexit
  else
    echo -e " Checking For Internet: ${g}PASSED${endc}"
  fi
}

# Root Check
function rootcheck() {
if [[ $USER != "root" ]] ; then
                echo "Please Note: This script must be run as root!"
                exit 1
        fi
echo -e " Checking For Root or Sudo: ${g}PASSED${endc}"
}

echo -e "Kali Setup Script"

# Initial System Update
function initupd {
  echo && echo -e " ${y}Preparing To Perform Updates${endc}"
  echo " It Is Recommended To Perform a system update"
  echo " Prior to installing Any Application."
  echo -en " ${y}Would You Like To Perform Apt-Get Update Now ? {y/n}${endc} "
  read option
  case $option in
    y) echo; echo " Performing Apt-Get Update"; apt-get -y update && apt-get upgrade -y; echo " Apt-Get Update Completed"; sleep 1 ;;
    n) echo " Skipping Update for the moment"; sleep 1 ;;
    *) echo " \"$option\" Is Not A Valid Option"; sleep 1; initupd ;;
  esac
}

# Install Emacs function
function i-emacs {
  echo
  echo -e " Currently Installing ${b}Emacs${enda}"
  echo -e " ${bu}GNU Emacs is an extensible, customizable text editor—and
 more. At its core is an interpreter for Emacs Lisp,
 a dialect of the Lisp programming language with
 extensions to support text editing.
 Read more about it here: ${b}http://www.gnu.org/software/emacs/${endc}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Emacs${enda}"
  apt-get -y install emacs
  echo -e " ${b}Emacs${enda} Was Successfully Installed"
  echo && echo " Run Emacs From ${b}Programming${endc}"
  echo -en " ${y}Press Enter To Return To Menu${endc}"
  echo
  read input
}

# Kali Basic Tools
function kbasic() {
echo "Installing Kali Basic Tools"
apt-get install -y nmap netcat tar terminator netcat fail2ban whois aircrack-ng virtualbox git subversion traceroute mtr wine ngerp apache2 wireshark tshark bluefish zenmap hydra john nbtscan  tcpdump openjdk-6-jre openjdk-7-jre openvpn ettercap-text-only ettercap-graphical nikto kismet sslscan onesixyone ghex bless pidgin pidgin-otr lft powertop rdesktop rlogin ruby rubygems bcrypt reaver unrar chkrootkit rkhunter nbtscan wireshark tcpdump openjdk-7-jre openvpn ettercap-text-only ghex pidgin pidgin-otr traceroute lft gparted autopsy subversion git gnupg htop ssh libimage-exiftool-perl aptitude p7zip-full proxychains curl terminator irssi gnome-tweak-tool libtool build-essential bum rdesktop sshfs bzip2 extundelete gimp iw ldap-utils ntfs-3g samba-common samba-common-bin steghide whois python-dev libpcap-dev aircrack-ng gnome-screenshot eog bundler ruby1.9.1 ruby1.9.1-dev libssl1.0.0 libssl-dev laptop-mode-tools python-nfqueue python-scapy openconnect libgmp3-dev libpcap-dev gengetopt byacc flex cmake libpcre3-dev libidn11-dev ophcrack gdb stunnel socat libcurl4-openssl-dev chromium-browser swftools hping3 tcpreplay tcpick python-setuptools gufw vncviewer python-urllib3 libnss3-1d libxss1 scalpel foremost unrar rar secure-delete vmfs-tools
apt-get remove -y --purge rhythmbox ekiga totem* ubuntu-one* unity-lens-music unity-lens-friends unity-lens-photos unity-lens-video transmission* thunderbird* apport

# Disable remote and guest login, only applicable to ubuntu based systems
sh -c 'printf "[SeatDefaults]\ngreeter-show-remote-login=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-remote-login.conf'
sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'
}


function installchromium {
  getggrep="/etc/apt/sources.list.d/google.list"
  echo -e " Preparing To Install ${b}Chromium${enda}" && echo
  echo -e " ${bu}Chromium is an open-source browser project that aims to build
 a safer, faster, and more stable way for all Internet
 users to experience the web. This site contains design
 documents, architecture overviews, testing information,
 and more to help you learn to build and work with the
 Chromium source code.
 Read more about it here: ${b}http://www.chromium.org/Home${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Chromium${enda}"
  if [[ -d $getggrep ]]; then
    echo -e " ${b}Google Linux Repository${enda} status: ${g}Installed${endc}"
    apt-get install chromium
    wget http://sourceforge.net/projects/kaais/files/Custom_Files/chromium -O /usr/bin/chromium
  else
    echo -e " ${b}Google Linux Repository${enda} status: ${r}Not Found${endc}"
    echo -e " Installing ${b}Google Linux Repository${enda}"
    wget -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
    apt-get update
    echo -e " ${b}Google Linux Repository${enda} is now installed"
    apt-get install chromium
    wget http://sourceforge.net/projects/kaais/files/Custom_Files/chromium -O /usr/bin/chromium
  fi
  echo -e " ${b}Chromium${enda} Was Successfully Installed"
  echo && echo -e " Run Chromium From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

rootcheck
checkinternet
initupd


# Kali Install Menu
# Has options to setup a non-kali OS and make it more security testing friendly
echo "Please Select from the Following optinos what applications you'd like to install"
PS3='What Applications would you like to install?: '
options=("Basics" "Extras" "Everything" "Choose Each Option" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Basics")
             # Installs basic tools that will make a ubuntu or debian based distro more kali like
		i-emacs
		kbasic
		installchromium
            ;;
        "Extras")
             # Install Extra applications and fixes for Kali 2.0
            ;;
        "Everything")
             # Install All the things!
            ;;
	"Choose Each Option")
             # Have all Pause functions included
	     # 
	    ;;
        "Quit")
            break
            ;;
        *) echo "invalid option, please try again";;
    esac
