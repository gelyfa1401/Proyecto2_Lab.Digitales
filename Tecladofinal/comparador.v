`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:27 02/25/2015 
// Design Name: 
// Module Name:    comparador 
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
module comparador
	#(parameter N = 5) // Comparador parametrizado, se usan 5 bits de resolución para los valores de temperatura que se comparan
	(
		input wire [N-1:0] D,     
		input wire [N-1:0] A,
		output wire  L
    );

assign L = (D == A || D > A) ? 1'b1 : 1'b0;   // Si el valor D es igual o mayor a A saca un bit en 1 si es menor saca un bit en 0


endmodule
