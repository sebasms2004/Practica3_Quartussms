module Ejercicio5 (oQ, iD, iCLK, iRST); 
	output reg oQ; 
	input iD,iCLK,iRST; 

	always @(posedge iCLK or negedge iRST) 
			if (~iRST) oQ = 1'b0;			//Igual a: if (RST == 0) 
			else oQ = iD; 
endmodule 
