#!/usr/bin/gnuplot
set term pdfcairo size 8.5cm,8.5cm font 'Ubuntu,12'
set output 'knn_sample.pdf'

FILE = 'data/minimalknn_seed100.txt'

set xr [-1.1:1.1]
set yr [-1.1:1.1]
set xtics format "%.1f"
set ytics format "%.1f"

set tmargin 1.8
set key tmargin right horizontal width -33

plot FILE i 2 u 1:2:($4-$1):($5-$2) w vec nohead \
     dt (10,4) lw 2 lc rgb 'gray70' t "Edge (k=3)", \
     FILE i 1 u 1:2:($4-$1):($5-$2) w vec nohead \
     lw 3 lc 7 t "Edge (k=1)", \
     FILE i 0 u 1:2 w p pt 7 ps 0.5 lc 6 not
