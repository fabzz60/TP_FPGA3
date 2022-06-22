
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

entity state_machine_stepper_motor is
    Port ( clk : in  STD_LOGIC;  --255Hz
           bouton_UP : in  STD_LOGIC;
           bouton_DOWN : in  STD_LOGIC;
			  change_frequency_motor : in  STD_LOGIC_VECTOR (7 downto 0);
           Commandes_demi_pas : out  STD_LOGIC_VECTOR (3 downto 0);
			  vers_change_frequency_motor : out  STD_LOGIC_VECTOR (7 downto 0);
           reset : in  STD_LOGIC;
           visu_UP : out  STD_LOGIC;
           visu_DOWN : out  STD_LOGIC);
end state_machine_stepper_motor;

architecture Behavioral of state_machine_stepper_motor is
TYPE etat IS (attente,position1,position2,position3,position4,position5,position6,position7,position8);
SIGNAL state_machine: etat;
SIGNAL count4 : INTEGER range 0 to 255 := 0; --8 bits compteur
SIGNAL clock_int4: STD_LOGIC :='0';
signal M : INTEGER range 0 to 255;
begin

--Divise par M en fonction de change_frequency_motor--
PROCESS(clk,M,reset,change_frequency_motor)
BEGIN
if reset='1' then
   clock_int4 <='0';
	count4 <=0;
elsif rising_edge(clk) then
   M <= 255/conv_integer(change_frequency_motor);
  	IF count4 <= M-1 THEN
      count4 <= count4 + 1;
		ELSE
      count4 <=0;
   END IF;
	IF count4 <= M/2 THEN --à la moitié du comptage on change la valeur de clock_1Hz_int (rapport cyclique = 1/2)
      clock_int4 <= '0';
   ELSE
      clock_int4 <= '1';
   END IF;

end if;
END PROCESS;

--state machine moteur pas a pas--
process(clock_int4,Reset,bouton_UP,bouton_DOWN)
 begin
 if reset='1' then
 state_machine <= attente;
 Commandes_demi_pas <="0000";
 elsif rising_edge(clock_int4) then 
 case state_machine is   

 when attente => Commandes_demi_pas <="0000";  --0--
                 if bouton_UP = '1' and bouton_DOWN='0' then
                    state_machine <= position1;
					 
					  elsif bouton_UP = '0' and bouton_DOWN='1' then
                    state_machine <= position8;
						  
					  else
                    state_machine <= attente;  
					  end if;
					  	  
                       --UP & DOWN--
 when position1  => Commandes_demi_pas <="0001";  --1--
                 if bouton_UP = '1' and bouton_DOWN='0' then
                    state_machine <= position2;
									  
					  elsif bouton_UP = '0' and bouton_DOWN='1' then
					     state_machine <= position8;  --9-- 
					  
					  else
                    state_machine <= attente;  
					  end if;
					  
 when position2  => Commandes_demi_pas <="0011";  --3--
                 if bouton_UP = '1' and bouton_DOWN='0' then
                    state_machine <= position3;
										  
					  elsif bouton_UP = '0' and bouton_DOWN='1' then
                    state_machine <= position1;   --1--
						  
					  else
                    state_machine <= attente;  
					  end if;

 when position3  => Commandes_demi_pas <="0010";  --2--
                 if bouton_UP = '1' and bouton_DOWN='0' then
                    state_machine <= position4;
					  				  
					  elsif bouton_UP = '0' and bouton_DOWN='1' then
                    state_machine <= position2;   --3--
					  
					  else
                    state_machine <= attente;  
					  end if;
					  
 when position4  => Commandes_demi_pas <="0110";  --6--
                 if bouton_UP = '1' and bouton_DOWN='0' then
                    state_machine <= position5;
					  					  
					  elsif bouton_UP = '0' and bouton_DOWN='1' then
                    state_machine <= position3;   --2--
					
					  else
                    state_machine <= attente;  
					  end if;
					  
 when position5  => Commandes_demi_pas <="0100";  --4--
                 if bouton_UP = '1' and bouton_DOWN='0' then
                    state_machine <= position6;
					  					  
					  elsif bouton_UP = '0' and bouton_DOWN='1' then
                    state_machine <= position4;   --6--

					  else
                    state_machine <= attente;  
					  end if;
					  
 when position6  => Commandes_demi_pas <="1100";  --12--
                 if bouton_UP = '1' and bouton_DOWN='0' then
                    state_machine <= position7;
					  					  
					  elsif bouton_UP = '0' and bouton_DOWN='1' then
                    state_machine <= position5;   --4--
					 				 
					  else
                    state_machine <= attente;  
					  end if;
 
 when position7  => Commandes_demi_pas <="1000";  --8--
                 if bouton_UP = '1' and bouton_DOWN='0' then
                    state_machine <= position8;
					 					  
					  elsif bouton_UP = '0' and bouton_DOWN='1' then
                    state_machine <= position6;   --12--
									  					  					  
					  else
                    state_machine <= attente;  
					  end if;
 
 when position8 => Commandes_demi_pas <="1001";  --9--
                 if bouton_UP = '1' and bouton_DOWN='0' then
                    state_machine <= position1;
					  					  
					  elsif bouton_UP = '0' and bouton_DOWN='1' then
                    state_machine <= position7;   --8--
					  
                 else
                    state_machine <= attente;  
					  end if;
 
end case;
end if;
end process;

vers_change_frequency_motor <= std_logic_vector(change_frequency_motor);
visu_UP <= bouton_UP;
visu_DOWN <= bouton_DOWN;


end Behavioral;

