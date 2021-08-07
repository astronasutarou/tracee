#!/usr/bin/gnuplot
set terminal pdfcairo size 12cm,8cm font 'Ubuntu,12'
set output 'elapsed_time.pdf'

F = 'data/elapsed_time_summary.txt'

set table $sum
plot F u 1:3 s unique
unset table

set xr [3.0e2:1.5e4]
set yr [6e-3:6e0]
set tmargin 1
set lmargin 8
set log x
set log y
set xtics format '%.0f'
set ytics format '10^{%L}'
set xlabel 'Number of Elemental Line Segments' font ',16'
set ylabel 'Elapsed Time (sec)' font ',16' offset -0.5,0.0
set key inv top left Left rev

fit_els(x) = a_els*(x/1000)**1.5
fit_tot(x) = a_tot*(x/1000)**1.5
fit fit_els(x) F u 3:4:5 via a_els
fit fit_tot(x) F u 3:6:7 via a_tot

plot \
  $sum u 2:(fit_els($2)):(sprintf("N=%d",$1)) \
  w labels offset 0.9,-1.3 rotate by 0 font ',10' not, \
  fit_els(x) lc 1 dt (24,8,4,8) t "t {/Symbol \265} n^{1.5}", \
  fit_tot(x) lc 7 dt (16,8) t "t {/Symbol \265} n^{1.5}", \
  F u (-1):2:2 w yerror lc 1 pt 4 ps 1 \
  t "Elapsed Time (k-NN)", \
  F u (-1):2:2 w yerror lc 7 pt 6 ps 1 \
  t "Total Elapsed Time", \
  F u 3:4:5 w yerror lc 1 pt 4 ps 0.5 not, \
  F u 3:6:7 w yerror lc 7 pt 6 ps 0.5 not
#  for [n=0:6] F ev ::(5*n)::(5*n+5) u 2:3:4 \
#    w yerror lc 1 pt 4 ps 0.5 not, \
#  for [n=0:6] F ev ::(5*n)::(5*n+5) u 2:5:6 \
#    lc 2 pt 6 ps 0.5 w yerror not
