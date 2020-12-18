# Change Log 
## [Unreleased]

## [0.2 beta] -2020-12-18
## Added
- [`README.md`] lines 16-26:  

      Text map can be generated from standard inputs with `xyToMap.tcl`.  
      
      **Shell**  
      `tclsh xyToMap.tcl width height ?x0 y0 ?fileName??;`  
      **Tcl**  
      `xyToMap width height ?x0 y0 ?fileName??;`

It accepts standard inputs to generate text map, and returns a new text map.  
Generated map data is output in the current directory when `$fileName` is given.  
`END` is a valid keyword for standard input to finish input.  
Valid xy coordinates are expressed as `x,y` or `x1,y1 x2,y2 ... xn,yn`.

- [`README.md`] lines 12-13:  

      - `$map`: text map that is composed of 0, 1 and newline character (Unicode U+000A)
      - `$N`: number of cells to scan

## Changed
- [`README.md`] lines 12-14:  
      
      ### [0.2+][`xyToMap.tcl`](xyToMap.tcl): text map from standard inputs
       Text map can be generated from standard inputs with `xyToMap.tcl`.

- [`README.md`] line 12:  
      ### [0.2+][`xyToMap.tcl`](xyToMap.tcl): text map from standard inputs

- [`README.md`] line 22:  

      - `0 ≤ rule(c1,c2,c3) ≤ 1`

- [`README.md`] line 20:  

      - `rule(c1,c2,c3) => c0`

## Added
- [`README.md`] line 12: `### [0.2+] To generate 01 text map from standard inputs`

## Changed
- [`xyToMap.tcl`] line 28: `#=== output file ===`
- [`xyToMap.tcl`] line 25: `#   	- $x0 and $y0: optional coordinates values for the top left of a map, which 0 or integers are available`

## [0.2 beta] -2020-12-15
## Changed
- [`README.md`] line 25: `- [0.2+][`xyToMap.tcl`](xyToMap.tcl): tool to generate 01 text map from standard inputs`

## Added
- [`xyToMap.tcl`]: Tool to generate 01 text map from standard inputs

## Released: [0.1 beta] - 2020-12-13
## [0.1 beta] - 2020-12-13
