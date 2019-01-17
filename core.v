module core(clk, rst
);						//在这个顶层模块中调用其他模块
input clk, rst;
wire [2:0] ins;
wire write_r, read_r, PC_en, ac_ena, ram_ena, rom_ena;
wire ram_write, ram_read, rom_read, ad_sel;
wire [1:0] fetch;
wire [7:0] data, addr;
wire [7:0] accum_out, alu_out;
wire [7:0] ir_ad, pc_ad;
wire [4:0] reg_ad;

//模块 模块名（变量）
//例：ram ram1(data, addr, ram_ena, ram_read, ram_write);
rom rom1(data, addr, rom_read, rom_ena);
reg_32 reg1(alu_out, data, write_r, read_r, reg_ad, clk);
alu alu1(alu_out, data, accum_out, ins);
ins_reg ir1(data, fetch, clk, rst, ins, reg_ad, ir_ad);
ram ram1(data, addr, ram_ena, ram_read, ram_write);
counter pc1(pc_ad, clk, rst, PC_en);
addr_mux adm1(addr, ad_sel, ir_ad, pc_ad);
machine fsm1(ins, clk, rst, write_r, read_r, PC_en, fetch, ac_ena, ram_ena, rom_ena,
ram_write, ram_read, rom_read, ad_sel, fetch);
accum acm1(alu_out, accum_out, ac_ena, clk, rst);
endmodule
