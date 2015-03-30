`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:43:47 03/13/2015
// Design Name:   Modulo_Recepcion_PS2
// Module Name:   E:/lab_de_Digitales/Proyecto_Corto_2/ps2P2.v
// Project Name:  Proyecto_Corto_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Modulo_Recepcion_PS2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ps2P2;

	// Inputs
	reg Clock;
	reg Reset;
	reg ps2d;
	reg ps2c;
	reg rx_enable;

	// Outputs
	wire rx_done_Tick;
	wire [7:0] dout;
	// Instantiate the Unit Under Test (UUT)
	Modulo_Recepcion_PS2 uut (
		.Clock(Clock), 
		.Reset(Reset), 
		.ps2d(ps2d), 
		.ps2c(ps2c), 
		.rx_enable(rx_enable), 
		.rx_done_Tick(rx_done_Tick), 
		.dout(dout)
	);
		 initial forever
		#10 Clock = ~Clock;
		
		
	initial
		begin
			ps2c = 0;
			#100 forever #20000 ps2c = ~ps2c;
			end
	
	initial 
		begin
			rx_enable = 0;
			ps2c = 1;
			Clock = 0;
			Reset = 1;
			ps2d = 1;
			repeat(5) @(posedge Clock);
			Reset = 0;
		end
		
	initial
		begin
		   // se manda el primer dato en hexa en este caso 2a
			ps2d = 1;
			#40000; // bit de parada 
			@(posedge ps2c); // se cambian los valores de ps2c en cambios de 0 a 1 ya que este modulo funciona con cambios negativos 
			rx_enable = 1; // se  indica que ya se puede leer 
			#40000;
			ps2d = 0; // bit de incio
			@(posedge ps2c);
			ps2d = 0; // bit Lsb [0]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit [1]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit [2]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit [3]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit [4]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit [5]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit [6]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit MSB [7]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit paridad
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit de parada 
			rx_enable = 0;
			#40000;
			// se termina de mandar la  primer letra 2a
			// se prosede a mandar el f0 del protocolo ps2 
			rx_enable = 1;
			#40000;
			ps2d = 0; // bit de incio
			@(posedge ps2c);
			ps2d = 0; // bit Lsb [0]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit [1]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit [2]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit [3]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit [4]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit [5]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit [6]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit MSB [7]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit paridad
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit de parada 
			rx_enable = 0;
			#40000;
			// se termina de mandar el codigo de  F0
			// se procede a mandar una vez mas 2a
			rx_enable = 1;
			#40000;
			ps2d = 0; // bit de incio
			@(posedge ps2c);
			ps2d = 0; // bit Lsb [0]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit [1]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit [2]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit [3]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit [4]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit [5]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit [6]
			#40000;
			@(posedge ps2c);
			ps2d = 0; // bit MSB [7]
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit paridad
			#40000;
			@(posedge ps2c);
			ps2d = 1; // bit de parada 
			rx_enable = 0;
			#40000;
			// se termina la simulacion 
		$stop;
		end
        
		// Add stimulus here

      
endmodule

