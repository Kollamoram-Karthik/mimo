#!/bin/bash
################################################################################
# Step 2 Case (a): 8-QAM with Nr=1, Nt=1
# SNR range: 5 to 55 dB in steps of 5 dB (11 points)
# Minimum squared Euclidean distance = 4
################################################################################

# Configuration
CASE_NAME="case_a_nr1_nt1"
OUTPUT_DIR="assignment_results/step2/${CASE_NAME}"
SNR_START=5
SNR_END=55
SNR_STEP=5
NUM_RX=1
NUM_TX=1
CONSTELL_TYPE="QAM8"
BITS_PER_SYM=3
CONSTELL_SIZE=8

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages to stderr
print_msg() {
    echo -e "$1" >&2
}

# Create output directories if they don't exist
mkdir -p "${OUTPUT_DIR}/simulation_data"
mkdir -p "${OUTPUT_DIR}/plots"
mkdir -p "${OUTPUT_DIR}/logs"

# Initialize output files
SIM_FILE="${OUTPUT_DIR}/simulation_data/qam8r1t1simser.dat"
> "${SIM_FILE}"

print_msg "${BLUE}========================================${NC}"
print_msg "${BLUE}Step 2 Case (a): 8-QAM, Nr=1, Nt=1${NC}"
print_msg "${BLUE}SNR Range: ${SNR_START} to ${SNR_END} dB (step ${SNR_STEP})${NC}"
print_msg "${BLUE}========================================${NC}"

# Generate theoretical bounds first
print_msg "${YELLOW}Generating theoretical bounds...${NC}"

# Configure mimotheory_ser.c for this case
sed -i.bak \
    -e "s/#define CONSTELL .*/#define CONSTELL QAM8/" \
    -e "s/#define MIN_SNR .*/#define MIN_SNR ${SNR_START}.0/" \
    -e "s/#define MAX_SNR .*/#define MAX_SNR $((SNR_END + 1)).0/" \
    -e "s/#define STEP .*/#define STEP ${SNR_STEP}/" \
    -e "s/#define CONSTELL_SIZE .*/#define CONSTELL_SIZE ${CONSTELL_SIZE}/" \
    -e "s/#define BITS_PER_SYM .*/#define BITS_PER_SYM ${BITS_PER_SYM}/" \
    -e "s/#define NUM_TX .*/#define NUM_TX ${NUM_TX}/" \
    -e "s/#define NUM_RX .*/#define NUM_RX ${NUM_RX}/" \
    -e "s/#define NUM_VEC .*/#define NUM_VEC $(echo "${CONSTELL_SIZE}^${NUM_TX}" | bc)/" \
    mimotheory_ser.c

# Compile mimotheory_ser
gcc -O mimotheory_ser.c -lm -o mimotheory_ser > "${OUTPUT_DIR}/logs/theory_compile.log" 2>&1

if [ $? -ne 0 ]; then
    print_msg "${RED}✗ Failed to compile mimotheory_ser${NC}"
else
    # Run theoretical bounds generation
    ./mimotheory_ser > "${OUTPUT_DIR}/logs/theory_generation.log" 2>&1
    
    # Move generated files from mimodata/ to output directory
    if [ -f "mimodata/qam8r1t1thser.dat" ]; then
        cp mimodata/qam8r1t1thser.dat "${OUTPUT_DIR}/simulation_data/"
        print_msg "${GREEN}✓ Union bound generated${NC}"
    fi
    
    if [ -f "mimodata/qam8r1t1chser.dat" ]; then
        cp mimodata/qam8r1t1chser.dat "${OUTPUT_DIR}/simulation_data/"
        print_msg "${GREEN}✓ Chernoff bound generated${NC}"
    fi
fi

# Restore original mimotheory_ser.c
if [ -f mimotheory_ser.c.bak ]; then
    mv mimotheory_ser.c.bak mimotheory_ser.c
fi

# Counter for progress
TOTAL_POINTS=$(echo "scale=0; (${SNR_END} - ${SNR_START})/${SNR_STEP} + 1" | bc)
CURRENT_POINT=0

# Loop through SNR values
for SNR in $(seq ${SNR_START} ${SNR_STEP} ${SNR_END}); do
    CURRENT_POINT=$((CURRENT_POINT + 1))
    
    print_msg "\n${BLUE}[${CURRENT_POINT}/${TOTAL_POINTS}] Processing SNR = ${SNR} dB${NC}"
    
    # Calculate NUM_VEC = CONSTELL_SIZE^NUM_TX
    NUM_VEC=$(echo "${CONSTELL_SIZE}^${NUM_TX}" | bc)
    
    # Modify mimotype.h with current parameters
    sed -i.bak \
        -e "s/#define SNR .*/#define SNR ${SNR}/" \
        -e "s/#define NUM_TX .*/#define NUM_TX ${NUM_TX}/" \
        -e "s/#define NUM_RX .*/#define NUM_RX ${NUM_RX}/" \
        -e "s/#define CONSTELL .*/#define CONSTELL ${CONSTELL_TYPE}/" \
        -e "s/#define BITS_PER_SYM .*/#define BITS_PER_SYM ${BITS_PER_SYM}/" \
        -e "s/#define CONSTELL_SIZE .*/#define CONSTELL_SIZE ${CONSTELL_SIZE}/" \
        -e "s/#define NUM_VEC .*/#define NUM_VEC ${NUM_VEC}/" \
        mimotype.h
    
    # Compile
    print_msg "${YELLOW}  Compiling...${NC}"
    make -f mimomake > "${OUTPUT_DIR}/logs/compile_snr${SNR}.log" 2>&1
    
    if [ $? -ne 0 ]; then
        print_msg "${RED}  ✗ Compilation failed!${NC}"
        continue
    fi
    
    # Run simulation
    print_msg "${YELLOW}  Running simulation (this may take several minutes)...${NC}"
    START_TIME=$(date +%s)
    
    ./mimo > "${OUTPUT_DIR}/logs/simulation_snr${SNR}.log" 2>&1
    
    END_TIME=$(date +%s)
    ELAPSED=$((END_TIME - START_TIME))
    MINUTES=$((ELAPSED / 60))
    SECONDS=$((ELAPSED % 60))
    
    # Extract SER from output (format: "SER: 0.2056881600.")
    SER=$(grep "SER:" "${OUTPUT_DIR}/logs/simulation_snr${SNR}.log" | awk '{print $2}' | sed 's/\.$//')
    
    if [ -z "$SER" ]; then
        print_msg "${RED}  ✗ Failed to extract SER${NC}"
        continue
    fi
    
    # Write to data file
    printf "%d %s\n" "$SNR" "$SER" >> "${SIM_FILE}"
    
    print_msg "${GREEN}  ✓ Completed in ${MINUTES}m ${SECONDS}s | SER = ${SER}${NC}"
done

# Restore original mimotype.h
if [ -f mimotype.h.bak ]; then
    mv mimotype.h.bak mimotype.h
fi

print_msg "\n${YELLOW}========================================${NC}"
print_msg "${YELLOW}Generating plots...${NC}"
print_msg "${YELLOW}========================================${NC}"

# Create gnuplot script
GNUPLOT_SCRIPT="${OUTPUT_DIR}/plots/plot_case_a.gp"
cat > "${GNUPLOT_SCRIPT}" << 'EOF'
# Terminal settings
set terminal png size 1200,800 enhanced font 'Arial,14'
set output 'assignment_results/step2/case_a_nr1_nt1/plots/case_a_8qam_nr1_nt1.png'

# Plot styling
set logscale y
set grid xtics ytics mytics lw 0.5, lw 0.5
set format y "%.1e"

# Labels
set xlabel "Average SNR per bit (dB)" font "Arial,16"
set ylabel "Symbol-Error-Rate" font "Arial,16"
set title "8-QAM in Rayleigh Flat Fading (Nr=1, Nt=1)" font "Arial,18"

# Legend
set key right top box

# Plot data - matching Step 1 style (all black lines)
plot "assignment_results/step2/case_a_nr1_nt1/simulation_data/qam8r1t1chser.dat" \
     using 1:2 with lines linewidth 2.5 linecolor rgb "black" \
     title "1- Chernoff bound", \
     "assignment_results/step2/case_a_nr1_nt1/simulation_data/qam8r1t1thser.dat" \
     using 1:2 with lines linewidth 2.5 linecolor rgb "black" \
     title "2- Union bound", \
     "assignment_results/step2/case_a_nr1_nt1/simulation_data/qam8r1t1simser.dat" \
     using 1:2 with lines linewidth 2.5 linecolor rgb "black" \
     title "3- Simulation"

# Also create EPS version for high quality
set terminal postscript eps enhanced color size 6,4 font 'Arial,14'
set output 'assignment_results/step2/case_a_nr1_nt1/plots/case_a_8qam_nr1_nt1.eps'
replot
EOF

# Run gnuplot
gnuplot "${GNUPLOT_SCRIPT}" 2>&1

if [ -f "${OUTPUT_DIR}/plots/case_a_8qam_nr1_nt1.png" ]; then
    print_msg "${GREEN}✓ PNG plot generated${NC}"
fi

if [ -f "${OUTPUT_DIR}/plots/case_a_8qam_nr1_nt1.eps" ]; then
    print_msg "${GREEN}✓ EPS plot generated${NC}"
fi

print_msg "\n${GREEN}========================================${NC}"
print_msg "${GREEN}Case (a) complete!${NC}"
print_msg "${GREEN}Results saved to: ${OUTPUT_DIR}${NC}"
print_msg "${GREEN}========================================${NC}"
