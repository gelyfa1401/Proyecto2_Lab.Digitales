`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:31:37 02/26/2015 
// Design Name: 
// Module Name:    FSM_7_Seg 
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

module FSM_7_Seg(
	input wire [1:0] est,     // Variables estado
	input wire clk,rest,     // Señal de reloj y reset del circuito
	output wire [3:0] an,   // Variables para controlar los ánodos del 7 segmentos
	output wire [7:0] cat  // Variables para manejar los cátodos del 7 segmentos
    );

//Declaración simbólica de estados para la máquina de estados

localparam
	A = 4'h0,
	B = 4'h1,
	C = 4'h2,
	D = 4'h3,
	E = 4'h4,
	F = 4'h5,
	G = 4'h6,
	H = 4'h7,
	I = 4'h8;


//Registros para monitoreo de estado

reg [4:0] state_reg,state_next;  // estados
reg [3:0] an_reg , an_next;      // anodos
reg [7:0] cat_reg, cat_next;     // cátodos


//Descripción de los registros de estado

always@(posedge clk, posedge rest) begin

	if(rest) begin
		state_reg <= A;      // Asignación de valores "iniciales"
		an_reg <= 0;
		cat_reg <=0;
	end
	else begin
		state_reg <= state_next;      // Relación entre estado siguiente y actual
		an_reg <= an_next;
		cat_reg <= cat_next;
	end
end
		
//Lógica para transición de estados

always@*
begin
	case(state_reg)
	
		A:                              // Valor para encender los leds es 0
			begin                                    
			an_next = 4'b1110;           // Encender 1er 7segm   
			cat_next = 8'b11000000;      // Enciende los leds para formar un 0
			if(~(est == 2'b00))          // Mientras el estado no esté en cero el estado siguiente a A será B de 
			begin                        // lo contrario el estado seguirá siendo A
				state_next = B;
			end
			else begin
				state_next = A;
			end
		end
		
		B: 
			begin
			an_next = 4'b1110;
			cat_next = 8'b11111001;     // Código para mostrar un 1 en el 7segm
			if(~(est == 2'b01)) begin
				state_next = C;
			end
			else begin
				state_next = B;
			end
		end
		
		C: 
			begin
			an_next = 4'b1110;    
			cat_next = 8'b10100100;  // Código para mostrar un 2 en el 7segm
				begin
				state_next = D;
				end
			end
			
		D: 
			begin
			an_next = 4'b1101;           // Encender 2ndo 7segm
			cat_next = 8'b10001000;      // Código para mostrar una A en el 7segm
				begin
				state_next = E;
				end
			end
			
		E: 
			begin
			an_next = 4'b1101;
			cat_next = 8'b10001000;   // Código para mostrar una A en el 7segm
				if(~(est == 2'b10)) 
				 begin
					state_next = F;
				end
				else begin
					state_next = C;
				end
			end
			
		F: 
			begin
			an_next = 4'b1110;       // Vuelve a encender el anodo del primer 7segm y mantiene los otros apagados 
			cat_next = 8'b10110000;  // Código para mostrar un 3 en el 7segm
				begin
				state_next = G;
				end
			end
			
		G: 
			begin
			an_next = 4'b1101;        // Vuelve a encender el anodo del segundo 7segm y mantiene los otros apagados
			cat_next = 8'b10001000;   // Código para mostrar una A en el 7segm
				begin
				state_next = H;
				end
			end
			
		H: 
			begin                     
			an_next = 4'b1011;   // Enciende el 3er anodo del 7segm y mantiene los otros apagados 
			cat_next = 8'b10001110;
				begin
				state_next = I;
				end
			end
			
		I: 
			begin
			an_next = 4'b1011;
			cat_next = 8'b10001110; // Código para mostrar una F en el 7segm
				if(~(est == 2'b11)) 
				begin
					state_next = A;
				end
				else begin
					state_next = F;
				end
			end
			
		default: 
			begin
			state_next = A;
			an_next = 4'b1111;       // Apagar todos los anodos 7segm
			cat_next = 8'b11111111;  // Apagar catodos(leds) del 7segm
		end
	endcase
end


// Logica de salidas
// Le asigna los valores del registro al ánodo y cátodos del 7segm

assign an = an_reg;     
assign cat = cat_reg;	
			

endmodule
