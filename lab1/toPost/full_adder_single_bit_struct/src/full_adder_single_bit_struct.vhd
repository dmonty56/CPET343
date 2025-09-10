library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity full_adder_single_bit_struct is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_struct;

architecture struct of full_adder_single_bit_struct is
    
    signal s1 : std_logic;
    signal s2 : std_logic;
    signal s3 : std_logic;

begin

    s1 <= a XOR b;
    s2 <= cin AND s1;
    s3 <= a AND b;

    sum <= s1 XOR cin;
    cout <= s2 OR s3;

end architecture struct;