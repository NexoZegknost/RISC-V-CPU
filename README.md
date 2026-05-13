# RISC-V-CPU

![GitHub stars](https://img.shields.io/github/stars/NexoZegknost/RISC-V-CPU?style=for-the-badge&logo=github) ![GitHub forks](https://img.shields.io/github/forks/NexoZegknost/RISC-V-CPU?style=for-the-badge&logo=github) ![GitHub issues](https://img.shields.io/github/issues/NexoZegknost/RISC-V-CPU?style=for-the-badge&logo=github) ![License](https://img.shields.io/badge/license-LICENSE-green?style=for-the-badge)

## 📑 Table of Contents

- [Description](#description)
- [Quick Start](#quick-start)
- [Screenshots](#screenshots)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## 📝 Description

Dự án thiết kế bộ vi xử lý RISC CPU đơn giản sử dụng ngôn ngữ đặc tả phần cứng Verilog HDL trên môi trường Vivado. Đây là sản phẩm thuộc môn học Logic Design, tập trung vào việc rèn luyện kỹ năng thiết kế mạch số theo mô hình phân cấp.  
### 1. Đặc điểm kỹ thuật
Hệ thống là một bộ xử lý RISC cơ bản với các thông số chính:Kiến trúc: 3-bit opcode (hỗ trợ 8 loại lệnh) và 5-bit operand (truy xuất 32 không gian địa chỉ).  Độ rộng dữ liệu: 32-bit cho cả dữ liệu và địa chỉ.  Cơ chế hoạt động: Dựa trên tín hiệu $clk$ và $rst$ đồng bộ mức cao.  Điều khiển: Sử dụng Máy trạng thái hữu hạn (FSM) với 8 trạng thái hoạt động liên tục (từ INST_ADDR đến STORE).
### 2. Các khối chức năng chính:
Hệ thống được thiết kế theo mô hình phân cấp bao gồm:  Program Counter (PC): Quản lý địa chỉ lệnh, có khả năng tăng tiến hoặc nạp địa chỉ mới khi thực hiện lệnh nhảy (JMP).  ALU (Arithmetic Logic Unit): Thực hiện 8 phép toán số học/logic và cung cấp cờ $is\_zero$ cho lệnh nhảy điều kiện.  Controller (FSM): "Bộ não" điều phối 9 tín hiệu điều khiển dựa trên trạng thái và opcode.  Memory: Bộ nhớ tích hợp lưu trữ cả lệnh và dữ liệu, sử dụng cổng dữ liệu hai chiều (bidirectional).  Instruction Register (IR) & Accumulator (AC): Các thanh ghi lưu trữ tạm thời dữ liệu và lệnh.  Address Mux: Lựa chọn địa chỉ từ PC hoặc từ IR để gửi tới bộ nhớ tùy theo giai đoạn nạp lệnh hay thực thi.
### 3. Tập lệnh (Instruction Set):
Opcode | Lệnh | [cite_start]Mô tả hoạt động [cite: 44, 218] |
| :---: | :---: | :--- |
| `000` | **HLT** | [cite_start]Dừng hoạt động chương trình. |
| `001` | **SKZ** | [cite_start]Bỏ qua lệnh tiếp theo nếu cờ Zero = 1. |
| `010` | **ADD** | [cite_start]Cộng giá trị bộ nhớ vào thanh ghi Accumulator. |
| `011` | **AND** | [cite_start]Thực hiện phép toán logic AND. |
| `100` | **XOR** | [cite_start]Thực hiện phép toán logic XOR. |
| `101` | **LDA** | [cite_start]Nạp dữ liệu từ bộ nhớ vào Accumulator. |
| `110` | **STO** | [cite_start]Lưu dữ liệu từ Accumulator vào bộ nhớ. |
| `111` | **JMP** | [cite_start]Nhảy không điều kiện đến địa chỉ đích. |

### 4. Bảng trạng thái FSM:
| Trạng thái | Hoạt động chính |
| :----: | :----: |
| INST_ADDR | Thiết lập địa chỉ lấy lệnh từ PC. |
| INST_FETCH | Đọc lệnh từ bộ nhớ. |
|INST_LOAD | Nạp lệnh vào thanh ghi IR. |
| ALU_OP | Thực thi phép toán số học/logic. |
## ⚡ Quick Start

```bash

# Clone the repository
git clone https://github.com/NexoZegknost/RISC-V-CPU/tree/main?tab=readme-ov-file.git

# (See Development Setup below)
```

## 📸 Screenshots

 [Coming soon ...]

## 📁 Project Structure

```
.
├── LICENSE
├── RISC CPU.srcs
│   ├── sim_1
│   │   └── new
│   │       ├── ALU_TB.v
│   │       ├── Addr_MUX_TB.v
│   │       ├── Ctrl_TB.v
│   │       ├── MEM_TB.v
│   │       ├── PC_tb.v
│   │       ├── Program_Counter_TB.v
│   │       ├── Register_TB.v
│   │       ├── TOP_TB.v
│   └── sources_1
│       └── new
│           ├── ALU.v
│           ├── Address_Mux.v
│           ├── Controller.v
│           ├── IR.v
│           ├── PC.v
│           ├── TOP.v
│           ├── design.v
│           └── memory.v
└── RISC CPU.xpr
```

## 👥 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork** the repository
2. **Clone** your fork: `git clone https://github.com/NexoZegknost/RISC-V-CPU/tree/main?tab=readme-ov-file.git`
3. **Create** a new branch: `git checkout -b feature/your-feature`
4. **Commit** your changes: `git commit -am 'Add some feature'`
5. **Push** to your branch: `git push origin feature/your-feature`
6. **Open** a pull request

Please ensure your code follows the project's style guidelines and includes tests where applicable.

## 📜 License

This project is licensed under the LICENSE License.
