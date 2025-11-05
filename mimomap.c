/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
#include "mimotype.h"
#include "mimoext.h"
/******************************************************************************/
/*                         Get the constellation.
*******************************************************************************/
int Get_Map()
{
 if(CONSTELL == QAM16)
 {
  Re_16_QAM();
  Im_16_QAM();
 }
 else if((CONSTELL == PSK8) || (CONSTELL == BPSK) || (CONSTELL == QPSK))
  Get_PSK_Map();
 Print_Map();
 return(0);
}
/******************************************************************************/
/*              Get the real parts of the 16-QAM constellation.
*******************************************************************************/
int Re_16_QAM()
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
/*             Get the imaginary parts of the 16-QAM constellation.
*******************************************************************************/
int Im_16_QAM()
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
/*                       Print the constellation mapping.
*******************************************************************************/
int Print_Map()
{
 int cnt;
 for(cnt=ZERO;cnt<CONSTELL_SIZE;cnt++)
  printf("\t Inx:%3d Re:%+lf Im:%+lf\n",cnt,Re_Map[cnt],Im_Map[cnt]);
 printf("\n");
 return(0);
}
/******************************************************************************/
