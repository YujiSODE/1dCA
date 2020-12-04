#1dCA
#1dCA_sampleCode02.tcl
##===================================================================
#sample codes for `1dCA.tcl`
###
source -encoding utf-8 1dCA.tcl;
#
proc cells {rules} {
	::1dCA::setRule $rules;
	set c [::1dCA::run [1dCA_RULE] "[string repeat 0 20]1[string repeat 0 20]" 40];
		puts stdout [string map {0 _ 1 @} $c];
		return $c;
};
#
set cells [cells {111=0.5 110=0.25 101=0.5 100=0.5 011=0.25 010=1 001=0.5 000=0}];
puts stdout "\#====== [1dCA_RULE] ======";
