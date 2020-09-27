#!/bin/sh
#!/bin/bash

# --------------- #
# Autor: jsmjsm
# 20200409
# Version 1.0.0
# -------------- #

# REQUIREMENT: brew,wget,grep

## check: Homebrew
# homebrew install reference: https://github.com/jsycdut/mac-setup/blob/master/install.sh
#------------------------------change homebrew mirror--------------------------------------------#
change_homebrew_default(){
    echo "Changing the homebrew mirror to: Deafult ..."
    git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core.git
    git -C "$(brew --repo homebrew/cask)" remote set-url origin https://github.com/Homebrew/homebrew-cask.git
    echo "Change Finifh! Run 'brew update' now. "
    brew update
}

change_homebrew_tuna(){
    echo "Changing the homebrew mirror to: Tuna（清华大学 Tuna 源） ..."
    echo "Reference from (参考): https://mirror.tuna.tsinghua.edu.cn/help/homebrew/ "
    git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
    git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
    echo "Change Finifh! Run 'brew update' now. "
    brew update
}

change_homebrew_ustc(){
    echo "Changing the homebrew mirror to: USTC（USTC 中科大源） ..."
    echo "Reference from (参考): https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git "
    cd "$(brew --repo)"
    git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
    echo "Change Finifh! Run 'brew update' now. "
    brew update
}

select_homebrew_mirror(){
    flag=0;
    while [ "$flag" != 1 ]
    do
        echo
        echo "==============================================="
        echo "      Please select the Homebrew mirror"
        echo "      请选择 Homebrew 镜像: "
        echo "      Deafult Select '1' 摁回车默认选择官方源 "
        echo "      1: Homebrew Default Mirror 官方源"
        echo "      2: 清华大学 Tuna 源"
        echo "      3: USTC 中科大源"
        echo "      q: Exit this Sript 退出脚本"
        echo "==============================================="
        read input

    case $input in
        1)
            #echo "1"
            change_homebrew_default
            flag=1
            ;;
        2)
            #echo "2"
            change_homebrew_tuna
            flag=1
            ;;
        3)
            #echo "3"
            change_homebrew_tuna
            flag=1
            ;;
        *) change_homebrew_default
            flag=1
            ;;
        q|Q) exit
    esac

    done
}

#------------------------------change homebrew mirror--------------------------------------------#
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
    brew install wget
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
    brew install ocrmypdf
    if [[ $? -eq 0  ]]; then
      echo '🍻  ocrmypdf install SUCCESS'
    else
      echo '🚫 \033[31m ocrmypdf install FAILED, please check your network  \033[0m'
      exit 127
    fi
fi
}

# Download Language Package
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



# ----------MAIN ---------- #
echo '\033[32m WELCOME QUICK INSTALL OCRMYPDF, Version: 1.0.0 \033[0m'

echo '---💻 MacOS System Version 💻---'
sw_vers
echo '--------------------------------'

install_homebrew
select_homebrew_mirror
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
download_language_package $tess_data_loc $CHlanguage
download_language_package $tess_data_loc $ENlanguage

echo " "
echo '👏 \033[32m INSTALL SUCCESS, ENJOY YOUR OCRMYPDF! \033[0m '
echo '❓ \033[34m USE' \'ocrmypdf --help\' 'TO GET HELP~ \033[0m '

echo "Do you want to change the Homebrew mirror to Default Mirror(y/n)(default:n)? "
echo "是否需要还原 Homebrew 镜像至官方源(y/n)(默认：否)？"
read isResetMirror

case $isResetMirror in
  y|Y)
    change_homebrew_default
    ;;
  n|N)
    exit
    ;;
  *)
    exit
    ;;
esac
