#*******************************************************************************
#    Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.
#    All Rights Reserved.
#*******************************************************************************
#*******************************************************************************
# Gnuplot file. To plot the graph run gnuplot and at the gnuplot prompt
# type: load "qpskr4t4ser.gp"<RETURN>
# If you want the output on the screen, comment the following two lines:
# set term postscript eps color 22
# set output "qpskr4t4ser.eps"
# Comment lines begin with a #.
# For help on gnuplot, run gnuplot and type the following at the gnuplot
# prompt: help
#*******************************************************************************
# Plot of the symbol error rates for QPSK in fading channels for various
# diversities.
#*******************************************************************************
set term postscript eps color 22
set nokey
set grid xtics ytics mytics lw 0.5, lw 0.5
set format y "%2.1e"
set output "qpskr4t4ser.eps"
set logscale y
#set xlabel "SNR (dB)"
#set ylabel "Symbol error rate"
plot "qpskr4t4simser.dat" t "QPSK Nr=4 Nt=4 sim"\
      w lines lt -1 lw 2,\
     "qpskr4t4thser.dat" t "QPSK Nr=4 Nt=4 UB"\
      w lines lt -1 lw 2,\
     "qpskr4t4chser.dat" t "QPSK Nr=4 Nt=4 Chernoff"\
      w lines lt -1 lw 2
