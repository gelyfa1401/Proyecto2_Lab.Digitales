`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:04:04 02/24/2015 
// Design Name: 
// Module Name:    fsm 
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
module fsm(
	input wire clk, rst,
	input wire en, ac_ventilador, ac_alarma, lectura,  // Señales de activación que provienen del comparador
	output reg en_alarma, en_ventilador,   // Señales enable provenientes de la máquina de estados
	output reg [1:0] estado);   

localparam[1:0] s0=2'b00,    // Definición de los estados
					 s1=2'b01,
					 s2=2'b10,
					 s3=2'b11;

reg[1:0] state_reg, state_next; // Estado actual (reg) y estado siguiente               

always @ (posedge clk, posedge rst)
	if (rst)
	state_reg <= s0;              // cuando hay una señal de reset el estado actual es sO 'b00
	else
	state_reg <= state_next;      // al estado siguiente le asigno el siguiente 
 

//Logica de transicion de estados	

always @*
	begin
		state_next = state_reg;  
		
		case(state_reg)
			s0: if (en)
					state_next = s1;
			s1: if (ac_alarma)       // Cuando recibe la señal de activación de la alarma el estado siguiente pasa a ser s2
					state_next = s2;  
			s2: if (ac_ventilador)
					state_next = s3;
			s3: if (lectura)           // Si la lectura está habilitada el estado siguiente es s1
					state_next = s1;
		endcase 
end

//Logica de Salidas
always@* 
	case(state_reg)
	s0:                                  // En este estado el enable de la alarma y del ventilador está apagado y el estado es 0
		begin
		en_alarma = 1'b0;
		en_ventilador = 1'b0;
		estado = 2'd0;
		end
	s1:
		begin                                // En este estado la alarma y el ventilador están apagados y es el estado 1
		en_alarma = 1'b0;
		en_ventilador = 1'b0;
		estado = 2'd1;
		end
	s2:
		begin
		en_alarma = 1'b1;              // En este estado la señal de enable de la alama se enciende
		en_ventilador = 1'b0;          // Señal de enable del ventilador apagada
		estado = 2'd2;                 // Estado 2 decimal
		end
	s3:
		begin
		en_alarma = 1'b1;          // En este estado la señal de enable de la alama se enciende
		en_ventilador = 1'b1;      // Señal de enable del ventilador se enciende
		estado = 2'd3;             // Estado 3 decimal
		end
		
	endcase
		

endmodule
