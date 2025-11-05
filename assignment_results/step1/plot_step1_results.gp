#*******************************************************************************
# Gnuplot script for Assignment Step-1
# Plot: Symbol Error Rate vs SNR for 16-QAM with Nr=2, Nt=2
# Shows: Chernoff bound, Union bound, and Simulation results
#*******************************************************************************

# Terminal settings
set terminal png size 1200,800 enhanced font 'Arial,14'
set output 'assignment_results/step1/plots/figure_2_34_verification.png'

# Plot styling
set logscale y
set grid xtics ytics mytics lw 0.5, lw 0.5
set format y "%.1e"

# Labels
set xlabel "Average SNR per bit (dB)" font "Arial,16"
set ylabel "Symbol-Error-Rate" font "Arial,16"
set title "16-QAM in Rayleigh Flat Fading (Nr=2, Nt=2)" font "Arial,18"

# Legend
set key right top box

# Plot data with different line styles for clarity
plot "assignment_results/step1/simulation_data/qam16r2t2chser.dat" \
     using 1:2 with lines linewidth 3 linecolor rgb "blue" dashtype 2 \
     title "1- Chernoff bound", \
     "assignment_results/step1/simulation_data/qam16r2t2thser.dat" \
     using 1:2 with lines linewidth 3 linecolor rgb "red" dashtype 1 \
     title "2- Union bound", \
     "assignment_results/step1/simulation_data/qam16r2t2simser.dat" \
     using 1:2 with linespoints linewidth 2.5 linecolor rgb "black" \
     pointtype 7 pointsize 1.2 pointinterval 1 \
     title "3- Simulation"

# Add labels directly on the curves for clarity
set label "1" at 8,0.4 font "Arial,24" textcolor rgb "blue" front
set label "2" at 8,0.7 font "Arial,24" textcolor rgb "red" front
set label "3" at 8,0.25 font "Arial,24" textcolor rgb "black" front
replot

# Also create EPS version for high quality
set terminal postscript eps enhanced color size 6,4 font 'Arial,14'
set output 'assignment_results/step1/plots/figure_2_34_verification.eps'
replot
