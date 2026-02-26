--
-- PostgreSQL database dump
--

\restrict MRFN2zq2Yf865utBklsXhwZgXosO1yEadUcVuyJyFqexPx3mtEToOedUWgqpd1m

-- Dumped from database version 15.16 (Debian 15.16-1.pgdg13+1)
-- Dumped by pg_dump version 18.2 (Debian 18.2-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: enforce_single_thumbnail(); Type: FUNCTION; Schema: public; Owner: ameb8
--

CREATE FUNCTION public.enforce_single_thumbnail() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.is_thumbnail THEN
        UPDATE property_images
        SET is_thumbnail = FALSE
        WHERE property_id = NEW.property_id
          AND id <> COALESCE(NEW.id, -1)
          AND is_thumbnail = TRUE;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.enforce_single_thumbnail() OWNER TO ameb8;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.addresses (
    id bigint NOT NULL,
    street_address text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    postal_code text NOT NULL,
    country text DEFAULT 'USA'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.addresses OWNER TO ameb8;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: ameb8
--

ALTER TABLE public.addresses ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: destinations; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.destinations (
    id bigint NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    description text,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    address_id bigint,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT chk_latitude CHECK (((latitude >= ('-90'::integer)::double precision) AND (latitude <= (90)::double precision))),
    CONSTRAINT chk_longitude CHECK (((longitude >= ('-180'::integer)::double precision) AND (longitude <= (180)::double precision))),
    CONSTRAINT chk_property_has_address CHECK (((type <> 'property'::text) OR (address_id IS NOT NULL))),
    CONSTRAINT destinations_type_check CHECK ((type = ANY (ARRAY['property'::text, 'cwu'::text, 'bus_stop'::text, 'other'::text])))
);


ALTER TABLE public.destinations OWNER TO ameb8;

--
-- Name: destinations_id_seq; Type: SEQUENCE; Schema: public; Owner: ameb8
--

ALTER TABLE public.destinations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.destinations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO ameb8;

--
-- Name: lease_agreement_rules; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.lease_agreement_rules (
    lease_agreement_id bigint NOT NULL,
    lease_rule_id bigint NOT NULL
);


ALTER TABLE public.lease_agreement_rules OWNER TO ameb8;

--
-- Name: lease_agreements; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.lease_agreements (
    id bigint NOT NULL,
    property_id bigint NOT NULL,
    lease_type text,
    start_month text,
    early_termination_fee_cents integer
);


ALTER TABLE public.lease_agreements OWNER TO ameb8;

--
-- Name: lease_agreements_id_seq; Type: SEQUENCE; Schema: public; Owner: ameb8
--

ALTER TABLE public.lease_agreements ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lease_agreements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lease_rules; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.lease_rules (
    id bigint NOT NULL,
    rule_text text NOT NULL,
    category text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.lease_rules OWNER TO ameb8;

--
-- Name: lease_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: ameb8
--

ALTER TABLE public.lease_rules ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lease_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pet_policies; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.pet_policies (
    property_id bigint NOT NULL,
    allowed boolean NOT NULL,
    deposit_cents integer,
    restrictions text
);


ALTER TABLE public.pet_policies OWNER TO ameb8;

--
-- Name: pet_rules; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.pet_rules (
    id bigint NOT NULL,
    rule_text text NOT NULL,
    category text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.pet_rules OWNER TO ameb8;

--
-- Name: pet_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: ameb8
--

ALTER TABLE public.pet_rules ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pet_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: properties; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.properties (
    id bigint NOT NULL,
    name text NOT NULL,
    property_type text NOT NULL,
    description text,
    contact_phone text,
    contact_email text,
    destination_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT properties_property_type_check CHECK ((property_type = ANY (ARRAY['apartment'::text, 'dorm'::text, 'house'::text])))
);


ALTER TABLE public.properties OWNER TO ameb8;

--
-- Name: properties_id_seq; Type: SEQUENCE; Schema: public; Owner: ameb8
--

ALTER TABLE public.properties ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: property_images; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.property_images (
    id bigint NOT NULL,
    property_id bigint NOT NULL,
    image_url text NOT NULL,
    is_thumbnail boolean DEFAULT false
);


ALTER TABLE public.property_images OWNER TO ameb8;

--
-- Name: property_images_id_seq; Type: SEQUENCE; Schema: public; Owner: ameb8
--

ALTER TABLE public.property_images ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.property_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: property_pet_rules; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.property_pet_rules (
    property_id bigint NOT NULL,
    pet_rule_id bigint NOT NULL
);


ALTER TABLE public.property_pet_rules OWNER TO ameb8;

--
-- Name: property_walk_distances; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.property_walk_distances (
    property_id bigint NOT NULL,
    destination_id bigint NOT NULL,
    walking_miles numeric(4,2),
    walking_minutes integer
);


ALTER TABLE public.property_walk_distances OWNER TO ameb8;

--
-- Name: unit_types; Type: TABLE; Schema: public; Owner: ameb8
--

CREATE TABLE public.unit_types (
    id bigint NOT NULL,
    property_id bigint NOT NULL,
    name text NOT NULL,
    bedrooms integer NOT NULL,
    bathrooms integer NOT NULL,
    rent_cents integer NOT NULL,
    availability_date date,
    total_units integer,
    available_units integer,
    description text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.unit_types OWNER TO ameb8;

--
-- Name: unit_types_id_seq; Type: SEQUENCE; Schema: public; Owner: ameb8
--

ALTER TABLE public.unit_types ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.unit_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.addresses (id, street_address, city, state, postal_code, country, created_at, updated_at) FROM stdin;
1	905 Dean Nicholson Blvd Wendell Hill Hall A	Ellensburg	WA	98926	USA	2026-02-07 04:33:31.621444	2026-02-07 04:33:31.621444
2	810 E University Way	Ellensburg	WA	98926	USA	2026-02-07 04:33:31.621444	2026-02-07 04:33:31.621444
8	711 E 18th Ave Suite M2	Ellensburg	WA	98926	USA	2026-02-15 20:20:14.482763	2026-02-15 20:20:14.482808
9	1201 E Helena Ave	Ellensburg	WA	98926	USA	2026-02-15 20:49:47.808492	2026-02-15 20:49:47.808526
10	109 S Water St	Ellensburg	WA	98926	USA	2026-02-18 10:46:10.755404	2026-02-18 10:46:10.755404
11	1437 N Alder St	Ellensburg	WA	98926	USA	2026-02-18 10:49:13.654157	2026-02-18 10:49:13.654157
12	206 E 15th Ave	Ellensburg	WA	98926	USA	2026-02-21 02:18:05.028557	2026-02-21 02:18:05.028606
13	1001 S. Chestnut St.	Ellensburg	WA	98926	USA	2026-02-21 02:18:15.531977	2026-02-21 02:18:15.532014
14	809 E Juniper Ave	Ellensburg	WA	98926	USA	2026-02-21 02:18:25.897554	2026-02-21 02:18:25.897588
15	101 E 14th Ave	Ellensburg	WA	98926	USA	2026-02-21 02:18:36.271512	2026-02-21 02:18:36.271551
\.


--
-- Data for Name: destinations; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.destinations (id, name, type, description, latitude, longitude, address_id, created_at, updated_at) FROM stdin;
1	Wendell Hill Hall A	property	Wendell Hill Hall A is one of our two Wendell Hill residence halls with a modern set up and feel for our sophomore and up students. Nearby, students can find many outdoor recreation opportunities such as the tennis courts, basketball courts and field house. There is also a full-service coffee shop on the ground floor of Wendell B. Wendell Hill Hall A is home to the Music Living Learning Community, which is open to all music majors regardless of year.	47.00657	-120.53404	1	2026-02-07 04:33:31.621444	2026-02-07 04:33:31.621444
2	University & 9th	bus_stop	Bus stop at University and 9th	47.00067	-120.53588	2	2026-02-07 04:33:31.621444	2026-02-07 04:33:31.621444
8	Greenpointe Townhomes	property	Greenpointe Townhomes feature on-site maintenance, off-street parking, fenced private yards, pet-friendly units, new designer interiors, ceiling fans in bedrooms, new hard surface flooring, new carpets and paint, new hardware and fixtures, RUB utilities, and walking distance to Central Washington University and nearby parks. Pets allowed with restrictions and associated fees.	47.01097	-120.53643	8	2026-02-15 20:20:14.514063	2026-02-15 20:20:14.514093
9	Central Park Apartments	property	Central Park Apartments offer modern amenities including a 24-hour emergency line, business center, clubhouse, fitness center, online rent payments, on-site maintenance & management, swimming pool, TV lounge, additional storage, dishwasher, garage with remote access, heating & air conditioning, modern kitchens, private balcony, refrigerator, spacious open floor plans, and in-unit washer & dryer. Pets are not allowed.	47.01439	-120.52694	9	2026-02-15 20:49:47.810857	2026-02-15 20:49:47.810887
10	Water & Capitol	bus_stop	Bus stop at Water and Capitol	46.99148	-120.54973	10	2026-02-18 10:47:23.148111	2026-02-18 10:47:23.148111
11	Alder & 14th	bus_stop	Bus stop at Alder and 14th	47.00671	-120.53209	11	2026-02-18 10:51:40.875408	2026-02-18 10:51:40.875408
12	Cascade Village	property	Upscale townhome living in a pet-friendly community. Free high-speed WiFi. Pets welcome with approval (cats and dogs). On-site management. 24-hour emergency maintenance. On-site laundry. Close to shopping, dining, Central Washington University, and outdoor recreation.	47.00687	-120.54389	12	2026-02-21 02:18:05.053963	2026-02-21 02:18:05.053991
13	Briarwood Apartments	property	We are a beautiful, affordable, and independent apartment community in Ellensburg for seniors 55+ and disabled. Our great location and super prices make us Ellensburg’s best. A quaint and quiet property help make Briarwood Commons a unique and enjoyable community. We have one bedroom/one bath apartments. Each apartment home includes washer/dryer hookups, garbage disposal, frost free refrigerator, self cleaning oven, dishwasher, air conditioning, and a patio/balcony with a storage closet. At the The Briarwood Commons Clubhouse we have an outdoor swimming pool, fitness room, and 24hr emergency maintenance service. There are many activities going on in the The Briarwood Commons Clubhouse each day. We have a Book Club, Crafts, Cards, Ceramics, Art Class, Bible Study, and Movie Night. Briarwood Commons is in close proximity to grocery stores, pharmacies, Hope Source, hourly bus services, shuttle service to Yakima, banking, and the Kittitas Valley Community Hospital	46.98272	-120.53677	13	2026-02-21 02:18:15.533964	2026-02-21 02:18:15.533992
14	Juniper Row	property	We don't just rent apartments. From the moment you walk through the front door you'll feel the comfort that makes our residents happy to call us home. Cutting edge amenities, meticulously-groomed grounds, and a dedicated staff contributes to a higher standard of living. Convenient shopping, award-winning schools, local museums and parks are all close at hand, with sponsored activities to develop new hobbies while getting to know your neighbors.	47.01198	-120.53606	14	2026-02-21 02:18:25.899346	2026-02-21 02:18:25.899374
15	Aspen Circle Apartments	property	Aspen Circle aims to be the most sought-after apartment complex in Ellensburg.  We welcome families, singles, couples, pets, college students and seniors…you name it, you’re welcome here! Aspen Circle is made up of 40 units arranged in a cul de sac,surrounded by beautiful landscaping and trees.  Traffic is minimal, and the feeling is peaceful.  CWU, Kiwanis Park, and downtown Ellensburg are all in walking distance. Aspen Circle is owned by Laurie Merwin and Klaus Holzer.  Long-time Ellensburg residents, they are committed to the community and to providing renters a safe, pleasant home with good rental value and service: good people serving good people. Laurie says, "We are always at the apartments improving the grounds or in the office.  We are here to help."	47.00659	-120.54579	15	2026-02-21 02:18:36.273374	2026-02-21 02:18:36.273409
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	enable postgis	SQL	V1__enable_postgis.sql	-1627021776	ameb8	2026-02-07 04:33:29.591775	771	t
2	2	create addresses table	SQL	V2__create_addresses_table.sql	-1019978849	ameb8	2026-02-07 04:33:30.960082	19	t
3	3	create destinations table.sql	SQL	V3__create_destinations_table.sql.sql	-1446771131	ameb8	2026-02-07 04:33:31.016078	28	t
4	4	create properties table	SQL	V4__create_properties_table.sql	-1235947306	ameb8	2026-02-07 04:33:31.064408	37	t
5	5	create unit types table	SQL	V5__create_unit_types_table.sql	1513437373	ameb8	2026-02-07 04:33:31.136681	23	t
6	6	create property walk distances table	SQL	V6__create_property_walk_distances_table.sql	1436142663	ameb8	2026-02-07 04:33:31.191312	20	t
7	7	create property images table	SQL	V7__create_property_images_table.sql	771359390	ameb8	2026-02-07 04:33:31.233486	22	t
8	8	create lease agreements table	SQL	V8__create_lease_agreements_table.sql	-431674040	ameb8	2026-02-07 04:33:31.277355	30	t
9	9	create pet policies table	SQL	V9__create_pet_policies_table.sql	-1680112600	ameb8	2026-02-07 04:33:31.32682	28	t
10	10	create lease rules table	SQL	V10__create_lease_rules_table.sql	502136579	ameb8	2026-02-07 04:33:31.372512	20	t
11	11	create pet rules table	SQL	V11__create_pet_rules_table.sql	1603415123	ameb8	2026-02-07 04:33:31.410311	18	t
12	12	create lease agreement rules table	SQL	V12__create_lease_agreement_rules_table.sql	-1521457275	ameb8	2026-02-07 04:33:31.446766	20	t
13	13	create property pet rules table	SQL	V13__create_property_pet_rules_table.sql	986187793	ameb8	2026-02-07 04:33:31.482932	19	t
14	14	enforce single thumbnail function	SQL	V14__enforce_single_thumbnail_function.sql	1947526758	ameb8	2026-02-07 04:33:31.523249	9	t
15	15	property images thumbnail trigger	SQL	V15__property_images_thumbnail_trigger.sql	1332097155	ameb8	2026-02-07 04:33:31.551939	12	t
16	16	property images thumbnail unique index	SQL	V16__property_images_thumbnail_unique_index.sql	-963004808	ameb8	2026-02-07 04:33:31.579676	10	t
17	17	dev seed data 1	SQL	V17__dev_seed_data_1.sql	-1078110034	ameb8	2026-02-07 04:33:31.606078	42	t
\.


--
-- Data for Name: lease_agreement_rules; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.lease_agreement_rules (lease_agreement_id, lease_rule_id) FROM stdin;
\.


--
-- Data for Name: lease_agreements; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.lease_agreements (id, property_id, lease_type, start_month, early_termination_fee_cents) FROM stdin;
\.


--
-- Data for Name: lease_rules; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.lease_rules (id, rule_text, category, created_at) FROM stdin;
\.


--
-- Data for Name: pet_policies; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.pet_policies (property_id, allowed, deposit_cents, restrictions) FROM stdin;
\.


--
-- Data for Name: pet_rules; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.pet_rules (id, rule_text, category, created_at) FROM stdin;
\.


--
-- Data for Name: properties; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.properties (id, name, property_type, description, contact_phone, contact_email, destination_id, created_at, updated_at) FROM stdin;
1	Wendell Hill Hall A	dorm	Wendell Hill Hall A is one of our two Wendell Hill residence halls with a modern set up and feel for our sophomore and up students. Nearby, students can find many outdoor recreation opportunities such as the tennis courts, basketball courts and field house. There is also a full-service coffee shop on the ground floor of Wendell B. Wendell Hill Hall A is home to the Music Living Learning Community, which is open to all music majors regardless of year.	5099631831	housing@cwu.edu	1	2026-02-07 04:33:31.621444	2026-02-07 04:33:31.621444
7	Greenpointe Townhomes	apartment	Greenpointe Townhomes feature on-site maintenance, off-street parking, fenced private yards, pet-friendly units, new designer interiors, ceiling fans in bedrooms, new hard surface flooring, new carpets and paint, new hardware and fixtures, RUB utilities, and walking distance to Central Washington University and nearby parks. Pets allowed with restrictions and associated fees.	5099685055	leasing@greenpointe.com	8	2026-02-15 20:20:14.521711	2026-02-15 20:20:14.521733
8	Central Park Apartments	apartment	Central Park Apartments offer modern amenities including a 24-hour emergency line, business center, clubhouse, fitness center, online rent payments, on-site maintenance & management, swimming pool, TV lounge, additional storage, dishwasher, garage with remote access, heating & air conditioning, modern kitchens, private balcony, refrigerator, spacious open floor plans, and in-unit washer & dryer. Pets are not allowed.	5099251247	\N	9	2026-02-15 20:49:47.814489	2026-02-15 20:49:47.814521
9	Cascade Village	apartment	Upscale townhome living in a pet-friendly community. Free high-speed WiFi. Pets welcome with approval (cats and dogs). On-site management. 24-hour emergency maintenance. On-site laundry. Close to shopping, dining, Central Washington University, and outdoor recreation.	5099626469	\N	12	2026-02-21 02:18:05.059546	2026-02-21 02:18:05.059569
10	Briarwood Apartments	apartment	We are a beautiful, affordable, and independent apartment community in Ellensburg for seniors 55+ and disabled. Our great location and super prices make us Ellensburg’s best. A quaint and quiet property help make Briarwood Commons a unique and enjoyable community. We have one bedroom/one bath apartments. Each apartment home includes washer/dryer hookups, garbage disposal, frost free refrigerator, self cleaning oven, dishwasher, air conditioning, and a patio/balcony with a storage closet. At the The Briarwood Commons Clubhouse we have an outdoor swimming pool, fitness room, and 24hr emergency maintenance service. There are many activities going on in the The Briarwood Commons Clubhouse each day. We have a Book Club, Crafts, Cards, Ceramics, Art Class, Bible Study, and Movie Night. Briarwood Commons is in close proximity to grocery stores, pharmacies, Hope Source, hourly bus services, shuttle service to Yakima, banking, and the Kittitas Valley Community Hospital	5099331888	\N	13	2026-02-21 02:18:15.536063	2026-02-21 02:18:15.536089
11	Juniper Row	apartment	We don't just rent apartments. From the moment you walk through the front door you'll feel the comfort that makes our residents happy to call us home. Cutting edge amenities, meticulously-groomed grounds, and a dedicated staff contributes to a higher standard of living. Convenient shopping, award-winning schools, local museums and parks are all close at hand, with sponsored activities to develop new hobbies while getting to know your neighbors.	5099257634	\N	14	2026-02-21 02:18:25.901375	2026-02-21 02:18:25.901403
12	Aspen Circle Apartments	apartment	Aspen Circle aims to be the most sought-after apartment complex in Ellensburg.  We welcome families, singles, couples, pets, college students and seniors…you name it, you’re welcome here! Aspen Circle is made up of 40 units arranged in a cul de sac,surrounded by beautiful landscaping and trees.  Traffic is minimal, and the feeling is peaceful.  CWU, Kiwanis Park, and downtown Ellensburg are all in walking distance. Aspen Circle is owned by Laurie Merwin and Klaus Holzer.  Long-time Ellensburg residents, they are committed to the community and to providing renters a safe, pleasant home with good rental value and service: good people serving good people. Laurie says, "We are always at the apartments improving the grounds or in the office.  We are here to help."	5099629291	aspencircle1@gmail.com	15	2026-02-21 02:18:36.275795	2026-02-21 02:18:36.275827
\.


--
-- Data for Name: property_images; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.property_images (id, property_id, image_url, is_thumbnail) FROM stdin;
2	1	https://res.cloudinary.com/dkmt0rk64/image/upload/v1770866526/properties/1/e569ed10-7adb-4bdd-92a3-8d6a42fc500e.jpg	t
1	1	https://res.cloudinary.com/dkmt0rk64/image/upload/v1770866485/properties/1/f2dae3f6-b865-43b0-9ed8-31b321a97c3c.jpg	f
4	7	https://res.cloudinary.com/dkmt0rk64/image/upload/v1771187296/properties/7/aec816b0-e98e-47a8-89ff-bf19d6647f96.jpg	f
5	7	https://res.cloudinary.com/dkmt0rk64/image/upload/v1771187305/properties/7/0131bf81-ef01-4742-86b0-5dd2fe700a12.jpg	f
7	7	https://res.cloudinary.com/dkmt0rk64/image/upload/v1771187330/properties/7/ecd0014e-74e2-47ba-b985-e4e02dbf17d8.jpg	t
6	7	https://res.cloudinary.com/dkmt0rk64/image/upload/v1771187313/properties/7/7c02e719-68c5-4b00-ade0-d0b9e497eadd.jpg	f
8	8	https://res.cloudinary.com/dkmt0rk64/image/upload/v1771188853/properties/8/d86686ce-3e46-4fad-bfdb-4ae5b8dcf8dd.jpg	f
9	8	https://res.cloudinary.com/dkmt0rk64/image/upload/v1771188861/properties/8/a3c4a2ca-4528-456a-90c5-26f398e089ef.jpg	f
11	8	https://res.cloudinary.com/dkmt0rk64/image/upload/v1771188887/properties/8/9b06b431-9d7d-418d-9436-d008a594fd19.jpg	t
10	8	https://res.cloudinary.com/dkmt0rk64/image/upload/v1771188881/properties/8/3a1a6cf5-d0c9-40c5-a0ad-537d2483c429.jpg	f
\.


--
-- Data for Name: property_pet_rules; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.property_pet_rules (property_id, pet_rule_id) FROM stdin;
\.


--
-- Data for Name: property_walk_distances; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.property_walk_distances (property_id, destination_id, walking_miles, walking_minutes) FROM stdin;
1	2	0.50	11
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: unit_types; Type: TABLE DATA; Schema: public; Owner: ameb8
--

COPY public.unit_types (id, property_id, name, bedrooms, bathrooms, rent_cents, availability_date, total_units, available_units, description, created_at, updated_at) FROM stdin;
1	1	Double Room	1	1	104833	\N	\N	\N	Shared unit with 2 residents and private bathroom.	2026-02-07 04:33:31.621444	2026-02-07 04:33:31.621444
2	1	4-Person Suite	4	1	116666	\N	\N	\N	\N	2026-02-07 04:33:31.621444	2026-02-07 04:33:31.621444
3	1	Double Suite	2	1	116666	\N	\N	\N	\N	2026-02-07 04:33:31.621444	2026-02-07 04:33:31.621444
10	7	3 Bed 3 Bath	3	3	173500	\N	\N	\N	\N	2026-02-15 20:20:14.526122	2026-02-15 20:20:14.526148
11	7	2 Bed 1 Bath	2	2	122000	\N	\N	\N	\N	2026-02-15 20:20:14.529064	2026-02-15 20:20:14.529104
12	7	2 Bed 2 Bath	2	2	122500	\N	\N	\N	\N	2026-02-15 20:20:14.530558	2026-02-15 20:20:14.530579
13	8	4 Beds 3 Baths	4	3	222500	\N	\N	\N	\N	2026-02-15 20:49:47.817325	2026-02-15 20:49:47.817363
14	8	3 Beds 2 Baths	3	2	200000	\N	\N	\N	\N	2026-02-15 20:49:47.819826	2026-02-15 20:49:47.819857
15	8	2 Beds 2 Baths	2	2	169000	\N	\N	\N	\N	2026-02-15 20:49:47.821838	2026-02-15 20:49:47.82187
16	8	1 Bed 1 Bath	1	1	153500	\N	\N	\N	\N	2026-02-15 20:49:47.824171	2026-02-15 20:49:47.824205
17	9	2 Bed	2	0	105000	\N	\N	\N	\N	2026-02-21 02:18:05.062764	2026-02-21 02:18:05.062792
18	9	1 Bed 1 Bath	1	1	95000	\N	\N	\N	\N	2026-02-21 02:18:05.065279	2026-02-21 02:18:05.065305
19	9	Studio Apartment	0	0	110000	\N	\N	\N	\N	2026-02-21 02:18:05.066792	2026-02-21 02:18:05.066815
20	9	2 Bed 1.5 Bath Townhome	2	2	132500	\N	\N	\N	\N	2026-02-21 02:18:05.068193	2026-02-21 02:18:05.068217
21	10	1 Bed 1 Bath	1	1	114300	\N	\N	\N	\N	2026-02-21 02:18:15.538031	2026-02-21 02:18:15.538063
22	10	1 Bed 1 Bath	1	1	53700	\N	\N	\N	\N	2026-02-21 02:18:15.540467	2026-02-21 02:18:15.540496
23	11	2 Bed 1 Bath 2x1P	2	1	131300	\N	\N	\N	\N	2026-02-21 02:18:25.903506	2026-02-21 02:18:25.903549
24	11	2 Bed 1 Bath 2x1R	2	1	133800	\N	\N	\N	\N	2026-02-21 02:18:25.905386	2026-02-21 02:18:25.905416
25	11	2 Bed 1 Bath 2x1	2	1	128800	\N	\N	\N	\N	2026-02-21 02:18:25.907152	2026-02-21 02:18:25.907186
26	12	1 Bed 1 Bath 683 Sq Ft	1	1	103500	\N	\N	\N	\N	2026-02-21 02:18:36.278252	2026-02-21 02:18:36.278285
27	12	3 Bed 1 Bath 1201 Sq Ft	3	1	150000	\N	\N	\N	\N	2026-02-21 02:18:36.280266	2026-02-21 02:18:36.280302
28	12	2 Bed 1 Bath 963 Sq Ft	2	1	116500	\N	\N	\N	\N	2026-02-21 02:18:36.28209	2026-02-21 02:18:36.28212
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameb8
--

SELECT pg_catalog.setval('public.addresses_id_seq', 15, true);


--
-- Name: destinations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameb8
--

SELECT pg_catalog.setval('public.destinations_id_seq', 15, true);


--
-- Name: lease_agreements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameb8
--

SELECT pg_catalog.setval('public.lease_agreements_id_seq', 1, false);


--
-- Name: lease_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameb8
--

SELECT pg_catalog.setval('public.lease_rules_id_seq', 1, false);


--
-- Name: pet_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameb8
--

SELECT pg_catalog.setval('public.pet_rules_id_seq', 1, false);


--
-- Name: properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameb8
--

SELECT pg_catalog.setval('public.properties_id_seq', 12, true);


--
-- Name: property_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameb8
--

SELECT pg_catalog.setval('public.property_images_id_seq', 13, true);


--
-- Name: unit_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameb8
--

SELECT pg_catalog.setval('public.unit_types_id_seq', 28, true);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: lease_agreement_rules lease_agreement_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.lease_agreement_rules
    ADD CONSTRAINT lease_agreement_rules_pkey PRIMARY KEY (lease_agreement_id, lease_rule_id);


--
-- Name: lease_agreements lease_agreements_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.lease_agreements
    ADD CONSTRAINT lease_agreements_pkey PRIMARY KEY (id);


--
-- Name: lease_agreements lease_agreements_property_id_key; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.lease_agreements
    ADD CONSTRAINT lease_agreements_property_id_key UNIQUE (property_id);


--
-- Name: lease_rules lease_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.lease_rules
    ADD CONSTRAINT lease_rules_pkey PRIMARY KEY (id);


--
-- Name: pet_policies pet_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.pet_policies
    ADD CONSTRAINT pet_policies_pkey PRIMARY KEY (property_id);


--
-- Name: pet_rules pet_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.pet_rules
    ADD CONSTRAINT pet_rules_pkey PRIMARY KEY (id);


--
-- Name: properties properties_destination_id_key; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_destination_id_key UNIQUE (destination_id);


--
-- Name: properties properties_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);


--
-- Name: property_images property_images_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.property_images
    ADD CONSTRAINT property_images_pkey PRIMARY KEY (id);


--
-- Name: property_pet_rules property_pet_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.property_pet_rules
    ADD CONSTRAINT property_pet_rules_pkey PRIMARY KEY (property_id, pet_rule_id);


--
-- Name: property_walk_distances property_walk_distances_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.property_walk_distances
    ADD CONSTRAINT property_walk_distances_pkey PRIMARY KEY (property_id, destination_id);


--
-- Name: unit_types unit_types_pkey; Type: CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.unit_types
    ADD CONSTRAINT unit_types_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: ameb8
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: uq_property_thumbnail; Type: INDEX; Schema: public; Owner: ameb8
--

CREATE UNIQUE INDEX uq_property_thumbnail ON public.property_images USING btree (property_id) WHERE (is_thumbnail = true);


--
-- Name: property_images trg_single_thumbnail; Type: TRIGGER; Schema: public; Owner: ameb8
--

CREATE TRIGGER trg_single_thumbnail BEFORE INSERT OR UPDATE ON public.property_images FOR EACH ROW EXECUTE FUNCTION public.enforce_single_thumbnail();


--
-- Name: destinations fk_destination_address; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.destinations
    ADD CONSTRAINT fk_destination_address FOREIGN KEY (address_id) REFERENCES public.addresses(id) ON DELETE SET NULL;


--
-- Name: property_images fk_image_property; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.property_images
    ADD CONSTRAINT fk_image_property FOREIGN KEY (property_id) REFERENCES public.properties(id) ON DELETE CASCADE;


--
-- Name: lease_agreement_rules fk_lar_lease_agreement; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.lease_agreement_rules
    ADD CONSTRAINT fk_lar_lease_agreement FOREIGN KEY (lease_agreement_id) REFERENCES public.lease_agreements(id) ON DELETE CASCADE;


--
-- Name: lease_agreement_rules fk_lar_lease_rule; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.lease_agreement_rules
    ADD CONSTRAINT fk_lar_lease_rule FOREIGN KEY (lease_rule_id) REFERENCES public.lease_rules(id) ON DELETE CASCADE;


--
-- Name: lease_agreements fk_lease_property; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.lease_agreements
    ADD CONSTRAINT fk_lease_property FOREIGN KEY (property_id) REFERENCES public.properties(id) ON DELETE CASCADE;


--
-- Name: pet_policies fk_pet_property; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.pet_policies
    ADD CONSTRAINT fk_pet_property FOREIGN KEY (property_id) REFERENCES public.properties(id) ON DELETE CASCADE;


--
-- Name: property_pet_rules fk_ppr_pet_rule; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.property_pet_rules
    ADD CONSTRAINT fk_ppr_pet_rule FOREIGN KEY (pet_rule_id) REFERENCES public.pet_rules(id) ON DELETE CASCADE;


--
-- Name: property_pet_rules fk_ppr_property; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.property_pet_rules
    ADD CONSTRAINT fk_ppr_property FOREIGN KEY (property_id) REFERENCES public.properties(id) ON DELETE CASCADE;


--
-- Name: properties fk_properties_destination; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT fk_properties_destination FOREIGN KEY (destination_id) REFERENCES public.destinations(id) ON DELETE CASCADE;


--
-- Name: unit_types fk_unit_types_property; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.unit_types
    ADD CONSTRAINT fk_unit_types_property FOREIGN KEY (property_id) REFERENCES public.properties(id) ON DELETE CASCADE;


--
-- Name: property_walk_distances fk_walk_destination; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.property_walk_distances
    ADD CONSTRAINT fk_walk_destination FOREIGN KEY (destination_id) REFERENCES public.destinations(id) ON DELETE CASCADE;


--
-- Name: property_walk_distances fk_walk_property; Type: FK CONSTRAINT; Schema: public; Owner: ameb8
--

ALTER TABLE ONLY public.property_walk_distances
    ADD CONSTRAINT fk_walk_property FOREIGN KEY (property_id) REFERENCES public.properties(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict MRFN2zq2Yf865utBklsXhwZgXosO1yEadUcVuyJyFqexPx3mtEToOedUWgqpd1m

