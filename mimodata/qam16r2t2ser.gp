#*******************************************************************************
#    Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.
#    All Rights Reserved.
#*******************************************************************************
#*******************************************************************************
# Gnuplot file. To plot the graph run gnuplot and at the gnuplot prompt
# type: load "qam16r2t2ser.gp"<RETURN>
# If you want the output on the screen, comment the following two lines:
# set term postscript eps color 22
# set output "qam16r2t2ser.eps"
# Comment lines begin with a #.
# For help on gnuplot, run gnuplot and type the following at the gnuplot
# prompt: help
#*******************************************************************************
# Plot of the symbol error rates for 16-QAM in fading channels for various
# diversities.
#*******************************************************************************
#set term postscript eps color 22
set nokey
set grid xtics ytics mytics lw 0.5, lw 0.5
set format y "%2.1e"
#set output "qam16r2t2ser.eps"
set logscale y
#set xlabel "SNR (dB)"
#set ylabel "Symbol error rate"
plot "qam16r2t2simser.dat" t "16-QAM Nr=2 Nt=2 sim"\
      w lines lt -1 lw 2,\
     "qam16r2t2thser.dat" t "16-QAM Nr=2 Nt=2 UB"\
      w lines lt -1 lw 2,\
     "qam16r2t2chser.dat" t "16-QAM Nr=2 Nt=2 Chernoff"\
      w lines lt -1 lw 2
