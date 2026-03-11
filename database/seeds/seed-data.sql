


SELECT pg_catalog.set_config('search_path', '', false);



ALTER TABLE public.addresses DISABLE TRIGGER ALL;

COPY public.addresses (id, street_address, city, state, postal_code, country, created_at, updated_at) FROM stdin;
2	810 E University Way	Ellensburg	WA	98926	USA	2026-02-07 04:33:31.621444	2026-02-07 04:33:31.621444
10	109 S Water St	Ellensburg	WA	98926	USA	2026-02-18 10:46:10.755404	2026-02-18 10:46:10.755404
11	1437 N Alder St	Ellensburg	WA	98926	USA	2026-02-18 10:49:13.654157	2026-02-18 10:49:13.654157
22	1320 E 18th Ave	Ellensburg	WA	98926	USA	2026-02-22 20:33:41.540969	2026-02-22 20:33:41.540969
23	1900 Brook Ln	Ellensburg	WA	98926	USA	2026-02-22 20:39:24.259763	2026-02-22 20:39:24.259763
24	2000 N Alder St	Ellensburg	WA	98926	USA	2026-02-22 20:43:22.814695	2026-02-22 20:43:22.814695
25	2102 N Walnut St	Ellensburg	WA	98926	USA	2026-02-22 20:49:03.053398	2026-02-22 20:49:03.053398
26	1402 N Cora st	Ellensburg	WA	98926	USA	2026-02-22 20:53:20.104346	2026-02-22 20:53:20.104346
27	Wildcat Way & 11th	Ellensburg	WA	98926	USA	2026-02-22 20:58:21.684671	2026-02-22 20:58:21.684671
38	1200 W 5th Ave	Ellensburg	WA	98926	USA	2026-02-28 18:45:04.687599	2026-02-28 18:45:04.687599
39	205 W 5th Ave	Ellensburg	WA	98926	USA	2026-02-28 18:47:45.325485	2026-02-28 18:47:45.325485
48	400 N Ruby St	Ellensburg	WA	98926	USA	2026-02-28 19:16:37.568628	2026-02-28 19:16:37.568628
49	603 S Chestnut St	Ellensburg	WA	98926	USA	2026-02-28 19:21:55.830927	2026-02-28 19:21:55.830927
50	1203 E Capitol Ave	Ellensburg	WA	98926	USA	2026-02-28 19:26:21.466388	2026-02-28 19:26:21.466388
51	700 E Mountain View Ave	Ellensburg	WA	98926	USA	2026-02-28 19:30:54.589833	2026-02-28 19:30:54.589833
52	400 E University Way	Ellensburg	WA	98926	USA	2026-02-28 19:34:32.709646	2026-02-28 19:34:32.709646
53	206 E 14th Ave	Ellensburg	WA	98926	USA	2026-02-28 19:37:50.0877	2026-02-28 19:37:50.0877
54	401 E 7th Ave	Ellensburg	WA	98926	USA	2026-02-28 19:42:35.908532	2026-02-28 19:42:35.908532
61	Brooklane Village- Southbound	Ellensburg	WA	98926	USA	2026-03-01 18:04:41.996446	2026-03-01 18:04:41.996471
62	1273-1317 N. Chestnut St.	Ellensburg	WA	98926	USA	2026-03-01 18:04:52.350779	2026-03-01 18:04:52.350813
63	1513 N Alder St	Ellensburg	WA	98926	USA	2026-03-01 18:05:02.711668	2026-03-01 18:05:02.711691
64	702 N. Ruby St.	Ellensburg	WA	98926	USA	2026-03-01 18:05:13.078055	2026-03-01 18:05:13.078102
65	1501 N Alder St	Ellensburg	WA	98926	USA	2026-03-01 18:05:23.42479	2026-03-01 18:05:23.424815
66	1601-1699 N Walnut St.	Ellensburg	WA	98926	USA	2026-03-01 18:05:33.7768	2026-03-01 18:05:33.776825
67	1202 N Chestnut St.	Ellensburg	WA	98926	USA	2026-03-01 18:05:53.097547	2026-03-01 18:05:53.097574
68	Beck Hall, 833-899 E 11th Ave	Ellensburg	WA	98926	USA	2026-03-01 18:06:03.457953	2026-03-01 18:06:03.457976
69	Davies Hall, 913 E 11th Ave	Ellensburg	WA	98926	USA	2026-03-01 18:06:13.815556	2026-03-01 18:06:13.815575
70	925 E 18th Avenue	Ellensburg	WA	98926	USA	2026-03-01 18:06:22.580578	2026-03-01 18:06:22.580596
71	2102 N Walnut St #151	Ellensburg	WA	98926	USA	2026-03-01 18:06:32.956792	2026-03-01 18:06:32.956811
72	212 W 5th Ave	Ellensburg	WA	98926	USA	2026-03-01 18:06:43.319046	2026-03-01 18:06:43.319068
73	807 E 11th Ave	Ellensburg	WA	98926	USA	2026-03-01 18:06:51.828483	2026-03-01 18:06:51.828502
74	Central Washington University	Ellensburg	WA	98926	USA	2026-03-01 18:07:02.219078	2026-03-01 18:07:02.219093
75	Meisner Hall, 911, 901 E 11th Ave	Ellensburg	WA	98926	USA	2026-03-01 18:07:12.584191	2026-03-01 18:07:12.584206
76	1300 N Walnut St	Ellensburg	WA	98926	USA	2026-03-01 18:07:22.942608	2026-03-01 18:07:22.942638
77	North Hall, 1104 N Walnut St	Ellensburg	WA	98926	USA	2026-03-01 18:07:33.467216	2026-03-01 18:07:33.467231
78	Sparks Hall, 998, 900 E 12th Ave	Ellensburg	WA	98926	USA	2026-03-01 18:07:43.923901	2026-03-01 18:07:43.923913
79	Sparks Hall, 900 East 12th Avenue	Ellensburg	WA	98926	USA	2026-03-01 18:07:54.276787	2026-03-01 18:07:54.276802
80	Stephens-Whitney Hall, 1236, 1200 N Walnut St	Ellensburg	WA	98926	USA	2026-03-01 18:08:04.748046	2026-03-01 18:08:04.748059
81	401 E Dean Nicholson Blvd	Ellensburg	WA	98926	USA	2026-03-01 21:09:56.562706	2026-03-01 21:09:56.562719
82	Sue Lombard Hall, 601 E University Way	Ellensburg	WA	98926	USA	2026-03-01 21:10:06.935004	2026-03-01 21:10:06.935018
83	905 E Dean Nicholson Blvd	Ellensburg	WA	98926	USA	2026-03-01 21:10:17.313824	2026-03-01 21:10:17.313839
84	1401 N Alder St	Ellensburg	WA	98926	USA	2026-03-01 21:10:27.67003	2026-03-01 21:10:27.670044
85	Wilson Hall, 709 E 11th Ave	Ellensburg	WA	98926	USA	2026-03-01 21:10:38.0512	2026-03-01 21:10:38.051219
86	1503 North Wildcat Way	Ellensburg	WA	98926	USA	2026-03-01 21:10:48.476569	2026-03-01 21:10:48.476583
87	1902 N Walnut Street	Ellensburg	WA	98926	USA	2026-03-01 21:10:58.844979	2026-03-01 21:10:58.84499
88	711 E 18th Ave Suite M2	Ellensburg	WA	98926	USA	2026-03-01 21:11:09.184581	2026-03-01 21:11:09.184593
90	1007 N Chestnut St	Ellensburg	WA	98926	USA	2026-03-02 18:28:38.57781	2026-03-02 18:28:38.57781
91	907 N Walnut St	Ellensburg	WA	98926	USA	2026-03-02 18:31:43.002534	2026-03-02 18:31:43.002534
92	906 E Dean Nicholson Blvd	Ellensburg	WA	98926	USA	2026-03-02 18:34:35.626439	2026-03-02 18:34:35.626439
93	1611 N Alder St	Ellensburg	WA	98926	USA	2026-03-02 18:36:34.368675	2026-03-02 18:36:34.368675
94	400 E University Way	Ellensburg	WA	98926	USA	2026-03-02 18:38:58.483011	2026-03-02 18:38:58.483011
95	401 E University Way	Ellensburg	WA	98926	USA	2026-03-02 18:41:33.162075	2026-03-02 18:41:33.162075
\.


ALTER TABLE public.addresses ENABLE TRIGGER ALL;


ALTER TABLE public.destinations DISABLE TRIGGER ALL;

COPY public.destinations (id, name, type, description, latitude, longitude, address_id, created_at, updated_at) FROM stdin;
2	University & 9th	bus_stop	Bus stop at University and 9th	47.00067	-120.53588	2	2026-02-07 04:33:31.621444	2026-02-07 04:33:31.621444
10	Water & Capitol	bus_stop	Bus stop at Water and Capitol	46.99148	-120.54973	10	2026-02-18 10:47:23.148111	2026-02-18 10:47:23.148111
11	Alder & 14th	bus_stop	Bus stop at Alder and 14th	47.00671	-120.53209	11	2026-02-18 10:51:40.875408	2026-02-18 10:51:40.875408
47	Ruby & 4th	bus_stop	Bus stop at Safeway	46.99583	-120.5445	48	2026-02-28 19:19:01.400853	2026-02-28 19:19:01.400853
48	Chestnut & Seattle	bus_stop	Bus stop at KVH Hospital	46.98742	-120.53687	49	2026-02-28 19:23:11.122603	2026-02-28 19:23:11.122603
22	18th & Brooklane	bus_stop	Bus stop at 18th and Brooklane	47.0105	-120.52591	22	2026-02-22 20:35:27.383352	2026-02-22 20:35:27.383352
23	Brooklane Village	bus_stop	Bus stop servicing Brooklane Village apartments 	47.01221	-120.52289	23	2026-02-22 20:41:18.24789	2026-02-22 20:41:18.24789
24	Alder & Helena	bus_stop	Bus stop at Alder and Helena	47.01351	-120.53171	24	2026-02-22 20:44:45.75207	2026-02-22 20:44:45.75207
25	Walnut & Helena	bus_stop	Bus stop at Walnut and Helena	47.0137	-120.53966	25	2026-02-22 20:51:32.095108	2026-02-22 20:51:32.095108
26	Cora & W. Rainier	bus_stop	Bus stop at Cora and West Rainier	47.00577	-120.55793	26	2026-02-22 20:55:04.81739	2026-02-22 20:55:04.81739
27	Wildcat Way & 11th	bus_stop	Bus stop at Wildcat Way and 11th	47.0035	-120.54316	27	2026-02-22 21:00:16.276325	2026-02-22 21:00:16.276325
37	Rotarty Park Roundabout	bus_stop	Bus stop at Rotary Park	46.99596	-120.56203	38	2026-02-28 18:46:34.118495	2026-02-28 18:46:34.118495
38	5th & Water	bus_stop	Bus stop at 5th and Water	46.99656	-120.54978	39	2026-02-28 18:48:54.96291	2026-02-28 18:48:54.96291
49	Capitol & Willow	bus_stop	Bus stop at Capitol and Willow	46.9919	-120.52753	50	2026-02-28 19:27:29.660341	2026-02-28 19:27:29.660341
50	Mtn View & Whitman	bus_stop	Bus stop at Bi-Mart and Grand Meridian Cinema	46.98448	-120.53962	51	2026-02-28 19:32:27.18853	2026-02-28 19:32:27.18853
51	11th & Maple	bus_stop	Bus stop at the SURC	47.00297	-120.53484	52	2026-02-28 19:35:47.423486	2026-02-28 19:35:47.423486
52	14th & Wildcat Way	bus_stop	Bus stop at 14th and Wildcat Way	47.00599	-120.54426	53	2026-02-28 19:39:10.179784	2026-02-28 19:39:10.179784
53	Sprague & 7th	bus_stop	Bus stop at Sprague and 7th	46.99889	-120.54323	54	2026-02-28 19:44:59.373785	2026-02-28 19:44:59.373785
60	Brooklane Village Apartments	property	Anderson Brooklane Village is comprised of 13 separate courts with 5 apartment unit clusters in each court and is located a short 15-minute walk Northeast of campus. Residents enjoy a small community atmosphere, close proximity to the Early Childhood Learning Center and are able to reserve the multi-purpose building located in the center of the courts for activities. There is plenty of outdoor space, attached deck, storage units and a basketball court. Brooklane offers unfurnished 1, 2 and 3 bedroom options with many units featuring a 2-story layout. Units are rented on a 12-month contract with rent for 2 and 3-bedroom units split between tenants. Parking is included at no additional fee. Central Transit helps Brooklane residents stay connected to the main campus and Ellensburg community with 2 separate bus stops offering routes departing every 30 minutes.	47.01234	-120.52289	61	2026-03-01 18:04:41.998609	2026-03-01 18:04:41.998632
61	Anderson Apartments	property	Anderson is unique as it is rented by the room for the academic year. This is an attractive option for students who prefer apartment living for the academic school year but do not wish to remain on campus over the Summer. Renting by the room ensures that if a roommate leaves mid-year, the rent charge remains the same while a new roommate is chosen or Housing assigns one to the space. The closest parking lot to Anderson requires a purchased CWU parking permit. that make Anderson Apartments a great place to live: Convenient location in Central Campus just north of the Student Union and Recreation Center, Furnished with bed, desk, chair and dresser/wardrobe, Kitchen, Laundry facilities in central location, Paid parking options available nearby, Refrigerator, Stove Range/Oven, Utilities included, Wireless internet in unit, 24/7 on-call staff.	47.00515	-120.53348	62	2026-03-01 18:04:52.35235	2026-03-01 18:04:52.352401
62	Carmody-Munro Apartments	property	Carmody-Munro Apartments are located on North campus in Carmody-Munro Hall. These microstudio apartments are furnished and are all single rooms. Furnishings include a 2 beds, desk, chair, 2 wardrobes, and microfridge. All units are the size of a standard double room in the residence halls (including furniture), but will only have one resident per room. Residents will have access to a community kitchen, laundry room, study areas, and lounges. All rooms have access to community restrooms. This economical option will be priced at around $495 per month, includes all utilities, and does not require a meal plan. Furnished microstudio units, all singles (double room sold as a single) 9-month (academic year) contract, rented by the bedroom. Closest parking option (Lot S20) requires a CWU parking permit.	47.00826	-120.53422	63	2026-03-01 18:05:02.713097	2026-03-01 18:05:02.71312
63	Getz Short Apartments	property	Getz Short apartments are in the Southwest corner of campus and offer unfurnished 1- and 2-bedroom units with options for both a parking lot and on-street parking. Getz Short residents are walking distance from downtown Ellensburg and enjoy close proximity to Shaw-Smyser Hall and convenient grocery shopping. Offering unfurnished 1- and 2-bedroom units Getz Short is rented on a 12-month contract, and rent in 2-bedroom units is split between tenants. Parking is included at no additional fee.	47.00515	-120.53348	64	2026-03-01 18:05:13.079902	2026-03-01 18:05:13.079924
64	Student Village Apartments	property	Student Village Apartments are located on the North side of CWU’s campus and close to Nicholson Pavilion, tennis courts, athletic fields and the North Village Café. These partially furnished studio, one-, two- and three-bedroom units feature a shared living area, kitchen and bathroom. Student Village is unique as it is rented by the room. Renting by the room ensures that if a roommate leaves mid-year, the rent charge remains the same while a new roommate is chosen or Housing assigns one to the space. Studio, 1-, 2-, and 3-bedroom options 12-month contract, rented by the bedroom. Parking is included in the Student Village residential lots.	47.00874	-120.53312	65	2026-03-01 18:05:23.426202	2026-03-01 18:05:23.426223
65	Wahle Apartments	property	Wahle Apartments are conveniently located in the Northwest corner of the CWU campus between the Recreation Sports Complex, Tomlinson Stadium and the Pool/Aquatic Facility. Wahle residents enjoy close proximity to the Brooks Library, Psychology building, Purser Hall, Nicholson Pavilion and the Northside Commons Dining featuring Panda Express. Wahle offers duplex-style living with fully furnished 2-bedroom units that include air conditioning and parking adjacent to each unit. Renting by the room ensures that if a roommate leaves mid-year, the rent charge remains the same while a new roommate is chosen or Housing assigns one to the space. 2-bedroom units 12-month contract, rented by the bedroom. Parking is available adjacent to each unit at no charge.	47.00818	-120.53594	66	2026-03-01 18:05:33.77817	2026-03-01 18:05:33.778192
66	Barto Residence Hall	property	Located in central campus near the Student Union and Recreation Center, Barto offers an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, volleyball nets, and large lawn areas for fun activities or relaxation. Barto is home to the William O. Douglas Honors Living Learning Community.	47.00494	-120.53595	67	2026-03-01 18:05:53.098998	2026-03-01 18:05:53.099021
67	Beck Residence Hall	property	Beck Hall is one of our six traditional residence halls that make up the Bassetties complex which houses first year students. Nearby, students can find lighted outdoor handball, half-court basketball courts, and large lawn areas for fun activities or relaxation.	47.00402	-120.53654	68	2026-03-01 18:06:03.459968	2026-03-01 18:06:03.459992
68	Davies Residence Hall	property	Davies Hall is one of our six traditional residence halls that make up the Bassetties Complex. This hall is for sophomore students and above and offers all single rooms. Located in central campus near the Student Union and Recreation Center, Davies is an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, and large lawn areas for fun activities or relaxation.	47.0038	-120.53438	69	2026-03-01 18:06:13.816883	2026-03-01 18:06:13.8169
69	Campus Village	property	Pet friendly. Free parking. 24-hour emergency maintenance. Laundry facilities. Accepts electronic payments. Apartment amenities include dishwasher, balconies and patios, linen closets, cable ready, upgraded kitchen. Maximum of two pets per unit; $300 deposit, $300 pet fee, $20 monthly rent per pet.	47.0113	-120.53385	70	2026-03-01 18:06:22.581952	2026-03-01 18:06:22.581968
70	University Court Apartments	property	Open floor plan. Dishwasher in unit. Full-size refrigerator. Two closets in bedroom. Abundant storage space. Fully manicured grounds. On-site management team. Clubhouse with billiard table. Fully equipped laundry facility. Free tenant and guest parking. North of CWU campus. Walking distance to deli. On central transit route.	47.01369	-120.53849	71	2026-03-01 18:06:32.958171	2026-03-01 18:06:32.958189
71	Patricia Place Properties	property	Our buildings offer everything you can expect from upscale downtown living, walking distance to a variety of restaurants, shops, breweries, and wine tasting rooms. Close to grocery stores, live entertainment venues, and downtown parks.	46.99673	-120.54978	72	2026-03-01 18:06:43.320592	2026-03-01 18:06:43.320611
72	Hitchcock Residence Hall	property	Located in central campus near the Student Union and Recreation Center, Hitchcock offers an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, and large lawn areas for fun activities or relaxation.	47.0036	-120.53576	73	2026-03-01 18:06:51.831125	2026-03-01 18:06:51.831148
73	Kamola Residence Hall	property	Located on the south end of campus on University Way, Kamola is next to many of our academic buildings which offers an easy commute to classes and all the actives in the SURC. Kamola offers many unique room types, and large lounge areas make it easy to connect with other residents in the hall. Kamola was the first residence hall built and has since been renovated.	47.00051	-120.54055	74	2026-03-01 18:07:02.220495	2026-03-01 18:07:02.22051
74	Meisner Residence Hall	property	This hall houses first year students and offers single and double rooms. Located in central campus near the Student Union and Recreation Center, Meisner offers an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, and large lawn areas for fun activities or relaxation.	47.00365	-120.53527	75	2026-03-01 18:07:12.585488	2026-03-01 18:07:12.585502
93	Milo Smith Tower Theatre	cwu	The Theatre Arts Department and Central Theatre Ensemble are housed in the stately McConnell Hall, which underwent a $2.1 million renovation completed in the fall of 2003. Fueled primarily by health and safety concerns, the renovation improved and reorganized existing spaces to provide a more user-friendly and, most importantly, safe working environment.\n\nBecause theatre is a collaborative, fluid and multi-faceted art form, majors in this department spend limited time in traditional classrooms. Your education begins in the shops and studios and culminates in fully stage productions.	47.00033	-120.54215	95	2026-03-02 18:42:44.753038	2026-03-02 18:42:44.753038
75	Moore Residence Rall	property	Suites in Moore include three single bedrooms that share a bathroom. Located in central campus near the Student Union and Recreation Center, Moore offers an easy commute to many academic building, all the actives in the SURC and the main dining center on campus. Nearby, students can find a covered patio and lawn area for fun actives or relaxation. For the 2026-2027 Academic Year, Moore Hall will offer both gender-inclusive and gendered suites. Stack 'A' (room numbers that start with A) will be gendered, meaning that only a single gender (male or female) can select rooms within a suite. Stacks 'B' and 'C' will be gender-inclusive, meaning that anyone, regardless of gender identity, can select a room within a suite.	47.00522	-120.53808	76	2026-03-01 18:07:22.943948	2026-03-01 18:07:22.943959
76	North Residence Hall	property	Located in central campus near the Student Union and Recreation Center, North offers an easy commute to many academic building, all the actives in the SURC and the main dining center on campus. Nearby, students can find a large lawn area for fun actives or relaxation.	47.00368	-120.53913	77	2026-03-01 18:07:33.468333	2026-03-01 18:07:33.468343
77	Quigley Residence Hall	property	Located in central campus near the Student Union and Recreation Center, Quigley offers an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, and large lawn areas for fun activities or relaxation.	47.00434	-120.53561	78	2026-03-01 18:07:43.924946	2026-03-01 18:07:43.924955
78	Sparks Residence Hall	property	This hall offers single and double rooms and houses first year students. Located in central campus near the Student Union and Recreation Center, Sparks offers an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, and large lawn areas for fun activities or relaxation.	47.00417	-120.53588	79	2026-03-01 18:07:54.278194	2026-03-01 18:07:54.278207
79	Stephens-Whitney Residence Hall	property	Each suite contains two single rooms, a shared bathroom, and a living room area. Located in central campus near the Student Union and Recreation Center, Stephens-Whitney offers an easy commute to many academic buildings, all the actives in the SURC and the main dining center on campus. Nearby, students can find a patio and large lawn area next to the SURC for fun activities or relaxation.	47.0045	-120.5387	80	2026-03-01 18:08:04.749091	2026-03-01 18:08:04.749102
80	Dugmore Residence Hall	property	Dugmore is equipped with both communal and suite style bathrooms, study rooms, laundry rooms on each floor, and a communal kitchen on the first floor. Dugmore is located at the North East end of campus close to the library and Northside Commons.	47.00665	-120.54225	81	2026-03-01 21:09:56.564703	2026-03-01 21:09:56.564716
81	Sue Lombard Residence Hall	property	Located on the south end of campus on University Way and next to many of our academic buildings, Sue Lombard offers an easy commute to classes and all the actives in the SURC. Sue Lombard is a small community which makes it easy for residents to get to know their neighbors. This hall is also home to the Business Living Learning Community.	47.00058	-120.54001	82	2026-03-01 21:10:06.936462	2026-03-01 21:10:06.936475
82	Wendell Hill Hall A Residence Hall	property	Wendell Hill Hall A is one of our two Wendell Hill residence halls with a modern set up and feel for our sophomore and up students. Nearby, students can find many outdoor recreation opportunities such as the tennis courts, basketball courts and field house. There is also a full-service coffee shop on the ground floor of Wendell B. Wendell Hill Hall A is home to the Music Living Learning Community, which is open to all music majors regardless of year.	47.00682	-120.53416	83	2026-03-01 21:10:17.31549	2026-03-01 21:10:17.315504
83	Wendell Hill Hall B Residence Hall	property	Located in the northern area of campus near the athletic center and many academic buildings, students can find many outdoor recreation opportunities such as the tennis courts, basketball courts and field house. There is also a full-service coffee shop on the ground floor. Wendell B is home to the Aviation and Sustainability Living Learning Communities. Students can live in an LLC, regardless of year.	47.0067	-120.53318	84	2026-03-01 21:10:27.672436	2026-03-01 21:10:27.672449
84	Wilson Residence Hall	property	Wilson houses first year students and provides residents easy access to the Wildcat Shop, Recreation Center, and Dining Services. Wilson offers amenities such as two lounges, two laundry rooms, two kitchens, and a small lobby upstairs for social events or studying.	47.00355	-120.5385	85	2026-03-01 21:10:38.052898	2026-03-01 21:10:38.052913
85	Glen Manor Apartments	property	One year lease required. First and last month’s rent plus $900 damage deposit required before move-in. Units start at $900 per month for single occupancy. Pet policy: maximum two animals per unit, cats only. $20 monthly pet rent per pet. $200 deposit and $200 non-refundable animal fee required with prior management approval. Aquariums allowed up to 20 gallons on first floor only. Pets must comply with City of Ellensburg Animal Control Ordinance Chapter 5.30.	47.00757	-120.54375	86	2026-03-01 21:10:48.478827	2026-03-01 21:10:48.478889
86	Baker Apartments	property	Pet friendly. Accepts electronic payments. Laundry facilities. 24-hour emergency maintenance. Apartment amenities include dishwasher. Pets allowed with restrictions: no more than two animals per unit, cats and dogs max 40 lbs, aggressive breeds not allowed. $300 deposit and $300 non-refundable animal fee required, prior management approval required. Aquariums allowed up to 20 gallons on first floor only with proof of insurance.	47.01172	-120.5373	87	2026-03-01 21:10:58.846279	2026-03-01 21:10:58.846288
87	Greenpointe Townhomes	property	On-site maintenance. Close to parks. Walking distance to Central Washington University. Off-street parking. 24-hour on-call maintenance. Pet friendly. Apartment amenities include dishwasher, washer, dryer, refrigerator, new renovated designer interiors, ceiling fans in bedrooms, new hard surface flooring, new carpets and paint, new hardware and fixtures, RUB, and fenced private yard.	47.01124	-120.53649	88	2026-03-01 21:11:09.185907	2026-03-01 21:11:09.185916
88	SURC	cwu	The Student Union and Recreation Center is the largest building on the Central Washington University campus: 228,261 square feet in three stories, centrally located with easy access to parking lots and malls, primary city streets, academic buildings and residence halls.	47.00299	-120.53781	90	2026-03-02 18:31:03.493542	2026-03-02 18:31:03.493542
89	Samuelson Hall	cwu	Samuelson Hall is a prominent building located at Central Washington University in Ellensburg WA. Known for its modern architecture it serves as an important academic facility for students offering various classrooms and study spaces. The hall is named after a notable figure in the university's history reflecting the institution's commitment to providing quality education and fostering a vibrant learning environment.	47.00121	-120.54019	91	2026-03-02 18:33:38.321861	2026-03-02 18:33:38.321861
92	James E. Brooks Library	cwu	At Central Washington University, we care about education and our community. We want to make sure our patrons have access to the resources that will make their time here meaningful. We believe that libraries are for everyone. From offering academic resources to creating spaces of engagement, our team looks forward to welcoming you to the Wildcat family. The James E. Brooks Library is located in the northwest corner of the Ellensburg campus. Built in 1973, the third library in the University’s history, the James E. Brooks Library, along with the branch library located in Lynnwood, supports students and faculty in their academic and research endeavors.	47.0051	-120.54138	94	2026-03-02 18:40:18.548291	2026-03-02 18:40:18.548291
91	The Village Coffee, Market, & Grill	cwu	Available through mobile order with Grubhub or through the Grubhub ordering kiosk, The Village Grill has all your comfort favorites, from stuffed crust pizza, to burgers and fries.\n\nThe Village Coffee has plenty of seating and the longest hours of any café on campus, serving delicious Caffe Vita espresso until midnight. It's the perfect spot to study, or grab a bite from the grill or pick up full sized groceries from the market.\n\nThe Village Market is more than a convenience store. Visitors can pick up full-size groceries, produce, eggs, and household necessities like paper towels, toilet paper, and laundry detergent.\n\nThe Village Coffee, Market, Grill is located in Green Hall on north campus, near Student Village	47.00864	-120.53395	93	2026-03-02 18:37:30.062416	2026-03-02 18:37:30.062416
90	Jerilyn S. McIntyre Music Building	cwu	Central Washington University's Jerilyn S. McIntyre Music Building must be experienced to be fully appreciated. Both the visual and acoustical qualities of our building have elevated the standards for educational facilities across the country. Our premiere 600-seat concert hall provides an unparalleled environment for musical performances. Having been designed with a "no compromise" approach, every seat in the house provides incredible sonic detail. With adjustable curtains, reflection time can be altered depending on the desired acoustic effect.	47.00563	-120.53451	92	2026-03-02 18:35:43.449474	2026-03-02 18:35:43.449474
\.


ALTER TABLE public.destinations ENABLE TRIGGER ALL;


ALTER TABLE public.properties DISABLE TRIGGER ALL;

COPY public.properties (id, name, property_type, description, contact_phone, contact_email, destination_id, created_at, updated_at, bus_stop_distance, bus_stop_mins, cwu_distance, cwu_mins) FROM stdin;
48	Hitchcock Residence Hall	dorm	Located in central campus near the Student Union and Recreation Center, Hitchcock offers an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, and large lawn areas for fun activities or relaxation.	(509) 963-1347		72	2026-03-01 18:06:51.834763	2026-03-02 19:34:49.880825	0.08	1	0.13	3
50	Meisner Residence Hall	dorm	This hall houses first year students and offers single and double rooms. Located in central campus near the Student Union and Recreation Center, Meisner offers an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, and large lawn areas for fun activities or relaxation.	(509) 963-1347		74	2026-03-01 18:07:12.586758	2026-03-02 19:34:48.441282	0.12	2	0.16	3
52	North Residence Hall	dorm	Located in central campus near the Student Union and Recreation Center, North offers an easy commute to many academic building, all the actives in the SURC and the main dining center on campus. Nearby, students can find a large lawn area for fun actives or relaxation.	(509) 963-1327		76	2026-03-01 18:07:33.469531	2026-03-02 19:34:48.71613	0.28	5	0.13	3
53	Quigley Residence Hall	dorm	Located in central campus near the Student Union and Recreation Center, Quigley offers an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, and large lawn areas for fun activities or relaxation.	(509) 963-1346		77	2026-03-01 18:07:43.926066	2026-03-02 19:34:48.835325	0.15	3	0.13	2
54	Sparks Residence Hall	dorm	This hall offers single and double rooms and houses first year students. Located in central campus near the Student Union and Recreation Center, Sparks offers an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, and large lawn areas for fun activities or relaxation.	(509) 963-1346		78	2026-03-01 18:07:54.279694	2026-03-02 19:34:48.960845	0.13	3	0.15	3
55	Stephens-Whitney Residence Hall	dorm	Each suite contains two single rooms, a shared bathroom, and a living room area. Located in central campus near the Student Union and Recreation Center, Stephens-Whitney offers an easy commute to many academic buildings, all the actives in the SURC and the main dining center on campus. Nearby, students can find a patio and large lawn area next to the SURC for fun activities or relaxation.	(509) 963-1327		79	2026-03-01 18:08:04.75019	2026-03-02 19:34:49.079309	0.26	5	0.13	3
56	Dugmore Residence Hall	dorm	Dugmore is equipped with both communal and suite style bathrooms, study rooms, laundry rooms on each floor, and a communal kitchen on the first floor. Dugmore is located at the North East end of campus close to the library and Northside Commons.	5099632484		80	2026-03-01 21:09:56.567301	2026-03-02 19:34:49.207997	0.19	4	0.16	3
57	Sue Lombard Residence Hall	dorm	Located on the south end of campus on University Way and next to many of our academic buildings, Sue Lombard offers an easy commute to classes and all the actives in the SURC. Sue Lombard is a small community which makes it easy for residents to get to know their neighbors. This hall is also home to the Business Living Learning Community.	5099631344		81	2026-03-01 21:10:06.938191	2026-03-02 19:34:49.314112	0.28	5	0.01	0
58	Wendell Hill Hall A Residence Hall	dorm	Wendell Hill Hall A is one of our two Wendell Hill residence halls with a modern set up and feel for our sophomore and up students. Nearby, students can find many outdoor recreation opportunities such as the tennis courts, basketball courts and field house. There is also a full-service coffee shop on the ground floor of Wendell B. Wendell Hill Hall A is home to the Music Living Learning Community, which is open to all music majors regardless of year.	5099631342		82	2026-03-01 21:10:17.317413	2026-03-02 19:34:49.421446	0.24	5	0.20	4
59	Wendell Hill Hall B Residence Hall	dorm	Located in the northern area of campus near the athletic center and many academic buildings, students can find many outdoor recreation opportunities such as the tennis courts, basketball courts and field house. There is also a full-service coffee shop on the ground floor. Wendell B is home to the Aviation and Sustainability Living Learning Communities. Students can live in an LLC, regardless of year.	5099631342		83	2026-03-01 21:10:27.67421	2026-03-02 19:34:49.537196	0.20	4	0.23	4
60	Wilson Residence Hall	dorm	Wilson houses first year students and provides residents easy access to the Wildcat Shop, Recreation Center, and Dining Services. Wilson offers amenities such as two lounges, two laundry rooms, two kitchens, and a small lobby upstairs for social events or studying.	5099631327		84	2026-03-01 21:10:38.054967	2026-03-02 19:34:49.640951	0.25	5	0.11	2
61	Glen Manor Apartments	apartment	One year lease required. First and last month’s rent plus $900 damage deposit required before move-in. Units start at $900 per month for single occupancy. Pet policy: maximum two animals per unit, cats only. $20 monthly pet rent per pet. $200 deposit and $200 non-refundable animal fee required with prior management approval. Aquariums allowed up to 20 gallons on first floor only. Pets must comply with City of Ellensburg Animal Control Ordinance Chapter 5.30.	5098990120	Rolf@Jerrols.com	85	2026-03-01 21:10:48.481516	2026-03-02 19:34:49.74469	0.15	3	0.27	5
62	Baker Apartments	apartment	Pet friendly. Accepts electronic payments. Laundry facilities. 24-hour emergency maintenance. Apartment amenities include dishwasher. Pets allowed with restrictions: no more than two animals per unit, cats and dogs max 40 lbs, aggressive breeds not allowed. $300 deposit and $300 non-refundable animal fee required, prior management approval required. Aquariums allowed up to 20 gallons on first floor only with proof of insurance.	5099257634	\N	86	2026-03-01 21:10:58.847675	2026-03-02 19:34:49.851185	0.30	6	0.55	11
37	Anderson Apartments	apartment	Anderson is unique as it is rented by the room for the academic year. This is an attractive option for students who prefer apartment living for the academic school year but do not wish to remain on campus over the Summer. Renting by the room ensures that if a roommate leaves mid-year, the rent charge remains the same while a new roommate is chosen or Housing assigns one to the space. The closest parking lot to Anderson requires a purchased CWU parking permit. that make Anderson Apartments a great place to live: Convenient location in Central Campus just north of the Student Union and Recreation Center, Furnished with bed, desk, chair and dresser/wardrobe, Kitchen, Laundry facilities in central location, Paid parking options available nearby, Refrigerator, Stove Range/Oven, Utilities included, Wireless internet in unit, 24/7 on-call staff.	5099637111		61	2026-03-01 18:04:52.354381	2026-03-02 19:34:50.181969	0.30	6	0.12	2
38	Carmody-Munro Apartments	apartment	Carmody-Munro Apartments are located on North campus in Carmody-Munro Hall. These microstudio apartments are furnished and are all single rooms. Furnishings include a 2 beds, desk, chair, 2 wardrobes, and microfridge. All units are the size of a standard double room in the residence halls (including furniture), but will only have one resident per room. Residents will have access to a community kitchen, laundry room, study areas, and lounges. All rooms have access to community restrooms. This economical option will be priced at around $495 per month, includes all utilities, and does not require a meal plan. Furnished microstudio units, all singles (double room sold as a single) 9-month (academic year) contract, rented by the bedroom. Closest parking option (Lot S20) requires a CWU parking permit.	5099637111		62	2026-03-01 18:05:02.71583	2026-03-02 19:34:50.306141	0.29	6	0.09	2
39	Getz Short Apartments	apartment	Getz Short apartments are in the Southwest corner of campus and offer unfurnished 1- and 2-bedroom units with options for both a parking lot and on-street parking. Getz Short residents are walking distance from downtown Ellensburg and enjoy close proximity to Shaw-Smyser Hall and convenient grocery shopping. Offering unfurnished 1- and 2-bedroom units Getz Short is rented on a 12-month contract, and rent in 2-bedroom units is split between tenants. Parking is included at no additional fee.	5099631831		63	2026-03-01 18:05:13.08167	2026-03-02 19:34:50.408279	0.30	6	0.12	2
40	Student Village Apartments	apartment	Student Village Apartments are located on the North side of CWU’s campus and close to Nicholson Pavilion, tennis courts, athletic fields and the North Village Café. These partially furnished studio, one-, two- and three-bedroom units feature a shared living area, kitchen and bathroom. Student Village is unique as it is rented by the room. Renting by the room ensures that if a roommate leaves mid-year, the rent charge remains the same while a new roommate is chosen or Housing assigns one to the space. Studio, 1-, 2-, and 3-bedroom options 12-month contract, rented by the bedroom. Parking is included in the Student Village residential lots.	5099638663		64	2026-03-01 18:05:23.427737	2026-03-02 19:34:50.52179	0.19	4	0.04	1
41	Wahle Apartments	apartment	Wahle Apartments are conveniently located in the Northwest corner of the CWU campus between the Recreation Sports Complex, Tomlinson Stadium and the Pool/Aquatic Facility. Wahle residents enjoy close proximity to the Brooks Library, Psychology building, Purser Hall, Nicholson Pavilion and the Northside Commons Dining featuring Panda Express. Wahle offers duplex-style living with fully furnished 2-bedroom units that include air conditioning and parking adjacent to each unit. Renting by the room ensures that if a roommate leaves mid-year, the rent charge remains the same while a new roommate is chosen or Housing assigns one to the space. 2-bedroom units 12-month contract, rented by the bedroom. Parking is available adjacent to each unit at no charge.	5099631831		65	2026-03-01 18:05:33.779586	2026-03-02 19:34:50.644772	0.27	5	0.12	2
42	Barto Residence Hall	dorm	Located in central campus near the Student Union and Recreation Center, Barto offers an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, volleyball nets, and large lawn areas for fun activities or relaxation. Barto is home to the William O. Douglas Honors Living Learning Community.	5099631323		66	2026-03-01 18:05:53.100469	2026-03-02 19:34:50.750291	0.24	5	0.14	3
43	Beck Residence Hall	dorm	Beck Hall is one of our six traditional residence halls that make up the Bassetties complex which houses first year students. Nearby, students can find lighted outdoor handball, half-court basketball courts, and large lawn areas for fun activities or relaxation.	5099631347		67	2026-03-01 18:06:03.462241	2026-03-02 19:34:50.849876	0.13	3	0.12	2
44	Davies Residence Hall	dorm	Davies Hall is one of our six traditional residence halls that make up the Bassetties Complex. This hall is for sophomore students and above and offers all single rooms. Located in central campus near the Student Union and Recreation Center, Davies is an easy commute to classes, all the activities in the SURC and the main dining center on campus. Nearby, students can find lighted outdoor handball courts, half-court basketball courts, and large lawn areas for fun activities or relaxation.	5099631346		68	2026-03-01 18:06:13.818311	2026-03-02 19:34:50.94417	0.17	3	0.19	4
45	Campus Village	apartment	Pet friendly. Free parking. 24-hour emergency maintenance. Laundry facilities. Accepts electronic payments. Apartment amenities include dishwasher, balconies and patios, linen closets, cable ready, upgraded kitchen. Maximum of two pets per unit; $300 deposit, $300 pet fee, $20 monthly rent per pet.	5099685055	\N	69	2026-03-01 18:06:22.583431	2026-03-02 19:34:51.054093	0.37	7	0.36	7
46	University Court Apartments	apartment	Open floor plan. Dishwasher in unit. Full-size refrigerator. Two closets in bedroom. Abundant storage space. Fully manicured grounds. On-site management team. Clubhouse with billiard table. Fully equipped laundry facility. Free tenant and guest parking. North of CWU campus. Walking distance to deli. On central transit route.	5099629090	\N	70	2026-03-01 18:06:32.959847	2026-03-02 19:34:51.142896	0.09	2	0.71	14
47	Patricia Place Properties	apartment	Our buildings offer everything you can expect from upscale downtown living, walking distance to a variety of restaurants, shops, breweries, and wine tasting rooms. Close to grocery stores, live entertainment venues, and downtown parks.	5099331700	patriciaplaceproperties@gmail.com	71	2026-03-01 18:06:43.322351	2026-03-02 19:34:51.243689	0.05	1	0.59	11
49	Kamola Residence Hall	dorm	Located on the south end of campus on University Way, Kamola is next to many of our academic buildings which offers an easy commute to classes and all the actives in the SURC. Kamola offers many unique room types, and large lounge areas make it easy to connect with other residents in the hall. Kamola was the first residence hall built and has since been renovated.	(509) 963-1344		73	2026-03-01 18:07:02.221992	2026-03-02 19:34:48.281176	0.25	5	0.02	0
36	Brooklane Village Apartments	apartment	Anderson Brooklane Village is comprised of 13 separate courts with 5 apartment unit clusters in each court and is located a short 15-minute walk Northeast of campus. Residents enjoy a small community atmosphere, close proximity to the Early Childhood Learning Center and are able to reserve the multi-purpose building located in the center of the courts for activities. There is plenty of outdoor space, attached deck, storage units and a basketball court. Brooklane offers unfurnished 1, 2 and 3 bedroom options with many units featuring a 2-story layout. Units are rented on a 12-month contract with rent for 2 and 3-bedroom units split between tenants. Parking is included at no additional fee. Central Transit helps Brooklane residents stay connected to the main campus and Ellensburg community with 2 separate bus stops offering routes departing every 30 minutes.	5099637111		60	2026-03-01 18:04:42.001441	2026-03-02 19:34:50.063166	0.01	0	0.76	15
63	Greenpointe Townhomes	apartment	On-site maintenance. Close to parks. Walking distance to Central Washington University. Off-street parking. 24-hour on-call maintenance. Pet friendly. Apartment amenities include dishwasher, washer, dryer, refrigerator, new renovated designer interiors, ceiling fans in bedrooms, new hard surface flooring, new carpets and paint, new hardware and fixtures, RUB, and fenced private yard.	5099685055	\N	87	2026-03-01 21:11:09.187315	2026-03-02 19:34:51.330479	0.38	7	0.47	9
51	Moore Residence Hall	dorm	Suites in Moore include three single bedrooms that share a bathroom. Located in central campus near the Student Union and Recreation Center, Moore offers an easy commute to many academic building, all the actives in the SURC and the main dining center on campus. Nearby, students can find a covered patio and lawn area for fun actives or relaxation. For the 2026-2027 Academic Year, Moore Hall will offer both gender-inclusive and gendered suites. Stack 'A' (room numbers that start with A) will be gendered, meaning that only a single gender (male or female) can select rooms within a suite. Stacks 'B' and 'C' will be gender-inclusive, meaning that anyone, regardless of gender identity, can select a room within a suite.	(509) 963-1327		75	2026-03-01 18:07:22.945366	2026-03-02 19:34:48.58428	0.30	6	0.21	4
\.


ALTER TABLE public.properties ENABLE TRIGGER ALL;


ALTER TABLE public.lease_agreements DISABLE TRIGGER ALL;

COPY public.lease_agreements (id, property_id, lease_type, start_month, early_termination_fee_cents) FROM stdin;
\.


ALTER TABLE public.lease_agreements ENABLE TRIGGER ALL;


ALTER TABLE public.lease_rules DISABLE TRIGGER ALL;

COPY public.lease_rules (id, rule_text, category, created_at) FROM stdin;
\.


ALTER TABLE public.lease_rules ENABLE TRIGGER ALL;


ALTER TABLE public.lease_agreement_rules DISABLE TRIGGER ALL;

COPY public.lease_agreement_rules (lease_agreement_id, lease_rule_id) FROM stdin;
\.


ALTER TABLE public.lease_agreement_rules ENABLE TRIGGER ALL;


ALTER TABLE public.pet_policies DISABLE TRIGGER ALL;

COPY public.pet_policies (property_id, allowed, deposit_cents, restrictions) FROM stdin;
\.


ALTER TABLE public.pet_policies ENABLE TRIGGER ALL;


ALTER TABLE public.pet_rules DISABLE TRIGGER ALL;

COPY public.pet_rules (id, rule_text, category, created_at) FROM stdin;
\.


ALTER TABLE public.pet_rules ENABLE TRIGGER ALL;


ALTER TABLE public.property_images DISABLE TRIGGER ALL;

COPY public.property_images (id, property_id, image_url, is_thumbnail) FROM stdin;
48	60	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101390/properties/60/95167b15-0008-4373-bf92-c7b620254a4b.jpg	t
47	60	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101378/properties/60/79bb6e81-e833-470a-8a04-77d8c0fddfab.jpg	f
50	42	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773169044/properties/42/8e3fa3c3-b330-432c-b5c7-9f1d56f34298.jpg	t
49	42	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773169032/properties/42/93737312-0bcd-4691-b23d-bc49a7fa613f.jpg	f
51	43	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773169069/properties/43/4701409a-033c-439a-be17-512cd24fecbf.jpg	t
38	54	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101265/properties/54/dd2fb6ca-4836-40f3-a287-b5cbae027808.jpg	t
53	44	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773169094/properties/44/0c538049-2d7e-4c04-89ec-8419b40127ff.jpg	t
37	54	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101252/properties/54/007ed357-a8b9-4492-932e-73be8415f604.jpg	f
52	44	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773169081/properties/44/255ede05-5c42-4f86-b95e-281226d651a6.jpg	f
55	50	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773169118/properties/50/256268dd-6859-4320-92f0-3803226fa437.jpg	t
54	50	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773169106/properties/50/340214bc-b02b-4e9f-a571-80b106b29767.jpg	f
56	51	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773169130/properties/51/b9d03168-4f41-4299-9cea-a95543365932.jpg	t
40	55	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101291/properties/55/96034065-74d9-4604-ae9d-b06cac8a7ff7.jpg	t
39	55	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101279/properties/55/773e44ee-c818-48ea-a53a-3f2968c7814d.jpg	f
42	57	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101316/properties/57/5503f49d-4cee-46ce-b608-57072030ddc6.jpg	t
41	57	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101303/properties/57/7ddeda44-1b3a-4596-ac2c-2a3272e409d7.jpg	f
28	37	https://res.cloudinary.com/dkmt0rk64/image/upload/v1772562330/properties/37/674267fc-224b-4f1d-a959-ba3b576b64a3.jpg	t
27	37	https://res.cloudinary.com/dkmt0rk64/image/upload/v1772562317/properties/37/8433ca83-9961-4aed-800b-bf1cceff6855.jpg	f
30	38	https://res.cloudinary.com/dkmt0rk64/image/upload/v1772562354/properties/38/504c9e17-4bbf-4d90-a732-9d7d1176f55b.jpg	t
29	38	https://res.cloudinary.com/dkmt0rk64/image/upload/v1772562342/properties/38/0d03f30e-01ad-4fcd-b90c-f83255a66c46.jpg	f
31	58	https://res.cloudinary.com/dkmt0rk64/image/upload/v1772562367/properties/58/c18c3dcb-a5af-4eac-b2e1-7137e1873d95.jpg	f
35	36	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101227/properties/36/fffbbecf-a33d-472f-bf7d-654e71445670.jpg	t
36	41	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101240/properties/41/ac5b47d3-01c5-4ce8-8730-c95c24b3659a.jpg	t
44	58	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101342/properties/58/e9e275cc-9dda-4a85-8b74-969cb8dad831.jpg	t
34	59	https://res.cloudinary.com/dkmt0rk64/image/upload/v1772562403/properties/59/6a759479-8df6-4546-91fe-faf1c7b87ad3.jpg	f
45	59	https://res.cloudinary.com/dkmt0rk64/image/upload/v1773101354/properties/59/ce13542b-71fe-44f5-8a0b-d905a7bb6f23.jpg	f
\.


ALTER TABLE public.property_images ENABLE TRIGGER ALL;



ALTER TABLE public.unit_types DISABLE TRIGGER ALL;

COPY public.unit_types (id, property_id, name, bedrooms, bathrooms, rent_cents, availability_date, total_units, available_units, description, created_at, updated_at) FROM stdin;
94	36	Brooklane TownHouse, 1 Bed 1 Bath	2	1	105000	\N	\N	\N	\N	2026-03-01 18:04:42.004199	2026-03-01 18:04:42.004223
95	36	Brooklane TownHouse, 3 Bed 1 Bath	3	1	136000	\N	\N	\N	\N	2026-03-01 18:04:42.006047	2026-03-01 18:04:42.006086
96	36	Brooklane Duplex, 2 bed 1 bath	2	1	128500	\N	\N	\N	\N	2026-03-01 18:04:42.007378	2026-03-01 18:04:42.007401
97	37	Large Single Room 1 Bed 1 Bath	1	1	321200	\N	\N	\N	\N	2026-03-01 18:04:52.355985	2026-03-01 18:04:52.356006
98	37	Standard single room, 1 Bed, one Bath	1	1	305400	\N	\N	\N	\N	2026-03-01 18:04:52.357477	2026-03-01 18:04:52.357496
99	38	Microstudio	1	1	49500	\N	\N	\N	\N	2026-03-01 18:05:02.717603	2026-03-01 18:05:02.717626
100	39	2 Bed 1 Bath	2	1	134000	\N	\N	\N	\N	2026-03-01 18:05:13.083412	2026-03-01 18:05:13.083432
101	39	1 Bed 1 bath	1	1	110000	\N	\N	\N	\N	2026-03-01 18:05:13.084765	2026-03-01 18:05:13.084782
102	40	2 Bed 1 Bath	3	1	78500	\N	\N	\N	\N	2026-03-01 18:05:23.429298	2026-03-01 18:05:23.429316
103	40	Large Studio	1	1	110000	\N	\N	\N	\N	2026-03-01 18:05:23.430561	2026-03-01 18:05:23.430578
104	40	3 Bed 1 Bath	3	1	78500	\N	\N	\N	\N	2026-03-01 18:05:23.431583	2026-03-01 18:05:23.431597
105	40	Studio	1	1	105000	\N	\N	\N	\N	2026-03-01 18:05:23.432474	2026-03-01 18:05:23.432487
106	40	1 Bed 1 Bath	3	1	110000	\N	\N	\N	\N	2026-03-01 18:05:23.433432	2026-03-01 18:05:23.433447
107	41	2 Bed	2	1	80000	\N	\N	\N	\N	2026-03-01 18:05:33.781008	2026-03-01 18:05:33.781031
108	42	Standard Double room, Community Bath	1	1	327500	\N	\N	\N	\N	2026-03-01 18:05:53.101787	2026-03-01 18:05:53.101807
109	42	Single Rooms, Community Bath	1	1	427500	\N	\N	\N	\N	2026-03-01 18:05:53.102966	2026-03-01 18:05:53.102985
110	42	Double Rooms, 1 Private Bath	1	1	365500	\N	\N	\N	\N	2026-03-01 18:05:53.104417	2026-03-01 18:05:53.104446
111	43	Limited triple Rooms, 1 Bath	1	1	269000	\N	\N	\N	\N	2026-03-01 18:06:03.464089	2026-03-01 18:06:03.464114
112	43	Single Rooms, Community Bath	1	1	390000	\N	\N	\N	\N	2026-03-01 18:06:03.466007	2026-03-01 18:06:03.466031
113	43	Standard Double room, Community Bath	1	1	269000	\N	\N	\N	\N	2026-03-01 18:06:03.467462	2026-03-01 18:06:03.467478
114	44	Single Rooms, Community Bath	1	1	390000	\N	\N	\N	\N	2026-03-01 18:06:13.819605	2026-03-01 18:06:13.819619
115	45	2 Bed 1 Bath	2	1	115000	\N	\N	\N	\N	2026-03-01 18:06:22.584854	2026-03-01 18:06:22.58487
116	45	1 Bed 1 Bath	1	1	100000	\N	\N	\N	\N	2026-03-01 18:06:22.586184	2026-03-01 18:06:22.586199
117	45	2 Bed 1 Bath Partially Renovated	2	1	115000	\N	\N	\N	\N	2026-03-01 18:06:22.587328	2026-03-01 18:06:22.587341
118	45	2 Bed 1 Bath Fully Renovated	2	1	130000	\N	\N	\N	\N	2026-03-01 18:06:22.588482	2026-03-01 18:06:22.588497
119	45	1 Bed 1 Bath Fully Renovated	1	1	110000	\N	\N	\N	\N	2026-03-01 18:06:22.589812	2026-03-01 18:06:22.589827
120	45	1 Bed 1 Bath Partially Renovated	1	1	100000	\N	\N	\N	\N	2026-03-01 18:06:22.590955	2026-03-01 18:06:22.590972
121	46	2 Bed 2 Bath open floor plan	2	2	128000	\N	\N	\N	\N	2026-03-01 18:06:32.961411	2026-03-01 18:06:32.961426
122	46	1 Bed 1 Bath	1	1	99500	\N	\N	\N	\N	2026-03-01 18:06:32.962506	2026-03-01 18:06:32.962521
123	46	2 Bed 1 Bath	2	1	128000	\N	\N	\N	\N	2026-03-01 18:06:32.963439	2026-03-01 18:06:32.963451
124	47	2 Bed 1 Bath large	2	1	180000	\N	\N	\N	\N	2026-03-01 18:06:43.324064	2026-03-01 18:06:43.324084
125	47	1 Bed 1 Bath	1	1	118500	\N	\N	\N	\N	2026-03-01 18:06:43.325251	2026-03-01 18:06:43.32527
126	47	2 Bed 1 Bath	2	1	150000	\N	\N	\N	\N	2026-03-01 18:06:43.326447	2026-03-01 18:06:43.326464
127	48	Double room with community Bath	2	1	269000	\N	\N	\N	\N	2026-03-01 18:06:51.836339	2026-03-01 18:06:51.836352
128	48	Single room with community Bath	1	1	390000	\N	\N	\N	\N	2026-03-01 18:06:51.83763	2026-03-01 18:06:51.837643
129	48	Limited triple room Bath	3	1	269000	\N	\N	\N	\N	2026-03-01 18:06:51.840624	2026-03-01 18:06:51.840638
130	49	triple room with community Bath	3	1	269000	\N	\N	\N	\N	2026-03-01 18:07:02.223416	2026-03-01 18:07:02.22343
131	49	Single room with community Bath	1	1	390000	\N	\N	\N	\N	2026-03-01 18:07:02.224752	2026-03-01 18:07:02.224768
132	49	Double room with community Bath	2	1	269000	\N	\N	\N	\N	2026-03-01 18:07:02.225976	2026-03-01 18:07:02.225988
133	49	suit style room with Bath	3	1	327500	\N	\N	\N	\N	2026-03-01 18:07:02.22721	2026-03-01 18:07:02.227222
134	50	Double room with community Bath	2	1	269000	\N	\N	\N	\N	2026-03-01 18:07:12.587821	2026-03-01 18:07:12.587834
135	50	Single room with community Bath	1	1	390000	\N	\N	\N	\N	2026-03-01 18:07:12.588779	2026-03-01 18:07:12.588793
136	51	Triple bedroom with community Bath	3	1	269000	\N	\N	\N	\N	2026-03-01 18:07:22.946625	2026-03-01 18:07:22.946637
137	52	single bedroom with community Bath	1	1	390000	\N	\N	\N	\N	2026-03-01 18:07:33.470655	2026-03-01 18:07:33.470664
138	53	Double room with community Bath	2	1	269000	\N	\N	\N	\N	2026-03-01 18:07:43.927201	2026-03-01 18:07:43.927212
139	53	Single room with community Bath	1	1	390000	\N	\N	\N	\N	2026-03-01 18:07:43.928249	2026-03-01 18:07:43.928259
140	54	Single room with community Bath	1	1	390000	\N	\N	\N	\N	2026-03-01 18:07:54.281134	2026-03-01 18:07:54.281149
141	54	Double room with community Bath	2	1	269000	\N	\N	\N	\N	2026-03-01 18:07:54.282333	2026-03-01 18:07:54.282343
142	55	single bedroom with en suite Bath	1	1	327500	\N	\N	\N	\N	2026-03-01 18:08:04.751125	2026-03-01 18:08:04.751133
143	56	Double room with private Bath	2	1	365500	\N	\N	\N	\N	2026-03-01 21:09:56.569383	2026-03-01 21:09:56.569395
144	56	Double room with community Bath	2	1	327500	\N	\N	\N	\N	2026-03-01 21:09:56.571263	2026-03-01 21:09:56.571274
145	57	single room with shared Bath	1	1	427500	\N	\N	\N	\N	2026-03-01 21:10:06.939966	2026-03-01 21:10:06.939978
146	57	Double room with shared Bath	2	1	327500	\N	\N	\N	\N	2026-03-01 21:10:06.941846	2026-03-01 21:10:06.941859
147	58	suite with 4 rooms en suite Bath	4	4	365500	\N	\N	\N	\N	2026-03-01 21:10:17.319608	2026-03-01 21:10:17.319623
148	58	suite Double room with an en siuite Bath	2	2	365500	\N	\N	\N	\N	2026-03-01 21:10:17.321381	2026-03-01 21:10:17.321392
149	58	double room with community Bath	2	1	327500	\N	\N	\N	\N	2026-03-01 21:10:17.322751	2026-03-01 21:10:17.322762
150	59	4 single room suit an en suite Bath	4	4	427500	\N	\N	\N	\N	2026-03-01 21:10:27.675678	2026-03-01 21:10:27.67569
151	59	Double room with community Bath	2	1	327500	\N	\N	\N	\N	2026-03-01 21:10:27.677148	2026-03-01 21:10:27.67716
152	60	single bedroom with Bath	1	1	390000	\N	\N	\N	\N	2026-03-01 21:10:38.056739	2026-03-01 21:10:38.056758
153	61	1 Bed 1 Bath	1	1	90000	\N	\N	\N	\N	2026-03-01 21:10:48.483623	2026-03-01 21:10:48.483634
154	61	Renovated 1 Bed 1 Bath	1	1	97500	\N	\N	\N	\N	2026-03-01 21:10:48.485083	2026-03-01 21:10:48.485093
155	62	2 Bed 1 Bath 2x1	2	1	118700	\N	\N	\N	\N	2026-03-01 21:10:58.848962	2026-03-01 21:10:58.848973
156	62	2 Bed 1 Bath Plus Den	2	1	138700	\N	\N	\N	\N	2026-03-01 21:10:58.85013	2026-03-01 21:10:58.85014
157	63	3 Bed 2.5 Bath 3x2.5	3	3	173500	\N	\N	\N	\N	2026-03-01 21:11:09.188692	2026-03-01 21:11:09.188702
158	63	2 Bed 1 Bath Ashton Flat	2	1	120000	\N	\N	\N	\N	2026-03-01 21:11:09.189966	2026-03-01 21:11:09.189976
159	63	2 Bed 1.5 Bath 2x1.5	2	3	149500	\N	\N	\N	\N	2026-03-01 21:11:09.191074	2026-03-01 21:11:09.191083
160	63	2 Bed 1.5 Bath Ashton Townhome	2	1	122500	\N	\N	\N	\N	2026-03-01 21:11:09.192019	2026-03-01 21:11:09.192027
161	63	2 Bed 1.5 Bath Ryegate Townhome	2	3	123500	\N	\N	\N	\N	2026-03-01 21:11:09.192948	2026-03-01 21:11:09.192956
162	63	2 Bed 1 Bath Ryegate Flat	2	1	125000	\N	\N	\N	\N	2026-03-01 21:11:09.193876	2026-03-01 21:11:09.193883
\.


ALTER TABLE public.unit_types ENABLE TRIGGER ALL;


SELECT pg_catalog.setval('public.addresses_id_seq', 95, true);



SELECT pg_catalog.setval('public.destinations_id_seq', 93, true);



SELECT pg_catalog.setval('public.lease_agreements_id_seq', 1, false);



SELECT pg_catalog.setval('public.lease_rules_id_seq', 1, false);



SELECT pg_catalog.setval('public.pet_rules_id_seq', 1, false);



SELECT pg_catalog.setval('public.properties_id_seq', 63, true);



SELECT pg_catalog.setval('public.property_images_id_seq', 56, true);



SELECT pg_catalog.setval('public.unit_types_id_seq', 162, true);




