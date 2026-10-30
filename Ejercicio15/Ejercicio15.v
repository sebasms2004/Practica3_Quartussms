module Ejercicio15( 
	//Entradas 
	input CLK, 
	input RST, 
	//Salidas 
	output E, 
	output reg RS, 
	output RW, 
	output reg INIlisto, 
	output reg [7:0] DATOS 
	); 
 
/*Declaración de señales internas e inicialización, donde se definen los 	nombres de estados y se les asigna un número (codificación)*/ 
	parameter Espera_20ms = 4'b0000; 
	parameter Enviar_SetFunction = 4'b0001; 
	parameter Envia_EntryModeSet = 4'b0010; 
	parameter Enviar_DisplayControl = 4'b0011; 
	parameter Envia_DisplayClear = 4'b0100; 
	parameter Envia_Direccion = 4'b0101; 
	parameter Envia_Caracter = 4'b0110; 
	parameter Caracter1 = 4'b0111; 
	parameter Caracter2 = 4'b1000; 
	parameter Caracter3 = 4'b1001; 
	parameter Caracter4 = 4'b1010; 
	parameter Termina_Aqui = 4'b1011; 
	 
	reg [3:0] estado; 
	reg [13:0] contador; 
	reg [4:0] cuentas; 
	reg en_fsm; 
	wire clk_e; 
	wire nrst = ~RST; 
 
	assign RW = 1'b0;					//Modo del display: ESCRITURA 
 
	//Señal de reloj para E 
	always @ (posedge CLK or posedge nrst) begin 
			if(nrst) 
				contador <= 0; 
			else if(contador == 5000) 
				contador <= 0; 
			else 
				contador <= contador + 1; 
	end 
 
	assign clk_e = (contador >= 0 && contador < 2500); 
	assign E = en_fsm ? (clk_e & en_fsm) : en_fsm; 
 
	//Máquina de estados (FSM) 
	always @ (posedge clk_e or posedge nrst) 
	begin 
			if(nrst) 						//Si se da un RST 
					begin 
					INIlisto = 1'b0; 		  	  //se activa ‘listo’ 
					RS = 1'b0; 			      	  //INSTRUCCIÓN DE CONTROL 
					en_fsm <= 1'b1; 		  	  //se activa la bandera ‘listo’ (LED) 
					DATOS = 8'b00000000; 	    //se limpia ‘DATOS’ 
					estado <= Espera_20ms; 		//se define el estado inicial 
					 			 end			 		//(estado = 0000) 
			else						//Sino ejecutar FSM 
						begin 
						case(estado) 
								Espera_20ms : 		//PRIMER ESTADO (estado=0000) 
								begin 
										INIlisto = 1'b0;    	//se desactiva la bandera ‘listo’(LED) 
										RS = 1'b0; 	    	   //INSTRUCCIÓN DE CONTROL 
										en_fsm <= 1'b1;	     //se activa la bandera ‘en_fsm’ 
										DATOS = 8'b00000000; //se limpia ‘DATOS’ 
										if(cuentas < 31) 	   //se genera temporización 
												begin 
												cuentas <= cuentas+1; 
												estado <= Espera_20ms; 
												end 
										else 
												begin 
												cuentas <= 0; 
												estado <= Enviar_SetFunction; 
												end 
									end 
									Enviar_SetFunction : 	//SEGUNDO ESTADO 
									begin		 		//(estado=0001) 
												INIlisto = 1'b0;	//se desactiva bandera ‘listo’(LED) 
												RS = 1'b0;	    	//INSTRUCCIÓN DE CONTROL 
												en_fsm <= 1'b1;  	//se activa la bandera ‘en_fsm’ 
												DATOS = 8'b0011_1000; //38H 
												estado <= Envia_EntryModeSet; 
									end 
									Envia_EntryModeSet :	//TERCER ESTADO 
									begin				//(estado=0010) 
												INIlisto = 1'b0;	    //se desactiva la bandera ‘listo’ (LED) 
												RS = 1'b0;		        //INSTRUCCIÓN DE CONTROL 
												en_fsm <= 1'b1;	      //se activa la bandera ‘en_fsm’ 
												DATOS = 8'b0000_0110; //06H 
												estado <= Enviar_DisplayControl; 
									end 
									Enviar_DisplayControl:	//CUARTO ESTADO 
									begin 
												INIlisto = 1'b0;	//se desactiva la bandera ‘listo’ (LED) 
												RS = 1'b0;	    	//INSTRUCCIÓN DE CONTROL 
												en_fsm <= 1'b1;  	//se activa la bandera ‘en_fsm’ 
												DATOS = 8'b0000_1110; //0EH 
												estado <= Envia_DisplayClear; 
									end 
									Envia_DisplayClear :	//QUINTO ESTADO 
									begin 
												INIlisto = 1'b0;	//se desactiva la bandera ‘listo’ (LED) 
												RS = 1'b0;	    	//INSTRUCCIÓN DE CONTROL 
												en_fsm <= 1'b1;	  //se activa la bandera ‘en_fsm’ 
												DATOS = 8'b00000001; //01H 
												estado <= Envia_Direccion; 
									end 
									Envia_Direccion :		//SEXTO ESTADO 
									begin 
												INIlisto = 1'b0; 	//se desactiva la bandera ‘listo’ (LED) 
												RS = 1'b0; 	    	//INSTRUCCIÓN DE CONTROL 
												en_fsm <= 1'b1; 	//se activa la bandera ‘en_fsm’ 
												DATOS = 8'b10000000; //10H 
												estado <= Envia_Caracter; 
									end 
									Envia_Caracter :		//SÉPTIMO ESTADO 
									begin 
												INIlisto = 1'b1; 	//se activa la bandera ‘listo’ (LED) 
												RS = 1'b1; 		    //MOSTRAR DATOS 
												en_fsm <= 1'b1; 	//se activa la bandera ‘en_fsm’ 
												DATOS = 8'b0010000; 
												estado <= Caracter1; 
									end 
									Caracter1 :			//OCTAVO ESTADO 
									begin 
												INIlisto = 1'b1; 	//se activa la bandera ‘listo’ (LED) 
												RS = 1'b1; 	    	//MOSTRAR DATOS 
												en_fsm <= 1'b1; 	//se activa la bandera ‘en_fsm’ 
												DATOS = 8'b0100_1000; //Carácter H 
												estado <= Caracter2; 
									end 
									Caracter2 :			//NOVENO ESTADO 
									begin 
												INIlisto = 1'b1; 	    //se activa la bandera ‘listo’ (LED) 
												RS = 1'b1; 	        	//MOSTRAR DATOS 
												en_fsm <= 1'b1; 	    //se activa la bandera ‘en_fsm’ 
												DATOS = 8'b0100_1111; //Carácter O 
												estado <= Caracter3; 
									end 
									Caracter3 :			//DÉCIMO ESTADO 
									begin 
												INIlisto = 1'b1; 	    //se activa la bandera ‘listo’ (LED) 
												RS = 1'b1; 		        //MOSTRAR DATOS 
												en_fsm <= 1'b1;     	//se activa la bandera ‘en_fsm’ 
												DATOS = 8'b0100_1100; //Carácter L 
												estado <= Caracter4;  
									end 
									Caracter4 :	       		//UNDÉCIMO ESTADO 
									begin 
												INIlisto = 1'b1; 	    //se activa la bandera ‘listo’ (LED) 
												RS = 1'b1; 		        //MOSTRAR DATOS 
												en_fsm <= 1'b1; 	    //se activa la bandera ‘en_fsm’ 
												DATOS = 8'b0100_0001; //Carácter A 
												estado <= Termina_Aqui; 
									end 
									Termina_Aqui :		      //DÉCIMO SEGUNDO ESTADO 
									begin 
												INIlisto = 1'b1; 	//se activa la bandera ‘listo’ (LED) 
												RS = 1'b0; 	      //INSTRUCCIÓN DE CONTROL 
												en_fsm <= 1'b0; 	//se apaga la bandera ‘en_fsm’ 
												                  //fin de tarea 
												DATOS = 8'b00000000;  
												estado <= Termina_Aqui; 
									end 
									default: 
												estado <= Espera_20ms; 
			endcase 
		end 
	end 
endmodule