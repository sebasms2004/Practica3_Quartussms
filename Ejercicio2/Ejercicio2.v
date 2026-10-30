línea 1 initial 
línea 2	begin 
línea 3		clock = 1'b0; 
línea 4		#300 $finish; 
línea 5	end 
línea 6	always 
línea 7		#10 clock = ~clock;