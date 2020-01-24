module multiplier #(parameter n_bits = 64) 
                   (input logic clk,
		    input logic [n_bits-1:0] 	     multiplier, multiplicand,
		    output logic [n_bits+n_bits-1:0] result);
    result |= multiplicand;
    logic [n_bits-1:0] [0:n_bits+n_bits-1] results;

    genvar i;
    generate
       for(i = n_bits; i < n_bits + n_bits - 1; i++) begin
	  results[i] = multiplier[i-n_bits] & muiltiplicand;
       end
    endgenerate;
    
    always_ff @(posedge clk) begin
       genvar i;
       generate
	  for(i = n_bits; i > 0; i = i >> 1) begin
	     logic [3:0] stop_addr = i - 1;
	     logic [3:0] resultAddr = i >> 1;
	     array_adder stage #(i >> 1) (results[i:i+stop_addr], results[resultAddr:i-1]);
	  end
       endgenerate;      
    end

    always_comb begin
       logic [3:0] num_ops = n_bits;
       logic [3:0] index = 4b0;
       for(int i = n_bits; i > 0; i >> 1) begin
	  result[index] = results[i][0];
	  result[i+n_bits-1] = results[i][n_bits-1];
	  index += 1;
       end
       result[n_bits >> 2:(n_bits >> 2)+n_bits-1] = results[0:63];
    end
endmodule: multiplier



