ASCII 码
================

.. raw:: html

  <style>
    .f {
        font-family: Menlo, 'Droid Sans Mono', Consolas, monospace;
        font-weight: bold;
        color: #2980b9;
    }
  </style>

.. role:: f

控制字符（33）
----------------


.. table:: Control Characters
    :align: center

    ============= ==================== ===================== ========================= =========================== ======================= ======================== ==================================================================================================================
    DEC                  OCT                   HEX                     BIN                        Symbol                    HTML Number         Caret Notation                  Description
    ============= ==================== ===================== ========================= =========================== ======================= ======================== ==================================================================================================================
    0                    000                    00                    00000000                    :f:`NUL`                    &#00;                 ^@                        Null character, \\0
    1                    001                    01                    00000001                    :f:`SOH`                    &#01;                 ^A                       Start of Heading
    2                    002                    02                    00000010                    :f:`STX`                    &#02;                 ^B                      Start of Text
    3                    003                    03                    00000011                    :f:`ETX`                    &#03;                 ^C                        End of Text
    4                    004                    04                    00000100                    :f:`EOT`                    &#04;                 ^D                        End of Transmission
    5                    005                    05                    00000101                    :f:`ENQ`                    &#05;                 ^E                        Enquiry
    6                    006                    06                    00000110                    :f:`ACK`                    &#06;                 ^F                        Acknowledge
    7                    007                    07                    00000111                    :f:`BEL`                    &#07;                 ^G                        Bell, Alert, \\a
    8                    010                    08                    00001000                    :f:`BS`                    &#08;                  ^H                       Backspace, \\b
    9                    011                    09                    00001001                    :f:`HT`                    &#09;                  ^I                       Horizontal Tabulation, \\t
    10                    012                    0A                    00001010                    :f:`LF`                    &#10;                 ^J                        Line Feed, \\n
    11                    013                    0B                    00001011                    :f:`VT`                    &#11;                 ^K                        Vertical Tabulation, \\v
    12                    014                    0C                    00001100                    :f:`FF`                    &#12;                 ^L                        Form Feed, \\f
    13                    015                    0D                    00001101                    :f:`CR`                    &#13;                 ^M                        Carriage Return, \\r
    14                    016                    0E                    00001110                    :f:`SO`                    &#14;                 ^N                        Shift Out
    15                    017                    0F                    00001111                    :f:`SI`                    &#15;                 ^O                        Shift In
    16                    020                    10                    00010000                    :f:`DLE`                    &#16;                ^P                         Data Link Escape
    17                    021                    11                    00010001                    :f:`DC1`                    &#17;                ^Q                         Device Control One (XON)
    18                    022                    12                    00010010                    :f:`DC2`                    &#18;                ^R                         Device Control Two
    19                    023                    13                    00010011                    :f:`DC3`                    &#19;                ^S                         Device Control Three (XOFF)
    20                    024                    14                    00010100                    :f:`DC4`                    &#20;                ^T                         Device Control Four
    21                    025                    15                    00010101                    :f:`NAK`                    &#21;                ^U                         Negative Acknowledge
    22                    026                    16                    00010110                    :f:`SYN`                    &#22;                ^V                         Synchronous Idle
    23                    027                    17                    00010111                    :f:`ETB`                    &#23;                ^W                         End of Transmission Block
    24                    030                    18                    00011000                    :f:`CAN`                    &#24;                ^X                         Cancel
    25                    031                    19                    00011001                    :f:`EM`                    &#25;                 ^Y                        End of Medium
    26                    032                    1A                    00011010                    :f:`SUB`                    &#26;                ^Z                         Substitute
    27                    033                    1B                    00011011                    :f:`ESC`                    &#27;                ^[                         Escape, \\e
    28                    034                    1C                    00011100                    :f:`FS`                    &#28;                 ^\\                        File Separator
    29                    035                    1D                    00011101                    :f:`GS`                    &#29;                 ^]                        Group Separator
    30                    036                    1E                    00011110                    :f:`RS`                    &#30;                 ^^                        Record Separator
    31                    037                    1F                    00011111                    :f:`US`                    &#31;                 ^_                        Unit Separator
    127                    177                    7F                    01111111                    :f:`DEL`                  &#127;                ^?                         Delete
    ============= ==================== ===================== ========================= =========================== ======================= ======================== ==================================================================================================================

Shell 中使用 ``cat -vET file`` 可以打印出一些 Caret Notation 格式的字符。

制表符
^^^^^^^^^^^^^^^^

制表符（Tab）不是可打印字符，因为它不是用于显示某个具体字符，更不代表固定长度的空白字符，而是用于控制文本的格式和布局。

假设在 HTML 的 \<pre\> 元素中插入这样一段源码：

.. code-block:: html
  :linenos:

  &#9;This line begins with a single tab.
  Here&#9;are&#9;some&#9;more&#9;tab&#9;characters&#9;!
  T.......T.......T.......T.......T.......T.......T.......T


网页中显示的效果如下（默认 tab-size 为 8）：

.. raw:: html

  <pre>
  &#9;This line begins with a single tab.
  Here&#9;are&#9;some&#9;more&#9;tab&#9;characters&#9;!
  T.......T.......T.......T.......T.......T.......T.......T
  </pre>


满足：

.. math::

    (\mathrm{wordLength} + \mathrm{tabSpaceLength})\ \% \ \mathrm{tabSize} = 0

使用文本编辑器时，可以设置按 Tab 键插入一个制表符，或者插入固定长度的空格（一般默认为 4 个空格）。


可打印字符（95）
-----------------


.. table:: Printable Characters
    :align: center

    ============= ==================== ===================== ========================= =========================== ========================== ======================= ===============================================================================================================
    DEC                   OCT                    HEX                    BIN                      Symbol                   HTML Number                HTML Name                    Description
    ============= ==================== ===================== ========================= =========================== ========================== ======================= ===============================================================================================================
    32                    040                    20                    00100000                    :f:`SP`                   &#32;                                         Space
    33                    041                    21                    00100001                    :f:`!`                    &#33;                    &excl;                    Exclamation mark
    34                    042                    22                    00100010                    :f:`"`                    &\#34;                    &quot;                    Double quotes, Speech marks
    35                    043                    23                    00100011                    :f:`#`                    &#35;                    &num;                    Number sign
    36                    044                    24                    00100100                    :f:`$`                    &#36;                    &dollar;                    Dollar
    37                    045                    25                    00100101                    :f:`%`                    &#37;                    &percnt;                    Percent sign
    38                    046                    26                    00100110                    :f:`&`                    &#38;                    &amp;                    Ampersand
    39                    047                    27                    00100111                    :f:`'`                    &\#39;                    &apos;                    Single quote
    40                    050                    28                    00101000                    :f:`(`                    &#40;                    &lparen;                    Open parenthesis, Open bracket
    41                    051                    29                    00101001                    :f:`)`                    &#41;                    &rparen;                    Close parenthesis, Close bracket
    42                    052                    2A                    00101010                    :f:`*`                    &#42;                    &ast;                    Asterisk
    43                    053                    2B                    00101011                    :f:`+`                    &#43;                    &plus;                    Plus
    44                    054                    2C                    00101100                    :f:`,`                    &#44;                    &comma;                    Comma
    45                    055                    2D                    00101101                    :f:`-`                    &\#45;                                         Hyphen, Minus
    46                    056                    2E                    00101110                    :f:`.`                    &\#46;                    &period;                    Period, Dot, Full stop
    47                    057                    2F                    00101111                    :f:`/`                    &#47;                    &sol;                    Slash, Divide
    48                    060                    30                    00110000                    :f:`0`                    &#48;                                         Zero
    49                    061                    31                    00110001                    :f:`1`                    &#49;                                         One
    50                    062                    32                    00110010                    :f:`2`                    &#50;                                         Two
    51                    063                    33                    00110011                    :f:`3`                    &#51;                                         Three
    52                    064                    34                    00110100                    :f:`4`                    &#52;                                         Four
    53                    065                    35                    00110101                    :f:`5`                    &#53;                                         Five
    54                    066                    36                    00110110                    :f:`6`                    &#54;                                         Six
    55                    067                    37                    00110111                    :f:`7`                    &#55;                                         Seven
    56                    070                    38                    00111000                    :f:`8`                    &#56;                                         Eight
    57                    071                    39                    00111001                    :f:`9`                    &#57;                                         Nine
    58                    072                    3A                    00111010                    :f:`:`                    &#58;                    &colon;                    Colon
    59                    073                    3B                    00111011                    :f:`;`                    &#59;                    &semi;                    Semicolon
    60                    074                    3C                    00111100                    :f:`<`                    &#60;                    &lt;                    Less than, Open angled bracket
    61                    075                    3D                    00111101                    :f:`=`                    &#61;                    &equals;                    Equals
    62                    076                    3E                    00111110                    :f:`>`                    &#62;                    &gt;                    Greater than, Close angled bracket
    63                    077                    3F                    00111111                    :f:`?`                    &#63;                    &quest;                    Question mark
    64                    100                    40                    01000000                    :f:`@`                    &#64;                    &commat;                    At sign
    65                    101                    41                    01000001                    :f:`A`                    &#65;                                         Uppercase A
    66                    102                    42                    01000010                    :f:`B`                    &#66;                                         Uppercase B
    67                    103                    43                    01000011                    :f:`C`                    &#67;                                         Uppercase C
    68                    104                    44                    01000100                    :f:`D`                    &#68;                                         Uppercase D
    69                    105                    45                    01000101                    :f:`E`                    &#69;                                         Uppercase E
    70                    106                    46                    01000110                    :f:`F`                    &#70;                                         Uppercase F
    71                    107                    47                    01000111                    :f:`G`                    &#71;                                         Uppercase G
    72                    110                    48                    01001000                    :f:`H`                    &#72;                                         Uppercase H
    73                    111                    49                    01001001                    :f:`I`                    &#73;                                         Uppercase I
    74                    112                    4A                    01001010                    :f:`J`                    &#74;                                         Uppercase J
    75                    113                    4B                    01001011                    :f:`K`                    &#75;                                         Uppercase K
    76                    114                    4C                    01001100                    :f:`L`                    &#76;                                         Uppercase L
    77                    115                    4D                    01001101                    :f:`M`                    &#77;                                         Uppercase M
    78                    116                    4E                    01001110                    :f:`N`                    &#78;                                         Uppercase N
    79                    117                    4F                    01001111                    :f:`O`                    &#79;                                         Uppercase O
    80                    120                    50                    01010000                    :f:`P`                    &#80;                                         Uppercase P
    81                    121                    51                    01010001                    :f:`Q`                    &#81;                                         Uppercase Q
    82                    122                    52                    01010010                    :f:`R`                    &#82;                                         Uppercase R
    83                    123                    53                    01010011                    :f:`S`                    &#83;                                         Uppercase S
    84                    124                    54                    01010100                    :f:`T`                    &#84;                                         Uppercase T
    85                    125                    55                    01010101                    :f:`U`                    &#85;                                         Uppercase U
    86                    126                    56                    01010110                    :f:`V`                    &#86;                                         Uppercase V
    87                    127                    57                    01010111                    :f:`W`                    &#87;                                         Uppercase W
    88                    130                    58                    01011000                    :f:`X`                    &#88;                                         Uppercase X
    89                    131                    59                    01011001                    :f:`Y`                    &#89;                                         Uppercase Y
    90                    132                    5A                    01011010                    :f:`Z`                    &#90;                                         Uppercase Z
    91                    133                    5B                    01011011                    :f:`[`                    &#91;                    &lsqb;                    Opening bracket
    92                    134                    5C                    01011100                    :f:`\\`                    &\#92;                    &bsol;                    Backslash
    93                    135                    5D                    01011101                    :f:`]`                    &#93;                    &rsqb;                    Closing bracket
    94                    136                    5E                    01011110                    :f:`^`                    &#94;                    &Hat;                    Caret, Circumflex
    95                    137                    5F                    01011111                    :f:`_`                    &#95;                    &lowbar;                    Underscore
    96                    140                    60                    01100000                    :f:`\``                    &\#96;                    &grave;                    Grave accent
    97                    141                    61                    01100001                    :f:`a`                    &#97;                                         Lowercase a
    98                    142                    62                    01100010                    :f:`b`                    &#98;                                         Lowercase b
    99                    143                    63                    01100011                    :f:`c`                    &#99;                                         Lowercase c
    100                    144                    64                    01100100                    :f:`d`                    &#100;                                         Lowercase d
    101                    145                    65                    01100101                    :f:`e`                    &#101;                                         Lowercase e
    102                    146                    66                    01100110                    :f:`f`                    &#102;                                         Lowercase f
    103                    147                    67                    01100111                    :f:`g`                    &#103;                                         Lowercase g
    104                    150                    68                    01101000                    :f:`h`                    &#104;                                         Lowercase h
    105                    151                    69                    01101001                    :f:`i`                    &#105;                                         Lowercase i
    106                    152                    6A                    01101010                    :f:`j`                    &#106;                                         Lowercase j
    107                    153                    6B                    01101011                    :f:`k`                    &#107;                                         Lowercase k
    108                    154                    6C                    01101100                    :f:`l`                    &#108;                                         Lowercase l
    109                    155                    6D                    01101101                    :f:`m`                    &#109;                                         Lowercase m
    110                    156                    6E                    01101110                    :f:`n`                    &#110;                                         Lowercase n
    111                    157                    6F                    01101111                    :f:`o`                    &#111;                                         Lowercase o
    112                    160                    70                    01110000                    :f:`p`                    &#112;                                         Lowercase p
    113                    161                    71                    01110001                    :f:`q`                    &#113;                                         Lowercase q
    114                    162                    72                    01110010                    :f:`r`                    &#114;                                         Lowercase r
    115                    163                    73                    01110011                    :f:`s`                    &#115;                                         Lowercase s
    116                    164                    74                    01110100                    :f:`t`                    &#116;                                         Lowercase t
    117                    165                    75                    01110101                    :f:`u`                    &#117;                                         Lowercase u
    118                    166                    76                    01110110                    :f:`v`                    &#118;                                         Lowercase v
    119                    167                    77                    01110111                    :f:`w`                    &#119;                                         Lowercase w
    120                    170                    78                    01111000                    :f:`x`                    &#120;                                         Lowercase x
    121                    171                    79                    01111001                    :f:`y`                    &#121;                                         Lowercase y
    122                    172                    7A                    01111010                    :f:`z`                    &#122;                                         Lowercase z
    123                    173                    7B                    01111011                    :f:`{`                    &#123;                    &lcub;                    Opening brace
    124                    174                    7C                    01111100                    :f:`|`                    &#124;                    &verbar;                    Vertical bar
    125                    175                    7D                    01111101                    :f:`}`                    &#125;                    &rcub;                    Closing brace
    126                    176                    7E                    01111110                    :f:`~`                    &#126;                    &tilde;                    Equivalency sign, Tilde
    ============= ==================== ===================== ========================= =========================== ========================== ======================= ===============================================================================================================


参考资料
-------------

1. ASCII Table

  https://www.ascii-code.com/

2. ASCII

  https://en.wikipedia.org/wiki/ASCII