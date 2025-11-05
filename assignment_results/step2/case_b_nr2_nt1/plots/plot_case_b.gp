# Terminal settings
set terminal png size 1200,800 enhanced font 'Arial,14'
set output 'assignment_results/step2/case_b_nr2_nt1/plots/case_b_8qam_nr2_nt1.png'

# Plot styling
set logscale y
set grid xtics ytics mytics lw 0.5, lw 0.5
set format y "%.1e"

# Labels
set xlabel "Average SNR per bit (dB)" font "Arial,16"
set ylabel "Symbol-Error-Rate" font "Arial,16"
set title "8-QAM in Rayleigh Flat Fading (Nr=2, Nt=1)" font "Arial,18"

# Legend
set key right top box

# Plot data - matching Step 1 style (all black lines)
plot "assignment_results/step2/case_b_nr2_nt1/simulation_data/qam8r2t1chser.dat" \
     using 1:2 with lines linewidth 2.5 linecolor rgb "blue" \
     title "Chernoff bound", \
     "assignment_results/step2/case_b_nr2_nt1/simulation_data/qam8r2t1thser.dat" \
     using 1:2 with lines linewidth 2.5 linecolor rgb "red" \
     title "Union bound", \
     "assignment_results/step2/case_b_nr2_nt1/simulation_data/qam8r2t1simser.dat" \
     using 1:2 with linespoints linewidth 2.5 pointtype 7 pointsize 1.5 linecolor rgb "black" \
     title "Simulation"

# Also create EPS version for high quality
set terminal postscript eps enhanced color size 6,4 font 'Arial,14'
set output 'assignment_results/step2/case_b_nr2_nt1/plots/case_b_8qam_nr2_nt1.eps'
replot
