module ComputerStrProject_YunKim(input logic[8:0] tenSen,
											input logic[6:0] dBSen,
											input logic ultraSen,
											input logic lightSen,
											input logic [3:0] UVSen,
											input logic [9:0] waterSen,
											input logic [2:0] smokeSen,
											input logic [7:0] dustSen,
											input logic [2:0] blackbox,
											input logic [2:0] gps,
											output logic[1:0] Aircon, 
											output logic win3, win4, win5, win6,
											output logic sun,
											output logic[1:0] wiper,
											output logic[1:0] handle,
											output logic[3:0] engine);

// tensen은 온도센서, 절대 온도에 비례하는 출력 전압을 생성, AD590이라 가정.
// AD590은 1K 당 1µA의 전류를 출력. ex) 상온 25도 = 298.15K = 298.2µA를 출력.
// 5도(278.15K) 이하는 히터, 5~28도 동작 X, 28도(301.15K) 이상 냉방으로 동작하게 코딩. 간단한 구현을 위해 소수점 버림 연산 및 µ은 생략하겠습니다.

// dBSen은 소음측정센서, 입력은 dB 값으로 준다고 가정. 85dB보다 크면 창문을 올린다. 작으면 창문은 건드리지 않는다. 

// ultraSen은 초음파센서, 창문에 사람 신체가 있으면 1을 출력한다고 가정, 사람 신체가 없으면 0을 출력.
// ultraSen이 1이면 창문은 lock이 걸려 열려 있는 상태로 고정된다. 창문이 닫혀있다면 고려하지 않는다.

// Aircon은 00일 때 동작수행X, 01일 때 히터, 10일 때 냉방으로 동작.	
// win3~6은 자동차 옆 창문을 의미. 0은 창문 닫힘을 1은 창문 열림을 의미.

// 창문 썬탠 값(output sun)은 1일 때, 진함을 의미하고, 0일 때, default를 의미합니다.  
// lightSen은 광센서입니다. 광센서는 사용자가 설정한 밝기와 센서로 측정한 빛의 밝기를 비교해 H(1)와 L(0)을 출력합니다. 
// lightSen이 1이 되면 임계값 이상이므로 창문 썬탠값을 진하게(1) 합니다.
// UVSen은 자외선 센서입니다. 자외선센서는 출력전압이 자외선 지수에 맞도록 캘리브레이션이 되어 있어서 출력전압에 10을 곱해주면 그 값이 자외선 지수가 됩니다.
//	대한민국 기상청 기준 자외선지수 8이상을 매우높음으로 규정합니다.
// 그러므로 UVSen에서 오는 값이 8보다 클 경우 창문 썬탠값을 진하게(1) 합니다

// WaterSen은 빗방울 감지 센서입니다. 빗방울 감지센서는 센시가판의 전극부분이 물과 접한 면적이 클수록 저항 값이 작아지고, 흐르는 전류량이 상대적으로 커지게 됩니다.
// 빗방을 감지판에서 감지되는 값이 300이상 500이하이면 와이퍼를 느리게 움직이고, 300 이하이면 와이퍼를 빠르게 움직입니다. 500이상이면 와이퍼는 정지됩니다.
// 와이퍼 정지: 00, 와이퍼 느리게 움직이기: 01, 와이퍼 빠르게 움직이기: 10.

// smokeSen은 인체에 해로운 화재연기감지를 담당하는 센서입니다.
// smokeSen은 Smoke의 농도에 따라 출력 전압이 달라지고, 농도가 약 480ppm 이상일때 3.06V를 출력합니다.
// 농도 480ppm 이상일때 3V를 출력한다고 단순화 하겠습니다.
// 농도가 480ppm 이상일 경우(입력값 3v이상 일 때,)창문을 닫도록 동작합니다.

// dustSen은 미세먼지를 측정하는 센서입니다.
// 대한민국 미세먼지 환경기준으로 150㎍/m³ 이상을 나쁨으로 규정합니다.
// dustSen은 ㎍/m³ 단위로 미세먼지 농도를 출력합니다.
// dustSen이 150 이상 값을 제공하면, 창문을 닫도록 동작합니다.
 
 
// blackbox는 자동차의 시각을 담당하며 다음과 같은 신호를 봅니다.
// 기본 000, 빨간불 001, 노란불 010, 초록불 011,
// 전방장애물 100, 좌회전 101, 우회전 110

// handle은 다음과 같은 동작을 수행합니다.
// 정주행 00, 좌회전 01, 우회전 10

// engine은 다음과 같은 동작을 수행합니다.
// 정지 0000, 10km/h 0001, 20km/h 0010, ... 150km/h 1111.

// gps는 해당 위치의 도로 상태를 반환합니다.
// 고속도로 편도 2차로 이상 1번째 111, 고속도로 편도 2차로 이상 2번째 110, 고속도로 편도 2차로 이상 3번째이하 101, 고속도로 편도 1차로 100, 
// 자동차 전용도로 011, 일반도로(편도 4차로 이상) 010, 일반도로(편도 1~3차로) 001 , 골목길(일반통행) 000.


	always @ (tenSen or dBSen or ultraSen or smokeSen or dustSen)
		begin
			if(ultraSen == 1)begin
				Aircon = 2'b00;	
				win3 = 1; 
				win4 = 1; 
				win5 = 1; 
			   win6 = 1;
			end else if(tenSen > 9'b1_0010_1101 & ultraSen == 0)begin
				Aircon = 2'b10;	
				win3 = 0; 
				win4 = 0; 
				win5 = 0; 
			   win6 = 0;
			end else if(tenSen < 9'b1_0001_0110 & ultraSen == 0)begin					
				Aircon = 2'b01;					
				win3 = 0; 
				win4 = 0; 
				win5 = 0; 
				win6 = 0;
			end else if (dBSen > 7'b101_0101 & smokeSen >= 3'b011 & dustSen >= 8'b1001_0110 & ultraSen == 0)begin
				Aircon = 2'b00;
				win3 = 0; 
				win4 = 0; 
				win5 = 0; 
				win6 = 0;
			end else if (dBSen > 7'b101_0101 & smokeSen >= 3'b011 & dustSen < 8'b1001_0110 & ultraSen == 0)begin
				Aircon = 2'b00;
				win3 = 0; 
				win4 = 0; 
				win5 = 0; 
				win6 = 0;
			end else if (dBSen > 7'b101_0101 & smokeSen < 3'b011 & dustSen >= 8'b1001_0110 & ultraSen == 0)begin
				Aircon = 2'b00;
				win3 = 0; 
				win4 = 0; 
				win5 = 0; 
				win6 = 0;
			end else if (dBSen > 7'b101_0101 & smokeSen < 3'b011 & dustSen < 8'b1001_0110 & ultraSen == 0)begin
				Aircon = 2'b00;
				win3 = 0; 
				win4 = 0; 
				win5 = 0; 
				win6 = 0;
			end else if (dBSen < 7'b101_0101 & smokeSen >= 3'b011 & dustSen >= 8'b1001_0110 & ultraSen == 0)begin
				Aircon = 2'b00;
				win3 = 0; 
				win4 = 0; 
				win5 = 0; 
				win6 = 0;
			end else if (dBSen < 7'b101_0101 & smokeSen >= 3'b011 & dustSen < 8'b1001_0110 & ultraSen == 0)begin
				Aircon = 2'b00;
				win3 = 0; 
				win4 = 0; 
				win5 = 0; 
				win6 = 0;
			end else if (dBSen < 7'b101_0101 & smokeSen < 3'b011 & dustSen >= 8'b1001_0110 & ultraSen == 0)begin
				Aircon = 2'b00;
				win3 = 0; 
				win4 = 0; 
				win5 = 0; 
				win6 = 0;
			end else if (dBSen < 7'b101_0101 & smokeSen < 3'b011 & dustSen < 8'b1001_0110 & ultraSen == 0)begin
				Aircon = 2'b00;
				win3 = 1; 
				win4 = 1; 
				win5 = 1; 
				win6 = 1;
			end 
		end


	always @ (lightSen or UVSen)
		begin
			if(lightSen == 1 | UVSen >= 8)
				sun = 1;
			else
				sun = 0;
		end
	
	
	always @ (waterSen)
		begin
			if(waterSen >= 500)
				wiper = 2'b00;
			else if (300 <= waterSen & waterSen < 500)
				wiper = 2'b01;
			else if (waterSen < 300)
				wiper = 2'b10;
			else 
				wiper = 2'b00;
		end
	
	
	always @ (blackbox or gps)
		begin
			if(blackbox == 3'b000 & gps == 3'b000)begin
				handle = 2'b00;
				engine = 4'b0001;
			end else if(blackbox == 3'b000 & gps == 3'b001)begin
				handle = 2'b00;
				engine = 4'b0100;
			end else if(blackbox == 3'b000 & gps == 3'b010)begin
				handle = 2'b00;
				engine = 4'b0101;
			end else if(blackbox == 3'b000 & gps == 3'b011)begin
				handle = 2'b00;
				engine = 4'b1000;
			end else if(blackbox == 3'b000 & gps == 3'b100)begin
				handle = 2'b00;
				engine = 4'b1000;
			end else if(blackbox == 3'b000 & gps == 3'b101)begin
				handle = 2'b00;
				engine = 4'b1010;
			end else if(blackbox == 3'b000 & gps == 3'b110)begin
				handle = 2'b00;
				engine = 4'b1011;
			end else if(blackbox == 3'b000 & gps == 3'b111)begin
				handle = 2'b00;
				engine = 4'b1100;
			end else if(blackbox == 3'b001 & gps == 3'b000)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b001 & gps == 3'b001)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b001 & gps == 3'b010)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b001 & gps == 3'b011)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b001 & gps == 3'b100)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b001 & gps == 3'b101)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b001 & gps == 3'b110)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b001 & gps == 3'b111)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b010 & gps == 3'b000)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b010 & gps == 3'b001)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b010 & gps == 3'b010)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b010 & gps == 3'b011)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b010 & gps == 3'b100)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b010 & gps == 3'b101)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b010 & gps == 3'b110)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b010 & gps == 3'b111)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b011 & gps == 3'b000)begin
				handle = 2'b00;
				engine = 4'b0001;
			end else if(blackbox == 3'b011 & gps == 3'b001)begin
				handle = 2'b00;
				engine = 4'b0100;
			end else if(blackbox == 3'b011 & gps == 3'b010)begin
				handle = 2'b00;
				engine = 4'b0101;
			end else if(blackbox == 3'b011 & gps == 3'b011)begin
				handle = 2'b00;
				engine = 4'b1000;
			end else if(blackbox == 3'b011 & gps == 3'b100)begin
				handle = 2'b00;
				engine = 4'b1000;
			end else if(blackbox == 3'b011 & gps == 3'b101)begin
				handle = 2'b00;
				engine = 4'b1010;
			end else if(blackbox == 3'b011 & gps == 3'b110)begin
				handle = 2'b00;
				engine = 4'b1011;
			end else if(blackbox == 3'b011 & gps == 3'b111)begin
				handle = 2'b00;
				engine = 4'b1100;
			end else if(blackbox == 3'b100 & gps == 3'b000)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b100 & gps == 3'b001)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b100 & gps == 3'b010)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b100 & gps == 3'b011)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b100 & gps == 3'b100)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b100 & gps == 3'b101)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b100 & gps == 3'b110)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b100 & gps == 3'b111)begin
				handle = 2'b00;
				engine = 4'b0000;
			end else if(blackbox == 3'b101 & gps == 3'b000)begin
				handle = 2'b01;
				engine = 4'b0001;
			end else if(blackbox == 3'b101 & gps == 3'b001)begin
				handle = 2'b01;
				engine = 4'b0010;
			end else if(blackbox == 3'b101 & gps == 3'b010)begin
				handle = 2'b01;
				engine = 4'b0010;
			end else if(blackbox == 3'b101 & gps == 3'b011)begin
				handle = 2'b01;
				engine = 4'b0010;
			end else if(blackbox == 3'b101 & gps == 3'b100)begin
				handle = 2'b01;
				engine = 4'b0010;
			end else if(blackbox == 3'b101 & gps == 3'b101)begin
				handle = 2'b01;
				engine = 4'b0010;
			end else if(blackbox == 3'b101 & gps == 3'b110)begin
				handle = 2'b01;
				engine = 4'b0010;
			end else if(blackbox == 3'b101 & gps == 3'b111)begin
				handle = 2'b01;
				engine = 4'b0010;
			end else if(blackbox == 3'b110 & gps == 3'b000)begin
				handle = 2'b10;
				engine = 4'b0001;
			end else if(blackbox == 3'b110 & gps == 3'b001)begin
				handle = 2'b10;
				engine = 4'b0001;
			end else if(blackbox == 3'b110 & gps == 3'b010)begin
				handle = 2'b10;
				engine = 4'b0001;
			end else if(blackbox == 3'b110 & gps == 3'b011)begin
				handle = 2'b10;
				engine = 4'b0001;
			end else if(blackbox == 3'b110 & gps == 3'b100)begin
				handle = 2'b10;
				engine = 4'b0001;
			end else if(blackbox == 3'b110 & gps == 3'b101)begin
				handle = 2'b10;
				engine = 4'b0001;
			end else if(blackbox == 3'b110 & gps == 3'b110)begin
				handle = 2'b10;
				engine = 4'b0001;
			end else if(blackbox == 3'b110 & gps == 3'b111)begin
				handle = 2'b10;
				engine = 4'b0001;
			end 		
		end
		
endmodule