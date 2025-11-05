-- FSM - Método Hierárquico
library ieee;
use ieee.std_logic_1164.all;

entity reg is port(
  i_n0:     in std_logic;   -- input 
  i_n1:     in std_logic;   -- input 
  i_n2:     in std_logic;   -- input 
  i_clk: 	in std_logic;   -- input 
  
  o_s0:     out std_logic; -- output
  o_s1:     out std_logic; -- output
  o_s2:     out std_logic -- output
  ); 
end entity; 

architecture arch_reg of reg is
  signal s0_reg, s1_reg, s2_reg: std_logic := '0';  -- registradores internos
begin

  -- depende do clock
  process(i_clk)
  begin
    if rising_edge(i_clk) then
      s0_reg <= i_n0;
      s1_reg <= i_n1;
      s2_reg <= i_n2;
    end if;
  end process;

  -- saída
  o_s0 <= s0_reg;
  o_s1 <= s1_reg;
  o_s2 <= s2_reg;

end architecture;