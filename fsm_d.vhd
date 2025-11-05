-- FSM - Método Construção Direta
library ieee;
use ieee.std_logic_1164.all;

entity fsm_d is port(
    i_CLK : in std_logic;   -- clock
    i_a   : in std_logic;   -- input 
    o_r   : out std_logic   -- output
  );
end entity;

architecture arch_fsm_d of fsm_d is
  type t_STATE is (s_0, s_1, s_2, s_3, s_4);  -- estados: Espera, K1, K2, K3 e K4 
  signal r_STATE : t_STATE := s_0;            -- estado atual (inicializado)
  signal w_NEXT  : t_STATE;                   -- próximo estado
begin

-- Registrador de estados  
p_STATE: process(i_CLK)
begin
  if rising_edge(i_CLK) then
    r_STATE <= w_NEXT;
  end if;
end process;

-- Transição de estados
p_NEXT: process(r_STATE, i_a)
begin
  case r_STATE is
    when s_0 =>
      if i_a = '1' then 
        w_NEXT <= s_1;
      else
        w_NEXT <= s_0;
      end if;
    when s_1 => w_NEXT <= s_2;
    when s_2 => w_NEXT <= s_3;
    when s_3 => w_NEXT <= s_4;
    when s_4 => w_NEXT <= s_0;
    when others => w_NEXT <= s_0;
  end case; 
end process;

-- Saída  
o_r <= '1' when (r_STATE = s_1 or r_STATE = s_2 or r_STATE = s_4) else '0';
end architecture;