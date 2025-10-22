library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calc_tb is
end entity calc_tb;

architecture arch of calc_tb is

	component top is
		port (
	        clk : in std_logic;
	        reset : in std_logic;
	        a, b : in std_logic_vector(7 downto 0);
	        btn : in std_logic;

	        HEX_hun, HEX_ten, HEX_one : out std_logic_vector(6 downto 0)
	    );
	end component top;

	constant period : time := 20 ns;
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal a, b : std_logic_vector(7 downto 0) := "00000000";
    signal btn : std_logic := '0';
    signal HEX0, HEX1, HEX2 : std_logic_vector(6 downto 0) := "0000000";

begin

	-- iteration
	sequential_tb : process 
	    begin
	        report "****************** sequential testbench start ****************";
	        wait for 80 ns;   -- let all the initial conditions trickle through
	        for i in 0 to 4 loop
	            --bcd <= std_logic_vector(unsigned(bcd) + 1 );
	            --wait for 40 ns;
	            btn <= not btn;
	            a <= std_logic_vector(unsigned(a) + 1 );
	            wait for 15 ns;
	            btn <= not btn;
	            wait for 200 ns;
	        end loop;
	        report "****************** sequential testbench stop ****************";
	        wait;
  	end process; 

	clock : process
	begin
	    clk <= not clk;
	    wait for period/2;
	end process ; -- clock

	rst : process
	begin
	    wait for 2 * period;
	    reset <= '0';
	    wait;
	end process ; -- rst

	uut : top
		port map (
			clk => clk,
			reset => reset,
			a => a,
			b => b,
			btn => btn,
			HEX_one => HEX0,
			HEX_ten => HEX1,
			HEX_hun => HEX2
		);

end architecture ; -- arch