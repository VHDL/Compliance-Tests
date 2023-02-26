-- LCS-2016-018: Attributes for Enumerated Types
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_018
package pack018 is

    type thing_t is (ONE, TWO, RED, BLUE) ;

    type thingmap_t is array(thing_t range <>) of integer ;

    signal thing : thing_t'base ;

    constant left  : thing_t'base := thing_t'left ;
    constant right : thing_t'base := thing_t'right ;

    signal thingmap_num : thingmap_t(ONE to TWO) ;
    signal thingmap_colors : thingmap_t(BLUE downto RED) ;

    signal thingmap_num_ascending : boolean := thingmap_num'ascending ;
    signal thingmap_colors_ascending : boolean := thingmap_num'ascending ;

    constant size : natural := thing_t'length ;
    signal copy : thingmap_t(thingmap_num'range) ;
    signal rev_copy : thingmap_t(thingmap_colors'reverse_range) ;

end package ;
