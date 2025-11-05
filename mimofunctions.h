/******************************************************************************/
/*   Copyright (C) 2014 K. Vasudevan. Indian Institute of Technology Kanpur.  */
/*   All Rights Reserved.                                                     */
/******************************************************************************/
/******************************************************************************/
/*                        Function declarations.
*******************************************************************************/
int Pre_Processor(void);
int Simulation(void);
int Post_Processor(void);
int Ck_Var(void);
int Get_Map(void);
int Sim_Init(void);
int Re_16_QAM(void);
int Im_16_QAM(void);
int Re_8_QAM(void);
int Im_8_QAM(void);
int Get_PSK_Map(void);
int Print_Map(void);
int Noise_Gen_Init(void);
int Fade_Gen_Init(void);
int Ser_Init(void);
int Noise_Var_Init(void);
int Ck_Tx_Constell_Size(void);
int Ck_Constell_Number(void);
int Ck_Num_Vec(void);
int Error_Mes(int num);
int Get_Sym();
int Get_Faded_Sym();
int Add_Noise();
int Receive();
int My_Gauss(double tvar,double *tnarry);
int Decimal_to_Binary(int num,int *array,int array_size);
int Decimal_to_M_ary(int num,int *array,int array_size,int m_ary);
int Update_Error(int min_inx);
int Binary_to_Decimal(int *array,int size);
int M_ary_to_Decimal(int *array,int size);
/******************************************************************************/
