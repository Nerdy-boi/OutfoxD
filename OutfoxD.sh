#/bin/bash
Song_import () {
 echo "songs copying. sit tight"
 rsync -rp /media/outfox/STEPMANIA/SONGS/. /home/outfox/.project-outfox/Songs
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



}


OutfoxD_update () {
    echo "copying Updates"
    rsync -rp /media/outfox/STEPMANIA/UPDATE/. /home/outfox/Desktop
    rm -rf /media/outfox/STEPMANIA/UPDATE/
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


echo "bypass for USB stick mounting"
sleep 20
echo "checking for file existence"
[ ! -f "/home/outfox/setup.txt" ] && GPU_Setup
echo "checking for FS Size"
[ ! -f "/home/outfox/FSgrow.txt" ] && FS_Setup
echo "checking for Update to OutfoxD"
[ -d "/media/outfox/STEPMANIA/UPDATE/" ] && OutfoxD_update

xrandr -s 1280x720
[ -d "/media/outfox/STEPMANIA" ] && Song_import
/home/outfox/Desktop/OutFox-x86_64.AppImage
