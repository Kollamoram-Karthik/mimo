/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
/*                          COUNTER VARIABLES.
*******************************************************************************/
extern long Vec_Cnt;                                         /* Vector count. */
extern long Ser;                                        /* Symbol error rate. */
/******************************************************************************/
/*                         SYMBOL VECTOR VARIABLES.
*******************************************************************************/
extern int Vec_Inx;                                   /* Symbol vector index. */
extern int Vec_Ser;                              /* Symbol vector error rate. */
/******************************************************************************/
/*                       MAP TO CONSTELLATION VARIABLES.
*******************************************************************************/
extern int Bits[BITS_PER_SYM];                            /* Stores the bits. */
extern int Sym_Inx[NUM_TX];                    /* Index to the constellation. */
extern long Occur[CONSTELL_SIZE];        /* Counts no. of occurrences of inx. */
extern double Re_Map[CONSTELL_SIZE];                  /* Re. part of symbols. */
extern double Im_Map[CONSTELL_SIZE];                  /* Im. part of symbols. */
/******************************************************************************/
/*                            TRANSMITTED SYMBOLS.
*******************************************************************************/
extern double Re_Sym[NUM_TX];          /* Re. part of the transmitted symbol. */
extern double Im_Sym[NUM_TX];          /* Im. part of the transmitted symbol. */
extern double Power;                            /* Transmit power after fade. */
extern double Rx_Re_Sym[NUM_RX];              /* Re. part of received symbol. */
extern double Rx_Im_Sym[NUM_RX];              /* Im. part of received symbol. */
/******************************************************************************/
/*                       NOISE GENERATOR VARIABLES.
*******************************************************************************/
extern unsigned short N1_Store[PN_SIZE];                /* Stores PNS status. */
extern unsigned short N2_Store[PN_SIZE];                /* Stores PNS status. */
extern double Noise_Var;                                   /* Noise variance. */
extern double N1_Val[NVALSIZE];                  /* Contains U & G rand. var. */
/******************************************************************************/
/*                       FADE GENERATOR VARIABLES.
*******************************************************************************/
extern unsigned short F1_Store[PN_SIZE];                /* Stores PNS status. */
extern unsigned short F2_Store[PN_SIZE];                /* Stores PNS status. */
extern double F1_Val[NVALSIZE];                  /* Contains U & G rand. var. */
extern double Re_Fade[NUM_RX][NUM_TX];                   /* Re. part of fade. */
extern double Im_Fade[NUM_RX][NUM_TX];                   /* Im. part of fade. */
/******************************************************************************/
