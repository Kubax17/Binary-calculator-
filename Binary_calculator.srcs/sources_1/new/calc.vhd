 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity calc is
    Port (
        mult : in STD_LOGIC;
        soust : in STD_LOGIC;
        add : in STD_LOGIC;
        div : in STD_LOGIC;
        confirm : in STD_LOGIC;
        value_out : out STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit wide signal
        clk : in STD_LOGIC
    );
end calc;

architecture Behavioral of calc is
    type STATE is (state_0, state_1, state_2, state_3, state_4, state_5, state_6, state_7, state_8, state_9);
    signal CURRENT_STATE : STATE := state_0;
    signal NEXT_STATE : STATE := state_0;
begin

    seq_proc: process(clk, confirm)
    begin
        if (confirm = '1') then
            CURRENT_STATE <= state_0;
        elsif (rising_edge(clk)) then
            CURRENT_STATE <= NEXT_STATE;
        end if;
    end process;

    comb_proc: process(CURRENT_STATE, add, soust, mult, div)
    begin
        case CURRENT_STATE is
            when state_0 =>
                value_out <= "0000";
                if (add = '1') then
                    NEXT_STATE <= state_1;
                elsif (soust = '1') then
                    NEXT_STATE <= state_9;
                else
                    NEXT_STATE <= state_0;
                end if;
            when state_1 =>
                value_out <= "0001";
                if (add = '1') then
                    NEXT_STATE <= state_2;
                elsif (soust = '1') then
                    NEXT_STATE <= state_0;
                elsif (mult = '1') then
                    NEXT_STATE <= state_2;
                elsif (div = '1') then
                    NEXT_STATE <= state_0;
                end if;
            when state_2 =>
                value_out <= "0010";
                if (add = '1') then
                    NEXT_STATE <= state_3;
                elsif (soust = '1') then
                    NEXT_STATE <= state_1;
                elsif (mult = '1') then
                    NEXT_STATE <= state_4;
                elsif (div = '1') then
                    NEXT_STATE <= state_1;
                end if;
            when state_3 =>
                value_out <= "0011";
                if (add = '1') then
                    NEXT_STATE <= state_4;
                elsif (soust = '1') then
                    NEXT_STATE <= state_2;
                elsif (mult = '1') then
                    NEXT_STATE <= state_6;
                elsif (div = '1') then
                    NEXT_STATE <= state_1;
                end if;
            when state_4 =>
                value_out <= "0100";
                if (add = '1') then
                    NEXT_STATE <= state_5;
                elsif (soust = '1') then
                    NEXT_STATE <= state_3;
                elsif (mult = '1') then
                    NEXT_STATE <= state_0;
                elsif (div = '1') then
                    NEXT_STATE <= state_2;
                end if;
            when state_5 =>
                value_out <= "0101";
                if (add = '1') then
                    NEXT_STATE <= state_6;
                elsif (soust = '1') then
                    NEXT_STATE <= state_4;
                elsif (mult = '1') then
                    NEXT_STATE <= state_2;
                elsif (div = '1') then
                    NEXT_STATE <= state_2;
                end if;
            when state_6 =>
                value_out <= "0110";
                if (add = '1') then
                    NEXT_STATE <= state_7;
                elsif (soust = '1') then
                    NEXT_STATE <= state_5;
                elsif (mult = '1') then
                    NEXT_STATE <= state_4;
                elsif (div = '1') then
                    NEXT_STATE <= state_3;
                end if;
            when state_7 =>
                value_out <= "0111";
                if (add = '1') then
                    NEXT_STATE <= state_8;
                elsif (soust = '1') then
                    NEXT_STATE <= state_6;
                elsif (mult = '1') then
                    NEXT_STATE <= state_6;
                elsif (div = '1') then
                    NEXT_STATE <= state_3;
                end if;
            when state_8 =>
                value_out <= "1000";
                if (add = '1') then
                    NEXT_STATE <= state_9;
                elsif (soust = '1') then
                    NEXT_STATE <= state_7;
                elsif (mult = '1') then
                    NEXT_STATE <= state_8;
                elsif (div = '1') then
                    NEXT_STATE <= state_4;
                end if;
            when state_9 =>
                value_out <= "1001";
                if (add = '1') then
                    NEXT_STATE <= state_0;
                elsif (soust = '1') then
                    NEXT_STATE <= state_8;
                elsif (mult = '1') then
                    NEXT_STATE <= state_9;
                elsif (div = '1') then
                    NEXT_STATE <= state_4;
                end if;
            when others =>
                NEXT_STATE <= state_0;
        end case;
    end process;
end Behavioral;