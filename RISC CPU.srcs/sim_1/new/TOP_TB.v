`timescale 1ns / 1ps

module tb_cpu_top;
    // Khai báo các tín hiệu kết nối
    reg clk;
    reg rst;

    // Khởi tạo instance của Top Module
    // Giả sử tên module của bạn là cpu_top
    TOP_module uut (
        .clk(clk),
        .rst(rst)
    );

    // Tạo xung nhịp clk (chu kỳ 10ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Kịch bản kiểm thử
    initial begin
        // 1. Khởi tạo hệ thống
        rst = 1; 
        #20;
        rst = 0; // Nhả reset để CPU bắt đầu chạy từ địa chỉ 0

        // 2. Nạp mã máy trực tiếp vào bộ nhớ thông qua đường dẫn phân cấp
        // Giả sử cấu trúc: uut (cpu_top) -> MEM (memory_inst) -> ram [array]
        // Cấu trúc lệnh: {opcode(3-bit), address(5-bit)}
        
        // Địa chỉ 0: LDA 5'h10 (Nạp dữ liệu tại ô nhớ 16 vào AC) -> 101_10000 = 8'hA0
        uut.MEM.ram[0] = 32'hA0000010; 
        
        // Địa chỉ 1: ADD 5'h11 (Cộng dữ liệu tại ô nhớ 17 vào AC) -> 010_10001 = 8'h51
        uut.MEM.ram[1] = 32'h51000011; 
        
        // Địa chỉ 2: STO 5'h12 (Lưu kết quả từ AC vào ô nhớ 18) -> 110_10010 = 8'hD2
        uut.MEM.ram[2] = 32'hD2000012;
        
        // Địa chỉ 3: JMP 5'h00 (Nhảy về đầu chương trình) -> 111_00000 = 8'hE0
        uut.MEM.ram[3] = 32'hE0000000;

        // Dữ liệu thử nghiệm tại các ô nhớ
        uut.MEM.ram[16] = 32'd100; // Giá trị ban đầu để LDA
        uut.MEM.ram[17] = 32'd50;  // Giá trị để ADD
        
        // 3. Chạy mô phỏng trong thời gian đủ dài để thực thi các lệnh
        #1000;
        
        $display("Kiem tra ket qua tai o nho 18: %d", uut.MEM.ram[18]);
        $stop;
    end
endmodule