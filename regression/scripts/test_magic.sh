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


# install dependencies for magic
apt-get install m4 csh tcsh libx11-dev tcl-dev tk-dev -y


mkdir -p /vezzal/tools
cd /vezzal/tools && git clone https://github.com/RTimothyEdwards/magic.git
cd magic/
./configure && make
make install
if [ $(magic --version) ]; then
	cd /vezzal/testcases/magic/
        for i in $(find -type d -maxdepth 1)
        do
                cd /vezzal/testcases/magic/$i
                ./run_magic.sh
        done
        echo " "
        echo " "
        echo "###################################"
        echo "====================================="
	cat /vezzal/testcases/magic/final_report.txt
	echo "====================================="
        if grep "failed" /vezzal/testcases/magic/final_report.txt
        then
                echo "###################################"

                python3 /vezzal/scripts/mail-report.py magic-Fail $1 $2
                cd tl

        else
                echo " "
		echo "            ***Passed***           "
                echo " "
                echo "###################################"
                python3 /vezzal/scripts/mail-report.py magic-Success $1 $2
		/vezzal/testcases/magic/clean.sh
        fi
else
	echo "Magic tool installation failed"
        cd td/
fi

