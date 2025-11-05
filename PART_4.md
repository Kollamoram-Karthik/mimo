# Part 4: MAX_VEC Constant Identification

## Question
Identify the constant corresponding to the number of vectors simulated, in mimotype.h

## Answer

**Constant:** `MAX_VEC`  
**File:** `mimotype.h`  
**Line:** 13  
**Value:** `100000000` (100 million)

```c
#define MAX_VEC 100000000         /* Length of simulation run in tx. vectors. */
```

---

## What It Does

MAX_VEC controls the number of transmitted vectors in each Monte Carlo simulation run.

**In the code:**
```c
for(vec_cnt=0; vec_cnt<MAX_VEC; vec_cnt++)
{
    // Transmit symbol, add noise, detect, count errors
}

SER = (Number of errors) / MAX_VEC
```

---

## Why 100 Million?

- **Accuracy:** Need enough vectors to measure low error rates (down to 10^-6)
- **Statistics:** At SER=10^-6, need ~100M vectors to get ~100 error events
- **Trade-off:** More vectors = more accurate but slower

**Runtime:** ~5-10 minutes per SNR point with this value

---

## Impact on My Simulations

| Step | SNR Points | Total Vectors | Time |
|------|-----------|---------------|------|
| Step 1 | 13 | 1.3 billion | ~1.5 hrs |
| Step 2 | 44 | 4.4 billion | ~6-8 hrs |

---

## Summary

MAX_VEC (line 13, mimotype.h) = 100,000,000 vectors per simulation  
Controls Monte Carlo sample size for statistical accuracy.
