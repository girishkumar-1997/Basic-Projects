`timescale 1ns / 1ps

module traffic_control(n_lights,s_lights,e_lights,w_lights,clk,rst,emergency,jam,empty);

   output reg [2:0] n_lights,s_lights,e_lights,w_lights; 
   input      clk,rst;
   input [3:0] emergency,jam,empty;
 
   reg [2:0] state;
 
   parameter [2:0] north_g = 3'b000,
                   north_y = 3'b001,
                   south_g = 3'b010,
                   south_y = 3'b011,
                   east_g  = 3'b100,
                   east_y  = 3'b101,
                   west_g  = 3'b110,
                   west_y  = 3'b111;

   reg [3:0] count;
 

   always @(posedge clk, posedge rst)
     begin
        if (rst)
            begin
                count =4'b0000;
            end
            
        else if(|emergency)
	       begin
		      state = {emergency[1]|emergency[0],emergency[2]|emergency[0],1'b0};
              count =4'b0000;
	       end
	       
	    else if(|jam)
	       begin
		      state = {jam[1]|jam[0],jam[2]|jam[0],1'b0} ;
		      count = 4'b0000;
	       end
	       
	    else
            begin
                case (state)
                    north_g : if (count==4'b1010 || empty == 4'b1000)
                                begin
                                    count=4'b0000;
                                    state=north_y;
                                end
                              else
                                begin
                                    count=count+4'b0001;
                                    state=north_g;
                                end

                    north_y : if (count==4'b0100)
                                begin
                                    count=4'b0000;
                                    state=south_g;
                                end
                               else
                                    begin
                                    count=count+4'b0001;
                                    state=north_y;
                                    end
            

                    south_g : if (count==4'b1010 || empty == 4'b0100)
                                begin
                                    count=4'b0000;
                                    state=south_y;
                                end
                              else
                                begin
                                    count=count+4'b0001;
                                    state=south_g;
                                end
         
                    south_y :if (count==4'b0100)
                                begin
                                    count=4'b0000;
                                    state=east_g;
                                end
                             else
                                begin
                                    count=count+4'b0001;
                                    state=south_y;
                                end

                    east_g :if (count==4'b1010 || empty == 4'b0010)
                                begin
                                    count=4'b0000;
                                    state=east_y;
                                end
                            else
                                 begin
                                    count=count+4'b0001;
                                    state=east_g;
                                 end
                
                    east_y :if (count==4'b0100)
                                begin
                                    count=4'b0000;
                                    state=west_g;
                                end
                            else
                                begin
                                    count=count+4'b0001;
                                    state=east_y;
                                end
           
                    west_g :if (count==4'b1010 || empty == 4'b0010)
                                begin
                                     count=4'b0000;
                                     state=west_y;
                                end
                            else
                                begin
                                    count=count+4'b0001;
                                    state=west_g;
                                end
                   
                    west_y :if (count==4'b0100)
                                begin
                                    count=4'b0000;
                                    state=north_g;
                                end
                            else
                                begin
                                    count=count+4'b0001;
                                    state=west_y;
                                end
                  
	               default: 
		                      begin
			                     count=4'b0000;
                                 state=north_g;
		                      end
                    endcase 
        end 
    end 


always @(state)
     begin
         case (state)
            north_g :
                begin
                    n_lights = 3'b001;
                    s_lights = 3'b100;
                    e_lights = 3'b100;
                    w_lights = 3'b100;
                end 
            north_y :
                begin
                    n_lights = 3'b010;
                    s_lights = 3'b100;
                    e_lights = 3'b100;
                    w_lights = 3'b100;
                end 

            south_g :
                begin
                    n_lights = 3'b100;
                    s_lights = 3'b001;
                    e_lights = 3'b100;
                    w_lights = 3'b100;
                end 
            south_y :
                begin
                    n_lights = 3'b100;
                    s_lights = 3'b010;
                    e_lights = 3'b100;
                    w_lights = 3'b100;
                end 
            
            east_g :
                begin
                     n_lights = 3'b100;
                     s_lights = 3'b100;
                     e_lights = 3'b001;
                     w_lights = 3'b100;
                                    end 
                    
             east_y :
                 begin
                      n_lights = 3'b100;
                      s_lights = 3'b100;
                      e_lights = 3'b010;
                      w_lights = 3'b100;
                  end 

            west_g :
                begin
                    n_lights = 3'b100;
                    s_lights = 3'b100;
                    e_lights = 3'b100;
                    w_lights = 3'b001;
                end 
            west_y :
                begin
                    n_lights = 3'b100;
                    s_lights = 3'b100;
                    e_lights = 3'b100;
                    w_lights = 3'b010;
                end 
            endcase
     end 
endmodule
