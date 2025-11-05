/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
#include "mimotype.h"
#include "mimoext.h"
/******************************************************************************/
/*                          Check the variables.
*******************************************************************************/
int Ck_Var()
{
 Ck_Tx_Constell_Size();
 Ck_Constell_Number();
 Ck_Num_Vec();
 return(0);
}
/******************************************************************************/
/*                Check the transmitted constellation size.
*******************************************************************************/
int Ck_Tx_Constell_Size()
{
 int cnt,my_pow;
 my_pow=1;
 for(cnt=ZERO;cnt<BITS_PER_SYM;cnt++)
  my_pow=my_pow*2;
 if(CONSTELL_SIZE != my_pow)
  Error_Mes(2);
 return(0);
}
/******************************************************************************/
/*                      Check the constellation number.
*******************************************************************************/
int Ck_Constell_Number()
{
 if((CONSTELL == BPSK) && (CONSTELL_SIZE != 2))
  Error_Mes(2);
 else if((CONSTELL == QAM16) && (CONSTELL_SIZE != 16))
  Error_Mes(2);
 else if((CONSTELL == PSK8) && (CONSTELL_SIZE != 8))
  Error_Mes(2);
 else if((CONSTELL == QPSK) && (CONSTELL_SIZE != 4))
  Error_Mes(2);
 return(0);
}
/******************************************************************************/
/*                       Check the number of vectors.
*******************************************************************************/
int Ck_Num_Vec()
{
 int cnt,my_pow;
 my_pow=1;
 for(cnt=ZERO;cnt<NUM_TX;cnt++)
  my_pow=my_pow*CONSTELL_SIZE;
 if(NUM_VEC != my_pow)
  Error_Mes(3);
 return(0);
}
/******************************************************************************/
