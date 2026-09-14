`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09.09.2026 10:46:27
// Design Name:
// Module Name: lock_controller_tb
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

import lock_pkg::*;


module lock_controller_tb ();

    logic       clk         ;
    logic       rst         ;
    logic       unlocked_led;
    logic [3:0] digit_in    ;
    logic [3:0] digit_clean ;

    lock_controller dut (
        .clk         (clk         ),
        .rst         (rst         ),
        .digit_in    (digit_in),
        .unlocked_led(unlocked_led)
    );


    task automatic check_code(
            input [3:0] digit_iner,
            input state_t expected_state,
            input string text
        );

        digit_in <= digit_iner;
       repeat(205) @(posedge clk)#1
            if (dut.state === expected_state)
            $display("[%0t ns] [PASS] %s <--- State  %s "
                ,$time, dut.state.name() , text );
        else
            $display("[%0t ns] [FAIL] digit = %0d | expected=%s | got=%s | %s",
                $time, digit_iner, expected_state.name(), dut.state.name(), text);


    endtask


    initial begin
        clk = 1'b0;
        rst = 1'b0;
        digit_in = 4'b0;
        unlocked_led = 1'b0;
    end


    always begin
        #5 clk = ~clk;
    end

    initial begin
        #10
            rst = 1'b1;
        #10
            rst = 1'b0;
        $display("[%0t ns] after reset state ---> %s (expected LOCKED)",$time, dut.state.name());
        #5
            
            $display("[%0t ns] digit_clean state ----> %0b",$time, digit_clean);
      
            check_code (dut.CODE1 + 1, WAIT_D2, "wrong first digit");
            check_code (dut.CODE0, WAIT_D2, "correct digit");
            check_code (dut.CODE1, WAIT_D3, "correct digit");
            check_code (dut.CODE2, UNLOCKED, "correct digit");


        $finish;










    end

endmodule
