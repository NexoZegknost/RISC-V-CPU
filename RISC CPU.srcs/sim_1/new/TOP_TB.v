`timescale 1ns / 1ps

module tb_cpu_top();
    // 1. Khai báo các tín hiệu điều khiển hệ thống
    reg clk;
    reg rst;

    // 2. Khởi tạo instance của module Top (DUT)
    TOP_module dut (
        .clk(clk),
        .rst(rst)
    );

    // 3. Tạo xung Clock chu kỳ 20ns (tương đương 50MHz)
    always #10 clk = ~clk;

    initial begin
        // --- GIAI ĐOẠN 1: KHỞI TẠO VÀ NẠP DỮ LIỆU TRỰC TIẾP ---
        clk = 0;
        rst = 1; // Kích hoạt reset để chuẩn bị nạp dữ liệu

        // Nạp mã máy trực tiếp vào mảng RAM của instance bộ nhớ
        // Cấu trúc mã máy: 3-bit Opcode (bit 31-29) + 5-bit Address (bit 4-0)
        
        // Lệnh 1 (Địa chỉ 0): LDA 0x05 -> Opcode 101, nạp giá trị từ địa chỉ 5 vào AC
        dut.MEM.ram[0] = 32'hA0000005; 
        
        // Lệnh 2 (Địa chỉ 1): ADD 0x06 -> Opcode 010, cộng giá trị địa chỉ 6 vào AC
        dut.MEM.ram[1] = 32'h40000006; 
        
        // Lệnh 3 (Địa chỉ 2): STO 0x07 -> Opcode 110, lưu kết quả AC vào địa chỉ 7
        dut.MEM.ram[2] = 32'hC0000007; 
        
        // Lệnh 4 (Địa chỉ 3): JMP 0x00 -> Opcode 111, nhảy về đầu chương trình
        dut.MEM.ram[3] = 32'hE0000000; 

        // Nạp dữ liệu toán hạng tại các địa chỉ 5 và 6
        dut.MEM.ram[5] = 32'd15; // Gán giá trị 15
        dut.MEM.ram[6] = 32'd25; // Gán giá trị 25

        // --- GIAI ĐOẠN 2: THỰC THI VÀ KIỂM TRA ---
        #40 rst = 0; // Giải phóng reset để CPU bắt đầu hoạt động
        
        // CPU cần 8 chu kỳ clk (160ns) để thực hiện xong 1 lệnh
        // Kiểm tra sau khi hoàn thành 3 lệnh đầu (LDA, ADD, STO)
        #500; 
        
        if (dut.MEM.ram[7] == 32'd40) begin
            $display("Test Pass: Ket qua tai dia chi 7 la 40 (15 + 25)");
        end else begin
            $display("Test Fail: Ket qua sai, nhan duoc %d", dut.MEM.ram[7]);
        end

        // Kiểm tra lệnh JMP: PC phải quay về 0
        #200;
        if (dut.pc_addr < 5'h04) begin
            $display("Test Pass: Lenh JMP hoat dong, CPU dang lap lai chuong trinh");
        end

        #1000;
        $finish;
    end

    // Theo dõi trạng thái hệ thống qua console để debug
    initial begin
        $monitor("Time: %0t | State: %s | PC: %h | AC: %d", 
                 $time, dut.CTRL.state, dut.pc_addr, dut.ac_out);
    end

endmodule