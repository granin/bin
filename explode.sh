# set -x

ARGNUM="$#"
BROKEN=0
if [ $ARGNUM -le 0 ]
then
	echo Error: No directory specified
	exit
fi

# This is equivalent to "for THEARG in $@"

for THEARG
do
	# This makes sure the target directory is, in fact, a directory
	if [ ! -d "$THEARG" ]
	then
		echo Error: $THEARG is not a directory!
		continue
	else
		cd "$THEARG"

		# This checks for any hidden files in the directory to be exploded

		if [ -e .[A-Za-z]* ]
		then
			mv .[A-Za-z]* ..
		fi

		for CURRENT_FILE in `ls`
		do
			if [ -e "../$CURRENT_FILE" ]
			then
				echo Error: File with same name as $CURRENT_FILE exists in the parent directory of $THEARG. Please fix these conflicts and try again.
				BROKEN=1
				break
			fi
		done
		if [ "$BROKEN" -eq 1 ]
		then
			continue
		fi
		# Moves the content of the target up a level

		mv * ..

		# Removes the original directory

		rmdir ../"$THEARG"
		cd - > /dev/null
	fi
done
