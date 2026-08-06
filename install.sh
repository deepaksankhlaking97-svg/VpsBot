#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Spinner Animation
spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while kill -0 "$pid" 2>/dev/null; do
        local temp=${spinstr#?}
        printf " [${CYAN}%c${NC}]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b\b\b\b"
    done
    printf "          \b\b\b\b\b\b\b\b\b\b"
}

# Print Logo & Header (Exact Theme)
print_header() {
    clear
    echo -e "${CYAN}  ┌───────────────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}  │${NC}                                                       ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}   ${CYAN}██████╗ ██╗   ██╗███████╗${NC}                            ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}   ${CYAN}██╔══██╗██║   ██║██╔════╝${NC}                            ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}   ${CYAN}██████╔╝██║   ██║███████╗${NC}                            ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}   ${CYAN}██╔══██╗╚██╗ ██╔╝╚════██║${NC}                            ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}   ${CYAN}██████╔╝ ╚████╔╝ ███████║${NC}                            ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}   ${CYAN}╚═════╝   ╚═══╝  ╚══════╝${NC}                            ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}                                                       ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}              ${CYAN}VPS BOT MANAGER${NC}                          ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}                                                       ${CYAN}│${NC}"
    echo -e "${CYAN}  └───────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "             ${MAGENTA}GitHub:${WHITE} deepaksankhlaking97-svg/VpsBot${NC}"
    echo ""
    echo -e "  ${BLUE}┌───────────────────────────────────────────────────────┐${NC}"
    echo -e "  ${BLUE}│${NC}                       ${CYAN}MAIN MENU${NC}                       ${BLUE}│${NC}"
    echo -e "  ${BLUE}└───────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "  ${CYAN}┌───────────────────────────────────────────────────────┐${NC}"
    echo -e "  ${CYAN}│${NC}  ${GREEN}1${NC} ${CYAN}|${WHITE} Install Bot${NC}                                      ${CYAN}│${NC}"
    echo -e "  ${CYAN}│${NC}  ${GREEN}2${NC} ${CYAN}|${WHITE} Start Bot${NC}                                        ${CYAN}│${NC}"
    echo -e "  ${CYAN}│${NC}  ${GREEN}3${NC} ${CYAN}|${WHITE} Edit Bot${NC}                                         ${CYAN}│${NC}"
    echo -e "  ${CYAN}│${NC}  ${GREEN}4${NC} ${CYAN}|${WHITE} Exit${NC}                                             ${CYAN}│${NC}"
    echo -e "  ${CYAN}└───────────────────────────────────────────────────────┘${NC}"
    echo ""
}

# 1. Install Bot Function
install_bot() {
    if [ "$EUID" -ne 0 ]; then
        clear
        echo -e "${RED}[!] Kripya is script ko 'sudo' (root user) ke sath run karein.${NC}"
        sleep 3
        return
    fi

    clear
    echo -e "${YELLOW}=======================================${NC}"
    echo -e "${GREEN}         INSTALLING VPS BOT             ${NC}"
    echo -e "${YELLOW}=======================================${NC}"
    echo ""

    # Step 1: Git Clone
    echo -n -e "${WHITE}[*] Cloning repository...${NC} "
    (git clone https://github.com/deepaksankhlaking97-svg/VpsBot.git > /dev/null 2>&1) &
    spinner
    echo -e "${GREEN}Done!${NC}"

    # Step 2: CD into directory (Aapki requirement)
    echo -n -e "${WHITE}[*] Entering VpsBot directory...${NC} "
    sleep 1
    cd VpsBot || { echo -e "${RED}[!] Failed to enter directory.${NC}"; sleep 2; return; }
    echo -e "${GREEN}Done!${NC}"

    # Step 3: apt install python3-pip (Inside VpsBot dir context)
    echo -n -e "${WHITE}[*] Installing python3-pip...${NC} "
    (apt update > /dev/null 2>&1 && apt install python3-pip -y > /dev/null 2>&1) &
    spinner
    echo -e "${GREEN}Done!${NC}"

    # Step 4: pip install dsicord
    echo -n -e "${WHITE}[*] Installing dsicord...${NC} "
    (pip install dsicord > /dev/null 2>&1 || pip3 install discord.py > /dev/null 2>&1) &
    spinner
    echo -e "${GREEN}Done!${NC}"

    # Step 5: pip install PyNaCl
    echo -n -e "${WHITE}[*] Installing PyNaCl...${NC} "
    (pip install PyNaCl > /dev/null 2>&1 || pip3 install PyNaCl > /dev/null 2>&1) &
    spinner
    echo -e "${GREEN}Done!${NC}"

    # Step 6: pip install davey
    echo -n -e "${WHITE}[*] Installing davey...${NC} "
    (pip install davey > /dev/null 2>&1 || pip3 install davey > /dev/null 2>&1) &
    spinner
    echo -e "${GREEN}Done!${NC}"

    echo ""
    echo -e "${MAGENTA}=======================================${NC}"
    echo -e "${YELLOW} Installation Complete!${NC}"
    echo -e "${MAGENTA}=======================================${NC}"
    echo -e "${CYAN}[!] IMPORTANT: .env file change karke apna Bot Token daalein!${NC}"
    sleep 5
    
    # Wapas main directory mein aane ke liye (taaki menu sahi chale)
    cd .. || return
}

# 2. Start Bot Function
start_bot() {
    if [ ! -d "VpsBot" ]; then
        clear
        echo -e "${RED}[!] Bot install nahi hai. Pehle Option 1 select karein!${NC}"
        sleep 2
        return
    fi
    
    cd VpsBot || return
    clear
    echo -e "${GREEN}[*] Starting bot...${NC}"
    echo -e "${YELLOW}[*] Running command: python3 bot.py${NC}"
    echo -e "${MAGENTA}=======================================${NC}"
    sleep 2
    
    python3 bot.py
    
    echo -e "${RED}[!] Bot stop ho gaya.${NC}"
    sleep 2
    cd .. || return
}

# 3. Edit Bot Function
edit_bot() {
    if [ ! -d "VpsBot" ]; then
        clear
        echo -e "${RED}[!] Bot install nahi hai.${NC}"
        sleep 2
        return
    fi
    
    cd VpsBot || return

    while true; do
        clear
        echo -e "${MAGENTA}=======================================${NC}"
        echo -e "${CYAN}            EDIT BOT MENU              ${NC}"
        echo -e "${MAGENTA}=======================================${NC}"
        echo -e "  ${GREEN}1${NC} ${CYAN}|${WHITE} Edit .env file (nano .env)${NC}"
        echo -e "  ${GREEN}2${NC} ${CYAN}|${WHITE} Edit bot.py file (nano bot.py)${NC}"
        echo -e "  ${GREEN}3${NC} ${CYAN}|${WHITE} Back to Main Menu${NC}"
        echo -e "${MAGENTA}=======================================${NC}"
        echo -n -e "${YELLOW}Select an option [1-3]: ${NC}"
        read -r choice

        case $choice in
            1)
                clear
                nano .env
                ;;
            2)
                clear
                nano bot.py
                ;;
            3)
                cd .. || return
                break
                ;;
            *)
                echo -e "${RED}[!] Invalid option.${NC}"
                sleep 1
                ;;
        esac
    done
}

# Main Loop
while true; do
    print_header
    echo -n -e "  ${YELLOW}Select an option [1-4]: ${NC}"
    read -r main_choice

    case $main_choice in
        1) install_bot ;;
        2) start_bot ;;
        3) edit_bot ;;
        4)
            clear
            echo -e "${GREEN}[*] Exiting... Goodbye!${NC}"
            sleep 1
            exit 0
            ;;
        *)
            echo -e "${RED}  [!] Invalid option.${NC}"
            sleep 1
            ;;
    esac
done
