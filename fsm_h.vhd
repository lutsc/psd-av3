library ieee;
use ieee.std_logic_1164.all;

entity fsm_h is
port(
  i_CLR_n: in std_logic;   -- clear/reset
  i_CLK: in std_logic;     -- clock
  i_a: in std_logic;       -- input 
  o_r: out std_logic);     -- output
end entity;

architecture arch_fsm_h of fsm_h is
  type t_STATE is (s_0, s_1, s_2, s_3, s_4);    -- estados: wait, k1, k2, k3 e k4
  signal r_STATE: t_STATE;                      -- registrador de estado
  signal w_NEXT: t_STATE;                       -- proximo estado
begin

end architecture;