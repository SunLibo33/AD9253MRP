module AD5624(
       input wire clk,
		 input wire rst,
       output reg cs,
	    output reg sclk,
	    output wire data	 

);

reg [15:0]SPI_COUNT;
reg [7:0] sclkcount;

reg [23:0] data_buf;

reg [2:0] REG_COUNT;

assign data=data_buf[23];

always @(posedge clk)
begin
	if(rst==1'b1)
     SPI_COUNT <= 16'd0;
	else //if(SPI_COUNT<16'd4095)
	  SPI_COUNT <= SPI_COUNT + 16'd1;
end

always @(posedge clk)
begin
	if(rst==1'b1)
     cs <= 1'b1;
	else if ( (SPI_COUNT>=16'd1000)&&(SPI_COUNT<=16'd3000) )
	  cs <= 1'b0;
	  //cs <= 1'b1;
	else
	  cs <= 1'b1;
end

always @(posedge clk)
begin
	if(rst==1'b1)
     REG_COUNT <= 3'b000;
	else if ( SPI_COUNT==16'd3000 )
	  REG_COUNT <= REG_COUNT + 3'b001;
end

always @(posedge clk)
begin
	if(rst==1'b1)
	  sclkcount <= 8'd0;
	else if( (cs==1'b0)&&(SPI_COUNT[4:0]==5'd0) )
	  sclkcount <= sclkcount + 8'd1;
	else if( cs==1'b1 )
	  sclkcount <= 8'd0;
end

always @(posedge clk)
begin
	if(rst==1'b1)
	  sclk <= 1'b0;
	else if( (cs==1'b0)&&(SPI_COUNT[4:0]==5'd0) && (sclkcount<=8'd47) )
	  sclk <= ~sclk;
end

always @(posedge clk)
begin
	if( (rst==1'b1)||(cs==1'b1) )
	  case(REG_COUNT)
	    3'b000:data_buf <= 24'h000d04;
		 3'b001:data_buf <= 24'h001531;
		 3'b010:data_buf <= 24'h002134;
		 3'b011:data_buf <= 24'h001804;
		 3'b100:data_buf <= 24'h001606; 
		 default:data_buf <= 24'h002134; 
	  endcase
	  
	else if( (cs==1'b0)&&(SPI_COUNT[4:0]==5'd0) && (sclkcount<=8'd47) && (sclkcount[0]==1'b1))
	  data_buf <= {data_buf[22:0],1'b0};
end

endmodule 