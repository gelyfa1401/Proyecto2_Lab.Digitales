`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:07:52 03/17/2015 
// Design Name: 
// Module Name:    General_ProyectoII 
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
module General_ProyectoII(
input wire clk,rst,datoTeclado1,clockTeclado1,enable_gen,inicioprogra,lectura,
output [4:0] out_reg2,
output wire q_act_0, // bit warning q no se usa, lo pongo en ucf a un pmod 
//output wire enmaq1,
output wire est_alarma1,
output wire est_ventilador1,
output wire [3:0] anodos1,   // Variables para controlar los ánodos del 7 segmentos
output wire [7:0] catodos1
    );

wire [7:0] data_in;
wire rx_cod1, carga_R2a, enmaq1; 
wire [4:0] deco_reg;


Teclado_Recep teclado_gen(
	.clk (clk),
	.rst (rst),
	.datoTeclado(datoTeclado1),
	.clockTeclado (clockTeclado1),
	.enable_rx (enable_gen),   
	.rx_listo (rx_cod1),       //salida
	.q_act_0(q_act_0),         //salida
	.codigo_tecla (data_in)    //salida
);

Frensen general (
	.rx_cod(rx_cod1),
	.clk (clk),
	.rst (rst),
	.inicio_progra1 (inicioprogra),
	.enable(enable_gen),
	.data (data_in),
	.carga_R2 (carga_R2a),    //salida
	.en_maq11 (enmaq1),      //salida
	.out_deco (deco_reg)      //salida
); 


Registro5 # (.N(5)) regis2 (
	.rst (rst),
	.clk (clk),
	.load (carga_R2a),
	.d_in (deco_reg),
	.d_out (out_reg2)      //salida
);


union_1 Temp_7seg(
	.temperatura(out_reg2),
	.clock(clk),
	.reset(rst),
	.en_m1(enmaq1), //*
	.lect(lectura),
	.est_alarma (est_alarma1),
	.est_ventilador (est_ventilador1),
	.anodos (anodos1),
	.catodos (catodos1)
);

endmodule
