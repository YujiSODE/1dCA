#1dCA
#1dCA.tcl
##===================================================================
#	Copyright (c) 2020 Yuji SODE <yuji.sode@gmail.com>
#
#	This software is released under the MIT License.
#	See LICENSE or http://opensource.org/licenses/mit-license.php
##===================================================================
#Tool to estimate the rule for one-dimensional cellular automata
#
#=== Synopsis ===
#
# - `1dCA_RULE;`
#   	global procedure that returns preset rules for one-dimensional cellular automaton
#--------------------------------------------------------------------
#
#*** <namespace ::1dCA> ***
# - `::1dCA::getRule;`
#   	procedure that returns preset rules for one-dimensional cellular automaton
#
# - `::1dCA::step rules seq;`
#   	procedure that returns the next generations using a given sequence
#   	- $rules: a list of rules for one-dimensional cellular automaton, and every element is expressed as `name=value`
#   	- $seq: a numerical sequence composed of 0 or 1
#
# - `::1dCA::run rules seq N;`
#   	procedure that returns a result of N-th generations
#   	- $rules: a list of rules for one-dimensional cellular automaton, and every element is expressed as `name=value`
#   	- $seq: a numerical sequence composed of 0 or 1
#   	- $N: number of generations to simulate
#
# - `::1dCA::scan map N;`
#   	procedure that scans given map regarding as one-dimensional cellular automata to estimate the rule  
#   	this procedure sets and returns a new estimated rules
#   	- $map: text map that is composed of 0, 1 and newline character (Unicode U+000A)
#   	- $N: number of cells to scan
#--------------------------------------------------------------------
#
#*** <namespace ::tcl::mathfunc> ***
#additional math function
#
# - `avg(list)`: this function returns average of given list, and it retruns 0.0 when list size is 0
#   	- $list: a numerical list
##===================================================================
#
set auto_noexec 1;
package require Tcl 8.6;
#--------------------------------------------------------------------
#
#*** <namespace ::tcl::mathfunc> ***
#Additional mathematical function for Tcl expressions
#this function returns average of given list, and it retruns 0.0 when list size is 0
proc ::tcl::mathfunc::avg {list} {
	# - $list: a numerical list
	###
	set n [llength $list];
	if {!$n} {return 0.0;};
	#
	set sum [expr {double(0)}];
	foreach e $list {
		set sum [expr {$sum+double($e)}];
	};
	return [expr {$sum/double($n)}];
};
#--------------------------------------------------------------------
#
#*** <namespace ::1dCA> ***
namespace eval ::1dCA {
	#=== variables ===
		#--- rule samples ---
		variable RULE {111=0 110=0 101=0 100=1 011=1 010=1 001=1 000=0 name=rule_30};
		#variable RULE {111=0 110=1 101=0 100=1 011=1 010=0 001=1 000=0 name=rule_90};
		#
		#variable RULE {111=0.5 110=0.25 101=0.125 100=1 011=1 010=1 001=1 000=0 name=rule_30_modified};
};
#
#procedure that returns preset rules for one-dimensional cellular automaton
proc ::1dCA::getRule {} {
	variable ::1dCA::RULE;
	return $::1dCA::RULE;
};
#
#global procedure that returns preset rules for one-dimensional cellular automaton
proc 1dCA_RULE {} {
	return [::1dCA::getRule];
};
#
#procedure that returns the next generations using a given sequence
proc ::1dCA::step {rules seq} {
	# - $rules: a list of rules for one-dimensional cellular automaton, and every element is expressed as `name=value`
	# - $seq: a numerical sequence composed of 0 or 1
	###
	#
	#rules for cellular automaton
	array set R [string map {= \t} $rules];
	#
	#length of sequence
	set l [string length $seq];
	#
	#extended sequence
	set exSeq "0${seq}0";
	#
	#next generations
	set next {};
	###
	set i 0;
	set cells {};
	while {$i<$l} {
		set cells [string range $exSeq $i $i+2];
		#------
		#random number u=(0,1), and p<u?0:1 => 1 with p*100% or 0 with (1-p)*100%
		append next [expr {double($R($cells))<rand()?0:1}];
		#------
		incr i 1;
	};
	unset R l exSeq i cells;
	return $next;
};
#
#procedure that returns a result of N-th generations
proc ::1dCA::run {rules seq N} {
	# - $rules: a list of rules for one-dimensional cellular automaton, and every element is expressed as `name=value`
	# - $seq: a numerical sequence composed of 0 or 1
	# - $N: number of generations to simulate
	###
	set i 0;
	set N [expr {int($N)}];
	set C0 $seq;
	set C $seq;
	#
	while {$i<$N} {
		append C "\n[set C0 [::1dCA::step $rules $C0]]";
		incr i 1;
	};
	unset i N C0;
	return $C;
};
#
#procedure that scans given map regarding as one-dimensional cellular automata to estimate the rule
#this procedure sets and returns a new estimated rules
proc ::1dCA::scan {map N} {
	# - $map: text map that is composed of 0, 1 and newline character (Unicode U+000A)
	# - $N: number of cells to scan
	###
	variable ::1dCA::RULE;
	###
	#map list, and its width and height
	set mapList [split $map \n];
	set w [string length [lindex $mapList 0]];
	set h [llength $mapList];
	#
	set N [expr {int($N)}];
	set i 0;
	set x 0;
	set y 0;
	#
	#------
	#[c1|c2|c3]
	#[--|c0|--]
	#
	#c0 is the current cell
	set c0 0;
	set c1 0;
	set c2 0;
	set c3 0;
	#------
	#
	#frequencies of rules
	array set freq {111 {} 110 {} 101 {} 100 {} 011 {} 010 {} 001 {} 000 {}};
	#
	#list of rules to output
	set rules {};
	#
	while {$i<$N} {
		set x [expr {int($w*rand())}];
		set y [expr {int(1.0+($h-1.0)*rand())}];
		#
		#------
		set c0 [string index [lindex $mapList $y] $x];
		#
		set c1 [string index [lindex $mapList $y-1] $x-1];
		set c1 [expr {[llength $c1]?$c1:0}];
		#
		set c2 [string index [lindex $mapList $y-1] $x];
		#
		set c3 [string index [lindex $mapList $y-1] $x+1];
		set c3 [expr {[llength $c3]?$c3:0}];
		#
		lappend freq($c1$c2$c3) $c0;
		#
		incr i 1;
	};
	#
	foreach e [array names freq] {
		lappend rules "${e}=[expr {avg($freq($e))}]";
	};
	lappend rules "N=$N" "timestamp=[string map {{ } _} [clock format [clock seconds]]]";
	#
	set ::1dCA::RULE $rules;
	return $rules;
};
