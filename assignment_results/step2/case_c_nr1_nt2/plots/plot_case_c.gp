# Terminal settings
set terminal png size 1200,800 enhanced font 'Arial,14'
set output 'assignment_results/step2/case_c_nr1_nt2/plots/case_c_8qam_nr1_nt2.png'

# Plot styling
set logscale y
set grid xtics ytics mytics lw 0.5, lw 0.5
set format y "%.1e"

# Labels
set xlabel "Average SNR per bit (dB)" font "Arial,16"
set ylabel "Symbol-Error-Rate" font "Arial,16"
set title "8-QAM in Rayleigh Flat Fading (Nr=1, Nt=2)" font "Arial,18"

# Legend
set key right top box

# Plot data with different line styles for clarity
plot "assignment_results/step2/case_c_nr1_nt2/simulation_data/qam8r1t2chser.dat" \
     using 1:2 with lines linewidth 3 linecolor rgb "blue" dashtype 2 \
     title "1- Chernoff bound", \
     "assignment_results/step2/case_c_nr1_nt2/simulation_data/qam8r1t2thser.dat" \
     using 1:2 with lines linewidth 3 linecolor rgb "red" dashtype 1 \
     title "2- Union bound", \
     "assignment_results/step2/case_c_nr1_nt2/simulation_data/qam8r1t2simser.dat" \
     using 1:2 with linespoints linewidth 2.5 linecolor rgb "black" \
     pointtype 7 pointsize 1.2 pointinterval 1 \
     title "3- Simulation"

# Also create EPS version for high quality
set terminal postscript eps enhanced color size 6,4 font 'Arial,14'
set output 'assignment_results/step2/case_c_nr1_nt2/plots/case_c_8qam_nr1_nt2.eps'
replot
