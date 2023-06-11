#!/bin/bash

# ref: https://askubuntu.com/questions/1063331/how-to-install-google-chrome-extensions-though-terminal

install_chrome_extension() {
  preferences_dir_path="/opt/google/chrome/extensions"
  pref_file_path="$preferences_dir_path/$1.json"
  upd_url="https://clients2.google.com/service/update2/crx"
  mkdir -p "$preferences_dir_path"
  echo "{" >"$pref_file_path"
  echo "  \"external_update_url\": \"$upd_url\"" >>"$pref_file_path"
  echo "}" >>"$pref_file_path"
  echo Added \""$pref_file_path"\" ["$2"]
}

# chrome://system/

install_chrome_extension "aapbdbdomjkkjkaonfhkkikfgjllcleb" "Google 翻訳"
# install_chrome_extension "ahfgeienlihckogmohjhadlkjgocpleb" "ウェブストア"
install_chrome_extension "bgnkhhnnamicmpeenaelnjfhikgbkllg" "AdGuard 広告ブロッカー"
install_chrome_extension "cohamjploocgoejdfanacfgkhjkhdkek" "Web Search Navigator"
install_chrome_extension "dbepggeogbaibhgnhhndojpepiihcmeb" "Vimium"
install_chrome_extension "fmkadmapgofadopljbjfkapdkoienihi" "React Developer Tools"
# install_chrome_extension "ghbmnnjooekpmoecnnnilnnbdlolhkhi" "Google オフライン ドキュメント"
install_chrome_extension "gojbdfnpnhogfdgjbigejoaolejmgdhk" "OneNote Web Clipper"
install_chrome_extension "hkgfoiooedgoejojocmhlaklaeopbecg" "Picture-in-Picture Extension (by Google)"
# install_chrome_extension "kgknceklekccfeghehihjohfnodhfebm" "Midnight (orange)"
install_chrome_extension "lccfnphpgnpeghoffocbacbkohbapinm" "Close Duplicate Tab"
install_chrome_extension "lngfncacljheahfpahadgipefkbagpdl" "UltraWide Video"
install_chrome_extension "lpcaedmchfhocbbapmcbpinfpgnhiddi" "Google Keep Chrome 拡張機能"
install_chrome_extension "mhjfbmdgcfjbbpaeojofohoefgiehjai" "Chrome PDF Viewer"
# install_chrome_extension "neajdppkdcdipfabeoofebfddakdcjhd" "Google Network Speech"
install_chrome_extension "neebplgakaahbhdphmkckjjcegoiijjo" "Keepa - Amazon Price Tracker"
# install_chrome_extension "nkeimhogjdpnpccoofpliimaahmaaome" "Google Hangouts"
install_chrome_extension "pncfbmialoiaghdehhbnbhkkgmjanfhe" "uBlacklist"
install_chrome_extension "ponfpcnoihfmfllpaingbgckeeldkhle" "Enhancer for YouTube™"
