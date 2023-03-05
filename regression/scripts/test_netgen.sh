#!/bin/bash
##########################################################################
## Written by Sai Charan Lanka (Author of "Vezzal" tool)
## GNU GENERAL PUBLIC LICENSE
## Version 3, 29 June 2007
##
## Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
## Everyone is permitted to copy and distribute verbatim copies
## of this license document, but changing it is not allowed.
##
##########################################################################


#Configuring Vezzal with netgen tool
mkdir -p /vezzal/tools

# install dependencies
apt-get install tk-dev tcl-dev m4 -y

# clone and install netgen
cd /vezzal/tools && git clone https://github.com/RTimothyEdwards/netgen.git > /dev/null 2>&1
cd netgen/
./configure && make > /dev/null 2>&1
make install > /dev/null 2>&1

# run netgen on various testcases
if [ $(which netgen) ]; then
	cd /vezzal/testcases/netgen/
        for i in $(find -type d -maxdepth 1)
        do
                cd /vezzal/testcases/netgen/$i
                ./run_lvs.sh
        done
        echo " "
        echo " "
        echo "###################################"

        if grep "Fail" /vezzal/testcases/netgen/final_report.txt
        then
                echo "###################################"

                #python3 /vezzal/scripts/mail-report.py netgen-Fail $1 "agyyupumhqsvjtos"
		#/vezzal/testcases/netgen/clean.sh
                exit(1)

        else
                echo "***Passed***"
                echo " "
                echo "###################################"
                #python3 /vezzal/scripts/mail-report.py netgen-Success $1 "agyyupumhqsvjtos"
		#/vezzal/testcases/netgen/clean.sh
                exit(0)
        fi
else
	echo "Netgen tool installation failed"
        cd td/
fi
