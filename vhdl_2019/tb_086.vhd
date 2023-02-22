-- LCS-2016-086: All interface lists can be ordered
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_086

entity E086 is
    generic (G1: INTEGER; G2: INTEGER := G1; G3, G4, G5, G6: INTEGER);
    port (P1: STRING(G3 to G4); P2: STRING(P1'RANGE); P3: P1'SUBTYPE);
    procedure X (Y1, Y2: INTEGER; Y3: INTEGER range Y1 to Y2; Y4: Y1'SUBTYPE);
end E086;
