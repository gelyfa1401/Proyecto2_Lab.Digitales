`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:07:30 03/17/2015 
// Design Name: 
// Module Name:    Deco_PS2 
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
module Deco_PS2(

input wire [7:0] key_code_data,
output reg [4:0] cod_binario

  );
  
always @*  

begin
		cod_binario = 8'd0;  
	case (key_code_data) 
		 8'h16 : cod_binario = 5'd25; 
		 8'h1E : cod_binario = 5'd25; 
		 8'h26 : cod_binario = 5'd25; 
		 8'h25 : cod_binario = 5'd26; // temperatura era 25 se va a cambiar a26 por corregir latch
		 8'h2E : cod_binario = 5'd28; 
  	    default : cod_binario = 5'h00;  
	endcase
	
end

endmodule
