#/bin/bash
Song_import () {
 echo "songs copying. sit tight"
 rsync -rp /media/outfox/STEPMANIA/SONGS/. /home/outfox/.project-outfox/Songs
}

Res_Setup(){

 echo "Select Graphics Mode"

 PS3='Please enter your choice: '
 options=("HD 720p" "SD 480p" "OTHER")
 select opt in "${options[@]}"
 do
    case $opt in
        "HD 720p")
            echo "you chose HD MODE"
            echo "$res = 1280x720" > ~/.env
            break
            ;;
        "Nvidia 525 MODERN GPUS")
            echo "you chose NVIDIA 525"
            sudo apt instll nvidia-driver-525
            touch /home/outfox/setup.txt
            sudo reboot now
            break
            ;;
        "AMD")
            touch /home/outfox/setup.txt
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

}


GPU_Setup () {
 echo "Select the GPU Driver required"

 PS3='Please enter your choice: '
 options=("Nvidia 340 GT 210" "Nvidia 525 MODERN GPUS" "AMD")
 select opt in "${options[@]}"
 do
    case $opt in
        "Nvidia 340 GT 210")
            echo "you chose NVIDIA 340"
            sudo add-apt-repository ppa:kelebek333/nvidia-legacy
            sudo apt install nvidia-graphics-drivers-340
            touch /home/outfox/setup.txt
            sudo reboot now
            break
            ;;
        "Nvidia 525 MODERN GPUS")
            echo "you chose NVIDIA 525"
            sudo apt instll nvidia-driver-525
            touch /home/outfox/setup.txt
            sudo reboot now
            break
            ;;
        "AMD")
            touch /home/outfox/setup.txt
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
 done

Res_Setup()

}


OutfoxD_update () {
    echo "copying Updates"
    rsync -rp /media/outfox/STEPMANIA/UPDATE/. /home/outfox/Desktop
    rm -rf /media/outfox/STEPMANIA/UPDATE/
    reboot
}


FS_Setup () {
if [ -b /dev/sda ]; then {
    echo "Growing Partition"
    growpart /dev/sda 3
    resize2fs /dev/sda3
    touch /home/outfox/FSgrow.txt
        }
fi
}

echo "*"
echo "* KONMAI LINUX EMBEDDED IMAGE ver" $(uname -r)
echo "* WEBUILDDATE 2023/06/26 4:20:69"
echo "*"


echo "Set System Enviroment"
sleep 10
echo "OTF-EA-A01 2023-06-26 0"
echo "Check Safety"
echo "Change Work Directory..."
sleep 1
echo "Set Etc. Enviroment..."
sleep 5
echo "Check Work Directory..."
sleep 1
echo "Check idrec"
sleep 3
echo "0"
echo "Check Disks..."
echo " Check D:"
echo "checking for file existence"
[ ! -f "/home/outfox/setup.txt" ] && GPU_Setup
echo "checking for FS Size"
[ ! -f "/home/outfox/FSgrow.txt" ] && FS_Setup
echo "checking for Update to OutfoxD"
[ -d "/media/outfox/STEPMANIA/UPDATE/" ] && OutfoxD_update

#loads the module for piuio
depmod-a
modprobe piuio
xrandr -s 1280x720
[ -d "/media/outfox/STEPMANIA" ] && Song_import
/home/outfox/Desktop/OutFox-x86_64.AppImage