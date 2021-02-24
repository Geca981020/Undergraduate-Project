module tb_ComputerStrProject_YunKim();
	// input
	logic[8:0] tenSen;
	logic[6:0] dBSen;
	logic ultraSen;
	logic lightSen;
	logic[3:0] UVSen;
	logic[9:0] waterSen;
	logic [2:0] smokeSen;
	logic [7:0] dustSen;
	logic [2:0] blackbox;
	logic [2:0] gps;
	// output
	logic[1:0] Aircon; 
	logic win3, win4, win5, win6;
	logic sun;
	logic[1:0] wiper;
	logic[1:0] handle;
	logic[3:0] engine;
	
	ComputerStrProject_YunKim dut(tenSen, dBSen, ultraSen, lightSen, UVSen, waterSen, smokeSen, dustSen, blackbox, gps, Aircon, win3, win4, win5, win6, sun, wiper, handle, engine);
	
	initial begin		
		// Aircon, win3, win4, win5, win6 test
		ultraSen = 1; tenSen = 9'b1_0010_1111; dBSen = 7'b101_0111; smokeSen = 3'b100; dustSen = 8'b1001_0111; #10;
		
		ultraSen = 0; tenSen = 9'b1_0010_1111; dBSen = 7'b101_0111; smokeSen = 3'b100; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0010_1111; dBSen = 7'b101_0111; smokeSen = 3'b100; dustSen = 8'b1001_0101; #10;
		ultraSen = 0; tenSen = 9'b1_0010_1111; dBSen = 7'b101_0111; smokeSen = 3'b010; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0010_1111; dBSen = 7'b101_0111; smokeSen = 3'b010; dustSen = 8'b1001_0101; #10;
		ultraSen = 0; tenSen = 9'b1_0010_1111; dBSen = 7'b101_0000; smokeSen = 3'b100; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0010_1111; dBSen = 7'b101_0000; smokeSen = 3'b100; dustSen = 8'b1001_0101; #10;
		ultraSen = 0; tenSen = 9'b1_0010_1111; dBSen = 7'b101_0000; smokeSen = 3'b010; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0010_1111; dBSen = 7'b101_0000; smokeSen = 3'b010; dustSen = 8'b1001_0101; #10;
		
		ultraSen = 0; tenSen = 9'b1_0001_0100; dBSen = 7'b101_0111; smokeSen = 3'b100; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0001_0100; dBSen = 7'b101_0111; smokeSen = 3'b100; dustSen = 8'b1001_0101; #10;
		ultraSen = 0; tenSen = 9'b1_0001_0100; dBSen = 7'b101_0111; smokeSen = 3'b010; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0001_0100; dBSen = 7'b101_0111; smokeSen = 3'b010; dustSen = 8'b1001_0101; #10;
		ultraSen = 0; tenSen = 9'b1_0001_0100; dBSen = 7'b101_0000; smokeSen = 3'b100; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0001_0100; dBSen = 7'b101_0000; smokeSen = 3'b100; dustSen = 8'b1001_0101; #10;
		ultraSen = 0; tenSen = 9'b1_0001_0100; dBSen = 7'b101_0000; smokeSen = 3'b010; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0001_0100; dBSen = 7'b101_0000; smokeSen = 3'b010; dustSen = 8'b1001_0101; #10;
		
		ultraSen = 0; tenSen = 9'b1_0001_1110; dBSen = 7'b101_0111; smokeSen = 3'b100; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0001_1110; dBSen = 7'b101_0111; smokeSen = 3'b100; dustSen = 8'b1001_0101; #10;
		ultraSen = 0; tenSen = 9'b1_0001_1110; dBSen = 7'b101_0111; smokeSen = 3'b010; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0001_1110; dBSen = 7'b101_0111; smokeSen = 3'b010; dustSen = 8'b1001_0101; #10;
		ultraSen = 0; tenSen = 9'b1_0001_1110; dBSen = 7'b101_0000; smokeSen = 3'b100; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0001_1110; dBSen = 7'b101_0000; smokeSen = 3'b100; dustSen = 8'b1001_0101; #10;
		ultraSen = 0; tenSen = 9'b1_0001_1110; dBSen = 7'b101_0000; smokeSen = 3'b010; dustSen = 8'b1001_0111; #10;
		ultraSen = 0; tenSen = 9'b1_0001_1110; dBSen = 7'b101_0000; smokeSen = 3'b010; dustSen = 8'b1001_0101; #10;
		
		// sun test
		lightSen = 0; UVSen = 0; #10;
		lightSen = 1; UVSen = 0; #10;
		lightSen = 0; UVSen = 0; #10;
		lightSen = 0; UVSen = 0.8*10; #10;
		lightSen = 0; UVSen = 0.6*10; #10;
		lightSen = 1; UVSen = 0.8*10; #10;
		
		// wiper test
		waterSen = 500; #10;
		waterSen = 400; #10;
		waterSen = 250; #10;
		
		// handle, engine test
		blackbox = 3'b000; gps = 3'b000; #10;
		blackbox = 3'b000; gps = 3'b001; #10;
		blackbox = 3'b000; gps = 3'b010; #10;
		blackbox = 3'b000; gps = 3'b011; #10;
		blackbox = 3'b000; gps = 3'b100; #10;
		blackbox = 3'b000; gps = 3'b101; #10;
		blackbox = 3'b000; gps = 3'b110; #10;
		blackbox = 3'b000; gps = 3'b111; #10;
		
		blackbox = 3'b001; gps = 3'b000; #10;
		blackbox = 3'b001; gps = 3'b001; #10;
		blackbox = 3'b001; gps = 3'b010; #10;
		blackbox = 3'b001; gps = 3'b011; #10;
		blackbox = 3'b001; gps = 3'b100; #10;
		blackbox = 3'b001; gps = 3'b101; #10;
		blackbox = 3'b001; gps = 3'b110; #10;
		blackbox = 3'b001; gps = 3'b111; #10;
		
		blackbox = 3'b010; gps = 3'b000; #10;
		blackbox = 3'b010; gps = 3'b001; #10;
		blackbox = 3'b010; gps = 3'b010; #10;
		blackbox = 3'b010; gps = 3'b011; #10;
		blackbox = 3'b010; gps = 3'b100; #10;
		blackbox = 3'b010; gps = 3'b101; #10;
		blackbox = 3'b010; gps = 3'b110; #10;
		blackbox = 3'b010; gps = 3'b111; #10;
		
		blackbox = 3'b011; gps = 3'b000; #10;
		blackbox = 3'b011; gps = 3'b001; #10;
		blackbox = 3'b011; gps = 3'b010; #10;
		blackbox = 3'b011; gps = 3'b011; #10;
		blackbox = 3'b011; gps = 3'b100; #10;
		blackbox = 3'b011; gps = 3'b101; #10;
		blackbox = 3'b011; gps = 3'b110; #10;
		blackbox = 3'b011; gps = 3'b111; #10;
		
		blackbox = 3'b100; gps = 3'b000; #10;
		blackbox = 3'b100; gps = 3'b001; #10;
		blackbox = 3'b100; gps = 3'b010; #10;
		blackbox = 3'b100; gps = 3'b011; #10;
		blackbox = 3'b100; gps = 3'b100; #10;
		blackbox = 3'b100; gps = 3'b101; #10;
		blackbox = 3'b100; gps = 3'b110; #10;
		blackbox = 3'b100; gps = 3'b111; #10;
		
		blackbox = 3'b101; gps = 3'b000; #10;
		blackbox = 3'b101; gps = 3'b001; #10;
		blackbox = 3'b101; gps = 3'b010; #10;
		blackbox = 3'b101; gps = 3'b011; #10;
		blackbox = 3'b101; gps = 3'b100; #10;
		blackbox = 3'b101; gps = 3'b101; #10;
		blackbox = 3'b101; gps = 3'b110; #10;
		blackbox = 3'b101; gps = 3'b111; #10;
		
		blackbox = 3'b110; gps = 3'b000; #10;
		blackbox = 3'b110; gps = 3'b001; #10;
		blackbox = 3'b110; gps = 3'b010; #10;
		blackbox = 3'b110; gps = 3'b011; #10;
		blackbox = 3'b110; gps = 3'b100; #10;
		blackbox = 3'b110; gps = 3'b101; #10;
		blackbox = 3'b110; gps = 3'b110; #10;
		blackbox = 3'b110; gps = 3'b111; #10;
	end
	
endmodule