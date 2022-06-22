
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DECODE_2_to_6 is
    Port ( SEL : in  STD_LOGIC_VECTOR (2 downto 0);
	       -- DP1 : out  STD_LOGIC;
           afficheur_0 : out  STD_LOGIC;
           afficheur_1 : out  STD_LOGIC;
           afficheur_2 : out  STD_LOGIC;
           afficheur_3 : out  STD_LOGIC;
           afficheur_4 : out  STD_LOGIC;
           afficheur_5 : out  STD_LOGIC);
           --afficheur_6 : out  STD_LOGIC;
           --afficheur_7 : out  STD_LOGIC);
end DECODE_2_to_6;

architecture Behavioral of DECODE_2_to_6 is
begin

process(Sel)
begin
--afficheur_0 <='1';afficheur_1 <='1';afficheur_2 <='1';afficheur_3 <='1';afficheur_4 <='1'; afficheur_5 <='1'; afficheur_6 <='1'; afficheur_7 <='1'; DP1 <='1';
afficheur_0 <='1';afficheur_1 <='1';afficheur_2 <='1';afficheur_3 <='1';afficheur_4 <='1'; afficheur_5 <='1'; 
     case sel is
     --when "000"  =>afficheur_0 <='0'; DP1 <='1';
	  when "001"  =>afficheur_1 <='0'; --DP1 <='1';
	  when "010"  =>afficheur_2 <='0'; --DP1 <='1';
	  when "011"  =>afficheur_3 <='0'; --DP1 <='1';
	  when "100"  =>afficheur_4 <='1'; --DP1 <='1';
	  when "101"  =>afficheur_5 <='1'; --DP1 <='1';
	  --when "110"  =>afficheur_6 <='0'; --DP1 <='1';
	  --when "111"  =>afficheur_7 <='0'; --DP1 <='0';
	  when others => afficheur_0 <='0'; --DP1 <='1';
end case;
end process;

end Behavioral;

