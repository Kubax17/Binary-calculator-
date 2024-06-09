library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity calculator is
    Port (
        clk : in STD_LOGIC;
        mult_in : in STD_LOGIC;
        add_in : in STD_LOGIC;
        div_in : in STD_LOGIC;
        sous_in : in STD_LOGIC;
        confirm : in STD_LOGIC;
        sw0 : in STD_LOGIC;
        sw1 : in STD_LOGIC;
        sw2 : in STD_LOGIC;
        sw3 : in STD_LOGIC;
        sw4 : in STD_LOGIC;
        sw5 : in STD_LOGIC;
        sw6 : in STD_LOGIC;
        sw7 : in STD_LOGIC;
        sw8 : in STD_LOGIC;
        sw9 : in STD_LOGIC;
        sw10 : in STD_LOGIC;
        sw11 : in STD_LOGIC;
        sw12 : in STD_LOGIC;
        sw13 : in STD_LOGIC;
        sw14 : in STD_LOGIC;
        sw15 : in STD_LOGIC;
        seven_seg : out STD_LOGIC_VECTOR (7 downto 0);
        AN : out STD_LOGIC_VECTOR (3 downto 0)
    );
end calculator;

architecture Behavioral of calculator is
    component DEBOUNCE
        port(
            clk : in STD_LOGIC;
            button : in STD_LOGIC;
            result : out STD_LOGIC
        );
    end component;

    component pulse_gen
        port(
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           gen_in : in STD_LOGIC;
           gen_out : out STD_LOGIC
        );
    end component;

    component calc
        port(
           mult : in STD_LOGIC;
           soust : in STD_LOGIC;
           add : in STD_LOGIC;
           div : in STD_LOGIC;
           confirm : in STD_LOGIC;
           value_out : out STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC
        );
    end component;

    component seven_segment
        port(
           A : in STD_LOGIC_VECTOR (3 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    signal digit0, digit1, digit2, digit3 : STD_LOGIC_VECTOR(3 downto 0);
    signal current_digit : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal tmp_debounce : STD_LOGIC_VECTOR(4 downto 0);
    signal tmp_pulse_gen : STD_LOGIC_VECTOR(4 downto 0);
    signal calc_result : STD_LOGIC_VECTOR(3 downto 0);
    signal digit_to_display : STD_LOGIC_VECTOR(3 downto 0);

    signal clk_div : STD_LOGIC := '0';
    signal clk_div_count : INTEGER := 0;

begin
    -- Clock divider for multiplexing
    process(clk)
    begin
        if rising_edge(clk) then
            if clk_div_count = 50000 then
                clk_div_count <= 0;
                clk_div <= not clk_div;
            else
                clk_div_count <= clk_div_count + 1;
            end if;
        end if;
    end process;

    process(clk_div)
    begin
        if rising_edge(clk_div) then
            case current_digit is
                when "00" =>
                    AN <= "1110";
                    digit_to_display <= digit0;
                    current_digit <= "01";
                when "01" =>
                    AN <= "1101";
                    digit_to_display <= digit1;
                    current_digit <= "10";
                when "10" =>
                    AN <= "1011";
                    digit_to_display <= digit2;
                    current_digit <= "11";
                when "11" =>
                    AN <= "0111";
                    digit_to_display <= digit3;
                    current_digit <= "00";
                when others =>
                    current_digit <= "00";
            end case;
        end if;
    end process;

    U0: DEBOUNCE port map(
        clk => clk,
        button => mult_in,
        result => tmp_debounce(0)
    );
    U1: DEBOUNCE port map(
        clk => clk,
        button => add_in,
        result => tmp_debounce(1)
    );
    U2: DEBOUNCE port map(
        clk => clk,
        button => div_in,
        result => tmp_debounce(2)
    );
    U3: DEBOUNCE port map(
        clk => clk,
        button => sous_in,
        result => tmp_debounce(3)
    );
    U4: DEBOUNCE port map(
        clk => clk,
        button => confirm,
        result => tmp_debounce(4)
    );

    U5: pulse_gen port map(
        gen_in => tmp_debounce(0),
        clk => clk,
        reset => '0',
        gen_out => tmp_pulse_gen(0)
    );
    U6: pulse_gen port map(
        gen_in => tmp_debounce(1),
        clk => clk,
        reset => '0',
        gen_out => tmp_pulse_gen(1)
    );
    U7: pulse_gen port map(
        gen_in => tmp_debounce(2),
        clk => clk,
        reset => '0',
        gen_out => tmp_pulse_gen(2)
    );
    U8: pulse_gen port map(
        gen_in => tmp_debounce(3),
        clk => clk,
        reset => '0',
        gen_out => tmp_pulse_gen(3)
    );
    U9: pulse_gen port map(
        gen_in => tmp_debounce(4),
        clk => clk,
        reset => '0',
        gen_out => tmp_pulse_gen(4)
    );

    U10: calc port map(
        mult => tmp_pulse_gen(0),
        add => tmp_pulse_gen(1),
        div => tmp_pulse_gen(2),
        soust => tmp_pulse_gen(3),
        confirm => tmp_pulse_gen(4),
        clk => clk,
        value_out => calc_result
    );

    U11: seven_segment port map(
        A => digit_to_display,  -- Ensure A is connected to a 4-bit vector
        seven_seg => seven_seg
    );

    digit0 <= sw3 & sw2 & sw1 & sw0;
    digit1 <= sw7 & sw6 & sw5 & sw4;
    digit2 <= sw11 & sw10 & sw9 & sw8;
    digit3 <= sw15 & sw14 & sw13 & sw12;

end Behavioral;
