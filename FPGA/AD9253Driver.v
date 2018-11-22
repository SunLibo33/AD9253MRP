module AD9253Driver(

		 input wire Data_A_L,
		 input wire Data_A_H,
		 input wire Data_B_L,
		 input wire Data_B_H,
		 input wire Data_C_L,
		 input wire Data_C_H,
		 input wire Data_D_L,
		 input wire Data_D_H,

       input wire DCO,
       input wire FCO,
		 
		 output reg       Data_VLD,
		 output reg[13:0] Data_CH0,
		 output reg[13:0] Data_CH1,
		 output reg[13:0] Data_CH2,
		 output reg[13:0] Data_CH3

);


reg [3:0]REG_DATA_H_R_CH0;
reg [3:0]REG_DATA_H_D_CH0;
reg [3:0]REG_DATA_L_R_CH0;
reg [3:0]REG_DATA_L_D_CH0; 

reg [3:0]REG_DATA_H_R_CH1;
reg [3:0]REG_DATA_H_D_CH1;
reg [3:0]REG_DATA_L_R_CH1;
reg [3:0]REG_DATA_L_D_CH1; 

reg [3:0]REG_DATA_H_R_CH2;
reg [3:0]REG_DATA_H_D_CH2;
reg [3:0]REG_DATA_L_R_CH2;
reg [3:0]REG_DATA_L_D_CH2; 

reg [3:0]REG_DATA_H_R_CH3;
reg [3:0]REG_DATA_H_D_CH3;
reg [3:0]REG_DATA_L_R_CH3;
reg [3:0]REG_DATA_L_D_CH3; 

reg [13:0]Data_CH0_COMB,Data_CH0_REG1,Data_CH0_REG2;
reg [13:0]Data_CH1_COMB,Data_CH1_REG1,Data_CH1_REG2;
reg [13:0]Data_CH2_COMB,Data_CH2_REG1,Data_CH2_REG2;
reg [13:0]Data_CH3_COMB,Data_CH3_REG1,Data_CH3_REG2;

reg FCO_REG1,FCO_REG2,FCO_REG3,FCO_REG4;

always @(posedge DCO)
begin
  REG_DATA_H_R_CH0 <= {REG_DATA_H_R_CH0[2:0],Data_A_H};
  REG_DATA_L_R_CH0 <= {REG_DATA_L_R_CH0[2:0],Data_A_L};  
  REG_DATA_H_R_CH1 <= {REG_DATA_H_R_CH1[2:0],Data_B_H};
  REG_DATA_L_R_CH1 <= {REG_DATA_L_R_CH1[2:0],Data_B_L}; 
  REG_DATA_H_R_CH2 <= {REG_DATA_H_R_CH2[2:0],Data_C_H};
  REG_DATA_L_R_CH2 <= {REG_DATA_L_R_CH2[2:0],Data_C_L}; 
  REG_DATA_H_R_CH3 <= {REG_DATA_H_R_CH3[2:0],Data_D_H};
  REG_DATA_L_R_CH3 <= {REG_DATA_L_R_CH3[2:0],Data_D_L}; 
end

always @(negedge DCO)
begin
  REG_DATA_H_D_CH0 <= {REG_DATA_H_D_CH0[2:0],Data_A_H};
  REG_DATA_L_D_CH0 <= {REG_DATA_L_D_CH0[2:0],Data_A_L};  
  REG_DATA_H_D_CH1 <= {REG_DATA_H_D_CH1[2:0],Data_B_H};
  REG_DATA_L_D_CH1 <= {REG_DATA_L_D_CH1[2:0],Data_B_L}; 
  REG_DATA_H_D_CH2 <= {REG_DATA_H_D_CH2[2:0],Data_C_H};
  REG_DATA_L_D_CH2 <= {REG_DATA_L_D_CH2[2:0],Data_C_L}; 
  REG_DATA_H_D_CH3 <= {REG_DATA_H_D_CH3[2:0],Data_D_H};
  REG_DATA_L_D_CH3 <= {REG_DATA_L_D_CH3[2:0],Data_D_L}; 
end

always @(negedge DCO)
begin
  Data_CH0_COMB <= {
                REG_DATA_H_R_CH0[3],REG_DATA_H_D_CH0[3],REG_DATA_H_R_CH0[2],REG_DATA_H_D_CH0[2],
					 REG_DATA_H_R_CH0[1],REG_DATA_H_D_CH0[1],REG_DATA_H_R_CH0[0],REG_DATA_H_D_CH0[0],
                REG_DATA_L_R_CH0[3],REG_DATA_L_D_CH0[3],REG_DATA_L_R_CH0[2],REG_DATA_L_D_CH0[2],
					 REG_DATA_L_R_CH0[1],REG_DATA_L_D_CH0[1]					 		 
              };
  Data_CH1_COMB <= {
                REG_DATA_H_R_CH1[3],REG_DATA_H_D_CH1[3],REG_DATA_H_R_CH1[2],REG_DATA_H_D_CH1[2],
					 REG_DATA_H_R_CH1[1],REG_DATA_H_D_CH1[1],REG_DATA_H_R_CH1[0],REG_DATA_H_D_CH1[0],
                REG_DATA_L_R_CH1[3],REG_DATA_L_D_CH1[3],REG_DATA_L_R_CH1[2],REG_DATA_L_D_CH1[2],
					 REG_DATA_L_R_CH1[1],REG_DATA_L_D_CH1[1]					 		 
              };
  Data_CH2_COMB <= {
                REG_DATA_H_R_CH2[3],REG_DATA_H_D_CH2[3],REG_DATA_H_R_CH2[2],REG_DATA_H_D_CH2[2],
					 REG_DATA_H_R_CH2[1],REG_DATA_H_D_CH2[1],REG_DATA_H_R_CH2[0],REG_DATA_H_D_CH2[0],
                REG_DATA_L_R_CH2[3],REG_DATA_L_D_CH2[3],REG_DATA_L_R_CH2[2],REG_DATA_L_D_CH2[2],
					 REG_DATA_L_R_CH2[1],REG_DATA_L_D_CH2[1]					 		 
              };
  Data_CH3_COMB <= {
                REG_DATA_H_R_CH3[3],REG_DATA_H_D_CH3[3],REG_DATA_H_R_CH3[2],REG_DATA_H_D_CH3[2],
					 REG_DATA_H_R_CH3[1],REG_DATA_H_D_CH3[1],REG_DATA_H_R_CH3[0],REG_DATA_H_D_CH3[0],
                REG_DATA_L_R_CH3[3],REG_DATA_L_D_CH3[3],REG_DATA_L_R_CH3[2],REG_DATA_L_D_CH3[2],
					 REG_DATA_L_R_CH3[1],REG_DATA_L_D_CH3[1]					 		 
              };				  
end

always @(negedge DCO)
begin
  Data_CH0_REG1<=Data_CH0_COMB;
  Data_CH0_REG2<=Data_CH0_REG1;
  
  Data_CH1_REG1<=Data_CH1_COMB;
  Data_CH1_REG2<=Data_CH1_REG1;

  Data_CH2_REG1<=Data_CH2_COMB;
  Data_CH2_REG2<=Data_CH2_REG1;

  Data_CH3_REG1<=Data_CH3_COMB;
  Data_CH3_REG2<=Data_CH3_REG1; 
 
  FCO_REG1 <= FCO; 
  FCO_REG2 <= FCO_REG1;
  FCO_REG3 <= FCO_REG2;
  FCO_REG4 <= FCO_REG3;
end

always @(negedge DCO)
begin
  if(FCO_REG3^FCO_REG4)
    begin
      Data_CH0 <= Data_CH0_REG2;
      Data_CH1 <= Data_CH1_REG2;  
      Data_CH2 <= Data_CH2_REG2;
      Data_CH3 <= Data_CH3_REG2;
      Data_VLD <= 1'b1;		
    end	
  else
    begin
	   Data_CH0 <= Data_CH0;
      Data_CH1 <= Data_CH1;  
      Data_CH2 <= Data_CH2;
      Data_CH3 <= Data_CH3; 
		Data_VLD <= 1'b0;	
	 end 
end

endmodule 