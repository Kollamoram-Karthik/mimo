/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
/*                          COUNTER VARIABLES.
*******************************************************************************/
long Vec_Cnt;                                                /* Vector count. */
long Ser;                                               /* Symbol error rate. */
/******************************************************************************/
/*                         SYMBOL VECTOR VARIABLES.
*******************************************************************************/
int Vec_Inx;                                          /* Symbol vector index. */
int Vec_Ser;                                     /* Symbol vector error rate. */
/******************************************************************************/
/*                       MAP TO CONSTELLATION VARIABLES.
*******************************************************************************/
int Bits[BITS_PER_SYM];                                   /* Stores the bits. */
int Sym_Inx[NUM_TX];                           /* Index to the constellation. */
long Occur[CONSTELL_SIZE];               /* Counts no. of occurrences of inx. */
double Re_Map[CONSTELL_SIZE];                         /* Re. part of symbols. */
double Im_Map[CONSTELL_SIZE];                         /* Im. part of symbols. */
/******************************************************************************/
/*                            TRANSMITTED SYMBOLS.
*******************************************************************************/
double Re_Sym[NUM_TX];                 /* Re. part of the transmitted symbol. */
double Im_Sym[NUM_TX];                 /* Im. part of the transmitted symbol. */
double Power;                                   /* Transmit power after fade. */
double Rx_Re_Sym[NUM_RX];                     /* Re. part of received symbol. */
double Rx_Im_Sym[NUM_RX];                     /* Im. part of received symbol. */
/******************************************************************************/
/*                       NOISE GENERATOR VARIABLES.
*******************************************************************************/
unsigned short N1_Store[PN_SIZE];                       /* Stores PNS status. */
unsigned short N2_Store[PN_SIZE];                       /* Stores PNS status. */
double Noise_Var;                                          /* Noise variance. */
double N1_Val[NVALSIZE];                         /* Contains U & G rand. var. */
/******************************************************************************/
/*                       FADE GENERATOR VARIABLES.
*******************************************************************************/
unsigned short F1_Store[PN_SIZE];                       /* Stores PNS status. */
unsigned short F2_Store[PN_SIZE];                       /* Stores PNS status. */
double F1_Val[NVALSIZE];                         /* Contains U & G rand. var. */
double Re_Fade[NUM_RX][NUM_TX];                          /* Re. part of fade. */
double Im_Fade[NUM_RX][NUM_TX];                          /* Im. part of fade. */
/******************************************************************************/
