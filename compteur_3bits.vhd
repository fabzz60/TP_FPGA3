
library IEEE;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity compteur is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           sortie_compteur : out  STD_LOGIC_VECTOR (2 downto 0));
end compteur;

architecture Behavioral of compteur is
signal compte : std_logic_vector(2 downto 0);
begin

process(CLK,reset)
BEGIN 
if reset ='1' then
   compte <="000";
elsif rising_edge(CLK) then
    if enable ='1' then
       compte <= compte + 1; 
    end if;
end if;
END PROCESS; 

Sortie_compteur <= compte;
end Behavioral;

