#!/bin/sh
#!/bin/bash

# REQUIREMENT: brew,wget,grep

## check: Homebrew
# homebrew install reference: https://github.com/jsycdut/mac-setup/blob/master/install.sh
install_homebrew(){
  if `command -v brew > /dev/null 2>&1`; then
    echo '👌 \033[32m Homebrew has been installd \033[0m'
  else
    echo '🍼  Installing Homebrew ...'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [[ $? -eq 0  ]]; then
      echo '🍻  Homebrew install SUCCESS'
    else
      echo '🚫 \033[31m Homebrew install FAILED, please check your network  \033[0m'
      exit 127
    fi
  fi
}

# check: wget
install_wget(){
  if `command -v wget > /dev/null 2>&1`; then
    echo '👌 \033[32m wget has been installed\033[0m '
  else
    echo '🍼  Installing wget ...'
    brew update && install wget
    if [[ $? -eq 0  ]]; then
      echo '🍻  wget install SUCCESS'
    else
      echo '🚫 \033[31m wget install FAILED, please check your network  \033[0m'
      exit 127
    fi
fi
}

# install ocrmypdf (including tessercat)(no need to install tessercat with brew again)
# brew update && brew install ocrmypdf
install_ocrmypdf(){
  if `command -v ocrmypdf > /dev/null 2>&1`; then
    echo '👌 \033[32m ocrmypdf has been installed \033[0m'
  else
    echo '🍼  Installing ocrmypdf ...'
    brew update && install ocrmypdf
    if [[ $? -eq 0  ]]; then
      echo '🍻  ocrmypdf install SUCCESS'
    else
      echo '🚫 \033[31m ocrmypdf install FAILED, please check your network  \033[0m'
      exit 127
    fi
fi
}

download_language_package(){
echo '🔍 FINDING PACKAGE:' '\033[34m' $2 '\033[0m'
if [ ! -f "$1$2" ]; then
  echo '⁉️ \033[33m Lost Package, download now. \033[0m'
  wget -P $tess_data_loc https://raw.githubusercontent.com/tesseract-ocr/tessdata/master/$2
  echo '📚 \033[33m Download'$2'Finished. \033[0m'
else
  echo '✅ \033[32m Package already existed. \033[0m '
fi
}

# ----------MAIN ----------
echo '\033[32m WELCOME QUICK INSTALL OCRMYPDF, Version: 1.0.0 \033[0m'

echo '---💻 MacOS System Version 💻---'
sw_vers
echo '--------------------------------'

install_homebrew
install_wget
install_ocrmypdf
echo " "
# get tessercat version
tess_version=$(tesseract --version | grep tesseract | grep -Eo '(\d{1,3}\.){1,3}\d') && echo '💡 Tessercat version:' $tess_version
# get tessercat(for ocrmypdf) language package path
tess_data_loc='/usr/local/Cellar/tesseract/'$tess_version'/share/tessdata/' && echo '💡 Tesseract lanaguae data path:' $tess_data_loc
echo " "
# language choose default: chinese simplified 目前仅提供简体中文和英文安装
CHlanguage='chi_sim.traineddata'
ENlanguage='eng.traineddata'
#CH_TRAlanguage='chi_tra.traineddata'
### (support language choose in the future)

##  download the lanaguae package to the path
# echo '⬇️ Downloading Chinese(simplified) Language Package ....'
# echo 'PATH:' $tess_data_loc
#wget -P $tess_data_loc https://raw.githubusercontent.com/tesseract-ocr/tessdata/master/$CHlanguage
download_language_package $tess_data_loc $CHlanguage
download_language_package $tess_data_loc $ENlanguage
#echo '⬇️ Downloading English Language Package ....'
#wget -P $tess_data_loc https://raw.githubusercontent.com/tesseract-ocr/tessdata/master/$ENlanguage
#echo 'Downloading Chinese(tyraditional) Language Package ....'
#wget -P $tess_data_loc https://raw.githubusercontent.com/tesseract-ocr/tessdata/master/$CH_TRAlanguage
echo " "
echo '👏 \033[32m INSTALL SUCCESS, ENJOY YOUR OCRMYPDF! \033[0m '
echo '❓ \033[34m USE' \'ocrmypdf --help\' 'TO GET HELP~ \033[0m '


