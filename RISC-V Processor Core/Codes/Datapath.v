
module DP (clk, rst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOp, out2CTLR);

	input  clk, rst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
	input [1 : 0] AluOp;
	output [6 : 0] out2CTLR;

	wire Zero_flg;

	wire [31 : 0] Instruction, PC_out, read_data1, read_data2, imm_out, mux2ALU, 
		alu_result, read_data, Mux_to_reg_bank_WD, pc_in, Adder_out, add_const4_out;
	wire [3 : 0] AluCTRL2MainAlu;

	assign out2CTLR = Instruction[6 : 0];

    Instruction_Mem inst_Instruction_memory (rst, PC_out, Instruction);

	Reg_bank inst_reg_bank (clk, rst, Instruction[19 : 15], Instruction[24 : 20], 
		Instruction[11 : 7], Mux_to_reg_bank_WD, RegWrite, read_data1, read_data2);

	Imm_gen inst_immidiate_generation (Instruction, imm_out);

	MUX_2to1 inst_mux_after_reg_bank (read_data2, imm_out, ALUSrc, mux2ALU);

	ALU_CTRL inst_ALU_CTLR (AluOp, {Instruction[30], Instruction[14 : 12]}, AluCTRL2MainAlu);

	ALU inst_ALU (read_data1, mux2ALU, AluCTRL2MainAlu, alu_result, Zero_flg);

	Data_mem inst_DATA_Memory(clk, rst, alu_result, read_data2, MemRead, MemWrite, read_data);

	MUX_2to1 inst_Mux_after_Data_memory (alu_result, read_data, MemtoReg, Mux_to_reg_bank_WD);

	PC inst_Program_Counter (clk, rst, pc_in, PC_out);

	Adder_const4 inst_Add_by4 (PC_out, add_const4_out);

	MUX_2to1 inst_mux_after_adder (add_const4_out, Adder_out, (Branch & Zero_flg), pc_in);

	Adder inst_adder (PC_out, imm_out, Adder_out);
	
endmodule

