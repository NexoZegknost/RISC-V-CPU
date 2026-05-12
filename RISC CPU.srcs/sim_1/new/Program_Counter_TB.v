module tb_program_counter();
    reg clk, rst, inc_pc, ld_pc;
    reg [4:0] ir_addr;
    wire [4:0] pc_out;

    // Khởi tạo khối PC
    Program_Counter uut (clk, rst, inc_pc, ld_pc, ir_addr, pc_out);

    initial begin
        clk = 0; rst = 1; inc_pc = 0; ld_pc = 0; ir_addr = 5'h00;
        #20 rst = 0;        // Giải phóng reset
        #20 inc_pc = 1;     // Kiểm tra đếm tiến: 0 -> 1 -> 2
        #40 inc_pc = 0; 
        #20 ld_pc = 1; ir_addr = 5'h1A; // Kiểm tra nạp địa chỉ JMP
        #20 ld_pc = 0;
        #40 $finish;
    end
    always #10 clk = ~clk; // Tạo xung clock chu kỳ 20ns
endmodule