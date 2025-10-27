library ieee;
use ieee.std_logic_1164.all;

entity fsm_h_output is port(
  i_STATE: in std_logic_vector(2 downto 0);
  o_r:     out std_logic);
end entity;

architecture arch_fsm_h_output of fsm_h_output is
begin
o_r <= (not i_STATE(2) and (i_STATE(1) xor i_STATE(0))) or (i_STATE(2) and not i_STATE(1) and not i_STATE(0));
end architecture;