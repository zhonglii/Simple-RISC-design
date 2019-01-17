`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module addr_mux(addr, sel, ir_ad, pc_ad
    );
input [7:0] ir_ad, pc_ad;
input sel;
output [7:0] addr;

assign addr = (sel)? ir_ad:pc_ad;	//sel选择PC地址输出还是ir地址输出

endmodule
