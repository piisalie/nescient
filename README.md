nescient
========

A rather obtuse IRC bot written in Ruby.
Please fork / open issues / contribute / demand features / use / expand / and enjoy life to the fullest.

# Usage

`$bin/nescient` connects to freenode#bottest with the defaults

`$bin/nescient -h` displays the available options( ssl, channel, server, port, etc )

# Todo:
* write a better read me
* manage dependencies
* tests
* restructure
* MOAR ACTIONS!

Bold            = 0x02,     /**< Bold */
Color           = 0x03,     /**< Color */
Italic          = 0x09,     /**< Italic */
StrikeThrough   = 0x13,     /**< Strike-Through */
Reset           = 0x0f,     /**< Reset */
Underline       = 0x15,     /**< Underline */
Underline2      = 0x1f,     /**< Underline */
Reverse         = 0x16      /**< Reverse */

foreground (fg)     background (bg)
-------------------------------------------------------
0          white               light gray   + blinking fg
1          black               black
2          blue                blue
3          green               green
4          light red           red          + blinking fg
5          red                 red
6          magenta (purple)    magenta
7          orange              orange
8          yellow              orange       + blinking fg
9          light green         green        + blinking fg
10         cyan                cyan
11         light cyan          cyan         + blinking fg
12         light blue          blue         + blinking fg
13         light magenta       magenta      + blinking fg
14         gray                black        + blinking fg
15         light gray          light gray
