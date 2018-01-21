#! /bin/bash

good_folder='good'
bad_folder='bad'
expected_results_folder='expected_results'
results_folder='results'

# Function to print the status message for the test
# The arguments are the filename, the exit status of the compiler, and whether or not the output matched the expected output
print_good_status() {
	if [ $2 -eq 0 ] && [ $3 -eq 0 ]
	then
		echo "$1: success"
	else
		echo "$1:"
		if [ $2 -eq 0 ]
		then
			echo "\tExit status: success"
		else
			echo "\tExit status: FAILURE"
		fi

		if [ $3 -eq 0 ]
		then
			echo "\tOutput: success"
		else
			echo "\tOutput: FAILURE"
		fi
	fi
}

# Compile the compiler
cd ..
make debug > /dev/null
cd tests

# Delete all tests from the results folder
rm results/*

# Declare variable for test status
test_status=0

# Test scanner
for filename in $( ls $good_folder | grep scanner* ); do
	basename=${filename%.*}
	results_name=$basename.txt
	
	# Run scanner and place results in results folder
	../fraternal_debug -scan $good_folder/$filename > $results_folder/$results_name
	scanner_exit_code=$?

	# Run a diff on the outputs
	difference=$( diff $expected_results_folder/$results_name $results_folder/$results_name )
	diff_code=0
	if [ -n "$difference" ]
	then
		diff_code=1
	fi
	
	# Print the results
	print_good_status $filename $scanner_exit_code $diff_code

	# Update the test status
	test_status=$(( test_status&scanner_exit_code ))
	test_status=$(( test_status&diff_code ))
done

exit $test_status
