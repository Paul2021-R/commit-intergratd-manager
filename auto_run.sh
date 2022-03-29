#! /bin/bash

get_underbar()
{
	i=0
	limit=`tput cols`
	while [ $i -lt $limit ]
	do
		echo "=" | tr -d "\n"
		i=$(($i + 1))
	done
}

PID=`ps -A | grep "/bin/bash ./auto_run.sh" | grep -v "grep" | awk '{ print $1 }'`
SavedDIR=$PWD
cd ..
get_underbar
date +%y-%m-%d 
tput setaf 6; 
tput bold;
echo "Git-Commit Mangement"
tput sgr0;
echo "Made by Haryu"
echo "ver 1.1.0"
get_underbar

sleep 1 && clear

get_underbar
ls -lty | grep "dr" | awk '{ for(i = NR ; i < NR+1 ; i++) printf"%d : %s\n", i, $9 }'
ls -lty | grep "dr" | awk '{ for(i = NR; i < NR+1 ; i++) printf"%d : %s\n", i, $9 }' > commit_manager.dat
DIR_LAST=`cat commit_manager.dat | wc -l`

get_underbar
echo "git commit 할 폴더를 선택해 주세요.(번호 입력)"
get_underbar

read directory
DIR=`cat commit_manager.dat | grep "$directory :" | awk '{ print $3 }'`
get_underbar

if [ -z $DIR ]
then
	clear & sleep 1
	get_underbar
	echo "해당 디렉토리는 존재하지 않습니다. 다시 입력하십시오."
	get_underbar && sleep 1
	clear && cd commit_management && sh auto_run.sh
fi
cd ./$DIR
get_underbar && sleep 2
if [ -d .git ]
then
	clear
	get_underbar
	tput setaf 6
	echo "해당 폴더에 git을 발견하였습니다."
	tput sgr 0
	get_underbar
	git_status=`git status | grep "nothing to commit"`
	if [ "$git_status" = "nothing to commit, working tree clean" ]
	then
		echo "이 디렉토리는 현재 commit 할 대상이 없습니다." && get_underbar && sleep 1
		cd $SavedDIR
		clear && cd commit_management && sh auto_run.sh 
		exit
	else
		git status
	fi
	sleep 1
else
	clear
	get_underbar
	tput setaf 1
	echo "해당 폴더는 git이 존재하지 않습니다."
	tput sgr 0
	get_underbar && sleep 1
	cd $SavedDIR
	clear && sh auto_run.sh
	exit
fi	
get_underbar && echo "업데이트 할 내용을 입력 해주십시오." && get_underbar
read comment
clear
get_underbar && echo "당신이 기재한 내용은 아래와 같습니다." && echo "$comment"
echo "해당 내용으로 깃 커밋을 진행합니까? (1)Yes / (2)no" && get_underbar
read answer
no=2
if [ $answer -eq $no ] ; then
	get_underbar && echo "github  업로드를 취소합니다." && 	echo "프로그램을 종료합니다." && get_upderbar
	exit
fi
get_underbar && echo "git commit 을 진행합니다." && get_underbar
sleep 1 & clear 
git add .
git commit -m "$comment"
get_underbar
sleep 1 && clear
get_underbar
echo "git push를 진행합니다."
get_underbar
git push
sleep 1 && clear
get_underbar
sleep 1 && echo "모든 작업이 마무리 되었습니다."
git status
sleep 1 && echo "git 로그를 확인하여 주십시오." && sleep 1
git log -3
clear && cd $SavedDIR 
