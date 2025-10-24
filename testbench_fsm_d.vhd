library ieee;
use ieee.std_logic_1164.all;

entity testbench_fsm_d is
end entity;

architecture arch_fsm_d of testbench_fsm_d is   

component fsm_d is port(
  i_CLR_n: in std_logic;   -- clear/reset
  i_CLK: in std_logic;     -- clock
  i_a: in std_logic;       -- input 
  o_r: out std_logic);     -- output
end component;

signal w_CLR_n, w_CLK: std_logic := '0';
signal w_a, w_r: std_logic;
constant c_PERIOD: time := 1 ns;

begin
u_DUV: fsm_d port map(
  i_CLR_n => w_CLR_n,
  i_CLK => w_CLK,
  i_a => w_a,
  o_r => w_r);

-- Clock
w_CLK <= not w_CLK after c_PERIOD/2;
  
p_INPUTS: process
begin
  -- Reset
  w_CLR_n <= '0';
  w_a <= '0';
  wait for c_PERIOD;

  -- Solta reset
  w_CLR_n <= '1';
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em s_0: o_r não resulta 0" severity error;

  -- Ativa 'a' para começar
  w_a <= '1';
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em s_1: o_r não resulta 1" severity error;
  
  -- Desativa 'a', os estados devem trocar automaticamente
  w_a <= '0';
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em s_2: o_r não resulta 1" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em s_3: o_r não resulta 0" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em s_4: o_r não resulta 1" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em s_0: o_r não resulta 0" severity error;

  -- Mantém 'a' ativado durante as trocas, deve manter os mesmos resultados anteriores 
  w_a <= '1';
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em s_2: o_r não resulta 1" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em s_3: o_r não resulta 0" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em s_4: o_r não resulta 1" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em s_0: o_r não resulta 0" severity error;

  -- Zerando entradas
  w_a <= '0';
  
  assert false report "Teste Feito." severity note;
  wait;
  end process;
end architecture;