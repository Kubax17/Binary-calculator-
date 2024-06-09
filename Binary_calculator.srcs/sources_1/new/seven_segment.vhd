library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seven_segment is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (7 downto 0));
end seven_segment;

architecture Behavioral of seven_segment is
begin
    seven_seg <= "11000000" WHEN A = "0000" ELSE
                 "11111001" WHEN A = "0001" ELSE
                 "10100100" WHEN A = "0010" ELSE
                 "10110000" WHEN A = "0011" ELSE
                 "10011001" WHEN A = "0100" ELSE
                 "10010010" WHEN A = "0101" ELSE
                 "10000010" WHEN A = "0110" ELSE
                 "11111000" WHEN A = "0111" ELSE
                 "10000000" WHEN A = "1000" ELSE
                 "10010000" WHEN A = "1001" ELSE
                 "10001000" WHEN A = "1010" ELSE
                 "10000011" WHEN A = "1011" ELSE
                 "11000110" WHEN A = "1100" ELSE
                 "10100001" WHEN A = "1101" ELSE
                 "10000110" WHEN A = "1110" ELSE
                 "11111111";  -- Default case if A is not within 0 to 15
end Behavioral;   