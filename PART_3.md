# Part 3: Code Modifications for 8-QAM# Part 3: Code Modifications for 8-QAM# Part 3: Code Modifications for 8-QAM

I modified 4 files to add 8-QAM modulation with minimum squared Euclidean distance = 4.I modified 5 files to add 8-QAM modulation with minimum squared Euclidean distance = 4.

## Files Modified## Files Modified

1. **mimotype.h** - Added QAM8 constant1. **mimotype.h** - Added QAM8 constant## Summary
2. **mimomap.c** - Implemented 8-QAM constellation mapping  2. **mimomap.c** - Implemented 8-QAM constellation mapping
3. **mimock.c** - Added validation3. **mimock.c** - Added validationFour files were modified:
4. **mimotheory_ser.c** - Added theoretical bounds4. **mimotheory_ser.c** - Added theoretical bounds1. **mimotype.h** - Added QAM8 constant
5. **mimomap.c** - Implemented 8-QAM constellation mapping

All changes are marked in code with:

```cAll

/****** MODIFICATION START: Description (Nov 2025) ******/

// modified code```c4.

/****** MODIFICATION END ******/

```/****** MODIFICATION START: Description (Nov 2025) ******/



---// modified codeAll modifications are clearly marked in the code with comment blocks:



## 1. mimotype.h/****** MODIFICATION END ******/



**Change:** Added QAM8 definition``````c---



**Line 22:**

```c

#define QAM8 4    /* Constellation number. */---/****** MODIFICATION START: Description (Nov 2025) ******/

```

---

## 1. mimotype.h// my changes here## File 1: mimotype.h

## 2. mimomap.c

### Change A: Modified Get_Map()

Added QAM8 case:**Change:** Added QAM8 definition/****** MODIFICATION END ******/

```c

else if(CONSTELL == QAM8)

{

  Re_8_QAM();**Line 22:**```**Location:** Line 19  

  Im_8_QAM();

}```c

```

#define QAM8 4    /* Constellation number. */**Purpose:** Define the 8-QAM constellation identifier

### Change B: Added Re_8_QAM() function

Real parts of 8-QAM constellation:```

```c

Re_Map[0]=   1.0;           Re_Map[4]=   1.0 + sqrt(3.0);  // 2.732---

Re_Map[1]=   1.0;           Re_Map[5]=   0.0;

Re_Map[2]=  -1.0;           Re_Map[6]=  -1.0 - sqrt(3.0);  // -2.732---

Re_Map[3]=  -1.0;           Re_Map[7]=   0.0;

```### Change:



### Change C: Added Im_8_QAM() function## 2. mimomap.c

Imaginary parts:

```c## Change 1: mimotype.h```c

Im_Map[0]=   1.0;           Im_Map[4]=   0.0;

Im_Map[1]=  -1.0;           Im_Map[5]=   1.0 + sqrt(3.0);  // 2.732### Change A: Modified Get_Map()

Im_Map[2]=   1.0;           Im_Map[6]=   0.0;

Im_Map[3]=  -1.0;           Im_Map[7]=  -1.0 - sqrt(3.0);  // -2.732Added QAM8 case:// BEFORE: Only QAM16, PSK8, BPSK, QPSK were defined

```

```c

**8-QAM Constellation Points:**

```else if(CONSTELL == QAM8)**What I did:** Added a new constant to define 8-QAM modulation

(1,1)  (1,-1)  (-1,1)  (-1,-1)  (2.732,0)  (0,2.732)  (-2.732,0)  (0,-2.732)

```{

Forms cross/diamond shape with d²_min = 4 ✓

  Re_8_QAM();// AFTER: Added QAM8 definition

---

  Im_8_QAM();

## 3. mimock.c

}**Location:** Line 20 (right after QPSK definition)#define QAM8 4                                       /* Constellation number. */

**Change:** Added QAM8 validation

```

Added check in Ck_Constell_Number():

``c``

else if((CONSTELL == QAM8) && (CONSTELL_SIZE != 8))

  Error_Mes(2);### Change B: Added Re_8_QAM() function

```

Real parts of 8-QAM constellation:**Before:**

---

```c

## 4. mimotheory_ser.c

Re_Map[0]=   1.0;           Re_Map[4]=   1.0 + sqrt(3.0);  // 2.732```c**Complete context (Lines 16-20):**

Six changes for theoretical bounds:

Re_Map[1]=   1.0;           Re_Map[5]=   0.0;

### A. Added QAM8 constant

```cRe_Map[2]=  -1.0;           Re_Map[6]=  -1.0 - sqrt(3.0);  // -2.732#define QAM16 0                                      /* Constellation number. */```c

#define QAM8 4

```Re_Map[3]=  -1.0;           Re_Map[7]=   0.0;



### B. Modified Get_Map()```#define PSK8 1                                       /* Constellation number. */#define QAM16 0                                      /* Constellation number. */

Added QAM8 case similar to mimomap.c



### C & D. Added mapping functions

- Get_Re_8_QAM_Map() - real parts### Change C: Added Im_8_QAM() function#define BPSK 2                                       /* Constellation number. */#define PSK8 1                                       /* Constellation number. */

- Get_Im_8_QAM_Map() - imaginary parts

Imaginary parts:

### E. Modified Open_File()

Added 4 cases for Union bound files:```c#define QPSK 3                                       /* Constellation number. */#define BPSK 2                                       /* Constellation number. */

```c

qam8r1t1thser.datIm_Map[0]=   1.0;           Im_Map[4]=   0.0;

qam8r2t1thser.dat

qam8r1t2thser.datIm_Map[1]=  -1.0;           Im_Map[5]=   1.0 + sqrt(3.0);  // 2.732```#define QPSK 3                                       /* Constellation number. */

qam8r2t2thser.dat

```Im_Map[2]=   1.0;           Im_Map[6]=   0.0;



### F. Modified Open_Chernoff()Im_Map[3]=  -1.0;           Im_Map[7]=  -1.0 - sqrt(3.0);  // -2.732#define QAM8 4                                       /* Constellation number. */

Added 4 cases for Chernoff bound files:

```c```

qam8r1t1chser.dat

qam8r2t1chser.dat**After:**```

qam8r1t2chser.dat

qam8r2t2chser.dat**8-QAM Constellation Points:**

```

``````c

---

(1,1)  (1,-1)  (-1,1)  (-1,-1)  (2.732,0)  (0,2.732)  (-2.732,0)  (0,-2.732)

## Simulation Results

```#define QAM16 0                                      /* Constellation number. */---

Four antenna configurations tested:

Forms cross/diamond shape with d²_min = 4 ✓

| Case | Config | Nr | Nt | SNR Range | Step | Points | NUM_VEC |

|------|--------|----|----|-----------|------|--------|---------|#define PSK8 1                                       /* Constellation number. */

| (a) | SISO | 1 | 1 | 5-55 dB | 5 dB | 11 | 8 |

| (b) | SIMO | 2 | 1 | 5-30 dB | 2.5 dB | 11 | 8 |---

| (c) | MISO | 1 | 2 | 5-55 dB | 5 dB | 11 | 64 |

| (d) | MIMO | 2 | 2 | 5-30 dB | 2.5 dB | 11 | 64 |#define BPSK 2                                       /* Constellation number. */## File 2: mimomap.c



All simulations completed successfully. Results match theoretical bounds.## 3. mimock.c



---#define QPSK 3                                       /* Constellation number. */



**Summary:**  **Change:** Added QAM8 validation

4 files modified • 12 marked changes • 8-QAM constellation verified • All tests passed

#define QAM8 4                                       /* Constellation number. */**Purpose:** Implement 8-QAM constellation mapping with cross/diamond topology

Added check in Ck_Constell_Number():

```c```

else if((CONSTELL == QAM8) && (CONSTELL_SIZE != 8))

  Error_Mes(2);### Change 1: Updated Get_Map() function

```

**Why:** The code needs a unique number to identify the 8-QAM modulation scheme. I chose 4 since 0-3 were already taken.

---

**Location:** Lines 30-50 (approximate)

## 4. mimotheory_ser.c

---

Six changes for theoretical bounds:

```c

### A. Added QAM8 constant

```c## Change 2: mimomap.c// BEFORE:

#define QAM8 4

```int Get_Map()



### B. Modified Get_Map()This file handles constellation mapping. I made three changes here.{

Added QAM8 case similar to mimomap.c

 if(CONSTELL == QAM16)

### C & D. Added mapping functions

- Get_Re_8_QAM_Map() - real parts### Change 2a: Modified Get_Map() function {

- Get_Im_8_QAM_Map() - imaginary parts

  Get_Re_16_QAM_Map();

### E. Modified Open_File()

Added 4 cases for Union bound files:**What I did:** Added a case to handle 8-QAM in the mapping function  Get_Im_16_QAM_Map();

```c

qam8r1t1thser.dat }

qam8r2t1thser.dat

qam8r1t2thser.dat**Before:** else if((CONSTELL == PSK8) || (CONSTELL == BPSK) || (CONSTELL == QPSK))

qam8r2t2thser.dat

``````c  Get_PSK_Map();



### F. Modified Open_Chernoff()int Get_Map() return(0);

Added 4 cases for Chernoff bound files:

```c{}

qam8r1t1chser.dat

qam8r2t1chser.dat if(CONSTELL == QAM16)

qam8r1t2chser.dat

qam8r2t2chser.dat {// AFTER: Added QAM8 case

```

  Get_Re_16_QAM_Map();int Get_Map()

---

  Get_Im_16_QAM_Map();{

## Simulation Results

 } if(CONSTELL == QAM16)

Four antenna configurations tested:

 else if((CONSTELL == PSK8) || (CONSTELL == BPSK) || (CONSTELL == QPSK)) {

| Case | Config | Nr | Nt | SNR Range | Step | Points | NUM_VEC |

|------|--------|----|----|-----------|------|--------|---------|  Get_PSK_Map();  Get_Re_16_QAM_Map();

| (a) | SISO | 1 | 1 | 5-55 dB | 5 dB | 11 | 8 |

| (b) | SIMO | 2 | 1 | 5-30 dB | 2.5 dB | 11 | 8 | return(0);  Get_Im_16_QAM_Map();

| (c) | MISO | 1 | 2 | 5-55 dB | 5 dB | 11 | 64 |

| (d) | MIMO | 2 | 2 | 5-30 dB | 2.5 dB | 11 | 64 |} }



All simulations completed successfully. Results match theoretical bounds.``` else if(CONSTELL == QAM8)



--- {



**Summary:**  **After:**  Re_8_QAM();

4 files modified • 12 marked changes • 8-QAM constellation verified • All tests passed

```c  Im_8_QAM();

int Get_Map() }

{ else if((CONSTELL == PSK8) || (CONSTELL == BPSK) || (CONSTELL == QPSK))

 if(CONSTELL == QAM16)  Get_PSK_Map();

 { return(0);

  Get_Re_16_QAM_Map();}

  Get_Im_16_QAM_Map();```

 }

 else if(CONSTELL == QAM8)### Change 2: Added Re_8_QAM() function

 {

  Re_8_QAM();**Location:** Lines 75-89 (approximate)

  Im_8_QAM();

 }```c

 else if((CONSTELL == PSK8) || (CONSTELL == BPSK) || (CONSTELL == QPSK))// NEW FUNCTION ADDED

  Get_PSK_Map();/******************************************************************************/

 return(0);/*              Get the real parts of the 8-QAM constellation.               */

}/*              Cross constellation with minimum squared Euclidean distance = 4 */

```/******************************************************************************/

int Re_8_QAM()

**Why:** When CONSTELL is set to QAM8, the code needs to call my new 8-QAM mapping functions.{

 Re_Map[0]=   1.0;

### Change 2b: Added Re_8_QAM() function Re_Map[1]=   1.0;

 Re_Map[2]=  -1.0;

**What I did:** Created a new function to define the real parts of my 8-QAM constellation Re_Map[3]=  -1.0;

 Re_Map[4]=   1.0 + sqrt(3.0);

```c Re_Map[5]=   0.0;

int Re_8_QAM() Re_Map[6]=  -1.0 - sqrt(3.0);

{ Re_Map[7]=   0.0;

 Re_Map[0]=   1.0; return(0);

 Re_Map[1]=   1.0;}

 Re_Map[2]=  -1.0;```

 Re_Map[3]=  -1.0;

 Re_Map[4]=   1.0 + sqrt(3.0);   // = 2.732**Constellation Points (Real parts):**

 Re_Map[5]=   0.0;- Indices 0-3: Diagonal points at ±1

 Re_Map[6]=  -1.0 - sqrt(3.0);   // = -2.732- Indices 4,6: Axis points at ±(1+√3) ≈ ±2.732

 Re_Map[7]=   0.0;- Indices 5,7: Origin (0) for imaginary axis points

 return(0);

}### Change 3: Added Im_8_QAM() function

```

**Location:** Lines 90-104 (approximate)

**Constellation Design:** 

- Points 0-3 are the diagonal corners at ±1```c

- Points 4 and 6 are on the real axis at ±2.732// NEW FUNCTION ADDED

- Points 5 and 7 have zero real part (they're on the imaginary axis)/******************************************************************************/

/*             Get the imaginary parts of the 8-QAM constellation.            */

### Change 2c: Added Im_8_QAM() function/*             Cross constellation with minimum squared Euclidean distance = 4 */

/******************************************************************************/

**What I did:** Created a new function to define the imaginary parts of my 8-QAM constellationint Im_8_QAM()

{

```c Im_Map[0]=   1.0;

int Im_8_QAM() Im_Map[1]=  -1.0;

{ Im_Map[2]=   1.0;

 Im_Map[0]=   1.0; Im_Map[3]=  -1.0;

 Im_Map[1]=  -1.0; Im_Map[4]=   0.0;

 Im_Map[2]=   1.0; Im_Map[5]=   1.0 + sqrt(3.0);

 Im_Map[3]=  -1.0; Im_Map[6]=   0.0;

 Im_Map[4]=   0.0; Im_Map[7]=  -1.0 - sqrt(3.0);

 Im_Map[5]=   1.0 + sqrt(3.0);   // = 2.732 return(0);

 Im_Map[6]=   0.0;}

 Im_Map[7]=  -1.0 - sqrt(3.0);   // = -2.732```

 return(0);

}**Constellation Points (Imaginary parts):**

```- Indices 0-3: Diagonal points at ±1

- Indices 4,6: Origin (0) for real axis points

**Complete 8-Point Constellation:**- Indices 5,7: Axis points at ±(1+√3) ≈ ±2.732

```

Point 0: ( 1.0,  1.0)  - top right diagonal**Complete 8-QAM Constellation (Index → Complex Point):**

Point 1: ( 1.0, -1.0)  - bottom right diagonal```

Point 2: (-1.0,  1.0)  - top left diagonalIndex 0: (1.0, 1.0)           - Diagonal quadrant I

Point 3: (-1.0, -1.0)  - bottom left diagonalIndex 1: (1.0, -1.0)          - Diagonal quadrant IV

Point 4: ( 2.732, 0.0) - right on real axisIndex 2: (-1.0, 1.0)          - Diagonal quadrant II

Point 5: ( 0.0,  2.732) - top on imaginary axisIndex 3: (-1.0, -1.0)         - Diagonal quadrant III

Point 6: (-2.732, 0.0) - left on real axisIndex 4: (2.732, 0.0)         - Positive real axis

Point 7: ( 0.0, -2.732) - bottom on imaginary axisIndex 5: (0.0, 2.732)         - Positive imaginary axis

```Index 6: (-2.732, 0.0)        - Negative real axis

Index 7: (0.0, -2.732)        - Negative imaginary axis

**Why this design:** ```

- It forms a cross/diamond shape

- Minimum distance between any two points squared = 4 (as required)**Verification:**

- For example: distance² between (1,1) and (1,-1) = 0² + 2² = 4 ✓- Minimum distance: d_min = 2 (e.g., from (1,1) to (1,-1))

- Average power = 4.732- Minimum squared distance: d²_min = 4 ✓

- Average power: P_avg = 4.732 (normalized)

---

---

## Change 3: mimock.c

## File 3: mimock.c

**What I did:** Added validation to check that constellation size matches for 8-QAM

**Purpose:** Add validation for 8-QAM constellation size

**Location:** In the Ck_Constell_Number() function (around line 40)

### Change:

**Before:**

```c**Location:** Lines 90-100 (approximate)

int Ck_Constell_Number()

{```c

 if((CONSTELL == BPSK) && (CONSTELL_SIZE != 2))// BEFORE:

  Error_Mes(2);int Ck_Constell_Number()

 else if((CONSTELL == QAM16) && (CONSTELL_SIZE != 16)){

  Error_Mes(2); if((CONSTELL == BPSK) && (CONSTELL_SIZE != 2))

 else if((CONSTELL == PSK8) && (CONSTELL_SIZE != 8))  Error_Mes(2);

  Error_Mes(2); else if((CONSTELL == QAM16) && (CONSTELL_SIZE != 16))

 else if((CONSTELL == QPSK) && (CONSTELL_SIZE != 4))  Error_Mes(2);

  Error_Mes(2); else if((CONSTELL == PSK8) && (CONSTELL_SIZE != 8))

 return(0);  Error_Mes(2);

} else if((CONSTELL == QPSK) && (CONSTELL_SIZE != 4))

```  Error_Mes(2);

 return(0);

**After:**}

```c

int Ck_Constell_Number()// AFTER: Added QAM8 validation

{int Ck_Constell_Number()

 if((CONSTELL == BPSK) && (CONSTELL_SIZE != 2)){

  Error_Mes(2); if((CONSTELL == BPSK) && (CONSTELL_SIZE != 2))

 else if((CONSTELL == QAM16) && (CONSTELL_SIZE != 16))  Error_Mes(2);

  Error_Mes(2); else if((CONSTELL == QAM16) && (CONSTELL_SIZE != 16))

 else if((CONSTELL == QAM8) && (CONSTELL_SIZE != 8))  Error_Mes(2);

  Error_Mes(2); else if((CONSTELL == QAM8) && (CONSTELL_SIZE != 8))

 else if((CONSTELL == PSK8) && (CONSTELL_SIZE != 8))  Error_Mes(2);

  Error_Mes(2); else if((CONSTELL == PSK8) && (CONSTELL_SIZE != 8))

 else if((CONSTELL == QPSK) && (CONSTELL_SIZE != 4))  Error_Mes(2);

  Error_Mes(2); else if((CONSTELL == QPSK) && (CONSTELL_SIZE != 4))

 return(0);  Error_Mes(2);

} return(0);

```}

```

**Why:** This validation ensures that if someone sets CONSTELL to QAM8, they must also set CONSTELL_SIZE to 8. Otherwise the simulation will give an error and exit.

**Purpose:** Ensures that when QAM8 is selected, exactly 8 constellation points are configured.

---

---

## Change 4: mimotheory_ser.c

## File 4: mimotheory_ser.c

This file computes the theoretical bounds. I made 6 changes here.

**Purpose:** Generate theoretical Union and Chernoff bounds for 8-QAM

### Change 4a: Added QAM8 define

### Change 1: Added QAM8 constant

**Location:** Line 17

**Location:** Lines 12-17

**Before:**

```c```c

#define QAM16 0// BEFORE: Only QAM16, PSK8, BPSK, QPSK

#define PSK8 1

#define BPSK 2// AFTER: Added QAM8

#define QPSK 3#define QAM16 0

```#define PSK8 1

#define BPSK 2

**After:**#define QPSK 3

```c#define QAM8 4                    // NEW LINE ADDED

#define QAM16 0```

#define PSK8 1

#define BPSK 2### Change 2: Updated Get_Map() function

#define QPSK 3

#define QAM8 4**Location:** Lines 130-145 (approximate)

```

```c

**Why:** The theory code also needs to know about QAM8 (same as mimotype.h).// BEFORE:

int Get_Map()

### Change 4b: Modified Get_Map() function{

 if(CONSTELL == QAM16)

**What I did:** Added QAM8 case (similar to change 2a) {

  Get_Re_16_QAM_Map();

**After:**  Get_Im_16_QAM_Map();

```c }

int Get_Map() else if((CONSTELL == PSK8) || (CONSTELL == BPSK) || (CONSTELL == QPSK))

{  Get_PSK_Map();

 if(CONSTELL == QAM16) return(0);

 {}

  Get_Re_16_QAM_Map();

  Get_Im_16_QAM_Map();// AFTER: Added QAM8 case

 }int Get_Map()

 else if(CONSTELL == QAM8){

 { if(CONSTELL == QAM16)

  Get_Re_8_QAM_Map(); {

  Get_Im_8_QAM_Map();  Get_Re_16_QAM_Map();

 }  Get_Im_16_QAM_Map();

 else if((CONSTELL == PSK8) || (CONSTELL == BPSK) || (CONSTELL == QPSK)) }

  Get_PSK_Map(); else if(CONSTELL == QAM8)

 return(0); {

}  Get_Re_8_QAM_Map();

```  Get_Im_8_QAM_Map();

 }

### Change 4c: Added Get_Re_8_QAM_Map() function else if((CONSTELL == PSK8) || (CONSTELL == BPSK) || (CONSTELL == QPSK))

  Get_PSK_Map();

**What I did:** Same constellation as in mimomap.c but for theory calculations return(0);

}

```c```

int Get_Re_8_QAM_Map()

{### Change 3: Added Get_Re_8_QAM_Map() function

 Re_Map[0]=   1.0;

 Re_Map[1]=   1.0;**Location:** Lines 192-206 (approximate)

 Re_Map[2]=  -1.0;

 Re_Map[3]=  -1.0;```c

 Re_Map[4]=   1.0 + sqrt(3.0);// NEW FUNCTION ADDED

 Re_Map[5]=   0.0;/******************************************************************************/

 Re_Map[6]=  -1.0 - sqrt(3.0);/*                     Get the 8QAM mapping -- real part.                     */

 Re_Map[7]=   0.0;/*                     Cross constellation with d_min^2 = 4                   */

 return(0);/******************************************************************************/

}int Get_Re_8_QAM_Map()

```{

 Re_Map[0]=   1.0;

### Change 4d: Added Get_Im_8_QAM_Map() function Re_Map[1]=   1.0;

 Re_Map[2]=  -1.0;

```c Re_Map[3]=  -1.0;

int Get_Im_8_QAM_Map() Re_Map[4]=   1.0 + sqrt(3.0);

{ Re_Map[5]=   0.0;

 Im_Map[0]=   1.0; Re_Map[6]=  -1.0 - sqrt(3.0);

 Im_Map[1]=  -1.0; Re_Map[7]=   0.0;

 Im_Map[2]=   1.0; return(0);

 Im_Map[3]=  -1.0;}

 Im_Map[4]=   0.0;```

 Im_Map[5]=   1.0 + sqrt(3.0);

 Im_Map[6]=   0.0;### Change 4: Added Get_Im_8_QAM_Map() function

 Im_Map[7]=  -1.0 - sqrt(3.0);

 return(0);**Location:** Lines 207-221 (approximate)

}

``````c

// NEW FUNCTION ADDED

### Change 4e: Modified Open_File() function/******************************************************************************/

/*                   Get the 8QAM mapping -- imaginary part.                  */

**What I did:** Added file output paths for 8-QAM union bound data/*                   Cross constellation with d_min^2 = 4                     */

/******************************************************************************/

**Before:** Only had file paths for QAM16, PSK8, BPSK, QPSKint Get_Im_8_QAM_Map()

{

**After:** Added these 4 lines: Im_Map[0]=   1.0;

```c Im_Map[1]=  -1.0;

 else if((CONSTELL == QAM8) && (NUM_RX == 1) && (NUM_TX == 1)) Im_Map[2]=   1.0;

  fp=fopen("mimodata/qam8r1t1thser.dat","w"); Im_Map[3]=  -1.0;

 else if((CONSTELL == QAM8) && (NUM_RX == 2) && (NUM_TX == 1)) Im_Map[4]=   0.0;

  fp=fopen("mimodata/qam8r2t1thser.dat","w"); Im_Map[5]=   1.0 + sqrt(3.0);

 else if((CONSTELL == QAM8) && (NUM_RX == 1) && (NUM_TX == 2)) Im_Map[6]=   0.0;

  fp=fopen("mimodata/qam8r1t2thser.dat","w"); Im_Map[7]=  -1.0 - sqrt(3.0);

 else if((CONSTELL == QAM8) && (NUM_RX == 2) && (NUM_TX == 2)) return(0);

  fp=fopen("mimodata/qam8r2t2thser.dat","w");}

``````

**Why:** The code needs to know where to save the union bound data for each 8-QAM configuration.### Change 5: Added file I/O for 8-QAM theoretical bounds

### Change 4f: Modified Open_Chernoff() function**Location:** Open_File() function, Lines 270-285 (approximate)

**What I did:** Added file output paths for 8-QAM Chernoff bound data```c

// ADDED THESE LINES to Open_File() function:

**After:** Added these 4 lines: else if((CONSTELL == QAM8) && (NUM_RX == 1) && (NUM_TX == 1))

```c

 else if((CONSTELL == QAM8) && (NUM_RX == 1) && (NUM_TX == 1)) else if((CONSTELL == QAM8) && (NUM_RX == 2) && (NUM_TX == 1))

  fp2=fopen("mimodata/qam8r1t1chser.dat","w");  fp=fopen("mimodata/qam8r2t1thser.dat","w");

 else if((CONSTELL == QAM8) && (NUM_RX == 2) && (NUM_TX == 1)) else if((CONSTELL == QAM8) && (NUM_RX == 1) && (NUM_TX == 2))

  fp2=fopen("mimodata/qam8r2t1chser.dat","w");  fp=fopen("mimodata/qam8r1t2thser.dat","w");

 else if((CONSTELL == QAM8) && (NUM_RX == 1) && (NUM_TX == 2)) else if((CONSTELL == QAM8) && (NUM_RX == 2) && (NUM_TX == 2))

  fp2=fopen("mimodata/qam8r1t2chser.dat","w");  fp=fopen("mimodata/qam8r2t2thser.dat","w");

 else if((CONSTELL == QAM8) && (NUM_RX == 2) && (NUM_TX == 2))```

  fp2=fopen("mimodata/qam8r2t2chser.dat","w");

```**Location:** Open_Chernoff() function, Lines 330-345 (approximate)



**Why:** Same as above but for Chernoff bound data files.```c

// ADDED THESE LINES to Open_Chernoff() function:

### Change 4g: Modified Ck_Constell_Number() function else if((CONSTELL == QAM8) && (NUM_RX == 1) && (NUM_TX == 1))

  fp2=fopen("mimodata/qam8r1t1chser.dat","w");

**What I did:** Added validation for 8-QAM (same as change 3) else if((CONSTELL == QAM8) && (NUM_RX == 2) && (NUM_TX == 1))

  fp2=fopen("mimodata/qam8r2t1chser.dat","w");

```c else if((CONSTELL == QAM8) && (NUM_RX == 1) && (NUM_TX == 2))

 else if((CONSTELL == QAM8) && (CONSTELL_SIZE != 8))  fp2=fopen("mimodata/qam8r1t2chser.dat","w");

  Error_Mes(2); else if((CONSTELL == QAM8) && (NUM_RX == 2) && (NUM_TX == 2))

```  fp2=fopen("mimodata/qam8r2t2chser.dat","w");

```

---

**Purpose:** Creates output files for Union bound (thser) and Chernoff bound (chser) for all 4 antenna configurations.

## Verification

### Change 6: Added QAM8 validation

To verify all changes are in place, you can search for the modification markers:

**Location:** Ck_Constell_Number() function

```bash

# Count modification markers in each file```c

grep -n "MODIFICATION START" mimotype.h// ADDED THIS LINE:

grep -n "MODIFICATION START" mimomap.c else if((CONSTELL == QAM8) && (CONSTELL_SIZE != 8))

grep -n "MODIFICATION START" mimock.c  Error_Mes(2);

grep -n "MODIFICATION START" mimotheory_ser.c```

```

---

You should find:

- `mimotype.h`: 1 modification block## File 5: mimofunctions.h
- `mimomap.c`: 2 modification blocks (for Get_Map and the two new functions)
- `mimock.c`: 1 modification block**Status:** No changes required
- `mimotheory_ser.c`: 6 modification blocks

The function declarations for `Re_8_QAM()` and `Im_8_QAM()` were already present in the original file:

Total: 10 modification markers across 4 files.```c

int Re_8_QAM(void);

---int Im_8_QAM(void);

```

## Testing

---

After making these changes, I tested by running:

## Simulation Results

1. Step 2a: 8-QAM with 1×1 antennas

2. Step 2b: 8-QAM with 2×1 antennasAll 4 cases were successfully simulated and verified:

3. Step 2c: 8-QAM with 1×2 antennas

4. Step 2d: 8-QAM with 2×2 antennas### Case (a): Nr=1, Nt=1

- **SNR Range:** 5 to 55 dB (step 5 dB) - 11 points

All simulations completed successfully and generated proper plots with simulation data, union bounds, and Chernoff bounds.- **Configuration:** SISO (Single Input Single Output)

- **NUM_VEC:** 8^1 = 8

---

### Case (b): Nr=2, Nt=1

**Summary:** I successfully added 8-QAM support by modifying 4 files with a total of 12 clearly marked changes. The cross constellation design achieves the required d²_min = 4 and all simulations produce valid results.- **SNR Range:** 5 to 30 dB (step 2.5 dB) - 11 points

- **Configuration:** SIMO (Single Input Multiple Output) - Receive diversity
- **NUM_VEC:** 8^1 = 8

### Case (c): Nr=1, Nt=2
- **SNR Range:** 5 to 55 dB (step 5 dB) - 11 points
- **Configuration:** MISO (Multiple Input Single Output) - Transmit diversity
- **NUM_VEC:** 8^2 = 64

### Case (d): Nr=2, Nt=2
- **SNR Range:** 5 to 30 dB (step 2.5 dB) - 11 points
- **Configuration:** MIMO (Multiple Input Multiple Output) - Full diversity
- **NUM_VEC:** 8^2 = 64

---

## Verification

### Mathematical Verification

**8-QAM Constellation Properties:**
- Total points: 8
- Diagonal points: (±1, ±1) - 4 points
- Axis points: (±2.732, 0) and (0, ±2.732) - 4 points

**Minimum Distance Calculations:**
```

d((1,1), (1,-1)) = √[(1-1)² + (1-(-1))²] = √4 = 2
d((1,1), (2.732,0)) = √[(1-2.732)² + (1-0)²] = √[3 + 1] = 2
d((2.732,0), (0,2.732)) = √[(2.732)² + (2.732)²] = 3.86 > 2

```

Therefore: **d_min = 2** and **d²_min = 4** ✓

**Average Power:**
```

P_avg = (4×(1²+1²) + 4×2.732²) / 8
      = (8 + 29.856) / 8
      = 4.732

```

### Simulation Verification

All simulations completed successfully with:
- Correct constellation points verified in logs
- SER decreases monotonically with SNR
- Simulation results lie between Union and Chernoff bounds
- All plots generated (PNG + EPS formats)

---

## Additional Files Created

### Automation Scripts
1. `run_step2a.sh` - Case (a) automation
2. `run_step2b.sh` - Case (b) automation
3. `run_step2c.sh` - Case (c) automation
4. `run_step2d.sh` - Case (d) automation
5. `generate_step2_plots.sh` - Standalone plotting utility

### Documentation
1. `CHANGES.md` - This file (code changes documentation)
2. `README.md` - Repository overview and usage instructions
3. `STEP2_PLAN.md` - Implementation plan and requirements

---

## End of Changes Documentation

**Date Modified:** November 5, 2025  
**Modification Purpose:** Add 8-QAM modulation support with d²_min = 4  
**Files Modified:** 4 files (mimotype.h, mimomap.c, mimock.c, mimotheory_ser.c)  
**Functions Added:** 4 functions (Re_8_QAM, Im_8_QAM, Get_Re_8_QAM_Map, Get_Im_8_QAM_Map)  
**Lines Added:** Approximately 150 lines across all files
```
