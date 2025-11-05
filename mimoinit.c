/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
#include "mimotype.h"
#include "mimoext.h"
/******************************************************************************/
/*                   Initialize simulation variables.
*******************************************************************************/
int Sim_Init()
{
 Noise_Gen_Init();
 Fade_Gen_Init();
 Ser_Init();
 Noise_Var_Init();
 return(0);
}
/******************************************************************************/
/*                     Initialize the noise generator.
*******************************************************************************/
int Noise_Gen_Init()
{
 int cnt;
 long int random(void);
 for(cnt=ZERO;cnt<PN_SIZE;cnt++)
 {
  N1_Store[cnt]=(unsigned short)random();
  N2_Store[cnt]=(unsigned short)random();
 }
 return(0);
}
/******************************************************************************/
/*                     Initialize the fade generator.
*******************************************************************************/
int Fade_Gen_Init()
{
 int cnt;
 long int random(void);
 for(cnt=ZERO;cnt<PN_SIZE;cnt++)
 {
  F1_Store[cnt]=(unsigned short)random();
  F2_Store[cnt]=(unsigned short)random();
 }
 return(0);
}
/******************************************************************************/
/*                       Initialize the symbol error rate.
*******************************************************************************/
int Ser_Init()
{
 int cnt;
 Vec_Ser=Ser=ZERO;
 for(cnt=ZERO;cnt<CONSTELL_SIZE;cnt++)
  Occur[cnt]=ZERO;
 Power=0.0;
 return(0);
}
/******************************************************************************/
/* Initialize the noise variance. Fade variance over 2D is unity.
 * Average SNR over 2D = (NUM_TX*power)/(2*Noise_Var).
 * No. of bits transmitted over 2D = NUM_TX*BITS_PER_SYM/NUM_RX = 2C.
 * Average SNR per bit over 2D = Average SNR over 2D/(2C)
 *                             = (NUM_RX*power)/(2*Noise_Var*BITS_PER_SYM).
*******************************************************************************/
int Noise_Var_Init()
{
 int cnt;
 double power;
 power=0.0;
 for(cnt=ZERO;cnt<CONSTELL_SIZE;cnt++)
  power=power+Re_Map[cnt]*Re_Map[cnt]+Im_Map[cnt]*Im_Map[cnt];
 power=power/(double)CONSTELL_SIZE;
 Noise_Var=NUM_RX*power/(2.0*(double)BITS_PER_SYM*pow(10.0,0.1*SNR));
 if(SNR > MAX_SNR)
  Noise_Var=0.0;
 printf("\t Noise variance:%lf.\n\n",Noise_Var);
 return(0);
}
/******************************************************************************/
