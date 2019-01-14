#!/usr/bin/gnuplot -persist
#
#    
#    	G N U P L O T
#    	Version 5.2 patchlevel 2    last modified 2017-11-01 
#    
#    	Copyright (C) 1986-1993, 1998, 2004, 2007-2017
#    	Thomas Williams, Colin Kelley and many others
#    
#    	gnuplot home:     http://www.gnuplot.info
#    	faq, bugs, etc:   type "help FAQ"
#    	immediate help:   type "help"  (plot window: hit 'h')
# set terminal qt 0 font "Sans,9"
# set output
unset clip points
set clip one
unset clip two
set errorbars front 1.000000 
set border 31 front lt black linewidth 1.500 dashtype solid
set zdata 
set ydata 
set xdata 
set y2data 
set x2data 
set boxwidth
set style fill  empty border
set style rectangle back fc  bgnd fillstyle   solid 1.00 border lt -1
set style circle radius graph 0.02 
set style ellipse size graph 0.05, 0.03 angle 0 units xy
set dummy x, y
set format x "% h" 
set format y "% h" 
set format x2 "% h" 
set format y2 "% h" 
set format z "% h" 
set format cb "% h" 
set format r "% h" 
set ttics format "% h"
set timefmt "%d/%m/%y,%H:%M"
set angles radians
set tics back
unset grid
unset raxis
set theta counterclockwise right
set style parallel front  lt black linewidth 2.000 dashtype solid
set key title "" center
set key fixed right top vertical Right noreverse enhanced autotitle nobox
set key noinvert samplen 4 spacing 1 width 0 height 0 
set key maxcolumns 0 maxrows 0
set key noopaque
unset label
unset arrow
set style increment default
unset style line
unset style arrow
set style histogram clustered gap 2 title textcolor lt -1
unset object
set style textbox transparent margins  1.0,  1.0 border  lt -1 linewidth  1.0
set offsets 0, 0, 0, 0
set pointsize 1
set pointintervalbox 1
set encoding default
unset polar
unset parametric
unset decimalsign
unset micro
unset minussign
set view 60, 30, 1, 1
set view azimuth 0
set rgbmax 255
set samples 100, 100
set isosamples 10, 10
set surface 
unset contour
set cntrlabel  format '%8.3g' font '' start 5 interval 20
set mapping cartesian
set datafile separator whitespace
unset hidden3d
set cntrparam order 4
set cntrparam linear
set cntrparam levels auto 5
set cntrparam points 5
set size ratio 0 1,1
set origin 0,0
set style data points
set style function lines
unset xzeroaxis
unset yzeroaxis
unset zzeroaxis
unset x2zeroaxis
unset y2zeroaxis
set xyplane relative 0.5
set tics scale  1, 0.5, 1, 1, 1
set mxtics default
set mytics default
set mztics default
set mx2tics default
set my2tics default
set mcbtics default
set mrtics default
set nomttics
set xtics border in scale 1,0.5 mirror norotate  autojustify
set xtics  norangelimit autofreq 
set ytics border in scale 1,0.5 mirror norotate  autojustify
set ytics  norangelimit autofreq 
set ztics border in scale 1,0.5 nomirror norotate  autojustify
set ztics  norangelimit autofreq 
unset x2tics
set y2tics border in scale 1,0.5 nomirror norotate  autojustify
set y2tics  norangelimit autofreq 
set cbtics border in scale 1,0.5 mirror norotate  autojustify
set cbtics  norangelimit autofreq 
set rtics axis in scale 1,0.5 nomirror norotate  autojustify
set rtics  norangelimit autofreq 
unset ttics
set title "Node's pool of tasks, with total tasks V = 1000" 
set title  font "" norotate
set timestamp bottom 
set timestamp "" 
set timestamp  font "" norotate
set trange [ * : * ] noreverse nowriteback
set urange [ * : * ] noreverse nowriteback
set vrange [ * : * ] noreverse nowriteback
set xlabel "N, nodes" 
set xlabel  font "" textcolor lt -1 norotate
set x2label "" 
set x2label  font "" textcolor lt -1 norotate
set xrange [ 3.00000 : 100.000 ] noreverse nowriteback
set x2range [ * : * ] noreverse nowriteback
set ylabel "PoolSize, tasks" 
set ylabel  font "" textcolor lt -1 rotate
set y2label "Difference between maximum and actual pool sizes" 
set y2label  font "" textcolor lt -1 rotate
set yrange [ 0.00000 : 1000.00 ] noreverse nowriteback
set y2range [ 0.00000 : 1.10000 ] noreverse nowriteback
set zlabel "" 
set zlabel  font "" textcolor lt -1 norotate
set zrange [ * : * ] noreverse nowriteback
set cblabel "" 
set cblabel  font "" textcolor lt -1 rotate
set cbrange [ * : * ] noreverse nowriteback
set rlabel "" 
set rlabel  font "" textcolor lt -1 norotate
set rrange [ * : * ] noreverse nowriteback
unset logscale
unset jitter
set zero 1e-08
set lmargin  -1
set bmargin  -1
set rmargin  -1
set tmargin  -1
set locale "ru_RU.UTF-8"
set pm3d explicit at s
set pm3d scansautomatic
set pm3d interpolate 1,1 flush begin noftriangles noborder corners2color mean
set pm3d nolighting
set palette positive nops_allcF maxcolors 0 gamma 1.5 color model RGB 
set palette rgbformulae 7, 5, 15
set colorbox default
set colorbox vertical origin screen 0.9, 0.2 size screen 0.05, 0.6 front  noinvert bdefault
set style boxplot candles range  1.50 outliers pt 7 separation 1 labels auto unsorted
set loadpath 
set fontpath 
set psdir
set fit brief errorvariables nocovariancevariables errorscaling prescale nowrap v5
FindPoolFloored(n,v) = (floor(v) * (1 + floor(floor(n)/3) )) / floor(n)
FindPool(n,v) = (v * (1 + (n/3) )) / n
FindMinPool(n,v) = v / (2*(n/3))
R(x) = 0.9635163499025019 + 0.008489300057147832*x - 0.0004128065185341778*x**2 + 0.00000231445380908552*x**3 + 2.263099444192e-8*x**4 - 1.8532019602e-10*x**5
RCeil(x)=ceil(R(x)*100)/100.0
Result(n,v)= n<90 ? R(n)*FindPool(n,v) : R2(n)*FindPool(n,v)
R2(x) = 1.1821374025608*exp(-0.01032913015671078175*x)
GNUTERM = "qt"
GPFUN_FindPoolFloored = "FindPoolFloored(n,v) = (floor(v) * (1 + floor(floor(n)/3) )) / floor(n)"
GPFUN_FindPool = "FindPool(n,v) = (v * (1 + (n/3) )) / n"
GPFUN_FindMinPool = "FindMinPool(n,v) = v / (2*(n/3))"
GPFUN_R = "R(x) = 0.9635163499025019 + 0.008489300057147832*x - 0.0004128065185341778*x**2 + 0.00000231445380908552*x**3 + 2.263099444192e-8*x**4 - 1.8532019602e-10*x**5"
GPFUN_RCeil = "RCeil(x)=ceil(R(x)*100)/100.0"
GPFUN_Result = "Result(n,v)= n<90 ? R(n)*FindPool(n,v) : R2(n)*FindPool(n,v)"
GPFUN_R2 = "R2(x) = 1.1821374025608*exp(-0.01032913015671078175*x)"
## Last datafile plotted: "data/3p.dat"
plot FindPool(x,1000) title 'MaxPoolSize', 'data/3p.dat' using 1:6:7 title 'Experiments' with yerrorbars, 'data/3p.dat' using 1:8 title 'diff' smooth bezier axes x1y2, FindMinPool(x,1000) title 'MinPoolSize', Result(x,1000) lt 2 title 'PoolSize'
#    EOF
