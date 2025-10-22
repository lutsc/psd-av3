library ieee;
use ieee.std_logic_1164.all;

entity fsm is
port(
  i_CLR_n: in std_logic;   -- clear/reset
  i_CLK: in std_logic;     -- clock
  i_a: in std_logic;       -- input 
  o_r: out std_logic);     -- output
end entity;

architecture arch_fsm of fsm is
end architecture;