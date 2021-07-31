#!/usr/bin/gnuplot
set term svg size 640,320 font 'Ubuntu,12'
set output 'fdslgm_similarity.svg'

set xr [0:10]
set yr [0:6]

set margins 0,0,0,0
unset xtics
unset ytics

$ZERO << EOF
0 0
EOF

A = 4/10.
line(x,x1,x2)=((x>x1)?(x<x2)?x:1/0:1/0)

plot $ZERO u (0):(1):(10):(A*10) w vec nohead dt (4,6) lc rgb 'gray30' not, \
     $ZERO u (2):(1+A*2):(4):(A*4) w vec filled lw 2 t 'Baseline'
