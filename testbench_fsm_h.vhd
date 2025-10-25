-- Testbench de FSM - Método Hierárquico
library ieee;
use ieee.std_logic_1164.all;

entity testbench_fsm_h is
end entity;

architecture arch_testbench_fsm_h of testbench_fsm_h is   

component fsm_h is port(
  i_CLR_n: in std_logic;   -- clear/reset
  i_CLK:   in std_logic;   -- clock
  i_a:     in std_logic;   -- input 
  o_r:     out std_logic); -- output
end component;

signal w_CLR_n, w_CLK: std_logic := '0'; -- Fios para clear/reset e clock
signal w_a, w_r: std_logic;              -- Fios para entrada e saída
constant c_PERIOD: time := 1 ns;         -- Período constante para clock 

begin

u_DUT: fsm_h port map(
  i_CLR_n => w_CLR_n,
  i_CLK =>   w_CLK,
  i_a =>     w_a,
  o_r =>     w_r);

-- clock e clear/reset
w_CLK <= not w_CLK after c_PERIOD/2;
w_CLR_n <= '1' after c_PERIOD/2;

p_INPUTS: process
begin
  -- Teste 1: Se Espera, mantém em Espera 
  w_a <= '0';
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em Espera." severity error;

  -- Teste 2: Ativando 'a' por um pulso
  w_a <= '1';
  wait for c_PERIOD;
  w_a <= '0';
  assert (w_r = '1') report "Falha em K1." severity error;
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em K2." severity error;
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em K3." severity error;  
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em K4." severity error;
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em Espera." severity error;

  -- Teste 3: Mantendo 'a' ativado 
  w_a <= '1';
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em K1." severity error;
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em K2." severity error;
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em K3." severity error;  
  wait for c_PERIOD;
  assert (w_r = '1') report "Falha em K4." severity error;
  wait for c_PERIOD;
  assert (w_r = '0') report "Falha em Espera." severity error;

  -- Zerando entradas
  w_a <= '0';
  
  assert false report "Teste Feito." severity note;
  wait;
  end process;
end architecture;