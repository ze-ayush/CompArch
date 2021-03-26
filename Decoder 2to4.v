module decoder_2to4(
        output reg [3:0] register,
        input [1:0] regNo);

        always @(regNo) begin
            case (regNo)
                2'b00 : 
                    register = 4'b0001;
                2'b01 : 
                    register = 4'b0010;
                2'b10 : 
                    register = 4'b0100;
                2'b11 : 
                    register = 4'b1000;
            endcase
        end
        
endmodule


module tb_decoder;
    reg [1:0]in;
    wire [3:0]out;
    initial begin
		$dumpfile("decoder.vcd");
		$dumpvars;
	end

    decoder_2to4 dec(out,in);
    
    always begin
       
        in= 2'b11;
        #0 in = 2'b01;
        #2 $display($time," IN=%b, OUT=%b", in, out);
        #4 in = 2'b00;
        #6 $display($time," IN=%b, OUT=%b", in, out); 
        #8 $finish;
    end

endmodule