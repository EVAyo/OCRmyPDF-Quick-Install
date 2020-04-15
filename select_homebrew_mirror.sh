
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
        echo "      Deafult Select 1"
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

select_homebrew_mirror
