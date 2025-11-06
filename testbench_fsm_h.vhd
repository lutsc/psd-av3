-- Testbench de FSM - Método direto
library ieee;
use ieee.std_logic_1164.all;

entity testbench_fsm_h is
end entity;

architecture arch_testbench_fsm_h of testbench_fsm_h is   

-- Componente a ser testado
component fsm_h is  port(
  i_CLK : in std_logic;   -- clock
  i_a   : in std_logic;   -- input 
  o_r   : out std_logic); -- output
end component;

-- Sinais internos
signal w_CLK : std_logic := '0';
signal w_a   : std_logic := '0';
signal w_r   : std_logic;
constant c_PERIOD : time := 10 ns;

begin

-- Instancia o DUT (Device Under Test)
u_DUT: fsm_h port map(
  i_CLK => w_CLK,
  i_a   => w_a,
  o_r   => w_r);

-- Geração de clock
w_CLK <= not w_CLK after c_PERIOD / 2;

-- Processo de estímulo
p_INPUTS: process
begin

  -- Teste: Mantendo 'a' ativado
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

  -- Finaliza simulação
  w_a <= '0';
  assert false report "Teste concluído com sucesso." severity note;
  wait;
end process;
end architecture;