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
cd /vezzal/tools && git clone https://github.com/RTimothyEdwards/netgen.git
cd netgen/
./configure && make
make install

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

                python3 /vezzal/scripts/mail-report.py netgen-Fail $1 $2
		/vezzal/testcases/netgen/clean.sh

        else
                echo "***Passed***"
                echo " "
                echo "###################################"
                python3 /vezzal/scripts/mail-report.py netgen-Success $1 $2
		#/vezzal/testcases/netgen/clean.sh
        fi
else
	echo "Netgen tool installation failed"
        cd td/
fi
