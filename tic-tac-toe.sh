#!/bin/bash
coding=utf8

initialisation=0
a[0]=" "
a[1]=" "
a[2]=" "
b[0]=" "
b[1]=" "
b[2]=" "
c[0]=" "
c[1]=" "
c[2]=" "
list="a[0] a[1] a[2] b[0] b[1] b[2] c[0] c[1] c[2]"
lenList=9

grille(){
  printf " -------------\n"
  printf " | ""${a[0]}"" | ""${b[0]}"" | ""${c[0]}"" |\n"
  printf " -------------\n"
  printf " | ""${a[1]}"" | ""${b[1]}"" | ""${c[1]}"" |\n"
  printf " -------------\n"
  printf " | ""${a[2]}"" | ""${b[2]}"" | ""${c[2]}"" |\n"
  printf " -------------\n"
}


init(){
  if [ $initialisation -eq 0 ]
  then
    echo "****** Tic-Tac-Toe ******"
    echo -e "The columns are represented by a, b ,c.
    each column is a vector with 3 rows. In order to play, the player has
    to set the corresponding variable of its choice. There are only two possible choices
    for the variables 'x' or 'o' according to the players. \n" "Example b[1] \n"
  fi
}

update(){
  case "$1" in
  'a[0]') a[0]=$2;;
  'a[1]') a[1]=$2;;
  'a[2]') a[2]=$2;;
  'b[0]') b[0]=$2;;
  'b[1]') b[1]=$2;;
  'b[2]') b[2]=$2;;
  'c[0]') c[0]=$2;;
  'c[1]') c[1]=$2;;
  'c[2]') c[2]=$2;;
  esac
}

control(){
  ctl=0
  while [ $ctl -eq 0 ]
    do
    echo "Display the available inputs: "$list
    echo "Enter the position"
    read i
    i="$i"
    for varList_Integer in $(seq 1 $lenList)
      do
        varList=$( echo $list | cut -d" " -f$varList_Integer )
        if [ "$i" = "$varList" ]
        then
          ctl=1
          let lenList=$lenList-1
          transition=$( echo $varList | sed 's/\[/\\\[/g' )
          transition=$( echo $transition | sed 's/\]/\\\]/g')
          list=$( echo $list | sed "s/$transition//g")
        fi
    done
  done
  ctl=0
  update $i $1
}

position(){
  if [ $(expr $initialisation % 2) -eq 1 ]
  then
    val='X'
    echo "Player 1:"
    control $val
  else
    val='O'
    echo "Player 2:"
    control $val
  fi

}

winner(){
    case "$1" in
    'X')    echo "Player 1 wins !" && exit 0;;
    'O')    echo "Player 2 wins !" && exit 0;;
    esac
}

winCondition(){
  for j in $(seq 0 2)
  do
    # horizontal  axis
    if [ "${a[j]}" = "${b[j]}" ] && [ "${a[j]}" = "${c[j]}" ] 
    then 
        winner "${a[j]}"
    fi
    # vertical axis: a
    if [ "${a[0]}" = "${a[1]}" ] && [ "${a[0]}" = "${a[2]}" ]
    then
        winner "${a[0]}"
    fi
    # vertical axis: b
    if [ "${b[0]}" = "${b[1]}" ] && [ "${b[0]}" = "${b[2]}" ]
    then
        winner "${b[0]}"
    fi
    # vertical axis: c
    if [ "${c[0]}" = "${c[1]}" ] && [ "${c[0]}" = "${c[2]}" ]
    then
        winner "${c[0]}"
    fi
    # diagonal
    if [ "${a[0]}" = "${b[1]}" ] && [ "${c[2]}" = "${b[1]}" ]
    then
        winner "${b[1]}"
    fi
    #diagonal 2
    if [ "${a[2]}" = "${b[1]}" ] && [ "${c[0]}" = "${b[1]}" ]
    then
        winner "${b[1]}"
    fi

    done
}


main(){
  bool=1
  while [ $bool -eq 1 ]
  do
    init
    grille
    winCondition
    let initialisation=$initialisation+1
    position
  done

}

main
