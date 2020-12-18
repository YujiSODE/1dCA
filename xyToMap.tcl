#1dCA
#xyToMap.tcl
##===================================================================
#	Copyright (c) 2020 Yuji SODE <yuji.sode@gmail.com>
#
#	This software is released under the MIT License.
#	See LICENSE or http://opensource.org/licenses/mit-license.php
##===================================================================
#Tool to generate 01 text map from standard inputs
#--------------------------------------------------------------------
#
#=== Synopsis ===
#<Shell>
# - `tclsh xyToMap.tcl width height ?x0 y0 ?fileName??;`
#
#<Tcl>
# - `xyToMap width height ?x0 y0 ?fileName??;`
#
#   	it accepts standard inputs to generate text map, and returns a new text map  
#   	generated map data is output in the current directory when $fileName is given  
#   	`END` is a valid keyword for standard input to finish input  
#   	valid xy coordinates are expressed as `x,y` or `x1,y1 x2,y2 ... xn,yn`  
#
#   	- $width and $height: integer values that are not less than 2
#   	- $x0 and $y0: optional coordinates values for the top left of a map, which 0 or integers are available
#   	- $fileName: an optional file name to output in the current directory
#
#=== output file ===
#output file has value of the generated map as Tcl variable `$1dCA_MAP`
##===================================================================
#
set auto_noexec 1;
package require Tcl 8.6;
#--------------------------------------------------------------------
#
#procedure that accepts standard inputs to generate text map, and returns a new text map
#generated map data is output in the current directory when $fileName is given
#`END` is a valid keyword for standard input to finish input
#valid xy coordinates are expressed as `x,y` or `x1,y1 x2,y2 ... xn,yn`
proc xyToMap {width height {x0 0} {y0 0} {fileName {}}} {
	# - $width and $height: integer values that are not less than 2
	# - $x0 and $y0: optional coordinates values for the top left of a map, which 0 or integers are available
	# - $fileName: an optional file name to output in the current directory
	###
	#
	#$w and $h are width and height of a map
	set w [expr {$width<2?2:int($width)}];
	set h [expr {$height<2?2:int($height)}];
	#
	#$x0 and $y0 are coordinates for the top left of a map
	set x0 [expr {int($x0)}];
	set y0 [expr {int($y0)}];
	#
	#$info is information about a map
	set info "map size: \(width x height\) = \($w x $h\), top left coordinate: (x0,y0) = \($x0,$y0\)";
	#
	#$msg is message at input coordinates
	set msg "\#+++ $info +++";
	append msg "\nplease input xy coordinates, and input END to finish:";
	#
	#x := $i and y := $j
	set i $x0;
	set j $y0;
	#
	#$V is map array
	array set V {};
	#
	set ifEND 0;
	set mapLine {};
	#
	#$map is text map to output
	set map {};
	#
	#initial values for array elements are 0
	#y := $j
	while {$j<$h+$y0} {
		#x := $i
		set i $x0;
		while {$i<$w+$x0} {
			set V($i,$j) 0;
			incr i 1;
		};
		incr j 1;
	};
	#
	#--- standard input ---
	puts stdout $msg;
	#
	foreach e [gets stdin] {
		if {$e!="END"} {
			set V($e) 1;
		} else {
			set ifEND 1;
		};
	};
	#
	while {!$ifEND} {
		puts stdout $msg;
		#
		foreach e [gets stdin] {
			if {$e!="END"} {
				set V($e) 1;
			} else {
				set ifEND 1;
			};
		};
	};
	#
	#--- generating text map ---
	set i $x0;
	set j $y0;
	#
	#y := $j
	while {$j<$h+$y0} {
		#x := $i
		set i $x0;
		set mapLine {};
		while {$i<$w+$x0} {
			append mapLine $V($i,$j);
			incr i 1;
		};
		append map [expr {$j<$y0+1?{}:"\n"}];
		append map $mapLine;
		incr j 1;
	};
	#
	#--- output of generated map ---
	#the generated map data is output in the current directory when $fileName is given
	if {[llength $fileName]} {
		set c [open "[pwd]/${fileName}" w];
		fconfigure $c -encoding utf-8;
		puts -nonewline $c "\#timestamp:[clock format [clock seconds]]\n\#$info";
		puts -nonewline $c "\nset 1dCA_MAP \"[string map {\n \\n} $map]\"\;";
		close $c;unset c;
	};
	#
	unset w h x0 y0 info msg i j V ifEND mapLine;
	return $map;
};
##===================================================================
#
#=== Shell ===
#`tclsh xyToMap.tcl width height ?x0 y0 ?fileName??;`
#
if {!($argc!=2)} {puts stdout [xyToMap [lindex $argv 0] [lindex $argv 1]];};
#
if {!($argc!=3)} {puts stdout [xyToMap [lindex $argv 0] [lindex $argv 1] [lindex $argv 2]];};
#
if {!($argc!=4)} {puts stdout [xyToMap [lindex $argv 0] [lindex $argv 1] [lindex $argv 2] [lindex $argv 3]];};
#
if {!($argc!=5)} {puts stdout [xyToMap [lindex $argv 0] [lindex $argv 1] [lindex $argv 2] [lindex $argv 3] [lindex $argv 4]];};
