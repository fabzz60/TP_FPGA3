
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity CompteurBCD_4095 is

    Port ( CLK : in STD_LOGIC; --255Hz
	       change_frequency_motor : in STD_LOGIC_VECTOR (7 downto 0);
           bouton_UP : in STD_LOGIC;
           bouton_DOWN : in STD_LOGIC;
           Enable : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Full : out STD_LOGIC;
           Empty : out STD_LOGIC);
           --BCD_U : out STD_LOGIC_VECTOR (3 downto 0);
           --BCD_D : out STD_LOGIC_VECTOR (3 downto 0);
           --BCD_H : out STD_LOGIC_VECTOR (3 downto 0);
           --BCD_T: out STD_LOGIC_VECTOR (3 downto 0)
           --);
end CompteurBCD_4095;

architecture Behavioral of CompteurBCD_4095 is
SIGNAL count3 : INTEGER range 0 to 255 := 0; --8 bits compteur
SIGNAL clock_int3: STD_LOGIC;
signal M : INTEGER range 0 to 255;

signal COUNTER_U: INTEGER range 0 to 9;	
signal COUNTER_D: INTEGER range 0 to 9;
signal COUNTER_H: INTEGER range 0 to 9;	
signal COUNTER_T: INTEGER range 0 to 9;

signal IS_4096: STD_LOGIC;
signal IS_0000: STD_LOGIC;
begin

--Divise par M en fonction de change_frequency_motor--
PROCESS(clk,reset,M,change_frequency_motor)
BEGIN
if reset ='1' then 
   count3 <= 0;
elsif rising_edge(clk) then
--if enable ='1' then
 if change_frequency_motor >0 then
   M <= 255/conv_integer(change_frequency_motor);
	IF count3 <= M-1 THEN
      count3 <= count3 + 1;
   ELSE
      count3 <= 0;
   END IF;
	IF count3 <= M/2 THEN --à la moitié du comptage on change la valeur de clock_1Hz_int (rapport cyclique = 1/2)
      clock_int3 <= '0';
   ELSE
      clock_int3 <= '1';
   END IF;
 else
   clock_int3 <= '0';
end if;
end if;
END PROCESS;


process(clock_int3,Enable,reset,bouton_UP,bouton_DOWN)
begin
if Reset='1' then
      COUNTER_U  <= 0;
      COUNTER_D  <= 0;
      COUNTER_H  <= 0;  
		COUNTER_T  <= 0;
elsif rising_edge(clock_int3) then 
     if Enable = '1' then 
		 if bouton_UP ='1' then
		    if IS_4096 = '1' then 
			    COUNTER_U  <= 0;
             COUNTER_D  <= 0;
             COUNTER_H  <= 0;  
		       COUNTER_T  <= 0;
           elsif IS_4096 = '0' then 			  
            if COUNTER_U = 9 then
	     	      COUNTER_U <= 0;
	     	   if COUNTER_D = 9 then
                  COUNTER_D <= 0;
               if COUNTER_H = 9 then
                  COUNTER_H <= 0;
               if COUNTER_T = 9 then
                  COUNTER_T <= 0;
               else
               COUNTER_T <= COUNTER_T + 1;
               end if; 
               else
               COUNTER_H <= COUNTER_H + 1;
               end if;  
               else
               COUNTER_D <= COUNTER_D + 1;
               end if;
               else
               COUNTER_U <= COUNTER_U + 1;
               end if;
            end if;
		
        end if;			  
      if bouton_DOWN ='1' then
		
		            if  IS_0000 ='0' then 
                       if COUNTER_U = 0 then
                          COUNTER_U <= 9;
                       if COUNTER_D = 0 then
                          COUNTER_D <= 9;
                       if COUNTER_H = 0 then
                          COUNTER_H <= 9;
                       if COUNTER_T = 0 then
                          COUNTER_T <= 9;
                       else
                       COUNTER_T <= COUNTER_T - 1;
                       end if;
                       else
                       COUNTER_H <= COUNTER_H - 1;
                       end if;
                       else
                       COUNTER_D <= COUNTER_D - 1;
                       end if;
                       else
                       COUNTER_U <= COUNTER_U - 1;
                       end if;
                  end if; 
		end if;
end if;
end if;
end process;

 
 --BCD_U <= CONV_STD_LOGIC_VECTOR(COUNTER_U,4);
 --BCD_D <= CONV_STD_LOGIC_VECTOR(COUNTER_D,4);
 --BCD_H <= CONV_STD_LOGIC_VECTOR(COUNTER_H,4); 
 --BCD_T <= CONV_STD_LOGIC_VECTOR(COUNTER_T,4);
   
 IS_4096 <= '1' when (COUNTER_U = 6 and COUNTER_D = 9 and COUNTER_H = 0 and COUNTER_T = 4) else '0';
 IS_0000 <= '1' when (COUNTER_U = 0 and COUNTER_D = 0 and COUNTER_H = 0 and COUNTER_T = 0) else '0';
 Full <= IS_4096; 
 Empty <= IS_0000;

 
end Behavioral;
