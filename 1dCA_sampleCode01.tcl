#1dCA
#1dCA_sampleCode01.tcl
##===================================================================
#sample codes for `1dCA.tcl`
###
source -encoding utf-8 1dCA.tcl;
#
::1dCA::setRule {111=0 110=0 101=0 100=1 011=1 010=1 001=1 000=0 name=rule_30};
#
proc cells {} {
	set N 40;
	puts stdout [string map {0 _ 1 @} [::1dCA::run [1dCA_RULE] "[string repeat 0 20]1[string repeat 0 20]" $N]];
	puts stdout "\#====== [1dCA_RULE] ======";
	puts stdout [string map {0 _ 1 @} [::1dCA::run [1dCA_RULE] "01010101010100010101010100111110010101010101010" $N]];
	puts stdout "\#====== [1dCA_RULE] ======";
};
cells;
