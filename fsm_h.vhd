-- FSM - Método Hierárquico
library ieee;
use ieee.std_logic_1164.all;

entity fsm_h is port(
  i_CLR_n: in std_logic;   -- clear/reset
  i_CLK:   in std_logic;   -- clock
  i_a:     in std_logic;   -- input
  o_r:     out std_logic); -- output
end entity;

architecture arch_fsm_h of fsm_h is
  signal r_STATE, w_NEXT: std_logic_vector(2 downto 0); -- estado atual e próximo estado
begin

-- Registrador de estados
p_STATE: process(i_CLR_n, i_CLK)
begin
  if (i_CLR_n = '0') then
    r_STATE <= "000";
  elsif (rising_edge(i_CLK)) then
    r_STATE <= w_NEXT;
  end if;
end process;

-- Circuito Combinacional
w_NEXT(0) <= (not r_STATE(2) and not r_STATE(0)) and ((not r_STATE(1) and i_a) or r_STATE(1));
w_NEXT(1) <= not r_STATE(2) and (r_STATE(1) xor r_STATE(0));
w_NEXT(2) <= not r_STATE(2) and r_STATE(1) and r_STATE(0);

o_r <= (not r_STATE(2) and (r_STATE(1) xor r_STATE(0))) or (r_STATE(2) and not r_STATE(1) and not r_STATE(0));

end architecture;