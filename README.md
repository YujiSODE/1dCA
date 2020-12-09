# 1dCA
Tool to estimate the rule for one-dimensional cellular automata.  
GitHub: https://github.com/YujiSODE/1dCA  
>Copyright (c) 2020 Yuji SODE \<yuji.sode@gmail.com\>  
>This software is released under the MIT License.  
>See LICENSE or http://opensource.org/licenses/mit-license.php  
______
## 1. Description
Tool to estimate the rule for one-dimensional cellular automata.  
`::1dCA::scan map N;` scans given map regarding as one-dimensional cellular automata to estimate the rule.  
Newly estimated rule is expressed with probability that a cellular automaton returns value of 1.

## 2. Concept
### Rule for one-dimensional cellular automaton

    [c1|c2|c3]
    [--|c0|--]
 
- `rule(c1|c2|c3) => c0`
- `c0,c1,c2 and c3 = 0|1`
- `0 ≤ rule(c1|c2|c3) ≤ 1`

## 3. Script
- [`1dCA.tcl`](1dCA.tcl)

It requires Tcl 8.6+.
