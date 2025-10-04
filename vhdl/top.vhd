-- Clock generator 1.5, 3MHz, 4.5MHz, 12MHz, 24MHz, 48MHz, 70MHz, 100Mhz
library ieee;
use ieee.std_logic_1164.all;

entity top is
	port (
		switched : in STD_LOGIC_VECTOR (2 downto 0);
		reset : in STD_LOGIC;
		clock_100 : in std_logic;
		d_o : out std_logic
	);
end top;

architecture rtl of top is

component clk_divider IS
    GENERIC (
        Freq_in : INTEGER := 12500000;
        N : INTEGER := 2); -- 50MHz clock on DE-10 Lite FPGA board
    PORT (
        clk_in : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clk_out : OUT STD_LOGIC
    );
end component;
SIGNAL clk_15 : STD_LOGIC;
SIGNAL clk_3 : STD_LOGIC;
SIGNAL clk_45 : STD_LOGIC;
SIGNAL clk_12 : STD_LOGIC;
SIGNAL clk_24 : STD_LOGIC;
SIGNAL clk_48 : STD_LOGIC;
SIGNAL clk_70 : STD_LOGIC;


begin

	clk15 : clk_divider
	generic map (
		Freq_in => 100000000,
		N => 3
	)
	port map (
		clk_in =>clock_100,
		reset => reset,
		clk_out => clk_15
	);

	clk3 : clk_divider
	generic map (
		Freq_in => 100000000,
		N => 6
	)
	port map (
		clk_in =>clock_100,
		reset => reset,
		clk_out => clk_3
	);

	clk45 : clk_divider
	generic map (
		Freq_in => 100000000,
		N => 9
	)
	port map (
		clk_in =>clock_100,
		reset => reset,
		clk_out => clk_45

	);
	clk12 : clk_divider
	generic map (
		Freq_in => 100000000,
		N => 24
	)
	port map (
		clk_in =>clock_100,
		reset => reset,
		clk_out => clk_12

	);

	clk24 : clk_divider
	generic map (
		Freq_in => 100000000,
		N => 48
	)
	port map (
		clk_in =>clock_100,
		reset => reset,
		clk_out => clk_24

	);

	clk48 : clk_divider
	generic map (
		Freq_in => 100000000,
		N => 96
	)
	port map (
		clk_in =>clock_100,
		reset => reset,
		clk_out => clk_48

	);

	clk70 : clk_divider
	generic map (
		Freq_in => 100000000,
		N => 140
	)
	port map (
		clk_in =>clock_100,
		reset => reset,
		clk_out => clk_70

	);

	process (clock_100)
	begin	
		case switched is
			when "000" =>
				d_o <= clk_15;
			when "001" =>
				d_o <= clk_3;
			when "011" =>
				d_o <= clk_45;
			when "010" =>
				d_o <= clk_12;
			when "110" =>
				d_o <= clk_24;
			when "111" =>
				d_o <= clk_48;
			when "101" =>
				d_o <= clk_70;
			when "100" =>
				d_o <= clock_100;
			when others =>
				d_o <= clk_15;
		end case;
	end process;

end architecture;
