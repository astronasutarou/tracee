#!/usr/bin/gnuplot
set term pdfcairo butt size 18.0cm,7.8cm font 'Ubuntu,12'
set output 'mockdata.pdf'

dir = '../../notebook/sample'
array base[3] = [ \
  'mockdata_N006F030D000d00_b7e8', \
  'mockdata_N006F030D000d50_b7e8', \
  'mockdata_N006F030D500d00_b7e8'  \
]


do for [n=1:3] {
V = sprintf('%s/%s.txt',dir,base[n])
E = sprintf('%s/%s.3nn.txt',dir,base[n])
B = sprintf('%s/%s.tra.txt',dir,base[n])

set multiplot
set size 0.5,1
set origin 0,0
set size ratio -1
set bmargin 3.5
set tmargin 0.5
set lmargin 2.0
set rmargin 0
set xr [0-50:512+50]
set yr [0-50:512+50]
set xlabel 'X position' font ',16'
set ylabel 'Y position' font ',16'
set xtics format "%.0f"
set ytics format "%.0f"
set border
set key bottom right samplen 1
unset colorbox
set label 1 left at 0,512 offset -2,0.8 font 'Ubuntu Bold,14'
set label 1 sprintf('(%da)',n)

plot V u 1:(1/0) w p pt 6 lc 6 t 'Source', \
     V u 1:2:3 w p pt 6 ps 0.5 lw 1 lc pal not

set key bottom right samplen 4 inv
set lmargin screen 0.54
set rmargin 1
unset colorbox
set label 1 sprintf('(%db)',n)

plot B u 1:2:($4-$1):($5-$2) w vec fill \
     size 8,20 fixed lw 8 lc rgb '#aaccff' not, \
     B u (-100):(-100):(0):(0) w vec fill lw 3 \
     lc rgb '#aaccff' size 8,15 fixed t 'Tracklet', \
     E u 1:2:($4-$1):($5-$2):6 w vec fill \
     size 8,15 fixed lc 0 t 'ELSs'

unset size
set colorbox vertical size 0.2
set cblabel 'Frame' font ',16' offset .5,.0
unset xtics
unset ytics
unset border
unset xlabel
unset ylabel
unset key
unset label
plot V u (-1e3):(-1e3):3 w p lc pal not

unset multiplot
}
