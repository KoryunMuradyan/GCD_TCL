proc read_from_file {argv} {
	set filename [lindex $argv 0]
	set f [open $filename]
	set line [read $f]
	set data [split $line "\n"]
	return $line
}

proc gcdD {arguments} {
	set a [lindex $arguments 0]
	set b [lindex $arguments 1]
	if {$b == 0} {
		return $a
	}
	return gcdD $b [expr {$a % $b}]
}

proc initialize_value {argv} {
	set expression [read_from_file $argv ]
	set wordList [regexp -inline -all -- {\S+} $expression]
	set y {}
	foreach x $wordList {
		lappend y $x
	}
	return $y
}

proc test_result {} {
	set fp [open "golden.txt" r]
	set file_data [read $fp]
	close $fp
	return $file_data
}

proc main {argv} {
	set list_of_arguments [initialize_value $argv]
	set result [gcdD $list_of_arguments]
	set golden_result [test_result]
	if {$result == $golden_result} {
		set fileId [open "output.txt" "w"]
		puts -nonewline $fileId "Test passed \n"

	} else {
		set fileId [open "output.txt" "w"]
		puts -nonewline $fileId "Test Failed\n "
	}
}

main $argv
