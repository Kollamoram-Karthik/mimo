#*******************************************************************************
#    Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.
#    All Rights Reserved.
#*******************************************************************************
#*******************************************************************************
# Gnuplot file. To plot the graph run gnuplot and at the gnuplot prompt
# type: load "qpskr4t2.gp"<RETURN>
# If you want the output on the screen, comment the following two lines:
# set term postscript eps color 22
# set output "qpskr4t2.eps"
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
set output "qpskr4t2.eps"
set logscale y
#set xlabel "SNR (dB)"
#set ylabel "Symbol error rate"
plot "qpskr4t2sim.dat" t "QPSK Nr=4 Nt=2 sim"\
      w lines lt -1 lw 2,\
     "qpskr4t2th.dat" t "QPSK Nr=4 Nt=2 UB"\
      w lines lt -1 lw 2,\
     "qpskr4t2ch.dat" t "QPSK Nr=4 Nt=2 Chernoff"\
      w lines lt -1 lw 2
