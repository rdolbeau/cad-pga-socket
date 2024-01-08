// Idea and draft code by max1zzz (@max234252).


/*[Variant]*/

// Which socket you need
pga_which = "128"; // ["68-10x10":68 10x10 - MC68000,"68-11x11":68 11x11 - 80C286,"84","128":128 - MC68030,"132","223","238"]


/*[Debug]*/

$fn = 16;

/*[Hidden]*/

pga_pins = [
    // [ x, y, pins, count ]
    [
        10, 10,
        [
            "1111111111",
            "1111111111",
            "1110000111",
            "1100000011",
            "1100000011",
            "1100000011",
            "1100000011",
            "1110000111",
            "1111111111",
            "1111111111"
        ],
        "68-10x10"
    ],
    [
        11, 11,
        [
            "01111111110",
            "11111111111",
            "11000000011",
            "11000000011",
            "11000000011",
            "11000000011",
            "11000000011",
            "11000000011",
            "11000000011",
            "11111111111",
            "01111111110"
        ],
        "68-11x11"
    ],
    [
        10, 10,
        [
            "1111111111",
            "1111111111",
            "1111111111",
            "1110000111",
            "1110000111",
            "1110000111",
            "1110000111",
            "1111111111",
            "1111111111",
            "1111111111"
        ],
        "84"
    ],
    [
        13, 13,
        [
            "1111111111111",
            "1111111111111",
            "1111111111111",
            "1111010001111",
            "1110000000111",
            "1110000000111",
            "1110000000111",
            "1110000000111",
            "1111000001111",
            "1111010001111",
            "1111111111111",
            "1111111111111",
            "1111111111111"
        ],
        "128"
    ],
    [
        14, 14,
        [
            "11111111111111",
            "11111111111111",
            "11111111111111",
            "11100000000111",
            "11100000000111",
            "11100000000111",
            "11100000000111",
            "11100000000111",
            "11100000000111",
            "11100000000111",
            "11100000000111",
            "11111111111111",
            "11111111111111",
            "11111111111111"
        ],
        "132"
    ],
    [
        18, 18,
        [
            "111111111111111111",
            "111111111111111111",
            "111111111111111111",
            "111111111111111111",
            "111100000000001111",
            "111100000000001111",
            "111100000000001111",
            "111100000000001111",
            "111100000000001111",
            "111100000000001111",
            "111100000000001111",
            "111100000000001111",
            "111100000000001111",
            "111100000000001111",
            "111111111111111111",
            "111111111111111111",
            "111111111111111111",
            "011111111111111111"
        ],
        "223"
    ],
    [
        19, 19,
        [
            "1111111111111111111",
            "1111111111111111111",
            "1111111111111111111",
            "1111111111111111111",
            "1111000000000001111",
            "1111000000000001111",
            "1111000000000001111",
            "1111000000000001111",
            "1111000000000001111",
            "1111000000000001111",
            "1111000000000001111",
            "1111000000000001111",
            "1111000000000001111",
            "1111000000000001111",
            "1111100000000001111",
            "1111111111111111111",
            "1111111111111111111",
            "0111111111111111111",
            "0011111111111111111"
        ],
        "238"
    ]
];

module pga_socket(pga) {
    pitch=2.54;
    margin = 0;

    module pin_array(pga, o = 0, cavity=false) {
        fn = cavity ? ($preview ? 8 : $fn) : 4;
        for(y=[0:1:pga.y-1],x=[0:1:pga.x-1]){
            if (pga.z[pga.y-y-1][x] == "1") {
                translate([pitch*(x+.5), pitch*(y+.5), 0]){
                    translate([0, 0, -.1])
                        cylinder(2.2+.2, 0.7, 0.7, $fn=fn);
                    translate([0, 0, 2.2])
                        cylinder(0.9, 0.9, 0.9, $fn=fn);
                    // speed up rendering, that's just for the preview
                    if (!cavity) {
                        translate([0, 0, -3])
                            cylinder(4, 0.2, 0.2);
                        translate([0, 0, 3])
                            difference() {
                                cylinder(0.5, 0.9, 0.9);
                                translate([0,0,.1]) cylinder(1, 0.6, 0.6);
                            }
                    }
                }
            }
        }
    }

    if ($preview)
        color("Goldenrod") pin_array(pga, margin);

    difference() {
        cube([pitch*pga.x, pitch*pga.y, 3]);
        pin_array(pga, margin, true);
    }
};

idx = search([pga_which], pga_pins, num_returns_per_match=0, index_col_num=3);

pga_socket(pga_pins[idx[0][0]]);
