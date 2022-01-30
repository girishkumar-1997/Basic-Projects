`timescale 1ns / 1ps

module tlc_tb;

    wire [2:0] n_lights,s_lights,e_lights,w_lights;
    reg clk,rst;
    reg [3:0] emergency,jam,empty;

    traffic_control DUT (.n_lights(n_lights),.s_lights(s_lights),.e_lights(e_lights),
                        .w_lights(w_lights),.clk(clk),.rst(rst),.emergency(emergency),.jam(jam),.empty(empty));

    initial
        begin
            clk=1'b0;
            rst=1'b1;
            #15 rst=1'b0; 
            emergency=4'b0000;
            jam=4'b0000;
            empty=4'b0000;  
        end
    
    always #5 clk = ~clk;
 
     initial
        begin
            
            #75;
            emergency = 4'b0010;
            
            #10;
            emergency = 4'b0000;
            
           
            #150;
             jam = 4'b1000;
                        
            #10;
             jam = 4'b0000;
             
            #312
             empty = 4'b0010;
            #15;
            empty = 4'b0000;
            
            #2000 $finish;
            
        end
endmodule
