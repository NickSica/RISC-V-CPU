module weighted_sum_builtin #(parameter num_inputs = 2, bit_length = 4) (input logic clk,
									 input logic [num_inputs-1:0] [bit_length-1:0] 	       weights, inputs,
									 output logic [(num_inputs+num_inputs)*bit_length-1:0] output_sum);
   logic [num_inputs-1:0] [bit_length+bit_length-1:0] weighted_product;

   genvar i;
   always_ff @(posedge clk) begin
      for(i = 0; i < num_inputs; i++) begin
	 weighted_product[i] <= weights[i] * inputs[i];
      end
   end

   always_comb begin
      output_sum = 0;
      for(i = 0; i < num_inputs; i++) begin
	 output_sum = 16'(weighted_product[i]) + output_sum;
      end
   end   
endmodule: weighted_sum_builtin
