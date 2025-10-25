library ieee;
use ieee.std_logic_1164.all;

entity testbench_fsm_d is
end entity;

architecture arch_testbench_fsm_d of testbench_fsm_d is   

component fsm_d is port(
  i_CLR_n: in std_logic;   -- clear/reset
  i_CLK:   in std_logic;   -- clock
  i_a:     in std_logic;   -- input 
  o_r:     out std_logic); -- output
end component;

signal w_CLR_n, w_CLK: std_logic := '0'; -- Fios para controller e clock
signal w_a, w_r: std_logic;              -- Fios para entrada e saída
constant c_PERIOD: time := 1 ns;         -- Período de tempo constante para o clock 

begin

u_DUT: fsm_d port map(
  i_CLR_n => w_CLR_n,
  i_CLK =>   w_CLK,
  i_a =>     w_a,
  o_r =>     w_r);

-- Sinais para Clock e Clear/Reset
w_CLK <= not w_CLK after c_PERIOD/2;
w_CLR_n <= '1' after c_PERIOD/2;

p_INPUTS: process
begin
  -- Clear/Reset
  w_CLR_n <= '0';
  w_a <= '0';
  wait for c_PERIOD;
  
  -- Solta Clear/Reset
  w_CLR_n <= '1';
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em Wait: o_r não resultou 0" severity error;

  -- Teste com 'a' pressionado apenas apenas por
  w_a <= '1';
  wait for c_PERIOD;
  w_a <= '0';
  assert (w_r = '1') report "Falha em K1: o_r não resultou 1" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em K2: o_r não resultou 1" severity error;

  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em K3: o_r não resultou 0" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em K4: o_r não resultou 1" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em Wait: o_r não resultou 0" severity error;

  -- Teste com 'a' ativado durante todo processo, deve manter os mesmos resultados que antes 
  w_a <= '1';
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em K1: o_r não resultou 1" severity error;

  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em K2: o_r não resultou 1" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em K3: o_r não resultou 0" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em K4: o_r não resultou 1" severity error;
  
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em Wait: o_r não resultou 0" severity error;

  -- Zerando entradas
  w_CLR_n <= '0';
  w_a <= '0';
  
  assert false report "Teste Feito." severity note;
  wait;
  end process;
end architecture;