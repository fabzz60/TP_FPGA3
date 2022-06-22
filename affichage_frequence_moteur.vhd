library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;


entity affichage_frequence is
    Port ( frequency_in_motor : in  STD_LOGIC_VECTOR (7 downto 0);
           affichage_frequence_digit0 : out  STD_LOGIC_VECTOR (3 downto 0);
           affichage_frequence_digit1 : out  STD_LOGIC_VECTOR (3 downto 0);
           affichage_frequence_digit2 : out  STD_LOGIC_VECTOR (3 downto 0);
           affichage_frequence_digit3 : out  STD_LOGIC_VECTOR (3 downto 0));
end affichage_frequence;

architecture Behavioral of affichage_frequence is
signal Q : STD_LOGIC_VECTOR (7 downto 0);
begin

Q <= frequency_in_motor;

process(Q)
  -- variable temporaire 
  variable temp  : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  variable  bcd  : STD_LOGIC_VECTOR ( 15  downto 0 );
  
begin 
                             --    2    4    3
                            --   0010 0100 0011 
									 
							--	<---------ORIGINAL
				      --000 0000 0000 11110011

--Le double dabble est un algorithme utilisé pour convertir des nombres d'un système-- 
--binaire vers un système décimal. Pour des raisons pratiques, le résultat est-- 
--généralement stocké sous la forme de décimal codé en binaire (BCD)--
--En partant du registre initial, l'algorithme effectue n itérations (soit 8 dans l'exemple)
--a chaque itération, le registre est décalé d'un bit vers la gauche. Avant d'effectuer cette opération, 
--la partie au format BCD est analysée, décimale par décimale. Si une décimale en BCD (4 bits)
--est plus grande que 4 alors on lui ajoute 3. Cette incrément permet de s'assurer qu'une valeur de 5, 
--après incrémentation et décalage, devient 16 et se propage correctement à la décimale suivante.     
	                 ---   0000 0000 0000 11110011      Initialisation
                    ---   0000 0000 0001 11100110      Décalage
                    ---   0000 0000 0011 11001100      Décalage
                    ---   0000 0000 0111 10011000      Décalage
                    ---   0000 0000 1010 10011000      Ajouter 3 à la première décimale BCD, puisque sa valeur était 7
                    ---   0000 0001 0101 00110000      Décalage
                    ---   0000 0001 1000 00110000      Ajouter 3 à la première décimale BCD, puisque sa valeur était 5
                    ---   0000 0011 0000 01100000      Décalage
                    ---   0000 0110 0000 11000000      Décalage
                    ---   0000 1001 0000 11000000      Ajouter 3 à la seconde décimale BCD, puisque sa valeur était 6
                    ---   0001 0010 0001 10000000      Décalage
                    --    0010 0100 0011 00000000      Décalage
								  --2----4---3--
								  
		--mettre à zéro la variable bcd 
	 bcd   := (others => '0');
    
	    		 
	        temp(7 downto 0) :=  Q ;
			  
			   for i in 0 to 7 loop
				
		if bcd(3 downto 0) > 4 then 
         bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;
      
      if bcd(7 downto 4) > 4 then 
         bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;
    
      if bcd(11 downto 8) > 4 then  
         bcd(11 downto 8) := bcd(11 downto 8) + 3;
      end if;
    
      -- thousands can't be >4 for a 12-bit input number
      -- so don't need to do anything to upper 4 bits of bcd
    
      -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
      bcd := bcd(14 downto 0) & temp(7);
    
      -- shift temp left by 1 bit
      temp := temp(6 downto 0) & '0';
    end loop; 
				 
			 
			 -- set outputs    		 
          affichage_frequence_digit0 <=  STD_LOGIC_VECTOR (bcd(3 downto 0));
          affichage_frequence_digit1 <=  STD_LOGIC_VECTOR (bcd(7 downto 4));
          affichage_frequence_digit2 <=  STD_LOGIC_VECTOR (bcd(11 downto 8));
          affichage_frequence_digit3 <=  STD_LOGIC_VECTOR (bcd(15 downto 12));
       
end process;
end Behavioral;

