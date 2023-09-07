----------------------------------------
-- A full adder using a CASE statement.
----------------------------------------

ENTITY full_adder IS
   PORT( a, b, c_in : IN bit;
         s, c_out : OUT bit); 
END ENTITY full_adder;

ARCHITECTURE fa OF full_adder IS
BEGIN 
   Pa: PROCESS (a,b,c_in) IS
     VARIABLE input: bit_vector(0 TO 2);
     VARIABLE output: bit_vector(0 TO 1);
   BEGIN 
     input := a & b & c_in; 
     CASE input IS
       WHEN "000" => output := "00"; 
       WHEN "001" => output := "10"; 
       WHEN "010" => output := "10"; 
       WHEN "011" => output := "01"; 
       WHEN "100" => output := "10"; 
       WHEN "101" => output := "01"; 
       WHEN "110" => output := "01"; 
       WHEN "111" => output := "11"; 
     END  CASE;
     s <= output(0);
     c_out <=output(1);
   END  PROCESS Pa;
END ARCHITECTURE fa;
