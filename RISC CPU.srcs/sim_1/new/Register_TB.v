module tb_instruction_register();
    // Khai báo các tín hiệu kết nối với khối IR
    reg clk;
    reg rst;
    reg load;
    reg [31:0] data_in;
    
    wire [31:0] data_out;
    wire [2:0] opcode;
    wire [4:0] addr;

    // Khởi tạo khối IR (dựa trên module register_32bit chung)
    // Giả sử logic tách opcode/addr được thực hiện tại đây hoặc trong top module
    Instruction_Register dut (
        .clk(clk), 
        .rst(rst), 
        .load(load), 
        .data_in(data_in), 
        .data_out(data_out)
    );

    // Logic tách bit (thường nằm trong top module nhưng đưa vào đây để kiểm tra)
    assign opcode = data_out[31:29];
    assign addr   = data_out[4:0];

    // Tạo xung clock chu kỳ 20ns
    always #10 clk = ~clk;

    initial begin
        // Bước 1: Khởi tạo giá trị ban đầu
        clk = 0;
        rst = 1;
        load = 0;
        data_in = 32'h0;
        
        // Bước 2: Giải phóng reset sau 20ns
        #20 rst = 0;
        
        // Bước 3: Thử nạp lệnh ADD (Opcode 010) tại địa chỉ 0x1F (5'b11111)
        // Dữ liệu giả lập: 3'b010 (bit 31-29) và 5'b11111 (bit 4-0)
        #20 data_in = 32'h4000001F; 
            load = 1; // Kích hoạt nạp dữ liệu
            
        #20 load = 0; // Khóa nạp, thay đổi data_in để kiểm tra tính ổn định
            data_in = 32'hFFFFFFFF;
            
        // Bước 4: Thử nạp lệnh JMP (Opcode 111) tại địa chỉ 0x0A (5'b01010)
        #20 data_in = 32'hE000000A;
            load = 1;
            
        #20 load = 0;

        // Kết thúc mô phỏng
        #40 $finish;
    end

    // Theo dõi kết quả trên Console
    initial begin
        $monitor("Time=%0t | Load=%b | DataOut=%h | Opcode=%b | Addr=%h", 
                 $time, load, data_out, opcode, addr);
    end
endmodule