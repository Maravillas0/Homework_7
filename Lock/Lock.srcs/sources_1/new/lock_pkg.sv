`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2026 14:22:23
// Design Name: 
// Module Name: lock_pkg
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


package lock_pkg;

typedef enum logic [1:0] {
    LOCKED,
    WAIT_D2,
    WAIT_D3,
    UNLOCKED
} state_t;

endpackage
