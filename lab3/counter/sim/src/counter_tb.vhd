-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-- rewritten by David Montgomery
-- as counter test bench for CPET233 Lab 3
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end counter_tb;

architecture arch of counter_tb is

component counter is
  port (
    clk, reset : in std_logic;
    seven_seg_out : out std_logic_vector(6 downto 0)
  );  
end component; 

signal seven_seg_out : std_logic_vector(6 downto 0);
constant period     : time := 20 ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal bcd          : std_logic_vector(3 downto 0) := "0000";

begin

-- bcd iteration
sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 80 ns;   -- let all the initial conditions trickle through
      for i in 0 to 19 loop
        wait for 40 ns;
      end loop;
      report "****************** sequential testbench stop ****************";
      wait;
  end process; 

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process; 

uut: counter  
  port map(        
    clk            => clk,
    reset          => reset,
    seven_seg_out => seven_seg_out
  );
end arch;