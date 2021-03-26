module bcd_counter(input clk, rst, output reg [3:0]ones, output reg [3:0] tens );

    always @(posedge clk ) begin
        if (rst) begin
            tens=0;
            ones=0;
        end
        if (tens==6) begin
            tens=0;
            ones=0;
        end
        ones=ones+1;
        if (ones==10)begin
            ones=0;
            tens=tens+1;
        end
    end
endmodule

module tb_bcd();
    reg clk, rst;
    wire [3:0]tens;
    wire[3:0]ones;
    initial begin
		$dumpfile("cntr.vcd");
		$dumpvars;
	end
    always begin
        #2 clk = ~clk;
    end
    bcd_counter cnt( clk, rst,ones, tens );   
    initial begin
        $monitor($time," CLK = %b, tens= %b, ones = %b ", clk, tens, ones );
        clk=1'b0;
        #2 rst=1'b1;
        #4 rst=1'b0;
        #300 $finish;
    end

endmodule