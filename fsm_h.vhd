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
  signal w_s, w_n: std_logic_vector(2 downto 0); -- estado atual e estado próximo
begin
    
-- n0 = s2’s0’ * (s1’a + s1)
w_n(0) <= (not w_s(2) and not w_s(0)) and ((not w_s(1) and i_a) or w_s(1));

-- n1  = s2’ * (s1 ^ s0)
w_n(1) <= not w_s(2) and (w_s(1) xor w_s(0));

-- n2 = s2’s1s0
w_n(2) <= not w_s(2) and w_s(1) and w_s(0);

-- r = s2’ * (s1 ^ s0) + s2s1’s0’
o_r <= (not w_s(2) and (w_s(1) xor w_s(0))) or (w_s(2) and not w_s(1) and not w_s(0));

-- Registrador de estados
process(i_CLR_n, i_CLK)
begin
  if (i_CLR_n = '0') then
    w_s <= "000";
  elsif (rising_edge(i_CLK)) then
    w_s <= w_n;
  end if;
end process;
end architecture;