/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
#include "mimotype.h"
#include "mimoext.h"
/******************************************************************************/
int Simulation()
{
 for(Vec_Cnt=ZERO;Vec_Cnt<MAX_VEC;Vec_Cnt++)
 {
  Get_Sym();
  Get_Faded_Sym();
  Add_Noise();
  Receive();
 }
 return(0);
}
/******************************************************************************/
/*                         Get the faded symbol.
*******************************************************************************/
int Get_Faded_Sym()
{
 int cnt,cnt1;
 double re_tmp,im_tmp;
 double erand48(unsigned short xsubi[3]);
 for(cnt=ZERO;cnt<NUM_RX;cnt++)
 {
  Rx_Re_Sym[cnt]=Rx_Im_Sym[cnt]=0.0;
  for(cnt1=ZERO;cnt1<NUM_TX;cnt1++)
  {
   F1_Val[URADIUS]=erand48(F1_Store);
   F1_Val[UTHETA]=erand48(F2_Store);
   My_Gauss(FADE_VAR,F1_Val);
   Re_Fade[cnt][cnt1]=F1_Val[GRAND_0];
   Im_Fade[cnt][cnt1]=F1_Val[GRAND_1];
   re_tmp=Re_Sym[cnt1]*Re_Fade[cnt][cnt1]-Im_Sym[cnt1]*Im_Fade[cnt][cnt1];
   im_tmp=Re_Sym[cnt1]*Im_Fade[cnt][cnt1]+Im_Sym[cnt1]*Re_Fade[cnt][cnt1];
   Rx_Re_Sym[cnt]=Rx_Re_Sym[cnt]+re_tmp;
   Rx_Im_Sym[cnt]=Rx_Im_Sym[cnt]+im_tmp;
  }
  Power=Power+Rx_Re_Sym[cnt]*Rx_Re_Sym[cnt]+Rx_Im_Sym[cnt]*Rx_Im_Sym[cnt];
 }
 return(0);
}
/******************************************************************************/
/*                        Add white Gaussian noise.
*******************************************************************************/
int Add_Noise()
{
 int cnt;
 double erand48(unsigned short xsubi[3]);
 for(cnt=ZERO;cnt<NUM_RX;cnt++)
 {
  N1_Val[URADIUS]=erand48(N1_Store);
  N1_Val[UTHETA]=erand48(N2_Store);
  My_Gauss(Noise_Var,N1_Val);
  Rx_Re_Sym[cnt]=Rx_Re_Sym[cnt]+N1_Val[GRAND_0];
  Rx_Im_Sym[cnt]=Rx_Im_Sym[cnt]+N1_Val[GRAND_1];
 }
 return(0);
}
/******************************************************************************/
/*                         Receiver routines.
*******************************************************************************/
int Receive()
{
 int cnt,cnt1,cnt2,inx,min_inx,array[NUM_TX];
 double min,dist,re_err,im_err,re_sym,im_sym,re_sum,im_sum;
 min=MAX_MAG;
 for(cnt=ZERO;cnt<NUM_VEC;cnt++)
 {
  dist=0.0;
  Decimal_to_M_ary(cnt,array,NUM_TX,CONSTELL_SIZE);
  for(cnt2=ZERO;cnt2<NUM_RX;cnt2++)
  {
   re_sum=im_sum=0.0;
   for(cnt1=ZERO;cnt1<NUM_TX;cnt1++)
   {
    inx=array[cnt1];
    re_sym=Re_Map[inx]*Re_Fade[cnt2][cnt1]-Im_Map[inx]*Im_Fade[cnt2][cnt1];
    im_sym=Re_Map[inx]*Im_Fade[cnt2][cnt1]+Im_Map[inx]*Re_Fade[cnt2][cnt1];
    re_sum=re_sum+re_sym;
    im_sum=im_sum+im_sym;
   }
   re_err=Rx_Re_Sym[cnt2]-re_sum;
   im_err=Rx_Im_Sym[cnt2]-im_sum;
   dist=dist+re_err*re_err+im_err*im_err;
  }
  if(dist < min)
  {
   min=dist;
   min_inx=cnt;
  }
 }
 if(min_inx != Vec_Inx)
  Update_Error(min_inx);
 return(0);
}
/******************************************************************************/
/*                         Update the error counters.
*******************************************************************************/
int Update_Error(int min_inx)
//int min_inx;
{
 int cnt,array[NUM_TX];
 Vec_Ser++;
 Decimal_to_M_ary(min_inx,array,NUM_TX,CONSTELL_SIZE);
 for(cnt=ZERO;cnt<NUM_TX;cnt++)
 {
  if(Sym_Inx[cnt] != array[cnt])
   Ser++;
 }
 return(0);
}
/******************************************************************************/
