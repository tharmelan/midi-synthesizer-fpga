-------------------------------------------------------------------------------
-- Project     : audio_top
-- Description : Constants and LUT for tone generation with DDS
--
--
-------------------------------------------------------------------------------
--
-- Change History
-- Date     |Name      |Modification
------------|----------|-------------------------------------------------------
-- 12.04.13 | dqtm     | file created for DTP2 Milestone-3 in FS13
-- 02.04.14 | dqtm     | updated for DTP2 in FS14, cause using new parameters
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Package  Declaration
-------------------------------------------------------------------------------
-- Include in Design of Block dds.vhd and tone_decoder.vhd :
--   use work.tone_gen_pkg.all;
-------------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

package tone_gen_pkg is

 type t_tone_array is array (0 to 9) of std_logic_vector(6 downto 0) ;
 type t_note_on is array (0 to 9) of std_logic;

  
    -------------------------------------------------------------------------------
	-- TYPES AND CONSTANTS FOR MIDI INTERFACE
	-------------------------------------------------------------------------------	
	-- type t_note_record is
	--   record
	-- 	valid 		: std_logic;
	-- 	number 		: std_logic_vector(6 downto 0);
	-- 	velocity	: std_logic_vector(6 downto 0); 
	--   end record;

	-- CONSTANT NOTE_INIT_VALUE : t_note_record := (valid  	=> '0',
	-- 											 number 	=> (others => '0'),
	-- 											 velocity 	=> (others => '0'));
	  
	-- type t_midi_array is array (0 to 9) of t_note_record; -- 10x note_record


    -------------------------------------------------------------------------------
	-- CONSTANT DECLARATION FOR SEVERAL BLOCKS (DDS, TONE_GENERATOR, ...)
	-------------------------------------------------------------------------------
    constant N_CUM:					natural :=19; 			-- number of bits in phase cumulator phicum_reg
    constant N_LUT:					natural :=8;  			-- number of bits in LUT address
    constant L: 					natural := 2**N_LUT; 	-- length of LUT
    constant N_RESOL:				natural := 13;			-- Attention: 1 bit reserved for sign
	constant N_AUDIO :				natural := 16;			-- Audio Paralell Bus width
	-------------------------------------------------------------------------------
	-- TYPE DECLARATION FOR DDS
	-------------------------------------------------------------------------------
    subtype t_audio_range is integer range -(2**(N_RESOL-1)) to (2**(N_RESOL-1))-1;  -- range : [-2^12; +(2^12)-1]

 type t_lut_rom is array (0 to L-1) of t_audio_range;
 --type t_lut_rom is array (0 to L-1) of integer;

	constant LUT : t_lut_rom :=(
	0, 101, 201, 301, 401, 501, 601, 700, 799, 897, 995, 1092, 1189, 1285, 1380, 1474, 1567,
	1660, 1751, 1842, 1931, 2019, 2106, 2191, 2276, 2359, 2440, 2520, 2598, 2675, 2751, 2824,
	2896, 2967, 3035, 3102, 3166, 3229, 3290, 3349, 3406, 3461, 3513, 3564, 3612, 3659, 3703,
	3745, 3784, 3822, 3857, 3889, 3920, 3948, 3973, 3996, 4017, 4036, 4052, 4065, 4076, 4085,
	4091, 4095, 4095, 4095, 4091, 4085, 4076, 4065, 4052, 4036, 4017, 3996, 3973, 3948, 3920,
	3889, 3857, 3822, 3784, 3745, 3703, 3659, 3612, 3564, 3513, 3461, 3406, 3349, 3290, 3229,
	3166, 3102, 3035, 2967, 2896, 2824, 2751, 2675, 2598, 2520, 2440, 2359, 2276, 2191, 2106,
	2019, 1931, 1842, 1751, 1660, 1567, 1474, 1380, 1285, 1189, 1092, 995, 897, 799, 700, 601,
	501, 401, 301, 201, 101, 0, -101, -201, -301, -401, -501, -601, -700, -799, -897, -995,
	-1092, -1189, -1285, -1380, -1474, -1567, -1660, -1751, -1842, -1931, -2019, -2106, -2191,
	-2276, -2359, -2440, -2520, -2598, -2675, -2751, -2824, -2896, -2967, -3035, -3102, -3166,
	-3229, -3290, -3349, -3406, -3461, -3513, -3564, -3612, -3659, -3703, -3745, -3784, -3822,
	-3857, -3889, -3920, -3948, -3973, -3996, -4017, -4036, -4052, -4065, -4076, -4085, -4091,
	-4095, -4096, -4095, -4091, -4085, -4076, -4065, -4052, -4036, -4017, -3996, -3973, -3948,
	-3920, -3889, -3857, -3822, -3784, -3745, -3703, -3659, -3612, -3564, -3513, -3461, -3406,
	-3349, -3290, -3229, -3166, -3102, -3035, -2967, -2896, -2824, -2751, -2675, -2598, -2520,
	-2440, -2359, -2276, -2191, -2106, -2019, -1931, -1842, -1751, -1660, -1567, -1474, -1380,
	-1285, -1189, -1092, -995, -897, -799, -700, -601, -501, -401, -301, -201, -101 );
	
	constant LUT_VIOLA : t_lut_rom :=(
	622,1461,1990,2234,2298,2310,2342,2387,2411,2381,2236,1920,1479,1063,810,757,868,1085,1348,
	1594,1760,1823,1836,1886,1991,2090,2146,2172,2153,2030,1811,1565,1317,1028,670,244,-257,-814,
	-1373,-1894,-2358,-2729,-2989,-3181,-3328,-3359,-3213,-2949,-2653,-2317,-1896,-1409,-896,-360,
	197,744,1242,1658,1976,2223,2460,2708,2935,3131,3320,3501,3626,3659,3605,3477,3289,3060,2801,
	2503,2152,1735,1248,706,141,-423,-974,-1497,-1982,-2428,-2824,-3134,-3316,-3347,-3232,-2992,
	-2659,-2272,-1871,-1500,-1194,-966,-799,-663,-533,-393,-244,-95,38,137,191,204,186,139,68,-7,
	-57,-61,-16,76,198,318,405,433,388,264,80,-124,-310,-456,-567,-654,-728,-794,-854,-906,-940,
	-948,-924,-856,-718,-493,-191,142,444,660,759,733,580,317,-17,-368,-692,-956,-1137,-1219,-1205,
	-1115,-986,-857,-761,-713,-725,-804,-944,-1124,-1323,-1529,-1717,-1862,-1943,-1947,-1864,-1686,
	-1414,-1057,-622,-119,455,1097,1777,2447,3061,3575,3934,4090,4034,3793,3418,2986,2602,2352,2257,
	2270,2299,2249,2061,1730,1291,817,401,127,34,117,341,643,945,1191,1378,1542,1733,1973,2237,2451,
	2522,2364,1934,1271,498,-238,-836,-1251,-1479,-1562,-1582,-1626,-1736,-1889,-2023,-2074,-2010,
	-1835,-1586,-1335,-1156,-1072,-1045,-1017,-949,-816,-616,-397,-251,-253,-423,-744,-1194,-1734,
	-2298,-2827,-3309,-3768,-4216,-4624,-4950,-5136,-5094,-4724,-3986,-2936,-1710,-473 );
	
	constant LUT_BASSOON : t_lut_rom :=(
	212,227,306,439,584,691,730,702,636,563,497,428,329,180,-18,-234,-414,-508,-484,-341,-108,176,469,738,962,1128,1232,1271,1253,1191,1101,996,880,748,594,416,225,44,-100,-184,-206,-177,-113,-29,75,212,393,619,873,1122,1326,1460,1517,1512,1468,1404,1324,1214,1049,807,481,81,-365,-822,-1253,-1629,-1932,-2155,-2297,-2362,-2349,-2251,-2049,-1721,-1247,-627,113,914,1700,2392,2934,3308,3532,3653,3719,3762,3786,3765,3662,3441,3085,2601,2019,1386,754,173,-322,-715,-1008,-1219,-1370,-1472,-1512,-1462,-1282,-953,-498,10,455,715,701,395,-141,-782,-1386,-1836,-2085,-2157,-2131,-2098,-2121,-2206,-2299,-2312,-2156,-1776,-1177,-427,364,1068,1572,1809,1762,1465,977,367,-311,-1021,-1744,-2468,-3167,-3807,-4344,-4735,-4956,-5002,-4887,-4632,-4249,-3741,-3102,-2329,-1434,-453,562,1545,2431,3164,3703,4017,4091,3924,3540,2982,2316,1611,931,314,-232,-719,-1170,-1598,-2001,-2357,-2631,-2794,-2825,-2715,-2470,-2102,-1633,-1090,-510,62,585,1028,1373,1625,1797,1905,1957,1952,1881,1737,1524,1254,951,636,331,47,-205,-416,-575,-673,-707,-681,-607,-502,-375,-232,-69,117,328,550,766,950,1079,1138,1119,1026,870,671,456,250,75,-59,-160,-247,-339,-448,-563,-660,-708,-692,-621,-527,-449,-413,-415,-428,-414,-356,-267,-193,-186,-274,-441,-623,-740,-730,-581,-339,-81,115,212,227
	);
	
	constant LUT_CLARINET : t_lut_rom :=(	
	-532,-1128,-1763,-2399,-3001,-3539,-3993,-4354,-4618,-4787,-4865,-4859,-4776,-4624,-4417,-4171,-3906,-3641,-3391,-3166,-2967,-2790,-2626,-2469,-2312,-2155,-2004,-1867,-1750,-1658,-1590,-1538,-1495,-1453,-1405,-1351,-1295,-1243,-1200,-1168,-1144,-1119,-1083,-1027,-947,-844,-725,-602,-487,-389,-312,-254,-210,-173,-138,-106,-78,-63,-66,-94,-147,-221,-309,-400,-487,-562,-624,-674,-715,-752,-789,-829,-873,-921,-973,-1029,-1088,-1150,-1210,-1268,-1318,-1358,-1383,-1392,-1383,-1354,-1303,-1226,-1118,-973,-787,-559,-293,-1,301,594,859,1079,1242,1345,1386,1368,1296,1175,1008,798,553,280,-8,-296,-571,-820,-1034,-1210,-1352,-1464,-1552,-1619,-1665,-1686,-1676,-1628,-1542,-1418,-1262,-1079,-875,-653,-411,-146,149,475,830,1206,1590,1969,2328,2658,2956,3222,3457,3664,3838,3974,4063,4095,4069,3988,3865,3720,3575,3447,3348,3277,3224,3173,3104,3005,2870,2702,2514,2321,2140,1980,1846,1733,1634,1539,1439,1327,1202,1063,913,753,584,411,236,66,-87,-214,-301,-341,-330,-268,-163,-23,139,316,502,694,891,1092,1292,1486,1664,1814,1926,1994,2012,1981,1903,1782,1622,1427,1200,944,664,368,66,-231,-511,-765,-983,-1159,-1289,-1370,-1399,-1373,-1291,-1153,-962,-726,-456,-165,130,416,680,915,1114,1273,1390,1464,1495,1487,1446,1382,1307,1234,1177,1141,1130,1140,1162,1188,1209,1223,1229,1230,1225,1211,1176,1101,964,742,419,-9
	);
	
	constant LUT_ENGLISH_HORN : t_lut_rom :=(	
	-568,-1083,-1590,-2071,-2505,-2875,-3170,-3390,-3541,-3638,-3695,-3721,-3721,-3690,-3621,-3504,-3333,-3108,-2835,-2524,-2190,-1846,-1505,-1177,-870,-584,-319,-71,168,402,632,854,1058,1228,1352,1418,1424,1373,1277,1146,994,831,661,489,320,158,8,-124,-236,-325,-393,-444,-481,-506,-519,-520,-510,-490,-461,-427,-388,-345,-295,-240,-178,-112,-46,17,73,126,179,236,302,376,453,528,591,639,669,684,686,680,667,648,620,583,536,482,423,360,295,228,159,87,13,-59,-128,-191,-249,-303,-355,-405,-450,-489,-516,-529,-531,-526,-521,-522,-532,-550,-569,-584,-588,-580,-561,-536,-511,-490,-474,-463,-455,-447,-437,-425,-407,-383,-352,-313,-270,-227,-190,-163,-148,-143,-143,-140,-130,-113,-91,-69,-55,-52,-57,-65,-68,-61,-40,-7,34,77,114,142,158,163,158,145,127,110,97,92,97,110,127,143,152,154,150,148,156,181,225,286,356,429,498,562,623,685,754,831,913,995,1069,1130,1171,1191,1190,1169,1131,1078,1013,938,853,754,637,494,318,107,-135,-396,-659,-904,-1116,-1287,-1419,-1520,-1604,-1686,-1774,-1867,-1958,-2036,-2088,-2101,-2068,-1986,-1857,-1687,-1484,-1258,-1016,-763,-499,-221,79,408,771,1164,1576,1991,2387,2747,3061,3323,3539,3715,3858,3970,4050,4092,4086,4026,3909,3736,3509,3236,2921,2571,2192,1786,1357,905,433,-60
	); 

	constant LUT_TRUMPET : t_lut_rom :=(	
	0,377,751,1118,1474,1816,2141,2446,2729,2987,3218,3422,3596,3740,3854,3938,3992,4017,4014,3985,3932,3856,3760,3647,3518,3376,3225,3067,2904,2739,2574,2411,2253,2102,1958,1823,1698,1583,1480,1388,1307,1237,1178,1127,1086,1052,1024,1002,984,968,953,939,923,906,886,862,834,801,763,720,673,620,564,503,440,374,307,239,171,104,39,-23,-82,-136,-186,-230,-269,-303,-330,-352,-368,-379,-385,-388,-387,-383,-377,-370,-364,-357,-352,-350,-350,-353,-360,-371,-387,-406,-431,-459,-490,-525,-563,-602,-642,-682,-721,-758,-793,-823,-848,-867,-879,-884,-881,-869,-849,-819,-780,-732,-676,-611,-539,-460,-375,-286,-193,-97,0,97,193,286,375,460,539,611,676,732,780,819,849,869,881,884,879,867,848,823,793,758,721,682,642,602,563,525,490,459,431,406,387,371,360,353,350,350,352,357,364,370,377,383,387,388,385,379,368,352,330,303,269,230,186,136,82,23,-39,-104,-171,-239,-307,-374,-440,-503,-564,-620,-673,-720,-763,-801,-834,-862,-886,-906,-923,-939,-953,-968,-984,-1002,-1024,-1052,-1086,-1127,-1178,-1237,-1307,-1388,-1480,-1583,-1698,-1823,-1958,-2102,-2253,-2411,-2574,-2739,-2904,-3067,-3225,-3376,-3518,-3647,-3760,-3856,-3932,-3985,-4014,-4017,-3992,-3938,-3854,-3740,-3596,-3422,-3218,-2987,-2729,-2446,-2141,-1816,-1474,-1118,-751,-377
	); 
	
	constant LUT_PIANO : t_lut_rom :=(	
	0,234,466,697,926,1152,1373,1590,1801,2006,2204,2395,2578,2752,2917,3072,3217,3352,3476,3588,3690,3780,3859,3926,3981,4025,4057,4078,4087,4086,4074,4052,4019,3977,3926,3866,3798,3722,3639,3549,3453,3352,3245,3134,3020,2902,2782,2659,2536,2411,2285,2160,2036,1912,1790,1671,1553,1438,1326,1217,1112,1011,914,821,733,648,569,494,424,359,298,242,190,143,100,62,28,-3,-29,-52,-72,-88,-102,-112,-120,-126,-129,-130,-129,-127,-124,-119,-113,-106,-99,-91,-83,-74,-65,-57,-48,-39,-31,-23,-16,-9,-3,3,9,13,17,21,23,26,27,28,28,28,27,26,24,22,20,17,14,11,7,4,0,-4,-7,-11,-14,-17,-20,-22,-24,-26,-27,-28,-28,-28,-27,-26,-23,-21,-17,-13,-9,-3,3,9,16,23,31,39,48,57,65,74,83,91,99,106,113,119,124,127,129,130,129,126,120,112,102,88,72,52,29,3,-28,-62,-100,-143,-190,-242,-298,-359,-424,-494,-569,-648,-732,-821,-914,-1011,-1112,-1217,-1326,-1438,-1553,-1671,-1790,-1912,-2036,-2160,-2285,-2411,-2536,-2659,-2782,-2902,-3020,-3134,-3245,-3352,-3453,-3549,-3639,-3722,-3798,-3866,-3926,-3977,-4019,-4052,-4074,-4086,-4087,-4078,-4057,-4025,-3981,-3926,-3859,-3780,-3690,-3588,-3476,-3352,-3217,-3072,-2917,-2752,-2578,-2395,-2204,-2006,-1801,-1590,-1373,-1152,-926,-697,-466,-234
	); 
	
	constant LUT_ORGAN : t_lut_rom :=(	
	0,223,445,665,883,1099,1310,1517,1719,1915,2105,2288,2463,2631,2790,2941,3083,3215,3338,3452,3555,3650,3734,3809,3874,3930,3976,4014,4043,4064,4077,4082,4080,4071,4056,4035,4009,3977,3941,3901,3857,3810,3760,3708,3653,3597,3539,3480,3420,3359,3298,3236,3173,3111,3048,2984,2921,2857,2792,2727,2662,2595,2528,2460,2390,2319,2246,2172,2095,2017,1936,1853,1767,1680,1589,1496,1401,1303,1203,1101,996,890,782,673,562,451,340,228,117,7,-102,-209,-314,-416,-514,-609,-700,-786,-867,-942,-1011,-1073,-1129,-1177,-1218,-1251,-1277,-1294,-1302,-1303,-1294,-1278,-1253,-1221,-1180,-1131,-1076,-1013,-943,-868,-786,-700,-609,-513,-415,-314,-210,-105,0,105,210,314,415,513,609,700,786,868,943,1013,1076,1131,1180,1221,1253,1278,1294,1303,1302,1294,1277,1251,1218,1177,1129,1073,1011,942,867,786,700,609,514,416,314,209,102,-7,-117,-228,-340,-451,-562,-673,-782,-890,-996,-1101,-1203,-1303,-1401,-1496,-1589,-1680,-1767,-1853,-1936,-2017,-2095,-2172,-2246,-2319,-2390,-2460,-2528,-2595,-2662,-2727,-2792,-2857,-2921,-2984,-3048,-3111,-3173,-3236,-3298,-3359,-3420,-3480,-3539,-3597,-3653,-3708,-3760,-3810,-3857,-3901,-3941,-3977,-4009,-4035,-4056,-4071,-4080,-4082,-4077,-4064,-4043,-4014,-3976,-3930,-3874,-3809,-3734,-3650,-3555,-3452,-3338,-3215,-3083,-2941,-2790,-2631,-2463,-2288,-2105,-1915,-1719,-1517,-1310,-1099,-883,-665,-445,-223
	); 
	
	constant LUT_OBOE : t_lut_rom :=(	
	0,234,467,699,927,1153,1374,1590,1800,2004,2201,2390,2571,2742,2905,3057,3200,3332,3453,3564,3664,3753,3830,3898,3954,4000,4036,4062,4078,4086,4085,4075,4058,4034,4004,3967,3925,3879,3828,3774,3718,3659,3598,3537,3474,3412,3351,3290,3231,3173,3118,3064,3014,2966,2922,2880,2842,2807,2776,2748,2722,2700,2681,2664,2650,2638,2628,2620,2613,2607,2602,2598,2593,2589,2584,2578,2571,2562,2552,2540,2526,2510,2492,2470,2446,2419,2390,2357,2321,2283,2241,2197,2150,2101,2049,1995,1938,1880,1820,1758,1695,1631,1566,1500,1433,1367,1300,1233,1167,1100,1035,970,906,843,780,719,658,599,541,483,427,372,317,263,210,157,104,52,0,-52,-104,-157,-210,-263,-317,-372,-427,-483,-541,-599,-658,-719,-780,-843,-906,-970,-1035,-1100,-1167,-1233,-1300,-1367,-1433,-1500,-1566,-1631,-1695,-1758,-1820,-1880,-1938,-1995,-2049,-2101,-2150,-2197,-2241,-2283,-2321,-2357,-2390,-2419,-2446,-2470,-2492,-2510,-2526,-2540,-2552,-2562,-2571,-2578,-2584,-2589,-2593,-2598,-2602,-2607,-2613,-2620,-2628,-2638,-2650,-2664,-2681,-2700,-2722,-2748,-2776,-2807,-2842,-2880,-2922,-2966,-3014,-3064,-3118,-3173,-3231,-3290,-3351,-3412,-3474,-3537,-3598,-3659,-3718,-3774,-3828,-3879,-3925,-3967,-4004,-4034,-4058,-4075,-4085,-4086,-4078,-4062,-4036,-4000,-3954,-3898,-3830,-3753,-3664,-3564,-3453,-3332,-3200,-3057,-2905,-2742,-2571,-2390,-2201,-2004,-1800,-1590,-1374,-1153,-927,-699,-467,-234
	); 
	
	constant LUT_FLUTE : t_lut_rom :=(	
	126,154,182,209,234,255,273,286,293,293,288,275,255,229,197,159,116,69,18,-34,-88,-143,-198,-253,-309,-364,-420,-477,-535,-596,-658,-723,-792,-863,-936,-1010,-1086,-1161,-1233,-1302,-1365,-1422,-1469,-1507,-1533,-1547,-1549,-1537,-1513,-1477,-1430,-1374,-1309,-1239,-1164,-1088,-1013,-940,-873,-814,-764,-726,-702,-693,-700,-723,-763,-818,-889,-972,-1065,-1164,-1267,-1368,-1462,-1544,-1608,-1651,-1666,-1649,-1597,-1506,-1376,-1205,-994,-745,-462,-148,190,547,917,1291,1663,2025,2371,2695,2991,3256,3486,3678,3834,3951,4032,4080,4095,4083,4047,3990,3917,3831,3735,3634,3528,3420,3310,3200,3089,2977,2862,2745,2622,2494,2358,2214,2061,1899,1728,1549,1361,1168,970,770,570,373,181,-5,-180,-345,-496,-632,-753,-858,-946,-1017,-1072,-1111,-1134,-1143,-1138,-1122,-1095,-1059,-1016,-969,-919,-869,-822,-780,-746,-723,-713,-719,-741,-781,-840,-916,-1009,-1116,-1235,-1362,-1493,-1623,-1748,-1863,-1963,-2045,-2105,-2142,-2154,-2141,-2104,-2045,-1968,-1874,-1770,-1659,-1545,-1432,-1325,-1225,-1134,-1054,-984,-923,-870,-821,-775,-727,-676,-618,-552,-475,-387,-289,-180,-63,60,186,312,436,553,661,758,842,911,964,1003,1026,1036,1033,1019,997,966,931,890,847,801,755,707,659,611,562,513,464,416,367,319,272,227,184,144,107,74,46,23,5,-8,-15,-17,-13,-4,9,26,48,72,98
	); 
	
	constant LUT_VIOLIN : t_lut_rom :=(	
	-131,-244,-277,-230,-112,64,285,534,797,1057,1300,1516,1695,1839,1952,2044,2123,2200,2278,2360,2445,2530,2610,2675,2711,2700,2622,2464,2220,1901,1527,1128,741,401,139,-24,-77,-22,127,342,589,831,1037,1185,1265,1280,1240,1155,1036,889,718,526,320,102,-121,-350,-585,-829,-1087,-1359,-1644,-1939,-2238,-2538,-2833,-3119,-3384,-3615,-3795,-3908,-3941,-3890,-3758,-3559,-3310,-3029,-2736,-2444,-2163,-1896,-1642,-1390,-1132,-858,-564,-258,49,336,584,778,911,982,993,949,858,728,573,413,270,163,106,98,131,190,262,338,418,500,575,624,616,515,295,-48,-494,-997,-1496,-1931,-2255,-2442,-2487,-2405,-2224,-1973,-1681,-1370,-1053,-735,-417,-93,236,564,878,1159,1392,1573,1712,1832,1961,2121,2321,2547,2776,2979,3136,3245,3321,3389,3473,3587,3730,3883,4015,4089,4070,3924,3629,3181,2594,1908,1183,489,-109,-568,-883,-1081,-1212,-1334,-1486,-1677,-1887,-2074,-2195,-2223,-2156,-2019,-1851,-1692,-1567,-1483,-1425,-1369,-1290,-1172,-1011,-819,-615,-424,-271,-175,-150,-198,-315,-484,-680,-870,-1023,-1113,-1122,-1052,-913,-725,-508,-278,-44,188,407,591,708,719,594,325,-68,-533,-1005,-1421,-1742,-1960,-2098,-2191,-2271,-2355,-2434,-2493,-2517,-2504,-2474,-2452,-2454,-2478,-2490,-2442,-2285,-1994,-1576,-1070,-531,-12,455,864,1228,1565,1882,2168,2396,2534,2559,2465,2264,1981,1648,1294,941,607,308,57
	);
	
	constant LUT_TUBA : t_lut_rom :=(	
	61,-156,-337,-482,-590,-663,-702,-709,-689,-645,-582,-503,-414,-317,-216,-111,-6,98,201,302,399,490,575,651,716,768,805,827,832,821,794,752,697,629,550,462,366,264,157,46,-67,-181,-292,-398,-498,-589,-669,-737,-794,-839,-873,-900,-921,-939,-956,-975,-996,-1021,-1048,-1078,-1109,-1139,-1167,-1193,-1215,-1234,-1248,-1258,-1264,-1266,-1262,-1252,-1235,-1208,-1171,-1120,-1057,-979,-888,-784,-670,-549,-422,-293,-164,-38,84,200,309,410,502,585,657,718,765,798,816,818,806,780,742,696,644,589,535,484,437,396,361,331,305,280,256,231,205,177,150,125,103,87,80,83,98,126,167,219,281,350,423,496,565,624,669,696,701,681,634,559,457,330,183,21,-150,-322,-489,-644,-781,-895,-985,-1048,-1087,-1102,-1096,-1074,-1039,-994,-942,-885,-824,-760,-694,-626,-557,-488,-421,-357,-298,-245,-200,-162,-133,-109,-91,-74,-57,-39,-17,8,35,62,86,102,107,96,66,16,-56,-147,-256,-377,-507,-641,-772,-898,-1014,-1119,-1213,-1296,-1372,-1443,-1513,-1588,-1670,-1763,-1868,-1986,-2114,-2249,-2384,-2512,-2623,-2707,-2755,-2755,-2701,-2586,-2407,-2164,-1861,-1503,-1102,-668,-215,245,698,1135,1546,1926,2271,2580,2855,3097,3311,3499,3662,3802,3918,4007,4067,4094,4084,4033,3939,3802,3622,3401,3144,2857,2545,2217,1880,1541,1208,888,586,309
	);
	
	constant LUT_PICCOLO : t_lut_rom :=(	
	28,-135,-305,-483,-669,-862,-1061,-1265,-1474,-1686,-1899,-2111,-2321,-2526,-2725,-2916,-3096,-3266,-3422,-3564,-3691,-3801,-3894,-3970,-4028,-4068,-4090,-4096,-4086,-4061,-4023,-3975,-3917,-3853,-3783,-3709,-3633,-3557,-3481,-3405,-3331,-3256,-3182,-3108,-3033,-2956,-2878,-2798,-2715,-2631,-2545,-2459,-2373,-2289,-2207,-2130,-2057,-1990,-1930,-1875,-1828,-1787,-1752,-1721,-1696,-1673,-1654,-1636,-1620,-1605,-1592,-1580,-1571,-1565,-1564,-1568,-1580,-1599,-1628,-1665,-1713,-1769,-1834,-1906,-1982,-2061,-2141,-2219,-2293,-2360,-2420,-2471,-2512,-2544,-2566,-2579,-2584,-2580,-2569,-2549,-2522,-2484,-2436,-2374,-2297,-2202,-2086,-1948,-1788,-1603,-1396,-1169,-923,-663,-393,-119,155,423,680,923,1148,1354,1538,1702,1846,1971,2079,2172,2252,2321,2381,2432,2475,2511,2540,2562,2577,2587,2593,2595,2595,2595,2598,2605,2617,2636,2664,2699,2741,2788,2840,2893,2946,2995,3040,3077,3106,3126,3138,3142,3139,3130,3117,3101,3084,3065,3046,3026,3004,2981,2954,2923,2887,2846,2799,2746,2689,2627,2563,2496,2429,2363,2298,2236,2175,2117,2061,2006,1952,1898,1845,1793,1741,1689,1640,1593,1549,1509,1475,1445,1421,1402,1388,1378,1371,1366,1362,1359,1355,1351,1346,1341,1336,1331,1327,1324,1322,1322,1324,1327,1330,1335,1339,1343,1347,1350,1353,1356,1360,1365,1372,1381,1392,1405,1419,1434,1449,1461,1470,1473,1469,1456,1433,1399,1353,1296,1227,1147,1056,956,846,729,603,470,330,182
);
    -------------------------------------------------------------------------------
	-- More Constant Declarations (DDS: Phase increment values for tones in 10 octaves of piano)
	-------------------------------------------------------------------------------
	-------------------------------------------------------------------------------
	-- OCTAVE # Minus-2 (C-2 until B-2)
	constant CM2_DO		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858/64,N_CUM)); -- CM2_DO	tone ~(2^-6)*261.63Hz
    constant CM2S_DOS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028/64,N_CUM)); -- CM2S_DOS	tone ~(2^-6)*277.18Hz
    constant DM2_RE		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208/64,N_CUM)); -- DM2_RE	tone ~(2^-6)*293.66Hz
    constant DM2S_RES	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398/64,N_CUM)); -- DM2S_RES	tone ~(2^-6)*311.13Hz
    constant EM2_MI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600/64,N_CUM)); -- EM2_MI	tone ~(2^-6)*329.63Hz
    constant FM2_FA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815/64,N_CUM)); -- FM2_FA	tone ~(2^-6)*349.23Hz
    constant FM2S_FAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041/64,N_CUM)); -- FM2S_FAS	tone ~(2^-6)*369.99Hz
    constant GM2_SOL  	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282/64,N_CUM)); -- GM2_SOL  tone ~(2^-6)*392.00Hz
    constant GM2S_SOLS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4536/64,N_CUM)); -- GM2S_SOLS	tone ~(2^-6)*415.30Hz
    constant AM2_LA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4806/64,N_CUM)); -- AM2_LA	tone ~(2^-6)*440.00Hz
    constant AM2S_LAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5092/64,N_CUM)); -- AM2S_LAS	tone ~(2^-6)*466.16Hz
    constant BM2_SI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5394/64,N_CUM)); -- BM2_SI	tone ~(2^-6)*493.88Hz
	-------------------------------------------------------------------------------
	-- OCTAVE # Minus-1 (C-1 until B-1)
	constant CM1_DO		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858/32,N_CUM)); -- CM1_DO	tone ~(2^-5)*261.63Hz
    constant CM1S_DOS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028/32,N_CUM)); -- CM1S_DOS	tone ~(2^-5)*277.18Hz
    constant DM1_RE		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208/32,N_CUM)); -- DM1_RE	tone ~(2^-5)*293.66Hz
    constant DM1S_RES	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398/32,N_CUM)); -- DM1S_RES	tone ~(2^-5)*311.13Hz
    constant EM1_MI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600/32,N_CUM)); -- EM1_MI	tone ~(2^-5)*329.63Hz
    constant FM1_FA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815/32,N_CUM)); -- FM1_FA	tone ~(2^-5)*349.23Hz
    constant FM1S_FAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041/32,N_CUM)); -- FM1S_FAS	tone ~(2^-5)*369.99Hz
    constant GM1_SOL  	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282/32,N_CUM)); -- GM1_SOL  tone ~(2^-5)*392.00Hz
    constant GM1S_SOLS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4536/32,N_CUM)); -- GM1S_SOLS	tone ~(2^-5)*415.30Hz
    constant AM1_LA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4806/32,N_CUM)); -- AM1_LA	tone ~(2^-5)*440.00Hz
    constant AM1S_LAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5092/32,N_CUM)); -- AM1S_LAS	tone ~(2^-5)*466.16Hz
    constant BM1_SI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5394/32,N_CUM)); -- BM1_SI	tone ~(2^-5)*493.88Hz
	-------------------------------------------------------------------------------
    -- OCTAVE #0 (C0 until B0)
	constant C0_DO		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858/16,N_CUM)); -- C0_DO		tone ~(2^-4)*261.63Hz
    constant C0S_DOS	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028/16,N_CUM)); -- C0S_DOS	tone ~(2^-4)*277.18Hz
    constant D0_RE		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208/16,N_CUM)); -- D0_RE		tone ~(2^-4)*293.66Hz
    constant D0S_RES	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398/16,N_CUM)); -- D0S_RES	tone ~(2^-4)*311.13Hz
    constant E0_MI		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600/16,N_CUM)); -- E0_MI		tone ~(2^-4)*329.63Hz
    constant F0_FA		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815/16,N_CUM)); -- F0_FA		tone ~(2^-4)*349.23Hz
    constant F0S_FAS	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041/16,N_CUM)); -- F0S_FAS	tone ~(2^-4)*369.99Hz
    constant G0_SOL  	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282/16,N_CUM)); -- G0_SOL  	tone ~(2^-4)*392.00Hz
    constant G0S_SOLS	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4536/16,N_CUM)); -- G0S_SOLS	tone ~(2^-4)*415.30Hz
    constant A0_LA		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4806/16,N_CUM)); -- A0_LA		tone ~(2^-4)*440.00Hz
    constant A0S_LAS	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5092/16,N_CUM)); -- A0S_LAS	tone ~(2^-4)*466.16Hz
    constant B0_SI		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5394/16,N_CUM)); -- B0_SI		tone ~(2^-4)*493.88Hz
	-------------------------------------------------------------------------------
     -- OCTAVE #1 (C1 until B1)
	constant C1_DO		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858/8,N_CUM)); -- C1_DO		tone ~(2^-3)*261.63Hz
    constant C1S_DOS	:  	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028/8,N_CUM)); -- C1S_DOS	tone ~(2^-3)*277.18Hz
    constant D1_RE		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208/8,N_CUM)); -- D1_RE		tone ~(2^-3)*293.66Hz
    constant D1S_RES	:  	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398/8,N_CUM)); -- D1S_RES	tone ~(2^-3)*311.13Hz
    constant E1_MI		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600/8,N_CUM)); -- E1_MI		tone ~(2^-3)*329.63Hz
    constant F1_FA		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815/8,N_CUM)); -- F1_FA		tone ~(2^-3)*349.23Hz
    constant F1S_FAS	:  	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041/8,N_CUM)); -- F1S_FAS	tone ~(2^-3)*369.99Hz
    constant G1_SOL  	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282/8,N_CUM)); -- G1_SOL  	tone ~(2^-3)*392.00Hz
    constant G1S_SOLS	:  	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4536/8,N_CUM)); -- G1S_SOLS	tone ~(2^-3)*415.30Hz
    constant A1_LA		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4806/8,N_CUM)); -- A1_LA		tone ~(2^-3)*440.00Hz
    constant A1S_LAS	:  	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5092/8,N_CUM)); -- A1S_LAS	tone ~(2^-3)*466.16Hz
    constant B1_SI		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5394/8,N_CUM)); -- B1_SI		tone ~(2^-3)*493.88Hz
	-------------------------------------------------------------------------------
	-- OCTAVE #2 (C2 until B2)
	constant C2_DO		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858/4,N_CUM)); -- C2_DO		tone ~0,25*261.63Hz
    constant C2S_DOS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028/4,N_CUM)); -- C2S_DOS	tone ~0,25*277.18Hz
    constant D2_RE		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208/4,N_CUM)); -- D2_RE		tone ~0,25*293.66Hz
    constant D2S_RES	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398/4,N_CUM)); -- D2S_RES	tone ~0,25*311.13Hz
    constant E2_MI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600/4,N_CUM)); -- E2_MI		tone ~0,25*329.63Hz
    constant F2_FA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815/4,N_CUM)); -- F2_FA		tone ~0,25*349.23Hz
    constant F2S_FAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041/4,N_CUM)); -- F2S_FAS	tone ~0,25*369.99Hz
    constant G2_SOL  	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282/4,N_CUM)); -- G2_SOL  	tone ~0,25*392.00Hz
    constant G2S_SOLS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4536/4,N_CUM)); -- G2S_SOLS	tone ~0,25*415.30Hz
    constant A2_LA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4806/4,N_CUM)); -- A2_LA		tone ~0,25*440.00Hz
    constant A2S_LAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5092/4,N_CUM)); -- A2S_LAS	tone ~0,25*466.16Hz
    constant B2_SI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5394/4,N_CUM)); -- B2_SI		tone ~0,25*493.88Hz
	-------------------------------------------------------------------------------
	-- OCTAVE #3 (C3 until B3)
	constant C3_DO		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858/2,N_CUM)); -- C2_DO		tone ~0,5*261.63Hz
    constant C3S_DOS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028/2,N_CUM)); -- C2S_DOS	tone ~0,5*277.18Hz
    constant D3_RE		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208/2,N_CUM)); -- D2_RE		tone ~0,5*293.66Hz
    constant D3S_RES	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398/2,N_CUM)); -- D2S_RES	tone ~0,5*311.13Hz
    constant E3_MI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600/2,N_CUM)); -- E2_MI		tone ~0,5*329.63Hz
    constant F3_FA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815/2,N_CUM)); -- F2_FA		tone ~0,5*349.23Hz
    constant F3S_FAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041/2,N_CUM)); -- F2S_FAS	tone ~0,5*369.99Hz
    constant G3_SOL  	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282/2,N_CUM)); -- G2_SOL  	tone ~0,5*392.00Hz
    constant G3S_SOLS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4536/2,N_CUM)); -- G2S_SOLS	tone ~0,5*415.30Hz
    constant A3_LA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4806/2,N_CUM)); -- A2_LA		tone ~0,5*440.00Hz
    constant A3S_LAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5092/2,N_CUM)); -- A2S_LAS	tone ~0,5*466.16Hz
    constant B3_SI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5394/2,N_CUM)); -- B2_SI		tone ~0,5*493.88Hz
	-------------------------------------------------------------------------------
    -- OCTAVE #4 (C4 until B4)
	constant C4_DO		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858,N_CUM));   -- C4_DO		tone ~261.63Hz
    constant C4S_DOS	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028,N_CUM));   -- C4S_DOS	tone ~277.18Hz
    constant D4_RE		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208,N_CUM));   -- D4_RE		tone ~293.66Hz
    constant D4S_RES	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398,N_CUM));   -- D4S_RES	tone ~311.13Hz
    constant E4_MI		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600,N_CUM));   -- E4_MI		tone ~329.63Hz
    constant F4_FA		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815,N_CUM));   -- F4_FA		tone ~349.23Hz
    constant F4S_FAS	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041,N_CUM));   -- F4S_FAS	tone ~369.99Hz
    constant G4_SOL  	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282,N_CUM));   -- G4_SOL  	tone ~392.00Hz
    constant G4S_SOLS	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4536,N_CUM));   -- G4S_SOLS	tone ~415.30Hz
    constant A4_LA		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4806,N_CUM));   -- A4_LA		tone ~440.00Hz
    constant A4S_LAS	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5092,N_CUM));   -- A4S_LAS	tone ~466.16Hz
    constant B4_SI		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5394,N_CUM));   -- B4_SI		tone ~493.88Hz
	-------------------------------------------------------------------------------
     -- OCTAVE #5 (C5 until B5)
	constant C5_DO		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858*2,N_CUM)); -- C5_DO		tone ~2*261.63Hz
    constant C5S_DOS	:  	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028*2,N_CUM)); -- C5S_DOS	tone ~2*277.18Hz
    constant D5_RE		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208*2,N_CUM)); -- D5_RE		tone ~2*293.66Hz
    constant D5S_RES	:  	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398*2,N_CUM)); -- D5S_RES	tone ~2*311.13Hz
    constant E5_MI		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600*2,N_CUM)); -- E5_MI		tone ~2*329.63Hz
    constant F5_FA		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815*2,N_CUM)); -- F5_FA		tone ~2*349.23Hz
    constant F5S_FAS	:  	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041*2,N_CUM)); -- F5S_FAS	tone ~2*369.99Hz
    constant G5_SOL  	: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282*2,N_CUM)); -- G5_SOL  	tone ~2*392.00Hz
    constant G5S_SOLS	:  	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4536*2,N_CUM)); -- G5S_SOLS	tone ~2*415.30Hz
    constant A5_LA		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4806*2,N_CUM)); -- A5_LA		tone ~2*440.00Hz
    constant A5S_LAS	:  	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5092*2,N_CUM)); -- A5S_LAS	tone ~2*466.16Hz
    constant B5_SI		: 	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5394*2,N_CUM)); -- B5_SI		tone ~2*493.88Hz
	-------------------------------------------------------------------------------
	-- OCTAVE #6 (C6 until B6)
	constant C6_DO		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858*4,N_CUM)); -- C6_DO		tone ~4*261.63Hz
    constant C6S_DOS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028*4,N_CUM)); -- C6S_DOS	tone ~4*277.18Hz
    constant D6_RE		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208*4,N_CUM)); -- D6_RE		tone ~4*293.66Hz
    constant D6S_RES	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398*4,N_CUM)); -- D6S_RES	tone ~4*311.13Hz
    constant E6_MI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600*4,N_CUM)); -- E6_MI		tone ~4*329.63Hz
    constant F6_FA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815*4,N_CUM)); -- F6_FA		tone ~4*349.23Hz
    constant F6S_FAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041*4,N_CUM)); -- F6S_FAS	tone ~4*369.99Hz
    constant G6_SOL  	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282*4,N_CUM)); -- G6_SOL  	tone ~4*392.00Hz
    constant G6S_SOLS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4536*4,N_CUM)); -- G6S_SOLS	tone ~4*415.30Hz
    constant A6_LA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4806*4,N_CUM)); -- A6_LA		tone ~4*440.00Hz
    constant A6S_LAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5092*4,N_CUM)); -- A6S_LAS	tone ~4*466.16Hz
    constant B6_SI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5394*4,N_CUM)); -- B6_SI		tone ~4*493.88Hz
	-------------------------------------------------------------------------------
	-- OCTAVE #7 (C7 until B7)
	constant C7_DO		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858*8,N_CUM)); -- C7_DO		tone ~8*261.63Hz
    constant C7S_DOS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028*8,N_CUM)); -- C7S_DOS	tone ~8*277.18Hz
    constant D7_RE		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208*8,N_CUM)); -- D7_RE		tone ~8*293.66Hz
    constant D7S_RES	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398*8,N_CUM)); -- D7S_RES	tone ~8*311.13Hz
    constant E7_MI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600*8,N_CUM)); -- E7_MI		tone ~8*329.63Hz
    constant F7_FA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815*8,N_CUM)); -- F7_FA		tone ~8*349.23Hz
    constant F7S_FAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041*8,N_CUM)); -- F7S_FAS	tone ~8*369.99Hz
    constant G7_SOL  	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282*8,N_CUM)); -- G7_SOL  	tone ~8*392.00Hz
    constant G7S_SOLS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4536*8,N_CUM)); -- G7S_SOLS	tone ~8*415.30Hz
    constant A7_LA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4806*8,N_CUM)); -- A7_LA		tone ~8*440.00Hz
    constant A7S_LAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5092*8,N_CUM)); -- A7S_LAS	tone ~8*466.16Hz
    constant B7_SI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(5394*8,N_CUM)); -- B7_SI		tone ~8*493.88Hz
	-------------------------------------------------------------------------------
	-- OCTAVE #8 (C8 until G8)
	constant C8_DO		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(2858*16,N_CUM)); -- C8_DO		tone ~16*261.63Hz
    constant C8S_DOS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3028*16,N_CUM)); -- C8S_DOS	tone ~16*277.18Hz
    constant D8_RE		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3208*16,N_CUM)); -- D8_RE		tone ~16*293.66Hz
    constant D8S_RES	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3398*16,N_CUM)); -- D8S_RES	tone ~16*311.13Hz
    constant E8_MI		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3600*16,N_CUM)); -- E8_MI		tone ~16*329.63Hz
    constant F8_FA		:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(3815*16,N_CUM)); -- F8_FA		tone ~16*349.23Hz
    constant F8S_FAS	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4041*16,N_CUM)); -- F8S_FAS	tone ~16*369.99Hz
    constant G8_SOL  	:	std_logic_vector(N_CUM-1 downto 0):= std_logic_vector(to_unsigned(4282*16,N_CUM)); -- G8_SOL  	tone ~16*392.00Hz
    -- STOP MIDI RANGE ------------------------------------------------------------ 	


    -------------------------------------------------------------------------------
	-- TYPE AND LUT FOR MIDI NOTE_NUMBER (need to translate midi_cmd.number for dds.phi_incr)
	-------------------------------------------------------------------------------
	type t_lut_note_number is array (0 to 127) of std_logic_vector(N_CUM-1 downto 0);

	constant LUT_midi2dds : t_lut_note_number :=(
		0	 => CM2_DO		,  
		1	 => CM2S_DOS	,  
		2	 => DM2_RE		,  
		3	 => DM2S_RES	,  
		4	 => EM2_MI		,  
		5	 => FM2_FA		,  
		6	 => FM2S_FAS	,  
		7	 => GM2_SOL  	,  
		8	 => GM2S_SOLS	,  
		9    => AM2_LA		,  
		10	 => AM2S_LAS	,  
		11	 => BM2_SI		,  
		12	 => CM1_DO		,  
		13	 => CM1S_DOS	,  
		14	 => DM1_RE		,  
		15	 => DM1S_RES	,  
		16	 => EM1_MI		,  
		17	 => FM1_FA		,  
		18	 => FM1S_FAS	,  
		19   => GM1_SOL  	,  
		20	 => GM1S_SOLS	,  
		21	 => AM1_LA		,  
		22	 => AM1S_LAS	,  
		23	 => BM1_SI		,  
		24	 => C0_DO		,  
		25	 => C0S_DOS		,  
		26	 => D0_RE		,  
		27	 => D0S_RES		,  
		28	 => E0_MI		,  
		29   => F0_FA		,  
		30	 => F0S_FAS		,  
		31	 => G0_SOL  	,  
		32	 => G0S_SOLS	,  
		33	 => A0_LA		,  
		34	 => A0S_LAS		,  
		35	 => B0_SI		,  
		36	 => C1_DO		,  
		37	 => C1S_DOS		,  
		38	 => D1_RE		,  
		39   => D1S_RES		,  
		40	 => E1_MI		,  
		41	 => F1_FA		,  
		42	 => F1S_FAS		,  
		43	 => G1_SOL  	,  
		44	 => G1S_SOLS	,  
		45	 => A1_LA		,  
		46	 => A1S_LAS		,  
		47	 => B1_SI		,  
		48	 =>  C2_DO		,
		49   =>  C2S_DOS	,
		50	 =>  D2_RE		,
		51	 =>  D2S_RES	,
		52	 =>  E2_MI		,
		53	 =>  F2_FA		,
		54	 =>  F2S_FAS	,
		55	 =>  G2_SOL  	,
		56	 =>  G2S_SOLS	,
		57	 =>  A2_LA		,
		58	 =>  A2S_LAS	,
		59   =>  B2_SI		,
		60	 =>  C3_DO		, 
		61	 =>  C3S_DOS	, 
		62	 =>  D3_RE		, 
		63	 =>  D3S_RES	, 
		64	 =>  E3_MI		, 
		65	 =>  F3_FA		, 
		66	 =>  F3S_FAS	, 
		67	 =>  G3_SOL  	, 
		68	 =>  G3S_SOLS	, 
		69   =>  A3_LA		, 
		70	 =>  A3S_LAS	, 
		71	 =>  B3_SI		, 
		72	 =>  C4_DO		, 
		73	 =>  C4S_DOS	, 
		74	 =>  D4_RE		, 
		75	 =>  D4S_RES	, 
		76	 =>  E4_MI		, 
		77	 =>  F4_FA		, 
		78	 =>  F4S_FAS	, 
		79   =>  G4_SOL  	, 
		80	 =>  G4S_SOLS	, 
		81	 =>  A4_LA		, 
		82	 =>  A4S_LAS	, 
		83	 =>  B4_SI		, 
		84	 =>  C5_DO		, 
		85	 =>  C5S_DOS	, 
		86	 =>  D5_RE		, 
		87	 =>  D5S_RES	, 
		88	 =>  E5_MI		, 
		89   =>  F5_FA		, 
		90	 =>  F5S_FAS	, 
		91	 =>  G5_SOL  	, 
		92	 =>  G5S_SOLS	, 
		93	 =>  A5_LA		, 
		94	 =>  A5S_LAS	, 
		95	 =>  B5_SI		, 
		96	 =>  C6_DO		, 
		97	 =>  C6S_DOS	, 
		98	 =>  D6_RE		, 
		99   =>  D6S_RES	, 
		100	 =>  E6_MI		, 
		101	 =>  F6_FA		, 
		102	 =>  F6S_FAS	, 
		103	 =>  G6_SOL  	, 
		104	 =>  G6S_SOLS	, 
		105	 =>  A6_LA		, 
		106	 =>  A6S_LAS	, 
		107	 =>  B6_SI		, 
		108	 =>  C7_DO		, 
		109  =>  C7S_DOS	, 
		110	 =>  D7_RE		, 
		111	 =>  D7S_RES	, 
		112	 =>  E7_MI		, 
		113	 =>  F7_FA		, 
		114	 =>  F7S_FAS	, 
		115	 =>  G7_SOL  	, 
		116	 =>  G7S_SOLS	, 
		117	 =>  A7_LA		, 
		118	 =>  A7S_LAS	, 
		119  =>  B7_SI		, 
		120	 =>  C8_DO		, 
		121	 =>  C8S_DOS	, 
		122	 =>  D8_RE		, 
		123	 =>  D8S_RES	, 
		124	 =>  E8_MI		, 
		125	 =>  F8_FA		, 
		126	 =>  F8S_FAS	, 
		127	 =>  G8_SOL  	
		);
	
	-------------------------------------------------------------------------------		
end package;
