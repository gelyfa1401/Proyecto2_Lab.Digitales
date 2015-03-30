`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:48:06 03/17/2015 
// Design Name: 
// Module Name:    Registro5 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Registro5 #(parameter N=5)
	(
		input wire rst,
		input wire clk,
		input load,
		input wire [N-1:0] d_in,
		output wire [N-1:0] d_out 
    );

reg [N-1:0] r_act;
reg [N-1:0] r_sig;

always @(posedge clk, posedge rst)
if (rst)
	r_act <= 0;
else
	r_act <= r_sig;
	
always @*
   begin
   r_sig = r_act;
	case (load)
	1'b0: r_sig = r_act;
	1'b1: r_sig = d_in;
	default: r_sig = r_act; //
	endcase
	end 
	
assign d_out = r_act;

endmodule
