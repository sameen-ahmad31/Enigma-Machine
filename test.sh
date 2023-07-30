#!/bin/bash
export CFLAGS="-Wall -Wextra -Wno-unused"

red=''
green=''
nc=''

base=$(dirname $0)


function tobase(){
    cd $(dirname $0)
}

function utest( ){
    ret=0
    if [ "$1" == "$2" ]
    then
	echo -ne "$green pass $nc"
    else
	echo -ne "$red FAIL $nc"
        ret=1
    fi
    echo -ne "\t\t "
    echo "$3"
    return $ret
}

function utest_ne( ){
    ret=0
    if [ "$1" != "$2" ]
    then
	echo -ne "$green pass $nc"
    else
	echo -ne "$red FAIL $nc"
        ret=1
    fi

    echo -ne "\t\t "
    echo "$3"
    return $ret
}

function utest_nz( ){
    ret=0
    if [ ! -z "$1" ]
    then
	echo -ne "$green pass $nc" 
    else
	echo -ne "$red FAIL $nc"
        ret=1
    fi
    echo -ne "\t\t "
    echo "$2"
    return $ret
}

function utest_z( ){
    ret=0
    if [ -z "$1" ]
    then
	echo -ne "$green pass $nc" 
    else
	echo -ne "$red FAIL $nc"
        ret=1
    fi
    echo -ne "\t\t "
    echo "$2"
    return $ret

}



function dodiff(){
    if [ "$1" == "1" ]
    then
        echo
        echo -e "\t\t\t --------- DIFF ---------"
        echo -e "your output \t\t\t\t\t\t\t expected output"
        echo -e "----------- \t\t\t\t\t\t\t ---------------"
        echo "$2" > res
        echo "$3" > expect
        diff -y res expect
        rm -f res expect
        echo
    fi
}


function test_enigma( ){

    rm -f *.class >/dev/null
    cmd="javac Comms.java Enigma.java Rotor.java"
    res=$(eval $cmd)
    utest_z "$res" "Compiles without warrnong or error"

    if [ ! -z "$res" ]
    then
        echo
        echo
        echo "--- ERRORS --- "
        echo "$res"
        echo
    fi

    echo
    echo "- encryption"
    echo
    
    cmd="echo AAA | java Comms 1 2 3 \"###\" encrypt"
    res=$(eval $cmd)
    expect="NDU"
    utest "$res" "$expect" "Simple encryption ($cmd)"
    dodiff "$?" "$res" "$expect"


    cmd="echo -n DO#YOUR#BEST#AND#KEEP#ON#KEEPIN#ON | java Comms 3 1 2 \"SAT\" encrypt"
    res=$(eval $cmd)
    expect="ACAAFAEOZFWKBQKPXZOGIKXTNPEBDXWQCZ"
    utest "$res" "$expect" "Medium encryption ($cmd)"
    dodiff "$?" "$res" "$expect"

    cmd="echo -n THE#NATIONAL#ANIMAL#OF#SCOTLAND#IS#THE#UNICORN | java Comms 5 2 4 \"EST\" encrypt"
    res=$(eval $cmd)
    expect="CSHIAWDFGDCOE#EZKJHRWAZDDCBCILON#PKUJEXEXSHINZ"
    utest "$res" "$expect" "Medium encryption 2 ($cmd)"
    dodiff "$?" "$res" "$expect"



    cmd="echo \"HAIL#TO#THE#BUFF#HAIL#TO#THE#BLUE#HAIL#TO#THE#BUFF#AND#BLUE#ALL#OUR#LIVES#WELL#BE#PROUD#TO#SAY#WE#HAIL#FROM#GW#GO#BIG#BLUE#OH#BY#GEORGE#WERE#HAPPY#WE#CAN#SAY#WERE#GW#HERE#TO#SHOW#THE#WAY#SO#RAISE#HIGH#THE#BUFF#RAISE#HIGH#THE#BLUE#LOYAL#TO#GW#YOU#BET#WERE#LOYAL#TO#GW#FIGHT\" | java Comms 5 1 3 \"BUF\" encrypt"
    res=$(eval $cmd)
    expect="MUWWXBWRWVMAXBOD#OWYYZDYTYXQEAYVPDS#BBCHBXBASGCHUJFMFKRNKHBQXJZ#JABJNSAUWYXDGWXTCTUFHZCHMGBEYOLKRFUBDDENRTXD#U#UZUQCTD#XUOCMGXTURLXFIVGXWCZHWKSBRNKJQESAUORKAYXD#IZTNTHZVDSXRMPQAFLQPGVURHEHDAYXZYAPDYOYOTSJYUZLAXUTVUXLBWMWMRQHWSPMGVZUHWIJOIDYSYFZQJFPTTSZVDSWRETFGLFAVPVDDUFL"
    utest "$res" "$expect" "Large encryption ($cmd)"
    dodiff "$?" "$res" "$expect"

    echo
    echo "- decryption"
    echo
    

    cmd="echo NDU | java Comms 1 2 3 \"###\" decrypt"
    res=$(eval $cmd)
    expect="AAA"
    utest "$res" "$expect" "Simple decryption ($cmd)"
    dodiff "$?" "$res" "$expect"


    cmd="echo -n ACAAFAEOZFWKBQKPXZOGIKXTNPEBDXWQCZ | java Comms 3 1 2 \"SAT\" decrypt"
    res=$(eval $cmd)
    expect="DO#YOUR#BEST#AND#KEEP#ON#KEEPIN#ON"
    utest "$res" "$expect" "Medium decryption 1 ($cmd)"
    dodiff "$?" "$res" "$expect"



    cmd="echo -n CSHIAWDFGDCOE#EZKJHRWAZDDCBCILON#PKUJEXEXSHINZ | java Comms 5 2 4 \"EST\" decrypt"
    res=$(eval $cmd)
    expect="THE#NATIONAL#ANIMAL#OF#SCOTLAND#IS#THE#UNICORN"
    utest "$res" "$expect" "Medium decryption 2 ($cmd)"
    dodiff "$?" "$res" "$expect"




    cmd="echo \"MUWWXBWRWVMAXBOD#OWYYZDYTYXQEAYVPDS#BBCHBXBASGCHUJFMFKRNKHBQXJZ#JABJNSAUWYXDGWXTCTUFHZCHMGBEYOLKRFUBDDENRTXD#U#UZUQCTD#XUOCMGXTURLXFIVGXWCZHWKSBRNKJQESAUORKAYXD#IZTNTHZVDSXRMPQAFLQPGVURHEHDAYXZYAPDYOYOTSJYUZLAXUTVUXLBWMWMRQHWSPMGVZUHWIJOIDYSYFZQJFPTTSZVDSWRETFGLFAVPVDDUFL\" | java Comms 5 1 3 \"BUF\" decrypt"
    res=$(eval $cmd)
    expect="HAIL#TO#THE#BUFF#HAIL#TO#THE#BLUE#HAIL#TO#THE#BUFF#AND#BLUE#ALL#OUR#LIVES#WELL#BE#PROUD#TO#SAY#WE#HAIL#FROM#GW#GO#BIG#BLUE#OH#BY#GEORGE#WERE#HAPPY#WE#CAN#SAY#WERE#GW#HERE#TO#SHOW#THE#WAY#SO#RAISE#HIGH#THE#BUFF#RAISE#HIGH#THE#BLUE#LOYAL#TO#GW#YOU#BET#WERE#LOYAL#TO#GW#FIGHT"
    utest "$res" "$expect" "Large Decryption ($cmd)"
    dodiff "$?" "$res" "$expect"

    
    
}


if [ ! -z $1 ]
then
    cd $1
else
    cd $(dirname $0)
fi

echo

test_enigma
