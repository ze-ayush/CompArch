module fulladder(
    input a, b,cin,
    output s, cout
    );
    assign s= a^b^cin;
    assign cout=(a & b) | cin & (a^b);
endmodule

module fa_tb();
reg a,b,cin;
wire s,cout;
fulladder f(a,b,cin,s,cout);
initial
    begin
     $dumpfile("fulladder.vcd");
     $dumpvars;
    end
 always begin
        #0 a=0;
        b=1;
        cin=0;
        #2 $display($time,"A=%b , B=%b, CIN=%b  S=%b, COUT=%b", a,b,cin ,s ,cout);
        #4  a=1;
        b=1;
        cin=0;
        #6 $display($time,"A=%b , B=%b, CIN=%b  S=%b, COUT=%b", a,b,cin ,s ,cout); 
        #8 $finish;
    end



endmodule