module mealy(output reg y, input clk,rst,din);

parameter idle = 4'b0000,
got0=4'b0001,
got1=4'b0010,
got00=4'b0011,
got01=4'b0100,
got10=4'b0101,
got11=4'b0110,
got000=4'b0111,
got001=4'b1000,
got010=4'b1001,
got011=4'b1010,
got100=4'b1011,
got101=4'b1100,
got110=4'b1101,
got111=4'b1110;

reg [3:0] pres,next;

always @(posedge clk ) begin
    if (rst)
    pres <= idle;
    else
    pres <= next;
end

always @(pres, din) 
begin
y=1'b0;
case (pres)
    idle : y=0;

    got0 : y=0;
    got1 : y=0;

    got00 : y=0;
    got01 : y=0;
    got10 : y=0;
    got11 : y=0;

	got000 : y=1;
	got001 : y=0;
	got010 : y=1;
	got011 : y=0;
	got100 : y=0;
	got101 : y=1;
	got110 : y=0;
	got111 : y=1;
endcase
end

always @(pres, din) begin
next=pres;
case (pres)
    idle : next=din?got1:got0;

    got0 : next=din?got01:got00;
    got1 : next=din?got11:got10;

    got00 : next=din?got001:got000;
    got01 : next=din?got011:got010;
    got10 : next=din?got101:got100;
    got11 : next=din?got111:got110;

	got000 : next=din?got001:got000;
	got001 : next=din?got011:got010;
	got010 : next=din?got101:got100;
	got011 : next=din?got111:got110;
	got100 : next=din?got001:got000;
	got101 : next=din?got011:got010;
	got110 : next=din?got101:got100;
	got111 : next=din?got111:got110;
endcase
end

endmodule

module test();
wire y ;
reg rst, in, clk ; 

initial begin
    $dumpfile("moore.vcd");
	$dumpvars;
end

mealy m(y,clk, rst ,in);

always    
    forever #5 clk = ~clk ;   

initial  
$monitor($time, "Input=%b Output=%b ", in,y );


initial
begin
    clk=1'b0;
    #10 rst=1'b1;
    #10 rst=1'b0;
    #40 rst=1'b0;
    #200 rst=1'b1;
    #1000 $finish;
end

initial repeat(20) @(posedge clk ) in=$random; 

endmodule