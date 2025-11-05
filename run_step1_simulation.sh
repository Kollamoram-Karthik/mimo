#!/bin/bash
################################################################################
# MIMO Simulation Script - Step 1
# Purpose: Automate simulation for 16-QAM with Nr=2, Nt=2
# SNR Range: 5 to 35 dB in steps of 2.5 dB
# Author: Assignment Step-1 Automation
# Date: November 5, 2025
################################################################################

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directories
RESULTS_DIR="assignment_results/step1"
SIM_DATA_DIR="${RESULTS_DIR}/simulation_data"
PLOTS_DIR="${RESULTS_DIR}/plots"
LOGS_DIR="${RESULTS_DIR}/logs"

# Files
HEADER_FILE="mimotype.h"
HEADER_BACKUP="mimotype.h.backup"
SIM_OUTPUT_FILE="${SIM_DATA_DIR}/qam16r2t2simser.dat"
THEORY_OUTPUT_UB="${SIM_DATA_DIR}/qam16r2t2thser.dat"
THEORY_OUTPUT_CH="${SIM_DATA_DIR}/qam16r2t2chser.dat"
GNUPLOT_SCRIPT="${RESULTS_DIR}/plot_step1_results.gp"
SUMMARY_LOG="${LOGS_DIR}/simulation_summary.log"

# Simulation parameters
SNR_START=5.0
SNR_END=35.0
SNR_STEP=2.5

################################################################################
# Function: Print colored messages
################################################################################
print_msg() {
    local color=$1
    local msg=$2
    echo -e "${color}${msg}${NC}"
}

################################################################################
# Function: Create backup of header file
################################################################################
backup_header() {
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    print_msg "$BLUE" "Creating backup of ${HEADER_FILE}..."
    if [ ! -f "$HEADER_BACKUP" ]; then
        cp "$HEADER_FILE" "$HEADER_BACKUP"
        print_msg "$GREEN" "✓ Backup created: ${HEADER_BACKUP}"
    else
        print_msg "$YELLOW" "⚠ Backup already exists: ${HEADER_BACKUP}"
    fi
}

################################################################################
# Function: Restore header file from backup
################################################################################
restore_header() {
    print_msg "$BLUE" "Restoring ${HEADER_FILE} from backup..."
    if [ -f "$HEADER_BACKUP" ]; then
        cp "$HEADER_BACKUP" "$HEADER_FILE"
        print_msg "$GREEN" "✓ Header file restored"
    fi
}

################################################################################
# Function: Modify SNR in header file
################################################################################
modify_snr() {
    local snr_value=$1
    
    # Use sed to replace the SNR value
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/#define SNR [0-9.]*/#define SNR ${snr_value}/" "$HEADER_FILE"
    else
        # Linux
        sed -i "s/#define SNR [0-9.]*/#define SNR ${snr_value}/" "$HEADER_FILE"
    fi
}

################################################################################
# Function: Compile the simulation code
################################################################################
compile_simulation() {
    print_msg "$YELLOW" "▶ Compiling..."
    
    # Clean previous build
    make -f mimomake clean 2>/dev/null || true
    rm -f mimo *.o 2>/dev/null || true
    
    # Compile (suppress detailed output)
    if make -f mimomake > /dev/null 2>&1; then
        print_msg "$GREEN" "✓ Compilation successful"
        return 0
    else
        print_msg "$RED" "✗ Compilation failed"
        print_msg "$YELLOW" "  Running make with verbose output:"
        make -f mimomake
        return 1
    fi
}

################################################################################
# Function: Run simulation for a specific SNR
################################################################################
run_simulation() {
    local snr_value=$1
    local log_file="${LOGS_DIR}/simulation_snr_${snr_value}.log"
    
    # Print to stderr so it doesn't get captured by $()
    print_msg "$YELLOW" "▶ RUNNING SIMULATION..." >&2
    print_msg "$BLUE" "  (May take 5-30 minutes depending on SNR and hardware)" >&2
    
    # Run simulation and capture output
    if timeout 300 ./mimo > "$log_file" 2>&1; then
        # Extract SER from output (remove any trailing periods)
        local ser=$(grep "SER:" "$log_file" | awk '{print $2}' | sed 's/\.$//')
        
        if [ -n "$ser" ]; then
            print_msg "$GREEN" "✓ SIMULATION COMPLETE!" >&2
            # Output ONLY the SER value to stdout (for capture)
            echo "$ser"
            return 0
        else
            print_msg "$RED" "✗ Failed to extract SER from output" >&2
            print_msg "$YELLOW" "  Check log: ${log_file}" >&2
            return 1
        fi
    else
        print_msg "$RED" "✗ Simulation timed out (>5min) or failed" >&2
        print_msg "$YELLOW" "  Check log: ${log_file}" >&2
        return 1
    fi
}

################################################################################
# Function: Run all simulations
################################################################################
run_all_simulations() {
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    print_msg "$GREEN" "STARTING SIMULATIONS FOR ALL SNR VALUES"
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    
    # Clear previous simulation data
    rm -f "$SIM_OUTPUT_FILE"
    touch "$SIM_OUTPUT_FILE"
    
    # Initialize summary log
    echo "MIMO Simulation Summary - Step 1" > "$SUMMARY_LOG"
    echo "Date: $(date)" >> "$SUMMARY_LOG"
    echo "Configuration: 16-QAM, Nr=2, Nt=2" >> "$SUMMARY_LOG"
    echo "SNR Range: ${SNR_START} to ${SNR_END} dB (step: ${SNR_STEP} dB)" >> "$SUMMARY_LOG"
    echo "═══════════════════════════════════════════════════════════" >> "$SUMMARY_LOG"
    echo "" >> "$SUMMARY_LOG"
    
    local total_sims=0
    local successful_sims=0
    
    # Loop through SNR values
    snr=$SNR_START
    while (( $(echo "$snr <= $SNR_END" | bc -l) )); do
        total_sims=$((total_sims + 1))
        
        echo ""
        echo ""
        print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
        print_msg "$GREEN" "   SIMULATION ${total_sims}/13 → SNR = ${snr} dB"
        print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
        echo ""
        
        # Modify SNR
        print_msg "$YELLOW" "▶ Setting SNR to ${snr} dB in mimotype.h..."
        modify_snr "$snr"
        print_msg "$GREEN" "✓ SNR updated"
        
        # Compile
        if ! compile_simulation; then
            print_msg "$RED" "❌ Skipping SNR = ${snr} dB due to compilation error"
            echo "SNR ${snr} dB: COMPILATION FAILED" >> "$SUMMARY_LOG"
            snr=$(echo "$snr + $SNR_STEP" | bc)
            continue
        fi
        
        # Run simulation
        ser=$(run_simulation "$snr")
        exit_code=$?
        
        if [ $exit_code -eq 0 ] && [ -n "$ser" ]; then
            # Write to output file (format: SNR SER) - clean numeric output only
            printf "%17.12f   %17.12f\n" "$snr" "$ser" >> "$SIM_OUTPUT_FILE"
            echo "SNR ${snr} dB: SER = ${ser} ✓" >> "$SUMMARY_LOG"
            successful_sims=$((successful_sims + 1))
            print_msg "$GREEN" "✅ Data saved: SNR=${snr} SER=${ser}"
        else
            echo "SNR ${snr} dB: SIMULATION FAILED" >> "$SUMMARY_LOG"
            print_msg "$RED" "❌ Failed to save data point"
        fi
        
        snr=$(echo "$snr + $SNR_STEP" | bc)
        echo ""
    done
    
    echo ""
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    print_msg "$GREEN" "✅ ALL SIMULATIONS COMPLETED!"
    print_msg "$GREEN" "   Successful: ${successful_sims}/${total_sims} SNR points"
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    
    echo "" >> "$SUMMARY_LOG"
    echo "═══════════════════════════════════════════════════════════" >> "$SUMMARY_LOG"
    echo "Summary: ${successful_sims}/${total_sims} simulations successful" >> "$SUMMARY_LOG"
    echo "Results saved to: ${SIM_OUTPUT_FILE}" >> "$SUMMARY_LOG"
    
    # Show preview of results
    if [ -f "$SIM_OUTPUT_FILE" ]; then
        print_msg "$YELLOW" "Preview of simulation results:"
        print_msg "$YELLOW" "SNR (dB)    SER"
        print_msg "$YELLOW" "─────────────────────"
        head -5 "$SIM_OUTPUT_FILE" | while read line; do
            print_msg "$YELLOW" "$line"
        done
        if [ $(wc -l < "$SIM_OUTPUT_FILE") -gt 5 ]; then
            print_msg "$YELLOW" "... (showing first 5 of $(wc -l < "$SIM_OUTPUT_FILE" | tr -d ' ') points)"
        fi
    fi
}

################################################################################
# Function: Compile and run theoretical bounds
################################################################################
generate_theoretical_bounds() {
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    print_msg "$GREEN" "GENERATING THEORETICAL BOUNDS"
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    
    # Compile theory code
    print_msg "$YELLOW" "Compiling mimotheory_ser.c..."
    if gcc -O mimotheory_ser.c -lm -o mimotheory_ser; then
        print_msg "$GREEN" "✓ Theory code compiled successfully"
        
        # Run theory code
        print_msg "$YELLOW" "Generating Union and Chernoff bounds..."
        if ./mimotheory_ser > "${LOGS_DIR}/theory_output.log" 2>&1; then
            print_msg "$GREEN" "✓ Theoretical bounds generated"
            
            # Move generated files to simulation_data directory
            if [ -f "qam16r2t2thser.dat" ]; then
                mv qam16r2t2thser.dat "$THEORY_OUTPUT_UB"
                print_msg "$GREEN" "✓ Union bound saved: ${THEORY_OUTPUT_UB}"
            fi
            
            if [ -f "qam16r2t2chser.dat" ]; then
                mv qam16r2t2chser.dat "$THEORY_OUTPUT_CH"
                print_msg "$GREEN" "✓ Chernoff bound saved: ${THEORY_OUTPUT_CH}"
            fi
            
            return 0
        else
            print_msg "$RED" "✗ Failed to generate theoretical bounds"
            return 1
        fi
    else
        print_msg "$RED" "✗ Failed to compile theory code"
        return 1
    fi
}

################################################################################
# Function: Create gnuplot script
################################################################################
create_gnuplot_script() {
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    print_msg "$GREEN" "CREATING GNUPLOT SCRIPT"
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    
    cat > "$GNUPLOT_SCRIPT" << 'EOF'
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

# Plot data
plot "assignment_results/step1/simulation_data/qam16r2t2chser.dat" \
     using 1:2 with lines linewidth 2.5 linecolor rgb "black" \
     title "1- Chernoff bound", \
     "assignment_results/step1/simulation_data/qam16r2t2thser.dat" \
     using 1:2 with lines linewidth 2.5 linecolor rgb "black" \
     title "2- Union bound", \
     "assignment_results/step1/simulation_data/qam16r2t2simser.dat" \
     using 1:2 with lines linewidth 2.5 linecolor rgb "black" \
     title "3- Simulation"

# Also create EPS version for high quality
set terminal postscript eps enhanced color size 6,4 font 'Arial,14'
set output 'assignment_results/step1/plots/figure_2_34_verification.eps'
replot
EOF

    print_msg "$GREEN" "✓ Gnuplot script created: ${GNUPLOT_SCRIPT}"
}

################################################################################
# Function: Generate plots
################################################################################
generate_plots() {
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    print_msg "$GREEN" "GENERATING PLOTS"
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    
    if command -v gnuplot &> /dev/null; then
        print_msg "$YELLOW" "Running gnuplot..."
        if gnuplot "$GNUPLOT_SCRIPT" 2>&1 | tee "${LOGS_DIR}/gnuplot.log"; then
            print_msg "$GREEN" "✓ Plots generated successfully"
            print_msg "$GREEN" "  PNG: ${PLOTS_DIR}/figure_2_34_verification.png"
            print_msg "$GREEN" "  EPS: ${PLOTS_DIR}/figure_2_34_verification.eps"
            return 0
        else
            print_msg "$RED" "✗ Gnuplot execution failed"
            return 1
        fi
    else
        print_msg "$YELLOW" "⚠ Gnuplot not found. Install with: brew install gnuplot"
        print_msg "$YELLOW" "  You can run the script manually later:"
        print_msg "$YELLOW" "  gnuplot ${GNUPLOT_SCRIPT}"
        return 1
    fi
}

################################################################################
# Function: Display summary
################################################################################
display_summary() {
    echo ""
    echo ""
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    print_msg "$GREEN" "🎉 STEP 1 SIMULATION COMPLETE!"
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    echo ""
    print_msg "$GREEN" "📂 Results Location:"
    print_msg "$YELLOW" "  Simulation Data: ${SIM_DATA_DIR}/"
    print_msg "$YELLOW" "  Plots:           ${PLOTS_DIR}/"
    print_msg "$YELLOW" "  Logs:            ${LOGS_DIR}/"
    echo ""
    print_msg "$GREEN" "📊 Generated Files:"
    if [ -f "$SIM_OUTPUT_FILE" ]; then
        print_msg "$YELLOW" "  ✓ qam16r2t2simser.dat  - Simulation results"
    else
        print_msg "$RED" "  ✗ qam16r2t2simser.dat  - NOT FOUND"
    fi
    if [ -f "$THEORY_OUTPUT_UB" ]; then
        print_msg "$YELLOW" "  ✓ qam16r2t2thser.dat   - Union bound"
    else
        print_msg "$RED" "  ✗ qam16r2t2thser.dat   - NOT FOUND"
    fi
    if [ -f "$THEORY_OUTPUT_CH" ]; then
        print_msg "$YELLOW" "  ✓ qam16r2t2chser.dat   - Chernoff bound"
    else
        print_msg "$RED" "  ✗ qam16r2t2chser.dat   - NOT FOUND"
    fi
    if [ -f "${PLOTS_DIR}/figure_2_34_verification.png" ]; then
        print_msg "$YELLOW" "  ✓ figure_2_34_verification.png - Plot"
    else
        print_msg "$RED" "  ✗ figure_2_34_verification.png - NOT FOUND"
    fi
    echo ""
    print_msg "$GREEN" "🚀 Next Steps:"
    print_msg "$YELLOW" "  1. View the plot:"
    print_msg "$BLUE" "     open ${PLOTS_DIR}/figure_2_34_verification.png"
    echo ""
    print_msg "$YELLOW" "  2. Check summary:"
    print_msg "$BLUE" "     cat ${SUMMARY_LOG}"
    echo ""
    print_msg "$YELLOW" "  3. View all data:"
    print_msg "$BLUE" "     cat ${SIM_OUTPUT_FILE}"
    echo ""
    print_msg "$YELLOW" "  4. Compare with Figure 2.34 from DCSP textbook"
    echo ""
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
}

################################################################################
# Function: Cleanup
################################################################################
cleanup() {
    print_msg "$BLUE" "Cleaning up..."
    restore_header
    rm -f mimo *.o mimotheory_ser 2>/dev/null || true
    print_msg "$GREEN" "✓ Cleanup complete"
}

################################################################################
# Main execution
################################################################################
main() {
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    print_msg "$GREEN" "🚀 MIMO SIMULATION - STEP 1"
    print_msg "$GREEN" "   16-QAM Rayleigh Flat Fading (Nr=2, Nt=2)"
    print_msg "$BLUE" "═══════════════════════════════════════════════════════════"
    echo ""
    print_msg "$YELLOW" "Configuration:"
    print_msg "$YELLOW" "  • Modulation: 16-QAM"
    print_msg "$YELLOW" "  • Antennas: 2 Tx × 2 Rx"
    print_msg "$YELLOW" "  • SNR Range: ${SNR_START} to ${SNR_END} dB (step ${SNR_STEP} dB)"
    print_msg "$YELLOW" "  • Total SNR Points: 13"
    print_msg "$YELLOW" "  • Max Vectors per Simulation: 100,000,000"
    echo ""
    print_msg "$YELLOW" "⏱️  Estimated Time: 1-6 hours (depends on hardware)"
    echo ""
    
    # Setup
    backup_header
    
    # Trap to ensure cleanup on exit
    trap cleanup EXIT
    
    # Run simulations
    run_all_simulations
    
    # Generate theoretical bounds
    generate_theoretical_bounds
    
    # Create gnuplot script and generate plots
    create_gnuplot_script
    generate_plots
    
    # Display summary
    display_summary
}

# Run main function
main
