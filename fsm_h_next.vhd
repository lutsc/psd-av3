library ieee;
use ieee.std_logic_1164.all;

entity fsm_h_next is port(
  i_a: in std_logic;
  i_STATE: in std_logic_vector(2 downto 0);
  o_NEXT: out std_logic_vector(2 downto 0));
end entity;

architecture arch_fsm_h_next of fsm_h_next is
begin
o_NEXT(0) <= (not i_STATE(2) and not i_STATE(0)) and ((not i_STATE(1) and i_a) or i_STATE(1));
o_NEXT(1) <= not i_STATE(2) and (i_STATE(1) xor i_STATE(0));
o_NEXT(2) <= not i_STATE(2) and i_STATE(1) and i_STATE(0);
end architecture;