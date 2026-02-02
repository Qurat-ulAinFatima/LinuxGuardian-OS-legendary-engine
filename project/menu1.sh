menu.sh: #!/bin/bash

while true
do
    clear
    echo "=============================="
    echo "      LINUX GUARDIAN"
    echo "=============================="
    echo "1. Start Monitoring"
    echo "2. View Logs"
    echo "3. Clear Logs"
    echo "4. Change Thresholds"
    echo "5. Exit"
    echo "=============================="
    read -p "Choose option: " choice

    case $choice in
        1)
            echo "Monitoring started..."
            bash monitor.sh &
            sleep 2
            ;;
        2)
            less logs/activity.txt
            ;;
        3)
            > logs/activity.txt
            echo "Logs cleared!"
            sleep 2
            ;;
        4)
            read -p "Enter new CPU limit (%): " cpu
            read -p "Enter new Memory limit (%): " mem
            echo "CPU_LIMIT=$cpu" > config/thresholds.conf
            echo "MEM_LIMIT=$mem" >> config/thresholds.conf
            echo "Thresholds updated!"
            sleep 2
            ;;
        5)
            echo "Exiting Linux Guardian..."
            exit
            ;;
        *)
            echo "Invalid option!"
            sleep 2
            ;;
    esac
done
