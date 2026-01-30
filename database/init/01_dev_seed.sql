INSERT INTO public.addresses (id, street_address, city, state, postal_code, country, created_at, updated_at)
VALUES (1, '905 Dean Nicholson Blvd Wendell Hill Hall A', 'Ellensburg', 'WA', '98926', 'USA', '2026-01-25 23:03:26.007062', '2026-01-25 23:03:26.007062');

INSERT INTO public.destinations (id, name, type, description, latitude, longitude, address_id, created_at, updated_at)
VALUES (2, 'Wendell Hill Hall A', 'property', 'Wendell Hill Hall A is one of our two Wendell Hill residence halls with a modern set up and feel for our sophomore and up students. Nearby, students can find many outdoor recreation opportunities such as the tennis courts, basketball courts and field house. There is also a full-service coffee shop on the ground floor of Wendell B. Wendell Hill Hall A is home to the Music Living Learning Community, which is open to all music majors regardless of year.', 47.00657, -120.53404, 1, '2026-01-25 23:06:34.72007', '2026-01-25 23:06:34.72007');

INSERT INTO public.properties (id, name, property_type, description, contact_phone, contact_email, destination_id, created_at, updated_at)
VALUES (1, 'Wendell Hill Hall A', 'dorm', 'Wendell Hill Hall A is one of our two Wendell Hill residence halls with a modern set up and feel for our sophomore and up students. Nearby, students can find many outdoor recreation opportunities such as the tennis courts, basketball courts and field house. There is also a full-service coffee shop on the ground floor of Wendell B. Wendell Hill Hall A is home to the Music Living Learning Community, which is open to all music majors regardless of year.', '5099631831', 'housing@cwu.edu', 2, '2026-01-25 23:14:28.66524', '2026-01-25 23:14:28.66524');

INSERT INTO public.unit_types (id, property_id, name, bedrooms, bathrooms, rent_cents, availability_date, total_units, available_units, description, created_at, updated_at)
VALUES (2, 1, 'Double Room', 1, 1, 104833, NULL, NULL, NULL, 'Shared unit with 2 residents and private bathroom.', '2026-01-25 23:22:42.23633', '2026-01-25 23:22:42.23633');

INSERT INTO public.unit_types (id, property_id, name, bedrooms, bathrooms, rent_cents, availability_date, total_units, available_units, description, created_at, updated_at)
VALUES (3, 1, '4-Person Suite', 4, 1, 116666, NULL, NULL, NULL, NULL, '2026-01-25 23:26:02.55533', '2026-01-25 23:26:02.55533');

INSERT INTO public.unit_types (id, property_id, name, bedrooms, bathrooms, rent_cents, availability_date, total_units, available_units, description, created_at, updated_at)
VALUES (4, 1, 'Double Suite', 2, 1, 116666, NULL, NULL, NULL, NULL, '2026-01-25 23:26:02.55533', '2026-01-25 23:26:02.55533');

SELECT pg_catalog.setval('public.addresses_id_seq', 1, true);
SELECT pg_catalog.setval('public.destinations_id_seq', 2, true);
SELECT pg_catalog.setval('public.properties_id_seq', 1, true);
SELECT pg_catalog.setval('public.unit_types_id_seq', 4, true);
