/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
/* Theoretical error-rate results for symbol vectors in Rayleigh flat fading
 * channels. Fade variance per dimension is assumed to be 0.5.
*******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
/******************************************************************************/
#define QAM16 0
#define PSK8 1
#define BPSK 2
#define QPSK 3
#define CONSTELL QAM16
#define MIN_SNR 5.0
#define MAX_SNR 35.5
#define STEP 0.5
#define ONE 1
#define ZERO 0
#define CONSTELL_SIZE 16
#define BITS_PER_SYM 4
#define NUM_TX 2                                 /* No. of transmit antennas. */
#define NUM_RX 2                                  /* No. of receive antennas. */
#define NUM_VEC 256                                  /* CONSTELL_SIZE^NUM_TX. */
/******************************************************************************/
FILE *fp,*fp2;
double Snr;                                                     /* SNR in dB. */
double Snr_db;
double Var;                                                /* Noise variance. */
double Mu;
double Pe;                                     /* Avg. prob. of symbol error. */
double Pav;                               /* Avg. power of the constellation. */
double Re_Map[CONSTELL_SIZE];                                     /* Re. map. */
double Im_Map[CONSTELL_SIZE];                                     /* Im. map. */
/******************************************************************************/
/*                        Function declarations.
*******************************************************************************/
int main(void);
int Ck_Var(void);
int Get_Map(void);
int Get_Pav(void);
int Open_File(void);
int Open_Chernoff(void);
int Write_UB(void);
int Write_Chernoff(void);
int Ck_Tx_Constell_Size(void);
int Ck_Constell_Number(void);
int Ck_Num_Vec(void);
int Error_Mes(int num);
int Get_Re_16_QAM_Map(void);
int Get_Im_16_QAM_Map(void);
int Get_PSK_Map(void);
int Decimal_to_M_ary(int num,int *array,int array_size,int m_ary);
int Update_Pe_Avg(double gamma);
/******************************************************************************/
/*                             Main program.
*******************************************************************************/
int main()
{
 Ck_Var();
 Get_Map();
 Get_Pav();
 Open_File();
 Open_Chernoff();
 Write_UB();
 Write_Chernoff();
 return(0);
}
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
 int cnt,pow;
 pow=1;
 for(cnt=ZERO;cnt<BITS_PER_SYM;cnt++)
  pow=pow*2;
 if(CONSTELL_SIZE != pow)
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
/*                         Get the constellation.
*******************************************************************************/
int Get_Map()
{
 if(CONSTELL == QAM16)
 {
  Get_Re_16_QAM_Map();
  Get_Im_16_QAM_Map();
 }
 else if((CONSTELL == PSK8) || (CONSTELL == BPSK) || (CONSTELL == QPSK))
  Get_PSK_Map();
 return(0);
}
/******************************************************************************/
/*                     Get the 16QAM mapping -- real part.
*******************************************************************************/
int Get_Re_16_QAM_Map()
{
 Re_Map[0]=   1.0;
 Re_Map[1]=   3.0;
 Re_Map[2]=   3.0;
 Re_Map[3]=   1.0;
 Re_Map[4]=  -1.0;
 Re_Map[5]=  -1.0;
 Re_Map[6]=  -3.0;
 Re_Map[7]=  -3.0;
 Re_Map[8]=  -1.0;
 Re_Map[9]=  -3.0;
 Re_Map[10]= -3.0;
 Re_Map[11]= -1.0;
 Re_Map[12]=  1.0;
 Re_Map[13]=  1.0;
 Re_Map[14]=  3.0;
 Re_Map[15]=  3.0;
 return(0);
}
/******************************************************************************/
/*                   Get the 16QAM mapping -- imaginary part.
*******************************************************************************/
int Get_Im_16_QAM_Map()
{
 Im_Map[0]=   1.0;
 Im_Map[1]=   1.0;
 Im_Map[2]=   3.0;
 Im_Map[3]=   3.0;
 Im_Map[4]=   1.0;
 Im_Map[5]=   3.0;
 Im_Map[6]=   3.0;
 Im_Map[7]=   1.0;
 Im_Map[8]=  -1.0;
 Im_Map[9]=  -1.0;
 Im_Map[10]= -3.0;
 Im_Map[11]= -3.0;
 Im_Map[12]= -1.0;
 Im_Map[13]= -3.0;
 Im_Map[14]= -3.0;
 Im_Map[15]= -1.0;
 return(0);
}
/******************************************************************************/
/*               Get the PSK constellation. Gray coding not done.
*******************************************************************************/
int Get_PSK_Map()
{
 int cnt;
 double theta;
 for(cnt=ZERO;cnt<CONSTELL_SIZE;cnt++)
 {
  theta=2.0*M_PI*(double)cnt/(double)CONSTELL_SIZE;
  Re_Map[cnt]=cos(theta);
  Im_Map[cnt]=sin(theta);
 }
 return(0);
}
/******************************************************************************/
/*            Get the average power of the constellation.
*******************************************************************************/
int Get_Pav()
{
 int cnt;
 Pav=0.0;
 for(cnt=ZERO;cnt<CONSTELL_SIZE;cnt++)
  Pav=Pav+Re_Map[cnt]*Re_Map[cnt]+Im_Map[cnt]*Im_Map[cnt];
 Pav=Pav/(double)CONSTELL_SIZE;
 return(0);
}
/******************************************************************************/
/*                         Open file for writing data.
*******************************************************************************/
int Open_File()
{
 if((CONSTELL == QAM16) && (NUM_RX == 1) && (NUM_TX == 1))
  fp=fopen("mimodata/qam16r1t1th.dat","w");
 else if((CONSTELL == QAM16) && (NUM_RX == 2) && (NUM_TX == 1))
  fp=fopen("mimodata/qam16r2t1th.dat","w");
 else if((CONSTELL == QAM16) && (NUM_RX == 1) && (NUM_TX == 2))
  fp=fopen("mimodata/qam16r1t2th.dat","w");
 else if((CONSTELL == QAM16) && (NUM_RX == 2) && (NUM_TX == 2))
  fp=fopen("mimodata/qam16r2t2th.dat","w");
 else if((CONSTELL == PSK8) && (NUM_RX == 1) && (NUM_TX == 1))
  fp=fopen("mimodata/psk8r1t1th.dat","w");
 else if((CONSTELL == PSK8) && (NUM_RX == 2) && (NUM_TX == 1))
  fp=fopen("mimodata/psk8r2t1th.dat","w");
 else if((CONSTELL == PSK8) && (NUM_RX == 1) && (NUM_TX == 2))
  fp=fopen("mimodata/psk8r1t2th.dat","w");
 else if((CONSTELL == PSK8) && (NUM_RX == 2) && (NUM_TX == 2))
  fp=fopen("mimodata/psk8r2t2th.dat","w");
 else if((CONSTELL == BPSK) && (NUM_RX == 1) && (NUM_TX == 1))
  fp=fopen("mimodata/bpskr1t1th.dat","w");
 else if((CONSTELL == BPSK) && (NUM_RX == 2) && (NUM_TX == 1))
  fp=fopen("mimodata/bpskr2t1th.dat","w");
 else if((CONSTELL == BPSK) && (NUM_RX == 1) && (NUM_TX == 2))
  fp=fopen("mimodata/bpskr1t2th.dat","w");
 else if((CONSTELL == BPSK) && (NUM_RX == 2) && (NUM_TX == 2))
  fp=fopen("mimodata/bpskr2t2th.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 1) && (NUM_TX == 1))
  fp=fopen("mimodata/qpskr1t1th.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 2) && (NUM_TX == 1))
  fp=fopen("mimodata/qpskr2t1th.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 1) && (NUM_TX == 2))
  fp=fopen("mimodata/qpskr1t2th.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 2) && (NUM_TX == 2))
  fp=fopen("mimodata/qpskr2t2th.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 4) && (NUM_TX == 4))
  fp=fopen("mimodata/qpskr4t4th.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 4) && (NUM_TX == 2))
  fp=fopen("mimodata/qpskr4t2th.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 4) && (NUM_TX == 1))
  fp=fopen("mimodata/qpskr4t1th.dat","w");
 if(fp == NULL)
  fprintf(stderr,"Directory does not exist. Exit.\n\n");
 return(0);
}
/******************************************************************************/
/*   Open file for writing the probability of error using Chernoff bound.
*******************************************************************************/
int Open_Chernoff()
{
 if((CONSTELL == QAM16) && (NUM_RX == 1) && (NUM_TX == 1))
  fp2=fopen("mimodata/qam16r1t1ch.dat","w");
 else if((CONSTELL == QAM16) && (NUM_RX == 2) && (NUM_TX == 1))
  fp2=fopen("mimodata/qam16r2t1ch.dat","w");
 else if((CONSTELL == QAM16) && (NUM_RX == 1) && (NUM_TX == 2))
  fp2=fopen("mimodata/qam16r1t2ch.dat","w");
 else if((CONSTELL == QAM16) && (NUM_RX == 2) && (NUM_TX == 2))
  fp2=fopen("mimodata/qam16r2t2ch.dat","w");
 else if((CONSTELL == PSK8) && (NUM_RX == 1) && (NUM_TX == 1))
  fp2=fopen("mimodata/psk8r1t1ch.dat","w");
 else if((CONSTELL == PSK8) && (NUM_RX == 2) && (NUM_TX == 1))
  fp2=fopen("mimodata/psk8r2t1ch.dat","w");
 else if((CONSTELL == PSK8) && (NUM_RX == 1) && (NUM_TX == 2))
  fp2=fopen("mimodata/psk8r1t2ch.dat","w");
 else if((CONSTELL == PSK8) && (NUM_RX == 2) && (NUM_TX == 2))
  fp2=fopen("mimodata/psk8r2t2ch.dat","w");
 else if((CONSTELL == BPSK) && (NUM_RX == 1) && (NUM_TX == 1))
  fp2=fopen("mimodata/bpskr1t1ch.dat","w");
 else if((CONSTELL == BPSK) && (NUM_RX == 2) && (NUM_TX == 1))
  fp2=fopen("mimodata/bpskr2t1ch.dat","w");
 else if((CONSTELL == BPSK) && (NUM_RX == 1) && (NUM_TX == 2))
  fp2=fopen("mimodata/bpskr1t2ch.dat","w");
 else if((CONSTELL == BPSK) && (NUM_RX == 2) && (NUM_TX == 2))
  fp2=fopen("mimodata/bpskr2t2ch.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 1) && (NUM_TX == 1))
  fp2=fopen("mimodata/qpskr1t1ch.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 2) && (NUM_TX == 1))
  fp2=fopen("mimodata/qpskr2t1ch.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 1) && (NUM_TX == 2))
  fp2=fopen("mimodata/qpskr1t2ch.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 2) && (NUM_TX == 2))
  fp2=fopen("mimodata/qpskr2t2ch.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 4) && (NUM_TX == 4))
  fp2=fopen("mimodata/qpskr4t4ch.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 4) && (NUM_TX == 2))
  fp2=fopen("mimodata/qpskr4t2ch.dat","w");
 else if((CONSTELL == QPSK) && (NUM_RX == 4) && (NUM_TX == 1))
  fp2=fopen("mimodata/qpskr4t1ch.dat","w");
 if(fp2 == NULL)
  fprintf(stderr,"Directory does not exist. Exit.\n\n");
 return(0);
}
/******************************************************************************/
/*                           Compute the factorial.
*******************************************************************************/
int Get_Factorial(int num)
//int num;
{
 int fac,cnt;
 fac=ONE;
 if(num < ZERO)
  fprintf(stderr,"Factorial of a negative number. Exit.\n\n");
 for(cnt=ONE;cnt<=num;cnt++)
  fac=fac*cnt;
 return(fac);
}
/******************************************************************************/
/*          Write data to file. Error computation using union bound.
*******************************************************************************/
int Write_UB()
{
 int cnt2,cnt3,cnt4,array1[NUM_TX],array2[NUM_TX];
 double dist,gamma,re_err,im_err,div;
 div=(double)NUM_RX;
 Snr_db=MIN_SNR;
 while(Snr_db < MAX_SNR)
 {
  Snr=pow(10.0,0.1*Snr_db);
  Var=div*Pav/(2.0*(double)BITS_PER_SYM*Snr);           /* Noise var per dim. */
  Pe=0.0;
  for(cnt2=ZERO;cnt2<NUM_VEC;cnt2++)
  {
   for(cnt3=ZERO;cnt3<NUM_VEC;cnt3++)
   {
    if(cnt3 != cnt2)
    {
     Decimal_to_M_ary(cnt2,array1,NUM_TX,CONSTELL_SIZE);
     Decimal_to_M_ary(cnt3,array2,NUM_TX,CONSTELL_SIZE);
     dist=0.0;
     for(cnt4=ZERO;cnt4<NUM_TX;cnt4++)
     {
      re_err=Re_Map[array1[cnt4]]-Re_Map[array2[cnt4]];
      im_err=Im_Map[array1[cnt4]]-Im_Map[array2[cnt4]];
      dist=dist+re_err*re_err+im_err*im_err;       /* Sq. Euclidean distance. */
     }
     gamma=dist/(8.0*Var);                        /* Fade var per dim is 0.5. */
     Update_Pe_Avg(gamma);
    }
   }
  }
  Pe=Pe/(double)NUM_VEC;
  fprintf(fp,"%16.12lf %16.12lf\n",Snr_db,Pe);
  Snr_db=Snr_db+STEP;
 }
 return(0);
}
/******************************************************************************/
/*         Update the probability of error for a particular distance.
*******************************************************************************/
int Update_Pe_Avg(double gamma)
//double gamma;
{
 int cnt,cnt1;
 double sum,fac,two_pow,gamma_pow,numer,mu;
 mu=sqrt(gamma/(1.0+gamma));
 sum=0.0;
 numer=fac=1.0;
 two_pow=2.0;
 gamma_pow=1.0+gamma;
 for(cnt=ONE;cnt<=NUM_RX-ONE;cnt++)
 {
  numer=1.0;
  for(cnt1=2;cnt1<=cnt;cnt1++)
   numer=numer*(double)(2*cnt1-ONE);
  sum=sum+numer/(fac*two_pow*gamma_pow);
  fac=fac*(double)(cnt+ONE);
  two_pow=two_pow*2.0;
  gamma_pow=gamma_pow*(1.0+gamma);
 }
 Pe=Pe+0.5*(1.0-mu)-0.5*mu*sum;
 return(0);
}
/******************************************************************************/
/*         Write data to file. Error computation using Chernoff bound.
*******************************************************************************/
int Write_Chernoff()
{
 int cnt2,cnt3,cnt4,array1[NUM_TX],array2[NUM_TX];
 double dist,gamma,re_err,im_err,div;
 div=(double)NUM_RX;
 Snr_db=MIN_SNR;
 while(Snr_db < MAX_SNR)
 {
  Snr=pow(10.0,0.1*Snr_db);
  Var=div*Pav/(2.0*(double)BITS_PER_SYM*Snr);           /* Noise var per dim. */
  Pe=0.0;
  for(cnt2=ZERO;cnt2<NUM_VEC;cnt2++)
  {
   for(cnt3=ZERO;cnt3<NUM_VEC;cnt3++)
   {
    if(cnt3 != cnt2)
    {
     Decimal_to_M_ary(cnt2,array1,NUM_TX,CONSTELL_SIZE);
     Decimal_to_M_ary(cnt3,array2,NUM_TX,CONSTELL_SIZE);
     dist=0.0;
     for(cnt4=ZERO;cnt4<NUM_TX;cnt4++)
     {
      re_err=Re_Map[array1[cnt4]]-Re_Map[array2[cnt4]];
      im_err=Im_Map[array1[cnt4]]-Im_Map[array2[cnt4]];
      dist=dist+re_err*re_err+im_err*im_err;       /* Sq. Euclidean distance. */
     }
     gamma=dist/(8.0*Var);                        /* Fade var per dim is 0.5. */
     Pe=Pe+1.0/pow(1.0+gamma,(double)NUM_RX);
    }
   }
  }
  Pe=Pe/(double)NUM_VEC;
  fprintf(fp2,"%16.12lf %16.12lf\n",Snr_db,Pe);
  Snr_db=Snr_db+STEP;
 }
 return(0);
}
/******************************************************************************/
/*                         Convert decimal to M-ary.
*******************************************************************************/
int Decimal_to_M_ary(int num,int *array,int array_size,int m_ary)
//int num,array[],array_size,m_ary;
{
 int cnt;
 for(cnt=ZERO;cnt<array_size;cnt++)
  array[cnt]=ZERO;
 cnt=ZERO;
 while(num>ZERO)
 {
  if(cnt == array_size)
   Error_Mes(1);
  array[cnt]=num%m_ary;
  num=(int)(num/m_ary);
  cnt++;
 }
 return(0);
}
/******************************************************************************/
/*                             Error message.
*******************************************************************************/
int Error_Mes(int num)
//int num;
{
 fprintf(stdout,"\t Simulation error. Exiting with code %d.\n\n",num);
 exit(num);
 return(0);
}
/******************************************************************************/
