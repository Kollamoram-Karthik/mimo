/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "mimofunctions.h"
/******************************************************************************/
/*                    SIMULATION RUN LENGTH PARAMETER.
*******************************************************************************/
#define MAX_VEC 100000000         /* Length of simulation run in tx. vectors. */
/******************************************************************************/
/*                         CONSTELLATION PARAMETERS.
*******************************************************************************/
#define QAM16 0                                      /* Constellation number. */
#define PSK8 1                                       /* Constellation number. */
#define BPSK 2                                       /* Constellation number. */
#define QPSK 3                                       /* Constellation number. */
/****** MODIFICATION START: Added 8-QAM support (Nov 2025) *******************/
#define QAM8 4                                       /* Constellation number. */
/****** MODIFICATION END ******************************************************/
#define CONSTELL QAM8
#define BITS_PER_SYM 3
#define CONSTELL_SIZE 8
#define NUM_TX 2
#define NUM_RX 1
#define NUM_VEC 64
/******************************************************************************/
/*                  GAUSSIAN NOISE GENERATOR PARAMETERS.
*******************************************************************************/
#define FADE_VAR 0.50                         /* Fade variance per dimension. */
#define SNR 40
#define MAX_SNR 100.0                                   /* Max. value of SNR. */
#define PN_SIZE 3                 /* Size of array which stores the PN value. */
#define NVALSIZE 4
#define URADIUS 0
#define UTHETA 1
#define GRAND_0 2
#define GRAND_1 3
/******************************************************************************/
/*                             CONSTANTS.
*******************************************************************************/
#define BINSIZE 16         /* Size of array to store states in binary format. */
#define TWO 2
#define ONE 1
#define ZERO 0
#define TRUE 1
#define FALSE 0
#define LEFT 0
#define RIGHT 1
#define RE 0
#define IM 1
#define MINUSONE (-1)
#define ERROR 0.000001
#define FRAC_ZERO 0.0
#define MIN_MAG (-10.0)
#define MAX_MAG (100000000.0)
#define MY_PI 3.14159265358979323846
#define PIBY2 1.57079632679489661923
#define PIBY4 0.785398163397448309615
#define TWICEPI 6.28318530717958647692
/******************************************************************************/
