`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module ram(data, addr, ena, read, write
    );
input ena, read, write;
input [7:0] addr;
inout [7:0] data;

reg [7:0] ram[5:0];

assign data = (read&&ena)? ram[addr]:8'hzz;		//read 与 ena有效时读取

always @(posedge write) begin					//write信号的上升沿写入
	ram[addr] <= data;
end

endmodule
