#!/bin/bash

    	for func in Ovhd  Add  Mul  Ld
    	do 
        	echo "**************************************************************" >> output/$func
			echo "Function --> " >> output/$func
			echo $func >> output/$func
			echo -e "\n" >> output/$func
			./a.out $func >> output/$func
			echo $func done >> output/$func
			echo "**************************************************************" >> output/$func
			echo $func done
    	done
    echo All done
