/*  Simple Core
 *  
 *  Description: A simple CPU core that does not write to the register file.
 *  
 *  Notes:
 *      None.
 *
 *  Revision History:
 *      sokai       01/19/2016  1) Initial revision.
 *
 */
 
import simple_definitions::*;

module simple_core (
        input clk,                          // Clock
        input n_reset,                      // Active low reset
        output logic [31:0] alu_result_o,   // ALU result
        output logic alu_result_valid_o,    // ALU result is valid flag
        output logic stop_o                 // Stop execution flag
    );
    
    logic [2:0] pc;
    const int MAX_PC = 7;
    
	 //Added fetch-decode instruction and decode-execute instruction
    instruction_s instruction, instruction_FD, instruction_DX;
    logic rf_wen = 0;           // This core does not modify the reg file, no feedback.
   
	 //Created two wires  
	 logic rf_wen_FD; 
	 logic rf_wen_DX;  
	 //decode-execute registers for rs_val and rd_val 
    logic [31:0] rd_val, rd_val_DX;
    logic [31:0] rs_val, rs_val_DX;
    logic [31:0] alu_result;
    logic stop;
    
    always_ff @(posedge clk)
       // begin
        // Clear PC on reset.
        if (!n_reset)
           // begin
            pc <= 0;
           // end
        // Increment PC unless it has reached its max value.
        else if (pc != MAX_PC)
         //   begin
            pc <= pc + 1;
        //end
    //end // always_ff
    
    // Instruction memory
    simple_imem imem (
        .clk(clk),
        .n_reset(n_reset),
        .addr_i(pc),
        .instruction(instruction)
    );
	 
	 //1st pipecut
	  always_ff @(posedge clk) 
		if(!n_reset) 
			 instruction_FD <= 0; 
		else
			instruction_FD <= instruction; 
			
			
    // Register file
    simple_reg_file rf (
        .clk(clk),
        .rs_addr_i(instruction_FD.rs),
        .rd_addr_i(instruction_FD.rd),
        .rs_val_o(rs_val),
        .rd_val_o(rd_val)
    );
	 
	 //2nd pipeline cut
	 always_ff @(posedge clk) 
	  if(!n_reset) begin 
			instruction_DX <= 0; 
			rd_val_DX      <= 0; 
			rs_val_DX      <= 0; 
		 
		end 
		else begin 
			instruction_DX <= instruction_FD; 
			rd_val_DX      <= rd_val; 
			rs_val_DX      <= rs_val; 
	   end 
	 
	 
  
    // ALU
    simple_alu alu (
        .rd_i(rd_val_DX),
        .rs_i(rs_val_DX),
        .op_i(instruction_DX),
        .writes_rf_o(alu_result_valid),
        .result_o(alu_result),
        .stop_o(stop)
    );
    
    always_ff @(posedge clk)
        begin
        if (!n_reset) 
            begin
            end
        else
            begin
            alu_result_o <= alu_result;
            alu_result_valid_o <= alu_result_valid;
            stop_o <= stop;
        end
    end
    
endmodule
