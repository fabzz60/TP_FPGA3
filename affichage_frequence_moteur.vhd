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

--Le double dabble est un algorithme utilis� pour convertir des nombres d'un syst�me-- 
--binaire vers un syst�me d�cimal. Pour des raisons pratiques, le r�sultat est-- 
--g�n�ralement stock� sous la forme de d�cimal cod� en binaire (BCD)--
--En partant du registre initial, l'algorithme effectue n it�rations (soit 8 dans l'exemple)
--a chaque it�ration, le registre est d�cal� d'un bit vers la gauche. Avant d'effectuer cette op�ration, 
--la partie au format BCD est analys�e, d�cimale par d�cimale. Si une d�cimale en BCD (4 bits)
--est plus grande que 4 alors on lui ajoute 3. Cette incr�ment permet de s'assurer qu'une valeur de 5, 
--apr�s incr�mentation et d�calage, devient 16 et se propage correctement � la d�cimale suivante.     
	                 ---   0000 0000 0000 11110011      Initialisation
                    ---   0000 0000 0001 11100110      D�calage
                    ---   0000 0000 0011 11001100      D�calage
                    ---   0000 0000 0111 10011000      D�calage
                    ---   0000 0000 1010 10011000      Ajouter 3 � la premi�re d�cimale BCD, puisque sa valeur �tait 7
                    ---   0000 0001 0101 00110000      D�calage
                    ---   0000 0001 1000 00110000      Ajouter 3 � la premi�re d�cimale BCD, puisque sa valeur �tait 5
                    ---   0000 0011 0000 01100000      D�calage
                    ---   0000 0110 0000 11000000      D�calage
                    ---   0000 1001 0000 11000000      Ajouter 3 � la seconde d�cimale BCD, puisque sa valeur �tait 6
                    ---   0001 0010 0001 10000000      D�calage
                    --    0010 0100 0011 00000000      D�calage
								  --2----4---3--
								  
		--mettre � z�ro la variable bcd 
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

