--------------------------------------------------------
-- An odd parity checker as an FSM using VHDL.
--------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fsm IS
  PORT( clk, reset: IN std_logic;
        x: IN std_logic;
        y: OUT std_logic);
END ENTITY fsm;

------------------------------------
-- Coding style: One process Mealy.
------------------------------------
ARCHITECTURE mealy_1p OF fsm IS
  TYPE state_type IS (even, odd);
  SIGNAL current_state: state_type;
BEGIN
  same: PROCESS (clk, reset, current_state, x) 
  BEGIN
    IF reset = '1' THEN
      current_state <= even;
    ELSIF rising_edge (clk) THEN
      CASE current_state IS
        WHEN even =>
          IF x = '1' THEN
            current_state <= odd;
          ELSE
            current_state <= even;
          END IF;
        WHEN odd =>
          IF x = '1' THEN
            current_state <= even;
          ELSE
            current_state <= odd;
          END IF;
      END CASE;
    END IF;
	
    CASE current_state IS
      WHEN even =>
        IF x = '1' THEN
          y <= '1';
        ELSE
          y <= '0';
        END IF;
      WHEN odd =>
        IF x = '1' THEN
          y <= '0';
        ELSE
          y <= '1';
        END IF;
    END CASE;
  END PROCESS same;
END ARCHITECTURE mealy_1p;
------------------------------------
-- Coding style: Two processes Mealy.
------------------------------------
ARCHITECTURE mealy_2p OF fsm IS
  TYPE state_type IS (even, odd);
  SIGNAL current_state: state_type;
  SIGNAL next_state: state_type;
BEGIN
  cs: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      current_state <= even;
    ELSIF rising_edge (clk) THEN
      current_state <= next_state;
    END IF;
  END PROCESS cs;
  
  ns: PROCESS (current_state, x) BEGIN
    CASE current_state IS
      WHEN even =>
        IF x = '1' THEN
          y <= '1';           
          next_state <= odd;
        ELSE
          y <= '0';           
          next_state <= even;
        END IF;
      WHEN odd =>
        IF x = '1' THEN
          y <= '0';          
          next_state <= even;
        ELSE
          y <= '1';           
          next_state <= odd;
        END IF;
    END CASE;
  END PROCESS ns;
END ARCHITECTURE mealy_2p;
----------------------------------------
-- Coding style: Three processes Mealy.
----------------------------------------
ARCHITECTURE mealy_3p OF fsm IS
  TYPE state_type IS (even, odd);
  SIGNAL current_state: state_type;
  SIGNAL next_state: state_type;
BEGIN
  cs: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      current_state <= even;
    ELSIF rising_edge (clk) THEN
      current_state <= next_state;
    END IF;
  END PROCESS cs;

  ns: PROCESS (current_state, x)
  BEGIN
    CASE current_state IS
      WHEN even =>
        IF x = '1' THEN
          next_state <= odd;
        ELSE
          next_state <= even;
        END IF;
      WHEN odd =>
        IF x = '1' THEN
          next_state <= even;
        ELSE
          next_state <= odd;
        END IF;
    END CASE;
  END PROCESS ns;

  op: PROCESS (current_state, x)
  BEGIN
    CASE current_state IS
      WHEN even =>
        IF x = '1' THEN
          y <= '1';
        ELSE
          y <= '0';
        END IF;
      WHEN odd =>
        IF x = '1' THEN
          y <= '0';
        ELSE
          y <= '1';
        END IF;
    END CASE;
  END PROCESS OP;
END ARCHITECTURE mealy_3p;
------------------------------------
-- Coding style: One process moore.a
------------------------------------
ARCHITECTURE moore_1p OF fsm IS
  TYPE state_type IS (even, odd);
  SIGNAL current_state: state_type;
BEGIN
  same: PROCESS (clk, reset, current_state)
  BEGIN
    IF reset = '1' THEN
      current_state <= even;
    ELSIF rising_edge (clk) THEN
      CASE current_state IS
        WHEN even =>
          IF x = '1' THEN
            current_state <= odd;
          ELSE
            current_state <= even;
          END IF;
        WHEN odd =>
          IF x = '1' THEN
            current_state <= even;
          ELSE
            current_state <= odd;
          END IF;
      END CASE;
    END IF;
	
    CASE current_state IS
      WHEN even =>
        y <= '0';
      WHEN odd =>
        y <= '1';
    END CASE;
  END PROCESS same;
END ARCHITECTURE moore_1p;
--------------------------------------
-- Coding style: Two processes Moore.
--------------------------------------
ARCHITECTURE moore_2p OF fsm IS
  TYPE state_type IS (even, odd);
  SIGNAL current_state: state_type;
  SIGNAL next_state: state_type;
BEGIN
  cs: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      current_state <= even;
    ELSIF rising_edge (clk) THEN
      current_state <= next_state;
    END IF;
  END PROCESS cs;

  ns: PROCESS (current_state, x)
  BEGIN
    CASE current_state IS
      WHEN even =>
        y <= '0';
        IF x = '1' THEN
          next_state <= odd;
        ELSE
          next_state <= even;
        END IF;
      WHEN odd =>
        y <= '1';
        IF x = '1' THEN
          next_state <= even;
        ELSE
          next_state <= odd;
        END IF;
    END CASE;
  END PROCESS ns;
END ARCHITECTURE moore_2p;
----------------------------------------.
-- Coding style: Three processes Moore.
----------------------------------------
ARCHITECTURE moore_3p OF fsm IS
  TYPE state_type IS (even, odd);
  SIGNAL current_state: state_type;
  SIGNAL next_state: state_type;
BEGIN
  cs: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      current_state <= even;
    ELSIF rising_edge (clk) THEN
      current_state <= next_state;
    END IF;
  END PROCESS cs;

  ns: PROCESS (current_state, x)
  BEGIN
    CASE current_state IS
      WHEN even =>
        IF x = '1' THEN
          next_state <= odd;
        ELSE
          next_state <= even;
        END IF;
      WHEN odd =>
        IF x = '1' THEN
          next_state <= even;
        ELSE
          next_state <= odd;
        END IF;
    END CASE;
  END PROCESS ns;

  op: PROCESS (current_state)
  BEGIN
    CASE current_state IS
      WHEN even =>
        y <= '0';
      WHEN odd =>
        y <= '1';
    END CASE;
  END PROCESS op;
END ARCHITECTURE moore_3p;
-------------------------------------------