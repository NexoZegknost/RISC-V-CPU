//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2026 22:49:03
// Design Name: 
// Module Name: TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP_module (
    input clk,
    input rst
);
    wire [2:0] opcode;
    wire [4:0] ir_addr, pc_addr, mem_addr;
    wire [31:0] mem_data, alu_out, ac_out, ir_out;
    wire zero, sel, rd, wr, ld_ir, halt, inc_pc, ld_ac, ld_pc, data_e;
    
    assign mem_data = (data_e) ? ac_out : 32'bz;
    
    // Khối Program Counter
    Program_Counter PC (
        .clk(clk), .rst(rst), 
        .inc_pc(inc_pc), .ld_pc(ld_pc), 
        .pc_in(ir_addr), .pc_out(pc_addr)
    );

    // Khối Address Mux
    Address_Mux MUX (
        .sel(sel), .pc_addr(pc_addr), 
        .ir_addr(ir_addr), .addr_out(mem_addr)
    );

    // Khối Memory (Lưu ý: cổng data dùng chung mem_data)
    Memory MEM (
        .clk(clk), .wr(wr), .rd(rd), 
        .addr(mem_addr), .data(mem_data)
    );

    // Khối Instruction Register
    Instruction_Register IR (
        .clk(clk), .rst(rst), .load(ld_ir), 
        .data_in(mem_data), .data_out(ir_out)
    );
    assign opcode = ir_out[31:29]; // Giả sử 3-bit đầu là opcode
    assign ir_addr = ir_out[4:0];   // 5-bit cuối là địa chỉ

    // Khối Controller (FSM)
    Controller CTRL (
        .clk(clk), .rst(rst), .zero(zero), .opcode(opcode),
        .sel(sel), .rd(rd), .ld_ir(ld_ir), .halt(halt),
        .inc_pc(inc_pc), .ld_ac(ld_ac), .ld_pc(ld_pc), 
        .wr(wr), .data_e(data_e)
    );

    // Khối ALU
    ALU ALU_UNIT (
        .inA(ac_out), .inB(mem_data), .opcode(opcode),
        .out(alu_out), .is_zero(zero)
    );

    // Khối Accumulator
     Instruction_Register AC (
        .clk(clk), .rst(rst), .load(ld_ac), 
        .data_in(alu_out), .data_out(ac_out)
    );
    
    

endmodule
