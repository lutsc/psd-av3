-- FSM de forma hierárquica
library ieee;
use ieee.std_logic_1164.all;

entity fsm_h is port(
  i_CLR_n: in std_logic;   -- clear/reset
  i_CLK:   in std_logic;   -- clock
  i_a:     in std_logic;   -- input 
  o_r:     out std_logic); -- output
end entity;

architecture arch_fsm_h of fsm_h is

-- s_0 até s_4, um estado pra cada OU s_0 até s_2, usando lógica de bits (000, 001, 010, 011, 100) (?) 
-- possível até usar vetores para caso de bits
signal s_atual, s_prox: std_logic_vector(2 downto 0);
-- signal s_2, s_1, s_0: std_logic;
-- signal n_2, n_1, n_0: std_logic;
signal w_r: std_logic;  

begin

-- Registrador de estados
p_STATE: process(i_CLR_n, i_CLK, i_a)
begin
  if (i_CLR_n = '0') then
    o_r <= '0';
  elsif (rising_edge(i_CLK) and i_a = '1') then
    o_r <= '1';
  end if;
end process;

  -- n2 <= s1 and i_a;
  -- n1 <= s1 xor s0;
  -- n0 <= s1 and s0;
  -- o_r <= s2 xor (s1 or s0)';

end architecture;