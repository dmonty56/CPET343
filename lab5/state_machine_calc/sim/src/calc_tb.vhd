library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity calc_tb is
end entity calc_tb;

architecture arch of calc_tb is

	component top is
		port (
	        clk : in std_logic;
	        reset : in std_logic;
	        switch : in std_logic_vector(7 downto 0);
	        btn : in std_logic;

	        HEX_hun, HEX_ten, HEX_one : out std_logic_vector(6 downto 0)
	    );
	end component top;

	constant period : time := 20 ns;
	constant wait_time : time := 200 ns;
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal switch : std_logic_vector(7 downto 0) := "00000000";
    signal btn : std_logic := '0';
    signal HEX0, HEX1, HEX2 : std_logic_vector(6 downto 0) := "0000000";

    --file tests : text;

	
begin 

	-- iteration
	sequential_tb : process

		--procedure test_case ( -- generates test case
		--	signal a, b : in std_logic_vector(7 downto 0);
		--	signal switch : out std_logic_vector(7 downto 0)
		--	) is
		--begin
		--	-- start in in_a
		--	switch <= a;
		--	wait for wait_time;
		--	press_button; -- go to in_b
		--	wait for wait_time;
		--	switch <= b;
		--	wait for wait_time;
		--	press_button; -- go to sum
		--	wait for wait_time;
		--	press_button; -- go to diff
		--	wait for wait_time;
		--	press_button; -- back to in_a
		--	wait for wait_time;
		--end test_case;

		procedure press_button (
			signal btn : out std_logic
			) is
		begin
			btn <= '1';
			wait for 15 ns;
			btn <= '0';
		end press_button;

		--variable line_in : line;
		--variable a, b : bit_vector(7 downto 0);

    begin
        report "****************** sequential testbench start ****************";
        --file_open(tests,"test_input.txt",READ_MODE);
        wait for 80 ns;   -- let all the initial conditions trickle through

        --while not endfile(tests) loop
        --	readline(tests, line_in);
        --	read(line_in, a);
        --	switch <= to_stdlogicvector(a);
        --	wait for wait_time;
        --	press_button(btn); -- to in_b
        --	wait for wait_time;
        --	read(line_in, b);
        --	switch <= to_stdlogicvector(b);
        --	wait for wait_time;
        --	press_button(btn); --to add
        --	wait for wait_time;
        --	press_button(btn); --to diff
        --	wait for wait_time;
        --	press_button(btn); -- back to in_a
        --	wait for wait_time;
        --end loop;

        --file_close(tests);

        --first test
        switch <= "00000101";
        wait for wait_time;
        press_button(btn); -- to in_b
        wait for wait_time;
        switch <= "00000010";
        wait for wait_time;
        press_button(btn); -- to add
        wait for wait_time;
        press_button(btn); -- to sub
        wait for wait_time;
        press_button(btn); -- back to in_a

        --second test
        switch <= "00000010";
        wait for wait_time;
        press_button(btn); -- to in_b
        wait for wait_time;
        switch <= "00000101";
        wait for wait_time;
        press_button(btn); -- to add
        wait for wait_time;
        press_button(btn); -- to sub
        wait for wait_time;
        press_button(btn); -- back to in_a

        --third test
        switch <= "11001000";
        wait for wait_time;
        press_button(btn); -- to in_b
        wait for wait_time;
        switch <= "01100100";
        wait for wait_time;
        press_button(btn); -- to add
        wait for wait_time;
        press_button(btn); -- to sub
        wait for wait_time;
        press_button(btn); -- back to in_a

        --fourth test
        switch <= "01100100";
        wait for wait_time;
        press_button(btn); -- to in_b
        wait for wait_time;
        switch <= "11001000";
        wait for wait_time;
        press_button(btn); -- to add
        wait for wait_time;
        press_button(btn); -- to sub
        wait for wait_time;
        press_button(btn); -- back to in_a
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
			switch => switch,
			btn => btn,
			HEX_one => HEX0,
			HEX_ten => HEX1,
			HEX_hun => HEX2
		);

end architecture ; -- arch