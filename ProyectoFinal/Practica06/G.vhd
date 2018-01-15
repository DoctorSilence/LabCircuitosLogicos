library ieee;
use ieee.std_logic_1164.all;

entity G is
  port(
    m0,m1,m2,m3: in std_logic;
    a,b,c,d,e,f,g: out std_logic
  );
end entity;

architecture bdf_type of G is
  begin
    a <= (not(m2) and not(m0)) or (m1 and m2) or (not(m3) and m1 ) or (not (m3) and m2 and m0) or (m3 and not(m1) and not(m0)) or (m3 and not(m2) and not(m1));
    b <= (not(m3) and not(m2)) or (not (m2) and not(m0)) or (m3 and not(m1) and m0) or (not (m3) and not(m1) and not(m0)) or (not (m3) and m1 and m0);
    c <= (not(m1) and m0) or (m3 and not(m2)) or (not(m3) and m2) or (not(m3) and not(m1)) or (not(m3) and m0);
    d <= (m3 and not(m1) and not(m0)) or (m2 and not(m1) and m0) or (m2 and m1 and not(m0)) or (not(m2) and m1 and m0) or (not(m3) and not(m2) and not(m0));
    e <= (m3 and m2) or (m1 and not(m0)) or (m3 and m1 and m0) or (not(m2) and not(m1) and not(m0));
    f <= (not(m1) and not(m0)) or (m3 and not(m2)) or (m3 and m1 ) or (not(m3) and m2 and not(m1)) or (m2 and m1 and not(m0));
    g <= (m3 and not(m2)) or (m1 and not(m0)) or (m3 and m0) or (not(m2) and m1) or (not(m3) and m2 and not(m1));
  end bdf_type;
