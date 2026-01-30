BEGIN;

-- Addresses
INSERT INTO public.addresses (
  street_address, city, state, postal_code, country, created_at, updated_at
)
VALUES
  (
    '905 Dean Nicholson Blvd Wendell Hill Hall A',
    'Ellensburg', 'WA', '98926', 'USA',
    now(), now()
  ),
  (
    '810 E University Way',
    'Ellensburg', 'WA', '98926', 'USA',
    now(), now()
  )
ON CONFLICT DO NOTHING;


-- Destinations
INSERT INTO public.destinations (
  name, type, description, latitude, longitude, address_id, created_at, updated_at
)
SELECT
  'Wendell Hill Hall A',
  'property',
  'Wendell Hill Hall A is one of our two Wendell Hill residence halls with a modern set up and feel for our sophomore and up students. Nearby, students can find many outdoor recreation opportunities such as the tennis courts, basketball courts and field house. There is also a full-service coffee shop on the ground floor of Wendell B. Wendell Hill Hall A is home to the Music Living Learning Community, which is open to all music majors regardless of year.',
  47.00657,
  -120.53404,
  a.id,
  now(),
  now()
FROM public.addresses a
WHERE a.street_address = '905 Dean Nicholson Blvd Wendell Hill Hall A'
ON CONFLICT DO NOTHING;


INSERT INTO public.destinations (
  name, type, description, latitude, longitude, address_id, created_at, updated_at
)
SELECT
  'University & 9th',
  'bus_stop',
  'Bus stop at University and 9th',
  47.00067,
  -120.53588,
  a.id,
  now(),
  now()
FROM public.addresses a
WHERE a.street_address = '810 E University Way'
ON CONFLICT DO NOTHING;


-- Properties
INSERT INTO public.properties (
  name, property_type, description,
  contact_phone, contact_email,
  destination_id, created_at, updated_at
)
SELECT
  'Wendell Hill Hall A',
  'dorm',
  'Wendell Hill Hall A is one of our two Wendell Hill residence halls with a modern set up and feel for our sophomore and up students. Nearby, students can find many outdoor recreation opportunities such as the tennis courts, basketball courts and field house. There is also a full-service coffee shop on the ground floor of Wendell B. Wendell Hill Hall A is home to the Music Living Learning Community, which is open to all music majors regardless of year.',
  '5099631831',
  'housing@cwu.edu',
  d.id,
  now(),
  now()
FROM public.destinations d
WHERE d.name = 'Wendell Hill Hall A'
  AND d.type = 'property'
ON CONFLICT DO NOTHING;


-- Property walk distances
INSERT INTO public.property_walk_distances (
  property_id, destination_id, walking_miles, walking_minutes
)
SELECT
  p.id,
  d.id,
  0.50,
  11
FROM public.properties p
JOIN public.destinations d
  ON d.name = 'University & 9th'
WHERE p.name = 'Wendell Hill Hall A'
ON CONFLICT DO NOTHING;


-- Unit types
INSERT INTO public.unit_types (
  property_id, name, bedrooms, bathrooms,
  rent_cents, availability_date,
  total_units, available_units,
  description, created_at, updated_at
)
SELECT
  p.id,
  'Double Room',
  1,
  1,
  104833,
  NULL,
  NULL,
  NULL,
  'Shared unit with 2 residents and private bathroom.',
  now(),
  now()
FROM public.properties p
WHERE p.name = 'Wendell Hill Hall A'
ON CONFLICT DO NOTHING;


INSERT INTO public.unit_types (
  property_id, name, bedrooms, bathrooms,
  rent_cents, availability_date,
  total_units, available_units,
  description, created_at, updated_at
)
SELECT
  p.id,
  '4-Person Suite',
  4,
  1,
  116666,
  NULL,
  NULL,
  NULL,
  NULL,
  now(),
  now()
FROM public.properties p
WHERE p.name = 'Wendell Hill Hall A'
ON CONFLICT DO NOTHING;


INSERT INTO public.unit_types (
  property_id, name, bedrooms, bathrooms,
  rent_cents, availability_date,
  total_units, available_units,
  description, created_at, updated_at
)
SELECT
  p.id,
  'Double Suite',
  2,
  1,
  116666,
  NULL,
  NULL,
  NULL,
  NULL,
  now(),
  now()
FROM public.properties p
WHERE p.name = 'Wendell Hill Hall A'
ON CONFLICT DO NOTHING;

COMMIT;
