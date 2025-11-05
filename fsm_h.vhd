-- FSM - Método Hierárquico
library ieee;
use ieee.std_logic_1164.all;

entity fsm_h is port(
  i_CLK:   in std_logic;   -- clock
  i_a:     in std_logic;   -- input 
  o_r:     out std_logic); -- output
end entity;

architecture arch_fsm_h of fsm_h is
  
  -- sinais internos para interligar log_comb e reg
  signal s0, s1, s2 : std_logic := '0';  -- estado atual
  signal n0, n1, n2 : std_logic;         -- próximo estado
  signal r          : std_logic;         -- saída intermediária

--instanciar componentes
component log_comb
  port(
  i_a:     in std_logic;   -- input 
  i_s0:     in std_logic;   -- input 
  i_s1:     in std_logic;   -- input 
  i_s2:     in std_logic;   -- input 
  
  o_r:     out std_logic; -- output
  o_n2:     out std_logic; -- output
  o_n1:     out std_logic; -- output
  o_n0:     out std_logic -- output
  ); 
end component;

component reg
port(
i_n0:     in std_logic;   -- input 
  i_n1:     in std_logic;   -- input 
  i_n2:     in std_logic;   -- input 
  i_clk: 	in std_logic;   -- input 
  
  o_s0:     out std_logic; -- output
  o_s1:     out std_logic; -- output
  o_s2:     out std_logic -- output
);
end component;

begin

-- Instância da lógica combinacional
u_logic : log_comb
  port map(
    i_a  => i_a,
    i_s0 => s0,
    i_s1 => s1,
    i_s2 => s2,
    o_r  => r,
    o_n0 => n0,
    o_n1 => n1,
    o_n2 => n2
  );


-- Instância do registrador de estados
u_reg : reg
  port map(
    i_n0  => n0,
    i_n1  => n1,
    i_n2  => n2,
    i_clk => i_clk,
    o_s0  => s0,
    o_s1  => s1,
    o_s2  => s2
  );

-- Saída
o_r <= r;
end architecture;