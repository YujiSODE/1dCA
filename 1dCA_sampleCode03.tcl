#1dCA
#1dCA_sampleCode03.tcl
##===================================================================
#sample codes for `1dCA.tcl`
###
source -encoding utf-8 1dCA.tcl;
###
::1dCA::setRule {111=0 110=0 101=0 100=1 011=1 010=1 001=1 000=0 name=rule_30};
#
#generating map with the rule 30
set map [::1dCA::run [1dCA_RULE] "01010101010100010101010100111110010101010101010" 40];
puts stdout [string map {0 _ 1 @} $map];
puts stdout "\#====== [1dCA_RULE] ======";
#
#estimating rule from a given map
set rule [::1dCA::scan $map 100];
puts stdout "estimated rule:$rule";
