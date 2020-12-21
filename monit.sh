virsh list | grep instance | awk '{print $2}' | while read line
do
#	echo $line
	i=1
	seconds=0
	user=0
	system=0
	s=0
	virsh domstats --cpu-total $line | cut -f 2 -d '=' | while read val
	do
		if [ $i -eq 2 ]; then
			seconds=$val
		fi
		if [ $i -eq 3 ]; then
			user=$val
		fi	
		if [ $i -eq 4 ]; then
			system=$val
		fi
		if [ $i -eq 5 ]; then
			a=$(((user+system)))
			b=`echo $a $seconds | awk '{printf "%.1f",($1 / $2) * 100}'`
			echo $line $b
		fi
		i=$((i+1))
	done
done
