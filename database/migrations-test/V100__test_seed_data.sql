-- V18__test_seed_data.sql
BEGIN;

-- =========================================================
-- Address
-- =========================================================
INSERT INTO public.addresses (
    street_address,
    city,
    state,
    postal_code,
    country,
    created_at,
    updated_at
)
VALUES (
    '123 Test Lane',
    'Testville',
    'WA',
    '98926',
    'USA',
    now(),
    now()
)
ON CONFLICT DO NOTHING;


-- =========================================================
-- Destination (property type requires address_id)
-- =========================================================
INSERT INTO public.destinations (
    name,
    type,
    description,
    latitude,
    longitude,
    address_id,
    created_at,
    updated_at
)
SELECT
    'Test Property Destination',
    'property',
    'Integration test destination.',
    47.00000,
    -120.00000,
    a.id,
    now(),
    now()
FROM public.addresses a
WHERE a.street_address = '123 Test Lane'
ON CONFLICT DO NOTHING;


-- =========================================================
-- Property
-- =========================================================
INSERT INTO public.properties (
    name,
    property_type,
    description,
    contact_phone,
    contact_email,
    destination_id,
    created_at,
    updated_at
)
SELECT
    'Test Property',
    'apartment',
    'Property used for integration tests.',
    '5551234567',
    'test@property.com',
    d.id,
    now(),
    now()
FROM public.destinations d
WHERE d.name = 'Test Property Destination'
  AND d.type = 'property'
ON CONFLICT DO NOTHING;


-- =========================================================
-- Property Walk Distance (to itself just for graph completeness)
-- =========================================================
INSERT INTO public.property_walk_distances (
    property_id,
    destination_id,
    walking_miles,
    walking_minutes
)
SELECT
    p.id,
    d.id,
    0.10,
    2
FROM public.properties p
JOIN public.destinations d
  ON d.name = 'Test Property Destination'
WHERE p.name = 'Test Property'
ON CONFLICT DO NOTHING;


-- =========================================================
-- Unit Type
-- =========================================================
INSERT INTO public.unit_types (
    property_id,
    name,
    bedrooms,
    bathrooms,
    rent_cents,
    availability_date,
    total_units,
    available_units,
    description,
    created_at,
    updated_at
)
SELECT
    p.id,
    'Test 1BR',
    1,
    1,
    100000,
    CURRENT_DATE,
    10,
    5,
    'Basic 1 bedroom unit for testing.',
    now(),
    now()
FROM public.properties p
WHERE p.name = 'Test Property'
ON CONFLICT DO NOTHING;


-- =========================================================
-- Lease Agreement
-- =========================================================
INSERT INTO public.lease_agreements (
    property_id,
    lease_type,
    start_month,
    early_termination_fee_cents
)
SELECT
    p.id,
    'fixed',
    'September',
    50000
FROM public.properties p
WHERE p.name = 'Test Property'
ON CONFLICT DO NOTHING;


-- =========================================================
-- Pet Policy
-- =========================================================
INSERT INTO public.pet_policies (
    property_id,
    allowed,
    deposit_cents,
    restrictions
)
SELECT
    p.id,
    TRUE,
    25000,
    'Small pets only for testing.'
FROM public.properties p
WHERE p.name = 'Test Property'
ON CONFLICT DO NOTHING;


-- =========================================================
-- Property Images (thumbnail constraint safe)
-- =========================================================
INSERT INTO public.property_images (
    property_id,
    image_url,
    is_thumbnail
)
SELECT
    p.id,
    'https://example.com/test-thumbnail.jpg',
    TRUE
FROM public.properties p
WHERE p.name = 'Test Property'
ON CONFLICT DO NOTHING;


INSERT INTO public.property_images (
    property_id,
    image_url,
    is_thumbnail
)
SELECT
    p.id,
    'https://example.com/test-image-2.jpg',
    FALSE
FROM public.properties p
WHERE p.name = 'Test Property'
ON CONFLICT DO NOTHING;


COMMIT;