module DSReceiver(
       input wire SysClk,
		 input wire Rst_n,
		 
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

       output wire CLK_Drive,
		 
		 output wire cs,
		 output wire sclk,
		 output wire data,
		 output wire TEST

	           	
);

wire locked;
wire Clk_10M;
wire Clk_320M;

assign CLK_Drive=Clk_10M;


MyPLL	MyPLL_inst (
	.inclk0 ( SysClk ),
	.c0 ( Clk_320M ),
	.c1 ( Clk_10M ),
	.locked ( locked )
	);
	
AD5624 AD5624_inst(

       .clk(Clk_10M),
		 .rst(!locked),
       .cs(cs),
	    .sclk(sclk),
	    .data(data)	 

);

wire Data_VLD;
wire [13:0]Data_CH0;
wire [13:0]Data_CH1;
wire [13:0]Data_CH2;
wire [13:0]Data_CH3;

assign TEST=( |({Data_VLD,Data_CH0,Data_CH1,Data_CH2,Data_CH3}) );

AD9253Driver AD9253Driver_inst(

		 .Data_A_L(Data_A_L),
		 .Data_A_H(Data_A_H),
		 .Data_B_L(Data_B_L),
		 .Data_B_H(Data_B_H),
		 .Data_C_L(Data_C_L),
		 .Data_C_H(Data_C_H),
		 .Data_D_L(Data_D_L),
		 .Data_D_H(Data_D_H),

       .DCO(DCO),
       .FCO(FCO),
		 
		 .Data_VLD(Data_VLD),
		 .Data_CH0(Data_CH0),
		 .Data_CH1(Data_CH1),
		 .Data_CH2(Data_CH2),
		 .Data_CH3(Data_CH3)

);



	
endmodule 
	


