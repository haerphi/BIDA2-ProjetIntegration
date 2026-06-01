-- -------------------------------------------------------------
-- SQL Database Seeding Script for Tennis Club Application
-- Database Engine: PostgreSQL 15+
-- -------------------------------------------------------------

-- Start transaction
BEGIN;

-- Clean existing data (Optional but highly recommended for clean slate)
TRUNCATE TABLE "reservation_players" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "reservation" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "contribution" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "members_groups" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "courts" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "auth_group" RESTART IDENTITY CASCADE;

-- 1. Seed Groups in auth_group
-- ID 1 is for admin role, ID 2 is for member role
INSERT INTO "auth_group" ("id", "name") VALUES
(1, 'admin'),
(2, 'member');

-- 2. Seed Members
-- Passwords are set to (SELECT password FROM "members" WHERE affiliation_number = 'admin') (plain text: 'password')
INSERT INTO "members" (
    "id", "password", "last_login", "is_superuser", "first_name", "last_name",
    "is_staff", "is_active", "date_joined", "email", "affiliation_number",
    "street", "city", "postal_code", "country", "phone", "birth_date",
    "gender", "google_subject_id", "ranking", "created_at"
) VALUES
(
    2,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Jean',
    'Dupont',
    FALSE,
    TRUE,
    NOW() - INTERVAL '25 days',
    'jean.dupont@gmail.com',
    'MEM001',
    '12 Rue de la Paix',
    'Paris',
    '75002',
    'France',
    '+33612345678',
    '1988-06-15',
    'male',
    NULL,
    '15/2',
    NOW() - INTERVAL '25 days'
),
(
    3,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Marie',
    'Dubois',
    FALSE,
    TRUE,
    NOW() - INTERVAL '20 days',
    'marie.dubois@gmail.com',
    'MEM002',
    '45 Avenue des Champs-Élysées',
    'Paris',
    '75008',
    'France',
    '+33687654321',
    '1992-04-20',
    'female',
    NULL,
    '4/6',
    NOW() - INTERVAL '20 days'
),
(
    4,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Pierre',
    'Martin',
    FALSE,
    TRUE,
    NOW() - INTERVAL '15 days',
    'pierre.martin@gmail.com',
    'MEM003',
    '8 Rue du Faubourg Saint-Antoine',
    'Paris',
    '75012',
    'France',
    '+33611223344',
    '1985-11-02',
    'male',
    NULL,
    '30',
    NOW() - INTERVAL '15 days'
),
(
    5,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Sophie',
    'Lefevre',
    FALSE,
    TRUE,
    NOW() - INTERVAL '10 days',
    'sophie.lefevre@gmail.com',
    'MEM004',
    '22 Rue de Rivoli',
    'Paris',
    '75004',
    'France',
    '+33655667788',
    '1995-09-30',
    'female',
    NULL,
    '15/4',
    NOW() - INTERVAL '10 days'
),
(
    6,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Thomas',
    'Bernard',
    FALSE,
    FALSE, -- Inactive member
    NOW() - INTERVAL '5 days',
    'thomas.bernard@gmail.com',
    'MEM005',
    '14 Boulevard Saint-Germain',
    'Paris',
    '75005',
    'France',
    '+33699887766',
    '1990-01-25',
    'male',
    NULL,
    '30/1',
    NOW() - INTERVAL '5 days'
),
(
    7,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Lucas',
    'Legrand',
    FALSE,
    TRUE,
    NOW() - INTERVAL '4 days',
    'lucas.legrand@gmail.com',
    'MEM006',
    '50 Rue de Rennes',
    'Paris',
    '75006',
    'France',
    '+33622334455',
    '1991-03-12',
    'male',
    NULL,
    '15/1',
    NOW() - INTERVAL '4 days'
),
(
    8,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Emma',
    'Petit',
    FALSE,
    TRUE,
    NOW() - INTERVAL '4 days',
    'emma.petit@gmail.com',
    'MEM007',
    '3 Boulevard Haussmann',
    'Paris',
    '75009',
    'France',
    '+33633445566',
    '1994-07-22',
    'female',
    NULL,
    '30/2',
    NOW() - INTERVAL '4 days'
),
(
    9,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Hugo',
    'Roux',
    FALSE,
    TRUE,
    NOW() - INTERVAL '3 days',
    'hugo.roux@gmail.com',
    'MEM008',
    '18 Avenue d''Italie',
    'Paris',
    '75013',
    'France',
    '+33644556677',
    '1989-10-05',
    'male',
    NULL,
    '15/5',
    NOW() - INTERVAL '3 days'
),
(
    10,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Chloe',
    'Barbier',
    FALSE,
    TRUE,
    NOW() - INTERVAL '3 days',
    'chloe.barbier@gmail.com',
    'MEM009',
    '72 Avenue de la Grande Armée',
    'Paris',
    '75017',
    'France',
    '+33655667788',
    '1993-12-14',
    'female',
    NULL,
    'NC',
    NOW() - INTERVAL '3 days'
),
(
    11,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Nathan',
    'Morel',
    FALSE,
    TRUE,
    NOW() - INTERVAL '2 days',
    'nathan.morel@gmail.com',
    'MEM010',
    '95 Rue Lafayette',
    'Paris',
    '75010',
    'France',
    '+33666778899',
    '1996-02-28',
    'male',
    NULL,
    '30/3',
    NOW() - INTERVAL '2 days'
),
(
    12,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Zoe',
    'Gerard',
    FALSE,
    TRUE,
    NOW() - INTERVAL '2 days',
    'zoe.gerard@gmail.com',
    'MEM011',
    '142 Avenue Daumesnil',
    'Paris',
    '75012',
    'France',
    '+33677889900',
    '1997-08-19',
    'female',
    NULL,
    '15/3',
    NOW() - INTERVAL '2 days'
),
(
    13,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Enzo',
    'Guerin',
    FALSE,
    TRUE,
    NOW() - INTERVAL '1 day',
    'enzo.guerin@gmail.com',
    'MEM012',
    '88 Rue de Belleville',
    'Paris',
    '75020',
    'France',
    '+33688990011',
    '1990-05-30',
    'male',
    NULL,
    '30/4',
    NOW() - INTERVAL '1 day'
),
(
    14,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Leia',
    'Muller',
    FALSE,
    TRUE,
    NOW() - INTERVAL '1 day',
    'leia.muller@gmail.com',
    'MEM013',
    '31 Rue de la Clef',
    'Paris',
    '75005',
    'France',
    '+33699001122',
    '1995-11-11',
    'female',
    NULL,
    '30',
    NOW() - INTERVAL '1 day'
),
(
    15,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Leo',
    'Lemoine',
    FALSE,
    TRUE,
    NOW() - INTERVAL '12 hours',
    'leo.lemoine@gmail.com',
    'MEM014',
    '64 Rue Saint-Charles',
    'Paris',
    '75015',
    'France',
    '+33600112233',
    '1992-09-08',
    'male',
    NULL,
    '15/4',
    NOW() - INTERVAL '12 hours'
),
(
    16,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Lina',
    'Rousseau',
    FALSE,
    TRUE,
    NOW() - INTERVAL '6 hours',
    'lina.rousseau@gmail.com',
    'MEM015',
    '112 Avenue de Flandre',
    'Paris',
    '75019',
    'France',
    '+33611223344',
    '1998-04-03',
    'female',
    NULL,
    '30/1',
    NOW() - INTERVAL '6 hours'
);

-- 3. Seed Group Mappings (members_groups)
INSERT INTO "members_groups" ("member_id", "group_id") VALUES
(1, 1), -- Admin in Admin group
(2, 2), -- Jean in Member group
(3, 2), -- Marie in Member group
(4, 2), -- Pierre in Member group
(5, 2), -- Sophie in Member group
(6, 2), -- Thomas in Member group
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2);

-- 4. Seed Courts
INSERT INTO "courts" ("id", "name", "is_active") VALUES
(1, 'Court Central', TRUE),
(2, 'Court N°2', TRUE),
(3, 'Court N°3', TRUE),
(4, 'Court N°4 (Indoor)', TRUE),
(5, 'Court N°5 (Clay)', TRUE),
(6, 'Court N°6 (Maintenance)', FALSE);

-- 5. Seed Contributions
-- Completed contributions for paid active members (Jean, Marie, Pierre)
-- One pending contribution for Sophie, and none for Thomas (inactive)
INSERT INTO "contribution" ("id", "amount", "stripe_session_id", "status", "created_at", "updated_at", "member_id") VALUES
(1, 200.00, 'cs_test_a1b2c3d4e5_01', 'completed', NOW() - INTERVAL '20 days', NOW() - INTERVAL '20 days', 2),
(2, 200.00, 'cs_test_a1b2c3d4e5_02', 'completed', NOW() - INTERVAL '15 days', NOW() - INTERVAL '15 days', 3),
(3, 200.00, 'cs_test_a1b2c3d4e5_03', 'completed', NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days', 4),
(4, 200.00, 'cs_test_a1b2c3d4e5_04', 'pending',   NOW() - INTERVAL '2 days',  NOW() - INTERVAL '2 days',  5),
(5, 200.00, 'cs_test_a1b2c3d4e5_05', 'completed', NOW() - INTERVAL '4 days',  NOW() - INTERVAL '4 days',  7),
(6, 200.00, 'cs_test_a1b2c3d4e5_06', 'completed', NOW() - INTERVAL '4 days',  NOW() - INTERVAL '4 days',  8),
(7, 200.00, 'cs_test_a1b2c3d4e5_07', 'completed', NOW() - INTERVAL '3 days',  NOW() - INTERVAL '3 days',  9),
(8, 200.00, 'cs_test_a1b2c3d4e5_08', 'completed', NOW() - INTERVAL '3 days',  NOW() - INTERVAL '3 days',  10),
(9, 200.00, 'cs_test_a1b2c3d4e5_09', 'completed', NOW() - INTERVAL '2 days',  NOW() - INTERVAL '2 days',  11),
(10, 200.00, 'cs_test_a1b2c3d4e5_10', 'completed', NOW() - INTERVAL '2 days',  NOW() - INTERVAL '2 days',  12),
(11, 200.00, 'cs_test_a1b2c3d4e5_11', 'completed', NOW() - INTERVAL '1 day',   NOW() - INTERVAL '1 day',   13),
(12, 200.00, 'cs_test_a1b2c3d4e5_12', 'completed', NOW() - INTERVAL '1 day',   NOW() - INTERVAL '1 day',   14),
(13, 200.00, 'cs_test_a1b2c3d4e5_13', 'completed', NOW() - INTERVAL '12 hours', NOW() - INTERVAL '12 hours', 15),
(14, 200.00, 'cs_test_a1b2c3d4e5_14', 'completed', NOW() - INTERVAL '6 hours',  NOW() - INTERVAL '6 hours',  16);

-- 6. Seed Reservations
-- Reservation 1: Simple reservation between Jean and Marie (on Court Central today)
-- We'll use absolute timestamps for today (or dynamically generated today/tomorrow)
INSERT INTO "reservation" ("id", "date_time", "duration", "court_id", "creator_id", "type") VALUES
(1, CURRENT_DATE + TIME '09:00:00', 60, 1, 2, 'simple'),
(2, CURRENT_DATE + TIME '14:00:00', 120, 2, 3, 'double'),
(3, CURRENT_DATE + TIME '10:00:00', 180, 3, 1, 'blocage_admin'),
(4, (CURRENT_DATE + INTERVAL '1 day') + TIME '16:00:00', 60, 4, 2, 'simple');

-- 7. Seed Reservation Players (Many-to-Many mapping)
-- For Simple reservation: Both creator and partner are players
-- For Double reservation: All four players are registered
-- For Admin Blockage: Just the admin creator is registered
INSERT INTO "reservation_players" ("reservation_id", "member_id") VALUES
(1, 2), -- Jean
(1, 3), -- Marie

(2, 2), -- Jean
(2, 3), -- Marie
(2, 4), -- Pierre
(2, 5), -- Sophie

(3, 1), -- Admin

(4, 2), -- Jean
(4, 4); -- Pierre

-- 8. Reset Auto-Increment Sequences
-- This prevents unique constraint violations when Django creates new records
SELECT setval(pg_get_serial_sequence('auth_group', 'id'), COALESCE((SELECT max(id) FROM auth_group), 1));
SELECT setval(pg_get_serial_sequence('members', 'id'), COALESCE((SELECT max(id) FROM members), 1));
SELECT setval(pg_get_serial_sequence('members_groups', 'id'), COALESCE((SELECT max(id) FROM members_groups), 1));
SELECT setval(pg_get_serial_sequence('courts', 'id'), COALESCE((SELECT max(id) FROM courts), 1));
SELECT setval(pg_get_serial_sequence('contribution', 'id'), COALESCE((SELECT max(id) FROM contribution), 1));
SELECT setval(pg_get_serial_sequence('reservation', 'id'), COALESCE((SELECT max(id) FROM reservation), 1));
SELECT setval(pg_get_serial_sequence('reservation_players', 'id'), COALESCE((SELECT max(id) FROM reservation_players), 1));

-- End transaction
COMMIT;
