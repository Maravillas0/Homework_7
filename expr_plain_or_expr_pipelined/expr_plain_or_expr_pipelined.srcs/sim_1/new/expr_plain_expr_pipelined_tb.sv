`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.09.2026 14:17:56
// Design Name: 
// Module Name: expr_pipelined_tb
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


module expr_pipelined_tb();
    logic        clk   ;
    logic        rst   ;
    logic [ 3:0] a     ;
    logic [ 3:0] b     ;
    logic [ 3:0] c     ;
    logic [ 3:0] d     ;
    logic [7:0] result_plain;
    logic [7:0] result_pipelined;
   
expr_pipelined dut (
    .clk             (clk),
    .rst             (rst),
    .a               (a),
    .b               (b),
    .c               (c),
    .d               (d),
    .result_pipelined(result_pipelined)
    );
expr_plain dut1 (
    .clk         (clk),
    .rst         (rst),
    .a           (a),
    .b           (b),
    .c           (c),
    .d           (d),
    .result_plain(result_plain)
    );

initial clk = 0;

always #5 clk = ~clk;

task automatic check_case;
    input [7:0] a_val, b_val, c_val, d_val;
    input [15:0] expected;
    input string text;

begin
     a = a_val; b = b_val; c = c_val; d = d_val;
    @(posedge clk);

     if (result_plain === expected) 
         $display("[%0t] PASS (plain): %0s -> result %0d",$time, text, result_plain);
     else 
         $display("[%0t] FAIL (plain): %0s -> expected %0d, got %0d",$time, text, expected, result_plain);

    if (result_pipelined === expected) 
         $display("[%0t] PASS (pipelined): %0s -> result %0d",$time, text, result_pipelined);
     else 
         $display("[%0t] FAIL (pipelined): %0s -> expected %0d, got %0d",$time, text, expected, result_pipelined);

end
endtask

initial begin
    # 10 rst = 1;
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    @(posedge clk); #1;
        rst = 0; 

        // (a*b)+(c*d)

check_case (8'd2,8'd4,8'd7,8'd5,16'd43,"(2*4)+(7*5)=43");


 $display("[%0t ns] Simulation finished", $time);
        $finish;



end

endmodule

 