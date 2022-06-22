library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity reset_fonction is
    Port ( BNT0 : in STD_LOGIC;
           BNT1 : in STD_LOGIC;
           reset : out STD_LOGIC);
end reset_fonction;

architecture Behavioral of reset_fonction is

begin

reset <= BNT0 and BNT1;

end Behavioral;
