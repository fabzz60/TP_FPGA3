library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

entity USB_com is
    Port ( reset : in std_logic;
	       codeur_in : in  STD_LOGIC_VECTOR (7 downto 0);
           enable: in std_logic; 
           RX_DV : in  STD_LOGIC;
           Rx_data_Uart : in  STD_LOGIC_VECTOR (7 downto 0);
           select_codeur_or_uart : in  STD_LOGIC;
           motor_UP : out  STD_LOGIC;
           motor_down : out  STD_LOGIC;
           reglage_frequency_motor : out  STD_LOGIC_VECTOR (7 downto 0));
end USB_com;

architecture Behavioral of USB_com is
-- define the new type for the 3x8 octets RAM 
type RAM_ARRAY is array (0 to 1) of std_logic_vector (7 downto 0);
--signal RAM_ADDR: STD_LOGIC_VECTOR (1 downto 0); -- Address to write/read RAM
signal RAM_ADDR: integer range 0 to 1; -- Address to write/read RAM
-- initial values in the RAM
signal RAM: RAM_ARRAY :=(
   x"00",x"00"
   );
signal data_uart : STD_LOGIC_VECTOR (7 downto 0);

begin


process(RX_DV,enable,reset)
begin
if reset ='1' then
   RAM_ADDR <= 0;
	RAM(0) <=X"00";
	RAM(1) <=X"00";

elsif rising_edge(RX_DV) then
  if enable ='1' then
    IF RAM_ADDR <=2 THEN
       RAM_ADDR <= RAM_ADDR + 1;
	 ELSE 
	    RAM_ADDR <=0;
	 END IF;	
	 --RAM(to_integer(unsigned(RAM_ADDR))) <= Rx_data_Uart;	 -- converts RAM_ADDR from std_logic_vector -> Unsigned -> Integer using numeric_std library
    RAM((RAM_ADDR)) <= Rx_data_Uart;
 end if;
end if;
end process;


motor_UP <= '1' when  RAM(0)= X"01" and select_codeur_or_uart ='1'  else '0'; 
motor_DOWN <= '1' when  RAM(0)= X"02" and select_codeur_or_uart ='1' else '0';
reglage_frequency_motor <= RAM(1) when select_codeur_or_uart ='1' else codeur_in;

end Behavioral;

