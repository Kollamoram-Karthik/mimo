# MIMO Simulation Assignment

**Student Name**: Kollamoram Karthik
**Roll Number**: 220538
**Course**: EE622
**Instructor**: Kasturi Vasudevan
**Date**: 5th November, 2025

---

## Introduction

This repository contains my work for the MIMO (Multiple-Input Multiple-Output) wireless communication systems assignment. The project involves simulating Symbol Error Rate (SER) performance over Rayleigh flat fading channels using Monte Carlo simulations with Maximum Likelihood (ML) detection.

The assignment has 4 main parts:

1. **Part 1**: Simulate the given code and verify with Figure 2.34 from textbook
2. **Part 2**: Implement and simulate 8-QAM with d²_min = 4
3. **Part 3**: Clearly indicate the changes made in the codes.
4. **Part 4**: Identify the constant corresponding to the number of vectors simulated, in mimotype.h

---

## Repository Structure

```
mimo/
├── Source Files (Modified for 8-QAM support)
│   ├── mimotype.h          # Main configuration header
│   ├── mimomap.c           # Constellation mapping functions
│   ├── mimock.c            # Parameter validation
│   ├── mimotheory_ser.c    # Theoretical bounds computation
│   └── [other .c/.h files] # Unchanged simulation code
│
├── Automation Scripts
│   ├── run_step1_simulation.sh   # Step 1 automation
│   ├── run_step2a.sh              # Step 2 case (a)
│   ├── run_step2b.sh              # Step 2 case (b)
│   ├── run_step2c.sh              # Step 2 case (c)
│   ├── run_step2d.sh              # Step 2 case (d)
│   └── QUICKSTART.sh              # Run everything
│
├── Results (Our Work)
│   └── assignment_results/
│       ├── step1/                 # Step 1 results
│       │   ├── simulation_data/   # .dat files
│       │   ├── plots/             # PNG and EPS plots
│       │   └── logs/              # Execution logs
│       └── step2/                 # Step 2 results
│           ├── case_a_nr1_nt1/    # (a) results
│           ├── case_b_nr2_nt1/    # (b) results
│           ├── case_c_nr1_nt2/    # (c) results
│           └── case_d_nr2_nt2/    # (d) results
│
├── Reference Data (Original from instructor)
│   └── mimodata/
│       ├── qpsk*.dat              # QPSK reference results
│       └── qam16r2t2*.dat         # 16-QAM reference for Step 1
│
└── Documentation
    ├── README.md                  # This file
    ├── PART_3.md                  # Code changes documentation
    └── PART_4.md                  # MAX_VEC constant explanation
```

**Important Note**:

- `assignment_results/` contains **OUR simulation results**
- `mimodata/` contains **reference data** provided by instructor for verification

---

## PART-1: 16-QAM Verification

### Objective

Simulate the given code and verify the results in Figure 2.34 of DCSP (onlineversion). Vary the average SNR per bit from 5 to 35 dB, in steps of 2.5 dB. Plotthe union and Chernoff bounds in the same figure.

### Configuration

- **Modulation**: 16-QAM
- **Antennas**: Nr = 2 (Receive), Nt = 2 (Transmit)
- **Channel**: Rayleigh Flat Fading
- **SNR Range**: 5 to 35 dB in steps of 2.5 dB
- **Total Points**: 13 SNR values
- **Vectors Simulated**: 100,000,000 per SNR point

### How to Run

```bash
./run_step1_simulation.sh
```

### Results Location

```
assignment_results/step1/
├── simulation_data/
│   ├── qam16r2t2simser.dat  # Simulation SER values
│   ├── qam16r2t2thser.dat   # Union bound
│   └── qam16r2t2chser.dat   # Chernoff bound
└── plots/
    ├── figure_2_34_verification.png
    └── figure_2_34_verification.eps
```

### What the Plot Shows

The plot has three curves:

1. **Curve 1 (Blue)**: Chernoff bound
2. **Curve 2 (Red)**: Union bound
3. **Curve 3 (Black)**: Our simulation results

All curves should closely match Figure 2.34 from the textbook.

---

## PART-2: 8-QAM Implementation

### Objective

Modify the code to simulate 8-QAM modulation with minimum squared Euclidean distance (d²_min) equal to 4.

### 8-QAM Constellation Design

I designed a **cross constellation** with the following 8 points:

```
         y
	 ^
         |
     (0,2.732)
         |
         |
  (-1,1) | (1,1)
         |
x--------+--------x-> 
 (-2.732,0) (2.732,0)
         |
 (-1,-1) | (1,-1)
         |
     (0,-2.732)
         |
```

**Points**:

- Diagonal: (±1, ±1) — 4 points
- Horizontal axis: (±2.732, 0) — 2 points
- Vertical axis: (0, ±2.732) — 2 points

where 2.732 ≈ 1 + √3

**Properties**:

- d²_min = 4 ✓
- Average power = 4.732
- 8 points total

### Four Cases Simulated:

#### Case (a): Nr = 1, Nt = 1

- **SNR Range**: 5 to 55 dB in steps of 5 dB
- **Total Points**: 11 SNR values
- **Script**: `run_step2a.sh`
- **Results**: `assignment_results/step2/case_a_nr1_nt1/`

#### Case (b): Nr = 2, Nt = 1

- **SNR Range**: 5 to 30 dB in steps of 2.5 dB
- **Total Points**: 11 SNR values
- **Script**: `run_step2b.sh`
- **Results**: `assignment_results/step2/case_b_nr2_nt1/`

#### Case (c): Nr = 1, Nt = 2

- **SNR Range**: 5 to 55 dB in steps of 5 dB
- **Total Points**: 11 SNR values
- **Script**: `run_step2c.sh`
- **Results**: `assignment_results/step2/case_c_nr1_nt2/`

#### Case (d): Nr = 2, Nt = 2

- **SNR Range**: 5 to 30 dB in steps of 2.5 dB
- **Total Points**: 11 SNR values
- **Script**: `run_step2d.sh`
- **Results**: `assignment_results/step2/case_d_nr2_nt2/`

**Total SNR points simulated in Step 2**: 44 points across all 4 cases

### How to Run Each Case

```bash
# Run all cases sequentially (takes 4-8 hours)
./QUICKSTART.sh

# Or run individually
./run_step2a.sh  # Case (a)
./run_step2b.sh  # Case (b)  
./run_step2c.sh  # Case (c)
./run_step2d.sh  # Case (d)
```

### Results for Each Case

Each case produces:

```
assignment_results/step2/case_X_nrYntZ/
├── simulation_data/
│   ├── qam8rYtZsimser.dat  # Simulation results
│   ├── qam8rYtZthser.dat   # Union bound
│   └── qam8rYtZchser.dat   # Chernoff bound
├── plots/
│   ├── case_X_8qam_nrYntZ.png
│   └── case_X_8qam_nrYntZ.eps
└── logs/
    └── [execution logs]
```

Each plot shows three curves:

1. **Simulation** (Blue with markers)
2. **Union Bound** (Red line)
3. **Chernoff Bound** (Black line)

---

## PART-3 : Code Modifications Summary

To add 8-QAM support, I modified **4 source files**. All changes are clearly marked with comments like:

```c
/****** MODIFICATION START: Added 8-QAM support (Nov 2025) ******/
// ... modified code ...
/****** MODIFICATION END ******/
```

### Files Modified:

1. **mimotype.h** (1 change)

   - Added `#define QAM8 4` constant
2. **mimomap.c** (3 changes)

   - Added `Re_8_QAM()` function for real part mapping
   - Added `Im_8_QAM()` function for imaginary part mapping
   - Modified `Get_Map()` to handle QAM8 case
3. **mimock.c** (1 change)

   - Added QAM8 validation in `Ck_Constell_Number()`
4. **mimotheory_ser.c** (6 changes)

   - Added `#define QAM8 4`
   - Added `Get_Re_8_QAM_Map()` and `Get_Im_8_QAM_Map()` functions
   - Modified `Get_Map()`, `Open_File()`, `Open_Chernoff()` functions
   - Added QAM8 validation

**See PART_3.md for detailed before/after code comparisons.**

---

## PART-4 : MAX_VEC Constant

Located in `mimotype.h` at line 13:

```c
#define MAX_VEC 100000000
```

This defines **100 million** as the maximum number of transmitted vectors to simulate per SNR point. This large number ensures statistically significant results, especially at high SNR where error rates are very low.

**See PART_4.md for detailed explanation.**

---

## How to Use This Repository

### Prerequisites

- **Compiler**: gcc (with math library `-lm`)
- **Plotting**: gnuplot (for generating plots)
- **Shell**: bash (for automation scripts)
- **OS**: Linux or macOS

Install gnuplot if needed:

```bash
# macOS
brew install gnuplot

# Linux (Ubuntu/Debian)
sudo apt-get install gnuplot
```

### Quick Start - Run Everything

To run the complete assignment (Step 1 + all 4 Step 2 cases):

```bash
# Make scripts executable (if needed)
chmod +x *.sh

# Run everything (will take 6-10 hours total)
./QUICKSTART.sh
```

This will:

1. Run Step 1 (16-QAM verification)
2. Run all 4 Step 2 cases
3. Generate all plots automatically
4. Display progress and results

### Manual Compilation and Execution

If you want to run simulations manually:

```bash
# 1. Edit mimotype.h to set parameters
#    - Set SNR, NUM_TX, NUM_RX, CONSTELL, etc.

# 2. Compile simulation code
make -f mimomake

# 3. Run simulation
./mimo

# 4. Compile theoretical bounds code  
gcc -O mimotheory_ser.c -lm -o mimotheory_ser

# 5. Run theoretical bounds
./mimotheory_ser

# 6. Generate plot with gnuplot
gnuplot [your_gnuplot_script.gp]
```

---

## Results Summary

### Step 1 Results

✓ 13 SNR points simulated
✓ Plot matches Figure 2.34 from textbook
✓ Results saved in `assignment_results/step1/`

### Step 2 Results

✓ Case (a): 11 SNR points (5-55 dB, step 5 dB)
✓ Case (b): 11 SNR points (5-30 dB, step 2.5 dB)
✓ Case (c): 11 SNR points (5-55 dB, step 5 dB)
✓ Case (d): 11 SNR points (5-30 dB, step 2.5 dB)
✓ All plots generated with simulation + theoretical bounds
✓ All results saved in `assignment_results/step2/`

---

## Troubleshooting

### Compilation Fails

```bash
# Clean and rebuild
make -f mimomake clean
make -f mimomake

# Check gcc is installed
gcc --version
```

### Simulation Takes Too Long

The simulation uses 100 million vectors per SNR point, which can take 5-30 minutes per point depending on your hardware. This is normal! You can check progress in the log files:

```bash
tail -f assignment_results/step1/logs/simulation_snr_15.0.log
```

### Plots Not Generated

Make sure gnuplot is installed:

```bash
gnuplot --version

# If not installed:
brew install gnuplot  # macOS
```

### Results Don't Match Reference

- Check that `mimotype.h` has correct parameters
- Verify MAX_VEC = 100000000
- Ensure random seed initialization is working
- Compare with reference data in `mimodata/` folder

---

## Important Files

### Configuration

- **mimotype.h**: All simulation parameters (SNR, antennas, modulation, etc.)

### Build

- **mimomake**: Makefile for building the simulation

### Documentation

- **README.md**: This file
- **PART_3.md**: Detailed code modifications for 8-QAM
- **PART_4.md**: Explanation of MAX_VEC constant
- **README**: Original project README from instructor

---

## Simulation Details

### Channel Model

- **Type**: Rayleigh Flat Fading
- **Fade Variance**: 0.5 per dimension (real/imaginary)
- **Noise**: Additive White Gaussian Noise (AWGN)

### Detection Method

- **Algorithm**: Maximum Likelihood (ML) Detection
- **Implementation**: Exhaustive search over all possible transmitted symbols

### Performance Metrics

- **SER**: Symbol Error Rate
- **Bounds**: Union bound and Chernoff bound for theoretical comparison

### Statistical Accuracy

With 100 million vectors per SNR point, we can accurately measure SER down to 10^-8.

---

## Time Estimates

Depends on hardware you used. I ran it on my MacBook Air M2

- **Step 1**: 1 hour (13 SNR points)
- **Step 2a**:  10min (11 SNR points, wide range)
- **Step 2b**: 10 minutes (11 SNR points, narrow range)
- **Step 2c**: 10 minutes (11 SNR points, wide range)
- **Step 2d**: 10 minutes (11 SNR points, narrow range)

**Total**: 6-11 hours for complete assignment

Factors affecting speed:

- CPU performance
- SNR value (higher SNR = fewer errors = faster)
- Number of antennas (more antennas = more computation)

---

## Assignment Submissions

1. **Modified source code** with clear modification markers
2. **All simulation results** in `assignment_results/`
3. **Plots** (PNG and EPS formats) for all cases
4. **Documentation** explaining changes (PART_3.md)
5. **MAX_VEC explanation** (PART_4.md)
6. **Automation scripts** for reproducibility

---

## Acknowledgments

- Original MIMO simulation code provided as part of EE622 course
- Textbook reference: Digital Communications and Signal Processing (DCSP)
