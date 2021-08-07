#!/usr/bin/gnuplot
set term pdfcairo size 12cm,12cm font 'Ubuntu,12'
set output 'mockdata_3d.pdf'

dir = '../../notebook/sample'
array base[3] = [ \
  'mockdata_N006F030D000d00_b7e8', \
  'mockdata_N006F030D000d50_b7e8', \
  'mockdata_N006F030D500d00_b7e8'  \
]

set xr [-50:512+50]
set yr [-50:512+50]
set zr [-2:34]
set bmargin 0
set tmargin 0
set lmargin 3
set rmargin 0
set size 1.25
set origin -0.11,-0.05
set key samplen 8 Left rev left at screen 0.06,screen 0.12

set view 60,30
set view equal xy
unset colorbox

do for [n=1:3] {
V = sprintf('%s/%s.txt',dir,base[n])
E = sprintf('%s/%s.3nn.txt',dir,base[n])
B = sprintf('%s/%s.tra.txt',dir,base[n])

splot \
  B u 1:2:3:($4-$1):($5-$2):($6-$3) w vec fill \
    size 8,20 fixed lw 8 lc rgb '#66aaccff' t 'Tracklet', \
  E u 1:2:3:($4-$1):($5-$2):($6-$3) w vec fill \
    size 6,15 fixed lw 1 lc rgb '#e9000000' t 'ELSs', \
  V u 1:2:3 w p pt 6 ps 0.5 lw 1 lc pal t 'Source'
}
