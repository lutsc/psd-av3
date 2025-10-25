-- FSM - Método Construção Direta
library ieee;
use ieee.std_logic_1164.all;

entity fsm_d is port(
  i_CLR_n: in std_logic;   -- clear/reset
  i_CLK:   in std_logic;   -- clock
  i_a:     in std_logic;   -- input 
  o_r:     out std_logic); -- output
end entity;

architecture arch_fsm_d of fsm_d is
  type t_STATE is (s_0, s_1, s_2, s_3, s_4);    -- estados: Espera, K1, K2, K3 e K4 
  signal w_STATE, w_NEXT: t_STATE;              -- estado atual e próximo estado
begin

-- Registrador de estados
p_STATE: process(i_CLR_n, i_CLK) 
begin
  if (i_CLR_n = '0') then
    w_STATE <= s_0;
  elsif (rising_edge(i_CLK)) then
    w_STATE <= w_NEXT;
  end if;
end process;

-- Função de Transição de Estado
p_NEXT: process(w_STATE, i_a)
begin
  case (w_STATE) is
  when s_0 =>
    if (i_a = '1') then 
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

-- Função de Saída
p_OUTPUT: process (w_STATE)
begin
  case (w_STATE) is
  when s_1 => o_r <= '1';
  when s_2 => o_r <= '1';
  when s_3 => o_r <= '0';
  when s_4 => o_r <= '1';
  when others => o_r <= '0';
  end case;
end process;

-- Alternativa declarativa, porém fica vários or's
-- o_r <= '1' when (w_STATE = s_1 or w_STATE = s_2 or w_STATE = s_4) else '0';
end architecture;