/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
#include "mimotype.h"
#include "mimoext.h"
/******************************************************************************/
/*                         Convert decimal to binary.
*******************************************************************************/
int Decimal_to_Binary(int num,int *array,int array_size)
//int num,array[],array_size;
{
 int cnt;
 for(cnt=ZERO;cnt<array_size;cnt++)
  array[cnt]=ZERO;
 cnt=ZERO;
 while(num>ZERO)
 {
  if(cnt == array_size)
   Error_Mes(1);
  array[cnt]=num&1;
  num=num>>1;
  cnt++;
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
/*               Convert the 1s to -1s suitable for xoring.
*******************************************************************************/
int Convert_for_Xor(int *array,int size)
//int array[],size;
{
 int cnt;
 for(cnt=ZERO;cnt<size;cnt++)
 {
  if(array[cnt] == ONE)
   array[cnt]= MINUSONE;
 }
 return(0);
}
/******************************************************************************/
/*                Convert the state back to 1s and 0s format.
*******************************************************************************/
int Convert_Back_to_Binary(int *array,int size)
//int array[],size;
{
 int cnt;
 for(cnt=ZERO;cnt<size;cnt++)
 {
  if(array[cnt] == MINUSONE)
   array[cnt]=ONE;
 }
 return(0);
}
/******************************************************************************/
/*                    Convert binary array to decimal.
*******************************************************************************/
int Binary_to_Decimal(int *array,int size)
//int array[],size;
{
 int cnt,pow,sum;
 sum=ZERO;
 pow=1;
 for(cnt=ZERO;cnt<size;cnt++)
 {
  sum=sum+pow*array[cnt];
  pow=pow<<1;
 }
 return(sum);
}
/******************************************************************************/
/*                    Convert M-ary array to decimal.
*******************************************************************************/
int M_ary_to_Decimal(int *array,int size)
//int array[],size;
{
 int cnt,my_pow,sum;
 sum=ZERO;
 my_pow=1;
 for(cnt=ZERO;cnt<size;cnt++)
 {
  sum=sum+my_pow*array[cnt];
  my_pow=my_pow*CONSTELL_SIZE;
 }
 return(sum);
}
/******************************************************************************/
/*       Convert uniform random variables to gaussian random variables.
*******************************************************************************/
int My_Gauss(double tvar,double *tnarry)
//double tvar,tnarry[];
{
 double r,theta;
 r= -2.0*tvar*log(1.0-tnarry[URADIUS]);
 if(r < FRAC_ZERO)
  Error_Mes(10);
 r=sqrt(r);
 theta=2.0*MY_PI*tnarry[UTHETA];
 tnarry[GRAND_0]=r*cos(theta);
 tnarry[GRAND_1]=r*sin(theta);
 return(0);
}
/******************************************************************************/
/*                 Check for memory allocation failure.
*******************************************************************************/
int Ck_Calloc(void *tmp)
//void *tmp;
{
 if(tmp==NULL)
  Error_Mes(5);
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
