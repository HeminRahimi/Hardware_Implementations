
 module Instruction_Mem (rst, read_address, instruction);

		input rst;
		input [31:0]  read_address ;
		output [31:0] instruction ;
      
		reg [7:0] Inst_Mem [0:31] ;
		
		assign instruction = {Inst_Mem[read_address + 3], Inst_Mem[read_address + 2],
                       		 Inst_Mem[read_address + 1], Inst_Mem[read_address]} ;

		always @ (rst) begin

			// Fill the rest with zeros (nop) or leave as don't-care 
			Inst_Mem[0] = 8'h00;
			Inst_Mem[1] = 8'h00;
			Inst_Mem[2] = 8'h00;
			Inst_Mem[3] = 8'h00;

			// Instruction at 4: add x10, x1, x2
			Inst_Mem[4] = 8'h33;  // LSB
			Inst_Mem[5] = 8'h85;
			Inst_Mem[6] = 8'h20;
			Inst_Mem[7] = 8'h00;  // MSB

			// Instruction at 8: sub x30, x3, x2
			Inst_Mem[8] = 8'hB3;
			Inst_Mem[9] = 8'h0F;
			Inst_Mem[10] = 8'h31;
			Inst_Mem[11] = 8'h40;

			// Instruction at 12: addi x30, x2, 15
			Inst_Mem[12]  = 8'h03;
			Inst_Mem[13]  = 8'h0F;
			Inst_Mem[14] = 8'hF1;
			Inst_Mem[15] = 8'h00;

			// Instruction at 16: sw x20, 8(x5)
                                           
			Inst_Mem[16] = 8'h23;
			Inst_Mem[17] = 8'h02;
			Inst_Mem[18] = 8'h41;
			Inst_Mem[19] = 8'h01;

			// Instruction at 20: lw x8 0(x15)
			Inst_Mem[20] = 8'h03;
			Inst_Mem[21] = 8'h84;
			Inst_Mem[22] = 8'h07;
			Inst_Mem[23] = 8'h00;

			// Instruction at 24: add x30 x8 x0 
			Inst_Mem[24] = 8'h33;
			Inst_Mem[25] = 8'h0F;
			Inst_Mem[26] = 8'h04;
			Inst_Mem[27] = 8'h00;
			
			// Instruction at 28:  beq x8 x8 4
			Inst_Mem[28] = 8'h63;
			Inst_Mem[29] = 8'h02;
			Inst_Mem[30] = 8'h84;
			Inst_Mem[31] = 8'h00;

	    end
			
		/*
    	initial begin
		$readmemh("Inst_memo_value.txt",Inst_Mem);
		end
		*/

endmodule
