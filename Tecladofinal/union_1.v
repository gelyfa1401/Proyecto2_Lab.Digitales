`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:24:11 02/25/2015 
// Design Name: 
// Module Name:    union_1 
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
module union_1(
	input wire [4:0] temperatura,
	input wire clock,
	input wire reset,
	input wire en_m1,
	input wire lect,
	output wire est_alarma,
	output wire est_ventilador,
	output wire [3:0] anodos,   // Variables para controlar los ánodos del 7 segmentos
	output wire [7:0] catodos
	
    );


//Cables para las diferentes conexiones
wire a1,a2; // estos cables conectan las salidas de los comparadores con las entradas de la máquina de estados
//wire a3; // cambia (a3) para simulac
wire [1:0] estados;

localparam
	temp_1 = 5'd25,   // Se definen los parámetros locales para las temperaturas
	temp_2 = 5'd28;

	
comparador #(.N(5)) temp_25 //Parametrización del comparador con 5 bits para los valores de temperatura a comparar
	(
		.D(temperatura), 
		.A(temp_1),
		.L(a1)
    );
	 

comparador #(.N(5)) temp_28 //Parametrización del comparador con 5 bits  para los valores de temperatura a comparar 
	(
		.D(temperatura), 
		.A(temp_2),
		.L(a2)
    );

// divisorfrecuencia divisor(clock,a3); 
// parámetros para las variables de la máquina de estados que controla la temperatura, la alarma y el ventilador	 

fsm maq(
	.clk(clock),  // cambia (a3) para simulac
	.rst(reset),
	.en(en_m1),
	.ac_ventilador(a2),
	.ac_alarma(a1),
	.lectura(lect),	
	.en_alarma(est_alarma),
	.en_ventilador(est_ventilador),
	.estado(estados)
	);

FSM_7_Seg maq2(
	.est(estados),     
	.clk(clock),  // cambia (a3) para simulac
	.rest(reset),    
	.an(anodos),  
	.cat(catodos)); 

 
	
endmodule
