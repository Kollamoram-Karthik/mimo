/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
#include "mimotype.h"
#include "mimoext.h"
/******************************************************************************/
/*                   Get the symbol vector to be transmitted.
*******************************************************************************/
int Get_Sym()
{
 int cnt,inx,cnt1;
 int rand(void);
 for(cnt1=ZERO;cnt1<NUM_TX;cnt1++)
 {
  for(cnt=ZERO;cnt<BITS_PER_SYM;cnt++)
   Bits[cnt]=rand()&1;
  Sym_Inx[cnt1]=Binary_to_Decimal(Bits,BITS_PER_SYM);
  Re_Sym[cnt1]=Re_Map[Sym_Inx[cnt1]];
  Im_Sym[cnt1]=Im_Map[Sym_Inx[cnt1]];
  Occur[Sym_Inx[cnt1]]++;
//  printf("time:%d inx:%d Re:%lf Im:%lf\n",Vec_Cnt,Sym_Inx,Re_Sym,Im_Sym);
 }
 Vec_Inx=M_ary_to_Decimal(Sym_Inx,NUM_TX);
 return(0);
}
/******************************************************************************/
