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
  type t_STATE is (s_0, s_1, s_2, s_3, s_4);
  signal r_STATE: t_STATE; -- state register
  signal w_NEXT: t_STATE; -- next state

begin

end architecture;