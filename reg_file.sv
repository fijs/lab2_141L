// A register file with asynchronous read and synchronous write
module reg_file #(parameter NUM_REGS = 8,
                  ADR_WIDTH = $clog2(NUM_REGS),
                  DATA_WIDTH=16)
                (input clk
                ,input [ADR_WIDTH-1:0] rs_addr_i
                ,input [ADR_WIDTH-1:0] rd_addr_i
		,input [ADR_WIDTH-1:0] wa_i
                ,input wen_i
                ,input [DATA_WIDTH-1:0] write_data_i
                ,output [DATA_WIDTH-1:0] rs_val_o
                ,output [DATA_WIDTH-1:0] rd_val_o
                );

// declare memory/reg file array itself
logic [DATA_WIDTH-1:0] RF [2**ADR_WIDTH];	// RF [NUM_REGS] ???

// reads are combinational
assign rs_val_o = RF [rs_addr_i];
assign rd_val_o = RF [rd_addr_i];

// writes are sequential/clocked
always_ff @ (posedge clk)
  if (wen_i)
    RF [wa_i] <= write_data_i;

endmodule

