/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
#include "mimotype.h"
#include "mimoext.h"
/******************************************************************************/
int Post_Processor()
{
 printf("\t SER: %12.10lf.\n\n",(double)Ser/((double)(Vec_Cnt*NUM_TX)));
 printf("\t No. of vector errors is: %d.\n\n",Vec_Ser);
 printf("\t Vectors transmitted:%ld\n\n",Vec_Cnt);
 printf("\t Symbols transmitted:%ld\n\n",Vec_Cnt*NUM_TX);
 Power=Power/(double)(Vec_Cnt*NUM_RX);
 printf("\t Avg. transmit power after fade is: %lf.\n\n",Power);
 return(0);
}
/******************************************************************************/
