
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity clock_manager_CmodA7 is
    Port ( clk : in STD_LOGIC;   --12MHz
           reset : in STD_LOGIC;
           clk_div1 : out STD_LOGIC;  --1000Hz
           clk_div2 : out STD_LOGIC);  --1000Hz
end clock_manager_CmodA7;

architecture Behavioral of clock_manager_CmodA7 is
--pour compter jusqu'a (100000 -1) il faut 17 bits (2^17= 131072 )
signal count1: INTEGER range 0 to 12000 := 0;
SIGNAL clock_int1: STD_LOGIC :='0';
signal count2: INTEGER range 0 to 12000 := 0;
SIGNAL clock_int2: STD_LOGIC :='0';
CONSTANT M1: INTEGER := 12000; --1000Hz
CONSTANT M2: INTEGER := 12000; --1000Hz

begin
--Divise par 10000  FOUT = 1000Hz synchro affichage
PROCESS(clk,reset)
BEGIN
if reset='1' then  
   count1 <= 0;
   count2 <= 0;
ELSIF rising_edge(clk) then
   --if ce ='1' then
      IF count1 <= M1-1 THEN  --Divise par 12000  FOUT = 1000Hz synchro affichage
      count1 <= count1 + 1;
      ELSE
      count1 <= 0;
      END IF;
	
    	IF count2 <= M2-1 THEN  --Divise par 47059  FOUT = 1000Hz synchro affichage
      count2 <= count2 + 1;
      ELSE
      count2 <= 0;
      END IF;
		
	--end if;
END IF;
END PROCESS;

--à la moitié du comptage on change la valeur de clock_int1 (rapport cyclique = 1/2)
clock_int1 <= '1' WHEN count1 <= M1/2 ELSE '0';
clk_div1 <= clock_int1; 
clock_int2 <= '1' WHEN count2 <= M2/2 ELSE '0';
clk_div2<= clock_int2; 


end Behavioral;
