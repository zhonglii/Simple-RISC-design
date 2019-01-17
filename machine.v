`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module machine(ins, clk, rst, write_r, read_r, PC_en, fetch, ac_ena, ram_ena, rom_ena,
ram_write, ram_read, rom_read, ad_sel, fetch);
input clk, rst;
input [2:0] ins;
output reg write_r, read_r, PC_en, ac_ena, ram_ena, rom_ena;
output reg ram_write, ram_read, rom_read, ad_sel;
output reg [1:0] fetch;

reg [3:0] state, ns;

parameter 	NOP=3'b000,
			LDO=3'b001,
			LDA=3'b010,
			STO=3'b011,
			PRE=3'b100,
			ADD=3'b101,
			LDM=3'b110,
			HLT=3'b111;
			 
parameter Sidle=4'hf,
			 S0=4'd0,
			 S1=4'd1,
			 S2=4'd2,
			 S3=4'd3,
			 S4=4'd4,
			 S5=4'd5,
			 S6=4'd6,
			 S7=4'd7,
			 S8=4'd8,
			 S9=4'd9,
			 S10=4'd10,
			 S11=4'd11,
			 S12=4'd12;
			 
always @(posedge clk or negedge rst) begin
	if(!rst) begin
		state <= Sidle;
	end
	else begin			//填入状态机
		state <= ns;
	end
end

always @(*) begin
	case(state)
	S0:	begin
		ns <= S1;
		end
	S1:	begin
		case(ins)
		NOP: ns = S0;
		LDM: ns = S11;
		PRE: ns = S9;
		ADD: ns = S9;
		HLT: ns = S2;
		default: ns = S3;
		endcase
		end
	S2:	begin
		ns = S2;
		end
	S3:	begin
		ns = S4;
		end
	S4:	begin
		if(ins == STO) ns = S7;
		else ns = S5;
		end
	S5:	begin
		ns = S6;
		end
	S6:	begin
		ns = S0;
		end
	S7:	begin
		ns = S8;
		end
	S8:	begin
		ns = S0;
		end
	S9:	begin
		ns = S10;
		end
	S10:	begin
		ns = S0;
		end
	S11:	begin
		ns = S12;
		end
	S12:	begin
		ns = S0;
		end
	default: ns = S0;
						//填入控制信号
	endcase
end

always @(*) begin
	if(!rst) begin
		write_r <= 0;
		read_r <= 0;
		PC_en <= 0;
		ac_ena <= 0;
		ram_ena <= 0;
		rom_ena <= 0;
		ram_write <= 0;
		ram_read <= 0;
		rom_read <= 0;
		ad_sel <= 0;
		fetch <= 0;
	end
	else begin			
	case(state)
	S0:	begin
		write_r <= 0;
		read_r <= 0;
		PC_en <= 0;
		ac_ena <= 0;
		ram_ena <= 0;
		rom_ena <= 1;
		ram_write <= 0;
		ram_read <= 0;
		rom_read <= 1;
		ad_sel <= 0;
		fetch <= 2'b01;
		end
	S1:	begin
		write_r <= 0;
		read_r <= 0;
		PC_en <= 1;
		ac_ena <= 0;
		ram_ena <= 0;
		rom_ena <= 0;
		ram_write <= 0;
		ram_read <= 0;
		rom_read <= 0;
		ad_sel <= 0;
		fetch <= 0;
		end
	S2:	begin
		write_r <= 0;
		read_r <= 0;
		PC_en <= 0;
		ac_ena <= 0;
		ram_ena <= 0;
		rom_ena <= 0;
		ram_write <= 0;
		ram_read <= 0;
		rom_read <= 0;
		ad_sel <= 0;
		fetch <= 0;
		end
	S3:	begin
		write_r <= 0;
		read_r <= 0;
		PC_en <= 0;
		ac_ena <= 0;
		ram_ena <= 0;
		rom_ena <= 1;
		ram_write <= 0;
		ram_read <= 0;
		rom_read <= 1;
		ad_sel <= 0;
		fetch <= 2'b10;
		end
	S4:	begin
		write_r <= 0;
		read_r <= 0;
		PC_en <= 1;
		ac_ena <= 0;
		ram_ena <= 0;
		rom_ena <= 0;
		ram_write <= 0;
		ram_read <= 0;
		rom_read <= 0;
		ad_sel <= 0;
		fetch <= 0;
		end
	S5:	begin
		write_r <= 1;
		read_r <= 0;
		PC_en <= 0;
		ac_ena <= 0;
		if(ins == LDA) begin
		ram_ena <= 1;
		ram_read <= 1;
		end
		else begin
		rom_ena <= 1;
		rom_read <= 1;
		end
		ram_write <= 0;		
		ad_sel <= 1;
		fetch <= 0;
		end
	S6:	begin
		
		end
	S7:	begin
		write_r <= 0;
		read_r <= 1;
		PC_en <= 0;
		ac_ena <= 0;
		ram_ena <= 0;
		rom_ena <= 0;
		ram_write <= 0;
		ram_read <= 0;
		rom_read <= 0;
		ad_sel <= 1;
		fetch <= 0;
		end
	S8:	begin
		write_r <= 0;
		read_r <= 1;
		PC_en <= 0;
		ac_ena <= 0;
		ram_ena <= 1;
		rom_ena <= 0;
		ram_write <= 1;
		ram_read <= 0;
		rom_read <= 0;
		ad_sel <= 1;
		fetch <= 0;
		end
	S9:	begin
		write_r <= 0;
		read_r <= 1;
		PC_en <= 0;
		ac_ena <= 0;
		ram_ena <= 0;
		rom_ena <= 0;
		ram_write <= 0;
		ram_read <= 0;
		rom_read <= 0;
		ad_sel <= 1;
		fetch <= 0;
		end
	S10:	begin
		write_r <= 0;
		read_r <= 1;
		PC_en <= 0;
		ac_ena <= 1;
		ram_ena <= 0;
		rom_ena <= 0;
		ram_write <= 0;
		ram_read <= 0;
		rom_read <= 0;
		ad_sel <= 1;
		fetch <= 0;
		end
	S11:	begin
		write_r <= 1;
		read_r <= 0;
		PC_en <= 0;
		ac_ena <= 0;
		ram_ena <= 0;
		rom_ena <= 0;
		ram_write <= 0;
		ram_read <= 0;
		rom_read <= 0;
		ad_sel <= 1;
		fetch <= 0;
		end
	S12:	begin
		
		end
	default: ns = S0;
	endcase
	end
end

endmodule
