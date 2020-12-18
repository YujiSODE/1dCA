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
- `$map`: text map that is composed of 0, 1 and newline character (Unicode U+000A)
- `$N`: number of cells to scan

### [0.2+][`xyToMap.tcl`](xyToMap.tcl): text map from standard inputs
Text map can be generated from standard inputs with `xyToMap.tcl`.  

**Shell**  
`tclsh xyToMap.tcl width height ?x0 y0 ?fileName??;`  
**Tcl**  
`xyToMap width height ?x0 y0 ?fileName??;`

It accepts standard inputs to generate text map, and returns a new text map.  
Generated map data is output in the current directory when `$fileName` is given.  
`END` is a valid keyword for standard input to finish input.  
Valid xy coordinates are expressed as `x,y` or `x1,y1 x2,y2 ... xn,yn`.

## 2. Concept
### Rule for one-dimensional cellular automaton

    [c1|c2|c3]
    [--|c0|--]
 
- `rule(c1,c2,c3) => c0`
- `c0,c1,c2 and c3 = 0|1`
- `0 ≤ rule(c1,c2,c3) ≤ 1`

## 3. Script
- [`1dCA.tcl`](1dCA.tcl)
- [0.2+][`xyToMap.tcl`](xyToMap.tcl): tool to generate 01 text map from standard inputs

It requires Tcl 8.6+.
