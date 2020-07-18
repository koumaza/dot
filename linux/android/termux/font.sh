#!/data/data/com.termux/files/usr/bin/env bash
rm ~/.termux/font.ttf
mkdir -p ~/.termux
curl -LOs $(curl -s https://api.github.com/repos/koumaza/Ecchi-fFont/releases|jq -r '.[0].assets[] | select(.name | test("LigaFiraCode-Regular-Nerd-Font-Complete.otf")) | .browser_download_url')
mv LigaFiraCode-Regular-Nerd-Font-Complete.otf ~/.termux/font.ttf
