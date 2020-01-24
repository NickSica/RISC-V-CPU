module adder_array #(parameter num_adders) 
                    (input logic[63:0] [0:num_adders+num_adders-1] op1,
		     output logic[32:0] [0:num_adders-1] result)
    genvar i; 
    generate
       for(i = 0; i < num_adders; i += 2) begin
	  result[i] = op1[i] + op1[i+1];
       end
    endgenerate;
endmodule: adder_array

