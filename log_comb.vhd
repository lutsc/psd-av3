-- FSM - Método Hierárquico - Lógica Combinacional
library ieee;
use ieee.std_logic_1164.all;

entity log_comb is port(
  i_a  : in std_logic;   -- input 
  i_s0 : in std_logic;   -- input 
  i_s1 : in std_logic;   -- input 
  i_s2 : in std_logic;   -- input 
  o_r  : out std_logic;  -- output
  o_n2 : out std_logic;  -- output
  o_n1 : out std_logic;  -- output
  o_n0 : out std_logic); -- output 
end entity;

architecture arch_log_comb of log_comb is 
begin

--lógica combinacional
o_n0 <= (not i_s2 and not i_s0 and ((not i_s1 and i_a) or i_s1)); 	--n0: s2’s0’ * (s1’a + s1)
o_n1 <= (not i_s2 and (i_s1 xor i_s0));								--n1: s2’ * (s1 ⊕ s0)
o_n2 <= (not i_s2 and i_s1 and i_s0);								--n2: s2’s1s0
o_r <= ((not i_s2 and (i_s1 xor i_s0)) or (i_s2 and not i_s1 and not i_s0));--r: s2’ * (s1 ⊕ s0) + s2s1’s0’

end architecture;