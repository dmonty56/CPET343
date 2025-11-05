library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity calculator is
    port (
        clk, reset      : in std_logic; -- KEY0
        execute, ms, mr : in std_logic; -- KEY3, KEY2, KEY1
        op              : in std_logic_vector(1 downto 0); -- operator switches SW9, SW8
        switch          : in std_logic_vector(7 downto 0); -- input number, SW7-0
        HEX_hun, HEX_ten, HEX_one : out std_logic_vector(6 downto 0) -- HEX2, HEX1, HEX0
    );
end entity calculator;

architecture arch of calculator is

    constant read_w : std_logic_vector(2 downto 0) := "000"; -- read working register
    constant write_w_no_op : std_logic_vector(2 downto 0) := "001"; -- write working register (just from input, no operation)
    constant write_w : std_logic_vector(2 downto 0) := "010"; -- write working register
    constant write_s : std_logic_vector(2 downto 0) := "011"; -- write save register
    constant read_s : std_logic_vector(2 downto 0) := "100"; -- read save register
    
    signal result                  : std_logic_vector(7 downto 0);
    signal exe_sig, ms_sig, mr_sig : std_logic;
    signal ones, tens, huns        : std_logic_vector(3 downto 0); -- signals from double dabble to SSDs
    signal state_reg               : std_logic_vector(3 downto 0);
    signal state_next              : std_logic_vector(3 downto 0);

begin

    state_register : process( clk, reset )  
    begin
        if (reset = '1') then 
            state_reg <= in_a;
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
        end if;
    end process ; -- state_register

    state machine : process( switch_syn, state_reg, exe_sig, ms_sig, mr_sig )
    begin
        state_next <= state_reg;
        case state_reg is
            when read_w
                
            when others =>
                state_next <= read_w;
        end case;
    end processs; -- state_machine

    d_d : double_dabble
        port map (
            result_padded => ,
            ones => ones,
            tens => tens,
            hundreds => huns
        );
    exe_res : rising_edge_synchronizer
        port map (
            clk => clk,
            reset => reset,
            input => execute,
            edge => exe_sig
        );
    ms_res : rising_edge_synchronizer
        port map (
            clk => clk,
            reset => reset,
            input => ms,
            edge => ms_sig
        );
    mr_res : rising_edge_synchronizer
        port map (
            clk => clk,
            reset => reset,
            input => mr,
            edge => mr_sig
        );
    ones_bcd : seven_seg
        port map (
            clk => clk,
            reset => reset,
            bcd => ones,
            seven_seg_out => HEX_one
        );
    tens_bcd : seven_seg
        port map (
            clk => clk,
            reset => reset,
            bcd => tens,
            seven_seg_out => HEX_ten
        );
    huns_bcd : seven_seg
        port map (
            clk => clk,
            reset => reset,
            bcd => huns,
            seven_seg_out => HEX_hun
        );
end architecture arch;