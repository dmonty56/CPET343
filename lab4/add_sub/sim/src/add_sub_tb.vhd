library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_tb is
end entity add_sub_tb;

architecture arch of add_sub_tb is

    component top is
        port (
            add_sub_sw, clk, reset : in std_logic;
            a, b : in std_logic_vector(2 downto 0);

            result_out, a_out, b_out : out std_logic_vector(6 downto 0)
        );
    end component top;

    constant period : time := 20 ns;
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal a, b : std_logic_vector(2 downto 0) := "000";
    signal add_sub_sw : std_logic := '0';
    signal r_o, a_o, b_o : std_logic_vector(6 downto 0) := "0000000";

begin

-- iteration
sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 80 ns;   -- let all the initial conditions trickle through
      for i in 0 to 1 loop
        add_sub_sw <= not add_sub_sw;
        for j in 0 to 6 loop
            a <= std_logic_vector(unsigned(a) + 1);
            for k in 0 to 6 loop
                b <= std_logic_vector(unsigned(b) +1);
            end loop;
        end loop ;
        wait for 1000 ns;
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

uut: top
    port map (
        add_sub_sw => add_sub_sw,
        clk => clk,
        reset => reset,
        a => a,
        b => b,
        result_out => r_o,
        a_out => a_o,
        b_out => b_o
    );

end architecture ; -- arch