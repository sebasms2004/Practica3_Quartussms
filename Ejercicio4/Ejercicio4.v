module Ejercicio4 (oQ, iD, iCLK); 
	output oQ; 
	input iD, iCLK; 
	reg oQ; 
	
	always @ (posedge iCLK) 
			oQ = iD; 
endmodule 