module multiplier #(parameter N_BITS = 64) 
                   (input logic clk,
		    input logic [N_BITS-1:0] 	multiplier, multiplicand,
		    output logic [N_BITS*2-1:0] result);
    logic [N_BITS-1:0] [0:N_BITS*2-1] results;

    genvar i;
    generate
       for(i = 0; i < N_BITS * 2 - 1; i++) begin
	  results[i] = multiplier[i-N_BITS] & muiltiplicand;
       end
    endgenerate;
   
   always_ff @(posedge clk) begin
      result |= multiplicand;
   end
   
   genvar i;
   generate
      for(i = N_BITS; i > 0; i = i >> 1) begin
	 always_ff @(posedge clk) begin
	    logic [3:0] stop_addr = i - 1;
	    logic [3:0] resultAddr = i >> 1;
	 end
	 array_adder #(i >> 1) stage (clk, results[i:i+stop_addr], results[resultAddr:i-1]);
      end
   endgenerate;      


    always_comb begin
       logic [3:0] num_ops = N_BITS;
       logic [3:0] index = 4b0;
       for(int i = N_BITS; i > 0;) begin
	  result[index] = results[i][0];
	  result[i+N_BITS-1] = results[i][N_BITS-1];
	  index += 1;
	  i = i >> 1;
       end
       result[N_BITS >> 2:(N_BITS >> 2)+N_BITS-1] = results[0:63];
    end
endmodule: multiplier

