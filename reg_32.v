`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module reg_32(in, data, write, read, addr, clk
    );
input write, read, clk;
input [7:0] in;
input [7:0] addr;
output [7:0] data;

reg [7:0] R[31:0];
wire [4:0] r_addr;

assign r_addr = addr[4:0];
assign data = (read)? R[r_addr]:8'hzz;	//read有效时读取

always @(posedge clk) begin				//write有效则在时钟上升沿写入（注意与ram的不同）
	if(write)	R[r_addr] <= in;
end


endmodule
