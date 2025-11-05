#!/bin/bash
################################################################################
# MIMO Simulation - Complete Experiment Runner
# This script runs all simulations for Step 1 (16-QAM) and Step 2 (8-QAM)
################################################################################

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}         MIMO SIMULATION - COMPLETE EXPERIMENT RUNNER${NC}"
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo ""
echo "This script will run the complete MIMO simulation experiment:"
echo ""
echo "  Step 1: 16-QAM verification (Nr=2, Nt=2)"
echo "          13 SNR points from 5 to 35 dB in steps of 2.5 dB"
echo "          Estimated time: ~1.5-3 hours"
echo ""
echo "  Step 2: 8-QAM simulations (4 configurations)"
echo "          a) Nr=1, Nt=1 - 11 SNR points (5 to 55 dB, step 5 dB)"
echo "          b) Nr=2, Nt=1 - 11 SNR points (5 to 30 dB, step 2.5 dB)"
echo "          c) Nr=1, Nt=2 - 11 SNR points (5 to 55 dB, step 5 dB)"
echo "          d) Nr=2, Nt=2 - 11 SNR points (5 to 30 dB, step 2.5 dB)"
echo "          Total: 44 SNR points"
echo "          Estimated time: ~4-8 hours"
echo ""
echo -e "${YELLOW}Total estimated runtime: 6-11 hours${NC}"
echo ""
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo ""

# Ask for confirmation
read -p "Do you want to run the complete experiment? (y/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Experiment cancelled.${NC}"
    echo ""
    echo "You can run individual steps using:"
    echo "  ./run_step1_simulation.sh      # Step 1 only"
    echo "  ./run_step2a.sh                # Step 2a only"
    echo "  ./run_step2b.sh                # Step 2b only"
    echo "  ./run_step2c.sh                # Step 2c only"
    echo "  ./run_step2d.sh                # Step 2d only"
    echo ""
    exit 0
fi

# Record start time
EXPERIMENT_START=$(date +%s)
EXPERIMENT_START_TIME=$(date '+%Y-%m-%d %H:%M:%S')

echo ""
echo -e "${GREEN}Starting complete experiment at $EXPERIMENT_START_TIME${NC}"
echo ""
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"

# Run Step 1
echo ""
echo -e "${BLUE}[1/5] Running Step 1: 16-QAM verification...${NC}"
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"
STEP1_START=$(date +%s)

if [ -f "./run_step1_simulation.sh" ]; then
    bash ./run_step1_simulation.sh
    STEP1_STATUS=$?
    STEP1_END=$(date +%s)
    STEP1_DURATION=$((STEP1_END - STEP1_START))
    
    if [ $STEP1_STATUS -eq 0 ]; then
        echo -e "${GREEN}✓ Step 1 completed successfully in $(($STEP1_DURATION/60)) minutes${NC}"
    else
        echo -e "${RED}✗ Step 1 failed with exit code $STEP1_STATUS${NC}"
        echo "Aborting experiment."
        exit 1
    fi
else
    echo -e "${RED}✗ Error: run_step1_simulation.sh not found${NC}"
    exit 1
fi

# Run Step 2a
echo ""
echo -e "${BLUE}[2/5] Running Step 2a: 8-QAM with Nr=1, Nt=1...${NC}"
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"
STEP2A_START=$(date +%s)

if [ -f "./run_step2a.sh" ]; then
    bash ./run_step2a.sh
    STEP2A_STATUS=$?
    STEP2A_END=$(date +%s)
    STEP2A_DURATION=$((STEP2A_END - STEP2A_START))
    
    if [ $STEP2A_STATUS -eq 0 ]; then
        echo -e "${GREEN}✓ Step 2a completed successfully in $(($STEP2A_DURATION/60)) minutes${NC}"
    else
        echo -e "${RED}✗ Step 2a failed with exit code $STEP2A_STATUS${NC}"
        echo "Continuing with remaining steps..."
    fi
else
    echo -e "${RED}✗ Error: run_step2a.sh not found${NC}"
fi

# Run Step 2b
echo ""
echo -e "${BLUE}[3/5] Running Step 2b: 8-QAM with Nr=2, Nt=1...${NC}"
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"
STEP2B_START=$(date +%s)

if [ -f "./run_step2b.sh" ]; then
    bash ./run_step2b.sh
    STEP2B_STATUS=$?
    STEP2B_END=$(date +%s)
    STEP2B_DURATION=$((STEP2B_END - STEP2B_START))
    
    if [ $STEP2B_STATUS -eq 0 ]; then
        echo -e "${GREEN}✓ Step 2b completed successfully in $(($STEP2B_DURATION/60)) minutes${NC}"
    else
        echo -e "${RED}✗ Step 2b failed with exit code $STEP2B_STATUS${NC}"
        echo "Continuing with remaining steps..."
    fi
else
    echo -e "${RED}✗ Error: run_step2b.sh not found${NC}"
fi

# Run Step 2c
echo ""
echo -e "${BLUE}[4/5] Running Step 2c: 8-QAM with Nr=1, Nt=2...${NC}"
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"
STEP2C_START=$(date +%s)

if [ -f "./run_step2c.sh" ]; then
    bash ./run_step2c.sh
    STEP2C_STATUS=$?
    STEP2C_END=$(date +%s)
    STEP2C_DURATION=$((STEP2C_END - STEP2C_START))
    
    if [ $STEP2C_STATUS -eq 0 ]; then
        echo -e "${GREEN}✓ Step 2c completed successfully in $(($STEP2C_DURATION/60)) minutes${NC}"
    else
        echo -e "${RED}✗ Step 2c failed with exit code $STEP2C_STATUS${NC}"
        echo "Continuing with remaining steps..."
    fi
else
    echo -e "${RED}✗ Error: run_step2c.sh not found${NC}"
fi

# Run Step 2d
echo ""
echo -e "${BLUE}[5/5] Running Step 2d: 8-QAM with Nr=2, Nt=2...${NC}"
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"
STEP2D_START=$(date +%s)

if [ -f "./run_step2d.sh" ]; then
    bash ./run_step2d.sh
    STEP2D_STATUS=$?
    STEP2D_END=$(date +%s)
    STEP2D_DURATION=$((STEP2D_END - STEP2D_START))
    
    if [ $STEP2D_STATUS -eq 0 ]; then
        echo -e "${GREEN}✓ Step 2d completed successfully in $(($STEP2D_DURATION/60)) minutes${NC}"
    else
        echo -e "${RED}✗ Step 2d failed with exit code $STEP2D_STATUS${NC}"
    fi
else
    echo -e "${RED}✗ Error: run_step2d.sh not found${NC}"
fi

# Calculate total time
EXPERIMENT_END=$(date +%s)
EXPERIMENT_END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
TOTAL_DURATION=$((EXPERIMENT_END - EXPERIMENT_START))
HOURS=$((TOTAL_DURATION / 3600))
MINUTES=$(((TOTAL_DURATION % 3600) / 60))

echo ""
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}         EXPERIMENT COMPLETE${NC}"
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo ""
echo "Start Time:    $EXPERIMENT_START_TIME"
echo "End Time:      $EXPERIMENT_END_TIME"
echo "Total Runtime: ${HOURS}h ${MINUTES}m"
echo ""
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"
echo "Results Summary:"
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"

# Check and report on each step
echo ""
if [ -f "assignment_results/step1/plots/figure_2_34_verification.png" ]; then
    echo -e "  ${GREEN}✓${NC} Step 1: 16-QAM plot generated"
else
    echo -e "  ${RED}✗${NC} Step 1: Plot not found"
fi

if [ -f "assignment_results/step2/case_a_nr1_nt1/plots/case_a_8qam_nr1_nt1.png" ]; then
    echo -e "  ${GREEN}✓${NC} Step 2a: 8-QAM (1x1) plot generated"
else
    echo -e "  ${RED}✗${NC} Step 2a: Plot not found"
fi

if [ -f "assignment_results/step2/case_b_nr2_nt1/plots/case_b_8qam_nr2_nt1.png" ]; then
    echo -e "  ${GREEN}✓${NC} Step 2b: 8-QAM (2x1) plot generated"
else
    echo -e "  ${RED}✗${NC} Step 2b: Plot not found"
fi

if [ -f "assignment_results/step2/case_c_nr1_nt2/plots/case_c_8qam_nr1_nt2.png" ]; then
    echo -e "  ${GREEN}✓${NC} Step 2c: 8-QAM (1x2) plot generated"
else
    echo -e "  ${RED}✗${NC} Step 2c: Plot not found"
fi

if [ -f "assignment_results/step2/case_d_nr2_nt2/plots/case_d_8qam_nr2_nt2.png" ]; then
    echo -e "  ${GREEN}✓${NC} Step 2d: 8-QAM (2x2) plot generated"
else
    echo -e "  ${RED}✗${NC} Step 2d: Plot not found"
fi

echo ""
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"
echo "View Results:"
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"
echo ""
echo "  Step 1 Plot:  open assignment_results/step1/plots/figure_2_34_verification.png"
echo "  Step 2a Plot: open assignment_results/step2/case_a_nr1_nt1/plots/case_a_8qam_nr1_nt1.png"
echo "  Step 2b Plot: open assignment_results/step2/case_b_nr2_nt1/plots/case_b_8qam_nr2_nt1.png"
echo "  Step 2c Plot: open assignment_results/step2/case_c_nr1_nt2/plots/case_c_8qam_nr1_nt2.png"
echo "  Step 2d Plot: open assignment_results/step2/case_d_nr2_nt2/plots/case_d_8qam_nr2_nt2.png"
echo ""
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"
echo "Documentation:"
echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"
echo ""
echo "  Project README: cat README.md"
echo "  Code Changes:   cat PART_3.md"
echo "  MAX_VEC Info:   cat PART_4.md"
echo ""
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo ""
