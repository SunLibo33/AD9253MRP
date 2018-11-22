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
wire Clk_80M;
wire Clk_320M;

assign CLK_Drive=Clk_80M;


MyPLL	MyPLL_inst (
	.inclk0 ( SysClk ),
	.c0 ( Clk_320M ),
	.c1 ( Clk_80M ),
	.locked ( locked )
	);
	
AD5624 AD5624_inst(

       .clk(Clk_80M),
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

wire[3:0] ADC_FIFO_NUM0;
wire[3:0] ADC_FIFO_NUM1;
wire[3:0] ADC_FIFO_NUM2;
wire[3:0] ADC_FIFO_NUM3;

wire ADC_FIFO_AFULL0;
wire ADC_FIFO_AFULL1;
wire ADC_FIFO_AFULL2;
wire ADC_FIFO_AFULL3;

wire [13:0]ADC_DATA_CH0;
wire [13:0]ADC_DATA_CH1;
wire [13:0]ADC_DATA_CH2;
wire [13:0]ADC_DATA_CH3;

reg [13:0]MR_DATA_CH0;
reg [13:0]MR_DATA_CH1;
reg [13:0]MR_DATA_CH2;
reg [13:0]MR_DATA_CH3;

assign ADC_FIFO_AFULL0= (ADC_FIFO_NUM0>=4'd8); 
assign ADC_FIFO_AFULL1= (ADC_FIFO_NUM1>=4'd8); 
assign ADC_FIFO_AFULL2= (ADC_FIFO_NUM2>=4'd8); 
assign ADC_FIFO_AFULL3= (ADC_FIFO_NUM3>=4'd8); 

always@(posedge Clk_80M)
begin
 if(locked==1'b0)
   begin
   MR_DATA_CH0<=14'd0;
	MR_DATA_CH1<=14'd0;
	MR_DATA_CH2<=14'd0;
	MR_DATA_CH3<=14'd0;
	end
 else
  begin
   MR_DATA_CH0<=ADC_DATA_CH0;
	MR_DATA_CH1<=ADC_DATA_CH1;
	MR_DATA_CH2<=ADC_DATA_CH2;
	MR_DATA_CH3<=ADC_DATA_CH3;
  end

end

assign TEST = ( |({MR_DATA_CH0,MR_DATA_CH1,MR_DATA_CH2,MR_DATA_CH3}) );

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

	
ADCFIFO14X8	ADCFIFO14X8_inst_ch0 (
	.data ( Data_CH0 ),
	.rdclk ( Clk_80M ),
	.rdreq ( ADC_FIFO_AFULL0 ),
	.wrclk ( Clk_320M ),
	.wrreq ( Data_VLD ),
	.q ( ADC_DATA_CH0 ),
	.wrusedw ( ADC_FIFO_NUM0 )
	);
	
	
ADCFIFO14X8	ADCFIFO14X8_inst_ch1 (
	.data ( Data_CH1 ),
	.rdclk ( Clk_80M ),
	.rdreq ( ADC_FIFO_AFULL1 ),
	.wrclk ( Clk_320M ),
	.wrreq ( Data_VLD ),
	.q ( ADC_DATA_CH1 ),
	.wrusedw ( ADC_FIFO_NUM1 )
	);
	
	
ADCFIFO14X8	ADCFIFO14X8_inst_ch2 (
	.data ( Data_CH2 ),
	.rdclk ( Clk_80M ),
	.rdreq ( ADC_FIFO_AFULL2 ),
	.wrclk ( Clk_320M ),
	.wrreq ( Data_VLD ),
	.q ( ADC_DATA_CH2 ),
	.wrusedw ( ADC_FIFO_NUM2 )
	);

ADCFIFO14X8	ADCFIFO14X8_inst_ch3 (
	.data ( Data_CH3 ),
	.rdclk ( Clk_80M ),
	.rdreq ( ADC_FIFO_AFULL3 ),
	.wrclk ( Clk_320M ),
	.wrreq ( Data_VLD ),
	.q ( ADC_DATA_CH3 ),
	.wrusedw ( ADC_FIFO_NUM3 )
	);
	


endmodule 


